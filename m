Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416C9C88E7F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n0V-0003NH-Fq; Wed, 16 Sep 2026 06:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n0T-0003MV-Hr; Wed, 16 Sep 2026 06:36:49 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n0R-0001eb-Kn; Wed, 16 Sep 2026 06:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789554955; bh=aEiT3QG469EI2q0kB1TaPKpLVjDW15SIMXjCpiswMWk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AN4MkmXpPGl8RtsTX0aDizzASfQ/G1LDO/CRdy+3bCbOsYJdi1QQ+Hc2efyzi/SH+
 8TpfIGNa4xuKvhoygLTIpkB2pYJY0w2mlIV0nU6SoHp1U5PhjmWm8R8kCwQ3ZXMtC1
 ClIEu1Lsrjl5grnQqzALDnHqeqfx78tRHla83gndVA9NlTVtvfPPt69XCdJ+Qzejj4
 R7pCCyrOhJsibXckNKbv2JpfphRueNsEm2qTtbbfcv4HCX8TWPlPC6j6hoz+uGSyOn
 mKRnSJCD/NONTTzLbLiDG9CELMQye1HFqyxvjg40fNBXjwOq2wHNLHkrR82Al+Z6t+
 42aYX3BDovM+A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B7C4A1D57F9;
 Wed, 16 Sep 2026 13:35:55 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 80B8D429F58;
 Wed, 16 Sep 2026 13:36:38 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 68F5F5A7ED; Wed, 16 Sep 2026 13:36:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Quante <christian@quante.one>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 06/56] hw/input/ps2: answer unknown mouse commands
 with a resend
Date: Wed, 16 Sep 2026 13:35:24 +0300
Message-ID: <20260916103622.684817-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Christian Quante <christian@quante.one>

ps2_write_mouse() ends its command switch with a bare "default: break;",
so an unknown command draws no reply at all. A real PS/2 device answers
every byte it is given -- ACK (0xFA) when it understood one, resend
(0xFE) when it did not -- and a guest that gets nothing back is left
waiting out its reply timeout. The keyboard path in the same file has
answered unknown commands with KBD_REPLY_RESEND since commit
06b3611fc2a3 ("ps2: reject unknown commands, instead of blindly
accepting them").

Two guests were measured on this.

OS/2 probes the mouse with the vendor command 0xBB, which QEMU does not
implement, and then polls the status port until its own timeout runs
out. On a Warp 3 guest that wait costs about 25 ms of every boot under
TCG, and 2.1 s under KVM, where each of those polls leaves the guest.
With this patch the wait ends on the first read: the guest takes the
same error path an unexpected reply would, and does not retry.

Linux runs into two of them while probing the mouse: the ALPS probe
sends 0xEC (reset wrap mode), which ps2_write_mouse() only answers
while the mouse is in wrap mode, and the TrackPoint probe sends 0xE1.
Each costs libps2 a 200 ms reply timeout. Timing the psmouse detection
from a mark written to /dev/kmsg to the kernel's "input:" line, three
boots each of a 6.18.35 kernel under TCG: 426.7/428.8/441.6 ms without
this patch, 21.4/21.6/21.2 ms with it. The mouse is detected
identically either way; only the error the probe ends in changes, from
-EIO (nothing came back at all) to -EPROTO (libps2 gives up after its
second attempt).

The specification's second stage -- 0xFC (Error) when the byte after a
rejected one is invalid as well -- is deliberately left out. It would
need state that has to survive migration, no guest is known to test for
it, and the keyboard path does without it as well.

Cc: qemu-stable@nongnu.org
Signed-off-by: Christian Quante <christian@quante.one>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260825075127.34876-2-christian@quante.one>
(cherry picked from commit 0846740652d1333369265fa075708b5a386c5ff6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 5516eb262d7..e8300d2d830 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -73,6 +73,7 @@
 #define AUX_SET_DEFAULT     0xF6
 #define AUX_RESET           0xFF    /* Reset aux device */
 #define AUX_ACK             0xFA    /* Command byte ACK. */
+#define AUX_RESEND          0xFE    /* Command NACK, send the cmd again */
 
 #define MOUSE_STATUS_REMOTE     0x40
 #define MOUSE_STATUS_ENABLED    0x20
@@ -955,6 +956,11 @@ void ps2_write_mouse(PS2MouseState *s, int val)
                 s->mouse_type);
             break;
         default:
+            /*
+             * A PS/2 device answers every command it is given; an unknown
+             * one draws a resend.
+             */
+            ps2_queue(ps2, AUX_RESEND);
             break;
         }
         break;
-- 
2.47.3


