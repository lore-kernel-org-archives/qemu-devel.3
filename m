Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB27CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB52-00050b-LO; Sat, 17 Oct 2026 16:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB3Y-0003Qw-8L; Sat, 17 Oct 2026 16:31:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB3W-0004QS-A6; Sat, 17 Oct 2026 16:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268869; bh=T9z8T1gpQIEuWmR14yqYEY/a+QPXaJdnyRekXUMSJoA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=N6LP6Od84LqaR6bmkFUQ6hDyvC2dlv4Z2WadmEmXS3w/hQ/gIJDAzvGL49zqPL0UE
 ishM+Sx4Uk3lAjKIRHASht3ROYwcfxq2hiz9ARmfXeiD+Sw9lMsfyk1PkoxaOGXlUZ
 mGPiKDGH/uwXAQkrW5uNEn2LyWYeIfT7cmKYRM+Txpiu+ULx1ZebKsVW9XImwe51U9
 R+xQea+xbJ6JpFLsGzelPYaG/PlP4WS8BasgsS6NPQi+FSpvfrxOzAx5CgJTtd/4YH
 It5UthVQpoagO7bPr1mD62r+jg0KJ4I/Cz5j6mjwOQdjqvRHkvTYR9ycjPjDkZetz2
 3V4s2p7Jkjleg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CEBF11DE769;
 Sat, 17 Oct 2026 23:27:49 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0790444343D;
 Sat, 17 Oct 2026 23:27:48 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Fiona Ebner <f.ebner@proxmox.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 43/73] block: fix bdrv_next() skipping monitor-owned
 nodes
Date: Sat, 17 Oct 2026 23:26:01 +0300
Message-ID: <20261017202638.728621-43-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
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

it->bs is the cursor into monitor_bdrv_states for the second phase of
bdrv_next(), so it has to be NULL when that phase starts. Commit
f6d38c9f6d made the first phase store the node it returns there, to
unreference the right one when the graph changes underneath. The cursor
is now left pointing at the last BlockBackend root, so the second phase
resumes from there instead of from the head of the list and never
returns a node added before it.

A skipped node drops out of the vm_stop and migration handover paths:
not flushed, not inactivated, not snapshotted. bdrv_inactivate_all()
still reports success, so the node keeps its image lock and the
migration target cannot open the image. Only detached nodes are hit in
practice, as these callers also recurse into children.

Reset the cursor when the second phase starts. old_bs is taken at the
top of the function, so f6d38c9f6d keeps working.

Cc: qemu-stable@nongnu.org
Fixes: f6d38c9f6d ("block-backend: fix edge case in bdrv_next() where BDS associated to BB changes")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Fiona Ebner <f.ebner@proxmox.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260828222005.2888213-1-den@openvz.org>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 8daaf8d3b1c5f2ef98e526e036277083bc5fe34b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/block-backend.c b/block/block-backend.c
index 5e59bac1a3..ab837fac92 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -625,6 +625,7 @@ BlockDriverState *bdrv_next(BdrvNextIterator *it)
             return bs;
         }
         it->phase = BDRV_NEXT_MONITOR_OWNED;
+        it->bs = NULL;
     }
 
     /* Then return the monitor-owned BDSes without a BB attached. Ignore all
diff --git a/tests/qemu-iotests/tests/inactive-node-nbd b/tests/qemu-iotests/tests/inactive-node-nbd
index 24242265b1..bb6ee5c75a 100755
--- a/tests/qemu-iotests/tests/inactive-node-nbd
+++ b/tests/qemu-iotests/tests/inactive-node-nbd
@@ -48,6 +48,7 @@ def node_is_active(_vm, node_name):
 
 with iotests.FilePath('disk.img') as path, \
      iotests.FilePath('ro.img') as ro_path, \
+     iotests.FilePath('detached.img') as detached_path, \
      iotests.FilePath('snap.qcow2') as snap_path, \
      iotests.FilePath('snap2.qcow2') as snap2_path, \
      iotests.FilePath('target.img') as target_path, \
@@ -60,6 +61,7 @@ with iotests.FilePath('disk.img') as path, \
     iotests.qemu_img_create('-f', iotests.imgfmt, path, img_size)
     iotests.qemu_img_create('-f', iotests.imgfmt, target_path, img_size)
     iotests.qemu_img_create('-f', iotests.imgfmt, ro_path, img_size)
+    iotests.qemu_img_create('-f', iotests.imgfmt, detached_path, img_size)
 
     iotests.qemu_img_create('-f', 'qcow2', '-b', path, '-F', iotests.imgfmt,
                             snap_path)
@@ -70,6 +72,9 @@ with iotests.FilePath('disk.img') as path, \
     vm.add_blockdev(f'file,node-name=disk-file,filename={path}')
     vm.add_blockdev(f'{iotests.imgfmt},file=disk-file,node-name=disk-fmt,'
                      'active=off')
+    vm.add_blockdev(f'file,node-name=detached-file,filename={detached_path}')
+    vm.add_blockdev(f'{iotests.imgfmt},file=detached-file,'
+                     'node-name=detached-fmt')
     vm.add_blockdev(f'file,node-name=target-file,filename={target_path}')
     vm.add_blockdev(f'{iotests.imgfmt},file=target-file,node-name=target-fmt')
     vm.add_blockdev(f'file,node-name=ro-file,filename={ro_path},read-only=on')
@@ -311,6 +316,17 @@ with iotests.FilePath('disk.img') as path, \
     iotests.log('snap2-fmt active: %s' % node_is_active(vm, 'snap2-fmt'))
     iotests.log('target-fmt active: %s' % node_is_active(vm, 'target-fmt'))
 
+    iotests.log('\n=== Inactivating all nodes at once ===')
+
+    # detached-fmt has no parent and no BlockBackend, so nothing can reach it
+    # by recursion. It is only inactivated if bdrv_next() actually returns it.
+    vm.qmp_log('stop')
+    vm.qmp_log('blockdev-set-active', active=False)
+
+    iotests.log('detached-fmt active: %s' % node_is_active(vm, 'detached-fmt'))
+    iotests.log('detached-file active: %s'
+                % node_is_active(vm, 'detached-file'))
+
     iotests.log('\nShutting down...')
     vm.shutdown()
     log = vm.get_log()
diff --git a/tests/qemu-iotests/tests/inactive-node-nbd.out b/tests/qemu-iotests/tests/inactive-node-nbd.out
index 3c43020053..28b1322554 100644
--- a/tests/qemu-iotests/tests/inactive-node-nbd.out
+++ b/tests/qemu-iotests/tests/inactive-node-nbd.out
@@ -243,5 +243,13 @@ snap-fmt active: True
 snap2-fmt active: True
 target-fmt active: True
 
+=== Inactivating all nodes at once ===
+{"execute": "stop", "arguments": {}}
+{"return": {}}
+{"execute": "blockdev-set-active", "arguments": {"active": false}}
+{"return": {}}
+detached-fmt active: False
+detached-file active: False
+
 Shutting down...
 
-- 
2.47.3


