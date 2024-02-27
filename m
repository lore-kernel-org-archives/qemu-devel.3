Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A155EC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexaR-0000ke-Bm; Tue, 27 Feb 2024 08:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaG-0000hy-Ih
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:24 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaE-0002qi-5U
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:24 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-412a3371133so16586115e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040801; x=1709645601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ghfytIikIlf01WoNBDAZGxwpGh2RY6aESDQERQrWq0o=;
 b=rogXWil7udjuPMqLArXZ6eV7E3LOT4ReBQkOBRkQPTL8nkyHFMWdz9D258mrnWIize
 HuShu26yDKwaID/xo94EfJfIIPH+CrjNdtb+w/CPMZJsQE/5cR/QvxVBL439Wzwba3pK
 d585QmB2tvHssT6c1t+LosWCbshFKVzESyxGf83hPGZznqHWPxFppSWW0pNCkvXyOv/J
 BMdf15B/ONJfX2vVjR008F/2ppod3AzYr7s8AMIM/u6E81eOiMEfFjRVopegWI9zE2LK
 3cZSg/bqItKpMuAIGAE6zkFn6uR6suw+8ze5I6rkSp+Xo1DDl4b/K/pCwwMmaOXY8qDz
 iHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040801; x=1709645601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ghfytIikIlf01WoNBDAZGxwpGh2RY6aESDQERQrWq0o=;
 b=E0LtNkF83Bo5hHhflXwCHgdcwcKdhHxhDbzQsl9mIl7gOd4LaUS5hBOR6X7LYc0WZ5
 0xnV1M6f4tnA11nVBxDbTlMech/AxuKiEr//1Bmd2VxxgAvlqg3TBOW6yoexPf9tOyoC
 mtIeh+cWZXFyU4N0gXHU0BwiIsJPZPY+fhF2Nh0YtYl7H8+937kl03DcQupr8+BLzGIE
 GO36cMzMUD9vjkH1IXCYkgfifmempScG/d84DVOVxL8RTLlLZm8teMA43q5vibOyFZ6W
 G8SNFIFxM2PXCzlxApA/FNQZ/oTWK2hFCLd1rD6soTBJdo6x7Kr+9HKSMo7PPc10IiZf
 RH0g==
X-Gm-Message-State: AOJu0YxxCRoHhMitkenrXkBPo10M84W39/cWCSG3/vXttSSMnRl4neCs
 pV8Ft7+bHnzU6F/fF8Sj1uwLSk3y+3j4bkTe/xWgHMutOm+c29+WHRoyNtFXtnrOOWNKfGHX4p4
 x
X-Google-Smtp-Source: AGHT+IEKtW7xRYLv9EOxT8yF7WlM0x4r9j959WQWK1Ze2mjZ5nSX1vGVcMqUvskUHLzpA0rFS4j00A==
X-Received: by 2002:a05:600c:548e:b0:412:a109:5005 with SMTP id
 iv14-20020a05600c548e00b00412a1095005mr5589092wmb.0.1709040800835; 
 Tue, 27 Feb 2024 05:33:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/45] block: m25p80: Add support of mt35xu02gbba
Date: Tue, 27 Feb 2024 13:32:39 +0000
Message-Id: <20240227133314.1721857-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>

Add Micro 2Gb OSPI flash part with sfdp data.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Message-id: 20240220091721.82954-2-sai.pavan.boddu@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/block/m25p80_sfdp.h |  1 +
 hw/block/m25p80.c      |  3 +++
 hw/block/m25p80_sfdp.c | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/hw/block/m25p80_sfdp.h b/hw/block/m25p80_sfdp.h
index 011a880f66a..1733b569508 100644
--- a/hw/block/m25p80_sfdp.h
+++ b/hw/block/m25p80_sfdp.h
@@ -16,6 +16,7 @@
 #define M25P80_SFDP_MAX_SIZE  (1 << 24)
 
 uint8_t m25p80_sfdp_n25q256a(uint32_t addr);
+uint8_t m25p80_sfdp_mt35xu02g(uint32_t addr);
 
 uint8_t m25p80_sfdp_mx25l25635e(uint32_t addr);
 uint8_t m25p80_sfdp_mx25l25635f(uint32_t addr);
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 0a12030a3a1..08a00a6d9b8 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -267,6 +267,9 @@ static const FlashPartInfo known_devices[] = {
     { INFO("mt25ql512ab", 0x20ba20, 0x1044, 64 << 10, 1024, ER_4K | ER_32K) },
     { INFO_STACKED("mt35xu01g", 0x2c5b1b, 0x104100, 128 << 10, 1024,
                    ER_4K | ER_32K, 2) },
+    { INFO_STACKED("mt35xu02gbba", 0x2c5b1c, 0x104100, 128 << 10, 2048,
+                   ER_4K | ER_32K, 4),
+                   .sfdp_read = m25p80_sfdp_mt35xu02g },
     { INFO_STACKED("n25q00",    0x20ba21, 0x1000, 64 << 10, 2048, ER_4K, 4) },
     { INFO_STACKED("n25q00a",   0x20bb21, 0x1000, 64 << 10, 2048, ER_4K, 4) },
     { INFO_STACKED("mt25ql01g", 0x20ba21, 0x1040, 64 << 10, 2048, ER_4K, 2) },
diff --git a/hw/block/m25p80_sfdp.c b/hw/block/m25p80_sfdp.c
index b33811a4f5e..6ee2cfaf119 100644
--- a/hw/block/m25p80_sfdp.c
+++ b/hw/block/m25p80_sfdp.c
@@ -57,6 +57,42 @@ static const uint8_t sfdp_n25q256a[] = {
 };
 define_sfdp_read(n25q256a);
 
+static const uint8_t sfdp_mt35xu02g[] = {
+    0x53, 0x46, 0x44, 0x50, 0x06, 0x01, 0x01, 0xff,
+    0x00, 0x06, 0x01, 0x10, 0x30, 0x00, 0x00, 0xff,
+    0x84, 0x00, 0x01, 0x02, 0x80, 0x00, 0x00, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xe5, 0x20, 0x8a, 0xff, 0xff, 0xff, 0xff, 0x7f,
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
+define_sfdp_read(mt35xu02g);
 
 /*
  * Matronix
-- 
2.34.1


