Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1C8C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm6C3-0005Tr-PR; Tue, 21 Jul 2026 04:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bz-0005SL-3q
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:11 -0400
Received: from mail-wr2-x00.google.com ([2a00:1450:4864:30::])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bw-0005iS-91
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:09 -0400
Received: by mail-wr2-x00.google.com with SMTP id
 ffacd0b85a97d-4700bd8aed1so879752f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784623867; x=1785228667; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wPrsV4wAJyGV760kc6/AjOJs1U2QCwOhs/FYcCXkgfM=;
 b=VKSPFOPdAChja9nCU9BssIPW2LTd3H0K8ZJOAPhqSeo1Z2n0VBJ4L+XAZrjswga5Dq
 Ljr73+Jq5woOozotpx6WAUcqM1pzMo2UBqnyCvS5kDHwRxXmls8ZYRpnOQfRGVQH8Xhu
 LJ3viLzsikfa71bbniHPJ2SbUlFt9/EDo/LxPxLu9q7p5Skl6Xvpwie6qZ5lrdKIH90o
 2Lgaq7AoAjYQKnyNpIQqgm4JYD48b3XNzhAzgtcAnS3teThCpUw1T8LBYTImpTbREhCM
 te014lIdUepLHSQo2Wcjr6RA0yZnDrOyiVAWZuZCEqeiuYg3QFg7wB3eRE0NjctSfZFc
 xGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784623867; x=1785228667;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wPrsV4wAJyGV760kc6/AjOJs1U2QCwOhs/FYcCXkgfM=;
 b=G0boLkc4kYE6YqLtz7reZb7cpe+pQfCHElabIFxr2ZA5pZdKx+ustty9QsICGLjo7Q
 5vkNrDTEsZ+Et/0UAI5Q02Ke58Kzh/SQ7Bn7puPzROjn7rJyBLyuDw9pHM8QPYNkEPuO
 wyuaRJcY18FBt50DYA8lbhrYMGb8/jG7lJVjygYxw3qy9hR37hfVOBAfP632uyHS2oTD
 w+1+W2WDj4eKIOimUyNlEKRXibqkUFf9n6kXdhjN8/z6waLEUabB0odhrkthTzdvTbFr
 Yly6hmxVggt3YJk/urij/km4YURzhdxscza0czxo7SWQvRB+j73OwES/WWXYNRU8y9o/
 nK6Q==
X-Gm-Message-State: AOJu0YwhNoHgJ8WPCCa2ViQyf1Hy4UK64XGqcETOnR86in7tksveWTbB
 ulHTgFAT6waqh2EaHkvKopyXrhM/T6Tqw1D0YBYjHql0z7lrWlPPZHlTUlpRR6fEoVq/qDtCeRY
 Z1jvfbZutZb26
X-Gm-Gg: AfdE7claSut61zzN3mogzAIBFU8Ner1GvgzHY4rK9vVMbOxZMolm1UPvUy7ZEJNfJxK
 XcOWjWZhUMNT82H0AWyEcITyXrgXJn7mXell9kM9pikmQtco25s9JUYteHkNJwNenlZEuMirPTb
 cwyd8gRQEvo0OxBqwHG2l19gbZxAwza6a2Uif38ezVWsSxA4fyjevUZYk8F/uSeAk0q2u2vUzrx
 G4YgNpPgJWWTYQOVc23a5LZ4gK50HHWENGml0oyC1T4ocD5yYbgoZcjUS3KBiqRNKB4fg1ndHjS
 2TlHMx9UxHEX5yzW4MxNGVApeEkDOnMDLctjTE2LIyOyQDrM7bbnJxkoDkwHp7AyhcAq0gnbXnd
 OkW22nu9R05Sk3NEyWAIcFdHi8QuISJ5moxlWqMCn+8cqABL2/IXyATIpYsxSpGt1slNFKXsrQm
 DrzI0D0lbMJSLa/XXk1ehA18T2LvIqhb+mYXcMvV6pvatb1BUiy5RnvoivCALwlLSJ5rao4sDtZ
 O95oEbtV0g=
X-Received: by 2002:a05:600c:3b88:b0:495:495f:bc30 with SMTP id
 5b1f17b1804b1-4954a3391femr195729495e9.12.1784623866445; 
 Tue, 21 Jul 2026 01:51:06 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c7desm68707245e9.7.2026.07.21.01.51.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:51:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/16] hw/dma/soc_dma: Use physical_memory_map() for mem2mem
 transfers
Date: Tue, 21 Jul 2026 09:50:46 +0100
Message-ID: <20260721085050.421257-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721085050.421257-1-peter.maydell@linaro.org>
References: <20260721085050.421257-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x00.google.com
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

The soc_dma code has a fastpath for when DMA transfers are from RAM
to RAM.  The current implementation of this has the caller of
soc_dma_port_add_mem() pass the underlying host address of the RAM
block that the DMA port is connected to (obtained via
memory_region_get_ram_ptr()).  Then the actual transfer function does
a simple memcpy(). This has several problems.

Most importantly, no bounds checking is done on the address and size
passed by the guest, so the memcpy source and destination might be
outside the backing host RAM entirely.  Secondly, because the DMA
access is done via this back door, there is no updating of the dirty
region when memory is written this way (there is a TODO comment
in omap_dma.c noting this).

Fix both of these by making the memory to memory transfer function
use physical_memory_map() to get the host addresses for the memory
copy.  That function will automatically give us the bounds check that
we want and return a short length if the transfer would run off the
end of the RAM MemoryRegion it starts in.  Since the OMAP DMA
documentation states that it's a guest error to misprogram the
addresses so that they fall outside the range that is valid for the
particular DMA port being addressed and that this can result in guest
memory corruption , we don't need to loop for short transfers, but
can simply log them and continue.

Note that we don't need to update addresses or bytecount here in the
transfer function, because when soc_dma_ch_update() selects
transfer_mem2mem it also sets ch->update to 1, which tells the
omap_dma_transfer_setup() code that it is responsible for updating
all the guest visible fields to match "transfer completed".

(We use physical_memory_map() here to match the use of
physical_memory_read() and physical_memory_write() in omap_dma.c;
making the DMA controller use an explicit AddressSpace would be
a separate cleanup task.)

Together with the preceding commits that fixed some integer overflow
problems, this fixes the "guest can provoke a bad memcpy() operation"
reported in issue #3204.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3204
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260710105907.2570621-7-peter.maydell@linaro.org
---
 hw/dma/omap_dma.c |  5 -----
 hw/dma/soc_dma.c  | 51 ++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index 14b310bf404..1a3ae747269 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -559,11 +559,6 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
         if (!ch->sync && frames) {
             ch->cpc = a->dest & 0xffff;
         }
-
-        /*
-         * TODO: if the destination port is IMIF or EMIFF, set the dirty
-         * bits on it.
-         */
     }
 
     omap_dma_interrupts_update(s);
diff --git a/hw/dma/soc_dma.c b/hw/dma/soc_dma.c
index 1b93aaf5655..6e325122d9e 100644
--- a/hw/dma/soc_dma.c
+++ b/hw/dma/soc_dma.c
@@ -20,13 +20,58 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
+#include "qemu/log.h"
+#include "system/physmem.h"
 #include "hw/arm/soc_dma.h"
 
 static void transfer_mem2mem(struct soc_dma_ch_s *ch)
 {
-    memcpy(ch->paddr[0], ch->paddr[1], ch->bytes);
-    ch->paddr[0] += ch->bytes;
-    ch->paddr[1] += ch->bytes;
+    /*
+     * Memory-to-memory transfer: do the whole thing in one go.  The
+     * hardware spec says that it is invalid to program the OMAP DMA
+     * controller with addresses that don't match the port (i.e. to
+     * ask for a transfer to/from a memory port with a physaddr that
+     * isn't within that port range) and that if you do then the
+     * transfer continues and memory can be corrupted.  So we can map
+     * both source and destination, and treat short mappings and
+     * failed mappings as a guest error.
+     */
+    hwaddr srclen = ch->bytes;
+    hwaddr dstlen = ch->bytes;
+    hwaddr srcaddr = ch->vaddr[0];
+    hwaddr dstaddr = ch->vaddr[1];
+    void *srcmem, *dstmem;
+    hwaddr xferlen = 0;
+
+    srcmem = physical_memory_map(srcaddr, &srclen, false);
+    if (!srcmem) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "soc_dma mem2mem transfer: could not map source; "
+                      "guest error programming source port/address\n");
+        return;
+    }
+
+    dstmem = physical_memory_map(dstaddr, &dstlen, true);
+    if (!dstmem) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "soc_dma mem2mem transfer: could not map destination; "
+                      "guest error programming destination port/address\n");
+        goto unmap_src;
+    }
+
+    xferlen = MIN(srclen, dstlen);
+    if (xferlen < ch->bytes) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "soc_dma mem2mem transfer: could not transfer all data; "
+                      "guest error programming src or destination addresses\n");
+        /* Continue to transfer whatever did fit in the port window */
+    }
+
+    memmove(dstmem, srcmem, xferlen);
+
+    physical_memory_unmap(dstmem, dstlen, true, xferlen);
+unmap_src:
+    physical_memory_unmap(srcmem, srclen, false, xferlen);
 }
 
 struct dma_s {
-- 
2.43.0


