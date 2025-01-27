Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9F7C0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 09:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcLcu-0005Nk-UD; Mon, 27 Jan 2025 04:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tcLcr-0005Jz-Bi
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 04:41:49 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tcLco-0005E0-AH
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 04:41:48 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d3f28881d6so6252966a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 01:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737970904; x=1738575704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yjPzdHFXd2uRfONBBPJoicdiCvhjmel6wJx9kp25WTk=;
 b=GJU9snrvB/L3qs9BfswlfvHUGRkDPk2QHAJFikL6Y4tT+9MT9zPF8Wl3ddWOyDXrdN
 gTHlURvGSbp4sxmqJNd2DXSoph8X2n4uuj2FnPYHdEAchD7T0KaedtCdsJUBqPJDa9ZQ
 ChJI+114ahKAowDvGTGZ58sf2PFbpWpWOd2DL5AwkvrVoPo4USBwP3tb8rLwn6wxq4Nk
 42evmVpX9T5rHmE4N4SsBcbnwpsiSmYV19NpJ23Q6HICrD/4y1QrUxDKVYqeq4Q8mDz3
 w894TrvtEfqqw9fl2AaID7mIN7AdVoZdTuZrLsLDwreTjN/MTiequRklYbjwNwvc1Peo
 Y5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737970904; x=1738575704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yjPzdHFXd2uRfONBBPJoicdiCvhjmel6wJx9kp25WTk=;
 b=E+TRBEM/qduLHBgQwYq/xDHfCKg53dF4LngI0lycyoDexZNl4S1Qqc0soWsXOnD5nS
 AnDoqxLvT5MWLC0aMAR8ZMi/YLXx10YOxmHcwO85nMKBpoQ0WdDOFOkcuUbrJRl8nkHg
 2XBiH7blg0uaWyHW8sECt9t/y6K1C5/zNK9dgv7Pdps3Q9BVQcSj40ovGGA+4l2zwn82
 uztsNoIodZyf7feEIt7bx+QDLhYAI5MUAZuY4NH8o37LPe2pPX3TLI9ntHrZTb385XeM
 toPP0bVedAgIm63V/ikxrZaKrDaUZT/GwiYZysfAxECnnvwa2ErK2sV9NIS4WM6U+yRW
 htaQ==
X-Gm-Message-State: AOJu0YzUD+DgZ5uiUnHB/rfb+ChCFpUSBXEZ/SqV3sR1QE7DjSym4TC0
 /Rymdfi2tkjOGJRv4EtYZeIUDqvdjrb7FgslqTN8pT+MaEizSsAKLkK2rA==
X-Gm-Gg: ASbGnctkz14nuIM7xWEja5UFs5bGkxRvF9bCAYRVG/y7gOnRtRqcKNktYXVnuP3lodJ
 oQl/vyTbPAfbogAZeJCrvUGfEbskcUYL8LpAi1oFkzVcqYcwlK+bxPbMu94XityzEq4+UKOH+mO
 TkUUmYNR7dvZbJ5m8FOqlZZhP8I+DOqlQvkODLaVbEcZpL3z7SziKxl2rtMRZsd7uhQ33dYLyB6
 8/KgK6mrzTtljvRq2lhjH+Jur+vii0T+RSxaSSYG1yeWjlSXpuF9RZRe+kb3qEi0QrHtUXxijCM
 ZVbT7XYzqRrEsCspPI7GMWafHX/rWa26ITOIoaRgS3CPPHppmCYCkpSZzWQgoCS2kM/l8A==
X-Google-Smtp-Source: AGHT+IFkv/KhCLVJUxMspAgUNe0GHT45E89xP1HqZLFbEuM2gS84XOsj/ALx/tTzcGTUQZwwVlsNIQ==
X-Received: by 2002:a05:6402:50d4:b0:5d0:cfad:f71 with SMTP id
 4fb4d7f45d1cf-5db7db2bea3mr93510860a12.32.1737970904204; 
 Mon, 27 Jan 2025 01:41:44 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-093-128-047-181.93.128.pool.telefonica.de. [93.128.47.181])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc18619265sm5140631a12.7.2025.01.27.01.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 01:41:43 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Paul Durrant <paul@xen.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH] hw/*/xen*: Prefer QOM cast for XenLegacyDevice
Date: Mon, 27 Jan 2025 10:41:29 +0100
Message-ID: <20250127094129.15941-1-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250125181343.59151-10-philmd@linaro.org>
References: <20250125181343.59151-10-philmd@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Makes the code less sensitive regarding changes in the class hierarchy which
will be performed in the next patch.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/usb/xen-usb.c            | 6 +++---
 hw/xen/xen-legacy-backend.c | 2 +-
 hw/xen/xen_pvdev.c          | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index 13901625c0..3da30efc44 100644
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
index 118c571b3a..ca2fe0e6b3 100644
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
index c9143ba259..fe95b62d13 100644
--- a/hw/xen/xen_pvdev.c
+++ b/hw/xen/xen_pvdev.c
@@ -273,7 +273,7 @@ void xen_pv_del_xendev(struct XenLegacyDevice *xendev)
 
     QTAILQ_REMOVE(&xendevs, xendev, next);
 
-    qdev_unplug(&xendev->qdev, NULL);
+    qdev_unplug(DEVICE(xendev), NULL);
 }
 
 void xen_pv_insert_xendev(struct XenLegacyDevice *xendev)
-- 
2.48.1


