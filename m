Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F43EC28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 00:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trQhb-0004Ec-UT; Sun, 09 Mar 2025 20:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQg3-0002MG-DW
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:07:38 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQfz-0007Sg-TF
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:07:27 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso5651835e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 17:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741565241; x=1742170041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rIe2D5ODG2ZchYabV2XjHTxGs36wogLivL/gojI4Tg=;
 b=Lwr/4OJw892QnAwi/HlaWqVPxwts5Wj4/2Usfiuc2x+Wc9iY6djwv8faetE/+gUEGc
 MAbj48+L3PWRz2gyN/4AxBZR2w/hPz/PsoRDmjyaZGjmZ66OvzWeEBp8xT4L76BkMKqo
 aspyLB54CsmOBr/+dem0YYVjywEQndevs8NAhmM9z+MDzmTDKvzbZvBku0EOl1zsJ+HQ
 0CQSEuEJnddgApebES+Gckqsik8fuc8BZSoMfQDFkBultaX8sHyQak4kf7mivjISMXT7
 qNc7o0H6g3whj9WdBG/2H2d32Vp1EvXyaQN7xDmAquBfuYV0K1V+DkmYlBwcjTqb+tgY
 dq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741565241; x=1742170041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0rIe2D5ODG2ZchYabV2XjHTxGs36wogLivL/gojI4Tg=;
 b=T2759uLueADOzlT4BtnNZ9McvPcg02s6lEFfynHE5nC5bVD7SKsUtRyPiAmjChQPND
 QY9gLa3kF07m40g5S4ZwNcng3jHhWjPe/xiUMU2vzo2KfkSxjt9iOwW7syKsIwT5kfpP
 MLhluJFlm2lKMonjdvs2YlkvFs8A/R3FEzqAbTOHHLEOW+MeTGKSeFStF8Y8h62uUOVb
 xlQnpXsU9iQaR8ynIkcqJPqp990tGuhVm2tySyCBskZCm5hKMOVTqwrRstPbo3p09Ufj
 mQ5aoWdgd5sP88LVEzt/YQdrZTaVbqOXYNi2hlnGRYqYD1TdAcWWCadPsKdDEZIogMiQ
 0YBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd6LLtC71vv8+eTMraJ1s8dHfrxqF6M2ws0bi8nUf/NyNR7GZ8p8ss0Pwcp7ZyWYYpxLM3IjU4H6z9@nongnu.org
X-Gm-Message-State: AOJu0Yw5mjjz86YHVJmHaczRmrKaoFkZPkrQbT3giFD1JShO8e/EIk4+
 VR6skfU0DF1xFuINbnOwZUvuzuGLbIYUK6CfrPavl+UbOG/NnpxDmErxrBGPMRw=
X-Gm-Gg: ASbGnctH5OX+bp4XEk1ULwHrRQ8Th7HzPtBgfEoch46hoQm4gNUwKKc4sIfVlAGRq6E
 Hz/nzx86YxaJKPMZlOpBLIgi7WsImcApFmGzkl4ytbfOPHIOLHJHXKZZewoFNYonLD/hd+ChBHg
 WcFKzOyvz/I1GDSOsq9e12zy9Su2jH7kptiRpBbBQ7oKdb5naYR7ajiH8a0LyMfatO3MmtlxS3u
 Im7Sj/W8J5+MPE8cmbgclL5PqSgmlqr2m3USdR8KqVNr/TtR6Z5XlN/IEyD+GUNr8QoG8m4Kh4C
 I2XKehDsUslvRDRhiLGnEMIgWQCahNf9OkbTJUIqc/HPwjcU/owM7IhI5PDSYkYVpmByG8bJgRT
 +iP8hxuFBBzBbiLqIpf8=
X-Google-Smtp-Source: AGHT+IGC5u6Ljd9F0hNaorGjVQUhjns3oVHxCIznbwiP0izSIQ9ue1/xt+mQnwR5l448hFqEFVMPIg==
X-Received: by 2002:a05:600c:4f90:b0:43c:fad6:fa5a with SMTP id
 5b1f17b1804b1-43cfad6fe22mr2781985e9.24.1741565241334; 
 Sun, 09 Mar 2025 17:07:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e222dsm13208215f8f.72.2025.03.09.17.07.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 17:07:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>,
	qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PATCH v5 11/14] hw/sd/sdhci: Allow SDHCI classes to have different
 register reset values
Date: Mon, 10 Mar 2025 01:06:17 +0100
Message-ID: <20250310000620.70120-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310000620.70120-1-philmd@linaro.org>
References: <20250310000620.70120-1-philmd@linaro.org>
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
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/sd/sdhci-internal.h | 24 ++++++++++++------------
 include/hw/sd/sdhci.h  | 20 ++++++++++++++++++++
 hw/sd/sdhci.c          | 14 ++++++++++++++
 3 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 9072b06bdde..d99a8493db2 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -70,7 +70,7 @@
 /* R/W Buffer Data Register 0x0 */
 #define SDHC_BDATA                     0x20
 
-/* R/ROC Present State Register 0x000A0000 */
+/* R/ROC Present State Register */
 #define SDHC_PRNSTS                    0x24
 #define SDHC_CMD_INHIBIT               0x00000001
 #define SDHC_DATA_INHIBIT              0x00000002
@@ -88,7 +88,7 @@ FIELD(SDHC_PRNSTS, CMD_LVL,            24, 1);
 #define TRANSFERRING_DATA(x)           \
     ((x) & (SDHC_DOING_READ | SDHC_DOING_WRITE))
 
-/* R/W Host control Register 0x0 */
+/* R/W Host control Register */
 #define SDHC_HOSTCTL                   0x28
 #define SDHC_CTRL_LED                  0x01
 #define SDHC_CTRL_DATATRANSFERWIDTH    0x02 /* SD mode only */
@@ -104,17 +104,17 @@ FIELD(SDHC_PRNSTS, CMD_LVL,            24, 1);
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
@@ -128,17 +128,17 @@ FIELD(SDHC_PWRCON, BUS_VOLTAGE,        1, 3);
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
@@ -151,7 +151,7 @@ FIELD(SDHC_TIMEOUTCON, COUNTER,        0, 4);
 #define SDHC_NIS_REMOVE                0x0080
 #define SDHC_NIS_CARDINT               0x0100
 
-/* ROC/RW1C Error Interrupt Status Register 0x0 */
+/* ROC/RW1C Error Interrupt Status Register */
 #define SDHC_ERRINTSTS                 0x32
 #define SDHC_EIS_CMDTIMEOUT            0x0001
 #define SDHC_EIS_BLKGAP                0x0004
@@ -159,7 +159,7 @@ FIELD(SDHC_TIMEOUTCON, COUNTER,        0, 4);
 #define SDHC_EIS_CMD12ERR              0x0100
 #define SDHC_EIS_ADMAERR               0x0200
 
-/* R/W Normal Interrupt Status Enable Register 0x0 */
+/* R/W Normal Interrupt Status Enable Register */
 #define SDHC_NORINTSTSEN               0x34
 #define SDHC_NISEN_CMDCMP              0x0001
 #define SDHC_NISEN_TRSCMP              0x0002
@@ -170,7 +170,7 @@ FIELD(SDHC_TIMEOUTCON, COUNTER,        0, 4);
 #define SDHC_NISEN_REMOVE              0x0080
 #define SDHC_NISEN_CARDINT             0x0100
 
-/* R/W Error Interrupt Status Enable Register 0x0 */
+/* R/W Error Interrupt Status Enable Register */
 #define SDHC_ERRINTSTSEN               0x36
 #define SDHC_EISEN_CMDTIMEOUT          0x0001
 #define SDHC_EISEN_BLKGAP              0x0004
@@ -205,7 +205,7 @@ FIELD(SDHC_HOSTCTL2, VERSION4,        12, 1); /* since v4 */
 FIELD(SDHC_HOSTCTL2, ASYNC_INT,       14, 1);
 FIELD(SDHC_HOSTCTL2, PRESET_ENA,      15, 1);
 
-/* HWInit Capabilities Register 0x05E80080 */
+/* HWInit Capabilities Register */
 #define SDHC_CAPAB                     0x40
 FIELD(SDHC_CAPAB, TOCLKFREQ,           0, 6);
 FIELD(SDHC_CAPAB, TOUNIT,              7, 1);
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index eb21b64f932..b21adcab670 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -121,6 +121,26 @@ struct SDHCIClass {
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
index eb6a0e0f939..f731b1a141a 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -295,6 +295,7 @@ static void sdhci_set_readonly(DeviceState *dev, bool level)
 static void sdhci_reset(SDHCIState *s)
 {
     DeviceState *dev = DEVICE(s);
+    SDHCIClass *sc = s->sc;
 
     timer_del(s->insert_timer);
     timer_del(s->transfer_timer);
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


