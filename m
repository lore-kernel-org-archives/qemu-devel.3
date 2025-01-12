Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4620E7719E
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6Ju-0003sW-Le; Sun, 12 Jan 2025 17:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6J5-00022d-RA
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:45 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6J4-0006Zd-8z
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:43 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so26231395e9.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720380; x=1737325180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iAeWlekp0I6VowiluDZapbh9k9d5Kq9MZ32VfBn8/0g=;
 b=qlC36qKjjyf4bFXKd4dnt3lPO/cNxp3CFTs1LqBglnJ20O5n75e69hG3ACuS6uNKtx
 a3bhlnnU9y8UQLERdt7uV2Kv5beNyoPdFB37yP9PwJLjZi1eCwm8mDcI1NXClaplewEH
 5Vv4R+1QI/VqJvV3Ndx9g+Wt+aRuXy1ALXdqBZtH/l0z8wXALBCu5/2zSkKeDcgC5Svo
 Cj3GgLFRDvWfR0nXpkCIJqgO5cbXgytwhXf2ye5XqidmKmTjd9EOXFo0uRmlpMkv88De
 38kYrtHxFnRk/CC53oC7qaql0NGUA+0w0ylUuFXSo0vnt+/DpXW8FAFkswYYRGyLgs4f
 /PbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720380; x=1737325180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iAeWlekp0I6VowiluDZapbh9k9d5Kq9MZ32VfBn8/0g=;
 b=PKlvyHy2l5c7PQA90674c01Nz/zyMVaFNv5mOD/K5WadeRjCASjZRFSm9K94FLMwCQ
 xwPxx40mWfTpieFb66jUZFw7Os/sRcfx8cr1NoOCGx/Nbgc8mW+LtTwaj38LBAfC8eBg
 PkCSYtsU+xuwDPPdOtd2v1iiYttnKVuVcn4mj4CSX8KRKsaBQ2JIP/WZRO9uGrFPYmYt
 FYPZtfMwMveiv2QU4tzJ9udg8j6KXQ9mWNq9Z1HMmvmU+WkZj/8nWeGHyoh0LZdCsiXu
 Xj7NrFAk/u221d9CAGKus2u24jTFDsJldfGkei5P4QjsIlcp7+yA9WGizKtq6xbvgaeY
 uXdQ==
X-Gm-Message-State: AOJu0YyS8e5g5nbOHdV3L9C4t53UrWnrWVTkJFu/UMW3strino90gAQD
 SyktYKD0cHe1YTHEswFwHd2HlK8Iqg47j1OPGPStVJ0NFIbxZRkcqvuWCZhbERW1LoVSlI/eVzS
 FnEE=
X-Gm-Gg: ASbGncvyqTjeHi4yPdldKIsSROr7A3XuvYtDP2rznBDMJzjCG7I7fQUUH7cZF5m4Y91
 mlHwhZqsWdho8oq8s2D24EcNU6CPiQqmqwmTrG8jnrhgqcMcSUNXF4/b34SrhEi2fgZQB2wuAeq
 X6bnG5yfbbCIzlesdNIhPt21Mqk6oZaoCJiYjd0+ksK6E9cWCen4KeGucW0E9MBTexnC7gu211Q
 gNizWzsNAaF9HYTVNqMWuIBMxD/NuOVO7GDVesqKjkcEFsnse5Avp3a3wUc4+YxLL9LaXvJczpD
 Vo13Ti0zzT5xHSDk5uznGbjpqELRYG0=
X-Google-Smtp-Source: AGHT+IF9cHGgEXMlrA1X7knljM0lI8FZG5FW2DRSqQu8nn6iPVobBJTa95sKFMZvjuHkmfdS3nlEBw==
X-Received: by 2002:a05:600c:3b8a:b0:434:f270:a4f0 with SMTP id
 5b1f17b1804b1-436e26dda80mr139563475e9.21.1736720380606; 
 Sun, 12 Jan 2025 14:19:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc0babsm157488615e9.14.2025.01.12.14.19.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:19:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 27/49] hw/sd/sdhci: Factor sdhci_sdma_transfer() out
Date: Sun, 12 Jan 2025 23:17:03 +0100
Message-ID: <20250112221726.30206-28-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Factor sdhci_sdma_transfer() out of sdhci_data_transfer().
Re-use it in sdhci_write(), so we don't try to run multi
block transfer for a single block.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20250109122029.22780-1-philmd@linaro.org>
---
 hw/sd/sdhci.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index a958c114974..318587ff57c 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -699,6 +699,15 @@ static void sdhci_sdma_transfer_single_block(SDHCIState *s)
     sdhci_end_transfer(s);
 }
 
+static void sdhci_sdma_transfer(SDHCIState *s)
+{
+    if ((s->blkcnt == 1) || !(s->trnmod & SDHC_TRNS_MULTI)) {
+        sdhci_sdma_transfer_single_block(s);
+    } else {
+        sdhci_sdma_transfer_multi_blocks(s);
+    }
+}
+
 typedef struct ADMADescr {
     hwaddr addr;
     uint16_t length;
@@ -930,12 +939,7 @@ static void sdhci_data_transfer(void *opaque)
     if (s->trnmod & SDHC_TRNS_DMA) {
         switch (SDHC_DMA_TYPE(s->hostctl1)) {
         case SDHC_CTRL_SDMA:
-            if ((s->blkcnt == 1) || !(s->trnmod & SDHC_TRNS_MULTI)) {
-                sdhci_sdma_transfer_single_block(s);
-            } else {
-                sdhci_sdma_transfer_multi_blocks(s);
-            }
-
+            sdhci_sdma_transfer(s);
             break;
         case SDHC_CTRL_ADMA1_32:
             if (!(s->capareg & R_SDHC_CAPAB_ADMA1_MASK)) {
@@ -1179,11 +1183,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
             if (!(mask & 0xFF000000) && s->blkcnt &&
                 (s->blksize & BLOCK_SIZE_MASK) &&
                 SDHC_DMA_TYPE(s->hostctl1) == SDHC_CTRL_SDMA) {
-                if (s->trnmod & SDHC_TRNS_MULTI) {
-                    sdhci_sdma_transfer_multi_blocks(s);
-                } else {
-                    sdhci_sdma_transfer_single_block(s);
-                }
+                sdhci_sdma_transfer(s);
             }
         }
         break;
-- 
2.47.1


