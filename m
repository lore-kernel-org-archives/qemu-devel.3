Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA22CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 05:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v20p5-0004qG-FF; Fri, 26 Sep 2025 01:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v20os-0004kV-23
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:16:35 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v20oi-00060B-1V
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:16:33 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b5565f0488bso1244075a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 22:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758863775; x=1759468575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ErpjM5v///jsQEmH//OMXKSRg7T93UzIYGTiGLLhSpc=;
 b=nMryvUoaMxaTTO6jqTBDLADTLhXmYoN5YQvl3H77qgorOGSv/ND+7+1KyvewOD2K4E
 /J7hJ+b3CZG/1MLDZZWzEuvtvpcwt2P5jQ+Jhz3suPUuRyL3V4PUDFU8RAeK72nsj7JY
 +ire1igJomlxadvUMB+xplUqeI3zgNWoz5TU4UoKaOUKyvQLuXwi7rAOHTEyNec+LKpq
 rflYhJTiQT79JZjZ9y0eQ4NHIBBdpc270QDMXWYSdKZONxLYPQxnxWtkqxHjKS33s3rC
 +P72xCmUIxlxp2yGevjzRdfuQ1Q65BGDvb/pIVZDEgfc7wBunWUoCXzfC6MqznDGXfks
 4UgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758863775; x=1759468575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ErpjM5v///jsQEmH//OMXKSRg7T93UzIYGTiGLLhSpc=;
 b=YFSsIsTsEfTI99DvCQy9qH07IJZ7gJERSFvRQTt+69WTUgQNUnfIvT3XaFyh60A5Fj
 T1s2f+44+xvSEgtriBWenHqm/9tmGE8UFCtwJ9rb/DNx3bZLVDid5T/mv77t0QZx0X4b
 ws3c29UOmzsIegXlRh2nJ3WFYwFY7d+IgsuSWFWpctQXtIuAUx9XPmZf3Hkux9nCL/mv
 3dE0GWiiJ99fqq4O4b+/IcufF7dvD7AlqiWaL2UzLLDgqywmwa8+ZwD1hgKhymEXQ+a/
 l++4/ui3DxqRWx4f6JSGx2XBRxCJD5UTcFvYI5u9Z2sIL/jucnkkTNI3/e0EE3K5MK+N
 eadQ==
X-Gm-Message-State: AOJu0YwafCI7oIp2p9uR9T4eEfSdE1/vZ5nTKSmH+AR7ksQJCi+U/vsX
 yLyu44ICzTSvIfsyRvK1rytIZ/kbfQtUzSS6DjbY3edADczykbCVf3LphYVsO171QPICnbSJsPo
 rItJG
X-Gm-Gg: ASbGnctaefIGY1+QjDHf1s079F/Gcysg2V69WoXu7DuMyiYBM35WWMzKCMk1xe83LBU
 iuZMU4ymrrRtjzwN4+VwuxXWxW5+WEUZhgJkUB6rTlsDTWpvH9AkQcWODex9PQ8vMsuC9R0NUAC
 Bvk1Zctn2NTV6mSBJ1hI1H5LVSmZ271tVXM87lJ60IOdU9aZDbKYfTG9f7YWllrlDJLYvl1n5ZJ
 7foAL+Ps0e1RcDuaCvyfZwulr4D5llRIkAIeq/fCbGqkn9FTSdduwwhnBtoehyuXuY3+DmVy9Pk
 06SEinYzMRDxG7M3T+PHlItDF7GrtQC4X0FMl9hZuxzLT9zTF3+wLtuvsHRFM3sTC/p87vX3wp3
 S48hzrViYH7sWTONiZ+HYHzAE7AMNCCvO2tzqdOIODjpDFiNuIjbQU1hpTIX/CP1yhKqg
X-Google-Smtp-Source: AGHT+IFRyPVOrEnEpQLIMDsrPcD3BrCW77aiKC4vjEC+82B5VTCizBN4m4Qj99MITrhmBs7V4SW/Aw==
X-Received: by 2002:a17:902:ced2:b0:271:ac7a:8f18 with SMTP id
 d9443c01a7336-27ed4a9615cmr78110225ad.43.1758863774712; 
 Thu, 25 Sep 2025 22:16:14 -0700 (PDT)
Received: from gromero0.. (189-47-45-49.dsl.telesp.net.br. [189.47.45.49])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed672a51fsm42160085ad.63.2025.09.25.22.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 22:16:14 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org, gustavo.romero@linaro.org,
 manos.pitsidianakis@linaro.org, peter.maydell@linaro.org
Subject: [PATCH v4 3/9] tests/functional: Provide GDB to the functional tests
Date: Fri, 26 Sep 2025 05:15:36 +0000
Message-Id: <20250926051542.104432-4-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926051542.104432-1-gustavo.romero@linaro.org>
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Because a single functional test can cover different arches, such as
aarch64, ppc64, and x86_64, only a GDB that supports all the arches in
the target list is passed to Meson for use in the functional tests. To
handle this check, a new shell function, is_target_arch_in_arch_list, is
introduced in 'configure'.

Meson then can pass the location of GDB to the test via an environment
variable: QEMU_TEST_GDB.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure                     | 21 +++++++++++++++++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  2 ++
 tests/functional/meson.build  |  6 ++++++
 4 files changed, 31 insertions(+)

diff --git a/configure b/configure
index 0f7eb95586..20e05d233f 100755
--- a/configure
+++ b/configure
@@ -1142,12 +1142,31 @@ fi
 #########################################
 # gdb test
 
+# Check if all target arches are in a provided list of arches.
+is_target_arch_in_arch_list() {
+    arch_list=$1
+    for target in $target_list; do
+        arch=${target%%-*}
+        if test "${arch_list#*$arch}" = "$arch_list"; then
+            # Target arch not in arch list
+            return 1
+        fi
+    done
+    return 0
+}
+
 if test -n "$gdb_bin"; then
     gdb_version_string=$($gdb_bin --version | head -n 1)
     # Extract last field in the version string
     gdb_version=${gdb_version_string##* }
     if version_ge $gdb_version 9.1; then
         gdb_arches=$($python "$source_path/scripts/probe-gdb-support.py" $gdb_bin)
+
+	if is_target_arch_in_arch_list "$gdb_arches"; then
+            gdb_multiarch="yes"
+        else
+            gdb_multiarch=""
+	fi
     else
         gdb_bin=""
     fi
@@ -1984,6 +2003,8 @@ if test "$skip_meson" = no; then
   test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
   test "$plugins" = yes && meson_option_add "-Dplugins=true"
   test "$tcg" != enabled && meson_option_add "-Dtcg=$tcg"
+  test "$gdb_multiarch" = yes && meson_option_add "-Dgdb=$gdb_bin"
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


