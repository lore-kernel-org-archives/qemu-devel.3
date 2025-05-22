Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C57C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 15:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI7O6-0003cL-EE; Thu, 22 May 2025 10:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uI7O0-0003b3-TE
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:59:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uI7Nx-0004gD-T3
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:59:08 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MEuW26022292;
 Thu, 22 May 2025 14:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2025-04-25; bh=jtNFJpZiwmU9xF4q
 rlHLhnddEZ4A8NSN64FcE49XGVo=; b=lWIrvKWeAV/TN9cerPQbZjWou2QChqzk
 YAzPtqQ7EB2zBP2i9Sf/qh7IcRgO/bTBiS7tsWnpHIXYC1CnNj46oQbIonoSpmMB
 DIHMbukj7q/0lcZ2kSaUQTbZl7HS742iwUP47CUFhO1vYidpfcDlr4QDjrA3ZGv4
 oOFKEmQCDVEtPmLR/xkszxkifk1gmdrwEzBqQtddBjWsFe2ndlW+SbgHAJL0h558
 xdI/COYZ1renD1YsxuWBUx8QeEHu9NK+VykV4f2Ouy1EJDqKylB5FClv17JV4OZE
 rN0rwhvNtQ9PWNSZJKOa0xY/77VJ5lnPhwGEqh3KNCdBjitCjarYyw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46t5b407d7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 14:58:46 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54MEFRLt034557; Thu, 22 May 2025 14:58:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46rwer98yx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 14:58:44 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54MEwiTt010227;
 Thu, 22 May 2025 14:58:44 GMT
Received: from dhcp-10-43-71-124.usdhcp.oraclecorp.com.com
 (dhcp-10-43-71-124.usdhcp.oraclecorp.com [10.43.71.124])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 46rwer98yj-1; Thu, 22 May 2025 14:58:44 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: jonah.palmer@oracle.com, eperezma@redhat.com, peterx@redhat.com,
 mst@redhat.com, jasowang@redhat.com, lvivier@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, parav@mellanox.com,
 sgarzare@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com
Subject: [PATCH v5 0/7] Move memory listener register to vhost_vdpa_init
Date: Thu, 22 May 2025 10:58:32 -0400
Message-ID: <20250522145839.59974-1-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_07,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505220152
X-Proofpoint-ORIG-GUID: peO5WENZi0dRDjOkropl8COv2agkwTUM
X-Authority-Analysis: v=2.4 cv=AdaxH2XG c=1 sm=1 tr=0 ts=682f3ba6 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=WQgBD-38X1HkX1-ZmYAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=5WABlXvFAscA:10
 a=n0c7R5xxTHgA:10 cc=ntf awl=host:13206
X-Proofpoint-GUID: peO5WENZi0dRDjOkropl8COv2agkwTUM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE1MiBTYWx0ZWRfXy2wlzFpHkMVY
 ztnilPMrPYHU4GYQ/iPehzCbEuHrB9WeRSbFGXT8yf07g08KqvNKEDvlskxeCLAmE/U56RNIVa7
 6D6OW+fCEV22ZPbnR6JqQvEl5aSN9KYirWYFtOqE6HPfrh/BcGrHVcGRpgM9XQUMZYl6K73n/MI
 79in0ATW0k0d5htp1qj+sPt57XTx7hWxLOJ45/7gOzup7fvYDI4CoLHVbK+vP35NN3Shve+XMPx
 oEFnqLC+lfglNMXwVk2CgSDsErhujvSDgRhaLo61btYQg/xNM5XGNBBNkXd+0ByzB5HWNcyWO+0
 5EonNrwlRlmXD5XHPshl2A0kOMWgQq0OLay7pCdCn/ukQ+7k5RMh4xI0t09EvxI4v4/C+dN8w+I
 NyJwnoaukxrxj7dtCVxHFiLdNYJ35RBP0zhjJgZ/2fBxSmPSXU9P4VaUYjJdzC5jS5wCW5bI
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Current memory operations like pinning may take a lot of time at the
destination.  Currently they are done after the source of the migration is
stopped, and before the workload is resumed at the destination.  This is a
period where neigher traffic can flow, nor the VM workload can continue
(downtime).

We can do better as we know the memory layout of the guest RAM at the
destination from the moment that all devices are initializaed.  So
moving that operation allows QEMU to communicate the kernel the maps
while the workload is still running in the source, so Linux can start
mapping them.

As a small drawback, there is a time in the initialization where QEMU
cannot respond to QMP etc.  By some testing, this time is about
0.2seconds.  This may be further reduced (or increased) depending on the
vdpa driver and the platform hardware, and it is dominated by the cost
of memory pinning.

This matches the time that we move out of the called downtime window.
The guest-visible downtime is measured as the elapsed trace time between
the last vhost_vdpa_suspend on the source and the last
vhost_vdpa_set_vring_enable_one on the destination. In other words, from
"guest CPUs freeze" to the instant the final Rx/Tx queue-pair is able to
start moving data.

Using ConnectX-6 Dx (MLX5) NICs in vhost-vDPA mode with 8 queue-pairs,
the series reduces guest-visible downtime during back-to-back live
migrations by more than half:
- 39G VM:   4.72s -> 2.09s (-2.63s, ~56% improvement)
- 128G VM:  14.72s -> 5.83s (-8.89s, ~60% improvement)

Future directions on top of this series may include to move more things ahead
of the migration time, like set DRIVER_OK or perform actual iterative migration
of virtio-net devices.

Comments are welcome.

This series is a different approach of series [1]. As the title does not
reflect the changes anymore, please refer to the previous one to know the
series history.

This series is based on [2] and has already been merged.

[Jonah Palmer]
This series was rebased after [3] was pulled in, as [3] was a prerequisite
fix for this series.

v5:
---
* Update performance metrics from the change in v4.

v4:
---
* Add memory listener unregistration to vhost_vdpa_reset_device.
* Remove memory listener unregistration from vhost_vdpa_reset_status.

v3:
---
* Rebase

v2:
---
* Move the memory listener registration to vhost_vdpa_set_owner function.
* Move the iova_tree allocation to net_vhost_vdpa_init.

v1 at https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02136.html.

[1] https://patchwork.kernel.org/project/qemu-devel/cover/20231215172830.2540987-1-eperezma@redhat.com/
[2] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05910.html
[3] https://lore.kernel.org/qemu-devel/20250217144936.3589907-1-jonah.palmer@oracle.com/

Eugenio Pérez (7):
  vdpa: check for iova tree initialized at net_client_start
  vdpa: reorder vhost_vdpa_set_backend_cap
  vdpa: set backend capabilities at vhost_vdpa_init
  vdpa: add listener_registered
  vdpa: reorder listener assignment
  vdpa: move iova_tree allocation to net_vhost_vdpa_init
  vdpa: move memory listener register to vhost_vdpa_init

 hw/virtio/vhost-vdpa.c         | 107 +++++++++++++++++++++------------
 include/hw/virtio/vhost-vdpa.h |  22 ++++++-
 net/vhost-vdpa.c               |  34 +----------
 3 files changed, 93 insertions(+), 70 deletions(-)

-- 
2.43.5


