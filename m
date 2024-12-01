Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C19D49773
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlWv-0001PD-4N; Sun, 01 Dec 2024 10:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWn-0001JU-F5
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:29 -0500
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWl-0004AN-8H
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:29 -0500
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5f1d1fdb328so1122927eaf.3
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065586; x=1733670386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W0Kyjmr0WOluioy2h/qO52iqWK3XVuY0W6MyzBGu6bc=;
 b=xHEOnRUtavHc9u35sl2VFgPOPE0xQjDCZhKR2MkeJeMsNHGeHQwE8lsyo2dZz5I3lo
 QqU5D/Mw/2+n1dJWAP6jeLzLvytEgabUZ1lf4XNXTSHfcxgXSy56rIZ2G8iAl8pOK0sj
 xQnGObaiYjong0xgxhVOjM+jnfI+DlRDluUO9fZE5Hkaf/FUqvD5gnLReMZeXwbDa/MZ
 h6HFa3OuftkDlNFnVipXBeOegtxdNCHE3yrWNXW8rbRzZnrOZmZ+nIM1DvvhlYTl98MV
 nYt4+wyYacy3WUrRY9OAlk2JAP5yYj7OX8oznNf/yLRrqh4RaEV6z5DnyJ0TmPAsAHVJ
 csBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065586; x=1733670386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W0Kyjmr0WOluioy2h/qO52iqWK3XVuY0W6MyzBGu6bc=;
 b=UvcfQLvfngaeiKTF+8kkA0qtizdQmv9uWKI6U1nNM7LF2eKAGRi5KrSMhU0BoxhReT
 3AgZ5Pu863zBrnGNI5FYcfZgzOHyB5TupsuqIqn1GkcC5uXaxQnHja0o0SBj3tWF4Mff
 81gcQKEFMBZQv04JmuVrUswk6U7OpzTsy0QPD58JxX+VClpsTVO2qwQfnuWSEG1N2gjy
 1D7wauOjg3q4ZPq9l0ioNRqOVl1pI9gi5CdNFxAkyussuju5F8ev61H4fyO38QvK2KJq
 awsTRv9EN5XgemsoFbAfTBSOcg85iDNkynHo1BvZPEo+2qH+ktyYyVg4AIXeF4PLnkH2
 fw0A==
X-Gm-Message-State: AOJu0Yz2YJIh/12/ji3ZNrAjFJR7hkoBwGnaMdXGT3hSvJl7i/MsxvoU
 h10iXVHHbzTvtuZ1mWapp4lKZQVY16Cidis90IIF34r5Dh5u7rNpNkC3YXRnYNM+fLpmFOU5p9g
 6NMg=
X-Gm-Gg: ASbGncsWS0b0MhQMhvfeUJ1+GEJlLm5a2k/hVJODknuExkEFODddb2SdqfNGuJuj2KE
 mEQaflvqQCfqXMZCs5YXgqgFVl40yd8MfygR4r1CkgpkYaNuntbCSyzq44vA3nvqGKAfKgVZZdS
 x448SY0+m8Ch+3XNsdHp37SjqUGcU2aiEwSFP7SIMgc0kQRpyZdkFCepVZ1bJes2dygn2B/G8PG
 nOM7iFxdY2XkHC9b4j0wNmUIbI2akE+VtWfjRlZcl5r35zF0TShbHvMNDjjm/TK3ukglYBYMWrn
 fDF1wQdscpYazV6fESLK139AsMDDrPKmOkLF
X-Google-Smtp-Source: AGHT+IHyUxmUxr3EfCHd04dRX9AAiMkV91J4pnVCWI6117m+X1TrEgO1AlZT6HCp+/m/f5bYlXyspQ==
X-Received: by 2002:a05:6830:924:b0:71d:5f7d:148e with SMTP id
 46e09a7af769-71d65c92ec1mr16566325a34.8.1733065585824; 
 Sun, 01 Dec 2024 07:06:25 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 14/67] target/arm: Convert disas_data_proc_3src to decodetree
Date: Sun,  1 Dec 2024 09:05:13 -0600
Message-ID: <20241201150607.12812-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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

This includes MADD, MSUB, SMADDL, SMSUBL, UMADDL, UMSUBL, SMULH, UMULH.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 119 ++++++++++++---------------------
 target/arm/tcg/a64.decode      |  16 +++++
 2 files changed, 59 insertions(+), 76 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d570bbb696..99ff787c61 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7955,98 +7955,68 @@ TRANS(SUB_r, do_addsub_reg, a, true, false)
 TRANS(ADDS_r, do_addsub_reg, a, false, true)
 TRANS(SUBS_r, do_addsub_reg, a, true, true)
 
-/* Data-processing (3 source)
- *
- *    31 30  29 28       24 23 21  20  16  15  14  10 9    5 4    0
- *  +--+------+-----------+------+------+----+------+------+------+
- *  |sf| op54 | 1 1 0 1 1 | op31 |  Rm  | o0 |  Ra  |  Rn  |  Rd  |
- *  +--+------+-----------+------+------+----+------+------+------+
- */
-static void disas_data_proc_3src(DisasContext *s, uint32_t insn)
+static bool do_mulh(DisasContext *s, arg_rrr *a,
+                    void (*fn)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
 {
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int ra = extract32(insn, 10, 5);
-    int rm = extract32(insn, 16, 5);
-    int op_id = (extract32(insn, 29, 3) << 4) |
-        (extract32(insn, 21, 3) << 1) |
-        extract32(insn, 15, 1);
-    bool sf = extract32(insn, 31, 1);
-    bool is_sub = extract32(op_id, 0, 1);
-    bool is_high = extract32(op_id, 2, 1);
-    bool is_signed = false;
-    TCGv_i64 tcg_op1;
-    TCGv_i64 tcg_op2;
-    TCGv_i64 tcg_tmp;
+    TCGv_i64 discard = tcg_temp_new_i64();
+    TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
+    TCGv_i64 tcg_rn = cpu_reg(s, a->rn);
+    TCGv_i64 tcg_rm = cpu_reg(s, a->rm);
 
-    /* Note that op_id is sf:op54:op31:o0 so it includes the 32/64 size flag */
-    switch (op_id) {
-    case 0x42: /* SMADDL */
-    case 0x43: /* SMSUBL */
-    case 0x44: /* SMULH */
-        is_signed = true;
-        break;
-    case 0x0: /* MADD (32bit) */
-    case 0x1: /* MSUB (32bit) */
-    case 0x40: /* MADD (64bit) */
-    case 0x41: /* MSUB (64bit) */
-    case 0x4a: /* UMADDL */
-    case 0x4b: /* UMSUBL */
-    case 0x4c: /* UMULH */
-        break;
-    default:
-        unallocated_encoding(s);
-        return;
-    }
+    fn(discard, tcg_rd, tcg_rn, tcg_rm);
+    return true;
+}
 
-    if (is_high) {
-        TCGv_i64 low_bits = tcg_temp_new_i64(); /* low bits discarded */
-        TCGv_i64 tcg_rd = cpu_reg(s, rd);
-        TCGv_i64 tcg_rn = cpu_reg(s, rn);
-        TCGv_i64 tcg_rm = cpu_reg(s, rm);
+TRANS(SMULH, do_mulh, a, tcg_gen_muls2_i64)
+TRANS(UMULH, do_mulh, a, tcg_gen_mulu2_i64)
 
-        if (is_signed) {
-            tcg_gen_muls2_i64(low_bits, tcg_rd, tcg_rn, tcg_rm);
-        } else {
-            tcg_gen_mulu2_i64(low_bits, tcg_rd, tcg_rn, tcg_rm);
-        }
-        return;
-    }
+static bool do_muladd(DisasContext *s, arg_rrrr *a,
+                      bool sf, bool is_sub, MemOp mop)
+{
+    TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
+    TCGv_i64 tcg_op1, tcg_op2;
 
-    tcg_op1 = tcg_temp_new_i64();
-    tcg_op2 = tcg_temp_new_i64();
-    tcg_tmp = tcg_temp_new_i64();
-
-    if (op_id < 0x42) {
-        tcg_gen_mov_i64(tcg_op1, cpu_reg(s, rn));
-        tcg_gen_mov_i64(tcg_op2, cpu_reg(s, rm));
+    if (mop == MO_64) {
+        tcg_op1 = cpu_reg(s, a->rn);
+        tcg_op2 = cpu_reg(s, a->rm);
     } else {
-        if (is_signed) {
-            tcg_gen_ext32s_i64(tcg_op1, cpu_reg(s, rn));
-            tcg_gen_ext32s_i64(tcg_op2, cpu_reg(s, rm));
-        } else {
-            tcg_gen_ext32u_i64(tcg_op1, cpu_reg(s, rn));
-            tcg_gen_ext32u_i64(tcg_op2, cpu_reg(s, rm));
-        }
+        tcg_op1 = tcg_temp_new_i64();
+        tcg_op2 = tcg_temp_new_i64();
+        tcg_gen_ext_i64(tcg_op1, cpu_reg(s, a->rn), mop);
+        tcg_gen_ext_i64(tcg_op2, cpu_reg(s, a->rm), mop);
     }
 
-    if (ra == 31 && !is_sub) {
+    if (a->ra == 31 && !is_sub) {
         /* Special-case MADD with rA == XZR; it is the standard MUL alias */
-        tcg_gen_mul_i64(cpu_reg(s, rd), tcg_op1, tcg_op2);
+        tcg_gen_mul_i64(tcg_rd, tcg_op1, tcg_op2);
     } else {
+        TCGv_i64 tcg_tmp = tcg_temp_new_i64();
+        TCGv_i64 tcg_ra = cpu_reg(s, a->ra);
+
         tcg_gen_mul_i64(tcg_tmp, tcg_op1, tcg_op2);
         if (is_sub) {
-            tcg_gen_sub_i64(cpu_reg(s, rd), cpu_reg(s, ra), tcg_tmp);
+            tcg_gen_sub_i64(tcg_rd, tcg_ra, tcg_tmp);
         } else {
-            tcg_gen_add_i64(cpu_reg(s, rd), cpu_reg(s, ra), tcg_tmp);
+            tcg_gen_add_i64(tcg_rd, tcg_ra, tcg_tmp);
         }
     }
 
     if (!sf) {
-        tcg_gen_ext32u_i64(cpu_reg(s, rd), cpu_reg(s, rd));
+        tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
     }
+    return true;
 }
 
+TRANS(MADD_w, do_muladd, a, false, false, MO_64)
+TRANS(MSUB_w, do_muladd, a, false, true, MO_64)
+TRANS(MADD_x, do_muladd, a, true, false, MO_64)
+TRANS(MSUB_x, do_muladd, a, true, true, MO_64)
+
+TRANS(SMADDL, do_muladd, a, true, false, MO_SL)
+TRANS(SMSUBL, do_muladd, a, true, true, MO_SL)
+TRANS(UMADDL, do_muladd, a, true, false, MO_UL)
+TRANS(UMSUBL, do_muladd, a, true, true, MO_UL)
+
 /* Add/subtract (with carry)
  *  31 30 29 28 27 26 25 24 23 22 21  20  16  15       10  9    5 4   0
  * +--+--+--+------------------------+------+-------------+------+-----+
@@ -8364,13 +8334,10 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
         disas_cond_select(s, insn);
         break;
 
-    case 0x8 ... 0xf: /* (3 source) */
-        disas_data_proc_3src(s, insn);
-        break;
-
     default:
     do_unallocated:
     case 0x6: /* Data-processing */
+    case 0x8 ... 0xf: /* (3 source) */
         unallocated_encoding(s);
         break;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 4d422a7191..c6609749ae 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -753,6 +753,22 @@ SUBS_ext        . 11 01011001 ..... ... ... ..... .....  @addsub_ext
 # Conditional select
 # Data Processing (3-source)
 
+&rrrr           rd rn rm ra
+@rrrr           . .. ........ rm:5 . ra:5 rn:5 rd:5     &rrrr
+
+MADD_w          0 00 11011000 ..... 0 ..... ..... ..... @rrrr
+MSUB_w          0 00 11011000 ..... 1 ..... ..... ..... @rrrr
+MADD_x          1 00 11011000 ..... 0 ..... ..... ..... @rrrr
+MSUB_x          1 00 11011000 ..... 1 ..... ..... ..... @rrrr
+
+SMADDL          1 00 11011001 ..... 0 ..... ..... ..... @rrrr
+SMSUBL          1 00 11011001 ..... 1 ..... ..... ..... @rrrr
+UMADDL          1 00 11011101 ..... 0 ..... ..... ..... @rrrr
+UMSUBL          1 00 11011101 ..... 1 ..... ..... ..... @rrrr
+
+SMULH           1 00 11011010 ..... 0 11111 ..... ..... @rrr
+UMULH           1 00 11011110 ..... 0 11111 ..... ..... @rrr
+
 ### Cryptographic AES
 
 AESE            01001110 00 10100 00100 10 ..... .....  @r2r_q1e0
-- 
2.43.0


