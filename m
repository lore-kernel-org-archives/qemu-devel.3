Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB61DC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 10:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA5i0-0006Kg-2o; Thu, 23 May 2024 06:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1sA5hz-0006KN-0h; Thu, 23 May 2024 06:30:03 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1sA5hw-0001EJ-40; Thu, 23 May 2024 06:30:02 -0400
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1716460193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2WqSKzC05EnuZ9NdOIHIky6gmKHK5eVCSZg+kTaLSO0=;
 b=ffB5S9BfPsVmAWB0yMX4TZ8R3FXBWKk8st20uQTE1DdkrDDdkbl7m8erd5kjqyW3dgDmuf
 3T7SmvtENkCPJdgSbMRB9U1DP6303KAkMnIc6j8LiklQsQ1Buk2GkQP5IxBrN7fkJPIOaj
 vbu4IX4EF3ucFNsVPRedKer7P2Pqq4g=
To: alxndr@bu.edu
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, sdl.qemu@linuxtesting.org,
 Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH] tests/qtest/fuzz/virtio_net_fuzz.c: fix virtio_net_fuzz_multi
Date: Thu, 23 May 2024 13:28:14 +0300
Message-ID: <20240523102813.396750-2-frolov@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If QTestState was already CLOSED due to error, calling qtest_clock_step()
afterwards makes no sense and only raises false-crash with message:
"assertion timer != NULL failed".

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
 tests/qtest/fuzz/virtio_net_fuzz.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qtest/fuzz/virtio_net_fuzz.c b/tests/qtest/fuzz/virtio_net_fuzz.c
index e239875e3b..2f57a8ddd8 100644
--- a/tests/qtest/fuzz/virtio_net_fuzz.c
+++ b/tests/qtest/fuzz/virtio_net_fuzz.c
@@ -81,6 +81,9 @@ static void virtio_net_fuzz_multi(QTestState *s,
         /* Run the main loop */
         qtest_clock_step(s, 100);
         flush_events(s);
+        if (!qtest_probe_child(s)) {
+            return;
+        }
 
         /* Wait on used descriptors */
         if (check_used && !vqa.rx) {
-- 
2.43.0


