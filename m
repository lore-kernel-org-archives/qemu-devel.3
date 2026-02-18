Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AE2E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 19:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsnGo-000296-Ho; Wed, 18 Feb 2026 14:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vsnGj-00028I-HT
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:31:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vsnGg-0007hW-Aw
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771443085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V/mfpdsOPvf5/cSCbY+su91rktGGKNOnoJcx/tjXA80=;
 b=SF8+/tKJF7Swl7W8auRyB2993+FW5rmc51/TeHguAwFVC26t2IQDHjO/070gzW5xwTF6ZK
 TSDyNDVdzcak+xOep9VgL3rg8EFuNooygExCZOCBPjmzx30qXCCJsx2jZDGgYPub25ZhKP
 mAHJY4QlldFRb3DLZtS/oWHtsXGP1jY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-9sC6cnHcMPyV7unkqY4lwQ-1; Wed,
 18 Feb 2026 14:31:22 -0500
X-MC-Unique: 9sC6cnHcMPyV7unkqY4lwQ-1
X-Mimecast-MFC-AGG-ID: 9sC6cnHcMPyV7unkqY4lwQ_1771443081
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13D3D19560B7; Wed, 18 Feb 2026 19:31:21 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.65.233])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2121C1800351; Wed, 18 Feb 2026 19:31:18 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 1/2] tests: upgrade most non-lcitool debian tests to debian 13
Date: Wed, 18 Feb 2026 14:31:15 -0500
Message-ID: <20260218193116.659213-2-jsnow@redhat.com>
In-Reply-To: <20260218193116.659213-1-jsnow@redhat.com>
References: <20260218193116.659213-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Debian 11 was EOL in 2024, and Debian 12 will be EOL this June. This
patch moves all but one of our tests, debian-legacy-test-cross, onto
Debian 13.

I did not make any attempt to optimize or update these tests beyond the
minimum necessary to keep them running, as I am not deeply familiar with
these tests.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/docker/dockerfiles/debian-hexagon-cross.docker  | 11 ++++++-----
 .../docker/dockerfiles/debian-loongarch-cross.docker  | 10 +++++-----
 tests/docker/dockerfiles/debian-toolchain.docker      |  8 +++++---
 tests/docker/dockerfiles/debian-tricore-cross.docker  |  5 ++---
 tests/docker/dockerfiles/debian-xtensa-cross.docker   |  2 +-
 5 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
index 23152b4918b..91d4b71ac95 100644
--- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
+++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
@@ -5,10 +5,12 @@
 # needs to be able to build QEMU itself in CI we include its
 # build-deps.
 #
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:13-slim
+
+# Add deb-src repository sources
+RUN sed -i "s/^Types: deb$/Types: deb deb-src/" \
+    /etc/apt/sources.list.d/debian.sources
 
-# Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
 RUN apt-get update && \
     DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
@@ -24,6 +26,7 @@ RUN apt-get update && \
         ninja-build \
         python3-pip \
         python3-setuptools \
+        python3-tomli \
         python3-venv \
         python3-wheel && \
 # Install QEMU build deps for use in CI
@@ -36,8 +39,6 @@ RUN apt-get update && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
-RUN /usr/bin/pip3 install tomli
-
 ENV TOOLCHAIN_INSTALL /opt
 ENV TOOLCHAIN_RELEASE 12.Dec.2023
 ENV TOOLCHAIN_BASENAME "clang+llvm-${TOOLCHAIN_RELEASE}-cross-hexagon-unknown-linux-musl"
diff --git a/tests/docker/dockerfiles/debian-loongarch-cross.docker b/tests/docker/dockerfiles/debian-loongarch-cross.docker
index 538ab534902..55b3dbe4510 100644
--- a/tests/docker/dockerfiles/debian-loongarch-cross.docker
+++ b/tests/docker/dockerfiles/debian-loongarch-cross.docker
@@ -4,10 +4,11 @@
 # This docker target uses prebuilt toolchains for LoongArch64 from:
 # https://github.com/loongson/build-tools/releases
 #
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:13-slim
 
-# Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
+# Add deb-src repository sources
+RUN sed -i "s/^Types: deb$/Types: deb deb-src/" \
+    /etc/apt/sources.list.d/debian.sources
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -31,12 +32,11 @@ RUN apt-get update && \
         ninja-build \
         python3-pip \
         python3-setuptools \
+        python3-tomli \
         python3-venv \
         python3-wheel && \
         dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
-RUN /usr/bin/pip3 install tomli
-
 RUN curl -#SL https://github.com/loongson/build-tools/releases/download/2023.08.08/CLFS-loongarch64-8.1-x86_64-cross-tools-gcc-glibc.tar.xz \
     | tar -xJC /opt
 
diff --git a/tests/docker/dockerfiles/debian-toolchain.docker b/tests/docker/dockerfiles/debian-toolchain.docker
index ab4ce29533d..9a256209a78 100644
--- a/tests/docker/dockerfiles/debian-toolchain.docker
+++ b/tests/docker/dockerfiles/debian-toolchain.docker
@@ -4,13 +4,15 @@
 # This dockerfile is used for building a cross-compiler toolchain.
 # The script for building the toolchain is supplied via extra-files.
 #
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:13-slim
 
 # Install build utilities for building gcc and glibc.
 # ??? The build-dep isn't working, missing a number of
 # minimal build dependiencies, e.g. libmpc.
 
-RUN sed 's/^deb /deb-src /' </etc/apt/sources.list >/etc/apt/sources.list.d/deb-src.list
+# Add deb-src repository sources
+RUN sed -i "s/^Types: deb$/Types: deb deb-src/" \
+    /etc/apt/sources.list.d/debian.sources
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
@@ -34,7 +36,7 @@ RUN cd /root && ./build-toolchain.sh
 # Throw away the extra toolchain build deps, the downloaded source,
 # and the build trees by restoring the original image,
 # then copying the built toolchain from stage 0.
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:13-slim
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
     DEBIAN_FRONTEND=noninteractive eatmydata \
diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
index 7e00e870ceb..fd797dc7ee4 100644
--- a/tests/docker/dockerfiles/debian-tricore-cross.docker
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -9,7 +9,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:13-slim
 
 RUN apt update && \
     DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
@@ -31,12 +31,11 @@ RUN apt update && \
        pkgconf \
        python3-pip \
        python3-setuptools \
+       python3-tomli \
        python3-wheel \
        python3-venv && \
        dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
-RUN /usr/bin/pip3 install tomli
-
 RUN curl -#SL https://github.com/bkoppelmann/package_940/releases/download/tricore-toolchain-9.40/tricore-toolchain-9.4.0.tar.gz \
     | tar -xzC /usr/local/
 
diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
index d011eee2ad3..ef63e44e2ef 100644
--- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -5,7 +5,7 @@
 # using a prebuilt toolchains for Xtensa cores from:
 # https://github.com/foss-xtensa/toolchain/releases
 #
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:13-slim
 
 RUN apt-get update && \
     DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
-- 
2.53.0


