Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB064C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 19:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY8dW-0007FH-5F; Wed, 15 Jan 2025 14:01:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tY8dS-0007Cc-G9
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:01:02 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tY8dO-0005b2-Ep
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:01:02 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHtlDn025376;
 Wed, 15 Jan 2025 19:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=AubhBZD1dgpU5Xm/g4C6L634IB5m+rk1ogOnBDGLCuM=; b=
 k4dPUEwjngETmYNwZ2K4gokPZf431qZSSuAB6AYrev6CQmMGsXRTd6MMiXSld3Rc
 JDD/h98EZBVmYjBTUSwloVBm1Rwo+kkDdmzp5PdwT/ip+nCdWUgU60wgSDrzrp0O
 Ijajo1ERIZ2nQnq0FNJg89d9WyiMY68FRvuAn7vTdRI3kZMaYrOPOJ2S5zuh5SWU
 inZLWLmHYDNDeSEFKOpLj6KcE6q4+duTrBFah6ovXzkx4oWrwQLGn87erQPW9dLP
 qTWirhISEilMKGWopHurrq81aRMKLUjrffxSMjs4HWc+dC7ebbJUQtqyhDu1enWZ
 93C5BJZNmk0Md8HOG2MMng==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443gpcrx9m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 19:00:54 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50FI21vZ033608; Wed, 15 Jan 2025 19:00:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 443f39uqy6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 19:00:53 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50FJ0pdv016497;
 Wed, 15 Jan 2025 19:00:53 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 443f39uqwr-3; Wed, 15 Jan 2025 19:00:53 +0000
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
Subject: [PATCH V7 02/24] physmem: fix qemu_ram_alloc_from_fd size calculation
Date: Wed, 15 Jan 2025 11:00:28 -0800
Message-Id: <1736967650-129648-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
References: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501150138
X-Proofpoint-GUID: 3r4lbUNSibHHHAweHLFFmpnHVwXNMvBQ
X-Proofpoint-ORIG-GUID: 3r4lbUNSibHHHAweHLFFmpnHVwXNMvBQ
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

qemu_ram_alloc_from_fd allocates space if file_size == 0.  If non-zero,
it uses the existing space and verifies it is large enough, but the
verification was broken when the offset parameter was introduced.  As
a result, a file smaller than offset passes the verification and causes
errors later.  Fix that, and update the error message to include offset.

Peter provides this concise reproducer:

  $ touch ramfile
  $ truncate -s 64M ramfile
  $ ./qemu-system-x86_64 -object memory-backend-file,mem-path=./ramfile,offset=128M,size=128M,id=mem1,prealloc=on
  qemu-system-x86_64: qemu_prealloc_mem: preallocating memory failed: Bad address

With the fix, the error message is:
  qemu-system-x86_64: mem1 backing store size 0x4000000 is too small for 'size' option 0x8000000 plus 'offset' option 0x8000000

Cc: qemu-stable@nongnu.org
Fixes: 4b870dc4d0c0 ("hostmem-file: add offset option")
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 system/physmem.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index c76503a..792844d 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1970,10 +1970,12 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     size = REAL_HOST_PAGE_ALIGN(size);
 
     file_size = get_file_size(fd);
-    if (file_size > offset && file_size < (offset + size)) {
-        error_setg(errp, "backing store size 0x%" PRIx64
-                   " does not match 'size' option 0x" RAM_ADDR_FMT,
-                   file_size, size);
+    if (file_size && file_size < offset + size) {
+        error_setg(errp, "%s backing store size 0x%" PRIx64
+                   " is too small for 'size' option 0x" RAM_ADDR_FMT
+                   " plus 'offset' option 0x%" PRIx64,
+                   memory_region_name(mr), file_size, size,
+                   (uint64_t)offset);
         return NULL;
     }
 
-- 
1.8.3.1


