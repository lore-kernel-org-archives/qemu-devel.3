Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2648FCA0EE6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 09:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umqJe-0003hW-WA; Fri, 15 Aug 2025 05:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJW-0003eB-Ay; Fri, 15 Aug 2025 05:01:30 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJS-0005od-SD; Fri, 15 Aug 2025 05:01:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45a1b0d224dso9235535e9.3; 
 Fri, 15 Aug 2025 02:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755248484; x=1755853284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yhe7E+9JR9f1bfFPfckbLBX3f/KTl4nrBPiyUbHb2SY=;
 b=RKMMRaxk8eHQoDrs3PMnoEPk1txkgQJgDbgLLBZFokjUz6EmHj6Xvv0o87V/w9DrWA
 R9hSuevWEviqA5bdEHPb8JFtx+DzqcxKQsErk3RQszN6QJrwpz48Xzga/ai96RiL0Zwj
 iN0yueiS0c1IIBCALHBDwO1pksHg8wxJ7pqe9ZWu1h3Diyy7uSTlt5nBuv1eZn+hHLRr
 I5F8zBtDU/3Ho/mEq+dAYWuheG5En1DDQr++Jo4lhVqUdiaszhwKuxt5KURwOjJsA3Cv
 yLIVAvoG3RKzb0WpoDpzzpUOnvOfITdb1RVr5UBywB4hbJz9A7zQsDrJj7iPIHmTFPQN
 9Ltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755248484; x=1755853284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yhe7E+9JR9f1bfFPfckbLBX3f/KTl4nrBPiyUbHb2SY=;
 b=S9xdXCZdq+RYGJ7seWX2goSzhA917U27roTCbwCjqzh//VfeRirlD9eizlXtdi1HvN
 Q3ue4EY3s/Od7+Nrpfk2ABVeR+aWnhd2JXCfYop5ttWeN9+yhjA651XWygp1GmztcXSj
 nj5REdiEu46Iq5DZkx160NuXouuyobfetFjV9X5xVAWbBuPr56SOXQLs/J0uTevg8SPr
 5UxPlffccsoKedJfDQ3bE2aGSrlIYUhWUvFvmXILIiISrl+XR3BZMrqmy4thpP0NcCqy
 yJ8j2kwDXrA917Ok6Xsk1zMAsNGQXLbiZHa8iyua0Jn8ZsxxqEyIvCLurlp+Mxcpr50P
 ulMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCWC2C5NwvmoErawdNRm91YDHn0lAjaN8wHjHwpykF3OWVU1JLbZl08jQfYnaP1KvCoKPk4tsPXA==@nongnu.org,
 AJvYcCX4zy75d5XRp0cKiGamtaLEOtizjGQuk3rhen76xjuOoaf5dA66cerZLNzeFvRO2PlNvz1jiBSDvByM9w==@nongnu.org
X-Gm-Message-State: AOJu0YxVKhd11pBFBHvolcgdgHIHeufcTXlT4PgF+97kiEEej0WlszeC
 ilLUpWC3Hr72UUemonDZGne9hl4l2vzPb7uzjOeZdVsC3LTlte/frl6fLR6/z6D8
X-Gm-Gg: ASbGncuyREAlKPrUnIIFXgv2QXmFehq6U/AobNKeEATUJZpPN0r+V6jGaD3XKIvZC5t
 qYG1f8RZZBo8xHd+sZN2hPjFqsk2MCGpmMJ44c977oFBjrIeQjqzl20YqmaYPizNzEGZfA9Kh9W
 0MeWytgI1q9gINoEVSvw1DFgo9PhbVLI67kcM7fu2jURziMMDXgiYJtwVfqKfEevWERhQzBouTf
 T3//qhGPehvLGAGAXbwlj3J0hpdnwqG3P0S7fYMQe0lZ7fo/nN0xpEo8nz0tikTU+MUBdfjWL5/
 O0SJmEJvMw5XiNUE3zMwLiY0O7M2fD8Q06ToKc617Zi1qxUMTKu2M2IJexF4oaWm3R2jEyFOO4G
 9alnNDVIiXnwS1umw6xXXxL8utNfIycnOdvchh+S851Obr8JEprDm9vvG
X-Google-Smtp-Source: AGHT+IHYHJIXN8xCDOfvrYCE902NP3v/HUZ1K1xMDhLG8nVyI3UyGqRjSzk6mDGFBW/SrpZ4mXc1tg==
X-Received: by 2002:a05:600c:1c96:b0:442:c993:6f94 with SMTP id
 5b1f17b1804b1-45a217f4228mr13697195e9.12.1755248483974; 
 Fri, 15 Aug 2025 02:01:23 -0700 (PDT)
Received: from corvink-nb.beckhoff.com
 ([2001:9e8:dc31:6500:43b3:5eac:8d91:b512])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a22321a54sm10964045e9.18.2025.08.15.02.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 02:01:23 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 YannickV <Y.Vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v2 10/14] hw/misc/zynq_slcr: Add logic for DCI configuration
Date: Fri, 15 Aug 2025 11:01:08 +0200
Message-ID: <20250815090113.141641-11-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815090113.141641-1-corvin.koehne@gmail.com>
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: YannickV <Y.Vossen@beckhoff.com>

The registers for the digitally controlled impedance (DCI) clock are
part of the system level control registers (SLCR). The DONE bit in
the status register indicates a successfull DCI calibration. An
description of the calibration process can be found here:
https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/DDR-IOB-Impedance-Calibration

The DCI control register and status register have been added. As soon
as the ENABLE and RESET bit are set, the RESET bit has also been toggled
to 0 before and the UPDATE_CONTROL is not set, the DONE bit in the status
register is set. If these bits change the DONE bit is reset. Note that the
option bits are not taken into consideration.

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/misc/zynq_slcr.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index a766bab182..8d15f0cc66 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -180,6 +180,12 @@ REG32(GPIOB_CFG_HSTL, 0xb14)
 REG32(GPIOB_DRVR_BIAS_CTRL, 0xb18)
 
 REG32(DDRIOB, 0xb40)
+REG32(DDRIOB_DCI_CTRL, 0xb70)
+    FIELD(DDRIOB_DCI_CTRL, RESET, 0, 1)
+    FIELD(DDRIOB_DCI_CTRL, ENABLE, 1, 1)
+    FIELD(DDRIOB_DCI_CTRL, UPDATE_CONTROL, 20, 1)
+REG32(DDRIOB_DCI_STATUS, 0xb74)
+    FIELD(DDRIOB_DCI_STATUS, DONE, 13, 1)
 #define DDRIOB_LENGTH 14
 
 #define ZYNQ_SLCR_MMIO_SIZE     0x1000
@@ -193,6 +199,8 @@ struct ZynqSLCRState {
 
     MemoryRegion iomem;
 
+    bool ddriob_dci_ctrl_reset_toggled;
+
     uint32_t regs[ZYNQ_SLCR_NUM_REGS];
 
     Clock *ps_clk;
@@ -331,6 +339,8 @@ static void zynq_slcr_reset_init(Object *obj, ResetType type)
 
     DB_PRINT("RESET\n");
 
+    s->ddriob_dci_ctrl_reset_toggled = false;
+
     s->regs[R_LOCKSTA] = 1;
     /* 0x100 - 0x11C */
     s->regs[R_ARM_PLL_CTRL]   = 0x0001A008;
@@ -418,6 +428,8 @@ static void zynq_slcr_reset_init(Object *obj, ResetType type)
     s->regs[R_DDRIOB + 4] = s->regs[R_DDRIOB + 5] = s->regs[R_DDRIOB + 6]
                           = 0x00000e00;
     s->regs[R_DDRIOB + 12] = 0x00000021;
+
+    s->regs[R_DDRIOB_DCI_CTRL] = 0x00000020;
 }
 
 static void zynq_slcr_reset_hold(Object *obj, ResetType type)
@@ -554,6 +566,25 @@ static void zynq_slcr_write(void *opaque, hwaddr offset,
                 (int)offset, (unsigned)val & 0xFFFF);
         }
         return;
+
+    case R_DDRIOB_DCI_CTRL:
+        if (!FIELD_EX32(val, DDRIOB_DCI_CTRL, RESET) && 
+            FIELD_EX32(s->regs[R_DDRIOB_DCI_CTRL], DDRIOB_DCI_CTRL, RESET)) {
+
+            s->ddriob_dci_ctrl_reset_toggled = true;
+            DB_PRINT("DDRIOB DCI CTRL RESET was toggled\n");
+        }
+
+        if (FIELD_EX32(val, DDRIOB_DCI_CTRL, ENABLE) &&
+            FIELD_EX32(val, DDRIOB_DCI_CTRL, RESET) &&
+            !FIELD_EX32(val, DDRIOB_DCI_CTRL, UPDATE_CONTROL) &&
+            s->ddriob_dci_ctrl_reset_toggled) {
+
+            s->regs[R_DDRIOB_DCI_STATUS] |= R_DDRIOB_DCI_STATUS_DONE_MASK;
+        } else {
+            s->regs[R_DDRIOB_DCI_STATUS] &= ~R_DDRIOB_DCI_STATUS_DONE_MASK;
+        }
+        break;
     }
 
     if (s->regs[R_LOCKSTA]) {
-- 
2.50.1


