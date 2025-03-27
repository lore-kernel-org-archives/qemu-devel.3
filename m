Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD48C36011
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 13:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txnPc-0007tw-Ab; Thu, 27 Mar 2025 09:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1txnPa-0007tW-Pp
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 09:36:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1txnPY-0006Du-LA
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 09:36:46 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RCT3oY002906;
 Thu, 27 Mar 2025 13:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2023-11-20; bh=gBiSO0xc
 BsE3DfqIVxokL31I4pL9pAR9foOpmAf3V5c=; b=HS4oVxOhXAje+GqM4rAfItKD
 eXT8HvB0/zWuXQNb9yJS9TAZeiNOGoJ3BiHe+Gm7hDsW2ZKjf4DpikNXAzSGEGML
 zPHnCSST+uzONXKNTI/mbnl7Dsc/6IEoMoxKiWRmoKObvIIs5QMGNzFXWEfY6auy
 2tzjpzQ7HPuzq76pxkvQpkIaCi4kuwdK57QMhUhBAVdcz35XBnIoMJFRawU85U6U
 b1MqYD3c80jo1/6zMu4LHNhl6M+QuRcJTU1ta6V5Lac/wUFWGA/DgPSvCpfG91b1
 P8n6gPWqcTYl00+Gek80+YI9Lf/DWrrFvQfH1KUEdi2f42KHdpsZbxT4xLK8VQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn5mcn04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Mar 2025 13:36:41 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52RDY7s0029562; Thu, 27 Mar 2025 13:36:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 45jjc3sr06-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Mar 2025 13:36:40 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52RDad4n023019;
 Thu, 27 Mar 2025 13:36:39 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 45jjc3sqyx-1; Thu, 27 Mar 2025 13:36:39 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1] migration: cpr breaks SNP guest
Date: Thu, 27 Mar 2025 06:36:38 -0700
Message-Id: <1743082598-428927-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503270093
X-Proofpoint-GUID: Bo7OPaIQJr5Q828YaOmAkygO3KdAYg0p
X-Proofpoint-ORIG-GUID: Bo7OPaIQJr5Q828YaOmAkygO3KdAYg0p
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 system/physmem.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index e97de3e..cfafb06 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1908,13 +1908,18 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
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
+        if (new_block->fd >= 0 && qemu_ram_is_shared(new_block)) {
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


