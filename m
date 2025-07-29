Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024F3C87FCA
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 21:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugsLX-0006J5-P1; Tue, 29 Jul 2025 17:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugqPC-0002yc-P8; Tue, 29 Jul 2025 15:54:36 -0400
Received: from mail-bn8nam12on20628.outbound.protection.outlook.com
 ([2a01:111:f403:2418::628]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugqP9-0006o2-49; Tue, 29 Jul 2025 15:54:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhJouqSoljkbUEbNzak8rM2Jgz2LzVqp8oaVq3cL3Wkjbd7M1thqGokNlxd4KCmtNF9kFjBlGDDRyLY+Ozldf58s75qgKgOvZ1yXHlTnoalxe2qufDulCrkz6p8DNhlN7ymW2ono2Mlqx/oGPXVz1GaBZtO6R8w6xcvX9zi20rYlJlFoFg90LkmUit7dy327sbD286B3qvwI8gtxXsmk8767XP+ZgRMAfRLAhwc/8qqeQzvcF/9ZeEVbkvLine2ZokoGJbZSE1z8fAKIxttz42fiEm9pi5z4DeyhFhriLqL3cKoPCSd1OFkYKqNdFGe8QcsdZ6LMexjWvzN+sRcGoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd8BhsmuGEUsqafz/i/p+zSz0iYyiadoHN1trs5agRc=;
 b=inPe1g7eLnP0YJPKtW3cFs/2XsAUQmuNRksmDjPZry+T5Y8Ny8kuH7Wf1ZslQXMrUcAFt7P/hZBx3JWGeE2CNPe1BOiRGhsRF3YOAT/+Fx9gbIY05beI+iOwOD4cpczg3jdRNaiLPDg0aec3fhmuLLugR3GFeK7CYAWq5O1njT+qUC6tObxfFvZVIfbk6c+I+o71Yqmq72Ni5qkIwkj60UmScOAhgN/2O3wo8ThaceNE8HkOQkOyF8k9Wrd8fH3pHFaWBcUmf7zqAZuGx/n5xZusFTjv+gIwJ5lcOgnug1gKUXTl7wyPaLr6Gbbf9AK6qix9rRxNtjP7OCCr/vMa+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gd8BhsmuGEUsqafz/i/p+zSz0iYyiadoHN1trs5agRc=;
 b=4veXKNW0j3bvcgery2clwFzcHDpJg+NK1kCFcyZg3V6uW2HvyORNGfkUMqVb9Y1h410m055e8Ra9YpT94Khy3okTbqKcLkKx1fdhem4Vuk/gFvDYQwLwk+MSiGpLyDNtlwWPRX53NJacd6GG5KpNesd9imQiC+xZMwcIIClXQgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by MN6PR12MB8589.namprd12.prod.outlook.com (2603:10b6:208:47d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 19:54:20 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 19:54:20 +0000
Date: Tue, 29 Jul 2025 21:54:13 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 17/48] hw/arm/xlnx-versal: rtc: refactor creation
Message-ID: <aIkm5cUYpDrMYYFP@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-18-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-18-luc.michel@amd.com>
X-ClientProxiedBy: LO2P265CA0251.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::23) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|MN6PR12MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: f558a6f6-e76d-4dfc-a474-08ddced9b503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3ZJbEViaVdBOGpPaXJUdmJhUTBSNlUyVmJoaHRsVGQ3cXJoK21Demoxcy9p?=
 =?utf-8?B?aEJOQ0hzUEJQV1JtVFpjM21ScGNwSDlDTm9uVHhTSVZrNmdBcjczTi9pMy9L?=
 =?utf-8?B?eVA4bW84em0wcmQ3ZUZSeDI4SzhVQkxlaVgzWWl5NDFlOFJ2MHVITjVpb3BN?=
 =?utf-8?B?WHRLa1I2c2N0c1FxZHRtZzJ5SHRybUZ0OGRoZW9ObG8vdXBWSEh5MkdTSXhR?=
 =?utf-8?B?TkROSEp3ZkpvWWlPeEQ2VXg3azNjamVMY01UK2Q3bmpmKzlSR2Vma205NW5F?=
 =?utf-8?B?Mk82SExxM3p2M1QrRSt3Q2Ixa2tyR2hHVElqY2lNNEEwY0s3bkd6aHQ2dnhs?=
 =?utf-8?B?em5KZ29YWDhXVzI1NmZVM2JjWXhXSDFlajhlLzM0enJEZStxbjAvRGJ4bWpR?=
 =?utf-8?B?MjJoakVDR2ViTXVJNm9PdWZneFRaL3hpNmFzWkk5R2JWMXg4NVZRcURMUzFL?=
 =?utf-8?B?YUZPYVA2SGMvdXhDOUxsNUh4T0RJaU04ZEhhQ3AzMjEyMitSWnU2bk0vOFgz?=
 =?utf-8?B?NWw2ZDdXVEdNMGROUkVqSmI3d0JKTmcrUEFld1M3WTh5ZFkzTWlvcW8xdTF0?=
 =?utf-8?B?ZXlDRGVyTG5WemJIUlIxS0NJd0lRb0VJbVpObG14RjFrNlZmZWx0Y0V2dy9w?=
 =?utf-8?B?UGw1SE1PZWVCS1g0NGhSV1lnN2xPU3NxbkJscyt1V2FYN04zQXJtenFxMGZ1?=
 =?utf-8?B?cEFUYndCZzN5WlMrRjhYcWVWamszS2VNb0xQUGUzVk5JcnFvSnpaOGdYMDFO?=
 =?utf-8?B?aEsvdmxXNFNxR216VHU4S3NCSVJjZnVCVW1EeFV5TmZMalhaTHQ3MlVxSnkx?=
 =?utf-8?B?NmdXL2JXOUpTNFRGOTgzV09SVnhLK2VEN0ViNUVhMkx1c2hnd0Q2cTZhS2pw?=
 =?utf-8?B?TnpqRUIvRWY5WGJrOFFZamhWckFaYU5lOURtWXRyRzZJQk4zM0tUMFIrbnlm?=
 =?utf-8?B?VkV2ZXJKMmpMS1h4T1ZVZ2VxUVRMZ2lIaHQ3NmZvTjdkSVJqSG5aV2I5bXpm?=
 =?utf-8?B?M05ydkZjdmtlYUw1Q0pPYWs0MDhpRlcxbHNYaWZNM3h4WjFpSHg5TjB3RGRH?=
 =?utf-8?B?dzBCNUdmMnFZT2pMTGRrdHNtbE1wT1JUTEFjVmdveDdwU3k5ZTJTN2lkVlBK?=
 =?utf-8?B?T08zUTAxaGR0YVIzeDB2MGU4UTBEaTdnamZXTG5yeEJnTDhpWFk1ekdvN2hq?=
 =?utf-8?B?WWJJMWorU1hJS1ZVRDhkKy93a1gzYlVSTFJ0Q1kycW1wN2xGcnBoMGJTTVZS?=
 =?utf-8?B?UG4yTnF0VlNraDlRclIyQWxEUkI1aXZoemZGV0l0SkVIN3ZnNWVabFlvdVNo?=
 =?utf-8?B?SnBUcWFOaFpsdEJyQTVIS3hiRU9kNGFtd2VaYThqVmREYXpOSGNNRnZUV1FE?=
 =?utf-8?B?UFhFcUl2UkR6N1RUNnBuZ2o1WjdZUE82bGUvR2FlbHo3ZzNCR01wb1hPUWNF?=
 =?utf-8?B?WkIwK1dMMUlaa041Z25GRnpPNkFCNzJrQlU4bUt0eHhjNG91a3hiaXZ6eHlE?=
 =?utf-8?B?N0FXUytYbStsUVlPUlA4M0MrNm9uYkdtc2dXOXlQYkI4T0YrQW1Iei9xT2Fw?=
 =?utf-8?B?MzFEN3J0SWs4RXp0VU8xNmhqblY3ckFxWDBMak5rYkxEcEV5VFhMUituSDhR?=
 =?utf-8?B?cFFjWWFtcGNyUTNzYitFTVJsTVBtdkFKbkVXZnoxL0NYTGM5dXRONkRFVk9h?=
 =?utf-8?B?ckpyOFoxQjc3aktiLzRJRndqRUtDNVRCQ0VHaURZeDhuR054ZzhSbE9wNlVj?=
 =?utf-8?B?VWljMGU4NjhJbXNVTnNIbWZPS2tFTkpsNWVrMEJYUEtJdlNkQ1FZMEZaWEZW?=
 =?utf-8?B?MDBHSnVaVVZHaXBnL1I1U21OZDFrcTkram41a2UvM0g2QnhyaE1YNlZ2Qm1a?=
 =?utf-8?B?TzBSVHpBMHF1dFU5Uk4raHhOZ0pCa3VHYjZ0a1JRd3dWcGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDJGWmtQdkNvOElpL054VDZ6UzMycngxaUkyWWhVdHRIOW9qMEltbkZKOXBB?=
 =?utf-8?B?WXlzUENwdStURXRzbWFnMlVvYlRXeElNbXZORGxoQWtFQ0hqelAvZDdFcGE5?=
 =?utf-8?B?SzF3ZHFjNkNNaThoNjU3S3lpQVlyZk51NGxnT0RVRkx4aEp3NVV1N2NkZ3RK?=
 =?utf-8?B?dmxrUHAwMFMwSVNhVlFUZDA2THk5d2ZkNTl3b2FJS2lOdHg3b1pkRkRKQ3N1?=
 =?utf-8?B?TFFVSm90MWFicXg4ckFuRjhvVlJaWHBXbG1GMHRqUjNXS3dremtaTE16U2JJ?=
 =?utf-8?B?ZEpXSVZ2NUVPZ3llMHN6QUlCWTFjYzZUU0ZCYXJCdW5RdHczd0Z6Q0FaWDZm?=
 =?utf-8?B?M3FLRnNMaFE2cHpiTThQTFAva3oxRWVuYTNsK1pBbVJwcHlKMmc0UkhYMXpC?=
 =?utf-8?B?Z29EZWRNcFFnVDZxSTd5RXZKVi8rdlg3SDkxUjRXenZJR3dXZmhRalprWUcw?=
 =?utf-8?B?ZERsK1FhNkd0MDh2Tm9tQW9vYWRmZFNJYWIvcHRJa0pWbU5EYU9GMS9jMExZ?=
 =?utf-8?B?S2pFTXdpODZkaWl5REpJVUZiaHNKOWU1KzBOUVUxc2VkTlgxMmJhR1ZPQ2xK?=
 =?utf-8?B?MWNWbjlqdkVyQllybmhFczRiMzZQUkZFdlNXWEFKVFZZbktvZ2VFNmgwTDFh?=
 =?utf-8?B?aERzVmJvazZRMzg4WVhsUzdPeitHSnFBMER4eVFzeHVUTXhZbjRhQW16N1Zl?=
 =?utf-8?B?NW9uTnRFQU03TGgraklUeTllaXkrKzNkV2F1cm9aVG5NMkozMDFVbU9kVmdV?=
 =?utf-8?B?ZjFuYlhlbWdlQ1NUSlhsY1R0U0V2VVM3empLOHNZZEUzQm1YSW1QMFJIMG5S?=
 =?utf-8?B?NjBTUVR5L0RRVnhXeVBBN3FuV1RQRlBSbFF5eEwwTDY3N3QxU2JDNHhmZlox?=
 =?utf-8?B?SFp6VmxRaVZ2cUNHamlQUnpkYzBJYWZTNjV6V0liUlFDREpZYWFwRi9BTXhP?=
 =?utf-8?B?cmtUalVaSjM2MGkwVG5NY0ZvNW5sbFpmRmVxaU5KcHhJdTJwTXNRVkdZOHZS?=
 =?utf-8?B?bVJQSURtWGw3dlMyVWNZTVd1VzhFTXdkN2Fndjlidkc2cTRORW0xWG9xNDBx?=
 =?utf-8?B?RXY0MmdBTUlMOEV1bG9EY0xOUGFQUWFvMEcrVTBKNnltZ0oxTG9CeTJaWnRH?=
 =?utf-8?B?bk04VVhMVlYyQ0d3VWFQcCtJYnAxM3ozRjFjQVVmTlZQMWFxMzhyQ2hhSk9F?=
 =?utf-8?B?VGx5a1VTbDBmS0cyeG1qalBCQyttL1BSZXRQMS9mUWM5R0FvVCsrSFFvVGFo?=
 =?utf-8?B?Z1lGYStvaGdlYU42Z3dTbDlDemdXaCttZWxBcVpmb2lYYWkxOTFNYVZ6amIx?=
 =?utf-8?B?S0RBNlNNOEt3TzhzeExudGxVaXBKMVRXbG93R1l1RGZjenVySGcybDRTNHI2?=
 =?utf-8?B?b2RWNjh2bXQwZDdYWlh4SlptcDhmTk1xbW9tTllIbGY1U2Q4RFFNOU5sV1BJ?=
 =?utf-8?B?SDlvVHVEY2hzeFdIYVBnZ1VkMGNuN2FoVHRyRTNMQ2ltSHF6c1pPaDI4NGE0?=
 =?utf-8?B?a1BsYXF6aEt0ZHI4UUI3c29KaWQwSUM4NnJaM0JmcXBTTEU2M3RxRXNBWHlL?=
 =?utf-8?B?Y1dIcnR5bWdQbW9pR2tEVTZlZ3IrbnFjWXBLbjhmREFHajhQUzlYNGZhenly?=
 =?utf-8?B?eG9MbE81Yy9uSDlsMnM1UDlPeTlYL0JxOFg5OWJSRHJ5SmVTNDVPdmZxSTBY?=
 =?utf-8?B?aHdGUVQ3Q2FnZVdqTHVjaEhYU1g1YTJRV2RVMmRiVnZ6ZUI1dkkvbXh0dkNn?=
 =?utf-8?B?NnZ2RmFOcis2eWtCaTFIcnhuTHJGSkRGNS9vUW1uTDQ0aGdhbnVMeXpNNm9q?=
 =?utf-8?B?RlpyZDFSWk9VRUtaRUxQZFZIRk5CNDg4MzlKckFmd25lc2N6bnJFeEd2UzZy?=
 =?utf-8?B?TzlqSkN5OW1PNGc1Qit5a2RIVVhkTnJESGZKTEhqMyt5M2hpV0QrZG4yd0Jl?=
 =?utf-8?B?T3RUN2swR1lkM3pVcUt3dmd6OU9oWVVSQWl2VGkzQVJRelBzWWNreXQ4Mk9C?=
 =?utf-8?B?RDc5ZXkwZG5UMXd6SjF1RDA4Mi9QUFh2Tng3YUdoSmpGR3BwTTNBN2s4NzhO?=
 =?utf-8?B?MmNoTldLTVBmL2RlSzdZUko3MnMvajRCS2sxYytlTHhJcURvaUsvZjM2VURT?=
 =?utf-8?Q?tQVWfHqTgdLsrhClBtm81XOUq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f558a6f6-e76d-4dfc-a474-08ddced9b503
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 19:54:20.2086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0wFD3TTLLZ8M2QW7yUYmOhpyNUMAgJ7gZnb90SwHPCA2BPr7lUBh3TzxKQqehHU94d5Iely2IKXf5jOZtIjgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8589
Received-SPF: permerror client-ip=2a01:111:f403:2418::628;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

On Wed, Jul 16, 2025 at 11:53:59AM +0200, Luc Michel wrote:
> Refactor the RTC device creation using the VersalMap structure.
> 
> The sysbus IRQ output 0 (APB IRQ) is connected instead of the output 1
> (addr error IRQ). This does not change the current behaviour since the
> RTC model does not implement those IRQs anyway.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h |  2 --
>  hw/arm/xlnx-versal-virt.c    | 22 --------------------
>  hw/arm/xlnx-versal.c         | 40 ++++++++++++++++++++++++++++--------
>  3 files changed, 31 insertions(+), 33 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index bba96201d37..abdbed15689 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -15,11 +15,10 @@
>  
>  #include "hw/sysbus.h"
>  #include "hw/cpu/cluster.h"
>  #include "hw/or-irq.h"
>  #include "hw/intc/arm_gicv3.h"
> -#include "hw/rtc/xlnx-zynqmp-rtc.h"
>  #include "qom/object.h"
>  #include "hw/misc/xlnx-versal-crl.h"
>  #include "net/can_emu.h"
>  #include "hw/misc/xlnx-versal-cfu.h"
>  #include "hw/misc/xlnx-versal-cframe-reg.h"
> @@ -79,11 +78,10 @@ struct Versal {
>          XlnxVersalCRL crl;
>      } lpd;
>  
>      /* The Platform Management Controller subsystem.  */
>      struct {
> -        XlnxZynqMPRTC rtc;
>          XlnxVersalCFUAPB cfu_apb;
>          XlnxVersalCFUFDRO cfu_fdro;
>          XlnxVersalCFUSFR cfu_sfr;
>          XlnxVersalCFrameReg cframe[XLNX_VERSAL_NR_CFRAME];
>          XlnxVersalCFrameBcastReg cframe_bcast;
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 2d7e8a5955a..01c230491df 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -149,31 +149,10 @@ static void fdt_add_timer_nodes(VersalVirt *s)
>              GIC_FDT_IRQ_TYPE_PPI, VERSAL_TIMER_NS_EL2_IRQ, irqflags);
>      qemu_fdt_setprop(s->fdt, "/timer", "compatible",
>                       compat, sizeof(compat));
>  }
>  
> -static void fdt_add_rtc_node(VersalVirt *s)
> -{
> -    const char compat[] = "xlnx,zynqmp-rtc";
> -    const char interrupt_names[] = "alarm\0sec";
> -    char *name = g_strdup_printf("/rtc@%x", MM_PMC_RTC);
> -
> -    qemu_fdt_add_subnode(s->fdt, name);
> -
> -    qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> -                           GIC_FDT_IRQ_TYPE_SPI, VERSAL_RTC_ALARM_IRQ,
> -                           GIC_FDT_IRQ_FLAGS_LEVEL_HI,
> -                           GIC_FDT_IRQ_TYPE_SPI, VERSAL_RTC_SECONDS_IRQ,
> -                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> -    qemu_fdt_setprop(s->fdt, name, "interrupt-names",
> -                     interrupt_names, sizeof(interrupt_names));
> -    qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> -                                 2, MM_PMC_RTC, 2, MM_PMC_RTC_SIZE);
> -    qemu_fdt_setprop(s->fdt, name, "compatible", compat, sizeof(compat));
> -    g_free(name);
> -}
> -
>  static void fdt_nop_memory_nodes(void *fdt, Error **errp)
>  {
>      Error *err = NULL;
>      char **node_path;
>      int n = 0;
> @@ -421,11 +400,10 @@ static void versal_virt_init(MachineState *machine)
>  
>      fdt_create(s);
>      versal_set_fdt(&s->soc, s->fdt);
>      fdt_add_gic_nodes(s);
>      fdt_add_timer_nodes(s);
> -    fdt_add_rtc_node(s);
>      fdt_add_cpu_nodes(s, psci_conduit);
>      fdt_add_clk_node(s, "/old-clk125", 125000000, s->phandle.clk_125Mhz);
>      fdt_add_clk_node(s, "/old-clk25", 25000000, s->phandle.clk_25Mhz);
>  
>      sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 45d9fc1e282..41965531f8d 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -36,10 +36,11 @@
>  #include "hw/nvram/xlnx-versal-efuse.h"
>  #include "hw/ssi/xlnx-versal-ospi.h"
>  #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
>  #include "hw/nvram/xlnx-bbram.h"
>  #include "hw/misc/xlnx-versal-trng.h"
> +#include "hw/rtc/xlnx-zynqmp-rtc.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
> @@ -121,10 +122,16 @@ typedef struct VersalMap {
>      } ospi;
>  
>      VersalSimplePeriphMap pmc_iou_slcr;
>      VersalSimplePeriphMap bbram;
>      VersalSimplePeriphMap trng;
> +
> +    struct VersalRtcMap {
> +        VersalSimplePeriphMap map;
> +        int alarm_irq;
> +        int second_irq;
> +    } rtc;
>  } VersalMap;
>  
>  static const VersalMap VERSAL_MAP = {
>      .uart[0] = { 0xff000000, 18 },
>      .uart[1] = { 0xff010000, 19 },
> @@ -165,10 +172,14 @@ static const VersalMap VERSAL_MAP = {
>      },
>  
>      .pmc_iou_slcr = { 0xf1060000, OR_IRQ(121, 0) },
>      .bbram = { 0xf11f0000, OR_IRQ(121, 1) },
>      .trng = { 0xf1230000, 141 },
> +    .rtc = {
> +        { 0xf12a0000, OR_IRQ(121, 2) },
> +        .alarm_irq = 142, .second_irq = 143
> +    },
>  };
>  
>  static const VersalMap *VERSION_TO_MAP[] = {
>      [VERSAL_VER_VERSAL] = &VERSAL_MAP,
>  };
> @@ -753,29 +764,40 @@ static void versal_create_pmc_apb_irq_orgate(Versal *s, qemu_irq *pic)
>                              "num-lines", VERSAL_NUM_PMC_APB_IRQS, &error_fatal);
>      qdev_realize(orgate, NULL, &error_fatal);
>      qdev_connect_gpio_out(orgate, 0, pic[VERSAL_PMC_APB_IRQ]);
>  }
>  
> -static void versal_create_rtc(Versal *s, qemu_irq *pic)
> +static void versal_create_rtc(Versal *s, const struct VersalRtcMap *map)
>  {
>      SysBusDevice *sbd;
>      MemoryRegion *mr;
> +    g_autofree char *node;
> +    const char compatible[] = "xlnx,zynqmp-rtc";
> +    const char interrupt_names[] = "alarm\0sec";
>  
> -    object_initialize_child(OBJECT(s), "rtc", &s->pmc.rtc,
> -                            TYPE_XLNX_ZYNQMP_RTC);
> -    sbd = SYS_BUS_DEVICE(&s->pmc.rtc);
> -    sysbus_realize(sbd, &error_fatal);
> +    sbd = SYS_BUS_DEVICE(qdev_new(TYPE_XLNX_ZYNQMP_RTC));
> +    object_property_add_child(OBJECT(s), "rtc", OBJECT(sbd));
> +    sysbus_realize_and_unref(sbd, &error_abort);
>  
>      mr = sysbus_mmio_get_region(sbd, 0);
> -    memory_region_add_subregion(&s->mr_ps, MM_PMC_RTC, mr);
> +    memory_region_add_subregion(&s->mr_ps, map->map.addr, mr);
>  
>      /*
>       * TODO: Connect the ALARM and SECONDS interrupts once our RTC model
>       * supports them.
>       */
> -    sysbus_connect_irq(sbd, 1,
> -                       qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate), 0));
> +    versal_sysbus_connect_irq(s, sbd, 0, map->map.irq);
> +
> +    node = versal_fdt_add_simple_subnode(s, "/rtc", map->map.addr, 0x10000,
> +                                         compatible, sizeof(compatible));
> +    qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
> +                           GIC_FDT_IRQ_TYPE_SPI, map->alarm_irq,
> +                           GIC_FDT_IRQ_FLAGS_LEVEL_HI,
> +                           GIC_FDT_IRQ_TYPE_SPI, map->second_irq,
> +                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> +    qemu_fdt_setprop(s->cfg.fdt, node, "interrupt-names",
> +                     interrupt_names, sizeof(interrupt_names));
>  }
>  
>  static void versal_create_trng(Versal *s, const VersalSimplePeriphMap *map)
>  {
>      SysBusDevice *sbd;
> @@ -1330,13 +1352,13 @@ static void versal_realize(DeviceState *dev, Error **errp)
>                                  qdev_get_gpio_in_named(ospi,
>                                                         "ospi-mux-sel", 0));
>  
>      versal_create_bbram(s, &map->bbram);
>      versal_create_trng(s, &map->trng);
> +    versal_create_rtc(s, &map->rtc);
>  
>      versal_create_pmc_apb_irq_orgate(s, pic);
> -    versal_create_rtc(s, pic);
>      versal_create_crl(s, pic);
>      versal_create_cfu(s, pic);
>      versal_map_ddr(s);
>      versal_unimp(s);
>  
> -- 
> 2.50.0
> 

