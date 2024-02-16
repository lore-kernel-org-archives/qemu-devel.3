Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B01C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 15:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb0Fp-0004A8-1G; Fri, 16 Feb 2024 10:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rb0Fa-00046y-8X
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:35:43 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rb0FY-0008Fd-GE
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:35:41 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a3dfb2e03e7so46946666b.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 07:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708097739; x=1708702539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FHq12xVLql3ZjDkC8k2lRJAF5RJwUJ4vzRZ5Ca5vbxw=;
 b=aGUvTxVn0CSevQHyBDA9cVw+UVglgY2WrUoRExucsmzbM/eRtrS5afWbUMOl5saiC0
 DFasHe2Rr9+TBowErSS1Z8yGmXrQD7zEolWAVbCv3u/pB6icUh03uVvzxSWYi/9GFmGb
 BP6EInDIox0XWaz7Yp+j+YWO419I9+jWTsAIS5LE6Re2hd5XbihKkBlAQot/4bQEfHbZ
 /w4luttgu7EWUA9KVsmHc9R1d8NI7mDDKcl5+XcbFZ1KVzA+ZN51Kf3bMD8okv1c4nAj
 z7aahlG9hehfiZbh8Ys/psowuFQ2tCEiLN30UMG7XBTvZ6kpbggx4yTxdig7KKvFj7aL
 +UpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708097739; x=1708702539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FHq12xVLql3ZjDkC8k2lRJAF5RJwUJ4vzRZ5Ca5vbxw=;
 b=XmMipHQvcsUOmNJ2F7F9j6PLiTvrEcr1xH6+BwlysCx5EgmCMu4uMZG9/vvS0OsOR2
 W11SCbFSU7Aeeq9W3LkK1ZXNlKDD4ulVeVif4L4KnvIti3DxUtmVSJagw1nddIi2CFts
 Rsgl1Glfq64gAH8jRyFBLtvr9xfeacHTx2JLrvw/SHHhb3/PAuNaeblhLDH8cwpNYPOD
 jwsMPyr5RU+pM35jjsb7olRX2TPaVy3SFUJb3t6H8iCbO4jCY+6o3GZglBKGoCLRSpt1
 ZqbZOBogEh5h6t0jJ0lwZJHeY5edlE2xjOI5Ln8e+igOlXtxCHOESCTEgu7EUlB87G0X
 BA5g==
X-Gm-Message-State: AOJu0YyZDoP4RyaRNMJe9tX7tQqdltxKs7Nd3/1urhh3VFIiRzhpcoa1
 SjNxxMmvP1yJC1t3qdrxQ2J48RgVpxN0SjkH58DO9gGvD7tQya/rDlH9qHEgsc92Dbh6rlb2h9K
 N
X-Google-Smtp-Source: AGHT+IEi6meqrapeqjO4OgHfp/p6JY/NLaWMf9AKL7DDim/5nYeDiOvwjmctPUdudVyzB5T7NpBDLw==
X-Received: by 2002:a17:907:b9c6:b0:a3d:2e34:30a5 with SMTP id
 xa6-20020a170907b9c600b00a3d2e3430a5mr3626388ejc.29.1708097738898; 
 Fri, 16 Feb 2024 07:35:38 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 tl7-20020a170907c30700b00a3d1458523esm52110ejc.29.2024.02.16.07.35.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 07:35:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/6] hw/arm/exynos4210: Inline
 sysbus_create_varargs(EXYNOS4210_FIMD)
Date: Fri, 16 Feb 2024 16:35:14 +0100
Message-ID: <20240216153517.49422-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216153517.49422-1-philmd@linaro.org>
References: <20240216153517.49422-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We want to set another qdev property (a link) for the FIMD
device, we can not use sysbus_create_varargs() which only
passes sysbus base address and IRQs as arguments. Inline
it so we can set the link property in the next commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/exynos4210.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 57c77b140c..ab18836943 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -769,11 +769,13 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     }
 
     /*** Display controller (FIMD) ***/
-    sysbus_create_varargs("exynos4210.fimd", EXYNOS4210_FIMD0_BASE_ADDR,
-            s->irq_table[exynos4210_get_irq(11, 0)],
-            s->irq_table[exynos4210_get_irq(11, 1)],
-            s->irq_table[exynos4210_get_irq(11, 2)],
-            NULL);
+    dev = qdev_new("exynos4210.fimd");
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_mmio_map(busdev, 0, EXYNOS4210_FIMD0_BASE_ADDR);
+    for (n = 0; n < 3; n++) {
+        sysbus_connect_irq(busdev, n, s->irq_table[exynos4210_get_irq(11, n)]);
+    }
 
     sysbus_create_simple(TYPE_EXYNOS4210_EHCI, EXYNOS4210_EHCI_BASE_ADDR,
             s->irq_table[exynos4210_get_irq(28, 3)]);
-- 
2.41.0


