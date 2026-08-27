Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3E4C5DF97
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 00:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzOBm-0005nJ-OZ; Wed, 26 Aug 2026 20:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wzOBl-0005ms-Fz; Wed, 26 Aug 2026 20:41:53 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wzOBj-0004l8-Vt; Wed, 26 Aug 2026 20:41:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVVF6SsJjfzDoAVn5AQzCiPWXKlOz1KnnF3qwSnYhOrv53Yl/TZH8U0lZMz3ubIVDHbXN7ge7DoJ1bU12d+qJut4xhMrGWMhHc39ee32WKxnERmAEvYceykzmsMuYcmut+un0C3OBpqA2N9dZCgEV41K4LxZ7At8AdQ5u6OYl9FgiZN9v2WG68BD0thP0fSmbxCqnMOlmMNFDhAQkAi+eVBtFG78AQjAWxIl2JqfFWLmuY8gIji21qtTs2qFocWkGDv1VmR432l4ImMVsDttPcrJTQY/gg3wWS82MZNutGiKGq0MwMaVSGr9zifEiRVjVt5LjNLY3BfY1qdVqsImGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Srjhx+SPolKf9relAUuL8yqTNJaPt46pyf7Munv1d8s=;
 b=EPr1Z6qWh/jRpPp03N+/3qSknpjHkw5dXkS9YxdTpwDhvZ7J4lliAbUjQK8DXGh+K+YUY5sjgA8F4kr87MXiVaCtydIIMiFF/MxiQ2xizbggHSji/+3cEyhRwyORgwpWkYIi+v64qdLuFZU6rcsCUJXJ8xiFV7of+tgfvoxva51R45gJ71Do9TMGdD5jaJFR4gpqoZYgv/KKjTOvQIP2RULFZtFe2d2leGo3nuZYILZotTwl1MU8xBF+WgwbXe8GKnrbuShRHYGV1owdha4Dk8hpNfGuEWuXpi3/N1I+GAjC/Hr2xT8OEA2+w0E3DPwHCrWy/vwP7SB6gILRfzXdSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Srjhx+SPolKf9relAUuL8yqTNJaPt46pyf7Munv1d8s=;
 b=nXns8hjvrXydXeqdHBAjgRC4IrHXd6mdBpW1Q4Ffnoq9PyA4H00Kel2+D5Hc7FqtXzjnHniQcRgDqv+vrYZYsEdytVSqNz1WDidW6mtvjA2ILL0+/wBAGbFIGYR/Dkc5xe8Rox2m28AEmv1ek1+TK88/VYAXlLxhAlJLzLKPJMQUvAzil9nuDhV1pvDdmcPOj7AECIeZd+V6TnNW7aBRqpoaExcen7Jwev2b7VFcZED9KXhsAtyb1g6DkmEUB9bexy9gmR3nsxeq9KFHHmBSDkMfMO7q0Dpnvof28s/PRHYT4eOw+gmfh39hyaFwRXGKOngae7ZenxbkvCIz7haF6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) by
 BN7PPF2E18BD747.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ca)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Thu, 27 Aug
 2026 00:41:33 +0000
Received: from DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e]) by DM4PR12MB9736.namprd12.prod.outlook.com
 ([fe80::ed33:f342:886b:dc8e%6]) with mapi id 15.21.0360.006; Thu, 27 Aug 2026
 00:41:33 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, devel@edk2.groups.io
Subject: [RFC PATCH v2 5/5] hw/arm/virt: add highmem-mmio-base property
Date: Wed, 26 Aug 2026 19:40:24 -0500
Message-Id: <20260827004024.598351-6-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827004024.598351-1-tdave@nvidia.com>
References: <20260827004024.598351-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0267.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::32) To DM4PR12MB9736.namprd12.prod.outlook.com
 (2603:10b6:8:225::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB9736:EE_|BN7PPF2E18BD747:EE_
X-MS-Office365-Filtering-Correlation-Id: 7118be92-baac-43fd-8358-08df03d3f176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|18002099003|22082099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: MYYwLQ5nq4M48VCS6GZJEXJ2RpfM8X5bRE1nWc74Fw01f42PE2XwZKvyPu0YmZvlMBxwk7+chzkr1vNFfjI+RJFw8QGMIu5x9qI1aArL39Q2AHqz9jXW228PD0bj9U+XLfF5YZ6MerXhAoIxnDN02HU26IKY5Bxnuw0yhfiTYHSzrmO5F43Nl2pPtZX0Q46ueVnBh1tlVuGyYZ67L9Jp3OFPGMDEsrbjQw7oRLVincMUGtY+a/obRw8g/qvNWSVBN8mO0aWCrdYCeVlu/YWngjMcL+aM4P0Paf5/BnlB6BYeQI5OLHaxbJY7gLBUl4VK5ZE/lirl4xETlRqAC6M6qLr+G1NWAX28qqcHp4OMio3/8mGwNVcQDtbxMYQxNXpC4//oWf5GqGAY2Ga6K/BMKFT70bRHeIW9VrkEu09UAnl69fvypVreLv/3EKaNYE4glsc+5GTlhLOlJMUB2HBzbd0aw70qX39sZylW0ysEuwejx93T5sWvgzrBwWjJ0Kv9NxsRKatFqjf6shdXCg6FbaLxwlxb0kLIE50BOvTeu71W2HrupE88o/XP+OR2WtM9zm2T8MdIpe7KejLCssee/7nFQ5PJ3mNd2T/JPF4ShhT02MQADL2dCoeP3XlGhV1J77yHvspwrn5nwNPIGwhjCgd1mWJrkBSSoewkJWNZcp8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB9736.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FIqwW+P7xPJF0IsHx4pBkzAfqNRuMYSlVLsbcQjsgUGQH0LyKFQfVhVfFZjF?=
 =?us-ascii?Q?mDT4jMF+oViUFWjD8SMd10EZvenjXeSXHCtlbB4oudYzlqk7Sykf7OFz3QHr?=
 =?us-ascii?Q?WQoNywSC9E4aJzyMfU+CaR5Xp5qe4Zcz29pzU0wEyTN9NnSET9ZFFeYvswCv?=
 =?us-ascii?Q?zcrhVVPSu4o8sCV2p74yOmL9MAM4WpcXBsqomWQa2YCfYXSXaMtFJRDDwNot?=
 =?us-ascii?Q?E+LW1Zyo+eiuXw7f2XyYwVcZUp1NBBryBLcgZo17ZI0AUgFZ47hT4DW/XAir?=
 =?us-ascii?Q?D5fwDIwo5skvKOWiM3AxV7BS1muUiAi3oD5SKPiyfuoVnJd2h0gl1XlBW/oJ?=
 =?us-ascii?Q?pI8TV79j1DzgXLMY1W2kSnOhCCH2wQJvpY+lls2u2boGh+e5M0DpKHoCmmKO?=
 =?us-ascii?Q?JLqXvGqQVb7kXHm2PvHD+mBpwg8Hn6mFWYm1lAAfRsAZolYSXRAIIpHaAYHg?=
 =?us-ascii?Q?ErjS0Liaw7mJtTBe6nZSZaarLeXYfYfqukqy1bUQgRJmnLdIUudfvxfsEsx7?=
 =?us-ascii?Q?gKyX/MoktGJ4IXz/f7gSvpVKg2gCugtQinjqiWl/VnR1QWv+NcfBitzoK8i5?=
 =?us-ascii?Q?nCAoBRus2I39pOTufJj8Ip29autvFpqiFx7O5D2ayjksaTlQ7/+Wxn5YREJ3?=
 =?us-ascii?Q?YE3O5qIKgTiOixYKARgqtUM3LJpd2Fxhn5d3x9dXOdCyE63NsMIVFbyoEjE4?=
 =?us-ascii?Q?IgSQjuWtC6VJwMk66Frc61E0l6OnPBFnNkpPlvLPrxwvHKXrVZFPh+1wLQtg?=
 =?us-ascii?Q?Aq1B/QCbu2Vf4ZA/BWV8d8G23rpQjBNufntZGp/LekYUFjMvfv47dEivTXe0?=
 =?us-ascii?Q?hhpGJbN7cUX82T4CI/SWJQETJ+5OpQrysvesaYXBrOX4wWjpe7N55TztWREE?=
 =?us-ascii?Q?1rLyPDTMeaOWfPgEQfMizjOGEWocQ54OYVA5w/8gLvzgBTSd1ljM9/r9Q4v5?=
 =?us-ascii?Q?NBAymnCapA984LPpCdOwfxKXmIR/Rmgpiy/TdGz8nMJSWS9kLskx2zFkhtUs?=
 =?us-ascii?Q?s8EiSqKIPYEp0rAZB0jrXcuBMx9HAtfKGFEe5itxEnbHj7IkYVbIv7cxQbSQ?=
 =?us-ascii?Q?oFLMKKz1Zqaup9lKa60SX0IQw60GkRjVlwmcenLQO1dCkOS06zyW1UV3As3G?=
 =?us-ascii?Q?DwN+bgAuCgPPkXnIxaCgUWbQQAiAIGnNuDYs+Adt5nZN2dmyb6jPrsB0msDi?=
 =?us-ascii?Q?AePzBceYCzcX0bcTnu0Q/iSMbNtHBFId6F6oInZSfUkxa2rm/AP89H13nKkH?=
 =?us-ascii?Q?PBGGxM6qpVD9YSAG7FMgjEXtYB20axs5y8d8ZmNAwpc+rX6MUQAJyW89yS7x?=
 =?us-ascii?Q?vemaR/hyqVPiBKRoTwRmI+D+kHdf0YJbyraUJFH3T6ehlnEA7iwsjZrGNYxK?=
 =?us-ascii?Q?5sEvVfSgPyd4+tPMBuZMlEfHxzG8BGQoBuzCBNfK0hQedsgrQZPVRBbHQaSN?=
 =?us-ascii?Q?hQAQMOQvIOIB1aIDbsYozC/gPb7Ls87pykMVwR9vBVaxxirXsp2mSoP5kQ0a?=
 =?us-ascii?Q?Ze48CTqqDJY1EGFsojfpy77HHmrBOG9jUYibKSTQMSJ9VQEKSR8tPR1rNPvR?=
 =?us-ascii?Q?MsILQ8Rd2fSt8RvOiPNlGQmP/aMGs6PYAaILFgNbwp1nqvnaLZuL/9BbOuqF?=
 =?us-ascii?Q?XSKT3muhvdbFgCLx+6pWhLkqQGNMmSw8g7DiOIYQ9gRDE+tPgZJEx3/DWw22?=
 =?us-ascii?Q?1viFBwxmh0nJeGbGyYdhhb6fFsGA/ITQBhBR+/iLBPE3B2Ah?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7118be92-baac-43fd-8358-08df03d3f176
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB9736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 00:41:33.4944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Syqm2DBnmX+1Uwg9qeOCMYegzEh5C/E4mRVYH8ab1UFuZnq6cj+QY3naSqecUZpzm9y7J2b2tbdX9nXIYzQJEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF2E18BD747
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=tdave@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add a highmem-mmio-base property to override the base of the virt
machine's high PCIe MMIO window, alongside the existing
highmem-mmio-size:

  -machine virt,highmem-mmio-base=<addr>,highmem-mmio-size=<size>

Some PCI devices require MMIO resources to be placed within a
specific address range that cannot be satisfied by the default
placement. The configured base is validated to be non-zero, aligned
to highmem-mmio-size, non-overlapping with the existing high memory
layout, and within the configured physical address space.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/arm/virt.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index cb9cd2d25c..47653b8753 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2515,9 +2515,34 @@ static void virt_set_high_memmap(VirtMachineState *vms,
 
     for (i = VIRT_LOWMEMMAP_LAST; i < ARRAY_SIZE(extended_memmap); i++) {
         region_enabled = virt_get_high_memmap_enabled(vms, i);
-        region_base = ROUND_UP(base, extended_memmap[i].size);
         region_size = extended_memmap[i].size;
 
+        if (i == VIRT_HIGH_PCIE_MMIO && extended_memmap[i].base) {
+            region_base = extended_memmap[i].base;
+
+            if (region_base < base) {
+                error_report("highmem-mmio-base 0x%"PRIx64" overlaps prior "
+                             "high memory layout (must be >= 0x%"PRIx64")",
+                             region_base, base);
+                exit(1);
+            }
+            if (region_base % region_size != 0) {
+                error_report("highmem-mmio-base 0x%"PRIx64" must be "
+                             "aligned to highmem-mmio-size 0x%"PRIx64,
+                             region_base, region_size);
+                exit(1);
+            }
+            if (region_base + region_size > BIT_ULL(pa_bits)) {
+                error_report("highmem-mmio-base + highmem-mmio-size "
+                             "[0x%"PRIx64", 0x%"PRIx64") exceeds %d-bit PA "
+                             "space", region_base,
+                             region_base + region_size, pa_bits);
+                exit(1);
+            }
+        } else {
+            region_base = ROUND_UP(base, region_size);
+        }
+
         vms->memmap[i].base = region_base;
         vms->memmap[i].size = region_size;
 
@@ -3418,6 +3443,33 @@ static void virt_set_highmem_mmio_size(Object *obj, Visitor *v,
     extended_memmap[VIRT_HIGH_PCIE_MMIO].size = size;
 }
 
+static void virt_get_highmem_mmio_base(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    uint64_t base = extended_memmap[VIRT_HIGH_PCIE_MMIO].base;
+
+    visit_type_size(v, name, &base, errp);
+}
+
+static void virt_set_highmem_mmio_base(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    uint64_t base;
+
+    if (!visit_type_size(v, name, &base, errp)) {
+        return;
+    }
+
+    if (base == 0) {
+        error_setg(errp, "highmem-mmio-base cannot be 0");
+        return;
+    }
+
+    extended_memmap[VIRT_HIGH_PCIE_MMIO].base = base;
+}
+
 static char *virt_get_msi(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -4285,6 +4337,14 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set the high memory region size "
                                           "for PCI MMIO");
 
+    object_class_property_add(oc, "highmem-mmio-base", "size",
+                                   virt_get_highmem_mmio_base,
+                                   virt_set_highmem_mmio_base,
+                                   NULL, NULL);
+    object_class_property_set_description(oc, "highmem-mmio-base",
+                                          "Set the high memory region base "
+                                          "for PCI MMIO");
+
     object_class_property_add(oc, "virtio-mmio-transports", "uint8",
                                    virt_get_virtio_transports,
                                    virt_set_virtio_transports,
-- 
2.34.1


