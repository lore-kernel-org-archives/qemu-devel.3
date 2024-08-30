Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2913ACA0FF1
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 13:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk1sQ-00089S-Ml; Fri, 30 Aug 2024 09:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk1sO-0007nT-Ft
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:41:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk1sM-0005cQ-It
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725025277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMkh+YGpTjhbMYB2P7rekHhrL11Gu9OuMlhFAjczmh8=;
 b=f6L4ihPXEBMFl8ZFlvjdT35Xb0Uhi+sLXIjqZ6adyB7P63WqDRy0We+bAcgXl0oX53hwUu
 TpibEid84FFLD7yj4FoAeEkgiXNIR2VaK5CB/yr3FL8ES4wOPeLhDMl42aoKge/EmyptlI
 uwbe+dnqgZJ5LhDBJWoQClzeo3+WBss=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-oEpSR-CaMUGOVr0Y8hVBBQ-1; Fri,
 30 Aug 2024 09:41:13 -0400
X-MC-Unique: oEpSR-CaMUGOVr0Y8hVBBQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5125C1955BF7; Fri, 30 Aug 2024 13:41:12 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E38D300019C; Fri, 30 Aug 2024 13:41:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v5 32/44] tests/functional: Convert the vnc test
Date: Fri, 30 Aug 2024 15:38:26 +0200
Message-ID: <20240830133841.142644-33-thuth@redhat.com>
In-Reply-To: <20240830133841.142644-1-thuth@redhat.com>
References: <20240830133841.142644-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Nothing thrilling in here, it's just a straight forward conversion.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build                     |  1 +
 tests/{avocado/vnc.py => functional/test_vnc.py} | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)
 rename tests/{avocado/vnc.py => functional/test_vnc.py} (97%)
 mode change 100644 => 100755

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 34a9b277f8..58f6bcf95d 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -107,6 +107,7 @@ tests_x86_64_system_quick = [
   'pc_cpu_hotplug_props',
   'virtio_version',
   'x86_cpu_model_versions',
+  'vnc',
 ]
 
 tests_x86_64_system_thorough = [
diff --git a/tests/avocado/vnc.py b/tests/functional/test_vnc.py
old mode 100644
new mode 100755
similarity index 97%
rename from tests/avocado/vnc.py
rename to tests/functional/test_vnc.py
index 862c8996a8..b769d3b268
--- a/tests/avocado/vnc.py
+++ b/tests/functional/test_vnc.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Simple functional tests for VNC functionality
 #
 # Copyright (c) 2018 Red Hat, Inc.
@@ -11,7 +13,7 @@
 import socket
 from typing import List
 
-from avocado_qemu import QemuSystemTest
+from qemu_test import QemuSystemTest
 
 
 VNC_ADDR = '127.0.0.1'
@@ -51,10 +53,7 @@ def find_free_ports(count: int) -> List[int]:
 
 
 class Vnc(QemuSystemTest):
-    """
-    :avocado: tags=vnc,quick
-    :avocado: tags=machine:none
-    """
+
     def test_no_vnc(self):
         self.vm.add_args('-nodefaults', '-S')
         self.vm.launch()
@@ -113,3 +112,6 @@ def test_change_listen(self):
         self.assertFalse(check_connect(a))
         self.assertTrue(check_connect(b))
         self.assertTrue(check_connect(c))
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.46.0


