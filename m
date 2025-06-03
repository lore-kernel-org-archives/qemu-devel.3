Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7644CC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPPP-00083X-9j; Tue, 03 Jun 2025 07:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPG-0007vQ-4Q
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:13 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uMPPE-00029q-7d
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:02:09 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-602e203db66so9458115a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748948526; x=1749553326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KSCR9Zn1xzSUAQGDM52JddqlPoeyuF15P7dYaTm1EMQ=;
 b=PvYF7mUX12YtljV6QdnqHwGKiCn1RwtCG5R1e8XzfABcx50cPmk6SqwDpxf2vO0N+p
 lLuOnKJHCQr15kfQAW5+crvJdcoNJ1w76zXupaRqKu6lMBzk5TMqIK0LmemvSA1JbDJw
 fY11wu5sixItpeLlslzXiWfrZGnaWgcxeWqqg4TcwrKJChETTU2Y5WTgoFMMPfdD+/Uw
 +JHw9AyPStICK7kNidj7hy0MDlH4tjYO0oUkayVXFCjWT0MSM24Bh0hbgSY63nF3lTKc
 rEUfEqLIn1T4ba0sw1N6AhPmJKLQZ8nhgCEVDXJHX0uRjkDYq2qKSJ4FHNhe/usMKmZG
 pZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748948526; x=1749553326;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KSCR9Zn1xzSUAQGDM52JddqlPoeyuF15P7dYaTm1EMQ=;
 b=IKBejgHUmUyEQgw2ahwFj0gM8EyEHoMMyl3k9ZCTVrfh3enJBsnrxAWW/VMRsQAb95
 4EIDNdNv0xKuUxOFFsPKOriyFK7ig6RiS7NqE5iwSBWTFrlCMMSvGpMxBqrbssB2KbzS
 NaUbrDhUp7emhU7JSJN6qTDRw0CT6BXBnDn8kZMEMTnXgZ1oxijcYcJfXa3v2P/yV1EH
 jkCfFo08rN1cKakct9bRP3pA5kc1NfdMHrxTqkkmEgCeEzfUIRccNo/HoBfTCC5TclpC
 NELCP3dCRo4O7suFLDC6xovuvIq3RPPsFpZk/I2Mzor9r2C7GaST3TYmCduT2f5cz2Hu
 ABbA==
X-Gm-Message-State: AOJu0Yz2NYPOwj7yKfxOqBuPUx4ECe8HDgpagGIK243tU7hkL/KTRUHD
 dFEE7AEGRee1rmYRXJ4UTZ7Emk4v5Cg3RhCGYPsu+gEOIgO6hfCp3JFyrfLJbOK3+Rw=
X-Gm-Gg: ASbGncs8XegC4uMrUiHOm8Wz1WrD/zepx3OUuklH/pl1sosvlLw0u/wqxtz/qSxDQav
 mz0gZUUW4oCiZ4Q1Q0wf1C0jNHxepBdeP6KL90ImVYJRAhiXkgf9D8C9dV34FnRQU36XoX1aL5p
 Wj5u89ooH11v0EKtOJffH9OETdFPI+LmpKOxIY4Tnbtl+fvpbSbJQEH97m7aJCzTpAzcB/8VMGO
 Df8cMGthXw0C8WO7U/w/ys6iuVlR2R8CaTjF+7WzK2gGrHgNpYWWJWvz2VAqTDP1d0xYC7njwDr
 93TWmhh6xvM+aItb7wdlV7iX9t3ItOoawBXPVJDME0zqU1kRqSZi
X-Google-Smtp-Source: AGHT+IFhzREmXPUrTE8Oi69Rskqkh0S+vY2UGZRTGGtRPl8RCBFklZ3LJOtpM7BcA7UowTZi2WiG2g==
X-Received: by 2002:a05:6402:1941:b0:604:bb1d:938d with SMTP id
 4fb4d7f45d1cf-605b7b6bf8dmr11023125a12.34.1748948526114; 
 Tue, 03 Jun 2025 04:02:06 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-605671437e0sm7347925a12.52.2025.06.03.04.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 04:02:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D5B715F839;
 Tue, 03 Jun 2025 12:02:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v4 00/17] Maintainer updates for May (testing, plugins,
 virtio-gpu) - pre-PR
Date: Tue,  3 Jun 2025 12:01:47 +0100
Message-ID: <20250603110204.838117-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Now the tree is open here is the state of my current maintainer
queues. I've tagged the virtio-gpu changes as Cc: qemu-stable but
given how close to release we were it didn't seem worth rushing them
in for 10.0. I've included a MAINTAINERS patch just to make sure I can
route any more fixes until a more full time maintainer volunteers.

As there is still controversy about a theoretical UAF in virtio-gpu
I've dropped that patch for now. There were a number of other review
comments addressed so I'm re-sending the pre-PR so I can roll the PR
later this week.

For v4
  - more review comments
  - made boot.S error handling more robust
  - dropped virtio-gpu hang fix for TCG
  - dropped test-plugins fix for Makefile

For v3
  - addressed review comments
  - included gdb/next patches

For v2
  - addressed various comments (see bellow --- in commits)
  - added Akihiko/Dmitry as virtio-gpu reviewers

The following still need review:

  tests/tcg: make aarch64 boot.S handle different starting modes

Alex.

Alex Bennée (11):
  tests/docker: expose $HOME/.cache/qemu as docker volume
  gitlab: disable debug info on CI builds
  tests/tcg: make aarch64 boot.S handle different starting modes
  contrib/plugins: add a scaling factor to the ips arg
  contrib/plugins: allow setting of instructions per quantum
  MAINTAINERS: add myself to virtio-gpu for Odd Fixes
  MAINTAINERS: add Akihiko and Dmitry as reviewers
  hw/display: re-arrange memory region tracking
  include/exec: fix assert in size_memop
  include/gdbstub: fix include guard in commands.h
  gdbstub: assert earlier in handle_read_all_regs

Dominik 'Disconnect3d' Czarnota (1):
  gdbstub: Implement qGDBServerVersion packet

Dongwon Kim (1):
  ui/gtk-gl-area: Remove extra draw call in refresh

Manos Pitsidianakis (2):
  virtio-gpu: refactor async blob unmapping
  gdbstub: update aarch64-core.xml

Nabih Estefan (1):
  tests/qtest: Avoid unaligned access in IGB test

Yiwei Zhang (1):
  virtio-gpu: support context init multiple timeline

 MAINTAINERS                               |   5 +-
 docs/about/emulation.rst                  |   4 +
 include/exec/memop.h                      |   4 +-
 include/gdbstub/commands.h                |   2 +-
 include/system/memory.h                   |   1 +
 contrib/plugins/ips.c                     |  49 +++++-
 gdbstub/gdbstub.c                         |  19 ++-
 hw/display/virtio-gpu-virgl.c             | 102 +++++++++----
 tests/qtest/libqos/igb.c                  |   4 +-
 ui/gtk-gl-area.c                          |   1 -
 .gitlab-ci.d/buildtest-template.yml       |   1 +
 gdb-xml/aarch64-core.xml                  |  52 ++++++-
 tests/docker/Makefile.include             |  10 +-
 tests/tcg/aarch64/Makefile.softmmu-target |   3 +-
 tests/tcg/aarch64/system/boot.S           | 172 +++++++++++++++++++++-
 15 files changed, 382 insertions(+), 47 deletions(-)

-- 
2.47.2


