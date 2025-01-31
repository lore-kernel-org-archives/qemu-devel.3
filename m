Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4F7C02192
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyFL-0004Cl-Jp; Fri, 31 Jan 2025 16:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyEm-0003c4-BN
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:43 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyEk-0007zR-HN
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:40 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38637614567so1147963f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357656; x=1738962456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VwhcEyrTW8SxL1gomr78xxwwBfYGuo9Xtd73z405jUg=;
 b=cKf9CMFlMp6xGGC2ZNg6hl1p0cGZ1WMzfS1iUUL/UJMaK4QPGNUMsE3v68KqMVrgBz
 XGehkAgHy4C5zrrNzLpHlCNcokaaVzPI8UeVC+FCvOGTtg1FE3gA65RjAZxOjjdHyJXc
 Vup01/OTTxwPtTLWdsHVOmnrsDLA7AiguWpYyy1zMQVRqW8DQTKdCg31J6lrXxpo9kwQ
 DRswJNQfn4Y9fdsBK8b82wgFDtRTsvO3P7i2IFYZEOqPr0RMzTnBs9AhPF2qRjHcopfW
 2Ml4Gvm+Vy703/LmSlYpTYzpYJXoX3MxyMwXvJd+KDpC6oVXiuaqGnAw3G5rE/Lky+KR
 WBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357656; x=1738962456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VwhcEyrTW8SxL1gomr78xxwwBfYGuo9Xtd73z405jUg=;
 b=cnVCHiebVMfOr/Qqcwxou8ewEYbGHzc17qMTJaRbu1Nchxdwc/FEZ2pjiQ/83Z7BCq
 cheJbMZW//YmS6C0IfzHi+loaAJgRNXZ2nEJshRU/I4PEcRY07lAWDBRkKSkcjbfv3Dr
 1V9OcH/4Qov6F5soQ9gAhrcm6RkvZdzJc0sTeg/eoIhlUWgZg4m+bkcZ78b7WyXsWcY2
 8O9gtmW0gPjCZMlDLLYhWNDu5cDa9V3OSPO1WxBxuXdAB9w40cmjO+G9Oo+1hWxb+A+z
 E6Rtm1cXS6CKT7nGw1mx3dQmBARTzjiC2cRx8kezzel+Igi7WbEOb/RY480X8GHF+rXo
 voGQ==
X-Gm-Message-State: AOJu0YwUlqFNM7cYJkwDCItfag9K51x+rDluJJNjH/Kuo6Oyc8T1Mxbw
 wRsDqjhH9kEPdGjha4qn6S+Ta+hjs2kT5em++btRyfhG7x5afq7ZzMMJfLogVCJjBkuMI+vyIzg
 W3Bg=
X-Gm-Gg: ASbGnctN2cGwKVy+tzWh6ezWYysUP8tB77xUx/6GccJOS1tAzjFu+WyssaQfbNvIikt
 zY+I6Noz7OlfSPnAyXkYvc4UqdbgtftSMQa8MByFgzVq83ZvWJiyDmFnjQbUddckgiGKRDOtHYr
 Cmi+41S/sa7DnwQOqVL10+M8CyhvIDZh26RB9VC6ek0M0ZA/6JAs8LORkbTVgQZCi+Vu+0Ght+N
 2zx6Bnj8qV1LSWRgGTBc3htInAGIQ1EP4JK5xsOiw4DI85EFzOhPBt6719RcdL0uB5aMUjlI5wj
 ipuDfcSMWOwGFFG1avRFBdH2aQfkDz4ODsL3HkrCB77lRgP2dq3/FhyLAZOSDZmqHA==
X-Google-Smtp-Source: AGHT+IFNQXg6pB9VnAgLLZCNaPka2MT5qyPvtKPrbcj4GjeQtaudzK7Cgtpr81+uFYtGcdgL8hHX0Q==
X-Received: by 2002:a5d:588c:0:b0:385:f38e:c0c3 with SMTP id
 ffacd0b85a97d-38c51930ff6mr10790922f8f.6.1738357656042; 
 Fri, 31 Jan 2025 13:07:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c0ece21sm5529637f8f.20.2025.01.31.13.07.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:07:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/36] hw/sd/omap_mmc: Convert remaining 'struct omap_mmc_s'
 uses to OMAPMMCState
Date: Fri, 31 Jan 2025 22:05:10 +0100
Message-ID: <20250131210520.85874-28-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Mechanically convert the remaining uses of 'struct omap_mmc_s' to
'OMAPMMCState'.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250128104519.3981448-3-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index fec2cfd4d66..0f17479ecb8 100644
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
2.47.1


