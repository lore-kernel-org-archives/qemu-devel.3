Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD573606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F2d1G/M1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNc00-00059S-LQ; Sun, 01 Nov 2026 15:17:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzk-0004uV-3q
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzd-0007B4-OV
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793564248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w8kRb99S0l/psFxR+jH598Cu/ICuwN3sx7YUFyW2eCo=;
 b=F2d1G/M1lrh3nwxvWWjQfqIeR25GdURa659lYn+C772cKH+g7CUo9ymOMJuIzce5UJ1xRk
 lURqXqmMK4IDc+9YePtiFAEHx5zIeuTDceqpTTWnEZcZK1v910LjA5XxB/T4Wxl0188b3S
 iiGtRmgxxynx3RQHXCaR/QR++Ft/dBI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-_4dDcUxtOy6qLtzbmb9-pg-1; Sun,
 01 Nov 2026 15:17:27 -0500
X-MC-Unique: _4dDcUxtOy6qLtzbmb9-pg-1
X-Mimecast-MFC-AGG-ID: _4dDcUxtOy6qLtzbmb9-pg_1793564246
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DF7918005BC
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9DC87E2
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E2FB621E6896; Sun, 01 Nov 2026 21:17:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v8 18/56] qom: convert QAPI enum properties to QAPI-aware
 registration
Date: Sun,  1 Nov 2026 21:16:39 +0100
Message-ID: <20261101201717.3911097-19-armbru@redhat.com>
In-Reply-To: <20261101201717.3911097-1-armbru@redhat.com>
References: <20261101201717.3911097-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Convert all callers of object_class_property_add_enum() but one to
pass QAPITypeInfo instead of QEnumLookup.

This enables QMP QOM introspection to report accurate QAPI type names
for enum properties in member @qapi-type.

Leave pc_i440fx_machine_options() for later, because enum
PCSouthBridgeOption is a handmade QAPI-like enum instead of a real
one.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/chardev/char.h                   | 6 ++++--
 authz/list.c                             | 6 ++++--
 backends/hostmem.c                       | 5 +++--
 crypto/secret_common.c                   | 5 +++--
 crypto/tlscreds.c                        | 4 ++--
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 4 ++--
 monitor/qmp.c                            | 5 +++--
 net/filter.c                             | 5 +++--
 target/i386/kvm/kvm.c                    | 9 +++++----
 ui/console-vc.c                          | 1 +
 ui/dbus.c                                | 6 ++++--
 ui/input-linux.c                         | 5 +++--
 12 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/include/chardev/char.h b/include/chardev/char.h
index 5283cc0d5d..61e6957118 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -1,6 +1,7 @@
 #ifndef QEMU_CHAR_H
 #define QEMU_CHAR_H
 
+#include "qapi/qapi-type-infos-char.h"
 #include "qapi/qapi-types-char.h"
 #include "qemu/bitmap.h"
 #include "qemu/thread.h"
@@ -356,8 +357,9 @@ static inline void chardev_vc_add_encoding_prop(ObjectClass *oc,
     int (*get)(Object *, Error **),
     void (*set)(Object *, int, Error **))
 {
-    object_class_property_add_enum(oc, "encoding", "ChardevVCEncoding", NULL,
-                                   &ChardevVCEncoding_lookup, get, set);
+    object_class_property_add_enum(oc, "encoding", "ChardevVCEncoding",
+                                   &ChardevVCEncoding_type_info, NULL,
+                                   get, set);
 }
 
 #endif
diff --git a/authz/list.c b/authz/list.c
index 40fbccd87e..767e91b3aa 100644
--- a/authz/list.c
+++ b/authz/list.c
@@ -22,6 +22,7 @@
 #include "authz/list.h"
 #include "trace.h"
 #include "qom/object_interfaces.h"
+#include "qapi/qapi-type-infos-authz.h"
 #include "qapi/qapi-visit-authz.h"
 #include "qemu/module.h"
 
@@ -120,8 +121,9 @@ qauthz_list_class_init(ObjectClass *oc, const void *data)
 {
     QAuthZClass *authz = QAUTHZ_CLASS(oc);
 
-    object_class_property_add_enum(oc, "policy", "QAuthZListPolicy", NULL,
-                                   &QAuthZListPolicy_lookup,
+    object_class_property_add_enum(oc, "policy", "QAuthZListPolicy",
+                                   &QAuthZListPolicy_type_info,
+                                   NULL,
                                    qauthz_list_prop_get_policy,
                                    qauthz_list_prop_set_policy);
 
diff --git a/backends/hostmem.c b/backends/hostmem.c
index c5882f0b16..b43d6ca956 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -16,6 +16,7 @@
 #include "hw/core/boards.h"
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-visit.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qapi/visitor.h"
 #include "qemu/config-file.h"
 #include "qom/compat-properties.h"
@@ -551,8 +552,8 @@ host_memory_backend_class_init(ObjectClass *oc, const void *data)
                               NULL, NULL);
     object_class_property_set_description(oc, "host-nodes",
         "Binds memory to the list of NUMA host nodes");
-    object_class_property_add_enum(oc, "policy", "HostMemPolicy", NULL,
-                                   &HostMemPolicy_lookup,
+    object_class_property_add_enum(oc, "policy", "HostMemPolicy",
+                                   &HostMemPolicy_type_info, NULL,
                                    host_memory_backend_get_policy,
                                    host_memory_backend_set_policy);
     object_class_property_set_description(oc, "policy",
diff --git a/crypto/secret_common.c b/crypto/secret_common.c
index 16df64b336..8e05f1365e 100644
--- a/crypto/secret_common.c
+++ b/crypto/secret_common.c
@@ -22,6 +22,7 @@
 #include "crypto/secret_common.h"
 #include "crypto/cipher.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-crypto.h"
 #include "qom/object_interfaces.h"
 #include "qemu/base64.h"
 #include "qemu/module.h"
@@ -269,8 +270,8 @@ qcrypto_secret_class_init(ObjectClass *oc, const void *data)
 
     ucc->complete = qcrypto_secret_complete;
 
-    object_class_property_add_enum(oc, "format", "QCryptoSecretFormat", NULL,
-                                   &QCryptoSecretFormat_lookup,
+    object_class_property_add_enum(oc, "format", "QCryptoSecretFormat",
+                                   &QCryptoSecretFormat_type_info, NULL,
                                    qcrypto_secret_prop_get_format,
                                    qcrypto_secret_prop_set_format);
     object_class_property_add_str(oc, "keyid",
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index db74d302cc..021e4bf111 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-crypto.h"
 #include "qapi-types-crypto.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
@@ -222,8 +223,7 @@ qcrypto_tls_creds_class_init(ObjectClass *oc, const void *data)
                                   qcrypto_tls_creds_prop_get_dir,
                                   qcrypto_tls_creds_prop_set_dir);
     object_class_property_add_enum(oc, "endpoint", "QCryptoTLSCredsEndpoint",
-                                   NULL,
-                                   &QCryptoTLSCredsEndpoint_lookup,
+                                   &QCryptoTLSCredsEndpoint_type_info, NULL,
                                    qcrypto_tls_creds_prop_get_endpoint,
                                    qcrypto_tls_creds_prop_set_endpoint);
     object_class_property_add_str(oc, "priority",
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 8cf7cda7d9..b52f12924d 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -27,6 +27,7 @@
 #include "qemu/target-info.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "target/microblaze/cpu.h"
 #include "hw/core/sysbus.h"
 #include "net/net.h"
@@ -175,8 +176,7 @@ static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc,
     mc->is_default = true;
 
     prop = object_class_property_add_enum(oc, "endianness", "EndianMode",
-                                          NULL,
-                                          &EndianMode_lookup,
+                                          &EndianMode_type_info, NULL,
                                           machine_get_endianness,
                                           machine_set_endianness);
     object_property_set_default_str(prop, target_big_endian() ? "big"
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 8d7e49d1ce..c6341f1a20 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -30,6 +30,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-char.h"
+#include "qapi/qapi-type-infos-qom.h"
 #include "qobject/qdict.h"
 #include "qobject/qjson.h"
 #include "qobject/qlist.h"
@@ -134,8 +135,8 @@ static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
                                    monitor_qmp_get_pretty,
                                    monitor_qmp_set_pretty);
     object_class_property_add_enum(cls, "close-action",
-                                   "MonitorQMPCloseAction", NULL,
-                                   &MonitorQMPCloseAction_lookup,
+                                   "MonitorQMPCloseAction",
+                                   &MonitorQMPCloseAction_type_info, NULL,
                                    monitor_qmp_get_close_action,
                                    monitor_qmp_set_close_action);
 
diff --git a/net/filter.c b/net/filter.c
index 5311622aca..9013d872ea 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 
@@ -342,8 +343,8 @@ static void netfilter_class_init(ObjectClass *oc, const void *data)
 
     object_class_property_add_str(oc, "netdev",
                                   netfilter_get_netdev_id, netfilter_set_netdev_id);
-    object_class_property_add_enum(oc, "queue", "NetFilterDirection", NULL,
-                                   &NetFilterDirection_lookup,
+    object_class_property_add_enum(oc, "queue", "NetFilterDirection",
+                                   &NetFilterDirection_type_info, NULL,
                                    netfilter_get_direction, netfilter_set_direction);
     object_class_property_add_str(oc, "status",
                                   netfilter_get_status, netfilter_set_status);
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index abd9aa6241..0f71e75b60 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -14,6 +14,8 @@
 
 #include "qemu/osdep.h"
 #include "qapi/qapi-events-run-state.h"
+#include "qapi/qapi-type-infos-common.h"
+#include "qapi/qapi-type-infos-run-state.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include <math.h>
@@ -7090,8 +7092,7 @@ static void kvm_arch_set_honor_guest_pat(Object *obj, int value, Error **errp)
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
     object_class_property_add_enum(oc, "notify-vmexit", "NotifyVMexitOption",
-                                   NULL,
-                                   &NotifyVmexitOption_lookup,
+                                   &NotifyVmexitOption_type_info, NULL,
                                    kvm_arch_get_notify_vmexit,
                                    kvm_arch_set_notify_vmexit);
     object_class_property_set_description(oc, "notify-vmexit",
@@ -7128,8 +7129,8 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
     object_class_property_set_description(oc, "xen-evtchn-max-pirq",
                                           "Maximum number of Xen PIRQs");
 
-    object_class_property_add_enum(oc, "honor-guest-pat", "OnOffAuto", NULL,
-                                   &OnOffAuto_lookup,
+    object_class_property_add_enum(oc, "honor-guest-pat", "OnOffAuto",
+                                   &OnOffAuto_type_info, NULL,
                                    kvm_arch_get_honor_guest_pat,
                                    kvm_arch_set_honor_guest_pat);
     object_class_property_set_description(oc, "honor-guest-pat",
diff --git a/ui/console-vc.c b/ui/console-vc.c
index 99cc8f09c8..ac8c6bf101 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -6,6 +6,7 @@
 
 #include "chardev/char.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-char.h"
 #include "qemu/option.h"
 #include "qemu/queue.h"
 #include "qom/compat-properties.h"
diff --git a/ui/dbus.c b/ui/dbus.c
index 966c2c8b4e..9c21204771 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -38,6 +38,8 @@
 #include "qemu/audio.h"
 #include "audio/audio_int.h" /* FIXME: use QOM dynamic cast instead of drv->name */
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-char.h"
+#include "qapi/qapi-type-infos-ui.h"
 #include "trace.h"
 
 #include "dbus.h"
@@ -508,8 +510,8 @@ dbus_display_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "p2p", get_dbus_p2p, set_dbus_p2p);
     object_class_property_add_str(oc, "addr", get_dbus_addr, set_dbus_addr);
     object_class_property_add_str(oc, "audiodev", get_audiodev, set_audiodev);
-    object_class_property_add_enum(oc, "gl-mode", "DisplayGLMode", NULL,
-                                   &DisplayGLMode_lookup,
+    object_class_property_add_enum(oc, "gl-mode", "DisplayGLMode",
+                                   &DisplayGLMode_type_info, NULL,
                                    get_gl_mode, set_gl_mode);
 }
 
diff --git a/ui/input-linux.c b/ui/input-linux.c
index ea4d76e75d..127be74450 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -6,6 +6,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qemu/config-file.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
@@ -506,8 +507,8 @@ static void input_linux_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "repeat",
                                    input_linux_get_repeat,
                                    input_linux_set_repeat);
-    object_class_property_add_enum(oc, "grab-toggle", "GrabToggleKeys", NULL,
-                                   &GrabToggleKeys_lookup,
+    object_class_property_add_enum(oc, "grab-toggle", "GrabToggleKeys",
+                                   &GrabToggleKeys_type_info, NULL,
                                    input_linux_get_grab_toggle,
                                    input_linux_set_grab_toggle);
 }
-- 
2.55.0


