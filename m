Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E913CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIU9E-0006mv-B9; Mon, 10 Nov 2025 10:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU97-0006XU-6K
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU94-0000yD-Lf
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762789770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NMx550ACO7zDOBBqwioSHioy3m7Jbt+MKTb/hDJ7dnk=;
 b=c/Ff04uE0hQzOfH5xRZJWz0qroJLhJjJ1LO3HHY5XKW+3CHyDW5GnsPPWvIDJbrMKSJN0o
 pOS6mnnwmAEmYhLmCBpScMcHHx7jxi69kuOdEZmQ3JFoyLU4ylmc+DRhR2zRr0QIDSsouI
 55ONxd4e7DRvpQa8yWy0VeNlUeZiCjw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-BdNwteTAMvaY9w1kmAEPLQ-1; Mon, 10 Nov 2025 10:49:29 -0500
X-MC-Unique: BdNwteTAMvaY9w1kmAEPLQ-1
X-Mimecast-MFC-AGG-ID: BdNwteTAMvaY9w1kmAEPLQ_1762789768
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47106a388cfso17177955e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762789768; x=1763394568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NMx550ACO7zDOBBqwioSHioy3m7Jbt+MKTb/hDJ7dnk=;
 b=Ap01cP7dCjOssFqAJtXgJUCo6cGj7eBLHubTBzy80g0EFyohSAOJqb63aJWClY3UMW
 64SwIfrRGnLWis3ztzWNl+psMi6z2vptr1WMGRr3rIeGpmQPrOZ/scKn1JwU05gXZfwp
 15WN64NJWmaJUHSgDzvP06t7DlusUKNDQtFT2d0mq9as7VCLRHtsmcCVYZGy4T9e1HZH
 yEkgikVkgUR44aJJ0yhhKjkuPxsTZf2Q0iDpPayNEWZ6y3gKxZ6KGw9Wfx013YD/51wF
 f3lOufH9EOXVmjbtCb2X5jSKDpIuNUL0P8+WRWOSO6HWYNIJhFxbQCLaFEc9/sV6znvm
 uBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789768; x=1763394568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NMx550ACO7zDOBBqwioSHioy3m7Jbt+MKTb/hDJ7dnk=;
 b=aPt4iL6Y3lWQdhZT2HzNfYWUg/USp/bzivXNdV6aXNzVBhp5UUgvQvV83HljUB02x3
 9xuuPx6gVFdFo4ngRgiN6ft3XnkJXw6yYP0qqb3ro52G/t3spFivkHHPXwzfeyQrrBhv
 y22tZj0UsMc0fTKnnUvD4eIfmUGyPh8bwI+JeipchYQPaPlnsgs28SEs8noU5cMGE7ZN
 C454QU+iDszvVgDVLzeRhL4Ah6RuF0I0A9mpZ+/R5lmtPxyYZVqAExX9q0g3d9bTbrCW
 gyLmrmWDe5Wo8wy9t1RWD6V3AghtvchokZ0cVTlKKCEMwNY8b7vJ5/v0IOV6s/uN2tAG
 Z5lw==
X-Gm-Message-State: AOJu0YxgKJd2mgtzSQFCtwm/AGltB5A97ZXAPF4Z3BXs3P8GrNUmp/ZC
 jKiUSvRjlTb1FnVjgOenz95Qm6DIRGVdvSqoxxsmiWEbwR/UI/+1x2+jLkoeSSJHtQduh04/TjU
 7kghYyvARLdbLtn2Hts1gCBOo8Bb8oDqFhr3IjybrwT6uy1IgLaYj2O9U
X-Gm-Gg: ASbGnct2AD84K7v/GNIHwOdPkZVaZoVO0McZssdRbXmts56UxMaElV6GAfF+wsgaqAx
 BQQVQAM76fm8MI4N9l9lz8Ko91B21Qvz998cau43RS9JrpzjdtkvENDAHK18lujmq1CW/B0MbHP
 /s/jDIn7h9480VWrMiO/VFVC9ErVOsGN+QKlGQuv3Xu65surxdhI3BDwxQL2KgktL398Iq91tis
 Jzb3DpXxgUGIAhNfqzM2quUI2N1/CDZhbKERPdG/s7cOH/O4gjyj2IbY2bBaDmpDs3xUsEj3bS2
 hz4qCZacdnPVQEMY8cmMKsk6zTvPM9ULNPAPs4bCxasR8Fi99EWbBxbz1ZcCKvSqbpDOLHNtUx/
 rfsayaUmFhWLLUmpMmDc+VVNJuzxw9e6KxM23mocdI+39CDVX8ETIxtBRGw==
X-Received: by 2002:a05:600c:3113:b0:477:e66:4077 with SMTP id
 5b1f17b1804b1-477732939admr79689835e9.29.1762789767596; 
 Mon, 10 Nov 2025 07:49:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOK9MF2jSGA/iwWXhfy+PMefCuGoC6PvIkmluFJO0zeDJkoNik5ogboaaihZzutpy+zxQxuA==
X-Received: by 2002:a05:600c:3113:b0:477:e66:4077 with SMTP id
 5b1f17b1804b1-477732939admr79689445e9.29.1762789767159; 
 Mon, 10 Nov 2025 07:49:27 -0800 (PST)
Received: from localhost
 (p200300cfd7171f537afd31f3f827a45e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f53:7afd:31f3:f827:a45e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b303386f1sm14432126f8f.3.2025.11.10.07.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:49:25 -0800 (PST)
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
Subject: [PATCH v2 08/19] nvme: Fix coroutine waking
Date: Mon, 10 Nov 2025 16:48:43 +0100
Message-ID: <20251110154854.151484-9-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110154854.151484-1-hreitz@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
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

To fix that, use aio_co_wake() to run the coroutine in its home context.
Just like in the preceding iscsi and nfs patches, we can drop the
trivial nvme_rw_cb_bh() and use aio_co_wake() directly.

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
 block/nvme.c | 56 +++++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 7ed5f570bc..b8262ebfd9 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1176,25 +1176,35 @@ fail:
 
 typedef struct {
     Coroutine *co;
+    bool skip_yield;
     int ret;
-    AioContext *ctx;
 } NVMeCoData;
 
-static void nvme_rw_cb_bh(void *opaque)
-{
-    NVMeCoData *data = opaque;
-    qemu_coroutine_enter(data->co);
-}
-
 static void nvme_rw_cb(void *opaque, int ret)
 {
     NVMeCoData *data = opaque;
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
+        /*
+         * Safe to call: The case where we run in the request coroutine is
+         * handled above, so we must be independent of it; and without
+         * skip_yield set, the coroutine will yield.
+         * No need to release NVMeQueuePair.lock (we are called without it
+         * held).  (Note: If we enter the coroutine here, @data will
+         * probably be dangling once aio_co_wake() returns.)
+         */
+        aio_co_wake(data->co);
     }
-    replay_bh_schedule_oneshot_event(data->ctx, nvme_rw_cb_bh, data);
 }
 
 static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
@@ -1218,7 +1228,7 @@ static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
         .cdw12 = cpu_to_le32(cdw12),
     };
     NVMeCoData data = {
-        .ctx = bdrv_get_aio_context(bs),
+        .co = qemu_coroutine_self(),
         .ret = -EINPROGRESS,
     };
 
@@ -1235,9 +1245,7 @@ static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
         return r;
     }
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-
-    data.co = qemu_coroutine_self();
-    while (data.ret == -EINPROGRESS) {
+    if (!data.skip_yield) {
         qemu_coroutine_yield();
     }
 
@@ -1333,7 +1341,7 @@ static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
         .nsid = cpu_to_le32(s->nsid),
     };
     NVMeCoData data = {
-        .ctx = bdrv_get_aio_context(bs),
+        .co = qemu_coroutine_self(),
         .ret = -EINPROGRESS,
     };
 
@@ -1341,9 +1349,7 @@ static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
     req = nvme_get_free_req(ioq);
     assert(req);
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-
-    data.co = qemu_coroutine_self();
-    if (data.ret == -EINPROGRESS) {
+    if (!data.skip_yield) {
         qemu_coroutine_yield();
     }
 
@@ -1384,7 +1390,7 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
     };
 
     NVMeCoData data = {
-        .ctx = bdrv_get_aio_context(bs),
+        .co = qemu_coroutine_self(),
         .ret = -EINPROGRESS,
     };
 
@@ -1404,9 +1410,7 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
     assert(req);
 
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-
-    data.co = qemu_coroutine_self();
-    while (data.ret == -EINPROGRESS) {
+    if (!data.skip_yield) {
         qemu_coroutine_yield();
     }
 
@@ -1434,7 +1438,7 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
     };
 
     NVMeCoData data = {
-        .ctx = bdrv_get_aio_context(bs),
+        .co = qemu_coroutine_self(),
         .ret = -EINPROGRESS,
     };
 
@@ -1479,9 +1483,7 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
     trace_nvme_dsm(s, offset, bytes);
 
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
-
-    data.co = qemu_coroutine_self();
-    while (data.ret == -EINPROGRESS) {
+    if (!data.skip_yield) {
         qemu_coroutine_yield();
     }
 
-- 
2.51.1


