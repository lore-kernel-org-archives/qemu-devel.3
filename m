Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951A210F9973
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYKw-0004s0-R8; Wed, 08 Apr 2026 15:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wAYJa-0000f1-Nk
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:11:51 -0400
Received: from mail-08.mail-europe.com ([57.129.93.249])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wAHJP-0001MP-MA
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 21:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matthewpenney.net;
 s=protonmail; t=1775610143; x=1775869343;
 bh=6Ir9wkbsRzDHn4ZCMkPGCiaAbY7a7WO1QuXJPohGOBE=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=faDerZWtCl+lq5qYekMywp3zEClp7Hdyzkv/yNyGYcIjSUR9GgOQwLxRBhtOCaJ+m
 KcHCde7NeKqn/ZHNL040rMQPeNMt1m1ecExWGYtlzYjhHIesNRXLnNoOG6rZ5pm/0X
 uZQekYJKw2Xb/hEX/nYn7nhOgjGZandORi2AXuT2lwjvChs9KgKi8KzvDUBiGC8Uz6
 rClOcNYRxUdJtMMjPUQnktnftvWmTsyB7TmQK1BIXFAYX3AOuGfrZsL8BnHiMEz700
 Tl1/w6DNApXQPRrwgfK5drSbeabNOf2899nIVeIU1OLiRfLYGTRHDjaeb6Xc8PJ6+V
 3S8TT6LMHEbSw==
Date: Wed, 08 Apr 2026 01:02:20 +0000
To: qemu-devel@nongnu.org
From: Matthew Penney <matt@matthewpenney.net>
Cc: Matthew Penney <matt@matthewpenney.net>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 3/8] io: use g_clear_handle_id() for GSource cleanup
Message-ID: <20260408010026.4611-4-matt@matthewpenney.net>
Feedback-ID: 185185778:user:proton
X-Pm-Message-ID: 7b59dc3fac1364fc5b44b65cb830ce258b38207f
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=57.129.93.249;
 envelope-from=matt@matthewpenney.net; helo=mail-08.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use g_clear_handle_id() instead of g_source_remove() with manual ID
checking and zeroing.

This simplifies the code and ensures consistent handling of GSource IDs,
since g_clear_handle_id() checks for a non-zero ID before calling the
cleanup function and zeros it afterwards.

No functional change intended.

Signed-off-by: Matthew Penney <matt@matthewpenney.net>
---
 io/channel-websock.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 9902b014f7..3479a5c32d 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -950,12 +950,8 @@ static void qio_channel_websock_finalize(Object *obj)
     buffer_free(&ioc->encinput);
     buffer_free(&ioc->encoutput);
     buffer_free(&ioc->rawinput);
-    if (ioc->hs_io_tag) {
-        g_source_remove(ioc->hs_io_tag);
-    }
-    if (ioc->io_tag) {
-        g_source_remove(ioc->io_tag);
-    }
+    g_clear_handle_id(&ioc->hs_io_tag, g_source_remove);
+    g_clear_handle_id(&ioc->io_tag, g_source_remove);
     error_free(ioc->io_err);
     object_unref(OBJECT(ioc->master));
 }
@@ -1070,10 +1066,7 @@ static gboolean qio_channel_websock_flush(QIOChannel=
 *ioc,
=20
 static void qio_channel_websock_unset_watch(QIOChannelWebsock *ioc)
 {
-    if (ioc->io_tag) {
-        g_source_remove(ioc->io_tag);
-        ioc->io_tag =3D 0;
-    }
+    g_clear_handle_id(&ioc->io_tag, g_source_remove);
 }
=20
 static void qio_channel_websock_set_watch(QIOChannelWebsock *ioc)
@@ -1250,12 +1243,8 @@ static int qio_channel_websock_close(QIOChannel *ioc=
,
     buffer_free(&wioc->encinput);
     buffer_free(&wioc->encoutput);
     buffer_free(&wioc->rawinput);
-    if (wioc->hs_io_tag) {
-        g_clear_handle_id(&wioc->hs_io_tag, g_source_remove);
-    }
-    if (wioc->io_tag) {
-        g_clear_handle_id(&wioc->io_tag, g_source_remove);
-    }
+    g_clear_handle_id(&wioc->hs_io_tag, g_source_remove);
+    g_clear_handle_id(&wioc->io_tag, g_source_remove);
     if (wioc->io_err) {
         g_clear_pointer(&wioc->io_err, error_free);
     }
--=20
2.53.0



