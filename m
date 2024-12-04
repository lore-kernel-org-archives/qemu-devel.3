Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1AFE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 07:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIjfk-0006Zf-11; Wed, 04 Dec 2024 02:19:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIjfV-0006Si-Iu
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 02:19:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tIjfU-0005Gs-39
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 02:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733296766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PGOrDdYWaOef4MfQEkI3GVDOqwz8+MMlsUiqjHR4ua0=;
 b=EZbx8n1z9HhWGckNuADJKYyZwqGNC6iZgrWSjzv6vSPDRiBzonaZOUCB88vSrxXKN0O1Vl
 oNigzS9VoQd6ohSFPcyaQrFOo0kueMsCKUrx9Am4ZLLfawD6+1pBv4jFAusrXavHDEkAD6
 IOmPhlzsB4TxFvUGP2VKx5ToCRlHyWs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-60-95wvhMVyjKU8Wr9B4VQ-1; Wed,
 04 Dec 2024 02:19:19 -0500
X-MC-Unique: 60-95wvhMVyjKU8Wr9B4VQ-1
X-Mimecast-MFC-AGG-ID: 60-95wvhMVyjKU8Wr9B4VQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14FAC1956095; Wed,  4 Dec 2024 07:19:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.155])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E978B1956060; Wed,  4 Dec 2024 07:19:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/5] tests/functional: Convert the vnc test
Date: Wed,  4 Dec 2024 08:19:07 +0100
Message-ID: <20241204071911.664057-2-thuth@redhat.com>
In-Reply-To: <20241204071911.664057-1-thuth@redhat.com>
References: <20241204071911.664057-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build                     |  1 +
 tests/{avocado/vnc.py => functional/test_vnc.py} | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)
 rename tests/{avocado/vnc.py => functional/test_vnc.py} (97%)
 mode change 100644 => 100755

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index f50bf61a50..3d29b8245a 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -206,6 +206,7 @@ tests_x86_64_system_quick = [
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
2.47.0


