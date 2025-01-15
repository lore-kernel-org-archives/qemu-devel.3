Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D0DC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCkI-0003Wd-Ci; Wed, 15 Jan 2025 18:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCkG-0003Ol-Lb
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:24:20 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCkF-0003z9-58
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:24:20 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso1548885e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983457; x=1737588257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O4yl4DQEqVaBZntvaEzVkn8po7qkjcpxFpZJUic/H/4=;
 b=rqavEPYNO+nqMq/FiF6VBHsrI6YwS816ytLj9UXOmBJsBxO4h054w3M1QBfUB386Mq
 p6lncKQaS0FQgsXg7Op5m1MIvTM7Z4DCRwv9fJhR3hskjtdBf4r8Uk0x0RBu6hlT+5Ic
 nOOQqIIF3OzW++poExnr/seGO3OdnXAZCdbst+P0FUCmALrcFW75uYSL07umAyYO1mnp
 8K5VQ/JRTpyOkFDWM7KkuQ9xkIJ5dRkX9Wo7YprGZhbyDXK2o9EUt5t+SLpnp4OTyNxd
 ks+JIUsDjvL/ciWRVQIUjcZ/oA9mp+kVZzm6WjbMG3+9L7kcVL3A8cItF2Ag96ka2lPV
 FgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983457; x=1737588257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O4yl4DQEqVaBZntvaEzVkn8po7qkjcpxFpZJUic/H/4=;
 b=Z8y133xACzvCAJnRHznzf4mswPzFblsDdskEGdxfO0p+ZKQGpf9QVGeIRbnRLTAAS2
 Y5QqO9cUuKLSZL7VdNjxxOABFUvfsUsc2N8w8RYPdL/XlsetseO7ne8AdeEREj+6DUs2
 hY1Y8svBcPZFdz0hKO5YL+ubadnVUpnNTCKt1ZPQwViOwaqmzss+U/O3V5FnoWuPb/Ew
 bOMlv588rqNdzCmBuq2bdN8WSriQmARyyRuvGBejPrSC4h5YcGY+TjbDmjghSgrIuJIv
 H/uKpDQA4JKMNOHg6Azl7s1jMYfNnwOyU65hNc+hzwcH6MF0ev46J1GwmmPfAaIujcVs
 5xlg==
X-Gm-Message-State: AOJu0YwEFnuLSxGnDQitvfS/iw4iF1IyvIaqwzRbFPdp4g/dZHr0Fzsv
 xo8AlnnTwwdk2m3Z1YjU8ZL8H3+k0KJuRVy/YBwbeR+SThH4e8DrHgdHFC/r4hFyhsFlHFE3g1W
 0e7k=
X-Gm-Gg: ASbGncvvFDAl287hpssF0NtFYvriAKInKonyoDfB40XFt9zE6aKO7PWtuXsdTqa8Cr5
 orinOnsRmRs8jUJZslJvCgGfS5CQvdcwIiNJSvmJJsNVZjhXdODLN/xiiD2GhHkl1kbzUAnspo6
 wnxo+CpTslxIKIx5MrWKeBRPglAS3WvTwg/TGmhZ8jgDLYE+vMd0ZzQ/UPkmNBhADeesrbJjeul
 dl8lnBMQPoJiV8a6zYZ1E1Mzn9BdCONnXKSM8UFyi8QqKgeJdCbKtCu3kO3POf4N/hnuPRB6EBZ
 PhbohFgI4mu6G3KtfpSc9RXw2TSLWgk=
X-Google-Smtp-Source: AGHT+IEplKswGuBIKj9shlQAig/os2HBaSPBitSudUYZnXJb2uyhAqGryrnXEAd5AGce/HTsQL/I1g==
X-Received: by 2002:a05:600c:5117:b0:431:60ec:7a96 with SMTP id
 5b1f17b1804b1-436e26ddc53mr238742545e9.25.1736983457161; 
 Wed, 15 Jan 2025 15:24:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b8124sm18585770f8f.81.2025.01.15.15.24.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:24:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 16/21] hw/scsi/vmw_pvscsi: Remove
 PVSCSI_COMPAT_OLD_PCI_CONFIGURATION definition
Date: Thu, 16 Jan 2025 00:22:42 +0100
Message-ID: <20250115232247.30364-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232247.30364-1-philmd@linaro.org>
References: <20250115232247.30364-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

PVSCSI_COMPAT_OLD_PCI_CONFIGURATION was only used by the
hw_compat_2_5[] array, via the 'x-old-pci-configuration=on'
property. We removed all machines using that array, lets remove
all the code around PVSCSI_COMPAT_OLD_PCI_CONFIGURATION.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/vmw_pvscsi.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index f07e377cb88..8c793b4188d 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -69,17 +69,11 @@ OBJECT_DECLARE_TYPE(PVSCSIState, PVSCSIClass, PVSCSI)
 
 
 /* Compatibility flags for migration */
-#define PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT 0
-#define PVSCSI_COMPAT_OLD_PCI_CONFIGURATION \
-    (1 << PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT)
 #define PVSCSI_COMPAT_DISABLE_PCIE_BIT 1
 #define PVSCSI_COMPAT_DISABLE_PCIE \
     (1 << PVSCSI_COMPAT_DISABLE_PCIE_BIT)
 
-#define PVSCSI_USE_OLD_PCI_CONFIGURATION(s) \
-    ((s)->compat_flags & PVSCSI_COMPAT_OLD_PCI_CONFIGURATION)
-#define PVSCSI_MSI_OFFSET(s) \
-    (PVSCSI_USE_OLD_PCI_CONFIGURATION(s) ? 0x50 : 0x7c)
+#define PVSCSI_MSI_OFFSET    (0x7c)
 #define PVSCSI_EXP_EP_OFFSET (0x40)
 
 typedef struct PVSCSIRingInfo {
@@ -1110,7 +1104,7 @@ pvscsi_init_msi(PVSCSIState *s)
     int res;
     PCIDevice *d = PCI_DEVICE(s);
 
-    res = msi_init(d, PVSCSI_MSI_OFFSET(s), PVSCSI_MSIX_NUM_VECTORS,
+    res = msi_init(d, PVSCSI_MSI_OFFSET, PVSCSI_MSIX_NUM_VECTORS,
                    PVSCSI_USE_64BIT, PVSCSI_PER_VECTOR_MASK, NULL);
     if (res < 0) {
         trace_pvscsi_init_msi_fail(res);
@@ -1298,8 +1292,6 @@ static const VMStateDescription vmstate_pvscsi = {
 
 static const Property pvscsi_properties[] = {
     DEFINE_PROP_UINT8("use_msg", PVSCSIState, use_msg, 1),
-    DEFINE_PROP_BIT("x-old-pci-configuration", PVSCSIState, compat_flags,
-                    PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT, false),
     DEFINE_PROP_BIT("x-disable-pcie", PVSCSIState, compat_flags,
                     PVSCSI_COMPAT_DISABLE_PCIE_BIT, false),
 };
-- 
2.47.1


