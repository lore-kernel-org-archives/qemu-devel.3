Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13E6CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2z4-0006q7-Sq; Mon, 01 Sep 2025 07:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2yt-0006kE-F4; Mon, 01 Sep 2025 07:45:52 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut2yj-0001Ho-K9; Mon, 01 Sep 2025 07:45:51 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2445805aa2eso43000915ad.1; 
 Mon, 01 Sep 2025 04:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727134; x=1757331934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+PQrFo8EBMIk0vCQdMb98g3now50VhqZJnrrrRXa3xE=;
 b=UqBKkC+nUrm2+6qsp+AZ78DQgyCSYcp6TCzo69z9uHkx8N7Sm2KnPRBmdF0N1zxP4q
 NvNhnL7QAL4H0I5wWX+MM1Xxrr7IpH3vw5Vp/iG8OoReE/jVhr1mZ1nSqL6k0MtBQQgI
 bSHg6SeiKUpGLR7G7fIVJt8v0yyeTzx6gMOzihxcgWpXF9ZpVkXDE+Ygye85fNv6in97
 6/3SftmBIUhrq9sgTL5f3Ci3Fug9OlGwzdfWyFuhyk/oqn11HBVu+AjTq9YKMH66Sd5Y
 3e4VQ0tyJxkRMcbTFPiqkrxiHyfvL/9xR2wGKxl11zWKFMH553dIq0n8mP7KrGUi5TW/
 aZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727134; x=1757331934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+PQrFo8EBMIk0vCQdMb98g3now50VhqZJnrrrRXa3xE=;
 b=oczDQkDi4HcLwU3dJhcx9ZsUbD7ymb4HEom/ofJ6DCyrMd+magnHj38EzPJnr2H5XL
 ywBXy6onCUVrdjzw6Jf4oObg8n6YnUC5FJK48gqe/7vFO8+kHiBJr/CAwRsJBRg8AC4m
 78s6garp88dSEAzSp/w46s/UFmw/5GoeiN7btKGJPz4HJR9JGYv9zHzQ+fzhzwAL5GBu
 PNWkR8QpBKKnYfr8RNVmv8iFLsgX/sXvKfIZ+b9vFxJC/gHdHIv2ZW0eq6kEFVLPgF/q
 1RqYQLJzJyG8Qz8MALCzhgX3xWY45Pl9c+UKaIcIk0cXD8D78s5XneAZWZBI8Aof/C8V
 iiLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZvf1FznWrfUb1/suNUlRBFZrl9cARE9R+palk+S294p+UCjBQPndlWnXUXg6G+79ifdUdb84Ez1Llcw==@nongnu.org,
 AJvYcCX249PDfpqdk/GAiNXhyN0bAemKR60YKFEgOAXcykxd6jTRGegAmiubmFFKIM379hX6V8v5JQRrSQ==@nongnu.org
X-Gm-Message-State: AOJu0Yw8FLJgFu5zsDU7+mCD5uc6S5Wtg6WU0y3c7vWFxVIP6Kx/IbhS
 FUC2G+Ttzktk1ZuUX40yGACbhNdandYfPG9pOQlGVfKVfiJ0tBXY66yX/+oOPQ==
X-Gm-Gg: ASbGncvNSYW3sb0UnL4sjZqu4atoIE4c6c7eMTzn60ll6JpYexpO0ykwtuTcW0kPphF
 5wk0KPU2RbXDreLagPgm3hmE6JkZR4R7yoHU6wBxceBSNtNxatqhRC/1bDXit1O/+1wrJkVUrhU
 sAWqK4zIxHsSQBT7YeXRMia1z3EWk8AqA4GRuTJVr7QNaUwtIQ1y30kYfImopnAB28apP3PFLH+
 Wh1sucuudVZN5PYg2+J71hewro4kavCuKpRqHAQ91wQxXGibMgduOahkRhXfc+msurlb11UqYAT
 fTOqLAs+sLl/2BTe3xYlEP2TIK4bTuTNMBczpHcXl2C6j5oINLOlWWNFQim2hVz7dkIVui7p8Hy
 uo0ufeK2q1FkdPPxo8Ij2VEuheEYLhhMg
X-Google-Smtp-Source: AGHT+IFTP42mQXbO3bVx0khj5I4eMKvfb49LTCNklV65+sAfcX5ZtwtVIu4pyFy2Lm9MzV1oMPfdlw==
X-Received: by 2002:a17:902:e810:b0:23d:fa76:5c3b with SMTP id
 d9443c01a7336-249448eb7a3mr92183895ad.22.1756727133912; 
 Mon, 01 Sep 2025 04:45:33 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:45:33 -0700 (PDT)
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
Subject: [PATCH v3 02/35] configure: Enable to propagate -sMEMORY64 flag to
 Emscripten
Date: Mon,  1 Sep 2025 20:44:04 +0900
Message-ID: <f0fcfef4573d19ff9291f6aac8f53c08f72509f7.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

[1] https://webassembly.org/features/
[2] https://emscripten.org/docs/tools_reference/settings_reference.html#memory64

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 configure | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

V3:
- This commit is under review in another patch series so please ignore it
  here.

diff --git a/configure b/configure
index 112e4725fc..8ac6cacc06 100755
--- a/configure
+++ b/configure
@@ -182,6 +182,10 @@ EXTRA_CXXFLAGS=""
 EXTRA_OBJCFLAGS=""
 EXTRA_LDFLAGS=""
 
+# The value is propagated to Emscripten's "-sMEMORY64" flag.
+# https://emscripten.org/docs/tools_reference/settings_reference.html#memory64
+wasm64_memory64=1
+
 # Default value for a variable defining feature "foo".
 #  * foo="no"  feature will only be used if --enable-foo arg is given
 #  * foo=""    feature will be searched for, and if found, will be used
@@ -239,6 +243,8 @@ for opt do
   ;;
   --without-default-features) default_feature="no"
   ;;
+  --wasm64-32bit-address-limit) wasm64_memory64="2"
+  ;;
   esac
 done
 
@@ -537,7 +543,7 @@ case "$cpu" in
     CPU_CFLAGS="-m32"
     ;;
   wasm64)
-    CPU_CFLAGS="-m64 -sMEMORY64=1"
+    CPU_CFLAGS="-m64 -sMEMORY64=$wasm64_memory64"
     ;;
 esac
 
@@ -795,6 +801,8 @@ for opt do
   ;;
   --disable-rust) rust=disabled
   ;;
+  --wasm64-32bit-address-limit)
+  ;;
   # everything else has the same name in configure and meson
   --*) meson_option_parse "$opt" "$optarg"
   ;;
@@ -920,6 +928,8 @@ Advanced options (experts only):
   --disable-containers     don't use containers for cross-building
   --container-engine=TYPE  which container engine to use [$container_engine]
   --gdb=GDB-path           gdb to use for gdbstub tests [$gdb_bin]
+  --wasm64-32bit-address-limit Restrict wasm64 address space to 32-bit (default
+                               is to use the whole 64-bit range).
 EOF
   meson_options_help
 cat << EOF
-- 
2.43.0


