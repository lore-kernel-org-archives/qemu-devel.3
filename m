Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E189C25B10
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mmH-0007g2-Sn; Sun, 05 May 2024 21:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmB-0007bv-9J
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:20 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mm6-0002R4-Cx
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:17 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2a2d82537efso913811a91.2
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957452; x=1715562252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uXd7G7gYNjtzzrDvubOWwZNd9eG96LxiAMr8ZaBZ+pk=;
 b=Eh7npzFvpohfrkoh98KKfXPWGPuuDtk0LALCgwoQ9yIh0Bdps4hnQ/EqGHblMEfZgs
 JHwVey/IDEjQePcVYep4qD22jUPap1R5ejyCMdziYBsmk9yW+jXjnu7x86rX5NiXin1n
 jSfRot4U05/Qlm8OA5PWNER99OOm9kytCAdcDVWEntkj3UIPCMCPegE1pjvpM4FD6ni0
 Ti5CWQsHSpYR5Kh3I4tSzrtcxOa8TPDJG/SoYT/7BJUisi8D2iZYHZSIBmuzZgDX2Kp0
 FGKsI/299+0qbE/Xf6Eh4Z6nJfu/dr54zG6XC8CsBAYptcb97s8M/40BfWQCuDjDIt1b
 9lVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957452; x=1715562252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uXd7G7gYNjtzzrDvubOWwZNd9eG96LxiAMr8ZaBZ+pk=;
 b=BCtfDmpsks70YawFttgoQYSmE1MeHuHm43m1vHXy9fNAs0q7sA0cI0jio2P03a9r/C
 Kq6rGvfvsoPur7rFLj6G2ekyHYuDqeK1yd9Rh89q3WbfVGhnm58qiI0eHkjTi5kv+Kv7
 iSSqHGSN+fEQtcapUptqi3bPWo2o2j1QrfleikldZrReveP7MKlCmPqtqp2qRxtJed8I
 0gI/gzV2xcLSdsGfVuvDSle1lsaEoMFEJ2fK6stGtkxiV89HWKTkShQVvkRKNGpfNW4I
 DlF/INC9JCYumWBHzxfVv5Kz39FQmvl7BoL7UucxHsWLzsNlrokaNpJQvSk2j2rZ2Rkz
 l1lA==
X-Gm-Message-State: AOJu0Yz9lYDTf/CnJ/mjjVNaJuSdgX1Pf0EKZ0ZKNRjsSb0iibC9kc9m
 ImdiqqhbKqQjBqr3/30klIFG29cVEbxQa7CMOdAZTceevBgoqgI4m8DTd8HFSZ7YJuGabkklMcU
 s
X-Google-Smtp-Source: AGHT+IEYIbfduC9znitozp274M/VhM4ibAtMLf/n4qqi8mundTauqD48AQ62yC6AlTQtjaxbauDzbg==
X-Received: by 2002:a17:90a:5293:b0:2b5:6e92:1096 with SMTP id
 w19-20020a17090a529300b002b56e921096mr380702pjh.28.1714957451858; 
 Sun, 05 May 2024 18:04:11 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 07/57] target/arm: Convert Cryptographic 2-register SHA512 to
 decodetree
Date: Sun,  5 May 2024 18:03:13 -0700
Message-Id: <20240506010403.6204-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |  5 ++++
 target/arm/tcg/translate-a64.c | 50 ++--------------------------------
 2 files changed, 8 insertions(+), 47 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index c342c27608..5a46205751 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -631,3 +631,8 @@ RAX1            1100 1110 011 ..... 100011 ..... .....  @rrr_q1e3
 SM3PARTW1       1100 1110 011 ..... 110000 ..... .....  @rrr_q1e0
 SM3PARTW2       1100 1110 011 ..... 110001 ..... .....  @rrr_q1e0
 SM4EKEY         1100 1110 011 ..... 110010 ..... .....  @rrr_q1e0
+
+### Cryptographic two-register SHA512
+
+SHA512SU0       1100 1110 110 00000 100000 ..... .....  @rr_q1e0
+SM4E            1100 1110 110 00000 100001 ..... .....  @r2r_q1e0
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d2d9198f22..1bfee2583a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4630,6 +4630,9 @@ TRANS_FEAT(SM3PARTW1, aa64_sm3, do_gvec_op3_ool, a, 0, gen_helper_crypto_sm3part
 TRANS_FEAT(SM3PARTW2, aa64_sm3, do_gvec_op3_ool, a, 0, gen_helper_crypto_sm3partw2)
 TRANS_FEAT(SM4EKEY, aa64_sm4, do_gvec_op3_ool, a, 0, gen_helper_crypto_sm4ekey)
 
+TRANS_FEAT(SHA512SU0, aa64_sha512, do_gvec_op2_ool, a, 0, gen_helper_crypto_sha512su0)
+TRANS_FEAT(SM4E, aa64_sm4, do_gvec_op3_ool, a, 0, gen_helper_crypto_sm4e)
+
 
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
@@ -13524,52 +13527,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Crypto two-reg SHA512
- *  31                                     12  11  10  9    5 4    0
- * +-----------------------------------------+--------+------+------+
- * | 1 1 0 0 1 1 1 0 1 1 0 0 0 0 0 0 1 0 0 0 | opcode |  Rn  |  Rd  |
- * +-----------------------------------------+--------+------+------+
- */
-static void disas_crypto_two_reg_sha512(DisasContext *s, uint32_t insn)
-{
-    int opcode = extract32(insn, 10, 2);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-    bool feature;
-
-    switch (opcode) {
-    case 0: /* SHA512SU0 */
-        feature = dc_isar_feature(aa64_sha512, s);
-        break;
-    case 1: /* SM4E */
-        feature = dc_isar_feature(aa64_sm4, s);
-        break;
-    default:
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!feature) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    switch (opcode) {
-    case 0: /* SHA512SU0 */
-        gen_gvec_op2_ool(s, true, rd, rn, 0, gen_helper_crypto_sha512su0);
-        break;
-    case 1: /* SM4E */
-        gen_gvec_op3_ool(s, true, rd, rd, rn, 0, gen_helper_crypto_sm4e);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 /* Crypto four-register
  *  31               23 22 21 20  16 15  14  10 9    5 4    0
  * +-------------------+-----+------+---+------+------+------+
@@ -13744,7 +13701,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e000400, 0xdfe08400, disas_simd_scalar_copy },
     { 0x5f000000, 0xdf000400, disas_simd_indexed }, /* scalar indexed */
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
-    { 0xcec08000, 0xfffff000, disas_crypto_two_reg_sha512 },
     { 0xce000000, 0xff808000, disas_crypto_four_reg },
     { 0xce800000, 0xffe00000, disas_crypto_xar },
     { 0xce408000, 0xffe0c000, disas_crypto_three_reg_imm2 },
-- 
2.34.1


