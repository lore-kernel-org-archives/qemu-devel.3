Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F351C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 12:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMmuk-0004Ax-B9; Wed, 04 Jun 2025 08:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uMmu7-0003yU-FC; Wed, 04 Jun 2025 08:07:35 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uMmtz-0002Cj-HD; Wed, 04 Jun 2025 08:07:31 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 5C5CE44AF3;
 Wed,  4 Jun 2025 14:07:23 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com,
 vsementsov@yandex-team.ru, eblake@redhat.com, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it
Subject: [PATCH 4/4] iotests: add test for snapshot on top of node with
 compress filter
Date: Wed,  4 Jun 2025 14:07:17 +0200
Message-Id: <20250604120717.458445-5-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604120717.458445-1-f.ebner@proxmox.com>
References: <20250604120717.458445-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 tests/qemu-iotests/085     | 18 ++++++++++++++++++
 tests/qemu-iotests/085.out | 21 +++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/tests/qemu-iotests/085 b/tests/qemu-iotests/085
index 3fb7b0b5c8..5063e3e8d2 100755
--- a/tests/qemu-iotests/085
+++ b/tests/qemu-iotests/085
@@ -270,6 +270,24 @@ _send_qemu_cmd $h "{ 'execute': 'blockdev-snapshot',
                                     'overlay':'snap_${SNAPSHOTS}' }
                    }" "error"
 
+echo
+echo === Add snapshot in combination with compress filter ===
+echo
+
+SNAPSHOTS=$((${SNAPSHOTS}+1))
+add_snapshot_image ${SNAPSHOTS}
+
+_send_qemu_cmd $h "{ 'execute': 'blockdev-add',
+                     'arguments': { 'driver':'compress',
+                                    'node-name':'compress',
+                                    'file':'virtio0' }
+                   }" "return"
+
+_send_qemu_cmd $h "{ 'execute': 'blockdev-snapshot',
+                     'arguments': { 'node':'compress',
+                                    'overlay':'snap_${SNAPSHOTS}' }
+                   }" "return"
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/085.out b/tests/qemu-iotests/085.out
index b543b992ff..57d68f3bb9 100644
--- a/tests/qemu-iotests/085.out
+++ b/tests/qemu-iotests/085.out
@@ -255,4 +255,25 @@ Formatting 'TEST_DIR/15-snapshot-v0.IMGFMT', fmt=IMGFMT size=134217728 backing_f
                                     'overlay':'snap_15' }
                    }
 {"error": {"class": "GenericError", "desc": "Cannot find device='nodevice' nor node-name='nodevice'"}}
+
+=== Add snapshot in combination with compress filter ===
+
+Formatting 'TEST_DIR/16-snapshot-v0.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/15-snapshot-v0.IMGFMT backing_fmt=IMGFMT
+{ 'execute': 'blockdev-add', 'arguments':
+           { 'driver': 'IMGFMT', 'node-name': 'snap_16', 'backing': null,
+             'file':
+             { 'driver': 'file', 'filename': 'TEST_DIR/16-snapshot-v0.IMGFMT',
+               'node-name': 'file_16' } } }
+{"return": {}}
+{ 'execute': 'blockdev-add',
+                     'arguments': { 'driver':'compress',
+                                    'node-name':'compress',
+                                    'file':'virtio0' }
+                   }
+{"return": {}}
+{ 'execute': 'blockdev-snapshot',
+                     'arguments': { 'node':'compress',
+                                    'overlay':'snap_16' }
+                   }
+{"return": {}}
 *** done
-- 
2.39.5



