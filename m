Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956D7C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAxz-0005y6-2a; Wed, 12 Aug 2026 11:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wuAxs-0005rj-NN; Wed, 12 Aug 2026 11:34:02 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wuAxA-0004eY-EB; Wed, 12 Aug 2026 11:33:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZExTlxhzywmg9YBAnoCqkSvBKCUeUAe05RO1U4D3/taQLCG7ZvyCCv8astOeqh/WpNjcne6RaIclWcHGUDDTjRcGhIxyQReqjWiygjiuSVWvt580tt6WifbqOXQaXX8rd8aV+/bnAF5QJ7GTGQD0cM1p3fHEWL/Gp17zmQH2Xt0AC6i+gqLQehjPlqq8182HsJW6nbMwgdnklLWF5zoICFYlRG2jCMA/NIyuiEgqYntVUwh57jrMsI44jDWlXRySdJkDElf0TjeklM5IO8irZ8s6OugrKntIezuI5ZrRiSuquP9YOhgMFfR3ro+KGbIdCh45lXhzpnRYuAaM7Z7xEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6xIwC98rVVeOajEYh8575egp55h4HmdNFuZkC5y0Yo=;
 b=MlBpcUl5CPUIguBA6ZddVxxFG4ObddpNYcEWXQ3kSP0INsJWLyR1OhDKgk6g8l4WnGBLp5zxudMER0RFZv3kyIbKOfK3mwPkDydhwTQlEDReptitswLVaDpGlNYp9ESEuysN34Wguy3a44RuUwLcnHbQHBrBW5dwEXj3etYYNWxepdg1au+P5epVf8zqPfqzkv81B+iKXTr7N2WsgCafvZ01HftuDMCziI/+NjvZWvrJeTjYQK0J5Be4gCkrcrUx1z51zjsw5z2UmNPIF2Ga2T1HbkmDuHycjpkWCDEQ85fWW6RR9+kYsHoS/e+nVKpjCbJ4MJ7T+miuwyaJuDu+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6xIwC98rVVeOajEYh8575egp55h4HmdNFuZkC5y0Yo=;
 b=kd8gkJjw3XrUUdViLXC/Y+2Vk0m7glX/3JzAiHDhIwk8ggCDWXBfchl8JzG7qI5BB2ZRdvnGuh274cNombOAuDfxU11QZ1+F/9+ad5x4iMNT7XHh6qYJCv8SnSWesmN/u8niOV4t+0xZeOcPgVuJWaXZ1h7asgzZdhoaf+bW9Ql5J9cmcuNEhOBB2+WLr8O4YumVS7nXUC0bgqwaA/Z14RitnM8wmSyFTTFL4Buaarkq2K0zfKfHxzaFWndJSABCOgdpoM+dPekS1TBxcLSrs9Gze5r8luR6se17QoySlknqNGRbqGj7biZki7sXu9MgTODSPI1dbYMB3fpnyp57DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com (2603:10a6:10:52d::7)
 by PAWPR08MB11558.eurprd08.prod.outlook.com (2603:10a6:102:509::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 15:32:38 +0000
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c]) by DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::1b2a:832c:d136:a37c%5]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 15:32:38 +0000
Message-ID: <cd63ee9c-da92-434c-9bc2-0af1dc8cb0b7@virtuozzo.com>
Date: Wed, 12 Aug 2026 18:32:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] block: let bdrv_reopen_commit_post() report a
 failure
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-stable@nongnu.org
References: <20260811154213.184947-1-den@openvz.org>
 <20260811154213.184947-3-den@openvz.org>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260811154213.184947-3-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::9) To DBBPR08MB10650.eurprd08.prod.outlook.com
 (2603:10a6:10:52d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10650:EE_|PAWPR08MB11558:EE_
X-MS-Office365-Filtering-Correlation-Id: e15ff6a1-179f-477e-8257-08def886f0b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|10067099003|22082099003|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: uHVk+h1gQzbOU3Kjgq1fJmJrPiYMcTE8JzY7ALH1K0WFPu9GfS/R2NfvH7LgTwrOm98s68w5nvg3BFIcnjTA75pdhgjPvWBqSyhCjhUDK1wwVEXFCDYrbKp+l/OwYfqDirFvgKF3gpcTA/jEeAwh53FeDlIhVZbH4vg4b9sB5a+tt9rDT44Dh45YyyQDtvHLMZTrHt7nqzXSWBeSXcGlPBfCgBLaJHvl98llLzigohRox/NolEkA1EO3geZADc2BwXN4/Hlg/5q1PzagDw8i8gRCN1BnuLeiuJS6SDUNu8+AE2yQAQOtRbjtgBa/TntQmmVBvZsEieQ8uC9cVrp5gUNACZqF79nvstVy8VN9F4dYBLfwkASC/K5OGr6AmzRsUFLKSC+BlTFmjJogXcPpa1CfEqTf/EK5H0c1FhNOd9HFgNxdVDFYCvA/lQ+G1g9tsfECIJ47YeHAz+e39VxrnZ0m/T+yyRHYx1x7uJPAfBwuUDqFnIHueuPKxSQbHUmnQEDH/rR7L66uk7sVEs0f/3mQBsIElqPplUOOoq4G09U43lAA+l9V6IcWVfcB1C2YDe1wPPEyWoNBF7nb1J8ieA4Qxrgzj5jkj+tQVRNmdQkiFnKmwfQQq5eentWaVI+Dj5586XzZ3vo+lQaMKdVXAQ/ORYFlWF0CfjPkLwLNXwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10650.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(10067099003)(22082099003)(4143699003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TS9CWFJXMFJmOVZJK0sxaTVMbThoZ0VEdHk1ZGFITi9wWEJqei9nZEo2eEFx?=
 =?utf-8?B?aGlLd1FtUUorY2ZDdWR5Y25NNURVTlp0MnlCbFNRdUpQenNhOXRPZVJxNHpI?=
 =?utf-8?B?M0lwc285dEU2YUN3c2FQMGQ5RWFuRW9jeHA5N0hJcE0wSFl1U2xvVkR0WGdZ?=
 =?utf-8?B?NWNqUzhlbVZQcGNaVGxEWTNZR3ZjZWNpalBqQURITXFtYzRQbmd4SXlmd2Ur?=
 =?utf-8?B?UkMvcG4ya0RkbXhqTzR5UW1IL1FvajZDaU04Qm9yUmNGeGRGaVIxajQzaGU2?=
 =?utf-8?B?RlpEVVRadWNJai9JaUpEOHA5eW9HVG1CMkxwck5SNHFJelQ2eE15VXR1bVNh?=
 =?utf-8?B?dERiZHZDa0tpSllFSU42UmIrRjErRHhQdzlFbWNCM0RlOTU1MUhyd0JEbVdS?=
 =?utf-8?B?QmtGWUdnRG8yZ0tod0Z0UEgrUlhlbmdPb2twVlNaM0JQa3JSZ0wxMDdmVmlS?=
 =?utf-8?B?ZVBVR1VLMFZVZmZGdThWVE1aMkhxKzRzSHVoQ1JTNFM1aW5nSG4wNG0xODND?=
 =?utf-8?B?OW1ZN1hDVTZ1azVmMWN6b3BQTXl4L1pCUTV3WmpwcENiS2J1dnpzRmJIaUZF?=
 =?utf-8?B?andLeCtmNUl6Mjlha25HUzRpdDNUc3JoQ055TGJaWXBaTWIzaVBzTjN1ejVk?=
 =?utf-8?B?YzZwd2g0K2lzZFEwTTBrMTVkbmxpVVhJRVhtanlzTWkxZHIwL1ZXb0Q0cXVP?=
 =?utf-8?B?ZTU1K1MvTC9aQXBHZHBRY3NHcUlKcHNaYXZmYmR4YVQ4S2w0RjdEaGhVYlJt?=
 =?utf-8?B?MXdFODhhWUVBVlg5TU13YkllbWl5bklUeTNBZ0RtZkhQamRLUTFKaXhrMWZz?=
 =?utf-8?B?WUl3ZU1ONXNnb3A1a0xrR0ZJc1d5dXZ0d2VRL0cxYnBFY2w1bGd6MWFFaVNY?=
 =?utf-8?B?NjFaL25rbWE0MjZ4NmRZdmFJSUdIZmVGelFKM1pKbUFwYUFkR0lKWFUzN2pU?=
 =?utf-8?B?dmR6Y21iWGxvT3Fnd0ZUUFFvTG5XNUlnbUw4ZEdmR1RGeTBiNHVhNnhYbW84?=
 =?utf-8?B?aE8yZVhwbzhEME1sUVo0NTc1dllJa05lUVV4ckoyR053S1ppME5saXFUOE1E?=
 =?utf-8?B?RCtlYUo4ZXNNRTg5S2xkQUdpcGNBY1BtSzZ3aHl2YU9VYng4RHVBREFrRFQy?=
 =?utf-8?B?Vk5jS0Y2SlVwQUFCYlZuaHlPQmJmYWdnYTh5VEZqVjRNUVBSZGp2RnFNVGF3?=
 =?utf-8?B?c0VmTVRrL3Nxdm5Cby9FZFk5eWVyUDZWUTFMSXFPYVhwekF3Qms1NWwwU2lu?=
 =?utf-8?B?aHFMRG9uUVUzSE1UVy9CM2d5c2pjSElNM0I3WjF3SkdQODZwTWsvNkViVldX?=
 =?utf-8?B?V2lmS0wrL0s4RldZb1QxZXdZRVhRTUYzcVNPcTl1MnBRVWxpT0N2Rno1NU1R?=
 =?utf-8?B?K3JDR2libmF1ejZ0VVVaeFZabVBZZ0UzL09qMk42K2w0dFlITGdsWVVGOHBO?=
 =?utf-8?B?K3JIeWJoYlNuckdpUmF1SWE1MUdic0xyUFBLMWZKTzBUeUNSd2tJUWlYaWth?=
 =?utf-8?B?T2p3MVFpcTdpM0tKWjRIQUlqNWNFS0dIY01zcG9mRUg3aXhHVlUwREkxTWRK?=
 =?utf-8?B?bkZrYW9xUjQzZUd2QUFYdTluM2ZPMGRDWnY1R3ZmMjBIRG53WFpEOWRJTUJ5?=
 =?utf-8?B?d0ZxdUYzUFFYa0dTQTZiU0pLRmloV05uNG5IUldUVHBHNjVBekpUZm5aMlZU?=
 =?utf-8?B?VTBhWEJLTkptTldGbnA1OWVJK0NXbnk1Q0c2a0cwMUhxbGg1YlI2Ukp2K3hE?=
 =?utf-8?B?azFnMDcvSVJEeC9raHpoeTAzWUtnWmxxMVNuQ000OTZPTGJCbnY3TXBpK1ZJ?=
 =?utf-8?B?U1k0eWZWVmpYakpWTzFIWXB5KzlFMnZLRGhMWjdqMllwRHNnT0NwUk9SUUJC?=
 =?utf-8?B?Qmo1OWRDajBRVHdObi9jYUFrdy9NMFFJN1FxalVLbHk1S25UblJVeS81ZmhH?=
 =?utf-8?B?NWtGU0toNkFPZnFaUHgxbjFZQ0tTcXFFTU1PQVIyanM1cEU5OHd6ZndTbXhU?=
 =?utf-8?B?dVBUZUFYS2pLZFFQNlpwemRSNEl4RG1aYk94ckhTTmZuMnVRSFdNc2RlSklV?=
 =?utf-8?B?dTFkcUJNdTRYakhqTTg4ZUkxd0VZZmZjRDVPMXJIS3B5S1JWMDN2UEVDdHBv?=
 =?utf-8?B?WlFTMEJKNXhMVnFteVJQYVE5b0tzSTRXN2NxUC90SEhJRGpuekMxSktNbFNV?=
 =?utf-8?B?S0cxeE9OMzB3U2l6WThSOUJITEgwN0Yza2Z1Q00rS0ZMRDFnaGdDSVB0UTZ1?=
 =?utf-8?B?SnJ0U3VjSkZZdm1wSnhDR0hja1RwdW55MDJkV0UwcjUrdGxPSllTNGIwNlRZ?=
 =?utf-8?B?UHJReVlmZFZUclRHdTFSTEw4VzQ4UmRJL0lGNDdtOTNNNkdmb2E5SXE5OFFW?=
 =?utf-8?Q?2msOr0zeeZyJfYKQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15ff6a1-179f-477e-8257-08def886f0b6
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10650.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 15:32:38.1937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u40gCyQK5klBf1vNC5HRWnknYorVyhoO7fR+saCvfnC4cugZwdoYVjYl7qFjexAY112+IQvFwt3imcv8/gILndG4/+eDpRDcrc+iK9ZVNYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11558
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/11/26 6:42 PM, Denis V. Lunev wrote:
> The callback runs after bdrv_reopen_multiple() has committed the
> transaction, so it cannot reject the reopen. It can still find that
> the node it has just made writable is unusable, and has no way to say
> so: bdrv_reopen() returns success and the caller carries on.
> 
> Give it a return value and an Error argument. The reopen stays
> committed, the error only reports that the node is gone. Every queued
> node still gets its callback, the first error is the one reported.
> qcow2 is the only implementation and does not fail yet.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Cc: qemu-stable@nongnu.org
> ---
>  block.c                          | 18 +++++++++++++++---
>  block/qcow2.c                    |  4 +++-
>  include/block/block_int-common.h |  5 +++--
>  3 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/block.c b/block.c
> index f0a6042e61..99ed06f8ca 100644
> --- a/block.c
> +++ b/block.c
> @@ -4653,15 +4653,27 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
>      tran_commit(tran);
>      bdrv_graph_wrunlock();
>  
> +    ret = 0;
>      QTAILQ_FOREACH_REVERSE(bs_entry, bs_queue, entry) {
>          BlockDriverState *bs = bs_entry->state.bs;
> +        Error *local_err = NULL;
> +        int commit_ret;
>  
> -        if (bs->drv->bdrv_reopen_commit_post) {
> -            bs->drv->bdrv_reopen_commit_post(&bs_entry->state);
> +        if (!bs->drv->bdrv_reopen_commit_post) {
> +            continue;
> +        }
> +
> +        commit_ret = bs->drv->bdrv_reopen_commit_post(&bs_entry->state,
> +                                                      &local_err);
> +        if (commit_ret < 0 && ret == 0) {
> +            /* Committed already, so report the first failure and go on */
> +            error_propagate(errp, local_err);
> +            ret = commit_ret;
> +        } else {
> +            error_free(local_err);
>          }
>      }
>  
> -    ret = 0;
>      goto cleanup;
>  
>  abort:
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 1543255eba..553a94d003 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2145,7 +2145,7 @@ static void qcow2_reopen_commit(BDRVReopenState *state)
>      g_free(state->opaque);
>  }
>  
> -static void qcow2_reopen_commit_post(BDRVReopenState *state)
> +static int qcow2_reopen_commit_post(BDRVReopenState *state, Error **errp)
>  {
>      GRAPH_RDLOCK_GUARD_MAINLOOP();
>  
> @@ -2163,6 +2163,8 @@ static void qcow2_reopen_commit_post(BDRVReopenState *state)
>                                bdrv_get_node_name(state->bs));
>          }
>      }
> +
> +    return 0;
>  }
>  
>  static void qcow2_reopen_abort(BDRVReopenState *state)
> diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
> index 147c08155f..61e6621c93 100644
> --- a/include/block/block_int-common.h
> +++ b/include/block/block_int-common.h
> @@ -239,8 +239,9 @@ struct BlockDriver {
>          BDRVReopenState *reopen_state, BlockReopenQueue *queue, Error **errp);
>      void GRAPH_UNLOCKED_PTR (*bdrv_reopen_commit)(
>          BDRVReopenState *reopen_state);
> -    void GRAPH_UNLOCKED_PTR (*bdrv_reopen_commit_post)(
> -        BDRVReopenState *reopen_state);
> +    /* Cannot fail the reopen, an error only reports an unusable node */
> +    int GRAPH_UNLOCKED_PTR (*bdrv_reopen_commit_post)(
> +        BDRVReopenState *reopen_state, Error **errp);
>      void GRAPH_UNLOCKED_PTR (*bdrv_reopen_abort)(
>          BDRVReopenState *reopen_state);
>      void (*bdrv_join_options)(QDict *options, QDict *old_options);

The overall commit logic is fine, but it changes the reopen logic.
Failures up to and including permissions refresh abort the transaction,
but commit_post failure (which can now potentially happen) takes place
after actual reopen.  So now we can end up in a situation where node is
reopened, but unusable.  I think this should be better documented.

Andrey


