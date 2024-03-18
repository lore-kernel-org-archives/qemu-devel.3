Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2348C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFCM-0002Mc-DB; Mon, 18 Mar 2024 11:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFCD-00029U-OQ
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:46:41 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rmFC8-0007og-65
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:46:41 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6e704078860so1811152b3a.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710776793; x=1711381593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Lh4OLW/jlfOus8yo1xuVh21qLkiyzxrn6SATs9r4I9s=;
 b=AlG/7WBdfdTaqJIHwlJ59WondobKJPcadT5RkSzYCLjHKGCgr8JTde0E2y1juQJGda
 UR2NWtcLXMIz8feAJ+mxvjqe6ubqrsadMfhuIW363iiAI3nkiPTj7+Ud+/V/cfLpyKG0
 xTT7EDJ+k+QfT7L5OnzydRpnWSe4WfdQPmlj7XkDeKok71Ls6RBDYZcp4ruMZgXnJCBq
 xhZf/S47HS3FSo+PPrk+v4FpwAW6df02FfLB7NJgdV4cKTpg1hrC5gcjH4cE8j1qhx5O
 RXdOQKNVOrSJpsBe4F4N4DUjbyqwRvtNpoAIADsjcnYVi9Zg/Felx7Uwkl9iLPZhbBo0
 /HDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710776793; x=1711381593;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lh4OLW/jlfOus8yo1xuVh21qLkiyzxrn6SATs9r4I9s=;
 b=alO/eN5IM8YEyv/1IpAderEB1OnCqqGPbKEpwrQvhDYAJ8V/UgMSK5IflanzRmrGki
 Dj7GeICANGpw1dRNcEREsGTiescnJ6SqWLSyT8730L6nz+chJ7494Va+96ar/2vVDEYB
 tabTHfqEhMn0FRKsYZ4QEE1hSCW3iqgPtQd9CwCdbFtg3mq/CDLo16rfc7y1hXHKBCoX
 3pRYeMEUoVOHxZBAD2Rka1/2LF5/NZJqqhBJn5QY5NsrWeAyR4v078UDc5vHIbhI1P6F
 Ui85A8MPPkg6QyFX2nuhgZCX3sbJ12OiWI5wqEPlky+U2HiU11ckpx/VpIkNWbueZHCC
 SY2Q==
X-Gm-Message-State: AOJu0YwPinhFI7lidt1CxtEAtvSctWtwlRDsuPmLRj0ET9jfTUGQZ4DU
 /nRJz1Xj4Ehwcu2yqDhhzIFqyKFzLrpiQohrXkuKH+cWEzB5ngQZWBJuxnmbs84=
X-Google-Smtp-Source: AGHT+IGvrc9NIK6DwrTufy1H2sG/fCFQAxevNQHUuQY3X3XCnF8v1wPHpm+1+QnR2sQ4zxjNpJfXyg==
X-Received: by 2002:a05:6a21:3184:b0:1a3:52bf:ee10 with SMTP id
 za4-20020a056a21318400b001a352bfee10mr8018363pzb.30.1710776793030; 
 Mon, 18 Mar 2024 08:46:33 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 v22-20020a634816000000b005dc26144d96sm7332108pga.75.2024.03.18.08.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 08:46:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v5 00/24] replay: fixes and new test cases
Date: Tue, 19 Mar 2024 01:45:57 +1000
Message-ID: <20240318154621.2361161-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since v4,

- Fixed a 32-bit compile bug and leftover debugging prints.
- Dropped the patch to change virtio net guest announce timers
  for now.
- Increased replay_kernel.py timeout because patch 3 was just
  nudging x86_64 test over the 120s timeout when run on gitlab.
- New patch to add a non-flaky x86_64 q35 machine replay_kernel test.
- Added some workarounds for the new reverse_debugging.py test cases
  that x86_64 and aarch64 fail on, so they don't cause CI failures.

Here are some CI jobs showing successes with replay_linux.py,
replay_kernel.py, and reverse_debugging.py on aarch64, ppc64,
and x86_64 tests:

https://gitlab.com/npiggin/qemu/-/jobs/6416485196
https://gitlab.com/npiggin/qemu/-/jobs/6416485200

Thanks,
Nick

Nicholas Piggin (24):
  scripts/replay-dump.py: Update to current rr record format
  scripts/replay-dump.py: rejig decoders in event number order
  tests/avocado: excercise scripts/replay-dump.py in replay tests
  replay: allow runstate shutdown->running when replaying trace
  Revert "replay: stop us hanging in rr_wait_io_event"
  tests/avocado: replay_kernel.py add x86-64 q35 machine test
  chardev: set record/replay on the base device of a muxed device
  replay: Fix migration use of clock
  replay: Fix migration replay_mutex locking
  virtio-net: Use replay_schedule_bh_event for bhs that affect machine
    state
  virtio-net: Use virtual time for RSC timers
  savevm: Fix load_snapshot error path crash
  tests/avocado: replay_linux.py remove the timeout expected guards
  tests/avocado: reverse_debugging.py mark aarch64 and pseries as not
    flaky
  tests/avocado: reverse_debugging.py add test for x86-64 q35 machine
  tests/avocado: reverse_debugging.py verify addresses between record
    and replay
  tests/avocado: reverse_debugging.py stop VM before sampling icount
  tests/avocado: reverse_debugging reverse-step at the end of the trace
  tests/avocado: reverse_debugging.py add snapshot testing
  replay: simple auto-snapshot mode for record
  tests/avocado: reverse_debugging.py test auto-snapshot mode
  target/ppc: fix timebase register reset state
  spapr: Fix vpa dispatch count for record-replay
  tests/avocado: replay_linux.py add ppc64 pseries test

 docs/system/replay.rst             |   5 +
 include/hw/ppc/spapr_cpu_core.h    |   3 +
 include/sysemu/replay.h            |  16 ++-
 include/sysemu/runstate.h          |   1 +
 accel/tcg/tcg-accel-ops-rr.c       |   2 +-
 chardev/char.c                     |  71 ++++++++---
 hw/net/virtio-net.c                |  17 +--
 hw/ppc/ppc.c                       |  11 +-
 hw/ppc/spapr.c                     |  36 +-----
 hw/ppc/spapr_hcall.c               |  33 +++++
 hw/ppc/spapr_rtas.c                |   1 +
 migration/migration.c              |  17 ++-
 migration/savevm.c                 |   1 +
 replay/replay-snapshot.c           |  57 +++++++++
 replay/replay.c                    |  50 ++++----
 system/runstate.c                  |  31 ++++-
 system/vl.c                        |   9 ++
 qemu-options.hx                    |   9 +-
 scripts/replay-dump.py             | 167 ++++++++++++++++--------
 tests/avocado/replay_kernel.py     |  31 ++++-
 tests/avocado/replay_linux.py      |  92 +++++++++++++-
 tests/avocado/reverse_debugging.py | 197 +++++++++++++++++++++++++----
 22 files changed, 667 insertions(+), 190 deletions(-)

-- 
2.42.0


