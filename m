Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85120C5DF81
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 07:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy2RB-0006Qt-1V; Sun, 23 Aug 2026 03:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wy2R9-0006Qi-BU
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 03:16:11 -0400
Received: from nx38.node01.secure-mailgate.com ([89.22.108.38])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian@quante.one>)
 id 1wy2R7-0000oq-5e
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 03:16:11 -0400
Received: from web279.dogado.net ([31.47.255.59])
 by node01.secure-mailgate.com with esmtps (TLS1.2) tls
 TLS_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <christian@quante.one>)
 id 1wy2R0-00GwcC-P4; Sun, 23 Aug 2026 09:16:04 +0200
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quante.one;
 s=cloudpit; t=1787469359;
 bh=By1lu3n2s3L5zNsSgNA4XfMp0fx3WS4b/BVEdjo0FzU=;
 h=From:To:Cc:Subject:Date:From;
 b=ZlAUSFwChn2Br/wkHmS0jSujXUP4fxQq/GJ4w6q0soskDzzu3oGDuGCWmGqU1/8dX
 8Gnyzumb400dg5F25k+RdzfHff44fKohKB0wW3COrbf2LnDNwjP+2Ru/gJYPlMNlpC
 0VdJrVrWxJd+G0q93ZHla9K8RHBhgE5iljkBZwJo=
Received: from Zeuss.fritz.box (p549f1be3.dip0.t-ipconnect.de [84.159.27.227])
 (Authenticated sender: christian@quante.one)
 by web279.dogado.net (Postfix) with ESMTPSA id 10227280652;
 Sun, 23 Aug 2026 09:15:59 +0200 (CEST)
X-SecureMailgate-Identity: christian@quante.one;web279.dogado.net
From: Christian Quante <christian@quante.one>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Christian Quante <christian@quante.one>
Subject: [PATCH] hw/input/ps2: answer unknown mouse commands with a resend
Date: Sun, 23 Aug 2026 09:15:28 +0200
Message-ID: <20260823071529.16389-1-christian@quante.one>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178746935961.2681787.12206641510893453916@web279.dogado.net>
X-PPP-Vhost: quante.one
X-Originating-IP: 31.47.255.59
X-SecureMailgate-Domain: web279.dogado.net
X-SecureMailgate-Username: 31.47.255.59
Authentication-Results: secure-mailgate.com;
 auth=pass smtp.auth=31.47.255.59@web279.dogado.net
X-SecureMailgate-Outgoing-Class: ham
X-SecureMailgate-Outgoing-Evidence: SB/global_tokens (0.00248173966136)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuVAbghcjzCMj9agjjk9wivV3TvQP7denkvp
 tYMocagoeCu2SmbhJN1U9FKs8X3+Nt1HOctZ5X+40a9IXddeG3M38JQYgcgjsac3uQcQdCX4ROfH
 zJ6mVE7ewsipSVIfs4YBWMI0kHH6ccxxYgKRbnuyS5+h1uiHzk/Rfxfh461YLyu3RZI1CD15pCOE
 1vk99ROIQSXp0prcVkrsJtqLDcOMdOtYechJ/ikE1WgRg4cS6K5mANmx2g/2xIniaWLUPf0al0h7
 43VOpKNY+4MjijihZK0EMmf3P50Ajf/tIX00Fuu2beRqilmjgQ6jA3UwYgm3QTha208ypFqQwBFb
 xm4JX7semJdl8Weuy8+tlMSTQwhoy9D5QZ6a84vJal7pM1XhlAOd290vPXa7Loma0jth+x0iJ0NX
 07iZIeUSWePdS+owFPr4kjXuZPwOU47Z9+s09nAWqoDs8zZa/KiCJd90Lk7053RUfwPXoECB9OvJ
 bEB3ZiIyIjwOoMnQjl6CrKp8EdZ8SizDtPkcGuerFSnVOYtq+HE3WG85mIDi374DW/icy5el5aWU
 /wf4ShFNzAzxuUotuUNGy5ExxW0GC5CkQjQ6zWGsvxsVC/m+yny0Rue4mmnjPFy3dPHP2FzOds3E
 46oSR4SMslNlGoPN/ReRDyx85JvPA3M+w5jBayuCMVamoWktV59525k34keYykbMQrAIKOj+9hX4
 DXX27MdKse0EuSSr7btxBu5GkHP0MO/iDzcBQTphqKbEazY5fbVoh9VoIekQHpwUfpYnEThmBYJb
 VMG52ZGVwnbZoccL6hb/zozlfY561u9Hn4cUO1fzYYXc64pg+rLT+Ot3L8AutF7Ey5dhohH1DJe4
 xKbBicPC1/Rnj77R/+sTEK1dN5vsJ9kuQgio2RjilK0QWzDS9OQPoavkwPMV2SuvcnEWOuw2MxX0
 5+DV5wYxLp/Q72cFKjFopoBzI+w6TKsrBBDgOPIh4HEPoN/NFnLJ6oXdnjOfbpfTHUB7Gt5iiSuf
 1ArWb2AAC8Y+67JeaTvmY/5qnmWiS9Y/KFRQf8e9WAFIg8gdqFY8KQ9Egxp4UGe16U/eGVjath4b
 vkom8c4V/PtEw6nIoDr0sXUZ7YZoZ/GZ+g6r2+bdtWXb1z9s4uNhgHLX+AZlS2zN461BhwVoVaJE
 tlw222OyNqTeU9tH1jYC/i8C7bWQrrnqtP27In+yOBOqEi1X3qoM14sIpnfztEwQP0Uw9n8VcNp0
 5ACBU/pi9Ze6aNYZYil6cObjel6n0jQ=
X-Report-Abuse-To: spam@node04.secure-mailgate.com
X-Complaints-To: abuse@node01.secure-mailgate.com
Received-SPF: pass client-ip=89.22.108.38; envelope-from=christian@quante.one;
 helo=nx38.node01.secure-mailgate.com
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

ps2_write_mouse() ends its command switch with a bare "default: break;",
so an unknown command draws no reply at all. A real PS/2 device answers
every byte it is given -- ACK (0xFA) when it understood one, resend
(0xFE) when it did not -- and a guest that gets nothing back is left
waiting out its reply timeout. The keyboard path in the same file has
always answered unknown commands with KBD_REPLY_RESEND.

Two guests were measured on this.

OS/2 probes the mouse with the vendor command 0xBB, which QEMU does not
implement, and then polls the status port until its own timeout runs
out. On a Warp 3 guest that wait costs about 25 ms of every boot under
TCG, and 2.1 s under KVM, where each of those polls leaves the guest.
With this patch the wait ends on the first read: the guest takes the
same error path an unexpected reply would, and does not retry.

Linux probes for a TrackPoint with 0xE1 and fails the same way. Timing
the psmouse detection from a mark written to /dev/kmsg to the kernel's
"input:" line, three boots each of a 6.18.35 kernel under TCG:
426.7/428.8/441.6 ms without this patch, 21.4/21.6/21.2 ms with it. The
mouse is detected identically either way; libps2 caps its retries at
two attempts and ends in the same -EPROTO the timeout produced.

The specification's second stage -- 0xFC (Error) when the byte after a
rejected one is invalid as well -- is deliberately left out. It would
need state that has to survive migration, no guest is known to test for
it, and the keyboard path has answered unknown commands with a bare
resend for twenty years.

Signed-off-by: Christian Quante <christian@quante.one>
---
 hw/input/ps2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 5516eb262d..1e8c6d983a 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -73,6 +73,7 @@
 #define AUX_SET_DEFAULT     0xF6
 #define AUX_RESET           0xFF    /* Reset aux device */
 #define AUX_ACK             0xFA    /* Command byte ACK. */
+#define AUX_RESEND          0xFE    /* Command NACK, send the cmd again */
 
 #define MOUSE_STATUS_REMOTE     0x40
 #define MOUSE_STATUS_ENABLED    0x20
@@ -955,6 +956,13 @@ void ps2_write_mouse(PS2MouseState *s, int val)
                 s->mouse_type);
             break;
         default:
+            /*
+             * A PS/2 device answers every command it is given; an unknown
+             * one draws a resend. Staying silent leaves the guest waiting
+             * out its reply timeout. The keyboard path above answers
+             * unknown commands with KBD_REPLY_RESEND.
+             */
+            ps2_queue(ps2, AUX_RESEND);
             break;
         }
         break;
-- 
2.53.0


