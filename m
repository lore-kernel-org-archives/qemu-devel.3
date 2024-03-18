Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180C7C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 11:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmBDm-0008BF-MF; Mon, 18 Mar 2024 07:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmBDj-00087i-Cx
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 07:31:59 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmBDh-00077S-5Q
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 07:31:59 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-512ed314881so2887667e87.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 04:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710761515; x=1711366315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SFthmmsYp+m5f9owLwx+hyTocTKSDvu4WqZSfWH+cu8=;
 b=M/kUTwkPeboXlUZublF5oMUWc/IoCL9w5+sb05yAxzdFHilC5Rs9LJdUHtkhHEgtgF
 4nFtjgh6nTMEt9MkNO+pk2pyon4wFbzjyfyscx2r6syPJBZyflZ4Zm/sYaZI5k7J2mxF
 ARIvup7v1S+3OW8YYb+QfF+ac7ICmxPUoFP0mm0OwtIX5hLOB7rso+DkgBg0bgsx00GG
 QtdsLxyJD0s1B+h0UPSOAtBfv0FV2O+ES7KOveXk8shEzTr8MDiuBXnzobK0hfRiq14w
 giTbUOEL3cU8chozV/dzeYVRSx6HsDaTvJrEfWnclYmPjohciKKyDR6F+yHUHLr4BbAP
 nriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710761515; x=1711366315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SFthmmsYp+m5f9owLwx+hyTocTKSDvu4WqZSfWH+cu8=;
 b=nm7qQ1g7q47onP0VuvxqpEad+ZxOel5FqIEQAYCLYlxVju4CpjdXuf4/J7njF1SyND
 FZj4Z/6zCg9/WmFEDJfaknACD0RJySNCHuuB7UMJuT7o5WiihF9R3doq2rgiqL4hHObc
 JZNVdlkloLUomEXjZCyWDLik8KfECa877dZ4MiRJQridRuItEwrkV9tPtWcMQoPXFbtC
 tZo9BCTvrejamUVtu8BZXPIYQ18Lu1l5Fk5V/91vtyp+K9CRDPLVrxtZq2v6bfF6W6X5
 u4NkMEfNvpCCbJZoOuwij37UjZkDYtBF8VfpX0hfLmoGao86TEYjhOzcRkQadc76LruS
 UOGw==
X-Gm-Message-State: AOJu0Yww1szOdI0fKCVzhDxd4I3VXOnT1Q5bCLdaM2oG+0etek+33Wkk
 xs82PEjqhxIOD84FNLGG4n3Glpm4nR6by8vDIcfQqFr7mNf4rjLxnJuMiCW3udTqrGuf8QYYPAY
 z
X-Google-Smtp-Source: AGHT+IFCHrUdNk0CpDc5uSQe3U4CVEm1dq2RK69dI4IRZK1XR3oim8G9ZRVa41AMLZhKA0VoYJmNWw==
X-Received: by 2002:a05:6512:2205:b0:513:e7ff:15b8 with SMTP id
 h5-20020a056512220500b00513e7ff15b8mr2758956lfu.51.1710761515074; 
 Mon, 18 Mar 2024 04:31:55 -0700 (PDT)
Received: from m1x-phil.lan (vit94-h02-176-184-29-165.dsl.sta.abo.bbox.fr.
 [176.184.29.165]) by smtp.gmail.com with ESMTPSA id
 m10-20020adffe4a000000b0033de10c9efcsm9536719wrs.114.2024.03.18.04.31.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Mar 2024 04:31:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 v2 2/3] hw/display/pxa2xx_lcd: Set rotation angle
 using qemu_console_set_rotate
Date: Mon, 18 Mar 2024 12:31:39 +0100
Message-ID: <20240318113140.88151-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240318113140.88151-1-philmd@linaro.org>
References: <20240318113140.88151-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/pxa2xx_lcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/pxa2xx_lcd.c b/hw/display/pxa2xx_lcd.c
index a9d0d981a0..7d03fa57d0 100644
--- a/hw/display/pxa2xx_lcd.c
+++ b/hw/display/pxa2xx_lcd.c
@@ -1439,6 +1439,7 @@ PXA2xxLCDState *pxa2xx_lcdc_init(MemoryRegion *sysmem,
     memory_region_add_subregion(sysmem, base, &s->iomem);
 
     s->con = graphic_console_init(NULL, 0, &pxa2xx_ops, s);
+    qemu_console_set_rotate(s->con, graphic_rotate);
 
     vmstate_register(NULL, 0, &vmstate_pxa2xx_lcdc, s);
 
-- 
2.41.0


