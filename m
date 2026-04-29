Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D8DFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIC4S-0003Wq-Jj; Wed, 29 Apr 2026 17:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC4R-0003Wg-DJ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:03:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC4P-0003FE-R0
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777496625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=14U39x3hKFcnEg9txnoTC7C763WGgzRgszbuzkY7lcQ=;
 b=hmXOw+3I0xGo8syRB+WjBI1qwTFQgYIQ4JlOm27NkGR2ZPLgyEXo080ooBVKPKzkWBTILX
 2JuVGT5QiwLJ1AWpyRGnBNNTQsNziv5eVSVZKZ6dLtY9UIGqmyGZ3PgtiPdHLnDlVV7Wtr
 wUnfTk3xSHaEck5rh+/amENCy23r+/8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-RZi9exQ6OrSDEYfSLEEtnw-1; Wed,
 29 Apr 2026 17:03:43 -0400
X-MC-Unique: RZi9exQ6OrSDEYfSLEEtnw-1
X-Mimecast-MFC-AGG-ID: RZi9exQ6OrSDEYfSLEEtnw_1777496622
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B113A180049F
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:03:42 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E2B019560AB; Wed, 29 Apr 2026 21:03:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Apr 2026 01:02:38 +0400
Subject: [PATCH v3 05/26] ui/dbus: expose vc encoding via D-Bus
 Chardev.VCEncoding interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-qemu-vnc-v3-5-be96757428d0@redhat.com>
References: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
In-Reply-To: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3680;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=4EvqtYupk8nS0o0eXyT42yY2zQZ9lVjuqZl5ryTPKwI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8nILijNBE/833XnKNw7MvHsLUq0h7LpZJLgqK
 YrSrO/KUX6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafJyCwAKCRDa6OEJdZac
 5dMXEAC36VxpStOMXAtCIhW2AWL3KO4CNfOx1GQYAfVvXvTgsPX7KDQL8EKglUznZW4Z4A2ykjw
 i4Vt8ajHAnhwtNu4JHhg8AHdHV/51OXgiQGawCmy+I4mvxe+E2rSy0t2VtwtZpyqyka3o5MVgLS
 kuitP6hskqeo3N99pD+k9J3HotONnWdut2xORLKGCelDvsjzi+tokJDlpO3ku1S5c+6mXu4vFWt
 /60aDF1+Edv/hGSOSYs/+w+Mwxaq10gq4PhrA/CoqlVpuevkskcCQoW6JLPHomhLCitSs5xY7Lc
 f8HY1uqmsBNF+Yf6QoHcvpyXoe79aiMV+sjPcOlmL1jIyoUTduZSAXXdcfAbJyq43qwoGa6gAhQ
 pyyCF0uBim9cw/r5IY1kSiBaMqvxZKPQIB659uovbaZ0cGco/UiNvRkDRDDA1XlEZekTJJT1kh+
 SMTsZ2f9XOdAwubqNpnrU5/QUhDPiZz4IDmEnDaEMua8suViMxav89CdG5MNZxRbDhjZmrr+u9X
 q9y9ufOt3KB6I5kUi2XlA12aMuOwqt5USQYUsA5Z1u3dc6s3VyzOoPpSccmwq8sQia0EdFVK90O
 KivZ6I2SCUIfedq5PSYZyFhezCZwBiZoKr7NJPV5XZLKIYftmNURpYg75e3ds34xnkEn/AZb2qe
 oJtDNinP0p44DnA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When a D-Bus VC chardev is instantiated, export an extra
org.qemu.Display1.Chardev.VCEncoding interface on the chardev
object.  This lets D-Bus display clients discover the encoding
(cp437 or utf8) in use by the virtual console.

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


