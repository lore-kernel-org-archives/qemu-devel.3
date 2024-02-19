Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5B1C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 09:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbzYt-0006ZZ-Er; Mon, 19 Feb 2024 04:03:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rbzYr-0006YV-RQ
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 04:03:42 -0500
Received: from mail-dm6nam11on2042.outbound.protection.outlook.com
 ([40.107.223.42] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rbzYn-0008AI-F7
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 04:03:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLQC5+zBsS8eTIfBwMUHkaB1nJMexH9cMBAB1eq3B6x50PhUDWdITBUBVblgrLial3Ac0+S43iiBY3J4eWIkIvMxswob2E3Zi377LsxLXkTdCC6j/y1/PYunhBE8MaNTq7kiwo0wFctjmlZHo19kQ/l1E03b0wfgLhCBfvhfYte0K1VPxcg3n9jPBTbtKYwCnlEdj+beyKO+/R5ACFfNQvMny945abA2Mf1MbKzBnZa2mziDGnpLsc8gHizKhl08h0GL6V/2vqz0+a5VfRpU8kEgU3nks6oJTSr9YgHcsZCQSb7WlDccUI9NXDZmgScEnaZjswT+EcWsFxx8AN5DQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8QQXZx0rHPo8Gg2f2YnGuwFuqpNc03S/hoHPr5M8eo=;
 b=ZOXGwT9FPCO6raUnOZu3Apxx6Woa6N+Uk8dKjXTH9317j/1mziwPk+ytc+SkKQVeRuvtIF3xJ3Grn+t/mllh9RRoLflpFx3SOZgBWVAlbbzu2wNnMq5rcDIkaVE222X8+z+TEM8ZnNaPL81McS/B+Blv+TFk9yrJU3DMn6oYlVhLxTI44FalfAX1oRRdibvTj1DUVWBGlCTGlh3kjEjvNSGd8qHiXVijuUa09MIi6+CLEewLbfCxddGNO+zzm0biOa1+RPzTUlMNS4zHS5yocIuUFfAgV8mmQ6uQQE2GKq1ZBXjBrkTRmPxC78lDz6ONLTqsgsYsywm1RVPgT7PG4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8QQXZx0rHPo8Gg2f2YnGuwFuqpNc03S/hoHPr5M8eo=;
 b=QzUIs8QFP3c0YD7KgQO0K//oR+zXbuKUaNPw6T8XQ7k73jFqi0JfPRQaUprg3xhlLq1b3ITTYVK7cEyo58dnPNmNHuYFFzNph/cBj02vNQO+4XowXRM6/QuPKPc6oSJixqOIVcu771q+Fdm27cS9zBMXpKpv5WLdPMHFgWFDHE5kDXZ7DZ6WYoFSR6I7Ic8e6/Sa82HeJ/bOm7Hl+72FaezTRKktS54AgKWj8DzE5dWplfn82gA7ZO2RauoNPyu3L3tEaxMVpkUXUHeMLWlBfVwHogWWVJg/pIm1SptvXPhSsvUIhzqvR8+LCQutCCxfxOnXnCQNevDacL5g6Q2OdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SN7PR12MB7348.namprd12.prod.outlook.com (2603:10b6:806:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 08:58:30 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7316.018; Mon, 19 Feb 2024
 08:58:30 +0000
Message-ID: <62269e45-cfd0-43e2-a08b-6b3091a34778@nvidia.com>
Date: Mon, 19 Feb 2024 10:58:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2 2/8] vfio/iommufd: Introduce auto domain creation
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
 <20240212135643.5858-3-joao.m.martins@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240212135643.5858-3-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0071.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::35) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SN7PR12MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: d2571cd7-036d-4fc0-bb5c-08dc3128f19c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f5YKs8eXOeMRzvHo5VA4aRZtS6fzeCmR5mBO2IAwBm5Eu1U9WVcSHfkbOLrOPEXTEtDcLUA0yNyyvGlK2i70uBmXTM+ocjK3PLk+BXzktypcLDbT4gfePUA9BkZirmTmQArEafkG9yw2KNCUX/pqoBcjv+CVHsrI0GHWsKGLtOuW9UDXePQEIIsznybbFGw9jHmL294DCw+g4mQBEWYD8/7zyNPrK6hgOmGyCZ1wlmvfOlMo14q9anbalGYyrVapEPJEzM3Cx4W/OMlvRbAG+eQNoVVEqK8CLpKXjmy6ydkvnfKSN0t0MHdkLuvMADGSEl7zv7UywLI9r8yvEJEIzom6gAoOuOG/MD7pPgjufykxRnXX7AURiE7AObP+gBOfx3sbYZF8y3RxWp/Nq4YfXFev+ze6yTrhYZTovLO5jl9Bj7UntxVm8GudILzxj5Sab7xS3n0sw9MxBTb46TpEt31QLDKiHBV1lS8RMnzPOvY2ui3tdl41ONK7rqZRhBy3Rhfiy5QHv9y+ruXHR7HFbIDnPMet+iHr6+frzePCzoIbSX3K0Be7Z5u3UHHjeKwq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(230922051799003)(230273577357003)(1800799012)(451199024)(186009)(64100799003)(6486002)(6506007)(6512007)(478600001)(53546011)(54906003)(316002)(6666004)(83380400001)(31696002)(86362001)(36756003)(38100700002)(2616005)(41300700001)(107886003)(26005)(66899024)(31686004)(2906002)(7416002)(4326008)(5660300002)(8936002)(66556008)(66476007)(8676002)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZElCVEczM0dDdmlIWjZtcE9BaGFzTnE5azhHZEpCM3AycUpvVk5kM1ptNU5a?=
 =?utf-8?B?ZXdlMVgvUG15aEZTSUtvYTdjSnMrbVBoaDlDWFlROW1mVCtFaU02VGUzNHh5?=
 =?utf-8?B?QmY4ZmJTanlySFJDQ1FkNFpzMWdRZkVPS010M0ZwQjVwUEZrQmhRc1YvZFVx?=
 =?utf-8?B?VlRwSGpLaGI2dDdtT01wNnVBYUJWTkQ2NmlYZDhxN1pjWkZxVUNnb1pRVGVD?=
 =?utf-8?B?M1pBNDlJTzRnN0lSMFpKNXJ0bGJyb09GcVY1WlRmR0NvV20xMzFybnoyMEt3?=
 =?utf-8?B?VmFCYytzT0xMaDZaYzdweFpMckdrTlRyRGo5cStwZytVZFRSV0VSakFjZEVy?=
 =?utf-8?B?b25lNE5sMURpbFd5SGZyaFZsdGNJZ09pMVFwT0t2ZnRGYllOWVU5MEE5djZC?=
 =?utf-8?B?djhkNnBKazNnMlNINnh5d2c4WTdhQWxKOWRWdS9OVFNDcnFlTUdENnFjcU4z?=
 =?utf-8?B?d1AyRThlVmF5VEhLZE9mYVRzTVo0NEwxWGdqYitUd0pUbE1OS3g3N2k4SU45?=
 =?utf-8?B?TlVkMmswZEJBbkNkTzhBc01USmN4QjQvb3p3cGJ6UUxIc0dyRVRhRmFXY1Zq?=
 =?utf-8?B?WTJSRm1GRHBoSlRBMHNJSHJBdUZZOHJQbmtubkxZbFJCYW54WitoK3JKRzNR?=
 =?utf-8?B?LzBibGkvNm1VdG4yY2t5VjRzVjc3K25SZ3ZyeEVXVkxqZEdGeDhsMjZUQTdn?=
 =?utf-8?B?ZDVES09nVytZVTBGUGxYUDZLU01MOEFUTHkvOFU3cGd1aEZFRG1wWTh6T0pm?=
 =?utf-8?B?TEQvdHJUdERWQllPb3NWUmJVcWtPa0pJNklJd24xRjcyNElEYjR4SSswNHI4?=
 =?utf-8?B?V2NTdkRPNVZ0ajdKQU56aEFyMnZlUnBOb1Q0czcrUHgxYmI2KytxM0lCSUF6?=
 =?utf-8?B?L1lGWmxNV1BuSDBjZ3RFMjlyT05jUys2anlsRVlFTm1Uc2xxSUdxSUZ4UU9l?=
 =?utf-8?B?S3IzZVNjaDdNbVZ4cUhGVDFaRm43bU9ZWm1aME11Nk9iMEhaaDVnWUN3eDdH?=
 =?utf-8?B?S2t0TzFJam1vcUNsWVUrNWhrWkxkZFQ0RU1EZ1NqS1A2MGVHdE03VDI1VkU5?=
 =?utf-8?B?eVhEbmE1K2pMK29nbzAzck5lY1hpaThESnYxWGJVSWwrRSt4MHJqRW5wRHlW?=
 =?utf-8?B?NFdjV04wMjlxbGZQcGRjbld3L2k0cytlMmhQbk1KNlJQeEJFNzJpbVN5YmJw?=
 =?utf-8?B?QmR5VTBNME90T1FpVm1yNlYvWW5TcGk0OWdZN3d1L0R6eXdNUy9wMjRjTVpH?=
 =?utf-8?B?ZGdwV2xiMTU0THZ0OUZETFR0RGFOUkFHMWQ1NGdKenlwVDVPMVpRV09lQ2RH?=
 =?utf-8?B?eWtGbjNEVEZxNjRSc1RNM3YwcXlwaC8xNHViVEQrU0lZS2dsQ2U1aHhURlFD?=
 =?utf-8?B?a0liV1oveGpaN0tGYy9UOVVSTThPOW9lL2o1NXNXMmZROVlRYWp0VVhVcjA3?=
 =?utf-8?B?SzRMUmhSNnh4M3hZYUtKeWFGa3MvOXhEeDA2WW5Mc29pRVQyam5QZEJhb2Qw?=
 =?utf-8?B?dkZtNDJjKzVsZXh5VnVhaEpZcm1pRDQybitTUTYrYWN1WkltaFFDUXRENDRs?=
 =?utf-8?B?WTVBNC82L1BlQmlrQ2FMTzd3Y1E4Z0xoMCsyVmJKdng5YjBSZitKVUtSNFFE?=
 =?utf-8?B?aVJNUllYNkxHWW10OVRJaTRnblZkb2tLalNtWDVXeFNSUG1paXZhWVdCb0lL?=
 =?utf-8?B?Z21EUVdOcllRTitLamwvMXZuRkw3TWc3bk90SkthYjQvbmVvU2JhNS9GRUpF?=
 =?utf-8?B?T0k2QnFLS0owMGQ3bEduLzBxRUdodHBjMlFRSi9uS3ExWEs1V3dNZE04eVFt?=
 =?utf-8?B?blpCTDdJN1Nrby91K3dHOW1naEhPZzRETW16RmhUelpQa3BIWkUrT1lVSzMv?=
 =?utf-8?B?QnlNOHZSb3lqVm5iZXRXWTJvZ1BHVjRFejRGaDhWd3JSbVEvUGo2VFB3cDZO?=
 =?utf-8?B?ZkEzRjRrc2FzYVVHbDJHbll4b3NSZlBLQUVMRUZGY2Z6aS9JdFdoQW53eFdK?=
 =?utf-8?B?T2FCOXVIc3ptT3JadmYrYVpnSVJUVnJxMHVTaG0zY01RK2psVUNJR2VWS1lR?=
 =?utf-8?B?NzA1ZjJkYWt1UkM1b3JySzVHd0ZldnZRbVR2VnkwZnV4T1dhcnNnUFdQRXMw?=
 =?utf-8?Q?gb9n007GbVDCV1rit0bGiaZIM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2571cd7-036d-4fc0-bb5c-08dc3128f19c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 08:58:30.3723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUoobrXPAZ6msIO+mhleJdA5VquYUtrjKvnIOHM5Wo5hfVqDIfevlyKImk86PiVfcQ5reiYizBjWKfOXDtNh0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7348
Received-SPF: softfail client-ip=40.107.223.42;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Joao,

On 12/02/2024 15:56, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
>
> There's generally two modes of operation for IOMMUFD:
>
> * The simple user API which intends to perform relatively simple things
> with IOMMUs e.g. DPDK. It generally creates an IOAS and attach to VFIO
> and mainly performs IOAS_MAP and UNMAP.
>
> * The native IOMMUFD API where you have fine grained control of the
> IOMMU domain and model it accordingly. This is where most new feature
> are being steered to.
>
> For dirty tracking 2) is required, as it needs to ensure that
> the stage-2/parent IOMMU domain will only attach devices
> that support dirty tracking (so far it is all homogeneous in x86, likely
> not the case for smmuv3). Such invariant on dirty tracking provides a
> useful guarantee to VMMs that will refuse incompatible device
> attachments for IOMMU domains.
>
> For dirty tracking such property is enabled/enforced via HWPT_ALLOC,
> which is responsible for creating an IOMMU domain. This is contrast to
> the 'simple API' where the IOMMU domain is created by IOMMUFD
> automatically when it attaches to VFIO (usually referred as autodomains)
>
> To support dirty tracking with the advanced IOMMUFD API, it needs
> similar logic, where IOMMU domains are created and devices attached to
> compatible domains. Essentially mimmicing kernel
> iommufd_device_auto_get_domain(). If this fails (i.e. mdevs) it falls back
> to IOAS attach.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
> Right now the only alternative to a userspace autodomains implementation
> is to mimmicing all the flags being added to HWPT_ALLOC but into VFIO
> IOAS attach. So opted for autodomains userspace approach to avoid the
> duplication of hwpt-alloc flags vs attach-ioas flags. I lack mdev real
> drivers atm, so testing with those is still TBD.
>
> Opinions, comments, welcome!
> ---
>   backends/iommufd.c            | 29 +++++++++++++
>   backends/trace-events         |  1 +
>   hw/vfio/iommufd.c             | 78 +++++++++++++++++++++++++++++++++++
>   include/hw/vfio/vfio-common.h |  9 ++++
>   include/sysemu/iommufd.h      |  4 ++
>   5 files changed, 121 insertions(+)
>
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 8486894f1b3f..2970135af4b9 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -211,6 +211,35 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>       return ret;
>   }
>
> +int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
> +                               uint32_t pt_id, uint32_t flags,
> +                               uint32_t data_type, uint32_t data_len,
> +                               void *data_ptr, uint32_t *out_hwpt)
> +{
> +    int ret;
> +    struct iommu_hwpt_alloc alloc_hwpt = {
> +        .size = sizeof(struct iommu_hwpt_alloc),
> +        .flags = flags,
> +        .dev_id = dev_id,
> +        .pt_id = pt_id,
> +        .data_type = data_type,
> +        .data_len = data_len,
> +        .data_uptr = (uint64_t)data_ptr,
> +        .__reserved = 0,
> +    };
> +
> +    ret = ioctl(iommufd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
> +    trace_iommufd_backend_alloc_hwpt(iommufd, dev_id, pt_id, flags, data_type,
> +                                     data_len, (uint64_t)data_ptr,
> +                                     alloc_hwpt.out_hwpt_id, ret);
> +    if (ret) {
> +        error_report("IOMMU_HWPT_ALLOC failed: %m");
> +    } else {
> +        *out_hwpt = alloc_hwpt.out_hwpt_id;
> +    }
> +    return !ret ? 0 : -errno;
> +}
> +
>   static const TypeInfo iommufd_backend_info = {
>       .name = TYPE_IOMMUFD_BACKEND,
>       .parent = TYPE_OBJECT,
> diff --git a/backends/trace-events b/backends/trace-events
> index d45c6e31a67e..f83a276a4253 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -13,5 +13,6 @@ iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=%d"
>   iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, void *vaddr, bool readonly, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" addr=%p readonly=%d (%d)"
>   iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>   iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
> +iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
>   iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d ioas=%d (%d)"
>   iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 7d39d7a5fa51..ca7ec45e725c 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -219,10 +219,82 @@ static int iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>       return ret;
>   }
>
> +static int iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
> +                                        VFIOIOMMUFDContainer *container,
> +                                        Error **errp)
> +{
> +    int iommufd = vbasedev->iommufd_dev.iommufd->fd;
> +    VFIOIOASHwpt *hwpt;
> +    Error *err = NULL;
> +    int ret = -EINVAL;

The -EINVAL initialization is not necessary.

> +    uint32_t hwpt_id;
> +
> +    /* Try to find a domain */
> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
> +        ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, &err);
> +        if (ret) {
> +            /* -EINVAL means the domain is incompatible with the device. */
> +            if (ret == -EINVAL) {

On error iommufd_cdev_attach_ioas_hwpt() returns -1 and not -errno, so I 
guess we need to change it.

> +                continue;
> +            }
> +            return ret;
> +        } else {
> +            vbasedev->hwpt = hwpt;
> +            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
> +            return 0;
> +        }
> +    }
> +
> +    ret = iommufd_backend_alloc_hwpt(iommufd,
> +                                     vbasedev->iommufd_dev.devid,
> +                                     container->ioas_id, 0, 0, 0,

Should we explicitly pass IOMMU_HWPT_DATA_NONE instead of 0?

> +                                     NULL, &hwpt_id);
> +    if (ret) {
> +        error_append_hint(&err,
> +                   "Failed to allocate HWPT for device %s. Fallback to IOAS attach\n",
> +                   vbasedev->name);
> +        warn_report_err(err);
> +        return ret;
> +    }
> +
> +    hwpt = g_malloc0(sizeof(*hwpt));
> +    hwpt->hwpt_id = hwpt_id;
> +    QLIST_INIT(&hwpt->device_list);
> +
> +    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, &err);
> +    if (ret) {
> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
> +        g_free(hwpt);
> +        return ret;
> +    }
> +
> +    vbasedev->hwpt = hwpt;
> +    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
> +    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
> +    return 0;

I think we need to improve error handling in this function.
There are various places where err is not freed/reported, not NULL-ed 
before re-used, or used in error_append_hint() although it can be NULL.
If there are places where Error can be ignored, we can pass NULL instead 
of &err.
Plus, errp parameter passed to this function is never used.

> +}
> +
> +static void iommufd_cdev_autodomains_put(VFIODevice *vbasedev,
> +                                         VFIOIOMMUFDContainer *container)
> +{
> +    VFIOIOASHwpt *hwpt = vbasedev->hwpt;
> +
> +    QLIST_REMOVE(vbasedev, hwpt_next);
> +    QLIST_REMOVE(hwpt, next);

Shouldn't QLIST_REMOVE(hwpt, next) be moved inside the if?

> +    if (QLIST_EMPTY(&hwpt->device_list)) {
> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
> +        g_free(hwpt);
> +    }
> +}
> +
>   static int iommufd_cdev_attach_container(VFIODevice *vbasedev,
>                                            VFIOIOMMUFDContainer *container,
>                                            Error **errp)
>   {
> +    if (!iommufd_cdev_autodomains_get(vbasedev, container, errp)) {
> +        return 0;
> +    }

If errp is used in iommufd_cdev_autodomains_get() eventually, we need to 
make sure it doens't contain an Error object before using it again below.

Thanks.

> +
>       return iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
>   }
>
> @@ -231,6 +303,11 @@ static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
>   {
>       Error *err = NULL;
>
> +    if (vbasedev->hwpt) {
> +        iommufd_cdev_autodomains_put(vbasedev, container);
> +        return;
> +    }
> +
>       if (iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
>           error_report_err(err);
>       }
> @@ -370,6 +447,7 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>       container = g_malloc0(sizeof(*container));
>       container->be = vbasedev->iommufd_dev.iommufd;
>       container->ioas_id = ioas_id;
> +    QLIST_INIT(&container->hwpt_list);
>
>       bcontainer = &container->bcontainer;
>       vfio_container_init(bcontainer, space, iommufd_vioc);
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 9c4b60c906d9..7f7d823221e2 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -93,10 +93,17 @@ typedef struct VFIOHostDMAWindow {
>
>   typedef struct IOMMUFDBackend IOMMUFDBackend;
>
> +typedef struct VFIOIOASHwpt {
> +    uint32_t hwpt_id;
> +    QLIST_HEAD(, VFIODevice) device_list;
> +    QLIST_ENTRY(VFIOIOASHwpt) next;
> +} VFIOIOASHwpt;
> +
>   typedef struct VFIOIOMMUFDContainer {
>       VFIOContainerBase bcontainer;
>       IOMMUFDBackend *be;
>       uint32_t ioas_id;
> +    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>   } VFIOIOMMUFDContainer;
>
>   /* Abstraction of host IOMMU legacy device */
> @@ -136,6 +143,8 @@ typedef struct VFIODevice {
>           IOMMULegacyDevice legacy_dev;
>           IOMMUFDDevice iommufd_dev;
>       };
> +    VFIOIOASHwpt *hwpt;
> +    QLIST_ENTRY(VFIODevice) hwpt_next;
>   } VFIODevice;
>
>   QEMU_BUILD_BUG_ON(offsetof(VFIODevice, legacy_dev.base) !=
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index 4afe97307dbe..1966b75caae2 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -49,4 +49,8 @@ typedef struct IOMMUFDDevice {
>   void iommufd_device_init(IOMMUFDDevice *idev);
>   int iommufd_device_get_hw_capabilities(IOMMUFDDevice *idev, uint64_t *caps,
>                                          Error **errp);
> +int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
> +                               uint32_t pt_id, uint32_t flags,
> +                               uint32_t data_type, uint32_t data_len,
> +                               void *data_ptr, uint32_t *out_hwpt);
>   #endif
> --
> 2.39.3
>

