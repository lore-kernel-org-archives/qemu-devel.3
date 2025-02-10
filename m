Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF3BC0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thadM-0000oS-8o; Mon, 10 Feb 2025 15:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thad6-0000Cw-TF
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:43:50 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thad4-0003kM-MB
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:43:44 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38dd006a4e1so2364556f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220220; x=1739825020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IDnd01ghJ5DO/nQRavFMGCul8vTWrpJP0MrxUBtvjqA=;
 b=tYk0+pDTu4YHam5eFbWgcsCvvZUY4CmLT+330bbU2hXrkOLtlWrbL8YFRcH9h1CfAl
 OLSyADn+T5Jr3jsx8yGsXfnpgd585SVEQo2AiJRC8AnKedTmY5UdT3fjESceR3Wa0+FC
 pQ/feP31vQTsskfwastAzHfcumgc7FVPsHq4TMMZ0Aad5o7+pj+0iWtDCNnNKwpme+ir
 9rLm6+6rHQT9euX1AsB1HLuWhusrSnfhcFcNzlWexHMIrleMpP51jm8g5jPepxqMEON3
 M2u17HZpVtaIqcMd9rNp5zoL40mLqbDi8e/QhkuWRXMUSarAJdbqcPBUO3jFKvNFnwH7
 UPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220220; x=1739825020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IDnd01ghJ5DO/nQRavFMGCul8vTWrpJP0MrxUBtvjqA=;
 b=tRUdiRQFQtHCXCJhHQYv4crOpZWQUOgCPkrkIm4Bt7wqhfWljkraJ/GBgCMsOx+mLA
 lQ8b3WSDcwLiDrRq9P33FwbKbGz8IG/O7X68KiioAIlZQQYgYvwUJYe2B0ipjHRlbUze
 BBu2gpV0vQ1f+cqqjiNHPDp9MqIYdPRuxLXoSnC24qd+kDiXy1+zdeT1uiGzSNiNn7w5
 yYuZ1WMA+qZt0YOIPbNTVzJCIdA6UjgqcMDtft0IhEdiwOMwGnSFps4vYn3E9WiUAXM+
 a/rY+Em4EdsxqMlSWZhRV9uLVTILtfd58cfwhOpHH4WDpWWfUiGwAsz9viI0qGxtbhB5
 SHRQ==
X-Gm-Message-State: AOJu0YyF3L6Svucr21BEm/6TTomNfZwMPvi2W30x01/D+i4UZ7Yjp9VV
 PchMB45i5dVFDOhuZIjpQ1YJSZm0bRCbPA4y8aWr4RC+XxrTltSQbZp/MrKm8A1k0p2wXUGIR/4
 4ahY=
X-Gm-Gg: ASbGncvROFu5AfdePCR/XhuvqjfIJLZ3SMJoEXgQ2/CnWZv0XJvzuugdZyX0m76oJV1
 p3AnfUOP+AdjXsi069v5ddaxbtEwwcIayDM21Azi9QQVvja7vvyEU2e2LrALt3HEFxLpa755EE0
 OI1kM/nxGsuvgBQdzFyZ5Hkw6Gn4juE0AEZXyWzVtMH58Q1Xej7eRk1f3/iA+23RxhueyXgUaef
 R+Chh3edm4amKPs7d5b7/diZeyIKdUqau2hdHDI5FG9gZHtdTgS45lgAj1TOXG2Q2LNfhMmUIom
 7SIPZKskGMSIhku8Ab9DrXGG9kytQdXpaQnJutChXNeEuOKdWjVob07iXNgu3eq2tg==
X-Google-Smtp-Source: AGHT+IEUS4KsM7fzmfs7yQyJ2FkAAETO7gNHE4f4ZS4rpmqcRCFu992IquUV3L93p62rcS5Iblwvtg==
X-Received: by 2002:a05:6000:1884:b0:38d:a6a1:2edc with SMTP id
 ffacd0b85a97d-38dc8d9c237mr11179506f8f.9.1739220220567; 
 Mon, 10 Feb 2025 12:43:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc17e278bsm12265152f8f.48.2025.02.10.12.43.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:43:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/32] hw/xen: Prefer QOM cast for XenLegacyDevice
Date: Mon, 10 Feb 2025 21:41:50 +0100
Message-ID: <20250210204204.54407-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Makes the code less sensitive regarding changes in the class hierarchy which
will be performed in the next patch.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250127094129.15941-1-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/xen-usb.c            | 6 +++---
 hw/xen/xen-legacy-backend.c | 2 +-
 hw/xen/xen_pvdev.c          | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index 13b065b0faa..fa46a7da01c 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -755,10 +755,10 @@ static void usbback_portid_add(struct usbback_info *usbif, unsigned port,
 
     qdict = qdict_new();
     qdict_put_str(qdict, "driver", "usb-host");
-    tmp = g_strdup_printf("%s.0", usbif->xendev.qdev.id);
+    tmp = g_strdup_printf("%s.0", DEVICE(&usbif->xendev)->id);
     qdict_put_str(qdict, "bus", tmp);
     g_free(tmp);
-    tmp = g_strdup_printf("%s-%u", usbif->xendev.qdev.id, port);
+    tmp = g_strdup_printf("%s-%u", DEVICE(&usbif->xendev)->id, port);
     qdict_put_str(qdict, "id", tmp);
     g_free(tmp);
     qdict_put_int(qdict, "port", port);
@@ -1022,7 +1022,7 @@ static void usbback_alloc(struct XenLegacyDevice *xendev)
     usbif = container_of(xendev, struct usbback_info, xendev);
 
     usb_bus_new(&usbif->bus, sizeof(usbif->bus), &xen_usb_bus_ops,
-                DEVICE(&xendev->qdev));
+                DEVICE(xendev));
     for (i = 0; i < USBBACK_MAXPORTS; i++) {
         p = &(usbif->ports[i].port);
         usb_register_port(&usbif->bus, p, usbif, i, &xen_usb_port_ops,
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 118c571b3a7..ca2fe0e6b36 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -163,7 +163,7 @@ static struct XenLegacyDevice *xen_be_get_xendev(const char *type, int dom,
 
     /* init new xendev */
     xendev = g_malloc0(ops->size);
-    object_initialize(&xendev->qdev, ops->size, TYPE_XENBACKEND);
+    object_initialize(xendev, ops->size, TYPE_XENBACKEND);
     OBJECT(xendev)->free = g_free;
     qdev_set_id(DEVICE(xendev), g_strdup_printf("xen-%s-%d", type, dev),
                 &error_fatal);
diff --git a/hw/xen/xen_pvdev.c b/hw/xen/xen_pvdev.c
index c9143ba259e..fe95b62d133 100644
--- a/hw/xen/xen_pvdev.c
+++ b/hw/xen/xen_pvdev.c
@@ -273,7 +273,7 @@ void xen_pv_del_xendev(struct XenLegacyDevice *xendev)
 
     QTAILQ_REMOVE(&xendevs, xendev, next);
 
-    qdev_unplug(&xendev->qdev, NULL);
+    qdev_unplug(DEVICE(xendev), NULL);
 }
 
 void xen_pv_insert_xendev(struct XenLegacyDevice *xendev)
-- 
2.47.1


