Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DD6CAC5A5
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 08:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzWqz-0004kY-Ut; Fri, 19 Sep 2025 04:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uzWqx-0004k5-OV; Fri, 19 Sep 2025 04:52:27 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uzWqt-00081Y-6B; Fri, 19 Sep 2025 04:52:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECFDhhsL4yczz+3hx4ZStnZUFIMtfONKMX/ypKlDru7HFtffkH8Frf0letUuH2dYIgH/lLjrGrUjl4HyZN0uOE9qin62iPkF0ENg2xSAjc/PqtXvyeU/aRV2PeL5CToDuwmAr9Gs4MshOCLomg/74byE4G4NWVdl40ZBKfQEmycrUtudDlGcfv2NL5EzdaMi3MzrAqY8Z0D5+LnXnSqERKXNm0JOv12Kpw7vXUzj2yLGkHbmzL2b8j+UMQ1VEk83SvbF3V747HCAfTpiEitjOkTVBB8OtGTY1KZzNz2kuAIu+vNS7gGdllA9t4CBrNQ/edmZMfTDGTyDkvzdpuiJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/HSPXeB45uK8pjNY2tb5P/0KwvWzYYB/q+fWezNLi4=;
 b=l4AeXuf8aU+TAzHo8NiqmHi2Hu2leodRN0bjl6x9YR/bVUX8a6nwtHDVuKh+C/cGgocYQIrQuIT6KO05KjyoEMehA3BcpURDHJSNQMPZdAJ6vgTDcpnselyBxorbQJsBV5amhsNbERBJDOHiqUQIGJ3iXyrGjGrDp8AX3amNUcWx7ApW2NQP9EiFWmx3XqNCcyBUIGaleSYhub//8aYZEUleEkUofsJ8Mb3YZzuwEpxAf5Bw/riO0D64SEnVZPXBrKY6QlURCpbrHBprsZeFKl6IHjdJJ2/ty8iqxMGPV3bzCxl1p3Y4CUo+KrF2Mgoo1gp8VtBxe6AP+ZbfFZUWJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/HSPXeB45uK8pjNY2tb5P/0KwvWzYYB/q+fWezNLi4=;
 b=KorOrwrBkRfl74bI8Nx1iWvVwW2qMNR/j4e8C9DIwGDpsHlgQR+gfhLX8FujEx/+zYEw9n+VIzUtBzjDaRQL4s3e6q2cXvvd1yyDRIhlCMX2EQ1IJm7OXNueiZCKxm67VUfIpe1Ceu4nKSpkDUyfPR883pX+5CrnL5ZJut0EtWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 08:52:15 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%5]) with mapi id 15.20.9115.020; Fri, 19 Sep 2025
 08:52:15 +0000
Date: Fri, 19 Sep 2025 10:52:09 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH 4/7] hw/core/register: remove the
 `register_finalize_block' function
Message-ID: <aM0ZufimMXvXetCf@xse-figlesia-l2.amd.com>
References: <20250917114450.175892-1-luc.michel@amd.com>
 <20250917114450.175892-5-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250917114450.175892-5-luc.michel@amd.com>
X-ClientProxiedBy: FR4P281CA0409.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::9) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1fe29e-c9a4-432c-5621-08ddf759d503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnowelVnR1B0MC9yK09HeFAxNmxzMFI2MERRRGVWNmpmZUpJcm85TkxKSW9B?=
 =?utf-8?B?ancxa1VEeDFDRnRMTGx3b3huK2V3K3FrSHF5YzZzTzljdXBieW1hSUJZQUhJ?=
 =?utf-8?B?Zk5KMWxhVVg5V1B5VTBkcUc0VUQyM3p0cnNKd2dwUGpYaGRHZTR3RTNKenYz?=
 =?utf-8?B?eDBRbnZwWjRWNjB3UW9zM0lHZjdtR05oWnRWVUVLbVBzNmZUUE9CRWU2azAr?=
 =?utf-8?B?MmRabnJvSHRzMlRVNXpNQ3dXRVNwdDVrb2p0VzI4M1dhb2tqVkJKdFpIRTh0?=
 =?utf-8?B?UzFWMEpCWmYvQmVkN1dqdVBJTnVzQjl0TTRwQUxxY3F6ekpab21Mb3BPV3Bq?=
 =?utf-8?B?d1hrSU42VGtxSFNFUlVkb2hSK09FRzBjdm1Wcm5aTlJYcmRMM3lMSFk5K2ZZ?=
 =?utf-8?B?SkZXWTJRMU5pdzVkVHRTN1pWUHVWRnJtcGIrZHB3c3ZuWS9PMEE4UUJ0OGRk?=
 =?utf-8?B?UUtIOCt2MVRwVjh0dmlyemNMN1RnSU53U2VlZ0EzUkM2WHB2RGZuLytiRU10?=
 =?utf-8?B?N29VQmIvM0VlZDZ1YWgwSmsvSHdKVVp1UGxzbkZSUFNTTUtLWWsxSW1YbGRv?=
 =?utf-8?B?WFZaWFZQcHBsTDRUeEdqdzlKSWpRNHFvT05zeGRKdlBrWXR2ZnRabDZ1UDBK?=
 =?utf-8?B?dVZwMXFBV1BtZDByR2ZiWWJIclNRQVBHbDdoSVVWdnhoanRBNHNIMTNxN1RK?=
 =?utf-8?B?dk84RUhyeEFmMFdHVWxSSWFiY25tNVBEY2xTWXdrYWVHelEvWDl2SVkxUU1q?=
 =?utf-8?B?THpkZ1hvakgzNk4vQmtRRUlLVU41UndnWFFOTU5ydWFFb0VaSVR6N0JVdGpK?=
 =?utf-8?B?TkNHTXBpNkRVUnQrSW1zZXZnYjlNd3V1ekF2OWZpNU1oRUhKeXg2b0tONE9W?=
 =?utf-8?B?TVE2NG9UdGY4YkVFbzB0QkkvWHdxQ0UrbFlITHV5UXBQTlZWVGMxb3ZvemJm?=
 =?utf-8?B?dlM4a0hlVVd5SExqRFcwM2VySHVlWXoyQzBOYWJjTmFwbkJidGRHUnFVcTVk?=
 =?utf-8?B?VlIzVUE5ZzhqZWM3eFNCaGZBNGZuR1ZGSFZvOE9XdXlNUkx3a09tRThUYnJB?=
 =?utf-8?B?RlFTckVvZUIzSjZBQXgrQjAveHUveDdpQXdJeUFuZVl4aHI4djVpNXJ5UzYy?=
 =?utf-8?B?VjFkYjN6bHVTOWpGOFU4ZjFoZjNJVzEySFlwRDNpUlJ0dWl6akdHNTVXNTZu?=
 =?utf-8?B?WEFZL1V2Q3BKR0lrdndEMUdPbzU0MWtUQi9RVGpuSU9LZTNCdUV6MlJ2NzlC?=
 =?utf-8?B?NmFSNWxmNkZWcEt5ZS93YkRBUXB0QXN5WFg1R210aFNjSS9reDViQS9GUGNZ?=
 =?utf-8?B?cGhiUXQzYzJiNkZ3dTN6bVE5SFNLSGROTnJsM3ljL0pYd0tyRnUxYTlLZDda?=
 =?utf-8?B?MFhGT2xIZ0VwOUVQRGlBMnV3ckl1eGFTZlU0NmljQjZNeVM5M3cyKzdGNkU5?=
 =?utf-8?B?Tk9tZmVzekltanRBNEswSFprbWtvSVcxL1BmemFrZkpxTEhDTzRkd05NcEpj?=
 =?utf-8?B?TG1NTm5JWVhoL1ZPUm8yMXdlcDQvWEtXT2RKSTZTM3hiRjQ5d3h3MFJzZ0JZ?=
 =?utf-8?B?aEV6bzlCaWl3Zk51SUtaaTFicVNuYUtqQnBzYzUxVmp0NkFzeHZLY1pkbEph?=
 =?utf-8?B?QTVmUjhFOXV6Tkk0SE5tL0MrdU52ZWFteTd6a1g0Sk5waXhjaERCbEpMVGxx?=
 =?utf-8?B?ME5DVmxXMlUzQ0dpUDJ1bVdITzBucnNaZlhOdzFSKytydGUwWlNDelg0b0gv?=
 =?utf-8?B?T3ZveHp6MUVwUFZTcWF0WnEzU2Y1eDNNbk9iM3ZoejVnS1Y1Y09BSE1CLzNZ?=
 =?utf-8?B?YnREbVNla3E2VCtKem04MjlaOE0raHFNZktrUW8yemtFbUpqME1jUGlxWmdu?=
 =?utf-8?B?RFp6YU1yOEU5OVJMUjZEVUxiSUw1dXlHSnBpMzV0cjMwU214ZnlFSjUwaWZW?=
 =?utf-8?Q?McpH3OU8lLM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0kzWlErbEJYZzI5dGVJZlFQbUlUeFB4S2RROVJCNHBPczZseWJ5T2dpS0NZ?=
 =?utf-8?B?eUY4QndMKzVWYUdPbkFteFRlc1dJTStYcXlIcHFnM0NTd3U3cE1ZcjFSTDdm?=
 =?utf-8?B?Mm9PZVo3cm1qajd0WjF4NzRLZ05FQU8vSU5ZS1VpSUxOK0FzTHVjM2JIMWZL?=
 =?utf-8?B?TmgveHZaUGhvWjhkUHRQQW5tMHJCd2VXZ2xQWVZRZStTa0NWWG9xREZZZGor?=
 =?utf-8?B?MkdUQ0d0MUo1YmY2N3F6VTNBSzlhNDk0cEF1K2hzRHl6bnV1MXFmc2drZC83?=
 =?utf-8?B?OGV0am1HL2psQ0kyTWUzeGozb3AyblVHays2UDRtU21WUzEwNXZRZkxCREs5?=
 =?utf-8?B?bkpSdHk5bDZOdStMSzQ2dFI5U2RQUVdDTW5XVm1Ub2lFMElDVWQrYVh6d1NX?=
 =?utf-8?B?eiszN2RsTElDaHJKWkdDdGpMQ1VYbU14ZndYMUZuL1RvbXcwUy8rb0U3Mlp1?=
 =?utf-8?B?L2VlWUwrSlJHc3ZMaGRCNG5CYXlMWjBKazlrUVlWVk1sRkpzVk94cUxHd053?=
 =?utf-8?B?NlFyNDc2eWdTME5LK3g5WGRDSzc3MnhHSFRjamRzaElxdUl0UEFQdjBINlp1?=
 =?utf-8?B?RWNnUzNjZWh5bFNTSjFRUzcyUEtUd2wyN3FGUEhTbC9OalFWcnZiNkNEKzYx?=
 =?utf-8?B?YkZReWRNUDQ4cndVMjgvTFQxZnBKaTM4SjNTRkJXUCtESTE2MXFMeFVURk02?=
 =?utf-8?B?aUl2QVJXTnVzNHJlWitMbnMzVE14cXdXbW5ZVGZkUnJQTU82NXNyMGVKNk5I?=
 =?utf-8?B?RDRjY1R3V21UU1FEVEJTS3BFdGJGWU9ocjl5RnlqOFRNY05rcnlaRlo3NUsw?=
 =?utf-8?B?RytXVTZxb2Z5Nm9VSXVwWlc1NFBGNExrSmNrWW1Kc3gvNkJKSjZ3UW81SE1E?=
 =?utf-8?B?ci83VUx4M2hnUWYybXpIRG9IakdaS01vcnY3eHpOZVN3aWNQZ21EMjIzMHdS?=
 =?utf-8?B?TVEzYTN0enBFMVVXbzNpUEp5amVkOWwxRjJWWXFzQlN5SnZiSEhEd081SGlh?=
 =?utf-8?B?MXdDVG5wcmZodGpwc2RVbThlZ1N0TDlmYUhvREdRNEVsVzZmUFpsem9uUGJ5?=
 =?utf-8?B?d0V6QysyS2l4a0l1Vlp0cjZHQXJVWGRYL1ZHcDl2UEowbkxpKzk0SGkyT1k4?=
 =?utf-8?B?MFRVVjFDMjlQSVhtZjlVWnZLZW9LSElZeEY1bVV0SVZML1FHMStmMDNNaWVP?=
 =?utf-8?B?ZFdNTG9VOHdsVGFZdU9rRzh6SUVFLzNwTnVhM29TK2hWdnZud0ZGVHVmNzhM?=
 =?utf-8?B?dDhuaTgzWGlWYS9yWnQ3blpqdjU2cFhOd2p5d1MzYjdEdlBFeE93WENpSGpn?=
 =?utf-8?B?anlYQnlHbUhWZGYzaWNlTkN3eVhadVdhZnRUY2lZbXQ4MFBiMG5nSmUrOUJG?=
 =?utf-8?B?Umt2Q1JPL0ozNVFYZkZqNjdxcDVURU84K2VQK0tHNHFjaUdaeFZPWXF2Vlcv?=
 =?utf-8?B?bmF3czA5VkhaL0JObGJNTjNpcmVYVUthR3l6YzlyVlBpS0ljbUtIUHdRVlJB?=
 =?utf-8?B?TlJSMUhhaExVZ3l1VExTZVNmVnFkMnNqdEJYdDI5Sll2alpDRTNHMzZtd29j?=
 =?utf-8?B?UE1zaFFMTG5sdks3T0RwYUFreDNlSDZhUkdvTFdKbjlmVFhKWE9BYm9vVnJD?=
 =?utf-8?B?U0pwVHV3aHRqUThVeGNTTytidVVVeTlTNjd6QlhTVGRhL0s4OFk3Z2VjeEtO?=
 =?utf-8?B?emdobThyWlh3Rjg5dDJoQ3hjMFJCaiswS1dzQnEvZm0vNloxT201L0JZTnZ4?=
 =?utf-8?B?U3BYQ2VsTFBGdnZtYjU3cHpJbkNVZkhrOFM1Yk1MSTFHN2F5b2w3NkV3TW5x?=
 =?utf-8?B?OGh4U2pCQVhveUpEUm9MZ3NRS0tSTWp0UWtTR2ZucFBsd0dMRmszU2NLWU9V?=
 =?utf-8?B?N1JSV0ZNenZZT1dLRXUxQnljYnlnUlZiUHUvMDFqcEorYkVBcGQ1M0lvblpN?=
 =?utf-8?B?cURVVjhoVkc0SDRPb05jZFJsYi9vUzh6alRNcS91WE02M1pDZHdoM0hLYTJX?=
 =?utf-8?B?MFVVRDBQSXpySEpWL3dYeWVLM1B1QWM4ZnFrcXEzaWZMZUhWcW81T3U0cHRD?=
 =?utf-8?B?MFJDRmR1NXF0V2QzTDJlNzEwamdqRGV6SVprZVowamV3bDJuaDlhcXJZZWlV?=
 =?utf-8?Q?IeumXJn2bH47TvU12twVqqDWC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1fe29e-c9a4-432c-5621-08ddf759d503
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 08:52:15.7164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlQe5lPmfXHBMZ5e4TOPHDna5eLyfGIxOHjPQyYB8SDIYdrfZ/v25zJd2ODGeWPs0AiW7EkdnKkbWg9h251b2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=francisco.iglesias@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
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

On Wed, Sep 17, 2025 at 01:44:45PM +0200, Luc Michel wrote:
> This function is now unused. Drop it.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/register.h | 14 --------------
>  hw/core/register.c    |  4 ----
>  2 files changed, 18 deletions(-)
> 
> diff --git a/include/hw/register.h b/include/hw/register.h
> index 65c82600e06..7b0f4c8b7a6 100644
> --- a/include/hw/register.h
> +++ b/include/hw/register.h
> @@ -207,20 +207,6 @@ RegisterInfoArray *register_init_block64(DeviceState *owner,
>                                           uint64_t *data,
>                                           const MemoryRegionOps *ops,
>                                           bool debug_enabled,
>                                           uint64_t memory_size);
>  
> -/**
> - * This function should be called to cleanup the registers that were initialized
> - * when calling register_init_block32(). This function should only be called
> - * from the device's instance_finalize function.
> - *
> - * Any memory operations that the device performed that require cleanup (such
> - * as creating subregions) need to be called before calling this function.
> - *
> - * @r_array: A structure containing all of the registers, as returned by
> - *           register_init_block32()
> - */
> -
> -void register_finalize_block(RegisterInfoArray *r_array);
> -
>  #endif
> diff --git a/hw/core/register.c b/hw/core/register.c
> index 4d1cce02a55..6cfcfcd2b14 100644
> --- a/hw/core/register.c
> +++ b/hw/core/register.c
> @@ -321,14 +321,10 @@ static void register_array_finalize(Object *obj)
>  
>      object_unparent(OBJECT(&r_array->mem));
>      g_free(r_array->r);
>  }
>  
> -void register_finalize_block(RegisterInfoArray *r_array)
> -{
> -}
> -
>  static const TypeInfo register_array_info = {
>      .name  = TYPE_REGISTER_ARRAY,
>      .parent = TYPE_OBJECT,
>      .instance_size = sizeof(RegisterInfoArray),
>      .instance_finalize = register_array_finalize,
> -- 
> 2.50.1
> 

