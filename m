Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CA4C624DA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ql1-0001Qy-Mf; Wed, 02 Sep 2026 15:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1qkw-0001QN-1z
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 15:36:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1qku-0004kF-1O
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 15:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788377779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Ic5IaMsLZ4c0vCDeMWdadQJ9Q2qNESSYIhn9OI8cRk=;
 b=FKX/SS04QpW4+ctZouUr+gCyxSUj02fjA3MjoRkKozVISonLOLDYEl/a2/BYtxdYs5up/i
 oyWXd6Ri6b59WApLmozQe1/38uui/W6YcpcYb2rUWwAA935jglRvdNJgrv1R8Nia5U52C5
 Ok2ejgCM5znMGrTj/HDX9nPPAuRNFJs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-xaEBogNINOCaAU1huf3K_g-1; Wed,
 02 Sep 2026 15:36:15 -0400
X-MC-Unique: xaEBogNINOCaAU1huf3K_g-1
X-Mimecast-MFC-AGG-ID: xaEBogNINOCaAU1huf3K_g_1788377773
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F4911944B0B; Wed,  2 Sep 2026 19:36:12 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.24])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7442F180063E; Wed,  2 Sep 2026 19:36:06 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Hanna Reitz <hreitz@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Yonggang Luo <luoyonggang@gmail.com>, Warner Losh <imp@bsdimp.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 02/16] tests: update libvirt-ci, lcitool
Date: Wed,  2 Sep 2026 15:35:37 -0400
Message-ID: <20260902193551.582660-3-jsnow@redhat.com>
In-Reply-To: <20260902193551.582660-1-jsnow@redhat.com>
References: <20260902193551.582660-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Update libvirt-ci to current origin/master for the primary sake of
grabbing new mappings for FreeBSD, which has upgraded from Python 3.11
to 3.12 and along with it changed the name of their python ecosystem
packages.

Refresh the lcitool generated files to fix our FreeBSD tests.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260825215851.1780608-3-jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/docker/dockerfiles/debian-amd64-cross.docker   |  2 +-
 tests/docker/dockerfiles/debian-arm64-cross.docker   |  2 +-
 tests/docker/dockerfiles/debian-armhf-cross.docker   |  2 +-
 tests/docker/dockerfiles/debian-i686-cross.docker    |  2 +-
 tests/docker/dockerfiles/debian-ppc64el-cross.docker |  2 +-
 tests/docker/dockerfiles/debian-riscv64-cross.docker |  2 +-
 tests/docker/dockerfiles/debian-s390x-cross.docker   |  2 +-
 tests/docker/dockerfiles/debian.docker               |  2 +-
 tests/docker/dockerfiles/opensuse-leap.docker        |  2 +-
 tests/docker/dockerfiles/ubuntu2404.docker           |  2 +-
 scripts/ci/setup/debian/debian-13-ppc64le.yaml       |  2 +-
 scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml     |  2 +-
 scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml       |  2 +-
 tests/lcitool/libvirt-ci                             |  2 +-
 tests/vm/generated/freebsd.json                      | 12 ++++++------
 15 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 9e30457ca79..e945e641e20 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -130,7 +130,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libsdl2-dev:amd64 \
                       libsdl2-image-dev:amd64 \
                       libseccomp-dev:amd64 \
-                      libselinux1-dev:amd64 \
+                      libselinux-dev:amd64 \
                       libslirp-dev:amd64 \
                       libsnappy-dev:amd64 \
                       libsndio-dev:amd64 \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index b9b94e5e6fa..0ee3a3f61c4 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -129,7 +129,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libsdl2-dev:arm64 \
                       libsdl2-image-dev:arm64 \
                       libseccomp-dev:arm64 \
-                      libselinux1-dev:arm64 \
+                      libselinux-dev:arm64 \
                       libslirp-dev:arm64 \
                       libsnappy-dev:arm64 \
                       libsndio-dev:arm64 \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index aa412ff66f5..aacc1846801 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -128,7 +128,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libsdl2-dev:armhf \
                       libsdl2-image-dev:armhf \
                       libseccomp-dev:armhf \
-                      libselinux1-dev:armhf \
+                      libselinux-dev:armhf \
                       libslirp-dev:armhf \
                       libsnappy-dev:armhf \
                       libsndio-dev:armhf \
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index d07eac84fe8..476031bd4db 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -128,7 +128,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libsdl2-dev:i386 \
                       libsdl2-image-dev:i386 \
                       libseccomp-dev:i386 \
-                      libselinux1-dev:i386 \
+                      libselinux-dev:i386 \
                       libslirp-dev:i386 \
                       libsnappy-dev:i386 \
                       libsndio-dev:i386 \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 7302c8236e4..87e24d4dc0f 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -129,7 +129,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libsdl2-dev:ppc64el \
                       libsdl2-image-dev:ppc64el \
                       libseccomp-dev:ppc64el \
-                      libselinux1-dev:ppc64el \
+                      libselinux-dev:ppc64el \
                       libslirp-dev:ppc64el \
                       libsnappy-dev:ppc64el \
                       libsndio-dev:ppc64el \
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index aa5a881cab2..d0a9805f864 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -129,7 +129,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libsdl2-dev:riscv64 \
                       libsdl2-image-dev:riscv64 \
                       libseccomp-dev:riscv64 \
-                      libselinux1-dev:riscv64 \
+                      libselinux-dev:riscv64 \
                       libslirp-dev:riscv64 \
                       libsnappy-dev:riscv64 \
                       libsndio-dev:riscv64 \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 82eae4fc2c2..179be9573d7 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -129,7 +129,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libsdl2-dev:s390x \
                       libsdl2-image-dev:s390x \
                       libseccomp-dev:s390x \
-                      libselinux1-dev:s390x \
+                      libselinux-dev:s390x \
                       libslirp-dev:s390x \
                       libsnappy-dev:s390x \
                       libsndio-dev:s390x \
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 3a4f208ccf6..56605a42a2f 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -82,7 +82,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libsdl2-dev \
                       libsdl2-image-dev \
                       libseccomp-dev \
-                      libselinux1-dev \
+                      libselinux-dev \
                       libslirp-dev \
                       libsnappy-dev \
                       libsndio-dev \
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index 8d8631bbcf0..a634f39c1ec 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -7,7 +7,7 @@
 FROM registry.opensuse.org/opensuse/leap:16.0
 
 RUN zypper update -y && \
-    zypper install -y \
+    zypper install -y --allow-downgrade \
            Mesa-devel \
            alsa-lib-devel \
            bash \
diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/docker/dockerfiles/ubuntu2404.docker
index a5c22231f98..d80f3a33d3b 100644
--- a/tests/docker/dockerfiles/ubuntu2404.docker
+++ b/tests/docker/dockerfiles/ubuntu2404.docker
@@ -82,7 +82,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libsdl2-dev \
                       libsdl2-image-dev \
                       libseccomp-dev \
-                      libselinux1-dev \
+                      libselinux-dev \
                       libslirp-dev \
                       libsnappy-dev \
                       libsndio-dev \
diff --git a/scripts/ci/setup/debian/debian-13-ppc64le.yaml b/scripts/ci/setup/debian/debian-13-ppc64le.yaml
index 9acd99a7433..c4d229830b6 100644
--- a/scripts/ci/setup/debian/debian-13-ppc64le.yaml
+++ b/scripts/ci/setup/debian/debian-13-ppc64le.yaml
@@ -75,7 +75,7 @@ packages:
   - libsdl2-dev
   - libsdl2-image-dev
   - libseccomp-dev
-  - libselinux1-dev
+  - libselinux-dev
   - libslirp-dev
   - libsnappy-dev
   - libsndio-dev
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
index 5c948109df8..f6fa68d476f 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
@@ -75,7 +75,7 @@ packages:
   - libsdl2-dev
   - libsdl2-image-dev
   - libseccomp-dev
-  - libselinux1-dev
+  - libselinux-dev
   - libslirp-dev
   - libsnappy-dev
   - libsndio-dev
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
index 010b7f86aab..6c4cefe97e5 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
@@ -75,7 +75,7 @@ packages:
   - libsdl2-dev
   - libsdl2-image-dev
   - libseccomp-dev
-  - libselinux1-dev
+  - libselinux-dev
   - libslirp-dev
   - libsnappy-dev
   - libsndio-dev
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index 5176e136ab1..76b5dd5b5c8 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 5176e136ab11e275eb9f57c3d5c80e77af6507cb
+Subproject commit 76b5dd5b5c84511e2e799c2b3d6a2a9b9f6a081d
diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/freebsd.json
index dfa8b41a524..ee3402f0d2b 100644
--- a/tests/vm/generated/freebsd.json
+++ b/tests/vm/generated/freebsd.json
@@ -52,12 +52,12 @@
     "pixman",
     "pkgconf",
     "png",
-    "py311-pip",
-    "py311-setuptools",
-    "py311-sphinx",
-    "py311-sphinx_rtd_theme",
-    "py311-tomli",
-    "py311-wheel",
+    "py312-pip",
+    "py312-setuptools",
+    "py312-sphinx",
+    "py312-sphinx_rtd_theme",
+    "py312-tomli",
+    "py312-wheel",
     "python3",
     "rpm2cpio",
     "rust",
-- 
2.55.0


