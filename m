Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC88C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjm1-0001yt-GS; Mon, 11 Mar 2024 13:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjjlw-0001xL-7l
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:49:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjjlt-0008UE-Kz
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:49:11 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42BG430Q008556; Mon, 11 Mar 2024 17:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=FLlBgyBUTZ2VoVYLUX1GtBuTOq7vOLX5VzP19Gzxn68=;
 b=OfTItMQpurPK6cpJUjCp3d90+acs65LYJLiFV+iuAdsZJM81RF/G2jB0QymFInICOWNL
 wMXT84e1hfo3mjnNLtFZ6gXhsz0H/yDVQNghZhdfKFFuLmu0z3pQf0wjbd2hJMaJcUJ3
 TlRqnZ6KeduOCW5w5dCuJUdVRwrUgdE66aPlxNUl17AIRbgx+vUNGc/6qKHxXARGL9P6
 Yjp9DVkJ2y+4E7eb79PfKYMmsEIFALEHnyJJc5HAU9SQ0ydfOs9ribflriD03lnJSbhP
 uLoCto4PLf2WnbNc1gcBgZAN7WfjiBxCNxfVyNpl5ETzEFvpdq5axpJJ8UjyRFNAgsrf bA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrftdc22d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 17:49:03 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42BHkjb0028544; Mon, 11 Mar 2024 17:49:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre763321-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 17:49:02 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42BHlHcg020033;
 Mon, 11 Mar 2024 17:49:02 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wre763302-2; Mon, 11 Mar 2024 17:49:02 +0000
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
Subject: [PATCH V2 01/11] migration: remove migration.h references
Date: Mon, 11 Mar 2024 10:48:48 -0700
Message-Id: <1710179338-294359-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1710179338-294359-1-git-send-email-steven.sistare@oracle.com>
References: <1710179338-294359-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403110136
X-Proofpoint-ORIG-GUID: 1shvOFzZFuCWOFACUkZeuQab5RFt9Osd
X-Proofpoint-GUID: 1shvOFzZFuCWOFACUkZeuQab5RFt9Osd
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

Remove migration.h from files that no longer need it due to
previous commits.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/container.c        | 1 -
 hw/virtio/vhost-user.c     | 1 -
 hw/virtio/virtio-balloon.c | 1 -
 system/qdev-monitor.c      | 1 -
 target/loongarch/kvm/kvm.c | 1 -
 tests/unit/test-vmstate.c  | 1 -
 6 files changed, 6 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index bd25b9f..ff081a1 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -32,7 +32,6 @@
 #include "sysemu/reset.h"
 #include "trace.h"
 #include "qapi/error.h"
-#include "migration/migration.h"
 #include "pci.h"
 
 VFIOGroupList vfio_group_list =
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index a1eea85..1af8621 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -26,7 +26,6 @@
 #include "qemu/sockets.h"
 #include "sysemu/runstate.h"
 #include "sysemu/cryptodev.h"
-#include "migration/migration.h"
 #include "migration/postcopy-ram.h"
 #include "trace.h"
 #include "exec/ramblock.h"
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a59ff17..609e39a 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -31,7 +31,6 @@
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "migration/misc.h"
-#include "migration/migration.h"
 
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index a13db76..948d393 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -38,7 +38,6 @@
 #include "qemu/option_int.h"
 #include "sysemu/block-backend.h"
 #include "migration/misc.h"
-#include "migration/migration.h"
 #include "qemu/cutils.h"
 #include "hw/qdev-properties.h"
 #include "hw/clock.h"
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index c19978a..11a69a3 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -22,7 +22,6 @@
 #include "hw/irq.h"
 #include "qemu/log.h"
 #include "hw/loader.h"
-#include "migration/migration.h"
 #include "sysemu/runstate.h"
 #include "cpu-csr.h"
 #include "kvm_loongarch.h"
diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index c4f9faa..63f28f2 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -24,7 +24,6 @@
 
 #include "qemu/osdep.h"
 
-#include "../migration/migration.h"
 #include "migration/vmstate.h"
 #include "migration/qemu-file-types.h"
 #include "../migration/qemu-file.h"
-- 
1.8.3.1


