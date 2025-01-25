Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9536C0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 18:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbkfj-0008E2-99; Sat, 25 Jan 2025 13:14:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkfa-0008C0-75
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:14:13 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkfT-0004EF-JH
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:14:05 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso2506565f8f.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 10:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737828842; x=1738433642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=60AuA1WDx9vhZn9WTP7sL5YOcyHTmPSWNTPXV1fPX/g=;
 b=NOzNXYXMvUQ4z6MSZv8v0orQ4FQb/kv2Kc9CbBejaFKVNbD5GDarkQdePQTGQZmwA2
 ssAwj9pilZthsmAmScon3CTvuh4JYgPdc23nidlKmzTzuE0MSY8CgDPDZIh8yRL6SkfT
 GO/RxnaA4EwR4xSnuJcfeMv72GEJ9cHnCO0c7UqmWt46WIdqQicZFwoa/APSG/JHdF6E
 1T5LRbjuTrz+jfBWImRPtXHycqulcDqeBnxt7NWfYmO/DGO1J3mDKdDtVX3XrZhGQJd3
 X/u1lZhEhZNdrp7xuHucMNM922jWI/zYXdwFVCVldlzmPsU5We1gF2VAtUGrDilKNoiV
 4isA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737828842; x=1738433642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=60AuA1WDx9vhZn9WTP7sL5YOcyHTmPSWNTPXV1fPX/g=;
 b=dkk/WwD4QYDc53IBhQcjYEzAc+1a3pfKWUNgx8zNmBOB9lRGnDFOfPXVHRzpTNNaZE
 WQnUBmix+tYuQh6wOQRMq2MqTzOUtufkhWfvytGQjpZ6LnqVjzdxrU0IESKVcR2bNAWi
 S0qz3Xbi2/tmMrpGkpw+ZHs0UAa8tt1xlgUUoDhEsU01GbeygKO2Omkr4xzzYnZ/rZoc
 2N+GnY/HWLSVUTWy0uQ5bdmizWqMwpO1JQBGv/ZZAto63eTDZyfqnITtR7PH1LBJD0of
 4+MjtyM7GSiZOA8mJ2f7MO+p+miqp4+ELWiQIWGXCBf5c2m5X42YAhh9tQZcZPsYE/bl
 JmHA==
X-Gm-Message-State: AOJu0YzQVJrhqKmtZzyRq48vRWSYRUrFoYOAs+EiD2YqegfHNToDo/Ko
 bOHSRFJRMAui+UeYimwUNwxhVGqawKB2nky1+Ps+vFEgcm8iiboV2Ph34UwITxWJs+eK92ZLwTA
 sTUA=
X-Gm-Gg: ASbGncvASX6FqmsJJ2JkElzpfJTGHiWIMIfnibZ+Xh46o6c5jKADK2S5QlWO5WWfHYz
 9s2SWsbrLCSyLjBoMV5UETbo2w45UK9pNOdu0LwH01At0cYtwv0sx24O/5WCQPydjDO1ayFX3yX
 g0DQXbrpPPcDkbMSRdzD+AittdLpXhFebtqqMU2DbeXM1NnJraLRsNN0Qs7IkRg1lNc0k7jSW3o
 JyT6nk422u2VtUzg/3LkxGqEecxqrfUGeUZFj/Fleq8yt6ph0LAtd80+6KS1/JpnkOxZOJ8yHEg
 Fc9qFgmviV+Sd7BjbTO6qNmlMMB0nhCXYUwgmllwggcMYFvYrnkpR2Q3DT9/
X-Google-Smtp-Source: AGHT+IFmsyFMtRiyUoQTMlDTj6UgcQ0Wyp8q7Re0IHss6ougDQh97Nwe8Gj2HZEyku0oDKVtn8rFyg==
X-Received: by 2002:a05:6000:2c5:b0:37d:4647:154e with SMTP id
 ffacd0b85a97d-38bf5655bd3mr29759427f8f.9.1737828841654; 
 Sat, 25 Jan 2025 10:14:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d865sm6249213f8f.38.2025.01.25.10.14.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 10:14:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Anthony PERARD <anthony@xenproject.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <graf@amazon.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/9] hw/sysbus: Introduce TYPE_DYNAMIC_SYS_BUS_DEVICE
Date: Sat, 25 Jan 2025 19:13:37 +0100
Message-ID: <20250125181343.59151-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125181343.59151-1-philmd@linaro.org>
References: <20250125181343.59151-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Some TYPE_SYS_BUS_DEVICEs can be optionally dynamically
plugged on the TYPE_PLATFORM_BUS_DEVICE.
Rather than sometimes noting that with comment around
the 'user_creatable = true' line in each DeviceRealize
handler, introduce an abstract TYPE_DYNAMIC_SYS_BUS_DEVICE
class.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sysbus.h |  2 ++
 hw/core/sysbus.c    | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index c9b1e0e90e3..81bbda10d37 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -19,6 +19,8 @@ DECLARE_INSTANCE_CHECKER(BusState, SYSTEM_BUS,
 OBJECT_DECLARE_TYPE(SysBusDevice, SysBusDeviceClass,
                     SYS_BUS_DEVICE)
 
+#define TYPE_DYNAMIC_SYS_BUS_DEVICE "dynamic-sysbus-device"
+
 /**
  * SysBusDeviceClass:
  *
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 306f98406c0..e8d03fd28d9 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -321,6 +321,14 @@ BusState *sysbus_get_default(void)
     return main_system_bus;
 }
 
+static void dynamic_sysbus_device_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *k = DEVICE_CLASS(klass);
+
+    k->user_creatable = true;
+    k->hotpluggable = false;
+}
+
 static const TypeInfo sysbus_types[] = {
     {
         .name           = TYPE_SYSTEM_BUS,
@@ -336,6 +344,12 @@ static const TypeInfo sysbus_types[] = {
         .class_size     = sizeof(SysBusDeviceClass),
         .class_init     = sysbus_device_class_init,
     },
+    {
+        .name           = TYPE_DYNAMIC_SYS_BUS_DEVICE,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .class_init     = dynamic_sysbus_device_class_init,
+        .abstract       = true,
+    }
 };
 
 DEFINE_TYPES(sysbus_types)
-- 
2.47.1


