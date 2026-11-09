Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F46606A32A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bz4iP3Vn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQV5w-0006fy-FV; Mon, 09 Nov 2026 14:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xQV5t-0006YK-Td
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:31:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xQV5q-0001PG-Kn
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794252710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oYN8aLN7g9KKay52bUTkapKfOflSdPYnNEWfRAM1sS0=;
 b=Bz4iP3VnOZzdI/05x/m74niNxNFVgEqqO4dlGOJ1ISzLzbxbnS299/82H3WOY6eP6CoNVb
 IOSuV+400CWt9hZWQpjE6vDy18IwwlB3VwDygpv9QC1++vzBrpXJFpYLq4seagKZvurwNn
 S+ccSyfB6qQGvaBiuRTn9Bsgex2wbhM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-jWlfa_M-P9WzmktVCDnHjQ-1; Mon,
 09 Nov 2026 14:31:48 -0500
X-MC-Unique: jWlfa_M-P9WzmktVCDnHjQ-1
X-Mimecast-MFC-AGG-ID: jWlfa_M-P9WzmktVCDnHjQ_1794252707
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 517341955F21; Mon,  9 Nov 2026 19:31:47 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.81])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 502621956089; Mon,  9 Nov 2026 19:31:46 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] Python: add support for Python3.15
Date: Mon,  9 Nov 2026 14:31:45 -0500
Message-ID: <20261109193145.3557626-1-jsnow@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update tests, docs and infrastructure to explicitly support and test
Python3.15.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 configure                              | 2 +-
 tests/docker/dockerfiles/python.docker | 5 ++---
 python/Makefile                        | 4 ++--
 python/setup.cfg                       | 3 ++-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/configure b/configure
index af14a9c23ef..745899b0e6d 100755
--- a/configure
+++ b/configure
@@ -497,7 +497,7 @@ first_python=
 if test -z "${PYTHON}"; then
     # A bare 'python' is traditionally python 2.x, but some distros
     # have it as python 3.x, so check in both places.
-    for binary in python3 python python3.14 python3.13 python3.12; do
+    for binary in python3 python python3.15 python3.14 python3.13 python3.12; do
         if has "$binary"; then
             python=$(command -v "$binary")
             if check_py_version "$python"; then
diff --git a/tests/docker/dockerfiles/python.docker b/tests/docker/dockerfiles/python.docker
index 79c554a2d87..86b38ba55dd 100644
--- a/tests/docker/dockerfiles/python.docker
+++ b/tests/docker/dockerfiles/python.docker
@@ -11,11 +11,10 @@ ENV PACKAGES="\
     python3-pip \
     python3-tox \
     python3-virtualenv \
-    python3.10 \
-    python3.11 \
     python3.12 \
     python3.13 \
-    python3.9 \
+    python3.14 \
+    python3.15 \
     "
 
 RUN dnf install -y $PACKAGES
diff --git a/python/Makefile b/python/Makefile
index 7868a48a232..99066bfa3e0 100644
--- a/python/Makefile
+++ b/python/Makefile
@@ -15,8 +15,8 @@ help:
 	@echo "make check-tox:"
 	@echo "    Run tests against multiple python versions."
 	@echo "    These tests use the newest dependencies."
-	@echo "    Requires: Python 3.12 - 3.14, and tox."
-	@echo "    Hint (Fedora): 'sudo dnf install python3-tox python3.14'"
+	@echo "    Requires: Python 3.12 - 3.15, and tox."
+	@echo "    Hint (Fedora): 'sudo dnf install python3-tox python3.15'"
 	@echo "    The variable QEMU_TOX_EXTRA_ARGS can be use to pass extra"
 	@echo "    arguments to tox".
 	@echo ""
diff --git a/python/setup.cfg b/python/setup.cfg
index 927f72a46f6..d4130a2b27b 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -17,6 +17,7 @@ classifiers =
     Programming Language :: Python :: 3.12
     Programming Language :: Python :: 3.13
     Programming Language :: Python :: 3.14
+    Programming Language :: Python :: 3.15
     Typing :: Typed
 
 [options]
@@ -145,7 +146,7 @@ multi_line_output=3
 # of python available on your system to run this test.
 
 [tox:tox]
-envlist = py312, py313, py314
+envlist = py312, py313, py314, py315
 skip_missing_interpreters = true
 
 [testenv]
-- 
2.56.0


