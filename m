Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD05CA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwGu-0003ku-Il; Tue, 26 Aug 2025 12:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwGn-0003gl-Sr; Tue, 26 Aug 2025 12:11:38 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uqwGf-0007kh-PJ; Tue, 26 Aug 2025 12:11:37 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b4c29d2ea05so37160a12.0; 
 Tue, 26 Aug 2025 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756224682; x=1756829482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZrW0ohTHwOsnEYUw7cM8Ny+LWm/AdAq2m0G/QyQL0Os=;
 b=bywpoZfF+mz51FQodaQwK4Sz4j8l0q0hcnQKlM+WmLx/40GMZwYlZCZ2q0b+Z0zZqo
 F92/Q0lSPlOOBmCchRl9kdFIXN3M4Zp6YUD5IlH4DqsWNG5fjJZ0VnY0n+CgAL/oohHz
 VdYQ9O1vdDokqzA6fbXmdjKwyCJpQasJf6aPfttjPu6tDmldbIrG6s5bE+SHJt2Y5L3E
 zUSZD/7nPMCW5u39/d2kEnmkkDqjMxw9boH4YP5W/yqy/FsNnIAH8ueBgFHYXsERmpcn
 6Dsqr2QlHBhO2fN3l/uz41+zN8UziS8dc5pxnCb1Wvr4zxBlluZUIEhp1qouK4fUva01
 vHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224682; x=1756829482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZrW0ohTHwOsnEYUw7cM8Ny+LWm/AdAq2m0G/QyQL0Os=;
 b=GuHz3TojYNEoLGE6X0y6WMJ7RvrAyJvDDAUDI4AyylOLC8NBlEMc+qDYJnfwh2JUC+
 aQoFmSD625Cgig0W9J844pQBnCtDIOCJv5InV4vQqk0WnKPtCEMBWUUTsqwanLWvO9op
 nwZJ6HuFZSqE7qHbG4gWWpVc2nVW3CG4Yg+adBVfCEQxVraz59wepmuu/DuH9CAAZcEF
 rfQ34Ey1EgnX8lKYK4yO7If/5+EklGhCMpCjNpTW3o2RHsTz8cZXRJea+ulHRxK2g4VH
 /C3LAfHq06lwSlCidiiZiVuj2NuY5X2ixaxLtq7K4B582jjBUmlcJtR+h87oCB/Nru3z
 +AuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcj4SLtUWapioecYt1dOopVGGtM2eG/KK0dRGUIxzoYnIuEMpOUvfiDK6SrQ87EU7UtcLuxODiAw==@nongnu.org,
 AJvYcCWbiCOA/NfII7O+E4HdN1HRjIxfcOteMZlCMsj63tNsYfax8Zs0nKlT0Fq35r9HuNHHFQAq5Y5BVYue6w==@nongnu.org
X-Gm-Message-State: AOJu0Yx9c4S2cAiU2u8phxvfu+1fHxv2avnUEm722l7UM8zuazQvTlbE
 KvCmn4UeIYdd4+TgTBZWep2xmph0mNqCF0At8vSWpBqB6N32xdjU0T9+UVRyCg==
X-Gm-Gg: ASbGnctcApBOmMwA8Gi0jwSnDPWXxP7++DRtq0zBzlzdLv457uO68BZWtDlUXzbLPxQ
 o5Pjaj7bR2kTN8B1S9QI6hdVOZPc9Qu++8l3Y6QxbYc6b1hKgYuSm7Jv4gReJzBuhsFHYV7LlXk
 ec7LpB6cx7JozOWyMebPChYyzul6JJmK1j52IFz0/FKqmrMJocbHsXSb64hy4D3glBWijOCYJru
 7rCK0fAoTDGOa+ieTBJTl0294qqrrT8Ucrr9c1vf2OAu0D1eOMWV4clOaMSJqo0fbRUWbeWzMOl
 wv/lsZHn0cKiDqTBEZIJVF5t1iQUH6Uh9zwUwIoL1g9WJahM91eCN4tEWlRLoy9/dQVsariCO2l
 YnAWzeLc1p2FhASA2AcJmLKZJgGIe8hR8
X-Google-Smtp-Source: AGHT+IGAlvqNgsQl2TNqNuU738NlBWs70byFFGw6TIDKRnpz8MoeUjGd0ays7mMpgVaUtX0Jp61xRw==
X-Received: by 2002:a17:90b:4b8d:b0:325:3ada:b385 with SMTP id
 98e67ed59e1d1-3275085f383mr2517991a91.8.1756224681831; 
 Tue, 26 Aug 2025 09:11:21 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:561f:1400:11f5:714b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32750bc341asm1749747a91.19.2025.08.26.09.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:11:21 -0700 (PDT)
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
Subject: [PATCH v2 02/35] configure: Enable to propagate -sMEMORY64 flag to
 Emscripten
Date: Wed, 27 Aug 2025 01:10:07 +0900
Message-ID: <f0fcfef4573d19ff9291f6aac8f53c08f72509f7.1756216429.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756216429.git.ktokunaga.mail@gmail.com>
References: <cover.1756216429.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x535.google.com
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

[1] https://webassembly.org/features/
[2] https://emscripten.org/docs/tools_reference/settings_reference.html#memory64

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 configure | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

V2:
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


