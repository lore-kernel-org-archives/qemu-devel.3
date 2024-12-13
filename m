Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C043DE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB7R-0007Sk-CC; Fri, 13 Dec 2024 14:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB6v-0006CQ-LH
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:03 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB6r-0007V0-2T
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:01 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-29fc424237bso905223fac.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117235; x=1734722035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nUKbNfLNV7tMpEPRQXiu5pUDo41X11Gr2PRR67Zp9bQ=;
 b=y6O9yECdk1IEQeyjfZ18sFJICDheGvB0V0h1RXGzfkwehBKJi+LJu7+XJAYBbtVUFx
 peX3WkhAT/KOil+FJ1yVYcTdXb0odBfLA8Sy5J4o/Lwgbmc+Vs2/Lt9z9I6wOeEi++Cc
 XqKD1GfQ2RnWI7L4EHoy/lB6rqOxpPqs16uBRnsANzaLu562viA6HqqAskhtC7D1PXyX
 Vmy8FSsYxSQXqKUq/eUlq98KOpxwG7QdzYYIgD9tfYVCDZnH9VKuLTz9CRu+nDRpM73v
 GDiFO/5MQOyklzr9yHHxmhZ9H1kKm3EApAjzWffzel7HUCjRXORlXbEY3ryeiKsGILmB
 wlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117235; x=1734722035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nUKbNfLNV7tMpEPRQXiu5pUDo41X11Gr2PRR67Zp9bQ=;
 b=pKOmD2gEMNJ0wFexDGdNGyqUoxigCScxV6Icy6VtFlhHvxtB0PHCZXptuTs3FC7fCR
 X7tDh6gr6Boe5pttaHK2zeouCLJGoCvNQfASsLsv+V95LKp0Nbd4HZC33rE66hVzY+Co
 oIvWDl53skrM3+mRubnnM1dPvkn4EqY2UiRb3NboK58y9+gadQFYu3Qhd/3igw3oW/9u
 VZ89RMQj0nImMcXHlEdfPHACFl4JKhUDBAQm3JQdaObs/7oNMk/AYyeu5AJw0s/ERw5M
 oS5+m/qrMbLjii8l5B97uNE3Tn74QOtFdiweJn+TcNSMTtkCYlpZ5iDuET2ZNLihZ+rs
 OvFA==
X-Gm-Message-State: AOJu0Yxk5gW6Se+ytUf1ZJJh3pKxxAcUxy1w+DHFZ9XDkk5UevZ2KRRl
 OhZ+Ic3OxZaJyAjFopIh5bBgd9bLQ7SFUsgKOTB/snNkLj4MddvWDWjmVbxfXzkFpU8GhldkVD+
 MoYtSKWPv
X-Gm-Gg: ASbGncsJ4xwITSacAKtbo6wqsIwQupOeCaK8oyHi0RuOJ8quVceA+VlQhpjZgCcv+68
 gFJB/Qyga0JS5ouZyvy0Q5cZ0G0nSP9vQKILXeegxeXiL6mbfeNphBHmI0n2pKPU/qrzQHShmO6
 H4oWbBXaL6DWCZZlb7oGNS/VOBIANKLDcutQ3ftGnSQe+mHISsJucywkvx7Kdan/u03x4JG66MR
 +0iT3qqVHngYcsSvkwtrd4C/TNEqGksEcUbLAtmz9dC0IspMz+q7cdOQlyJUZ9l
X-Google-Smtp-Source: AGHT+IHemLjXV9z1C+LJquCum9tw315+U2mAp7/7xU4Ss7HY96NJWP1dbriTWOGF/3Nqku9VDWMFNA==
X-Received: by 2002:a05:6808:1482:b0:3eb:63c9:fe87 with SMTP id
 5614622812f47-3eba6864579mr2334125b6e.16.1734117235695; 
 Fri, 13 Dec 2024 11:13:55 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:13:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 42/71] hw/nubus: Constify all Property
Date: Fri, 13 Dec 2024 13:07:16 -0600
Message-ID: <20241213190750.2513964-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/nubus/nubus-bridge.c | 2 +-
 hw/nubus/nubus-device.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/nubus/nubus-bridge.c b/hw/nubus/nubus-bridge.c
index a42c86080f..83893e5a46 100644
--- a/hw/nubus/nubus-bridge.c
+++ b/hw/nubus/nubus-bridge.c
@@ -23,7 +23,7 @@ static void nubus_bridge_init(Object *obj)
     qdev_init_gpio_out(DEVICE(s), bus->irqs, NUBUS_IRQS);
 }
 
-static Property nubus_bridge_properties[] = {
+static const Property nubus_bridge_properties[] = {
     DEFINE_PROP_UINT16("slot-available-mask", NubusBridge,
                        bus.slot_available_mask, 0xffff),
     DEFINE_PROP_END_OF_LIST()
diff --git a/hw/nubus/nubus-device.c b/hw/nubus/nubus-device.c
index 26fbcf29a2..7cafc13427 100644
--- a/hw/nubus/nubus-device.c
+++ b/hw/nubus/nubus-device.c
@@ -107,7 +107,7 @@ static void nubus_device_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property nubus_device_properties[] = {
+static const Property nubus_device_properties[] = {
     DEFINE_PROP_INT32("slot", NubusDevice, slot, -1),
     DEFINE_PROP_STRING("romfile", NubusDevice, romfile),
     DEFINE_PROP_END_OF_LIST()
-- 
2.43.0


