Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B63CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CqS-0007KU-0w; Fri, 10 Oct 2025 09:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CqL-0007GQ-Ep
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:34 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpN-0003z9-2A
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:33 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so1237833f8f.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101587; x=1760706387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lr17S6XUbTHxBwNSfaoJpVMYZRclxo3pq1TReeAr7Dw=;
 b=mbymxy6N6Kncgcg2vnJLJtcA9cm0oqHclx6IZc+jfiRZ3ClDjdsemlmQOQCmBw2OHM
 Ajnu67pknNs7lBp7L+ygxrQGp6WVutL4Bv80C/Zg3nJKosPPIYm6pgf2quNUM2HCrO9K
 D2OdiY06d2v0M7HeQIIZQVex60W7CBlLLOXXJm/1jR3toVzA5pTOZBGUJOamnjKEFJd8
 0/Ai6ZLk559g4KnOpEpxRzp0ZS3TcngP8HAgom59ZM3Q5M3sVgh1mXFcC5O/kbN/szUt
 UHKsBLTlv9xDX4glhuGLF8hrDrs2VSWUaOSjo43cZnYNXG+gdhLWDLlnBm2RDDI+Pw8N
 eSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101587; x=1760706387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lr17S6XUbTHxBwNSfaoJpVMYZRclxo3pq1TReeAr7Dw=;
 b=gXAa+y+R5+wXpCYccehKfbCzFNBZsZYlioylCDMss/Lzde19BuxvyWZw3a4Pf/verk
 zIwoun4a0b+7mhIXP0MOBbiDLRjbdpLk/P/ZAUOL1mU460Qnq4z2M46eQv4j9xvid1KK
 bvPyfquxmh4yM6wbtgpxH/cJdUNlfXZ2VhMVSJdfvg8g6O9xmTYX7tNZhpo3rTK0S3o3
 xxa2u3kzWjIVlwDIw8FuOY0VFzGKCri/Co+AlQR9K/U3lwBECDXtsPRyYHPQch77CsxN
 aE7ezSJ3+ymzp7NIOymFmfwo9pBgKFwNqkCfVAFbJu9IAFrvQG1iJeFuk0jflbq3dotQ
 BP4g==
X-Gm-Message-State: AOJu0YxbXg0D+vOEoHq4g4FLYm2GspefhPhK1ximPGwAJRDn6xsZvHW5
 12FqMQuD1wVr9cuoDAQtNozVqQH1/IG0B6zkfE0ntXWPEQW+fVpYB3suujYht4VtXLRTgQOYi/U
 C6zeH
X-Gm-Gg: ASbGncupd4be6V3YSza7jA2uAH6oGGUbx8rwiSOp+jy4fMnCEIiARtkOoJpZzw022r/
 uBuVp9dT5uB7U6WQm5P7y0yXOfhW9V5sVz5vkIe8WD4rdJ8EzS04MBwcVNKZI9wnXbyskiAj5zs
 2oK3ogS3FRdYIp/d5DZ+/gCd+NMH7xBLrT5vhxYyLmth83XTVMRSLXgP1VmrrFZH8kXu2FZjrSE
 7Ui1HkXzS49/iA7fbQ8td655GKZeW6qvyHlLPkLJejMIafmvlJL7JQMixINzaerSJ8bMRks2/5s
 +goYF4ppLgnIoB7QvG2OpPg7KDWjLXmXQxTSH1T7NUJkCy2IJ7u3qFy9C6A+LMPbSho5cXEelw0
 hmuNDt/6C1TzFVaCFPicNipJmvmlBRacfNL0m4/fPVDgWbldGEcM=
X-Google-Smtp-Source: AGHT+IFEvuYrEykNXhN9ZQkbnwPKVPLL8YA4Cxfx+dxbftSRIBoL8YasVZF7RIPDJOwA1PIyMW9efA==
X-Received: by 2002:a05:6000:430b:b0:3ed:e1d8:bd72 with SMTP id
 ffacd0b85a97d-42666da6dc9mr7326847f8f.17.1760101587521; 
 Fri, 10 Oct 2025 06:06:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 51/76] target/arm: Implement GCSPOPX
Date: Fri, 10 Oct 2025 14:05:02 +0100
Message-ID: <20251010130527.3921602-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-52-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h            |  1 +
 target/arm/cpregs-gcs.c        |  3 +++
 target/arm/tcg/translate-a64.c | 35 ++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 909916b7fd7..ccf45fd136d 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -51,6 +51,7 @@ enum {
     ARM_CP_GCSPUSHM              = 0x0008,
     ARM_CP_GCSPOPM               = 0x0009,
     ARM_CP_GCSPUSHX              = 0x000a,
+    ARM_CP_GCSPOPX               = 0x000b,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index e6c7025d02a..5b5b895a091 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -120,6 +120,9 @@ static const ARMCPRegInfo gcs_reginfo[] = {
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 4,
       .access = PL1_W, .accessfn = access_gcspushx, .fgt = FGT_NGCSEPP,
       .type = ARM_CP_GCSPUSHX },
+    { .name = "GCSPOPX", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 6,
+      .access = PL1_W, .type = ARM_CP_GCSPOPX },
 };
 
 void define_gcs_cpregs(ARMCPU *cpu)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0df1916d28a..72b912a6050 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2568,6 +2568,33 @@ static void gen_gcspushx(DisasContext *s)
     clear_pstate_bits(PSTATE_EXLOCK);
 }
 
+static void gen_gcspopx(DisasContext *s)
+{
+    TCGv_i64 gcspr = cpu_gcspr[s->current_el];
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 tmp = tcg_temp_new_i64();
+    TCGLabel *fail_label =
+        delay_exception(s, EXCP_UDEF, syn_gcs_data_check(GCS_IT_GCSPOPX, 31));
+
+    /* The value at top-of-stack must be an exception token. */
+    tcg_gen_qemu_ld_i64(tmp, gcspr, mmuidx, mop);
+    tcg_gen_brcondi_i64(TCG_COND_NE, tmp, 0b1001, fail_label);
+
+    /*
+     * The other three values in the exception return record
+     * are ignored, but are loaded anyway to raise faults.
+     */
+    tcg_gen_addi_i64(addr, gcspr, 8);
+    tcg_gen_qemu_ld_i64(tmp, addr, mmuidx, mop);
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_qemu_ld_i64(tmp, addr, mmuidx, mop);
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_qemu_ld_i64(tmp, addr, mmuidx, mop);
+    tcg_gen_addi_i64(gcspr, addr, 8);
+}
+
 /*
  * Look up @key, returning the cpreg, which must exist.
  * Additionally, the new cpreg must also be accessible.
@@ -2893,6 +2920,14 @@ static void handle_sys(DisasContext *s, bool isread,
             gen_gcspushx(s);
         }
         return;
+    case ARM_CP_GCSPOPX:
+        /* Choose the CONSTRAINED UNPREDICTABLE for UNDEF. */
+        if (rt != 31) {
+            unallocated_encoding(s);
+        } else if (s->gcs_en) {
+            gen_gcspopx(s);
+        }
+        return;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


