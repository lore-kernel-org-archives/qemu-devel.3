Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4479DC2BA18
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 07:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKCgN-0003Ls-3Z; Thu, 20 Jun 2024 03:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1sKCgK-0003II-R3
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 03:58:09 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1sKCgH-00004s-UC
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 03:58:08 -0400
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1718870279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KaU9cgmLIerNEpu6u9oGU8K3uAdhAJgSaULPLqMWsaQ=;
 b=k3wWWZsYI1qpXno8XASbJ7Np0aPpEI2x9X0apHKOtkwLWgp9gV0EJ+YWmlzO/2lhhMbigx
 +v8V664PnnZoWKh60DmG+6+xCfixCq36FmeEdJBBWrtVsmVdjdfsCWXSas5DcwF2v3zWeb
 c8WCLhy5Tv8wOTL8mZs0hou1cmjqw+8=
To: alxndr@bu.edu
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org,
 Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH v2] tests/qtest/fuzz/virtio_net_fuzz.c: fix
 virtio_net_fuzz_multi
Date: Thu, 20 Jun 2024 10:54:35 +0300
Message-ID: <20240620075454.194425-3-frolov@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The main loop is executed during flush_events(), where virtio error may occur.
This behavior is legit and should not produce any crash report.
But the test is waiting on used descriptors w/o a check, and, in case of error
fails with message: "assertion timer != NULL failed".
Thus, any invalid input data produces a meaningless crash report.
Debuging the problem, I found that in case of virtio error in the main loop,
dev->bus->get_status(dev) is 0 in most cases.
In rare cases VIRTIO_CONFIG_S_NEEDS_RESET bit is set.
So, checking only for VIRTIO_CONFIG_S_NEEDS_RESET bit is not enough.

Also, the second qvirtqueue_add() call with corresponding comment are redundant.

v1: https://patchew.org/QEMU/20240523102813.396750-2-frolov@swemel.ru/
v2: modified error-check & clean-up

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
 tests/qtest/fuzz/virtio_net_fuzz.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c b/tests/qtest/fuzz/virtio_net_fuzz.c
index e239875e3b..f62d2b9478 100644
--- a/tests/qtest/fuzz/virtio_net_fuzz.c
+++ b/tests/qtest/fuzz/virtio_net_fuzz.c
@@ -65,22 +65,21 @@ static void virtio_net_fuzz_multi(QTestState *s,
         } else {
             vqa.rx = 0;
             uint64_t req_addr = guest_alloc(t_alloc, vqa.length);
-            /*
-             * If checking used ring, ensure that the fuzzer doesn't trigger
-             * trivial asserion failure on zero-zied buffer
-             */
             qtest_memwrite(s, req_addr, Data, vqa.length);
 
-
             free_head = qvirtqueue_add(s, q, req_addr, vqa.length,
                     vqa.write, vqa.next);
-            qvirtqueue_add(s, q, req_addr, vqa.length, vqa.write , vqa.next);
             qvirtqueue_kick(s, dev, q, free_head);
         }
 
         /* Run the main loop */
         qtest_clock_step(s, 100);
         flush_events(s);
+        /* Input led to a virtio_error */
+        if (dev->bus->get_status(dev) & VIRTIO_CONFIG_S_NEEDS_RESET ||
+          !(dev->bus->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK)) {
+            return;
+        }
 
         /* Wait on used descriptors */
         if (check_used && !vqa.rx) {
@@ -92,10 +91,6 @@ static void virtio_net_fuzz_multi(QTestState *s,
              */
             while (!vqa.rx && q != net_if->queues[QVIRTIO_RX_VQ]) {
                 uint32_t got_desc_idx;
-                /* Input led to a virtio_error */
-                if (dev->bus->get_status(dev) & VIRTIO_CONFIG_S_NEEDS_RESET) {
-                    break;
-                }
                 if (dev->bus->get_queue_isr_status(dev, q) &&
                         qvirtqueue_get_buf(s, q, &got_desc_idx, NULL)) {
                     g_assert_cmpint(got_desc_idx, ==, free_head);
@@ -107,6 +102,11 @@ static void virtio_net_fuzz_multi(QTestState *s,
                 /* Run the main loop */
                 qtest_clock_step(s, 100);
                 flush_events(s);
+                /* Input led to a virtio_error */
+                if (dev->bus->get_status(dev) & VIRTIO_CONFIG_S_NEEDS_RESET ||
+                  !(dev->bus->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK)) {
+                    return;
+                }
             }
         }
         Data += vqa.length;
-- 
2.43.0


