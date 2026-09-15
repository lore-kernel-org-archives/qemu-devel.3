Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBEEC982C4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ZbZ-00008r-Mf; Tue, 15 Sep 2026 16:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6ZZd-0006sQ-Ko
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:16:18 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6ZZZ-0003I0-C7
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:16:13 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e8185e037so1166015e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789503368; x=1790108168; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NZWPhlLkOuk9iA3jYBR1D22Zr4Gwpb30arbfNP6pIW0=;
 b=wo0PEaay6p9X0UKERY/hIioL2N7Vqps45XVR61wuzQCtfs24sDhYfoxVQFjuWqJ4KG
 HEbj4x/hQxJLav0wyXoosR/DMVlEbo+bWXE77vaCcfDENN0m84GlTUEViyd7MGx4sDI9
 0AQLeUmaOtA+z7j+OFMU0ie0er1rb+nPQGMQF333SHuZBdmTsRgmLk/MyjmKSbgvEOY/
 3W7MJ/KhMym1WFhEI5oFpxcgUgh+MQUNoSCOIdj4Z84TD+AcJIgIk73UwMWMFpXidWad
 Vm/KOfSVjBtyeubWwCP45ytpcMwfg5IOJge8JGhNWI/qYzLkrNLZvudzKpNybJ1QpaXa
 cDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789503368; x=1790108168;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NZWPhlLkOuk9iA3jYBR1D22Zr4Gwpb30arbfNP6pIW0=;
 b=VesIvmPHUYaNHiytOkD4uGpQ92AF1u91WqWCHW+RgTjeRdOw50lSRZv+bWk3TT7Ycz
 2uIrpTX5+bbN/RspJwu68pu5r6RJU6K4QlAblXDynC7Ox/TFduOdlvQX+IednSOx9iYe
 ocFF15cQjbvEQJzQ7OFwBWxE7hRW7zpk4D4zHR1Qv2LbygGv4jrsB/IH0FH2jKLhdAxH
 R3IfbNB/acZ365QCiXUMFdl8TChBuKA8xIBrp7EhVkX6iDBfFYVIead1heMSsVs9DY/o
 bFK+exg0dZH2QOihjDrSSndqxhP20S4EoDPO5Etv+wcS5xwN2UNRBhOFyGTI3lHuaFLh
 h2sg==
X-Gm-Message-State: AFuF++kDCkXZogIzKZwW2ytpRi1iZQTPWN5IjaBzy/savJ3nu6OnhJSY
 w9YfO4/sXux4Ve7GyEz4HLX26WpiLv1SRLk+uWxZWq6A9bOsMiNg346vW+YhICXILzQ=
X-Gm-Gg: AYBFou1gIet5XbeE1QVJdeEE+U5J7wbW1bT02l2DUANvlAzQeGTSe8IPxi4SCvqJbQk
 VsycLvFPzK2hiXNdFL4jG48HlP4q0cZTzJwIEpinffwvxyzTCKRoIEdQsZPCJ7hk2B7M9LggCiN
 mPOjPHg6CSRPb7stgcmdQgSzEQ/aCuuLdRtwBi4l0pNROx/2B/JM7MKIMRQJbf/bYqQxyFBPPVG
 hcIW9WGSVkzJjQolQiYvK9xFW3m/5goydT2CXGwwo7+NLj5lxt5Tr+v8g7qWX5nVGn9rxnoPDKq
 lSFXNhXk8vc3CZu91R2II3FvGlStd1UwSNsRkVadccUuHvIS8QUY9WFM6LjCEO7agMlUECk5l7H
 uDwsb18jV3BLW651A9rLbKcNynjJ+vDu9RpbSmRZBOM8UdsmFG5Xx5fANs4wV0v2sZ69Gs3rp3b
 hKU69fKUsOMEwQG/rvQGJk5lPNwK/3lYDBT+NWZAOTte6Op/4nNQ2YFLfC5Soej9ifYn34W2q76
 5EdZs43Ag==
X-Received: by 2002:a05:600c:871b:b0:49e:69e3:884d with SMTP id
 5b1f17b1804b1-49e7a63770cmr102539025e9.4.1789503367895; 
 Tue, 15 Sep 2026 13:16:07 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83db9102sm15986175e9.12.2026.09.15.13.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:16:07 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 96235618D5;
 Tue, 15 Sep 2026 21:16:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Kyle Evans <kevans@freebsd.org>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 09/15] tests/docker: add container registry to configure
 and use
Date: Tue, 15 Sep 2026 21:15:54 +0100
Message-ID: <20260915201601.1207839-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915201601.1207839-1-alex.bennee@linaro.org>
References: <20260915201601.1207839-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Previously we had the default baked into Makefile.include but as the
meson container logic will also benefit from it we update the configure
machinery.

For now we allow direct make invocations to override but for the
normal case it is in one place now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - fixed conflicts from the revert.
---
 configure                     | 8 ++++++++
 meson_options.txt             | 4 ++++
 tests/docker/Makefile.include | 4 +---
 tests/tcg/meson.build         | 6 ++++++
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index c89f3c61f7f..fc85555c48e 100755
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


