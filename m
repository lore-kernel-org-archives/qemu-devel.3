Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8132FCF6BF2
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 07:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdOGg-0008QN-Ou; Wed, 07 Jan 2026 02:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vdOGZ-0008IK-Jc
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:47:41 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vdOGU-0002nq-Rw
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:47:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4ltguUGCWOkpjgmJ2Tgh8GbrP3Ltyj0EI7TMBZ+on7QSU5HH4E05hG8FCyr4GT+zaZeTYE+SeNI8hsPxdjAGpQWws5Xf/7Q7U2I/7nGvIs62sifDilZ2FoPTONFGqG/kCJkWAv9epDsC2U2IwPnpNVzYPMEHCeq9rFCsmQEZ2JkkSnDj9w3gXNz6KK/xYmOj5a6WRT72rMkanVdphdXKTtBcg9hVEpaAbnXM4P4HowDHjHiW0yToja8+3y1GQ2xtCGjCl+c2FZtCTdjTDbFM3zW8OWBnVlb5FuATJZQ1ODLSRrwhNYxm21WYLQWzFn1S8E6Edco1EbhZeiW/0ezFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jwj0G9hxysJppXYGhzMZlCKlArrcCP12s2Qaw/G5nGY=;
 b=kOIn+Tj1SNELbRQ9FUCRzXD1KxFXATHG/S9JxCAaBubMeHPbpGXmsIiNnLJieHBUgCRndzLFzA8O1Oz96NuOw6tfWefrKJa6PzUeq75UUNxjrB/T+yRegZT+It+fr/ruW7NmFEJvq4ToKs8Tdl27MU75soeLLZN+KGQH5DOXK21zh4WwvBj4qS8Vv0Aw+gi6AqIPFgD9o8zql3wtchhzFSzErV55a+xFEOGPyCoBt1cBx6WBOhMv1xbox31/Kcld5GWfdrbG1pVPtURpuUuIO90D/3qVN1SPWuXYkXMejm0hIBrDYrIuEVdY0ES5Zc5qvT+OZU/nKOZvYtmyT0r0hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jwj0G9hxysJppXYGhzMZlCKlArrcCP12s2Qaw/G5nGY=;
 b=tD1CrCU9FbN1OY9jjD2Fb6m4IenXB6CZyESKi7723i2HLlAtKzfnqnScmd7gL5/H4STm8bxvCPPpYNRIw40IALMrNevUDNarCvV+7vN0YrtwIvJwQujf1za5ElTNDB0C0J4rP2PLm7on/2FvVJomiJrUBLiKC1MNfhp8mxOKZdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 07:47:27 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 07:47:27 +0000
Message-ID: <17309bbf-7ca2-4c36-ba8b-380f46adc910@amd.com>
Date: Wed, 7 Jan 2026 15:47:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] virtio-gpu: Add user pointer and ROCm support
 enhancements
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: alex.bennee@linaro.org, dmitry.osipenko@collabora.com, Ray.Huang@amd.com, 
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
References: <20260107071858.3452614-1-honghuan@amd.com>
 <7eec42f0-a622-4383-99e4-c99e51f7439c@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Honglei Huang <honghuan@amd.com>
In-Reply-To: <7eec42f0-a622-4383-99e4-c99e51f7439c@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|LV2PR12MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: b63e11d5-0b11-48b3-bd72-08de4dc100e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXh3OWY0eWY5bWZacEJUUDFjdVRWRVdQdzdvOFc4ZytaU0JkWXozMzBFNjhV?=
 =?utf-8?B?VmFrTS9MaHlEZWZTN1Y2UzdSbEllVE82UFlJZm1SdFRYUytGTUJZMzJWenNz?=
 =?utf-8?B?V3BPR2xYOEhKdG9NVUJRdWpia2cxbWJ3Tmw4T05LWDI2dDN1eWlITGVwaDZh?=
 =?utf-8?B?K2JHQjlwQ05meEtTWi9Vd1NHWUo4UU1QaE02aE1kS3ZyclE2M2R0am13MXFZ?=
 =?utf-8?B?bllxODhvVXJKSXozQURBYUYxRG9KNzJtanhwY00zbWQweERXNnlqUmxQelB0?=
 =?utf-8?B?MFJtNFZBbkU2NXBjaW55QUlEMkEwQ3FiWHVaNDFxeHRsTURTQU1aM1JucUJ2?=
 =?utf-8?B?K1BHL2ptVkU5Z2JYS1ByOWxEY0dweTIwaUJPbXRpeC9qYlM1WkVVUmlpMGJh?=
 =?utf-8?B?ODkvWU1BU0NQdURaMDN5dUpQS0FJM3Y4WTNRVmhuRUtGdGxUWHR2QytscVBp?=
 =?utf-8?B?SGJBdFA4UEMyOVhvRFRzV1pTdFhSQVNHYlZNdXRlTXRkWUttNFI1dmd2TGxF?=
 =?utf-8?B?RUQ1VWNkM3IwakhBdHFXeDRxa1VtRTlhQ2VXUnlibEVpbjdzQnZoM0hoejNN?=
 =?utf-8?B?dVFNQmJJV2RsWnhDWGs1dEtUZFFhK0FwdGt1OVpMNEJUQjdIaTZxODdxNCts?=
 =?utf-8?B?SVNUSUdPeHd5K3VvaXFkV1ZJUzRlZzhBUEVCNGQ2WGxQNE5LTm9UdjU5S0s2?=
 =?utf-8?B?SVBBVUxSZEtVL2hnR1VocVJ0YklLeFhYR2x0a0k3YXM4UXduRDA4bHVTMGpD?=
 =?utf-8?B?a0gzRW5iMVZ2c3VMa3hRbjNiT2VNQ2Z3T1ZzZXpuUDRTSG12ejBHV2lpb05U?=
 =?utf-8?B?TGk2RTlEdHV1V010UEFYRUdNYnRvSUxRRGdKWCtnTHA3elBIQWQrcldlU2hT?=
 =?utf-8?B?UTYxYmRJZmExcHo2dGg4NFpwK3VvNDZYMk9IdUtBVEVianVFc1pKa3QvaUZZ?=
 =?utf-8?B?b0owaGZtcmdVaXpMQVVWVmRCVm5BejdWbzYydVF4SkNaY1ErVlhHQVhTOUMr?=
 =?utf-8?B?QWNwTXRMZDU0K3R1SVp6NktyYi9McXpPMU5DNHRzUFM1cU1IaGVjNGwxc1I0?=
 =?utf-8?B?MkthZkd4TkpRZzFWMUxQTUN3bkFvNVJoYUh5eWZ2Wm1EWUYyRHZTU0cvbGF5?=
 =?utf-8?B?RDk3ak9Hb2J3MFViQ3VzekttQk1wQnNETXBJRjIzVzU3REIzZEQ0T0ZwSWtz?=
 =?utf-8?B?cFZQZ2FsY0I5elBsUUlIcURIQVVuaUZmVzRKdnl0RlhBQ1poYXVtUU4xQytt?=
 =?utf-8?B?d3VueUlrWVdwMGIyNlJzb2oxbGw1dXBxdnFiS29IRitIamRENGFDcVd4bnh1?=
 =?utf-8?B?MldOM3M2c2s1T0xNQllyNUx5WE1JMmJsbktVWE15RFVSZ0pJRzJXNkgxWjBy?=
 =?utf-8?B?Q3hVKzdBQzRDSW5LaGdCMlNiSnpvamJ5K3NKY01kZ2kxT0EyYTZuVitaWGFX?=
 =?utf-8?B?a2ZNQzJDNHhyNlo4OUlMdmd1SFhxNG5XVDNVTVlDL0NOamJ4RFVpa3VGbzRs?=
 =?utf-8?B?djY4aTkyeDBYU0xjZ3czeVYzSXE1bERuZ1ZlSVpyeTkyU09Vb0RobU1ObldP?=
 =?utf-8?B?bnBZR3JyMHpudm02allSUEx6emczREVnNEhrczFON2QyZUU1R0lWMU1qb01i?=
 =?utf-8?B?c21uam9TMEg5TzFKLzZMc05JTExFM0xNeXVreDAxRTZPenlVWFlLVjQwcDEr?=
 =?utf-8?B?bnk2SHdxUVFSRjlmb1pjZExxMTk5TWd6cFNMVXRuZW5zMW9MYS9sK3NyQ2Mz?=
 =?utf-8?B?Z3BQM05YRXZtc2MzUGRWanFrZzYwMEZVeWhlMENsbnlLb2lHY0JicU95YUta?=
 =?utf-8?B?VlcwRGY3SFA5MEdoemVyb2xZV3IwKzJFYWhoaFVkaFUzMzNaWk1yMWo5YVFZ?=
 =?utf-8?B?U0lCNDYvZTZIYU9yck1aZkdqNEVGVHduZDE2d2pQc1lZckswckh3MEM3Wmty?=
 =?utf-8?B?NzlLeEloaFhnSGF4Q2Z3Y09oRnpEY2dmMUtaT3BBTys3QzVOWkY4dDdqRkdh?=
 =?utf-8?B?UFFBQjB5YldBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFJCbFVHZkxxd0VyemF4bmFSd1pLczZKMkVYK0dMM2xIYjk1a0NOdDArNGY2?=
 =?utf-8?B?Y0tBdzB5MzVjU3ptc3BWZXgvZXFnVE90aVhHUlRWUWpkZ0xCTUNjZ3g3UmZi?=
 =?utf-8?B?eUczeWh2RndoU1ZaMW1WTEJJdklVdEI4UEVwa2Z2eENvQzR4UkdDdzltQkx6?=
 =?utf-8?B?T3pKRW1XdTh3TnI3cVExVGlvTUNDckU5WHBidEdtb3VOZVRhZ2hCWEJPamJu?=
 =?utf-8?B?bzV3NE45TVY3U2FFQlRBeDM1elFKSEhYWDdnYlJUZ0dJREpySzdWQXk4VlE5?=
 =?utf-8?B?VVdaUlBtR2FvMkIvUGZPRmJhdjdHRjdGZ1pSaTNuZ0pUZmVicnIwT0xkeGR5?=
 =?utf-8?B?NkJtTFBxWnhRdjAzY1N6SEFXNkozdXp4NHRJbnhYL2VWWHF0MFFEQncxajln?=
 =?utf-8?B?WllyVnU2RzZ5emZPQnB0Yzd0RjBYUjlZUlVETm5JbU5sbHY4Z0dZQkpFZWtO?=
 =?utf-8?B?N0MrUGVpM1RlTmNkRTBVSnR3eFJxU3dXUU5TVjRZWFFIMWdpZ3AvWnUreUF5?=
 =?utf-8?B?OHhrSSt1RmVnVHd3aE15bVRKcDF0aER0VUU3RVV5UnpDaHZ4elc2SWRuSzNF?=
 =?utf-8?B?SEgyNzkreldiMzhCVURmS2Q4RlppcHJiVHBSMkVZQldKUmxWczc5MVIwckhI?=
 =?utf-8?B?cDdhUHdjQTZXQTBIK1FhbDJqTXd2L3Y2SnU4VzlsS0ZMRGpZcEp1QXJYZ254?=
 =?utf-8?B?Y21FMjIrbFp4eWNqQWYvVExIbkt4ODU2K2gxUXlsUEw5ZFVyNzlsanBYd09m?=
 =?utf-8?B?bUFmSlBqKzllZi9rV2pMZ24zWnR1d1hCMG9iUm1hc1RrVGxFbzJwVHRJUTUw?=
 =?utf-8?B?R0FhWHN1ZG5tdlNvOUFxaUZzVU5VUGMxWlZwNTRCRFFrTG5hdXo0MHU0UHV6?=
 =?utf-8?B?UlMrMmRtMGprVThtTlo0WGNmNmlWZmR2ZjZGZVVuQ0xYM1FRVEFxSVBiekpG?=
 =?utf-8?B?R291YlpiVHJWTTArTnQ2d3VkNWFsL29rZ3E5WDJtZkc5aEhxZi9LVFVhai94?=
 =?utf-8?B?MWxUWitWT1c1MDRBdElhVzhaaTk5TURoQVkweEJGRzhWcTBNSUo2YmthVS9o?=
 =?utf-8?B?KzRPK0orNzlkVTNuYkQzRnNUQkVacmJ6UXlJcE5hNVpabnBjeWozN3E4aDRM?=
 =?utf-8?B?OEdHSmVyTGNZRmFVaWZnNmc2N25YeWcwL3FBd2M2My92RjVBWkxxdWxFUGxi?=
 =?utf-8?B?amNJS2RPMWlYZWpkSWJ1Q2ttZjN6eEJYbGU0L3BHMW9xWVkwc0dNWEpXRyt1?=
 =?utf-8?B?L21mQlJHOFpESU41ZnFzeUFNRnZ6MW5MRXhhNFNyUmVmRXNIL0lhVVNjNU5m?=
 =?utf-8?B?VlVmLzFNVVl5VXBwckN2cnRKZ0ZYQ1AzeXdUL3R1cVpsZFpGbDNVeGI5KzMv?=
 =?utf-8?B?dHE0a1ZSbVdiR1Q1SVNOaHZOeElMMlV2aGQ5aXpTVE1kTWZjN2EvQTl0WkN4?=
 =?utf-8?B?ZWV5QXVidHdLZy9veGhvNEgvMnE4UElDcmRxNi9ONy9wUU5BN2o0ZmxYVU1i?=
 =?utf-8?B?OXI0TnhoVXBRWGxTbjdpck9STGVOeUFmM2VZbWFOMEN6TDZZYU9wQjZSVnhR?=
 =?utf-8?B?aTdJSU1uRGFPdyt5NjRGc0ZNcjhKVUtGNXNEemtwaEtWQzMvRnErS09Ha1Vt?=
 =?utf-8?B?MldsME0wVVpOYWZXM2ErYUZhK3ZiV0J6ejUzZEM0Tk1ma25qTWpUWUMrU21y?=
 =?utf-8?B?eXM3bm83RnBkUXJvUURvQTlTVWE1cFFZRHd5d0ZJakkybVFIRXVxYXEwQmd4?=
 =?utf-8?B?cElac0tlSE5MdDlpWEZUMkpOZG0xSDJJSWQ1N2tzYUErZ3A2bVptSVUrU3BI?=
 =?utf-8?B?TE1WckJVa1ZzQ0JUUnNQc2NVL1J1MFhNcE9nM1p0MWtRMHFmWTBFY1Y4QXhU?=
 =?utf-8?B?Um96MVNUQXd4eWVWUjl5TTJXSWUxWk9PME9TVkNWb1ZKQ2krK2x2SUx3bXNZ?=
 =?utf-8?B?VnhrRFR6TG41ak45N2F4cWNXc05aKy96cWtkbDhaNEYvVTlkci9rNjRSNUhT?=
 =?utf-8?B?U2NwOHcvWmh1NzNoRzlUeDdJeFc3czF0ZFlrSkdjSGtwR1dLa2ZreUl6WHNS?=
 =?utf-8?B?Rm1weWUrdHFhOXRwUnA5Wnc2c0IxdlprT1MvL1R2R25SbWUrMS83eFZjcEJp?=
 =?utf-8?B?d1NMQmVpTkhXeWV0OFIvYjVxYnZybDNNVXUxOGFZUi9PN1doSnJENEo1UXNh?=
 =?utf-8?B?WXFpSE80TmZzbDB3bU5BMXZ0cStYTk4zSytCZEJtcGVsVXFuWGoxSDRxZlRy?=
 =?utf-8?B?UXBMRUorWkdBeVlnTDZFcmZ6NnZ5TWJzSjZIbk1UUmZxaU1zM1Z4WkdYOGRs?=
 =?utf-8?B?Q1BRVDBUMms2ZEcwVkF0ZUgybGpxdGFDd3RpTUxrSVRzMTExbjNkQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b63e11d5-0b11-48b3-bd72-08de4dc100e1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 07:47:27.5846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzWdYfsLo3Wg38258Ofa67tnHb07DiUYRdn50Il2Gg8YK7Iq9FicRM3qB3Gtvx+C9M6lAUNSt8CXWzKbEBoCDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=Honglei1.Huang@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2026/1/7 15:36, Akihiko Odaki wrote:
> On 2026/01/07 16:18, Honglei Huang wrote:
>> This patch series introduces enhancements to virtio-gpu to improve
>> memory management and GPU virtualization capabilities for ROCm workloads.
>>
>> The series includes:
>>
>> 1. VIRTIO_GPU_BLOB_FLAG_USE_USERPTR support: Enables user pointer mapping
>>     for blob resources, allowing guest applications to use user-allocated
>>     memory for GPU resources more efficiently.
>>
>> 2. VIRTIO_GPU_F_RESOURCE_USERPTR feature support: Introduces a new 
>> virtio-gpu
>>     feature flag with configurable "userptr=on" device property to enable
>>     user pointer resources for enhanced memory management.
>>
>> 3. ROCm capability support: Adds native support for AMD's ROCm (Radeon 
>> Open
>>     Compute) platform through a new "rocm=on" device property and
>>     VIRTIO_GPU_CAPSET_ROCM capability. This enables GPU compute
>>     workloads using the ROCm stack through virtio-gpu.
>>
>> Changes in v3:
>> - Renamed HSAKMT-related functionality to ROCm for better clarity and
>>    alignment with the ROCm ecosystem terminology
>> - Changed device property from "hsakmt=on" to "rocm=on"
>> - Changed flag from VIRTIO_GPU_FLAG_HSAKMT_ENABLED to
>>    VIRTIO_GPU_FLAG_ROCM_ENABLED
>> - Changed renderer flag from VIRGL_RENDER_USE_HSAKMT to
>>    VIRGL_RENDERER_USE_ROCM
>> - Updated capset handling to use VIRTIO_GPU_CAPSET_ROCM (8) instead of
>>    VIRTIO_GPU_CAPSET_HSAKMT (8)
>> - Removed the error handling fix from patch 1 (virtio-gpu-virgl.c) into
>>    another thread
>>
>> These patches work together to provide more flexible and efficient memory
>> management between guest and host in GPU virtualization scenarios, with
>> enhanced support for AMD ROCm compute workloads. The changes are backward
>> compatible and controlled by new device properties.
>>
>> Usage examples:
>>    -device virtio-gpu-gl,rocm=on,userptr=on
>>
>> The series has been tested with ROCm GPU compute workloads requiring
>> advanced memory management capabilities.
>>
>> TODO:
>> - Unify and simplify the handling path for userptr resources.
>>    This improvement requires coordinated changes across multiple 
>> components
>>    (virglrenderer and virtio-gpu driver), and will be implemented once 
>> the
>>    approach is finalized with other component maintainers.
> 
> Apparently this series still does not explain the utility of
> VIRTIO_GPU_BLOB_FLAG_USE_USERPTR, which I have a doubt about:
> https://lore.kernel.org/qemu-devel/35a8add7-da49-4833-9e69- 
> d213f52c771a@amd.com/
> 
> I suspect this TODO points to that or maybe something else, but either 
> way I think this should have a RFC tag for now. After all, the 
> corresponding change of virglrenderer has not merged and there is no 
> explicit agreement on the QEMU-facing interface yet.
> 
> Regards,
> Akihiko Odaki

Hi Akihiko,

Thank you for the feedback. I agree with your points:

The utility of VIRTIO_GPU_BLOB_FLAG_USE_USERPTR needs better explanation,
you're right that this series should be marked as RFC.
I'll resend this as RFC v4 with.

Thanks for the review!

Regards,
Honglei


