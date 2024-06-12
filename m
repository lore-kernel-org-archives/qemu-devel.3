Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6E8C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNv3-0000TS-T6; Wed, 12 Jun 2024 09:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHNur-00009n-U2
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHNul-0003wM-DP
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718198482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZXZx4mBy9A0uTUfCiqa1pLnX0ROixaN0F0vHgz6+z5U=;
 b=fLewCAAfG3G1701F8qrDjTPG2TRi7Dd4HJaYUpAKAtveZptqURgVi5wAnT6+CHlH76nbzZ
 M+f1hVAQwMqLESdQxDTiiXvzk00znArMB/PtrW/Mywg0j93MqTDyv6RzZr8mSDxBMlxxrf
 KWAHVyOwjAiNlgjZwxK/sbTe64QWqcY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-D2cjC5yaMiG_arktHFSKXw-1; Wed,
 12 Jun 2024 09:21:18 -0400
X-MC-Unique: D2cjC5yaMiG_arktHFSKXw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50B691956062; Wed, 12 Jun 2024 13:21:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.236])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A8CB1955E87; Wed, 12 Jun 2024 13:21:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: zhenwei pi <pizhenwei@bytedance.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/15] test: Remove libibumad dependence
Date: Wed, 12 Jun 2024 15:20:46 +0200
Message-ID: <20240612132055.326889-7-thuth@redhat.com>
In-Reply-To: <20240612132055.326889-1-thuth@redhat.com>
References: <20240612132055.326889-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: zhenwei pi <pizhenwei@bytedance.com>

Remove libibumad dependence from the test environment.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240611105427.61395-3-pizhenwei@bytedance.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml      | 1 -
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml        | 1 -
 tests/docker/dockerfiles/debian-amd64-cross.docker    | 1 -
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 1 -
 tests/docker/dockerfiles/debian-armel-cross.docker    | 1 -
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 1 -
 tests/docker/dockerfiles/debian-i686-cross.docker     | 1 -
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 1 -
 tests/docker/dockerfiles/debian-mipsel-cross.docker   | 1 -
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 1 -
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 1 -
 tests/docker/dockerfiles/debian.docker                | 1 -
 tests/docker/dockerfiles/ubuntu2204.docker            | 1 -
 tests/lcitool/projects/qemu.yml                       | 1 -
 14 files changed, 14 deletions(-)

diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
index 8d7d8725fb..fd5489cd82 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
@@ -49,7 +49,6 @@ packages:
   - libglusterfs-dev
   - libgnutls28-dev
   - libgtk-3-dev
-  - libibumad-dev
   - libibverbs-dev
   - libiscsi-dev
   - libjemalloc-dev
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
index 16050a5058..afa04502cf 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
@@ -49,7 +49,6 @@ packages:
   - libglusterfs-dev
   - libgnutls28-dev
   - libgtk-3-dev
-  - libibumad-dev
   - libibverbs-dev
   - libiscsi-dev
   - libjemalloc-dev
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index f8c61d1191..8058695979 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -105,7 +105,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:amd64 \
                       libgnutls28-dev:amd64 \
                       libgtk-3-dev:amd64 \
-                      libibumad-dev:amd64 \
                       libibverbs-dev:amd64 \
                       libiscsi-dev:amd64 \
                       libjemalloc-dev:amd64 \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 6510872279..15457d7657 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -105,7 +105,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:arm64 \
                       libgnutls28-dev:arm64 \
                       libgtk-3-dev:arm64 \
-                      libibumad-dev:arm64 \
                       libibverbs-dev:arm64 \
                       libiscsi-dev:arm64 \
                       libjemalloc-dev:arm64 \
diff --git a/tests/docker/dockerfiles/debian-armel-cross.docker b/tests/docker/dockerfiles/debian-armel-cross.docker
index f227d42987..c26ffc2e9e 100644
--- a/tests/docker/dockerfiles/debian-armel-cross.docker
+++ b/tests/docker/dockerfiles/debian-armel-cross.docker
@@ -108,7 +108,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:armel \
                       libgnutls28-dev:armel \
                       libgtk-3-dev:armel \
-                      libibumad-dev:armel \
                       libibverbs-dev:armel \
                       libiscsi-dev:armel \
                       libjemalloc-dev:armel \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 58bdf07223..8f87656d89 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -105,7 +105,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:armhf \
                       libgnutls28-dev:armhf \
                       libgtk-3-dev:armhf \
-                      libibumad-dev:armhf \
                       libibverbs-dev:armhf \
                       libiscsi-dev:armhf \
                       libjemalloc-dev:armhf \
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index 9f4102be8f..f1e5b0b877 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -108,7 +108,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:i386 \
                       libgnutls28-dev:i386 \
                       libgtk-3-dev:i386 \
-                      libibumad-dev:i386 \
                       libibverbs-dev:i386 \
                       libiscsi-dev:i386 \
                       libjemalloc-dev:i386 \
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index c861c3bd5b..59c4c68dce 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -107,7 +107,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:mips64el \
                       libgnutls28-dev:mips64el \
                       libgtk-3-dev:mips64el \
-                      libibumad-dev:mips64el \
                       libibverbs-dev:mips64el \
                       libiscsi-dev:mips64el \
                       libjemalloc-dev:mips64el \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index fe9415395e..880c774f1c 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -107,7 +107,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:mipsel \
                       libgnutls28-dev:mipsel \
                       libgtk-3-dev:mipsel \
-                      libibumad-dev:mipsel \
                       libibverbs-dev:mipsel \
                       libiscsi-dev:mipsel \
                       libjemalloc-dev:mipsel \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 35c8ff0864..1d55b9514c 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -105,7 +105,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:ppc64el \
                       libgnutls28-dev:ppc64el \
                       libgtk-3-dev:ppc64el \
-                      libibumad-dev:ppc64el \
                       libibverbs-dev:ppc64el \
                       libiscsi-dev:ppc64el \
                       libjemalloc-dev:ppc64el \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index bef9dff17a..62ccda6ab1 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -105,7 +105,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev:s390x \
                       libgnutls28-dev:s390x \
                       libgtk-3-dev:s390x \
-                      libibumad-dev:s390x \
                       libibverbs-dev:s390x \
                       libiscsi-dev:s390x \
                       libjemalloc-dev:s390x \
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 63d7aac616..0d1d401eb8 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -55,7 +55,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev \
                       libgnutls28-dev \
                       libgtk-3-dev \
-                      libibumad-dev \
                       libibverbs-dev \
                       libiscsi-dev \
                       libjemalloc-dev \
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index febd25b320..beeb44fc28 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -55,7 +55,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libglusterfs-dev \
                       libgnutls28-dev \
                       libgtk-3-dev \
-                      libibumad-dev \
                       libibverbs-dev \
                       libiscsi-dev \
                       libjemalloc-dev \
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 070d7f4706..0c85784259 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -47,7 +47,6 @@ packages:
  - libfdt
  - libffi
  - libgcrypt
- - libibumad
  - libibverbs
  - libiscsi
  - libjemalloc
-- 
2.45.2


