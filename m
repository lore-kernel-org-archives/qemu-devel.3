Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58119D49775
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlbM-0003eR-Op; Sun, 01 Dec 2024 10:11:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaQ-00083x-E0
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:18 -0500
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaN-0005CE-GK
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:13 -0500
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5f1d3e74ea4so1364137eaf.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065808; x=1733670608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uRDcEjCSQyuXv4CKyKrMl6OTcVO9NJQnDrnRCeRyrgY=;
 b=ztAZPcxE7U22P0BKWZZWNomsAoKztpi7+hKGaXMbQF+S4HM7pe8bEe+ItkydLk85KU
 uKyy2V/mP1dYfs6wVmmiNyO4ud3pAiejWxEPihNs/ZVEC4Pf90EsZJn3O/O0jZA9l3H1
 Mwn9ZyZUc0dZe2ztwPlio05yjNea8jgfJp4m/QBYBpP7no1qV8qgjr43NO4XAKvuMDi6
 2KXh7o9a9vfDGtOOZP5cyxuIgn+Q/T7tIItUDQ7h+al12wot+DjJdgp70gt2AElnvLc+
 P8jMBHVOgUiR77lwS63kyFvcdozYc/XB/1Z7RHHMbQDTXHmT1s4dOZRf2wq65QdtUT9P
 +yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065808; x=1733670608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uRDcEjCSQyuXv4CKyKrMl6OTcVO9NJQnDrnRCeRyrgY=;
 b=f+BjCRMU+Ql4ue7MyzSfr966rvCEG5PsSJHLZqs7xfWdxIA99m8yKN7NdOOLq4i74S
 5vM/KdZU5g5KzY+pMjmMfDg9c/nrG0TR93Oy+KsK4hnxKBBcwUhf/5patTl0hOVw68GH
 Zw5Q5n0inedu+H50KuN96yUhzjNsydS8H5SyPs9dBa+XQM5Cpe/yWZXsC1PsAoLK6Oj/
 fS9z7GAahUTNstn+cWTdzPgsGybNEQB4acqaOawbT+oy/4UmnlM3Y54yxwT0w4b7nDQK
 r1mTpR2nUTLlJQK2mwy0SBbSdN/03NrIWjmEHDNKkMySMAIsJyAtKCsIIp1q094Mp9aY
 ISSA==
X-Gm-Message-State: AOJu0Yw+lKcNnuwtqx7iepWuQtIlseOZADdVY4ABEUlWasCp9OvwYqXQ
 /Jvl4yK7OjmUwMG8ODy3hn9G5ny4ClHANaamkEfGU/OJAoEOu+t1oHs/tbatCXcrJDnYQwwtx4Z
 XwBA=
X-Gm-Gg: ASbGncvIrQNchK2oaO+prbUti7RRy/Y/nTVsZtnFYYeu7IpBSipfsmKQELkfT7n/bLm
 EizDspr+eczZAN/coqFn1YDdIYkqFpjgCIqayb8XJ8E3hkir80F1lM6ymA/sy9tvIoZuMBeFCY9
 du4IM5fLRizjedBHAi4qyZTlLcWoPikzWqCjB+P1ozezNUUQNxpD5XXxiaToggAEVleOT5IWIjG
 +BRboz714f7AGybselUjxDApYG7iqGHfPEOznyjMNGwIVbLQWVlJeJ1/9/pmrChEqUPKLbcq273
 B2vzliDZASkinKQD1vmQCt6x2gAoPuNWMnKf
X-Google-Smtp-Source: AGHT+IG0NKe4KJezVCLjuZpxbzG+6UBDvQF7Cem1PoJar2kS9W+QzRWIYxgdh/jeOWtz9Ob3rh3axA==
X-Received: by 2002:a05:6820:1c95:b0:5f2:586:5ca3 with SMTP id
 006d021491bc7-5f20a18e82emr14793063eaf.4.1733065807894; 
 Sun, 01 Dec 2024 07:10:07 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a4cd78fsm1807008eaf.32.2024.12.01.07.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:10:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 52/67] target/arm: Convert FABS, FNEG (vector) to decodetree
Date: Sun,  1 Dec 2024 09:05:51 -0600
Message-ID: <20241201150607.12812-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/tcg/translate-a64.c | 61 ++++++++++++++++++----------------
 target/arm/tcg/a64.decode      |  7 ++++
 2 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 613dcdb9a2..31272c1878 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9153,6 +9153,28 @@ static bool trans_SHLL_v(DisasContext *s, arg_qrr_e *a)
     return true;
 }
 
+static bool do_fabs_fneg_v(DisasContext *s, arg_qrr_e *a, bool neg)
+{
+    int check = fp_access_check_vector_hsd(s, a->q, a->esz);
+    uint64_t sign;
+
+    if (check <= 0) {
+        return check == 0;
+    }
+
+    sign = 1ull << ((8 << a->esz) - 1);
+    if (neg) {
+        gen_gvec_fn2i(s, a->q, a->rd, a->rn, sign,
+                      tcg_gen_gvec_xori, a->esz);
+    } else {
+        gen_gvec_fn2i(s, a->q, a->rd, a->rn, sign - 1,
+                      tcg_gen_gvec_andi, a->esz);
+    }
+    return true;
+}
+
+TRANS(FABS_v, do_fabs_fneg_v, a, false)
+TRANS(FNEG_v, do_fabs_fneg_v, a, true)
 
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
@@ -9451,12 +9473,6 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
      * requires them.
      */
     switch (opcode) {
-    case 0x2f: /* FABS */
-        gen_vfp_absd(tcg_rd, tcg_rn);
-        break;
-    case 0x6f: /* FNEG */
-        gen_vfp_negd(tcg_rd, tcg_rn);
-        break;
     case 0x7f: /* FSQRT */
         gen_helper_vfp_sqrtd(tcg_rd, tcg_rn, tcg_fpstatus);
         break;
@@ -9501,6 +9517,8 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
     case 0x9: /* CMEQ, CMLE */
     case 0xa: /* CMLT */
     case 0xb: /* ABS, NEG */
+    case 0x2f: /* FABS */
+    case 0x6f: /* FNEG */
         g_assert_not_reached();
     }
 }
@@ -9972,13 +9990,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         opcode |= (extract32(size, 1, 1) << 5) | (u << 6);
         size = is_double ? 3 : 2;
         switch (opcode) {
-        case 0x2f: /* FABS */
-        case 0x6f: /* FNEG */
-            if (size == 3 && !is_q) {
-                unallocated_encoding(s);
-                return;
-            }
-            break;
         case 0x1d: /* SCVTF */
         case 0x5d: /* UCVTF */
         {
@@ -10103,6 +10114,8 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x16: /* FCVTN, FCVTN2 */
         case 0x36: /* BFCVTN, BFCVTN2 */
         case 0x56: /* FCVTXN, FCVTXN2 */
+        case 0x2f: /* FABS */
+        case 0x6f: /* FNEG */
             unallocated_encoding(s);
             return;
         }
@@ -10175,12 +10188,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             {
                 /* Special cases for 32 bit elements */
                 switch (opcode) {
-                case 0x2f: /* FABS */
-                    gen_vfp_abss(tcg_res, tcg_op);
-                    break;
-                case 0x6f: /* FNEG */
-                    gen_vfp_negs(tcg_res, tcg_op);
-                    break;
                 case 0x7f: /* FSQRT */
                     gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_fpstatus);
                     break;
@@ -10224,6 +10231,8 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                     break;
                 default:
                 case 0x7: /* SQABS, SQNEG */
+                case 0x2f: /* FABS */
+                case 0x6f: /* FNEG */
                     g_assert_not_reached();
                 }
             }
@@ -10366,14 +10375,12 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     case 0x7b: /* FCVTZU */
         rmode = FPROUNDING_ZERO;
         break;
-    case 0x2f: /* FABS */
-    case 0x6f: /* FNEG */
-        need_fpst = false;
-        break;
     case 0x7d: /* FRSQRTE */
     case 0x7f: /* FSQRT (vector) */
         break;
     default:
+    case 0x2f: /* FABS */
+    case 0x6f: /* FNEG */
         unallocated_encoding(s);
         return;
     }
@@ -10476,12 +10483,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
             case 0x59: /* FRINTX */
                 gen_helper_advsimd_rinth_exact(tcg_res, tcg_op, tcg_fpstatus);
                 break;
-            case 0x2f: /* FABS */
-                tcg_gen_andi_i32(tcg_res, tcg_op, 0x7fff);
-                break;
-            case 0x6f: /* FNEG */
-                tcg_gen_xori_i32(tcg_res, tcg_op, 0x8000);
-                break;
             case 0x7d: /* FRSQRTE */
                 gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
                 break;
@@ -10489,6 +10490,8 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
                 gen_helper_vfp_sqrth(tcg_res, tcg_op, tcg_fpstatus);
                 break;
             default:
+            case 0x2f: /* FABS */
+            case 0x6f: /* FNEG */
                 g_assert_not_reached();
             }
 
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 8f91b9af1a..fec6aa7a23 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -77,6 +77,7 @@
 @qrr_s          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=2
 @qrr_bh         . q:1 ...... . esz:1 ...... ...... rn:5 rd:5  &qrr_e
 @qrr_hs         . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=%esz_hs
+@qrr_sd         . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=%esz_sd
 @qrr_e          . q:1 ...... esz:2 ...... ...... rn:5 rd:5  &qrr_e
 
 @qrrr_b         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=0
@@ -1687,3 +1688,9 @@ FCVTXN_v        0.10 1110 011 00001 01101 0 ..... .....     @qrr_s
 BFCVTN_v        0.00 1110 101 00001 01101 0 ..... .....     @qrr_h
 
 SHLL_v          0.10 1110 ..1 00001 00111 0 ..... .....     @qrr_e
+
+FABS_v          0.00 1110 111 11000 11111 0 ..... .....     @qrr_h
+FABS_v          0.00 1110 1.1 00000 11111 0 ..... .....     @qrr_sd
+
+FNEG_v          0.10 1110 111 11000 11111 0 ..... .....     @qrr_h
+FNEG_v          0.10 1110 1.1 00000 11111 0 ..... .....     @qrr_sd
-- 
2.43.0


