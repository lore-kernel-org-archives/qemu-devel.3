Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CD2C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMIu-0006q8-7R; Tue, 23 Jul 2024 16:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMIf-00063G-Tg
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:39:59 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMIe-00041A-Ad
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:39:57 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-368663d7f80so3241745f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767194; x=1722371994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+hMaqq/BTdi6PrKr3cYrZxRyWg7HqfkCm9irnu5mKRU=;
 b=e8dv81d4GETIhKjz02U2Qj/VXej0lWG70HkJKws/gKIh0vBvftL2e5b09BHrbbXUES
 ZFzDakkLq0gHU06/zRYtTh18StG8M+2fEe9KUPnfXEom2USB+is5iTmXVyh16tKT8UG1
 OHuU5JA1DUV083gWW+wYUwK7MwBQknVWU2QY8aYYdvc50aoh5MFgwXEDoy/xnZHDTKTJ
 I0hshvtRiZTOGSF05wzUffeH94si7mOfBfSnyCxj7ldy7Zdr6DwyMBzIa5GnOBhHtu2P
 QFxy/aOgxeRZawzCr9fFfp2+p/7CGMwmj4vcJEVBAUmFk+BVFaOpHPQ5DUk2T86eeiGm
 ihjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767194; x=1722371994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+hMaqq/BTdi6PrKr3cYrZxRyWg7HqfkCm9irnu5mKRU=;
 b=kpnZQaBcGTiFIjahmsbi5Y/Sjr/hB2ycjy+8IEGTPtAonJeB3RJNa7J2KBIvVchnJC
 jS1COoo7v0P2QlTiGtt9sSp/jimnIvxV8IdfjvMoIBlwd6rdSHKm3TGVf00kO1kpWNSf
 5hHdGYTsteXAKvfsc6osgOwWc5W/yrhK3NXuf2l2Ip0mDqp3jIvNBq1RgfDpTZgB+FCP
 i6NXRiXvJK0WeKicC2nFuh9mbncmCh9PO8pV5cBFtoQ20zZel/HqbcZsHOTu0IIW0nPa
 H7hTG7xDJQl4J/UbUwCRxfZsUVZ/vDcxuSxm+TTWdCjTMxlG9qSd98r9bhlSm0X1US7B
 435Q==
X-Gm-Message-State: AOJu0YzqjkX2xv/QUYLoEnvV4Bnl2vtaidbHIgr9PFl7aGNpSdS2k2Zb
 5pDABIcF9xvij++9heuRxWJfCIXP6HWnPyIurqNPqeR+opNsuzCnLqO49FkdT5JYjdmnBms5Zgi
 DZMs=
X-Google-Smtp-Source: AGHT+IG57LI5YWyZHVY+kl90wAv5lE9l7oJ9B0qwyRPR4wxUqd35iJDfJuVsGFBnhz88AsrCOTWPBg==
X-Received: by 2002:a05:6000:d85:b0:368:66b7:621d with SMTP id
 ffacd0b85a97d-369f5b2c80fmr38100f8f.18.1721767194455; 
 Tue, 23 Jul 2024 13:39:54 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878694833sm12408147f8f.55.2024.07.23.13.39.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:39:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/28] hw/i2c/mpc_i2c: Fix mmio region size
Date: Tue, 23 Jul 2024 22:38:37 +0200
Message-ID: <20240723203855.65033-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The last register of this device is at offset 0x14 occupying 8 bits so
to cover it the mmio region needs to be 0x15 bytes long. Also correct
the name of the field storing this register value to match the
register name.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Fixes: 7abb479c7a ("PPC: E500: Add FSL I2C controller")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240721225506.B32704E6039@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i2c/mpc_i2c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
index cb051a520f7..06d4ce7d68d 100644
--- a/hw/i2c/mpc_i2c.c
+++ b/hw/i2c/mpc_i2c.c
@@ -82,7 +82,7 @@ struct MPCI2CState {
     uint8_t cr;
     uint8_t sr;
     uint8_t dr;
-    uint8_t dfssr;
+    uint8_t dfsrr;
 };
 
 static bool mpc_i2c_is_enabled(MPCI2CState *s)
@@ -293,7 +293,7 @@ static void mpc_i2c_write(void *opaque, hwaddr addr,
         }
         break;
     case MPC_I2C_DFSRR:
-        s->dfssr = value;
+        s->dfsrr = value;
         break;
     default:
         DPRINTF("ERROR: Bad write addr 0x%x\n", (unsigned int)addr);
@@ -319,7 +319,7 @@ static const VMStateDescription mpc_i2c_vmstate = {
         VMSTATE_UINT8(cr, MPCI2CState),
         VMSTATE_UINT8(sr, MPCI2CState),
         VMSTATE_UINT8(dr, MPCI2CState),
-        VMSTATE_UINT8(dfssr, MPCI2CState),
+        VMSTATE_UINT8(dfsrr, MPCI2CState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -329,7 +329,7 @@ static void mpc_i2c_realize(DeviceState *dev, Error **errp)
     MPCI2CState  *i2c = MPC_I2C(dev);
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &i2c->irq);
     memory_region_init_io(&i2c->iomem, OBJECT(i2c), &i2c_ops, i2c,
-                          "mpc-i2c", 0x14);
+                          "mpc-i2c", 0x15);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &i2c->iomem);
     i2c->bus = i2c_init_bus(dev, "i2c");
 }
-- 
2.41.0


