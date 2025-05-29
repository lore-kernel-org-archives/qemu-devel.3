Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57FDC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 05:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKW6L-000373-VX; Thu, 29 May 2025 01:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW6B-00034F-6u
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:39 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW69-0003Dm-9B
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:38 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-310cf8f7301so434224a91.1
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 22:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748497596; x=1749102396;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zcXBpjTHPNeeSaV+SDkbnQDyNsA4TkuiYdbQXIhIDo8=;
 b=LWFHFdLsz5ReaFxoPA1qg9I4Kvn++JDmXk0CtbecPvpfXIN6hmBagL9KtWj1GCx+My
 Dksg2ddO7TbI00naJ5zDOJvEwGD9cYTy7/7Ztsf90s9kZXUNwlcfn0Bt33BKFmOs4LGN
 qiRlGS7TDRk3LBkTa4cprXHBGXOu//PG0xeb8+igWSR7YzAjH/lVN+tmCJLxkDc5OEvM
 HuVrw/WQVplbbWRDbGqj04ijVtWedLmVojutEllCSmkFphzxDDyEpJEPlTKWOXS4F76N
 IhPl0/3nTW0iwqAR09RDaJr0UrfZpwL6CctjGcjQBO3J9W4NCr+lzSaB4crnAlaB8d2M
 IEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748497596; x=1749102396;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zcXBpjTHPNeeSaV+SDkbnQDyNsA4TkuiYdbQXIhIDo8=;
 b=Qg+EduiWj4PudDcbUokZx8W56mBIC4GY4L8uAeeAxP9u1JVSu673BKAoBrF+v/99F7
 F79SdeY58P5yPnVUK0XU1LW56NSr2ABfFwQ4CAooW5qT5EqTW+zPUIj9Y8G4PKJtONz7
 0e7ntDoRf4Gxyl4+mb9jDP+44W72gXelqwh2+L0J+5c+0Lc4F/q5nfQQsbPNx2ItKNVB
 Fxi5DdVSm1rbrTY+41lgUNsm1k5I+dT7xq552mUYCxbPM9+jCbkr/zkUEonbQhquoOZC
 zWBEQ/Nx3jpTBZqVp8isma/vA2A4gIUxvCGlTkhHY+Xa3yrCA7PxUHKnTNvgMOrFo3KM
 uXfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWpx56SeRp43mgwOib6dhb0KxbW8Hr/KcLxKt0njlFuXP1yYE8Qy/ns5prqp9kl8WhVHyAhZ4lJcEp@nongnu.org
X-Gm-Message-State: AOJu0YyRDsN+MFm75J93FUqBVtJ7mWnxJAU2X/xVOHYFYYWhp3WJnbuA
 YCpXISUI0/DKALzttKXW3qt601329ZhxAh8j76j6ykRtyTW/1AcfPP5AOUJKerjg6dw=
X-Gm-Gg: ASbGncuqbdC41HgxfQfP2SMg+wn4Te1e7OTLtNDRWjfUyJ1pX75OWv89cDYJfa0Gj6C
 /v+aRYU72eeNgYPqs6i/CgSpUwfHPI/uHFzQ696bEygFU4g3SoPmFTSgUjD6oqvUI+fEt1oVYFN
 gU+24KxMj9Z+BN2aey4x/ftjMXsgnp03zi2nXo8X93TawX27GTt0f0/6EkvCJsF5kAKyRmNkkWH
 0e3rhgbMjTID/2jDyx5MgZX64xbh5FAdBM4LyrQp0EMreSOAr0/nwdZ1C0dbk4RkB0U+3GydRw5
 uI5nuA+sM3xBzZcyFAlC1XgjVECOoUXIlW2lOG8hYtURYpFsxXrh
X-Google-Smtp-Source: AGHT+IEfbEv7t24Tj9e6sN3FwDLlIg19PxaHiqPP1FnX+c3EPYstUl4tFFykwY2pmoQc9GRETOlkCg==
X-Received: by 2002:a17:90b:2e04:b0:2fa:562c:c1cf with SMTP id
 98e67ed59e1d1-31214e1228dmr3591766a91.1.1748497595494; 
 Wed, 28 May 2025 22:46:35 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-3121ba3e4f9sm597141a91.42.2025.05.28.22.46.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 22:46:35 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 29 May 2025 14:46:01 +0900
Subject: [PATCH v5 12/13] qemu-thread: Document QemuEvent
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-event-v5-12-53b285203794@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102e.google.com
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

Document QemuEvent to help choose an appropriate synchronization
primitive.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/qemu/thread.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 573f8c9ede20..f0302ed01fdb 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -10,6 +10,16 @@ typedef struct QemuSemaphore QemuSemaphore;
 typedef struct QemuLockCnt QemuLockCnt;
 typedef struct QemuThread QemuThread;
 
+/*
+ * QemuEvent
+ * =========
+ *
+ * QemuEvent is an implementation of Win32 manual-reset event object.
+ * For details, refer to:
+ * https://learn.microsoft.com/en-us/windows/win32/sync/using-event-objects
+ *
+ * QemuEvent is more lightweight than QemuSemaphore when HAVE_FUTEX is defined.
+ */
 typedef struct QemuEvent {
 #ifndef HAVE_FUTEX
     pthread_mutex_t lock;

-- 
2.49.0


