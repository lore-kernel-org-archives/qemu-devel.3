Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79C0EE49BD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOmS-00017L-Mq; Wed, 11 Sep 2024 10:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1soOlC-0004bH-S7
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:56:00 -0400
Received: from mail-mw2nam10on2080.outbound.protection.outlook.com
 ([40.107.94.80] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1soOl8-0007eC-Ee
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:55:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTnV1MrbSMj2gBX4zJ04J+wEJKGUkshG8Jar/8DzdEtgiaAm06Wqd9D0htKGljLVZi6oPwbjOPGY+O75XWVA2e+c0DCUSO/9sacUTUE6CJ5ekw/Km+dN8O7yJoKzhGnJ+IVJ5pynTSb1b3hPDVV08obC1bafuJJwKDUOP67QZasMBJPbmTLlsCTicGrOLUllyxu6taw8rMbYF6pLskmh7IS50avKlSVl4gGcPnH3UHENSb9Ur5yMCQwq02Iuncszgqxk3baDWE1hgaHmRozG9FL54qVL6WOEy0Je6ZpPyClCz7gP7ReZXuG6JGMzI1lgY7q1p34y0Yo2aavNifNMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDK3R2zc9gQXOoJNT6O5pBzoO9LQY/Z9lj9FOEUe+zo=;
 b=xn/EJmvSNMM3FbDUsx7nG8RakkYIGXxmRBREU82gsPBRdZacwtmKMt3xP6KmzCunAL+Es3kXLj7KBZzrfSracXPWRUtpMLGoNb46aH5zI9Ok4msPwAPWxjnCh2hoPC/cuSAaEOh697//XryNkyd27qPLNbWfKvaVCYyPJwtW0NQBz0TJfZ9U1kuQdbo2F0Yh+Y9YWcPEwJJslAUh7S0vnJYllj8ooUxMulz6ajtKR2ubVNQni2/qJfSgK7RvJIafJUWKeF+rqC1LLPxrp0Dt1QL5bSdObcgbLL1G1PcoddKG9TFdktefoU2l3VxiLu1exZJWDKyqPgjpptXrJYI+0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDK3R2zc9gQXOoJNT6O5pBzoO9LQY/Z9lj9FOEUe+zo=;
 b=GK8IAz9FXN2Hic11SDMcw9ZAkgjeUk/rOjjDkHIj1Cx2TuPpa5YzhPGzAXVwKajHijVqeOzyYivPuVytBIhVKcnn+UOssmhcH66XOBbJhxl+r2FfKoBl1+GLI2RCzqq/pfTPYWIj0UnRuPEbLUlHEFzD03gYFfs8ZCUlswxpp5zucVbvg+3G3tWVMfsLR2bBwT8OiOhPZrpPJPS77A7LhBG8ouL2nPQ0iUxoR6CanQxuzeNHi7n46xLveQ4ed2SMK/K9eEpb8ufUCmZsnAzw3WX85t9/MPdu1dQHW/K51AAEF1QhVOrQl6cpkrVDizW7ma+NB9oMzAxotV12Vh8q4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 14:50:47 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.7962.017; Wed, 11 Sep 2024
 14:50:47 +0000
Message-ID: <c09e6ded-1a30-4cef-9e7b-6592263fcb20@nvidia.com>
Date: Wed, 11 Sep 2024 17:50:39 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/17] vfio/migration: Add
 save_{iterate,complete_precopy}_started trace events
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <3c43bf662842e579c0009dfc5135024e45166987.1724701542.git.maciej.szmigiero@oracle.com>
 <8ec6abeb-25ee-417e-9f3f-d0f27ec4f370@nvidia.com>
 <57835a25-10f9-4484-bd20-9e4e90a590e9@maciej.szmigiero.name>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <57835a25-10f9-4484-bd20-9e4e90a590e9@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0333.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::8) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: ab54caf9-7e76-4cd9-05c5-08dcd2711e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWM2ZHNyTExEOFVWemlGNlpkOW9oRkZnNVlKcE9wMlN6b1QrelpMb3dEUGk1?=
 =?utf-8?B?NS9LUXBXWE96dDlBRnc0cU9TaUNnTklMME5xRHI1ZmNzVzF0clVZL0EyTnph?=
 =?utf-8?B?YnpEekNqZXdJTkVQUjZwaW82VjZrbzB3T0oxVlR5d0RxTkFlMjB5VDhnWGcy?=
 =?utf-8?B?ZGVEclp0YkxDSHVlZVJXZys0M2VsYktVbmd2SlRmNDRJWFk2TzZGQmtZaldK?=
 =?utf-8?B?KytXTXpyS0FWSFBwMXY2Q2QrckxveUQrU21GVmkwWm1vVlNLcDMrZ3Z1RHdB?=
 =?utf-8?B?NDBESlRvc1BOL0N3dGk4TVRpRzBucEQwYm44TFErMVFRQVBERFBhQ0pWczB0?=
 =?utf-8?B?cWN5aG9ZUDEwVWU5OE15TjJLbG81WHJCS0FIZFppaXV1SmI4UDZJNlFqNDJx?=
 =?utf-8?B?VEU2Tk9nR2JtRTVMSnBIZXZ0ODZDN0lXUmo4dzFpN0hMK1hhOEttMk9LYTNt?=
 =?utf-8?B?MkpET2tzZllxZGRXY0hSN2xZTFlKZlpmby84RzkxYTVVQ1l1bGRVWkNjeXll?=
 =?utf-8?B?MjRIQnBCSHljWVFSemV6dlMvS2xhbzVEM3NhL1paQ2hVYmpIdUc4cnhuM1cx?=
 =?utf-8?B?MWhJRytDamxyc0REUnM0aktKVTFzSU1iejFzaVFtcmF5L0tNTDJ4RkozY1dj?=
 =?utf-8?B?UStuQWp6alorOW9XeWVRNXdSQmQrQmJPdEthNXFvYUlMNm01NHBMQkIySlJz?=
 =?utf-8?B?MUkwVmVteTE3Sko5LzEvVW5Ncm1YdE9lUHNSWDE3M2ZuRDV1R20vbjMyQUR1?=
 =?utf-8?B?dUd6OHNrZ2RnMkxDY1gwM3JOS3lkQWc4SG5pV08ydllTY1RIb2hnK1p0V0tK?=
 =?utf-8?B?aDBlSkkzSjBnZTNmMm9LMERMemFaT29tNkhBMEh5clQzS200Y1QzUnUxdUNL?=
 =?utf-8?B?LzBNWXZ0aDljK1lEOTJ0ejdnSGZ0VlJaOGUzbmFHdmIxakFlckFtMEVkM2Va?=
 =?utf-8?B?QnFaQlp4MnB1bUV3cFZod0lqc0ZKWnN4T054RmozT2VlallJMWxYZ1dkMThp?=
 =?utf-8?B?VUFqTE1FWVlkaEFTVnJ0bWRYRFlCMmtYeTdvZmpBalBkaTQxNXBzaFdyYmNk?=
 =?utf-8?B?UHVZcGV2VHVWa05Mc2VLZzA4QUVIcUNWUWVhTWhXdHplNW1MOFk5MlNyNkFk?=
 =?utf-8?B?b2liVk5ocVJLRTJzcUNQUHBSY3NaM1JxMzJzaDQ1WDJhaTlXcWRTd2gxZVVs?=
 =?utf-8?B?TStBMU14UzhNaVJwcndKYmZTRy93bEpMelpUNU5EVGUySVlDaldNYmxGUnU5?=
 =?utf-8?B?OXhNYkZQOEhLeE5WVUVKTGlHZGFmYjU5MTRzV09EcjNvbis1dCswTHBlamh5?=
 =?utf-8?B?dnYyVVpudFUxWVJtczVEWjFNVy8yVHE3Nm1qMktRdFh1MVR3L3RRcWpDOGNS?=
 =?utf-8?B?L0VuMlBKbk5mUE9PSWZhOUMzOGJ2QUlncGdKWUZBOXg3L3l5Z0NyRnpVc2Fa?=
 =?utf-8?B?VUJnZ2RMSjlscW9yYzl3SHJCYytyTVBCVE5kQWN3ZmhSUDIrS2hFbkNmUzBZ?=
 =?utf-8?B?Tlo4V1hIQ2FBT0JSUUwvTmxPOGtzMDVGNXNCRkRhNzNjQ1NIb2lzeElpRmFt?=
 =?utf-8?B?WDkyVUszSW9RdytaMG4zWkduRGJiTk9sbi9abTVrak43T2haT3dCd0RhVHZS?=
 =?utf-8?B?QUNTMFBjKzRHRDZYSUpFTkNEcXNpaHdrZ0g3NHhyaU1SM0RYVEZOVFBCc1B3?=
 =?utf-8?B?WklaaXFmUk9EN3pjWk5kZDU2NmpWUzlNUTVTZ0poVXhRRW9NeGhwUDJoOHlr?=
 =?utf-8?B?UW1RcGxZK3FZeE1oZ2s0aEpJUEwxT29SODZhb0NZSXdXTnM2eUVMUFFCUmJa?=
 =?utf-8?B?Y0ZIb2Y0WGN6KzViVmJ5Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckg3dExKaVJzZG5hZWptbGhGOFpQbzFnZGdLUXc0Mk90aFpadHJNOGNhNC90?=
 =?utf-8?B?ZVkvZXZja3VZR0d6TG9pVnZhVkM5NmdIcTFGOXAxa2NVWEoxRUFIVzIxZG1U?=
 =?utf-8?B?NmFBS3lkWHFDd0tybHlneWdabU9qQjlURUNab1AxSWFNQ3dFK3ErYzJqMjJW?=
 =?utf-8?B?eVl2L0NRNmR4QlhjVXRWZDhSQ3NQOHIrNW1wQU42VGNQaVZhK0d0a2J5bDBq?=
 =?utf-8?B?VS9kOU55d29aOTV6Yncwa0grbE1Kc29LWFdYU0xvTU1PaFYrYU9NVVRWRnhG?=
 =?utf-8?B?QU5xN3c2RDlHUFRLSnhGdFNIK2V5eVc3VmtnSytYVzkvTGlBN2NkOEZXclNv?=
 =?utf-8?B?cjhqWnNQZGQzdHZuWE8wSzFGTHBpWjN2MEN2ME51dXJQMnhndnZFUnFxVEFT?=
 =?utf-8?B?S2wyYThheWhublJsbEdWYk9VK0Z6azlUSnNmS0Q3OC82VGJjd2RJazlNR1Qr?=
 =?utf-8?B?b29mdDM3WkJ6NUsyeHBsRTFuT2RzSjFqYWY2aTNqZzJXQmFmYnNJMmtqZm5C?=
 =?utf-8?B?OFB4RzcxYUt3cEo4aE1KN0w3UTVkL0ZOVlZPcG9lU2l4d1ZMOUplRUhaZDJl?=
 =?utf-8?B?YWF6dmJScEVPc2prQ0pGWERFMHZOM0tnaXhwd2VoV0N0NTNGWHFSUDNFYWJm?=
 =?utf-8?B?cEFITXRCM2dla1lTbW5xcHg4bTNGdUFFajRNSmEydGVUVkV2aHA1TEF5djJx?=
 =?utf-8?B?S3lnblloWWJmVG1xeDJ5Mkw2SXZWTThZRjFuSmdYOFU4YWE3aWZ1RGgvOU05?=
 =?utf-8?B?RTRzNWduSWVtMS9wektaR3g2VHcyRUs2VjhrckV4TGhrRFJSWm5uRldFSTEx?=
 =?utf-8?B?dkxyQzlrTXpYSUJnQnZyTEp2TWEwdXdFOGYwM3p6M1R0dXJDZXp6UVNEdjQ1?=
 =?utf-8?B?R0Zkb3ZHUWpUbE9YTjFaVWpiYi9QY1JISVN2SmtvTTR5bzBERE9KNVdwcVNx?=
 =?utf-8?B?Y0UrNXBnR0hjTUNQSDQ1d1R1SUg5di9zM0JJb2NqU3Q4SVMvUTdrbjE5RVVU?=
 =?utf-8?B?UDliZE45eUVyWStCM2VvZFdmTlBSMTBPNGh5ZmNkM3d4NHg0QnVGSVJJRTBR?=
 =?utf-8?B?TVdzaEZEQTB2RmpsNGRmRDFOQWtPTmRWTFo0VVdMNm1BeURlMWdJMUFPTlVq?=
 =?utf-8?B?UVNEOG5wOC93VWpTYkJjMzJocXVXWDU1OGhKeDhzZXJWQi8xRGI4L1RtOS9s?=
 =?utf-8?B?OE9jaUx5d1lrTzE1UWxWS2pBb0cyRm43TlM1aXFSb0hNY1NoNVlabFcyRnpo?=
 =?utf-8?B?VzNVZ0xjTnlDUDhiZW5YZ21tUE1pamZhdG1NUklGbHhoVzZOY3FDSlU5RlhB?=
 =?utf-8?B?emlWUlhvWnVhaEs5clV1YXdUcTZFR2Y1T1lKVUc4YU1QdkFtUmdRa1FSY1Z0?=
 =?utf-8?B?Sm9WU2tTdXJoNTFnUlNUcitzWFYrN1lvbjg0NVVCRjdYSUtYbjEyR0wvWFpC?=
 =?utf-8?B?R2MybXc2QWF6N2hDWXBvZ2FUU1pYNmd4T3BDWjAxSndTNmtKNVRBcUt4czd1?=
 =?utf-8?B?OWp4aW9ITGlRS2ZuMGtrZEFsQThkWHBjWDlIU2swM2Jxa1lmbm5JT1BSTlRy?=
 =?utf-8?B?OU4rY3YrKzEyNVd2eEFTeVZoVUV6QnZVUW9oK0hKVE9sYzBqeXhHNEdVSS91?=
 =?utf-8?B?Y1Y0S3N6eldvV2xodDgxQWxHNTVESittekxXZHNwOSt4TmhqazcrdlRHSk53?=
 =?utf-8?B?c29ORjlScitadTZpSDZSdEhWd3BUcmg1UHZrRXN4eEFtdG1PMlArbDJMc2tN?=
 =?utf-8?B?eHRhVG9CQVVHN04ybU5mTktlaWJZcm15Z1BnUERsMHpWYkRvSzJNN2JSWmpX?=
 =?utf-8?B?a21ubVkwT3VKVzZJWTROcC95eWYyeDJaWjRBdXZkMStERE1zaG4vTlk1NFZ4?=
 =?utf-8?B?Q3RZR2w3ODl4NFZDTWFQdTRmQW9kNUdZMHhLTmFEQy8wOG9mbFh6U1ZCSFp0?=
 =?utf-8?B?QyttKzZrU01PNnpCQlFmRU9DQWNIOFFjcStrMkhCOTRMQXR0cEQ3SlVEeXBS?=
 =?utf-8?B?bGtKbnJOWXlJT2dRdE14V01QaXovYUk1Rk5XM0Y1WXFtakRPSXg4TUNqb2kz?=
 =?utf-8?B?Q1J0VXZmNDVCN0F5MFRMOXZ0cjdROWxQVDRXQ0l0MytqKzJtZzRuZXlaWlpr?=
 =?utf-8?Q?O/lahCmuvr4O9aVIc732b+2JW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab54caf9-7e76-4cd9-05c5-08dcd2711e28
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 14:50:47.1058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rA+p7s7GAD2sokiXC6Df9J6x9i9Qsbf6G01JgmVWdesgluc28EXWKHS/uotwOP9uSb2DkX5IdGOCU+FkE4YUIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862
Received-SPF: softfail client-ip=40.107.94.80; envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


On 09/09/2024 21:04, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> On 5.09.2024 15:08, Avihai Horon wrote:
>> Hi Maciej,
>>
>> On 27/08/2024 20:54, Maciej S. Szmigiero wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> This way both the start and end points of migrating a particular VFIO
>>> device are known.
>>>
>>> Add also a vfio_save_iterate_empty_hit trace event so it is known when
>>> there's no more data to send for that device.
>>
>> Out of curiosity, what are these traces used for?
>
> Just for benchmarking, collecting these data makes it easier to
> reason where possible bottlenecks may be.
>
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   hw/vfio/migration.c           | 13 +++++++++++++
>>>   hw/vfio/trace-events          |  3 +++
>>>   include/hw/vfio/vfio-common.h |  3 +++
>>>   3 files changed, 19 insertions(+)
>>>
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 262d42a46e58..24679d8c5034 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -472,6 +472,9 @@ static int vfio_save_setup(QEMUFile *f, void 
>>> *opaque, Error **errp)
>>>           return -ENOMEM;
>>>       }
>>>
>>> +    migration->save_iterate_run = false;
>>> +    migration->save_iterate_empty_hit = false;
>>> +
>>>       if (vfio_precopy_supported(vbasedev)) {
>>>           switch (migration->device_state) {
>>>           case VFIO_DEVICE_STATE_RUNNING:
>>> @@ -605,9 +608,17 @@ static int vfio_save_iterate(QEMUFile *f, void 
>>> *opaque)
>>>       VFIOMigration *migration = vbasedev->migration;
>>>       ssize_t data_size;
>>>
>>> +    if (!migration->save_iterate_run) {
>>> +        trace_vfio_save_iterate_started(vbasedev->name);
>>> +        migration->save_iterate_run = true;
>>
>> Maybe rename save_iterate_run to save_iterate_started so it's aligned 
>> with trace_vfio_save_iterate_started and 
>> trace_vfio_save_complete_precopy_started?
>
> Will do.
>
>>> +    }
>>> +
>>>       data_size = vfio_save_block(f, migration);
>>>       if (data_size < 0) {
>>>           return data_size;
>>> +    } else if (data_size == 0 && !migration->save_iterate_empty_hit) {
>>> +        trace_vfio_save_iterate_empty_hit(vbasedev->name);
>>> +        migration->save_iterate_empty_hit = true;
>>
>> During precopy we could hit empty multiple times. Any reason why only 
>> the first time should be traced?
>
> This trace point is supposed to indicate whether the device state
> transfer during the time the VM was still running likely has
> exhausted the amount of data that can be transferred during
> that phase.
>
> In other words, the stopped-time device state transfer likely
> only had to transfer the data which the device does not support
> transferring during the live VM phase (with just a small possible
> residual accrued since that trace point was hit).
>
> If that trace point was hit then delaying the switch over point
> further likely wouldn't help the device transfer less data during
> the downtime.

Ah, I see.

Can we achieve the same goal by using trace_vfio_state_pending_exact() 
instead?

Thanks.


