Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13C0C3DA4B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 14:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSGrB-0001rH-0f; Fri, 12 Jul 2024 10:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sSGr3-0001PR-9O
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:02:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sSGqy-0005ux-EI
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:02:33 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CDIgUP022130;
 Fri, 12 Jul 2024 14:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id; s=corp-2023-11-20; bh=nnzJAB
 bEofeXRiRH348VxDADbTf1KCfkh65zPb8C3yM=; b=K4ts4p9mhl8rdtELsFGEfv
 jewoCksQusfxmcc9WTvlxkz2VztVQYnfX3sL60W3tk+5m8qMAcxh69IZk0p29qin
 aGa/eFaxfNiQD0hai4LN28NnoJ6VGJ7e104hcYad1nSKB+HXleGFumoaN2dVLvUg
 mvu4f00TMoAv8WU3Q3YFjzG4ajI9LwKJYA8IG8YrF9lmckuKsUYf5N+MtoQqE2bM
 kQwUUfOjOb47qOTMwR2QClB5DkriPg5+muXnNzgXOrlJxaKyt1w6dGsT7Xup1xBm
 bv9gPmIUkriQMwWGaBQUfNgqOhtNdbJr7+ca5boy0+wGQ4og5eczN7kfHaLmfJ6Q
 ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406xfsv2bt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 14:02:15 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46CDx6I5010978; Fri, 12 Jul 2024 14:02:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 409vv74jrg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 14:02:14 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CE2DPm020438;
 Fri, 12 Jul 2024 14:02:13 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 409vv74jq7-1; Fri, 12 Jul 2024 14:02:13 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Si-Wei Liu <si-wei.liu@oracle.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 0/7] Live update: vdpa
Date: Fri, 12 Jul 2024 07:02:04 -0700
Message-Id: <1720792931-456433-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_10,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120094
X-Proofpoint-ORIG-GUID: N2LJ4UfadrGH__59NaxWkzBZpUAsvNWG
X-Proofpoint-GUID: N2LJ4UfadrGH__59NaxWkzBZpUAsvNWG
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

Support vdpa devices with the cpr-exec live migration mode.  
This series depends on the QEMU series 
  Live update: cpr-exec
  https://lore.kernel.org/qemu-devel/1719776434-435013-1-git-send-email-steven.sistare@oracle.com/

and depends on the kernel series:
  vdpa live update
  https://lore.kernel.org/virtualization/1720790333-456232-1-git-send-email-steven.sistare@oracle.com/

Preserve the device descriptor across exec, which in turn preserves the
locks on pages which are pinned in memory for DMA.  Suppress the DMA
unmap calls which are normally triggerred when a vdpa device is suspended.
After exec, call VHOST_NEW_OWNER to inform the device that a new process
is in charge.

If the device advertises the VHOST_BACKEND_F_IOTLB_REMAP capability, then
send VHOST_IOTLB_REMAP messages to update the userland address for each
DMA mapping.  Devices that do not advertise this cap have already translated
the userland addresses to physical when the DMA was initially mapped,
and do not require any update.

The cpr-exec mode leverages the vdpa live migration code path for the rest 
of the update, but is faster than live migration because it does not unlock
and relock pages in memory for DMA.

This series does not add any user-visible interfaces.

Steve Sistare (7):
  migration: cpr_needed_for_reuse
  migration: skip dirty memory tracking for cpr
  vdpa/cpr: preserve device fd
  vdpa/cpr: kernel interfaces
  vdpa/cpr: use VHOST_NEW_OWNER
  vdpa/cpr: pass shadow parameter to dma functions
  vdpa/cpr: preserve dma mappings

 hw/virtio/trace-events                       |  5 +-
 hw/virtio/vhost-vdpa.c                       | 71 +++++++++++++++-----
 include/hw/virtio/vhost-vdpa.h               |  7 +-
 include/hw/virtio/vhost.h                    |  1 +
 include/migration/cpr.h                      |  1 +
 include/standard-headers/linux/vhost_types.h |  7 ++
 linux-headers/linux/vhost.h                  |  9 +++
 migration/cpr.c                              |  5 ++
 net/vhost-vdpa.c                             | 29 +++++---
 scripts/tracetool/__init__.py                |  2 +-
 system/memory.c                              | 11 +++
 11 files changed, 120 insertions(+), 28 deletions(-)

-- 
2.39.3


