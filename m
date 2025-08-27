Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB6AC8303F
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 08:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urB0j-0005Z9-JF; Wed, 27 Aug 2025 03:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB0f-0005YG-1D
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:55:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB0c-00021O-Db
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756281350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y/tE9QCVfKFOuc+DooaQq/T97779sMa6K622pe7bPyM=;
 b=gy/yuYfLtKsBJ4x+gxMZx8zxHjy9yf6nZ4zVONl3d9rZ+9LiCZzeeVc8Id4caY9JUkNbIX
 GSqp98v5PVRSAgXuxHOiNT4dYPEid1l81vXlwp+v8vU+2Omi70pJCjHvAtECH5VwXz713l
 4On8Usrz8ld0+3lsRG9SEH/lRzha3EA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-1ron3Ug3My66VQE0v-mU3A-1; Wed,
 27 Aug 2025 03:55:48 -0400
X-MC-Unique: 1ron3Ug3My66VQE0v-mU3A-1
X-Mimecast-MFC-AGG-ID: 1ron3Ug3My66VQE0v-mU3A_1756281347
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A830319540F0; Wed, 27 Aug 2025 07:55:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47D101955F24; Wed, 27 Aug 2025 07:55:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/31] tests/functional: Move loongarch64 tests into
 architecture specific folder
Date: Wed, 27 Aug 2025 09:54:26 +0200
Message-ID: <20250827075443.559712-17-thuth@redhat.com>
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
loongarch64 tests into a target-specific subfolder.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250819112403.432587-12-thuth@redhat.com>
---
 MAINTAINERS                                                  | 2 +-
 tests/functional/loongarch64/meson.build                     | 5 +++++
 .../{test_loongarch64_virt.py => loongarch64/test_virt.py}   | 0
 tests/functional/meson.build                                 | 5 +----
 4 files changed, 7 insertions(+), 5 deletions(-)
 create mode 100644 tests/functional/loongarch64/meson.build
 rename tests/functional/{test_loongarch64_virt.py => loongarch64/test_virt.py} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b109ecc18c..716127e831d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -258,7 +258,7 @@ M: Song Gao <gaosong@loongson.cn>
 S: Maintained
 F: target/loongarch/
 F: tests/tcg/loongarch64/
-F: tests/functional/test_loongarch64_virt.py
+F: tests/functional/loongarch64/test_virt.py
 
 M68K TCG CPUs
 M: Laurent Vivier <laurent@vivier.eu>
diff --git a/tests/functional/loongarch64/meson.build b/tests/functional/loongarch64/meson.build
new file mode 100644
index 00000000000..d1687176a3d
--- /dev/null
+++ b/tests/functional/loongarch64/meson.build
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests_loongarch64_system_thorough = [
+  'virt',
+]
diff --git a/tests/functional/test_loongarch64_virt.py b/tests/functional/loongarch64/test_virt.py
similarity index 100%
rename from tests/functional/test_loongarch64_virt.py
rename to tests/functional/loongarch64/test_virt.py
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index f1fc01717c3..e2e66dcf523 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -15,6 +15,7 @@ subdir('arm')
 subdir('avr')
 subdir('hppa')
 subdir('i386')
+subdir('loongarch64')
 
 test_mips_timeouts = {
   'mips_malta' : 480,
@@ -80,10 +81,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_loongarch64_system_thorough = [
-  'loongarch64_virt',
-]
-
 tests_m68k_system_thorough = [
   'm68k_mcf5208evb',
   'm68k_nextcube',
-- 
2.50.1


