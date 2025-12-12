Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94B6D44166
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 10:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU0LB-0003bS-U9; Fri, 12 Dec 2025 05:25:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vU0LA-0003b5-93
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 05:25:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vU0L8-0001JE-Ju
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 05:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765535132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xcU2D0Os4dN+GWBznUP/OXsjC9V0WYkZ+Cden057DQk=;
 b=GYeJMqY5bMy7W9E8ABsjFw/wRs40k0/bJPqokjBa0QItsTCotFMZHpkcVf7nTSUP9KbhpZ
 g4D9RQnqfQJXj8ifyXL6n52gNIR/GzPOxTMM21clcnBEkDC9+AlgC4Bn5CTUyN9W3GiS+I
 9eUiVIIM8ZjwFtjD+a2XN49fGgxCjkg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-Lt5d-HYpMgqPHB2MpO-dlQ-1; Fri, 12 Dec 2025 05:25:31 -0500
X-MC-Unique: Lt5d-HYpMgqPHB2MpO-dlQ-1
X-Mimecast-MFC-AGG-ID: Lt5d-HYpMgqPHB2MpO-dlQ_1765535130
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42e2e447e86so719609f8f.3
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 02:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765535130; x=1766139930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xcU2D0Os4dN+GWBznUP/OXsjC9V0WYkZ+Cden057DQk=;
 b=SVzC6quRrEouyik7TXLAyWE0NgqU6RPuBS7HRinj9egDUO+KI6jHwcIW4oIS3YalwG
 MWi2kafDzEBAAZaYMNqZ/91j68BM/1MmwUl9viQkJfbGnCz9UIsfIUIp99CZrUlIDPMZ
 yoYAazAVGXe43WDZnM9ojFjdAhmCzTAhpqeolB4oJpH4/x7JHh8/BncdoUWMlEK5JEjp
 I1NGgtLcDNtQbvvJS0JlfPAoOBCMy1YFxG6YcXgyJS8rFFiBqRmWJOg6XPJymMUMEUkw
 rBMGzO3iwDCZ/SJadcETHz/QCUfn7CMITMY5AlwpM1MPdyO/ZdhItt2w9uUCHnXt5NZV
 ouVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765535130; x=1766139930;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xcU2D0Os4dN+GWBznUP/OXsjC9V0WYkZ+Cden057DQk=;
 b=JV6K4CW5xNKpQku/k4K0OucsGq3A6Td1TEY71K7nolr+mheJ44fAu6Yzuf024g3mw9
 VXuz6AT50Cf4g4T29MJfU5GiLLXxtSJMC2U8432/kZ7nOuVKMHgi7re7i06J+DJnC2jH
 xKOQbqUV387U665o84QPhuHUTLXdMN3xjaMh8mdk/gLffO2qntG4p2V5aYdcsmaH9mqM
 LXr9e1rtiHMFh2SpOAloLziNJHGyx7zmYZmCIqGmN143h3l5UC7N4THuGKnwH1n1inx1
 8XmrMKeTXpzmbjc3m4hpVNXhCvtAeDTxAEDVD+R0gzgZ5VCbp6aSWIz39EHY0WwhfC5f
 nFpQ==
X-Gm-Message-State: AOJu0Yx8WBZjFw+3dL5btn5TUi7nJxmU5Ae3wMqVsDsPWi80ZEDRjCuF
 MIGw9wj8IW5CrD5XR3C45etSTktahBqp2v9VTO9Hi7OpaB5ywdRQdko0QrGaNOaXGT+U7UuDY4b
 fVobwKJrkU0bUIewNyR2wmQ5vU3tjkXMgSf0jl5pumVpatIyJaoGkpx5z
X-Gm-Gg: AY/fxX77pagFmUT6MiVaP34eYKDCLOCg/9eRb9rc5JzIzQMFz+ulU3wvau0W0kIuP5/
 mM2zD+RzwlgMawpoynXy1WN2sAjtRb6/R6B40nxpsA6tTZ3sH+26otr/CY/NAOQpzaYOL3/jC1b
 rud/ePkocAhyJKLMj3rhHYdPg72JGUeKNR9AXROrpTAcVOPyhmlIKKUWlO+BrRMig9PXeZgozD4
 fQEOas3Lhky9iB/hfbsfGXPr152G8aNYP9erLucGtzWV//3N+Rfa04m41od9mxKrsPqJzFSkPOj
 N+9/vySbdZhESUQgqrUDX7dizO9lrckzy8BvvYzj7+2J9BtaXOov1hmZ/NxDf7yzLR6JAgw6MYc
 P/5GKiuWg3xhFzght48deeVMBWajIS7rtJEV765nuIVWgqFOdWDXpCBqUDOwpWNxSVA==
X-Received: by 2002:a05:6000:290b:b0:429:d3c9:b889 with SMTP id
 ffacd0b85a97d-42fb44a1c1dmr1281627f8f.1.1765535129594; 
 Fri, 12 Dec 2025 02:25:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRS/3z9CKb98YVMHL/8sSCmqW5V3VrtwBt1iOVchP5xfrmFbitxHz1iC9lHqK3W0qqWujCCw==
X-Received: by 2002:a05:6000:290b:b0:429:d3c9:b889 with SMTP id
 ffacd0b85a97d-42fb44a1c1dmr1281598f8f.1.1765535129158; 
 Fri, 12 Dec 2025 02:25:29 -0800 (PST)
Received: from localhost
 (p200300cfd7171fba423c00671f5dbd5f.dip0.t-ipconnect.de.
 [2003:cf:d717:1fba:423c:67:1f5d:bd5f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b8a9efsm11923515f8f.33.2025.12.12.02.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 02:25:28 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH for-10.2] Revert "nvme: Fix coroutine waking"
Date: Fri, 12 Dec 2025 11:25:22 +0100
Message-ID: <20251212102522.38232-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Lukáš Doktor reported a simple single-threaded nvme test case hanging
and bisected it to this commit.  While we are still investigating, it is
best to revert the commit for now.

(This breaks multiqueue for nvme, but better to have single-queue
working than neither.)

Cc: qemu-stable@nongnu.org
Reported-by: Lukáš Doktor <ldoktor@redhat.com>
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


