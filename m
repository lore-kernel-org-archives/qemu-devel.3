Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD938CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDL2S-0001jO-C9; Mon, 27 Oct 2025 07:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL2P-0001em-Dj
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:05:21 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL1a-0005br-IV
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:05:20 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b5b823b4f3dso563514566b.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563030; x=1762167830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XeRSVxV/a/+cXLwVgc+XC0DpKFA3aVxT1tt4Uj60OQ8=;
 b=wWD9G/qJHJV+g3P9eISyRZZS2+K1MzOHe6L9jminNsfavdvHYfvPEM+AHjebDnuU7L
 +mvu/ONdLQGDyaYEqNDzYHMWgQC2/PaJCQ7TmLIAP89OSgotaA+2iuTOKWFrvEgjx9Rl
 ETOkTqZb7vZ3Bc+MetDp14GEqsOSr5nlZrbliQKTbM7Tlm78pjpa4vIkYEcwgkk4Cpjv
 X57VVGVVNtTfDneg+bEvQapDd+O+o54FYbHsnuR1Y4ZoISc/82bAyM13C9cz8XHiHFbW
 s5TJPXMSUFBcYGXR1JesyhNXJXYfFZDEmsJVRkoVIsPB/l7pvH43C1ZCz36i7f25MpIq
 9Odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563030; x=1762167830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XeRSVxV/a/+cXLwVgc+XC0DpKFA3aVxT1tt4Uj60OQ8=;
 b=hJqIWQy+cQDqhwFM7vAvBeHSUhzSokwST5ERN3iL2yQ5YJQ0DoqM7yP6zRIbtrOT36
 MCruYJr/Xs2TYHWfPdTzYCOoN8M/YEMVRe8xhTQpJtzvPTDOId31koSI1QmAJJKEbcoY
 ZJnTAIR2cpC5YMA3E2x2TYNUtSRFGzEIY1KwjCdsZiC5B5OERvRaJPjF1relzWJ7kWvj
 6FcPle/YZbXqZOfcwxBvSyY5c/gpmVb9y2ZdHuXulvpOLhoCDMGIiGMM9+pnVzV6rRnO
 zy3p6fHbLiH/9goHPT4IJl2QG/nai2Erm49I5B2buyYmPuMyJFX1l3fUeXPZqvFv6xdM
 fFWg==
X-Gm-Message-State: AOJu0YxPyuUD9dId4VigA6hV63qPDkZS8OUNjim/v71LaT/G/SgNwzBe
 X2vzG3yR5wyT1Z/S8BJTCnrD1OgOouvYjpYb+6ZpTsWPt+sRQ9moXVEXlLKwZ/17lVg=
X-Gm-Gg: ASbGncvstDZER54wSObN+w+V5Rq9Xe/Do6EtNlUTMMpkMN9sO7UK/qaXFwma7PhvW+o
 v5WmVr11zQQ6oV0t8AmPkoNQC7dVjKCzg474080u5d7MAeQz3W+PWs82MLBCHKNKVC06v4hwKLZ
 WjMX95tFf3O+TSeX149qMQfeu92IAPEkfiO44Rys2Zf/woCoMyv8sHW2iSVYbVOByfAh59/2KeI
 RpGNDzDLz2i+x7XwvpTi2OwWBt+d+r59bI/lBvg9tbufHfR3jITbzVnO0mUXSasMOc81pzFcykw
 DAGNsXrQD6jk1xKv3aV3E7DObmjj/cjHxRW/BgMn2S5fvqchH+aETLU7vEYDU8ONX3e+CTFRMZ9
 1GA9C23wjlR0xtX+BFWdNyqA+9dIYhBwX1VNx3vbjjkWPKuXte5vYzgc0+mtWoi6hYEliiNY1OS
 tvMcK2DU8BEJ8=
X-Google-Smtp-Source: AGHT+IGVeVAd9SOhpQydD1C6iIU4n4tkewdKGA2QFdCIbJrrSlQ45g2gAXLS0i8sKETvZQ5il8jl6g==
X-Received: by 2002:a17:906:794f:b0:b6d:80e6:cf with SMTP id
 a640c23a62f3a-b6d80e6068cmr742975766b.44.1761563029639; 
 Mon, 27 Oct 2025 04:03:49 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853077c7sm733658066b.7.2025.10.27.04.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:03:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 94EBF5FA07;
 Mon, 27 Oct 2025 11:03:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 05/35] tests/lcitool: generate a yaml file for the ppc64le
 runner
Date: Mon, 27 Oct 2025 11:03:12 +0000
Message-ID: <20251027110344.2289945-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027110344.2289945-1-alex.bennee@linaro.org>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/ci/setup/build-environment.yml        |  10 +-
 .../ci/setup/debian/debian-13-ppc64le.yaml    | 134 ++++++++++++++++++
 tests/lcitool/refresh                         |   1 +
 3 files changed, 143 insertions(+), 2 deletions(-)
 create mode 100644 scripts/ci/setup/debian/debian-13-ppc64le.yaml

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


