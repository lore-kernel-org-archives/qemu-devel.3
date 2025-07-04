Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFF9C83F0B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhUm-0005Dq-AG; Fri, 04 Jul 2025 10:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPb-0003ZF-62
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:29:13 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPU-0001t9-Ik
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:29:10 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2ea58f008e9so1155713fac.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639341; x=1752244141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YKpZ3Wi3kiPeGsW/028ukyK/ultYPAj8ufnMNu1KCsg=;
 b=rLDPJN8638ML7h49SuHnKQXQmIvAM3QZ8iV8eaQ4SD4uNFKv8Ci1UR7oMLFjCDafBl
 qt5WHa4kmOv7mFtTpx40iyzA1tDQQANc7rXdKGvRgrnLU4xgaOQozv1AOxx6znXk6ZQ7
 WgfxBLODytuAIszHkTPX8gyz4ullu96Jl43vju1veAlqzPep4B+NZjl9IQvdHPMG1Xnz
 GiHOqKgyHbz1OpGbpcncjWM5gmRpwoF2WKThkePBIwYsLl+zw0HSQ5X2AzFUetlMuE1P
 FhcsPfsLQ2glVulLn8c0EcNpoKs5gGBNgehChQm2oMgDZoY9dO8MHoRuxR6bMUuVtuva
 LpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639341; x=1752244141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YKpZ3Wi3kiPeGsW/028ukyK/ultYPAj8ufnMNu1KCsg=;
 b=JNLQXY50WG2Qne8OLUgbLG24bMqJx8qKgvHVhCcCcK4gPDFnE2KzxV2PGCbcnoDwns
 L0tuHe4VmWkslEZeZNYWCmDJ0S3IaFIXX7Nx41XsBFxbJKHTEgaqHwuqY02VMbfB2luC
 lXKOv7xIsNEAoNBzdrSF5WxwfK5Qkynph2uT14508a6r84le/595jkOROvtJ0FvIKLha
 x0pfFrL0C+C6DNzUBJiVtCbJuhGkqZrgceDdgaKdQ1MFyAwOjlaiEr3tn5NwcRNwK5p8
 kBQ7Rsd4b1mmCMx7RLY7zo+aF3C6qXPuvL9L0b1X21CiZkdnzxlf67wU25bev9OmGxpX
 LIAA==
X-Gm-Message-State: AOJu0YyIaRk8TIfEzcqlwbh2tbW0x+wp3GTy6Ty0qTO02f+myj0Fm4UP
 pQsaOCyxRXqVdMxysCVslAEGDe8tebrl1nDtBoqGlCb5BXvtrm/XGgGiUx1x9cawNKiMi5k4zXq
 PLa52Nz8=
X-Gm-Gg: ASbGncvspRueMb+2Ji5RveiF3R/c8e3wm7hUF0cbpNxiKLlb4QQ9H2QoF2b1PGm7r8q
 HJVCvIEALfxBCinSJL83zxR2ZTBz6BtGNiIRFce/0qUVRfaQHi+/NIcm/xfJOu6P+MpWOciz95e
 XXBKdWMK/c1eO2zqnmIVgDXzJUlxi7cGd4esqIywoA62kmoxlZgJk5GESY7g/cH19BcDWPf+sFY
 sCUeqbLGmEYbfGJQbcrJvzHF0v/It+dxIrxrn+RldqdBn6vM3BfLWAi2Vix15f2iDKZdimQ7UOv
 DINQI9eOUGyIokTIHSDk0XZqyrt4LibRL9gFV1GYcBjXZ1atwm5D83vNT+AF34yRS8zJIBJjrms
 SKPHS/t/Ii1Z6henNXWQT+r+Hf9CmfPm2bsEPdVHJ5CmwgQBv
X-Google-Smtp-Source: AGHT+IHs6XWo2s1JJTPH0ZN/wB4BUXucmp+pTTe6pt1/w/Rf2gmDSCuMNh39nCKXPeGK9MH65EGD9w==
X-Received: by 2002:a05:6871:14b:b0:2e9:93c6:6e34 with SMTP id
 586e51a60fabf-2f796d38232mr1699267fac.34.1751639341430; 
 Fri, 04 Jul 2025 07:29:01 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:29:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 102/108] target/arm: Rename BFMOPA to BFMOPA_w
Date: Fri,  4 Jul 2025 08:21:05 -0600
Message-ID: <20250704142112.1018902-103-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Our current BFMOPA opcode pattern is the widening version
of the insn. Rename it to BFMOPA_w, to make way for
the non-widening version added in SME2.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    | 2 +-
 target/arm/tcg/sme_helper.c    | 4 ++--
 target/arm/tcg/translate-sme.c | 2 +-
 target/arm/tcg/sme.decode      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 67d620e456..16083660e2 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -141,7 +141,7 @@ DEF_HELPER_FLAGS_7(sme_fmopa_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_7(sme_fmopa_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, fpst, i32)
-DEF_HELPER_FLAGS_7(sme_bfmopa, TCG_CALL_NO_RWG,
+DEF_HELPER_FLAGS_7(sme_bfmopa_w, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_6(sme_smopa_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 1575a2f20c..4772c97deb 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1261,8 +1261,8 @@ void HELPER(sme2_fvdot_idx_h)(void *vd, void *vn, void *vm, void *va,
     }
 }
 
-void HELPER(sme_bfmopa)(void *vza, void *vzn, void *vzm,
-                        void *vpn, void *vpm, CPUARMState *env, uint32_t desc)
+void HELPER(sme_bfmopa_w)(void *vza, void *vzn, void *vzm,
+                          void *vpn, void *vpm, CPUARMState *env, uint32_t desc)
 {
     intptr_t row, col, oprsz = simd_maxsz(desc);
     uint32_t neg = simd_data(desc) * 0x80008000u;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 1167aa4964..38d0231b0a 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -572,7 +572,7 @@ TRANS_FEAT(FMOPA_s, aa64_sme, do_outprod_fpst, a,
 TRANS_FEAT(FMOPA_d, aa64_sme_f64f64, do_outprod_fpst, a,
            MO_64, FPST_ZA, gen_helper_sme_fmopa_d)
 
-TRANS_FEAT(BFMOPA, aa64_sme, do_outprod_env, a, MO_32, gen_helper_sme_bfmopa)
+TRANS_FEAT(BFMOPA_w, aa64_sme, do_outprod_env, a, MO_32, gen_helper_sme_bfmopa_w)
 
 TRANS_FEAT(SMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_smopa_s)
 TRANS_FEAT(UMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_umopa_s)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 77744eef4f..8ad86f707e 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -189,7 +189,7 @@ ADDVA_d         11000000 11 01000 1 ... ... ..... 00 ...        @adda_64
 FMOPA_s         10000000 100 ..... ... ... ..... . 00 ..        @op_32
 FMOPA_d         10000000 110 ..... ... ... ..... . 0 ...        @op_64
 
-BFMOPA          10000001 100 ..... ... ... ..... . 00 ..        @op_32
+BFMOPA_w        10000001 100 ..... ... ... ..... . 00 ..        @op_32
 FMOPA_w_h       10000001 101 ..... ... ... ..... . 00 ..        @op_32
 
 SMOPA_s         1010000 0 10 0 ..... ... ... ..... . 00 ..      @op_32
-- 
2.43.0


