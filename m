Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BD9F433D0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 23:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD9fv-00016F-5m; Wed, 15 Apr 2026 19:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wD9fi-00013x-IP
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 19:29:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wD9fg-00011W-4p
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 19:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776295763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QDdW5psnASriwqAha13B7nHWu8m/JIs4baxXcH9bxPQ=;
 b=hArgLsOQMwDrU5TJbXLwE5hIKhV/sInuVsbeY3M0yraiyI/1w4WRBn9S1anVtJ3CzvVRQD
 XJ9aNkOX+66HAjN9+QoaGGQygKB3NrFpCBH0YPGsKi8Yev+wTI3/D5dGoPwcVWWdZog+5z
 FYVHMGRVM2Mp7ThzX/Y9Hp6VxMDb3a0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-p2vHyAZfPgSei7bvYP_a7A-1; Wed,
 15 Apr 2026 19:29:20 -0400
X-MC-Unique: p2vHyAZfPgSei7bvYP_a7A-1
X-Mimecast-MFC-AGG-ID: p2vHyAZfPgSei7bvYP_a7A_1776295759
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56F0A18005A9; Wed, 15 Apr 2026 23:29:19 +0000 (UTC)
Received: from localhost (unknown [10.44.34.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C36B1955F43; Wed, 15 Apr 2026 23:29:17 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 2/2] scsi: handle reservation changes across migration
Date: Wed, 15 Apr 2026 19:29:06 -0400
Message-ID: <20260415232906.212349-3-stefanha@redhat.com>
In-Reply-To: <20260415232906.212349-1-stefanha@redhat.com>
References: <20260415232906.212349-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Other nodes in the cluster can preempt or clear SCSI Persistent
Reservations at any time. When this happens across live migration, the
reservation state transferred with the guest might be outdated.

Attempt to handle such cases gracefully by checking the current
reservation or registered keys to detect stale state before restoring.
If the actual state of the disk has changed, do not modify it and accept
that as the most up-to-date state.

Do this using READ RESERVATION when the guest holds a reservation or
READ KEYS when the guest has registered a key but does not hold a
reservation.

There is still a race condition between checking and restoring state,
but it seems unavoidable and is no worse than before.

Buglink: https://redhat.atlassian.net/browse/RHEL-153123
Fixes: ab57b51f1375b6a6f098a74c6f79207a9630948d ("scsi: save/load SCSI reservation state")
Reported-by: Qing Wang
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/scsi-generic.c | 173 +++++++++++++++++++++++++++++++++++------
 1 file changed, 149 insertions(+), 24 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 29bc952af5..8999f3b720 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -479,13 +479,84 @@ static bool scsi_generic_pr_preempt(SCSIDevice *s, uint64_t key,
     return true;
 }
 
+/*
+ * Returns true if the given key is registered or false otherwise (including
+ * errors).
+ */
+static bool scsi_generic_pr_key_registered(SCSIDevice *s, uint64_t key,
+                                           Error **errp)
+{
+    const size_t key_list_offset = 8; /* in READ KEYS parameter data */
+    uint64_t key_be = cpu_to_be64(key);
+    uint8_t cmd[10] = {};
+    size_t buf_len;
+    g_autofree uint8_t *buf = NULL;
+    uint32_t additional_length = 16 * 8; /* initial key list size */
+
+    /*
+     * Loop to resize parameter data buffer when there are many keys. It would
+     * be simpler to hardcode the maximum buffer size (it's only 64 KB), but
+     * SG_IO can fail with EINVAL if the host kernel blkdev queue limits are
+     * too low.
+     */
+    do {
+        uint16_t allocation_length_be;
+        int ret;
+
+        buf_len = key_list_offset + additional_length;
+        buf = g_realloc(buf, buf_len);
+        memset(buf, 0, buf_len);
+
+        cmd[0] = PERSISTENT_RESERVE_IN;
+        cmd[1] = PRI_READ_KEYS;
+        allocation_length_be = cpu_to_be16(buf_len);
+        memcpy(&cmd[7], &allocation_length_be, sizeof(allocation_length_be));
+
+        ret = scsi_SG_IO(s->conf.blk, SG_DXFER_FROM_DEV, cmd, sizeof(cmd),
+                         buf, buf_len, s->io_timeout, errp);
+        if (ret < 0) {
+            error_prepend(errp, "PERSISTENT RESERVE IN with READ KEYS: ");
+            return false;
+        }
+
+        memcpy(&additional_length, &buf[4], sizeof(additional_length));
+        be32_to_cpus(&additional_length);
+
+        /*
+         * The parameter data's ADDITIONAL LENGTH must not overflow the CDB's
+         * 16-bit ALLOCATION LENGTH field since the next loop iteration will
+         * compute ALLOCATION LENGTH based on ADDITIONAL LENGTH.
+         */
+        if (additional_length > UINT16_MAX - key_list_offset) {
+            error_setg(errp, "got invalid ADDITIONAL LENGTH %" PRIu32
+                       " from READ KEYS", additional_length);
+            return false;
+        }
+
+        for (size_t i = key_list_offset; i < buf_len; i += sizeof(key_be)) {
+            if (i - key_list_offset >= additional_length) {
+                break; /* end of parameter list */
+            }
+
+            if (memcmp(&key_be, &buf[i], sizeof(key_be)) == 0) {
+                return true; /* key found */
+            }
+        }
+    } while (additional_length > buf_len - key_list_offset);
+
+    return false; /* key not found */
+}
+
 /* Register keys and preempt reservations after live migration */
 bool scsi_generic_pr_state_preempt(SCSIDevice *s, Error **errp)
 {
     SCSIPRState *pr_state = &s->pr_state;
+    Error *local_err = NULL;
+    bool check_stale_key = true;
     uint64_t key;
     uint8_t resv_type;
 
+    /* Get the migrated PR state */
     WITH_QEMU_LOCK_GUARD(&pr_state->mutex) {
         key = pr_state->key;
         resv_type = pr_state->resv_type;
@@ -493,36 +564,90 @@ bool scsi_generic_pr_state_preempt(SCSIDevice *s, Error **errp)
 
     trace_scsi_generic_pr_state_preempt(key, resv_type);
 
-    if (key) {
-        if (!scsi_generic_pr_register(s, key, errp)) {
+    /* Handle stale PR state (e.g. another node preempted) */
+    if (resv_type) {
+        uint64_t dev_key;
+        uint8_t dev_resv_type;
+
+        if (scsi_generic_read_reservation(s, &dev_key, &dev_resv_type,
+                                          errp) < 0) {
             return false;
         }
 
-        /*
-         * Two cases:
-         *
-         * 1. There is no reservation (resv_type is 0) and the other I_T nexus
-         *    will be unregistered. This is important so the source host does
-         *    not leak registered keys across live migration.
-         *
-         * 2. There is a reservation (resv_type is not 0) and the other I_T
-         *    nexus will be unregistered and its reservation is atomically
-         *    taken over by us. This is the scenario where a reservation is
-         *    migrated along with the guest.
-         */
-        if (!scsi_generic_pr_preempt(s, key, resv_type, errp)) {
+        if (dev_resv_type != resv_type) {
+            /* vmstate had a stale reservation type */
+            g_autofree char *name = qdev_get_human_name(&s->qdev);
+            warn_report("Expected SCSI reservation type 0x%x on device '%s', "
+                        "got 0x%x, using new type",
+                        resv_type, name, dev_resv_type);
+            resv_type = dev_resv_type;
+        }
+
+        if (dev_key == key) {
+            /* The reservation exists, no need to check for a stale key */
+            check_stale_key = false;
+        } else {
+            g_autofree char *name = qdev_get_human_name(&s->qdev);
+            warn_report("Expected SCSI reservation with key 0x%" PRIx64
+                        " on device '%s', got 0x%" PRIx64 ", ignoring "
+                        "reservation",
+                        key, name, dev_key);
+            resv_type = 0; /* vmstate had a stale reservation */
+        }
+    }
+
+    if (key != 0 && check_stale_key &&
+        !scsi_generic_pr_key_registered(s, key, &local_err)) {
+        if (local_err) {
+            error_propagate(errp, local_err);
             return false;
         }
 
-        /*
-         * Some SCSI targets, like the Linux LIO target, remove our
-         * registration when preempting without a reservation (resv_type is 0).
-         * Try to register again but ignore the error since a RESERVATION
-         * CONFLICT is expected if our registration remained in place.
-         */
-        if (resv_type == 0) {
-            scsi_generic_pr_register(s, key, NULL);
-        }
+        g_autofree char *name = qdev_get_human_name(&s->qdev);
+        warn_report("SCSI reservation key 0x%" PRIx64 " on device '%s' not "
+                    "registered after migration, ignoring",
+                    key, name);
+        key = 0; /* vmstate had a stale key */
+    }
+
+    /* Stale PR state may have been updated */
+    WITH_QEMU_LOCK_GUARD(&pr_state->mutex) {
+        pr_state->key = key;
+        pr_state->resv_type = resv_type;
+    }
+
+    if (key == 0) {
+        return true; /* no PR state, do nothing */
+    }
+
+    if (!scsi_generic_pr_register(s, key, errp)) {
+        return false;
+    }
+
+    /*
+     * Two cases:
+     *
+     * 1. There is no reservation (resv_type is 0) and the other I_T nexus
+     *    will be unregistered. This is important so the source host does
+     *    not leak registered keys across live migration.
+     *
+     * 2. There is a reservation (resv_type is not 0) and the other I_T
+     *    nexus will be unregistered and its reservation is atomically
+     *    taken over by us. This is the scenario where a reservation is
+     *    migrated along with the guest.
+     */
+    if (!scsi_generic_pr_preempt(s, key, resv_type, errp)) {
+        return false;
+    }
+
+    /*
+     * Some SCSI targets, like the Linux LIO target, remove our
+     * registration when preempting without a reservation (resv_type is 0).
+     * Try to register again but ignore the error since a RESERVATION
+     * CONFLICT is expected if our registration remained in place.
+     */
+    if (resv_type == 0) {
+        scsi_generic_pr_register(s, key, NULL);
     }
     return true;
 }
-- 
2.53.0


