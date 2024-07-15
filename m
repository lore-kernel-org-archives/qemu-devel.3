Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0DBC3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 12:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTKks-0000e6-K7; Mon, 15 Jul 2024 08:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTKkq-0000dP-Fq
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 08:24:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTKkn-00089F-Br
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 08:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721046267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qZfMtSsSKRnHYwMRYZ6pPalGfv3zPch0BPlXlsB8SvM=;
 b=G4i+ISy1I5u+gU9vyX3e3/7T3lHeh8ox6zEZWuGakXr2w3xQdOpCpx9QzUWfinz72WlfVb
 cusPeUJmGTJmCVg/0nIWEsjWngaC3D2VGCmlfN7fvWiXX0sy7IboPRTHotml9SdiDGQOUR
 XC0UvSyzRVVqojtiifDGDgDCwFvfaR0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-r3n4o8VYPdGZKTWamoY4aQ-1; Mon,
 15 Jul 2024 08:24:24 -0400
X-MC-Unique: r3n4o8VYPdGZKTWamoY4aQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2515C19560A2; Mon, 15 Jul 2024 12:24:23 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 214AE1955D42; Mon, 15 Jul 2024 12:24:19 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, mst@redhat.com,
 wangyanan55@huawei.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 anisinha@redhat.com, qemu-arm@nongnu.org
Subject: [PATCH v2] smbios: make memory device size configurable per Machine
Date: Mon, 15 Jul 2024 14:24:17 +0200
Message-ID: <20240715122417.4059293-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently QEMU describes initial[1] RAM* in SMBIOS as a series of
virtual DIMMs (capped at 16Gb max) using type 17 structure entries.

Which is fine for the most cases.  However when starting guest
with terabytes of RAM this leads to too many memory device
structures, which eventually upsets linux kernel as it reserves
only 64K for these entries and when that border is crossed out
it runs out of reserved memory.

Instead of partitioning initial RAM on 16Gb DIMMs, use maximum
possible chunk size that SMBIOS spec allows[2]. Which lets
encode RAM in lower 31 bits of 32bit field (which amounts upto
2047Tb per DIMM).
As result initial RAM will generate only one type 17 structure
until host/guest reach ability to use more RAM in the future.

Compat changes:
We can't unconditionally change chunk size as it will break
QEMU<->guest ABI (and migration). Thus introduce a new machine
class field that would let older versioned machines to use
legacy 16Gb chunks, while new(er) machine type[s] use maximum
possible chunk size.

PS:
While it might seem to be risky to rise max entry size this large
(much beyond of what current physical RAM modules support),
I'd not expect it causing much issues, modulo uncovering bugs
in software running within guest. And those should be fixed
on guest side to handle SMBIOS spec properly, especially if
guest is expected to support so huge RAM configs.

In worst case, QEMU can reduce chunk size later if we would
care enough about introducing a workaround for some 'unfixable'
guest OS, either by fixing up the next machine type or
giving users a CLI option to customize it.

1) Initial RAM - is RAM configured with help '-m SIZE' CLI option/
   implicitly defined by machine. It doesn't include memory
   configured with help of '-device' option[s] (pcdimm,nvdimm,...)
2) SMBIOS 3.1.0 7.18.5 Memory Device — Extended Size

PS:
* tested on 8Tb host with RHEL6 guest, which seems to parse
  type 17 SMBIOS table entries correctly (according to 'dmidecode').

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v2:
  * add comment in the code describing where 2047Tb comes from (mst)
  * rephrase commit message a bit and clarify what RAM it applies.
---
 include/hw/boards.h |  4 ++++
 hw/arm/virt.c       |  1 +
 hw/core/machine.c   |  6 ++++++
 hw/i386/pc_piix.c   |  1 +
 hw/i386/pc_q35.c    |  1 +
 hw/smbios/smbios.c  | 11 ++++++-----
 6 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index ef6f18f2c1..48ff6d8b93 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -237,6 +237,9 @@ typedef struct {
  *    purposes only.
  *    Applies only to default memory backend, i.e., explicit memory backend
  *    wasn't used.
+ * @smbios_memory_device_size:
+ *    Default size of memory device,
+ *    SMBIOS 3.1.0 "7.18 Memory Device (Type 17)"
  */
 struct MachineClass {
     /*< private >*/
@@ -304,6 +307,7 @@ struct MachineClass {
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
     int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
     ram_addr_t (*fixup_ram_size)(ram_addr_t size);
+    uint64_t smbios_memory_device_size;
 };
 
 /**
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b0c68d66a3..719e83e6a1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3308,6 +3308,7 @@ DEFINE_VIRT_MACHINE_AS_LATEST(9, 1)
 static void virt_machine_9_0_options(MachineClass *mc)
 {
     virt_machine_9_1_options(mc);
+    mc->smbios_memory_device_size = 16 * GiB;
     compat_props_add(mc->compat_props, hw_compat_9_0, hw_compat_9_0_len);
 }
 DEFINE_VIRT_MACHINE(9, 0)
diff --git a/hw/core/machine.c b/hw/core/machine.c
index bc38cad7f2..ac30544e7f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1004,6 +1004,12 @@ static void machine_class_init(ObjectClass *oc, void *data)
     /* Default 128 MB as guest ram size */
     mc->default_ram_size = 128 * MiB;
     mc->rom_file_has_mr = true;
+    /*
+     * SMBIOS 3.1.0 7.18.5 Memory Device — Extended Size
+     * use max possible value that could be encoded into
+     * 'Extended Size' field (2047Tb).
+     */
+    mc->smbios_memory_device_size = 2047 * TiB;
 
     /* numa node memory size aligned on 8MB by default.
      * On Linux, each node's border has to be 8MB aligned
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9445b07b4f..d9e69243b4 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -495,6 +495,7 @@ static void pc_i440fx_machine_9_0_options(MachineClass *m)
     pc_i440fx_machine_9_1_options(m);
     m->alias = NULL;
     m->is_default = false;
+    m->smbios_memory_device_size = 16 * GiB;
 
     compat_props_add(m->compat_props, hw_compat_9_0, hw_compat_9_0_len);
     compat_props_add(m->compat_props, pc_compat_9_0, pc_compat_9_0_len);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 71d3c6d122..9d108b194e 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -374,6 +374,7 @@ static void pc_q35_machine_9_0_options(MachineClass *m)
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_machine_9_1_options(m);
     m->alias = NULL;
+    m->smbios_memory_device_size = 16 * GiB;
     compat_props_add(m->compat_props, hw_compat_9_0, hw_compat_9_0_len);
     compat_props_add(m->compat_props, pc_compat_9_0, pc_compat_9_0_len);
     pcmc->isa_bios_alias = false;
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 3b7703489d..a394514264 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -1093,6 +1093,7 @@ static bool smbios_get_tables_ep(MachineState *ms,
                        Error **errp)
 {
     unsigned i, dimm_cnt, offset;
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
     ERRP_GUARD();
 
     assert(ep_type == SMBIOS_ENTRY_POINT_TYPE_32 ||
@@ -1123,12 +1124,12 @@ static bool smbios_get_tables_ep(MachineState *ms,
     smbios_build_type_9_table(errp);
     smbios_build_type_11_table();
 
-#define MAX_DIMM_SZ (16 * GiB)
-#define GET_DIMM_SZ ((i < dimm_cnt - 1) ? MAX_DIMM_SZ \
-                                        : ((current_machine->ram_size - 1) % MAX_DIMM_SZ) + 1)
+#define GET_DIMM_SZ ((i < dimm_cnt - 1) ? mc->smbios_memory_device_size \
+    : ((current_machine->ram_size - 1) % mc->smbios_memory_device_size) + 1)
 
-    dimm_cnt = QEMU_ALIGN_UP(current_machine->ram_size, MAX_DIMM_SZ) /
-               MAX_DIMM_SZ;
+    dimm_cnt = QEMU_ALIGN_UP(current_machine->ram_size,
+                             mc->smbios_memory_device_size) /
+               mc->smbios_memory_device_size;
 
     /*
      * The offset determines if we need to keep additional space between
-- 
2.43.0


