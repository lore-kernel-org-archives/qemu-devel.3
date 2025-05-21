Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881A3C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 15:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHl8W-0004se-GR; Wed, 21 May 2025 11:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uHl8V-0004sS-9R
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:13:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uHl8R-00022c-VT
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747840412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XuEkYjKzDf6DVqioHgv3E9FZv9MeMmn9lH+ktcqBymA=;
 b=LbEu9U8yFXTa/A8z4vNgthg3GkLyvAMsTSkXgXYrLZGhoXpAhYdLhvg4xG2FCia7i+6w7M
 aizWS+8ik4J1fBehlbwp57jiubs9lte+ivVZjbE4ysd+65xYoN+E53SA6muhhdGObAIKUY
 25tJ4W54OMb0ICltBxlUhUPB0w5I1fM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-h9abPPUhNz-LWvTgqUYYgQ-1; Wed,
 21 May 2025 11:13:29 -0400
X-MC-Unique: h9abPPUhNz-LWvTgqUYYgQ-1
X-Mimecast-MFC-AGG-ID: h9abPPUhNz-LWvTgqUYYgQ_1747840408
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 417A31800771; Wed, 21 May 2025 15:13:28 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.199])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 26386195608F; Wed, 21 May 2025 15:13:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] tests/functional: Set 'pc' machine type instead of relying on
 the default
Date: Wed, 21 May 2025 17:13:23 +0200
Message-ID: <20250521151323.155232-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

In case the default machine has not been compiled into the QEMU
binary, the vnc and the cpu_hotplug_props test are currently
failing. Add a set_machine('pc') here to make sure that the tests
are correctly skipped in case the machine is not available.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_pc_cpu_hotplug_props.py | 1 +
 tests/functional/test_vnc.py                  | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/tests/functional/test_pc_cpu_hotplug_props.py b/tests/functional/test_pc_cpu_hotplug_props.py
index 9d5a37cb170..2bed8ada023 100755
--- a/tests/functional/test_pc_cpu_hotplug_props.py
+++ b/tests/functional/test_pc_cpu_hotplug_props.py
@@ -26,6 +26,7 @@
 class OmittedCPUProps(QemuSystemTest):
 
     def test_no_die_id(self):
+        self.set_machine('pc')
         self.vm.add_args('-nodefaults', '-S')
         self.vm.add_args('-smp', '1,sockets=2,cores=2,threads=2,maxcpus=8')
         self.vm.add_args('-device', 'qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0')
diff --git a/tests/functional/test_vnc.py b/tests/functional/test_vnc.py
index 5c0ee5f9272..cbb01f00c7b 100755
--- a/tests/functional/test_vnc.py
+++ b/tests/functional/test_vnc.py
@@ -31,6 +31,7 @@ def check_connect(port: int) -> bool:
 class Vnc(QemuSystemTest):
 
     def test_no_vnc_change_password(self):
+        self.set_machine('pc')
         self.vm.add_args('-nodefaults', '-S')
         self.vm.launch()
 
@@ -62,6 +63,7 @@ def launch_guarded(self):
                 raise excp
 
     def test_change_password_requires_a_password(self):
+        self.set_machine('pc')
         self.vm.add_args('-nodefaults', '-S', '-vnc', ':1,to=999')
         self.launch_guarded()
         self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
@@ -74,6 +76,7 @@ def test_change_password_requires_a_password(self):
                          'Could not set password')
 
     def test_change_password(self):
+        self.set_machine('pc')
         self.vm.add_args('-nodefaults', '-S', '-vnc', ':1,to=999,password=on')
         self.launch_guarded()
         self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
@@ -103,6 +106,7 @@ def do_test_change_listen(self, a, b, c):
         self.assertTrue(check_connect(c))
 
     def test_change_listen(self):
+        self.set_machine('pc')
         with Ports() as ports:
             a, b, c = ports.find_free_ports(3)
             self.do_test_change_listen(a, b, c)
-- 
2.49.0


