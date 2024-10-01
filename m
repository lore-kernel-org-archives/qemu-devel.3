Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A4BCEACE7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfud-0005aH-27; Tue, 01 Oct 2024 12:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuU-0005Tz-UF
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:38 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuF-00060F-AK
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:38 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cb8dac900so55200025e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800762; x=1728405562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QS3mui/BYfOr3eX5Vx6VX1RVK+HBTtq1jSdLydD978k=;
 b=I9o+NyqUkokUJLevNBCNpcafzpD33+zFFLc21uCwaAzRB6Vg8WwBvvUYHLhMefv53b
 EyhL2TUDBZVpXLwT5KXkAeRsLtEEC9RE42nCMce7lV9epqLpAF9obUPab59eS2syUBAD
 0NhFOGlAmDPax1gsGolEyVDbOBGXUVM7IdTjcp4nNaQL8f83e6CW2FdFSFBMVPfPrEnP
 KIs3qKMUz8FosLovvkV2gGJFnqfVnNw1GhMhz04A9bCKhp75wgECBk2aWvlI7SKrs/po
 Zq7IevRRnWqolbRDH1CgYKBIb14VE8CRUx9TUYpr/4cm6jVtzUJvdtOtm/D81S3n+0Vg
 mEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800762; x=1728405562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QS3mui/BYfOr3eX5Vx6VX1RVK+HBTtq1jSdLydD978k=;
 b=r5fdLkyRwcNC+cWdiK/B02OUexk8Qc2gdwMrzDcBEa2jKt4k9WpSSPeAZ8SPlPfy0t
 wLugWb+QPGbtfcGAK7uifhXiqr321Y6qiP+IK1Bolj/5Br3AzUiF40qijzcEn6bu1LG9
 esmLiYbNYuDndHFPYjqHNsPd8E0zvasi7Wt+Ox79LGkjj0GCxNfyLBSBYqqrvb44oEq+
 CP+1RicfEGmxMeLF/QIfiblJDfr6kfHWr6qHFtyWEqwiGq3aY8oy1T7GSE0GG+0bn9bI
 fW9xBkzb5z7fnEfwkOoE+hd81LKSLlILxF5cZnxIw1NZsfsyfKP7rs/P7xGjO4xeqxnh
 DJKQ==
X-Gm-Message-State: AOJu0YxZcttk5YM4/VouI/e84c4vJsC0huqVD38a+FIt2WIep/LEpIR6
 NyGo+RwUIr/sz+khA9gtoMeoHT7iEAJe5oGA+tavSZfLm09TYfWOVgXJq9AIuiMuXDCg9bn9iw6
 3
X-Google-Smtp-Source: AGHT+IE1gJN6m51NqlAY8qo4xCz0uETiu5ShqETL4Qk+DkB86yqaooPuO9I5mga2Y0TsyA8t5deobQ==
X-Received: by 2002:adf:e711:0:b0:37c:ccbc:6573 with SMTP id
 ffacd0b85a97d-37cfb8c7618mr120092f8f.18.1727800761497; 
 Tue, 01 Oct 2024 09:39:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/54] m25p80: Add SFDP table for mt35xu01g flash
Date: Tue,  1 Oct 2024 17:38:27 +0100
Message-Id: <20241001163918.1275441-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Shiva sagar Myana <Shivasagar.Myana@amd.com>

Add the SFDP table for the Micron Xccela mt35xu01g flash.

Signed-off-by: Shiva sagar Myana <Shivasagar.Myana@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Message-id: 20240829120117.616861-1-Shivasagar.Myana@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/block/m25p80_sfdp.h |  1 +
 hw/block/m25p80.c      |  3 ++-
 hw/block/m25p80_sfdp.c | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/hw/block/m25p80_sfdp.h b/hw/block/m25p80_sfdp.h
index 1733b569508..89c2d8f72d5 100644
--- a/hw/block/m25p80_sfdp.h
+++ b/hw/block/m25p80_sfdp.h
@@ -16,6 +16,7 @@
 #define M25P80_SFDP_MAX_SIZE  (1 << 24)
 
 uint8_t m25p80_sfdp_n25q256a(uint32_t addr);
+uint8_t m25p80_sfdp_mt35xu01g(uint32_t addr);
 uint8_t m25p80_sfdp_mt35xu02g(uint32_t addr);
 
 uint8_t m25p80_sfdp_mx25l25635e(uint32_t addr);
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 134ee07fbcb..f7123f9e687 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -266,7 +266,8 @@ static const FlashPartInfo known_devices[] = {
     { INFO("n25q512ax3",  0x20ba20,  0x1000,  64 << 10, 1024, ER_4K) },
     { INFO("mt25ql512ab", 0x20ba20, 0x1044, 64 << 10, 1024, ER_4K | ER_32K) },
     { INFO_STACKED("mt35xu01g", 0x2c5b1b, 0x104100, 128 << 10, 1024,
-                   ER_4K | ER_32K, 2) },
+                   ER_4K | ER_32K, 2),
+                   .sfdp_read = m25p80_sfdp_mt35xu01g },
     { INFO_STACKED("mt35xu02gbba", 0x2c5b1c, 0x104100, 128 << 10, 2048,
                    ER_4K | ER_32K, 4),
                    .sfdp_read = m25p80_sfdp_mt35xu02g },
diff --git a/hw/block/m25p80_sfdp.c b/hw/block/m25p80_sfdp.c
index 6ee2cfaf119..82d84cc21fe 100644
--- a/hw/block/m25p80_sfdp.c
+++ b/hw/block/m25p80_sfdp.c
@@ -57,6 +57,43 @@ static const uint8_t sfdp_n25q256a[] = {
 };
 define_sfdp_read(n25q256a);
 
+static const uint8_t sfdp_mt35xu01g[] = {
+    0x53, 0x46, 0x44, 0x50, 0x06, 0x01, 0x01, 0xff,
+    0x00, 0x06, 0x01, 0x10, 0x30, 0x00, 0x00, 0xff,
+    0x84, 0x00, 0x01, 0x02, 0x80, 0x00, 0x00, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xe5, 0x20, 0x8a, 0xff, 0xff, 0xff, 0xff, 0x3f,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0xee, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
+    0xff, 0xff, 0x00, 0x00, 0x0c, 0x20, 0x11, 0xd8,
+    0x0f, 0x52, 0x00, 0x00, 0x24, 0x5a, 0x99, 0x00,
+    0x8b, 0x8e, 0x03, 0xe1, 0xac, 0x01, 0x27, 0x38,
+    0x7a, 0x75, 0x7a, 0x75, 0xfb, 0xbd, 0xd5, 0x5c,
+    0x00, 0x00, 0x70, 0xff, 0x81, 0xb0, 0x38, 0x36,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0x43, 0x0e, 0xff, 0xff, 0x21, 0xdc, 0x5c, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+};
+
+define_sfdp_read(mt35xu01g);
+
 static const uint8_t sfdp_mt35xu02g[] = {
     0x53, 0x46, 0x44, 0x50, 0x06, 0x01, 0x01, 0xff,
     0x00, 0x06, 0x01, 0x10, 0x30, 0x00, 0x00, 0xff,
-- 
2.34.1


