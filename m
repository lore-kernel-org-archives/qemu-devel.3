Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92685C0218E
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 18:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbkfv-0008Mi-Ut; Sat, 25 Jan 2025 13:14:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkfk-0008EW-OU
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:14:21 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkfj-0004Gj-70
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:14:20 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso20968885e9.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 10:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737828857; x=1738433657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w1nS9BzjJB0tn/0Fa9F2b1T3lbd2oKgl5iwd0JMSerQ=;
 b=epudOJvkry3DP3vuXPUI1Gx6j9ZZuzMNSw/hYCX8weYBI4SWvyvoUGSSQ1n4Tm3You
 2hTLaRpvuaojKn2gjuTLJtOf2pfCBvrTC4BjHozD31uGgYmgYL/XB+F76FWK4nnQOQOB
 UeidpPLLjPRY0aDNTcdVGHfPaelDOIRuhHFkeymL2zfQfLBb79hYhIra3CBN0wo6sNoI
 vMX2Rxn+bOUeJiz0Uav6bCy22KemTV6clFd5l5R3NWQR0ouOX7qkgh+WDR6Xco00ppNE
 tsdn1g9i1+pMgj6PmSAjqT0dTQLcpScshof6u1rf8IwbuISweA9gZ1jDjJZK2vPs/or5
 tAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737828857; x=1738433657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w1nS9BzjJB0tn/0Fa9F2b1T3lbd2oKgl5iwd0JMSerQ=;
 b=pRL/VYLMFYo266PFh7xy61tRrCBr/uPywXWmaeHlIjwsoYDw1WVDk6WqrJScfKt44V
 u76Hn/s8kUONqkYFTKceXBIW2FpvrilJcRQTbg/Q4JAU9k/py9Z/qyCcgOEd3gyra8xh
 jY+1NtXz0Zj07oqvncKFlXdkmoyor2Woh4ge2gs8F50wrXTkfpRZyM9YIGGNxCCus5T9
 YwHdE/Cb6rN1QC0cCCUI11IXKVnNR7XDl1LJ7gZMBN2riLvbP3IwVisYI8QRbMBZnUYf
 9V7m/Qb1uOkTZpwBVSKmQ1nBlc92eacuQCesNf9S9eMipzdj+SlKJOggRVXzZxxey0TJ
 UZgQ==
X-Gm-Message-State: AOJu0YwmhAJxT9wxCeMzFJxCS08vp8uNMHM7UcU1gkilYzXwuU0roZ0Z
 wtFA+IWbB1Y88RjvbzKA3KndezEuoWZ0/+VkRzfphf5lOfmhKWVxNSkZQi8abDwEV4n0Lsb4Gxv
 Jy2M=
X-Gm-Gg: ASbGncspGNGv1cljPs/qS6ZHLHiu2NgpWv0arenJHJandLzXJvc8qsbcOIa4Uvcdia6
 rv3fbSwW+zAPRKSfL9JliNCx48axn8JwFva/4zKnTUQ6yAnqNLRZ4Xm70h2KFJBrnCdwRrHz5vQ
 365TdSLMdEg3iaKbp7T7dwoBYYl7L1dntMte79MRv/rLJXCgXDOfCy8t9fI6wvYxH+6sAEcO8Kc
 7XiCo1pfXEQmXNu9voLDIkNp5o9NXYMaIBtch5IfYJ46OpXT5VEFJRhnWBn42VYxcSIUsG9auOX
 hpw9PfoQnO2n/729WM8l1tFH1h+79ZhT5q8XTulTNXYXk79LJsGiH3tc/Oah
X-Google-Smtp-Source: AGHT+IE5XUCSuHVVDMagGbiF8o/U1zOarBMIVGYFxMB07VQ6SArrPMMpgZuB4UE+b0bVMHzNNBLvMA==
X-Received: by 2002:a7b:cc8f:0:b0:438:a214:52f4 with SMTP id
 5b1f17b1804b1-438a2145332mr233337725e9.25.1737828857490; 
 Sat, 25 Jan 2025 10:14:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd54c066sm67839795e9.29.2025.01.25.10.14.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 10:14:17 -0800 (PST)
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
Subject: [PATCH 6/9] hw/i386: Have X86_IOMMU devices inherit from
 DYNAMIC_SYS_BUS_DEVICE
Date: Sat, 25 Jan 2025 19:13:40 +0100
Message-ID: <20250125181343.59151-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125181343.59151-1-philmd@linaro.org>
References: <20250125181343.59151-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Do not explain why _X86_IOMMU devices are user_creatable,
have them inherit TYPE_DYNAMIC_SYS_BUS_DEVICE, to explicit
they can optionally be plugged on TYPE_PLATFORM_BUS_DEVICE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/amd_iommu.c   | 2 --
 hw/i386/intel_iommu.c | 2 --
 hw/i386/x86-iommu.c   | 2 +-
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 6b13ce894b1..e8e084c7cf8 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1687,8 +1687,6 @@ static void amdvi_sysbus_class_init(ObjectClass *klass, void *data)
     dc->hotpluggable = false;
     dc_class->realize = amdvi_sysbus_realize;
     dc_class->int_remap = amdvi_int_remap;
-    /* Supported by the pc-q35-* machine types */
-    dc->user_creatable = true;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->desc = "AMD IOMMU (AMD-Vi) DMA Remapping device";
     device_class_set_props(dc, amdvi_properties);
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f366c223d0e..7fde0603bfe 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4871,8 +4871,6 @@ static void vtd_class_init(ObjectClass *klass, void *data)
     dc->hotpluggable = false;
     x86_class->realize = vtd_realize;
     x86_class->int_remap = vtd_int_remap;
-    /* Supported by the pc-q35-* machine types */
-    dc->user_creatable = true;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->desc = "Intel IOMMU (VT-d) DMA Remapping device";
 }
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index fed34b2fcfa..5cdd165af0d 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -146,7 +146,7 @@ bool x86_iommu_ir_supported(X86IOMMUState *s)
 
 static const TypeInfo x86_iommu_info = {
     .name          = TYPE_X86_IOMMU_DEVICE,
-    .parent        = TYPE_SYS_BUS_DEVICE,
+    .parent        = TYPE_DYNAMIC_SYS_BUS_DEVICE,
     .instance_size = sizeof(X86IOMMUState),
     .class_init    = x86_iommu_class_init,
     .class_size    = sizeof(X86IOMMUClass),
-- 
2.47.1


