Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9AFCD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 18:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLQ5g-0006lw-Bd; Fri, 08 May 2026 14:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wLQ5T-0006ho-9R; Fri, 08 May 2026 14:38:16 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1wLQ5R-0002b2-AT; Fri, 08 May 2026 14:38:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rI97G3liEXjcNSlX6jLZjuPcqx7mZRKXA5bNCd7/8uABHQ0DbzgREhOKq4EbwS+xiRet1QO2JOR+7utpAx5A3YpSbDrZUZxbR27tKNHD0+IOnb97ULxzqdvvOx70EmpqkPcNCBCh9O1AFc4/BOPP+ofCLXHhLT3X+PYP75SIwihuFqjNICwB7sOb02BCJu6r+qOEB1/5w4DRsI/Qh5p+cFOjJVNEpD4OoyT655CT5x72mCzoJMkI/vPn5JLSuwjRpI+f6RAcOK4sj/LT+0QvY8VFkEXTKBNnFPUEfPnIq0ZoR4kMfJlf8d/QDAZha2O93JbLxZspbwkAMdrjTAnIVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1a9TJhPNEvWPxcpxTaxPFxtgFtp645kI9A9RF51YJg=;
 b=pSrSpDZcWcKBnN6jQQAxQtLqc8ZCJSNYn3hwUNamZDr2LKhszqEhPIiWIKSgJord0YIa18k/FvcxtGOhlYjU0neVGmiuCEBwJr2aPmK6SIhjbWVAuaWRR+7odzVLLIqvOqrAMvFjpkbA0ySngkYJZTADgzlbb+SKor6ZD6ITATh+N6c4SoQ7w4lhW4TSoQa50owBPOQl5RsEy0fIgXBy+eDFJR6kSBbzwSdrwzgTm1ff+dWWoT6A77DaTi9mb2z6Qw9wXOTfr0oRf6BDXcNVG2dHXcIUzWRNsVH+vj+IYhEXNm8w3L5MztX/A0MZBBNIe5GdQRPEBPtQgchqhjy7Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1a9TJhPNEvWPxcpxTaxPFxtgFtp645kI9A9RF51YJg=;
 b=feqEb2E1s/rOB9OFvD3kmtK7n1z1WDpHDf9Ds6lwv/egWfjoW4nJmaEPowXF2fN80bYjz9JGgouM+0a/OwJbti4AP4SVhzmv0ChA2wS+2qJeqi4wXMhqp3wFq4ghdLgWAi8IsoBw9bWrHYHOKL3FJhdkK4j948OtHJUldzbLqVT5Veh96+wrY4t0ToSYyETH0C4juRdmXZgfdJlRwTKdRa11vE3KD7uUdagVbnktIueo5naWajQfuCO5ZxcrFX/vDxpi9ZoGiGGwO4+5EtVmoILxud6MSff8vLiKRlC0uGglfmO/s0x2MOZll6VRtAfVl0+ho0I+KTv43QWoklqQpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by DM4PR12MB6205.namprd12.prod.outlook.com (2603:10b6:8:a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 18:37:56 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%4]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 18:37:56 +0000
From: Tushar Dave <tdave@nvidia.com>
To: qemu-devel@nongnu.org
Cc: alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, devel@edk2.groups.io
Subject: [RFC PATCH 7/8] hw/arm/virt: add pcie-mmio-window machine property
Date: Fri,  8 May 2026 13:37:16 -0500
Message-Id: <20260508183717.193630-8-tdave@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508183717.193630-1-tdave@nvidia.com>
References: <20260508183717.193630-1-tdave@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:208:52d::14) To BY5PR12MB4179.namprd12.prod.outlook.com
 (2603:10b6:a03:211::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4179:EE_|DM4PR12MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de8b9c6-6042-4703-44ea-08dead30ebda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: GxoKxB7fpRQqfXpWR3JGb/CDaKGusN4OgSPu+OVi+CbatVBG+AXw2jpOCJxJcbBvx46sYMs15iEPmvCYY1BIVUa25sjUh8Mva/v82v5DnxH9g5CiqSCagCPZDyID9+qQ6C76mSdvcte0KUjUtLAtws+dN0+etbTcsQThftlDdONoezz+AvwbjCvAT7iT9yw3mRuXAkkjpugl///3T5OxdFMyYr5styaSacDpfOd54H4teBzXiPeVjraaNnn+NT/cyyASekevbYJxC/fyh6V8s2DjlBbExcLmWkaxnNLZgYgzTSZ6z4rdIkuPgFM00ysRLdI3RvsyGPRQIEC9bTs5NuXgoglLfA7iP+4g9TileyrKhFIwZkxaU0Px7k26KJFxF6+kir7CQJfEgF2oUCqzupej58kelZ9a439S3nGmBKdq1beLq4J2k5n3240TWzXC08uG2uVhcTJzPgwViLN9OgdRe6RwQSErhX57ZtZZ73l/PPR39VBPH2IAfbKCg05bVHdFdk5tipUZ1oSne+1NPFZZDD+ENBkJwureDRI6fXnoYII4usi5ZPzGplXw1O4C4SZOzKn8pzOuCPd0Iuj1TJzlim5oLBQksHpIikqNe6pUX+HXIf7bksjpoj81dkggL76GBysWg1PgwBiqCRFsNGJB1ACBNKYC6QJA1od6MdblznM0XlIF+gVCK0ABBkIV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UnKVJdV7U8spuyhlSHLHMSp70pdOzOg9HYAAcjDU347pP4D0fDbYpnfDTjv6?=
 =?us-ascii?Q?j2X/+5OX+vmsA7xPIrweIZWBFjwLZuYh+aOZ9E5+zsRL/+/d1N24/Djfv8eG?=
 =?us-ascii?Q?mhez3jWG7fATlhR8VQnGXxCF10tFNUJ+1PexYWqpQ/O5BMAje7wmi9YFU1XD?=
 =?us-ascii?Q?zPKgikGVXyYJlaSYbjCvmAuLbNZxRVaP7kR2/4pKYW4m3HNZOvy7Lq57tqBH?=
 =?us-ascii?Q?E+/wkD/eXtZFtWf3+aVyMAoQX5SBHf1KvYJhNNi5U4XeVaGi3hqsWAmgmykz?=
 =?us-ascii?Q?XLhM8r7ePQzBNq/9RszwkfnXpwo/KpWfBfEZ8wPyx6K+UivK3TO2n3iObwsE?=
 =?us-ascii?Q?92Fqpmp7JppflEd8tvKcJFb+zjf3fJdZ2hiLV9ri0i0o7gX7gJDtMg+cYODz?=
 =?us-ascii?Q?A8X3mpk4vWRf7kBoEOSnbMLm//txo0d+/1OAwkSp/o/TWEPl/EAqAZipNCxO?=
 =?us-ascii?Q?DXQS94UmikhpbFSYPu4a/ZnsYJssYgGeJDHwTLoaECQbrMbpuZM6QRqOLhRE?=
 =?us-ascii?Q?mfqtrAn+AnQAubqsFpWnvnLawozBxUYcsxlUiCY9ZowEOt6ch/HMT12ca4WN?=
 =?us-ascii?Q?yK5xoXI3YIB13GkrN8RU43dtjX/8W09nlHgxPjLkm/kFb7ZARmSKwcHXY+i/?=
 =?us-ascii?Q?KXZFXHbD2lMVbmdQyO5yVkISy05LSCRjJiytJX+grzIH/RbQTRxhm08CZ3qw?=
 =?us-ascii?Q?QC+BpxQH42sE6e4V0PcK0ekj26iR8qR1GoSKRr0ChH7CeJmjmIo4aoG0NxpS?=
 =?us-ascii?Q?Og7GXW00zVQm44AuZoBvHSFhq8rU5VonQ85CP5QewQPIrSg1uFQTyWTzvsh5?=
 =?us-ascii?Q?llxUW/ynzSH6tZmaKvoX9krQNYY6g62tE3mPAav8S+rY580BqDl5KOnZE4sY?=
 =?us-ascii?Q?L7qrQ1q5SgRdPgXZwzIyO3MTJrlARQh1ADtVV0I1zAFlP0jDMDxSe4lZMZsp?=
 =?us-ascii?Q?a80nvuLKUIjHKvv41Hu6aGuQeITXmzSevQLu1KGCj9xs3d+yzXVp7yHRz/KI?=
 =?us-ascii?Q?IkUwonfnmoZwZ8F6phbwJBYefptqE/B/UzUSb4iESNgdbWySnyc1yPFIHaSG?=
 =?us-ascii?Q?mGiKao+7FQx+TphilSL/GUjTlBNAmgdd8ArpWKPHXenfr8LBjP9kkbsrwOXD?=
 =?us-ascii?Q?SKZoTZGXID7EB7xlDT+w534le89fpxXblp6L5aZLZuv0onoCUTRSc5Nn2A3T?=
 =?us-ascii?Q?LOSFFu8KZL11GEZc/WH/+vWnZSNf1yi3YquP7SATRGC4JMnEBs2H/X0vKJC3?=
 =?us-ascii?Q?RmuGCKX4lIufvQbjeJrsG0My3zPI/UWXbMRIHv1cX5MU7+H4FlUCMNkvZxNg?=
 =?us-ascii?Q?+dr3ORSshavOKwq/+6zzi8jkLG9IDa1b99dcsa3hti2neUa/Zh3kVKI8CX2X?=
 =?us-ascii?Q?aNlBPecUA9Zf9o+qjNZR/b8Q9HvLC+/M4qyBqcQVbM/w6Zxwe0Rb4uDEay2n?=
 =?us-ascii?Q?OH2Wd1eaObRLYwO0JViRc1mYnjAoiKKbT6adkdx6YwSYugJAuJ5yUpf8xRlN?=
 =?us-ascii?Q?ayiOUVzhiC/TH4/osZaUCegTLYSxrhdPvC/swWPqbuQ8UoJRIyUqqMlXDhPw?=
 =?us-ascii?Q?TQblLmejd3bBggF0znjnNeaJwDDmL1/nO6mbVajcE6unSHmP0jDJcBlrX52T?=
 =?us-ascii?Q?8p/srvbhb2rt3+hIu28WbWNH6YW1IVYr+m8TxTZzjQCb36bfmf8YyrvHQU+X?=
 =?us-ascii?Q?oV6TEPYdv0xJIZyu65xYlgVI6gwebVpBNgzYR/QgqRFCeiIzH24XebUl8T7Y?=
 =?us-ascii?Q?bNj9QDsO0A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de8b9c6-6042-4703-44ea-08dead30ebda
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 18:37:56.1197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8FcgVU0Zmzzj940pP7QltM/ZojV6KikAbnsHR9YcyTPZBHQlPEB9G4zBVjEHGhDTloya6dZD6yOFESvyDfC+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6205
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=tdave@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Introduce a machine property to explicitly set the high PCIe MMIO
window as BASE:SIZE, and apply it in the high memory map.

Usage:
    -machine pcie-mmio-window=0x400000000000:0x400000000000

When using the fixed-bars property to assign guest physical
addresses to PCI BARs, those addresses must fall within the
machine's MMIO64 window. The default aperture may be too small
or not cover the required range.

This property allows the aperture to be resized or repositioned
so that all fixed BAR addresses are accessible to the guest.

Signed-off-by: Tushar Dave <tdave@nvidia.com>
---
 hw/arm/virt.c         | 87 ++++++++++++++++++++++++++++++++++++++++++-
 include/hw/arm/virt.h |  2 +
 2 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ec0d8475ca..55f41c7e46 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1915,8 +1915,31 @@ static void virt_set_high_memmap(VirtMachineState *vms,
 
     for (i = VIRT_LOWMEMMAP_LAST; i < ARRAY_SIZE(extended_memmap); i++) {
         region_enabled = virt_get_high_memmap_enabled(vms, i);
-        region_base = ROUND_UP(base, extended_memmap[i].size);
-        region_size = extended_memmap[i].size;
+
+        if (i == VIRT_HIGH_PCIE_MMIO && vms->override_pcie_mmio_size) {
+            region_base = vms->override_pcie_mmio_base;
+            region_size = vms->override_pcie_mmio_size;
+
+            /* Check for overlap with prior high regions */
+            if (region_base < base) {
+                error_report("pcie-mmio-window base 0x%" PRIx64 " overlaps "
+                            "high memory layout (must be >= 0x%" PRIx64 ")",
+                            (uint64_t)region_base, (uint64_t)base);
+                exit(1);
+            }
+            /* Must not exceed the PA space */
+            if (region_base + region_size > BIT_ULL(pa_bits)) {
+                error_report("pcie-mmio-window [0x%" PRIx64 ", 0x%" PRIx64 ") "
+                            "exceeds %d-bit PA space",
+                            (uint64_t)region_base,
+                            (uint64_t)(region_base + region_size),
+                            pa_bits);
+                exit(1);
+            }
+        } else {
+            region_base = ROUND_UP(base, extended_memmap[i].size);
+            region_size = extended_memmap[i].size;
+        }
 
         vms->memmap[i].base = region_base;
         vms->memmap[i].size = region_size;
@@ -3004,6 +3027,60 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
     }
 }
 
+static char *virt_get_pcie_mmio_window(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    if (!vms->override_pcie_mmio_size) {
+        return g_strdup("");
+    }
+    return g_strdup_printf("0x%" PRIx64 ":0x%" PRIx64,
+                           (uint64_t)vms->override_pcie_mmio_base,
+                           (uint64_t)vms->override_pcie_mmio_size);
+}
+
+static void virt_set_pcie_mmio_window(Object *obj, const char *value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+    uint64_t base = 0, size = 0;
+    const char *endptr;
+    int ret;
+
+    if (!value || !*value) {
+        return;
+    }
+
+    ret = qemu_strtou64(value, &endptr, 0, &base);
+    if (ret || base == 0) {
+        error_setg(errp, "pcie-mmio-window base must be a positive number");
+        return;
+    }
+    if (*endptr != ':' || !*(endptr + 1)) {
+        error_setg(errp, "pcie-mmio-window expects BASE:SIZE");
+        return;
+    }
+
+    ret = qemu_strtou64(endptr + 1, NULL, 0, &size);
+    if (ret || size == 0) {
+        error_setg(errp, "pcie-mmio-window size must be a positive number");
+        return;
+    }
+
+    if (!is_power_of_2(size)) {
+        error_setg(errp, "pcie-mmio-window size 0x%" PRIx64 " must be a power of 2",
+                   (uint64_t)size);
+        return;
+    }
+    if (base % size != 0) {
+        error_setg(errp, "pcie-mmio-window base 0x%" PRIx64 " must be aligned to size 0x%" PRIx64,
+                  (uint64_t)base, (uint64_t)size);
+        return;
+    }
+
+    vms->override_pcie_mmio_base = base;
+    vms->override_pcie_mmio_size = size;
+}
+
 static char *virt_get_iommu(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -3582,6 +3659,12 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set the IOMMU type. "
                                           "Valid values are none and smmuv3");
 
+    object_class_property_add_str(oc, "pcie-mmio-window",
+                                  virt_get_pcie_mmio_window,
+                                  virt_set_pcie_mmio_window);
+    object_class_property_set_description(oc, "pcie-mmio-window",
+                                          "Override the high PCIe MMIO window as BASE:SIZE");
+
     object_class_property_add_bool(oc, "default-bus-bypass-iommu",
                                    virt_get_default_bus_bypass_iommu,
                                    virt_set_default_bus_bypass_iommu);
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 5fcbd1c76f..410df857c7 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -187,6 +187,8 @@ struct VirtMachineState {
     MemoryRegion *sysmem;
     MemoryRegion *secure_sysmem;
     bool pci_preserve_config;
+    hwaddr override_pcie_mmio_base;
+    hwaddr override_pcie_mmio_size;
 };
 
 #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
-- 
2.34.1


