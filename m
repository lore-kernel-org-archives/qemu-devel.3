Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96E3C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJVz-0003fi-6U; Tue, 06 May 2025 10:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJT3-0007yG-1u
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:40:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJT1-0001pZ-15
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:40:20 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso43093275e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542417; x=1747147217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MjppJwO3PoPneuGtrvBsUFRU7aSrgebY1jdyuvD/TSQ=;
 b=QvnUsUCFJB+HrKDHRFIZdiQo7IZWyK7Jh0orFIjxnlutMSa/R5bi7tCWlBGtrGLA/o
 i3vkMWdEfEsTJ61IDzGNhhfddvHHxEwCTT8Td817klCdfrZ+TAlYFOnRSSselCb4vSOI
 3eDOv3kOvlU8ZU97W9Hyl189fCJ8PpwTnCnvk1YVb+XkaZM53dKpSxKQsZcScwkdY8QS
 VjL2K9ULueLw3FZucTlDhpedcnK/ot5f6043crH+YlnRi+EGf1/zaaqdVL2GPGF/+MV/
 xz966IY8ufnrNTubJBq2x/DR9SkM+l+DTWgA3DmZeL42eFX9fWxVRYsvOT9+JNHJqqvB
 M/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542417; x=1747147217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MjppJwO3PoPneuGtrvBsUFRU7aSrgebY1jdyuvD/TSQ=;
 b=MaOszceIU15NmoPoH5WmLNwsbOL3AMiySVzzaLN0btKJX08QcObjCt2wLYYPl5yKRQ
 MFHQt2yLVJjgjlBA0rmHYWdxU1veuy7awYCG/5EBu9dY4Y1nPP0QMAUfVZ13tlO/w1CT
 QMacHNtyboggCdu+LA6ToN3fO/u/AXsohcs+zIz45h2y6fx2nNdgiLCz9XYvn/ILt6tm
 /JMGmAkb/v6Vc6zlNj1lsh8EWJUKaceboN2YzKdtghBLqtktYGD8bPdMsOhLyc/Dpw4b
 4GZoRHSbfb7ZVf5Ml0v9kRVHS2YCIYV77zx8VW3A0Gyn4YCWUElvTtsixYaWZ+IF0i5n
 ZlZw==
X-Gm-Message-State: AOJu0Yz7hoHBNVKWheDZrSlS0BrHZF7IAMbzzw+zQTVfPlTRyNEyFIuj
 nauhGpki7n6VWqViVZ+IE8q/nG2v669gFJRKOlQku9wSrdp4qlSb7BmRWCRgzS8FPFuL9Qc9i8d
 q
X-Gm-Gg: ASbGnctO/zQww9QXoPhdFQTPwm4BkDPZP7wqP6v5dMJ/1dUq0dC0Ke2GJwXtlxpw9Dx
 kHguMCEeSrhNlOkroobdm6fQqZAmBWxzK7Gxre1ebXeGlT6GjgrN+k23mvtiCmwZ8eS5elVeuaF
 LaEu3PObmBFph1+nQ1vljWZDihygroPBKuJoKBUi5KlRd44uh3X6LAbg5HKSsfHqhUeoWUtHmk5
 UXm45T6c+c6onHv8iruTkBBikguJK05bGaUscM7GQajGBLGFNiiwjG6UJrpGnUl1oPnQCYcA1nS
 ovKP5i8Yb6vLqf9sdd1hM/qx5Q8mfswf3MzPnptSkutJPDIpBOacXE2fEYp8s9lR2ip5cBYnv7b
 rabaQp236BtuT/7DPbeYe
X-Google-Smtp-Source: AGHT+IEXoh0ai1yyZRRU9+wK0PdOW3veVuHo/M3gbGoWgGo3XNDnwUuXtK5qWt5VOK3abrccRN6Ieg==
X-Received: by 2002:a05:6000:40ce:b0:3a0:a3f3:5034 with SMTP id
 ffacd0b85a97d-3a0ac0ecdeemr2882530f8f.34.1746542416925; 
 Tue, 06 May 2025 07:40:16 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b16f9dsm14156691f8f.93.2025.05.06.07.40.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:40:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-block@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 14/19] hw/scsi/vmw_pvscsi: Remove
 PVSCSI_COMPAT_OLD_PCI_CONFIGURATION definition
Date: Tue,  6 May 2025 16:39:00 +0200
Message-ID: <20250506143905.4961-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143905.4961-1-philmd@linaro.org>
References: <20250506143905.4961-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/scsi/vmw_pvscsi.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index d5825b67868..34de59a7cf6 100644
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
@@ -1158,15 +1152,11 @@ pvscsi_realizefn(PCIDevice *pci_dev, Error **errp)
     trace_pvscsi_state("init");
 
     /* PCI subsystem ID, subsystem vendor ID, revision */
-    if (PVSCSI_USE_OLD_PCI_CONFIGURATION(s)) {
-        pci_set_word(pci_dev->config + PCI_SUBSYSTEM_ID, 0x1000);
-    } else {
-        pci_set_word(pci_dev->config + PCI_SUBSYSTEM_VENDOR_ID,
-                     PCI_VENDOR_ID_VMWARE);
-        pci_set_word(pci_dev->config + PCI_SUBSYSTEM_ID,
-                     PCI_DEVICE_ID_VMWARE_PVSCSI);
-        pci_config_set_revision(pci_dev->config, 0x2);
-    }
+    pci_set_word(pci_dev->config + PCI_SUBSYSTEM_VENDOR_ID,
+                 PCI_VENDOR_ID_VMWARE);
+    pci_set_word(pci_dev->config + PCI_SUBSYSTEM_ID,
+                 PCI_DEVICE_ID_VMWARE_PVSCSI);
+    pci_config_set_revision(pci_dev->config, 0x2);
 
     /* PCI latency timer = 255 */
     pci_dev->config[PCI_LATENCY_TIMER] = 0xff;
@@ -1298,8 +1288,6 @@ static const VMStateDescription vmstate_pvscsi = {
 
 static const Property pvscsi_properties[] = {
     DEFINE_PROP_UINT8("use_msg", PVSCSIState, use_msg, 1),
-    DEFINE_PROP_BIT("x-old-pci-configuration", PVSCSIState, compat_flags,
-                    PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT, false),
     DEFINE_PROP_BIT("x-disable-pcie", PVSCSIState, compat_flags,
                     PVSCSI_COMPAT_DISABLE_PCIE_BIT, false),
 };
-- 
2.47.1


