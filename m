Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75528C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 13:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmvEg-0002qQ-Rp; Tue, 25 Feb 2025 08:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tmvEa-0002nd-Iz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 08:44:29 -0500
Received: from mail-mw2nam12on2082.outbound.protection.outlook.com
 ([40.107.244.82] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tmvEY-0002kG-28
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 08:44:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4EA9Og2zun7Eq2CTR5879rJ+6203QjmHdQX7bMoGUYpLUlZ7PTENS+Ocxxy2+JDj//L5L+whvkhYRjonn1t6WygPwgjPZjj4vNkkcpJWGF1DjA4um9ntLbXW0yXR7Ndyx0J0oqyYIIe0wxqUFKK2DNEu0qfQp/fNrmiiBrfCVnGXKSxQ8A977Mi5ZSoxw0qMhGWOOrBRm3kREDf2T4PsHpZdQ0GX5lVd2OV6vwjV+CcE9XKex8XuHjRFPcff9K1twRhrVuDyzi7bUJiklnXPrh/A+x61LiV6qIGdSi28hmgSN1rr//PEdc8ErXglG3B8U6waWqlqfETn2f+d3DMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQLkVTto/rgJ847vUYjgIbvUQ7l9My98mqaohcKCEbo=;
 b=jP1t0QLRrY7N3VvHFoh/rXhSVt09U7Nl9FcuxbmeGPrR8mSRcO180fNpzBaRFrrgFrsUg6qJaWSvDOtPLtRSf7pe2GTTwJyjmYiXYPG4H5NbXuEfYLhEeZINPIln8Ww3ynSl/t6E75IKJFZUHaGeVvnCC3iPLpuXChNq4dv3t0PJ8UpvYVhHudcaSET5IFTX3KO01ymWfalp9dcLp6xz4okIgOBOBtNIy+AZU+io3fNBQGRIXnT2ol/VY4uQIdgUUJzREA94jgJy+v+bMNUrzgVwlOGmqnOm2inEKHXc9nl+j6R28Pm6lgToNOp47eNkpe5DideZKsaOLkLXtsAgwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQLkVTto/rgJ847vUYjgIbvUQ7l9My98mqaohcKCEbo=;
 b=tBa650NQs9uA9QCKwMuWhLouR5zXl4bNBkY24IsJmvjJytxOmmTrWVIwLYRmnFURd1b9maGeGK6PFxBTV5sYw+k4hfkxr6M00bGGxOOzjqluFziI5Vjcs3/+FZnIZE16fZR0Lyq3bv/I3xpDL1TrqMhvJnt1nvtwi5mmDyJjsus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CH3PR12MB9124.namprd12.prod.outlook.com (2603:10b6:610:1a7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Tue, 25 Feb 2025 13:39:18 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 13:39:18 +0000
Message-ID: <969ef3be-b47a-4cd4-a2b9-8948d50484d0@amd.com>
Date: Tue, 25 Feb 2025 20:39:09 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] hw/i386/amd_iommu: Isolate AMDVI-PCI from
 amd-iommu device to allow full control over the PCI device creation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 marcel.apfelbaum@gmail.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 vasant.hegde@amd.com, Wei.Huang2@amd.com, bsd@redhat.com,
 berrange@redhat.com, joao.m.martins@oracle.com,
 alejandro.j.jimenez@oracle.com
References: <20250212054450.578449-1-suravee.suthikulpanit@amd.com>
 <20250212054450.578449-2-suravee.suthikulpanit@amd.com>
 <20250220193726-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20250220193726-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|CH3PR12MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a185bc8-f9ba-43b3-e26e-08dd55a1cd47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0t2SGJoZHRkUDJzY2tkcTU4Q0F3cXFGRTNaVTNBUFhYcmtOYXJPMGR1c2xm?=
 =?utf-8?B?eld1WGEyS0NaL1VRSUdpMHUzbENSa0swc3lBQTQ0Y0Nya3BxRkx4S0E1WXB5?=
 =?utf-8?B?WlBjbVlPU0JNT3dmMFVFNC9XOW92Y0NmczZYelVrK2ZJdTNIQXFvcWZoVmtr?=
 =?utf-8?B?eCtXbS8wZXlGZFVkL2Z2RE82WDRDR09rck8zbzliYXVZajM3TnJpaGRXTEEr?=
 =?utf-8?B?TVZtU0xRL2hkVU1TbkdpSis0b1pTY3RrdzE5K1lWWCtkSTNDZER4YjJRdSs2?=
 =?utf-8?B?YUZyNXJUOG83MHlBTzNiVENlem1rWlU0dU5VZ09iN0E1MHl6UGpMQ3NzSlZ2?=
 =?utf-8?B?NDlIZUxzaC93VFQxaG14UWU2REpuS1dZeGxNaHBrN3JVb2JEZ3ZHcnU4N0JH?=
 =?utf-8?B?SFQzZ210OUw2TkovL1Y2b3RGK1BLNmZ1VmxkcVNaY0g5OUpPZGNiditSNWY4?=
 =?utf-8?B?SVM0SjFFSXUzaWtUMUhIdEVqaFB3WU5oaHJBSnB2QkhxNi95SVBpZ0JabG1s?=
 =?utf-8?B?WXhHcm4wbFJnb293OGUzUGs3Qml5elVnd1Q5YVpzdmtrZjVGOEN5bFpCLy8y?=
 =?utf-8?B?Z2NEOHhqWXd5R2ROejFpSGxqVytvbnhwQzhudldJUUdLaG5SeHJSWkJBbGcz?=
 =?utf-8?B?UTk4KzFTZFRXa3J5UzRpUjZZRzN0b3BCa3Z3Z25FYklweG1ieitPWE9OZlcw?=
 =?utf-8?B?SWFMa1dFNk52bk4vakRZOFF3MzVhWVVBQnloWTNURVRpQzBGK3lJc0N4WXE0?=
 =?utf-8?B?YytBWlpDL0dwQWpjbFRtTnpGTnozN1JqZDBaMnZWU04xNjE5VVNueUhaYjNk?=
 =?utf-8?B?d0tXUHdzM1FHZTdNQzdlbUtnRnFwb05vaDNSWWwzd28rNHc1VWkyUUFodE10?=
 =?utf-8?B?TjNqOEl3QVFMOFlmVnpPaDFYdFRzeVJCMjFmdHZQbWpYdU5YTWtVZWtlcHFU?=
 =?utf-8?B?V3ZBZXVPbjhvYVYzc0NHVjZoRldJTUlHWlBVMzhrR21FajhtQ01SdUNTSk03?=
 =?utf-8?B?c2JzZnZqTDBuU3JiTG51OGNGN01FZ2Y4MDdaVm9vSkJyckc4cGZGNUdkRHJM?=
 =?utf-8?B?d0RGa2hLSjVBUFYrdUxWSXZsZXIzZGpLZ2JZQWowZ3hseDZHZXBsOXdDLzBa?=
 =?utf-8?B?MEFYU3dKMnE2L2orYzNCSzNHSG1EUWFhMHFneDErNmZCQ01ON1BUSU4vSUYx?=
 =?utf-8?B?MWFrL0RNMUhTbU56RjYwSWxROVlEYkpudXZUSjFGT0hwZWdESkxFYTNUSGF6?=
 =?utf-8?B?SlRKQXFETysrKzlnQ3RmdENQNE5xVWI4Qm1sOCsvSXI2OVJYWGs1SjZQU2Ns?=
 =?utf-8?B?MTlabGgvbmVsM2QrNWtub0ZRdlVISVFyVEpXZXZ6N3M4ZlJWdGxxMWwvWkFP?=
 =?utf-8?B?STBPVmVIZGdIU1htS01ocis4QzNQeVF5YkdGZlpwZ00xNUJFMytrSlcyaVB2?=
 =?utf-8?B?ZWxMMFIvODlUNjk5WW0xMGVFVDZqUE56MGxubnRrcEl4ZCs3YVIzTnZvRWZJ?=
 =?utf-8?B?VE9rNzhwWFBoSGVQRjMzVVIrbFZlWjkydTZ0SGlsM3JoSjd3bGxBZWVXVGRt?=
 =?utf-8?B?eFVGQU4vOXFacVpnTy9SRm9iOUo2TnBpR1RYS3RhVzN5UmY0U3hIOTJ4K2pa?=
 =?utf-8?B?QzVYd1RGZU9GUlNYNUNiTVRwTkhyRUFjcWlsalR6RzFicmVWRk1MUWlRdHhG?=
 =?utf-8?B?LzJTTkgrdW5YRGNtYzRBbm5keWN5ZWtyRElzYVdWT0pGV1Zab0Myem1Qem5o?=
 =?utf-8?B?eitJQWVLcDRTc3JzZlgzbjlHNnpFQVFnaHhEbUpWcFllK1UxdzZRWldnVERY?=
 =?utf-8?B?Vk1xR1BSRlZnc0JnY3pHTWxDQkd4RzdBcXEwME04YUV4WDk5MXNZcjNZU3pZ?=
 =?utf-8?Q?ffrKcAP+VmPTZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Si84RTRtSy9SdDFaZjBkK00yaEo3R1BIQ3RFVStOWjE2U0hNT3gzNEZZREVL?=
 =?utf-8?B?ZGp3TktSckVoeERvcUplZk1pcjkzODJHU1Flc0xVUUo0aEV3T0lSUUtsUzdp?=
 =?utf-8?B?aU9iWUZCNkFQMFBUdjdUcWdxMkZ3ZE5KYW9vQXlSdE5qMEE1dWtxOGszWmlF?=
 =?utf-8?B?Tm1NYmhiSndtTFg3QnJkY3J3SGhwb2tjYWVCMEt6eHBjL21FZUQ4TC9LblZ1?=
 =?utf-8?B?dyt4VGp0WDZaUWJ3Yk9jV2dQZHYvSmFXQ2F4VHpnWTVZUGs1ZTFiUXQ1UndM?=
 =?utf-8?B?QXlLeVZBNlBobnQrTUt2Tm5TTlFHQ0JCaHJqQkM3NUlWUlZTdUJrVVl6ekRt?=
 =?utf-8?B?Z29jYTNQQmJKcmhzWnJvclpjWDNabUNyZmY4dHZaOVA4cnl3UlNsZVF3U2ZJ?=
 =?utf-8?B?bjh0eGxaaTA5ZldHOVVVa0FrdHlQUUExTFJ6SFFtWHMwZ0toamhRMitwcjFV?=
 =?utf-8?B?c0VVNFk5ZkRFWXhSeDRGaUtUREJlSnZNZzBSL0YzaXZRSUQ2VzJMM0pReFlq?=
 =?utf-8?B?UG8zTGpSS1NJdFFqbGU3VVJQMGFSZ01BUGhDRW5HajJPL2xqTThpeXhDNUht?=
 =?utf-8?B?V0E0UG4zZjY2NDlrcVkrRTJySUpmYkN4Wm53VWtqVHpWUkhSMVlFbmw0Z2VP?=
 =?utf-8?B?b2VnZUVEMGJBblpsZE1jNzcrWkJyNlBYZVdnSEtvYTZyVkJxTWRhTjc5RzZk?=
 =?utf-8?B?SUNlOEFUTDlOV242cUVDNFYrMXh5a0dvVTg4REhIbFRObnphV2g2SHlDR0tJ?=
 =?utf-8?B?WHU0ODdxa3lTUWpLOUtpOXFVWkZqOHNFb0RvOExxTXoxSkw4N3QwNEtJUVBu?=
 =?utf-8?B?RDkvaXZkQXBpNm1Ua2p2WFNiTnUremsvdUxGVmJ1Y3NYUEpialVLYWVldGor?=
 =?utf-8?B?b0w4d0ozcnJtTGlvdG9nZVBGSWxLNEk2TXVzZHhEdWFpSCtteUhpcHFnS003?=
 =?utf-8?B?Wi9FN2xTQ2V2dHIzV3lLbmdTT3h2Q3ErNWk3YkJNeWZDQTA2YmpqalNoT0xn?=
 =?utf-8?B?bUs3WGRJMjhwVS9wWnBGVGlMVmZKTVFrdjA0bkpzL2tkc0xRT2c0WGVwMFVY?=
 =?utf-8?B?cDNZekFTY1ViN29wclRCY0gyamVPVXFQYUR2cWFKNmt2OVMxQ0FmOXQ1Umxu?=
 =?utf-8?B?ZjhZSFZYbFhlTWd5cGFUOEpNYnFUUGpPaU9VVVJTN0lPcjgwOWdIQU5GZ2h6?=
 =?utf-8?B?OHE5NENTbC9melBZZ2Z6WDBkbjhYVUpCNGVOR0ZPcUNuN0tobFBNeDl1d3Fh?=
 =?utf-8?B?RENPZjhhTmJacFBJemJpdUU3RTlvdXlTeHJFblRsMzhGZGJjNHdnZXVpTmdL?=
 =?utf-8?B?S0NodjRLWVFCQTlTRnA4WnRmZk5MUFd6bUFCR1NNU0kwYnVHZkFiK3VKQjFo?=
 =?utf-8?B?KzFqQlNSWDZJWW5xRzdZWHFvT2J1MTFURDdiS0xIOHhncTJTN29ISE9SaGx3?=
 =?utf-8?B?ZzkxZDBFYzhOR1NMZTlVQzc1MWU5YjhwMDVQbmVoRWFZdklSL0hLRWlEdTdF?=
 =?utf-8?B?OWhSc2R0N1Ryd2Z5WHNFR0VWamM1NlVNMk11MW9aUTloUmliVjEwcjIyQzFL?=
 =?utf-8?B?M2JpcCtxRWJma1dDalJpd0g4Z1NlNlR5V1RTL3QwTmcvZjQzR2hUNEVxTEtm?=
 =?utf-8?B?bXZmZVIrYTc2bS9hdVNZM2dvRDB6OVlyRVF0Z3E1Nnp4T1FoSTh2ZGxKYlJG?=
 =?utf-8?B?azFwQmw2bHUwaEV3dUlQRGdicjlZc290M01SVnM1SG9hZXpGOXBTQkFjTEgw?=
 =?utf-8?B?U2tnV3g3bW5QMTQ0Q2t6RnNIZFIycnk1WmY4WU5EM3g3RUQwRXJyK25tZjIy?=
 =?utf-8?B?UnowaXducHBNd1Jnbm04R1FKcjl0NU4rV1BzRGtycFhucDQyb1FTV1FMQ1Zs?=
 =?utf-8?B?VlZUM1E2VzBMaUwvaEEza0kwdzl5VDNpQTVVN2NEMUE3WTRpc0ppdGVBNTEr?=
 =?utf-8?B?Q1VzZDVBbTBIK3d4K1BFQVhFMlBLajRjaUNHYlRRbUlabjdlQ044UzlJZjFY?=
 =?utf-8?B?cHdYbHNtcEwrRW45NVlwaWtDV0FkdzRZcTdHalVlVy9qczlOMHY3cXNZNHdx?=
 =?utf-8?B?cExiNTJZT2RCR3BTYm94QWRXNzVkalBYK0FxZW5WZlFBVlR1RTNhNG5wVURl?=
 =?utf-8?Q?migeuHlzkliofH/X2I6At+DXs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a185bc8-f9ba-43b3-e26e-08dd55a1cd47
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 13:39:18.7455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KcthVCv0CBVwhFX1yQWR1h3WBy8LyvWYrGfASOq6ISYfcrgSv1ME77BMxFpOzBBfVsANw5GNeUT/sbxrDG/jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9124
Received-SPF: permerror client-ip=40.107.244.82;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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



On 2/21/2025 7:38 AM, Michael S. Tsirkin wrote:
> On Wed, Feb 12, 2025 at 05:44:49AM +0000, Suravee Suthikulpanit wrote:
>> Current amd-iommu model internally creates an AMDVI-PCI device. Here is
>> a snippet from info qtree:
>>
>>    bus: main-system-bus
>>      type System
>>      dev: amd-iommu, id ""
>>        xtsup = false
>>        pci-id = ""
>>        intremap = "on"
>>        device-iotlb = false
>>        pt = true
>>      ...
>>      dev: q35-pcihost, id ""
>>        MCFG = -1 (0xffffffffffffffff)
>>        pci-hole64-size = 34359738368 (32 GiB)
>>        below-4g-mem-size = 134217728 (128 MiB)
>>        above-4g-mem-size = 0 (0 B)
>>        smm-ranges = true
>>        x-pci-hole64-fix = true
>>        x-config-reg-migration-enabled = true
>>        bypass-iommu = false
>>        bus: pcie.0
>>          type PCIE
>>          dev: AMDVI-PCI, id ""
>>            addr = 01.0
>>            romfile = ""
>>            romsize = 4294967295 (0xffffffff)
>>            rombar = -1 (0xffffffffffffffff)
>>            multifunction = false
>>            x-pcie-lnksta-dllla = true
>>            x-pcie-extcap-init = true
>>            failover_pair_id = ""
>>            acpi-index = 0 (0x0)
>>            x-pcie-err-unc-mask = true
>>            x-pcie-ari-nextfn-1 = false
>>            x-max-bounce-buffer-size = 4096 (4 KiB)
>>            x-pcie-ext-tag = true
>>            busnr = 0 (0x0)
>>            class Class 0806, addr 00:01.0, pci id 1022:0000 (sub 1af4:1100)
>>
>> This prohibits users from specifying the PCI topology for the amd-iommu device,
>> which becomes a problem when trying to support VM migration since it does not
>> guarantee the same enumeration of AMD IOMMU device.
>>
>> Therfore, decouple the AMDVI-PCI from amd-iommu device and introduce pci-id
>> parameter to link between the two devices.
>>
>> For example:
>>    -device AMDVI-PCI,id=iommupci0,bus=pcie.0,addr=0x05 \
>>    -device amd-iommu,intremap=on,pt=on,xtsup=on,pci-id=iommupci0 \
>>
>> For backward-compatibility, internally create the AMDVI-PCI device if not
>> specified on the CLI.
>>
>> Co-developed-by: Daniel P. Berrangé<berrange@redhat.com>
>> Signed-off-by: Suravee Suthikulpanit<suravee.suthikulpanit@amd.com>
> 
> breaks build:
> 
> https://gitlab.com/mstredhat/qemu/-/jobs/9202802751
> 
> 	./hw/i386/amd_iommu.c: In function ‘amdvi_sysbus_realize’:
> ../hw/i386/amd_iommu.c:1616:18: error: unused variable ‘dc’ [-Werror=unused-variable]
>   1616 |     DeviceClass *dc = (DeviceClass *) object_get_class(OBJECT(dev));
>        |                  ^~
> cc1: all warnings being treated as errors

I'll send out v4 with the fix.

Suravee


