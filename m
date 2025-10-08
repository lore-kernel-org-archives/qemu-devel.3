Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18F5CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 21:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cBN-0005PK-SV; Wed, 08 Oct 2025 17:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cAK-0004Ny-7T
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:47 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9F-0006jA-Mx
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:43 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-267facf9b58so1971695ad.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960594; x=1760565394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnGv3gaWQ9shrmt0WGxn8YCEO4EdUIFI2jl/MhJPR7Y=;
 b=o/CmAFUN8MeGqx0O8dMCpGZaZuIcjQxXnm98JvbqhYwtRZqHPZVrdi6bvhDv3TDNgY
 vc+3vUfiAghT2eBKr5tkZGAo+y+Y4+SD5SjwpbLBaYWv3e5qQ20WHKzsjH0AmXf/8DkN
 tTSjjTq5zkW5eRYJeotptRFkL19ddDNRAJeXE/xyMJPs9CBTLYCTHKAmyA6knx3NTjrr
 REFEaiuxKE4bjlQ1GqRlnwGEDnKiy+msNRN32WDNM9iON43WZOFp9J6K2DYpPYjuNstD
 QfDSOceyMZsHeS5uJXRllkLe4+DZplMhjJtv77VnM0eM4YIhDldHBDy9A9BCHkfcI6kb
 IzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960594; x=1760565394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZnGv3gaWQ9shrmt0WGxn8YCEO4EdUIFI2jl/MhJPR7Y=;
 b=c3uHglNS76W3xXqD3u+qEPPfh5R6s+0UEMPm80CWbInGp60rrudHOw3GPq3QNEV6wg
 +kAMPqlUwTAXbZWcABt9R3tyyZuDqBbXMH1xRRz33cIG7vbSPyKtLeX0usxZk9GYcYgw
 KtpNfGlZziCDnYWEFkgFYNXhVIa5rznSsv7WSv0GSHBBAnikL8ZUHiK8QZXY8FVMgf8q
 RpgenoNaKJhOvzGDne+9+VD3TCt7UXKYoHKKl1R0rDMChIguQzo6R4F2VwJ7wj21ehPY
 gwLij6qnCLi0BsOJ5d+FCkb96FxmhNh6dMVHHhyXIx84f7M0yCxxRRTcwpp+tb7nRi12
 6u8w==
X-Gm-Message-State: AOJu0YyKB4n/2I4ObXnqnLNejZTznWmDg9++blh7uAamoxis1g3BbBxp
 adch+PylAg1JDSacTkAObJazqYiihX6G1pricaOMdeQ3q+sac2f5NVWS0UR5riqrv7OGR5LMAVu
 s6zQnHTI=
X-Gm-Gg: ASbGncv6+XM1qLUmk72lfUT+A+G0EAuZ46cr6q7vjv+8k1cDKisow/f2RlnGRy2fIDO
 dfpr89wNTHYWkZntxvbELo3yBhiXJqcFdORiKI/UqnNi/gezHvB1lmtrFahe4oPKeAlqONcF+7L
 pD7E6TK2yiR9yH+6Dg5Up6bviglesgTwP4KuSqyZh657IJZuuOtZ05NoDisccU8+fHqMym7Qq+H
 +bTVRUFhVyD3Xz9wmxaXjjhcGvocVXbuQaKVEN7c7iWuVRRBezDVGsn1gJdvS3fgmROKaM1X/s9
 4lGeYyr2SKIJXCdDS/PzA2D4GCoqr4M/0Kd1lRmGuCrtnc7ANMfwIPJtJzsux8dLzpJQDZdf/mY
 jfBZRRCWz34056E/TXzzdy74C648BinWtkHls7lmnG/OTwqkiXGwfu4EQ
X-Google-Smtp-Source: AGHT+IHP3Ive7fT9YEbBxf245MDA3oCmfLvTSRKp2QFEH9kf6EjvBjp1nRmjIJIVppAmjKKi2auDnQ==
X-Received: by 2002:a17:903:2f10:b0:275:27ab:f6c8 with SMTP id
 d9443c01a7336-29027379486mr63974845ad.20.1759960594011; 
 Wed, 08 Oct 2025 14:56:34 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 30/73] target/arm: Implement gcs bit for data abort
Date: Wed,  8 Oct 2025 14:55:30 -0700
Message-ID: <20251008215613.300150-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/tlb_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index ae2acd6727..f1983a5732 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -28,7 +28,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
                                             ARMMMUFaultInfo *fi,
                                             unsigned int target_el,
                                             bool same_el, bool is_write,
-                                            int fsc)
+                                            int fsc, bool gcs)
 {
     uint64_t syn;
 
@@ -78,6 +78,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
 
     /* Form ISS2 at the top of the syndrome. */
     syn |= (uint64_t)fi->dirtybit << 37;
+    syn |= (uint64_t)gcs << 40;
 
     return syn;
 }
@@ -252,9 +253,10 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
         syn = syn_insn_abort(same_el, fi->ea, fi->s1ptw, fsc);
         exc = EXCP_PREFETCH_ABORT;
     } else {
+        bool gcs = regime_is_gcs(core_to_arm_mmu_idx(env, mmu_idx));
         syn = merge_syn_data_abort(env->exception.syndrome, fi, target_el,
                                    same_el, access_type == MMU_DATA_STORE,
-                                   fsc);
+                                   fsc, gcs);
         if (access_type == MMU_DATA_STORE
             && arm_feature(env, ARM_FEATURE_V6)) {
             fsr |= (1 << 11);
-- 
2.43.0


