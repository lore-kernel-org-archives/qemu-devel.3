Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0384DC87FD3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 17:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujhZQ-0002Yw-Vb; Wed, 06 Aug 2025 13:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujgPS-0007Hs-42
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:50:37 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujgPP-00037Y-EN
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 11:50:33 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-769a21bd4d5so126606b3a.0
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754495430; x=1755100230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJlOz+Jg5Eh+vkwIFvbU82F8MEu7BNgLBhpUCzS/X/E=;
 b=cFUzqpfXdpl5o55S1RU4w5n2yA4UJpWThn2MsUjrNVI597baHaQyizIhfDDc2tzJjq
 uw8G0sSDk6Tzx32HSfMUvmr5bpnIexRB0TIcCwDiG8tJcVGVSAZa+IJxgPZw/PcZoXfR
 UbHztSZSXD7eOgD074bMH34f2A806RfDokWUnQu08Fx0fF/AnARiBpiOd4O0C3E/H61l
 gs+c4LlCkWqhHj6PsqlGGULK3DIG27oVAJaTWnbGgsw+KpJwMu3mifYxvDGIr2Ux37dV
 s2vIS9DZcYPyp7yQ+mnr2QHaAajzR6yOta9XXeNZ/hRg2aTBdnw6AuXr93r12F7tslTC
 Qv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754495430; x=1755100230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xJlOz+Jg5Eh+vkwIFvbU82F8MEu7BNgLBhpUCzS/X/E=;
 b=S6UadTRud6dGr7epFf8+XkKuWryDW31JBOzyqZjKKvEZnnNcC4ri5dG3VnW6myQW7w
 kzbDm75iJDgrym13NrO4uZffU9GV1VZPWOo060M9yYwcjcBaJp/Gk5rBsEPjpzoecynQ
 L+jPHMFXGpd08BVUiSYJQzYt9i2qTB1K0DGDV/QZPJisstUWqUBgeCrN1h9Cu+vjR36T
 QR+eUEzSA07mdqrkVybAKyEBSBPfdTSYBm32YK4eLfBL4i+VDgh80zyB3c4/S2QMCy/0
 oXEQYVot4gHZgcmS064C8rPpKZvc0yxKlLqUBZucyc8HiCxs1Y3Oc/3srBg6Eyx7pYQD
 fG2A==
X-Gm-Message-State: AOJu0YyxeGt6q3DOjoe3nhvkPesvK6tW1Fz2MWSUgWBvPXjd8dJwCp4q
 qnJFhDD2oIYSLCrlef4izOYjl35a9hh84rjg/nEaKMD09acRbVxZmGdQHdVqQg==
X-Gm-Gg: ASbGncsygZ5AvEpKLcRKTLyzdcd6ojznlCMbrh1eAC12QMnkXs07do7iYGvkORLaWBA
 iKAvHmOmhpYZpGjfWPv+bsPAulXMd5RmMrkKxn3mx67vdn3ufvhYKUBr22qCU8S9YS8isTkWsFx
 8kKW8LNglhsdlwUCtitXFuvADnW9QOEFOAUu0RrjKgBhE2a6vuF2EbBci362I3YcuTdmkZOFe0i
 dQNCzBNAo/btJJMAWKT/mTgwYUt8eTHhrsON7QwM1mXD6SeysbMX4X6S2KRX8abhPIjYxdBZeJ6
 3Mlj3RnO/GFRx5wgba16HQyHrsGbsSmVn1Xl+RVgfZn4BJgMmdqFey+W4WacaTf95OOzmhCHgwv
 6GtDolIq2U6ZpKZa1J09jRcmuF/l15+nD
X-Google-Smtp-Source: AGHT+IHlWUkoAJSlKgoqYOsN42Bumz9b1gBCwHLnV+2jn8B4zHHFrPYtMiYa4wO86b6IVDtCInpARA==
X-Received: by 2002:a17:902:e54d:b0:242:a0b0:3c1b with SMTP id
 d9443c01a7336-242a0b03f31mr35484625ad.30.1754495429670; 
 Wed, 06 Aug 2025 08:50:29 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:4cca:cbdb:3f01:1165])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8976a3asm163374575ad.87.2025.08.06.08.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 08:50:29 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v2 1/4] meson: Add wasm64 support to the --cpu flag
Date: Thu,  7 Aug 2025 00:49:48 +0900
Message-ID: <fcfdf0cc933aa46c4c3767bd8f23eadd31ab6865.1754494089.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754494089.git.ktokunaga.mail@gmail.com>
References: <cover.1754494089.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x434.google.com
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


