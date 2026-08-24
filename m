Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53ECC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUru-0003pb-1A; Mon, 24 Aug 2026 09:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyUrq-0003mK-9O
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:37:38 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyUrn-0002aD-5x
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:37:38 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c15cf78d1a2so394268766b.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787578654; x=1788183454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DEtOnidl3ou2oeXSipGVMeNr8jrN0dWWhLCJjPRUG+M=;
 b=t5xqf9ohc3T81fZ8kR5NL4EV6cmBQ8ielBV0/ppefeyJ45ElMJVCWJk73mIqScZHT5
 rNW1EO+mHxVZfrTmQrlTgs1Yk+m+bEqInou21zAXqk3/S6NKhTp90ipOtUegV0vQ4guW
 uSUdl8ejL00HPYOdYdNphMJF6gmGV7qStbExj8WfdnNHZauKvOjSET01qZtwe9vPhZhG
 fYEhFZ1M3cEv9EYQjGCFLtqMlUrDPe5XSMTxn9y43FOqshbu5i+rdbsxnlQvazio07p5
 iUaBxi2kTBVuaojkqF10GrEbA3ufaTf5uOgAZy/O9j0vxlfHRQNK6IyK+JILgDPlWBR2
 FBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787578654; x=1788183454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DEtOnidl3ou2oeXSipGVMeNr8jrN0dWWhLCJjPRUG+M=;
 b=FTh3o0THrCf1SpaXOBl5rr5YjC92mIWRoaFsqhSYmJB0FukMkaMh3UVPby8LgKhxQN
 IW5yTjEkHpV9bKSzKgEQ0IG7uvSZIgEXcX73CktxD1KYdzUN0psmOeBfwYSUgKByYIqE
 hPdXlkHhaXyO8EURDP5MWMAv7alfQeZTOn5GxZTVQsWub9eJp8RJnyKyDiR/4U5R5BL9
 IWVUuoghwHBVQ0HXfHTPVpJ4QBj9sUUTXWMLU+xZzRJxZUMJ8gg7SrXJvz2Rcn63spkY
 j57DVsPwSkXtzSGLRhTqAVT8laJ3OQsE9mJ1/RxLD8xI5Jf2IgZRf6du2ty0GclIYpB0
 SrJg==
X-Gm-Message-State: AFuF++kRnm7TIMvIfmMGDEbuuRYAU7miBTKXcEJIL3wIJfmUQCuHyOur
 AiDwsdJ096vAF2djPQcHFGXnpQwwEoMuI1AY37ni3FGhaYugLPQgL1GQVNYsYVpjpXw7KgIb+1c
 yEIb+
X-Gm-Gg: AR+sD13IqX8ZnEFTKJ5r/wuCEhzxrAG1ygNFYUrLpE2as6kKd1WUHJsBCJg+Q0oOZCK
 ZX9OYDTwvXvY308K5g1/TZ7hATi7WXvHbyNGqVzha36ii1UVqlCfPEHGJtkFt839QEa8vSjuRlJ
 GkxxvD0luWBYTS6sMQjKzQaUQklT8CpY7FQpAV2r0ocCAID+ZHltu+f+uaGOF05lNVgQ47jas8M
 IIFRrfGZnPVYnUPxJ1F3pTTRB/fRcrUKI0S/n2JcjELkEN67LqhxuaSHBpbhz2Eu6zDoDXnJ2ZS
 tMv+wg7XFysYpLxRG8lfFlSrhC/J+k6S/g/j3XdYwphNExvMsCmnJinahfQi6HWtBFPzcqEzcNA
 IRyFbaEmNJ5bTz/AY5d8hSOzqydFyw9RtbqfPqpJPklXT2d/9WFfsuh235mVHh5bdVMiARQZ+Lr
 ACUuVXwfYopb3cgMAusGotMjOsHWvAlIzGsXUpS1DRQ1CAAn0HW3fwfNmF2w==
X-Received: by 2002:a17:907:6d15:b0:c24:4128:c19d with SMTP id
 a640c23a62f3a-c246a2e9378mr2726316666b.4.1787578653591; 
 Mon, 24 Aug 2026 06:37:33 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9048:7bf0:d3e2:2b9e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f58dfsm1236658166b.38.2026.08.24.06.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:37:33 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v4 1/5] qcow2: do not clear the dirty bit when reopening a
 read-only node
Date: Mon, 24 Aug 2026 15:37:25 +0200
Message-ID: <20260824133729.1141990-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824133729.1141990-1-den@openvz.org>
References: <20260824133729.1141990-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=den@openvz.org; helo=mail-ej1-x632.google.com
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

qcow2_reopen_prepare() clears the dirty bit whenever the node is
reopened read-only, with an unguarded header write. A read-only node
can still be dirty, inherited from an earlier writable session, and it
holds no BLK_PERM_WRITE to resolve that. A read-only to read-only
reopen of a dirty image therefore fails outright:

  $ qemu-io -r -f qcow2 dirty.qcow2 <<< $'reopen -r\nquit'
  qemu-io: failed while preparing to reopen image 'dirty.qcow2'

Where the file node below is writable the write is not refused early,
and bdrv_co_write_req_prepare() aborts on its BLK_PERM_WRITE assertion
instead.

Clear it only for a node that is writable now, the predicate
qcow2_do_open() already uses for the repair. bdrv_is_writable() also
excludes an inactive node, whose header must not be touched either.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-stable@nongnu.org
---
 block/qcow2.c              |  8 +++---
 tests/qemu-iotests/039     | 50 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/039.out | 20 +++++++++++++++
 3 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7292dd036c..1543255eba 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2102,9 +2102,11 @@ qcow2_reopen_prepare(BDRVReopenState *state,BlockReopenQueue *queue,
             goto fail;
         }
 
-        ret = qcow2_mark_clean(state->bs);
-        if (ret < 0) {
-            goto fail;
+        if (bdrv_is_writable(state->bs)) {
+            ret = qcow2_mark_clean(state->bs);
+            if (ret < 0) {
+                goto fail;
+            }
         }
     }
 
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index 94a8bfe754..3d0c073d65 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -95,6 +95,40 @@ $QEMU_IMG info --image-opts \
 # The dirty bit must still be set: this open never wrote any guest data
 _qcow2_dump_header | grep incompatible_features
 
+echo
+echo "== Read-only reopen must not clear the dirty bit =="
+
+# A read-only node cannot write the header, and must keep the dirty bit
+$QEMU_IO -r -c "reopen -r" -c "read -P 0x5a 0 512" "$TEST_IMG" \
+    | _filter_qemu_io
+
+# The dirty bit must still be set
+_qcow2_dump_header | grep incompatible_features
+
+echo
+echo "== Read-only reopen must not write through a writable file node =="
+
+# The write the header update needs is refused by the permission system
+echo "{'execute': 'qmp_capabilities'}
+      {'execute': 'blockdev-reopen',
+       'arguments': {'options': [{'node-name': 'drive',
+                                  'driver': 'qcow2',
+                                  'read-only': true,
+                                  'file': 'prot'}]}}
+      {'execute': 'quit'}" \
+    | $QEMU -qmp stdio -nographic -nodefaults \
+            -blockdev "{'node-name': 'prot',
+                        'driver': 'file',
+                        'filename': '$TEST_IMG'}" \
+            -blockdev "{'node-name': 'drive',
+                        'driver': 'qcow2',
+                        'file': 'prot',
+                        'read-only': true}" \
+    | _filter_qmp
+
+# The dirty bit must still be set
+_qcow2_dump_header | grep incompatible_features
+
 echo
 echo "== Repairing the image file must succeed =="
 
@@ -108,6 +142,22 @@ echo "== Data should still be accessible after repair =="
 
 $QEMU_IO -c "read -P 0x5a 0 512" "$TEST_IMG" | _filter_qemu_io
 
+echo
+echo "== A read-write to read-only reopen must clear the dirty bit =="
+
+_make_test_img -o "compat=1.1,lazy_refcounts=on" $size
+
+# The kill keeps the close from clearing the bit, so the header shows what
+# the reopen did with it
+_NO_VALGRIND \
+$QEMU_IO -c "write -P 0x5a 0 512" \
+         -c "reopen -r" \
+         -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
+    | _filter_qemu_io
+
+# The dirty bit must not be set
+_qcow2_dump_header | grep incompatible_features
+
 echo
 echo "== Opening a dirty image read/write should repair it =="
 
diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
index c66361128f..ce8ee57721 100644
--- a/tests/qemu-iotests/039.out
+++ b/tests/qemu-iotests/039.out
@@ -27,6 +27,19 @@ incompatible_features     [0]
 == Read-only open must not crash on close ==
 incompatible_features     [0]
 
+== Read-only reopen must not clear the dirty bit ==
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+incompatible_features     [0]
+
+== Read-only reopen must not write through a writable file node ==
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+incompatible_features     [0]
+
 == Repairing the image file must succeed ==
 ERROR cluster 5 refcount=0 reference=1
 Rebuilding refcount structure
@@ -45,6 +58,13 @@ incompatible_features     []
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
+== A read-write to read-only reopen must clear the dirty bit ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+wrote 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+./common.rc: Killed ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
+incompatible_features     []
+
 == Opening a dirty image read/write should repair it ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 wrote 512/512 bytes at offset 0
-- 
2.53.0


