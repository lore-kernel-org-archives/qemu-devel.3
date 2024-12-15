Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AE8E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMu2D-0006iY-CJ; Sun, 15 Dec 2024 14:12:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMu00-00036R-PS
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:52 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzy-0001X6-Vk
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:52 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3eb87127854so1013417b6e.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289790; x=1734894590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+3W25tZKNwolMqrRntpySrnz7X/bER0nM1ryiF0CDU=;
 b=sXyBl4OXN1GEBETDWUbJg63TwV863b96gNJ1WuU2XZM6VSG8EueIrNvp6NT2v2zwlU
 Tylgxnj7p0xzRndMkXdyelZS8xAoPjh+P/GvZdfx9XRsR+AgC8tNZRUZDsQhUfjwBVH6
 TWGG/ETUY4hgiYNsKuiVo9+w+t6c8EGkOPQz6TK9UfWmLbl0QVY+N+itfD4jCmP0gWbO
 qCh62FsfvStvTzgT99oaRblh0r5wEpAh4ePW2KQR3oQRWDtQoJJ9sklnUA7J/cgfOq7p
 ZhcZaed1sP8TVosz2/301TDtFZDTNqL1na6FCa1b9K35R9sUdk8F0BMs3jh7F9247iko
 iFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289790; x=1734894590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T+3W25tZKNwolMqrRntpySrnz7X/bER0nM1ryiF0CDU=;
 b=X48V3iMW2W9QY4vsUKJLQTlGGT/aNHaAGnX/hrHTDI1ask1dvGJeptJWKqqdrL1I0G
 E1EnxFu7wtbGa7HULPQxUIyZltYXL6ZNCJBiTBWJUK/OK7C7BqLQgrbTDveo4jMkydAd
 owxGkEE6D0M8Nh07vAxW/F+/3sbde9B+kk9yP3DaofurzxcD7caLrjCYQdoXrqckB8eC
 cMPM6FneSLAN92lBZpzmnj/z+GjhERg16PyNsFu0MuPRqPed0b0dIQN7q4Saa8Hwds3U
 nxjQavcciiPSjsaAcQQmUnlvdrVCorKizkhPimWAA6QIM8nl4pcoHYLmfDXVzNlvDBKi
 eFmA==
X-Gm-Message-State: AOJu0YxMkUpSwJYD5rm+68IuprAu/PZqKNRVF4mZYlYssGTuGT8pIqqf
 FhyMxaSrWMnFksW28QllMvzFQVpQKiTNOjR+w0pRWJSMqlToTEwXX6xqp4NQf+6ucy5nvG6pFwX
 7/5h5ZLrl
X-Gm-Gg: ASbGncu8GmWNq2oa4yb8xY7Wt3yjdWiTqOWJunClJXdguBCqi89Q6WKOVWDeRyW/7tb
 Lf5fToqhd+ltAfIrsneAeOdJuD9asnXAyd4aaIYCiQF4cxFEI5MirJ5tuK2TPjvO/mHiRyYJQdK
 qHQmJzuKJYfQ8D1sqeKar4+TRAD/Rz1q7nRIw3zlpyUMod0hk5/qVwPhSudGrdO76y9btVW38DC
 0/HjgKZGQU2rqOw4PMF+YZ3yrcEzMphnYbgqPVABrCGT1v+Rk1oQmVHxBlSq+xdzA39/AFMxRmU
 gBN98FfbMdevad6tNz0HA3/X2u55xIlZVOg2cIi5L2k=
X-Google-Smtp-Source: AGHT+IGRiW/Q6i7yKbN+vXMB91OfkL8UutJ6oICtS95s8+jHsz7GV9WUGlXmomNLrZ4uDIBF0xycWw==
X-Received: by 2002:a9d:3e51:0:b0:71e:57b5:224a with SMTP id
 46e09a7af769-71e57b523b8mr2184611a34.11.1734289789851; 
 Sun, 15 Dec 2024 11:09:49 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:09:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 56/67] hw/sparc64: Constify all Property
Date: Sun, 15 Dec 2024 13:05:22 -0600
Message-ID: <20241215190533.3222854-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/sparc64/sun4u.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 541c7f74fa..7088ac273e 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -374,7 +374,7 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
     pci_register_bar(pci_dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->bar1);
 }
 
-static Property ebus_properties[] = {
+static const Property ebus_properties[] = {
     DEFINE_PROP_UINT64("console-serial-base", EbusState,
                        console_serial_base, 0),
     DEFINE_PROP_END_OF_LIST(),
@@ -532,7 +532,7 @@ static void ram_init(hwaddr addr, ram_addr_t RAM_size)
     sysbus_mmio_map(s, 0, addr);
 }
 
-static Property ram_properties[] = {
+static const Property ram_properties[] = {
     DEFINE_PROP_UINT64("size", RamDevice, size, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0


