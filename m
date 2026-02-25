Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCAFFD45E2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 19:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvKj3-0007pB-Ia; Wed, 25 Feb 2026 14:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vvKj0-0007oc-Vm
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 14:39:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vvKiz-0001sK-EA
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 14:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772048348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9NCJ4mFbAphqTGvPGQENy2t485k2etqwV0Ur0lBLu3Y=;
 b=bXseSr7WG5xfdTnZPX4DUjDB318pUB3LWjY6kSd9Ayc7pSBs3cWzFCfL7Gajaaw80jn+6J
 rtzyChDJeaYqHG4aIo2EjqHMkV958wBG2i/3PeeyYOooSEjX95T3oSCFrWUeGuSH1MKF41
 SIFNgiLitSUIDci7XoeCgwbZs8xrYw8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-cWw1CA0iNYywwm1T4nadqw-1; Wed,
 25 Feb 2026 14:39:05 -0500
X-MC-Unique: cWw1CA0iNYywwm1T4nadqw-1
X-Mimecast-MFC-AGG-ID: cWw1CA0iNYywwm1T4nadqw_1772048345
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D88C71956053; Wed, 25 Feb 2026 19:39:04 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.212])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 41DD71800370; Wed, 25 Feb 2026 19:39:03 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 2/3] tests: upgrade debian-legacy-test-cross to debian 13
Date: Wed, 25 Feb 2026 14:38:55 -0500
Message-ID: <20260225193856.959771-3-jsnow@redhat.com>
In-Reply-To: <20260225193856.959771-1-jsnow@redhat.com>
References: <20260225193856.959771-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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

We no longer require Debian 11 to run these tests; they work properly
under Debian 13/Trixie.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 .../dockerfiles/debian-legacy-test-cross.docker  | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-legacy-test-cross.docker b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
index 5a6616b7d39..293f31a07d6 100644
--- a/tests/docker/dockerfiles/debian-legacy-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-legacy-test-cross.docker
@@ -1,18 +1,13 @@
 # Docker legacy cross-compiler target (tests and minimal qemu)
 #
-# Compilers for some of our older targets which we cant currently
-# upgrade. Currently:
-#
-#   libc6.1-dev-alpha-cross: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1054412
-#   sh4-linux-user: binaries don't run with bookworm compiler
-#
 # As we are targeting check-tcg here we only need minimal qemu
 # dependencies and the relevant cross compilers.
 
-FROM docker.io/library/debian:11-slim
+FROM docker.io/library/debian:13-slim
 
-# Duplicate deb line as deb-src
-RUN cat /etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
+# Add deb-src repository sources
+RUN sed -i "s/^Types: deb$/Types: deb deb-src/" \
+    /etc/apt/sources.list.d/debian.sources
 
 RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
@@ -35,12 +30,11 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         libc6-dev-sh4-cross \
         python3-pip \
         python3-setuptools \
+        python3-tomli \
         python3-venv \
         python3-wheel && \
         dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
-RUN /usr/bin/pip3 install tomli
-
 ENV QEMU_CONFIGURE_OPTS --disable-system --disable-docs --disable-tools
 ENV DEF_TARGET_LIST alpha-linux-user,sh4-linux-user
 ENV MAKE /usr/bin/make
-- 
2.53.0


