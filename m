Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE661C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHUW-0007Hx-Cw; Wed, 12 Aug 2026 18:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUU-0007G0-Ni
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:06 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUP-0000yu-Ls
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:06 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-84f3ab8750cso1366249b3a.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573920; x=1787178720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f1cHhDDQS9k4fHmPQCoqY1V3PFVkrqSubkfXzA73XzM=;
 b=M8QByCfGD+VUYAFbX84+dbJgPcFjPR1ImzxgDuHMNk2KyY8INcQaAe94S8cU4reFjW
 DaE3MViephL/pyYdZJrtOEmCh8Ee8S/0tbwW9Cc0G4Z6W1vEteRg7HaWKKbfsSfjVGyN
 lbR935hXaBfVhvmClux1eZDvoZEyHdL4yPfHHxv8wMJDdTF8AhIX5ytEZ9lEFcYUCS3S
 /2P75pp4mFDfWki5Lpjw54U+r7T7G9C9Fnl3+M6RI3fRdU9hB2MgOX1Dzd2ldYQML/Ob
 XYxeVZaGxSkIM6iOzFSBhlMJVNEKAOB7drJ2YvPJPnyLRDNumkIIEPMWARWKmL42XzcT
 pH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573920; x=1787178720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f1cHhDDQS9k4fHmPQCoqY1V3PFVkrqSubkfXzA73XzM=;
 b=PiID/pGV4fJQ3FRKAsVC2doRT/B1ZF9zt5OdmJmlczSIX1vJaFk8NxMF90MzzF1kUY
 yg15nDSYUSJlHHPd0uzlriGFsSB/YADUiKYfZPAlBScw7yU/J0zJOuWevKXIh3P41P/U
 8MWlbSc0epXzxQqX4q3UIVdAJptoNGrIWAvkeRV1UHm7fuAGBP2tPISlRma7LMR3gfX6
 E5tILaQ5UFCnQUJB/elbrvfsdBPma1+vnpx4mjvnMV62WiK4zrU+CyaaJkveatbZG6kd
 LAF8s9zBoxndmlxM3rIHvdaaKipitmPE96lsRe9s8KvzYlvbwY/JRqcFfa59p7NKr9f3
 WCQg==
X-Gm-Message-State: AOJu0Yyuz10gB43WvD1IHXS0poCeRowm1n4HHePrCZDxBdDEFkksJzzo
 CIDRrYNBxmT5sxijKs8ULTNXy8uespiefmC+UOok0RXh1G/tLh5n53qPerzt3+mXaodymIMlluI
 n+oSj
X-Gm-Gg: AR+sD100LEp6wQeBmrqCXiDfAp4i4KNz6LAa3hZkUpiOp3VdWDscwZG8gv6T7obPgDh
 6hvG4m+NY+t1qqgfk3inzFlKin8lWjAdKIIGhQD1QR0eDL4TqjQ729TTeSeswD/fbgvroRehXY/
 i0NK7nQTNUdXVOFxWHJ9bma5eJQh2kj/A8rMm5pcU7B7nxodG6VOekbRIpTEXPkBzXA+1OJDqK8
 mwc2dTM2LVgnuBkMV3hD/uoFPpqTbqwA+9/W4Ae+2OwejylZ15egrOvshjflrhPXEnbIxRb8Wvk
 LCSuXNyLs73s6x/qh7j5LKiyO5bcMl3fwuIaTZlv4yQoIFNzZTN3SE7mmJuXdezryrelZLwlVR3
 5+PeX0Y73tULEEyHCwIFWOIBZP/elJaRnCvb5ycVxnBqDDY0WeH69CzKcVB3JVmAg2WOxbkeySz
 uN2qNliTuy+3Rs5/5naia5RrE0waUA0B1qi2fva03SVqXZfxm9OO5rhWMzlhzwonAK1ma6r34zi
 cB2U6cXzHTHVF+F9bfoPmO6NuRkTWkj
X-Received: by 2002:a05:6a00:300a:b0:84a:2a88:fbd3 with SMTP id
 d2e1a72fcca58-84fc75c3be9mr1192891b3a.20.1786573920090; 
 Wed, 12 Aug 2026 15:32:00 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:31:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 14/52] disas/riscv: Simplify c.addi
Date: Wed, 12 Aug 2026 15:31:04 -0700
Message-ID: <20260812223142.349142-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

While c.addi with imm == 0 and rd == 0 is c.nop,
other c.addi with imm == 0 and rd != 0 are not illegal,
but are reserved as HINTs.  Go ahead and disassemble as
c.addi rather than falling back to invalid.

Further, there's no reason to differentiate c.nop, since we have
  c.addi -> addi -> nop
vs
  c.nop -> addi -> nop
via decompress and pseudo translation steps.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 8a957e6a1e..7978ffb378 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -263,7 +263,6 @@ typedef enum {
     rv_op_c_fsd = 231,
     rv_op_c_sw = 232,
     rv_op_c_fsw = 233,
-    rv_op_c_nop = 234,
     rv_op_c_addi = 235,
     rv_op_c_jal = 236,
     rv_op_c_li = 237,
@@ -1896,10 +1895,9 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "c.sw", rv_codec_cs_sw, rv_fmt_rs2_offset_rs1, NULL, rv_op_sw, rv_op_sw,
       rv_op_sw },
     { "c.fsw", rv_codec_cs_sw, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsw, 0, 0 },
-    { "c.nop", rv_codec_ci_none, rv_fmt_none, NULL, rv_op_addi, rv_op_addi,
-      rv_op_addi },
+    { },
     { "c.addi", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi,
-      rv_op_addi, rvcd_imm_nz },
+      rv_op_addi },
     { "c.jal", rv_codec_cj_jal, rv_fmt_rd_offset, NULL, rv_op_jal, 0, 0 },
     { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi,
       rv_op_addi },
@@ -3010,10 +3008,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
     case 1:
         switch ((inst >> 13) & 0b111) {
         case 0:
-            switch ((inst >> 2) & 0b11111111111) {
-            case 0: op = rv_op_c_nop; break;
-            default: op = rv_op_c_addi; break;
-            }
+            op = rv_op_c_addi; /* or unspecified HINT */
             break;
         case 1:
             if (isa == rv32) {
-- 
2.43.0


