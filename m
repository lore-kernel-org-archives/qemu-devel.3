Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BD8E8B365
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 20:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnN8C-0003oe-K2; Tue, 03 Feb 2026 15:36:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vnN8B-0003oD-O3
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:36:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vnN8A-00012w-4z
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770150973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cV2lc3N0MbxJhjLRkTuCdN2XwVtlbf4p3z9LWjnzgrU=;
 b=G79KEkAlE+icCPXk2lWQtNEEOZmTiJZ7Hf5aLZPrxOMdDp5RTmZhgaIiUtSOhnRspKgENp
 2YcHWVJ8nXgGQIXJeG5QXjyG0hvWa1Ne7n6F3Lyy49vln8sAE/54mpmoMVSXKCnQYx90d6
 AGwNvI8L/B5SMpfnyWEsbW2DncH6oc8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-PP_LsL9IOBqOtk-cIWgjXg-1; Tue,
 03 Feb 2026 15:36:09 -0500
X-MC-Unique: PP_LsL9IOBqOtk-cIWgjXg-1
X-Mimecast-MFC-AGG-ID: PP_LsL9IOBqOtk-cIWgjXg_1770150967
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4435518005AD; Tue,  3 Feb 2026 20:36:07 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.43])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E10F18004D8; Tue,  3 Feb 2026 20:36:03 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v5 13/16] tests: remove "make check-venv" target
Date: Tue,  3 Feb 2026 15:35:08 -0500
Message-ID: <20260203203512.672552-14-jsnow@redhat.com>
In-Reply-To: <20260203203512.672552-1-jsnow@redhat.com>
References: <20260203203512.672552-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

With the qemu.qmp and qemu.machine dependencies now installed by default
at configure time and additional dependencies required by functional
testing installed on demand, there is no longer any reason to have an
explicit target.

FIXME: This forces image regeneration for vm tests whenever Make
determines that the image needs to be rebuilt; which is a regression
over the previous behavior.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/Makefile.include    | 22 ++--------------------
 tests/vm/Makefile.include | 24 +++++++-----------------
 2 files changed, 9 insertions(+), 37 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index f28c9e329aa..2a203e23718 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -21,7 +21,6 @@ ifneq ($(filter $(all-check-targets), check-softfloat),)
 endif
 	@echo
 	@echo " $(MAKE) check-report.junit.xml   Generates an aggregated XML test report"
-	@echo " $(MAKE) check-venv               Creates a Python venv for tests"
 	@echo " $(MAKE) check-clean              Clean the tests and related data"
 	@echo
 	@echo "The following are useful for CI builds"
@@ -92,33 +91,16 @@ clean-tcg: $(CLEAN_TCG_TARGET_RULES)
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
index 14188bba1c6..095ec2eefa3 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -1,14 +1,5 @@
 # Makefile for VM tests
 
-# Hack to allow running in an unconfigured build tree
-ifeq ($(realpath $(SRC_PATH)),$(realpath .))
-VM_PYTHON = PYTHONPATH=$(SRC_PATH)/python /usr/bin/env python3
-VM_VENV =
-else
-VM_PYTHON = $(PYTHON)
-VM_VENV = check-venv
-endif
-
 .PHONY: vm-build-all vm-clean-all
 
 EFI_AARCH64 = $(wildcard $(BUILD_DIR)/pc-bios/edk2-aarch64-code.fd)
@@ -90,11 +81,10 @@ vm-clean-all:
 
 $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 			$(SRC_PATH)/tests/vm/basevm.py \
-			$(SRC_PATH)/tests/vm/Makefile.include \
-			$(VM_VENV)
+			$(SRC_PATH)/tests/vm/Makefile.include
 	@mkdir -p $(IMAGES_DIR)
 	$(call quiet-command, \
-		$(VM_PYTHON) $< \
+		$(PYTHON) $< \
 		$(if $(V)$(DEBUG), --debug) \
 		$(if $(GENISOIMAGE),--genisoimage $(GENISOIMAGE)) \
 		$(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
@@ -102,14 +92,14 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 		$(if $(LOG_CONSOLE),--log-console) \
 		--source-path $(SRC_PATH) \
 		--image "$@" \
-		$(if $(filter-out check-venv, $?), --force) \
+		--force \
 		--build-image $@, \
 		"  VM-IMAGE $*")
 
 # Build in VM $(IMAGE)
-vm-build-%: $(IMAGES_DIR)/%.img $(VM_VENV)
+vm-build-%: $(IMAGES_DIR)/%.img
 	$(call quiet-command, \
-		$(VM_PYTHON) $(SRC_PATH)/tests/vm/$* \
+		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(V)$(DEBUG), --debug) \
 		$(if $(DEBUG), --interactive) \
 		$(if $(J),--jobs $(J)) \
@@ -133,9 +123,9 @@ vm-boot-serial-%: $(IMAGES_DIR)/%.img
 		-device virtio-net-pci,netdev=vnet \
 	|| true
 
-vm-boot-ssh-%: $(IMAGES_DIR)/%.img $(VM_VENV)
+vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 	$(call quiet-command, \
-		$(VM_PYTHON) $(SRC_PATH)/tests/vm/$* \
+		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
 		$(if $(V)$(DEBUG), --debug) \
 		$(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
-- 
2.52.0


