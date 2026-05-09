Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EED1CD343F
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 05:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLa9w-0000jH-Mq; Sat, 09 May 2026 01:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wLa9v-0000id-A0
 for qemu-devel@nongnu.org; Sat, 09 May 2026 01:23:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wLa9t-0007N5-DG
 for qemu-devel@nongnu.org; Sat, 09 May 2026 01:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778304204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WHAANPw3hoVZMvfFza2Z/uOEAoSMVMaGiu2b+FC5QMc=;
 b=MfvNN9I3u8KIlwlw9BZOE/gt6/nBsbq7dMV5ARWaYMqNR96qZ6by396tSc4ZWNu2sm83b8
 gQ2aA46Yjo91GVdKfwYUfgukHQoJ4+T9KcbMpT9xMh3fjTXDMwZ4GHuDCDIirpB9k2vQZr
 1nW/bzzLmPINqmTTCHnuP1JIZgInn/g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-EkUzxY_PMK2EU96XbbU-IA-1; Sat, 09 May 2026 01:23:23 -0400
X-MC-Unique: EkUzxY_PMK2EU96XbbU-IA-1
X-Mimecast-MFC-AGG-ID: EkUzxY_PMK2EU96XbbU-IA_1778304202
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43d7a5b9678so1758927f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 22:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778304201; x=1778909001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHAANPw3hoVZMvfFza2Z/uOEAoSMVMaGiu2b+FC5QMc=;
 b=JoDPhNtBBWe/rfRhBA15TDogzGloDHGs1XzMFrFMTBBD0K2MFaFaiBNIQ3HE2aTCxJ
 7W6oLLEr3iSG3v8hOFubbFLi275suXzf75RcPN6Fb2lwYwDEvZ6FkyBjRs7fYLESgp2d
 sQgQSqMwul+kL26GWQPbmm8CkWQnE0YT+urDoNDFRJBgQk5fdvMxlRgE2E5rUsIZ9saD
 +znwJe52bx6lWW0BbfrJpA8MN3v2dHum17qc9XW6HBfdXvnxiMiFBE+jKG2bPlvZL5I4
 32jL2TIaSV/D80kYOZc2YZM6CxvbcXlFKYbKehWzhy46GceaHYXrybuD71ZNB/o7hMs2
 4uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778304201; x=1778909001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WHAANPw3hoVZMvfFza2Z/uOEAoSMVMaGiu2b+FC5QMc=;
 b=oiS2pv7kwgVbB8qQqYR1R+XX2shmd0rv/7z8s3fZ5BidQ6pZnn0/Er9LhZHU2lBUcc
 c+Lx/56hnHa3fhtAehDMeG+J/sPsVNOenKUbIXI9QLvEPAvZtCPJ8XCib/i0eGIqvZIf
 MN5mgSVVDFqgIPUu1/2wClLvKPcUpTBfM2ru+NXEdWDZEXKmk9GOIP/mPLVPuXlXmwON
 QAVtvd2iAmjb3ZBbFiKikzUwblhioa2w6me255pd10olXQJ3nQVyZk/MhKE4i6ToRghD
 LE+VXvBpHI5kmawLqYqmvfqowbLVefeu9RaLA9jOw+fFjxQnGA0zjDqMNAea4+pFu3oC
 ocag==
X-Gm-Message-State: AOJu0YzkCVnSPwxhj+/fK0pvdaEsabRTPmU8ijHcjf+gDo+DaNfIbUdO
 UD5em2hbA34gRiCsngS1Hn6mr0Gim9RVJVr2L4lUn1fmV+BoufVwMA7/txQeSKnCPkMG/bdAUhm
 y0o4uHxrVnv96/vZ806g4sUxk/7BzAez4jMjIQ1yVR+PvtnuCJ+ERhD3U7jankbh7MKA7KiYul/
 m8ZlH0Ee1a6jh046U9gOZsKKuqt5bS/LNbm1RXrXxq
X-Gm-Gg: Acq92OEekvwGizaX29ost5oO9j+PoLJHSSk31dV43GOhqp0vetFNpOzGdkfNYmyjaLd
 FnAHqaosc5+2Lqnv4G5yT0sOHlQ3qF9XRJ0zdTs32iQVc36bgyzYDPrfE0/nPxX9NP+8IUDKczp
 KpPpLcsElW9Hrxjt0qXMb3oob5nyWna7lQDd3Z/zI6QP7tlJtqFXPxeNqc2DWrtTck9tJNbBpPo
 nW+5uM2JOSnVaVgRgHrJIyy9ilzkUNf75AZe7eRiEwlZdPC3heFVd3gGMr5/RP+sLqr5HcFsBHP
 BHW1hCLRQFvVKE+HkLi+2j5Ld6ujPg3jKpShOaha73KJf1MtUDczQOc0MKk25so3m5hX+V74LPn
 j3vwleVV8Vhds2XnWiYaYFpWXKmhpllvELj5E6Zfyc49Z5rIMm2PIM8M8qENrBqvGeuHdw+0b1b
 R0BxNaNrEs10Pn2usicI53PnEJilFL
X-Received: by 2002:a05:600c:8486:b0:48a:6fd4:d3d3 with SMTP id
 5b1f17b1804b1-48e706be062mr15119355e9.20.1778304201043; 
 Fri, 08 May 2026 22:23:21 -0700 (PDT)
X-Received: by 2002:a05:600c:8486:b0:48a:6fd4:d3d3 with SMTP id
 5b1f17b1804b1-48e706be062mr15118915e9.20.1778304200442; 
 Fri, 08 May 2026 22:23:20 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e701e9585sm24194945e9.5.2026.05.08.22.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 22:23:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 5/5] scsi: handle reservation changes across migration
Date: Sat,  9 May 2026 07:23:04 +0200
Message-ID: <20260509052304.2159829-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509052304.2159829-1-pbonzini@redhat.com>
References: <20260509052304.2159829-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

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
Link: https://lore.kernel.org/r/20260415232906.212349-3-stefanha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-generic.c | 173 +++++++++++++++++++++++++++++++++++------
 1 file changed, 149 insertions(+), 24 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 29bc952af5d..8999f3b7200 100644
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
2.54.0


