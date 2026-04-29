Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1B4CD13D3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIC6r-0007uo-3c; Wed, 29 Apr 2026 17:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC5e-0006OV-UU
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:05:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC5c-0003V5-O5
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777496695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9ejhMqDOIAnqlDB6S6XDF5JcjPS+M/QLKhH2rZsC/U=;
 b=PvloAO1UvWpqe4CgtZYMrajkFzhXTGM/ztrKuSEiCSQKkeCUSV6KgoAG556hWTu869VkLB
 LLrZcx4GFNUMRuum5tnu9qtBIFpKUnH4COxKMjRjA9DRrokvSldyJaorQMcyVxyJbHtOgZ
 IWTZef6jWt8v4dUPulHOmncK9pXeTfM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-o7l964QgOf2P83nbbpg2UQ-1; Wed,
 29 Apr 2026 17:04:54 -0400
X-MC-Unique: o7l964QgOf2P83nbbpg2UQ-1
X-Mimecast-MFC-AGG-ID: o7l964QgOf2P83nbbpg2UQ_1777496693
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EF6A19560B7
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:04:53 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 007661800577; Wed, 29 Apr 2026 21:04:51 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Apr 2026 01:02:50 +0400
Subject: [PATCH v3 17/26] ui/vnc: clean up VNC displays on exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-qemu-vnc-v3-17-be96757428d0@redhat.com>
References: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
In-Reply-To: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3164;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=UofqdxEpsoMU3tHdoWYdaOMGh4untiTWKq2jjDIVs/Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8nIMJ1jHyit5LpouPussdgMCirQheJLzzaMuf
 CCUYpcUpy6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafJyDAAKCRDa6OEJdZac
 5dltD/4mDqHs1l5qBtnLmqVCgXkW8sFKReO1HjMEcepO2AP+mwOcaNB7VV3gRaNLZMM5mgTs8o1
 jEUrJkyFH4nXB4pIUlSX3UwF4NHLmcN8ZXPQMnzXugxl25XFGc41s/IoSn/bAGOEYjxMTChUIpb
 5j0uvttmP/N8i4jbhIwGvokhYWbnYPm5DsQazcCvGAKoOHw8kYgvjXKBg20SscqVoO/8Xn7R9Ly
 JJk25QHu7ueag2JgFdUwREfZN8ffrVp9BcsHJ+StD9aBy8XFbz8eAm73WPjinCWzKoN7qilHJV+
 DxsmyFRcdaS7Z83b9CbldlkNZliZN08PBVFNZfMnuHSlyFrAGjlrPHYp1x5Cu1yKMn4k+VKx5L4
 YhuMNdFB5svr7FSGoQYt/+XwJl8MSFRCrnJqQtCycqhpeGvbbzxFpaGro5kEaOf8BxgQ4ja1Uzw
 cnU6/TFLUOOtrsGEml6E2Y43oy7D2P+p+W9GC7BQgLNbfdplFe4UmzK9ny+TQfHYnjQD/Wd8/l0
 KxsyZ9z2CV4f/IU7budzMZBcygkqujol7YrzVKKSzilMCuCqOZGHhNF/lLcSdcgIIcry9hQFC76
 JUwo6i9TiVpVIHEVB4W3JjyibDoa85keKa4ZHa8ZXMcbAz3CxKhQZzGnbT0TPE8YI4lOJbXEHGW
 iENqQFGK0M30qxQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Previously, VNC displays were never torn down on QEMU exit, leaking
resources and leaving connected clients with unclean disconnects.

Add vnc_cleanup() to free all VNC displays during qemu_cleanup().
Make vnc_display_close() initiate disconnection of active clients,
and have vnc_display_free() drain the main loop until all clients
have completed their teardown, instead of asserting the client list
is empty.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h |  1 +
 system/runstate.c    |  5 +++++
 ui/vnc.c             | 20 ++++++++++++++++++--
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 550a5e08e46..89fb4c1942a 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -445,6 +445,7 @@ void vnc_parse(const char *str);
 int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp);
 bool vnc_display_reload_certs(const char *id,  Error **errp);
 bool vnc_display_update(DisplayUpdateOptionsVNC *arg, Error **errp);
+void vnc_cleanup(void);
 
 /* input.c */
 int index_from_key(const char *key, size_t key_length);
diff --git a/system/runstate.c b/system/runstate.c
index 770253b467b..0e1cb3b4e67 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -61,6 +61,8 @@
 #include "system/confidential-guest-support.h"
 #include "system/system.h"
 #include "system/tpm.h"
+#include "ui/console.h"
+
 #include "trace.h"
 
 static NotifierList exit_notifiers =
@@ -1044,5 +1046,8 @@ void qemu_cleanup(int status)
     monitor_cleanup();
     qemu_chr_cleanup();
     user_creatable_cleanup();
+#ifdef CONFIG_VNC
+    vnc_cleanup();
+#endif
     /* TODO: unref root container, check all devices are ok */
 }
diff --git a/ui/vnc.c b/ui/vnc.c
index 1c649e7bccf..d65153a5001 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3473,8 +3473,13 @@ VncDisplay *vnc_display_new(const char *id, Error **errp)
 
 static void vnc_display_close(VncDisplay *vd)
 {
+    VncState *vs;
+
     assert(vd);
 
+    QTAILQ_FOREACH(vs, &vd->clients, next) {
+        vnc_disconnect_start(vs);
+    }
     if (vd->listener) {
         qio_net_listener_disconnect(vd->listener);
         object_unref(OBJECT(vd->listener));
@@ -3515,10 +3520,12 @@ void vnc_display_free(VncDisplay *vd)
         return;
     }
 
-    assert(QTAILQ_EMPTY(&vd->clients));
+    vnc_display_close(vd);
+    while (!QTAILQ_EMPTY(&vd->clients)) {
+        main_loop_wait(false);
+    }
 
     vnc_stop_worker_thread(vd);
-    vnc_display_close(vd);
     unregister_displaychangelistener(&vd->dcl);
     qkbd_state_free(vd->kbd);
     qemu_del_vm_change_state_handler(vd->vmstate_handler_entry);
@@ -4348,6 +4355,15 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
     return vnc_display_new(id, errp) != NULL ? 0 : -1;
 }
 
+void vnc_cleanup(void)
+{
+    VncDisplay *vd, *vd_next;
+
+    QTAILQ_FOREACH_SAFE(vd, &vnc_displays, next, vd_next) {
+        vnc_display_free(vd);
+    }
+}
+
 static void vnc_register_config(void)
 {
     qemu_add_opts(&qemu_vnc_opts);

-- 
2.54.0


