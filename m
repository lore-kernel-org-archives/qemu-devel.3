Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1CFF4613D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 15:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4heo-0005di-OV; Mon, 23 Mar 2026 11:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w4he5-0005Es-7P
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:56:50 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w4he2-0007tl-VG
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:56:48 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-661d20c9787so467129a12.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 08:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774281405; x=1774886205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=43Q6+kzhBrTb5bx6FeAKwYn/Gs9dWMYzJ9+hPGcPf+k=;
 b=K2NyxfBzi0wY3aPY4aLa+zdeC+uNeRgI/RjHqoiyZG6OH7VAmSCqptXfZQ5Zz0h7JK
 RfuMHSmXQWgvLy3FX92ioYvWJ0qCWGd/hjgWZJmL7H8IUE7yuwnH/euOT32d4tXT0v2R
 aufc8wBYMqMKECgjL/Ft2vGNfjeXT3J8i69/nZ+oyAJzdSZAKFemFHV8gF4b57T3M6dq
 rwn2yBSvzAH96hjme09R5w45OziOFQvNyLrMsIy9kJzCSFna4zMKCl1H690w71wCbfVM
 WA96C/Nr4I1O3OqCuGlTqa1g/JgROAqpNSOepBMQkoTz0UdOuwBcr2Ur2uEym58IMLm2
 G84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774281405; x=1774886205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=43Q6+kzhBrTb5bx6FeAKwYn/Gs9dWMYzJ9+hPGcPf+k=;
 b=IKnClX77Zp5sRh5t1VXVlECrD/eISdamz5LngWZlqC2OjE7DVTMm+3TgeMDCGqODUG
 7tqY2XedLF63haIT0uJEXIq9UtRJdlK8kWBtFIqFnNLJNYD16nhSpx8VO0/9xpqGHl63
 PtXu+z+fyCPNtCiFc69jhOdkEIqY6msN1ma2T4oM92y53Y+HUlTru6kIODo1ydYaIH+x
 1yTsTN/BqCE3tM+fmbvBmkLNnF90TJCfRERYEqXfDCGYuqasCalajCHodTXHRob9ZNeF
 /KyX9PRKQlE8V8smzOW9GGrLEH0aKSzCLkrNOHk8zAoZaJmFC7ywF3KALzjmqUYo9x7e
 dR7Q==
X-Gm-Message-State: AOJu0YyKhYSxjq0WaLSNuc+xbf/BwIv9bfwweFyde2gZgVrXOzKz/M6z
 GVN5YMVYfA3Op/64PNfmqVFCrbt2CT8h8JuXSchJPvsLsY0cCASR3Fco7oZWq3lZGYU=
X-Gm-Gg: ATEYQzxamvkcA7yVZ6xpUaC503PyB+rLaEe1IYKwoO2Lfvk6Ytz68Z7UrU/9Tx0esW7
 V8jur3c6LMMWo+hu/SKiwlqUZppti+CoiMhOy8usITLetNP1kw+CNOTDYoaM8VXtaHMrb9VuPTC
 K1gcZziDBmk6yaqdpVpvfQB8xX0OoWgr71Qn/d56Fg4GA7l/jR3prBjxV9mhKRdRbw/snfTTxnD
 9k1s/cKxGh+Z5O1S+bSc3CXGIPAMM5ofp5Pi/ZHG9BUDQoeJ3Tl5BX3k+61Rks5FTXDcPBXWdQH
 9rEFQvv2EcIxe49zmpIj6H1d0XtVBMFW+9ffyYR/GcyV1+rn6kZi4kE71pFsoYeqCdNB8C0vfR5
 Xe+4SYgm2S6gJRPg6QplLtlnWpnFv+frui2jPcaduMu+vQkz5phuFNP6pdrvUeQUs/inaqkMByz
 Zhf3oxgD+OzDFwLefcOqeEPhddxz3NFInjRA==
X-Received: by 2002:a05:6402:158d:b0:668:502d:80b6 with SMTP id
 4fb4d7f45d1cf-668c9928d2emr8305443a12.26.1774281405205; 
 Mon, 23 Mar 2026 08:56:45 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-668cf4f89fesm3900200a12.4.2026.03.23.08.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 08:56:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 75FAF5F8EB;
 Mon, 23 Mar 2026 15:56:38 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 7/8] tests/docker: Update the opensuse-leap container file to
 version 16
Date: Mon, 23 Mar 2026 15:56:36 +0000
Message-ID: <20260323155637.145015-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323155637.145015-1-alex.bennee@linaro.org>
References: <20260323155637.145015-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

Run "make lcitool-refresh" to update the container file to the latest
version of openSUSE.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20260316135407.209072-4-thuth@redhat.com>
Message-ID: <20260320155107.2143191-8-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index d693f2c6f85..66e90fa3634 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -1,13 +1,12 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all opensuse-leap-15 qemu
+#  $ lcitool dockerfile --layers all opensuse-leap-16 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM registry.opensuse.org/opensuse/leap:15.6
+FROM registry.opensuse.org/opensuse/leap:16.0
 
 RUN zypper update -y && \
-    zypper addrepo -fc https://download.opensuse.org/update/leap/15.6/backports/openSUSE:Backports:SLE-15-SP6:Update.repo && \
     zypper install -y \
            Mesa-devel \
            alsa-lib-devel \
@@ -80,13 +79,14 @@ RUN zypper update -y && \
            libudev-devel \
            liburing-devel \
            libusb-1_0-devel \
+           libxdp-devel \
            libzstd-devel \
            llvm \
            lttng-ust-devel \
            lzo-devel \
            make \
+           meson \
            mtools \
-           ncat \
            ncurses-devel \
            ninja \
            openssh \
@@ -94,11 +94,17 @@ RUN zypper update -y && \
            pcre2-devel-static \
            pipewire-devel \
            pkgconfig \
-           python311 \
-           python311-base \
-           python311-pip \
-           python311-setuptools \
-           python311-wheel \
+           python3-Pillow \
+           python3-PyYAML \
+           python3-Sphinx \
+           python3-base \
+           python3-numpy \
+           python3-opencv \
+           python3-pip \
+           python3-setuptools \
+           python3-sphinx_rtd_theme \
+           python3-tomli \
+           python3-wheel \
            rdma-core-devel \
            rust \
            rust-bindgen \
@@ -110,7 +116,7 @@ RUN zypper update -y && \
            spice-protocol-devel \
            swtpm \
            systemd-devel \
-           systemtap-sdt-devel \
+           systemtap-dtrace \
            tar \
            tesseract-ocr \
            tesseract-ocr-traineddata-english \
@@ -133,18 +139,11 @@ RUN zypper update -y && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
-RUN /usr/bin/pip3.11 install \
-                     PyYAML \
-                     meson==1.8.1 \
-                     pillow \
-                     sphinx \
-                     sphinx-rtd-theme
-
 ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
 ENV LANG="en_US.UTF-8"
 ENV MAKE="/usr/bin/make"
 ENV NINJA="/usr/bin/ninja"
-ENV PYTHON="/usr/bin/python3.11"
+ENV PYTHON="/usr/bin/python3"
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
-- 
2.47.3


