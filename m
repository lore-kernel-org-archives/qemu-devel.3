Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31847D33992
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYsG-0005ZE-NZ; Fri, 05 Dec 2025 11:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYsF-0005Xl-2Z
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:39 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYsC-0005la-I3
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:38 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so21021325e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764952893; x=1765557693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQp/ZbbemXyzSCDNAGT1OI68GJIBYJpHR1vWpyZoxIs=;
 b=fj0KqW+nQlwq1jgrOPygyIYdl7RdacGWdDLKs8IL8sydPMC3c+7UR7pmEEZxZTsE/2
 VY7G4CO1jt4LEP+4es3VqJ8Vnxs8Ej4VShz+SSTgpceNG/gD/pM0GtXSGEPolpZlgKz4
 2arAPnT1lGj+GDkhhIKtdFxlInVgUbwn/WthVaW5Rn4FK7RiMONaqpebP/tDg20hSNa+
 bbsOsD23BE5b8JXgW2JibcvPpqmoB5Xk9IGTSUYzLjlT5newh9B9w3rcANalHRZxl1I1
 2IDC4EHyy6O8WcYrncBlCp49YTqRauBFREWZG/NBfmioQOf6e+36GnG/EXl7wqiue789
 BGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764952893; x=1765557693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rQp/ZbbemXyzSCDNAGT1OI68GJIBYJpHR1vWpyZoxIs=;
 b=wFVv9GKmwCgwirBalrvHevJD/urxS/A517HFzaTi0LgjZNxdK3mV35cLm192NJgUla
 2kUlBVLHAXK2OK2va5650n9qDQob/uqWhEFuFvRB1yMlFA+2XLyazVbZCucX0ywyznMc
 ngxfabTcuXGYT6rCdtGXVHTYgrjAyPkwOFgjaCb94hnHgf60GdcXKiTwQmawUJiW1uRs
 wIhq/NF4411tNO6skmfvdohQFbBIPCWYyD1lQbC67KChGFQNPrulWuuHxWyhz1EBe6Lu
 KEXj1ef2wLv1xu9r8xjmW6tIWPvIPNTB4+6cWrbvSgyDNEH2s74zvd2vUP+Jqd7k5B5Q
 MZbw==
X-Gm-Message-State: AOJu0Yw7djqZdRMkLWhex0em9J4HCwH4T8FQQscds/edJ60kFVynrTt3
 AbRND3Q1TIUEGjnKjvGMBggoLzR+60vfbpaJBer0uPYD78cR7mfGqcqzXtzxv9HVo+U=
X-Gm-Gg: ASbGncsJjKG4QTlYfigALj4HgXR77qyksVSih5aI7b8QjBf6aFGVmjgyLNUqhRvtChH
 DqP/ES1pp3qdNgkwFGmHi1Ex1A/roAbmmVTfjbeY2c1r0Y4qYFMB5QIqHi3VF2p0QXDRHuh7Rz/
 pFH7joODUZ6VXg4Zd4nNpgnl5oI79LK+KLKvaCxkMe7R9hdzigVBiSXp76Dzb7msW19rM4fDwcS
 D8OeacK18Z2rQjQueOPKYssRz+YiXqLafDipopNJz6bL9BxTTaWwY3VC78iKaXdkNwczRdn4A2G
 5AeWJNloRYulpYqZXCSx3Txo6/mMfXJFBNj3ZT/eE5onlJYm2P9cz/zdMBjCg6fKO1OlQpJrNWh
 1Hf1KQNpfV0Gi34JfkCkTGNpmjpVo+SGjqv650yNF7fcFWhQ08iJjUdGR17zF5oFYQCYHzVHi8m
 ED9/yqXR+dEPQ=
X-Google-Smtp-Source: AGHT+IHNaVvi+ROQJO9pfHeDXlqBLpgV3gyQsyYRSvWC/mkPnKjqnIhD/Rn1xs4u/2d5LAy5a/NVTg==
X-Received: by 2002:a05:600c:1d0e:b0:477:fcb:2256 with SMTP id
 5b1f17b1804b1-4792f386c42mr73337855e9.17.1764952893436; 
 Fri, 05 Dec 2025 08:41:33 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4793093ac44sm96982385e9.8.2025.12.05.08.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 08:41:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D17855F90A;
 Fri, 05 Dec 2025 16:41:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/14] docs/devel: update build environment setup documentation
Date: Fri,  5 Dec 2025 16:41:20 +0000
Message-ID: <20251205164125.2122504-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251205164125.2122504-1-alex.bennee@linaro.org>
References: <20251205164125.2122504-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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

Bring `libvirt-ci` front and centre when discussing dependencies for
QEMU. While we are at it:

  - drop links to additional instructions (libvirt is more upto date)
  - compress pkg installs into a table
  - call out distro/upstream dep difference in a proper note

Message-ID: <20251204194902.1340008-9-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/docs/devel/build-environment.rst b/docs/devel/build-environment.rst
index 661f6ea8504..61b2dc0d1bc 100644
--- a/docs/devel/build-environment.rst
+++ b/docs/devel/build-environment.rst
@@ -4,55 +4,103 @@
 Setup build environment
 =======================
 
-QEMU uses a lot of dependencies on the host system. glib2 is used everywhere in
-the code base, and most of the other dependencies are optional.
-
-We present here simple instructions to enable native builds on most popular
-systems.
-
-You can find additional instructions on `QEMU wiki <https://wiki.qemu.org/>`_:
-
-- `Linux <https://wiki.qemu.org/Hosts/Linux>`_
-- `MacOS <https://wiki.qemu.org/Hosts/Mac>`_
-- `Windows <https://wiki.qemu.org/Hosts/W32>`_
-- `BSD <https://wiki.qemu.org/Hosts/BSD>`_
-
-Note: Installing dependencies using your package manager build dependencies may
-miss out on deps that have been newly introduced in qemu.git. In more, it misses
-deps the distribution has decided to exclude.
-
-Linux
------
-
-Fedora
-++++++
-
-::
-
-    sudo dnf update && sudo dnf builddep qemu
-
-Debian/Ubuntu
-+++++++++++++
-
-You first need to enable `Sources List <https://wiki.debian.org/SourcesList>`_.
-Then, use apt to install dependencies:
-
-::
-
-    sudo apt update && sudo apt build-dep qemu
-
-MacOS
------
-
-You first need to install `Homebrew <https://brew.sh/>`_. Then, use it to
-install dependencies:
-
-::
-
-    brew update && brew install $(brew deps --include-build qemu)
+QEMU uses a lot of dependencies on the host system a large number of
+which are optional. At a minimum we expect to have a system C library
+(usually glibc but others can work), the glib2 library (used heavily
+in the code base) and a few other core libraries for interfacing with
+code modules and system build descriptions.
+
+We use the ``libvirt-ci`` project to handle the mapping of
+dependencies to a wide variety output formats including system install
+scripts. For example:
+
+.. code-block:: bash
+
+  # THIS FILE WAS AUTO-GENERATED
+  #
+  #  $ lcitool buildenvscript debian-13 ./tests/lcitool/projects/qemu-minimal.yml
+  #
+  # https://gitlab.com/libvirt/libvirt-ci
+
+  function install_buildenv() {
+      export DEBIAN_FRONTEND=noninteractive
+      apt-get update
+      apt-get dist-upgrade -y
+      apt-get install --no-install-recommends -y \
+              bash \
+              bc \
+              bison \
+              bzip2 \
+              ca-certificates \
+              ccache \
+              findutils \
+              flex \
+              gcc \
+              git \
+              libc6-dev \
+              libfdt-dev \
+              libffi-dev \
+              libglib2.0-dev \
+              libpixman-1-dev \
+              locales \
+              make \
+              meson \
+              ninja-build \
+              pkgconf \
+              python3 \
+              python3-venv \
+              sed \
+              tar
+      sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen
+      dpkg-reconfigure locales
+      rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
+      dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
+      mkdir -p /usr/libexec/ccache-wrappers
+      ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc
+      ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
+  }
+
+  export CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+  export LANG="en_US.UTF-8"
+  export MAKE="/usr/bin/make"
+  export NINJA="/usr/bin/ninja"
+  export PYTHON="/usr/bin/python3"
+
+If you instead select the ``qemu.yml`` project file you will get all
+the dependencies that the project can use.
+
+Using you system package manager
+--------------------------------
+
+.. note::
+
+   Installing dependencies using your package manager build dependencies may
+   miss out on deps that have been newly introduced in qemu.git. It
+   also misses deps the distribution has decided to exclude.
+
+Systems with Package Managers
++++++++++++++++++++++++++++++
+
+.. list-table:: Package Manager Commands
+  :widths: 10 50 40
+  :header-rows: 1
+
+  * - System
+    - Command
+    - Notes
+  * - Fedora
+    - ``sudo dnf update && sudo dnf builddep qemu``
+    -
+  * - Debian/Ubuntu
+    - ``sudo apt update && sudo apt build-dep qemu``
+    - Must enable `Sources List
+      <https://wiki.debian.org/SourcesList>`_ first
+  * - MacOS
+    - ``brew update && brew install $(brew deps --include-build qemu)``
+    - Using `Homebrew <https://brew.sh/>`_.
 
 Windows
--------
++++++++
 
 You first need to install `MSYS2 <https://www.msys2.org/>`_.
 MSYS2 offers `different environments <https://www.msys2.org/docs/environments/>`_.
@@ -104,7 +152,7 @@ build QEMU in MSYS2 itself.
     makepkg --syncdeps --nobuild PKGBUILD || true
 
 Build on windows-aarch64
-++++++++++++++++++++++++
+~~~~~~~~~~~~~~~~~~~~~~~~
 
 When trying to cross compile meson for x86_64 using UCRT64 or MINGW64 env,
 configure will run into an error because the cpu detected is not correct.
@@ -115,4 +163,3 @@ and force a cross compilation (with empty prefix).
 ::
 
     ./configure --cpu=x86_64 --cross-prefix=
-
-- 
2.47.3


