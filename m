Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6A8C79FBF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4jIq-00040t-Ny; Thu, 10 Sep 2026 14:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4jIp-0003x4-9N
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:15:15 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4jIm-000748-Rj
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:15:14 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49d036e0e99so838075e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 11:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789064111; x=1789668911; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T5Xuw/KQ0j+V1bZw5QEINYzzMk8dJ72+D9GtgNKZY48=;
 b=bmikMRSUJ/6y+omp15H94d/+ptfYN7CIcQaVSVb/V156JovA0sobhkTDBKfgdHQdjf
 F8HGz0CyG2O3+GZGH0gCFj/iKbWzVPtfEzPnFEEjufii6Cs4BlqkrwAgg5THNdHbc7YO
 gMMxGM4Rx6K93PDESxzci/8rIaCUmQAbR+kdd8wn7bmdd0ZbpueWFRP9fwgAW0uZ5FlC
 Y6J4fbhuIplYI0ChqyBaiRLXK/5NAVV9RtWSuJS/WFm0g0+BLVeqbGN71RCsOs5QIZrx
 rRHNMdpOjlqJXZ/vk/Al9lzHiRP+rpUKbYu1y561JNUNNvRbFRUfRr7SoQrUJF9ke/TL
 xq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789064111; x=1789668911;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T5Xuw/KQ0j+V1bZw5QEINYzzMk8dJ72+D9GtgNKZY48=;
 b=qctavkGqa0tKItAeQnXDUZ3L1dT7nfITKtbc8qG2boKr7SQBN9SKCeoqN48Xf8yz9S
 IDOB8O5hMXOyGaN5Ns5uP+ErP+5CegnT6czQ6BHyhTcWFOlGKTpdrAZUcPpWsXBp+XZS
 0eZ4f0BqrYLdhebdYAbLq3p3iNSRc3ey4jc2RiizV3XDdgWG/n8ibjNerhkLlxvvaHX+
 7KdDfutuvS1U9H35L5B/awQlhfyNi05Z80rWPFZVr3m2YhFAIJjvCG7r6PLx6Qudzcho
 ly1fSInhe5rwRcRutSBgJDqyieKEukEyfQZzxJGUTxZtewD621WX6AYpyxkU6N2DMQV6
 D6wA==
X-Gm-Message-State: AFuF++lMFcj2eIdFfcGRUCX77KR4/WNOMaoFTg3ASOBy/8H8W9h/UQit
 RrrB6lfw0dNwVNNxE3gzFL89MRzN2+pB9maYgCsiYlMME6eQIPpuM6fEbRjPmpGX/jM=
X-Gm-Gg: AYBFou2lrFKM/dop1oyOD693ZGRKbbfszoa0X+l0KzL+0WJ9nt/rjCiFZsXymhCAiKR
 Wc7nKwOCyr/OR0istA9OryVbcPs8/iyj3l+pysKnlwRZg0KhKhV6xdKpRF/STD+FdHEmjwIUTro
 S+o5yoi8gwVTM/hQmKqmpk7uRRx4k9LI0WlB+D1TqcgESKjT65fLffNGTTE+VxFbW0Gl5JAsbsk
 2mHSIk4C+6c78mFH3goEXIpuQeN6/GWoICsKxYz3iAdPgOk/5wQjN17MqHhVY/n8Q/EFDfNFW+x
 bGC0QFfPYz5zYTEuTwSdPKs/O9gSFbdDutiKmlULH+oGfUurv3WwwslLoumyKR0/mzAApJJ0Iqq
 n8f31G+/3cD65rLttZVjD5o1WZjU4bGTFfZaD3DE5tWBFr9JfKy6IYvVx2E4ZUHY5BPmAibm+f+
 87T6vpztyj96QFhKrkEMR6WXqhkmYfO+AkxiXs7+NsKwCSX6dDITctkERA9ukBDLwoAiGt9GdnP
 Jq+8j6aoQ==
X-Received: by 2002:a05:600c:8712:b0:49c:ee36:10fc with SMTP id
 5b1f17b1804b1-49e619acbfemr3156425e9.8.1789064111449; 
 Thu, 10 Sep 2026 11:15:11 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33fd3bsm208083f8f.19.2026.09.10.11.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 11:15:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 84A0D5FCE5;
 Thu, 10 Sep 2026 19:15:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 5/9] tests/docker: add container registry to configure and use
Date: Thu, 10 Sep 2026 19:15:00 +0100
Message-ID: <20260910181504.1010916-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910181504.1010916-1-alex.bennee@linaro.org>
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Previously we had the default baked into Makefile.include but as the
meson container logic will also benefit from it we update the configure
machinery.

For now we allow direct make invocations to override but for the
normal case it is in one place now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure                     | 8 ++++++++
 meson_options.txt             | 3 +++
 tests/docker/Makefile.include | 4 +---
 tests/tcg/meson.build         | 6 ++++++
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index aaa41fe47aa..7d6b11ddd35 100755
--- a/configure
+++ b/configure
@@ -172,6 +172,7 @@ fi
 # some defaults, based on the host environment
 
 # default parameters
+container_registry="registry.gitlab.com/qemu-project/qemu"
 cpu=""
 cross_compile="no"
 cross_prefix=""
@@ -728,6 +729,9 @@ for opt do
   ;;
   --container-command=*) meson_option_add -Dcontainer_command="$optarg"
   ;;
+  --container-registry=*) container_registry="$optarg"
+                          meson_option_add -Dcontainer_registry="$optarg"
+  ;;
   --rust-target-triple=*) rust_target_triple="$optarg"
   ;;
   --gdb=*) meson_option_add -Dgdb="$optarg"
@@ -862,6 +866,7 @@ Advanced options (experts only):
   --cpu=CPU                Build for host CPU [$cpu]
   --disable-containers     don't use containers for cross-building
   --container-command=CMD  which container command to use [autodetect]
+  --container-registry=URL which container registry to cache from [$container_registry]
   --gdb=GDB-path           gdb to use for gdbstub tests [autodetect]
   --wasm64-32bit-address-limit Restrict wasm64 address space to 32-bit (default
                                is to use the whole 64-bit range).
@@ -1318,6 +1323,9 @@ echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
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
index 292625af08a..030231492e1 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -391,6 +391,9 @@ option('containers', type: 'boolean', value: true,
        description: 'use containers to cross compile tcg tests')
 option('container_command', type: 'string',
        description: 'command to build/run containers')
+option('container_registry', type: 'string',
+       value: 'registry.gitlab.com/qemu-project/qemu',
+       description: 'container registry to cache from')
 
 option('tcg_tests_cross_cc_aarch64', type: 'string',
        description: 'cc for aarch64 tcg tests')
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
index 814f2f8cd8c..22157a47c96 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -101,6 +101,9 @@ if get_option('containers')
   endif
 endif
 tcg_tests_summary += {'container command': container_command}
+if get_option('container_registry') != ''
+  tcg_tests_summary += {'container registry': get_option('container_registry')}
+endif
 
 # plugins come first, as we need to build the list
 test_plugins = {}
@@ -257,6 +260,9 @@ foreach target, plan: tcg_tests
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


