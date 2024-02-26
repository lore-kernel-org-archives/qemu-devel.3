Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F024C54E51
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reewC-0004ii-RA; Mon, 26 Feb 2024 12:38:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reew9-0004Yu-3R
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:38:45 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reew7-0007AU-JS
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:38:44 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-412a3371133so10231845e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 09:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708969121; x=1709573921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=67Ry2a6gAfjKQBP9Yw9WSNGqndsJgD876RK2i0/zSrw=;
 b=XpU3iXAmdkQdSxPVWMsr9IASBDwk2ok8jOtvQSXVffxNNURBnWoZej4effi9QX6K9L
 PQkw8ReTUlgMgPMmTLAy9lvF//76/DTvZDkPKaxRQiTLbtv/y5Ujb6bcyHP7UALnS5bS
 DhhAHfree9PgsQe3A6t8vSwpGLKDyqqp7wdsJCd8VEUODcwUl707xWTImBV2jU3Fd99r
 CC+r29kGY0ZtXauTtOaYasDa8DPX3Wy0Uvh3R+rQfP7DuabrtwJrKLixE6IA6AsJoENI
 YeFxqJz1YDGpAq7Zxj21CEmUroqqjBLp6KaaUKOXejHmdKjHwZWmsizRE1eoRn+Ek7Mt
 AZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708969121; x=1709573921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=67Ry2a6gAfjKQBP9Yw9WSNGqndsJgD876RK2i0/zSrw=;
 b=qkRlLTQZey8nl17A805aAEwcGN0GpxEaV8r/Nf+QHVzNzUyTxsjOIZdNiUTgy8bLM9
 fUqr1GYeN/jAmd6gvbVXAJAuYkS/G6nkIGCGqpNsHkFzqoC+XDhK4V2an3G1cXpg7DTK
 cLO2Bz6/Xd5TAoTj9i1toD/79sPud86RrQK3P6J5l1e50QCi4kDwMOvm3c5BMXGnWx8f
 wMQvl+CXU+1wF6g/inXKm3vwY++mrvBOPcYIA89Kzvgn1Y3dALclqjfvo9e9tAks0xYe
 +1BZU61myFxjuCD/7zlcHTZfEPO9KFI032F1gbZGmZ5gKVj7w3iOOtGUioC9GU7+/Kc8
 5XfQ==
X-Gm-Message-State: AOJu0Yzub4zR23dAJKbJbrHCXdKIsNkvHynAeVEo+lBUigIxsA56jdpP
 qrJVqJTlHw1J1FXWl9DFVUVMVH4QP9QjrlkGyUAbMzE2N2s2Dc/5t+m+EDi/SHnpK2N73SiIXt1
 F
X-Google-Smtp-Source: AGHT+IFm9j7roCguFb9LggVqMuSN/9WcoP0rMHs5V+U6pZLt39Yo3y7KKzQ3CRO0q3CeqDXZrK68jA==
X-Received: by 2002:a05:600c:4706:b0:412:a313:5a5f with SMTP id
 v6-20020a05600c470600b00412a3135a5fmr3562490wmo.4.1708969120904; 
 Mon, 26 Feb 2024 09:38:40 -0800 (PST)
Received: from m1x-phil.lan ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a05600c4ecd00b00412a1307106sm6258725wmq.43.2024.02.26.09.38.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 09:38:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 6/6] hw/sysbus: Remove now unused sysbus_address_space()
Date: Mon, 26 Feb 2024 18:38:04 +0100
Message-ID: <20240226173805.289-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226173805.289-1-philmd@linaro.org>
References: <20240226173805.289-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

sysbus_address_space() is not more used, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/sysbus.h | 1 -
 hw/core/sysbus.c    | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index 14dbc22d0c..3cb29a480e 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -83,7 +83,6 @@ void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr);
 void sysbus_mmio_map_overlap(SysBusDevice *dev, int n, hwaddr addr,
                              int priority);
 void sysbus_mmio_unmap(SysBusDevice *dev, int n);
-MemoryRegion *sysbus_address_space(SysBusDevice *dev);
 
 bool sysbus_realize(SysBusDevice *dev, Error **errp);
 bool sysbus_realize_and_unref(SysBusDevice *dev, Error **errp);
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 9f1d5b2d6d..ad34fb7344 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -298,11 +298,6 @@ static char *sysbus_get_fw_dev_path(DeviceState *dev)
     return g_strdup(qdev_fw_name(dev));
 }
 
-MemoryRegion *sysbus_address_space(SysBusDevice *dev)
-{
-    return get_system_memory();
-}
-
 static void sysbus_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
-- 
2.41.0


