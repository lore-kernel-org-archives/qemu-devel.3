Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E70C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 13:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg3B6-0001Wb-Kc; Fri, 01 Mar 2024 08:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rg3B3-0001Tt-N6; Fri, 01 Mar 2024 08:43:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rg3B0-0004qT-0k; Fri, 01 Mar 2024 08:43:53 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 4219CBI0032561; Fri, 1 Mar 2024 13:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=LNmtBqROn5fgR9N5ZpFtAKKlvQeAp9zgapdmdwbrdTw=;
 b=GK8i9+HDfe9RTOLwWrLsCdhdzO567wObfE123aj41FLdjpoGArYcL9/sd3z1V4MyP4lu
 U6jrYsGfKoLELu2fJI7QaV1LxWBYAFKZrExxiGs3buPNyYMbvLv4PO46IpJcDyb1on3W
 9PW6iQSYEsYqsGCIaMsND93wjWnlQEJ6Gl2ZmNBz/zXKENfLrbdpMTobNv40aM0cWfUh
 f3rSt894ZrdaM97YLub1DpJGJkq+xjhUx6yiBAKTHu9g/ofEwBzcPsz2zREBVdt/HwKq
 lnBwTywhYF60QEZxcDMm+Yz5NKjt8gUw13eKhPJpChbf3Sw3nZr0iK8MOoJ65FJ5pFMe 5Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8bbgmug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Mar 2024 13:43:35 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 421DE5VD009390; Fri, 1 Mar 2024 13:43:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wjrqmtrak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Mar 2024 13:43:33 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 421DhWAI026578;
 Fri, 1 Mar 2024 13:43:32 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-65-160-211.vpn.oracle.com
 [10.65.160.211])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3wjrqmtr9m-1; Fri, 01 Mar 2024 13:43:32 +0000
From: Jonah Palmer <jonah.palmer@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 jonah.palmer@oracle.com, raphael@enfabrica.net, kwolf@redhat.com,
 hreitz@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, thuth@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, cohuck@redhat.com,
 pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, virtio-fs@lists.linux.dev
Subject: [RFC 0/8] virtio,vhost: Add VIRTIO_F_NOTIFICATION_DATA support
Date: Fri,  1 Mar 2024 08:43:22 -0500
Message-Id: <20240301134330.4191007-1-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_13,2024-03-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403010114
X-Proofpoint-GUID: ZBIBoBJr7EwKm9Zr6UuxaR0bLGpQvq7K
X-Proofpoint-ORIG-GUID: ZBIBoBJr7EwKm9Zr6UuxaR0bLGpQvq7K
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The goal of these patches are to add support to a variety of virtio and
vhost devices for the VIRTIO_F_NOTIFICATION_DATA transport feature. This
feature indicates that a driver will pass extra data (instead of just a
virtqueue's index) when notifying the corresponding device.

The data passed in by the driver when this feature is enabled varies in
format depending on if the device is using a split or packed virtqueue
layout:

 Split VQ
  - Upper 16 bits: last_avail_idx
  - Lower 16 bits: virtqueue index

 Packed VQ
  - Upper 16 bits: 1-bit wrap counter & 15-bit last_avail_idx
  - Lower 16 bits: virtqueue index

Also, due to the limitations of ioeventfd not being able to carry the
extra provided by the driver, ioeventfd is left disabled for any devices
using this feature.

A significant aspect of this effort has been to maintain compatibility
across different backends. As such, the feature is offered by backend
devices only when supported, with fallback mechanisms where backend
support is absent.

Jonah Palmer (8):
  virtio/virtio-pci: Handle extra notification data
  virtio-pci: Lock ioeventfd state with VIRTIO_F_NOTIFICATION_DATA
  virtio-mmio: Handle extra notification data
  virtio-mmio: Lock ioeventfd state with VIRTIO_F_NOTIFICATION_DATA
  virtio-ccw: Handle extra notification data
  virtio-ccw: Lock ioeventfd state with VIRTIO_F_NOTIFICATION_DATA
  vhost/vhost-user: Add VIRTIO_F_NOTIFICATION_DATA to vhost feature bits
  virtio: Add VIRTIO_F_NOTIFICATION_DATA property definition

 hw/block/vhost-user-blk.c    |  1 +
 hw/net/vhost_net.c           |  2 ++
 hw/s390x/s390-virtio-ccw.c   | 18 ++++++++++++++----
 hw/s390x/virtio-ccw.c        |  6 ++++--
 hw/scsi/vhost-scsi.c         |  1 +
 hw/scsi/vhost-user-scsi.c    |  1 +
 hw/virtio/vhost-user-fs.c    |  2 +-
 hw/virtio/vhost-user-vsock.c |  1 +
 hw/virtio/virtio-mmio.c      | 18 ++++++++++++++----
 hw/virtio/virtio-pci.c       | 19 ++++++++++++++-----
 hw/virtio/virtio.c           | 13 +++++++++++++
 include/hw/virtio/virtio.h   |  5 ++++-
 net/vhost-vdpa.c             |  1 +
 13 files changed, 71 insertions(+), 17 deletions(-)

-- 
2.39.3


