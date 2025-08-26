Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D28CA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwGt-0003iu-1f; Tue, 26 Aug 2025 12:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwGe-0003di-AS; Tue, 26 Aug 2025 12:11:28 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwGW-0007jI-V7; Tue, 26 Aug 2025 12:11:26 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b49d6f8f347so2673499a12.0; 
 Tue, 26 Aug 2025 09:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224670; x=1756829470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AhbLYMshYAUBc3POZs0F74KQaPEz55+loE8jlkKBrEA=;
 b=YSbV85diLpUKrfrsm8n5JyM/jIpJ6RR+EN5/tkwcsbVLOaZg+3axb9kHJVFcvHPXzJ
 QnqeS8BGezEgW0hZzZ/gpeDwKXRTL/Nf3bqk+nWSpVGk7FpCiIoFb5Lmmf5XhcenTyt5
 a8aGovpWCpAlP2oE40W3ZaiRyEMtZRlUdLkAlCPLTmQj0uGN357byHptrcSxtpjiZh8+
 KHZEFQkJYHD6ffMF2EPNVKay8T5OQObCJA30ChHwTBOYWT4XBuPMl9cavxwrjk5MKBUi
 AnvC46BrJSdvoE1vyODhBEtfeHp/c4ypJIhe4nn49PYGPkF3VpF0rJc8dwVuaP2pQw1J
 RYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224670; x=1756829470;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AhbLYMshYAUBc3POZs0F74KQaPEz55+loE8jlkKBrEA=;
 b=Z5ytF61M5xuDN4tbJeX1D83ohxWDTa8LTNNs8IRWx6/Gzth6QCcLiZsJvWDNZkOpEg
 dkRtWf69QiOtvMkUFqwliqdSHIbmK69HvgLH2nxhfDb5BTgHgWaKbY5X1tfI8kK1y1Z1
 6l5phpQDKYQySRWrVVU4FypddwGtqoRrFOaKr5Hb8teVZQjj+yb2qkzutet9zDOtcHPj
 WUPJHT9ddrQUmWLHfF8CMkAmfF4t1h65wOmZnVjl1zU323Sb5DFOFRK/4K64pQQBfXV0
 Zehn73R7y/FMJScjvpZmzsqTBKbZNc7Ox+TaQnWbVzAfGWryoTCZfYUTlxAjvzMVRxUC
 IThA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm9LiWRUILflK9Bli3XmVdKcGp4DzLPSU8mzPC+c+AY2v2H9TcVkVXs0GFlqFHILQZSp+2kJsqhg==@nongnu.org,
 AJvYcCWTJT7YoQu6KQVQmhQQDgu7EONsrBVPfWVjvzxT49tyG9cw4wZkZtCKMzTrGYgCryBzHeiivgtmmmSM5A==@nongnu.org
X-Gm-Message-State: AOJu0YwJBoKZXNQy8xjVaK9uiK552Bbo9Mf60D77A/vFHBuyW4rENr5f
 QaFxSilTtC354xu3R0R4Et4akgFeeDPLHmHl5NTmxzaD7f7Q+aYQf2p8nLLipQ==
X-Gm-Gg: ASbGncuqMEAOEwoQRKAm8mZO2jae/V48WHEmluuzoIko8wkmSrsV9JrcwommBZDxzbK
 OAXDE0PQfmfqy3loZQ9zUN/TvVoZcxgK+8X3owXRg/IkqqMjf7gvqAtgHrLOzLyYIQe7sBqtR7+
 ih4b4pacDHrfe7zlwgBxgvffzqlUxKfEmkRAaa6SiymI42Nr2qrUYMwm3o/18gq9toyrwhHoADM
 SjlTdci9ScaUTHbL1IvnxvAVnIvg39mb4agda2lr73k1KBHeQepIeo0Ss6lJypAlOWDsBoF84ju
 NPmq9uN2cxWr7NX6t92/oL1iVbAjSSuYV/7mUVyfGitXaNfcfz44GyozK6DtLCfbA4WalbSQx1J
 SEI0IPjtoeqMO8KuiAg5zyA==
X-Google-Smtp-Source: AGHT+IFQWwLCA/juWOF1czhFawogvI/Pf19u10kCZ+xfnl0r5+tAN4bwO9GuF/YuyLJQZvojKYYnVw==
X-Received: by 2002:a17:90b:5386:b0:313:176b:3d4b with SMTP id
 98e67ed59e1d1-32515eab5demr19170688a91.22.1756224670221; 
 Tue, 26 Aug 2025 09:11:10 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:11:09 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v2 00/35] wasm: Add Wasm TCG backend based on wasm64
Date: Wed, 27 Aug 2025 01:10:05 +0900
Message-ID: <cover.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x535.google.com
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

V2:

- Reorganized commits to implement the backend incrementally from a clean
  state.
- Removed the andc, orc, eqv, nand and nor operations to rely on default
  expansion.
- Removed the bswap operations to use default expansion.
- Removed the extract and deposit oprations to use default expansion.
- Updated the sextract to emit only when the corresponding Wasm instruction
  is available
- Removed the not operation to rely on default expansion.
- Fixed the neg implementation to "ret = 0 - arg"
- Added Wasm implementation of the mb operation using the atomic.fence
  instruction.

Note:
The first four commits are temporarily imported from a separated patch
series which enables 64bit guests using wasm64 [2]. These commits are under
review in that series and are included here only to allow subsequent patches
to build. Please ignore them when reviewing this series.

V1:

This patch series adds a TCG backend for WebAssembly. Unlike eariler
attempts [1], it is implemented using Emscripten's wasm64 target to support
64bit guests.

The first four commits are temporarily imported from a separated patch
series which enables 64bit guests using wasm64 [2]. These commits are under
review in that series and are included here only to allow subsequent patches
to build. Please ignore them when reviewing this series.

# New TCG Backend for Browsers

A new TCG backend translates IR instructions into Wasm instructions and runs
them using the browser's WebAssembly APIs (WebAssembly.Module and
WebAssembly.instantiate). To minimize compilation overhead and avoid hitting
the browser's limitation of the number of instances, this backend integrates
a forked TCI. TBs run on TCI by default, with frequently executed TBs
compiled into WebAssembly.

# 64bit guests support by wasm64

Support for 64bit guests is being reviewed in a separated patch series [2],
which enables QEMU to use 64bit pointers by compiling with the --cpu=wasm64
flag. The Wasm TCG backend is based on this feature and also requires
--cpu=wasm64.

QEMU compiled with --cpu=wasm64 runs on wasm64-capable engines. To support
engines which don't support wasm64 (e.g. Safari), the Wasm backend can use
the compatibility flag "--enable-wasm64-32bit-address-limit" also introduced
in [2]. This flag enables 64bit pointers in the C code while Emscripten
lowers the output binary to wasm32 and limits the maximum memory size to
4GB. As a result, the Wasm backend can run on wasm32 engiens while
supporting 64bit guests.

Note: The flag was originally named --wasm64-32bit-address-limit but this
patch series moved it from the configure script into meson_options.txt. To
follow Meson's naming conventions, it was renamed to
--enable-wasm64-32bit-address-limit.

# Overview of build process

To compile QEMU with Emscripten, the following dependencies are required.
The emsdk-wasm-cross.docker environment includes all necessary components
and can be used as the build environment:

- Emscripten SDK (emsdk) v4.0.10
- Libraries cross-compiled with Emscripten (please see also
  emsdk-wasm-cross.docker for build steps)
  - GLib v2.84.0
  - zlib v1.3.1
  - libffi v3.5.2
  - Pixman v0.44.2

The configure script supports --cpu=wasm64 flag to compile QEMU with 64bit
pointer support.

emconfigure ./configure --cpu=wasm64 \
                        --static --disable-tools \
                        --target-list=x86_64-softmmu
emmake make -j$(nproc)

If the output needs to run on wasm32 engines, use
"--enable-wasm64-32bit-address-limit" flag.

emconfigure ./configure --cpu=wasm64 --enable-wasm64-32bit-address-limit \
                        --static --disable-tools \
                        --target-list=x86_64-softmmu
emmake make -j$(nproc)

Either of the above commands generates the following files:

- qemu-system-x86_64.js
- qemu-system-x86_64.wasm

Guest images can be packaged using Emscripten's file_packager.py tool.
For example, if the images are stored in a directory named "pack", the
following command packages them, allowing QEMU to access them through
Emscripten's virtual filesystem:

/path/to/file_packager.py qemu-system-x86_64.data --preload pack > load.js

This process generates the following files:

- qemu-system-x86_64.data
- load.js

Emscripten allows passing arguments to the QEMU command via the Module
object in JavaScript:

Module['arguments'] = [
    '-nographic', '-m', '512M',
    '-L', 'pack/',
    '-drive', 'if=virtio,format=raw,file=pack/rootfs.bin',
    '-kernel', 'pack/bzImage',
    '-append', 'earlyprintk=ttyS0 console=ttyS0 root=/dev/vda loglevel=7',
];

The sample repository [3] (tcgdev64 branch) provides a complete setup,
including an HTML file that implements a terminal UI.

[1] https://patchew.org/QEMU/cover.1747744132.git.ktokunaga.mail@gmail.com/
[2] https://patchew.org/QEMU/cover.1754534225.git.ktokunaga.mail@gmail.com/
[3] https://github.com/ktock/qemu-wasm-sample/tree/tcgdev64

Kohei Tokunaga (35):
  meson: Add wasm64 support to the --cpu flag
  configure: Enable to propagate -sMEMORY64 flag to Emscripten
  dockerfiles: Add support for wasm64 to the wasm Dockerfile
  .gitlab-ci.d: Add build tests for wasm64
  tcg/wasm: Add tcg-target.h and tcg-target-reg-bits.h
  tcg/wasm: Add register-related definitions
  tcg/wasm: Add constraint definitions
  tcg/wasm: Add relocation callbacks
  tcg/wasm: Add and/or/xor instructions
  tcg/wasm: Add add/sub/mul instructions
  tcg/wasm: Add shl/shr/sar instructions
  tcg/wasm: Add setcond/negsetcond/movcond instructions
  tcg/wasm: Add sextract instruction
  tcg/wasm: Add load and store instructions
  tcg/wasm: Add mov/movi instructions
  tcg/wasm: Add ext instructions
  tcg/wasm: Add div/rem instructions
  tcg/wasm: Add neg/ctpop instructions
  tcg/wasm: Add rot/clz/ctz instructions
  tcg/wasm: Add br/brcond instructions
  tcg/wasm: Add exit_tb/goto_tb/goto_ptr instructions
  tcg/wasm: Add call instruction
  tcg/wasm: Add qemu_ld/qemu_st instructions
  tcg/wasm: Add mb instruction
  tcg/wasm: Mark unimplemented instructions
  tcg/wasm: Add initialization of fundamental registers
  tcg/wasm: Write wasm binary to TB
  tcg/wasm: Implement instantiation of Wasm binary
  tcg/wasm: Allow switching coroutine from a helper
  tcg/wasm: Enable instantiation of TBs executed many times
  tcg/wasm: Enable TLB lookup
  tcg/wasm: Add tcg_target_init function
  meson.build: enable to build Wasm backend
  meson.build: Propagate optimization flag for linking on Emscripten
  .gitlab-ci.d: build wasm backend in CI

 .gitlab-ci.d/buildtest.yml                    |   26 +-
 .gitlab-ci.d/container-cross.yml              |   20 +-
 .gitlab-ci.d/container-template.yml           |    4 +-
 MAINTAINERS                                   |    9 +-
 configure                                     |   14 +-
 include/accel/tcg/getpc.h                     |    2 +-
 include/tcg/helper-info.h                     |    4 +-
 include/tcg/tcg.h                             |    2 +-
 meson.build                                   |   16 +-
 meson_options.txt                             |    3 +
 scripts/meson-buildoptions.sh                 |    5 +
 tcg/aarch64/tcg-target.c.inc                  |   11 +
 tcg/arm/tcg-target.c.inc                      |   11 +
 tcg/i386/tcg-target.c.inc                     |   11 +
 tcg/loongarch64/tcg-target.c.inc              |   11 +
 tcg/meson.build                               |    5 +
 tcg/mips/tcg-target.c.inc                     |   11 +
 tcg/ppc/tcg-target.c.inc                      |   11 +
 tcg/region.c                                  |   10 +-
 tcg/riscv/tcg-target.c.inc                    |   11 +
 tcg/s390x/tcg-target.c.inc                    |   11 +
 tcg/sparc64/tcg-target.c.inc                  |   11 +
 tcg/tcg.c                                     |   21 +-
 tcg/tci/tcg-target.c.inc                      |   11 +
 tcg/wasm.c                                    |  855 +++++
 tcg/wasm.h                                    |  117 +
 tcg/wasm/tcg-target-con-set.h                 |   19 +
 tcg/wasm/tcg-target-con-str.h                 |   14 +
 tcg/wasm/tcg-target-has.h                     |   14 +
 tcg/wasm/tcg-target-mo.h                      |   20 +
 tcg/wasm/tcg-target-opc.h.inc                 |   18 +
 tcg/wasm/tcg-target-reg-bits.h                |   11 +
 tcg/wasm/tcg-target.c.inc                     | 2843 +++++++++++++++++
 tcg/wasm/tcg-target.h                         |   61 +
 ...2-cross.docker => emsdk-wasm-cross.docker} |   29 +-
 35 files changed, 4218 insertions(+), 34 deletions(-)
 create mode 100644 tcg/wasm.c
 create mode 100644 tcg/wasm.h
 create mode 100644 tcg/wasm/tcg-target-con-set.h
 create mode 100644 tcg/wasm/tcg-target-con-str.h
 create mode 100644 tcg/wasm/tcg-target-has.h
 create mode 100644 tcg/wasm/tcg-target-mo.h
 create mode 100644 tcg/wasm/tcg-target-opc.h.inc
 create mode 100644 tcg/wasm/tcg-target-reg-bits.h
 create mode 100644 tcg/wasm/tcg-target.c.inc
 create mode 100644 tcg/wasm/tcg-target.h
 rename tests/docker/dockerfiles/{emsdk-wasm32-cross.docker => emsdk-wasm-cross.docker} (85%)

-- 
2.43.0


