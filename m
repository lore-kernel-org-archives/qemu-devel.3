Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E31C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmlz-0002Ur-7E; Fri, 17 Jan 2025 08:52:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmlt-0002Tl-6f
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:52:25 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmlp-0003kk-Vh
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:52:24 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ab2bb0822a4so408956566b.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121938; x=1737726738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xom9M1/hHRIoa6wXqP36+GbithL64UKHkweB7SQXlLs=;
 b=ArOEyUJc6/fw0QJJOPLSb0Hg05+rfE8APGA+igs6N9O7SCI3/gGpcoE+NU3nV1jV7w
 swgleVhsgBg1E73eTH2p3iFjLOqrnmw/wnV8CFC8brbhIChuOrx/cdjiSJZ79QWvFxyV
 zAN9S2U9DGCO/piXUl5OHcmXf69n63J/aN07S/K46/cIwj9PhfrGBGjaN4aifwGC1vlz
 hD1pCk4I8izV2cHnTah974iMxilnHlB3dHCOvEfmQx6gn38eKBJ9H9oRYnuGzVlF0spk
 cBSzMndD9Uvl4InswKbFU8zIpw8g/Zli47XOcgYB8PRel1eIZ097DBe5Qj8/fBV2HAM5
 uvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121938; x=1737726738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xom9M1/hHRIoa6wXqP36+GbithL64UKHkweB7SQXlLs=;
 b=KsqBZ+1ATHma42fP1MtgLhnsJO1KtJfy/8njByLA9Wn7BsDWk1RQzaEi5LZ0g0UXFd
 dNGm30z3bKtFmG4l9lwBURUEj2y3ci1RPABscJg7zq2LSe61Cib4OiBxTHtbElSNsRMQ
 xbxmVygtMOtz0/p4zbbKEQl84tU7HbSeF3wM5CiVDBBqnyrf99+1Tgf7h8pMLXHohph5
 +WROlDy6Y3AjzjeBnv7yyUavJ+tcJtTAAA0W+k1/WzI9eu5/QMo/s1sPdPfZV51J+8jj
 GIFmpM5JE8zHZx5syB5O7gnVgFTT7OQ46QgtNBF01FA5bnCbG4ZJi6O4wegJ7QiqUG8n
 vBQA==
X-Gm-Message-State: AOJu0YyR5mMMm+JvFZxhN8HdQ1SmTG1NUkXzh6iOZ42FpxGuMR7KilDL
 mTkawsTkyJS2C7DnxPqSmJz9xmEXhy6iBt9AgxtHGknCF/Tt6vuYcE9Qa0XEDrs=
X-Gm-Gg: ASbGnct5ZUiXnlyk4n+tgMLfvK+UsDmxx5C98kVUWOzJS7eZym96TCybfLu2hdnWYLk
 9O4uyTxRHXwFfEXZ7CgQAQv5ofuZZj1u7x1AbfGi66gTku3FB2+gonMWl8GMzBhtB6qg/ThDYvY
 UmDwwVwYYgibdfGy9px8K4OwRPYk1bbH9gchPbOC+WhfqjB6xzE3Kjv9DLRALPUvlxsYq4G/wh8
 LLbOTtVdT38R82dq+8OWsA4tav1155CN8SPIszOrIK/cdUW8QWH2T4=
X-Google-Smtp-Source: AGHT+IEAnZJBlkkXp6B1clDgibBfsmspoijK0Dj1grD+QcgLcQWy8z54iFGKCl9ACAFHD8hToV4h4w==
X-Received: by 2002:a17:907:7ba2:b0:aa6:b63a:4521 with SMTP id
 a640c23a62f3a-ab38b1100cemr255520966b.15.1737121937716; 
 Fri, 17 Jan 2025 05:52:17 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384fcd5e2sm174983766b.170.2025.01.17.05.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:52:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2D4AD608F4;
 Fri, 17 Jan 2025 13:43:00 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 34/37] docs/devel: add information on how to setup build
 environments
Date: Fri, 17 Jan 2025 13:42:53 +0000
Message-Id: <20250117134256.2079356-35-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

MacOS and Linux are straightforward, but Windows needs a bit more
details.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241209183104.365796-5-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-35-alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index a928ce3e41..f744896f89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -72,9 +72,10 @@ R: Markus Armbruster <armbru@redhat.com>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
 W: https://www.qemu.org/docs/master/devel/index.html
 S: Odd Fixes
-F: docs/devel/style.rst
+F: docs/devel/build-environment.rst
 F: docs/devel/code-of-conduct.rst
 F: docs/devel/conflict-resolution.rst
+F: docs/devel/style.rst
 F: docs/devel/submitting-a-patch.rst
 F: docs/devel/submitting-a-pull-request.rst
 
diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index d8b0445157..482b09819c 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -29,6 +29,9 @@ The `Repology`_ site is a useful resource to identify
 currently shipped versions of software in various operating systems,
 though it does not cover all distros listed below.
 
+You can find how to install build dependencies for different systems on the
+:ref:`setup-build-env` page.
+
 Supported host architectures
 ----------------------------
 
@@ -130,7 +133,6 @@ Optional build dependencies
   cross compilation using ``docker`` or ``podman``, or to use pre-built
   binaries distributed with QEMU.
 
-
 Windows
 -------
 
diff --git a/docs/devel/build-environment.rst b/docs/devel/build-environment.rst
new file mode 100644
index 0000000000..f133ef2e01
--- /dev/null
+++ b/docs/devel/build-environment.rst
@@ -0,0 +1,118 @@
+
+.. _setup-build-env:
+
+Setup build environment
+=======================
+
+QEMU uses a lot of dependencies on the host system. glib2 is used everywhere in
+the code base, and most of the other dependencies are optional.
+
+We present here simple instructions to enable native builds on most popular
+systems.
+
+You can find additional instructions on `QEMU wiki <https://wiki.qemu.org/>`_:
+
+- `Linux <https://wiki.qemu.org/Hosts/Linux>`_
+- `MacOS <https://wiki.qemu.org/Hosts/Mac>`_
+- `Windows <https://wiki.qemu.org/Hosts/W32>`_
+- `BSD <https://wiki.qemu.org/Hosts/BSD>`_
+
+Note: Installing dependencies using your package manager build dependencies may
+miss out on deps that have been newly introduced in qemu.git. In more, it misses
+deps the distribution has decided to exclude.
+
+Linux
+-----
+
+Fedora
+++++++
+
+::
+
+    sudo dnf update && sudo dnf builddep qemu
+
+Debian/Ubuntu
++++++++++++++
+
+You first need to enable `Sources List <https://wiki.debian.org/SourcesList>`_.
+Then, use apt to install dependencies:
+
+::
+
+    sudo apt update && sudo apt build-dep qemu
+
+MacOS
+-----
+
+You first need to install `Homebrew <https://brew.sh/>`_. Then, use it to
+install dependencies:
+
+::
+
+    brew update && brew install $(brew deps --include-build qemu)
+
+Windows
+-------
+
+You first need to install `MSYS2 <https://www.msys2.org/>`_.
+MSYS2 offers `different environments <https://www.msys2.org/docs/environments/>`_.
+x86_64 environments are based on GCC, while aarch64 is based on Clang.
+
+We recommend to use MINGW64 for windows-x86_64 and CLANGARM64 for windows-aarch64
+(only available on windows-aarch64 hosts).
+
+Then, you can open a windows shell, and enter msys2 env using:
+
+::
+
+    c:/msys64/msys2_shell.cmd -defterm -here -no-start -mingw64
+    # Replace -ucrt64 by -clangarm64 or -ucrt64 for other environments.
+
+MSYS2 package manager does not offer a built-in way to install build
+dependencies. You can start with this list of packages using pacman:
+
+Note: Dependencies need to be installed again if you use a different MSYS2
+environment.
+
+::
+
+    # update MSYS2 itself, you need to reopen your shell at the end.
+    pacman -Syu
+    pacman -S \
+        base-devel binutils bison diffutils flex git grep make sed \
+        ${MINGW_PACKAGE_PREFIX}-toolchain \
+        ${MINGW_PACKAGE_PREFIX}-glib2 \
+        ${MINGW_PACKAGE_PREFIX}-gtk3 \
+        ${MINGW_PACKAGE_PREFIX}-libnfs \
+        ${MINGW_PACKAGE_PREFIX}-libssh \
+        ${MINGW_PACKAGE_PREFIX}-ninja \
+        ${MINGW_PACKAGE_PREFIX}-pixman \
+        ${MINGW_PACKAGE_PREFIX}-pkgconf \
+        ${MINGW_PACKAGE_PREFIX}-python \
+        ${MINGW_PACKAGE_PREFIX}-SDL2 \
+        ${MINGW_PACKAGE_PREFIX}-zstd
+
+If you want to install all dependencies, it's possible to use recipe used to
+build QEMU in MSYS2 itself.
+
+::
+
+    pacman -S wget
+    wget https://raw.githubusercontent.com/msys2/MINGW-packages/refs/heads/master/mingw-w64-qemu/PKGBUILD
+    # Some packages may be missing for your environment, installation will still
+    # be done though.
+    makepkg -s PKGBUILD || true
+
+Build on windows-aarch64
+++++++++++++++++++++++++
+
+When trying to cross compile meson for x86_64 using UCRT64 or MINGW64 env,
+configure will run into an error because the cpu detected is not correct.
+
+Meson detects x86_64 processes emulated, so you need to manually set the cpu,
+and force a cross compilation (with empty prefix).
+
+::
+
+    ./configure --cpu=x86_64 --cross-prefix=
+
diff --git a/docs/devel/index-build.rst b/docs/devel/index-build.rst
index 0023953be3..0745c81a26 100644
--- a/docs/devel/index-build.rst
+++ b/docs/devel/index-build.rst
@@ -8,6 +8,7 @@ some of the basics if you are adding new files and targets to the build.
    :maxdepth: 3
 
    build-system
+   build-environment
    kconfig
    docs
    qapi-code-gen
-- 
2.39.5


