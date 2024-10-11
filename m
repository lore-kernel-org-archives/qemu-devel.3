Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C4FD0EE12
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJIl-0001Sx-S1; Fri, 11 Oct 2024 13:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1szJ7f-0003Vx-Uj
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:08:17 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1szEWe-0004wa-TM
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 08:13:48 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20c714cd9c8so15625955ad.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 05:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1728648824; x=1729253624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D1H1tgefHez5i+plGQ3DfK7W7Zdn6pb/fC/rPvGnh+Q=;
 b=C7lvg8B5xKGBC+jcxbL6PRuC0PkcLe9/JuEy6wG4D2Yn3j8neYbY4e0bwKDJKyeJ2k
 PhdG09kEczIXhJ0GWwMO7nFdGIVSHQolLW8ibac+tSk54/+7Q997EfSm2NfS0CLRjHYv
 QdoIaA4aVZxbKy0+DuFvJumtC7jx7sBhiMZ1EQk2sHp0BREUDMwXv88tzeEZxB+A4Yte
 muqxlfM7xH2fm+Ij8sjWevhgIGVrxjBlIdsTeDuJCbfFOmr0dWAa8I/FhNamhneZV9VQ
 4VOZjiYYZHJN+Lh2542M4tJRvx/3AuFMTo+xr8CBFE4oqFaTebC1pdoYxZzc7wBF2h3h
 tu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728648824; x=1729253624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D1H1tgefHez5i+plGQ3DfK7W7Zdn6pb/fC/rPvGnh+Q=;
 b=qSg7/pCfek0jFTYkhS1bo7O+Haw2BJQ0lyICjBK3uxdlNl/iEISS3Ra7UK5L4bGn4X
 JzlBbOjKX0R4I/wMy6an/OzIJvn7obW6rq49OncHVcI0dR/1lby5SXqRO963xnfmU+2q
 ajGkeGY8Z/MV3GGe38DB4a0ghj12j2oyl2Vnfk0qeY0ZKxrpkhFm4TSo8Pj5Way65JBh
 I12bpaxHLeOyrn5i8+gjHKSwKuTGPa8+a/ROyLf/z+ichWXMWXZhSXyUEBi/s0/oMVl7
 W9gya+VbAv9YcJjBBmlRumN237eFtzKOUT3b6l+8i1nFljG+s23VhDqI/m9/7/uBbxrB
 Veig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsuSrKF03vQ6ivDjYgPL+NVR7lTl3ZnVBgY4QWq95tXST63hby1l10QjUtcmjGF0vfy4WkGtd7wE9k@nongnu.org
X-Gm-Message-State: AOJu0YyNvitkp8q+mqTM/GG+FsbvsOQfyCgSuKu0tkXWFiygFWO/TjnW
 PSX30oBJ4cfjqmvs7KCHyq++xrXf6HKbLJfygfMzx0CBX2o0kZo+v7Yx6RbuviU=
X-Google-Smtp-Source: AGHT+IFR5inEKX4TRZy+YSj2mZv3yxqfQ2JkfJSPaC7TEnmB7wejUhJ4KyYAOWtqsKBPLKIVH42y9Q==
X-Received: by 2002:a17:902:e751:b0:20c:a122:e6c4 with SMTP id
 d9443c01a7336-20ca142c079mr42153065ad.14.1728648823572; 
 Fri, 11 Oct 2024 05:13:43 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([139.177.225.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8bc13551sm22569305ad.88.2024.10.11.05.13.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 11 Oct 2024 05:13:43 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v14 10/10] block/iscsi: add persistent reservation in/out
 driver
Date: Fri, 11 Oct 2024 20:12:31 +0800
Message-Id: <20241011121231.18333-11-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20241011121231.18333-1-luchangqi.123@bytedance.com>
References: <20241011121231.18333-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add persistent reservation in/out operations for iscsi driver.
The following methods are implemented: bdrv_co_pr_read_keys,
bdrv_co_pr_read_reservation, bdrv_co_pr_register, bdrv_co_pr_reserve,
bdrv_co_pr_release, bdrv_co_pr_clear and bdrv_co_pr_preempt.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/iscsi.c | 428 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 428 insertions(+)

diff --git a/block/iscsi.c b/block/iscsi.c
index 2ff14b7472..245ee77e19 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -96,6 +96,7 @@ typedef struct IscsiLun {
     unsigned long *allocmap_valid;
     long allocmap_size;
     int cluster_size;
+    uint8_t pr_cap;
     bool use_16_for_rw;
     bool write_protected;
     bool lbpme;
@@ -280,6 +281,10 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
                     iTask->err_code = -error;
                     iTask->err_str = g_strdup(iscsi_get_error(iscsi));
                 }
+            } else if (status == SCSI_STATUS_RESERVATION_CONFLICT) {
+                iTask->err_code = -EBADE;
+                error_report("iSCSI Persistent Reservation Conflict: %s",
+                             iscsi_get_error(iscsi));
             }
         }
     }
@@ -1792,6 +1797,50 @@ static void iscsi_save_designator(IscsiLun *lun,
     }
 }
 
+/*
+ *  Ensure iscsi_open() must succeed, weather or not the target
+ *  implement SCSI_PR_IN_REPORT_CAPABILITIES.
+ */
+static void iscsi_get_pr_cap_sync(IscsiLun *iscsilun)
+{
+    struct scsi_task *task = NULL;
+    struct scsi_persistent_reserve_in_report_capabilities *rc = NULL;
+    int retries = ISCSI_CMD_RETRIES;
+    int xferlen = sizeof(struct scsi_persistent_reserve_in_report_capabilities);
+
+    do {
+        if (task != NULL) {
+            scsi_free_scsi_task(task);
+            task = NULL;
+        }
+
+        task = iscsi_persistent_reserve_in_sync(iscsilun->iscsi,
+               iscsilun->lun, SCSI_PR_IN_REPORT_CAPABILITIES, xferlen);
+        if (task != NULL && task->status == SCSI_STATUS_GOOD) {
+                rc = scsi_datain_unmarshall(task);
+                if (rc == NULL) {
+                    error_report("iSCSI: Failed to unmarshall "
+                                 "report capabilities data.");
+                } else {
+                    iscsilun->pr_cap =
+                    scsi_pr_cap_to_block(rc->persistent_reservation_type_mask);
+                    iscsilun->pr_cap |= (rc->ptpl_a) ? BLK_PR_CAP_PTPL : 0;
+                }
+                break;
+        }
+    } while (task != NULL && task->status == SCSI_STATUS_CHECK_CONDITION
+             && task->sense.key == SCSI_SENSE_UNIT_ATTENTION
+             && retries-- > 0);
+
+    if (task == NULL || task->status != SCSI_STATUS_GOOD) {
+        error_report("iSCSI: failed to send report capabilities command.");
+    }
+
+    if (task) {
+        scsi_free_scsi_task(task);
+    }
+}
+
 static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
                       Error **errp)
 {
@@ -2024,6 +2073,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
         bs->supported_zero_flags = BDRV_REQ_MAY_UNMAP;
     }
 
+    iscsi_get_pr_cap_sync(iscsilun);
 out:
     qemu_opts_del(opts);
     g_free(initiator_name);
@@ -2110,6 +2160,8 @@ static void iscsi_refresh_limits(BlockDriverState *bs, Error **errp)
         bs->bl.opt_transfer = pow2floor(iscsilun->bl.opt_xfer_len *
                                         iscsilun->block_size);
     }
+
+    bs->bl.pr_cap = iscsilun->pr_cap;
 }
 
 /* Note that this will not re-establish a connection with an iSCSI target - it
@@ -2408,6 +2460,374 @@ out_unlock:
     return r;
 }
 
+static int coroutine_fn
+iscsi_co_pr_read_keys(BlockDriverState *bs, uint32_t *generation,
+                      uint32_t num_keys, uint64_t *keys)
+{
+    IscsiLun *iscsilun = bs->opaque;
+    QEMUIOVector qiov;
+    struct IscsiTask iTask;
+    int xferlen = sizeof(struct scsi_persistent_reserve_in_read_keys) +
+                  sizeof(uint64_t) * num_keys;
+    g_autofree uint8_t *buf = g_malloc0(xferlen);
+    int32_t num_collect_keys = 0;
+    int r = 0;
+
+    qemu_iovec_init_buf(&qiov, buf, xferlen);
+    iscsi_co_init_iscsitask(iscsilun, &iTask);
+    qemu_mutex_lock(&iscsilun->mutex);
+retry:
+    iTask.task = iscsi_persistent_reserve_in_task(iscsilun->iscsi,
+                 iscsilun->lun, SCSI_PR_IN_READ_KEYS, xferlen,
+                 iscsi_co_generic_cb, &iTask);
+
+    if (iTask.task == NULL) {
+        qemu_mutex_unlock(&iscsilun->mutex);
+        return -ENOMEM;
+    }
+
+    scsi_task_set_iov_in(iTask.task, (struct scsi_iovec *)qiov.iov, qiov.niov);
+    iscsi_co_wait_for_task(&iTask, iscsilun);
+
+    if (iTask.task != NULL) {
+        scsi_free_scsi_task(iTask.task);
+        iTask.task = NULL;
+    }
+
+    if (iTask.do_retry) {
+        iTask.complete = 0;
+        goto retry;
+    }
+
+    if (iTask.status != SCSI_STATUS_GOOD) {
+        error_report("iSCSI PERSISTENT_RESERVE_IN failed: %s", iTask.err_str);
+        r = iTask.err_code;
+        goto out;
+    }
+
+    memcpy(generation, &buf[0], 4);
+    *generation = be32_to_cpu(*generation);
+    memcpy(&num_collect_keys, &buf[4], 4);
+    num_collect_keys = be32_to_cpu(num_collect_keys) / sizeof(uint64_t);
+    if (num_collect_keys > num_keys) {
+        r = -EINVAL;
+        goto out;
+    }
+
+    for (int i = 0; i < num_collect_keys; i++) {
+        memcpy(&keys[i], &buf[8 + i * 8], 8);
+        keys[i] = be64_to_cpu(keys[i]);
+    }
+    r = num_collect_keys;
+
+out:
+    qemu_mutex_unlock(&iscsilun->mutex);
+    g_free(iTask.err_str);
+    return r;
+}
+
+static int coroutine_fn
+iscsi_co_pr_read_reservation(BlockDriverState *bs, uint32_t *generation,
+                             uint64_t *key, BlockPrType *type)
+{
+    IscsiLun *iscsilun = bs->opaque;
+    QEMUIOVector qiov;
+    struct IscsiTask iTask;
+    int xferlen = sizeof(struct scsi_persistent_reserve_in_read_reservation);
+    g_autofree uint8_t *buf = g_malloc0(xferlen);
+    uint8_t scope_type = 0;
+    int32_t num_collect_keys = 0;
+    int r = 0;
+
+    qemu_iovec_init_buf(&qiov, buf, xferlen);
+    iscsi_co_init_iscsitask(iscsilun, &iTask);
+    qemu_mutex_lock(&iscsilun->mutex);
+retry:
+    iTask.task = iscsi_persistent_reserve_in_task(iscsilun->iscsi,
+                 iscsilun->lun, SCSI_PR_IN_READ_RESERVATION,
+                 xferlen, iscsi_co_generic_cb, &iTask);
+
+    if (iTask.task == NULL) {
+        qemu_mutex_unlock(&iscsilun->mutex);
+        return -ENOMEM;
+    }
+
+    scsi_task_set_iov_in(iTask.task, (struct scsi_iovec *)qiov.iov, qiov.niov);
+    iscsi_co_wait_for_task(&iTask, iscsilun);
+
+    if (iTask.task != NULL) {
+        scsi_free_scsi_task(iTask.task);
+        iTask.task = NULL;
+    }
+
+    if (iTask.do_retry) {
+        iTask.complete = 0;
+        goto retry;
+    }
+
+    if (iTask.status != SCSI_STATUS_GOOD) {
+        error_report("iSCSI PERSISTENT_RESERVE_IN failed: %s", iTask.err_str);
+        r = iTask.err_code;
+        goto out;
+    }
+
+    memcpy(generation, &buf[0], 4);
+    *generation = be32_to_cpu(*generation);
+    memcpy(key, &buf[8], 8);
+    *key = be64_to_cpu(*key);
+    memcpy(&scope_type, &buf[21], 1);
+    *type = scsi_pr_type_to_block(scope_type & 0xf);
+    memcpy(&num_collect_keys, &buf[4], 4);
+    r = be32_to_cpu(num_collect_keys) / sizeof(uint64_t);
+out:
+    qemu_mutex_unlock(&iscsilun->mutex);
+    g_free(iTask.err_str);
+    return r;
+}
+
+static int coroutine_fn
+iscsi_co_pr_register(BlockDriverState *bs, uint64_t old_key,
+                     uint64_t new_key, BlockPrType type,
+                     bool ptpl, bool ignore_key)
+{
+    IscsiLun *iscsilun = bs->opaque;
+    struct IscsiTask iTask;
+    struct scsi_persistent_reserve_out_basic basic;
+    SCSIPrOutAction action = ignore_key ? SCSI_PR_OUT_REG_AND_IGNORE_KEY :
+                                          SCSI_PR_OUT_REGISTER;
+    int r = 0;
+
+    memset(&basic, 0, sizeof(basic));
+    basic.reservation_key = old_key;
+    basic.service_action_reservation_key = new_key;
+    basic.aptpl = ptpl ? 1 : 0;
+
+    iscsi_co_init_iscsitask(iscsilun, &iTask);
+    qemu_mutex_lock(&iscsilun->mutex);
+retry:
+    iTask.task = iscsi_persistent_reserve_out_task(iscsilun->iscsi,
+                 iscsilun->lun, action, 0, block_pr_type_to_scsi(type),
+                 &basic, iscsi_co_generic_cb, &iTask);
+
+    if (iTask.task == NULL) {
+        qemu_mutex_unlock(&iscsilun->mutex);
+        return -ENOMEM;
+    }
+
+    iscsi_co_wait_for_task(&iTask, iscsilun);
+
+    if (iTask.task != NULL) {
+        scsi_free_scsi_task(iTask.task);
+        iTask.task = NULL;
+    }
+
+    if (iTask.do_retry) {
+        iTask.complete = 0;
+        goto retry;
+    }
+
+    if (iTask.status != SCSI_STATUS_GOOD) {
+        error_report("iSCSI PERSISTENT_RESERVE_OUT failed: %s", iTask.err_str);
+        r = iTask.err_code;
+    }
+
+    qemu_mutex_unlock(&iscsilun->mutex);
+
+    g_free(iTask.err_str);
+    return r;
+}
+
+static int coroutine_fn
+iscsi_co_pr_reserve(BlockDriverState *bs, uint64_t key, BlockPrType type)
+{
+    IscsiLun *iscsilun = bs->opaque;
+    struct IscsiTask iTask;
+    struct scsi_persistent_reserve_out_basic basic;
+    int r = 0;
+
+    memset(&basic, 0, sizeof(basic));
+    basic.reservation_key = key;
+    iscsi_co_init_iscsitask(iscsilun, &iTask);
+    qemu_mutex_lock(&iscsilun->mutex);
+retry:
+    iTask.task = iscsi_persistent_reserve_out_task(iscsilun->iscsi,
+                 iscsilun->lun, SCSI_PR_OUT_RESERVE, 0,
+                 block_pr_type_to_scsi(type), &basic,
+                 iscsi_co_generic_cb, &iTask);
+
+    if (iTask.task == NULL) {
+        qemu_mutex_unlock(&iscsilun->mutex);
+        return -ENOMEM;
+    }
+
+
+    iscsi_co_wait_for_task(&iTask, iscsilun);
+
+    if (iTask.task != NULL) {
+        scsi_free_scsi_task(iTask.task);
+        iTask.task = NULL;
+    }
+
+    if (iTask.do_retry) {
+        iTask.complete = 0;
+        goto retry;
+    }
+
+    if (iTask.status != SCSI_STATUS_GOOD) {
+        error_report("iSCSI PERSISTENT_RESERVE_OUT failed: %s", iTask.err_str);
+        r = iTask.err_code;
+    }
+
+    qemu_mutex_unlock(&iscsilun->mutex);
+
+    g_free(iTask.err_str);
+    return r;
+}
+
+static int coroutine_fn
+iscsi_co_pr_release(BlockDriverState *bs, uint64_t key, BlockPrType type)
+{
+    IscsiLun *iscsilun = bs->opaque;
+    struct IscsiTask iTask;
+    struct scsi_persistent_reserve_out_basic basic;
+    int r = 0;
+
+    memset(&basic, 0, sizeof(basic));
+    basic.reservation_key = key;
+    iscsi_co_init_iscsitask(iscsilun, &iTask);
+    qemu_mutex_lock(&iscsilun->mutex);
+retry:
+    iTask.task = iscsi_persistent_reserve_out_task(iscsilun->iscsi,
+                 iscsilun->lun, SCSI_PR_OUT_RELEASE, 0,
+                 block_pr_type_to_scsi(type), &basic,
+                 iscsi_co_generic_cb, &iTask);
+
+    if (iTask.task == NULL) {
+        qemu_mutex_unlock(&iscsilun->mutex);
+        return -ENOMEM;
+    }
+
+
+    iscsi_co_wait_for_task(&iTask, iscsilun);
+
+    if (iTask.task != NULL) {
+        scsi_free_scsi_task(iTask.task);
+        iTask.task = NULL;
+    }
+
+    if (iTask.do_retry) {
+        iTask.complete = 0;
+        goto retry;
+    }
+
+    if (iTask.status != SCSI_STATUS_GOOD) {
+        error_report("iSCSI PERSISTENT_RESERVE_OUT failed: %s", iTask.err_str);
+        r = iTask.err_code;
+    }
+
+    qemu_mutex_unlock(&iscsilun->mutex);
+
+    g_free(iTask.err_str);
+    return r;
+}
+
+static int coroutine_fn
+iscsi_co_pr_clear(BlockDriverState *bs, uint64_t key)
+{
+    IscsiLun *iscsilun = bs->opaque;
+    struct IscsiTask iTask;
+    struct scsi_persistent_reserve_out_basic basic;
+    int r = 0;
+
+    memset(&basic, 0, sizeof(basic));
+    basic.reservation_key = key;
+    iscsi_co_init_iscsitask(iscsilun, &iTask);
+    qemu_mutex_lock(&iscsilun->mutex);
+retry:
+    iTask.task = iscsi_persistent_reserve_out_task(iscsilun->iscsi,
+                 iscsilun->lun, SCSI_PR_OUT_CLEAR, 0, 0, &basic,
+                 iscsi_co_generic_cb, &iTask);
+
+    if (iTask.task == NULL) {
+        qemu_mutex_unlock(&iscsilun->mutex);
+        return -ENOMEM;
+    }
+
+
+    iscsi_co_wait_for_task(&iTask, iscsilun);
+
+    if (iTask.task != NULL) {
+        scsi_free_scsi_task(iTask.task);
+        iTask.task = NULL;
+    }
+
+    if (iTask.do_retry) {
+        iTask.complete = 0;
+        goto retry;
+    }
+
+    if (iTask.status != SCSI_STATUS_GOOD) {
+        error_report("iSCSI PERSISTENT_RESERVE_OUT failed: %s", iTask.err_str);
+        r = iTask.err_code;
+    }
+
+    qemu_mutex_unlock(&iscsilun->mutex);
+
+    g_free(iTask.err_str);
+    return r;
+}
+
+static int coroutine_fn
+iscsi_co_pr_preempt(BlockDriverState *bs, uint64_t old_key,
+                    uint64_t new_key, BlockPrType type, bool abort)
+{
+    IscsiLun *iscsilun = bs->opaque;
+    struct IscsiTask iTask;
+    struct scsi_persistent_reserve_out_basic basic;
+    SCSIPrOutAction action = abort ? SCSI_PR_OUT_PREEMPT_AND_ABORT :
+                                     SCSI_PR_OUT_PREEMPT;
+    int r = 0;
+
+    memset(&basic, 0, sizeof(basic));
+    basic.reservation_key = old_key;
+    basic.service_action_reservation_key = new_key;
+
+    iscsi_co_init_iscsitask(iscsilun, &iTask);
+    qemu_mutex_lock(&iscsilun->mutex);
+retry:
+    iTask.task = iscsi_persistent_reserve_out_task(iscsilun->iscsi,
+                 iscsilun->lun, action, 0, block_pr_type_to_scsi(type),
+                 &basic, iscsi_co_generic_cb, &iTask);
+
+    if (iTask.task == NULL) {
+        qemu_mutex_unlock(&iscsilun->mutex);
+        return -ENOMEM;
+    }
+
+
+    iscsi_co_wait_for_task(&iTask, iscsilun);
+
+    if (iTask.task != NULL) {
+        scsi_free_scsi_task(iTask.task);
+        iTask.task = NULL;
+    }
+
+    if (iTask.do_retry) {
+        iTask.complete = 0;
+        goto retry;
+    }
+
+    if (iTask.status != SCSI_STATUS_GOOD) {
+        error_report("iSCSI PERSISTENT_RESERVE_OUT failed: %s", iTask.err_str);
+        r = iTask.err_code;
+    }
+
+    qemu_mutex_unlock(&iscsilun->mutex);
+
+    g_free(iTask.err_str);
+    return r;
+}
+
 
 static const char *const iscsi_strong_runtime_opts[] = {
     "transport",
@@ -2451,6 +2871,14 @@ static BlockDriver bdrv_iscsi = {
     .bdrv_co_writev        = iscsi_co_writev,
     .bdrv_co_flush_to_disk = iscsi_co_flush,
 
+    .bdrv_co_pr_read_keys     = iscsi_co_pr_read_keys,
+    .bdrv_co_pr_read_reservation = iscsi_co_pr_read_reservation,
+    .bdrv_co_pr_register      = iscsi_co_pr_register,
+    .bdrv_co_pr_reserve       = iscsi_co_pr_reserve,
+    .bdrv_co_pr_release       = iscsi_co_pr_release,
+    .bdrv_co_pr_clear         = iscsi_co_pr_clear,
+    .bdrv_co_pr_preempt       = iscsi_co_pr_preempt,
+
 #ifdef __linux__
     .bdrv_aio_ioctl   = iscsi_aio_ioctl,
 #endif
-- 
2.20.1


