Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E437BCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEP4S-0001BX-HI; Wed, 07 Oct 2026 06:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <74993d75ee26e699b4543a2fb6f3b7c3b7f49442@kylie.crudebyte.com>)
 id 1xEP45-0000MS-7c
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:40:04 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <74993d75ee26e699b4543a2fb6f3b7c3b7f49442@kylie.crudebyte.com>)
 id 1xEP43-00083x-MP
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=u4Vsb0D3n7KiJRd1nb+DIjsLZ8klFlk3wTwHWapGcvA=; b=HI3OO
 FZjyZr5/B7LBq7osJV//X+tR93Uo9uSA5lW6k/sLRGU1TbtTAfE3sAumzEx0ZbL8a3cIM43RrET5r
 wyTAkJr5QoWNOnQ4AbXYKgzpU3/7wI/lHKyPWvuo6mB7UiYCpEeOwj+vK+M4IQHyyxbnxr+v4U5YN
 AIYJsB0djhDV9c7YltyNg/A91r27+faRv1dK3fOIh/vq/wQ9NJq/5RVtbwNix6et/cKCMKZp6jup9
 zwdZ+vipgeyT5fuAIbyar8wor9c7sHit792/O1WxpjSVLroM/QgKltcJ40T6z862b+Dxq06wpoW0f
 9c91QtHzUadX/ZQB8E267JHaHBC1vMoJ/vGX8VYYyrq7ix4/j5YK+immsFXg9CtFDGy1FBRaWvq2I
 cdVpuBsAjPdpad8mue6dwg7yDLcI0rtxAgJlP4tObVey/XPYdbqGuIqeTrnVgIk5DcRsLgKcWgulQ
 ++JopWbwaxXrZrJd3G5LIk4m5K5aq35LvZdEftxnu+qb7hBPMlUYecSlVCjCPrfm+p0yTfZV3xnNd
 UjhbKz2KYkU4OUqfMcKhpGEafYstm4N+e5Kd/g1E+9k9lcjD3rMQ3K9M81u6CKBRhCBsBTs8FMFl3
 Pk8jdlvw1Ke1aQ0iGuCVY2TG1JgQQjudL+yt3ducviTuYv1+w6OWdSjUX23YSI=;
Message-ID: <74993d75ee26e699b4543a2fb6f3b7c3b7f49442.1791368962.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1791368962.git.qemu_oss@crudebyte.com>
References: <cover.1791368962.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 7 Oct 2026 12:27:44 +0200
Subject: [PATCH v2 5/9] tests/9p-race: add Treaddir race test
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=74993d75ee26e699b4543a2fb6f3b7c3b7f49442@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Add "race/readdir" test, a test racing Treaddir's directory stream.

In each round a Treaddir request is sent against another Treaddir
request or Tstat request on the same FID.

This test is registered as slow test (i.e. skipped by default) and
therefore requires -m slow to run.

On my test machine a full run of 20000 rounds took around 1 minute
to complete.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-race-test.c | 84 +++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/tests/qtest/virtio-9p-race-test.c b/tests/qtest/virtio-9p-race-test.c
index 789fb7721d..d2b76bf075 100644
--- a/tests/qtest/virtio-9p-race-test.c
+++ b/tests/qtest/virtio-9p-race-test.c
@@ -546,6 +546,89 @@ static void v9p_race_fid_path(void *obj, void *data, QGuestAllocator *t_alloc)
     fflush(stdout);
 }
 
+/*
+ * Race 9p server's internal directory stream for Treaddir.
+ *
+ * Race Treaddir request against another Treaddir or Tstat request on the same
+ * FID.
+ */
+static void v9p_race_readdir(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    QVirtio9P *v9p = obj;
+    uint32_t rounds;
+    uint32_t i;
+
+    if (v9p_race_skip()) {
+        return;
+    }
+    rounds = v9p_race_rounds();
+
+    v9fs_set_allocator(t_alloc);
+    v9p_race_prepare(v9p);
+
+    for (i = 0; i < rounds; i++) {
+        P9Req *req_a, *req_b;
+        uint16_t tag_a = v9p_race_new_tag();
+        uint16_t tag_b = v9p_race_new_tag();
+
+        if (i % 2000 == 0) {
+            g_print("race/readdir: %u/%u rounds\n", i, rounds);
+            fflush(stdout);
+        }
+
+        /*
+         * Reset the descriptor pool at the start of every round, where
+         * no request is in-flight anymore.
+         */
+        v9p_race_reset_pool(v9p);
+
+        /* initial Treaddir request */
+        req_a = v9fs_treaddir((TReadDirOpt) {
+            .client = v9p,
+            .fid = V9P_RACE_D2_FID,
+            .offset = 0,
+            .count = 64,
+            .tag = tag_a,
+            .requestOnly = true,
+        }).req;
+
+        /*
+         * On every 3rd round send a concurrent Tstat, otherwise a
+         * concurrent Treaddir request.
+         */
+        if (i % 3 == 0) {
+            /* a Tstat on the same directory FID */
+            req_b = v9fs_tstat((TStatOpt) {
+                .client = v9p,
+                .fid = V9P_RACE_D2_FID,
+                .tag = tag_b,
+                .requestOnly = true,
+            }).req;
+        } else {
+            /* a concurrent Treaddir on the same FID */
+            req_b = v9fs_treaddir((TReadDirOpt) {
+                .client = v9p,
+                .fid = V9P_RACE_D2_FID,
+                .offset = 0,
+                .count = 64,
+                .tag = tag_b,
+                .requestOnly = true,
+            }).req;
+        }
+
+        uint8_t resp_a, resp_b;
+
+        resp_a = v9p_race_resp_collect(v9p, req_a);
+        g_assert_cmpint(resp_a, ==, P9_RREADDIR);
+        resp_b = v9p_race_resp_collect(v9p, req_b);
+        g_assert_cmpint(resp_b, ==,
+                        (i % 3 == 0) ? P9_RSTAT : P9_RREADDIR);
+    }
+
+    g_print("race/readdir: %u rounds done\n", rounds);
+    fflush(stdout);
+}
+
 /* setup and cleanup for race tests using the 9p 'local' fs driver */
 static void *v9p_race_local_driver(GString *cmd_line, void *arg)
 {
@@ -570,6 +653,7 @@ static void v9p_race_register_tests(void)
     };
 
     qos_add_test("race/fid-path", "virtio-9p", v9p_race_fid_path, &opts);
+    qos_add_test("race/readdir", "virtio-9p", v9p_race_readdir, &opts);
 }
 
 libqos_init(v9p_race_register_tests);
-- 
2.47.3


