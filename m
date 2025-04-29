Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96214C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9lf2-0003TO-AL; Tue, 29 Apr 2025 10:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9leZ-0003As-B9
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:09:43 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9leX-0006TU-Nw
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:09:43 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so23664365e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745935780; x=1746540580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cgWjRtFl0Tqbcd4/+gPIcf2l4PP5xa+gpuaAj2NrLow=;
 b=Y838GGm3mFEK6Q7WaC5H/eNdklCYSMjUbxJGxA41F4ELmmWUxbfkwnGBHsP/3ixJWH
 DThO5mMsn1L+eMJ+POVEFJXhgX1irvx5pXnZjsMNW093oIpAPMLSgStkV0/+doj9xUfp
 /aSxr9F+0f3pNGw2nWLfjZjAWglEsGWqosl+uLhbJat+VUX7ieMmqMNFSsnZYRL+yLfO
 pcNyqlU+TTUVXxjijbSK/YcZMEKpfUOKPvF4+0V/lXX9NdYly4QWFQ9vNQDRYXckslHk
 kM0L5ne1hgvSXyfLiaER6b8jmQy/tLwIpJJUAnY05zf9/QafC9aM2rx/5PtItCxTFru6
 kr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935780; x=1746540580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cgWjRtFl0Tqbcd4/+gPIcf2l4PP5xa+gpuaAj2NrLow=;
 b=wUfx8TDFNPyDRzyeTBkLT6bT51WcPsGfhMMVIxlgApVvtOGnKxq2wQ3Rhxjx6oGCDZ
 YT0PA1FS0/ItqmFI1kpqFya43eHxOw743NRQEsR5/WbLmJfmx7k27ESbC0ngG8b6j0P6
 XKi3SdSoSvdS1bXSEdmpbX7L+0Pti0NHSqwnB4357vFKkXQroyVjPF+hrrDTlk2GEUXB
 7E/K8YV5Y/+nnHORDZkd1yvNOt4QHqhkQtQszBq7vI23IBG4jXYkC/hFTgTrpZlM4g7s
 HdVwDJlWDstemoaHAaHtXggADDd1zOhGdjUlOSorgbKyA7X9/mqD9OGY7sbeEMMUIRTn
 Vs0g==
X-Gm-Message-State: AOJu0YwFy29u/qZVoCUwAVP4szf1DSi9kKxkbO6MNjrA9yhMf0XrJ8KF
 73uPOe4YuSEc9clqpHmh+Z/GUsZs5Gqxvkd+89E1Mr5iE4wXZUW7UzNOR2qt4b3W1H2HL1t8y+t
 P
X-Gm-Gg: ASbGncsRGQd8J1D1TBckMt4gWwgv02t9MDhv68hW1S1LJUHZ/gt0OlcNjj2iyvSGoWt
 An4l4kKXL2LwazLGTJicey2PcYvXSs1TivhtJ64HDdQesxlRX4qJ3c45DlwTkfIL7QQ/fZBui3r
 P1R/Q5N3hlRWcJZCsaCA3hrpGlop/QI/qgCkKO5vpTHuAAejvMcpe1YbUTpBcOf8uld7Jtl9vK8
 iOGDJoPf7Yu/maAJ8PBNXILkjVQByoyHK+JpmHyDTPFtcouFDc2x2bY1THkXLafdoiV75ayztno
 JvQQaFU4W3kOjDBJeO7/bvTTzJ7QJmtanKoHnis69wNyk63XdqKeSg5TBL1DNbZF2h5sexymwGr
 PDJS4Q8UuvaJyMru9LTgt
X-Google-Smtp-Source: AGHT+IEyWXukeI+Pl5W22LKIsZz5SJqar6L1PSi+oMoZ13+hLI2v4xf8Dl64BDyxeCtUv8HLak6k/g==
X-Received: by 2002:a05:600c:b9b:b0:43b:ca39:6c7d with SMTP id
 5b1f17b1804b1-440ab782a91mr132704845e9.3.1745935778149; 
 Tue, 29 Apr 2025 07:09:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073bbeb5esm14012581f8f.0.2025.04.29.07.09.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 07:09:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 14/19] hw/scsi/vmw_pvscsi: Remove
 PVSCSI_COMPAT_OLD_PCI_CONFIGURATION definition
Date: Tue, 29 Apr 2025 16:08:20 +0200
Message-ID: <20250429140825.25964-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429140825.25964-1-philmd@linaro.org>
References: <20250429140825.25964-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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


