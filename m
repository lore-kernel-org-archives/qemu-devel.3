Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0612D6B086
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUaw-000170-CT; Thu, 29 Jan 2026 11:10:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUag-0000KK-If
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:55 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUad-0006fM-5D
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:54 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so1105565f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702986; x=1770307786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eMcVG4md74Ay1zuipzEe30vEGwsgGydjvAvH9T9QNys=;
 b=OfrBITATczyszCrhoxRt1gF4H1RnFVK7ZIN9iRLnfNTeV+/up0kzGjH1JZTXcO1dDa
 nlcaICTAnNsC1iCcUOlmtcdIOuCTiq9yPKulj6/AuzRsIH3slEWg/UQAZHZNSKdXpWYO
 +SA94XlPoKPM80NwUo6CnbC/kYziZiVGqdsYrQtpaS+3xXbeNwUZIYRCALBoE1a3RU/t
 DOWxNzzUS8cXjXSqU8v4jlU3eVnqq/zwcFdQDYf/Kz2rRCzL2zMpMDIuGbLq0dzOE+WO
 vBTRXJEdowOj56xbb2dpZmItbbglRsmBKtay1y59AU6UkqnyfQEa5ICMoQ/sKr0Ml16M
 7PXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702986; x=1770307786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eMcVG4md74Ay1zuipzEe30vEGwsgGydjvAvH9T9QNys=;
 b=jsbt1ckUia1bRPgmNBCofDOFiC5s1OLST5UxU3IRVDuYWYf1/ptSA+s3GXZcLbc9JZ
 kYyyqG16fDyHlvTWD3zvwvVZHVdfptRIJ2LTxg9hbN0Lp7b0X6mRZti68WE84Hzn3SKj
 +w7FwkDE680LzQlQ7TH0pKeYBbN8FcifQn+wE7NWceP1ILpAk3TmDf+fh4alFF/OimUR
 UbaSp7Q7WIwyspWBIr6Tp6ENbZ34Rlt22Y6OWgnenYjghSWKFOjrkY93eJCNDZ3Z7+JT
 MvvoJqQDTCxd+ae9ZHh102UudKGczvOaNoxtc2ZUxlBMc01v6AadFq1YKiwkdiZGEKaz
 sSmg==
X-Gm-Message-State: AOJu0Yz3RwNlFUMUVWuzmJmAxXoigqB9Dfz1k4e4rv4PhHDlz/LjmcFx
 50R/Ch+qkOCE9rTgi9YGVuLr5hgRCybCju/gyfybAQWYdyV9pKTtNnWRY7f1ucRX8JLgmrBa/TG
 2B3XaR3A=
X-Gm-Gg: AZuq6aLcJ/g7zYYZtgTw8eYmYdl16mBjU4PBqsinCWDr2KskkcJPMCOzN/zJ6EOnMKl
 aSFyzuf+JmDVkgXVL6mQD3oGwye2pXp6s2zMOWRpzUxDoCMK+P/zuX4hTFN3ljJfsazVm7KDAg8
 Y/L7E5YOAQcFBr3O+wAoaXVg2+CuCMMB66egsyHf76fEYlzRgIwDyAfKNzM/t1Llyd9tB7C+5wg
 3PDvO7c03hXljX1j3aLfK8t7CYVWNjGmLlAwNIxeFAJUbM3aRLWyuI6mu0AOMRRf4wy+78miBSz
 Ft54eCpIa8/qeEzRXY3saJoQc7TJAtCTzefhNHM0sZd5HHkkJ6gZAWNxxQXO8GdL86+4OzUXIpr
 D8H5+q4VrXIUQAnoWKjo+P2Rdw/J+2PsR/9tPt/JpD1yuYl+v9OfI3TExqiFR5+KZfLbUiJ2EGi
 OseQIJ/FPQio6lj2cNcDG6kNFJgWf2UA==
X-Received: by 2002:a05:6000:2489:b0:432:5b81:483 with SMTP id
 ffacd0b85a97d-435f3a9244bmr171355f8f.24.1769702986073; 
 Thu, 29 Jan 2026 08:09:46 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/43] hw/pci-host/gpex: Allow to generate preserve boot config
 DSM #5
Date: Thu, 29 Jan 2026 16:08:56 +0000
Message-ID: <20260129160917.1415092-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Eric Auger <eric.auger@redhat.com>

Add a 'preserve_config' field in struct GPEXConfig and, if set, generate
the _DSM function #5 for preserving PCI boot configurations.

This will be used for SMMUv3 accel=on support in subsequent patch. When
SMMUv3 acceleration (accel=on) is enabled, QEMU exposes IORT Reserved
Memory Region (RMR) nodes to support MSI doorbell translations. As per
the Arm IORT specification, using IORT RMRs mandates the presence of
_DSM function #5 so that the OS retains the firmware-assigned PCI
configuration. Hence, this patch adds conditional support for generating
_DSM #5.

According to the ACPI Specification, Revision 6.6, Section 9.1.1 -
“_DSM (Device Specific Method)”,

"
If Function Index is zero, the return is a buffer containing one bit for
each function index, starting with zero. Bit 0 indicates whether there
is support for any functions other than function 0 for the specified
UUID and Revision ID. If set to zero, no functions are supported (other
than function zero) for the specified UUID and Revision ID. If set to
one, at least one additional function is supported. For all other bits
in the buffer, a bit is set to zero to indicate if that function index
is not supported for the specific UUID and Revision ID. (For example,
bit 1 set to 0 indicates that function index 1 is not supported for the
specific UUID and Revision ID.)
"

Please refer PCI Firmware Specification, Revision 3.3, Section 4.6.5 —
"_DSM for Preserving PCI Boot Configurations" for Function 5 of _DSM
method.

Also, while at it, move the byte_list declaration to the top of the
function for clarity.

At the moment, DSM generation is not yet enabled.

The resulting AML when preserve_config=true is:

    Method (_DSM, 4, NotSerialized)
        {
            If ((Arg0 == ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d")))
                {
                    If ((Arg2 == Zero))
                    {
                        Return (Buffer (One)
                        {
                             0x21
                        })
                    }

                    If ((Arg2 == 0x05))
                    {
                        Return (Zero)
                    }
                }
         ...
      }

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20260126104342.253965-23-skolothumtho@nvidia.com
[Shameer: Removed possible duplicate _DSM creations]
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pci-host/gpex-acpi.c    | 29 +++++++++++++++++++++++------
 include/hw/pci-host/gpex.h |  1 +
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index 4587baeb78..d9820f9b41 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -51,10 +51,11 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
     }
 }
 
-static Aml *build_pci_host_bridge_dsm_method(void)
+static Aml *build_pci_host_bridge_dsm_method(bool preserve_config)
 {
     Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
     Aml *UUID, *ifctx, *ifctx1, *buf;
+    uint8_t byte_list[1] = {0};
 
     /* PCI Firmware Specification 3.0
      * 4.6.1. _DSM for PCI Express Slot Information
@@ -64,10 +65,23 @@ static Aml *build_pci_host_bridge_dsm_method(void)
     UUID = aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
     ifctx = aml_if(aml_equal(aml_arg(0), UUID));
     ifctx1 = aml_if(aml_equal(aml_arg(2), aml_int(0)));
-    uint8_t byte_list[1] = {0};
+    if (preserve_config) {
+        /* support functions other than 0, specifically function 5 */
+        byte_list[0] = 0x21;
+    }
     buf = aml_buffer(1, byte_list);
     aml_append(ifctx1, aml_return(buf));
     aml_append(ifctx, ifctx1);
+    if (preserve_config) {
+        Aml *ifctx2 = aml_if(aml_equal(aml_arg(2), aml_int(5)));
+        /*
+         * 0 - The operating system must not ignore the PCI configuration that
+         *     firmware has done at boot time.
+         */
+        aml_append(ifctx2, aml_return(aml_int(0)));
+        aml_append(ifctx, ifctx2);
+    }
+
     aml_append(method, ifctx);
 
     byte_list[0] = 0;
@@ -77,12 +91,13 @@ static Aml *build_pci_host_bridge_dsm_method(void)
 }
 
 static void acpi_dsdt_add_host_bridge_methods(Aml *dev,
-                                              bool enable_native_pcie_hotplug)
+                                              bool enable_native_pcie_hotplug,
+                                              bool preserve_config)
 {
     /* Declare an _OSC (OS Control Handoff) method */
     aml_append(dev,
                build_pci_host_bridge_osc_method(enable_native_pcie_hotplug));
-    aml_append(dev, build_pci_host_bridge_dsm_method());
+    aml_append(dev, build_pci_host_bridge_dsm_method(preserve_config));
 }
 
 void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
@@ -152,7 +167,8 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
                 build_cxl_osc_method(dev);
             } else {
                 /* pxb bridges do not have ACPI PCI Hot-plug enabled */
-                acpi_dsdt_add_host_bridge_methods(dev, true);
+                acpi_dsdt_add_host_bridge_methods(dev, true,
+                                                  cfg->preserve_config);
             }
 
             aml_append(scope, dev);
@@ -227,7 +243,8 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
     }
     aml_append(dev, aml_name_decl("_CRS", rbuf));
 
-    acpi_dsdt_add_host_bridge_methods(dev, cfg->pci_native_hotplug);
+    acpi_dsdt_add_host_bridge_methods(dev, cfg->pci_native_hotplug,
+                                      cfg->preserve_config);
 
     Aml *dev_res0 = aml_device("%s", "RES0");
     aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));
diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
index 695886dedd..1da9c85bce 100644
--- a/include/hw/pci-host/gpex.h
+++ b/include/hw/pci-host/gpex.h
@@ -46,6 +46,7 @@ struct GPEXConfig {
     int         irq;
     PCIBus      *bus;
     bool        pci_native_hotplug;
+    bool        preserve_config;
 };
 
 typedef struct GPEXIrq GPEXIrq;
-- 
2.43.0


