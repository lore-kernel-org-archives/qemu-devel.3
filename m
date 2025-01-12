Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25325E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6Ha-0007WF-3n; Sun, 12 Jan 2025 17:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6HO-0007Tb-7x
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:03 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6HI-0006Og-Sj
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:17:57 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so38315945e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720262; x=1737325062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RRilqG0RRzc/tLS+/K4TJ6YsxHq+JDiiCxUzzS2N1LY=;
 b=EnrmkeWV5hicqQ7cryUySmTtzA3tNMH5s2rA4H0k7O/qtWG8/b6S/zGDQqy5yXr9AX
 IFFJ5VzV4JceEYbWLVOCMMp1zWhvGj0sLWaPP2bHY9Cdm5y4v4RSNzZg8Gw/kDFERAyM
 NhinP/QmQp4PMbDyaSUw9jZJ4PUWUFRa+ItWUv9fAw04kqU3OO0v+iTScHrS+Mnxd2gz
 MwaH0bo07jhBBRswj2LCDcb62S8MIHUPpzFkpxy33rht5Gzb08BnMYul8gK2p47PQ22q
 5a4ZH6AFTOxX2fRosxgAmqp3wl4T4cyLxnmxlcnymrVZ+U1OAWhF6qLLbxaBNnGsBxuI
 2uRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720262; x=1737325062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RRilqG0RRzc/tLS+/K4TJ6YsxHq+JDiiCxUzzS2N1LY=;
 b=sW6pP4SUbqAO0v//6UTO3U3jKlysuOueP/QvF8hXG9rb6ZJMuCgPmqRbtRbXJqg1L4
 AeCU8j79d2zKNwRjr/+sdgVPH0CmHTsB7VpQVVW5cETtk+zFi3vLE47RFGD+5ShuBiC9
 /XzU7XbEmTatM1GTLAiu0gVGE8BQBtVNg6NxeKYI/UTBoKgFsNTCR8CDJzKadrsOwaoB
 FYlioYxEoXmV1HffzRjhtgc+wnsTa/QOmP86sqtl/YSPl84doj+5pH0Zr1/nqbRa3YF8
 hU44aW/dVU5t7Fl45OP/1JR3mQtTTFXtYut53ds20k6emSY4Ane1geXmYuIuMnQeLu2K
 4zsQ==
X-Gm-Message-State: AOJu0YwL8b5JGZVdsfDXvJv1rYpycaykHm2LYCLg4TXBUcINRfjgNAc4
 Pk4/f5wCJ+iB0uk6CfvieNYnmgFjv08oKBp+eiMV3e4D24isj2qIZ9AfC10DCbkaKrB7iykBOdn
 MNwc=
X-Gm-Gg: ASbGncuINjcj7zcuOblwhpUWEykZ3XhVujcgLWjNunTHmnTQ54sL959xmDSgTauX5I7
 WOYakCzhrXmXJWta6EtjVnXsNza0jDkmYBgXyNMxN31goHVa+SuK2FF9W7IRT7KmdchZ6XkOk5K
 N89fGf1xf+XHaU0w2C3mP11K/8nrF7pptQLFeUJ7GbKOcFF4Fd41B3jGEjpulTITHiIDhieL7Ph
 tlhCVbSQlm0bsFKxEP1H9NVHySiVhhVB5t01n3Wn4JW5funDPVp2Lok7JAyc67u70AyP4bEDwyd
 ey0n8hwBKia6A7YvJCBsq57gmuQUgTY=
X-Google-Smtp-Source: AGHT+IH9TOWJZadiSEpDlZJ8zL8X2L7kGUhzzDP97Vk2L1eK8rCqJyX/67bM6O9HGa4i0ukOX74e/w==
X-Received: by 2002:a05:600c:3ca4:b0:434:a26c:8291 with SMTP id
 5b1f17b1804b1-436e26e203emr147457395e9.24.1736720262574; 
 Sun, 12 Jan 2025 14:17:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9dc895esm122279135e9.13.2025.01.12.14.17.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:17:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 03/49] hw: Replace DEVICE(object_new) -> qdev_new()
Date: Sun, 12 Jan 2025 23:16:39 +0100
Message-ID: <20250112221726.30206-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
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

Prefer QDev API for QDev objects, avoid the underlying QOM layer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20240216110313.17039-7-philmd@linaro.org>
---
 hw/arm/musicpal.c | 2 +-
 hw/sparc/sun4m.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index a712ff954bd..48a32c24079 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1238,7 +1238,7 @@ static void musicpal_init(MachineState *machine)
                           qdev_get_gpio_in(pic, MP_TIMER4_IRQ), NULL);
 
     /* Logically OR both UART IRQs together */
-    uart_orgate = DEVICE(object_new(TYPE_OR_IRQ));
+    uart_orgate = qdev_new(TYPE_OR_IRQ);
     object_property_set_int(OBJECT(uart_orgate), "num-lines", 2, &error_fatal);
     qdev_realize_and_unref(uart_orgate, NULL, &error_fatal);
     qdev_connect_gpio_out(uart_orgate, 0,
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 217a69e4d5d..e070360a2c7 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -974,7 +974,7 @@ static void sun4m_hw_init(MachineState *machine)
     sysbus_mmio_map(s, 0, hwdef->ms_kb_base);
 
     /* Logically OR both its IRQs together */
-    ms_kb_orgate = DEVICE(object_new(TYPE_OR_IRQ));
+    ms_kb_orgate = qdev_new(TYPE_OR_IRQ);
     object_property_set_int(OBJECT(ms_kb_orgate), "num-lines", 2, &error_fatal);
     qdev_realize_and_unref(ms_kb_orgate, NULL, &error_fatal);
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(ms_kb_orgate, 0));
@@ -995,7 +995,7 @@ static void sun4m_hw_init(MachineState *machine)
     sysbus_mmio_map(s, 0, hwdef->serial_base);
 
     /* Logically OR both its IRQs together */
-    serial_orgate = DEVICE(object_new(TYPE_OR_IRQ));
+    serial_orgate = qdev_new(TYPE_OR_IRQ);
     object_property_set_int(OBJECT(serial_orgate), "num-lines", 2,
                             &error_fatal);
     qdev_realize_and_unref(serial_orgate, NULL, &error_fatal);
-- 
2.47.1


