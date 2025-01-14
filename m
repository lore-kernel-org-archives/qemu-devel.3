Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78459E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfFd-000558-Gh; Tue, 14 Jan 2025 06:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFc-00054V-Ag
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:28 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFZ-0005OY-Al
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:28 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aaf57c2e0beso1100725766b.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736854703; x=1737459503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ft+gcg+qJTK2Lbg959Sb2wOGiy9ubf9tu+nWPd5aoEA=;
 b=ZUZr1+6HjTEWNI34jhsNJ/eI8SFTYloRVRdXrADMKf/J4LP/KaaMGfxjqzTuZ3JAGa
 m3Hqmw+lm/aRKmiLCiLgOZ29s4GAKtUA0q/IrKF9L8o36qSuPq2WITr6ZfKdE3Fbw5tX
 KDIP7MCoC8ClMeyL4zyAiCRF6eN1c85Qm9HFutDzyxmtAbllBo6BkLuFPOtM7U3Osniv
 d7pPv6TtzYY6GiDDcHAHxltke7Iu7F+m3ZJbnyuP7DOGllbQqCxvBI6bbJk3SeYss4oV
 sYI2R7LpMRhT4AbGk16U5HGZ2sorKs/FKoETvWn3zn9ojBA0faicd/kDHP9QIkII1NUH
 M+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854703; x=1737459503;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ft+gcg+qJTK2Lbg959Sb2wOGiy9ubf9tu+nWPd5aoEA=;
 b=Q2CzwV0Y1SvLfTNf7+sbYXwHHf9oMGAcvUsVU5lZA9K5VB4HHtVqHgrMUgAmZatLuD
 +EFKBKhsP8WKKeswqE0Fnmk5eAZ2Zt6J50QMzbtObuumrTKQBXarBUd1BpueIgCwg3Hn
 5IMAyJq5BYnoQW0apQ+k3kGzP7asE/S1MdP6VawtAQRVTT8dsn/68qhkDs1v4/yPXgEw
 W9QmH+DNqw9xEdQDuza2Y7HhqTsI+1smG6KMRKFCbEvzvIxWbT5QI6n5W0w1y3wYLDrL
 s2NGub30Ryaqz8sJ7PK2jHyYuw/pws52yb6Z1TyhSftHvSp7ByK5ipjSuUF7MejYpDOk
 WwxQ==
X-Gm-Message-State: AOJu0Yyd1bsYUq7x4hAiwfQKSkjxA9ZgcdfOEEYFDvT5fgxPYOUyebUN
 RXy7qHMGBK+SDNaWPaD5SBjwM2i9Vryi+/Vcjr20UmfTwX0oR1Y14ybuLqG6m5A=
X-Gm-Gg: ASbGnctwBkO0JCP5+24Cmoe9yGqqZb4vjnxR97tbnRkph8y5Wsv7iNFF3lr3Nm0/2d6
 IVHuvzdiAatYWvHZ389lA0+oHNqp7HNyEiaIeDlUPwDSDr3HDCPF3XeN4wipxX4SJHsfJQydwbx
 7h4EL+cg/et9PSyU+1q97lKxX2Veu08xOjCyG5bavYijPoU4vmO0jb5vuEcgh2e1TN3b9wYcn2+
 B7r//Ymf3Hj4bKMJ21FjPO3VyV4sJN3q9HMcM+EslasYxI2vu3UOY8=
X-Google-Smtp-Source: AGHT+IENHjS0/+IvY4KCOBilv8+fpPOfhGOTVoRJT1dtSOpuuDrh7Ap8Bph0cwh4TsNpPVO0rZ7OpA==
X-Received: by 2002:a17:907:96a7:b0:aa6:2c18:aaa2 with SMTP id
 a640c23a62f3a-ab2ab73e7dbmr2215522966b.27.1736854703207; 
 Tue, 14 Jan 2025 03:38:23 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90da2c8sm626466166b.62.2025.01.14.03.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:38:22 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C29CA5F89C;
 Tue, 14 Jan 2025 11:38:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 00/37] maintainer updates for jan '25 (semihosting, gdb,
 plugins, docs) pre-PR
Date: Tue, 14 Jan 2025 11:37:44 +0000
Message-Id: <20250114113821.768750-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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
  docs: add a codebase section
  docs: add a glossary

Stefan Weil (1):
  scripts/nsis.py: Run dependency check for each DLL file only once

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
 contrib/plugins/cache.c                   |  18 +-
 contrib/plugins/cflow.c                   |  17 +-
 contrib/plugins/hotblocks.c               |  29 ++-
 contrib/plugins/hotpages.c                |   6 +-
 contrib/plugins/howvec.c                  |   7 +-
 contrib/plugins/hwprofile.c               |  27 ++-
 contrib/plugins/stoptrigger.c             |  48 ++--
 gdbstub/system.c                          |  22 +-
 gdbstub/user.c                            |  20 +-
 linux-user/main.c                         |   6 +-
 monitor/hmp-cmds.c                        |   2 +-
 semihosting/arm-compat-semi.c             |   1 +
 semihosting/console.c                     |   3 +-
 semihosting/syscalls.c                    |   2 +
 semihosting/uaccess.c                     |   1 +
 system/vl.c                               |  99 ++++----
 tests/tcg/plugins/insn.c                  |   4 +-
 tests/tcg/plugins/mem.c                   |   6 +-
 tests/tcg/plugins/syscall.c               |   6 +-
 .editorconfig                             |  13 +
 contrib/plugins/meson.build               |   2 +-
 plugins/meson.build                       |  24 +-
 scripts/nsis.py                           |  10 +-
 semihosting/meson.build                   |   9 +-
 tests/tcg/plugins/meson.build             |   3 +-
 66 files changed, 1027 insertions(+), 223 deletions(-)
 create mode 100644 docs/devel/build-environment.rst
 create mode 100644 docs/devel/codebase.rst
 create mode 100644 docs/glossary.rst

-- 
2.39.5


