Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDF7F8D775
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 20:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDSuy-0007fl-1q; Thu, 16 Apr 2026 16:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wDSut-0007eu-Sr; Thu, 16 Apr 2026 16:02:24 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wDSus-0007YX-0P; Thu, 16 Apr 2026 16:02:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvGML+SEi/9JEmkZiy2jr0dyqqrmRsKkWTvdDxj+oeRlMGgFtqfBZ7OENHljWyziBr29uNctO7h8MbHL43OrcTzKQbqmODgJ+1lpeTPkLkNuCESPa9aoAzWSQfddUh/BseWKWmzUOea0opKIyDDYQVSk7ycFyEQVjAzs1jjzosL9yAzzLzsXqs06Mns9bv1HDxl0qrRFopozwls/fo/zXRxbSCLEr+9n407458GOMX+Ne0qB/uW3cKKwRazeCqzCENDPhh447aLjI7qIAieeRp3+RxKgk5plDMiyevdOOvx0d0wtGCgzkF7H0sX4MIZvHrlDXudRpyvXX8DRWNh1OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0KbsN0prrhZDvkxjw7VSeLh6urSM3AVCs44rINPErU=;
 b=OAAyZV314ONiCyTlHYbD+dWAaAONmfIpSA1Sc3D7hWyOvipP9ilij6Hi+cDDGoDiT3ZA2ACHCmpRxRzSvzymaTYm7Ku6zmS4afECpoCjz6Jj2r9BZdFIWyx2Crm4PO4v9+VhC9xshnR/zbUrmXiCXm8CKGdAsX6r+HaQkSoioT32ocYA6JODRe35ibTRxOti4F8A48nPdXIGkOUAFZXpE+z/owcxrF/IEy7MeFFyqu8sy/N/rrg1LjTNJWaOeqJBNQ57kXOCYhDgg6nMq8dPWqBTEKsPBETRQnDKLIJtTSqBTROKPWpk/hbHmAWrIPt1YO0mzkC4vb0IFKiZh2i1Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0KbsN0prrhZDvkxjw7VSeLh6urSM3AVCs44rINPErU=;
 b=RD9ajUTNmwyo5Oip/qRuN01O6VbHCrbGvdlWgMtFy6kbCxpyyy8vbxa45UoV1SeKzv/VV2MsgHeKL4y3o2BA2q9Qcq3BoD9XAAZugKvMGGuP+jRfpWMqYZEVa8fn0t5XI8OrN5mZUYvYhFUc9+ITqD4CjQbNx5w/bEVkxKsZPXZ6s59kW2iTf5N0qLruZDByaFCuzLuS2CP0c83N1uTT9CkjYwQYQWkQRx5w0vRydVv96ceYwORsYErzLGUczwqyQoXVBp2f0YI1saAEr70dmIu3H4ReqFC7pR6dfhfX63IL+hMvPu6SZlzaXgO5DRSlKJDW8HV2nhQIJdpUxvKqaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 20:02:09 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9791.032; Thu, 16 Apr 2026
 20:02:09 +0000
Message-ID: <f5beeb19-fbe8-473c-876c-0dbf0f7db58d@nvidia.com>
Date: Thu, 16 Apr 2026 13:02:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] hw/arm/smmuv3-accel: Implement "auto" value for
 "oas"
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
 <20260401010231.4166776-10-nathanc@nvidia.com>
 <CH3PR12MB754858C236A5322833654F34AB232@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <CH3PR12MB754858C236A5322833654F34AB232@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::27) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c8def6-2aa4-4002-6625-08de9bf30ab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: RiFZ9fKnytXVU7ItD9WRUmBdlXXINLUDzjq/YK3BB48NHYz/q0cZf6+C/hRo6ChF1nShrf3LaXcCYVxiULuFAEAgs3aJUlcUqMJbP5vTMjujvytH3TCST/dUOMpwS8FG1HVzn4b16bfEOON0+wGeWZ/rXNwbgGsuTR8BS7jFgMao05jjc87H+Z74OeeG3Twkh8yaqZLPC4YJqMS5oXv0G7IvHk6zn0EMXRQfkc74w9tMcTNfr8Ew0UZnXHujTAjh+QudPFmEAetD3B4B6lBn+jFtN4l9wYJ3Ym1G9r6atPOWP7WCjsuqVVLgLgk2d79kw4fQmnBEsmNcXaCDmF9jENLI6GFwKe6JVTaMGv82Fj0VeRIlnUsH3IjZbQPHsIAvY0Sb2aeaQNRuzKFdyxYc1h0Im8mOnj2BZauRCrwQhSRf6PUcMh1RQA/2goPW5vkeVGgjvPlkk2aavE9n8BE9QxdU1HmAfg/BwoMqmxDuXmEOyGDoKBYwltQItY7G7IDQLb4x/M2OnkZQd+Tlw9sb6UZNyUDzA86vHugyPINhMzq2SsmRUSC5Sykhl1oiBoY39CrTAkYRwJvO7Osf39O8nzRCFNT2wmcS4wSawEeXjhLKhcEimIkPatV9AWYNxjDKJE3n4HZBdvCg+OTRXbjriNl+6xOzhD89fn/aoc492McitaZ4oneNQolYpCRF3KJndfR6LUX963MswFU+mfhWVtGdtSrE6YiuRL9VgX0RGnc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3Bvb1cxWkl3bjBIaTR1eVBXNitWNUZkWm41OEIwWmFyWlZmMEdyVXBmcGo5?=
 =?utf-8?B?emRDdzZ4cjMvb2psSDdTZXNxdnlvckw3YS9XSTd2NFQzTnJqTWsrV0JkQVQ1?=
 =?utf-8?B?UHFrc3M4NmEwZWIzKytHQ01hRVYxeC8zbk1FTzJZczliUzF0L1YveWpHRmEr?=
 =?utf-8?B?U1JoMFFKSFlnMjhQS2x6MFZSM3FYdEFURXZQMnBLVHZEdllpazlMSWdIVGV3?=
 =?utf-8?B?YTdTRDhDSU9ObHI1RDFoeXBiOUhUZFFQcXB3a1I5K0t4ekJrZ3EvVDMza0Nk?=
 =?utf-8?B?bU5nSUx4RGJLWnhELzdteTUveDBMdjQxTVJDWVZDNVl0bENwVGxQNUNxQVMr?=
 =?utf-8?B?N2phUmNQR3RoS3REa2RVUUZPVEZKVzZMN1hXSVNhWWFQVTlkVS93em9GUjRI?=
 =?utf-8?B?SFFiQUMvK1lMSGpKY2YzakVtUGZNdXdOMlZvNDhFL2RXZGlYTnNFdWIveDlk?=
 =?utf-8?B?ekJrZEpVYk9VWTJlU29rNHlUeGR3NWNLbk5hZE9Oem15eU5jNnkvQVIvZXl1?=
 =?utf-8?B?ckF2Q0FUWXlKMkFaYk92cTJYVFJHa3UvOThpa0MyTjIxcStSUCt1MS9VWEdp?=
 =?utf-8?B?WVNhVG90WTNTUUpUM0VnWm00MTZ3QzcxWFUzUDd2VWJLSC9xeU4vcVVqY3Nl?=
 =?utf-8?B?citoTENCbFBRVkNmK3BpNlJjMjJnTmxuOTJIVko2SUk4cTVaUmVLREsyeHds?=
 =?utf-8?B?d3kwOFl4U3F3YnZxYWNMTXp1VFpKc2hwRCtlcEpBbG1Zdit0QjdHN1NvTU1x?=
 =?utf-8?B?M0tFSWNKUUtYVlJNUDFWbFhXNEVvc1E2Q2NyVzNoT3ZEekFEd3M0Y2tXRlh6?=
 =?utf-8?B?cXpCcjNDdnhjRXlaMHlWM0k1ZDcxbzNCT1cvV1MrV0NuOHV6eWZJU0FESGsv?=
 =?utf-8?B?S21Dd3VrT0lBaTJucktDbnVXbkh1WHRZTnowMTYwcENyMUxRdVpudWNzWFNV?=
 =?utf-8?B?c3FmMjZaZTVRVS9FZmhnWU55NjFPNnlzRDIwdWhQV2tPV2RLZmZBVzF3NFAy?=
 =?utf-8?B?dFZRaC9lN3k4TUx4MDlqV2RWZG9RUjUrWldjOVo1U2JvdExTMG5RMHdoa2oy?=
 =?utf-8?B?NU53S21YUE5ZOHRDMXVlL3BybG50UlloaG5HMHNQZW9Yays1bTBxbWxVckRy?=
 =?utf-8?B?UkUwdERVcVVod0E5dzR4QUdOQ0pkL2xLTXpzSCtLWWVEZkIvUXduenhtcndn?=
 =?utf-8?B?QWgvWG9xQno5NjVBNm1nVGJmY0FIY0prT2FxckpBek0wSzJJY3NkRkZvZG4y?=
 =?utf-8?B?bmt3RnZ3MDRsVkM2OEk0UjlOWEhWWk9pKzhVWXB4UVczSnM4SXZrYkdvQWRU?=
 =?utf-8?B?MHJVSEZhaldIM1B5WUlhTDhMVkkvM3NLWXFlS1daRnZCYzRIYkw5SHB1V1Ax?=
 =?utf-8?B?dzlvNldnR0R3UjdoMllMdnVsVnJHQ1M5aVNyTmZEdnEzWlhoSkd6R0puUnJ6?=
 =?utf-8?B?QUdob3g0Z1kycThmYkYyYTJnK2tLK0ZoYWhzTmcwNGJBdE4zQjJ2WGU2TVY5?=
 =?utf-8?B?SlNOM0pXNUF0bWhOY3ptT2lmSjZiVlgzZ2g2RE43QURrTXdUMWpoNTUvSld2?=
 =?utf-8?B?R0FZbXdCWHp3dmxVTWtXRDNjd1pkWVYvVm1Ua2g2KzVqYjhES01QNklwS0VU?=
 =?utf-8?B?U2pnRmRIWTBreEIrSmc0Y01iTUx2dmdTVjNBT0dGS2R6RjQ2MGl1eEo0ajNh?=
 =?utf-8?B?SDlyVVQwd2pOZVJyMEFDYW1GY3hZZWN4cTl0ME50SW9vUmRFY3V1Z2xCS2hh?=
 =?utf-8?B?ZXFuTmR6OUU5anJ6NEdmaXFNS2NBMU4xS2ljSmIzT25VWENSSURBYytJNlZi?=
 =?utf-8?B?eDhjd1E2R1dRbnFLU0pBRWJYdXlIRlg1TkJseW1CR0JySmZXR3lPa1F4OFBN?=
 =?utf-8?B?cUZobzAzN1dEN1l1eGJmVW5MblpvSU9YRGNUMm5KRW9FaE5LMnZ1MXZIQlZK?=
 =?utf-8?B?Uk5TODhlaVMyUVFJR2hsc3ZzUyt1ajFUTFNQVWJURG12ZWhPNUpVeEJubmxE?=
 =?utf-8?B?eThWd0RERzFicWxHQU9qcmp0UmVKZXJjc3lRTjEvT0paSW0vUWc4SzNZRDZU?=
 =?utf-8?B?MldUNlRVWm9UOUxRcm14YWpZQWNVUC9BYUpKcjBZdHlydDNDQjJKZ2wwZlZB?=
 =?utf-8?B?K01zMDJXemR5bWxIdEtqUkk2cmlyVGZ6eCtLZWFrWUtGYTlkM2loQ3RySmtZ?=
 =?utf-8?B?K3RvaU5pUUU4YkNyRGdFSUJ6eUlUUDUvSGJRQUErZzBSL0lmTEJpUmVYTEEz?=
 =?utf-8?B?c2RkNzcwdGpmeTYvMXlnZW9TMFRNa0xIbFJLMWgwcG5FeGxseSt5emR0Nk41?=
 =?utf-8?B?eVROaGM0bElpWVJQU083WHRSQ1pUTVJRRy9kYzhvTnlUU3RxbnREZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c8def6-2aa4-4002-6625-08de9bf30ab2
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 20:02:09.3619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0cymAYETICoBQx1J7JCB98McFWIVEwEcx7T3aceg8BUg+qNw5Xgf05vEuJUcs2Uz0rd8peARkewvwd2VL+IQGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=nathanc@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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



On 4/16/2026 7:08 AM, Shameer Kolothum Thodi wrote:
> 
>> -----Original Message-----
>> From: Nathan Chen<nathanc@nvidia.com>
>> Sent: 01 April 2026 02:02
>> To:qemu-arm@nongnu.org;qemu-devel@nongnu.org
>> Cc: Yi Liu<yi.l.liu@intel.com>; Eric Auger<eric.auger@redhat.com>;
>> Zhenzhong Duan<zhenzhong.duan@intel.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Marcel Apfelbaum
>> <marcel.apfelbaum@gmail.com>; Philippe Mathieu-Daudé
>> <philmd@linaro.org>; Yanan Wang<wangyanan55@huawei.com>; Zhao Liu
>> <zhao1.liu@intel.com>; Alex Williamson<alex@shazbot.org>; Cédric Le Goater
>> <clg@redhat.com>; Shameer Kolothum Thodi<skolothumtho@nvidia.com>;
>> Matt Ochs<mochs@nvidia.com>; Nicolin Chen<nicolinc@nvidia.com>;
>> Nathan Chen<nathanc@nvidia.com>
>> Subject: [PATCH 09/11] hw/arm/smmuv3-accel: Implement "auto" value for
>> "oas"
>>
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Allow accelerated SMMUv3 OAS property to be derived from host IOMMU
>> capabilities. Derive host values using IOMMU_GET_HW_INFO, retrieving
>> OAS from IDR5.
>>
>> This keeps the OAS value advertised by the virtual SMMU compatible with
>> the capabilities of the host SMMUv3, so that the intermediate physical
>> addresses (IPA) consumed by host SMMU for stage-2 translation do not
>> exceed the host's max supported IPA size.
>>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c | 9 ++++++++-
>>   hw/arm/smmuv3.c       | 6 +++---
>>   2 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index 03393fd7ba..105f6d26bf 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -63,6 +63,12 @@ static void
>> smmuv3_accel_auto_finalise(SMMUv3State *s,
>>                                  FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
>>       }
>>
>> +    /* Update OAS if auto from info */
>> +    if (s->oas == OAS_MODE_AUTO) {
>> +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS,
>> +                               FIELD_EX32(info->idr[5], IDR5, OAS));
>> +    }
>> +
>>       accel->auto_finalised = true;
>>   }
>>
>> @@ -962,7 +968,8 @@ void smmuv3_accel_init(SMMUv3State *s)
>>
>>       if (s->ats == ON_OFF_AUTO_AUTO ||
>>           s->ril == ON_OFF_AUTO_AUTO ||
>> -        s->ssidsize == SSID_SIZE_MODE_AUTO) {
>> +        s->ssidsize == SSID_SIZE_MODE_AUTO ||
>> +        s->oas == OAS_MODE_AUTO) {
>>           s->s_accel->auto_mode = true;
>>       }
>>   }
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index cb14a08a66..0ab6d1e762 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -1976,7 +1976,8 @@ static bool
>> smmu_validate_property(SMMUv3State *s, Error **errp)
>>       }
>>   #endif
>>
>> -    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
>> +    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48 &&
>> +        s->oas != OAS_MODE_AUTO) {
>>           error_setg(errp, "QEMU SMMUv3 model only implements 44 and 48 bit"
>>                      "OAS; other OasMode values are not supported");
>>           return false;
> Do we end up now allowing OAS_MODE_AUTO for non-accel mode?
> 
> I think we may need to adjust as below:
> 
>      if (!s->accel) {
>           if (s->ril == ON_OFF_AUTO_OFF) {
>                error_setg();
>                return false;
>            }
>            if (s->ats != ON_OFF_AUTO_OFF) {
>                error_setg();
>                return false;
>            }
>            if (s->oas != OAS_MODE_44) {
>                error_setg();
>                return false;
>            }
>            if (s->ssidsize != SSID_SIZE_MODE_0) {
>                error_setg();
>                return false;
>            }
>            return true;
>        }
> 
> Please check.
Yes, we need to adjust the check in smmu_validate_property() accordingly 
otherwise we can pass 'auto' in the non-accel case. I will include it on 
the next refresh.

Thanks,
Nathan

