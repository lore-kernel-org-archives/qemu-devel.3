Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E62C3ABCC
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 06:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDzsT-0002Tf-0a; Sun, 11 May 2025 02:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDzsQ-0002NF-Cf
 for qemu-devel@nongnu.org; Sun, 11 May 2025 02:09:30 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDzsM-0003zI-Gr
 for qemu-devel@nongnu.org; Sun, 11 May 2025 02:09:29 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7376dd56eccso3664366b3a.0
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 23:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746943765; x=1747548565;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JTypoeZqSyyTDeBkhQ4cmNM0+/YBvay7mu1Vof3a/Wg=;
 b=bp54SyyS1AWvMVI7ihn9qRT9Gm6OLq9WmUsTGh9cg8vwHYUpYr1t97J3xUFsQhcUzU
 32KM+6wvAVlbeoEI8kzg3htRQvLFITEKdzXJLf1oo31/p5SYLxtSdCQvquuWJ7ABOj1K
 Q5sg8H+Xr/0oKUXJ0Z6rMYT9QIuiiElYrHBARmCSgSfzM/mmOsnrDFraD2lOyS7X40X7
 eHvQ3TN8oA2c8zgjriO8CjNunOuOhNhZAVdM6PrUEuKLsAJogT+oKSi140Mdv5mvQapg
 oe/3NNgso5U/tWJhvLBb8GHH27ONPvmADs9pM+E3YZbrVcDqK+t+4n+NKLNDqE1c29Ic
 pU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746943765; x=1747548565;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JTypoeZqSyyTDeBkhQ4cmNM0+/YBvay7mu1Vof3a/Wg=;
 b=P2bzYxYiBShSpETdDcbfR0LCRzUTds8btDpFXv0xsQUfAX9D766GFeS5h3vzv7T7ph
 5DphW6OGNypjev0q1KoHnPp2zt17RZ1BBdS5hE1Cirl8KOU/nGIxBuyY0nix5XXbSyTh
 L8Wh8JSIE9Ai4dMDBWEVkrEITYautqY5bLMce57dSTSVfooCLzJjnZXzbeaRRfRC/Cjk
 69oSWGyMv00qmHncl9GsGceoBc5ix6Lu4wvDbzNbaHRyB/47wo1WYCoApwAEIGU73V4e
 NoSOoJAlJ/rfCiyD5FyHiNdnQ8H+mEyRLvfbd3MY3f4H86Fh213Wf+ZFmA55UB9ZFcHZ
 w5Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1Nd3Zopiws3GYKmmqMy05dypMjrYPGFN0/kI6mRXowIIrbN4MAvecPd4L5csz1LNHhFOAMFBZPVyK@nongnu.org
X-Gm-Message-State: AOJu0YzzS+9Nl1bOVmWcLjmbW792mxdaOor/MXy1NHD9dXLaszO1rfEQ
 TJIqhyOm3+LnF11eAsdGMx2kHZm7aok81o4oaVOEzYQDyxoPSyscmDmFUpTPNgA=
X-Gm-Gg: ASbGnctvrnYtOU4oT1AmsdxPc4j9xK5J4RX/sEurdssszORU5X6a2mD/mP0N4Vatte9
 yE/AfNI452gs5zbxByaOcRoip+e/chPs0GC3E9+E/mg2BILDkhtz9eS0TVyi6WPZGQovAjA7lQ+
 SAJdmfBo16D+VMLwHOCz2kF3afLMtsdw/8OrbxHgzCAfdFOe8a4ioeKo+C3bkhGjfJs5Rdgfqw+
 u7+aLF34oVcxsnC9dRvOH0XzIl589/zrfXjTURQuMU9heVCyZ7Zr9RDPjTal8rQA4rt+9tur8E1
 Sa2WJI+enPmK729Lqd91HHsTrai1OEI/c/jxGy726PeYsiwdLCq/ESA=
X-Google-Smtp-Source: AGHT+IGYTUJr+erX3gCKvhGmSsPSowRUsEOukTUu7wdlOAdlGaSS1fH99ZIX5LoPPbfB8mvb/OxFsg==
X-Received: by 2002:a05:6a21:3946:b0:1f5:9098:e448 with SMTP id
 adf61e73a8af0-215abb547c3mr12632191637.5.1746943765272; 
 Sat, 10 May 2025 23:09:25 -0700 (PDT)
Received: from localhost ([157.82.203.223])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b2350ddbb38sm3704131a12.62.2025.05.10.23.09.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 23:09:25 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 11 May 2025 15:08:26 +0900
Subject: [PATCH v3 09/10] migration/postcopy: Replace QemuSemaphore with
 QemuEvent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250511-event-v3-9-f7f69247d303@daynix.com>
References: <20250511-event-v3-0-f7f69247d303@daynix.com>
In-Reply-To: <20250511-event-v3-0-f7f69247d303@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
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


