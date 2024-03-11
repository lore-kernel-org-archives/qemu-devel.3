Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F94C54E66
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjly-0001xP-QX; Mon, 11 Mar 2024 13:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjjlv-0001x1-2D
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:49:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjjlt-0008U6-3Y
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:49:10 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42BG47l8011957; Mon, 11 Mar 2024 17:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=z74dRZXo6g8FUyXJa1o1XyChuUYJJE7XabWxOnpstmw=;
 b=Sz5VFgb3rhzw1gqhOX1k61VN3uRDY/pyi8rDlrzs8VjmX2j4qBj+g4bd4wiWOACUDfDZ
 KoC7HSqM4UuMs9Ci893DLlAlgNMGxQosXyuC6RjQwCyvtj70j81XyWinMmHiBJPldFCv
 vCtcQTScQO97+lqOnZXRWvjq0qURCSOF/HI0+UYRLe4abCjozspAIvKol/U2nangatH4
 9Neig/iIS3gRHUJ2boquXW47X+FTv7LjA8UB7EJ6RkwHu2Ig497WRUsu4A4XIvBQZWal
 SBelKBtvRo7tLRTpsLttG3lgZsqL83dpln6f/KA13QMpqN1VHNeFpLAhqm+jFdz3LJZt /A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wre6ec0yh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 17:49:01 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42BHgM5F028540; Mon, 11 Mar 2024 17:49:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre763312-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 17:49:01 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42BHlHce020033;
 Mon, 11 Mar 2024 17:49:00 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wre763302-1; Mon, 11 Mar 2024 17:49:00 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Jason Wang <jasowang@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 Song Gao <gaosong@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 00/11] privatize migration.h
Date: Mon, 11 Mar 2024 10:48:47 -0700
Message-Id: <1710179338-294359-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403110136
X-Proofpoint-GUID: Oia2a7kSAZfdI0XPrJN3dUyU2hYztqk8
X-Proofpoint-ORIG-GUID: Oia2a7kSAZfdI0XPrJN3dUyU2hYztqk8
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

migration/migration.h is the private interface for code in the migration
sub-directory, but many other clients include it because they need accessors
that are not exported by the publc interface in include/migration/misc.h.
Fix that by refactoring accessors and defining new ones as needed.

After these fixes, no code outside of migration includes migration.h,
and no code outside of migration uses MigrationState.

This series depends on the following:
  * singleton patch "migration: export fewer options"

Changes in V2:
  * rebase to migration-next, add RB
  * split last patch

Steve Sistare (11):
  migration: remove migration.h references
  migration: export migration_is_setup_or_active
  migration: export migration_is_active
  migration: export migration_is_running
  migration: export vcpu_dirty_limit_period
  migration: migration_thread_is_self
  migration: migration_is_device
  migration: migration_file_set_error
  migration: privatize colo interfaces
  migration: delete unused accessors
  migration: purge MigrationState from public interface

 hw/vfio/common.c                   | 17 +++-------
 hw/vfio/container.c                |  1 -
 hw/vfio/migration.c                | 11 ++-----
 hw/virtio/vhost-user.c             |  1 -
 hw/virtio/virtio-balloon.c         |  1 -
 include/migration/client-options.h |  1 +
 include/migration/misc.h           | 17 +++++-----
 migration/colo.c                   | 17 ++++++----
 migration/migration.c              | 67 ++++++++++++++++++++++++--------------
 migration/migration.h              |  7 ++--
 migration/options.c                | 11 +++++--
 migration/ram.c                    |  5 ++-
 migration/savevm.c                 |  2 +-
 net/colo-compare.c                 |  3 +-
 net/vhost-vdpa.c                   |  3 +-
 stubs/colo.c                       |  1 -
 system/dirtylimit.c                | 12 +++----
 system/qdev-monitor.c              |  1 -
 target/loongarch/kvm/kvm.c         |  1 -
 target/riscv/kvm/kvm-cpu.c         |  4 +--
 tests/unit/test-vmstate.c          |  1 -
 21 files changed, 96 insertions(+), 88 deletions(-)

-- 
1.8.3.1


