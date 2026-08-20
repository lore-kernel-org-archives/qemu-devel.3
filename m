Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B5FC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtjZ-0001Gw-CS; Wed, 19 Aug 2026 23:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjX-00015b-8r
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:27 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjU-00043X-Tv
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:27 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-cbb8b54fcf8so1426426a12.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197583; x=1787802383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RNFgnM0t7+t0Hez1CnQLXLKNEeRTeeGqtk2q17G/SNg=;
 b=dCuv70Kz6G9XLA6fA1H/kxO/tcOtI2pkfEoOX44J3lYk1RGfcqX8eqtCCNA+/fD5Xd
 3LOTjvz0QXisIgDZUGkX/WiMs+jquB1QyGnQdW8JWNIKvOeYyqKX+4JzeF2B+NkV+Rv8
 RaCwzTZexSCqtsXJbgJb2F/+NvvR4X41FS6OloMxQ2KQpWRjNCDwLYLvdyVA+lgLGLJB
 NRCq63X7SFbFU1kfG1cLOlQlRUKxxGRLDb7VjlG/fFviEbQJFPrtP6b+3muBnMS53hCp
 ddRBFylGno3VNLQD/7WXWN3KUVSmeqQWeiu9NJ+T5TEaJMf8iL0VKpMztD/4TO0KoGt3
 jGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197583; x=1787802383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RNFgnM0t7+t0Hez1CnQLXLKNEeRTeeGqtk2q17G/SNg=;
 b=nA7iJGa+BHo6FKYdvwkLdTCcvsnCTGbMg5FLCwBp147NVPc8DwnjzITKx061vOKe2a
 X6AnXN3XWNbdSY+lH+P9Lke13BQCDC61BpFuy9LF2uAWvyZM8psGJtzgPS8aLAd5IKmF
 9uckpHIOfVsHJjoqQq+26VR2rPY64jixbb7wwCP/K9AQ3sZbeIfQE0Dcp8Nx4fKwEocg
 3keU+KAQtqiY6GuXh1ugc8lmXzbbgfINATt56B6uqqNpZWEGftbI+JnOt0Dh+FTLWjc1
 M64hBex7xDK3H0ns9PVo3VmMWQBunGiVtqryMV3pp+yhpoKi3g+VMMr03qvmzyVp3Qln
 0bXQ==
X-Gm-Message-State: AOJu0YwD+b1irrKSzgigU9lNuMVa11X2YktMLz7g14bX4n/DDh4LEeWf
 fDQdx7M6pryqEE874wLcIT49MBdSjlV8usVVkGameQ2O8nerPNA/QeOCn16dWg==
X-Gm-Gg: AR+sD12v1fCjSJNZfXPIcTTwpfjVmskGVtssW739uS7YN6XVYfc4+hb0PxumYeTHRJq
 UhX/s3ogSVNMZcvxren/BQSF/2RukDr+TVmap9PSr7bQKseRj/U2czSw4YTtRFrqe9NWN6TXr3N
 2kX5BR3dCCI+6x2rYdlTGrzmSMLt1lVIf5YD5FVosq+/kjEr21Q2i7nZnqY2tQnsOFT+MmZ5GdF
 BBQD8qud2FXv+aEoiehrUa3BfWOk3cCrwMlh5W3780AKtW/1jZ3EGStzatGDgTfOrfKS4Oq7qlJ
 0A2Fcdh63JNOtodo7sMm3jm/vnzh8T0+0hO/pnJTLTEmy03PCTF3zDlzjpL00aZHxNutbqFTBsn
 IbYe3SAkCAQDSYiObC4mo1L9hbV68YXWZspe3V0/5AlE9Jg2rLB9kzmoXoCFB6yCOdecpmkWO+O
 HS6/8ShDE8TkGJu/wUnbzsWthYrFWUfYHTgNoupI3Ixom42kmzAS3SRWyk6OeZRh6ZQbIfzADfw
 y7K2g==
X-Received: by 2002:a05:6a21:9984:b0:3c3:b57b:6291 with SMTP id
 adf61e73a8af0-3cd0132c618mr15437140637.18.1787197583393; 
 Wed, 19 Aug 2026 20:46:23 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:46:22 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: TANG Tiancheng <lyndra@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 33/93] disas/riscv: Use extract helpers for operand fields
Date: Thu, 20 Aug 2026 13:43:30 +1000
Message-ID: <20260820034430.1186695-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: TANG Tiancheng <lyndra@linux.alibaba.com>

Replace shift-based operand extraction with extract32() and sextract32().
For signed immediates, use sextract32() on the field that carries the sign
bit and combine it with the remaining extract32() fields.

The RISC-V disassembler currently follows target/riscv/internals.h:
insn_len() and decodes only 16-bit or 32-bit instruction lengths, so the
converted fields are all in the low 32 bits of rv_inst.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260703-b4-disas-xthead-fix-riscv-next-v4-5-84c566330bc7@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 214 +++++++++++++++++++++++++-------------------------
 1 file changed, 107 insertions(+), 107 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 82b962dc71..2ba0a6a73a 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4202,82 +4202,82 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
 
 static uint32_t operand_rd(rv_inst inst)
 {
-    return (inst << 52) >> 59;
+    return extract32(inst, 7, 5);
 }
 
 static uint32_t operand_rs1(rv_inst inst)
 {
-    return (inst << 44) >> 59;
+    return extract32(inst, 15, 5);
 }
 
 static uint32_t operand_rs2(rv_inst inst)
 {
-    return (inst << 39) >> 59;
+    return extract32(inst, 20, 5);
 }
 
 static uint32_t operand_rs3(rv_inst inst)
 {
-    return (inst << 32) >> 59;
+    return extract32(inst, 27, 5);
 }
 
 static uint32_t operand_aq(rv_inst inst)
 {
-    return (inst << 37) >> 63;
+    return extract32(inst, 26, 1);
 }
 
 static uint32_t operand_rl(rv_inst inst)
 {
-    return (inst << 38) >> 63;
+    return extract32(inst, 25, 1);
 }
 
 static uint32_t operand_pred(rv_inst inst)
 {
-    return (inst << 36) >> 60;
+    return extract32(inst, 24, 4);
 }
 
 static uint32_t operand_succ(rv_inst inst)
 {
-    return (inst << 40) >> 60;
+    return extract32(inst, 20, 4);
 }
 
 static uint32_t operand_rm(rv_inst inst)
 {
-    return (inst << 49) >> 61;
+    return extract32(inst, 12, 3);
 }
 
 static uint32_t operand_shamt5(rv_inst inst)
 {
-    return (inst << 39) >> 59;
+    return extract32(inst, 20, 5);
 }
 
 static uint32_t operand_shamt6(rv_inst inst)
 {
-    return (inst << 38) >> 58;
+    return extract32(inst, 20, 6);
 }
 
 static uint32_t operand_shamt7(rv_inst inst)
 {
-    return (inst << 37) >> 57;
+    return extract32(inst, 20, 7);
 }
 
 static uint32_t operand_crdq(rv_inst inst)
 {
-    return (inst << 59) >> 61;
+    return extract32(inst, 2, 3);
 }
 
 static uint32_t operand_crs1q(rv_inst inst)
 {
-    return (inst << 54) >> 61;
+    return extract32(inst, 7, 3);
 }
 
 static uint32_t operand_crs1rdq(rv_inst inst)
 {
-    return (inst << 54) >> 61;
+    return extract32(inst, 7, 3);
 }
 
 static uint32_t operand_crs2q(rv_inst inst)
 {
-    return (inst << 59) >> 61;
+    return extract32(inst, 2, 3);
 }
 
 static uint32_t calculate_xreg(uint32_t sreg)
@@ -4287,80 +4287,80 @@ static uint32_t calculate_xreg(uint32_t sreg)
 
 static uint32_t operand_sreg1(rv_inst inst)
 {
-    return calculate_xreg((inst << 54) >> 61);
+    return calculate_xreg(extract32(inst, 7, 3));
 }
 
 static uint32_t operand_sreg2(rv_inst inst)
 {
-    return calculate_xreg((inst << 59) >> 61);
+    return calculate_xreg(extract32(inst, 2, 3));
 }
 
 static uint32_t operand_crd(rv_inst inst)
 {
-    return (inst << 52) >> 59;
+    return extract32(inst, 7, 5);
 }
 
 static uint32_t operand_crs1(rv_inst inst)
 {
-    return (inst << 52) >> 59;
+    return extract32(inst, 7, 5);
 }
 
 static uint32_t operand_crs1rd(rv_inst inst)
 {
-    return (inst << 52) >> 59;
+    return extract32(inst, 7, 5);
 }
 
 static uint32_t operand_crs2(rv_inst inst)
 {
-    return (inst << 57) >> 59;
+    return extract32(inst, 2, 5);
 }
 
 static uint32_t operand_cimmsh5(rv_inst inst)
 {
-    return (inst << 57) >> 59;
+    return extract32(inst, 2, 5);
 }
 
 static uint32_t operand_csr12(rv_inst inst)
 {
-    return (inst << 32) >> 52;
+    return extract32(inst, 20, 12);
 }
 
 static int32_t operand_imm12(rv_inst inst)
 {
-    return ((int64_t)inst << 32) >> 52;
+    return sextract32(inst, 20, 12);
 }
 
 static int32_t operand_imm20(rv_inst inst)
 {
-    return (((int64_t)inst << 32) >> 44) << 12;
+    return sextract32(inst, 12, 20) << 12;
 }
 
 static int32_t operand_jimm20(rv_inst inst)
 {
-    return (((int64_t)inst << 32) >> 63) << 20 |
-        ((inst << 33) >> 54) << 1 |
-        ((inst << 43) >> 63) << 11 |
-        ((inst << 44) >> 56) << 12;
+    return sextract32(inst, 31, 1) << 20 |
+        extract32(inst, 21, 10) << 1 |
+        extract32(inst, 20, 1) << 11 |
+        extract32(inst, 12, 8) << 12;
 }
 
 static int32_t operand_simm12(rv_inst inst)
 {
-    return (((int64_t)inst << 32) >> 57) << 5 |
-        (inst << 52) >> 59;
+    return sextract32(inst, 25, 7) << 5 |
+        extract32(inst, 7, 5);
 }
 
 static int32_t operand_sbimm12(rv_inst inst)
 {
-    return (((int64_t)inst << 32) >> 63) << 12 |
-        ((inst << 33) >> 58) << 5 |
-        ((inst << 52) >> 60) << 1 |
-        ((inst << 56) >> 63) << 11;
+    return sextract32(inst, 31, 1) << 12 |
+        extract32(inst, 25, 6) << 5 |
+        extract32(inst, 8, 4) << 1 |
+        extract32(inst, 7, 1) << 11;
 }
 
 static uint32_t operand_cimmshl6(rv_inst inst, rv_isa isa)
 {
-    int imm = ((inst << 51) >> 63) << 5 |
-        (inst << 57) >> 59;
+    int imm = extract32(inst, 12, 1) << 5 |
+        extract32(inst, 2, 5);
     if (isa == rv128) {
         imm = imm ? imm : 64;
     }
@@ -4369,8 +4369,8 @@ static uint32_t operand_cimmshl6(rv_inst inst, rv_isa isa)
 
 static uint32_t operand_cimmshr6(rv_inst inst, rv_isa isa)
 {
-    int imm = ((inst << 51) >> 63) << 5 |
-        (inst << 57) >> 59;
+    int imm = extract32(inst, 12, 1) << 5 |
+        extract32(inst, 2, 5);
     if (isa == rv128) {
         imm = imm | (imm & 32) << 1;
         imm = imm ? imm : 64;
@@ -4380,116 +4380,116 @@ static uint32_t operand_cimmshr6(rv_inst inst, rv_isa isa)
 
 static int32_t operand_cimmi(rv_inst inst)
 {
-    return (((int64_t)inst << 51) >> 63) << 5 |
-        (inst << 57) >> 59;
+    return sextract32(inst, 12, 1) << 5 |
+        extract32(inst, 2, 5);
 }
 
 static int32_t operand_cimmui(rv_inst inst)
 {
-    return (((int64_t)inst << 51) >> 63) << 17 |
-        ((inst << 57) >> 59) << 12;
+    return sextract32(inst, 12, 1) << 17 |
+        extract32(inst, 2, 5) << 12;
 }
 
 static uint32_t operand_cimmlwsp(rv_inst inst)
 {
-    return ((inst << 51) >> 63) << 5 |
-        ((inst << 57) >> 61) << 2 |
-        ((inst << 60) >> 62) << 6;
+    return extract32(inst, 12, 1) << 5 |
+        extract32(inst, 4, 3) << 2 |
+        extract32(inst, 2, 2) << 6;
 }
 
 static uint32_t operand_cimmldsp(rv_inst inst)
 {
-    return ((inst << 51) >> 63) << 5 |
-        ((inst << 57) >> 62) << 3 |
-        ((inst << 59) >> 61) << 6;
+    return extract32(inst, 12, 1) << 5 |
+        extract32(inst, 5, 2) << 3 |
+        extract32(inst, 2, 3) << 6;
 }
 
 static uint32_t operand_cimmlqsp(rv_inst inst)
 {
-    return ((inst << 51) >> 63) << 5 |
-        ((inst << 57) >> 63) << 4 |
-        ((inst << 58) >> 60) << 6;
+    return extract32(inst, 12, 1) << 5 |
+        extract32(inst, 6, 1) << 4 |
+        extract32(inst, 2, 4) << 6;
 }
 
 static int32_t operand_cimm16sp(rv_inst inst)
 {
-    return (((int64_t)inst << 51) >> 63) << 9 |
-        ((inst << 57) >> 63) << 4 |
-        ((inst << 58) >> 63) << 6 |
-        ((inst << 59) >> 62) << 7 |
-        ((inst << 61) >> 63) << 5;
+    return sextract32(inst, 12, 1) << 9 |
+        extract32(inst, 6, 1) << 4 |
+        extract32(inst, 5, 1) << 6 |
+        extract32(inst, 3, 2) << 7 |
+        extract32(inst, 2, 1) << 5;
 }
 
 static int32_t operand_cimmj(rv_inst inst)
 {
-    return (((int64_t)inst << 51) >> 63) << 11 |
-        ((inst << 52) >> 63) << 4 |
-        ((inst << 53) >> 62) << 8 |
-        ((inst << 55) >> 63) << 10 |
-        ((inst << 56) >> 63) << 6 |
-        ((inst << 57) >> 63) << 7 |
-        ((inst << 58) >> 61) << 1 |
-        ((inst << 61) >> 63) << 5;
+    return sextract32(inst, 12, 1) << 11 |
+        extract32(inst, 11, 1) << 4 |
+        extract32(inst, 9, 2) << 8 |
+        extract32(inst, 8, 1) << 10 |
+        extract32(inst, 7, 1) << 6 |
+        extract32(inst, 6, 1) << 7 |
+        extract32(inst, 3, 3) << 1 |
+        extract32(inst, 2, 1) << 5;
 }
 
 static int32_t operand_cimmb(rv_inst inst)
 {
-    return (((int64_t)inst << 51) >> 63) << 8 |
-        ((inst << 52) >> 62) << 3 |
-        ((inst << 57) >> 62) << 6 |
-        ((inst << 59) >> 62) << 1 |
-        ((inst << 61) >> 63) << 5;
+    return sextract32(inst, 12, 1) << 8 |
+        extract32(inst, 10, 2) << 3 |
+        extract32(inst, 5, 2) << 6 |
+        extract32(inst, 3, 2) << 1 |
+        extract32(inst, 2, 1) << 5;
 }
 
 static uint32_t operand_cimmswsp(rv_inst inst)
 {
-    return ((inst << 51) >> 60) << 2 |
-        ((inst << 55) >> 62) << 6;
+    return extract32(inst, 9, 4) << 2 |
+        extract32(inst, 7, 2) << 6;
 }
 
 static uint32_t operand_cimmsdsp(rv_inst inst)
 {
-    return ((inst << 51) >> 61) << 3 |
-        ((inst << 54) >> 61) << 6;
+    return extract32(inst, 10, 3) << 3 |
+        extract32(inst, 7, 3) << 6;
 }
 
 static uint32_t operand_cimmsqsp(rv_inst inst)
 {
-    return ((inst << 51) >> 62) << 4 |
-        ((inst << 53) >> 60) << 6;
+    return extract32(inst, 11, 2) << 4 |
+        extract32(inst, 7, 4) << 6;
 }
 
 static uint32_t operand_cimm4spn(rv_inst inst)
 {
-    return ((inst << 51) >> 62) << 4 |
-        ((inst << 53) >> 60) << 6 |
-        ((inst << 57) >> 63) << 2 |
-        ((inst << 58) >> 63) << 3;
+    return extract32(inst, 11, 2) << 4 |
+        extract32(inst, 7, 4) << 6 |
+        extract32(inst, 6, 1) << 2 |
+        extract32(inst, 5, 1) << 3;
 }
 
 static uint32_t operand_cimmw(rv_inst inst)
 {
-    return ((inst << 51) >> 61) << 3 |
-        ((inst << 57) >> 63) << 2 |
-        ((inst << 58) >> 63) << 6;
+    return extract32(inst, 10, 3) << 3 |
+        extract32(inst, 6, 1) << 2 |
+        extract32(inst, 5, 1) << 6;
 }
 
 static uint32_t operand_cimmd(rv_inst inst)
 {
-    return ((inst << 51) >> 61) << 3 |
-        ((inst << 57) >> 62) << 6;
+    return extract32(inst, 10, 3) << 3 |
+        extract32(inst, 5, 2) << 6;
 }
 
 static uint32_t operand_cimmq(rv_inst inst)
 {
-    return ((inst << 51) >> 62) << 4 |
-        ((inst << 53) >> 63) << 8 |
-        ((inst << 57) >> 62) << 6;
+    return extract32(inst, 11, 2) << 4 |
+        extract32(inst, 10, 1) << 8 |
+        extract32(inst, 5, 2) << 6;
 }
 
 static int32_t operand_vimm(rv_inst inst)
 {
-    return (int64_t)(inst << 44) >> 59;
+    return sextract32(inst, 15, 5);
 }
 
 static uint32_t operand_vuimm(rv_inst inst)
@@ -4499,54 +4499,54 @@ static uint32_t operand_vuimm(rv_inst inst)
 
 static uint32_t operand_vzimm11(rv_inst inst)
 {
-    return (inst << 33) >> 53;
+    return extract32(inst, 20, 11);
 }
 
 static uint32_t operand_vzimm10(rv_inst inst)
 {
-    return (inst << 34) >> 54;
+    return extract32(inst, 20, 10);
 }
 
 static uint32_t operand_vzimm6(rv_inst inst)
 {
-    return ((inst << 37) >> 63) << 5 |
-        ((inst << 44) >> 59);
+    return extract32(inst, 26, 1) << 5 |
+        extract32(inst, 15, 5);
 }
 
 static uint32_t operand_bs(rv_inst inst)
 {
-    return (inst << 32) >> 62;
+    return extract32(inst, 30, 2);
 }
 
 static uint32_t operand_rnum(rv_inst inst)
 {
-    return (inst << 40) >> 60;
+    return extract32(inst, 20, 4);
 }
 
 static uint32_t operand_vm(rv_inst inst)
 {
-    return (inst << 38) >> 63;
+    return extract32(inst, 25, 1);
 }
 
 static uint32_t operand_uimm_c_lb(rv_inst inst)
 {
-    return (((inst << 58) >> 63) << 1) |
-        ((inst << 57) >> 63);
+    return extract32(inst, 5, 1) << 1 |
+        extract32(inst, 6, 1);
 }
 
 static uint32_t operand_uimm_c_lh(rv_inst inst)
 {
-    return (((inst << 58) >> 63) << 1);
+    return extract32(inst, 5, 1) << 1;
 }
 
 static uint32_t operand_zcmp_spimm(rv_inst inst)
 {
-    return ((inst << 60) >> 62) << 4;
+    return extract32(inst, 2, 2) << 4;
 }
 
 static uint32_t operand_zcmp_rlist(rv_inst inst)
 {
-    return ((inst << 56) >> 60);
+    return extract32(inst, 4, 4);
 }
 
 static uint32_t operand_imm6(rv_inst inst)
@@ -4556,17 +4556,17 @@ static uint32_t operand_imm6(rv_inst inst)
 
 static uint32_t operand_imm2(rv_inst inst)
 {
-    return (inst << 37) >> 62;
+    return extract32(inst, 25, 2);
 }
 
 static uint32_t operand_immh(rv_inst inst)
 {
-    return (inst << 32) >> 58;
+    return extract32(inst, 26, 6);
 }
 
 static uint32_t operand_imml(rv_inst inst)
 {
-    return (inst << 38) >> 58;
+    return extract32(inst, 20, 6);
 }
 
 static uint32_t calculate_stack_adj(rv_isa isa, uint32_t rlist, uint32_t spimm)
@@ -4585,12 +4585,12 @@ static uint32_t operand_zcmp_stack_adj(rv_inst inst, rv_isa isa)
 
 static uint32_t operand_tbl_index(rv_inst inst)
 {
-    return ((inst << 54) >> 56);
+    return extract32(inst, 2, 8);
 }
 
 static uint32_t operand_lpl(rv_inst inst)
 {
-    return inst >> 12;
+    return extract32(inst, 12, 20);
 }
 
 /* decode operands */
-- 
2.54.0


