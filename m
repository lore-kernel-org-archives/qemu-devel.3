Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04330CA5FE6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDLJx-0006bo-Ho; Sun, 04 Oct 2026 08:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJv-0006Zx-0x
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:27:59 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJt-0007Af-AW
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:27:58 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so8635615e9.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791116876; x=1791721676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GIQ3t9XJD46Rwmhcd95S+OSkc6Ax70k+P6l9TREEcmk=;
 b=F+rDSbjdtrn/TaYyVgcHPHmNwoADr9XE3hHsPymJ365Cz2jINxOvu5cCiiinTkUmUh
 EGfycA+ADfafADuL8JAXgKjQYFgZw6Az17gOcXHw+36dxa9V1dJONVovqQLXtoACsRnP
 jvB2EFuC2QMWkvpDPz0TDwC3PCsE6TacmOB0S1dDFgY0Fkbj/LAJiUUjx+ZJvtCTohFC
 rMTYVmWmK+lfama8ylXwkWks43KOKsAFUhSqiErzAABkcBW0eetJ9Jo3LAJ06+nA94Qv
 1y+CTDYzUvHWbW8RcuL+NcG5gGIU5FMF+P92CD78hrUkAMBp8dMlKtVW/krl+QTfimS7
 h0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791116876; x=1791721676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GIQ3t9XJD46Rwmhcd95S+OSkc6Ax70k+P6l9TREEcmk=;
 b=z2iWq3NUrxESpOYO4qD7LKtryzpA5Qi8sg1lFYh88aFIe++6rRbVYSHOzSvCfJ0m+k
 uw8DNGpTIhkvTZI2mIKVvneQRF8Czf2Lx/7l4jdYsL0Q/3RkIO30ZspZWemww3svIOe9
 dI/vn07CtaETOBeq0KsFNLOztmXLg03RogR1xL3lbV96jmQBK5PvB/68AVpAvd/9IZSL
 Ok951a66ReWgH3Zi4lymfrmjHBVaF1L4rCrElqAsL+1s5KBuMJmy9wiibgyEP0hNV2hZ
 FutUCVLmMzpSnGDXuJMJcWXSdUN3KeEhRnQJQrcZcoEtpmfrUXrZpXm/msjJpy57bXST
 l7FQ==
X-Gm-Message-State: AFuF++kzZlNJAa++5AJdDDIMugy20/fCnD/o2DVrATQMQCD/mGxLRKxb
 YuPwHqSk3kLnXQvNHN4ZRnkvAwD6nDLTVi6ZnuhwQRaXIs+IAmuyqjOfb/Q9Vw==
X-Gm-Gg: AYBFou19f41qSRc6dVjoaOyCyJSLsxirgnCqtNClF1Pk5oP90zSOyPxKXUD+L2TaYZ7
 LfgDDn33UDxqE+jQOaf1i+PSyHjMmTwhOEINBCe/WLnBGeg+VpUx06IqI+fGJ8LWRH1OVWJTnA6
 T9dWxCzZiICnuA7Am/71MBMKYRZqgv2V54TdELXzLLSA5wR13IfEENpVF477E2s7+b+PM26bV6C
 qE5yrnehasQ8bVZmTq/kIfVjHAM3nZiHR1BrQWtgp43gt1D5t3JoMLkvkI59JQmXTxKmY+kt64u
 uDi8UKjo2KPEkIFEWFMShCF94M9Td4iAQFfxwF+DWjBso/DYXTMuI6lMLWEFHrDwDKDNDWx21oJ
 2k81iZX+A4YpBx0ilE9WN0T16yNMj0SSt3fElnv+2246tNKoSwgjCfZ6EXp8O4d/f6ZH5epTrV+
 nyow/u6apWwGLU7gR/1L68Td2o2mySNCbqo0R01Rt/a5MzI0bRGbqVyhr1N3PP87ib4zbYskHv8
 F76AA65sqGGnIc8YWotYADFuk+PXykznRL0nSQdJ5H+a7tJ
X-Received: by 2002:a05:600c:1d0a:b0:4a1:6ff4:886a with SMTP id
 5b1f17b1804b1-4a16ff48af5mr21621325e9.16.1791116875605; 
 Sun, 04 Oct 2026 05:27:55 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm242319975e9.1.2026.10.04.05.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:27:54 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 15/30] hw/arm/fsl-imx7: Derive from TYPE_SYS_BUS_DEVICE
Date: Sun,  4 Oct 2026 14:26:31 +0200
Message-ID: <20261004122647.3913-16-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004122647.3913-1-shentey@gmail.com>
References: <20261004122647.3913-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset upon
machine reset.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/arm/fsl-imx7.h | 5 ++---
 hw/arm/fsl-imx7.c         | 5 +----
 hw/arm/mcimx7d-sabre.c    | 2 +-
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index a573e0dd4f..945d8c5ad7 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -37,6 +37,7 @@
 #include "hw/pci-host/designware.h"
 #include "hw/usb/chipidea.h"
 #include "hw/core/or-irq.h"
+#include "hw/core/sysbus.h"
 #include "target/arm/cpu.h"
 #include "qom/object.h"
 #include "qemu/units.h"
@@ -64,10 +65,8 @@ enum FslIMX7Configuration {
 };
 
 struct FslIMX7State {
-    /*< private >*/
-    DeviceState    parent_obj;
+    SysBusDevice   parent_obj;
 
-    /*< public >*/
     ARMCPU             cpu[FSL_IMX7_NUM_CPUS];
     A15MPPrivState     a7mpcore;
     IMXGPTState        gpt[FSL_IMX7_NUM_GPTS];
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 2defa498d3..fc5d0efe06 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -753,15 +753,12 @@ static void fsl_imx7_class_init(ObjectClass *oc, const void *data)
 
     device_class_set_props(dc, fsl_imx7_properties);
     dc->realize = fsl_imx7_realize;
-
-    /* Reason: Uses serial_hds and nd_table in realize() directly */
-    dc->user_creatable = false;
     dc->desc = "i.MX7 SOC";
 }
 
 static const TypeInfo fsl_imx7_type_info = {
     .name = TYPE_FSL_IMX7,
-    .parent = TYPE_DEVICE,
+    .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(FslIMX7State),
     .instance_init = fsl_imx7_init,
     .class_init = fsl_imx7_class_init,
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 47744e66a4..55c23061b0 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -52,7 +52,7 @@ static void mcimx7d_sabre_init(MachineState *machine)
     object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
     object_property_set_bool(OBJECT(s), "fec2-phy-connected", false,
                              &error_fatal);
-    qdev_realize(DEVICE(s), NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX7_MMDC_ADDR,
                                 machine->ram);
-- 
2.56.0


