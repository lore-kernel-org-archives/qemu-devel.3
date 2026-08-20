Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5925AC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5zj-0000fS-8X; Thu, 20 Aug 2026 12:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zh-0000e1-Sl
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zf-0005lJ-M9
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8oXsNt/zDv/071YYoOtmJBMr5fEJodxY4IzsRLOYpZ8=;
 b=Z7CmOJsTCRVTA5EG1rZSeLGrbkGMWlseKEc4s0rpENmXtIoJrpVBd54K3sP4KmTkfwamoB
 B9qq4GTNBvh8qzMdA8ZmyFpQasAZ1XpXZGVMyCuZya5kGyCyKZArNI8kqQ5qEQJW+BBGxe
 qRlR+ePUTkdZvawixy9tX9/nR0kXEhw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-VCb5z3VIOTWVBFdfHrXUNw-1; Thu, 20 Aug 2026 12:51:53 -0400
X-MC-Unique: VCb5z3VIOTWVBFdfHrXUNw-1
X-Mimecast-MFC-AGG-ID: VCb5z3VIOTWVBFdfHrXUNw_1787244712
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-499574e98a1so164875e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244712; x=1787849512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8oXsNt/zDv/071YYoOtmJBMr5fEJodxY4IzsRLOYpZ8=;
 b=avP84xT9RFARPInqeyvde3v5WNtUcWCobrBmiMprx4XxHEBhAIIfugy2vOGoCUXg3b
 4JVo/ALPmD/CXbg3PdHh+6hrlxcZGSYpHc9mKM1sV4e5GkF7YVlbiARtVozUInJPcG1m
 kVYQuYn6uojiIDT0vfR/3v0/UshKKTXcmhD+4mSIVwzmYtztJ6bRBv4tM4HfsO2LoohC
 JwsjJdld6MRnhIpDvJMUckOs8EWDRkHlh0dZ3gnkZhVwiB40D2VAMcjaAgg8paQMGb9+
 7Jxni3n/QnB9Tr/X189S+SrQxl1Yv4mPLqVoPiDAZUvPAU6JrgdINWkyYa+krhXpZObr
 3CCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244712; x=1787849512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8oXsNt/zDv/071YYoOtmJBMr5fEJodxY4IzsRLOYpZ8=;
 b=N8RuqzVnYWB72nIufTcv7Zq0Uu3QUG9rUDhBscV0SJfPFv/OYKXrlxMtBrAm4PKWT5
 Hmcm/2y7aSsaLkK/pRrwSfG51PYqicjWLni4+xZU3qX+Ejfy9l2wQlBx4fGzooiVGKQy
 lq87Mu19tTKAzYksVGrYrYFTLIbH7MfeZo+uMZG9913PoA3slHGOmqf784/siy127fgn
 86FC4cqgxXXX7BoHyTp7EZ/yKtl49setSNlXT6Kar21hPYPUdOMtfw02Erdaeyt1xVFy
 eTTUy5pX/uU4pMzOxg+VYbxV56MdpV/U6GJunMRIAMPemtmV7915sV6UUNmlItna7wNw
 2Eqg==
X-Gm-Message-State: AOJu0YwdTv3Q640OuETl7nu9nZlB6eOz8ITLz58yW6eRareQljZ2UOl6
 P9U1lotuQfx63V6t4mswYI+6xfx1mWIZyFCOY6nITilGkY0HttxYmblnN44yPWfWTcRFSaHyXqT
 z0dvJekIdYNjWMmZkMFR/X+uY0wQvxVYKsC/KYN6H+2GlHqLGKX/KK/xOy5Pu6CHGhbd+mvpm/p
 B8wwu9RcYVbEdGWuLiBrBGJozg0wu/tUILFKlwpkRn
X-Gm-Gg: AR+sD11wxLrafBZcGVxiVwH22WDIO2fuJdZG5iX5lzY42b5BNZsJluu8I7W0KowKVPj
 ZJTzo8zkp5cwwLqNla3QxqlU219ZNYATc7cw0YvxLycwR48mQbCxDtmbsF8+ZzrtQGgZwwrACXC
 k4jSn5JOLOQ1eOI83CkeDI4GyUuVjaXTU+oIYp1WrrZxudtsl9CJP5fAZohxYg0vIGaROuu5SH2
 YzPkse3K/dYrIAay+cr+XsHMGqLcmG3l3smbFZIudiq72kVa4mPfFac2BB3MaFCKJNFwYdXBZoc
 nSYJ3WMjEnbZCamkRwzwIzHQVJbs6WjVI7PdkRdqujvFCwvL+J6OFXC+4AhDNaTiG9OTG2JHfLT
 OawxrDK6vPV6s8NrcD5xsNI64DQwkGU9A9NqGPrSmyHcV/WKlpfKM3Ejg37pJSvH7YM5NsmER2j
 vq2yU=
X-Received: by 2002:a05:600c:45c3:b0:499:4e47:eaf2 with SMTP id
 5b1f17b1804b1-499b8325c3fmr3928725e9.6.1787244712160; 
 Thu, 20 Aug 2026 09:51:52 -0700 (PDT)
X-Received: by 2002:a05:600c:45c3:b0:499:4e47:eaf2 with SMTP id
 5b1f17b1804b1-499b8325c3fmr3927695e9.6.1787244711639; 
 Thu, 20 Aug 2026 09:51:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b642865dsm17017045e9.10.2026.08.20.09.51.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 40/53] dockerfiles: update CentOS Stream 9 to Python 3.11,
 Meson to 1.12
Date: Thu, 20 Aug 2026 18:49:43 +0200
Message-ID: <20260820164957.1895963-41-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Python 3.10, which is a requirement for Meson 1.12.0, was never packaged
for CentOS Stream 9 so update directly to 3.11.

CentOS 9 does not install meson from PyPI because configure will install
it from the bundled wheel; this way CI covers that path as well.  This is
guaranteed because, when using a non-default Python, basically nothing
is installed.

The opensuse-leap-15.yml file was not in use anymore, so delete it
while touching tests/lcitool/targets/.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/dockerfiles/centos9.docker       | 16 +++++++-----
 .../dockerfiles/debian-all-test-cross.docker  |  2 +-
 .../dockerfiles/debian-amd64-cross.docker     |  2 +-
 .../dockerfiles/debian-arm64-cross.docker     |  2 +-
 .../dockerfiles/debian-armhf-cross.docker     |  2 +-
 .../dockerfiles/debian-i686-cross.docker      |  2 +-
 .../dockerfiles/debian-ppc64el-cross.docker   |  2 +-
 .../dockerfiles/debian-riscv64-cross.docker   |  2 +-
 .../dockerfiles/debian-s390x-cross.docker     |  2 +-
 tests/docker/dockerfiles/debian.docker        |  2 +-
 .../dockerfiles/fedora-rust-nightly.docker    |  2 +-
 .../dockerfiles/fedora-win64-cross.docker     |  2 +-
 tests/docker/dockerfiles/fedora.docker        |  2 +-
 tests/docker/dockerfiles/ubuntu2404.docker    |  2 +-
 tests/lcitool/mappings.yml                    | 26 ++++++++++++++++++-
 ...ensuse-leap-15.yml => centos-stream-9.yml} |  0
 16 files changed, 47 insertions(+), 21 deletions(-)
 rename tests/lcitool/targets/{opensuse-leap-15.yml => centos-stream-9.yml} (100%)

diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index e38cd692db9..8101370a2db 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -95,13 +95,11 @@ RUN dnf --quiet distro-sync -y && \
                 pixman-devel \
                 pkgconfig \
                 pulseaudio-libs-devel \
-                python3 \
-                python3-pip \
-                python3-setuptools \
-                python3-sphinx \
-                python3-sphinx_rtd_theme \
                 python3-tomli \
-                python3-wheel \
+                python3.11 \
+                python3.11-pip \
+                python3.11-setuptools \
+                python3.11-wheel \
                 rdma-core-devel \
                 rust \
                 rust-std-static \
@@ -131,11 +129,15 @@ RUN dnf --quiet distro-sync -y && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
+RUN /usr/bin/pip3.11 install \
+                     sphinx \
+                     sphinx-rtd-theme
+
 ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
 ENV LANG="en_US.UTF-8"
 ENV MAKE="/usr/bin/make"
 ENV NINJA="/usr/bin/ninja"
-ENV PYTHON="/usr/bin/python3"
+ENV PYTHON="/usr/bin/python3.11"
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 2dc580552e3..833185f6072 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -47,7 +47,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
-RUN /usr/bin/pip3 install meson==1.8.1
+RUN /usr/bin/pip3 install meson==1.12.0
 
 ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
 ENV LANG="en_US.UTF-8"
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 823606dc52a..9e30457ca79 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -66,7 +66,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg-reconfigure locales && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
-RUN /usr/bin/pip3 install meson==1.8.1
+RUN /usr/bin/pip3 install meson==1.12.0
 
 ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
 ENV LANG="en_US.UTF-8"
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index ed58e089ec0..b9b94e5e6fa 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -66,7 +66,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg-reconfigure locales && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
-RUN /usr/bin/pip3 install meson==1.8.1
+RUN /usr/bin/pip3 install meson==1.12.0
 
 ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
 ENV LANG="en_US.UTF-8"
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 0843f7428a9..aa412ff66f5 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -66,7 +66,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg-reconfigure locales && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
-RUN /usr/bin/pip3 install meson==1.8.1
+RUN /usr/bin/pip3 install meson==1.12.0
 
 ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
 ENV LANG="en_US.UTF-8"
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index caba08f842e..d07eac84fe8 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -66,7 +66,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg-reconfigure locales && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
-RUN /usr/bin/pip3 install meson==1.8.1
+RUN /usr/bin/pip3 install meson==1.12.0
 
 ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
 ENV LANG="en_US.UTF-8"
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 17018c0dab7..7302c8236e4 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -66,7 +66,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg-reconfigure locales && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
-RUN /usr/bin/pip3 install meson==1.8.1
+RUN /usr/bin/pip3 install meson==1.12.0
 
 ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
 ENV LANG="en_US.UTF-8"
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index 2408d453c20..aa5a881cab2 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -66,7 +66,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg-reconfigure locales && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
-RUN /usr/bin/pip3 install meson==1.8.1
+RUN /usr/bin/pip3 install meson==1.12.0
 
 ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
 ENV LANG="en_US.UTF-8"
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 2b0a344c2c5..82eae4fc2c2 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -66,7 +66,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg-reconfigure locales && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
-RUN /usr/bin/pip3 install meson==1.8.1
+RUN /usr/bin/pip3 install meson==1.12.0
 
 ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
 ENV LANG="en_US.UTF-8"
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 064b2ad1f12..3a4f208ccf6 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -145,7 +145,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
-RUN /usr/bin/pip3 install meson==1.8.1
+RUN /usr/bin/pip3 install meson==1.12.0
 
 ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
 ENV LANG="en_US.UTF-8"
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index dcad3af2a7f..0f3dc370a4f 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -145,7 +145,7 @@ exec "$@"\n' > /usr/bin/nosync && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
-RUN /usr/bin/pip3 install meson==1.8.1
+RUN /usr/bin/pip3 install meson==1.12.0
 
 ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
 ENV LANG="en_US.UTF-8"
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index bce350dfd8d..6f972f61738 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -66,7 +66,7 @@ exec "$@"\n' > /usr/bin/nosync && \
     nosync dnf --quiet clean all -y && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
-RUN /usr/bin/pip3 install meson==1.8.1
+RUN /usr/bin/pip3 install meson==1.12.0
 
 ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
 ENV LANG="en_US.UTF-8"
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index c541f5d5b18..99bb38a3665 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -145,7 +145,7 @@ exec "$@"\n' > /usr/bin/nosync && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
-RUN /usr/bin/pip3 install meson==1.8.1
+RUN /usr/bin/pip3 install meson==1.12.0
 
 ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
 ENV LANG="en_US.UTF-8"
diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/docker/dockerfiles/ubuntu2404.docker
index f027eef022e..a5c22231f98 100644
--- a/tests/docker/dockerfiles/ubuntu2404.docker
+++ b/tests/docker/dockerfiles/ubuntu2404.docker
@@ -145,7 +145,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
-RUN /usr/bin/pip3 install meson==1.8.1
+RUN /usr/bin/pip3 install meson==1.12.0
 
 ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
 ENV LANG="en_US.UTF-8"
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 62fe60d047f..1816556dde4 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -3,6 +3,30 @@ mappings:
   bindgen:
     Ubuntu2204:
 
+  python3:
+    CentOSStream9: python3.11
+
+  python3-devel:
+    CentOSStream9: python3.11-devel
+
+  python3-pip:
+    CentOSStream9: python3.11-pip
+
+  python3-setuptools:
+    CentOSStream9: python3.11-setuptools
+
+  python3-sphinx:
+    CentOSStream9:
+
+  python3-sphinx-rtd-theme:
+    CentOSStream9:
+
+  python3-venv:
+    CentOSStream9: python3.11
+
+  python3-wheel:
+    CentOSStream9: python3.11-wheel
+
   meson:
     # Use Meson from PyPI wherever Rust is enabled
     Debian:
@@ -23,7 +47,7 @@ mappings:
 pypi_mappings:
   # Request more recent version
   meson:
-    default: meson==1.8.1
+    default: meson==1.12.0
 
   # Drop packages that need devel headers
   python3-tomli:
diff --git a/tests/lcitool/targets/opensuse-leap-15.yml b/tests/lcitool/targets/centos-stream-9.yml
similarity index 100%
rename from tests/lcitool/targets/opensuse-leap-15.yml
rename to tests/lcitool/targets/centos-stream-9.yml
-- 
2.55.0


