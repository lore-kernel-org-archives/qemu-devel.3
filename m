Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CED0E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN28z-0007Ja-UC; Sun, 15 Dec 2024 22:51:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28x-0007I7-70
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:39 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tN28v-0005zl-Pr
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:51:38 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3eba5848ee4so733422b6e.3
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734321096; x=1734925896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O2d/hWrSxehZt7xGreBWrCDPh5wzby7jHdOMpyWXISQ=;
 b=xPaeO0Ckc10qcAeaGWUV3utfq6NY98MfX4WijXenj4LZHP4yzfOqaCO+Hu6PXMRg3m
 nkF8rv9KfIQRlO4f/DjlRJqN8ewBDrfDghf2UI1Cloh/ot5qoKN9vvSqxNCenQQg3FQh
 KCseAgtMazaiB/7pSMCymOdZIapvDOGoPTkAiKT/TpMyM6qW3UnG2DLK2qeofRRL6oZC
 aLpxrW4qgrMO02myydJo6V6bYe8eqj7eWd32PXfarpeOQuu6ziJrMRewzM3P9gNXEQ54
 wX9zSLsWcA1RceCFdts3xbgfQshPIH+RaGR0iYupCfrB6+XWKfNbL79m3sUbg+zz9G9s
 eypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734321096; x=1734925896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O2d/hWrSxehZt7xGreBWrCDPh5wzby7jHdOMpyWXISQ=;
 b=nDXIjiNNhhn6tOtrKxUQLNOPNsFFcI5t16rPLhFrWxCHWWNvWw1tHeHNu+YvmYrFjZ
 BzUVPADewW0rZryuG2sMmhPXiTkdCXCSjBpy1srsI9i3Ll7w23iXT7MCuMf4rzMLos/N
 vfAJLkswNhgKoUBpQIUiI+6NrroWnJM/Hwr3+AJn3cv7TWnEu6qf279k0Z21knIXVkj5
 wdx7KRHpH9hv6leYtTpTMQ+FIjo6MN9/vEGDvOcdoQsadxq96aW59Z/eFLXjSG9iXiny
 dWAABkrWPE/MAHIWWW8bD+xp8VRB5pZFHUJxpvgZD7qOJDL7tchwMa1NImvhcjsHkiLp
 rQnQ==
X-Gm-Message-State: AOJu0YyJDwlXX6pSrlBF7XcMlAjLUJggdTot3MQtiwQQw/AxUtiwDMsG
 c0jnVoHNWQOwHHiNHg6lQlKTfLtJ0XBLPhMRH4Yum1TcoPGAEk6FcDITMi55Catx7pGovEYzlUl
 x936YKhWi
X-Gm-Gg: ASbGncud/k7no67+VbpFv5dlNmPQrqUdIh6vjTIiEW12w0Jv3UumZPLW/iQZRUzFD5p
 zPtdYG5Q5gHh4lNHIfc/HkqfxxBIT051q4POCrUwSIkvqGUMFylnvdWlhrQp5xT3uENxfaHywFl
 FGD4QUA8vKfc1JTWezf/CcMc/1jUUPg/N1srM6bT6y5l1YZlx/qXiw5mSblg0ksUVv3+PQm54g8
 Ri43/QipStuBIJVzcqwevKtJGxoylFMZieAVHa1YjYCsWZ92G5uS1uXCYFxdMWuPq67ZOF7qoF5
 Lmv5CszDxOKx+RoJWSYOb7aLbhq7crDxAdgCXfajmzc=
X-Google-Smtp-Source: AGHT+IHAsDWvyKeEc030AH5ouMCfvn8KXEz5IFVH7PeATqPAwLckYkOeZopz77B6uel9ACDvgxUeWA==
X-Received: by 2002:a05:6830:2713:b0:71d:54fb:da4e with SMTP id
 46e09a7af769-71e3b812994mr5753263a34.3.1734321096405; 
 Sun, 15 Dec 2024 19:51:36 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a93a6d1sm1287493eaf.33.2024.12.15.19.51.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 19:51:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/24] hw/sparc: Remove empty Property lists
Date: Sun, 15 Dec 2024 21:50:55 -0600
Message-ID: <20241216035109.3486070-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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
 hw/sparc/sun4m.c   | 5 -----
 hw/sparc64/sun4u.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index d52e6a7213..7ec346533e 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -732,15 +732,10 @@ static void prom_realize(DeviceState *ds, Error **errp)
     sysbus_init_mmio(dev, &s->prom);
 }
 
-static Property prom_properties[] = {
-    {/* end of property list */},
-};
-
 static void prom_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    device_class_set_props(dc, prom_properties);
     dc->realize = prom_realize;
 }
 
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 7088ac273e..05b8c7369e 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -471,15 +471,10 @@ static void prom_realize(DeviceState *ds, Error **errp)
     sysbus_init_mmio(dev, &s->prom);
 }
 
-static Property prom_properties[] = {
-    {/* end of property list */},
-};
-
 static void prom_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    device_class_set_props(dc, prom_properties);
     dc->realize = prom_realize;
 }
 
-- 
2.43.0


