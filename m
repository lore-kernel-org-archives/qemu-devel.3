Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F156C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 18:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbkfn-0008FD-39; Sat, 25 Jan 2025 13:14:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkfe-0008CS-1H
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:14:16 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkfa-0004F8-0S
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:14:12 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-437a92d7b96so32123215e9.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 10:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737828847; x=1738433647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dyOkRsNGVEWSIU/g0zj3C7+UfvVjzQgLwIYDoErjrzY=;
 b=j7cufMCr+elMY6jVERZ8Fx+SxovwQ0h+/COMnnW6yJ7O16eXCMYJNV3AaiKYNDR5OG
 KiVXZOy152tw9KYAi3wFgL1zUL0w6LeKihf+ct1FE/6Z0KOWx0zqLY2uMNP7SPYMPEE+
 sLTzyGN7/YRgzCx52oDY4180qkQajYB4ePPLleWk3wSo1SDyrCh9M64Dn3HCkTpWfaKD
 ewWEahHz9wtOn8vZIXz3mcKQk9e9CHyg0q4RGbqEH2AqStMEBn6v3sFIqG3yRUccUMBc
 3CqQWQSk7s4NFun6SQ+NkTVcNoyfIfXkffzfUv8NTWFB2NgLR0UiyueL1BotIktEA3pE
 8UIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737828847; x=1738433647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dyOkRsNGVEWSIU/g0zj3C7+UfvVjzQgLwIYDoErjrzY=;
 b=OT5znBFscITiz5zPCUF/9FBEwXZsoBpOgVZ9gC8vgaK8qc0RJ3qxDSH3QOIngW9Lh6
 qfFGxiNLXNEiXnyVnIZfr0vefiFy+fkM2NZK4JylQRbbDFPM92RjCo5i/5lzCayX+cIa
 G6J6hnCf8WBoCn/jBsB9QHnSjCMazltkcQMcpR6Zrks4lP55DxVH2w3HN2eDfbqROVU4
 8fxKZ15rm+iqLKfgIC0XUnH0GPglCT4mYGul3fWYEQs4da7vC0VtUdLYgUwLmAbShs52
 pHI5iH1mGHTXF52/PjyonizGhp+kQILNgPJsiz1jhZKUF0vF0Y6CPBNXvu5W4oXlsoio
 4J3Q==
X-Gm-Message-State: AOJu0Yw3mMPBvecZzGcWME7iRG3gOsMU9Ik+c7WqYvRlXWmuPqIfnV1m
 tD7Ju9suiR4oyKoJOsRFmLM/q9vQ7NAs/1wrknBJRtTPYuU5DGiY2MOnTwCW6fQ2APU3uumovzS
 bggc=
X-Gm-Gg: ASbGncvibm1VqCfD9qtfdgMcthD79yViPRlwOJhiMoHOxJJU785uv0cwVr8ycYRnMwl
 2gfyUeV0ep0oFnq1XqhAF59xHRFyW0WcO/2195H6X7RmiC88pdLAmV5x8qTwI7XO7urUIJRD+wK
 l9I8jR4OWx9zXdsjybHUuSOvqGdukm2kGwvkoJ7LfYtem0d/mUZM2aMJJERbVZs2amIeHo/doLG
 EAj8aNlQAhEff3hrk9r82UmRu+XJKxnYrpBVwwa/LezhZ35rJTSh3hx4uWj4HIwLYRF6vNH6JlJ
 LiWYyTzyuGxFdYKiHYlMjVEdvNb1Vbfgrj4bEhlacrAjEcXlhgeFERdU0jqm
X-Google-Smtp-Source: AGHT+IEr2qoA1rRQRSxzBRg9AaVRyh1DsB0c2e066JVheh7W35FZo8o118MnJ47nSIRaQRkoz3MpFg==
X-Received: by 2002:a05:600c:468d:b0:436:4708:9fb6 with SMTP id
 5b1f17b1804b1-43891437546mr293523335e9.20.1737828846888; 
 Sat, 25 Jan 2025 10:14:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4857c3sm68307685e9.10.2025.01.25.10.14.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 10:14:06 -0800 (PST)
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
Subject: [PATCH 4/9] hw/vfio: Have VFIO_PLATFORM devices inherit from
 DYNAMIC_SYS_BUS_DEVICE
Date: Sat, 25 Jan 2025 19:13:38 +0100
Message-ID: <20250125181343.59151-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125181343.59151-1-philmd@linaro.org>
References: <20250125181343.59151-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Do not explain why VFIO_PLATFORM devices are user_creatable,
have them inherit TYPE_DYNAMIC_SYS_BUS_DEVICE, to explicit
they can optionally be plugged on TYPE_PLATFORM_BUS_DEVICE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/amd-xgbe.c      | 2 --
 hw/vfio/calxeda-xgmac.c | 2 --
 hw/vfio/platform.c      | 4 +---
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/vfio/amd-xgbe.c b/hw/vfio/amd-xgbe.c
index 96bd608b8dd..aaa96903db0 100644
--- a/hw/vfio/amd-xgbe.c
+++ b/hw/vfio/amd-xgbe.c
@@ -41,8 +41,6 @@ static void vfio_amd_xgbe_class_init(ObjectClass *klass, void *data)
                                     &vcxc->parent_realize);
     dc->desc = "VFIO AMD XGBE";
     dc->vmsd = &vfio_platform_amd_xgbe_vmstate;
-    /* Supported by TYPE_VIRT_MACHINE */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo vfio_amd_xgbe_dev_info = {
diff --git a/hw/vfio/calxeda-xgmac.c b/hw/vfio/calxeda-xgmac.c
index 87c382e7361..b016d42b496 100644
--- a/hw/vfio/calxeda-xgmac.c
+++ b/hw/vfio/calxeda-xgmac.c
@@ -41,8 +41,6 @@ static void vfio_calxeda_xgmac_class_init(ObjectClass *klass, void *data)
                                     &vcxc->parent_realize);
     dc->desc = "VFIO Calxeda XGMAC";
     dc->vmsd = &vfio_platform_calxeda_xgmac_vmstate;
-    /* Supported by TYPE_VIRT_MACHINE */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo vfio_calxeda_xgmac_dev_info = {
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 1070a2113a1..f491f4dc954 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -672,13 +672,11 @@ static void vfio_platform_class_init(ObjectClass *klass, void *data)
     dc->desc = "VFIO-based platform device assignment";
     sbc->connect_irq_notifier = vfio_start_irqfd_injection;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    /* Supported by TYPE_VIRT_MACHINE */
-    dc->user_creatable = true;
 }
 
 static const TypeInfo vfio_platform_dev_info = {
     .name = TYPE_VFIO_PLATFORM,
-    .parent = TYPE_SYS_BUS_DEVICE,
+    .parent = TYPE_DYNAMIC_SYS_BUS_DEVICE,
     .instance_size = sizeof(VFIOPlatformDevice),
     .instance_init = vfio_platform_instance_init,
     .class_init = vfio_platform_class_init,
-- 
2.47.1


