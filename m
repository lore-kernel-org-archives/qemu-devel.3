Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0A4CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUbF-0002vi-RE; Wed, 07 Oct 2026 12:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUb5-0002sa-3v
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUb2-0006Ik-5d
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791390863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ehYZfi6ewcevy0iV2JWMOEC3cYURQVi8rsF6omdyiVA=;
 b=SoEG10Yc+5CL1z9kmwnI7VXbBdQGxx9BYcGeKQxjbPqKZrIVY7vGpicViuJcqWHwb+FGdx
 TcMpEv8NZjND8+wzXaRqxKlSGn3QtLdvMPlw/g7sM05Np7zE1MOGta/KlUuZGJEqUvmTqq
 X7hBebviRN6Z56dWwPEdBKpp1QoUvE8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-KLYCbSnSM1SbCBZdl_eOjw-1; Wed,
 07 Oct 2026 12:34:20 -0400
X-MC-Unique: KLYCbSnSM1SbCBZdl_eOjw-1
X-Mimecast-MFC-AGG-ID: KLYCbSnSM1SbCBZdl_eOjw_1791390859
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F36F91809C87; Wed,  7 Oct 2026 16:34:18 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 908741956087; Wed,  7 Oct 2026 16:34:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 03/21] block: fix bdrv_next() skipping monitor-owned nodes
Date: Wed,  7 Oct 2026 18:32:44 +0200
Message-ID: <20261007163302.332250-4-kwolf@redhat.com>
In-Reply-To: <20261007163302.332250-1-kwolf@redhat.com>
References: <20261007163302.332250-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 block/block-backend.c                          |  1 +
 tests/qemu-iotests/tests/inactive-node-nbd     | 16 ++++++++++++++++
 tests/qemu-iotests/tests/inactive-node-nbd.out |  8 ++++++++
 3 files changed, 25 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 5e59bac1a3c..ab837fac921 100644
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
index 24242265b16..bb6ee5c75ab 100755
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
index 96af7608ded..5ff0063ec46 100644
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
2.56.0


