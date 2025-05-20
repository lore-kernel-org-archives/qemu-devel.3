Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E5DC5479B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMSJ-0000cE-ID; Tue, 20 May 2025 08:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMSH-0000bq-K2; Tue, 20 May 2025 08:52:25 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uHMSD-0000dD-W3; Tue, 20 May 2025 08:52:25 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b26c5fd40a9so5288704a12.1; 
 Tue, 20 May 2025 05:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747745535; x=1748350335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6AOdg1AywyIl611ITWfSCCutnIjDg8eluRSR+NLR4ts=;
 b=iwltJhIGc1ViAlwqBf/jvmHsJ28mWgt7uGbTjbkoKn9AgEPZNeNiMAsG9Bl4GN7Pwq
 19U2iTR2iDKG+Ek1OEzLT+apj011raF+v821z/bICb/q2ZYD7eE2yYoUdiYTTa7i7W1Y
 KbRsPI/xvJziFCry88l/AuzrPpw4LEC4PfqYMAF3K0ohzYpvX1IZ+v2kwKEAJ5bxC5Ns
 lMMLBZTNc6kXOeil5SplQoSd7iTR/LFzvok3CxaGhv+H4y2NaViy6lyxnv96J6r6/Rdn
 WHhmQvt52rpKqIhHx4N0bqsNYsUkkejljCNAJFQObWZmo2gMtYJmAM8grXgO1XSzSHet
 z8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745535; x=1748350335;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6AOdg1AywyIl611ITWfSCCutnIjDg8eluRSR+NLR4ts=;
 b=EIWeTmFGRD4tjNVKgvJo2GYBvbvqXPtrAa2+bxVw9dXSN78GY5Yj3i+A3Ux5EvBkDI
 qZjcgk4ciwo+cyvncEkiEdLqOTh223NDP1ckUj5pr/LkWf2+vCyFO5+RUtWOLqVeH9qL
 QwX/ndufs4tmk6LytvVgl7R2WBNbBnfFZ3qUdXJGqBOXcD1XGWeCTCS3WK2OCkUAitx+
 JjrrFXpViKOSZeF/+b6VRbe8pZ2EheWKHUw9T53GoyzPF9YtF9RzMGNj5TZYijUkrPiM
 dt6ueujAO3fzydGo8p6Epmh6Qo6NeO+XRzxMuNRfsuptIMlsBMqwObev9Z033J6Fhmb8
 mZNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU/KRaowwYC6LvTk4A5l0C3q+SUvnrQGhsRaRtgw7wWIEJhrlkHbYBO398i7dKux0jBHzxtY5AJg==@nongnu.org,
 AJvYcCVoJOcJIXDWHpqO/20Gb61Z3Fvx0qPjvLvhIwxJyQpDzFdYdK1s9qPIuwjcVCeGoSR7zlwDnW7Yrajtyg==@nongnu.org
X-Gm-Message-State: AOJu0YxrkFIf9mSNUifJMiOusOvLD+Jt4lLSBy15rjZX3q+u2O107phW
 ZzoMY2/Cd7ceA0YqH3ZaEL7XQg1rPvtvtgB/Sg9l6xjTzBs+XxZgREK1E6drXvor
X-Gm-Gg: ASbGncs66gr/9BQk1NStYDJIGzDtInEkk7sItyKgHo+W2cKy0fvV4oCJi7VtO4UsY2s
 PcL7443dPDnRmm0D1opa2W/0WXRRdzwvw/ymlc+f/I6E/+2BJlvteBovmjJfv93WElIXoBdOIcj
 m4l8k2/95E+sYlR7E/82SyVhAYL7Tnk8FIKM4CIJrfMxhItbyRp/r9C7fSp9a1Jb8uuaihfHsmt
 pBGNvSd7KIAySPazUL8CMY31zDwJaMaXG+A1ZBL4xBe6ri5vbcTUhl+otc9cXlm+TXWXIpq9ySJ
 urL5o1V085W8MdWMtT4WAnpayT/POckwsP6WBdbPaPDtdcyoTMU=
X-Google-Smtp-Source: AGHT+IHnHoG1pdY+DSlUAYQ+x5iFiPPLD8vIXKhLgYXpLwBJk0GbWd59nDqGjbHkpkx+fbgBr+HeZA==
X-Received: by 2002:a17:90b:2e85:b0:2ee:c30f:33c9 with SMTP id
 98e67ed59e1d1-30e7e770523mr21483641a91.14.1747745535218; 
 Tue, 20 May 2025 05:52:15 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:1bde:8310:e993:5dcc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f36364f9asm1625916a91.4.2025.05.20.05.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:52:14 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 00/33] tcg: Add WebAssembly backend
Date: Tue, 20 May 2025 21:51:02 +0900
Message-ID: <cover.1747744132.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

This patch series is split from the original "Enable QEMU to run on
browsers" series, focusing solely on introducing a TCG backend for
WebAssembly. This implemention is based on the latest master which already
includes the essential changes required to compile QEMU (in 32bit TCI mode)
using Emscripten.

# New TCG Backend for Browsers

A new TCG backend translates IR instructions into Wasm instructions and runs
them using the browser's WebAssembly APIs (WebAssembly.Module and
WebAssembly.instantiate). To minimize compilation overhead and avoid hitting
the browser's limitation of the number of instances, this backend integrates
a forked TCI. TBs run on TCI by default, with frequently executed TBs
compiled into WebAssembly.

# Workaround for Running 64bit Guests

The current implementation uses Wasm's 32bit memory model. This series
explores supporting TCG 64bit instructions while relying on SoftMMU for
address translation. To enable 64bit guest support in Wasm today, it was
necessary to partially revert recent changes that removed support for 64bit
guests on 32bit hosts (e.g. commits a70af12addd9060fdf8f3dbd42b42e3072c3914f
and bf455ec50b6fea15b4d2493059365bf94c706273) when compiling with
Emscripten. The reverting is partial and addresses only pointer width
differences between hosts and guests since the Wasm backend supports 64bit
word operations. While this serves as a temporary workaround, a long-term
solution could involve migrating to Wasm's 64bit memory model once it gains
broader support, as it is currently not widely adopted (e.g. unsupported by
Safari and libffi).

# Overview of build process

This section provides an overview of the build process for compiling QEMU
using Emscripten. Full instructions are available in the sample
repository[1].

To compile QEMU with Emscripten, the following dependencies are required.
The emsdk-wasm32-cross.docker environment includes all necessary components
and can be used as the build environment:

- Emscripten SDK (emsdk) v3.1.50
- Libraries cross-compiled with Emscripten (refer to
  emsdk-wasm32-cross.docker for build steps)
  - GLib v2.84.0
  - zlib v1.3.1
  - libffi v3.4.7
  - Pixman v0.44.2

QEMU can be compiled using Emscripten's emconfigure and emmake, which
automatically set environment variables such as CC for targeting Emscripten.

emconfigure configure --static --disable-tools --target-list=x86_64-softmmu
emmake make -j$(nproc)

This process generates the following files:

- qemu-system-x86_64.js
- qemu-system-x86_64.wasm
- qemu-system-x86_64.worker.js

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
    '-nographic', '-m', '512M', '-accel', 'tcg,tb-size=500',
    '-L', 'pack/',
    '-drive', 'if=virtio,format=raw,file=pack/rootfs.bin',
    '-kernel', 'pack/bzImage',
    '-append', 'earlyprintk=ttyS0 console=ttyS0 root=/dev/vda loglevel=7',
];

The sample repository[1] provides a complete setup, including an HTML file
that implements a terminal UI.

[1] https://github.com/ktock/qemu-wasm-sample

# Additional references

- A talk at FOSDEM 2025:
  https://fosdem.org/2025/schedule/event/fosdem-2025-6290-running-qemu-inside-browser/
- Demo page on GitHub Pages: https://ktock.github.io/qemu-wasm-demo/

Kohei Tokunaga (33):
  tcg: Fork TCI for wasm32 backend
  tcg/wasm32: Do not use TCI disassembler in Wasm backend
  meson: Enable to build wasm backend
  tcg/wasm32: Set TCG_TARGET_INSN_UNIT_SIZE to 1
  tcg/wasm32: Add and/or/xor instructions
  tcg/wasm32: Add add/sub/mul instructions
  tcg/wasm32: Add shl/shr/sar instructions
  tcg/wasm32: Add setcond/negsetcond/movcond instructions
  tcg/wasm32: Add deposit/sextract/extract instrcutions
  tcg/wasm32: Add load and store instructions
  tcg/wasm32: Add mov/movi instructions
  tcg/wasm32: Add ext instructions
  tcg/wasm32: Add bswap instructions
  tcg/wasm32: Add rem/div instructions
  tcg/wasm32: Add andc/orc/eqv/nand/nor instructions
  tcg/wasm32: Add neg/not/ctpop instructions
  tcg/wasm32: Add rot/clz/ctz instructions
  tcg/wasm32: Add addc/subb instructions
  tcg/wasm32: Add br/brcond instructions
  tcg/wasm32: Add exit_tb/goto_tb/goto_ptr instructions
  tcg/wasm32: Add call instruction
  tcg/wasm32: Add qemu_ld/qemu_st instructions
  include/exec: Allow using 64bit guest addresses on emscripten
  tcg/wasm32: Set TCG_TARGET_REG_BITS to 64
  tcg/wasm32: Set mulu2/muls2 as unimplemented
  tcg/wasm32: Add initialization of fundamental registers
  tcg/wasm32: Write wasm binary to TB
  tcg/wasm32: Implement instantiation of Wasm binary
  tcg/wasm32: Allow Asyncify unwinding from TB
  tcg/wasm32: Enable instantiation of TBs executed many times
  tcg/wasm32: Enable TLB lookup
  meson: Propagate optimization flag for linking on Emscripten
  .gitlab-ci.d: build wasm backend in CI

 .gitlab-ci.d/buildtest.yml       |    2 +-
 MAINTAINERS                      |    7 +
 accel/tcg/cputlb.c               |    8 +-
 include/accel/tcg/getpc.h        |    2 +-
 include/exec/helper-head.h.inc   |    6 +
 include/exec/tlb-common.h        |   14 +-
 include/exec/vaddr.h             |   11 +
 include/qemu/atomic.h            |    4 +
 include/tcg/helper-info.h        |    4 +-
 include/tcg/tcg.h                |    6 +-
 meson.build                      |   16 +-
 tcg/aarch64/tcg-target.c.inc     |   11 +
 tcg/arm/tcg-target.c.inc         |   11 +
 tcg/i386/tcg-target.c.inc        |   11 +
 tcg/loongarch64/tcg-target.c.inc |   11 +
 tcg/meson.build                  |    5 +
 tcg/mips/tcg-target.c.inc        |   11 +
 tcg/ppc/tcg-target.c.inc         |   11 +
 tcg/region.c                     |   10 +-
 tcg/riscv/tcg-target.c.inc       |   11 +
 tcg/s390x/tcg-target.c.inc       |   11 +
 tcg/sparc64/tcg-target.c.inc     |   11 +
 tcg/tcg.c                        |   23 +-
 tcg/tci/tcg-target.c.inc         |   11 +
 tcg/wasm32.c                     | 1096 ++++++++
 tcg/wasm32.h                     |  119 +
 tcg/wasm32/tcg-target-con-set.h  |   21 +
 tcg/wasm32/tcg-target-con-str.h  |   11 +
 tcg/wasm32/tcg-target-has.h      |   22 +
 tcg/wasm32/tcg-target-mo.h       |   17 +
 tcg/wasm32/tcg-target-opc.h.inc  |   15 +
 tcg/wasm32/tcg-target-reg-bits.h |   12 +
 tcg/wasm32/tcg-target.c.inc      | 3985 ++++++++++++++++++++++++++++++
 tcg/wasm32/tcg-target.h          |   76 +
 34 files changed, 5569 insertions(+), 33 deletions(-)
 create mode 100644 tcg/wasm32.c
 create mode 100644 tcg/wasm32.h
 create mode 100644 tcg/wasm32/tcg-target-con-set.h
 create mode 100644 tcg/wasm32/tcg-target-con-str.h
 create mode 100644 tcg/wasm32/tcg-target-has.h
 create mode 100644 tcg/wasm32/tcg-target-mo.h
 create mode 100644 tcg/wasm32/tcg-target-opc.h.inc
 create mode 100644 tcg/wasm32/tcg-target-reg-bits.h
 create mode 100644 tcg/wasm32/tcg-target.c.inc
 create mode 100644 tcg/wasm32/tcg-target.h

-- 
2.43.0


