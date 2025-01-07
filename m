Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54736E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCV3-0003Xx-EN; Tue, 07 Jan 2025 11:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tVCUw-0003Wv-OZ; Tue, 07 Jan 2025 11:32:07 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tVCUu-0003hv-1W; Tue, 07 Jan 2025 11:32:06 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507GBich012354;
 Tue, 7 Jan 2025 16:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2023-11-20; bh=AubhBZD1
 dgpU5Xm/g4C6L634IB5m+rk1ogOnBDGLCuM=; b=nJtumi+BDTVtC+ip9Oy2RT8L
 qha0RY32KOUpd7IdTrTqVHfNM/Bo/gtSPwts6ptK3Dz/SpajPhZwf9iNiOwFYJac
 2CFyJUHnQnx3l5pN8Ds/feqTKx4MaQFidb18XxWIK/eGnmxmvd9sLJ4QSck8rccz
 12rmY+RPSnFV2F5EaLOJyBcvKJQkeGEfVqxwb/fsL4AW+NMIdG9k4GXv0LCHBLWm
 bDGwgFE27KrKFkk0+A8yyri3eWpGzRaNp1YmnO8Iship5vp4KzLn5JhkljXO66C6
 CwzGirSukeHNI8Ffegvu7FqIDAT1+fUcSRCNHsV0tLEi4zarpfdvQFwlChNgqw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuwb55ay-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Jan 2025 16:32:00 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 507FCibe011240; Tue, 7 Jan 2025 16:31:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43xue8g5t0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Jan 2025 16:31:59 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 507GVw8H031266;
 Tue, 7 Jan 2025 16:31:58 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 43xue8g5rv-1; Tue, 07 Jan 2025 16:31:58 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3] physmem: fix qemu_ram_alloc_from_fd size calculation
Date: Tue,  7 Jan 2025 08:31:57 -0800
Message-Id: <1736267517-338203-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-07_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501070137
X-Proofpoint-GUID: SP-8CV2PUWVhvOAjJVjBTHNizEjXWNYb
X-Proofpoint-ORIG-GUID: SP-8CV2PUWVhvOAjJVjBTHNizEjXWNYb
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.37,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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


