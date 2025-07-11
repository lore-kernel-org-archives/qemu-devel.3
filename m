Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9BFC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 20:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaKe5-0003It-3p; Fri, 11 Jul 2025 16:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uaKdj-0003He-N1; Fri, 11 Jul 2025 16:46:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uaKdh-0003g6-BS; Fri, 11 Jul 2025 16:46:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2E4E8135CFF;
 Fri, 11 Jul 2025 23:46:04 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0E01823FF3A;
 Fri, 11 Jul 2025 23:46:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.19 01/15] hw/misc/aspeed_hace: Ensure HASH_IRQ is always
 set to prevent firmware hang
Date: Fri, 11 Jul 2025 23:46:16 +0300
Message-ID: <20250711204632.1804872-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-7.2.19-20250711111933@cover.tls.msk.ru>
References: <qemu-stable-7.2.19-20250711111933@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Currently, if the program encounters an unsupported algorithm, it does not set
the HASH_IRQ bit in the status register and send an interrupt to indicate
command completion. As a result, the FW gets stuck waiting for a completion
signal from the HACE module.

Additionally, in do_hash_operation, if an error occurs within the conditional
statement, the HASH_IRQ bit is not set in the status register. This causes the
firmware to continuously send HASH commands, as it is unaware that the HACE
model has completed processing the command.

To fix this, the HASH_IRQ bit in the status register must always be set to
ensure that the firmware receives an interrupt from the HACE module, preventing
it from getting stuck or repeatedly sending HASH commands.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Fixes: c5475b3 ("hw: Model ASPEED's Hash and Crypto Engine")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250515081008.583578-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit fb8e59abbe46957cd599bb9aa9221fad1e4e989e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index 11bd25708e..20f645f49b 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -278,12 +278,6 @@ static void do_hash_operation(AspeedHACEState *s, int algo, bool sg_mode,
                             iov[i - 1].iov_len, false,
                             iov[i - 1].iov_len);
     }
-
-    /*
-     * Set status bits to indicate completion. Testing shows hardware sets
-     * these irrespective of HASH_IRQ_EN.
-     */
-    s->regs[R_STATUS] |= HASH_IRQ;
 }
 
 static uint64_t aspeed_hace_read(void *opaque, hwaddr addr, unsigned int size)
@@ -358,10 +352,16 @@ static void aspeed_hace_write(void *opaque, hwaddr addr, uint64_t data,
                 qemu_log_mask(LOG_GUEST_ERROR,
                         "%s: Invalid hash algorithm selection 0x%"PRIx64"\n",
                         __func__, data & ahc->hash_mask);
-                break;
+        } else {
+            do_hash_operation(s, algo, data & HASH_SG_EN,
+                    ((data & HASH_HMAC_MASK) == HASH_DIGEST_ACCUM));
         }
-        do_hash_operation(s, algo, data & HASH_SG_EN,
-                ((data & HASH_HMAC_MASK) == HASH_DIGEST_ACCUM));
+
+        /*
+         * Set status bits to indicate completion. Testing shows hardware sets
+         * these irrespective of HASH_IRQ_EN.
+         */
+        s->regs[R_STATUS] |= HASH_IRQ;
 
         if (data & HASH_IRQ_EN) {
             qemu_irq_raise(s->irq);
-- 
2.47.2


