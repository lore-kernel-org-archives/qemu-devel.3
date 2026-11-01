Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BB7606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gbczNPkF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNc1y-00084k-PJ; Sun, 01 Nov 2026 15:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzx-000577-Nn
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzi-0007EU-7h
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793564252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2uvdeGskkqU565zwgVPASejQLcudocykzaM6kW4Oxc=;
 b=gbczNPkFf7xZESWOZwKTaO7A1HGXl/HaAeQeLOD5wpfA1VbZubKkkScYkcApZCcjxw/5kI
 lTi8OrpWbi05Ksv+DiNdgwwpqOpnRBpuQAwHJ89u4FgeX8Nmf6WWixSfB9KY+uyuF9FhuL
 nqJnX4dIwL+F2zBw2m03CI1EBkm6+rY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-Yyx8iPj0O1Wg3RxIggnz3Q-1; Sun,
 01 Nov 2026 15:17:30 -0500
X-MC-Unique: Yyx8iPj0O1Wg3RxIggnz3Q-1
X-Mimecast-MFC-AGG-ID: Yyx8iPj0O1Wg3RxIggnz3Q_1793564249
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 845621955F6E; Sun,  1 Nov 2026 20:17:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F5B81800495; Sun,  1 Nov 2026 20:17:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 43DA121E681E; Sun, 01 Nov 2026 21:17:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PATCH v8 36/56] qom: convert scalar properties to QAPI-aware
 registration
Date: Sun,  1 Nov 2026 21:16:57 +0100
Message-ID: <20261101201717.3911097-37-armbru@redhat.com>
In-Reply-To: <20261101201717.3911097-1-armbru@redhat.com>
References: <20261101201717.3911097-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Pass appropriate QAPITypeInfo to object_class_property_add() and
object_property_add().

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 accel/kvm/kvm-all.c                 |  9 ++++----
 accel/nitro/nitro-accel.c           |  4 +++-
 accel/tcg/tcg-all.c                 |  3 ++-
 backends/cryptodev.c                |  7 +++---
 backends/hostmem-file.c             |  4 ++--
 backends/hostmem-memfd.c            |  4 +++-
 backends/hostmem.c                  |  7 +++---
 block/throttle-groups.c             |  4 +++-
 crypto/secret_keyring.c             |  9 ++++----
 event-loop-base.c                   | 10 +++++---
 hw/acpi/ich9.c                      |  4 +++-
 hw/acpi/pci.c                       |  5 ++--
 hw/arm/virt.c                       | 18 ++++++++-------
 hw/core/clock.c                     |  4 +++-
 hw/core/machine.c                   |  2 +-
 hw/cpu/core.c                       |  5 ++--
 hw/cxl/cxl-host.c                   |  2 +-
 hw/gpio/aspeed_gpio.c               |  7 ++++--
 hw/gpio/aspeed_sgpio.c              |  4 +++-
 hw/gpio/stm32l4x5_gpio.c            |  5 ++--
 hw/hexagon/hexagon_dsp.c            |  4 +++-
 hw/i386/pc.c                        |  9 +++++---
 hw/i386/sgx-epc.c                   |  4 +++-
 hw/i386/x86.c                       |  6 ++---
 hw/ide/ide-dev.c                    |  3 ++-
 hw/intc/apic_common.c               |  3 ++-
 hw/loongarch/virt.c                 |  8 +++----
 hw/mem/nvdimm.c                     |  3 ++-
 hw/mem/pc-dimm.c                    |  3 ++-
 hw/misc/aspeed_lpc.c                | 25 ++++++++++----------
 hw/misc/aspeed_sdmc.c               |  3 ++-
 hw/misc/npcm7xx_mft.c               |  3 ++-
 hw/net/ne2000-isa.c                 |  3 ++-
 hw/nvme/ctrl.c                      |  4 +++-
 hw/pci-bridge/pci_expander_bridge.c |  3 ++-
 hw/pci-host/i440fx.c                |  9 ++++----
 hw/pci-host/pnv_phb3.c              |  5 ++--
 hw/pci-host/pnv_phb4.c              |  5 ++--
 hw/pci-host/q35.c                   | 13 +++++++----
 hw/ppc/spapr_drc.c                  |  5 ++--
 hw/remote/vfio-user-obj.c           |  4 ++--
 hw/riscv/microchip_pfsoc.c          |  3 ++-
 hw/s390x/sclpcpi.c                  |  6 +++--
 hw/s390x/virtio-ccw-mem.c           |  4 +++-
 hw/sensor/adc128d818.c              |  8 ++++---
 hw/sensor/adm1266.c                 |  3 ++-
 hw/sensor/adm1272.c                 |  9 ++++----
 hw/sensor/emc141x.c                 |  9 ++++----
 hw/sensor/isl_pmbus_vr.c            | 19 +++++++--------
 hw/sensor/lsm303dlhc_mag.c          |  9 ++++----
 hw/sensor/max34451.c                |  5 ++--
 hw/sensor/tmp105.c                  |  3 ++-
 hw/sensor/tmp421.c                  |  9 ++++----
 hw/usb/dev-storage-classic.c        |  3 ++-
 hw/virtio/virtio-balloon.c          |  4 +++-
 hw/virtio/virtio-mem-pci.c          |  4 +++-
 hw/virtio/virtio-mem.c              | 10 +++++---
 hw/xen/xen-pvh-common.c             | 13 +++++++----
 iothread.c                          |  9 ++++----
 net/colo-compare.c                  |  7 +++---
 net/dump.c                          |  3 ++-
 net/filter-buffer.c                 |  3 ++-
 qom/object.c                        | 36 ++++++++++++++---------------
 system/bootdevice.c                 |  3 ++-
 system/memory.c                     |  5 ++--
 target/arm/cpu64.c                  | 16 +++++++++----
 target/arm/kvm.c                    |  3 ++-
 target/arm/tcg/cpu64.c              |  6 +++--
 target/i386/cpu.c                   | 13 ++++++-----
 target/i386/kvm/kvm.c               | 10 ++++----
 target/i386/sev.c                   |  7 +++---
 target/ppc/compat.c                 |  3 ++-
 target/riscv/cpu.c                  | 19 ++++++++++-----
 target/riscv/kvm/kvm-cpu.c          |  7 +++---
 target/riscv/tcg/tcg-cpu.c          |  7 +++---
 target/s390x/cpu_models.c           |  6 +++--
 tests/unit/test-qdev-global-props.c |  9 ++++----
 ui/console.c                        |  3 ++-
 util/thread-context.c               | 10 +++++---
 79 files changed, 335 insertions(+), 213 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index fe11cd92b4..dcb1db139d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -24,6 +24,7 @@
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/s390x/adapter.h"
@@ -4302,15 +4303,15 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "kernel-irqchip",
         "Configure KVM in-kernel irqchip");
 
-    object_class_property_add(oc, "kvm-shadow-mem", "int", NULL,
+    object_class_property_add(oc, "kvm-shadow-mem", "int", &int_type_info,
                               kvm_get_kvm_shadow_mem, kvm_set_kvm_shadow_mem,
                               NULL, NULL);
     object_class_property_set_description(oc, "kvm-shadow-mem",
         "KVM shadow MMU size");
 
-    object_class_property_add(oc, "dirty-ring-size", "uint32", NULL,
-                              kvm_get_dirty_ring_size,
-                              kvm_set_dirty_ring_size,
+    object_class_property_add(oc, "dirty-ring-size", "uint32",
+                              &uint32_type_info,
+                              kvm_get_dirty_ring_size, kvm_set_dirty_ring_size,
                               NULL, NULL);
     object_class_property_set_description(oc, "dirty-ring-size",
         "Size of KVM dirty page ring buffer (default: 0, i.e. use bitmap)");
diff --git a/accel/nitro/nitro-accel.c b/accel/nitro/nitro-accel.c
index 597027438c..9c07483be3 100644
--- a/accel/nitro/nitro-accel.c
+++ b/accel/nitro/nitro-accel.c
@@ -29,6 +29,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
 #include "qemu/rcu.h"
@@ -238,7 +239,8 @@ static void nitro_accel_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "debug-mode",
         "Start enclave in debug mode (enables console output)");
 
-    object_class_property_add(oc, "enclave-cid", "uint64", NULL,
+    object_class_property_add(oc, "enclave-cid", "uint64",
+                              &uint64_type_info,
                               nitro_get_enclave_cid,
                               nitro_set_enclave_cid,
                               NULL, NULL);
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index ed314e01cb..bbc733a707 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -29,6 +29,7 @@
 #include "exec/icount.h"
 #include "tcg/startup.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qemu/error-report.h"
 #include "qemu/accel.h"
 #include "qemu/atomic.h"
@@ -270,7 +271,7 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
                                   tcg_get_thread,
                                   tcg_set_thread);
 
-    object_class_property_add(oc, "tb-size", "uint32", NULL,
+    object_class_property_add(oc, "tb-size", "uint32", &uint32_type_info,
                               tcg_get_tb_size, tcg_set_tb_size,
                               NULL, NULL);
     object_class_property_set_description(oc, "tb-size",
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index cc323014cc..46059faa26 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -25,6 +25,7 @@
 #include "system/cryptodev.h"
 #include "system/stats.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-commands-cryptodev.h"
 #include "qapi/qapi-types-stats.h"
 #include "qapi/visitor.h"
@@ -622,15 +623,15 @@ cryptodev_backend_class_init(ObjectClass *oc, const void *data)
     ucc->prepare_delete = cryptodev_backend_prepare_delete;
 
     QTAILQ_INIT(&crypto_clients);
-    object_class_property_add(oc, "queues", "uint32", NULL,
+    object_class_property_add(oc, "queues", "uint32", &uint32_type_info,
                               cryptodev_backend_get_queues,
                               cryptodev_backend_set_queues,
                               NULL, NULL);
-    object_class_property_add(oc, "throttle-bps", "uint64", NULL,
+    object_class_property_add(oc, "throttle-bps", "uint64", &uint64_type_info,
                               cryptodev_backend_get_bps,
                               cryptodev_backend_set_bps,
                               NULL, NULL);
-    object_class_property_add(oc, "throttle-ops", "uint64", NULL,
+    object_class_property_add(oc, "throttle-ops", "uint64", &uint64_type_info,
                               cryptodev_backend_get_ops,
                               cryptodev_backend_set_ops,
                               NULL, NULL);
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 15b5fee246..2f65ca3678 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -275,11 +275,11 @@ file_backend_class_init(ObjectClass *oc, const void *data)
         file_memory_backend_get_discard_data, file_memory_backend_set_discard_data);
     object_class_property_add_str(oc, "mem-path",
         get_mem_path, set_mem_path);
-    object_class_property_add(oc, "align", "uint64", NULL,
+    object_class_property_add(oc, "align", "uint64", &uint64_type_info,
                               file_memory_backend_get_align,
                               file_memory_backend_set_align,
                               NULL, NULL);
-    object_class_property_add(oc, "offset", "int", NULL,
+    object_class_property_add(oc, "offset", "int", &int_type_info,
                               file_memory_backend_get_offset,
                               file_memory_backend_set_offset,
                               NULL, NULL);
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 4e1b23a1d6..19a9a5b409 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -16,6 +16,7 @@
 #include "qemu/memfd.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qom/object.h"
 #include "migration/cpr.h"
 #include "system/kvm.h"
@@ -191,7 +192,8 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
                                        memfd_backend_set_hugetlb);
         object_class_property_set_description(oc, "hugetlb",
                                               "Use huge pages");
-        object_class_property_add(oc, "hugetlbsize", "uint64", NULL,
+        object_class_property_add(oc, "hugetlbsize", "uint64",
+                                  &uint64_type_info,
                                   memfd_backend_get_hugetlbsize,
                                   memfd_backend_set_hugetlbsize,
                                   NULL, NULL);
diff --git a/backends/hostmem.c b/backends/hostmem.c
index b43d6ca956..0f39f4d1b7 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -529,7 +529,7 @@ host_memory_backend_class_init(ObjectClass *oc, const void *data)
         host_memory_backend_set_prealloc);
     object_class_property_set_description(oc, "prealloc",
         "Preallocate memory");
-    object_class_property_add(oc, "prealloc-threads", "int", NULL,
+    object_class_property_add(oc, "prealloc-threads", "int", &int_type_info,
                               host_memory_backend_get_prealloc_threads,
                               host_memory_backend_set_prealloc_threads,
                               NULL, NULL);
@@ -540,13 +540,14 @@ host_memory_backend_class_init(ObjectClass *oc, const void *data)
         object_property_allow_set_link, OBJ_PROP_LINK_STRONG);
     object_class_property_set_description(oc, "prealloc-context",
         "Context to use for creating CPU threads for preallocation");
-    object_class_property_add(oc, "size", "size", NULL,
+    object_class_property_add(oc, "size", "size", &size_type_info,
                               host_memory_backend_get_size,
                               host_memory_backend_set_size,
                               NULL, NULL);
     object_class_property_set_description(oc, "size",
         "Size of the memory region (ex: 500M)");
-    object_class_property_add(oc, "host-nodes", "[uint16]", NULL,
+    object_class_property_add(oc, "host-nodes", "[uint16]",
+                              &uint16List_type_info,
                               host_memory_backend_get_host_nodes,
                               host_memory_backend_set_host_nodes,
                               NULL, NULL);
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 5d6b089092..40a49e6233 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -31,6 +31,7 @@
 #include "qemu/thread.h"
 #include "system/qtest.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-type-infos-block-core.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "qom/object.h"
@@ -985,7 +986,8 @@ static void throttle_group_obj_class_init(ObjectClass *klass,
 
     /* individual properties */
     for (i = 0; i < sizeof(properties) / sizeof(ThrottleParamInfo); i++) {
-        object_class_property_add(klass, properties[i].name, "int64", NULL,
+        object_class_property_add(klass, properties[i].name, "int64",
+                                  &int64_type_info,
                                   throttle_group_get,
                                   throttle_group_set,
                                   NULL, &properties[i]);
diff --git a/crypto/secret_keyring.c b/crypto/secret_keyring.c
index e9cb222bf8..aa9c45f141 100644
--- a/crypto/secret_keyring.c
+++ b/crypto/secret_keyring.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include <asm/unistd.h>
 #include <linux/keyctl.h>
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
 #include "trace.h"
@@ -107,10 +108,10 @@ qcrypto_secret_keyring_class_init(ObjectClass *oc, const void *data)
     QCryptoSecretCommonClass *sic = QCRYPTO_SECRET_COMMON_CLASS(oc);
     sic->load_data = qcrypto_secret_keyring_load_data;
 
-    object_class_property_add(oc, "serial", "int32_t", NULL,
-                                  qcrypto_secret_prop_get_key,
-                                  qcrypto_secret_prop_set_key,
-                                  NULL, NULL);
+    object_class_property_add(oc, "serial", "int32_t", &int32_type_info,
+                              qcrypto_secret_prop_get_key,
+                              qcrypto_secret_prop_set_key,
+                              NULL, NULL);
 }
 
 
diff --git a/event-loop-base.c b/event-loop-base.c
index 42bf09d58b..e4a57c6190 100644
--- a/event-loop-base.c
+++ b/event-loop-base.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qom/object_interfaces.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "block/thread-pool.h"
 #include "system/event-loop-base.h"
 
@@ -104,15 +105,18 @@ static void event_loop_base_class_init(ObjectClass *klass,
     ucc->complete = event_loop_base_complete;
     ucc->prepare_delete = event_loop_base_prepare_delete;
 
-    object_class_property_add(klass, "aio-max-batch", "int64", NULL,
+    object_class_property_add(klass, "aio-max-batch", "int64",
+                              &int64_type_info,
                               event_loop_base_get_param,
                               event_loop_base_set_param,
                               NULL, &aio_max_batch_info);
-    object_class_property_add(klass, "thread-pool-min", "int64", NULL,
+    object_class_property_add(klass, "thread-pool-min", "int64",
+                              &int64_type_info,
                               event_loop_base_get_param,
                               event_loop_base_set_param,
                               NULL, &thread_pool_min_info);
-    object_class_property_add(klass, "thread-pool-max", "int64", NULL,
+    object_class_property_add(klass, "thread-pool-max", "int64",
+                              &int64_type_info,
                               event_loop_base_get_param,
                               event_loop_base_set_param,
                               NULL, &thread_pool_max_info);
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index f3e248c8da..91a22a8e94 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -26,6 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
@@ -379,7 +380,8 @@ void ich9_pm_add_class_properties(ObjectClass *oc, ptrdiff_t pm_offset)
                                    PM_REG_FIELD(acpi_pci_hotplug.root),
                                    object_property_allow_set_link,
                                    OBJ_PROP_LINK_STRONG);
-    object_class_property_add(oc, ACPI_PM_PROP_GPE0_BLK, "uint32", NULL,
+    object_class_property_add(oc, ACPI_PM_PROP_GPE0_BLK, "uint32",
+                              &uint32_type_info,
                               ich9_pm_get_gpe0_blk,
                               NULL, NULL, NULL);
     object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S3_DISABLED,
diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index abd1071f49..d393638d2e 100644
--- a/hw/acpi/pci.c
+++ b/hw/acpi/pci.c
@@ -27,6 +27,7 @@
 #include "qemu/error-report.h"
 #include "qom/object_interfaces.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "hw/core/boards.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/pci.h"
@@ -139,7 +140,7 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, const void *data)
         acpi_generic_initiator_set_pci_device);
     object_class_property_set_description(oc, "pci-dev",
         "PCI device to associate with the node");
-    object_class_property_add(oc, "node", "uint32", NULL, NULL,
+    object_class_property_add(oc, "node", "uint32", &uint32_type_info, NULL,
                               acpi_generic_initiator_set_node, NULL, NULL);
     object_class_property_set_description(oc, "node",
         "NUMA node associated with the PCI device");
@@ -253,7 +254,7 @@ static void acpi_generic_port_class_init(ObjectClass *oc, const void *data)
         acpi_generic_port_set_pci_bus);
     object_class_property_set_description(oc, "pci-bus",
        "PCI Bus of the host bridge associated with this GP affinity structure");
-    object_class_property_add(oc, "node", "uint32", NULL, NULL,
+    object_class_property_add(oc, "node", "uint32", &uint32_type_info, NULL,
                               acpi_generic_port_set_node, NULL, NULL);
     object_class_property_set_description(oc, "node",
        "The NUMA node like ID to index HMAT/SLIT NUMA properties involving GP");
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e39d77eba6..2f03679afd 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4254,18 +4254,20 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set on/off to enable/disable high "
                                           "memory region for PCI MMIO");
 
-    object_class_property_add(oc, "highmem-mmio-size", "size", NULL,
-                                   virt_get_highmem_mmio_size,
-                                   virt_set_highmem_mmio_size,
-                                   NULL, NULL);
+    object_class_property_add(oc, "highmem-mmio-size", "size",
+                              &size_type_info,
+                              virt_get_highmem_mmio_size,
+                              virt_set_highmem_mmio_size,
+                              NULL, NULL);
     object_class_property_set_description(oc, "highmem-mmio-size",
                                           "Set the high memory region size "
                                           "for PCI MMIO");
 
-    object_class_property_add(oc, "virtio-mmio-transports", "uint8", NULL,
-                                   virt_get_virtio_transports,
-                                   virt_set_virtio_transports,
-                                   NULL, NULL);
+    object_class_property_add(oc, "virtio-mmio-transports", "uint8",
+                              &uint8_type_info,
+                              virt_get_virtio_transports,
+                              virt_set_virtio_transports,
+                              NULL, NULL);
     object_class_property_set_description(oc, "virtio-mmio-transports",
                                           "Set the number of virtio-mmio transports to instantiate");
 
diff --git a/hw/core/clock.c b/hw/core/clock.c
index d46c888f5c..f927354923 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "system/qtest.h"
 #include "hw/core/clock.h"
@@ -185,7 +186,8 @@ static void clock_initfn(Object *obj)
     QLIST_INIT(&clk->children);
 
     if (qtest_enabled()) {
-        object_property_add(obj, "qtest-clock-period", "uint64", NULL,
+        object_property_add(obj, "qtest-clock-period", "uint64",
+                            &uint64_type_info,
                             clock_period_prop_get, NULL, NULL, NULL);
     }
 }
diff --git a/hw/core/machine.c b/hw/core/machine.c
index bc03a62883..0574e4326f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1140,7 +1140,7 @@ static void machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "smp-cache",
         "Cache properties list for SMP machine");
 
-    object_class_property_add(oc, "phandle-start", "int", NULL,
+    object_class_property_add(oc, "phandle-start", "int", &int_type_info,
                               machine_get_phandle_start,
                               machine_set_phandle_start,
                               NULL, NULL);
diff --git a/hw/cpu/core.c b/hw/cpu/core.c
index f430befad8..5fae05ae37 100644
--- a/hw/cpu/core.c
+++ b/hw/cpu/core.c
@@ -12,6 +12,7 @@
 #include "hw/core/boards.h"
 #include "hw/cpu/core.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 
 static void core_prop_get_core_id(Object *obj, Visitor *v, const char *name,
@@ -82,10 +83,10 @@ static void cpu_core_class_init(ObjectClass *oc, const void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     set_bit(DEVICE_CATEGORY_CPU, dc->categories);
-    object_class_property_add(oc, "core-id", "int", NULL,
+    object_class_property_add(oc, "core-id", "int", &int_type_info,
                               core_prop_get_core_id,
                               core_prop_set_core_id, NULL, NULL);
-    object_class_property_add(oc, "nr-threads", "int", NULL,
+    object_class_property_add(oc, "nr-threads", "int", &int_type_info,
                               core_prop_get_nr_threads,
                               core_prop_set_nr_threads, NULL, NULL);
 }
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index ef7f766847..3bafda0904 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -611,7 +611,7 @@ static void machine_set_cfmw(Object *obj, Visitor *v, const char *name,
 
 void cxl_machine_init(Object *obj, CXLState *state)
 {
-    object_property_add(obj, "cxl", "bool", NULL, machine_get_cxl,
+    object_property_add(obj, "cxl", "bool", &bool_type_info, machine_get_cxl,
                         machine_set_cxl, NULL, state);
     object_property_set_description(obj, "cxl",
                                     "Set on/off to enable/disable "
diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index 4463cf7c9f..f95fe0d82a 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -12,6 +12,7 @@
 #include "hw/gpio/aspeed_gpio.h"
 #include "hw/misc/aspeed_scu.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
@@ -1481,7 +1482,8 @@ static void aspeed_gpio_init(Object *obj)
             int pin_idx = j % GPIOS_PER_GROUP;
             const char *group = &props->group_label[group_idx][0];
             char *name = g_strdup_printf("gpio%s%d", group, pin_idx);
-            object_property_add(obj, name, "bool", NULL, aspeed_gpio_get_pin,
+            object_property_add(obj, name, "bool", &bool_type_info,
+                                aspeed_gpio_get_pin,
                                 aspeed_gpio_set_pin, NULL, NULL);
             g_free(name);
         }
@@ -1489,7 +1491,8 @@ static void aspeed_gpio_init(Object *obj)
 
     for (int i = 0; i < agc->nr_gpio_sets; i++) {
         g_autofree char *name = g_strdup_printf("gpio-set[%d]", i);
-        object_property_add(obj, name, "uint32", NULL, aspeed_gpio_get_set,
+        object_property_add(obj, name, "uint32", &uint32_type_info,
+                            aspeed_gpio_get_set,
                             aspeed_gpio_set_set, NULL, NULL);
     }
 }
diff --git a/hw/gpio/aspeed_sgpio.c b/hw/gpio/aspeed_sgpio.c
index aeaef4f102..6263d126ee 100644
--- a/hw/gpio/aspeed_sgpio.c
+++ b/hw/gpio/aspeed_sgpio.c
@@ -11,6 +11,7 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
@@ -300,7 +301,8 @@ static void aspeed_sgpio_init(Object *obj)
 {
     for (int i = 0; i < ASPEED_SGPIO_MAX_PIN_PAIR * 2; i++) {
         g_autofree char *name = g_strdup_printf("sgpio%03d", i);
-        object_property_add(obj, name, "bool", NULL, aspeed_sgpio_get_pin,
+        object_property_add(obj, name, "bool", &bool_type_info,
+                            aspeed_sgpio_get_pin,
                             aspeed_sgpio_set_pin, NULL, NULL);
     }
 }
diff --git a/hw/gpio/stm32l4x5_gpio.c b/hw/gpio/stm32l4x5_gpio.c
index a31999323a..e3e5bc46e7 100644
--- a/hw/gpio/stm32l4x5_gpio.c
+++ b/hw/gpio/stm32l4x5_gpio.c
@@ -25,6 +25,7 @@
 #include "hw/core/qdev-properties.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 
@@ -409,10 +410,10 @@ static void stm32l4x5_gpio_init(Object *obj)
 
     s->clk = qdev_init_clock_in(DEVICE(s), "clk", NULL, s, 0);
 
-    object_property_add(obj, "disconnected-pins", "uint16", NULL,
+    object_property_add(obj, "disconnected-pins", "uint16", &uint16_type_info,
                         disconnected_pins_get, disconnected_pins_set,
                         NULL, &s->disconnected_pins);
-    object_property_add(obj, "clock-freq-hz", "uint32", NULL,
+    object_property_add(obj, "clock-freq-hz", "uint32", &uint32_type_info,
                         clock_freq_get, NULL, NULL, NULL);
 }
 
diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
index abccf10c00..eddf69545e 100644
--- a/hw/hexagon/hexagon_dsp.c
+++ b/hw/hexagon/hexagon_dsp.c
@@ -17,6 +17,7 @@
 #include "hw/hexagon/hex-subsys.h"
 #include "hw/core/loader.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
@@ -153,7 +154,8 @@ static void hexagon_sim_set_subsystem_base(Object *obj, Visitor *v,
 
 static void add_dsp_properties(ObjectClass *oc)
 {
-    object_class_property_add(oc, "subsystem-base", "uint32", NULL,
+    object_class_property_add(oc, "subsystem-base", "uint32",
+                              &uint32_type_info,
                               hexagon_sim_get_subsystem_base,
                               hexagon_sim_set_subsystem_base, NULL, NULL);
     object_class_property_set_description(oc, "subsystem-base",
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 649ae27156..80940e81e5 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1718,7 +1718,8 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_id = "pc.ram";
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_AUTO;
 
-    object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size", NULL,
+    object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
+                              &size_type_info,
                               pc_machine_get_max_ram_below_4g,
                               pc_machine_set_max_ram_below_4g,
                               NULL, NULL);
@@ -1757,14 +1758,16 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
         pc_machine_get_default_bus_bypass_iommu,
         pc_machine_set_default_bus_bypass_iommu);
 
-    object_class_property_add(oc, PC_MACHINE_MAX_FW_SIZE, "size", NULL,
+    object_class_property_add(oc, PC_MACHINE_MAX_FW_SIZE, "size",
+                              &size_type_info,
                               pc_machine_get_max_fw_size,
                               pc_machine_set_max_fw_size,
                               NULL, NULL);
     object_class_property_set_description(oc, PC_MACHINE_MAX_FW_SIZE,
         "Maximum combined firmware size");
 
-    object_class_property_add(oc, PC_MACHINE_SMBIOS_EP, "str", NULL,
+    object_class_property_add(oc, PC_MACHINE_SMBIOS_EP, "str",
+                              &str_type_info,
                               pc_machine_get_smbios_ep,
                               pc_machine_set_smbios_ep,
                               NULL, NULL);
diff --git a/hw/i386/sgx-epc.c b/hw/i386/sgx-epc.c
index a1b55c2ec3..e5fc90db9e 100644
--- a/hw/i386/sgx-epc.c
+++ b/hw/i386/sgx-epc.c
@@ -15,6 +15,7 @@
 #include "hw/mem/memory-device.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "target/i386/cpu.h"
 #include "system/address-spaces.h"
@@ -159,7 +160,8 @@ static void sgx_epc_class_init(ObjectClass *oc, const void *data)
     mdc->get_memory_region = sgx_epc_md_get_memory_region;
     mdc->fill_device_info = sgx_epc_md_fill_device_info;
 
-    object_class_property_add(oc, SGX_EPC_SIZE_PROP, "uint64", NULL,
+    object_class_property_add(oc, SGX_EPC_SIZE_PROP, "uint64",
+                              &uint64_type_info,
                               sgx_epc_get_size,
                               NULL,
                               NULL, NULL);
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 3416df13ab..b490c4e715 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -417,9 +417,9 @@ static void x86_machine_class_init(ObjectClass *oc, const void *data)
                                           "The string may be up to 8 bytes in size");
 
     object_class_property_add(oc, X86_MACHINE_BUS_LOCK_RATELIMIT, "uint64_t",
-                                NULL,
-                                x86_machine_get_bus_lock_ratelimit,
-                                x86_machine_set_bus_lock_ratelimit, NULL, NULL);
+                              &uint64_type_info,
+                              x86_machine_get_bus_lock_ratelimit,
+                              x86_machine_set_bus_lock_ratelimit, NULL, NULL);
     object_class_property_set_description(oc, X86_MACHINE_BUS_LOCK_RATELIMIT,
             "Set the ratelimit for the bus locks acquired in VMs");
 
diff --git a/hw/ide/ide-dev.c b/hw/ide/ide-dev.c
index 7bb06088a5..94b9147892 100644
--- a/hw/ide/ide-dev.c
+++ b/hw/ide/ide-dev.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-types-block.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
@@ -174,7 +175,7 @@ out:
 
 static void ide_dev_instance_init(Object *obj)
 {
-    object_property_add(obj, "bootindex", "int32", NULL,
+    object_property_add(obj, "bootindex", "int32", &int32_type_info,
                         ide_dev_get_bootindex,
                         ide_dev_set_bootindex, NULL, NULL);
     object_property_set_int(obj, "bootindex", -1, NULL);
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index ee5f6cb4c3..eab75dd169 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -22,6 +22,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "hw/i386/apic.h"
 #include "hw/i386/apic_internal.h"
@@ -442,7 +443,7 @@ static void apic_common_initfn(Object *obj)
     APICCommonState *s = APIC_COMMON(obj);
 
     s->id = s->initial_apic_id = -1;
-    object_property_add(obj, "id", "uint32", NULL,
+    object_property_add(obj, "id", "uint32", &uint32_type_info,
                         apic_common_get_id,
                         apic_common_set_id, NULL, NULL);
 }
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 1e1271ce87..1eae2bffe6 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1512,10 +1512,10 @@ static void virt_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "highmem-mmio",
                                           "Set on/off to enable/disable high "
                                           "memory region for PCI MMIO");
-    object_class_property_add(oc, "highmem-mmio-size", "size", NULL,
-                                   virt_get_highmem_mmio_size,
-                                   virt_set_highmem_mmio_size,
-                                   NULL, NULL);
+    object_class_property_add(oc, "highmem-mmio-size", "size", &size_type_info,
+                              virt_get_highmem_mmio_size,
+                              virt_set_highmem_mmio_size,
+                              NULL, NULL);
     object_class_property_set_description(oc, "highmem-mmio-size",
                                           "Set the high memory region size "
                                           "for PCI MMIO");
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 8d6e8d0bd9..04e8361348 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -26,6 +26,7 @@
 #include "qemu/module.h"
 #include "qemu/pmem.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/core/qdev-properties.h"
@@ -99,7 +100,7 @@ static void nvdimm_set_uuid(Object *obj, Visitor *v, const char *name,
 
 static void nvdimm_init(Object *obj)
 {
-    object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "size", NULL,
+    object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "size", &size_type_info,
                         nvdimm_get_label_size, nvdimm_set_label_size, NULL,
                         NULL);
 
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 7250146c10..e9b872450a 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -26,6 +26,7 @@
 #include "hw/mem/nvdimm.h"
 #include "hw/mem/memory-device.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
 #include "system/hostmem.h"
@@ -176,7 +177,7 @@ static void pc_dimm_get_size(Object *obj, Visitor *v, const char *name,
 
 static void pc_dimm_init(Object *obj)
 {
-    object_property_add(obj, PC_DIMM_SIZE_PROP, "uint64", NULL,
+    object_property_add(obj, PC_DIMM_SIZE_PROP, "uint64", &uint64_type_info,
                         pc_dimm_get_size,
                         NULL, NULL, NULL);
 }
diff --git a/hw/misc/aspeed_lpc.c b/hw/misc/aspeed_lpc.c
index a73df07332..ef320875cc 100644
--- a/hw/misc/aspeed_lpc.c
+++ b/hw/misc/aspeed_lpc.c
@@ -12,6 +12,7 @@
 #include "qemu/error-report.h"
 #include "hw/misc/aspeed_lpc.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
@@ -417,40 +418,40 @@ static void aspeed_lpc_realize(DeviceState *dev, Error **errp)
 
 static void aspeed_lpc_init(Object *obj)
 {
-    object_property_add(obj, "idr1", "uint32", NULL,
+    object_property_add(obj, "idr1", "uint32", &uint32_type_info,
                         aspeed_kcs_get_register_property,
                         aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "odr1", "uint32", NULL,
+    object_property_add(obj, "odr1", "uint32", &uint32_type_info,
                         aspeed_kcs_get_register_property,
                         aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "str1", "uint32", NULL,
+    object_property_add(obj, "str1", "uint32", &uint32_type_info,
                         aspeed_kcs_get_register_property,
                         aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "idr2", "uint32", NULL,
+    object_property_add(obj, "idr2", "uint32", &uint32_type_info,
                         aspeed_kcs_get_register_property,
                         aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "odr2", "uint32", NULL,
+    object_property_add(obj, "odr2", "uint32", &uint32_type_info,
                         aspeed_kcs_get_register_property,
                         aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "str2", "uint32", NULL,
+    object_property_add(obj, "str2", "uint32", &uint32_type_info,
                         aspeed_kcs_get_register_property,
                         aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "idr3", "uint32", NULL,
+    object_property_add(obj, "idr3", "uint32", &uint32_type_info,
                         aspeed_kcs_get_register_property,
                         aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "odr3", "uint32", NULL,
+    object_property_add(obj, "odr3", "uint32", &uint32_type_info,
                         aspeed_kcs_get_register_property,
                         aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "str3", "uint32", NULL,
+    object_property_add(obj, "str3", "uint32", &uint32_type_info,
                         aspeed_kcs_get_register_property,
                         aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "idr4", "uint32", NULL,
+    object_property_add(obj, "idr4", "uint32", &uint32_type_info,
                         aspeed_kcs_get_register_property,
                         aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "odr4", "uint32", NULL,
+    object_property_add(obj, "odr4", "uint32", &uint32_type_info,
                         aspeed_kcs_get_register_property,
                         aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "str4", "uint32", NULL,
+    object_property_add(obj, "str4", "uint32", &uint32_type_info,
                         aspeed_kcs_get_register_property,
                         aspeed_kcs_set_register_property, NULL, NULL);
 }
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 427816b838..412aa17d2e 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -15,6 +15,7 @@
 #include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "trace.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
@@ -259,7 +260,7 @@ static void aspeed_sdmc_set_ram_size(Object *obj, Visitor *v, const char *name,
 
 static void aspeed_sdmc_initfn(Object *obj)
 {
-    object_property_add(obj, "ram-size", "int", NULL,
+    object_property_add(obj, "ram-size", "int", &int_type_info,
                         aspeed_sdmc_get_ram_size, aspeed_sdmc_set_ram_size,
                         NULL, NULL);
 }
diff --git a/hw/misc/npcm7xx_mft.c b/hw/misc/npcm7xx_mft.c
index 3ce92fad3a..a9e827e937 100644
--- a/hw/misc/npcm7xx_mft.c
+++ b/hw/misc/npcm7xx_mft.c
@@ -23,6 +23,7 @@
 #include "hw/core/registerfields.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
@@ -491,7 +492,7 @@ static void npcm7xx_mft_init(Object *obj)
     s->clock_2 = qdev_init_clock_out(dev, "clock2");
 
     for (int i = 0; i < NPCM7XX_PWM_PER_MODULE; ++i) {
-        object_property_add(obj, "max_rpm[*]", "uint32", NULL,
+        object_property_add(obj, "max_rpm[*]", "uint32", &uint32_type_info,
                             npcm7xx_mft_get_max_rpm,
                             npcm7xx_mft_set_max_rpm,
                             NULL, &s->max_rpm[i]);
diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
index 02300eaaa6..ed2c9e356c 100644
--- a/hw/net/ne2000-isa.c
+++ b/hw/net/ne2000-isa.c
@@ -29,6 +29,7 @@
 #include "ne2000.h"
 #include "system/system.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
 #include "qom/object.h"
@@ -131,7 +132,7 @@ out:
 
 static void isa_ne2000_instance_init(Object *obj)
 {
-    object_property_add(obj, "bootindex", "int32", NULL,
+    object_property_add(obj, "bootindex", "int32", &int32_type_info,
                         isa_ne2000_get_bootindex,
                         isa_ne2000_set_bootindex, NULL, NULL);
     object_property_set_int(obj, "bootindex", -1, NULL);
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 405010af4b..10e5d976a8 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -203,6 +203,7 @@
 #include "qemu/units.h"
 #include "qemu/range.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "system/system.h"
 #include "system/block-backend.h"
@@ -10612,7 +10613,8 @@ static void nvme_instance_init(Object *obj)
                                   "bootindex", "/namespace@1,0",
                                   DEVICE(obj));
 
-    object_property_add(obj, "smart_critical_warning", "uint8", NULL,
+    object_property_add(obj, "smart_critical_warning", "uint8",
+                        &uint8_type_info,
                         nvme_get_smart_warning,
                         nvme_set_smart_warning, NULL, NULL);
 }
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 1b22f5e383..88b2e2971e 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
@@ -103,7 +104,7 @@ static void pxb_bus_class_init(ObjectClass *class, const void *data)
     pbc->bus_num = pxb_bus_num;
     pbc->numa_node = pxb_bus_numa_node;
 
-    object_class_property_add(class, "acpi_uid", "uint32", NULL,
+    object_class_property_add(class, "acpi_uid", "uint32", &uint32_type_info,
                               prop_pxb_uid_get, NULL, NULL, NULL);
     object_class_property_set_description(class, "acpi_uid",
         "ACPI Unique ID used to distinguish this PCI Host Bridge / ACPI00016");
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index bf4b6c4253..0951378836 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -32,6 +32,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/core/sysbus.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "migration/vmstate.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
@@ -388,22 +389,22 @@ static void i440fx_pcihost_class_init(ObjectClass *klass, const void *data)
     dc->user_creatable = false;
 
     object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
-                              NULL,
+                              &uint32_type_info,
                               i440fx_pcihost_get_pci_hole_start,
                               NULL, NULL, NULL);
 
     object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
-                              NULL,
+                              &uint32_type_info,
                               i440fx_pcihost_get_pci_hole_end,
                               NULL, NULL, NULL);
 
     object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
-                              NULL,
+                              &uint64_type_info,
                               i440fx_pcihost_get_pci_hole64_start,
                               NULL, NULL, NULL);
 
     object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
-                              NULL,
+                              &uint64_type_info,
                               i440fx_pcihost_get_pci_hole64_end,
                               NULL, NULL, NULL);
 }
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index c45401d9dd..b159f93944 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -11,6 +11,7 @@
 #include "qemu/bswap.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "hw/pci-host/pnv_phb3_regs.h"
 #include "hw/pci-host/pnv_phb.h"
 #include "hw/pci-host/pnv_phb3.h"
@@ -1164,12 +1165,12 @@ static void pnv_phb3_root_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
-    object_class_property_add(klass, "phb-id", "uint32", NULL,
+    object_class_property_add(klass, "phb-id", "uint32", &uint32_type_info,
                               pnv_phb3_root_bus_get_prop,
                               pnv_phb3_root_bus_set_prop,
                               NULL, NULL);
 
-    object_class_property_add(klass, "chip-id", "uint32", NULL,
+    object_class_property_add(klass, "chip-id", "uint32", &uint32_type_info,
                               pnv_phb3_root_bus_get_prop,
                               pnv_phb3_root_bus_set_prop,
                               NULL, NULL);
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 6a5d1bb227..a5e1ee2844 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -11,6 +11,7 @@
 #include "qemu/bswap.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "target/ppc/cpu.h"
 #include "hw/pci-host/pnv_phb4_regs.h"
 #include "hw/pci-host/pnv_phb4.h"
@@ -1775,12 +1776,12 @@ static void pnv_phb4_root_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
-    object_class_property_add(klass, "phb-id", "uint32", NULL,
+    object_class_property_add(klass, "phb-id", "uint32", &uint32_type_info,
                               pnv_phb4_root_bus_get_prop,
                               pnv_phb4_root_bus_set_prop,
                               NULL, NULL);
 
-    object_class_property_add(klass, "chip-id", "uint32", NULL,
+    object_class_property_add(klass, "chip-id", "uint32", &uint32_type_info,
                               pnv_phb4_root_bus_get_prop,
                               pnv_phb4_root_bus_set_prop,
                               NULL, NULL);
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 027ae02066..d53441561f 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -35,6 +35,7 @@
 #include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
 
@@ -226,19 +227,23 @@ static void q35_host_initfn(Object *obj)
     qdev_prop_set_uint64(DEVICE(s), PCI_HOST_PROP_PCI_HOLE64_SIZE,
                          Q35_PCI_HOST_HOLE64_SIZE_DEFAULT);
 
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32", NULL,
+    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
+                        &uint32_type_info,
                         q35_host_get_pci_hole_start,
                         NULL, NULL, NULL);
 
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "uint32", NULL,
+    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
+                        &uint32_type_info,
                         q35_host_get_pci_hole_end,
                         NULL, NULL, NULL);
 
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "uint64", NULL,
+    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
+                        &uint64_type_info,
                         q35_host_get_pci_hole64_start,
                         NULL, NULL, NULL);
 
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "uint64", NULL,
+    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
+                        &uint64_type_info,
                         q35_host_get_pci_hole64_end,
                         NULL, NULL, NULL);
 
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index a33f0949d1..4054215592 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qobject/qnull.h"
 #include "qemu/cutils.h"
 #include "hw/ppc/spapr_drc.h"
@@ -584,8 +585,8 @@ static void spapr_dr_connector_instance_init(Object *obj)
     SpaprDrcClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
     object_property_add_uint32_ptr(obj, "id", &drc->id, OBJ_PROP_FLAG_READ);
-    object_property_add(obj, "index", "uint32", NULL, prop_get_index,
-                        NULL, NULL, NULL);
+    object_property_add(obj, "index", "uint32", &uint32_type_info,
+                        prop_get_index, NULL, NULL, NULL);
     object_property_add(obj, "fdt", "struct", NULL, prop_get_fdt,
                         NULL, NULL, NULL);
     drc->state = drck->empty_state;
diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 205582a91f..eae8a799f1 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -933,8 +933,8 @@ static void vfu_object_class_init(ObjectClass *klass, const void *data)
     k->nr_devs = 0;
 
     object_class_property_add(klass, "socket", "SocketAddress",
-                              &SocketAddress_type_info,
-                              NULL, vfu_object_set_socket, NULL, NULL);
+                              &SocketAddress_type_info, NULL,
+                              vfu_object_set_socket, NULL, NULL);
     object_class_property_set_description(klass, "socket",
                                           "SocketAddress "
                                           "(ex: type=unix,path=/tmp/sock). "
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 04c48a4eda..27c7c42231 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -39,6 +39,7 @@
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
@@ -744,7 +745,7 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc,
     mc->default_ram_size = 1537 * MiB;
 
     object_class_property_add(oc, "clint-timebase-frequency", "uint32_t",
-                              NULL,
+                              &uint32_type_info,
                               microchip_icicle_kit_get_clint_timebase_freq,
                               microchip_icicle_kit_set_clint_timebase_freq,
                               NULL, NULL);
diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
index 90cb36aad6..7de38f81e7 100644
--- a/hw/s390x/sclpcpi.c
+++ b/hw/s390x/sclpcpi.c
@@ -53,6 +53,7 @@
 #include "qemu/timer.h"
 #include "hw/s390x/event-facility.h"
 #include "hw/s390x/ebcdic.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-visit-machine.h"
 #include "qapi/qapi-events-machine-s390x.h"
 #include "migration/vmstate.h"
@@ -195,13 +196,14 @@ static void cpi_class_init(ObjectClass *klass, const void *data)
             "name of the cluster which the VM belongs to, if any"
             " e.g. \"PLEX    \"");
 
-    object_class_property_add(klass, "system_level", "uint64", NULL,
+    object_class_property_add(klass, "system_level", "uint64",
+                              &uint64_type_info,
                               get_system_level,
                               NULL, NULL, NULL);
     object_class_property_set_description(klass, "system_level",
             "distribution and kernel version in Linux e.g. 74872343805430528");
 
-    object_class_property_add(klass, "timestamp", "uint64", NULL,
+    object_class_property_add(klass, "timestamp", "uint64", &uint64_type_info,
                               get_timestamp,
                               NULL, NULL, NULL);
     object_class_property_set_description(klass, "timestamp",
diff --git a/hw/s390x/virtio-ccw-mem.c b/hw/s390x/virtio-ccw-mem.c
index 1dc19ca914..c9d09237c2 100644
--- a/hw/s390x/virtio-ccw-mem.c
+++ b/hw/s390x/virtio-ccw-mem.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qemu/module.h"
 #include "virtio-ccw-mem.h"
 #include "hw/mem/memory-device.h"
@@ -205,7 +206,8 @@ static void virtio_ccw_mem_instance_init(Object *obj)
                               OBJECT(&dev->vdev), VIRTIO_MEM_BLOCK_SIZE_PROP);
     object_property_add_alias(obj, VIRTIO_MEM_SIZE_PROP, OBJECT(&dev->vdev),
                               VIRTIO_MEM_SIZE_PROP);
-    object_property_add(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, "size", NULL,
+    object_property_add(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, "size",
+                        &size_type_info,
                         virtio_ccw_mem_get_requested_size,
                         virtio_ccw_mem_set_requested_size, NULL, NULL);
 }
diff --git a/hw/sensor/adc128d818.c b/hw/sensor/adc128d818.c
index 14d79d3958..4ac7a4393d 100644
--- a/hw/sensor/adc128d818.c
+++ b/hw/sensor/adc128d818.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qom/object.h"
@@ -642,15 +643,16 @@ static void adc128d818_initfn(Object *obj)
     for (unsigned ch = 0u; ch < ADC128D818_NUM_CHANNELS; ch++) {
         char *name = g_strdup_printf("ain%u", ch);
 
-        object_property_add(obj, name, "int", NULL, adc128d818_get_ain,
+        object_property_add(obj, name, "int", &int_type_info,
+                            adc128d818_get_ain,
                             adc128d818_set_ain, NULL, NULL);
         g_free(name);
     }
 
-    object_property_add(obj, "temperature", "int", NULL,
+    object_property_add(obj, "temperature", "int", &int_type_info,
                         adc128d818_get_temperature,
                         adc128d818_set_temperature, NULL, NULL);
-    object_property_add(obj, "ext-vref-mv", "int", NULL,
+    object_property_add(obj, "ext-vref-mv", "int", &int_type_info,
                         adc128d818_get_ext_vref,
                         adc128d818_set_ext_vref, NULL, NULL);
 }
diff --git a/hw/sensor/adm1266.c b/hw/sensor/adm1266.c
index 7927845e32..c880fca225 100644
--- a/hw/sensor/adm1266.c
+++ b/hw/sensor/adm1266.c
@@ -14,6 +14,7 @@
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -217,7 +218,7 @@ static void adm1266_init(Object *obj)
     for (int i = 0; i < ADM1266_NUM_PAGES; i++) {
         pmbus_page_config(pmdev, i, flags);
 
-        object_property_add(obj, "vout[*]", "uint16", NULL,
+        object_property_add(obj, "vout[*]", "uint16", &uint16_type_info,
                             adm1266_get,
                             adm1266_set, NULL, &pmdev->pages[i].read_vout);
     }
diff --git a/hw/sensor/adm1272.c b/hw/sensor/adm1272.c
index 6a7ff02617..ca66039c20 100644
--- a/hw/sensor/adm1272.c
+++ b/hw/sensor/adm1272.c
@@ -12,6 +12,7 @@
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -493,19 +494,19 @@ static void adm1272_init(Object *obj)
 
     pmbus_page_config(pmdev, 0, flags);
 
-    object_property_add(obj, "vin", "uint16", NULL,
+    object_property_add(obj, "vin", "uint16", &uint16_type_info,
                         adm1272_get,
                         adm1272_set, NULL, &pmdev->pages[0].read_vin);
 
-    object_property_add(obj, "vout", "uint16", NULL,
+    object_property_add(obj, "vout", "uint16", &uint16_type_info,
                         adm1272_get,
                         adm1272_set, NULL, &pmdev->pages[0].read_vout);
 
-    object_property_add(obj, "iout", "uint16", NULL,
+    object_property_add(obj, "iout", "uint16", &uint16_type_info,
                         adm1272_get,
                         adm1272_set, NULL, &pmdev->pages[0].read_iout);
 
-    object_property_add(obj, "pin", "uint16", NULL,
+    object_property_add(obj, "pin", "uint16", &uint16_type_info,
                         adm1272_get,
                         adm1272_set, NULL, &pmdev->pages[0].read_pin);
 
diff --git a/hw/sensor/emc141x.c b/hw/sensor/emc141x.c
index 128d721b7b..f53ee9f654 100644
--- a/hw/sensor/emc141x.c
+++ b/hw/sensor/emc141x.c
@@ -22,6 +22,7 @@
 #include "hw/i2c/i2c.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
 #include "qom/object.h"
@@ -251,16 +252,16 @@ static void emc141x_reset(DeviceState *dev)
 
 static void emc141x_initfn(Object *obj)
 {
-    object_property_add(obj, "temperature0", "int", NULL,
+    object_property_add(obj, "temperature0", "int", &int_type_info,
                         emc141x_get_temperature,
                         emc141x_set_temperature, NULL, NULL);
-    object_property_add(obj, "temperature1", "int", NULL,
+    object_property_add(obj, "temperature1", "int", &int_type_info,
                         emc141x_get_temperature,
                         emc141x_set_temperature, NULL, NULL);
-    object_property_add(obj, "temperature2", "int", NULL,
+    object_property_add(obj, "temperature2", "int", &int_type_info,
                         emc141x_get_temperature,
                         emc141x_set_temperature, NULL, NULL);
-    object_property_add(obj, "temperature3", "int", NULL,
+    object_property_add(obj, "temperature3", "int", &int_type_info,
                         emc141x_get_temperature,
                         emc141x_set_temperature, NULL, NULL);
 }
diff --git a/hw/sensor/isl_pmbus_vr.c b/hw/sensor/isl_pmbus_vr.c
index 1af0f2af35..dbff398d57 100644
--- a/hw/sensor/isl_pmbus_vr.c
+++ b/hw/sensor/isl_pmbus_vr.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "hw/sensor/isl_pmbus_vr.h"
 #include "hw/core/qdev-properties.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -136,63 +137,63 @@ static void isl_pmbus_vr_add_props(Object *obj, uint64_t *flags, uint8_t pages)
     PMBusDevice *pmdev = PMBUS_DEVICE(obj);
     for (int i = 0; i < pages; i++) {
         if (flags[i] & PB_HAS_VIN) {
-            object_property_add(obj, "vin[*]", "uint16", NULL,
+            object_property_add(obj, "vin[*]", "uint16", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_vin);
         }
 
         if (flags[i] & PB_HAS_VOUT) {
-            object_property_add(obj, "vout[*]", "uint16", NULL,
+            object_property_add(obj, "vout[*]", "uint16", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_vout);
         }
 
         if (flags[i] & PB_HAS_IIN) {
-            object_property_add(obj, "iin[*]", "uint16", NULL,
+            object_property_add(obj, "iin[*]", "uint16", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_iin);
         }
 
         if (flags[i] & PB_HAS_IOUT) {
-            object_property_add(obj, "iout[*]", "uint16", NULL,
+            object_property_add(obj, "iout[*]", "uint16", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_iout);
         }
 
         if (flags[i] & PB_HAS_PIN) {
-            object_property_add(obj, "pin[*]", "uint16", NULL,
+            object_property_add(obj, "pin[*]", "uint16", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_pin);
         }
 
         if (flags[i] & PB_HAS_POUT) {
-            object_property_add(obj, "pout[*]", "uint16", NULL,
+            object_property_add(obj, "pout[*]", "uint16", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_pout);
         }
 
         if (flags[i] & PB_HAS_TEMPERATURE) {
-            object_property_add(obj, "temp1[*]", "uint16", NULL,
+            object_property_add(obj, "temp1[*]", "uint16", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_temperature_1);
         }
 
         if (flags[i] & PB_HAS_TEMP2) {
-            object_property_add(obj, "temp2[*]", "uint16", NULL,
+            object_property_add(obj, "temp2[*]", "uint16", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_temperature_2);
         }
 
         if (flags[i] & PB_HAS_TEMP3) {
-            object_property_add(obj, "temp3[*]", "uint16", NULL,
+            object_property_add(obj, "temp3[*]", "uint16", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_temperature_3);
diff --git a/hw/sensor/lsm303dlhc_mag.c b/hw/sensor/lsm303dlhc_mag.c
index f362686b69..1045473595 100644
--- a/hw/sensor/lsm303dlhc_mag.c
+++ b/hw/sensor/lsm303dlhc_mag.c
@@ -25,6 +25,7 @@
 #include "hw/i2c/i2c.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
@@ -509,19 +510,19 @@ static void lsm303dlhc_mag_reset(DeviceState *dev)
  */
 static void lsm303dlhc_mag_initfn(Object *obj)
 {
-    object_property_add(obj, "mag-x", "int", NULL,
+    object_property_add(obj, "mag-x", "int", &int_type_info,
                         lsm303dlhc_mag_get_x,
                         lsm303dlhc_mag_set_x, NULL, NULL);
 
-    object_property_add(obj, "mag-y", "int", NULL,
+    object_property_add(obj, "mag-y", "int", &int_type_info,
                         lsm303dlhc_mag_get_y,
                         lsm303dlhc_mag_set_y, NULL, NULL);
 
-    object_property_add(obj, "mag-z", "int", NULL,
+    object_property_add(obj, "mag-z", "int", &int_type_info,
                         lsm303dlhc_mag_get_z,
                         lsm303dlhc_mag_set_z, NULL, NULL);
 
-    object_property_add(obj, "temperature", "int", NULL,
+    object_property_add(obj, "temperature", "int", &int_type_info,
                         lsm303dlhc_mag_get_temperature,
                         lsm303dlhc_mag_set_temperature, NULL, NULL);
 }
diff --git a/hw/sensor/max34451.c b/hw/sensor/max34451.c
index 6c2f7311ff..9e3ebf72be 100644
--- a/hw/sensor/max34451.c
+++ b/hw/sensor/max34451.c
@@ -11,6 +11,7 @@
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
@@ -727,7 +728,7 @@ static void max34451_init(Object *obj)
 
     /* get and set the voltage in millivolts, max is 32767 mV */
     for (int i = 0; i < MAX34451_NUM_PWR_DEVICES; i++) {
-        object_property_add(obj, "vout[*]", "uint16", NULL,
+        object_property_add(obj, "vout[*]", "uint16", &uint16_type_info,
                             max34451_get,
                             max34451_set, NULL, &pmdev->pages[i].read_vout);
     }
@@ -737,7 +738,7 @@ static void max34451_init(Object *obj)
      * centidegrees Celsius i.e.: 2500 -> 25.00 C, max is 327.67 C
      */
     for (int i = 0; i < MAX34451_NUM_TEMP_DEVICES; i++) {
-        object_property_add(obj, "temperature[*]", "uint16", NULL,
+        object_property_add(obj, "temperature[*]", "uint16", &uint16_type_info,
                             max34451_get,
                             max34451_set,
                             NULL,
diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index 98f45a49b7..ec39c31d90 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qom/object.h"
 #include "hw/sensor/tmp105.h"
@@ -408,7 +409,7 @@ static void tmp105_realize(DeviceState *dev, Error **errp)
 
 static void tmp105_initfn(Object *obj)
 {
-    object_property_add(obj, "temperature", "int", NULL,
+    object_property_add(obj, "temperature", "int", &int_type_info,
                         tmp105_get_temperature,
                         tmp105_set_temperature, NULL, NULL);
     object_property_set_description(obj, "temperature",
diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index 8e6823dfcc..0e4d0d0ec2 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -28,6 +28,7 @@
 #include "hw/i2c/i2c.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
 #include "qom/object.h"
@@ -350,16 +351,16 @@ static void tmp421_class_init(ObjectClass *klass, const void *data)
     dc->vmsd = &vmstate_tmp421;
     sc->dev = (DeviceInfo *) data;
 
-    object_class_property_add(klass, "temperature0", "int", NULL,
+    object_class_property_add(klass, "temperature0", "int", &int_type_info,
                               tmp421_get_temperature,
                               tmp421_set_temperature, NULL, NULL);
-    object_class_property_add(klass, "temperature1", "int", NULL,
+    object_class_property_add(klass, "temperature1", "int", &int_type_info,
                               tmp421_get_temperature,
                               tmp421_set_temperature, NULL, NULL);
-    object_class_property_add(klass, "temperature2", "int", NULL,
+    object_class_property_add(klass, "temperature2", "int", &int_type_info,
                               tmp421_get_temperature,
                               tmp421_set_temperature, NULL, NULL);
-    object_class_property_add(klass, "temperature3", "int", NULL,
+    object_class_property_add(klass, "temperature3", "int", &int_type_info,
                               tmp421_get_temperature,
                               tmp421_set_temperature, NULL, NULL);
 }
diff --git a/hw/usb/dev-storage-classic.c b/hw/usb/dev-storage-classic.c
index dfd568da5e..353f81dcc0 100644
--- a/hw/usb/dev-storage-classic.c
+++ b/hw/usb/dev-storage-classic.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "hw/usb/usb.h"
 #include "hw/usb/desc.h"
@@ -122,7 +123,7 @@ out:
 
 static void usb_msd_instance_init(Object *obj)
 {
-    object_property_add(obj, "bootindex", "int32", NULL,
+    object_property_add(obj, "bootindex", "int32", &int32_type_info,
                         usb_msd_get_bootindex,
                         usb_msd_set_bootindex, NULL, NULL);
     object_property_set_int(obj, "bootindex", -1, NULL);
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 995b1a41ef..366f88e048 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -27,6 +27,7 @@
 #include "hw/virtio/virtio-balloon.h"
 #include "system/address-spaces.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-events-machine.h"
 #include "qapi/visitor.h"
 #include "trace.h"
@@ -1039,7 +1040,8 @@ static void virtio_balloon_instance_init(Object *obj)
     object_property_add(obj, "guest-stats", "guest statistics", NULL,
                         balloon_stats_get_all, NULL, NULL, NULL);
 
-    object_property_add(obj, "guest-stats-polling-interval", "int", NULL,
+    object_property_add(obj, "guest-stats-polling-interval", "int",
+                        &int_type_info,
                         balloon_stats_get_poll_interval,
                         balloon_stats_set_poll_interval,
                         NULL, NULL);
diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
index 6349337bf4..3044a807c1 100644
--- a/hw/virtio/virtio-mem-pci.c
+++ b/hw/virtio/virtio-mem-pci.c
@@ -14,6 +14,7 @@
 #include "virtio-mem-pci.h"
 #include "hw/mem/memory-device.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-events-machine.h"
 #include "qapi/qapi-events-misc.h"
 
@@ -211,7 +212,8 @@ static void virtio_mem_pci_instance_init(Object *obj)
                               OBJECT(&dev->vdev), VIRTIO_MEM_BLOCK_SIZE_PROP);
     object_property_add_alias(obj, VIRTIO_MEM_SIZE_PROP, OBJECT(&dev->vdev),
                               VIRTIO_MEM_SIZE_PROP);
-    object_property_add(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, "size", NULL,
+    object_property_add(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, "size",
+                        &size_type_info,
                         virtio_mem_pci_get_requested_size,
                         virtio_mem_pci_set_requested_size, NULL, NULL);
 }
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index fcfd9fa18a..cbcfdf9f13 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -26,6 +26,7 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-mem.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "migration/misc.h"
 #include "hw/core/boards.h"
@@ -1533,13 +1534,16 @@ static void virtio_mem_instance_init(Object *obj)
 
     notifier_list_init(&vmem->size_change_notifiers);
 
-    object_property_add(obj, VIRTIO_MEM_SIZE_PROP, "size", NULL,
+    object_property_add(obj, VIRTIO_MEM_SIZE_PROP, "size",
+                        &size_type_info,
                         virtio_mem_get_size,
                         NULL, NULL, NULL);
-    object_property_add(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, "size", NULL,
+    object_property_add(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, "size",
+                        &size_type_info,
                         virtio_mem_get_requested_size,
                         virtio_mem_set_requested_size, NULL, NULL);
-    object_property_add(obj, VIRTIO_MEM_BLOCK_SIZE_PROP, "size", NULL,
+    object_property_add(obj, VIRTIO_MEM_BLOCK_SIZE_PROP, "size",
+                        &size_type_info,
                         virtio_mem_get_block_size, virtio_mem_set_block_size,
                         NULL, NULL);
 }
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index ddeabe30f2..ca3326156f 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "hw/core/boards.h"
 #include "hw/core/irq.h"
@@ -413,7 +414,8 @@ void xen_pvh_class_setup_common_props(XenPVHMachineClass *xpc)
 
 #define OC_MEMMAP_PROP_BASE(c, prop_name, name)                           \
 do {                                                                      \
-    object_class_property_add(c, prop_name "-base", "uint64_t", NULL,     \
+    object_class_property_add(c, prop_name "-base", "uint64_t",           \
+                              &uint64_type_info,                          \
                               xen_pvh_get_ ## name ## _base,              \
                               xen_pvh_set_ ## name ## _base, NULL, NULL); \
     object_class_property_set_description(oc, prop_name "-base",          \
@@ -422,7 +424,8 @@ do {                                                                      \
 
 #define OC_MEMMAP_PROP_SIZE(c, prop_name, name)                           \
 do {                                                                      \
-    object_class_property_add(c, prop_name "-size", "uint64_t", NULL,     \
+    object_class_property_add(c, prop_name "-size", "uint64_t",           \
+                              &uint64_type_info,                          \
                               xen_pvh_get_ ## name ## _size,              \
                               xen_pvh_set_ ## name ## _size, NULL, NULL); \
     object_class_property_set_description(oc, prop_name "-size",          \
@@ -458,7 +461,8 @@ do {                                                                      \
         OC_MEMMAP_PROP(oc, "pci-mmio", pci_mmio);
         OC_MEMMAP_PROP(oc, "pci-mmio-high", pci_mmio_high);
 
-        object_class_property_add(oc, "pci-intx-irq-base", "uint32_t", NULL,
+        object_class_property_add(oc, "pci-intx-irq-base", "uint32_t",
+                                  &uint32_type_info,
                                   xen_pvh_get_pci_intx_irq_base,
                                   xen_pvh_set_pci_intx_irq_base,
                                   NULL, NULL);
@@ -468,7 +472,8 @@ do {                                                                      \
 
 #ifdef CONFIG_TPM
     if (xpc->has_tpm) {
-        object_class_property_add(oc, "tpm-base-addr", "uint64_t", NULL,
+        object_class_property_add(oc, "tpm-base-addr", "uint64_t",
+                                  &uint64_type_info,
                                   xen_pvh_get_tpm_base,
                                   xen_pvh_set_tpm_base,
                                   NULL, NULL);
diff --git a/iothread.c b/iothread.c
index 7084d336a4..3a1601e28b 100644
--- a/iothread.c
+++ b/iothread.c
@@ -20,6 +20,7 @@
 #include "system/event-loop-base.h"
 #include "system/iothread.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qemu/error-report.h"
 #include "qemu/rcu.h"
@@ -315,19 +316,19 @@ static void iothread_class_init(ObjectClass *klass, const void *class_data)
     bc->init = iothread_init;
     bc->update_params = iothread_set_aio_context_params;
 
-    object_class_property_add(klass, "poll-max-ns", "int64", NULL,
+    object_class_property_add(klass, "poll-max-ns", "int64", &int64_type_info,
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_max_ns_info);
-    object_class_property_add(klass, "poll-grow", "int64", NULL,
+    object_class_property_add(klass, "poll-grow", "int64", &int64_type_info,
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_grow_info);
-    object_class_property_add(klass, "poll-shrink", "int64", NULL,
+    object_class_property_add(klass, "poll-shrink", "int64", &int64_type_info,
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_shrink_info);
-    object_class_property_add(klass, "poll-weight", "int64", NULL,
+    object_class_property_add(klass, "poll-weight", "int64", &int64_type_info,
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_weight_info);
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 6bc43e0696..9b04b28484 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -16,6 +16,7 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "net/net.h"
 #include "net/eth.h"
 #include "qom/object_interfaces.h"
@@ -1373,15 +1374,15 @@ static void colo_compare_init(Object *obj)
     object_property_add_str(obj, "notify_dev",
                             compare_get_notify_dev, compare_set_notify_dev);
 
-    object_property_add(obj, "compare_timeout", "uint64", NULL,
+    object_property_add(obj, "compare_timeout", "uint64", &uint64_type_info,
                         compare_get_timeout,
                         compare_set_timeout, NULL, NULL);
 
-    object_property_add(obj, "expired_scan_cycle", "uint32", NULL,
+    object_property_add(obj, "expired_scan_cycle", "uint32", &uint32_type_info,
                         compare_get_expired_scan_cycle,
                         compare_set_expired_scan_cycle, NULL, NULL);
 
-    object_property_add(obj, "max_queue_size", "uint32", NULL,
+    object_property_add(obj, "max_queue_size", "uint32", &uint32_type_info,
                         get_max_queue_size,
                         set_max_queue_size, NULL, NULL);
 
diff --git a/net/dump.c b/net/dump.c
index 558115b9c9..da366f48da 100644
--- a/net/dump.c
+++ b/net/dump.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "clients.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
@@ -238,7 +239,7 @@ static void filter_dump_class_init(ObjectClass *oc, const void *data)
 {
     NetFilterClass *nfc = NETFILTER_CLASS(oc);
 
-    object_class_property_add(oc, "maxlen", "uint32", NULL,
+    object_class_property_add(oc, "maxlen", "uint32", &uint32_type_info,
                               filter_dump_get_maxlen,
                               filter_dump_set_maxlen, NULL, NULL);
     object_class_property_add_str(oc, "file", file_dump_get_filename,
diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index f56b2cfaf0..82a64a4680 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -10,6 +10,7 @@
 #include "net/filter.h"
 #include "net/queue.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qemu/timer.h"
 #include "qemu/iov.h"
 #include "qapi/qapi-builtin-visit.h"
@@ -182,7 +183,7 @@ static void filter_buffer_class_init(ObjectClass *oc, const void *data)
 {
     NetFilterClass *nfc = NETFILTER_CLASS(oc);
 
-    object_class_property_add(oc, "interval", "uint32", NULL,
+    object_class_property_add(oc, "interval", "uint32", &uint32_type_info,
                               filter_buffer_get_interval,
                               filter_buffer_set_interval, NULL, NULL);
 
diff --git a/qom/object.c b/qom/object.c
index 0ef0d4d42c..39d26a17c6 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -22,10 +22,10 @@
 #include "qapi/string-output-visitor.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/forward-visitor.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/compat-policy.h"
 #include "qobject/qdict.h"
-#include "qobject/qjson.h"
 #include "qemu/id.h"
 #include "qapi/qmp/qerror.h"
 #include "trace.h"
@@ -2406,7 +2406,7 @@ object_property_add_str(Object *obj, const char *name,
     prop->get = get;
     prop->set = set;
 
-    return object_property_add(obj, name, "string", NULL,
+    return object_property_add(obj, name, "string", &str_type_info,
                                get ? property_get_str : NULL,
                                set ? property_set_str : NULL,
                                property_release_data,
@@ -2424,7 +2424,7 @@ object_class_property_add_str(ObjectClass *klass, const char *name,
     prop->get = get;
     prop->set = set;
 
-    return object_class_property_add(klass, name, "string", NULL,
+    return object_class_property_add(klass, name, "string", &str_type_info,
                                      get ? property_get_str : NULL,
                                      set ? property_set_str : NULL,
                                      NULL,
@@ -2476,7 +2476,7 @@ object_property_add_bool(Object *obj, const char *name,
     prop->get = get;
     prop->set = set;
 
-    return object_property_add(obj, name, "bool", NULL,
+    return object_property_add(obj, name, "bool", &bool_type_info,
                                get ? property_get_bool : NULL,
                                set ? property_set_bool : NULL,
                                property_release_data,
@@ -2493,7 +2493,7 @@ object_class_property_add_bool(ObjectClass *klass, const char *name,
     prop->get = get;
     prop->set = set;
 
-    return object_class_property_add(klass, name, "bool", NULL,
+    return object_class_property_add(klass, name, "bool", &bool_type_info,
                                      get ? property_get_bool : NULL,
                                      set ? property_set_bool : NULL,
                                      NULL,
@@ -2817,7 +2817,7 @@ object_class_property_add_bool_ptr(ObjectClass *klass, const char *name,
         setter = property_class_set_bool_ptr;
     }
 
-    return object_class_property_add(klass, name, "bool", NULL,
+    return object_class_property_add(klass, name, "bool", &bool_type_info,
                                      getter, setter, NULL, (void *)offset);
 }
 
@@ -2837,7 +2837,7 @@ object_property_add_uint8_ptr(Object *obj, const char *name,
         setter = property_set_uint8_ptr;
     }
 
-    return object_property_add(obj, name, "uint8", NULL,
+    return object_property_add(obj, name, "uint8", &uint8_type_info,
                                getter, setter, NULL, (void *)v);
 }
 
@@ -2857,7 +2857,7 @@ object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
         setter = property_class_set_uint8_ptr;
     }
 
-    return object_class_property_add(klass, name, "uint8", NULL,
+    return object_class_property_add(klass, name, "uint8", &uint8_type_info,
                                      getter, setter, NULL, (void *)offset);
 }
 
@@ -2878,7 +2878,7 @@ object_class_static_property_add_uint8_ptr(ObjectClass *klass,
         setter = property_set_uint8_ptr;
     }
 
-    return object_class_property_add(klass, name, "uint8", NULL,
+    return object_class_property_add(klass, name, "uint8", &uint8_type_info,
                                      getter, setter, NULL, (void *)v);
 }
 
@@ -2898,7 +2898,7 @@ object_property_add_uint16_ptr(Object *obj, const char *name,
         setter = property_set_uint16_ptr;
     }
 
-    return object_property_add(obj, name, "uint16", NULL,
+    return object_property_add(obj, name, "uint16", &uint16_type_info,
                                getter, setter, NULL, (void *)v);
 }
 
@@ -2918,7 +2918,7 @@ object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
         setter = property_class_set_uint16_ptr;
     }
 
-    return object_class_property_add(klass, name, "uint16", NULL,
+    return object_class_property_add(klass, name, "uint16", &uint16_type_info,
                                      getter, setter, NULL, (void *)offset);
 }
 
@@ -2939,7 +2939,7 @@ object_class_static_property_add_uint16_ptr(ObjectClass *klass,
         setter = property_set_uint16_ptr;
     }
 
-    return object_class_property_add(klass, name, "uint16", NULL,
+    return object_class_property_add(klass, name, "uint16", &uint16_type_info,
                                      getter, setter, NULL, (void *)v);
 }
 
@@ -2959,7 +2959,7 @@ object_property_add_uint32_ptr(Object *obj, const char *name,
         setter = property_set_uint32_ptr;
     }
 
-    return object_property_add(obj, name, "uint32", NULL,
+    return object_property_add(obj, name, "uint32", &uint32_type_info,
                                getter, setter, NULL, (void *)v);
 }
 
@@ -2979,7 +2979,7 @@ object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
         setter = property_class_set_uint32_ptr;
     }
 
-    return object_class_property_add(klass, name, "uint32", NULL,
+    return object_class_property_add(klass, name, "uint32", &uint32_type_info,
                                      getter, setter, NULL, (void *)offset);
 }
 
@@ -3000,7 +3000,7 @@ object_class_static_property_add_uint32_ptr(ObjectClass *klass,
         setter = property_set_uint32_ptr;
     }
 
-    return object_class_property_add(klass, name, "uint32", NULL,
+    return object_class_property_add(klass, name, "uint32", &uint32_type_info,
                                      getter, setter, NULL, (void *)v);
 }
 
@@ -3020,7 +3020,7 @@ object_property_add_uint64_ptr(Object *obj, const char *name,
         setter = property_set_uint64_ptr;
     }
 
-    return object_property_add(obj, name, "uint64", NULL,
+    return object_property_add(obj, name, "uint64", &uint64_type_info,
                                getter, setter, NULL, (void *)v);
 }
 
@@ -3040,7 +3040,7 @@ object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
         setter = property_class_set_uint64_ptr;
     }
 
-    return object_class_property_add(klass, name, "uint64", NULL,
+    return object_class_property_add(klass, name, "uint64", &uint64_type_info,
                                      getter, setter, NULL, (void *)offset);
 }
 
@@ -3061,7 +3061,7 @@ object_class_static_property_add_uint64_ptr(ObjectClass *klass,
         setter = property_set_uint64_ptr;
     }
 
-    return object_class_property_add(klass, name, "uint64", NULL,
+    return object_class_property_add(klass, name, "uint64", &uint64_type_info,
                                      getter, setter, NULL, (void *)v);
 }
 
diff --git a/system/bootdevice.c b/system/bootdevice.c
index 4fc6b4c8ed..36eb582dee 100644
--- a/system/bootdevice.c
+++ b/system/bootdevice.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "system/system.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
@@ -336,7 +337,7 @@ void device_add_bootindex_property(Object *obj, int32_t *bootindex,
     prop->suffix = suffix;
     prop->dev = dev;
 
-    object_property_add(obj, name, "int32", NULL,
+    object_property_add(obj, name, "int32", &int32_type_info,
                         device_get_bootindex,
                         device_set_bootindex,
                         property_release_bootindex,
diff --git a/system/memory.c b/system/memory.c
index ac296cb0d8..56c5dd6c8a 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "system/memory.h"
 #include "qapi/visitor.h"
 #include "qemu/bitops.h"
@@ -1293,11 +1294,11 @@ static void memory_region_initfn(Object *obj)
 
     object_property_add_uint64_ptr(OBJECT(mr), "addr",
                                    &mr->addr, OBJ_PROP_FLAG_READ);
-    object_property_add(OBJECT(mr), "priority", "int32", NULL,
+    object_property_add(OBJECT(mr), "priority", "int32", &int32_type_info,
                         memory_region_get_priority,
                         NULL, /* memory_region_set_priority */
                         NULL, NULL);
-    object_property_add(OBJECT(mr), "size", "uint64", NULL,
+    object_property_add(OBJECT(mr), "size", "uint64", &uint64_type_info,
                         memory_region_get_size,
                         NULL, /* memory_region_set_size, */
                         NULL, NULL);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 9c869b4488..2a0f61e42d 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "cpu.h"
 #include "cpregs.h"
 #include "qemu/module.h"
@@ -328,7 +329,8 @@ static void prop_bool_set_false(Object *obj, Visitor *v, const char *name,
 
 static void prop_add_stub_bool(Object *obj, const char *name)
 {
-    object_property_add(obj, name, "bool", NULL, prop_bool_get_false,
+    object_property_add(obj, name, "bool", &bool_type_info,
+                        prop_bool_get_false,
                         prop_bool_set_false, NULL, NULL);
 }
 
@@ -518,13 +520,15 @@ void aarch64_add_sve_properties(Object *obj)
     for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
         char name[8];
         snprintf(name, sizeof(name), "sve%d", vq * 128);
-        object_property_add(obj, name, "bool", NULL, cpu_arm_get_vq,
+        object_property_add(obj, name, "bool", &bool_type_info,
+                            cpu_arm_get_vq,
                             cpu_arm_set_vq, NULL, &cpu->sve_vq);
     }
 
 #ifdef CONFIG_USER_ONLY
     /* Mirror linux /proc/sys/abi/sve_default_vector_length. */
-    object_property_add(obj, "sve-default-vector-length", "int32", NULL,
+    object_property_add(obj, "sve-default-vector-length", "int32",
+                        &int32_type_info,
                         cpu_arm_get_default_vec_len,
                         cpu_arm_set_default_vec_len, NULL,
                         &cpu->sve_default_vq);
@@ -543,13 +547,15 @@ void aarch64_add_sme_properties(Object *obj)
     for (vq = 1; vq <= ARM_MAX_VQ; vq <<= 1) {
         char name[8];
         snprintf(name, sizeof(name), "sme%d", vq * 128);
-        object_property_add(obj, name, "bool", NULL, cpu_arm_get_vq,
+        object_property_add(obj, name, "bool", &bool_type_info,
+                            cpu_arm_get_vq,
                             cpu_arm_set_vq, NULL, &cpu->sme_vq);
     }
 
 #ifdef CONFIG_USER_ONLY
     /* Mirror linux /proc/sys/abi/sme_default_vector_length. */
-    object_property_add(obj, "sme-default-vector-length", "int32", NULL,
+    object_property_add(obj, "sme-default-vector-length", "int32",
+                        &int32_type_info,
                         cpu_arm_get_default_vec_len,
                         cpu_arm_set_default_vec_len, NULL,
                         &cpu->sme_default_vq);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8a698a9d20..5c78a64b47 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -20,6 +20,7 @@
 #include "qemu/main-loop.h"
 #include "qom/object.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "system/system.h"
 #include "system/runstate.h"
 #include "system/ramblock.h"
@@ -1820,7 +1821,7 @@ static void kvm_arch_set_eager_split_size(Object *obj, Visitor *v,
 
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
-    object_class_property_add(oc, "eager-split-size", "size", NULL,
+    object_class_property_add(oc, "eager-split-size", "size", &size_type_info,
                               kvm_arch_get_eager_split_size,
                               kvm_arch_set_eager_split_size, NULL, NULL);
 
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 79df821da8..026d074868 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "cpu.h"
 #include "qemu/module.h"
 #include "qapi/visitor.h"
@@ -1392,7 +1393,7 @@ void aarch64_max_v8_tcg_initfn(Object *obj)
     /* v8.2: FEAT_SVE */
     cpu->sve_vq.supported = MAKE_64BIT_MASK(0, ARM_MAX_VQ);
     aarch64_add_sve_properties(OBJECT(cpu));
-    object_property_add(OBJECT(cpu), "sve-max-vq", "uint32", NULL,
+    object_property_add(OBJECT(cpu), "sve-max-vq", "uint32", &uint32_type_info,
                         cpu_max_get_sve_max_vq, cpu_max_set_sve_max_vq,
                         NULL, NULL);
 
@@ -1529,7 +1530,8 @@ void aarch64_max_v9_tcg_initfn(Object *obj)
     object_property_add_bool(obj, "x-rme", cpu_arm_get_rme, cpu_arm_set_rme);
 
     /* v9.4: FEAT_RME_GPC2 */
-    object_property_add(obj, "x-l0gptsz", "uint32", NULL, cpu_max_get_l0gptsz,
+    object_property_add(obj, "x-l0gptsz", "uint32", &uint32_type_info,
+                        cpu_max_get_l0gptsz,
                         cpu_max_set_l0gptsz, NULL, NULL);
 }
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6a05a7144a..9ee96cbe39 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10486,7 +10486,7 @@ static void x86_cpu_register_bit_prop(X86CPUClass *xcc,
         fp = g_new0(BitProperty, 1);
         fp->w = w;
         fp->mask = mask;
-        object_class_property_add(oc, prop_name, "bool", NULL,
+        object_class_property_add(oc, prop_name, "bool", &bool_type_info,
                                   x86_cpu_get_bit_prop,
                                   x86_cpu_set_bit_prop,
                                   NULL, fp);
@@ -11009,13 +11009,13 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
 
     dc->user_creatable = true;
 
-    object_class_property_add(oc, "family", "uint64", NULL,
+    object_class_property_add(oc, "family", "uint64", &uint64_type_info,
                               x86_cpuid_version_get_family,
                               x86_cpuid_version_set_family, NULL, NULL);
-    object_class_property_add(oc, "model", "uint64", NULL,
+    object_class_property_add(oc, "model", "uint64", &uint64_type_info,
                               x86_cpuid_version_get_model,
                               x86_cpuid_version_set_model, NULL, NULL);
-    object_class_property_add(oc, "stepping", "uint64", NULL,
+    object_class_property_add(oc, "stepping", "uint64", &uint64_type_info,
                               x86_cpuid_version_get_stepping,
                               x86_cpuid_version_set_stepping, NULL, NULL);
     object_class_property_add_str(oc, "vendor",
@@ -11024,7 +11024,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_str(oc, "model-id",
                                   x86_cpuid_get_model_id,
                                   x86_cpuid_set_model_id);
-    object_class_property_add(oc, "tsc-frequency", "int", NULL,
+    object_class_property_add(oc, "tsc-frequency", "int", &int_type_info,
                               x86_cpuid_get_tsc_freq,
                               x86_cpuid_set_tsc_freq, NULL, NULL);
     /*
@@ -11037,7 +11037,8 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
                               x86_cpu_get_unavailable_features,
                               NULL, NULL, NULL);
 
-    object_class_property_add(oc, "avx10-version", "uint8", NULL,
+    object_class_property_add(oc, "avx10-version", "uint8",
+                              &uint8_type_info,
                               x86_cpuid_get_avx10_version,
                               x86_cpuid_set_avx10_version,
                               NULL, NULL);
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 0f71e75b60..e003e47c5b 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -7098,7 +7098,7 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
     object_class_property_set_description(oc, "notify-vmexit",
                                           "Enable notify VM exit");
 
-    object_class_property_add(oc, "notify-window", "uint32", NULL,
+    object_class_property_add(oc, "notify-window", "uint32", &uint32_type_info,
                               kvm_arch_get_notify_window,
                               kvm_arch_set_notify_window,
                               NULL, NULL);
@@ -7106,7 +7106,7 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
                                           "Clock cycles without an event window "
                                           "after which a notification VM exit occurs");
 
-    object_class_property_add(oc, "xen-version", "uint32", NULL,
+    object_class_property_add(oc, "xen-version", "uint32", &uint32_type_info,
                               kvm_arch_get_xen_version,
                               kvm_arch_set_xen_version,
                               NULL, NULL);
@@ -7115,14 +7115,16 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
                                           "(in XENVER_version form "
                                           "e.g. 0x4000a for 4.10)");
 
-    object_class_property_add(oc, "xen-gnttab-max-frames", "uint16", NULL,
+    object_class_property_add(oc, "xen-gnttab-max-frames", "uint16",
+                              &uint16_type_info,
                               kvm_arch_get_xen_gnttab_max_frames,
                               kvm_arch_set_xen_gnttab_max_frames,
                               NULL, NULL);
     object_class_property_set_description(oc, "xen-gnttab-max-frames",
                                           "Maximum number of grant table frames");
 
-    object_class_property_add(oc, "xen-evtchn-max-pirq", "uint16", NULL,
+    object_class_property_add(oc, "xen-evtchn-max-pirq", "uint16",
+                              &uint16_type_info,
                               kvm_arch_get_xen_evtchn_max_pirq,
                               kvm_arch_set_xen_evtchn_max_pirq,
                               NULL, NULL);
diff --git a/target/i386/sev.c b/target/i386/sev.c
index d19f98e1c7..c1c12d1125 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -3051,7 +3051,8 @@ sev_guest_instance_init(Object *obj)
     sev_guest->policy = DEFAULT_GUEST_POLICY;
     object_property_add_uint32_ptr(obj, "handle", &sev_guest->handle,
                                    OBJ_PROP_FLAG_READWRITE);
-    object_property_add(obj, "policy", "uint32", NULL, sev_guest_get_policy,
+    object_property_add(obj, "policy", "uint32", &uint32_type_info,
+                        sev_guest_get_policy,
                         sev_guest_set_policy, NULL, NULL);
     object_apply_compat_props(obj);
 
@@ -3329,7 +3330,7 @@ sev_snp_guest_class_init(ObjectClass *oc, const void *data)
     x86_klass->adjust_cpuid_features = sev_snp_adjust_cpuid_features;
     x86_klass->kvm_type = sev_snp_kvm_type;
 
-    object_class_property_add(oc, "policy", "uint64", NULL,
+    object_class_property_add(oc, "policy", "uint64", &uint64_type_info,
                               sev_snp_guest_get_policy,
                               sev_snp_guest_set_policy, NULL, NULL);
     object_class_property_add_str(oc, "guest-visible-workarounds",
@@ -3353,7 +3354,7 @@ sev_snp_guest_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "secure-tsc",
                                   sev_snp_guest_get_secure_tsc,
                                   sev_snp_guest_set_secure_tsc);
-    object_class_property_add(oc, "tsc-frequency", "uint32", NULL,
+    object_class_property_add(oc, "tsc-frequency", "uint32", &uint64_type_info,
                               sev_snp_guest_get_tsc_frequency,
                               sev_snp_guest_set_tsc_frequency, NULL, NULL);
 }
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 78f4b23122..8740c8727b 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -23,6 +23,7 @@
 #include "kvm_ppc.h"
 #include "system/cpus.h"
 #include "qemu/error-report.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "cpu-models.h"
@@ -335,7 +336,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
     gchar *names, *desc;
     int i;
 
-    object_property_add(obj, name, "string", NULL,
+    object_property_add(obj, name, "string", &str_type_info,
                         ppc_compat_prop_get, ppc_compat_prop_set, NULL,
                         compat_pvr);
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 85b674217e..adb53aad96 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -29,6 +29,7 @@
 #include "target/riscv/tcg/csr.h"
 #include "internals.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
@@ -1412,20 +1413,26 @@ void riscv_add_satp_mode_properties(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
 
-    object_property_add(obj, "svbare", "bool", NULL, cpu_riscv_get_satp,
+    object_property_add(obj, "svbare", "bool", &bool_type_info,
+                        cpu_riscv_get_satp,
                         cpu_riscv_set_satp, NULL, &cpu->satp_modes);
 
     if (cpu->env.misa_mxl == MXL_RV32) {
-        object_property_add(obj, "sv32", "bool", NULL, cpu_riscv_get_satp,
+        object_property_add(obj, "sv32", "bool", &bool_type_info,
+                            cpu_riscv_get_satp,
                             cpu_riscv_set_satp, NULL, &cpu->satp_modes);
     } else {
-        object_property_add(obj, "sv39", "bool", NULL, cpu_riscv_get_satp,
+        object_property_add(obj, "sv39", "bool", &bool_type_info,
+                            cpu_riscv_get_satp,
                             cpu_riscv_set_satp, NULL, &cpu->satp_modes);
-        object_property_add(obj, "sv48", "bool", NULL, cpu_riscv_get_satp,
+        object_property_add(obj, "sv48", "bool", &bool_type_info,
+                            cpu_riscv_get_satp,
                             cpu_riscv_set_satp, NULL, &cpu->satp_modes);
-        object_property_add(obj, "sv57", "bool", NULL, cpu_riscv_get_satp,
+        object_property_add(obj, "sv57", "bool", &bool_type_info,
+                            cpu_riscv_get_satp,
                             cpu_riscv_set_satp, NULL, &cpu->satp_modes);
-        object_property_add(obj, "sv64", "bool", NULL, cpu_riscv_get_satp,
+        object_property_add(obj, "sv64", "bool", &bool_type_info,
+                            cpu_riscv_get_satp,
                             cpu_riscv_set_satp, NULL, &cpu->satp_modes);
     }
 }
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 9bccd59809..21b675c74c 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -24,6 +24,7 @@
 
 #include "qemu/timer.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/target-info.h"
@@ -541,7 +542,7 @@ static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
      * unknown to KVM and error out if the user attempts
      * to enable any of them.
      */
-    object_property_add(obj, prop_name, "bool", NULL,
+    object_property_add(obj, prop_name, "bool", &bool_type_info,
                         cpu_get_cfg_unavailable,
                         cpu_set_cfg_unavailable,
                         NULL, (void *)prop_name);
@@ -561,7 +562,7 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
         misa_cfg->name = riscv_get_misa_ext_name(bit);
         misa_cfg->description = riscv_get_misa_ext_description(bit);
 
-        object_property_add(cpu_obj, misa_cfg->name, "bool", NULL,
+        object_property_add(cpu_obj, misa_cfg->name, "bool", &bool_type_info,
                             kvm_cpu_get_misa_ext_cfg,
                             kvm_cpu_set_misa_ext_cfg,
                             NULL, misa_cfg);
@@ -577,7 +578,7 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
     for (i = 0; i < ARRAY_SIZE(kvm_multi_ext_cfgs); i++) {
         KVMCPUConfig *multi_cfg = &kvm_multi_ext_cfgs[i];
 
-        object_property_add(cpu_obj, multi_cfg->name, "bool", NULL,
+        object_property_add(cpu_obj, multi_cfg->name, "bool", &bool_type_info,
                             kvm_cpu_get_multi_ext_cfg,
                             kvm_cpu_set_multi_ext_cfg,
                             NULL, multi_cfg);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index df73f45829..5834ec1524 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -26,6 +26,7 @@
 #include "pmu.h"
 #include "time_helper.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/accel.h"
 #include "qemu/error-report.h"
@@ -1478,7 +1479,7 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
             continue;
         }
 
-        object_property_add(cpu_obj, name, "bool", NULL,
+        object_property_add(cpu_obj, name, "bool", &bool_type_info,
                             cpu_get_misa_ext_cfg,
                             cpu_set_misa_ext_cfg,
                             NULL, (void *)misa_cfg);
@@ -1532,7 +1533,7 @@ static void riscv_cpu_add_profiles(Object *cpu_obj)
     for (int i = 0; riscv_profiles[i] != NULL; i++) {
         RISCVCPUProfile *profile = riscv_profiles[i];
 
-        object_property_add(cpu_obj, profile->name, "bool", NULL,
+        object_property_add(cpu_obj, profile->name, "bool", &bool_type_info,
                             cpu_get_profile, cpu_set_profile,
                             NULL, (void *)profile);
 
@@ -1608,7 +1609,7 @@ static void riscv_cpu_add_user_properties(Object *obj)
 
     for (edata = isa_edata_arr; edata && edata->name; edata++) {
         if (edata->prop_name) {
-            object_property_add(obj, edata->prop_name, "bool", NULL,
+            object_property_add(obj, edata->prop_name, "bool", &bool_type_info,
                                 cpu_get_multi_ext_cfg,
                                 cpu_set_multi_ext_cfg,
                                 NULL, (void *)&edata->ext_enable_offset);
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 0718df791f..abbfa96646 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -17,6 +17,7 @@
 #include "system/kvm.h"
 #include "system/tcg.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qemu/error-report.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
@@ -792,13 +793,14 @@ void s390_cpu_model_class_register_props(ObjectClass *oc)
 
     for (feat = 0; feat < S390_FEAT_MAX; feat++) {
         const S390FeatDef *def = s390_feat_def(feat);
-        object_class_property_add(oc, def->name, "bool", NULL, get_feature,
+        object_class_property_add(oc, def->name, "bool", &bool_type_info,
+                                  get_feature,
                                   set_feature, NULL, (void *) feat);
         object_class_property_set_description(oc, def->name, def->desc);
     }
     for (group = 0; group < S390_FEAT_GROUP_MAX; group++) {
         const S390FeatGroupDef *def = s390_feat_group_def(group);
-        object_class_property_add(oc, def->name, "bool", NULL,
+        object_class_property_add(oc, def->name, "bool", &bool_type_info,
                                   get_feature_group,
                                   set_feature_group, NULL, (void *) group);
         object_class_property_set_description(oc, def->name, def->desc);
diff --git a/tests/unit/test-qdev-global-props.c b/tests/unit/test-qdev-global-props.c
index 35fb5eca6f..e32c0eee55 100644
--- a/tests/unit/test-qdev-global-props.c
+++ b/tests/unit/test-qdev-global-props.c
@@ -27,6 +27,7 @@
 #include "hw/core/qdev-properties.h"
 #include "qom/object.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 
 
@@ -171,11 +172,11 @@ static void prop2_accessor(Object *obj, Visitor *v, const char *name,
 
 static void dynamic_instance_init(Object *obj)
 {
-    object_property_add(obj, "prop1", "uint32", NULL, prop1_accessor,
-                        prop1_accessor,
+    object_property_add(obj, "prop1", "uint32", &uint32_type_info,
+                        prop1_accessor, prop1_accessor,
                         NULL, NULL);
-    object_property_add(obj, "prop2", "uint32", NULL, prop2_accessor,
-                        prop2_accessor,
+    object_property_add(obj, "prop2", "uint32", &uint32_type_info,
+                        prop2_accessor, prop2_accessor,
                         NULL, NULL);
 }
 
diff --git a/ui/console.c b/ui/console.c
index 732b4afee0..c995abc5d1 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -28,6 +28,7 @@
 #include "ui/vgafont.h"
 #include "hw/core/qdev.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-commands-ui.h"
 #include "qapi/visitor.h"
 #include "qemu/coroutine.h"
@@ -535,7 +536,7 @@ qemu_graphic_console_class_init(ObjectClass *oc, const void *data)
                                    offsetof(QemuGraphicConsole, device),
                                    object_property_allow_set_link,
                                    OBJ_PROP_LINK_STRONG);
-    object_class_property_add(oc, "head", "uint32", NULL,
+    object_class_property_add(oc, "head", "uint32", &uint32_type_info,
                               qemu_graphic_console_prop_get_head,
                               NULL, NULL, NULL);
 
diff --git a/util/thread-context.c b/util/thread-context.c
index 4fe7a6c8f4..d653178048 100644
--- a/util/thread-context.c
+++ b/util/thread-context.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/thread-context.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/visitor.h"
 #include "qemu/config-file.h"
@@ -278,13 +279,16 @@ static void thread_context_class_init(ObjectClass *oc, const void *data)
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
     ucc->complete = thread_context_instance_complete;
-    object_class_property_add(oc, "thread-id", "uint64", NULL,
+    object_class_property_add(oc, "thread-id", "uint64",
+                              &uint64_type_info,
                               thread_context_get_thread_id, NULL, NULL,
                               NULL);
-    object_class_property_add(oc, "cpu-affinity", "[uint16]", NULL,
+    object_class_property_add(oc, "cpu-affinity", "[uint16]",
+                              &uint16List_type_info,
                               thread_context_get_cpu_affinity,
                               thread_context_set_cpu_affinity, NULL, NULL);
-    object_class_property_add(oc, "node-affinity", "[uint16]", NULL, NULL,
+    object_class_property_add(oc, "node-affinity", "[uint16]",
+                              &uint16List_type_info, NULL,
                               thread_context_set_node_affinity, NULL, NULL);
 }
 
-- 
2.55.0


