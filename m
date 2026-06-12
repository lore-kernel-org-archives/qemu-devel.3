Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEE0CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 20:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY8rI-0002vf-Vy; Fri, 12 Jun 2026 16:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wY8rH-0002vU-UT
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 16:52:07 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wY8rG-0003eV-92
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 16:52:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgCoZJdX9mR9WYmt1T1dl/ll8ztOO3cAsiEYAEJjKGZq4oOsqMTr5JGmovEToc55L2E5UmbAe/Ech1zYAKsT6+9wXCCmRF0c2nCIyc1oLS3O3bKhtIJ7x2SDQs2kn9f9uGA/ptchSIFAWWNE7yhwp624/DJUUsqzoqSCLZZL2sEC+W2OCJmlbxk3iFPJqcr4honMgFBezoYX727UEg1LA9D85TYh/zd7EKvs5L+URqHb4eFGN7iZkupnZY0jMHz5jdJCCFRDJPWvypnX+sUwHq3Q83KDQMjFAO4cHL+zEnMqLrlYMF/xTii3m4aSL00ZKkIvaOO47Qfj1laFm8WHqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pfe6g2lpfbNOEcn740QNpsmBpjbOW9UI1OmNDcUQDTI=;
 b=TYxpp99vBsVn+dF0pw6RJGMvT8PgzlaJaq1vUm7ZRCKw8PE5b0TXz4L2rZRde3mRy3NH2e6hv83ki5U+bwUo6+irNqWM73rpSHc+dUffX9j6hZiP/LIPjLlCOE9o6w9ptsklB1aB/rAZjfGHfmZO68oA9KILUyYwqiKTV9KU7AqBmlm2zQsL+P5ZLpbR/kkr0uIMobLbmBai9NgbIyNfe5NREp2Nnuk1nM8IWPhj+3lYW8ND/rTZu9oI08TZGcLJCUlQsVjQc/V6mvg9EjzlgecD4/nKkabgj/BG6p4FQaxKWzD8FaQ9kexaBOdngs/S4OzDYPsIScL3MoVIqLJ3/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pfe6g2lpfbNOEcn740QNpsmBpjbOW9UI1OmNDcUQDTI=;
 b=X5XFhvXEfezUplm8wYsbzMaVWZFqLxRRzAsIamAOqzaoQfdAZNRoxvOdZRXSuJdV14b5Z0pKUERrwvgJvc7z94fkhJAjkfdavkzcktwv49Fq4TTqYp4CQIiTFAjyqw8f5f0nRSiHTLU5WOOfc8V1H+5nFbc8aCyduP89md72cwj48jT2nDkwLucSjdLEMLZ+UaypRswNKdl5qhyyiJC36DeW4isTX/Y4GGVIiftfZtJolf+gVEkMmLmWlecISsFPX7bysgBv3ABKAMvMsRjVncCh9qiiO4u0ZkJckx+9TtonmlDSmPzCQ6WNqJfMQdfL3bMjVFRxq4QHZ6m6jlX6HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by SJ2PR12MB8882.namprd12.prod.outlook.com (2603:10b6:a03:537::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 20:52:00 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0113.014; Fri, 12 Jun 2026
 20:51:59 +0000
Message-ID: <26678ebe-afb6-4b6f-9a56-58283060bcfc@nvidia.com>
Date: Fri, 12 Jun 2026 13:51:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/core/machine: Add new compat for vfio-pci ats
 property
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260612014322.2918836-1-nathanc@nvidia.com>
 <20260612014322.2918836-4-nathanc@nvidia.com>
 <71f8a1d2-e123-4815-a4da-dbb249b8cfba@oss.qualcomm.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <71f8a1d2-e123-4815-a4da-dbb249b8cfba@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0188.namprd05.prod.outlook.com
 (2603:10b6:a03:330::13) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|SJ2PR12MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c1b98a-b36e-420f-05a8-08dec8c4723c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MEXGUkSdykLm6mmU4Nk6ssWfowXFLcWuJaagtW9TBo5oZJwy8arKB3NfAQLlVok5cyCOc0sVax5ORyOYJxFL0yrqdNXgO0NGz7rayAZrF+ZJ6QJQfQvCAZfurni9ETvgiI3MHp3khefTJLSqq4L/eh6RLhi5CuX5IbCuwGHh7P7RGm1CZZPdXT45LRkGXjYLS9PBfi7/zSiBZBRiIr7EA/mgfAgbq2Ycb67V6NHggZykjgKcTZOOQwkqTU9YtPx0ZGAX5O9PC2scELaz4MCFNpP8olmOJ+paZoxQz049rWGxKkD13amPaAKLR6f2qoXC9m2IF5LqHxZXQBi/VMbl01Dq4qm28yNIaGmQTsVP1lbakeUsx5fj9K+2T7OVbBx3Jh3x3UYj9fc0e8X7FszsrANH53xSGsb2HsLliEqhzH+L7xeGEEeH8tB0X/k7EDZR8AhN5yNJOsMVTz8+M1F0I0Vgn3F1prqtGFPnKAJwFjP7GXhHxNqfxGKOpDvuuP+p8WUKMxGCYACcvsl94a8WUgNz5j2Lpl8TOCOssbuBu/4Y/yzImhqQGVFkyAsGGE7kp6c6GZ37WPf4Hx+1Ia6yFS3j053T6h5C5Zjd1W8fLZTl8DIccNvNBnyhCM2u7dEDPMb88yd3HoCLgw3odWvq90wyfuFxbXxEU3YRPJDtrfF7WXB90Xv+qAjU2jYc/V+k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjJndm02YUJMazRtd3BDLzBwZkpiYmo1dDlVWURUTSs4QTNubGNxQ1dGOUZB?=
 =?utf-8?B?MXA2MitvK24rdHZFWUtSZUdlLzJTL0VCdUdFLy9oaEJFQnU0eEtVTWVGMnRs?=
 =?utf-8?B?U3JQMm5uaSt5SVNXeDJ5YTR3ZTB4N1djVEVOTjJBNjhJS3NSK0t1a2N1VGhz?=
 =?utf-8?B?eWFzbnIxektCakw1aEZMUTN5ZU1WUDdUTzVKNWVkT05NQkNZd1NhSnNlTWht?=
 =?utf-8?B?Ny9sejh2NURXRVVQdU1jSmV0a3lYUzBoRXVncEgvSWdQUnd5ci9VbHZBbHZJ?=
 =?utf-8?B?WDJ0RXMvU1EvNkM4N2JVS1VSZnc4RnNxZHVDdGYrWHBicW1JNW43M3UwQXNG?=
 =?utf-8?B?T0pOeENpaEpGRFFpYVZlalkvT1paVzFYbDd5V0E2b2U0QXhrR2k1SC83U1lD?=
 =?utf-8?B?Z2ZYSDFVeTVBdWxRN1pMSEJwZlRSRDMrNUtZMFJrWlNGZlJORUh3S3YxaHR1?=
 =?utf-8?B?Z0tENDhQQ3MweWk2cjA3bGY2MDRJcm9HQ0gyeHJ6VjJqcDZGbk11TVJlY3lu?=
 =?utf-8?B?RWxzbGJrazF5WndkRWJPZTNtRUd2aExlNGZaellHbDFnSkxtd0lub0o1Q1dr?=
 =?utf-8?B?UWZrbXc0WGNmTWJuR1BPQXpXcU1IeVl5dURsa0x5S1k3M2xacno4aitsU0tk?=
 =?utf-8?B?bWJITDRISUlaSkJVR1FVazdiYmw2Sml3d0d1RVprN2NxZ0YzY05TK2dCbFV4?=
 =?utf-8?B?Y3NDSWcybnlBdVhobVp5d2txZTI3YVVjbWpPSldBMk00R2dOMExPK0dWRGQ0?=
 =?utf-8?B?R21HNENRVExDbFhsd1BTaDIxWFVMcHhzT0hMdkpNbjBadlJyTmhaMGprc2FE?=
 =?utf-8?B?L2JkKzRPb3E5blo0V2FBLzYvSTBaSzg3VFN1YTd0a0ZTSEJ1Ymh4SGF4endT?=
 =?utf-8?B?S1BjdlVXNGppQ2crbUJaampPSVdsOHBYdGgwVTEyUThYdC9HUkc5aDE5aUg0?=
 =?utf-8?B?MjhTSkdlSzJ6ODJyb2RiOHVSMStzbmEvOTdXZ0Y3YXF6UTRCWXJtME5aYStW?=
 =?utf-8?B?K21XNi92NDdoV3VLY2hnM01kaisvN1RMRTcvNUJLNUdzSU1tS3JsZkJ2SVdL?=
 =?utf-8?B?NHZYZzU3UUFOelh0a0dsbmVvUnZZaFpMQlZva0hyODU1cW84b25MTmRBQUR1?=
 =?utf-8?B?MGxvMFdHa1VSNy94aVhXWlpLdjIvTWdDTHRvd3ZocVFNYVN5QVZmQVI4aWRl?=
 =?utf-8?B?Z0N0bGIyeTlNcE5Jc0RYTU9oOGY4dWJNVG11MjJNdVc3VFhRenhWWU9RWWVl?=
 =?utf-8?B?UEo2d2ZlY3lHRjdhREQvVlFvQ29WbkNKcDUvN0kxai9lZnZNdUlzZm1OaVNs?=
 =?utf-8?B?ZnRoUWFJUWV2a21kV051MkdtOXhGOGNTTWZ0aE1NaW1PUDV1d2V2bXpVNis2?=
 =?utf-8?B?WHUrYkx0eEN3NTJoamZpcVZQMTV3MGJXOGhQWWdzVXhKYkxWVkJrbklxenI2?=
 =?utf-8?B?UlV5emUxc2lGUS9DR3RnQnRKVFBRbXo5V3ZtSmtnMVRERFR6blpMSGxaQkFk?=
 =?utf-8?B?RDgxUTR6ZEZuSnE1ZzJ0KyticEViK1pKV0ZKeDZBN2ZYbXpYdUZSUkFIdHF4?=
 =?utf-8?B?MTZvdERoZTlxNEtiZGRZS3pXN3JhMGVxU2hPOEsvR2t0UjlGSk9nc2UwTCty?=
 =?utf-8?B?ajJZUVBEaGkyZzNxeGxXMG5xUEFTaFkzSURDSmxKemJyRG1ubnZaLzMrRDZm?=
 =?utf-8?B?UC9Ybmt4TkRPWXRGbGFXckZGRUwydDVtMzQvTjVUdXhONzhPSWZDWGliQktB?=
 =?utf-8?B?YXpxOVpIcTRJMzdNaDV6WFFpSEl4Uk9RZnl3azc3YnYyakRCMEZwbEpHQXpZ?=
 =?utf-8?B?SmlsMWRralhuNzdzeEc5ZFZmK0JFRG1NMTRYRS9BNjlXemJHSnd2Z0s5VG1m?=
 =?utf-8?B?TXBQS0hZbW01OFlkWXAxZ0tSc2N1NzVMWDBiRkhpUEFuUXhuZktjYVVHWGRo?=
 =?utf-8?B?YnRrU0JkdlhGd1N1dWR5MXdJTHpJNXkxNGM4aXp1Uy9ZT25US2pCWHk3L3lW?=
 =?utf-8?B?ZkpRWFVyaHlDMlR4SERlam93aHB5WjhQaVNuZm5LdTR4UEJUMzl1NUVpMXA1?=
 =?utf-8?B?ajZOVGpyYlhZbWFZa21FQWhUTGtZQWRsTTBMc3NGUkkxQkVKNUUxd2kvSWE4?=
 =?utf-8?B?WjhLN3QxbUdKczY5THJpaUR5R1FhRlJoeiszQlNKT3dPMmt0ZXN4V2htL2My?=
 =?utf-8?B?dDQ4YldVYTRqcFZHVzNOL1V5SWZ4aUd0dUdaQTFsREhucnpZL0s2NkZmOUJu?=
 =?utf-8?B?OXIwVFpleGJQa0VWTnR6c1QvWkR1R3VoNjJyL1BWNUNhOTVxODhtWk9NanJT?=
 =?utf-8?B?a2pTc21qZ2xZRWh3a1ZTVTFNRmx2RUhHZDZrSFkxUHdYNzlSeU9hdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c1b98a-b36e-420f-05a8-08dec8c4723c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 20:51:59.0358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hp/9o88r6lFDECR7Y8tJg7E2E9DOAtBESuNalJI+Bpw9yW7hwI2xXmgqC0a+m8NTXxsUUyBucPQ8W3AHaxc+Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8882
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

Hi Philippe,

On 6/12/2026 6:56 AM, Philippe Mathieu-Daudé wrote:
> Hi Nathan,
> 
> On 12/6/26 03:43, Nathan Chen wrote:
>> From: Nathan Chen <nathanc@nvidia.com>
>>
>> Introduce a new compat for the changed default for vfio-pci device ATS
>> property, from "on" to "auto".
>>
>> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
>> ---
>>   hw/core/machine.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 4d8b15d99e..c0cdf7c9da 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -43,6 +43,7 @@ GlobalProperty hw_compat_11_0[] = {
>>       { "chardev-vc", "encoding", "cp437" },
>>       { "tpm-crb", "cap-chunk", "off" },
>>       { "tpm-crb", "x-allow-chunk-migration", "off" },
>> +    { "vfio-pci", "ats", "on" },
>>   };
>>   const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
> 
> Shouldn't this be squashed with previous patch to keep bisectability?

Yes, I will squash this with patch 2 to keep bisectability.

Thanks,
Nathan

