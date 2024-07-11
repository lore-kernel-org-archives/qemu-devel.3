Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050E4C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 11:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRsPX-0003Hf-VM; Thu, 11 Jul 2024 07:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sRsPI-0002kb-Ho
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:56:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sRsPG-000499-1F
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720698972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5fu+46QJHWywwyFBmzBK0M1K/+VQFbUkdqggpGNG6nA=;
 b=eeu79MPMnYBVh77vjljDrdIe2dzcdRvZ4zMdAhMp4r8y92Gi7huBFNMULH4Ik17EhDjhga
 oCBFeVOniOMn+971TQ0k6/1nh7edenoJrDTdhFSi+oZfXZkhCAoIeRm1qTuVxOlGzhswgs
 nUEiNou3C6pid7voWhXQmm/J2HUzFhk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-5Aret1sqNmuU2q5FhBmxEA-1; Thu,
 11 Jul 2024 07:56:09 -0400
X-MC-Unique: 5Aret1sqNmuU2q5FhBmxEA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17A481954B3E; Thu, 11 Jul 2024 11:56:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.118])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A5F761955BD4; Thu, 11 Jul 2024 11:56:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH 3/8] tests/pytest: Convert info_usernet and version test
 with small adjustments
Date: Thu, 11 Jul 2024 13:55:41 +0200
Message-ID: <20240711115546.40859-4-thuth@redhat.com>
In-Reply-To: <20240711115546.40859-1-thuth@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

These two simple tests can be converted to a pytest quite easily,
we just have to set the machine to 'none' now manually since we
don't support the avocado tags here yet.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../info_usernet.py => pytest/test_info_usernet.py}       | 6 ++----
 tests/{avocado/version.py => pytest/test_version.py}      | 8 +++-----
 2 files changed, 5 insertions(+), 9 deletions(-)
 rename tests/{avocado/info_usernet.py => pytest/test_info_usernet.py} (91%)
 rename tests/{avocado/version.py => pytest/test_version.py} (82%)

diff --git a/tests/avocado/info_usernet.py b/tests/pytest/test_info_usernet.py
similarity index 91%
rename from tests/avocado/info_usernet.py
rename to tests/pytest/test_info_usernet.py
index e1aa7a6e0a..0cc3697c0b 100644
--- a/tests/avocado/info_usernet.py
+++ b/tests/pytest/test_info_usernet.py
@@ -8,18 +8,16 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from avocado_qemu import QemuSystemTest
+from qemu_pytest import QemuSystemTest
 
 from qemu.utils import get_info_usernet_hostfwd_port
 
 
 class InfoUsernet(QemuSystemTest):
-    """
-    :avocado: tags=machine:none
-    """
 
     def test_hostfwd(self):
         self.require_netdev('user')
+        self.machine = 'none'
         self.vm.add_args('-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22')
         self.vm.launch()
         res = self.vm.cmd('human-monitor-command',
diff --git a/tests/avocado/version.py b/tests/pytest/test_version.py
similarity index 82%
rename from tests/avocado/version.py
rename to tests/pytest/test_version.py
index c6139568a1..2d16b4075d 100644
--- a/tests/avocado/version.py
+++ b/tests/pytest/test_version.py
@@ -9,15 +9,13 @@
 # later.  See the COPYING file in the top-level directory.
 
 
-from avocado_qemu import QemuSystemTest
+from qemu_pytest import QemuSystemTest
 
 
 class Version(QemuSystemTest):
-    """
-    :avocado: tags=quick
-    :avocado: tags=machine:none
-    """
+
     def test_qmp_human_info_version(self):
+        self.machine = 'none'
         self.vm.add_args('-nodefaults')
         self.vm.launch()
         res = self.vm.cmd('human-monitor-command',
-- 
2.45.2


