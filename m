Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8E1C02193
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZFI-0001za-B8; Thu, 30 Jan 2025 13:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdZEW-0001J1-MB
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:25:46 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdZEU-00017X-Rc
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:25:44 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso1197750f8f.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261541; x=1738866341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZk0oTGxDURxLqCpPV0Zd69bGvF/XaBnOTd5i1RlcsU=;
 b=D2ttSnEmww329jc93cCX7Loc3QveFlpRjHa49/XByX5SKh5Aa8ydJXM9anAxKPNEdT
 hKOz+JVXlkddkGpV2OwUx7a/iiUnt6KT4jgOfsIGxQeitAbqVCtSYgng4m8EH7GaqdkF
 odTzSA8Sy5bfebp7VjlL3WIm2kT4cpsk7YtGpKRoFu1UPRK4pHkmPRrnBAhgeOfL+blg
 uynTuvjQLx+wxHFmskadigoEfcgxKAoF9VOebAD+fUpHk2cLK7TKv9FKJD3dYxplCJvt
 tsqEBL0OjQIsP0PlsKOR/4A9uRUTR8Ul5T1vLawhxSjBoJTXj+dhOzTQyEclpfHwA+xE
 PP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261541; x=1738866341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vZk0oTGxDURxLqCpPV0Zd69bGvF/XaBnOTd5i1RlcsU=;
 b=qSEzUDtyRihVdJXaXZCpuL/dEK3fzEzRKU4aOUXchBpUAWm0I3usoPcN+ewrCr6aTZ
 jJEV49ZLqeAFAcc5tzfCdyT4C3PX3fXdsHoCcTpiEeJYktHNT+Cbb3b1vn329oTjOGKJ
 Rhj53U5QI5vkKliBLqRKp9ZMZ4pdB0wvNtRLjS5rIFyDosjgIUu/erE6ggYL59gJdNXQ
 0C1crQQbHqbiHuVKTZ9z4GTXYPrEiJf8PZ1DMolEuPtbEMTvMWMH9EsGnS8kyYKA1/at
 h+/8XRYzoe/vDUDRXzPs5jDLQxQFsTTDvk+EATBTVJU/Kd3A9TFQzPhpsUPeUf7xMUdW
 XZjw==
X-Gm-Message-State: AOJu0Yyg+NqNt6gfJ3rTEYuminST0AWwcfRXz1Se3yJRZbvFKaURQVwX
 7h+phY139a6hZ9je760oZmrXVZJuHIpNxO+2FuauWwp1pbfAUPtIt9YDGMr/0gum3o6M+NeLYTo
 iO20=
X-Gm-Gg: ASbGnctbavI1SWSNm6ZK2Z+EoJ467la5G8y9pijFWf6v9XJxCa1NF6Ozp8xSbEX/Qph
 pPi8HbqifZjfd4Jnt+JHM4DEmSljnvqdUt0Dx8+CA9LWI42/Pw2J6i4cbQQdkVbj6mpFeGbUqJo
 hZC8cseRMDvUrlVvD3zx3wKy5ESiwsEuwovbHc3TW7f6djLloo/go8mFA+eebArAOrDLAyj8Qob
 SS6fq9v+ZlBMbCFi3Gi6BMoSMOwfhz9KQm5lmlSI/yZfOcdaR4AKMQrKtLOY05qnZD89XhDMWQ2
 Jxorbbv6ueGYQF7I+ik0ew8cHVjQ0Zh12Wp/pRsJIacqCuJXng9L1PqyNJ2iSsrdwQ==
X-Google-Smtp-Source: AGHT+IGfE188vZLMhP5pd6SCSIhGlCHXFdgRfnECKuHFzu88TvKH4QJ5gl/qySXuELw6dDYw7rXiHQ==
X-Received: by 2002:a5d:4f90:0:b0:385:ee3f:5cbf with SMTP id
 ffacd0b85a97d-38c519526edmr6505846f8f.20.1738261540837; 
 Thu, 30 Jan 2025 10:25:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1b5780sm2721855f8f.67.2025.01.30.10.25.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 Jan 2025 10:25:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/8] hw/arm/exynos4210: Explicit number of GIC external IRQs
Date: Thu, 30 Jan 2025 19:24:35 +0100
Message-ID: <20250130182441.40480-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250130182441.40480-1-philmd@linaro.org>
References: <20250130182441.40480-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

When not specified, Cortex-A9MP configures its GIC with 64 external
IRQs (see commit a32134aad89 "arm:make the number of GIC interrupts
configurable"). Add the GIC_EXT_IRQS definition (with a comment)
to make that explicit.

Except explicitly setting a property value to its same implicit
value, there is no logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/exynos4210.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 99b05a175d6..75d6e4d1ab9 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -103,6 +103,14 @@
 #define EXYNOS4210_PL330_BASE1_ADDR         0x12690000
 #define EXYNOS4210_PL330_BASE2_ADDR         0x12850000
 
+/*
+ * The Cortex-A9MP may have anything from 0 to 224 external interrupt
+ * IRQ lines (with another 32 internal). We default to 64+32, which
+ * is the number provided by the Cortex-A9MP test chip in the
+ * Realview PBX-A9 and Versatile Express A9 development boards.
+ */
+#define GIC_EXT_IRQS 64
+
 enum ExtGicId {
     EXT_GIC_ID_MDMA_LCD0 = 66,
     EXT_GIC_ID_PDMA0,
@@ -588,6 +596,8 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
 
     /* Private memory region and Internal GIC */
     qdev_prop_set_uint32(DEVICE(&s->a9mpcore), "num-cpu", EXYNOS4210_NCPUS);
+    qdev_prop_set_uint32(DEVICE(&s->a9mpcore), "num-irq",
+                         GIC_EXT_IRQS + GIC_INTERNAL);
     busdev = SYS_BUS_DEVICE(&s->a9mpcore);
     sysbus_realize(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, EXYNOS4210_SMP_PRIVATE_BASE_ADDR);
-- 
2.47.1


