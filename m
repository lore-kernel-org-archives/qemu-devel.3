Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6939C38150
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 22:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPr35-0001f1-C5; Fri, 05 Jul 2024 18:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr33-0001bS-W7
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:04:58 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr31-0007B9-Mr
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:04:57 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42562e4b5d1so14194465e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 15:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720217093; x=1720821893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDcwrWNYcnZcMeZ/8KRw8egv2ZLimv3SUep7b6VkVhI=;
 b=eSFv5lrUqg6iPQxnQIA2470Hz3T3ZSIFlRtReW1ZYMLoxFiEouUk8DnSq3bLYdIym9
 o79Aer9xK6tANtIlD5U+Sy8Il8wi+Iep04CHn41StVmiyEeQrGeN5KQNqB8JjwgEBx/m
 I+HNUwVYif46tj3/be33xGFVafhP/ALk8z0VYDPhQMftou+aFKMbS5oC/9knIKVKT7dq
 r+d1+XZkaPlvZ7MuwYcLOvtUf+Ccc6WNyOAP1oW9Zn2YI3/fm4XlTfYcgZ/tEj7oISXv
 9Il1BnJGDM3VaWVmqmI1S8NnJ9CRGQl8aePbs5/dcd0u8qphaxuc4gK73RrKiRzE1PVs
 QbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720217093; x=1720821893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uDcwrWNYcnZcMeZ/8KRw8egv2ZLimv3SUep7b6VkVhI=;
 b=l6EB0qbwXrHx+VWeq/FIgBa128gWmaJ8wNzt/FFRcRvY7oZujrNcZlpJmwR2RLXw2o
 O2UjWwHADNpUlyxuKF6UsfiZP6ZPiaxhM9wIrrz5KhCVwk4z0ZnZcUVLmWP93oGuMLh5
 Mij8vmZvfwi8+o62bJvCsi141kns8O12gTmd0xfmWicCJ/ujjkT81DdNsI2o0R1Brw8G
 Iaf1u+H8qj6LvyFg9jl4lylNY/WUiE4BiPZ1r7GtOuFDG4nWXufflaWg5EDEY0nss/3m
 P45zg5tg7RfjjDcg0pgQFSxo0mPRLb4omOE91nm7INkGKRr1yi33MRw8k4N/X9YRghbs
 JNXQ==
X-Gm-Message-State: AOJu0Yxghs5bVB21tSDyDVebfNITlDUpbA5uKsFN89xbUFbvFirskqjY
 b4crmQMrcuzzFgwpFRTIgLskfWhZAqY2/EKXUPm7/s2U2LQd8pJBTz1a5NU7CHs1d0YhQVUbmzx
 S
X-Google-Smtp-Source: AGHT+IFDN4OZL2pvaiKQztpKAgMVnDyYVgnE7mOPI8smlva07stvNAs7UE/f/em5jw2k+huZlwIz0A==
X-Received: by 2002:a05:600c:45c9:b0:425:632b:b924 with SMTP id
 5b1f17b1804b1-4264a3e3520mr40787315e9.16.1720217092790; 
 Fri, 05 Jul 2024 15:04:52 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264d6d41cesm61526645e9.16.2024.07.05.15.04.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 15:04:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/16] tests/qtest/npcm7xx_sdhci: Access the card using its
 published address
Date: Sat,  6 Jul 2024 00:04:21 +0200
Message-ID: <20240705220435.15415-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240705220435.15415-1-philmd@linaro.org>
References: <20240705220435.15415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Currently setup_sd_card() asks the card its address,
but discard the response and use hardcoded 0x4567.

Set the SDHC_CMD_RESPONSE bit to have the controller
record the bus response, and read the response from
the RSPREG0 register. Then we can select the card with
its real address.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240702140842.54242-4-philmd@linaro.org>
---
 tests/qtest/libqos/sdhci-cmd.h   | 2 ++
 tests/qtest/npcm7xx_sdhci-test.c | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/libqos/sdhci-cmd.h b/tests/qtest/libqos/sdhci-cmd.h
index 9e61dd4944..90efa028ef 100644
--- a/tests/qtest/libqos/sdhci-cmd.h
+++ b/tests/qtest/libqos/sdhci-cmd.h
@@ -22,6 +22,7 @@
 #define SDHC_ARGUMENT 0x08
 #define SDHC_TRNMOD 0x0C
 #define SDHC_CMDREG 0x0E
+#define SDHC_RSPREG0 0x10
 #define SDHC_BDATA 0x20
 #define SDHC_PRNSTS 0x24
 #define SDHC_BLKGAP 0x2A
@@ -38,6 +39,7 @@
 #define SDHC_TRNS_MULTI 0x0020
 
 /* CMD Reg */
+#define SDHC_CMD_RESPONSE (3 << 0)
 #define SDHC_CMD_DATA_PRESENT (1 << 5)
 #define SDHC_ALL_SEND_CID (2 << 8)
 #define SDHC_SEND_RELATIVE_ADDR (3 << 8)
diff --git a/tests/qtest/npcm7xx_sdhci-test.c b/tests/qtest/npcm7xx_sdhci-test.c
index 5d68540e52..01f237a816 100644
--- a/tests/qtest/npcm7xx_sdhci-test.c
+++ b/tests/qtest/npcm7xx_sdhci-test.c
@@ -30,6 +30,8 @@ char *sd_path;
 
 static QTestState *setup_sd_card(void)
 {
+    uint16_t rca;
+
     QTestState *qts = qtest_initf(
         "-machine kudo-bmc "
         "-device sd-card,drive=drive0 "
@@ -43,8 +45,10 @@ static QTestState *setup_sd_card(void)
     sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0, 0, SDHC_APP_CMD);
     sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0x41200000, 0, (41 << 8));
     sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0, 0, SDHC_ALL_SEND_CID);
-    sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0, 0, SDHC_SEND_RELATIVE_ADDR);
-    sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0x45670000, 0,
+    sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0, 0, SDHC_SEND_RELATIVE_ADDR
+                                                    | SDHC_CMD_RESPONSE);
+    rca = qtest_readl(qts, NPCM7XX_MMC_BA + SDHC_RSPREG0) >> 16;
+    sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, rca << 16, 0,
                    SDHC_SELECT_DESELECT_CARD);
 
     return qts;
-- 
2.41.0


