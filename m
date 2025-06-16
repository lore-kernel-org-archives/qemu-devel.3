Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82401C71155
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 15:52:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRC7q-0001ck-To; Mon, 16 Jun 2025 11:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>)
 id 1uRC7o-0001Zr-IB; Mon, 16 Jun 2025 11:51:57 -0400
Received: from mail.sean.taipei ([128.199.207.102] helo=sean.taipei)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@sean.taipei>)
 id 1uRC7h-0003tH-ON; Mon, 16 Jun 2025 11:51:55 -0400
Authentication-Results: sean.taipei; dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
ARC-Filter: OpenARC Filter v0.1.0 sean.taipei 6C4757385
ARC-Seal: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2; t=1750089075;
 cv=none;
 b=s+mnZCl7GEI+C9N1fOQKpIPT9BbIj8gKHTn3Gpf3+Erxm6A7ZYGpIgNZvAIV7u9oE6ywvkZ+e19b6THmvRR9BZZkp4Z6C/Rg3TVEvjT/0HtRBEO9N8+E/8aX3UngzGiExx2kzeNWanQSRzkGMfXQmcP1wHRackfMQ8XFZQeYbLHaGQmgsIrzGxohzEKW6s6qvy4Oa4TwK6FIYu86OIal16zwEWzEBfZH4aSPjOR+2rWCevN/5UbHO82WY8+U/K6+KZJOur8VldaVP0yss7iH3ZMwmfRS2Ya4fCpB4e6XmhFww1bbKplfZLMaZZY8oGxBiojBhyfsla6Z1BTTEtmEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sean.taipei; s=arc-2024Q2;
 t=1750089075; c=relaxed/simple;
 bh=gCAbVQKT50ls79CaOWWp+h5fI2lfYy6bipO+wl13RME=;
 h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:References:
 MIME-Version;
 b=MEpkQFyJweVGZQ1lYFVyRdVeZNuFrg/ex8Q7OpxNwJwQ2K1+xJ1DXjRJIyErM7LgyCSte50PPDZONwrsFfV/qcFfYsp2LkwzjHnn1XJqRcHD2W1nqsMhYid0zA7EI2X21LUSeid00//u2+g46zgZCkmeTTbp3m15ufhQ9uv72yly6tdxAmtDBj+yQMr5qA5sOdImVM2R2gxUiVplg7AwVhscSzMhDzYcfYEvfqu2XYgIzUXZ2vZb3z6CNxj0IJDCq6Zoqu/PkRLZsAbad6UcZm70Pw5pc2la3g3YC5V3P2oYSYzD+lUZHUtC463uEWvGww+gnbkN5Zow9bqphs3OKg==
ARC-Authentication-Results: i=1; sean.taipei;
 dmarc=fail (p=quarantine dis=none)
 header.from=sean.taipei
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sean.taipei;
 s=2021Q3; t=1750089074;
 bh=gCAbVQKT50ls79CaOWWp+h5fI2lfYy6bipO+wl13RME=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=otsDIzC4GrVFCC9QZHBGtyF/1M9kJpavB7vL8l74sKfRT3XHRcHBtgcXufGm99Dmq
 y1EcuwEWRyWJ7JhFd8nCS4/VQ2QvjD4Up7Ezc+feW4LPJOa//8eh/su7dUOKVHfidb
 +Sa8jru7tFh0rUzc0+GMxGVoabrecY714u7TOsdbt2vsTXfoNkpVJuLszRTGeMhmkt
 Y1VbCqBfGSWM3nKowMcfxPxffdfLWJtLtoVLQ9N8JuAUVxBln8lJVUgN2AiSxJTS4P
 kxN39ScTJEz5tnJvShteT8dhsnxGtctT+Pxn+D+HumumJBUK7BImzkzlLNd/IRmOhi
 nZXVuGx0cnmxg==
Received: from localhost.localdomain (unknown [23.170.80.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by sean.taipei (Postfix) with ESMTPSA id 6C4757385;
 Mon, 16 Jun 2025 23:51:09 +0800 (CST)
From: Sean Wei <me@sean.taipei>
To: qemu-devel@nongnu.org
Cc: Sean Wei <me@sean.taipei>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org (open list:sPAPR (pseries))
Subject: [PATCH 5/6] treewide: update docs file extensions (.txt -> .rst) in
 comments
Date: Mon, 16 Jun 2025 11:50:50 -0400
Message-ID: <20250616.qemu.relocated.05@sean.taipei>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616.qemu.relocated@sean.taipei>
References: <20250616.qemu.relocated@sean.taipei>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Powered-By: Sean <postmaster@sean.taipei>
X-Scanned-By: MIMEDefang 3.3 on 104.21.5.93
Received-SPF: pass client-ip=128.199.207.102; envelope-from=me@sean.taipei;
 helo=sean.taipei
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Several source comments still refer to docs with the old .txt
extension that were previously converted to reStructuredText.

Update these references to use the correct .rst extensions to
maintain accurate in-tree documentation pointers.

No functional changes.

Related commits:
  50f8174c5c1 (Jul 2021): docs/specs/acpi_nvdimm: Convert to rST
  f054eb1c920 (Jul 2021): docs/specs/acpi_pci_hotplug: Convert to rST
  912fb3678b8 (Sep 2023): docs/specs/vmgenid: Convert to rST
  bb1cff6ee04 (Sep 2023): docs/specs/ivshmem-spec: Convert to rST
  55ff468f781 (Jan 2022): docs: Rename ppc-spapr-hotplug.txt to .rst

Signed-off-by: Sean Wei <me@sean.taipei>
---
 hw/acpi/nvdimm.c               | 2 +-
 hw/acpi/pcihp.c                | 2 +-
 hw/acpi/vmgenid.c              | 6 +++---
 hw/misc/ivshmem-flat.c         | 2 +-
 hw/ppc/spapr.c                 | 2 +-
 include/hw/acpi/pcihp.h        | 2 +-
 include/hw/misc/ivshmem-flat.h | 2 +-
 tests/qtest/vmgenid-test.c     | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 9ba90806f2..732d613ac0 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -535,7 +535,7 @@ nvdimm_dsm_no_payload(uint32_t func_ret_status, hwaddr dsm_mem_addr)
 
 #define NVDIMM_QEMU_RSVD_HANDLE_ROOT         0x10000
 
-/* Read FIT data, defined in docs/specs/acpi_nvdimm.txt. */
+/* Read FIT data, defined in docs/specs/acpi_nvdimm.rst. */
 static void nvdimm_dsm_func_read_fit(NVDIMMState *state, NvdimmDsmIn *in,
                                      hwaddr dsm_mem_addr)
 {
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index aac90013d4..497281ae20 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -3,7 +3,7 @@
  *
  * QEMU supports PCI hotplug via ACPI. This module
  * implements the interface between QEMU and the ACPI BIOS.
- * Interface specification - see docs/specs/acpi_pci_hotplug.txt
+ * Interface specification - see docs/specs/acpi_pci_hotplug.rst
  *
  * Copyright (c) 2013, Red Hat Inc, Michael S. Tsirkin (mst@redhat.com)
  * Copyright (c) 2006 Fabrice Bellard
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index fac3d6d97e..33c35c85dd 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -38,7 +38,7 @@ void vmgenid_build_acpi(VmGenIdState *vms, GArray *table_data, GArray *guid,
     guid_le = qemu_uuid_bswap(vms->guid);
     /* The GUID is written at a fixed offset into the fw_cfg file
      * in order to implement the "OVMF SDT Header probe suppressor"
-     * see docs/specs/vmgenid.txt for more details
+     * see docs/specs/vmgenid.rst for more details
      */
     g_array_insert_vals(guid, VMGENID_GUID_OFFSET, guid_le.data,
                         ARRAY_SIZE(guid_le.data));
@@ -101,7 +101,7 @@ void vmgenid_build_acpi(VmGenIdState *vms, GArray *table_data, GArray *guid,
      * < 4GB, but write 64 bits anyway.
      * The address that is patched in is offset in order to implement
      * the "OVMF SDT Header probe suppressor"
-     * see docs/specs/vmgenid.txt for more details.
+     * see docs/specs/vmgenid.rst for more details.
      */
     bios_linker_loader_write_pointer(linker,
         VMGENID_ADDR_FW_CFG_FILE, 0, sizeof(uint64_t),
@@ -153,7 +153,7 @@ static void vmgenid_update_guest(VmGenIdState *vms)
             guid_le = qemu_uuid_bswap(vms->guid);
             /* The GUID is written at a fixed offset into the fw_cfg file
              * in order to implement the "OVMF SDT Header probe suppressor"
-             * see docs/specs/vmgenid.txt for more details.
+             * see docs/specs/vmgenid.rst for more details.
              */
             cpu_physical_memory_write(vmgenid_addr, guid_le.data,
                                       sizeof(guid_le.data));
diff --git a/hw/misc/ivshmem-flat.c b/hw/misc/ivshmem-flat.c
index be28c24d73..fe4be6be17 100644
--- a/hw/misc/ivshmem-flat.c
+++ b/hw/misc/ivshmem-flat.c
@@ -362,7 +362,7 @@ static bool ivshmem_flat_connect_server(DeviceState *dev, Error **errp)
      *
      *  ivshmem_flat_recv_msg() calls return 'msg' and 'fd'.
      *
-     *  See ./docs/specs/ivshmem-spec.txt for details on the protocol.
+     *  See docs/specs/ivshmem-spec.rst for details on the protocol.
      */
 
     /* Step 0 */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 702f774cda..08615f6c90 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -577,7 +577,7 @@ static int spapr_dt_dynamic_memory(SpaprMachineState *spapr, void *fdt,
 
 /*
  * Adds ibm,dynamic-reconfiguration-memory node.
- * Refer to docs/specs/ppc-spapr-hotplug.txt for the documentation
+ * Refer to docs/specs/ppc-spapr-hotplug.rst for the documentation
  * of this device tree node.
  */
 static int spapr_dt_dynamic_reconfiguration_memory(SpaprMachineState *spapr,
diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index a97904bada..cdc0cb8e43 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -3,7 +3,7 @@
  *
  * QEMU supports PCI hotplug via ACPI. This module
  * implements the interface between QEMU and the ACPI BIOS.
- * Interface specification - see docs/specs/acpi_pci_hotplug.txt
+ * Interface specification - see docs/specs/acpi_pci_hotplug.rst
  *
  * Copyright (c) 2013, Red Hat Inc, Michael S. Tsirkin (mst@redhat.com)
  * Copyright (c) 2006 Fabrice Bellard
diff --git a/include/hw/misc/ivshmem-flat.h b/include/hw/misc/ivshmem-flat.h
index 09bc3abcad..3eca99004e 100644
--- a/include/hw/misc/ivshmem-flat.h
+++ b/include/hw/misc/ivshmem-flat.h
@@ -36,7 +36,7 @@ typedef struct IvshmemFTState IvshmemFTState;
 
 DECLARE_INSTANCE_CHECKER(IvshmemFTState, IVSHMEM_FLAT, TYPE_IVSHMEM_FLAT)
 
-/* Ivshmem registers. See ./docs/specs/ivshmem-spec.txt for details. */
+/* Ivshmem registers. See docs/specs/ivshmem-spec.rst for details. */
 enum ivshmem_registers {
     INTMASK = 0,
     INTSTATUS = 4,
diff --git a/tests/qtest/vmgenid-test.c b/tests/qtest/vmgenid-test.c
index e613374665..33e96b7c55 100644
--- a/tests/qtest/vmgenid-test.c
+++ b/tests/qtest/vmgenid-test.c
@@ -61,7 +61,7 @@ static uint32_t acpi_find_vgia(QTestState *qts)
 
             /* The GUID is written at a fixed offset into the fw_cfg file
              * in order to implement the "OVMF SDT Header probe suppressor"
-             * see docs/specs/vmgenid.txt for more details
+             * see docs/specs/vmgenid.rst for more details
              */
             guid_offset = le32_to_cpu(vgia_val) + VMGENID_GUID_OFFSET;
             g_free(table_aml);
-- 
2.49.0


