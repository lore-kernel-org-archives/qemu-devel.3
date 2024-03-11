Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5994C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjdm-0002Pt-Oi; Mon, 11 Mar 2024 13:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjdk-0002PQ-56
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:40:45 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjdh-00079p-4x
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:40:43 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e5a232fe80so3135031b3a.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178838; x=1710783638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HsCaEMKCnbNOVqyHg/O2IxFK4K/IVuc67DpDBDgJ5L0=;
 b=nZHUaDGqUGFIloXG8Ee7Sdvcpyn24vtPLuoyMi6szVruRPB4GCko6sYPEdeCIue5P2
 +3PeVoonUDUYCua+EMm72LdIRT8W18Q7ha7BEAStxtmDfl11Icmc7MaO/v6NI8Z130/C
 nTrw7camZHtEyTtkihQtm3UgJR8jjOhhizYmnojOhTfS7lWpMtsEkrnS6EafWhvNcNfy
 7C9NF2ixuaCyGuby13PjaKT1qOFedQR+kLbameiulfZ8A7hfAzasntoTpHtSNb1zBuG6
 g5P3XTX9PpHTCsw/O6fVhowBdgvub9LNUfdPsH7mgn6STKEIOAwDz+GycntEPxfETbY1
 TIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178838; x=1710783638;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HsCaEMKCnbNOVqyHg/O2IxFK4K/IVuc67DpDBDgJ5L0=;
 b=v3QBUjJXe5iI/aXAWp1cqt7GUO4RYcA28lpEDV8T5XLo55gQprt8HgtL4lonOEcWd3
 OBZx0TZsbRjU5FPIGkdey94u2E7tETPLsjXNDT01nTfXyVlP9+hfcu2wEUOuFhQClgPr
 sHtVHnr1DnFE8IrCxdl5FC0Iei+XQw4Rnskpj7Rrtyi3svnwA7j8ZDC2HNT2UPBfhQp/
 guq9vKWmP5c72YCnWGWmtXVOskNE0wDH9UHte8TVnTiRRknlOV1UmuTo39AcjWt+Hk26
 LwbR6aAfq6h61MOWcaqx9mx+Fctp6hMG/JQ7LRrzkI1pevLCZbtott1Aghue27/LrTjh
 f8Zw==
X-Gm-Message-State: AOJu0Yxh3RNnlR8N+T1lzwxxQdagxDXpjP1itaJWBjcf3PcrvdqqV95z
 RXXnHSwfuBNz8E5ISTwVbkBRd+LKk4mGLUJRFbWlolUHrhnqLQnAwf6d50Xwhcs=
X-Google-Smtp-Source: AGHT+IHVBtX9Jr+V/dEo59TqwgJhARsbSK/WVJOKzvSsdnhdmzt2bPoLWzqG0kQghnFtYofVZkyE0g==
X-Received: by 2002:a05:6a00:92aa:b0:6e6:66b1:654f with SMTP id
 jw42-20020a056a0092aa00b006e666b1654fmr11626343pfb.15.1710178837839; 
 Mon, 11 Mar 2024 10:40:37 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:40:37 -0700 (PDT)
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
Subject: [PATCH v4 00/24] replay: fixes and new test cases
Date: Tue, 12 Mar 2024 03:40:02 +1000
Message-ID: <20240311174026.2177152-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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

Since v3,

* Attacked the replay_linux.py bugs and found a bunch of gaps
  in networking that was causing the hangs.
* And several powerpc bugs that were also causing problems on
  pseries.
* Added ppc test to replay_linux.py now that it's working.
* Found several crash bugs in record/replay vs migration.
* Added snapshot and more stepping tests to reverse_debugging.py
* Addressed comments in auto-snapshot code.
* Added auto-snapshot test case.
* "Solved" x86-64 issues in test cases by switching to q35, which
  seems to have less problems.

The last 3 patches I will take in the ppc tree, but included here
because powerpc is the only one that survives the record-replay test
with auto-snapshots at the moment.

Thanks,
Nick

Since v2, here fixes became less minor so I rename the series.

https://lore.kernel.org/qemu-devel/20240125160835.480488-1-npiggin@gmail.com/#r)

* Found several more bugs (patches 5-8).
* Enable the rr avocado test on pseries and aarch64 virt since they're
  passing here (and on gitlab, e.g.,
  https://gitlab.com/npiggin/qemu/-/jobs/6253787216,
  https://gitlab.com/npiggin/qemu/-/jobs/6253787218).
* Updated replay-dump script to John's feedback.

x86-64 still has issues with replay and reverse debugging tests.
replay_kernel.py seems to be timing dependent -- after patch 5 I
had it pass 30/30 runs, then the following day 0/30 and I realized
I had several other QEMU instances hogging the CPU which probably
changed timings. So the first thing I would look at is timers and
clocks. pseries had some rounding issues in time calculations that meant
clock/timer were not replayed exactly as they were recorded, which
caused hangs.

Thanks,
Nick

Nicholas Piggin (24):
  scripts/replay-dump.py: Update to current rr record format
  scripts/replay-dump.py: rejig decoders in event number order
  tests/avocado: excercise scripts/replay-dump.py in replay tests
  replay: allow runstate shutdown->running when replaying trace
  Revert "replay: stop us hanging in rr_wait_io_event"
  chardev: set record/replay on the base device of a muxed device
  replay: Fix migration use of clock
  replay: Fix migration replay_mutex locking
  virtio-net: Use replay_schedule_bh_event for bhs that affect machine
    state
  virtio-net: Use virtual time for RSC timers
  net: Use virtual time for net announce
  savevm: Fix load_snapshot error path crash
  tests/avocado: replay_linux.py remove the timeout expected guards
  tests/avocado/reverse_debugging.py: mark aarch64 and pseries as not
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
 chardev/char.c                     |  71 ++++++++----
 hw/net/virtio-net.c                |  17 +--
 hw/ppc/ppc.c                       |  11 +-
 hw/ppc/spapr.c                     |  36 +-----
 hw/ppc/spapr_hcall.c               |  33 ++++++
 hw/ppc/spapr_rtas.c                |   1 +
 migration/migration.c              |  17 ++-
 migration/savevm.c                 |   1 +
 net/announce.c                     |   2 +-
 replay/replay-snapshot.c           |  57 ++++++++++
 replay/replay.c                    |  50 ++++----
 system/runstate.c                  |  31 ++++-
 system/vl.c                        |   9 ++
 target/ppc/machine.c               |   4 +
 qemu-options.hx                    |   9 +-
 scripts/replay-dump.py             | 167 ++++++++++++++++++---------
 tests/avocado/replay_kernel.py     |  11 ++
 tests/avocado/replay_linux.py      |  97 +++++++++++++++-
 tests/avocado/reverse_debugging.py | 176 ++++++++++++++++++++++++-----
 24 files changed, 635 insertions(+), 192 deletions(-)

-- 
2.42.0


