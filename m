Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D06F41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcxy-0002J1-Cl; Mon, 09 Mar 2026 11:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcxP-0001fl-AS
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:55:49 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcxN-0000gt-Jp
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:55:47 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-439b73f4ab4so8416134f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071744; x=1773676544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VWGvuis3N+sXRHcI3R/rDoWuInMgEzwzqaLHB5LkS+o=;
 b=AguU+c01rnGMBk2kADrNhsVNu9eLJevM/dK5hWQ0ejU1sdXZvRfd/Xqo1rCMsfBI4e
 i4raFrPtEBgTeFjZwWRcBXHMrNl85KNeW64uGiZBE66ReYehkYFRzDFOHKmENCcBbV5n
 2YrDtGUl37iMQi7nBYauQyxgV3e1CgNpoZkfrEJcnaxSXgenb2l9UJP0+SFfIxnwJPk6
 7PxWQ9yGSlQEusNXwawBu25S//jE57/cb0ifIKfnnzQCOl+xMpr5XyRCR9p4lY3HFuhN
 Bti+9Px+H7hLPRac2rJkKU2/9aC7Huq9HMJxCoGv9cvYuQeXjj6554fkGqgtW1Ga+WMl
 7Ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071744; x=1773676544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VWGvuis3N+sXRHcI3R/rDoWuInMgEzwzqaLHB5LkS+o=;
 b=LGvpnxXlEUcINvoS9rupcNIBlr5pKq522fgF/Zg2wlfUYhcuiONe3qqN84UUhbrssf
 YMDHXknEzYkOFrvhtlecSH1CSHrbySafbmJfO9Y02/rMEtu1tkn41b0dy81DowlCU1qH
 SmOZsHD6vLU3LYjO6dwiWIM+Dar3zeox9BUwaIm/Q6RcDTCV7Ss8TdHp5cFKUvEg7TG2
 ZdELPhRZEupW7/yaX50ZaOYnv2wc3yleFkxE3FHE6xbLtqQkxHB87rLeAVAxX9JVYleH
 IGSIdcf76O2r8ZWNlx5uYJhobn5JemTfXU8cmbvnC0n0rVhfML8+mmR0ny9pKlN/reZ7
 +eiA==
X-Gm-Message-State: AOJu0YxNQInCSAHVnWZTT8Twjo+Uvw8Yn1JJk6c9tlE7YbH68ctwdS7V
 Fd5+yn4P1Tkup2wA/0xhwaa5USBqZuSHMdX/DT9fhyI0C6f6yeukr/+abFhMqRo6XP4GYzu+uer
 lgIi23jU=
X-Gm-Gg: ATEYQzwr5WsadWb1rSX06BS7qqv4nLvfBFV5IEal2ZU+Loxx90Ng8eaFnbjPtIMN4OA
 601BoQP2CcccxaGvIdzF1A7Rvm4h8xWTdFCzXnyTJkyaYykAkFIEgLSb5C/YK4e64kgfM0Yxxgr
 CA848iR4vhnR1Gx5NPmzfas04oBgtWIYGc4Vqc4qlevui6pDAhVm2CHc1Orgea8yDAri+vvE8CN
 cMEaUwxzpEgezCTbgVzrWRK9OvF5D2oWv/ORLU3VmvmRXzzQeEvzsyyAla3v/TBGGi/cTx7hO2v
 qfhqFJQXrmyRvi56YS8xmqyQmYvwGqQtX8UtHKx9N1maagGx0t+qb4iKKxqqI9N+teQRRN3l8Fo
 NhiSbeOBlZ5XIZPSHrz6RpU7HUfIgPktiTO3pbca76QWCzFHOeJ1PTl6ObjuD3i8ODiPu10204d
 MGpWKdiaaTxZEPaAcXKInW/OH/uDc3GgHjGkMDgNSrqyox2p+d/uLHz365P6s44u3McmNqCJH1f
 t5WU+YIhPk=
X-Received: by 2002:a05:6000:2383:b0:439:b736:bd0e with SMTP id
 ffacd0b85a97d-439da891b21mr21835619f8f.44.1773071743670; 
 Mon, 09 Mar 2026 08:55:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae3c80esm24659298f8f.29.2026.03.09.08.55.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:55:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/49] hw/net/npcm_gmac: Catch accesses off the end of the
 register array
Date: Mon,  9 Mar 2026 16:52:00 +0100
Message-ID: <20260309155219.62400-31-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In the npcm_gmac device, we create the iomem MemoryRegion with
a size of 8KB, but NPCM_GMAC_NR_REGS is only 0x1060 / 4. This
means there's a range of offsets that the guest can access
that don't have gmac->regs[] entries. We weren't catching this,
so the guest could get us to index off the end of the regs array.

Catch and log these invalid accesses.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3316
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260306154016.2194091-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/net/npcm_gmac.h |  3 ++-
 hw/net/npcm_gmac.c         | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/hw/net/npcm_gmac.h b/include/hw/net/npcm_gmac.h
index d4fe49ada57..23b9841a80e 100644
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
diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index 123fb92ca40..d9902d9ab5d 100644
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
-- 
2.53.0


