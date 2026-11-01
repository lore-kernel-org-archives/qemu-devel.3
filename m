Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A256E606A326
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dOZXE2G1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNUKw-0007ti-5B; Sun, 01 Nov 2026 07:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNUKs-0007sp-2O
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 07:06:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNUKq-0003Xw-Ba
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 07:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793534811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/z+AhOvGNXZ5geetWGL5EEk8p1OIF4xQOZUJuC9dmfA=;
 b=dOZXE2G1uYsXNVDQmwsB3BhqhdI1pAcpoewZqR5fczw4EnyIRhx7zgEViF9T0b1ZvW5ZT9
 wT1Jguvm9/s1z8U7erRQ1wHKDoyXgdBFD7G4g0QzeJQ+nr3fGv7B30Ae2wZ3PG9FcYz/BO
 lEjPlYnuZOL79UGn49jhKX1x+vILNPI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-pqPgrzZdNSmdRPk6BYqc7w-1; Sun,
 01 Nov 2026 07:06:47 -0500
X-MC-Unique: pqPgrzZdNSmdRPk6BYqc7w-1
X-Mimecast-MFC-AGG-ID: pqPgrzZdNSmdRPk6BYqc7w_1793534806
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D764E1955EAD; Sun,  1 Nov 2026 12:06:45 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A8701800345; Sun,  1 Nov 2026 12:06:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 01 Nov 2026 16:06:34 +0400
Subject: [GIT PULL 1/9] ui/clipboard: add clipboard peer update
 notification
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261101-ui-v1-1-8af305cef69a@redhat.com>
References: <20261101-ui-v1-0-8af305cef69a@redhat.com>
In-Reply-To: <20261101-ui-v1-0-8af305cef69a@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7127;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=CGo90z5HSC5nlQbBJZLwp6GMX8d04lJRbMfJYugBm/k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5ytOhAHBIOrN7eGEwcKSIrZYYiBwHpEejBPsg
 pPAwUFK2AuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaucrTgAKCRDa6OEJdZac
 5VafD/9g8Aly78rzx2oft+rsiRACk8GaZKmj9hCqu8zYlaz0D1x5UotuIPDCM3+PC1sjGplxmCz
 umBDVlWlA+5FiXCJHgMYMbSSs0XchGGg1BzZi0N3gQYgRUzsILLltODUZDtiZVDiM+gxtTDAQ5O
 SYVlOZhDK2PAferpN3czleYIE7jSRDvdWStyeSHvI8ikhvPNe1BH/uxLsvIDGV3EfIPJ+hVT18o
 qodfwaWqGhjUZyAOmFgK9zpKrfmURr6TuXXp8sUS79oHBzZgPv/dYLl5gz7KUdN/WmqQbA/WkYL
 Imd64pNH+Nh1BHLEE3dLgjs/apOAQ9d0EgubavfZB8FzFSDkfof+uGRhhJU+lj7r25Bl5P/E9WR
 Mlgke7ABg7m8DTp9Y2W6TEcchV61MuuZMmnQVLq0EbrVzra3AU6NwJvKyPTFdyXDXVrI8IQXAyy
 h8X6SnACW21Tsg8tbo1xrpbAmpj0uWVTCOyWsD6Q9PA1S43VjqXZkvettMOUBvUbANXJMLT03xT
 qyihlbJMM2Z8Mh1ItxK80g6wSRgiITfBD2GvOPKiuzAfSF9lesLuiDu9cnGRnQrjxmaRLGMOluc
 PFh5+HMYaWEhwq1wTnkYAlVMAIiUYeCXaRW5E+Ue/7fhN7MX1lv8DbCBrotjBM7CNhiiT2jdGW2
 r2Dy1dGTBEOKgKQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Lukasz Kornicki <lucas.kornicki@nutanix.com>

Add a new QEMU_CLIPBOARD_PEER_UPDATE notify type which carries
a payload with affected peer and whether it just registered or
unregistered.

All existing notifier handlers are updated to explicitly ignore
the new event so that the enum switch remains exhaustive.

Signed-off-by: Lukasz Kornicki <lucas.kornicki@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261030141442.264308-2-lucas.kornicki@nutanix.com>
---
 include/ui/clipboard.h     | 19 +++++++++++++++++++
 tools/qemu-vnc/clipboard.c |  3 +++
 ui/clipboard.c             | 18 ++++++++++++++++++
 ui/cocoa.m                 |  3 +++
 ui/dbus-clipboard.c        |  3 +++
 ui/gtk-clipboard.c         |  3 +++
 ui/trace-events            |  1 +
 ui/vdagent.c               |  3 +++
 ui/vnc-clipboard.c         |  3 +++
 9 files changed, 56 insertions(+)

diff --git a/include/ui/clipboard.h b/include/ui/clipboard.h
index 62a96ce9ff56..6166af513906 100644
--- a/include/ui/clipboard.h
+++ b/include/ui/clipboard.h
@@ -25,6 +25,7 @@ typedef enum QemuClipboardNotifyType QemuClipboardNotifyType;
 typedef enum QemuClipboardSelection QemuClipboardSelection;
 typedef struct QemuClipboardPeer QemuClipboardPeer;
 typedef struct QemuClipboardNotify QemuClipboardNotify;
+typedef struct QemuClipboardPeerUpdate QemuClipboardPeerUpdate;
 typedef struct QemuClipboardInfo QemuClipboardInfo;
 typedef struct QemuClipboardContent QemuClipboardContent;
 
@@ -78,12 +79,27 @@ struct QemuClipboardPeer {
  *
  * @QEMU_CLIPBOARD_UPDATE_INFO: clipboard info update
  * @QEMU_CLIPBOARD_RESET_SERIAL: reset clipboard serial
+ * @QEMU_CLIPBOARD_PEER_UPDATE: peer registered/unregistered
  *
  * Clipboard notify type.
  */
 enum QemuClipboardNotifyType {
     QEMU_CLIPBOARD_UPDATE_INFO,
     QEMU_CLIPBOARD_RESET_SERIAL,
+    QEMU_CLIPBOARD_PEER_UPDATE,
+};
+
+/**
+ * struct QemuClipboardPeerUpdate
+ *
+ * @peer: the peer affected by this event
+ * @registered: whether @peer registered or unregistered.
+ *
+ * Clipboard peer update event data.
+ */
+struct QemuClipboardPeerUpdate {
+    QemuClipboardPeer *peer;
+    bool registered;
 };
 
 /**
@@ -91,6 +107,8 @@ enum QemuClipboardNotifyType {
  *
  * @type: the type of event.
  * @info: a QemuClipboardInfo event.
+ * @peer_update: a peer register/unregister event
+ *               (valid for QEMU_CLIPBOARD_PEER_UPDATE).
  *
  * Clipboard notify data.
  */
@@ -98,6 +116,7 @@ struct QemuClipboardNotify {
     QemuClipboardNotifyType type;
     union {
         QemuClipboardInfo *info;
+        QemuClipboardPeerUpdate peer_update;
     };
 };
 
diff --git a/tools/qemu-vnc/clipboard.c b/tools/qemu-vnc/clipboard.c
index 81a09ec5adfa..3ce994c9edbd 100644
--- a/tools/qemu-vnc/clipboard.c
+++ b/tools/qemu-vnc/clipboard.c
@@ -174,6 +174,9 @@ vnc_dbus_clipboard_notify(Notifier *notifier, void *data)
                 -1, NULL, NULL, NULL);
         }
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 
diff --git a/ui/clipboard.c b/ui/clipboard.c
index 46e602dfef43..3d8f58a85508 100644
--- a/ui/clipboard.c
+++ b/ui/clipboard.c
@@ -59,6 +59,21 @@ static void qemu_clipboard_change_state(void *opaque, bool running, RunState sta
 
 }
 
+static void qemu_clipboard_notify_peer_update(QemuClipboardPeer *peer,
+                                              bool registered)
+{
+    QemuClipboardNotify notify = {
+        .type = QEMU_CLIPBOARD_PEER_UPDATE,
+        .peer_update = {
+            .peer = peer,
+            .registered = registered,
+        },
+    };
+
+    trace_clipboard_peer_update(peer->name, registered);
+    notifier_list_notify(&clipboard_notifiers, &notify);
+}
+
 void qemu_clipboard_peer_register(QemuClipboardPeer *peer)
 {
     if (cb_change_state_entry == NULL) {
@@ -66,6 +81,7 @@ void qemu_clipboard_peer_register(QemuClipboardPeer *peer)
     }
 
     notifier_list_add(&clipboard_notifiers, &peer->notifier);
+    qemu_clipboard_notify_peer_update(peer, true);
 }
 
 void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer)
@@ -76,6 +92,8 @@ void qemu_clipboard_peer_unregister(QemuClipboardPeer *peer)
         qemu_clipboard_peer_release(peer, i);
     }
     notifier_remove(&peer->notifier);
+    qemu_clipboard_notify_peer_update(peer, false);
+
     if (QLIST_EMPTY(&clipboard_notifiers.notifiers)) {
         g_clear_pointer(&cb_change_state_entry,
                         qemu_del_vm_change_state_handler);
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 3751be379220..4587547c98ca 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1860,6 +1860,9 @@ static void cocoa_clipboard_notify(Notifier *notifier, void *data)
     case QEMU_CLIPBOARD_RESET_SERIAL:
         /* ignore */
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 
diff --git a/ui/dbus-clipboard.c b/ui/dbus-clipboard.c
index 90318384ee48..6940f719ffb6 100644
--- a/ui/dbus-clipboard.c
+++ b/ui/dbus-clipboard.c
@@ -125,6 +125,9 @@ dbus_clipboard_notify(Notifier *notifier, void *data)
     case QEMU_CLIPBOARD_RESET_SERIAL:
         dbus_clipboard_reset_serial(dpy);
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 
diff --git a/ui/gtk-clipboard.c b/ui/gtk-clipboard.c
index 476e6b8303c9..6bb3d7f3fcb9 100644
--- a/ui/gtk-clipboard.c
+++ b/ui/gtk-clipboard.c
@@ -133,6 +133,9 @@ static void gd_clipboard_notify(Notifier *notifier, void *data)
     case QEMU_CLIPBOARD_RESET_SERIAL:
         /* ignore */
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 
diff --git a/ui/trace-events b/ui/trace-events
index 339a61f34153..917d116d90e1 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -171,6 +171,7 @@ xkeymap_keymap(const char *name) "keymap '%s'"
 # clipboard.c
 clipboard_check_serial(int cur, int recv, bool ok) "cur:%d recv:%d %d"
 clipboard_reset_serial(void) ""
+clipboard_peer_update(const char *name, bool registered) "peer '%s' registered=%d"
 
 # vdagent.c
 vdagent_fe_open(bool fe_open) "fe_open=%d"
diff --git a/ui/vdagent.c b/ui/vdagent.c
index b9784d4d9b9e..cc32a94fb9c0 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -477,6 +477,9 @@ static void vdagent_clipboard_notify(Notifier *notifier, void *data)
     case QEMU_CLIPBOARD_RESET_SERIAL:
         vdagent_clipboard_reset_serial(vd);
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 
diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
index fa05d86f424a..dfe830f8199b 100644
--- a/ui/vnc-clipboard.c
+++ b/ui/vnc-clipboard.c
@@ -236,6 +236,9 @@ static void vnc_clipboard_notify(Notifier *notifier, void *data)
     case QEMU_CLIPBOARD_RESET_SERIAL:
         /* ignore */
         return;
+    case QEMU_CLIPBOARD_PEER_UPDATE:
+        /* ignore */
+        return;
     }
 }
 

-- 
2.56.0.116.g6de20f6092dc


