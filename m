Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C53AC3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjLO-0003ov-6Y; Tue, 30 Jul 2024 05:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLL-0003fA-Ja
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:31 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLJ-0000Yn-10
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:31 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3683329f787so2166111f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722332427; x=1722937227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7nLQOxJ+g65mj2LydJL4MXaPvrQeqRnkG/NPnjTzCQk=;
 b=CfJfkwZBaaNfG4sJKDA3PGogxziJ5aIB/0LWpr7s5cZ07mW/LB233ObODMErIN78e9
 lHjcvsfqsyTDo/YA2rTLESqkzvzXl0j2ExLh4vhRReog0oWset/3vbvNt9ETYAvLCl9+
 2LAb40P6dMF8xq1SvghYbJ/gLoVFAXrGAcWiY/6bVmsTyk0p9vBUPl6LFdcivCdeKRrB
 LIepGnjPtGmBx5vAzvd5Ei5UyhhDxn7OYZUbjTGYdfdQKowJRyw+2eusGmyOcWT4zvgL
 wkCo/for70UO0FjgnZL1Srwvydtf1t+mccU7FlYmUwhFByGSR9ER/4F5Ms/eJCyl+1xZ
 K/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722332427; x=1722937227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7nLQOxJ+g65mj2LydJL4MXaPvrQeqRnkG/NPnjTzCQk=;
 b=ZzV4o64FTzMz8YqCsxNccYWJuVXhH3968MuVRxOjyFFJGME6pG9ZYDeYifCLYTCdVI
 gE5fkVQliYlVduloU+5311xHIX094+BekJ9uPxEgkpFonkgpUIITCm8mcpEKqaetFCVB
 vDq/PG1+YPUzebjg6gjqzjYPjVrgtu1BO+4PD+GOyf6OV2PcJpmaHj4o9CgJTJYLa3fL
 deAtOM+dplGG0X4L+xbA6koI9IvwL+eoLTobHN4R5FNyMm7MmDiHB3rYNeiRiJreVPXo
 1ph0Tfe5xcu+BlHvVFcDuZ0M/BEcF7nw1ibpwUuysVWdivdzt/br2m05nLogCwJt3OvP
 IWzQ==
X-Gm-Message-State: AOJu0YxjY+2LSxusN5XY9hxckZksF/UtPyCiG1bYDIBhfRT883nY0rxa
 Eyhdxtb5dziVFYgC7OcfAlfHxKKtboV9dtUm2pZPNKeIcWpTFiA3qtC4Dj3ducJiYaVxEnKRzUQ
 T
X-Google-Smtp-Source: AGHT+IGxMLYeLCuVpLBPe55yX44FLU983h0Knm4RknNmR9YbBL4W8EZtX1pcHgQr6gWpMn3dRpcUrg==
X-Received: by 2002:a05:6000:1542:b0:368:4e4f:cec5 with SMTP id
 ffacd0b85a97d-36b5cf25338mr9134188f8f.35.1722332427406; 
 Tue, 30 Jul 2024 02:40:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14194974f8f.106.2024.07.30.02.40.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 02:40:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/21] hw/misc/bcm2835_property: Fix handling of
 FRAMEBUFFER_SET_PALETTE
Date: Tue, 30 Jul 2024 10:40:07 +0100
Message-Id: <20240730094020.2758637-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730094020.2758637-1-peter.maydell@linaro.org>
References: <20240730094020.2758637-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

The documentation of the "Set palette" mailbox property at
https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface#set-palette
says it has the form:

    Length: 24..1032
    Value:
        u32: offset: first palette index to set (0-255)
        u32: length: number of palette entries to set (1-256)
        u32...: RGBA palette values (offset to offset+length-1)

We get this wrong in a couple of ways:
 * we aren't checking the offset and length are in range, so the guest
   can make us spin for a long time by providing a large length
 * the bounds check on our loop is wrong: we should iterate through
   'length' palette entries, not 'length - offset' entries

Fix the loop to implement the bounds checks and get the loop
condition right. In the process, make the variables local to
this switch case, rather than function-global, so it's clearer
what type they are when reading the code.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240723131029.1159908-2-peter.maydell@linaro.org
---
 hw/misc/bcm2835_property.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 63de3db6215..e28fdca9846 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -31,7 +31,6 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
     size_t resplen;
     uint32_t tmp;
     int n;
-    uint32_t offset, length, color;
     uint32_t start_num, number, otp_row;
 
     /*
@@ -274,19 +273,25 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             resplen = 16;
             break;
         case RPI_FWREQ_FRAMEBUFFER_SET_PALETTE:
-            offset = ldl_le_phys(&s->dma_as, value + 12);
-            length = ldl_le_phys(&s->dma_as, value + 16);
-            n = 0;
-            while (n < length - offset) {
-                color = ldl_le_phys(&s->dma_as, value + 20 + (n << 2));
-                stl_le_phys(&s->dma_as,
-                            s->fbdev->vcram_base + ((offset + n) << 2), color);
-                n++;
+        {
+            uint32_t offset = ldl_le_phys(&s->dma_as, value + 12);
+            uint32_t length = ldl_le_phys(&s->dma_as, value + 16);
+            int resp;
+
+            if (offset > 255 || length < 1 || length > 256) {
+                resp = 1; /* invalid request */
+            } else {
+                for (uint32_t e = 0; e < length; e++) {
+                    uint32_t color = ldl_le_phys(&s->dma_as, value + 20 + (e << 2));
+                    stl_le_phys(&s->dma_as,
+                                s->fbdev->vcram_base + ((offset + e) << 2), color);
+                }
+                resp = 0;
             }
-            stl_le_phys(&s->dma_as, value + 12, 0);
+            stl_le_phys(&s->dma_as, value + 12, resp);
             resplen = 4;
             break;
-
+        }
         case RPI_FWREQ_FRAMEBUFFER_GET_NUM_DISPLAYS:
             stl_le_phys(&s->dma_as, value + 12, 1);
             resplen = 4;
-- 
2.34.1


