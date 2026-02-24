Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B68F4BB6F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 18:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuwxR-00046Y-L4; Tue, 24 Feb 2026 13:16:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vuwxP-0003tS-A5
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:16:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vuwxN-0002bs-LO
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771956984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/RaKJwXknqQTirOEHPZZLWAcaD+fpK9SofqPcsVqOQ=;
 b=SQNBwEM1PF65Fki2fORV345H3MkfImOKpzbgfn7dh/9Lz0+2aNQmi24tjZ4HgC0lpkqbX9
 jjNvMFIPK4mBv5ZNRt3F0d+K0sJIL/9FSn+hVBtJUMDZrPA05xzFDV42C5MxXKlXi4XCXq
 QZ7xC7c1nNqBfKSTCuxJuivMl7wNd2M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-VJuf3fMCMDm3BFqQkD6ciQ-1; Tue,
 24 Feb 2026 13:16:21 -0500
X-MC-Unique: VJuf3fMCMDm3BFqQkD6ciQ-1
X-Mimecast-MFC-AGG-ID: VJuf3fMCMDm3BFqQkD6ciQ_1771956979
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BC7B180034D; Tue, 24 Feb 2026 18:16:19 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.212])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 52173180066B; Tue, 24 Feb 2026 18:16:14 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kyle Evans <kevans@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
 Li-Wen Hsu <lwhsu@freebsd.org>, Hanna Reitz <hreitz@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 15/19] tests: replace check-venv with vm-venv target
Date: Tue, 24 Feb 2026 13:14:34 -0500
Message-ID: <20260224181440.832943-16-jsnow@redhat.com>
In-Reply-To: <20260224181440.832943-1-jsnow@redhat.com>
References: <20260224181440.832943-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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

With the qemu.qmp and qemu.machine dependencies now installed by default
at configure time and additional dependencies required by functional
testing installed on demand, we do not need the explicit "check-venv" target.

...However, to facilitate running VM tests without running configure, we
move some of the former logic into tests/vm/Makefile.include to create a
new venv (vm-venv) on-demand when running VM tests from the source tree.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260218213416.674483-17-jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/Makefile.include    | 22 ++--------------------
 tests/vm/Makefile.include | 20 ++++++++++++++++----
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 76d77545b71..59b9a4b9220 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -22,7 +22,6 @@ ifneq ($(filter $(all-check-targets), check-softfloat),)
 endif
 	@echo
 	@echo " $(MAKE) check-report.junit.xml        Generates an aggregated XML test report"
-	@echo " $(MAKE) check-venv                    Creates a Python venv for tests"
 	@echo " $(MAKE) check-clean                   Clean the tests and related data"
 	@echo
 	@echo "The following are useful for CI builds"
@@ -93,33 +92,16 @@ clean-tcg: $(CLEAN_TCG_TARGET_RULES)
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
-	$(MKVENV_ENSUREGROUP) $< tooling functests
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
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 14188bba1c6..8a5aaedce7a 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -2,13 +2,25 @@
 
 # Hack to allow running in an unconfigured build tree
 ifeq ($(realpath $(SRC_PATH)),$(realpath .))
-VM_PYTHON = PYTHONPATH=$(SRC_PATH)/python /usr/bin/env python3
-VM_VENV =
+VM_PYTHON = $(SRC_PATH)/vm-venv/bin/python3
+VM_VENV = vm-venv
 else
 VM_PYTHON = $(PYTHON)
-VM_VENV = check-venv
+VM_VENV =
 endif
 
+VM_VENV_TOKEN=$(SRC_PATH)/vm-venv/tooling.group $(SRC_PATH)/vm-venv/functests.group
+
+$(VM_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
+	/usr/bin/env python3 $(SRC_PATH)/python/scripts/mkvenv.py create vm-venv
+	$(SRC_PATH)/vm-venv/bin/python3 \
+	$(SRC_PATH)/python/scripts/mkvenv.py ensuregroup --online \
+	$(SRC_PATH)/pythondeps.toml tooling functests
+
+.PHONY: vm-venv
+vm-venv: $(VM_VENV_TOKEN)
+# end hackery
+
 .PHONY: vm-build-all vm-clean-all
 
 EFI_AARCH64 = $(wildcard $(BUILD_DIR)/pc-bios/edk2-aarch64-code.fd)
@@ -102,7 +114,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 		$(if $(LOG_CONSOLE),--log-console) \
 		--source-path $(SRC_PATH) \
 		--image "$@" \
-		$(if $(filter-out check-venv, $?), --force) \
+		--force \
 		--build-image $@, \
 		"  VM-IMAGE $*")
 
-- 
2.53.0


