Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00B7C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 16:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgm0d-0003Nu-KS; Mon, 06 Jul 2026 12:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wgm0D-0003IT-VG
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:17:10 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wgm07-00071k-2P
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:16:58 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-39b268e608eso23006481fa.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 09:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1783354612; x=1783959412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dr8pqgO9ncY3sE5trjG/un8CT0S6+ugozJlCn+Ohclk=;
 b=WZne4r57JT4o+zyhmR1L26F5j6a4MkdsFok/1DKVVH/b5VhXJq47aLxOE65L9rUGoK
 eX3gmZmLoOqDqF0CZzCgvkdp5y0Phg8AKVI3jnhB7DtmkMZQsmQ+yXtrNA59VqrXF7qn
 bSctKPmW5p9TkISvRKuqoyRAHav2/wbFbnse0ZCBMPJ8nrG4uNN9V6UiSV5B6HQZISV7
 XpwI9eCArc7fPE2H1ZGlMCYJWSMq3IBdA9k02X8MsMX2IDXKTbsJkeNJ7rUzzECCfvP2
 B1Za3ULMC3euIY84o2e5XNtx6fQeEuzk3ijMqr5RblCR7CM37xVRy4JlUbYINGypwnGq
 o39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783354612; x=1783959412;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dr8pqgO9ncY3sE5trjG/un8CT0S6+ugozJlCn+Ohclk=;
 b=rzP3lEc4qchEw4/FSfwpk2v5NfrrcsqCuYyN/LbJg8Yq2MrMDx1FwVyA2OeY3FrqdJ
 iSmjQPv6adnFAtusek9uljuGlxHpUAtVVsk1lK1bUlWokhg2eWtrS6aqIiR8C6h0u1yT
 IW5Pobl/yOvzEMZTXDPIoF1coC6pFlj+qM5LraKhCVsXMMM+jzeeb+AQHJVJcLix8P+y
 /bXU5VyFYaMNOi0hOw/XwckGZrEw1bRU3VDjwPR/qEAtFxiYJojfXXWdTCIkaB7iz2o3
 seXfx1isYwkENoG+u4gijUG8G2LwKDjVAKyWgFAz9SXSbgXZ3cJq92yTCj1WYSRM+49i
 Q6/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqensjsys7f2Ml55pgNZcnu10kgiUMLNJQV7MVVa/9vAI+uzVmAUteKx/FzzAaSsCGiMHwM58e7/Rtt@nongnu.org
X-Gm-Message-State: AOJu0YyrSTn4XGmR7N2MtdvlxqoXjVe14rCSg+l6VMTUy74J9oTq8mHt
 GeQb9iNOE8SMWrY2+HqTkweUsKa2Z/K5iqk8mtDQNbotsvFrIJYypyKbZ9iZW3MvQZk=
X-Gm-Gg: AfdE7cnz4h1teSWHyxdB23VO4Yu0rPMbbS1p9u4CiiNuk6Dpbl7Sv40cfKhpyrnC+cV
 Ny1ApUpeuVLU/bqsL86UR+zN+w6rVvWzXwTMAY8FwZSDWAIhf4QSztXUtte1L2gcUzehURKTrAQ
 N/q69Ldtbw19vsyrTRXglRsVUrRts3OIcF/o14vvFvi+olD+07nGjQitp0FQFCJtE6MLzQTIQRz
 cl44a0kOPIdk36n4EciAmgBiuzwV7Tc37VP5g1KoAPiKOPJ0R7j1jDxV5BdlzKUbmBQ/zWePX57
 JGbCBnNijlwdYmkiDCUCE+XRx+DowlJev++zOt251DD2zHfREpLfiaE/81NVaCA45a/xvBr4ieE
 8+aEYvLpK45+oAyA/qIji0nw0wFsgOIVSm8WPTZrkEAdzMXNaNkIxOCnpEIz4npQ8lhvHzH4Wlr
 Mh4xe2nhVeEg==
X-Received: by 2002:a05:6512:66c1:10b0:5ae:a9ec:9fc3 with SMTP id
 2adb3069b0e04-5b007c09780mr214671e87.62.1783354611270; 
 Mon, 06 Jul 2026 09:16:51 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:1f33:7d58:cc65:7668])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed13bb685sm2985296e87.46.2026.07.06.09.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 09:16:49 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 1/1] block/monitor: force read-only on live-added persistent
 bitmap
Date: Mon,  6 Jul 2026 18:16:45 +0200
Message-ID: <20260706161645.515304-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=den@openvz.org; helo=mail-lj1-x22b.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

qmp_block_dirty_bitmap_add() marks a new bitmap persistent without
checking write access to its node. bdrv_create_dirty_bitmap() always
creates bitmaps writable, so a persistent bitmap added live to an
already read-only node stays writable in memory on a node that can
never store it. The next global inactivation (migration completion,
save, or any other bdrv_inactivate_all() caller) then fails trying to
flush it back:

  Lost persistent bitmaps during inactivation of node '<node>': No write access
  migration_block_inactivate: bdrv_inactivate_all() failed: -22

qcow2_load_dirty_bitmaps() and qcow2_reopen_bitmaps_ro() already force
a persistent bitmap read-only when its node is read-only; do the same
right after the bitmap is marked persistent, whether it arrived
through a plain block-dirty-bitmap-add or the transaction action that
calls the same function. qcow2_reopen_bitmaps_rw() already promotes
any persistent, read-only bitmap back to writable once its node is
reopened read-write, so the reverse direction needs no changes.

Also check BDRV_O_INACTIVE, matching qcow2's private can_write()
helper, to cover adding a bitmap to a node that is already inactive.
Document the new behavior on BlockDirtyBitmapAdd.persistent.

Extend remove-bitmap-from-backing to cover this: add a persistent
bitmap live to the already read-only "base" node, then inactivate all
nodes the way migration completion, virsh save and qemu-update do, and
check the bitmap ends up as protected as one already on disk.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
---
 block/monitor/bitmap-qmp-cmds.c                  |  9 +++++++++
 qapi/block-core.json                             |  4 +++-
 .../tests/remove-bitmap-from-backing             | 16 ++++++++++++++++
 .../tests/remove-bitmap-from-backing.out         | 11 +++++++++++
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/block/monitor/bitmap-qmp-cmds.c b/block/monitor/bitmap-qmp-cmds.c
index a738e7bbf7..1f2c0c9cbc 100644
--- a/block/monitor/bitmap-qmp-cmds.c
+++ b/block/monitor/bitmap-qmp-cmds.c
@@ -141,6 +141,15 @@ void qmp_block_dirty_bitmap_add(const char *node, const char *name,
     }
 
     bdrv_dirty_bitmap_set_persistence(bitmap, persistent);
+
+    /*
+     * A persistent bitmap on a node that can't be written must not be
+     * writable either, same as one loaded from or reopened onto it.
+     */
+    if (persistent &&
+        (bdrv_is_read_only(bs) || (bdrv_get_flags(bs) & BDRV_O_INACTIVE))) {
+        bdrv_dirty_bitmap_set_readonly(bitmap, true);
+    }
 }
 
 BdrvDirtyBitmap *block_dirty_bitmap_remove(const char *node, const char *name,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1f87b07850..a52397922b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2353,7 +2353,9 @@
 # @persistent: the bitmap is persistent, i.e. it will be saved to the
 #     corresponding block device image file on its close.  For now
 #     only Qcow2 disks support persistent bitmaps.  Default is false
-#     for `block-dirty-bitmap-add`.  (Since: 2.10)
+#     for `block-dirty-bitmap-add`.  If the node is read-only, the
+#     bitmap is created read-only instead, the same as a persistent
+#     bitmap already stored on such a node.  (Since: 2.10)
 #
 # @disabled: the bitmap is created in the disabled state, which means
 #     that it will not track drive changes.  The bitmap may be enabled
diff --git a/tests/qemu-iotests/tests/remove-bitmap-from-backing b/tests/qemu-iotests/tests/remove-bitmap-from-backing
index 15be32dcb9..61e1f3f10f 100755
--- a/tests/qemu-iotests/tests/remove-bitmap-from-backing
+++ b/tests/qemu-iotests/tests/remove-bitmap-from-backing
@@ -66,6 +66,22 @@ result = vm.qmp('blockdev-reopen', **new_base_opts)
 if result != {'return': {}}:
     log('Failed to reopen: ' + str(result))
 
+# A bitmap added live (not loaded from disk) must be protected the same
+# way as bitmap0 above once its node is read-only.
+log('Adding a persistent bitmap live to the r-o base node:')
+vm.qmp_log('block-dirty-bitmap-add', node='base', name='bitmap1',
+          persistent=True)
+
+# Inactivate globally, like migration completion/save/qemu-update do;
+# inactivating "base" directly would hit an unrelated guard, since it is
+# a backing child of the still-active "top".
+log('Inactivating all nodes must not fail flushing bitmap1:')
+vm.qmp_log('blockdev-set-active', active=False)
+vm.qmp_log('blockdev-set-active', active=True)
+
+log('Trying to remove the live-added bitmap, should fail same as bitmap0:')
+vm.qmp_log('block-dirty-bitmap-remove', node='base', name='bitmap1')
+
 vm.shutdown()
 
 if 'bitmaps' in qemu_img_info(base)['format-specific']['data']:
diff --git a/tests/qemu-iotests/tests/remove-bitmap-from-backing.out b/tests/qemu-iotests/tests/remove-bitmap-from-backing.out
index c28af82c75..ea492d167f 100644
--- a/tests/qemu-iotests/tests/remove-bitmap-from-backing.out
+++ b/tests/qemu-iotests/tests/remove-bitmap-from-backing.out
@@ -4,3 +4,14 @@ Trying to remove persistent bitmap from r-o base node, should fail:
 Remove persistent bitmap from base node reopened to RW:
 {"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0", "node": "base"}}
 {"return": {}}
+Adding a persistent bitmap live to the r-o base node:
+{"execute": "block-dirty-bitmap-add", "arguments": {"name": "bitmap1", "node": "base", "persistent": true}}
+{"return": {}}
+Inactivating all nodes must not fail flushing bitmap1:
+{"execute": "blockdev-set-active", "arguments": {"active": false}}
+{"return": {}}
+{"execute": "blockdev-set-active", "arguments": {"active": true}}
+{"return": {}}
+Trying to remove the live-added bitmap, should fail same as bitmap0:
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap1", "node": "base"}}
+{"error": {"class": "GenericError", "desc": "Bitmap 'bitmap1' is readonly and cannot be modified"}}
-- 
2.53.0


