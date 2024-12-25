Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D8CE7718F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 05:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQKBz-00070Z-Vg; Wed, 25 Dec 2024 00:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tQKBy-0006zF-1v
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 00:44:22 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tQKBv-0008Fx-Co
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 00:44:21 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-216426b0865so59242045ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 21:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735105457; x=1735710257;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mWw9J2Wu8ISxZruTkl74E7CloTmonfbuAu7CXvKpT7o=;
 b=frUnCYHYbJQhv2WhncUIH0i2SMwq7dBVlgvC9U+Rmbhnx2/DuXJZk7oKeQsCd/61Rb
 0H/alZLhlzwRseS/hc4elSfH1Jk5QG9JDtE7xbp3dyZiUJuDZNOOZnoP4mJ5wgvHfYde
 eXqGFaTNC8CxSkNpqU7g/aLd8K4ABQ+CKML4gRnu9nYEBp6LaNoZYT0T4WflGQMpLGVV
 qhba8WLfPWfVw0BaTH7u4eNBmWRTmLG/8J9vBW1O+7yhBwKnIgbm8rFh1ov15vBDPtX2
 xKhJsxipa+P+JvfXGSva66YRK4WHiix2RYDpNlybwP3lO7bQBzLsBybOWzX8+Qlts0z3
 39aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735105457; x=1735710257;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mWw9J2Wu8ISxZruTkl74E7CloTmonfbuAu7CXvKpT7o=;
 b=MdSi1EegTvIp8Ssmpo95zvOkfh2AGmNkwpmlRhx1YmKY5q58WcEuTHDbzr8XgLDiu6
 5zhTCeRuS5P8U82NTC2IrirjaCnDNR11/TTJYm6fNEwZA7ypEzMSvPfnykkHCfxeIG5E
 U5JOrnkpTnihBncsVzeaCfl4BbQivF1dBvfbQfTm+JznWU+NBhprTDxszEtuCe7HjCYT
 eBchOd9pJ/sJk+29ZBU1YuVYaCfkxmyhvfoNAc6w0kw+iyCe59ucQpa9UkOLg0FKQcGn
 W065g1uPMNzrrZHKZS3vOWmrzlKq3KCEUZ2EBoTBQOx5Au6ECSdJXpJ+i4xBr4MNKVb1
 N+eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXz9TjsOznQRuKGcF6YmYD6RU3AbufGNcuz/xQXFYGAuB73umstRbY/nrhan9Hj7x3nEnbvf2O1NZxt@nongnu.org
X-Gm-Message-State: AOJu0YwIEcwrHGzle/HKg2iS7UshkxqBz22D90x9wkricxwLhczow+/D
 /awnwpahdefN1v5YZqfaIF+gch/t3fVZLWAzaA0QKZ3zBXYJTfNwx3qzUH8zW1M=
X-Gm-Gg: ASbGnctASfySHR32nZkn6ewkkqQIx5hEeF04oCUnItXAXdFbGm/5BC3uv4UUFfrzNyq
 9Bbxutcn0kCOp7OnLb5JXtqbi3Iz26HAptiNmrnKTidKXYKu5w2lFHmdVsb5W47R4U+wAmL1cYx
 FY8IuNf59pMfdLjEoTMaYMN0AYm/VtKHoB2a54QAK9raYnltPdXDmskcXoaa/5XyOaIz3IJiqJV
 ydvH3BWu2c4WTgKTw9lFW9NX6UUmdHyPe0c5YQHrNZI7cJ8EhGKPj9lA12M
X-Google-Smtp-Source: AGHT+IHcue3Pfrlp8TM1or2ac1uC+jKTQIe+UbFp+9WAnth4Iemhy4ucRBC4hS7DAyed1dg13gsuag==
X-Received: by 2002:a05:6a21:900e:b0:1db:ec0f:5cf4 with SMTP id
 adf61e73a8af0-1e5e081c8bbmr29611872637.39.1735105457628; 
 Tue, 24 Dec 2024 21:44:17 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-842b84fb8d1sm8160340a12.37.2024.12.24.21.44.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 21:44:17 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/8] Improve futex usage
Date: Wed, 25 Dec 2024 14:44:12 +0900
Message-Id: <20241225-event-v1-0-a58c8d63eb70@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKyba2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA2ND3dSy1LwSXXML00SjNIOUlESTRCWg2oKi1LTMCrA50bG1tQCh7p4
 VVwAAAA==
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
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
"migration/colo: Replace QemuSemaphore with QemuEvent", and
"migration/postcopy: Replace QemuSemaphore with QemuEvent" replace some
QemuSemaphores with QemuEvents, which can utilize futex. Some of them
rely on that QemuEvent can be destroyed immediately after
qemu_event_wait().

[1]: https://lore.kernel.org/r/CAAibmn3HZeDeK8FrYhHa1GGwc+N8rBuB2VvMRm7LCt0mUGmsYQ@mail.gmail.com

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (8):
      futex: Check value after qemu_futex_wait()
      futex: Support Windows
      qemu-thread: Avoid futex abstraction for non-Linux
      qemu-thread: Use futex for QemuEvent on Windows
      qemu-thread: Use futex if available for QemuLockCnt
      migration: Replace QemuSemaphore with QemuEvent
      migration/colo: Replace QemuSemaphore with QemuEvent
      migration/postcopy: Replace QemuSemaphore with QemuEvent

 meson.build                       |   2 +
 include/qemu/futex.h              |  43 ++++++++++-
 include/qemu/lockcnt.h            |   2 +-
 include/qemu/thread-posix.h       |   9 ---
 include/qemu/thread-win32.h       |   6 --
 include/qemu/thread.h             |  11 ++-
 migration/migration.h             |  16 ++---
 migration/colo.c                  |  20 +++---
 migration/migration.c             |  33 ++++-----
 migration/postcopy-ram.c          |  10 +--
 migration/savevm.c                |   2 +-
 tests/unit/test-aio-multithread.c |   6 +-
 util/event.c                      | 144 +++++++++++++++++++++++++++++++++++++
 util/lockcnt.c                    |   9 +--
 util/qemu-thread-posix.c          | 148 --------------------------------------
 util/qemu-thread-win32.c          | 129 ---------------------------------
 util/meson.build                  |   3 +-
 17 files changed, 247 insertions(+), 346 deletions(-)
---
base-commit: 34754a3a627e1937be7f3daaa0c5e73d91c7d9b5
change-id: 20241031-event-785a2f0dda4a

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


