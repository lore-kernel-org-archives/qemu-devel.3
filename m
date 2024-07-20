Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CABC3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 19:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVFZ9-00074N-99; Sat, 20 Jul 2024 15:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVFYz-0006qE-FQ
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVFYv-0000rZ-3P
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:12 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KJAUWm021897;
 Sat, 20 Jul 2024 19:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=KEtu+Nxv6EH7Q/6YhuuppatukClo9brblJ9w6R7zxOU=; b=
 JubR34CvCUj+4G4NyrI5TXEht4YWjiiHsdxcLLBrGN/tlgTeXOYkRZ2H3BKIiL6Q
 H6B93N36aVJy1nrDf7+JQbP1tVrgpSy1kUwRiA2XEtTPp50/KNrraU8LsPJ4W7/6
 cngv0s6zJglnHRPUxXKm/dRU6wbf4OfgC1JYhmdhhzEtvQJktPAkA/0cT+2X+OEp
 8vN0y7Ci76TQph7XBlABwZq3wjxXXzns/KM54IzNKCVq0YvaGTHXeiB16dJCveTM
 gEORix8Gxg33dSuJi4AgrpJ+qRTtJcw+5owYFEY4EkO8UmZrk6dd9QiJXJgsh0Z0
 NKx5wgRkqYuNLRHOC8+YzQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gk5jr04j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:15:54 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46KIfsYt027542; Sat, 20 Jul 2024 19:15:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40g3p5puwa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:15:53 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46KJFdfL028365;
 Sat, 20 Jul 2024 19:15:53 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 40g3p5pusv-11; Sat, 20 Jul 2024 19:15:53 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 10/12] migration/ram: old host address
Date: Sat, 20 Jul 2024 12:15:35 -0700
Message-Id: <1721502937-87102-11-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
References: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_16,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407200140
X-Proofpoint-GUID: iEqILvLT-oYpMT69ERvnhgoX8cj0UfEh
X-Proofpoint-ORIG-GUID: iEqILvLT-oYpMT69ERvnhgoX8cj0UfEh
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Remember the RAMBlock host address as host_old during migration, for use
by CPR.  The iommufd interface to update the virtual address of DMA
mappings requires it.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/core/machine.c       | 6 ++++++
 include/exec/ramblock.h | 1 +
 migration/migration.h   | 2 ++
 migration/options.c     | 2 ++
 migration/ram.c         | 7 +++++++
 5 files changed, 18 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 9676953..0ac16b8 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -35,6 +35,12 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
 
+/* TBD: register hw_compat_9_1 with machines */
+GlobalProperty hw_compat_9_1[] = {
+    { "migration", "send-host-old", "off"},
+};
+const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
+
 GlobalProperty hw_compat_9_0[] = {
     {"arm-cpu", "backcompat-cntfrq", "true" },
     {"scsi-disk-base", "migrate-emulated-scsi-request", "false" },
diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 64484cd..8f1c535 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -28,6 +28,7 @@ struct RAMBlock {
     struct rcu_head rcu;
     struct MemoryRegion *mr;
     uint8_t *host;
+    uint64_t host_old;
     uint8_t *colo_cache; /* For colo, VM's ram cache */
     ram_addr_t offset;
     ram_addr_t used_length;
diff --git a/migration/migration.h b/migration/migration.h
index 38aa140..b5e3151 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -442,6 +442,8 @@ struct MigrationState {
      */
     uint8_t clear_bitmap_shift;
 
+    bool send_host_old;
+
     /*
      * This save hostname when out-going migration starts
      */
diff --git a/migration/options.c b/migration/options.c
index 7526f9f..197cb86 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -92,6 +92,8 @@ Property migration_properties[] = {
                       clear_bitmap_shift, CLEAR_BITMAP_SHIFT_DEFAULT),
     DEFINE_PROP_BOOL("x-preempt-pre-7-2", MigrationState,
                      preempt_pre_7_2, false),
+    DEFINE_PROP_BOOL("send-host-old", MigrationState,
+                     send_host_old, true),
 
     /* Migration parameters */
     DEFINE_PROP_UINT8("x-throttle-trigger-threshold", MigrationState,
diff --git a/migration/ram.c b/migration/ram.c
index 1e1e05e..8644917 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3030,6 +3030,9 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
             qemu_put_byte(f, strlen(block->idstr));
             qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->idstr));
             qemu_put_be64(f, block->used_length);
+            if (migrate_get_current()->send_host_old) {
+                qemu_put_be64(f, (uint64_t)block->host);
+            }
             if (migrate_postcopy_ram() &&
                 block->page_size != max_hg_page_size) {
                 qemu_put_be64(f, block->page_size);
@@ -4021,6 +4024,10 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
 
     assert(block);
 
+    if (migrate_get_current()->send_host_old) {
+        block->host_old = qemu_get_be64(f);
+    }
+
     if (migrate_mapped_ram()) {
         parse_ramblock_mapped_ram(f, block, length, &local_err);
         if (local_err) {
-- 
1.8.3.1


