Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75974E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 12:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVV5L-0001OJ-Ei; Wed, 08 Jan 2025 07:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVV0s-00020h-3m
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:18:23 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVV0g-0002Ry-RK
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 07:18:14 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso120610485e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 04:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736338685; x=1736943485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6UOxR9mHFC4u/8ZQKvQLQtYEWlgMJY9tIWZpiZZUDDA=;
 b=PuMZJ6hpLUwpmhu/uVcgNtnNfCPxCTIOcBjTXPzk6Fb+EPnCj76tQ0m7SYXqLxlDWb
 fIEB6xhabm8PaFFZhsFrNiW1vjzXG7qnDzVPkyK0eGHz+panyCR3C8aAXqzLmT/5qPRE
 EfA2jVvsugCOM/jbpm5dOZqRGBwYdpFVS5GN26Os64HFXn0hu9mgSnCpVu5Se8/IrlyY
 Vjm6+rh28LVFYU83j+d+DPIaeQDztjpp6GIw2SmN9/5d0SX4rh4dtbQsBZfew3PfwLUp
 c2SMpAwfyLgS48bCdCtuzb+B8ol4zB6HdaJgpgjeA745SaMKp5dh7HjLn2aeSBM8Gu+x
 NaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736338685; x=1736943485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6UOxR9mHFC4u/8ZQKvQLQtYEWlgMJY9tIWZpiZZUDDA=;
 b=DSlCh99L8IJboDN/3pYsJa3fAGqbUcpqhqC8mRJ4knx91touQ0ZN+yiyGHYIk6+qiS
 hEBgQ8lP3jVnZNZW7u/moVemfeL3v3cbaefNZ4rCHJXiWDDZbtWN7Ce23qulWsv5hznC
 Nn1hZe+7qU+lvn5MJwe4eoCQKFB1w8mbiP68M604A/OSUb8+2/OIZLwguaxOtzrvxZXG
 GBvLlSBAW3UP03dXUrjnVbbOExl5akx2XBwZtts/9tzOrnNbFcv81T+aBICcExqi+cLf
 PTIaw32xtCpVN3aKgq72gfGPv8qoQjUaer3zFwyRN65RlePR9g0n47w+nFFw8uxKldgY
 34ug==
X-Gm-Message-State: AOJu0YxIjGDGHVo+L9Yd32mjAIYOg6Q6MJ7o7HkOqXxwV5sMvw3VJz2p
 9UnGieX6DyILD6+ioayzFiqx3OTruixRRHs6IXLnV6cpx8ol8r68t850+U2M7e4=
X-Gm-Gg: ASbGncvh8tVk25E9mRdxYwWXlyMeYnKS3rpJDRsqFy6Ojc2fnGVj1vVI9L/dJH/Xc0+
 vN6AOgaVzsziQ0SYtSc1mGOvfjDBwxR7tftzkCFYYG3ICd61+cqP1AyQBuNIxOUTNwoVbQaqJbU
 7sVwbBUxPAT2tbRMA13kFLDxd068OVlU+JhFLtDd8SliH/W5WzUCjm6zQxhYhauQjYvJLe87ySm
 K3fyhT993X+h3PcwKltWvBflzRCXxx84UDkV6glVUBifnzIYFRPufE=
X-Google-Smtp-Source: AGHT+IGBl5HY0BvqGcsvaAvLVU7eaOYfih3Are+F+GhLUJfwjh4ETIDnTuMBN+lNnaq4mJQZWrFlBA==
X-Received: by 2002:a05:600c:5486:b0:434:f131:1e64 with SMTP id
 5b1f17b1804b1-436e2696d1fmr21053675e9.9.1736338685136; 
 Wed, 08 Jan 2025 04:18:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c847d7fsm52703371f8f.60.2025.01.08.04.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 04:18:02 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 226965FD97;
 Wed,  8 Jan 2025 12:10:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-riscv@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>
Subject: [PATCH v4 26/32] tests/lcitool: remove temp workaround for debian
 mips64el
Date: Wed,  8 Jan 2025 12:10:48 +0000
Message-Id: <20250108121054.1126164-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250108121054.1126164-1-alex.bennee@linaro.org>
References: <20250108121054.1126164-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The workaround applied in

  commit c60473d29254b79d9437eface8b342e84663ba66
  Author: Alex Bennée <alex.bennee@linaro.org>
  Date:   Wed Oct 2 10:03:33 2024 +0200

    testing: bump mips64el cross to bookworm and fix package list

Is no longer required since the affected builds are now fixed.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20241217133525.3836570-1-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .../dockerfiles/debian-mips64el-cross.docker  |  9 ++++++
 tests/lcitool/mappings.yml                    | 29 -------------------
 2 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index c09a8da890..9f6c4763c5 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -93,13 +93,18 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcmocka-dev:mips64el \
                       libcurl4-gnutls-dev:mips64el \
                       libdaxctl-dev:mips64el \
+                      libdrm-dev:mips64el \
+                      libepoxy-dev:mips64el \
                       libfdt-dev:mips64el \
                       libffi-dev:mips64el \
                       libfuse3-dev:mips64el \
+                      libgbm-dev:mips64el \
                       libgcrypt20-dev:mips64el \
                       libglib2.0-dev:mips64el \
                       libglusterfs-dev:mips64el \
                       libgnutls28-dev:mips64el \
+                      libgtk-3-dev:mips64el \
+                      libgtk-vnc-2.0-dev:mips64el \
                       libibverbs-dev:mips64el \
                       libiscsi-dev:mips64el \
                       libjemalloc-dev:mips64el \
@@ -119,6 +124,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       librbd-dev:mips64el \
                       librdmacm-dev:mips64el \
                       libsasl2-dev:mips64el \
+                      libsdl2-dev:mips64el \
+                      libsdl2-image-dev:mips64el \
                       libseccomp-dev:mips64el \
                       libselinux1-dev:mips64el \
                       libslirp-dev:mips64el \
@@ -134,6 +141,8 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libusb-1.0-0-dev:mips64el \
                       libusbredirhost-dev:mips64el \
                       libvdeplug-dev:mips64el \
+                      libvirglrenderer-dev:mips64el \
+                      libvte-2.91-dev:mips64el \
                       libxdp-dev:mips64el \
                       libzstd-dev:mips64el \
                       nettle-dev:mips64el \
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index f8186b0e69..74eb13d62b 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -6,23 +6,6 @@ mappings:
   flake8:
     OpenSUSELeap15:
 
-  # Due to https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1081535 we
-  # have to disable all packages that depend on libgl1-mesa-dri:mips64el
-  gtk3:
-    mips64el-deb:
-
-  libdrm:
-    mips64el-deb:
-
-  libepoxy:
-    mips64el-deb:
-
-  gtk-vnc:
-    mips64el-deb:
-
-  mesa-libgbm:
-    mips64el-deb:
-
   meson:
     OpenSUSELeap15:
 
@@ -81,18 +64,6 @@ mappings:
   python3-wheel:
     OpenSUSELeap15: python311-pip
 
-  sdl2:
-    mips64el-deb:
-
-  sdl2-image:
-    mips64el-deb:
-
-  virglrenderer:
-    mips64el-deb:
-
-  vte:
-    mips64el-deb:
-
 pypi_mappings:
   # Request more recent version
   meson:
-- 
2.39.5


