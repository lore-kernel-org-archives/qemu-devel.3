Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6337ECD5BC0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smCDl-0006bW-9U; Thu, 05 Sep 2024 09:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1smCDk-0006Uz-3n
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:08:20 -0400
Received: from mail-bn8nam12on2061a.outbound.protection.outlook.com
 ([2a01:111:f403:2418::61a]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1smCDh-0003UI-SH
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:08:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaWiqTABexEaQVtWJLqFwNysGqaT0SJkW0Cd/ceOYPrNNmnZ7Wp2c+V98GwP6M6bDTAAVRRkCDV5fQTdN5p0P5RPqtoynhTFcNuxksKKE1mELqgsCHXFGCavSShjuO7WdF0nQXeU44ik+yft5AHeLDPm/xSE/Ad3b61KXjlLkDeGaLzFvBUrjoun0k8imReySpyMgYLLYYMY12INS80SUt90tsvVfpPqUJbe5GQggRqZffzLSFWIvlvzJVSJhVPD/+/VlmBGnmCB3IBfE6pq2jVXoR9RiFOgXKiHVerOaVr6Y+zFUBNq8VX2Y3xm23bEhJ0uxzb9+CYzWI7VqKh9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8sOinHtijoTAxBplSwDLyv2rvaX83cS6TTbMCc++C0=;
 b=hEXv6xN1pmEGArfHY/YxqTUIN0+0+DlkIoiNAQoa+keh7oyLXXHK9b2h1AVMTGxJASW+IVe1wpU+nCcYWkyuYgW2mVYUP++rskbCJxHF6krT+pjHnwDHFlRWVk6b4EYJSjkZS6GFcjMSI3NUjsFD8RtBIOOsOndFwqAgQCydc4Gx50F0Z0EhJg+yXiXGqrLX8KpXnH5HT/3j7/q1I1sueaTXXBAXugRLo9jGa2szi+b2lu7Xk4S0NesDv4mqFyO/Hs6bxGe3Ocp5LycZGLS7Ujkq7xrz5BtI0VKNdThCQbUKzkS7+rDcUGCW/Eq9zubgW5XRGytWkJUThhboluuu8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8sOinHtijoTAxBplSwDLyv2rvaX83cS6TTbMCc++C0=;
 b=LGPJWARD2H/oRdB884J6t6JskvMkyN/nhgN/XDO2rKgaWTG1CKQuJHPLJACYqLZNEOY9bMkg3z96MTuiY0A5vbXWFhgn3XzH7LzxFWNWUfgezMAPTgglnA+MevlRnC/M9r1XSWbO80kK1tRQPc1E0DiH/l2EZZKstkDAqvSAd+UOw97LOq0hOSHDe46yNDm4IJAzzYSJhafVusdRf4+MvnotlsRJzP0x+khzr3ZPD18ux80LnoiIZgGiORykLBSeC1EOGncxvIPovF+uliYFSfYznQGKrljM8zQU7Y+RPc7LMsv7xIJqSoO3VQxcOVaeeeguhmL52+YizGNSBiMzvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 13:08:10 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 13:08:10 +0000
Message-ID: <8ec6abeb-25ee-417e-9f3f-d0f27ec4f370@nvidia.com>
Date: Thu, 5 Sep 2024 16:08:02 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/17] vfio/migration: Add
 save_{iterate,complete_precopy}_started trace events
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <3c43bf662842e579c0009dfc5135024e45166987.1724701542.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <3c43bf662842e579c0009dfc5135024e45166987.1724701542.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0241.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::12) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DM4PR12MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 0285ddd1-5060-410e-0c6b-08dccdabca80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STFQdTVhNTdPV0dCcEhoTko1ZFJzQU1QQVE4a2pnb3dDSEhuVVBxREQvMG82?=
 =?utf-8?B?ekZwZEY3Q1Q0WGVEM0FHSU5VNzdmaFFVMmdzcDYyWGN5TE1vODRqeCtHZzQx?=
 =?utf-8?B?SDF1ZXVIamg4NTErbW5lZzBEYmFSL3BIY0w3emo4WjlnZzE2UVRwL3dCQ1h6?=
 =?utf-8?B?b3h4MERPRmRpUDBzWWZKRkdSaWRRa2lDWE0zbTZpRTYzV3RXY05wK1Jucmdq?=
 =?utf-8?B?UGY0ZjJxRG1tTitXQ256eGFTZnZpVWFTNi9KQ3BEZUdtUWtCNEEzd01jSGVx?=
 =?utf-8?B?L2dzMnVOd2tUVkk3MVBqUEJzWEhITGxnV053LzhRRHpWYTBvUkZ5bUdRcDRZ?=
 =?utf-8?B?YmtwRGVvY2t2RGttQTFQVXJ3NU9HUDBnOUYwN2ZqOGJWSW5uT21FK2ZEek5P?=
 =?utf-8?B?S3BqS0NjWUExdm4yS01UUnY4VU5waTduYTBNYXBkZ2J6Sk1oSFNMamFwOEoy?=
 =?utf-8?B?UU1mek82dmdvb1FqNndlODh0amVYY2Vpa3RGNVB2Q3RoQk50NDB6ck84ampr?=
 =?utf-8?B?cThvZXVwYlFRcW5xTzVPZVFSUnZ6VWxwTzJ4dmJ2WG93V2xMa2djK1QyWVVK?=
 =?utf-8?B?M3dzR20yem44N09FSzFDRzJwTGdIS1dXNWU4cGRnMWFkTWhuNkQ0a1RXaEhp?=
 =?utf-8?B?Y2dCTnFEOFNuU0ovVjdyQnZnNnpWUFovUFFGUlZUb1VxSERraWZjM2hodS9w?=
 =?utf-8?B?ckdKek1WQXducmsvRXBJcklheVZnVlhJL2pyd0hIZU1TVjFEMUZUZW5lYjIv?=
 =?utf-8?B?MkFtdk53S2ZDR0I2TzdEZGRVLzI5K3dTRGVFY09PWnFiTVNPTkpGWmk2Vmw5?=
 =?utf-8?B?cU1IS2l0S3dRNXdrajlWaHkrQTVmQnI5OUJWZEgxSTVvempraml2dER5K1RH?=
 =?utf-8?B?emRPK3pheDBsaDZuYk51NXdkU1lNRDVPVUhrNXRMVjJXK0Y1Sy96WVVCWVdu?=
 =?utf-8?B?MjhVRG9pNTZQSTRIWUdRVWdSNVdsY2pvZTFlcng2Sko0T2hMNjY1ZCsyV1By?=
 =?utf-8?B?WlFJQ0F1eVluVUs3Wk9vUWZlblp5aVBCNmo5bWtmTkh2cnZhNkUzUEJzb3Zs?=
 =?utf-8?B?bkVKTGJsREJ1RDJoMmVyRGNldUJiLytwazErQmQwalA2My8ybzE0UDFmN1Jn?=
 =?utf-8?B?UzNNOGlsdlNjQWdEdUlvZkxSVWNMSGsraTdXbjFJS25EdUFWTlQ5TFgyd3pL?=
 =?utf-8?B?ZnBWeDU3a1F4NjV3cUQ0VFpoRUJsWXJKc3ZmMkdWbXBuNlc1cUMyY3lxN1p3?=
 =?utf-8?B?TzlIL3lZVkpIOWo3Sk52QnQxaWNOc2p2RW93cmNwd0hqZzhzemZvVERKMm0v?=
 =?utf-8?B?Vm02cmJrc1dyY2NqanVVbWpuZFAzc25nVFlmZjZwN3grOGVEZlFqbXVtbUoz?=
 =?utf-8?B?bk52TFlZb29PbmpKY2VXelkzdy9YYUdHNTJHOXZsaW5oam1BY2cvVkgrRWt4?=
 =?utf-8?B?M3VUdG9OQmxCT205TVJrei9la2pYdzZHYzcxbFFBd0NyR2xXL21Ua3Fad2RS?=
 =?utf-8?B?V3VING5NOHJka2tEVGl2L1J5NURRUXJUQW5GalMzSWJKN1hxYS9NaDFSMmhs?=
 =?utf-8?B?a092U0o5NytwRFh5V3NXOFZ4UGRDa3BNWlRMZVpQOFk1dkpwT2Fzc3ZlT3Fr?=
 =?utf-8?B?T21ibk9vK2V4b3VieERPVHA0d3JUWEdYbTZvVTBhNjNLM292M0JrZFVwZHBR?=
 =?utf-8?B?a2dhYkdBRXViYlJrZG4rZS9oQXlhK1psSk11VWJDc2lUNG45dGp5a1pIc20r?=
 =?utf-8?B?OUt1NytHNEV2SkdzdEFCc2VZMHRqYWpVYWw2RFJXTEpuM1dFbGdnV2pVanpR?=
 =?utf-8?B?dW1HZVVjVGhCZHNwT2lNZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3dwRVd3NGpFMmJsN3dpWkUwdVZ4ZGhtSmprWGRnR3RNajdHblVuallraCtW?=
 =?utf-8?B?bC9Tc3ZTNGpvSDdmMS90djFsRy9ZL21YanBKZW1hZUx4Z3IvVlJPV1BYMFlB?=
 =?utf-8?B?amxaZ2thVmk0czE3dG5TdGE2TmtjSURJSG1vN3NjMzJEZUUvbkdrM05sczFL?=
 =?utf-8?B?RjV4Z2FldWd0WmprM1NkT1VZbE9JUk5qM1pzY0x0eUNXS0dlM3AxSnd4RkFV?=
 =?utf-8?B?WGdxaHkrejZPaGFaZmJ1ZDN5bE8vbGxkQWRweTJFSGNHSmxNWC81OTlFVFJm?=
 =?utf-8?B?ZFU4KzBSVzk0aWpqalppcFhtL21oVXFBS0JvLytXSXdUdmFBWGwrbUl1ayt3?=
 =?utf-8?B?ajBMeW44S1QrOFBxeGNieXBzdDEvYUtnVmVOWXRhLy9iTHJWbTVaVU9IT3FE?=
 =?utf-8?B?Zmp6Uzk3Yys2Z29iKzFCMFNsVzEzUEVBeU1qMzZWWURTTmdVempkaVJJU3lD?=
 =?utf-8?B?NlNMQ3VPM2NMUkpvUEU2ekpmeEZqNFhaTnJaQm84ZmpGOVJkV204NTM1MFND?=
 =?utf-8?B?T2c4UFU0b0VuYWRvRVNNOGdTYmxvVm1oS0JpTVVzZW1QRnRkL2xrSHpoVTVx?=
 =?utf-8?B?QjBrQTdCTUtGRm92cHgzMlBZd1JnNWp3NlRHUjlmRWtpU0ZueGE4TjhhSFpK?=
 =?utf-8?B?N1NDVURuM09YV3R2YVJZVVJqSlZGallZRVhVRkdncHVuaWdaYjh4NVVvYlVy?=
 =?utf-8?B?KzZ5SnVmdVZHNU5Ca0ZWTkYzMkZUclVVMmNsOWRDdnUxbGtZb1RxWjl4a29a?=
 =?utf-8?B?WmQ3OGNuLzg2ak5GckNGWTI0MXd6NmJQR2VUbzNhUkRXUmlWbTdndkhnSG40?=
 =?utf-8?B?MVpick9qM3QvaWlvdndka0Y0ZGpPOEd6UW1tdkFlZldpem9xUXQxUUhzZEpq?=
 =?utf-8?B?ZVI5c0dHN0VPRFE0QU5xT0NNbTVVTy9ncmZLaDR0a0NRNXJ1SUNGN2lZOHVT?=
 =?utf-8?B?ZmVVRUhQVnZ3NGcxaXJzc0xkZjJBMUZ5WXhHOHhoQndqaU9uZU04M1d2UlU5?=
 =?utf-8?B?Szc1bEI1cjhUYkNtMXVmSEtnWmxuUitHVlVRNUs3dVJmUVVyN3VyNXNiMzE5?=
 =?utf-8?B?Q3MwWWlWaThaUzFHRHNNSjE5c0ZPRkV0YzRCVFdIdVBjZ1VUREVtdVIvdVRj?=
 =?utf-8?B?SS9hSnFONVBGRlFlVzJIUWE3RFdPeTgvSjRxR1hUeUNKSjhaNEdXWmZjQXUx?=
 =?utf-8?B?bTEvZG1mVmhHSjhDQUh6bTd1RGZWTW5ITmVIWjlnMTlzZkJObEJZT05YeUYy?=
 =?utf-8?B?clVDUklRank4VE1aQ2g2ZGVCa3ZFZmMrZXZUSmdnTGVXQ1pzWmtsOEF1ZFFx?=
 =?utf-8?B?UU1ucWp1Ky9YdXpjYms3YzVMSkNRMzYrS1IrZEQ1aFd4c29rNkdsVU5oYWVi?=
 =?utf-8?B?K2ZkcVJpWStBU2VkTVNjUnp6bVFmci9SWlVXb2lDa2p5MDgyNXFSUTlKaTVp?=
 =?utf-8?B?a3dNNnNJNjU2MTI2ekpTK0p5aHVhMlV5VmUrNmVYVDBvak9QRTJ2S2wwZE9u?=
 =?utf-8?B?RjlUbWlqcWE4MWhwU1REYmp5SEdjcVV4ek14MHJTdmRMRTdUQzBtL3dnTHFL?=
 =?utf-8?B?WU41cFVMQUN5ajhZeUpxVjJXMG9jRFV6ZDA1cHkxWHZ1emtmMHh4V3E4Z2Zz?=
 =?utf-8?B?Q0JlUm1hbDc1R0szd3E1ajZYaHNCZ2h2RE54WG9tc3U0S1c5ZUVmblVrN0F2?=
 =?utf-8?B?QUpLU3EwNTZPZUtCdjdhcWVUa2s5Zkw3T3NSb2llcGdGd3VmQnNGdVFBbm5S?=
 =?utf-8?B?OWJZVFA2U3JVR1k1QmxsN2prc0hOVGd2bWJIbHFCeFh0WGFKZ256ZmFiSXJC?=
 =?utf-8?B?WFlqWkNRaW5Bb3I3RGJFSFdvSjRYRkJhcVRsOFhsL1VhbTUza0NoK2JGY3Fa?=
 =?utf-8?B?RWtUNm8xVWUxNE9xRFgzcENQcU1SMWdraE1kdGx5R0pWK2FuakNZWWpUV0t2?=
 =?utf-8?B?ZHBZNk15OUwyUUtBSE1ZV1QwSjM0dzlTT1hlb2xxNkR0WFBNSFI4dnpxQngw?=
 =?utf-8?B?aG5ZMXhrVTNJdmNaWFdBbGlEdmxWTUo0TkZLR2dyRVIrK2t5VzFyVENjWEhh?=
 =?utf-8?B?eHpFeHJlbWpiUTZpTzRSRVdIY3krUVRWZG9rM2FnT1JWZk5KNWFJWW1iY1cx?=
 =?utf-8?Q?2J7PCFQLyqqdybG6mfmwlwJpk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0285ddd1-5060-410e-0c6b-08dccdabca80
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 13:08:10.2719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6t5pdGJ+gThVMyUyM+x4ZK3P9bHg4t557A0IfNowuUoLgEQ54l0Q8Po4DHXGd9fi2Gf7xAaaAuBFNwyp7rXIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6087
Received-SPF: softfail client-ip=2a01:111:f403:2418::61a;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Maciej,

On 27/08/2024 20:54, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> This way both the start and end points of migrating a particular VFIO
> device are known.
>
> Add also a vfio_save_iterate_empty_hit trace event so it is known when
> there's no more data to send for that device.

Out of curiosity, what are these traces used for?

>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration.c           | 13 +++++++++++++
>   hw/vfio/trace-events          |  3 +++
>   include/hw/vfio/vfio-common.h |  3 +++
>   3 files changed, 19 insertions(+)
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 262d42a46e58..24679d8c5034 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -472,6 +472,9 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>           return -ENOMEM;
>       }
>
> +    migration->save_iterate_run = false;
> +    migration->save_iterate_empty_hit = false;
> +
>       if (vfio_precopy_supported(vbasedev)) {
>           switch (migration->device_state) {
>           case VFIO_DEVICE_STATE_RUNNING:
> @@ -605,9 +608,17 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
>       VFIOMigration *migration = vbasedev->migration;
>       ssize_t data_size;
>
> +    if (!migration->save_iterate_run) {
> +        trace_vfio_save_iterate_started(vbasedev->name);
> +        migration->save_iterate_run = true;

Maybe rename save_iterate_run to save_iterate_started so it's aligned 
with trace_vfio_save_iterate_started and 
trace_vfio_save_complete_precopy_started?

> +    }
> +
>       data_size = vfio_save_block(f, migration);
>       if (data_size < 0) {
>           return data_size;
> +    } else if (data_size == 0 && !migration->save_iterate_empty_hit) {
> +        trace_vfio_save_iterate_empty_hit(vbasedev->name);
> +        migration->save_iterate_empty_hit = true;

During precopy we could hit empty multiple times. Any reason why only 
the first time should be traced?

>       }
>
>       vfio_update_estimated_pending_data(migration, data_size);
> @@ -633,6 +644,8 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>       int ret;
>       Error *local_err = NULL;
>
> +    trace_vfio_save_complete_precopy_started(vbasedev->name);
> +
>       /* We reach here with device state STOP or STOP_COPY only */
>       ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
>                                      VFIO_DEVICE_STATE_STOP, &local_err);
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 98bd4dcceadc..013c602f30fa 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -159,8 +159,11 @@ vfio_migration_state_notifier(const char *name, int state) " (%s) state %d"
>   vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
>   vfio_save_cleanup(const char *name) " (%s)"
>   vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
> +vfio_save_complete_precopy_started(const char *name) " (%s)"
>   vfio_save_device_config_state(const char *name) " (%s)"
>   vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
> +vfio_save_iterate_started(const char *name) " (%s)"
> +vfio_save_iterate_empty_hit(const char *name) " (%s)"

Let's keep it sorted in alphabetical order.

Thanks.

>   vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size 0x%"PRIx64
>   vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
>   vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy 0x%"PRIx64" postcopy 0x%"PRIx64" stopcopy size 0x%"PRIx64" precopy initial size 0x%"PRIx64" precopy dirty size 0x%"PRIx64
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index fed499b199f0..32d58e3e025b 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -73,6 +73,9 @@ typedef struct VFIOMigration {
>       uint64_t precopy_init_size;
>       uint64_t precopy_dirty_size;
>       bool initial_data_sent;
> +
> +    bool save_iterate_run;
> +    bool save_iterate_empty_hit;
>   } VFIOMigration;
>
>   struct VFIOGroup;

