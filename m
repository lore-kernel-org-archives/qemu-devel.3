Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DC8C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2024 07:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDIoT-00049f-2X; Sat, 01 Jun 2024 03:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sDIoR-00048x-MW
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 03:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sDIoP-00005d-Ug
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 03:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717225557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLYO5ihc4YnxNOUX10HaW4WrYPcP1+QP9574sRUd+7Q=;
 b=VhtTERQigbF95dyS5yYeH1k8VGDkKAlDYpY2kzT4II7bMxFbbwMFU51/IlC+PAaEF4E7xJ
 7dk/OJ5RqKPLL3U0vjPJKCMR5F6KAx5z2ujcCI0aSoul1Qlus6xCSStW85HXz4BfDD6fTc
 tEwYhMTgXWRDfs40h1uGbnY2t/+D9zg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-EbL6mBtMPE2YfEqh15MGVw-1; Sat, 01 Jun 2024 03:05:51 -0400
X-MC-Unique: EbL6mBtMPE2YfEqh15MGVw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B14B185A780;
 Sat,  1 Jun 2024 07:05:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 511FF21EE56E;
 Sat,  1 Jun 2024 07:05:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 5/5] tests/docker/dockerfiles: Run lcitool-refresh to update
 Fedora and Alpine
Date: Sat,  1 Jun 2024 09:05:43 +0200
Message-ID: <20240601070543.37786-6-thuth@redhat.com>
In-Reply-To: <20240601070543.37786-1-thuth@redhat.com>
References: <20240601070543.37786-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Run "make lcitool-refresh" to update the dockerfiles with the recent
changes to the lcitool.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/docker/dockerfiles/alpine.docker             | 4 ++--
 tests/docker/dockerfiles/fedora-win64-cross.docker | 6 ++++--
 tests/docker/dockerfiles/fedora.docker             | 5 +++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index 554464f31e..b079a83fe2 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all alpine-318 qemu
+#  $ lcitool dockerfile --layers all alpine-319 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/alpine:3.18
+FROM docker.io/library/alpine:3.19
 
 RUN apk update && \
     apk upgrade && \
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index 0f78711876..007e1574bd 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch mingw64 fedora-38 qemu,qemu-win-installer
+#  $ lcitool dockerfile --layers all --cross-arch mingw64 fedora-40 qemu,qemu-win-installer
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM registry.fedoraproject.org/fedora:38
+FROM registry.fedoraproject.org/fedora:40
 
 RUN dnf install -y nosync && \
     printf '#!/bin/sh\n\
@@ -51,6 +51,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                python3-pip \
                python3-sphinx \
                python3-sphinx_rtd_theme \
+               python3-zombie-imp \
                sed \
                socat \
                sparse \
@@ -74,6 +75,7 @@ ENV NINJA "/usr/bin/ninja"
 ENV PYTHON "/usr/bin/python3"
 
 RUN nosync dnf install -y \
+               mingw-w64-tools \
                mingw32-nsis \
                mingw64-SDL2 \
                mingw64-SDL2_image \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 098c894d10..44f239c088 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all fedora-38 qemu
+#  $ lcitool dockerfile --layers all fedora-40 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM registry.fedoraproject.org/fedora:38
+FROM registry.fedoraproject.org/fedora:40
 
 RUN dnf install -y nosync && \
     printf '#!/bin/sh\n\
@@ -110,6 +110,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                python3-pip \
                python3-sphinx \
                python3-sphinx_rtd_theme \
+               python3-zombie-imp \
                rdma-core-devel \
                sed \
                snappy-devel \
-- 
2.45.1


