Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE9F60A2610
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovhcloud.com header.i=@ovhcloud.com header.a=rsa-sha256 header.s=mailout header.b=bxdgmnk6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU3Pz-0004SG-RA; Thu, 19 Nov 2026 09:47:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xU3Pr-0004QY-8X
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:47:11 -0500
Received: from 1.mo15.mail-out.ovh.net ([5.135.90.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xU3Pp-0006DS-6O
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:47:10 -0500
Received: from DAGFR11EX3.OVH.local (unknown [10.110.0.73])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4jVhBT0tBZz42Mw;
 Thu, 19 Nov 2026 14:46:56 +0000 (UTC)
Received: from ovhcloud.com (109.190.254.2) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 15:46:56 +0100
From: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <eblake@redhat.com>, <vsementsov@yandex-team.ru>, 
 <kwolf@redhat.com>, <hreitz@redhat.com>, <stefanha@redhat.com>,
 <fam@euphon.net>, Guillaume Vincke <guillaume.vincke@ovhcloud.com>
Subject: [PATCH 4/5] iotests: Add coverage for NBD resize
Date: Thu, 19 Nov 2026 15:46:31 +0100
Message-ID: <20261119144632.232457-5-guillaume.vincke@ovhcloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119144632.232457-1-guillaume.vincke@ovhcloud.com>
References: <20261119144632.232457-1-guillaume.vincke@ovhcloud.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CAS2.OVH.local (172.16.1.2) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 855965406749278685
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTGQhBK1U4xr/AMRFXRFeSFunzyiF6YtPFyxOtiBV85ZL5XARzZl8Z6U/ThfSP8t+5aj6ASB256lQMITIDvCr2bW5VG3AmVbjnFNPYSKTRwG+4DbCS6uE9SzdlmglbW/hDwGl+LfYUd+e+1PYDLewjTk7sCr/qyWO8hNVUp+rWsuv8BS/lxxOolWzCkc3Xy5dfi1Qbv4IFpRs09fIF/+f6kNcUVFFQXKiVq//Ej4Dz3sfLD8Tqa+8pP0afr1+xcIpXKR8UAhCmDiKlWfaRtcm7LIKr3ZkiesntSSjmnxh5QoyNvoLGs7VCnKrYAd4aeVDJ0oxd0UIGBSk78TrOY87RF6fcukzdNHupHSdL8MB4y/i/MBb4/Vs397E60UASxLlmL66Mh1SxJ4x/r556cQFb/7oQKAj8KsJrqYTO2/GjgghEZh4SfF5dEqgbjzcvaSXd8iBb2wbSw7VOFPqbWKBa/ngtEaY2UQ8pN1waPRQSjRiNCElrqnOPVHgGfr3dU8F9MqI1A3EKWv1i0rFTaEEe2HWSQiUV4flRzcAjTtG6O3WzOqqwVdAGzbCarD03Hgqg4DKR6/4DhjRtXjeOg//vZts82nYZxNqEnT//r3+U0f5XCVXm8u5HD5071TE/J/Qe5IhidCkJo8baVUwM5J9OKpCM9GTPEQkVlYWlyVMvHDqQ
DKIM-Signature: a=rsa-sha256; bh=0ia8OpYUMfisiLn9YZYC10KD5H2WNL7fCwjQsBTXoWQ=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1795099617; v=1; 
 b=bxdgmnk6fFCySGpgbYIeo03q2ThrdEI95BKKeoQfFAKHxD6wjao0mba8zMP7uTIlp2xR3F14
 DAZHnv8TbNAyUOb1IXKnBLZune9JzjPlC/jcZf7tEBufashYXlZ1ylml9NLMl77LdURkTxomkm6
 XSWQ6AN9JOfVe34APXgeluSA=
Received-SPF: pass client-ip=5.135.90.178;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=1.mo15.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: guillaume.vincke@ovhcloud.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Test the block_resize QMP function on an NBD device. Prior to the
addition of bdrv_co_refresh_connection(), running block_resize on a
node that did not process any requests between the device size
update and the function call failed with "Cannot grow NBD nodes".

Add a test that updates an NBD node size and verifies that the
block_resize behaves as expected. The first part configures a reconnect
delay and asserts that the call succeeds. The second uses the default
reconnect-delay=0 and asserts that, even though the function returns an
error, the reconnection routine gets started and that retrying succeeds
once the node has successfully reconnected.

Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
---
 tests/qemu-iotests/tests/nbd-resize     | 81 +++++++++++++++++++++++++
 tests/qemu-iotests/tests/nbd-resize.out | 24 ++++++++
 2 files changed, 105 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/nbd-resize
 create mode 100644 tests/qemu-iotests/tests/nbd-resize.out

diff --git a/tests/qemu-iotests/tests/nbd-resize b/tests/qemu-iotests/tests/nbd-resize
new file mode 100755
index 0000000000..4f305eaebf
--- /dev/null
+++ b/tests/qemu-iotests/tests/nbd-resize
@@ -0,0 +1,81 @@
+#!/usr/bin/env python3
+# group: quick
+#
+# Test the NBD resize
+#
+# Copyright (C) 2026 OVHcloud
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import time
+import iotests
+
+iotests.script_initialize(supported_fmts=['qcow2'])
+nbd_sock = iotests.file_path('nbd-sock', base_dir=iotests.sock_dir)
+disk = iotests.file_path('disk')
+node_name = 'nbd0'
+
+
+def node_size(virtm):
+    for node in virtm.cmd('query-named-block-nodes', flat=True):
+        if node['node-name'] == node_name:
+            return node['image']['virtual-size']
+    return None
+
+
+def wait_for_parked_connection(virtm):
+    with iotests.Timeout(30, "connect-thread did not reach 'parked' state"):
+        while True:
+            client = virtm.qmp('x-debug-query-nbd-client', node_name=node_name)
+            if client['return']['connector']['state'] == 'parked':
+                return
+            time.sleep(0.1)
+
+
+for reconnect_delay in [10, 0]:
+    iotests.log(f"=== Resize with reconnect-delay={reconnect_delay} ===")
+    with iotests.VM() as vm:
+        vm.launch()
+
+        iotests.qemu_img_create('-f', iotests.imgfmt, disk, '1M')
+        with iotests.qemu_nbd_popen('-k',
+                                    nbd_sock,
+                                    '-f',
+                                    iotests.imgfmt,
+                                    disk):
+            vm.cmd('blockdev-add', {
+                'driver': 'nbd',
+                'node-name': node_name,
+                'server': { 'type': 'unix', 'path': nbd_sock },
+                'reconnect-delay': reconnect_delay,
+            })
+
+            iotests.log('Size before resize:')
+            iotests.log(node_size(vm))
+
+        iotests.qemu_img('resize', '-f', iotests.imgfmt, disk, '2M')
+        with iotests.qemu_nbd_popen('-k',
+                                    nbd_sock,
+                                    '-f',
+                                    iotests.imgfmt,
+                                    disk):
+            iotests.log(vm.qmp('block_resize', {
+                'node-name': node_name,
+                'size': 2097152,
+            }))
+            iotests.log('Size after resize:')
+            iotests.log(node_size(vm))
+            if reconnect_delay == 0:
+                # With delay=0, block_resize fails while the client reconnects.
+                # Retry once parked.
+                iotests.log('Waiting until the reconnection succeeds')
+                wait_for_parked_connection(vm)
+
+                iotests.log(vm.qmp('block_resize', {
+                    'node-name': node_name,
+                    'size': 2097152,
+                }))
+                iotests.log('Size after retried resize:')
+                iotests.log(node_size(vm))
+
+            vm.shutdown()
diff --git a/tests/qemu-iotests/tests/nbd-resize.out b/tests/qemu-iotests/tests/nbd-resize.out
new file mode 100644
index 0000000000..89eda39740
--- /dev/null
+++ b/tests/qemu-iotests/tests/nbd-resize.out
@@ -0,0 +1,24 @@
+=== Resize with reconnect-delay=10 ===
+Start NBD server
+Size before resize:
+1048576
+Kill NBD server
+Start NBD server
+{"return": {}}
+Size after resize:
+2097152
+Kill NBD server
+=== Resize with reconnect-delay=0 ===
+Start NBD server
+Size before resize:
+1048576
+Kill NBD server
+Start NBD server
+{"error": {"class": "GenericError", "desc": "Failed to reconnect NBD node"}}
+Size after resize:
+1048576
+Waiting until the reconnection succeeds
+{"return": {}}
+Size after retried resize:
+2097152
+Kill NBD server
-- 
2.43.0


