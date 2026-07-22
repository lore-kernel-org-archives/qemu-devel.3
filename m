Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62F9C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmVPA-0004XY-RR; Wed, 22 Jul 2026 07:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rangolit@gmail.com>)
 id 1wmLNC-0000Aj-3F
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 21:03:46 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rangolit@gmail.com>)
 id 1wmLN9-0002hA-4o
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 21:03:45 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c15d3cd51b2so1369095266b.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 18:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784682222; x=1785287022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Erq1uqG60FGH82vJJ5aDBApZSrpA1rGh49YRLXOpd+0=;
 b=Oc9EeDhG7Rggt+7SmRenTzZUmMY82AlQ8lHG4Xvk0TS70tjoVaRxBH1D9Sr+TBxLXP
 tJ53w7iKh9XTXJ0O9bhEtGvHlsOc9lnWdUvx9XcX7EjNOWMqzdIga6iC0hNStWGaIWlB
 ER7hlMfTZHSlswmQ5fmTCkVoIetc0WOPFFKf2Ol6U/TIMjQWwoHu7Bu06qze/iVFbk5o
 m+OdHqhFjsg76eAoAUgrocgnKJHTJvUuLA+ERyV9+lhAT8hgeI3SMeiiA+dZRY+uuwst
 WMJLv9t5dTZ7aox+4kVEC483DcNfDZttgVvIFrTrHm5zxqZq0jXROMoGHaRJTJDAjg3m
 EH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784682222; x=1785287022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Erq1uqG60FGH82vJJ5aDBApZSrpA1rGh49YRLXOpd+0=;
 b=eQmvLmN+i8BMnG18ROWxPllEWwTIxvEyLMI18sgUcyuUHGvfh7QdP3HCamsBzye1e0
 BxjAC+bRCgMEMCKq/wx0fAb7CASM3U7yNW3wRy5qwZzh2gMlL1id4BI2jLzOMfvJSGKK
 Bvdktl0KOevwuQzbqpVxs08l/muISPNCN/1esh/GKe5iWb5sXmWbByb88ga5JOCKBSvR
 4CoU/sL8Wyn08DuJzzD6wb18zr2uWU+DnJFRWSFygQrn0YFRjD2jwHI8z2RZlY6cFyXN
 8y0leetofEMCa9lBDGpvtZw9qTgE7m0C7BEqRIJor0LtaDn+mLetXBghHxOAeB8NzBFq
 lRRg==
X-Gm-Message-State: AOJu0YxoNlLJZpU6YN7d6z5G68RdU02C1XXwWUmottKYk8PnuJt83zDM
 LhaJPQGO+71MNXaNcTz5NrWa8uuMo4p6BzQ66oatNOc0S7EKghu6570jrZ8v+jt5yFw=
X-Gm-Gg: AR+sD128e+GFqDxnYrtXDy71R1hBvKiJr7iHE2LsVNZf+yztp51OAqZ1z6v9U4VGjoX
 zmCN9rTYgkgznnt3V8Sj0UUX88RIq67VtjKH+/ZlpRCL1unLZ1cnLA3jlGjgaKmItbU0BwDmDMO
 xNEU+nyyaqK/Li2o+J2WXhActkm6wBM8Xx+KSK+6cTMvStlCp48ykCVeLI4DRDY6u6Y/MK4HyaF
 WyAGhwL9cJeLXaXQVy21XBesXgqKl49s/1ztVkzQiWenUMcN9RyAVF7990pHwdn3tqwfQ3RWxlG
 6wmeGxEOpJxFgioMpI2ovWCO4Wjf7HJhluTaVIFBulv4Uyy3tKpFtWKs8ryEU+E7u2/VO6yZEhk
 ZhRRGWSEMePNYrPlc1uxKk2pXzNMYaFNSmnPv/7z5ZEqjSjB27qHBZR4lYG7Jnf+X+g==
X-Received: by 2002:a17:907:3e1d:b0:c12:34ed:e100 with SMTP id
 a640c23a62f3a-c16b489328cmr952031866b.62.1784682221400; 
 Tue, 21 Jul 2026 18:03:41 -0700 (PDT)
Received: from Arc ([109.245.172.88]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32ebac95sm32694066b.47.2026.07.21.18.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 18:03:40 -0700 (PDT)
From: Konstantin Nigmatullin <rangolit@gmail.com>
To: qemu-devel@nongnu.org
Cc: Konstantin Nigmatullin <rangolit@gmail.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 4/5] iscsi: fail new iSCSI I/O while the transport is known
 down
Date: Wed, 22 Jul 2026 03:02:53 +0200
Message-ID: <20260722010254.424820-5-rangolit@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722010254.424820-1-rangolit@gmail.com>
References: <20260722010254.424820-1-rangolit@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=rangolit@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 22 Jul 2026 07:46:12 -0400
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

After the first disconnect failure, queued requests kept restarting long
waits so blk_drain_all never stayed idle and QEMU could not exit.

See: https://gitlab.com/qemu-project/qemu/-/work_items/3067
Signed-off-by: Konstantin Nigmatullin <rangolit@gmail.com>
---
 block/iscsi.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 330f17e08b..b6207d03e5 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -103,6 +103,12 @@ typedef struct IscsiLun {
     bool dpofua;
     bool has_write_same;
     bool request_timed_out;
+    /*
+     * Set when the transport is known to be down (command or NOP timeout).
+     * New I/O fails immediately until libiscsi reports logged-in again after
+     * reconnect. Prevents drain/shutdown from waiting forever on a dead target.
+     */
+    bool fail_io;
     /* Consecutive NOP-Outs without a successful NOP-In reply. */
     int nop_failures;
 } IscsiLun;
@@ -245,10 +251,12 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
              * Do not retry timed-out commands. Retries keep in-flight I/O
              * alive across a dead session and can block blk_drain_all()
              * (and thus QEMU exit) for minutes or indefinitely. Kick
-             * reconnect and fail this request.
+             * reconnect and fail this request; further I/O is rejected via
+             * fail_io until the session is logged in again.
              */
             error_report("iSCSI timed out: %s", iscsi_get_error(iscsi));
             iscsilun->request_timed_out = true;
+            iscsilun->fail_io = true;
         } else if (iTask->retries++ < ISCSI_CMD_RETRIES) {
             if (status == SCSI_STATUS_BUSY ||
                 status == SCSI_STATUS_TASK_SET_FULL) {
@@ -277,6 +285,9 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
                 }
             }
         }
+    } else {
+        iscsilun->fail_io = false;
+        iscsilun->nop_failures = 0;
     }
 
     /*
@@ -379,6 +390,10 @@ static void iscsi_timed_check_events(void *opaque)
         /* check for timed out requests */
         iscsi_service(iscsilun->iscsi, 0);
 
+        if (iscsilun->fail_io && iscsi_is_logged_in(iscsilun->iscsi)) {
+            iscsilun->fail_io = false;
+        }
+
         if (iscsilun->request_timed_out) {
             iscsilun->request_timed_out = false;
             /*
@@ -604,6 +619,15 @@ static void coroutine_fn iscsi_co_wait_for_task(IscsiTask *iTask,
     qemu_mutex_lock(&iscsilun->mutex);
 }
 
+/* Called with iscsilun->mutex held. */
+static int iscsi_co_reject_if_failing(IscsiLun *iscsilun)
+{
+    if (iscsilun->fail_io) {
+        return -EIO;
+    }
+    return 0;
+}
+
 static int coroutine_fn
 iscsi_co_writev(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
                 QEMUIOVector *iov, int flags)
@@ -631,6 +655,10 @@ iscsi_co_writev(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
     iscsi_co_init_iscsitask(iscsilun, &iTask);
     qemu_mutex_lock(&iscsilun->mutex);
 retry:
+    if (iscsi_co_reject_if_failing(iscsilun)) {
+        r = -EIO;
+        goto out_unlock;
+    }
     if (iscsilun->use_16_for_rw) {
 #if LIBISCSI_API_VERSION >= (20160603)
         iTask.task = iscsi_write16_iov_task(iscsilun->iscsi, iscsilun->lun, lba,
@@ -730,6 +758,10 @@ static int coroutine_fn iscsi_co_block_status(BlockDriverState *bs,
 
     qemu_mutex_lock(&iscsilun->mutex);
 retry:
+    if (iscsi_co_reject_if_failing(iscsilun)) {
+        ret = -EIO;
+        goto out_unlock;
+    }
     if (iscsi_get_lba_status_task(iscsilun->iscsi, iscsilun->lun,
                                   lba, 8 + 16, iscsi_co_generic_cb,
                                   &iTask) == NULL) {
@@ -861,6 +893,10 @@ static int coroutine_fn iscsi_co_readv(BlockDriverState *bs,
     iscsi_co_init_iscsitask(iscsilun, &iTask);
     qemu_mutex_lock(&iscsilun->mutex);
 retry:
+    if (iscsi_co_reject_if_failing(iscsilun)) {
+        qemu_mutex_unlock(&iscsilun->mutex);
+        return -EIO;
+    }
     if (iscsilun->use_16_for_rw) {
 #if LIBISCSI_API_VERSION >= (20160603)
         iTask.task = iscsi_read16_iov_task(iscsilun->iscsi, iscsilun->lun, lba,
@@ -927,6 +963,10 @@ static int coroutine_fn iscsi_co_flush(BlockDriverState *bs)
     iscsi_co_init_iscsitask(iscsilun, &iTask);
     qemu_mutex_lock(&iscsilun->mutex);
 retry:
+    if (iscsi_co_reject_if_failing(iscsilun)) {
+        qemu_mutex_unlock(&iscsilun->mutex);
+        return -EIO;
+    }
     if (iscsi_synchronizecache10_task(iscsilun->iscsi, iscsilun->lun, 0, 0, 0,
                                       0, iscsi_co_generic_cb, &iTask) == NULL) {
         qemu_mutex_unlock(&iscsilun->mutex);
@@ -1170,6 +1210,10 @@ coroutine_fn iscsi_co_pdiscard(BlockDriverState *bs, int64_t offset,
     iscsi_co_init_iscsitask(iscsilun, &iTask);
     qemu_mutex_lock(&iscsilun->mutex);
 retry:
+    if (iscsi_co_reject_if_failing(iscsilun)) {
+        r = -EIO;
+        goto out_unlock;
+    }
     if (iscsi_unmap_task(iscsilun->iscsi, iscsilun->lun, 0, 0, &list, 1,
                          iscsi_co_generic_cb, &iTask) == NULL) {
         r = -ENOMEM;
@@ -1255,6 +1299,10 @@ coroutine_fn iscsi_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
     qemu_mutex_lock(&iscsilun->mutex);
     iscsi_co_init_iscsitask(iscsilun, &iTask);
 retry:
+    if (iscsi_co_reject_if_failing(iscsilun)) {
+        qemu_mutex_unlock(&iscsilun->mutex);
+        return -EIO;
+    }
     if (use_16_for_ws) {
         /*
          * iscsi_writesame16_task num_blocks argument is uint32_t. We rely here
@@ -1423,6 +1471,10 @@ static void iscsi_nop_timed_event(void *opaque)
     IscsiLun *iscsilun = opaque;
 
     QEMU_LOCK_GUARD(&iscsilun->mutex);
+    if (iscsilun->fail_io && iscsi_is_logged_in(iscsilun->iscsi)) {
+        iscsilun->fail_io = false;
+    }
+
     /*
      * Prefer libiscsi's counter when it works; also track locally because
      * some libiscsi builds leave nops_in_flight at 0 across a dead TCP
@@ -1432,6 +1484,7 @@ static void iscsi_nop_timed_event(void *opaque)
         iscsi_get_nops_in_flight(iscsilun->iscsi) >= MAX_NOP_FAILURES) {
         error_report("iSCSI: NOP timeout. Reconnecting...");
         iscsilun->request_timed_out = true;
+        iscsilun->fail_io = true;
         iscsilun->nop_failures = 0;
         iscsi_scsi_cancel_all_tasks(iscsilun->iscsi);
     } else if (iscsi_nop_out_async(iscsilun->iscsi, iscsi_nop_cb, NULL, 0,
@@ -2398,6 +2451,10 @@ iscsi_co_copy_range_to(BlockDriverState *bs,
     qemu_mutex_lock(&dst_lun->mutex);
     iscsi_task.task = iscsi_xcopy_task(data.size);
 retry:
+    if (iscsi_co_reject_if_failing(dst_lun)) {
+        r = -EIO;
+        goto out_unlock;
+    }
     if (iscsi_scsi_command_async(dst_lun->iscsi, dst_lun->lun,
                                  iscsi_task.task, iscsi_co_generic_cb,
                                  &data,
-- 
2.53.0


