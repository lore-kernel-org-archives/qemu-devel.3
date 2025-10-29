Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EB7CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8S7-000444-2C; Wed, 29 Oct 2025 11:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8S4-00042O-Hi
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:08 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Rw-0002sm-9A
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:08 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b6d3effe106so2709766b.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753053; x=1762357853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USJvroAe4YWNpWWacUbn1WFtugDBkJmsxwDxe+5+ZlI=;
 b=alE8cmqAm0y2zJ99Qm3OzX+ADub8/S481Xr1m6dvjLunFY9oJT7N/zBmr8NdkBtp9T
 xSHiyKPJjaTX86gepXhRmW1w50ghHaIbgbcBXycFcROyMzcDHS8scUj35SqbJMGX9Khf
 rRBOW9Nix5zHmJt54aJ0n4VctJsw7c8+gttfEiB0i8Y/YE4Uocf7gKXbjwzfo8YPZqyn
 CFHKdfoVVnPTyz1/LuCzvKXuOaUVorISHVWxVJyWJOVofsgkKBbP0+I35SXjTikjg1+O
 +8znR+S2Upg3ix8Ezzg6Ivv+VTzZTwX50ekhHRcg3grqI18chVHTGd/p5M0ky5+dz8Na
 GdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753053; x=1762357853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=USJvroAe4YWNpWWacUbn1WFtugDBkJmsxwDxe+5+ZlI=;
 b=YTgOn/tXRMDUXyZ/WfRGYxAjF5FfxYK6pCXvrFQMMxrMnBN1UU1xABPR9oJF4QiFm4
 XCt2mUnUmhOeMZ7MT1Mhkf/ZAZfRyFyk8sQAhaRG4YWlGsdajYzVcJhIU3nyOBlAE7vU
 DqU/SpYhsCQkEFNXbAEkhSM8DzmVWNNCZyFJvBqls4L91X6uWUGZDPlFuByyVhSdNhXJ
 BKgyoiM8BfWC2vcD313Q7+V2E723VOJyJy9QOX8RwTr1R47g6FeDAjHjms/rclohpd75
 4b3KRREoXPQZo8yBZC4K03rLWdoUG+pfIptkRJHvUuqHWp9qsattwtDBDI7/nT03zakL
 Pu2w==
X-Gm-Message-State: AOJu0YyZErc0Xtl1mLmnvWsIL4irGl2ojrG0LEQoPLpMNEOwRBzrCv9W
 1T/uMTwwNNaJYHR0RxHaiNLMo4LsNWTE1P2JCtTn0Z2LwvVIetHTM7rQ9B/DSdC57pA=
X-Gm-Gg: ASbGnctckmL5hFFNAxi5y9hzG18zmNW79WCT0x9xlfQ3iFGMZTOaSFstNY+/KlRmq3T
 J88rusq4bfW2D0M1NkJzFAKT/P7WpOD6wNq+qtoCOdzX15iE9yrviLaAFj4i+J9hdTf0iN7zXSY
 76uZfWil72XC+GfsVMvKrcLvAeaCjrzmZzn1S6eSPwXCbGxu92kjM4yHP00SSJ2XBd8SE1UHPYz
 rTvmdf7CN/q5RvH8EPnI3axoW+IYlS43xKgGs3VDwII9+X1odwmplpVMPNiFxpbnyCyBl/S91qs
 udUXX1IybQmFCYOEcXckuiuHm3K1EsCjcN7XBPnYuGdVrmsPGUUGXrZT61MqnOwlGE2oW8MqxqT
 T5TupHnPsxczGRyuXD6Y2MFvyszoA5k725lIfNkW7ZSJtJhGireL4lSac/s4FoPRWeDExLcBHjN
 IR
X-Google-Smtp-Source: AGHT+IGAqDWLjgWlwMFTIOzzzLbG1vlfcPUaNxsOWBLbs3eIDXXUKclPUj4i/E9pZlSgZUjCwAPJvg==
X-Received: by 2002:a17:907:7292:b0:b33:a2ef:c7 with SMTP id
 a640c23a62f3a-b703d5cb7efmr387845066b.55.1761753053058; 
 Wed, 29 Oct 2025 08:50:53 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8544c9f5sm1491873866b.68.2025.10.29.08.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 55E885FA07;
 Wed, 29 Oct 2025 15:50:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 05/35] tests/lcitool: generate a yaml file for the ppc64le
 runner
Date: Wed, 29 Oct 2025 15:50:14 +0000
Message-ID: <20251029155045.257802-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

Unlike the Aarch64 runners this comes with pure Debian out of the box.
We need a minor tweak to build-environment to deal with the
differences in naming convention.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20251027110344.2289945-6-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/build-environment.yml
index 253d0b759bc..528150dce78 100644
--- a/scripts/ci/setup/build-environment.yml
+++ b/scripts/ci/setup/build-environment.yml
@@ -27,20 +27,26 @@
         - ansible_facts['distribution'] in ['Ubuntu', 'Debian']
 
     # the package lists are updated by "make lcitool-refresh"
-    - name: Define package list file path
+    - name: Define package list file path for Ubuntu
       set_fact:
         package_file: "ubuntu/ubuntu-2404-{{ ansible_facts['architecture'] }}.yaml"
       when:
         - ansible_facts['distribution'] == 'Ubuntu'
         - ansible_facts['distribution_version'] == '24.04'
 
+    - name: Define package list file path for Debian
+      set_fact:
+        package_file: "debian/debian-{{ ansible_facts['distribution_major_version'] }}-{{ ansible_facts['architecture'] }}.yaml"
+      when:
+        - ansible_facts['distribution'] == 'Debian'
+
     - name: Include package lists based on OS and architecture
       include_vars:
         file: "{{ package_file }}"
       when:
         - package_file is exists
 
-    - name: Install packages for QEMU on Ubuntu 24.04
+    - name: Install packages for QEMU on Ubuntu/Debian
       package:
         name: "{{ packages }}"
       when:
diff --git a/scripts/ci/setup/debian/debian-13-ppc64le.yaml b/scripts/ci/setup/debian/debian-13-ppc64le.yaml
new file mode 100644
index 00000000000..e29c9c18403
--- /dev/null
+++ b/scripts/ci/setup/debian/debian-13-ppc64le.yaml
@@ -0,0 +1,134 @@
+# THIS FILE WAS AUTO-GENERATED
+#
+#  $ lcitool variables --host-arch ppc64le debian-13 qemu
+#
+# https://gitlab.com/libvirt/libvirt-ci
+
+packages:
+  - bash
+  - bc
+  - bindgen
+  - bison
+  - bsdextrautils
+  - bzip2
+  - ca-certificates
+  - ccache
+  - clang
+  - dbus
+  - debianutils
+  - diffutils
+  - exuberant-ctags
+  - findutils
+  - flex
+  - gcc
+  - gcovr
+  - gettext
+  - git
+  - hostname
+  - libaio-dev
+  - libasan8
+  - libasound2-dev
+  - libattr1-dev
+  - libbpf-dev
+  - libbrlapi-dev
+  - libbz2-dev
+  - libc6-dev
+  - libcacard-dev
+  - libcap-ng-dev
+  - libcapstone-dev
+  - libcbor-dev
+  - libclang-rt-dev
+  - libcmocka-dev
+  - libcurl4-gnutls-dev
+  - libdaxctl-dev
+  - libdrm-dev
+  - libepoxy-dev
+  - libfdt-dev
+  - libffi-dev
+  - libfuse3-dev
+  - libgbm-dev
+  - libgcrypt20-dev
+  - libglib2.0-dev
+  - libglusterfs-dev
+  - libgnutls28-dev
+  - libgtk-3-dev
+  - libgtk-vnc-2.0-dev
+  - libibverbs-dev
+  - libiscsi-dev
+  - libjemalloc-dev
+  - libjpeg62-turbo-dev
+  - libjson-c-dev
+  - liblttng-ust-dev
+  - liblzo2-dev
+  - libncursesw5-dev
+  - libnfs-dev
+  - libnuma-dev
+  - libpam0g-dev
+  - libpcre2-dev
+  - libpipewire-0.3-dev
+  - libpixman-1-dev
+  - libpng-dev
+  - libpulse-dev
+  - librbd-dev
+  - librdmacm-dev
+  - libsasl2-dev
+  - libsdl2-dev
+  - libsdl2-image-dev
+  - libseccomp-dev
+  - libselinux1-dev
+  - libslirp-dev
+  - libsnappy-dev
+  - libsndio-dev
+  - libspice-protocol-dev
+  - libspice-server-dev
+  - libssh-dev
+  - libstd-rust-dev
+  - libsystemd-dev
+  - libtasn1-6-dev
+  - libubsan1
+  - libudev-dev
+  - liburing-dev
+  - libusb-1.0-0-dev
+  - libusbredirhost-dev
+  - libvdeplug-dev
+  - libvirglrenderer-dev
+  - libvte-2.91-dev
+  - libxdp-dev
+  - libzstd-dev
+  - llvm
+  - locales
+  - make
+  - mtools
+  - multipath-tools
+  - ncat
+  - nettle-dev
+  - ninja-build
+  - openssh-client
+  - pkgconf
+  - python3
+  - python3-numpy
+  - python3-opencv
+  - python3-pillow
+  - python3-pip
+  - python3-setuptools
+  - python3-sphinx
+  - python3-sphinx-rtd-theme
+  - python3-tomli
+  - python3-venv
+  - python3-wheel
+  - python3-yaml
+  - rpm2cpio
+  - rustc
+  - sed
+  - socat
+  - sparse
+  - swtpm
+  - systemtap-sdt-dev
+  - tar
+  - tesseract-ocr
+  - tesseract-ocr-eng
+  - vulkan-tools
+  - xorriso
+  - zlib1g-dev
+  - zstd
+
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 056cfb6e9d7..7fbdf6f340b 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -272,6 +272,7 @@ try:
     #
     generate_yaml("ubuntu", "ubuntu-2404", "aarch64")
     generate_yaml("ubuntu", "ubuntu-2404", "s390x")
+    generate_yaml("debian", "debian-13", "ppc64le")
 
 
     sys.exit(0)
-- 
2.47.3


