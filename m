Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B755BE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL31c-00065w-Oj; Tue, 10 Dec 2024 11:23:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL31T-0005B0-4j
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:23:43 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL31Q-0007Nl-9P
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:23:42 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-53e399e3310so3735554e87.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847818; x=1734452618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IE8JGMQCGp7GAj77eQk0VVYvmtYbR6TxiLKDi8J590s=;
 b=xkP+yKhL5NnP2qPchCyM5P/8prgwb/5ZIoZLMoi/gKbAmeLCAQb7P3GwAc6h1xaxuZ
 iVqvApLcxHLKt2IqJeu5bILU1FrJLo8TJNnZsGsPu8JwgPXrTSrns0QBdwgecJb0w8+P
 C8Z1P9GW63fgw667Kc2zRLs4v5OZ6aY2ZzGVgV5Qt9Y8bnbJgkw9Gzct90zFn4GhKzFC
 0AnKokc+ghHA0R6dyNVWynHO4uVtHbF+jLIJbGMteSt1jWPG7NrjM27ZiqHMbrhGlcQM
 7QETOlJUOo4qEAW4r93Fj7d5bhsnSwzyCt+oqS9upFkK3auLrpwwjz7U8mhitnXmDhz1
 Z3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847818; x=1734452618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IE8JGMQCGp7GAj77eQk0VVYvmtYbR6TxiLKDi8J590s=;
 b=lyq8lFMGdMs9SCk8LYHIj7LGK8QQ7VR73hb9LC95oUbOsEaKGX4ZKDMmlqxP9Sd6Nq
 JeDJbV/GJrikOXekUU4CFDqGi0uIM+BWWz3T2+hxBXS7vQXs8YhjDgZuxPEE1qrYfyqk
 165JATZbYaracgJMuQbPp6uSgQE3oHnyIxENf7BmmQcBD03tX8AnL6cUh1BdGn3DduAK
 hwscn7SA7ITxlPh101efh6qBzzbQn8hqahEv2uh+6ymkEHEsJ/txhorg+R7YXd65Kb6u
 ShQi8K2Qm/zLGdeAJmKQQFSWBpIRN1vznTy910fjJB3E5o1L9gXSlXK9hQqqc/a4olL6
 GFag==
X-Gm-Message-State: AOJu0YyylapIsmQg7Ku5JjJkoQRzkUX0Mxj2rp2n6xIUTP8BAovkrzWj
 ZNsHK+2dUNPVMpaEE87xA40DltH0zmhCUQfhmcIfp4RCa/zrzQ2HUlapJTw2GyCrEKucbVuA1DO
 W3R206Vbd
X-Gm-Gg: ASbGncvmZrxfNO9EURNzK3Fq+wTolZKgvsbg4qCpfxRjjihXZT6KXY4emjocensM7TO
 lq8TSJwgF7KFVc0ZtJzGAZBGLfNJNnWqIlPpj8YMr0/NM1XkVcp4BPLTpsqmQN4mV549QAQ4i8q
 aQaFPM4DksM+2ziMkHQhzbvuDlrQIpHkWVjeaou65O91Qha3WCa9r5tz6UpMnm9ns/PuhKAOp/B
 1hVI3/r1FmgFiStR2AjCKc+BYhFWdOCUAK1cZ6sJOnS9ach2hQwG3V0tCY=
X-Google-Smtp-Source: AGHT+IEMVZNG9bPiKD40Gx+tVQ0ThKrccpFAUH6trcuBUnjGR9QkWvwEWCYZ4haFEJfRPwcd4GCSsQ==
X-Received: by 2002:a05:6512:3e2a:b0:53e:39e6:a1c2 with SMTP id
 2adb3069b0e04-53e39e6a2e7mr6342125e87.44.1733847818349; 
 Tue, 10 Dec 2024 08:23:38 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5402960b0absm26024e87.102.2024.12.10.08.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:23:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 43/69] target/arm: Convert handle_rev to decodetree
Date: Tue, 10 Dec 2024 10:17:07 -0600
Message-ID: <20241210161733.1830573-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12e.google.com
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

This includes REV16, REV32, REV64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 79 +++-------------------------------
 target/arm/tcg/a64.decode      |  5 +++
 2 files changed, 10 insertions(+), 74 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c737a35121..9ce58586a8 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8939,6 +8939,8 @@ TRANS(CMGE0_v, do_gvec_fn2, a, gen_gvec_cge0)
 TRANS(CMLT0_v, do_gvec_fn2, a, gen_gvec_clt0)
 TRANS(CMLE0_v, do_gvec_fn2, a, gen_gvec_cle0)
 TRANS(CMEQ0_v, do_gvec_fn2, a, gen_gvec_ceq0)
+TRANS(REV16_v, do_gvec_fn2, a, gen_gvec_rev16)
+TRANS(REV32_v, do_gvec_fn2, a, gen_gvec_rev32)
 
 static bool do_gvec_fn2_bhs(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 {
@@ -8953,6 +8955,7 @@ static bool do_gvec_fn2_bhs(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 
 TRANS(CLS_v, do_gvec_fn2_bhs, a, gen_gvec_cls)
 TRANS(CLZ_v, do_gvec_fn2_bhs, a, gen_gvec_clz)
+TRANS(REV64_v, do_gvec_fn2_bhs, a, gen_gvec_rev64)
 
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
@@ -9882,76 +9885,6 @@ static void handle_2misc_widening(DisasContext *s, int opcode, bool is_q,
     }
 }
 
-static void handle_rev(DisasContext *s, int opcode, bool u,
-                       bool is_q, int size, int rn, int rd)
-{
-    int op = (opcode << 1) | u;
-    int opsz = op + size;
-    int grp_size = 3 - opsz;
-    int dsize = is_q ? 128 : 64;
-    int i;
-
-    if (opsz >= 3) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    if (size == 0) {
-        /* Special case bytes, use bswap op on each group of elements */
-        int groups = dsize / (8 << grp_size);
-
-        for (i = 0; i < groups; i++) {
-            TCGv_i64 tcg_tmp = tcg_temp_new_i64();
-
-            read_vec_element(s, tcg_tmp, rn, i, grp_size);
-            switch (grp_size) {
-            case MO_16:
-                tcg_gen_bswap16_i64(tcg_tmp, tcg_tmp, TCG_BSWAP_IZ);
-                break;
-            case MO_32:
-                tcg_gen_bswap32_i64(tcg_tmp, tcg_tmp, TCG_BSWAP_IZ);
-                break;
-            case MO_64:
-                tcg_gen_bswap64_i64(tcg_tmp, tcg_tmp);
-                break;
-            default:
-                g_assert_not_reached();
-            }
-            write_vec_element(s, tcg_tmp, rd, i, grp_size);
-        }
-        clear_vec_high(s, is_q, rd);
-    } else {
-        int revmask = (1 << grp_size) - 1;
-        int esize = 8 << size;
-        int elements = dsize / esize;
-        TCGv_i64 tcg_rn = tcg_temp_new_i64();
-        TCGv_i64 tcg_rd[2];
-
-        for (i = 0; i < 2; i++) {
-            tcg_rd[i] = tcg_temp_new_i64();
-            tcg_gen_movi_i64(tcg_rd[i], 0);
-        }
-
-        for (i = 0; i < elements; i++) {
-            int e_rev = (i & 0xf) ^ revmask;
-            int w = (e_rev * esize) / 64;
-            int o = (e_rev * esize) % 64;
-
-            read_vec_element(s, tcg_rn, rn, i, size);
-            tcg_gen_deposit_i64(tcg_rd[w], tcg_rd[w], tcg_rn, o, esize);
-        }
-
-        for (i = 0; i < 2; i++) {
-            write_vec_element(s, tcg_rd[i], rd, i, MO_64);
-        }
-        clear_vec_high(s, true, rd);
-    }
-}
-
 static void handle_2misc_pairwise(DisasContext *s, int opcode, bool u,
                                   bool is_q, int size, int rn, int rd)
 {
@@ -10066,10 +9999,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     TCGv_ptr tcg_fpstatus;
 
     switch (opcode) {
-    case 0x0: /* REV64, REV32 */
-    case 0x1: /* REV16 */
-        handle_rev(s, opcode, u, is_q, size, rn, rd);
-        return;
     case 0x12: /* XTN, XTN2, SQXTUN, SQXTUN2 */
     case 0x14: /* SQXTN, SQXTN2, UQXTN, UQXTN2 */
         if (size == 3) {
@@ -10272,6 +10201,8 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         break;
     }
     default:
+    case 0x0: /* REV64, REV32 */
+    case 0x1: /* REV16 */
     case 0x3: /* SUQADD, USQADD */
     case 0x4: /* CLS, CLZ */
     case 0x5: /* CNT, NOT, RBIT */
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 247d3a7bda..05f1bc99b5 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -73,6 +73,7 @@
 
 @qrr_b          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=0
 @qrr_h          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=1
+@qrr_bh         . q:1 ...... . esz:1 ...... ...... rn:5 rd:5  &qrr_e
 @qrr_e          . q:1 ...... esz:2 ...... ...... rn:5 rd:5  &qrr_e
 
 @qrrr_b         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=0
@@ -1657,3 +1658,7 @@ CMGE0_v         0.10 1110 ..1 00000 10001 0 ..... .....     @qrr_e
 CMEQ0_v         0.00 1110 ..1 00000 10011 0 ..... .....     @qrr_e
 CMLE0_v         0.10 1110 ..1 00000 10011 0 ..... .....     @qrr_e
 CMLT0_v         0.00 1110 ..1 00000 10101 0 ..... .....     @qrr_e
+
+REV16_v         0.00 1110 001 00000 00011 0 ..... .....     @qrr_b
+REV32_v         0.10 1110 0.1 00000 00001 0 ..... .....     @qrr_bh
+REV64_v         0.00 1110 ..1 00000 00001 0 ..... .....     @qrr_e
-- 
2.43.0


