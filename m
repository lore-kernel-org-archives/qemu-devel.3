Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EB5C3ABCC
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 08:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDfwi-0006IR-VM; Sat, 10 May 2025 04:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDfwh-0006IH-QD
 for qemu-devel@nongnu.org; Sat, 10 May 2025 04:52:35 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDfwg-0005eT-6d
 for qemu-devel@nongnu.org; Sat, 10 May 2025 04:52:35 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso2904840b3a.0
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 01:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746867153; x=1747471953;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JTypoeZqSyyTDeBkhQ4cmNM0+/YBvay7mu1Vof3a/Wg=;
 b=Aiy2PstZuQf4GSYoFe7gEA7lMii1QyRvjO/UuwoeqJvSbT0ULT0m1EbRq8dHMFhuyG
 rYfNyTVHvjnHka4BMpoZEqm3HgjwlK1gIVm5/518kKbZiksk/+6SKG5zKDda9wjBi/rs
 AcM0ueIDpYeaTVTHFhOAEkOriLzv4OVBz1Wz3rpUSDiyboSG3fqFrY1twwi2WInDbBgr
 DPKvrp2rcOFpnVi0GUHkq+QKWyLOyorpNa9W0gzadaHSvhkzlziwqapMANCO+dRUK10y
 GKVy1qz/+sg+bPX12XgGVM547HmdSWmkTQooBnbhBm9qJUkrHq2LYSarGOnUg3f6miw5
 r+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746867153; x=1747471953;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JTypoeZqSyyTDeBkhQ4cmNM0+/YBvay7mu1Vof3a/Wg=;
 b=XbhuVDFVQBS3Qg+ZwZ06U2SODfmWQzEu94fJ1lGDJvKKf13h2enc5aeTU2oYbCyeqG
 A0zXxIK1t+ImtLVinuzfho59qGnRTW/oB/nKaSsxW2S6XMuoha+1YYLolr6adIFPD2IS
 iF5aZPYM9dnQsiXTlWo0C5fJxFzjenzb5Za477IxVjafiolApaLoOotI7qKab4oQjhp2
 Ye4AKdaiRDcbK1TOXmNNxy3R2DnSyRN4lNMc1trWeial0WNRuvv+fQ4+2d1zgVhSsr1J
 hQag3bKFaa3s4VcqZxsCBCeVfQcsqU6PlqEJeCd2R6DAXD6IWiqRCBFkQBUoxZw7J8v8
 iApA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmT5lncvwveQGs61rEP1vGheQ4KhrtYO7Zu+FIrfLDXsjWgQr0+HUMmnDzDtRRWt3ObtkEB7kguJf2@nongnu.org
X-Gm-Message-State: AOJu0YzL9zUJ7DPsSR0Jb+7nDPLqHTPg5V5Y1lMgTbC3z0LBFtes4ij1
 EsP1vqkMNTps/LjUOXSgnqL0CXr8Flz0I2fmpU5iiT781g6mgEo6rILWL+z1fWH0QfkLmjFCELN
 c
X-Gm-Gg: ASbGncvKAsfDlaqc6f1LT3fqEPs11D7SivLhDaMtWmTs9q33fjrGFxXiD1X1NyDCDz0
 nAvPnSlfcu/IVhdFUuPLltuclYqe1E/08BQiVpzmioqOOjCwOtEUNkhAcEUWMSd/lsUzOseatV1
 MlfYuaCoZxWmlgfa6R8Gpl2LFsKv+eULR4I9hnejupI1jRjhg+ASFhD5LHL+SwSnw1SmnxYPNX1
 irjaKTanEAeucxUcbjSplnH+wXzRb7PyMphZiMoPUOgxLug6MAsdIaqftD+rE3Us1MDUKBOeG8e
 Ejn8eUQc1fWarpA/6DX/qnRGV73v8TuTy0VxFo6cwRbXM6j+F+vPLphlMdZnq1uoDw==
X-Google-Smtp-Source: AGHT+IH5+GGfcQiorC5hfXfzvH4cquAZXNKyVZFeZg7oEzQwEe/vdLvIBPLFB6oJW7xXgWbCM3H9Cw==
X-Received: by 2002:a05:6a00:35cc:b0:736:b3cb:5db with SMTP id
 d2e1a72fcca58-740a94f8e34mr16789650b3a.11.1746867152768; 
 Sat, 10 May 2025 01:52:32 -0700 (PDT)
Received: from localhost ([157.82.203.223])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-74237704990sm2905115b3a.3.2025.05.10.01.52.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 01:52:32 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 10 May 2025 17:51:53 +0900
Subject: [PATCH v2 8/9] migration/postcopy: Replace QemuSemaphore with
 QemuEvent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-event-v2-8-7953177ce1b8@daynix.com>
References: <20250510-event-v2-0-7953177ce1b8@daynix.com>
In-Reply-To: <20250510-event-v2-0-7953177ce1b8@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
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
index eec49bf3f893..fd45a0f20c0f 100644
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


