Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50EACD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 21:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPRcX-0003Th-IG; Tue, 19 May 2026 17:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wPRcI-0003O4-01; Tue, 19 May 2026 17:04:45 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wPRcE-0001h5-Ry; Tue, 19 May 2026 17:04:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SO0yvB26kIsXKi/LElNsVgdQgflIBN4s3sHpoG3AqxmFKSAXoj4Qs+T71pkFQ8CT/G8+zhLAR/8HZDvLyucQbCFXMyRQ1Df+LFtXcweaoxbx3aSF4CsfOCK0tIvtZamqvOxnFtANxoDrrIQ2gstCl9qRkrKl1WUBdF9CoSv3kBd6kXrwjzlucPmqK1xrJHBdpMBFxbPhI1aIGLOHIKLp6CrV/3xCsQTUD/PZbEDUSefO1vEkcjUkSVb/0cHt4CRBXxwvPWW5D+Wc7CXzI9iP8cMM0EygVaAaj9Y87yv6TnoPVajv2ZZISrxunG96+WJwGJuH7R6AOJCAblNsqKRFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdmfRTJHvV4Lhhcr8sltRKlqqKcg3AGUCJGt0v/iI+s=;
 b=nXtCSSHVaaXzCpzS6wgji+7/2pDSsQu78VEqGfYRbHepX2fmvHdo1IiHyZc2fiRHCD5+0Hw+lTxuEKXZffjdtKUYubN49SJXt00AwOaqlaKI0LSLwVdVyRFKeg07kq8MoGj7yNtfTw3JIRIWnHk8H9zTtceSlaRBlVWw9+cuKs47GYpJucDhEX755bWMZ9Z7CBAja/vLak42RbMhUB+VVGUayWM9eZdegn/ZOzmkE8R4pnijI8NxJfCwZTghM8Ocna1hxr0dRaTCoCfUI+AuvVjqBvY0KYNrqsM0Qw7J8HZKfcxQ2j+b+zbUWvlKcsvjzq3BietrHuEhU7DPoH0yhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdmfRTJHvV4Lhhcr8sltRKlqqKcg3AGUCJGt0v/iI+s=;
 b=GCnln1u8g/+QH6TsfWP2q4Oyp4faabZyVy9a5WuWJ8JKS6H+hvFYHpG2TaUwYkM4jHkbnzNcx4fXAw9t+l23K3IhYOJJ+sZQJ/MdhPZG7jxn6MeNB5PQaBkgQwv+7G3Gnfuau1YAJe6NtaCqcT2OKdfm1+YHOSJC+Y2jhtsPd220ZPXs3G4R5q2Mq58rp1bPjzvhX3gZZyZH9/T1X8xrF3BJqzcK3XxeSU6rDSV3S3qDcUFk4iasQtBN4IVE6kNEC0jDrrQxApYjGl0FSNXzKJmWWotuxhEvdU1lJ0FnX5kFfsDYjNrmb0LazdZV2QpOy5laXjRdTvjz3exKn7NsFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CY1PR12MB9604.namprd12.prod.outlook.com (2603:10b6:930:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 21:04:31 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 21:04:31 +0000
Message-ID: <bdc232c5-4409-4828-826d-988a620a5d21@nvidia.com>
Date: Tue, 19 May 2026 14:04:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] hw/arm/smmuv3: Set default ats, ril, ssidsize, oas
 to auto
To: eric.auger@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
 <20260512193520.3109172-7-nathanc@nvidia.com>
 <acd61fd5-a0f8-41f9-9144-d6889d6deaf0@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <acd61fd5-a0f8-41f9-9144-d6889d6deaf0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::11) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CY1PR12MB9604:EE_
X-MS-Office365-Filtering-Correlation-Id: 854eeee8-65d1-4750-9b79-08deb5ea38a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|4143699003|56012099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: tOzmrQqI6LrE07r8qB1jf1jIyFZr8f6EjZDE8Is1lkL1gJ34QO2vnoLSiDejAjmumGEYDgHGETOz5rbE42DBBI+LBkp3lGx275za3XYj3KgqGJ7Cx1bRI8rAFtLrX1u/OWXwdH1R6qiSMIgr1z24U+EgT0jDkBfIfqX/k4R3fGBb4m2SlyOJ8I60fn/O1shqi0rYpup+C0h9Keg0sJ/+FLQqUTwEkc4Njsp939Hc3r6bmuVMGINvwxl19mjVdoRr+UjQn2bWObJ7UU9dEZ0o/G1K1rQejDRVlW2X6hNVwUTqYEhi1DUIZDGRFyF3JdrHFxxjy3n6QhV83Wt4Or0bEFTY0IVY3L7uagZ8eAapwlPNlfNPf0t9Kd6XZaxAlHP4Yf7LSzDfvEwdEgUtdGydGA/BGkxXCinZ2bFES5142UdpRI/Z2H7nH8k36YzJlyHTpBK/1GDuXAGBeHMDkzEKy2sx+Q9qXV7EJpGUorfhvi6Hs/naVQ4Ov9uFV0tmefY4RVBY4nEz3my3214RyULGlbC+fiZHletItMSsjk5hXel5z5MibZyHu4sprL0PxyHw6848c+j5RhaRJUjkztE+97PVo5Y+wrF3GWnob8AB/He3k4ZThzjnYypkWVWZAIgMP8nO9kxSrjO2nfxzVDTzvgrosLe4KvHLEK3AjwQfngGjXJFS1FLmJbjsH6MSYfUl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(4143699003)(56012099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk5VaEtuM0tBUWc2dmNpQmlMTU5EbWZSQ0FKRW9hQVRTWVZJRVhVK0NOdVJa?=
 =?utf-8?B?Rlhia1dFVDF3bFUvUVRiV3dKN0RLc3ROT3VGSEM4NHV1NjlRazF0VmpjN3FG?=
 =?utf-8?B?dCtPUi9OVzhyVDFKdFlnRGlvMW01cmp3d3g2ZVU4ajFJQW13R2lkMDdLOXpU?=
 =?utf-8?B?VldWWHpxVkhnb1dxeGJETmFXSTV0dnVoY1A1WXdXTFhQWmxQbEdUWTA0Q2ZU?=
 =?utf-8?B?aHpLSkNjMjJKUVJTUkxtU0w2MkVMYVBVYXBtYzlSTVZkSlFWRFcxM3RSWlpv?=
 =?utf-8?B?U2R5MWIwQzBRZ2QvWUhBbzBNaWZiVFBmTStucjQrYlpEcnM0cG45Q2RQbDN2?=
 =?utf-8?B?TkI1aDdqL25TWkR4bEo3amFvUDBqYWozcXZYYWdpRmhlMlVaTHlxUnd4OTJC?=
 =?utf-8?B?d2Ixb2s4WG1vNSsyQWtVNW83Qm9hb0RybW5FY1gyV1Nxa2dCcURvZE5QdEd2?=
 =?utf-8?B?UjE5cFVvdGRYY3hsZmMzRDJDL0tnQlhkeGFQcnZ4UENHUXhCU3krRTBscDZZ?=
 =?utf-8?B?NG0va05ESGF2amwxWkNYdmlXL0lJdTcycU85Y2tRNEpIUEdCV2Y0SlVoRXI3?=
 =?utf-8?B?NGFjUUJkdlA5WVI0aCsyUkQrU1ltWFdrMnk1OTRBM3NvejVvOUd0RDU2cFVP?=
 =?utf-8?B?VXFDdFEyNWdtTkFWbmVxeldOV3I1SnVoVTlhKzB0TitNNEFZY0gxOGNFM0FM?=
 =?utf-8?B?a1prM2dBRFFlcVRpU2lFWWx6RTduMmlBcGFRR1AvMVJ1di9oMjd6TlE4WHlw?=
 =?utf-8?B?by80RFAvMGpwSzBZR2tmdTBEN3RsbVZqL1g0ODk5aisySmdMNjVHNUFCdXQy?=
 =?utf-8?B?akVQY2J3citGVU5MTVdNL2J3UUNuYWh4eTRBT09wYnhsWHBlOG1Eb2IrYTJa?=
 =?utf-8?B?UGVrWnhTemRQVU9UMHpoNDFzUEk4OFF6dzNFc2dhbWlPL2orbmk4SnBSMlhE?=
 =?utf-8?B?bmFnMXp4RUM1VDl1cGF2UUVlWDRuQU05aHdQa0dXN0xudUZjMGcydEV0cmlp?=
 =?utf-8?B?WEVta3NYeG9kTFlwUDRuT056WU9PNDRkdG0rcE51bnByNnlvWC9JaDFGTFBz?=
 =?utf-8?B?Z25kZllQdE9aREN3Q3QxRzFGRFU3L3d0cjEyNStZWHZEZnd4RUpHWElrc1dS?=
 =?utf-8?B?TTlSS2ZkQTBVZHpkWUl6cWhJS3hKQ2hwK1kvWXN6Vno0bU8rWnlDQnFPTXk1?=
 =?utf-8?B?TXFYTkl2R0tyT1FtY01HN1dCYTY1aW9QN1V5UWU4Q1RwRm5DY050OHZXcEpT?=
 =?utf-8?B?MUFBa3cxdXFHZTlQbDJKajhNYVQ0aHFsV2VMamt1bkhzZUZ2dCtkSll0dW83?=
 =?utf-8?B?ZUdLUjhPUGhwQTIvdDhTQWQ4czk4TG9ES3NKMDBDVHlKL0hRaU5kSWliL21O?=
 =?utf-8?B?WitsSFk4bGdSK1VKbmJDNkZOUGJyZGdWbE1iNExNaTJCS1FzcitmaVBBSGN6?=
 =?utf-8?B?V245UlBMUWdkQk05ZXRnUEx1VXdmTE5jNUcyaTVvN0JZSkROT21iMTg2Nk4v?=
 =?utf-8?B?RUxXaTZzK3hIWklxcXpoWFYyY3RwWHJWVnVlbnQxd282RFNlbEdFeFN3Ry9K?=
 =?utf-8?B?U0lYNHNiM29NYk5tajNrUHU3T1BXVmJOWVBYTkMrODh0V2ZCTEFwRDRGY2d3?=
 =?utf-8?B?OTJSRUlFMkthWlRnWmJNTTRud3FIRDJTa3JlWnhOYVNyVUd5VjBPQ2Rremtq?=
 =?utf-8?B?YTIyaVYzTUhXK3dRSXpZWlEySm5ZU1VlM2hKRjVGWWlNdndMNHNrb2hGVmJP?=
 =?utf-8?B?MWV0TDk1Sy9Tb1AxZk1EMlRrVHNmc1h1THMyT3ErT2k1Mmk1SkVpN04xVFRr?=
 =?utf-8?B?QzlSRkJ5MlRIaURDdkJDMS9mKzlOY3lMbTI0UVc5S253TjhOMWozNld6OCto?=
 =?utf-8?B?ZUFWdEdNNDNuL3ZGQmVnMCtDTmtIVSs2cFF4M3ljbEtTRU9UQmNaOS93Vkpn?=
 =?utf-8?B?YVBvOTRjMEdLYUIvWFNnL1loNVFtUTFacy9VbVlNamR6aHMxc3lCSDk0V2hu?=
 =?utf-8?B?RitxT0xOWjBvWGFpZGhuSWF2a0orVjhYeUJZcEtNaDBlcFIrMlRqVm9WT3NJ?=
 =?utf-8?B?N3k2RzZva0lVNEMrRFpwMk9DWFVrOGI4M2R6ZW1vUFIxbnR2OHo2OUUydFJJ?=
 =?utf-8?B?dlYyeUgveC9FUXF2Tkl3cDZMZHppRjlnYjlwcDFzckljMS9JQ3d6eHFlZDhJ?=
 =?utf-8?B?ak15OXdaQ2hNNXZlWjNxbjU3WGFtZ3VrVjFSWFVtS21RZzRySVFhUWNpVXBm?=
 =?utf-8?B?dHY4bnRsTDJtY0JmVk5aNE9DZ2tWQVBybXNiQU9jNHNrakcvaVZiclVObTNy?=
 =?utf-8?B?eTFpYjdHMGRCandyLzMrS3p4S0hydkh1YzlwVXZ2QytzSS9ib2VyZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854eeee8-65d1-4750-9b79-08deb5ea38a4
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 21:04:31.1752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2xxIl07SHPvw2n728rXrF4q2TjHM7rM7Azl9cCK/NqXOpzI15uLC+ieAsqaahv9n5j6GONBZfyCq0zN9w1D2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9604
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=nathanc@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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



On 5/19/2026 8:59 AM, Eric Auger wrote:
> 
> On 5/12/26 9:35 PM, Nathan Chen wrote:
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Set the default value of ATS, RIL, SSIDSIZE, and OAS to auto, in order
>> to match the host IOMMU properties when accel=on.
>>
>> If accel=off and these property values are set to auto, the default
>> property values defined in smmuv3_init_id_regs() for OAS and RIL will
>> remain unchanged, while SSIDSIZE and ATS values will remain initialized
>> at 0.
>>
>> Introduce a new compat for the changed defaults.
>>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3.c   | 23 +++++++++++++++--------
>>   hw/core/machine.c |  5 +++++
>>   2 files changed, 20 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 31c2eec2f4..665e6a2538 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -2129,12 +2129,19 @@ static const Property smmuv3_properties[] = {
>>       DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
>>       /* GPA of MSI doorbell, for SMMUv3 accel use. */
>>       DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>> +    /*
>> +     * AUTO values for accel=off will resolve to:
>> +     * ril: on
>> +     * ats: off
>> +     * oas: 44
>> +     * ssidsize: 0
>> +     */
>>       /* RIL can be turned off for accel cases */
>> -    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
>> -    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
>> -    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
>> +    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_AUTO),
>>       DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
>> -                              SSID_SIZE_MODE_0),
>> +                              SSID_SIZE_MODE_AUTO),
>>   };
>>   
>>   static void smmuv3_instance_init(Object *obj)
>> @@ -2162,20 +2169,20 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>>           "configured in nested mode for vfio-pci dev assignment");
>>       object_class_property_set_description(klass, "ril",
>>           "Enable/disable range invalidation support (for accel=on). "
>> -        "Valid values are on, off, and auto. Defaults to on. "
>> +        "Valid values are on, off, and auto. Defaults to auto. "
>>           "Any attempt to turn it 'on' while the host does not support "
>>           "it would fail.");
>>       object_class_property_set_description(klass, "ats",
>>           "Enable/disable ATS support (for accel=on). "
>> -        "Valid values are on, off, and auto. Defaults to off. "
>> +        "Valid values are on, off, and auto. Defaults to auto. "
>>           "Please ensure host platform supports ATS before setting it "
>>           "to on.");
>>       object_class_property_set_description(klass, "oas",
>>           "Set Output Address Size in bits (for accel=on). "
>> -        "Valid values are 44, 48, and auto. Defaults to 44 bits.");
>> +        "Valid values are 44, 48, and auto. Defaults to auto.");
> not really related to this patch but I notice that we do not have any
> "Please ensure host platform supports..." statement as opposed to
> previous props.
> While some host requirements are needed to be statistied too.
> 
> smmuv3-accel.c:    if (FIELD_EX32(info->idr[5], IDR5, OAS) <
> smmuv3-accel.c:                FIELD_EX32(s->idr[5], IDR5, OAS)) {
> 
>>       object_class_property_set_description(klass, "ssidsize",
>>           "Set number of bits used to represent SubstreamIDs (SSIDs). "
>> -        "Valid values are 0-20 and auto. Defaults to 0. "
>> +        "Valid values are 0-20 and auto. Defaults to auto. "
>>           "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
>>           "A value of 0 disables SubstreamID support. A value greater "
>>           "than 0 is required to enable PASID support.");
> same here.
> 
Got it, I will update with host requirement guidance for OAS and 
SSIDSIZE on the next refresh.

> smmuv3-accel.c:        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
> smmuv3-accel.c:                               FIELD_EX32(info->idr[1],
> IDR1, SSIDSIZE));
> 
> Also it is not written (for accel=on)
I can reword the accel section to something like:
"Enable SMMUv3 accelerator support. Allows host SMMUv3 to be configured 
in nested mode for vfio-pci dev assignment. Please ensure the host 
SMMUv3 supports hardware-accelerated VFIO-PCI device assignment before 
enabling."

Should I create a new patch for this update to the accel guidance or 
consolidate into the next refresh of this current patch?

Thanks,
Nathan

>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 63baff859f..3339da99ee 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -38,9 +38,14 @@
>>   #include "hw/virtio/virtio-iommu.h"
>>   #include "hw/acpi/generic_event_device.h"
>>   #include "qemu/audio.h"
>> +#include "hw/arm/smmuv3.h"
>>   
>>   GlobalProperty hw_compat_11_0[] = {
>>       { "chardev-vc", "encoding", "cp437" },
>> +    { TYPE_ARM_SMMUV3, "ats", "off" },
>> +    { TYPE_ARM_SMMUV3, "ril", "on" },
>> +    { TYPE_ARM_SMMUV3, "ssidsize", "0" },
>> +    { TYPE_ARM_SMMUV3, "oas", "44" },
>>   };
>>   const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
>>   


