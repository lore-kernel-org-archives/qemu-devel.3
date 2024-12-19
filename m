Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC669E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJIT-0000EH-4C; Thu, 19 Dec 2024 11:22:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIck-0004pC-0I
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:39:38 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIci-0004Vo-B9
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:39:37 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361a50e337so6978315e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734622774; x=1735227574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RMGv7qvi3m/JTiz7jQ63fQU4SttU7iapPs3aSHWSfWE=;
 b=h4cTGGIAoYun2ASXFD9Je9JoqpR0sujEsWKg6rtpwHMN5ZqE4nM1yuqLRbgiKszQe3
 l5McV6Arp9LIsCHfCeBbJGz2qj/wVdDICbu8zTt5wWUUMrX6m4pXGLKaS481Q99G3CQH
 5D1iRlwnCzH5za0YdopyByt5xVz/W247unu2z1+UGihBe2EQBpuPe+MuvuqAiYNiBsN9
 TZldclw0cBlCdM4DzdN25YK4jvD1x1KRv5k/O3YWSidPKS+Y85rZsxfdbiWT0DREeUSU
 3fURLdIF1Aw6+HUj1pu7MsbgusJE/NSEYJJy82ckwLJtd5JffcIc9lnw8BJvn4AI4wfO
 yQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734622774; x=1735227574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RMGv7qvi3m/JTiz7jQ63fQU4SttU7iapPs3aSHWSfWE=;
 b=pB5n4ngxJIkLSg3JNtIlUUzdpPLCWn2NH20s8xraQ67Jvsc+eS/3zPa37kK2MYYCtS
 n6KE3rbEOvHmhDlrYjIfmBnohRh9dHOuKAhIOP4kbfHx3GJwfnrDMqVCjtF1mTUhRRw2
 vFLsNxr1LZSgB7B90rvlQcs/sq7a0WqyJlXOxnxHNWALhgPr8TG7ssyPRNvPD/yk9C0K
 55jzLCXq5x+Twlnr5Kv+Q4m1KEHSeLsCaiXFmYhWnUVYBKF/PhT4tHwuYJyMwkVqaBkr
 j/zrSgBfIisXQDA1xkaOLFyU696Bwy7Sk8r9Bg1b+6knIxLwHXIk6HRNB2Gx067HTx25
 uytA==
X-Gm-Message-State: AOJu0YyA+zuK1/ZwExSU7Vou1iggOJstkyOTeG5yP58MCD67ICVXjRXJ
 CMTiy5reKWGv/wM7EkxABDfQujOgzogtpzj/BV3OueIzq67yrH/eHmPhWsCWIcgN9+J11oR1/DS
 W
X-Gm-Gg: ASbGncvQeAmk+EaL3tyivB9muC2qJ+skKAFK3UdouWNr425Al7a206ks2EjkYpHLmMh
 zl8mzFTSNw5nr289HjjRAkCdBUYkEdTW19V7q6DDa+s2ivnl+J4XOGx9teAJF/qL5YISMa8sLPa
 upwEnr6AJfmy1DsAsPTZekaRdqVw6nVOLKXtagAP3gI3W2lV7K6GDvGib4pfSxpIyeWvavBNqLR
 ZqPsJ3YwJzrSV36WQe4r6q1o0xlqADH2P4sWE7N8wTTlQzY8qWwMEX7lxBBhhq5UQH28U388CfK
 POj0
X-Google-Smtp-Source: AGHT+IGh0eZIZPaxTiz7UGfEy8XHE6o5ObgLI9iwFFlqzABUoKuS/Dmnu9cBOUOHJL67G2wHfkMXog==
X-Received: by 2002:a05:600c:4fd3:b0:436:346a:fa9b with SMTP id
 5b1f17b1804b1-4365c7c9707mr27726955e9.20.1734622774615; 
 Thu, 19 Dec 2024 07:39:34 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8474a9sm1805633f8f.52.2024.12.19.07.39.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Dec 2024 07:39:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 06/10] hw/misc/vmcoreinfo: Move vmstate_vmcoreinfo[] around
Date: Thu, 19 Dec 2024 16:38:53 +0100
Message-ID: <20241219153857.57450-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219153857.57450-1-philmd@linaro.org>
References: <20241219153857.57450-1-philmd@linaro.org>
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

In order to simplify the next commit,
move vmstate_vmcoreinfo[] around.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/vmcoreinfo.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index 093bede655e..55f9d437a94 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -18,6 +18,20 @@
 #include "migration/vmstate.h"
 #include "hw/misc/vmcoreinfo.h"
 
+static const VMStateDescription vmstate_vmcoreinfo = {
+    .name = "vmcoreinfo",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL(has_vmcoreinfo, VMCoreInfoState),
+        VMSTATE_UINT16(vmcoreinfo.host_format, VMCoreInfoState),
+        VMSTATE_UINT16(vmcoreinfo.guest_format, VMCoreInfoState),
+        VMSTATE_UINT32(vmcoreinfo.size, VMCoreInfoState),
+        VMSTATE_UINT64(vmcoreinfo.paddr, VMCoreInfoState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static void fw_cfg_vmci_write(void *opaque, off_t offset, size_t len)
 {
     VMCoreInfoState *s = opaque;
@@ -70,20 +84,6 @@ static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
     vmcoreinfo_state = s;
 }
 
-static const VMStateDescription vmstate_vmcoreinfo = {
-    .name = "vmcoreinfo",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (const VMStateField[]) {
-        VMSTATE_BOOL(has_vmcoreinfo, VMCoreInfoState),
-        VMSTATE_UINT16(vmcoreinfo.host_format, VMCoreInfoState),
-        VMSTATE_UINT16(vmcoreinfo.guest_format, VMCoreInfoState),
-        VMSTATE_UINT32(vmcoreinfo.size, VMCoreInfoState),
-        VMSTATE_UINT64(vmcoreinfo.paddr, VMCoreInfoState),
-        VMSTATE_END_OF_LIST()
-    },
-};
-
 static void vmcoreinfo_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-- 
2.47.1


