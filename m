Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A75FEC0E6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 17:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w55VL-0007ug-6Y; Tue, 24 Mar 2026 13:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w55VJ-0007tf-5g; Tue, 24 Mar 2026 13:25:21 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w55VG-0006Hq-El; Tue, 24 Mar 2026 13:25:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpyXBj4d+QHu0wn6OL/BgfW+qTKtcy7+Oim4vO9U9/q0hiPBITsCt6eojigo6p87jRx4saw7NfLIUiX8f5vn8xou0b5BJ3OfPfMm2Uutl6enzoCwHqhWLrCPQs8uVQhE9paMj8jfNthlSr1dGNUqdwEt4OTxH9vO4h7rCd1O3KvzsZUikAwgEvJ6OV+X0ZcpyR5Xr1nAVB2ogbk/scAVy5B99huq0jrtVvsdJKj+tJLjfzaKaXMu1KbtcW2yWZoIthwecM3Hmw2Esk2rTP0uk8tgUXSd5DE7g9g9sZoLB2MVzZETATXFTTcqXJesjWYyVLMrLVSN1wdUbQMWe79XkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7XJN5GLlu1Hheb8UivpQ5E8rSAXo5oMrB/G1NIOE2Y=;
 b=AiEO0JCWJbU0M2cT3IsmjK637StuPUd0NXMQ4c1vXTKS8NiqKjayJdZHy8PYgD17YQJFfwLiVqioOxHRoBgnboG9dfzKn5I4I9p/3GXV9Pr5EqggZyqUg1yVrheWpBt9o0ifW5CV/RR3q20MpqV5TN5mx5lxnoRj52GCyooTLwNEPKuoKo7esLVPOywCby2cU7BRTXV4q+N5AGmhkbnVMr6q9y86c0zp58QL9ap8PFx76V9KRNqPm7Bg8eYR+f5qE2gVLSaAhAkfqAztsseLBRuXYKHIdKEx2jdOIsnjzdY02anwgDGmNXG0u3OVx3kLUADj9OX7dZ4aPD5XhcEcRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7XJN5GLlu1Hheb8UivpQ5E8rSAXo5oMrB/G1NIOE2Y=;
 b=fMkHKMqMsn2UiBiFxJltkqNu0U7Ng7TbvEkijHv5inHwPNCfzfqLzhT2v6XvpPCmdKvuX0U/zJcGUPkACOv2MKhfsfaxYFZkqZBtPIHvitiW+v/XbxogBsAZbhy57YNI5X0/db/1PBArvvup4qemseKqRsrGEHTiX+AALumWCWOl3nUjpE7ZT0HMZHVVovfrWjNNhRTXmSinxVYI0r2mROikw93m1e9obeqUxn+KMB6b5JWJooCMO5wrckWNiQj5A7o/sC+YQ9P5Hg25Vv8LWmOFxNJBEjHgZzspRooSrx+lTBT23xVKFBE/jHD+O1faYV6P00zdpdesi0I1IgGd6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Tue, 24 Mar 2026 17:25:10 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 17:25:10 +0000
Message-ID: <e140428e-36d6-463b-b9b7-bfb1bd465f30@nvidia.com>
Date: Tue, 24 Mar 2026 10:25:07 -0700
User-Agent: Mozilla Thunderbird
To: eric.auger@redhat.com
Cc: eric.auger.pro@gmail.com, mst@redhat.com, nathanc@nvidia.com,
 nicolinc@nvidia.com, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, skolothumtho@nvidia.com
References: <20260323183024.4069032-1-eric.auger@redhat.com>
Subject: Re: [PATCH] hw/pci/pci: Enforce pci_setup_iommu_per_bus() is called
 only once per bus
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <20260323183024.4069032-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0067.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::44) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c23ec3-7798-40e9-e4b6-08de89ca4cdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: R0VXErh19211Xvz7AsNiRnexRXlvx1RmI2oSbE7xKFAQWt7qGHLiyibGzUwizcEOeN+mE6urehjKdIGWmJYcFFLfLVhD3TI7WoymE1AueaU6Esri00QEaKVK0O/xk7HWAuSf/h0GeCvUDAdWIENQvOdjzuKyh+QPtxEZ8ORF/KGNpV838ydEfIE8vZ6ap2wmfD43uayITAZk85nT6Txaza9GEcq2mrlIzZ77z8ReqMoNYrpdfmaPA5H0/5j0z3OfYMgooKd6FVcBg2Xo5hzg4YWx8eIjn+j784+lUyfD9RmqS5BTEKfgBw612MgG8CViKNhsZy3HLtXzgecllWG8jpH/JDQreiTwB3If6pQhuX2vNLofuXulBGJAvyaC4sLLFqfX1ca17miLuBO9OFeVGDKnTQSGaKOQDibSwVy45jNZ6EgCTBrjA/AZdG+ZLA3fj0/AbjEAsnyIuk+1vAVw8m7prWx26z8JcGVfBe/wXN8yCdKUL8MtrkQ/ztrErhS9zyFPwW2bqwgkI4Z9/ktc8B3SncZx7EqPaIjUnelfcV/xdH7FIobaIOAHJR7mjARqmGYkjrkfFnetMhMjm3OZc1A2HNxDvwp1AxuF3Dj2dv7PIBGhLg5gTKE0yEBUCDDFI987CCYwImdSmzCQfRrVVgkgf/cX2q1bQuct11eQu4RKjP96I71Lu3DYwWnLUz4eeZlzJLEC/WreGd3BREYOCWNtWgNw95u3uPltgdFpe0E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VER5d2ZMK3ZxTUt4YURhcWZtelA4UEZ0VmJ0dWN4YTdlSjNmS05HekpIakxI?=
 =?utf-8?B?M2RQUUlOdzhJZ0xLcTl2aEtuSVVIYjFUdmRNMEhtZGFYMjUrbERmREhvNmcy?=
 =?utf-8?B?a2xGcHdXZm96bW5RNk1iRFdXSzFZM3Q2YVZsZGNwRll1U1hHOHJnVTFkV1dV?=
 =?utf-8?B?SGMxcVp3Mm9jOGIwZTJycTBoVGFCQkRoVm9ZUm5NMm1NamxYWW5IMmVxbERw?=
 =?utf-8?B?aVBJQ3JWK2FOUTZmSWlENVpjbGJjSXE0Z1h3NU16bmUwaXY1QzBZMUZZYVZF?=
 =?utf-8?B?Rmg0R3dBSXVBTE1NWmEvMXZXai9iQ0ZCWTM4WS9XQy9kUzJaWmRNd2o0VXVk?=
 =?utf-8?B?T0NONTh0K1JHZEQ2WVZ3eWt0YThuQ1QrYTVrbkJ3bVk4dmgzbHZNYVBEZjA4?=
 =?utf-8?B?SUh3bVF2QlEyUlpqakpiN1ZubXZHNHBoVDJZdi9JT1JCS3lSV1lVYk9QNmtT?=
 =?utf-8?B?NEVTSHd6VSt4blFjVWZZQzZWNEl2dktzay9oTkluMERNSG9BTVBtOTQyTzRW?=
 =?utf-8?B?a3dBMy9xVUdYUG5ScHU5bVJ5WnQrcTU0cXZqTjY5ck51dGdHWVRGZTFWWlRv?=
 =?utf-8?B?SDJlSW1hWFIybWJKVXQyQVY2bEZkUXFKL0d3cVFIN3NHV3JSd3hqdzNvUVZi?=
 =?utf-8?B?aGpnVnJXbmVQWnVQakxxWEtDc2ZJN2djOVRVMXByeGk4Mm5jVTRxdFRUcm42?=
 =?utf-8?B?T3RBYnd0VlRaTnFHTTNzdlA4YWdXNjErNXZibDZyKzFmQlhaQ2pWelo0RndK?=
 =?utf-8?B?TVI4V0NVRUxDVkM1U3N6UXJRWHA2SXNiY0E1WEsxWVNDV3RQMU1Pd2FhbEJI?=
 =?utf-8?B?SExyRnVxbWF0amtPT3BjeUhVdyt3OGRXbHZja1JKT09rMDRkWXdIeTZsNXJG?=
 =?utf-8?B?UVkxYUwxSys3aWR4WWZNcnRwZTRJaDNETlY4S1g5NHZiWTNITlYvejlsUzhh?=
 =?utf-8?B?T2RPM1lxaldhdHFZeVBhU0s3bTc2R0JCUVFxaWJqRmg0emJRYnRybFFLMHNu?=
 =?utf-8?B?N2hNMWZRUEoxeFdFZVpqdDdOZmdQbEN2VHNBTGpSdmp2b0t6YUg3ZUVOQXFz?=
 =?utf-8?B?V0VEUS8vNzM2SWlvQWdjZkdiQ2dHUjd5WGVpNEVudHpFd3JqUFlIMWdlRkNw?=
 =?utf-8?B?VjFqdk5oTFdSRGd0M2pJVWRqa1ZLR2ZmMEdUZFUzT2J1SUE0ZlZXMzRHRVI1?=
 =?utf-8?B?R3pPeW9BT3dwdTBVRVV1ZTBIZENzdkJObXhtTUxLQXc2V0N3Vlh2d2FxZzdR?=
 =?utf-8?B?RjdlZ2psVS83eGMwNlZOek9OSnhqU2dKaFlDdlB0cm51ckg4aDQ5Tm5vS0xH?=
 =?utf-8?B?dmRlM0N3bi9IeFFYQ1U5aVYvRGpnL0ZHRHVCL0dHZXh1b2lLSkdNQk1mN2ZL?=
 =?utf-8?B?cURVVGNTQ0tsOGZDdGR3dFhjNVNOdU1XRkFpOWM3dzgycXFEYUdwdFBsZlA1?=
 =?utf-8?B?SVR1T205dDNZTVZYTURIQ3NPVk1JcGlkb3JmdCs2bkRmZTJJSTZsZlFlS0Zt?=
 =?utf-8?B?azgxQTU4eXh4eThVNUtUT1YyT0hjR1ZmcVkxYnhyN2FUT3d1ZUowdk5NL05G?=
 =?utf-8?B?MERMcW0wZnVpMGlrMnJlcTk3K0ZhenJCM2d1WkRYUzBsM0lVcVJaZ1ZaVzFS?=
 =?utf-8?B?YXZQOFRHWitiWVQ5K0p6UGNORUc0YURrY2pIT0RwY2ZSWERFZ2t4dkYyb3JS?=
 =?utf-8?B?OGJDbGpHYTFiTkFVaFU4ZE9qdGp2YjRvZXIzbDhpL00wc3BoWHdUVU9yekJh?=
 =?utf-8?B?NWNYWE9abUdzbVhEMTFkWjdxUlJzMmtJZDVLaVdXU0ZWMUJuMXZxSEZIUStB?=
 =?utf-8?B?bWJEeWtxaWF0VlJDTEpianZwb1JUMmlTaHdUNkZxRjlreSszTnY2bXl3bEY0?=
 =?utf-8?B?RDlIQ0NqWEk3MWhpSG1tV3VZUlk2UHZnKzJhRldsTTBwdFpjSXkwRUxSTXN5?=
 =?utf-8?B?QytxUHNrYUpJNmUwNU03K1NDNVdROHl1MGt0aXRBd3VseWxFdVJkbEdJVkFi?=
 =?utf-8?B?Y0lwWmtnYzVPUXFDMXRsYW9sZm1MUC9HZGc2eFZaNXNiWGhjelhzN3QwVGU2?=
 =?utf-8?B?bnczQTBJNFE3Z21YTlNBNldwLy9EcmxwRHNRMHE4WVc3NjVtRTVQZ0E4MHdw?=
 =?utf-8?B?UkNrdXA0V2cwQ3dJYjJQMDNkd0l6ZzhoSWNDemxNNE9DRDVmbXB4L1ZFVkla?=
 =?utf-8?B?MnFpdkIrbHJ3QzlKYVJOaWw2bzMzVEgrT3FkZDQ2eE5GL21BZDR6L0l1Tjhq?=
 =?utf-8?B?bTJCUDhsYWlVcVVqYTc3b1FSYWxQWlhUUGZ0NjhQR1c0ZGRrbE9sSklTb0hO?=
 =?utf-8?B?ejNxVldTNnRSL1NxbWFDT2gwYk9Jbks2RGpXYmlnQjBWV1RGUVJ2dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c23ec3-7798-40e9-e4b6-08de89ca4cdc
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 17:25:10.0594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ec1VrmZUbAnjRs9hvK5aOY9QCBkqTYlSL1y3Dco55oWLfD2NlWEdjNROXexaPKPDKaB/JViW8V3Vr4V/nZ8nMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=nathanc@nvidia.com;
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

Hi Eric,
> Currently it is possible to attach several arm-smmuv3 devices to the
> same bus although it is a wrong setup.
> 
> Change the prototype of pci_setup_iommu_per_bus to pass an error
> handle. This latter is set when iommu_per_bus is already set and
> used by the single caller (smmu_base_realize) to report a useful
> error to the end-user.
> 
> While at it document pci_setup_iommu_per_bus callback in the header.
> 
> Fixes: 66d2f665e163 ("hw/arm/virt: Allow user-creatable SMMUv3 dev instantiation")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  include/hw/pci/pci.h | 16 +++++++++++++++-
>  hw/arm/smmu-common.c |  2 +-
>  hw/pci/pci.c         |  9 +++++++--
>  3 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 5b179091dee..f2448e941a0 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -863,7 +863,21 @@ int pci_iommu_unregister_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
>   */
>  void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque);
>  
> -void pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque);
> +/**
> + * pci_setup_iommu_per_bus: Initialize specific IOMMU handlers for a PCIBus
> + *
> + * Similar to pci_setup_iommu but enforces that the iommu only protects
> + * @bus downstream end points and no other bus hierarchy
> + *
> + * @bus: the #PCIBus being updated.
> + * @ops: the #PCIIOMMUOps
> + * @opaque: passed to callbacks of the @ops structure.
> + * @errp: error handle
> + *
> + * Returns false on failure with @errp set, true on success
> + */
> +bool pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
> +                             void *opaque, Error **errp);
>  
>  pcibus_t pci_bar_address(PCIDevice *d,
>                           int reg, uint8_t type, pcibus_t size);
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 58c4452b1f5..a3aeb5a8796 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -981,7 +981,7 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>          }
>  
>          if (s->smmu_per_bus) {
> -            pci_setup_iommu_per_bus(pci_bus, s->iommu_ops, s);
> +            pci_setup_iommu_per_bus(pci_bus, s->iommu_ops, s, errp);
>          } else {
>              pci_setup_iommu(pci_bus, s->iommu_ops, s);
>          }
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 2c3657d00de..5610193783d 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -3307,11 +3307,16 @@ void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
>   * IOMMU ops are returned, avoiding the use of the parent’s IOMMU when
>   * it's not appropriate.
>   */
> -void pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
> -                             void *opaque)
> +bool pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
> +                             void *opaque, Error **errp)
>  {
> +    if (bus->iommu_per_bus) {
> +        error_setg(errp, "An iommu is already attached to this bus");
> +        return false;
> +    }
>      pci_setup_iommu(bus, ops, opaque);
>      bus->iommu_per_bus = true;
> +    return true;
>  }
>  
>  static void pci_dev_get_w64(PCIBus *b, PCIDevice *dev, void *opaque)

I verified that assigning multiple SMMUv3 to the same bus is prevented 
by this patch, and confirmed that basic sanity testing is unaffected in 
the normal case with one SMMUv3 per bus (GPU passthrough with CUDA test 
apps).

Tested-by: Nathan Chen <nathanc@nvidia.com>

Thanks,
Nathan

