Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A11C19F32
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Mar 2025 13:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toivi-0005Ex-0R; Sun, 02 Mar 2025 08:00:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1toive-0005EA-La
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 08:00:22 -0500
Received: from mail-co1nam11on20622.outbound.protection.outlook.com
 ([2a01:111:f403:2416::622]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1toivc-0002XX-CW
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 08:00:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMJWwj4EaBmmpIp8i7cosyouIRWD2I1QmOhTLNx71R2d4fr0XYiCBDlZFQCdtW2tgrCcjoqVIaOQdJINUFltYHDLkA0p7uQJrAgG9ckedh6X/LcypujjuBGWPri8DN7fW01WzinhIn+iUVd1ELquKOx17D4NSzjUJ9A/foTc89sP04Ovc64JWqQBCGuiDWl6fyuyraqhOE8tjj0KA5j9m+Va5SiA6t1tq0DYbDnYmp7zf0ME5YUnRClWH7/pqrb421+HILY2fVswKLRceUWHPTYjcFXGyX/K088FA9NWKWzBYE+59i0eg4MflCCEp5gXwaCpBTsWu4gH8+KbGvFUMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YP7yPv1f4bmY+9QY6L5y+dar8qttGorpX/GSjQRw49Q=;
 b=XdpW/Rpsc8V4LMaXXa1vVl0qAtgfnpv6KJtcqyd1FrsBD598uG+YJ7pMIYwJCP2IEf1j1ZDCtGoyVfp5I3axskZYfQVRt/G08UzdWxNvMRnwIX/dabPsvEdBNtPqh01FAHxtvxVz13d30EeVZIPqyqSqZbQrjMgid+/J24HNDZekkzw2BPRt0Um+TvtE+lgIksUQ7pUX2kM4KxAnSmCXjf20x2GBC5yUGZTHB2mz6OWZeQGA2hogg5yYmB1UQz5h7qlZ0/I1f7UAHwnXoB7mTmNE+sGS82KFGl/CAN/oyON31C9BXC+Dc8s9KZwd6/hfXIuqlyKYVr1CCUdasTbv6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YP7yPv1f4bmY+9QY6L5y+dar8qttGorpX/GSjQRw49Q=;
 b=oKT3KG4UPURvvjKlARMApP+R6xZqokNsSnaEwMgmI3LzEA/EORlkRH7U7YRYhlZfDeiOhS9bpveHLgzTcHcaYXsTi3+R8u8+r9Yc08WuR8DlhM7AJF9Z7nCKh8qzMjfE9nWvGu36mwQbosrrxkcOytRFLrT+VBNGhN7syD57bql6hIns2KofiMFpbox5ZgRNBFC1t3gM1wKFRZZRoOixSC1X23vfaFWcze+fuKqZVfv4+gBM60MEBcbXfJMv/5UFGpmYGOcsybvGmID1r1T8CTl8lUHYCrq14FU91CFaSBenhJATrLOWAU8G+wSNJiHk6IGj762mjNmeCPJeu+Zc2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SA3PR12MB8763.namprd12.prod.outlook.com (2603:10b6:806:312::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sun, 2 Mar
 2025 13:00:12 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 13:00:12 +0000
Message-ID: <9bc9f288-6db5-4229-9a16-7e8842604c55@nvidia.com>
Date: Sun, 2 Mar 2025 15:00:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/36] vfio/migration: Multifd device state transfer
 support - VFIOStateBuffer(s)
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <96303daed289e9c7a3261590027d18e425ea07c2.1739994627.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <96303daed289e9c7a3261590027d18e425ea07c2.1739994627.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::7) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SA3PR12MB8763:EE_
X-MS-Office365-Filtering-Correlation-Id: 913b3d96-15a1-470b-7fa3-08dd598a2b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjVmUWtyWkxXM2dPSjBITmxHem8zQ2VpQTRNR2ZRYlFxT29kbzd2NU1NNVNv?=
 =?utf-8?B?M040SmVoYm53a0J2Tm9LRUllR0dZeFp6UjZGa2orVGJzVDZjbEJGK25mZWtS?=
 =?utf-8?B?TGR0dzZaWDRCZ2pQRVU4clRtYjBScHNVVnowNnpTQ1RtTlk3U0QxQTRUNkVH?=
 =?utf-8?B?czA0OU5nZDFMWWFyYy9WcWczTHNTZFBlSHdUajYyT0dCNXhGbTBqK0FmZSs0?=
 =?utf-8?B?amp3Z25yaVBHVFVaeFRCWjAyUllaS21yL25hNmpQSkJtZklWOEJSa2R6UGNk?=
 =?utf-8?B?cFdzcWowWmUxVStnL0FSZWxIN1VWVlIvYWl6QTZPVDFMenVZNzhDVDdEcUNp?=
 =?utf-8?B?UUJjMVVrem9ZTndsdURFQnpDVVVKd2NEcm5BcldYUS9DYnJoN2lEbHhPaDI4?=
 =?utf-8?B?cktnK0dBbWZib0pDVVlBWk1jL1YxZlU1TUNEdldhUXdjdVVPZ2JzckFrUnpX?=
 =?utf-8?B?YU9UcDh3S09MWXYwSU0rWEtqeWxaTFFkck15Vml1bGxrNlU4VkdQVzhPR3Ew?=
 =?utf-8?B?TjNOTmtuR1ZEUWVBMHZCbnpWSU1KTjB0dmRLTkhDbG0xS2p6REI3am5Ia3lQ?=
 =?utf-8?B?MUljWEwwbVNwK29qUUM1TlJxZW42SFVDL2QvUFVHK1h5d0dUVEJyYmt3ZEVt?=
 =?utf-8?B?RlIzbktTaUNTVW9LSUtZQlN5NXhmR1d4VFVBSlFiZXIzZW1LS0FNMFNiVkU5?=
 =?utf-8?B?a0dxaFRtWVAxcGNxN09SZmdEU0dydlJ6WGZobUVydEthNHM5OXozeTZhM1pj?=
 =?utf-8?B?NmZyZTdQK2VYN2p5N25vQ2NpNkZXaXZ4eWh0dXJLdWdJN3RQSU4wa1E1K3V2?=
 =?utf-8?B?bE5sWEt2ZEM2SjVWZ3lFR2p6TUZnR1JkRzhkR04wNHV6NFRwMFVMVzM1cDhT?=
 =?utf-8?B?Smwrby8vRlI4cDkrR1ZQdlM0NjQ4TW1MVUpBaHNpVEsvQm4waDA1a3h6dCtB?=
 =?utf-8?B?N3gvWHJrYjZHWGs2dUNicllTQ3A1V3krYkxWS3d3UVhOY2NqRGRPdlFzeUNt?=
 =?utf-8?B?dGU4cDdBTGVTaHJubytNQ1UycGw2QjdTeTZzWjZheTU4WHc0MURXQlRKTllr?=
 =?utf-8?B?dkdpN2F1VEZac0FJNGxYM1JBcFF2RCs2Wmk3eHFqZWFtWXphOHNyYXJJK3F0?=
 =?utf-8?B?MHBncCtiNnVjRFR5L1lZdGxlZDliZ3ZnSVpISW5WZDBNZ1JtMEdINzRQSHMw?=
 =?utf-8?B?WS9MeFdySExkL3JFVE5RL0k2YWJSNWZieTYwQTJJK3VBYWhlZTZ3S1RKdCtt?=
 =?utf-8?B?UDA1Q1RnUEtYenRpckozY3JCS0FBT3N5U0hKbUV2MWpVbVJRWWp4Z2JQOWx6?=
 =?utf-8?B?YUh2MHFiYkN5aFd2UjI3cUljMDhMaGl1M2o0Y3dOMGxJRDBEZDRta25DbWhv?=
 =?utf-8?B?UG80YkVWMzdtaXRVT1U3RVp2VmNFR1h6R0g0WWhGdHFSYm5SeURzU01xc3F3?=
 =?utf-8?B?cG90M3c3N0VUUnUzY2hhSTVLbmdWdmxzSkdwc3drVndtS0dReXVWcWNHUGlm?=
 =?utf-8?B?OG5xWDNJUFZ2TUZyNUJZK2lnWi9rbW96QnpIZmIwM2t4OVhwcWVicFZQWE1q?=
 =?utf-8?B?WjJNZ1pxSC9kaGdPeEFUSGFxVnI1ZS9LNVB2R3VVTXZaMFFYNFphNkVtSmJQ?=
 =?utf-8?B?bUhhcmVYQjVPQ29yMGhaemt1ZzZ5OElpdVdvTUdMNEhlQllpS1FHNzZvUXNw?=
 =?utf-8?B?NVNzbi9wM2xJdUpqelFTZVBMRW5CdVRBM2s3ZDU3aFpFdEtXd3lFS0dLWnV5?=
 =?utf-8?B?UWlrSStTTk9rU2IxNFZpOEpuZFNMQ1lNRERDS3QwaGNPbEp3MHpUVnZ5UHFs?=
 =?utf-8?B?a0kvT20zNHRiUnZ4TUpSTWErdVlCMnZCUEFKWDloejZMVHJhVWFqRExDVTJE?=
 =?utf-8?Q?sJxiwm/ZB0k7o?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3hsM2xQUm01c1BwbjhqaXZ5MXFnelpJbEUvYTVHUHRFVFRmSjduL2RwL0Vx?=
 =?utf-8?B?ekpEVko1MG1CTnUxdnJmbklkTytqMVYzWERwd1Q1UHJ5M2hwUi9KYjJ6Skxm?=
 =?utf-8?B?bHFvQ0FYQkVqeldWVEdYWitPOUZnekJ4R3E1R254dEozSTdYVjZxSk1HT0ZG?=
 =?utf-8?B?bVI4b0FadWx2MXlCOG1hRGdiZ3BRZzAzRkFCRm1qRUxOQnJmRUR6K1UyczZP?=
 =?utf-8?B?Uk93RHlkTjRHVmlyTURTQUprV2ltM0N4QVEwdy9JMWNGMlZVNCtDVTZwOXZk?=
 =?utf-8?B?Z2xxL3ZESnpUaWN1SGNjR0RMOEFlQ1JJcGNjMFlrNEVGbFY0Q0hFM2t3UE80?=
 =?utf-8?B?d3VKait6MFN1ekl2bHE5Zm1rMEt1TUF0ZWVtQWJ3b2plN211cHZWSVNjTG45?=
 =?utf-8?B?L1g1a2JDSTVjano5cjZseWtCUlFLc0tzTGtJQnozSTAzdEVlT0dJeUMzN1Mv?=
 =?utf-8?B?aGpmNzFtTFVJLzVsRmh5UmhRSDUzMU5VbjRpY1dMVk9idFJQUHpIWlJCVmFG?=
 =?utf-8?B?OWxsUEp5dHJNT3paNHZrSWNaYmpqQzRVUzZrUVp4bmF6emY5dG04R1Q2VUNW?=
 =?utf-8?B?Rkk0dnFGMGR4YkJwL1F6SC9jODlmR0Rnclk0VUpaekZZVndTRzYrQUh2VnM4?=
 =?utf-8?B?RFlBZUREZU1ubUhpYkY1UVpjL0EvSjBkSkJzYlJOaE4wdVUyUzk4U3lVSVhl?=
 =?utf-8?B?czZFRElwb1AyTE9NZG5mWFdtNnlRT3pMdm5zTGRFT1hMQWZGWjRONXNodG1G?=
 =?utf-8?B?NVo4QWlQZTNvN3ZaRUZ2R3JsWllhM1dsS1ZFQXJ2TVZaNXZXR2JpVU1EZVpX?=
 =?utf-8?B?YnU3YWludWc5NWxINFBVSGJXd1NManVubDVwL2F4bGJKQlVob05DWldsS3VS?=
 =?utf-8?B?QTB2dG4wTXgvVUQ0VHdiVjl3emt6bEZmUmZVWldyUm1CV3ZTWHVVK3ovU2ta?=
 =?utf-8?B?TUx5bXY0RmtmQnkweS9wU1JtTTVwSFMxRWpjdDBsdFE1VDlUaE9EZ01PWUdk?=
 =?utf-8?B?Q2dOK25iVytJck5ZR1IzaXdWeUtuNG5KVVRxVldTOTJuRmNGOTFTNnVRU3hV?=
 =?utf-8?B?Y2lFQThOaFZrV1hsYWRXbFJ4LzJDUC9PZlFsVkZXeStvMXEyOEZpaXJOS3Ar?=
 =?utf-8?B?KzdnVHdKRXJHb05zOHR3bDYxcnhsRXU1bjNqTHBIbXRHMGMwYkdOUHp5UW9X?=
 =?utf-8?B?S204c3BQRmcrbThlWHFRZDc3TFhpVlk4b3RJOW5vci9XQjFLbSt2cjNaS3hP?=
 =?utf-8?B?ZXA3ZDNERUpvcG1mazRkbm0vRHB5YXdQdWlWK3JEL2lFUUdYOXJNYVFaZGtu?=
 =?utf-8?B?SU5UQjJNZ21VckpNOXFNekJUVlBtSVh2TUpCZmk2RDN2bktwMzRZRnFqNjFL?=
 =?utf-8?B?eXM4MjBHWHFrTlRoR0M1bUpyQWRjbGV3eDV0V2JWcEE4enF0LzFSMU9Vclcy?=
 =?utf-8?B?MkNLMmZ2cDZocXNLdGpySlVqcHVtWlgyV1phMmh0MUpraUJ1dkUyVHEwMFNw?=
 =?utf-8?B?Q2R4S0ZOSHN2TDFSRmkrQit0VEptVEE1czdpY0I3RysxZmdKMHE1ajl4N25s?=
 =?utf-8?B?eStEZW5PZzZsVnRaZkFDSWRpcHB5b1E2YzdsQnZaYTFzMkQ1di9nT05iRVRl?=
 =?utf-8?B?SEE0RHp4S25zbVdxb1Fldk4wYjdEbFR0YW5QRGhkSGgzNXg1cy9UdHdlQlFq?=
 =?utf-8?B?dVZZalJKY1B5WjUrT1N6a21MRUlhZ3lSR01jaFh0K1RjTXFYMmJLKzVaYTc0?=
 =?utf-8?B?Q2x5VTlDVTBzVDJRTk8yd3hFMkNOUmQrRWtnckVtdllGRE1QQUlNRUxWUHZY?=
 =?utf-8?B?cC9lK2xmaXM2b0I2MnNXWkhoSEpUOVJ2dkhZazlNYTRTSnV1ajRwcWhPTFZG?=
 =?utf-8?B?aGQ3Qy9BanhIZU43VHFJOGpxOUFDWGxWQnE5TXJDS1JRemdYWVBmZ21oaHc0?=
 =?utf-8?B?N081NmlRTm55Q0dOa1F3VEhzdUtrK0JMc0d0cG5ZcXVwVkhVL0liVkxWZURj?=
 =?utf-8?B?NThXVnNBQys2U0VyL0VIN2lySXpwSElFb285em9qN1NvVXJIdVdCMTZqSnlo?=
 =?utf-8?B?TmRBQStlbkRRcVdlNFVwQldpS1JJaTdXVzF0Z3ZiWnN5aHRKSHRRUUNtSjln?=
 =?utf-8?Q?dgtY0CdQ+3K77I5PlvurvBwR6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913b3d96-15a1-470b-7fa3-08dd598a2b1f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 13:00:12.2509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELqPDqKW7fICDXzIcMl4hMtkdyRzZ9wPL4AC6dsRtVE9JvfSRrlIVTDdSJtJj+n80qi22WVfXbKw/6bAu/tBEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8763
Received-SPF: softfail client-ip=2a01:111:f403:2416::622;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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


On 19/02/2025 22:34, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> Add VFIOStateBuffer(s) types and the associated methods.
>
> These store received device state buffers and config state waiting to get
> loaded into the device.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration-multifd.c | 54 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
>
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index 0c3185a26242..760b110a39b9 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -29,3 +29,57 @@ typedef struct VFIODeviceStatePacket {
>       uint32_t flags;
>       uint8_t data[0];
>   } QEMU_PACKED VFIODeviceStatePacket;
> +
> +/* type safety */
> +typedef struct VFIOStateBuffers {
> +    GArray *array;
> +} VFIOStateBuffers;
> +
> +typedef struct VFIOStateBuffer {
> +    bool is_present;
> +    char *data;
> +    size_t len;
> +} VFIOStateBuffer;
> +
> +static void vfio_state_buffer_clear(gpointer data)
> +{
> +    VFIOStateBuffer *lb = data;
> +
> +    if (!lb->is_present) {
> +        return;
> +    }
> +
> +    g_clear_pointer(&lb->data, g_free);
> +    lb->is_present = false;
> +}
> +
> +static void vfio_state_buffers_init(VFIOStateBuffers *bufs)
> +{
> +    bufs->array = g_array_new(FALSE, TRUE, sizeof(VFIOStateBuffer));
> +    g_array_set_clear_func(bufs->array, vfio_state_buffer_clear);
> +}
> +
> +static void vfio_state_buffers_destroy(VFIOStateBuffers *bufs)
> +{
> +    g_clear_pointer(&bufs->array, g_array_unref);
> +}
> +
> +static void vfio_state_buffers_assert_init(VFIOStateBuffers *bufs)
> +{
> +    assert(bufs->array);
> +}
> +
> +static guint vfio_state_buffers_size_get(VFIOStateBuffers *bufs)
> +{
> +    return bufs->array->len;
> +}
> +
> +static void vfio_state_buffers_size_set(VFIOStateBuffers *bufs, guint size)
> +{
> +    g_array_set_size(bufs->array, size);
> +}
> +
> +static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers *bufs, guint idx)
> +{
> +    return &g_array_index(bufs->array, VFIOStateBuffer, idx);
> +}

This patch breaks compilation as non of the functions are used, e.g.: 
error: ‘vfio_state_buffers_init’ defined but not used I can think of 
three options to solve it: 1. Move these functions to their own file and 
export them, e.g., hw/vfio/state-buffer.{c,h}. But this seems like an 
overkill for such a small API. 2. Add __attribute__((unused)) tags and 
remove them in patch #26 where the functions are actually used. A bit 
ugly. 3. Squash this patch into patch #26. I prefer option 3 as this is 
a small API closely related to patch #26 (and patch #26 will still 
remain rather small).

Thanks.


