Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92E1CCF2E5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoE3-0002bo-8p; Mon, 19 Oct 2026 10:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDQ-0002FE-U9
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDK-0005bY-4U
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792419585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ex+WYkA7KgSdZe2xGLyiw6hy+oLBT2WlA1Fvy2TtH2Y=;
 b=Jo3s/giV8XMoxMhIdA6pfv4SGOjiYa1LQWg0z4UwsCZY9fkVT0jcLGUkMrkZbyo3fDn6Sa
 t/TyCiuZamWJkxBy/xRHksPaVl3qOo2Uqi1TEldwPKaOotKxTORDfg/71AuWOy2VFFBdD9
 86rqbaI48WPU8/tjQzIZ2v7plHPfbuQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-Pk05pqq3O-KR8uDvJLNSew-1; Mon,
 19 Oct 2026 14:19:39 +0000
X-MC-Unique: Pk05pqq3O-KR8uDvJLNSew-1
X-Mimecast-MFC-AGG-ID: Pk05pqq3O-KR8uDvJLNSew_1792419578
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 905C5180086F; Mon, 19 Oct 2026 14:19:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 099311955F28; Mon, 19 Oct 2026 14:19:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C13FF21E6897; Mon, 19 Oct 2026 16:19:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 michael.roth@amd.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com, kkostiuk@redhat.com, alistair.francis@wdc.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v6 19/65] qom: convert QAPI enum properties to QAPI-aware
 registration
Date: Mon, 19 Oct 2026 16:18:43 +0200
Message-ID: <20261019141929.1594337-20-armbru@redhat.com>
In-Reply-To: <20261019141929.1594337-1-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Convert all callers of object_class_property_add_enum() but one to use
the new object_class_property_add_qapi_enum() with the
QAPI_ENUM_PROP() macro, which provides type information via
QAPITypeInfo instead of raw lookup tables and string type names.

This enables QMP QOM introspection to report accurate QAPI type names
for enum properties. Where a separate set_description call was used,
the description is now embedded in the QAPI_ENUM_PROP initializer.

Leave pc_i440fx_machine_options() for later, because enum
PCSouthBridgeOption is a handmade QAPI-like enum instead of a real
one.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/chardev/char.h                   |  8 -------
 authz/list.c                             | 12 ++++++----
 backends/hostmem.c                       | 14 ++++++-----
 crypto/secret_common.c                   | 12 ++++++----
 crypto/tlscreds.c                        | 12 ++++++----
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 19 ++++++++-------
 monitor/qmp.c                            | 12 ++++++----
 net/filter.c                             | 10 +++++---
 target/i386/kvm/kvm.c                    | 30 ++++++++++++++----------
 ui/console-vc.c                          |  8 ++++++-
 ui/dbus.c                                | 18 ++++++++++----
 ui/input-linux.c                         | 11 +++++----
 12 files changed, 99 insertions(+), 67 deletions(-)

diff --git a/include/chardev/char.h b/include/chardev/char.h
index 2616c19cc0..21bf85d197 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -352,12 +352,4 @@ static void set_encoding(Object *obj, int value, Error **errp)  \
     cast_func(obj)->encoding = value;                           \
 }
 
-static inline void chardev_vc_add_encoding_prop(ObjectClass *oc,
-    int (*get)(Object *, Error **),
-    void (*set)(Object *, int, Error **))
-{
-    object_class_property_add_enum(oc, "encoding", "ChardevVCEncoding",
-                                   &ChardevVCEncoding_lookup, get, set);
-}
-
 #endif
diff --git a/authz/list.c b/authz/list.c
index 17aa0efd80..363b2ee12c 100644
--- a/authz/list.c
+++ b/authz/list.c
@@ -22,6 +22,7 @@
 #include "authz/list.h"
 #include "trace.h"
 #include "qom/object_interfaces.h"
+#include "qapi/qapi-type-infos-authz.h"
 #include "qapi/qapi-visit-authz.h"
 #include "qemu/module.h"
 
@@ -120,11 +121,12 @@ qauthz_list_class_init(ObjectClass *oc, const void *data)
 {
     QAuthZClass *authz = QAUTHZ_CLASS(oc);
 
-    object_class_property_add_enum(oc, "policy",
-                                   "QAuthZListPolicy",
-                                   &QAuthZListPolicy_lookup,
-                                   qauthz_list_prop_get_policy,
-                                   qauthz_list_prop_set_policy);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "policy",
+        .qapi_type = &QAuthZListPolicy_type_info,
+        .get = qauthz_list_prop_get_policy,
+        .set = qauthz_list_prop_set_policy,
+    ));
 
     object_class_property_add(oc, "rules", "QAuthZListRule",
                               qauthz_list_prop_get_rules,
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 8782c8b1ea..edb8e6ab45 100644
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
@@ -551,12 +552,13 @@ host_memory_backend_class_init(ObjectClass *oc, const void *data)
         NULL, NULL);
     object_class_property_set_description(oc, "host-nodes",
         "Binds memory to the list of NUMA host nodes");
-    object_class_property_add_enum(oc, "policy", "HostMemPolicy",
-        &HostMemPolicy_lookup,
-        host_memory_backend_get_policy,
-        host_memory_backend_set_policy);
-    object_class_property_set_description(oc, "policy",
-        "Set the NUMA policy");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "policy",
+        .description = "Set the NUMA policy",
+        .qapi_type = &HostMemPolicy_type_info,
+        .get = host_memory_backend_get_policy,
+        .set = host_memory_backend_set_policy,
+    ));
     object_class_property_add_bool(oc, "share",
         host_memory_backend_get_share, host_memory_backend_set_share);
     object_class_property_set_description(oc, "share",
diff --git a/crypto/secret_common.c b/crypto/secret_common.c
index a5ecb876ae..381d23ecc8 100644
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
@@ -269,11 +270,12 @@ qcrypto_secret_class_init(ObjectClass *oc, const void *data)
 
     ucc->complete = qcrypto_secret_complete;
 
-    object_class_property_add_enum(oc, "format",
-                                   "QCryptoSecretFormat",
-                                   &QCryptoSecretFormat_lookup,
-                                   qcrypto_secret_prop_get_format,
-                                   qcrypto_secret_prop_set_format);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "format",
+        .qapi_type = &QCryptoSecretFormat_type_info,
+        .get = qcrypto_secret_prop_get_format,
+        .set = qcrypto_secret_prop_set_format,
+    ));
     object_class_property_add_str(oc, "keyid",
                                   qcrypto_secret_prop_get_keyid,
                                   qcrypto_secret_prop_set_keyid);
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index fb09e295a6..54859720bf 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-crypto.h"
 #include "qapi-types-crypto.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
@@ -221,11 +222,12 @@ qcrypto_tls_creds_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_str(oc, "dir",
                                   qcrypto_tls_creds_prop_get_dir,
                                   qcrypto_tls_creds_prop_set_dir);
-    object_class_property_add_enum(oc, "endpoint",
-                                   "QCryptoTLSCredsEndpoint",
-                                   &QCryptoTLSCredsEndpoint_lookup,
-                                   qcrypto_tls_creds_prop_get_endpoint,
-                                   qcrypto_tls_creds_prop_set_endpoint);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "endpoint",
+        .qapi_type = &QCryptoTLSCredsEndpoint_type_info,
+        .get = qcrypto_tls_creds_prop_get_endpoint,
+        .set = qcrypto_tls_creds_prop_set_endpoint,
+    ));
     object_class_property_add_str(oc, "priority",
                                   qcrypto_tls_creds_prop_get_priority,
                                   qcrypto_tls_creds_prop_set_priority);
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index c5f6431900..9a8fcc6678 100644
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
@@ -174,14 +175,16 @@ static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc,
     mc->init = petalogix_s3adsp1800_init;
     mc->is_default = true;
 
-    prop = object_class_property_add_enum(oc, "endianness", "EndianMode",
-                                          &EndianMode_lookup,
-                                          machine_get_endianness,
-                                          machine_set_endianness);
-    object_property_set_default_str(prop, target_big_endian() ? "big"
-                                                              : "little");
-    object_class_property_set_description(oc, "endianness",
-            "Defines whether the machine runs in big or little endian mode");
+    prop = object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "endianness",
+        .description =
+            "Defines whether the machine runs in big or little endian mode",
+        .qapi_type = &EndianMode_type_info,
+        .get = machine_get_endianness,
+        .set = machine_set_endianness,
+    ));
+    object_property_set_default_enum(prop,
+        target_big_endian() ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE);
 }
 
 static const TypeInfo petalogix_s3adsp1800_machine_types[] = {
diff --git a/monitor/qmp.c b/monitor/qmp.c
index eb44012643..c2849214d5 100644
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
@@ -133,11 +134,12 @@ static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
     object_class_property_add_bool(cls, "pretty",
                                    monitor_qmp_get_pretty,
                                    monitor_qmp_set_pretty);
-    object_class_property_add_enum(cls, "close-action",
-                                   "MonitorQMPCloseAction",
-                                   &MonitorQMPCloseAction_lookup,
-                                   monitor_qmp_get_close_action,
-                                   monitor_qmp_set_close_action);
+    object_class_property_add_qapi_enum(cls, QAPI_ENUM_PROP(
+        .name = "close-action",
+        .qapi_type = &MonitorQMPCloseAction_type_info,
+        .get = monitor_qmp_get_close_action,
+        .set = monitor_qmp_set_close_action,
+    ));
 
     moncls->emit_event = monitor_qmp_emit_event;
     moncls->requires_iothread = monitor_qmp_requires_iothread;
diff --git a/net/filter.c b/net/filter.c
index 389f3b0bfe..79883af22a 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 
@@ -342,9 +343,12 @@ static void netfilter_class_init(ObjectClass *oc, const void *data)
 
     object_class_property_add_str(oc, "netdev",
                                   netfilter_get_netdev_id, netfilter_set_netdev_id);
-    object_class_property_add_enum(oc, "queue", "NetFilterDirection",
-                                   &NetFilterDirection_lookup,
-                                   netfilter_get_direction, netfilter_set_direction);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "queue",
+        .qapi_type = &NetFilterDirection_type_info,
+        .get = netfilter_get_direction,
+        .set = netfilter_set_direction,
+    ));
     object_class_property_add_str(oc, "status",
                                   netfilter_get_status, netfilter_set_status);
     object_class_property_add_str(oc, "position",
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index da922f72d7..f2e8dc8c15 100644
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
@@ -7089,12 +7091,13 @@ static void kvm_arch_set_honor_guest_pat(Object *obj, int value, Error **errp)
 
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
-    object_class_property_add_enum(oc, "notify-vmexit", "NotifyVMexitOption",
-                                   &NotifyVmexitOption_lookup,
-                                   kvm_arch_get_notify_vmexit,
-                                   kvm_arch_set_notify_vmexit);
-    object_class_property_set_description(oc, "notify-vmexit",
-                                          "Enable notify VM exit");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "notify-vmexit",
+        .description = "Enable notify VM exit",
+        .qapi_type = &NotifyVmexitOption_type_info,
+        .get = kvm_arch_get_notify_vmexit,
+        .set = kvm_arch_set_notify_vmexit,
+    ));
 
     object_class_property_add(oc, "notify-window", "uint32",
                               kvm_arch_get_notify_window,
@@ -7127,13 +7130,14 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
     object_class_property_set_description(oc, "xen-evtchn-max-pirq",
                                           "Maximum number of Xen PIRQs");
 
-    object_class_property_add_enum(oc, "honor-guest-pat", "OnOffAuto",
-                                   &OnOffAuto_lookup,
-                                   kvm_arch_get_honor_guest_pat,
-                                   kvm_arch_set_honor_guest_pat);
-    object_class_property_set_description(oc, "honor-guest-pat",
-                                          "Disable KVM quirk that ignores guest PAT "
-                                          "memory type settings (default: auto)");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "honor-guest-pat",
+        .description = "Disable KVM quirk that ignores guest PAT "
+                       "memory type settings (default: auto)",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = kvm_arch_get_honor_guest_pat,
+        .set = kvm_arch_set_honor_guest_pat,
+    ));
 }
 
 void kvm_set_max_apic_id(uint32_t max_apic_id)
diff --git a/ui/console-vc.c b/ui/console-vc.c
index 99cc8f09c8..cca4790c99 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -6,6 +6,7 @@
 
 #include "chardev/char.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-char.h"
 #include "qemu/option.h"
 #include "qemu/queue.h"
 #include "qom/compat-properties.h"
@@ -326,7 +327,12 @@ static void char_vc_class_init(ObjectClass *oc, const void *data)
     cc->supports_size_opts = true;
     cc->supports_encoding_opts = true;
 
-    chardev_vc_add_encoding_prop(oc, get_encoding, set_encoding);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "encoding",
+        .qapi_type = &ChardevVCEncoding_type_info,
+        .get = get_encoding,
+        .set = set_encoding,
+    ));
 }
 
 static void char_vc_init(Object *obj)
diff --git a/ui/dbus.c b/ui/dbus.c
index 7be0f8e261..afc321514c 100644
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
@@ -508,9 +510,12 @@ dbus_display_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "p2p", get_dbus_p2p, set_dbus_p2p);
     object_class_property_add_str(oc, "addr", get_dbus_addr, set_dbus_addr);
     object_class_property_add_str(oc, "audiodev", get_audiodev, set_audiodev);
-    object_class_property_add_enum(oc, "gl-mode",
-                                   "DisplayGLMode", &DisplayGLMode_lookup,
-                                   get_gl_mode, set_gl_mode);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "gl-mode",
+        .qapi_type = &DisplayGLMode_type_info,
+        .get = get_gl_mode,
+        .set = set_gl_mode,
+    ));
 }
 
 #define TYPE_CHARDEV_VC "chardev-vc"
@@ -602,7 +607,12 @@ dbus_vc_class_init(ObjectClass *oc, const void *data)
     cc->chr_open = dbus_vc_open;
     cc->supports_encoding_opts = true;
 
-    chardev_vc_add_encoding_prop(oc, get_encoding, set_encoding);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "encoding",
+        .qapi_type = &ChardevVCEncoding_type_info,
+        .get = get_encoding,
+        .set = set_encoding,
+    ));
 }
 
 static void
diff --git a/ui/input-linux.c b/ui/input-linux.c
index f4eee1ffd7..715d1f5892 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -6,6 +6,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qemu/config-file.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
@@ -506,10 +507,12 @@ static void input_linux_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "repeat",
                                    input_linux_get_repeat,
                                    input_linux_set_repeat);
-    object_class_property_add_enum(oc, "grab-toggle", "GrabToggleKeys",
-                                   &GrabToggleKeys_lookup,
-                                   input_linux_get_grab_toggle,
-                                   input_linux_set_grab_toggle);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "grab-toggle",
+        .qapi_type = &GrabToggleKeys_type_info,
+        .get = input_linux_get_grab_toggle,
+        .set = input_linux_set_grab_toggle,
+    ));
 }
 
 static const TypeInfo input_linux_info = {
-- 
2.55.0


