Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3826BC5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwf3o-00048P-61; Wed, 19 Aug 2026 08:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwf3f-00045e-0Y
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:06:18 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwf3W-0007qB-7X
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:06:14 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47f7872abb6so501269f8f.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 05:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787141165; x=1787745965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pmb9e2aAFvXxu+UaCLIym+x4WJEYWHUpLcXH/GTdPrQ=;
 b=CFTB46OJfxzqJNE1pXUOoCKvB8t8FRynuGNeiC1bJ2ql8oQ5KfQKNED7Zx3zQ/0QbD
 myYtPFfpRdeVg5DGIPmaUXclGZQmXde+1x8DbQkU71193lRB0McF2wnjPZfZf5y9CaI6
 0xDYmocXGGJ80DYME30vOs1cTyyhKgVn7pE48nTbQxjL3tZCfZk8QLEVYSRNTuEW8gVq
 GbbkVHwTIusGucg4KrZawor6sUSx2zEK5jUKxc/oVbDQIlE7VsCBnVNN4raugQ8V2AiV
 8D0HtRrcoLpxrCOxyVpV1XPVElI0sEYlBwjPNXogBhLIsZWXeNnjPIf/ZTyov1g0fhdi
 eknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787141165; x=1787745965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pmb9e2aAFvXxu+UaCLIym+x4WJEYWHUpLcXH/GTdPrQ=;
 b=C9gM3KSsvQ8zylBys8MnPF+QQA6Gi/zEiKKbXUe4amU0xACGNkGdld4B88yng7n+dr
 wvdUz2Z38kvy548eUiriiNnIInH8zVurfN6WcCC5WOZMF1XH8mAStRQVrDOVRXjcVMpz
 YIo+w5tCHEMJ0apwA3ZsBwW3jPS4nYyaWRFqdRkJRj3dJa1S+ROTzP17xvE+bQWsum9v
 lSo0qoJbdiSPRBUXiuV9lxBhqCwMD38vtuqWesWPBgRWxAG879ZPD7YeBWEWmNfUdHJb
 i8lMn4k9UX8nVgvqTphnbnsz5K1axL7lf8Q/SjemrS5ZDMpoNi16J1R2zf5tNwUoqa2a
 qWcA==
X-Gm-Message-State: AOJu0Yy+JvXs1bzF+fnCQQ4k3VquJ5ZJU+UmtVExB21PAe35JXP/oT7F
 IyPJRQJ/sS3YC44YtHJpq5yaKt7AiZgpAg9BlzcSbtR4z4eIBRbcJpw+tVWJ1//xSAsmeWpknvA
 AcRLs
X-Gm-Gg: AR+sD12AJicQE3mB2TgGe5pHzxEqUJtLXfNhew1xXzIjXcIDXTSX5A3Bx9e8coAMpLP
 xsU6+w4iuNUGQKkPXIpYtAj5vJg+zKubfmoKhN8/2D/FCh0yeVWDs1KdPzSzBRsQ00u1twJSVL6
 tSNYawp6lojnmQDQZc8+HX/kxsCB04NCHEqx3beEG2yuMLQAhTQ5Ge4QPSboRySfNkksq2sGMyf
 ghEdrMirZKyXT5xRg7JW+zL1OFtyRP4/kUOAIClBNKbjnREMtSUXre4b/z5d02Ah8zw1dzIR/8q
 kdeYWgPCtP7hjKA59vMM/2zGQhLtm33wlK754KE7LuYU+TNeU8bnwPBDFkJJ7Guvg4hEBXpCGAq
 KoxGOqk8cMjBUqcA0eu6Y5qWmocEf34zcbg13N99Q0hFAjN0l7JbG2vW8mWq8weRMFIYuhgvhv5
 WdrzAbjggZLGyVTbf79+AM+m9AgBiR6yygfIsVzCWEVBQQXvM75IMTOmqkkQ==
X-Received: by 2002:a05:600c:19c7:b0:495:7a04:b006 with SMTP id
 5b1f17b1804b1-499aa192422mr61140545e9.8.1787141164426; 
 Wed, 19 Aug 2026 05:06:04 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:258d:1706:7089:f765])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1111a7sm59244785e9.6.2026.08.19.05.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 05:06:03 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v3 2/5] block: reject a reopen of an unusable node instead of
 crashing
Date: Wed, 19 Aug 2026 14:05:55 +0200
Message-ID: <20260819120558.3870413-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819120558.3870413-1-den@openvz.org>
References: <20260819120558.3870413-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=den@openvz.org; helo=mail-wr1-x433.google.com
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
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
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


