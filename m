Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80BDEC047D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxMIx-0000wP-DU; Tue, 03 Mar 2026 04:44:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1vxMIw-0000tE-7N
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:44:38 -0500
Received: from mail-westusazon11012050.outbound.protection.outlook.com
 ([52.101.43.50] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1vxMIu-0008Tt-9z
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:44:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5w7AauqvGfxhwTLuBrJTIwQCDzNfKhNLAZTFBdEh686mqCKdZjv7qHUnGvhOsbHNUSluEZs1Du6qcsW/oUICaz37pVnb/ojxD2tkP0IInTRER8s59+eE/wALSNXvhrPTWNny0L/kbxSkjLkvC1zp17/wX7At8wI+k7MtazcAJgUmnK2aGJPguZsxZtKA3M9RWqUhq+BMJvVLq+RogSzxn3WrVPY+4nzHu3A3nnFy9kgW9raTWE/lDpdVQFjJrlLvM1cy3y1KAWDtCo1p0Gg8bHGlKwU06O+2mOxN6VaNFdpa8Zi0c5UKevMOheGsvdNi0p+nSOT8OeHn7UizoLAUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIULXXiKyJ8jPbhUCpcgGcVhc2YEyIWySFnLFIvyqiQ=;
 b=jb2XzJTYjrzGmsWNXzNDWncpGa5PBZ58+ytGg06WAxJlvT0/zK/kvJo2Fk8gDtY4SO0tNR61CDapJCl8H90n6FUmaulmVJVqCSUXhCmcia+z5Byo3dEzXySZmpb1+XzSr1RX/ZKVKKdq+G6u4uf11JqNc7GKQpKgwYXJHpP4yzfO0oev9oq+FX5GLuGdiVDt8hcwAFCfstfOBDTwcMhTnVG4FlQ+l4qoQfal7hJ4B+FEPt5PDAkpONT/YD1XUYnsLFHRac8LDDhkFUmemaV9kJw724uADI8zkzYuDNJiHyXwQ89UJmDUY5af1bqLXzE7gqD1uccjOdoc7Y9npJCElw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIULXXiKyJ8jPbhUCpcgGcVhc2YEyIWySFnLFIvyqiQ=;
 b=3Y0uJ9wJV4w+z6/04V59Cufan29iFSZrCqwkgoFUNHrumQj9nk03Brv1C9iOLDh3HiJ6oHIBKww2dfem7TpYgvLuGb8QbEmuzLlC22WA4q//+a14hMCEeQGmdyRgz805e8eM2hXN2FAfUr0d0wfzNLUiF8f8GwsLgxlS0Q8Oq+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6)
 by DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 09:39:27 +0000
Received: from MN0PR12MB5761.namprd12.prod.outlook.com
 ([fe80::b0f2:27be:4ba6:3288]) by MN0PR12MB5761.namprd12.prod.outlook.com
 ([fe80::b0f2:27be:4ba6:3288%4]) with mapi id 15.20.9654.015; Tue, 3 Mar 2026
 09:39:27 +0000
Message-ID: <27d6b36b-c8df-466f-bf67-26e70ef34cb8@amd.com>
Date: Tue, 3 Mar 2026 15:09:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] amd_iommu: Turn on XT support only when guest has
 enabled it
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: alejandro.j.jimenez@oracle.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, clement.mathieu--drif@eviden.com
References: <20260302115130.5903-1-sarunkod@amd.com>
 <20260302115130.5903-3-sarunkod@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260302115130.5903-3-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000185.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4b) To MN0PR12MB5761.namprd12.prod.outlook.com
 (2603:10b6:208:374::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5761:EE_|DM4PR12MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c49496a-4360-473f-ff1e-08de7908c253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: OxSIJswJk9/HidrftXb45YKHF/JfH/9FXdg9TJO3IfMb5njRUF41PNto7mgXDThhIOSL3wE6arWpmP6Nq27apaGWMXhLkRwZvG7oIgEFEBlHg9vPjuv8gWFcXcRNQm+guL2zGNxyD6TWPsL+rZ6oRvfGw4voDjcvqLQQok2XArYQ80L/pIXUK+tFSO/XjR4IQcjSSwGSdkpdxtcW0fmkD7D6MA/KlNyC5Su95yGClIq6MGeeccE7UysSSbOTDUDW74O0CNXwrzba5Ze0LxJjRNW5jT+KOwhOxCXC8OEzyfhY1l2U32MZ0nq4zFvmZFS/aeJWKg3J2zygx5Ta3kMHeVK1GaFdvhWcXmbfGmGZkIDZgAKKtd9TsZ0CgL+0xG0NgSICulaFWC/a2kqhQ00wHMS/gfMdQssTkodU+2THVYSW/c917SyoBKq7ZotGqYSFST04VwiKPbGzB5Kskcylu4NecPIS2Ar6n6HDgKxkFns3xPIQWZcSVJW9AtwPVctAms2Z711yvTwcFQRhe8zxzcccoj66WshB6YmpiNmzbLWcoZtX4bVH6IRF0qI5iJLig967O2tm+LEoDplzXK3UlXaTisjRJvpKQ960JHhPe+QeTsdnhrDfDEwavYGktvTDQzWoWBWrJQ75SbJXaooQzm1PMxsK9BlFuIb2R6uTHkPGDg+jUzMdF8gkRPy9ATlt13Xq15pl7+iT9lkCuU5ahMiKWWsqgE4d+QjIw/DSezc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmNFUnpxN2pTd0N2U3RKQnEzTVprTFMveEFmdzV6bitoSytOV25EU2NGbkFy?=
 =?utf-8?B?eVZ6TlRPU09EQmg0YVI5ZW5DbS93TEVvR0JNVDI1WFM3T3ozcGMyRWRTKzdv?=
 =?utf-8?B?eHhSVHhpU0Qrb05WZllFUmpKVDYwbGZkRzg0OXg1SzEzcXNqWmV4dVRjSFUz?=
 =?utf-8?B?NzlocFhJMVBFMFNaa2x2MlM5STc1blFFclA5TmhWMXhFZzd1TFJlUVJ5NkV2?=
 =?utf-8?B?bkxCOEFKcFh4QnNTdllGcGlYNmYzN2JUUldUaUxYY3QwdkwwdURXUnBYc0VS?=
 =?utf-8?B?aW8vOFBPSVZRR1o2anRJa01ETHk0K2g0YTdGdUIvL3RMd3hUY2ZZSUxpRldw?=
 =?utf-8?B?N3RBbXN4SG9TaTVhOU16U3J5bzBMb0NmOG1xbXcvdzhLdUx1eG51TXdMNHlE?=
 =?utf-8?B?a0czcTJsN0ZkRTBZME9VdGNrcXpqd242T1dQMG56Y1lNZFR3bzNuUEpFcHQz?=
 =?utf-8?B?SXRwWjM0bjdQNWhjVW8vRUpWQkVFbHQyYkhaUUFoTFYrTUNlczFDRUR0cFVl?=
 =?utf-8?B?eFNWTEo3bTljeHVFRmdqUTIrOHQwbms4ZFNYeDdkblVrTlNrS2Q4aDhLL2pm?=
 =?utf-8?B?OEs5WXB3SWVCQWZobVpUekZpSWNVUnNSV0hFckFoeElKd1VwSUlSbW5QMzBa?=
 =?utf-8?B?bjhrTU1lbTZycXdiRzc1aEU1b1RURjA1ZlVDNldBYzdFRGc5L0d1THBkNVJJ?=
 =?utf-8?B?NFNqdXNQVlFVYkJ3a2VNY2d0bHhNaGRlalNqMGhMSnN3Tm1Sak5NdGVkdDlu?=
 =?utf-8?B?WTlMYzBTS3BwbGdmVHNtMHphVVBLeUpxRVEyem1lcVhzNEE1V20yL1JjZnJB?=
 =?utf-8?B?TEh1OFEzc1ZRUThJdzkrU3ZkSDh5YXFXZzIxYmE3YzZqWldhejdIa3RZc28v?=
 =?utf-8?B?a21VTFpGSEtaTXNrbHkvSjBHN2lIWmJLZmkzUjlka0Z3d1FYR3JETVVDeSsy?=
 =?utf-8?B?YXZscHRzSlB0OVc3TW5aWTRPWGFtTmZOTEltVGhvblg0aG1oNDRyNXlTOW0y?=
 =?utf-8?B?MDhvamZIbmV0azZ6ZS8vSHZEaU5EaXZLSjRYbHZtVXp3WWNVR28wVkgrMk5R?=
 =?utf-8?B?SG1YTDR1Ym44bEJMQWEzQkVuT2dvNjJKQXMybGNiQm9JaDB2aDJOQ2lWb0Jn?=
 =?utf-8?B?SXNEZzZuZ2ozcWJOaEJPenk2aHNWbVgrcUpqS3FJTFFJQ3JtTkFrYTlsV2hn?=
 =?utf-8?B?L09oWjdHVFFBWFQ4RzdoM3RhUHUwbExGRVRQb28wNTdML0haM0JHWXZBZ2F2?=
 =?utf-8?B?YkQ2b252cDlkY0xzR01tMm1kbERmTEpTQ2h5MStXbnZEdng0ckpPYjJraXJr?=
 =?utf-8?B?VVNySUhiN0RNcFhBNERsOUJHZW50b0JYZUFWTUNBaCtUWnFtVklBWjBNL05H?=
 =?utf-8?B?TUhjS2E2YVRCYU0yUGVWN0MvU24rY080TkF5NTJXNVJUM0lCazcvR2Y5Rlcx?=
 =?utf-8?B?REtMK1RzcTY4Y2p6ZFZGOTcvbVVtaEc4bExDOGx5NktBY0d2Nm5WT1B1MkFM?=
 =?utf-8?B?NFR0amRCS3FaL1k1R04wTG9WeEoxOHNKUXpmUDFjVXhYTEs3WnZoQmVqK1dK?=
 =?utf-8?B?TERXaEdBUFV4bm9mR3lXMTdsZ0JMQ0djTzJwL29mNVBqQU8wUGFnLzUzbG1X?=
 =?utf-8?B?VFBERHZ0RTVGaHpwaFpXZjhZSk9VWU14NnZKTElOUnQ4VzN5WWRKTmNXVWpD?=
 =?utf-8?B?MUZqK25PMWJDOGxJT3hEc3E3Tzh6VTZvdVA5Zk5vc2luR2pJZnlHR0FtR3V4?=
 =?utf-8?B?Tk9zNWI3RUhhVjVIY3R4M3NJODJranNrMXZsUVFCZk9iNzJOVEczb2kvMGF4?=
 =?utf-8?B?c0dzakFvVmRGbUp5S2t2UnNQWG4vSno4dGd6ZWdINnVPQmRLWk9WUkhiNWlH?=
 =?utf-8?B?ZTYwMHFaQlJyS3NKa003My92ZkMyU3VjOVloajZhWkt2dWQ0OEdSb0ZxaDRI?=
 =?utf-8?B?WVdJOEhaQ2lDa1Y5QmxqM2VLQTFwNmh6R2ZuenBpYzlEMTMrMllaWGN5alRx?=
 =?utf-8?B?N3dZVzBwVlZKWHVtbDA3SGw5Z21xM1ZZeDh5ZXRoMCsxQ2JnTFcyRVIrajZh?=
 =?utf-8?B?T3ljZnQ2UnNYcDZMSHYvL3VDRmFVR2NYYm5IMVgxdmJiM0syUGpUYk9rMmN0?=
 =?utf-8?B?U1RVdlY4UDFZYjRTeVhmZHJnbUpSdUkrYkZ0akxyU0xXVCtUL0huY3JsS1hx?=
 =?utf-8?B?eVNZZk1VekxCeTNtelVlbmtQY2xTTW9LYmY1NlB1M29oVW05TFQ0aU9SY2NR?=
 =?utf-8?B?bHlvVy9va2dISVpMS2RBVEl1NVQwUVhvNlh0SjZKbHhsdyt3MVM1d3ZFWXJY?=
 =?utf-8?B?SDl4NnFkNTViYjlYcnk1V2hIVXJvdHkrZmppbXJiQmN5cTZUOU9Ldz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c49496a-4360-473f-ff1e-08de7908c253
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:39:26.8298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bc4g3Dy96AGBlyoL28nGwXsiwfU3jQHbsj622kfoFk5z7AgvfF11WQHc0Hd/QFfzY4WosWOzG6yeSV71mbCAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890
Received-SPF: permerror client-ip=52.101.43.50;
 envelope-from=Vasant.Hegde@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 3/2/2026 5:21 PM, Sairaj Kodilkar wrote:
> Current code uses 32 bit destination ID irrespective of the fact that
> guest has enabled x2APIC support through control register[XTEn] and
> completely depends on command line parameter xtsup=on. This is not a
> correct hardware behaviour and can cause problems in the guest which has
> not enabled XT mode.
> 
> Introduce new flag "xten", which is enabled when guest writes 1 to the
> control register bit 50 (XTEn). Also, add a new subsection in
> `VMStateDescription` for backward compatibility during vm migration.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>  hw/i386/amd_iommu.c | 21 +++++++++++++++++++--
>  hw/i386/amd_iommu.h |  4 +++-
>  2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index f5aa9c763d02..4a86e62a3b92 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1523,6 +1523,8 @@ static void amdvi_handle_control_write(AMDVIState *s)
>      s->cmdbuf_enabled = s->enabled && !!(control &
>                          AMDVI_MMIO_CONTROL_CMDBUFLEN);
>      s->ga_enabled = !!(control & AMDVI_MMIO_CONTROL_GAEN);
> +    s->xten = !!(control & AMDVI_MMIO_CONTROL_XTEN) && s->xtsup &&
> +              s->ga_enabled;
>  
>      /* update the flags depending on the control register */
>      if (s->cmdbuf_enabled) {
> @@ -1996,7 +1998,7 @@ static int amdvi_int_remap_ga(AMDVIState *iommu,
>      irq->vector = irte.hi.fields.vector;
>      irq->dest_mode = irte.lo.fields_remap.dm;
>      irq->redir_hint = irte.lo.fields_remap.rq_eoi;
> -    if (iommu->xtsup) {
> +    if (iommu->xten) {
>          irq->dest = irte.lo.fields_remap.destination |
>                      (irte.hi.fields.destination_hi << 24);
>      } else {
> @@ -2379,6 +2381,7 @@ static void amdvi_init(AMDVIState *s)
>      s->mmio_enabled = false;
>      s->enabled = false;
>      s->cmdbuf_enabled = false;
> +    s->xten = false;
>  
>      /* reset MMIO */
>      memset(s->mmior, 0, AMDVI_MMIO_SIZE);
> @@ -2443,6 +2446,16 @@ static void amdvi_sysbus_reset(DeviceState *dev)
>      amdvi_reset_address_translation_all(s);
>  }
>  
> +static const VMStateDescription vmstate_xt = {
> +       .name = "amd-iommu-xt",
> +       .version_id = 1,
> +       .minimum_version_id = 1,

Wrong indentation. Otherwise patch looks good.

-Vasant


