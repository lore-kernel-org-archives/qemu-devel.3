Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D4EC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 05:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKW5q-0002xg-8c; Thu, 29 May 2025 01:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW5k-0002wO-KK
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:12 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW5i-00039m-MT
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:12 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-742c5f3456fso378610b3a.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 22:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748497569; x=1749102369;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tnhDHBHT8UpHOJ0AArQ0HTYILZ+Nf8KL3aRskmQW/xU=;
 b=O4aQz2Lo5icVm2ElyHoSslEpVJJ6cF3xyN7JP9sJbq5/UrSgBJywUzuiOW46pKNFJa
 CnJwarpVL0DB+G91KmqcEXBnTl2WRc76xGgadlDgI/Qac+0a4HdeEokRzbLizNcKZvrz
 Ev3KNBgDJrRS9hkTABbI2MhVL7FgIci/77yaZ7jIYVivq+Y05kwtsNQuz9hlxByzivq4
 BTdwr2cJ80C1TPh5xAEuHo9dpNoF9YRmMIbgjYD9v/M1uL2mGWkRdhUdKCCN6dPHCx2J
 57Cyi8xN8qKjvhP1k6mdWdolMNrYKh18j5uqGKsUU40CXPh6vdE6vMH/2t1pjUmJoRVQ
 5CSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748497569; x=1749102369;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tnhDHBHT8UpHOJ0AArQ0HTYILZ+Nf8KL3aRskmQW/xU=;
 b=RAuzuZ/HGuGhiYvReGztiI2TddyS70H6Cdvj5mlKwcMAYyAcfZvdZ3WdYjo6KdIf9H
 4ygiVYdbNsRJ4+YDl8KphevhZwFD97YUJXT16wQFRkJ3Dq8FoLWYbb/y6oL+W4OIFGFA
 g7HLMcuEkYYyZyymuiiGnqqWof6lcDm0UC5ahwkQfjuJXAT7g3tGHmtda4R6lLp2rW5Y
 JnSAi+i5zSSqk5pC33cUrBVlWIDxEF4lSBdfPBEmy9G15jgi78FnMJ1k2q/Mpnasduov
 jzM91IzQjxotHZ6UFESPgX1tJRc3VEhSDKMcJxoVhGae8xC+4UEprBVcSbw1+F9Shgki
 +n5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyc2LqF+zp3KYlZ5Z7RLc6GY+YaHQcarzP/SiyqCmryg3IkjBgeNb9KSitjpl44+A2Y1PIXKBVuKMi@nongnu.org
X-Gm-Message-State: AOJu0Yy8q1xTH6eEotY068Lfj4hcXkcBawS/EiFlX0yWmb0vQ6wsa4aA
 3MrcMePYhZFimwruLlZnM9oHfkErrB1ES31zwe4PYes1XMpQgvjO+8cwYSSm6fiSZmQ=
X-Gm-Gg: ASbGncvc1z+wN0gVfGs5zyTHFkyEDuBQ0gmdKjYJopD9pMTl3ceuMSgOKMJcXKidLQE
 0WF9nAf7FNNqqqiihKBrQ4eH5kbx6wiwF36M0Y55ya4q1yxeHHARwjO7u1vfLMjjgqF8B5IcJCI
 Rm/Jn/Z8OTLXN4qbRbuJatggcGCFx9+KQad4yp7voVzwZ6UOAHRscExYpEs/TKub62GmgUXFG+J
 IYxU5lp/kyC/VroYwiWh16K+qw60i6zWjPX5cQ8mP1NBoz4mYDHjKPnbgstSjXyzMnsiC6klF2o
 w7ReJF5pvQ7eUYuOf+EoJpLW4hB20zJT4zKQhNbayImPgkxUWHCh4MsqeZB3/r8=
X-Google-Smtp-Source: AGHT+IGbvxN6Qo6GM6mEN++Vg1ZAJFx2h79irkAF1x8Fx0th1UhjHdKtQRXXkPndmwwDDViWDeUrVA==
X-Received: by 2002:a05:6a00:a96:b0:740:6f69:f52a with SMTP id
 d2e1a72fcca58-745fdac80demr28303009b3a.0.1748497569098; 
 Wed, 28 May 2025 22:46:09 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-747afeaba4fsm567686b3a.63.2025.05.28.22.46.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 22:46:08 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 29 May 2025 14:45:52 +0900
Subject: [PATCH v5 03/13] qemu-thread: Replace __linux__ with CONFIG_LINUX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250529-event-v5-3-53b285203794@daynix.com>
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

scripts/checkpatch.pl warns for __linux__ saying "architecture specific
defines should be avoided".

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/thread-posix.h | 2 +-
 util/qemu-thread-posix.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/qemu/thread-posix.h b/include/qemu/thread-posix.h
index 5f2f3d1386bc..c412623a9143 100644
--- a/include/qemu/thread-posix.h
+++ b/include/qemu/thread-posix.h
@@ -33,7 +33,7 @@ struct QemuSemaphore {
 };
 
 struct QemuEvent {
-#ifndef __linux__
+#ifndef CONFIG_LINUX
     pthread_mutex_t lock;
     pthread_cond_t cond;
 #endif
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 4d6f24d705c7..21ed12ddb56b 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -317,7 +317,7 @@ void qemu_sem_wait(QemuSemaphore *sem)
     qemu_mutex_unlock(&sem->mutex);
 }
 
-#ifdef __linux__
+#ifdef CONFIG_LINUX
 #include "qemu/futex.h"
 #else
 static inline void qemu_futex_wake(QemuEvent *ev, int n)
@@ -363,7 +363,7 @@ static inline void qemu_futex_wait(QemuEvent *ev, unsigned val)
 
 void qemu_event_init(QemuEvent *ev, bool init)
 {
-#ifndef __linux__
+#ifndef CONFIG_LINUX
     pthread_mutex_init(&ev->lock, NULL);
     pthread_cond_init(&ev->cond, NULL);
 #endif
@@ -376,7 +376,7 @@ void qemu_event_destroy(QemuEvent *ev)
 {
     assert(ev->initialized);
     ev->initialized = false;
-#ifndef __linux__
+#ifndef CONFIG_LINUX
     pthread_mutex_destroy(&ev->lock);
     pthread_cond_destroy(&ev->cond);
 #endif

-- 
2.49.0


