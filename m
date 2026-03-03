Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D073EC047E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxMLn-0001o6-DX; Tue, 03 Mar 2026 04:47:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1vxMLl-0001nv-JO
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:47:33 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1vxMLj-0000Zk-Qf
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:47:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7WQRJMWtATel3Vh9jMToQ5kmE5A7MyB8sTtmiN8kQwAItgZIsOvolUD6Yk6Z54pnyPDgfWQkfDluCA3AqZUDc87TZze2Of+qvSx0L15y9lIXBLgNM17xGkjM7hBAXIINfCNceu/7ZQwIdmadpht7GAuN+cVDD7bEBTCSb4S2QUhWovqtPy/bFqktCFiN717oJizvU8UDVqScC4sbGnfvnHzhJ+1zNwy/UndKJ5xR+ZrYSJOuF43gwQc6O6FVNy9VstPBtw5lqA9xo6cyvro28kNtohReGleXY5+38OmQo8vF+dVu1EXRcjFLqsfIbvv3LcKm3yepDswI+UEsvo+uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtdOsMH1Yuuo91gTDEXQb+LuIlfrDXzXYV/GG4ruoSs=;
 b=afMzh1l/yS3DrULhHyynKE1McTOVHY325nL0YVeTzllC1+ubYI0PHYk8xu9JsPunaRkJ4rNiKmbtOKVjEaUQqJ49WDVSNFsQem4NX0i4VchALJHXb0x/O1v2AWb/7XwML4HHTL1f+nNeXBT98bQtrcLcjadcATdeoolLXA5cEpMjLWd0b40q9ZoiOFNCtFuj6ILAzdOtrrIuDaXq7WoxvudxbVEb0p+HZxjMx0hzeYNGHb+FZBOUu/xMptLV2djMGoZAbh+eBTdDmn2uJpLSzpZeQ4Xr3DyrCgJfKsvi11dnMLmCZenNtspIKC5vmn3SPU0e7dcZ0XlkdcFB4OlSFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtdOsMH1Yuuo91gTDEXQb+LuIlfrDXzXYV/GG4ruoSs=;
 b=kC7dAAo/pxC1p7fWaruj/uXHw6hQWWnG+XSD1ylqTnA0KbL938mQt1+eHbAosbSxpTZkz+LN9l4kJEw/LyrkqoFjVuD1e13rNV8Ggz1JBZRASsyNbgIEXkcpX8frthP4Shv+IM0oaN+pWk0u8wuaHPk6lBwHwb82l8PMz11WXFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6)
 by SN7PR12MB7156.namprd12.prod.outlook.com (2603:10b6:806:2a7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 09:47:27 +0000
Received: from MN0PR12MB5761.namprd12.prod.outlook.com
 ([fe80::b0f2:27be:4ba6:3288]) by MN0PR12MB5761.namprd12.prod.outlook.com
 ([fe80::b0f2:27be:4ba6:3288%4]) with mapi id 15.20.9654.015; Tue, 3 Mar 2026
 09:47:27 +0000
Message-ID: <2c022a3c-f0e0-42be-a946-760a6e938de5@amd.com>
Date: Tue, 3 Mar 2026 15:17:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] amd_iommu: Generate XT interrupts when xt support
 is enabled
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: alejandro.j.jimenez@oracle.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, clement.mathieu--drif@eviden.com
References: <20260302115130.5903-1-sarunkod@amd.com>
 <20260302115130.5903-4-sarunkod@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260302115130.5903-4-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0127.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::7) To MN0PR12MB5761.namprd12.prod.outlook.com
 (2603:10b6:208:374::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5761:EE_|SN7PR12MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1d25cb-df3c-449f-2299-08de7909e12b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 9PNaNyFzhTzEPMPfWV3mKfT+B55RBFK3XpIFr0Rv3smoTCF/elKY6kAD8Xbb3WbtkuF86t9llgFm6Uza4x8u7hLMpaJSwIJi89FemJF/JkN23Nu1Er1J9awGLbkaPrGsyNvGgnw6LlDmAUGVkGx/q3uWmg1zkF+MAH20S7snuTeVLqbMGRb1mJyb//s3ud1bujFxxh6Y8D7fSVhmUnKz8B5Dl7EpiVF3l4o67LbjsjreLSTiTLb/kVFYjMwI/DndwAZdRxVTw3z7TdMQN0mL/gYobZspk9ZjzfOEh9q5mbAKn+T1FeQ+ulxSFL21Xe6m1J09y2AAW254oPTX0m24DrpFPxEjtZR5d5ztXJzW+Do4XYDDKAf0dUGYDCUiJ46cdOm/0+k9NfaeA6CcIBFCSoRkK0d5ex4Z+tYypTslRooXVATu7jJXXOmZyFZPTr445F05lO8keoPEvXYhMuLGKiZjLoR9CaP5ILR9SYZ1gu+e/OPDwx/p1wk3AETRE2K2RxXYQJjRiNsZHVxJ2OQbt7i4sLLb5VE0jqJwKjddY7GS+2xVUdIgKQvVUUt5V4B74FXKWFGiVJNOtinZNnhYs5B01saE/LEfDdXxueYe5225I0+gM5shdsdcYAtGf5KlEdgllAKb33b/16fL4T62o8WUnNI9sn95SQQYF6cqTS0vVhPsuwFoIon9EgjAaUOljcvwNskZF5XYmaFACmKS9/buwBtHAhj5IiYkN45VOBs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTVCVXVSR0NER3UwdjcvNDdmSktPdUp4clhONWxwYUpNTkROU2lUbkRBS3E2?=
 =?utf-8?B?S3dRU2JaTlVNc2JvYkJCR1lvYkYzQzhIc1hPdjROT2NPMDNlU082anUraHht?=
 =?utf-8?B?bU9HM0M4emovRHF2aVVuOENIQXc5VmozcE5XRkx5L1hZRnpKWFNmeG1CeFJS?=
 =?utf-8?B?UWx3a3ZwKzkzNUVFb3BnTHBNVW1zd1ZSNG5raVI4d2FqOEprcVRnbWNBTEdJ?=
 =?utf-8?B?K0JvVVYyQzJoWGp5TlhJTmZtVnFHK0xXVzBOdVNVR2JjN3RhRFBibDNXckE4?=
 =?utf-8?B?ZFpQQWtFRm5Fa3NJSTNVUGQrVnhvRWRweVY2Q0tRRTZqeXgwM25SMVd2QUJ6?=
 =?utf-8?B?aWxKZXBjanNsZXFkdjRRRCtxZHg1MkJORHQ0a1pCd2g0R3FYWDVhM2U1Q2FO?=
 =?utf-8?B?OVNOR25sQmxzZk4zazVvL01nSnVhTXozd0pxaFdOVXM1dGtsNDNQNitDSWU0?=
 =?utf-8?B?dnFsOEV6R0I1d0NnZ2I0eGhZbzJ1WWxuYmozbUxjZWxNVUt2ZU1RL2pvNHRs?=
 =?utf-8?B?d2lxaTVJRUdkUGNncHgyaXNXNElFTWhDb2k2QllLMXV1cHJSa3l2RWpCcDYv?=
 =?utf-8?B?ZDk4Uk0zbEVmSXpDVGxDZ3NPLzd1RDZkNjM0YmdZVVhzTkIyUnJlWlVmZ1hO?=
 =?utf-8?B?Wk5obW5NWmtkOFd6YXF6VTJtSmw1ZFo0Q2x3OVA2VG5kaHVaTnNSNi9qYnNE?=
 =?utf-8?B?VGsrbzVVYXc0TmhjRm5ZRnZRbllJNVRFa2tXSGdrNE10UTkxdkUvaTZrWXNq?=
 =?utf-8?B?bjdISmpXdWhRSHZubnNLVnBQYTlPVGxJN2tNdC9wakhFZUI5bTJSaVdLelRH?=
 =?utf-8?B?S2ljeHlBZlprZk1uc0lZR20xSDJ3bkZPUW5oeExsY09HUmF3Z1I2R0NSMk9l?=
 =?utf-8?B?OHlzdm5oalozTzRuamNseEhNbnRoaVNoRFhERzNCMEFlWDRhWXAwWU1RQ1g5?=
 =?utf-8?B?OEJPL0NTQ2NDUkIxK0oxSy9VVnMxOHIrejE3dHAwL0FOdm5HQWtPeVd2WmtE?=
 =?utf-8?B?WEpwQUk5d3dtbTRacE5MKzJOU1pGckJ1YTI2dzBUUHEvR3l1ZW9ndndhYkZy?=
 =?utf-8?B?WDNiUm51K1pWR3NUQWdvVG1LWkdiZlJGU1RZekhNT1hBY290Y1ZkUnpBNWV4?=
 =?utf-8?B?amJZTUR6UFQvWnY1dW5FKzY4dTl6cjBZMG1LeFNIMGxGdUc0M2FETncrOEhV?=
 =?utf-8?B?QTBiRFZ2THRZOWxROC9FRmNQWGh3djd6VEtkeE5DZU1IZWpDMHlDcUhuL0tB?=
 =?utf-8?B?azhJU3REQy95aWxWdHZqUjVHV2hCOXlnSGoyM0dNcVRLbWl6ajZtK1VqTGlI?=
 =?utf-8?B?L3VraWd0WC92M0o5ZTNOVHZwZ3ZXcUVLMTR2aUYxUlEwSkN4OWRSdHEwNU1Y?=
 =?utf-8?B?R3VhM1VrQlR6c09KUklVVnV5cHVZRk1ydHI4cFRFUnQ2T3lHSXJuNVFSbVRG?=
 =?utf-8?B?OUxoVnRWWFJaOGlVSHZKTnRHV1diYlVLcWMwV2N3Y2t3MXVUVURHS2hQeklv?=
 =?utf-8?B?cTVCeElSVVZRV2dCRnFETVY1UU5MTnZuaklmSml3LzhEMDMyQjFwZGlOVGwy?=
 =?utf-8?B?ZVdaZlYyMVBqRGZLdmloN0M5cjA3R0xDaTFnV3poaXhSSk5hMDMzMHBhakNp?=
 =?utf-8?B?V0pHTUdaZ2ZNUVR6RWVxQ2MzVERIM2RaZ1Z2WG1Db1YwK3JHNjZ1QXU2MVBQ?=
 =?utf-8?B?SUNhc0llcU1XWEVVN0tGTDlMRDgzTnZPMHNtSkNuUkNwaUV4M0JxU211cW1k?=
 =?utf-8?B?d3VQQWRFNGhHTDBDQTdGd0xTOWpsRkhnSWlGQm9ZdStWVWZLT1JHa21GbUV5?=
 =?utf-8?B?OEZyN3hxTm1oUDVpSFNNNmJhT3h6WWM1T2t2aC9YdjR4UHlXajY3c2FEcFow?=
 =?utf-8?B?VG95R0JiSFhyRFQ1eUlMVG9CL3Yvb3J0Zkh4U0N5ZWVyMlZSTGtnVFBXaGE0?=
 =?utf-8?B?ejNqTkxzazlPc2kyNlZrc3BUWXIvS09mWlppanEvUlI3NG12R1JRTUo0bnND?=
 =?utf-8?B?ajBNcm9jRFJCYS9VSFZvaE04c2ZJeHl1OEQxcDVIa0Vhb3dJalU0SmJTbWJI?=
 =?utf-8?B?bDMvWW5sVUM2MWlEamgwSjU3Ym0rTlBKTVhlMVAwNkpnbzNOcTNqbVdZT0tx?=
 =?utf-8?B?MFZRTzdCdzljMkNEc0cydzQzR1ZnWXk0Sm5reXZRc250QkFzS0VPMDZ3bGQy?=
 =?utf-8?B?MVRUY0E1SGp1Z0VlQ3BuTnVBZUVLb25tRUZvWjVOZVBlMXBuKzREVlJlSnJi?=
 =?utf-8?B?YVVvK0wva1pDQk9sd1ZKNG8vUzdlUEJqaUtRVVRKVlN2NnlENEhnNHMvOFhO?=
 =?utf-8?B?eHJXcTdyZ29IYi9FMnI4UVZ5RExiTnN0dW92RnEyZXZTR0NwSHV3dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1d25cb-df3c-449f-2299-08de7909e12b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:47:27.3936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/VaVsiu26Tc5BMDseW958rcQVgXpJSNt2ponc94zrkmXQwx0tivrrop33gcrMt4VsbuEuhkfhql/TjmVRJDGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7156
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=Vasant.Hegde@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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



On 3/2/2026 5:21 PM, Sairaj Kodilkar wrote:
> When MMIO 0x18[IntCapXTEn]=1, interrupts originating from the IOMMU itself are
> sent based on the programming in XT IOMMU Interrupt Control Registers in MMIO
> 0x170-0x180 instead of the programming in the IOMMU's MSI capability registers.
> The guest programs these registers with appropriate vector and destination
> ID instead of writing to PCI MSI capability.
> 
> Current AMD vIOMMU is capable of generating interrupts only through PCI
> MSI capability and does not care about xt mode. Because of this AMD
> vIOMMU cannot generate event log interrupts when the guest has enabled
> xt mode.
> 
> Introduce a new flag "intcapxten" which is set when guest writes control
> register [IntCapXTEn] (bit 51) and use vector and destination field in
> the XT MMIO register (0x170) to support XT mode.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>  hw/i386/amd_iommu.c  | 47 ++++++++++++++++++++++++++++++++++++++------
>  hw/i386/amd_iommu.h  | 17 ++++++++++++++++
>  hw/i386/trace-events |  1 +
>  3 files changed, 59 insertions(+), 6 deletions(-)
> 

.../...

>  
>      /* update the flags depending on the control register */
>      if (s->cmdbuf_enabled) {
> @@ -1732,6 +1762,9 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
>      case AMDVI_MMIO_STATUS:
>          amdvi_mmio_reg_write(s, size, val, addr);
>          break;
> +    case AMDVI_MMIO_XT_GEN_INTR:
> +        amdvi_mmio_reg_write(s, size, val, addr);
> +        break;
>      }
>  }
>  
> @@ -2382,6 +2415,7 @@ static void amdvi_init(AMDVIState *s)
>      s->enabled = false;
>      s->cmdbuf_enabled = false;
>      s->xten = false;
> +    s->intcapxten = false;
>  
>      /* reset MMIO */
>      memset(s->mmior, 0, AMDVI_MMIO_SIZE);
> @@ -2452,6 +2486,7 @@ static const VMStateDescription vmstate_xt = {
>         .minimum_version_id = 1,
>         .fields = (VMStateField[]) {
>             VMSTATE_BOOL(xten, AMDVIState),
> +           VMSTATE_BOOL(intcapxten, AMDVIState),

Do we need to increase the version no?

-Vasant


