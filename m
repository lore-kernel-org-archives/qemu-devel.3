Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51790C982CD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6rbH-0002TV-5Q; Wed, 16 Sep 2026 11:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6rao-0002Cx-OW
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:42 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6raj-0001Rp-Ek
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:38 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso9926375e9.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 08:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789572632; x=1790177432; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gwlxe/ftx0pHehXwbKVnrhXAcQYcmg6mCdmQFjqdGEY=;
 b=PxbpSlPorMVoCHb141w6dV4BPE8XSpJqXfVDP3Z5ujNSCczWPsoqSkqRW79YrgEpxD
 5YcJC/H4UI1799mqTdd/5RdDxJnHq9/UdUOgpgVp/NHbejpWFR3B7h4/PW547zD8XWf/
 rUcIZE2ykMVCAZX2riL0wo2C1TGedeEzUZCD/5pI5D6TYJOhIgLPhgAXbvCL/4+0GHKz
 dRUk+6kqma4+IuefbA9Q1TBwwk0D1i86lWzvBJbaMFjEf/ROYz9M9OyKeo6fCLqG0JOX
 UAb0SVb5ThnY2l749OkKcoP3nDVnb6tphMh4Bk/gibZj4ZheKl743ca45v0bE8sT31sh
 MxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789572632; x=1790177432;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gwlxe/ftx0pHehXwbKVnrhXAcQYcmg6mCdmQFjqdGEY=;
 b=HtASh4pH3hlJGfgRZseAoPvW7cMbswBVX+9fwfabLJcSVeO6TCfMGck2Cyo7eTJmc0
 vR/bl+IhFLGXaxtj6P0klcP+u6Oqi67EkyXlnO8W3jFK/SoUuutnYbHrMi8hUKvjCsrf
 wz5IT5FfcCSsOVhCgwQAbIfDyje/5CEXlb0pJKVTaXK9GLpnOqHjhy4kMaEJJDg2ksnH
 0E4HDAvLAh0NEzdzabhPWQK7bUVzn6unXAKu+etRbYAp9zopV1kMB7eT3RvmkBKHDCq9
 hyVTNVSVmFtAIDbvteW1HhTMC8W3dB8Ra2jadhPTpUlkQPOUZeY/6A17i5c5hzhR2YJM
 vdxw==
X-Gm-Message-State: AFuF++mGMhgd/L3CNHg0ZGdoq1TRFsbnHKLczJC/yFEvDhbQ9WIYAWk2
 E27Y/J7py9NLnA6jctSIXqgMqqoyFeZ6xQV8NHtvcpAOZPLkwzhr3mePWBVAm2OQ8l0=
X-Gm-Gg: AYBFou0Namo5VEfN9nQGv77plLrIv5Gi/wFOrxK53tlAsZ+wX8jzFKchEtCxZllTmWw
 +icZpMevvWO0dgX3EDBWorYiZU9lFr9YxVOVrINuIoeoLD4/vBAUvpiBme+ellqsdxoLASYPDKu
 SuA9Bj5P9c811N1zo2Xpq3FiVfX4BVMzz8bYd/ISI310bPwPbWfVvX8BmO1fneCcUbbsAP+29pZ
 KEi/cQL14DeO0IOcrDRI/1ZRv68j7DiX+8dWJEP7s2fqKHoRplK0NTygUFIagdfObKf0+OeA9fq
 PdJ7t5306iORRt5jWEV4erymYHFFLWnyZwfe29ien8cXEHSXQs1g/R6Cp6clEqElGA9oMZFi5jf
 l0VE0qnC/OdvVZW6O11kXzWSVjlqGJL5MkeZt+JvW4ByNIy/muWPk4COQTm2LUVUHPtYaATP2Qk
 O2dFbifwhOktx4OjMZQ7tvRb7vgorlfAI4rwLLLmg08UGH1ytNnHYEbygz2wruiNlOz9r+1Cw=
X-Received: by 2002:a05:600c:6290:b0:49d:1f32:c911 with SMTP id
 5b1f17b1804b1-49eac462565mr33754665e9.3.1789572631761; 
 Wed, 16 Sep 2026 08:30:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e847e89f3sm30371715e9.3.2026.09.16.08.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:30:22 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BE8F761901;
 Wed, 16 Sep 2026 16:30:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-arm@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Kyle Evans <kevans@freebsd.org>,
 Eric Farman <farman@linux.ibm.com>, Brad Smith <brad@comstyle.com>,
 Fabiano Rosas <farosas@suse.de>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 05/19] configure: re-purpose the tcg test compiler configs
 for vdso building
Date: Wed, 16 Sep 2026 16:29:58 +0100
Message-ID: <20260916153013.2134555-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916153013.2134555-1-alex.bennee@linaro.org>
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

All the tcg tests are in meson now so there is no reason to put the
config-target.mak files in those directories. We also don't need the
GDB feature tests or to emit prerequsistes.

The vdso re-build blob does use the compiler definitions though so
we can emit the details for that and tweak the vdso makefiles to point
at the right place. Note some of the vdso makefiles build both 32 and
64 bit versions from the same compiler.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure                            | 69 +++++++++++-----------------
 linux-user/aarch64/Makefile.vdso     |  2 +-
 linux-user/arm/Makefile.vdso         |  2 +-
 linux-user/hppa/Makefile.vdso        |  2 +-
 linux-user/i386/Makefile.vdso        |  2 +-
 linux-user/loongarch64/Makefile.vdso |  2 +-
 linux-user/ppc/Makefile.vdso         |  2 +-
 linux-user/riscv/Makefile.vdso       |  2 +-
 linux-user/s390x/Makefile.vdso       |  2 +-
 linux-user/sh4/Makefile.vdso         |  2 +-
 linux-user/x86_64/Makefile.vdso      |  2 +-
 11 files changed, 36 insertions(+), 53 deletions(-)

diff --git a/configure b/configure
index 4c7bf406b88..67967cd294c 100755
--- a/configure
+++ b/configure
@@ -1736,65 +1736,48 @@ if test "$default_targets" = "yes"; then
   echo "CONFIG_DEFAULT_TARGETS=y" >> $config_host_mak
 fi
 
-tcg_tests_with_compilers=
+# Export the compiler details needed for rebuilding the vdso blobs
 for target in $target_list; do
-  arch=${target%%-*}
 
+  # Skip anything that is not a linux-user target
   case $target in
+    *-linux-user)
+      ;;
+    *)
+      continue
+      ;;
+  esac
+
+  arch=${target%%-*}
+
+  case $arch in
     xtensa*-linux-user)
-      # the toolchain is not complete with headers, only build system tests
+      # the toolchain can only build system tests due to missing headers
+      continue
+      ;;
+    aarch64_be-linux-user)
+      # there is no BE user space
       continue
       ;;
-    *-softmmu)
-      test -f "$source_path/tests/tcg/$arch/Makefile.softmmu-target" || continue
-      qemu="qemu-system-$arch"
+    aarch64|arm|hppa|i386|loongarch64|ppc64|riscv64|s390x|sh4|x86_64)
+      # arches which need a vdso, some 64 bit arches build both
       ;;
-    *-linux-user|*-bsd-user)
-      qemu="qemu-$arch"
+    *)
+      continue
       ;;
   esac
 
-  if probe_target_compiler $target || test -n "$container_image"; then
-      test -n "$container_image" && build_static=y
-      mkdir -p "tests/tcg/$target"
-      config_target_mak=tests/tcg/$target/config-target.mak
-      ln -sf "$source_path/tests/tcg/Makefile.target" "tests/tcg/$target/Makefile"
+  # note container_image is set by a successful call to probe_target_compiler
+  if probe_target_compiler "$target" || test -n "$container_image"; then
+      mkdir -p "linux-user/$arch"
+      config_target_mak=linux-user/$arch/config-target.mak
       echo "# Automatically generated by configure - do not modify" > "$config_target_mak"
       echo "TARGET_NAME=$arch" >> "$config_target_mak"
       echo "TARGET=$target" >> "$config_target_mak"
-      write_target_makefile "build-tcg-tests-$target" >> "$config_target_mak"
-      echo "BUILD_STATIC=$build_static" >> "$config_target_mak"
-      echo "QEMU=$PWD/$qemu" >> "$config_target_mak"
-
-      # will GDB work with these binaries?
-      if test "${gdb_arches#*$arch}" != "$gdb_arches"; then
-          echo "GDB=$gdb_bin" >> $config_target_mak
-      fi
-
-      if test "${gdb_arches#*$arch}" != "$gdb_arches" && version_ge $gdb_version 14.1; then
-          echo "GDB_HAS_SME_TILES=y" >> $config_target_mak
-      else
-          echo "GDB_HAS_SME_TILES=n" >> $config_target_mak
-      fi
-
-      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 15.1; then
-          echo "GDB_HAS_MTE=y" >> $config_target_mak
-      fi
-
-      if test "${gdb_arches#*aarch64}" != "$gdb_arches" && version_ge $gdb_version 16.0; then
-          # GDB has to support MTE in baremetal to allow debugging MTE in QEMU system mode
-          echo "GDB_SUPPORTS_MTE_IN_BAREMETAL=y" >> $config_target_mak
-      fi
-
-      echo "run-tcg-tests-$target: $qemu\$(EXESUF)" >> Makefile.prereqs
-      tcg_tests_with_compilers="$tcg_tests_with_compilers $target"
+      write_target_makefile "update-linux-vdso" >> "$config_target_mak"
   fi
 done
 
-if test "$tcg" = "enabled"; then
-    echo "TCG_TESTS_WITH_COMPILERS=$tcg_tests_with_compilers" >> $config_host_mak
-fi
-
 if test "$skip_meson" = no; then
   cross="config-meson.cross.new"
   meson_quote() {
diff --git a/linux-user/aarch64/Makefile.vdso b/linux-user/aarch64/Makefile.vdso
index c33a679c0f2..82ed2011087 100644
--- a/linux-user/aarch64/Makefile.vdso
+++ b/linux-user/aarch64/Makefile.vdso
@@ -1,4 +1,4 @@
-include $(BUILD_DIR)/tests/tcg/aarch64-linux-user/config-target.mak
+include $(BUILD_DIR)/linux-user/aarch64/config-target.mak
 
 SUBDIR = $(SRC_PATH)/linux-user/aarch64
 VPATH += $(SUBDIR)
diff --git a/linux-user/arm/Makefile.vdso b/linux-user/arm/Makefile.vdso
index ede489e2363..16ae8d7aaae 100644
--- a/linux-user/arm/Makefile.vdso
+++ b/linux-user/arm/Makefile.vdso
@@ -1,4 +1,4 @@
-include $(BUILD_DIR)/tests/tcg/arm-linux-user/config-target.mak
+include $(BUILD_DIR)/linux-user/arm/config-target.mak
 
 SUBDIR = $(SRC_PATH)/linux-user/arm
 VPATH += $(SUBDIR)
diff --git a/linux-user/hppa/Makefile.vdso b/linux-user/hppa/Makefile.vdso
index f4537ae7169..78642c42661 100644
--- a/linux-user/hppa/Makefile.vdso
+++ b/linux-user/hppa/Makefile.vdso
@@ -1,4 +1,4 @@
-include $(BUILD_DIR)/tests/tcg/hppa-linux-user/config-target.mak
+include $(BUILD_DIR)/linux-user/hppa/config-target.mak
 
 SUBDIR = $(SRC_PATH)/linux-user/hppa
 VPATH += $(SUBDIR)
diff --git a/linux-user/i386/Makefile.vdso b/linux-user/i386/Makefile.vdso
index 95bc616f6d6..ca2e37fa6b6 100644
--- a/linux-user/i386/Makefile.vdso
+++ b/linux-user/i386/Makefile.vdso
@@ -1,4 +1,4 @@
-include $(BUILD_DIR)/tests/tcg/i386-linux-user/config-target.mak
+include $(BUILD_DIR)/linux-user/i386/config-target.mak
 
 SUBDIR = $(SRC_PATH)/linux-user/i386
 VPATH += $(SUBDIR)
diff --git a/linux-user/loongarch64/Makefile.vdso b/linux-user/loongarch64/Makefile.vdso
index 1d760b1e47e..ceb61101209 100644
--- a/linux-user/loongarch64/Makefile.vdso
+++ b/linux-user/loongarch64/Makefile.vdso
@@ -1,4 +1,4 @@
-include $(BUILD_DIR)/tests/tcg/loongarch64-linux-user/config-target.mak
+include $(BUILD_DIR)/linux-user/loongarch64/config-target.mak
 
 SUBDIR = $(SRC_PATH)/linux-user/loongarch64
 VPATH += $(SUBDIR)
diff --git a/linux-user/ppc/Makefile.vdso b/linux-user/ppc/Makefile.vdso
index e2b8facbb50..6b9be843817 100644
--- a/linux-user/ppc/Makefile.vdso
+++ b/linux-user/ppc/Makefile.vdso
@@ -1,4 +1,4 @@
-include $(BUILD_DIR)/tests/tcg/ppc64-linux-user/config-target.mak
+include $(BUILD_DIR)/linux-user/ppc64/config-target.mak
 
 SUBDIR = $(SRC_PATH)/linux-user/ppc
 VPATH += $(SUBDIR)
diff --git a/linux-user/riscv/Makefile.vdso b/linux-user/riscv/Makefile.vdso
index 2c257dbfda5..2eefdb70cf9 100644
--- a/linux-user/riscv/Makefile.vdso
+++ b/linux-user/riscv/Makefile.vdso
@@ -1,4 +1,4 @@
-include $(BUILD_DIR)/tests/tcg/riscv64-linux-user/config-target.mak
+include $(BUILD_DIR)/linux-user/riscv64/config-target.mak
 
 SUBDIR = $(SRC_PATH)/linux-user/riscv
 VPATH += $(SUBDIR)
diff --git a/linux-user/s390x/Makefile.vdso b/linux-user/s390x/Makefile.vdso
index e82bf9e29ff..51f7c50a2de 100644
--- a/linux-user/s390x/Makefile.vdso
+++ b/linux-user/s390x/Makefile.vdso
@@ -1,4 +1,4 @@
-include $(BUILD_DIR)/tests/tcg/s390x-linux-user/config-target.mak
+include $(BUILD_DIR)/linux-user/s390x/config-target.mak
 
 SUBDIR = $(SRC_PATH)/linux-user/s390x
 VPATH += $(SUBDIR)
diff --git a/linux-user/sh4/Makefile.vdso b/linux-user/sh4/Makefile.vdso
index 272c5d262de..ed2cc11b825 100644
--- a/linux-user/sh4/Makefile.vdso
+++ b/linux-user/sh4/Makefile.vdso
@@ -1,4 +1,4 @@
-include $(BUILD_DIR)/tests/tcg/sh4-linux-user/config-target.mak
+include $(BUILD_DIR)/linux-user/sh4/config-target.mak
 
 SUBDIR = $(SRC_PATH)/linux-user/sh4
 VPATH += $(SUBDIR)
diff --git a/linux-user/x86_64/Makefile.vdso b/linux-user/x86_64/Makefile.vdso
index 26552b66dba..56fe87af72b 100644
--- a/linux-user/x86_64/Makefile.vdso
+++ b/linux-user/x86_64/Makefile.vdso
@@ -1,4 +1,4 @@
-include $(BUILD_DIR)/tests/tcg/x86_64-linux-user/config-target.mak
+include $(BUILD_DIR)/linux-user/x86_64/config-target.mak
 
 SUBDIR = $(SRC_PATH)/linux-user/x86_64
 VPATH += $(SUBDIR)
-- 
2.47.3


