Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB92C28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 00:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trQfn-0002AY-F3; Sun, 09 Mar 2025 20:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQfi-00028W-Nf
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:07:07 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQff-0007OF-VJ
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:07:06 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43bc63876f1so31288705e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 17:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741565222; x=1742170022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nrSyjlqQLxIdz5EnxNr6LHBBkoV7ANv7WOr2ucCNGYM=;
 b=io3IZVhJOyKBeVHK9/jJU+7iU6yvP9QrIxS+r43oHKyQ43BIA1aSsDnuJVO9pivJDQ
 Vws15/9C8YmtAmGh85qKqZZAX0jqGTxiNB1qxzgcFrwo3KKW3l+P5/XIWZfLifQUqOnb
 E+hor9F/l8wcv9z9Lk1r4UU9esRGYjMvA5iQx/6JApI4uAOr3G+cKRrvr5WkPTgZepi8
 Ujxe+UvgvEEnkOnE101oJdQBBckvu11hl7LyJ5Je1Vgz7tZDXtGqxYxJ+dksIrjShOBk
 5IIdGtJdoMDZKSjVZHvTV00BocVUSu2J2wcO+J42qohaOVaGnxq5Gb9g+mDyB/iUYsnS
 d3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741565222; x=1742170022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nrSyjlqQLxIdz5EnxNr6LHBBkoV7ANv7WOr2ucCNGYM=;
 b=dJxV0IhIAO03SSSPpC1PoE4lvS+35hJn/xmUQzjOSEJqwGN6rLsrW3xnjiuC0uvNhO
 7reII7iMKLkLSQt055pGmjpnZ5+JyWBx8QNCHvZR0rNAY5lkQeSTOWs8GtI5pR9HAszC
 A3Wgky8f4xXAtFtZKEWtqIiZZMWDIrgx7NDcZ6A7fDkcrrcmaLWpQlVq4VHWt3ESuW1r
 AynkYUIxMraBQQZWDxtx1zR4024dngJiQSVgfJcAZhK+J2p9ArSWCZKjc3c+8H+EJaoO
 O0NMWXIidHdzfD53aBtXlbeyGHDYyAuyzYETYt81bfiQ1g1U4bUmOhW45MUgwsrRi1Sm
 7C+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf8bKRKzg6TdQhQYZmE2Lcx5p114/Y4PAoRmulWgTsxtbhHNtDSeR3/1/mOhbxIyPvmgJ9fwmEkWzu@nongnu.org
X-Gm-Message-State: AOJu0Yy+KmnMYKF+TM50XKWGCAe9DDNS0tMKj6KSqRJep1yikX7z9Akg
 AhO0+rDE6FqbhIJSlZvhcHCowhN17Zg1/ZSGtr+n1/UoKkaNy7FKKJzmjgonNDs=
X-Gm-Gg: ASbGncsB6kO6pfUglrVzYehOIrimNYiOrI8SSwuodCSk1+TEZUXP+jMDra/968WOjRt
 V/Pcud0XQxKShaH9EcgEXhmLoN2EgkTG7C79Z4CakvmcBZ6yMcTYCAudXBiMDWxthBBUVsxQJO9
 i3g53yrw16psiLz9b5AtdTL5aZU4tSaPWKucj+fo6YaDQoEdkDrVffvCS8uFMZkNvtQTyjkYtHM
 xmo7zkp/Q0lAXjsKvWls81Gibs9/+YQnk2M2RjQryZOf0bgq4PnCW1jZEVuPJI4dOM/c4gcE9rk
 I4z41GWFvw8M476eTP/7OjbyHTlL3xrIITgw3j75RC+6sqWSMNKF64+3NuVb3Rq30V3TSGmIdd7
 /cHQ4mIOcaZc6pZwSeVE=
X-Google-Smtp-Source: AGHT+IF858cwE1RzW5WeHVoN0/VwJuGZY/TNoX99uh/LJTh6Ystvp8OJwOp0Q4+zLVVLApqHif71Zw==
X-Received: by 2002:a05:600c:4687:b0:43c:efae:a73 with SMTP id
 5b1f17b1804b1-43cefae1393mr24142295e9.10.1741565220740; 
 Sun, 09 Mar 2025 17:07:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf7b88494sm20159685e9.0.2025.03.09.17.06.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 17:07:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>,
	qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PATCH v5 07/14] hw/sd/sdhci: Make quirks a class property
Date: Mon, 10 Mar 2025 01:06:13 +0100
Message-ID: <20250310000620.70120-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310000620.70120-1-philmd@linaro.org>
References: <20250310000620.70120-1-philmd@linaro.org>
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

Allow to enforce implementations quirks by the class.

All TYPE_IMX_USDHC instances use the quirk: move it
to the class layer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sdhci.h |  2 ++
 hw/sd/sdhci.c         | 12 +++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index c42aeab6848..ee1e7ef4b10 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -116,6 +116,8 @@ struct SDHCIClass {
         PCIDeviceClass pci_parent_class;
         SysBusDeviceClass sbd_parent_class;
     };
+
+    uint32_t quirks;
 };
 
 /*
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 176bee6b8f5..570d825d130 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1427,6 +1427,7 @@ void sdhci_initfn(SDHCIState *s)
                                    sdhci_raise_insertion_irq, s);
     s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                      sdhci_data_transfer, s);
+    s->quirks = s->sc->quirks;
 
     s->io_ops = &sdhci_mmio_le_ops;
 }
@@ -1888,7 +1889,15 @@ static void imx_usdhc_init(Object *obj)
     SDHCIState *s = SYSBUS_SDHCI(obj);
 
     s->io_ops = &usdhc_mmio_ops;
-    s->quirks = BIT(SDHCI_QUIRK_NO_BUSY_IRQ);
+}
+
+static void imx_usdhc_class_init(ObjectClass *oc, void *data)
+{
+    SDHCIClass *sc = SYSBUS_SDHCI_CLASS(oc);
+
+    sc->quirks = BIT(SDHCI_QUIRK_NO_BUSY_IRQ);
+
+    sdhci_common_class_init(oc, data);
 }
 
 /* --- qdev Samsung s3c --- */
@@ -1969,6 +1978,7 @@ static const TypeInfo sdhci_types[] = {
         .name = TYPE_IMX_USDHC,
         .parent = TYPE_SYSBUS_SDHCI,
         .instance_init = imx_usdhc_init,
+        .class_init = imx_usdhc_class_init,
     },
     {
         .name = TYPE_S3C_SDHCI,
-- 
2.47.1


