Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7ACE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 12:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNWVA-0000wM-Il; Tue, 17 Dec 2024 07:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNWV4-0000vP-4l
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 07:16:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNWUy-0007wB-G7
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 07:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734437780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vGPFuF0s7/iQk3ev3K9OkipcorVBDhCojDwHRiwy9pM=;
 b=b2/5a0mRQEndKhzZXugDJ7mKGUM0v38StdtEMxKw+esF6dof4F3CKjH7n4KEHUzpeAV8dz
 85RxHKQerGczf7gFAYzLqRw/dKQP3dVhGzwRKP17BOJzCDF5fFYewtvjBomZ1HF3k3FbA6
 PhhqXXt0yekpdKDj2mDe1vylrE7GDxA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-bNWI4xwpM52vt-qLLCWPKQ-1; Tue,
 17 Dec 2024 07:16:16 -0500
X-MC-Unique: bNWI4xwpM52vt-qLLCWPKQ-1
X-Mimecast-MFC-AGG-ID: bNWI4xwpM52vt-qLLCWPKQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E2A31955F2D; Tue, 17 Dec 2024 12:16:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DB1E71955F54; Tue, 17 Dec 2024 12:16:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 1/2] tests/functional: Add a helper function for retrieving
 the hostfwd port
Date: Tue, 17 Dec 2024 13:15:49 +0100
Message-ID: <20241217121550.141072-2-thuth@redhat.com>
In-Reply-To: <20241217121550.141072-1-thuth@redhat.com>
References: <20241217121550.141072-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

It's just a wrapper around get_info_usernet_hostfwd_port from the
qemu module that is also calling the right monitor command for
retrieving the information from QEMU.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/utils.py   | 7 +++++++
 tests/functional/test_info_usernet.py | 8 +++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
index 43853b4366..e7c8de8165 100644
--- a/tests/functional/qemu_test/utils.py
+++ b/tests/functional/qemu_test/utils.py
@@ -10,6 +10,13 @@
 
 import os
 
+from qemu.utils import get_info_usernet_hostfwd_port
+
+
+def get_usernet_hostfwd_port(vm):
+    res = vm.cmd('human-monitor-command', command_line='info usernet')
+    return get_info_usernet_hostfwd_port(res)
+
 """
 Round up to next power of 2
 """
diff --git a/tests/functional/test_info_usernet.py b/tests/functional/test_info_usernet.py
index cd37524d94..e8cbc37eed 100755
--- a/tests/functional/test_info_usernet.py
+++ b/tests/functional/test_info_usernet.py
@@ -11,8 +11,7 @@
 # later.  See the COPYING file in the top-level directory.
 
 from qemu_test import QemuSystemTest
-
-from qemu.utils import get_info_usernet_hostfwd_port
+from qemu_test.utils import get_usernet_hostfwd_port
 
 
 class InfoUsernet(QemuSystemTest):
@@ -22,9 +21,8 @@ def test_hostfwd(self):
         self.set_machine('none')
         self.vm.add_args('-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22')
         self.vm.launch()
-        res = self.vm.cmd('human-monitor-command',
-                          command_line='info usernet')
-        port = get_info_usernet_hostfwd_port(res)
+
+        port = get_usernet_hostfwd_port(self.vm)
         self.assertIsNotNone(port,
                              ('"info usernet" output content does not seem to '
                               'contain the redirected port'))
-- 
2.47.1


