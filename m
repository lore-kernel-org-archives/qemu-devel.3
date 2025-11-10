Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC360CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIU8v-000690-BK; Mon, 10 Nov 2025 10:49:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU8t-00060g-9L
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU8r-0000ru-9I
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762789756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=95UWx9bv5Qm9uHBp11oS3OtA++Y5vcpLhkYQtD3r7fI=;
 b=LeXL4KcDzppCle1LjOHiQHeiuJ380e9Yt+jWsSUu0x0gmalSU8vZRNUceRU4fMmN03OwJ6
 19BVeM4J3WaDfeJcaI3oLegBjUvnrV6qm4IrkM7dTHzKet6IuGDJAX1xKBVn6w+dBFurL6
 5P5pb29cKXiWZwXQF3ieqSaGMCLHAtE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-6LNBMRyPMcGY_ZSEauEZ9w-1; Mon, 10 Nov 2025 10:49:15 -0500
X-MC-Unique: 6LNBMRyPMcGY_ZSEauEZ9w-1
X-Mimecast-MFC-AGG-ID: 6LNBMRyPMcGY_ZSEauEZ9w_1762789754
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b352355a1so597157f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762789754; x=1763394554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=95UWx9bv5Qm9uHBp11oS3OtA++Y5vcpLhkYQtD3r7fI=;
 b=h4bHzwIr84RGPjarbrw+GoGDPF4iFV7nTX1UwgoRh/fGBE9gnSbsmEkDntFdVbCejT
 Eodb8jQ2LqU8/dd5T+Uw9xCK/Zo3oBfXLDFj+vTQZYXWyPvURBqc1VcLpELMcAubu4Zc
 J39uDFGcYDcyVv9O1WHsyv5P5eu5wKwGdVwvancREzKxUad6hhQiuEVVFb3B5DXyAE9y
 DNsZD3e5bjkkSYHz0zGStw80lI5E1eoOeeE805DZNI0pTmdU4uW5kTDpGbQQh8qHhnHs
 lINfKwkybXLH5lwmuBiD5IZFOizZ4IBH7Pk0t2MgeUWDWOXIbkuIFH5bE1chDF8eQ22F
 EdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789754; x=1763394554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=95UWx9bv5Qm9uHBp11oS3OtA++Y5vcpLhkYQtD3r7fI=;
 b=dATcn80KDhUayrjf/4r5AjdQQ2u2GL5E3U+qOel0jZX8xGI2Mlq58MptVUeYRa0Z9W
 9naISrkNa73jzmjVgzMaSQhRzU7POz+eMI9YZMrF/p4UEulIP8qPK6N6YilKeq2Yt3Q6
 x8987t5O6yQ9gOCl4b+qZrWEylPmA6Z9Nl1quqfIXAnYjCQnJGZmOtCm/7eG7qNzyUxN
 gSjzM/M03amY5fJcWrRgVTg6vr6HvGljcG/a9B8PMbs/9Kd25B2/myRO3Rx6lag2ehxS
 Edfld9ar1acsKmy90gyMPIB/YdR3WRlMl4yFn6DMLg1dATjaUeWo3hUvyYQSDG0o7r8S
 4oLA==
X-Gm-Message-State: AOJu0YyflnkeChuQmX2TL54kPbz96ektPFQcBOpYwgbrqPeBhXyosNTO
 XXlPtof8RXKsKvpgCMW1zkeEMWVwQK/i9JkcPaxs9sUObCoB8KgByVhRkmPHVon2ic8sB+F6LxB
 Zz4F9rrt98LDa4sJNHXDwpzA4J4YvbTG7zzKmkbAQ9HM3x+XWqAiof6iY
X-Gm-Gg: ASbGncuTP/1Zjm7d1hMKfdvjYdY4RGZGxYdmpEQ0PzdGmo+DViVYO4DmGU/aE4d8XvX
 gz4jsy5I8R0xLfREjWayzKNJ7qhexsHzHoGuoQLL0XClrRu3rXgLqYj8olG5bF8ORqFSlKHLiFk
 YQJBTkX8fEBKQUdOkCMvsE/a8mzDQMsxfabDhlVgwRAaBL4kYG0jMz1qAQ2jaLrpt80buX8TDN9
 gw3LTrquWg46xuDaFylLXa8qL0CRW3UdE39pMTNvOh5qBS7a5ny0uWdltDnJg5wNnYMwkO967XB
 vK0gDE4KZRoR/sfOQARJ344xb6XJCZ0qddPT8DDh2tpkRXbsUMCPwRff4ikPgJN6PRi3MlWC7t7
 y/bj+OuoJe4iViFEca/yfm66IRUg/93EH+oZqDrcTnVDsggyP6eTd9uN0Bg==
X-Received: by 2002:a05:6000:2809:b0:42b:3701:c4dc with SMTP id
 ffacd0b85a97d-42b3701c6b6mr3476560f8f.31.1762789753628; 
 Mon, 10 Nov 2025 07:49:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHO5r++23R4W9iXWJG96fnP70fFUBIkwFAGUbSuT1VJKvVrE7SVllB2faKEOdTTEtI/fui8YA==
X-Received: by 2002:a05:6000:2809:b0:42b:3701:c4dc with SMTP id
 ffacd0b85a97d-42b3701c6b6mr3476529f8f.31.1762789753081; 
 Mon, 10 Nov 2025 07:49:13 -0800 (PST)
Received: from localhost
 (p200300cfd7171f537afd31f3f827a45e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f53:7afd:31f3:f827:a45e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42abe63dfecsm23405854f8f.12.2025.11.10.07.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:49:11 -0800 (PST)
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
Subject: [PATCH v2 03/19] =?UTF-8?q?iscsi:=20Run=20co=20BH=20CB=20in=20the?=
 =?UTF-8?q?=20coroutine=E2=80=99s=20AioContext?=
Date: Mon, 10 Nov 2025 16:48:38 +0100
Message-ID: <20251110154854.151484-4-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110154854.151484-1-hreitz@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
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
bit boring, so at least the former we can drop and call aio_co_wake()
directly from scsi_co_generic_cb() to the same effect.  As for the
latter, the timer needs a CB, so we can’t drop it (I suppose we could
technically use aio_co_wake directly as the CB, but that would be
nasty), but we can put it into the coroutine’s AioContext to make its
aio_co_wake() a simple wrapper around qemu_coroutine_enter() without a
further BH indirection.

Finally, remove the iTask->co != NULL checks: This field is set by
iscsi_co_init_iscsitask(), which all users of IscsiTask run before even
setting up iscsi_co_generic_cb() as the callback, and it is never set or
cleared elsewhere, so it is impossible to not be set in
iscsi_co_generic_cb().

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/iscsi.c | 56 +++++++++++++++++++--------------------------------
 1 file changed, 21 insertions(+), 35 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 15b96ee880..852ecccf0d 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -107,7 +107,6 @@ typedef struct IscsiLun {
 
 typedef struct IscsiTask {
     int status;
-    int complete;
     int retries;
     int do_retry;
     struct scsi_task *task;
@@ -180,21 +179,10 @@ iscsi_schedule_bh(IscsiAIOCB *acb)
 
 #endif
 
-static void iscsi_co_generic_bh_cb(void *opaque)
-{
-    struct IscsiTask *iTask = opaque;
-
-    iTask->complete = 1;
-    aio_co_wake(iTask->co);
-}
-
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
@@ -239,6 +227,8 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
 {
     struct IscsiTask *iTask = opaque;
     struct scsi_task *task = command_data;
+    IscsiLun *iscsilun = iTask->iscsilun;
+    AioContext *itask_ctx = qemu_coroutine_get_aio_context(iTask->co);
 
     iTask->status = status;
     iTask->do_retry = 0;
@@ -263,9 +253,9 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
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
@@ -284,12 +274,17 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
         }
     }
 
-    if (iTask->co) {
-        replay_bh_schedule_oneshot_event(iTask->iscsilun->aio_context,
-                                         iscsi_co_generic_bh_cb, iTask);
-    } else {
-        iTask->complete = 1;
-    }
+    /*
+     * aio_co_wake() is safe to call: iscsi_service(), which called us, is only
+     * run from the event_timer and/or the FD handlers, never from the request
+     * coroutine.  The request coroutine in turn will yield unconditionally.
+     * We must release the lock, though, in case we enter the coroutine
+     * directly.  (Note that if do we enter the coroutine, iTask will probably
+     * be dangling once aio_co_wake() returns.)
+     */
+    qemu_mutex_unlock(&iscsilun->mutex);
+    aio_co_wake(iTask->co);
+    qemu_mutex_lock(&iscsilun->mutex);
 }
 
 static void coroutine_fn
@@ -592,12 +587,10 @@ static inline bool iscsi_allocmap_is_valid(IscsiLun *iscsilun,
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
@@ -669,7 +662,6 @@ retry:
     }
 
     if (iTask.do_retry) {
-        iTask.complete = 0;
         goto retry;
     }
 
@@ -740,7 +732,6 @@ retry:
             scsi_free_scsi_task(iTask.task);
             iTask.task = NULL;
         }
-        iTask.complete = 0;
         goto retry;
     }
 
@@ -902,7 +893,6 @@ retry:
     }
 
     if (iTask.do_retry) {
-        iTask.complete = 0;
         goto retry;
     }
 
@@ -940,7 +930,6 @@ retry:
     }
 
     if (iTask.do_retry) {
-        iTask.complete = 0;
         goto retry;
     }
 
@@ -1184,7 +1173,6 @@ retry:
     }
 
     if (iTask.do_retry) {
-        iTask.complete = 0;
         goto retry;
     }
 
@@ -1301,7 +1289,6 @@ retry:
     }
 
     if (iTask.do_retry) {
-        iTask.complete = 0;
         goto retry;
     }
 
@@ -2390,7 +2377,6 @@ retry:
     iscsi_co_wait_for_task(&iscsi_task, dst_lun);
 
     if (iscsi_task.do_retry) {
-        iscsi_task.complete = 0;
         goto retry;
     }
 
-- 
2.51.1


