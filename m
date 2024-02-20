Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D49C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcPcd-0000k1-N2; Tue, 20 Feb 2024 07:53:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rcPcZ-0000hz-UD
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:53:18 -0500
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2414::600]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1rcPcW-0002Lu-PR
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:53:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IH2N0pHnbKXgSQ1WVjQ0eCPfDK3vyUvCf/Tp6umA/RAHnLWDKvjmnycGNLpOg34oFqTxmz8JfhmOwm07FLvpKLmsrE1bIfkvsH8x63JyYa6XXuYp8YfcTIPb/EUAZgIQjr1mBNHQv/YzljHy34SH9i0ix9Kk9/ez6zibKkIDxJTlsK4z18lVtHq2LR4w6PpKbLoztYlUsW8X+/ivQh5V2CfTsJgT8zHP+7k7alienWCJ4IzyI+AhnI/hvmbDwUfnR27QGwfcDYrBoWWNZJa4/JogEJHjzbTtUqU3VePC5wnk8LmLKSm+L4RQwCqTolf4PrQ/8/uzG6h0QFZh8XRbSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Dz5JNcBOdvrRdDIWkIEcoyiFSzxgVE2tGupemGOHAA=;
 b=OYAe1+6uppcQu+zY6bglnR+pB+heUC+3xXSixmbOKkWxGRTJbyQETv9yvdgfy6fyZ+0/QZs7cdfJwv+PIHQEPrQ9ONbE8BHVl4Zd6GJ9QefPBCCKzKOU4tXcngGjz7Iwz6SclrrUewp89vO1BpALQRybFNIioPABoqWrL+F2Kv9rKN4/bYTYhWU6SbgRoyh7AS2PJswt9ftRv6lyJe8hDVePDQ8smcIiALxI92YFO8hlOMOIUggqZNUFTvl1jSfcSIrP1TZVNRjvtJ0c9xs3ZyFznq4IZ/KoruD+HuLua5xQklBb928nMk2DqK/wV8o1LZKG9w1NQr4/ji4mee0mEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Dz5JNcBOdvrRdDIWkIEcoyiFSzxgVE2tGupemGOHAA=;
 b=spdiThosUHHox1IAQPcOsko/IMY70+J4bApFtiNNXRanxWDQV6SXfJFJ7Wp4nrBk8hdKVTOin3tFhC/DqfQMZVvmgNgiTP4OR6AEp6OjMUeT7bxtK8CV9Hm7UdQlF7gxyzQy5QjmkGcudvdKGIJySAAxOVoeQ1Cc9NZxjTIbmXRqXOUBiphIOze8jboXcX3H1QF2QnMoN7K0sXUZHQFdYRniPVLP7dq8UnxqsaUKoG7HLCOnPwlgVa2Sl1N2oLM7z+W/UrAHjmPqhaQ2kAKQxqlbMkjVUhNSlDJf0HxTiZ2VcZbEE/OTIfcbGFTImCdT6jQLJuRwtnMDn8YXkqo1dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by SA1PR12MB7200.namprd12.prod.outlook.com (2603:10b6:806:2bb::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 12:53:08 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::2bc1:5563:c496:8076]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::2bc1:5563:c496:8076%4]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 12:53:07 +0000
Message-ID: <8bbe2964-f0f7-4845-bd58-76aeb8067f33@nvidia.com>
Date: Tue, 20 Feb 2024 14:52:59 +0200
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
 <717d6632-9038-4ffb-8193-511e62da5311@nvidia.com>
 <096b9798-7534-41aa-ba3d-12f98c00c59f@oracle.com>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <096b9798-7534-41aa-ba3d-12f98c00c59f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0308.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::12) To BY5PR12MB5544.namprd12.prod.outlook.com
 (2603:10b6:a03:1d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_|SA1PR12MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: ad3ca8d0-0820-4603-853f-08dc3212e2b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ba9KnAq4jSvIJFJscEafdf7eVvKeSw4Fpk+V/yZc12oDyXFvKKG57YkboXlaNjPYFE2a8JcZjQLZXLPi1FjVM+oMDDeIFHJhQDuk+vTclAMZxAJRgavFaciSuht4SmEJqTdU50Dj5ZywD9kE67yNPpxPsC0senNSXisuRu2YQOa37l8ntkVUWBjX3lDoPSP9xpbMkILw58oOYnS0UYmXaQnLZVKD3v1A2qNJvSy+tSwU+/nP9uMFu5aud/k/C0VfmuIRCx5hyGlGLSqqSDO0mTf6DVFUpxTDywV5gfaxbnGC2K1HazBAW8KpfX0Vr9rwWeqxpUsHiQvEuAS23VSu9M8RxtF22R0qpsWlls9wvz/qpqfRYO4lGizP3R8KlZy1IT/hlq5uIySRoQ/adi38rPGXy+W7BsRWrcSJMQ+SqfyLngPsModRQBj0PngIxKkhUE5k4JxgxqA9r8fdlUNhZOgsFXIyZBEfqOFalpB5g/FEQp3i3mh8TSPItH+CRUe41o80x/vx8aEgIAXgGJFw11jq31wQ3a9lh31syLlG4FZ+hsJhLVMdFhACCFiJ9k6H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5544.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czNKYzJNVE9Tczc0ZWNrUmdxNnIyUGlWcnZLMGV2K0c3TGV6L0Z2ODN6cmR0?=
 =?utf-8?B?a3VOdllCSGgzTk1ZZUtZS3A4YmNQSWRla2gxK2hxMVNuQi9ZTTVVTzQ2cTRZ?=
 =?utf-8?B?Z3lXdE5oYVdnRGJuTElkT3dWZ2xjRGoyc3F4Y3pnM2RPRWZReEIrRXRXZDh6?=
 =?utf-8?B?L0Q4S01NQjdtWEJTVWVtY01yTThSZFdReXJWWk1DeDlaMUgzQUFqT0s3QVlI?=
 =?utf-8?B?TFZ0Z3VobnMwRWRWTUViNTloVmwvNkRtU2hLWWYzV1FMMEtaMG9tNC91dkNQ?=
 =?utf-8?B?VnFCQ0VRNTRlTTNNRHF3YkkzaUc3VWFVVUxmZDdwZjdzSjRKMC9RMlBVOGRj?=
 =?utf-8?B?cnFyNy8yazZtSjM3Sm5NTTFYMW1SU2hmUXQ3eFpmeWEzMmhCaHlMdjBiS1RQ?=
 =?utf-8?B?L2oxaU10WWV4MklwYzBIYlo4MTdoWWJMYm5odk5NWmY2OVlYakpjaldPekZM?=
 =?utf-8?B?SEhJT1Fqd2Q4eDZsRklkSGMrL1AzbDJsREZyWE9Kd2tFZjk4RldrRVBSWjhW?=
 =?utf-8?B?elFoK1dweWNYODRjS0VYTW05T21GMjZtTHVNeE5XZTNPSDF3RzZ3MDBrb0p3?=
 =?utf-8?B?UkYwNGFMZ0VhN2NMUDVNYXRxVzJsOEtqV3J0ZksyVFN2cmkyVWZCd1MxR09S?=
 =?utf-8?B?TFhTUE9CeUNJVk52akZJMGtVQVBNYWtvR2RhNlFmSlRGUzh2NU84OUdhQmRo?=
 =?utf-8?B?a0VDSkdOVlJMRTNMSndHTVN0RTFyeTNBOGtHdytrNkRCbjJ4MEhKeDdNTVZ0?=
 =?utf-8?B?d1hwaUFubVBFc0tEVWdqckUxODlRM21NUnFFaWRSQjNYNjBabndzQzhGdk9x?=
 =?utf-8?B?L3AvMlJNTktlUkJJclFRRnRVTzJpN0pkWkVlT1dYbCtVTmZrVGpWSWJCVndN?=
 =?utf-8?B?Tkp3OHNSNWRZVDlWRXUxalZBNkc1NlQvOWRLT0lwaWJqbWRTKzlJODBtWG0y?=
 =?utf-8?B?bUtRWXF6Vk14R0Rlc3htZ2sxRFVZamU3VjN2OVVjNHRsS0s3dGY0TGRuQ3p2?=
 =?utf-8?B?OXNqZXZBcW91V2hlZ2pudkIvbWFaejJvTVd5Nk40Y09ibVJmSk5lcFphWWtB?=
 =?utf-8?B?WUZjWERnMjlhcXljdEs2cE9xakZqd1h6Y0JGMk13bXlsVjRnd3laMTE0bFhR?=
 =?utf-8?B?dWVPRHRDcjNHL0tVUUY5VkZXTVNpWkE0MVdPTFB0QStYdS9pZHl1SUZzR25r?=
 =?utf-8?B?eVdBeHQrc1ZsL0VkdDR4NXlZc2VKWGZOcTdmMTlmSUptaUMxQkRPdXo0WTFN?=
 =?utf-8?B?T0VrSW1WZTRFQnRCOFEvTXVackFFY3doQ1dWdGZFdDdNM2w2NmQ1ODNDRTQr?=
 =?utf-8?B?TEIrQmxtb2tLV2NvcXk2OGdrSHFwSmRpQ1NTaFlkbzNsTWREU0EvWm53dVdE?=
 =?utf-8?B?eE1XamoyeExuRmNOWVBSUEw2Nk1wcVZSck5hUDRGeXo4aWhDV2RnSkl0R0Na?=
 =?utf-8?B?aEhPY3p2bzlGK09IOUdLd0VNSUZSUEVkL3NIMGJTekpqOVN1UVA1TEZuWEt3?=
 =?utf-8?B?d0JOTGZrZC9Tck9XelE5NUQ1ZWUvbVNkZERjWHVKeVhTdy82TFNzV05WeWdJ?=
 =?utf-8?B?Wmx5YnBxSlhqdmk0VVFUNllqMWlpUDlITkhEcGNKRWdLSDBOa0Z6ZXRHQURB?=
 =?utf-8?B?akEwNHQ0QlJrT0tQMHlJYjNIbHdHRXhYOXlOVEhqQ2xDeW52cXhIeXdrZHRq?=
 =?utf-8?B?ZmJuRkpoblpuaDgyRm51eVVLUE9DUVFlSVdNaEszZWI2QzFnOGxDanB4UzVL?=
 =?utf-8?B?RTB4UkZYZXdYYVRVOVZpSTc2K29ZMkhDakc5a09ldWd5aHg3Tlp4VFE5V1E1?=
 =?utf-8?B?ZmVPOFBzUDR1eUFaZE1YV2x0dTltRWNlWXpmVklMUkJXeEVDMWU0by9YOXIy?=
 =?utf-8?B?MkM1QTFXVU81dTE3TVRsd3dSaHQxd210V3NNdGhPbytDZ2VOa2VDSjhITlZJ?=
 =?utf-8?B?Vk9yY3dGWW1zY0V0OGtUcDVGaWowS3NZbTZVaU9pdlBrWGJPTWJSaTR2R1I4?=
 =?utf-8?B?TTB6b1c4Q1dwUGVWZXVsTlJEbG9SbUNYa210UUZmTnoxbGJBK2V5Y0JUWjJ1?=
 =?utf-8?B?OXR5OHJkdXQ4NWRzbWdLeDBqck9vTVgrSHBBZUN3VkFVYk1paWVaQi9HMXkw?=
 =?utf-8?Q?d+mj5k9/5uD3mzNNGMTwpsTef?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3ca8d0-0820-4603-853f-08dc3212e2b8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 12:53:07.6607 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYbuJEFxptk4scahvSAgyamEz4HzEWPVIYGNImldSynhyi2+cvSG+giRWFPuTtj9AR/J0ZfXToX05XkOnZVDWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7200
Received-SPF: softfail client-ip=2a01:111:f403:2414::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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


On 20/02/2024 12:59, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
>
> On 19/02/2024 09:30, Avihai Horon wrote:
>> Hi Joao,
>>
>> On 12/02/2024 15:56, Joao Martins wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> ioctl(iommufd, IOMMU_HWPT_GET_DIRTY_BITMAP, arg) is the UAPI
>>> that fetches the bitmap that tells what was dirty in an IOVA
>>> range.
>>>
>>> A single bitmap is allocated and used across all the hwpts
>>> sharing an IOAS which is then used in log_sync() to set Qemu
>>> global bitmaps.
>>>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>>    backends/iommufd.c       | 24 ++++++++++++++++++++++++
>>>    backends/trace-events    |  1 +
>>>    hw/vfio/iommufd.c        | 30 ++++++++++++++++++++++++++++++
>>>    include/sysemu/iommufd.h |  3 +++
>>>    4 files changed, 58 insertions(+)
>>>
>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>> index 954de61c2da0..dd676d493c37 100644
>>> --- a/backends/iommufd.c
>>> +++ b/backends/iommufd.c
>>> @@ -259,6 +259,30 @@ int iommufd_backend_set_dirty_tracking(IOMMUFDBackend
>>> *be, uint32_t hwpt_id,
>>>        return !ret ? 0 : -errno;
>>>    }
>>>
>>> +int iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>>> +                                     uint64_t iova, ram_addr_t size,
>>> +                                     uint64_t page_size, uint64_t *data)
>>> +{
>>> +    int ret;
>>> +    struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap = {
>>> +        .size = sizeof(get_dirty_bitmap),
>>> +        .hwpt_id = hwpt_id,
>>> +        .iova = iova, .length = size,
>>> +        .page_size = page_size, .data = (uintptr_t)data,
>> Member per line for readability?
>>
> Yeap
>
>>> +    };
>>> +
>>> +    ret = ioctl(be->fd, IOMMU_HWPT_GET_DIRTY_BITMAP, &get_dirty_bitmap);
>>> +    trace_iommufd_backend_get_dirty_bitmap(be->fd, hwpt_id, iova, size,
>>> +                                           page_size, ret);
>>> +    if (ret) {
>>> +        error_report("IOMMU_HWPT_GET_DIRTY_BITMAP (iova: 0x%"PRIx64
>>> +                     " size: 0x%"PRIx64") failed: %s", iova,
>>> +                     size, strerror(errno));
>>> +    }
>>> +
>>> +    return !ret ? 0 : -errno;
>>> +}
>>> +
>>>    static const TypeInfo iommufd_backend_info = {
>>>        .name = TYPE_IOMMUFD_BACKEND,
>>>        .parent = TYPE_OBJECT,
>>> diff --git a/backends/trace-events b/backends/trace-events
>>> index feba2baca5f7..11a27cb114b6 100644
>>> --- a/backends/trace-events
>>> +++ b/backends/trace-events
>>> @@ -17,3 +17,4 @@ iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
>>> uint32_t pt_id, uint32_
>>>    iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d
>>> ioas=%d (%d)"
>>>    iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d
>>> id=%d (%d)"
>>>    iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int
>>> ret) " iommufd=%d hwpt=%d enable=%d (%d)"
>>> +iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t
>>> iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%d
>>> iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
>> s/hwpt=%d/hwpt=%u
>>
> /me nods
>
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index 361e659288fd..79b13bd262cc 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -25,6 +25,7 @@
>>>    #include "qemu/cutils.h"
>>>    #include "qemu/chardev_open.h"
>>>    #include "pci.h"
>>> +#include "exec/ram_addr.h"
>>>    #include "migration/migration.h"
>>>
>>>    static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>>> @@ -142,6 +143,34 @@ err:
>>>        return ret;
>>>    }
>>>
>>> +static int iommufd_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>> +                                      VFIOBitmap *vbmap, uint64_t iova,
>>> +                                      uint64_t size)
>>> +{
>>> +    VFIOIOMMUFDContainer *container = container_of(bcontainer,
>>> +                                                   VFIOIOMMUFDContainer,
>>> +                                                   bcontainer);
>>> +    int ret;
>>> +    VFIOIOASHwpt *hwpt;
>>> +    unsigned long page_size;
>>> +
>>> +    if (!bcontainer->dirty_pages_supported) {
>> Do we need this check?
>> IIUC, if we got to iommufd_query_dirty_bitmap(), it means
>> bcontainer->dirty_pages_supported is already true.
>>
> Not quite. Look again at vfio_get_dirty_bitmap(); furthermore
> vfio_container_query_dirty_bitmap() doesn't check for dirty_pages_supported.

vfio_get_dirty_bitmap() has this check at the beginning:

if (!bcontainer->dirty_pages_supported && !all_device_dirty_tracking) {
     cpu_physical_memory_set_dirty_range(ram_addr, size,
                                         tcg_enabled() ? DIRTY_CLIENTS_ALL :
                                         DIRTY_CLIENTS_NOCODE);
     return 0;
}

So if bcontainer->dirty_pages_supported is false we will mark all dirty 
and return (and not call vfio_container_query_dirty_bitmap()).

Or am I missing something?

> I guess this check should be better placed into container-base class rather than
> here.
>
>> Thanks.
>>
>>> +        return 0;
>>> +    }
>>> +
>>> +    page_size = qemu_real_host_page_size();
>>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>>> +        ret = iommufd_backend_get_dirty_bitmap(container->be, hwpt->hwpt_id,
>>> +                                               iova, size, page_size,
>>> +                                               vbmap->bitmap);
>>> +        if (ret) {
>>> +            break;
>>> +        }
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>>    static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>>>    {
>>>        long int ret = -ENOTTY;
>>> @@ -765,6 +794,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass
>>> *klass, void *data)
>>>        vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
>>>        vioc->host_iommu_device_init = vfio_cdev_host_iommu_device_init;
>>>        vioc->set_dirty_page_tracking = iommufd_set_dirty_page_tracking;
>>> +    vioc->query_dirty_bitmap = iommufd_query_dirty_bitmap;
>>>    };
>>>
>>>    static const TypeInfo types[] = {
>>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>>> index 562c189dd92c..ba19b7ea4c19 100644
>>> --- a/include/sysemu/iommufd.h
>>> +++ b/include/sysemu/iommufd.h
>>> @@ -55,5 +55,8 @@ int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
>>>                                   void *data_ptr, uint32_t *out_hwpt);
>>>    int iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>>>                                           bool start);
>>> +int iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>>> +                                     uint64_t iova, ram_addr_t size,
>>> +                                     uint64_t page_size, uint64_t *data);
>>>
>>>    #endif
>>> --
>>> 2.39.3
>>>

