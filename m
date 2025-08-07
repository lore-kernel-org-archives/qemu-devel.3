Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0058BC87FD3
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 03:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujquP-0007rd-GZ; Wed, 06 Aug 2025 23:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujqu8-0007kA-O9
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 23:02:58 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujqu2-0002Cb-Ph
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 23:02:54 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-23fe2be6061so3902745ad.0
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 20:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754535766; x=1755140566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hox/JubKo6/V4q4RB3YlZQj7BLFXBniITJvVoESyKgw=;
 b=kyOGwx7h+lMyOVuQRSbb+4wljWnIjldgZHeGT7dQZ5ezLQS0FRzMi0J6hCybF+PfYE
 tlFAifKpW8RAMfc4MW8fp+65O9xSQ2pFRa67Df5gUS95FybRb9jjTxuFUbSQ2vyyKqiW
 biOEm1vjGkQ+E+IOr1uW5fIXD0GJehJW3CCorbPQlI6AWmz30tub4XCQZi9WKmbbhcPV
 gVq1oM+pyRX1Hga3q0zZit/vWZUEHjhiTMn85SYVOjo/NGgbyOBHmI7Ex2LPTODN/qNb
 TcHFTew1jsntIFvhNp1eYT6IhfB8GurGPZgo6O5MT0dz96MBCBoXOLb7cpdrlKLnt6Nx
 bNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754535766; x=1755140566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hox/JubKo6/V4q4RB3YlZQj7BLFXBniITJvVoESyKgw=;
 b=i0jwsIFLi2Pamolwl18z3XlEMa23WIlphbGNhDRDs1KJjXsQ5xwUPQaNXG1e0YPIwZ
 fKGu7f8hLQooxzieQioLywwSokPWXF0KPon48E/5x8fIIFn0v3USkCQUcK08JaIQx7ud
 ullVzqbLqNC/STLdvZs+trSdq4VWAsu5ERqwmuFfqFy54Tt/l4ImLTm3sZIG1T28znJa
 qnC896L7biDt3mDQR/smITT5eEk06dujFkJWAa5RoLk7FMfNCS7Cweok2Ue68HV97JPC
 oAX2m5HRO8KiBSmnkwtAxvc4sOIwETp29RcTdwT6oQ1fNtQYsdE6aU9Cu1Dj7ERR5AxY
 qYfg==
X-Gm-Message-State: AOJu0YyxoD2ipR/IRieZftcQWtAvmb0QFj7m34viUIgMIY6wCCOdtxuu
 VX2FqCO5ceY8TW424TaJHP4tdvNXN2PSZedjaoIBlrry9cTRQWwYg6rmSVFDpw==
X-Gm-Gg: ASbGnct3sFyi8RGz3EdkNYDy3jugb13QvRoAyrMTjRokXKwGXLgovI5lsl6ZQ50RJLY
 diQ9Y8rpLExIntHXI281YYGPEYZRfjW0i+PFXcCijIVozTT4MFIEFoS+4TGKTOUWKTJ2gHdqL4k
 PnL2SjIdGtNkGuwyA8f6dMGBQYhMC4RsanTebSB5hcjCWKutSAbCPSwT7Wbt7Kf5o0a+K/IWOyt
 BsGukilIQN9Xza3/+TDI3Gb4i99YjUKC5YmVZa2vp8qsFrSziqhSf3U2Ew6MOQ+4Skjqg+KNGga
 LHGZJ3NWyiv3l9GwAD55LXSaneAB1fSCIrwu7BDBo10i0pgKzw5CFteFcV0LlvVkibI/QgMC52n
 dehDU9ELh5KAa6WM2znE7TA==
X-Google-Smtp-Source: AGHT+IHLQI2Ocyx0VbIDh14jWYebKsG+DqMKpojzTbVGSngXhTnAvGvOB9ehPRgDFB5YpGIkwED0YQ==
X-Received: by 2002:a17:902:ef0a:b0:240:3245:6d40 with SMTP id
 d9443c01a7336-242b04d6139mr25838435ad.0.1754535765512; 
 Wed, 06 Aug 2025 20:02:45 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:81e2:9f1d:777a:7b46])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef6ac6sm173154585ad.1.2025.08.06.20.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 20:02:44 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v3 2/4] configure: Enable to propagate -sMEMORY64 flag to
 Emscripten
Date: Thu,  7 Aug 2025 12:02:01 +0900
Message-ID: <574dee5a5cb19d15dbfbe94cea31de23189596a9.1754534225.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754534225.git.ktokunaga.mail@gmail.com>
References: <cover.1754534225.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x635.google.com
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

diff --git a/configure b/configure
index 7f3893a42f..0587577da9 100755
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


