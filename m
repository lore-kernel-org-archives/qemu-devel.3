Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88F7CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 14:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulpcC-0007Th-Kn; Tue, 12 Aug 2025 10:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulpcA-0007T1-VB
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 10:04:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulpc5-0007jC-Oa
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 10:04:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4563cfac2d2so47987655e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 07:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755007462; x=1755612262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xIFWjdnlfJkUuXmB+qiWsTetFCi9OyczEwhVE30q1+k=;
 b=END0WNCsyiBzOYWH6kpcamnQYo+tuIpgUND2m7H7LHWcxp9vQKrVRH1jeYlg8zDS68
 l/YshQ12uVutyBHUptzp+nXfw7dKsTtOHlgrDzfmA5aEYUP3EIyZy4fvvQSFFHMJRonz
 pGE5LUlN9IftW5YWeIvhBv8wspeRCuLrUZMiIPxrv2BFETeJKwGs0U44I7sIWIGNb3NF
 rpzYpFqHsXJs6FGkhMMQx2gCrdGmP9aNjK/p+JPj8j+W4X6arL4RTLF/TM5uQnmMFjuP
 QHQDifNJagf5hBbieHnwLQ+otgUUeVUBd07AUNQi7mEJ7Gq+g7EJVbwQUFo4OkTezNRj
 3CqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755007462; x=1755612262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xIFWjdnlfJkUuXmB+qiWsTetFCi9OyczEwhVE30q1+k=;
 b=dhPInj2pjyuSqs/RpyVTbH1HazsMdWP2PczvHccyvj15ai44ua3TerGt3kmq4mATD5
 UrvqcL275HUHno39mP7DF4iwVKX6a0fKEEaRYRd2Rf/8qa2MTZi7axS2aQ1zjAeUjIvR
 TQNzn8TBewuZpRiIXSmF+lMQE9ZTIzy4qMHl2MUXe+4Y7lkgsq04CgJ4NJLFm0cbcMyq
 +XP+z3EYTBUypXbi6YV0ngaK44ackfzn1q+TJfJXoS/z61YSa/G72st+u5pUBokQUg0Y
 /qT/bZfeEitHyJsr9WvKx3s/2ix70yXhzF5yNR9aFR4mo2hXAGYzDCTAFoN4rIjRkWKg
 /iGg==
X-Gm-Message-State: AOJu0Yxke8sgnBgCAFcn/WYzXo69g/0E8KuXKXltw+yL/SuQWyydinHW
 S296RMw5EmCTQrniNNMyDoa/vwYPnktUXVqXdBIbcxLVwgEK7BL9+f0J34NjjoFUyc7oL5Gf5vU
 A222t
X-Gm-Gg: ASbGncvapSpPowy2P9nOdBTe5R9Op0aAaylFsbdbolHi1ESS46joIshqgbU4sPyT8i+
 RmOMlXPlIR1DwVehcve+R1rRrQpOgVdk2cdXR3jdwLG1AA2i4yjkG2gD4cBPHOEUhIVVuL2M6Xv
 EqoDumP5BUoeK1L0+zaZBBnqVPx6dFHOTaV9DXIeD7HvLhHxgmNdBlreBj62eCfI/laL1k9wSpG
 IJ+hrPDEiEeSr6XyFTuHLiG3vD3uIXfdYN+LcWoaNQ5uTp76+ouzQczzIy7yfvuIhNSLmCez62U
 8zZhvMiVEkHCrh1lHXoeOa6CQ4WXxMJGmZ5pqixE/stAW+XjLLlUYx16QpBy8A9tc0idDysNp1f
 t/29p8ByvPeJINTr2M6x62RuaLgV5ozLE4QMlPe5YSlAp+U4fGEVsVfWejPLfxib3DkCLj5tz
X-Google-Smtp-Source: AGHT+IGMHkoSYcGSPxyYIJgyRWKk0I7FhJcDTrnjuvJYtOw0mUH55Ep4WOE3k8S8lO8onut4QFzvSA==
X-Received: by 2002:a05:6000:4308:b0:3b7:9350:d372 with SMTP id
 ffacd0b85a97d-3b900b4e1c5mr16541044f8f.24.1755007462448; 
 Tue, 12 Aug 2025 07:04:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5843021sm323838745e9.3.2025.08.12.07.04.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Aug 2025 07:04:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH-for-10.1 RESEND RESEND v2 1/3] hw/sd/ssi-sd: Return noise
 (dummy byte) when no card connected
Date: Tue, 12 Aug 2025 16:04:13 +0200
Message-ID: <20250812140415.70153-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812140415.70153-1-philmd@linaro.org>
References: <20250812140415.70153-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Commit 1585ab9f1ba ("hw/sd/sdcard: Fill SPI response bits in card
code") exposed a bug in the SPI adapter: if no SD card is plugged,
we are returning "there is a card with an error". This is wrong,
we shouldn't return any particular packet response, but the noise
shifted on the MISO line. Return the dummy byte, otherwise we get:

  qemu-system-riscv64: ../hw/sd/ssi-sd.c:160: ssi_sd_transfer: Assertion `s->arglen > 0' failed.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 775616c3ae8 ("Partial SD card SPI mode support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/sd/ssi-sd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index 594dead19ee..3aacbd03871 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -89,6 +89,10 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev, uint32_t val)
     SDRequest request;
     uint8_t longresp[5];
 
+    if (!sdbus_get_inserted(&s->sdbus)) {
+        return SSI_DUMMY;
+    }
+
     /*
      * Special case: allow CMD12 (STOP TRANSMISSION) while reading data.
      *
-- 
2.49.0


