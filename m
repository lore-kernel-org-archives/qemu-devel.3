Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0860606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ioe52EpS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNc1G-0006H0-Co; Sun, 01 Nov 2026 15:19:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzt-00055v-TP
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzh-0007EG-4p
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793564252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6t0D0fURl2GvAxppybGdR9M0EHQSWp60lEziTqdyGw=;
 b=Ioe52EpSASOwh+W1tN9ujJa3Kd0JX/xE+PneuIz4XP9PivSuwnLdCdBjFMXMj6Q/Pt6AoR
 c1VmH7oY06r///zIxFNLp0NUKLMpgSejZzEmcKm3N2EhKllzRFfqVViwaIyuMT33AH17go
 fjThjJ5MBPnpdsy3Q6B5DJeqmNAz+Y8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-5Rz6-D5pPwGEiTZ9hSTW5A-1; Sun,
 01 Nov 2026 15:17:30 -0500
X-MC-Unique: 5Rz6-D5pPwGEiTZ9hSTW5A-1
X-Mimecast-MFC-AGG-ID: 5Rz6-D5pPwGEiTZ9hSTW5A_1793564250
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 033A618005B4
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7733B1800444
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9762A21E6686; Sun, 01 Nov 2026 21:17:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v8 54/56] qom: Drop object_property_add_enum() parameter
 @lookup
Date: Sun,  1 Nov 2026 21:17:15 +0100
Message-ID: <20261101201717.3911097-55-armbru@redhat.com>
In-Reply-To: <20261101201717.3911097-1-armbru@redhat.com>
References: <20261101201717.3911097-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

All callers now pass non-null @qapi_type and null @lookup.  Drop
@lookup and simplify the code accordingly.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/chardev/char.h                   |  3 +--
 include/qom/object.h                     |  4 ----
 accel/hvf/hvf-all.c                      |  2 +-
 accel/kvm/kvm-all.c                      |  2 +-
 accel/whpx/whpx-common.c                 |  4 ++--
 authz/list.c                             |  1 -
 backends/hostmem-file.c                  |  2 +-
 backends/hostmem-memfd.c                 |  4 ++--
 backends/hostmem.c                       |  2 +-
 crypto/secret_common.c                   |  2 +-
 crypto/tlscreds.c                        |  2 +-
 hw/arm/virt.c                            |  4 ++--
 hw/i386/microvm.c                        | 15 ++++++---------
 hw/i386/pc.c                             |  5 ++---
 hw/i386/pc_piix.c                        |  5 ++---
 hw/i386/x86.c                            | 12 ++++--------
 hw/loongarch/virt.c                      | 14 +++++++-------
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  2 +-
 hw/riscv/virt.c                          | 10 +++++-----
 monitor/qmp.c                            |  2 +-
 net/filter.c                             |  5 +++--
 qom/object.c                             | 15 ++++-----------
 target/i386/kvm/kvm.c                    |  4 ++--
 target/i386/sev.c                        |  2 +-
 target/i386/whpx/whpx-all.c              |  7 +++----
 tests/unit/check-qom-proplist.c          |  3 +--
 ui/dbus.c                                |  4 ++--
 ui/input-linux.c                         |  2 +-
 28 files changed, 58 insertions(+), 81 deletions(-)

diff --git a/include/chardev/char.h b/include/chardev/char.h
index 61e6957118..45fc3edb5e 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -358,8 +358,7 @@ static inline void chardev_vc_add_encoding_prop(ObjectClass *oc,
     void (*set)(Object *, int, Error **))
 {
     object_class_property_add_enum(oc, "encoding", "ChardevVCEncoding",
-                                   &ChardevVCEncoding_type_info, NULL,
-                                   get, set);
+                                   &ChardevVCEncoding_type_info, get, set);
 }
 
 #endif
diff --git a/include/qom/object.h b/include/qom/object.h
index d1699964fa..a90cd30675 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1988,7 +1988,6 @@ ObjectProperty *object_class_property_add_bool(ObjectClass *klass,
  * @name: the name of the property
  * @typename: the name of the enum data type
  * @qapi_type: QAPI type info descriptor
- * @lookup: enum value namelookup table
  * @get: the getter or %NULL if the property is write-only.
  * @set: the setter or %NULL if the property is read-only
  *
@@ -2000,7 +1999,6 @@ ObjectProperty *object_class_property_add_bool(ObjectClass *klass,
 ObjectProperty *object_property_add_enum(Object *obj, const char *name,
                               const char *typename,
                               const QAPITypeInfo *qapi_type,
-                              const QEnumLookup *lookup,
                               int (*get)(Object *, Error **),
                               void (*set)(Object *, int, Error **));
 
@@ -2010,7 +2008,6 @@ ObjectProperty *object_property_add_enum(Object *obj, const char *name,
  * @name: the name of the property
  * @typename: the name of the enum data type
  * @qapi_type: QAPI type info descriptor
- * @lookup: enum value namelookup table
  * @get: the getter or %NULL if the property is write-only.
  * @set: the setter or %NULL if the property is read-only
  *
@@ -2023,7 +2020,6 @@ ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
                                     const char *name,
                                     const char *typename,
                                     const QAPITypeInfo *qapi_type,
-                                    const QEnumLookup *lookup,
                                     int (*get)(Object *, Error **),
                                     void (*set)(Object *, int, Error **));
 
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 938379b9f2..f233d86c06 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -271,7 +271,7 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
 
     object_class_property_add_enum(oc, "kernel-irqchip", "on|off|split",
                                    &OnOffSplit_type_info, NULL,
-                                   NULL, hvf_set_kernel_irqchip);
+                                   hvf_set_kernel_irqchip);
     object_class_property_set_description(oc, "kernel-irqchip",
         "Configure HVF irqchip");
 }
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index dcb1db139d..313c41c4a2 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4299,7 +4299,7 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
 
     object_class_property_add_enum(oc, "kernel-irqchip", "on|off|split",
                                    &OnOffSplit_type_info, NULL,
-                                   NULL, kvm_set_kernel_irqchip);
+                                   kvm_set_kernel_irqchip);
     object_class_property_set_description(oc, "kernel-irqchip",
         "Configure KVM in-kernel irqchip");
 
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 068258bf6c..78d2827809 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -510,12 +510,12 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
 
     object_class_property_add_enum(oc, "kernel-irqchip", "on|off|split",
                                    &OnOffSplit_type_info, NULL,
-                                   NULL, whpx_set_kernel_irqchip);
+                                   whpx_set_kernel_irqchip);
     object_class_property_set_description(oc, "kernel-irqchip",
         "Configure WHPX in-kernel irqchip");
     object_class_property_add_enum(oc, "hyperv", "OnOffAuto",
                                    &OnOffAuto_type_info, NULL,
-                                   NULL, whpx_set_hyperv);
+                                   whpx_set_hyperv);
     object_class_property_set_description(oc, "hyperv",
         "Configure Hyper-V enlightenments");
 
diff --git a/authz/list.c b/authz/list.c
index 75155cf077..c3dd9d7b68 100644
--- a/authz/list.c
+++ b/authz/list.c
@@ -123,7 +123,6 @@ qauthz_list_class_init(ObjectClass *oc, const void *data)
 
     object_class_property_add_enum(oc, "policy", "QAuthZListPolicy",
                                    &QAuthZListPolicy_type_info,
-                                   NULL,
                                    qauthz_list_prop_get_policy,
                                    qauthz_list_prop_set_policy);
 
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 2f65ca3678..6ad9cad032 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -293,7 +293,7 @@ file_backend_class_init(ObjectClass *oc, const void *data)
         file_memory_backend_get_readonly,
         file_memory_backend_set_readonly);
     object_class_property_add_enum(oc, "rom", "OnOffAuto",
-                                   &OnOffAuto_type_info, NULL,
+                                   &OnOffAuto_type_info,
                                    file_memory_backend_get_rom,
                                    file_memory_backend_set_rom);
     object_class_property_set_description(oc, "rom",
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 19a9a5b409..496455f7aa 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -201,8 +201,8 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
                                               "Huge pages size (ex: 2M, 1G)");
     }
 
-    object_class_property_add_enum(oc, "guest-memfd",  "OnOffAuto",
-                                   &OnOffAuto_type_info, NULL,
+    object_class_property_add_enum(oc, "guest-memfd", "OnOffAuto",
+                                   &OnOffAuto_type_info,
                                    memfd_backend_get_guest_memfd,
                                    memfd_backend_set_guest_memfd);
     object_class_property_set_description(oc, "guest-memfd",
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 0f39f4d1b7..173d042be3 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -554,7 +554,7 @@ host_memory_backend_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "host-nodes",
         "Binds memory to the list of NUMA host nodes");
     object_class_property_add_enum(oc, "policy", "HostMemPolicy",
-                                   &HostMemPolicy_type_info, NULL,
+                                   &HostMemPolicy_type_info,
                                    host_memory_backend_get_policy,
                                    host_memory_backend_set_policy);
     object_class_property_set_description(oc, "policy",
diff --git a/crypto/secret_common.c b/crypto/secret_common.c
index 8e05f1365e..98898aa885 100644
--- a/crypto/secret_common.c
+++ b/crypto/secret_common.c
@@ -271,7 +271,7 @@ qcrypto_secret_class_init(ObjectClass *oc, const void *data)
     ucc->complete = qcrypto_secret_complete;
 
     object_class_property_add_enum(oc, "format", "QCryptoSecretFormat",
-                                   &QCryptoSecretFormat_type_info, NULL,
+                                   &QCryptoSecretFormat_type_info,
                                    qcrypto_secret_prop_get_format,
                                    qcrypto_secret_prop_set_format);
     object_class_property_add_str(oc, "keyid",
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index 021e4bf111..74d8d4fe00 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -223,7 +223,7 @@ qcrypto_tls_creds_class_init(ObjectClass *oc, const void *data)
                                   qcrypto_tls_creds_prop_get_dir,
                                   qcrypto_tls_creds_prop_set_dir);
     object_class_property_add_enum(oc, "endpoint", "QCryptoTLSCredsEndpoint",
-                                   &QCryptoTLSCredsEndpoint_type_info, NULL,
+                                   &QCryptoTLSCredsEndpoint_type_info,
                                    qcrypto_tls_creds_prop_get_endpoint,
                                    qcrypto_tls_creds_prop_set_endpoint);
     object_class_property_add_str(oc, "priority",
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 2f03679afd..57bd78479f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4202,8 +4202,8 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     mc->default_nic = "virtio-net-pci";
 
     object_class_property_add_enum(oc, "acpi", "OnOffAuto",
-                                   &OnOffAuto_type_info, NULL,
-                                   virt_get_acpi, virt_set_acpi);
+                                   &OnOffAuto_type_info, virt_get_acpi,
+                                   virt_set_acpi);
     object_class_property_set_description(oc, "acpi",
         "Enable ACPI");
     object_class_property_add_bool(oc, "secure", virt_get_secure,
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 7f010cb2f2..ed391c0596 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -658,25 +658,22 @@ static void microvm_class_init(ObjectClass *oc, const void *data)
     hc->unplug_request = microvm_device_unplug_request_cb;
     hc->unplug = microvm_device_unplug_cb;
 
-    object_class_property_add_enum(oc, MICROVM_MACHINE_RTC,
-                                   "OnOffAuto",
-                                   &OnOffAuto_type_info, NULL,
+    object_class_property_add_enum(oc, MICROVM_MACHINE_RTC, "OnOffAuto",
+                                   &OnOffAuto_type_info,
                                    microvm_machine_get_rtc,
                                    microvm_machine_set_rtc);
     object_class_property_set_description(oc, MICROVM_MACHINE_RTC,
         "Enable MC146818 RTC");
 
-    object_class_property_add_enum(oc, MICROVM_MACHINE_PCIE,
-                                   "OnOffAuto",
-                                   &OnOffAuto_type_info, NULL,
+    object_class_property_add_enum(oc, MICROVM_MACHINE_PCIE, "OnOffAuto",
+                                   &OnOffAuto_type_info,
                                    microvm_machine_get_pcie,
                                    microvm_machine_set_pcie);
     object_class_property_set_description(oc, MICROVM_MACHINE_PCIE,
         "Enable PCIe");
 
-    object_class_property_add_enum(oc, MICROVM_MACHINE_IOAPIC2,
-                                   "OnOffAuto",
-                                   &OnOffAuto_type_info, NULL,
+    object_class_property_add_enum(oc, MICROVM_MACHINE_IOAPIC2, "OnOffAuto",
+                                   &OnOffAuto_type_info,
                                    microvm_machine_get_ioapic2,
                                    microvm_machine_set_ioapic2);
     object_class_property_set_description(oc, MICROVM_MACHINE_IOAPIC2,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 80940e81e5..4737eb471c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1726,9 +1726,8 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, PC_MACHINE_MAX_RAM_BELOW_4G,
         "Maximum ram below the 4G boundary (32bit boundary)");
 
-    object_class_property_add_enum(oc, PC_MACHINE_VMPORT,
-                                   "OnOffAuto",
-                                   &OnOffAuto_type_info, NULL,
+    object_class_property_add_enum(oc, PC_MACHINE_VMPORT, "OnOffAuto",
+                                   &OnOffAuto_type_info,
                                    pc_machine_get_vmport,
                                    pc_machine_set_vmport);
     object_class_property_set_description(oc, PC_MACHINE_VMPORT,
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 20bd4231c1..211e3c5f9e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -389,9 +389,8 @@ static void pc_i440fx_machine_options(MachineClass *m)
 
     object_class_property_add_enum(oc, "x-south-bridge",
                                    "PCSouthBridgeOption",
-                                   &PCSouthBridgeOption_type_info, NULL,
-                                   pc_get_south_bridge,
-                                   pc_set_south_bridge);
+                                   &PCSouthBridgeOption_type_info,
+                                   pc_get_south_bridge, pc_set_south_bridge);
     object_class_property_set_description(oc, "x-south-bridge",
                                      "Use a different south bridge than PIIX3");
     compat_props_add(m->compat_props,
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 4e5a7cf270..4b75b7406a 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -373,29 +373,25 @@ static void x86_machine_class_init(ObjectClass *oc, const void *data)
     nc->raise_nmi = x86_nmi;
 
     object_class_property_add_enum(oc, X86_MACHINE_SMM, "OnOffAuto",
-                                   &OnOffAuto_type_info, NULL,
-                                   x86_machine_get_smm,
+                                   &OnOffAuto_type_info, x86_machine_get_smm,
                                    x86_machine_set_smm);
     object_class_property_set_description(oc, X86_MACHINE_SMM,
         "Enable SMM");
 
     object_class_property_add_enum(oc, X86_MACHINE_ACPI, "OnOffAuto",
-                                   &OnOffAuto_type_info, NULL,
-                                   x86_machine_get_acpi,
+                                   &OnOffAuto_type_info, x86_machine_get_acpi,
                                    x86_machine_set_acpi);
     object_class_property_set_description(oc, X86_MACHINE_ACPI,
         "Enable ACPI");
 
     object_class_property_add_enum(oc, X86_MACHINE_PIT, "OnOffAuto",
-                                   &OnOffAuto_type_info, NULL,
-                                   x86_machine_get_pit,
+                                   &OnOffAuto_type_info, x86_machine_get_pit,
                                    x86_machine_set_pit);
     object_class_property_set_description(oc, X86_MACHINE_PIT,
         "Enable i8254 PIT");
 
     object_class_property_add_enum(oc, X86_MACHINE_PIC, "OnOffAuto",
-                                   &OnOffAuto_type_info, NULL,
-                                   x86_machine_get_pic,
+                                   &OnOffAuto_type_info, x86_machine_get_pic,
                                    x86_machine_set_pic);
     object_class_property_set_description(oc, X86_MACHINE_PIC,
         "Enable i8259 PIC");
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 1eae2bffe6..598898e0fb 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1470,18 +1470,18 @@ static void virt_class_init(ObjectClass *oc, const void *data)
     hc->unplug = virt_device_unplug;
 
     object_class_property_add_enum(oc, "acpi", "OnOffAuto",
-                                        &OnOffAuto_type_info, NULL,
-                                        virt_get_acpi, virt_set_acpi);
+                                   &OnOffAuto_type_info, virt_get_acpi,
+                                   virt_set_acpi);
     object_class_property_set_description(oc, "acpi",
         "Enable ACPI");
     object_class_property_add_enum(oc, "v-eiointc", "OnOffAuto",
-                                   &OnOffAuto_type_info, NULL,
-                                   virt_get_veiointc, virt_set_veiointc);
+                                   &OnOffAuto_type_info, virt_get_veiointc,
+                                   virt_set_veiointc);
     object_class_property_set_description(oc, "v-eiointc",
                             "Enable Virt Extend I/O Interrupt Controller.");
-    object_class_property_add_enum(oc,  "dmsi", "OnOffAuto",
-                                   &OnOffAuto_type_info, NULL,
-                                   virt_get_dmsi, virt_set_dmsi);
+    object_class_property_add_enum(oc, "dmsi", "OnOffAuto",
+                                   &OnOffAuto_type_info, virt_get_dmsi,
+                                   virt_set_dmsi);
     object_class_property_set_description(oc, "dmsi",
                             "Enable direct Message-interrupts Controller.");
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index b52f12924d..4ad04801ce 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -176,7 +176,7 @@ static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc,
     mc->is_default = true;
 
     prop = object_class_property_add_enum(oc, "endianness", "EndianMode",
-                                          &EndianMode_type_info, NULL,
+                                          &EndianMode_type_info,
                                           machine_get_endianness,
                                           machine_set_endianness);
     object_property_set_default_str(prop, target_big_endian() ? "big"
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 31fecdc964..0cb731482a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1175,14 +1175,14 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     }
 
     object_class_property_add_enum(oc, "acpi", "OnOffAuto",
-                                   &OnOffAuto_type_info, NULL,
-                                   virt_get_acpi, virt_set_acpi);
+                                   &OnOffAuto_type_info, virt_get_acpi,
+                                   virt_set_acpi);
     object_class_property_set_description(oc, "acpi",
                                           "Enable ACPI");
 
-    object_class_property_add_enum(oc,  "iommu-sys", "OnOffAuto",
-                                   &OnOffAuto_type_info, NULL,
-                                   virt_get_iommu_sys, virt_set_iommu_sys);
+    object_class_property_add_enum(oc, "iommu-sys", "OnOffAuto",
+                                   &OnOffAuto_type_info, virt_get_iommu_sys,
+                                   virt_set_iommu_sys);
     object_class_property_set_description(oc, "iommu-sys",
                                           "Enable IOMMU platform device");
 }
diff --git a/monitor/qmp.c b/monitor/qmp.c
index c6341f1a20..d2e45d3993 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -136,7 +136,7 @@ static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
                                    monitor_qmp_set_pretty);
     object_class_property_add_enum(cls, "close-action",
                                    "MonitorQMPCloseAction",
-                                   &MonitorQMPCloseAction_type_info, NULL,
+                                   &MonitorQMPCloseAction_type_info,
                                    monitor_qmp_get_close_action,
                                    monitor_qmp_set_close_action);
 
diff --git a/net/filter.c b/net/filter.c
index 9013d872ea..145c72107a 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -344,8 +344,9 @@ static void netfilter_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_str(oc, "netdev",
                                   netfilter_get_netdev_id, netfilter_set_netdev_id);
     object_class_property_add_enum(oc, "queue", "NetFilterDirection",
-                                   &NetFilterDirection_type_info, NULL,
-                                   netfilter_get_direction, netfilter_set_direction);
+                                   &NetFilterDirection_type_info,
+                                   netfilter_get_direction,
+                                   netfilter_set_direction);
     object_class_property_add_str(oc, "status",
                                   netfilter_get_status, netfilter_set_status);
     object_class_property_add_str(oc, "position",
diff --git a/qom/object.c b/qom/object.c
index 637459c2b1..c285eb849f 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2501,8 +2501,7 @@ object_class_property_add_bool(ObjectClass *klass, const char *name,
 }
 
 typedef struct EnumProperty {
-    const QAPITypeInfo *qapi_type; /* non-null for QAPI enums */
-    const QEnumLookup *lookup;
+    const QAPITypeInfo *qapi_type;
     int (*get)(Object *, Error **);
     void (*set)(Object *, int, Error **);
 } EnumProperty;
@@ -2520,7 +2519,7 @@ static void property_get_enum(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    visit_type_enum(v, name, &value, prop->lookup, errp);
+    visit_type_enum(v, name, &value, prop->qapi_type->lookup, errp);
 }
 
 static void property_set_enum(Object *obj, Visitor *v, const char *name,
@@ -2529,7 +2528,7 @@ static void property_set_enum(Object *obj, Visitor *v, const char *name,
     EnumProperty *prop = opaque;
     int value;
 
-    if (!visit_type_enum(v, name, &value, prop->lookup, errp)) {
+    if (!visit_type_enum(v, name, &value, prop->qapi_type->lookup, errp)) {
         return;
     }
     prop->set(obj, value, errp);
@@ -2539,15 +2538,12 @@ ObjectProperty *
 object_property_add_enum(Object *obj, const char *name,
                          const char *typename,
                          const QAPITypeInfo *qapi_type,
-                         const QEnumLookup *lookup,
                          int (*get)(Object *, Error **),
                          void (*set)(Object *, int, Error **))
 {
     EnumProperty *prop = g_malloc(sizeof(*prop));
 
-    assert(!qapi_type != !lookup);
     prop->qapi_type = qapi_type;
-    prop->lookup = lookup ?: qapi_type->lookup;
     prop->get = get;
     prop->set = set;
 
@@ -2562,15 +2558,12 @@ ObjectProperty *
 object_class_property_add_enum(ObjectClass *klass, const char *name,
                                     const char *typename,
                                     const QAPITypeInfo *qapi_type,
-                                    const QEnumLookup *lookup,
                                     int (*get)(Object *, Error **),
                                     void (*set)(Object *, int, Error **))
 {
     EnumProperty *prop = g_malloc(sizeof(*prop));
 
-    assert(!qapi_type != !lookup);
     prop->qapi_type = qapi_type;
-    prop->lookup = lookup ?: qapi_type->lookup;
     prop->get = get;
     prop->set = set;
 
@@ -2607,7 +2600,7 @@ int object_property_get_enum(Object *obj, const char *name,
         return -1;
     }
 
-    ret = qapi_enum_parse(enumprop->lookup, str, -1, errp);
+    ret = qapi_enum_parse(enumprop->qapi_type->lookup, str, -1, errp);
     g_free(str);
 
     return ret;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e003e47c5b..64c9e2e379 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -7092,7 +7092,7 @@ static void kvm_arch_set_honor_guest_pat(Object *obj, int value, Error **errp)
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
     object_class_property_add_enum(oc, "notify-vmexit", "NotifyVMexitOption",
-                                   &NotifyVmexitOption_type_info, NULL,
+                                   &NotifyVmexitOption_type_info,
                                    kvm_arch_get_notify_vmexit,
                                    kvm_arch_set_notify_vmexit);
     object_class_property_set_description(oc, "notify-vmexit",
@@ -7132,7 +7132,7 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
                                           "Maximum number of Xen PIRQs");
 
     object_class_property_add_enum(oc, "honor-guest-pat", "OnOffAuto",
-                                   &OnOffAuto_type_info, NULL,
+                                   &OnOffAuto_type_info,
                                    kvm_arch_get_honor_guest_pat,
                                    kvm_arch_set_honor_guest_pat);
     object_class_property_set_description(oc, "honor-guest-pat",
diff --git a/target/i386/sev.c b/target/i386/sev.c
index c1c12d1125..604c2255ac 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -3019,7 +3019,7 @@ sev_guest_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "session-file",
             "guest owners session parameters (encoded with base64)");
     object_class_property_add_enum(oc, "legacy-vm-type", "OnOffAuto",
-                                   &OnOffAuto_type_info, NULL,
+                                   &OnOffAuto_type_info,
                                    sev_guest_get_legacy_vm_type,
                                    sev_guest_set_legacy_vm_type);
     object_class_property_set_description(oc, "legacy-vm-type",
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index c459138c7e..e3e672dcd1 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2974,17 +2974,16 @@ void whpx_arch_accel_class_init(ObjectClass *oc)
 {
     object_class_property_add_enum(oc, "ignore-unknown-msr", "OnOffAuto",
                                    &OnOffAuto_type_info, NULL,
-                                   NULL, whpx_set_unknown_msr);
+                                   whpx_set_unknown_msr);
     object_class_property_set_description(oc, "ignore-unknown-msr",
         "Configure unknown MSR behavior");
     object_class_property_add_enum(oc, "intercept-msr-gp", "OnOffAuto",
                                    &OnOffAuto_type_info, NULL,
-                                   NULL, whpx_set_intercept_msr_gp);
+                                   whpx_set_intercept_msr_gp);
     object_class_property_set_description(oc, "intercept-msr-gp",
         "Intercept #GP to log erroring MSR accesses.");
     object_class_property_add_enum(oc, "ssd", "OnOffAuto",
-                                   &OnOffAuto_type_info, NULL,
-                                   NULL, whpx_set_ssd);
+                                   &OnOffAuto_type_info, NULL, whpx_set_ssd);
     object_class_property_set_description(oc, "ssd",
         "Separate security domain");
 }
diff --git a/tests/unit/check-qom-proplist.c b/tests/unit/check-qom-proplist.c
index 246935d714..381a868a80 100644
--- a/tests/unit/check-qom-proplist.c
+++ b/tests/unit/check-qom-proplist.c
@@ -152,8 +152,7 @@ static void dummy_class_init(ObjectClass *cls, const void *data)
                               dummy_get_sv, dummy_set_sv,
                               NULL, NULL);
     object_class_property_add_enum(cls, "av", "DummyAnimal",
-                                   &dummy_animal_qapi_type_info, NULL,
-                                   dummy_get_av,
+                                   &dummy_animal_qapi_type_info, dummy_get_av,
                                    dummy_set_av);
 }
 
diff --git a/ui/dbus.c b/ui/dbus.c
index 9c21204771..f473a66889 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -511,8 +511,8 @@ dbus_display_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_str(oc, "addr", get_dbus_addr, set_dbus_addr);
     object_class_property_add_str(oc, "audiodev", get_audiodev, set_audiodev);
     object_class_property_add_enum(oc, "gl-mode", "DisplayGLMode",
-                                   &DisplayGLMode_type_info, NULL,
-                                   get_gl_mode, set_gl_mode);
+                                   &DisplayGLMode_type_info, get_gl_mode,
+                                   set_gl_mode);
 }
 
 #define TYPE_CHARDEV_VC "chardev-vc"
diff --git a/ui/input-linux.c b/ui/input-linux.c
index 127be74450..c7f9114036 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -508,7 +508,7 @@ static void input_linux_class_init(ObjectClass *oc, const void *data)
                                    input_linux_get_repeat,
                                    input_linux_set_repeat);
     object_class_property_add_enum(oc, "grab-toggle", "GrabToggleKeys",
-                                   &GrabToggleKeys_type_info, NULL,
+                                   &GrabToggleKeys_type_info,
                                    input_linux_get_grab_toggle,
                                    input_linux_set_grab_toggle);
 }
-- 
2.55.0


