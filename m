Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151E3E7718E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 16:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ7b2-00033Z-GN; Tue, 24 Dec 2024 11:17:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tQ7ay-00031R-3A
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:17:20 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tQ7aw-00039q-3T
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:17:19 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOEfZBE013114;
 Tue, 24 Dec 2024 16:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=X7tlMCUS/pe0rYbAxZWEdnFp1ET9KC5GRBfBDrcPckc=; b=
 bi1VttGFh8EuFsKEKZZUJweB8DaXliE9r8x6CuvSTONGh1pYTv/Zp9hR/RtaxUNg
 vdD3UIZDExfyV8yiVfKCl+1gOeYmwwR42VyGVCYZ5qmPiNKO6fBlCZ3zh2wP+tqI
 pUXlloEdvWp73gMn+uSYcIwT3NrXtWIM1YyBpZdxZJRiylod5ODdrtN2A7goHUpK
 Nmj49MR/Okz5GwHd4CaL6rETEl2HQmiUI0a0NNAGooSU+b1TjYczqzAS66ZW47Px
 iKDkbDFwrxS+1q+2zZzyEx0Y83DUWXBqbaNggv57Etxd6aD8FzTkda7Rk6nVyQfJ
 Raw71SkAoU0yCkIPLKgqAw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq6sch4f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Dec 2024 16:17:14 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BOFLbUQ022596; Tue, 24 Dec 2024 16:17:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43nm484gja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Dec 2024 16:17:13 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BOGH9XQ021973;
 Tue, 24 Dec 2024 16:17:12 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 43nm484ggj-6; Tue, 24 Dec 2024 16:17:12 +0000
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
Subject: [PATCH V5 05/23] machine: aux-ram-share option
Date: Tue, 24 Dec 2024 08:16:50 -0800
Message-Id: <1735057028-308595-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_06,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412240141
X-Proofpoint-ORIG-GUID: 7jWrwsd0gCC4xwwOP3_ynMlmkpXlaQsq
X-Proofpoint-GUID: 7jWrwsd0gCC4xwwOP3_ynMlmkpXlaQsq
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Allocate auxilliary guest RAM as an anonymous file that is shareable
with an external process.  This option applies to memory allocated as
a side effect of creating various devices. It does not apply to
memory-backend-objects, whether explicitly specified on the command
line, or implicitly created by the -m command line option.

This option is intended to support new migration modes, in which the
memory region can be transferred in place to a new QEMU process, by sending
the memfd file descriptor to the process.  Memory contents are preserved,
and if the mode also transfers device descriptors, then pages that are
locked in memory for DMA remain locked.  This behavior is a pre-requisite
for supporting vfio, vdpa, and iommufd devices with the new modes.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 hw/core/machine.c   | 20 ++++++++++++++++++++
 include/hw/boards.h |  1 +
 qemu-options.hx     | 11 +++++++++++
 system/physmem.c    |  3 +++
 4 files changed, 35 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index c949af9..75c8cba 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -455,6 +455,20 @@ static void machine_set_mem_merge(Object *obj, bool value, Error **errp)
     ms->mem_merge = value;
 }
 
+static bool machine_get_aux_ram_share(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return ms->aux_ram_share;
+}
+
+static void machine_set_aux_ram_share(Object *obj, bool value, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    ms->aux_ram_share = value;
+}
+
 static bool machine_get_usb(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -1160,6 +1174,12 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "mem-merge",
         "Enable/disable memory merge support");
 
+#ifdef CONFIG_POSIX
+    object_class_property_add_bool(oc, "aux-ram-share",
+                                   machine_get_aux_ram_share,
+                                   machine_set_aux_ram_share);
+#endif
+
     object_class_property_add_bool(oc, "usb",
         machine_get_usb, machine_set_usb);
     object_class_property_set_description(oc, "usb",
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 2ad711e..e1f41b2 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -410,6 +410,7 @@ struct MachineState {
     bool enable_graphics;
     ConfidentialGuestSupport *cgs;
     HostMemoryBackend *memdev;
+    bool aux_ram_share;
     /*
      * convenience alias to ram_memdev_id backend memory region
      * or to numa container memory region
diff --git a/qemu-options.hx b/qemu-options.hx
index cc694d3..b1f56b7 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -38,6 +38,9 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                nvdimm=on|off controls NVDIMM support (default=off)\n"
     "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
     "                hmat=on|off controls ACPI HMAT support (default=off)\n"
+#ifdef CONFIG_POSIX
+    "                aux-ram-share=on|off allocate auxiliary guest RAM as shared (default: off)\n"
+#endif
     "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
     "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n",
     QEMU_ARCH_ALL)
@@ -101,6 +104,14 @@ SRST
         Enables or disables ACPI Heterogeneous Memory Attribute Table
         (HMAT) support. The default is off.
 
+    ``aux-ram-share=on|off``
+        Allocate auxiliary guest RAM as an anonymous file that is
+        shareable with an external process.  This option applies to
+        memory allocated as a side effect of creating various devices.
+        It does not apply to memory-backend-objects, whether explicitly
+        specified on the command line, or implicitly created by the -m
+        command line option.  The default is off.
+
     ``memory-backend='id'``
         An alternative to legacy ``-mem-path`` and ``mem-prealloc`` options.
         Allows to use a memory backend as main RAM.
diff --git a/system/physmem.c b/system/physmem.c
index eb1c3a7..0e629ee 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2112,6 +2112,9 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
 
 #ifdef CONFIG_POSIX         /* ignore RAM_SHARED for Windows */
     if (!host) {
+        if (!share_flags && current_machine->aux_ram_share) {
+            ram_flags |= RAM_SHARED;
+        }
         if (ram_flags & RAM_SHARED) {
             const char *name = memory_region_name(mr);
             int fd = qemu_ram_get_shared_fd(name, errp);
-- 
1.8.3.1


