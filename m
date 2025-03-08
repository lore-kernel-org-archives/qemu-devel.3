Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D79C28B28
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 19:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqzRx-000702-Oq; Sat, 08 Mar 2025 14:03:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqzRj-0006pP-RD
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 14:02:52 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqzRg-0003WB-Mb
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 14:02:51 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43bdc607c16so22608865e9.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 11:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741460567; x=1742065367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B/DAOjgGSbt8R5XFJfa90IfAIHW3vg/xwsnsSI4jCJ0=;
 b=Te9HZ4CFYgfKFRTSCidJUFayuI0r7rtswMbXlsWWHlmWeW80jf8TJqRSUBwMCsyEqr
 rK+ZkWbbKrvcIIjtpzbm7gH2e4P5yf3324zRhylQVOPFk9jV09bbsjRTjT/KMpGiAeSx
 j3FyhjN19yzDiNH07JRCKBzDxxEKdC6BEEZGJ+Qs7ptJ6Iq7LpJvwH+gjD45VZiJMxbx
 tgICV3TXpHQkGQFUDUMj31OwGVHqkPQHRTc+9fhtOFTdfKyC22xhnmoqNxKosvwQAn22
 EhqeptEgXxG+mN9z8waaHtvFOvawOTq/Fcs4t3njE7bHAmPIGHwrydpJI3s9Z80lB3yy
 p6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741460567; x=1742065367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B/DAOjgGSbt8R5XFJfa90IfAIHW3vg/xwsnsSI4jCJ0=;
 b=lTGAxqrlnGY+u6m3yQDjlm5uSUHKgE54aHZOl3saWLegeiEkl0NzXpBDcBpa25pRGn
 yaYi92StG5gwt+rmHOSfh6F+CNq2ZoGE0kv5BdAcLYZ464IGhYWwOi75rz1OxQvhqdPb
 1vzYQ4H08+2s0wnB2eckGwDIGPF3EJC0f6vKuTNr7Tl3f12DozVaHVHJFnj6kXhsN5Fg
 y1Il7Pnec/v7vd4VpkmDyCuBBGBCdOe4LFMxQH6z65fX6I3Vnc0QkPsN+R3Tol/qVpYO
 PGpRKBsMlsQunwgAQ4Jad+pF717Q16JFmYM4VU8PV3/bx7MuxoUhhodiGjsllb1p9OYn
 HHCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhYlWWD2KZDFUL8/doglZ23bU3t4usIPdpra8vAT5mx2zacGcTKLhCphK2OKCVaDhYqdU+55oZjBPY@nongnu.org
X-Gm-Message-State: AOJu0YyoZ2BDBBV6mWPXt/k38vGude/Ag5zVw4C7nEKE7fPUpruYvs4a
 Zr8QeJTnj1Q0kdUsbvaJRuQcvId87ykQdKMM8a5ytcFBTmuep4+9HU4PgN8rdF54z8GlZkfaTBZ
 lPjQ=
X-Gm-Gg: ASbGnct/5Tw5OIz5ccswnN1B4HT4dYDqdPEPyXKGn54DyoaqKuSJOc86ZrDcubhEP3W
 anAdt4S54/Listrqf5mgbYdFtWvJXDIQ2Z7oK5AWZUYVhow4zVt+O8J6nTG6vsrnxaXI4EbcBXy
 YVyPGsWnpMtofFq7tLJUzfneaVR1sjxQjbLcylvZXgzZGTDKTxbUG6Uj0Uratr1GOE3prCiw+8n
 FGAEmvto0LlutI9lMZJCbi8lBXe49VU+wbyFBuaQCF91llinESP7oPRhcLe/UH7RrrLJaTv5CAF
 bdVjnjCLxzv4B+9h7GoTXEdodHgYTAl15vxXHkkNtCOTl6jl577sxSn1HEpQZsDdhhnY3c/I3vq
 QoJMeB3iAm9P+ZFKZOso=
X-Google-Smtp-Source: AGHT+IFuUdQOktJ/RQKgJdnwZ8m//8mj/iqJ8iiBS4xUdJyp7WWnVym+ciIWp44Zt0jiGT9RNApwcA==
X-Received: by 2002:a5d:6d8a:0:b0:38d:d371:e04d with SMTP id
 ffacd0b85a97d-39132dacb85mr5588540f8f.34.1741460566990; 
 Sat, 08 Mar 2025 11:02:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c019557sm9889830f8f.50.2025.03.08.11.02.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 11:02:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>,
	qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 03/12] hw/sd/sdhci: Make quirks a class property
Date: Sat,  8 Mar 2025 20:02:21 +0100
Message-ID: <20250308190230.7508-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308190230.7508-1-philmd@linaro.org>
References: <20250308190230.7508-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

All TYPE_IMX_USDHC instances use the quirk:
move it to the class layer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sdhci.h |  3 ++-
 hw/sd/sdhci.c         | 15 +++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index c4b20db3877..0616ce3aa59 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -95,7 +95,6 @@ struct SDHCIState {
 
     /* Configurable properties */
     bool pending_insert_quirk; /* Quirk for Raspberry Pi card insert int */
-    uint32_t quirks;
     uint8_t endianness;
     uint8_t sd_spec_version;
     uint8_t uhs_mode;
@@ -112,6 +111,8 @@ typedef struct SDHCIClass {
         PCIDeviceClass pci_parent_class;
         SysBusDeviceClass sbd_parent_class;
     };
+
+    uint32_t quirks;
 } SDHCIClass;
 
 /*
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 4917a9b3632..2b7eb11a14a 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -345,6 +345,8 @@ static void sdhci_send_command(SDHCIState *s)
     rlen = sdbus_do_command(&s->sdbus, &request, response);
 
     if (s->cmdreg & SDHC_CMD_RESPONSE) {
+        SDHCIClass *sc = SYSBUS_SDHCI_GET_CLASS(s);
+
         if (rlen == 4) {
             s->rspreg[0] = ldl_be_p(response);
             s->rspreg[1] = s->rspreg[2] = s->rspreg[3] = 0;
@@ -366,7 +368,7 @@ static void sdhci_send_command(SDHCIState *s)
             }
         }
 
-        if (!(s->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
+        if (!(sc->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
             (s->norintstsen & SDHC_NISEN_TRSCMP) &&
             (s->cmdreg & SDHC_CMD_RESPONSE) == SDHC_CMD_RSP_WITH_BUSY) {
             s->norintsts |= SDHC_NIS_TRSCMP;
@@ -1886,7 +1888,15 @@ static void imx_usdhc_init(Object *obj)
     SDHCIState *s = SYSBUS_SDHCI(obj);
 
     s->io_ops = &usdhc_mmio_ops;
-    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+}
+
+static void imx_usdhc_class_init(ObjectClass *oc, void *data)
+{
+    SDHCIClass *sc = SYSBUS_SDHCI_CLASS(oc);
+
+    sc->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+
+    sdhci_common_class_init(oc, data);
 }
 
 /* --- qdev Samsung s3c --- */
@@ -1967,6 +1977,7 @@ static const TypeInfo sdhci_types[] = {
         .name = TYPE_IMX_USDHC,
         .parent = TYPE_SYSBUS_SDHCI,
         .instance_init = imx_usdhc_init,
+        .class_init = imx_usdhc_class_init,
     },
     {
         .name = TYPE_S3C_SDHCI,
-- 
2.47.1


