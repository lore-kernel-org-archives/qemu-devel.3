Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BA3C28B27
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 20:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqekG-0000Rk-8x; Fri, 07 Mar 2025 15:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tqejn-0008P9-6F
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:56:14 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tqejk-0003qY-6W
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:56:06 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527JtwtK018267;
 Fri, 7 Mar 2025 20:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=n1k0/HyO5PaySwG59q3NWb0lYya8BcADYAqkC9BtGk0=; b=
 I/h4TYZB3hovjoNlWNp0mlNOAl46wszgzGWdCbsU3V/bGCTdJuqyTE7lgo8PCTbS
 UvpwpCooroOj9QiWMOXzqvoaF2QjeI4x+J72OchxmT6mFPmWCvq0zCL+DXGWpDNN
 e+Qf9shHa+5suLpk43lleqp8fCYEKiveHjYcLzYK4X0s12mYRQe+kynavYEdJ6p7
 fNDryTT9IiQfglk2WG0O9cHjchh9y+uQsmEnygxz7HH6iH19xgxhZIBBiquTCifw
 hG4Q48hH04alHeeCiFd4O5TjeRdK8QMhrHSgWeg5G2qu4KRsIS1Vh8yN4WnXIhUE
 QH/db8x6uKilcCfO7oDtwA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8255um-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Mar 2025 20:56:01 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 527Kf97Q011061; Fri, 7 Mar 2025 20:56:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 453rpfmv45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Mar 2025 20:56:00 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 527KtuLv016275;
 Fri, 7 Mar 2025 20:55:59 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 453rpfmv2c-4; Fri, 07 Mar 2025 20:55:59 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daude <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 3/4] hw/loader: fix roms during cpr
Date: Fri,  7 Mar 2025 12:55:53 -0800
Message-Id: <1741380954-341079-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741380954-341079-1-git-send-email-steven.sistare@oracle.com>
References: <1741380954-341079-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_07,2025-03-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070158
X-Proofpoint-GUID: alAcPc-LPdah80zclEuYSZNB4dtwEB6h
X-Proofpoint-ORIG-GUID: alAcPc-LPdah80zclEuYSZNB4dtwEB6h
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

During normal migration, new QEMU creates and initializes memory regions,
then loads the preserved contents of the region from vmstate.

During CPR, memory regions are preserved in place, then the realize
method initializes the regions contents, losing the old contents.  To
fix, skip the re-init during CPR.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/core/loader.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index fd25c5e..3c3a9a0 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -51,6 +51,7 @@
 #include "trace.h"
 #include "hw/hw.h"
 #include "disas/disas.h"
+#include "migration/cpr.h"
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "system/reset.h"
@@ -1029,7 +1030,9 @@ static void *rom_set_mr(Rom *rom, Object *owner, const char *name, bool ro)
     vmstate_register_ram_global(rom->mr);
 
     data = memory_region_get_ram_ptr(rom->mr);
-    memcpy(data, rom->data, rom->datasize);
+    if (!cpr_is_incoming()) {
+        memcpy(data, rom->data, rom->datasize);
+    }
 
     return data;
 }
-- 
1.8.3.1


