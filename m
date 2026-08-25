Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAB5C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypMw-0006CA-Rp; Tue, 25 Aug 2026 07:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypMK-0005Zn-AN
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypMI-0006VP-Ks
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787657425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/EF15DLJHuyxxg2Wx4TIr/vf8/Y8SRHbXy9M4qOyPP8=;
 b=VuY9GsySEF/FBcILKM5peguhnz52N70sDqWmizbqWpLsr5x4m3KIq0vUttUmY0dPFkA0eZ
 rJJHbPQihc8KYBCk54iqqcBRnS2rSbKLDj5COYXDM6bL1MVPRu5y8l8dJjK1npme/0Vct1
 6owT91J9tnc+HOjYsIkVp1HIMaUEzfE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-chVzuRhiPMuv3UfoEuah6A-1; Tue,
 25 Aug 2026 07:30:23 -0400
X-MC-Unique: chVzuRhiPMuv3UfoEuah6A-1
X-Mimecast-MFC-AGG-ID: chVzuRhiPMuv3UfoEuah6A_1787657422
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96D55187E5E4; Tue, 25 Aug 2026 11:30:22 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA6DF1800641; Tue, 25 Aug 2026 11:30:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 15:21:08 +0400
Subject: [GIT PULL 18/19] hw/input/ps2: answer unknown mouse commands with
 a resend
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-fixes-v1-18-c59e8a620836@redhat.com>
References: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
In-Reply-To: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=3100;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vqPBZIR/UTG1l+75KrnAJ+h+vmcAhTrHiaqlz5DLOgw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjXrV07ry58ZYV9nhWOlhV5QjRH6rMytA3U3Gm
 JaLEiCWtQqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao161QAKCRDa6OEJdZac
 5W9QD/9wwXNLWW8lANbqYZvPIslyYO+LzFi7JdPPXSMqWp4GPEDj8HM+/2dXjbYVJ2fyNRsEe8M
 zjIwoZZMppnFC1n89x5Nv2Elj6bJSQRls2SbWHfWaAuiNmFq8OkTSI1zU+gXKND3ctuOj6Okytf
 c9cCEwrGKzCKYkuccz7QaLXtLHh9XP0KwoZrTKkpvDKISS7HnBomzLa92WihIYTRVZN/ZA54rJ6
 OndsPJ0i/o6B6taj+0Y7cI2F9box5xwsOqBtn+hzgUCnBz9dXEs5ubQNRd+XafTvZNMbqaCuhjc
 KeL6tyxUkkFJM5xmfmWAhjJd2djpb5C00YuBaIH76F9ausAiPLKrI8LYdrl8H1mCs1Aiu5Y5xdg
 iwMKDOeTTqZiTj/onE3Vld/w/uDOWoeIH4gwndtSV7nBJvDB7sxo5UeOPEqPR20vCkpU+8dbrys
 5ooYEcLDkup3bO5OqEADdIt+YQN0AasFhu/N1mQStWyLtYl4CJuKvUp8zwsa3quGNjwguaP//XJ
 gVNZFvVN7j9v3Ytu2OzZyLYBwAIZ/fmgXjqAKzGoVuwm3HMUGHHjL10bRfOVQ8a9jOsQynVjos4
 fSizCNqVUMUvq6hQ3YaJQZOzRfu3JV82/vBnq1E45Om8weJBnnyilqXHKnVQn+STtJtpvFRty2E
 0+DZPEYKiDo4lgw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 hw/input/ps2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 5516eb262d70..e8300d2d8308 100644
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
2.55.0.543.g5ebe2ebe4ea8


