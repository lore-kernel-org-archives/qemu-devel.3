Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDF0E77190
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 05:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQKCT-0007A9-4j; Wed, 25 Dec 2024 00:44:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tQKCR-00079d-Q3
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 00:44:51 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tQKCQ-0008Rs-57
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 00:44:51 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so68510905ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 21:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735105489; x=1735710289;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BfW6loc+fFQscPvRrP8GDLS1/0I7at7KRLKoCL6/Ni0=;
 b=Ge2znAg5xNZe1A1sOB38lorzo1bcpbcd6MKM4amixK7OpJNudM5s/4nmfD4BMAKBCM
 seBAqqCvqeEreIYVV5aSVcLizGRlkHyEZ0WAwjJgSYxY89Jx+kBjUy8SNfOmgQKPdNAA
 XNyuIfFiZOkk9gyyFF0Mr78VLjPTBVmBfVd89MorxTPwCViWf1Mjl4XStWpoOl+21MOV
 qjmzJcIDc3QWOULr0t8PjwgELWVohlWuIYAxvvvlY/PZhQYStIkUsdV8WjAHpkRq55Sq
 jop5dgXS8J16dmT5yEBsB5NbZ2whw6zLH1g3zwMeSvDEnSFT/SUwPemxBqsY3FY+v9Bi
 U7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735105489; x=1735710289;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BfW6loc+fFQscPvRrP8GDLS1/0I7at7KRLKoCL6/Ni0=;
 b=mj9FeG6RsJOswKmhNA2Aph7fTcEgmOExNzoNHgwkYBWVVjWn3FFjz7d7Wd8HcBFTsm
 pL+1rUx0teqAycvM+kitrhE545YCRcslYTh0MuHvhUj/Ee6zp/4iwjx32s35Q+s3L/GD
 IGLHO+tK2XRiLYvae+yqohsD3tDxw5c0OSxEhp3mzJN1LBP1oWQ8oJsHetIa+Wnoj5X/
 yxwlbibsspJAj2DiEEnI/jFSJ0ywhV/gtVqYOThdopS/wdCDupN1AsBx3CHoSbMNSKRH
 2IO0l0upPcrI00rQb1562GsJzW8GhRNaBA/zhvcVcPY3StOJbJuIJgIu6avUqUbAW598
 WrtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3jgo3rl67f/YFHhi4MJr6pO1E7Hcrod5B2TF5/vfRRMe75a643XdJALXoNJe/416iebYPfF6RPmfH@nongnu.org
X-Gm-Message-State: AOJu0YyTNNa2oRTVTJfJFEeIudW68zJsyOE+1IBYzL1FFyCf2hw/nTwc
 flPBoKo1FPHcuLTy53f3JDT21InUjq5cFdB27jHvoW7OYKNqOPsOugqzLUVXcMRPZt01SDMLg8c
 TYJo=
X-Gm-Gg: ASbGncsSTDZexBTRvAQcJRIJfBvYPTHt5r7z9S8Wy9jomgey8bxoVjXYcRqy9/8xUuR
 Obg+p9izYyKWDArxT/TmMbYQR6va+ftwGm/8Akxqf8eMeaqdkglmE2U3pSAMPZRGOxPw8d19aGc
 UOpopXli5smX8e1U48G9KNgy0Sro6m39M6p9T/cxeYZRpPIf5qN8xbKwZGrHNlSkE+M77HTvFf0
 y+tOxwVP3m/kG8J9SFBNPchRe9xuv7wugYyWmjd9LGTno+MmfruWZMuZVI+
X-Google-Smtp-Source: AGHT+IGj5tSFW7/HxPa8wxzeC3Nsr4XVV6a/eZZ/ifTTN8CopyXpMJrO2Jk0DBld4diyPUDhHElKdg==
X-Received: by 2002:a17:902:ea10:b0:216:271d:e06c with SMTP id
 d9443c01a7336-219e6ca6cb3mr243789455ad.4.1735105489039; 
 Tue, 24 Dec 2024 21:44:49 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-219dc962cddsm98698155ad.48.2024.12.24.21.44.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 21:44:48 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 25 Dec 2024 14:44:20 +0900
Subject: [PATCH 8/8] migration/postcopy: Replace QemuSemaphore with QemuEvent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241225-event-v1-8-a58c8d63eb70@daynix.com>
References: <20241225-event-v1-0-a58c8d63eb70@daynix.com>
In-Reply-To: <20241225-event-v1-0-a58c8d63eb70@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

thread_sync_sem is an one-shot event so it can be converted into
QemuEvent, which is more lightweight.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 migration/migration.h    |  4 ++--
 migration/postcopy-ram.c | 10 +++++-----
 migration/savevm.c       |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 14032e347ece..405f69c095e4 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -97,9 +97,9 @@ struct MigrationIncomingState {
     void (*transport_cleanup)(void *data);
     /*
      * Used to sync thread creations.  Note that we can't create threads in
-     * parallel with this sem.
+     * parallel with this event.
      */
-    QemuSemaphore  thread_sync_sem;
+    QemuEvent  thread_sync_event;
     /*
      * Free at the start of the main state load, set as the main thread finishes
      * loading state.
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index a535fd2e30c9..80f780bff87c 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -90,10 +90,10 @@ void postcopy_thread_create(MigrationIncomingState *mis,
                             QemuThread *thread, const char *name,
                             void *(*fn)(void *), int joinable)
 {
-    qemu_sem_init(&mis->thread_sync_sem, 0);
+    qemu_event_init(&mis->thread_sync_event, false);
     qemu_thread_create(thread, name, fn, mis, joinable);
-    qemu_sem_wait(&mis->thread_sync_sem);
-    qemu_sem_destroy(&mis->thread_sync_sem);
+    qemu_event_wait(&mis->thread_sync_event);
+    qemu_event_destroy(&mis->thread_sync_event);
 }
 
 /* Postcopy needs to detect accesses to pages that haven't yet been copied
@@ -964,7 +964,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
     trace_postcopy_ram_fault_thread_entry();
     rcu_register_thread();
     mis->last_rb = NULL; /* last RAMBlock we sent part of */
-    qemu_sem_post(&mis->thread_sync_sem);
+    qemu_event_set(&mis->thread_sync_event);
 
     struct pollfd *pfd;
     size_t pfd_len = 2 + mis->postcopy_remote_fds->len;
@@ -1716,7 +1716,7 @@ void *postcopy_preempt_thread(void *opaque)
 
     rcu_register_thread();
 
-    qemu_sem_post(&mis->thread_sync_sem);
+    qemu_event_set(&mis->thread_sync_event);
 
     /*
      * The preempt channel is established in asynchronous way.  Wait
diff --git a/migration/savevm.c b/migration/savevm.c
index f4e4876f7202..03e4cb63f35b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1987,7 +1987,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
 
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                                    MIGRATION_STATUS_POSTCOPY_ACTIVE);
-    qemu_sem_post(&mis->thread_sync_sem);
+    qemu_event_set(&mis->thread_sync_event);
     trace_postcopy_ram_listen_thread_start();
 
     rcu_register_thread();

-- 
2.47.1


