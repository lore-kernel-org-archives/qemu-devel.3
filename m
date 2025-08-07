Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C92C87FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 03:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujquP-0007rC-GX; Wed, 06 Aug 2025 23:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujqu6-0007jl-5U
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 23:02:55 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujqu1-00026B-PN
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 23:02:52 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b4272ea5dbbso426851a12.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 20:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754535762; x=1755140562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJlOz+Jg5Eh+vkwIFvbU82F8MEu7BNgLBhpUCzS/X/E=;
 b=mS95ZPDYt8cyhN5CFqd1sR4UhnGYOs6rWXaK6UltMRsZSI+IePzuFu5YLQKk3k4alb
 hpPlw/c0w+lBM8Ch1fWKFuvmWXTovnu1lqZamB0gLAJjD1CyyBCShR3hBDTd1dHIedRt
 AMpOi1EPtRCMJR0NVTsS27DlQTb6H7W5PsUdkfXpQjsZxmuH7Vo0NNaU9FtWYOn/Tvzl
 6sOEhBfgJtPu1ubGWDzESseLtsM0p2WA9kwY2ZJUBLdpaWjgeoQj0wFgWeyBtL3/N/G/
 i/Ieon2bZqXfrwfCGwyoI2GRoEjb1+/gTw/YfHSD+TTASg9hwj2CWFv+FcPq99EAaa3I
 Ff2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754535762; x=1755140562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xJlOz+Jg5Eh+vkwIFvbU82F8MEu7BNgLBhpUCzS/X/E=;
 b=AGJl2OLVP0duXC1zwNrWBF5NGjyjTBj3eGAEZ+bR7YDWGbuzYbauc0BXI6HbkPIU4o
 cjFFNoZWZfQLD56LoKLoSa5p70AgzcBniNitNH0Tsnky5ZmhM8JZLcQxTPT8LjSwIa9u
 RcWDOR7l9XuzsURQYHXv/Vdl/Z/vZrExSQski2HNreNBztKdnSBubxXfqvHbbO6FuX+N
 J+0PUTwx/Kd953V5dT9gJ1d3v+BTdILfidI+o8wt/M2z9nxeUCvT2oNNFt15uxN/K0Em
 sThpyGsNV/erre5NTyexf6gsA87T7/eMF79osYfuKGwqJvuImMKhdF2Gc3I4bjki/OXA
 dt/Q==
X-Gm-Message-State: AOJu0Yz/rMMayM/OWiYz/A5Ii0zrHGK9WpYjTUytimbDdZI1cJBVSVqq
 ZXdD7xhskbz8pN0OORxckA5Jl5c+JQS0+nKuagqGp0sq6ZDFg56ufli/sYiHRw==
X-Gm-Gg: ASbGncvTrTdmhYLgzyWF8JCFwhlHAsDDOkTEvbbSU19HincfWqjGrC9GK811JBeXusR
 7ZiCxyOj1tYtgrwHlaf3AWhXzk5IlCHSSkVsTBddcTmVB6YazIFI+UBSIowtJ7g0HA2DmGPa9wO
 36PTuEXGSwpNcorugMV5nCXKNo4whwCOeA8bFVtB0aSeHST/phIf95R2k/YJuTd/dhkXMzTh/0b
 GbJbnO3LKiGMALL3+8gJ4c6kOPGqCXIOdkhzSwuLIlfeCSBtZ7GbkZN4wSd8YAFS2+6vM3dmmpC
 R4Q0KLBktR8eySqjJqZ3CjYX5iL0e3xDCMKWohn4YDw2wGtWnhj2RFHqn5kvSRHRlvQWj0RBFeM
 xEOv3OeKu2nja8zBTOQqjZg==
X-Google-Smtp-Source: AGHT+IGYPOBKzfPnZYzxTD/JeBtsCGGBmHMl5CEfmX10XVJXSWTAHsUelalGnAzLuXoGknD0x/eOQw==
X-Received: by 2002:a17:902:f78a:b0:231:d0da:5e1f with SMTP id
 d9443c01a7336-242b0704556mr25742275ad.21.1754535762170; 
 Wed, 06 Aug 2025 20:02:42 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:81e2:9f1d:777a:7b46])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef6ac6sm173154585ad.1.2025.08.06.20.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 20:02:41 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v3 1/4] meson: Add wasm64 support to the --cpu flag
Date: Thu,  7 Aug 2025 12:02:00 +0900
Message-ID: <fcfdf0cc933aa46c4c3767bd8f23eadd31ab6865.1754534225.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754534225.git.ktokunaga.mail@gmail.com>
References: <cover.1754534225.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x536.google.com
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


