Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE74CD637A4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 18:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBIIk-0004YS-Ld; Wed, 13 Nov 2024 13:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1tBIIh-0004Y5-W4
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:41:12 -0500
Received: from mail-co1nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2416::601]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1tBIIf-0004VX-C5
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:41:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvmrfWfocaTG4Wi5BUoetReL+D1t+b+krWVn4N6cffGUbLVWC35gaFYskxDlA/olUoOltCJGQtI41TMvKlK7LCM+rxFKwMgayNMXu77ijaKQLysovOA5cSV3PAdW0r/uxS+e+yTvQhs3aiV4iKnAs49G0/OwTJoik3dkljmVa1Cy/sHHtL9n/++jTCBII1ZTfbMZvr6eOyOklIErfclVsyNXrCMq2nZ6ln7pTZmugloFZVMIyiuFB1Bwv2NWqu+lKsAWU2JOLc94QWSoWiJAsmrfRxAX4BDJnTnThwF+MHeZjvQncEKwqVdwofOwd79guGz82OH+35z/porNWJNExw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXvUJ/Rum+Hf78v3T09ln48Ip68UTcosP9mfxth8akc=;
 b=qeJySGYB4hvv35rPvAvZNjLKEOqFA9mOKrodOIbjtMivkBBzzd+/QFIbOjX5JFQBzlKWuYazZybHeICjgypGfIsjJAmCfnlZ+TePjU379g1CzsycrflPBhJQWGHnDQ/f5AKnxqHeMbbYBL0DN6bCAVJz9rktJdHXJoDasHXyrCtE18L8eOHiHdzzfwurVottsabL/+Jsv/6WCgVTrhan3yMOzj9brZEv+4eHyIgE/eHVIJiFA93e37kULazEUe6NjCTEgPSL4zk2NIS6WRmK7fkup8Bvh8YI+e0gisBGZqS24WRbjTvxfaKW1bSGmxmoovPfmLB6vcj/K1++kfL5kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXvUJ/Rum+Hf78v3T09ln48Ip68UTcosP9mfxth8akc=;
 b=PVFRNN04EigCtFSUwOvxRS9QpwFxCnY3Mtbrr8wsDPim7lYVjS7KhaOFJpzTbrYivHJ4rbZUhRZFTRmYQUZ+FMJcPSqCOgN4RSCDjDnJZiVbUComrEgLyiCsZ1aechXALaR7LL6sdLyYZ1G0YcGZU7e617pK28whSdjDMm9KzO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11)
 by IA0PR12MB8973.namprd12.prod.outlook.com (2603:10b6:208:48e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Wed, 13 Nov
 2024 18:41:01 +0000
Received: from CY5PR12MB6323.namprd12.prod.outlook.com
 ([fe80::2300:2257:1877:4750]) by CY5PR12MB6323.namprd12.prod.outlook.com
 ([fe80::2300:2257:1877:4750%7]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 18:41:01 +0000
Message-ID: <69b6371e-7a1e-a7fb-c2dd-310a2685c5c7@amd.com>
Date: Thu, 14 Nov 2024 00:10:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] i386/kvm: Fix kvm_enable_x2apic link error in non-KVM
 builds
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, mtosatti@redhat.com, suravee.suthikulpanit@amd.com
References: <20241113144923.41225-1-phil@philjordan.eu>
 <b772f6e7-e506-4f87-98d1-5cbe59402b2b@redhat.com>
 <ed2246ca-3ede-918c-d18d-f47cf8758d8c@amd.com>
 <CABgObfYhQDmjh4MJOaqeAv0=cFUR=iaoLeSoGYh9iMnjDKM2aA@mail.gmail.com>
From: "Shukla, Santosh" <santosh.shukla@amd.com>
In-Reply-To: <CABgObfYhQDmjh4MJOaqeAv0=cFUR=iaoLeSoGYh9iMnjDKM2aA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::13) To CY5PR12MB6323.namprd12.prod.outlook.com
 (2603:10b6:930:20::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6323:EE_|IA0PR12MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: 32936e22-98a0-47cd-9d31-08dd0412b8b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzVOczFKVnZjQm9FdWl4NFZ3UGlHM1dWK2JiaEUxcFhjQllPMVo4RCtZYS9I?=
 =?utf-8?B?VTRqWWZmb0JWMC9mL0pPZXMyUURtVzlLeU55cDF6aFlSZG5DOFhWam9MQVkv?=
 =?utf-8?B?T04yc1pyV1ZCU3QxM1JKUzdJV1pFbFRFc2IreldWRk5tUGdDaFl3cjlBK1JM?=
 =?utf-8?B?UnZPWEo1OTdFam9zQnVaSEpkbmhpM3hwdTdEYkpaSER1OUlkL3Bia2VHdFUv?=
 =?utf-8?B?ZUZBNWg2ck1oZ1hsUzBoZkVJUDd6OFJSa08wMENyK2E3a3dGNkxFT1BEbjlx?=
 =?utf-8?B?K2tBK3NkSUxxL0g5cGRmR2tDMjU0MGZFSkk0ajVqMkdVNVB5N0Q1T1ZqKzhs?=
 =?utf-8?B?UXRyY3h6akJMajV2UHFaVmRrM0I5VUR3R2VlMVpLOXZGbE1DQksyUEpwTUx4?=
 =?utf-8?B?dndPMXNlKy93bTM5aDN3WVo0MmgxZFE5aHBEaUhtTm9sNWhpRGxmR3V0RHhF?=
 =?utf-8?B?ZXBNSkM0RjRESVNaTG1qY0pld2RmTjY3Lzc1dkJ6emU5QjZmSFZpUWRUSEpx?=
 =?utf-8?B?bkVvN2NzQlBXSkkwMy9oYkRtMUI5cGk0VGZlNEY0TjBSdm1nSTZHZFBJL1Zm?=
 =?utf-8?B?L0lzQ3FQWWVDUlB1Q2NNOEZzYTVhS3pwR1hMSTNFenFoSkgrMy9zVUhSUTNj?=
 =?utf-8?B?VXdPTW4yd2ZnbVdBRCt0eDlRTWNmcXp4MFlWMUZHVjdldWx1aWE0Tm10dytv?=
 =?utf-8?B?YTd6N09ZSFppUHdEYkxrQm9FL1pyRXZzdkZ0RVJMYmgrY0hTeDZHUmNweGY2?=
 =?utf-8?B?T3RIQmNZblRnVkpVbUlwZFZibGR4OWhOd2NHa0hOKy9ocHlnSW54c3d0Zm5q?=
 =?utf-8?B?ZkVjNU9vWXlwR3I1bENiN2o4bkxpNWE5T1dZSU9rUFpGaFFOUEFoWitmSERN?=
 =?utf-8?B?YnJLZnpldXo3b3NrVnpqdjZTL3MzeTl5RThlamNIcXhDc3pCZ2UzeisrR2Jq?=
 =?utf-8?B?WlpqeTkxa1Z0Z2dueXU2WnMrdTVCS3A3UGxRM2pmTnQxdVlhT3ZERENlTjVj?=
 =?utf-8?B?UVdQN1MwN2NOT29pSDZwSWgybTNzK2M4eTcrUkRnaWg4K3J3QTVwSWFqTklI?=
 =?utf-8?B?QjR2eGJHOXc4ZlQydkJISEhQREd1MmxERW5HeWI1eitlRTRjb2V4Z3BSOGF2?=
 =?utf-8?B?OVVodFhGRUk3TzlISzZIaGVQeGwxYjMyS3ExeXFOTjdvd2hHY3FXRVM3Q1FQ?=
 =?utf-8?B?dW9vYzJKMVlTQ3RtRzZmL2Z1N1g4am9CMG1uSlp4UkdlV0ZPY2pBZXZkL0xM?=
 =?utf-8?B?dFZxNHFseS9UOE5iSEtkRUNaR1hhcytWRDVHQlFSZ3Rza05lQkpHeWpLdkwy?=
 =?utf-8?B?Zm9pOUdVRHNYUmw4Tmc3aVFWeWNDN1lGa3RHWnR4amJCQzB4WmxBc2tDWlRa?=
 =?utf-8?B?VXFzOG55Y1dSQUtzbGFPRXJOWDEvM2orOW9XNHpydHhNbzdvanI1NXhXZ281?=
 =?utf-8?B?L09BSlNSTEhhQ0VlV1B2R0pBcHJYWVIxRU83K2hXUFh1U05RVm8zOWZpN1RY?=
 =?utf-8?B?V2l6QW9iSnhNRlUzWFFLaHczNitvb1dpTlRLUWM1OHBVSERXSDI3ckJDNUhX?=
 =?utf-8?B?NXpoNnVRbVZJcWZXL25yODV2Q0krZ0szcW5XaGNnSFdvZXo4dFBYMGQweDBa?=
 =?utf-8?B?UWo2L3BDdE5zcXlKWmhwUTVRbHo3VlNIdkZONWR1dUhCazVKL1RZc3dFMDMx?=
 =?utf-8?B?QjhadXZhRFNROEwxa21LYURJTDdjRStOUEhBVi9MQ1dxUytVU3ZHdG01VUIx?=
 =?utf-8?Q?UWkYActhmrBUwjcIgfk4Wf/WQAiYi2HYlM5zRH+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6323.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHBQaGt6VkN3aDE5WVNaQ09Ha0c3aWtBWHd3WkFVQmxDa21nRmRqOS9YbjN4?=
 =?utf-8?B?Vjk4TlVadW1zR3YyY3ZjeEVKOHpVY09rb0U2aDRJN2oxU212anNQaWVhZElz?=
 =?utf-8?B?Y3hpcWNITlYyVmJpY2pIUnVrS3hBNXAydkoxUWNCbzJCWXBNL05JYUdBWmdB?=
 =?utf-8?B?ZUprSUkvTGxvOW1VWnFsQnFncXNDRFZpcEtqczBSNmg3OGZsY3h3Um1GL0Ux?=
 =?utf-8?B?R0tnRTl1ck9ISEFCTWwyVlFWR3BlQW5mbk5Ua0FFME9jYXY0M0pFeFBlTS9z?=
 =?utf-8?B?MU9yWWtWZU1ybDZiUHBXUXNtbHltZzhHRDJBYVhQUkVLSFQyZXowbDNNWWll?=
 =?utf-8?B?ODhUbm9vTWE2c250ZGxjWHhuTDBnQWNONGloY3NvR1RpM3h2Y3lveXNpL2Ux?=
 =?utf-8?B?Zzl1d0cxVjZkSmwydmREcnptcnBBY1ZvL2diNzF2Y3ZEYjJwemtzMUl5RHlk?=
 =?utf-8?B?QytlbWdvMkhGcTRzU3lHZnV0cTZVMEkxc3U5T0ZQR0w2U2h3UzJJNEVic0Nm?=
 =?utf-8?B?M2l2Q3kzVFpPaDk4SUNlRDdlRTZXT0krRzJLUDhMZ05nNWRONnlMdmdtdVVz?=
 =?utf-8?B?UStXQU1EQzk0ZzlTSnpneTlFTnVhZTFPRnArN0lra1l0bHZGK2d0SVN4eitC?=
 =?utf-8?B?RkpkYis1Qko4MmYyRmxuR09YT2Qzcmtjd1NROXZSd2JSZGEwOVV3NFZ5YXpo?=
 =?utf-8?B?Yy82WUw4djA0SGNzTU9EU3ByNWh0eWpZMEFtTUZ3VVZWdXMxTkV3VDZ0Vk1r?=
 =?utf-8?B?Z2tMM0ZCbXlzNzFTcHNsaENob0NxMkZ3Ry92b3o0eXE1R3F2UzRvbEJHa1d2?=
 =?utf-8?B?M0dDcmx5eFM1MTVwbkkyWGFYdDhKYjhCdkh5eTQzL0hUZlFRUjUva1RPeksy?=
 =?utf-8?B?RzBRZWh2L3JwZ1lKQkw2cGRlam44VEVoYmhLcWtraE1HalRjZjkxcWtham45?=
 =?utf-8?B?U3ZhNmJVQ1QvRE1USS9mQlBLT2tJVDRYWVJUcWR6bWZhUmM1TCtSdWU1Nk82?=
 =?utf-8?B?SHpObWoyY2w0ampsazBLem81VWtLT2FyU0pYdlNaVzBYWDFOSjNHRHBNM0o1?=
 =?utf-8?B?ZldXMHVEUnFPN2ZIdXcwNGV0cmx6QTM4SGRSbjBVNFF0WEdZc2YzcUE4RW94?=
 =?utf-8?B?My92U210TkxXQUphcnZpdlZIaGlLNDl6MVE2T0Z6UWtXNGJYWGs3US82VVp5?=
 =?utf-8?B?THc0OWZiaHBWQVZSaGVEeGNjcW5Td1AyM3VhZk1HMW8yQ1FLWGpINnVkQVlT?=
 =?utf-8?B?bHdVRzJMTUxoSTVMNnVWa0l2RndSN0Irc3JQOGhuSE9mRXF0amxWSCsxWE9C?=
 =?utf-8?B?elEwNTVVRXlxRVN3YStVTU15NHdBSmJ3YU80aHo4cDVXSU9UY2l4ODZpa25B?=
 =?utf-8?B?ZmJuMVo1NmtxQjVsTUw1azUyRXhtOXNVL1J6MFR6bkZsa2xuaG9HdkpFazNW?=
 =?utf-8?B?ZGhsV216L1pLY3NkV2lHcmdvTkJwcE9QeEZjK0pyRS96aURjRGJ2MW1EcjVQ?=
 =?utf-8?B?KzlCTWRvcytIMGNiazRIc01NeGZqZHVGMGVRMXFNUnFPNERpcGNNd09jREJt?=
 =?utf-8?B?Q2xUeVgvTTBibENZVGdFM21yaGVRc2Z6RHFhckpoVm5QekZOUjdKUWozcXIy?=
 =?utf-8?B?R2wzWEpYSStiTmplWTc3VTdqVTlrZFlRZGJaSWxqS0l2Y0FCazA3VHVSaG5j?=
 =?utf-8?B?N2tVSWlNQktuTjJ1Y3M3OWZ0NE16TUpwMkVhdHNvNGZ4d0R1aEVaS1NLeWhT?=
 =?utf-8?B?c3JuSUxQN3hrbEtaajFuazkxRWxvbmxSNWZJRk9GOGdhTDNDQjMrUzd2cG5Q?=
 =?utf-8?B?WnVzcG14Q3ptejN4Q2thVlNBRXd1a2wyeHFGNXdMdE03NVJCTS9nNndZMnVi?=
 =?utf-8?B?Y3gyc09uZDlnaXRRelB0Q0NNdUNIQW55dkdhdzRJeEpsSWpORDIyQ2xyTktL?=
 =?utf-8?B?TDVsaUhadmFmMkhiRVlQS2c0dkx6UFQvNjVNU1AyUEZsTWh0ZTZPTDBkKzUz?=
 =?utf-8?B?Y0JpRkZjUkhtRDBGdURBZ0NuNUZ3Um1uTTJtNzcrRW5RZW1yeHAzeVhOOElz?=
 =?utf-8?B?cVdLUENZMFZ3RVF1UXduTGx5aVhURzZIK00rV2JxTXhGZ1dMWkpabWpnN3A5?=
 =?utf-8?Q?FckYzAmLeOaIAiqGV83EB6Ofa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32936e22-98a0-47cd-9d31-08dd0412b8b0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6323.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 18:41:01.4735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udsjlman1PBQRsPZja3Njz5uEn3w+N/246DKhy2o6gXELOzOliAUldjz/DTY3vKPO4kbbX4bZdhhEH/Odbrrqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8973
Received-SPF: permerror client-ip=2a01:111:f403:2416::601;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.215, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 11/14/2024 12:09 AM, Paolo Bonzini wrote:
> On Wed, Nov 13, 2024 at 7:25 PM Shukla, Santosh <santosh.shukla@amd.com> wrote:
>> Same proposed at https://lore.kernel.org/qemu-devel/cebca38a-5896-e2a5-8a68-5edad5dc9d8c@amd.com/
>> and I think Phil confirmed that it works.
> 
> Thanks Santosh, can you post it with commit message and everything?
> 

Sure thing, will send by tomorrow.

Regards,
Santosh

> Paolo
> 

