Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DCFCD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 07:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLcFt-0006HM-H0; Sat, 09 May 2026 03:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLcFp-0006DG-0b
 for qemu-devel@nongnu.org; Sat, 09 May 2026 03:37:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLcFn-00078H-FL
 for qemu-devel@nongnu.org; Sat, 09 May 2026 03:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778312258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xI/X402CtmtDzIEVp/khfjIWs7e18AEbTBGOXmkqZYM=;
 b=MPaEYSxjqGByChDl8vZqYrkBepdJ4ylVyBmxRQqmiTi7m1YLPI+MgG3ihjmJ8OkLXnoAKi
 E7SZ/3CBeo8gR/CzU4NfJSMDWnjZ6LuyB4j1k71OkbPoA2ibM3pPTjsRrcE18b3PgVGDpr
 yTNdEnDV03w0fbySeLBEpgPgLMWrbFk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-mcNU1XGpP8eGOg2Ov7Br0w-1; Sat,
 09 May 2026 03:37:34 -0400
X-MC-Unique: mcNU1XGpP8eGOg2Ov7Br0w-1
X-Mimecast-MFC-AGG-ID: mcNU1XGpP8eGOg2Ov7Br0w_1778312254
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E195A1955F18; Sat,  9 May 2026 07:37:33 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 93D5F3002D30; Sat,  9 May 2026 07:37:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 12/32] ui/dbus: expose vc encoding via D-Bus Chardev.VCEncoding
 interface
Date: Sat,  9 May 2026 11:35:58 +0400
Message-ID: <20260509073621.1011778-13-marcandre.lureau@redhat.com>
In-Reply-To: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
References: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When a D-Bus VC chardev is instantiated, export an extra
org.qemu.Display1.Chardev.VCEncoding interface on the chardev
object.  This lets D-Bus display clients discover the encoding
(cp437 or utf8) in use by the virtual console.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus.h            |  1 +
 ui/dbus-chardev.c    | 10 ++++++++++
 ui/dbus.c            |  6 ++++++
 ui/dbus-display1.xml | 18 ++++++++++++++++++
 4 files changed, 35 insertions(+)

diff --git a/ui/dbus.h b/ui/dbus.h
index 986d7774601..e4e78590b49 100644
--- a/ui/dbus.h
+++ b/ui/dbus.h
@@ -126,6 +126,7 @@ typedef struct DBusChardev {
 
     bool exported;
     QemuDBusDisplay1Chardev *iface;
+    QemuDBusDisplay1ChardevVCEncoding *iface_vc_encoding;
 } DBusChardev;
 
 DECLARE_INSTANCE_CHECKER(DBusChardev, DBUS_CHARDEV, TYPE_CHARDEV_DBUS)
diff --git a/ui/dbus-chardev.c b/ui/dbus-chardev.c
index 9442b475517..55117029acc 100644
--- a/ui/dbus-chardev.c
+++ b/ui/dbus-chardev.c
@@ -53,6 +53,15 @@ dbus_display_chardev_export(DBusDisplay *dpy, DBusChardev *chr)
     sk = g_dbus_object_skeleton_new(path);
     g_dbus_object_skeleton_add_interface(
         sk, G_DBUS_INTERFACE_SKELETON(chr->iface));
+    if (chr->iface_vc_encoding) {
+        const char *interfaces[] = {
+            "org.qemu.Display1.Chardev.VCEncoding",
+            NULL
+        };
+        g_dbus_object_skeleton_add_interface(
+            sk, G_DBUS_INTERFACE_SKELETON(chr->iface_vc_encoding));
+        g_object_set(chr->iface, "interfaces", interfaces, NULL);
+    }
     g_dbus_object_manager_server_export(dpy->server, sk);
     chr->exported = true;
 }
@@ -290,6 +299,7 @@ char_dbus_finalize(Object *obj)
     };
 
     dbus_display_notify(&event);
+    g_clear_object(&dc->iface_vc_encoding);
     g_clear_object(&dc->iface);
 }
 
diff --git a/ui/dbus.c b/ui/dbus.c
index 59b73e0aa94..e02a94df2f3 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -514,6 +514,7 @@ CHARDEV_VC_ENCODING_PROPERTY_DEFINE(DBUS_VC_CHARDEV)
 static bool
 dbus_vc_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
+    DBusChardev *dc = DBUS_CHARDEV(chr);
     DBusVCChardev *vc = DBUS_VC_CHARDEV(chr);
     ChardevClass *parent =
         CHARDEV_CLASS(object_class_by_name(TYPE_CHARDEV_DBUS));
@@ -522,6 +523,11 @@ dbus_vc_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     if (be->has_encoding) {
         vc->encoding = be->encoding;
     }
+    dc->iface_vc_encoding =
+        qemu_dbus_display1_chardev_vcencoding_skeleton_new();
+    qemu_dbus_display1_chardev_vcencoding_set_encoding(
+        dc->iface_vc_encoding,
+        qapi_enum_lookup(&ChardevVCEncoding_lookup, vc->encoding));
 
     return parent->chr_open(chr, backend, errp);
 }
diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml
index 4a41a7e0f34..d96bae2ed64 100644
--- a/ui/dbus-display1.xml
+++ b/ui/dbus-display1.xml
@@ -1141,4 +1141,22 @@
     -->
     <property name="Interfaces" type="as" access="read"/>
   </interface>
+
+  <!--
+      org.qemu.Display1.Chardev.VCEncoding:
+
+      Provides encoding information for virtual console chardevs.
+
+      This interface is present on chardev objects that are virtual
+      consoles, and exposes the character encoding used by the guest.
+  -->
+  <interface name="org.qemu.Display1.Chardev.VCEncoding">
+    <!--
+        Encoding:
+
+        The character encoding used by the virtual console
+        (matching ``ChardevVCEncoding``): ``cp437`` or ``utf8``.
+    -->
+    <property name="Encoding" type="s" access="read"/>
+  </interface>
 </node>
-- 
2.54.0


