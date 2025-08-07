Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456D7C87FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 03:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujqto-0007g2-5a; Wed, 06 Aug 2025 23:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujqtd-0007dF-1C
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 23:02:26 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujqtZ-0001LB-4H
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 23:02:23 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-23fd3fe0d81so4884995ad.3
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 20:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754535739; x=1755140539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VNM/Alx3viiry5FgrdkPI7g05gTkH+/25lDnLA+8uy0=;
 b=NAN9P7xqjHq1Issym6aINiwmgLK28vnzTt7MObmFvaG1rLYgeVRxmTdZxajClFlEMi
 /R48AwPfsHYFuj55nUDZ7W3yIyAzZWxBjsu4BludLIJep6ASOM/mshhUKcOXqJMVA0Ox
 xvXEIGstDhQroBrE5E9WFwfvSuSZGcGPeLno5ck8FZZAOMEl2U9Kp23YUQgwR687Txfz
 TUyfw8leE84YmYyXDqQsIwqFlrzwix72nr0oz0pt5U/SwtEgcLNnPgRTn7B8z7Jg4wyl
 RCXp7q6YZsp4pGzdYc/pmxg2XxjGZXB9K4M4QJ81nI7Kb8nr/QmypB81A0Xc2iQMU58b
 T7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754535739; x=1755140539;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VNM/Alx3viiry5FgrdkPI7g05gTkH+/25lDnLA+8uy0=;
 b=icwPVDJ3oWmWyqHkDqK0PjtV7bJyy7NMCJotdalvQn+gEPj2pGsn/14caxgptdU21w
 gbNPPdtDrYICAJXBeTlN6bfUW8YNSj+ZeWvVBKddTrpZle1nCyN0Wl/P0iApUIoWX1sH
 UfuXYPwAuQyULVgvx8lmjjswP7wjKZxTq/+Hw4DWFme0ph/cJ5FD7hxkX0zljlCCjFXY
 z2ec173NHTuq89KbcUBdA49ZDc0LJthPHti+H2SojjaNmsnPfu1GWwQIfc4LmA+VrMIP
 G7qOv3Af2+QrMEksejJDQbqvmm4QJyoVF5ZzvdqJSCLcmHCpRihO+WDYUoeL9Tev2Ayg
 ZCbg==
X-Gm-Message-State: AOJu0Yzi3E/ErZ0SnDf84TVseZ5zMUco0GdSkLXSJF/wMq7fI4RF6aJq
 zMLU4jq9Tg+kDuPzfOJ1ESCdp8GIaFIDZoMznjv374RtxMpMCFY0Mg5qcB1nrg==
X-Gm-Gg: ASbGncvH9QDqXq0tH8fBmGflzCt6UP1CFZpawusJU4gI9XNtKfim1JseaqUsFy2GcHU
 e2XNMI/TKG1fh2TWRN3RMMWJX1EDaMq6Rz6V5CRKWmh1oxX6r+284Aog13a8P+CCWwUJa/2wW6P
 h57GKNt3U4M5mhQXVbCY5AmjvQ6rqoS6ljJ37SmGqAzvGbxrK9qTuH//RfZuOkm8p3mz9llaIKl
 VrXzE8hBqFLUAB3hvKk7SOyzSChMbc7IkMjSjIl9AcQDtAm2C2scdvL8ajwXzfxK7+y9ZR2TwDa
 2AUPIKpTqYIBDuAuioXNlrZgdd1oBAiNoRVWuoQw0bde7XpJzj/B2YXdM+r0NRganO7L48nIUuG
 C/7Y6gvZiOAyGxCyRIyutxw==
X-Google-Smtp-Source: AGHT+IFFKQ+ai/sUPnLfVuLGWVVklfwXuRwtFkM0idYpLdlA3pVwCTWmN/yp4Zz8cjOCXoEAlzOgzw==
X-Received: by 2002:a17:902:ebd1:b0:234:d679:72e9 with SMTP id
 d9443c01a7336-2429f1dbd61mr73472175ad.12.1754535739173; 
 Wed, 06 Aug 2025 20:02:19 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:81e2:9f1d:777a:7b46])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef6ac6sm173154585ad.1.2025.08.06.20.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 20:02:18 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v3 0/4] wasm: Enable 64bit guests on TCI using wasm64
Date: Thu,  7 Aug 2025 12:01:59 +0900
Message-ID: <cover.1754534225.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62e.google.com
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

V3:

- Renamed the build tests on GitLab CI("build-wasm32" ->
  "build-wasm32-32bit", "build-wasm-wasm64" -> "build-wasm64-64bit",
  "build-wasm-wasm64l" -> "build-wasm64-32bit"). The same change has also
  been applied to container-cross.yml.

V2:

- Added a link to the Emscripten documentation about -sMEMORY64 in the
  configure script.
- Changed --wasm64-memory64 flag to --wasm64-32bit-address-limit to avoid
  exposing the -sMEMORY64 value directly to the users.
- Fixed GitLab CI to use --wasm64-32bit-address-limit instead of
  --wasm64-memory64.

V1:

This patch series enables the TCI of the Wasm build to run 64bit
guests. Unlike the previous series[1], this patch series is implemented by
adding support for WebAssembly's "wasm64" target which enables 64bit
pointers.

In the previous discussion[2], the main challenge of using wasm64 was its
limited adoption, particularly the lack of support in our dependency
(libffi) and some engines such as Safari.

For libffi, I've completed the addition of wasm64 support upstream[3] so it
can be used.

To support wasm32 engines, this patch uses Emscripten's compatibility
feature, -sMEMORY64=2 flag[4]. This flag still enables 64bit pointers in the
C code while Emscripten lowers the output binary to wasm32 and limits the
maximum memory size to 4GB. As a result, QEMU can run on wasm32 engiens
while still supporting 64bit guests.

# Overview of the build process

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
                        --target-list=x86_64-softmmu \
                        --enable-tcg-interpreter
emmake make -j$(nproc)

If the output needs to run on wasm32 engines, use
--wasm64-32bit-address-limit flag. This flag enables Emscripten's
-sMEMORY64=2 flag[4]. (Note: --wasm64-memory64=2 flag in the V1 patch has
been renamed to --wasm64-32bit-address-limit in V2)

emconfigure ./configure --cpu=wasm64 --wasm64-32bit-address-limit \
                        --static --disable-tools \
                        --target-list=x86_64-softmmu \
                        --enable-tcg-interpreter
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

The sample repository[5] (tcidev64 branch) provides a complete setup,
including an HTML file that implements a terminal UI.

[1] https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg05376.html
[2] https://lists.nongnu.org/archive/html/qemu-devel/2025-04/msg01795.html
[3] https://github.com/libffi/libffi/pull/927
[4] https://emscripten.org/docs/tools_reference/settings_reference.html#memory64
[5] https://github.com/ktock/qemu-wasm-sample/tree/tcidev64

Kohei Tokunaga (4):
  meson: Add wasm64 support to the --cpu flag
  configure: Enable to propagate -sMEMORY64 flag to Emscripten
  dockerfiles: Add support for wasm64 to the wasm Dockerfile
  .gitlab-ci.d: Add build tests for wasm64

 .gitlab-ci.d/buildtest.yml                    | 26 ++++++++++++++---
 .gitlab-ci.d/container-cross.yml              | 20 +++++++++++--
 .gitlab-ci.d/container-template.yml           |  4 ++-
 MAINTAINERS                                   |  2 +-
 configure                                     | 16 +++++++++-
 meson.build                                   |  4 +--
 ...2-cross.docker => emsdk-wasm-cross.docker} | 29 ++++++++++++++-----
 7 files changed, 83 insertions(+), 18 deletions(-)
 rename tests/docker/dockerfiles/{emsdk-wasm32-cross.docker => emsdk-wasm-cross.docker} (85%)

-- 
2.43.0


