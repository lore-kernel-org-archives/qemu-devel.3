Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A98BD47CD0
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghql-0007JC-Ef; Fri, 16 Jan 2026 06:18:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghqh-0007I1-S6
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:18:41 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vghqf-0005hX-TX
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:18:39 -0500
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so999314f8f.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768562316; x=1769167116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+lSDqpgt49/OyQ2ExzKjU606U5rmO2/rMItUS6X3ncQ=;
 b=XWi3BOoju3xmOr9zUExzCOWDplb0NMhWJfhErBEGK+/s157RmUoNDQhiaKEn1N7iUG
 Mubblyheu57hYJmhehlJVvVBNuhKWKjw2nVT+yrWbF/K64B7zAq+jOl0mrzTUh8L58zp
 Fzc75fzACPkSRxKKWO83lap23trZvH7AagejfJBs+MJW2jdPK4idDEU/V9ZZXeAFLoxB
 tHH8Clcylifjnr18XAwaF2lpfqgHzc91mnhnEXvlO5u9dfleJ0l7UWczKoGAdHcEJaYe
 stH5w9YMZDvUGpLTXIxb0UWH5/TpYBtTQqPxkGH5lw/qPN3r4jTYXxQ15AwdV3Q29SL2
 5Qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562316; x=1769167116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+lSDqpgt49/OyQ2ExzKjU606U5rmO2/rMItUS6X3ncQ=;
 b=vZs19zlWz38P8wse+a47dBqc3AHKxL4DQpdDPKmIDdvFbC/YAz5K0fNCCBqb2WYV6g
 6Pp4bhBsWcogigUOY0eJWfirzRzQp2I45fUBRJA3+k1iTgFy+DJE/qoJFxQkR1z91dn1
 gpcqiZmE4oBbiezoJYYI77kzdIbheGKu1/tACcQ/1MefpIfJt6ddzvo2Wh8/L4fS+jnR
 VgBGjOI4dgfteJ1hhhWzM8jVh2PSFwVBfoOsDBtwSV/p2zlktJn5/VnetnY7CQZLfZ4S
 +UZakKS/CiVhEWEFi+Xc8f74jPFYs951prC7W0w90umfDWi7/3uBsb1eGZWQVfgxeAgD
 XShA==
X-Gm-Message-State: AOJu0YzB31u8P2NiYyRA2q9hfrkSXCjSrX5WKut8mv0e0eWqA5gmE90h
 8toUT95Dqv7uPupjRV9tiiZivkoP4QAvrJwHUFHJQMsFpowSDdiDLXPpnry+MKl0LK9gp1kLYss
 /sMZSAB0=
X-Gm-Gg: AY/fxX7Q9zjz73OsBKotUTeU5yptz4tW10EL5OE/P16WSEIeBhzwEYFyfuUTDwnNXcW
 Ner2bAHEegIn8+YAxIeJzXmwOgrN2nPl3N/ghOPop+eVR9bNLhowJ4K/1LPnFSXc30U9ypWKgC7
 GD6tzOnknk2fOxF6FMYCxyPQqpKvXAUoJ+I8PKBVRhgr456myzDvlaxsP4GwW0H+iLZsSi6vtEJ
 A8y4DWa2gKlN0A3hneDNfWOUlM4CH6k7dhZ8hF6b036C6ougWo0ZNGQP5IjBTo/Wacj6/9LwsnZ
 qnpUJD+OdBhjjMis+md3mlqTsz1Aeu4QWGOm8jNvN1J17RgVn3rAxeW4B3aqY4r/ZQMA/4GdFz5
 FadUScuwCEA0Dc5FPoCGLinOk5nMjxzquuiNbR57uUTEVKD5JOg/DZ5rklt6PCD9YadmORDXv8m
 Ebg35Vw8M2k1QuJ6w5KhN1jZrM6DRjeyyz5UDVWs3IPtN0YNmb1BWCGqW7viT94p4GoAv2Hi8=
X-Received: by 2002:a05:6000:2382:b0:432:86a3:ef2e with SMTP id
 ffacd0b85a97d-4356998ad0dmr2794824f8f.21.1768562316001; 
 Fri, 16 Jan 2026 03:18:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997eb1fsm4746688f8f.35.2026.01.16.03.18.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Jan 2026 03:18:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/30] meson: Add wasm64 support to the --cpu flag
Date: Fri, 16 Jan 2026 12:17:41 +0100
Message-ID: <20260116111807.36053-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
References: <20260116111807.36053-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x441.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Kohei Tokunaga <ktokunaga.mail@gmail.com>

wasm64 target enables 64bit pointers using Emscripten's -sMEMORY64=1
flag[1]. This enables QEMU to run 64bit guests.

Although the configure script uses "uname -m" as the fallback value when
"cpu" is empty, this can't be used for Emscripten which targets to Wasm.
So, in wasm build, this commit fixes configure to require --cpu flag to be
explicitly specified by the user.

[1] https://emscripten.org/docs/tools_reference/settings_reference.html#memory64

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <91f16f0e9ae6b36fbf0c2caac510dcf855120400.1768308374.git.ktokunaga.mail@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configure   | 6 +++++-
 meson.build | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 55e0bd34256..92bfc5f9765 100755
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
@@ -419,6 +418,8 @@ elif check_define __aarch64__ ; then
   cpu="aarch64"
 elif check_define __loongarch64 ; then
   cpu="loongarch64"
+elif check_define EMSCRIPTEN ; then
+  error_exit "wasm32 or wasm64 must be specified to the cpu flag"
 else
   # Using uname is really broken, but it is just a fallback for architectures
   # that are going to use TCI anyway
@@ -519,6 +520,9 @@ case "$cpu" in
   wasm32)
     CPU_CFLAGS="-m32"
     ;;
+  wasm64)
+    CPU_CFLAGS="-m64 -sMEMORY64=1"
+    ;;
 esac
 
 if test -n "$host_arch" && {
diff --git a/meson.build b/meson.build
index c58007291a8..600c50007da 100644
--- a/meson.build
+++ b/meson.build
@@ -51,7 +51,7 @@ qapi_trace_events = []
 bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
 supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux', 'emscripten']
 supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86', 'x86_64',
-  'arm', 'aarch64', 'loongarch64', 'mips64', 'sparc64', 'wasm32']
+  'arm', 'aarch64', 'loongarch64', 'mips64', 'sparc64', 'wasm32', 'wasm64']
 
 cpu = host_machine.cpu_family()
 
@@ -923,7 +923,7 @@ if have_tcg
     if not get_option('tcg_interpreter')
       error('Unsupported CPU @0@, try --enable-tcg-interpreter'.format(cpu))
     endif
-  elif host_arch == 'wasm32'
+  elif host_arch == 'wasm32' or host_arch == 'wasm64'
     if not get_option('tcg_interpreter')
       error('WebAssembly host requires --enable-tcg-interpreter')
     endif
-- 
2.52.0


