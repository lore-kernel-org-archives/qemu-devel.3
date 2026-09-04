Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE39C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Ph6-0005Ki-DW; Fri, 04 Sep 2026 04:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x2Ph3-0005Jb-D4
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 04:54:41 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x2Ph1-0007Yu-Ph
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 04:54:41 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-39647aa9d52so865141a91.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 01:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1788512078; x=1789116878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RRja5k1q9ApEjl0FZYo2g1/y3PvPqD42W1nTIrwMKLc=;
 b=QMRKEiB1eCkWssUfZ8URVXogcX/tANsPAtYqXEoQcbhSmv7vXd/E1sA4gguQcgIUGc
 MyhNXD8vXz+T+KDz8VXAE6tsg0qz74f3qhFgQ81hCnlbeUCBlzjD/wixJS1qV+gtr4jV
 gAs5AimR1yPkqFHjSMjeKknOjOpQeMPGtkplgC7uLgFl8rv5QnWM0O+CbuEBZTeH0Gii
 i9Fn3pDQvck6POhG7CingdIBoq3LUWab9HUZxFWuvMHGgQFsYVOqxJojxsvjaZ8lKrWa
 ADRUiHcAo4bEEASeRuAwq68z2CTngaNJRIBcGGqy0L22+B6lFrNVUa4I54TIlEF0NJPh
 7RKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788512078; x=1789116878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RRja5k1q9ApEjl0FZYo2g1/y3PvPqD42W1nTIrwMKLc=;
 b=VZRmns9zYJfSbb9NEVzxqC8TRTkakDEEpzEWlSYrvWC19lMKK0mwzevcs2iEBoy9Bf
 SBnbQlSAdz7VaUVDeN4P+aCXbcwM7oK4XApOo/M/HpTBXYnJ8T+waQKr9UtarwUNYLmy
 HOuYf1DXd/0IFBSag6PjVRakY6r4iALW1aBRAaX+2ews8HKmicwPbgsn35kKkSAzQego
 ENyjt6L+slW1BPb1ZE+pTYwt6XRjU3UTr29YcYqZcCJbYZBUZehgWpW+cnUCbOuqAw61
 rayx2IVrjZ4S43BEcaxTexteu7dvnaaDwUEU3ot0lm1QJqCMS/mIiKgahdAA7UZ/hcdr
 CUBg==
X-Gm-Message-State: AFuF++l+hbWAOv18P+K1TuwQbRqFkgM4izmV5zVzICmO5GyEiciuktqt
 RmpffL7B1TtaX2MWaBc+BK85nbaMJtLWmRRn9JM7xWLMpeTzJAUroy6sK9VU+Mxz5nR5EcxzRpG
 t0Zn8RG55G/6quylP3YHp+aAJRo9BrAwwWIXc5keJluVZ0+5Dvi+Y/hnqtfIPEOmhXkfu7jViwy
 6ovPO5DUt4RlnW/uhPnIr8wivWkOoHjmxS4o0d2vJR1g==
X-Gm-Gg: AYBFou2BubT+0s+oACN/Hsv89quRJ3OA7INgvuOsFSgjuFB65OeEMi0w3PMxiBv/++O
 dPwFtD9sroFebC1w5DYdaqd1GBrmWIH1QzxI2TMTQGGgjuuxFYIw0orRWmE4UG3pSrJNfOGfzgv
 LZkXadUT4EsoFY6etWjtBNhSa9FdIsRELUDrI7LGFvaMxQrShoMKeK3gw+yHWc44jWIBPAnaUYT
 NzN02Vm1v1kujXZ4cdnCIORYglz0fumHu5rcuzT12lo2LnJYRdYTi+crJzWmc+fKFL9ZA7huRwu
 zeHNu3iDuiwdQZNHsVQxR2I3qWbYp6/2dVLUDGyThkWwOi9okd7h6PSCcfCXlMn7gi6FoCdjWm1
 hvLJGjMNHrx+1rrsNBC/8iUtLuwBTOGPQYWzsGdNnJ5+jXIYAd97Fj1Ho5en9ShOgXsCH+VJiqR
 PSxUptWTUJb7EN6NP4lRXSkpr/vNlghPWMMHYGU/1M095pgd8o1V3nyai+tAqiNFbyGtgLaoPfb
 h8lXu2TAkJ6Nur3JF8hy397OY9MJoRhamtwsU2W8kjwpkFjkDHeMcZEcMR6604=
X-Received: by 2002:a17:90b:1d44:b0:38f:cab0:9aa9 with SMTP id
 98e67ed59e1d1-39b0803b0efmr12284521a91.13.1788512078187; 
 Fri, 04 Sep 2026 01:54:38 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39ae8f1448esm4782912a91.4.2026.09.04.01.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 01:54:37 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v2 2/2] tcg/riscv64: Fall back when AUIPC pairs are out of
 range
Date: Fri,  4 Sep 2026 16:54:26 +0800
Message-ID: <20260904085426.3686492-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904085426.3686492-1-max.chou@sifive.com>
References: <20260904085426.3686492-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102c.google.com
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

tcg_out_movi and tcg_out_call_int only check whether a
PC-relative displacement is signed 32-bit before emitting an AUIPC
pair. This does not account for rounding the signed 12-bit immediate,
which can require an unencodable positive 0x80000000 AUIPC contribution.

Validate the split and emit the pair only when it fits. Otherwise,
tcg_out_movi keeps its existing full-address materialization and
tcg_out_call_int uses its existing indirect far-call sequence.

Fixes: dfa8e74f9463 ("tcg/riscv: Add the relocation functions")
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 tcg/riscv64/tcg-target.c.inc | 43 +++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 76db0de94c3..4228203d36f 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -674,6 +674,21 @@ static bool reloc_call(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
     return false;
 }
 
+static bool tcg_out_auipc_pair(TCGContext *s, const tcg_insn_unit *target,
+                               RISCVInsn opc, TCGReg base,
+                               TCGReg rd, TCGReg rs1)
+{
+    uint32_t hi, lo;
+
+    if (!split_auipc_offset(s->code_ptr, target, &hi, &lo)) {
+        return false;
+    }
+    tcg_out_opc_upper(s, OPC_AUIPC, base, hi);
+    tcg_out_opc_imm(s, opc, rd, rs1, lo);
+
+    return true;
+}
+
 static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -808,7 +823,8 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
                          tcg_target_long val)
 {
     tcg_target_long lo, hi, tmp;
-    int shift, ret;
+    int shift;
+    bool ret;
 
     if (type == TCG_TYPE_I32) {
         val = (int32_t)val;
@@ -829,12 +845,9 @@ static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
         return;
     }
 
-    tmp = tcg_pcrel_diff(s, (void *)val);
-    if (tmp == (int32_t)tmp) {
-        tcg_out_opc_upper(s, OPC_AUIPC, rd, 0);
-        tcg_out_opc_imm(s, OPC_ADDI, rd, rd, 0);
-        ret = reloc_call(s->code_ptr - 2, (const tcg_insn_unit *)val);
-        tcg_debug_assert(ret == true);
+    ret = tcg_out_auipc_pair(s, (const tcg_insn_unit *)val, OPC_ADDI, rd, rd,
+                             rd);
+    if (ret) {
         return;
     }
 
@@ -1588,7 +1601,7 @@ static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
 {
     TCGReg link = tail ? TCG_REG_ZERO : TCG_REG_RA;
     ptrdiff_t offset = tcg_pcrel_diff(s, arg);
-    int ret;
+    bool ret;
 
     init_setting_vtype(s);
 
@@ -1596,14 +1609,14 @@ static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
     if (offset == sextreg(offset, 0, 20)) {
         /* short jump: -2097150 to 2097152 */
         tcg_out_opc_jump(s, OPC_JAL, link, offset);
-    } else if (offset == (int32_t)offset) {
-        /* long jump: -2147483646 to 2147483648 */
-        tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP0, 0);
-        tcg_out_opc_imm(s, OPC_JALR, link, TCG_REG_TMP0, 0);
-        ret = reloc_call(s->code_ptr - 2, arg);
-        tcg_debug_assert(ret == true);
     } else {
-        /* far jump: 64-bit */
+        ret = tcg_out_auipc_pair(s, arg, OPC_JALR, TCG_REG_TMP0, link,
+                                 TCG_REG_TMP0);
+        if (ret) {
+            return;
+        }
+
+        /* Far jump: 64-bit. */
         tcg_target_long imm = sextreg((tcg_target_long)arg, 0, 12);
         tcg_target_long base = (tcg_target_long)arg - imm;
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP0, base);
-- 
2.43.0


