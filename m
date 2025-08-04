Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B9AC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 13:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uivhi-0006ZQ-Nf; Mon, 04 Aug 2025 09:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uiulH-0004MY-3v
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 08:58:04 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uiulF-0000T2-Be
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 08:57:54 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-747e41d5469so3392444b3a.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 05:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754312272; x=1754917072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YUuth8HbNH8Ia7rPyHh7evcGT1DKrq1MlXctr0Y3ZAs=;
 b=mzJbyslYKUkEx58avSq1dtwcyj6/hOU/cRvuYjGxKQZfaCrqzV1HDljR3zcFZrPxeW
 cVvu25+vJNYwq5Be7gRn30woYFanQmV92JdAc6M6hRp969EE2XV+c1uUr1VqZ46CYGcY
 SfeXhsyGhWLQyR6llGWrOxERJC+/tyZnYUevANnhTOEsHKEiMxQryy7CAXLj2mP85Urz
 x4g3E/lCR+cBq4dti2bqKzN+Gma4NauuGEgPcvhGXUTTBO8lRenfhCI/jVyPVNDJrtH4
 tAnJbYMD55VciGg3p2JX2VUkix7bj15iLrKx4p9xy7ywoEU3XBJ81p6PIuL6TYnjU1xj
 MfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754312272; x=1754917072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YUuth8HbNH8Ia7rPyHh7evcGT1DKrq1MlXctr0Y3ZAs=;
 b=BS7YV1ZNEbWtmVGVN/pr7mftWEG5YVoMGpJNgded5aN0q84e5aQHkwzqJFL8kXNjiA
 hqGmzkAsMWaKJ2yFODuhv4aRpuFiKSkzRR+1SOZssgSIp1D8P9PaKWxb1WmVwtMDz2Kq
 BfSSuplrdY7kczi2jq5EOuQPop3poMEzMFKvOE/FwD0jtLaREgXwA3/g0NmVrJbKUTfk
 70uPE9SzyvN5cVrX8qb996gvEkWqkkGoY+LkRZC+KPnAR0+ZFxHl0iy7ubiPbPEB8II/
 pEZ7VDqPlJV60qh/gwxpWAA180NShpw4Z5Oeom1xYtWP3kWjgnv0An5Ns+BN2L4IR9ym
 ngKg==
X-Gm-Message-State: AOJu0YznPguuGhDzRsKQ7Od3WjP3DKhladssSjb8+Qe0tSQLwKovwT6y
 LoK/KmIwm9daXUoyHO+Hm7WPTdlWl4wjh02UINVfi/l3UBHY6fcD2vSyZz7ZTA==
X-Gm-Gg: ASbGncupGCGzfXOXoBoJ9D8FXA5f2PEwIBkSznpSchUGzr3YrimeqV3oqkO6dQILJRL
 H51SSy8w+t2qVh5qB5xZI70SRERV46kgbqIgEbKKjHoJr6Aq+qn9+UGLnbiwadXBD+stY3OQTC1
 eNSfQVvaWZSgOt/Rd4m9cgjaLm2IaCCGnZO7MDfTGQ1CuwTOtvHguiUAVL1R//PNrkaEVFOPc+O
 dWKzpvZFZk6mOENuUqVvfTPzH+/tbrPDUxG66KPFyrADekGUzbchecI5We5mlyHXAFMPf69IDn2
 l8emEXKcQVXC6XHxaj0zR7E7Y6YFMckWh+/W+gRossCSBXHsPRJxUiyiopCfpUijWXER+2QX6CY
 lT4A90mUtOiVccBjIqYr4zw==
X-Google-Smtp-Source: AGHT+IFGWFxcWqTy9uYd49JJ/Z0krs9Q/OT2j7KygQvVsFwjPb/8Rp/5tZRIcoDCG+9qfYVdwCl1xA==
X-Received: by 2002:a05:6a00:2295:b0:76b:caa5:9a32 with SMTP id
 d2e1a72fcca58-76bec489607mr11071554b3a.11.1754312271852; 
 Mon, 04 Aug 2025 05:57:51 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:d117:15e5:e721:f1cd])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce8f800sm10488308b3a.42.2025.08.04.05.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 05:57:51 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH 2/4] configure: Enable to propagate -sMEMORY64 flag to
 Emscripten
Date: Mon,  4 Aug 2025 21:57:15 +0900
Message-ID: <9e9d4d6e10a2eaaca2d741184ba292d699ddff7b.1754310749.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754310749.git.ktokunaga.mail@gmail.com>
References: <cover.1754310749.git.ktokunaga.mail@gmail.com>
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

Currently there are some engines that don't support wasm64 (e.g. unsupported
on Safari[1]). To mitigate this issue, the configure script allows the user
to use Emscripten's compatibility feature, "-sMEMORY64=2" flag[2].

Emscripten's "-sMEMORY64=2" flag still enables 64bit pointers in C code. But
this flag lowers the output binary into wasm32, with limiting the maximum
memory size to 4GB. So QEMU can run on wasm32 engines.

This commit adds "--wasm64-memory64" flag to the configure script. This
takes the value to propagate to Emscripten's -sMEMORY64. 1(default) targets
wasm64 engines and 2 targets wasm32 engines with still enabling 64bit
pointers.

[1] https://webassembly.org/features/
[2] https://emscripten.org/docs/tools_reference/settings_reference.html#memory64

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 configure | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 7f3893a42f..8573f84e26 100755
--- a/configure
+++ b/configure
@@ -182,6 +182,8 @@ EXTRA_CXXFLAGS=""
 EXTRA_OBJCFLAGS=""
 EXTRA_LDFLAGS=""
 
+wasm64_memory64=1
+
 # Default value for a variable defining feature "foo".
 #  * foo="no"  feature will only be used if --enable-foo arg is given
 #  * foo=""    feature will be searched for, and if found, will be used
@@ -239,6 +241,8 @@ for opt do
   ;;
   --without-default-features) default_feature="no"
   ;;
+  --wasm64-memory64=*) wasm64_memory64="$optarg"
+  ;;
   esac
 done
 
@@ -537,7 +541,7 @@ case "$cpu" in
     CPU_CFLAGS="-m32"
     ;;
   wasm64)
-    CPU_CFLAGS="-m64 -sMEMORY64=1"
+    CPU_CFLAGS="-m64 -sMEMORY64=$wasm64_memory64"
     ;;
 esac
 
@@ -795,6 +799,8 @@ for opt do
   ;;
   --disable-rust) rust=disabled
   ;;
+  --wasm64-memory64=*)
+  ;;
   # everything else has the same name in configure and meson
   --*) meson_option_parse "$opt" "$optarg"
   ;;
@@ -920,6 +926,8 @@ Advanced options (experts only):
   --disable-containers     don't use containers for cross-building
   --container-engine=TYPE  which container engine to use [$container_engine]
   --gdb=GDB-path           gdb to use for gdbstub tests [$gdb_bin]
+  --wasm64-memory64        Used only for wasm64 build. Set -sMEMORY64 of
+                           Emscripten to 1(default) or 2 (choices: 1/2)
 EOF
   meson_options_help
 cat << EOF
-- 
2.43.0


