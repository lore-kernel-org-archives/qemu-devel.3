Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C02CCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmeY-0008BN-Nr; Tue, 28 Oct 2025 12:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmeH-00084U-Ln
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDme8-0003Y9-Es
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761669245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6fT6mtzR5u0lZZ0ban5hvgxpPszfsK/X1TDCxFw5a88=;
 b=husxOrhji3BkLFKy7sNhdBiT8YyKS7dsEMa9fek/Pld7gbZmMifoYiwv4FHtAelXyeN7VR
 27zDTl42XjNYxh+WtKJrg+yN+BsyP+34J3XqX1QtEsyHBo7SMj1kyoYJLVDUHu1uuegAt4
 9A1QwSW+4fhzU8NWpYyT6wA9HTnT49M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-DNW2A8wAOIWH0iBXz8jD7Q-1; Tue, 28 Oct 2025 12:33:59 -0400
X-MC-Unique: DNW2A8wAOIWH0iBXz8jD7Q-1
X-Mimecast-MFC-AGG-ID: DNW2A8wAOIWH0iBXz8jD7Q_1761669238
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47111dc7c5dso431565e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761669238; x=1762274038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6fT6mtzR5u0lZZ0ban5hvgxpPszfsK/X1TDCxFw5a88=;
 b=jS58Cnh6WftnmCpEeOfS33p7cpMKiMev14w3DIfTMogLxxMHH7M87vL9pj8oCgcVzB
 H5mWOZ7L69esZBvr/IfykS73vGoGmYEcKVJK/mdoc0ruLo5PPd1KXvEKP2K8TqduHNox
 53Udd7kcWWjQ1KaZDJcK/iqkN/2N70Sg47M1pne/+B/Tvv5SgRvH+Y0p7u8tnP+9ftYy
 vSP4xMDY2oNuVnP+0n20ZfKSHxR2/Qs8t2qDZr1vwf8yy6oSMJ6f0QYnOgDHdK3hBMNQ
 VQqbiB33JhAknCbqwc8yP6F9MVU7qecHFIIdfdWL+aH4CRz31d5ST1ilJ9aCCy6luEre
 f9+g==
X-Gm-Message-State: AOJu0Yy6vtijw2jgwE15Ymh6XChPIIoUcSQBlM9EjK0N2Antzj2Ih5zs
 5srZuCUzyLDxxMj7SbKyQA0uo2i7KdjDEDmDmBOLORbD2qX8klCRf+pEYlEWg9Am3kPilalWU/w
 f13/xBGgZRafzNxbb64ig+B0HuccDiroNFsaOwkeNXtfYJcfuSjwOMtFf
X-Gm-Gg: ASbGnctsQEBxGTJEr8cu9eWzTZEXIcV8GU/MRbGuT6bMq5DoIlHE1i7hbK2Tziihrdn
 TvDDPAYhGZecgaT/OPK2spbXI3fw4UjcAt/jBBfzfTU7SQbBdxusWdZhKG1v12yUwRsWj3QyheE
 5nheGtyVcAvIgpLlh3duq1wK9sy2kfddNWW9SHW8NjA0U/SPY+jV3ib+KQFg0PgbpJ1fdKyZLt6
 jtzpH3xVRaFDKSvEYs7GSy9SA4Sv8uP5CMUbVZTTqQLNexcpIIvdPVtQg8NLs3bEPLMfhePfkJv
 X6Ot5VkvRCs685ruZmUUQkeYb3zeWsMGtDO6HzcxvW5knXwCHXDj9PZERXb4IFBzGjRCLVHZ7SO
 GNcuCkSKVUD0lJhn8u9atCMpzIv8+NI816sPNJ8Oc38SmEDv8Ly7SXVL4mA==
X-Received: by 2002:a05:600c:c10f:b0:475:d7fd:5c59 with SMTP id
 5b1f17b1804b1-4771819772amr25163855e9.16.1761669238295; 
 Tue, 28 Oct 2025 09:33:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOeyGHVXYZ85irW03JhyRix5r8yuu3zLuUZHaKA1+29RrLT2PcnJiHm7nIPcsmIrdPrRn8Jg==
X-Received: by 2002:a05:600c:c10f:b0:475:d7fd:5c59 with SMTP id
 5b1f17b1804b1-4771819772amr25163605e9.16.1761669237738; 
 Tue, 28 Oct 2025 09:33:57 -0700 (PDT)
Received: from localhost
 (p200300cfd7171feeff88afa910cb665f.dip0.t-ipconnect.de.
 [2003:cf:d717:1fee:ff88:afa9:10cb:665f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cb7dcsm21979902f8f.11.2025.10.28.09.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:33:56 -0700 (PDT)
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
Subject: [PATCH 03/16] =?UTF-8?q?iscsi:=20Run=20co=20BH=20CB=20in=20the=20?=
 =?UTF-8?q?coroutine=E2=80=99s=20AioContext?=
Date: Tue, 28 Oct 2025 17:33:29 +0100
Message-ID: <20251028163343.116249-4-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028163343.116249-1-hreitz@redhat.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
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

For rbd (and others), as described in “rbd: Run co BH CB in the
coroutine’s AioContext”, the pattern of setting a completion flag and
waking a coroutine that yields while the flag is not set can only work
when both run in the same thread.

iscsi has the same pattern, but the details are a bit different:
iscsi_co_generic_cb() can (as far as I understand) only run through
iscsi_service(), not just from a random thread at a random time.
iscsi_service() in turn can only be run after iscsi_set_events() set up
an FD event handler, which is done in iscsi_co_wait_for_task().

As a result, iscsi_co_wait_for_task() will always yield exactly once,
because iscsi_co_generic_cb() can only run after iscsi_set_events(),
after the completion flag has already been checked, and the yielding
coroutine will then be woken only once the completion flag was set to
true.  So as far as I can tell, iscsi has no bug and already works fine.

Still, we don’t need the completion flag because we know we have to
yield exactly once, so we can drop it.  This simplifies the code and
makes it more obvious that the “rbd bug” isn’t present here.

This makes iscsi_co_generic_bh_cb() and iscsi_retry_timer_expired() a
bit boring, and actually, for the former, we could drop it and run
aio_co_wake() directly from scsi_co_generic_cb() to the same effect; but
that would remove the replay_bh_schedule_oneshot_event(), and I assume
we shouldn’t do that.  At least schedule both the BH and the timer in
the coroutine’s AioContext to make them simple wrappers around
qemu_coroutine_enter(), without a further BH indirection.

Finally, remove the iTask->co != NULL checks: This field is set by
iscsi_co_init_iscsitask(), which all users of IscsiTask run before even
setting up iscsi_co_generic_cb() as the callback, and it is never set or
cleared elsewhere, so it is impossible to not be set in
iscsi_co_generic_cb().

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/iscsi.c | 39 ++++++++++-----------------------------
 1 file changed, 10 insertions(+), 29 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 15b96ee880..76c15e20ea 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -107,7 +107,6 @@ typedef struct IscsiLun {
 
 typedef struct IscsiTask {
     int status;
-    int complete;
     int retries;
     int do_retry;
     struct scsi_task *task;
@@ -183,18 +182,13 @@ iscsi_schedule_bh(IscsiAIOCB *acb)
 static void iscsi_co_generic_bh_cb(void *opaque)
 {
     struct IscsiTask *iTask = opaque;
-
-    iTask->complete = 1;
     aio_co_wake(iTask->co);
 }
 
 static void iscsi_retry_timer_expired(void *opaque)
 {
     struct IscsiTask *iTask = opaque;
-    iTask->complete = 1;
-    if (iTask->co) {
-        aio_co_wake(iTask->co);
-    }
+    aio_co_wake(iTask->co);
 }
 
 static inline unsigned exp_random(double mean)
@@ -239,6 +233,7 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
 {
     struct IscsiTask *iTask = opaque;
     struct scsi_task *task = command_data;
+    AioContext *itask_ctx = qemu_coroutine_get_aio_context(iTask->co);
 
     iTask->status = status;
     iTask->do_retry = 0;
@@ -263,9 +258,9 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
                              " (retry #%u in %u ms): %s",
                              iTask->retries, retry_time,
                              iscsi_get_error(iscsi));
-                aio_timer_init(iTask->iscsilun->aio_context,
-                               &iTask->retry_timer, QEMU_CLOCK_REALTIME,
-                               SCALE_MS, iscsi_retry_timer_expired, iTask);
+                aio_timer_init(itask_ctx, &iTask->retry_timer,
+                               QEMU_CLOCK_REALTIME, SCALE_MS,
+                               iscsi_retry_timer_expired, iTask);
                 timer_mod(&iTask->retry_timer,
                           qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + retry_time);
                 iTask->do_retry = 1;
@@ -284,12 +279,7 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
         }
     }
 
-    if (iTask->co) {
-        replay_bh_schedule_oneshot_event(iTask->iscsilun->aio_context,
-                                         iscsi_co_generic_bh_cb, iTask);
-    } else {
-        iTask->complete = 1;
-    }
+    replay_bh_schedule_oneshot_event(itask_ctx, iscsi_co_generic_bh_cb, iTask);
 }
 
 static void coroutine_fn
@@ -592,12 +582,10 @@ static inline bool iscsi_allocmap_is_valid(IscsiLun *iscsilun,
 static void coroutine_fn iscsi_co_wait_for_task(IscsiTask *iTask,
                                                 IscsiLun *iscsilun)
 {
-    while (!iTask->complete) {
-        iscsi_set_events(iscsilun);
-        qemu_mutex_unlock(&iscsilun->mutex);
-        qemu_coroutine_yield();
-        qemu_mutex_lock(&iscsilun->mutex);
-    }
+    iscsi_set_events(iscsilun);
+    qemu_mutex_unlock(&iscsilun->mutex);
+    qemu_coroutine_yield();
+    qemu_mutex_lock(&iscsilun->mutex);
 }
 
 static int coroutine_fn
@@ -669,7 +657,6 @@ retry:
     }
 
     if (iTask.do_retry) {
-        iTask.complete = 0;
         goto retry;
     }
 
@@ -740,7 +727,6 @@ retry:
             scsi_free_scsi_task(iTask.task);
             iTask.task = NULL;
         }
-        iTask.complete = 0;
         goto retry;
     }
 
@@ -902,7 +888,6 @@ retry:
     }
 
     if (iTask.do_retry) {
-        iTask.complete = 0;
         goto retry;
     }
 
@@ -940,7 +925,6 @@ retry:
     }
 
     if (iTask.do_retry) {
-        iTask.complete = 0;
         goto retry;
     }
 
@@ -1184,7 +1168,6 @@ retry:
     }
 
     if (iTask.do_retry) {
-        iTask.complete = 0;
         goto retry;
     }
 
@@ -1301,7 +1284,6 @@ retry:
     }
 
     if (iTask.do_retry) {
-        iTask.complete = 0;
         goto retry;
     }
 
@@ -2390,7 +2372,6 @@ retry:
     iscsi_co_wait_for_task(&iscsi_task, dst_lun);
 
     if (iscsi_task.do_retry) {
-        iscsi_task.complete = 0;
         goto retry;
     }
 
-- 
2.51.0


