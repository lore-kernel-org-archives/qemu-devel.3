Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48260D46BFA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 20:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlCKi-00087P-CL; Wed, 28 Jan 2026 15:40:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vlCKL-0007bI-PZ
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 15:39:50 -0500
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vlCKH-00084W-78
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 15:39:49 -0500
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
 by m0409409.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 60SDMwsh3880427; Wed, 28 Jan 2026 20:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=aeZzkvmebewRfaih4/t4ihsdQNyBJJYUYDDfKylGW9w=; b=NvjanVxPAfeN
 6gydrksGB+zTkObywhAeqgAHE9Wnt+QHew7SyaDwRqkyWzNio/i6Svpzdogr5DM6
 1NKyDbIBp+0e7FTp1gszqN4lmlnnNqXZXyDLmQCp5Cx2AANIjfjpph+tY5ZlHx50
 t11aD0Yn//bmn2ZsZzWV7sOouwX5Pa1lGM7I149hrVuWgTQb04t+xFqZKQr7ccUZ
 OMxfHk36ffILz5t1m3lnSxOl8gIMRVKVmz498HSlHh7sqeIdtw/h+eh0dH2IIskj
 lKWUlgOYrbCtMO8x8qflI2GLA93LYudURNrStMlqegkXJslLEVezglwvMxNYCaE3
 dMEDPsEphQ==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60])
 by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 4by2u0y6ep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Jan 2026 20:39:40 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
 by prod-mail-ppoint5.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 60SJlc8k013937; Wed, 28 Jan 2026 12:39:39 -0800
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
 by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 4bvvxfyxx9-1;
 Wed, 28 Jan 2026 12:39:39 -0800
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.220.254])
 by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 0066D99;
 Wed, 28 Jan 2026 20:39:39 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
Date: Wed, 28 Jan 2026 15:39:29 -0500
Subject: [PATCH v4 1/8] migration: stop vm earlier for cpr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-cpr-tap-v4-1-48e334d4216b@akamai.com>
References: <20260128-cpr-tap-v4-0-48e334d4216b@akamai.com>
In-Reply-To: <20260128-cpr-tap-v4-0-48e334d4216b@akamai.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan <hamza.khan@nutanix.com>,
 Mark Kanda <mark.kanda@oracle.com>, Joshua Hunt <johunt@akamai.com>,
 Max Tottenham <mtottenh@akamai.com>, Ben Chaney <bchaney@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769632778; l=4773;
 i=bchaney@akamai.com; s=20251203; h=from:subject:message-id;
 bh=1oAm0CghpeE3ORzzZ0ONoCUfr6xsC782SwLSqOwlPWY=;
 b=n599jx+ep5dXg8teN4LS5FpiEZgZvIir5AHC0dIxJ+ySFb3/JXJ6PJ897w2d/9amFHEFTBxau
 BlNvnMs5Kp7Dna31qKzZ4Frf6wPKDte0qHRUBtvzkSnNH4hwiVAmZTY
X-Developer-Key: i=bchaney@akamai.com; a=ed25519;
 pk=6+w9cse5QEeVdy3tjqFxs/4rAaRdQ2/fkTxVFq+lWy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601280169
X-Authority-Analysis: v=2.4 cv=OOkqHCaB c=1 sm=1 tr=0 ts=697a740c cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=X7Ea-ya5AAAA:8 a=N5d-UlcB8v2vpT89WNEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8NAJ6BHxrsGwBj-6Kg3tMNEnBo0PnA_2
X-Proofpoint-GUID: 8NAJ6BHxrsGwBj-6Kg3tMNEnBo0PnA_2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDE3MCBTYWx0ZWRfX1wkiyc1uZCel
 Pgbrnnd1JZ6+YcxwEnhrKOULz4mCbWn+sUxYixhSkDLeg0P2mIOEpksxg6My23XWSpwifm2Q/Bv
 rdtK9iOKZIXJGuoY53RYPTzibBLDvCMtCC6M9N94YZkz548HsF8N8zK/ILn6JNASJRHq6dmoZbv
 ZthUXz5fdIhwHQauCIuspKlpzQzAf+iOChFdiFFhl495Y/P9hzx76zMXFlQRCqvvkHzXtqOyM1O
 PsVSuUarRq/XYkMEWVOMsoaD9OG8XaUmPo/ZMcyYfPBxSjnfCOOnaR/zjhH9Ma98ERihcTuW0/2
 gsRAHaYLFREn6HXMoTDw/aFNTI2EZz0ntABOTOCBnScklT7v2fly/ksOq3Q0LjzVn0ua1QrtTxG
 eaD5XmVvOuHqgzfqKEwUlWPXw6XQQONdj7uiT5MSGdnUMpeWPki6VmSgOdF9SoDGsZ2Iuv/Eefc
 I5bAWf30LJM2Inv5ZPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280170
Received-SPF: pass client-ip=67.231.149.131; envelope-from=bchaney@akamai.com;
 helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Steve Sistare <steven.sistare@oracle.com>

Stop the vm earlier for cpr, before cpr_save_state which causes new QEMU
to proceed and initialize devices.  We must guarantee devices are stopped
in old QEMU, and all source notifiers called, before they are initialized
in new QEMU.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Ben Chaney <bchaney@akamai.com>
---
 migration/migration.c | 57 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 1bcde301f7..f36e59d9e8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1654,6 +1654,7 @@ void migration_cancel(void)
                           MIGRATION_STATUS_CANCELLED);
         cpr_state_close();
         migrate_hup_delete(s);
+        vm_resume(s->vm_old_state);
     }
 }
 
@@ -2212,6 +2213,7 @@ void qmp_migrate(const char *uri, bool has_channels,
     MigrationAddress *addr = NULL;
     MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
     MigrationChannel *cpr_channel = NULL;
+    bool stopped = false;
 
     /*
      * Having preliminary checks for uri and channel
@@ -2264,6 +2266,46 @@ void qmp_migrate(const char *uri, bool has_channels,
         return;
     }
 
+    /*
+     * CPR-transfer  ordering:
+     *
+     *   SOURCE                              TARGET
+     *   ------                              ------
+     *                                       cpr_state_load() blocks
+     *   |                                        |
+     *   |  1. migration_stop_vm()                |
+     *   |     VM stopped, devices quiesced       |
+     *   |                                        | Waiting for
+     *   |  2. notifiers (PRECOPY_SETUP)          | FDs from source
+     *   |     vhost_reset_owner() releases       |
+     *   |     device ownership                   |
+     *   |                                        |
+     *   |  3. cpr_state_save() ---- FDs -------> |
+     *   |                                        |
+     *   v                                        v
+     *   postmigrate                         Device init begins
+     *                                       - cpr_find_fd()
+     *                                       - vhost_dev_init()
+     *                                       - VHOST_SET_OWNER
+     *
+     * Step 3 is the synchronization/cut-over point. Target proceeds immediately
+     * upon receiving FDs, so steps 1-2 must complete otherwise:
+     * - Target's VHOST_SET_OWNER fails with -EBUSY (source still owns)
+     * - Race between source I/O and target device init
+     *
+     *  We stop the VM early (before FD transfer) to prevent this race.
+     *  Unlike regular migration, CPR-transfer passes memory via FD (memfd)
+     *  rather than copying RAM, so early VM stop should have minimal downtime.
+     */
+    if (migrate_mode_is_cpr(s)) {
+        int ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
+        if (ret < 0) {
+            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
+            goto out;
+        }
+        stopped = true;
+    }
+
     if (!cpr_state_save(cpr_channel, &local_err)) {
         goto out;
     }
@@ -2290,6 +2332,9 @@ out:
     if (local_err) {
         migration_connect_error_propagate(s, error_copy(local_err));
         error_propagate(errp, local_err);
+        if (stopped) {
+            vm_resume(s->vm_old_state);
+        }
     }
 }
 
@@ -2334,6 +2379,9 @@ static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
         }
         migration_connect_error_propagate(s, error_copy(local_err));
         error_propagate(errp, local_err);
+        if (migrate_mode_is_cpr(s)) {
+            vm_resume(s->vm_old_state);
+        }
         return;
     }
 }
@@ -4017,7 +4065,6 @@ void migration_connect(MigrationState *s, Error *error_in)
     Error *local_err = NULL;
     uint64_t rate_limit;
     bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
-    int ret;
 
     /*
      * If there's a previous error, free it and prepare for another one.
@@ -4088,14 +4135,6 @@ void migration_connect(MigrationState *s, Error *error_in)
         return;
     }
 
-    if (migrate_mode_is_cpr(s)) {
-        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
-        if (ret < 0) {
-            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
-            goto fail;
-        }
-    }
-
     /*
      * Take a refcount to make sure the migration object won't get freed by
      * the main thread already in migration_shutdown().

-- 
2.34.1


