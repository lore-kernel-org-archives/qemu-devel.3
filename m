Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADA3CCD182
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 14:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4gco-0004Ks-H5; Fri, 03 Oct 2025 10:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v4gcm-0004Je-Jk
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 10:19:08 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v4gcT-0000MN-Rs
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 10:19:07 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b5506b28c98so1592088a12.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 07:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759501117; x=1760105917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Av0b4w51KjBkrgO+Sf3v3FDDHs9Dpny2C0CPcpUwJwo=;
 b=xp7Gy3ZVDpB5RPgEPNBuhspkUNFyz92G4ujt6Uoyj08nhO2pge1M4W4CJObtlYQ/Yp
 CwT7Cxe3a6zZQu6ijM9H1E60zRMQL9QPDEC8OSTCjmGfEM4rJz3rYlNPhbyKvmK1ZE+X
 hhfXCZI+EIKLwjRh07F+9N9meR2plV6lxMaBhE3sEYUkNe1WRo51V6TihJdPVT36bsZW
 /vlvZbdYsYFreJ3fuDuPdpi5LjffqWFjmrQAudMK5Cbybe3UIQYPdaPdtXTfOJFSyPRY
 M/lhjl21i6eyJEvr0lthbL3KG//cHhrEC5HGxWXvHiwRvWb6GeOBTjOwKeCsWRrxaEfb
 eE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759501117; x=1760105917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Av0b4w51KjBkrgO+Sf3v3FDDHs9Dpny2C0CPcpUwJwo=;
 b=eCiI/r6cbVdKsf7yGroPzgM8bn6BCTwXqUWqb+VSGKgy2wDwaaih+SqSPPCfWEsm8s
 ovaXj223KM3oLmDKkC8JTSAbiGmQiB+QjfPzZF2VxSgkhkua4xnqedW/4Yf76PUVopAM
 MuPpCV1D5cS3HCYTFKjUcbodzY/8cpmKPxnRV5m48T+U1y3nWwLIYOLQzMnfsBBMY5dJ
 azS1CedStoova0wvDnlLF5aDhf6jL0vnndZw9UvB3OYIQTKyJb+gMs0DkDU57WP6AJ6p
 UANcKDSNSzEjqztN27Xfxb67grott+VzsQOPZSBGHqtHUGQ2RxMhzXKQpK9CLSkrDp3V
 HNGg==
X-Gm-Message-State: AOJu0YyxmaVUAFfv4JGEdkpOyp5pJb+eiocFF+N1OSCi04GsTQszbJeI
 8ZRK24vqFTLE1Medf/SMuCiZ77bwgvO4VThD7lj29EDsFy6bh3GCtvmBwEREEWyMfU+Lx2L5xPQ
 J4WeI
X-Gm-Gg: ASbGnctkg5gCmJmRooVJ6irbH/5ZcSzJpD75yCI+QLLdgQHVuifUOX+Yu7PoPcRwB3g
 Grq0+JNvXnLaL3GcKvaGFdBeid3YjRrk7+qz318BEP8Uz+clatlYCIV672i/Kw74PehGqw8FxFJ
 yLXiV1nX2tjIdXfOkjXKQ5P7ox7jJjyhe50IDhl+NwW5lMtFj3U2IglevGiQV4uVR/mkLVbTcto
 9vVntK13+u4wuc5sZEZC8PWligY41MJXa7HFYh9akW6lxzySZ9lfLBnie+LOhgrhZwLmX6oK7YW
 pCAa804EfefX0U8evySxBolgo7A2iRs2ug0qkdYhUt7a4EFMwc/4wmQQxZBaVw//u/ChWs5/rCn
 xNaXDpNf/eaNMMoSoUc1niwGYnODJAp53AqFtvhSzTU2hGPzH2NePB2o2VmPefzPt3WU=
X-Google-Smtp-Source: AGHT+IEFK70Onc6rTTcd0gZl8vdEKB0vu7pZJRc7zPQ4F1RR7HmgY5MP1+l2uq1psPIAkBJnLvqhIg==
X-Received: by 2002:a17:902:f612:b0:280:4b60:5570 with SMTP id
 d9443c01a7336-28e9a65167emr38681875ad.52.1759501116947; 
 Fri, 03 Oct 2025 07:18:36 -0700 (PDT)
Received: from gromero0.. ([186.215.59.111]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d5635sm51759645ad.102.2025.10.03.07.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 07:18:36 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v6 3/9] tests/functional: Provide GDB to the functional tests
Date: Fri,  3 Oct 2025 14:18:14 +0000
Message-Id: <20251003141820.85278-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251003141820.85278-1-gustavo.romero@linaro.org>
References: <20251003141820.85278-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The probe of GDB is done in 'configure' and the full path is passed to
meson.build via the -Dgdb=option.

Meson then can pass the location of GDB to the functional tests via an
environment variable: QEMU_TEST_GDB.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 configure                     | 2 ++
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 2 ++
 tests/functional/meson.build  | 6 ++++++
 4 files changed, 12 insertions(+)

diff --git a/configure b/configure
index 78445cbb4b..21d1679f58 100755
--- a/configure
+++ b/configure
@@ -2003,6 +2003,8 @@ if test "$skip_meson" = no; then
   test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
   test "$plugins" = yes && meson_option_add "-Dplugins=true"
   test "$tcg" != enabled && meson_option_add "-Dtcg=$tcg"
+  test -n "$gdb_bin" && meson_option_add "-Dgdb=$gdb_bin"
+
   run_meson() {
     NINJA=$ninja $meson setup "$@" "$PWD" "$source_path"
   }
diff --git a/meson_options.txt b/meson_options.txt
index fff1521e58..5bb41bcbc4 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -36,6 +36,8 @@ option('trace_file', type: 'string', value: 'trace',
 option('coroutine_backend', type: 'combo',
        choices: ['ucontext', 'sigaltstack', 'windows', 'wasm', 'auto'],
        value: 'auto', description: 'coroutine backend to use')
+option('gdb', type: 'string', value: '',
+       description: 'Path to GDB')
 
 # Everything else can be set via --enable/--disable-* option
 # on the configure script command line.  After adding an option
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 0ebe6bc52a..f4bd21220e 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -58,6 +58,7 @@ meson_options_help() {
   printf "%s\n" '  --enable-ubsan           enable undefined behaviour sanitizer'
   printf "%s\n" '  --firmwarepath=VALUES    search PATH for firmware files [share/qemu-'
   printf "%s\n" '                           firmware]'
+  printf "%s\n" '  --gdb=VALUE              Path to GDB'
   printf "%s\n" '  --iasl=VALUE             Path to ACPI disassembler'
   printf "%s\n" '  --includedir=VALUE       Header file directory [include]'
   printf "%s\n" '  --interp-prefix=VALUE    where to find shared libraries etc., use %M for'
@@ -323,6 +324,7 @@ _meson_option_parse() {
     --disable-fuzzing) printf "%s" -Dfuzzing=false ;;
     --enable-gcrypt) printf "%s" -Dgcrypt=enabled ;;
     --disable-gcrypt) printf "%s" -Dgcrypt=disabled ;;
+    --gdb=*) quote_sh "-Dgdb=$2" ;;
     --enable-gettext) printf "%s" -Dgettext=enabled ;;
     --disable-gettext) printf "%s" -Dgettext=disabled ;;
     --enable-gio) printf "%s" -Dgio=enabled ;;
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 2a0c5aa141..725630d308 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -77,6 +77,12 @@ foreach speed : ['quick', 'thorough']
     test_env.set('PYTHONPATH', meson.project_source_root() / 'python:' +
                                meson.current_source_dir())
 
+    # Define the GDB environment variable if gdb is available.
+    gdb = get_option('gdb')
+    if gdb != ''
+      test_env.set('QEMU_TEST_GDB', gdb)
+    endif
+
     foreach test : target_tests
       testname = '@0@-@1@'.format(target_base, test)
       if fs.exists('generic' / 'test_' + test + '.py')
-- 
2.34.1


