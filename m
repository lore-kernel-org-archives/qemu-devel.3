Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DC5109879F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3c8D-0007b5-2o; Fri, 20 Mar 2026 11:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3c85-0007YY-K7
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:51:20 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3c83-0005Wm-57
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:51:17 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b9358dd7f79so128675466b.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 08:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774021873; x=1774626673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vtp616pn0VVl4bYnzt5PwIs8bsU7tc9ZvPQ6p1AmMyI=;
 b=B+kOAUQQs53AajIgcTyUamIoE7nxbEWFarGskZSgxS8I6YT7++yw4OZRSVzrsl+IEK
 eamx3q9PzfKbuqlfBUWrOXA4FWEiY7fSllYPfZMXcKoFL3Npr79WI9gZyzr7kLCb/P/T
 v0PPcBnuemnozTnSkdwfjtXqiFDYDeGvN3kET9pnkRYmFV2rXakqOcM5m16vKaPMXeHL
 vIhCOvMAoCq2jVXK6Z5za5MZCG09WfXtyjaTxMKbwJ6aHL3upl2z5om2q4JvdFbjQwTr
 6dZPNLaOc4FXvPTwKS1zuV0OQv80BloLA4gx4rxU8eyuHZx7coaqKiMk2yCGsBaMHXAy
 U7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774021873; x=1774626673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vtp616pn0VVl4bYnzt5PwIs8bsU7tc9ZvPQ6p1AmMyI=;
 b=NfbF8bjByM/55ODnCCrkyYwFwXcdb4W/086GTOZt0zH+g5FL60KTyu5DhbZhVqyD56
 tz+xRBgdRQZUM3dADsxbqPuR5nheRf9aEw/LhyXmpjTxCV+PT0PlM2lkika8r2f/KzlX
 z7BOi0Fz7I8opUg/i++PJVc7FOE2uweVLCnJEykb3pmrGqrfr5AZfizsbArbcpHHGZuH
 0CZx5pIkx1tU/8o+v420LH9/YHqpUuvJbdmBKsuB2UHyQ5BG4zzAzbxU4ar5MZu6emOY
 y9dEiAuQa67Bn5sX5atzK35QFnTk1DHdLJ8lNEUtwm3KoTVX+Gdwst4wm9ENmMOiYZnL
 hdaA==
X-Gm-Message-State: AOJu0Yy6qBB4BVI36ZmBSRBqSGC8NEwT4Atpy162VMKSIDRNwuWdUa/k
 Ho2+KxtCpqCLqBwZIPrjV719XrHctfVtHaCXjiWmFvIbpaez2YvR0X5jt9uo3KqQFtM=
X-Gm-Gg: ATEYQzw5iP/xZRg/pu6J0tFGba+01VOSWLeC2kCUSENfVUfuEuRvYnm3el8qX5cgzWZ
 qYfgBTUJSQNiCExDmomZLfN8fy7JYXpnfRxvarKCa+4YVTrYUl4EZhVZXPSMV4kdPiO21axdUL8
 ivlq31y5+q4JCa+TPTsLK5GImKXccmV/PpcE0GmeiJBXRYm2Ll1CGHBGYcbTAyFs9UB6On/6GYD
 kDyYAZYqnzNNFyJRaF08PZJtKfLgHVVfPsmr/VWA0vpOjuN4EDRVbZDU3acJaluIgK4OPl7dPqh
 mAir5ks0xSypyt5i8hZHgwhcH4APacMHhXa3DW75b76xSOCVSY1O4mT3r7HrMrAZ2IS0zHdtc4n
 Pi/28WpE6kxwKEUWhFSW2k7vuaaBbUS7gzBExEpEA42mH5Rl8bT5whfaOe89aGQd3J7GRDGfRfc
 zATMW0VyscLfPteJ1xaQWoumA=
X-Received: by 2002:a17:906:cc8d:b0:b97:a422:b435 with SMTP id
 a640c23a62f3a-b982f3a5e4fmr185042066b.40.1774021873425; 
 Fri, 20 Mar 2026 08:51:13 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b983387084asm169057066b.53.2026.03.20.08.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 08:51:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6F9175F943;
 Fri, 20 Mar 2026 15:51:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, qemu-arm@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Brad Smith <brad@comstyle.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 7/8] tests/docker: Update the opensuse-leap container file
 to version 16
Date: Fri, 20 Mar 2026 15:51:06 +0000
Message-ID: <20260320155107.2143191-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320155107.2143191-1-alex.bennee@linaro.org>
References: <20260320155107.2143191-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/dockerfiles/opensuse-leap.docker | 35 +++++++++----------
 1 file changed, 17 insertions(+), 18 deletions(-)

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


