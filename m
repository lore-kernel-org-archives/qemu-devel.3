Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602CEC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 13:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uclDp-0008F4-Fi; Fri, 18 Jul 2025 09:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1uclDo-00088m-8T
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 09:33:56 -0400
Received: from mail-dm3nam02on2073.outbound.protection.outlook.com
 ([40.107.95.73] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1uclDl-0004T4-Rw
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 09:33:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTrWeQrrHgUx4bnZLmD3x4zWPbVutRrtWxnu26nA8mgZvlLDX+AY1OaCNOiiIGF4z1py+NEHa2G9jlHTNHOIOT09os4xcer8qqqaajZGeRKh8HcvLh4eJOizY1CEio37wDULfvJtEYzNGqhjt8xnNweqOhq/uSN3+xVi3JMnstL6/f7+4px2Y0/CzuJVy0EAavzskfvYE3sQ6Gh1Xr/B2Tvt9hYOY1cL6K15EjjC7iJ9pRyROxWyUeUtnEqVgXCLXjidiKMamgW3qNOVgUdN2GU2G8Ilvtx1fctYR5n+3Dngb+ps8shmztntfsV+0Etr9JOYalHtE/5SM0HS2lBfhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqcZxgkPm9+3+yUH8qw4M04nYRrdP0DeHXu43iz8c/c=;
 b=wkB41nduPCVmxhhh+P9pvM0eG+ILp0vcGX0DrCzIDCayPO4CvFwCBcLMjgBa19S918JrKXUnYgGPRFbZkAFQ4amBGhh7q2H9qixGHkmnTAMl4D4q55wHib+Z27Pu0H+MJgRQN8i1AV5ZFre9NcGGJwzb3REBoTZPuWPUc0ZDBPvGzwMpyk289jpiy0/Gc2UvHznYSmj5Qxy+IAUTqQHsrKmG57LAoZDhe6liHHqNI4F+HOZsasfHjdLYmc3RODW8aXHxB9yUPvP4+KIkbqyt2UgrMaAbcdM3G78xwXJkDhdk2H7uRyHL1kt2QDYfyPWLKglXyoeDHEpHQEnLBNjFKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqcZxgkPm9+3+yUH8qw4M04nYRrdP0DeHXu43iz8c/c=;
 b=rCzhT0WyGSdyGQKsK7Ncihh64nFfeBBYPk+NTK5pAupEFHZPQPqbJRu5Cc7itE2r2VS9DWJiajNIN+D0vVJeaiqIbQNtsOkmmzezQuo8u1BiHs6dPyZml906kTGzo0ojYmlYnDP8MzyJ/V5wqD3Fgh4cdoDz8F0ZxCI2I5iJADI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS5PPF5A66AFD1C.namprd12.prod.outlook.com (2603:10b6:f:fc00::64d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 13:28:48 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 13:28:48 +0000
Message-ID: <273eae46-57d0-43db-8b67-f628f729b978@amd.com>
Date: Fri, 18 Jul 2025 18:58:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] hw/i386/amd_iommu: Cleanups and fixes
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sairaj Kodilkar <sarunkod@amd.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 eduardo@habkost.net, richard.henderson@linaro.org
References: <20250716073145.915-1-sarunkod@amd.com>
 <6e56761c-64b1-43eb-9ff1-316b6de082e7@linaro.org>
 <a184b8d5-4620-4b21-99c4-0fc859647d14@amd.com>
 <20250716092916-mutt-send-email-mst@kernel.org>
 <9570378b-0084-4acc-bb87-7ba4c454ddc6@amd.com>
 <20250717020716-mutt-send-email-mst@kernel.org>
 <4413c937-5bc2-4cd0-ba25-617e757a07fb@oracle.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <4413c937-5bc2-4cd0-ba25-617e757a07fb@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS5PPF5A66AFD1C:EE_
X-MS-Office365-Filtering-Correlation-Id: e150a0bc-4249-410e-c188-08ddc5ff06cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjFQZVNUYUtLTUpFOWxIazhkL0FJVGtwRThlQm9zbU1RTkIzNXkrMWRUMXhk?=
 =?utf-8?B?LzczaUQxSGl1YlNDaTVoMHJFbkxDa1J1Y3JjNGdIRndEVjNtanViN0NqbXNu?=
 =?utf-8?B?bFdNVG5KeWVUUkhLZU5VK2VaZmxxdnYwc0FoVHNRRUJYK1Z2Mm9IcGUrU1NR?=
 =?utf-8?B?L1pZZkxMRy9RSW9EUS83OWI2endsVDlRNUp4aW1tMjg3OXJwWURNalBPakN5?=
 =?utf-8?B?SDdKZndFcytxMTZVYno4NGlva3BHek5YaXkxNHBjbzBGRmFkTUs0ODNIK2xx?=
 =?utf-8?B?V3k0VDVkQjVEYkIvdnpRL3FiT0dUcjNkd21LNHJBN1F3R2VybUNmblFqQ3pX?=
 =?utf-8?B?RVZaTC9PMDdHYUpxOVdiRjIzdHFKMnFpbG0wNmNzaUQyNXJvU1VpakZmUFFT?=
 =?utf-8?B?NjZxVHN0ckFSZlEyc3ViQVgyb2VzcXlwY1E0WW5zd0ZSQnNNYndvTHpnQk5Q?=
 =?utf-8?B?QmJmR2ZFcTFML0xBbW1yNDdJS3R2NzFmSVB5Y3BPQldqbXo3MFNUYXZQOGEr?=
 =?utf-8?B?aTdQVGUzMk9qRFlzNDc2RGRhNFM2WGM0MGpYQVpiTGdydFo3eVRoM2l3NS9Q?=
 =?utf-8?B?M0VjMUNpcXVHbUZyd3gvWnRidkFLbW9QelhZekRobHgvQ2hkZk9xSzIzNVRT?=
 =?utf-8?B?bEtGWHhNcG4rR1pDUjlmWUFiN2xwd0wvZnVqWWxTUHo3L3V4QWd0TWpDSHBP?=
 =?utf-8?B?SEtNTTQyVUJONzFrbDRnUk1hOEhWUXdjYXU3N2tQNU84QXk4OGNNYmlVODRT?=
 =?utf-8?B?VStLa0NQNFIwWHhsUXpjYS83aHVYcHNZc2JBM1pmenRaVGFLalgrbi9KaXc3?=
 =?utf-8?B?aWZnSlZIVndidXhwL0VxditiWVhjdllHNHczWmZrYmZWak44MVdESkRZOEVI?=
 =?utf-8?B?Y3dnSjNlaXA1dkltTHFaWkhtRjBmNjBYYlVoZHp1T01sTzRPcXp0bkphY2w2?=
 =?utf-8?B?eEFnVFl6UFZtM1h4L3cvWlNmTklPeHR0alI4QVlNQm9tNTZTWmFRNFgwRVp2?=
 =?utf-8?B?RFRLdGl4cnViRDBPai9DSHRGOHd6QXlvTUhpcEFONCtYd0plS0VzQmtQem1z?=
 =?utf-8?B?YXp2c05HVm1MN3ZDS0tRcWZJOHdTTXkyQUFkQmNjakJxUU5sMlZlQVZHYkY5?=
 =?utf-8?B?M1JVSVhUNDhWVmtucEVoejdGNnYyQm9mcGRWRStFcEpSQW1kRExJZmZQV3pa?=
 =?utf-8?B?T2NnN2hZUk4ySzByMWJpTUg3S0hPdWVROUFMYTRkYWI3QXNMQ3N3NW9xK0g1?=
 =?utf-8?B?MnA0bldBdVd6cXpGL0NFL3JjckJZZURMTWJHZEtqMytPZmFkQ05SZ3lDMHF3?=
 =?utf-8?B?eUExbnRjMUd2NnlVODY5ZkREUWhmTGc4Skk5cnE5UDNOV2hRZWdteG54dlNH?=
 =?utf-8?B?clRjVlJZcmxCTjFGK0UwMFBacGk4bWVtK3pXZk14amxTZDVXVEVZUHBSZFlk?=
 =?utf-8?B?TitTbUZRSVA0V1FnaHJybjFUN3l0WlJ0L1FRSDhBSldVeStaMXJmbVlCOFRW?=
 =?utf-8?B?T2EzOE5ZdiszUUc4K1lZdytiVkx6NjExeGs5cnBOMjNVcEJDRjVPZEVoMU9X?=
 =?utf-8?B?OGxHanQ1c2hCQ1NyV1ovWWl3dkZ0aEp0REdiSnpnREd3WVVia3kwSFJYK0R6?=
 =?utf-8?B?aFF6TUp6c1dicHFNVUZpSnU2Yjd1endhdzdGc2pqOXpDSDFiMkw3YXhFNWVa?=
 =?utf-8?B?Z3EwVGFFbFZPSEVOTFNrSUhNODh2UStyWmxPdXZyTEVKZ1NXWjNoODNlSjRN?=
 =?utf-8?B?MmwrNDZQa1gwZ2wrV3Z5TzBpZXE0VTBMblh5dUlxQkVvZmhyZkwxemdvV0Zv?=
 =?utf-8?B?MmxGTUU2NnRMR2MwWWdKUzRHaWhZMGQwamxKOUlyNFFaVWhjSGtUWkdheXI3?=
 =?utf-8?B?a2ZZeFZCZlovMjE4T0hvR3ZHVUhHSlpRamZScUNtZ3VIVERqZGhaMWVYR2th?=
 =?utf-8?Q?UsIHKVDCQOs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmRRUmdoM2ZRbW92YUdvcjJVakdsUmtYRzhEOFNXSklCMFhkK0NlM1YrOElN?=
 =?utf-8?B?ZWR1a3pWNDh3TU5qSnBxNTkrVmVFYmZYUUhlSUVrYTZGM3VoZmlyL3N2bTl4?=
 =?utf-8?B?a3NtRUlQTXNjWldTbEZ6RmZNSE5rWTlvdU5EMC9FeHR1ZGFiWTRScmpHVlI0?=
 =?utf-8?B?YVRTak5pY05YVUpQRkpXbGFsYUZpQXMxdE4xL0dYaVFiMGFpcWlQVzRpanQx?=
 =?utf-8?B?TUJKMzFUM1JmT3FHTDlVK3JIb3gvSmRoNXBnTWFKQnRZWVpWeUFQL1RGd0Jw?=
 =?utf-8?B?ZzVEZEdJN2pML2VLWTJqNEhiREhiSkpKVk95cGlCaXpGUUlRNHVkMFQwcGZq?=
 =?utf-8?B?NVIvYlhXdkVTelpGdWRmQ2N1aGZXcGJYTU5SVm5XaVhRRXNEMTUrcW5INEgx?=
 =?utf-8?B?QytsWkFyTDVqRVdkc1ZpdVZkWGFtQmc4S0Z0azNldFk3am9ISjFjeUxlL1hB?=
 =?utf-8?B?YytRbmFZWkQwcGJ6SkdISmVxanE1UUhlbmtNbDZMcWozREpuYlZwcjRKZnBP?=
 =?utf-8?B?SkFBK21YZTh1Sis1V04xZlJQdC9TL0wyc2h5N2dvRk5TbUl5V2lxZ3QyRjRv?=
 =?utf-8?B?QkFXTmp5R1lkYSt1UlBDQW96dWJUVzhKdkFCZUwyNE5HTWxGWkZmemZvYWFm?=
 =?utf-8?B?UC81dW4yVCtqbWs1V0UzRTl3cXZ2bW9RdXRnMnZDUnFYOHZoeFJJNE9RZVI2?=
 =?utf-8?B?UWszc1E5Nm84Z21SV0d4NEcvcHIvamtDcDkvbE52L1N5cng4SUFKRG0xTVky?=
 =?utf-8?B?bVJIU3VEUkI1S3g4RlVQRnlWbTA4MGRtSjB1Z3VaLzRDcFU0K2g0NUVWVFVy?=
 =?utf-8?B?eG1IVjQ3amRoYUZQbGFHdjltNVhIV2dDWWZGWmRZKzVtb1NPWm9CWGFNOHF1?=
 =?utf-8?B?cExPZ3o5cWoyandtenlHbEhjYkRMblZuVDl4eFFMZURjbUJMWkpjQ2pYaXRB?=
 =?utf-8?B?RzVZUlRJUk5vTlZwZFJaOHYwTVhycmo1TzRxRCtiQjk0RS9hcHRpRDVRTk13?=
 =?utf-8?B?VmJZRTVQWjBmRGdoZTJieXMybXcxVXg3L2RheXFmcXZUZWNtYXl2Q0JBa25P?=
 =?utf-8?B?ai91eGVpUlp1NitCSnBGU0RJQTNHa3o3S3hvK2RTV1ZjaFhXdXBldjhxdzEv?=
 =?utf-8?B?bnQ4REJQb1NzNTFKUHcrRmNyeFhOMHJPbmdJaElBUlFtSXZYTXF1S0tGUkNM?=
 =?utf-8?B?YVJiUldvQjIyelhJZEEwUUhPTm5mekg4eXFOMU1XNDZ3T1V5K2Q5WENIaWV3?=
 =?utf-8?B?S0xjQk5lSlJ3clBTZmw5elJhQWJXMTVPdEQxaU9Ob3VBdTlTa2djYUdLUnVr?=
 =?utf-8?B?ZVVBWlJZZTROQWhTbDBLTGtTL3FmZk8vNTlmYlh0dHRFaXZwaTJ6eFVFZlda?=
 =?utf-8?B?L2Y1RHZkQk4weXNibzBBVDB3MUR2RTJxZmdvd0lIRWtTZDlqb3JOWSttK2w3?=
 =?utf-8?B?RWdYZXd1Qk9jTFEwTFJWYnZGUjFOZlhQSWN5VDhSWThrMjlxMXhlRDNXY1Zv?=
 =?utf-8?B?Qm8vSTRWcVppbExVY09LODVEQ2Iya3l1ejVGT0VyN2VoVzRDV0JqaUJEcEtl?=
 =?utf-8?B?VmJrdDRqYlppZlRmdENRdW0yWG9qNWhTazVRWXFxWC95NWxGYUUwZ3kwcXZn?=
 =?utf-8?B?VlBSbS9ialNLSzcwZW9QV1RwcmlHRkJ1YTVLYlFLV24rOVp3WFJZK010UU1O?=
 =?utf-8?B?ekllaEluYk9pc2pQK25kOEtYZ1lPQU5FajBUSXFOOVhkNTJLaTJEUkQ5OFQ0?=
 =?utf-8?B?RDA2WDIvKzBYZ2tuVThvTnhGOEtmN0w2empxR00vTXZxR1RGQ3JqR25oY1J0?=
 =?utf-8?B?QU1LSktrY3JsYVNnNkEzcVlTTHhXMUhnNGNBcWcrNnJvRUJKckxOWmpVelBs?=
 =?utf-8?B?bnphaDQwcU9QVzh0d1dsbU9PeTVNL0I1NG9tZ1l6NDZ4MlFpR3htTGRCbUpM?=
 =?utf-8?B?VlBhQUZlZXFYOC9odkorWTRJdGxHZzNicm1adzZ3enFyaWY1MTFROFF4ZDdZ?=
 =?utf-8?B?VlZxZGdDNTBmcHQyR2VVYjRzR1JFck9Pc3pmWmZkZ1dnWkJCU3JFWE9mNTRZ?=
 =?utf-8?B?N3c5aDBzdzF3NmJwUkwybzFCQTIvYVY2YllrZHRTa0JYMU9GcHcyN2dJRzIz?=
 =?utf-8?Q?2oBIN++2Qx8/JeyVOnC4dHC0F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e150a0bc-4249-410e-c188-08ddc5ff06cb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 13:28:48.0958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHEhffme6QLaOt9fuTKvaJ9ZoOZRL2GOrn68SrQ0tmjCGXXqcP4t8i94KmhssA1fb4xtsbrEeIC5Z5BO0J1hHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5A66AFD1C
Received-SPF: permerror client-ip=40.107.95.73;
 envelope-from=Vasant.Hegde@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Alejandro, Sairaj,


On 7/17/2025 7:18 PM, Alejandro Jimenez wrote:
> 
> 
> On 7/17/25 2:07 AM, Michael S. Tsirkin wrote:
>> On Thu, Jul 17, 2025 at 11:17:05AM +0530, Sairaj Kodilkar wrote:
>>>
>>>
>>> On 7/16/2025 6:59 PM, Michael S. Tsirkin wrote:
>>>> On Wed, Jul 16, 2025 at 06:26:37PM +0530, Sairaj Kodilkar wrote:
>>>>>


.../...

>>>
>>> Hey Michael,
>>>
>>> Sorry, I should have mentioned which series I am talking about,
>>> https://lore.kernel.org/qemu-devel/20250502021605.1795985-1-\
>>> alejandro.j.jimenez@oracle.com/
>>
>>
>> Alejandro said he will send v3 of this.
>>
> 
> Yes, I am working on this task, and expect to send the new revision soon. The
> pending issue I am working to address (failures on reboot when guest boots with
> forcedac=1) also requires a change in the VFIO host kernel driver, but I will
> send the QEMU patches as soon as that portion is ready.

Sure. May be for now keep that as known issue and move on ? we can fix it later.

Other thought (Again it can be separate patch/series)

Ankit's kernel side fix to support different host page table level is queued for
next merge window. How about reducing MAX host page table level support from
current 6 level to 4 level? I think this should help to improve performance
little bit as well.


[1]
https://lore.kernel.org/linux-iommu/8109b208f87b80e400c2abd24a2e44fcbc0763a5.1749016436.git.Ankit.Soni@amd.com/


-Vasant

