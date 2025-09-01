Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADB6CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2yu-0006jl-Qq; Mon, 01 Sep 2025 07:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2yk-0006c7-UP; Mon, 01 Sep 2025 07:45:44 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2yc-0001Gm-IH; Mon, 01 Sep 2025 07:45:41 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b4c72e4f1b6so2240214a12.1; 
 Mon, 01 Sep 2025 04:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727128; x=1757331928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PJjbFuVAPTI7U71p25kyRaD/FGclmStwyCKrbtmghs=;
 b=jRF6w8M0IJHrZXpE4O9ehr9i2T9b2U7kjnpMD2aQDTiuUX+iA86Y9zTmYd5nccgxBw
 QXYBuLXrFhfn77qwLJ4N8I7Mh8drbVXPvI4FuWyvD2gmJG617yaBRNFG5hnYtx2L439/
 QkyxSsUz6xZoxDPC2Ntmebf0kpIGsqn0CXglewfCBJu/cfrpKQOP3xoFfy7gpEJlAlg5
 ky0uuzT69C8nA3l0ghv9pqjd5rUlWJm/x+NkKPs2d+4WWkxXFlV17WPcIz7y5cvGptio
 jgWgAIr9WbNsiYm+VzDLFRr0vrdtZhlYjlzzkw9FWQKgvafXxT4QUNWpd5LiVmGVBRHB
 3IkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727128; x=1757331928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8PJjbFuVAPTI7U71p25kyRaD/FGclmStwyCKrbtmghs=;
 b=kIp2pFigla1QS7Y9YpMcvSMNe3LlvjXJd5htgklLH1s8l0H8oCaT2aHM6n7ogdPYx+
 zudJQ7KRwpbKV2S8kluvSkw7YTTcQZ2C+tMId4x/NC23wtpw+zy4RXYGQ9+HG6VVjKAL
 s0kyYMknisfldqaiYjKqUdBPrz+G6fffQMywZ4EKSETTZk2KkKlKPNpDS55OkZ9BO6Dx
 XwVYhuA+H+4EmRUsAF/GH/CpLkGda3SRtAvMoRekS71q+CMGNkO81U8UbBeYXu9ZNGio
 gzBdKe+OXnh8VZ/b7Z3WP7qEFc9QBYoWuL7CAmxl2PvCsjqxiFZ0QFKzqAjJmlJpCdck
 BX9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhGmSxb8D5necKLQ9qjrcLHgdbeo3A6c9dAOIBztue4KvT9XaxnU1p7mMT+czmRr2xtL8jett+WQ==@nongnu.org,
 AJvYcCXNDSRUYFC5DFgvJ4pbXTyaqp1rZgBXGrStshF6sOZb+FXrkke+TlMSO7TlR33xEIn9jmWycG8TLJulZg==@nongnu.org
X-Gm-Message-State: AOJu0YwDPCfHpOvkiKcDDJvzzM92tSUfjP6hYB3JyE3HVM7NHE/zkqE7
 JKIAEgnbG+xKzPEySvw9fFZnrGKwL3vwl5WHB4IieQiSp4PLAOVfjA7YUHgILQ==
X-Gm-Gg: ASbGnctJHuG5geChZDXP3X9lvJx+y542iSKwHMBJ8FmB/mHyB/+Cr3JCBTZ3bGVMz9e
 A7IIAfz6oSR/QyGxzyRpvNLHeHQRNvpA0fCTQG9MKtZJLreZPPBDDWYo5WznQIPEBmR6H7c0/Vc
 0lNEZ1NYGbgt0jRaT5tL62S75qQtv1/RJJel/buTMsnjpxnfrE3/pu4CNqXaEeDHd6Q6lcuZJk6
 ek23NrrpNdEcLn+oCOz+xNERFvkubDi8VjbMbHwuoNsJzGb64PxwwmGImCu2mQ5Gnnjahk5lVko
 ASkg3HGopNxyXjhR8MVCPXF0RY/2SUZnMerVsq6zEi20t+L8Se6N8RbftmHY8T/Aj4PtaY3lpq5
 I34qOAe8E7ZgO7l0H/0u4bw==
X-Google-Smtp-Source: AGHT+IEk+JR9rLQxwWFa2CL9gxcqSzd16zyWCdHr8aNXz6jrLhN/lSHLexK71nqTr/kN7zDED+mlew==
X-Received: by 2002:a17:903:3804:b0:235:f091:11e5 with SMTP id
 d9443c01a7336-249449037ecmr95371585ad.10.1756727128189; 
 Mon, 01 Sep 2025 04:45:28 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:45:27 -0700 (PDT)
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
Subject: [PATCH v3 01/35] meson: Add wasm64 support to the --cpu flag
Date: Mon,  1 Sep 2025 20:44:03 +0900
Message-ID: <33d88400963d0da84f44296306c4e39af1f3cf5c.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52a.google.com
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

V3:
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


