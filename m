Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90887CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 20:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY8ey-0000xu-Up; Fri, 12 Jun 2026 16:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wY8ex-0000xj-Gl
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 16:39:23 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wY8ev-0004je-SO
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 16:39:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcUbdUBPAFPJL/TdrOiTL0Hs+XX2Z2Mcop7+b6mnTe3Gb4s+GCfPnqMU0/8KpWbmwVWHHIDBCIPDKYpELhIceQoNko6uMjCOH8y/vHaeW7CtnouWfQBv2YTLp36jBnYp8sEyb7ohZZmaDSjLpwIa/1dLvq0iqg6nqQuvQhpfigLu0FoNOQCB6YdLh/fxzOiSZ5WPeUICujSJy1bHZdmaK7sZmlrRsoPgXFQS+b4QEkvq1M0GGfsCllpVHZxBJfLUxCgQSR1q51KpgH4Novk3dZsHdynhb3x34H9g1d13lPl6N8/+45efm7jVnxroWmQbUv5YuMvxAuGWeBEXLStIBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tp1Sw8AiqIUX+TyqCwwutmHHzs2Qine9/d5LfsnUNrc=;
 b=WsLlBbhuVqPLBpM92HCZSFsjFQHXZvrSYHO4tb810d6ouXotqiuEXa2dcG0aF2S81MWOneEnOeKPujZQdbIuJ+TtlTJk4y2P2wdcNsRWjJW9iMvdaGgKZDnmHhAYRHAmyP2xqvxvgCIkEHq4X+PN1Zd6zW3u0M5XcQEdPcZ7Jp0+SesV/E2bTuAB/v1AgaHducjMA63yQllKdVF70gK/gqzCsh4VP6Lcwft6hMnIdGlqB07N041IZDAcsE7XwU1VuYmoNBTzBQnGIrspxmQ1NmUsfubJOlpwREC5B1/9BuTBOOLC6EOwzsWlw+aGaXzBo78L8sI5A2vCyWFY4zg3Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tp1Sw8AiqIUX+TyqCwwutmHHzs2Qine9/d5LfsnUNrc=;
 b=uEh3FyisF5/4NLw2EgEgupl18o7RAOPhsFMFoETIkRBDrzQmkVnmpHujzgpCg35m8f1D2zH32QaP9eJ3Ny13cyEVmM8whQNGvOPd1tkOiklN9a5dIQxKULL1tsW22v4eoKM3Rumn+90cn5kH5GuBnnljTcKW0WTLFJs87v1kC3BGR3/tiVAVxi1U+OyQF7HOY4KjStamNDNQ56xnPI8BJSO/7ij7MUd6QoUsFJyTaIjD3iKejd6SzrDUp+M4etu3ggz4VkJ+hWni9tYqcwHb0JuduqKPg9+LVXy04xNX0r6BVYfNjByR8qlnm8cZY1uRjKULdqEvM5r5sF7UEOUKrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 20:39:15 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0113.014; Fri, 12 Jun 2026
 20:39:15 +0000
Message-ID: <c67ab585-a12d-486c-9a73-80a09b579aa9@nvidia.com>
Date: Fri, 12 Jun 2026 13:39:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iommufd: Introduce handler for device ATS support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260612014322.2918836-1-nathanc@nvidia.com>
 <20260612014322.2918836-2-nathanc@nvidia.com>
 <f158c795-8b68-4aa0-9853-022bcf115c7a@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <f158c795-8b68-4aa0-9853-022bcf115c7a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0088.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::33) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: b849362a-009d-4ad7-df0a-08dec8c2ab0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8knFuUKMfutTDYIuzm4D56eSxzEE1B5cDMkyFMbLpl/iYTvBZr3PLZzT8LQlyVbue1gGN/qfZNUtMEKu5HjNY5EIZ1E+gTCQuT8Cncz8fG1eNXaFmqZp5PCksEsJNw1Be0yd/MdDzZFMMTyAX9851CvnJTH+NOVZTI3O5MrIWji8xcQkxAx5GFhdwPyoTVm3peWf8FmRvEnR9ApwbMH8JdMtJAKIc9S3i5Fa+0mrFypOJBgpw0RTrl5c2TZYvpzWOsgK4x8B681rqUyCe9dAum29XoxZ3hr6uzix7dQIcGvnqKHY6xT3DplbJjttKxGxC21gaV77rzj90zp0lg1C7/R6u8g/Mjr0P3MEmAKPS1+vC5tYejySLAgIM0TXLSx0TNR1H6rtyO/O8Z7axlPwQTIiw53/VL8y23OpW4FM6Fjne2HEDjhS5zWJR2BsLZJJkUpB5NbrFdM8AKX5JOBLb7IaFQeq1U9bFY02+USnU+KYYDthWbsdybmZR1fJAQKTLcTT8I+fqAiU2YL88ihbO+0YceGLMZFZBPd6gawB+ft5z0PQRvLQinIHh9o2KnZl+6KYsEeP3jUTNz3Ts7A5H3l1Mg5szd5JrzE4rcgyFAYnYVtWNTbQsLN4aYAjlyeQkj9kz7w+EnvR6yXNCF7JKhTZK3yP4w2hSJ1F3xFGz6kKa6R/RAlAoVo8jDLjX20n
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW5IenhuZ1lFZXMvVXREUldvajltLzhZZks4dmFoN2psYWkxK0oyYXpJdkpa?=
 =?utf-8?B?Rms3QW16WWh6S0ltbTBBN3hhTk1TOXBqYjZ0aXI4SHVTUndaV2Q5NWQvRFZS?=
 =?utf-8?B?UkpSaUtkcURWbVovQWV0SzlGeXcxTTNFcWZJVHdwRUdqYjBoYWRGanFLbE84?=
 =?utf-8?B?Um9GWFFBS1R4ZnlTRGFDb2xyY1JxZFhYOFBMWkRPWkd5RjZ3Z1NlMElDRmVC?=
 =?utf-8?B?UFVBNmxvMXFkVGxOQ3dkbWdxVGJwRnFwREFEN05UYlpIZ3V3NXVuN25zTHdj?=
 =?utf-8?B?Z0JZMVh2aGUzUjFyZ1EwM3lQL29SQzhOSit3QUFrcnlrUWF4cURLaWQ2ZWNL?=
 =?utf-8?B?NlBWOFZoKzluL29RN0JTcW9ScFJ0aEsvOFJEbTV5c2pQajdFSzR6SmdLSU1w?=
 =?utf-8?B?bjN0a3RPY090eVJ3b2ZiOHk5bUgxYlRqMld6ZUw0cmpxb3laM1Jzcm4zRjlx?=
 =?utf-8?B?aXp0TWgxNnhSN2xNRno0dVhmV251emhRNGg4NkRDdkVDa3JYbW9JU0Uybmtk?=
 =?utf-8?B?aHhpbnc3M2NjZnZhZk1QMEI4THQwL0ROWmcwSkdmVUhMeEFDWFNMa3FPZE5V?=
 =?utf-8?B?NlpMRit2eUF1UmIvQW13ZFpHNERWemsrTnJYNThYMnFyUThYUVFJUk9sNGx0?=
 =?utf-8?B?dm9DWnl6ZEFYbFBNbElNZW1mZTMxVkdVVzdZaW1MelVDY2ZyNlV0eWdNREN5?=
 =?utf-8?B?R0RoVnFSWHN5SmxJOXVZSGZ0cEd3UVQrTHlvVG1yVWJ4VktwZE80bFB2RFI1?=
 =?utf-8?B?OG9MZkJaN2N6R1EzdDh6L1djVS8zeElxRjNabVBSVENlK2NQeWJHUGxJT245?=
 =?utf-8?B?V2tLQ05PbzBZTEtkSEUvQjNoaEM5MmdGRlg5THJBMldndHpzaXRiVmpsTGNN?=
 =?utf-8?B?dldkWXBKdWhvdEY5bDhFM3ZKZjRVN21FWUpDdEUyeWJKUXVKZjZPNXVlOFdY?=
 =?utf-8?B?S0RzeHRCYWpic0JJMTN2M0lWNDdWV3RsU1IySitOejNhRWlhZmZEYzV2SnlY?=
 =?utf-8?B?YjlmalZtdTZqOFZ0c2xxY09JUjZrWFFtMHRZZ0xkZWorZk9uSVhIQnRTbnM4?=
 =?utf-8?B?dVhpWjNIbEIzVGZTUVZJMWc3YlpYQ2E3b3djK0RGbXF4UEFmL1pZUU9pMGNa?=
 =?utf-8?B?V0hMdzZRaVlHOSs0cU1Fa1psZytId0VmNFVWZDZ2WUdrQ3JrMkF2MTBhcXov?=
 =?utf-8?B?UExEcFpRbGg3UGxPTnROeUVKUEtnWXFLUHV3RnNQQmpKMlpvSkM4MTNwTWVY?=
 =?utf-8?B?a3RKNU5JUzg3WkNaWVpjVTd2OW1FcVVvd2hEc09QazJOM1pnYk1VSFk5bFBG?=
 =?utf-8?B?VFpXajdRWUYwc0VtK2dsUnVjYjBXSnBTT3FndTBTL1ovZEpoNklZWEM5a0Vw?=
 =?utf-8?B?cFFncVNML0lhOXdkUWo0VEtVOHc2MG5BLzc3RW1xSTdLbFdOVExXYlRnWFE1?=
 =?utf-8?B?eTBvV2NMUDU0d2grWmtodlFjVnp1QVVPcWYvNytkeVI0amtEMEtwbjd0b2xq?=
 =?utf-8?B?ODRtZVdlTGQ4akphOUVIZlNxdHBseFJHeFdHN2sxQlM0RGxjS3VoMnFCZEFH?=
 =?utf-8?B?czRIaEduck1qRGxhaHBWTG41RktFc2lCcjFmZ3QxdzFIeUlXbHc0dy9CN2l4?=
 =?utf-8?B?Q2dzRGxZQ2dZMmRrbXRBM09UcXpaSXppa0JBUlNlZkg1UUp2Mk1uT3U0N0du?=
 =?utf-8?B?ZElsa2k0ajZuU05kQ3pZUzVqc3NhSE9JZU1MTkNIZ3BJVnI1RElYVmJWMWxv?=
 =?utf-8?B?cWkvWGpRZ2N2OER4TTU3akw2bVRMNndZQmpOaGhSSXBZaU5Nd0dIL3VxWlhn?=
 =?utf-8?B?U0ttRXRaVjE1TTJIWXBCK2MydXVaQUxyS3F5cmtHZVFtU29IY3FGQTRIYWZU?=
 =?utf-8?B?SC9rWWdzdVY2UnpsSFp3bjB4Q0ZSa05EL21CdG9nMVJRKzA4MFg3Wkw4c2Vs?=
 =?utf-8?B?VXpzOTBVcDM0aXcvZGs5NXVwdzdGbXBGWnhCZDNDak1KY2N4cUZ6WWZ1Rml2?=
 =?utf-8?B?TUU1UWl4OXpWRWhwUGthQVNzQzJWbkZ3djVXanJuUURaeGdIek00c3VBL0px?=
 =?utf-8?B?dW5UNW0wSkgrSVJmTnF3VDlaNVRjZ0M3U1JMR0RVK3Z6YUgvV1lHK3lVTnFO?=
 =?utf-8?B?RE1jdmppQmIwRE5aUERkc1R5ZVZkTkJoekhYRzBXUmo4UkhBa0QvVFhvc2Yz?=
 =?utf-8?B?ajRLbkwzNk01aDhDcjJlQXduSjcydG9VMmhaOVBDM0ZEOWxGSEVzRXZFZlhK?=
 =?utf-8?B?QWtOa3lEZHAvMmtUMkVVWktNNThubngwWWlQZTI0eWdjWEx2aDVhb09UdmpQ?=
 =?utf-8?B?RGRFUmFyWDVWdDNKeG0rZmNlNTZRNXprZExjR1FQUWk4NTV5NDJ2Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b849362a-009d-4ad7-df0a-08dec8c2ab0a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 20:39:15.3752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNHJLaX/lbmQZALNaTit2sRxjJ7PhGARwQ+mTqbN3d1jvFI0oymymbaBJz1jrOTwlMwl99t97Y4rcGKs3mWNDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=nathanc@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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



On 6/12/2026 12:24 AM, Cédric Le Goater wrote:
> On 6/12/26 03:43, Nathan Chen wrote:
>> From: Nathan Chen <nathanc@nvidia.com>
>>
>> Introduce a support_ats() handler that returns whether ATS is supported
>> for a device associated with a host IOMMU device, checking if the
>> IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED capability bit is set.
>>
>> Implement this handler in a new function for iommufd.
>>
>> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
>> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
>> ---
>>   include/system/host_iommu_device.h | 10 ++++++++++
>>   backends/iommufd.c                 |  8 ++++++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/include/system/host_iommu_device.h b/include/system/ 
>> host_iommu_device.h
>> index f000301583..5615d6cb57 100644
>> --- a/include/system/host_iommu_device.h
>> +++ b/include/system/host_iommu_device.h
>> @@ -133,6 +133,16 @@ struct HostIOMMUDeviceClass {
>>        * Returns: true on success, false on failure.
>>        */
>>       bool (*get_pasid_info)(HostIOMMUDevice *hiod, PasidInfo 
>> *pasid_info);
>> +    /**
>> +     *  @support_ats: Return whether ATS is supported for the device
>> +     *  associated with @hiod host IOMMU device, checking if the
>> +     *  IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED capability bit is set.
> 
> IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED is low level implementation detail,
> which could differ on a future host IOMMU backend.
> 
> I would remove "checking if the IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED
> capability bit is set."
> 
> Something like this is more generic :
> 
>    Returns true if ATS can be used by the device, false if the host IOMMU
>    reports it is unavailable.
Ok, I will re-word this comment on the next revision.

Thanks,
Nathan

