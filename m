Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC71C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 10:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcj6R-0001E7-GY; Tue, 28 Jan 2025 05:45:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcj60-00017d-4s
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:45:28 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcj5y-0003Vu-Ep
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:45:27 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-437a92d7b96so55932205e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 02:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738061124; x=1738665924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XrDcp9C2vowFkhJ2ur3N47jalbiWCpVSVZgOh5cHSxg=;
 b=QVxxfbk5UOllJQq7NMzjpdzh+Wdu/jcnCk4RG9CYqX/i9QH0RZH0qj4neajXn82Ese
 VMeRXePuTYL2Ko/1V9vW7+j7hV3vzpufUSaN3RDh7PMDGT/lgXtDRh3PfC/Zaji6B0s+
 ggE0eObxg5r+KCES6M+dvE5b32djQazUNl04q0xkuhZqeTd4Qugb0i+d6MRAEH+a54aS
 iAtZS/BhT4nuzq5CFeNxCC+q1pDWP1dREsJsedKEM0lwh1obxGWuXr4mJESxZarUbu6I
 zGNimoxCeaXnv3kZaer1WbQrSses6duaKQCxxlGzoxhOXkVj8dDFHeT7RhUffugLUYk9
 WPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738061124; x=1738665924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XrDcp9C2vowFkhJ2ur3N47jalbiWCpVSVZgOh5cHSxg=;
 b=sfsMuuJQelMzvJq7CJhKUI994tAg88g184MJRnm2IK86V7F5tA03IvLKPGdKGmILk3
 /fciAGYaojTrV6xkXi+rjk0sVpGBbXoNRjxVdiSpuvaOf3hu/Q0pRZxkz1AuKgdr+vO7
 Kx7ne85v4THpA3GTw9OHbske4ZeY8s+LCV4GAW9Oia4NLYJmQsEHSLgB+3rTKZ+TH2/t
 077duDigyJHOM5V1ifY/vZSvWvrIcF9VS9pBRQuT/iid3hXvvQLEX3DhVks/2nRfM68e
 lbFVjoVbKkoqFzF+R+Yx/6rmgSrQ696um7EFHA1Qpwqb1hUC4ELd7x56U+27s1vX/JDw
 JPfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1YvldBeFVPlxfcgRuRNdvttiFnzZZ2uVOvJf6JMdOIeuQ4etnh7gIINtNnCt57ha/mOabc2t6/qly@nongnu.org
X-Gm-Message-State: AOJu0YxE2gzjVTbgFAJateYsreQYff9ytCLzgprBmWtBifjNwOc0J5tm
 vJk6VTZc9McQm7Y4FWldwOL/VpMnB5z85oS+qfLngpfQRepFHK2FvBUP5nIj1P4=
X-Gm-Gg: ASbGnctm8f+0pLUiAcHDyn10XOFpWZAreVW5k9EMxayUGMEBbJiT/vIsrLmkqXBhyUg
 2NmAhMx9l6MMEw04Dx0UCTGHy5WjKOF7xGI+4RIBEgIr6fNVSYbMKDrWCrukhQgRREYTR/DBzlo
 KsDdE4JgANVD5nq3HB8C6gDHXF4CVSmjuztGdXgwqgOcBl7c4sNSgXvroSnMkDoSlNKE3jkXyvO
 iZ/JZy2Po852wUwo8VeaK70Xgv7a5kkhV90baQPnOmUbwfri7ot56Nw2NgBEhJF+ova2kjAH7N8
 u2ZA8GjaDw+TmmDXqvtM
X-Google-Smtp-Source: AGHT+IGAnMiFAiV+C4yoRdmBlKIi6PJW+NXQlw6VBvZxBqSAqnJ/O775tggZbWvyiyBeRUgPHHDZ8w==
X-Received: by 2002:a05:600c:3114:b0:434:a386:6cf with SMTP id
 5b1f17b1804b1-438913bff57mr404650415e9.2.1738061123943; 
 Tue, 28 Jan 2025 02:45:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c418esm13920133f8f.95.2025.01.28.02.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 02:45:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 02/11] hw/sd/omap_mmc: Convert remaining 'struct omap_mmc_s'
 uses to OMAPMMCState
Date: Tue, 28 Jan 2025 10:45:10 +0000
Message-Id: <20250128104519.3981448-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128104519.3981448-1-peter.maydell@linaro.org>
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Mechanically convert the remaining uses of 'struct omap_mmc_s' to
'OMAPMMCState'.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/omap.h |  2 +-
 hw/sd/omap_mmc.c      | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 6339c5a581e..7d1a1afc4f8 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -530,7 +530,7 @@ struct omap_lcd_panel_s *omap_lcdc_init(MemoryRegion *sysmem,
 
 /* omap_mmc.c */
 #define TYPE_OMAP_MMC "omap-mmc"
-OBJECT_DECLARE_SIMPLE_TYPE(omap_mmc_s, OMAP_MMC)
+OBJECT_DECLARE_SIMPLE_TYPE(OMAPMMCState, OMAP_MMC)
 
 DeviceState *omap_mmc_init(hwaddr base,
                            MemoryRegion *sysmem,
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 9cba437f74e..dd45abc075e 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -27,7 +27,7 @@
 #include "hw/arm/omap.h"
 #include "hw/sd/sdcard_legacy.h"
 
-typedef struct omap_mmc_s {
+typedef struct OMAPMMCState {
     SysBusDevice parent_obj;
 
     qemu_irq irq;
@@ -72,12 +72,12 @@ typedef struct omap_mmc_s {
     qemu_irq cdet;
 } OMAPMMCState;
 
-static void omap_mmc_interrupts_update(struct omap_mmc_s *s)
+static void omap_mmc_interrupts_update(OMAPMMCState *s)
 {
     qemu_set_irq(s->irq, !!(s->status & s->mask));
 }
 
-static void omap_mmc_fifolevel_update(struct omap_mmc_s *host)
+static void omap_mmc_fifolevel_update(OMAPMMCState *host)
 {
     if (!host->transfer && !host->fifo_len) {
         host->status &= 0xf3ff;
@@ -125,7 +125,7 @@ typedef enum {
     SD_TYPE_ADTC = 3,   /* addressed with data transfer */
 } MMCCmdType;
 
-static void omap_mmc_command(struct omap_mmc_s *host, int cmd, int dir,
+static void omap_mmc_command(OMAPMMCState *host, int cmd, int dir,
                              MMCCmdType type, int busy,
                              sd_rsp_type_t resptype, int init)
 {
@@ -234,7 +234,7 @@ static void omap_mmc_command(struct omap_mmc_s *host, int cmd, int dir,
         host->status |= 0x0001;
 }
 
-static void omap_mmc_transfer(struct omap_mmc_s *host)
+static void omap_mmc_transfer(OMAPMMCState *host)
 {
     uint8_t value;
 
@@ -289,19 +289,19 @@ static void omap_mmc_transfer(struct omap_mmc_s *host)
 
 static void omap_mmc_update(void *opaque)
 {
-    struct omap_mmc_s *s = opaque;
+    OMAPMMCState *s = opaque;
     omap_mmc_transfer(s);
     omap_mmc_fifolevel_update(s);
     omap_mmc_interrupts_update(s);
 }
 
-static void omap_mmc_pseudo_reset(struct omap_mmc_s *host)
+static void omap_mmc_pseudo_reset(OMAPMMCState *host)
 {
     host->status = 0;
     host->fifo_len = 0;
 }
 
-static void omap_mmc_reset(struct omap_mmc_s *host)
+static void omap_mmc_reset(OMAPMMCState *host)
 {
     host->last_cmd = 0;
     memset(host->rsp, 0, sizeof(host->rsp));
@@ -340,7 +340,7 @@ static void omap_mmc_reset(struct omap_mmc_s *host)
 static uint64_t omap_mmc_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint16_t i;
-    struct omap_mmc_s *s = opaque;
+    OMAPMMCState *s = opaque;
 
     if (size != 2) {
         return omap_badwidth_read16(opaque, offset);
@@ -433,7 +433,7 @@ static void omap_mmc_write(void *opaque, hwaddr offset,
                            uint64_t value, unsigned size)
 {
     int i;
-    struct omap_mmc_s *s = opaque;
+    OMAPMMCState *s = opaque;
 
     if (size != 2) {
         omap_badwidth_write16(opaque, offset, value);
-- 
2.34.1


