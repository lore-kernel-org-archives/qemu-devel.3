Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAC6CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY42-00005F-6T; Tue, 13 Oct 2026 04:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3b-0007UY-B6
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:23 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3W-0007uD-ME
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:23 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a020e65269so16617055e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880817; x=1792485617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Hrch6mWn18Vsni9ZYGMXpYD4co+MVRjdvkjQZHLk8Lc=;
 b=d2e+aPxgNxvYeNKooL417/DX2KuMKT2T7P3JQlVVciYfYTaxk4EncoJ+U4mr1qyHIo
 0yGYkkCG6FLsiOdWTblj6bryp6lc4qCJJI7D21Z0AOp+jngDMaPqKo7FlFfiuhbb541f
 ymLPS41mwGHXsWXdtOfZ9qJsFYz782Dj9LtUaihWb9u7jdZZC4Xjukl9hrBOpjsqPtzC
 bosW3k7okVAIpYC8qP0pyuvs67ZqZuX2IjIR4rZ+qcUz9qr/lP9aUYpoxeTzgEoOarq2
 JCZft58VeVCS6DsNvyk5//AImbfdLguvrm1whNeLmzI5UjraTJE41oedG7gETp36ucI7
 Nxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880817; x=1792485617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Hrch6mWn18Vsni9ZYGMXpYD4co+MVRjdvkjQZHLk8Lc=;
 b=lGOMGUGZaE2lCNqEKtR4i4AH4+p1yiaCgvXvTRmLD/zJ9N2wlQHLdtWhjcANjfu1Bg
 dwuMPq/Gif7+mfXcL1gZESkmhwY9CKlKE7HzR2Y3pYugKCNxBarOW1KYcMkw41S2qFsy
 pfNzxLaoO6h3oLVTC7/in4PPcN3g3uzXB+wX9R+SqrWbyV4AMtFGlVnlsCqTpQZ4aKXZ
 gVVqCA8CPH/+WUpPYFxqzZroHQuFAJ7DyPNTnGM+0P5KI7LsyLDY0IPYC45HtdbX70oq
 zzFxBjr6PczxtFP2VvNgTrDfbiDte5XZCrmPiDLLn/bRVXaMA7G6xl4XpPtYZj6UBbCO
 QuIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBykjedBehn/lRR5zJb7+tDnZbZO32QYikr9BJX2wGXSEuviRVglsR+yGwuLyFcaR7lJoefnlqiHpi61@nongnu.org
X-Gm-Message-State: AFq9FYJpF/rp9+dNKJNitlgYDv8HHJPwYrhLiVRmHby4+9edOeEsAMch
 X4ms6NCCPgVyz+ncFpByAiawr5VidzTGfgcuFtI6MuHEz2wRrbvU2DhapKQe7tc4+l5u7VQQ+yS
 330ilOv4=
X-Gm-Gg: AYBFou1larMkWxhveS8yOBOr38xF+FNSzwpMbAj0SztyQnZ+GmXVzmvWROa6jw6C+s4
 Xh6fhr0FZOfn4CwFbWuMbwm3hSXCPWi2YfkDf1YdyCfYHxhHdVZS10/Tvt3ezL5sfvPDVaqXqTG
 KAEC6m/ebXbbPNhKn9cNcTW9GDMyE2vbQnU7F5nhrJFhSNlC4UOTDOUbXuDWuOhTT2K5/TC7ERZ
 3BPX6MFrFoAbpUdj+H+Kh4sUMoAcsoi/XLGO7ru3GzPEEUr3AWnb9Lb6MvOLAA0A9b+nCOhvXTi
 oKFDSb8yB384kBtOv3rkI3BinKIvUxhLMuVTNRAztqI3gh23Ew2j2xsQKkC1MI9+ZSXJeocoZql
 MOhVN09D+kgaYF7h/JvVuA4KZzXuLgs6Q3Vk8cXE0C1cxsaCbxEQXaXyyCBfTm1zEYVosJqqIff
 hYJ33oFAs9wiZrfvDV9WUohwUBNxZrLfgBbsSx/Qd5Wpk6kBRf0YPnYT1EnTR+3J/eGuOnCgH7i
 B7nLcSuLg9j0a36XH8FtQsu0T5DqoxX9mMi9orjixeH9tsoqp6TpNBQaP09Mqu5o4lONe6h3Pau
 BF8=
X-Received: by 2002:a05:600c:6388:b0:4a1:ac66:5ffe with SMTP id
 5b1f17b1804b1-4a1ac666396mr23901165e9.15.1791880816785; 
 Tue, 13 Oct 2026 01:40:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 30/86] target/arm: GICv5 cpuif: Implement
 ICV_PPI_CPENDR<n>_EL1, ICV_PPI_SPENDR<n>_EL1
Date: Tue, 13 Oct 2026 09:38:37 +0100
Message-ID: <20261013083933.1024405-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement the redirection of ICC_PPI_CPENDR<n>_EL1 and
ICC_PPI_SPENDoR<n>_EL1 to the virtual ICV_ versions of these
registers.  The underlying state here is held in
ICH_PPI_PENDR<n>_EL2, but the inner-guest facing view has set/clear
semantics.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 40 ++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 876f5813d5a..96384c58726 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -480,26 +480,50 @@ static void gic_ppi_sactive_write(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+static uint64_t gic_ppi_pend_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    if (gicv5_icv_access(env)) {
+        uint64_t value = env->gicv5_cpuif.ich_ppi_pend[ri->opc2 & 1];
+
+        value &= ~env->gicv5_cpuif.ich_ppi_hvi[ri->opc2 & 1];
+        return value;
+    } else {
+        return raw_read(env, ri);
+    }
+}
+
 static void gic_ppi_cpend_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                 uint64_t value)
 {
-    uint64_t old = raw_read(env, ri);
     /* If ICC_PPI_HMR_EL1[n].HM is 1, PEND bits are RO */
     uint64_t hm = env->gicv5_cpuif.ppi_hm[ri->opc2 & 1];
     value &= ~hm;
-    raw_write(env, ri, old & ~value);
-    gic_recalc_ppi_hppi(env);
+
+    if (gicv5_icv_access(env)) {
+        value &= ~env->gicv5_cpuif.ich_ppi_hvi[ri->opc2 & 1];
+        env->gicv5_cpuif.ich_ppi_pend[ri->opc2 & 1] &= ~value;
+    } else {
+        uint64_t old = raw_read(env, ri);
+        raw_write(env, ri, old & ~value);
+        gic_recalc_ppi_hppi(env);
+    }
 }
 
 static void gic_ppi_spend_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                 uint64_t value)
 {
-    uint64_t old = raw_read(env, ri);
     /* If ICC_PPI_HMR_EL1[n].HM is 1, PEND bits are RO */
     uint64_t hm = env->gicv5_cpuif.ppi_hm[ri->opc2 & 1];
     value &= ~hm;
-    raw_write(env, ri, old | value);
-    gic_recalc_ppi_hppi(env);
+
+    if (gicv5_icv_access(env)) {
+        value &= ~env->gicv5_cpuif.ich_ppi_hvi[ri->opc2 & 1];
+        env->gicv5_cpuif.ich_ppi_pend[ri->opc2 & 1] |= value;
+    } else {
+        uint64_t old = raw_read(env, ri);
+        raw_write(env, ri, old | value);
+        gic_recalc_ppi_hppi(env);
+    }
 }
 
 static uint64_t gic_ppi_enable_read(CPUARMState *env, const ARMCPRegInfo *ri)
@@ -1134,6 +1158,7 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .access = PL1_RW, .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
         .fgt = FGT_ICC_PPI_PENDRN_EL1,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[0]),
+        .readfn = gic_ppi_pend_read,
         .writefn = gic_ppi_cpend_write,
     },
     {   .name = "ICC_PPI_CPENDR1_EL1", .state = ARM_CP_STATE_AA64,
@@ -1141,6 +1166,7 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .access = PL1_RW, .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
         .fgt = FGT_ICC_PPI_PENDRN_EL1,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[1]),
+        .readfn = gic_ppi_pend_read,
         .writefn = gic_ppi_cpend_write,
     },
     {   .name = "ICC_PPI_SPENDR0_EL1", .state = ARM_CP_STATE_AA64,
@@ -1148,6 +1174,7 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
         .fgt = FGT_ICC_PPI_PENDRN_EL1,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[0]),
+        .readfn = gic_ppi_pend_read,
         .writefn = gic_ppi_spend_write,
     },
     {   .name = "ICC_PPI_SPENDR0_EL1", .state = ARM_CP_STATE_AA64,
@@ -1155,6 +1182,7 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
         .fgt = FGT_ICC_PPI_PENDRN_EL1,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[1]),
+        .readfn = gic_ppi_pend_read,
         .writefn = gic_ppi_spend_write,
     },
     {   .name = "ICC_APR_EL1", .state = ARM_CP_STATE_AA64,
-- 
2.43.0


