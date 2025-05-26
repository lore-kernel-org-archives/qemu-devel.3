Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003BCC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 05:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJQPE-000727-JI; Mon, 26 May 2025 01:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJQP4-000708-9S
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:29:40 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJQP2-0001xr-AP
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:29:37 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2346765d5b0so4064535ad.2
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748237374; x=1748842174;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ylcfQZWNhdn6C7MJjX4V0g4UDPBlgC/24CBbOFlS6Js=;
 b=rsNM/6FZzcqGEXVdaOyEhLFtXqf42OuO29VMiIIhzl1awW3RrvpwJeBJfmB6nDbwpz
 OBWarzgZYEcppRAG+fO9Evb/DiOkE1Fzlkh0e7+LInnxWUj87QTneczuflG87oHT/rfc
 pDcUTcikKKzrLIqB+kliCV/lQvTRMJI8IJO/SjJaJnG70GwLTFzmZ6E3EF9sPIpZuahw
 W2EYrSg9/B4Whsw9E1JNzUps4+o5pGAyqgRq89zy5/+dvxzEmRp1agIqUoN4sFp2U+8f
 k91j7QCBPQO7PT/41/gJ5QDKPlg1d2346rg/ecPkL6cfQdxKhwgRgGFEIb+XDa7mGLUU
 X/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748237374; x=1748842174;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ylcfQZWNhdn6C7MJjX4V0g4UDPBlgC/24CBbOFlS6Js=;
 b=D7FJRulAc88anUYL3nPExUjuW9obObql5nTwOUnIwvVrKPJEneyeh14Pk3CXa7sYLb
 tn9Zygdo4DcQHqcs1QkLwl+0ZIN76SeYyLYoNCHSiXiZRD8ocMxs6jyrLtxvcJwELLi5
 vvRzzyZMDAynyf19vC1AjrDmgsN9padZFzKWmAFCmRJ9E2TzekYLmpLocHD4SXKCzTid
 Fb3T7OhOv6c+naGZZrUwvVwJz0dwZBgidQc7QIpsPBBpzH0alIN0ofafh+CRpIf87yPR
 PehBPwyr+o8VJjgGMZkB3XmLvOrR4J6S2j9m8tRbndfetNPM7C2u/80dxOZLiRV0mOCj
 Vf7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVclUlEDa5dkXduclvu8hv++nSJzwNyD1SlWnMaFEmmiDMcZRG5wM8Uh8d/Uy/yr5UzgYglHXyLdr7d@nongnu.org
X-Gm-Message-State: AOJu0YywYwpoOSGKAp6v+rIFRCTabzLagcgsAojjYY7R6RUtCsg/4Wc0
 HMgjCmYgfezP3OhrDIpNUKIQ0oeo/2uxxwy4r+/9RYuGApI3jGgnYWW8s+DvfHowCv7Qx6hd9C3
 uLxZU
X-Gm-Gg: ASbGncsG/q6Uc4BPQB0wlF5rMStgVRznaZTUCAJGu1FSIBVSeIrWez6Dg5kMIKzaAre
 yflOBKrPfyocJE3HFqlHY3vdt8vl45ISmUxOd0m9mDJkwEPEQ//bmGOGXD9PWUgjXX9jCWw9zAQ
 ElgWv6zMrhZDV12EL3U/Lj1dM6K/HGekV1qDawkdv4x71PUMLpoMUZawpth+IbfUPcEqE9Aslbh
 Cu4rVBUNdhrpX9IbrdV+cSwhQt2E1ckkfgzNfdF5diJFyIXRJRBswgLD67Jd06MDgXZ1vhOwjHc
 4SSgZyPTP+eVTuKUycvrgIa0JQQZPeMNxyIlWMlyb5yTKVilkVWT
X-Google-Smtp-Source: AGHT+IEdD0Ly+wv0LIoFBAJn7ydVZgF7NMPPSAGo1KhepTrmdYF3uSBcF/J0LJuA+Mgb8VpGG8EPQA==
X-Received: by 2002:a17:903:244a:b0:220:e362:9b1a with SMTP id
 d9443c01a7336-23414f66af8mr119065675ad.25.1748237374487; 
 Sun, 25 May 2025 22:29:34 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2340c0e72fasm39210075ad.239.2025.05.25.22.29.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 22:29:34 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 26 May 2025 14:29:14 +0900
Subject: [PATCH v4 04/11] qemu-thread: Replace __linux__ with CONFIG_LINUX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-event-v4-4-5b784cc8e1de@daynix.com>
References: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
In-Reply-To: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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
index a1b592d358c3..0d6344f4d216 100644
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


