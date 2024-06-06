Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3DDC41513
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 11:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFBe4-0007mQ-By; Thu, 06 Jun 2024 07:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBe3-0007le-CZ
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:51:03 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBe0-0000tc-ES
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:51:03 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57a2ed9af7dso1229349a12.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 04:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717674658; x=1718279458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HEiaO79EnHcFSWKjr05NL64y0sp0/W9PFgORRJ4kV5Q=;
 b=MGN0z1GECs09TirsXeNl7t807yhwrJjHbYrmrBnpopkC1d4xhxFkmFk90KC5sb4lSe
 RaPXpSH1YjyyVX5y5iKJSecGuNf3L69nbUnalzp3kDPQYZHGcF849afirPStdMthO9gm
 nT5/RLCxCi4oRly8oipKoLve4N56B5xwUI46lL09gcd4wHXVc2moKeTHYgsa9HxBSWEJ
 FViQAnegTcD11mfJ1QFaBydQDaRtmnmej8JoLoYffG6A//m3Ep8i4AJPuPbvYYMpoRgY
 LUEdF9ywXYVHZaM9LmIpACh2vARffJ+0xuCKJWj0rkBRYLexYVV/pgOtaopALp3nCpj0
 SD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717674658; x=1718279458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HEiaO79EnHcFSWKjr05NL64y0sp0/W9PFgORRJ4kV5Q=;
 b=fwlwfucCEc5y0U9DaOuoaJW15Uhb/xkVQdgEi//JPkFLP/aUeZZRwRoJ7ehHNlrh9v
 kSOEC4Oz9KuZo1YPrBFL9PSS7eMS3SNShDWAvt96SVR45jvt98jtBJ7WDJhZkx3RcNz5
 FRv9742Uf4CFsqf7ywqZmFIn9PvMOm/45vzRWYA/9xRaj7utusC8hRZB910lJe7pXDmJ
 1JcQYkEqGZCxbEwyDVnRToqgrOU98tUljIMvmdudPcDnt67bl061rheY2Bp1nz6ZjgyX
 9x6KhyapdnzVSPa/V7giHIaLe+tY4J60tKYqhtzvMfivhfZcqKguIDcBv1LN8z2QbbqI
 SfXg==
X-Gm-Message-State: AOJu0YzHA91qiITwzLjDn5vCoj8fLCrri20h7x8Qk+FIEw8LEzQ2c7n/
 1gm1sy+hj4PXK0kMw61Wm6DZcMAvnyzGhYPDnrZ2xIcp0O2qsCc1VRmZSLXTUK8=
X-Google-Smtp-Source: AGHT+IGyTifOTlv4a5c2l9SvnG9z9T+rJ2flE5ulMnWnie7F8j69UTDG3ew45mIm27AEux+fsl+CsQ==
X-Received: by 2002:a50:8e45:0:b0:578:6410:1d50 with SMTP id
 4fb4d7f45d1cf-57a8bc912abmr4241181a12.34.1717674657759; 
 Thu, 06 Jun 2024 04:50:57 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae12ce21sm971618a12.49.2024.06.06.04.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 04:50:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 147345FA2E;
 Thu,  6 Jun 2024 12:50:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 12/12] scripts/ci: drive ubuntu/build-environment.yml from
 lcitool
Date: Thu,  6 Jun 2024 12:50:47 +0100
Message-Id: <20240606115047.421045-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606115047.421045-1-alex.bennee@linaro.org>
References: <20240606115047.421045-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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
Message-Id: <20240603175328.3823123-13-alex.bennee@linaro.org>

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


