Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCF4E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEzU-0000HK-Bd; Fri, 10 Jan 2025 08:23:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEz6-0008MY-8H
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:32 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEz4-0005dc-7g
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:31 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3862ca8e0bbso1619798f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515408; x=1737120208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yv0P0wrEbC6sAp6kQa5O/Cjc+4V7VV+VslM7BVlUX/0=;
 b=IV1Zd7prAiSYr5SbyHpfkUkUFyU/2g2bKmpNXUZthhKikZKP2BXUiKcIHZ2lxT9tFY
 7STn7HLu2nGO6dnWqWtlaejscBb4iq5GfyLx7Bzt7swj3Ga+IwLU+xuoExKiSq9l+/C2
 UnKR8edeqKlownKCNEwRvkwWqD4Mo6MhFcKDRf2D9pkb9Rdw+gfonI+brCsrif4gX45p
 naO6gMfzdvV8jd7Q/9s+eA6DtJg5hlqRIkxOqZTAgG2fY73BcPqCBM07OHRk1nuoioSV
 Z3U9cW4yxRpZxjWiBT1vLLbna5l7Z+Hv+7ft4IjgFavFiXpgk+F/5QOGlgd9CktMPUOu
 I3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515408; x=1737120208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yv0P0wrEbC6sAp6kQa5O/Cjc+4V7VV+VslM7BVlUX/0=;
 b=Suijrl+zw3ZQmoyGny0AepxEClp9SD/WTI3nbmhRArFY1KDP+vBuV57gZIdYOSI2dq
 twFkJn7zIZXodDJe7uIJqnlnEv3Sjiwxx26THsA49jkwqUfj45IxG9e5/BKT8/pkdzc4
 zhJlJyWALQlowrHr+EFfHeHCwrqadB4aNebGi+2d+JqsaSiHe8p7V0udTdhlWXhcfvPw
 dEH8mYZXU0Ud/PoWn0G5yknp47QqlOl+Y+Bnl4V+AAOlhod4+yt8EAmYBldTpgq9UfuL
 u87OGiGvtimc3vN83C7yjBRTQ+y6EsdSxMHqof+2W7OH6y8YIYQ57EfAFpO1NASr18bQ
 YiVg==
X-Gm-Message-State: AOJu0Yydy3Z1WQ0k9LT/lVUVRmAlYOWkFxc5pZAPV1r12v0oqBUZxGF2
 t2ifAjD5cciROERuPLgxNqzUvB4sA4ZbUcgYflOt32hHyyd7r71yYlbJw4EUPyQ=
X-Gm-Gg: ASbGncvuokjIKzhbCxqGzCt6nhGGX6NvO+Twb9dSAaku85TefKgqZGpQko6AFgxXnjw
 pJFFC8f4ZQbRbUnHIybXiby7eW7UYxaUNirNIyxeSIoxjDZNS1tCxGmKYchM2oqSwnQhiDv50HW
 3DEqOo9cEBLfm0MY9NF4j07D5FY2QBUIE3bAPij3iZYiK6wj1mNi1huwYDzP5cajfiRox9INmDv
 fb7QuxlHRWQHSGiglPZh9h3uu2O9gziE7GHr26XQjBSJI2w5cDTIY8=
X-Google-Smtp-Source: AGHT+IFgmhBwDCwhP3HZMzOkqHqee7c/TL6XRKJs4/C+isMEPox2p/jMlRL5aS4OPqu/1jfnY0UIlg==
X-Received: by 2002:a05:6000:4618:b0:385:f560:7916 with SMTP id
 ffacd0b85a97d-38a8732aeefmr11025274f8f.35.1736515408424; 
 Fri, 10 Jan 2025 05:23:28 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c912f165sm165890666b.83.2025.01.10.05.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:23:26 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6C07B617A2;
 Fri, 10 Jan 2025 13:17:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/32] tests/lcitool: remove temp workaround for debian mips64el
Date: Fri, 10 Jan 2025 13:17:48 +0000
Message-Id: <20250110131754.2769814-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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
Message-Id: <20250108121054.1126164-27-alex.bennee@linaro.org>

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


