Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC39C5B542
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 05:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJQOv-0006yl-8q; Mon, 26 May 2025 01:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJQOo-0006yK-BI
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:29:23 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJQOm-0001wX-2Z
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:29:22 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-af523f4511fso1337170a12.0
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748237358; x=1748842158;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SeeJcfOzym64rK0YYDyk4X+IvSBPeQtg/kLv7wuw5Ys=;
 b=zyYpiSO40InyJhVXtR2heNcvdZZ4fjwR4m31CRyDN4HbUoiVYlcWQia0RUDYENGIDt
 yyTCW/fVL7b/b5G3xTFluHpFPrmWZQ4yhIQo8DzuC4D6RfM06Mdaau+KtqHGwc2swRYb
 nIuJweGWKd/jzr7teLw8TT0Wa8sJzBmJE3L80x+uAnLEDBXlktLqkYM7RY/IlM6iOWyh
 Y3my9O4FVgvvnJPI3EB1JJdCM5RV3NCEOJ4ZP70diA0SPbp9NznFIv6LNcseRrF2/Gvn
 wkiUisW3yGmw1ZdPVo+AVwDlq3Lh8+WnmZJLFa/wynQl4lmqW0lGIu+ZtHbEDr874Q1b
 Np3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748237358; x=1748842158;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SeeJcfOzym64rK0YYDyk4X+IvSBPeQtg/kLv7wuw5Ys=;
 b=vRlYAIHU+6SVYVNe3YkrTteWyj16tx6cz59G7giP5UGnrhUkzvqnD4AnRoVETNjfVm
 AkwGKEywJx38wUsb+Zku0dCFBGQjIPndB+jl2SpefQRxZgLk/5jXu3OZmuChEd0Jdh+8
 og8Ut6T674LpSP0OQgcSOOSG6fH6PLgh1wtE5QxLzwrzuyl3D6O445uDDZ9K+qHaW35n
 PyLyq35FlN7PN6/4gmHp7+EhID4Ew6dQoI/0b87u9aA2so2Qgdc2/HW2I1Yx0TzD3hnk
 jtQUunyO9mYfpnltbGJ0MpYYVWuXzd57NwNyLm33GvA/q9A4BNzxtgp89lNZHuNbu8xz
 VCrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6XaicJ473kcfm2A41RBd2aU6+B/PzDE+mclRMFEK8q33KTVr7J9jWoPvS6pe3nxSrDnatYxaw646T@nongnu.org
X-Gm-Message-State: AOJu0YwtegqYtW4EISvfRY2fyCE4IZBxg7m9pezxF1PcoI+sNd/fEghC
 uvCnuI1iSvBC03QbI2voBSU05VKlbTjDAPufv3HhQ4djt3JgimO0DLNicOiuRhIIDsVsXcoLcNF
 RVVb+
X-Gm-Gg: ASbGncvgksYPoM53Ov0nc2xQsWSX/nML/YJDCJ7pDD0Pil2p4YhTkdgUN6xSx8FW7sz
 A4Tu7HWuWgGp4BvG0efYosQkg6PtEVSmt8N+EsJgCJF4lOgFDeitEQIFnU7GzkkdAuK/4XWOw4j
 o4K9tbzE6kwBOHOJkwJC2kDzdvFLyVWJjmYjkWn1PoQY/J8An8dfjWYbAS2+3SBRgdByE0WII5u
 4V/W9Nd/FAaGd7g4hs5V59W21t6qPgipjOTX/+VNPmZf4F+4Dcc4rrRcal0OO5q4d61G2QJITLg
 fefyGnVG2Sw1hyTk/DKXF9LkO8LN3t7rRN3sEu7vhIinkR7zIHlI
X-Google-Smtp-Source: AGHT+IGnIK7AEPm4Sc/etzzPbAARMxCkucwxN5c8eHQgzmEnqr4DQmVGopBXEH9zhvZpUL4BUGmIjg==
X-Received: by 2002:a17:902:ef51:b0:22e:50f6:b95b with SMTP id
 d9443c01a7336-23414f49185mr126157585ad.11.1748237357683; 
 Sun, 25 May 2025 22:29:17 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23416a0ebc3sm34474165ad.168.2025.05.25.22.29.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 22:29:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 00/11] Improve futex usage
Date: Mon, 26 May 2025 14:29:10 +0900
Message-Id: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACb8M2gC/2XOTQ7CIBRG0a0YxmL4LdSR+zAOKLxaBlIDDWnTd
 O/SahONw++Fc8OMEkQPCZ0PM4qQffJ9KEMcD8h2JtwBe1c2YoQJSjjFkCEMWGlpWEucM8Kg8vY
 ZofXj1rneyu58Gvo4bdlM1+u7wJj8FDLFBBuprXYVh0aRizNT8OPJ9g+0JjLbmSSSkp2xwlQtO
 VXKAm30H+PfbP9v5oW1qq1qJpTjhP+wZVlersLTMQkBAAA=
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x535.google.com
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
Changes in v4:
- Added patch "qemu-thread: Remove qatomic_read() in qemu_event_set()".
- Renamed patch "futex: Replace __linux__ with CONFIG_LINUX" to
  "qemu-thread: Replace __linux__ with CONFIG_LINUX".
- Reverted changes to convert rp_pong_acks to QemuEvent.
- Link to v3: https://lore.kernel.org/qemu-devel/20250511-event-v3-0-f7f69247d303@daynix.com

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
Akihiko Odaki (11):
      futex: Check value after qemu_futex_wait()
      futex: Support Windows
      qemu-thread: Remove qatomic_read() in qemu_event_set()
      qemu-thread: Replace __linux__ with CONFIG_LINUX
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
 migration/migration.h             |  12 ++--
 migration/colo.c                  |  20 +++---
 migration/migration.c             |  21 +++---
 migration/postcopy-ram.c          |  10 +--
 migration/savevm.c                |   2 +-
 tests/unit/test-aio-multithread.c |   6 +-
 util/event.c                      | 122 +++++++++++++++++++++++++++++++
 util/lockcnt.c                    |   9 +--
 util/qemu-thread-posix.c          | 148 --------------------------------------
 util/qemu-thread-win32.c          | 129 ---------------------------------
 hw/display/apple-gfx.m            |  10 +--
 util/meson.build                  |   3 +-
 18 files changed, 223 insertions(+), 343 deletions(-)
---
base-commit: f0737158b483e7ec2b2512145aeab888b85cc1f7
change-id: 20241031-event-785a2f0dda4a

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


