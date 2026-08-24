Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D18EC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUru-0003qZ-HH; Mon, 24 Aug 2026 09:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyUrs-0003o1-0o
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:37:40 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyUro-0002ab-FK
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:37:39 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so890666366b.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 06:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787578655; x=1788183455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tT1pWzDf1PzRnWrUuIrKA5QxwcckvDOrTMYkBiLpWdc=;
 b=JOgAM1j/rIn5cOhgDXJfIxXUlVkB0XcviSkSZE8q2kGhDaGCr8IKOouhZk0COpaU7d
 E/c298VM4hqm+E5GejZcBWegZ7jJNX5ci+pTc+TBKthJ+deDcMe7MpZvUeXZHlBMJOzp
 4u7dEsnVMmqR2SbS3LobXZUTqAx7q9w/ixwnL1ESfSS9kAVEzJR3Ey5hdfIr7+UHo5zj
 h4diJLpeUToCCXn1OdryQ/FvNh6QqUBCn0NOk4SzDgM6FbVe93oFe+5tLEdtXYZtmSyg
 4R6Bh3l/tbLmCcIbrecDvK5b0WVqAqfgAutl8tBlCtjcjNaxGroFjHCEBHj2sV5lwqgN
 777Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787578655; x=1788183455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tT1pWzDf1PzRnWrUuIrKA5QxwcckvDOrTMYkBiLpWdc=;
 b=OzCflVbxTSyo8LkwAE7XzYUmRmTna6XBVXsLHYlasGPIlvSFW9CJyoI/W0oB2+vGKK
 nZzbdjUBGFzOrdEtxxIflFn4Z8SfEIkyirZSwkaVWk6cDxzo/xHftco+8x7s7yrqXbC7
 xwlDnshYw8LZJMu4PW8uXS5pMF7EU0FAPv3FpngaYdbals1Plcoq3pDjLCOzv0CkB387
 h64RQOZvUyUGbDH+iqffjSK5EXHw6VvGy0T99oEmdRhnC2s4xwSuCmh2qNzTMvBe5/d4
 pAXSPedybixn8k4xe3DWkASalWc3spmPt8crQ+2ZTQGOynPZIOV9gmPZlwgav7VxzjSW
 frSQ==
X-Gm-Message-State: AFuF++nGnHbguXMiyIlIoiavLJ7nK2/jQTG7mEwGlOZ25SewaSNpGaDE
 t3yudPTJmOzmXbfqyh3nCa6hH7Vyeey2SEVrQE9FFmzCm2qswndqRYv2d5GAx8Uii37nUVHLeNT
 rCXsB
X-Gm-Gg: AR+sD10fPnwZVLiMABQ2USlME7cuvC+vQLGKsQmwVCn4KYjUT+24wupqeRieY9L5fR4
 x1J6MReB8SuEg+7d+/hhy5VsDwhSLYhxePihHmlVVfzEnMxmMtjD5Z+Nd0fBGtaRDVwUAN4dmUh
 zzXt3mWwJHDxWuIYgO/J6DCoGV4eqAJhBEIBhl5TiBuqS/HWF6Eg63T6lFDFV3WxQAo4Gm5yJ6h
 W4XQ85UGX+zdEPz1k2I6Ej/91CHD+otpqFm3Vw8K6kvzWxq1n5D3XCVDGMYGH0GCJTSeqUQxbmM
 vdnchz9WDceqN9DpbPsRQX7O3DgV+JyXVlKeZW2kiU32ODfjS3UWVFYVbanlaxsv1WTz2o/WCNT
 X5oozPbuDBZdeqQlIL61u2F5gY1WGlIiw0Ezm3dYfMBJPzd2UTv+rW6q4drN47AfP086Hn2xIkt
 a9KoigavZ6zybtOuKVX+oB4grh3ZpxMU9l8aKFipz/A4U0MnzpRfBfgoEyBg==
X-Received: by 2002:a17:907:3e89:b0:c21:7c98:d9ec with SMTP id
 a640c23a62f3a-c244d6349a2mr3085489266b.5.1787578654840; 
 Mon, 24 Aug 2026 06:37:34 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9048:7bf0:d3e2:2b9e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f58dfsm1236658166b.38.2026.08.24.06.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:37:34 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v4 2/5] block: reject a reopen of an unusable node instead of
 crashing
Date: Mon, 24 Aug 2026 15:37:26 +0200
Message-ID: <20260824133729.1141990-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824133729.1141990-1-den@openvz.org>
References: <20260824133729.1141990-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=den@openvz.org; helo=mail-ej1-x62b.google.com
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

qcow2_signal_corruption() drops bs->drv, so a node can lose its driver
at any time and a reopen has to expect that. Both ends of the path
assume otherwise:

  $ qemu-io -c "read 0 64k" -c "reopen -r" corrupt.qcow2
  qcow2: Marking image as corrupt: Cluster allocation offset 0x1200
  unaligned (L2 offset: 0x40000, L2 index: 0); ...
  Segmentation fault

bdrv_reopen_queue_child() dereferences bs->drv while descending into
the children the node opened itself, and bdrv_reopen_prepare() asserts
on it. commit_clean() reopens the base of a commit job back to
read-only, so a base which goes corrupt under the job arrives here too.

There is nothing to reopen for such a node, so stop descending into its
children and let bdrv_reopen_prepare() report what every caller of
bdrv_reopen() already handles. bdrv_reopen_commit() and
bdrv_reopen_abort() keep their assertion, only a prepared entry reaches
them.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-stable@nongnu.org
---
 block.c                    | 14 +++++++++++++-
 tests/qemu-iotests/060     | 30 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/060.out | 13 +++++++++++++
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index f0a6042e61..e39f15816a 100644
--- a/block.c
+++ b/block.c
@@ -4486,6 +4486,11 @@ bdrv_reopen_queue_child(BlockReopenQueue *bs_queue, BlockDriverState *bs,
             !qdict_haskey(options, "backing.driver");
     }
 
+    /* An unusable node is rejected by bdrv_reopen_prepare(), do not descend */
+    if (!bs->drv) {
+        return bs_queue;
+    }
+
     QLIST_FOREACH(child, &bs->children, next) {
         QDict *new_child_options = NULL;
         bool child_keep_old = keep_old_opts;
@@ -4881,9 +4886,16 @@ bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
     bool drv_prepared = false;
 
     assert(reopen_state != NULL);
-    assert(reopen_state->bs->drv != NULL);
     GLOBAL_STATE_CODE();
+
     drv = reopen_state->bs->drv;
+    if (drv == NULL) {
+        GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+        error_setg(errp, "Block node '%s' has no driver left to reopen",
+                   bdrv_get_device_or_node_name(reopen_state->bs));
+        return -ENOMEDIUM;
+    }
 
     /* This function and each driver's bdrv_reopen_prepare() remove
      * entries from reopen_state->options as they are processed, so
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 5cd21a6f68..ce49fc34ec 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -486,6 +486,36 @@ echo
 # Image should not have been marked corrupt
 _img_info --format-specific | grep 'corrupt:'
 
+echo
+echo "=== Testing the reopen of an image corrupted at runtime ==="
+echo
+
+_make_test_img 64M
+poke_file "$TEST_IMG" "$l1_offset" "\x00\x00\x00\x00\x2a\x2a\x2a\x2a"
+
+# The read leaves the node unusable, the reopen must report that
+echo "{'execute': 'qmp_capabilities'}
+      {'execute': 'human-monitor-command',
+       'arguments': {'command-line': 'qemu-io drive \"read 0 512\"'}}
+      {'execute': 'blockdev-reopen',
+       'arguments': {'options': [{'node-name': 'drive',
+                                  'driver': 'qcow2',
+                                  'read-only': true,
+                                  'file': {
+                                      'driver': 'file',
+                                      'filename': '$TEST_IMG'
+                                  }}]}}
+      {'execute': 'quit'}" \
+    | $QEMU -qmp stdio -nographic -nodefaults \
+            -blockdev "{'node-name': 'drive',
+                        'driver': 'qcow2',
+                        'file': {
+                            'driver': 'file',
+                            'filename': '$TEST_IMG'
+                        }}" \
+            2>&1 \
+    | _filter_qmp | _filter_qemu_io
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index a37bf446e9..ad1912a43b 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -436,4 +436,17 @@ qcow2: Image is corrupt: L2 table offset 0x2a2a2a00 unaligned (L1 index: 0); fur
 {"return": {}}
 
     corrupt: false
+
+=== Testing the reopen of an image corrupted at runtime ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+QMP_VERSION
+{"return": {}}
+qcow2: Marking image as corrupt: L2 table offset 0x2a2a2a00 unaligned (L1 index: 0); further corruption events will be suppressed
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_IMAGE_CORRUPTED", "data": {"device": "", "msg": "L2 table offset 0x2a2a2a00 unaligned (L1 index: 0)", "node-name": "drive", "fatal": true}}
+read failed: Input/output error
+{"return": ""}
+{"error": {"class": "GenericError", "desc": "Block node 'drive' has no driver left to reopen"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 *** done
-- 
2.53.0


