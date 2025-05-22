Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82349C54ED0
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 17:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI9tg-0004rV-SB; Thu, 22 May 2025 13:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1uI9te-0004rB-RF; Thu, 22 May 2025 13:39:58 -0400
Received: from mail-db8eur05on20704.outbound.protection.outlook.com
 ([2a01:111:f403:2614::704]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1uI9tc-0007DH-M9; Thu, 22 May 2025 13:39:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKN9pnEp7RD21fYHs4hGB3vFX0kcrY+tumQBWDiOivDnKG0ABaixioYJ7aC20OwzJKj/d34fBl6o9CngA2II/wZz8zq/zcauhQVG1K1LgRxadxwyBb+MjZ4w3nU86nqKMiSPdMETOHep1FYtBXpdKvDc91z+mw/Boljm6oa+PFWkFrBzyA5M6NJah39zrnQ39ciuG3WfFZ1tLc2Exp9y4cDrxmLfpkngFlqNB2Oi6XzR6w48iCR9a1/zYDogVDqOcUUiuxc+EtiP1Y49eV7sdGe3r1/d8cHpm2i1A/2E59nl/AIOFFO+UQOY5AZViN+Q+uirvUusB8GvKvqVKbi/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqtVekZHH7p6sqP+UCY7DKjThZTtNSgZHVLfs8vMT/w=;
 b=qXkZ90UtQ5/kUmU7Ol1kf+Jqf/mOA0WHz1c+wBBp30xNWj0KVrzbCC43BmdEC36xB2rXkwf7DKf070HoaLV60015jB5Yz/Mx5gI7QFF6hq3rjYBJmM/QfrcODNNPrpVbURj5ybPYpv3L4ua7iN8r0Ro9rGl83O7yM3sX36RNZ/KimqO6VH5Elp4m3PEhSmzBqMVAU39HYCDRBhbzJYQIrFDER7vEuyJVsHj2FRTh8fxfee/OGfpzTbBOo+pKIhKsC3b79Yvq6i6p6jKMRVd8lVXErRYQQaQVxnCZx6AV2GcJwap0UMZFslSilmW8r1F7YEqgJ+vUa29MhIBclwdhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqtVekZHH7p6sqP+UCY7DKjThZTtNSgZHVLfs8vMT/w=;
 b=ffOVKdo9AGqr5kZ77jsTTtuOqTSblLUZoIz61wsNeWwU1S4BjHA8ocjWDRrWxhol9Pxd5XW1+ndQF2tF0yAIdzJBWQN7kivuBFKqB/1lMyiGcUcjRbwmJqnjkNUmw9GMxh6P4OLbu0iufC1zVu6uDeSf6nIdnyrZOSBYFPyDY/o8l9AVPOipsyIlrkKztWiMw6E7WaPhW2qXv5Gf/WYFyYJBWIvdqSTelAdwufcyijAh7L6nFhmUSQG2vymZ7Y/ufLLI4dCG4+w11kgWIe26huOYn0ERMQoNOPnw7T07bvOjdn34WIFo9T9b5XK+n2YkewXRjLYzCPu3mlLUmikoiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com (2603:10a6:10:52d::7)
 by AM9PR08MB6641.eurprd08.prod.outlook.com (2603:10a6:20b:306::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 17:39:50 +0000
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::b0a0:bda8:8808:adab]) by DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::b0a0:bda8:8808:adab%4]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 17:39:50 +0000
Message-ID: <faa5559f-2529-4c3a-827d-5350dd3213f2@virtuozzo.com>
Date: Thu, 22 May 2025 20:37:58 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] nbd: Enable multi-conn using round-robin
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20250428185246.492388-6-eblake@redhat.com>
 <20250428185246.492388-10-eblake@redhat.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20250428185246.492388-10-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::18) To DBBPR08MB10650.eurprd08.prod.outlook.com
 (2603:10a6:10:52d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10650:EE_|AM9PR08MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: d26ebad3-9592-4d61-8fdd-08dd9957a709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eW5VMUJmOWl6b0pEYVMzZkQ5YzZaRDFwdU4zSjhMVXY4WWRLWEZmL0pibHpp?=
 =?utf-8?B?SzNZcklTejhVZWJFZWI2U1ltRVp2M0hWdU05SWNsaHRPdjhkK3RiSlc2dTRF?=
 =?utf-8?B?bkVadTdJZExJNFBDeFllTlJET0lDSUQ4SWRjUG9FM2xuS1o1TlZNNUZWRk4x?=
 =?utf-8?B?NFVKamdYZFNNSllSeTZaYXFHTVJBOVpkTGg0MTRrNlRhNzBVdUk1OFRHejJN?=
 =?utf-8?B?MTA0bXQ1WTRTcG1sZ2FsbzBIeXlJZ2RkVjJMRmtNUEtHUEl0T2dmaS9LY2E4?=
 =?utf-8?B?UnFnU0JNNVZXM1hodzlFSVJLdGVObWZlQjNNNEZyQjQwR1VSMnJvVEFuVThS?=
 =?utf-8?B?NGxzVXYrbnpwdHl5bWFTNUZFQzJ6V1AweFMwZ3VmRTBYampTYWVHbW1WeHly?=
 =?utf-8?B?RnFtSDdtNjhsdHpHNkkxVloyOStRNHFRcmtuQ1RpYncrZXR3cGRVYUhncUtX?=
 =?utf-8?B?VEFWOGdIOXRFeTIyTGtoUGhadjJnMitaQ25rZnZDbjQ0R2s2N1ZuZU9TSUxh?=
 =?utf-8?B?ZFQrT0VqUUZod3dKKzVIV0dYdktQdEZpSTVoaC9uZGhjdHkvUmJjN0NZOFBW?=
 =?utf-8?B?ci90a1pzSXN0UlFTV2FQUHZ2UlpQRUhSenE1c051SzB6VTlFUmtsdU5IeURo?=
 =?utf-8?B?anhWWjhxWDFzWUFpK3ZGTTdLNUN1NklGKzJhS1AraVV1dVVCb29uU2NCeHlQ?=
 =?utf-8?B?bTg0bTZwQkNqblpsTzhwSUFDT1R2TmNXcW42eWM4L2dJdHBMK2dFQ2R3R2pE?=
 =?utf-8?B?bXNhVy95OUJ0THdrVXUrL3lNZ3JtenEzK3RzNTlsWXROcktNcmE3UFJIZ1BP?=
 =?utf-8?B?NjVGeE82Ym9ZbWNOWDlzd2tYZzQxQkUvVFZXNXZSY0RsWWJ2SzhZU28rM1kz?=
 =?utf-8?B?dEVOUWhNamtBN2FpZEJtV3lnOEt5aFkxQ1V4T0ZjQU9NU0VQWnFVRlhvZE41?=
 =?utf-8?B?b0VjamVTRWQwZjhYaDdsRHNzb2piY3NaV0hpVHcvQWZ5eWlhMmJES1ZzUnkx?=
 =?utf-8?B?VmNYZkZFSHo5VUdSdkMxOHY3NzVkUE9UUzFwS1BvTTFnUzlaN3AxQWN2WVA2?=
 =?utf-8?B?VXBoOHQ3b0hPbXV6a2JoNVR6V3ZrRXlhSnBQZktvdzhZUkZDNEJRQm5qdVhj?=
 =?utf-8?B?anVIMDhEV0dMZmkyTnRia2ltRkptZXoxdUpEeUlLOUtzMVRjY3NvYlJGSUxE?=
 =?utf-8?B?SHcwb2JEY0V6dGo5YldpUGE5K0kxSlp2NGFCK0w4cDlkZ1FzLys0U2lNK3JQ?=
 =?utf-8?B?b2IrT215T2N0dUpkVDVwK082QUxJbE1ySG1jNHNjaXZFQ1d2M21wSVpJZVNW?=
 =?utf-8?B?ck1pa2ZZb1NWdmlGK2d6eWhvUWJWZk1ZS1JGVnNqa0w2Vlo4bGVTSmZYa1V4?=
 =?utf-8?B?OGZVSFFXYy96dllER0d6VzBBa1h3emd4bXcrRkhRRDdyWUJtbXowOUlqZm4z?=
 =?utf-8?B?MnhRYndUdTBZMjhqTm1MZTNZWG1yRkw1OFFzazdwWnFBTGNQYlVteUdBazlK?=
 =?utf-8?B?TTRmT1pCY21lekJUWHBNcUlEUm5UTlQzREFkSkIyK2hIVEwyS29TU0g2YWsx?=
 =?utf-8?B?T2tLMmd4eEJIcnVldjFBZjhFY2dqZ1ZkcFRqRkt0eldIS2NTekNqQVk1S2lo?=
 =?utf-8?B?ZE8xMzYyWHpGcWMrcWVtRnpyMGlYMXBKRTQ2U3hYbGUyZ0RZM2k5L3Z4alBt?=
 =?utf-8?B?RWV1aC9uNlEvS1hXRmFmNnY0b2QrN1JLaW9IbWJBcE5oSzA0ODZBeFRpRm0y?=
 =?utf-8?B?bWMrSkkrZmlnUGpmOW9TL1YyVHY0VWxpdk1XZXpZcmRCaTZqRkNwYlUwZVBZ?=
 =?utf-8?B?TE5UdlZ0ck9tVmZMejRWdHYxdHkwT0RZUVBpYUVqSnpNQ2kvUWZBbjlhMmdM?=
 =?utf-8?B?T2NzS2R0NGx0Ri9PV3h4TjU4bzlJSE5lS0plbkNaT0tsdm56SkE4R1Z4blFO?=
 =?utf-8?Q?/MrT4W264No=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10650.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlFGaXhjaXJERTNKamhYZG41dk9SR3NaYWttWk1BcDRJS0pkMkhBSzFpZG9P?=
 =?utf-8?B?MjJZbVBqbFE5U3IzZkhLZUNTcjRFYVRBWUxhM0JIOFVLMERSdnZNMWp4dzZR?=
 =?utf-8?B?MXl4NkNoOTFvNXlJL3VPamtLL1FwczFSZkFqRWp6cEVCNWNJa1k5YW51TFdR?=
 =?utf-8?B?QUc5R2JraFpIRlI0WEx2RUZNanpwcER4MThPM1IvdmpjWmY4eS9xcEFWQlB6?=
 =?utf-8?B?SXJBa29mcml6c1VqWTZxYWVyK0FMTnUxNmJwWnNzQk9GUmZTR1JySkVYRys2?=
 =?utf-8?B?REV6VWU5dUdMeExDMlFON0k0Vkg4L0FMVzZmeVgyY3lDbGxwSnVJdkhYTEkx?=
 =?utf-8?B?Rnh4N0R0aFBCOXprUlByUDBVNVBPRkhxTjJ4MmphdG1mUDFFYzZ3VEI1OEl5?=
 =?utf-8?B?S1dQK2YvMThwRDBOY3FUbVZEQzRVeTRqc0ZjckhmWnRhVmtOcTdYMDVqdmhB?=
 =?utf-8?B?ckhWTmo2YndVM1FTMDEyVDBqNUFCd0luczRadU9ITXE1eVNYZzludldEYTMx?=
 =?utf-8?B?UlpUcnVCQmM1clBSMEo2QndySHJOZHBla25WREdlbVZMQmV5NElNT29ERWZZ?=
 =?utf-8?B?VXZwODJmUXEvMjFrNlNiSEdkdEpwY2dJMTFCcnBwS3VNNnczZEx2aWM2MVdx?=
 =?utf-8?B?SVN6bE14OERLeDliYnczckp1RjBYQUdhM1NqTXN2RWkxRGp0WVVHbzNWT1JR?=
 =?utf-8?B?UkNibUFma1V0bzAzWkpDKzlZdzNWUXVvN2hadnRmWm8wOGRFaFYzbkRmLzRX?=
 =?utf-8?B?WjJ2WTZNbXVEaTNrMmNHenBJaWpzbXFKTnJSNS9FT05uTnI1ajhqQi9CVHJu?=
 =?utf-8?B?QU1nd2pqeWhxQ25MZGYwSGwzRGVhSHNKMGJPZnhJL0FsS1pqNHRuOHAxOFM4?=
 =?utf-8?B?MGNWSVhBcHlhdVJzdjRXelQyU3ZFT0ZvZHpmNnhBTHV0LzRWWDJRYnBFQjAz?=
 =?utf-8?B?SWVPelU5VmFKUjNyNElnUWd3enBWblBGMnZWU3BnTGlqc3cvYm4vL1VSc2FF?=
 =?utf-8?B?VVJNdlMrWlNKMUZDRDRSdCs4T2xGMXZRT0grUG9kbXdpWTZDZy9XWnd5SFph?=
 =?utf-8?B?U2M1dlhIT2E0VUo3bUlLOC9aU2JlNmRHQ1VpeFExcXZLekFVaFNOcGJGcVZZ?=
 =?utf-8?B?TDBzL1RIbkE3cURxWlJ4RkNmbE5CUmVIcm1HbEFCM1REZkRRb2tkcDVOWHdP?=
 =?utf-8?B?Mzk0V0N2cXlaVzNIUzVwRGpGNkdJYmllZVRIOGtCVzRMWVA0dG1QU0pLajlD?=
 =?utf-8?B?MXY2TElBL0JqK0t1RDZIdEZDVG5Da3hRV1kzQVJHeElKS0cvWkZaK20xdE5K?=
 =?utf-8?B?bTBCRksyYWM2Q0xYNTQyOGcvekg1RTBqT1Q5R1JkVHhGdmxiM2VxNERJdDVR?=
 =?utf-8?B?N3MvcjNnN1RmOEFXZ3dRbEJ4ZjRSeXF6dHBubTl3VXkyemswVUc4S1BQMUkv?=
 =?utf-8?B?OWNsVG84TVV1REwwVFJPMHQvK2RwS3pOM3BJSkVObE5xcGNucVEwbi9ZdHpq?=
 =?utf-8?B?VkxTQzBPdWZzNU5xRUFwRHBPZkZnSXRoM0NidzFxMzN0YXBYM0dTamFzUjZZ?=
 =?utf-8?B?ZjhFTU01V25qRjhOMkdBdU1pNEFyRHZsNFo0dU56RzJKcWxvQVJpT1VIYVpj?=
 =?utf-8?B?NmFnaDJiR0MyTm02ZzBNTHhlYk1kRnhiNjB4NUgyVGdxdFlRcFgxNk1XUmor?=
 =?utf-8?B?NXlJN2lqMzUzaVp0K0JEUmt6YnRVaklFRktnVnc1RkxzdUNxUnM2cktwUHNl?=
 =?utf-8?B?djE2UWl5bGlkZkk5clhCeUMxeTdZOVFHM0hQSjIveEhqNXRLblYzOWhSUGFZ?=
 =?utf-8?B?dWNXaS9oMXdQdHZ4Z2d4SE05MHdqZUtmSzVNVDBHNEgwY202V1BuRFh6NHNE?=
 =?utf-8?B?TWlSM25ZQTF6RW43U1VLSlIxL0dwR0ZsbVVlRVN2NnZBZDFqZm1CODZIMHBQ?=
 =?utf-8?B?ZkdFdG9mUExCTmMvZ0lzSitmSml1aUxlUEdDU3A4M3NKVVM5NTE4WndKZ1VR?=
 =?utf-8?B?dUlUU09Nb2RJU3JadC9CMkJrZzFwMmpFckk3ZFBkN0JPUHVmb3hmL1NaK1Jw?=
 =?utf-8?B?SUdpeTBianRTaUkrUHhPL0hqcHZ0Q3hxOFh5VC9NUURpQ20yQkVKTlV0YlA2?=
 =?utf-8?B?bFVsMzFSMmV1ZnlmYks1TFR3bXFER1NUVm1BVlc5QVpsWW1hY211ZWZ0U0JO?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26ebad3-9592-4d61-8fdd-08dd9957a709
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10650.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 17:39:50.1660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPeM+n9NujNcxlTxR6HGJ21V69lCCM3GRzFMQbCJxyRzEVq5qiG1s0E4Ctl8Drplr4oK0ta8Z4PVAOizxG/6dM1SHW05MwM2kqqDmYrcBAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6641
Received-SPF: pass client-ip=2a01:111:f403:2614::704;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/28/25 9:46 PM, Eric Blake wrote:
> From: "Richard W.M. Jones" <rjones@redhat.com>
> 
> Enable NBD multi-conn by spreading operations across multiple
> connections.
> 
> (XXX) This uses a naive round-robin approach which could be improved.
> For example we could look at how many requests are in flight and
> assign operations to the connections with fewest.  Or we could try to
> estimate (based on size of requests outstanding) the load on each
> connection.  But this implementation doesn't do any of that.
> 
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> Message-ID: <20230309113946.1528247-5-rjones@redhat.com>
> ---
>  block/nbd.c | 67 +++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 49 insertions(+), 18 deletions(-)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index 19da1a7a1fe..bf5bc57569c 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> 
> [...]


> @@ -2207,24 +2233,29 @@ static const char *const nbd_strong_runtime_opts[] = {
>  static void nbd_cancel_in_flight(BlockDriverState *bs)
>  {
>      BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
> -    NBDConnState * const cs = s->conns[0];
> +    size_t i;
> +    NBDConnState *cs;
> 
> -    reconnect_delay_timer_del(cs);
> +    for (i = 0; i < MAX_MULTI_CONN; ++i) {
> +        cs = s->conns[i];
> 
> -    qemu_mutex_lock(&cs->requests_lock);
> -    if (cs->state == NBD_CLIENT_CONNECTING_WAIT) {
> -        cs->state = NBD_CLIENT_CONNECTING_NOWAIT;
> +        reconnect_delay_timer_del(cs);
> +

This code is causing iotests/{185,264,281} to segfault.  E.g.:

> (gdb) bt
> #0  0x000055bbaec58119 in reconnect_delay_timer_del (cs=0x0) at ../block/nbd.c:205
> #1  0x000055bbaec5d8e4 in nbd_cancel_in_flight (bs=0x55bbb1458020) at ../block/nbd.c:2242
> #2  0x000055bbaec4ff16 in bdrv_cancel_in_flight (bs=0x55bbb1458020) at ../block/io.c:3737
> #3  0x000055bbaec54ec1 in mirror_cancel (job=0x55bbb21ce800, force=true) at ../block/mirror.c:1335
> #4  0x000055bbaec18278 in job_cancel_async_locked (job=0x55bbb21ce800, force=true) at ../job.c:893
> #5  0x000055bbaec18df2 in job_cancel_locked (job=0x55bbb21ce800, force=true) at ../job.c:1143
> #6  0x000055bbaec18ef3 in job_force_cancel_err_locked (job=0x55bbb21ce800, errp=0x7fff44f247a0) at ../job.c:1190
> #7  0x000055bbaec192a4 in job_finish_sync_locked (job=0x55bbb21ce800, finish=0x55bbaec18ed2 <job_force_cancel_err_locked>, errp=0x0) at ../job.c:1253
> #8  0x000055bbaec18f2e in job_cancel_sync_locked (job=0x55bbb21ce800, force=true) at ../job.c:1196
> #9  0x000055bbaec19086 in job_cancel_sync_all () at ../job.c:1214
> #10 0x000055bbaed55177 in qemu_cleanup (status=0) at ../system/runstate.c:949
> #11 0x000055bbaedd0aad in qemu_default_main (opaque=0x0) at ../system/main.c:51
> #12 0x000055bbaedd0b4f in main (argc=21, argv=0x7fff44f249d8) at ../system/main.c:80

We're dereferencing a pointer to NBDConnState that was never
initialized.  So it should either be

> -    for (i = 0; i < MAX_MULTI_CONN; ++i) {
> +    for (i = 0; i < s->multi_conn; ++i) {

or

> -        cs = s->conns[i];
> +        if (s->conns[i]) {
> +            cs = s->conns[i];
> +        ...

[...]

Andrey

