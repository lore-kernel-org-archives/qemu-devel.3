Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D00DC55172
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 05:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr7df-0004kz-0M; Tue, 04 Aug 2026 01:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wr7dc-0004kp-RE
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 01:24:28 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wr7dY-0005pE-0x
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 01:24:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c56SzOuTXBCS5/04OfW2qx7AOpkP+n/rYRuwrA5PhAkJIAkn6TEp/1onhFJkeMa4B3m0XG5HB4SVI88BjlWL+WBlpF+MZ8y9nxwuNMfWOylJ8E+Zicrg7mX5ywh90UbWjBg+2c6GGZhwZjvECHkpusG/mdojAnTYry6PaIk3Jnzf3aoMmxZCgkG2xuFplEdQ6z769CwyS4ywkLdAvNpW1J9tdYUvWjF8Nq3xUFs8FnXJEL4vS0DRQ38qBB8b+R2rHKepEfPrp26HBGop4LTgA3nxR/jiylZ2z3nNU9lZAzU+fVw2Zm250bVXfImesysRCB/dSU5GP6ZHR/3tEQnxxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEARliNZrIT1eBfUSaLDlTH3mkNSWFOisstX3E39tTo=;
 b=mz9PzFXQb/tE5RJVrmvvzIVDkV6pNCI2XN6Ckq89cN+7oxkrudncIT4tyCK0pdsJbdz/pIia8Q2jbR+xOm3YpctD7VFSUcEJVyo5lwoO1FbSuJkAsWf5K9cjkwZe9zi6ZSutgqH2x3mXE+KgOEeiouybqMctsy+RsyzFRyQp1LApmbZ8M7lox9vJ4rv+wKpuEiS+s5IQMnPnpw0GmIITWgzEs2qQX+BTkH4CDAeJjIu44w7mDcnPzUoo3uZF6Sdv4ELGhvCbTrPccJSvMahpNlYI+PwjtOCkXNM6jdtOsB6SxO2fo+rDPP3Ehzb62dJ7+HpAKU8K8N+jHUeYdDxczw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEARliNZrIT1eBfUSaLDlTH3mkNSWFOisstX3E39tTo=;
 b=nVEEQks4kyMMomrphO6XQ/KTpKp462bVDIxfglsltcZNviP1sxysBcGlJqf1L3QDdZX7GnErLQgUT5OavNuo74HIiwlWXecP2aAM7fn+pX7IG0XOCLhHDbJ8OqZl6+x5ptWeFeGbfECEDD7a+43mOp3LOiESdISnwTfLTV8E5fY=
Received: from BN9PR03CA0275.namprd03.prod.outlook.com (2603:10b6:408:f5::10)
 by CY8PR12MB7313.namprd12.prod.outlook.com (2603:10b6:930:53::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 05:24:05 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::97) by BN9PR03CA0275.outlook.office365.com
 (2603:10b6:408:f5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 05:23:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 05:23:11 +0000
Received: from [10.136.32.97] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 00:23:07 -0500
Message-ID: <c0ceb962-3385-4a0e-bef5-aae70c8f702d@amd.com>
Date: Tue, 4 Aug 2026 10:53:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, "Igor
 Mammedov" <imammedo@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>,
 <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH 7/8] acpi_build: Cleanup AMD IOMMU IVRS building
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20260511123937.32743-1-sarunkod@amd.com>
 <20260511123937.32743-8-sarunkod@amd.com>
 <20260803180841-mutt-send-email-mst@kernel.org>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260803180841-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|CY8PR12MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b930127-024b-42a6-ffe7-08def1e879c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bygZaSgQONGnON0C4rEZgjYyJuzcKI2CQgKRta0Gck9weIzKyglbetmyU5YNCKjPlvaFIegHIvBixIXV4xehcw6imTCaLvMlRNtkD57h53e4V5Qg68C8AItEKqzmBDhTzqs89CrD0lSgeqNVYBeGpJeNvyn8xX05nRbYABBbz/NIHAkkOy8CQeX+rqIqTFSG+22nOgFmK2lwC/iJN2sFiIrUVoGz8YbGfhF+Grc06gignkShT2Li75egPPcqmE/Aorqgrtpd5LI4MjUxheEBtZpZs6FM5cnQKA8/glr+UJxECMquMP1OspLRH/e62cbvUDS5AcClY/YChJfjmkpT4oVGhQi5qii4qJp/C/1MUG1yDc9YjcmUEcfQ+XI/3aOr4QUiyzTfoDRB7MAQBrCGV2mZjaAmx/VFsMUsGYQp5B0epmdYg8RgoawD7TDjQIW1HiIaI5M9kfH0/Ade9QB+yzh7qKzOTBzWNpUfXAnpALXqehewkIV1ZJ/oT6+Gr1GLU+JJJwPFkSSMWlV/ZbvH5KyvXTpB0sbazk7ErA1D0gvtIoU56qHbg6cnyRPkNk3s7ui75iYGVLMgldHlKd13gi7FI0FCfcxRLL4fDqXRW+3ZEkD6ghA5pbE6OgaZ23w2g8Eax32nVdpY9JTa196TcV8Oiy9gXzVa2kB3qLgWPMu9VLH8qGBNBuLQ2F3/k4XSSymDSvCB7+A4DSC9vhmEVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e3UKYCvm47rnfajJNLQsJ/3oaP84G3yiF9L8JSaHwuHvbGNqAbJBZb/8w6hB5Ms8tul2amU6ZnlPNKl0Q2oNaBlnrV1pa7bxwHs85O0bVNmSBmbHRQmkxBP+PXcvZuOXYf3BkYdtPNpBMKW6ti0Jw2x6+1bV3VsTC2O4wrv9/aIiBlH+7T2g8jEhE+PzJhvlY2pPIFRXwoSFooHie/XISsyeMWJzKX6gIMFS7D+UQKpiJd59P+mz5BLAUKOR1hbIbSbEe2XctgsSoSaK1nJyes7xpV1aBvsdYZXoriMrXqLB36LuIbueUnwlzdLSGDDx9TYCkUoAJ8SUIODRp+n3g9Zq9xBoTFz6HBqvE3/Cqy4WH6bhH0gFkGXFWUH6nOgul+4zy1VRFCHL+KcUAVZXbJD+bBbZLyCDvTugtSmVrIANuOcM/d8ypRYpXf/3sPM4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 05:23:11.0297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b930127-024b-42a6-ffe7-08def1e879c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7313
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=Sairaj.K@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 8/4/2026 3:40 AM, Michael S. Tsirkin wrote:
> On Mon, May 11, 2026 at 06:09:36PM +0530, Sairaj Kodilkar wrote:
>> Use structs and macros to improve the readability and maintainability of
>> the the code. 
>>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> 
> This does not "improve the readability and maintainability" it blows up
> code size by a factor of 4, makes it impossible to find things in the
> spec and breaks endian-ness.
> 
> Please don't.

Understood, will change this in v2

Thanks
Sairaj.

> 
>> ---
>>  hw/i386/acpi-build.c | 149 +++++++++++++++++--------------------------
>>  1 file changed, 59 insertions(+), 90 deletions(-)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 82208e06e155..e18c9be801a2 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -1663,11 +1663,13 @@ static void
>>  insert_ivhd(PCIBus *bus, PCIDevice *dev, void *opaque)
>>  {
>>      GArray *table_data = opaque;
>> -    uint32_t entry;
>> +    AmdIvhdDeviceEntry entry = {};
>>  
>>      /* "Select" IVHD entry, type 0x2 */
>> -    entry = PCI_BUILD_BDF(pci_bus_num(bus), dev->devfn) << 8 | 0x2;
>> -    build_append_int_noprefix(table_data, entry, 4);
>> +    entry.type = AMD_IVHD_DEVICE_ENTRY_TYPE_SELECT;
>> +    entry.devid = PCI_BUILD_BDF(pci_bus_num(bus), dev->devfn);
>> +
>> +    g_array_append_vals(table_data, &entry, sizeof(entry));
>>  
>>      if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
>>          PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
>> @@ -1691,11 +1693,14 @@ insert_ivhd(PCIBus *bus, PCIDevice *dev, void *opaque)
>>               */
>>              if (sec == sub) { /* leaf bus */
>>                  /* "Start of Range" IVHD entry, type 0x3 */
>> -                entry = PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0)) << 8 | 0x3;
>> -                build_append_int_noprefix(table_data, entry, 4);
>> +                entry.type = AMD_IVHD_DEVICE_ENTRY_TYPE_START_RANGE;
>> +                entry.devid = PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0));
>> +                g_array_append_vals(table_data, &entry, sizeof(entry));
>> +
>>                  /* "End of Range" IVHD entry, type 0x4 */
>> -                entry = PCI_BUILD_BDF(sub, PCI_DEVFN(31, 7)) << 8 | 0x4;
>> -                build_append_int_noprefix(table_data, entry, 4);
>> +                entry.type = AMD_IVHD_DEVICE_ENTRY_TYPE_END_RANGE;
>> +                entry.devid = PCI_BUILD_BDF(sub, PCI_DEVFN_MAX - 1);
>> +                g_array_append_vals(table_data, &entry, sizeof(entry));
>>              } else {
>>                  pci_for_each_device(sec_bus, sec, insert_ivhd, table_data);
>>              }
>> @@ -1708,24 +1713,26 @@ insert_ivhd(PCIBus *bus, PCIDevice *dev, void *opaque)
>>               * express bridges, just as in pci_device_iommu_address_space().
>>               * DeviceIDa vs DeviceIDb as per the AMD IOMMU spec.
>>               */
>> -            uint16_t dev_id_a, dev_id_b;
>> +            AmdIvhdDeviceEntryExt entry_ext = {};
>>  
>> -            dev_id_a = PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0));
>> +            entry_ext.type = AMD_IVHD_DEVICE_ENTRY_TYPE_ALIAS_START_RANGE;
>> +            entry_ext.devid_a = PCI_BUILD_BDF(sec, PCI_DEVFN(0, 0));
>>  
>>              if (pci_is_express(dev) &&
>>                  pcie_cap_get_type(dev) == PCI_EXP_TYPE_PCI_BRIDGE) {
>> -                dev_id_b = dev_id_a;
>> +                entry_ext.devid_b = entry_ext.devid_a;
>>              } else {
>> -                dev_id_b = PCI_BUILD_BDF(pci_bus_num(bus), dev->devfn);
>> +                entry_ext.devid_b = PCI_BUILD_BDF(pci_bus_num(bus),
>> +                                                  dev->devfn);
>>              }
>>  
>>              /* "Alias Start of Range" IVHD entry, type 0x43, 8 bytes */
>> -            build_append_int_noprefix(table_data, dev_id_a << 8 | 0x43, 4);
>> -            build_append_int_noprefix(table_data, dev_id_b << 8 | 0x0, 4);
>> +            g_array_append_vals(table_data, &entry_ext, sizeof(entry_ext));
>>  
>>              /* "End of Range" IVHD entry, type 0x4 */
>> -            entry = PCI_BUILD_BDF(sub, PCI_DEVFN(31, 7)) << 8 | 0x4;
>> -            build_append_int_noprefix(table_data, entry, 4);
>> +            entry.type = AMD_IVHD_DEVICE_ENTRY_TYPE_END_RANGE;
>> +            entry.devid = PCI_BUILD_BDF(sub, PCI_DEVFN_MAX - 1);
>> +            g_array_append_vals(table_data, &entry, sizeof(entry));
>>          }
>>      }
>>  }
>> @@ -1786,20 +1793,20 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>>      GArray *ivhd_blob = g_array_new(false, true, 1);
>>      AcpiTable table = { .sig = "IVRS", .rev = 1, .oem_id = oem_id,
>>                          .oem_table_id = oem_table_id };
>> -    uint64_t feature_report;
>>      int iommu_bus = pci_bus_num(pci_get_bus(iommu_dev));
>>      uint16_t iommu_devid = PCI_BUILD_BDF(iommu_bus, iommu_dev->devfn);
>> +    AmdIvrsVendorHdr ivrs_hdr = {};
>> +    AmdIvhdHdr10 ivhd10 = {};
>> +    AmdIvhdHdr11 ivhd11 = {};
>>  
>>      acpi_table_begin(&table, table_data);
>>      /* IVinfo - IO virtualization information common to all
>>       * IOMMU units in a system
>>       */
>> -    build_append_int_noprefix(table_data,
>> -                             (1UL << 0) | /* EFRSup */
>> -                             AMDVI_PA_SIZE_52,
>> -                             4);
>> -    /* reserved */
>> -    build_append_int_noprefix(table_data, 0, 8);
>> +    ivrs_hdr.ivinfo = AMD_IVINFO_EFR_SUP | AMDVI_GVA_SIZE_48 |
>> +                      AMDVI_PA_SIZE_52 | AMDVI_VA_SIZE_64;
>> +
>> +    g_array_append_vals(table_data, &ivrs_hdr, sizeof(ivrs_hdr));
>>  
>>      /*
>>       * A PCI bus walk, for each PCI host bridge, is necessary to create a
>> @@ -1817,7 +1824,8 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>>           *   These are 4-byte device entries currently reporting the range of
>>           *   Refer to Spec - Table 95:IVHD Device Entry Type Codes(4-byte)
>>           */
>> -        build_append_int_noprefix(ivhd_blob, 0x0000001, 4);
>> +        AmdIvhdDeviceEntry entry = { .type = AMD_IVHD_DEVICE_ENTRY_TYPE_ALL };
>> +        g_array_append_vals(ivhd_blob, &entry, sizeof(entry));
>>      }
>>  
>>      /*
>> @@ -1829,76 +1837,37 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
>>       * See Linux kernel commit 'c2ff5cf5294bcbd7fa50f7d860e90a66db7e5059'
>>       */
>>      if (x86_iommu_ir_supported(x86_iommu_get_default())) {
>> -        build_append_int_noprefix(ivhd_blob,
>> -                                 (0x1ull << 56) |           /* type IOAPIC */
>> -                                 (IOAPIC_SB_DEVID << 40) |  /* IOAPIC devid */
>> -                                 0x48,                      /* special device */
>> -                                 8);
>> -    }
>> -
>> -    /* IVHD definition - type 10h */
>> -    build_append_int_noprefix(table_data, 0x10, 1);
>> -    /* virtualization flags */
>> -    build_append_int_noprefix(table_data,
>> -                             (1UL << 0) | /* HtTunEn      */
>> -                             (1UL << 4) | /* iotblSup     */
>> -                             (1UL << 6) | /* PrefSup      */
>> -                             (1UL << 7),  /* PPRSup       */
>> -                             1);
>> -
>> -    /* IVHD length */
>> -    build_append_int_noprefix(table_data, ivhd_blob->len + 24, 2);
>> -    /* DeviceID */
>> -    build_append_int_noprefix(table_data, iommu_devid, 2);
>> -    /* Capability offset */
>> -    build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
>> -    /* IOMMU base address */
>> -    build_append_int_noprefix(table_data, s->mr_mmio.addr, 8);
>> -    /* PCI Segment Group */
>> -    build_append_int_noprefix(table_data, 0, 2);
>> -    /* IOMMU info */
>> -    build_append_int_noprefix(table_data, 0, 2);
>> -    /* IOMMU Feature Reporting */
>> -    feature_report = get_amd_ivhd_feature_report(s);
>> -    build_append_int_noprefix(table_data, feature_report, 4);
>> -
>> +        AmdIvhdDeviceEntryExt entry_ext = {
>> +                    .type = AMD_IVHD_DEVICE_ENTRY_TYPE_SPECIAL_DEVICE,
>> +                    .devid_b = IOAPIC_SB_DEVID,
>> +                    .variety = IVHD_VARIETY_IOAPIC
>> +                };
>> +
>> +        g_array_append_vals(ivhd_blob, &entry_ext, sizeof(entry_ext));
>> +    }
>> +
>> +    ivhd10.type = 0x10;
>> +    ivhd10.flags = AMD_IVHD_FLAG_HT_TUN_EN | AMD_IVHD_FLAG_IOTLB_SUP |
>> +                   AMD_IVHD_FLAG_PREF_SUP  | AMD_IVHD_FLAG_PPR_SUP;
>> +    ivhd10.length = ivhd_blob->len + sizeof(ivhd10);
>> +    ivhd10.devid = iommu_devid;
>> +    ivhd10.capab_offset = s->pci->capab_offset;
>> +    ivhd10.base_addr = s->mr_mmio.addr;
>> +    ivhd10.iommu_feature_report = get_amd_ivhd_feature_report(s);
>> +    g_array_append_vals(table_data, &ivhd10, sizeof(ivhd10));
>>      /* IVHD entries as found above */
>>      g_array_append_vals(table_data, ivhd_blob->data, ivhd_blob->len);
>>  
>> -   /* IVHD definition - type 11h */
>> -    build_append_int_noprefix(table_data, 0x11, 1);
>> -    /* virtualization flags */
>> -    build_append_int_noprefix(table_data,
>> -                             (1UL << 0) | /* HtTunEn      */
>> -                             (1UL << 4),  /* iotblSup     */
>> -                             1);
>> -
>> -    /* IVHD length */
>> -    build_append_int_noprefix(table_data, ivhd_blob->len + 40, 2);
>> -
>> -    /* DeviceID */
>> -    build_append_int_noprefix(table_data, iommu_devid, 2);
>> -    /* Capability offset */
>> -    build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
>> -    /* IOMMU base address */
>> -    build_append_int_noprefix(table_data, s->mr_mmio.addr, 8);
>> -    /* PCI Segment Group */
>> -    build_append_int_noprefix(table_data, 0, 2);
>> -    /* IOMMU info */
>> -    build_append_int_noprefix(table_data, 0, 2);
>> -    /* IOMMU Attributes */
>> -    if (!s->iommu.dma_translation) {
>> -        build_append_int_noprefix(table_data, (1UL << 0) /* HATDis */, 4);
>> -    } else {
>> -        build_append_int_noprefix(table_data, 0, 4);
>> -    }
>> -    /* EFR Register Image */
>> -    build_append_int_noprefix(table_data,
>> -                              amdvi_extended_feature_register(s),
>> -                              8);
>> -    /* EFR Register Image 2 */
>> -    build_append_int_noprefix(table_data, 0, 8);
>> -
>> +    ivhd11.type = 0x11;
>> +    ivhd11.flags = AMD_IVHD_FLAG_HT_TUN_EN | AMD_IVHD_FLAG_IOTLB_SUP;
>> +    ivhd11.length = ivhd_blob->len + sizeof(ivhd11);
>> +    ivhd11.devid = iommu_devid;
>> +    ivhd11.capab_offset = s->pci->capab_offset;
>> +    ivhd11.base_addr = s->mr_mmio.addr;
>> +    ivhd11.iommu_attributes = !s->iommu.dma_translation <<
>> +                              AMD_IVHD_ATTRIBUTES_HATDIS_SHIFT;
>> +    ivhd11.efr = amdvi_extended_feature_register(s);
>> +    g_array_append_vals(table_data, &ivhd11, sizeof(ivhd11));
>>      /* IVHD entries as found above */
>>      g_array_append_vals(table_data, ivhd_blob->data, ivhd_blob->len);
>>  
>> -- 
>> 2.34.1
> 


