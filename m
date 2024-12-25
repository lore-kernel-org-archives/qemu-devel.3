Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CBBE7718D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 05:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQKCH-00073V-Oy; Wed, 25 Dec 2024 00:44:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tQKCG-00073N-IP
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 00:44:40 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tQKCE-0008O9-UW
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 00:44:40 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2163b0c09afso59677085ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 21:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735105478; x=1735710278;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DdexgsTRx5ghvnxfUSfjxB7Ao/P1TQJISnBHx9RM6RI=;
 b=zc6svIf0dHsW/ZOjqre8j8k8dIpc+SWYuGSiSSeTpC00unxPyHCJFjuVXFv2o466YM
 QxaHloBAOZZteoyAPZxtboKHPYZF1bfgIbhjWPbqcxg5zr5+rm9IzWpTUxDTBoDx+Pp5
 PVIUR2ENhBD4h8D8+SXFQeWUcGIhNYV50jkWIlDn5S4mBOzyhrXfGqzrhnPmyZCJpQ/7
 Dgj33H5zadcY6dfkkUbcYqqo89BEMSxlSJ5LRJRHjEFPNuBaxAnKifzctjmQyYBES863
 NVf7I3Vr6E15SMqAQmJXt4g5KamGCzn1N8amOnFHZOq0vjOZIA9kzQpDZZ0aX85w97PR
 ZRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735105478; x=1735710278;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DdexgsTRx5ghvnxfUSfjxB7Ao/P1TQJISnBHx9RM6RI=;
 b=EvOcSYg54TOloS/xPmAlFnIlY551ogdrtxICz4/k8Wqwe7Il0CnGr8W+udmc9Sjo5h
 Bek0zVH169K+09nkEQdgjYg0FqTWiX66Pkhwt/mW3S8InW/ZfmfMrs0U6LlHlzJzf/uw
 bwGyAbu03KJ5Rd3gCJJvwdpz3I+CzD58wb3FpOQTfIIvAh+rnqcIcBojxSGKdrZ0YoJk
 OUCpGc4lFMER1XttO6js8Dm57ozC/hDWCOlFXCTc6J+LwaMggo2d9/2jji0nRcuFGk1s
 ecJ2yYADvJ6yitGHlgyNRC+rP4JU9HXEhYE8G6o+YP66JNflSGLENMAY+Ug20JD85Sbb
 Zd1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNK/8QI153xtnFYY5KTUKvpeMzQcZszJRkunrwtenOsNIoufnbF6bun9YGB4plX8pD7DOGXfINZuVM@nongnu.org
X-Gm-Message-State: AOJu0YytFvLHOCe94PZenhKjWox7E6sZyokRwUyG23KPG4BwLf1nvjI5
 0tinOpSljnbRK8DxjdmTgsN57nK6X3rdCTWN6Y1b0UxYQd3jskuTYJH2GXmHWas=
X-Gm-Gg: ASbGncvbdmKgeXazGfLcvSE+3IlPxgAGt93Yte5WEWgyzOL196Iluxfk7vGTouXIyKJ
 xmELf6hRW/+VbRQVZ3swhPQw1zQZmmVZHg90vQ/QMS+Y3cPu0oXRC5FqjkwdQBHPGQGkM0bmqmX
 pim6SwcWnWq4uzSiqW7bctwtlfp73+mhaoaXKFEw+RtwAK6nEw1KwCoPbOA1JIxIOahVEtw3hfR
 jyfBU0ett2dP3PIJcMiT5khoDG7fxyQ9zC9iJKo3+nqEKfUjv8PAKXD5OIu
X-Google-Smtp-Source: AGHT+IE+XjUSs2O3Mg7yEeDLL5J5FOg1irk5lCkvlDyw4bBe2jtSD4B4YQqQtlFzGFkxTAnJNflBGA==
X-Received: by 2002:a17:902:fc50:b0:215:b8c6:338a with SMTP id
 d9443c01a7336-219e6e85ccemr284555585ad.4.1735105477745; 
 Tue, 24 Dec 2024 21:44:37 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-219dc962cddsm98695455ad.48.2024.12.24.21.44.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 21:44:37 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 25 Dec 2024 14:44:17 +0900
Subject: [PATCH 5/8] qemu-thread: Use futex if available for QemuLockCnt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241225-event-v1-5-a58c8d63eb70@daynix.com>
References: <20241225-event-v1-0-a58c8d63eb70@daynix.com>
In-Reply-To: <20241225-event-v1-0-a58c8d63eb70@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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

This unlocks the futex-based implementation of QemuLockCnt to Windows.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/qemu/lockcnt.h | 2 +-
 util/lockcnt.c         | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/qemu/lockcnt.h b/include/qemu/lockcnt.h
index f4b62a3f7011..5a2800e3f182 100644
--- a/include/qemu/lockcnt.h
+++ b/include/qemu/lockcnt.h
@@ -17,7 +17,7 @@
 typedef struct QemuLockCnt QemuLockCnt;
 
 struct QemuLockCnt {
-#ifndef CONFIG_LINUX
+#ifndef HAVE_FUTEX
     QemuMutex mutex;
 #endif
     unsigned count;
diff --git a/util/lockcnt.c b/util/lockcnt.c
index ca27d8e61a5c..92c9f8ceca88 100644
--- a/util/lockcnt.c
+++ b/util/lockcnt.c
@@ -12,10 +12,11 @@
 #include "qemu/atomic.h"
 #include "trace.h"
 
-#ifdef CONFIG_LINUX
-#include "qemu/futex.h"
+#ifdef HAVE_FUTEX
 
-/* On Linux, bits 0-1 are a futex-based lock, bits 2-31 are the counter.
+/*
+ * When futex is available, bits 0-1 are a futex-based lock, bits 2-31 are the
+ * counter.
  * For the mutex algorithm see Ulrich Drepper's "Futexes Are Tricky" (ok,
  * this is not the most relaxing citation I could make...).  It is similar
  * to mutex2 in the paper.

-- 
2.47.1


