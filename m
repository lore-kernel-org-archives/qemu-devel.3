Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AADE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBNW-0007JM-9p; Fri, 13 Dec 2024 14:31:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMBMr-0006ft-Ai
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:30:31 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMBMl-0004ER-3F
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:30:26 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5401e6efffcso2355401e87.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734118221; x=1734723021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=af94ntL1aP0LTF1ynUhyZnJWEdtzaUCk8WuF/T+fV+g=;
 b=DhsJOCgN0GNkUIdOv/ra6++4YgPagwNnsBLurVvSbANTwZ/R20i5xU5JA4qdx6jJ9E
 PTosc/f4znHAiwEld/R363P4Xh/v7ojla/GI7C/aDQDFkEfdmiSSppwd8LEFy35+FGIF
 LMKBTUMb8p2LEJvJ6iXlAmKbFaUqjJ5c6UbaAufHCDYi0ZV8Qr98KvPHthzD0Ml6dhZm
 5WK34jYe+YJVs3Hxojpkvd538btTX3nFYp7dRpcEFlDU25BieMVzL1WHICKq2cqmCymN
 ql0tZWSzhdXt9X4yHXW2OSxSmROWCUPDlGUOSzJtpG2/bELoVfjf7DEJeoxO4MhtkgUl
 cvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734118221; x=1734723021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=af94ntL1aP0LTF1ynUhyZnJWEdtzaUCk8WuF/T+fV+g=;
 b=fcXOGauDxQXW47bXjLK/mHCOI8XBm21azgwag3rMxuNtUnWPgjzB8d5wg9be37PzRs
 h41y5HzxSiPST7BtmARAQhvR4osq+jpsuj+ClUq+y8VkuoKhbG3vLRJpHjjgDgGE6hWG
 i/pHvPe36lGgw+j9Z9G3EhE/LDGEILZXNljnP/8vVrEA+70zs2JDL0cdrWivChmTGKiX
 7DSvh0QVr4EllGg+PKgywoRb/5SvSJDWjG/pSXaKcnRe26ppCWUuGBpHv70FU3PkyHl3
 gLVTzcxDQb5XGf09alVmH5VuFluwBnOwsEiaBzfW4ayzdtaBfdJxKtNsfu/ltt71f497
 GUCg==
X-Gm-Message-State: AOJu0YwuDtMyPDV97vbHRilkBb7WGfigGPnCOMQgSJR+/CqDqDeRgTld
 LYAbGlB0ylBzR4dZJ51ST27MTFx9r+aQl4QVp8wuocm5FCb9/YT+OVRV6YfEVTJwQV8ucjuLf6U
 8CSO6X93b
X-Gm-Gg: ASbGnctUc1Dpc1uJufAXL3bbfonbvHrzk7ZCMRklmbWR9ZS3qPbIGzRh/8tpWzhNDPp
 boRFwKQGxgkQLagtDUdW4FmxGc5y8scjA+9Mz5exOB8LAi24asKJsh33ZVYyG9uDmIlzLtMkuKK
 sMy9p0IdmJcqmEU/oW9HcbPZra9JRSoZuPVNQlGST8f+1zR7DVJwWqBvUybvA6JHUvHTV7yzQEa
 wcH5AVtvcHWkZ5CZtjZl+j7v9j3+HODaZsjhn44SXG6+31inZtKXPGnWeti0g==
X-Google-Smtp-Source: AGHT+IFZJahtbpIO34rwarliyJq479V6b+7SCuRWEO589fskOqPBLdkr5T5JDUlJwmlOZKzSAaL27g==
X-Received: by 2002:a05:6512:3d27:b0:53e:1c3e:34 with SMTP id
 2adb3069b0e04-540905974b1mr1348410e87.38.1734118221148; 
 Fri, 13 Dec 2024 11:30:21 -0800 (PST)
Received: from stoup.. ([91.209.212.67]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c01051sm6972e87.156.2024.12.13.11.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:30:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:vfio-ap)
Subject: [PATCH 65/71] hw/vfio: Constify all Property
Date: Fri, 13 Dec 2024 13:29:59 -0600
Message-ID: <20241213193004.2515684-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213193004.2515684-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213193004.2515684-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 hw/vfio/ap.c       | 2 +-
 hw/vfio/ccw.c      | 2 +-
 hw/vfio/pci.c      | 4 ++--
 hw/vfio/platform.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 4013e7b436..2e6ea2dd93 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -191,7 +191,7 @@ static void vfio_ap_unrealize(DeviceState *dev)
     g_free(vapdev->vdev.name);
 }
 
-static Property vfio_ap_properties[] = {
+static const Property vfio_ap_properties[] = {
     DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
 #ifdef CONFIG_IOMMUFD
     DEFINE_PROP_LINK("iommufd", VFIOAPDevice, vdev.iommufd,
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index c1cd7736cd..b96ab27e12 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -655,7 +655,7 @@ static void vfio_ccw_unrealize(DeviceState *dev)
     }
 }
 
-static Property vfio_ccw_properties[] = {
+static const Property vfio_ccw_properties[] = {
     DEFINE_PROP_STRING("sysfsdev", VFIOCCWDevice, vdev.sysfsdev),
     DEFINE_PROP_BOOL("force-orb-pfch", VFIOCCWDevice, force_orb_pfch, false),
 #ifdef CONFIG_IOMMUFD
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 14bcc725c3..93aca850e3 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3354,7 +3354,7 @@ static void vfio_instance_init(Object *obj)
     pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
-static Property vfio_pci_dev_properties[] = {
+static const Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
     DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
     DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
@@ -3451,7 +3451,7 @@ static const TypeInfo vfio_pci_dev_info = {
     },
 };
 
-static Property vfio_pci_dev_nohotplug_properties[] = {
+static const Property vfio_pci_dev_nohotplug_properties[] = {
     DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
     DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
                             ON_OFF_AUTO_AUTO),
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index a85c199c76..766e8a86ef 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -629,7 +629,7 @@ static const VMStateDescription vfio_platform_vmstate = {
     .unmigratable = 1,
 };
 
-static Property vfio_platform_dev_properties[] = {
+static const Property vfio_platform_dev_properties[] = {
     DEFINE_PROP_STRING("host", VFIOPlatformDevice, vbasedev.name),
     DEFINE_PROP_STRING("sysfsdev", VFIOPlatformDevice, vbasedev.sysfsdev),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPlatformDevice, vbasedev.no_mmap, false),
-- 
2.43.0


