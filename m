Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0D2D3E77F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SMd-0007zv-Nk; Tue, 05 Nov 2024 17:49:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SMS-00076h-Jt
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:49:20 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SMR-0004Nf-2O
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:49:20 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37d5689eea8so3512574f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846957; x=1731451757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eNVUy4JgphlrUnvvw1fKIDJ/0JALMaFzf/fcxiUPpvE=;
 b=vB9CFDACv3KAJbPfRF12S/3m6j1Vv3TB36857KQh7RBTZEJftfYu6H8fP2pLl/WEov
 W2Q+lO8amjWxYxMMDZfpDfTg3B83yUXdJUPAMJoKRzDwQEPidApS+N6nbxSqJsV9Ll+f
 3yQR97TggCPDMfqPuXS8C0GzYoWDcxMKv7M6/9X2YSsKQ4ZGJxRqgdcF4f8pXSviiVEX
 jbQGMhBMG8xBFz4G3axTvmdAyN6X2emy8YfROYvn7kf54vGbjkku4vvpavDDZ9CVdGf2
 dBKAnIVWfNy1nKKDmHdKM2PG1E7t1qRTd0Diaz2QVCgkyf7U6BKoFc/lWgHL/ZgL9LS4
 9ITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846957; x=1731451757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eNVUy4JgphlrUnvvw1fKIDJ/0JALMaFzf/fcxiUPpvE=;
 b=UxgzD9DCrvXYlJPWf5qJ35l4HvxLAemp+7dHH5/hllxk3r+nKto4wzN0CLL9jNNCwl
 VoBA3hx6TwI1z/soLznMpvuJqsBRGsEuiVJcBzpTGn761ejidpCvVkZWFzfAXj95bT1K
 3W2hRRx6ZTOrOx2Y1475kN/by09gjTzUjifqGReuDw/ngR13ms7GjJF9bv1YSNcHMbOo
 8uLDzmtq8BFOMAGO2TnynGzxEt6SG9xxZLnUWgpFURNWpBiPYFdrnpWxVuJwXxHvReXe
 sovIXP3cDecEiGNIzyh9Yca6cP5Bf/jUg4wJkI3m9mWM6gfuVkjL6ic7lGkNqDTXR1H+
 5Qkg==
X-Gm-Message-State: AOJu0YwnAN9V5mXHOwKeSPj4VAUNUbc/Ih76LpbBQT/rTOos1br8SEjI
 FQctYrY+F0qA7FlBIAz23fMWCJUY1zN5Mtrl6SF/pOkPtJmxXrHZ7GWyWjQK6A9dNpX5DxNexA7
 gRFC7Vw==
X-Google-Smtp-Source: AGHT+IFX/i8Y2/aITtVswh6KioWeOJyX64NZgkefgOuURl2kJ+Ef6o1R9eeeIrbDNNqdJ6KDX6e58g==
X-Received: by 2002:adf:face:0:b0:37d:481e:fd3 with SMTP id
 ffacd0b85a97d-38061162b6emr23714906f8f.26.1730846957330; 
 Tue, 05 Nov 2024 14:49:17 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e89csm17544092f8f.74.2024.11.05.14.49.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:49:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/29] hw/net/fsl_etsec/miim: Reuse MII constants
Date: Tue,  5 Nov 2024 22:47:18 +0000
Message-ID: <20241105224727.53059-21-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Instead of defining redundant constants and using magic numbers reuse the
existing MII constants.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20241103133412.73536-16-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/fsl_etsec/miim.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/hw/net/fsl_etsec/miim.c b/hw/net/fsl_etsec/miim.c
index b48d2cb57bd..4e9169907a9 100644
--- a/hw/net/fsl_etsec/miim.c
+++ b/hw/net/fsl_etsec/miim.c
@@ -29,13 +29,6 @@
 
 /* #define DEBUG_MIIM */
 
-#define MIIM_CONTROL    0
-#define MIIM_STATUS     1
-#define MIIM_PHY_ID_1   2
-#define MIIM_PHY_ID_2   3
-#define MIIM_T2_STATUS  10
-#define MIIM_EXT_STATUS 15
-
 static void miim_read_cycle(eTSEC *etsec)
 {
     uint8_t  phy;
@@ -47,14 +40,14 @@ static void miim_read_cycle(eTSEC *etsec)
     addr = etsec->regs[MIIMADD].value & 0x1F;
 
     switch (addr) {
-    case MIIM_CONTROL:
+    case MII_BMCR:
         value = etsec->phy_control;
         break;
-    case MIIM_STATUS:
+    case MII_BMSR:
         value = etsec->phy_status;
         break;
-    case MIIM_T2_STATUS:
-        value = 0x1800;           /* Local and remote receivers OK */
+    case MII_STAT1000:
+        value = MII_STAT1000_LOK | MII_STAT1000_ROK;
         break;
     default:
         value = 0x0;
@@ -84,8 +77,8 @@ static void miim_write_cycle(eTSEC *etsec)
 #endif
 
     switch (addr) {
-    case MIIM_CONTROL:
-        etsec->phy_control = value & ~(0x8100);
+    case MII_BMCR:
+        etsec->phy_control = value & ~(MII_BMCR_RESET | MII_BMCR_FD);
         break;
     default:
         break;
-- 
2.45.2


