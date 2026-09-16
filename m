Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EEAC982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lOx-0007st-Hv; Wed, 16 Sep 2026 04:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6lOt-0007oj-48
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:53:55 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6lOp-000504-AB
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:53:54 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-48437356d60so290566f8f.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 01:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789548830; x=1790153630; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i2Y6PTJy6Ue37NuEEJ19/+e1vKsW2mbiw6rvAiII2Gw=;
 b=LfoUKhywP8tf1nB3p9H2UtBVB4UqnsC1sKYLRSDR2Bg4lRlvTKkqZEpW3xiM/zfOlf
 06JNK39f7pr8qiDJnI+K2Vq1dTebAKtQGn0iqAsOOeB7pmbPbugtBMvhj9WB/Qv8Mn28
 VTQ3II+zUuvurg8B79nKdPrhcOT096GEDs77SsR2wOvHEAvHtzu+m8Q580LG3m5cbdfg
 iWlCpPMH4ftXD6fcUn/mX3VsT9dYRnSVUnQXixvQQ8IWzYZ/6ak20W+ntBTM3sf5mpOa
 ten+bm2W0M1kxLJSTghftUD+hlH36lWkHy3vPm1uUnYmZkW3BaGmmarCGvg8kZmZt7dR
 2deQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789548830; x=1790153630;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i2Y6PTJy6Ue37NuEEJ19/+e1vKsW2mbiw6rvAiII2Gw=;
 b=SO2fLAkFYcmU6zLdGdGe5eX92z3I8lkcPLoFfnNIVEcqLy2ff8ko+v6MKla6/s2gGu
 cHLaC9K2/qFJ7H8Q4aVdcHYhCvZ754W37pe/rMRAAC6I0POu+B9bK97iVX444vNeLGL5
 JjwWqFtw0w/t/6VBxNNH4RnIlVlwAFakDbTDi7ZCOCxjqpFbNXeg4+VKo1U7AAD3coET
 S2SxS/327PtxtD4DDL5oyNFjJn5ab2G86nV+b2l93y3G7x/zuA1Hq418ACS8en3sJ+Nd
 GCbcd04IGJSexE8b30gkGBTNA24nS9NmVtcLOb4wJL1kWF9zB6ta4z9rvxxyzeUnRGkt
 1h7w==
X-Gm-Message-State: AFuF++nVpkElZA9ZFFNloP/okf2uX4aCdT4I36GERexQbx1qxWcaV9Us
 2k0GQER0rclycBEz3Yo+xPd6SsjlZlxpbY6pF1hK/tbMCx0mFWXh5nr6NfN/hLPZAlM=
X-Gm-Gg: AYBFou0TOyeCLOxjMwoINyiNvB2Z0fkFW23YpHT8jjSmZRO43I15/ywevA97N3p/u5i
 GOaYGTMCu2YmKkKD5ItdD1QYLBreapskF2ePqcwPfwr2rfpyHUGGsi+BbhQ88GG7WDZFOrsqHKN
 NLfv6hL0BULEm91cKu/GWJQUEE4/eGO39Z0eJ7aEwzQx50kWO7VFM2NBClWJ0hrjMVr5JFqsaF/
 BzBT+2FmvRL1qR54awHq8l6ISOMH8DyynMfTNypjgj7OsbFH5qgcW+Xy7pHLQ6vYQmNSnHM7Xn2
 Nc4sy9hXD6lvgBah3oo9ROk4fv/QwQYDy68O72ruD3QBpf3dOK9BgEbZUn1GWqYl1f5HU0t5BWg
 iEJBVnW/qRdk+a+0biqDKlGgBqJyiVjdbcIbeK14vYKyg9m2xaavW1f2dj1rq64wsUsBqijIqLI
 jXoqOYsEovoFmYcoQRXsnLJ9QAY/BEQAMpY0dVX+QRdDO+aYNJobq9VRpft5wIfnzKPEFCS10=
X-Received: by 2002:a05:6000:2312:b0:487:355:4619 with SMTP id
 ffacd0b85a97d-4870cf273d4mr2312749f8f.4.1789548829598; 
 Wed, 16 Sep 2026 01:53:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1f98csm5065257f8f.11.2026.09.16.01.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 01:53:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 66A85618D5;
 Wed, 16 Sep 2026 09:53:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Warner Losh <imp@bsdimp.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <gaosong@loongson.cn>,
 Kyle Evans <kevans@freebsd.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 09/17] tests/docker: add container registry to configure
 and use
Date: Wed, 16 Sep 2026 09:53:32 +0100
Message-ID: <20260916085341.1692742-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916085341.1692742-1-alex.bennee@linaro.org>
References: <20260916085341.1692742-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x0f.google.com
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

Previously we had the default baked into Makefile.include but as the
meson container logic will also benefit from it we update the configure
machinery.

For now we allow direct make invocations to override but for the
normal case it is in one place now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - fixed conflicts from the revert.
v3
  - regen meson-buildoptions.sh
---
 configure                     | 8 ++++++++
 meson_options.txt             | 4 ++++
 scripts/meson-buildoptions.sh | 3 +++
 tests/docker/Makefile.include | 4 +---
 tests/tcg/meson.build         | 6 ++++++
 5 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index d1b4e6d3ff6..b9d64993835 100755
--- a/configure
+++ b/configure
@@ -173,6 +173,7 @@ fi
 
 # default parameters
 container_command=""
+container_registry="registry.gitlab.com/qemu-project/qemu"
 cpu=""
 cross_compile="no"
 cross_prefix=""
@@ -733,6 +734,9 @@ for opt do
   ;;
   --container-command=*) container_command="$optarg"
   ;;
+  --container-registry=*) container_registry="$optarg"
+                          meson_option_add -Dcontainer_registry="$optarg"
+  ;;
   --rust-target-triple=*) rust_target_triple="$optarg"
   ;;
   --gdb=*) meson_option_add -Dgdb="$optarg"
@@ -867,6 +871,7 @@ Advanced options (experts only):
   --cpu=CPU                Build for host CPU [$cpu]
   --disable-containers     don't use containers for cross-building
   --container-command=CMD  which container command to use [autodetect]
+  --container-registry=URL which container registry to cache from [$container_registry]
   --gdb=GDB-path           gdb to use for gdbstub tests [autodetect]
   --wasm64-32bit-address-limit Restrict wasm64 address space to 32-bit (default
                                is to use the whole 64-bit range).
@@ -1729,6 +1734,9 @@ echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
 echo "MESON=$meson" >> $config_host_mak
 echo "NINJA=$ninja" >> $config_host_mak
 echo "EXESUF=$EXESUF" >> $config_host_mak
+if test -n "$container_registry"; then
+  echo "DOCKER_DEFAULT_REGISTRY=$container_registry" >> $config_host_mak
+fi
 if test "$default_targets" = "yes"; then
   echo "CONFIG_DEFAULT_TARGETS=y" >> $config_host_mak
 fi
diff --git a/meson_options.txt b/meson_options.txt
index 218d003a80b..5a080b2360c 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -389,3 +389,7 @@ option('rust', type: 'feature', value: 'disabled',
        description: 'Rust support')
 option('strict_rust_lints', type: 'boolean', value: false,
        description: 'Enable stricter set of Rust warnings')
+
+option('container_registry', type: 'string',
+       value: 'registry.gitlab.com/qemu-project/qemu',
+       description: 'container registry to cache from')
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index ba3c9de216b..0cb1d48c982 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -10,6 +10,9 @@ meson_options_help() {
   printf "%s\n" '  --block-drv-rw-whitelist=VALUE'
   printf "%s\n" '                           set block driver read-write whitelist (by default'
   printf "%s\n" '                           affects only QEMU, not tools like qemu-img)'
+  printf "%s\n" '  --container-registry=VALUE'
+  printf "%s\n" '                           container registry to cache from'
+  printf "%s\n" '                           [registry.gitlab.com/qemu-project/qemu]'
   printf "%s\n" '  --datadir=VALUE          Data file directory [share]'
   printf "%s\n" '  --disable-coroutine-pool coroutine freelist (better performance)'
   printf "%s\n" '  --disable-debug-info     Enable debug symbols and other information'
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 0adddb6a5c6..74bf471f171 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -11,9 +11,7 @@ USER = $(if $(NOUSER),,$(shell id -un))
 UID = $(if $(NOUSER),,$(shell id -u))
 
 DOCKER_FILES_DIR := $(SRC_PATH)/tests/docker/dockerfiles
-ifeq ($(HOST_ARCH),x86_64)
-DOCKER_DEFAULT_REGISTRY := registry.gitlab.com/qemu-project/qemu
-endif
+DOCKER_DEFAULT_REGISTRY ?= registry.gitlab.com/qemu-project/qemu
 DOCKER_REGISTRY := $(if $(REGISTRY),$(REGISTRY),$(DOCKER_DEFAULT_REGISTRY))
 
 CONTAINER_COMMAND ?= $(shell $(SRC_PATH)/tests/docker/docker.py probe)
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 28a8e7a0558..fce70f8e56f 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -84,6 +84,9 @@ docker_supported = docker_probe.returncode() == 0
 if docker_supported
   docker_wrapper = [docker_wrapper, '--command', docker_probe.stdout().strip()]
 endif
+if get_option('container_registry') != ''
+  tcg_tests_summary += {'container registry': get_option('container_registry')}
+endif
 
 # plugins come first, as we need to build the list
 test_plugins = {}
@@ -219,6 +222,9 @@ foreach target, plan: tcg_tests
     if cc_dockerfile not in image_targets and has_docker
       cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', 'qemu/' + cc_dockerfile,
              '--add-current-user']
+      if get_option('container_registry') != ''
+        cmd += ['--registry', get_option('container_registry')]
+      endif
       t = custom_target(image_name, command: cmd,
                         build_by_default: false,
                         output: 'no_output_' + image_name)
-- 
2.47.3


