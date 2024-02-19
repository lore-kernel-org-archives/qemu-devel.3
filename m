Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B380C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6ff-0001Hw-QO; Mon, 19 Feb 2024 11:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6fe-0001Hb-CW
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:39:10 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6fc-0002v4-PK
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:39:10 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41261233e61so8603045e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 08:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708360747; x=1708965547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7g5vOQ8eZi29yIHTGoT9HD5BPvRL3ou+PdzCGqII3v4=;
 b=hsZFgLCoKCha+7NLdqzfzboAIKu1uU3YjkXWtKEKoW3f6NtLi4vT+318mEqcQoxdsH
 RihQlZXdYwmrQi1+rPrEjVHGpS2YocHcGF/IBo1N/bIZ5k0Voa60EJG43kctXMCuNvyG
 f1Y0u2D9nGbmNTWRekWTwEgOtbZIwbAZaVoMx9bva3XQJuuVR5Zw5KhvIYLokTZ1+9DA
 EVIJBVnjCB1bozfgD+Tu68oDIAWnvBttvUkVXq+TbxHSxFU1x7kva4Rcs3xgvfMx7YBZ
 aKWDjCPgi3v5x6b89IxRiP77IWofVpxliJo8ZgfzmA1388bZAFdLUpMpfEFG7JMrcZiv
 WZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708360747; x=1708965547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7g5vOQ8eZi29yIHTGoT9HD5BPvRL3ou+PdzCGqII3v4=;
 b=j7V1hHCTJLtNbzNkK7oI4rOvdxo10PmFKkHvmBqcI27wt07YXfDRH2I3bU3fPLTTZ5
 I287YdpURCG5PZ5BPAadK0grGI4kNlUCkc13C+8Y9VN0uAdipkJL7vWS9I+2ynVHRdNw
 PmI+voYF325CDiEh4LzU6I/LwMbwSbTFp5GnMPuazqqFmZTEYHNa93hj4R3HzzXfcRWZ
 VyiiK1wLCGUbs+YULdf9wXq8gD2IrOMMC/Fh5uI2JVmor+rCvtDW2WGgKy3cVumy5VpX
 /oomGbPleXG0VpBJY6Ais93wDev8n9EK9CXEyuEQhEMaxsxdPAzX7ytsM3DfIQXZ9WH3
 u6dA==
X-Gm-Message-State: AOJu0YzWuTwDZyE2dRHVGvkJz20G0zrg/t9QFsK7Olt6moOrp3q1dsq7
 WH2bgvoMQDF37AsnjJPzxGz8Bt7CXJjmIvao5tbqFQrVCl3qSHHv8chOsKxm97UlMf2EUVUBa5d
 D
X-Google-Smtp-Source: AGHT+IFEHVbo0ZTve0Om+MWqi2oyIteATw2Q/vh5PwapV6cPIM6DzJ215BvljaGRr5vahVLIl2XPnQ==
X-Received: by 2002:a05:600c:19c7:b0:412:5296:9737 with SMTP id
 u7-20020a05600c19c700b0041252969737mr8340793wmq.12.1708360746815; 
 Mon, 19 Feb 2024 08:39:06 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 s6-20020a05600c45c600b00412696bd7d9sm1956339wmo.41.2024.02.19.08.39.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Feb 2024 08:39:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bernhard Beschow <shentey@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/14] MAINTAINERS: Add 'ICH9 South Bridge' section
Date: Mon, 19 Feb 2024 17:38:41 +0100
Message-ID: <20240219163855.87326-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240219163855.87326-1-philmd@linaro.org>
References: <20240219163855.87326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Extract 'ICH9 South Bridge' from the 'PC' section.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d61fb9319..1b210c5cc1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1808,12 +1808,7 @@ F: include/hw/pci-host/i440fx.h
 F: include/hw/pci-host/q35.h
 F: include/hw/pci-host/pam.h
 F: hw/isa/piix.c
-F: hw/isa/lpc_ich9.c
-F: hw/i2c/smbus_ich9.c
 F: hw/acpi/piix4.c
-F: hw/acpi/ich9*.c
-F: include/hw/acpi/ich9*.h
-F: include/hw/southbridge/ich9.h
 F: include/hw/southbridge/piix.h
 F: hw/isa/apm.c
 F: include/hw/isa/apm.h
@@ -2606,6 +2601,16 @@ F: hw/display/edid*
 F: include/hw/display/edid.h
 F: qemu-edid.c
 
+ICH9 South Bridge (82801i)
+M: Michael S. Tsirkin <mst@redhat.com>
+M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
+S: Supported
+F: hw/acpi/ich9*.c
+F: hw/i2c/smbus_ich9.c
+F: hw/isa/lpc_ich9.c
+F: include/hw/acpi/ich9*.h
+F: include/hw/southbridge/ich9.h
+
 PIIX4 South Bridge (i82371AB)
 M: Hervé Poussineau <hpoussin@reactos.org>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
-- 
2.41.0


