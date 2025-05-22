Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F263CC54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 15:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI7gO-0005CD-8C; Thu, 22 May 2025 11:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uI7gK-0005A8-GJ
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:18:04 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uI7gI-0007hq-6m
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:18:04 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b1396171fb1so4671351a12.2
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 08:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747927079; x=1748531879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rvg2UlH6jf+nRIXvLdTGrLlkT7w11xuha3nJjKC5QcY=;
 b=egbkdK/VfpJxTDIMpZD0sAybaLj2onOJEjfy2+yVi9TcNQ8c7CmfVzGlgPDTG0zeyi
 xIPmYUOJZ2MVymoEkmxMpgtYaH/0hAHVQUMgSBWXRUAEKTn0b14uh9r8f3d9jAx+RSq5
 h3k/21hOUkaAckGfX71beQSCxL8QBAnbCRJuEkuUKWuoLbBiHJ0vKRLtTJ57X6tGKzrM
 KYF9FyjPyQsChzEJ9kJ3c/LHQ2oJLtlvsA0egBlCrQA6poA9e3+R50c7QCEjSrfjt67u
 IoYDBgBwezKv9zAvimkFDa1FS+jYZXf3B4nwhALu0FDgS9B5VqLdR2xA8emmFPzsIJJ+
 3W4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747927079; x=1748531879;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rvg2UlH6jf+nRIXvLdTGrLlkT7w11xuha3nJjKC5QcY=;
 b=pFOqIphiE8cEXyYtHRtkGneStPL7R5ypKAurxkTG1hCAoAASFsphH21H0GiZ2hwjWt
 REeKki/fsobcn0/0WYVoZ8nhy0K+f1w7+iyT7LBJwDUicyLMqI5q4ejD2Bs5zzgnuxA5
 1eSE3kASTA1zOsWDD2cgmH7g3rH2JJYUra7FUSU9sBqZP74FLlC2WZabwnpTV+ejvpYT
 Uiq8zWta2w46W6V26T+qyGpGEnj3ZPD2+dEqxDPDLW5WZltMhi6n4KszlGNBkUcQrG4X
 9jUwSLafC0qczwf6sAkpwFzOJ8Vvs/tVGIolUI1Nck6WwcFoyDNJwclqOtVOSg5d+Qzl
 3ElA==
X-Gm-Message-State: AOJu0YyGUT9W58NODfPeUe/2zxSaaGjERHeXYszhlKBlaHr4eVlUmagn
 cbbG1nvyol43cnx1h20o3cvv5Fi7AtAW1OdUioVNvG7pCo3FimI+v4CKz1JfRg==
X-Gm-Gg: ASbGncuqRZdTkh7ErLc8T8o5YPMNEiqwmufl3U1PRP9NGzVGaUkAyx+t3Fk75SQJePl
 2QFBuwoFudFAv11Myox84v+A0JKnm25TqB70y7fDz7PhCLu1RnnHlMZLck1bBhIB9ehmEwnfREN
 kUf9w0TozHlAgWtTmDCkQDQDJIQv0qI0RXQJ+1i2TCORkDt76iDm/EWbm+XxuD44WBT8/Jcz6eq
 62Gvj33Rt0jU2wiO6BYwFyojSFYqaeXOPX69q3mtoFGiPW0xsaz6mdzOZOyAqbt+x/+PnXPpZey
 wNmF/zpUCUW0wIOdiHxd51lbk2Xj+pd0to8k+u8qRZIGv6V1/DM=
X-Google-Smtp-Source: AGHT+IGQhqFhPAldDe+Sht7STTTKHjiyqWe5tKDLP4t47DsJ80enjdb2r1HtTmUwtKGBxWpSANlLIg==
X-Received: by 2002:a17:903:324c:b0:231:e331:b7c9 with SMTP id
 d9443c01a7336-231e331bc2emr309521525ad.10.1747927079205; 
 Thu, 22 May 2025 08:17:59 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:c732:a88c:b916:8b9f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4b017dasm110443555ad.98.2025.05.22.08.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 08:17:58 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 ktokunaga.mail@gmail.com
Subject: [PATCH 0/5] Enable QEMU TCI to run 64bit guests on browsers
Date: Fri, 23 May 2025 00:17:25 +0900
Message-ID: <cover.1747922170.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x530.google.com
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
browsers" series, focusing solely on supporting 64bit guest on QEMU TCI
compiled with Emscripten. The implementation is based on discussions from
the thread in the "tcg: Add WebAssembly backend" patch series, particulalrly
Paolo Bonzini's suggestion to introduce TCG_VADDR_BITS. Thank you for the
feedback in that thread.

# Running 64bit Guests on WebAssembly

The current implementation uses Wasm's 32bit memory model. This series
explores supporting 64bit guests while relying on SoftMMU for address
translation. To achieve this in Wasm today, it was necessary to partially
revert recent changes that removed support for 64bit guests on 32bit hosts,
specifically those related to pointer width differences between host and
guest (e.g. commits a70af12addd9060fdf8f3dbd42b42e3072c3914f and
bf455ec50b6fea15b4d2493059365bf94c706273) when compiling with
Emscripten. While this serves as a temporary workaround, a long-term
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

emconfigure configure --static --disable-tools \
                      --target-list=x86_64-softmmu --enable-tcg-interpreter
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
    '-nographic', '-m', '512M',
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

Kohei Tokunaga (5):
  meson.build: add TCG_VADDR_BITS for defining the vaddr size
  include: define vaddr based on TCG_VADDR_BITS
  tlb: specify address field size based on TCG_VADDR_BITS
  tci: define TCG_TARGET_REG_BITS based on TCG_VADDR_BITS
  tci: use tcg_target_ulong when retrieving the pool data

 accel/tcg/cputlb.c             |  8 ++++----
 include/exec/helper-head.h.inc |  9 +++++----
 include/exec/tlb-common.h      | 18 +++++++++++++-----
 include/exec/vaddr.h           | 28 +++++++++++++++++++---------
 include/qemu/atomic.h          |  4 ++++
 include/tcg/tcg.h              |  6 +++---
 meson.build                    |  5 ++++-
 tcg/tci.c                      |  6 ++++--
 tcg/tci/tcg-target-reg-bits.h  |  4 ++--
 9 files changed, 58 insertions(+), 30 deletions(-)

-- 
2.43.0


