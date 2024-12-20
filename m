Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68DFE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaSt-0001l3-UN; Fri, 20 Dec 2024 05:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaSq-0001fu-Br; Fri, 20 Dec 2024 05:42:36 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaSo-0005BT-G0; Fri, 20 Dec 2024 05:42:36 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ef70c7efa5so1259227a91.2; 
 Fri, 20 Dec 2024 02:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734691352; x=1735296152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2KqqE2uzzrs0eOYeMQH8kfx4YKMlbk/LGQt0OEUmnbQ=;
 b=TWZGeH6WwZL2ZDmh56pJM62UMTocIQ/l7VcJ4A3nWkT9woyNsjfgUai0GMZkUgonSX
 KqC2c+xRPDclNzMXk/lmoIcuZ80XehBmbY7lnt1C/o0pmlmEv8qAGA42PWrUuL3gmLi1
 kVf5KaDv535QmW4O7E5UUdiPLIsrOUwOU4fl9MsO5arhZOIwbmJ7MvnURY38T4DfJxEq
 ZDrV4Q43Ls4BepYX5JazXRLFZYK8SVwvUq8Dgo6w5HXF+67hF4KRqaS4Fz7Kz1LNxk5T
 oU/fDOI8B+dwQP0/p3NEMMe/ZpHk1XNEQmPfObvWAUC7VpthEbQ0LZeZ9oaJdp0NHWqx
 qp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734691352; x=1735296152;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2KqqE2uzzrs0eOYeMQH8kfx4YKMlbk/LGQt0OEUmnbQ=;
 b=GSm13Dn0NsU3acDxg8H9u6Ue/RGE6nWsk5aEDQzGDuMD+0qqkInp7EPpITa15LEI9o
 ZHr8NJTk7V/EYTMO+4uFKeScu+xBg1ZSm58Y1UzMmeOW+UA/UvX9jSIY+hnmLaledXZB
 0nXajICKLOiZKmwMdnLp2HIEAU6xGKRGIKZcJYjTbjJGmmnUiYZ440fCTZPUe3rhqvS2
 vG+uFgIpFz8qbHUG4AHaYI09tRf3JVn8hV//SEcFYfQnJhm01ZcxlaDRnpZxuCAXs+oI
 1Lx2an4PUhApk1Ts2vQV2eIpRoT0TkzVyGvfkhHQxsVbttkG5DR4qzLmi4Q4MRiJ+g7J
 5AtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNOuWhBtCnKPbQsrcrU/jfvk2Dxw9ESK6/797Rmc7jhCBRq+TeVqQ6krj2hDxSh7NfrKrwrN9gSAyZ@nongnu.org
X-Gm-Message-State: AOJu0Yzyg1lA48fNejQ3pFY2+IqkrsXmwtJHMQfvV1Gi/O7p1TZRS9B0
 H23IQksq+HH/G7l+LyZG5BE4sytaH9mKkTtLI8kGgEiE+r5b4/XsCl6cmA==
X-Gm-Gg: ASbGnctW6+TskUIcp/I9oMRhyhrHc2cfSOFXUgyiZ+ksc/DlOdC1U5C8Y2tgg33G7HC
 IJg5SKmG0VhLatorDI0LHYQsvGolfXN/Rd8TbVpKME/ky30pR11hqcO5g6F2Z4+A1yQ48+aNn9y
 X9+2amGLhpGmP3dp3IAWbzD6Vi1yrzw7ocG8FkzKSItVzrFRkAgmJCuWgNf/MtBQr/Znnlcuk4t
 M3WvN+s/rgaWnPA/dIo56uFS9I3WqsvgbgT6A4EhRzuUax9e1XgoFY8//xfAavF22Setbz9icLu
 ox3x8ffWgw==
X-Google-Smtp-Source: AGHT+IE3VSyKQwocqx+4l5AtLiHz+wChHhO66obu0i6U53ZqKKN2czTdJvg8OIneUaOQfdtx5g5LPg==
X-Received: by 2002:a17:90b:50c4:b0:2ee:c9b6:c26a with SMTP id
 98e67ed59e1d1-2f452e227e8mr3730640a91.11.1734691352164; 
 Fri, 20 Dec 2024 02:42:32 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee06dfd3sm5376942a91.32.2024.12.20.02.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 02:42:31 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 00/17] replay: Fixes and avocado test updates
Date: Fri, 20 Dec 2024 20:42:02 +1000
Message-ID: <20241220104220.2007786-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi,

This is another round of replay fixes posted here

https://lore.kernel.org/qemu-devel/20240813050638.446172-1-npiggin@gmail.com/

A bunch of those fixes have been merged, but there are still some
outstanding here.

Dropped from the series is the net announce change, which seemed to
be the main issue Pavel had so far:

https://lore.kernel.org/qemu-devel/6e9b8e49-f00f-46fc-bbf8-4af27e0c3906@ispras.ru/

New in this series is a reworking of the replay BH APIs because people
didn't like the replay_xxx APIs throughout the tree. These new APIs
also have some assertions added to catch un-converted users when replay
is enabled, because it is far harder to debug it when it surfaces as a
replay failure.

These new API assertions caught a hw/ide replay bug which solves some
replay_linux test hangs. Couple of fixes in the replay_linux test case,
and now all tests are passing including aarch64 tests, see here

  https://gitlab.com/npiggin/qemu/-/jobs/8695386122

(In that run a couple of the x86_64 tests were disabled to fit the
aarch64 tests in because gitlab seems to kill the job after 1 hour
so we can't fit them all in)

ppc64 also passes replay_linux after a couple of ppc64 fixes I'll post
a patch to add the ppc64 test later after everything works through.

Thanks,
Nick


Nicholas Piggin (17):
  replay: Fix migration use of clock for statistics
  replay: Fix migration replay_mutex locking
  async: rework async event API for replay
  util/main-loop: Convert to new bh API
  util/thread-pool: Convert to new bh API
  util/aio-wait: Convert to new bh API
  async/coroutine: Convert to new bh API
  migration: Convert to new bh API
  monitor: Convert to new bh API
  qmp: Convert to new bh API
  block: Convert to new bh API
  hw/ide: Fix record-replay and convert to new bh API
  hw/scsi: Convert to new bh API
  async: add debugging assertions for record/replay in bh APIs
  tests/avocado/replay_linux: Fix compile error
  tests/avocado/replay_linux: Fix cdrom device setup
  tests/avocado/replay_linux: remove the timeout expected guards

 docs/devel/replay.rst              |  7 +--
 include/block/aio.h                | 44 ++++++++++++++++--
 include/sysemu/replay.h            |  2 +-
 backends/rng-builtin.c             |  2 +-
 block.c                            |  4 +-
 block/blkreplay.c                  | 10 +++-
 block/block-backend.c              | 24 ++++++----
 block/io.c                         |  5 +-
 block/iscsi.c                      |  5 +-
 block/nfs.c                        | 10 ++--
 block/null.c                       |  4 +-
 block/nvme.c                       |  8 ++--
 hw/ide/core.c                      |  9 ++--
 hw/net/virtio-net.c                | 14 +++---
 hw/scsi/scsi-bus.c                 | 14 ++++--
 job.c                              |  3 +-
 migration/migration.c              | 17 +++++--
 migration/savevm.c                 | 15 +++---
 monitor/monitor.c                  |  3 +-
 monitor/qmp.c                      |  5 +-
 qapi/qmp-dispatch.c                |  5 +-
 replay/replay-events.c             | 29 +++++-------
 stubs/replay-tools.c               |  2 +-
 util/aio-wait.c                    |  3 +-
 util/async.c                       | 75 ++++++++++++++++++++++++++++--
 util/main-loop.c                   |  2 +-
 util/thread-pool.c                 |  8 ++--
 scripts/block-coroutine-wrapper.py |  3 +-
 tests/avocado/replay_linux.py      |  9 ++--
 29 files changed, 245 insertions(+), 96 deletions(-)

-- 
2.45.2


