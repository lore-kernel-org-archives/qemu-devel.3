Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59B4C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 02:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf7BX-0004BY-2j; Wed, 01 Jul 2026 22:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wf7BW-0004BM-2C
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 22:29:50 -0400
Received: from ms-2002h-snip4-5.eps.apple.com ([57.103.74.38]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wf7BR-0002SD-Fi
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 22:29:49 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPS id
 61D7F18000B0; Thu, 02 Jul 2026 02:29:38 +0000 (UTC)
X-ICL-RepId: 019f20a9-0f76-7975-9158-97c72dae7979
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ5JHVoHRQNGD1YCWgZLVxQEFVsHVghdEkoXXS1aDhwTVhUTC1NWXxUXG1wAFxlRTQhIEwVSB11NVg1HD1geXBQXFUBDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FXggZCF0dGRVaCQpXAEALTgNaB1kCQgtBAVoZXwRFCEgeXhoGWhpYG1wPRARcMFQdHQ5YBgxQTQFDCAoCURxWDVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1782959381; x=1785551381; bh=COq6H4N+kGc/Y6SrSsYP8fpipvMlqT9yC11jsb2+MGU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=RNWblcRy83jrhwB2UCXoY/Gbd82sH22n4Z5rad/eWi62/isPkZT4NSYn7UTTN8m5qlNj/fyXtJoZq3u8qQreJlQ7YZI88jXFJB9k3RTiHwAVJhBS3k6O8E1CJ0zr1DfwUK05fd2Tpo4J7UHvrGLs1H3WGBByMt1EltePRS+7CRYZqlVXyBi1P6pNg2mUPDWl4fEIdGI+I+El3lhmcmNcG2jkwrh84dClOzX1BoMXHboel4NplHySLYsBEYt0dyRuByxibT7pq+SQtkI0inyJ9AVUtEcbEP6xdP/QZGCI5Z0YjwuOHGggL0Anl87VMiPkOOTrxDvA7IED8GwfiNI+LA==
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-7 (Postfix) with ESMTPSA id
 8B22B180013D; Thu, 02 Jul 2026 02:29:36 +0000 (UTC)
From: Matt Jacobson <mhjacobson@me.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Matt Jacobson <mhjacobson@me.com>
Subject: [PATCH v3 2/5] fifo32: add fifo32_peek()
Date: Wed,  1 Jul 2026 22:29:24 -0400
Message-ID: <20260702022927.46510-3-mhjacobson@me.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702022927.46510-1-mhjacobson@me.com>
References: <20260702022927.46510-1-mhjacobson@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: VFi0Q6RAHQLuOp_DtyXVQ9jVSACJa84m
X-Proofpoint-GUID: VFi0Q6RAHQLuOp_DtyXVQ9jVSACJa84m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAyMyBTYWx0ZWRfX7NlqBUsFwBu2
 lDcJq1jNBuDmEPy2d/hYxBL2XHW+M8AXHM5Dzfw34zs/C3T86/M2Lg6xQebnK3jq/utsWnEMobj
 f65MquM2pnWpBUcu8F+INDw5pc2kOGsdDAxR9Qsuqv5JycUTq1bOObo6i5u9+grlfHDqtbMnM9R
 GmCc2M+4Ka2SDKpAZoVGkMIKCkZLxpRm5dQZSUA1OVbrBNzhHwfMS3Ly2KJL0BPmE/RpLBNnVgj
 eSrBRM0KS3rxQIsTs7N7BypO/3Dv9AkHBSXzLXpMkuaOlvBWXXMZ2tMQyaXffdv6LJPEwCihuYJ
 IFoih5ww2ZWSDKNX6nj
Received-SPF: pass client-ip=57.103.74.38; envelope-from=mhjacobson@me.com;
 helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Add fifo32_peek(), which, like the other Fifo32 functions, ultimately
just delegates to the Fifo8 code.

Adjust fifo32_pop() to use ldl_le_p() too.

Signed-off-by: Matt Jacobson <mhjacobson@me.com>
---
 include/qemu/fifo32.h | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/qemu/fifo32.h b/include/qemu/fifo32.h
index 4e9fd1b5ef..4e8b739a1e 100644
--- a/include/qemu/fifo32.h
+++ b/include/qemu/fifo32.h
@@ -15,6 +15,7 @@
 #ifndef FIFO32_H
 #define FIFO32_H
 
+#include "qemu/bswap.h"
 #include "qemu/fifo8.h"
 
 typedef struct {
@@ -117,6 +118,25 @@ static inline void fifo32_push_all(Fifo32 *fifo, const uint32_t *data,
     }
 }
 
+/**
+ * fifo32_peek:
+ * @fifo: fifo to peek from
+ *
+ * Peek the data word at the current head of the FIFO. Clients are responsible
+ * for checking for emptiness using fifo32_is_empty().
+ *
+ * Returns: The peeked 32 bits data word.
+ */
+
+static inline uint32_t fifo32_peek(Fifo32 *fifo)
+{
+    uint8_t bytes[sizeof(uint32_t)];
+    uint32_t read = fifo8_peek_buf(&fifo->fifo, bytes, sizeof(bytes));
+    assert(read == sizeof(bytes));
+
+    return ldl_le_p(bytes);
+}
+
 /**
  * fifo32_pop:
  * @fifo: fifo to pop from
@@ -130,14 +150,11 @@ static inline void fifo32_push_all(Fifo32 *fifo, const uint32_t *data,
 
 static inline uint32_t fifo32_pop(Fifo32 *fifo)
 {
-    uint32_t ret = 0;
-    int i;
-
-    for (i = 0; i < sizeof(uint32_t); i++) {
-        ret |= (fifo8_pop(&fifo->fifo) << (i * 8));
-    }
+    uint8_t bytes[sizeof(uint32_t)];
+    uint32_t popped = fifo8_pop_buf(&fifo->fifo, bytes, sizeof(bytes));
+    assert(popped == sizeof(bytes));
 
-    return ret;
+    return ldl_le_p(bytes);
 }
 
 /**
-- 
2.54.0


