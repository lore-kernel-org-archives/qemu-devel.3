Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94F9CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 18:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoQys-0004r7-JY; Tue, 19 Aug 2025 14:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQyq-0004qE-JV; Tue, 19 Aug 2025 14:22:44 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uoQyo-0003km-Dg; Tue, 19 Aug 2025 14:22:44 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2449788923eso16448135ad.2; 
 Tue, 19 Aug 2025 11:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755627760; x=1756232560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FbK9ZmTXg2xQSJZsVexzLKV577HxgsyGAmP/Gwi0cg=;
 b=Pu3YEvS8M+QWRbHejBl6Lg9oG2OhbT6LqbgUxD6m3bbfN5zDfQOSGqcSs9pjGafcCT
 Wk5qBp0ZLBF/UgixEBXNH2g62tpJTBpV+6uz61AU20z1gzHgXwod87j40rUL13geaCS6
 u9xDkbmL6CvdYR9XAFOk4XZx74c3S6M3PEVqMEdOrSEMJfjEczJoCGEz8buolOcRyzKk
 4T7v8J9UVLYFdKcPYGVaRDcJWIDm7/gDx2bgcqgNOkp3FEWtqwnjlDeq73xkyEoM9JDg
 2fxipDESxESQMQV2b147Nlu3aG+cd8pXKMPNVnvgodXKOpy4Izd5VZt8EtDbWwu6Z63v
 JK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755627760; x=1756232560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+FbK9ZmTXg2xQSJZsVexzLKV577HxgsyGAmP/Gwi0cg=;
 b=ItmKB1GIxSEcjmu3f+kb7FTo/xMbxHeI7rc7WX6hsgc56eFJm8KCumAjNrKPsHxVVI
 MW8iCUmYOp61N02XeMGf4SKRiBDRBTo5hTp76zU7M+XmmInP8uthemmzpMkWLGm+3tg1
 wtG+UlJj29Ppw7IxvZcXMsyWXPGCvo8P/gm0J+1zbj5J93BrBoGFL+YYAQfhBHm6PH/w
 6Q9mneri6Xz84p8sTsvyPNh+KCYZC3Hz10VwitNH4Fhms7JZjhCDF1BirpGp7bQ/8LMZ
 GVt3LXi6713zFJhee1Jfd5idZKGBi31zonYh56/RROWsvjaMlGOFpOxFUcyOUlD2Is+i
 wUWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZSXII99Xz+rqH5PesdLbGpvVpau31gxZK2hJ1ZLDX5f0AeNKBzHBkMxV2jVOH8ikYqtd0PzAKsw==@nongnu.org,
 AJvYcCVFkhJ3V1VRjDaTjjEHP9kQWI9+l8re0V225WhXC5rIYOKWjgfTGdJODnBp8v9UhqPv5C+1I5hzeDRs6Q==@nongnu.org
X-Gm-Message-State: AOJu0YzpWwBMFBiv8bla+MZ6hRrZ4P4BHdOxRCh9A9/pIMctZuIMF86R
 hyzppBxfz6GKDyvXAHBrDoHzi1vbz1N4wOGPVUxqCceMBJLyWoveG/Rw6R4g9lsY
X-Gm-Gg: ASbGncs/W/8vl78xUmDya22B+VXTG2qlg1V7VJSScG/BlGVnizJxL21VCi5BTzEUS2V
 ryv57xSZ9WIDNYjqGRmBO5+tBGHkeTP4p+6nFlC1cHgZ8baTwEJ4EdBClI0IJGBQKwQ84VJ11WS
 on0zwRZvRZ7OSy7xa7sp6f0F/TUrvmnUBpU+dqtJeNRlki6+tgNmMx6/129AC8s6E4pPTrwkS1r
 PB0y5hC3nQst7iK3NI+CMbbvQ2sZtNuv8oudvoPR1slj0t1XqXcHlp/SJ4QF/gPU5kxoP928G0l
 s8Z/TbW4JoINqcqRs2S0fyUYUKdNa/A1JpJlUbyadXQYdM/zK81t0tXfR92ozuuVjBGhAViujvx
 dxTePukelu3GKdrKSfL4/YcWXwQOl8HIW
X-Google-Smtp-Source: AGHT+IEDH6izQI/U6+5s+QiG5ryEh4M4Zw+H4hvy/7aeTEr0e6FPH6hKsGVlP8FRZJvogGt+aAtfKA==
X-Received: by 2002:a17:902:ef07:b0:235:f143:9b07 with SMTP id
 d9443c01a7336-245e04347c9mr42010395ad.5.1755627760155; 
 Tue, 19 Aug 2025 11:22:40 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:29ce:ef58:c2c9:e52f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm3725125ad.25.2025.08.19.11.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 11:22:39 -0700 (PDT)
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
Subject: [PATCH 01/35] meson: Add wasm64 support to the --cpu flag
Date: Wed, 20 Aug 2025 03:21:30 +0900
Message-ID: <fcfdf0cc933aa46c4c3767bd8f23eadd31ab6865.1755623521.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1755623521.git.ktokunaga.mail@gmail.com>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x633.google.com
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

wasm64 target enables 64bit pointers using Emscripten's -sMEMORY64=1
flag[1]. This enables QEMU to run 64bit guests.

Although the configure script uses "uname -m" as the fallback value when
"cpu" is empty, this can't be used for Emscripten which targets to Wasm.
So, in wasm build, this commit fixes configure to require --cpu flag to be
explicitly specified by the user.

[1] https://emscripten.org/docs/tools_reference/settings_reference.html#memory64

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 configure   | 6 +++++-
 meson.build | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

V1:
- This commit is under review in another patch series so please ignore it
  here.

diff --git a/configure b/configure
index 825057ebf1..7f3893a42f 100755
--- a/configure
+++ b/configure
@@ -365,7 +365,6 @@ elif check_define __APPLE__; then
   host_os=darwin
 elif check_define EMSCRIPTEN ; then
   host_os=emscripten
-  cpu=wasm32
   cross_compile="yes"
 else
   # This is a fatal error, but don't report it yet, because we
@@ -425,6 +424,8 @@ elif check_define __aarch64__ ; then
   cpu="aarch64"
 elif check_define __loongarch64 ; then
   cpu="loongarch64"
+elif check_define EMSCRIPTEN ; then
+  error_exit "wasm32 or wasm64 must be specified to the cpu flag"
 else
   # Using uname is really broken, but it is just a fallback for architectures
   # that are going to use TCI anyway
@@ -535,6 +536,9 @@ case "$cpu" in
   wasm32)
     CPU_CFLAGS="-m32"
     ;;
+  wasm64)
+    CPU_CFLAGS="-m64 -sMEMORY64=1"
+    ;;
 esac
 
 if test -n "$host_arch" && {
diff --git a/meson.build b/meson.build
index e53cd5b413..291fe3f0d0 100644
--- a/meson.build
+++ b/meson.build
@@ -52,7 +52,7 @@ qapi_trace_events = []
 bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
 supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux', 'emscripten']
 supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86', 'x86_64',
-  'arm', 'aarch64', 'loongarch64', 'mips', 'mips64', 'sparc64', 'wasm32']
+  'arm', 'aarch64', 'loongarch64', 'mips', 'mips64', 'sparc64', 'wasm32', 'wasm64']
 
 cpu = host_machine.cpu_family()
 
@@ -916,7 +916,7 @@ if have_tcg
     if not get_option('tcg_interpreter')
       error('Unsupported CPU @0@, try --enable-tcg-interpreter'.format(cpu))
     endif
-  elif host_arch == 'wasm32'
+  elif host_arch == 'wasm32' or host_arch == 'wasm64'
     if not get_option('tcg_interpreter')
       error('WebAssembly host requires --enable-tcg-interpreter')
     endif
-- 
2.43.0


