Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E9CCA0EC1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 17:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujhYf-0001h9-8A; Wed, 06 Aug 2025 13:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujgP5-0005dI-Uw
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:50:11 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujgP3-00035q-M4
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:50:11 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2403df11a2aso46573465ad.0
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 08:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754495408; x=1755100208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/hhxVpoetzMDkpH+BkDjKcH9xZaCMmxw/1RApGRB4ZM=;
 b=Mxbp7b/B/kYRFtoS1HrRZNLYzTOGn2grzw4zxRw5EhFtGaQC784gN1sfrDbvKPebxy
 lHwkyHeN8aCUYP/fcaux6sAw/k3LxD9eoOvWJJkyWwf2MwdCIi3l3ESLw3gwfk8WFjyz
 IC2f/mbwa9FvYeimDGzd+Utyvog/V8f6MIgIBIjltOyXL26iRBIqrxQqOkzeLMu7SHmE
 i8FU/DyvYSAy+5oWgTwUXLyuyVdb3DepzlV3ICgDa9PrWB39BcXyDiQVRQRzZNHhBkRz
 AwF06b08F2bXrZR8Iaf0rTuC8cZF30y5I15VAHrJfHjRcNWIDSDGnU6NgdQXBXHPyV+r
 MkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754495408; x=1755100208;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/hhxVpoetzMDkpH+BkDjKcH9xZaCMmxw/1RApGRB4ZM=;
 b=voVGj9heClg5K14ccStTaqqj9PFueb8RSoVwmPTe7qPnuTMRSGxt1MvB1bt9Wl6jA0
 GJvRc/Su0JxjYxWfPlEryQI+jwuQXHvRXxUgRiBgDYqr3A0jQsvHkh+gWGSv7YaCxrC3
 dap2dUjYj8rClTFbR8xLRQ+j2Uw5/AtvwIE7zSfa6aTGJ9TDfV1SOLtKACso5ZEff2zr
 Xi82ueZDpuUa0m6xMZ6IySvuQ3siUnPpa+sQye5hLk4g57ZwK+VrSx6oT2aVuyG+8U46
 XNZcN+Zlk1y7tz1Me7XvpCwtG+k/Lgq2KSqWLFP1RNDFTCd7mchbBNDN6TzAmch5PWw8
 JaQQ==
X-Gm-Message-State: AOJu0Yw2olrbMJSWagv7hBc0JpI2AzkCoqnpRhl3dpokKdy27KVHU5oZ
 f94TbkenHm7QTvDPm7mpeija8NPF3jdE9rpyseKeM3E/7LpvVwBpp0U9dhfUsg==
X-Gm-Gg: ASbGncso/uPKhZeSqbLWB+lQ1sj/RM1EkT3hECCdHA6sJE5CiOgJYkHsDwuFrukqsW0
 vHvA5QoOawgYC/2cjNHVIJfl7WW0/YGjH76tXucVKdtAFH9i3qWa3dev5PLVzeQ2M2hTjxUIoUy
 lY9lZ4lgi+eG8U7Mg8ze4Vi+Cro3qE6g6C4jcJfHROC4xbd8//Gxh1FEEgi/aIohgWkxZxwfsv8
 CHaeHjpXnhq6IsdV4LjUbYmCTBjAkk2m2RRfjdVbcJqaheu/rnoijkjeCuCer1x7mYVRYPFeNJc
 dQ2ZdtJKQ8BwNRjrldwmeg1VobyW9wGfcYCShtg1DmdiWXmey9ohdoVn88YLJ61GHfp195N2cMm
 b9G9Jlhp4M2gdalY4EDo0SzsJYIQOwUB9
X-Google-Smtp-Source: AGHT+IEeWfulLiFYV1LpG7QpMFoM9epSG7yJvFYj7fX6+WMUnvCtxoTrLnPzCFgOSTlc6iybk/3vlw==
X-Received: by 2002:a17:903:174e:b0:240:6e54:3cd1 with SMTP id
 d9443c01a7336-2429f521a22mr47883625ad.1.1754495407962; 
 Wed, 06 Aug 2025 08:50:07 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:4cca:cbdb:3f01:1165])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8976a3asm163374575ad.87.2025.08.06.08.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 08:50:07 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v2 0/4] wasm: Enable 64bit guests on TCI using wasm64
Date: Thu,  7 Aug 2025 00:49:47 +0900
Message-ID: <cover.1754494089.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62f.google.com
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

 .gitlab-ci.d/buildtest.yml                    | 24 +++++++++++++--
 .gitlab-ci.d/container-cross.yml              | 18 +++++++++++-
 .gitlab-ci.d/container-template.yml           |  4 ++-
 MAINTAINERS                                   |  2 +-
 configure                                     | 16 +++++++++-
 meson.build                                   |  4 +--
 ...2-cross.docker => emsdk-wasm-cross.docker} | 29 ++++++++++++++-----
 7 files changed, 81 insertions(+), 16 deletions(-)
 rename tests/docker/dockerfiles/{emsdk-wasm32-cross.docker => emsdk-wasm-cross.docker} (85%)

-- 
2.43.0


