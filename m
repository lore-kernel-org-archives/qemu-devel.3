Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50079CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHmP-0003pX-GT; Wed, 27 Aug 2025 11:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHkH-0007qN-9x; Wed, 27 Aug 2025 11:07:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHkF-0005YI-59; Wed, 27 Aug 2025 11:07:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 795E014C554;
 Wed, 27 Aug 2025 18:02:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 611A126985C;
 Wed, 27 Aug 2025 18:03:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Kowal <kowal@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 44/59] ppc/xive2: Reset Generation Flipped bit on END
 Cache Watch
Date: Wed, 27 Aug 2025 18:02:49 +0300
Message-ID: <20250827150323.2694101-44-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
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

From: Michael Kowal <kowal@linux.ibm.com>

When the END Event Queue wraps the END EQ Generation bit is flipped and the
Generation Flipped bit is set to one.  On a END cache Watch read operation,
the Generation Flipped bit needs to be reset.

While debugging an error modified END not valid error messages to include
the method since all were the same.

Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-8-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 576830428eea6ebfc85792851a343214b834e401)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 92e62b3e5f..7535fb67b9 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1325,10 +1325,11 @@ static uint64_t pnv_xive2_ic_vc_read(void *opaque, hwaddr offset,
     case VC_ENDC_WATCH3_DATA0:
         /*
          * Load DATA registers from cache with data requested by the
-         * SPEC register
+         * SPEC register.  Clear gen_flipped bit in word 1.
          */
         watch_engine = (offset - VC_ENDC_WATCH0_DATA0) >> 6;
         pnv_xive2_end_cache_load(xive, watch_engine);
+        xive->vc_regs[reg] &= ~(uint64_t)END2_W1_GEN_FLIPPED;
         val = xive->vc_regs[reg];
         break;
 
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 4dd04a0398..453fe37f18 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -374,8 +374,8 @@ static void xive2_end_enqueue(Xive2End *end, uint32_t data)
         qgen ^= 1;
         end->w1 = xive_set_field32(END2_W1_GENERATION, end->w1, qgen);
 
-        /* TODO(PowerNV): reset GF bit on a cache watch operation */
-        end->w1 = xive_set_field32(END2_W1_GEN_FLIPPED, end->w1, qgen);
+        /* Set gen flipped to 1, it gets reset on a cache watch operation */
+        end->w1 = xive_set_field32(END2_W1_GEN_FLIPPED, end->w1, 1);
     }
     end->w1 = xive_set_field32(END2_W1_PAGE_OFF, end->w1, qindex);
 }
-- 
2.47.2


