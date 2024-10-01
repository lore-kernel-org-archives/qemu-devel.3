Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA2ECEACC5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdYA-0008JS-Ag; Tue, 01 Oct 2024 10:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svdY7-0008FW-Ui
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:08:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svdY3-0001s9-DG
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727791698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=z/5+rs0r508iREfL2v3FN+6adWfn4Z6/mf996ngU0Ew=;
 b=eLryQqFy6dm/1/mRrAUO0Rs4dAI7+sZ5bmVI0mE6e2yeKZGBQBB5V8QwMPtowopY4DLDp7
 6mnhFGFVdnQHgy88ZqVp97mp4LFG+o5ut7CHNswsGR9pvyo+SxoH+0d+L3rZbQZ493Yt1l
 bjA+iNzxMAf7CuzgAyexuD8h+PVWwD8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-dyMZVtv6PuG3bgoh9RU8Ag-1; Tue,
 01 Oct 2024 06:51:58 -0400
X-MC-Unique: dyMZVtv6PuG3bgoh9RU8Ag-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8C8418E68CB; Tue,  1 Oct 2024 10:51:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.152])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 03781195DF91; Tue,  1 Oct 2024 10:51:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v2] testing: bump mips64el cross to bookworm and allow to fail
Date: Tue,  1 Oct 2024 12:51:48 +0200
Message-ID: <20241001105148.74182-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Alex Bennée <alex.bennee@linaro.org>

The mips64el cross setup is very broken for bullseye which has now
entered LTS support so is unlikely to be fixed. While we still can't
build the container for bookworm due to a single missing dependency
that will hopefully get fixed in due course. For the sake of keeping
the CI green we mark it as allow_fail for the time being.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
[thuth: Temporarily remove the problematic packages manually]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Removing the packages that depend on mesa manually helps to get the
 job green again:
  https://gitlab.com/thuth/qemu/-/jobs/7961678029
 That's of course just a temporary fix 'til the next update via lcitool,
 but hopefully Debian will have fixed their distro by that point in time.

 .gitlab-ci.d/container-cross.yml              |  3 +++
 .../dockerfiles/debian-mips64el-cross.docker  | 20 ++++---------------
 tests/lcitool/refresh                         |  2 +-
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 34c0e729ad..c567926182 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -49,6 +49,9 @@ i686-debian-cross-container:
 mips64el-debian-cross-container:
   extends: .container_job_template
   stage: containers
+  # Currently waiting for Debian to fix:
+  #  libgl1-mesa-dri:mips64el : Depends: libllvm15:mips64el but it is not going to be installed
+  allow_failure: true
   variables:
     NAME: debian-mips64el-cross
 
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 2862785692..4f3277a3a6 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch mips64el debian-11 qemu
+#  $ lcitool dockerfile --layers all --cross-arch mips64el debian-12 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:12-slim
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -33,7 +33,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libgtk-vnc-2.0-dev \
                       libpcre2-dev \
                       libsndio-dev \
-                      libspice-protocol-dev \
                       llvm \
                       locales \
                       make \
@@ -48,16 +47,15 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-opencv \
                       python3-pillow \
                       python3-pip \
-                      python3-setuptools \
                       python3-sphinx \
                       python3-sphinx-rtd-theme \
                       python3-venv \
-                      python3-wheel \
                       python3-yaml \
                       rpm2cpio \
                       sed \
                       socat \
                       sparse \
+                      swtpm \
                       tar \
                       tesseract-ocr \
                       tesseract-ocr-eng \
@@ -69,8 +67,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
     dpkg-reconfigure locales && \
     rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED
 
-RUN /usr/bin/pip3 install tomli
-
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
@@ -97,17 +93,13 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcmocka-dev:mips64el \
                       libcurl4-gnutls-dev:mips64el \
                       libdaxctl-dev:mips64el \
-                      libdrm-dev:mips64el \
-                      libepoxy-dev:mips64el \
                       libfdt-dev:mips64el \
                       libffi-dev:mips64el \
                       libfuse3-dev:mips64el \
-                      libgbm-dev:mips64el \
                       libgcrypt20-dev:mips64el \
                       libglib2.0-dev:mips64el \
                       libglusterfs-dev:mips64el \
                       libgnutls28-dev:mips64el \
-                      libgtk-3-dev:mips64el \
                       libibverbs-dev:mips64el \
                       libiscsi-dev:mips64el \
                       libjemalloc-dev:mips64el \
@@ -126,13 +118,10 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       librbd-dev:mips64el \
                       librdmacm-dev:mips64el \
                       libsasl2-dev:mips64el \
-                      libsdl2-dev:mips64el \
-                      libsdl2-image-dev:mips64el \
                       libseccomp-dev:mips64el \
                       libselinux1-dev:mips64el \
                       libslirp-dev:mips64el \
                       libsnappy-dev:mips64el \
-                      libspice-server-dev:mips64el \
                       libssh-gcrypt-dev:mips64el \
                       libsystemd-dev:mips64el \
                       libtasn1-6-dev:mips64el \
@@ -141,8 +130,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libusb-1.0-0-dev:mips64el \
                       libusbredirhost-dev:mips64el \
                       libvdeplug-dev:mips64el \
-                      libvirglrenderer-dev:mips64el \
-                      libvte-2.91-dev:mips64el \
+                      libxdp-dev:mips64el \
                       libzstd-dev:mips64el \
                       nettle-dev:mips64el \
                       systemtap-sdt-dev:mips64el \
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 92381f3c46..a78219f7bc 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -166,7 +166,7 @@ try:
                                             "x86_64-linux-user,"
                                             "i386-softmmu,i386-linux-user"))
 
-    generate_dockerfile("debian-mips64el-cross", "debian-11",
+    generate_dockerfile("debian-mips64el-cross", "debian-12",
                         cross="mips64el",
                         trailer=cross_build("mips64el-linux-gnuabi64-",
                                             "mips64el-softmmu,mips64el-linux-user"))
-- 
2.46.1


