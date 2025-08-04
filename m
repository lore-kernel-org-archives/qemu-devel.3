Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC6AC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 13:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uivhg-0006Nu-Hm; Mon, 04 Aug 2025 09:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uiulC-0004LI-3f
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 08:58:01 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uiul9-0000Rt-G0
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 08:57:49 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7698e914cd2so4298679b3a.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 05:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754312265; x=1754917065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4Ou1EzKr76Oqq1Kf+6va7jAMq3p8Sa43C28/ENtgZaA=;
 b=FuX8p6XDZMRZE+8Ep0tBCmgfFE+FedIWfZLI5c0bSB6PW7frZcW0dLsCfTDFjWA9/P
 gDsCopdPD0GsMpfuyzIEV/+3CJZrJjNECsbxtJrRoGP6Fqo9DKiwb/k/low9EHbFb9h8
 QPbty3bxp/5DuUO0p2MB0SZRDV3zwrQgoPnBsjqG5HcGtlaOm4HyvtdBM55SVZ2j3P/V
 HetVihh46PZRETNx54/3ncIdxpVhuccU70EyAr128wWMsTDET9PD9K+E0Q5logg69IxA
 998Vafv8J/Ymqrkcu2VBmPBaJmjMywPkpy6kQ4+7vkxiNqCfyRqc2J7lmBAagG8qglm4
 U4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754312265; x=1754917065;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4Ou1EzKr76Oqq1Kf+6va7jAMq3p8Sa43C28/ENtgZaA=;
 b=MzLkZKZqa+S2xSjo9niQgXVs6EVg3sLA3FgcP+HEOxQzeGd5VvP9vwsrNkhRzqtEym
 duwJKCKwySUUD9WrMkR2LlLl4eLd5jJPz68zNmtlZkHzTMxeK1vhk3+QASortZQJ4oLh
 INYfvJuvz1GpRml+DX9Ck0hVXcP4ITfoupKwcQ1Ea3TSsbZEO6qvOex3jquuQJks1k2b
 4vrf+hyBVz06l3HlHyg5VvHcZnil0dpg6RM1vVkgIj/+fv/MjBFMATJLPJBFJ+Q3qh2Q
 pHD6iU07YjEle4UeT3sAVesL1Iy8whVU/2eRXcI9yQ+Um+I3/prLC/O33G/i9puIF0l1
 SQmQ==
X-Gm-Message-State: AOJu0YzlshW5L9kZtEEQOAA3epismO67ID9c3tMHCLcEHkHRocS7+q3J
 PwcL28ipDDZVHxSt2sEbWr58r3FO2AjcXE8FTSsMhKwpl5THpeUTUIiCIRi2pg==
X-Gm-Gg: ASbGncup4RbKG8ErnsuFSQILkci6Ac787jpwZ2Uvq189LuIr4qs9+9OFyXPRRXpGv4m
 AnFMQVL47ctMDF9D4g5GtpUYbkYtMM3qRdlSkwJDaZbW5AnVAJf7MKoh+p5byw6KAAvrPi+gaHE
 5ENGKj/66RpY73UIChXUZrz89r5cjjXJ8Cnq0qRWbtEFPIUs+SQ+saoYlmyVoB9yeyGPd/5lXN/
 xFHylx2Tyq06wBuLFchgsIgooJMWeQyccLNY3jDxIszrkeJLkoYrDksZDRKk70b0jIVp5OMIvxx
 FRlIO53TwKuPl4hWjyylT2hs7r40Q226UPiXAkoSYdKSKneluCFtyrOo0seMrxC3PJcB20KeIQ7
 dO8M1U/cxVplwu/u/T0PIyg==
X-Google-Smtp-Source: AGHT+IFdsI1752nXQP1dymV9MnBwpvn3AEmBLWYlVYC5WVT9wyU08KI8f1eMGo0Dbe55mgY+lNpiEw==
X-Received: by 2002:a05:6a00:23c8:b0:748:eedb:902a with SMTP id
 d2e1a72fcca58-76bec4d2292mr10138988b3a.17.1754312264991; 
 Mon, 04 Aug 2025 05:57:44 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:d117:15e5:e721:f1cd])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce8f800sm10488308b3a.42.2025.08.04.05.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 05:57:44 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH 0/4] wasm: Enable 64bit guests on TCI using wasm64
Date: Mon,  4 Aug 2025 21:57:13 +0900
Message-ID: <cover.1754310749.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x435.google.com
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

If the output needs to run on wasm32 engines, use --wasm64-memory64=2
flag. This flag propagates the value to Emscripten's -sMEMORY64 flag[4].

emconfigure ./configure --cpu=wasm64 --wasm64-memory64=2 \
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
 configure                                     | 14 ++++++++-
 meson.build                                   |  4 +--
 ...2-cross.docker => emsdk-wasm-cross.docker} | 29 ++++++++++++++-----
 7 files changed, 79 insertions(+), 16 deletions(-)
 rename tests/docker/dockerfiles/{emsdk-wasm32-cross.docker => emsdk-wasm-cross.docker} (85%)

-- 
2.43.0


