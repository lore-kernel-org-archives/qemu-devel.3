Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEBACCF2C9
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 05:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIJHO-0000Cl-Nn; Sun, 18 Oct 2026 01:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xIJHK-0000CL-1p
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 01:17:50 -0400
Received: from nx236.node01.secure-mailgate.com ([89.22.108.236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1xIJHH-0001Ay-Eu
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 01:17:49 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node01.secure-mailgate.com with esmtps (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <christian@quante.one>)
 id 1xIJHC-007xj4-Ju; Sun, 18 Oct 2026 07:17:43 +0200
Received: from Zeuss.fritz.box (p57b2fda0.dip0.t-ipconnect.de [87.178.253.160])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id D2B1B282AB1;
 Sun, 18 Oct 2026 07:17:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1792300662;
 bh=EP2rpgKgjzi8mP1goSgycQWAnVWPm6jQAT61285CC2s=;
 h=From:To:Cc:Subject:Date:From;
 b=j2TODuua7lsbfLyRx83M8+Fj4em7zeyNAwf2kI+9Y0I7h7acRl4yoghnVb98/Olag
 Ww3vtfTofrFqkZN71zDG0zAOW7sQ6wsx9O+fQ5zKQ37LpRTXLyETdYGLv4v32x9W82
 w6ctrC6cn3h+L2yrFpwHFmntx0Q6SCxn5BRs/PKs=
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] hw/input/pckbd: raise the keyboard irq for 0xd2 also while
 disabled
Date: Sun, 18 Oct 2026 07:17:13 +0200
Message-ID: <20261018051715.12267-1-christian@quante.one>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <179230066131.397781.9034412120309008868@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: SB/global_tokens (0.000313505442682)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuWQDuxDjzdGbWmDwyrhEgr90sBUeyjuFYic
 ayvrgsfj1Cu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4Y07ZQFkwKdAbrPqTYt2Kl8S5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99RMgoMVb7lebWWPLzvZvEUCPdOtYechJ/ikE1WgRg4cS6K5mANmx2g/2xIniaWLUPf0al0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgm3QTha208ypFqQwBFb
 xm4JX7semJdl8Weuy8+tlMSTQwhoy9D5QZ6a84vJal7pM1XhlAOd290vPXa7Loma0jth+x0iJ0NX
 07iZIeUSWePdS+owFPr4kjXuZPwOU47Z9+uiyBzEoUPergF1Fr7PXRtjTffsOB8F7c9lBceogHQ4
 /ADG0FyWKtan2R3jnELtGjVlIqecxOBP1yJf91UNzkSEUDq6mKQ/XAiI42Mzh38yXz3dKxLhoxcm
 aInYbR5vlqHlDhVAB/0EYD/jnz2OZJv6szlVwj1n2JAvHUSGQgae904HZe+Npbm5PA9zxaDCuu7n
 enbrzWUw2X62ZQfetBN+Wd6yNxOSUIsmGCJDuSiGSNdj68Lf4FNI5GmjYNknO4WLIFZtYLHBUTps
 l3R7CReAta0GbUei82mY0H6Chww1cz80oxZpqzGK0CNfmEFbcNY9tQrhDVxWCGj1JArKPJWkG7EB
 ouE/Lp65oEK6Kr4PFISAzVaFNHfkjGyFyiRzr7YOhfiboNBv0POUVLQJNXGP/GGMrN0VgEP1fddi
 hPZrzx1Lw2yMf4vpvhlM+vErQ1gn6IjLLbcvolUaG2pSKCEkiWrFfcvTzpdI3AEG059XQdWGh3EH
 O+AUBK5+ekb1JyB3OnKG9eRDP2/Ogb+c8D2oSvdcBJ1869L2y5ERFHC8NPIK4B7OUVSn0kbL6D23
 dfd3aH2fATPqEIe+zbt2NwyT7DYzFfTn4NXnBjEun9DvZ0n9a1rfFCnSMsc+vEwrNstTbe4wBw6S
 kC2jAENWaINDgXBbKTIlqNpRK89muFbKwBsa9A+nmEd7cRVfyxrpZ1WT35ix5VehBc2cUR742vO7
 eUcOGCmJTaorUhtlNRknxw==
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=89.22.108.236; envelope-from=christian@quante.one;
 helo=nx236.node01.secure-mailgate.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

QEMU raises no keyboard irq while the keyboard is disabled
(KBD_MODE_DISABLE_KBD, for example after KBD_CCMD_KBD_DISABLE 0xad).
This also applies to the bytes that the controller itself puts into the
output buffer, such as the answer to KBD_CCMD_READ_MODE (0x20) or a
byte that the guest writes with KBD_CCMD_WRITE_OBUF (0xd2).

The keyboard driver of the OS/2 Warp 4 installation (IBMKBD.SYS,
1996-09-09, code at file offsets 0xf08 and 0xf8b) disables the
keyboard, sends 0x20, reads port 0x60 at once and then waits for the
keyboard irq.  If the irq does not come within about 0.35 seconds, the
driver writes the byte that it has read back with 0xd2 and waits again,
so it expects an irq for this byte.  With
QEMU, this irq does not come either.  The driver then loses track of
its command sequence and leaves the keyboard disabled: the installation
does not accept the Enter key after the request for diskette 2.

0xd2 puts a byte into the output buffer as if the keyboard had sent it
(HelpPC 2.10, 8042 commands: "as if initiated by a device; invokes
interrupt if enabled").  Bochs (controller_enQ() in keyboard.cc) and
86Box (kbc_send_to_ob() in kbc_at.c) raise the keyboard irq for every
byte in the output buffer that does not come from the mouse, if bit 0
of the command byte is set.  They do this also while the keyboard is
disabled.

Raise the irq while the keyboard is disabled, but only for a byte from
0xd2.  The answers to other controller commands keep the old behaviour,
because an irq for them causes a problem with the emulated 8259: the
8259 of QEMU and the 8259 of KVM keep the edge request of a masked line
after the line has gone low again, but a real 8259A drops it (Intel
8259A data sheet: "the request latch is a transparent D type latch",
and "the IR inputs must remain high until after the falling edge of the
first INTA").  Windows for Workgroups 3.11 masks IRQ 1,
sends 0xad and 0x20, and polls for the answer.  With an irq for the
answer, it gets a stale IRQ 1 with an empty output buffer when it
unmasks the line, and then it masks IRQ 1 for good, so the keyboard
does not work any more.  In my traces (start of Windows for Workgroups
up to the first dialog box, and one key press), it does not use 0xd2.

A new flag in "pending" marks the byte from 0xd2.  The flag is only set
with the extended state of the i8042, so machine types 6.0 and older
keep the old behaviour.  It is migrated with
"pending"; an older QEMU clears unknown flags in kbd_post_load() and
keeps its old behaviour for this byte.

With this patch, the Warp 4 installation goes on after the 0xd2
fallback (one delay of about 0.35 seconds, tested with TCG).

Signed-off-by: Christian Quante <christian@quante.one>
---

Notes:
    Windows for Workgroups 3.11 and OS/2 Warp 3 (both with KVM) work as
    before.  Both runs, and the traces of Windows for Workgroups above, used
    my Cirrus patches (the first series is
    <20261018050643.9288-1-christian@quante.one>, the others follow),
    because the Cirrus display drivers of these guests need them; the
    keyboard path does not depend on them.

 hw/input/pckbd.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index b09c3bce93..06b4c5d9ea 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -139,6 +139,7 @@
 #define KBD_PENDING_CTRL_AUX    0x08
 #define KBD_PENDING_KBD         KBD_MODE_DISABLE_KBD    /* 0x10 */
 #define KBD_PENDING_AUX         KBD_MODE_DISABLE_MOUSE  /* 0x20 */
+#define KBD_PENDING_CTRL_OBUF   0x40
 
 #define KBD_MIGR_TIMER_PENDING  0x1
 
@@ -149,7 +150,10 @@
 
 /*
  * XXX: not generating the irqs if KBD_MODE_DISABLE_KBD is set may be
- * incorrect, but it avoids having to simulate exact delays
+ * incorrect, but it avoids having to simulate exact delays.
+ * A byte from KBD_CCMD_WRITE_OBUF raises the irq also while the keyboard
+ * is disabled: a guest may write a byte with this command and then wait
+ * for the keyboard irq.
  */
 static void kbd_update_irq_lines(KBDState *s)
 {
@@ -165,7 +169,9 @@ static void kbd_update_irq_lines(KBDState *s)
             }
         } else {
             if ((s->mode & KBD_MODE_KBD_INT) &&
-                !(s->mode & KBD_MODE_DISABLE_KBD)) {
+                (!(s->mode & KBD_MODE_DISABLE_KBD) ||
+                 ((s->obsrc & KBD_OBSRC_CTRL) &&
+                  (s->pending & KBD_PENDING_CTRL_OBUF)))) {
                 irq_kbd_level = 1;
             }
         }
@@ -282,7 +288,8 @@ static void kbd_queue(KBDState *s, int b, int aux)
 {
     if (s->extended_state) {
         s->cbdata = b;
-        s->pending &= ~KBD_PENDING_CTRL_KBD & ~KBD_PENDING_CTRL_AUX;
+        s->pending &= ~KBD_PENDING_CTRL_KBD & ~KBD_PENDING_CTRL_AUX &
+                      ~KBD_PENDING_CTRL_OBUF;
         s->pending |= aux ? KBD_PENDING_CTRL_AUX : KBD_PENDING_CTRL_KBD;
         kbd_safe_update_irq(s);
     } else {
@@ -290,11 +297,21 @@ static void kbd_queue(KBDState *s, int b, int aux)
     }
 }
 
+static void kbd_queue_obuf(KBDState *s, int b)
+{
+    kbd_queue(s, b, 0);
+    if (s->extended_state) {
+        s->pending |= KBD_PENDING_CTRL_OBUF;
+        kbd_update_irq_lines(s);
+    }
+}
+
 static uint8_t kbd_dequeue(KBDState *s)
 {
     uint8_t b = s->cbdata;
 
-    s->pending &= ~KBD_PENDING_CTRL_KBD & ~KBD_PENDING_CTRL_AUX;
+    s->pending &= ~KBD_PENDING_CTRL_KBD & ~KBD_PENDING_CTRL_AUX &
+                  ~KBD_PENDING_CTRL_OBUF;
     if (kbd_pending(s)) {
         kbd_update_irq(s);
     }
@@ -450,7 +467,7 @@ static void kbd_write_data(void *opaque, hwaddr addr,
         kbd_safe_update_irq(s);
         break;
     case KBD_CCMD_WRITE_OBUF:
-        kbd_queue(s, val, 0);
+        kbd_queue_obuf(s, val);
         break;
     case KBD_CCMD_WRITE_AUX_OBUF:
         kbd_queue(s, val, 1);
@@ -608,7 +625,7 @@ static int kbd_post_load(void *opaque, int version_id)
     }
     /* clear all unused flags */
     s->pending &= KBD_PENDING_CTRL_KBD | KBD_PENDING_CTRL_AUX |
-                  KBD_PENDING_KBD | KBD_PENDING_AUX;
+                  KBD_PENDING_CTRL_OBUF | KBD_PENDING_KBD | KBD_PENDING_AUX;
     return 0;
 }
 
-- 
2.53.0


