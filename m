Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42971CD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE5C-0004gc-87; Mon, 15 Jun 2026 16:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE59-0004Qq-Mt
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE57-0002Jc-AJ
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781555932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DuDRW6V+aWzKlJuNxqSfmtV/QT53trqII/zulWui71g=;
 b=YVFh5mvOKJ4lP1Ul9uClwKaFC6MTnRsmth9UTzlcCU3dUDl+lfm9konHCQOLtb7BpKYGO3
 yeZQu5RsxltbZMD0ZGN2n/X8nX7Hqy2WR+lblfbBSRHyr7oJTjesZkQIFin3UZ1OBX6VFG
 y9qX7Y+LFyJtr1nJo7j9Qkc4DagdFBE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-cmAT4Iw7P46kZ81oNyZaaQ-1; Mon,
 15 Jun 2026 16:38:48 -0400
X-MC-Unique: cmAT4Iw7P46kZ81oNyZaaQ-1
X-Mimecast-MFC-AGG-ID: cmAT4Iw7P46kZ81oNyZaaQ_1781555927
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36ECF195608E; Mon, 15 Jun 2026 20:38:47 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A533619560B2; Mon, 15 Jun 2026 20:38:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:37:38 +0400
Subject: [PATCH v2 12/53] qom: convert enum properties to QAPI-aware
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-12-cc9396b9c18c@redhat.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
In-Reply-To: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=18173;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=EKTLk9xasxbVdTFQRFQCLxASDX1dmN60PxBcWGsOCO8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKObeXy9QIvMwe0iqHFAI8JZTnNpRTRGUn4p
 nWZt2ly/V2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijgAKCRDa6OEJdZac
 5TnEEACvuzaNNymF3OSIThnVlgJEIor1o8b3cIImsK5MuGxi2K8psxa3N0e+F9+1RKAL4m80TmY
 /BPlTxjrugn4EOZKWcJquq2w4FaQLwefflBw0s7ghyZNWd5T6bHeeOi9/3qiopA+MT1dBVCpw+3
 c8+kqKM9k55VSQN2A+2tDqfyDK5NxzisO+6X3fFK49dLI4E38mwbMatQTOy1JjqQ7AqZmTqMIM0
 8GgU8Vz3W1JgNgrs8Eeizl2X2bmdLO5v8OZalYdIVgA4sK2cuaYl40OP0mS1wViWI8q7F4uHLWK
 LeqwrFW8DuLJQAB/dTtq1G3nSpsCSYdpXyDuaCKEFIvHnGkSUqeCqMNkQ0V2N3TG0CWK/SFNqM5
 bI0qkWdSPQe+ucSLwjrFwZENAX5QnIZt4s2IKQLlR1ie2YTxb+i2R00tbZi+AV/N3o40P8mIz8X
 fN+GItvBizyZ7g5CXSjwLMae6Z+/SCEstA0ADiqEdVvWZyrFTRTm75p0w6gMOskqXTShPw3jNLz
 SXqYkzkp8VQNqfRtnVuX3YgPSz8HnqbPkICXGqO+YKwNwXCeu51MQmGE57IgSil3yQzetsCft54
 o0jogNmG3sQ0CEOaFtFdpz3diBmiT4MYl2ghBEZO1KmuWM8Dq/c8jUuaRUy8M7vDTc1nQ6+/ohS
 V1QaZXVn8gv0y3A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Convert all callers of object_class_property_add_enum() to use the new
object_class_property_add_qapi_enum() with the QAPI_ENUM_PROP()
macro, which provides type information via QAPITypeInfo instead of
raw lookup tables and string type names.

This enables QMP introspection to report accurate QAPI type names
for enum properties. Where a separate set_description call was used,
the description is now embedded in the QAPI_ENUM_PROP initializer.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/chardev/char.h                   |  8 --------
 authz/list.c                             | 12 +++++++-----
 backends/hostmem.c                       | 14 ++++++++------
 crypto/secret_common.c                   | 12 +++++++-----
 crypto/tlscreds.c                        | 12 +++++++-----
 hw/i386/pc_piix.c                        | 19 +++++++++++++------
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 19 +++++++++++--------
 net/filter.c                             | 10 +++++++---
 target/i386/kvm/kvm.c                    | 30 +++++++++++++++++-------------
 ui/console-vc.c                          |  8 +++++++-
 ui/dbus.c                                | 18 ++++++++++++++----
 ui/input-linux.c                         | 11 +++++++----
 12 files changed, 105 insertions(+), 68 deletions(-)

diff --git a/include/chardev/char.h b/include/chardev/char.h
index 7377d8e60a0..f5e53b3867a 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -343,12 +343,4 @@ static void set_encoding(Object *obj, int value, Error **errp)  \
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
index 17aa0efd80e..363b2ee12c9 100644
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
index cd2085fb3cd..d0977552b40 100644
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
@@ -548,12 +549,13 @@ host_memory_backend_class_init(ObjectClass *oc, const void *data)
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
index a5ecb876aeb..381d23ecc8e 100644
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
index fb09e295a65..54859720bf7 100644
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
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 82457bdb167..91a371b12d7 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -47,6 +47,7 @@
 #include "hw/acpi/acpi.h"
 #include "hw/vfio/types.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-info.h"
 #include "qemu/error-report.h"
 #include "system/xen.h"
 #ifdef CONFIG_XEN
@@ -336,6 +337,11 @@ static const QEnumLookup PCSouthBridgeOption_lookup = {
     .size = PC_SOUTH_BRIDGE_OPTION_MAX
 };
 
+static const QAPITypeInfo PCSouthBridgeOption_type_info = {
+    .name = "PCSouthBridgeOption",
+    .lookup = &PCSouthBridgeOption_lookup,
+};
+
 static int pc_get_south_bridge(Object *obj, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
@@ -418,12 +424,13 @@ static void pc_i440fx_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_UEFI_VARS_X64);
 
-    object_class_property_add_enum(oc, "x-south-bridge", "PCSouthBridgeOption",
-                                   &PCSouthBridgeOption_lookup,
-                                   pc_get_south_bridge,
-                                   pc_set_south_bridge);
-    object_class_property_set_description(oc, "x-south-bridge",
-                                     "Use a different south bridge than PIIX3");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "x-south-bridge",
+        .description = "Use a different south bridge than PIIX3",
+        .qapi_type = &PCSouthBridgeOption_type_info,
+        .get = pc_get_south_bridge,
+        .set = pc_set_south_bridge,
+    ));
     compat_props_add(m->compat_props,
                      pc_piix_compat_defaults, pc_piix_compat_defaults_len);
 }
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index c5f64319009..9a8fcc66781 100644
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
diff --git a/net/filter.c b/net/filter.c
index 389f3b0bfef..79883af22a5 100644
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
index 9e352882c8c..ecf0c76fcdf 100644
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
@@ -7086,12 +7088,13 @@ static void kvm_arch_set_honor_guest_pat(Object *obj, int value, Error **errp)
 
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
@@ -7124,13 +7127,14 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
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
index 828e78c41ea..286b39fe8ae 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -6,6 +6,7 @@
 
 #include "chardev/char.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-char.h"
 #include "qemu/option.h"
 #include "qemu/queue.h"
 #include "qom/compat-properties.h"
@@ -317,7 +318,12 @@ static void char_vc_class_init(ObjectClass *oc, const void *data)
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
index e02a94df2f3..ce3e1ad0055 100644
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
@@ -449,9 +451,12 @@ dbus_display_class_init(ObjectClass *oc, const void *data)
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
@@ -543,7 +548,12 @@ dbus_vc_class_init(ObjectClass *oc, const void *data)
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
index f4eee1ffd7e..715d1f58929 100644
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
2.54.0


