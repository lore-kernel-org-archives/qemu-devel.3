Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06432C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 06:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbN-00059F-2P; Mon, 24 Aug 2026 01:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZd-0002hX-GR
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:22 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZb-0002Q0-SH
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:21 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38e08baf860so3373064a91.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550618; x=1788155418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cjyHLAWuHJgJ/+lIjyXwN6xYrYB6otvsADCyVj8AJtU=;
 b=Q4LCP41sv8+M89j8MdOKs55IytLCZiPUpfwo6sMxOC10RwrGOOmXKhf9LfC89Wjo82
 IGYdyP993LosSlypjB8qnUVV34Y51EEwglJ7sJ7JVLNAADWIXn7LhBPYKG2q7pdzoenx
 WqDVtj4aH5nf34WQn3U8lL88LKWUs5QnGkkViU3lc8ATI5KPX9B9wDTaJyOHpwuAYdbN
 4rWlML4DE6YAxIysVjXjK+AbleKln00A+jLIwNIVxNG0vTrJneVYCdYzjQ1MVxfrHhG2
 WSadK1LsJyHDPEx/a1Hukd28ILAoxEauBNEHoATWPy8ZosuQC/pwrf5RY6lUhemHepKb
 440Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550618; x=1788155418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cjyHLAWuHJgJ/+lIjyXwN6xYrYB6otvsADCyVj8AJtU=;
 b=EKCGFOdxk64hpDxA+OpChEEQEz22mNAlKF5msfTUSIdrQR0Vkx4wy2fM6AIfPBPc5/
 PfpPz20KB/qNKIWqBb5GUqqD/CdktJgMGNxhiOcp/JT/VVahMcEJIRFKGKxPw3kYEanI
 iVdNOKsmJlSdkll4pF8XDh/RKLqOl8Z4OjgAdHijVUbADKurhJZhFHXJcYRsls09WIZ9
 zSPHl0JuIiFeD52eXGY8PrEQbiyx8uYd5xMXyF4ne9Ij0yqngDtoqG9MC7u4AHumWLwr
 EmiJE1a5F0i3RiKee0HsNE/5Dsrpz/CUnWlVNmh+G3XaOn9T1pDXV4SJkBuwQ/G1rsC0
 9gAw==
X-Gm-Message-State: AFuF++nwGWWIswafwsDYYOjneVQ3iHdDyD6KLDRzrVDaW+1w8ObYZFb+
 ilx3MANbjDWPi8kLu51h0kpn4MDWxOIgghCB/baMBCtoUsdYSPtIl70T1JLRTw==
X-Gm-Gg: AR+sD10VOu9eFEeDkN2mjFoDc+5A5XQw4mFXyT58a04JpDOaGEVkYC7Lhk/O9px2xm2
 NY/8CBGdx/Mg3Z58/Cei4NrGZQISYaxBDMFiCl5w1V4aFKn3OnLo0+1/Zgp89SlSgLXtSxul8Bw
 LdY/RBtkPyCf9+FY/GV7PieMKYFO2XdydoUEhPG4tjetNlBoTEUzwK2d7LTu0up31nmbjHSTDJf
 i8l4qXpiUQDUMw8m3FLuGToxzKnscTQABBLsi5b2vWhUFQMH620LMX+K1G1QUjtDIY3aDJyS9u/
 85INkyyQgpBiCZAqtK0v7h1R0N35VovSaL1Pb+2r2uSUx+5PGDF3e869D9Fo+gJOq25tdrtg91y
 L2puauw1xxYn8b47tJga7zgDbAEs7DYtvDdloxCrg89BskJuGIYetLmrvOcmLXmPoQfij+m0nSQ
 g5FvASX9hLcxCJ0XTOiL9y96xkYeeUSuA51uPRFBIA4ife9rAN4XlosGbKUxpT6j5mob3lCpAx3
 EM6Wg==
X-Received: by 2002:a17:90b:2cc3:b0:392:e5b1:d833 with SMTP id
 98e67ed59e1d1-395df29666cmr29931094a91.13.1787550618526; 
 Sun, 23 Aug 2026 22:50:18 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:50:18 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 38/96] disas/riscv: Pass rv_opcode_data pointer to/from
 decode_inst_decompress
Date: Mon, 24 Aug 2026 15:47:08 +1000
Message-ID: <20260824054806.2790041-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Unify 4 functions, sharing code.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-6-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 70 ++++++++++++++++-----------------------------------
 1 file changed, 21 insertions(+), 49 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index af43940732..47fae7316c 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5377,64 +5377,36 @@ static void decode_inst_lift_pseudo(rv_decode *dec)
 
 /* decompress instruction */
 
-static void decode_inst_decompress_rv32(rv_decode *dec)
+static const rv_opcode_data *decode_inst_decompress(rv_decode *dec, rv_isa isa,
+                                                    const rv_opcode_data *op)
 {
-    const rv_opcode_data *opcode_data = dec->opcode_data;
-    int decomp_op = opcode_data[dec->op].decomp_rv32;
-    if (decomp_op != rv_op_illegal) {
-        if ((opcode_data[dec->op].decomp_data & rvcd_imm_nz)
-            && dec->imm == 0) {
-            dec->op = rv_op_illegal;
-        } else {
-            dec->op = decomp_op;
-            dec->codec = opcode_data[decomp_op].codec;
-        }
-    }
-}
-
-static void decode_inst_decompress_rv64(rv_decode *dec)
-{
-    const rv_opcode_data *opcode_data = dec->opcode_data;
-    int decomp_op = opcode_data[dec->op].decomp_rv64;
-    if (decomp_op != rv_op_illegal) {
-        if ((opcode_data[dec->op].decomp_data & rvcd_imm_nz)
-            && dec->imm == 0) {
-            dec->op = rv_op_illegal;
-        } else {
-            dec->op = decomp_op;
-            dec->codec = opcode_data[decomp_op].codec;
-        }
-    }
-}
+    int decomp_op;
 
-static void decode_inst_decompress_rv128(rv_decode *dec)
-{
-    const rv_opcode_data *opcode_data = dec->opcode_data;
-    int decomp_op = opcode_data[dec->op].decomp_rv128;
-    if (decomp_op != rv_op_illegal) {
-        if ((opcode_data[dec->op].decomp_data & rvcd_imm_nz)
-            && dec->imm == 0) {
-            dec->op = rv_op_illegal;
-        } else {
-            dec->op = decomp_op;
-            dec->codec = opcode_data[decomp_op].codec;
-        }
-    }
-}
-
-static void decode_inst_decompress(rv_decode *dec, rv_isa isa)
-{
     switch (isa) {
     case rv32:
-        decode_inst_decompress_rv32(dec);
+        decomp_op = op->decomp_rv32;
         break;
     case rv64:
-        decode_inst_decompress_rv64(dec);
+        decomp_op = op->decomp_rv64;
         break;
     case rv128:
-        decode_inst_decompress_rv128(dec);
+        decomp_op = op->decomp_rv128;
         break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (decomp_op != rv_op_illegal) {
+        if ((op->decomp_data & rvcd_imm_nz) && dec->imm == 0) {
+            dec->opcode_data = rvi_opcode_data;
+            dec->op = rv_op_illegal;
+        } else {
+            dec->op = decomp_op;
+        }
+        op = &dec->opcode_data[decomp_op];
+        dec->codec = op->codec;
     }
+    return op;
 }
 
 /* disassemble instruction */
@@ -5491,7 +5463,7 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
 
     op = &dec.opcode_data[dec.op];
     decode_inst_operands(&dec, isa, op);
-    decode_inst_decompress(&dec, isa);
+    op = decode_inst_decompress(&dec, isa, op);
     decode_inst_lift_pseudo(&dec);
     return format_inst(24, &dec);
 }
-- 
2.54.0


