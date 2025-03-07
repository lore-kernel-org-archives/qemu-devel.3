Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356C5C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 20:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqek4-0000IF-No; Fri, 07 Mar 2025 15:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tqejn-0008P8-5m
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:56:14 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tqejj-0003kR-9V
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:56:05 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527Jtkjm017510;
 Fri, 7 Mar 2025 20:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=IuY98+6rwmP/rroRpKLqM65CjlaGLlASb9JcDNwWpuU=; b=
 mox7A6ABFYkgO/2gfosmFs+vCf1FhRmAdIOotOf0uAh34hCc+Vakq6Fd6ym6yiCv
 Qo4hPhw5cy30Oxlerv151gogKD9+bJQf1oiU2jZwFcm/KWgICbFBU1alvCUwx3TL
 ha23hc5o28hc+aTApEKqRW6JaTXpfWieSza0BXKTW+9/AM58S7bYDr7oQZC7vuAr
 XAc8yrpnwm6x3x6uBs31HltDwM7kJYvkf/ZvVNdWih3hs70vDFoxXIoANhQVlP86
 n1mEBuvuos+Ofm0phH+JFetGl+sATByBXzdNrL93ziqAYzQIEbAL9ClNcg8yGwhD
 NDIoxrqssOc7zdxQb/Jo1w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453uaw51h7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Mar 2025 20:56:00 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 527KCtl0010911; Fri, 7 Mar 2025 20:55:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 453rpfmv3g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Mar 2025 20:55:59 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 527KtuLt016275;
 Fri, 7 Mar 2025 20:55:58 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 453rpfmv2c-3; Fri, 07 Mar 2025 20:55:58 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daude <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 2/4] pflash: fix cpr
Date: Fri,  7 Mar 2025 12:55:52 -0800
Message-Id: <1741380954-341079-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741380954-341079-1-git-send-email-steven.sistare@oracle.com>
References: <1741380954-341079-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_07,2025-03-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=968
 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070158
X-Proofpoint-GUID: doY-NKB49UOAprb8vtwa4tyOHkjbQyGk
X-Proofpoint-ORIG-GUID: doY-NKB49UOAprb8vtwa4tyOHkjbQyGk
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
 hw/block/block.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/block/block.c b/hw/block/block.c
index 1d405e0..2e10611 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -12,6 +12,7 @@
 #include "system/blockdev.h"
 #include "system/block-backend.h"
 #include "hw/block/block.h"
+#include "migration/cpr.h"
 #include "qapi/error.h"
 #include "qapi/qapi-types-block.h"
 
@@ -66,6 +67,10 @@ bool blk_check_size_and_read_all(BlockBackend *blk, DeviceState *dev,
     int ret;
     g_autofree char *dev_id = NULL;
 
+    if (cpr_is_incoming()) {
+        return true;
+    }
+
     blk_len = blk_getlength(blk);
     if (blk_len < 0) {
         error_setg_errno(errp, -blk_len,
-- 
1.8.3.1


