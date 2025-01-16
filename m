Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924E3C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSLJ-0003kz-V7; Thu, 16 Jan 2025 11:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSL0-0003UX-AD
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:18 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSKu-0001Di-AU
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:17 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso7093225e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043390; x=1737648190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gUoaXyH4aVrYb6ckq7rSg03LWFbF+cDfUNxU6VcJTrY=;
 b=RLZWm/WfjwsrKvGMSAFn8hMyKXmWV6QeUJ/j/PLkh8pq51rj12/DmL16fJYGbYPqRm
 an4L4JN1gCB9RjeFTw/9EFwUwN29MpHfnBxqSHki4kRf/tC3kHktkq2o7BVuYsFOmBhD
 3rVwxFVuRIeyuY/5Q8UnFso8DdRz7d8GElaGS6CB9KmDeJ2/mfEryVoKK7mSXUtY9on4
 c3tFo3MPcH8QD16J8r4wUpgV0MFAqPWu56Sbx7xVziESKiHVqFrgPqx5on1VZQmLj/EL
 9sGZAx39vpNDqC18+BOYi3RB8gcwxmE84ufw2lygEd4WBMBpE8BbBZtiY2JFcu5JV7RR
 9YFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043390; x=1737648190;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gUoaXyH4aVrYb6ckq7rSg03LWFbF+cDfUNxU6VcJTrY=;
 b=LmRCN2/POqiJhdCycucw0YHL9H2QpzF+jYVF4lcs4Y3/e+jQcJCmBxhBne/6ugw5dP
 K6z26YD56Jk6XY930fVV4DJSfdYRaaEp6wopVz7Bkc9kKOY61Vu6n9/SvrOSwrFORyQx
 YqXsUKSS5Pgg63wtTWrF7LPj3Sklxjazyu7A3DkEK9Q8A8Xt5rTm/dCm8XXhXhGOA+Tt
 xCk7VGIEZKpzIofwJdVnqGOK/SW/GHZtrLHBHkDvVzTg4JEOAAJtq5K1L9PEbc0/saF6
 J0c1jnLWT0RPvmrhUdw8W8qzwRoq1vb311kgcaJ3NfZrxeiDH/mkK6gm14sYOpgEC+lp
 QSoA==
X-Gm-Message-State: AOJu0YxpqNve9kOm1LGwV2FBb9Z/GAJUr8qQD9yxC6xzXzq7ReTneV+N
 lWG+9FfrmLEFLXItXQWyLbs0a8FmZUy3okgQeU3Exgs8IIgWBnJI4nKfQzbeQv4=
X-Gm-Gg: ASbGncsHWALWC/5HYSIlkxphd8pyg1bDkq8+vj7r+xokqujgJgb/YEfKVohY8TJk9+h
 Hwo/hwXjpjTtkrNcU8phhKHiJ+ffzlvpbWgSiJ9CEm6ArHlIN2BQan/uMJJuCq/SrsTMQdhePyp
 aWCD1lzeQ0Dn+qwa18Jj5wAFurnuHtFjP7laJRcH8TJmKuBrmkhmhhuLKZXfDmXaiP8oyrGnGgy
 UqjtH+3FlDYO+6P7YNIYKJ3E9X6g5cFFC/y9ZLr6lI7Fp+LTaybqCw=
X-Google-Smtp-Source: AGHT+IH8g3gJFyLpsw7M5Ig9kbtb1cbTZzkN0EZpyWQOJ0ukBEZ2LhbhTSPbEtDA8m9fupb0wSCyXQ==
X-Received: by 2002:a05:600c:468a:b0:434:a968:89a3 with SMTP id
 5b1f17b1804b1-436e26a78a5mr267630225e9.9.1737043389509; 
 Thu, 16 Jan 2025 08:03:09 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438904086cfsm3672345e9.4.2025.01.16.08.03.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:03:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 65EBF60812;
 Thu, 16 Jan 2025 16:03:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 00/37] maintainer updates for jan '25 (semihosting, gdb,
 plugins, docs) pre-PR-FINAL
Date: Thu, 16 Jan 2025 16:02:29 +0000
Message-Id: <20250116160306.1709518-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Only a few changes from v2, sending out to cut a PR tomorrow

  - applied r-b tags
  - fixed bsd-user gdbserver_start
  - a few minor tweaks to commit messages

This covers my remaining trees outside of testing/next and is mostly a
consolidation of patches I've pulled from other people.

For semihosting:

  - a bunch of cleanups from Philippe to aide single binary builds

For gdbstub (touches system/vl.c as well):

  - propagate *Error to setup functions

For plugins

  - mostly fixes from Pierrick
  - a speculative fix for cpu_io_recompile() case exposed by Julian's
    discontinuity patches.
  - windows clang build fixes

For docs (new for v2)

  - Some old docs/next I found in my tree
  - A dependency fix to ensure we rebuild if we change the kdoc script
  - Pierrick's devel updates

Additional (new for v2)

  - optimising the nsis.py script from Stefan

Most are already reviewed, the following remain:

  docs/sphinx: include kernel-doc script as a dependency
  include/exec: fix some copy and paste errors in kdoc
  tests/qtest: fix some copy and paste errors in kdoc
  editorconfig: update for perl scripts
  plugins: fix kdoc annotation

Now testing/next is merged I'll cut a PR for this on Friday. I suspect
I'll do another gdbstub/next once this is merged. I don't think I have
anything else pending but do shout if there is.

Alex.

Alex Bennée (11):
  semihosting: add guest_error logging for failed opens
  system/vl: more error exit into config enumeration code
  system: squash usb_parse into a single function
  system: propagate Error to gdbserver_start (and other device setups)
  accel/tcg: also suppress asynchronous IRQs for cpu_io_recompile
  plugins: fix kdoc annotation
  editorconfig: update for perl scripts
  tests/qtest: fix some copy and paste errors in kdoc
  include/exec: fix some copy and paste errors in kdoc
  include/exec: remove warning_printed from MemoryRegion
  docs/sphinx: include kernel-doc script as a dependency

Philippe Mathieu-Daudé (6):
  semihosting/uaccess: Briefly document returned values
  semihosting/syscalls: Include missing 'exec/cpu-defs.h' header
  semihosting/uaccess: Include missing 'exec/cpu-all.h' header
  semihosting/arm-compat: Include missing 'cpu.h' header
  semihosting/console: Avoid including 'cpu.h'
  semihosting/meson: Build config.o and console.o once

Pierrick Bouvier (19):
  tests/tcg/plugins/insn: remove unused callback parameter
  contrib/plugins/howvec: ensure we don't regress if this plugin is
    extended
  tests/tcg/plugins/syscall: fix 32-bit build
  tests/tcg/plugins/mem: fix 32-bit build
  contrib/plugins/stoptrigger: fix 32-bit build
  contrib/plugins/cache: fix 32-bit build
  contrib/plugins/hotblocks: fix 32-bit build
  contrib/plugins/cflow: fix 32-bit build
  contrib/plugins/hwprofile: fix 32-bit build
  contrib/plugins/hotpages: fix 32-bit build
  configure: reenable plugins by default for 32-bit hosts
  win32: remove usage of attribute gcc_struct
  docs/devel/style: add a section about bitfield, and disallow them for
    packed structures
  plugins: enable linking with clang/lld
  docs/devel: add git-publish for patch submitting
  docs/devel: add b4 for patch retrieval
  docs/devel: add information on how to setup build environments
  docs/devel: add a codebase section
  docs: add a glossary

Stefan Weil (1):
  scripts/nsis.py: Run dependency check for each DLL file only once

 MAINTAINERS                               |   5 +-
 docs/about/build-platforms.rst            |   4 +-
 docs/about/emulation.rst                  |   2 +
 docs/devel/build-environment.rst          | 118 +++++++++
 docs/devel/codebase.rst                   | 220 +++++++++++++++++
 docs/devel/control-flow-integrity.rst     |   2 +
 docs/devel/decodetree.rst                 |   2 +
 docs/devel/ebpf_rss.rst                   |   2 +
 docs/devel/index-build.rst                |   1 +
 docs/devel/index-internals.rst            |   2 +
 docs/devel/index.rst                      |   1 +
 docs/devel/migration/main.rst             |   2 +
 docs/devel/multi-thread-tcg.rst           |   2 +
 docs/devel/qapi-code-gen.rst              |   1 +
 docs/devel/style.rst                      |  20 ++
 docs/devel/submitting-a-patch.rst         |  39 +++
 docs/devel/testing/main.rst               |   9 +-
 docs/devel/testing/qtest.rst              |   2 +
 docs/glossary.rst                         | 280 ++++++++++++++++++++++
 docs/index.rst                            |   3 +
 docs/interop/qemu-ga.rst                  |   2 +
 docs/sphinx/depfile.py                    |   3 +
 docs/system/arm/virt.rst                  |   2 +
 docs/system/images.rst                    |   2 +
 docs/system/qemu-block-drivers.rst.inc    |   2 +
 docs/tools/qemu-nbd.rst                   |   2 +
 docs/tools/qemu-storage-daemon.rst        |   2 +
 docs/user/main.rst                        |   6 +
 configure                                 |  21 +-
 meson.build                               |   6 +-
 include/exec/gdbstub.h                    |   8 +-
 include/exec/memory.h                     |   5 +-
 include/qemu/compiler.h                   |   7 +-
 include/qemu/qemu-plugin.h                |   2 +-
 include/semihosting/console.h             |   2 -
 include/semihosting/syscalls.h            |   1 +
 include/semihosting/uaccess.h             |  55 +++++
 scripts/cocci-macro-file.h                |   6 +-
 subprojects/libvhost-user/libvhost-user.h |   6 +-
 tests/qtest/libqos/qgraph.h               |   2 +-
 tests/qtest/libqtest.h                    |   6 +-
 accel/tcg/translate-all.c                 |   5 +-
 bsd-user/main.c                           |   2 +-
 contrib/plugins/cache.c                   |  18 +-
 contrib/plugins/cflow.c                   |  17 +-
 contrib/plugins/hotblocks.c               |  29 ++-
 contrib/plugins/hotpages.c                |   6 +-
 contrib/plugins/howvec.c                  |   7 +-
 contrib/plugins/hwprofile.c               |  27 ++-
 contrib/plugins/stoptrigger.c             |  48 ++--
 gdbstub/system.c                          |  22 +-
 gdbstub/user.c                            |  22 +-
 linux-user/main.c                         |   6 +-
 monitor/hmp-cmds.c                        |   2 +-
 semihosting/arm-compat-semi.c             |   1 +
 semihosting/console.c                     |   3 +-
 semihosting/syscalls.c                    |   2 +
 semihosting/uaccess.c                     |   1 +
 system/vl.c                               | 101 ++++----
 tests/tcg/plugins/insn.c                  |   4 +-
 tests/tcg/plugins/mem.c                   |   6 +-
 tests/tcg/plugins/syscall.c               |   6 +-
 .editorconfig                             |  13 +
 contrib/plugins/meson.build               |   2 +-
 plugins/meson.build                       |  24 +-
 scripts/nsis.py                           |  10 +-
 semihosting/meson.build                   |   9 +-
 tests/tcg/plugins/meson.build             |   3 +-
 68 files changed, 1035 insertions(+), 226 deletions(-)
 create mode 100644 docs/devel/build-environment.rst
 create mode 100644 docs/devel/codebase.rst
 create mode 100644 docs/glossary.rst

-- 
2.39.5


