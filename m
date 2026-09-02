Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A16C624DA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1qlM-0001Vp-36; Wed, 02 Sep 2026 15:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1qlL-0001VT-5H
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 15:36:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1qlJ-0004mV-JM
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 15:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788377804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IScl4ymDcWi7vUFYlQodu0K2mUJ8yqPYvAkugoMHSlk=;
 b=ftDWsKyyISy5O58XWVu7EW5pGvY5tIu2+UVnO7xhVU3Wensq99jbu04HEXakMtRu8KShaM
 GV71nfX/e2QZ2AGzJkwoXfhsYDNep3Me/HMoNnTyN5YHc2b1k5sfpgdbONZyhltfzQu1F3
 vxvMi5moelGy6fxq1KDL9J6ceLka7UM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-1-jbPDGfP16tLfO8HOzfJA-1; Wed,
 02 Sep 2026 15:36:41 -0400
X-MC-Unique: 1-jbPDGfP16tLfO8HOzfJA-1
X-Mimecast-MFC-AGG-ID: 1-jbPDGfP16tLfO8HOzfJA_1788377799
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44AEB183F9D4; Wed,  2 Sep 2026 19:36:39 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.24])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 08086180063E; Wed,  2 Sep 2026 19:36:33 +0000 (UTC)
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
Subject: [PULL 06/16] tests: add Python3.12 to centos9.docker
Date: Wed,  2 Sep 2026 15:35:41 -0400
Message-ID: <20260902193551.582660-7-jsnow@redhat.com>
In-Reply-To: <20260902193551.582660-1-jsnow@redhat.com>
References: <20260902193551.582660-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

While we recently upgraded to Python 3.11 for the CentOS 9 container,
upgrade it EVEN FURTHER BEYOND... to Python 3.12.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260825215851.1780608-7-jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/docker/dockerfiles/centos9.docker   | 12 ++++++------
 tests/lcitool/mappings.yml                | 10 +++++-----
 tests/lcitool/targets/centos-stream-9.yml |  4 ++--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index 6f5c400c2db..8bfce395f9d 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -96,10 +96,10 @@ RUN dnf --quiet distro-sync -y && \
                 pkgconfig \
                 pulseaudio-libs-devel \
                 python3-tomli \
-                python3.11 \
-                python3.11-pip \
-                python3.11-setuptools \
-                python3.11-wheel \
+                python3.12 \
+                python3.12-pip \
+                python3.12-setuptools \
+                python3.12-wheel \
                 rdma-core-devel \
                 rust \
                 rust-std-static \
@@ -129,7 +129,7 @@ RUN dnf --quiet distro-sync -y && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
     ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
 
-RUN /usr/bin/pip3.11 install \
+RUN /usr/bin/pip3.12 install \
                      numpy \
                      opencv-python \
                      sphinx \
@@ -139,7 +139,7 @@ ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
 ENV LANG="en_US.UTF-8"
 ENV MAKE="/usr/bin/make"
 ENV NINJA="/usr/bin/ninja"
-ENV PYTHON="/usr/bin/python3.11"
+ENV PYTHON="/usr/bin/python3.12"
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index cb56cdb3da1..c99f007798e 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -4,13 +4,13 @@ mappings:
     Ubuntu2204:
 
   python3:
-    CentOSStream9: python3.11
+    CentOSStream9: python3.12
 
   python3-pip:
-    CentOSStream9: python3.11-pip
+    CentOSStream9: python3.12-pip
 
   python3-setuptools:
-    CentOSStream9: python3.11-setuptools
+    CentOSStream9: python3.12-setuptools
 
   python3-sphinx:
     CentOSStream9:
@@ -22,10 +22,10 @@ mappings:
     CentOSStream9:
 
   python3-venv:
-    CentOSStream9: python3.11
+    CentOSStream9: python3.12
 
   python3-wheel:
-    CentOSStream9: python3.11-wheel
+    CentOSStream9: python3.12-wheel
 
   python3-numpy:
     CentOSStream9:
diff --git a/tests/lcitool/targets/centos-stream-9.yml b/tests/lcitool/targets/centos-stream-9.yml
index c2d87f6cb4d..0d6801fd9a3 100644
--- a/tests/lcitool/targets/centos-stream-9.yml
+++ b/tests/lcitool/targets/centos-stream-9.yml
@@ -1,3 +1,3 @@
 paths:
-  pip3: /usr/bin/pip3.11
-  python: /usr/bin/python3.11
+  pip3: /usr/bin/pip3.12
+  python: /usr/bin/python3.12
-- 
2.55.0


