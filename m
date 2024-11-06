Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E445D59F62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 18:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8l33-0008Q0-Cf; Wed, 06 Nov 2024 13:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8l2y-0008NV-VU
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:46:29 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8l2x-0000v9-FD
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:46:28 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9ed0ec0e92so9457266b.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 10:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730918785; x=1731523585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iNstnbcurcwe9tiYawZfa8Zi088/DUlHFBmK9/a+8zY=;
 b=Jjv83wV1lY6IO/4e/sk0GXNxwM4LdIwlGSTgZ1/swRoAAgf584+dX3N2gSqYt0emYr
 3cSj6usG7IVGx0yi2VFpbehF2IDJ46/b4SnfeElM7a03Bf32w/MoRifiFgCGv+MZrvR4
 gFRJG3fT+mL2BZPlAmB+1m4QY0z3fcN3FRg2T0ng5KgO10HJbc5YUQuBjEj7v85wecSx
 MBbEKJgYjjk3bcyl+yUyZwbw9C1Xwm0xiKThFPaJve/EjW8HGfhlU8JDCwQQ2tInVpsK
 XUS4vCZRHgU2s6oCd1HpKyJHnBmCDXhyo6pH7qOJeRkLm4efT7Aqfw9srFExGI5AN+vo
 CFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730918785; x=1731523585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iNstnbcurcwe9tiYawZfa8Zi088/DUlHFBmK9/a+8zY=;
 b=V0ZQMTS6VbFX/UNNp0RPm93A1saPNk9afj9XaVDrT0XYWxoyHWX/pk1LwpaujJcYM0
 T86B3yVDqSVVDr6vN5w58K5XaeLPKhxM6RdgOBVup3Jy3egLXvDwFOb3x8Khtb2eCjwy
 8Ock7hWBbUwqH7NqD+bVG95scnOSrYcfiQqZJ54LSD2RKVrG5dNmwUt56gnQjUomTAnh
 yjj4D8Kxr2QZaFmn9miPkMPWE7ObIvl0xAjxa2Qp4pFlaBEE5O3GAmSMtdZqhQwm7XNo
 NtpJGJ6fIVE2MOY0Hr79qyxCwZK/9RqiE+i0sduTJ8GEe4yQaI6MQXoxaCsnt51yqNUy
 IdCA==
X-Gm-Message-State: AOJu0YzptxToQG3zfyuZDFB0lwTMSDpF4BysNC6cbAfnKnIUNg7k3yeL
 ZZKmypkkyO0HDsVdu/d7U42N53JZ2ioLp5F/6bPo6xiTDaTcVImxFA6gfwbTpSaOrtCeZr2sWoz
 D
X-Google-Smtp-Source: AGHT+IGjArD1IMYMRr0Wdsufa3Pz3wV1Bnd8QpL2R9nInPp4yr8/a39mB/pkO2WyFWxS76ZZlJR3WQ==
X-Received: by 2002:a17:907:94cb:b0:a9a:835b:fc77 with SMTP id
 a640c23a62f3a-a9e6549106bmr2239257766b.8.1730918785638; 
 Wed, 06 Nov 2024 10:46:25 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb16d9f96sm318040866b.75.2024.11.06.10.46.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 Nov 2024 10:46:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Anthony PERARD <anthony@xenproject.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <huth@tuxfamily.org>,
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Paul Durrant <paul@xen.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/5] hw/tricore: Mark devices as little-endian
Date: Wed,  6 Nov 2024 18:46:09 +0000
Message-ID: <20241106184612.71897-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241106184612.71897-1-philmd@linaro.org>
References: <20241106184612.71897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

These devices are only used by the TriCore target, which is
only built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
definition expand to DEVICE_LITTLE_ENDIAN (besides, the
DEVICE_BIG_ENDIAN case isn't tested). Simplify directly using
DEVICE_LITTLE_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/tricore/tricore_testdevice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/tricore/tricore_testdevice.c b/hw/tricore/tricore_testdevice.c
index ae95c49565..169f5907e9 100644
--- a/hw/tricore/tricore_testdevice.c
+++ b/hw/tricore/tricore_testdevice.c
@@ -47,7 +47,7 @@ static const MemoryRegionOps tricore_testdevice_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void tricore_testdevice_init(Object *obj)
-- 
2.45.2


