Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AE7C3ABC5
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 06:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDzrs-0002Bj-5o; Sun, 11 May 2025 02:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDzrl-0002BF-4w
 for qemu-devel@nongnu.org; Sun, 11 May 2025 02:08:49 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDzri-0003py-R6
 for qemu-devel@nongnu.org; Sun, 11 May 2025 02:08:48 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22fa47f295aso21563225ad.0
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 23:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746943724; x=1747548524;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dagDmNLXkyQjHnHjwR/re6YXLASaq4AnPIWxBIG7eKI=;
 b=UflGfXzgkXjTn+4yn/5FvI4VeKj/FAGvlscz/USjQ4vEAvEp+N1V1pDzjrnFT1swqa
 vJWF9pfn7+4IK/MsFLMo8GoFb+ey9CL6D3CoN9704IsWjPpArEYhln1HIvNUxUluCVi1
 87XtpZX3kj3pdP/iHJCgf1QNqPrcMrBwhn9AqXUi778WCoMl++q2fAWcBSu6Lx7Bgq8d
 E+ogp5YPCiISkYHamPM9B+xpne1vunwLgJA3rN95LsJYUghRG1b5Mh1YIFEKFQxz05Dr
 3o6p6ugWm+rNUusOnw8rhbRPHBqGpEz/6HWoN5M83cFGaW/lcbjnLo6vyerLJDJZwP1A
 hEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746943724; x=1747548524;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dagDmNLXkyQjHnHjwR/re6YXLASaq4AnPIWxBIG7eKI=;
 b=jV3wtJPVC12Uo38rkKf5OYgBPPfQAuW/AcEOvFZJ6lwFaX9MRozQVNEv+4k4a4wYMN
 YwmqfFQi53cy4MZ+gNClHR6l2iRTzYC/4VH1JIe83FGxb1P7EjJ8W/nRrK/DLMsLy622
 WpK2/oKTcDnnHREuw/DitzFA9fjjQwLSzIn1BDPsCQHeDGPUotNiL4gGn0ILnkvqWCgb
 itDEsyRMrj+eGY5AO9DoDgFrdmYKN9hq6w+5sBsiuyyyPZr60O+xJlq67jHOcbrHPpmG
 vuFl5uckzPgXkwKAg+1oXBozJ71cQj73Em1Uoz/yI/XvQ/V+5RrPCOrxsky4Y6U+LH4q
 ueUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlDjfNjlX3OdYjBNh2z6Swa4zxP/ZCRGjaaI9DkNKFMh+plCijL8f0b8cPiCqSq0FlPt7uDRE/ZsmM@nongnu.org
X-Gm-Message-State: AOJu0Yy79QQy2S2iFbjcpl2gFtx3CtdFNw7fwYg6WWcLS0qOw/AaloFs
 JL3u3YcyQJ498EeIAhub6EklQeipHGCk4WXtR+L0fSVS7ht4tYn1Z5PaOb3pplI=
X-Gm-Gg: ASbGncvfae3sHqopjBxZ+7PMbuCyO3ExeSu/A93J2jhQNYX4Vbk9SnrhSruVwjt4yY7
 ZYlgL9gIOXZgTR74aoybmrM6T96fID8kOQAleIwx36CTa1dYVxGIIZr/wPWUDZZVQBlb08/lhuw
 wG2MvCktjDHwWH7YAM6eoKAjS6BhKYvGBoB1zlK0n4Ns2dsMyWSlxWBYrTEEI8FG5kQ8lPBXdUY
 GYDRHguTDNLUyF/ZSVKtUg7oZjuDhYK3PaeV6MqTCdPElJ8L/8h5VK08SgBRGh2cRaRPgQq896y
 zTPuvO057FpZ5z/u3iFerLzSTPcdO6tD2GlqcTB7nH39vgIQtBW9NRo=
X-Google-Smtp-Source: AGHT+IFAcaYONK66krXA+wS3VqgDKRvOLHQbinbCCWxVMdat/pTQ7F1L0Yubfi2Gu6D0INt464I4sg==
X-Received: by 2002:a17:903:1b6c:b0:22e:4db0:6bf with SMTP id
 d9443c01a7336-22fc91a1e37mr128833915ad.52.1746943724219; 
 Sat, 10 May 2025 23:08:44 -0700 (PDT)
Received: from localhost ([157.82.203.223])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22fc7742e2asm41437315ad.88.2025.05.10.23.08.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 23:08:43 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 00/10] Improve futex usage
Date: Sun, 11 May 2025 15:08:17 +0900
Message-Id: <20250511-event-v3-0-f7f69247d303@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANE+IGgC/1WMyw6CMBQFf4V0bU0f1FZX/odxUdqL3IWFtKSBE
 P7dgrJwOSdnZiEJIkIit2ohETIm7EMBeaqI62x4AUVfmAgmas4kp5AhjFQbZUXLvLe1JeU7RGh
 x2juPZ+EO09jHec9mvq3fghDqV8icMmqVccZfJDSa3b2dA05n17/Jlsji0BRTnB2aKJq+Ksm1d
 sAb86et6/oB9RWMJdIAAAA=
X-Change-ID: 20241031-event-785a2f0dda4a
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

In a recent discussion, Phil Dennis-Jordan pointed out a quirk in
QemuEvent destruction due to futex-like abstraction, which prevented
the usage of QemuEvent in new and existing code[1]. With some more
thoughts after this discussion, I also found other problem and room
of improvement in futex usage. Here is a stack of patches to resolve
them.

Patch "futex: Check value after qemu_futex_wait()" ensures
qemu_futex_wait() is used in loops as suggested in the man page.

Patch "futex: Support Windows" implements futex functions for Windows.

Patch "qemu-thread: Avoid futex abstraction for non-Linux" and
"qemu-thread: Use futex for QemuEvent on Windows" enable destroying
QemuEvent immediately after qemu_event_wait().

Patch "qemu-thread: Use futex for QemuEvent on Windows" and
"qemu-thread: Use futex if available for QemuLockCnt" make the use of
futex functions added for Windows.

Patches "migration: Replace QemuSemaphore with QemuEvent",
"migration/colo: Replace QemuSemaphore with QemuEvent",
"migration/postcopy: Replace QemuSemaphore with QemuEvent", and
"hw/display/apple-gfx: Replace QemuSemaphore with QemuEvent" replace
some QemuSemaphores with QemuEvents, which can utilize futex. Some of
them rely on that QemuEvent can be destroyed immediately after
qemu_event_wait().

[1]: https://lore.kernel.org/r/CAAibmn3HZeDeK8FrYhHa1GGwc+N8rBuB2VvMRm7LCt0mUGmsYQ@mail.gmail.com

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v3:
- Fixed race between qemu_event_reset() and qemu_event_set().
- Prepared for spurious pthread_cond_wait() wakeups.
- Added patch "futex: Replace __linux__ with CONFIG_LINUX".
- Link to v2: https://lore.kernel.org/qemu-devel/20250510-event-v2-0-7953177ce1b8@daynix.com

Changes in v2:
- Rebased.
- Added patch
  "hw/display/apple-gfx: Replace QemuSemaphore with QemuEvent".
- Link to v1: https://lore.kernel.org/r/20241225-event-v1-0-a58c8d63eb70@daynix.com

---
Akihiko Odaki (10):
      futex: Check value after qemu_futex_wait()
      futex: Support Windows
      futex: Replace __linux__ with CONFIG_LINUX
      qemu-thread: Avoid futex abstraction for non-Linux
      qemu-thread: Use futex for QemuEvent on Windows
      qemu-thread: Use futex if available for QemuLockCnt
      migration: Replace QemuSemaphore with QemuEvent
      migration/colo: Replace QemuSemaphore with QemuEvent
      migration/postcopy: Replace QemuSemaphore with QemuEvent
      hw/display/apple-gfx: Replace QemuSemaphore with QemuEvent

 meson.build                       |   2 +
 include/qemu/futex.h              |  44 +++++++++++-
 include/qemu/lockcnt.h            |   2 +-
 include/qemu/thread-posix.h       |   9 ---
 include/qemu/thread-win32.h       |   6 --
 include/qemu/thread.h             |  11 ++-
 migration/migration.h             |  16 ++---
 migration/colo.c                  |  20 +++---
 migration/migration.c             |  29 ++++----
 migration/postcopy-ram.c          |  10 +--
 migration/savevm.c                |   2 +-
 tests/unit/test-aio-multithread.c |   6 +-
 util/event.c                      | 148 ++++++++++++++++++++++++++++++++++++++
 util/lockcnt.c                    |   9 +--
 util/qemu-thread-posix.c          | 148 --------------------------------------
 util/qemu-thread-win32.c          | 129 ---------------------------------
 hw/display/apple-gfx.m            |  10 +--
 util/meson.build                  |   3 +-
 18 files changed, 255 insertions(+), 349 deletions(-)
---
base-commit: 4b1f5b73e060971c434e70694d571adfee553027
change-id: 20241031-event-785a2f0dda4a

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


