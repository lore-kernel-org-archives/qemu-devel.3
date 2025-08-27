Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A925FC8303F
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 08:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urB1f-0006vT-CL; Wed, 27 Aug 2025 03:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB1O-0006Tw-Qw
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:56:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB1L-000275-2w
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756281397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=78/CIPPpoCX3BQC0Oxa4bTGnZyXc43jAnyTaVPd1xFo=;
 b=X1AFxmCYNN/DX/Hhev04kZXHqG1OAKYM4ttCfbNyeoB98Kx24jeypRdvz+s7PpGhknMYpu
 iMD1pHhJyn4oSjoJmMPZJKHAxk2nnOJKhkAewp9VD+urcp9Kt9zoharleBOsd37mXfucUS
 0Hba1QBBoIbND3BE8MYJN01pYqwLJag=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-WW9zmrhuOd2a-9UDxcHzzw-1; Wed,
 27 Aug 2025 03:56:33 -0400
X-MC-Unique: WW9zmrhuOd2a-9UDxcHzzw-1
X-Mimecast-MFC-AGG-ID: WW9zmrhuOd2a-9UDxcHzzw_1756281392
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4EDF19560AD; Wed, 27 Aug 2025 07:56:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5DC831955F24; Wed, 27 Aug 2025 07:56:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/31] tests/functional: Move xtensa tests into target-specific
 folder
Date: Wed, 27 Aug 2025 09:54:38 +0200
Message-ID: <20250827075443.559712-29-thuth@redhat.com>
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
xtensa tests into a target-specific subfolder.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250819112403.432587-24-thuth@redhat.com>
---
 MAINTAINERS                                                 | 2 +-
 tests/functional/meson.build                                | 6 +-----
 tests/functional/xtensa/meson.build                         | 6 ++++++
 .../functional/{test_xtensa_lx60.py => xtensa/test_lx60.py} | 0
 .../{test_xtensa_replay.py => xtensa/test_replay.py}        | 0
 5 files changed, 8 insertions(+), 6 deletions(-)
 create mode 100644 tests/functional/xtensa/meson.build
 rename tests/functional/{test_xtensa_lx60.py => xtensa/test_lx60.py} (100%)
 rename tests/functional/{test_xtensa_replay.py => xtensa/test_replay.py} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b1a94f696c..792d2d6f2de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2005,7 +2005,7 @@ S: Maintained
 F: hw/xtensa/xtfpga.c
 F: hw/net/opencores_eth.c
 F: include/hw/xtensa/mx_pic.h
-F: tests/functional/test_xtensa_lx60.py
+F: tests/functional/xtensa/test_lx60.py
 
 Devices
 -------
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 34e30239a6b..b1eec16add8 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -35,6 +35,7 @@ subdir('sh4eb')
 subdir('sparc')
 subdir('sparc64')
 subdir('x86_64')
+subdir('xtensa')
 
 tests_generic_system = [
   'empty_cpu_model',
@@ -48,11 +49,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_xtensa_system_thorough = [
-  'xtensa_lx60',
-  'xtensa_replay',
-]
-
 precache_all = []
 foreach speed : ['quick', 'thorough']
   foreach dir : target_dirs
diff --git a/tests/functional/xtensa/meson.build b/tests/functional/xtensa/meson.build
new file mode 100644
index 00000000000..d61d82a1356
--- /dev/null
+++ b/tests/functional/xtensa/meson.build
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests_xtensa_system_thorough = [
+  'lx60',
+  'replay',
+]
diff --git a/tests/functional/test_xtensa_lx60.py b/tests/functional/xtensa/test_lx60.py
similarity index 100%
rename from tests/functional/test_xtensa_lx60.py
rename to tests/functional/xtensa/test_lx60.py
diff --git a/tests/functional/test_xtensa_replay.py b/tests/functional/xtensa/test_replay.py
similarity index 100%
rename from tests/functional/test_xtensa_replay.py
rename to tests/functional/xtensa/test_replay.py
-- 
2.50.1


