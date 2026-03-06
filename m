Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F646FCB61A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXHt-00018i-50; Fri, 06 Mar 2026 10:40:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyXHp-00013c-7C
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:40:21 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyXHn-0000y1-GY
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:40:20 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439b9b1900bso4256040f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772811618; x=1773416418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GdtUZgYJO/AkZ54kOEVmR9jlUu/MzOeYTvNR+pXLkow=;
 b=QiMPnfP84n11YEFWZ3qONNrtKjhqt7ksKbnu6SGRMhCr7i4mvEXcWEZB+Nc3Ay7gms
 uyWlONrudX/8BH9nfPd4EFcZKY1LlESeE8rCaF9p2G3LDdq06CoAKR1e0Cqt22xTclUA
 lnoV+rM6YxzwnwYq+dZwERa1ohHaSEEytKOmo4WkUWeCbnM5ihaHqLoqR4DTXKBiO76G
 kr3mDAzP2ckI4BRbhLks3bOudcecUJWcH7Gzf79miAeN0kEJAZ8OdbWd+ENCUbZRSYl0
 UUwwrheh/Vx5XCPxHE+xy36j/C5DhklhcLdE56JANTOY95wnFppAR+y8ycQOclhqV43d
 casA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772811618; x=1773416418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GdtUZgYJO/AkZ54kOEVmR9jlUu/MzOeYTvNR+pXLkow=;
 b=XQ+5M4Z37Ya4CRtAiRQc2UJxXOzwtXFLRNN+JJrFsgxCnlxNsi8FFWfSqRpmSPlEZG
 tWlO3WlpLgFzDqkjsMvLINAASOSaVVU9txcScNpjodogbSyhvxkrQIOwaRwIaEm7vhhW
 jAkdcB1e36LZQnPfouLwtV3Hp3IB3tqx00cYK7koPRO5zIAERNEGulZDXtzGfc/j3Mro
 HoYuTy5CkDlXRBL2WZFiVCwOdot9Nbucp8qoaOhmlXFI2YeWPLR1qXOk8AZWSjSwKvhB
 JZYZdHDjl3mqjSOq/C7nvs5OhJYGzaIIozFMgdCfwM0Pq1c5FiTBJv5+28JOHtgR+3FA
 Gx2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNp29u4DIG7dBP/UkZLHBsTtaGiIbhrIUuzliEJfPmqRHIQd4qTjY5GJJV20m0XQGZbMjZTkw+nT2S@nongnu.org
X-Gm-Message-State: AOJu0Yzxnve5cGPu3Lh5103MuoaYVA76ekI0vv8JAxp91iIk3MfGtU26
 IXwV6kEc6Dj9gh0fJiJ8DTZdFmXHeDUOq6Dq6zLw4U53OZkQZvpflf2jtHvACNbeKrA=
X-Gm-Gg: ATEYQzztwW8F9l98AWAtPfVvqS2Q6kI7aPlZYp1USiMAAgovFA80ELxXKuaMyrCgXwc
 T/ghSA6sHGwBy/f46xNNgsHVL2j5HKJ0oUaEAqf84mivadVGIxsirTIRwKxxVumqS6x0Lu/R6L2
 KSwEzSrnQapWyOH29gDzz7pz9XA4fq2ezksPSBqfWLZrpX2i5A9oJcDVQMrm+K/jnHwBQuqpIRR
 hyrpXxhWchD7l4s4HB9An553lq7uD18WFDyKBmQ8brVt4/4MDnAfbopXI4EkOjEVEv1WOM+IiNN
 yu2uNqhngmLp7eorxjLBkuwg7n9LokCh+Yif5tIV1UK026bOx94kuHi/g3onSBZUrif6HwxCYLe
 ZC9/D6S57+WfX3K6UaqQmXYPYbgh/lWKBh062KpYxXl94nJ3cEziODNtlPgRMknopXFi1FShhrn
 N7qUIXAscbDFkSAtisdxk6PGOKe4bd9wRdMZpL+jym337qh6/+yeDo7tNK0/xCMZvueWYVBT/SY
 YN2ozEFeaYTCvxd6GjUbpENjoSp3dg=
X-Received: by 2002:a05:600c:4ec9:b0:483:7783:5373 with SMTP id
 5b1f17b1804b1-4852697a0d8mr39970575e9.23.1772811617839; 
 Fri, 06 Mar 2026 07:40:17 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852470c258sm17921205e9.30.2026.03.06.07.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:40:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH] hw/net/npcm_gmac: Catch accesses off the end of the register
 array
Date: Fri,  6 Mar 2026 15:40:16 +0000
Message-ID: <20260306154016.2194091-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

In the npcm_gmac device, we create the iomem MemoryRegion with
a size of 8KB, but NPCM_GMAC_NR_REGS is only 0x1060 / 4. This
means there's a range of offsets that the guest can access
that don't have gmac->regs[] entries. We weren't catching this,
so the guest could get us to index off the end of the regs array.

Catch and log these invalid accesses.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3316
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/npcm_gmac.c         | 14 ++++++++++++++
 include/hw/net/npcm_gmac.h |  3 ++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index 123fb92ca4..d9902d9ab5 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -700,6 +700,13 @@ static uint64_t npcm_gmac_read(void *opaque, hwaddr offset, unsigned size)
     NPCMGMACState *gmac = opaque;
     uint32_t v = 0;
 
+    if (offset >= NPCM_GMAC_REG_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid register offset: 0x%04" HWADDR_PRIx"\n",
+                      DEVICE(gmac)->canonical_path, offset);
+        return v;
+    }
+
     switch (offset) {
     /* Write only registers */
     case A_NPCM_DMA_XMT_POLL_DEMAND:
@@ -724,6 +731,13 @@ static void npcm_gmac_write(void *opaque, hwaddr offset,
 
     trace_npcm_gmac_reg_write(DEVICE(gmac)->canonical_path, offset, v);
 
+    if (offset >= NPCM_GMAC_REG_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid register offset: 0x%04" HWADDR_PRIx"\n",
+                      DEVICE(gmac)->canonical_path, offset);
+        return;
+    }
+
     switch (offset) {
     /* Read only registers */
     case A_NPCM_GMAC_VERSION:
diff --git a/include/hw/net/npcm_gmac.h b/include/hw/net/npcm_gmac.h
index d4fe49ada5..23b9841a80 100644
--- a/include/hw/net/npcm_gmac.h
+++ b/include/hw/net/npcm_gmac.h
@@ -24,7 +24,8 @@
 #include "hw/core/sysbus.h"
 #include "net/net.h"
 
-#define NPCM_GMAC_NR_REGS (0x1060 / sizeof(uint32_t))
+#define NPCM_GMAC_REG_SIZE 0x1060
+#define NPCM_GMAC_NR_REGS (NPCM_GMAC_REG_SIZE / sizeof(uint32_t))
 
 #define NPCM_GMAC_MAX_PHYS 32
 #define NPCM_GMAC_MAX_PHY_REGS 32
-- 
2.43.0


