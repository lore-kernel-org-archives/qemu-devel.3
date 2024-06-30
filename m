Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD108C3065B
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 19:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO0Pz-00005d-4P; Sun, 30 Jun 2024 15:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0Pu-0008S5-D7
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:40:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sO0Pn-0004O1-Lq
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 15:40:51 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UJcvCO020058;
 Sun, 30 Jun 2024 19:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=3raiXCm8kRFGnYk1UPCeOPFpx20xzLtvntIeQ9Dkyxg=; b=
 nTOyazqKQSjW8LQP4azBJFbllje1B+NYVtLw44T/XhuvOyoWtet5VNLEyKbXbVr4
 krdeu1XUMY1iLnaOPV8XBj+pwhXTkfBeEsGPQGpR99ZuaSSVDVknXLlXaaU1AHiV
 t06F565AqlLOS0Nac/lu7gnGPL9gW2V3rGFE23e6A2f4hLapW5eHYx4cynWE03/n
 AJGJP/RcnEUQjOFE4dFU5+XFhWFT3hQ+iMXWY2q0k/CjCPirrs+ClPXhwGTBwL+r
 fbWTHNMG3bEKp2dKlwVOCDcskzWg4nZiNu1LHOSk57K4c5oSKILoRAHfSiIwm8qs
 L1HvQg/a2hpj9byramVirw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402att9e1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:40:39 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45UIwiMG018459; Sun, 30 Jun 2024 19:40:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4028qc16cw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 19:40:38 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45UJeaSQ014044;
 Sun, 30 Jun 2024 19:40:37 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 4028qc16cc-2; Sun, 30 Jun 2024 19:40:37 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 01/11] machine: alloc-anon option
Date: Sun, 30 Jun 2024 12:40:24 -0700
Message-Id: <1719776434-435013-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_16,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406300157
X-Proofpoint-GUID: LLqZLkOEv4-f0KPQWrpRiUV3jHhgo8HX
X-Proofpoint-ORIG-GUID: LLqZLkOEv4-f0KPQWrpRiUV3jHhgo8HX
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
on the value of the anon-alloc machine property.  This affects
memory-backend-ram objects, guest RAM created with the global -m option
but without an associated memory-backend object and without the -mem-path
option, and various memory regions such as ROMs that are allocated when
devices are created.  This option does not affect memory-backend-file,
memory-backend-memfd, or memory-backend-epc objects.

The memfd option is intended to support new migration modes, in which the
memory region can be transferred in place to a new QEMU process, by sending
the memfd file descriptor to the process.  Memory contents are preserved,
and if the mode also transfers device descriptors, then pages that are
locked in memory for DMA remain locked.  This behavior is a pre-requisite
for supporting vfio, vdpa, and iommufd devices with the new modes.

To access the same memory in the old and new QEMU processes, the memory
must be mapped shared.  Therefore, the implementation always sets
RAM_SHARED if alloc-anon=memfd, except for memory-backend-ram, where the
user must explicitly specify the share option.  In lieu of defining a new
RAM flag, at the lowest level the implementation uses RAM_SHARED with fd=-1
as the condition for calling memfd_create.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/core/machine.c   | 24 ++++++++++++++++++++++++
 include/hw/boards.h |  1 +
 qapi/machine.json   | 14 ++++++++++++++
 qemu-options.hx     | 13 +++++++++++++
 system/memory.c     | 12 +++++++++---
 system/physmem.c    | 38 +++++++++++++++++++++++++++++++++++++-
 system/trace-events |  3 +++
 7 files changed, 101 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 655d75c..7ca2ad0 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -454,6 +454,20 @@ static void machine_set_mem_merge(Object *obj, bool value, Error **errp)
     ms->mem_merge = value;
 }
 
+static int machine_get_anon_alloc(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return ms->anon_alloc;
+}
+
+static void machine_set_anon_alloc(Object *obj, int value, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    ms->anon_alloc = value;
+}
+
 static bool machine_get_usb(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -1066,6 +1080,11 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "mem-merge",
         "Enable/disable memory merge support");
 
+    object_class_property_add_enum(oc, "anon-alloc", "AnonAllocOption",
+                                   &AnonAllocOption_lookup,
+                                   machine_get_anon_alloc,
+                                   machine_set_anon_alloc);
+
     object_class_property_add_bool(oc, "usb",
         machine_get_usb, machine_set_usb);
     object_class_property_set_description(oc, "usb",
@@ -1416,6 +1435,11 @@ static bool create_default_memdev(MachineState *ms, const char *path, Error **er
     if (!object_property_set_int(obj, "size", ms->ram_size, errp)) {
         goto out;
     }
+    if (!object_property_set_bool(obj, "share",
+                                  ms->anon_alloc == ANON_ALLOC_OPTION_MEMFD,
+                                  errp)) {
+        goto out;
+    }
     object_property_add_child(object_get_objects_root(), mc->default_ram_id,
                               obj);
     /* Ensure backend's memory region name is equal to mc->default_ram_id */
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 73ad319..77f16ad 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -383,6 +383,7 @@ struct MachineState {
     bool enable_graphics;
     ConfidentialGuestSupport *cgs;
     HostMemoryBackend *memdev;
+    AnonAllocOption anon_alloc;
     /*
      * convenience alias to ram_memdev_id backend memory region
      * or to numa container memory region
diff --git a/qapi/machine.json b/qapi/machine.json
index 2fd3e9c..9173953 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1881,3 +1881,17 @@
 { 'command': 'x-query-interrupt-controllers',
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ]}
+
+##
+# @AnonAllocOption:
+#
+# An enumeration of the options for allocating anonymous guest memory.
+#
+# @mmap: allocate using mmap MAP_ANON
+#
+# @memfd: allocate using memfd_create
+#
+# Since: 9.1
+##
+{ 'enum': 'AnonAllocOption',
+  'data': [ 'mmap', 'memfd' ] }
diff --git a/qemu-options.hx b/qemu-options.hx
index 8ca7f34..595b693 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -38,6 +38,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                nvdimm=on|off controls NVDIMM support (default=off)\n"
     "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
     "                hmat=on|off controls ACPI HMAT support (default=off)\n"
+    "                anon-alloc=mmap|memfd allocate anonymous guest RAM using mmap MAP_ANON or memfd_create (default: mmap)\n"
     "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
     "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n",
     QEMU_ARCH_ALL)
@@ -101,6 +102,18 @@ SRST
         Enables or disables ACPI Heterogeneous Memory Attribute Table
         (HMAT) support. The default is off.
 
+    ``anon-alloc=mmap|memfd``
+        Allocate anonymous guest RAM using mmap MAP_ANON (the default)
+        or memfd_create.  This affects memory-backend-ram objects,
+        RAM created with the global -m option but without an
+        associated memory-backend object and without the -mem-path
+        option, and various memory regions such as ROMs that are
+        allocated when devices are created.  This option does not
+        affect memory-backend-file, memory-backend-memfd, or
+        memory-backend-epc objects.
+
+        Some migration modes require anon-alloc=memfd.
+
     ``memory-backend='id'``
         An alternative to legacy ``-mem-path`` and ``mem-prealloc`` options.
         Allows to use a memory backend as main RAM.
diff --git a/system/memory.c b/system/memory.c
index 2d69521..28a837d 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1552,8 +1552,10 @@ bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
                                       uint64_t size,
                                       Error **errp)
 {
+    uint32_t flags = (current_machine->anon_alloc == ANON_ALLOC_OPTION_MEMFD) ?
+                     RAM_SHARED : 0;
     return memory_region_init_ram_flags_nomigrate(mr, owner, name,
-                                                  size, 0, errp);
+                                                  size, flags, errp);
 }
 
 bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
@@ -1713,8 +1715,10 @@ bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
                                       uint64_t size,
                                       Error **errp)
 {
+    uint32_t flags = (current_machine->anon_alloc == ANON_ALLOC_OPTION_MEMFD) ?
+                     RAM_SHARED : 0;
     if (!memory_region_init_ram_flags_nomigrate(mr, owner, name,
-                                                size, 0, errp)) {
+                                                size, flags, errp)) {
          return false;
     }
     mr->readonly = true;
@@ -1731,6 +1735,8 @@ bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
                                              Error **errp)
 {
     Error *err = NULL;
+    uint32_t flags = (current_machine->anon_alloc == ANON_ALLOC_OPTION_MEMFD) ?
+                     RAM_SHARED : 0;
     assert(ops);
     memory_region_init(mr, owner, name, size);
     mr->ops = ops;
@@ -1738,7 +1744,7 @@ bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
     mr->terminates = true;
     mr->rom_device = true;
     mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc(size, 0, mr, &err);
+    mr->ram_block = qemu_ram_alloc(size, flags, mr, &err);
     if (err) {
         mr->size = int128_zero();
         object_unparent(OBJECT(mr));
diff --git a/system/physmem.c b/system/physmem.c
index 33d09f7..efe95ff 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -47,6 +47,7 @@
 #include "qemu/qemu-print.h"
 #include "qemu/log.h"
 #include "qemu/memalign.h"
+#include "qemu/memfd.h"
 #include "exec/memory.h"
 #include "exec/ioport.h"
 #include "sysemu/dma.h"
@@ -54,6 +55,7 @@
 #include "sysemu/hw_accel.h"
 #include "sysemu/xen-mapcache.h"
 #include "trace/trace-root.h"
+#include "trace.h"
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
 #include <linux/falloc.h>
@@ -69,6 +71,8 @@
 
 #include "qemu/pmem.h"
 
+#include "qapi/qapi-types-migration.h"
+#include "migration/options.h"
 #include "migration/vmstate.h"
 
 #include "qemu/range.h"
@@ -1828,6 +1832,32 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                 qemu_mutex_unlock_ramlist();
                 return;
             }
+
+        } else if (new_block->flags & RAM_SHARED) {
+            size_t max_length = new_block->max_length;
+            MemoryRegion *mr = new_block->mr;
+            const char *name = memory_region_name(mr);
+
+            new_block->mr->align = QEMU_VMALLOC_ALIGN;
+
+            if (new_block->fd == -1) {
+                new_block->fd = qemu_memfd_create(name, max_length + mr->align,
+                                                  0, 0, 0, errp);
+            }
+
+            if (new_block->fd >= 0) {
+                int mfd = new_block->fd;
+                qemu_set_cloexec(mfd);
+                new_block->host = file_ram_alloc(new_block, max_length, mfd,
+                                                 false, 0, errp);
+            }
+            if (!new_block->host) {
+                qemu_mutex_unlock_ramlist();
+                return;
+            }
+            memory_try_enable_merging(new_block->host, new_block->max_length);
+            free_on_error = true;
+
         } else {
             new_block->host = qemu_anon_ram_alloc(new_block->max_length,
                                                   &new_block->mr->align,
@@ -1911,6 +1941,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         ram_block_notify_add(new_block->host, new_block->used_length,
                              new_block->max_length);
     }
+    trace_ram_block_add(memory_region_name(new_block->mr), new_block->flags,
+                        new_block->fd, new_block->used_length,
+                        new_block->max_length);
     return;
 
 out_free:
@@ -2097,8 +2130,11 @@ RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t maxsz,
                                                      void *host),
                                      MemoryRegion *mr, Error **errp)
 {
+    uint32_t flags = (current_machine->anon_alloc == ANON_ALLOC_OPTION_MEMFD) ?
+                     RAM_SHARED : 0;
+    flags |= RAM_RESIZEABLE;
     return qemu_ram_alloc_internal(size, maxsz, resized, NULL,
-                                   RAM_RESIZEABLE, mr, errp);
+                                   flags, mr, errp);
 }
 
 static void reclaim_ramblock(RAMBlock *block)
diff --git a/system/trace-events b/system/trace-events
index 69c9044..f8ebf42 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -38,3 +38,6 @@ dirtylimit_state_finalize(void)
 dirtylimit_throttle_pct(int cpu_index, uint64_t pct, int64_t time_us) "CPU[%d] throttle percent: %" PRIu64 ", throttle adjust time %"PRIi64 " us"
 dirtylimit_set_vcpu(int cpu_index, uint64_t quota) "CPU[%d] set dirty page rate limit %"PRIu64
 dirtylimit_vcpu_execute(int cpu_index, int64_t sleep_time_us) "CPU[%d] sleep %"PRIi64 " us"
+
+#physmem.c
+ram_block_add(const char *name, uint32_t flags, int fd, size_t used_length, size_t max_length) "%s, flags %u, fd %d, len %lu, maxlen %lu"
-- 
1.8.3.1


