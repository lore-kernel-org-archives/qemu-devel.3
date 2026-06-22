Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEC1CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbhD0-0006nZ-LF; Mon, 22 Jun 2026 12:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wbhCK-0006Kq-5w
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:08:32 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wbhCH-0006jM-IY
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:08:31 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490b1bbcf3aso30172765e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 09:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782144507; x=1782749307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v7B7MPlm8lxhhWU0KcQHkTsOfZGkRsES1ICXN/vP+BI=;
 b=APzd+dg4zHpkUm6z7CMlrIeWwOsTWyT6nMjpqUaLYFf8T65hUWQA0VCpFfN9BaLr0s
 x8f7HzpjGyGkbrLTHUZbcVpM89IJmT8o7j0bUune2kxkk00WMHlW/4CHrpocYsvJmtpT
 whv7oFMvWoFuRoaMXmmX2HQ/2qq+NlJvtr5h2y1Lkmg2PkdDTWvlnULLxpJCWXDUfkXn
 459nkXu7zUkZmjHQ3c3LxE0V4+rl02TTcHeAijNReUJDYRraaH9we+ja2j4++RwLnokF
 AAJtN4r8pSnDBTmuym2dPGVitaEsshTck0JFPDiD3WoABI8jtCnDd5Tv4/70delOroR5
 cang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782144507; x=1782749307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v7B7MPlm8lxhhWU0KcQHkTsOfZGkRsES1ICXN/vP+BI=;
 b=oshTAFhl3sghR8eZNDWapMpeX0JhfwKn5iJeLBnjsPOYU/eDHuNKxxXjWs9x8Jp2Mf
 ftta/CEuMWRSs2xNZiO/zbBrDTQFxCSaVOlsnBc6nRkh8IWQAaA54A6rIN+j/J1jvk3v
 SP/ZkUMQm6uK/kE/yCRUIlwApgg3qrfq9Tf4i7xA0w2g8WRGNSHrVtHZj//IKgXEvIFn
 rHkTDD2qMkmaouAqhzCThw39JgVAqRKAbHBXxNYzeQ5S+YCieV7R+QoOp3UUws+rjr8B
 ACBRDJ6OjfErvxPvb0JP1nTw0n67PmHdAFYj8ag2XV6N+LJPyHV0CMs1Ks8NMy9LedQZ
 qrZw==
X-Gm-Message-State: AOJu0YxZvz6NtBysPQ+hRs+nV5t4o5e7Vp5pTMl7rIYHSNMLRAKShong
 omp64f0ENrgyxp3Beu7nqKWfqUyjqZDzUq9liEwt2GHSsFVdsd/06nlLOcf3EJbo
X-Gm-Gg: AfdE7cmBdNRAh1zukKA8f/s6Ypv/2pTwnfvOvQq8e65mVz2A2gTuNj7Kcx38+YHbcQs
 MTVxtig8LFTeJpf4+KklGtxh7rGmJXfqXKVqWzEmyYZ0Ip/cBIpSAnFUFE4c0Q14TgH/iZF8fEx
 qHT69uAqFTaBhII0AIyV3L+cY53K6/1mKxzzujd23fbwvnuQ/wJ0ZRQRmphpSPKWo0LXJLy/TZX
 VNmIhQKcXObPNkNlpJz8PLzOcqbGW0J/8r0LXGVVHAe0Q+V94rLWjnxsrw4MUN1M//zo/tCApag
 dwPq/c4iBXScs39lcyRHAE6csNsktP3ZqtVcS6mZi0xOt5Fl9o+w7PRUR3UqGzH/zTyVHhj+Jnc
 3aJNroIiJaUjHdVMJjrlfqAqddpLKSKcGvmK/cTVjWb/C76rlvYLiOMjzGefIFlJTPZSrdEjCKl
 SZjgV1nvIo/CC8wbU2rdvl78Y7E39qmPEDfdPNx9E09Cw=
X-Received: by 2002:a05:600c:154a:b0:492:3e66:6c84 with SMTP id
 5b1f17b1804b1-492490af5c2mr168783525e9.30.1782144507088; 
 Mon, 22 Jun 2026 09:08:27 -0700 (PDT)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492494496d8sm225062545e9.9.2026.06.22.09.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 09:08:26 -0700 (PDT)
From: =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
To: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrey Volkov <andrey@volkov.fr>,
 =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
Subject: [PATCH v6 3/7] hw/misc/imx6_ccm: Add PLL3 and CAN clock
Date: Mon, 22 Jun 2026 18:08:08 +0200
Message-ID: <95da33074f8b79842566d61e4e04448b1e622080.1782140438.git.matyas.bobek@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782140438.git.matyas.bobek@gmail.com>
References: <cover.1782140438.git.matyas.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add fixed frequency (480 MHz) PLL3, of which the FlexCAN
clock is derived, and compute FlexCAN frequency based on
the divider configuration (CCM_CSCMR2).

The clock frequency will be used for computing timestamps
in FlexCAN emulator.

Signed-off-by: Matyáš Bobek <matyas.bobek@gmail.com>
Signed-off-by: Pavel Pisa <pisa@fel.cvut.cz>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Pavel Pisa <pisa@fel.cvut.cz>
---
 hw/misc/imx6_ccm.c         | 24 ++++++++++++++++++++++++
 hw/misc/trace-events       |  2 ++
 include/hw/misc/imx6_ccm.h |  4 ++++
 include/hw/misc/imx_ccm.h  |  1 +
 4 files changed, 31 insertions(+)

diff --git a/hw/misc/imx6_ccm.c b/hw/misc/imx6_ccm.c
index a10b67d396..45fdd0d5a8 100644
--- a/hw/misc/imx6_ccm.c
+++ b/hw/misc/imx6_ccm.c
@@ -257,6 +257,15 @@ static uint64_t imx6_analog_get_pll2_clk(IMX6CCMState *dev)
     return freq;
 }
 
+static uint64_t imx6_analog_get_pll3_clk(IMX6CCMState *dev)
+{
+    uint64_t freq = 480000000;
+
+    trace_imx6_analog_get_pll3_clk(freq);
+
+    return freq;
+}
+
 static uint64_t imx6_analog_get_pll2_pfd0_clk(IMX6CCMState *dev)
 {
     uint64_t freq = 0;
@@ -344,6 +353,18 @@ static uint64_t imx6_ccm_get_per_clk(IMX6CCMState *dev)
     return freq;
 }
 
+static uint64_t imx6_ccm_get_can_clk(IMX6CCMState *dev)
+{
+    uint64_t freq = 0;
+
+    freq = imx6_analog_get_pll3_clk(dev) / 8;
+    freq /= (1 + EXTRACT(dev->ccm[CCM_CSCMR2], CAN_CLK_PODF));
+
+    trace_imx6_ccm_get_can_clk(freq);
+
+    return freq;
+}
+
 static uint32_t imx6_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
 {
     uint32_t freq = 0;
@@ -358,6 +379,9 @@ static uint32_t imx6_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
     case CLK_IPG_HIGH:
         freq = imx6_ccm_get_per_clk(s);
         break;
+    case CLK_CAN:
+        freq = imx6_ccm_get_can_clk(s);
+        break;
     case CLK_32k:
         freq = CKIL_FREQ;
         break;
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index b88accc437..99910fc068 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -242,11 +242,13 @@ imx6_analog_get_periph_clk(uint32_t freq) "freq = %u Hz"
 imx6_analog_get_pll2_clk(uint32_t freq) "freq = %u Hz"
 imx6_analog_get_pll2_pfd0_clk(uint32_t freq) "freq = %u Hz"
 imx6_analog_get_pll2_pfd2_clk(uint32_t freq) "freq = %u Hz"
+imx6_analog_get_pll3_clk(uint32_t freq) "freq = %u Hz"
 imx6_analog_read(const char *reg, uint32_t value) "reg[%s] => 0x%" PRIx32
 imx6_analog_write(const char *reg, uint32_t value) "reg[%s] <= 0x%" PRIx32
 imx6_ccm_get_ahb_clk(uint32_t freq) "freq = %u Hz"
 imx6_ccm_get_ipg_clk(uint32_t freq) "freq = %u Hz"
 imx6_ccm_get_per_clk(uint32_t freq) "freq = %u Hz"
+imx6_ccm_get_can_clk(uint32_t freq) "freq = %u Hz"
 imx6_ccm_get_clock_frequency(unsigned clock, uint32_t freq) "(Clock = %d) = %u"
 imx6_ccm_read(const char *reg, uint32_t value) "reg[%s] => 0x%" PRIx32
 imx6_ccm_reset(void) ""
diff --git a/include/hw/misc/imx6_ccm.h b/include/hw/misc/imx6_ccm.h
index ccf46d7353..a54b940686 100644
--- a/include/hw/misc/imx6_ccm.h
+++ b/include/hw/misc/imx6_ccm.h
@@ -164,6 +164,10 @@
 #define PERCLK_PODF_SHIFT        (0)
 #define PERCLK_PODF_LENGTH       (6)
 
+/* CCM_CSCMR2 */
+#define CAN_CLK_PODF_SHIFT       (2)
+#define CAN_CLK_PODF_LENGTH      (6)
+
 /* CCM_ANALOG_PFD_528 */
 #define PFD0_FRAC_SHIFT          (0)
 #define PFD0_FRAC_LENGTH         (6)
diff --git a/include/hw/misc/imx_ccm.h b/include/hw/misc/imx_ccm.h
index c4212d04ea..6839716ea3 100644
--- a/include/hw/misc/imx_ccm.h
+++ b/include/hw/misc/imx_ccm.h
@@ -46,6 +46,7 @@ typedef enum  {
     CLK_EXT,
     CLK_HIGH_DIV,
     CLK_HIGH,
+    CLK_CAN,
 } IMXClk;
 
 struct IMXCCMClass {
-- 
2.54.0


