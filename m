Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA75EE7718E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGp-0003qh-SF; Thu, 19 Dec 2024 11:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIcY-0004c0-Rk
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:39:26 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOIcX-0004SO-Ei
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 10:39:26 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43623f0c574so6770955e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 07:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734622764; x=1735227564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ltkM6wv4nnewbtt7Wl7DzeFeRkwimvs0bnn2crm+6CQ=;
 b=jPuJDHxmUdmGyU9OLHk8iuTuWp3JW2kZ4F9XDyzMqxyINfVIknTQPoHkYTrYXozAJE
 5qEmr1yfKyi0tpM0jGMNHEYyfgcPOAegg4FTTn8wQPu8tKjRWKG4iagGIDjynnnNVoYM
 3V1Vl/cpHItfxvi0Nq2L3nHcTBb2ndMFSms2e7A2v8y30LUl43HYeuX1WrR+UDu+gPIC
 nwNrsaEcDNG72AcNNEWlGiIpuvpEABniF0LExBtgDtlnb8YVLWgTGwAnbZxeHzTguW/d
 T/zGsvel3qRG3gRJXqmO9DkjzQTbJN6ni3+p87swLx4qW4gtmmUHQC7Z4YtEyyqUNyrI
 VSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734622764; x=1735227564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ltkM6wv4nnewbtt7Wl7DzeFeRkwimvs0bnn2crm+6CQ=;
 b=Bc1G66UmBj20OlKRnrUP5zqijg4Ktx5IMjhRpHpCrvu7JbtnOhub3wJJX17wy1udR0
 3lVmUmfwmIqXnxj8Cf1M3Pitcg6VBrTIfnZ1ij6KKHmkh5PauRqHq0mjL4340Fci+vo0
 0xY7RL7TnkRcLvVMfx/WNkBExKG8tMIwhXnQYfNGbnsIwH7Dyhgb6TYQp2+WJ+Xos69R
 efyU3Y32Z0TPnbQK6DCKaCmOIcRtxfNMk90CzMQJ8tWYn7GpJ7Zvfd7j05779jCRVLta
 HNM0zC4itnj5L9CyAuqt9staprqKHeJkGun9yiL3Tk3F5Tdu2ms5+D3wlrRIPbOzivg5
 pSTQ==
X-Gm-Message-State: AOJu0Yzx8d2C8te2mGoKgmDIf20EcSdaARgkMQ+9N58ZLc6sG9Ej28eB
 pFP9Br9pR/SmDeXFOPqQuM1+W4i1wy8TutZNNkpCLTX9SCgmEzh1BAYXE457RmfD1tiM3zMuEsO
 J
X-Gm-Gg: ASbGncvnT6HdgiD8hKMWhLyR5/cOEqo/gPnEler+GKOVPSKEhvXVpjq7c3O7A3nY+DF
 xfX7CEo7lx8N0SRtDZ1qjXD/wD9BvWOQn2wcWtakfO0w3XvL8hLd8BAMxIbCuBKTQoWBLaq9n/y
 wv6tE0Lbyu8EXRxdnO0NRG2JItjVywE4gZoxSAxhk/y03BFclPig8RWI76BZh0TxPlLv2lqRtJZ
 D2zBs95FeS11GVqnHSKdCq/I8yWVWfq5DlIBRcqf/CHmRWUYv1NEXg+Ig20138PQCz68FB4214c
 Hrq6
X-Google-Smtp-Source: AGHT+IHqT2aqNU6znhJmAnu6BPD6sDUBEfCZ/4rUkgoJAGrbRO4KYM8P8HUa1iOsstTrLxK5eACAcw==
X-Received: by 2002:a05:600c:4586:b0:436:1c04:aa9a with SMTP id
 5b1f17b1804b1-43655370395mr72815995e9.14.1734622763724; 
 Thu, 19 Dec 2024 07:39:23 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436604e9c2csm22880975e9.43.2024.12.19.07.39.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Dec 2024 07:39:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 04/10] hw/misc/vmcoreinfo: Rename VMCOREINFO_DEVICE ->
 TYPE_VMCOREINFO_DEVICE
Date: Thu, 19 Dec 2024 16:38:51 +0100
Message-ID: <20241219153857.57450-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219153857.57450-1-philmd@linaro.org>
References: <20241219153857.57450-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Follow the assumed QOM type definition style, prefixing with 'TYPE_'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/misc/vmcoreinfo.h | 6 +++---
 hw/misc/vmcoreinfo.c         | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/hw/misc/vmcoreinfo.h b/include/hw/misc/vmcoreinfo.h
index da1066d540c..122c69686b0 100644
--- a/include/hw/misc/vmcoreinfo.h
+++ b/include/hw/misc/vmcoreinfo.h
@@ -16,10 +16,10 @@
 #include "standard-headers/linux/qemu_fw_cfg.h"
 #include "qom/object.h"
 
-#define VMCOREINFO_DEVICE "vmcoreinfo"
+#define TYPE_VMCOREINFO_DEVICE "vmcoreinfo"
 typedef struct VMCoreInfoState VMCoreInfoState;
-DECLARE_INSTANCE_CHECKER(VMCoreInfoState, VMCOREINFO,
-                         VMCOREINFO_DEVICE)
+DECLARE_INSTANCE_CHECKER(VMCoreInfoState, VMCOREINFO_DEVICE,
+                         TYPE_VMCOREINFO_DEVICE)
 
 typedef struct fw_cfg_vmcoreinfo FWCfgVMCoreInfo;
 
diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
index c5bb5c9fa52..9822615cfed 100644
--- a/hw/misc/vmcoreinfo.c
+++ b/hw/misc/vmcoreinfo.c
@@ -37,7 +37,7 @@ static void vmcoreinfo_reset(void *opaque)
 
 static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
 {
-    VMCoreInfoState *s = VMCOREINFO(dev);
+    VMCoreInfoState *s = VMCOREINFO_DEVICE(dev);
     FWCfgState *fw_cfg = fw_cfg_find();
     /* for gdb script dump-guest-memory.py */
     static VMCoreInfoState * volatile vmcoreinfo_state G_GNUC_UNUSED;
@@ -48,13 +48,13 @@ static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
      */
     if (!vmcoreinfo_find()) {
         error_setg(errp, "at most one %s instance is permitted",
-                   VMCOREINFO_DEVICE);
+                   TYPE_VMCOREINFO_DEVICE);
         return;
     }
 
     if (!fw_cfg || !fw_cfg->dma_enabled) {
         error_setg(errp, "%s device requires fw_cfg with DMA",
-                   VMCOREINFO_DEVICE);
+                   TYPE_VMCOREINFO_DEVICE);
         return;
     }
 
@@ -96,7 +96,7 @@ static void vmcoreinfo_device_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo vmcoreinfo_types[] = {
     {
-        .name           = VMCOREINFO_DEVICE,
+        .name           = TYPE_VMCOREINFO_DEVICE,
         .parent         = TYPE_DEVICE,
         .instance_size  = sizeof(VMCoreInfoState),
         .class_init     = vmcoreinfo_device_class_init,
-- 
2.47.1


