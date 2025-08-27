Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5239DCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 07:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urB0a-0005WI-Vd; Wed, 27 Aug 2025 03:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB0R-0005UF-Q3
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:55:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB0O-0001zk-3o
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756281338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7l19xKkpbq1cpW8+tXty8JzpdiIk5grtZ6e9NFMSjLs=;
 b=M+7iusm9/Ujr4UdX0LnTCNzHa/c+/dFfjYAGkiVCulICyYwQsx7lIQiKpU3bAVIfcHLQ7E
 P2RdCy+h/PIU9ZsBW3DuFbw9i10gpabd+4Cp01c61jtMXmw55Txjo3wcCGdmzLXMSPS+Kr
 m3WhrGYOEigBEEfhbjRyKA506xcfEHQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-lgopCXZ-NpyfwlVTnZaLmA-1; Wed,
 27 Aug 2025 03:55:31 -0400
X-MC-Unique: lgopCXZ-NpyfwlVTnZaLmA-1
X-Mimecast-MFC-AGG-ID: lgopCXZ-NpyfwlVTnZaLmA_1756281330
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CA8319560B2; Wed, 27 Aug 2025 07:55:30 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 99E401955F24; Wed, 27 Aug 2025 07:55:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/31] tests/functional: Move alpha tests into architecture
 specific folder
Date: Wed, 27 Aug 2025 09:54:21 +0200
Message-ID: <20250827075443.559712-12-thuth@redhat.com>
In-Reply-To: <20250827075443.559712-1-thuth@redhat.com>
References: <20250827075443.559712-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

The tests/functional folder has become quite crowded already, some
restructuring would be helpful here. Thus move the alpha tests into
a target-specific subfolder.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250819112403.432587-7-thuth@redhat.com>
---
 MAINTAINERS                                            |  3 ++-
 tests/functional/alpha/meson.build                     | 10 ++++++++++
 .../{test_alpha_clipper.py => alpha/test_clipper.py}   |  0
 .../test_migration.py}                                 |  0
 .../{test_alpha_replay.py => alpha/test_replay.py}     |  0
 tests/functional/meson.build                           | 10 +---------
 6 files changed, 13 insertions(+), 10 deletions(-)
 create mode 100644 tests/functional/alpha/meson.build
 rename tests/functional/{test_alpha_clipper.py => alpha/test_clipper.py} (100%)
 rename tests/functional/{test_alpha_migration.py => alpha/test_migration.py} (100%)
 rename tests/functional/{test_alpha_replay.py => alpha/test_replay.py} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index a2a5ccea7b6..8115aae6183 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -189,6 +189,7 @@ M: Richard Henderson <richard.henderson@linaro.org>
 S: Maintained
 F: target/alpha/
 F: tests/tcg/alpha/
+F: tests/functional/alpha/
 F: disas/alpha.c
 
 ARM TCG CPUs
@@ -656,7 +657,7 @@ S: Maintained
 F: hw/alpha/
 F: hw/isa/smc37c669-superio.c
 F: tests/tcg/alpha/system/
-F: tests/functional/test_alpha_clipper.py
+F: tests/functional/alpha/test_clipper.py
 
 ARM Machines
 ------------
diff --git a/tests/functional/alpha/meson.build b/tests/functional/alpha/meson.build
new file mode 100644
index 00000000000..26a5b3f2e4b
--- /dev/null
+++ b/tests/functional/alpha/meson.build
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests_alpha_system_quick = [
+  'migration',
+]
+
+tests_alpha_system_thorough = [
+  'clipper',
+  'replay',
+]
diff --git a/tests/functional/test_alpha_clipper.py b/tests/functional/alpha/test_clipper.py
similarity index 100%
rename from tests/functional/test_alpha_clipper.py
rename to tests/functional/alpha/test_clipper.py
diff --git a/tests/functional/test_alpha_migration.py b/tests/functional/alpha/test_migration.py
similarity index 100%
rename from tests/functional/test_alpha_migration.py
rename to tests/functional/alpha/test_migration.py
diff --git a/tests/functional/test_alpha_replay.py b/tests/functional/alpha/test_replay.py
similarity index 100%
rename from tests/functional/test_alpha_replay.py
rename to tests/functional/alpha/test_replay.py
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 9cb6325360f..a7f8c88a078 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -10,6 +10,7 @@ if get_option('tcg_interpreter')
 endif
 
 subdir('aarch64')
+subdir('alpha')
 
 test_arm_timeouts = {
   'arm_aspeed_palmetto' : 120,
@@ -96,15 +97,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_alpha_system_quick = [
-  'alpha_migration',
-]
-
-tests_alpha_system_thorough = [
-  'alpha_clipper',
-  'alpha_replay',
-]
-
 tests_arm_system_quick = [
   'arm_migration',
 ]
-- 
2.50.1


