Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68784C36011
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 14:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txoaz-0004g8-Bs; Thu, 27 Mar 2025 10:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1txoaq-0004aw-RY
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:52:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1txoal-0007mJ-Tf
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:52:28 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RCTLin027032;
 Thu, 27 Mar 2025 14:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2023-11-20; bh=/oGiHv9w
 UeBDC0FpA6TOCJgiUoDG0a8Qu4dW23KG/rU=; b=Keo20Z/BE3YzTaNByOgwUd5R
 noHzEkotXHQrRIHMSdyrBYY+hXxgCMqWfB96eE6T1EjbTH5mk0wLFCU89V1cNAga
 UlWE4qERZ5Y1u7bqKsCSV78/DTZw36xQifanh37QYM2cKK3KFuPi8tW0ngrXOAfy
 LCswRuhnAzI8MrOckPgVYJrqeW3GpUvLQsye33vDBHmCe61MAB3DcJXBcrwhAM9h
 pQciDowNxTZXVZSsAm5bWmnBW4IdP4T7Iubd0Ne0Tu982g7smDuNXxIwm3iDUraM
 /jDqBrk+q4ImiFn5AX3io3c3dYt0yhapYhaaRAbL5PvuJutRfj+5WY4/cpS2sQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn874qvb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Mar 2025 14:52:19 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52RDKT6A023050; Thu, 27 Mar 2025 14:52:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45jjcgqq1w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Mar 2025 14:52:18 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52REqH7L009100;
 Thu, 27 Mar 2025 14:52:17 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 45jjcgqpw0-1; Thu, 27 Mar 2025 14:52:17 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2] migration: cpr breaks SNP guest
Date: Thu, 27 Mar 2025 07:52:10 -0700
Message-Id: <1743087130-429075-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503270101
X-Proofpoint-GUID: dTvbSQBvncC81kab_KZy-2f2y7ORcKPz
X-Proofpoint-ORIG-GUID: dTvbSQBvncC81kab_KZy-2f2y7ORcKPz
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

With aux-ram-share=off, booting an SNP guest fails with:

  ../util/error.c:68: error_setv: Assertion `*errp == NULL' failed.

This is because a CPR blocker for the guest_memfd ramblock is added
twice, once in ram_block_add_cpr_blocker because aux-ram-share=off so
rb->fd < 0, and once in ram_block_add for a specific guest_memfd blocker.

To fix, add the guest_memfd blocker iff a generic one would not be
added by ram_block_add_cpr_blocker.

Fixes: 094a3dbc55df ("migration: ram block cpr blockers")
Reported-by: Tom Lendacky <thomas.lendacky@amd.com>
Reported-by: Michael Roth <michael.roth@amd.com>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 system/physmem.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index e97de3e..333a5eb 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -158,6 +158,7 @@ static void io_mem_init(void);
 static void memory_map_init(void);
 static void tcg_log_global_after_sync(MemoryListener *listener);
 static void tcg_commit(MemoryListener *listener);
+static bool ram_is_cpr_compatible(RAMBlock *rb);
 
 /**
  * CPUAddressSpace: all the information a CPU needs about an AddressSpace
@@ -1908,13 +1909,18 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             goto out_free;
         }
 
-        error_setg(&new_block->cpr_blocker,
-                   "Memory region %s uses guest_memfd, "
-                   "which is not supported with CPR.",
-                   memory_region_name(new_block->mr));
-        migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
-                                  MIG_MODE_CPR_TRANSFER,
-                                  -1);
+        /*
+         * Add a specific guest_memfd blocker if a generic one would not be
+         * added by ram_block_add_cpr_blocker.
+         */
+        if (ram_is_cpr_compatible(new_block)) {
+            error_setg(&new_block->cpr_blocker,
+                       "Memory region %s uses guest_memfd, "
+                       "which is not supported with CPR.",
+                       memory_region_name(new_block->mr));
+            migrate_add_blocker_modes(&new_block->cpr_blocker, errp,
+                                      MIG_MODE_CPR_TRANSFER, -1);
+        }
     }
 
     ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;
-- 
1.8.3.1


