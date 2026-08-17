Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FDDC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxcj-0000vX-1m; Mon, 17 Aug 2026 09:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvxch-0000qV-FA
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:43:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvxcf-0001Bu-9s
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786974208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cr/q2DFhwbF8JH8HX7tGqmU4MDGlvqjmazAq6Ek7EQ4=;
 b=B1msrR+aNahxcMk9Wx2lctGKSfc7WSe/ZlH6W50P3gKFYC5tDbN1hYh7bOuOVeURsvKv4/
 PYP3hRZN8nD//nKXTsJ3v9gYSnVgjhmtatyhhrTaifjVdcqWUxZPZven7Z7pneC4SWoSBA
 L4scxQYAHSPWh9Q/I6Vh9aUrRNTUP+o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-k77QmDpFOFydGm4xa0y9_g-1; Mon, 17 Aug 2026 09:43:27 -0400
X-MC-Unique: k77QmDpFOFydGm4xa0y9_g-1
X-Mimecast-MFC-AGG-ID: k77QmDpFOFydGm4xa0y9_g_1786974206
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47fd4ee0ac0so2805406f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 06:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786974206; x=1787579006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cr/q2DFhwbF8JH8HX7tGqmU4MDGlvqjmazAq6Ek7EQ4=;
 b=ImDuoMekW1/dfLZGge/thP5jrggBO84y288w1POs8fTWVUtz8sM3811ZnEI4pcEJhV
 xBG+2d7vhghlDZqkF0dOZ54jlam2cZYgt6sxF5n/lKi1k60GmWXfK396uCGnD1s67VcW
 Twy7ghsiI0fxGAtQI9ccjNRBJr+s3G3gT5jQWTCu8/YyQGHB6A26TI5Xyp6WJ3A3mojC
 KHQHO4zpwsXT2VJeLmaBzRgQU3ZeDm8ZLkHwtV0d1n5VH+zsv0DnR8xdRGmcxwhIkUXo
 nfOGRj2GiPYADgBXZVqEg97uPfK2eXmoTci7tIvxQJCbfSceY74+VnwjUMtTX6hb0SZJ
 lWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786974206; x=1787579006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cr/q2DFhwbF8JH8HX7tGqmU4MDGlvqjmazAq6Ek7EQ4=;
 b=eOi5sotZVq1xM6lQtEkE6m9qoNV5fa5/o4xHtXeXN+MosKGejeFDUUMMQKDjPzdCcW
 KpBwhYjwfwcF7+qtccfDMQt3jBg2xTpersvy3h4aK3d1GeWCEPJARP+H1o5/FqRPy24u
 ai5W7GoQgBLhbUxnOTPPaBtY7OmqpxCfb2oFsMieFecWSBvKzHfxiLcVDW/NYPJouNSR
 gpz7s3R/V6XQ5fbpbLrjP7EDuVBatLotrSYopTaHP4VPqWmLBv7mmEZvoouFYZzLVFdm
 HwT9JY6FgXuO25FFPxIDARy6i5dU2fM8efcsyg9Qxm4l02og64aRch0yzPwlzXMpWDV+
 ekTQ==
X-Gm-Message-State: AOJu0YxWY5s/BVT4o7u/nP78G96RewoKMmpOFZibYhsHAtY/xT6LdLah
 mC2QlOJyxiTdCVUPcYxQ0+ka1J25/b3gZBOiv0aADw2u2xb6XNYg1gWkgW5MqoKuZ5u9y7z/KfE
 RL3oUPt/O+582toSmeY/PQaf4oTqPQyaEq27Zeb8bKEI+jtSJxxoqeWQmXARhtaU3HnVZOBwZd9
 wCXG8QOGXZoWyT+nzqH/s6tWVOmDBXyDxqSCfWhbYG
X-Gm-Gg: AR+sD129v2sYGCet6o50Q93myx/PqUqm59GkgnzrYK6cik56LeEqdZAPkSEhFw9N89y
 hryk5hdNU+lxu9hJauu/bUXWy/WD7xPQHH+Ee96HRQbydzqE6K8UHrs+a4Qe6dhNGI3jnmhRtFg
 RmLmMS4hBB9Egatohj+Fq17PqAmbcPHKLOfZyE9xeW9Y3tlkuSf0WkzCrR9FYEuJKQwEeVsdOA4
 dFSmbBCEZ579pABEQ8UtPWaWlCAUhADvrCty3ZtKgw9YjrFTltiKShDcENDKXGBL3wJ3BVyPC23
 AW86NkA3Q7RI4+ix4fQ5dEUcPEqMiBZgSqFwG7Az0tVpXMVZgixTISdhAs+LbYpylN7pXa3OOiJ
 4tk62DWZYvVs189uui8dOs8KDzfxus+VtY9ozNgS4B74VFIUV+4CRqUjHKGeJyLCTPDmqhlYqh1
 oJ3BQ=
X-Received: by 2002:a5d:4209:0:b0:481:5d81:3b18 with SMTP id
 ffacd0b85a97d-481607a1229mr27632332f8f.24.1786974205459; 
 Mon, 17 Aug 2026 06:43:25 -0700 (PDT)
X-Received: by 2002:a5d:4209:0:b0:481:5d81:3b18 with SMTP id
 ffacd0b85a97d-481607a1229mr27632248f8f.24.1786974204773; 
 Mon, 17 Aug 2026 06:43:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a315d3sm4157459f8f.6.2026.08.17.06.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 06:43:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	alex.bennee@linaro.org
Subject: [PATCH 3/3] dockerfiles: update CentOS Stream 9 to Python 3.11,
 Meson to 1.12
Date: Mon, 17 Aug 2026 15:43:13 +0200
Message-ID: <20260817134313.922754-4-pbonzini@redhat.com>
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

Python 3.10, which is a requirement for Meson 1.12.0, was never
packages for CentOS Stream 9 so update directly to 3.11.

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


