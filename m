Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F0BC624C2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0x2m-0002vC-Kg; Mon, 31 Aug 2026 04:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1x0x2k-0002uu-OL
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:07:02 -0400
Received: from mail-westus2azon11010030.outbound.protection.outlook.com
 ([52.101.46.30] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1x0x2i-0003sb-KE
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:07:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mG1Jo44RBgPvNUR6ATEVN1hGA2mkTy74NQctJ/AUk81X5NW0yRoWn5newSrw1XtW1S6ar97My1SoO4lodbTo4F6PI7jUDgwLh/953hAoy1OF7HPfD7xPlP6lXVsg1qlGNYW+5+EWTRUf8ZX3qcR5+wcDVDyC1K0WB9KeIb8PkPvhTFXN4CLAi/v8RdTCT+MkTnHcyoyPR3q+1Ee8tYdQ8AyKrgwQLTXC4wLU7z9/qf+fbA0fphgMcgQ4A//8PyBD649ecsM5lDkj3M5eFngj3wTxuw4JypPCqHEPULUBnbVJY3DZtNUaYeZWcmt26xBJaQc5xlhg2CeObnScS9cdSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQxVfrIu0NfLYtK6Qs0AoY4XvwumU9m7tJFCFpo78NQ=;
 b=dIVsfcZe3crdugcK7efFcJdIDGuVVeD3uWq5oaHfVdsCC3jq6hod4JwFnLX0nLEnQTxf2xvt9OGRU7soIzFu5Nz4yJCaq7EnHPlwmGP1Ez/BcFF25c0mG9shmClW3QiMDs8J8Lo2pGzG029d6be6kuiYHNPxaryKjw/0OFpdayLzRcaAkJQgUBZnMaFkMn7z43cGAY05Wt+Ow3EWyufzWGJbR++rfuitLsMPYQnRdWOzNnVycqBfZ8Jmn/fo0FGpMvuF4Z1XYwVvlY/hbIwWq09l0mVb4RRBNvKRKqv7xMEM7/35klIGJYPX0wguxNHv1JCVjspHPYE79g+YmkMpLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQxVfrIu0NfLYtK6Qs0AoY4XvwumU9m7tJFCFpo78NQ=;
 b=JXYvgi6kMJNDMtcwisc9ct59S93m5sEewMn6k/BNsU8cpLDYtrfnZQl6yxakyQDg7cQJNlVyHWWcetaIKpK5VU51Wk1/E2XSW90Yy7URwEMX5ZjbcWRiMFWXsbpi7HgxN/O0hqXn5jCZEKjSmeCqHb7am5io0ay063/IIFO4Q7I=
Received: from CH0P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::12)
 by BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 08:01:52 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::a) by CH0P221CA0014.outlook.office365.com
 (2603:10b6:610:11c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 08:01:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 08:01:52 +0000
Received: from [10.85.43.97] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 03:01:34 -0500
Message-ID: <d80dc942-e400-4ed7-898c-98684bf412c5@amd.com>
Date: Mon, 31 Aug 2026 13:31:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <mst@redhat.com>,
 <joe.jin@oracle.com>
Subject: Re: [PATCH v2 2/5] amd_iommu: Use full BDF when reporting page faults
Content-Language: en-US
To: Dongli Zhang <dongli.zhang@oracle.com>, <qemu-devel@nongnu.org>
References: <20260724223216.108667-1-dongli.zhang@oracle.com>
 <20260724223216.108667-3-dongli.zhang@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260724223216.108667-3-dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|BL4PR12MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: 74038a57-8a72-4702-0060-08df07361df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: r62GdASUk3IfotLg4UCniRJqF9eV5ywK7eOjFl3FhwW1fPr4b+JrWQ6k/CGYT8k/43Lg8piLGLjdwI3WbyYw0RY+08bmYB7PDcvPeomAZYWhaBXn0Zl7NcwbPZ39i63iTr4vJPO8ZTzubcC9whgetWBgb5u5njAQXZCVG02XKaCKdioHJ8NBEFI/c3GEpjBc1UJZtsks2olRa8U3URZSMba5g0ywFg8T6YpFbAH9MQwrxbyIZFT1SXsP05fcRyHi9IwJBYLmXNl9Dhd2GisQYBz5unCHO9D5Jcc9OECTX5yOuIMD6uy/zV6PXCdCFK/tgtTeCc+yKDvCuW48tueFn65OQFO5tDVBd/6Mh0miax9Bdnih0we4yvgxip77NVHF7cYMEqCWEpTsaJeYDC/ciy1Qb8GLGGDCvaEfEXuiRDv1Qut8swWxtuMSy6MntbW4CR9ZkvrNHlEiqIUdWwoYCXKo76UcNkV7vRLT/fOt3FTEi38OruHzmnAevgpQ32AW6ZmkFdqPSmjCjVHNJoZMmD3fVVGb0ZjfMeRk3J6A8bq9FKrX7ZowI7G7E1JsOLqAvxGh5cQQlcEPLgrydvN9GJynnXyemyZxlGq6DHQlHYknCTHA08VoxJRkrDw2yaPyIHZih9WtnUHrYZtJ1FcWn3H/IozcbGINJYFgnhL8MxZgQAQIIR4kBB9hfTR/Pdw5r6V4U600YlHsI5hwguMtwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: laNkemCzAbvjs7PeZMSQ76hhFz0VwE09kBW3piVXxzT1mhdyWythLQFI8Hy2+durgWQS1A5jTmx10JA+ZNXEH9SRbdUSgiis6lkkkXgu9DSGXe7dAY4lfac/zmpEfepL5xRVx1UW8ohTNqhyc6adH7fqGtHfqvKwGLKgUGgM9KUmBP3Hw/o876FpX6iWR33UJXpFVBcYY3+rsIIrn0tF7abICFXunEOs5O7TSIB/86+VV6NUVjnGGymOpjUMCkudxJp8HM7ww9X0D13MYn5qopzK7Lw/vDqr31Vmue/YodeawCl9KOwNUt6sqEzG5ed1UDf3UgjntB2X6pbwU5SCaM1dprn9/+/hQnjrQfZBsRURAFmm1Xbw6obrQQF8UpD7gSyiW0eaWlBGfRKe86ODf6gJERI+P4D9ywkZUq1eWzXEq5K5eLs3svrF6b4VDIle
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 08:01:52.1824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74038a57-8a72-4702-0060-08df07361df5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9533
Received-SPF: permerror client-ip=52.101.46.30; envelope-from=Sairaj.K@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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



On 7/25/2026 4:01 AM, Dongli Zhang wrote:
> AMDVIAddressSpace->devfn only contains the PCI device/function number.
> AMD-Vi event log entries require the full DeviceID, including the PCI
> bus number.
> 
> When reporting IO page faults for devices behind a pcie-root-port, QEMU
> logs the fault against the wrong requester. For example, a fault from
> 01:00.0 is reported as 00:00.0 because only devfn is passed to
> amdvi_page_fault().
> 
> [root@vm ~]# lspci
> ... ...
> 01:00.0 Ethernet controller: Red Hat, Inc. Virtio 1.0 network device (rev 01)
> 
> [   58.154050] pci 0000:00:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0xc0000000 flags=0x000a]
> [   58.156968] pci 0000:00:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0xc0000000 flags=0x000a]
> 
> Use the full BDF consistently for AMD-Vi address spaces and pass it to
> page fault and page-table access error reporting.
> 
> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> v1->v2:
>   - Add Fixes tag.
>   - Rename amdvi_as_devid() to amdvi_get_as_devid().
>   - Introduce amdvi_get_devid().
>   - Rebase to call amdvi_get_devid() at amdvi_find_as_by_devid().
> 
>  hw/i386/amd_iommu.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index a5682747ac..2fd680c4ff 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -65,6 +65,16 @@ typedef struct AMDVIIOTLBEntry {
>      uint64_t page_mask;         /* physical page size  */
>  } AMDVIIOTLBEntry;
>  
> +static uint16_t amdvi_get_devid(PCIBus *bus, uint8_t devfn)
> +{
> +    return PCI_BUILD_BDF(pci_bus_num(bus), devfn);
> +}
> +
> +static uint16_t amdvi_get_as_devid(AMDVIAddressSpace *as)
> +{
> +    return amdvi_get_devid(as->bus, as->devfn);
> +}
> +
>  /*
>   * These 'fault' reasons have an overloaded meaning since they are not only
>   * intended for describing reasons that generate an IO_PAGE_FAULT as per the AMD
> @@ -459,7 +469,7 @@ static gboolean amdvi_find_as_by_devid(gpointer key, gpointer value,
>      const AMDVIAsKey *as = key;
>      const uint16_t *devidp = user_data;
>  
> -    return *devidp == PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
> +    return *devidp == amdvi_get_devid(as->bus, as->devfn);
>  }
>  
>  static AMDVIAddressSpace *amdvi_get_as_by_devid(AMDVIState *s, uint16_t devid)
> @@ -664,7 +674,7 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
>  
>  static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
>  {
> -    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
> +    uint16_t devid = amdvi_get_as_devid(as);
>      AMDVIState *s = as->iommu_state;
>  
>      if (!amdvi_get_dte(s, devid, dte)) {
> @@ -763,6 +773,7 @@ static int fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
>      uint8_t pt_level, next_pt_level;
>      IOMMUAccessFlags perms;
>      int ret;
> +    uint16_t devid = amdvi_get_as_devid(as);
>  
>      *page_size = 0;
>  
> @@ -780,7 +791,7 @@ static int fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
>       * Pointer and indexing the top level table using the IOVA from the request.
>       */
>      pte_addr = NEXT_PTE_ADDR(dte, pt_level, address);
> -    *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
> +    *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, devid);
>  
>      if (*pte == (uint64_t)-1) {
>          /*
> @@ -836,7 +847,7 @@ static int fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
>          *page_size = PTE_LEVEL_PAGE_SIZE(pt_level);
>  
>          pte_addr = NEXT_PTE_ADDR(*pte, pt_level, address);
> -        *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
> +        *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, devid);
>  
>          if (*pte == (uint64_t)-1) {
>              /* Failure to read PTE. Page walk skips a page_size chunk */
> @@ -1897,6 +1908,7 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
>      uint8_t mode;
>      uint64_t pte;
>      int fetch_ret;
> +    uint16_t devid = amdvi_get_as_devid(as);
>  
>      /* make sure the DTE has TV = 1 */
>      if (!(dte[0] & AMDVI_DEV_TRANSLATION_VALID)) {
> @@ -1930,7 +1942,7 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
>      if (fetch_ret < 0 || !IOMMU_PTE_PRESENT(pte) ||
>          perms != (perms & amdvi_get_perms(pte))) {
>  
> -        amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
> +        amdvi_page_fault(as->iommu_state, devid, addr, perms);
>          trace_amdvi_page_fault(addr);
>          return;
>      }
> @@ -1957,7 +1969,7 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
>                                 bool is_write, IOMMUTLBEntry *ret)
>  {
>      AMDVIState *s = as->iommu_state;
> -    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
> +    uint16_t devid = amdvi_get_as_devid(as);
>      AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
>      uint64_t entry[4];
>      int dte_ret;

Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>

Thanks
Sairaj

