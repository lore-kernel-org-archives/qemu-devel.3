Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B719C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 09:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWYiX-0001Jz-UP; Wed, 24 Jul 2024 05:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWYiT-000142-Ip
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWYiR-0005VB-HG
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721814921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Muq9lKePMMfx5aBcbTooUFRy5QQcUng0MBgTt3402lM=;
 b=M4w9hUNQi9/HzkAlcqGTMs3gAetZndQbXQieXwtQbG+1noEUO+1NjZJ0+56TBe9oxmWc4/
 0x4kHc5oPFzzVKkGg+Kc5SggoAVVH9xydJOgKoflMXEvzl5rG3fn/q4tJztUYzIQgsB9p1
 5CuCVpPQZyvG/eqhBKG8kFwQGAtoLTc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-8yi6_fQ4Mhu05W-4R1m8DA-1; Wed,
 24 Jul 2024 05:55:19 -0400
X-MC-Unique: 8yi6_fQ4Mhu05W-4R1m8DA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB5B11955D44; Wed, 24 Jul 2024 09:55:18 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.141])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BFFB019560AE; Wed, 24 Jul 2024 09:55:13 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/2] gitlab: record installed packages in /packages.txt in
 containers
Date: Wed, 24 Jul 2024 10:55:03 +0100
Message-ID: <20240724095505.33544-2-berrange@redhat.com>
In-Reply-To: <20240724095505.33544-1-berrange@redhat.com>
References: <20240724095505.33544-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The lcitool created containers save the full distro package list
details into /packages.txt. The idea is that build jobs will 'cat'
this file, so that the build log has a record of what packages
were used. This is important info, because when it comes to debug
failures, the original container is often lost.

This extends the manually written dockerfiles to also create the
/packages.txt file.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/docker/dockerfiles/debian-all-test-cross.docker    | 3 ++-
 tests/docker/dockerfiles/debian-hexagon-cross.docker     | 3 ++-
 tests/docker/dockerfiles/debian-legacy-test-cross.docker | 3 ++-
 tests/docker/dockerfiles/debian-loongarch-cross.docker   | 3 ++-
 tests/docker/dockerfiles/debian-tricore-cross.docker     | 3 ++-
 tests/docker/dockerfiles/debian-xtensa-cross.docker      | 3 ++-
 6 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 6cc38a3633..8ab244e018 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -62,7 +62,8 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         gcc-s390x-linux-gnu \
         libc6-dev-s390x-cross \
         gcc-sparc64-linux-gnu \
-        libc6-dev-sparc64-cross
+        libc6-dev-sparc64-cross && \
+        dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
 
 ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
index f2d40f2dee..23152b4918 100644
--- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
+++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
@@ -33,7 +33,8 @@ RUN apt-get update && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/c++ && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/g++ && \
-    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc && \
+    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
 RUN /usr/bin/pip3 install tomli
 
diff --git a/tests/docker/dockerfiles/debian-legacy-test-cross.docker b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
index d75e0b85e2..5a6616b7d3 100644
--- a/tests/docker/dockerfiles/debian-legacy-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
@@ -36,7 +36,8 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         python3-pip \
         python3-setuptools \
         python3-venv \
-        python3-wheel
+        python3-wheel && \
+        dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
 RUN /usr/bin/pip3 install tomli
 
diff --git a/tests/docker/dockerfiles/debian-loongarch-cross.docker b/tests/docker/dockerfiles/debian-loongarch-cross.docker
index 6a9197528b..79eab5621e 100644
--- a/tests/docker/dockerfiles/debian-loongarch-cross.docker
+++ b/tests/docker/dockerfiles/debian-loongarch-cross.docker
@@ -32,7 +32,8 @@ RUN apt-get update && \
         python3-pip \
         python3-setuptools \
         python3-venv \
-        python3-wheel
+        python3-wheel && \
+        dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
 RUN /usr/bin/pip3 install tomli
 
diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker b/tests/docker/dockerfiles/debian-tricore-cross.docker
index 16276aa21d..479b4d6eba 100644
--- a/tests/docker/dockerfiles/debian-tricore-cross.docker
+++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
@@ -34,7 +34,8 @@ RUN apt update && \
        python3-pip \
        python3-setuptools \
        python3-wheel \
-       python3-venv
+       python3-venv && \
+       dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
 RUN /usr/bin/pip3 install tomli
 
diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
index 413881899b..d011eee2ad 100644
--- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -16,7 +16,8 @@ RUN apt-get update && \
         curl \
         gettext \
         git \
-        python3-minimal
+        python3-minimal && \
+    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
 ENV CPU_LIST dc232b dc233c de233_fpu dsp3400
 ENV TOOLCHAIN_RELEASE 2020.07
-- 
2.45.2


