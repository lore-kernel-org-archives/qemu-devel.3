Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED19AC5B549
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 05:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKW5m-0002wW-6z; Thu, 29 May 2025 01:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW5g-0002ve-Fg
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:08 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW5a-00039B-L0
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:08 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-74264d1832eso477466b3a.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 22:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748497560; x=1749102360;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5MQNLV1SbvkmWGBHZePeaWM00yWHooS2WBWQz3++P/w=;
 b=u5zTzJrvPXyfHiYab2I9VEy3rvshFT43h7fq///nbfthcgkmRe7yanwjuIPUcZ6yE8
 LnT9qvkomKHd2xLIRT8RGuO95SBHzEIgqkEbWRysZrfItrHBARBsPAkWI5zSLT/8J5+S
 kcnETDsNa8t8U+8puWy43lG+erPRpi3GU0fjL752HNCaQLEP1VVEWuYpF2pMS6n5EJ8o
 M/6d/FWLOovI6j0As+rYG7Sre1zw0Z/hkuL4m/xNc2OgNSHlPLb/5NANchlrtuiENFWs
 FaOS4xGW2KmEOMsUELEp6CT3Xw7RmcFySmnrJ9F1rzYpaDVMx/k6XSxPxWoEj63m2mOF
 2CXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748497560; x=1749102360;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5MQNLV1SbvkmWGBHZePeaWM00yWHooS2WBWQz3++P/w=;
 b=BWh1bK03sBR2xYDRJ0Lb9aNacRhzsIPqz+V+JpcA/n7qMkMUO2B0AD73hjDdn9xzU+
 CVZauBcN1l7bzc3N8Hg9LQGEKt2w+MpHLjgc/T9PV0XSNe8O/vL5t9+yyYU2gteZkyK5
 yoJJhP9aTtuxDFClqjIlCNCbZk1SzL4LpxCxOWAv0Dg05TlspQwap94mGYBpBGowCG6x
 yi9NRqxYWaLzFEW6dKB8gwJcLy0ze5LLjcI0pkr8/t9MpNiG8jOhFP4IMqRAnfXIw6oC
 SgiBDMzoGIxuZJD7xwkBlobLg3ChibeNjphs0QxNiHgG8IrLK1nwuy39wulLkdDn8Fgw
 khGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNkhre1JAfQRtYV/PKrxuZC3dqq0m9XTV1CRzTmq+zjphvnviA9yMNnI5hzfgrNHY6VpYWYSi8lTY2@nongnu.org
X-Gm-Message-State: AOJu0YxuWOygWUJkKkQyka2Mo6wup7SYiFarOWNRFsV0Xa+otNY0SNbL
 mBvEo/MXEyYiHzl5nr6sV1w1TQC/r/5+CxNhhi3ZmN2XWLZDAqf204MOqjW1NAicubg=
X-Gm-Gg: ASbGncvHeeH3mjW2fHnGH76XXcOvjVeMClq5m2j8yaFy8QgAjqSS8oqiEv+MWfH8gwy
 7NeglJ+2ELGwBrJwR7v7OVrIWR/6qn9WPaxStHerdKCxeAPAgJg7J+z1YmAA1v769PJCpZZcaYp
 0LaSHmpzwskGOAeqPpouxsDcS8eiYOp93Oaaf4n76UR3UC0xsMr0EEC2Am/dEyvFk5Hg2ZQMA+s
 12JDnOI62L0peMQdEQaAT5VNTQ+bFoAJxV24vksxYcC//Y5LMEcOAX7Uq+gs631ZuflpVGWwWVn
 LQU4hNK3bqjNITM2+h0XR8KojIWNdOZ5IBP/i1elWQCRVKdTICLWtfC4Wl/2EBI=
X-Google-Smtp-Source: AGHT+IEBkCYof5DYaP7xucctYbxZ0dc6PMoubeh+39P2PJNSXBb9Ipbu/Klo8uZPwzqA2lFHinZJ4A==
X-Received: by 2002:a05:6a00:2443:b0:742:b3a6:db16 with SMTP id
 d2e1a72fcca58-745fe058d5amr29426870b3a.20.1748497559910; 
 Wed, 28 May 2025 22:45:59 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-747afff73fbsm544998b3a.162.2025.05.28.22.45.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 22:45:59 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 00/13] Improve futex usage
Date: Thu, 29 May 2025 14:45:49 +0900
Message-Id: <20250529-event-v5-0-53b285203794@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI30N2gC/2XQTQ7CIBAF4KsY1mJggIKuvIdxQWGqLGyVVlJje
 nfxh6Smy0fme5nhSXqMAXuyWz1JxBT60LU5qPWKuLNtT0iDz5kAA8mZ4BQTtgPVRllomPdWWpJ
 nrxGbMH56Dsecz6Efuvj41Cb+fv02AKhfQ+KUUauMM74SWGu29/bRhnHjugt5VyQoTDHFWWGQm
 d4qwbV2yGuzYGLOyr5JZNboptqC1F4wsWByxqAqTGamam2kcwa5xz82fQ+PeLvnfxt+10/TCy6
 YkDJVAQAA
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
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
Changes in v5:
- Updated the documentation of the state transitions for the non-futex
  variant.
- Placed patch "qemu-thread: Remove qatomic_read() in qemu_event_set()"
  after all other code changes.
- Added patches "qemu-thread: Document QemuEvent" and
  "qemu-thread: Document QemuEvent memory ordering".
- Link to v4: https://lore.kernel.org/qemu-devel/20250526-event-v4-0-5b784cc8e1de@daynix.com

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
Akihiko Odaki (13):
      futex: Check value after qemu_futex_wait()
      futex: Support Windows
      qemu-thread: Replace __linux__ with CONFIG_LINUX
      qemu-thread: Avoid futex abstraction for non-Linux
      qemu-thread: Use futex for QemuEvent on Windows
      qemu-thread: Use futex if available for QemuLockCnt
      migration: Replace QemuSemaphore with QemuEvent
      migration/colo: Replace QemuSemaphore with QemuEvent
      migration/postcopy: Replace QemuSemaphore with QemuEvent
      hw/display/apple-gfx: Replace QemuSemaphore with QemuEvent
      qemu-thread: Remove qatomic_read() in qemu_event_set()
      qemu-thread: Document QemuEvent
      qemu-thread: Document QemuEvent memory ordering

 meson.build                       |   2 +
 include/qemu/futex.h              |  44 +++++++++++-
 include/qemu/lockcnt.h            |   2 +-
 include/qemu/thread-posix.h       |   9 ---
 include/qemu/thread-win32.h       |   6 --
 include/qemu/thread.h             |  40 ++++++++++-
 migration/migration.h             |  12 ++--
 migration/colo.c                  |  20 +++---
 migration/migration.c             |  21 +++---
 migration/postcopy-ram.c          |  10 +--
 migration/savevm.c                |   2 +-
 tests/unit/test-aio-multithread.c |   6 +-
 util/event.c                      | 139 +++++++++++++++++++++++++++++++++++
 util/lockcnt.c                    |   9 +--
 util/qemu-thread-posix.c          | 148 --------------------------------------
 util/qemu-thread-win32.c          | 129 ---------------------------------
 hw/display/apple-gfx.m            |  10 +--
 util/meson.build                  |   3 +-
 18 files changed, 269 insertions(+), 343 deletions(-)
---
base-commit: f0737158b483e7ec2b2512145aeab888b85cc1f7
change-id: 20241031-event-785a2f0dda4a

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


