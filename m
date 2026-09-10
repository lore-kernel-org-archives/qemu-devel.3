Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E855C88E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4paT-00053B-4m; Thu, 10 Sep 2026 20:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPv-0001jT-Ej
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:43:08 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPl-0007DL-1V
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:42:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49cd77e0f95so2888955e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789083759; x=1789688559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gOCgb/8qYTx3Tvjv6qT01WmwOcfq9B2Xk9PXWdyz6VY=;
 b=VXz5gZXqjEpUPGNfI6zA2zw29nzzWaHhJSlnSagtklA17j7qYLo1mWrh3WurhkTt0a
 Slzu5C7CZt0bNXHQSGWmPEO/beOb2pu1a4CnIhVjMl3oHBl9iLdXw2HDI7qeZwlkhQK7
 jph/invF8HDIARIuu3ek+r1XCbX642MKiO32gl5aDXMpQJdb16Yn4aPdqCPptVS/gykz
 +9xGVOgrxtGYQ/FWGrzuvSH1rE8g86dgJPGLuYSORLWL2ktXu8zEumqwNFH/1Irt/qmd
 gN67XcA32N6XagQHLvLsd/+5v2P2yhmpnmLM20EthWb9o3/aBbF9GRX8YZ66GhEqCChV
 kY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789083759; x=1789688559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gOCgb/8qYTx3Tvjv6qT01WmwOcfq9B2Xk9PXWdyz6VY=;
 b=hbg8ac1pm7Gjhc3fKYkv9J48fUuJ7EJ/5GgWWPf+vmQ0onfc4e35D2DAeZbIsY9vwJ
 hPZiHrLTgbZZa33fcu3ZfLt0ZkEYlbRIOJZzCZ/4DfVlf5GzbvJunmj4F8YEGa3vPtjc
 KyMWiFsMK9O84FqFZrah+2Jfo+95w55F2lhr5SH854XbO+fKR7Y0sYcJoAg2UNprIjBU
 aMpx3amOQ+NJqZrc32u5VtPtBInKRRvVEUXDBgpqyh4qx46zwNQDiAlpqy2HrW2AGepc
 QPuDf1eQBCKJULflUb87T+6tVX3O4+YiOcG6Mhu3bD0BDeNhLRREv3L+CUyMutsiME+v
 QodQ==
X-Gm-Message-State: AFuF++nCwFQLFrTebp0M2Gb3VXFEGTn9m+WajjXjpv+sJlSoEobB6i7j
 v4nXT0uxSUTHnsnezJT53P2lEUrv9WuV4DzATodgWoWshh2dM3BYio8owSt9auOnfRDs8IoHx5O
 Yzls1
X-Gm-Gg: AYBFou1zofUL9VbUZ8v8AHaqgBH9j76riBvlEqXo4c0OrtqK8VwsWa/ooEigx5DNko5
 PjEIxdjQy0/rKgH8IPcjwMAqMVdSX43nvNLcqZ6q2LqLOSF1VMyt5FJSzUG85JRZg5BOdjvd+4Q
 3aYWtIxbjEYz9nvK3KEuASXJw8CqqLaCEMCIWWK0I8xrfcoesMUqDhuKApDAXpVpJOuVU1DHJRw
 Zb4OuhKJwi6mNo/ZbcSUKXl94N3M718ehyNSlpxfn0ZtAsLJdmrUjDkghWIOmgNenz3pCRUuOu7
 DMZgbLB0G/Gre+FTuYNYELDne9nMXZzf4kPuwKuLhRHbIUQ/2etxdGvKsvENv0VA5IA/Ou7Bb+3
 kz2LeCC6Q1g5r30DigshEq2Gs8CR9yJd/AA3UC+9Vq9njVcbUTm/j7XVpMzMBeFvqSSv5KsZf60
 GBAmbWX+3geEhM4BuxheEOhvZFfJh38toEQfTHQE4egdDC06a3jLSX+9moffkxhoETCZKWuA==
X-Received: by 2002:a05:600c:46cc:b0:49c:fc6e:a3d9 with SMTP id
 5b1f17b1804b1-49e619cc71bmr14037445e9.24.1789083758810; 
 Thu, 10 Sep 2026 16:42:38 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:54f3:cc87:964b:3604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm7726775e9.4.2026.09.10.16.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 16:42:38 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PULL 11/29] parallels: Make mark_used() a global function
Date: Fri, 11 Sep 2026 01:42:04 +0200
Message-ID: <20260910234222.3039975-12-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910234222.3039975-1-den@openvz.org>
References: <20260910234222.3039975-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=den@openvz.org; helo=mail-wm1-x32d.google.com
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

From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

We will need this function and a function for marking unused clusters (will
be added in the next patch) in parallels-ext.c too. Let it be a global
function parallels_mark_used().

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 14 ++++++++------
 block/parallels.h |  3 +++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index f02ad7a0be..6f7a9911d7 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -187,8 +187,8 @@ static void parallels_set_bat_entry(BDRVParallelsState *s,
     bitmap_set(s->bat_dirty_bmap, bat_entry_off(index) / s->bat_dirty_block, 1);
 }
 
-static int mark_used(BlockDriverState *bs, unsigned long *bitmap,
-                     uint32_t bitmap_size, int64_t off, uint32_t count)
+int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
+                        uint32_t bitmap_size, int64_t off, uint32_t count)
 {
     BDRVParallelsState *s = bs->opaque;
     uint32_t cluster_index = host_cluster_index(s, off);
@@ -241,7 +241,8 @@ static int GRAPH_RDLOCK parallels_fill_used_bitmap(BlockDriverState *bs)
             continue;
         }
 
-        err2 = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off, 1);
+        err2 = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
+                                   host_off, 1);
         if (err2 < 0 && err == 0) {
             err = err2;
         }
@@ -375,7 +376,8 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
         }
     }
 
-    ret = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off, to_allocate);
+    ret = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
+                              host_off, to_allocate);
     if (ret < 0) {
         /* Image consistency is broken. Alarm! */
         return ret;
@@ -840,7 +842,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
             continue;
         }
 
-        ret = mark_used(bs, bitmap, bitmap_size, host_off, 1);
+        ret = parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1);
         assert(ret != -E2BIG);
         if (ret == 0) {
             continue;
@@ -900,7 +902,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
          * considered, and the bitmap size doesn't change. This specifically
          * means that -E2BIG is OK.
          */
-        ret = mark_used(bs, bitmap, bitmap_size, host_off, 1);
+        ret = parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1);
         if (ret == -EBUSY) {
             res->check_errors++;
             goto out_repair_bat;
diff --git a/block/parallels.h b/block/parallels.h
index 423b2ad727..68077416b1 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -90,6 +90,9 @@ typedef struct BDRVParallelsState {
     Error *migration_blocker;
 } BDRVParallelsState;
 
+int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
+                        uint32_t bitmap_size, int64_t off, uint32_t count);
+
 int GRAPH_RDLOCK
 parallels_read_format_extension(BlockDriverState *bs, int64_t ext_off,
                                 Error **errp);
-- 
2.53.0


