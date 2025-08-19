Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36126CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 11:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoKSr-0003vt-Vl; Tue, 19 Aug 2025 07:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uoKSo-0003sB-MM
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:25:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uoKSm-0007Rf-IP
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755602711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6N3iggi7xWk924RjU/CaayKEFPpzv6J3ZPrirNNlF4A=;
 b=b1+k/6xqUPmUEKx9Ff2Sh/xvfzp2BxjcMsSS1ZlCjnlPud9lBM/YL7bQa28cm7dDmSAwmr
 TjcSFxNM6rOoEcoKOVQjyH8olHgUZqSt2a34EWXmiyA5Zc2zUVa1vAXYFhmALkm8if75qg
 NhWxHU4mU/Cvs/dreVlg/PmbGEu3uYk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-5z4Zir53PJe20HAq6ABrKQ-1; Tue,
 19 Aug 2025 07:25:08 -0400
X-MC-Unique: 5z4Zir53PJe20HAq6ABrKQ-1
X-Mimecast-MFC-AGG-ID: 5z4Zir53PJe20HAq6ABrKQ_1755602707
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67D4A19560B0; Tue, 19 Aug 2025 11:25:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.251])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E9B630001A8; Tue, 19 Aug 2025 11:25:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 20/25] tests/functional: Move sh4/sh4eb tests into
 target-specific folders
Date: Tue, 19 Aug 2025 13:23:57 +0200
Message-ID: <20250819112403.432587-21-thuth@redhat.com>
In-Reply-To: <20250819112403.432587-1-thuth@redhat.com>
References: <20250819112403.432587-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
sh4 tests into a target-specific subfolder.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                       |  4 ++--
 tests/functional/meson.build                      | 15 ++-------------
 tests/functional/sh4/meson.build                  | 10 ++++++++++
 .../{test_sh4_r2d.py => sh4/test_r2d.py}          |  0
 .../{test_sh4_tuxrun.py => sh4/test_tuxrun.py}    |  0
 tests/functional/sh4eb/meson.build                |  5 +++++
 .../{test_sh4eb_r2d.py => sh4eb/test_r2d.py}      |  0
 7 files changed, 19 insertions(+), 15 deletions(-)
 create mode 100644 tests/functional/sh4/meson.build
 rename tests/functional/{test_sh4_r2d.py => sh4/test_r2d.py} (100%)
 rename tests/functional/{test_sh4_tuxrun.py => sh4/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/sh4eb/meson.build
 rename tests/functional/{test_sh4eb_r2d.py => sh4eb/test_r2d.py} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a55a20f6a5..eddec0058e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1736,8 +1736,8 @@ F: hw/pci-host/sh_pci.c
 F: hw/timer/sh_timer.c
 F: include/hw/sh4/sh_intc.h
 F: include/hw/timer/tmu012.h
-F: tests/functional/test_sh4*_r2d.py
-F: tests/functional/test_sh4_tuxrun.py
+F: tests/functional/sh4*/test_r2d.py
+F: tests/functional/sh4/test_tuxrun.py
 
 SPARC Machines
 --------------
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index abaa4e00fca..ce713509e32 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -30,10 +30,8 @@ subdir('riscv32')
 subdir('riscv64')
 subdir('rx')
 subdir('s390x')
-
-test_sh4_timeouts = {
-  'sh4_tuxrun' : 240,
-}
+subdir('sh4')
+subdir('sh4eb')
 
 test_x86_64_timeouts = {
   'acpi_bits' : 420,
@@ -56,15 +54,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_sh4_system_thorough = [
-  'sh4_r2d',
-  'sh4_tuxrun',
-]
-
-tests_sh4eb_system_thorough = [
-  'sh4eb_r2d',
-]
-
 tests_sparc_system_quick = [
   'sparc_migration',
 ]
diff --git a/tests/functional/sh4/meson.build b/tests/functional/sh4/meson.build
new file mode 100644
index 00000000000..56f824e1e71
--- /dev/null
+++ b/tests/functional/sh4/meson.build
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+test_sh4_timeouts = {
+  'tuxrun' : 240,
+}
+
+tests_sh4_system_thorough = [
+  'r2d',
+  'tuxrun',
+]
diff --git a/tests/functional/test_sh4_r2d.py b/tests/functional/sh4/test_r2d.py
similarity index 100%
rename from tests/functional/test_sh4_r2d.py
rename to tests/functional/sh4/test_r2d.py
diff --git a/tests/functional/test_sh4_tuxrun.py b/tests/functional/sh4/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_sh4_tuxrun.py
rename to tests/functional/sh4/test_tuxrun.py
diff --git a/tests/functional/sh4eb/meson.build b/tests/functional/sh4eb/meson.build
new file mode 100644
index 00000000000..25e9a6e4041
--- /dev/null
+++ b/tests/functional/sh4eb/meson.build
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests_sh4eb_system_thorough = [
+  'r2d',
+]
diff --git a/tests/functional/test_sh4eb_r2d.py b/tests/functional/sh4eb/test_r2d.py
similarity index 100%
rename from tests/functional/test_sh4eb_r2d.py
rename to tests/functional/sh4eb/test_r2d.py
-- 
2.50.1


