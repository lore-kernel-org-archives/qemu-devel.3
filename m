Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87637C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5uFU-00034w-0v; Sun, 13 Sep 2026 20:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uFP-00033s-KR
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:36 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uFN-0006tj-NI
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:35 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccc09d65so1417716a91.3
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 17:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789344512; x=1789949312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lRKC1NjwzkFYnwd3q3kKfMylXeO+schj/guqn+zGtj0=;
 b=kibiIW+aYcHNA3DowabFwJ1mN8VMVGdBM4TIp26W7O8LhmvRFNHtVFzKlEzEPBc78X
 r3ntO3HY2og93Zd1VsRQB+YdmgC728OU1zU/T9K4IpgROhTqcLUsv7z6dul/9k2TLf+S
 1Z2tCcJ8K6NrKCxrpBBuPM1qVLG0dOKrurYNlmPFw33YN59TVrcedxWXf9jNBIvDPmS7
 No+V+FK0lwM1zkz/xS0JhPoSgWAASR3M2ohX4dhrZRBA8A05aR/QLwgUhewldP8ALq8M
 XJjQuiFwDKzJKqA6mc+zs3IwO0ZBxo8jZyntF+gyXT/qz+RERYxdrP9ueeF6ZgDXk+EK
 4zXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789344512; x=1789949312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lRKC1NjwzkFYnwd3q3kKfMylXeO+schj/guqn+zGtj0=;
 b=VqKzDemRr1g35NwI+vB8wNlhKxzy7mP3s//LfSVU9xH6D9hHgPRUAUSY3gBn3dMqN2
 sS2OPrG6Orc93xWKY0xE22MjkYttSfuKJlG02twpC20hI7cToq3zAcLQbYi5Z15iqftk
 ywjHXXIYYI1lbieM4cGbw/OAnizUXHnODFN2o5uNkMVV4nNvuEugRvFDxZNy5hZ8q1yM
 DtuXaYq8vnrJcaY/h8is387aVpmuLxL/PITiHBz8xMIlOK9DuOyREelIDuy33uUbRiBf
 Qu64ExhjoW15TKAk9Fu+opb5kSBBxZav9QSrx0WL4kNaq0W6FvlImfc1xf6su4ONkW6Y
 TLuw==
X-Gm-Message-State: AFuF++lM1wnJNTvQqkum+FGpZy/6rZE+zhiPDISFRpKpcbNp5CSJSa/L
 tXHOtGHd631TCyMo+gzJiiYZM3O85+ZB7dTpYt3P8bcShTxft41BMrcGiB7LJALBOrGpjlk/CQU
 iyAMa
X-Gm-Gg: AYBFou1a6J/1FMGEJjfGto+B8qzXMZSt1JKkbvU90NaSadNTCJAO8I8i7YIPRpeZ3Ok
 h76t1jyA3Nz/fUDtqen3Lgw8FouQPNnoCLq/2/KXfps83YGVeh5C/3mEHlGKPxkMBMGMW7RhtvR
 2VIYRPZGLp8aMkgWcimQakByg6x7H0pX0li3HrH5r/Ihkajw5POyhjFgbJQhLE/DAh5wlFqG4xf
 +l6wlEqSzjy/xHcbYTAq4vD5c57tBs9sFbxagIxNibx6ZUJvZVrsXju8Zo5Fwjai6HFweg6VbA9
 u2PdbpPQYWKflB0GtFtntH1lmSjoQQjLDPw7lXmCTRy+2VQ+urnqhaLEKRj+vv88DKv57FLyeqe
 AiONahpXi/O19VEGC+5KZ156gXg4ugFni6e9Yf2IRvZGMywBA6xQkAfI6MUFScA0+7V0grX7Xj/
 F692lQQ8ubxuO5+5N1quToPrsPfAMv0xgFEHbDNo5Hkcc51OsTQVxtKhpPqZNArM1UEeHMXp57E
 xqFPUE=
X-Received: by 2002:a17:90b:3b92:b0:392:ca3b:370a with SMTP id
 98e67ed59e1d1-39debf6b6dbmr596647a91.2.1789344512377; 
 Sun, 13 Sep 2026 17:08:32 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:1665:91c0:9a80:f870])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14382741839sm4937677c88.6.2026.09.13.17.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:08:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com, palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com,
 Alistair.Francis@wdc.com, philmd@oss.qualcomm.com
Subject: [PATCH v3 11/11] tcg/riscv64: Fall back when AUIPC pairs are out of
 range
Date: Sun, 13 Sep 2026 14:08:14 -1000
Message-ID: <20260914000814.785155-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914000814.785155-1-richard.henderson@linaro.org>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

From: Max Chou <max.chou@sifive.com>

tcg_out_movi, tcg_out_call_int, and tcg_out_ldst only check whether a
PC-relative displacement is signed 32-bit before emitting an AUIPC pair.
This does not account for rounding the signed 12-bit immediate, which
can require an unencodable positive 0x80000000 AUIPC contribution.

Validate the split and emit the pair only when it fits.

Fixes: dfa8e74f9463 ("tcg/riscv: Add the relocation functions")
Signed-off-by: Max Chou <max.chou@sifive.com>
[rth: Drop 'ret' local variables; update tcg_out_ldst too.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 54 +++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 7754bcf39f2..682d9e8320b 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -808,7 +808,7 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
 {
     tcg_target_long tmp;
     int32_t lo, hi;
-    int shift, ret;
+    int shift;
 
     if (type == TCG_TYPE_I32) {
         val = (int32_t)val;
@@ -829,12 +829,9 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
         return;
     }
 
-    tmp = tcg_pcrel_diff(s, (void *)val);
-    if (tmp == (int32_t)tmp) {
-        tcg_out_opc_upper(s, OPC_AUIPC, rd, 0);
-        tcg_out_opc_imm(s, OPC_ADDI, rd, rd, 0);
-        ret = reloc_call(s->code_ptr - 2, (const tcg_insn_unit *)val);
-        tcg_debug_assert(ret == true);
+    if (split_auipc_offset(s->code_ptr, val, &hi, &lo)) {
+        tcg_out_opc_upper(s, OPC_AUIPC, rd, hi);
+        tcg_out_opc_imm(s, OPC_ADDI, rd, rd, lo);
         return;
     }
 
@@ -952,16 +949,16 @@ static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg ret, TCGReg arg)
 static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
                          TCGReg addr, intptr_t offset)
 {
-    intptr_t imm12 = sextreg(offset, 0, 12);
+    int32_t lo = sextract32(offset, 0, 12);
 
-    if (offset != imm12) {
-        intptr_t diff = tcg_pcrel_diff(s, (void *)offset);
+    if (offset != lo) {
+        int32_t hi;
 
-        if (addr == TCG_REG_ZERO && diff == (int32_t)diff) {
-            imm12 = sextreg(diff, 0, 12);
-            tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP2, diff - imm12);
+        if (addr == TCG_REG_ZERO &&
+            split_auipc_offset(s->code_ptr, offset, &hi, &lo)) {
+            tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP2, hi);
         } else {
-            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP2, offset - imm12);
+            tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP2, offset - lo);
             if (addr != TCG_REG_ZERO) {
                 tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP2, TCG_REG_TMP2, addr);
             }
@@ -974,7 +971,7 @@ static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
     case OPC_SH:
     case OPC_SW:
     case OPC_SD:
-        tcg_out_opc_store(s, opc, addr, data, imm12);
+        tcg_out_opc_store(s, opc, addr, data, lo);
         break;
     case OPC_LB:
     case OPC_LBU:
@@ -983,7 +980,7 @@ static void tcg_out_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
     case OPC_LW:
     case OPC_LWU:
     case OPC_LD:
-        tcg_out_opc_imm(s, opc, data, addr, imm12);
+        tcg_out_opc_imm(s, opc, data, addr, lo);
         break;
     default:
         g_assert_not_reached();
@@ -1589,7 +1586,7 @@ static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
     TCGReg link = tail ? TCG_REG_ZERO : TCG_REG_RA;
     ptrdiff_t offset = tcg_pcrel_diff(s, arg);
     tcg_insn_unit insn = encode_j(OPC_JAL, link, 0);
-    int ret;
+    int32_t lo, hi;
 
     init_setting_vtype(s);
 
@@ -1597,19 +1594,18 @@ static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
     if (encode_jimm20(&insn, offset)) {
         /* short jump */
         tcg_out32(s, insn);
-    } else if (offset == (int32_t)offset) {
-        /* long jump: -2147483646 to 2147483648 */
-        tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP0, 0);
-        tcg_out_opc_imm(s, OPC_JALR, link, TCG_REG_TMP0, 0);
-        ret = reloc_call(s->code_ptr - 2, arg);
-        tcg_debug_assert(ret == true);
-    } else {
-        /* far jump: 64-bit */
-        tcg_target_long imm = sextreg((tcg_target_long)arg, 0, 12);
-        tcg_target_long base = (tcg_target_long)arg - imm;
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, base);
-        tcg_out_opc_imm(s, OPC_JALR, link, TCG_REG_TMP0, imm);
+        return;
     }
+
+    if (split_auipc_offset(s->code_ptr, (intptr_t)arg, &hi, &lo)) {
+        /* long jump */
+        tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP0, hi);
+    } else {
+        /* far jump */
+        lo = sextract32((intptr_t)arg, 0, 12);
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, (intptr_t)arg - lo);
+    }
+    tcg_out_opc_imm(s, OPC_JALR, link, TCG_REG_TMP0, lo);
 }
 
 static void tcg_out_call(TCGContext *s, const tcg_insn_unit *arg,
-- 
2.53.0


