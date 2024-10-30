Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9CCD5CCB4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 14:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t69wQ-0004ow-3b; Wed, 30 Oct 2024 10:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t69wN-0004mi-Cd
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 10:44:56 -0400
Received: from mail-bn8nam12on2052.outbound.protection.outlook.com
 ([40.107.237.52] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t69wK-0005As-MI
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 10:44:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PdpRKax8yucm60tHiklaDA78Kdgkt9ErGu0s01xT9GKk7qtN+abGaxQy/6TWe9AeThV3IuI0vkTp6dWpNTaRzm4Gyb3czz5WJuMQVjVG98l0zH6I3yLNUCON+uBZzZX6WTvPzuNpBOLG7+nSI//aWv8qzGrv/rJYGMJHzmev+kkn7BLo6rp35hkbVviuIAI9K3nvezMy44v5VJn58nfHoBIeD8Q6/xyvLYUOpK9ToVUx65IO0U3S/XmF+PWxjq646MK58kBSSBoIzCKoLQbtkgzMhgjJPPbpwXDl+2djTkUPW+kQZpy2wcKKkRJE55baMvfZ2LF1Rxe+9ukMOhA9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txn3DqWSTcnRPpmFtwHqeSNrVgCTUHXBgMdr1Lm5lgQ=;
 b=mFqCHwoJwzJJp2KHp3LnZC07OKLn/qWWJVSLvryaOhxmT+dyPCJLvEuAtZXLI0BZL1rMoXblnQYDOb0cuw7OHR0UE0eqJ/JXwL8pKiRorei8nxvob9KqaqlGVkuk9SZUejpxc6choqFO+5fJ/bznnZZZJyv5DFNDQ5SDsjskDYvuis1JDgOcQ5komLD5/GYn13CLBwtiKwC7Szfj3hkIFkPMw6VcReLJ67TqH6lnOETNLFGR5PF+SYlduZStOJeCgpr7YjluUgTAqTSA3MMbWX43gLHNPwMA+lypEMaBtGdPPkdVKCefXfzE3HJzggFi3LLNX9CgOp+x/jjafHmhkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txn3DqWSTcnRPpmFtwHqeSNrVgCTUHXBgMdr1Lm5lgQ=;
 b=fy8cpVera7ztdtte+ewPhXDoCbSTGEgvXSMF7tUBjKuY5uUpZODcgw2zR4HMRhG5OphXcf/Vneg9ETOI85kNYTUiqaKIY5WDaAehG1hC7v0P9WSMFPuqvwDZL5nU581MYlDtYkPOppuSokoiJKYsZ7LXBTwVzRByM+AtKd/JKp3JoD7WZgmpy8D1pOAI2X+67Ab2kerpeNSFr/hfS+3bnBq9l/F7NdA1mbR97aUR4Qk2bMCVhNspFNInRLjX4BWnoDFvwBAhvwg1EDRlVGQWuoE2nuXTJz3Go8iw4qliGZoSmCS4Dkh22UcHP7xWI0/PauuHpH5fZ/15qEG2FVFD1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SN7PR12MB8818.namprd12.prod.outlook.com (2603:10b6:806:34b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 14:39:46 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 14:39:45 +0000
Message-ID: <58146556-d3fa-4d8b-a1db-9bdc68168c78@nvidia.com>
Date: Wed, 30 Oct 2024 16:39:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] migration: Unexport migration_is_active()
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20241024213056.1395400-1-peterx@redhat.com>
 <20241024213056.1395400-8-peterx@redhat.com>
 <78729b4b-3747-4408-8146-12d49e70fed1@nvidia.com> <Zx-xpZzYG_1KuCQu@x1n>
 <4c6bb701-dd6d-4cca-be80-156c19f2a088@nvidia.com> <Zx_C0hrRZK34qc7I@x1n>
 <a96a8f31-ef8d-48b5-999c-8ca8a917f3c1@nvidia.com> <Zx_gzdJ549ApAiBp@x1n>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <Zx_gzdJ549ApAiBp@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::19) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SN7PR12MB8818:EE_
X-MS-Office365-Filtering-Correlation-Id: 3772c29b-e535-430f-19d4-08dcf8f0b2d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckY5TWRlQlNzT1BwVjVhWmJ4ckhXWXdoSlhjN0dLbW1QUmhZV0ZsZTI2b0Zy?=
 =?utf-8?B?N0NyclRiV2RaeVVOVmM4bFRrVW1MK01jZlVlb1Z6UTAxMVk3bE9OejRzaytV?=
 =?utf-8?B?RjgwTG5DbHJBL3Z2Y2xDUVN1NjhRK2NuajI5L013ZEdOQkZSUTdPeXIzMDVp?=
 =?utf-8?B?RzM0S0pUZkFPN29od3FLbTZpbUtLUnNVTUVtUTRSVWYyQXh1dHJXZXNFTXVa?=
 =?utf-8?B?WHBGSGQ4endvYm4waTQyK3hESUZ5V1d4aXo3Q21adWpBUVczSlBrdDdiWlhC?=
 =?utf-8?B?dnc1eTlodENLaTJORmdmdEFWRWhTc1g0Y3Fpd3drOEFQME5JMk1CZXR1Qkp1?=
 =?utf-8?B?ajhmSnhOc3FnYkdCRkwrUENxMDkzV2VYV3BLRmY3VWE1c0ZwTkN0SXVwRWlh?=
 =?utf-8?B?eFJmZWw4WjRuWXh5WTVlK1ZYRFRlOFZIRHN0MGhWYlFsZjg0MnRGbXFrZk50?=
 =?utf-8?B?SDg4aUI4THZ5QUVxd3hYdllNM01lc2pwdzczUCt4bVlZcGg4cEU4aGF4QWxC?=
 =?utf-8?B?WmlGQy9lMFpwb1RHS1ZrWlQ2U056cmVRdG42R0I4TnpnaytWZEQxanVrcXlU?=
 =?utf-8?B?V3IvZW15WnJBT2k4TDY4NktDNlM0c3JFV3ZsTTVWTFIxMTVJZS9TSFlUb3JI?=
 =?utf-8?B?T0QvbGMyL0J1SzNrRENEcmI0WW1lVEhMc01VTEp1R1ZJRDRQL0Y3c1JEWTJk?=
 =?utf-8?B?WWpmMklEd3FWdHBqRkNzREwyOG5uek5IczZaOXNudVU4R0t5YmozN0w1cWxM?=
 =?utf-8?B?cGJuMFNvdTlCaERUTlU3dnluUzkreG16YWE1dTNJSlNhQzlxQjRNemN2a3B0?=
 =?utf-8?B?NU5uRHFnSDhRekRtNGIzVEd1RVU5QzMreFVVdFR6N1IvWVJ5bUMzdHFkOFlm?=
 =?utf-8?B?V293ZzRaeVFxa2FUaE53WnB1Z1BKVUVxL280YXJUalp2Tnp3RlAwUHFHN0Jk?=
 =?utf-8?B?VWM1Q05hSG9sSUFNbWVNKzlOcm1WNUpveThNa3RNN3pJaWZoOHFyaXhSVXN3?=
 =?utf-8?B?bml0YzRMRlh2YUNkRUppajJqOHJrYjBIMGM2UFVNRENRRG9EWituZWRFUmN6?=
 =?utf-8?B?QXB2YTM0WGZ1T2hVVjNIK25vdXFYTFVVWnBHcm9aNkMycEY4dmhvVjNzbmJX?=
 =?utf-8?B?TVV5YklKS0xSaFVCME9qR0hQVm82b09lL2xiS20yeVlkMXdNZVNZUElwZHlQ?=
 =?utf-8?B?QXdBR0xhK3BJaUZobTMrTDYyenV5Z0F6NjVZUnNDdE05dG8ydHJBSjJIWkJj?=
 =?utf-8?B?VzNnOFNVeVpPdzFVbDYwTEpLYk1HRmlYUjhuYThZV0plSTUzUU9yRmZzTzhZ?=
 =?utf-8?B?elljaHI2YXg2cUY4SzUwb2YyQkNvLzFEamFkTndrWkdISDZYUVFjOEczVHp1?=
 =?utf-8?B?N0VvcFhXK0VzMUlwa2MvRnhvdkZUWUpPZnVSd3NKbTMwMlVkZmRCMUsrRjZR?=
 =?utf-8?B?UDArTmJlbEZDeVd4UXk3V2VqcGN6U3ZTcE5qRjIyUUtIWWJzQWY1VkhjVmVy?=
 =?utf-8?B?UXEvOFN1Q2kwNmJMTysrTEE1bHlwRnAraW93dHV5ZUVJMjRodVF5YVNzdHE0?=
 =?utf-8?B?cElNSUFuMU84RG1UVEhES2FQcjBpSXpGMGs3VFh4ME1hSWdiMjQxSGJYMjhX?=
 =?utf-8?B?N3l5aWdPMng2WDRKREhKaTU1ZVgvRVNTZk1nZkZ0VDc3bkYvYU9uakhKREsw?=
 =?utf-8?B?dlppcEIwK2FmT2xlN0FHY0tYejcwL0JMYk41amhuR2VXNFBoeGQyYmMxa1dO?=
 =?utf-8?Q?EOWmtT/XdvFYt8yoJqL6CXEGU1IiBtZqWKWHBCE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZllzMHo3NUhheFljb0V2bTk3eUU4enFsenlDUDF3M3RNWlJLcW94YUxLa0o1?=
 =?utf-8?B?alNEZFNSM2dwd3V4Ty9YUWZTV1lvS1VnR3NMRHV0azdUQnF1T0hML3ZWR0ZZ?=
 =?utf-8?B?REg2NTMzaGtiWkJyZWxOZDVtTmQ4ZkpNdVhQa0ZwVDRhUzVMNjFvK2hTcng3?=
 =?utf-8?B?dDkvQmhEWHVMMndLaWNuZDM2NlFtdjg2cXJ3a3RYL05qNU5sdkZZY3FlU0tW?=
 =?utf-8?B?RnJIdTRaNHpLS0RjWEVYM01PRWtpMEZ5Z3ZaRmpLL2FFaFZyd3kwWE5NZ0NK?=
 =?utf-8?B?d1h0ZDA5WVcxSnRkNy9qejdEbUV1YTA4cW9sbkxrb09vMXpDRFhFOXRTazVS?=
 =?utf-8?B?ZmVXQ1F0MDNBd2tMaklZdWV6TmZNSlo4c1ZaUEd5d0pDazMzSVdNWTluZ05X?=
 =?utf-8?B?UGpWb1dVVDByZElQcG15aTNScU95VE5jN2Z3VzBTNGJWQ01YbFVVSWhNWThT?=
 =?utf-8?B?L3R4U0pGZlA0T0k2dWFUNzBtUnFNVlFVZGVzbnptWGxNeGhycGhtbmhUSW5l?=
 =?utf-8?B?UWhCN2FXVy8wcFk5N2R2bG1hL0RtUjNnT1ZBamZTZmlMSU9KeTl5ZGxMRURF?=
 =?utf-8?B?OTk2c1BRcXdUeFU5aWhRY3ZobVByQlBmckIrNGo4eDZUYmdYRjlBYmNsNEZa?=
 =?utf-8?B?VXI4SG5TTFk4dXprQ0NDY2hXSlFUTnE0cVFSZWlmdi85ZTVDMUZDRFlZZ25v?=
 =?utf-8?B?Z1FsQlBJTWFXeklDMlRlUFBOY3lWdVdtTUgzdXhzREJWdEh5MFZzN0dDUTNN?=
 =?utf-8?B?VHNVMlYvajFaVWVkZUtPaUVTbk5tVWxhc28rVnlyV1FkTGZONkhhNGxYRjlu?=
 =?utf-8?B?Rk5oY1g3SXFaakdKR1kwSk9pUWUxdGFWbzJtZUFQcEdLT1hkczFUWGJJWFda?=
 =?utf-8?B?dEhsaExPeng0c1g2M3hWeWp5Ulo3NExicVM3aWl5Wjd3ZzVEQmlseGdaSWxs?=
 =?utf-8?B?M1FST0lKam0xVUorL01FYmRqVWJJV0tCbldvWCtwKzMzMjAwTHRaR1lueW1M?=
 =?utf-8?B?TFY5WDkzQkR1NjhjYlpQRnZJQWFoN0F2bjJ0cmlIaTZ6Y2lhb1p0U3FVMmtp?=
 =?utf-8?B?bDN1VC9iNGs5MUlLZlRTNFdFanVleXltcDJJNmo5SytaclBQeGtFak5BeGdC?=
 =?utf-8?B?VFZXdUlUWWZvZGs3cVNDN2pOMnBZN3NpOHVxQjdZdm1vdWVWcjJ5cTNGY2pT?=
 =?utf-8?B?RUtmeTlBY0RWM3kwU2p5RExDNTZjdmJxTUlkUDVqS0dnbGp3YmQ0TUFrQ1BJ?=
 =?utf-8?B?OWJ2aStMb1B6aHBReXpSTVBqNEt4WXp0U1p5cnFqcCtKcWdtYjA3b2VCZXQw?=
 =?utf-8?B?RVhWS1B6L0dPQm5hVHNTWkFhMXVKekhNT09EOVFJM0dWSDNsbDVUSmpTK1px?=
 =?utf-8?B?MHg3UW1aeFdQNGJZNTl3QWpEbTRjYU02MFBqVnV5UWJHMUxtS0lMYXNpMHVs?=
 =?utf-8?B?dmw2bHVHbmlBTDVteUhGVU5mZTVwQkR0K050dk92MjZDQ01Ea0tIMER2d25P?=
 =?utf-8?B?Y1RRK0lnbFFYT3gxV24zQWdKanZScStoOFpyUTVVU251ZWE0K3NkbEhuZ1ZH?=
 =?utf-8?B?Q1FXRmxSWUhFZzlMNDJ6cDVpQURCODQ5UVdLMHpEb1dGMmpRZkRDeHJNakI3?=
 =?utf-8?B?UzNTanBXdHMrUGREUEdDdnN4ZVRrZzAxVlp2T3p4TURlcFZlY1VRTms1Tngw?=
 =?utf-8?B?T0VmU2VETThNc2pJemQ2QjM2NTJQZTM0WTFNNENzUUlCcjdqK1dqeFUvUTds?=
 =?utf-8?B?b2I1Rk9hRU82UTM4VXI0MmtjYktUbURaS1crcWQzV1ZQckJnUnhMZnN2NmY5?=
 =?utf-8?B?WnRxZTVVRGZDY0VsanYxRjNDSzZyazVJVXEwdTZldEk4b25OanNlTFNMNzhO?=
 =?utf-8?B?TU0yci9xTXFnRmd2OGZURnBBREZ2bllQUUxJa2YyZ2lTdDdFTkZBSldYMEVX?=
 =?utf-8?B?RkZac0NRZThTZVoyZ0F6SjZoeWVqakNiY280RWNldFZKWk90cytTdktiNW03?=
 =?utf-8?B?VVJlRWRYMlFQNy9IUnR3bms3R0duenJoMzZvclVqSkNpNHlSNXUreHloRGFh?=
 =?utf-8?B?TFA5NVZpUjJnaVJNcWhmL0xDOVQxZDZHWFhuTDRNN1VQdVIzdEVWUithOHRk?=
 =?utf-8?Q?q200JJT4ybiGghekpUXywpBMt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3772c29b-e535-430f-19d4-08dcf8f0b2d3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 14:39:45.8643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4kNbGGKajMYmWfRTivWKcHUSV/vcEGWZmFwnx64ao0drAzBuhurHpB0ISzLiQdU605QKbeFuUAvsPYPKOjJfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8818
Received-SPF: softfail client-ip=40.107.237.52;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 28/10/2024 21:06, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, Oct 28, 2024 at 07:20:27PM +0200, Avihai Horon wrote:
>> On 28/10/2024 18:58, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Mon, Oct 28, 2024 at 06:41:42PM +0200, Avihai Horon wrote:
>>>> On 28/10/2024 17:45, Peter Xu wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On Mon, Oct 28, 2024 at 09:43:16AM +0200, Avihai Horon wrote:
>>>>>> On 25/10/2024 0:30, Peter Xu wrote:
>>>>>>> External email: Use caution opening links or attachments
>>>>>>>
>>>>>>>
>>>>>>> We have two outside users of this API, so it's exported.
>>>>>>>
>>>>>>> Is it really necessary?  Does it matter whether it must be
>>>>>>> ACTIVE/POSTCOPY_ACTIVE/DEVICE?  I guess no.
>>>>>> Actually for VFIO it does matter, because we don't want VFIO to do DPT
>>>>>> log_sync in SETUP stage when DPT might not have been started yet.
>>>>>> See commit ff180c6bd7a8 ("vfio/migration: Skip log_sync during migration
>>>>>> SETUP state").
>>>>> This seems to be a known issue for migration in general, rather than VFIO
>>>>> specific.  Hyman has a patch for it, not yet reviewed..
>>>>>
>>>>> https://lore.kernel.org/r/cover.1729648695.git.yong.huang@smartx.com
>>>>>
>>>>> That corresponds to your comment here:
>>>>>
>>>>>        Redundant -- all RAM is marked dirty in migration SETUP state and is
>>>>>        transferred only after migration is set to ACTIVE state, so doing
>>>>>        log_sync during migration SETUP is pointless.
>>>>>
>>>>> So I wonder whether it's only VFIO that should skip it, or log_sync()
>>>>> simply shouldn't be called at all during SETUP, because of its redundancy.
>>>> Not sure why this sync was there in the first place, but if its only purpose
>>>> was to sync dirty pages then yes, I guess it be dropped.
>>>>
>>>>> The other thing you mentioned here:
>>>>>
>>>>>        Can fail -- there is a time window, between setting migration state to
>>>>>        SETUP and starting dirty tracking by RAM save_live_setup handler, during
>>>>>        which dirty tracking is still not started. Any VFIO log_sync call that
>>>>>        is issued during this time window will fail. For example, this error can
>>>>>        be triggered by migrating a VM when a GUI is active, which constantly
>>>>>        calls log_sync.
>>>>>
>>>>> This is VFIO specific.  Why this can fail even if global tracking is
>>>>> started already?
>>>> It can fail if global tracking is *not* started yet.
>>>> As mentioned in the commit message, there is a time window where migration
>>>> is in SETUP state but global tracking is not started yet.
>>> Hmm, I'm totally confused now..
>>>
>>> The only thing that can kickoff the sync during SETUP, AFAICT, is:
>>>
>>>               ret = memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, errp);
>>>               if (!ret) {
>>>                   goto out_unlock;
>>>               }
>>>               migration_bitmap_sync_precopy(false);   <------------- here
>>>
>>> I need to confess this may not be the right place to invoke it in ram.c (I
>>> think we probably should move it out at some point.. into generic migration
>>> code).  However I don't yet see why log_start() is not called first in your
>>> case before log_sync().
>>>
>>> Could you elaborate?
>> Indeed, in the above code log_start is called before log_sync.
>>
>> I was referring to the case where some other code path triggers log_sync.
>> E.g., if you open a VNC to the guest then it constantly calls log_sync to
>> refresh the graphics. In that case, one of these log_syncs can happen
>> between "migration status is set to SETUP" and "global tracking is started".
> I see.  That's unfortunate..
>
> Though this is also the case where it shouldn't be VFIO's problem alone.
> See some other users of log_sync():
>
> vhost_sync_dirty_bitmap():
>      if (!dev->log_enabled || !dev->started) {
>          return 0;
>      }
>
> kvm_slot_get_dirty_log():
>      if (ret == -ENOENT) {
>          /* kernel does not have dirty bitmap in this slot */
>          ret = 0;
>      }
>
> And I didn't further look.
>
> In short, IMHO looks like VFIO still shouldn't be special on differeciating
> and make migration export the SETUP phase just for this..  as VFIO has
> log_start() like all the rest, so VFIO can also know whether tracking is
> enabled at all, then it can silently no-op the log_sync() like all the rest
> of the users.
>
> If you agree, I'd prefer we keep this patch - it'll be nice we only ever
> expose migration_is_running() for migration status checks, without exposing
> SETUP only for this VFIO use case even if it could have followed what other
> modules are doing.

Yes, I agree this could be a nice cleanup.

>
> If you would like to propose a patch for VFIO, I'd be happy to include your
> patch before this patch (just in case this patch could land some day) to
> make sure VFIO works as before.  Since I don't have VFIO HW to test, it'll
> be challenging for me to propose and test such patch otherwise.

I can do that, though it may be a bit involved because VFIO has multiple 
dirty tracking mechanisms (legacy, device DPT and IOMMU DPT). Plus, I 
don't have HW that supports IOMMU DPT at hand for testing.
I assume this is not an urgent cleanup, right?

Thanks.


