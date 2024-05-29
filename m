Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B980FC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLsL-0000nn-7D; Wed, 29 May 2024 12:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLsI-0000jE-95
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:10:02 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLs0-0003Jo-7B
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:10:00 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52ad8230bb9so1088527e87.3
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 09:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716998982; x=1717603782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/qJ7xDiNWdg4bRPzfstpnmSMAmVg6rR997URbUEFLNQ=;
 b=lRk/hi54fIATeGFKcp1IGJyrUncJI8v0c76cYg34s5wL8UDhV9QG7KSpzBnoS7ndi+
 PmCAbgMJhZ4XhUWSQENqbT7kY0SBGZvuRFCkNPgWewCZ0Yn20F5jXfx4vYHbI8aVP8Sy
 pnvb2NlOMkcPPhMQcdY9SRWd1fo8oXsI+LC2bhtbBnIpbFy8c9KKECQzjiKIWPp60w5d
 osXunwKhuflZ3Oyxb8viwcwTH9b6i8be678q72jO2uQeTpWObCYVhuo72r+MQmWX96/n
 yef0+qVunFEsTh5VNk9UbhqMBpOxWw/kHCt5plLE91KiWjFPN+gc0btLeoXgBKhWywwF
 OhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716998982; x=1717603782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/qJ7xDiNWdg4bRPzfstpnmSMAmVg6rR997URbUEFLNQ=;
 b=ZMAtR+87CW3Fr4AJx2NJWHwd42CCehUSY/+mi7mJPgxwfkluH+johj4We6RN5AqHxj
 wvowFMy6PaNX9quU2sVicvmSdTapR03Xwp9tFrjil2MRhxOAnVHMpldvhTN54LaVpujZ
 UfZTkwDafj84ALczTjUazZq8y4x9xRmeJ5v8RIvHVKnVx8vdY4uh94+dbaUAcgo+e06p
 NsyKDEHmoaIeQyzam/tZIcXJdjusARXcPO0hK4s6cpnAxqpbV2GlUE3wQyJkJ88u/l/X
 veHgrBT/4q1lg+c6tIg5f8PXA8VLFrXxiDKOwdfgucK/QwI14oMaGVCUeVVoLW0cVmYZ
 3tuQ==
X-Gm-Message-State: AOJu0YwqdmjbDkfXX1TvGFRU2GjUuu+B3cv8xKBUoGilol9wyStbRoqY
 WzIToiRE1tPmp7GVEsGj7R5rKc1wWMEy7E+LAK7AnHdMxqrVdA0c3IaD20m7Q6w=
X-Google-Smtp-Source: AGHT+IEwderT+q3O8iYlmC30u+S23KECjoGwC6m/uDArvq4roozqGxTlhhFI4gabd8hrVhcnho3D3w==
X-Received: by 2002:ac2:5dca:0:b0:51e:150e:2c45 with SMTP id
 2adb3069b0e04-52966e9ac88mr9614472e87.63.1716998980558; 
 Wed, 29 May 2024 09:09:40 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5798d861b05sm5993830a12.25.2024.05.29.09.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 09:09:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E4DE55FA94;
 Wed, 29 May 2024 17:09:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH 09/10] scripts/ci: drive ubuntu/build-environment.yml from
 lcitool
Date: Wed, 29 May 2024 17:09:33 +0100
Message-Id: <20240529160934.982373-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529160934.982373-1-alex.bennee@linaro.org>
References: <20240529160934.982373-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12f.google.com
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


