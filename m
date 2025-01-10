Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC0AE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEu4-0004ny-Ix; Fri, 10 Jan 2025 08:18:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtt-0004h9-VJ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:10 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEts-0004l3-09
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:09 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385f07cd1a4so1562060f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515086; x=1737119886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wEhsigK84EEHi4oVXQ53fs8YC0MI1AY3akn0PMxaBwY=;
 b=VO7Sb+uKQ2jWoah16YoJVLnJQnmvoW4PSokBn8EK5yBq8eERf7rUTOOZBe9z2T9GOq
 4otQp3KgQQQgWtjNzaqRplMm68D8yMbfvq9BMn9e1WON/xCzbfDQyxqAlxxb2+tSI3dl
 nHF2wndMGGEWQfoTHerScOIia17afmcuODInW63DV+C4KyP6W1RgyeeqqhWcuB4KtnSM
 aO8Lp+ibv4kzmBm/1pQNbybKLzgRCcrbdXMY657uvcOoDSZDdZp7NyzF+ml1e9QLNIbC
 oOCNw1aewISsuKLj/hvL24KSmsO7oXrAaAIOujco9yjL/t0AozlapZPlAJqAbDfcI0lf
 5SMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515086; x=1737119886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wEhsigK84EEHi4oVXQ53fs8YC0MI1AY3akn0PMxaBwY=;
 b=apGXBg6j1vCeclLqcUF8/x1+0YOdBW50sVgnJq0irVd1+zjli8unqhL4mpc1o6Krl5
 QM3htEMiQX4Ky2VK2R5ggV56ZsSe54DV6KnVK5KvG1A2DolSbYZmOdUo0s2IXycEKCmS
 ark8RfifOpP4zG3I6IfUxEb9BSDE2vtqAjZvWAIpfSCdLGkB516xjbc8YGrOTezeiuG2
 Iqrl7RuKLSwhbaP/x9XeNPhENudnCPgxfHK4WqUdB+2ObuUd8bZGMfGy9uSUd6+fKg7/
 3tKSQEA2u6IgjRXABDXXs17f1E0tiRhit1VtiokDGuXhmSlqOzIsplzKAuSgjxPsMXBK
 MZiA==
X-Gm-Message-State: AOJu0YwqlqMSj+Ht1grFqm/4W1qVPUXPzmPqbi4pwbLj54Q2rR0oMpGP
 RimFCGUCXayyFrHKTu4sxeDQXKDM4MJojkHS/7YJOYR99ohToCGBxKruM7z23Ow=
X-Gm-Gg: ASbGncvXYLnDh+/fA5+xlg2wlX8dDQxadGJMBunJ2K4Bpj0hgJeMGcXi+tzXWDyHi3e
 kEjZaRBsiJIGAZBCnePEhtANlPuhT3dAPglCAMBOoC9thSNnhrB8RQzTV2hbC5x+/lJQBAm446L
 qJYIIylFFIgzUtKj/v6P4bev3u/9FD7EjS6BKOz+gZQfTHIRU+uW/YJ/JANzs9T7aYg8UzC4GJ0
 IonApdftYynrBMtznv/21How5suuUsh+emmo35CuxdsZTadEVGoqD8=
X-Google-Smtp-Source: AGHT+IHhBycDYElDSzHmgmUqQNArsFU1/+3/ne6CiO3PvvAplGQfGps9rr8cEDcGXdS+xCxzzCkdhw==
X-Received: by 2002:a5d:47c3:0:b0:386:3329:6a04 with SMTP id
 ffacd0b85a97d-38a8732c076mr10368036f8f.39.1736515086382; 
 Fri, 10 Jan 2025 05:18:06 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b81e4sm4593762f8f.64.2025.01.10.05.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:18:02 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3DF5561774;
 Fri, 10 Jan 2025 13:17:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 24/32] tests/lcitool: bump to latest version of libvirt-ci
Date: Fri, 10 Jan 2025 13:17:46 +0000
Message-Id: <20250110131754.2769814-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

We will shortly need this to build our riscv64 cross container.
However to keep the delta down just do the bump first. As ccache4 is
now preferred for FreeBSD to get the latest version there is a little
update in the FreeBSD metadata.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-25-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/cirrus/freebsd-14.vars b/.gitlab-ci.d/cirrus/freebsd-14.vars
index 0a7ac5e0e1..0997c47af5 100644
--- a/.gitlab-ci.d/cirrus/freebsd-14.vars
+++ b/.gitlab-ci.d/cirrus/freebsd-14.vars
@@ -11,6 +11,6 @@ MAKE='/usr/local/bin/gmake'
 NINJA='/usr/local/bin/ninja'
 PACKAGING_COMMAND='pkg'
 PIP3='/usr/local/bin/pip'
-PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache cmocka ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk-vnc gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py311-numpy py311-pillow py311-pip py311-pyyaml py311-sphinx py311-sphinx_rtd_theme py311-tomli python3 rpm2cpio rust rust-bindgen-cli sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 xorriso zstd'
+PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache4 cmocka ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk-vnc gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py311-numpy py311-pillow py311-pip py311-pyyaml py311-sphinx py311-sphinx_rtd_theme py311-tomli python3 rpm2cpio rust rust-bindgen-cli sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 xorriso zstd'
 PYPI_PKGS=''
 PYTHON='/usr/local/bin/python3'
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index 9ad3f70bde..b6a65806bc 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 9ad3f70bde9865d5ad18f36d256d472e72b5cbf3
+Subproject commit b6a65806bc9b2b56985f5e97c936b77c7e7a99fc
diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/freebsd.json
index 3cb7fb7060..81fc38d798 100644
--- a/tests/vm/generated/freebsd.json
+++ b/tests/vm/generated/freebsd.json
@@ -13,7 +13,7 @@
     "bzip2",
     "ca_root_nss",
     "capstone4",
-    "ccache",
+    "ccache4",
     "cmocka",
     "ctags",
     "curl",
-- 
2.39.5


