Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BB8F45A18
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 01:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBNWV-0002z0-QN; Fri, 10 Apr 2026 21:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wBNWN-0002xz-SV; Fri, 10 Apr 2026 21:52:27 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wBNWK-000429-Qd; Fri, 10 Apr 2026 21:52:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTVXhwTWbMGUj1sbafeRIGnPSMZiheeueEBs/e8qfvZC7KD/gpi8KVb1tAj7EmIQcixDWN8pQ1+bZ2PxyJIxEM5koFzlBpjdZOAYTBSNxVyxf0sWNmBc27Ze5k+wEW+6TD5jqggXakCQsmj0WwF7dlUmecTE+zIoXa2/Xi69/kXeJAUoUDpSKQd6e9enw7ne9UoUNTtkRa1IfQMAaqFVdOVqMB9dQZAxtzs6zrodUmCiQtIzaGdlru75ZExZjwbehDWNxxgBLUMoqMjYI1Od1Df3lWJ+iFRDmwg+aI3LDcdSaXdTg5F/2gHtLcS+FYn9wUSs/Yzq5rma8SFYHL1x0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FP2SMVYOnsfnlhMAnzwM6/Gq+Pyo0DoY2jtM/Qj0kkg=;
 b=u7YDzlUjDPvkyUSz2V62OAwwzhaBm7RV6LTLPZMcFEryKb+IWrNb0NdvlLMgUM4FwdoVMY+vZHSRjrvfrbvvoCX0KvGWS6w/jsGs4xxJnBtnIsl0T8MO3+8mYB2PUwvjSq70mkCilnrqU5El70GU5T0mmY80KTnGy9ps3rnX2wBtHZ9AfIm5epZnrbvddSpfgQHnS8ys6A0NCxkS0FHUKDrVuJVpekQktRFWltd/SnVs8V+IEFSHv/FlCxGYX2H8Hkh0Y+8Bq6EjzrxF2n0uTJaJ6AWyoYN65e4c0SuO+UXIFuuIlaMuZ2JQ+lHJBYrmQ0OJWQnaNn8k75TWal302Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FP2SMVYOnsfnlhMAnzwM6/Gq+Pyo0DoY2jtM/Qj0kkg=;
 b=um+OoQMKH3KHAAFFKSiZmRE7Y9v9sfhCdtDwgsQ02zgkciwsKvvLdy3P3mMzr2g773yVQrDfCTJrtJlOk6b32apdmeQnIXu3Qk573Rxpem63aItLkRndcQRe+csyUlWwHWPTU346CMhLUmyj44yTOsUIhYzIbcQs6kOYBpbxjCnvLY0AfxaF7R4Cns9BTrfbEc0U5wu3pqxcnkkJTaTa9wBan7LVqU3dCJyrRutxja22sO0sFr82XmN5/sTmaVIP6bs2vII1EfQK43EpNv6JGvdC0EtUrHkpFVX9JBBmOmD5s5uzPqPV9kq8OZK1ce9AjS/c4TPOeFmy8RWB/sHIZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.34; Sat, 11 Apr 2026 01:52:17 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9791.032; Sat, 11 Apr 2026
 01:52:17 +0000
Message-ID: <e2f357c8-c124-4a20-ae7c-acbee4be8e38@nvidia.com>
Date: Fri, 10 Apr 2026 18:52:15 -0700
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
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <084d5550-c471-4d5b-8e2b-d2529a77cde8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:a03:54::31) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: a4f41a96-e004-469a-dd61-08de976cf60a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KXiY8iQtMvXIyGGx9SVt8J+LFdu0R2UUIgPJJuQVVGt207rSaP8RjAlCLiGuXpZBFLlx7T16j0ypaIW/NSuZ8QbEVt2UvZmEHZrbHd007FzTTe9jCu4KLFvHexB7pTqHqLDTM3dxgWLM3Vh2qoMGmfUpWFGnX5JohSHGxyGwUhi2TuV06zaVDBybEG3sGHQ5YIwnYDgfWWDuTgt9IfqODytgMEC0PnqnsGwuOtz39BswRabL3NkIyYmzuEBKyW/uAzFSQiCTjJJ8kjTuNtqpOvWInU02EEzvmmEIbaerhiclcrB7azzWfaDCi/QGzjbBL1rwqNU3eULNWcytNUNWoF+kpSXx+Lf3dZKNE2NXlOPJGrnRW6Uj118WU3AjSkv7XXH4wLN3ySX0EEA4o4cY8WQzwhIULKMT5LA4c/Y6DOlaukO5EzW6uFNcPl931ovoF8pQl+QVqBhI/AcHEV4EhZZAwaVWqC9YM7EJnQsvA9EQ0waM1nw2rXL/EhsyYVUBCzjjE6abABLtnlEDsBRVWw59miOf6Ukbpo1wyPicCFO7t3gEE5Ekqz30qEM2EUw706zvbOZ6tHEL9xZWutRmFHPJUml+qPRTxHkVtyqvflLECs/3OfJUbxU8c550rlD21S+c9li+0esCqQLT0yvvQ8WiO2IJrfQMoXOFdvZUXxwRXY5viyU04nKFzUPDQgcG+2MPszuLdas2Mg6BctDhQW8pWddu/WkDMNLGD3Ek1AA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cndmdWs4ckZqaTdra2orYWNmMGcrZjduckFFR09LdGcrc2JzSTJZUGg5WHl5?=
 =?utf-8?B?R2Y0YU50ZnpNTmxrbnF3U3VZNFhrUEhUdUpBbTJuYk16T2ZXZTVHT2phU20y?=
 =?utf-8?B?cVNVNG4vRnpkZ1NsWXg0bGxhK1JHeGRMeUpkMHFRRExwWE45dGMzY2ViUG94?=
 =?utf-8?B?OTZHaDl0ZGk2THJHQUs1ektvZGRlRUs5LzRGWlRCRFZqblluN2p4M21ROTF5?=
 =?utf-8?B?eCtGdjZvRnRLQVdPa0VxZHBJUzlxbW9tMUp5TTY1aVl2UWZjSFNtMjJ2MUpG?=
 =?utf-8?B?VmUvRW85bXp0bGRIR3lCbGgrUUtMWFlCRWp2R1FtK3J0SVEzRkkyakJYVmUr?=
 =?utf-8?B?eWNaRzJvMG5KU29xSGhRSWtEd2M4d1NLdi9FYVhLdHRtbWhvVFFHenYwczFE?=
 =?utf-8?B?TDhPdnZRcGVGcU9abkkxNkJ6YVlrTDRSRVZ4akJPRlRJRXhoQVRiQitIK3kz?=
 =?utf-8?B?WHA0NmNtN00yM2xoVkwzcnpOWDM5alF2Z0pMOEgrNjFkZnlvR2lZbHNkSWps?=
 =?utf-8?B?dExhUTFJVmRDNVQ2WXJqSWdkWTRyYzY1aEpaYXlocHc4aW03Y0xyQ3pyLzNZ?=
 =?utf-8?B?a1JmNWxLRHRzNXRVRHhGMFhrbXM4Zit0Zml3ak4vRDlJWGRabS9aeStrV0k1?=
 =?utf-8?B?NXZDZVU5R3B4M2RhMTRtbGdIWlQxS1RsenFCY3lUMkUxS2tPRjZKRWJ0dTRW?=
 =?utf-8?B?RThGVTg5V3BMalFRM05wQmFxcS9VS2pUL2VnSXhTTXBOMGpoZFU1VXdEWVVu?=
 =?utf-8?B?L0xZR2lWbmxwSExHTXRSWTNkVWxHVVdNVkRyQjh4U1laYVpUUHAvV1RaTTB6?=
 =?utf-8?B?eUtGdWkzcCtyVGV2SVJxdm45YjNTaUVPckhHVUJqOEhzZWhaaFMxZWh4dllt?=
 =?utf-8?B?MU1nb2hKTGE4TDNjbW5EcEZONytHYnlseTNRQlFkWnhXYXdOMGxwcXZrUlFk?=
 =?utf-8?B?Ly9BcTJhbGZvY3NPT0kzR2owaHp1UUppTnV3NVRUQWxqcEtJbHEyRDZidkJu?=
 =?utf-8?B?RnB1dkptS24xL3krZ2pOT2gzb0l0YmkxZXRlZUVxRkhKYXBoQkN0Nyt0K2Uv?=
 =?utf-8?B?RVVZcWkyVzZOZjhyZHY4cTdMNUJxbWxIVVQ4R3pqRWVlMDlBSkJkL1ozZ2Jv?=
 =?utf-8?B?VDRxQ3R1OHZ1SFRveTlIUm5mOEp6dmVidTdISW5jYXppTmZpcGZuV2g2dTZJ?=
 =?utf-8?B?RlFpWXdYTEUwLytISnNNYUkvV2FmN2hXOGwxZ2hWSDV2c253cmRnTUN0d2Yv?=
 =?utf-8?B?c2pQWm5qRnVzRzNIZUJMck1VSG0wMHVHc2dNc0FZdnR4SVBKMFZvdEpFN1NX?=
 =?utf-8?B?ZWtiYlpqWENHckVORFcrYkJlVkdNQk1QMndKQzFlaktQQytuYkNsZ1Y3Y01p?=
 =?utf-8?B?bjZlMlRINEUxUG95bXlLejdzS3NUd1Zva0VXZ0JEU2dFcDRHZGJXME9FU1lH?=
 =?utf-8?B?YWpSZzhFbEpQeVJFcFYxeGpLM1pxbW85RC8yZ3VLQWlPS2R4Y3RaT0dZcXhS?=
 =?utf-8?B?SEgwVmxVWlRWclIvQ3VjUVZEWk9KQWg3c3lHRXZMbkF1VGRlQUU1QUVUN08r?=
 =?utf-8?B?a3NLZFdZR2VLZ0FRZmVVeHhDeG1CUGM4bmVnVzNPdCsyVHlmcDRlMkhzUUY2?=
 =?utf-8?B?N2plS2x2UWpnRmUwSTRMb3FjZnJCdmV6VnpyVGdOUm5aT3NTamdwcXRRMGFW?=
 =?utf-8?B?bXNTb3hJQU91SHEwUFo5eG1KUk92MlA0WURUbXQ3Qll0OFBkb25FWFJjemZB?=
 =?utf-8?B?Vk5oQ09zWThUZDJLOVdNY0RaQmdmbk93NVVuVUdzbCtXdTZMaUdqa2Z1Wndi?=
 =?utf-8?B?aFRtZGtCQlpoVUx2V3htTVovc0YvSi9FMk1vbko5TGtXekZHRXZSUGVWVkl4?=
 =?utf-8?B?TFlJUmVBWHVKL3lIYXZzbFFGMXZFQ21UYkhGZmI5YS9xMUdKbTNkNUthbjZt?=
 =?utf-8?B?UXBqeThBZCs5ay80QWZ4bzBtRWdMUGhyYm1SL0tTWlhzTWtmdUVwU0VvZ3Iw?=
 =?utf-8?B?VDlGZ0hQelJ4SE1qU3FlaGMxazV0Z1hjM2lsS25hRmx1QVArcXdFV01EemEx?=
 =?utf-8?B?WGIrOWJOdnNNVWIxMnNmcmxyblhXTG9oKzZyQzdqQURUeTQzeVVrNi83T3pv?=
 =?utf-8?B?S0NmSHlyVEhXZW9kZTdhVVNTVWJXZGhkd2Vlckt5RkdhbkNnd2kvc1FreEwr?=
 =?utf-8?B?YVRaV3Z1c205b2lWZjkzUFk5V0lTNUxNZWI3OFMvSG1qZXRpTllIRC9aTDUv?=
 =?utf-8?B?dFZZREMvalZRajU1bVZ1WDFPVEk5a3M1TllNb21HanFHc1hnQ3Vja1BReEE3?=
 =?utf-8?B?L2JiSE5YbStWWWZrT21ub1krWkQzRGp5c0ZtZ1Y5SlliTUw3eEJKUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f41a96-e004-469a-dd61-08de976cf60a
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2026 01:52:17.5114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UltQS1sGQvvnNLiG9Ca+5T/mE6IFkjxKMAnXIvpkkk9JnBfaIPn3M/mC33sdTwOosbS5j9ry+9F5bvrc6C/XFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=nathanc@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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


Hi Cédric,
On 4/10/2026 2:09 PM, Cédric Le Goater wrote:
> Hello Nathan,
> 
> On 4/1/26 03:02, Nathan Chen wrote:
>> From: Nathan Chen <nathanc@nvidia.com>
>>
>> Add an "ats" OnOffAuto property to vfio-pci. When the device has an ATS
>> extended capability in config space but we should not expose it (ats=off,
>> or ats=auto and kernel reports IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED), mask
>> the capability so the guest does not see it.
>>
>> This aligns with the kernel's per-device effective ATS reporting and
>> allows omitting ATS capability when the vIOMMU has ats=off.
>>
>> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
>> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> 
> This looks like a standalone VFIO change that could be sent independently.
> Could you please rebase on vfio-next [*] ? There are a few conflicting
> changes in this branch.
> 
> [*] https://github.com/legoater/qemu/commits/vfio-next
> 
> You will need to add a compat machine property too. This is a guest-visible
> ABI change. A separate patch would be preferred.
> 
Yes, I will separate this out and rebase on vfio-next, with the compat 
machine property added.

>> ---
>>   backends/iommufd.c                 | 15 +++++++
>>   hw/vfio/pci.c                      | 63 ++++++++++++++++++++++++++++++
>>   hw/vfio/pci.h                      |  1 +
>>   include/system/host_iommu_device.h | 10 +++++
>>   4 files changed, 89 insertions(+)
>>
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index e1fee16acf..52cb060454 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -22,6 +22,13 @@
>>   #include "hw/vfio/vfio-device.h"
>>   #include <sys/ioctl.h>
>>   #include <linux/iommufd.h>
>> +/*
>> + * Until kernel UAPI is synced via scripts;
>> + * matches include/uapi/linux/iommufd.h
>> + */
>> +#ifndef IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
>> +#define IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED (1 << 3)
>> +#endif
> 
> This definition is introduced by :
> 
> https://lore.kernel.org/all/20260303150348.233997-1- 
> skolothumtho@nvidia.com/
> 
> It should reach Linux v7.1 since it is in linux-next. Anyhow, until then,
> please isolate this change in a temporary patch updating linux-headers/
> 
Ok, I will separate it out.
>>   static const char *iommufd_fd_name(IOMMUFDBackend *be)
>>   {
>> @@ -573,6 +580,13 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice 
>> *hiod, int cap, Error **errp)
>>       }
>>   }
>> +static bool hiod_iommufd_support_ats(HostIOMMUDevice *hiod)
>> +{
>> +    HostIOMMUDeviceCaps *caps = &hiod->caps;
>> +
>> +    return !(caps->hw_caps & IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED);
>> +}
>> +
>>   static bool hiod_iommufd_get_pasid_info(HostIOMMUDevice *hiod,
>>                                           PasidInfo *pasid_info)
>>   {
>> @@ -595,6 +609,7 @@ static void hiod_iommufd_class_init(ObjectClass 
>> *oc, const void *data)
>>       hioc->get_cap = hiod_iommufd_get_cap;
>>       hioc->get_pasid_info = hiod_iommufd_get_pasid_info;
>> +    hioc->support_ats = hiod_iommufd_support_ats;
>>   };
>>   static const TypeInfo types[] = {
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 1945751ffd..2d408e1d9a 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -49,6 +49,10 @@
>>   #include "system/iommufd.h"
>>   #include "vfio-migration-internal.h"
>>   #include "vfio-helpers.h"
>> +#ifdef CONFIG_IOMMUFD
>> +#include "system/host_iommu_device.h"
>> +#include "linux/iommufd.h"
>> +#endif
> These includes are not necessary.
Got it, I will remove these. I see that system/host_iommu_device.h is 
included in system/iommufd.h already. And linux/iommufd.h was leftover 
from a previous revision.

> 
>>   /* Protected by BQL */
>>   static KVMRouteChange vfio_route_change;
>> @@ -2550,10 +2554,53 @@ static bool 
>> vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev, Error **errp)
>>       return true;
>>   }
>> +/*
>> + * Determine whether ATS capability should be advertised for @vdev, 
>> based on
>> + * whether it was enabled on the command line and whether it is 
>> supported
>> + * according to the kernel's IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED bit.
>> + *
>> + * Store whether ATS capability should be advertised in @ats_need.
>> + *
>> + * Return false if kernel enables IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
>> + * and ATS is effectively unsupported.
>> + */
>> +static bool vfio_pci_ats_requested_and_supported(VFIOPCIDevice *vdev,
>> +                                                 bool *ats_need, 
>> Error **errp)
> 
> May be rename 'ats_need' to 'ats' or 'ats_needed'
> 
Ok, I will rename this to ats_needed.
>> +{
>> +    HostIOMMUDevice *hiod = vdev->vbasedev.hiod;
>> +    HostIOMMUDeviceClass *hiodc;
>> +    bool ats_supported;
>> +
>> +    if (vdev->ats == ON_OFF_AUTO_OFF) {
>> +        *ats_need = false;
>> +        return true;
>> +    }
>> +
>> +    *ats_need = true;
>> +    if (!hiod) {
>> +        return true;
>> +    }
>> +    hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>> +    if (!hiodc || !hiodc->support_ats) {
>> +        return true;
>> +    }
>> +
>> +    ats_supported = hiodc->support_ats(hiod);
>> +    if (vdev->ats == ON_OFF_AUTO_ON && !ats_supported) {
>> +        error_setg(errp, "vfio: ATS requested but not supported by 
>> kernel");
> 
> hmm, I wonder if we shouldn't fail to realize the device and stop the VM
> in this case (ats requested + no support).
Agreed. I can move the vfio_pci_ats_requested_and_supported() call to 
vfio_pci_add_capabilities() so we can propagate the Error **, and then 
pass ats_needed as a new input arg to vfio_add_ext_cap. Would that be 
alright?
> 
>> +        *ats_need = false;
>> +        return false;
>> +    }
>> +
>> +    *ats_need = ats_supported;
>> +    return true;
>> +}
>> +
>>   static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>>   {
>>       PCIDevice *pdev = PCI_DEVICE(vdev);
>>       bool pasid_cap_added = false;
>> +    bool ats_needed = false;
>>       Error *err = NULL;
>>       uint32_t header;
>>       uint16_t cap_id, next, size;
>> @@ -2603,6 +2650,11 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>>       pci_set_long(pdev->wmask + PCI_CONFIG_SPACE_SIZE, 0);
>>       pci_set_long(vdev->emulated_config_bits + PCI_CONFIG_SPACE_SIZE, 
>> ~0);
>> +    if (!vfio_pci_ats_requested_and_supported(vdev, &ats_needed, 
>> &err)) {
>> +        error_report_err(err);
>> +       err = NULL;
> 
> indent error
> 
Thanks, will fix this.
>> +    }
>> +
>>       for (next = PCI_CONFIG_SPACE_SIZE; next;
>>            next = PCI_EXT_CAP_NEXT(pci_get_long(config + next))) {
>>           header = pci_get_long(config + next);
>> @@ -2640,6 +2692,16 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>>           case PCI_EXT_CAP_ID_PASID:
>>               pasid_cap_added = true;
>>               /* fallthrough */
> 
> This change is coupling the PASID and ATS capabilities. Is this intended ?
> 
This was not intentional, I will add a pcie_add_capability() call and 
break for the PASID case.
> 
>> +        case PCI_EXT_CAP_ID_ATS:
>> +            /*
>> +             * If ATS is requested and supported according to the 
>> kernel, add
>> +             * the ATS capability. If not supported according to the 
>> kernel or
>> +             * disabled on the qemu command line, omit the ATS cap.
>> +             */
>> +            if (ats_needed) {
>> +                pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>> +            }
>> +            break;
>>           default:
>>               pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>>           }
>> @@ -3819,6 +3881,7 @@ static const Property vfio_pci_properties[] = {
>>   #ifdef CONFIG_IOMMUFD
>>       DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
>>                        TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
>> +    DEFINE_PROP_ON_OFF_AUTO("ats", VFIOPCIDevice, ats, 
>> ON_OFF_AUTO_AUTO),
> 
> conflicts with vfio-next
> 
Ok, will take a look and rebase on vfio-next.
>>   #endif
>>       DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, 
>> skip_vsc_check, true),
>>       DEFINE_PROP_UINT16("x-vpasid-cap-offset", VFIOPCIDevice,
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index d6495d7f29..514a9197ce 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -191,6 +191,7 @@ struct VFIOPCIDevice {
>>       VFIODisplay *dpy;
>>       Notifier irqchip_change_notifier;
>>       VFIOPCICPR cpr;
>> +    OnOffAuto ats;
>>   };
>>   /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot 
>> match hw */
>> diff --git a/include/system/host_iommu_device.h b/include/system/ 
>> host_iommu_device.h
>> index f000301583..44c56e87bb 100644
>> --- a/include/system/host_iommu_device.h
>> +++ b/include/system/host_iommu_device.h
> 
> Please add to your .git/config :
> 
> [diff]
>      orderFile = /path/to/qemu/scripts/git.orderfile
> 
> 
Ok, I will add this for the next refresh.
>> @@ -133,6 +133,16 @@ struct HostIOMMUDeviceClass {
>>        * Returns: true on success, false on failure.
>>        */
>>       bool (*get_pasid_info)(HostIOMMUDevice *hiod, PasidInfo 
>> *pasid_info);
>> +    /**
>> +     *  @support_ats: Return whether ATS is supported for the device
>> +     *  associated with @hiod host IOMMU device, checking if the
>> +     *  IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED capability bit is set.
>> +     *
>> +     *  @hiod: handle to the host IOMMU device
>> +     *
>> +     *  Returns: true on success, false on failure
> 
>   "Returns: true if ATS is supported, false otherwise"
> 
Ok, I will make this more clear.
>> +     */
>> +    bool (*support_ats)(HostIOMMUDevice *hiod);
>>   };
>>   /*
> 
> 
> I would split this patch in 4 parts :
> 
> - linux-headers/ v7.1 update
> - support_ats() handler introduction and iommufd implementation
> - "ats" property addition
> - compat property fixup
Got it, thanks for the guidance on organizing the split. I will send 
separately from this series.

Thanks,
Nathan


