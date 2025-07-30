Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951DCC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 15:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh8va-0008Ut-4M; Wed, 30 Jul 2025 11:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uh7ot-0005QW-3U; Wed, 30 Jul 2025 10:30:17 -0400
Received: from mail-dm6nam10on2061e.outbound.protection.outlook.com
 ([2a01:111:f403:2413::61e]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uh7oo-00020G-G6; Wed, 30 Jul 2025 10:30:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Io4OCMsQNk9eJZtBoaG6xUw/Q9EJmZJW7qsb6NhfTKAHx/UJgE9CCflnoGXPyyhWXEHzZS9oUgs4vzLN6F8jQKTo0CHCWsLhRk0iOP+PyvhfcyqIYIJhrFU6Yi9gOp8oS66oKInPP5LGYRB3k2ml6u6V97QucqeLPoxk7+n9o9R8T8drJvonFDa4imXajrP57zbdkaao+f4nmBuwB4R1lVFIhOepC2E1/4mCoIXugnXm2Hx5Mb/WztiRJlIgKflBLUCRhLTyLrfGHRXgZ0oBxVDgs7sotSNabynRfcTs56936gx0jrRVI8ved21F9+OX/BuizsE6BxH8T0b7IZJB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4chui31reJCHTC35H0XNLD1ie9nkp9pFLrHmZqIdws=;
 b=ZMynCqLetKbd3+n2QZzJobMlBnl0dIIoQmJKwAKIYeQ8MBS6gKF9GbbI4WOUrU88KbROuYmSHeSoOixU4DBJL1zSq+hlYrcYOcSFS0SPOdiLONNfn3tyTKfeNEFcAlIZhT/flXBS86q/wnBOP8kanAjZCGFC5V735YRaTGx4rP9aXN3rNjEbOClIe+D4pgsYxe4Zhep+mynKCG3xM6EfZBlW0TYtTAIGLZbx/atgCYZGDUoQ6A7vF/4ZX0pViaT1Fiy3mf+VStSYW8Eo9h4t4wTb9CUppN99gfnZExNZ9DfXV0YebWJoESCOTEWzoioCBZ+a6NkfyYVsKjTodSeoLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4chui31reJCHTC35H0XNLD1ie9nkp9pFLrHmZqIdws=;
 b=HikCiSOB9NcxC+KTRne+2pl9pMhNYFhW2Pfiz7jQs9XuQWjKWOnEjkxDegFKMti5rQhaEtILv8IfP8eUZQgZ7+dkpTc9F+xk9C4F9paYUyVSj8X8s6jlTGw9o9TIeI4KcRUJDkLqTzgx2mvbXuhVerb8G3vcSA0Hcv8Xkq8KW6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 14:30:02 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 14:30:02 +0000
Date: Wed, 30 Jul 2025 16:29:56 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 26/48] hw/arm/xlnx-versal: add support for GICv2
Message-ID: <aIosZMhYLYVXlekp@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-27-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-27-luc.michel@amd.com>
X-ClientProxiedBy: PR0P264CA0077.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::17) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6e0539-acad-48da-31f3-08ddcf7591d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0FjQXdRTXBOOGJLSEpxWmlwcG9IMVc4WEJxd0NYVG9tZDk1dFR1MFJKNlVW?=
 =?utf-8?B?bFFHNHM1SFAzZHBSOG5tUzRUWDhhSnhoZHVRMm1wcVFPSTg5L0NNM3dxUHRP?=
 =?utf-8?B?MlVZRmNHWVFuOFdkUE8xWHdibnRTMDF1enlOWnhEeHFnUFJKaytycUwxSGwv?=
 =?utf-8?B?T09UZTlvZDVYeW5sMFp3QXU2NXI3UnNwbkozOVY2aDRURnY4d0UvL0tabnh2?=
 =?utf-8?B?dTZudEpheFNCNjF5NXZrSmdhS2xDM3NCb3NlQy9Hci84T3JKdG1aSDFNNmpv?=
 =?utf-8?B?SVZzalpKNEhKWXJiNXdPTG5xeDZteFZOSDJWOWlmOHEwQ2RIdit2M21pdjEx?=
 =?utf-8?B?S3RMZ0lscmFGYTlXSjhJQlAySWhaenBndnk5ZHl3K1Q5SElKcklnZ3VpaWM1?=
 =?utf-8?B?R3NrRkhyQjQwTlZVcHFPWDljaEdBcHg3Y0gwVnduOGdpSDRscmpQTktIT3Qr?=
 =?utf-8?B?VGNLRDRUS21LUG02TzI3Tk5nZzJzSDBselk1ZnBnRm85U0VSN2RWbDBabm1Q?=
 =?utf-8?B?SU5BSFdSVUd1RFZKK3lScWFJYnFrU2tKT1Z0Njk2K3JUQm51RzVWakx3ZWRa?=
 =?utf-8?B?SWJqTGZLUGhuTG84aitMTUl4dzRQbGp0UFZkRkprODhEQTB1ZjA2Wk9uUmhH?=
 =?utf-8?B?eU4ySW9YTEsvU3h4eWtPeU1abzZwWTUwbU1ET3FRVE44NUdJcXBiVTY3OHpu?=
 =?utf-8?B?TU50eGcvblFVbXI1ZnFzdVExTFpObE41KzkzaDZRamxaaFZiS0kxSUVTZmpk?=
 =?utf-8?B?ZjZqODRMR1JVMzVTMjllV0RTWTNSNXlCSm5nTG0yemtmdnlzei9rTktoNlpq?=
 =?utf-8?B?cThPNk43NzJoRE9ScEpnanc2SXFKNkZyZG5ZOG9YK29jV1FrZ1k2WDNjWG9y?=
 =?utf-8?B?RE94VFZXZUhjUC9hdTFaUnZ3YlE3NERkdXFyMWduUFFTNS83aDMvQlg0N3J0?=
 =?utf-8?B?VUM2T01ZS3JMQytReGVzN0Z6QnhmbStqc0VLRU9iK1RXRWxhWG9pSksxTnRj?=
 =?utf-8?B?ZzhVcmh5NnZaZ3JaYzA5OHdvTXo1QXI2Nzh4L2k5WmwzaXkySWtEZEl6R0k2?=
 =?utf-8?B?djZZUjFnVkpIdWc0Q3pVWTRXTTAzTXdPbVVCeW00WlU0R2NNVkR0NFg4VXFx?=
 =?utf-8?B?ZzluTVppRVEwTG8ydzFpdFpqa2ZWWHpyakdhZThuVjkyazJZMytJZ0l6Z3NV?=
 =?utf-8?B?a0UwNktRZUgra3lqZTVaalhwK282RG9EcmVhUHVsMDQ0dkVFNTVXZDArMk1M?=
 =?utf-8?B?NnV3aEpjNjBoRWlhRERFbGFLaVhidTF5Vi95TzVJYjdLak1CYkJTZGdPMCtK?=
 =?utf-8?B?MUNRdnJnMldPalc4K2xJRjl4bUlDbHoxMk9NNFgxOFNObTBXL0NDL3ZwWWpH?=
 =?utf-8?B?anFhbXZBVGhTbWx1VmREQW9jTWRTODViakhQVkVXdXExU1NMcDJtclNmVCtY?=
 =?utf-8?B?aUYxRXdvUnNFYTQveDZpd0ZiSlAxdW5sdlpSSTI1Nml3a2ZsOUNWMXF1TW0r?=
 =?utf-8?B?M3dWeS8yd2tEVCtGWG1ZNnJUOEFyOENrTjRTRVVlcXhVS01QbzArMk1wUmxp?=
 =?utf-8?B?NHdONU9kS3RXU0tOUHZnam5jcjhzc3A0UnpZTlI2a0E5WlJIak9FdnB3eDg0?=
 =?utf-8?B?TUdpL3U3dkVMRW9JRjgzMWtnOE1OSXAvcjFRMXRtdm1HN3RodmpxeUZFdVoy?=
 =?utf-8?B?SU1RM2ZKSXJKRENnaHRZSEI0UG5rTVNmR2daaVZtMVNZc2RXanNla1M1eU45?=
 =?utf-8?B?endDTnFINWp2M0pLaFJRQzNFQlFvb1c4NlRHUTBubSs2Y0VnVlRCbVpnSmVV?=
 =?utf-8?B?bkR1eWRCaWNVTFlwckNBOElpZnljalVrK2JiVFczdFduMjdCRnFZZ0UySHJL?=
 =?utf-8?B?aTJhcEcySTlJRG1aaXd6djZWbjRIRXdQSFhyV2cxMllXd0V3My9OVlFEb00z?=
 =?utf-8?Q?qZauYhiesHE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STNLT0xlTXNwMDY1R3QwNXVGL0xrM0c2OVNaYVNiV1pXTmF1Z0hwaEZXcWJH?=
 =?utf-8?B?My9CdGxiT2g3a3VYdmxiZDQrL2dRRG5LVUZzZnR1eW41cjh2UU5yaU80MXVF?=
 =?utf-8?B?KzdWVXNka2tYVnZCTzFqVmdMMVlCWWJweEp4Z3NnL2MyVUUySUV6Y1ZDVjNH?=
 =?utf-8?B?N0w2VDFoc0VOY1lZWkVXczJOYUo5Z0lTZVFXT285dHYvVTd0czI2aHVISWVG?=
 =?utf-8?B?dGlkdyswNDlyS1FwUTFXQlM5S3g0YmZDV1liRnV2MkQzRjBGb3VlK29iNVlL?=
 =?utf-8?B?L0hGdnpuSFduT2JhM0l4L0lTYUtuTndVc1pGL3lMU1d6d0JmVUp4RzN1WS9Z?=
 =?utf-8?B?cnhNdUF1TWlEK1ZVa01tbktmbmRWd0MwdWpOZUpVbzcvSHIzdkd1c0RrSnFV?=
 =?utf-8?B?ZXY5MzZWZW1HNE5TcGt1NURNUnFtT1V2ODN0NTdMbmZuMlkzVTRrcXoyTE53?=
 =?utf-8?B?TUc4VnUwcFNKRE11SEpEMWh2QkVCSHlhSm1iSXFscTc0ZFVnVDVJMkNaTVFy?=
 =?utf-8?B?T2dNVS9VZXpwd1hEVGpnR25qUFhIVnNjY3Z5SERIQmkwUjg3RFVVMVFtTE9F?=
 =?utf-8?B?bzlLSFd5eDdwTmxFWnh0WUVYWTEvU2hyRHl2bi9SbDk5MU9uM0h5c3AvcDNp?=
 =?utf-8?B?ZUdzYU5mLzUyYVFyZUEzZkRUandHWXJoUDduajArTWlRMEVhTDR5bGdpMVZK?=
 =?utf-8?B?c0tCaUhmWWpzZGNpRUQyOC9KOEdJUTBzSzZoUUx5N0lwZHYySmpmTmNXL09E?=
 =?utf-8?B?OHVMaFRmekFubFo1aEEvc0VWdDBBVzFTWUlZTzdOOUpVVkliZnAwU1d0ekZj?=
 =?utf-8?B?cTZBVlgrOUZ3WGlzRk0zbDZKTUNJMVlZTHR0QmdOUXdKMnRUaU1XYXlRT0pZ?=
 =?utf-8?B?aWdEVGxDM0FuYXVsVWlUT0NvKy80U1Nhb3pTZjM0eW5heDlFYm83R29RMldI?=
 =?utf-8?B?WUg3TnNhMllUcnFheHBSTDVFOVdLQ0VYci9CVjY2MUpmZjBrcFk0QW41MUsy?=
 =?utf-8?B?WjhzMnpqOHp4d3dOc2xJc0pnN091MVdJU1FVVGIydEN6aU9xV0lzWmRKRGpI?=
 =?utf-8?B?aytmeVVBNUZ6M2puYi9jNjE4M2VlVytBa0RXUGttVjVZRXc4ZFEwa2toYXdy?=
 =?utf-8?B?QnR2NU5QczlONGUwZGpmRE5PQ2x5bUNjM0JyUHJIK21HQlgvamFGbVRDeS8w?=
 =?utf-8?B?WjZqdDZQYlZPSmxYTndVU0l6VTEvQTJZYzErQ0FKNFhYQWxsblJESXVWZDBp?=
 =?utf-8?B?QVdtZ0l4Mkt2ZklzL2hmeVFIaldnRjhmMEZPeEtNYnhudVl6dkhMbmlYVTZz?=
 =?utf-8?B?STFBeTFhbDdQRTlIWDNPSmJuTmgvRkJVWHRDR2FXcFB2WW9DTmhQRExkdHJD?=
 =?utf-8?B?OGpmS2hXMGhyeGNTR1MyMVZGSnVaTG82djFnd05vYTd3TnlOK3Q2SjRZbkxT?=
 =?utf-8?B?MDJPRW4reTZoUEtWcHpyWHlZVnAxK1FJZDZMZ21xU3VmK080UkNwbGo2R0Nt?=
 =?utf-8?B?NHM3elZEd2VVZ2poOWZ2VERlclRhVUxRYk9ObGl2MTlEdUlBL2dzdmtQVXZl?=
 =?utf-8?B?NDJnVWRxUWpnU0JSQTEya2k4MDVaWU5GMURmeU1LWVZ0UUErU2xlUlVGTXdI?=
 =?utf-8?B?azBrK2llOUdSZ1FTSDZRMnBqN2s0N2JCcXBqMUZWTFM4TU55N1JyTk9aVzBI?=
 =?utf-8?B?SjJvcG1lKzJVWnZ2a3k1NHBWOHBaVlZCcC8raEhuQ09mVElxdTQxMnNJU0ky?=
 =?utf-8?B?ZVNLVWRvYmJ0eUxKYWNtWjlDTmhvZ2N5ZjFJd2RQTkRpNFplWVozV0xMTWNZ?=
 =?utf-8?B?WWVQWDhnL2JaUzVtQVVsVGgzdHRRUUU5ZnZ3OWlrZmYwd3dHaHJmdXFvSHBm?=
 =?utf-8?B?SU04UkdUQWx6U0FTaXAzT25Xdm1aV2I0ZllrMk1DT2o1WE1BSFpTeTdLOXcz?=
 =?utf-8?B?VzNHNW1QaXRFUVdzRS96VGRXTWdUUi9kUkJuSGFoRkFDTVVndjRaUmY5ZWxJ?=
 =?utf-8?B?blBzUVFQcUh0M0swcGdWR3R6ZWJwT1p2OWx5TGl1NWFSb0xySlAwVzRWRUV0?=
 =?utf-8?B?VmFwd1EvVXNoTk5aQmFQY21OMFkzUTJoMDYxb0dhaVgvNVUrdHdlOURSU01l?=
 =?utf-8?Q?Fnc6EPv9h3dsIwFMvEtl3RdUh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6e0539-acad-48da-31f3-08ddcf7591d4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 14:30:02.4781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZ2+4fsUS6E3nBMif7UVJoOMVAiIQGchL3u8SYDT/YqjDHi6OwPkK9X35lSdsVvbKIww9SGFwRXmxY5/s6hWQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830
Received-SPF: permerror client-ip=2a01:111:f403:2413::61e;
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

On Wed, Jul 16, 2025 at 11:54:08AM +0200, Luc Michel wrote:
> Add support for GICv2 instantiation in the Versal SoC. This is in
> preparation for the RPU refactoring.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  hw/arm/xlnx-versal.c | 82 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 62 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 58cd874f81f..771f6108558 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -43,10 +43,11 @@
>  #include "hw/misc/xlnx-versal-cframe-reg.h"
>  #include "hw/or-irq.h"
>  #include "hw/misc/xlnx-versal-crl.h"
>  #include "hw/intc/arm_gicv3_common.h"
>  #include "hw/intc/arm_gicv3_its_common.h"
> +#include "hw/intc/arm_gic.h"
>  #include "hw/core/split-irq.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
> @@ -72,10 +73,11 @@ typedef struct VersalSimplePeriphMap {
>  
>  typedef struct VersalGicMap {
>      int version;
>      uint64_t dist;
>      uint64_t redist;
> +    uint64_t cpu_iface;
>      uint64_t its;
>      size_t num_irq;
>      bool has_its;
>  } VersalGicMap;
>  
> @@ -504,10 +506,14 @@ static void versal_create_gic_its(Versal *s,
>      DeviceState *dev;
>      SysBusDevice *sbd;
>      g_autofree char *node_pat = NULL, *node = NULL;
>      const char compatible[] = "arm,gic-v3-its";
>  
> +    if (map->gic.version != 3) {
> +        return;
> +    }
> +
>      if (!map->gic.has_its) {
>          return;
>      }
>  
>      dev = qdev_new(TYPE_ARM_GICV3_ITS);
> @@ -543,49 +549,85 @@ static DeviceState *versal_create_gic(Versal *s,
>                                        int first_cpu_idx,
>                                        size_t num_cpu)
>  {
>      DeviceState *dev;
>      SysBusDevice *sbd;
> -    QList *redist_region_count;
>      g_autofree char *node = NULL;
>      g_autofree char *name = NULL;
> -    const char compatible[] = "arm,gic-v3";
> +    const char gicv3_compat[] = "arm,gic-v3";
> +    const char gicv2_compat[] = "arm,cortex-a15-gic";
> +
> +    switch (map->gic.version) {
> +    case 2:
> +        dev = qdev_new(gic_class_name());
> +        break;
> +
> +    case 3:
> +        dev = qdev_new(gicv3_class_name());
> +        break;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
>  
> -    dev = qdev_new(gicv3_class_name());
>      name = g_strdup_printf("%s-gic[*]", map->name);
>      object_property_add_child(OBJECT(s), name, OBJECT(dev));
>      sbd = SYS_BUS_DEVICE(dev);
> -    qdev_prop_set_uint32(dev, "revision", 3);
> +    qdev_prop_set_uint32(dev, "revision", map->gic.version);
>      qdev_prop_set_uint32(dev, "num-cpu", num_cpu);
>      qdev_prop_set_uint32(dev, "num-irq", map->gic.num_irq + 32);
> -
> -    redist_region_count = qlist_new();
> -    qlist_append_int(redist_region_count, num_cpu);
> -    qdev_prop_set_array(dev, "redist-region-count", redist_region_count);
> -
>      qdev_prop_set_bit(dev, "has-security-extensions", true);
> -    qdev_prop_set_bit(dev, "has-lpi", map->gic.has_its);
> -    object_property_set_link(OBJECT(dev), "sysmem", OBJECT(mr), &error_abort);
>      qdev_prop_set_uint32(dev, "first-cpu-index", first_cpu_idx);
>  
> +    if (map->gic.version == 3) {
> +        QList *redist_region_count;
> +
> +        redist_region_count = qlist_new();
> +        qlist_append_int(redist_region_count, num_cpu);
> +        qdev_prop_set_array(dev, "redist-region-count", redist_region_count);
> +        qdev_prop_set_bit(dev, "has-lpi", map->gic.has_its);
> +        object_property_set_link(OBJECT(dev), "sysmem", OBJECT(mr),
> +                                 &error_abort);
> +
> +    }
> +
>      sysbus_realize_and_unref(sbd, &error_fatal);
>  
>      memory_region_add_subregion(mr, map->gic.dist,
>                                  sysbus_mmio_get_region(sbd, 0));
> -    memory_region_add_subregion(mr, map->gic.redist,
> -                                sysbus_mmio_get_region(sbd, 1));
> +
> +    if (map->gic.version == 3) {
> +        memory_region_add_subregion(mr, map->gic.redist,
> +                                    sysbus_mmio_get_region(sbd, 1));
> +    } else {
> +        memory_region_add_subregion(mr, map->gic.cpu_iface,
> +                                    sysbus_mmio_get_region(sbd, 1));
> +    }
>  
>      if (map->dtb_expose) {
> -        node = versal_fdt_add_subnode(s, "/gic", map->gic.dist, compatible,
> -                                      sizeof(compatible));
> +        if (map->gic.version == 3) {
> +            node = versal_fdt_add_subnode(s, "/gic", map->gic.dist,
> +                                          gicv3_compat,
> +                                          sizeof(gicv3_compat));
> +            qemu_fdt_setprop_sized_cells(s->cfg.fdt, node, "reg",
> +                                         2, map->gic.dist,
> +                                         2, 0x10000,
> +                                         2, map->gic.redist,
> +                                         2, GICV3_REDIST_SIZE * num_cpu);
> +        } else {
> +            node = versal_fdt_add_subnode(s, "/gic", map->gic.dist,
> +                                          gicv2_compat,
> +                                          sizeof(gicv2_compat));
> +            qemu_fdt_setprop_sized_cells(s->cfg.fdt, node, "reg",
> +                                         2, map->gic.dist,
> +                                         2, 0x1000,
> +                                         2, map->gic.cpu_iface,
> +                                         2, 0x1000);
> +        }
> +
>          qemu_fdt_setprop_cell(s->cfg.fdt, node, "phandle", s->phandle.gic);
>          qemu_fdt_setprop_cell(s->cfg.fdt, node, "#interrupt-cells", 3);
> -        qemu_fdt_setprop_sized_cells(s->cfg.fdt, node, "reg",
> -                                     2, map->gic.dist,
> -                                     2, 0x10000,
> -                                     2, map->gic.redist,
> -                                     2, GICV3_REDIST_SIZE * num_cpu);
>          qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
>                                 GIC_FDT_IRQ_TYPE_PPI, VERSAL_GIC_MAINT_IRQ,
>                                 GIC_FDT_IRQ_FLAGS_LEVEL_HI);
>          qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-controller", NULL, 0);
>      }
> -- 
> 2.50.0
> 

