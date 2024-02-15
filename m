Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CECC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafep-0000HG-Ug; Thu, 15 Feb 2024 12:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeL-0007z8-Q2
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:54 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeG-0003xt-MH
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:53 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3392b045e0aso687071f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018547; x=1708623347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OMq3Oiu8MVXVSj6SjndbT1ne8mFYQDhWUWbGPd/yiL0=;
 b=Tm8XQY5f7N/aFnaCXBxs2O/TBaTCRHcTOg5CAd3ebM4G8FX8kIeV5jUAy2nUw3HKdx
 rO/msKlvMK543R9CWzyRXEnC/YB7UR6Gd3SxBHtItPHn+i9vEtyNEcbeaQqXk5gazyVu
 Zhm+iWMIJ8P4aYhnU2y4bh2D0ahvD2TIIBsP5FWzOSohd2aTVq6+y1U4iFeNJhC3cQBO
 Tx9SOmtK0T8Cz8OBTUEiuZfyxm3T3ybaF6810jsY/BGmE70AASi1gn6VpITmWuyrtV4N
 K7Ek1xR2UhZYfonh3uyeVIR0455pz+PGovx3NcH32XjXHOUomIBRsSpgGqnFT81DkG6b
 0glQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018547; x=1708623347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OMq3Oiu8MVXVSj6SjndbT1ne8mFYQDhWUWbGPd/yiL0=;
 b=tec5j2cVItsC1bEMDN4v5kRXIZjRlA4qLpU/pt5CJryqbJ9Tfe5j8XWOIPpTcpBWXx
 UNSyRPZloUitD3OxuLaDbSUdHqnYhs32obKuMwGcdmM9hS6vuw6tFpn2t/aIMruH0Dz9
 Dq3caFgDencthIxac8xLRB9wk/CEJ7lt1kCq11fQhWWPj//LtHEiTRhrny6LtuUPQJGk
 wVHdlzSj7u5oUVZ8xGeX25qCdIQA6zi9NtxmMsw+HYjd/y0HmmmRBw2sKgOveY9EzQ9k
 ZRqol8iFAkNZMBih0Cow3Z8XBFViGQwewk6RAIEnlH58hnCvo+4iCNlaUV/hwtH6b6Of
 Owbw==
X-Gm-Message-State: AOJu0Ywr7WjaP07pFKzxqnmvmc8q9xtMa8HeZ7XaMc0aWVtZMS0GQAf9
 1oKLfuOk7fNnVDb1h9UCtpybzhb7gSU/UjGD1GVh/I/Cc7qtNwU2gP0QjZvVv7i30BrXV/NRZjh
 I
X-Google-Smtp-Source: AGHT+IH7ya+ABd33GHOoGjQi+HxEwa5NcrXNUllADO+BrQr3K0rj16xnE6JZeNQ88NBN73FIcMUOFQ==
X-Received: by 2002:adf:cc86:0:b0:33b:26d7:e6dd with SMTP id
 p6-20020adfcc86000000b0033b26d7e6ddmr2037072wrj.48.1708018546972; 
 Thu, 15 Feb 2024 09:35:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/35] tests/qtest: Fix GMAC test to run on a machine in
 upstream QEMU
Date: Thu, 15 Feb 2024 17:35:20 +0000
Message-Id: <20240215173538.2430599-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Nabih Estefan <nabihestefan@google.com>

Fix the nocm_gmac-test.c file to run on a nuvoton 7xx machine instead
of 8xx. Also fix comments referencing this and values expecting 8xx.

Change-Id: Iabd0fba14910c3f1e883c4a9521350f3db9ffab8
Signed-Off-By: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Message-id: 20240208194759.2858582-2-nabihestefan@google.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: commit message tweaks]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/npcm_gmac-test.c | 84 +-----------------------------------
 tests/qtest/meson.build      |  3 +-
 2 files changed, 4 insertions(+), 83 deletions(-)

diff --git a/tests/qtest/npcm_gmac-test.c b/tests/qtest/npcm_gmac-test.c
index 9e58b15ca1c..c28b471ab20 100644
--- a/tests/qtest/npcm_gmac-test.c
+++ b/tests/qtest/npcm_gmac-test.c
@@ -36,7 +36,7 @@ typedef struct TestData {
     const GMACModule *module;
 } TestData;
 
-/* Values extracted from hw/arm/npcm8xx.c */
+/* Values extracted from hw/arm/npcm7xx.c */
 static const GMACModule gmac_module_list[] = {
     {
         .irq        = 14,
@@ -46,14 +46,6 @@ static const GMACModule gmac_module_list[] = {
         .irq        = 15,
         .base_addr  = 0xf0804000
     },
-    {
-        .irq        = 16,
-        .base_addr  = 0xf0806000
-    },
-    {
-        .irq        = 17,
-        .base_addr  = 0xf0808000
-    }
 };
 
 /* Returns the index of the GMAC module. */
@@ -182,32 +174,18 @@ static uint32_t gmac_read(QTestState *qts, const GMACModule *mod,
     return qtest_readl(qts, mod->base_addr + regno);
 }
 
-static uint16_t pcs_read(QTestState *qts, const GMACModule *mod,
-                          NPCMRegister regno)
-{
-    uint32_t write_value = (regno & 0x3ffe00) >> 9;
-    qtest_writel(qts, PCS_BASE_ADDRESS + NPCM_PCS_IND_AC_BA, write_value);
-    uint32_t read_offset = regno & 0x1ff;
-    return qtest_readl(qts, PCS_BASE_ADDRESS + read_offset);
-}
-
 /* Check that GMAC registers are reset to default value */
 static void test_init(gconstpointer test_data)
 {
     const TestData *td = test_data;
     const GMACModule *mod = td->module;
-    QTestState *qts = qtest_init("-machine npcm845-evb");
+    QTestState *qts = qtest_init("-machine npcm750-evb");
 
 #define CHECK_REG32(regno, value) \
     do { \
         g_assert_cmphex(gmac_read(qts, mod, (regno)), ==, (value)); \
     } while (0)
 
-#define CHECK_REG_PCS(regno, value) \
-    do { \
-        g_assert_cmphex(pcs_read(qts, mod, (regno)), ==, (value)); \
-    } while (0)
-
     CHECK_REG32(NPCM_DMA_BUS_MODE, 0x00020100);
     CHECK_REG32(NPCM_DMA_XMT_POLL_DEMAND, 0);
     CHECK_REG32(NPCM_DMA_RCV_POLL_DEMAND, 0);
@@ -257,64 +235,6 @@ static void test_init(gconstpointer test_data)
     CHECK_REG32(NPCM_GMAC_PTP_TAR, 0);
     CHECK_REG32(NPCM_GMAC_PTP_TTSR, 0);
 
-    /* TODO Add registers PCS */
-    if (mod->base_addr == 0xf0802000) {
-        CHECK_REG_PCS(NPCM_PCS_SR_CTL_ID1, 0x699e);
-        CHECK_REG_PCS(NPCM_PCS_SR_CTL_ID2, 0);
-        CHECK_REG_PCS(NPCM_PCS_SR_CTL_STS, 0x8000);
-
-        CHECK_REG_PCS(NPCM_PCS_SR_MII_CTRL, 0x1140);
-        CHECK_REG_PCS(NPCM_PCS_SR_MII_STS, 0x0109);
-        CHECK_REG_PCS(NPCM_PCS_SR_MII_DEV_ID1, 0x699e);
-        CHECK_REG_PCS(NPCM_PCS_SR_MII_DEV_ID2, 0x0ced0);
-        CHECK_REG_PCS(NPCM_PCS_SR_MII_AN_ADV, 0x0020);
-        CHECK_REG_PCS(NPCM_PCS_SR_MII_LP_BABL, 0);
-        CHECK_REG_PCS(NPCM_PCS_SR_MII_AN_EXPN, 0);
-        CHECK_REG_PCS(NPCM_PCS_SR_MII_EXT_STS, 0xc000);
-
-        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_ABL, 0x0003);
-        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_TX_MAX_DLY_LWR, 0x0038);
-        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_TX_MAX_DLY_UPR, 0);
-        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_TX_MIN_DLY_LWR, 0x0038);
-        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_TX_MIN_DLY_UPR, 0);
-        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_RX_MAX_DLY_LWR, 0x0058);
-        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_RX_MAX_DLY_UPR, 0);
-        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_RX_MIN_DLY_LWR, 0x0048);
-        CHECK_REG_PCS(NPCM_PCS_SR_TIM_SYNC_RX_MIN_DLY_UPR, 0);
-
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MMD_DIG_CTRL1, 0x2400);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_AN_CTRL, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_AN_INTR_STS, 0x000a);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_TC, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_DBG_CTRL, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_EEE_MCTRL0, 0x899c);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_EEE_TXTIMER, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_EEE_RXTIMER, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_LINK_TIMER_CTRL, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_EEE_MCTRL1, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_DIG_STS, 0x0010);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_ICG_ERRCNT1, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MISC_STS, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_RX_LSTS, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_BSTCTRL0, 0x00a);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_LVLCTRL0, 0x007f);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_GENCTRL0, 0x0001);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_GENCTRL1, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_TX_STS, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_RX_GENCTRL0, 0x0100);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_RX_GENCTRL1, 0x1100);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_RX_LOS_CTRL0, 0x000e);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MPLL_CTRL0, 0x0100);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MPLL_CTRL1, 0x0032);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MPLL_STS, 0x0001);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MISC_CTRL2, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_LVL_CTRL, 0x0019);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MISC_CTRL0, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_MP_MISC_CTRL1, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_DIG_CTRL2, 0);
-        CHECK_REG_PCS(NPCM_PCS_VR_MII_DIG_ERRCNT_SEL, 0);
-    }
-
     qtest_quit(qts);
 }
 
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 663338ae124..2b89e8634be 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -192,7 +192,8 @@ qtests_npcm7xx = \
    'npcm7xx_sdhci-test',
    'npcm7xx_smbus-test',
    'npcm7xx_timer-test',
-   'npcm7xx_watchdog_timer-test'] + \
+   'npcm7xx_watchdog_timer-test',
+   'npcm_gmac-test'] + \
    (slirp.found() ? ['npcm7xx_emc-test'] : [])
 qtests_aspeed = \
   ['aspeed_hace-test',
-- 
2.34.1


