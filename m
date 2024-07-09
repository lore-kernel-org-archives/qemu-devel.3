Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E1FC3DA45
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 20:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRHvZ-0005Bo-0A; Tue, 09 Jul 2024 16:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sRHvX-0005Al-S5
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 16:59:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sRHvV-0005WJ-JH
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 16:59:07 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469KtXoG025203;
 Tue, 9 Jul 2024 20:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id; s=corp-2023-11-20; bh=4eSu+k
 M7YAPtkSfm5mNDuC4BrU5YjXxmxnDz/P0M7ws=; b=eZ1nkkp8y1APWbQoM1otxe
 9AGyXVLaelhGZIBptawCb1q6wNPH5y8/+AqaLGxML4DWEroaZFpoh1Z0CQI0j0a3
 KnV8ldOvSs0Fm2VxUw9WYRnauqxEsgfwMGIJOfrU8xJ29bCr80At/62++YtrI9NX
 FKC5l6jjLfl1BjzvRAD+0Nz0s/lClxw5vakdTJPxtw2Sb9AzFewy9FxhDWi6U37D
 65NMnO3dqZZmDnMgDRLL6Soe7TsuUPOV0aoC8kub6p46o+0Uupf8HeBb+oaD/q8B
 bgzP3xlbhXklv/szHYinqAracZIcHL+PiujkfRAoj+rNssZXVGFxrYfO9BKO+ioA
 ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8dw6n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 20:59:00 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 469J9JWC005095; Tue, 9 Jul 2024 20:58:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 407tve98r5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 20:58:59 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 469KwwCp012128;
 Tue, 9 Jul 2024 20:58:58 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 407tve98qa-1; Tue, 09 Jul 2024 20:58:58 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 0/8] Live update: vfio
Date: Tue,  9 Jul 2024 13:58:49 -0700
Message-Id: <1720558737-451106-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_09,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090143
X-Proofpoint-GUID: f1wOcoRNrIRcalmeOmGepAJ1YEaOvAf7
X-Proofpoint-ORIG-GUID: f1wOcoRNrIRcalmeOmGepAJ1YEaOvAf7
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

Support vfio devices with the cpr-exec live migration mode.
See the commit messages of the individual patches for details.
No user-visible interfaces are added.

This series is extracted from the following and updated for the latest QEMU:
  [PATCH V9 00/46] Live Update
  https://lore.kernel.org/qemu-devel/1658851843-236870-1-git-send-email-steven.sistare@oracle.com/

This series depends on the following, which is based on commit 44b7329de469:
  [PATCH V2 00/11] Live update: cpr-exec
  https://lore.kernel.org/qemu-devel/1719776434-435013-1-git-send-email-steven.sistare@oracle.com/

Steve Sistare (8):
  migration: cpr_needed_for_reuse
  pci: export msix_is_pending
  vfio-pci: refactor for cpr
  vfio-pci: cpr part 1 (fd and dma)
  vfio-pci: cpr part 2 (msi)
  vfio-pci: cpr part 3 (intx)
  vfio: vfio_find_ram_discard_listener
  vfio-pci: recover from unmap-all-vaddr failure

 hw/pci/msix.c                         |   2 +-
 hw/pci/pci.c                          |  13 ++
 hw/vfio/common.c                      |  88 ++++++++--
 hw/vfio/container.c                   | 139 ++++++++++++---
 hw/vfio/cpr-legacy.c                  | 162 ++++++++++++++++++
 hw/vfio/cpr.c                         |  24 ++-
 hw/vfio/meson.build                   |   3 +-
 hw/vfio/pci.c                         | 308 +++++++++++++++++++++++++++++-----
 include/hw/pci/msix.h                 |   1 +
 include/hw/vfio/vfio-common.h         |  10 ++
 include/hw/vfio/vfio-container-base.h |   7 +
 include/migration/cpr.h               |   1 +
 include/migration/vmstate.h           |   2 +
 migration/cpr.c                       |   5 +
 14 files changed, 682 insertions(+), 83 deletions(-)
 create mode 100644 hw/vfio/cpr-legacy.c

-- 
1.8.3.1


