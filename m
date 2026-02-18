Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A4BE9A04C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 19:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsnGx-0002A4-KG; Wed, 18 Feb 2026 14:31:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vsnGl-00028b-Ci
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:31:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vsnGi-0007hg-Gy
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771443087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uLvtwt3FhGO0yqeoDTGYUhFou8xHbfvgLa+hodwrEQw=;
 b=EzIlUbNiDhKag6KksI26giCYswENbd2llvXqSvVnKtqVfGRh/XwbjGc3d0hLFtIADgUvou
 9DiFRGDr2u1yBtrTuBfVFjVbUsqyuUTRjjT881l58nwJpUqJ0hyS58FfnJCdCFaB+hDqrD
 RhNvAuANDbThz3YXIvt1MPFloyZLLa4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-6eIDrKqsM5eu7DkHMDSY9Q-1; Wed,
 18 Feb 2026 14:31:24 -0500
X-MC-Unique: 6eIDrKqsM5eu7DkHMDSY9Q-1
X-Mimecast-MFC-AGG-ID: 6eIDrKqsM5eu7DkHMDSY9Q_1771443083
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3277119560B7; Wed, 18 Feb 2026 19:31:23 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.65.233])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9458B1800297; Wed, 18 Feb 2026 19:31:21 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 2/2] tests: upgrade debian-legacy-test-cross to debian 13
Date: Wed, 18 Feb 2026 14:31:16 -0500
Message-ID: <20260218193116.659213-3-jsnow@redhat.com>
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

This test appears to work properly on Debian 13/Trixie. It is possible
we no longer need a specific "legacy" cross test and this can be fixed
on a deeper level, so consider this patch more of an RFC and a request
for help performing this upgrade.

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


