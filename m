Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89AAC48260
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 09:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbzmf-0002lZ-2N; Mon, 19 Feb 2024 04:17:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rbzmd-0002lJ-Gm
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 04:17:55 -0500
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:200a::600]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rbzma-0002Bm-Q5
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 04:17:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsI0q+Xp4u+DhrJEhzNLmzKS3StaVqQ+4hLt6geg7K/Hm02ibOcmGzPfJgFS5jhqsxxg0AsD8okmBLXcX4EHEu1+e5b/6KRID7uWSLjwnkHTpJ1MEKGgnVF6so+YqIX/03XdGmssx/UsYOcqo+2IwFHOK7HC8agQri6DSe2XuOI0PW2m4fKC7pTU3GlGkGPDRCNljNx1O33rMucfGLq4N1QM+CJbU7JPpQgX5KO6xPF5aKGLwcC54B6QZd/Tqj/7uAQ9Dnfmnn//4lBzomkKL10qGXp9Lu2obxyLQmfhAbyjaW2+RFFg/WkRYh+/L0QGx+FtEmH3I9QG2wYbsitZjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qqw/O/2l2hM8MsfuwcgyVShC6dAvVmDuuhyl0HYE+68=;
 b=JeekNS7LWRW741lco8giaLHK3JdtAig4BLic9k0mv8v7nloN6JgZsdpJ7ViFs0TzQzMRt6rBdD6AHeo9nu5kZ4SoMG1UJEmZVzVBIazoKWkubmImkuN9gfs9QrWRt8SbpKJ/lUnriN9YrcLWvIcNbZ6itYLV5fc7CHl/3hQt1VQoKzkvR9EoRXcwTBJto4OIwbohhAHf1uWZ6C2KsPxT7NonbN2iJaK6dJoPNEPwEQqml0eiGOxbbgtrYZ0uW+k7qO68cVerV4fBckz6gNGs/1rF07r0Ssj7uqZ4TzNdDiAG5DD5jR+KkCcqdbnvZMQOAK1ekKjdgD6AfJ6lLawIdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qqw/O/2l2hM8MsfuwcgyVShC6dAvVmDuuhyl0HYE+68=;
 b=tUChP07qwHE7HeAesjEe7KRJ9J4o1FOh8D0b3dqTgb0CZjVAwRpnFNdv78eG5thqvJ87qkwtpILjvT/LG4+ZZyf8+JcZSVp84JEzNR1qXra4dAtlBhITM6qmCWSJbdz/tueo4q/5eIz74wNgvHhR/JqSnAFFzy8uGbk0Oz9fKLRCMIpADK076XJlb/d2cW4oqgYS3AJ+eVuLjbyqAKKpuA0crXcx/Ikn5Et8PrwlqGM9d/ye9HwTXMfRtQaRQlFpu/8pEQSLl1o+djyN9G39kNar30g94nNc5fG3WK7JHXu164VtiTbWlKTLzS2HbgJiIFohhgEcCdFA3vJqwJbGAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 09:17:46 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7316.018; Mon, 19 Feb 2024
 09:17:46 +0000
Message-ID: <9bd9ab52-6875-4cdd-9372-0b71856a5ae9@nvidia.com>
Date: Mon, 19 Feb 2024 11:17:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2 4/8] vfio/iommufd: Implement
 VFIOIOMMUClass::set_dirty_tracking support
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
 <20240212135643.5858-5-joao.m.martins@oracle.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240212135643.5858-5-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0096.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::14) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e20de2d-f706-4615-bcbf-08dc312ba2dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ctc34li49gXATngP4wq3rBdjyZLjfaMW0uTEjC+4YAJvmSGUKoXi3iU+oLX2lidALM/3f3nYGc+HH2j7ijSRoiM4vt65tvpaD9kB5EBTIia2P3uciAVNnvoDclnt7hHaDRZ6dhS0jo4lib/gH9OQRLJrqAT1aA09qSDrh9sW0KnlrICc4Oz1cBwB5zJmnjW9LcGZlnJiQvGqhdhlyO6fHh0VPW/Ho0O2f+iF/J2N/6p2XkWLe5Motu5P8b56Qqac595joguTNiOL+D2LtuJtCOmgsoZ9hPmdO38ga7agnjJS1oZ2sBsb4ntKGzIXUnq7l7P2VEQIqqOAm19420pgR2+y835Y003V+ZCkEimWYySOmue5U9x37RSLbC0Uo1gGtTuMR5zlol0HJ4ZTjkdydE17pJOHO0/u7pY6EpUArrb7Mlxe92k15jAqbl3RrJfRgRkh8pdqk/bAUhLbD9t5iR9+hf/tNDH1OmR/WpWUVzLrfvAc9XHOwwCQ2bdfkPWpaLaYB0t5+s6768Wxq8jIQRSPwrdqYUPIJg0DbW8AW8uj2GAIz4zHJAPsZBtl2QNd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(366004)(136003)(396003)(230922051799003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(36756003)(31696002)(86362001)(53546011)(41300700001)(6486002)(6512007)(6506007)(316002)(6666004)(54906003)(478600001)(83380400001)(2616005)(26005)(107886003)(38100700002)(66476007)(8936002)(8676002)(4326008)(66556008)(31686004)(7416002)(66946007)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1kvd2xoVE9xTm9VWG56MWU2eHlVVU5jalRGREI2dDBIKzlRajEwMDZFS3Fi?=
 =?utf-8?B?UVl0bzZ1ZU9JTmlkdWozdFZIKzVMY0JpcmgwdUkvcUlreUkwcjZDZ3cvTDZp?=
 =?utf-8?B?UzVTVHZaQ0VWTmppY0hHQVdPUkFJZWE0ZTBYRU1XNHc5bHo5K0xIUlRuM0JR?=
 =?utf-8?B?dmtISXBTVHMwU29kMVpWRHJYZjg5bXU5Qi9JQlRnYU9IQ1VUVzZnc2Z1cEcr?=
 =?utf-8?B?bHNQdUZaVXZ1VzA0cWpHaU9GSHVkR2ppdzNkR1p1NEFROVVKSEFaNklEK2Ir?=
 =?utf-8?B?TTdlZ0FQUm5UWWFPeFdZc1JKRFRKdEhCSDlvbmVTNlcyQVRxZ2dEc09weThh?=
 =?utf-8?B?dm9OeEVZemVyZnpGTUM1bE5GNnR0OTBRZWNUanI1V2RUdGhrVExsVXAxenND?=
 =?utf-8?B?L2dHdGs5RjlLRExwYmVYS29KR2dHTjM1cUZkckZ1aTlEdGxuTXBJOE90cXdq?=
 =?utf-8?B?eDhVYTNPeTdvRzIyS242b3BQUTc5L2Z6U1hFb3V5TVQ1bkNGL1hyeXN4NWdI?=
 =?utf-8?B?Um9Obnh3dGVhaytnVXpjSzhrbXpjcStKa0ppejZucDBXOFdRcy9SbSt3QU9I?=
 =?utf-8?B?VGJVTUs5ck52aHpyY01uRm1XZTNZcHNCYWsyd0dYc3g1Z2UyN0dvZ0hQUXVF?=
 =?utf-8?B?NHZQVVlWdm9sK1k2VkRrdWUwWmp6Yjk2elJabE50NkI5T0hPZ3QvVDRrWW5Q?=
 =?utf-8?B?K29aeURQVHZkNEgwUTQzYUZkczBrdGNxRDFteVN0cHlFOWJBbG11WXhYZysv?=
 =?utf-8?B?MVFyNUNGb2l1RlNUS05pVVRGM3dvWGE2MDRXRXd5aXRSZllDcVh1azZNclRY?=
 =?utf-8?B?Vkozc0tHcTViV1djbU1NaWsyQytBeEFFcUpxMyt5QVRoMDhoUFN5OUtvVE1a?=
 =?utf-8?B?b1F1Uk5Dck1GempQTDAxNi9tUjRUNEpRd0xsMGRCTlRETDhYak45U1orendC?=
 =?utf-8?B?R3owY1lQQWQ5VG42TnBOZnhPQ0VIWFNMTDhkZ0NUTjE2bEx6L1BBbENLcE1P?=
 =?utf-8?B?WHpqWU90SmtRTmRMblMwRzJ5Q3d0ZmNUaXp6eVM1L0x3Q0dtSE8rYzZ6b3Vy?=
 =?utf-8?B?Y0JOTC8wYUtOM1hnVXdoNzBwaGFtbXAxODBHS3grbjhYT01vUGoxc3lpK0ph?=
 =?utf-8?B?TGlVeDZmbHdISnhPekhSZGxnelNiOTNid1dlSGtaRU84dEovdkp5Z1p1RFJp?=
 =?utf-8?B?cThsTkN0ampYRjJ5clJESjlwRVVYeGwwMGlNQnM4ZDN2ZGdnNDBaRm93cnZR?=
 =?utf-8?B?U1dlNHgweFZySUNRdjJOU3NkT0tUQy9aOXdFZ2dKKzllcy9JdEJ6dXhIZGxI?=
 =?utf-8?B?UXhaUzVsRWYzRUN6VlF6Q0NuMUpVbURMN2EyNHRaL0RVT2dXUFA0M2dmNW1t?=
 =?utf-8?B?cTVWRGo0YVRBK1E3SStJMEhNVVA1VVNoNWsybVNYVVJ5a3J4WjdaY0xqdGM4?=
 =?utf-8?B?WVdlMlBIZUcvRkhzeFdYMXRSWndqSklOeUVZc0hld0RGNU1PZTNzL3d0OGtq?=
 =?utf-8?B?OVVXWGdsMWRtSjBpcWI4RUVDQ1RxVmoxYTYyQVlsNFJlZDRFb0pDMkYxYVNn?=
 =?utf-8?B?WmpNOUVlRnVHb1FheFhmenpid1BGTXp1RWFJbjdCanVMbmxhaUN3SWNqMC9r?=
 =?utf-8?B?Y2xKNUJwcmgyV0Zmdk5rbXlWbFJNaVFmK1ExMDFia2d6blZTdUtGaXRsZTZS?=
 =?utf-8?B?UzNpM3dlNXp6Z05nUmlENjZqNFRlY3IzQWxqN28rZ3dJaEJqcE1FK3Nlbzdr?=
 =?utf-8?B?dWJTbUtmemRjdkluMUdvS3Z3clc0bHdZVlF2VmovOWZxcDl2dzduY05QWlVk?=
 =?utf-8?B?eHhWRDBrOWkxUE5pZnNPZ0xNSkh0RnNSeXlaeDV0MDk0RGZVZStlMkFKRkVP?=
 =?utf-8?B?b2paYkp5WjErQ1pDVjR5R21LMDhLbzNyQUtUWFdPTFUyWWNhT25xbXVIYks4?=
 =?utf-8?B?TXNUQmo4Ynp0TGpHL3huY3l5Qi9OcHBqSjM1UE5XazRNY1YzVzAyOStmQ2FG?=
 =?utf-8?B?VDFGdEpZd2RabUh4aGZ2TjAzTUxrb3VkcEpVRHBSeGFtbmh1NHoxbFVpV3VI?=
 =?utf-8?B?REU5bUZ2Sm1CZS8xbFNUaTZiaklhbTZrUitJbjF6YVR2VlA3UmhiUnNOaytP?=
 =?utf-8?Q?i8hRrx4m1DFvJaRo7m7FiJuSw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e20de2d-f706-4615-bcbf-08dc312ba2dd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 09:17:46.7880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPh+oOUA/Z3QQrEFbwH9IRTMbHJSRqgw4iS+LzkPhvMf1sIIBfSjQOr9MQlAzNXtImE2zQNxol4n5mjwBSY03Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967
Received-SPF: softfail client-ip=2a01:111:f403:200a::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
> ioctl(iommufd, IOMMU_HWPT_SET_DIRTY_TRACKING, arg) is the UAPI that
> enables or disables dirty page tracking.
>
> It is called on the whole list of iommu domains it is are tracking,
> and on failure it rolls it back.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   backends/iommufd.c       | 19 +++++++++++++++++++
>   backends/trace-events    |  1 +
>   hw/vfio/common.c         |  7 ++++++-
>   hw/vfio/iommufd.c        | 28 ++++++++++++++++++++++++++++
>   include/sysemu/iommufd.h |  3 +++
>   5 files changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 2970135af4b9..954de61c2da0 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -240,6 +240,25 @@ int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
>       return !ret ? 0 : -errno;
>   }
>
> +int iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
> +                                       bool start)
> +{
> +    int ret;
> +    struct iommu_hwpt_set_dirty_tracking set_dirty = {
> +            .size = sizeof(set_dirty),
> +            .hwpt_id = hwpt_id,
> +            .flags = !start ? 0 : IOMMU_HWPT_DIRTY_TRACKING_ENABLE,
> +    };
> +
> +    ret = ioctl(be->fd, IOMMU_HWPT_SET_DIRTY_TRACKING, &set_dirty);
> +    trace_iommufd_backend_set_dirty(be->fd, hwpt_id, start, ret);
> +    if (ret) {
> +        error_report("IOMMU_HWPT_SET_DIRTY_TRACKING failed: %s",
> +                     strerror(errno));
> +    }
> +    return !ret ? 0 : -errno;
> +}
> +
>   static const TypeInfo iommufd_backend_info = {
>       .name = TYPE_IOMMUFD_BACKEND,
>       .parent = TYPE_OBJECT,
> diff --git a/backends/trace-events b/backends/trace-events
> index f83a276a4253..feba2baca5f7 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -16,3 +16,4 @@ iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t si
>   iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
>   iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d ioas=%d (%d)"
>   iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
> +iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%d enable=%d (%d)"

s/hwpt=%d/hwpt=%u

> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index d8fc7077f839..a940c0b6ede8 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -190,7 +190,7 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
>       QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>           VFIOMigration *migration = vbasedev->migration;
>
> -        if (!migration) {
> +        if (!migration && !vbasedev->iommufd_dev.iommufd) {
>               return false;
>           }
>
> @@ -199,6 +199,11 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
>                vfio_device_state_is_precopy(vbasedev))) {
>               return false;
>           }
> +
> +        if (vbasedev->iommufd_dev.iommufd &&
> +            !bcontainer->dirty_pages_supported) {
> +            return false;
> +        }

Why do we need this and the above?
IIUC, vfio_devices_all_dirty_tracking() is used to check if this is a 
"proper time" to issue a dirty page sync (e.g., if migration is active, 
if we are in pre-copy and dirty tracking during pre-copy is enabled).
If it's a "proper time" to do dirty page sync, even if 
bcontainer->dirty_pages_supported is false, we should still issue a 
dirty sync which will mark all dirty.

>       }
>       return true;
>   }
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index edacb6d72748..361e659288fd 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -25,6 +25,7 @@
>   #include "qemu/cutils.h"
>   #include "qemu/chardev_open.h"
>   #include "pci.h"
> +#include "migration/migration.h"

This is redundant.

Thanks.

>
>   static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                               ram_addr_t size, void *vaddr, bool readonly)
> @@ -115,6 +116,32 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
>       iommufd_backend_disconnect(vbasedev->iommufd_dev.iommufd);
>   }
>
> +static int iommufd_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
> +                                           bool start)
> +{
> +    const VFIOIOMMUFDContainer *container =
> +        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
> +    int ret;
> +    VFIOIOASHwpt *hwpt;
> +
> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
> +        ret = iommufd_backend_set_dirty_tracking(container->be,
> +                                                 hwpt->hwpt_id, start);
> +        if (ret) {
> +            goto err;
> +        }
> +    }
> +
> +    return 0;
> +
> +err:
> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
> +        iommufd_backend_set_dirty_tracking(container->be,
> +                                           hwpt->hwpt_id, !start);
> +    }
> +    return ret;
> +}
> +
>   static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>   {
>       long int ret = -ENOTTY;
> @@ -737,6 +764,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>       vioc->detach_device = iommufd_cdev_detach;
>       vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
>       vioc->host_iommu_device_init = vfio_cdev_host_iommu_device_init;
> +    vioc->set_dirty_page_tracking = iommufd_set_dirty_page_tracking;
>   };
>
>   static const TypeInfo types[] = {
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index 1966b75caae2..562c189dd92c 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -53,4 +53,7 @@ int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
>                                  uint32_t pt_id, uint32_t flags,
>                                  uint32_t data_type, uint32_t data_len,
>                                  void *data_ptr, uint32_t *out_hwpt);
> +int iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
> +                                       bool start);
> +
>   #endif
> --
> 2.39.3
>

