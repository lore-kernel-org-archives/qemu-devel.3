Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A22C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 16:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhsUr-0006Gy-2h; Fri, 01 Aug 2025 12:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uhrSD-0004cR-Ar
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:13:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uhrSB-0002k5-J0
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754061230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m3w6m9Ne+lmaK5GR3tcjGylbUwOlD6+g4phTVoQsrw0=;
 b=WQCfqFESImBZ36XZpTyq836Z9Z2J12CR9xY5J2FIVD/mFsm9aWMr675VYNNfFAokzQsJPs
 wJUgKD7CmB2oykzMJM8hF5nKUiqNYWCp2nnTMiXueE2KaDDK4XzY12+OmWC399TFOuuAWW
 1TnjxfW9EAex5POidKszMsyfAiJbADE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-G0IH9VzyO1u9Q8zpfTOFpQ-1; Fri,
 01 Aug 2025 11:13:48 -0400
X-MC-Unique: G0IH9VzyO1u9Q8zpfTOFpQ-1
X-Mimecast-MFC-AGG-ID: G0IH9VzyO1u9Q8zpfTOFpQ_1754061226
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AFD4195D002; Fri,  1 Aug 2025 15:13:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.137])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 78CDA1800B6A; Fri,  1 Aug 2025 15:13:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 15/24] tests/functional: Move or1k tests into target-specific
 folders
Date: Fri,  1 Aug 2025 17:12:40 +0200
Message-ID: <20250801151251.751368-16-thuth@redhat.com>
In-Reply-To: <20250801151251.751368-1-thuth@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The tests/functional folder has become quite crowded, thus move the
openrisc tests into a target-specific subfolder.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                                 | 2 +-
 tests/functional/meson.build                                | 6 +-----
 tests/functional/or1k/meson.build                           | 6 ++++++
 .../functional/{test_or1k_replay.py => or1k/test_replay.py} | 0
 tests/functional/{test_or1k_sim.py => or1k/test_sim.py}     | 0
 5 files changed, 8 insertions(+), 6 deletions(-)
 create mode 100644 tests/functional/or1k/meson.build
 rename tests/functional/{test_or1k_replay.py => or1k/test_replay.py} (100%)
 rename tests/functional/{test_or1k_sim.py => or1k/test_sim.py} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 56e430db153..db0cc7de6cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1454,7 +1454,7 @@ S: Maintained
 F: docs/system/openrisc/or1k-sim.rst
 F: hw/intc/ompic.c
 F: hw/openrisc/openrisc_sim.c
-F: tests/functional/test_or1k_sim.py
+F: tests/functional/or1k/test_sim.py
 
 PowerPC Machines
 ----------------
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 586f3dc6cac..e5e3d1667b8 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -23,6 +23,7 @@ subdir('mips')
 subdir('mipsel')
 subdir('mips64')
 subdir('mips64el')
+subdir('or1k')
 
 test_ppc_timeouts = {
   'ppc_40p' : 240,
@@ -70,11 +71,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_or1k_system_thorough = [
-  'or1k_replay',
-  'or1k_sim',
-]
-
 tests_ppc_system_quick = [
   'ppc_migration',
   'ppc_74xx',
diff --git a/tests/functional/or1k/meson.build b/tests/functional/or1k/meson.build
new file mode 100644
index 00000000000..e246e2ab08d
--- /dev/null
+++ b/tests/functional/or1k/meson.build
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests_or1k_system_thorough = [
+  'replay',
+  'sim',
+]
diff --git a/tests/functional/test_or1k_replay.py b/tests/functional/or1k/test_replay.py
similarity index 100%
rename from tests/functional/test_or1k_replay.py
rename to tests/functional/or1k/test_replay.py
diff --git a/tests/functional/test_or1k_sim.py b/tests/functional/or1k/test_sim.py
similarity index 100%
rename from tests/functional/test_or1k_sim.py
rename to tests/functional/or1k/test_sim.py
-- 
2.50.1


