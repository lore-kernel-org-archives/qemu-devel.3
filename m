Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A434C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFe-0006AW-HH; Fri, 04 Jul 2025 12:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFW-00056T-1t
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFU-0006y5-0p
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:53 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-451d54214adso7695865e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646410; x=1752251210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BLZ2yd1uGgF3NN7lDCPG1kKzvbCyV4+5e2lz9TIgE5A=;
 b=famuMgDqV1wmjrr5UJr8JJjity+DYaAaWaDNecsypqskp3nuvHLahL9zNul8K2v7SB
 fi107xjTDABwbgBePgVeLXw5ff8ai3yKidwWDmaqCI+oT9BbmOjMewMeAlAEYffdPlur
 9Yl9kh0e2AQJzDUuDXANc/uUA4H/Ws1QiMf8bcuef3XEQV6KY1p5Bn7JlMVg2QH5Qf8D
 EBHWwNKtEJ81mV4rHuzCLw3WkziT4CdXtFTf2Mq0Q9I9azNSuK8mEUf8XMAQlFAErvxG
 A5l//FHG7Hfs+bUr3g8PFi0fKAAN7Vk5v36jhx2tebSKcrHM+kJ3cqm9CseN3+9DikKN
 7DiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646410; x=1752251210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BLZ2yd1uGgF3NN7lDCPG1kKzvbCyV4+5e2lz9TIgE5A=;
 b=vyTE3VXtlOEZIb6sRo+9hb8nQWa4pIeUVb0dgFXG3B8LuPS1se78+DcdXNnMtgQxPl
 0HN57GFINN/I17H3aM1pGWb30kgDA56vd6rYz4m2gqTLF2uYgD9EOSq2nC61/rdNHsfi
 rs6JK8h/C4fnl5xN83srShhFELEPIFsAMZdH8IX1e2UOp5YOcOeHel9ipKZgsciw2e+x
 bPZUDMynIukclNdSvFRXjDewCfpNvF8cZbLqBveuu96XqQL1yWhq9DoYPLNRggZrzBBc
 wq79CBSXw2OosH2t6+oWAueQLcNfRLkdxo/0irSTHZ4eVDB+z7RIuA1w0Nu2UqfUTx4v
 bSBg==
X-Gm-Message-State: AOJu0YwsQH3I124IY5qHDUYeImmZZBR1HyekSVi+aBR/iYkClhBbgVIb
 DRrd7b9c9CrFA/FupffTtGn+M4mDpe2e3eAWv3JEDSOSmw/rCc9FDZWGlKpqj8rXCXAxw17eo5Y
 At6m3
X-Gm-Gg: ASbGncs0ZWrNO53vKE+hfMLYaTdkqaG1M3O1Wy316JIWiFbGz0CiUIZYPtjy4+sBBzG
 klHH4ksoCYbcd6rQKL/zaKjmAVmIoLbRb55aKCgCoGpfsg43Q8ngfBpsxSwNZmi3i+7l59O4Gwp
 TLYWOWIZ2XBvr9Lynymz7Fu0xxVc6wAxupLNV4rzS2wLYnJCmO7OwypHtkMBc/ulJXscFSF/Rae
 FnRQ3VTuwF5+jA9Dw1WWPG2DNunK/JvTCxxDT2VNd+aqB75fdcCq5SS47m4QwJXFNy39UOvO92b
 s2JW/C1XDL/Q2WS5icgk34lxF3E2HiCX6VPPJ3JjHUmioYgmIhBfMi45X6NOPslovARac4QOq2W
 QPwQ=
X-Google-Smtp-Source: AGHT+IGqKcrEJFJwCYFuGGZKS8NyiFaSBrvszSkZ0x/zBQcku/Yd4frf9uf2dGu6rMJY97Aq6k5idg==
X-Received: by 2002:a05:600c:4f4d:b0:442:f956:53f9 with SMTP id
 5b1f17b1804b1-454b3162015mr35152845e9.18.1751646410504; 
 Fri, 04 Jul 2025 09:26:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 114/119] target/arm: Rename BFMOPA to BFMOPA_w
Date: Fri,  4 Jul 2025 17:24:54 +0100
Message-ID: <20250704162501.249138-115-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Our current BFMOPA opcode pattern is the widening version
of the insn. Rename it to BFMOPA_w, to make way for
the non-widening version added in SME2.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-103-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme.h    | 2 +-
 target/arm/tcg/sme.decode      | 2 +-
 target/arm/tcg/sme_helper.c    | 4 ++--
 target/arm/tcg/translate-sme.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 67d620e456c..16083660e2f 100644
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
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 77744eef4fd..8ad86f707ed 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -189,7 +189,7 @@ ADDVA_d         11000000 11 01000 1 ... ... ..... 00 ...        @adda_64
 FMOPA_s         10000000 100 ..... ... ... ..... . 00 ..        @op_32
 FMOPA_d         10000000 110 ..... ... ... ..... . 0 ...        @op_64
 
-BFMOPA          10000001 100 ..... ... ... ..... . 00 ..        @op_32
+BFMOPA_w        10000001 100 ..... ... ... ..... . 00 ..        @op_32
 FMOPA_w_h       10000001 101 ..... ... ... ..... . 00 ..        @op_32
 
 SMOPA_s         1010000 0 10 0 ..... ... ... ..... . 00 ..      @op_32
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 1575a2f20c5..4772c97debb 100644
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
index 1167aa4964c..38d0231b0a9 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -572,7 +572,7 @@ TRANS_FEAT(FMOPA_s, aa64_sme, do_outprod_fpst, a,
 TRANS_FEAT(FMOPA_d, aa64_sme_f64f64, do_outprod_fpst, a,
            MO_64, FPST_ZA, gen_helper_sme_fmopa_d)
 
-TRANS_FEAT(BFMOPA, aa64_sme, do_outprod_env, a, MO_32, gen_helper_sme_bfmopa)
+TRANS_FEAT(BFMOPA_w, aa64_sme, do_outprod_env, a, MO_32, gen_helper_sme_bfmopa_w)
 
 TRANS_FEAT(SMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_smopa_s)
 TRANS_FEAT(UMOPA_s, aa64_sme, do_outprod, a, MO_32, gen_helper_sme_umopa_s)
-- 
2.43.0


