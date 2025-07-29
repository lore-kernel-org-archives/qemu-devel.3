Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A513BC87FCA
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 22:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugsMk-0000de-Qc; Tue, 29 Jul 2025 18:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugqSu-0008PM-9S; Tue, 29 Jul 2025 15:58:39 -0400
Received: from mail-dm6nam10on20614.outbound.protection.outlook.com
 ([2a01:111:f403:2413::614]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugqSr-0007Z3-IK; Tue, 29 Jul 2025 15:58:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULaD6CxUmvwzhn46mdAj1qJkh1yRBMjndicEEBYt7+xDpaC8IBLc2p/uvUxX8LvltO2AeNNadz19cvBkbzp8FcRl2tJpGy8RPafs7HZun3V0xDsizBVQYXdeqwdMYpbMSQRPjB7LEJE5dnx41or3/IWuP9DSW7UFZnPEAB3pg6gVftFNUlgsSZL8TPluOlHKAJ1DpgXiWCsLzamZZQTl1bmvc3PdvjL1RMrh7zxy2ultXaNsoRKLn8SXVhl+oIeubozVc7eTHXmHEvp2liAHPisfCRVilBDLldxwvqzXuV3w+aR+gpL9D+pFN4rUdCan03b9GoZnez7rYuqL2cWvyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+gbIq07kg1IAJO6RDb+tst6NdqTLBCy0SnHtrtizRE=;
 b=WKn9EtXAdH83XMaMSkNL1uCEt5ub+FcSfhBKCdASR8F90SUutoc8o/VDGGDtw8s4xhd4JbBJXO3vioCgRddteg1UvY5QG0v5Sj+kEFUpDvO3atWF7j5wOoDexFhlJyiU7fhIIXQ3UVhhs9pg6ZeKU+R73N5XJUliEQ05Bd6fCowG9KCyfYW9HWfle5NVB0IjxgdVi+wwdPq2RAfYjlTzf2FkE0ENBgLhgDf2u2ePmRzdCb0E0O/figyBVFbd9tYeWCCaZUTBB4w5EJC20hr/cRv6Vo8YNNXbEwFTtSkhfPTVgUaEf9LsmXlTfrCnLOn0iw5IzoxijngRLwIC/4Lz+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+gbIq07kg1IAJO6RDb+tst6NdqTLBCy0SnHtrtizRE=;
 b=ImxM1wEECZwz0Vh97cHysWBJ+fXYsMhpodjgEE67n/u+J093r/DAtCJzH07FrZGedQEXU9sRj/7cynT6VB7UcIaG6P1BWYD6py47Npy1fHV8Qm9mB0U9iK3aD/HEqrApyyYEo7b1VQVjDRQwDRTrvHwpdqq/zXMezMjNDiq7jfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 19:58:16 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 19:58:16 +0000
Date: Tue, 29 Jul 2025 21:58:09 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 18/48] hw/arm/xlnx-versal: cfu: refactor creation
Message-ID: <aIkn0VNw1jV+dimB@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-19-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-19-luc.michel@amd.com>
X-ClientProxiedBy: LO2P265CA0350.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::26) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|SA0PR12MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e401bfd-b551-480b-dcc2-08ddceda41cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVMvYXdNdTdwa2kxTGhIdGJKQU45MFhwZjVUL0QzekJYck9wbmNhRVRhTWFl?=
 =?utf-8?B?dHppb04wLzlsVFdETWVGMUtScTFEUEJ3VTFZY1orMnZpQm1zVTZhakhIeDBO?=
 =?utf-8?B?M1AxaWFOOEQ4RG5BT1h3aXZZS3o5OEZLOW9NUUwySWdDeWxYN051ZjdJM0FX?=
 =?utf-8?B?ODB3UWdPRFJmSmI0SUVnbjR5T2JMTi82VWEzSUlERDVPUk8xMjVnVGlsNUsy?=
 =?utf-8?B?RkR3Z3BQUis1aHI3TzVSa0NlRFZDRlZhT1Ayb29jUDNBTHIwTC92K2RtNzBC?=
 =?utf-8?B?bTBMN0tUd080S0hkZkhIQklWVVNPYTFEb2NxanoyUFU4YVY3WnVZT2ZOSnBH?=
 =?utf-8?B?Q1F5NWtNUlJQcFVaRU50R216RDN4UHdGcXowUG1FZWt3ZGFZSDRLTnBsT0NF?=
 =?utf-8?B?S0pxT1g4RThNVE1tQUdheE84SmxQRlJndmY3ZnJ1cTBoQit5ZVJBYkZlSFZi?=
 =?utf-8?B?U1lPRWxtWDRDcXdDTEY2dnBFOHhIdlVaY0RsT1RQUTVtRENXNU1DNDRDNC9v?=
 =?utf-8?B?aGhSVUJBQ2tkd3VHNUFwWFY5NUVMTFFWeXJpeFRyVjJMYjgrZ1hzTndyYTlJ?=
 =?utf-8?B?S1QyMENXaTRJZ0RYMVdQeFdpZEk0dkNNY1BSZGRLNHdlQmlFMmpDOVM2NDNw?=
 =?utf-8?B?RDJzTDJaS08yK1J5YytXNlh6TGV2bnFuSk5ZSC9TZWQ2b0c2eDFWWUtJYUZl?=
 =?utf-8?B?OXJpWENiL21FdkpMTmRzYzVLdGZYRzJteXhnVXJ0dDdiOE9veWlSMWhXbjlY?=
 =?utf-8?B?VjVNM21yOW8vcFd4WjBQUUhNSTltQ0taTXVzRDZUOWJscU1DM2pOQ0IySHFO?=
 =?utf-8?B?SWJKODJtY1RjWDdLZXZxMjE0K2JlTDhpa2xJTEgzRC9vbnRuYmpZQ0tnUVg5?=
 =?utf-8?B?QXJrdnRMcFhCNWlSMGJjN3h3bHZFcFV2RHl4Yit3UGRGYUk5aHc0UXFFTWFB?=
 =?utf-8?B?R1kvWlRVZms1UklDalNaNUY3M1ViUHQ4elU4RXBMSTNxRGJneWduRXZvbENF?=
 =?utf-8?B?ZTJnak5JS0lqdVF1ZTFXVkQ4SURJdmo5dTdER0l0QlFieGMyU3lDL3BMNFJq?=
 =?utf-8?B?SEZRV2NMVWtaNHI4N1ROaERxUGJmWDJiRENQMUR1MmtGUTRLNzdPSmZqYUk2?=
 =?utf-8?B?M3NkbDJ6RFo4NTBpdWhmOGNlaVR4eEtsd2dVOUZ1M0ExUnFFb3JneWtNbnFZ?=
 =?utf-8?B?WUNlMUtYaHd6N1pCK0JPMTdaUmJITmh1ODdrSUdmOU94cWRlN1JHUGpCL28v?=
 =?utf-8?B?NlhaNk8wT2UyTUhvSXRibkJ2N0xSV0NJdnlsQlRvNVdoa1hlMjQ0ZFNzTU1y?=
 =?utf-8?B?SnM1Z2w3OVJFaVBoUW1Cc2FBazdSY1ducEhaRGgxUTU3Sjh1QXM0N3Z1Um1X?=
 =?utf-8?B?RXNFTFlWc3ZUYUZKdU9nSjBvVHF2RjZsckZKc0M1aWRvQXpueFBWUFZwV1h2?=
 =?utf-8?B?bkVUSVBTWFVEaHNaRzB1aWt6YWJxWDEwdjVqWjJqVkZkZHlkYW82Y3dzVCtG?=
 =?utf-8?B?YmtMTklLL3JGTjJyUHRDc29KWG9HUStKV3RtaCtFQ3pENzNyc2QvUzIvZ01k?=
 =?utf-8?B?cm1JS3dwcFFNT09TKzc2SkhibVRIVUhEQ0VvSWVkTjlPNUFOZktNTnVaS1VM?=
 =?utf-8?B?VklKa1lGVDg2ZlFMVFRGNnBNTmt3MjJKZG4rWEZpMm10azJCTjMxLzNsWFF3?=
 =?utf-8?B?WmNYYnJVUjhhRFpBeFJEdGFmS3drL2lYbXhFQ285SnFtYXZmNjZrVm13TlZh?=
 =?utf-8?B?VjRRbXJQWWUwVjIrTjRwTDFpUkFtMzVmU3ErM0ZnV2h5ZHE2QU5YZnRkTlFQ?=
 =?utf-8?B?L3Y5QWdiYVV0UXBRT1ptMFYzNjd4dml0dWtJNWZka0tQQWIrenMyV2VZekJw?=
 =?utf-8?B?MHB1enZwa3dTS0w2TGcyRzZMLy9RVC9vWDduUmhEQjV1aXpsbGpKenhPcHM1?=
 =?utf-8?Q?ivQ6uGbY7tE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWVNMWt3b2NTWmZJSzZrcVFrdjJuY1didXM3am50SUgzTlJLQlJsbXczVGQz?=
 =?utf-8?B?LzdTSUNjbUl4RFNxVWxjYzh2enZyVXpGaWxFY1ZpK1VQeXFRaDh0aFE4dUFz?=
 =?utf-8?B?SHBGeUNnVHp1N213Mkd1MVdxSXhCN3A5cjRLdDFLSkQyT3RSUzZuck1KenBh?=
 =?utf-8?B?YWRZRFRaNm54TGNPV1NieHZvbm5Ca2lvOWd0bkpXZWtvcEpUU1Vpd2FnYmJy?=
 =?utf-8?B?Z0FTRi80NjY0RjZSUUc0NHNzMVVMZXBFY3NLczZVaS9jZ3FhSUN5ajYvSitz?=
 =?utf-8?B?bmg0Sk9WZXNwOXMyZzJIZDk2Q3FSTExRdWxqaVFHS0JvWmgzcGpvS2dHNVc4?=
 =?utf-8?B?VDdSQXZiL1FGRVZlR3RWdFRHQldVdVFZclR2VHF3Z1ByVVJia3ZmVW1mQjFo?=
 =?utf-8?B?M0tlcTVBend5R0txTkVmSDh6eW9CdWx0QUVjaWJHNFh5cnhENDB6U3k4TGZ0?=
 =?utf-8?B?NWVlZzBxdExEb1Fkb1pIMkNPNUs2UHRiSTIyeEF4YmFjN3pWNzRyUUZ0Qk1n?=
 =?utf-8?B?Q0tlalF0YytubllweUFmZ2cyVE1JbVplbGxzTEc5dll3ZVVHRzZON1BlOGdN?=
 =?utf-8?B?OWxsQWJLdTQ5MmcrZ2JOc1oxaFNWWHl3YjV3c1BmcmpzYjhHR3ZXWGJxQ2tr?=
 =?utf-8?B?NlRGUkRRZ0FVdTZkUTBBMFRaYmRBOTAzNTF2bWYwZElTL2llUlpKejF4QzVK?=
 =?utf-8?B?TnNiTzQ4MjczWjNFQmNZVjdId0ZyUWZTRi9JTVREaWorTVFNajFBNkNQV2dr?=
 =?utf-8?B?emRreUlFaXBFbHkvWHV4cUUzaHV5a1duUnZVcXFmY3dZN0VieUp1ek16SC9r?=
 =?utf-8?B?RnJtTHgyaE5CTXBWejVvUU1sbER3Q2pZOE9rRFhPbWdUd0tha1BQWXA0N1hH?=
 =?utf-8?B?a0ljZUN5NE1pM1hCenllR1lZdkhFeFpwR1JyMFQyWEl3Skhjdk8wMjlPb1E2?=
 =?utf-8?B?TGNBcFNOSlNuQWxmeXBoQW1MWGN0MG40MU5jdWh0VURYSHExbHBVanlDc1Rw?=
 =?utf-8?B?a0ljeVVhelAyaCtWUkVHb1pzc2JHV2d0SENMSGMrMDI4UjNOd1h0NG1IcFhL?=
 =?utf-8?B?eURwUFZ2U0JRR0RWUjJUU0JadTlKYkJmeGVaT2U3K0F2WkJhTTJ4Y2RNUWdj?=
 =?utf-8?B?RUxveUpiWjkxY2JyaTQxQUw4TkJua0ZHUW1HVjN0Qkx2Smd2MlMrQ0NtQXox?=
 =?utf-8?B?QkduSk51UEhpK1FPTXFnYjUxL0lkRWk5RXZEY3c5VER0T3pwcUJjNUdBdE51?=
 =?utf-8?B?K0piTmtpSjN4L0VZd211TmRuaGVMUWJBZ21WNlRvNWVLczMvZ2g2NDNCRENN?=
 =?utf-8?B?czEwMStHaW9Bb2JDNnRqOUFhMFUwNldFUG1xS01YbHkxQ29iTjhab2Y5cVJZ?=
 =?utf-8?B?NmwzOHRSY01xMXhFWWRQMFd5NlRlUmh1ZjRKTmUxcUZFN2RrSnFzWDhBNVFm?=
 =?utf-8?B?TjBJRCtKWHlxTno1NFp0TEVmMWZjQXMzVTJaU3JSaXZtK1dkTHRHS0tDUFhZ?=
 =?utf-8?B?WG1xaUtrUHJKT0hBdWZWRVNDUHU1UjU0Sk9SVTlvVTFYSm1MZ0dyQVN1MGVo?=
 =?utf-8?B?OUhrR2xPKzkyQk8rRW9jMlFlQ0xscExhTmhBYWVrdXc5VjVlekg4YWR1RzZa?=
 =?utf-8?B?OVlRUDlMM29wUXR1Mnd5YnlWNjdpWjF5dDU4S1E4aXBZWkFxSDZEbEt3d1RN?=
 =?utf-8?B?OTlKMGJ5MlNtV29lQjkxWHhDWThnVXp3VVlKN0NFVkxhelUxbWFiM0JsbitY?=
 =?utf-8?B?bElMNGJuSTZXWkJLV0s3bFE0WUQxZWIzYzA4cjI1UjZ3NG9HZ3d3QW5zd0xs?=
 =?utf-8?B?V1p1UkhHYnhlRFdQVk5GOVhOZjJpdURtMk1GNzdxZmVWVlZVOVpWOHBPOGky?=
 =?utf-8?B?NytSUWhDUityRXNEQWZ1RE42Y2RGNFhYOGZMNExGTTYrQzJ6VHhGbHBTRnhh?=
 =?utf-8?B?RlBtSGt0TkFaZ0QvdXp3VncwSXpiNW00dFpzR1RGZisraE9QUWdNa3cra3pq?=
 =?utf-8?B?eWFUNkM4Wm9ZaTA3b0YrT0oyVGRDM0ZWSnVFVkM1b1VsalZCRkJpNG1Jb1NJ?=
 =?utf-8?B?UHZJemd3azN1bkQvWE1XbVVSWFZFUlhveFc5Yyt0T3BRd3FnK2hLU084cE9j?=
 =?utf-8?Q?+xImRNLFvE+bpxFExtFvqhi2V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e401bfd-b551-480b-dcc2-08ddceda41cf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 19:58:16.1642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7oQ4WCnWS15keOeitkfxu3qR4M/g0Fagdb9wzFy2OnUIy0p3IrxRaY+BPA+v9dJA8Th5utD5zFE6W8cnFzrpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366
Received-SPF: permerror client-ip=2a01:111:f403:2413::614;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Jul 16, 2025 at 11:54:00AM +0200, Luc Michel wrote:
> Refactor the CFU device creation using the VersalMap structure. All
> users of the APB IRQ OR gate have now been converted. The OR gate device
> can be dropped.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h |  14 --
>  hw/arm/xlnx-versal.c         | 258 ++++++++++++++++-------------------
>  2 files changed, 115 insertions(+), 157 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index abdbed15689..5a685aea6d4 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -13,17 +13,14 @@
>  #ifndef XLNX_VERSAL_H
>  #define XLNX_VERSAL_H
>  
>  #include "hw/sysbus.h"
>  #include "hw/cpu/cluster.h"
> -#include "hw/or-irq.h"
>  #include "hw/intc/arm_gicv3.h"
>  #include "qom/object.h"
>  #include "hw/misc/xlnx-versal-crl.h"
>  #include "net/can_emu.h"
> -#include "hw/misc/xlnx-versal-cfu.h"
> -#include "hw/misc/xlnx-versal-cframe-reg.h"
>  #include "target/arm/cpu.h"
>  #include "hw/arm/xlnx-versal-version.h"
>  
>  #define TYPE_XLNX_VERSAL_BASE "xlnx-versal-base"
>  OBJECT_DECLARE_TYPE(Versal, VersalClass, XLNX_VERSAL_BASE)
> @@ -76,21 +73,10 @@ struct Versal {
>          } rpu;
>  
>          XlnxVersalCRL crl;
>      } lpd;
>  
> -    /* The Platform Management Controller subsystem.  */
> -    struct {
> -        XlnxVersalCFUAPB cfu_apb;
> -        XlnxVersalCFUFDRO cfu_fdro;
> -        XlnxVersalCFUSFR cfu_sfr;
> -        XlnxVersalCFrameReg cframe[XLNX_VERSAL_NR_CFRAME];
> -        XlnxVersalCFrameBcastReg cframe_bcast;
> -
> -        OrIRQState apb_irq_orgate;
> -    } pmc;
> -
>      struct {
>          uint32_t clk_25mhz;
>          uint32_t clk_125mhz;
>      } phandle;
>  
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 41965531f8d..2128dbbad92 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -37,10 +37,13 @@
>  #include "hw/ssi/xlnx-versal-ospi.h"
>  #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
>  #include "hw/nvram/xlnx-bbram.h"
>  #include "hw/misc/xlnx-versal-trng.h"
>  #include "hw/rtc/xlnx-zynqmp-rtc.h"
> +#include "hw/misc/xlnx-versal-cfu.h"
> +#include "hw/misc/xlnx-versal-cframe-reg.h"
> +#include "hw/or-irq.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
> @@ -128,10 +131,28 @@ typedef struct VersalMap {
>      struct VersalRtcMap {
>          VersalSimplePeriphMap map;
>          int alarm_irq;
>          int second_irq;
>      } rtc;
> +
> +    struct VersalCfuMap {
> +        uint64_t cframe_base;
> +        uint64_t cframe_stride;
> +        uint64_t cfu_fdro;
> +        uint64_t cframe_bcast_reg;
> +        uint64_t cframe_bcast_fdri;
> +        uint64_t cfu_apb;
> +        uint64_t cfu_stream;
> +        uint64_t cfu_stream_2;
> +        uint64_t cfu_sfr;
> +        int cfu_apb_irq;
> +        int cframe_irq;
> +        size_t num_cframe;
> +        struct VersalCfuCframeCfg {
> +            uint32_t blktype_frames[7];
> +        } cframe_cfg[15];
> +    } cfu;
>  } VersalMap;
>  
>  static const VersalMap VERSAL_MAP = {
>      .uart[0] = { 0xff000000, 18 },
>      .uart[1] = { 0xff010000, 19 },
> @@ -176,10 +197,26 @@ static const VersalMap VERSAL_MAP = {
>      .trng = { 0xf1230000, 141 },
>      .rtc = {
>          { 0xf12a0000, OR_IRQ(121, 2) },
>          .alarm_irq = 142, .second_irq = 143
>      },
> +
> +    .cfu = {
> +        .cframe_base = 0xf12d0000, .cframe_stride = 0x1000,
> +        .cframe_bcast_reg = 0xf12ee000, .cframe_bcast_fdri = 0xf12ef000,
> +        .cfu_apb = 0xf12b0000, .cfu_sfr = 0xf12c1000,
> +        .cfu_stream = 0xf12c0000, .cfu_stream_2 = 0xf1f80000,
> +        .cfu_fdro = 0xf12c2000,
> +        .cfu_apb_irq = 120, .cframe_irq = OR_IRQ(121, 3),
> +        .num_cframe = 15,
> +        .cframe_cfg = {
> +            { { 34111, 3528, 12800, 11, 5, 1, 1 } },
> +            { { 38498, 3841, 15361, 13, 7, 3, 1 } },
> +            { { 38498, 3841, 15361, 13, 7, 3, 1 } },
> +            { { 38498, 3841, 15361, 13, 7, 3, 1 } },
> +        },
> +    },
>  };
>  
>  static const VersalMap *VERSION_TO_MAP[] = {
>      [VERSAL_VER_VERSAL] = &VERSAL_MAP,
>  };
> @@ -743,31 +780,10 @@ static void versal_create_sdhci(Versal *s,
>      qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
>                             GIC_FDT_IRQ_TYPE_SPI, map->irq,
>                             GIC_FDT_IRQ_FLAGS_LEVEL_HI);
>  }
>  
> -static void versal_create_pmc_apb_irq_orgate(Versal *s, qemu_irq *pic)
> -{
> -    DeviceState *orgate;
> -
> -    /*
> -     * The VERSAL_PMC_APB_IRQ is an 'or' of the interrupts from the following
> -     * models:
> -     *  - RTC
> -     *  - BBRAM
> -     *  - PMC SLCR
> -     *  - CFRAME regs (input 3 - 17 to the orgate)
> -     */
> -    object_initialize_child(OBJECT(s), "pmc-apb-irq-orgate",
> -                            &s->pmc.apb_irq_orgate, TYPE_OR_IRQ);
> -    orgate = DEVICE(&s->pmc.apb_irq_orgate);
> -    object_property_set_int(OBJECT(orgate),
> -                            "num-lines", VERSAL_NUM_PMC_APB_IRQS, &error_fatal);
> -    qdev_realize(orgate, NULL, &error_fatal);
> -    qdev_connect_gpio_out(orgate, 0, pic[VERSAL_PMC_APB_IRQ]);
> -}
> -
>  static void versal_create_rtc(Versal *s, const struct VersalRtcMap *map)
>  {
>      SysBusDevice *sbd;
>      MemoryRegion *mr;
>      g_autofree char *node;
> @@ -982,158 +998,115 @@ static DeviceState *versal_create_ospi(Versal *s,
>      sysbus_connect_irq(SYS_BUS_DEVICE(dma_dst), 0, qdev_get_gpio_in(orgate, 2));
>  
>      return dev;
>  }
>  
> -static void versal_create_cfu(Versal *s, qemu_irq *pic)
> +static void versal_create_cfu(Versal *s, const struct VersalCfuMap *map)
>  {
>      SysBusDevice *sbd;
> -    DeviceState *dev;
> +    Object *container;
> +    DeviceState *cfu_fdro, *cfu_apb, *cfu_sfr, *cframe_bcast;
> +    DeviceState *cframe_irq_or;
>      int i;
> -    const struct {
> +
> +    container = object_new(TYPE_CONTAINER);
> +    object_property_add_child(OBJECT(s), "cfu", container);
> +    object_unref(container);
> +
> +    /* CFU FDRO */
> +    cfu_fdro = qdev_new(TYPE_XLNX_VERSAL_CFU_FDRO);
> +    object_property_add_child(container, "cfu-fdro", OBJECT(cfu_fdro));
> +    sbd = SYS_BUS_DEVICE(cfu_fdro);
> +
> +    sysbus_realize_and_unref(sbd, &error_fatal);
> +    memory_region_add_subregion(&s->mr_ps, map->cfu_fdro,
> +                                sysbus_mmio_get_region(sbd, 0));
> +
> +    /* cframe bcast */
> +    cframe_bcast = qdev_new(TYPE_XLNX_VERSAL_CFRAME_BCAST_REG);
> +    object_property_add_child(container, "cframe-bcast", OBJECT(cframe_bcast));
> +
> +    /* CFU APB */
> +    cfu_apb = qdev_new(TYPE_XLNX_VERSAL_CFU_APB);
> +    object_property_add_child(container, "cfu-apb", OBJECT(cfu_apb));
> +
> +    /* IRQ or gate for cframes */
> +    cframe_irq_or = qdev_new(TYPE_OR_IRQ);
> +    object_property_add_child(container, "cframe-irq-or-gate",
> +                              OBJECT(cframe_irq_or));
> +    qdev_prop_set_uint16(cframe_irq_or, "num-lines", map->num_cframe);
> +    qdev_realize_and_unref(cframe_irq_or, NULL, &error_abort);
> +    versal_qdev_connect_gpio_out(s, cframe_irq_or, 0, map->cframe_irq);
> +
> +    /* cframe reg */
> +    for (i = 0; i < map->num_cframe; i++) {
>          uint64_t reg_base;
>          uint64_t fdri_base;
> -    } cframe_addr[] = {
> -        { MM_PMC_CFRAME0_REG, MM_PMC_CFRAME0_FDRI },
> -        { MM_PMC_CFRAME1_REG, MM_PMC_CFRAME1_FDRI },
> -        { MM_PMC_CFRAME2_REG, MM_PMC_CFRAME2_FDRI },
> -        { MM_PMC_CFRAME3_REG, MM_PMC_CFRAME3_FDRI },
> -        { MM_PMC_CFRAME4_REG, MM_PMC_CFRAME4_FDRI },
> -        { MM_PMC_CFRAME5_REG, MM_PMC_CFRAME5_FDRI },
> -        { MM_PMC_CFRAME6_REG, MM_PMC_CFRAME6_FDRI },
> -        { MM_PMC_CFRAME7_REG, MM_PMC_CFRAME7_FDRI },
> -        { MM_PMC_CFRAME8_REG, MM_PMC_CFRAME8_FDRI },
> -        { MM_PMC_CFRAME9_REG, MM_PMC_CFRAME9_FDRI },
> -        { MM_PMC_CFRAME10_REG, MM_PMC_CFRAME10_FDRI },
> -        { MM_PMC_CFRAME11_REG, MM_PMC_CFRAME11_FDRI },
> -        { MM_PMC_CFRAME12_REG, MM_PMC_CFRAME12_FDRI },
> -        { MM_PMC_CFRAME13_REG, MM_PMC_CFRAME13_FDRI },
> -        { MM_PMC_CFRAME14_REG, MM_PMC_CFRAME14_FDRI },
> -    };
> -    const struct {
> -        uint32_t blktype0_frames;
> -        uint32_t blktype1_frames;
> -        uint32_t blktype2_frames;
> -        uint32_t blktype3_frames;
> -        uint32_t blktype4_frames;
> -        uint32_t blktype5_frames;
> -        uint32_t blktype6_frames;
> -    } cframe_cfg[] = {
> -        [0] = { 34111, 3528, 12800, 11, 5, 1, 1 },
> -        [1] = { 38498, 3841, 15361, 13, 7, 3, 1 },
> -        [2] = { 38498, 3841, 15361, 13, 7, 3, 1 },
> -        [3] = { 38498, 3841, 15361, 13, 7, 3, 1 },
> -    };
> +        DeviceState *dev;
> +        g_autofree char *prop_name;
> +        size_t j;
>  
> -    /* CFU FDRO */
> -    object_initialize_child(OBJECT(s), "cfu-fdro", &s->pmc.cfu_fdro,
> -                            TYPE_XLNX_VERSAL_CFU_FDRO);
> -    sbd = SYS_BUS_DEVICE(&s->pmc.cfu_fdro);
> +        dev = qdev_new(TYPE_XLNX_VERSAL_CFRAME_REG);
> +        object_property_add_child(container, "cframe[*]", OBJECT(dev));
>  
> -    sysbus_realize(sbd, &error_fatal);
> -    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_FDRO,
> -                                sysbus_mmio_get_region(sbd, 0));
> +        sbd = SYS_BUS_DEVICE(dev);
>  
> -    /* CFRAME REG */
> -    for (i = 0; i < ARRAY_SIZE(s->pmc.cframe); i++) {
> -        g_autofree char *name = g_strdup_printf("cframe%d", i);
> +        for (j = 0; j < ARRAY_SIZE(map->cframe_cfg[i].blktype_frames); j++) {
> +            g_autofree char *blktype_prop_name;
>  
> -        object_initialize_child(OBJECT(s), name, &s->pmc.cframe[i],
> -                                TYPE_XLNX_VERSAL_CFRAME_REG);
> -
> -        sbd = SYS_BUS_DEVICE(&s->pmc.cframe[i]);
> -        dev = DEVICE(&s->pmc.cframe[i]);
> -
> -        if (i < ARRAY_SIZE(cframe_cfg)) {
> -            object_property_set_int(OBJECT(dev), "blktype0-frames",
> -                                    cframe_cfg[i].blktype0_frames,
> -                                    &error_abort);
> -            object_property_set_int(OBJECT(dev), "blktype1-frames",
> -                                    cframe_cfg[i].blktype1_frames,
> -                                    &error_abort);
> -            object_property_set_int(OBJECT(dev), "blktype2-frames",
> -                                    cframe_cfg[i].blktype2_frames,
> -                                    &error_abort);
> -            object_property_set_int(OBJECT(dev), "blktype3-frames",
> -                                    cframe_cfg[i].blktype3_frames,
> -                                    &error_abort);
> -            object_property_set_int(OBJECT(dev), "blktype4-frames",
> -                                    cframe_cfg[i].blktype4_frames,
> -                                    &error_abort);
> -            object_property_set_int(OBJECT(dev), "blktype5-frames",
> -                                    cframe_cfg[i].blktype5_frames,
> -                                    &error_abort);
> -            object_property_set_int(OBJECT(dev), "blktype6-frames",
> -                                    cframe_cfg[i].blktype6_frames,
> +            blktype_prop_name = g_strdup_printf("blktype%zu-frames", j);
> +            object_property_set_int(OBJECT(dev), blktype_prop_name,
> +                                    map->cframe_cfg[i].blktype_frames[j],
>                                      &error_abort);
>          }
> +
>          object_property_set_link(OBJECT(dev), "cfu-fdro",
> -                                 OBJECT(&s->pmc.cfu_fdro), &error_fatal);
> +                                 OBJECT(cfu_fdro), &error_abort);
>  
> -        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
> +        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_abort);
>  
> -        memory_region_add_subregion(&s->mr_ps, cframe_addr[i].reg_base,
> +        reg_base = map->cframe_base + i * map->cframe_stride * 2;
> +        fdri_base = reg_base + map->cframe_stride;
> +        memory_region_add_subregion(&s->mr_ps, reg_base,
>                                      sysbus_mmio_get_region(sbd, 0));
> -        memory_region_add_subregion(&s->mr_ps, cframe_addr[i].fdri_base,
> +        memory_region_add_subregion(&s->mr_ps, fdri_base,
>                                      sysbus_mmio_get_region(sbd, 1));
> -        sysbus_connect_irq(sbd, 0,
> -                           qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate),
> -                                            3 + i));
> -    }
> -
> -    /* CFRAME BCAST */
> -    object_initialize_child(OBJECT(s), "cframe_bcast", &s->pmc.cframe_bcast,
> -                            TYPE_XLNX_VERSAL_CFRAME_BCAST_REG);
> +        sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(cframe_irq_or, i));
>  
> -    sbd = SYS_BUS_DEVICE(&s->pmc.cframe_bcast);
> -    dev = DEVICE(&s->pmc.cframe_bcast);
> -
> -    for (i = 0; i < ARRAY_SIZE(s->pmc.cframe); i++) {
> -        g_autofree char *propname = g_strdup_printf("cframe%d", i);
> -        object_property_set_link(OBJECT(dev), propname,
> -                                 OBJECT(&s->pmc.cframe[i]), &error_fatal);
> +        prop_name = g_strdup_printf("cframe%d", i);
> +        object_property_set_link(OBJECT(cframe_bcast), prop_name,
> +                                 OBJECT(dev), &error_abort);
> +        object_property_set_link(OBJECT(cfu_apb), prop_name,
> +                                 OBJECT(dev), &error_abort);
>      }
>  
> -    sysbus_realize(sbd, &error_fatal);
> -
> -    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFRAME_BCAST_REG,
> +    sbd = SYS_BUS_DEVICE(cframe_bcast);
> +    sysbus_realize_and_unref(sbd, &error_abort);
> +    memory_region_add_subregion(&s->mr_ps, map->cframe_bcast_reg,
>                                  sysbus_mmio_get_region(sbd, 0));
> -    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFRAME_BCAST_FDRI,
> +    memory_region_add_subregion(&s->mr_ps, map->cframe_bcast_fdri,
>                                  sysbus_mmio_get_region(sbd, 1));
>  
> -    /* CFU APB */
> -    object_initialize_child(OBJECT(s), "cfu-apb", &s->pmc.cfu_apb,
> -                            TYPE_XLNX_VERSAL_CFU_APB);
> -    sbd = SYS_BUS_DEVICE(&s->pmc.cfu_apb);
> -    dev = DEVICE(&s->pmc.cfu_apb);
> -
> -    for (i = 0; i < ARRAY_SIZE(s->pmc.cframe); i++) {
> -        g_autofree char *propname = g_strdup_printf("cframe%d", i);
> -        object_property_set_link(OBJECT(dev), propname,
> -                                 OBJECT(&s->pmc.cframe[i]), &error_fatal);
> -    }
> -
> -    sysbus_realize(sbd, &error_fatal);
> -    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_APB,
> +    sbd = SYS_BUS_DEVICE(cfu_apb);
> +    sysbus_realize_and_unref(sbd, &error_fatal);
> +    memory_region_add_subregion(&s->mr_ps, map->cfu_apb,
>                                  sysbus_mmio_get_region(sbd, 0));
> -    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_STREAM,
> +    memory_region_add_subregion(&s->mr_ps, map->cfu_stream,
>                                  sysbus_mmio_get_region(sbd, 1));
> -    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_STREAM_2,
> +    memory_region_add_subregion(&s->mr_ps, map->cfu_stream_2,
>                                  sysbus_mmio_get_region(sbd, 2));
> -    sysbus_connect_irq(sbd, 0, pic[VERSAL_CFU_IRQ_0]);
> +    versal_sysbus_connect_irq(s, sbd, 0, map->cfu_apb_irq);
>  
>      /* CFU SFR */
> -    object_initialize_child(OBJECT(s), "cfu-sfr", &s->pmc.cfu_sfr,
> -                            TYPE_XLNX_VERSAL_CFU_SFR);
> +    cfu_sfr = qdev_new(TYPE_XLNX_VERSAL_CFU_SFR);
> +    object_property_add_child(container, "cfu-sfr", OBJECT(cfu_sfr));
> +    sbd = SYS_BUS_DEVICE(cfu_sfr);
>  
> -    sbd = SYS_BUS_DEVICE(&s->pmc.cfu_sfr);
> -
> -    object_property_set_link(OBJECT(&s->pmc.cfu_sfr),
> -                            "cfu", OBJECT(&s->pmc.cfu_apb), &error_abort);
> -
> -    sysbus_realize(sbd, &error_fatal);
> -    memory_region_add_subregion(&s->mr_ps, MM_PMC_CFU_SFR,
> +    object_property_set_link(OBJECT(cfu_sfr),
> +                            "cfu", OBJECT(cfu_apb), &error_abort);
> +    sysbus_realize_and_unref(sbd, &error_fatal);
> +    memory_region_add_subregion(&s->mr_ps, map->cfu_sfr,
>                                  sysbus_mmio_get_region(sbd, 0));
>  }
>  
>  static void versal_create_crl(Versal *s, qemu_irq *pic)
>  {
> @@ -1353,14 +1326,13 @@ static void versal_realize(DeviceState *dev, Error **errp)
>                                                         "ospi-mux-sel", 0));
>  
>      versal_create_bbram(s, &map->bbram);
>      versal_create_trng(s, &map->trng);
>      versal_create_rtc(s, &map->rtc);
> +    versal_create_cfu(s, &map->cfu);
>  
> -    versal_create_pmc_apb_irq_orgate(s, pic);
>      versal_create_crl(s, pic);
> -    versal_create_cfu(s, pic);
>      versal_map_ddr(s);
>      versal_unimp(s);
>  
>      /* Create the On Chip Memory (OCM).  */
>      memory_region_init_ram(&s->lpd.mr_ocm, OBJECT(s), "ocm",
> -- 
> 2.50.0
> 

