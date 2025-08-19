Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D515ACA0EED
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 11:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoKSM-0003Kz-Ib; Tue, 19 Aug 2025 07:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uoKSK-0003KV-PA
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:24:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uoKSI-0007Cs-RH
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755602681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wXP3DQz3dPCY28DqAGhGTwT4YeqHk/6QDnHrABy5h/M=;
 b=aRiqMPk2/kRJFYg34SDQrjYMgVsqXisp/1OqXurmYfAy+idVot1arlta7ne7z2PeTLnsvM
 Vec93+o9QJIW/6ttzAgZEww6RHNGRLW2zY1NX/Yg0ecmWsv/EKd/SUKpY8MAQ5RCgsigpL
 ulv/mf+CswjuuK9coSVkaC/xuTQskVA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-GQkCSKv6Ndu1UkOEz5JHZg-1; Tue,
 19 Aug 2025 07:24:40 -0400
X-MC-Unique: GQkCSKv6Ndu1UkOEz5JHZg-1
X-Mimecast-MFC-AGG-ID: GQkCSKv6Ndu1UkOEz5JHZg_1755602679
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50494180048E; Tue, 19 Aug 2025 11:24:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.251])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BBEE630001B5; Tue, 19 Aug 2025 11:24:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 10/25] tests/functional: Move i386 tests into architecture
 specific folder
Date: Tue, 19 Aug 2025 13:23:47 +0200
Message-ID: <20250819112403.432587-11-thuth@redhat.com>
In-Reply-To: <20250819112403.432587-1-thuth@redhat.com>
References: <20250819112403.432587-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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
i386 tests into a target-specific subfolder.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                            |  3 ++-
 tests/functional/i386/meson.build                      | 10 ++++++++++
 .../{test_i386_migration.py => i386/test_migration.py} |  0
 .../{test_i386_replay.py => i386/test_replay.py}       |  0
 .../{test_i386_tuxrun.py => i386/test_tuxrun.py}       |  0
 tests/functional/meson.build                           | 10 +---------
 6 files changed, 13 insertions(+), 10 deletions(-)
 create mode 100644 tests/functional/i386/meson.build
 rename tests/functional/{test_i386_migration.py => i386/test_migration.py} (100%)
 rename tests/functional/{test_i386_replay.py => i386/test_replay.py} (100%)
 rename tests/functional/{test_i386_tuxrun.py => i386/test_tuxrun.py} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2e1754912f6..2b109ecc18c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -146,6 +146,7 @@ F: target/i386/*.[ch]
 F: target/i386/Kconfig
 F: target/i386/meson.build
 F: tools/i386/
+F: tests/functional/i386/
 
 Guest CPU cores (TCG)
 ---------------------
@@ -1891,7 +1892,7 @@ F: hw/isa/apm.c
 F: include/hw/isa/apm.h
 F: tests/unit/test-x86-topo.c
 F: tests/qtest/test-x86-cpuid-compat.c
-F: tests/functional/test_i386_tuxrun.py
+F: tests/functional/i386/test_tuxrun.py
 F: tests/functional/test_linux_initrd.py
 F: tests/functional/test_mem_addr_space.py
 F: tests/functional/test_pc_cpu_hotplug_props.py
diff --git a/tests/functional/i386/meson.build b/tests/functional/i386/meson.build
new file mode 100644
index 00000000000..23d8c216be7
--- /dev/null
+++ b/tests/functional/i386/meson.build
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests_i386_system_quick = [
+  'migration',
+]
+
+tests_i386_system_thorough = [
+  'replay',
+  'tuxrun',
+]
diff --git a/tests/functional/test_i386_migration.py b/tests/functional/i386/test_migration.py
similarity index 100%
rename from tests/functional/test_i386_migration.py
rename to tests/functional/i386/test_migration.py
diff --git a/tests/functional/test_i386_replay.py b/tests/functional/i386/test_replay.py
similarity index 100%
rename from tests/functional/test_i386_replay.py
rename to tests/functional/i386/test_replay.py
diff --git a/tests/functional/test_i386_tuxrun.py b/tests/functional/i386/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_i386_tuxrun.py
rename to tests/functional/i386/test_tuxrun.py
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 8f85c13d3d1..f1fc01717c3 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -14,6 +14,7 @@ subdir('alpha')
 subdir('arm')
 subdir('avr')
 subdir('hppa')
+subdir('i386')
 
 test_mips_timeouts = {
   'mips_malta' : 480,
@@ -79,15 +80,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_i386_system_quick = [
-  'i386_migration',
-]
-
-tests_i386_system_thorough = [
-  'i386_replay',
-  'i386_tuxrun',
-]
-
 tests_loongarch64_system_thorough = [
   'loongarch64_virt',
 ]
-- 
2.50.1


