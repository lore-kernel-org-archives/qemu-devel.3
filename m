Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B59BC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvtI4-0003JD-GV; Mon, 17 Aug 2026 05:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtHw-0003G4-BH; Mon, 17 Aug 2026 05:05:49 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtHq-0001dT-GP; Mon, 17 Aug 2026 05:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786957506; bh=yS5sdGj0TvYVlC2VmjuuLCiI0euqI6in4Xr/niktBHI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PDfu3Spr6FVsPg6vTQjiJ5S23bDoItc9xrx1kSn1RAY6bAt+7rxLZGf744NAubRUs
 WPY4PxUcosWJPBcL5OEysF7q86YpF4ZfA8CNB11gfgDb62k25eVWUy1PFWi1U7HsgD
 XG2s6233H1bblWOJIY3eufaVsBMXOSxMcZpTk5vgThn4MSJW/nr2jFWfaPBD1CNmj7
 LBBDRKTzP5Np5EjzvspSQ/a68EnoRvj0Hm/q4oMwTF4Ers4nJ7xaIiNmz1q/x5tyEY
 82pXvPgtDDfuAR83NmCFoz1NCzncAtceOq/mg8WYyCMqgBcfWZnGiKufgHmFVV0qv9
 mgCPzW/7dAI+g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 138EA1CBA39;
 Mon, 17 Aug 2026 12:05:06 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E70E640D01B;
 Mon, 17 Aug 2026 12:05:26 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id ACBD430CEA; Mon, 17 Aug 2026 12:05:00 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 05/42] target/hexagon: accept valid packets rejected
 by check
Date: Mon, 17 Aug 2026 12:04:10 +0300
Message-ID: <20260817090453.2034156-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

has_valid_slot_assignment() rejected any packet with two instructions
assigned to the same slot.  That is too strict.  When a memory
instruction is encoded before a slot-flexible instruction in a packet,
the descending slot assignment places the memory op in slot 1 and the
other in slot 0, then the "mem insns to slot 0" fixup moves the memory
op to slot 0 as well, leaving both in slot 0.  Such a packet is valid
and executes correctly, but the uniqueness test flagged it as
HEX_CAUSE_INVALID_PACKET, raising SIGILL in linux-user and a precise
exception in system mode.

For example this packet, with the load encoded first, was wrongly
rejected:

    { r6 = memw(r3+#-4)
      r7 = #0x4ae6 }

Replace the uniqueness test with a slot-exhaustion check: walk the
instructions in encoding order handing out slots in strictly decreasing
order and fail only if an instruction has no valid slot at or below the
running slot.  This accepts packets that legally share a slot while
still rejecting genuinely unassignable packets, such as a memory
instruction grouped with a duplex, or a load followed by an instruction
that requires a high slot.

Reviewed-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
(cherry picked from commit 0177efb9b75891717c45667e20efe6d6e64f7c82)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index 6eddcca26ed..e6bb7733be8 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -549,21 +549,35 @@ static bool decode_parsebits_is_loopend(uint32_t encoding32)
     return bits == 0x2;
 }
 
+/*
+ * Check that the packet's instructions can be grouped into slots: walk them
+ * in encoding order handing out slots in strictly decreasing order, and fail
+ * if an instruction has no valid slot at or below the running slot.  Two
+ * instructions may legally share a slot, so this does not require unique
+ * slots, only that every instruction fits.
+ */
 static bool has_valid_slot_assignment(Packet *pkt)
 {
-    int used_slots = 0;
-    for (int i = 0; i < pkt->num_insns; i++) {
-        int slot_mask;
-        Insn *insn = &pkt->insn[i];
-        if (decode_opcode_ends_loop(insn->opcode)) {
+    int i;
+    int slot = 3;
+
+    for (i = 0; i < pkt->num_insns; i++) {
+        SlotMask valid_slots;
+        if (decode_opcode_ends_loop(pkt->insn[i].opcode)) {
             /* We overload slot 0 for endloop. */
             continue;
         }
-        slot_mask = 1 << insn->slot;
-        if (used_slots & slot_mask) {
+        if (slot < 0) {
             return false;
         }
-        used_slots |= slot_mask;
+        valid_slots = get_valid_slots(pkt, i);
+        while (!(valid_slots & (1 << slot))) {
+            if (slot <= 0) {
+                return false;
+            }
+            slot--;
+        }
+        slot--;
     }
     return true;
 }
-- 
2.47.3


