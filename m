Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5500FC3ABCB
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 08:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDfwA-0006DL-Dk; Sat, 10 May 2025 04:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDfw9-0006DC-46
 for qemu-devel@nongnu.org; Sat, 10 May 2025 04:52:01 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDfw6-0005bw-SH
 for qemu-devel@nongnu.org; Sat, 10 May 2025 04:52:00 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-73972a54919so2957912b3a.3
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 01:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746867116; x=1747471916;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6zUq0GiWqUMNT77WbT5wkKw+w/zwWIbdY/JyE9n7hgc=;
 b=hqBLvnYMW4+Gq2OfR07X6caWqYtOkojHH8jSobWGjK/uiIhgvTHIKORLMf5dpQlSHm
 vLJURch+8bC5dWGAntO1uBN23+jLr1atfHTk6ZmA80rQZ55BNgrswMIi5/VQNWImgWtH
 ftS7oQc1DLdeJhco5B1zohkpLC3o6b1yaLxBSa5vdi8fzZ4gsLxW7nyQ4dkbjm6lIAEg
 +mnKwURppP6lXtVkfVb+2iWv1V+AxvfpA4HDTz0HN5RgieE852zLcSBVtRg7DOuJDdFT
 9led6pmG5goDxa9RHAdwTjjzC+MdNkSijdH4VScWYr0RB2rx7fZg4/LGKQ+sp3/uvdW3
 whNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746867116; x=1747471916;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6zUq0GiWqUMNT77WbT5wkKw+w/zwWIbdY/JyE9n7hgc=;
 b=xBk8fe5vwm39Yqb3EHQu/woYCvjHKictn/nHuANQyZm6jDPBc1aMv/wWfODdFFf2YF
 8d7kHMGoDz26Kg0E2cu78S4DTH8eK00vgWMkHEUA+pw5ck6kk36ndYAArYtLOFDCTv1C
 bnvfp0im/UmdyoyqkWTQAGS/gSiWTfuXQz+w+Eey1hI/pcmJZBy+LjSN7G8fvMMJp01G
 5EtsTrIKshN8Kn/Nt5c26xvaWnrF8Ul9P8B1uU2dY5Aii4Rmr3K4jNZV1tmOkzMhAbDB
 dZstby9NiEWA9gjBoLQbIIre2TZ20EW9ARCEfYjgl70eCDqFRWa+GBjnGtKrbG7TDNEX
 aubA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgEFM3xT6oBNfiHSpT8OZhRFFTZr71BY2M6ZILlT7XGNQknvd8G/+RwOO/2dSbyYwPJRLJ17nVgZhs@nongnu.org
X-Gm-Message-State: AOJu0YyfylUJ3xGg1wrFDVGQT7OLO6DUL68xerVhMkwuOgYO/h6nBVEM
 yy5+M6TpN3J+tgoajLxfaKyyvBPT28rZb59bM1rj1u/G308kTmxeuuFLomFuXS9caWX48BzoVTS
 x
X-Gm-Gg: ASbGncv6FVDca4Sfvo1JOmvA5VxLjGaA1b8zI5AuLFuJOSqsgghmkGsYiHrhGQOdUIl
 bbDG+Ns5Bx4Zhh93hbcM5o+0jYjQA+lr/rUzaOxv9u01uM2TwvDH0nMztxnG82hzDm5H56hHRQK
 ZnJydmXRE/caPalfZtzgIhCkDefwmZB+9sr4+ZPV7RpnSYt2aC6qivvOS0tTbnJeRt0NF6fh2Rg
 +7j2PEIW3dKs/yy4mlWz39xq6n8cZN/b0MzXP/rG5GFbeFJg4VFp8vxj6U3dj4Y8wxMqJyoznD7
 v5PMO9vF0jJIZx9/Txhz+a+C9KUFmxozRp+ypY0Pco5cXFdx5Cl1W7A=
X-Google-Smtp-Source: AGHT+IEyvqYqrWsGNDHjTare65+q+UQc9CkAneex2hKIl2/i3ko3XBUKGVNUDq+c1l3o7CEzmV4CKg==
X-Received: by 2002:a05:6a00:a16:b0:732:5164:3cc with SMTP id
 d2e1a72fcca58-7423bffde33mr9623270b3a.19.1746867116096; 
 Sat, 10 May 2025 01:51:56 -0700 (PDT)
Received: from localhost ([157.82.203.223])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7423770447asm2851260b3a.32.2025.05.10.01.51.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 01:51:55 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 0/9] Improve futex usage
Date: Sat, 10 May 2025 17:51:45 +0900
Message-Id: <20250510-event-v2-0-7953177ce1b8@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKETH2gC/y3MQQ7CIBCF4as0sxYD02KJK+9hukCY2llIDTSkT
 cPdxeryf3n5dkgUmRJcmx0iZU48hxp4asBNNjxJsK8NKLFTslWCMoVF9EZbHKX3trNQv+9II6+
 Hcx9qT5yWOW4Hm9V3/QmI+i9kJaSw2jjjLy09ennzdgu8nt38gqGU8gH5pK3gmwAAAA==
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
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
Changes in v2:
- Rebased.
- Added patch
  "hw/display/apple-gfx: Replace QemuSemaphore with QemuEvent".
- Link to v1: https://lore.kernel.org/r/20241225-event-v1-0-a58c8d63eb70@daynix.com

---
Akihiko Odaki (9):
      futex: Check value after qemu_futex_wait()
      futex: Support Windows
      qemu-thread: Avoid futex abstraction for non-Linux
      qemu-thread: Use futex for QemuEvent on Windows
      qemu-thread: Use futex if available for QemuLockCnt
      migration: Replace QemuSemaphore with QemuEvent
      migration/colo: Replace QemuSemaphore with QemuEvent
      migration/postcopy: Replace QemuSemaphore with QemuEvent
      hw/display/apple-gfx: Replace QemuSemaphore with QemuEvent

 meson.build                       |   2 +
 include/qemu/futex.h              |  43 ++++++++++-
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
 util/event.c                      | 144 +++++++++++++++++++++++++++++++++++++
 util/lockcnt.c                    |   9 +--
 util/qemu-thread-posix.c          | 148 --------------------------------------
 util/qemu-thread-win32.c          | 129 ---------------------------------
 hw/display/apple-gfx.m            |  10 +--
 util/meson.build                  |   3 +-
 18 files changed, 250 insertions(+), 349 deletions(-)
---
base-commit: 4b1f5b73e060971c434e70694d571adfee553027
change-id: 20241031-event-785a2f0dda4a

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


