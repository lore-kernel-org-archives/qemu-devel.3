Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8119FCDD1D5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 19:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svMGW-0006s9-VS; Mon, 30 Sep 2024 15:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1svMGT-0006pb-N9
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:41:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1svMGR-00020g-7i
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 15:41:01 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UIuavs010900;
 Mon, 30 Sep 2024 19:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=XPUCEy1XwbNzVfK9wtX+YFAg5j38iy3gw15i0pRy/L0=; b=
 aGWCDr4NCUDZ/zE31PWy1OVh9l7puV00LT0KQlRJ4GHjfX+/EUIrPpLAqPXhziCj
 eUM8yj3YovqpBHHIki2LcmiwNAi0rcQcRHhsfacw/7QUkGP//AWVd6QnxiEl3D8L
 PfnoDg9/cyTBG6FSmOi2ggFZGwcMrqPazJJoW+S7vv6z/Xj+OPdHZZaSBxJ+gW7K
 Wx2Elw96KSqhAChBlrhzWo1KnZchYJMx2rNEAZS2pTg0+GOcZ7mZ/mM9HHp+Dt0N
 jDPM5VEXuC9WO4L3btjt8RlvxB2dAlpZMLn6iYaC2k7asj49W8HYEAqSL76iqvkz
 B89bUwp+P0vX+VDQxqCVdg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9ucmpv4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 19:40:54 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48UIsC2m012568; Mon, 30 Sep 2024 19:40:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41x8868tsf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 19:40:53 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48UJepUk028204;
 Mon, 30 Sep 2024 19:40:53 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 41x8868thj-2; Mon, 30 Sep 2024 19:40:53 +0000
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
Subject: [PATCH V2 01/13] machine: alloc-anon option
Date: Mon, 30 Sep 2024 12:40:32 -0700
Message-Id: <1727725244-105198-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_19,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409300142
X-Proofpoint-GUID: lrVHDFyKKakh7TzuWoYXuZ2LaiJjZDFP
X-Proofpoint-ORIG-GUID: lrVHDFyKKakh7TzuWoYXuZ2LaiJjZDFP
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
on the value of the anon-alloc machine property.  This option applies to
memory allocated as a side effect of creating various devices. It does
not apply to memory-backend-objects, whether explicitly specified on
the command line, or implicitly created by the -m command line option.

The memfd option is intended to support new migration modes, in which the
memory region can be transferred in place to a new QEMU process, by sending
the memfd file descriptor to the process.  Memory contents are preserved,
and if the mode also transfers device descriptors, then pages that are
locked in memory for DMA remain locked.  This behavior is a pre-requisite
for supporting vfio, vdpa, and iommufd devices with the new modes.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/core/machine.c   | 19 +++++++++++++++++++
 include/hw/boards.h |  1 +
 qapi/machine.json   | 14 ++++++++++++++
 qemu-options.hx     | 11 +++++++++++
 system/physmem.c    | 35 +++++++++++++++++++++++++++++++++++
 system/trace-events |  3 +++
 6 files changed, 83 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index adaba17..a89a32b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -460,6 +460,20 @@ static void machine_set_mem_merge(Object *obj, bool value, Error **errp)
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
@@ -1078,6 +1092,11 @@ static void machine_class_init(ObjectClass *oc, void *data)
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
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 5966069..5a87647 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -393,6 +393,7 @@ struct MachineState {
     bool enable_graphics;
     ConfidentialGuestSupport *cgs;
     HostMemoryBackend *memdev;
+    AnonAllocOption anon_alloc;
     /*
      * convenience alias to ram_memdev_id backend memory region
      * or to numa container memory region
diff --git a/qapi/machine.json b/qapi/machine.json
index a6b8795..d4a63f5 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1898,3 +1898,17 @@
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
+# Since: 9.2
+##
+{ 'enum': 'AnonAllocOption',
+  'data': [ 'mmap', 'memfd' ] }
diff --git a/qemu-options.hx b/qemu-options.hx
index d94e2cb..90ab943 100644
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
@@ -101,6 +102,16 @@ SRST
         Enables or disables ACPI Heterogeneous Memory Attribute Table
         (HMAT) support. The default is off.
 
+    ``anon-alloc=mmap|memfd``
+        Allocate anonymous guest RAM using mmap MAP_ANON (the default)
+        or memfd_create.  This option applies to memory allocated as a
+        side effect of creating various devices. It does not apply to
+        memory-backend-objects, whether explicitly specified on the
+        command line, or implicitly created by the -m command line
+        option.
+
+        Some migration modes require anon-alloc=memfd.
+
     ``memory-backend='id'``
         An alternative to legacy ``-mem-path`` and ``mem-prealloc`` options.
         Allows to use a memory backend as main RAM.
diff --git a/system/physmem.c b/system/physmem.c
index dc1db3a..174f7e0 100644
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
@@ -69,6 +70,8 @@
 
 #include "qemu/pmem.h"
 
+#include "qapi/qapi-types-migration.h"
+#include "migration/options.h"
 #include "migration/vmstate.h"
 
 #include "qemu/range.h"
@@ -1849,6 +1852,35 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                 qemu_mutex_unlock_ramlist();
                 return;
             }
+
+        } else if (current_machine->anon_alloc == ANON_ALLOC_OPTION_MEMFD &&
+                   !object_dynamic_cast(new_block->mr->parent_obj.parent,
+                                        TYPE_MEMORY_BACKEND)) {
+            size_t max_length = new_block->max_length;
+            MemoryRegion *mr = new_block->mr;
+            const char *name = memory_region_name(mr);
+
+            new_block->mr->align = QEMU_VMALLOC_ALIGN;
+            new_block->flags |= RAM_SHARED;
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
@@ -1932,6 +1964,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         ram_block_notify_add(new_block->host, new_block->used_length,
                              new_block->max_length);
     }
+    trace_ram_block_add(memory_region_name(new_block->mr), new_block->flags,
+                        new_block->fd, new_block->used_length,
+                        new_block->max_length);
     return;
 
 out_free:
diff --git a/system/trace-events b/system/trace-events
index 074d001..4669411 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -47,3 +47,6 @@ dirtylimit_vcpu_execute(int cpu_index, int64_t sleep_time_us) "CPU[%d] sleep %"P
 
 # cpu-throttle.c
 cpu_throttle_set(int new_throttle_pct)  "set guest CPU throttled by %d%%"
+
+#physmem.c
+ram_block_add(const char *name, uint32_t flags, int fd, size_t used_length, size_t max_length) "%s, flags %u, fd %d, len %lu, maxlen %lu"
-- 
1.8.3.1


