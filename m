Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D16BC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr1j-0003t8-Pc; Fri, 17 Jan 2025 13:25:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1i-0003sa-5O
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:02 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1g-0007dY-5r
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:01 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2161eb95317so48430405ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138299; x=1737743099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6S52snYHijLwx57nwxGZtQUutA8vgOZxNo/jj2SLduk=;
 b=JJjjqY+MPhFDd0ocvNOvVyYp64cF/iS4vR2oYDEdz3jhHu+qWoaol9lFlr/VhvcJfq
 76wlunQckAZ6byPPFig5vG105iZhWhIuK2LNe2miCSCyPVsahGkMwHyshy2/D9Jf/RLC
 p04V5cyycNIl3Qv/HFMgqoLWhjWzlGSxARwVrrURQ8kiQFFhbEIMlf4wFxA30CoAo1w2
 s00CqprwFgLPeXC97bcYmUsYsyaBzc+v/F7k0VmOLSLW4AUIXgeZ2Liccbx9IE+4iHj2
 kp/1lRnTBgdQ0YUJZg66EOmYKuxEEQ5WIWSnkz27MDNv51y+2bJcjx0/nhNcRQs1OvIe
 WuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138299; x=1737743099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6S52snYHijLwx57nwxGZtQUutA8vgOZxNo/jj2SLduk=;
 b=F83UDtnigYYBxvj71PKjHirJiyZ2ztTicwnPkC6ip5k9022kmU7rD/64fMbJ8fpNQf
 8juMFb+4j0/1r8HrDJiLsmXjJcZNtVauW5WDrG3DgNVAR+ORAFcAbYXtpz5+U7Bmzfxs
 twPbLd1oopn6XdDtXT2MefVP5hwl25Q0E2p+80xjJE/57BbmQ5a6WMb7oqNbq8MrQm20
 IejlxV4fGTygUn5MtJYJWDweHaRw/EWNGg6eEl8FShFQQhBfPJPzCxlPthnHLBhQgaVe
 BWAdoZaTtATLfe7OL8s05qHA0PTSHJYlHYg2d/4sLLqQGW2HVVWZhGVVRYhPbjk3lPu/
 3o+g==
X-Gm-Message-State: AOJu0YwGFb21PAO8lyrs2klyGCIMK6CK0b5729U1brwqhfqeOlx1LnYP
 T171YlIb82jRqbB3z5BU5pb81b+eF9ZwX5jpQ6aEQJz0CeJjAfROsv00xy/7UVlVgqXd9NxRFJg
 W
X-Gm-Gg: ASbGncsYAhizzxZrXSlmP2VG4WyHdadtToomnqIIVw7pWkRkC/Uv7Ca9WJdBYN+Ylmc
 QsXXTC8ApfC5lo7dTlAJrJuAbrQ3PO8NUjvvRLZx9y2hAKLLOnQgCiS9Ltx6oDgwYxI5URMcqbm
 tKe4IL9zOOK5EXtlVWIUa8v6kEq+rg1+AS+yrYQAcmZfg8c0q3KgA9ebVG3R+fIW1QO13tg9nXt
 GREnJCJUTLMqcV+oycnpq+zINyno66wCX4K/BQSoAX5o8nu7YLQcIzSKJMZn//guQZPrGUpJS1K
 8OSGWHYXxUxEtMs=
X-Google-Smtp-Source: AGHT+IFmWzRgSe8xPN8EX/rpkRfvyNaIeFL8rRpXwGSDEUqcbQ6KKmg3FnUUoP+3O1mWyH1Vo2aDoQ==
X-Received: by 2002:a17:902:c951:b0:216:5268:9aab with SMTP id
 d9443c01a7336-21c355e832amr44404635ad.46.1737138298775; 
 Fri, 17 Jan 2025 10:24:58 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:24:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 01/68] disas/riscv: Guard dec->cfg dereference for host
 disassemble
Date: Fri, 17 Jan 2025 10:23:49 -0800
Message-ID: <20250117182456.2077110-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

For riscv host, it will set dec->cfg to zero. Thus we shuld guard
the dec->cfg deference for riscv host disassemble.

And in general, we should only use dec->cfg for target in three cases:

1) For not incompatible encodings, such as zcmp/zcmt/zfinx.
2) For maybe-ops encodings, they are better to be disassembled to
   the "real" extensions, such as zicfiss. The guard of dec->zimop
   and dec->zcmop is for comment and avoid check for every extension
   that encoded in maybe-ops area.
3) For custom encodings, we have to use dec->cfg to disassemble
   custom encodings using the same encoding area.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241206032411.52528-1-zhiwei_liu@linux.alibaba.com>
---
 disas/riscv.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 9c1e332dde..4075ed6bfe 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2611,7 +2611,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             break;
         case 2: op = rv_op_c_li; break;
         case 3:
-            if (dec->cfg->ext_zcmop) {
+            if (dec->cfg && dec->cfg->ext_zcmop) {
                 if ((((inst >> 2) & 0b111111) == 0b100000) &&
                     (((inst >> 11) & 0b11) == 0b0)) {
                     unsigned int cmop_code = 0;
@@ -2712,7 +2712,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 op = rv_op_c_sqsp;
             } else {
                 op = rv_op_c_fsdsp;
-                if (dec->cfg->ext_zcmp && ((inst >> 12) & 0b01)) {
+                if (dec->cfg && dec->cfg->ext_zcmp && ((inst >> 12) & 0b01)) {
                     switch ((inst >> 8) & 0b01111) {
                     case 8:
                         if (((inst >> 4) & 0b01111) >= 4) {
@@ -2738,7 +2738,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 } else {
                     switch ((inst >> 10) & 0b011) {
                     case 0:
-                        if (!dec->cfg->ext_zcmt) {
+                        if (dec->cfg && !dec->cfg->ext_zcmt) {
                             break;
                         }
                         if (((inst >> 2) & 0xFF) >= 32) {
@@ -2748,7 +2748,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                         }
                         break;
                     case 3:
-                        if (!dec->cfg->ext_zcmp) {
+                        if (dec->cfg && !dec->cfg->ext_zcmp) {
                             break;
                         }
                         switch ((inst >> 5) & 0b011) {
@@ -2956,7 +2956,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             break;
         case 5:
             op = rv_op_auipc;
-            if (dec->cfg->ext_zicfilp &&
+            if (dec->cfg && dec->cfg->ext_zicfilp &&
                 (((inst >> 7) & 0b11111) == 0b00000)) {
                 op = rv_op_lpad;
             }
@@ -4058,7 +4058,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 2: op = rv_op_csrrs; break;
             case 3: op = rv_op_csrrc; break;
             case 4:
-                if (dec->cfg->ext_zimop) {
+                if (dec->cfg && dec->cfg->ext_zimop) {
                     int imm_mop5, imm_mop3, reg_num;
                     if ((extract32(inst, 22, 10) & 0b1011001111)
                         == 0b1000000111) {
@@ -5112,28 +5112,28 @@ static GString *format_inst(size_t tab, rv_decode *dec)
             g_string_append(buf, rv_ireg_name_sym[dec->rs2]);
             break;
         case '3':
-            if (dec->cfg->ext_zfinx) {
+            if (dec->cfg && dec->cfg->ext_zfinx) {
                 g_string_append(buf, rv_ireg_name_sym[dec->rd]);
             } else {
                 g_string_append(buf, rv_freg_name_sym[dec->rd]);
             }
             break;
         case '4':
-            if (dec->cfg->ext_zfinx) {
+            if (dec->cfg && dec->cfg->ext_zfinx) {
                 g_string_append(buf, rv_ireg_name_sym[dec->rs1]);
             } else {
                 g_string_append(buf, rv_freg_name_sym[dec->rs1]);
             }
             break;
         case '5':
-            if (dec->cfg->ext_zfinx) {
+            if (dec->cfg && dec->cfg->ext_zfinx) {
                 g_string_append(buf, rv_ireg_name_sym[dec->rs2]);
             } else {
                 g_string_append(buf, rv_freg_name_sym[dec->rs2]);
             }
             break;
         case '6':
-            if (dec->cfg->ext_zfinx) {
+            if (dec->cfg && dec->cfg->ext_zfinx) {
                 g_string_append(buf, rv_ireg_name_sym[dec->rs3]);
             } else {
                 g_string_append(buf, rv_freg_name_sym[dec->rs3]);
@@ -5439,7 +5439,8 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
         const rv_opcode_data *opcode_data = decoders[i].opcode_data;
         void (*decode_func)(rv_decode *, rv_isa) = decoders[i].decode_func;
 
-        if (guard_func(cfg)) {
+        /* always_true_p don't dereference cfg */
+        if (((i == 0) || cfg) && guard_func(cfg)) {
             dec.opcode_data = opcode_data;
             decode_func(&dec, isa);
             if (dec.op != rv_op_illegal)
-- 
2.43.0


