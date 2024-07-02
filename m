Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6591CC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 10:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOapj-0004ZC-NV; Tue, 02 Jul 2024 06:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOaph-0004SX-U1
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 06:33:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOapg-00077q-4r
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 06:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719916435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n89XocrGSLjafzTq3x8jNZ6v67Auks/7crf5izLupRM=;
 b=G3TCv7PV0ktFBYwavwudrtQjJbb2PE87AuJitYjHmfrsvuKFBlduWAg/X2o5lNCnAVG2CN
 3FezSqQy6BrwSJKh2WrhLPfdaSKfXq6EdBZEJr+36wS6DIj6tBr2LI74iudnZ5g0hr2vmZ
 npcg4++hVH1KItkm3Rb9k1KPzpsHYQQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-7yguL_GSPAW-hqgQ_2w-TQ-1; Tue,
 02 Jul 2024 06:33:51 -0400
X-MC-Unique: 7yguL_GSPAW-hqgQ_2w-TQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C8461977328; Tue,  2 Jul 2024 10:33:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C728519560AA; Tue,  2 Jul 2024 10:33:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 10/12] tests/avocado: add hotplug_blk test
Date: Tue,  2 Jul 2024 12:33:08 +0200
Message-ID: <20240702103310.347201-11-thuth@redhat.com>
In-Reply-To: <20240702103310.347201-1-thuth@redhat.com>
References: <20240702103310.347201-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Introduce a test, that checks that plug/unplug of virtio-blk device
works.

(the test is developed by copying hotplug_cpu.py, so keep original
copyright)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240409065854.366856-1-vsementsov@yandex-team.ru>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/hotplug_blk.py | 69 ++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 tests/avocado/hotplug_blk.py

diff --git a/tests/avocado/hotplug_blk.py b/tests/avocado/hotplug_blk.py
new file mode 100644
index 0000000000..5dc30f6616
--- /dev/null
+++ b/tests/avocado/hotplug_blk.py
@@ -0,0 +1,69 @@
+# Functional test that hotplugs a virtio blk disk and checks it on a Linux
+# guest
+#
+# Copyright (c) 2021 Red Hat, Inc.
+# Copyright (c) Yandex
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import time
+
+from avocado_qemu import LinuxTest
+
+
+class HotPlug(LinuxTest):
+    def blockdev_add(self) -> None:
+        self.vm.cmd('blockdev-add', **{
+            'driver': 'null-co',
+            'size': 1073741824,
+            'node-name': 'disk'
+        })
+
+    def assert_vda(self) -> None:
+        self.ssh_command('test -e /sys/block/vda')
+
+    def assert_no_vda(self) -> None:
+        with self.assertRaises(AssertionError):
+            self.assert_vda()
+
+    def plug(self) -> None:
+        args = {
+            'driver': 'virtio-blk-pci',
+            'drive': 'disk',
+            'id': 'virtio-disk0',
+            'bus': 'pci.1',
+            'addr': 1
+        }
+
+        self.assert_no_vda()
+        self.vm.cmd('device_add', args)
+        try:
+            self.assert_vda()
+        except AssertionError:
+            time.sleep(1)
+            self.assert_vda()
+
+    def unplug(self) -> None:
+        self.vm.cmd('device_del', id='virtio-disk0')
+
+        self.vm.event_wait('DEVICE_DELETED', 1.0,
+                           match={'data': {'device': 'virtio-disk0'}})
+
+        self.assert_no_vda()
+
+    def test(self) -> None:
+        """
+        :avocado: tags=arch:x86_64
+        :avocado: tags=machine:q35
+        :avocado: tags=accel:kvm
+        """
+        self.require_accelerator('kvm')
+        self.vm.add_args('-accel', 'kvm')
+        self.vm.add_args('-device', 'pcie-pci-bridge,id=pci.1,bus=pcie.0')
+
+        self.launch_and_wait()
+        self.blockdev_add()
+
+        self.plug()
+        self.unplug()
-- 
2.45.2


