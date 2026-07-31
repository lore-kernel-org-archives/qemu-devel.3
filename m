Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF849C55173
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 22:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpvHi-00066L-0v; Fri, 31 Jul 2026 18:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpvHc-00064C-BX
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 18:00:48 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpvHa-0007Sm-HZ
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 18:00:48 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so904982f8f.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 15:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785535245; x=1786140045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EqUCep0HZSTo8W3y5ufyYcxJQO20NzUS0NZ7qB5Dt3s=;
 b=g3ta6camtSBV/Hjy6teFwssOYe8KvSXTgNE3g7AXVO1PQOgoxIWJ2KbClLWmWiMk0t
 Gsk3w3lyx3B4oBWiTaWeowVj0vQHRIv9xNHoDfjDDJNB4pbBT1T15RCR2s6EpNRoxMlm
 DVWcaAbVs4dFNQTfIC7cZuv/PHERbWs1Sg3+8AoKZEgD5dsZcDX+UcgEqIww/2Yr56Jz
 SQuCPWrVQIfonv/kYnTehQq6Ee3OEmR7Pj2kvx/rxRasS9VsMJ7z0mYIzhCBf901rEES
 hx5NclKNS9izP4XRqh+jE3xJ6c7n4go6H/fEnGF89aqN4occ4VmINAsTT3zdndfwrdov
 LZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785535245; x=1786140045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EqUCep0HZSTo8W3y5ufyYcxJQO20NzUS0NZ7qB5Dt3s=;
 b=rouLuyR6CC5hcGHeR995INtPbM4S50YF35lAkPUm2tzDBp9Yf8SYFMp/iDqZK0BuOT
 Y26NWlgV2RuvUJUj7nV07ucDDaE4+FuW5e0r06fxELclQoPV0gO1vbI3OB/F/YIg3qxA
 gghIWwOTfblr6R13JVb4YViOqsBNShtsms8zBv+78sAgKFD+g4EQLugucO6RKEPnbURr
 eCD5JE7aXePzKJaTVvWKcUy6ivQ0nlq5/DYZ+STCJia8/92Xt37alb4fCCvIDzpzApp+
 nLaKdD1IQL1f9R8oAoeHutz8p2+FNiq8wgxH5vC8ln1c/WDBl+Rz7c1IGXhkFMGQu+XN
 DRTw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrAKfRfstwjLpnywj7PtvPX7Bb5tuoA1+niZ305LxGzB44NCWeEmqiOEdx2cdvDQX+d2CLcSbOjmQyS@nongnu.org
X-Gm-Message-State: AOJu0YyESwys6DU4wGd7IaD/a07OJVCtVDM/2800yRfkWmvHAYQA+CzM
 rEUC63suLffhoYDBav2GG8Kp9WvjmQF0F4rvBSxTT1/JGCofcU6uaOTPhj1zakV5nec=
X-Gm-Gg: AR+sD13FehG8NJUPhLOMFSenlZhHTu7gkoyBoEQRjlnpId9uRQQyKdNcrFVSEkJ3gCS
 D07P02l6xBZq3EsLWe7bzA4bGQBwa5zUQgiRmSR/ajF6eZMnUDyYq8199vHRGrzaJ5ecAZtb9C9
 43Qpbz8BwtT7u1mUxVtGCfN5KJMUNz1MpRRm3haQyefhlF+Gkv0ZEfhwwKnZRMNw8X5QgO5pS4C
 DUq3dPVJ1YwZZ0+NiIaFYD6UFdPeUm3awvDN14ziob0cTLD48UddBVQ6+JbaPXBcNCffSZL/IaQ
 j4gqzC2LGG90bLlo7huFAyj8alk/Hs1sL18+hYLTDl6hRRfVu2+3TR1WMrrPQJIQhLO33tRatir
 pjRlBNKbunRB0SIxzwwWkAKH6SslxEACaWxb7pcxCko29zmP2fmkariAwn1ajmmBBPYgjE5Es+7
 m7vK5MP0M6jPxG2zqn22l2BV9zlluu+qP4fOwlu+VUByA8J/0MSaYXmwSa2+uYMhFVPuFF
X-Received: by 2002:a05:6000:b44:b0:47f:81c4:36a5 with SMTP id
 ffacd0b85a97d-47fd72a8cdfmr2140256f8f.15.1785535245168; 
 Fri, 31 Jul 2026 15:00:45 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:1758:fc6:a5f8:a15f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e2cf1sm9711152f8f.10.2026.07.31.15.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 15:00:44 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-stable@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 2/2] qcow2: repair a dirty image when it becomes writable
Date: Sat,  1 Aug 2026 00:00:39 +0200
Message-ID: <20260731220039.1765584-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731220039.1765584-1-den@openvz.org>
References: <20260731220039.1765584-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=den@openvz.org; helo=mail-wr1-x432.google.com
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

A dirty image must be repaired before anything allocates a cluster in
it. qcow2_do_open() does that, but only for a node that is writable
from the start. A node opened read-only skips it, and nothing revisits
the question once that node becomes writable, which block-commit does
routinely: commit_active_start() and commit_start() reopen the base
read-write for the duration of the job.

With lazy refcounts the on-disk refcount block then still accounts for
the metadata clusters only, so the allocator restarts at the front of
the image and hands out clusters that L2 entries point at. Two guest
offsets end up sharing one host cluster. Nothing fails, the corrupt bit
stays clear, and a clean close clears the dirty bit, so no later open
repairs the image either.

Do the repair in qcow2_reopen_commit_post(). bdrv_reopen_prepare() runs
before bdrv_list_refresh_perms(), so it holds no BLK_PERM_WRITE and,
with auto-read-only, bs->file may still have an O_RDONLY descriptor.
commit_post cannot reject the reopen, so signal corruption if the
repair fails rather than let writes alias live clusters. An inactive
node is skipped: bdrv_activate() calls qcow2_do_open() again through
qcow2_co_invalidate_cache().

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
---
 block/qcow2.c              | 14 ++++++++++++++
 tests/qemu-iotests/039     | 24 ++++++++++++++++++++++++
 tests/qemu-iotests/039.out | 17 +++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 1543255eba..e660655a0d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2147,8 +2147,22 @@ static void qcow2_reopen_commit(BDRVReopenState *state)
 
 static void qcow2_reopen_commit_post(BDRVReopenState *state)
 {
+    BDRVQcow2State *s = state->bs->opaque;
+
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
+    if (bdrv_is_writable(state->bs) &&
+        (s->incompatible_features & QCOW2_INCOMPAT_DIRTY)) {
+        BdrvCheckResult result = {0};
+        int ret;
+
+        ret = bdrv_check(state->bs, &result, BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
+        if (ret < 0 || result.check_errors) {
+            qcow2_signal_corruption(state->bs, true, -1, -1,
+                                    "Could not repair dirty image");
+        }
+    }
+
     if (state->flags & BDRV_O_RDWR) {
         Error *local_err = NULL;
 
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index a5be81bc4a..255dc2e7e5 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -137,6 +137,30 @@ $QEMU_IO -c "write 0 512" "$TEST_IMG" | _filter_qemu_io
 # The dirty bit must not be set
 _qcow2_dump_header | grep incompatible_features
 
+echo
+echo "== Reopening a dirty image read/write should repair it =="
+
+_make_test_img -o "compat=1.1,lazy_refcounts=on" $size
+
+_NO_VALGRIND \
+$QEMU_IO -c "write -P 0x5a 0 512" \
+         -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
+    | _filter_qemu_io
+
+# The dirty bit must be set
+_qcow2_dump_header | grep incompatible_features
+
+# The refcounts are only resolved when the node becomes writable. Without
+# that, this write is allocated on top of the cluster at offset 0 and reading
+# it back returns the data written here.
+$QEMU_IO -r -c "reopen -w" \
+            -c "write -P 0xb1 1M 512" \
+            -c "read -P 0x5a 0 512" "$TEST_IMG" | _filter_qemu_io
+
+# The dirty bit must not be set
+_qcow2_dump_header | grep incompatible_features
+_check_test_img
+
 echo
 echo "== Creating an image file with lazy_refcounts=off =="
 
diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
index 3c71e5a3dd..62073916a9 100644
--- a/tests/qemu-iotests/039.out
+++ b/tests/qemu-iotests/039.out
@@ -64,6 +64,23 @@ wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 incompatible_features     []
 
+== Reopening a dirty image read/write should repair it ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+wrote 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+./common.rc: Killed ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
+incompatible_features     [0]
+ERROR cluster 5 refcount=0 reference=1
+Rebuilding refcount structure
+Repairing cluster 1 refcount=1 reference=0
+Repairing cluster 2 refcount=1 reference=0
+wrote 512/512 bytes at offset 1048576
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+incompatible_features     []
+No errors were found on the image.
+
 == Creating an image file with lazy_refcounts=off ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 wrote 512/512 bytes at offset 0
-- 
2.53.0


