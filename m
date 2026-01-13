Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6001D2D105
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 13:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vferH-00038C-Cx; Tue, 13 Jan 2026 08:54:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vferG-00037i-A3
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:54:54 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vferE-0000Lr-8p
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:54:54 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a0834769f0so52420995ad.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 05:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768312491; x=1768917291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fDnPyI7NPiNXP8nlPrhXeSrPIlabxti57X5AZJh4Nxo=;
 b=BZHeg2uK9LrDpsA/VxIwLik+58F3RdkQBgj6CTK0XZ74BzzYoytERCzDSweFZ+Q6FI
 0HtQi1d0o84NFotpU38P5G07I+/vIk6yp9fWqdj6K4zfx5+ul769Db2YpjHixlf4MY27
 F8xGEcrFf+DZ8tweFKqb9Lh7gWsZ+Lzzi6Wv9Gl08zS3f8S7+4q5AMYA5MA2+eMbIaGg
 ReSeDnxenhD6Bf/qvCuspOOhThnG25ZiT1HMLjxbiuiMMC7xzDCswBdj1OUe6AzzcPDR
 a6yN1BqnTrmjd9YIJaAdzJW/jPZCyFjlXnYzzCzcniv04vBGERGTOR+vG8S6zcYkRDn4
 EcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768312491; x=1768917291;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fDnPyI7NPiNXP8nlPrhXeSrPIlabxti57X5AZJh4Nxo=;
 b=AYA5GCXP/52XpnrNKL+RalYIaOPMnZaGKlQB8/4KbvE/+u+0b/NVowF8O7czZ7qXtv
 V7T43FbvAu07UMNhJhTVFl+SGElpyCuvhbxN1WZ/zCvbui8Z9vckrUs2avxTr+4ZrWEk
 TzQQ4XtfUjk5p5ZrH409wERfNlfafSOONnGfjeMa3WrpYqvQU0tZ6kYUc8ev7+otxRR7
 XAtYIGf2Kc/7UILRmoTKxJBFGa24wylJr+0TENHSV91AYVSXYoa3sd9OgEuN/AAYp6cC
 A8aqHl/RwYgq0a6s3nkjITTSLYu3hKlVAp7CVH4JWqA08B8LEyy60jBDeptF2TeE57It
 W2OQ==
X-Gm-Message-State: AOJu0YwMn9dEUEN8eE1FH7DGxKLvfFFwAi8Sp38lhyqdrwgw89R0w6RQ
 nwvnfMwX6SPNoLffOECtDM5gLnd+RATHyZ6iUrIeVvtpauxX8IOND/q6QhdjaqM7
X-Gm-Gg: AY/fxX67Uwcfq/N9JcVGTSI18nkOCafAGrT0si4D9H5ovWyaZiUQwGCLlz3AxWQmw1K
 fEzD/6mClVWaSReT5jgDUCOtQiRQxg9UI3k4JPIkNu+hfUtHDECvs1SZM/JQNxhocpMsqDhNLT8
 h0odOFrn9vpfV1wA9BK5FCcEkCACFqQhlWVTxPzhfdeJvypf9Vq9Kn1yKHM6+uaFD1MDhZ7yjH/
 PvxTI/AM4FngXBEING3DTqpmfO7g9ysMbsH+QEPtf9O73YY3Vo13ISZvnHOHpMUk3pJfldGijZz
 0kFFEGk2CACHb88IUfVsjZpi5LCFFBv6nQd+qK0PNa8HcZFuCWngAmef/oKdb2hJ6JUKEKLEHOX
 dlekx8Ez9AeS1+zQM5JZdbCQG3VFTASgwZp5fq45+dhFC2RS9/Uhvy1JYRjilRVqr00oyhPXog+
 hyYX8YCoT60g==
X-Google-Smtp-Source: AGHT+IF/0NnUoBvl/4c559Ya8K2Vnu7JpOSJaPOga6FwnVSszq9IpLg2j2RoTTGTJMCigmq6KLfmQg==
X-Received: by 2002:a17:903:2f44:b0:29f:3042:407f with SMTP id
 d9443c01a7336-2a3ee4343c1mr217829565ad.21.1768312490511; 
 Tue, 13 Jan 2026 05:54:50 -0800 (PST)
Received: from ktock.. ([240d:1a:3b6:8b00:eb29:7536:a39f:7476])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a2eesm38240465ad.6.2026.01.13.05.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 05:54:50 -0800 (PST)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 0/4] wasm: Enable 64bit guests on TCI using wasm64
Date: Tue, 13 Jan 2026 22:54:27 +0900
Message-ID: <cover.1768308374.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x631.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

V5:

- In emsdk-wasm-cross.docker, removed -sMEMORY64 from the environment
  variables (e.g. CFLAGS) in the QEMU compilation stage.
- Updated the Dockerfile to build dependencies always with -sMEMORY64=1 for
  wasm64 target. The final QEMU compilation can be lowered to wasm32 by
  using configure's --wasm64-32bit-address-limit flag which enables
  Emscripten's MEMORY64=2.
- Fixed wasm64 tests (build-wasm64-64bit and build-wasm64-32bit) to share
  the same wasm64 container. The build-wasm64-32bit test passes
  --wasm64-32bit-address-limit to the configure script so that the output is
  lowered to wasm32 by Emscripten's -sMEMORY64=2.

V4:

- Rebased on the recent tree.

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

 .gitlab-ci.d/buildtest.yml                    | 24 ++++++++++++++---
 .gitlab-ci.d/container-cross.yml              | 11 +++++++-
 .gitlab-ci.d/container-template.yml           |  4 ++-
 .gitlab-ci.d/containers.yml                   |  3 ++-
 MAINTAINERS                                   |  2 +-
 configure                                     | 16 +++++++++++-
 meson.build                                   |  4 +--
 ...2-cross.docker => emsdk-wasm-cross.docker} | 26 ++++++++++++++-----
 8 files changed, 73 insertions(+), 17 deletions(-)
 rename tests/docker/dockerfiles/{emsdk-wasm32-cross.docker => emsdk-wasm-cross.docker} (89%)

-- 
2.43.0


