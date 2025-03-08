Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1463CC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr1tf-0001L7-Cl; Sat, 08 Mar 2025 16:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1rj-0005pJ-Fy
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:37:56 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1rg-00041c-4z
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:37:51 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso97595e9.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741469866; x=1742074666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q/k+IuqmCugwBVdD9kKxpUEX74jL1+6yWn5zkp1fRLA=;
 b=ggOKiTZ+Bbb3/rlGYQOb34GHHxSnY1yxpXCkV25QI6o7trRexVmlWGooP5GJY4KDoR
 fjsW9TAvdX5fuhhSsWk/1Er9TkT2LHe+02ZLO1ZER3r9fs3pSbiOAnQzebjdKsgGrULF
 Ft9ciqwZhu3jsvpbpoQ98kvkZ/0XFiXVj0yyWt86Pt8m1RHE5fimrcfqppuhgQsOL6cR
 VqdieOmRLlehUjdmtSzOSH1YaU3QIkt6XU4k5/20MWUbafPhkrufdCFpSsluvNcp9TpG
 QF/QZOTmWlqILProEo0eg9FKEdWcq7rOJYkYErAOdava5optAUMITroh35ERH40Sbpzw
 QQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741469866; x=1742074666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q/k+IuqmCugwBVdD9kKxpUEX74jL1+6yWn5zkp1fRLA=;
 b=gDh6Ogbhs2LgyS8XldA2JZgxzgXFT6s8rhxEfKValB/WCLYbUzQvVOQD4dOleShX2A
 XSA6tlwmDeen/K339X0awvOrZlhsXYIuLjTsHnD4fGryX3BkO2JHC4qsb+zCR/+4inJr
 avI3Vks7+MqvU5i2ecnaRKuNyUq0lXehKD6jjP80XypbIXeaT6g+MYY5T0Z5IC+rmygm
 AjrZtc7CI3U4OGmOt38zktQuwgJKZRlJM2riCgfCibzekz3HPhQCPfFCd8aZ0cnZ8yFO
 GKsTc6dQ5FWZcQo0zfY4sISzmwZ9NSwKlRNf+/kujRAtWkYPxXmDcKwt/RHfVA50inya
 2zpA==
X-Gm-Message-State: AOJu0YzPfEp1WqY3tDIjayW3GaX/A2vn2mjmrwUVNZ1UD3dRAebsy7ye
 8R8FN/qbxEc5XvwlH7H/rsJOXiKqC7vnnd1T/FgC9bIOciXyQKu57JGN7Q2U2p8NLHLuXcnm4tB
 B+uM=
X-Gm-Gg: ASbGncu8bGdXPNdXYWHry+Pwg35ndBRZiKJgI/WMv578ska72QoO+Rg3YyPUAq7Aomp
 TylzDChQPiqcQ3pET0mm1DOBvlkcHGdXzpR9i4EYyB3k66p3l2ReajGDlNJcpJ0M0spIFfkGzAF
 A+deyW9fcp+Vu7WEgX8UvLVa6XBWE7xgcCJAZKXhk0NbnNZBTrhyzYATR17zeOVHAKu111oHWJw
 qnJUREJoMLcrSpYQImqDjbi8d5tt1szApyPehYzrE2fqfJ616CJhi8oiqHA26Is7f9a7K8i+FKh
 YwKaICpKNc6IZuDhh7VaUXoSKF92juj1qEJy5PM2vb7AVtmOdSsOV9SJvtZMQyVkPu+ZQwuX8rc
 1SSI7XjlQHqlWtG1aiqI=
X-Google-Smtp-Source: AGHT+IGoFnoeiu6c1BMedWp/zn/Fqal0cXYHXGv6fY6PjoLHHj+PM4R9kWt/zfYa/YjNsPX1aXLZvg==
X-Received: by 2002:a05:600c:468b:b0:43c:f00b:d581 with SMTP id
 5b1f17b1804b1-43cf00bd768mr3603935e9.29.1741469866202; 
 Sat, 08 Mar 2025 13:37:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031fdsm9642737f8f.89.2025.03.08.13.37.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 13:37:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
Subject: [PATCH v4 12/14] hw/sd/sdhci: Allow SDHCI classes to have different
 register reset values
Date: Sat,  8 Mar 2025 22:36:38 +0100
Message-ID: <20250308213640.13138-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308213640.13138-1-philmd@linaro.org>
References: <20250308213640.13138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For the registers which are not zeroed at reset, allow the
different implementations to set particular reset values.

Remove the misleading values commented in sdhci-internal.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci-internal.h | 24 ++++++++++++------------
 include/hw/sd/sdhci.h  | 20 ++++++++++++++++++++
 hw/sd/sdhci.c          | 14 ++++++++++++++
 3 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index c459279f3f3..4ca269831f3 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -71,7 +71,7 @@
 /* R/W Buffer Data Register 0x0 */
 #define SDHC_BDATA                     0x20
 
-/* R/ROC Present State Register 0x000A0000 */
+/* R/ROC Present State Register */
 #define SDHC_PRNSTS                    0x24
 #define SDHC_CMD_INHIBIT               0x00000001
 #define SDHC_DATA_INHIBIT              0x00000002
@@ -89,7 +89,7 @@ FIELD(SDHC_PRNSTS, CMD_LVL,            24, 1);
 #define TRANSFERRING_DATA(x)           \
     ((x) & (SDHC_DOING_READ | SDHC_DOING_WRITE))
 
-/* R/W Host control Register 0x0 */
+/* R/W Host control Register */
 #define SDHC_HOSTCTL                   0x28
 #define SDHC_CTRL_LED                  0x01
 #define SDHC_CTRL_DATATRANSFERWIDTH    0x02 /* SD mode only */
@@ -105,17 +105,17 @@ FIELD(SDHC_PRNSTS, CMD_LVL,            24, 1);
 #define SDHC_CTRL_CDTEST_INS           0x40
 #define SDHC_CTRL_CDTEST_EN            0x80
 
-/* R/W Power Control Register 0x0 */
+/* R/W Power Control Register */
 #define SDHC_PWRCON                    0x29
 #define SDHC_POWER_ON                  (1 << 0)
 FIELD(SDHC_PWRCON, BUS_VOLTAGE,        1, 3);
 
-/* R/W Block Gap Control Register 0x0 */
+/* R/W Block Gap Control Register */
 #define SDHC_BLKGAP                    0x2A
 #define SDHC_STOP_AT_GAP_REQ           0x01
 #define SDHC_CONTINUE_REQ              0x02
 
-/* R/W WakeUp Control Register 0x0 */
+/* R/W WakeUp Control Register */
 #define SDHC_WAKCON                    0x2B
 #define SDHC_WKUP_ON_INS               (1 << 1)
 #define SDHC_WKUP_ON_RMV               (1 << 2)
@@ -129,17 +129,17 @@ FIELD(SDHC_PWRCON, BUS_VOLTAGE,        1, 3);
 #define SDHC_CLOCK_IS_ON(x)            \
     (((x) & SDHC_CLOCK_CHK_MASK) == SDHC_CLOCK_CHK_MASK)
 
-/* R/W Timeout Control Register 0x0 */
+/* R/W Timeout Control Register */
 #define SDHC_TIMEOUTCON                0x2E
 FIELD(SDHC_TIMEOUTCON, COUNTER,        0, 4);
 
-/* R/W Software Reset Register 0x0 */
+/* R/W Software Reset Register */
 #define SDHC_SWRST                     0x2F
 #define SDHC_RESET_ALL                 0x01
 #define SDHC_RESET_CMD                 0x02
 #define SDHC_RESET_DATA                0x04
 
-/* ROC/RW1C Normal Interrupt Status Register 0x0 */
+/* ROC/RW1C Normal Interrupt Status Register */
 #define SDHC_NORINTSTS                 0x30
 #define SDHC_NIS_ERR                   0x8000
 #define SDHC_NIS_CMDCMP                0x0001
@@ -152,7 +152,7 @@ FIELD(SDHC_TIMEOUTCON, COUNTER,        0, 4);
 #define SDHC_NIS_REMOVE                0x0080
 #define SDHC_NIS_CARDINT               0x0100
 
-/* ROC/RW1C Error Interrupt Status Register 0x0 */
+/* ROC/RW1C Error Interrupt Status Register */
 #define SDHC_ERRINTSTS                 0x32
 #define SDHC_EIS_CMDTIMEOUT            0x0001
 #define SDHC_EIS_BLKGAP                0x0004
@@ -160,7 +160,7 @@ FIELD(SDHC_TIMEOUTCON, COUNTER,        0, 4);
 #define SDHC_EIS_CMD12ERR              0x0100
 #define SDHC_EIS_ADMAERR               0x0200
 
-/* R/W Normal Interrupt Status Enable Register 0x0 */
+/* R/W Normal Interrupt Status Enable Register */
 #define SDHC_NORINTSTSEN               0x34
 #define SDHC_NISEN_CMDCMP              0x0001
 #define SDHC_NISEN_TRSCMP              0x0002
@@ -171,7 +171,7 @@ FIELD(SDHC_TIMEOUTCON, COUNTER,        0, 4);
 #define SDHC_NISEN_REMOVE              0x0080
 #define SDHC_NISEN_CARDINT             0x0100
 
-/* R/W Error Interrupt Status Enable Register 0x0 */
+/* R/W Error Interrupt Status Enable Register */
 #define SDHC_ERRINTSTSEN               0x36
 #define SDHC_EISEN_CMDTIMEOUT          0x0001
 #define SDHC_EISEN_BLKGAP              0x0004
@@ -206,7 +206,7 @@ FIELD(SDHC_HOSTCTL2, VERSION4,        12, 1); /* since v4 */
 FIELD(SDHC_HOSTCTL2, ASYNC_INT,       14, 1);
 FIELD(SDHC_HOSTCTL2, PRESET_ENA,      15, 1);
 
-/* HWInit Capabilities Register 0x05E80080 */
+/* HWInit Capabilities Register */
 #define SDHC_CAPAB                     0x40
 FIELD(SDHC_CAPAB, TOCLKFREQ,           0, 6);
 FIELD(SDHC_CAPAB, TOUNIT,              7, 1);
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 15ef3a07b54..eb8380187b5 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -117,6 +117,26 @@ typedef struct SDHCIClass {
     uint32_t quirks;
     uint64_t iomem_size;
 
+    /* Default reset values */
+    struct {
+        uint32_t sdmasysad;
+
+        uint16_t blksize;
+        uint16_t blkcnt;
+
+        uint32_t prnsts;
+
+        uint8_t  hostctl1;
+        uint8_t  pwrcon;
+        uint8_t  blkgap;
+        uint8_t  wakcon;
+
+        uint16_t clkcon;
+        uint8_t  timeoutcon;
+
+        uint16_t norintstsen;
+        uint16_t errintstsen;
+    } reset;
     /* Read-only registers */
     struct {
         uint64_t capareg;
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 9708b52f850..234a6e4a1fe 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -294,6 +294,7 @@ static void sdhci_set_readonly(DeviceState *dev, bool level)
 
 static void sdhci_reset(SDHCIState *s)
 {
+    SDHCIClass *sc = SYSBUS_SDHCI_GET_CLASS(s);
     DeviceState *dev = DEVICE(s);
 
     timer_del(s->insert_timer);
@@ -306,6 +307,19 @@ static void sdhci_reset(SDHCIState *s)
      */
     memset(&s->sdmasysad, 0, (uintptr_t)&s->capareg - (uintptr_t)&s->sdmasysad);
 
+    s->sdmasysad = sc->reset.sdmasysad;
+    s->blksize = sc->reset.blksize;
+    s->blkcnt = sc->reset.blkcnt;
+    s->prnsts = sc->reset.prnsts;
+    s->hostctl1 = sc->reset.hostctl1;
+    s->pwrcon = sc->reset.pwrcon;
+    s->blkgap = sc->reset.blkgap;
+    s->wakcon = sc->reset.wakcon;
+    s->clkcon = sc->reset.clkcon;
+    s->timeoutcon = sc->reset.timeoutcon;
+    s->norintstsen = sc->reset.norintstsen;
+    s->errintstsen = sc->reset.errintstsen;
+
     /* Reset other state based on current card insertion/readonly status */
     sdhci_set_inserted(dev, sdbus_get_inserted(&s->sdbus));
     sdhci_set_readonly(dev, sdbus_get_readonly(&s->sdbus));
-- 
2.47.1


