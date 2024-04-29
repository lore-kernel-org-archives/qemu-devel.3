Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19DBC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 15:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1TMS-0004hB-8t; Mon, 29 Apr 2024 11:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TML-0004bH-Ut
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s1TMJ-0005IS-S7
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 11:56:05 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TFmtkg024859; Mon, 29 Apr 2024 15:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=OdRX+jRtvCW98UOUiTtcK+L9U7QTWnTC0birZ0CkFpo=;
 b=Pul2sqwYCFTihXbG5RSDBsfveEpdnEeGYu9jy+wXEjw7uw5f67hgvevBmeaXRyXzaxuG
 NGCPSBk8m9kVJHlaHXN8dgU2laXkgqxCP7aK5aOSs2Vfk+97i57ya8uQ1CTSMVMAhk4A
 iy+/OjE79LPaF4i4zUBowBojuBM4qoeGiyKzbR0mZd9u81qyQY8KvkfMp5pqXFAvzswA
 1iH+Cg5ftu5eXG4CAVXgIIoi2leREabqzp9tJZvUzKQ+uaK02e+w0BhWy497jGdby4Tk
 r20aJJ7ycFDUBRdRHf38f6MKtBHfxxKd8+Vyk5zfE+i4e01bUQ1VrNeSjF9TFNnKvTae Cw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqsetx45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:50 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43TFAtvA011379; Mon, 29 Apr 2024 15:55:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt6j6fq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 15:55:49 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TFtaH2034442;
 Mon, 29 Apr 2024 15:55:48 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3xrqt6j5ys-18; Mon, 29 Apr 2024 15:55:48 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 17/26] machine: memfd-alloc option
Date: Mon, 29 Apr 2024 08:55:26 -0700
Message-Id: <1714406135-451286-18-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_14,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290101
X-Proofpoint-ORIG-GUID: XsjXw9QE5dA8AOJ-8O-ijpBV7uylLDNE
X-Proofpoint-GUID: XsjXw9QE5dA8AOJ-8O-ijpBV7uylLDNE
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Allocate anonymous memory using memfd_create if the memfd-alloc machine
option is set.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/core/machine.c   | 22 ++++++++++++++++++++++
 include/hw/boards.h |  1 +
 qemu-options.hx     |  6 ++++++
 system/memory.c     |  9 ++++++---
 system/physmem.c    | 18 +++++++++++++++++-
 system/trace-events |  1 +
 6 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 582c2df..9567b97 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -443,6 +443,20 @@ static void machine_set_mem_merge(Object *obj, bool value, Error **errp)
     ms->mem_merge = value;
 }
 
+static bool machine_get_memfd_alloc(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return ms->memfd_alloc;
+}
+
+static void machine_set_memfd_alloc(Object *obj, bool value, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    ms->memfd_alloc = value;
+}
+
 static bool machine_get_usb(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -1044,6 +1058,11 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "mem-merge",
         "Enable/disable memory merge support");
 
+    object_class_property_add_bool(oc, "memfd-alloc",
+        machine_get_memfd_alloc, machine_set_memfd_alloc);
+    object_class_property_set_description(oc, "memfd-alloc",
+        "Enable/disable allocating anonymous memory using memfd_create");
+
     object_class_property_add_bool(oc, "usb",
         machine_get_usb, machine_set_usb);
     object_class_property_set_description(oc, "usb",
@@ -1387,6 +1406,9 @@ static bool create_default_memdev(MachineState *ms, const char *path, Error **er
     if (!object_property_set_int(obj, "size", ms->ram_size, errp)) {
         goto out;
     }
+    if (!object_property_set_bool(obj, "share", ms->memfd_alloc, errp)) {
+        goto out;
+    }
     object_property_add_child(object_get_objects_root(), mc->default_ram_id,
                               obj);
     /* Ensure backend's memory region name is equal to mc->default_ram_id */
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 69c1ba4..96259c3 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -372,6 +372,7 @@ struct MachineState {
     bool dump_guest_core;
     bool mem_merge;
     bool require_guest_memfd;
+    bool memfd_alloc;
     bool usb;
     bool usb_disabled;
     char *firmware;
diff --git a/qemu-options.hx b/qemu-options.hx
index cf61f6b..f0dfda5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -32,6 +32,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
     "                dump-guest-core=on|off include guest memory in a core dump (default=on)\n"
     "                mem-merge=on|off controls memory merge support (default: on)\n"
+    "                memfd-alloc=on|off controls allocating anonymous guest RAM using memfd_create (default: off)\n"
     "                aes-key-wrap=on|off controls support for AES key wrapping (default=on)\n"
     "                dea-key-wrap=on|off controls support for DEA key wrapping (default=on)\n"
     "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
@@ -79,6 +80,11 @@ SRST
         supported by the host, de-duplicates identical memory pages
         among VMs instances (enabled by default).
 
+    ``memfd-alloc=on|off``
+        Enables or disables allocation of anonymous guest RAM using
+        memfd_create.  Any associated memory-backend objects are created with
+        share=on.  The memfd-alloc default is off.
+
     ``aes-key-wrap=on|off``
         Enables or disables AES key wrapping support on s390-ccw hosts.
         This feature controls whether AES wrapping keys will be created
diff --git a/system/memory.c b/system/memory.c
index 49f1cb2..ca04a0e 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1552,8 +1552,9 @@ bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
                                       uint64_t size,
                                       Error **errp)
 {
+    uint32_t flags = current_machine->memfd_alloc ? RAM_SHARED : 0;
     return memory_region_init_ram_flags_nomigrate(mr, owner, name,
-                                                  size, 0, errp);
+                                                  size, flags, errp);
 }
 
 bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
@@ -1713,8 +1714,9 @@ bool memory_region_init_rom_nomigrate(MemoryRegion *mr,
                                       uint64_t size,
                                       Error **errp)
 {
+    uint32_t flags = current_machine->memfd_alloc ? RAM_SHARED : 0;
     if (!memory_region_init_ram_flags_nomigrate(mr, owner, name,
-                                                size, 0, errp)) {
+                                                size, flags, errp)) {
          return false;
     }
     mr->readonly = true;
@@ -1731,6 +1733,7 @@ bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
                                              Error **errp)
 {
     Error *err = NULL;
+    uint32_t flags = current_machine->memfd_alloc ? RAM_SHARED : 0;
     assert(ops);
     memory_region_init(mr, owner, name, size);
     mr->ops = ops;
@@ -1738,7 +1741,7 @@ bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
     mr->terminates = true;
     mr->rom_device = true;
     mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc(size, 0, mr, &err);
+    mr->ram_block = qemu_ram_alloc(size, flags, mr, &err);
     if (err) {
         mr->size = int128_zero();
         object_unparent(OBJECT(mr));
diff --git a/system/physmem.c b/system/physmem.c
index c736af5..36d97ec 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -45,6 +45,7 @@
 #include "qemu/qemu-print.h"
 #include "qemu/log.h"
 #include "qemu/memalign.h"
+#include "qemu/memfd.h"
 #include "exec/memory.h"
 #include "exec/ioport.h"
 #include "sysemu/dma.h"
@@ -1825,6 +1826,19 @@ static void *ram_block_alloc_host(RAMBlock *rb, Error **errp)
     if (xen_enabled()) {
         xen_ram_alloc(rb->offset, rb->max_length, mr, errp);
 
+    } else if (rb->flags & RAM_SHARED) {
+        if (rb->fd == -1) {
+            mr->align = QEMU_VMALLOC_ALIGN;
+            rb->fd = qemu_memfd_create(rb->idstr, rb->max_length + mr->align,
+                                       0, 0, 0, errp);
+        }
+        if (rb->fd >= 0) {
+            int mfd = rb->fd;
+            qemu_set_cloexec(mfd);
+            host = file_ram_alloc(rb, rb->max_length, mfd, false, 0, errp);
+            trace_qemu_anon_memfd_alloc(rb->idstr, rb->max_length, mfd, host);
+        }
+
     } else {
         host = qemu_anon_ram_alloc(rb->max_length, &mr->align,
                                    qemu_ram_is_shared(rb),
@@ -2106,8 +2120,10 @@ RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t maxsz,
                                                      void *host),
                                      MemoryRegion *mr, Error **errp)
 {
+    uint32_t flags = current_machine->memfd_alloc ? RAM_SHARED : 0;
+    flags |= RAM_RESIZEABLE;
     return qemu_ram_alloc_internal(size, maxsz, resized, NULL,
-                                   RAM_RESIZEABLE, mr, errp);
+                                   flags, mr, errp);
 }
 
 static void reclaim_ramblock(RAMBlock *block)
diff --git a/system/trace-events b/system/trace-events
index f0a80ba..0092734 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -41,3 +41,4 @@ dirtylimit_vcpu_execute(int cpu_index, int64_t sleep_time_us) "CPU[%d] sleep %"P
 
 # physmem.c
 ram_block_create(const char *name, uint32_t flags, int fd, size_t used_length, size_t max_length, size_t align) "%s, flags %u, fd %d, len %lu, maxlen %lu, align %lu"
+qemu_anon_memfd_alloc(const char *name, size_t size, int fd, void *ptr) "%s size %zu fd %d -> %p"
-- 
1.8.3.1


