Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCA6C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x04vn-00006H-AP; Fri, 28 Aug 2026 18:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x04vl-00004w-9g
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:20:13 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x04vj-0001Mg-DR
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:20:13 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-499840a2575so9532585e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787955609; x=1788560409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=W9dl4FBJSzjursIZDzQhAMVE6DykvRtXZpBPUUvqz6E=;
 b=qEry/Ben4/AiIrwsSUY/LLgQgfPhtdFQAbNdsFFbeNEHMw4QYARy8YsMwNDLjgwAy2
 MdDFUJ+y0EyWhcxUZS4vJF3KejdHhnXTgdmzwznNeg+7oQBMBgRLEAsqi5gSXxbMcKh7
 lDqfR1+HFHxjxHKCCiHdWxGrJIu4XgcFpDFv8P+/GzISi0hXnH7pJuqzFk/pWwZHr01n
 6oGxEP1G/08+kBUj+Qkp4TwSUeR0x0KiMvQxSu+3SZPgzPjXA59MoVoJfsb5e8g3B6OB
 jbleFSLgJomZQv8oTn75pueKMl9uKgLsUlqPEARqDDh9ewWf40dQIZHJBossjBIvU9iW
 qKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787955609; x=1788560409;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W9dl4FBJSzjursIZDzQhAMVE6DykvRtXZpBPUUvqz6E=;
 b=ANY7P77keRcqBZJauMYjWOrG4TJ8vbadx6reLQJF3RJc+FYPmRqY7z0FYT5HIMHlTI
 1ZvME8To5Jh82ZOZMunYwqHkNxFSwYIRcSCiOs/9apjxDxy9Fn7nzW6ZABNSt3CbcEeu
 E8mDJRVhiENT4saHY1nvsxwerL+aBkyyFiL7dkNRGDISiMR7EZRDQ9hFgdomxxcbcAti
 sw55s2J34IqFHa/9wC2qt4+x2TO2MTrojRwkQgupTm0CIT1HwE7yIXnkNzTcQzcfhzdX
 YJqvC5ZbHieNuunYa/kG1VtLqvtlWJLbseXNv+8pDcRmVhpSY8nvVTzI4JY6Em8N2UGM
 zYXA==
X-Gm-Message-State: AFuF++np7ZT8DtBcYWESNMGPLFqVpiImUpXKjrvFwhzFsXOv8021tFEA
 cf75j+2FOf4IaQ1zQwrB2EkAcbT4103203IL+M66xAckn702glCUEGoH+neEpv90rY2I+XA4ZRf
 UMMzc
X-Gm-Gg: AR+sD12CchxYMZSYVNhRN6TNUBxG751pBvPx9Op+GaEuOrdZLk47kaBGPr7Md1VzF97
 ExTQU+u8qBZ3oXUjWMcA7KXYB6SMUzyVIH7vPYTzzjo1PTQP15uE0N5xO5D6lQ3tnx7yNlelOAW
 nMUGTt7cZ6tRRl8BEX+4MHp99Ear+Fc3CNdHdj6OWnjZnc9jHJ073R3Oe1wD36jZw6CqcT/qjKF
 UbxcLSMqnE/9C4NWjChuTcH0ijWew1XiWJT52/m5icbBE8Bqas5kRvokUnoIOphNWxfUWbiEK2H
 9uEeUh725/Xyts07r2t3rYh/4u7c30iZJzAI/4z1L93tRlaNiUTJXdYn/6F2v2Uuy9l0I82FmPe
 zzOM7Z7A55FR8wzpZjAyhsGN9oRxRO4D8OTtnI1xwPJ3ABWxYXrCrcB5W4HLCJngTGPVQ1wdmLH
 jTbhQc5qxU0TiEGaGdNJRxm9sUUt7TWOWWgU1C+uSIovozlC0J37MiXW7U0XA=
X-Received: by 2002:a05:600c:6088:b0:49b:2796:be30 with SMTP id
 5b1f17b1804b1-49b91c433a4mr158972405e9.11.1787955609089; 
 Fri, 28 Aug 2026 15:20:09 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9458:da19:ab04:373a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b95018ee8sm83329455e9.15.2026.08.28.15.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:20:08 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Fiona Ebner <f.ebner@proxmox.com>, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH] block: fix bdrv_next() skipping monitor-owned nodes
Date: Sat, 29 Aug 2026 00:20:05 +0200
Message-ID: <20260828222005.2888213-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=den@openvz.org; helo=mail-wm1-x334.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Denis V. Lunev <den@openvz.org>

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

Fixes: f6d38c9f6d ("block-backend: fix edge case in bdrv_next() where BDS associated to BB changes")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Fiona Ebner <f.ebner@proxmox.com>
Cc: Kevin Wolf <kwolf@redhat.com>
---

Notes:
    The iterator was correct from its introduction in 2016 until 2024:
    it->bs was written only by the second phase, and the node to unreference
    came from the BlockBackend instead.

    f6d38c9f6d's own reproducer does not fire for me, 240 runs across 8
    timings, even with its fix reverted. Tried hard.

 block/block-backend.c                          |  1 +
 tests/qemu-iotests/tests/inactive-node-nbd     | 16 ++++++++++++++++
 tests/qemu-iotests/tests/inactive-node-nbd.out |  8 ++++++++
 3 files changed, 25 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 37ba7e9fc4..55497c4551 100644
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
index 664157bfd0..ef876ae6be 100755
--- a/tests/qemu-iotests/tests/inactive-node-nbd
+++ b/tests/qemu-iotests/tests/inactive-node-nbd
@@ -47,6 +47,7 @@ def node_is_active(_vm, node_name):
     return node['active']
 
 with iotests.FilePath('disk.img') as path, \
+     iotests.FilePath('detached.img') as detached_path, \
      iotests.FilePath('snap.qcow2') as snap_path, \
      iotests.FilePath('snap2.qcow2') as snap2_path, \
      iotests.FilePath('target.img') as target_path, \
@@ -58,6 +59,7 @@ with iotests.FilePath('disk.img') as path, \
     iotests.log('Preparing disk...')
     iotests.qemu_img_create('-f', iotests.imgfmt, path, img_size)
     iotests.qemu_img_create('-f', iotests.imgfmt, target_path, img_size)
+    iotests.qemu_img_create('-f', iotests.imgfmt, detached_path, img_size)
 
     iotests.qemu_img_create('-f', 'qcow2', '-b', path, '-F', iotests.imgfmt,
                             snap_path)
@@ -68,6 +70,9 @@ with iotests.FilePath('disk.img') as path, \
     vm.add_blockdev(f'file,node-name=disk-file,filename={path}')
     vm.add_blockdev(f'{iotests.imgfmt},file=disk-file,node-name=disk-fmt,'
                      'active=off')
+    vm.add_blockdev(f'file,node-name=detached-file,filename={detached_path}')
+    vm.add_blockdev(f'{iotests.imgfmt},file=detached-file,'
+                     'node-name=detached-fmt')
     vm.add_blockdev(f'file,node-name=target-file,filename={target_path}')
     vm.add_blockdev(f'{iotests.imgfmt},file=target-file,node-name=target-fmt')
     vm.add_blockdev(f'file,node-name=snap-file,filename={snap_path}')
@@ -297,6 +302,17 @@ with iotests.FilePath('disk.img') as path, \
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
index a458b4fc05..48451dc0c5 100644
--- a/tests/qemu-iotests/tests/inactive-node-nbd.out
+++ b/tests/qemu-iotests/tests/inactive-node-nbd.out
@@ -235,5 +235,13 @@ snap-fmt active: True
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
2.53.0


