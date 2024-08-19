Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2814C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 22:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgBG7-00078Q-CO; Mon, 19 Aug 2024 18:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBEx-000265-7a
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:52:45 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBEu-0000nl-82
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:52:41 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37196229343so2253264f8f.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 15:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724107957; x=1724712757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z09RW6IFcneNIVHjMWauhlzcbq2Ve54pkQqfOcA3PEg=;
 b=ElViYo1jGB/IydxtVP/35FT7U3FFTpX/428tiEaJLxqRZB4tTZ9WeRMPX7Swu2jFfr
 XqtvjTHtMIm5IWyj7R8+2K0Kj7ith2tYYEdP7z9WMlSgnHfS1si+XRj7yaEoZ8hFxfUE
 w8dPyabSsTVef0ENlT5J8FSC1QRPbI9B7MMZMfnVqx13nmdzaCuJEgM7pAqfCxO2HDKT
 P6hDyGUq9TKz69gpr6afpbybBZwqZ9ifp99CcUlTrXsrHLGHdknIX6IYtQdadR7xhOgy
 KNnObPjIybEAPDLqnfxRtsV92RRIW3r720Sg6ppBvu+UdULVKBzx8n5Gye+NDBFR8yax
 thoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724107957; x=1724712757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z09RW6IFcneNIVHjMWauhlzcbq2Ve54pkQqfOcA3PEg=;
 b=Edwg6IiexN59XPFobe0lvy3Krq2BrMt1/e4mzCoS4JzOULCdcVfl9h9xk0k8Py0Wtb
 HSFhN4UtCLTZaeUHRxlNAfHB5KUv0xvd4ZdLnU5FL6vGl6xHJflPDsf2Yvrhpoa3F20M
 km8YOn/pFM/eb5QKoyN+iesBWvCcq5iKdeOCLocEJ2Ojb26I7QfceE0Hvxx3w5XfOVQG
 ZcSjDgkFo9KaDIFB8tO6OyJyvNWr56CZuVHujI1TWO1hxOxZzYyGDNt9aHxBmL3/P/jY
 tTLt+t+JNS12cDBdNSR3kZRF50tAmOjxoJCxo0U6Ymp53DEaBE3xLnnbE5aJihv0dTzp
 5fwA==
X-Gm-Message-State: AOJu0YxhExjoiMrzyL0NEecQiU/nQUPGIA3BqM4j3vvVLq2Vq+vo5jAf
 Vn1+SnglESO1Ic9MoOX5Yj9szvx4NOA/I9U/9DTpXSmvkCP0L7LSub1QmJnGUCEsjOJEdoiLhHq
 gA3s=
X-Google-Smtp-Source: AGHT+IFppZc2C2k0jzdRIXeMYR2BrPwxSECWzKO6v6Mvlb+8GJrm4Spb218TdNBcu+z6fuTLjTe1qw==
X-Received: by 2002:adf:9785:0:b0:371:8e67:7a90 with SMTP id
 ffacd0b85a97d-371946a4f3emr7195327f8f.49.1724107957546; 
 Mon, 19 Aug 2024 15:52:37 -0700 (PDT)
Received: from localhost.localdomain (88-178-97-237.subs.proxad.net.
 [88.178.97.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37189849831sm11585295f8f.30.2024.08.19.15.52.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Aug 2024 15:52:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/20] hw/ppc/Kconfig: Add missing SERIAL_ISA dependency to
 POWERNV machine
Date: Tue, 20 Aug 2024 00:51:13 +0200
Message-ID: <20240819225116.17928-18-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819225116.17928-1-philmd@linaro.org>
References: <20240819225116.17928-1-philmd@linaro.org>
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

From: Bernhard Beschow <shentey@gmail.com>

The machine calls serial_hds_isa_init() which is provided by serial-isa.c,
guarded by SERIAL_ISA.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240814181534.218964-4-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index c235519881..5addad1124 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -39,6 +39,7 @@ config POWERNV
     select PCI_POWERNV
     select PCA9552
     select PCA9554
+    select SERIAL_ISA
     select SSI
     select SSI_M25P80
     select PNV_SPI
-- 
2.45.2


