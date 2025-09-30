Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB197CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 11:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3YEN-0005yb-N3; Tue, 30 Sep 2025 07:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3YEK-0005xn-TF
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 07:09:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3YEA-0007hD-SG
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 07:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759230528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WJ004NYdXAyPlxQNdz1jcbvRzHTnf1+4agR11jcuXJ8=;
 b=NplDPOyrI5NpRk0N5vlcuHEXBD8uJtgzeXNbdN+wbFJDHEzF8JobURyayVBEFB+ayLCO2e
 ht4s87WLmJ3Og1r+hnR0LxW7NeFOELpuOIt387SB9H4twyb5gf06HTbsjdJ6yShEm3kBbg
 VgUbDO15/Bmqiu9EVtF5irvXVYaazgU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-4ezfv-RbO2OD8yjd8vHCIg-1; Tue,
 30 Sep 2025 07:08:43 -0400
X-MC-Unique: 4ezfv-RbO2OD8yjd8vHCIg-1
X-Mimecast-MFC-AGG-ID: 4ezfv-RbO2OD8yjd8vHCIg_1759230522
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 305E91800289; Tue, 30 Sep 2025 11:08:42 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.102])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6CC4219560B4; Tue, 30 Sep 2025 11:08:40 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Grant Millar | Cylo <rid@cylo.io>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>
Subject: [PATCH 2/2] io: fix use after free in websocket handshake code
Date: Tue, 30 Sep 2025 12:08:34 +0100
Message-ID: <20250930110834.2551757-3-berrange@redhat.com>
In-Reply-To: <20250930110834.2551757-1-berrange@redhat.com>
References: <20250930110834.2551757-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If the QIOChannelWebsock object is freed while it is waiting to
complete a handshake, a GSource is leaked. This can lead to the
callback firing later on and triggering a use-after-free in the
use of the channel. This was observed in the VNC server with the
following trace from valgrind:

==2523108== Invalid read of size 4
==2523108==    at 0x4054A24: vnc_disconnect_start (vnc.c:1296)
==2523108==    by 0x4054A24: vnc_client_error (vnc.c:1392)
==2523108==    by 0x4068A09: vncws_handshake_done (vnc-ws.c:105)
==2523108==    by 0x44863B4: qio_task_complete (task.c:197)
==2523108==    by 0x448343D: qio_channel_websock_handshake_io (channel-websock.c:588)
==2523108==    by 0x6EDB862: UnknownInlinedFun (gmain.c:3398)
==2523108==    by 0x6EDB862: g_main_context_dispatch_unlocked.lto_priv.0 (gmain.c:4249)
==2523108==    by 0x6EDBAE4: g_main_context_dispatch (gmain.c:4237)
==2523108==    by 0x45EC79F: glib_pollfds_poll (main-loop.c:287)
==2523108==    by 0x45EC79F: os_host_main_loop_wait (main-loop.c:310)
==2523108==    by 0x45EC79F: main_loop_wait (main-loop.c:589)
==2523108==    by 0x423A56D: qemu_main_loop (runstate.c:835)
==2523108==    by 0x454F300: qemu_default_main (main.c:37)
==2523108==    by 0x73D6574: (below main) (libc_start_call_main.h:58)
==2523108==  Address 0x57a6e0dc is 28 bytes inside a block of size 103,608 free'd
==2523108==    at 0x5F2FE43: free (vg_replace_malloc.c:989)
==2523108==    by 0x6EDC444: g_free (gmem.c:208)
==2523108==    by 0x4053F23: vnc_update_client (vnc.c:1153)
==2523108==    by 0x4053F23: vnc_refresh (vnc.c:3225)
==2523108==    by 0x4042881: dpy_refresh (console.c:880)
==2523108==    by 0x4042881: gui_update (console.c:90)
==2523108==    by 0x45EFA1B: timerlist_run_timers.part.0 (qemu-timer.c:562)
==2523108==    by 0x45EFC8F: timerlist_run_timers (qemu-timer.c:495)
==2523108==    by 0x45EFC8F: qemu_clock_run_timers (qemu-timer.c:576)
==2523108==    by 0x45EFC8F: qemu_clock_run_all_timers (qemu-timer.c:663)
==2523108==    by 0x45EC765: main_loop_wait (main-loop.c:600)
==2523108==    by 0x423A56D: qemu_main_loop (runstate.c:835)
==2523108==    by 0x454F300: qemu_default_main (main.c:37)
==2523108==    by 0x73D6574: (below main) (libc_start_call_main.h:58)
==2523108==  Block was alloc'd at
==2523108==    at 0x5F343F3: calloc (vg_replace_malloc.c:1675)
==2523108==    by 0x6EE2F81: g_malloc0 (gmem.c:133)
==2523108==    by 0x4057DA3: vnc_connect (vnc.c:3245)
==2523108==    by 0x448591B: qio_net_listener_channel_func (net-listener.c:54)
==2523108==    by 0x6EDB862: UnknownInlinedFun (gmain.c:3398)
==2523108==    by 0x6EDB862: g_main_context_dispatch_unlocked.lto_priv.0 (gmain.c:4249)
==2523108==    by 0x6EDBAE4: g_main_context_dispatch (gmain.c:4237)
==2523108==    by 0x45EC79F: glib_pollfds_poll (main-loop.c:287)
==2523108==    by 0x45EC79F: os_host_main_loop_wait (main-loop.c:310)
==2523108==    by 0x45EC79F: main_loop_wait (main-loop.c:589)
==2523108==    by 0x423A56D: qemu_main_loop (runstate.c:835)
==2523108==    by 0x454F300: qemu_default_main (main.c:37)
==2523108==    by 0x73D6574: (below main) (libc_start_call_main.h:58)
==2523108==

The above can be reproduced by launching QEMU with

  $ qemu-system-x86_64 -vnc localhost:0,websocket=5700

and then repeatedly running:

  for i in {1..100}; do
     (echo -n "GET / HTTP/1.1" && sleep 0.05) | nc -w 1 localhost 5700 &
  done

Reported-by: Grant Millar | Cylo <rid@cylo.io>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/io/channel-websock.h |  1 +
 io/channel-websock.c         | 16 ++++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/io/channel-websock.h b/include/io/channel-websock.h
index e180827c57..d1e760e449 100644
--- a/include/io/channel-websock.h
+++ b/include/io/channel-websock.h
@@ -61,6 +61,7 @@ struct QIOChannelWebsock {
     size_t payload_remain;
     size_t pong_remain;
     QIOChannelWebsockMask mask;
+    guint hs_io_tag;
     guint io_tag;
     Error *io_err;
     gboolean io_eof;
diff --git a/io/channel-websock.c b/io/channel-websock.c
index 56d53355d5..588c313dfb 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -597,7 +597,7 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
     error_propagate(&wioc->io_err, err);
 
     trace_qio_channel_websock_handshake_reply(ioc);
-    qio_channel_add_watch(
+    wioc->hs_io_tag = qio_channel_add_watch(
         wioc->master,
         G_IO_OUT,
         qio_channel_websock_handshake_send,
@@ -907,11 +907,12 @@ void qio_channel_websock_handshake(QIOChannelWebsock *ioc,
 
     trace_qio_channel_websock_handshake_start(ioc);
     trace_qio_channel_websock_handshake_pending(ioc, G_IO_IN);
-    qio_channel_add_watch(ioc->master,
-                          G_IO_IN,
-                          qio_channel_websock_handshake_io,
-                          task,
-                          NULL);
+    ioc->hs_io_tag = qio_channel_add_watch(
+        ioc->master,
+        G_IO_IN,
+        qio_channel_websock_handshake_io,
+        task,
+        NULL);
 }
 
 
@@ -1212,6 +1213,9 @@ static int qio_channel_websock_close(QIOChannel *ioc,
     buffer_free(&wioc->encinput);
     buffer_free(&wioc->encoutput);
     buffer_free(&wioc->rawinput);
+    if (wioc->hs_io_tag) {
+        g_clear_handle_id(&wioc->hs_io_tag, g_source_remove);
+    }
     if (wioc->io_tag) {
         g_clear_handle_id(&wioc->io_tag, g_source_remove);
     }
-- 
2.50.1


