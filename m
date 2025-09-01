Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62432CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 09:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut0iv-0001hm-PM; Mon, 01 Sep 2025 05:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cjchen@igel.co.jp>) id 1ut0io-0001fp-5e
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 05:21:06 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cjchen@igel.co.jp>) id 1ut0id-00025g-Sd
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 05:21:05 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-248a61a27acso29267325ad.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 02:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1756718451; x=1757323251;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=suPF5eHN599eEn8ssEkh6c0CY3/BMDLdWzuuryRGhoQ=;
 b=Ro6mbCfUPwmH32cT6Qj2brQhY79b+z1a6bnuosqHYCRIcN6ju48xOfhPrV3UDdGMtS
 m4ke8EHIqCUsrzV8OfOCI42F+rTBJSSvixadntu465hGEFHHE7QPbUeknTSeXfSJiHxD
 Vh59xbDfJ1eyHwqTC/CxQdkp6pbEzpCf+VonPW+RakqQHckBRm9zLw/gw21U/GyrWF4r
 G26AA5dT6BntV2gY5pvJnpx11JsCtnprbOED0q/kXsWsbjZhHI8IC30pS/5sSSIL5teo
 v16+jQIs6En4n1ZZu/5KBeZpXdfkbzcXXEgJ5eyCnxdHc87IemqnuLXfoUKIG2tQ+/66
 mSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756718451; x=1757323251;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=suPF5eHN599eEn8ssEkh6c0CY3/BMDLdWzuuryRGhoQ=;
 b=gsx2IVlK+nD0y0VG8o7AQDCl7Dw7I8ddJ+gbBITJtamREJb3FRg157Qh2ghGNscCHu
 pqaKHIT+X8KH8+pwEZ0ddPkdSrpKo0Na85grzR83gTiU7ilg0krY/frePrisy9+c5BiV
 54NUlsMZXdobdeqdoIxHNgKgiWhiTx6AFxE1mMMfVGDGcOsWjBQ4m0yr6nFy13Ykg3XR
 ZjZm4TDCWz6Wp9SJEjxR5EgVjyOnb1XiR7l8fvXuFYlVCMpHY7drbwNIO8xZgzMEYynC
 3QhABZI4HCrvjE/NP2w5sX5CtTWVDbc6wxqS5wsdZ/lwmlet4+jghc+poxccCxam87fU
 7VWQ==
X-Gm-Message-State: AOJu0Yz93jGjqQWBQXRWQZ+G80CYLoD8d47b0xxQ/xiWnFoGVn9UKc8/
 ggBfqX2WrK3P0fYkl0Hmvpvu9W52TvsQ57wYItvPE+Pe4AgRg79/x/E/JIfgagIBD18ztk7nIiO
 ALSQw
X-Gm-Gg: ASbGnctis4s7UstT4JIav16vuYNyj0c7Cs7G8ynC3bGq+3d2mmQbTvTapgR1PgRK9nU
 HIM3UsQTo4hDsi+IRde3bvZ1BsU/2QYX+XzTDrPogFvst3dJZhU4xEgIA0wdWgYBo4YwK/nGSe4
 wOuNzOIac3vA5CoPN0gKR1tzxt1WjaQpkfgoD1Uuhnu3/mC7P+LfCa+enVCRG+k12VoMjqGg6WE
 VUdBUsLYar+J20jnQCYFBppsiaP2LRWgX+FujzwxkAZGTszB579kPnNS9CDC16XS+W3fSCjpPRE
 8IXfhJDblStxbIp+x7ksaVgKKDt4aK4MA1LL4P0aLaJgbcaeOhRo13dj42lKLmxtKmKkRgsste5
 TIBvQrozOE9Idqm5VuEWaDrXRKWMItPGNYoKRLZz+kHh7v9z0O3Ze
X-Google-Smtp-Source: AGHT+IGu6FOs8vCckEqRAXBjcWYAhdxs2hj/MeBmPzeFalL/bJOFaOXIhmehrCbxJQzu9QyDlBsnRg==
X-Received: by 2002:a17:903:46cf:b0:249:1bce:49eb with SMTP id
 d9443c01a7336-2494486efb2mr108582055ad.5.1756718451122; 
 Mon, 01 Sep 2025 02:20:51 -0700 (PDT)
Received: from warg.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490648c89bsm98913605ad.109.2025.09.01.02.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 02:20:50 -0700 (PDT)
From: CJ Chen <cjchen@igel.co.jp>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 cjchen@igel.co.jp
Subject: [PATCH] block/iscsi: fix crashes on session disconnect and I/O hard
 timeout
Date: Mon,  1 Sep 2025 18:20:43 +0900
Message-Id: <20250901092043.28722-1-cjchen@igel.co.jp>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=cjchen@igel.co.jp; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When an iSCSI session drops or an I/O stalls past a hard timeout,
requests could complete after teardown and coroutines might be woken
in an invalid state. This patch clarifies task ownership and hardens
completion paths.

Changes:
 - Add a per-command deadline (I/O hard timeout). On expiry, cancel
   the libiscsi task, detach the coroutine (co = NULL), and let the
   callback free the task safely.
 - Track inflight tasks and fail them promptly on session disconnect
   when fail-fast is enabled. Throttle reconnect attempts and drive
   them via the periodic timer and NOP keepalives.
 - Always refresh the fd event mask after state changes. Tidy event,
   read, and write handlers, and remove unused labels/duplicates.
 - Arm deadlines only for heap-allocated tasks (read/write/flush).
   Stack-based helper paths continue to wait synchronously without
   deadlines.

User-visible effect: under error conditions we now return -ETIMEDOUT
or -ENOTCONN instead of hanging or crashing. Normal I/O behavior is
unchanged. Internally, a 5s hard timeout with fail-fast is enforced to
avoid indefinite stalls.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3067

Signed-off-by: CJ Chen <cjchen@igel.co.jp>
---
 block/iscsi.c | 449 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 358 insertions(+), 91 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 15b96ee880..094b51c47c 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -49,6 +49,7 @@
 #include "crypto/secret.h"
 #include "scsi/utils.h"
 #include "trace.h"
+#include "qemu/timer.h"
 
 /* Conflict between scsi/utils.h and libiscsi! :( */
 #define SCSI_XFER_NONE ISCSI_XFER_NONE
@@ -74,6 +75,8 @@ typedef struct IscsiLun {
     QEMUTimer *nop_timer;
     QEMUTimer *event_timer;
     QemuMutex mutex;
+    int64_t next_reconnect_ms;   /* throttle repeated reconnects */
+    bool last_logged_in;         /* for state-change logging */
     struct scsi_inquiry_logical_block_provisioning lbp;
     struct scsi_inquiry_block_limits bl;
     struct scsi_inquiry_device_designator *dd;
@@ -103,6 +106,9 @@ typedef struct IscsiLun {
     bool dpofua;
     bool has_write_same;
     bool request_timed_out;
+    uint32_t io_hard_timeout_ms;
+    bool fail_fast;
+    QTAILQ_HEAD(, IscsiTask) inflight;
 } IscsiLun;
 
 typedef struct IscsiTask {
@@ -116,6 +122,12 @@ typedef struct IscsiTask {
     QEMUTimer retry_timer;
     int err_code;
     char *err_str;
+    QEMUTimer deadline_timer;
+    bool deadline_armed;
+    bool hard_timed_out;
+    int64_t first_submit_ms;
+    QTAILQ_ENTRY(IscsiTask) entry;
+    bool on_list;
 } IscsiTask;
 
 typedef struct IscsiAIOCB {
@@ -185,7 +197,9 @@ static void iscsi_co_generic_bh_cb(void *opaque)
     struct IscsiTask *iTask = opaque;
 
     iTask->complete = 1;
-    aio_co_wake(iTask->co);
+    if (iTask->co) {
+        aio_co_wake(iTask->co);
+    }
 }
 
 static void iscsi_retry_timer_expired(void *opaque)
@@ -232,75 +246,148 @@ static int iscsi_translate_sense(struct scsi_sense *sense)
                                sense->ascq & 0xFF);
 }
 
+static void iscsi_fail_inflight(IscsiLun *s, int err)
+{
+    IscsiTask *it, *next;
+    int n = 0;
+
+    QTAILQ_FOREACH_SAFE(it, &s->inflight, entry, next) {
+        if (it->deadline_armed) {
+            timer_del(&it->deadline_timer);
+            it->deadline_armed = false;
+        }
+        it->err_code = err ? err : -EIO;
+        it->hard_timed_out = true;
+        it->status = SCSI_STATUS_TIMEOUT;
+
+        if (it->task) {
+            iscsi_scsi_cancel_task(s->iscsi, it->task);
+        }
+
+        if (it->co) {
+            replay_bh_schedule_oneshot_event(s->aio_context,
+                                             iscsi_co_generic_bh_cb, it);
+        } else {
+            it->complete = 1;
+        }
+        QTAILQ_REMOVE(&s->inflight, it, entry);
+        it->on_list = false;
+        n++;
+    }
+}
+
 /* Called (via iscsi_service) with QemuMutex held.  */
 static void
 iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
-                        void *command_data, void *opaque)
+                    void *command_data, void *opaque)
 {
     struct IscsiTask *iTask = opaque;
     struct scsi_task *task = command_data;
 
+    if (iTask->deadline_armed) {
+        timer_del(&iTask->deadline_timer);
+        iTask->deadline_armed = false;
+    }
+
     iTask->status = status;
     iTask->do_retry = 0;
     iTask->err_code = 0;
     iTask->task = task;
 
     if (status != SCSI_STATUS_GOOD) {
-        iTask->err_code = -EIO;
-        if (iTask->retries++ < ISCSI_CMD_RETRIES) {
-            if (status == SCSI_STATUS_BUSY ||
-                status == SCSI_STATUS_TIMEOUT ||
-                status == SCSI_STATUS_TASK_SET_FULL) {
-                unsigned retry_time =
-                    exp_random(iscsi_retry_times[iTask->retries - 1]);
-                if (status == SCSI_STATUS_TIMEOUT) {
-                    /* make sure the request is rescheduled AFTER the
-                     * reconnect is initiated */
-                    retry_time = EVENT_INTERVAL * 2;
-                    iTask->iscsilun->request_timed_out = true;
-                }
-                error_report("iSCSI Busy/TaskSetFull/TimeOut"
-                             " (retry #%u in %u ms): %s",
-                             iTask->retries, retry_time,
-                             iscsi_get_error(iscsi));
-                aio_timer_init(iTask->iscsilun->aio_context,
-                               &iTask->retry_timer, QEMU_CLOCK_REALTIME,
-                               SCALE_MS, iscsi_retry_timer_expired, iTask);
-                timer_mod(&iTask->retry_timer,
-                          qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + retry_time);
-                iTask->do_retry = 1;
-                return;
-            } else if (status == SCSI_STATUS_CHECK_CONDITION) {
-                int error = iscsi_translate_sense(&task->sense);
-                if (error == EAGAIN) {
-                    error_report("iSCSI CheckCondition: %s",
+        if (iTask->hard_timed_out) {
+            iTask->err_code = -ETIMEDOUT;
+            iTask->err_str = g_strdup("iSCSI hard timeout");
+            iTask->do_retry = 0;
+        } else {
+            iTask->err_code = -EIO;
+            if (iTask->retries++ < ISCSI_CMD_RETRIES) {
+                if (status == SCSI_STATUS_BUSY ||
+                    status == SCSI_STATUS_TIMEOUT ||
+                    status == SCSI_STATUS_TASK_SET_FULL) {
+                    unsigned retry_time =
+                        exp_random(iscsi_retry_times[iTask->retries - 1]);
+                    if (status == SCSI_STATUS_TIMEOUT) {
+                        /*
+                         * make sure the request is rescheduled AFTER the
+                         * reconnect is initiated
+                         */
+                        retry_time = EVENT_INTERVAL * 2;
+                        iTask->iscsilun->request_timed_out = true;
+                    }
+                    error_report("iSCSI Busy/TaskSetFull/TimeOut"
+                                 " (retry #%u in %u ms): %s",
+                                 iTask->retries, retry_time,
                                  iscsi_get_error(iscsi));
+                    aio_timer_init(iTask->iscsilun->aio_context,
+                                   &iTask->retry_timer, QEMU_CLOCK_REALTIME,
+                                   SCALE_MS, iscsi_retry_timer_expired, iTask);
+                    timer_mod(&iTask->retry_timer,
+                              qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + retry_time);
                     iTask->do_retry = 1;
+                    return;
+                } else if (status == SCSI_STATUS_CHECK_CONDITION) {
+                    int error = iscsi_translate_sense(&task->sense);
+                    if (error == EAGAIN) {
+                        error_report("iSCSI CheckCondition: %s",
+                                     iscsi_get_error(iscsi));
+                        iTask->do_retry = 1;
+                    } else {
+                        iTask->err_code = -error;
+                        iTask->err_str = g_strdup(iscsi_get_error(iscsi));
+                    }
                 } else {
-                    iTask->err_code = -error;
+                    if (!iTask->err_str) {
+                        iTask->err_str = g_strdup(iscsi_get_error(iscsi));
+                    }
+                }
+            } else {
+                if (!iTask->err_str) {
                     iTask->err_str = g_strdup(iscsi_get_error(iscsi));
                 }
             }
         }
     }
-
     if (iTask->co) {
         replay_bh_schedule_oneshot_event(iTask->iscsilun->aio_context,
                                          iscsi_co_generic_bh_cb, iTask);
     } else {
         iTask->complete = 1;
+        if (iTask->task) {
+            scsi_free_scsi_task(iTask->task);
+            iTask->task = NULL;
+        }
+        g_free(iTask->err_str);
+        g_free(iTask);
     }
+
 }
 
 static void coroutine_fn
 iscsi_co_init_iscsitask(IscsiLun *iscsilun, struct IscsiTask *iTask)
 {
     *iTask = (struct IscsiTask) {
-        .co         = qemu_coroutine_self(),
-        .iscsilun   = iscsilun,
+        .co              = qemu_coroutine_self(),
+        .iscsilun        = iscsilun,
+        .deadline_armed  = false,
+        .hard_timed_out  = false,
+        .first_submit_ms = qemu_clock_get_ms(QEMU_CLOCK_REALTIME),
+        .on_list         = false,
     };
 }
 
+static IscsiTask * coroutine_fn iscsi_task_new(IscsiLun *iscsilun)
+{
+    IscsiTask *iTask = g_new0(IscsiTask, 1);
+    iTask->co              = qemu_coroutine_self();
+    iTask->iscsilun        = iscsilun;
+    iTask->deadline_armed  = false;
+    iTask->hard_timed_out  = false;
+    iTask->first_submit_ms = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    iTask->on_list         = false;
+    return iTask;
+}
+
 #ifdef __linux__
 
 /* Called (via iscsi_service) with QemuMutex held. */
@@ -371,17 +458,85 @@ iscsi_set_events(IscsiLun *iscsilun)
     }
 }
 
+/* Try to (re)connect, but throttle to avoid storms. */
+static void iscsi_maybe_reconnect(IscsiLun *iscsilun)
+{
+    int64_t now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    if (now < iscsilun->next_reconnect_ms) {
+        return;
+    }
+    iscsi_reconnect(iscsilun->iscsi);
+    iscsilun->next_reconnect_ms = now + 2000; /* 2s throttle */
+    /* After changing connection state, refresh event mask immediately. */
+    iscsi_set_events(iscsilun);
+}
+
+static void iscsi_deadline_timer_expired(void *opaque)
+{
+    struct IscsiTask *iTask = opaque;
+    IscsiLun *iscsilun = iTask->iscsilun;
+
+    if (!iTask->deadline_armed) {
+        return;
+    }
+    iTask->deadline_armed = false;
+    iTask->hard_timed_out = true;
+    iTask->status   = SCSI_STATUS_TIMEOUT;
+    iTask->err_code = -ETIMEDOUT;
+
+    if (iscsilun) {
+        qemu_mutex_lock(&iscsilun->mutex);
+        if (iTask->task) {
+            iscsi_scsi_cancel_task(iscsilun->iscsi, iTask->task);
+            if (iTask->co) {
+                replay_bh_schedule_oneshot_event(iscsilun->aio_context,
+                                                 iscsi_co_generic_bh_cb, iTask);
+            }
+            iscsi_set_events(iscsilun);
+        }
+        qemu_mutex_unlock(&iscsilun->mutex);
+    }
+}
+
+static inline void iscsi_arm_deadline(struct IscsiTask *iTask)
+{
+    IscsiLun *iscsilun = iTask->iscsilun;
+
+    if (!iscsilun->io_hard_timeout_ms || iTask->deadline_armed) {
+        return;
+    }
+    aio_timer_init(iscsilun->aio_context, &iTask->deadline_timer,
+                   QEMU_CLOCK_REALTIME, SCALE_MS,
+                   iscsi_deadline_timer_expired, iTask);
+    timer_mod(&iTask->deadline_timer,
+              iTask->first_submit_ms + iscsilun->io_hard_timeout_ms);
+    iTask->deadline_armed = true;
+}
+
 static void iscsi_timed_check_events(void *opaque)
 {
     IscsiLun *iscsilun = opaque;
 
     WITH_QEMU_LOCK_GUARD(&iscsilun->mutex) {
+        bool logged_in_before = iscsilun->last_logged_in;
+        bool logged_in_now;
         /* check for timed out requests */
         iscsi_service(iscsilun->iscsi, 0);
+        logged_in_now = iscsi_is_logged_in(iscsilun->iscsi);
+        if (logged_in_before != logged_in_now) {
+            iscsilun->last_logged_in = logged_in_now;
+            if (logged_in_before && !logged_in_now && iscsilun->fail_fast) {
+                iscsi_fail_inflight(iscsilun, -ENOTCONN);
+            }
+        }
 
         if (iscsilun->request_timed_out) {
             iscsilun->request_timed_out = false;
-            iscsi_reconnect(iscsilun->iscsi);
+            iscsi_maybe_reconnect(iscsilun);
+        }
+
+        if (!logged_in_now) {
+            iscsi_maybe_reconnect(iscsilun);
         }
 
         /*
@@ -605,7 +760,7 @@ iscsi_co_writev(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
                 QEMUIOVector *iov, int flags)
 {
     IscsiLun *iscsilun = bs->opaque;
-    struct IscsiTask iTask;
+    IscsiTask *iTask;
     uint64_t lba;
     uint32_t num_sectors;
     bool fua = flags & BDRV_REQ_FUA;
@@ -624,21 +779,27 @@ iscsi_co_writev(BlockDriverState *bs, int64_t sector_num, int nb_sectors,
 
     lba = sector_qemu2lun(sector_num, iscsilun);
     num_sectors = sector_qemu2lun(nb_sectors, iscsilun);
-    iscsi_co_init_iscsitask(iscsilun, &iTask);
+    iTask = iscsi_task_new(iscsilun);
     qemu_mutex_lock(&iscsilun->mutex);
+    if (iscsilun->fail_fast && !iscsi_is_logged_in(iscsilun->iscsi)) {
+        qemu_mutex_unlock(&iscsilun->mutex);
+        g_free(iTask->err_str);
+        g_free(iTask);
+        return -ENOTCONN;
+    }
 retry:
     if (iscsilun->use_16_for_rw) {
 #if LIBISCSI_API_VERSION >= (20160603)
-        iTask.task = iscsi_write16_iov_task(iscsilun->iscsi, iscsilun->lun, lba,
+        iTask->task = iscsi_write16_iov_task(iscsilun->iscsi, iscsilun->lun, lba,
                                             NULL, num_sectors * iscsilun->block_size,
                                             iscsilun->block_size, 0, 0, fua, 0, 0,
-                                            iscsi_co_generic_cb, &iTask,
+                                            iscsi_co_generic_cb, iTask,
                                             (struct scsi_iovec *)iov->iov, iov->niov);
     } else {
-        iTask.task = iscsi_write10_iov_task(iscsilun->iscsi, iscsilun->lun, lba,
+        iTask->task = iscsi_write10_iov_task(iscsilun->iscsi, iscsilun->lun, lba,
                                             NULL, num_sectors * iscsilun->block_size,
                                             iscsilun->block_size, 0, 0, fua, 0, 0,
-                                            iscsi_co_generic_cb, &iTask,
+                                            iscsi_co_generic_cb, iTask,
                                             (struct scsi_iovec *)iov->iov, iov->niov);
     }
 #else
@@ -653,41 +814,62 @@ retry:
                                         iscsi_co_generic_cb, &iTask);
     }
 #endif
-    if (iTask.task == NULL) {
+    if (iTask->task == NULL) {
         qemu_mutex_unlock(&iscsilun->mutex);
+        g_free(iTask);
         return -ENOMEM;
     }
 #if LIBISCSI_API_VERSION < (20160603)
     scsi_task_set_iov_out(iTask.task, (struct scsi_iovec *) iov->iov,
                           iov->niov);
 #endif
-    iscsi_co_wait_for_task(&iTask, iscsilun);
+    iscsi_set_events(iscsilun);
+    if (!iTask->on_list) {
+        QTAILQ_INSERT_TAIL(&iscsilun->inflight, iTask, entry);
+        iTask->on_list = true;
+    }
+    iscsi_arm_deadline(iTask);
+    iscsi_co_wait_for_task(iTask, iscsilun);
 
-    if (iTask.task != NULL) {
-        scsi_free_scsi_task(iTask.task);
-        iTask.task = NULL;
+    if (!iTask->hard_timed_out && iTask->task != NULL) {
+        scsi_free_scsi_task(iTask->task);
+        iTask->task = NULL;
     }
 
-    if (iTask.do_retry) {
-        iTask.complete = 0;
+    if (iTask->do_retry) {
+        iTask->complete = 0;
         goto retry;
     }
 
-    if (iTask.status != SCSI_STATUS_GOOD) {
+    if (iTask->hard_timed_out) {
+        r = iTask->err_code ? iTask->err_code : -ETIMEDOUT;
+        iTask->co = NULL;
+        if (iTask->on_list) {
+            QTAILQ_REMOVE(&iscsilun->inflight, iTask, entry);
+            iTask->on_list = false;
+        }
+        qemu_mutex_unlock(&iscsilun->mutex);
+        return r;
+    }
+
+    if (iTask->status != SCSI_STATUS_GOOD) {
         iscsi_allocmap_set_invalid(iscsilun, sector_num * BDRV_SECTOR_SIZE,
                                    nb_sectors * BDRV_SECTOR_SIZE);
         error_report("iSCSI WRITE10/16 failed at lba %" PRIu64 ": %s", lba,
-                     iTask.err_str);
-        r = iTask.err_code;
-        goto out_unlock;
+                     iTask->err_str);
+        r = iTask->err_code;
+    } else {
+        iscsi_allocmap_set_allocated(iscsilun, sector_num * BDRV_SECTOR_SIZE,
+                                     nb_sectors * BDRV_SECTOR_SIZE);
     }
 
-    iscsi_allocmap_set_allocated(iscsilun, sector_num * BDRV_SECTOR_SIZE,
-                                 nb_sectors * BDRV_SECTOR_SIZE);
-
-out_unlock:
+    if (iTask->on_list) {
+        QTAILQ_REMOVE(&iscsilun->inflight, iTask, entry);
+        iTask->on_list = false;
+    }
     qemu_mutex_unlock(&iscsilun->mutex);
-    g_free(iTask.err_str);
+    g_free(iTask->err_str);
+    g_free(iTask);
     return r;
 }
 
@@ -733,6 +915,8 @@ retry:
         ret = -ENOMEM;
         goto out_unlock;
     }
+    iscsi_arm_deadline(&iTask);
+    iscsi_set_events(iscsilun);
     iscsi_co_wait_for_task(&iTask, iscsilun);
 
     if (iTask.do_retry) {
@@ -801,7 +985,7 @@ static int coroutine_fn iscsi_co_readv(BlockDriverState *bs,
                                        QEMUIOVector *iov)
 {
     IscsiLun *iscsilun = bs->opaque;
-    struct IscsiTask iTask;
+    IscsiTask *iTask;
     uint64_t lba;
     uint32_t num_sectors;
     int r = 0;
@@ -856,22 +1040,28 @@ static int coroutine_fn iscsi_co_readv(BlockDriverState *bs,
     lba = sector_qemu2lun(sector_num, iscsilun);
     num_sectors = sector_qemu2lun(nb_sectors, iscsilun);
 
-    iscsi_co_init_iscsitask(iscsilun, &iTask);
+    iTask = iscsi_task_new(iscsilun);
     qemu_mutex_lock(&iscsilun->mutex);
+    if (iscsilun->fail_fast && !iscsi_is_logged_in(iscsilun->iscsi)) {
+        qemu_mutex_unlock(&iscsilun->mutex);
+        g_free(iTask->err_str);
+        g_free(iTask);
+        return -ENOTCONN;
+    }
 retry:
     if (iscsilun->use_16_for_rw) {
 #if LIBISCSI_API_VERSION >= (20160603)
-        iTask.task = iscsi_read16_iov_task(iscsilun->iscsi, iscsilun->lun, lba,
+        iTask->task = iscsi_read16_iov_task(iscsilun->iscsi, iscsilun->lun, lba,
                                            num_sectors * iscsilun->block_size,
                                            iscsilun->block_size, 0, 0, 0, 0, 0,
-                                           iscsi_co_generic_cb, &iTask,
+                                           iscsi_co_generic_cb, iTask,
                                            (struct scsi_iovec *)iov->iov, iov->niov);
     } else {
-        iTask.task = iscsi_read10_iov_task(iscsilun->iscsi, iscsilun->lun, lba,
+        iTask->task = iscsi_read10_iov_task(iscsilun->iscsi, iscsilun->lun, lba,
                                            num_sectors * iscsilun->block_size,
                                            iscsilun->block_size,
                                            0, 0, 0, 0, 0,
-                                           iscsi_co_generic_cb, &iTask,
+                                           iscsi_co_generic_cb, iTask,
                                            (struct scsi_iovec *)iov->iov, iov->niov);
     }
 #else
@@ -887,70 +1077,119 @@ retry:
                                        iscsi_co_generic_cb, &iTask);
     }
 #endif
-    if (iTask.task == NULL) {
+    if (iTask->task == NULL) {
         qemu_mutex_unlock(&iscsilun->mutex);
+        g_free(iTask);
         return -ENOMEM;
     }
 #if LIBISCSI_API_VERSION < (20160603)
     scsi_task_set_iov_in(iTask.task, (struct scsi_iovec *) iov->iov, iov->niov);
 #endif
-
-    iscsi_co_wait_for_task(&iTask, iscsilun);
-    if (iTask.task != NULL) {
-        scsi_free_scsi_task(iTask.task);
-        iTask.task = NULL;
+    if (!iTask->on_list) {
+        QTAILQ_INSERT_TAIL(&iscsilun->inflight, iTask, entry);
+        iTask->on_list = true;
+    }
+    iscsi_arm_deadline(iTask);
+    iscsi_co_wait_for_task(iTask, iscsilun);
+    if (!iTask->hard_timed_out && iTask->task != NULL) {
+        scsi_free_scsi_task(iTask->task);
+        iTask->task = NULL;
     }
 
-    if (iTask.do_retry) {
-        iTask.complete = 0;
+    if (iTask->do_retry) {
+        iTask->complete = 0;
         goto retry;
     }
 
-    if (iTask.status != SCSI_STATUS_GOOD) {
+    if (iTask->hard_timed_out) {
+        r = iTask->err_code ? iTask->err_code : -ETIMEDOUT;
+        iTask->co = NULL;
+        if (iTask->on_list) {
+            QTAILQ_REMOVE(&iscsilun->inflight, iTask, entry);
+            iTask->on_list = false;
+        }
+        qemu_mutex_unlock(&iscsilun->mutex);
+        return r;
+    }
+
+    if (iTask->status != SCSI_STATUS_GOOD) {
         error_report("iSCSI READ10/16 failed at lba %" PRIu64 ": %s",
-                     lba, iTask.err_str);
-        r = iTask.err_code;
+                     lba, iTask->err_str);
+        r = iTask->err_code;
     }
 
+    if (iTask->on_list) {
+        QTAILQ_REMOVE(&iscsilun->inflight, iTask, entry);
+        iTask->on_list = false;
+    }
     qemu_mutex_unlock(&iscsilun->mutex);
-    g_free(iTask.err_str);
+    g_free(iTask->err_str);
+    g_free(iTask);
     return r;
 }
 
 static int coroutine_fn iscsi_co_flush(BlockDriverState *bs)
 {
     IscsiLun *iscsilun = bs->opaque;
-    struct IscsiTask iTask;
+    IscsiTask *iTask;
     int r = 0;
 
-    iscsi_co_init_iscsitask(iscsilun, &iTask);
+    iTask = iscsi_task_new(iscsilun);
     qemu_mutex_lock(&iscsilun->mutex);
+    if (iscsilun->fail_fast && !iscsi_is_logged_in(iscsilun->iscsi)) {
+        qemu_mutex_unlock(&iscsilun->mutex);
+        g_free(iTask->err_str);
+        g_free(iTask);
+        return -ENOTCONN;
+    }
 retry:
     if (iscsi_synchronizecache10_task(iscsilun->iscsi, iscsilun->lun, 0, 0, 0,
-                                      0, iscsi_co_generic_cb, &iTask) == NULL) {
+                                      0, iscsi_co_generic_cb, iTask) == NULL) {
         qemu_mutex_unlock(&iscsilun->mutex);
+        g_free(iTask);
         return -ENOMEM;
     }
+    iscsi_set_events(iscsilun);
+    if (!iTask->on_list) {
+        QTAILQ_INSERT_TAIL(&iscsilun->inflight, iTask, entry);
+        iTask->on_list = true;
+    }
+    iscsi_arm_deadline(iTask);
+    iscsi_co_wait_for_task(iTask, iscsilun);
 
-    iscsi_co_wait_for_task(&iTask, iscsilun);
-
-    if (iTask.task != NULL) {
-        scsi_free_scsi_task(iTask.task);
-        iTask.task = NULL;
+    if (!iTask->hard_timed_out && iTask->task != NULL) {
+        scsi_free_scsi_task(iTask->task);
+        iTask->task = NULL;
     }
 
-    if (iTask.do_retry) {
-        iTask.complete = 0;
+    if (iTask->do_retry) {
+        iTask->complete = 0;
         goto retry;
     }
 
-    if (iTask.status != SCSI_STATUS_GOOD) {
-        error_report("iSCSI SYNCHRONIZECACHE10 failed: %s", iTask.err_str);
-        r = iTask.err_code;
+    if (iTask->hard_timed_out) {
+        r = iTask->err_code ? iTask->err_code : -ETIMEDOUT;
+        iTask->co = NULL; /* detach */
+        if (iTask->on_list) {
+            QTAILQ_REMOVE(&iscsilun->inflight, iTask, entry);
+            iTask->on_list = false;
+        }
+        qemu_mutex_unlock(&iscsilun->mutex);
+        return r;
     }
 
+    if (iTask->status != SCSI_STATUS_GOOD) {
+        error_report("iSCSI SYNCHRONIZECACHE10 failed: %s", iTask->err_str);
+        r = iTask->err_code;
+    }
+
+    if (iTask->on_list) {
+        QTAILQ_REMOVE(&iscsilun->inflight, iTask, entry);
+        iTask->on_list = false;
+    }
     qemu_mutex_unlock(&iscsilun->mutex);
-    g_free(iTask.err_str);
+    g_free(iTask->err_str);
+    g_free(iTask);
     return r;
 }
 
@@ -1086,6 +1325,12 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
 
     data.size = 0;
     qemu_mutex_lock(&iscsilun->mutex);
+    if (iscsilun->fail_fast && !iscsi_is_logged_in(iscsilun->iscsi)) {
+        qemu_mutex_unlock(&iscsilun->mutex);
+        acb->status = -ENOTCONN;
+        iscsi_schedule_bh(acb);
+        return &acb->common;
+    }
     if (acb->task->xfer_dir == SCSI_XFER_WRITE) {
         if (acb->ioh->iovec_count == 0) {
             data.data = acb->ioh->dxferp;
@@ -1176,6 +1421,7 @@ retry:
         goto out_unlock;
     }
 
+    iscsi_set_events(iscsilun);
     iscsi_co_wait_for_task(&iTask, iscsilun);
 
     if (iTask.task != NULL) {
@@ -1282,6 +1528,7 @@ retry:
         return -ENOMEM;
     }
 
+    iscsi_set_events(iscsilun);
     iscsi_co_wait_for_task(&iTask, iscsilun);
 
     if (iTask.status == SCSI_STATUS_CHECK_CONDITION &&
@@ -1415,14 +1662,24 @@ static void iscsi_nop_timed_event(void *opaque)
     IscsiLun *iscsilun = opaque;
 
     QEMU_LOCK_GUARD(&iscsilun->mutex);
+    /* If we are not logged in, use the nop timer as an additional reconnect driver. */
+    if (!iscsi_is_logged_in(iscsilun->iscsi)) {
+        iscsilun->request_timed_out = true;
+        iscsi_maybe_reconnect(iscsilun);
+        goto rearm;
+    }
     if (iscsi_get_nops_in_flight(iscsilun->iscsi) >= MAX_NOP_FAILURES) {
         error_report("iSCSI: NOP timeout. Reconnecting...");
         iscsilun->request_timed_out = true;
     } else if (iscsi_nop_out_async(iscsilun->iscsi, NULL, NULL, 0, NULL) != 0) {
-        error_report("iSCSI: failed to sent NOP-Out. Disabling NOP messages.");
-        return;
+        /* Do NOT disable NOPs; treat as connection problem and try to reconnect. */
+        error_report("iSCSI: failed to send NOP-Out. Triggering reconnect.");
+        iscsilun->request_timed_out = true;
+        iscsi_maybe_reconnect(iscsilun);
+        /* keep NOPs enabled; next tick will try again */
     }
 
+rearm:
     timer_mod(iscsilun->nop_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + NOP_INTERVAL);
     iscsi_set_events(iscsilun);
 }
@@ -1559,6 +1816,8 @@ static void iscsi_attach_aio_context(BlockDriverState *bs,
     IscsiLun *iscsilun = bs->opaque;
 
     iscsilun->aio_context = new_context;
+    iscsilun->next_reconnect_ms = 0;
+    iscsilun->last_logged_in = iscsi_is_logged_in(iscsilun->iscsi);
     iscsi_set_events(iscsilun);
 
     /* Set up a timer for sending out iSCSI NOPs */
@@ -1894,6 +2153,9 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
         warn_report("iSCSI: ignoring timeout value for libiscsi <1.15.0");
     }
 #endif
+    /* FORCE-ON policy: 5s hard timeout */
+    iscsilun->io_hard_timeout_ms = 5000; /* 5 seconds */
+    iscsilun->fail_fast = true;
 
     if (iscsi_full_connect_sync(iscsi, portal, lun) != 0) {
         error_setg(errp, "iSCSI: Failed to connect to LUN : %s",
@@ -1905,6 +2167,8 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     iscsilun->iscsi = iscsi;
     iscsilun->aio_context = bdrv_get_aio_context(bs);
     iscsilun->lun = lun;
+    iscsilun->next_reconnect_ms = 0;
+    iscsilun->last_logged_in = false; /* updated after connect */
     iscsilun->has_write_same = true;
 
     task = iscsi_do_inquiry(iscsilun->iscsi, iscsilun->lun, 0, 0,
@@ -2007,6 +2271,8 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
 
     qemu_mutex_init(&iscsilun->mutex);
     iscsi_attach_aio_context(bs, iscsilun->aio_context);
+    iscsilun->last_logged_in = iscsi_is_logged_in(iscsilun->iscsi);
+    QTAILQ_INIT(&iscsilun->inflight);
 
     /* Guess the internal cluster (page) size of the iscsi target by the means
      * of opt_unmap_gran. Transfer the unmap granularity only if it has a
@@ -2387,6 +2653,7 @@ retry:
         goto out_unlock;
     }
 
+    iscsi_set_events(dst_lun);
     iscsi_co_wait_for_task(&iscsi_task, dst_lun);
 
     if (iscsi_task.do_retry) {
-- 
2.25.1


