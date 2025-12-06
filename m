Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698DED3B7D8
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Dec 2025 18:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRwyX-0001mu-FN; Sat, 06 Dec 2025 13:25:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.qemu@xen0n.name>) id 1vRwyM-0001lj-Hz
 for qemu-devel@nongnu.org; Sat, 06 Dec 2025 13:25:34 -0500
Received: from mail.xen0n.name ([115.28.160.31] helo=mailbox.box.xen0n.name)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.qemu@xen0n.name>) id 1vRwyI-0007aI-P4
 for qemu-devel@nongnu.org; Sat, 06 Dec 2025 13:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
 t=1765045488; bh=6GCm88dXNYy/3rkdxxT04Pk/3f0lZZt+faUI8M7IJZw=;
 h=From:To:Cc:Subject:Date:From;
 b=ZGpMA1ISzGxDmOFPXs4dHoAO/0mApfKwTgMgg0JQsSPbKaC50lbT/yZwQQLf7BXj+
 8rK0nGGiM6dol9Hk/9urD+acMvW8JWxffM4kAEi8n9RQe/E/3wEzZMGN41HQ6Ds7QW
 ag7wSbyW+z0IULX3Yz40Mdq5iJF1xBy1I1c+JZ6Q=
Received: from ld50.lan (unknown [IPv6:240e:b8f:939d:bb00::8c0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 886FF60110;
 Sun,  7 Dec 2025 02:24:47 +0800 (CST)
From: WANG Xuerui <i.qemu@xen0n.name>
To: qemu-devel@nongnu.org
Cc: WANG Xuerui <git@xen0n.name>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 xtex <xtex@aosc.io>
Subject: [PATCH] tcg/loongarch64: Support every TCGCond for cmp_vec ops
Date: Sun,  7 Dec 2025 02:24:45 +0800
Message-ID: <20251206182445.3656223-1-i.qemu@xen0n.name>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.28.160.31; envelope-from=i.qemu@xen0n.name;
 helo=mailbox.box.xen0n.name
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: WANG Xuerui <git@xen0n.name>

Support for TCGCond's in loongarch64 cmp_vec codegen is not uniform: NE
is not supported at all and will trip over assertions, and legalization
(currently just operand-swapping) is not done for reg-imm comparisons.
Since the TCG middle-end will not legalize the comparison conditions for
us, we have to do it ourselves like other targets.

Because EQ/LT/LTU/LE/LEU are natively supported, we only have to keep
the current operand swapping treatment for GT/GTU/GE/GEU but ensure it
is done for both reg-reg and reg-imm cases, and use a bitwise NOT to
help legalize NE.

While at it, lift the cmp_vec handling to own function to make it easier
for readers.

Fixes: d8b6fa593d2d ("tcg/loongarch64: Lower cmp_vec to vseq/vsle/vslt")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3237
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Reported-by: xtex <xtex@aosc.io>
Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 tcg/loongarch64/tcg-target.c.inc | 119 +++++++++++++++++++------------
 1 file changed, 75 insertions(+), 44 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 10c69211ac5..1a243a57beb 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2179,15 +2179,38 @@ static void tcg_out_addsub_vec(TCGContext *s, bool lasx, unsigned vece,
     tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
 }
 
-static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
-                           unsigned vecl, unsigned vece,
-                           const TCGArg args[TCG_MAX_OP_ARGS],
-                           const int const_args[TCG_MAX_OP_ARGS])
+static void tcg_out_cmp_vec(TCGContext *s, bool lasx, unsigned vece,
+                            TCGArg a0, TCGArg a1, TCGArg a2,
+                            bool a2_is_const, TCGCond cond)
 {
-    TCGType type = vecl + TCG_TYPE_V64;
-    bool lasx = type == TCG_TYPE_V256;
-    TCGArg a0, a1, a2, a3;
     LoongArchInsn insn;
+    bool need_invert = false;
+
+    switch (cond) {
+    case TCG_COND_EQ:
+    case TCG_COND_LE:
+    case TCG_COND_LEU:
+    case TCG_COND_LT:
+    case TCG_COND_LTU:
+        /* These are directly expressible. */
+        break;
+    case TCG_COND_NE:
+        need_invert = true;
+        cond = TCG_COND_EQ;
+        break;
+    case TCG_COND_GE:
+    case TCG_COND_GEU:
+    case TCG_COND_GT:
+    case TCG_COND_GTU:
+        {
+            TCGArg t;
+            t = a1, a1 = a2, a2 = t;
+            cond = tcg_swap_cond(cond);
+            break;
+        }
+    default:
+        g_assert_not_reached();
+    }
 
     static const LoongArchInsn cmp_vec_insn[16][2][4] = {
         [TCG_COND_EQ] = {
@@ -2233,6 +2256,49 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
             { OPC_XVSLTI_BU, OPC_XVSLTI_HU, OPC_XVSLTI_WU, OPC_XVSLTI_DU },
         }
     };
+
+    if (a2_is_const) {
+        /*
+         * cmp_vec dest, src, value
+         * Try vseqi/vslei/vslti
+         */
+        int64_t value = sextract64(a2, 0, 8 << vece);
+
+        insn = cmp_vec_imm_insn[cond][lasx][vece];
+        switch (cond) {
+        case TCG_COND_EQ:
+        case TCG_COND_LE:
+        case TCG_COND_LT:
+            tcg_out32(s, encode_vdvjsk5_insn(insn, a0, a1, value));
+            break;
+        case TCG_COND_LEU:
+        case TCG_COND_LTU:
+            tcg_out32(s, encode_vdvjuk5_insn(insn, a0, a1, value));
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    } else {
+        insn = cmp_vec_insn[cond][lasx][vece];
+        tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
+    }
+
+    if (need_invert) {
+        insn = lasx ? OPC_XVNOR_V : OPC_VNOR_V;
+        tcg_out32(s, encode_vdvjvk_insn(insn, a0, a0, a0));
+    }
+}
+
+static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
+                           unsigned vecl, unsigned vece,
+                           const TCGArg args[TCG_MAX_OP_ARGS],
+                           const int const_args[TCG_MAX_OP_ARGS])
+{
+    TCGType type = vecl + TCG_TYPE_V64;
+    bool lasx = type == TCG_TYPE_V256;
+    TCGArg a0, a1, a2, a3;
+    LoongArchInsn insn;
+
     static const LoongArchInsn neg_vec_insn[2][4] = {
         { OPC_VNEG_B, OPC_VNEG_H, OPC_VNEG_W, OPC_VNEG_D },
         { OPC_XVNEG_B, OPC_XVNEG_H, OPC_XVNEG_W, OPC_XVNEG_D },
@@ -2347,43 +2413,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         insn = lasx ? OPC_XVNOR_V : OPC_VNOR_V;
         goto vdvjvk;
     case INDEX_op_cmp_vec:
-        {
-            TCGCond cond = args[3];
-
-            if (const_args[2]) {
-                /*
-                 * cmp_vec dest, src, value
-                 * Try vseqi/vslei/vslti
-                 */
-                int64_t value = sextract64(a2, 0, 8 << vece);
-                switch (cond) {
-                case TCG_COND_EQ:
-                case TCG_COND_LE:
-                case TCG_COND_LT:
-                    insn = cmp_vec_imm_insn[cond][lasx][vece];
-                    tcg_out32(s, encode_vdvjsk5_insn(insn, a0, a1, value));
-                    break;
-                case TCG_COND_LEU:
-                case TCG_COND_LTU:
-                    insn = cmp_vec_imm_insn[cond][lasx][vece];
-                    tcg_out32(s, encode_vdvjuk5_insn(insn, a0, a1, value));
-                    break;
-                default:
-                    g_assert_not_reached();
-                }
-                break;
-            }
-
-            insn = cmp_vec_insn[cond][lasx][vece];
-            if (insn == 0) {
-                TCGArg t;
-                t = a1, a1 = a2, a2 = t;
-                cond = tcg_swap_cond(cond);
-                insn = cmp_vec_insn[cond][lasx][vece];
-                tcg_debug_assert(insn != 0);
-            }
-        }
-        goto vdvjvk;
+        tcg_out_cmp_vec(s, lasx, vece, a0, a1, a2, const_args[2], a3);
+        break;
     case INDEX_op_add_vec:
         tcg_out_addsub_vec(s, lasx, vece, a0, a1, a2, const_args[2], true);
         break;
-- 
2.52.0


