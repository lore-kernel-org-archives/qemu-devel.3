Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD21F8D776
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 20:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDSxR-0008Ei-W3; Thu, 16 Apr 2026 16:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wDSx1-0008Dd-7X; Thu, 16 Apr 2026 16:04:36 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wDSwy-0007v2-Dx; Thu, 16 Apr 2026 16:04:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kv/9fIiSD3KFzWzuOJ6zHY9JVmJ3lJbKd6n+3Kwx4+WWRVRutBLrNYRilpPCyUkAEOoKpZtYeofjpSB3lHuPgJ8NkrEKm1zxwLdLLSv/FQuzXpkc4prZJnrtkU7hSygluxaJKO/Y8v//+SdobLXy7dguJWY3Q1J9xPp9qQ4wsJEkfVn9JPvevk43mriWOXa7xOZMxUUaXKjgPmhBeEZTOG6xcnx0fJPX64MIyzm79iUF8aYGaLsV46FD/rrOAS6C24sMDSmwnlLuqHjCszg9nxlMjmwmN0tqrpMi1zCaj/j1napKUQmNcZwEcorQBxz86QklWqK++EhrHLcqTnrbkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bz/Ga++vDdQhgPO3Ev9MQ5Ty/4JuwrzwwpRCDQTqRyg=;
 b=wkPj2Vzdcvz8l8k4U7WzLwqCHWjIxopxNX0xbrWCgC/MwPCeA0nGx1jOoqpML/CbGQqDGsNKFjc3nHjVtz4LtoytzxbaOZe/kXWCDNHYf3pQ9CgPzkWhTZ2OomkD6mA4Zh1aoh7A8aERtn1ZwUPMCsnZRIR2/SKJxWgBnifuBkkj7FnndxeOJ7b4GO5AdYKdjaMRr2+fBOmd0LWZQXF0qiC54fvCqZ4wX6slbOnWTzrAghtYmCUw5Xoyd2JPVMquKkiPQWFGvvq/8jatcYtpiphSJC6A2nZi4DfEZElb2Ulsqda2Zv+eig6rrP2zzx9xNbpXXIurkL4CColtTfx5yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bz/Ga++vDdQhgPO3Ev9MQ5Ty/4JuwrzwwpRCDQTqRyg=;
 b=ZRXJ+MOKIIipL7hJLxy/gc9IqVi6Hju3KJdfKYd1JPLr0hlm1LGEpBw9dMrD53Kl2S5ECXyHDZr0eOprZqK6CvvdK5P+O9tlIo2MSCxcS2ObRWqwxdTDC3NqB4EJfdn7F3pt4CyJegiCHeqKDefvt7Vy4mrSW7h3oKTuuZvCpHxqsHBoT1ELEHrk0QwcZV9MrGCQAPyO8uw03pRSe6gz26rgs97CE7SmDdpDFNs+ANoD6Qte6HGHLYRW+wPsw0h5N10lA5056rlQHP6ATF+oD5hlHstyIirwMRxhCQa0JxMq2sgWUgz6L3Mc1dSB/9BrLwNa9N8P0FxucirtyGHf6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 20:04:18 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9791.032; Thu, 16 Apr 2026
 20:04:13 +0000
Message-ID: <d38e056e-d13a-4efe-9e9f-40967ae9bafb@nvidia.com>
Date: Thu, 16 Apr 2026 13:04:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] vfio/pci: Add ats property and mask ATS cap when
 not exposed
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
 <20260401010231.4166776-5-nathanc@nvidia.com>
 <084d5550-c471-4d5b-8e2b-d2529a77cde8@redhat.com>
 <2f463a23-d0c7-464c-a42c-14d9a0f60bbe@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <2f463a23-d0c7-464c-a42c-14d9a0f60bbe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0092.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::33) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d7f9c8-958b-4060-e2dd-08de9bf354d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SUDxAi2h/h3SHkkY0eF7qdPFv30QO29JS1A/HILJFZuo+gr77vvMYMkqRlJWJoVqnMmZwS8R59gzcB+xMdjFIe6a7oZ+DNOrLBtsOeQnxN0QT52s58KCtaIf/R1V9G0djINsGoMPlBxBAsg0YPyp445W9Mgugx5Ezhusv5h2OnmraSkESaKPMhPmqPksNJbt1Jnou7XJ0NOXTAAuOKgPVEcLoLwC1mTOfJSuRA1DzXxZXopXnLk7nCj/Hi/Uzu12KbbkCy/hrcQrT/6odjWFwttBLm9Wh7hWuMWUPc9K10MkvLyjmZ8Xyd8WzstADhW+VmKTy9paQ8mPMZLSpO1fao1h75LGV/sHOQHTczQ0Ve7lWPVdpa8kvkuZsZs3GiFTZlOne7Q7PxHgAowSAGg3zhLl1pKNwj6wOMAF2sPC21sG71R8kpZxzyTMzUYBSI1ZZiv6yelx8fU27tfMH1driloJWvGIUdc7OXKS0cZXR2fm8cBQrPteUdE1Gcyy4SFjs5KzIzsLb1P+oUlFibFzfn99nhq7kN+xVJfbwQds8bXeYQhYg2qpUshXUMI8mKlvr+NjGzBhcwKLxfehDjWW0D1N5fXopiMYAn3vrIz3+EfsQ3UvLgCvvjnW+QNt4dvvs/2RpPN89L4bcNkma/seMvmtUMVnJlOQLUK9CIIJbFPOqPIlSjLyMKSSe5flQ0qLeJ3YHkgd+Z00kGRp44ZzUJE8JMM9El6fp4gUK4/AMDM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODh5Rkc2NVlRamJvZmI0cGN0UjlIa3VINFRsdnV3MTNPdlkwbWYvcjV6Wnh4?=
 =?utf-8?B?Z2FXb1AyVXR0dlJjZ29hbmVnWnpsVXZHSWFJNTJEMVFQRWdUQXVKNVcvYWwx?=
 =?utf-8?B?WHYrT1loNk5mM2Q0cmRlbjlOb0pmLzBKaG9WdDA4dnI1VGJubUswbmFLSDdT?=
 =?utf-8?B?Q1o1L1NlaEtjNGlnRVpzdDFFaVZCQThyWTZkNFMzbXdEQmZSc053ZGo1eEFH?=
 =?utf-8?B?cndiNXVlR1lDNVBGZ3EvUEFWTmQyK0ErVm9lc255UXpuK29PYlZwbzVLRkFL?=
 =?utf-8?B?T0FTaFZIYkFVeGwzSWlCTkFrT1ZvclJoYlIxUUtSREJFQlBUcUZCeTNkQ3Rq?=
 =?utf-8?B?cnMwSzJCNytsOUQ4VHF0SExPQWZYUW85UUhua0xLRzlIaXlvbmlnUU1qWlp1?=
 =?utf-8?B?cG5ZMHlBU1BCMlBjUU5uWFhIZlJOcVZLaW5RSHZtdDZLcEdqb0VQL1I2Wjl3?=
 =?utf-8?B?TW1lakxZcUJZRmdEVUVhTHFxc0crS3JkdGloVnlmKzJjY0FLNjlQQnk1UkU1?=
 =?utf-8?B?MVROYW4yV2puQ2EyanIyQW1uTTdUbHUxMkwrazNhNzBRM3pjOWFCM1diVEVq?=
 =?utf-8?B?UEtyVm82ZDVUZWJHdERGajNhWUdUSSsxbWppWllmSTFJQm1vQldCY0VCb09i?=
 =?utf-8?B?aG8wSjZTVExQYnBjMkh0Q1B4Ni9aS2s1OWtGdk1xNUY4SDY0dFlYd21yMlZy?=
 =?utf-8?B?dEVqOVhaWjB0Q2FtQ1hUTjVRUGlzYnlSZ3FXcGhDR0V4ek9ESzFRalJ6R3FH?=
 =?utf-8?B?R3NCd2pZdUdmSmM5ZjhsKzlFa0crM3RqaTZNaktsRnNSTjdpaE4yN293UU5B?=
 =?utf-8?B?RTlnR2VDeXkzRTJmMnRBVGcyNm84MDBIbHYwK0V2elBheW1WV0t2d1NDUmY5?=
 =?utf-8?B?MU1uNmhoNlhTQzNHdy9mZEZrQ3VnSnhiT2IyQSsyc01BTWhuSmVOVU1EZUpv?=
 =?utf-8?B?aEpzZDMxci9XNlRxSUIxcEhSRjdSZk9XeHRlTWUzdG1TZmJna241aGE1MHZ4?=
 =?utf-8?B?eW44SnhCZVV4RG51N1R2RU9TeU9WaFIrZGtFZEE4UFNCNVVFeTJuWXdBVHpH?=
 =?utf-8?B?SkpsRWs3V2pzTXcrak1ud2dZdTc2TGdUWWRqaFRoN01zTU51UTl5VVFhTEJX?=
 =?utf-8?B?dUhMaUQwT09qVldOTE5zdjdVSjhOMWxiakdUOXNBSm1XQTdFUm4xc2NEc2Zh?=
 =?utf-8?B?d0gxWDlFU3ZleGFZaVpnU3hQUmhxTEdOVGJwUktsZ2VNaDEvcXVXNk04bUFL?=
 =?utf-8?B?N08wOWxFZ1VqVUxFeEVPTW9jcVUzTGVLOUJ1eFZBSEZobjk0cS91QkIyS1Vn?=
 =?utf-8?B?RzIxYmNSMWlCUjdGWEFSOXIwait6cWxYVkI0dlpLTEh0ZThZdEpUUEdrZW5R?=
 =?utf-8?B?ZlhPNzZlV3ZxNDdkcEhxZTZ6ME1iS3ZBR1Rjeno5QW90MEd0RGp0R3g1SWJE?=
 =?utf-8?B?Y1FkYjRKdnJYR3dld3V2MnpFZVp2UDF1V0xhdHRhUWxYdDZpQSsvZEtKMWF0?=
 =?utf-8?B?MTJjUXgzWU1sZk9XTVcrTThUTXlGVDRIbzBmZkVacXB6Vjh5bmh4ODducUxx?=
 =?utf-8?B?QWwydFNHWS8xM2UxbnpyN0NaRUNETzZtOE1ISzFEUjFNOHU2UHhOZkpHaWF6?=
 =?utf-8?B?YmVsTCtCZ2ErallrS1p5T01pYVR6ai9OQnNsdEs0b20xSXlPbGhYL1FtQjd3?=
 =?utf-8?B?RGRWL1NFNjZFamVDNCtJZHg3RU9jQ1VjeXJlMGVGUlFvYkx3cWl3Z0dkaisv?=
 =?utf-8?B?b0dOajBvUk9uQzlka3JBcHgyYS9QSFlxTDIydU1kY1NWeHh0OFQ4ZVVaSkVB?=
 =?utf-8?B?TmVhcDVJRnBCL25FbU9CK0x1RUsvMkJ4K2NTUjA3U3pnd0RtNWxRVXh1RGgw?=
 =?utf-8?B?M0dmSXMyUUI4eWRzRmQxbUdQZjZIQlJkNi9mbEw1bFJnd2UxQmhucFVpT09j?=
 =?utf-8?B?TmhBdVVwYlJ5MVRoUFdEVzh0NFVCcVhOU0JhUjlMTTJPY3lZYVQ0UGk2ekNO?=
 =?utf-8?B?UHRSWWdFQ3pHdFVTZ3hSR3dBY1VJMHdKVEpwZXQ1UExraUx4NUx1ZTgwcFlq?=
 =?utf-8?B?ckFXTWNjUTZMaTVLR29HUGFZM1pLUTRRbmhBWDFpUFNwbUNMNGx5RWo5b0VX?=
 =?utf-8?B?MVBNbjJjVUdrbXV3NGVJVmVYWlVrTXNNTWpHR1JjcWwrenRvS3ZQN3g4V2Js?=
 =?utf-8?B?dnc2dlVXa3l5ME8wZTdhaDM1QVAxc2ErR3p6c2pONElXTEJqSU0xSmlVZUhR?=
 =?utf-8?B?c3ZBb2FQdGxjakFmbXQ0QUhFcnlFSS85dEw1aUFqVEVPcTNWSU90VzdWTXBR?=
 =?utf-8?B?aEJIeGpEdmZpWk54eldGY2g0aXZNaTRHYU9mbFpRaTJaR3pTcncxdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d7f9c8-958b-4060-e2dd-08de9bf354d5
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 20:04:13.7293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOqMcstmLNODDTVgyi6xxDlRNm2DfHqnSXFYlh9Kf45ZgD9zUSijNYJUY/tYl7H9qVmStieOo8Owen/JdlSQVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=nathanc@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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



On 4/16/2026 6:58 AM, Cédric Le Goater wrote:
> On 4/10/26 23:09, Cédric Le Goater wrote:
>> Hello Nathan,
>>
>> On 4/1/26 03:02, Nathan Chen wrote:
>>> From: Nathan Chen <nathanc@nvidia.com>
>>>
>>> Add an "ats" OnOffAuto property to vfio-pci. When the device has an ATS
>>> extended capability in config space but we should not expose it 
>>> (ats=off,
>>> or ats=auto and kernel reports IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED), mask
>>> the capability so the guest does not see it.
>>>
>>> This aligns with the kernel's per-device effective ATS reporting and
>>> allows omitting ATS capability when the vIOMMU has ats=off.
>>>
>>> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
>>
>> This looks like a standalone VFIO change that could be sent 
>> independently.
>> Could you please rebase on vfio-next [*] ? There are a few conflicting
>> changes in this branch.
>>
>> [*] https://github.com/legoater/qemu/commits/vfio-next
>>
>> You will need to add a compat machine property too. This is a guest- 
>> visible
>> ABI change. A separate patch would be preferred.
>>
>>> ---
>>>   backends/iommufd.c                 | 15 +++++++
>>>   hw/vfio/pci.c                      | 63 ++++++++++++++++++++++++++++++
>>>   hw/vfio/pci.h                      |  1 +
>>>   include/system/host_iommu_device.h | 10 +++++
>>>   4 files changed, 89 insertions(+)
>>>
>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>> index e1fee16acf..52cb060454 100644
>>> --- a/backends/iommufd.c
>>> +++ b/backends/iommufd.c
>>> @@ -22,6 +22,13 @@
>>>   #include "hw/vfio/vfio-device.h"
>>>   #include <sys/ioctl.h>
>>>   #include <linux/iommufd.h>
>>> +/*
>>> + * Until kernel UAPI is synced via scripts;
>>> + * matches include/uapi/linux/iommufd.h
>>> + */
>>> +#ifndef IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
>>> +#define IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED (1 << 3)
>>> +#endif
>>
>> This definition is introduced by :
>>
>> https://lore.kernel.org/all/20260303150348.233997-1- 
>> skolothumtho@nvidia.com/
> 
> This is now upstream.
> 
>> It should reach Linux v7.1 since it is in linux-next. Anyhow, until then,
>> please isolate this change in a temporary patch updating linux-headers/
> 
> Please use script ./scripts/update-linux-headers.sh. I would wait
> for v7.1-rc1 to be tagged though.
Ok, I will use this script after v7.1-rc1 is tagged.

Thanks,
Nathan

