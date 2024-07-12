Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4344C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 14:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSGrC-0001vG-89; Fri, 12 Jul 2024 10:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sSGr7-0001dx-14
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:02:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sSGr4-0005vG-LB
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:02:36 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDIjM8028175;
 Fri, 12 Jul 2024 14:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=oCT40AtDEKvFtYLo+FbOlAkqvMJe0KAt51MjZe2n1ug=; b=
 Vt6fxaB4wDudYnpPAclRlLdjZl2ZM61ClnJ2+0DMLYnD/F/1NYHHpWAwPrBuSo02
 RhFazoF852vpZUSQlChX3QR55YjPxNV4Lqz+0KrVtErgMa81oLq5akyWP2R6E9Kx
 1RboHZpFHxKNRbc+Ybu17HJI593oinvPs1Jqfg6ufZmmmZfPJYKPe1RxCnpk17aF
 V2CdM7Mqj9y54dV/vqoZ/soYfHNWB6Twy5lxQi7Oksc/U16e1SZHtEMoI1ercSZL
 ti75BQm3TOUZuz7EUvJVqG0SoYCF0LGR+5J52rgUhL7d40XDh3K0NnXVuKfhMFPh
 Qu6M9yZSVGMyX5n6cmZaPw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkyc4f5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 14:02:17 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46CDmDek010418; Fri, 12 Jul 2024 14:02:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 409vv74jtp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 14:02:16 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CE2DPq020438;
 Fri, 12 Jul 2024 14:02:16 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 409vv74jq7-3; Fri, 12 Jul 2024 14:02:15 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Si-Wei Liu <si-wei.liu@oracle.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 2/7] migration: skip dirty memory tracking for cpr
Date: Fri, 12 Jul 2024 07:02:06 -0700
Message-Id: <1720792931-456433-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1720792931-456433-1-git-send-email-steven.sistare@oracle.com>
References: <1720792931-456433-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_10,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=712 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120094
X-Proofpoint-ORIG-GUID: GiN25Z3wON-RkORBrRD22UTy7JGVmIxU
X-Proofpoint-GUID: GiN25Z3wON-RkORBrRD22UTy7JGVmIxU
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

CPR preserves memory in place, so there is no need to track dirty memory.
By skipping it, CPR can support devices that do not support tracking.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 system/memory.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/system/memory.c b/system/memory.c
index b7548bf112..aef584e638 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -27,6 +27,7 @@
 
 #include "exec/memory-internal.h"
 #include "exec/ram_addr.h"
+#include "migration/misc.h"
 #include "sysemu/kvm.h"
 #include "sysemu/runstate.h"
 #include "sysemu/tcg.h"
@@ -2947,6 +2948,11 @@ bool memory_global_dirty_log_start(unsigned int flags, Error **errp)
 
     assert(flags && !(flags & (~GLOBAL_DIRTY_MASK)));
 
+    /* CPR preserves memory in place, so no need to track dirty memory */
+    if (migrate_mode() != MIG_MODE_NORMAL) {
+        return true;
+    }
+
     if (vmstate_change) {
         /* If there is postponed stop(), operate on it first */
         postponed_stop_flags &= ~flags;
@@ -3021,6 +3027,11 @@ static void memory_vm_change_state_handler(void *opaque, bool running,
 
 void memory_global_dirty_log_stop(unsigned int flags)
 {
+    /* CPR preserves memory in place, so no need to track dirty memory */
+    if (migrate_mode() != MIG_MODE_NORMAL) {
+        return;
+    }
+
     if (!runstate_is_running()) {
         /* Postpone the dirty log stop, e.g., to when VM starts again */
         if (vmstate_change) {
-- 
2.39.3


