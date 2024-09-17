Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3207C35FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 08:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqTw1-0007ky-FC; Tue, 17 Sep 2024 04:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sqTvz-0007kT-7z
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:51:43 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sqTvm-00005L-4L
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 04:51:41 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cbbb1727eso44362235e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 01:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726563077; x=1727167877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sDwmDwyOhKnQJ0sz4RS/eydK+R6xk885g9EHeZWpZCw=;
 b=W95BCXmbHltdISrarirnNCG3cN7IMknWA4YsLhbrWVnH8poLFL+o2OutPe7oYe67jw
 IsoJMTgasioztPvi9dSRGc25LWsw7+cXf6zVjHo7EZmnbilhy2OK07YG/eW1wuNkLOfT
 ras8Q8AigwxN3wo+h/yA0OPzSdJgvFcqG+mtHdwaCGGfcN/6272TllIA4RtTIa6TKSM6
 v1dBQLLnDZssHkS1Nly1fXVLUsYJL8FSe3CUBCB1tNUAQR4Or/vxvs7hhXifjQM4+/HL
 afUY+X3owCp2rwRZ8ViymY15eWf45lqghF+oPkF7bI5PRrVNqOPdxHhdAODHS8Pz6MBa
 5zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726563077; x=1727167877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sDwmDwyOhKnQJ0sz4RS/eydK+R6xk885g9EHeZWpZCw=;
 b=JrXv5EPxIbzlEa3AQtKNiz9cvn7yjfHBJuAmmNqJCygvk+8tG6hfuKz8JjVVY1XOSq
 2A3PCov0GFmJo9tT/KGoudDwJrNE4m4BqhhMbCRJYoP3ryK0q+N13I5ZbPiTpktVnhQL
 PfgGOQhh+re3kFt9UOWPzbJ5MMue+Rl35dLOAbTb9S3QZJhjedbrxZzvDJV1QaapTUA8
 cDnu47gkugQUCAjUQnBMuL2Lqk2KfKr3jK47hwARC0VnmoQ3pRYjHec2Bsp9+GLM6J/5
 hnzZ3MfrAnb2kU6BPta6jJdIb8uULrxzNYZDmUCAkdTBV7Oyh1Lyr25YlNEnM22FxW8a
 enYg==
X-Gm-Message-State: AOJu0Yxo0+9BNqRTfXqITBnlZEJwVnm6+ymBRMnwsUMfxGy2p+eb+pwe
 SkEghwr8vrc9wDW7Izrxd+3lwJuavzPBAcFpz6ce/92kB/Wg+FW2ff647Q3rcaruiYWiG1YVCjY
 cXlk=
X-Google-Smtp-Source: AGHT+IFIl+BtPfLYnASczDhJ0Vv5aFdE3o7hAAHUHsTgbsgmVBQ7Wffl8OewdmtCj1hlr56YTjVDVA==
X-Received: by 2002:a5d:4dc2:0:b0:371:87d4:8f12 with SMTP id
 ffacd0b85a97d-378c2cfc857mr9370001f8f.17.1726563077490; 
 Tue, 17 Sep 2024 01:51:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.131.223])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e78052e4sm8845073f8f.102.2024.09.17.01.51.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Sep 2024 01:51:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 3/3] .gitlab-ci.d/cirrus: Add manual testing of macOS 15
 (Sequoia)
Date: Tue, 17 Sep 2024 10:50:58 +0200
Message-ID: <20240917085058.1740-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240917085058.1740-1-philmd@linaro.org>
References: <20240917085058.1740-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Upgrade libvirt-ci so it covers macOS 15. Add a manual entry
(QEMU_JOB_OPTIONAL: 1) to test on Sequoia release. Refresh the
lci-tool generated files.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Pending libvirt-ci MR 501: https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/501

CI job: https://gitlab.com/philmd/qemu/-/jobs/7841560032
---
 .gitlab-ci.d/cirrus.yml           | 17 +++++++++++++++++
 .gitlab-ci.d/cirrus/macos-15.vars | 16 ++++++++++++++++
 tests/lcitool/libvirt-ci          |  2 +-
 tests/lcitool/refresh             |  1 +
 4 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 .gitlab-ci.d/cirrus/macos-15.vars

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index f061687f1b..b84b42cce5 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -66,6 +66,22 @@ aarch64-macos-14-base-build:
     NAME: macos-14
     CIRRUS_VM_INSTANCE_TYPE: macos_instance
     CIRRUS_VM_IMAGE_SELECTOR: image
+    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-ventura-base:latest
+    CIRRUS_VM_CPUS: 12
+    CIRRUS_VM_RAM: 24G
+    UPDATE_COMMAND: brew update
+    INSTALL_COMMAND: brew install
+    PATH_EXTRA: /opt/homebrew/ccache/libexec:/opt/homebrew/gettext/bin
+    PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
+    CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,microblazeel-softmmu,mips64-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4-softmmu,xtensaeb-softmmu
+    TEST_TARGETS: check-unit check-block check-qapi-schema check-softfloat check-qtest-x86_64
+
+aarch64-macos-15-base-build:
+  extends: .cirrus_build_job
+  variables:
+    NAME: macos-15
+    CIRRUS_VM_INSTANCE_TYPE: macos_instance
+    CIRRUS_VM_IMAGE_SELECTOR: image
     CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-sonoma-base:latest
     CIRRUS_VM_CPUS: 12
     CIRRUS_VM_RAM: 24G
@@ -74,3 +90,4 @@ aarch64-macos-14-base-build:
     PATH_EXTRA: /opt/homebrew/ccache/libexec:/opt/homebrew/gettext/bin
     PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
     TEST_TARGETS: check-unit check-block check-qapi-schema check-softfloat check-qtest-x86_64
+    QEMU_JOB_OPTIONAL: 1
diff --git a/.gitlab-ci.d/cirrus/macos-15.vars b/.gitlab-ci.d/cirrus/macos-15.vars
new file mode 100644
index 0000000000..23b2c1d22f
--- /dev/null
+++ b/.gitlab-ci.d/cirrus/macos-15.vars
@@ -0,0 +1,16 @@
+# THIS FILE WAS AUTO-GENERATED
+#
+#  $ lcitool variables macos-15 qemu
+#
+# https://gitlab.com/libvirt/libvirt-ci
+
+CCACHE='/opt/homebrew/bin/ccache'
+CPAN_PKGS=''
+CROSS_PKGS=''
+MAKE='/opt/homebrew/bin/gmake'
+NINJA='/opt/homebrew/bin/ninja'
+PACKAGING_COMMAND='brew'
+PIP3='/opt/homebrew/bin/pip3'
+PKGS='bash bc bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
+PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
+PYTHON='/opt/homebrew/bin/python3'
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index 789b4601bc..488392b0a8 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 789b4601bce4e01f43fdb6ad4ce5ab4e46674440
+Subproject commit 488392b0a8f4ea91599f3e5b282bcba243f9ae80
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index d111b01480..06d27f9cf2 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -203,6 +203,7 @@ try:
     #
     generate_cirrus("freebsd-14")
     generate_cirrus("macos-14")
+    generate_cirrus("macos-15")
 
     #
     # VM packages lists
-- 
2.45.2


