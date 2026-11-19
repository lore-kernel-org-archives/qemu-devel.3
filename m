Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14EE6071655
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ovhcloud.com header.i=@ovhcloud.com header.a=rsa-sha256 header.s=mailout header.b=f46Lx5PU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU3QD-0004WV-5e; Thu, 19 Nov 2026 09:47:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xU3Pv-0004R2-AZ
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:47:17 -0500
Received: from 1.mo15.mail-out.ovh.net ([5.135.90.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xU3Pp-0006DU-6m
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:47:12 -0500
Received: from DAGFR11EX3.OVH.local (unknown [10.110.0.73])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4jVhBT62ncz42N0;
 Thu, 19 Nov 2026 14:46:57 +0000 (UTC)
Received: from ovhcloud.com (109.190.254.2) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 15:46:56 +0100
From: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <eblake@redhat.com>, <vsementsov@yandex-team.ru>, 
 <kwolf@redhat.com>, <hreitz@redhat.com>, <stefanha@redhat.com>,
 <fam@euphon.net>, Guillaume Vincke <guillaume.vincke@ovhcloud.com>
Subject: [PATCH 5/5] block: Add refresh connection support to raw and luks
Date: Thu, 19 Nov 2026 15:46:32 +0100
Message-ID: <20261119144632.232457-6-guillaume.vincke@ovhcloud.com>
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
x-ovh-tracer-id: 856246879468667357
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTGQhBK1U4xr/AMRFXRFeSFunzyiF6YtPFyxOtiBV85ZL5XARzZl8Z6U/ThfSP8t+5aj6ASB256lQMITIDvCr2bW5VG3AmVbjnFNPYSKTRwG+4DbCS6uE9SzdlmglbW/hDwGl+LfYUd+e+1PYDLewjTk7sCr/qyWO8hNVUp+rWsuv8BS/lxxOolWzCkc3Xy5dfi1Qbv4IFpRs09fIF/+f6kNcUVFFQXKiVq//Ej4Dz3sfLD8Tqa+8pP0afr1+xcIpXKR8UAhCmDiKlWfaRtcm7LIKr3ZkiesntSSjmnxh5QoyNvoLGs7VCnKrYAd4aeVDJ0oxd0UIGBSk78TrOY87RF6NyIMpuMhF1SpyAM3IA/msXwFc/bN0yJ566n9d7A+PU9kzmxp62YtFiKtIiG/T3b80vvcs08xscTmXJ3rq46l17TuFzwQcjEcdNBJ3fe8YNWWJceQCuYtcJORz1C7ckzdBSAHlylawtm92F1thiYnEifB3Wy7BsNZdhf3BOTmjT4MYAMz7FGqht48520my8drMKTeeZQBx5uYrG6BY8HANBnXpZ6vAym1yCFeac90W2WHsvRh49IOyGHgYYAGoyi1/yEPDUuLDghPxKgM1r56uIvKxYxx8IBR1yFfLPEsZwFY6VsTxy/Mgy28lok98w6klnMR/kmtgSBCJC33xPcwcg
DKIM-Signature: a=rsa-sha256; bh=XqfV3xygi1sxCzdjjD8L4mS8tUYOUq9c9D58YPg31CY=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1795099618; v=1; 
 b=f46Lx5PU7W1w5H/wP469vtrqhfVNDoBkO6O4EhusLMiI+Ovws650kLk/Y4mGZeGY9NkQiNA9
 6pnME+HviqSlJGnRbGSCsnb8YMoABdqkTkgxa0yDgJcpvg9WXri3pQ4913L1n2oAMUgNezWRwLc
 pnmHjzmL3G+zNCIN3wtB+lCg=
Received-SPF: pass client-ip=5.135.90.178;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=1.mo15.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The bdrv_co_refresh_connection callback is used to force an idle NBD
client to reconnect before the node is truncated. However, when a
format node such as luks or raw is on top of the NBD node, the call is
not forwarded.

Implement the bdrv_co_refresh_connection callback in raw and luks to
forward the request to their file child.

Update the nbd-resize test to exercise it with luks and raw format
drivers.

Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
---
 block/crypto.c                      |  7 ++++
 block/raw-format.c                  |  7 ++++
 tests/qemu-iotests/tests/nbd-resize | 51 ++++++++++++++++++++++++-----
 3 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 8a34d92fde..7e13a3a917 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -462,6 +462,12 @@ block_crypto_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
     return bdrv_co_truncate(bs->file, offset, exact, prealloc, 0, errp);
 }
 
+static int coroutine_fn GRAPH_RDLOCK
+block_crypto_co_refresh_connection(BlockDriverState *bs, Error **errp)
+{
+    return bdrv_co_refresh_connection(bs->file, errp);
+}
+
 static void block_crypto_close(BlockDriverState *bs)
 {
     BlockCrypto *crypto = bs->opaque;
@@ -1086,6 +1092,7 @@ static BlockDriver bdrv_crypto_luks = {
     .bdrv_co_create     = block_crypto_co_create_luks,
     .bdrv_co_create_opts = block_crypto_co_create_opts_luks,
     .bdrv_co_truncate   = block_crypto_co_truncate,
+    .bdrv_co_refresh_connection = block_crypto_co_refresh_connection,
     .create_opts        = &block_crypto_create_opts_luks,
     .amend_opts         = &block_crypto_amend_opts_luks,
 
diff --git a/block/raw-format.c b/block/raw-format.c
index a57c2922d5..389ab16201 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -432,6 +432,12 @@ raw_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
     return bdrv_co_truncate(bs->file, offset, exact, prealloc, flags, errp);
 }
 
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_refresh_connection(BlockDriverState *bs, Error **errp)
+{
+    return bdrv_co_refresh_connection(bs->file, errp);
+}
+
 static void coroutine_fn GRAPH_RDLOCK
 raw_co_eject(BlockDriverState *bs, bool eject_flag)
 {
@@ -657,6 +663,7 @@ BlockDriver bdrv_raw = {
     .bdrv_co_copy_range_from = &raw_co_copy_range_from,
     .bdrv_co_copy_range_to  = &raw_co_copy_range_to,
     .bdrv_co_truncate     = &raw_co_truncate,
+    .bdrv_co_refresh_connection = &raw_co_refresh_connection,
     .bdrv_co_getlength    = &raw_co_getlength,
     .is_format            = true,
     .bdrv_measure         = &raw_measure,
diff --git a/tests/qemu-iotests/tests/nbd-resize b/tests/qemu-iotests/tests/nbd-resize
index 4f305eaebf..ac283c74e5 100755
--- a/tests/qemu-iotests/tests/nbd-resize
+++ b/tests/qemu-iotests/tests/nbd-resize
@@ -10,10 +10,34 @@
 import time
 import iotests
 
-iotests.script_initialize(supported_fmts=['qcow2'])
+iotests.script_initialize(supported_fmts=['qcow2', 'raw', 'luks'])
 nbd_sock = iotests.file_path('nbd-sock', base_dir=iotests.sock_dir)
 disk = iotests.file_path('disk')
-node_name = 'nbd0'
+nbd_node_name = 'nbd0'
+
+qemu_nbd_volume_format = iotests.imgfmt
+node_name = nbd_node_name
+format_driver_extra_opts: dict[str, object] = {}
+
+if iotests.imgfmt == 'raw':
+    node_name = f"raw_{node_name}"
+
+elif iotests.imgfmt == 'luks':
+    qemu_nbd_volume_format = 'raw'
+    node_name = f"luks_{node_name}"
+    format_driver_extra_opts = { 'key-secret': 'keysec0' }
+
+
+def create_img():
+    iotests.qemu_img_create('-f', iotests.imgfmt, disk, '1M')
+
+
+def resize_img():
+    if iotests.imgfmt == 'qcow2':
+        iotests.qemu_img('resize', '-f', iotests.imgfmt, disk, '2M')
+    else:
+        # raw and luks virtual size follows the file size
+        iotests.qemu_img('resize', '-f', 'raw', disk, '+1M')
 
 
 def node_size(virtm):
@@ -26,7 +50,8 @@ def node_size(virtm):
 def wait_for_parked_connection(virtm):
     with iotests.Timeout(30, "connect-thread did not reach 'parked' state"):
         while True:
-            client = virtm.qmp('x-debug-query-nbd-client', node_name=node_name)
+            client = virtm.qmp('x-debug-query-nbd-client',
+                               node_name=nbd_node_name)
             if client['return']['connector']['state'] == 'parked':
                 return
             time.sleep(0.1)
@@ -35,29 +60,39 @@ def wait_for_parked_connection(virtm):
 for reconnect_delay in [10, 0]:
     iotests.log(f"=== Resize with reconnect-delay={reconnect_delay} ===")
     with iotests.VM() as vm:
+        if iotests.imgfmt == 'luks':
+            vm.add_object(iotests.luks_default_secret_object)
+
         vm.launch()
 
-        iotests.qemu_img_create('-f', iotests.imgfmt, disk, '1M')
+        create_img()
         with iotests.qemu_nbd_popen('-k',
                                     nbd_sock,
                                     '-f',
-                                    iotests.imgfmt,
+                                    qemu_nbd_volume_format,
                                     disk):
             vm.cmd('blockdev-add', {
                 'driver': 'nbd',
-                'node-name': node_name,
+                'node-name': nbd_node_name,
                 'server': { 'type': 'unix', 'path': nbd_sock },
                 'reconnect-delay': reconnect_delay,
             })
 
+            if iotests.imgfmt != 'qcow2':
+                vm.cmd('blockdev-add', {
+                    'driver': iotests.imgfmt,
+                    'node-name': node_name,
+                    'file': nbd_node_name,
+                } | format_driver_extra_opts)
+
             iotests.log('Size before resize:')
             iotests.log(node_size(vm))
 
-        iotests.qemu_img('resize', '-f', iotests.imgfmt, disk, '2M')
+        resize_img()
         with iotests.qemu_nbd_popen('-k',
                                     nbd_sock,
                                     '-f',
-                                    iotests.imgfmt,
+                                    qemu_nbd_volume_format,
                                     disk):
             iotests.log(vm.qmp('block_resize', {
                 'node-name': node_name,
-- 
2.43.0


