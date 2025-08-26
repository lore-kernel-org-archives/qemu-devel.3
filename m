Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FA0CA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwGj-0003eU-Ap; Tue, 26 Aug 2025 12:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwGc-0003dA-NX; Tue, 26 Aug 2025 12:11:26 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwGa-0007k9-16; Tue, 26 Aug 2025 12:11:26 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-771e4378263so2027282b3a.0; 
 Tue, 26 Aug 2025 09:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224676; x=1756829476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H7vt7OkiXHUEzx/G748B2BYGM/w8l4INmskv00Nw7Dg=;
 b=i5cxq/TRPLW6XfpYR7lLeVtjRJHQKqjGDiHK0jM2nVNNRLQ02UjPZ8DkQPEaBb5+t8
 V/kBxAGzgZZCkngge5Aj084sM98Hmyl5zmrMIsUO3IE5hxSrFlW8duQTkWdn8B7VB4tK
 IGOUy8y44t79r5h3AxVLA5tHSi+VB3IWQW8UhtkJ2kk99FBn72VvBTfBYRHgwZoXBw63
 TzQQegjv4Kit7Wq4+YA9O74LUm6eHWaXXzEmOHI7/NEpIsTA2GI9F8wjZW7Gi5JD1hKl
 pkZRD8v7FH/S+No+kBdZ/2il0wpya+0QMs9HiIZrAJwxaLHEAA+KonGznV80KXf1vZ2F
 LZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224676; x=1756829476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H7vt7OkiXHUEzx/G748B2BYGM/w8l4INmskv00Nw7Dg=;
 b=MmjfkYn0v34y3TakXiMl3uJ1+ZRDGZF8br1tmQde4LXxJ4WokIYd+9Gl2AI8tq7WcD
 r83EZ0L0zmHTK3I328CauHble3wMMb0QNSzLTvZJ+1S8Pv/XcWSjt7ZreBK6jvBiERzW
 efk73tn9mVWJMyzcRbfbWqSLT4aV61ey+H5Rk92UQiAe2bUOWHxoL41drAMYHdFCQEnd
 4ydHcSLCeo/VUgLj9o7lEVjSbK5ERa85un8l2XSwzkJXfZG9b2ukPt5bPekuTudabMfX
 o2GVHRd7LECk32KVQR0ubwn7jSgxi5SQpthAKcXovqJPbwU29fI5j30l/86SNPCoVewE
 HggA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGpx7T3QJVGtZtxhYy/72wOnjHDaExdUpQCwUxFRmi4KWL3MLCsMHIbZtQPU21MBJYQJ8QK6Wi/w==@nongnu.org,
 AJvYcCVZMJ0Hd1n7rrHwBiZyFtkKElKUej6kZyWMZ+Gz5wsGrkatUrVsyISK7ftryqwLlIy1y7HVL3lmYhazBg==@nongnu.org
X-Gm-Message-State: AOJu0YwakIWRihS39NRtGH+lxetmRqF3f3LJGSI+uWLpUh6NiE3PjDHl
 PmtIHqdw/0ynXp4L3XM9xlxdX5n/roWcEmzEpVutEuP7zKrEbl5QUWqG0ATZcg==
X-Gm-Gg: ASbGnctuWRSIGuYcq0T65VWk/atcOxhIgflwZRtDFXoZdz5kDreb40nWWptBuaIn+56
 qw4oP9BYBswGySXUSMMlkYnNVr36eflXyUYhEvkS5PX3cur8wtr0l82/zmqjQwHtTJRKxU9a2tn
 IGPFzhxU8DzNl1T/PXcCO88EktNqAwT/IeUr5yYaGfAquqI/gilJCMJz6WLgP/fYsdBxuKwPlXq
 eKSMVUORzaXarjueq1yPC91nKVGlAne/qgm1bvYkKC3I6JnqE1AU8J83bc4u4G8UH3WI0JGQJLo
 BSiygaoy3wbyiDeg6Qq89DzXewfv9mJ0TLHteCqUPWdSDhAsja6BkoWEbFx/yD4vsDKXkCmXvbP
 OIY55stJsOVl1KO4mpZxpKw==
X-Google-Smtp-Source: AGHT+IHilpOPTkNf8uCPiUoROCi6F+Ls+u7shiD3rkLBfSwi0ay05E/98XqzOl4iGC5Z/t61RpvALg==
X-Received: by 2002:a17:902:cf09:b0:243:43a:fa20 with SMTP id
 d9443c01a7336-2462ee8e559mr239368125ad.24.1756224676173; 
 Tue, 26 Aug 2025 09:11:16 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:11:15 -0700 (PDT)
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
Subject: [PATCH v2 01/35] meson: Add wasm64 support to the --cpu flag
Date: Wed, 27 Aug 2025 01:10:06 +0900
Message-ID: <33d88400963d0da84f44296306c4e39af1f3cf5c.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x429.google.com
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

V2:
- This commit is under review in another patch series so please ignore it
  here.

diff --git a/configure b/configure
index 274a778764..112e4725fc 100755
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
index 50c774a195..44bb7ed334 100644
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


