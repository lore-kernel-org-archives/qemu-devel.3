Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E54E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 03:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKqYp-0008VY-JC; Mon, 09 Dec 2024 22:05:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tKqYo-0008VI-0l; Mon, 09 Dec 2024 22:05:18 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tKqYm-0003FA-EZ; Mon, 09 Dec 2024 22:05:17 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-216281bc30fso30041405ad.0; 
 Mon, 09 Dec 2024 19:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733799914; x=1734404714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KOMqAq/XLCw5xaW3v52CxiPZORNNIgXMExZScw5gYTU=;
 b=SmWVhbb/EtSwARilYTDdksB/03wWp4qViPuGKtbtItdRrhVNKGLqOZKjb2bSAmRjK7
 VCtLOl9U4EgOogwwfI2L/a6gIa7wkus7wYKYoC/qXDqPH+OMNHxvcBDh3aEI6ziJNqIN
 JlKbeshTPPQdHhgTIaGeKBq5yuGi2DzpqzioG4wiX6UmJ/fEdMS0BXCUJlaPqtgRWou/
 32xN4hHmkEUWHRDghW+qMP+qAztZDwhbDSveYs0xr90eQjaPYQyiSY76cnEJihHLsWvm
 wbZKVfA6UYnypjIVoW57SACASuKYEnpv7Ec/5ohCNF35lD2IaM7Kylmr2WXwOLCfw/lc
 EcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733799914; x=1734404714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KOMqAq/XLCw5xaW3v52CxiPZORNNIgXMExZScw5gYTU=;
 b=QgGIN/gfBMj8LFkK5xoNEnDunFGWDE4TAW9mhiWoUMuBPW8wqZ8d2LjUCAk8I984lv
 4j0SQCYNbOj0RU8CPROr71Ts/Qe3ky23ehkCamIQtxfjpoMW2QuR6FcYKS+6zIYdlGuG
 sZEPRtTamNjLH0avIg8jmLNm/C+caY7njRwt9QfRYA6K9L936HK0c5eh7S8EC3p992KY
 tK1hlmvLcu2IBZpzpb4/rqstEqnjt8x+vUqIy9ACoNDdya+IXiGxLOqu7SPtQDNAY2gX
 BWJAHGs22FQd/ZKaNDZRYdKsUFVIHXXNhjlzxjBh8T+BewzcV+O4tAeg09LZ/l8IvlZd
 DQkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqpu3saFTqEQ2d/5u2LFi4uUwuMPO63Xxdi2nTKmOrrS5gfWz9PYgWw8Iq2e9WjM9iqc7+rJQuIgPm@nongnu.org
X-Gm-Message-State: AOJu0YzQsIf7J/stv/ZBLr9iWXioLZdl1/FgAm8mz1FcOlij8jZwQQxv
 e4wpdP5Ya7XjRh3YsYiuLGvB1EMI9Y7bF6bkSOUNQSmMQ/z8z7rW4++YpQ==
X-Gm-Gg: ASbGncsYbey8dVrUbwWl4PczpO5iSf45bdmHGkmp4x6Y0b580Z0X7KAoNZ8f8zWPPfP
 YjU/kAJGaL3+8ZIeWcVYpQ1lKWgu2eQrlBqXINkMBSX0lPGrt9nfs5Z2nzDzqi7CtGqTjL3UC07
 NFKHp/3cMQLiKGTZXefpdLOStYv6dGfGlH71UkPH8rzTsXswhz9R7NFvuZjwl/Od6CWAd/VvRuv
 EFAdlb4diukpG32amWiHvWL5Kr4iTZx38+stjNG/E1deTuS1yNxV7bSwpzz
X-Google-Smtp-Source: AGHT+IHdO9uodK50gxJU2TUDXL4FtW5ZWEspzalHDmxL0yE/L1tcQANSWxhasN21jvqzgXbPfbXX+A==
X-Received: by 2002:a17:903:945:b0:216:4b1f:499 with SMTP id
 d9443c01a7336-2166a01077bmr55773625ad.31.1733799914327; 
 Mon, 09 Dec 2024 19:05:14 -0800 (PST)
Received: from wheely.local0.net ([220.253.106.119])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21631118cedsm44813865ad.150.2024.12.09.19.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 19:05:13 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH 5/9] ppc/pnv/occ: Better document OCCMISC bits
Date: Tue, 10 Dec 2024 13:04:45 +1000
Message-ID: <20241210030451.1306608-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210030451.1306608-1-npiggin@gmail.com>
References: <20241210030451.1306608-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Use defines for the OCCMISC register bits, and add a comment about the
IRQ request bit, which QEMU may not model quite correctly.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_occ.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index c6681a035a7..5424d87ee97 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -30,6 +30,7 @@
 #define OCB_OCI_OCCMISC         0x4020
 #define OCB_OCI_OCCMISC_AND     0x4021
 #define OCB_OCI_OCCMISC_OR      0x4022
+#define   OCCMISC_PSI_IRQ       PPC_BIT(0)
 
 /* OCC sensors */
 #define OCC_SENSOR_DATA_BLOCK_OFFSET          0x0000
@@ -50,13 +51,16 @@
 
 static void pnv_occ_set_misc(PnvOCC *occ, uint64_t val)
 {
-    bool irq_state;
-
-    val &= 0xffff000000000000ull;
+    val &= PPC_BITMASK(0, 18); /* Mask out unimplemented bits */
 
     occ->occmisc = val;
-    irq_state = !!(val >> 63);
-    qemu_set_irq(occ->psi_irq, irq_state);
+
+    /*
+     * OCCMISC IRQ bit triggers the interrupt on a 0->1 edge, but not clear
+     * how that is handled in PSI so it is level-triggered here, which is not
+     * really correct (but skiboot is okay with it).
+     */
+    qemu_set_irq(occ->psi_irq, !!(val & OCCMISC_PSI_IRQ));
 }
 
 static uint64_t pnv_occ_power8_xscom_read(void *opaque, hwaddr addr,
-- 
2.45.2


