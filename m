Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23A0D5B16E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 14:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV9Mx-0003uh-CY; Mon, 15 Dec 2025 09:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vV9Mo-0003tE-Qf
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 09:16:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vV9Mm-0003vP-CH
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 09:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765808153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jhTQFXNzdZP6yGM8QJGBmevfgBmqJeKpuyrRgjNwE6c=;
 b=T/m+Inb7/d3fbAFNtNnZJgZWnyekT/VbAE4VwhK80rfrx7ZEhWSgN0T/Twartr40SXJWQz
 +LGB0t34Ufpm5fwm9e/oViQGzvpG7Q9Z0pgUiVwd5DJoX6WwBZY8ggJiIOQeF8uZeVrKfF
 H6bSRvWZ62NoQBzao/fWJZ1anGoW0ew=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-QmhrHRXZMaiZr-LHIc1dRw-1; Mon, 15 Dec 2025 09:15:51 -0500
X-MC-Unique: QmhrHRXZMaiZr-LHIc1dRw-1
X-Mimecast-MFC-AGG-ID: QmhrHRXZMaiZr-LHIc1dRw_1765808150
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430fe16b481so450818f8f.3
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 06:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765808150; x=1766412950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jhTQFXNzdZP6yGM8QJGBmevfgBmqJeKpuyrRgjNwE6c=;
 b=LEZ/7NcYakh8hkL+Ft76c9ePpBO3lGd6nGCgAopgGeWTBqnxW1OyEH4NPQ8aAPwype
 RD6FB3rC2SrWnoVAj7TDMD7jCzSRmkP0X+JyVeOIrHf4Mr2fs5lVZZh4JNVvKst91g04
 XTShyeifAPHLilmMiUlo7VIHlG2WYwxBBHgimko1CP2bu9+p2CrZZnVAzgdeA9AolTu1
 dPkanSCA6ZB9NB/bmDAxSOk1H8RZaT4YFdoo745CYwHkBZFohRI/AkCtoGK0vOaNV/c0
 E4jtnGD/2ez+0Ck/CufHig/vO9cNp5ZhyZ6lqHVI7RC0z4J6564wOgWRVdhr4Bld1lnS
 ZtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765808150; x=1766412950;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jhTQFXNzdZP6yGM8QJGBmevfgBmqJeKpuyrRgjNwE6c=;
 b=vKGM/nsR035uNiI4RaATKQYUBbfGmSRtAufiy1aoivrd13/vPj/BjTm7raMCsDK532
 58MkanFJ74QCuQy/KX82x6wvT/IXIpN6bk815EKrWaMvBjv/xT6TnENWkPuU4Mf4kzic
 822fyHfGs/ILTA2tByNm1LO8s6fl+yG3IpttdMvI1HGeoeS40bVw9viFDJrlG4FnyqLk
 XPw5Fi3HFohcczcADsuCyMWH3G2zj/rygtQKj0DxizRs+Z7j7NEZJdf/Qjl9VrCkrS5A
 imHdoboo/OnpCkkdOvLGqTiQ9nV3q+AlhJU4qviUAMQ01Rh7eEJQYawDZKBGG96A7etm
 ji+g==
X-Gm-Message-State: AOJu0YxoP75XHWlR58FoJjyqOCL35aC82Lw/zmECLiJNuAXVJwVhn5Yx
 ltKygkrBoTBWgp/cxSoTrOzopO3gMzAdsjYcMwEqWT7qYL/dVJItXWI4kUTgbDPPTrUJDDxyR7I
 4qm7R3+/XulX3G1pQ61VS6bNk4nkqVNvI7w+EPs9L4Kj4NnqWoBHEWqry
X-Gm-Gg: AY/fxX66TWJbw8UmhqLfdjM0tEkWng1AW2xy79sKnfhzJChl6a34HI59TUySswdP+JQ
 ltXYqBndKfxzPPoaTuuNJByvq8KNzyFHk1AW3zg+GQxc1rmj8TzREngoWr87sn7xokxzs0tuiSc
 XirT8IVAQFbY1VKghCcRIy39ySVTMMomYctyXZN3X9OelOwndO8MEVrNt4PlXCZDnL2hLQ25yzH
 110d6Ok8fXbkCB//iLCCThwjL8jyII5QAF+c/6baqg+c7lzLtS0NSFsgGPIX0GyPOIPXop2O3LZ
 mNAQLksZMeCqeDFPMvU7PU7GMxRg8eXxunQMjvmJgvbIsxNmm02JmmDxSkcpIrpkqF//FqNRvOL
 n5EC86cR5DZnqkdiSrUrqK5fGk079MKNun1S/tHgQVkGPTHtSQaUuBZGJeL4f1OLY2bax
X-Received: by 2002:a05:6000:26d0:b0:430:f742:fbb5 with SMTP id
 ffacd0b85a97d-430f742fd4fmr6213408f8f.22.1765808150259; 
 Mon, 15 Dec 2025 06:15:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZErRTn2sVhmSAcZlC+9ShyH6KCEaUyC/1X6Pe2IuCAgNfwafS3Yo0UtSa7TxbG/fZo+pHSw==
X-Received: by 2002:a05:6000:26d0:b0:430:f742:fbb5 with SMTP id
 ffacd0b85a97d-430f742fd4fmr6213354f8f.22.1765808149703; 
 Mon, 15 Dec 2025 06:15:49 -0800 (PST)
Received: from localhost
 (p200300cfd7171f2176157dc4a8a42b71.dip0.t-ipconnect.de.
 [2003:cf:d717:1f21:7615:7dc4:a8a4:2b71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-430f8290590sm10596608f8f.28.2025.12.15.06.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 06:15:48 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 for-10.2] Revert "nvme: Fix coroutine waking"
Date: Mon, 15 Dec 2025 15:15:40 +0100
Message-ID: <20251215141540.88915-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This reverts commit 0f142cbd919fcb6cea7aa176f7e4939925806dd9.

Said commit changed the replay_bh_schedule_oneshot_event() in
nvme_rw_cb() to aio_co_wake(), allowing the request coroutine to be
entered directly (instead of only being scheduled for later execution).
This can cause the device to become stalled like so:

It is possible that after completion the request coroutine goes on to
submit another request without yielding, e.g. a flush after a write to
emulate FUA.  This will likely cause a nested nvme_process_completion()
call because nvme_rw_cb() itself is called from there.

(After submitting a request, we invoke nvme_process_completion() through
defer_call(); but the fact that nvme_process_completion() ran in the
first place indicates that we are not in a call-deferring section, so
defer_call() will call nvme_process_completion() immediately.)

If this inner nvme_process_completion() loop then processes any
completions, it will write the final completion queue (CQ) head index to
the CQ head doorbell, and subsequently execution will return to the
outer nvme_process_completion() loop.  Even if this loop now finds no
further completions, it still processed at least one completion before,
or it would not have called the nvme_rw_cb() which led to nesting.
Therefore, it will now write the exact same CQ head index value to the
doorbell, which effectively is an unrecoverable error[1].

Therefore, nesting of nvme_process_completion() does not work at this
point.  Reverting said commit removes the nesting (by scheduling the
request coroutine instead of entering it immediately), and so fixes the
stall.

On the downside, reverting said commit breaks multiqueue for nvme, but
better to have single-queue working than neither.  For 11.0, we will
have a solution that makes both work.

A side note: There is a comment in nvme_process_completion() above
qemu_bh_schedule() that claims nesting works, as long as it is done
through the completion_bh.  I am quite sure that is not true, for two
reasons:
- The problem described above, which is even worse when going through
  nvme_process_completion_bh() because that function unconditionally
  writes to the CQ head doorbell,
- nvme_process_completion_bh() never takes q->lock, so
  nvme_process_completion() unlocking it will likely abort.

Given the lack of reports of such aborts, I believe that completion_bh
simply is unused in practice.

[1] See the NVMe Base Specification revision 2.3, page 180, figure 152:
    “Invalid Doorbell Write Value: A host attempted to write an invalid
    doorbell value. Some possible causes of this error are: [...] the
    value written is the same as the previously written doorbell value.”

    To even be notified of this error, we would need to send an
    Asynchronous Event Request to the admin queue (p. 178ff), which we
    don’t do, and then to handle it, we would need to delete and
    recreate the queue (p. 88, section 3.3.1.2 Queue Usage).

Cc: qemu-stable@nongnu.org
Reported-by: Lukáš Doktor <ldoktor@redhat.com>
Tested-by: Lukáš Doktor <ldoktor@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/nvme.c | 56 +++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 919e14cef9..c3d3b99d1f 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1200,36 +1200,26 @@ fail:
 
 typedef struct {
     Coroutine *co;
-    bool skip_yield;
     int ret;
+    AioContext *ctx;
 } NVMeCoData;
 
+static void nvme_rw_cb_bh(void *opaque)
+{
+    NVMeCoData *data = opaque;
+    qemu_coroutine_enter(data->co);
+}
+
 /* Put into NVMeRequest.cb, so runs in the BDS's main AioContext */
 static void nvme_rw_cb(void *opaque, int ret)
 {
     NVMeCoData *data = opaque;
-
     data->ret = ret;
-
-    if (data->co == qemu_coroutine_self()) {
-        /*
-         * Fast path: We are inside of the request coroutine (through
-         * nvme_submit_command, nvme_deferred_fn, nvme_process_completion).
-         * We can set data->skip_yield here to keep the coroutine from
-         * yielding, and then we don't need to schedule a BH to wake it.
-         */
-        data->skip_yield = true;
-    } else {
-        /*
-         * Safe to call: The case where we run in the request coroutine is
-         * handled above, so we must be independent of it; and without
-         * skip_yield set, the coroutine will yield.
-         * No need to release NVMeQueuePair.lock (we are called without it
-         * held).  (Note: If we enter the coroutine here, @data will
-         * probably be dangling once aio_co_wake() returns.)
-         */
-        aio_co_wake(data->co);
+    if (!data->co) {
+        /* The rw coroutine hasn't yielded, don't try to enter. */
+        return;
     }
+    replay_bh_schedule_oneshot_event(data->ctx, nvme_rw_cb_bh, data);
 }
 
 static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
@@ -1253,7 +1243,7 @@ static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
         .cdw12 = cpu_to_le32(cdw12),
     };
     NVMeCoData data = {
-        .co = qemu_coroutine_self(),
+        .ctx = bdrv_get_aio_context(bs),
         .ret = -EINPROGRESS,
     };
 
@@ -1270,7 +1260,9 @@ static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
         return r;
     }
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-    if (!data.skip_yield) {
+
+    data.co = qemu_coroutine_self();
+    while (data.ret == -EINPROGRESS) {
         qemu_coroutine_yield();
     }
 
@@ -1366,7 +1358,7 @@ static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
         .nsid = cpu_to_le32(s->nsid),
     };
     NVMeCoData data = {
-        .co = qemu_coroutine_self(),
+        .ctx = bdrv_get_aio_context(bs),
         .ret = -EINPROGRESS,
     };
 
@@ -1374,7 +1366,9 @@ static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
     req = nvme_get_free_req(ioq);
     assert(req);
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-    if (!data.skip_yield) {
+
+    data.co = qemu_coroutine_self();
+    if (data.ret == -EINPROGRESS) {
         qemu_coroutine_yield();
     }
 
@@ -1415,7 +1409,7 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
     };
 
     NVMeCoData data = {
-        .co = qemu_coroutine_self(),
+        .ctx = bdrv_get_aio_context(bs),
         .ret = -EINPROGRESS,
     };
 
@@ -1435,7 +1429,9 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
     assert(req);
 
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-    if (!data.skip_yield) {
+
+    data.co = qemu_coroutine_self();
+    while (data.ret == -EINPROGRESS) {
         qemu_coroutine_yield();
     }
 
@@ -1463,7 +1459,7 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
     };
 
     NVMeCoData data = {
-        .co = qemu_coroutine_self(),
+        .ctx = bdrv_get_aio_context(bs),
         .ret = -EINPROGRESS,
     };
 
@@ -1508,7 +1504,9 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
     trace_nvme_dsm(s, offset, bytes);
 
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-    if (!data.skip_yield) {
+
+    data.co = qemu_coroutine_self();
+    while (data.ret == -EINPROGRESS) {
         qemu_coroutine_yield();
     }
 
-- 
2.52.0


