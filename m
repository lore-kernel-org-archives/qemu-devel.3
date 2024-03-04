Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1670FC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 19:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhEGj-0003BZ-Vc; Mon, 04 Mar 2024 14:46:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rhEGf-0002cc-F4; Mon, 04 Mar 2024 14:46:33 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1rhEGc-0007Nc-PX; Mon, 04 Mar 2024 14:46:33 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 424IxqGd032304; Mon, 4 Mar 2024 19:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=tC9KBJfCvFe//nHt1DYEV1IOweBPPnQLAk60VlvmXW0=;
 b=V4fHAQpCxJcHTykuogMHv7PygJX2wG9D57T3kL+V7oXjvCy33bZ6bL9t9Ul/8ocyfHOc
 iVS41/GnoGtBsveJsDQHJmN0HrcHECI3G3xOQRcK/osSAfj0+cyNNPtpQswHVUN54stm
 iWC49QAOGEYO9Sd8LinhaBRgFYymef18bcPYFLZEaXhzniUQsr7Sh1scjA3ITvzvYmbi
 hfBzNgkh/1XPAj93wD5cGrxHG8K/Xg7/ZgDMXDqNAd1jC+l0yYCWLSpFmpVt/RbmCHiH
 onh7gnxv0Jj5/zyk/Q99TqNxG2FJYiUrBQ6jZ68udYspd1bzml4smWw87umy8uupjJ/q 5w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv0bcfaj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Mar 2024 19:46:17 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 424JIr71018962; Mon, 4 Mar 2024 19:46:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wktj6ag65-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Mar 2024 19:46:15 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 424JkE3w038523;
 Mon, 4 Mar 2024 19:46:14 GMT
Received: from jonah-ol8.us.oracle.com (dhcp-10-39-196-188.vpn.oracle.com
 [10.39.196.188])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3wktj6ag50-1; Mon, 04 Mar 2024 19:46:14 +0000
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
Subject: [PATCH v1 0/8] virtio,vhost: Add VIRTIO_F_NOTIFICATION_DATA support
Date: Mon,  4 Mar 2024 14:46:04 -0500
Message-Id: <20240304194612.611660-1-jonah.palmer@oracle.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_15,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040152
X-Proofpoint-ORIG-GUID: vRvhdcgJXi0OEMGyYLakIPJdyBVU4HHr
X-Proofpoint-GUID: vRvhdcgJXi0OEMGyYLakIPJdyBVU4HHr
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
  - Upper 16 bits: shadow_avail_idx
  - Lower 16 bits: virtqueue index

 Packed VQ
  - Upper 16 bits: 1-bit wrap counter & 15-bit shadow_avail_idx
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
 hw/s390x/s390-virtio-ccw.c   | 16 ++++++++++++----
 hw/s390x/virtio-ccw.c        |  6 ++++--
 hw/scsi/vhost-scsi.c         |  1 +
 hw/scsi/vhost-user-scsi.c    |  1 +
 hw/virtio/vhost-user-fs.c    |  2 +-
 hw/virtio/vhost-user-vsock.c |  1 +
 hw/virtio/virtio-mmio.c      | 15 +++++++++++----
 hw/virtio/virtio-pci.c       | 16 +++++++++++-----
 hw/virtio/virtio.c           | 18 ++++++++++++++++++
 include/hw/virtio/virtio.h   |  5 ++++-
 net/vhost-vdpa.c             |  1 +
 13 files changed, 68 insertions(+), 17 deletions(-)

-- 
2.39.3


