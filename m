Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434F2CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 18:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9cZ-00051A-Ry; Sat, 17 Oct 2026 14:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9cX-0004sy-C7; Sat, 17 Oct 2026 14:59:05 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9cV-0003tT-Ij; Sat, 17 Oct 2026 14:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263402; bh=ZafvBSm/LhoxM26OS3duVotEFaFUdHJv5VXNEI0wyNo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MQNGdnxtoHIWa394YVEFGfJMcmDEGLpU7rc+Kxrb8nBhDuIX37PTXaBlJ7cU9ncD3
 pD3EQpgNuykVTpTBWXCM3dxlwqRvaoAi6c6I/N08GqhASOkI20uSA85mxMR4EHGaMo
 J0cUAJ8GKe1S5J4Ke5TKPbx0EsUhEnlup6iIos3KS6H7hrRMWmz8LVRE97AhgPXjH/
 66W8rlHuTiUQUrYCq8iD81c7+Im5DEiWAMiS5ox/nqPG2E9JLaVK3y6LpGjYS1Rilu
 HSlDNTeCDqgBL6mE3TtbTDdX+lfQ3L6KNEd866MPR6BWEvxUX3OMIJRDHfxVQIA5Oj
 Ubv2qlfmczRbQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 732011DE6C4;
 Sat, 17 Oct 2026 21:56:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1E2C644338F;
 Sat, 17 Oct 2026 21:56:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 36/63] iotests: cover inactivating a read-only node
Date: Sat, 17 Oct 2026 21:54:52 +0300
Message-ID: <20261017185528.722197-36-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Denis V. Lunev" <den@openvz.org>

A driver which writes something out on .bdrv_inactivate has nothing to
write for a node it can not write to, and has to answer such a request
with success rather than with the error its refused write produces.
The test inactivates nodes in several ways and never a read-only one,
so nothing caught that.

Add a read-only node and take it through a deactivation and back. The
case is generic, as every driver implementing the handler has to answer
the same way.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
(cherry picked from commit 2910b995f6c8afd3eaa950e24432a0e044274ac5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/tests/inactive-node-nbd b/tests/qemu-iotests/tests/inactive-node-nbd
index a95b37e796..52c63fdf26 100755
--- a/tests/qemu-iotests/tests/inactive-node-nbd
+++ b/tests/qemu-iotests/tests/inactive-node-nbd
@@ -46,6 +46,7 @@ def node_is_active(_vm, node_name):
     return node['active']
 
 with iotests.FilePath('disk.img') as path, \
+     iotests.FilePath('ro.img') as ro_path, \
      iotests.FilePath('snap.qcow2') as snap_path, \
      iotests.FilePath('snap2.qcow2') as snap2_path, \
      iotests.FilePath('target.img') as target_path, \
@@ -57,6 +58,7 @@ with iotests.FilePath('disk.img') as path, \
     iotests.log('Preparing disk...')
     iotests.qemu_img_create('-f', iotests.imgfmt, path, img_size)
     iotests.qemu_img_create('-f', iotests.imgfmt, target_path, img_size)
+    iotests.qemu_img_create('-f', iotests.imgfmt, ro_path, img_size)
 
     iotests.qemu_img_create('-f', 'qcow2', '-b', path, '-F', iotests.imgfmt,
                             snap_path)
@@ -69,6 +71,9 @@ with iotests.FilePath('disk.img') as path, \
                      'active=off')
     vm.add_blockdev(f'file,node-name=target-file,filename={target_path}')
     vm.add_blockdev(f'{iotests.imgfmt},file=target-file,node-name=target-fmt')
+    vm.add_blockdev(f'file,node-name=ro-file,filename={ro_path},read-only=on')
+    vm.add_blockdev(f'{iotests.imgfmt},file=ro-file,node-name=ro-fmt,'
+                     'read-only=on')
     vm.add_blockdev(f'file,node-name=snap-file,filename={snap_path}')
     vm.add_blockdev(f'file,node-name=snap2-file,filename={snap2_path}')
 
@@ -288,6 +293,15 @@ with iotests.FilePath('disk.img') as path, \
     iotests.log(qemu_io.cmd('map'), filters=[filter_qemu_io])
     qemu_io.close()
 
+    iotests.log('\n=== Inactivating a read-only node ===')
+
+    # A driver which writes something out on inactivation has nothing to
+    # write for a node it can not write to, and must not fail the request
+    vm.qmp_log('blockdev-set-active', node_name='ro-fmt', active=False)
+    iotests.log('ro-fmt active: %s' % node_is_active(vm, 'ro-fmt'))
+    vm.qmp_log('blockdev-set-active', node_name='ro-fmt', active=True)
+    iotests.log('ro-fmt active: %s' % node_is_active(vm, 'ro-fmt'))
+
     iotests.log('\n=== Resuming VM activates all images ===')
     vm.qmp_log('cont')
 
diff --git a/tests/qemu-iotests/tests/inactive-node-nbd.out b/tests/qemu-iotests/tests/inactive-node-nbd.out
index a458b4fc05..3c43020053 100644
--- a/tests/qemu-iotests/tests/inactive-node-nbd.out
+++ b/tests/qemu-iotests/tests/inactive-node-nbd.out
@@ -227,6 +227,14 @@ discard failed: Operation not permitted
 qemu-io: Failed to get allocation status: Operation not permitted
 
 
+=== Inactivating a read-only node ===
+{"execute": "blockdev-set-active", "arguments": {"active": false, "node-name": "ro-fmt"}}
+{"return": {}}
+ro-fmt active: False
+{"execute": "blockdev-set-active", "arguments": {"active": true, "node-name": "ro-fmt"}}
+{"return": {}}
+ro-fmt active: True
+
 === Resuming VM activates all images ===
 {"execute": "cont", "arguments": {}}
 {"return": {}}
-- 
2.47.3


