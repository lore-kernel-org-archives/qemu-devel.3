Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85467C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmWz-0000P3-Il; Wed, 21 May 2025 12:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmWw-0000NW-Sm
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:42:58 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmWu-00068E-JN
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:42:58 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-601fb2b7884so5590352a12.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 09:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747845772; x=1748450572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tuiJpxIfqq7ecvK9GRXekyPg/m+L/Ysi2Yko/jGzDgA=;
 b=dzQtS3FdVjWvJE3ap5SDEAhok23Sg306Btr8UCD70058blZzf/CQaj250dvCPqC/lB
 rtyxSkmfBuA5jD4dFlobAFskj9uPPt4K44jbzChZtGdQu0I9AJWrfuLliD6gVLElGcFg
 pCQJPciHyAvBHEuVe/Atfirprcl4y3m+29hx5F+mItWwKDCOdauI+pUYrzz8NOMYu6kX
 NPUGZK2R7CmZLw/ExeAShGJMHMIKTuo/7t3+NB0i+HR1+NL1PjEDhQyQtADyfhTQkjyj
 FTCfc5u01sx4nhsV9eqD+zI7zytSXYFgfXY+h/+V6mHg3Jp5dhNu2Onx6jqmBson7rO4
 +ZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747845772; x=1748450572;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tuiJpxIfqq7ecvK9GRXekyPg/m+L/Ysi2Yko/jGzDgA=;
 b=U0ax69CpoFO+FQilm+gWl7V8edI+5lj1+HKvPo/IBWcYwDAksIH+kI8/MOQS/I9qG8
 /+fzqvDlC/SHn5pvcK5s2YqXVz3oSzRGDzKH12NHoDvY08tQhjRYtjiL7K/vhxw9HmW/
 NZw2CPoC+l8keoGnMEKkoYW05xcdivBTecPCY7ikDNq3YXUYrrCXLAnbBthlozNR+7fk
 SZanLAypsMVJnK/Dt/0wv1GLKQufGlxdC5RfdQi8f7W+SbdvTQPYgIoOttXtlfceYhWV
 4A1pCKZcvMl2iZbBDmIydlu/XZZuAjTCMnxX8wRZlUSgFgjaf+plgGTTZwybBnOk2eKu
 ja0A==
X-Gm-Message-State: AOJu0YxiFXrP3YMI50D0xdQcxAi8KI9aVjz/2wGmCgqfDGPOddSRcK7q
 /KOa23Zw91oO04jfvZgBdij1uhkcXD+ZiFOoWqhLQrs57VhbwZgZ8FI/v7zBBku6whM=
X-Gm-Gg: ASbGncshxv8qrRZ2dHDLkRxdWPBkXvwFZJ4ijk//QFUj9iTwfyqDbDL9f6y/0O8+ALP
 czyKiwbLZjdkMcl4653p3yxOpJcxkkdwObqhW/hHqVvCQUG5uAgxPPoIVK0T9EZAtpLr7K28T7P
 kzw+wUDqMFp0Er9ImX1xcalzLqhnmz9sffLEwcjMghynuSBUix9lIlvHMy6HqgfXmLu0XJCFnx0
 eXFhESldjdi27iZP8Chf2ESRZM9bQfvQjwD2CPpTXu0Esl2xZGv+mVLMmcZbJLyG3KgzXaA6fKR
 DWbWKotAfL5y48khbKXpxry3IUDY2+UdywEI6qjR5to5kSPfrEj8QUGn3Gjziy8=
X-Google-Smtp-Source: AGHT+IGjZbAwuBp+N+ZBBNezbM0wWIjTb6YSFPn/w+iow7w+pJFg8EAsktUJeL1TxgwGrYFkh+HGrw==
X-Received: by 2002:a17:907:1b1b:b0:ad2:40a1:7894 with SMTP id
 a640c23a62f3a-ad536f9db58mr1786802866b.41.1747845772185; 
 Wed, 21 May 2025 09:42:52 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d277a1fsm922258566b.85.2025.05.21.09.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 09:42:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 31CB75F786;
 Wed, 21 May 2025 17:42:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 00/20] Maintainer updates for May (testing, plugins,
 virtio-gpu) - pre-PR
Date: Wed, 21 May 2025 17:42:30 +0100
Message-Id: <20250521164250.135776-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

Unless there are any major objections I intend to send the PR on Friday.

For v3
  - addressed review comments
  - included gdb/next patches

For v2
  - addressed various comments (see bellow --- in commits)
  - added Akihiko/Dmitry as virtio-gpu reviewers

The following still need review:

  MAINTAINERS: add Akihiko and Dmitry as reviewers
  MAINTAINERS: add myself to virtio-gpu for Odd Fixes
  tests/Makefile: include test-plugins in per-arch build deps
  tests/tcg: make aarch64 boot.S handle different starting modes
  tests/docker: expose $HOME/.cache/qemu as docker volume

Alex.

Alex Bennée (12):
  tests/docker: expose $HOME/.cache/qemu as docker volume
  gitlab: disable debug info on CI builds
  tests/tcg: make aarch64 boot.S handle different starting modes
  tests/Makefile: include test-plugins in per-arch build deps
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

Gustavo Romero (1):
  tests/functional: Add PCI hotplug test for aarch64

Manos Pitsidianakis (3):
  virtio-gpu: fix hang under TCG when unmapping blob
  virtio-gpu: refactor async blob unmapping
  gdbstub: update aarch64-core.xml

Nabih Estefan (1):
  tests/qtest: fix igb test failure under --enable-ubsan

Yiwei Zhang (1):
  virtio-gpu: support context init multiple timeline

 MAINTAINERS                                  |  11 +-
 docs/about/emulation.rst                     |   4 +
 include/exec/memop.h                         |   4 +-
 include/gdbstub/commands.h                   |   2 +-
 include/system/memory.h                      |   1 +
 contrib/plugins/ips.c                        |  49 +++++-
 gdbstub/gdbstub.c                            |  19 ++-
 hw/display/virtio-gpu-virgl.c                | 104 ++++++++---
 tests/qtest/libqos/igb.c                     |   4 +-
 ui/gtk-gl-area.c                             |   1 -
 .gitlab-ci.d/buildtest-template.yml          |   1 +
 gdb-xml/aarch64-core.xml                     |  52 +++++-
 tests/Makefile.include                       |   2 +-
 tests/docker/Makefile.include                |  10 +-
 tests/functional/meson.build                 |   1 +
 tests/functional/test_aarch64_hotplug_pci.py |  74 ++++++++
 tests/tcg/aarch64/Makefile.softmmu-target    |   3 +-
 tests/tcg/aarch64/system/boot.S              | 171 ++++++++++++++++++-
 18 files changed, 464 insertions(+), 49 deletions(-)
 create mode 100755 tests/functional/test_aarch64_hotplug_pci.py

-- 
2.39.5


