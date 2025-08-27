Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6FDCA0FF6
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 08:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urB14-0005np-7N; Wed, 27 Aug 2025 03:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB0y-0005ie-1x
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:56:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB0u-00023x-P5
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756281370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h5nVOb28U7Eh63q0wZmCjz+OzCO5sanBuP8EeJJe4zc=;
 b=VkOZ2R+6pFZqstbE3eytkKqJeGppGMuvDxyQNejEwMUg3A+VWCFSh8yJ0sDVUKaB7A+g/j
 njf729izmBpgkciuxA09oFJ1fc3pGGGtGJKAMPzq5E2ezIFELP1t/UyMMtsRPhX4Uimj7D
 f8f/XGROaeiIQ5HbGedbIV+orEV6BQg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-E1FfoF4PMXeqUJRVd2rnlA-1; Wed,
 27 Aug 2025 03:56:06 -0400
X-MC-Unique: E1FfoF4PMXeqUJRVd2rnlA-1
X-Mimecast-MFC-AGG-ID: E1FfoF4PMXeqUJRVd2rnlA_1756281365
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E7F819560B5; Wed, 27 Aug 2025 07:56:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 27A101955F24; Wed, 27 Aug 2025 07:56:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/31] tests/functional: Move or1k tests into target-specific
 folders
Date: Wed, 27 Aug 2025 09:54:30 +0200
Message-ID: <20250827075443.559712-21-thuth@redhat.com>
In-Reply-To: <20250827075443.559712-1-thuth@redhat.com>
References: <20250827075443.559712-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250819112403.432587-16-thuth@redhat.com>
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
index b8f0ce33605..56ba9b02c39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1457,7 +1457,7 @@ S: Maintained
 F: docs/system/openrisc/or1k-sim.rst
 F: hw/intc/ompic.c
 F: hw/openrisc/openrisc_sim.c
-F: tests/functional/test_or1k_sim.py
+F: tests/functional/or1k/test_sim.py
 
 PowerPC Machines
 ----------------
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 52969a3ff87..397303ec6fb 100644
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


