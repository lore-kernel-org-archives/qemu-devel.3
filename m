Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0499ECCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnKx-0007XN-Js; Mon, 20 Oct 2025 06:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAnKu-0007W4-UY
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:41:56 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAnKs-0000fq-Gw
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:41:56 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-63c1006fdcfso8133121a12.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956913; x=1761561713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PdnRwZ3tolRl+7dJTQy0leQsj9SwCkKXi3pwZqwGHj8=;
 b=A/aQVkmYzYKnbM/H5IuCS9y4Y8UHXqh6KZjemVlNqhz3SlKpiLgJwLqYZ3Wajkwejg
 jnPAXonPHeQbgKsORntWTY4mw4DrZxzQEaoJzFfD14KSvzBYDs/KUHtFSuRGVJRmVRN5
 RAp6N8qYqXkLClgC/5afx0hUjRVJBoHzFmyQN3JV04fwx1FIcm9KHmO2Meq8rJDGPTOe
 +dJWdG/gT3CRBRHPBAgSPgmUxfOEv+SO9YbX7XwDGexlxv7EQ8bKufLZM1l1rJxWyHUJ
 AsIifmNZWOou9sVDPsvNWJlk+XrRnK6VqS4QBCLmHhLmtD5wo7DaUPMHoZPkYcjm1ZZO
 N+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956913; x=1761561713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PdnRwZ3tolRl+7dJTQy0leQsj9SwCkKXi3pwZqwGHj8=;
 b=YqvZv6kO57X6KFjv5abMhBzpOzWB6aaNl6Lpy5W6HY0Z8iRrm1KLCFt9wwGhHhqkrR
 l7sY3pKov3XDzbYyWymy9dBgU8cuYS41e+MOAbKiljS74PUUanB9kiWOZS/Tg0GcuNtD
 wUyeXg8FtoGX3lAQcSvRQoaJpTHhQgpajsXVjRhJe2dtyJnC086rV8QFo4dosS40Usho
 dM9DmtVQfBLhYd3cSkGE+tw9tER256hloAhzuuISpdc3kg2vhlOEn9ohl5CYNUEsbOk1
 PzUyNn9TLvPu9Zh8qCfrxn8tJq+xkuzxmZkCUhga2Mj/6EC91Ac1GVoCazt7tnYl6P6K
 oQnQ==
X-Gm-Message-State: AOJu0YxMNYPChqqa2Fwta3wzO2zIlOx59crEXcngUMiX7TGsyuFg0uvq
 v5n2jArrHp25Ew/iDc0YDWsjHJkoGoUcnD6O1usc6BGicujePOrNyJDNWxzn81pBed0=
X-Gm-Gg: ASbGncvJRHiYAqM1YThzEM6ubAnTfw+BIZFsgJ96ZKklQ8vvurSMaQvXQZuYK8Os39X
 Ebb3vWDF4SF7vnjkMK83xJCH2tfTs4/wLcwBjzD3aGPiF2s7kafvZ6J5jR+ubQXYIfMHnkaxTr2
 r6zbSHCabtEdpF66yzNBKXsXnzoQIz6CBjDTpg3FYoi2hm7gsTyisinrWJTiQ3iVN8q7aX9UP0X
 qP+wb95ifofqeoG4IQOgYAwRo0gHsCmfX13sEsGtXZJ35HnHF+fnb3DbkvoyzHrXZzqk7CNKxVz
 RA/Irnxese/vy5VkkaH2As2NOOt4B1WoIshaP9VDr3te5thtZQwdsj3on/qZmVKjONbAVsV4Qgx
 MZjYTVvLzD/7cJIEgm1QqV5Zy2dmakKh4hBECoWUSLGK1MNEketeACUTF5ryL5ZyfjcaFOXxmKi
 7196omD5tEpTQ=
X-Google-Smtp-Source: AGHT+IGHFNE8coI7XKCLpdaJJXzmsGN7HOPrXK0XRFVdiSjPu+icLllpk8fL2OAbadaYzpbv83q5Iw==
X-Received: by 2002:a17:907:984:b0:b4b:cb5:133a with SMTP id
 a640c23a62f3a-b6474b371d9mr1351975266b.39.1760956912587; 
 Mon, 20 Oct 2025 03:41:52 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65e7da33dcsm760523266b.12.2025.10.20.03.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 03:41:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C17D45F872;
 Mon, 20 Oct 2025 11:41:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 02/11] gitlab: drop aarch32 runner and associated bits
Date: Mon, 20 Oct 2025 11:41:40 +0100
Message-ID: <20251020104149.4034124-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020104149.4034124-1-alex.bennee@linaro.org>
References: <20251020104149.4034124-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

While working out what hoops to jump through to get a full set of
aarch32 packages installed on the aarch64 runner it was pointed out 32
bit host support is deprecated. As the extra packages where needed for
system emulation (marked deprecated since 8.0!) there didn't seem much
point keeping this in.

While the full expunging of 32 bit host support will probably be done
for 11.0 we can at least reduce the CI burden a bit now.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20251016150357.876415-3-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runners.yml
index 3eb8216d571..142fbf4a242 100644
--- a/.gitlab-ci.d/custom-runners.yml
+++ b/.gitlab-ci.d/custom-runners.yml
@@ -31,4 +31,3 @@
 include:
   - local: '/.gitlab-ci.d/custom-runners/ubuntu-24.04-s390x.yml'
   - local: '/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml'
-  - local: '/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml'
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml
deleted file mode 100644
index 75029c9187e..00000000000
--- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml
+++ /dev/null
@@ -1,25 +0,0 @@
-# All ubuntu-24.04 jobs should run successfully in an environment
-# setup by the scripts/ci/setup/ubuntu/build-environment.yml task
-# "Install basic packages to build QEMU on Ubuntu 24.04"
-
-ubuntu-24.04-aarch32-all:
- extends: .custom_runner_template
- needs: []
- stage: build
- tags:
- - ubuntu_24.04
- - aarch32
- rules:
- - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-   when: manual
-   allow_failure: true
- - if: "$AARCH32_RUNNER_AVAILABLE"
-   when: manual
-   allow_failure: true
- script:
- - mkdir build
- - cd build
- - ../configure --cross-prefix=arm-linux-gnueabihf-
-   || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make --output-sync -j`nproc --ignore=40`
- - make --output-sync -j`nproc --ignore=40` check
diff --git a/scripts/ci/setup/ubuntu/build-environment.yml b/scripts/ci/setup/ubuntu/build-environment.yml
index 6042750cb4d..0f8ec5fab04 100644
--- a/scripts/ci/setup/ubuntu/build-environment.yml
+++ b/scripts/ci/setup/ubuntu/build-environment.yml
@@ -47,21 +47,4 @@
         - ansible_facts['distribution'] == 'Ubuntu'
         - ansible_facts['distribution_version'] == '24.04'
 
-    - name: Install armhf cross-compile packages to build QEMU on AArch64 Ubuntu 24.04
-      package:
-        name:
-          - binutils-arm-linux-gnueabihf
-          - gcc-arm-linux-gnueabihf
-          - libblkid-dev:armhf
-          - libc6-dev:armhf
-          - libffi-dev:armhf
-          - libglib2.0-dev:armhf
-          - libmount-dev:armhf
-          - libpcre2-dev:armhf
-          - libpixman-1-dev:armhf
-          - zlib1g-dev:armhf
-      when:
-        - ansible_facts['distribution'] == 'Ubuntu'
-        - ansible_facts['distribution_version'] == '24.04'
-        - ansible_facts['architecture'] == 'aarch64'
 
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml b/scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml
deleted file mode 100644
index 0cc34cd10b9..00000000000
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml
+++ /dev/null
@@ -1,127 +0,0 @@
-# THIS FILE WAS AUTO-GENERATED
-#
-#  $ lcitool variables --cross-arch armv7l ubuntu-2204 qemu
-#
-# https://gitlab.com/libvirt/libvirt-ci
-
-packages:
-  - bash
-  - bc
-  - bison
-  - bsdextrautils
-  - bzip2
-  - ca-certificates
-  - ccache
-  - dbus
-  - debianutils
-  - diffutils
-  - exuberant-ctags
-  - findutils
-  - flex
-  - gcc
-  - gcovr
-  - gettext
-  - git
-  - hostname
-  - libglib2.0-dev
-  - libpcre2-dev
-  - libsndio-dev
-  - libspice-protocol-dev
-  - llvm
-  - locales
-  - make
-  - meson
-  - mtools
-  - ncat
-  - ninja-build
-  - openssh-client
-  - pkgconf
-  - python3
-  - python3-numpy
-  - python3-opencv
-  - python3-pillow
-  - python3-pip
-  - python3-sphinx
-  - python3-sphinx-rtd-theme
-  - python3-tomli
-  - python3-venv
-  - python3-yaml
-  - rpm2cpio
-  - sed
-  - socat
-  - sparse
-  - swtpm
-  - tar
-  - tesseract-ocr
-  - tesseract-ocr-eng
-  - xorriso
-  - zstd
-  - gcc-arm-linux-gnueabihf
-  - libaio-dev:armhf
-  - libasan6:armhf
-  - libasound2-dev:armhf
-  - libattr1-dev:armhf
-  - libbpf-dev:armhf
-  - libbrlapi-dev:armhf
-  - libbz2-dev:armhf
-  - libc6-dev:armhf
-  - libcacard-dev:armhf
-  - libcap-ng-dev:armhf
-  - libcapstone-dev:armhf
-  - libcmocka-dev:armhf
-  - libcurl4-gnutls-dev:armhf
-  - libdaxctl-dev:armhf
-  - libdrm-dev:armhf
-  - libepoxy-dev:armhf
-  - libfdt-dev:armhf
-  - libffi-dev:armhf
-  - libfuse3-dev:armhf
-  - libgbm-dev:armhf
-  - libgcrypt20-dev:armhf
-  - libglib2.0-dev:armhf
-  - libglusterfs-dev:armhf
-  - libgnutls28-dev:armhf
-  - libgtk-3-dev:armhf
-  - libibumad-dev:armhf
-  - libibverbs-dev:armhf
-  - libiscsi-dev:armhf
-  - libjemalloc-dev:armhf
-  - libjpeg-turbo8-dev:armhf
-  - libjson-c-dev:armhf
-  - liblttng-ust-dev:armhf
-  - liblzo2-dev:armhf
-  - libncursesw5-dev:armhf
-  - libnfs-dev:armhf
-  - libnuma-dev:armhf
-  - libpam0g-dev:armhf
-  - libpipewire-0.3-dev:armhf
-  - libpixman-1-dev:armhf
-  - libpng-dev:armhf
-  - libpulse-dev:armhf
-  - librbd-dev:armhf
-  - librdmacm-dev:armhf
-  - libsasl2-dev:armhf
-  - libsdl2-dev:armhf
-  - libsdl2-image-dev:armhf
-  - libseccomp-dev:armhf
-  - libselinux1-dev:armhf
-  - libslirp-dev:armhf
-  - libsnappy-dev:armhf
-  - libspice-server-dev:armhf
-  - libssh-dev:armhf
-  - libsystemd-dev:armhf
-  - libtasn1-6-dev:armhf
-  - libubsan1:armhf
-  - libudev-dev:armhf
-  - liburing-dev:armhf
-  - libusb-1.0-0-dev:armhf
-  - libusbredirhost-dev:armhf
-  - libvdeplug-dev:armhf
-  - libvirglrenderer-dev:armhf
-  - libvte-2.91-dev:armhf
-  - libxen-dev:armhf
-  - libzstd-dev:armhf
-  - nettle-dev:armhf
-  - systemtap-sdt-dev:armhf
-  - zlib1g-dev:armhf
-
-- 
2.47.3


