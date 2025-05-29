Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67D1C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 05:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKW6L-00036q-B0; Thu, 29 May 2025 01:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW61-00031j-W4
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:31 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW60-0003DG-6a
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:29 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-742caef5896so357203b3a.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 22:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748497587; x=1749102387;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kMU5RXGBbkZhXJ9lXd+1Fr6sB8OdX216UKmxJPnd6lo=;
 b=Fx+bkKLYALBZ8oourcIz77uNRgF/7LNsCYFpj7XqdakAv+9xp+jeNpeMb6bmjbomUV
 GCFr2UEZtqq0kMqJ/iTQcqeTOrypmxuKCl3DHmtetAIt2mSs6Dqb5lIvRLZdpBnHCL3G
 sSCNQST6AZUkvH3pjxMmMU7dDfVCdcDl8ADwcGMAbyPOBTDzIi/0OQ0Jp4CBAON3pXNk
 f3BAoek37tSHoy87ftcHvOmcAMaBMz3SQ55ATbcxYIeLo3I2xgbRrjHJh2AM9kl+MxIP
 GUXtJaBkOhlC0EsUHyz0RpSETIBCYl69VqrD09GlqY/IPSEuzrOS/xx6JRC1nAhaOqS1
 n1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748497587; x=1749102387;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kMU5RXGBbkZhXJ9lXd+1Fr6sB8OdX216UKmxJPnd6lo=;
 b=cXhUYNAGQRIYB/Nikmh9J9R5DUdIbTa/x/6KOGEimDeSR3SpU/cv1a95jh3N7ISIzj
 Lgz98Jv3ewA5nTNtgnbb4qa4/pscd9ZzdCevzFYdGscUZuVQOMd/utSs/1YQo+lWu6j0
 G7gXXlwtVjUcbBqsN00oTSQkacHmnViHPWDhUDVzAlVGAK3KNYrc0SutVhPgLfoHMpvJ
 xCF5UGAQAZwyLGQBxSgbC0WRU1xDG+Ao5xcnLzONOQFFTxW698xdRBXfNqnqEuEJ2wap
 9BCNpc7Gl40VjSlH31UX80IfhIK0up7guQ3fSLBMTo6Fqq4u1gsoX6YCoAwbq9vJ/eVK
 TKdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmtXxoUi5zEVzRWQFEj95vKvsd4k6TF413EhCnS+czra6XN7B+pNgpXa8RznqEIq5C1VqNamIoNiyG@nongnu.org
X-Gm-Message-State: AOJu0YwstGPKAFbHgFLx9bewreh7sPpsl1N60cl9EUSN3T96vmjB+AuD
 CEvwU4/To6NLeFofwbVt/ssNFR4vOSts+qjRSe06jeEi8HrYdjG+ApmdnXpuJFyK/io=
X-Gm-Gg: ASbGncsr0k50nUOyCxENxHSax6MxJL+vxU5weu/8KX2U29V+uaWjIWTvXO0pDbKN6YB
 1aSuKc70zRUPTp1xfJb/Rhhf2gTqif8AVAJcQ2xIb6f8QY9345oH1VAgaGBfyGnwutO3QmgXS8j
 bIEcGkQs0oUo6JND2HSOgLsdQVSnILpoPyTbL7NLznwGgP7Iq17GlNQ23zxg0jR1dCwfqIKuYSQ
 K7k1rcNsd1HoWOEoPce8jtvyi1MaH5HDWWwoqM+Qs7O9SEnbwhzo3BjS/JOhF36wD4RlSf56LuC
 xiJZef+Z4idhDCIusWbC0FbNNhcVx1z78CfYEIUnbKATHbWdvwh7F8gxJWa9dPo=
X-Google-Smtp-Source: AGHT+IG0PmseUyyqUy+mDG0GYcFeHv0ZOD3dpBvwnhmJ9To1EySl8DGNfP7xO1j9uzJ8Bxk3QcJDCg==
X-Received: by 2002:a05:6a00:2da7:b0:730:9801:d3e2 with SMTP id
 d2e1a72fcca58-747b0c8ef15mr1679404b3a.8.1748497586945; 
 Wed, 28 May 2025 22:46:26 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-747afe966easm554014b3a.4.2025.05.28.22.46.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 22:46:26 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 29 May 2025 14:45:58 +0900
Subject: [PATCH v5 09/13] migration/postcopy: Replace QemuSemaphore with
 QemuEvent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-event-v5-9-53b285203794@daynix.com>
References: <20250529-event-v5-0-53b285203794@daynix.com>
In-Reply-To: <20250529-event-v5-0-53b285203794@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org, 
 devel@daynix.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.h    |  4 ++--
 migration/postcopy-ram.c | 10 +++++-----
 migration/savevm.c       |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index aaec471c00f8..739289de9342 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -98,9 +98,9 @@ struct MigrationIncomingState {
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
index 995614b38c9d..75fd310fb2b0 100644
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
index 006514c3e301..52105dd2f10b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2078,7 +2078,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
 
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                                    MIGRATION_STATUS_POSTCOPY_ACTIVE);
-    qemu_sem_post(&mis->thread_sync_sem);
+    qemu_event_set(&mis->thread_sync_event);
     trace_postcopy_ram_listen_thread_start();
 
     rcu_register_thread();

-- 
2.49.0


