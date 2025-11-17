Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849CECEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 18:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL4Ns-0005qS-0B; Mon, 17 Nov 2025 13:55:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vL4LN-0002xG-CO
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 13:52:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vL4LL-0008D3-0o
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 13:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763405567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mpzQ9F6FPmTjpjAdvXixC5rTGf1BJHaJ4+hTymm0WJw=;
 b=V+lBA+awPQlbkDZFiBSD5VqTcg4mdXXK+PO94lvi9OeTu1LWw95NXuW27sV5K/jWGWjvNv
 Ph4KVUsLlsCtC8N+xVfhqlpYYtzu4DYZ3XxU5JEIkF3jjYB9IWUHklZlSiSbOA487xsB71
 F9YMArouGrf0zZXucNIMTdve+4JIiis=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-b-6Ng_mnMfWJpvE63l_17w-1; Mon,
 17 Nov 2025 13:52:37 -0500
X-MC-Unique: b-6Ng_mnMfWJpvE63l_17w-1
X-Mimecast-MFC-AGG-ID: b-6Ng_mnMfWJpvE63l_17w_1763405556
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47F5318002CA; Mon, 17 Nov 2025 18:52:36 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.81.70])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CB690180049F; Mon, 17 Nov 2025 18:52:33 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 21/22] tests/Makefile: replace old "check-venv" target with
 meson target
Date: Mon, 17 Nov 2025 13:51:29 -0500
Message-ID: <20251117185131.953681-22-jsnow@redhat.com>
In-Reply-To: <20251117185131.953681-1-jsnow@redhat.com>
References: <20251117185131.953681-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Note that this patch actually changes the meaning of check-venv slightly
to how it has been operating in the past: this target now only installs
the necessary patches to run "make check" and will no longer pull in
dependencies for functional tests.

This winds up being safe to do because the meson dependencies will
handle this satisfactorily; the target here could even be removed, but
it's still useful as a manual invocation prior to running tests from
outside the meson test runner system.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/Makefile.include | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 40b114bd158..237d410ad83 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -83,33 +83,16 @@ clean-tcg: $(CLEAN_TCG_TARGET_RULES)
 .PHONY: distclean-tcg
 distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
 
-# Python venv for running tests
-
-.PHONY: check-venv
-
 # Build up our target list from the filtered list of ninja targets
 TARGETS=$(patsubst libqemu-%.a, %, $(filter libqemu-%.a, $(ninja-targets)))
 
-TESTS_VENV_TOKEN=$(BUILD_DIR)/pyvenv/tests.group
-
-quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
-    $(PYTHON) -m pip -q --disable-pip-version-check $1, \
-    "VENVPIP","$1")
-
-$(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
-	$(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
-	$(MKVENV_ENSUREGROUP) $< checktests functests
-	$(call quiet-command, touch $@)
-
-check-venv: $(TESTS_VENV_TOKEN)
-
 FUNCTIONAL_TARGETS=$(patsubst %-softmmu,check-functional-%, $(filter %-softmmu,$(TARGETS)))
 .PHONY: $(FUNCTIONAL_TARGETS)
-$(FUNCTIONAL_TARGETS): check-venv
+$(FUNCTIONAL_TARGETS):
 	@$(MAKE) SPEED=thorough $(subst -functional,-func,$@)
 
 .PHONY: check-functional
-check-functional: check-venv
+check-functional:
 	@$(NINJA) precache-functional
 	@$(PYTHON) $(SRC_PATH)/scripts/clean_functional_cache.py
 	@QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func check-func-quick
@@ -117,6 +100,10 @@ check-functional: check-venv
 .PHONY: check-func check-func-quick
 check-func check-func-quick:
 
+.PHONY: check-venv
+check-venv:
+	@$(NINJA) pyvenv/checktests.group
+
 # Consolidated targets
 
 .PHONY: check check-clean
-- 
2.51.1


