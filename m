Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A1ACFD370
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 04:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNkFm-0003kG-KG; Mon, 24 Nov 2025 23:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vNkEm-0003Eu-4D
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 23:01:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vNkEj-0006Vg-9V
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 23:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764043263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FmetUOe40hvzGOIp7He7kbSRjBEg+7e6QkqFhTBp49c=;
 b=W+RitcbdA2qsf7ne4X0rDzQmkj8JshGHHxieVjxSmDqep16C14Ej3HIka6LK8TAvMngKAs
 W0kZA61EtLnriNlQ4L3Q4DiYt2+CrCgjn09w39S5GjNdExdX864Fx3MTE5fXDllqajWWzY
 Fw19uwHII/rcFVfbojO8JJuG77Mb7W4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-QDmPte0qP3yCgXQFRhoSmg-1; Mon,
 24 Nov 2025 23:00:59 -0500
X-MC-Unique: QDmPte0qP3yCgXQFRhoSmg-1
X-Mimecast-MFC-AGG-ID: QDmPte0qP3yCgXQFRhoSmg_1764043258
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8447618002C5; Tue, 25 Nov 2025 04:00:58 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 713A318004D8; Tue, 25 Nov 2025 04:00:56 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH v2 03/16] python/mkvenv: add 'checktests' and 'functests'
 dependency groups
Date: Mon, 24 Nov 2025 23:00:31 -0500
Message-ID: <20251125040045.461148-4-jsnow@redhat.com>
In-Reply-To: <20251125040045.461148-1-jsnow@redhat.com>
References: <20251125040045.461148-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

'checktests' contains depedencies *required* to run "make check", and as
such, we promise that these dependencies can be sourced from the user's
distribution repository or from vendored packages so that "make check"
can be executed offline in an isolated build environment.

In contrast, pygdbmi is only needed for functional tests and not tests
in general; we do not make the same offline/isolated guarantees for
functional tests, and this dependency group is allowed to fetch
dependencies from PyPI at runtime.

For the time being, Amend the "check-venv" target to install both
dependency groups, to avoid a duplicate dependency between them.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 pythondeps.toml        | 10 +++++++++-
 tests/Makefile.include |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/pythondeps.toml b/pythondeps.toml
index 1657953ff65..14ceb4e7787 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -31,6 +31,14 @@ meson = { accepted = ">=1.9.0", installed = "1.9.0", canary = "meson" }
 sphinx = { accepted = ">=3.4.3", installed = "6.2.1", canary = "sphinx-build" }
 sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
 
-[testdeps]
+# This test group is for dependencies required to run "make check"
+# successfully, and should only include depedencies that can be
+# guaranteed via configure from system packages, or python packages we
+# vendor.
+[checktests]
 "qemu.qmp" = { accepted = ">=0.0.5", installed = "0.0.5" }
+
+# This test group is for functional tests, and can include dependencies
+# fetched from PyPI.
+[functests]
 pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }
diff --git a/tests/Makefile.include b/tests/Makefile.include
index d4dfbf3716d..40b114bd158 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -98,7 +98,7 @@ quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
 
 $(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
 	$(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
-	$(MKVENV_ENSUREGROUP) $< testdeps
+	$(MKVENV_ENSUREGROUP) $< checktests functests
 	$(call quiet-command, touch $@)
 
 check-venv: $(TESTS_VENV_TOKEN)
-- 
2.51.1


