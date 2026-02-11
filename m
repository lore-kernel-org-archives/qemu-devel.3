Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F210ECD6E9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 19:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqGLq-0003Tg-Q0; Wed, 11 Feb 2026 14:58:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vqGLp-0003TF-QT
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 14:58:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vqGLn-00054O-GZ
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 14:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770839894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJSrtOlUG9Em7gbAF25NTN7JchmBmH0erph5/8s96iM=;
 b=GA5tW1LzhnFOyhTVLqv7xOZD7lAgU3lyPLQbWYJ4c1L5szA6Y+nlxU+6uXNm6NPBqrfk69
 OVijUU31TuQYWdeAWdPgULZiPZWBBCv4CaaN/CX0Ea5OzD6ovU+78Uz7xQV6I5B2nvYnFL
 RRcztEW0F2I5a9xTqaMLaxyP+9ficVE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-v155pHElP_C-_hS2cP51HQ-1; Wed,
 11 Feb 2026 14:58:12 -0500
X-MC-Unique: v155pHElP_C-_hS2cP51HQ-1
X-Mimecast-MFC-AGG-ID: v155pHElP_C-_hS2cP51HQ_1770839891
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB1A3180AE93; Wed, 11 Feb 2026 19:58:09 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.82.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7666919560B9; Wed, 11 Feb 2026 19:58:08 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 1/2] python: fix minreqs test under newest pip/setuptools
Date: Wed, 11 Feb 2026 14:58:03 -0500
Message-ID: <20260211195804.135144-2-jsnow@redhat.com>
In-Reply-To: <20260211195804.135144-1-jsnow@redhat.com>
References: <20260211195804.135144-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Even though we have been pinning versions for the minreqs test, the
conflict arises because the isolated build environment that some
versions of pip use by default will pull in the latest and greatest
version.

Switch to using a non-isolated build mode and pin more of the packaging
ecosystem to keep our Python 3.9 tests running happy on modern machines.

Note that we will be able to require Python >= 3.11 at the end of April
when we drop support for Ubuntu 22.04 LTS.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/Makefile          |  5 ++---
 python/tests/minreqs.txt | 10 +++++-----
 tests/Makefile.include   |  2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/python/Makefile b/python/Makefile
index 32aedce4137..c143eaa10e7 100644
--- a/python/Makefile
+++ b/python/Makefile
@@ -63,12 +63,11 @@ $(QEMU_MINVENV_DIR) $(QEMU_MINVENV_DIR)/bin/activate: setup.cfg tests/minreqs.tx
 	@(								\
 		echo "ACTIVATE $(QEMU_MINVENV_DIR)";			\
 		. $(QEMU_MINVENV_DIR)/bin/activate;			\
-		echo "INSTALL wheel $(QEMU_MINVENV_DIR)";               \
-		$(PIP_INSTALL) wheel 1>/dev/null;		               \
 		echo "INSTALL -r tests/minreqs.txt $(QEMU_MINVENV_DIR)";\
 		$(PIP_INSTALL) -r tests/minreqs.txt 1>/dev/null;	\
 		echo "INSTALL -e qemu $(QEMU_MINVENV_DIR)";		\
-		PIP_CONFIG_SETTINGS="editable_mode=compat" $(PIP_INSTALL) -e . 1>/dev/null;	\
+		PIP_CONFIG_SETTINGS="editable_mode=compat"		\
+		$(PIP_INSTALL) --no-build-isolation -e . 1>/dev/null;	\
 	)
 	@touch $(QEMU_MINVENV_DIR)
 
diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
index cd2e2a81c3d..c5ae63567e8 100644
--- a/python/tests/minreqs.txt
+++ b/python/tests/minreqs.txt
@@ -11,11 +11,12 @@
 # When adding new dependencies, pin the very oldest non-yanked version
 # on PyPI that allows the test suite to pass.
 
-# For some reason, the presence of packaging==14.0 below requires us to
-# also pin setuptools to version 70 or below. Otherwise, the
-# installation of the QEMU package itself fails, failing to find
-# setuptools.
+# Pin packaging utilities to older versions to prevent difficulties
+# mixing and matching newer and older ecosystem packages.
+packaging==14.0
 setuptools<=70
+wheel<0.46
+pip<26
 
 # Dependencies for qapidoc/qapi_domain et al
 sphinx==3.4.3
@@ -66,7 +67,6 @@ alabaster==0.7.1
 babel==1.3
 docutils==0.12
 imagesize==0.5.0
-packaging==14.0
 pytz==2011b0
 requests==2.5.0
 snowballstemmer==1.1
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 7728098981d..09ceaee675f 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -106,7 +106,7 @@ quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
     "VENVPIP","$1")
 
 $(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
-	$(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
+	$(call quiet-venv-pip,install --no-build-isolation -e "$(SRC_PATH)/python/")
 	$(MKVENV_ENSUREGROUP) $< testdeps
 	$(call quiet-command, touch $@)
 
-- 
2.53.0


