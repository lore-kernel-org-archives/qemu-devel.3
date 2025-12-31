Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16530EE57D6
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 07:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaqim-0007TX-5P; Wed, 31 Dec 2025 02:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqik-0007SK-B4
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:14 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vaqii-00019N-I9
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 02:34:14 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7b9215e55e6so6517839b3a.2
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 23:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767166451; x=1767771251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pFDpaqVfMywBDSQG0C6nZ29vsJWyVrth+eUfWW0xuig=;
 b=vJROXhzXViVgKwE2K2Jwym63GYbN5kBdzruIvTNubuWQy1pdueEpbD/Jw05EPXHMfJ
 HCo0GzgcmGqMVleyceBk9cPK9LIN0ywbDe3zILyKM95qDGzD8pzsvE9BWZi6t++cjbJY
 PljOzft45eAPgnjaBGxx4yrdlyb+vrxQXuEovsJe/feLAPJt6bs7UpuKv24I4zcfOBuo
 xMd0qLhhNYQMUBgORn6S89fGo3UmVM729VRVZbaaSZsmIBT1BOQ8+OSkr68CD7ZnRFj2
 UM0cZL/BVIo/hEwej6RO+qSz7/0huxBa98xnerr0yGL1VKg6UsWvS3/QRTN8adSRiwje
 HPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767166451; x=1767771251;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pFDpaqVfMywBDSQG0C6nZ29vsJWyVrth+eUfWW0xuig=;
 b=frgBX0aouzVFIx9VLT7A7ELlWWeJSucEPJJryU1uGsigi4nWc4XvqaLomLb7oOCMTq
 L6yePvVWMF9JHpJk0t/cBKtUWRQw9dC4tOz0C08QPBgnJq6zBd9/IcxBS+hSD0K1n+rh
 EbAmHGtiiiALpPLHW48/kM6t6jJplldCI0dlO5j/5SUZYsC8UvgOKf/2eKOdm1ouJAJB
 VemyhGIMQoW2JOhK8FomsW3liPegUHlSzmXlTwO+a64yrJwH/G7kAiLQUmpBhs5bBCBv
 5X59P2/t79tViGj4xPlKOZn76TxpnBGj66ZHY3qJp7UwZGPNMxYh042KGfF/OC67yd1B
 e+VA==
X-Gm-Message-State: AOJu0YxgqxIZwbralnf2kXcPiqgVZqMKaJ038EqoSkWFfvVtDIUzzgt8
 sMgYUSWHz9kgR6XROYn8YxAlPeqhJBd2OGg6Gd0RULbIF7KZd3qXzznYtWswjkqB9pR8qjafFs6
 2U5GH
X-Gm-Gg: AY/fxX7NczaGGt2c9Jd/sHNE1LfOxC+hm5p0CSGTZrNUWqJ4JZxe7RGQ4yp0aQLNSIN
 7nh5bkwHzJK+KM2xUbVfqz+cD0dBm2NgIn2DXKuZFIASbvXMsAv1x0EUYISIE6q7moKWXvbHi4c
 +Jf81VWAFQY/Efy3u/qv2zeuHIt3Vz6D7ZwuwKqbKhWHNkiYY03rBwpEhIFyj6JBZ6CB9m1/VYI
 xw7TpwCtFGJ0/liDpkLR2ekkYc1VdHEjgDJSLP/ozmL3ea+bHr9olXKYVVYxbHzVnGzXZ4WlUGm
 cu90GYjSRm6mcqNbwLWiFPYDnuhJpxYwdSJ0UH0fTjDSEuWjMKshUhyIsa9Fhj6Wyfa88+sHhsF
 rDumaWw0Gjsfj8mrsRAw3OSegs5x01EXn6eO7Up6xJ3b98Qb1fymbi1JR5Cg5UhsDAeMBZ/ORGU
 PCkWLPIUrhO0ct2ZV3BNMWmEpaiI/A5hTqliOqiNRcQcBq1pqyy2tv+FkopRU1J0SI
X-Google-Smtp-Source: AGHT+IHCt9sQSkGW2Un7urezkWF0PQgDWpZ1ZJbdeMYbO+hxGqPQOPFgSOyAhAooM5DqUTv8gkyKLw==
X-Received: by 2002:a05:6a21:6d97:b0:341:84ee:7597 with SMTP id
 adf61e73a8af0-376a96b90b4mr32941342637.47.1767166450548; 
 Tue, 30 Dec 2025 23:34:10 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48f3d7sm34597984b3a.51.2025.12.30.23.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 23:34:10 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 00/11] plugins: enable C++ plugins
Date: Tue, 30 Dec 2025 23:33:50 -0800
Message-ID: <20251231073401.2097765-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Writing plugins in C can be sometimes tedious, especially when using Glib to
keep track of execution state. We can directly use the same C API but write our
plugin in C++, benefiting from its great standard library offering strings,
smart pointers, data structures and synchronization mechanisms.

It's common for downstream QEMU forks to provide C++ for plugins, like this:
- https://github.com/panda-re/panda/tree/dev/panda/plugins
- https://github.com/FlorentRevest/DejaView/tree/main/src/qemu_plugin

Hopefully this will help more people to use upstream QEMU, and as a benefit, get
their contribution back and help to develop plugins ecosystem upstream directly.

This series first cleans up build system for plugins, factorizing details
between contrib/plugins and tests/tcg/plugins folders.
Then, we perform codebase cleanups to fix conflicts between existing headers
and C++ headers.
After that, we can update the C++ standard used by QEMU, to benefit fully
from latest updates of the language.
Finally, we define an empty C++ plugin, making sure we can keep track of
possible regression in qemu-plugin header.

Note: This series is *not* a trojan horse to bring C++ in QEMU
codebase, nor to define an alternative C++ API for plugins. It's just enabling
more users to get the most out of existing C plugin API.

CI: https://gitlab.com/pbo-linaro/qemu/-/pipelines/2239199381

Pierrick Bouvier (11):
  plugins: move win32_linker.c file to plugins directory
  plugins: factorize plugin dependencies and library details
  plugins: use complete filename for defining plugins sources
  plugins: define plugin API symbols as extern "C" when compiling in C++
  include: qemu/ctype.h -> qemu/qemu-ctype.h
  include: qemu/coroutine.h -> qemu/qemu-coroutine.h
  meson: fix supported compiler arguments in other languages than C
  meson: enable cpp (optionally) for plugins
  qga/vss-win32: fix clang warning with C++20
  meson: update C++ standard to C++23
  contrib/plugins: add empty cpp plugin

 meson.build                                   |  24 ++--
 block/parallels.h                             |   2 +-
 block/qcow2.h                                 |   2 +-
 fsdev/qemu-fsdev-throttle.h                   |   2 +-
 hw/9pfs/9p.h                                  |   2 +-
 include/block/block-global-state.h            |   2 +-
 include/block/block-hmp-cmds.h                |   2 +-
 include/block/block-io.h                      |   2 +-
 include/block/reqlist.h                       |   2 +-
 include/block/throttle-groups.h               |   2 +-
 include/qemu/coroutine_int.h                  |   2 +-
 include/qemu/job.h                            |   2 +-
 .../qemu/{coroutine.h => qemu-coroutine.h}    |   0
 include/qemu/{ctype.h => qemu-ctype.h}        |   0
 include/qemu/qemu-plugin.h                    |   8 ++
 migration/migration.h                         |   2 +-
 ui/console-priv.h                             |   2 +-
 block.c                                       |   2 +-
 block/block-copy.c                            |   2 +-
 block/io_uring.c                              |   2 +-
 block/linux-aio.c                             |   2 +-
 block/mirror.c                                |   2 +-
 block/progress_meter.c                        |   2 +-
 block/ssh.c                                   |   2 +-
 block/vdi.c                                   |   2 +-
 block/vvfat.c                                 |   2 +-
 chardev/char.c                                |   2 +-
 gdbstub/gdbstub.c                             |   2 +-
 hw/9pfs/coth.c                                |   2 +-
 hw/block/virtio-blk.c                         |   2 +-
 hw/core/bus.c                                 |   2 +-
 hw/core/qdev-properties-system.c              |   2 +-
 hw/core/qdev-properties.c                     |   2 +-
 hw/hyperv/syndbg.c                            |   2 +-
 hw/nvme/nguid.c                               |   2 +-
 hw/s390x/ccw-device.c                         |   2 +-
 hw/s390x/ipl.c                                |   2 +-
 hw/s390x/s390-virtio-ccw.c                    |   2 +-
 hw/scsi/scsi-generic.c                        |   2 +-
 migration/migration.c                         |   2 +-
 migration/rdma.c                              |   2 +-
 monitor/fds.c                                 |   2 +-
 monitor/hmp.c                                 |   2 +-
 nbd/client-connection.c                       |   2 +-
 net/colo-compare.c                            |   2 +-
 net/net.c                                     |   2 +-
 net/tap-solaris.c                             |   2 +-
 {contrib/plugins => plugins}/win32_linker.c   |   0
 qapi/qapi-util.c                              |   2 +-
 qapi/qmp-dispatch.c                           |   2 +-
 qobject/json-parser.c                         |   2 +-
 target/ppc/ppc-qmp-cmds.c                     |   2 +-
 target/riscv/cpu.c                            |   2 +-
 target/riscv/riscv-qmp-cmds.c                 |   2 +-
 tests/qtest/libqtest.c                        |   2 +-
 tests/qtest/migration/migration-util.c        |   2 +-
 tests/unit/test-aio-multithread.c             |   2 +-
 tests/vhost-user-bridge.c                     |   2 +-
 ui/console.c                                  |   2 +-
 ui/keymaps.c                                  |   2 +-
 ui/ui-qmp-cmds.c                              |   2 +-
 util/cutils.c                                 |   2 +-
 util/id.c                                     |   2 +-
 util/qemu-co-shared-resource.c                |   2 +-
 util/qemu-co-timeout.c                        |   2 +-
 util/qemu-coroutine-io.c                      |   2 +-
 util/readline.c                               |   2 +-
 util/thread-pool.c                            |   2 +-
 contrib/plugins/cpp.cpp                       | 119 ++++++++++++++++++
 contrib/plugins/meson.build                   |  25 ++--
 plugins/meson.build                           |  15 ++-
 qga/vss-win32/requester.cpp                   |   6 +-
 tests/tcg/plugins/meson.build                 |  18 +--
 73 files changed, 237 insertions(+), 104 deletions(-)
 rename include/qemu/{coroutine.h => qemu-coroutine.h} (100%)
 rename include/qemu/{ctype.h => qemu-ctype.h} (100%)
 rename {contrib/plugins => plugins}/win32_linker.c (100%)
 create mode 100644 contrib/plugins/cpp.cpp

-- 
2.47.3


