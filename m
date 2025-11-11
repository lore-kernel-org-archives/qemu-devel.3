Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46035CD1297
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 10:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIm2I-0001By-GF; Tue, 11 Nov 2025 05:55:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIm1P-0000qe-M6
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:54:48 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vIm1M-00054s-Ek
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:54:46 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b7272012d30so750714366b.2
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 02:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762858482; x=1763463282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y957JedXXz51HxEYpkd5rXFo9PIx1RfbJT3kt9mmiO4=;
 b=wjx4iNfRLnrSYKVPtaZoR99U7NFD6a1cKo8SRchfxA6n/TbWuj1nUzhfYBogcS5HJf
 7q4NjoIUEowGkHfN9In5QVYk1LhxhiheL/17ZEPQIESNeDYGkuAxV4K4KUt+enS7fo/1
 KX6Ga8sU3OBLujWDhVdhKsTVbue76WYyVrGP2GK/4NqFj89HPYlNqVZ3Xb25h8d4lVM5
 V19JJsp+pjuOSgju0ej0EOf2f0IPHnAdXo2p7CVcmdjoN1L8KL7KnpnLMKOXiWU2lNmB
 roG0H/0Pe2UI/hdqMigHEy27EY614JaNRw7LqtY+MoAVcxwrbBFJ6liO6rz39CAvw53/
 kfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762858482; x=1763463282;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y957JedXXz51HxEYpkd5rXFo9PIx1RfbJT3kt9mmiO4=;
 b=Bxn18ZCbmXfoaPdoBHmDtmpOLA1WJZJh3+HFuzpLZIi8/MdnYZtaB30txWmgWJBTl3
 eZd11Etwh1tyaWzpsqt96C5d4ar8Jfw27OPMlfMqGQXZkh87hWoyqYOppiC/LDt6Y4OR
 6syyXklG8a4O/MGZh2oPTAomwEQ3cSNMSPIMBBb4s/70q46ygbp6cLHg8R5gxAsVZ94s
 I8tzF4NvMR990lSw7kO/QYDN7rStnrnWYk1UjvDHhQXg2UP1thDvbSLDKYNRatilLOfO
 3YBKDwrp+OaAIz995wXDLNG1lq5bi7JpPdLDDkz3VyQacartoH9q8LUYEsbAvLfHJZib
 MaZA==
X-Gm-Message-State: AOJu0YzDtt0MQT480lvjYcpOG8fz7dSUmaR3swZpYASygKWVly4NRWdv
 KuB+4c6pT25ZRCuRmlCvuYXaib0NqQ+nDHrytkZiJ+C21h3BT8P0G15VH0qQheGOAO8=
X-Gm-Gg: ASbGncs+ddF1X7EqEtW4Lx2TWY68/kMHs6tt4q4tzDt7IioCkFnVEgj0Y6G5N+dITux
 bWmS63cUwi+6WlM8XITeKjpVFvz+PlZmfztF1iIe8VO+GNlZTIgALrxLEWoUObvLUOjK+tIiRjI
 C9fg6XBeuiY6a4APCFYCGWIqW4vG5vvFieF7J3vRoPtmFXTF/yqKGjL3hdCMMAnMJGiQpIJCk0O
 hkZiK1go+srdsBfzcw1D03+zn1EoecctH13axQ3cdwiGz+huhhmceTV8JK8AMOmmiY+eP9guzB0
 sACiaAnmWQZ2UUOqrHk+Omb2GxBZDYRaSAr1QaSHwrj8fnALZDNKGCTXFTZIZYCilPNeCeX/77r
 +MkpWAyHYVSNL1xSEP5h9KCgtULua04vYWSuXyDZY+3m2p+czNORIHFv2vEMRdbhRuS6tZ/agFz
 BbUME/UCdh8VI=
X-Google-Smtp-Source: AGHT+IExVkWNHtM5qz3czOCTtjdDS2GyVLjr75WTKyeK8FvEBPdu6wOYT8qFzu8efTqZevIQtgJmaA==
X-Received: by 2002:a17:907:1c1d:b0:b72:b433:1bb2 with SMTP id
 a640c23a62f3a-b72e028b170mr1031959966b.7.1762858482159; 
 Tue, 11 Nov 2025 02:54:42 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bf9bdf21sm1311057266b.59.2025.11.11.02.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 02:54:41 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7DFF15F871;
 Tue, 11 Nov 2025 10:54:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org (open list:Raspberry Pi)
Subject: [RFC PATCH] hw/dma: don't allow weird transfer lengths for bcm2835
Date: Tue, 11 Nov 2025 10:54:29 +0000
Message-ID: <20251111105429.3993300-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

The datasheet doesn't explicitly say that TXFR_LEN has to be word
aligned but the fact there is a DMA_D_WIDTH flag to select between 32
bit and 128 bit strongly implies that is how it works. The downstream
rpi kernel also goes to efforts to not write sub-4 byte lengths so
lets:

  - fail when mis-programmed and report GUEST_ERROR
  - catch setting D_WIDTH for 128 bit and report UNIMP
  - add comments that the DEBUG register isn't a straight write

This includes the test case from the reported bug which is of unknown
provenience but isn't particularly novel.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3201
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/dma/bcm2835_dma.c           | 19 +++++++++++++++++++
 tests/qtest/bcm2835-dma-test.c | 22 ++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
index a2771ddcb52..e03247796cf 100644
--- a/hw/dma/bcm2835_dma.c
+++ b/hw/dma/bcm2835_dma.c
@@ -86,6 +86,19 @@ static void bcm2835_dma_update(BCM2835DMAState *s, unsigned c)
         }
         xlen_td = xlen;
 
+        if (ch->ti & BCM2708_DMA_D_WIDTH) {
+            qemu_log_mask(LOG_UNIMP, "%s: 128bit transfers not yet supported", __func__);
+            ch->cs |= BCM2708_DMA_ERR;
+            break;
+        }
+
+        /* datasheet implies 32bit or 128bit transfers only */
+        if (xlen & 0x3) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: bad transfer size\n", __func__);
+            ch->cs |= BCM2708_DMA_ERR;
+            break;
+        }
+
         while (ylen != 0) {
             /* Normal transfer mode */
             while (xlen != 0) {
@@ -229,6 +242,12 @@ static void bcm2835_dma_write(BCM2835DMAState *s, hwaddr offset,
         ch->conblk_ad = value;
         break;
     case BCM2708_DMA_DEBUG:
+        /* this needs masking
+         * 31:29 - WAZRI
+         * 28:04 - RO
+         *    03 - WAZRI
+         * 00:02 - W1CLR
+         */
         ch->debug = value;
         break;
     default:
diff --git a/tests/qtest/bcm2835-dma-test.c b/tests/qtest/bcm2835-dma-test.c
index 18901b76d21..4b100480f25 100644
--- a/tests/qtest/bcm2835-dma-test.c
+++ b/tests/qtest/bcm2835-dma-test.c
@@ -105,12 +105,34 @@ static void bcm2835_dma_test_interrupts(void)
     bcm2835_dma_test_interrupt(14, 11);
 }
 
+static void test_cve_underflow_txfr_len_1(void)
+{
+    uint64_t dma_base = RASPI3_DMA_BASE; // 0x3f007000
+    uint32_t cb_addr = 0x1000;
+    uint32_t src_addr = 0x2000;
+    uint32_t dst_addr = 0x3000;
+    /* Prepare DMA Control Block with VULNERABLE configuration */
+    writel(cb_addr + 0, BCM2708_DMA_S_INC | BCM2708_DMA_D_INC); /* TI */
+    writel(cb_addr + 4, src_addr); /* source address */
+    writel(cb_addr + 8, dst_addr); /* destination address */
+    writel(cb_addr + 12, 1); /* ⚠️ txfr_len = 1 (TRIGGER!) */
+    writel(cb_addr + 16, 0); /* stride */
+    writel(cb_addr + 20, 0); /* next CB = NULL */
+    /* Set control block address */
+    writel(dma_base + BCM2708_DMA_ADDR, cb_addr);
+    /* Trigger DMA - this will cause the vulnerability */
+    writel(dma_base + BCM2708_DMA_CS, BCM2708_DMA_ACTIVE);
+    /* Without the fix, QEMU process will hang at 100% CPU */
+}
+
 int main(int argc, char **argv)
 {
     int ret;
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/bcm2835/dma/test_interrupts",
                    bcm2835_dma_test_interrupts);
+    qtest_add_func("/bcm2835/dma/test_underflow_txfr",
+                   test_cve_underflow_txfr_len_1);
     qtest_start("-machine raspi3b");
     ret = g_test_run();
     qtest_end();
-- 
2.47.3


