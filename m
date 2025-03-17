Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A968C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 12:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu9in-0002uv-9H; Mon, 17 Mar 2025 08:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1tu9ik-0002s8-Jz
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 08:37:30 -0400
Received: from mail-dm6nam12on2060d.outbound.protection.outlook.com
 ([2a01:111:f403:2417::60d]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1tu9ii-00061S-16
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 08:37:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9DOj0oKTCUW86aaBQN/JHx5ScR/ytnUi8wdmaiVNPFX6fCejbknwr2xhOVhrR75sQ5B+aTwWzvZzsFtwyWVIrqGiquwqmvqKuev1thazMWV3+JRwVpHMc8CR1psCVg+6IuHlb2gJVkaHvaJh/Wwd+8e7dkO7H+bkhlAK6HT4skPs4cp1yMYFXr2JTNQcevsq10jaY5FX+gU2MWF7DtuImxGRQEF6H7IqdFZxmP4aRYVyhshaxW3yGJNoxPKIFZpgZtN3FYcLswo16jHZUqCvSNgJvdAiFs7CJIh5mw7xZeLAxhnpQvIHqJg04isiOf4VB3obVsKRpvcjkQYiIwr1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/XhpGMLQyxVQOfTRozN1+MgCWPlEDedhYjo/na4Kx0=;
 b=hNfXeolkZl2VL9/x4yoravSJeGCyKFHjrVFstahf1CGBTTiKGY2X084a2+Dvx9bMnf+wo4Z4NW312RAeUPris8gB129C7VIact8sf6Df4uoKKhT/AuYUgUMmeeuJH7L8UTMzcoH0xe7AA5IqDsrRvofHewvVhOU4DVP2Bj5SAHsPdPAgw9KSzm3AB+0X2zXSj4d6vqLRv2/ajjlO1ceonA9YrFfbuzm7SyiqZrzb+WEVpZo5J9Cv89XB3BRIm1Xngls+B48BIoVbaU71cdk8cRMPrtuW7+q8zYS4P6AvmyekeiBbY9Z637f60wBxcKAa+x75s3M445CQowEVr4t/ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/XhpGMLQyxVQOfTRozN1+MgCWPlEDedhYjo/na4Kx0=;
 b=tbUBjnpfVGgc8AKyVXOeekDCJ/Omkn11PkyXMpB934gB9Lg5Rw/YKEW+iJxL/RVM0xX3/4cXmjlzqFoiH/0bXj+CyBHO5vCdDrBypoRINexzwRoseholsGf1ob2+sbNZ6IBp2sYublGOBGN1NRb9qJHZay6PC3gInAxJttW2r6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 12:37:24 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 12:37:24 +0000
Message-ID: <0eedda68-633e-4bfa-aec3-25af385c3dda@amd.com>
Date: Mon, 17 Mar 2025 18:07:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] amd_iommu: Fix Miscellanous Information Register 0
 offsets
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250311152446.45086-1-alejandro.j.jimenez@oracle.com>
 <20250311152446.45086-2-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250311152446.45086-2-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0197.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 6333a599-76aa-412b-4bf4-08dd65507803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RTBWR1lEbGNucSs4L0FkVFRtV2tSYndLb1JzWGpNUlBKSS9qYlcwTnUwdnVr?=
 =?utf-8?B?T3lJeXVROU5aVTMrR1FtWitzYkxjbXJxcUU2QWQ4aGZGcGVodzhkemVnN0FW?=
 =?utf-8?B?bWppdVI5cTJOS1NSa2VCMU1UbU0zdG1BMk5Vdzl4elcrQmNROEVwVEkyQXBr?=
 =?utf-8?B?SVhjaE5qNXFSNlZEaDl5anZ0V05vTWpDK1ZGTTBRZ0JhRno0RFdzNUQyZzNk?=
 =?utf-8?B?VkozanNSSTRqWmUyZTUxWEQ1b2FNaW83MktvN1lHbHlZVDdOSXFENmJSV3VE?=
 =?utf-8?B?RU9qTVVaR3ZzODlRcTBra2JybC9PRlg4WGhJZSt5M1hMd0lXZlEvL1lUbjh3?=
 =?utf-8?B?VE5lcGdIRE9PZVRHWFp4b2w5TlFxUU9mSGI5dTlpWEE1RXJ2aXdBZnNLQkky?=
 =?utf-8?B?UkIrOHo5aVNDN2N3c05PcGwrajZUa2VVekV5OWNDbnJyeWJQOWs4K0dxa3E1?=
 =?utf-8?B?SmtPcm5vVjVPUGhMeExOQmdWZmFrU1FPVEYzY1hzcGhyQ0dSUkZyRElGL1lC?=
 =?utf-8?B?bkJaY3JlNjVuc2ZpQlhQbUd6ak9qZXRKMUpkRzlkZ2JpSndwSDNILzFpMlRI?=
 =?utf-8?B?dVNYZHhUUVhxTzVBWHdrc0JCZCsxV2NoeGxXSDNZaHFTOUJxdy9VdWZwcFZM?=
 =?utf-8?B?ZGJveW1rRWFoOHJVMUwrQ28zaUwvOHF1OXRaTkMrWjJ3MGhTUVBEWnlKS1Rz?=
 =?utf-8?B?dCtPMHVqMUJWelJEQlk4Q2dyd0phV0NuaVhMUFAwTVNHWHFsZ2NtYnhXSDc4?=
 =?utf-8?B?anNILzVDYWo0UVgvdDlacDY5bUNrMzRwc0RRUzFYemRHb2ZmQ3dvZ05kNlYv?=
 =?utf-8?B?VTJWY0dsdDFxVnJYdlFoOTRjOGd2TFUrSHlqWGE3QTVyRWthcXk0RGthTFJ5?=
 =?utf-8?B?TkJKUUFkVHFOYTRrWmthYzE3d0Q2cFl3dFlaVlZvOW5hR0JubjVodzB2Vk0y?=
 =?utf-8?B?UEJOWlJQUEE5ajdnaWR2dGExUlVoT3lzRjUzSWlocU9nUHBlTmdvejlqN2t2?=
 =?utf-8?B?L1JSejc1YTZzbVQwc25xTFU0NFVlbitvREpjV05za0RydTROMzZPSEd5K3g2?=
 =?utf-8?B?U0tqbzR1K0twbkYwa3ZxTmpjR3JOK0x4VnBlZHlXUkNTREFIYzQ5MS9EZEox?=
 =?utf-8?B?b2hOUUNtakp2ZmJlVGk2OG9Qb2hWeDkycTFBYndQWWNFUHNXNzZ1dU9YSks5?=
 =?utf-8?B?WHE1TVpoSmFNU3FZU2NwMUQwYmxjK0VIRjRqM2h3QU5RUWZVVHN6SjVVR0VL?=
 =?utf-8?B?RDFRQTlHbnJrNGpHQVZqTU1XeWV6aHF4YVM3aWcrZmpRbWhMb1pLYk1Sak9q?=
 =?utf-8?B?aXEwUStUaW5lb1lEa1RwQ0hnU3JlTWYwTnRnaG9HeENHWFFodXBoQ05OanpX?=
 =?utf-8?B?YWRyNkVsMXREaW5nQmphNGVLb09vZ2tEWmwvdjM0VlFqQlNyVkJiV2ZDejh2?=
 =?utf-8?B?d0x3S3g2RkdUalhHUFFoRmVaOEVXaHF5d0FScnVrM1Ivdk5XWXhHZWV3L1Jj?=
 =?utf-8?B?QjhuWUFBY053ekJSZlB0R1Z0ekwyc2RMa1dkb1lVeG9IazJkeTludktIYldS?=
 =?utf-8?B?bDhnZTBkeTNGUVplei91MFZ6clRlRTR2T2E0SjhmSEI0NHdnczhFRENuVDhM?=
 =?utf-8?B?TkFKSXo1bDY3SFp0Vy9DUmNPbzhvTDNuWUZ5VjdzZTRJbHJ5VGFtQjkzVStG?=
 =?utf-8?B?VFV6TURXNjdtWDFiOEYzVkFMSTN5Z014aEdJTXhEb2tPQkRnVmdTb0R2ME9l?=
 =?utf-8?B?R2pxLzZlcmdjMldDZjQ0VjU2dzA5K2liUXFQQWFRTDhrT1JtVWEvQmF4Zzgv?=
 =?utf-8?B?WmNnd0VjL01qK24zbE96VDl4VGMyUXFDWDVsUUtrUEViQ2tjMGRPU0cxekVx?=
 =?utf-8?Q?LVTxDbKB4P5AD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDR1d3dkNzE4djA4Zm51RGdVRTVnM2lCOW9Hc1NRSHFqc2F1SHdLbkdPUVlS?=
 =?utf-8?B?anB3SHNDcTMxZTBJQjJEc1RvVXBTcnQ1dkk1eDlIclBERHFDSGZLMlVoTzZI?=
 =?utf-8?B?dkVOMzBGOW1XK3hnU1BDTXNPcVdPRVFFRGg3dFMzWlBIVmNmdDg1a3lSd1FP?=
 =?utf-8?B?NzMrdDJwU2hjdG1Qcm52T000MDdUNVFkN21ZMU9hNzBUdFhobk13bWVGUlI4?=
 =?utf-8?B?eDZYQ09IM1pOY2JRNTlzNUlpWTVmdHUxSVZJUTVBdkErWjd3TmdYa2pqTjl0?=
 =?utf-8?B?cEZsM3d0cmRVS1lENW84U05Ec250SlhENnM2YWtsZi9zbVVac1o1dmg1Z0RB?=
 =?utf-8?B?QjVqU3hjUEZ1WVc0MHMrUUZxWDVhZHRaYTFCUXh0bUN3Ny8vanpUM2ZmOFBF?=
 =?utf-8?B?S0MxQjVFMTZhR3pSdFBpSE9BcEpRK1ZSSHpZblJTMXRMOTBESWdCSUI0REJU?=
 =?utf-8?B?VGNpQUg0MFV6a2NVczBKZGY4cmVuVFgrcjRNRzloekZpN0o5cHJpd2dDMTUr?=
 =?utf-8?B?TXZSZnBNdDY0Q3JRQ3JmRk5MbHZNTWZsTkhBSWdmMkNKTi9EcFBONWpsMjRp?=
 =?utf-8?B?c29RaUVBTkV4ell2K2xJd1ZHR2w1YXJEbHRQYStEL1ZQejdVWmJjSjZqQ0tC?=
 =?utf-8?B?SnVJTDd0UDhodkZDb3FrbU9vZGI0TlZrOXVJcHNHRm1HVkUzN000SW9kckZ2?=
 =?utf-8?B?R0d5QWtRMXlPVnp1S0gzQkIrZGxCRlk2M2ZtMkl4dDhMZGFmZURtZGxBRDU2?=
 =?utf-8?B?VFh1cmMxK005L2dLTndtSStTeVE4Z2JJVEJqSU00d1BSamt0ekdpdERoNERG?=
 =?utf-8?B?WUNJakJUeFM5bDEzd0ZZS2Vyc09pODFUK0tEb0ZnRVdIdmRmN1F4MVY1WTU1?=
 =?utf-8?B?Q0p0QjczWGYzZ1NLZVF6aGprZ1c3TlFmVVlNV0p3YjByZC9jcUk3UWlZYmlj?=
 =?utf-8?B?L05uL1UwM3Q0MDBrNldMcGFzaHJVWTk5cHNnd1NwWGl6SWZNck8yMEh0R0V2?=
 =?utf-8?B?ODA0MkVSM3puUnNWRThCUkl3b3pMOUVzVjhWTGorbzh2bnhMYnJnTzdQd0w5?=
 =?utf-8?B?eWpDbS9ydkxXRXhGTGJaYnBBQ2U4NHAvOStWY2NzelVua2FrZmhIMEtMM3lB?=
 =?utf-8?B?WmlaaXJsdW5tdnlRRUtLTklBUFpqSkNkZDUxTUpESXdETWRhNVQvTWFtR28z?=
 =?utf-8?B?SHJhalB6YVBIOGZPTy9FbFp6ZURYNTc1QThYN2lGZE5WSzBKa0lYWkxnMzN4?=
 =?utf-8?B?OFhuYklSZnVxenZ0SVlkd0hoYVhKck1LZVhVMGZOdUhDVzhYL1FZbUt6YnFs?=
 =?utf-8?B?cnBWL2dBQVZsTDNUa05STUY1aTl4WnNHb3lMUUlaamJaZVJiRUhHeHpuSUVV?=
 =?utf-8?B?cVR6QTFIYlZ3NTFVemhPMEdlUVNpbWdLTWNsMjdvT3d1NTFyOGJqT3M2cFVN?=
 =?utf-8?B?bWNMQ1pWSG1xYWV3RXhTZUdDQ1MxMmk1cjJYQlo3emlrOGZTaENzTjNEMFFQ?=
 =?utf-8?B?L1MxU1VKd0pSY1RzS25EME4vTENTNnpoQURJVUIxdW9SVjJoTk00eVp3dWhZ?=
 =?utf-8?B?MkRBOVQyRnlDR1g5YTZIMTRDSDYveERPK0xxR21YdzNhS21IU0JRLzBSd0Nk?=
 =?utf-8?B?RjhMdEsxRHg4aVpxTWtudmQwRzlLMlRKM01aNlBucUZqMlJ1a0JpUUoydkdT?=
 =?utf-8?B?bElaUE5RQzJnUjVMRXp1Q05yeGY4TkVCMVlhWWRMc0FkaXNLYS9JVHBLb3Vh?=
 =?utf-8?B?aHllWmZYQkg3QW5VK2tKR3VTVkp1M2RtWkdmNzlreXNmUXRwbjY0RDFoNkxD?=
 =?utf-8?B?YzdUV1l3dVdwUVpNMk05T1BEWFNGSFRMRlNtRE1sdTZxbmRuSFN2T1MvcU5K?=
 =?utf-8?B?ZGtsMkhGcVJXYXMybEJlYXBZMzB5VFNpMk5Ba0FQNmFacnk0dDBFaDRvVlNu?=
 =?utf-8?B?NllManJqcGNUaXNPNE8wVFU2dGVmYzE0Tkx0Ym9PS1Nua0IxWUFHY2kyVlJL?=
 =?utf-8?B?bjh0MWYrY0xaci9XWWFqUjkrcG9CVk93WWRqNFdNZmNXUi81VEhianFQcDZo?=
 =?utf-8?B?VWRvNklMbENmOUVoWkc2ZkJmTXZTdG9TencvUmhub3YyKzFNSTFOd0czQnR0?=
 =?utf-8?Q?50cAHM5XO9sIoy/oGZsbN4Rg/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6333a599-76aa-412b-4bf4-08dd65507803
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 12:37:24.5123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3eNU7hIISs0Edme5vjBC03Oz7zwj8ROCdyDCYkO2s0FiWyUTC3ZY6cukRbU+Tw6XMrh4mVbJKbqgfv7EUohMNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762
Received-SPF: permerror client-ip=2a01:111:f403:2417::60d;
 envelope-from=Vasant.Hegde@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 3/11/2025 8:54 PM, Alejandro Jimenez wrote:
> The definitions encoding the maximum Virtual, Physical, and Guest Virtual
> Address sizes supported by the IOMMU are using incorrect offsets i.e. the
> VASize and GVASize offsets are switched.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Good catch. I had read this code but missed to catch this!

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

> ---
>  hw/i386/amd_iommu.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 28125130c6..4c708f8d74 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -196,9 +196,9 @@
>  #define AMDVI_PAGE_SHIFT_4K 12
>  #define AMDVI_PAGE_MASK_4K  (~((1ULL << AMDVI_PAGE_SHIFT_4K) - 1))
>  
> -#define AMDVI_MAX_VA_ADDR          (48UL << 5)
> -#define AMDVI_MAX_PH_ADDR          (40UL << 8)
> -#define AMDVI_MAX_GVA_ADDR         (48UL << 15)
> +#define AMDVI_MAX_GVA_ADDR      (48UL << 5)
> +#define AMDVI_MAX_PH_ADDR       (40UL << 8)
> +#define AMDVI_MAX_VA_ADDR       (48UL << 15)
>  
>  /* Completion Wait data size */
>  #define AMDVI_COMPLETION_DATA_SIZE    8


