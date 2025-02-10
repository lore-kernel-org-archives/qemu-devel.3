Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8450BC0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thadK-0000eN-Tz; Mon, 10 Feb 2025 15:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thadA-0000Hg-SL
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:43:54 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thad9-0003l2-7o
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:43:48 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38dd93a6f0aso1417352f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220225; x=1739825025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DVW9ufOV2+0hfeUzGxYgydnkdsq/0Dv+lLX+D5jdROY=;
 b=Z/937dnso5mLwo3K682GNI4f5JlMRqlC+VWrSv8FydAnrpmNT2rg73e/HQ8KX2m075
 Wm4I4T1kGrAN3HQy5M4pPNcJTrka1AIbfJ8bP/TxB3uRTGTdBfNUfL3cbNAhpCij+kww
 nbBtQoTlvTVgvE3tcRvQsL7pAuXNLG8RMNFiya5K8yen2zCPzeDrtdyl5TxYwje0CyuY
 johSmcqeu5dYH4GY5+6k4wFtMuMoO6ryxca5WuURt58knmdYn9wA9C5v/TnILguGCEJp
 EQtfuqV8wb9AsEd+hwQ1y9rUz+M3nNfMAcHvKGU3/SrPgwTfrDme4OnH1SjQiI39aUEi
 6BPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220225; x=1739825025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DVW9ufOV2+0hfeUzGxYgydnkdsq/0Dv+lLX+D5jdROY=;
 b=G8uaGnSvFNJwZU6YkVgWn+Zc6voYx+QGfRg1gHkCzgo7uAgt7utyRFlPDIJn0VUDA1
 xoHUj261o7+XKDi/gRZPcCDkBuzhBd13p0e8TIKaxMTurzF2LXP6+9d8pJ0yNZ/8zTcd
 TbC9GdSIMdC65wlvzwMdKNx0JBnwL4Irm2yT7+oFFWBPgHDrzsS2aCClZAvGktQUhLD1
 tXpfH2QkKDt0VcV6VGGtt45R7qu3dDWVYTRZ3Lyn8RJTj0p8hxKu3Srsq1NRINWQxykO
 qYXtatb0a7pqzbjuBWftaXRref5IMLTbM72pLArDd5rC9SDAANvds8O0S+A3/tYAfzxT
 N87A==
X-Gm-Message-State: AOJu0Yy267B69oo59PzQKQLEB/sqMcEtoDBpmFjT5e5JyEM3hRXEXnZe
 pVsFo0PE5a6IbCEgWt3rYVtxBg9+sPJsG7oAcs17jEubJrGDZpxbvlKQzzRcYsCX62X0Q3sKCTQ
 3q7s=
X-Gm-Gg: ASbGncvk97hMVwC/wxZjUZBoQ/c7/mgHF+45YeyW1NUkuy5dEAlduLvz1Z0vLf1yUu0
 dn6EINDhgSBZcRi2A5iKKqlZW610VXqFBR2l7LewHcchoHLmNHzabkjrhl8Xjt1HCOk5qiMVJxl
 5Kx/ZvMEB3epkN/Q5e0vVtyZGEeLgL+10Ah67xyptNZNY+jaYffF2jCLayfVPxSfHcMRSJYLZNx
 j+3LaCR40MhM2Rqh83Ns5hPBEYb/CbQeRCP0XEwsULd3PPN7+hqNxjpdpKRd3Fhh7e+cGBtzWYM
 sRzbpwBqPkQZK12Anb9sNSBcvSnRBx0P2+SHs/84IsgoyGv0YeCxAhRQxoyPeb7ZwA==
X-Google-Smtp-Source: AGHT+IEdB9jyOOCnMAcW3U4fWGN7UpQagFk/0iIxmpIkI0Q6zbVDrSMunjAlgNVyfCDVPvMFf+JKjQ==
X-Received: by 2002:a05:6000:1fa5:b0:38d:deca:fcc1 with SMTP id
 ffacd0b85a97d-38ddecaff06mr4788510f8f.29.1739220225258; 
 Mon, 10 Feb 2025 12:43:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc5839877sm11546143f8f.3.2025.02.10.12.43.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:43:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <graf@amazon.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 19/32] hw/xen: Have legacy Xen backend inherit from
 DYNAMIC_SYS_BUS_DEVICE
Date: Mon, 10 Feb 2025 21:41:51 +0100
Message-ID: <20250210204204.54407-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Because the legacy Xen backend devices can optionally be plugged on the
TYPE_PLATFORM_BUS_DEVICE, have it inherit TYPE_DYNAMIC_SYS_BUS_DEVICE.
Remove the implicit TYPE_XENSYSDEV instance_size.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alexander Graf <graf@amazon.com>
Tested-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20250125181343.59151-10-philmd@linaro.org>
---
 include/hw/xen/xen_pvdev.h  | 5 +++--
 hw/xen/xen-legacy-backend.c | 7 ++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/hw/xen/xen_pvdev.h b/include/hw/xen/xen_pvdev.h
index 0c984440476..629bec90d09 100644
--- a/include/hw/xen/xen_pvdev.h
+++ b/include/hw/xen/xen_pvdev.h
@@ -1,7 +1,7 @@
 #ifndef QEMU_HW_XEN_PVDEV_H
 #define QEMU_HW_XEN_PVDEV_H
 
-#include "hw/qdev-core.h"
+#include "hw/sysbus.h"
 #include "hw/xen/xen_backend_ops.h"
 
 /* ------------------------------------------------------------- */
@@ -32,7 +32,8 @@ struct XenDevOps {
 };
 
 struct XenLegacyDevice {
-    DeviceState        qdev;
+    SysBusDevice parent_obj;
+
     const char         *type;
     int                dom;
     int                dev;
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index ca2fe0e6b36..bf58db0ca68 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -640,16 +640,14 @@ static void xendev_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    /* xen-backend devices can be plugged/unplugged dynamically */
-    dc->user_creatable = true;
     dc->bus_type = TYPE_XENSYSBUS;
 }
 
 static const TypeInfo xendev_type_info = {
     .name          = TYPE_XENBACKEND,
-    .parent        = TYPE_DEVICE,
+    .parent        = TYPE_DYNAMIC_SYS_BUS_DEVICE,
     .class_init    = xendev_class_init,
-    .instance_size = sizeof(struct XenLegacyDevice),
+    .instance_size = sizeof(XenLegacyDevice),
 };
 
 static void xen_sysbus_class_init(ObjectClass *klass, void *data)
@@ -672,7 +670,6 @@ static const TypeInfo xensysbus_info = {
 static const TypeInfo xensysdev_info = {
     .name          = TYPE_XENSYSDEV,
     .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(SysBusDevice),
 };
 
 static void xenbe_register_types(void)
-- 
2.47.1


