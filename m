Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E986C61CE8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWKz-0004qC-RH; Fri, 06 Jun 2025 08:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWJ4-0003S7-7w
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWJ1-0005zb-5S
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eYJeLQYvbKDx/QkCxC4hOQDCvKuzoGgQDdTfpggpJGo=;
 b=YH0ebMMz7+pXb2K80wwxHauylf7esZTpRBXwX1hrLb6r4eU77tYM4XxxVm//1jVnXNSiHt
 bvkhL/SxKXwND3g7iOJEIshpOyIDuFncIttRx011D77XbCdaqosLSbqSRQgypFbv5SQayf
 Hdbi9D4tl3Ytc+DXN3M1HtNOT0BCrP4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-fvHFoSv9OtCpg-v0H3z1fA-1; Fri, 06 Jun 2025 08:36:16 -0400
X-MC-Unique: fvHFoSv9OtCpg-v0H3z1fA-1
X-Mimecast-MFC-AGG-ID: fvHFoSv9OtCpg-v0H3z1fA_1749213375
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f65a705dso1275119f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213374; x=1749818174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eYJeLQYvbKDx/QkCxC4hOQDCvKuzoGgQDdTfpggpJGo=;
 b=kLqyLU/H2u3Ji3CrXMlLl+OZ/sQMgn3U2FISNMpWDXK/YHCVLq3ATag99TnM9eruB5
 gcyLBM60jAz/C1rBTJmaxP5qNpJTkjcyQz4klAk2HAtrfOaKOS9jlRz1qmK5j2wqQZOd
 4YgjaZST6W4Iu0U4LTgXzEjgBJrVeScJ0LDMRCgPBSa0YuUZ9obMxd+cDZXGFhK/4Tgb
 Yl9urBjpdAU7+CHKJ49KJdxlBOcTxfPJkrD8lYLz8gSgoj/XnDS3xuaH4a3VckmqxEhy
 VMKOF+2WZt9U7WprhOzdiZV9svGfeEmYouRhcEETxZm/poCcUFFQG55PRBfL03o/GL5b
 RROQ==
X-Gm-Message-State: AOJu0YxsjXnaKCxFho79h/0aDCeZ52pKv41VyBPaXAWVXhTwKPi6WFVD
 JtFph/2CvpjTBHCSjstAvw0yNRpF4msLBJlZBkXfH6Cdd18WAZPvtsEcgoWsl9EmhPwm/jQCljv
 8VNaC+mkOKC+sthwgtQi8op6XgzJxU3YmGjsLd3snpxNA2FzX7tKuFK1485MRuantq9dRKMgX85
 8Z0SM0dy+W3vKC98i7YiPw4C55WjWcLVBw/peWu7LJ
X-Gm-Gg: ASbGncvi8lROCZF/f3bF7bB0Q7gj+oY5rP6t0Lrt6cBPDuwaizD8kJB0leq8fUjgA7i
 stw0OZJaYxs4UDUDq1Ued/NINaUOZvQlR4NxLwTBXwwEUVUATEsmUJEzTCJGzPBBc58RRPDd6D0
 7X9/VpFUh5Iq5+myaqyG9oWPzn1PzLIN3PG03VHZKmKPf6xoBjjYDE7NXKpaaJyvLn9drDbx42S
 RqP/MnPqScskmRIrpWtTO/CRTuNiBOMN5TZ/fIrBRnUYYjY9WDrIbcYnoa2pYbHqXVUmqDpmOsu
 thqZjulTbV+cPQ==
X-Received: by 2002:a5d:64c7:0:b0:3a4:d0dc:184f with SMTP id
 ffacd0b85a97d-3a531cdcfa0mr2712749f8f.39.1749213374518; 
 Fri, 06 Jun 2025 05:36:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgXuY99rVbUKv96STZzIJ2w0i82W+i4zh12btb3sZ/9EnjHIvNleLrRJGTM61t8YcP/YLIsA==
X-Received: by 2002:a5d:64c7:0:b0:3a4:d0dc:184f with SMTP id
 ffacd0b85a97d-3a531cdcfa0mr2712723f8f.39.1749213374069; 
 Fri, 06 Jun 2025 05:36:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452730b9beasm19709415e9.22.2025.06.06.05.36.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:36:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/31] migration/colo: Replace QemuSemaphore with QemuEvent
Date: Fri,  6 Jun 2025 14:34:39 +0200
Message-ID: <20250606123447.538131-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

colo_exit_sem and colo_incoming_sem represent one-shot events so they
can be converted into QemuEvent, which is more lightweight.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250529-event-v5-8-53b285203794@daynix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 migration/migration.h |  6 +++---
 migration/colo.c      | 20 ++++++++++----------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 21aa6a3c8fe..aaec471c00f 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -186,7 +186,7 @@ struct MigrationIncomingState {
 
     /* The coroutine we should enter (back) after failover */
     Coroutine *colo_incoming_co;
-    QemuSemaphore colo_incoming_sem;
+    QemuEvent colo_incoming_event;
 
     /* Optional load threads pool and its thread exit request flag */
     ThreadPool *load_threads;
@@ -381,8 +381,8 @@ struct MigrationState {
     /* Migration is paused due to pause-before-switchover */
     QemuEvent pause_event;
 
-    /* The semaphore is used to notify COLO thread that failover is finished */
-    QemuSemaphore colo_exit_sem;
+    /* The event is used to notify COLO thread that failover is finished */
+    QemuEvent colo_exit_event;
 
     /* The event is used to notify COLO thread to do checkpoint */
     QemuEvent colo_checkpoint_event;
diff --git a/migration/colo.c b/migration/colo.c
index c976b3ff344..e0f713c837f 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -146,7 +146,7 @@ static void secondary_vm_do_failover(void)
         return;
     }
     /* Notify COLO incoming thread that failover work is finished */
-    qemu_sem_post(&mis->colo_incoming_sem);
+    qemu_event_set(&mis->colo_incoming_event);
 
     /* For Secondary VM, jump to incoming co */
     if (mis->colo_incoming_co) {
@@ -195,7 +195,7 @@ static void primary_vm_do_failover(void)
     }
 
     /* Notify COLO thread that failover work is finished */
-    qemu_sem_post(&s->colo_exit_sem);
+    qemu_event_set(&s->colo_exit_event);
 }
 
 COLOMode get_colo_mode(void)
@@ -620,8 +620,8 @@ out:
     }
 
     /* Hope this not to be too long to wait here */
-    qemu_sem_wait(&s->colo_exit_sem);
-    qemu_sem_destroy(&s->colo_exit_sem);
+    qemu_event_wait(&s->colo_exit_event);
+    qemu_event_destroy(&s->colo_exit_event);
 
     /*
      * It is safe to unregister notifier after failover finished.
@@ -651,7 +651,7 @@ void migrate_start_colo_process(MigrationState *s)
     s->colo_delay_timer =  timer_new_ms(QEMU_CLOCK_HOST,
                                 colo_checkpoint_notify_timer, NULL);
 
-    qemu_sem_init(&s->colo_exit_sem, 0);
+    qemu_event_init(&s->colo_exit_event, false);
     colo_process_checkpoint(s);
     bql_lock();
 }
@@ -808,11 +808,11 @@ void colo_shutdown(void)
     case COLO_MODE_PRIMARY:
         s = migrate_get_current();
         qemu_event_set(&s->colo_checkpoint_event);
-        qemu_sem_post(&s->colo_exit_sem);
+        qemu_event_set(&s->colo_exit_event);
         break;
     case COLO_MODE_SECONDARY:
         mis = migration_incoming_get_current();
-        qemu_sem_post(&mis->colo_incoming_sem);
+        qemu_event_set(&mis->colo_incoming_event);
         break;
     default:
         break;
@@ -827,7 +827,7 @@ static void *colo_process_incoming_thread(void *opaque)
     Error *local_err = NULL;
 
     rcu_register_thread();
-    qemu_sem_init(&mis->colo_incoming_sem, 0);
+    qemu_event_init(&mis->colo_incoming_event, false);
 
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_COLO);
@@ -923,8 +923,8 @@ out:
     }
 
     /* Hope this not to be too long to loop here */
-    qemu_sem_wait(&mis->colo_incoming_sem);
-    qemu_sem_destroy(&mis->colo_incoming_sem);
+    qemu_event_wait(&mis->colo_incoming_event);
+    qemu_event_destroy(&mis->colo_incoming_event);
 
     rcu_unregister_thread();
     return NULL;
-- 
2.49.0


