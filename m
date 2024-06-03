Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1442DC27C50
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 17:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEBse-0007DE-Tv; Mon, 03 Jun 2024 13:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBsQ-00074K-7O
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:53:46 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBsK-0000CF-87
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:53:45 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4212f0444efso1036005e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 10:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717437219; x=1718042019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eyETGJ7FAfbleq050QORjF2RnGfBN+QWuLIy+JDRMVY=;
 b=B9WqJp7T5qewCUqi19y/YaV+ywFqQWyX3UK/Blp0V676VWR02k+sPCvlYgAsXu0fHs
 vkAhawMpk4gY7RM1Y9IKESfbTVR3eXFJgguv3EHJ4RLkFTXrFu6mbi6RNp5XMDv25y1C
 hBVgvQaVfpP/iGQ3Qllg6duSlWfJ2OyFSI7VmfGSBRr6+FZ2TpgKYmjHAqe/9oy15NM6
 LtJ7PFmfWt4plzEeYBEY/zYujxFfF/gg20NDaip2EQ3NBAwtkOzQTgr4RRCh2xPv1Hhh
 CRBRvhbAUHn+jBraVsqbi1Lgf4JDTDTukQ00pniVGknuc1zKoYrIa4riMG/0UrbBXCYq
 /J7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717437219; x=1718042019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eyETGJ7FAfbleq050QORjF2RnGfBN+QWuLIy+JDRMVY=;
 b=Iiv3+PvodorO3BSRJCLLwsyhOebfD/f2afPCpf360dfBUSni6HR6i6xVNs3+zDURbe
 mK7B4Xd94U0Q4m2FDEBx5U9N1s579bW0CVXD5uhHpQFZM0F0O7+FyRfsheH+8HhKGzU7
 FI4x1WtHgTnXL9Mby0K7MULTFvpYFZZa+D0hv0EBMNRY0tBi2X9ffxo6AmQ97sPOZGWB
 G/+xJSV79AdkLVDEkcBRHtiBTTP4JP730yGEKeGdFe+he28UEZLx0/KucpXcGQjznRwe
 xbQn1VJhufuUhI/cSE2lWtYZyWKbAeBSPFx9qML3o0uBoEakZYCb/horCb+qbqvcuKGL
 er8A==
X-Gm-Message-State: AOJu0Yx5HVrW0kNvIfNp3jk8uoPOqQ+LzhpQjQ1YtActAQKzEWUbFjjp
 i8YScEvubQP9plGsBNNfWoCACcw+16eJikN1Vq9T7pzDDBNhrv/F9B9cHL2HwNs=
X-Google-Smtp-Source: AGHT+IEyp+ZrDRNNl/KP8P+0KowrfxCqSN2VJeEl+AQYVMYb3ZClGVFJFksOCYAbPlWBeetPd4V1Rw==
X-Received: by 2002:a5d:68cf:0:b0:354:f92f:fd00 with SMTP id
 ffacd0b85a97d-35e0f30c6b5mr6594420f8f.52.1717437218915; 
 Mon, 03 Jun 2024 10:53:38 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04d9c89sm9324185f8f.60.2024.06.03.10.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 10:53:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C10975FA08;
 Mon,  3 Jun 2024 18:53:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Leif Lindholm <quic_llindhol@quicinc.com>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH v3 12/12] scripts/ci: drive ubuntu/build-environment.yml from
 lcitool
Date: Mon,  3 Jun 2024 18:53:28 +0100
Message-Id: <20240603175328.3823123-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240603175328.3823123-1-alex.bennee@linaro.org>
References: <20240603175328.3823123-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now lcitool can write the package list for us we no longer need to
duplicate the information directly in build-environment.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240529160934.982373-10-alex.bennee@linaro.org>
---
 scripts/ci/setup/ubuntu/build-environment.yml | 131 +-----------------
 1 file changed, 7 insertions(+), 124 deletions(-)

diff --git a/scripts/ci/setup/ubuntu/build-environment.yml b/scripts/ci/setup/ubuntu/build-environment.yml
index e82097b465..edf1900b3e 100644
--- a/scripts/ci/setup/ubuntu/build-environment.yml
+++ b/scripts/ci/setup/ubuntu/build-environment.yml
@@ -32,135 +32,18 @@
       when:
         - ansible_facts['distribution'] == 'Ubuntu'
 
-    # lcitool variables -f json ubuntu-2204 qemu | jq -r '.pkgs[]' | xargs -n 1 echo "-"
-    - name: Install basic packages to build QEMU on Ubuntu 22.04
-      package:
-        name:
-          - bash
-          - bc
-          - bison
-          - bsdextrautils
-          - bzip2
-          - ca-certificates
-          - ccache
-          - clang
-          - dbus
-          - debianutils
-          - diffutils
-          - exuberant-ctags
-          - findutils
-          - flex
-          - g++
-          - gcc
-          - gcovr
-          - genisoimage
-          - gettext
-          - git
-          - hostname
-          - libaio-dev
-          - libasan5
-          - libasound2-dev
-          - libattr1-dev
-          - libbpf-dev
-          - libbrlapi-dev
-          - libbz2-dev
-          - libc6-dev
-          - libcacard-dev
-          - libcap-ng-dev
-          - libcapstone-dev
-          - libcmocka-dev
-          - libcurl4-gnutls-dev
-          - libdaxctl-dev
-          - libdrm-dev
-          - libepoxy-dev
-          - libfdt-dev
-          - libffi-dev
-          - libgbm-dev
-          - libgcrypt20-dev
-          - libglib2.0-dev
-          - libglusterfs-dev
-          - libgnutls28-dev
-          - libgtk-3-dev
-          - libibumad-dev
-          - libibverbs-dev
-          - libiscsi-dev
-          - libjemalloc-dev
-          - libjpeg-turbo8-dev
-          - libjson-c-dev
-          - liblttng-ust-dev
-          - liblzo2-dev
-          - libncursesw5-dev
-          - libnfs-dev
-          - libnuma-dev
-          - libpam0g-dev
-          - libpcre2-dev
-          - libpixman-1-dev
-          - libpng-dev
-          - libpulse-dev
-          - librbd-dev
-          - librdmacm-dev
-          - libsasl2-dev
-          - libsdl2-dev
-          - libsdl2-image-dev
-          - libseccomp-dev
-          - libslirp-dev
-          - libsnappy-dev
-          - libspice-protocol-dev
-          - libssh-dev
-          - libsystemd-dev
-          - libtasn1-6-dev
-          - libubsan1
-          - libudev-dev
-          - liburing-dev
-          - libusb-1.0-0-dev
-          - libusbredirhost-dev
-          - libvdeplug-dev
-          - libvirglrenderer-dev
-          - libvte-2.91-dev
-          - libxml2-dev
-          - libzstd-dev
-          - llvm
-          - locales
-          - make
-          - meson
-          - multipath-tools
-          - ncat
-          - nettle-dev
-          - ninja-build
-          - openssh-client
-          - pkgconf
-          - python3
-          - python3-numpy
-          - python3-opencv
-          - python3-pillow
-          - python3-pip
-          - python3-sphinx
-          - python3-sphinx-rtd-theme
-          - python3-venv
-          - python3-yaml
-          - rpm2cpio
-          - sed
-          - sparse
-          - systemtap-sdt-dev
-          - tar
-          - tesseract-ocr
-          - tesseract-ocr-eng
-          - texinfo
-          - xfslibs-dev
-          - zlib1g-dev
-        state: present
+    # the package lists are updated by "make lcitool-refresh"
+    - name: Include package lists based on OS and architecture
+      include_vars:
+        file: "ubuntu-2204-{{ ansible_facts['architecture'] }}.yaml"
       when:
         - ansible_facts['distribution'] == 'Ubuntu'
         - ansible_facts['distribution_version'] == '22.04'
+        - ansible_facts['architecture'] == 'aarch64' or ansible_facts['architecture'] == 'x86_64'
 
-    # not all packages are available for all architectures
-    - name: Install additional packages to build QEMU on Ubuntu 22.04
+    - name: Install packages for QEMU on Ubuntu 22.04
       package:
-        name:
-          - libpmem-dev
-          - libspice-server-dev
-          - libxen-dev
-        state: present
+        name: "{{ packages }}"
       when:
         - ansible_facts['distribution'] == 'Ubuntu'
         - ansible_facts['distribution_version'] == '22.04'
-- 
2.39.2


