Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5524C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWND-00021o-Bw; Mon, 26 Feb 2024 03:30:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1reWN9-00020Z-9c
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:30:03 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1reWN7-0005Q5-Jn
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:30:03 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5d8b70b39efso2971696a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708936199; x=1709540999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zTjp6ZRVTm6BScbQMSvmnjcDONBbmN+EU/1fd15iY0I=;
 b=donS4Wk6Ok92iagHLU4syPmVqt82eLZgX4OiPCaHxOq5JFHkcNTqYpcOHYfxgQADZe
 m72jdM0Nth4ChpgM+GuItqf0huoqEhHLxw1m4LYl5rvfltFp33dKK4c/lu6oscbNaacI
 aLnKJDuzFEsv4nUMvnoJBNxq/2KDFDgiMsdrPLym7xEsPlFOA4eSs5ayB9B4fml6LpPZ
 CufQnBBSDkrmQ/jBXb3gqbePSCSe0jZGkcqGSxLEWw85dt3kAq/RAvVe5n3cqQDEPVtU
 vqadWEVkHr2zGOefSKSn5m6ZK788YjutbT/FS065MSIbqQ5gacwnCo9qzR4B2maDVaXX
 O+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708936199; x=1709540999;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zTjp6ZRVTm6BScbQMSvmnjcDONBbmN+EU/1fd15iY0I=;
 b=Zb4wk1UUw2cFLGdWCLI3etDygqYE0HVkmKSgbjdL1xOrQR4GxEdei3C8DH8ksUDwe/
 bNXuwrVyn831arFzDYXpYe36M7Jdf0G3C2CHcf5NNa1nYcph0btkMindgwn6R6Idp26M
 9tNI2R7tFFxCogWN1u5igtQA5CQ0UQB5wyhOsGv8npB5l+ymWUykgXA923xx5XwY26ZI
 HVPApYiJmsfKNXT2dhgyjGE+8gRA0xg7LVyX+pM5j3xw/Y1F71npG1/CVg8bzsEkcfNq
 Ddw4r/CSpU5RMptvgvZg6sOZ1Y3P5EFHJ78x/7prtGwwJMsFXXB77fsRy3ed29Z7Fg8j
 DonQ==
X-Gm-Message-State: AOJu0Yx19e42acs9i+04ist70GcjlUJApiNqM0dRljoBu1aImyH3gTND
 CTs6CShvkxsDasIz7TD3VVdDxdIpyWXxEcC7AOgw8Lj4GFkIhf1ul1CAdqJe
X-Google-Smtp-Source: AGHT+IFQIxFxJHClYDmgv1WAOt9F6G3NmNOQn9czj+91OiVVIx0i882+hRxvpVP72Ie5vLfBuVQM3g==
X-Received: by 2002:a05:6a20:12cb:b0:1a0:e089:e25e with SMTP id
 v11-20020a056a2012cb00b001a0e089e25emr5293590pzg.46.1708936199226; 
 Mon, 26 Feb 2024 00:29:59 -0800 (PST)
Received: from wheely.local0.net ([1.146.74.212])
 by smtp.gmail.com with ESMTPSA id
 w16-20020a1709026f1000b001d9641003cfsm3511260plk.142.2024.02.26.00.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 00:29:59 -0800 (PST)
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
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v3 0/9] replay: fixes and new test cases
Date: Mon, 26 Feb 2024 18:29:36 +1000
Message-ID: <20240226082945.1452499-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x534.google.com
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

Nicholas Piggin (9):
  scripts/replay-dump.py: Update to current rr record format
  scripts/replay-dump.py: rejig decoders in event number order
  tests/avocado: excercise scripts/replay-dump.py in replay tests
  replay: allow runstate shutdown->running when replaying trace
  Revert "replay: stop us hanging in rr_wait_io_event"
  chardev: set record/replay on the base device of a muxed device
  replay: Fix migration use of clock
  replay: Fix migration replay_mutex locking
  tests/avocado/reverse_debugging.py: mark aarch64 and pseries as not
    flaky

 include/sysemu/replay.h            |   5 -
 include/sysemu/runstate.h          |   1 +
 migration/migration.h              |   2 -
 accel/tcg/tcg-accel-ops-rr.c       |   2 +-
 chardev/char.c                     |  71 ++++++++----
 migration/migration.c              |  19 +++-
 replay/replay.c                    |  23 +---
 system/runstate.c                  |  19 ++++
 scripts/replay-dump.py             | 167 ++++++++++++++++++++---------
 tests/avocado/replay_kernel.py     |  16 +++
 tests/avocado/replay_linux.py      |  15 +++
 tests/avocado/reverse_debugging.py |   9 +-
 12 files changed, 233 insertions(+), 116 deletions(-)

-- 
2.42.0


