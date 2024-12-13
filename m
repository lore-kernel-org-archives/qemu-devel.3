Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D06E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9YG-0000no-Ed; Fri, 13 Dec 2024 12:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XA-00072D-98
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:00 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9X6-0001Wi-R8
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:59 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3862df95f92so1072337f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111175; x=1734715975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HvKVN0eNYR2Ji3llX0JaJuzMLboGsS744lfcra4L1yM=;
 b=SgQoq/iDHyThh/h+fJEpTAAbM7jnYNkY9Z0Ol8Jes/PH5UuHrjTGHTVk5sw+lP7FpG
 3VTWh30LCl0/pHsReGK+hKt1hpYiouJua96JwuZRKJfz9+HH8sJ2QQvQ3aTTVaNCr9BP
 hybfK28hHuKgdVSVasFSmqZ0VudAtewWjcu7s6E/FamX2FTcl9pYVZCmYirmhxTSQbuM
 By89KXTGyAICqkhw//fJDp37HwJfOihDlsz5A45SGL6+ZiS40Xtn71GLsZVjcnI+04V6
 h65OGk3h9BtpQx+tf/7+UsEHUjBlKFKgJc/p1TvdSoaIAZ7d9VEO0Lgbas+V6abHrSxH
 KXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111175; x=1734715975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HvKVN0eNYR2Ji3llX0JaJuzMLboGsS744lfcra4L1yM=;
 b=cGJo80eWsKjkP69wo9siW0PjhxRXrRUtWjYicWL2lADmuYazeXLEa7XKj68wq4EkpI
 gieC/rObUgupbjyo7hAoWdr+cYWyxZLv84gSRrkegjlU1eEp7YkgFcvG+en/dp9cR+b6
 0Rap/G/4sulw2ofc9a+EAmw2f0RFDQ2W7uJwKgVLl/DtfAqBYM0bh3XRG8xrrMhgQl+n
 oMSl52euDybqiKLbZbMrXHZ6W4SHfRh10wR3vXRS53hNrFKhguYbqoOqZ1nNhzWVEcVi
 RRjjPZr2WWv7glRO4uxAKhp6jPxqaM+uXqdOWcGiOJrB0l5TWIQWttT1KulfpylAwxFu
 T1DA==
X-Gm-Message-State: AOJu0YzgOAjJdjU/f9GXlDq0dXDzTj/aUBvFJB+ANewgJaPeOMaVX0fa
 /sneOIsIjGdqDYmD7kHllOBbEEtMyGCFsacO6wTTLX7uSPgPYmXBmA73MmEyzg+aVa6YcBovHK0
 +
X-Gm-Gg: ASbGncvD9cIyTl3+Q7caY/QGY0eKPHqbJBe1ZqrcnAzxywwLMU7XK4MXwCR7mu41/vW
 WEi0DuZ9or5AqdHPTOGit696rNFhmjrp2DCAdYXlkZZsLQwoItm8VusqpLLz3jWZqIz3kIDoSRd
 o6qKNEpg0dF9wUkgPERUmsRFhZWXrvjThU4x5iNfUpCB9yU+86LDfJy+sQGZ9axbwu6FQG+VDRd
 mfEy/3+Gud7Uyax8ogdmUbjVxBLnsQn6mWMyzWQuupT1xAPYbH05SbXcdLJbg==
X-Google-Smtp-Source: AGHT+IHbOZ+BrwmDUEILJnAhDbl4ofPHmdKKjaS5jSYeGBCkv/xv+cdl4L0DR2Lw6J2/1Cn5WpEWyg==
X-Received: by 2002:a5d:6801:0:b0:388:c75c:e839 with SMTP id
 ffacd0b85a97d-388c75ce895mr527886f8f.42.1734111174987; 
 Fri, 13 Dec 2024 09:32:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/85] target/arm: Convert FCMP, FCMPE, FCCMP,
 FCCMPE to decodetree
Date: Fri, 13 Dec 2024 17:31:26 +0000
Message-Id: <20241213173229.3308926-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-23-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |   8 +
 target/arm/tcg/translate-a64.c | 283 ++++++++++++---------------------
 2 files changed, 112 insertions(+), 179 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 56708467681..7868b1cb241 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1325,6 +1325,14 @@ FMINV_s         0110 1110 10 11000 01111 10 ..... .....     @rr_q1e2
 
 FMOVI_s         0001 1110 .. 1 imm:8 100 00000 rd:5         esz=%esz_hsd
 
+# Floating-point Compare
+
+FCMP            00011110 .. 1 rm:5 001000 rn:5 e:1 z:1 000  esz=%esz_hsd
+
+# Floating-point Conditional Compare
+
+FCCMP           00011110 .. 1 rm:5 cond:4 01 rn:5 e:1 nzcv:4  esz=%esz_hsd
+
 # Advanced SIMD Modified Immediate / Shift by Immediate
 
 %abcdefgh       16:3 5:5
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 4611ae4ade9..a99f3d0d135 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6888,6 +6888,106 @@ static bool trans_FMOVI_s(DisasContext *s, arg_FMOVI_s *a)
     return true;
 }
 
+/*
+ * Floating point compare, conditional compare
+ */
+
+static void handle_fp_compare(DisasContext *s, int size,
+                              unsigned int rn, unsigned int rm,
+                              bool cmp_with_zero, bool signal_all_nans)
+{
+    TCGv_i64 tcg_flags = tcg_temp_new_i64();
+    TCGv_ptr fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+
+    if (size == MO_64) {
+        TCGv_i64 tcg_vn, tcg_vm;
+
+        tcg_vn = read_fp_dreg(s, rn);
+        if (cmp_with_zero) {
+            tcg_vm = tcg_constant_i64(0);
+        } else {
+            tcg_vm = read_fp_dreg(s, rm);
+        }
+        if (signal_all_nans) {
+            gen_helper_vfp_cmped_a64(tcg_flags, tcg_vn, tcg_vm, fpst);
+        } else {
+            gen_helper_vfp_cmpd_a64(tcg_flags, tcg_vn, tcg_vm, fpst);
+        }
+    } else {
+        TCGv_i32 tcg_vn = tcg_temp_new_i32();
+        TCGv_i32 tcg_vm = tcg_temp_new_i32();
+
+        read_vec_element_i32(s, tcg_vn, rn, 0, size);
+        if (cmp_with_zero) {
+            tcg_gen_movi_i32(tcg_vm, 0);
+        } else {
+            read_vec_element_i32(s, tcg_vm, rm, 0, size);
+        }
+
+        switch (size) {
+        case MO_32:
+            if (signal_all_nans) {
+                gen_helper_vfp_cmpes_a64(tcg_flags, tcg_vn, tcg_vm, fpst);
+            } else {
+                gen_helper_vfp_cmps_a64(tcg_flags, tcg_vn, tcg_vm, fpst);
+            }
+            break;
+        case MO_16:
+            if (signal_all_nans) {
+                gen_helper_vfp_cmpeh_a64(tcg_flags, tcg_vn, tcg_vm, fpst);
+            } else {
+                gen_helper_vfp_cmph_a64(tcg_flags, tcg_vn, tcg_vm, fpst);
+            }
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    gen_set_nzcv(tcg_flags);
+}
+
+/* FCMP, FCMPE */
+static bool trans_FCMP(DisasContext *s, arg_FCMP *a)
+{
+    int check = fp_access_check_scalar_hsd(s, a->esz);
+
+    if (check <= 0) {
+        return check == 0;
+    }
+
+    handle_fp_compare(s, a->esz, a->rn, a->rm, a->z, a->e);
+    return true;
+}
+
+/* FCCMP, FCCMPE */
+static bool trans_FCCMP(DisasContext *s, arg_FCCMP *a)
+{
+    TCGLabel *label_continue = NULL;
+    int check = fp_access_check_scalar_hsd(s, a->esz);
+
+    if (check <= 0) {
+        return check == 0;
+    }
+
+    if (a->cond < 0x0e) { /* not always */
+        TCGLabel *label_match = gen_new_label();
+        label_continue = gen_new_label();
+        arm_gen_test_cc(a->cond, label_match);
+        /* nomatch: */
+        gen_set_nzcv(tcg_constant_i64(a->nzcv << 28));
+        tcg_gen_br(label_continue);
+        gen_set_label(label_match);
+    }
+
+    handle_fp_compare(s, a->esz, a->rn, a->rm, false, a->e);
+
+    if (label_continue) {
+        gen_set_label(label_continue);
+    }
+    return true;
+}
+
 /*
  * Advanced SIMD Modified Immediate
  */
@@ -8183,174 +8283,6 @@ static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
     return true;
 }
 
-static void handle_fp_compare(DisasContext *s, int size,
-                              unsigned int rn, unsigned int rm,
-                              bool cmp_with_zero, bool signal_all_nans)
-{
-    TCGv_i64 tcg_flags = tcg_temp_new_i64();
-    TCGv_ptr fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
-
-    if (size == MO_64) {
-        TCGv_i64 tcg_vn, tcg_vm;
-
-        tcg_vn = read_fp_dreg(s, rn);
-        if (cmp_with_zero) {
-            tcg_vm = tcg_constant_i64(0);
-        } else {
-            tcg_vm = read_fp_dreg(s, rm);
-        }
-        if (signal_all_nans) {
-            gen_helper_vfp_cmped_a64(tcg_flags, tcg_vn, tcg_vm, fpst);
-        } else {
-            gen_helper_vfp_cmpd_a64(tcg_flags, tcg_vn, tcg_vm, fpst);
-        }
-    } else {
-        TCGv_i32 tcg_vn = tcg_temp_new_i32();
-        TCGv_i32 tcg_vm = tcg_temp_new_i32();
-
-        read_vec_element_i32(s, tcg_vn, rn, 0, size);
-        if (cmp_with_zero) {
-            tcg_gen_movi_i32(tcg_vm, 0);
-        } else {
-            read_vec_element_i32(s, tcg_vm, rm, 0, size);
-        }
-
-        switch (size) {
-        case MO_32:
-            if (signal_all_nans) {
-                gen_helper_vfp_cmpes_a64(tcg_flags, tcg_vn, tcg_vm, fpst);
-            } else {
-                gen_helper_vfp_cmps_a64(tcg_flags, tcg_vn, tcg_vm, fpst);
-            }
-            break;
-        case MO_16:
-            if (signal_all_nans) {
-                gen_helper_vfp_cmpeh_a64(tcg_flags, tcg_vn, tcg_vm, fpst);
-            } else {
-                gen_helper_vfp_cmph_a64(tcg_flags, tcg_vn, tcg_vm, fpst);
-            }
-            break;
-        default:
-            g_assert_not_reached();
-        }
-    }
-
-    gen_set_nzcv(tcg_flags);
-}
-
-/* Floating point compare
- *   31  30  29 28       24 23  22  21 20  16 15 14 13  10    9    5 4     0
- * +---+---+---+-----------+------+---+------+-----+---------+------+-------+
- * | M | 0 | S | 1 1 1 1 0 | type | 1 |  Rm  | op  | 1 0 0 0 |  Rn  |  op2  |
- * +---+---+---+-----------+------+---+------+-----+---------+------+-------+
- */
-static void disas_fp_compare(DisasContext *s, uint32_t insn)
-{
-    unsigned int mos, type, rm, op, rn, opc, op2r;
-    int size;
-
-    mos = extract32(insn, 29, 3);
-    type = extract32(insn, 22, 2);
-    rm = extract32(insn, 16, 5);
-    op = extract32(insn, 14, 2);
-    rn = extract32(insn, 5, 5);
-    opc = extract32(insn, 3, 2);
-    op2r = extract32(insn, 0, 3);
-
-    if (mos || op || op2r) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (type) {
-    case 0:
-        size = MO_32;
-        break;
-    case 1:
-        size = MO_64;
-        break;
-    case 3:
-        size = MO_16;
-        if (dc_isar_feature(aa64_fp16, s)) {
-            break;
-        }
-        /* fallthru */
-    default:
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    handle_fp_compare(s, size, rn, rm, opc & 1, opc & 2);
-}
-
-/* Floating point conditional compare
- *   31  30  29 28       24 23  22  21 20  16 15  12 11 10 9    5  4   3    0
- * +---+---+---+-----------+------+---+------+------+-----+------+----+------+
- * | M | 0 | S | 1 1 1 1 0 | type | 1 |  Rm  | cond | 0 1 |  Rn  | op | nzcv |
- * +---+---+---+-----------+------+---+------+------+-----+------+----+------+
- */
-static void disas_fp_ccomp(DisasContext *s, uint32_t insn)
-{
-    unsigned int mos, type, rm, cond, rn, op, nzcv;
-    TCGLabel *label_continue = NULL;
-    int size;
-
-    mos = extract32(insn, 29, 3);
-    type = extract32(insn, 22, 2);
-    rm = extract32(insn, 16, 5);
-    cond = extract32(insn, 12, 4);
-    rn = extract32(insn, 5, 5);
-    op = extract32(insn, 4, 1);
-    nzcv = extract32(insn, 0, 4);
-
-    if (mos) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (type) {
-    case 0:
-        size = MO_32;
-        break;
-    case 1:
-        size = MO_64;
-        break;
-    case 3:
-        size = MO_16;
-        if (dc_isar_feature(aa64_fp16, s)) {
-            break;
-        }
-        /* fallthru */
-    default:
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    if (cond < 0x0e) { /* not always */
-        TCGLabel *label_match = gen_new_label();
-        label_continue = gen_new_label();
-        arm_gen_test_cc(cond, label_match);
-        /* nomatch: */
-        gen_set_nzcv(tcg_constant_i64(nzcv << 28));
-        tcg_gen_br(label_continue);
-        gen_set_label(label_match);
-    }
-
-    handle_fp_compare(s, size, rn, rm, false, op);
-
-    if (cond < 0x0e) {
-        gen_set_label(label_continue);
-    }
-}
-
 /* Floating-point data-processing (1 source) - half precision */
 static void handle_fp_1src_half(DisasContext *s, int opcode, int rd, int rn)
 {
@@ -9107,16 +9039,9 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
         disas_fp_fixed_conv(s, insn);
     } else {
         switch (extract32(insn, 10, 2)) {
-        case 1:
-            /* Floating point conditional compare */
-            disas_fp_ccomp(s, insn);
-            break;
-        case 2:
-            /* Floating point data-processing (2 source) */
-            unallocated_encoding(s); /* in decodetree */
-            break;
-        case 3:
-            /* Floating point conditional select */
+        case 1: /* Floating point conditional compare */
+        case 2: /* Floating point data-processing (2 source) */
+        case 3: /* Floating point conditional select */
             unallocated_encoding(s); /* in decodetree */
             break;
         case 0:
@@ -9127,7 +9052,7 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
                 break;
             case 1: /* [15:12] == xx10 */
                 /* Floating point compare */
-                disas_fp_compare(s, insn);
+                unallocated_encoding(s); /* in decodetree */
                 break;
             case 2: /* [15:12] == x100 */
                 /* Floating point data-processing (1 source) */
-- 
2.34.1


