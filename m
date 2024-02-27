Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DB4C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 17:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf1UW-0001dq-UH; Tue, 27 Feb 2024 12:43:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rf1UU-0001dB-Uo
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:43:42 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rf1UT-0005KW-Cm
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:43:42 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41RFXsAp022521; Tue, 27 Feb 2024 17:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=rZ+ZCxdXz8XN6kA/7QeHs0FPcKCfgLqaWCH7ARgDvaw=;
 b=QmXj4/5aYv4CAsoBFRQAxNlS8SUML/q+lyBajxWYxtFoX8Nt4tQPEEt+Q+uaNj2yAWEQ
 sdVGGCXP+CA0IwvDle5wSZiiXzPStxg9CzvlSVI94EL6OloFUBsA2WQ0SzLRsCi9Hcmn
 WCeQcXqLOBTULxYOyWvfJuEt7Wb3GO+aUVnbBYv+6aVD9QlInW90prpLpmHHPlrM8N8a
 BuDJHWXj2DhmYDc0DIiZhLPNnUf0okX9CY21Ph5MpvjpYEb+7XKSefdGUi70NuMuKtuT
 4JvqV6pV1kSLxeUTY31xlnCy9e5XCXvpEfvDnrECUmKIXFygH40ntGE34C4ydx4MyawB bg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf784g3en-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 17:43:33 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41RGW37v025680; Tue, 27 Feb 2024 17:43:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wf6we2v3c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 17:43:32 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41RHfGVG000491;
 Tue, 27 Feb 2024 17:43:32 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wf6we2v1c-1; Tue, 27 Feb 2024 17:43:32 +0000
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
Subject: [PATCH V1 00/10] privatize migration.h
Date: Tue, 27 Feb 2024 09:43:17 -0800
Message-Id: <1709055807-315099-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_05,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 adultscore=0 mlxlogscore=970 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402270137
X-Proofpoint-GUID: x27Pg-nQcZl3ccPiWCwBtNajDY1aSVQT
X-Proofpoint-ORIG-GUID: x27Pg-nQcZl3ccPiWCwBtNajDY1aSVQT
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
  * migration patches in the series "allow cpr-reboot for vfio"
  * singleton patch "migration: export fewer options"

Steve Sistare (10):
  migration: remove migration.h references
  migration: export migration_is_setup_or_active
  migration: export migration_is_active
  migration: export migration_is_running
  migration: export vcpu_dirty_limit_period
  migration: migration_thread_is_self
  migration: migration_is_device
  migration: migration_file_set_error
  migration: privatize colo interfaces
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


