Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A430CC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sExzD-0000jn-MN; Wed, 05 Jun 2024 17:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExz2-0000fr-J3
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:48 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyt-0003Rz-1g
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:48 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6f6a045d476so195668b3a.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717622137; x=1718226937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NRnvBT7dCcRQW46yZ2cILgjEvSH0UMGtXyMJE1zUYf4=;
 b=S9kKFkx20O5iBGODTxQSGVUjSxOWAZreFkd8sJdIMwY7SovB/JQw5x1bLKaX3b43Sj
 DK9cOVLC8xTDyIFt8KD7ebFxyEBAKDtjbxaq5NLrdeNoW3zOxFR3YErXHFP4SwCmzZVG
 YYfEwHfeNAmgUKKucG5q7NaJL0DCP+C7oYtaB19Q3OXBKCcLOPMp50SdpSeFPOBhE+0n
 7+zGk6kNZATq3GEX+kT5V+Kdm4JGDHyplnXd4PSxkMLlhS34RnF9NCUPj2V/tDhHpT6K
 W3nbXeL21JJOV7PEmiqzTxd4FUQXhCTzhBd4GnUTXSeBH0vCPZUInQzj8ZD+WIsdepKg
 y2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717622137; x=1718226937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NRnvBT7dCcRQW46yZ2cILgjEvSH0UMGtXyMJE1zUYf4=;
 b=qibHiHPtGzikPLpuLfveMWnE84uvvzmfKP2LLbL+Y0lYX7nA+4wonN/Ela497ebcvt
 YFT170tv5iqM5lz+N1CFtkntu+BKiGb7sI6fl5uwNC2elJoTOPId6T57Uuf8Qgmm+ZYg
 rQSbYLkNTpBH+RRFwn0AWAIpohM4PvExkzqpx/mWINqLETMNtFb28aonxZNMUbDlCN8R
 ahuqTtlyv0Zdq/F5Qt9p5vzAl1yVZaMOaTCHgqmUqX185tuOPlKd1Cy6VhFcHzQqWF9V
 8GdeYixwF37VK1EGKEdAv1MopwFoJRpnRkd5GG0W+9XDZS0uex0fNaBZpb2WBXol9L0w
 quxQ==
X-Gm-Message-State: AOJu0YyYCcQ8aJsjyBERGd7w4XJuOtkJfWaYiMpMuohA5Hk274Hk0ZsH
 zUTHoDei2SwKWthUHaKG9shOj1VaQ2eRnPhtAoQ8fSTnzM5762P9La9v4Mhh66t/P9K0gK55efj
 M
X-Google-Smtp-Source: AGHT+IFrOjyBsjPYDMv5dM6bzh8qw21VByPFIHuNpSTu1G2B1BZ0K/Ocd1kb5ph/vQI2oMl6TaytCg==
X-Received: by 2002:a05:6a20:2593:b0:1a3:8e1d:16b8 with SMTP id
 adf61e73a8af0-1b2b6ffee37mr4401487637.28.1717622137280; 
 Wed, 05 Jun 2024 14:15:37 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242aec7d0sm9347538b3a.99.2024.06.05.14.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:15:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 16/16] disas/riscv: Use GString in format_inst
Date: Wed,  5 Jun 2024 14:15:21 -0700
Message-Id: <20240605211521.577094-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605211521.577094-1-richard.henderson@linaro.org>
References: <20240605211521.577094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Allocate and fill a GString instead of snprintf and
appending to a fixed sized buffer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240412073346.458116-22-richard.henderson@linaro.org>
---
 disas/riscv.c | 209 ++++++++++++++++++++++----------------------------
 1 file changed, 92 insertions(+), 117 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 297cfa2f63..90d6b26de9 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4820,272 +4820,249 @@ static size_t inst_length(rv_inst inst)
 
 /* format instruction */
 
-static void append(char *s1, const char *s2, size_t n)
-{
-    size_t l1 = strlen(s1);
-    if (n - l1 - 1 > 0) {
-        strncat(s1, s2, n - l1);
-    }
-}
-
-static void format_inst(char *buf, size_t buflen, size_t tab, rv_decode *dec)
+static GString *format_inst(size_t tab, rv_decode *dec)
 {
     const rv_opcode_data *opcode_data = dec->opcode_data;
-    char tmp[64];
+    GString *buf = g_string_sized_new(64);
     const char *fmt;
 
     fmt = opcode_data[dec->op].format;
     while (*fmt) {
         switch (*fmt) {
         case 'O':
-            append(buf, opcode_data[dec->op].name, buflen);
+            g_string_append(buf, opcode_data[dec->op].name);
             break;
         case '(':
-            append(buf, "(", buflen);
-            break;
         case ',':
-            append(buf, ",", buflen);
-            break;
         case ')':
-            append(buf, ")", buflen);
-            break;
         case '-':
-            append(buf, "-", buflen);
+            g_string_append_c(buf, *fmt);
             break;
         case 'b':
-            snprintf(tmp, sizeof(tmp), "%d", dec->bs);
-            append(buf, tmp, buflen);
+            g_string_append_printf(buf, "%d", dec->bs);
             break;
         case 'n':
-            snprintf(tmp, sizeof(tmp), "%d", dec->rnum);
-            append(buf, tmp, buflen);
+            g_string_append_printf(buf, "%d", dec->rnum);
             break;
         case '0':
-            append(buf, rv_ireg_name_sym[dec->rd], buflen);
+            g_string_append(buf, rv_ireg_name_sym[dec->rd]);
             break;
         case '1':
-            append(buf, rv_ireg_name_sym[dec->rs1], buflen);
+            g_string_append(buf, rv_ireg_name_sym[dec->rs1]);
             break;
         case '2':
-            append(buf, rv_ireg_name_sym[dec->rs2], buflen);
+            g_string_append(buf, rv_ireg_name_sym[dec->rs2]);
             break;
         case '3':
-            append(buf, dec->cfg->ext_zfinx ? rv_ireg_name_sym[dec->rd] :
-                                              rv_freg_name_sym[dec->rd],
-                   buflen);
+            if (dec->cfg->ext_zfinx) {
+                g_string_append(buf, rv_ireg_name_sym[dec->rd]);
+            } else {
+                g_string_append(buf, rv_freg_name_sym[dec->rd]);
+            }
             break;
         case '4':
-            append(buf, dec->cfg->ext_zfinx ? rv_ireg_name_sym[dec->rs1] :
-                                              rv_freg_name_sym[dec->rs1],
-                   buflen);
+            if (dec->cfg->ext_zfinx) {
+                g_string_append(buf, rv_ireg_name_sym[dec->rs1]);
+            } else {
+                g_string_append(buf, rv_freg_name_sym[dec->rs1]);
+            }
             break;
         case '5':
-            append(buf, dec->cfg->ext_zfinx ? rv_ireg_name_sym[dec->rs2] :
-                                              rv_freg_name_sym[dec->rs2],
-                   buflen);
+            if (dec->cfg->ext_zfinx) {
+                g_string_append(buf, rv_ireg_name_sym[dec->rs2]);
+            } else {
+                g_string_append(buf, rv_freg_name_sym[dec->rs2]);
+            }
             break;
         case '6':
-            append(buf, dec->cfg->ext_zfinx ? rv_ireg_name_sym[dec->rs3] :
-                                              rv_freg_name_sym[dec->rs3],
-                   buflen);
+            if (dec->cfg->ext_zfinx) {
+                g_string_append(buf, rv_ireg_name_sym[dec->rs3]);
+            } else {
+                g_string_append(buf, rv_freg_name_sym[dec->rs3]);
+            }
             break;
         case '7':
-            snprintf(tmp, sizeof(tmp), "%d", dec->rs1);
-            append(buf, tmp, buflen);
+            g_string_append_printf(buf, "%d", dec->rs1);
             break;
         case 'i':
-            snprintf(tmp, sizeof(tmp), "%d", dec->imm);
-            append(buf, tmp, buflen);
+            g_string_append_printf(buf, "%d", dec->imm);
             break;
         case 'u':
-            snprintf(tmp, sizeof(tmp), "%u", ((uint32_t)dec->imm & 0b111111));
-            append(buf, tmp, buflen);
+            g_string_append_printf(buf, "%u", ((uint32_t)dec->imm & 0b111111));
             break;
         case 'j':
-            snprintf(tmp, sizeof(tmp), "%d", dec->imm1);
-            append(buf, tmp, buflen);
+            g_string_append_printf(buf, "%d", dec->imm1);
             break;
         case 'o':
-            snprintf(tmp, sizeof(tmp), "%d", dec->imm);
-            append(buf, tmp, buflen);
-            while (strlen(buf) < tab * 2) {
-                append(buf, " ", buflen);
+            g_string_append_printf(buf, "%d", dec->imm);
+            while (buf->len < tab * 2) {
+                g_string_append_c(buf, ' ');
             }
-            snprintf(tmp, sizeof(tmp), "# 0x%" PRIx64,
-                dec->pc + dec->imm);
-            append(buf, tmp, buflen);
+            g_string_append_printf(buf, "# 0x%" PRIx64, dec->pc + dec->imm);
             break;
         case 'U':
             fmt++;
-            snprintf(tmp, sizeof(tmp), "%d", dec->imm >> 12);
-            append(buf, tmp, buflen);
+            g_string_append_printf(buf, "%d", dec->imm >> 12);
             if (*fmt == 'o') {
-                while (strlen(buf) < tab * 2) {
-                    append(buf, " ", buflen);
+                while (buf->len < tab * 2) {
+                    g_string_append_c(buf, ' ');
                 }
-                snprintf(tmp, sizeof(tmp), "# 0x%" PRIx64,
-                    dec->pc + dec->imm);
-                append(buf, tmp, buflen);
+                g_string_append_printf(buf, "# 0x%" PRIx64, dec->pc + dec->imm);
             }
             break;
         case 'c': {
             const char *name = csr_name(dec->imm & 0xfff);
             if (name) {
-                append(buf, name, buflen);
+                g_string_append(buf, name);
             } else {
-                snprintf(tmp, sizeof(tmp), "0x%03x", dec->imm & 0xfff);
-                append(buf, tmp, buflen);
+                g_string_append_printf(buf, "0x%03x", dec->imm & 0xfff);
             }
             break;
         }
         case 'r':
             switch (dec->rm) {
             case rv_rm_rne:
-                append(buf, "rne", buflen);
+                g_string_append(buf, "rne");
                 break;
             case rv_rm_rtz:
-                append(buf, "rtz", buflen);
+                g_string_append(buf, "rtz");
                 break;
             case rv_rm_rdn:
-                append(buf, "rdn", buflen);
+                g_string_append(buf, "rdn");
                 break;
             case rv_rm_rup:
-                append(buf, "rup", buflen);
+                g_string_append(buf, "rup");
                 break;
             case rv_rm_rmm:
-                append(buf, "rmm", buflen);
+                g_string_append(buf, "rmm");
                 break;
             case rv_rm_dyn:
-                append(buf, "dyn", buflen);
+                g_string_append(buf, "dyn");
                 break;
             default:
-                append(buf, "inv", buflen);
+                g_string_append(buf, "inv");
                 break;
             }
             break;
         case 'p':
             if (dec->pred & rv_fence_i) {
-                append(buf, "i", buflen);
+                g_string_append_c(buf, 'i');
             }
             if (dec->pred & rv_fence_o) {
-                append(buf, "o", buflen);
+                g_string_append_c(buf, 'o');
             }
             if (dec->pred & rv_fence_r) {
-                append(buf, "r", buflen);
+                g_string_append_c(buf, 'r');
             }
             if (dec->pred & rv_fence_w) {
-                append(buf, "w", buflen);
+                g_string_append_c(buf, 'w');
             }
             break;
         case 's':
             if (dec->succ & rv_fence_i) {
-                append(buf, "i", buflen);
+                g_string_append_c(buf, 'i');
             }
             if (dec->succ & rv_fence_o) {
-                append(buf, "o", buflen);
+                g_string_append_c(buf, 'o');
             }
             if (dec->succ & rv_fence_r) {
-                append(buf, "r", buflen);
+                g_string_append_c(buf, 'r');
             }
             if (dec->succ & rv_fence_w) {
-                append(buf, "w", buflen);
+                g_string_append_c(buf, 'w');
             }
             break;
         case '\t':
-            while (strlen(buf) < tab) {
-                append(buf, " ", buflen);
+            while (buf->len < tab) {
+                g_string_append_c(buf, ' ');
             }
             break;
         case 'A':
             if (dec->aq) {
-                append(buf, ".aq", buflen);
+                g_string_append(buf, ".aq");
             }
             break;
         case 'R':
             if (dec->rl) {
-                append(buf, ".rl", buflen);
+                g_string_append(buf, ".rl");
             }
             break;
         case 'l':
-            append(buf, ",v0", buflen);
+            g_string_append(buf, ",v0");
             break;
         case 'm':
             if (dec->vm == 0) {
-                append(buf, ",v0.t", buflen);
+                g_string_append(buf, ",v0.t");
             }
             break;
         case 'D':
-            append(buf, rv_vreg_name_sym[dec->rd], buflen);
+            g_string_append(buf, rv_vreg_name_sym[dec->rd]);
             break;
         case 'E':
-            append(buf, rv_vreg_name_sym[dec->rs1], buflen);
+            g_string_append(buf, rv_vreg_name_sym[dec->rs1]);
             break;
         case 'F':
-            append(buf, rv_vreg_name_sym[dec->rs2], buflen);
+            g_string_append(buf, rv_vreg_name_sym[dec->rs2]);
             break;
         case 'G':
-            append(buf, rv_vreg_name_sym[dec->rs3], buflen);
+            g_string_append(buf, rv_vreg_name_sym[dec->rs3]);
             break;
         case 'v': {
-            char nbuf[32] = {0};
             const int sew = 1 << (((dec->vzimm >> 3) & 0b111) + 3);
-            sprintf(nbuf, "%d", sew);
             const int lmul = dec->vzimm & 0b11;
             const int flmul = (dec->vzimm >> 2) & 1;
             const char *vta = (dec->vzimm >> 6) & 1 ? "ta" : "tu";
             const char *vma = (dec->vzimm >> 7) & 1 ? "ma" : "mu";
-            append(buf, "e", buflen);
-            append(buf, nbuf, buflen);
-            append(buf, ",m", buflen);
+
+            g_string_append_printf(buf, "e%d,m", sew);
             if (flmul) {
                 switch (lmul) {
                 case 3:
-                    sprintf(nbuf, "f2");
+                    g_string_append(buf, "f2");
                     break;
                 case 2:
-                    sprintf(nbuf, "f4");
+                    g_string_append(buf, "f4");
                     break;
                 case 1:
-                    sprintf(nbuf, "f8");
-                break;
+                    g_string_append(buf, "f8");
+                    break;
                 }
-                append(buf, nbuf, buflen);
             } else {
-                sprintf(nbuf, "%d", 1 << lmul);
-                append(buf, nbuf, buflen);
+                g_string_append_printf(buf, "%d", 1 << lmul);
             }
-            append(buf, ",", buflen);
-            append(buf, vta, buflen);
-            append(buf, ",", buflen);
-            append(buf, vma, buflen);
+            g_string_append_c(buf, ',');
+            g_string_append(buf, vta);
+            g_string_append_c(buf, ',');
+            g_string_append(buf, vma);
             break;
         }
         case 'x': {
             switch (dec->rlist) {
             case 4:
-                snprintf(tmp, sizeof(tmp), "{ra}");
+                g_string_append(buf, "{ra}");
                 break;
             case 5:
-                snprintf(tmp, sizeof(tmp), "{ra, s0}");
+                g_string_append(buf, "{ra, s0}");
                 break;
             case 15:
-                snprintf(tmp, sizeof(tmp), "{ra, s0-s11}");
+                g_string_append(buf, "{ra, s0-s11}");
                 break;
             default:
-                snprintf(tmp, sizeof(tmp), "{ra, s0-s%d}", dec->rlist - 5);
+                g_string_append_printf(buf, "{ra, s0-s%d}", dec->rlist - 5);
                 break;
             }
-            append(buf, tmp, buflen);
             break;
         }
         case 'h':
-            append(buf, rv_fli_name_const[dec->imm], buflen);
+            g_string_append(buf, rv_fli_name_const[dec->imm]);
             break;
         default:
             break;
         }
         fmt++;
     }
+
+    return buf;
 }
 
 /* lift instruction to pseudo-instruction */
@@ -5171,9 +5148,8 @@ static void decode_inst_decompress(rv_decode *dec, rv_isa isa)
 
 /* disassemble instruction */
 
-static void
-disasm_inst(char *buf, size_t buflen, rv_isa isa, uint64_t pc, rv_inst inst,
-            RISCVCPUConfig *cfg)
+static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
+                            RISCVCPUConfig *cfg)
 {
     rv_decode dec = { 0 };
     dec.pc = pc;
@@ -5220,7 +5196,7 @@ disasm_inst(char *buf, size_t buflen, rv_isa isa, uint64_t pc, rv_inst inst,
     decode_inst_operands(&dec, isa);
     decode_inst_decompress(&dec, isa);
     decode_inst_lift_pseudo(&dec);
-    format_inst(buf, buflen, 24, &dec);
+    return format_inst(24, &dec);
 }
 
 #define INST_FMT_2 "%04" PRIx64 "              "
@@ -5231,7 +5207,6 @@ disasm_inst(char *buf, size_t buflen, rv_isa isa, uint64_t pc, rv_inst inst,
 static int
 print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa isa)
 {
-    char buf[128] = { 0 };
     bfd_byte packet[2];
     rv_inst inst = 0;
     size_t len = 2;
@@ -5272,9 +5247,9 @@ print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa isa)
         }
     }
 
-    disasm_inst(buf, sizeof(buf), isa, memaddr, inst,
-                (RISCVCPUConfig *)info->target_info);
-    (*info->fprintf_func)(info->stream, "%s", buf);
+    g_autoptr(GString) str =
+        disasm_inst(isa, memaddr, inst, (RISCVCPUConfig *)info->target_info);
+    (*info->fprintf_func)(info->stream, "%s", str->str);
 
     return len;
 }
-- 
2.34.1


