Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D60C54791
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 17:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdCsP-0004XO-2Z; Thu, 22 Feb 2024 12:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdCsK-0004PT-Vq
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:28:50 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdCsI-0003BI-Qk
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:28:48 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41MGtc6X005157; Thu, 22 Feb 2024 17:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=AUy6fkvdJLKYTlh6iTDgH1DoKVpFUzrcjIjPipFP550=;
 b=bQVh7ZF3NEFN4JEKdiGMg/S2k+4WxQGQyIZBkvFtFJ8BDqkrYXDeoMan6dIOGQRD4PkQ
 uqqXvA4zjcktkpVZ4FWB1/zRM3S+Hufguc74yZUc98bSDk+tlSFM6UE+DVu6Lhf/bkUk
 wBAEmFflxoIi6J3RHzx17tLYkKN5+pSRSDP/7uCS/Lq+NTZviz8YpMfFZhxewKoTNb2M
 uozG3v/dtMekTSBJtvy0d1HGezJnge3mO061XkIGefFglzUcuYxrJNGgxxvLa55ob1ti
 oC/8KA3Q8xj9taOZGi9Z42Es5Xwp2ZpfH7TSu8a8iVdPhWL0cHMgWKDNWGU2268vCWIu MQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd5fw52tv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 17:28:44 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41MHObER024713; Thu, 22 Feb 2024 17:28:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak8ayrg2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 17:28:42 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41MHSg9l032453;
 Thu, 22 Feb 2024 17:28:42 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wak8ayre4-1; Thu, 22 Feb 2024 17:28:42 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 00/14] allow cpr-reboot for vfio
Date: Thu, 22 Feb 2024 09:28:26 -0800
Message-Id: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_13,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=749
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220138
X-Proofpoint-GUID: gT6b55c7O4X1_YXwMDIN53_fXwYUXDya
X-Proofpoint-ORIG-GUID: gT6b55c7O4X1_YXwMDIN53_fXwYUXDya
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Allow cpr-reboot for vfio if the guest is in the suspended runstate.  The
guest drivers' suspend methods flush outstanding requests and re-initialize
the devices, and thus there is no device state to save and restore.  The
user is responsible for suspending the guest before initiating cpr, such as
by issuing guest-suspend-ram to the qemu guest agent.

Most of the patches in this series enhance migration notifiers so they can
return an error status and message.  The last few patches register a notifier
for vfio that returns an error if the guest is not suspended.

Changes in V3:
  * update to tip, add RB's
  * replace MigrationStatus with new enum MigrationEventType
  * simplify migrate_fd_connect error recovery
  * support vfio iommufd containers
  * add patches:
      migration: stop vm for cpr
      migration: update cpr-reboot description

Changes in V4:
  * rebase to tip, add RB's
  * add patch to prevent options such as precopy from being used with cpr.
      migration: options incompatible with cpr
  * refactor subroutines in "stop vm for cpr"
  * simplify "notifier error checking" patch by restricting that only
    notifiers for MIG_EVENT_PRECOPY_SETUP may return an error.
  * doc that a fail event may be sent without a prior setup event

Steve Sistare (14):
  notify: pass error to notifier with return
  migration: remove error from notifier data
  migration: convert to NotifierWithReturn
  migration: MigrationEvent for notifiers
  migration: remove postcopy_after_devices
  migration: MigrationNotifyFunc
  migration: per-mode notifiers
  migration: refactor migrate_fd_connect failures
  migration: notifier error checking
  migration: stop vm for cpr
  vfio: register container for cpr
  vfio: allow cpr-reboot migration if suspended
  migration: update cpr-reboot description
  migration: options incompatible with cpr

 hw/net/virtio-net.c                   |  13 +--
 hw/vfio/common.c                      |   2 +-
 hw/vfio/container.c                   |  11 ++-
 hw/vfio/cpr.c                         |  39 +++++++++
 hw/vfio/iommufd.c                     |   6 ++
 hw/vfio/meson.build                   |   1 +
 hw/vfio/migration.c                   |  15 ++--
 hw/vfio/trace-events                  |   2 +-
 hw/virtio/vhost-user.c                |  10 +--
 hw/virtio/virtio-balloon.c            |   3 +-
 include/hw/vfio/vfio-common.h         |   5 +-
 include/hw/vfio/vfio-container-base.h |   1 +
 include/hw/virtio/virtio-net.h        |   2 +-
 include/migration/misc.h              |  47 +++++++++--
 include/qemu/notify.h                 |   8 +-
 migration/migration.c                 | 148 +++++++++++++++++++++++-----------
 migration/migration.h                 |   4 -
 migration/postcopy-ram.c              |   3 +-
 migration/postcopy-ram.h              |   1 -
 migration/ram.c                       |   3 +-
 net/vhost-vdpa.c                      |  14 ++--
 qapi/migration.json                   |  37 ++++++---
 roms/seabios-hppa                     |   2 +-
 ui/spice-core.c                       |  17 ++--
 util/notify.c                         |   5 +-
 25 files changed, 275 insertions(+), 124 deletions(-)
 create mode 100644 hw/vfio/cpr.c

-- 
1.8.3.1


