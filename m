Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10309D49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlWz-0001T9-NX; Sun, 01 Dec 2024 10:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWw-0001Q7-5k
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:38 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWt-0004Gf-R6
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:37 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-71d554dedc6so1182482a34.1
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065595; x=1733670395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LhcI9CHWaJnBplFy/u43VHAC0yxtJNM95MVoOzb1/F0=;
 b=TikZLvL24MH4YlgB+UFKlX8+BCTXZWHMZGiPZSpzHTemz2E/JT7P/lelkGCTViZh1b
 f+cIai1904X189vQ94KUB0iRGQCZKTPgjEkWtPuFBYn2OdaZiM3j+WUJTsBmZI2+4VgP
 yR/9VylY2tlJwoQ+17hgyWGVDaxVTcRIbWDNzpzmect3M4a3IKiZ85BT+hZrvFuvEs0W
 3ZoEhknCxjXlwjQ5hCef9uxviRZOPPuLonZOYKQeGpFsf25EF/09p0GCZc6X1bhlyKfz
 vyzRCCD6Ouv2g28vbn9aAzUBzf1PBRxZBZEfnnm7FIxilXgoztotqP1eV4FpYKD7OpMJ
 A02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065595; x=1733670395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LhcI9CHWaJnBplFy/u43VHAC0yxtJNM95MVoOzb1/F0=;
 b=NTDxvdrfrL/2ZRtrLhD2u+E5TbiGXfRXYCi4hrL4xkFOrb8Z4jr58dy3Vm0KtI76+B
 R0hOi7uHX5mGx8GHX4JCGfXrh4a7euAekxgvPUrZR2kYV57Zh/FYsNEF94f9Y4nwPTWU
 6sEBjQ5UrEwu++h9P0m+kohLyi6FkghbZ9iYncWWPG81R8xMmCBmWUs3VpatKqrvcD9v
 hBk2HiQKIa+wUP2r7ptdegwXYVe3O7SRlMmGr3xLSaPCS5d9zmPqfElNogAuwh7IdlWj
 04NCOCrahLQ883/lH2M+22YiakL8iqI9RJglCNgvs5sg4iLw7T7YyPyPi3idbPU6yKVS
 Y7vw==
X-Gm-Message-State: AOJu0YwnQRGD9izZf1evMYWyioFrHUX7Ve5iIDqjcjlRmYdEaItRbIyG
 D7yM6PLqlkpvB3C69oinGtYzBO7y3aV5cAMwBFkmsWicTewDiDn5TniLgiyu+duyq6ewReBu2ki
 IBlQ=
X-Gm-Gg: ASbGnctCqDtkZkpjN2KftVyN5VWoWmh/MlKgTaPYxKYSbJLB0u859H83Hx+umZjJCLE
 qNVuL3X0f3fs28Ye4h5GCA+ZlhmsvbS/24GmZh1B9ZO1qm7aE9CpUaFfx1HxM7tM4FATqL5pHMI
 3W35Ykg5X1kFViDUjaGY0A7OB/qrWP0qrBMKUKgQgNlX9u+u3XBpnGjcXY9mhkN5L6YXZdrGBKo
 tMCu+OVlXzrXHI1uTy0jE3tbEYQlzTUJYJmX8P9D7euiqa8e4u9o2DNei0vKtvxtLeMjpJry7po
 IQpiCaCYO0NXQOad2tYLvzy0NsEG5L1pTBBL
X-Google-Smtp-Source: AGHT+IEAAdZwzOpHq3iXEr0HE22iXaSyWrGQpjyem0pVAezzjVlNqJN8Vam8aaJ80uCCXtoAuq2eUg==
X-Received: by 2002:a05:6830:44a2:b0:71d:5b13:20e3 with SMTP id
 46e09a7af769-71d65d034f2mr15914207a34.25.1733065594712; 
 Sun, 01 Dec 2024 07:06:34 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 22/67] target/arm: Convert FCMP, FCMPE, FCCMP,
 FCCMPE to decodetree
Date: Sun,  1 Dec 2024 09:05:21 -0600
Message-ID: <20241201150607.12812-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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
 target/arm/tcg/translate-a64.c | 287 +++++++++++++--------------------
 target/arm/tcg/a64.decode      |   8 +
 2 files changed, 116 insertions(+), 179 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 4611ae4ade..2d3566e45c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6888,6 +6888,110 @@ static bool trans_FMOVI_s(DisasContext *s, arg_FMOVI_s *a)
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
+    int check;
+
+    if (a->z && a->rm != 0) {
+        return false;
+    }
+    check = fp_access_check_scalar_hsd(s, a->esz);
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
@@ -8183,174 +8287,6 @@ static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
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
@@ -9107,16 +9043,9 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
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
@@ -9127,7 +9056,7 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
                 break;
             case 1: /* [15:12] == xx10 */
                 /* Floating point compare */
-                disas_fp_compare(s, insn);
+                unallocated_encoding(s); /* in decodetree */
                 break;
             case 2: /* [15:12] == x100 */
                 /* Floating point data-processing (1 source) */
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 3bc2767106..928e69da69 100644
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
-- 
2.43.0


