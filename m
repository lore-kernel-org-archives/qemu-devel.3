Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EA9606A325
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GZSP7gjM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNc02-0005AK-So; Sun, 01 Nov 2026 15:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzl-0004uv-Nt
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzd-0007BO-Ss
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793564248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E7Ca6L0OIH9p7Kld2rQUX0hFdwCHdbUHLuj8v7WhKsM=;
 b=GZSP7gjMNSLgX/mSutCCT8E2/+O1IAFek1vdCnbDfyFj/5O5P2wq5Xxm9NSR7u6s8qjQMK
 JFemeh+pZY6ry+YqKrGSGdjQAGD6VRc0/f+A8HaCGh9NpN7CIUe2uM/gXBmp8dDn4DQIpQ
 WyjsZP4vvMZeHft1n+2afOUPeX7fwhk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-hDQtQiTEPJi9Q7NO9f9cTQ-1; Sun,
 01 Nov 2026 15:17:27 -0500
X-MC-Unique: hDQtQiTEPJi9Q7NO9f9cTQ-1
X-Mimecast-MFC-AGG-ID: hDQtQiTEPJi9Q7NO9f9cTQ_1793564246
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 527481800646
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBADB3000B56
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D98E521E6894; Sun, 01 Nov 2026 21:17:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v8 16/56] qom: New object_property_add_enum() etc. parameter
 @qapi_type
Date: Sun,  1 Nov 2026 21:16:37 +0100
Message-ID: <20261101201717.3911097-17-armbru@redhat.com>
In-Reply-To: <20261101201717.3911097-1-armbru@redhat.com>
References: <20261101201717.3911097-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Callers may either pass a non-null @lookup, or a non-null @qapi_type.
For now, all pass a non-null @lookup and a null @qapi_type.  Callers
updated with this Coccinelle script:

@@
identifier fun = {
    object_property_add_enum, object_class_property_add_enum
};
expression obj, name, type;
@@
-    fun(obj, name, type,
+    fun(obj, name, type, NULL,
     ...)

Future patches will eliminate non-null @lookup and drop the parameter.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/chardev/char.h                   |  2 +-
 include/qom/object.h                     |  4 ++++
 authz/list.c                             |  3 +--
 backends/hostmem.c                       |  8 ++++----
 crypto/secret_common.c                   |  3 +--
 crypto/tlscreds.c                        |  4 ++--
 hw/i386/pc_piix.c                        |  3 ++-
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
 monitor/qmp.c                            |  2 +-
 net/filter.c                             |  2 +-
 qom/object.c                             | 15 +++++++++++----
 target/i386/kvm/kvm.c                    |  3 ++-
 tests/unit/check-qom-proplist.c          |  3 +--
 ui/dbus.c                                |  4 ++--
 ui/input-linux.c                         |  2 +-
 15 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/include/chardev/char.h b/include/chardev/char.h
index 2616c19cc0..5283cc0d5d 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -356,7 +356,7 @@ static inline void chardev_vc_add_encoding_prop(ObjectClass *oc,
     int (*get)(Object *, Error **),
     void (*set)(Object *, int, Error **))
 {
-    object_class_property_add_enum(oc, "encoding", "ChardevVCEncoding",
+    object_class_property_add_enum(oc, "encoding", "ChardevVCEncoding", NULL,
                                    &ChardevVCEncoding_lookup, get, set);
 }
 
diff --git a/include/qom/object.h b/include/qom/object.h
index 84b273e535..e9a67017fa 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1987,6 +1987,7 @@ ObjectProperty *object_class_property_add_bool(ObjectClass *klass,
  * @obj: the object to add a property to
  * @name: the name of the property
  * @typename: the name of the enum data type
+ * @qapi_type: QAPI type info descriptor
  * @lookup: enum value namelookup table
  * @get: the getter or %NULL if the property is write-only.
  * @set: the setter or %NULL if the property is read-only
@@ -1998,6 +1999,7 @@ ObjectProperty *object_class_property_add_bool(ObjectClass *klass,
  */
 ObjectProperty *object_property_add_enum(Object *obj, const char *name,
                               const char *typename,
+                              const QAPITypeInfo *qapi_type,
                               const QEnumLookup *lookup,
                               int (*get)(Object *, Error **),
                               void (*set)(Object *, int, Error **));
@@ -2007,6 +2009,7 @@ ObjectProperty *object_property_add_enum(Object *obj, const char *name,
  * @klass: the object class to add a property to
  * @name: the name of the property
  * @typename: the name of the enum data type
+ * @qapi_type: QAPI type info descriptor
  * @lookup: enum value namelookup table
  * @get: the getter or %NULL if the property is write-only.
  * @set: the setter or %NULL if the property is read-only
@@ -2019,6 +2022,7 @@ ObjectProperty *object_property_add_enum(Object *obj, const char *name,
 ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
                                     const char *name,
                                     const char *typename,
+                                    const QAPITypeInfo *qapi_type,
                                     const QEnumLookup *lookup,
                                     int (*get)(Object *, Error **),
                                     void (*set)(Object *, int, Error **));
diff --git a/authz/list.c b/authz/list.c
index 72aedc6ac4..40fbccd87e 100644
--- a/authz/list.c
+++ b/authz/list.c
@@ -120,8 +120,7 @@ qauthz_list_class_init(ObjectClass *oc, const void *data)
 {
     QAuthZClass *authz = QAUTHZ_CLASS(oc);
 
-    object_class_property_add_enum(oc, "policy",
-                                   "QAuthZListPolicy",
+    object_class_property_add_enum(oc, "policy", "QAuthZListPolicy", NULL,
                                    &QAuthZListPolicy_lookup,
                                    qauthz_list_prop_get_policy,
                                    qauthz_list_prop_set_policy);
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 299a3b90fe..c5882f0b16 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -551,10 +551,10 @@ host_memory_backend_class_init(ObjectClass *oc, const void *data)
                               NULL, NULL);
     object_class_property_set_description(oc, "host-nodes",
         "Binds memory to the list of NUMA host nodes");
-    object_class_property_add_enum(oc, "policy", "HostMemPolicy",
-        &HostMemPolicy_lookup,
-        host_memory_backend_get_policy,
-        host_memory_backend_set_policy);
+    object_class_property_add_enum(oc, "policy", "HostMemPolicy", NULL,
+                                   &HostMemPolicy_lookup,
+                                   host_memory_backend_get_policy,
+                                   host_memory_backend_set_policy);
     object_class_property_set_description(oc, "policy",
         "Set the NUMA policy");
     object_class_property_add_bool(oc, "share",
diff --git a/crypto/secret_common.c b/crypto/secret_common.c
index a5ecb876ae..16df64b336 100644
--- a/crypto/secret_common.c
+++ b/crypto/secret_common.c
@@ -269,8 +269,7 @@ qcrypto_secret_class_init(ObjectClass *oc, const void *data)
 
     ucc->complete = qcrypto_secret_complete;
 
-    object_class_property_add_enum(oc, "format",
-                                   "QCryptoSecretFormat",
+    object_class_property_add_enum(oc, "format", "QCryptoSecretFormat", NULL,
                                    &QCryptoSecretFormat_lookup,
                                    qcrypto_secret_prop_get_format,
                                    qcrypto_secret_prop_set_format);
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index fb09e295a6..db74d302cc 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -221,8 +221,8 @@ qcrypto_tls_creds_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_str(oc, "dir",
                                   qcrypto_tls_creds_prop_get_dir,
                                   qcrypto_tls_creds_prop_set_dir);
-    object_class_property_add_enum(oc, "endpoint",
-                                   "QCryptoTLSCredsEndpoint",
+    object_class_property_add_enum(oc, "endpoint", "QCryptoTLSCredsEndpoint",
+                                   NULL,
                                    &QCryptoTLSCredsEndpoint_lookup,
                                    qcrypto_tls_creds_prop_get_endpoint,
                                    qcrypto_tls_creds_prop_set_endpoint);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 63c4667ea3..ae07e6c56c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -413,7 +413,8 @@ static void pc_i440fx_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_UEFI_VARS_X64);
 
-    object_class_property_add_enum(oc, "x-south-bridge", "PCSouthBridgeOption",
+    object_class_property_add_enum(oc, "x-south-bridge",
+                                   "PCSouthBridgeOption", NULL,
                                    &PCSouthBridgeOption_lookup,
                                    pc_get_south_bridge,
                                    pc_set_south_bridge);
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index c5f6431900..8cf7cda7d9 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -175,6 +175,7 @@ static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc,
     mc->is_default = true;
 
     prop = object_class_property_add_enum(oc, "endianness", "EndianMode",
+                                          NULL,
                                           &EndianMode_lookup,
                                           machine_get_endianness,
                                           machine_set_endianness);
diff --git a/monitor/qmp.c b/monitor/qmp.c
index eb44012643..8d7e49d1ce 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -134,7 +134,7 @@ static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
                                    monitor_qmp_get_pretty,
                                    monitor_qmp_set_pretty);
     object_class_property_add_enum(cls, "close-action",
-                                   "MonitorQMPCloseAction",
+                                   "MonitorQMPCloseAction", NULL,
                                    &MonitorQMPCloseAction_lookup,
                                    monitor_qmp_get_close_action,
                                    monitor_qmp_set_close_action);
diff --git a/net/filter.c b/net/filter.c
index 389f3b0bfe..5311622aca 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -342,7 +342,7 @@ static void netfilter_class_init(ObjectClass *oc, const void *data)
 
     object_class_property_add_str(oc, "netdev",
                                   netfilter_get_netdev_id, netfilter_set_netdev_id);
-    object_class_property_add_enum(oc, "queue", "NetFilterDirection",
+    object_class_property_add_enum(oc, "queue", "NetFilterDirection", NULL,
                                    &NetFilterDirection_lookup,
                                    netfilter_get_direction, netfilter_set_direction);
     object_class_property_add_str(oc, "status",
diff --git a/qom/object.c b/qom/object.c
index 9a0966c911..0ef0d4d42c 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2501,6 +2501,7 @@ object_class_property_add_bool(ObjectClass *klass, const char *name,
 }
 
 typedef struct EnumProperty {
+    const QAPITypeInfo *qapi_type; /* non-null for QAPI enums */
     const QEnumLookup *lookup;
     int (*get)(Object *, Error **);
     void (*set)(Object *, int, Error **);
@@ -2537,17 +2538,20 @@ static void property_set_enum(Object *obj, Visitor *v, const char *name,
 ObjectProperty *
 object_property_add_enum(Object *obj, const char *name,
                          const char *typename,
+                         const QAPITypeInfo *qapi_type,
                          const QEnumLookup *lookup,
                          int (*get)(Object *, Error **),
                          void (*set)(Object *, int, Error **))
 {
     EnumProperty *prop = g_malloc(sizeof(*prop));
 
-    prop->lookup = lookup;
+    assert(!qapi_type != !lookup);
+    prop->qapi_type = qapi_type;
+    prop->lookup = lookup ?: qapi_type->lookup;
     prop->get = get;
     prop->set = set;
 
-    return object_property_add(obj, name, typename, NULL,
+    return object_property_add(obj, name, typename, qapi_type,
                                get ? property_get_enum : NULL,
                                set ? property_set_enum : NULL,
                                property_release_data,
@@ -2557,17 +2561,20 @@ object_property_add_enum(Object *obj, const char *name,
 ObjectProperty *
 object_class_property_add_enum(ObjectClass *klass, const char *name,
                                     const char *typename,
+                                    const QAPITypeInfo *qapi_type,
                                     const QEnumLookup *lookup,
                                     int (*get)(Object *, Error **),
                                     void (*set)(Object *, int, Error **))
 {
     EnumProperty *prop = g_malloc(sizeof(*prop));
 
-    prop->lookup = lookup;
+    assert(!qapi_type != !lookup);
+    prop->qapi_type = qapi_type;
+    prop->lookup = lookup ?: qapi_type->lookup;
     prop->get = get;
     prop->set = set;
 
-    return object_class_property_add(klass, name, typename, NULL,
+    return object_class_property_add(klass, name, typename, qapi_type,
                                      get ? property_get_enum : NULL,
                                      set ? property_set_enum : NULL,
                                      NULL,
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 32175604e6..abd9aa6241 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -7090,6 +7090,7 @@ static void kvm_arch_set_honor_guest_pat(Object *obj, int value, Error **errp)
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
     object_class_property_add_enum(oc, "notify-vmexit", "NotifyVMexitOption",
+                                   NULL,
                                    &NotifyVmexitOption_lookup,
                                    kvm_arch_get_notify_vmexit,
                                    kvm_arch_set_notify_vmexit);
@@ -7127,7 +7128,7 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
     object_class_property_set_description(oc, "xen-evtchn-max-pirq",
                                           "Maximum number of Xen PIRQs");
 
-    object_class_property_add_enum(oc, "honor-guest-pat", "OnOffAuto",
+    object_class_property_add_enum(oc, "honor-guest-pat", "OnOffAuto", NULL,
                                    &OnOffAuto_lookup,
                                    kvm_arch_get_honor_guest_pat,
                                    kvm_arch_set_honor_guest_pat);
diff --git a/tests/unit/check-qom-proplist.c b/tests/unit/check-qom-proplist.c
index 89de92b7d9..804d066f28 100644
--- a/tests/unit/check-qom-proplist.c
+++ b/tests/unit/check-qom-proplist.c
@@ -140,8 +140,7 @@ static void dummy_class_init(ObjectClass *cls, const void *data)
     object_class_property_add_str(cls, "sv",
                                   dummy_get_sv,
                                   dummy_set_sv);
-    object_class_property_add_enum(cls, "av",
-                                   "DummyAnimal",
+    object_class_property_add_enum(cls, "av", "DummyAnimal", NULL,
                                    &dummy_animal_map,
                                    dummy_get_av,
                                    dummy_set_av);
diff --git a/ui/dbus.c b/ui/dbus.c
index 7be0f8e261..966c2c8b4e 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -508,8 +508,8 @@ dbus_display_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "p2p", get_dbus_p2p, set_dbus_p2p);
     object_class_property_add_str(oc, "addr", get_dbus_addr, set_dbus_addr);
     object_class_property_add_str(oc, "audiodev", get_audiodev, set_audiodev);
-    object_class_property_add_enum(oc, "gl-mode",
-                                   "DisplayGLMode", &DisplayGLMode_lookup,
+    object_class_property_add_enum(oc, "gl-mode", "DisplayGLMode", NULL,
+                                   &DisplayGLMode_lookup,
                                    get_gl_mode, set_gl_mode);
 }
 
diff --git a/ui/input-linux.c b/ui/input-linux.c
index f4eee1ffd7..ea4d76e75d 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -506,7 +506,7 @@ static void input_linux_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "repeat",
                                    input_linux_get_repeat,
                                    input_linux_set_repeat);
-    object_class_property_add_enum(oc, "grab-toggle", "GrabToggleKeys",
+    object_class_property_add_enum(oc, "grab-toggle", "GrabToggleKeys", NULL,
                                    &GrabToggleKeys_lookup,
                                    input_linux_get_grab_toggle,
                                    input_linux_set_grab_toggle);
-- 
2.55.0


