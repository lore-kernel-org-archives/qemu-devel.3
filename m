Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23E0CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmeg-0008Gf-I3; Tue, 28 Oct 2025 12:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmeQ-00087a-7P
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmeK-0003gP-Lb
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761669258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2U80ME5X7xSKjsO4KLvJ1M0GL7cSpjh3xsJvtFdCoFc=;
 b=QV8BT0kLrzjEDUvzjEY8ROwtcDJGYul3k2h6Dg6KX4wPsxgbYnlF+DHMCE15RAycyQettF
 kYpFu3zTF49cAaaakBLjgXM00pRuUVDVqO6syf9MAoXNSLXLK94XDIb6Nb3KbvdPTia+XL
 uYQFJ9InlURN1ggLiYhW4eVxZBKmOhw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-kG7K8c9RNqWQ0iWL7HGmzw-1; Tue, 28 Oct 2025 12:34:16 -0400
X-MC-Unique: kG7K8c9RNqWQ0iWL7HGmzw-1
X-Mimecast-MFC-AGG-ID: kG7K8c9RNqWQ0iWL7HGmzw_1761669255
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477171bbf51so6380455e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761669255; x=1762274055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2U80ME5X7xSKjsO4KLvJ1M0GL7cSpjh3xsJvtFdCoFc=;
 b=FkysiQUUKuuxjd7VSqPW4R1hLN0kaDw52dGjESWS+wwwF1vl+bN034z7Qb306JRjke
 fCqpw8rUQRN4BVxfKQXkvTZRE3IWGNV4HNy7Mn7OlfiqRQJCm4duBkfFmERAVj3ThMbC
 GLVcWNAhOn/5biIooW1yD0N30KSieD2H+D1/fa+N8aD38KrPDubISThLk88N3AEUdfMq
 CUKAfAHZepVUBcgTLa/6nEhIyxd3FDFe2WFaICTIp01XBVTRAmuBdSZuZnAC748Hn9Rh
 cIT7X8eChSvHpUTeWx4D3LwEG/pY3vV76OUyX6rgm3wfC4ziWx1Dp7u95ZOVKh2JijGn
 2A4Q==
X-Gm-Message-State: AOJu0Yy3XsPI66N7i65lCiIDwyPPmknwgewJ98tTnnodYD9xfI9WewQj
 UOyt/nyPLGZnWThRqHD5r/W2c2rQRlgP63QJqXe4vNbdC1PEiz50bGiCYMyf7FC1awW99NEAKFu
 auiWfKzE5XGXSwkoMD75gu5YCyhrrrU9y1SzdNo3Tw+4ACljS8GxnRyG1
X-Gm-Gg: ASbGncsWS+uZ+W0OecHRDbewAl7tVk7Dv5J+73leKR4AtzmOqcE48EeN0bO5Stn14No
 rE3NxKZBDZW3vGFWYJ+UfIgV5KcwdtKQAjXBI3f3wGr0IRwBBoMNsjk3FStxOnuB5ooez6x+Wiz
 IZRPTckQ5u6ypMesykFeGlXDwQch76Q+kml+Z4gzEyckk3qAqlmS6SEbovntw637SedbdOFp3oX
 PLM6XTUclQjQIx5Ix2ctNHJskAff9zdGbafaRxySvX0bdabcLDES8ltVWeV3hdJYB77JBWfqV9O
 dpPXE+UbC38QsZDB6LwV6rJ/UXxgDvpR+CwpukJzCU1GqFUIbcV/TTkwnDXtmpRLVn2QQFNpAqy
 nMpM88WCKR4/jFR9erHv0RrGh7XqGHEfvdJIuwHR2Musyls3sg22oe+cxdQ==
X-Received: by 2002:a05:600c:34d0:b0:46e:41b0:f0cb with SMTP id
 5b1f17b1804b1-4771e1cb177mr804425e9.25.1761669254417; 
 Tue, 28 Oct 2025 09:34:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQmkNTSEvC5o3/eBH7QlX9nY4qlj2NbJKwfNhzskrzuXwQP7QV8ynPHtkIfl5f4zuTSbdj7Q==
X-Received: by 2002:a05:600c:34d0:b0:46e:41b0:f0cb with SMTP id
 5b1f17b1804b1-4771e1cb177mr803925e9.25.1761669253409; 
 Tue, 28 Oct 2025 09:34:13 -0700 (PDT)
Received: from localhost
 (p200300cfd7171feeff88afa910cb665f.dip0.t-ipconnect.de.
 [2003:cf:d717:1fee:ff88:afa9:10cb:665f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952e3201sm21260003f8f.47.2025.10.28.09.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:34:11 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: [PATCH 08/16] nvme: Fix coroutine waking
Date: Tue, 28 Oct 2025 17:33:34 +0100
Message-ID: <20251028163343.116249-9-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028163343.116249-1-hreitz@redhat.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
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

nvme wakes the request coroutine via qemu_coroutine_enter() from a BH
scheduled in the BDS AioContext.  This may not be the same context as
the one in which the request originally ran, which would be wrong:
- It could mean we enter the coroutine before it yields,
- We would move the coroutine in to a different context.

(Can be reproduced with multiqueue by adding a usleep(100000) before the
`while (data.ret == -EINPROGRESS)` loop.)

To fix that, schedule nvme_rw_cb_bh() in the coroutine AioContext.
(Just like in the preceding iscsi and nfs patches, we could drop the
trivial nvme_rw_cb_bh() and just use aio_co_wake() directly, but don’t
do that to keep replay_bh_schedule_oneshot_event().)

With this, we can remove NVMeCoData.ctx.

Note the check of data->co == NULL to bypass the BH/yield combination in
case nvme_rw_cb() is called from nvme_submit_command(): We probably want
to keep this fast path for performance reasons, but we have to be quite
careful about it:
- We cannot overload .ret for this, but have to use a dedicated
  .skip_yield field.  Otherwise, if nvme_rw_cb() runs in a different
  thread than the coroutine, it may see .ret set and skip the yield,
  while nvme_rw_cb() will still schedule a BH for waking.   Therefore,
  the signal to skip the yield can only be set in nvme_rw_cb() if waking
  too is skipped, which is independent from communicating the return
  value.
- We can only skip the yield if nvme_rw_cb() actually runs in the
  request coroutine.  Otherwise (specifically if they run in different
  AioContexts), the order between this function’s execution and the
  coroutine yielding (or not yielding) is not reliable.
- There is no point to yielding in a loop; there are no spurious wakes,
  so once we yield, we will only be re-entered once the command is done.
  Replace `while` by `if`.

Cc: qemu-stable@nongnu.org
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/nvme.c | 56 +++++++++++++++++++++-------------------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 7ed5f570bc..4b1f623e7d 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1176,8 +1176,8 @@ fail:
 
 typedef struct {
     Coroutine *co;
+    bool skip_yield;
     int ret;
-    AioContext *ctx;
 } NVMeCoData;
 
 static void nvme_rw_cb_bh(void *opaque)
@@ -1189,12 +1189,22 @@ static void nvme_rw_cb_bh(void *opaque)
 static void nvme_rw_cb(void *opaque, int ret)
 {
     NVMeCoData *data = opaque;
+    AioContext *ctx;
+
     data->ret = ret;
-    if (!data->co) {
-        /* The rw coroutine hasn't yielded, don't try to enter. */
-        return;
+
+    if (data->co == qemu_coroutine_self()) {
+        /*
+         * Fast path: We are inside of the request coroutine (through
+         * nvme_submit_command, nvme_deferred_fn, nvme_process_completion).
+         * We can set data->skip_yield here to keep the coroutine from
+         * yielding, and then we don't need to schedule a BH to wake it.
+         */
+        data->skip_yield = true;
+    } else {
+        ctx = qemu_coroutine_get_aio_context(data->co);
+        replay_bh_schedule_oneshot_event(ctx, nvme_rw_cb_bh, data);
     }
-    replay_bh_schedule_oneshot_event(data->ctx, nvme_rw_cb_bh, data);
 }
 
 static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
@@ -1217,10 +1227,7 @@ static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
         .cdw11 = cpu_to_le32(((offset >> s->blkshift) >> 32) & 0xFFFFFFFF),
         .cdw12 = cpu_to_le32(cdw12),
     };
-    NVMeCoData data = {
-        .ctx = bdrv_get_aio_context(bs),
-        .ret = -EINPROGRESS,
-    };
+    NVMeCoData data = { .co = qemu_coroutine_self() };
 
     trace_nvme_prw_aligned(s, is_write, offset, bytes, flags, qiov->niov);
     assert(s->queue_count > 1);
@@ -1235,9 +1242,7 @@ static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
         return r;
     }
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-
-    data.co = qemu_coroutine_self();
-    while (data.ret == -EINPROGRESS) {
+    if (!data.skip_yield) {
         qemu_coroutine_yield();
     }
 
@@ -1332,18 +1337,13 @@ static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
         .opcode = NVME_CMD_FLUSH,
         .nsid = cpu_to_le32(s->nsid),
     };
-    NVMeCoData data = {
-        .ctx = bdrv_get_aio_context(bs),
-        .ret = -EINPROGRESS,
-    };
+    NVMeCoData data = { .co = qemu_coroutine_self() };
 
     assert(s->queue_count > 1);
     req = nvme_get_free_req(ioq);
     assert(req);
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-
-    data.co = qemu_coroutine_self();
-    if (data.ret == -EINPROGRESS) {
+    if (!data.skip_yield) {
         qemu_coroutine_yield();
     }
 
@@ -1383,10 +1383,7 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
         .cdw11 = cpu_to_le32(((offset >> s->blkshift) >> 32) & 0xFFFFFFFF),
     };
 
-    NVMeCoData data = {
-        .ctx = bdrv_get_aio_context(bs),
-        .ret = -EINPROGRESS,
-    };
+    NVMeCoData data = { .co = qemu_coroutine_self() };
 
     if (flags & BDRV_REQ_MAY_UNMAP) {
         cdw12 |= (1 << 25);
@@ -1404,9 +1401,7 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
     assert(req);
 
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-
-    data.co = qemu_coroutine_self();
-    while (data.ret == -EINPROGRESS) {
+    if (!data.skip_yield) {
         qemu_coroutine_yield();
     }
 
@@ -1433,10 +1428,7 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
         .cdw11 = cpu_to_le32(1 << 2), /*deallocate bit*/
     };
 
-    NVMeCoData data = {
-        .ctx = bdrv_get_aio_context(bs),
-        .ret = -EINPROGRESS,
-    };
+    NVMeCoData data = { .co = qemu_coroutine_self() };
 
     if (!s->supports_discard) {
         return -ENOTSUP;
@@ -1479,9 +1471,7 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
     trace_nvme_dsm(s, offset, bytes);
 
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-
-    data.co = qemu_coroutine_self();
-    while (data.ret == -EINPROGRESS) {
+    if (!data.skip_yield) {
         qemu_coroutine_yield();
     }
 
-- 
2.51.0


