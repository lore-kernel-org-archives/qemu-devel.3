Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264C0C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 07:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1hgo-00012K-0X; Tue, 30 Apr 2024 03:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgj-0000tl-ER
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:14:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgh-0008Pm-Sy
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714461243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XvQAqWLE4bZMMlG6excdTC5v9yBUmN935gA/qF9agFo=;
 b=gMyiPhjy0Bt1UsI/YfVxF7A3skaiDYsef3fPd8A+LDR7sstCdtrmEYv+ZKaHei2/Jq+pZj
 rttENuP8fYR+60IMdxKUWXELzh5APmsbgmboBuXmUN30OUMAd3yLfpEk8lbf115Q0iyU2a
 P8KWlQL44nWccgsHyGcGBsbHPaVQjL8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-V9koSCvAOEqxlbQsbfdyfQ-1; Tue,
 30 Apr 2024 03:13:59 -0400
X-MC-Unique: V9koSCvAOEqxlbQsbfdyfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF65B3C0F18B;
 Tue, 30 Apr 2024 07:13:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67EC940C141D;
 Tue, 30 Apr 2024 07:13:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Chris Friedt <chrisfriedt@gmail.com>,
	Chris Friedt <cfriedt@meta.com>
Subject: [PULL 09/19] hw: misc: edu: use qemu_log_mask instead of hw_error
Date: Tue, 30 Apr 2024 09:13:30 +0200
Message-ID: <20240430071340.413305-10-thuth@redhat.com>
In-Reply-To: <20240430071340.413305-1-thuth@redhat.com>
References: <20240430071340.413305-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Chris Friedt <chrisfriedt@gmail.com>

Log a guest error instead of a hardware error when
the guest tries to DMA to / from an invalid address.

Signed-off-by: Chris Friedt <cfriedt@meta.com>
Message-ID: <20221018122551.94567-3-cfriedt@meta.com>
[thuth: Add missing #include statement, fix error reported by checkpatch.pl]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/misc/edu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index e1cb443438..fa052c44db 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "qemu/units.h"
 #include "hw/pci/pci.h"
 #include "hw/hw.h"
@@ -118,9 +119,10 @@ static void edu_check_range(uint64_t xfer_start, uint64_t xfer_size,
         return;
     }
 
-    hw_error("EDU: DMA range 0x%016"PRIx64"-0x%016"PRIx64
-             " out of bounds (0x%016"PRIx64"-0x%016"PRIx64")!",
-            xfer_start, xfer_end - 1, dma_start, dma_end - 1);
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "EDU: DMA range 0x%016"PRIx64"-0x%016"PRIx64
+                  " out of bounds (0x%016"PRIx64"-0x%016"PRIx64")!",
+                  xfer_start, xfer_end - 1, dma_start, dma_end - 1);
 }
 
 static dma_addr_t edu_clamp_addr(const EduState *edu, dma_addr_t addr)
@@ -128,7 +130,9 @@ static dma_addr_t edu_clamp_addr(const EduState *edu, dma_addr_t addr)
     dma_addr_t res = addr & edu->dma_mask;
 
     if (addr != res) {
-        printf("EDU: clamping DMA %#.16"PRIx64" to %#.16"PRIx64"!\n", addr, res);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "EDU: clamping DMA 0x%016"PRIx64" to 0x%016"PRIx64"!",
+                      addr, res);
     }
 
     return res;
-- 
2.44.0


