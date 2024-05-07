Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C937FC25B5F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 05:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4DIR-0004Wl-6k; Tue, 07 May 2024 01:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1s4DIM-0004UM-Ux; Tue, 07 May 2024 01:23:19 -0400
Received: from mail-sh0chn02on20711.outbound.protection.partner.outlook.cn
 ([2406:e500:4420:2::711]
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1s4DIJ-0005li-PL; Tue, 07 May 2024 01:23:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLuBxFu6DXJpuhw5Z2L9F932AMyt6TdKC5SyfPTB02AB/8LllcDizSwmbr+IMY/fU9gC/qaH5RyYtzFPfGLY+BK/BJgzUqG98ziSPR7liTvC1ux+zEre+yozZMDp2uMVBflngDjOkt976ORVS8tptdnSP23JuOgODT50QphM2+wSLQq1ysnxGnPWwXLYsVD2f+ckg/YLzmJEui7qqk0cz1HAiNonysm87OJeRii1E0TBa4P2kGreCvdBqnhGGOYh7ZiCmSwiDvH3HXg2JqCwsQKqdpkndTCzlyc1Lh5zR7jfg4gy0wdVFo47CY3ViSbmXgLUD61XlVTpORrIlvOv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8G9tManfS2lIwAnEIGINpz7Ro4cJX/jlHdHelYzDFI=;
 b=brIBcDoIuNzS43srpMtNlJ46lpQD92GtLUpGYSxwePnq49eMq8EN42YCYry5FWv7M2P0oVXWrC19tTZDnvxMqZxVTEyXOW0+Qh0zHEb0FPC9t/c+fm671WjA6g9ngIYpskPWY7JF34JZvxu/+5fFO2AyHbManibi5P5vH6/B5VxHBS06rhZaiGRYF97lAZ6CR/NtXkwK5zz3sicUXSSwiQrXrCHdGP6ycnNNzeQMFdqvOsO1x2dZKamfJ7+emCfvzsdjlB+MTAKb1ztSa6ss+FwDHQGtEuYueFqzPUa4EHTbum4hHqUqOXtgHGi/Ua5QJUJS92LKMjlrlZmvap7ovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB1072.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33; Tue, 7 May
 2024 05:22:37 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::e604:661e:e939:4c87]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::e604:661e:e939:4c87%4])
 with mapi id 15.20.7472.044; Tue, 7 May 2024 05:22:37 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, jeeheng.sia@starfivetech.com,
 shannon.zhaosl@gmail.com, sunilvl@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Subject: [PATCH v2 2/3] hw/acpi: Upgrade ACPI SPCR table to support SPCR table
 version 4 format
Date: Mon,  6 May 2024 22:22:11 -0700
Message-Id: <20240507052212.291137-3-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507052212.291137-1-jeeheng.sia@starfivetech.com>
References: <20240507052212.291137-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0024.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::8) To NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1278:EE_|NT0PR01MB1072:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d206f5-2329-41ea-614c-08dc6e55b58b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1geG2U+lAlZbizddr7JsuOuBnqkvZjNjw5bZeAzMk/DiZAVbP5RDOjKq37KhrQwR+J/M+IKi32wj410SXhCcRo3tnl6o5ZxnkyFZYOxQaiQO5WG9XvEg8C3IVrHv4QL9HjjmoMbmRPfbeO8/J6XYJvpRkZiQpRu7pKQj81eR6VCRthH7Bq8p9hqWMHR1SYa+SaLFFdM5gPusKkemFbZSn9iUhd1xOl2TQWssqhhH7r6Knql+Zq6zPf5au2g8Sj8BH01PojUbTrlZiKCmKHPLMtemgw03yxtkOav7wAgoi/fx07SpsQLQG8D9zYA5fyk+66mAYY+1UC6j0Yj8S38D7+ON1d58akgiet9JjcvJmNwYK53Kt6ErAZrCr+q6T8CPype9T0bVhnwiu5ifw1UWE2YeWlYkU1FDV4hkaxuKf4dfTQEQ0HPcfO7SBXW+/GPy8xEYJH3a2kb0TL103HuH1sK37NSOwSRUa9SJC0eet67kBIxN3qZteaeOB1SLyZ81xH6F3HoB1vItjeXVL8d6rGiMk2qV0m2//FqWpmzCC0YaFDxpmKBO+3cxa8+FKwBEDfW1opsUn3KwCrMEEW32xz9Gyak2GXX3Yif8OpstV2HBLE+vYcUi0SWRjzFn8Yi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(366007)(52116005)(41320700004)(7416005)(1800799015)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qaNH4x8t7qfO1AfcUBcEX0f42W6wPE4sCU0yNs3eyGKaZ6gsuQ01Jw3LS3HP?=
 =?us-ascii?Q?wtlcGSSU5B3lPACwRFxZccOUJ3Q+D2y53Q+qy+22pfQp63nGbHAY/dyqLA0R?=
 =?us-ascii?Q?uaD8LSix4YmNR7DaDzubl+9BvTeiAdDUA6vEDjWttJ8wIIGzNhZ33dgOR5lw?=
 =?us-ascii?Q?2wBGikAHhW6uAjwoR5leAOcAB6vQ5vsXp9m8Djcd/cNKTV5ohh3iDstuKR/q?=
 =?us-ascii?Q?6TlUrxiyRdwD83mxBeo0MO9wuOnlnsF02ccy7IRdffR/yx8GWzA3/eYj8DMt?=
 =?us-ascii?Q?AW5wHX9Uvi5EoknB8b7vt9R1QcAoyUFqUiaIOsKJf+muu6hZCoRqji0GfkU6?=
 =?us-ascii?Q?84vGR8r7CvZ/kbcW0bTWlrbsh/RI+uhRtjNmt67oRVHqaO8A4yhE16YeAaBe?=
 =?us-ascii?Q?hsLdMYpSGkaQUwOIUPKjmhNwtTGi1cGkTX1c7o0cfWxQOrNya6WWfVxmKmgy?=
 =?us-ascii?Q?Pco+YoRskQqioT9TOam8+WplFC8axxdNUmoW3RMhRVKoe/+yk7CAwzIReybg?=
 =?us-ascii?Q?mzTR/XHYi3nhFRjg+QRQqL9wSvTIsPrXHeqhw6aUquF2gXf6qlz0UuZ7ANNH?=
 =?us-ascii?Q?zXeDFiE0PYd3Y1Jbt5/n3vI3Sg8pktjTaVW0SecxXVeAgOKwWpm1jLusvVu3?=
 =?us-ascii?Q?6B1bsNfvwzDHxoI5kE9OJRpmMwlTeiRW7igucux7k7xg0JfvyRl/0/7SBYfL?=
 =?us-ascii?Q?exYt2Yd3PJVtBD7XoYKb3A0hLjkiTmuMdlWAz5mB595VWAL3sbP3+LM7K5b/?=
 =?us-ascii?Q?fbc4Lit0cA+NXMSNSL3WuRFG7flGbFglsrVkRHhjaCU/48cR4bX79+bzub7D?=
 =?us-ascii?Q?VcVWcCVddA1E4Hv6fpxqvZPnm9HVri/MSBShxh3nby8c/xvm9YtPmd5WqjOl?=
 =?us-ascii?Q?kSj8+OONT3wVrKD39FXeT/6aoqCjaeTWMhXGgUGR9CUl7VaszlEnBmkua3+H?=
 =?us-ascii?Q?k2SjX8V317K0MfbqLUlG85h350tMVBwm8wQvEBlcPCsJ+4h+AIAIrcki/IAR?=
 =?us-ascii?Q?vD1mjl8FAHYK3/y/QlwEJaNsdHwP9nLy8Hwua8vQsQ7ZWOVw25iRqgfPkMzz?=
 =?us-ascii?Q?8e/oDKMilEr8Rzdk8gqav07NbidDuQ+C9ug2pYpe06yi0tKS9EGQG21rBxku?=
 =?us-ascii?Q?NLZpGhGgkQxOU4Lu61rddehbOl7clbwoNRgWJNbeT9PXshlnbXlmuHBKz7g/?=
 =?us-ascii?Q?t8XHMb4/ppcXAisEI5qwzmYQy1MbY+VZcwMGb5qLGK+TZ8TKrlcqSegkdJQV?=
 =?us-ascii?Q?UIXIRo2Or3QLnaH30riRLQ5C46e8pkdKelO69M9iKwuigb03lkSgDls+HmY9?=
 =?us-ascii?Q?dlGkzLJc33nzwUF0RHogTx4+Hyc1c1OppNw7qV41uRXH2e/yNEH3iUBb1ogL?=
 =?us-ascii?Q?7UxXtDpj2AY1hBJcM3FGWQII4OiVNZyGMQMb0aNwTTdpgceVCTHaccB4L+S4?=
 =?us-ascii?Q?lrorKThh5Pp4f/U6btQlod6XLdXVfCNBem4YxMW76q0T65EPyTpXA39Pv9Cb?=
 =?us-ascii?Q?pPIGLYd2I6UPpeaQsEVfPS+guepFgvKceFGwJJ6XUt00yHJnGu8aPc9tRlv5?=
 =?us-ascii?Q?vYkX46Eby4p6SZ1RuNwv2YpX2rTmqLyumX6HyJQ6ognqjSfnWewZy+lPHxqg?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d206f5-2329-41ea-614c-08dc6e55b58b
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 05:22:37.8163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oir9W4hgrjbmdt2q39ER0NhJOMTdRSqTur77m8gk/39m7sFu6qcprn7jiet66PunxqAkMpxlVgxtk3rC5jFALxWeTZNSLJvDKNAFxbg4nBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1072
Received-SPF: pass client-ip=2406:e500:4420:2::711;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Update the SPCR table to accommodate the SPCR Table version 4 [1].
The SPCR table has been modified to adhere to the version 4 format [2].

[1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
[2]: https://github.com/acpica/acpica/pull/931

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
---
 hw/acpi/aml-build.c         | 14 +++++++++++---
 hw/arm/virt-acpi-build.c    | 10 ++++++++--
 hw/riscv/virt-acpi-build.c  | 12 +++++++++---
 include/hw/acpi/acpi-defs.h |  7 +++++--
 include/hw/acpi/aml-build.h |  2 +-
 5 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 6d4517cfbe..7c43573eef 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1996,7 +1996,7 @@ static void build_processor_hierarchy_node(GArray *tbl, uint32_t flags,
 
 void build_spcr(GArray *table_data, BIOSLinker *linker,
                 const AcpiSpcrData *f, const uint8_t rev,
-                const char *oem_id, const char *oem_table_id)
+                const char *oem_id, const char *oem_table_id, const char *name)
 {
     AcpiTable table = { .sig = "SPCR", .rev = rev, .oem_id = oem_id,
                         .oem_table_id = oem_table_id };
@@ -2042,8 +2042,16 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
     build_append_int_noprefix(table_data, f->pci_flags, 4);
     /* PCI Segment */
     build_append_int_noprefix(table_data, f->pci_segment, 1);
-    /* Reserved */
-    build_append_int_noprefix(table_data, 0, 4);
+    /* UartClkFreq */
+    build_append_int_noprefix(table_data, f->uart_clk_freq, 4);
+    /* PreciseBaudrate */
+    build_append_int_noprefix(table_data, f->precise_baudrate, 4);
+    /* NameSpaceStringLength */
+    build_append_int_noprefix(table_data, f->namespace_string_length, 2);
+    /* NameSpaceStringOffset */
+    build_append_int_noprefix(table_data, f->namespace_string_offset, 2);
+    /* NamespaceString[] */
+    g_array_append_vals(table_data, name, f->namespace_string_length);
 
     acpi_table_end(linker, &table);
 }
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 6a1bde61ce..cb345e8659 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -428,11 +428,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
 /*
  * Serial Port Console Redirection Table (SPCR)
- * Rev: 1.07
+ * Rev: 1.10
  */
 static void
 spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
+    const char name[] = ".";
     AcpiSpcrData serial = {
         .interface_type = 3,       /* ARM PL011 UART */
         .base_addr.id = AML_AS_SYSTEM_MEMORY,
@@ -456,9 +457,14 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         .pci_function = 0,
         .pci_flags = 0,
         .pci_segment = 0,
+        .uart_clk_freq = 0,
+        .precise_baudrate = 0,
+        .namespace_string_length = sizeof(name),
+        .namespace_string_offset = 88,
     };
 
-    build_spcr(table_data, linker, &serial, 2, vms->oem_id, vms->oem_table_id);
+    build_spcr(table_data, linker, &serial, 4, vms->oem_id, vms->oem_table_id,
+               name);
 }
 
 /*
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 0925528160..5fa3942491 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -176,14 +176,15 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
 
 /*
  * Serial Port Console Redirection Table (SPCR)
- * Rev: 1.07
+ * Rev: 1.10
  */
 
 static void
 spcr_setup(GArray *table_data, BIOSLinker *linker, RISCVVirtState *s)
 {
+    const char name[] = ".";
     AcpiSpcrData serial = {
-        .interface_type = 0,       /* 16550 compatible */
+        .interface_type = 0x12,       /* 16550 compatible */
         .base_addr.id = AML_AS_SYSTEM_MEMORY,
         .base_addr.width = 32,
         .base_addr.offset = 0,
@@ -205,9 +206,14 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, RISCVVirtState *s)
         .pci_function = 0,
         .pci_flags = 0,
         .pci_segment = 0,
+        .uart_clk_freq = 0,
+        .precise_baudrate = 0,
+        .namespace_string_length = sizeof(name),
+        .namespace_string_offset = 88,
     };
 
-    build_spcr(table_data, linker, &serial, 2, s->oem_id, s->oem_table_id);
+    build_spcr(table_data, linker, &serial, 4, s->oem_id, s->oem_table_id,
+               name);
 }
 
 /* RHCT Node[N] starts at offset 56 */
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 0e6e82b339..2e6e341998 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -112,7 +112,6 @@ typedef struct AcpiSpcrData {
     uint8_t flow_control;
     uint8_t terminal_type;
     uint8_t language;
-    uint8_t reserved1;
     uint16_t pci_device_id;    /* Must be 0xffff if not PCI device */
     uint16_t pci_vendor_id;    /* Must be 0xffff if not PCI device */
     uint8_t pci_bus;
@@ -120,7 +119,11 @@ typedef struct AcpiSpcrData {
     uint8_t pci_function;
     uint32_t pci_flags;
     uint8_t pci_segment;
-    uint32_t reserved2;
+    uint32_t uart_clk_freq;
+    uint32_t precise_baudrate;
+    uint32_t namespace_string_length;
+    uint32_t namespace_string_offset;
+    char namespace_string[];
 } AcpiSpcrData;
 
 #define ACPI_FADT_ARM_PSCI_COMPLIANT  (1 << 0)
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index a3784155cb..68c0f2dbee 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -500,5 +500,5 @@ void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
 
 void build_spcr(GArray *table_data, BIOSLinker *linker,
                 const AcpiSpcrData *f, const uint8_t rev,
-                const char *oem_id, const char *oem_table_id);
+                const char *oem_id, const char *oem_table_id, const char *name);
 #endif
-- 
2.34.1


