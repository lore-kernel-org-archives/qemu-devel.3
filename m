Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB72C54764
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 10:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc0Wg-0008Rs-Qt; Mon, 19 Feb 2024 05:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rc0Wf-0008Rb-Ue
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 05:05:30 -0500
Received: from mail-dm6nam10on2062e.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::62e]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rc0Wd-000235-H3
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 05:05:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gk8K/9LrEacaMGsiQukTGaJ1VbgbI2M8DKBxjjVdxTRv5idMcFBy34/ik+UOgo7L9WJZFxvBYuEmwF4z5Oelpbe9zfDqEc0RzdzjRlGCKjKim+X+wNgE2SgMvHmOO1Je4rti3MsaWpajOQ+3/p9Z9K4J6G8RY5JUW3/6oyBFBPWl1NJ0FT26f7sY9KTjli5ytbgWaA5HFS8piwPFKJpTGHkz2bMiLihqfFpHjqtXOnisGc6XQZyRfVSEmssHhKzYfjtY52LGoqk1+JoQfFny3elKVCveLSJI7G8IJDaEUbySd4CFVa7Bv5fDDv9ALpqWlMuR5pBxLYNqxxPxlDfHuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfXKnpbPrKp9gzi3f539TgcdWYt6GZuKGVpF700kD2g=;
 b=EPA3eL/UhH34bvmngf8IAIOyAchL4Tc5daCqdkDG+XixLwRXcgfcXLSxm3qS7ZhYltXVAdDZES2SOmJim2pgxzaxPzlZD/v6sKQCn5IG/8pKrdpzqGdBLyPxp9sHf91t9b7VVPU1YovAoDP66HLOfZ8UHHEgcs6EHUU/8kofEkcsesZR0JRthEoFqgKHO5XlyRp7yOCc7e9OBihCsI94nXzk8CvKrCq8dktKey1YBBZQQ4yXAzKqWpNEpPOoOn6hgnAtHACLuP4RZSYnCwVDqj5rffyXClUN55C+FIM1Qr/bNvml8UaHuOzog+gTteBq6O52VXf5MZ5tStY8B1YN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfXKnpbPrKp9gzi3f539TgcdWYt6GZuKGVpF700kD2g=;
 b=BHB0bNsjikrAlMEwH4w5EL/ZiiGPEw1zV3vjnWdn7TjlRZzRhigSuYKrCoQO/9eoxpj7FrqAk+VK+lQiPlYxlk1KB5LiZvg+Py2uOCZBxbStKjJ6aLAlumyI5n0iSuTSMxpr3RwgMMpK2Szxaep+qXeMhmxkBTzWkFarBBMregDIqmcnCSY0HfhPoOCYJDa/5yd7IefzREbAH19q7M1q9V6ul9WrxmYYjKsQlNb3sANFMy9S1q5LaQuVixQ3pvUoSk/oBFH3iQ0/RmF/PFVBwcxx1NNA6HYW2VRNGUxG/b1qfGOkH5bV/aK7/nvEQiBahsUpj6vKG02BUYsEJCXLyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Mon, 19 Feb
 2024 10:05:21 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::c444:5cde:d19a:c73e%7]) with mapi id 15.20.7316.018; Mon, 19 Feb 2024
 10:05:21 +0000
Message-ID: <a44e354e-f157-49db-9e60-5014afc605a5@nvidia.com>
Date: Mon, 19 Feb 2024 12:05:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2 6/8] backends/iommufd: Add ability to disable
 hugepages
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
 <20240212135643.5858-7-joao.m.martins@oracle.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240212135643.5858-7-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0259.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::31) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: cd37231a-30a0-42c2-849b-08dc31324859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtp+KmNvNAmLzRlg1kvtNq8AmthnP/k1ZDnzNuO1khlpc4UV+L0FnYDKY2muSbScN7rW3bL2rDR6qHLDcp4Uud0nH+aUe2EEjSzMY2G67Vz9km/3HZ5Xc4anrE7RP4JtBGlzBBnarzukOv00VXTA0ioBfDDovRtSssL+wlaUjb5jsGN8sh50Fz2FD0T6lQ9USssZxepqwMlcVsUNJ2ZvobZjVX5/7onytgKeYet7pgEVyTllokkM176zIbf7u9SaI8QgrYr+Ybv64cvjzdpKdPtPV26uC3LjSHpYaSQHqKZzckhCX674RG7l52NhDS49Y6TtO8ouYsnjKO8QDGwTmUlAAofjxZe0wj4pq1Hfb2ZQcTue5WjvwuBRVfKp0SnkLE0C0ycIlSAisNTbT5tLkS3Y7ETr1He0tNLf7HI7LT44OLQr5iNeSBpuUUF4TInlcUbNUAZIvPQWKK8RxRLIpgmcflvQzO76tW9h79pXsRS6X/rZdpcHuDQMD/V/ys8wqNRNL3M+DsWIqE5qswj0O8UcdY6N8gLJ5zdTDtyf+Tz5d1XOTYQt0gi8jDseMGJG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(2906002)(5660300002)(7416002)(31686004)(26005)(41300700001)(6666004)(8936002)(66476007)(66556008)(4326008)(66946007)(316002)(2616005)(83380400001)(107886003)(8676002)(86362001)(478600001)(53546011)(54906003)(6512007)(6506007)(6486002)(38100700002)(31696002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVRMdlN6RE5tMWZkdHhTMDdFbUpGc1lMTTRQNmhqS1ZMTlREcENpTGN6b3Rh?=
 =?utf-8?B?QzdOZFVkUTZ1MXFZLzVaK1dvRnNqT05WNDMzdGNXamQ3VVJVTHRjN1dWcHE1?=
 =?utf-8?B?ZWlLMUI5ZmZ0RjZUaWR4S0N0Sm9pelF0ekNmOHM1OWRvS2lYSE9xeWN5dTFa?=
 =?utf-8?B?QzJnZnRiSjlsc3VTWWtLS0F6Vzd5OHpBZWtwdkp5Yzk5Z3E2QzlOaE1BU0g0?=
 =?utf-8?B?L0w1OXIzQTNUYTZSODY2Tm9iM2YvZE0ySGlROTN2VFU4Q1ZMWXgyRXZmVW5Z?=
 =?utf-8?B?QkRtTDBYZnF5YmQ2ZVJCWHBDOXJLTnR3N1RncGFIQzdoQVEwaFRCaGNIWkh6?=
 =?utf-8?B?OWZta2g4dURHL093c3I4bjhScjhLaFNCQllma1cwVDF1N3dONy9QMEI2T3BC?=
 =?utf-8?B?U1FBZFlENGZiekl5M2dXKzQza3Jia1hDYkkxYmhnbmhuMC9uYktmM2ttcDJw?=
 =?utf-8?B?TkJXNHdFU3NHUGc4SWdUUHBJYjFxUGZFQldOL2F1cUhFcDFtWkYwSFpoblMw?=
 =?utf-8?B?K1VmYWtRa2wzOEpzeGMzMTRuU1FCWXVoUFl1OCs0Z29mN3NuZjNHM0VJY0VT?=
 =?utf-8?B?Ykx0SnA3M01wRFhkTWFmOUV3aWVjRWZ3N0I5U0ZhQktJOEVkcHpxdlVaSkpy?=
 =?utf-8?B?MFF2Ri9nWUJpcGFMZlF3ci9zN1VZWWhTQ0hrWGVaWWEzVEJjdysySjZsN3lq?=
 =?utf-8?B?YVBqbnl0VFhxS0NXYzVmbEM1M1B1bEpTeFdTVEJhY2FhajNKRkpSbkNwRFlp?=
 =?utf-8?B?eUVJdGZacW9KSmljbmMrdkRlZW56TnhaZlYrQkVmdVZYMVZFbGg4d3luRlpF?=
 =?utf-8?B?SUhpVXNIdGxXNmtpT0hyOTVSN0ZiNjZXd2sxcXhtNkgySTVOYi9RckRpSFha?=
 =?utf-8?B?UVhnbUV4K1hsQmNoVXdxVWV4cFYxV3lHSTdyUFA2cVBXMmNsRXlyUkdjN3lJ?=
 =?utf-8?B?aWJSSjhLZTlPK1AySWN1WC84VGlGUG1ReXpta3pubmJHNTE0N1FSd2Q3eUpw?=
 =?utf-8?B?MVRQMkVYTnZwYmdLcU9UZkdQM0FLa0d6Q0FCdVJsTnZNYzFITkp1RzNJY2FN?=
 =?utf-8?B?WlFMZWRXTFVraC9xUzA0MFZWdU1Zc1BpenZmb1VqZnoya2RKcnpKYnFnUStL?=
 =?utf-8?B?bGpSdmt0aGZkWW1hWkVmcUFleG0vWk80Z3dHR2IwaWVJdlh6VVBkTlNJS1RL?=
 =?utf-8?B?OXNMMlBtcXVzTXUwVGk5NTR1YW8rR1JTUURCRlZRRFVZQmdvd3lQeGpGbjNq?=
 =?utf-8?B?cWNqMG1TQy82emErWGlYMTZveWU4N2xYcm55OGlzM3RQMlZ6NVRyQ0pLRXJo?=
 =?utf-8?B?WUFyVFEzdStlMzRGTStSZVpyOThxckhCdGlPSFZRTUNNeWZtT3RFZERKZkNy?=
 =?utf-8?B?czlEQzhMY1NsRkpYRkJTL2tFQlFrRGVDcjB0dXJIN0dMOEJEK1paRFh3SktD?=
 =?utf-8?B?Qnp4T1lLdnNEcFdsaXZPdDJVSXpPaXZweW1Ra3FiNG5jdXJhTGRnd0pZZFRT?=
 =?utf-8?B?REFyd1g1RmNkVVpkdllGSDEvNDJ5OG5Qa3ZKT0Zzbmg5VWNmci9NN2k0K1NG?=
 =?utf-8?B?b2N0SVZiTk1jVFRZY1Q5Rmp3UGJSWThHaVl4bHg5Qm5TQUhGaXErekd5Qk0y?=
 =?utf-8?B?SEVyQzFicnlFdmJOOWZONEpWZ09IcFBEV2I2MmgrdUlFRk1TMTU4cFNVZDBV?=
 =?utf-8?B?NEpvRkl3M3FPZWhtayt1WXBZUWcxdnZnR08vRjRacmZmNEdNcnc3Q3kwVXB6?=
 =?utf-8?B?eFZZc3FQQWd2bkhJNXhHN3JTdEpRcVYxRDNNTmJrOUJxVDVQTUQ5RUJFd3FG?=
 =?utf-8?B?R3hDK25KbTJkL0JHc0FrSWoyak5ZeFJhOFVrRHZFcmR6YitQUUhNTVNQNmtp?=
 =?utf-8?B?VlFwZWdrc0I1ZXZoMkt5V3lGTXIyQVhTd3Zjb0k2SnpYNUUvQWFTWmRRbTVB?=
 =?utf-8?B?bFR6NUVOYkxaSEo1Q29DOEJXdFRabnpjWnQ2NWRSL3N3YSt4cWRDSmp4OTQ1?=
 =?utf-8?B?aUxYajE0MTlFRzFrVWFPaWd1UUxjZElCajVOUlZkZWkrcXYvRCtKb2dFWWZx?=
 =?utf-8?B?MnE0NmpZQ29LSS8xaEptTHp3ZWVmblNCZlFaaml1UlpmYVFkR3JYN3hRbmNl?=
 =?utf-8?Q?tstC/ljo8aJLE/YfpE45tD5aK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd37231a-30a0-42c2-849b-08dc31324859
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 10:05:21.4200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Vn1O+IAxKDEqWSEBCGakYvcsiU+kTMVE4OH0mBQBByWk8+0m5CEjO+UPj+PXwSIF93YSW5Pt+wpjnv92RYOeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219
Received-SPF: softfail client-ip=2a01:111:f400:7e88::62e;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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
> Allow disabling hugepages to be dirty track at base page
> granularity in similar vein to vfio_type1_iommu.disable_hugepages
> but per IOAS.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   backends/iommufd.c       | 36 ++++++++++++++++++++++++++++++++++++
>   backends/trace-events    |  1 +
>   hw/vfio/iommufd.c        |  4 ++++
>   include/sysemu/iommufd.h |  4 ++++
>   qapi/qom.json            |  2 +-
>   5 files changed, 46 insertions(+), 1 deletion(-)
>
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index dd676d493c37..72fd98a9a50c 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -29,6 +29,7 @@ static void iommufd_backend_init(Object *obj)
>       be->fd = -1;
>       be->users = 0;
>       be->owned = true;
> +    be->hugepages = 1;
>   }
>
>   static void iommufd_backend_finalize(Object *obj)
> @@ -63,6 +64,14 @@ static bool iommufd_backend_can_be_deleted(UserCreatable *uc)
>       return !be->users;
>   }
>
> +static void iommufd_backend_set_hugepages(Object *obj, bool enabled,
> +                                          Error **errp)
> +{
> +    IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
> +
> +    be->hugepages = enabled;
> +}
> +
>   static void iommufd_backend_class_init(ObjectClass *oc, void *data)
>   {
>       UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
> @@ -70,6 +79,11 @@ static void iommufd_backend_class_init(ObjectClass *oc, void *data)
>       ucc->can_be_deleted = iommufd_backend_can_be_deleted;
>
>       object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
> +
> +    object_class_property_add_bool(oc, "hugepages", NULL,
> +                                   iommufd_backend_set_hugepages);
> +    object_class_property_set_description(oc, "hugepages",
> +                                          "Set to 'off' to disable hugepages");
>   }
>
>   int iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
> @@ -106,6 +120,28 @@ out:
>       trace_iommufd_backend_disconnect(be->fd, be->users);
>   }
>
> +int iommufd_backend_set_option(int fd, uint32_t object_id,
> +                               uint32_t option_id, uint64_t val64)
> +{
> +    int ret;
> +    struct iommu_option option = {
> +        .size = sizeof(option),
> +        .option_id = option_id,
> +        .op = IOMMU_OPTION_OP_SET,
> +        .val64 = val64,
> +        .object_id = object_id,
> +    };
> +
> +    ret = ioctl(fd, IOMMU_OPTION, &option);
> +    if (ret) {
> +        error_report("Failed to set option %x to value %"PRIx64" %m", option_id,
> +                     val64);
> +    }
> +    trace_iommufd_backend_set_option(fd, object_id, option_id, val64, ret);
> +
> +    return ret;
> +}
> +
>   int iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
>                                  Error **errp)
>   {
> diff --git a/backends/trace-events b/backends/trace-events
> index 11a27cb114b6..076166552881 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -15,6 +15,7 @@ iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, u
>   iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>   iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
>   iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d ioas=%d (%d)"
> +iommufd_backend_set_option(int iommufd, uint32_t object_id, uint32_t option_id, uint64_t val, int ret) " iommufd=%d object_id=%u option_id=%u val64=0x%"PRIx64" (%d)"
>   iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
>   iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%d enable=%d (%d)"
>   iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%d iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 79b13bd262cc..697d40841d7f 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -521,6 +521,10 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>           goto err_alloc_ioas;
>       }
>
> +    if (!vbasedev->iommufd_dev.iommufd->hugepages) {
> +        iommufd_backend_set_option(vbasedev->iommufd_dev.iommufd->fd, ioas_id,
> +                                   IOMMU_OPTION_HUGE_PAGES, 0);

Shouldn't we fail device attach if iommufd_backend_set_option() fails?

Thanks.

> +    }
>       trace_iommufd_cdev_alloc_ioas(vbasedev->iommufd_dev.iommufd->fd, ioas_id);
>
>       container = g_malloc0(sizeof(*container));
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index ba19b7ea4c19..bc6607e3d444 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -19,6 +19,7 @@ struct IOMMUFDBackend {
>       /*< protected >*/
>       int fd;            /* /dev/iommu file descriptor */
>       bool owned;        /* is the /dev/iommu opened internally */
> +    bool hugepages;    /* are hugepages enabled on the IOAS */
>       uint32_t users;
>
>       /*< public >*/
> @@ -30,6 +31,9 @@ void iommufd_backend_disconnect(IOMMUFDBackend *be);
>   int iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
>                                  Error **errp);
>   void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id);
> +int iommufd_backend_set_option(int fd, uint32_t object_id,
> +                               uint32_t option_id,
> +                               uint64_t val64);
>   int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
>                               ram_addr_t size, void *vaddr, bool readonly);
>   int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 84af23fe245d..9ad27e2b939b 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -809,7 +809,7 @@
>   # Since: 9.0
>   ##
>   { 'struct': 'IOMMUFDProperties',
> -  'data': { '*fd': 'str' } }
> +  'data': { '*fd': 'str', '*hugepages': 'bool' } }
>
>   ##
>   # @RngProperties:
> --
> 2.39.3
>

