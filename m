Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7534E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 17:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXkeM-0004nz-Tu; Tue, 14 Jan 2025 12:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXkeD-0004lE-UB
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:24:14 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXkeB-0004Rw-5q
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:24:13 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EC0mP7012488;
 Tue, 14 Jan 2025 17:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=OKuyyIMZRWX+ruf8O7EPA3ln+FvBTA9Ji4elaAsQCVM=; b=
 h4j7BVFbEVJPZB4z4occezgW/CKaAd3fYYrFybNVukz8AX7Yp60BTICNlIi3qD8E
 Kd6ppEf8/n6cqHVrvKVCC3Kz/HMASCMgal22JA3Ng6zFTI49nGpP/qEq9xSkbJSw
 6thPBGebfPv5EzhTnQsyIbl7sdMYG0u/PNXeCpGjyvd/5JtTnHxXG7hnzThVR43u
 ni1DWF+i5WemkLnb7dhEQ8y/UrtfFKQuSqhF6K6nAyX4/1aRBkW4Vhi9qTxLekAQ
 xoID2gIa3i1XxFQoHaXaXdUeCPJn/DtQap53Hy7FNoQGBMNlrtqvKgQiTsL3agdc
 P9Bc/S+VFZGIcrWM+vdiYw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fe2eabn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 17:24:08 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50EHArUb020486; Tue, 14 Jan 2025 17:24:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 443f3eq67k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 17:24:08 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50EHNtXe013352;
 Tue, 14 Jan 2025 17:24:07 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 443f3eq5us-6; Tue, 14 Jan 2025 17:24:07 +0000
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
Subject: [PATCH V6 05/24] memory: add RAM_PRIVATE
Date: Tue, 14 Jan 2025 09:23:35 -0800
Message-Id: <1736875434-106563-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
References: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_05,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501140133
X-Proofpoint-ORIG-GUID: NXIE0bICi4p8LGEriJt_pzYsekZVV4qK
X-Proofpoint-GUID: NXIE0bICi4p8LGEriJt_pzYsekZVV4qK
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

Define the RAM_PRIVATE flag.

In RAMBlock creation functions, if MAP_SHARED is 0 in the flags parameter,
in a subsequent patch the implementation may still create a shared mapping
if other conditions require it.  Callers who specifically want a private
mapping, eg for objects specified by the user, must pass RAM_PRIVATE.

After RAMBlock creation, MAP_SHARED in the block's flags indicates whether
the block is shared or private, and MAP_PRIVATE is omitted.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 backends/hostmem-epc.c   |  2 +-
 backends/hostmem-file.c  |  2 +-
 backends/hostmem-memfd.c |  2 +-
 backends/hostmem-ram.c   |  2 +-
 include/exec/memory.h    | 10 ++++++++++
 system/physmem.c         | 15 ++++++++++++---
 6 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/backends/hostmem-epc.c b/backends/hostmem-epc.c
index eb4b95d..1fa2d03 100644
--- a/backends/hostmem-epc.c
+++ b/backends/hostmem-epc.c
@@ -36,7 +36,7 @@ sgx_epc_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 
     backend->aligned = true;
     name = object_get_canonical_path(OBJECT(backend));
-    ram_flags = (backend->share ? RAM_SHARED : 0) | RAM_PROTECTED;
+    ram_flags = (backend->share ? RAM_SHARED : RAM_PRIVATE) | RAM_PROTECTED;
     return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
                                           backend->size, ram_flags, fd, 0, errp);
 }
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 46321fd..691a827 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -82,7 +82,7 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 
     backend->aligned = true;
     name = host_memory_backend_get_name(backend);
-    ram_flags = backend->share ? RAM_SHARED : 0;
+    ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     ram_flags |= fb->readonly ? RAM_READONLY_FD : 0;
     ram_flags |= fb->rom == ON_OFF_AUTO_ON ? RAM_READONLY : 0;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index d4d0620..1672da9 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -52,7 +52,7 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 
     backend->aligned = true;
     name = host_memory_backend_get_name(backend);
-    ram_flags = backend->share ? RAM_SHARED : 0;
+    ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
     ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
     return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend), name,
diff --git a/backends/hostmem-ram.c b/backends/hostmem-ram.c
index 39aac6b..868ae6c 100644
--- a/backends/hostmem-ram.c
+++ b/backends/hostmem-ram.c
@@ -28,7 +28,7 @@ ram_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     }
 
     name = host_memory_backend_get_name(backend);
-    ram_flags = backend->share ? RAM_SHARED : 0;
+    ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
     ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
     ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
     return memory_region_init_ram_flags_nomigrate(&backend->mr, OBJECT(backend),
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9458e28..0ac21cc 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -246,6 +246,16 @@ typedef struct IOMMUTLBEvent {
 /* RAM can be private that has kvm guest memfd backend */
 #define RAM_GUEST_MEMFD   (1 << 12)
 
+/*
+ * In RAMBlock creation functions, if MAP_SHARED is 0 in the flags parameter,
+ * the implementation may still create a shared mapping if other conditions
+ * require it.  Callers who specifically want a private mapping, eg objects
+ * specified by the user, must pass RAM_PRIVATE.
+ * After RAMBlock creation, MAP_SHARED in the block's flags indicates whether
+ * the block is shared or private, and MAP_PRIVATE is omitted.
+ */
+#define RAM_PRIVATE (1 << 13)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end,
diff --git a/system/physmem.c b/system/physmem.c
index e435564..03fac0a 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1952,7 +1952,11 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
     ERRP_GUARD();
     RAMBlock *new_block;
     Error *local_err = NULL;
-    int64_t file_size, file_align;
+    int64_t file_size, file_align, share_flags;
+
+    share_flags = ram_flags & (RAM_PRIVATE | RAM_SHARED);
+    assert(share_flags != (RAM_SHARED | RAM_PRIVATE));
+    ram_flags &= ~RAM_PRIVATE;
 
     /* Just support these ram flags by now. */
     assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
@@ -2097,7 +2101,11 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
 {
     RAMBlock *new_block;
     Error *local_err = NULL;
-    int align;
+    int align, share_flags;
+
+    share_flags = ram_flags & (RAM_PRIVATE | RAM_SHARED);
+    assert(share_flags != (RAM_SHARED | RAM_PRIVATE));
+    ram_flags &= ~RAM_PRIVATE;
 
     assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
                           RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
@@ -2172,7 +2180,8 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
 RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags,
                          MemoryRegion *mr, Error **errp)
 {
-    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
+    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD |
+                          RAM_PRIVATE)) == 0);
     return qemu_ram_alloc_internal(size, size, NULL, NULL, ram_flags, mr, errp);
 }
 
-- 
1.8.3.1


