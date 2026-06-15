Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2807DCD98E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE6o-0003dD-9C; Mon, 15 Jun 2026 16:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE6l-0003Vm-Po
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:40:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZE6h-0002xr-JR
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781556031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZnnNupxWguigi8DRMAxMDfsERlDSYXV475GSx1RIrb4=;
 b=K9BTDqxA+EyQzsiun5rh8VDN/Wvjhj7Wnq+8CU3ry1ufe2st5edVu6QLi+7B3XvkaCzli+
 JVDAlKjzT+ghACcEdrN4+GI9JKjpX/+xiPZ/YJlz1jmYqwjwk4kinLUZNmmnC8puYyV6IC
 bLXwaaWoyu+e/fhZRUM3Dj5+9+a1fDM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-u-WVn10iN_6kim_QH5eSDw-1; Mon,
 15 Jun 2026 16:40:28 -0400
X-MC-Unique: u-WVn10iN_6kim_QH5eSDw-1
X-Mimecast-MFC-AGG-ID: u-WVn10iN_6kim_QH5eSDw_1781556027
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F62A19560BE; Mon, 15 Jun 2026 20:40:27 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F485180058F; Mon, 15 Jun 2026 20:40:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Jun 2026 00:37:57 +0400
Subject: [PATCH v2 31/53] qom: convert scalar properties to QAPI-aware
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-qom-qapi-v2-31-cc9396b9c18c@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=107033;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ZtFoZ0Tg0NsFu+Pz5mdVbvNDOMkxnRsR2dPQaERxVYA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMGKP44FqWYgW5C/4vZJTyeO67gOkjW8VAQfdB
 QSIZW9nuQGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajBijwAKCRDa6OEJdZac
 5bNfD/9VvZrrtZLlYAGMcKSpaXeKGCWbccHe5jGejP/NDnbS8b59Onhc20ysiftBUjRnAEpN3Ht
 CO1mBM8wD0wAijwyzxq/x7//C6vl1E/HEqFXV9r4DYhE9/xq9On7xtQV+rtIF8RStHgYdxYBIt+
 W6ZrKKUXpRURlgHB8RUBd35hr9WIiAvTWZ/2xMaumZY2AQ1Hz9QkLzhpog0u5Jmb2DycYW3M72w
 qxMMUcOHzdgJsOAtZUwyxiTOywKB+71Ouo/SmDreGls+55w1frOwf3/j/kc8m+7TcJugyCfZtL/
 mRaG+SzY/MlfvvrPgJj8DDAXSEraNqDImx5md/o6tr0w3l1baed2RrduafhdOx/5MfX2BCpG5IU
 emm9LQA/CKRjHMta0YPQTQB7FM8ZQh22Iv30zrmlkBHR60/AAAJgdD2IViuUzJ3sGmBGEMzQqyE
 Zsh3xfng+byT8O02xudCKebENxIVALG+ipN9/FCx+ZurDBDOH2p83Wj2KtT95544hVL/4UZYbTM
 zDnDpGEriJkLYbBJcFx9jahqFmNnLqpWPnCwq3wcxBc6XJ+Lys+LB7TUmnq6xvcJQk91sogXS99
 Cy0NsCeQ4JEdotWYirnqeYVxGYT/Oi8iuftIiR1S/vLjycJd+7Vc/2KNooxmT0IwfbatZjuEQBM
 uhQLBoOMZMk9PFQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 accel/kvm/kvm-all.c                 |  5 ++-
 accel/nitro/nitro-accel.c           |  3 +-
 accel/tcg/tcg-all.c                 |  3 +-
 backends/cryptodev.c                |  7 ++--
 backends/hostmem-file.c             |  4 +-
 backends/hostmem-memfd.c            |  3 +-
 backends/hostmem.c                  |  6 +--
 block/throttle-groups.c             |  5 ++-
 crypto/secret_keyring.c             |  9 +++--
 event-loop-base.c                   |  7 ++--
 hw/acpi/ich9.c                      |  3 +-
 hw/acpi/pci.c                       |  5 ++-
 hw/arm/virt.c                       |  4 +-
 hw/core/clock.c                     |  3 +-
 hw/core/machine.c                   |  2 +-
 hw/cpu/core.c                       | 10 +++--
 hw/cxl/cxl-host.c                   |  2 +-
 hw/gpio/aspeed_gpio.c               |  5 ++-
 hw/gpio/aspeed_sgpio.c              |  3 +-
 hw/gpio/pca9552.c                   |  6 ++-
 hw/gpio/pca9554.c                   |  6 ++-
 hw/gpio/stm32l4x5_gpio.c            |  5 ++-
 hw/i386/pc.c                        |  6 +--
 hw/i386/sgx-epc.c                   |  3 +-
 hw/i386/x86.c                       |  6 +--
 hw/ide/ide-dev.c                    |  3 +-
 hw/intc/apic_common.c               |  3 +-
 hw/loongarch/virt.c                 |  2 +-
 hw/mem/nvdimm.c                     |  7 ++--
 hw/mem/pc-dimm.c                    |  3 +-
 hw/misc/aspeed_lpc.c                | 73 +++++++++++++++++++++++++------------
 hw/misc/aspeed_sdmc.c               |  3 +-
 hw/misc/npcm7xx_mft.c               |  3 +-
 hw/net/ne2000-isa.c                 |  3 +-
 hw/nvme/ctrl.c                      |  3 +-
 hw/pci-bridge/pci_expander_bridge.c |  3 +-
 hw/pci-host/i440fx.c                | 35 ++++++++++--------
 hw/pci-host/pnv_phb3.c              |  5 ++-
 hw/pci-host/pnv_phb4.c              |  5 ++-
 hw/pci-host/q35.c                   |  9 +++--
 hw/ppc/spapr_drc.c                  |  3 +-
 hw/riscv/microchip_pfsoc.c          |  3 +-
 hw/s390x/sclpcpi.c                  |  8 ++--
 hw/s390x/virtio-ccw-mem.c           |  3 +-
 hw/sensor/adm1266.c                 |  3 +-
 hw/sensor/adm1272.c                 |  9 +++--
 hw/sensor/emc141x.c                 |  9 +++--
 hw/sensor/isl_pmbus_vr.c            | 19 +++++-----
 hw/sensor/lsm303dlhc_mag.c          |  9 +++--
 hw/sensor/max34451.c                |  5 ++-
 hw/sensor/tmp105.c                  |  3 +-
 hw/sensor/tmp421.c                  |  9 +++--
 hw/usb/dev-storage-classic.c        |  3 +-
 hw/virtio/virtio-balloon.c          |  3 +-
 hw/virtio/virtio-mem-pci.c          |  3 +-
 hw/virtio/virtio-mem.c              | 18 +++++----
 hw/xen/xen-pvh-common.c             |  9 +++--
 iothread.c                          |  9 +++--
 net/colo-compare.c                  |  7 ++--
 net/dump.c                          |  6 ++-
 net/filter-buffer.c                 |  3 +-
 qom/object.c                        | 42 ++++++++++-----------
 system/bootdevice.c                 |  3 +-
 system/memory.c                     |  5 ++-
 target/arm/cpu64.c                  | 11 +++---
 target/arm/kvm.c                    |  3 +-
 target/arm/tcg/cpu64.c              |  5 ++-
 target/i386/cpu.c                   | 12 +++---
 target/i386/kvm/kvm.c               |  8 ++--
 target/i386/sev.c                   |  2 +-
 target/ppc/compat.c                 |  3 +-
 target/riscv/cpu.c                  | 11 +++---
 target/riscv/kvm/kvm-cpu.c          |  7 ++--
 target/riscv/tcg/tcg-cpu.c          |  5 ++-
 target/s390x/cpu_models.c           |  5 ++-
 tests/unit/test-qdev-global-props.c | 11 ++++--
 ui/console.c                        |  3 +-
 util/thread-context.c               |  7 ++--
 78 files changed, 335 insertions(+), 233 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 14e3c7fcc80..0742c9bb52c 100644
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
@@ -4306,13 +4307,13 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
         .description = "Configure KVM in-kernel irqchip",
     ));
 
-    object_class_property_add(oc, "kvm-shadow-mem", "int",
+    object_class_property_add_qapi(oc, "kvm-shadow-mem", &int_type_info,
         kvm_get_kvm_shadow_mem, kvm_set_kvm_shadow_mem,
         NULL, NULL);
     object_class_property_set_description(oc, "kvm-shadow-mem",
         "KVM shadow MMU size");
 
-    object_class_property_add(oc, "dirty-ring-size", "uint32",
+    object_class_property_add_qapi(oc, "dirty-ring-size", &uint32_type_info,
         kvm_get_dirty_ring_size, kvm_set_dirty_ring_size,
         NULL, NULL);
     object_class_property_set_description(oc, "dirty-ring-size",
diff --git a/accel/nitro/nitro-accel.c b/accel/nitro/nitro-accel.c
index a1e97a9162e..05841c1277d 100644
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
@@ -238,7 +239,7 @@ static void nitro_accel_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "debug-mode",
         "Start enclave in debug mode (enables console output)");
 
-    object_class_property_add(oc, "enclave-cid", "uint64",
+    object_class_property_add_qapi(oc, "enclave-cid", &uint64_type_info,
                               nitro_get_enclave_cid,
                               nitro_set_enclave_cid,
                               NULL, NULL);
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 8eb4a6b89e8..4e9d7a1da33 100644
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
@@ -272,7 +273,7 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
                                   tcg_get_thread,
                                   tcg_set_thread);
 
-    object_class_property_add(oc, "tb-size", "int",
+    object_class_property_add_qapi(oc, "tb-size", &int_type_info,
         tcg_get_tb_size, tcg_set_tb_size,
         NULL, NULL);
     object_class_property_set_description(oc, "tb-size",
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 79f8882d3be..014774d60fd 100644
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
@@ -616,15 +617,15 @@ cryptodev_backend_class_init(ObjectClass *oc, const void *data)
     ucc->can_be_deleted = cryptodev_backend_can_be_deleted;
 
     QTAILQ_INIT(&crypto_clients);
-    object_class_property_add(oc, "queues", "uint32",
+    object_class_property_add_qapi(oc, "queues", &uint32_type_info,
                               cryptodev_backend_get_queues,
                               cryptodev_backend_set_queues,
                               NULL, NULL);
-    object_class_property_add(oc, "throttle-bps", "uint64",
+    object_class_property_add_qapi(oc, "throttle-bps", &uint64_type_info,
                               cryptodev_backend_get_bps,
                               cryptodev_backend_set_bps,
                               NULL, NULL);
-    object_class_property_add(oc, "throttle-ops", "uint64",
+    object_class_property_add_qapi(oc, "throttle-ops", &uint64_type_info,
                               cryptodev_backend_get_ops,
                               cryptodev_backend_set_ops,
                               NULL, NULL);
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 52b62f71533..399aae02e2c 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -275,11 +275,11 @@ file_backend_class_init(ObjectClass *oc, const void *data)
         file_memory_backend_get_discard_data, file_memory_backend_set_discard_data);
     object_class_property_add_str(oc, "mem-path",
         get_mem_path, set_mem_path);
-    object_class_property_add(oc, "align", "int",
+    object_class_property_add_qapi(oc, "align", &int_type_info,
         file_memory_backend_get_align,
         file_memory_backend_set_align,
         NULL, NULL);
-    object_class_property_add(oc, "offset", "int",
+    object_class_property_add_qapi(oc, "offset", &int_type_info,
         file_memory_backend_get_offset,
         file_memory_backend_set_offset,
         NULL, NULL);
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 923239f9cf6..ab069a70379 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -16,6 +16,7 @@
 #include "qemu/memfd.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qom/object.h"
 #include "migration/cpr.h"
 
@@ -145,7 +146,7 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
                                        memfd_backend_set_hugetlb);
         object_class_property_set_description(oc, "hugetlb",
                                               "Use huge pages");
-        object_class_property_add(oc, "hugetlbsize", "int",
+        object_class_property_add_qapi(oc, "hugetlbsize", &int_type_info,
                                   memfd_backend_get_hugetlbsize,
                                   memfd_backend_set_hugetlbsize,
                                   NULL, NULL);
diff --git a/backends/hostmem.c b/backends/hostmem.c
index d0977552b40..ab20e9b79dc 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -526,7 +526,7 @@ host_memory_backend_class_init(ObjectClass *oc, const void *data)
         host_memory_backend_set_prealloc);
     object_class_property_set_description(oc, "prealloc",
         "Preallocate memory");
-    object_class_property_add(oc, "prealloc-threads", "int",
+    object_class_property_add_qapi(oc, "prealloc-threads", &int_type_info,
         host_memory_backend_get_prealloc_threads,
         host_memory_backend_set_prealloc_threads,
         NULL, NULL);
@@ -537,13 +537,13 @@ host_memory_backend_class_init(ObjectClass *oc, const void *data)
         object_property_allow_set_link, OBJ_PROP_LINK_STRONG);
     object_class_property_set_description(oc, "prealloc-context",
         "Context to use for creating CPU threads for preallocation");
-    object_class_property_add(oc, "size", "int",
+    object_class_property_add_qapi(oc, "size", &int_type_info,
         host_memory_backend_get_size,
         host_memory_backend_set_size,
         NULL, NULL);
     object_class_property_set_description(oc, "size",
         "Size of the memory region (ex: 500M)");
-    object_class_property_add(oc, "host-nodes", "int",
+    object_class_property_add_qapi(oc, "host-nodes", &int_type_info,
         host_memory_backend_get_host_nodes,
         host_memory_backend_set_host_nodes,
         NULL, NULL);
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index b161576432a..2a17ae79f74 100644
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
@@ -977,9 +978,9 @@ static void throttle_group_obj_class_init(ObjectClass *klass,
 
     /* individual properties */
     for (i = 0; i < sizeof(properties) / sizeof(ThrottleParamInfo); i++) {
-        object_class_property_add(klass,
+        object_class_property_add_qapi(klass,
                                   properties[i].name,
-                                  "int",
+                                  &int_type_info,
                                   throttle_group_get,
                                   throttle_group_set,
                                   NULL, &properties[i]);
diff --git a/crypto/secret_keyring.c b/crypto/secret_keyring.c
index 78d7f09b3b9..de813e79d8d 100644
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
@@ -108,10 +109,10 @@ qcrypto_secret_keyring_class_init(ObjectClass *oc, const void *data)
     QCryptoSecretCommonClass *sic = QCRYPTO_SECRET_COMMON_CLASS(oc);
     sic->load_data = qcrypto_secret_keyring_load_data;
 
-    object_class_property_add(oc, "serial", "int32_t",
-                                  qcrypto_secret_prop_get_key,
-                                  qcrypto_secret_prop_set_key,
-                                  NULL, NULL);
+    object_class_property_add_qapi(oc, "serial", &int32_type_info,
+                                   qcrypto_secret_prop_get_key,
+                                   qcrypto_secret_prop_set_key,
+                                   NULL, NULL);
 }
 
 
diff --git a/event-loop-base.c b/event-loop-base.c
index 8ca143bea43..284f2f56b85 100644
--- a/event-loop-base.c
+++ b/event-loop-base.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qom/object_interfaces.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "block/thread-pool.h"
 #include "system/event-loop-base.h"
 
@@ -104,15 +105,15 @@ static void event_loop_base_class_init(ObjectClass *klass,
     ucc->complete = event_loop_base_complete;
     ucc->can_be_deleted = event_loop_base_can_be_deleted;
 
-    object_class_property_add(klass, "aio-max-batch", "int",
+    object_class_property_add_qapi(klass, "aio-max-batch", &int_type_info,
                               event_loop_base_get_param,
                               event_loop_base_set_param,
                               NULL, &aio_max_batch_info);
-    object_class_property_add(klass, "thread-pool-min", "int",
+    object_class_property_add_qapi(klass, "thread-pool-min", &int_type_info,
                               event_loop_base_get_param,
                               event_loop_base_set_param,
                               NULL, &thread_pool_min_info);
-    object_class_property_add(klass, "thread-pool-max", "int",
+    object_class_property_add_qapi(klass, "thread-pool-max", &int_type_info,
                               event_loop_base_get_param,
                               event_loop_base_set_param,
                               NULL, &thread_pool_max_info);
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 5c7dfb2c69d..f8196c771f2 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -26,6 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
@@ -405,7 +406,7 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
                              (Object **)&pm->acpi_pci_hotplug.root,
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG);
-    object_property_add(obj, ACPI_PM_PROP_GPE0_BLK, "uint32",
+    object_property_add_qapi(obj, ACPI_PM_PROP_GPE0_BLK, &uint32_type_info,
                         ich9_pm_get_gpe0_blk,
                         NULL, NULL, pm);
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index 8c7ed104796..727f3aade4a 100644
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
-    object_class_property_add(oc, "node", "int", NULL,
+    object_class_property_add_qapi(oc, "node", &int_type_info, NULL,
         acpi_generic_initiator_set_node, NULL, NULL);
     object_class_property_set_description(oc, "node",
         "NUMA node associated with the PCI device");
@@ -253,7 +254,7 @@ static void acpi_generic_port_class_init(ObjectClass *oc, const void *data)
         acpi_generic_port_set_pci_bus);
     object_class_property_set_description(oc, "pci-bus",
        "PCI Bus of the host bridge associated with this GP affinity structure");
-    object_class_property_add(oc, "node", "int", NULL,
+    object_class_property_add_qapi(oc, "node", &int_type_info, NULL,
         acpi_generic_port_set_node, NULL, NULL);
     object_class_property_set_description(oc, "node",
        "The NUMA node like ID to index HMAT/SLIT NUMA properties involving GP");
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 295cc053768..0c793fdcf15 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4175,7 +4175,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set on/off to enable/disable high "
                                           "memory region for PCI MMIO");
 
-    object_class_property_add(oc, "highmem-mmio-size", "size",
+    object_class_property_add_qapi(oc, "highmem-mmio-size", &size_type_info,
                                    virt_get_highmem_mmio_size,
                                    virt_set_highmem_mmio_size,
                                    NULL, NULL);
@@ -4183,7 +4183,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set the high memory region size "
                                           "for PCI MMIO");
 
-    object_class_property_add(oc, "virtio-mmio-transports", "uint8",
+    object_class_property_add_qapi(oc, "virtio-mmio-transports", &uint8_type_info,
                                    virt_get_virtio_transports,
                                    virt_set_virtio_transports,
                                    NULL, NULL);
diff --git a/hw/core/clock.c b/hw/core/clock.c
index 3fc98a0c65d..f55cb17af77 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "system/qtest.h"
 #include "hw/core/clock.h"
@@ -185,7 +186,7 @@ static void clock_initfn(Object *obj)
     QLIST_INIT(&clk->children);
 
     if (qtest_enabled()) {
-        object_property_add(obj, "qtest-clock-period", "uint64",
+        object_property_add_qapi(obj, "qtest-clock-period", &uint64_type_info,
                             clock_period_prop_get, NULL, NULL, NULL);
     }
 }
diff --git a/hw/core/machine.c b/hw/core/machine.c
index e3075592673..354e557d822 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1117,7 +1117,7 @@ static void machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "smp-cache",
         "Cache properties list for SMP machine");
 
-    object_class_property_add(oc, "phandle-start", "int",
+    object_class_property_add_qapi(oc, "phandle-start", &int_type_info,
         machine_get_phandle_start, machine_set_phandle_start,
         NULL, NULL);
     object_class_property_set_description(oc, "phandle-start",
diff --git a/hw/cpu/core.c b/hw/cpu/core.c
index 26e488f3d8e..d7c89f47ab0 100644
--- a/hw/cpu/core.c
+++ b/hw/cpu/core.c
@@ -12,6 +12,7 @@
 #include "hw/core/boards.h"
 #include "hw/cpu/core.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 
 static void core_prop_get_core_id(Object *obj, Visitor *v, const char *name,
@@ -82,10 +83,11 @@ static void cpu_core_class_init(ObjectClass *oc, const void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     set_bit(DEVICE_CATEGORY_CPU, dc->categories);
-    object_class_property_add(oc, "core-id", "int", core_prop_get_core_id,
-                              core_prop_set_core_id, NULL, NULL);
-    object_class_property_add(oc, "nr-threads", "int", core_prop_get_nr_threads,
-                              core_prop_set_nr_threads, NULL, NULL);
+    object_class_property_add_qapi(oc, "core-id", &int_type_info, core_prop_get_core_id,
+                                   core_prop_set_core_id, NULL, NULL);
+    object_class_property_add_qapi(oc, "nr-threads", &int_type_info,
+                                   core_prop_get_nr_threads, core_prop_set_nr_threads,
+                                   NULL, NULL);
 }
 
 static const TypeInfo cpu_core_type_info = {
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 87067b94b34..e94ce29a00f 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -345,7 +345,7 @@ static void machine_set_cfmw(Object *obj, Visitor *v, const char *name,
 
 void cxl_machine_init(Object *obj, CXLState *state)
 {
-    object_property_add(obj, "cxl", "bool", machine_get_cxl,
+    object_property_add_qapi(obj, "cxl", &bool_type_info, machine_get_cxl,
                         machine_set_cxl, NULL, state);
     object_property_set_description(obj, "cxl",
                                     "Set on/off to enable/disable "
diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index 1cf6f5df550..0c90bcd723d 100644
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
@@ -1481,7 +1482,7 @@ static void aspeed_gpio_init(Object *obj)
             int pin_idx = j % GPIOS_PER_GROUP;
             const char *group = &props->group_label[group_idx][0];
             char *name = g_strdup_printf("gpio%s%d", group, pin_idx);
-            object_property_add(obj, name, "bool", aspeed_gpio_get_pin,
+            object_property_add_qapi(obj, name, &bool_type_info, aspeed_gpio_get_pin,
                                 aspeed_gpio_set_pin, NULL, NULL);
             g_free(name);
         }
@@ -1489,7 +1490,7 @@ static void aspeed_gpio_init(Object *obj)
 
     for (int i = 0; i < agc->nr_gpio_sets; i++) {
         g_autofree char *name = g_strdup_printf("gpio-set[%d]", i);
-        object_property_add(obj, name, "uint32", aspeed_gpio_get_set,
+        object_property_add_qapi(obj, name, &uint32_type_info, aspeed_gpio_get_set,
         aspeed_gpio_set_set, NULL, NULL);
     }
 }
diff --git a/hw/gpio/aspeed_sgpio.c b/hw/gpio/aspeed_sgpio.c
index 7d2f7369952..67b0c10d79f 100644
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
@@ -300,7 +301,7 @@ static void aspeed_sgpio_init(Object *obj)
 {
     for (int i = 0; i < ASPEED_SGPIO_MAX_PIN_PAIR * 2; i++) {
         g_autofree char *name = g_strdup_printf("sgpio%03d", i);
-        object_property_add(obj, name, "bool", aspeed_sgpio_get_pin,
+        object_property_add_qapi(obj, name, &bool_type_info, aspeed_sgpio_get_pin,
                             aspeed_sgpio_set_pin, NULL, NULL);
     }
 }
diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 472d8ad9571..5d55bd32ef4 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -20,6 +20,7 @@
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "trace.h"
 #include "qom/object.h"
@@ -437,8 +438,9 @@ static void pca955x_initfn(Object *obj)
         char *name;
 
         name = g_strdup_printf("led%d", led);
-        object_property_add(obj, name, "bool", pca955x_get_led, pca955x_set_led,
-                            NULL, NULL);
+        object_property_add_qapi(obj, name, &bool_type_info,
+                                 pca955x_get_led, pca955x_set_led,
+                                 NULL, NULL);
         g_free(name);
     }
 }
diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index 8427e01e9b2..8ec1f94bb5c 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -16,6 +16,7 @@
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "trace.h"
 #include "qom/object.h"
@@ -253,8 +254,9 @@ static void pca9554_initfn(Object *obj)
         char *name;
 
         name = g_strdup_printf("pin%d", pin);
-        object_property_add(obj, name, "bool", pca9554_get_pin, pca9554_set_pin,
-                            NULL, NULL);
+        object_property_add_qapi(obj, name, &bool_type_info,
+                                 pca9554_get_pin, pca9554_set_pin,
+                                 NULL, NULL);
         g_free(name);
     }
 }
diff --git a/hw/gpio/stm32l4x5_gpio.c b/hw/gpio/stm32l4x5_gpio.c
index 92fa397fbaf..d349d41e41a 100644
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
 
-    object_property_add(obj, "disconnected-pins", "uint16",
+    object_property_add_qapi(obj, "disconnected-pins", &uint16_type_info,
                         disconnected_pins_get, disconnected_pins_set,
                         NULL, &s->disconnected_pins);
-    object_property_add(obj, "clock-freq-hz", "uint32",
+    object_property_add_qapi(obj, "clock-freq-hz", &uint32_type_info,
                         clock_freq_get, NULL, NULL, NULL);
 }
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 836a26cc72f..86f20477524 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1680,7 +1680,7 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_id = "pc.ram";
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_AUTO;
 
-    object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
+    object_class_property_add_qapi(oc, PC_MACHINE_MAX_RAM_BELOW_4G, &size_type_info,
         pc_machine_get_max_ram_below_4g, pc_machine_set_max_ram_below_4g,
         NULL, NULL);
     object_class_property_set_description(oc, PC_MACHINE_MAX_RAM_BELOW_4G,
@@ -1718,13 +1718,13 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
         pc_machine_get_default_bus_bypass_iommu,
         pc_machine_set_default_bus_bypass_iommu);
 
-    object_class_property_add(oc, PC_MACHINE_MAX_FW_SIZE, "size",
+    object_class_property_add_qapi(oc, PC_MACHINE_MAX_FW_SIZE, &size_type_info,
         pc_machine_get_max_fw_size, pc_machine_set_max_fw_size,
         NULL, NULL);
     object_class_property_set_description(oc, PC_MACHINE_MAX_FW_SIZE,
         "Maximum combined firmware size");
 
-    object_class_property_add(oc, PC_MACHINE_SMBIOS_EP, "str",
+    object_class_property_add_qapi(oc, PC_MACHINE_SMBIOS_EP, &str_type_info,
         pc_machine_get_smbios_ep, pc_machine_set_smbios_ep,
         NULL, NULL);
     object_class_property_set_description(oc, PC_MACHINE_SMBIOS_EP,
diff --git a/hw/i386/sgx-epc.c b/hw/i386/sgx-epc.c
index d3fe10028c5..d9b9ab3f7a9 100644
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
@@ -43,7 +44,7 @@ static void sgx_epc_get_size(Object *obj, Visitor *v, const char *name,
 
 static void sgx_epc_init(Object *obj)
 {
-    object_property_add(obj, SGX_EPC_SIZE_PROP, "uint64", sgx_epc_get_size,
+    object_property_add_qapi(obj, SGX_EPC_SIZE_PROP, &uint64_type_info, sgx_epc_get_size,
                         NULL, NULL, NULL);
 }
 
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 155763b1c98..361286019f5 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -420,9 +420,9 @@ static void x86_machine_class_init(ObjectClass *oc, const void *data)
                                           "in ACPI table header."
                                           "The string may be up to 8 bytes in size");
 
-    object_class_property_add(oc, X86_MACHINE_BUS_LOCK_RATELIMIT, "uint64_t",
-                                x86_machine_get_bus_lock_ratelimit,
-                                x86_machine_set_bus_lock_ratelimit, NULL, NULL);
+    object_class_property_add_qapi(oc, X86_MACHINE_BUS_LOCK_RATELIMIT, &uint64_type_info,
+                                   x86_machine_get_bus_lock_ratelimit,
+                                   x86_machine_set_bus_lock_ratelimit, NULL, NULL);
     object_class_property_set_description(oc, X86_MACHINE_BUS_LOCK_RATELIMIT,
             "Set the ratelimit for the bus locks acquired in VMs");
 
diff --git a/hw/ide/ide-dev.c b/hw/ide/ide-dev.c
index 5d478588c61..e2dd2439991 100644
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
-    object_property_add(obj, "bootindex", "int32",
+    object_property_add_qapi(obj, "bootindex", &int32_type_info,
                         ide_dev_get_bootindex,
                         ide_dev_set_bootindex, NULL, NULL);
     object_property_set_int(obj, "bootindex", -1, NULL);
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 49c03a5bcee..43ed8cc29f0 100644
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
-    object_property_add(obj, "id", "uint32",
+    object_property_add_qapi(obj, "id", &uint32_type_info,
                         apic_common_get_id,
                         apic_common_set_id, NULL, NULL);
 }
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 5b99c95fec9..1d678c7ae35 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1521,7 +1521,7 @@ static void virt_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "highmem-mmio",
                                           "Set on/off to enable/disable high "
                                           "memory region for PCI MMIO");
-    object_class_property_add(oc, "highmem-mmio-size", "size",
+    object_class_property_add_qapi(oc, "highmem-mmio-size", &size_type_info,
                                    virt_get_highmem_mmio_size,
                                    virt_set_highmem_mmio_size,
                                    NULL, NULL);
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index cf8a4d8c5f2..123ddc93854 100644
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
@@ -99,9 +100,9 @@ static void nvdimm_set_uuid(Object *obj, Visitor *v, const char *name,
 
 static void nvdimm_init(Object *obj)
 {
-    object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "size",
-                        nvdimm_get_label_size, nvdimm_set_label_size, NULL,
-                        NULL);
+    object_property_add_qapi(obj, NVDIMM_LABEL_SIZE_PROP, &size_type_info,
+                             nvdimm_get_label_size, nvdimm_set_label_size, NULL,
+                             NULL);
 
     object_property_add(obj, NVDIMM_UUID_PROP, "QemuUUID", nvdimm_get_uuid,
                         nvdimm_set_uuid, NULL, NULL);
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 3efe47f499a..1328f1cfec0 100644
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
-    object_property_add(obj, PC_DIMM_SIZE_PROP, "uint64", pc_dimm_get_size,
+    object_property_add_qapi(obj, PC_DIMM_SIZE_PROP, &uint64_type_info, pc_dimm_get_size,
                         NULL, NULL, NULL);
 }
 
diff --git a/hw/misc/aspeed_lpc.c b/hw/misc/aspeed_lpc.c
index 7f7e4f1a098..e2d9b7572f2 100644
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
@@ -417,30 +418,54 @@ static void aspeed_lpc_realize(DeviceState *dev, Error **errp)
 
 static void aspeed_lpc_init(Object *obj)
 {
-    object_property_add(obj, "idr1", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "odr1", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "str1", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "idr2", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "odr2", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "str2", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "idr3", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "odr3", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "str3", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "idr4", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "odr4", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
-    object_property_add(obj, "str4", "uint32", aspeed_kcs_get_register_property,
-                        aspeed_kcs_set_register_property, NULL, NULL);
+    object_property_add_qapi(obj, "idr1", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "odr1", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "str1", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "idr2", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "odr2", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "str2", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "idr3", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "odr3", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "str3", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "idr4", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "odr4", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "str4", &uint32_type_info,
+                             aspeed_kcs_get_register_property,
+                             aspeed_kcs_set_register_property,
+                             NULL, NULL);
 }
 
 static const VMStateDescription vmstate_aspeed_lpc = {
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index f8fbaebee6a..d096cc88f5c 100644
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
-    object_property_add(obj, "ram-size", "int",
+    object_property_add_qapi(obj, "ram-size", &int_type_info,
                         aspeed_sdmc_get_ram_size, aspeed_sdmc_set_ram_size,
                         NULL, NULL);
 }
diff --git a/hw/misc/npcm7xx_mft.c b/hw/misc/npcm7xx_mft.c
index 742166c4e82..99e9e49788c 100644
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
-        object_property_add(obj, "max_rpm[*]", "uint32",
+        object_property_add_qapi(obj, "max_rpm[*]", &uint32_type_info,
                             npcm7xx_mft_get_max_rpm,
                             npcm7xx_mft_set_max_rpm,
                             NULL, &s->max_rpm[i]);
diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
index 673c785abc9..63e0d40ee72 100644
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
-    object_property_add(obj, "bootindex", "int32",
+    object_property_add_qapi(obj, "bootindex", &int32_type_info,
                         isa_ne2000_get_bootindex,
                         isa_ne2000_set_bootindex, NULL, NULL);
     object_property_set_int(obj, "bootindex", -1, NULL);
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 815f39173c8..74f209946a2 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -202,6 +202,7 @@
 #include "qemu/units.h"
 #include "qemu/range.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "system/system.h"
 #include "system/block-backend.h"
@@ -9561,7 +9562,7 @@ static void nvme_instance_init(Object *obj)
                                   "bootindex", "/namespace@1,0",
                                   DEVICE(obj));
 
-    object_property_add(obj, "smart_critical_warning", "uint8",
+    object_property_add_qapi(obj, "smart_critical_warning", &uint8_type_info,
                         nvme_get_smart_warning,
                         nvme_set_smart_warning, NULL, NULL);
 }
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 40ffbc4e082..9bb7d3c9deb 100644
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
 
-    object_class_property_add(class, "acpi_uid", "uint32",
+    object_class_property_add_qapi(class, "acpi_uid", &uint32_type_info,
                               prop_pxb_uid_get, NULL, NULL, NULL);
     object_class_property_set_description(class, "acpi_uid",
         "ACPI Unique ID used to distinguish this PCI Host Bridge / ACPI00016");
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index c1982f7962a..feafa6a72fe 100644
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
@@ -387,21 +388,25 @@ static void i440fx_pcihost_class_init(ObjectClass *klass, const void *data)
     /* Reason: needs to be wired up by pc_init1 */
     dc->user_creatable = false;
 
-    object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
-                              i440fx_pcihost_get_pci_hole_start,
-                              NULL, NULL, NULL);
-
-    object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
-                              i440fx_pcihost_get_pci_hole_end,
-                              NULL, NULL, NULL);
-
-    object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
-                              i440fx_pcihost_get_pci_hole64_start,
-                              NULL, NULL, NULL);
-
-    object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
-                              i440fx_pcihost_get_pci_hole64_end,
-                              NULL, NULL, NULL);
+    object_class_property_add_qapi(klass, PCI_HOST_PROP_PCI_HOLE_START,
+                                   &uint32_type_info,
+                                   i440fx_pcihost_get_pci_hole_start,
+                                   NULL, NULL, NULL);
+
+    object_class_property_add_qapi(klass, PCI_HOST_PROP_PCI_HOLE_END,
+                                   &uint32_type_info,
+                                   i440fx_pcihost_get_pci_hole_end,
+                                   NULL, NULL, NULL);
+
+    object_class_property_add_qapi(klass, PCI_HOST_PROP_PCI_HOLE64_START,
+                                   &uint64_type_info,
+                                   i440fx_pcihost_get_pci_hole64_start,
+                                   NULL, NULL, NULL);
+
+    object_class_property_add_qapi(klass, PCI_HOST_PROP_PCI_HOLE64_END,
+                                   &uint64_type_info,
+                                   i440fx_pcihost_get_pci_hole64_end,
+                                   NULL, NULL, NULL);
 }
 
 static const TypeInfo i440fx_pcihost_info = {
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index d6ab5153374..9af3059900f 100644
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
@@ -1154,12 +1155,12 @@ static void pnv_phb3_root_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
-    object_class_property_add(klass, "phb-id", "int",
+    object_class_property_add_qapi(klass, "phb-id", &int_type_info,
                               pnv_phb3_root_bus_get_prop,
                               pnv_phb3_root_bus_set_prop,
                               NULL, NULL);
 
-    object_class_property_add(klass, "chip-id", "int",
+    object_class_property_add_qapi(klass, "chip-id", &int_type_info,
                               pnv_phb3_root_bus_get_prop,
                               pnv_phb3_root_bus_set_prop,
                               NULL, NULL);
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 396bc47817d..e301a54bab5 100644
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
@@ -1766,12 +1767,12 @@ static void pnv_phb4_root_bus_class_init(ObjectClass *klass, const void *data)
 {
     BusClass *k = BUS_CLASS(klass);
 
-    object_class_property_add(klass, "phb-id", "int",
+    object_class_property_add_qapi(klass, "phb-id", &int_type_info,
                               pnv_phb4_root_bus_get_prop,
                               pnv_phb4_root_bus_set_prop,
                               NULL, NULL);
 
-    object_class_property_add(klass, "chip-id", "int",
+    object_class_property_add_qapi(klass, "chip-id", &int_type_info,
                               pnv_phb4_root_bus_get_prop,
                               pnv_phb4_root_bus_set_prop,
                               NULL, NULL);
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 355e81bfa20..b952e81fd5b 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -35,6 +35,7 @@
 #include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
 
@@ -226,19 +227,19 @@ static void q35_host_initfn(Object *obj)
     qdev_prop_set_uint64(DEVICE(s), PCI_HOST_PROP_PCI_HOLE64_SIZE,
                          Q35_PCI_HOST_HOLE64_SIZE_DEFAULT);
 
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
+    object_property_add_qapi(obj, PCI_HOST_PROP_PCI_HOLE_START, &uint32_type_info,
                         q35_host_get_pci_hole_start,
                         NULL, NULL, NULL);
 
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
+    object_property_add_qapi(obj, PCI_HOST_PROP_PCI_HOLE_END, &uint32_type_info,
                         q35_host_get_pci_hole_end,
                         NULL, NULL, NULL);
 
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
+    object_property_add_qapi(obj, PCI_HOST_PROP_PCI_HOLE64_START, &uint64_type_info,
                         q35_host_get_pci_hole64_start,
                         NULL, NULL, NULL);
 
-    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
+    object_property_add_qapi(obj, PCI_HOST_PROP_PCI_HOLE64_END, &uint64_type_info,
                         q35_host_get_pci_hole64_end,
                         NULL, NULL, NULL);
 
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 9bc65c760ea..62baf38a00e 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qobject/qnull.h"
 #include "qemu/cutils.h"
 #include "hw/ppc/spapr_drc.h"
@@ -583,7 +584,7 @@ static void spapr_dr_connector_instance_init(Object *obj)
     SpaprDrcClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
     object_property_add_uint32_ptr(obj, "id", &drc->id, OBJ_PROP_FLAG_READ);
-    object_property_add(obj, "index", "uint32", prop_get_index,
+    object_property_add_qapi(obj, "index", &uint32_type_info, prop_get_index,
                         NULL, NULL, NULL);
     object_property_add(obj, "fdt", "struct", prop_get_fdt,
                         NULL, NULL, NULL);
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 5e48a297083..37319cb0699 100644
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
@@ -738,7 +739,7 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc,
      */
     mc->default_ram_size = 1537 * MiB;
 
-    object_class_property_add(oc, "clint-timebase-frequency", "uint32_t",
+    object_class_property_add_qapi(oc, "clint-timebase-frequency", &uint32_type_info,
                               microchip_icicle_kit_get_clint_timebase_freq,
                               microchip_icicle_kit_set_clint_timebase_freq,
                               NULL, NULL);
diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
index 68fc1b809bf..307eba9f765 100644
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
@@ -190,12 +191,13 @@ static void cpi_class_init(ObjectClass *klass, const void *data)
             "name of the cluster which the VM belongs to, if any"
             " e.g. \"PLEX    \"");
 
-    object_class_property_add(klass, "system_level", "uint64", get_system_level,
-                              NULL, NULL, NULL);
+    object_class_property_add_qapi(klass, "system_level",
+                                   &uint64_type_info, get_system_level,
+                                   NULL, NULL, NULL);
     object_class_property_set_description(klass, "system_level",
             "distribution and kernel version in Linux e.g. 74872343805430528");
 
-    object_class_property_add(klass, "timestamp", "uint64", get_timestamp,
+    object_class_property_add_qapi(klass, "timestamp", &uint64_type_info, get_timestamp,
                               NULL, NULL, NULL);
     object_class_property_set_description(klass, "timestamp",
             "latest update of CPI data in nanoseconds since the UNIX EPOCH");
diff --git a/hw/s390x/virtio-ccw-mem.c b/hw/s390x/virtio-ccw-mem.c
index dea30aacfb3..046dfd544cf 100644
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
@@ -205,7 +206,7 @@ static void virtio_ccw_mem_instance_init(Object *obj)
                               OBJECT(&dev->vdev), VIRTIO_MEM_BLOCK_SIZE_PROP);
     object_property_add_alias(obj, VIRTIO_MEM_SIZE_PROP, OBJECT(&dev->vdev),
                               VIRTIO_MEM_SIZE_PROP);
-    object_property_add(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, "size",
+    object_property_add_qapi(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, &size_type_info,
                         virtio_ccw_mem_get_requested_size,
                         virtio_ccw_mem_set_requested_size, NULL, NULL);
 }
diff --git a/hw/sensor/adm1266.c b/hw/sensor/adm1266.c
index 37d1cffd57a..62f563af7a7 100644
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
 
-        object_property_add(obj, "vout[*]", "uint16",
+        object_property_add_qapi(obj, "vout[*]", &uint16_type_info,
                             adm1266_get,
                             adm1266_set, NULL, &pmdev->pages[i].read_vout);
     }
diff --git a/hw/sensor/adm1272.c b/hw/sensor/adm1272.c
index 0aa2a865568..e1c1bf1c54d 100644
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
 
-    object_property_add(obj, "vin", "uint16",
+    object_property_add_qapi(obj, "vin", &uint16_type_info,
                         adm1272_get,
                         adm1272_set, NULL, &pmdev->pages[0].read_vin);
 
-    object_property_add(obj, "vout", "uint16",
+    object_property_add_qapi(obj, "vout", &uint16_type_info,
                         adm1272_get,
                         adm1272_set, NULL, &pmdev->pages[0].read_vout);
 
-    object_property_add(obj, "iout", "uint16",
+    object_property_add_qapi(obj, "iout", &uint16_type_info,
                         adm1272_get,
                         adm1272_set, NULL, &pmdev->pages[0].read_iout);
 
-    object_property_add(obj, "pin", "uint16",
+    object_property_add_qapi(obj, "pin", &uint16_type_info,
                         adm1272_get,
                         adm1272_set, NULL, &pmdev->pages[0].read_pin);
 
diff --git a/hw/sensor/emc141x.c b/hw/sensor/emc141x.c
index a51fc44395a..5efe94643ca 100644
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
-    object_property_add(obj, "temperature0", "int",
+    object_property_add_qapi(obj, "temperature0", &int_type_info,
                         emc141x_get_temperature,
                         emc141x_set_temperature, NULL, NULL);
-    object_property_add(obj, "temperature1", "int",
+    object_property_add_qapi(obj, "temperature1", &int_type_info,
                         emc141x_get_temperature,
                         emc141x_set_temperature, NULL, NULL);
-    object_property_add(obj, "temperature2", "int",
+    object_property_add_qapi(obj, "temperature2", &int_type_info,
                         emc141x_get_temperature,
                         emc141x_set_temperature, NULL, NULL);
-    object_property_add(obj, "temperature3", "int",
+    object_property_add_qapi(obj, "temperature3", &int_type_info,
                         emc141x_get_temperature,
                         emc141x_set_temperature, NULL, NULL);
 }
diff --git a/hw/sensor/isl_pmbus_vr.c b/hw/sensor/isl_pmbus_vr.c
index 0fad04def77..8923e9e8751 100644
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
-            object_property_add(obj, "vin[*]", "uint16",
+            object_property_add_qapi(obj, "vin[*]", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_vin);
         }
 
         if (flags[i] & PB_HAS_VOUT) {
-            object_property_add(obj, "vout[*]", "uint16",
+            object_property_add_qapi(obj, "vout[*]", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_vout);
         }
 
         if (flags[i] & PB_HAS_IIN) {
-            object_property_add(obj, "iin[*]", "uint16",
+            object_property_add_qapi(obj, "iin[*]", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_iin);
         }
 
         if (flags[i] & PB_HAS_IOUT) {
-            object_property_add(obj, "iout[*]", "uint16",
+            object_property_add_qapi(obj, "iout[*]", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_iout);
         }
 
         if (flags[i] & PB_HAS_PIN) {
-            object_property_add(obj, "pin[*]", "uint16",
+            object_property_add_qapi(obj, "pin[*]", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_pin);
         }
 
         if (flags[i] & PB_HAS_POUT) {
-            object_property_add(obj, "pout[*]", "uint16",
+            object_property_add_qapi(obj, "pout[*]", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_pout);
         }
 
         if (flags[i] & PB_HAS_TEMPERATURE) {
-            object_property_add(obj, "temp1[*]", "uint16",
+            object_property_add_qapi(obj, "temp1[*]", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_temperature_1);
         }
 
         if (flags[i] & PB_HAS_TEMP2) {
-            object_property_add(obj, "temp2[*]", "uint16",
+            object_property_add_qapi(obj, "temp2[*]", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_temperature_2);
         }
 
         if (flags[i] & PB_HAS_TEMP3) {
-            object_property_add(obj, "temp3[*]", "uint16",
+            object_property_add_qapi(obj, "temp3[*]", &uint16_type_info,
                                 isl_pmbus_vr_get,
                                 isl_pmbus_vr_set,
                                 NULL, &pmdev->pages[i].read_temperature_3);
diff --git a/hw/sensor/lsm303dlhc_mag.c b/hw/sensor/lsm303dlhc_mag.c
index cd5773ae64e..c8085739ca4 100644
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
-    object_property_add(obj, "mag-x", "int",
+    object_property_add_qapi(obj, "mag-x", &int_type_info,
                 lsm303dlhc_mag_get_x,
                 lsm303dlhc_mag_set_x, NULL, NULL);
 
-    object_property_add(obj, "mag-y", "int",
+    object_property_add_qapi(obj, "mag-y", &int_type_info,
                 lsm303dlhc_mag_get_y,
                 lsm303dlhc_mag_set_y, NULL, NULL);
 
-    object_property_add(obj, "mag-z", "int",
+    object_property_add_qapi(obj, "mag-z", &int_type_info,
                 lsm303dlhc_mag_get_z,
                 lsm303dlhc_mag_set_z, NULL, NULL);
 
-    object_property_add(obj, "temperature", "int",
+    object_property_add_qapi(obj, "temperature", &int_type_info,
                 lsm303dlhc_mag_get_temperature,
                 lsm303dlhc_mag_set_temperature, NULL, NULL);
 }
diff --git a/hw/sensor/max34451.c b/hw/sensor/max34451.c
index 4d64434f3af..3c8fa3d4a86 100644
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
-        object_property_add(obj, "vout[*]", "uint16",
+        object_property_add_qapi(obj, "vout[*]", &uint16_type_info,
                             max34451_get,
                             max34451_set, NULL, &pmdev->pages[i].read_vout);
     }
@@ -737,7 +738,7 @@ static void max34451_init(Object *obj)
      * centidegrees Celsius i.e.: 2500 -> 25.00 C, max is 327.67 C
      */
     for (int i = 0; i < MAX34451_NUM_TEMP_DEVICES; i++) {
-        object_property_add(obj, "temperature[*]", "uint16",
+        object_property_add_qapi(obj, "temperature[*]", &uint16_type_info,
                             max34451_get,
                             max34451_set,
                             NULL,
diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index c5089d74f4b..ce4ff4856af 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -24,6 +24,7 @@
 #include "migration/vmstate.h"
 #include "hw/sensor/tmp105.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/module.h"
 #include "hw/core/registerfields.h"
@@ -308,7 +309,7 @@ static void tmp105_realize(DeviceState *dev, Error **errp)
 
 static void tmp105_initfn(Object *obj)
 {
-    object_property_add(obj, "temperature", "int",
+    object_property_add_qapi(obj, "temperature", &int_type_info,
                         tmp105_get_temperature,
                         tmp105_set_temperature, NULL, NULL);
 }
diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index 127edd0ba56..60844e76b21 100644
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
 
-    object_class_property_add(klass, "temperature0", "int",
+    object_class_property_add_qapi(klass, "temperature0", &int_type_info,
                               tmp421_get_temperature,
                               tmp421_set_temperature, NULL, NULL);
-    object_class_property_add(klass, "temperature1", "int",
+    object_class_property_add_qapi(klass, "temperature1", &int_type_info,
                               tmp421_get_temperature,
                               tmp421_set_temperature, NULL, NULL);
-    object_class_property_add(klass, "temperature2", "int",
+    object_class_property_add_qapi(klass, "temperature2", &int_type_info,
                               tmp421_get_temperature,
                               tmp421_set_temperature, NULL, NULL);
-    object_class_property_add(klass, "temperature3", "int",
+    object_class_property_add_qapi(klass, "temperature3", &int_type_info,
                               tmp421_get_temperature,
                               tmp421_set_temperature, NULL, NULL);
 }
diff --git a/hw/usb/dev-storage-classic.c b/hw/usb/dev-storage-classic.c
index 977151c4a08..06584092bca 100644
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
-    object_property_add(obj, "bootindex", "int32",
+    object_property_add_qapi(obj, "bootindex", &int32_type_info,
                         usb_msd_get_bootindex,
                         usb_msd_set_bootindex, NULL, NULL);
     object_property_set_int(obj, "bootindex", -1, NULL);
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 4c5f486ba23..9e43948128f 100644
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
@@ -1022,7 +1023,7 @@ static void virtio_balloon_instance_init(Object *obj)
     object_property_add(obj, "guest-stats", "guest statistics",
                         balloon_stats_get_all, NULL, NULL, NULL);
 
-    object_property_add(obj, "guest-stats-polling-interval", "int",
+    object_property_add_qapi(obj, "guest-stats-polling-interval", &int_type_info,
                         balloon_stats_get_poll_interval,
                         balloon_stats_set_poll_interval,
                         NULL, NULL);
diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
index f592eb1a784..80e9bfedd9f 100644
--- a/hw/virtio/virtio-mem-pci.c
+++ b/hw/virtio/virtio-mem-pci.c
@@ -14,6 +14,7 @@
 #include "virtio-mem-pci.h"
 #include "hw/mem/memory-device.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-events-machine.h"
 #include "qapi/qapi-events-misc.h"
 
@@ -211,7 +212,7 @@ static void virtio_mem_pci_instance_init(Object *obj)
                               OBJECT(&dev->vdev), VIRTIO_MEM_BLOCK_SIZE_PROP);
     object_property_add_alias(obj, VIRTIO_MEM_SIZE_PROP, OBJECT(&dev->vdev),
                               VIRTIO_MEM_SIZE_PROP);
-    object_property_add(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, "size",
+    object_property_add_qapi(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, &size_type_info,
                         virtio_mem_pci_get_requested_size,
                         virtio_mem_pci_set_requested_size, NULL, NULL);
 }
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index a4b71974a1c..8cdaab50505 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -25,6 +25,7 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-mem.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "migration/misc.h"
 #include "hw/core/boards.h"
@@ -1652,14 +1653,15 @@ static void virtio_mem_instance_init(Object *obj)
     notifier_list_init(&vmem->size_change_notifiers);
     QLIST_INIT(&vmem->rdl_list);
 
-    object_property_add(obj, VIRTIO_MEM_SIZE_PROP, "size", virtio_mem_get_size,
-                        NULL, NULL, NULL);
-    object_property_add(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, "size",
-                        virtio_mem_get_requested_size,
-                        virtio_mem_set_requested_size, NULL, NULL);
-    object_property_add(obj, VIRTIO_MEM_BLOCK_SIZE_PROP, "size",
-                        virtio_mem_get_block_size, virtio_mem_set_block_size,
-                        NULL, NULL);
+    object_property_add_qapi(obj, VIRTIO_MEM_SIZE_PROP, &size_type_info,
+                             virtio_mem_get_size,
+                             NULL, NULL, NULL);
+    object_property_add_qapi(obj, VIRTIO_MEM_REQUESTED_SIZE_PROP, &size_type_info,
+                             virtio_mem_get_requested_size,
+                             virtio_mem_set_requested_size, NULL, NULL);
+    object_property_add_qapi(obj, VIRTIO_MEM_BLOCK_SIZE_PROP, &size_type_info,
+                             virtio_mem_get_block_size, virtio_mem_set_block_size,
+                             NULL, NULL);
 }
 
 static void virtio_mem_instance_finalize(Object *obj)
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index cca37202ffb..7b4fd933a8f 100644
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
@@ -413,7 +414,7 @@ void xen_pvh_class_setup_common_props(XenPVHMachineClass *xpc)
 
 #define OC_MEMMAP_PROP_BASE(c, prop_name, name)                           \
 do {                                                                      \
-    object_class_property_add(c, prop_name "-base", "uint64_t",           \
+    object_class_property_add_qapi(c, prop_name "-base", &uint64_type_info,\
                               xen_pvh_get_ ## name ## _base,              \
                               xen_pvh_set_ ## name ## _base, NULL, NULL); \
     object_class_property_set_description(oc, prop_name "-base",          \
@@ -422,7 +423,7 @@ do {                                                                      \
 
 #define OC_MEMMAP_PROP_SIZE(c, prop_name, name)                           \
 do {                                                                      \
-    object_class_property_add(c, prop_name "-size", "uint64_t",           \
+    object_class_property_add_qapi(c, prop_name "-size", &size_type_info, \
                               xen_pvh_get_ ## name ## _size,              \
                               xen_pvh_set_ ## name ## _size, NULL, NULL); \
     object_class_property_set_description(oc, prop_name "-size",          \
@@ -458,7 +459,7 @@ do {                                                                      \
         OC_MEMMAP_PROP(oc, "pci-mmio", pci_mmio);
         OC_MEMMAP_PROP(oc, "pci-mmio-high", pci_mmio_high);
 
-        object_class_property_add(oc, "pci-intx-irq-base", "uint32_t",
+        object_class_property_add_qapi(oc, "pci-intx-irq-base", &uint32_type_info,
                                   xen_pvh_get_pci_intx_irq_base,
                                   xen_pvh_set_pci_intx_irq_base,
                                   NULL, NULL);
@@ -468,7 +469,7 @@ do {                                                                      \
 
 #ifdef CONFIG_TPM
     if (xpc->has_tpm) {
-        object_class_property_add(oc, "tpm-base-addr", "uint64_t",
+        object_class_property_add_qapi(oc, "tpm-base-addr", &uint64_type_info,
                                   xen_pvh_get_tpm_base,
                                   xen_pvh_set_tpm_base,
                                   NULL, NULL);
diff --git a/iothread.c b/iothread.c
index 3558535b40f..21fd5a91c5e 100644
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
 
-    object_class_property_add(klass, "poll-max-ns", "int",
+    object_class_property_add_qapi(klass, "poll-max-ns", &int_type_info,
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_max_ns_info);
-    object_class_property_add(klass, "poll-grow", "int",
+    object_class_property_add_qapi(klass, "poll-grow", &int_type_info,
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_grow_info);
-    object_class_property_add(klass, "poll-shrink", "int",
+    object_class_property_add_qapi(klass, "poll-shrink", &int_type_info,
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_shrink_info);
-    object_class_property_add(klass, "poll-weight", "int",
+    object_class_property_add_qapi(klass, "poll-weight", &int_type_info,
                               iothread_get_poll_param,
                               iothread_set_poll_param,
                               NULL, &poll_weight_info);
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 5986fb1e880..e5e79ce1091 100644
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
 
-    object_property_add(obj, "compare_timeout", "uint64",
+    object_property_add_qapi(obj, "compare_timeout", &uint64_type_info,
                         compare_get_timeout,
                         compare_set_timeout, NULL, NULL);
 
-    object_property_add(obj, "expired_scan_cycle", "uint32",
+    object_property_add_qapi(obj, "expired_scan_cycle", &uint32_type_info,
                         compare_get_expired_scan_cycle,
                         compare_set_expired_scan_cycle, NULL, NULL);
 
-    object_property_add(obj, "max_queue_size", "uint32",
+    object_property_add_qapi(obj, "max_queue_size", &uint32_type_info,
                         get_max_queue_size,
                         set_max_queue_size, NULL, NULL);
 
diff --git a/net/dump.c b/net/dump.c
index 0c39f09892c..3d7bb36182e 100644
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
@@ -238,8 +239,9 @@ static void filter_dump_class_init(ObjectClass *oc, const void *data)
 {
     NetFilterClass *nfc = NETFILTER_CLASS(oc);
 
-    object_class_property_add(oc, "maxlen", "uint32", filter_dump_get_maxlen,
-                              filter_dump_set_maxlen, NULL, NULL);
+    object_class_property_add_qapi(oc, "maxlen", &uint32_type_info,
+                                   filter_dump_get_maxlen,
+                                   filter_dump_set_maxlen, NULL, NULL);
     object_class_property_add_str(oc, "file", file_dump_get_filename,
                                   file_dump_set_filename);
 
diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index 427da24097f..9d7a9f5cb2c 100644
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
 
-    object_class_property_add(oc, "interval", "uint32",
+    object_class_property_add_qapi(oc, "interval", &uint32_type_info,
                               filter_buffer_get_interval,
                               filter_buffer_set_interval, NULL, NULL);
 
diff --git a/qom/object.c b/qom/object.c
index 1a3e224ea2c..f5d3e1e1e00 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -22,10 +22,10 @@
 #include "qapi/string-output-visitor.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/forward-visitor.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qobject/qdict.h"
 #include "qapi/qapi-type-info.h"
-#include "qobject/qjson.h"
 #include "qemu/id.h"
 #include "qapi/qmp/qerror.h"
 #include "trace.h"
@@ -2438,7 +2438,7 @@ object_property_add_str(Object *obj, const char *name,
     prop->get = get;
     prop->set = set;
 
-    return object_property_add(obj, name, "string",
+    return object_property_add_qapi(obj, name, &str_type_info,
                                get ? property_get_str : NULL,
                                set ? property_set_str : NULL,
                                property_release_data,
@@ -2456,7 +2456,7 @@ object_class_property_add_str(ObjectClass *klass, const char *name,
     prop->get = get;
     prop->set = set;
 
-    return object_class_property_add(klass, name, "string",
+    return object_class_property_add_qapi(klass, name, &str_type_info,
                                      get ? property_get_str : NULL,
                                      set ? property_set_str : NULL,
                                      NULL,
@@ -2508,7 +2508,7 @@ object_property_add_bool(Object *obj, const char *name,
     prop->get = get;
     prop->set = set;
 
-    return object_property_add(obj, name, "bool",
+    return object_property_add_qapi(obj, name, &bool_type_info,
                                get ? property_get_bool : NULL,
                                set ? property_set_bool : NULL,
                                property_release_data,
@@ -2525,7 +2525,7 @@ object_class_property_add_bool(ObjectClass *klass, const char *name,
     prop->get = get;
     prop->set = set;
 
-    return object_class_property_add(klass, name, "bool",
+    return object_class_property_add_qapi(klass, name, &bool_type_info,
                                      get ? property_get_bool : NULL,
                                      set ? property_set_bool : NULL,
                                      NULL,
@@ -2814,8 +2814,8 @@ object_property_add_uint8_ptr(Object *obj, const char *name,
         setter = property_set_uint8_ptr;
     }
 
-    return object_property_add(obj, name, "uint8",
-                               getter, setter, NULL, (void *)v);
+    return object_property_add_qapi(obj, name, &uint8_type_info,
+                                    getter, setter, NULL, (void *)v);
 }
 
 ObjectProperty *
@@ -2834,8 +2834,8 @@ object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
         setter = property_set_uint8_ptr;
     }
 
-    return object_class_property_add(klass, name, "uint8",
-                                     getter, setter, NULL, (void *)v);
+    return object_class_property_add_qapi(klass, name, &uint8_type_info,
+                                          getter, setter, NULL, (void *)v);
 }
 
 ObjectProperty *
@@ -2854,8 +2854,8 @@ object_property_add_uint16_ptr(Object *obj, const char *name,
         setter = property_set_uint16_ptr;
     }
 
-    return object_property_add(obj, name, "uint16",
-                               getter, setter, NULL, (void *)v);
+    return object_property_add_qapi(obj, name, &uint16_type_info,
+                                    getter, setter, NULL, (void *)v);
 }
 
 ObjectProperty *
@@ -2874,8 +2874,8 @@ object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
         setter = property_set_uint16_ptr;
     }
 
-    return object_class_property_add(klass, name, "uint16",
-                                     getter, setter, NULL, (void *)v);
+    return object_class_property_add_qapi(klass, name, &uint16_type_info,
+                                          getter, setter, NULL, (void *)v);
 }
 
 ObjectProperty *
@@ -2894,8 +2894,8 @@ object_property_add_uint32_ptr(Object *obj, const char *name,
         setter = property_set_uint32_ptr;
     }
 
-    return object_property_add(obj, name, "uint32",
-                               getter, setter, NULL, (void *)v);
+    return object_property_add_qapi(obj, name, &uint32_type_info,
+                                    getter, setter, NULL, (void *)v);
 }
 
 ObjectProperty *
@@ -2914,8 +2914,8 @@ object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
         setter = property_set_uint32_ptr;
     }
 
-    return object_class_property_add(klass, name, "uint32",
-                                     getter, setter, NULL, (void *)v);
+    return object_class_property_add_qapi(klass, name, &uint32_type_info,
+                                          getter, setter, NULL, (void *)v);
 }
 
 ObjectProperty *
@@ -2934,8 +2934,8 @@ object_property_add_uint64_ptr(Object *obj, const char *name,
         setter = property_set_uint64_ptr;
     }
 
-    return object_property_add(obj, name, "uint64",
-                               getter, setter, NULL, (void *)v);
+    return object_property_add_qapi(obj, name, &uint64_type_info,
+                                    getter, setter, NULL, (void *)v);
 }
 
 ObjectProperty *
@@ -2954,8 +2954,8 @@ object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
         setter = property_set_uint64_ptr;
     }
 
-    return object_class_property_add(klass, name, "uint64",
-                                     getter, setter, NULL, (void *)v);
+    return object_class_property_add_qapi(klass, name, &uint64_type_info,
+                                          getter, setter, NULL, (void *)v);
 }
 
 typedef struct {
diff --git a/system/bootdevice.c b/system/bootdevice.c
index 9538b08983f..7789e464186 100644
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
 
-    object_property_add(obj, name, "int32",
+    object_property_add_qapi(obj, name, &int32_type_info,
                         device_get_bootindex,
                         device_set_bootindex,
                         property_release_bootindex,
diff --git a/system/memory.c b/system/memory.c
index aaf5ec40230..1f2d44ce8b4 100644
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
@@ -1316,11 +1317,11 @@ static void memory_region_initfn(Object *obj)
 
     object_property_add_uint64_ptr(OBJECT(mr), "addr",
                                    &mr->addr, OBJ_PROP_FLAG_READ);
-    object_property_add(OBJECT(mr), "priority", "int32",
+    object_property_add_qapi(OBJECT(mr), "priority", &int32_type_info,
                         memory_region_get_priority,
                         NULL, /* memory_region_set_priority */
                         NULL, NULL);
-    object_property_add(OBJECT(mr), "size", "uint64",
+    object_property_add_qapi(OBJECT(mr), "size", &uint64_type_info,
                         memory_region_get_size,
                         NULL, /* memory_region_set_size, */
                         NULL, NULL);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 28167355773..62c0fa5a9e5 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "cpu.h"
 #include "cpregs.h"
 #include "qemu/module.h"
@@ -320,7 +321,7 @@ static void prop_bool_set_false(Object *obj, Visitor *v, const char *name,
 
 static void prop_add_stub_bool(Object *obj, const char *name)
 {
-    object_property_add(obj, name, "bool", prop_bool_get_false,
+    object_property_add_qapi(obj, name, &bool_type_info, prop_bool_get_false,
                         prop_bool_set_false, NULL, NULL);
 }
 
@@ -510,13 +511,13 @@ void aarch64_add_sve_properties(Object *obj)
     for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
         char name[8];
         snprintf(name, sizeof(name), "sve%d", vq * 128);
-        object_property_add(obj, name, "bool", cpu_arm_get_vq,
+        object_property_add_qapi(obj, name, &bool_type_info, cpu_arm_get_vq,
                             cpu_arm_set_vq, NULL, &cpu->sve_vq);
     }
 
 #ifdef CONFIG_USER_ONLY
     /* Mirror linux /proc/sys/abi/sve_default_vector_length. */
-    object_property_add(obj, "sve-default-vector-length", "int32",
+    object_property_add_qapi(obj, "sve-default-vector-length", &int32_type_info,
                         cpu_arm_get_default_vec_len,
                         cpu_arm_set_default_vec_len, NULL,
                         &cpu->sve_default_vq);
@@ -535,13 +536,13 @@ void aarch64_add_sme_properties(Object *obj)
     for (vq = 1; vq <= ARM_MAX_VQ; vq <<= 1) {
         char name[8];
         snprintf(name, sizeof(name), "sme%d", vq * 128);
-        object_property_add(obj, name, "bool", cpu_arm_get_vq,
+        object_property_add_qapi(obj, name, &bool_type_info, cpu_arm_get_vq,
                             cpu_arm_set_vq, NULL, &cpu->sme_vq);
     }
 
 #ifdef CONFIG_USER_ONLY
     /* Mirror linux /proc/sys/abi/sme_default_vector_length. */
-    object_property_add(obj, "sme-default-vector-length", "int32",
+    object_property_add_qapi(obj, "sme-default-vector-length", &int32_type_info,
                         cpu_arm_get_default_vec_len,
                         cpu_arm_set_default_vec_len, NULL,
                         &cpu->sme_default_vq);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index a54ef51ec2a..e1709552f68 100644
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
@@ -1776,7 +1777,7 @@ static void kvm_arch_set_eager_split_size(Object *obj, Visitor *v,
 
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
-    object_class_property_add(oc, "eager-split-size", "size",
+    object_class_property_add_qapi(oc, "eager-split-size", &size_type_info,
                               kvm_arch_get_eager_split_size,
                               kvm_arch_set_eager_split_size, NULL, NULL);
 
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index f7a920a202e..d23f92a9bd3 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "cpu.h"
 #include "qemu/module.h"
 #include "qapi/visitor.h"
@@ -1431,10 +1432,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     aarch64_add_pauth_properties(obj);
     aarch64_add_sve_properties(obj);
     aarch64_add_sme_properties(obj);
-    object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
+    object_property_add_qapi(obj, "sve-max-vq", &uint32_type_info, cpu_max_get_sve_max_vq,
                         cpu_max_set_sve_max_vq, NULL, NULL);
     object_property_add_bool(obj, "x-rme", cpu_arm_get_rme, cpu_arm_set_rme);
-    object_property_add(obj, "x-l0gptsz", "uint32", cpu_max_get_l0gptsz,
+    object_property_add_qapi(obj, "x-l0gptsz", &uint32_type_info, cpu_max_get_l0gptsz,
                         cpu_max_set_l0gptsz, NULL, NULL);
     qdev_property_add_static(DEVICE(obj), &arm_cpu_lpa2_property);
 }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3f0d8d8f1e8..58c78a8c607 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10423,7 +10423,7 @@ static void x86_cpu_register_bit_prop(X86CPUClass *xcc,
         fp = g_new0(BitProperty, 1);
         fp->w = w;
         fp->mask = mask;
-        object_class_property_add(oc, prop_name, "bool",
+        object_class_property_add_qapi(oc, prop_name, &bool_type_info,
                                   x86_cpu_get_bit_prop,
                                   x86_cpu_set_bit_prop,
                                   NULL, fp);
@@ -10939,13 +10939,13 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
 
     dc->user_creatable = true;
 
-    object_class_property_add(oc, "family", "int",
+    object_class_property_add_qapi(oc, "family", &int_type_info,
                               x86_cpuid_version_get_family,
                               x86_cpuid_version_set_family, NULL, NULL);
-    object_class_property_add(oc, "model", "int",
+    object_class_property_add_qapi(oc, "model", &int_type_info,
                               x86_cpuid_version_get_model,
                               x86_cpuid_version_set_model, NULL, NULL);
-    object_class_property_add(oc, "stepping", "int",
+    object_class_property_add_qapi(oc, "stepping", &int_type_info,
                               x86_cpuid_version_get_stepping,
                               x86_cpuid_version_set_stepping, NULL, NULL);
     object_class_property_add_str(oc, "vendor",
@@ -10954,7 +10954,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_str(oc, "model-id",
                                   x86_cpuid_get_model_id,
                                   x86_cpuid_set_model_id);
-    object_class_property_add(oc, "tsc-frequency", "int",
+    object_class_property_add_qapi(oc, "tsc-frequency", &int_type_info,
                               x86_cpuid_get_tsc_freq,
                               x86_cpuid_set_tsc_freq, NULL, NULL);
     /*
@@ -10967,7 +10967,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, const void *data)
                               x86_cpu_get_unavailable_features,
                               NULL, NULL, NULL);
 
-    object_class_property_add(oc, "avx10-version",  "uint8",
+    object_class_property_add_qapi(oc, "avx10-version",  &uint8_type_info,
                               x86_cpuid_get_avx10_version,
                               x86_cpuid_set_avx10_version,
                               NULL, NULL);
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index ecf0c76fcdf..9b41d04259b 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -7096,7 +7096,7 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
         .set = kvm_arch_set_notify_vmexit,
     ));
 
-    object_class_property_add(oc, "notify-window", "uint32",
+    object_class_property_add_qapi(oc, "notify-window", &uint32_type_info,
                               kvm_arch_get_notify_window,
                               kvm_arch_set_notify_window,
                               NULL, NULL);
@@ -7104,7 +7104,7 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
                                           "Clock cycles without an event window "
                                           "after which a notification VM exit occurs");
 
-    object_class_property_add(oc, "xen-version", "uint32",
+    object_class_property_add_qapi(oc, "xen-version", &uint32_type_info,
                               kvm_arch_get_xen_version,
                               kvm_arch_set_xen_version,
                               NULL, NULL);
@@ -7113,14 +7113,14 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
                                           "(in XENVER_version form "
                                           "e.g. 0x4000a for 4.10)");
 
-    object_class_property_add(oc, "xen-gnttab-max-frames", "uint16",
+    object_class_property_add_qapi(oc, "xen-gnttab-max-frames", &uint16_type_info,
                               kvm_arch_get_xen_gnttab_max_frames,
                               kvm_arch_set_xen_gnttab_max_frames,
                               NULL, NULL);
     object_class_property_set_description(oc, "xen-gnttab-max-frames",
                                           "Maximum number of grant table frames");
 
-    object_class_property_add(oc, "xen-evtchn-max-pirq", "uint16",
+    object_class_property_add_qapi(oc, "xen-evtchn-max-pirq", &uint16_type_info,
                               kvm_arch_get_xen_evtchn_max_pirq,
                               kvm_arch_set_xen_evtchn_max_pirq,
                               NULL, NULL);
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 63ccae4c26c..53d3e310c51 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -3179,7 +3179,7 @@ sev_snp_guest_class_init(ObjectClass *oc, const void *data)
     x86_klass->adjust_cpuid_features = sev_snp_adjust_cpuid_features;
     x86_klass->kvm_type = sev_snp_kvm_type;
 
-    object_class_property_add(oc, "policy", "uint64",
+    object_class_property_add_qapi(oc, "policy", &uint64_type_info,
                               sev_snp_guest_get_policy,
                               sev_snp_guest_set_policy, NULL, NULL);
     object_class_property_add_str(oc, "guest-visible-workarounds",
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 55de3bd5d5d..4d81225de37 100644
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
 
-    object_property_add(obj, name, "string",
+    object_property_add_qapi(obj, name, &str_type_info,
                         ppc_compat_prop_get, ppc_compat_prop_set, NULL,
                         compat_pvr);
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5903df99548..a63961bb713 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -25,6 +25,7 @@
 #include "cpu_vendorid.h"
 #include "internals.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
@@ -1021,16 +1022,16 @@ void riscv_add_satp_mode_properties(Object *obj)
     RISCVCPU *cpu = RISCV_CPU(obj);
 
     if (cpu->env.misa_mxl == MXL_RV32) {
-        object_property_add(obj, "sv32", "bool", cpu_riscv_get_satp,
+        object_property_add_qapi(obj, "sv32", &bool_type_info, cpu_riscv_get_satp,
                             cpu_riscv_set_satp, NULL, &cpu->satp_modes);
     } else {
-        object_property_add(obj, "sv39", "bool", cpu_riscv_get_satp,
+        object_property_add_qapi(obj, "sv39", &bool_type_info, cpu_riscv_get_satp,
                             cpu_riscv_set_satp, NULL, &cpu->satp_modes);
-        object_property_add(obj, "sv48", "bool", cpu_riscv_get_satp,
+        object_property_add_qapi(obj, "sv48", &bool_type_info, cpu_riscv_get_satp,
                             cpu_riscv_set_satp, NULL, &cpu->satp_modes);
-        object_property_add(obj, "sv57", "bool", cpu_riscv_get_satp,
+        object_property_add_qapi(obj, "sv57", &bool_type_info, cpu_riscv_get_satp,
                             cpu_riscv_set_satp, NULL, &cpu->satp_modes);
-        object_property_add(obj, "sv64", "bool", cpu_riscv_get_satp,
+        object_property_add_qapi(obj, "sv64", &bool_type_info, cpu_riscv_get_satp,
                             cpu_riscv_set_satp, NULL, &cpu->satp_modes);
     }
 }
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 53d88339c13..de2a91b81b4 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -24,6 +24,7 @@
 
 #include "qemu/timer.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qapi/visitor.h"
@@ -529,7 +530,7 @@ static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
      * unknown to KVM and error out if the user attempts
      * to enable any of them.
      */
-    object_property_add(obj, prop_name, "bool",
+    object_property_add_qapi(obj, prop_name, &bool_type_info,
                         cpu_get_cfg_unavailable,
                         cpu_set_cfg_unavailable,
                         NULL, (void *)prop_name);
@@ -549,7 +550,7 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
         misa_cfg->name = riscv_get_misa_ext_name(bit);
         misa_cfg->description = riscv_get_misa_ext_description(bit);
 
-        object_property_add(cpu_obj, misa_cfg->name, "bool",
+        object_property_add_qapi(cpu_obj, misa_cfg->name, &bool_type_info,
                             kvm_cpu_get_misa_ext_cfg,
                             kvm_cpu_set_misa_ext_cfg,
                             NULL, misa_cfg);
@@ -565,7 +566,7 @@ static void kvm_riscv_add_cpu_user_properties(Object *cpu_obj)
     for (i = 0; i < ARRAY_SIZE(kvm_multi_ext_cfgs); i++) {
         KVMCPUConfig *multi_cfg = &kvm_multi_ext_cfgs[i];
 
-        object_property_add(cpu_obj, multi_cfg->name, "bool",
+        object_property_add_qapi(cpu_obj, multi_cfg->name, &bool_type_info,
                             kvm_cpu_get_multi_ext_cfg,
                             kvm_cpu_set_multi_ext_cfg,
                             NULL, multi_cfg);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 3e22e7ed53d..1b9c68bff54 100644
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
@@ -1438,7 +1439,7 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
             continue;
         }
 
-        object_property_add(cpu_obj, name, "bool",
+        object_property_add_qapi(cpu_obj, name, &bool_type_info,
                             cpu_get_misa_ext_cfg,
                             cpu_set_misa_ext_cfg,
                             NULL, (void *)misa_cfg);
@@ -1492,7 +1493,7 @@ static void riscv_cpu_add_profiles(Object *cpu_obj)
     for (int i = 0; riscv_profiles[i] != NULL; i++) {
         RISCVCPUProfile *profile = riscv_profiles[i];
 
-        object_property_add(cpu_obj, profile->name, "bool",
+        object_property_add_qapi(cpu_obj, profile->name, &bool_type_info,
                             cpu_get_profile, cpu_set_profile,
                             NULL, (void *)profile);
 
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 0b88868289b..bbf983afee9 100644
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
@@ -906,13 +907,13 @@ void s390_cpu_model_class_register_props(ObjectClass *oc)
 
     for (feat = 0; feat < S390_FEAT_MAX; feat++) {
         const S390FeatDef *def = s390_feat_def(feat);
-        object_class_property_add(oc, def->name, "bool", get_feature,
+        object_class_property_add_qapi(oc, def->name, &bool_type_info, get_feature,
                                   set_feature, NULL, (void *) feat);
         object_class_property_set_description(oc, def->name, def->desc);
     }
     for (group = 0; group < S390_FEAT_GROUP_MAX; group++) {
         const S390FeatGroupDef *def = s390_feat_group_def(group);
-        object_class_property_add(oc, def->name, "bool", get_feature_group,
+        object_class_property_add_qapi(oc, def->name, &bool_type_info, get_feature_group,
                                   set_feature_group, NULL, (void *) group);
         object_class_property_set_description(oc, def->name, def->desc);
     }
diff --git a/tests/unit/test-qdev-global-props.c b/tests/unit/test-qdev-global-props.c
index 8ea362cbb90..204436fb727 100644
--- a/tests/unit/test-qdev-global-props.c
+++ b/tests/unit/test-qdev-global-props.c
@@ -27,6 +27,7 @@
 #include "hw/core/qdev-properties.h"
 #include "qom/object.h"
 #include "qapi/error.h"
+#include "qapi/qapi-builtin-type-infos.h"
 #include "qapi/visitor.h"
 
 
@@ -171,10 +172,12 @@ static void prop2_accessor(Object *obj, Visitor *v, const char *name,
 
 static void dynamic_instance_init(Object *obj)
 {
-    object_property_add(obj, "prop1", "uint32", prop1_accessor, prop1_accessor,
-                        NULL, NULL);
-    object_property_add(obj, "prop2", "uint32", prop2_accessor, prop2_accessor,
-                        NULL, NULL);
+    object_property_add_qapi(obj, "prop1", &uint32_type_info,
+                             prop1_accessor, prop1_accessor,
+                             NULL, NULL);
+    object_property_add_qapi(obj, "prop2", &uint32_type_info,
+                             prop2_accessor, prop2_accessor,
+                             NULL, NULL);
 }
 
 static void dynamic_class_init(ObjectClass *oc, const void *data)
diff --git a/ui/console.c b/ui/console.c
index a7c977d0c44..014061f0fa0 100644
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
@@ -509,7 +510,7 @@ qemu_graphic_console_class_init(ObjectClass *oc, const void *data)
                                    offsetof(QemuGraphicConsole, device),
                                    object_property_allow_set_link,
                                    OBJ_PROP_LINK_STRONG);
-    object_class_property_add(oc, "head", "uint32",
+    object_class_property_add_qapi(oc, "head", &uint32_type_info,
                               qemu_graphic_console_prop_get_head,
                               NULL, NULL, NULL);
 
diff --git a/util/thread-context.c b/util/thread-context.c
index 0146154fa56..ee90d8d5d99 100644
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
@@ -278,13 +279,13 @@ static void thread_context_class_init(ObjectClass *oc, const void *data)
     UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
 
     ucc->complete = thread_context_instance_complete;
-    object_class_property_add(oc, "thread-id", "int",
+    object_class_property_add_qapi(oc, "thread-id", &int_type_info,
                               thread_context_get_thread_id, NULL, NULL,
                               NULL);
-    object_class_property_add(oc, "cpu-affinity", "int",
+    object_class_property_add_qapi(oc, "cpu-affinity", &int_type_info,
                               thread_context_get_cpu_affinity,
                               thread_context_set_cpu_affinity, NULL, NULL);
-    object_class_property_add(oc, "node-affinity", "int", NULL,
+    object_class_property_add_qapi(oc, "node-affinity", &int_type_info, NULL,
                               thread_context_set_node_affinity, NULL, NULL);
 }
 

-- 
2.54.0


