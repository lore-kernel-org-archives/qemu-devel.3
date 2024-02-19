Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4776AC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 09:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbzyb-0005MN-BP; Mon, 19 Feb 2024 04:30:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rbzyZ-0005M4-Hv
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 04:30:15 -0500
Received: from mail-bn7nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2009::600]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rbzyW-0004Hy-Ur
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 04:30:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9isjwPRF1OWdkOtE3EG21p/zHAU778OkfLa8RMb7viRIr4GgmvraI9xVCZJfixsEQAEc6/IuH4kwJ7sM8tQ1CO0gP3LyV7xqBLG7SplVWTgHzzWEhUqfIAYW5HTZxv4MiKYt2FvBPc7e4iB10izPvz5yCrjilVkIUUdz7AlaUyZvJfpsxlh8Vr2UoS+x/QtgSRu2v6eeCJFiLku7hm+Lm2U5SFw8ra6//IH1g7WFqfCVozJbvoiwxtsuLS+QnmJqPxg3UkgKIG5oYT4KnHIyp/kN130Od6vUyyluYXapSLq7f48cO9w9JrE+eZ8J7CLMXzlPGK3bwK5BK2yslXH/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1D1KSPbi3/r1tAPS+L+V3jDsshvK4udFKYjBBILvLI=;
 b=Cp9MHZqA2saT47lzKiiWjNsvDYQJFArO1vVMfpKwNnaVMChBz2n0J3fXYSUTUGtrC9OFVKOZUVSyQHwYVKDVxFEbOs4MXSNrQU+od0CfKQlvqHiHW2PA0ccCxKitMxQ6v/lQ5d4Q6L8j6xamFht2xaN5+lAfHnfzMBvRL20Wl20Lg31vO16ByVxwDhyVpbwVzy8iJeukpVsvtbCdNLbi7tCL8mWJI58uS250zOe5QmP98ulgVaDZ4NTsbOg9D90nM9oyf5tbISJVeY+3d69ErgupZTRst7z7EBFRAzY+u7VWlZX3uNPz5JexD+DRVtryxN0ZwXVuVys2RJm18h9nng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1D1KSPbi3/r1tAPS+L+V3jDsshvK4udFKYjBBILvLI=;
 b=MbTeE6D+MKFCfCMrxWFXvq4R8xanaJ0HC/Pih5+RHs4DaAVtTfKLcZ2r9M0vPrRkoOflouf0sUrmG0UWF+BtgMIhXgb/rSpcZK6nv2K/gIVNUQNsM/NLulTGWbCKotTXAX+2uxfBTOEbxBB9P6tqVogC1rdifp3w5DuJD4G2xFUnNMPPaMAHDvhjc08lVUATKj5sXG391fB0beKAjo0lA8P1ZXzwk3vKayYNFnk0fCFOm6KpIyMalVlVp9jrkDB6fY7frFmCat9uNK0mLs9A68VQwjto1zxn76kJ/KRpaS22Xki8FnoaV9wiyhDPI8/6TKn6xVlwiDIUm1xDnrAExw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 09:30:07 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7316.018; Mon, 19 Feb 2024
 09:30:07 +0000
Message-ID: <717d6632-9038-4ffb-8193-511e62da5311@nvidia.com>
Date: Mon, 19 Feb 2024 11:30:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2 5/8] vfio/iommufd: Implement
 VFIOIOMMUClass::query_dirty_bitmap support
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
 <20240212135643.5858-6-joao.m.martins@oracle.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240212135643.5858-6-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0374.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::26) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a801bcf-debb-46d3-3853-08dc312d5c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+fIKQGL19kxPOCwdr4LiiIb59EJfLG/nJRldPlsz2KQ49zARe7fKNYnyGekcxVYcwGbv3oJNVfL31OXUr1qAgCv+/ML2R6Zdfk2YKr7qFp3sSaDjCjCtl7gEhJJQhLRB9//L0TSQGEDl945BVJtvJzPh9WzBRdPFWw2Jpg08e9EogldKO6Vqrnal/YJkNHXxxmFFvsJs14T+1akXHWXA3DBfQk2HgswkkvzgaXWachOjF7s5ti4xdXjF9XY6ULBxamjhqMEXQRX4jpGvR9V34hdzRjdBTNRdW6epRIjyE08PoXdpOYXVQTO6HeqxOk/XQMb45/v4Vj9S9bf1I5mLyv6EnpICnBuO7W1b35jGWuoOyBiSi0MNvVh3/mInmxByQGWc2zVjEJ61FN/iBG/M1Fhg3c5syKYsHzpZ2S8UVP9/o0gv782tPRb413gxt6VU4bjGK/aQo5FCJi9ISsEIlm6BHX/BY3N3E5XGlMJqVznspe4cFw44C0UF6VIvQvwBwAWUIny0WswXnVnk36Wym6zdGry/cDlJ9Z0/hzxVAljnKWgrOKL02Iok4ud4sAr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(230273577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6666004)(6512007)(478600001)(6486002)(31686004)(41300700001)(2906002)(4326008)(8936002)(5660300002)(7416002)(8676002)(53546011)(316002)(6506007)(66476007)(66556008)(66946007)(54906003)(107886003)(2616005)(86362001)(31696002)(26005)(38100700002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUh3NlZPbmdOeFRYQ1YzcjFYQStEL1VaeTlPUTczWnI2MEVWWmlNaGIwazRj?=
 =?utf-8?B?NDQvTzRtLzQxQlNnaHB6bTlTQzJSTHliOStzaEUyaHVxbWtnRk9yMTh6dWQr?=
 =?utf-8?B?cXd5bFNxOW5QVGpuZmxHK3R3WExJa0hkbW1XdmlNMHRQZWVwakgraHpVOEdQ?=
 =?utf-8?B?MTRja21yK09OUnZsOEp3VjQ0WlA3UFliK3N6c2ptT0tKTysyQUVBUnZuVnl6?=
 =?utf-8?B?aWUrcCtlSk5yMmcwMHRyOC9PWWdic3JwMFZ6NzBDV3Y4MERRQ01yVzcxRDlM?=
 =?utf-8?B?d21RMXpDWUZZYThoYmwxQ3JaV3drRXI2MVNjUW5wekg3alByb2ZER2pKbThr?=
 =?utf-8?B?YlVqd2kzZHFZdkMxQTBqdVJ0NCtOYVcxZmNrcXdtRXFKeWFXNGl6WmRwUWJF?=
 =?utf-8?B?Rk1kRCtkdlhsWU5wK1gwZTA4Q29ha2owbmd5T3dHUWdudEx5WWg1ak9WY28y?=
 =?utf-8?B?aExibk03VzJSZnRWMzJiVUV5MjNUbDNuV1JuT1hkelN1cVZ6Kzc4YjRrS2VD?=
 =?utf-8?B?c3kvZTh4eEt1NVJZTm9uLytUS0lWQmNIYlQwNVhYdHJwdWdxUlZwd0ZiSVhO?=
 =?utf-8?B?SGMxQ0VOTThubHJOOXNBODZrL0ZyUXF5aDV0MjBoR1RxVkFFT1ZwTWFDM0p6?=
 =?utf-8?B?c1JIRWdHTFpMT3RmVnZpUUFkQklpODdIUkF5V2pTakEzOXdHbTA4b1ZLV2ho?=
 =?utf-8?B?c2ZZUVY3emFLemRBV2s2aXN6OXpLdm5pdVVCSVRtdDlyckpOVTFnUVJIVG1p?=
 =?utf-8?B?MEpFSjVRbTVNanNLck83NDc3Z3lSNXkyK1RiUWxmdzFUMTRzN0RGU1YrS290?=
 =?utf-8?B?aVByN0NRaXBnT3hnakFRNzlZZ2MzQlRCcjlCcE1mQll6Vk5GUnIyUjRqWkZ4?=
 =?utf-8?B?YnBNUWZPVEgycmFJcEFjeFhnS0NRYXc5Z2IwZU1iYWVhNERVSU5JejZmWDhs?=
 =?utf-8?B?UGRtdkFESnBsUDRRYzZuT0RIUnVXZnRTa2pFZ3VsTEVQZ29jR3lmSGVjRTRl?=
 =?utf-8?B?bGR1R2ZHUW42S0VVQ25RcW5uT1dkUHMwWk96SXBEaHZkL05XQzhQUHIrS1ZR?=
 =?utf-8?B?eUpiYkdiUTNsR0pCcGdNSldSaHZWTkFIdTFLeThkTTVyOG90Vm01WWx2YTJ1?=
 =?utf-8?B?TmNxTnB2N1hiNFBEZXUrRnFGdnZLT1VtSFFIdWROY21KVm1qazlxR0FUKzBq?=
 =?utf-8?B?bG9jR08wNjVhelQxVmQzQTl3Vk13Vk9DVDYvM1BKSGJ1WUxUNyt4ZGJxNFJs?=
 =?utf-8?B?TmJRNWhPUit3ejVqT3RENGxOei81L2xZUTk4ZS81VW1GQ1RQaDhCVWFpaHFG?=
 =?utf-8?B?S1Jxb2lTNXJOdElhVHRiSzdvUUVCcC93SjdCOC9YbUZBL1I3V3Q0YTRBY1FG?=
 =?utf-8?B?T1pmeTlzNHBadGdGNnVhaS9DWXZPdnZvMWdFN0c3WjB4MWtmUnNyeW9vS0E2?=
 =?utf-8?B?dzE4cDQzWXpqc0pxZmJqaHIwWkNybXJtRUFCWnZ6c0VNcnh0bDZ1RmRwVWox?=
 =?utf-8?B?TFlLR200VnI1Z3UvQzVQQUthdm53SHZJZUdOVkY4LzNqWjN5NG9BTzdZL0E5?=
 =?utf-8?B?VkNGVXRhOVNkT1ZyazUzTkYyOGVOSVl2RXh5SldJVVVYNkZaWEZSamx0Y0Fs?=
 =?utf-8?B?UmJJVDBTdmlUekEwQkpRQVU0aHo4dWRSdTFVKzM1bFIzZi9Bb2ZSRDJNY2pw?=
 =?utf-8?B?YWV0UlpaNnRnWGRYL21vRHB5eHBHV0c0WkV4NzhwRlBIUzYyTHE2RFdHaVNu?=
 =?utf-8?B?OVFBdUR3c0hTODBNVnZoTFBQK0V4bEpYOFA0cjBHM2t2dmhxckFTczNoUkcz?=
 =?utf-8?B?ZHJsNzVncmcyRUcrYm9wWEVIeXVGMXh6cFpBdjU3cmVIQ1V4MGhxcENxcElz?=
 =?utf-8?B?YzVSZE9ZSk8rdmZ6TDhhRnFXY3UxbmJsWXQ2UWk4UjhINjU0aXVseFIvNUFq?=
 =?utf-8?B?RGZkWWpISHpQN2o2aVVnS1VpajQvcUJPOVVpSUNOTzZ3aWoxNGg4MXJVVkhv?=
 =?utf-8?B?cXcrbXdhWVhVS1RjUWRXTmZXcXZ2SlBtazl4c2tvQ1FQRWl4bmd5eG1VaTFt?=
 =?utf-8?B?SVo5U2htTmhMNDVMK3hwRXg3TkcrUjFSeCtmamFJeStGcjhwUENmQVlZQlRi?=
 =?utf-8?Q?f/4R7y/YIDipYl9yWka2CkqjK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a801bcf-debb-46d3-3853-08dc312d5c5c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 09:30:07.4474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWMPYILZBOrIDzrhtRbrPxV3A9bSJp4w/9EEzflI90fvQvVcTu4XsNmjy0gjcGjVEpwVHxMnsvt1/wv9Cl/Rwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316
Received-SPF: softfail client-ip=2a01:111:f403:2009::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> ioctl(iommufd, IOMMU_HWPT_GET_DIRTY_BITMAP, arg) is the UAPI
> that fetches the bitmap that tells what was dirty in an IOVA
> range.
>
> A single bitmap is allocated and used across all the hwpts
> sharing an IOAS which is then used in log_sync() to set Qemu
> global bitmaps.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   backends/iommufd.c       | 24 ++++++++++++++++++++++++
>   backends/trace-events    |  1 +
>   hw/vfio/iommufd.c        | 30 ++++++++++++++++++++++++++++++
>   include/sysemu/iommufd.h |  3 +++
>   4 files changed, 58 insertions(+)
>
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 954de61c2da0..dd676d493c37 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -259,6 +259,30 @@ int iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>       return !ret ? 0 : -errno;
>   }
>
> +int iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
> +                                     uint64_t iova, ram_addr_t size,
> +                                     uint64_t page_size, uint64_t *data)
> +{
> +    int ret;
> +    struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap = {
> +        .size = sizeof(get_dirty_bitmap),
> +        .hwpt_id = hwpt_id,
> +        .iova = iova, .length = size,
> +        .page_size = page_size, .data = (uintptr_t)data,

Member per line for readability?

> +    };
> +
> +    ret = ioctl(be->fd, IOMMU_HWPT_GET_DIRTY_BITMAP, &get_dirty_bitmap);
> +    trace_iommufd_backend_get_dirty_bitmap(be->fd, hwpt_id, iova, size,
> +                                           page_size, ret);
> +    if (ret) {
> +        error_report("IOMMU_HWPT_GET_DIRTY_BITMAP (iova: 0x%"PRIx64
> +                     " size: 0x%"PRIx64") failed: %s", iova,
> +                     size, strerror(errno));
> +    }
> +
> +    return !ret ? 0 : -errno;
> +}
> +
>   static const TypeInfo iommufd_backend_info = {
>       .name = TYPE_IOMMUFD_BACKEND,
>       .parent = TYPE_OBJECT,
> diff --git a/backends/trace-events b/backends/trace-events
> index feba2baca5f7..11a27cb114b6 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -17,3 +17,4 @@ iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_
>   iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d ioas=%d (%d)"
>   iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
>   iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%d enable=%d (%d)"
> +iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%d iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"

s/hwpt=%d/hwpt=%u

> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 361e659288fd..79b13bd262cc 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -25,6 +25,7 @@
>   #include "qemu/cutils.h"
>   #include "qemu/chardev_open.h"
>   #include "pci.h"
> +#include "exec/ram_addr.h"
>   #include "migration/migration.h"
>
>   static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
> @@ -142,6 +143,34 @@ err:
>       return ret;
>   }
>
> +static int iommufd_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> +                                      VFIOBitmap *vbmap, uint64_t iova,
> +                                      uint64_t size)
> +{
> +    VFIOIOMMUFDContainer *container = container_of(bcontainer,
> +                                                   VFIOIOMMUFDContainer,
> +                                                   bcontainer);
> +    int ret;
> +    VFIOIOASHwpt *hwpt;
> +    unsigned long page_size;
> +
> +    if (!bcontainer->dirty_pages_supported) {

Do we need this check?
IIUC, if we got to iommufd_query_dirty_bitmap(), it means 
bcontainer->dirty_pages_supported is already true.

Thanks.

> +        return 0;
> +    }
> +
> +    page_size = qemu_real_host_page_size();
> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
> +        ret = iommufd_backend_get_dirty_bitmap(container->be, hwpt->hwpt_id,
> +                                               iova, size, page_size,
> +                                               vbmap->bitmap);
> +        if (ret) {
> +            break;
> +        }
> +    }
> +
> +    return ret;
> +}
> +
>   static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>   {
>       long int ret = -ENOTTY;
> @@ -765,6 +794,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>       vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
>       vioc->host_iommu_device_init = vfio_cdev_host_iommu_device_init;
>       vioc->set_dirty_page_tracking = iommufd_set_dirty_page_tracking;
> +    vioc->query_dirty_bitmap = iommufd_query_dirty_bitmap;
>   };
>
>   static const TypeInfo types[] = {
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index 562c189dd92c..ba19b7ea4c19 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -55,5 +55,8 @@ int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
>                                  void *data_ptr, uint32_t *out_hwpt);
>   int iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                          bool start);
> +int iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
> +                                     uint64_t iova, ram_addr_t size,
> +                                     uint64_t page_size, uint64_t *data);
>
>   #endif
> --
> 2.39.3
>

