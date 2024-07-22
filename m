Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F18C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVqq5-0005Uc-Qy; Mon, 22 Jul 2024 07:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqq4-0005T6-0G
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:20 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqq2-0002RB-48
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:19 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5a15692b6f6so3395112a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721646256; x=1722251056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1UxZeJVXfh506tEb3223GmpHqSZOGPy9dFtloKHCAl0=;
 b=DmUZzPMYBUaXr++d7/FNchIF+2GzAONswbftFjgg2nJtyMwKspeCaVipPxBK2LbTPD
 8KSNsvcWHqoPPuLHyW37aq7UCiTezGpu+vMnc2wuvQs1jovzeysAxi53NY52Ty/thhX7
 gm8llfSQD0t5y0Dqy2ODrBfsF5ryNyKwdcaCvrYhb4MZDZM5XTLq6QJCPfLF4DYd5KaG
 f8ntZUbPNvf4fcDMmPADSagdd5obrp/hqmOpkdIr+jA3Yn94CxtuPrQ1MP3/5ni241iS
 9m4dV3ZmDCbnrYky0jy481ZbQ1i4FLA2r2g5M+aah3CmkogUoXbpngem7KRYAKDksplN
 xH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721646256; x=1722251056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1UxZeJVXfh506tEb3223GmpHqSZOGPy9dFtloKHCAl0=;
 b=mu2UYkuojyvdy+NmEkZpDEe95sbnFHcuKmiszhlMF8jmOn9IVI1HHmTTTTdY+JN1uS
 rN5AvywOx4emm8LRCehIgxTVVvP6g2iEODYjVyHzUO47mxnFaxe/7EqMw599LD3Wm5fy
 bg+hVYRCdJDaLEX9FTU2UoMLzdOsyk54wVhM6iurJxVNjPauEpOJw6fCIVlDeK8R/3K0
 Dbfj/fjLtC0/jUTxudzEjTihsRs5pL5O6Q9QYpiHi/Mq/p8d1m5iQ4kP1c/v67LuKY95
 +z3Lr+6hRBGGUS/kEWR0koUe+r0/EbHZYldDom7ey7fHC96E/k9/zVnhGANtQk4FIanI
 duOA==
X-Gm-Message-State: AOJu0Yxw/c+W7SU5a1QKQDfTTesnRnoWqD0G76A+EjN7WDLSutSdNhuU
 RR5w7DPInCirOwpvA4c2GoQPk6WlgN/zjQzhbERpfBJDvTQLNZ1C/QLAA0u+cqk=
X-Google-Smtp-Source: AGHT+IHM2nvW7nHuvQE2tzGuvgDxxAdwRrtEqsHSlgPTepHdvcKBBbYQzAtfFWLT2vODC8K/iHo5pQ==
X-Received: by 2002:a17:907:940e:b0:a72:6b08:ab24 with SMTP id
 a640c23a62f3a-a7a4bfa3dcdmr451066366b.14.1721646255614; 
 Mon, 22 Jul 2024 04:04:15 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c95088fsm406324566b.212.2024.07.22.04.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 04:04:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A57DC5F8FC;
 Mon, 22 Jul 2024 12:04:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 01/16] testing: bump to latest libvirt-ci
Date: Mon, 22 Jul 2024 12:03:58 +0100
Message-Id: <20240722110413.118418-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722110413.118418-1-alex.bennee@linaro.org>
References: <20240722110413.118418-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

This brings in the latest python mappings for the BSD updates.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240718094523.1198645-2-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/cirrus/freebsd-13.vars b/.gitlab-ci.d/cirrus/freebsd-13.vars
index 3785afca36..29ab9645f9 100644
--- a/.gitlab-ci.d/cirrus/freebsd-13.vars
+++ b/.gitlab-ci.d/cirrus/freebsd-13.vars
@@ -11,6 +11,6 @@ MAKE='/usr/local/bin/gmake'
 NINJA='/usr/local/bin/ninja'
 PACKAGING_COMMAND='pkg'
 PIP3='/usr/local/bin/pip-3.8'
-PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache cmocka ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py39-numpy py39-pillow py39-pip py39-sphinx py39-sphinx_rtd_theme py39-tomli py39-yaml python3 rpm2cpio sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 xorriso zstd'
+PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache cmocka ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py311-numpy py311-pillow py311-pip py311-sphinx py311-sphinx_rtd_theme py311-tomli py311-yaml python3 rpm2cpio sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 xorriso zstd'
 PYPI_PKGS=''
 PYTHON='/usr/local/bin/python3'
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index 0e9490cebc..789b4601bc 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 0e9490cebc726ef772b6c9e27dac32e7ae99f9b2
+Subproject commit 789b4601bce4e01f43fdb6ad4ce5ab4e46674440
diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/freebsd.json
index 2d5895ebed..2a361cecd0 100644
--- a/tests/vm/generated/freebsd.json
+++ b/tests/vm/generated/freebsd.json
@@ -51,13 +51,13 @@
     "pixman",
     "pkgconf",
     "png",
-    "py39-numpy",
-    "py39-pillow",
-    "py39-pip",
-    "py39-sphinx",
-    "py39-sphinx_rtd_theme",
-    "py39-tomli",
-    "py39-yaml",
+    "py311-numpy",
+    "py311-pillow",
+    "py311-pip",
+    "py311-sphinx",
+    "py311-sphinx_rtd_theme",
+    "py311-tomli",
+    "py311-yaml",
     "python3",
     "rpm2cpio",
     "sdl2",
-- 
2.39.2


