Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4700FC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxcl-00010w-O7; Mon, 17 Aug 2026 09:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvxck-000100-Be
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvxci-0001EI-1J
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786974211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p8GqaEFaMPo1l6ldVuP9CeBTLgFWapcQlvcyQk2bPv0=;
 b=J8E2OG+GkaVzEcYqWgVZwWs7v583CA5kDSGu2A9zyVlH7E4VGtqIVvjpwXbX/ZMX5D+kgJ
 7rpeJ0poJcKeFFgyOB86gd2KPIg1krLFQffzcsQQPo+xkatGZK4SIt1X612jKyYrPYsEp0
 /agHr6/o6WKYPYrlo5Cnth/Y9NZb6go=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-IR1xRGyLPWS-3T2IkPb4gQ-1; Mon, 17 Aug 2026 09:43:24 -0400
X-MC-Unique: IR1xRGyLPWS-3T2IkPb4gQ-1
X-Mimecast-MFC-AGG-ID: IR1xRGyLPWS-3T2IkPb4gQ_1786974204
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47eaa4006a1so1370633f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 06:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786974203; x=1787579003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p8GqaEFaMPo1l6ldVuP9CeBTLgFWapcQlvcyQk2bPv0=;
 b=Ye0PSuGoLWUUcKWvL0k7oNb6D1LA06xe5dz0u63IjNk6S2yb+eh3Ha6CK+zJW38Su2
 jUMCplG8oQaDyqSeUbMSgTZLG+el2BD2Ma4eoxn9ofaWcrZYF18yWimHdT58Z09F2qI5
 yl6qKEiL5BSFOnE+NFf96HbMWok+55NyaDqy7/tDdvxIbZlTay+6AKGHsq7o1UJxEgEL
 zF7v9HW5QiMFXIs71EOuzzQsED6cqfoAtudHtt9COi+F6LBDJM7tAqi++dBmlX13Qqgq
 tsQUUeOeDi95IFWBWTiAKg/2n7aHR9jfwhl86kU3zJLyo4ZrD79rdghQrtbQ9nLk5Zxg
 npuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786974203; x=1787579003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p8GqaEFaMPo1l6ldVuP9CeBTLgFWapcQlvcyQk2bPv0=;
 b=cyEzjlLPhOhmsHFmWTm3JVqUkSZDWl1QZP4QWjlvjC2Yd7cA7n143OSdVB3iFowtAQ
 XtWydg/UMC/2RrAciU4DNSRQmOitpWVWKTcBu5y2yOWF8jUnnA80FKrOAOAh6z2cHn2k
 D3IsufUbFfJfTsSEkI2UxYJnsD/w6r+mBJ1rcEdyEAR1f9fLp37zrdy+E6uL0zF6Jnsi
 joxjSVWC6p5a9Jr8kTqURf5EDfhKNG/BW+TnrOX9YUhi86IUWowkUN2SGoKSWBARJw/Z
 RlMiPzX80ntEm3X9Ed1zaoKJ7WqclOZ7jJmmLBSEfUtmo3TA3ADroKxy5xJrAyqMeyiV
 rL0Q==
X-Gm-Message-State: AOJu0Yzyb1CHDEUx856GGNhauC/D/BrRNPli5vxXtYGWInYxCRiDQ49N
 6quy3HMlEhj7nt6s4BlRw4aynUFY72un1DS9CsFau18OBykmlow1DviSF0A4qwvGhdTFJPCSbK2
 XOj43WZ/opi1Uo//e9+swaqWpgVSbhAdhbWK2z0yjctvTXbknwr2Af3QyW159n0pPEmYt6XcKl8
 LhNYJOCfQmsHFdTYNEJkOSAoWuWWzZZzJAjyB4GjG9
X-Gm-Gg: AR+sD11r4LUIt6TV5PxGg4JUpcV7MZdk53ywZEJDG63IxpUXEoq+Kp5Y0iWbW27s/Gy
 ueVnB2PEt6PdIjpix0JZe4IUBBSEKJmlgXPq1agQN8iYo2ZOrrOa2Roxh5jmKLCbKglsq3Rtp/2
 RuojTivAEKVkj+CUpcNeLrCCaCyrb5UMGrUxDNVnPFNBwvhwPvB/tGzFMo+AL46t5LJpPPUS57L
 e35833TtCp+SRYtu1/pP+ZBoOqbDMCpAtmbo9vGAGCWrqrclB8jpAj+OWQwnYO/BS38HlyvrDQA
 mZhLDEyyK565NAnnPlSuz0VGw7KYzSNMLEx0UFU/YR/5MIBy9MIS5lGGkCbSWGAG653e3BOuxol
 3nswCOT7J4hFrw2jnStVg219bp8ti4mcEVFknzQr/RXnFJg70KHxMvZv4ygdKEHrlDFDPzTKJHF
 1gBiQ=
X-Received: by 2002:adf:f288:0:b0:47f:f002:3656 with SMTP id
 ffacd0b85a97d-48160797e95mr31341538f8f.12.1786974203472; 
 Mon, 17 Aug 2026 06:43:23 -0700 (PDT)
X-Received: by 2002:adf:f288:0:b0:47f:f002:3656 with SMTP id
 ffacd0b85a97d-48160797e95mr31341448f8f.12.1786974202929; 
 Mon, 17 Aug 2026 06:43:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b896sm4074834f8f.16.2026.08.17.06.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 06:43:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	alex.bennee@linaro.org
Subject: [PATCH 2/3] dockerfiles: remove packages required by Avocado
Date: Mon, 17 Aug 2026 15:43:12 +0200
Message-ID: <20260817134313.922754-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817134313.922754-1-pbonzini@redhat.com>
References: <20260817134313.922754-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Make our CI containers smaller, by removing a handful of packages that
were only included as dependencies of Avocado.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/dockerfiles/alpine.docker               | 3 ---
 tests/docker/dockerfiles/centos9.docker              | 3 ---
 tests/docker/dockerfiles/debian-amd64-cross.docker   | 4 ----
 tests/docker/dockerfiles/debian-arm64-cross.docker   | 4 ----
 tests/docker/dockerfiles/debian-armhf-cross.docker   | 4 ----
 tests/docker/dockerfiles/debian-i686-cross.docker    | 4 ----
 tests/docker/dockerfiles/debian-ppc64el-cross.docker | 4 ----
 tests/docker/dockerfiles/debian-riscv64-cross.docker | 4 ----
 tests/docker/dockerfiles/debian-s390x-cross.docker   | 4 ----
 tests/docker/dockerfiles/debian.docker               | 4 ----
 tests/docker/dockerfiles/fedora-rust-nightly.docker  | 4 ----
 tests/docker/dockerfiles/fedora-win64-cross.docker   | 4 ----
 tests/docker/dockerfiles/fedora.docker               | 4 ----
 tests/docker/dockerfiles/opensuse-leap.docker        | 4 ----
 tests/docker/dockerfiles/ubuntu2404.docker           | 4 ----
 .gitlab-ci.d/macos-14.vars                           | 2 +-
 scripts/ci/setup/debian/debian-13-ppc64le.yaml       | 4 ----
 scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml     | 4 ----
 scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml       | 4 ----
 tests/lcitool/projects/qemu.yml                      | 4 ----
 tests/vm/generated/freebsd.json                      | 4 ----
 21 files changed, 1 insertion(+), 79 deletions(-)

diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index 118c6e8eeaf..8a5a355e89a 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -83,14 +83,11 @@ RUN apk update && \
         pixman-dev \
         pkgconf \
         pulseaudio-dev \
-        py3-numpy \
-        py3-pillow \
         py3-pip \
         py3-setuptools \
         py3-sphinx \
         py3-sphinx_rtd_theme \
         py3-wheel \
-        py3-yaml \
         python3 \
         rpm2cpio \
         rust \
diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index 0d5b5fa7f59..e38cd692db9 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -96,9 +96,6 @@ RUN dnf --quiet distro-sync -y && \
                 pkgconfig \
                 pulseaudio-libs-devel \
                 python3 \
-                python3-PyYAML \
-                python3-numpy \
-                python3-pillow \
                 python3-pip \
                 python3-setuptools \
                 python3-sphinx \
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 061cd8e9b82..823606dc52a 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -41,9 +41,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
@@ -51,7 +48,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-tomli \
                       python3-venv \
                       python3-wheel \
-                      python3-yaml \
                       rpm2cpio \
                       rustc \
                       sed \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 3dfa60fdfd7..ed58e089ec0 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -41,9 +41,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
@@ -51,7 +48,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-tomli \
                       python3-venv \
                       python3-wheel \
-                      python3-yaml \
                       rpm2cpio \
                       rustc \
                       sed \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 401c64269c1..0843f7428a9 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -41,9 +41,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
@@ -51,7 +48,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-tomli \
                       python3-venv \
                       python3-wheel \
-                      python3-yaml \
                       rpm2cpio \
                       rustc \
                       sed \
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index 8b60c7b085f..caba08f842e 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -41,9 +41,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
@@ -51,7 +48,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-tomli \
                       python3-venv \
                       python3-wheel \
-                      python3-yaml \
                       rpm2cpio \
                       rustc \
                       sed \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 2a7e8cba056..17018c0dab7 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -41,9 +41,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
@@ -51,7 +48,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-tomli \
                       python3-venv \
                       python3-wheel \
-                      python3-yaml \
                       rpm2cpio \
                       rustc \
                       sed \
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index 349de3a0bbb..2408d453c20 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -41,9 +41,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
@@ -51,7 +48,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-tomli \
                       python3-venv \
                       python3-wheel \
-                      python3-yaml \
                       rpm2cpio \
                       rustc \
                       sed \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 8bc42b1e00b..2b0a344c2c5 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -41,9 +41,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
@@ -51,7 +48,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-tomli \
                       python3-venv \
                       python3-wheel \
-                      python3-yaml \
                       rpm2cpio \
                       rustc \
                       sed \
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 413986d3f07..064b2ad1f12 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -113,9 +113,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
@@ -123,7 +120,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-tomli \
                       python3-venv \
                       python3-wheel \
-                      python3-yaml \
                       rpm2cpio \
                       rustc \
                       sed \
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index 4f84b803798..dcad3af2a7f 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -104,10 +104,6 @@ exec "$@"\n' > /usr/bin/nosync && \
                        pkgconfig \
                        pulseaudio-libs-devel \
                        python3 \
-                       python3-PyYAML \
-                       python3-numpy \
-                       python3-opencv \
-                       python3-pillow \
                        python3-pip \
                        python3-setuptools \
                        python3-sphinx \
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index c1e63feb46f..bce350dfd8d 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -44,10 +44,6 @@ exec "$@"\n' > /usr/bin/nosync && \
                        ninja-build \
                        openssh-clients \
                        python3 \
-                       python3-PyYAML \
-                       python3-numpy \
-                       python3-opencv \
-                       python3-pillow \
                        python3-pip \
                        python3-setuptools \
                        python3-sphinx \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index a6996917c4b..c541f5d5b18 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -104,10 +104,6 @@ exec "$@"\n' > /usr/bin/nosync && \
                        pkgconfig \
                        pulseaudio-libs-devel \
                        python3 \
-                       python3-PyYAML \
-                       python3-numpy \
-                       python3-opencv \
-                       python3-pillow \
                        python3-pip \
                        python3-setuptools \
                        python3-sphinx \
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index fc363c647cd..8d8631bbcf0 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -93,12 +93,8 @@ RUN zypper update -y && \
            pcre2-devel-static \
            pipewire-devel \
            pkgconfig \
-           python3-Pillow \
-           python3-PyYAML \
            python3-Sphinx \
            python3-base \
-           python3-numpy \
-           python3-opencv \
            python3-pip \
            python3-setuptools \
            python3-sphinx_rtd_theme \
diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/docker/dockerfiles/ubuntu2404.docker
index 27992e34fd9..f027eef022e 100644
--- a/tests/docker/dockerfiles/ubuntu2404.docker
+++ b/tests/docker/dockerfiles/ubuntu2404.docker
@@ -113,9 +113,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
@@ -123,7 +120,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-tomli \
                       python3-venv \
                       python3-wheel \
-                      python3-yaml \
                       rpm2cpio \
                       rustc-1.83 \
                       sed \
diff --git a/.gitlab-ci.d/macos-14.vars b/.gitlab-ci.d/macos-14.vars
index def77cfdea5..0c187624dd0 100644
--- a/.gitlab-ci.d/macos-14.vars
+++ b/.gitlab-ci.d/macos-14.vars
@@ -12,5 +12,5 @@ NINJA='/opt/homebrew/bin/ninja'
 PACKAGING_COMMAND='brew'
 PIP3='/opt/homebrew/bin/pip3'
 PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka coreutils ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libcbor libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python-setuptools python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 vulkan-tools xorriso zlib zstd'
-PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
+PYPI_PKGS='sphinx sphinx-rtd-theme tomli'
 PYTHON='/opt/homebrew/bin/python3'
diff --git a/scripts/ci/setup/debian/debian-13-ppc64le.yaml b/scripts/ci/setup/debian/debian-13-ppc64le.yaml
index e64321357da..9acd99a7433 100644
--- a/scripts/ci/setup/debian/debian-13-ppc64le.yaml
+++ b/scripts/ci/setup/debian/debian-13-ppc64le.yaml
@@ -105,9 +105,6 @@ packages:
   - openssh-client
   - pkgconf
   - python3
-  - python3-numpy
-  - python3-opencv
-  - python3-pillow
   - python3-pip
   - python3-setuptools
   - python3-sphinx
@@ -115,7 +112,6 @@ packages:
   - python3-tomli
   - python3-venv
   - python3-wheel
-  - python3-yaml
   - rpm2cpio
   - rustc
   - sed
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
index 12b0e38a220..5c948109df8 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
@@ -106,9 +106,6 @@ packages:
   - openssh-client
   - pkgconf
   - python3
-  - python3-numpy
-  - python3-opencv
-  - python3-pillow
   - python3-pip
   - python3-setuptools
   - python3-sphinx
@@ -116,7 +113,6 @@ packages:
   - python3-tomli
   - python3-venv
   - python3-wheel
-  - python3-yaml
   - rpm2cpio
   - rustc-1.83
   - sed
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
index 56299f4cc2b..010b7f86aab 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
@@ -104,9 +104,6 @@ packages:
   - openssh-client
   - pkgconf
   - python3
-  - python3-numpy
-  - python3-opencv
-  - python3-pillow
   - python3-pip
   - python3-setuptools
   - python3-sphinx
@@ -114,7 +111,6 @@ packages:
   - python3-tomli
   - python3-venv
   - python3-wheel
-  - python3-yaml
   - rpm2cpio
   - rustc-1.83
   - sed
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 7d185cda3cc..b3c99936723 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -91,11 +91,7 @@ packages:
  - pkg-config
  - pulseaudio
  - python3
- - python3-numpy
- - python3-opencv
- - python3-pillow
  - python3-pip
- - python3-PyYAML
  - python3-setuptools
  - python3-sphinx
  - python3-sphinx-rtd-theme
diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/freebsd.json
index 08b6eb61553..dfa8b41a524 100644
--- a/tests/vm/generated/freebsd.json
+++ b/tests/vm/generated/freebsd.json
@@ -49,14 +49,10 @@
     "ncurses",
     "nettle",
     "ninja",
-    "opencv",
     "pixman",
     "pkgconf",
     "png",
-    "py311-numpy",
-    "py311-pillow",
     "py311-pip",
-    "py311-pyyaml",
     "py311-setuptools",
     "py311-sphinx",
     "py311-sphinx_rtd_theme",
-- 
2.55.0


