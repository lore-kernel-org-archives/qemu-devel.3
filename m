Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177AAC0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 18:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbkgK-0000HJ-3j; Sat, 25 Jan 2025 13:14:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkg6-00006c-CG
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:14:46 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkg1-0004Ip-DI
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:14:41 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so32105095e9.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 10:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737828875; x=1738433675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bl6x3NGb6owz3SHDZJmiiZ4r1za5TcxmylUs2G0w4SA=;
 b=ro4U20GmmVU2Vhqa43lZgUYnhXDQKpJxZ3nleuqP3lU6Aeh8c0AwatB1U9GEcH9NEC
 mswFz4j7kDRcVZxXDsTKl7qrjDkieop17+COSuDMIgTT7dO18zcz8hyUDLhPvvz1VPc9
 raJX59mPtz2IsNjX4+pBABhfbANLPOQwrVBrd2x6B59/UYMdzw3g06Z6lLteVGiK/+HQ
 BlNIPnpJbfg2vhHVERz7tu5zH+at0eer76PqDQv9f3dVTO5I13l6kNLRpsMAEoUT0fPo
 yaJKwFRwUC3a5NqbRT0dA0IRg74YTG2JM0Xmfbe2SJ1BtH2d3n1BzCHNWkV4fy0zsS8n
 y6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737828875; x=1738433675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bl6x3NGb6owz3SHDZJmiiZ4r1za5TcxmylUs2G0w4SA=;
 b=kaL3SqoCnM+oiiXIVya3v5CGpQ8eoHc/1W67ShyOwx5t7xhPMgmdzL9Bwtgdwn61Gf
 RPihHQIVqA6GeV1mHTkDWxIgsLg6bhnjgneEf4wb37sW/Kz1l7wnkfuQUvrsKtNIUxWT
 r4rfWFTiHywmLMbXl2OKZivBKYFnC+AcmsEcVjPR3oge/FviS+GWOwcuT1gfO5SxhIs0
 KKYVUajoTlUIXZCYDzIkdskQuorMV5Mmf6FsrgVSmgvOTRufKOv5UxcDBXnl6Moy3rPQ
 whpPMLjTnPWV1w86F5k33jiiKJWarGKsGwdLMZBcuKo5T20wi7j26TLQMY6ySTaMEX+x
 dXCg==
X-Gm-Message-State: AOJu0Yz7bDND23DkFeM1ahbQxV/RyZNK5ptvokkjVu7LGA+iCHJJOPqM
 Sy/03infS9ZiI0IgnpRjIlNAfiIFUS4qcC0NilQQiybJERzM9gH5W+h2pDRXlbEpyrGzD6i7FWz
 US7w=
X-Gm-Gg: ASbGncuYzY4u4JyCt2kR4ulqtWKoPVPmTL7SI1N3DTeDK6yx7oaJPeNvt+BesUFiV9N
 M+LPHgimKG5JhiVIj+WS9tga9A32NC7Xy3ctFm+aLtvhgOgpqwtjmIrFnIjDXLe377qgLIprAwl
 PZLxu71kqaYZgIvrtdUJEGyXplUYft/A7pN7idwuP945y0v4m1mS9E72htKqX8L6/qqJTfeQTLF
 EYU0CZi9HqbENmH+6C4nf3Sm6U+hHHqDVM5eCb2OhntOhujvrjIP6TXnCv/JpJVi3ddl0AE/7xM
 ZksjyJE/ZuPLiqeP4Ro0MOMERizYbfU62DcU2/mp3HxlYL2tmZdDGWzuJXnm
X-Google-Smtp-Source: AGHT+IH6Im9WAFP62p+c65YcO9soXGrjbd4TGzQetbCmkepXX8mf8yxKvYvU59Qz1V1TA9WTvs42GQ==
X-Received: by 2002:adf:f504:0:b0:385:ecdf:a30a with SMTP id
 ffacd0b85a97d-38bf57ab510mr28008868f8f.33.1737828875399; 
 Sat, 25 Jan 2025 10:14:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a176490sm6041968f8f.1.2025.01.25.10.14.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 10:14:34 -0800 (PST)
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
Subject: [RFC PATCH 9/9] hw/xen: Have legacy Xen backend inherit from
 DYNAMIC_SYS_BUS_DEVICE
Date: Sat, 25 Jan 2025 19:13:43 +0100
Message-ID: <20250125181343.59151-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125181343.59151-1-philmd@linaro.org>
References: <20250125181343.59151-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Untested, but I'm surprised the legacy devices work because they
had a broken instance size (QDev instead of Sysbus...), so accesses
of XenLegacyDevice fields were overwritting sysbus ones.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/xen/xen_pvdev.h  | 3 ++-
 hw/xen/xen-legacy-backend.c | 7 ++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/hw/xen/xen_pvdev.h b/include/hw/xen/xen_pvdev.h
index 0c984440476..48950dc2b57 100644
--- a/include/hw/xen/xen_pvdev.h
+++ b/include/hw/xen/xen_pvdev.h
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
index 118c571b3a7..4d079e35d83 100644
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


