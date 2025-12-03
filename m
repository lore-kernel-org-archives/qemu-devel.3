Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D63D1BDCC
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 18:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQrwq-0007SG-A2; Wed, 03 Dec 2025 13:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrwp-0007Qp-14
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:31 -0500
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vQrwn-0000zR-5z
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:30 -0500
Received: from pps.filterd (m0409411.ppops.net [127.0.0.1])
 by m0409411.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 5B3FwH85148441; Wed, 3 Dec 2025 18:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=SCJJjeHJL3zvQFZyNH6s4ysT7NMl476yKiQWW9PF388=; b=Uy6tsZ86GKI0
 Ee/lp5OZYKvBAsIgv+dYboExsM/fr849GjrtMgaX86mMsvpf39/tw1drbQoc3gpY
 DbAyXcJPZ90XK1oY1w6HLgaOGGsIND9m69MHQ4REG5UFUI9CHmXLtiaOv528++he
 7Uxy0KitMddrfr10+N39IGWO4oMEqE1Bsm0Wa3llCSuaDq0S1k7SPw0qso1wdUUV
 RhKaRDIBPrG1u4FSTwe+SPS1AGMJxrBnSH0q1/1TcWh52ch64OB68E04ysN1M5AS
 dspyLwe5IjvzyeiVeDKKkw9tXk7774PomEEEA7vUfZYaK2t8xATC4ohJKu2quUTo
 o41j2FmJkQ==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
 by m0409411.ppops.net-00190b01. (PPS) with ESMTPS id 4at31m8y0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Dec 2025 18:51:27 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
 by prod-mail-ppoint2.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5B3IZ4A0014679; Wed, 3 Dec 2025 13:51:26 -0500
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
 by prod-mail-ppoint2.akamai.com (PPS) with ESMTP id 4aqw21kuh6-1;
 Wed, 03 Dec 2025 13:51:26 -0500
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.40.75])
 by prod-mail-relay01.akamai.com (Postfix) with ESMTP id 9CA8184;
 Wed,  3 Dec 2025 18:51:26 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
Date: Wed, 03 Dec 2025 13:51:18 -0500
Subject: [PATCH v3 1/8] migration: stop vm earlier for cpr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-cpr-tap-v3-1-3c12e0a61f8e@akamai.com>
References: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
In-Reply-To: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764787886; l=4737;
 i=bchaney@akamai.com; s=20251203; h=from:subject:message-id;
 bh=6VO5q5TE5yuukYkhY6LLyhvDeAXk7NNxQPT3gWn7Grw=;
 b=jmB3MnmsjpjuBR/wnVMra/A/TNmA/dppEn5qBFxRW1X9N+Qzwm8MSIeLmEoyL6bBW4kfGSpTe
 KBQX1b8RC8JCBAbmBEwwsEuzkp3Yi6MwqTXXziriNInNkHbQnMZt6qc
X-Developer-Key: i=bchaney@akamai.com; a=ed25519;
 pk=6+w9cse5QEeVdy3tjqFxs/4rAaRdQ2/fkTxVFq+lWy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512030148
X-Proofpoint-GUID: X363mFYwB-pYD7snl9ZTA5UTk2bKOKDW
X-Authority-Analysis: v=2.4 cv=I6Nohdgg c=1 sm=1 tr=0 ts=693086af cx=c_pps
 a=BpD+HMUBsFIkYY1OQe22Yw==:117 a=BpD+HMUBsFIkYY1OQe22Yw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=X7Ea-ya5AAAA:8 a=Q2gaB0lLyM3LBXvKuXcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: X363mFYwB-pYD7snl9ZTA5UTk2bKOKDW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDE0NyBTYWx0ZWRfXyRMrCv7efKI4
 J0fG9e7AoGAIaTK/g2DnvAh0BYkYO1uJhegDdLplFQVZ03pZWTFNrB8M1GikGIIyzVVMjJgqotO
 6BHvCV8vooMm011YWkfLYmu3qxJ9FtCCdjKM3GrF2VST78BnyaFATDfNOTZi3h4zhQaPFJYEKY9
 rQG4lXAATcRASrVBX32Ypz7uO0KBk+mj2XNJCitOYk1m7wmMjzDBRdI6SXb5/WlBtWV6SukhLKF
 8fAXveIW48hw4LTLt4M1u9FcWEKPN8ke8pCiPo4FgX6W5qeRh1mUIDF1PL2k4U8MUOaiHTYkXQX
 erUSpPB1FawxYWMCauQ0jf97ZZIfkfHWqH4YhFYhYH7/wf7xc/VTrS0zDwHSAUV4gMO+O84wEv7
 2Xdo95s5s8zP9suNutu85SE05BJ8Tw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_02,2025-12-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030147
Received-SPF: pass client-ip=67.231.157.127; envelope-from=bchaney@akamai.com;
 helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index c2daab6bdd..6d40697767 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1657,6 +1657,7 @@ void migration_cancel(void)
                           MIGRATION_STATUS_CANCELLED);
         cpr_state_close();
         migrate_hup_delete(s);
+        vm_resume(s->vm_old_state);
     }
 }
 
@@ -2216,6 +2217,7 @@ void qmp_migrate(const char *uri, bool has_channels,
     MigrationAddress *addr = NULL;
     MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
     MigrationChannel *cpr_channel = NULL;
+    bool stopped = false;
 
     /*
      * Having preliminary checks for uri and channel
@@ -2268,6 +2270,46 @@ void qmp_migrate(const char *uri, bool has_channels,
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
@@ -2294,6 +2336,9 @@ out:
     if (local_err) {
         migration_connect_set_error(s, local_err);
         error_propagate(errp, local_err);
+        if (stopped) {
+            vm_resume(s->vm_old_state);
+        }
     }
 }
 
@@ -2339,6 +2384,9 @@ static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
         }
         migration_connect_set_error(s, local_err);
         error_propagate(errp, local_err);
+        if (migrate_mode_is_cpr(s)) {
+            vm_resume(s->vm_old_state);
+        }
         return;
     }
 }
@@ -4028,7 +4076,6 @@ void migration_connect(MigrationState *s, Error *error_in)
     Error *local_err = NULL;
     uint64_t rate_limit;
     bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
-    int ret;
 
     /*
      * If there's a previous error, free it and prepare for another one.
@@ -4099,14 +4146,6 @@ void migration_connect(MigrationState *s, Error *error_in)
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


