Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2797C3ABC5
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 06:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDzry-0002DL-LC; Sun, 11 May 2025 02:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDzrx-0002D6-Bw
 for qemu-devel@nongnu.org; Sun, 11 May 2025 02:09:01 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDzrv-0003sr-MO
 for qemu-devel@nongnu.org; Sun, 11 May 2025 02:09:01 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso4794332b3a.2
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 23:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746943738; x=1747548538;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J+NahNT6JCkAHJlrO231/8rHXe7Wm87JlF1v64HG6q8=;
 b=UlvOrvvWmnzjk7BhcpJe/eHLQAJAywLiH6Po2lZOOgYzwzCDmTITYjpHIiW6NPJr/v
 1fUTsxrQu6zwv1ojyh0YWN+QbqjXYLGCb+76cfvuoiX8X5IjJNElpYP1NNUiIsf8B7iD
 qbOsdBWvzJMzA2sXsGMGUV+0bARuutqPDINZR2Pe1T287JRx+BhBrTkxUfeleUoUDgl5
 EmugO2UW1nGUXQnOp/4/gHQLTSdfXY7mesnHfhQiq0jJX356hOLAtPYmgu39DXglkpSj
 iiY6bKhdfbI30Hgz8BhH1htKx04h6NJNo7AymAkn3ru5mtKZG/fOF1mXl0f4QTyGA28N
 SmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746943738; x=1747548538;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J+NahNT6JCkAHJlrO231/8rHXe7Wm87JlF1v64HG6q8=;
 b=pcibM0V8zTwI8qzLrCK57VpjkE+RUvrd/p9gml1dpKOFbFTA4M14JQfouf8lYjcMIS
 BmZzjXJpn2DG4OtlrqFRpPoRAgbLdJu6XL03n5LzDxKVWyLIkg2boJvfA9ZvS6q/zhyM
 M6m8SD/IhamGYqGj8amYQzEyxgz+GNUCd/ZZxpE+Zz5sFHxHTJOA61cvVak0QXyUCHNm
 Q40R1CGuHYkMfPS74bBWtFVd9ilDgx2YjpjWL7AWgtNh9/P79rI/YY4Fj0aUpqWqwgTH
 t3FqpUGzTz33+ou2hcuOx1xssXX6D2YTo3YlmoAZClXUb0FclAJ99iCe2hVQy6s8DNmM
 MV0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4DRgJ608UXTpE4MrLETAH7yLPkFJFyqiym6zT+8oBeN/JuWuK0LgM/MGw21yadb2TQ3y8cOgrrMif@nongnu.org
X-Gm-Message-State: AOJu0YwKLCjQSTOT8KmFn4TEq91wbZ6rzKcDX4MeJ6mlEAUoltZ1jXTD
 TAwzwllxa0Xg/7iqxrImZw3ncDVCZQMa2832rD6G5GbXgFYwpCfvFhhASGE5UBg=
X-Gm-Gg: ASbGncu2+spaHCmG4qi5+GIfgLAb3NxFpOIey6ZFUXiTACrSBxo+sO00AxxCvrVy+TF
 ojM452lPjlWotxGnzuI+a94pBBGcTxuXla8w+ALFpRmw58k5BAIGH3ty+hLK0EaKCmVkryhStDG
 W5GRaYXtjYpx2Euxu00F7XmxfKjLWQtT8sSE+AzlFeEEy89zgRYZh0zo26tmWlkhvsXWBB8BZJt
 6YPWii6A3iVvYirmPPyR9wTuiQzXcCT66Got0KjefqQ3MDq3HrcGmn7CroJn45VIr31cr/+ZYEG
 6rv3L0wbcy4NVFkJPdSA4UZiOMhh9NYY3Wg8Dqvq4nTKeHPanNDpbgc=
X-Google-Smtp-Source: AGHT+IFKye8q7z4IHECvZYg91peS0IcZrGq6Vzi5NIPicgNI1L/SHT/iRRLb/3wu5TmJgIbupW4gng==
X-Received: by 2002:a05:6a00:9286:b0:736:3d7c:236c with SMTP id
 d2e1a72fcca58-7423be7d6d0mr11971050b3a.14.1746943737689; 
 Sat, 10 May 2025 23:08:57 -0700 (PDT)
Received: from localhost ([157.82.203.223])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-74237704025sm4191192b3a.13.2025.05.10.23.08.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 23:08:57 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 11 May 2025 15:08:20 +0900
Subject: [PATCH v3 03/10] futex: Replace __linux__ with CONFIG_LINUX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250511-event-v3-3-f7f69247d303@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
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
index 13459e44c768..dfe26b8d020c 100644
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


