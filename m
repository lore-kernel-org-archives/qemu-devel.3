Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EF2C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Og4-0000Q1-Gr; Tue, 01 Sep 2026 09:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x1Og3-0000P5-3o; Tue, 01 Sep 2026 09:37:27 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x1Og1-0004If-G4; Tue, 01 Sep 2026 09:37:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zL8aXLoSv+VOcqxE5ES1mxskZQQnYyDiOSrsmJHb13SHZY4EK+HI2wQaKGZ9uXeFOTeM9tClerY5rt/+pnXS0G1W+gjOWfCQTiGQeyAW+QgPiWjDf/lMbADeq8jbPXC97cUI489GeEE8pV8FoFu/xVkm/cqrQGzKsRzeSDqi7x/6GFKZNfLAnRlJ1s5NVotR8Fp6PWFN41zpqM8hmHf4WovEkr8yoeD7qDOF0/tn7XBkRVdrEVFpgfKE9HLvdRLoGnkYaXO7XevHuha1NKYLVC1Mo8l3BUu9YVM5l3gSf0ey6Qz/SI5oH8NvYy2xUZG0IF1PrEQnbb/dILH0vCLp5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epejsT3/hw59sPkuSvSNnZGDZ82ExAd4Z0jGZ+L6QQI=;
 b=PKf+BY0yikMYf3tV0VjgfW6A1xKrREzwkVi1zV0WbDxHsaGOqxSrrFTtboIf5cAX/Eb4BAHIvQNKVkOPAW+SyTVxHVuM0zXXWcJURB/+o4ccMvprNaFwKZ9pG560SX6TFj5oeDxOszsDkgFydl/pivaC/3DtpkKqFcZcxmLgNPXmtp5BrojcLDVGuTdv/jkYf+9I/vRr45x+lR7OgxukiZdR6Lt1qrisWuriZOASZy0MJ9ZOPqaaaaYTPypvGPQIhOCa5QwRbHQzd4RekzYOo1Nh8EqQRCQ3jiLunzxHYBq9Ra5ASBppg+GvE3xu83nfK/DXYWPdv+X8R3Ug34FAFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epejsT3/hw59sPkuSvSNnZGDZ82ExAd4Z0jGZ+L6QQI=;
 b=D+qoSsPkc0kJv+0XugeZPkEUmUhxCLHxhs8CRIFZ7GrhuAiwiQdOkQv3pfN33n5YfGX3Z7v0ApYHsmJnzuFnaSEh552KisdwIubmw45e1nKAkWxTIX119SzhDUSUDwchcuNVTwFWT+I64HzeZiU3A/Vv24QVrbLWfu7n9S+LfrL0JVQUghH3gzvFu3pNu17xhYSsbxYRrjcbz5SekKB2DCKaRWbYQpCSBFaDwCTjq8D1KuzHUlcXOKK+/1vdamXNuuz9C/g68C3ajcr4SfrKdLgaxvG2O4tZWGnCw/BBPRp9KzhZjBy4MMkcSacVuhj7ZutwhN/dqhfMCjMesjTO8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by FRRPR08MB11965.eurprd08.prod.outlook.com
 (2603:10a6:d10:1cd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 13:37:13 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 13:37:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 9/9] block/block-copy: coalesce write-zeroes tasks
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 John Snow <jsnow@redhat.com>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260828144554.1741910-10-den@openvz.org>
References: <20260828144554.1741910-1-den@openvz.org>
 <20260828144554.1741910-10-den@openvz.org>
Date: Tue, 01 Sep 2026 16:37:05 +0300
Message-Id: <178826982594.73810.9138039014408511227.b4-review@b4>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0114.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:350::18) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|FRRPR08MB11965:EE_
X-MS-Office365-Filtering-Correlation-Id: 4762cc68-54a3-4212-82d7-08df082e214c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|23010399003|1800799024|366016|38350700014|6133799003|10067099003|4143699003|5023799004|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 3jM2Gi8EyTLKSlO2r3i2d1I4wphCdoW8jl0NDxeUim0CdPF+kN7FddUZU4Q5wil5ydYWB+aue6QkVFL2ZEFrYhIGZGmayNVacHefJ4qvWlTUcIWslAduOSkiIaC+/fhqj+i00vqHFyvMu12wH5wJjYU9R49tFntXPTu53ecgXqo/PgLMNW+6Hp2MLutyJzZ0IIWxN4KuWU8rPgVawYBCh51Jz+OVlSm2cqu6U+L/fXkKhBONqZnB8whuk7g+o2fJcs/Eum1h/kzKE/R6KG++3aD1Cf0ZR80VT/QLR4eGbLDL38Io6vsXESVqkhVFi7is6F4MX7oG2UWh1bMEpABjtpFmssr0f9T+A3e/4ybHAQjXVhNh3PZ67KzqRkRsJ0lztHEtdFF9di1TFICEXZEzuAd7H8OtRjmczBtJ9CH6wTfleRN2AKTXMS+GdY5e9GO0zEwxKsd4fENxZGVB3XGv2kqnA1miOYGH6ntnn2uU8UD9rOTy1p2GL+XxbYvrg/Ugu23cSm1u0/NrObVho52rd5iReRINzCewdrd9dFwXAiGfRjtQOPoH//c8y1ENI1gCMq4x1Bb6uSUR1VORz3FfrQxV0OuT2xlg7vzb2AsswdDlCqFgoWLZX+EnC2L5XQ0wwxEPuxf19Nfo6SjdGPJOJt6EdBMbxo5Z3iyCYCoJVivntih2QA7xwDmlcn8b5aBhlqp30fTqI6TWcFLExhmkCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(23010399003)(1800799024)(366016)(38350700014)(6133799003)(10067099003)(4143699003)(5023799004)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3JtSXUrdnpnSEJKenRxcFMrdFBzNkJiSXFqajRFRTZ3QnAzdytwQ1grbG0y?=
 =?utf-8?B?VHZZVzkvNUx1NjdDQUNhQ011SzN3WnM1NHFEYmkxd0RaenliQkhFUmsybDR2?=
 =?utf-8?B?UjI2TklqTTNxa2c3b2pqL2tUZzdOR2xNK0pENXBEYjk3VEtabEVyUmtDUktG?=
 =?utf-8?B?d3pRL1c1NUdPOEo0ZVNUdkRTU1N6eFA0STFld0xmZnBpOThJZHY0UGFFZk1n?=
 =?utf-8?B?ZFBiMUhFaE1XbDIzRWRTVjBBZGdzOFZhTXhXSmowd3d6VDhueXFTT054emIx?=
 =?utf-8?B?ZHJZYk5ONFJsdytqallvMXd6TXRONWs3SnNrL1daclFvdnMvbTlhdEZMbWE3?=
 =?utf-8?B?eDRqTVc5TkQxeitnYjdqT3I3dlJzVFZzZmVCUkJqQ1pHZDJheWpSbDIzNWlC?=
 =?utf-8?B?ZWIwZDV5Rlk4alJHQjFCemFuOTZvVXcvbktGRXg0NURhSUo0cUY0R3VDbC9s?=
 =?utf-8?B?a3g2YUgzSkQvcDdEMTVUYTRLblFlN1FmbjZ4UVRsZHJSMVM1WDM5bVpTWFVu?=
 =?utf-8?B?dlBvcXN0UGRYT3RRMEMwcVlDM0N4V1ZQUEVtWVBqMEF2bTRtMTUwK0dMK3Jl?=
 =?utf-8?B?cXVjS25abEIrYm9BMEhBWnNIWTU5RWFaTlJoR29BeStPZXJQMXRXYUV6T0du?=
 =?utf-8?B?S0JBNjJhbTFabldQVVdvR0t2bGZQZ0dSK1IvK0k5c3JyQ3VoeHJ1TTVQMWRI?=
 =?utf-8?B?YWRXM3hBT2dRUjdZNzRPa28vMVNtTGZ5MjRObE9ldnAyQlJBaEcydzdoa2t5?=
 =?utf-8?B?S2JlbUVVelBEeW53S0UycWNCaC9lblZRVkpUUjlGa1NsWkx4YTVJWEZRaWxY?=
 =?utf-8?B?SFhwcytuQU8vN0drTUFkYWpIckQ3K2Y2d0lGT0VuZ09qZkR4RG9ZaE8zZ0xy?=
 =?utf-8?B?RkM5V1FQZWNPS2x0QUhBaTVLSndoWUdOOXpDUHdSalNBeHlBcThhU09uL0FB?=
 =?utf-8?B?Q0tpdnNCRVBQSmlZTUlZQlZhVERLYTJ0N2JNWHhhbDQyTW5jbHhqMDhnODdD?=
 =?utf-8?B?VVFCTG42b1pNV3Q0dG1qYjVQTVhnajI1RXg2ellGYUFzWThQRjJSVkpQUERw?=
 =?utf-8?B?Rk9JdTVNYmxPRnF3L1VLT2ZoT3I5RDUzVGIvZzV1MTRZeG9QeGVSSVRWNE1C?=
 =?utf-8?B?VmFnRm1YRVJLdlVsSEdVZTNQdkNuenB3NXNwNDA1ZHdrT1FvcUlmdXU1T3hi?=
 =?utf-8?B?MGcvN2xBSEswN1Uxd25TWDZzTHNyeWpYMDJObGVMWVU0alZtallkYlp4cXRm?=
 =?utf-8?B?aVJDUDlmVVMrRmcrNFlQK2J2ek15TDIxdXZad0F5MmJCR3BFdVR0S05QQVVT?=
 =?utf-8?B?cWk3eHhYNUFmc25LbUs1WWc3ZDZ4Y0c1emFzaGtjTk1yL3JQY0cyRGdRZ0FH?=
 =?utf-8?B?YWFmZ0NDZWpGTkJSaG5tZ2hNNG9Fb3k2eWdOYlRIOUd3NldFSFlkMTJTZ050?=
 =?utf-8?B?ZXBXL1ZVYWhPaWltWGFIOGRTN0tDYkJMeWdGT0NzQ1hyVlRHZ2IrWkhYZGpH?=
 =?utf-8?B?ekpsWFM0VGJJdncweVJTTlRPSE45K2IyMTMzRTJ4SEVCWG1QUkVqYkRzcXZu?=
 =?utf-8?B?US92Z2t2ZXlCT2NiOElOT2srUHNlWUdhZHZlUVpNdTR2b1RpaWY5Z3Y4eW5s?=
 =?utf-8?B?V0FDQlVWdTlHZFo2di85K3NBMGJyNUxWSHA2U2tkdGNoTi9tMzdvd3Zyb09V?=
 =?utf-8?B?SUVhUzlZcVFnRmg5bFpPOW1vY05YUkU2c3ZQaUc0Z1krVmdlN1NTTUtpU0VT?=
 =?utf-8?B?YXBRVmtyZGN4SktGWEg2Mnk0Uk1scldxTm9hZ3FxbXZXY3ZxM0hoOC9hMTg3?=
 =?utf-8?B?ZnFDQktKbXhDMUNZaTNQUk1rMzU0aStyeWR2V0xvaGdEdXZhd05wWTQ0cklY?=
 =?utf-8?B?ZExRZ2F4a2U5eWRPQVpsclBFcWhBa2pLb3J1dUdXOWdnUHNxajMzUkJwSldS?=
 =?utf-8?B?U291Zml6RVhWWGVMWFYrczZReTFRa1ZESFh4eU9Oc1NQVVY0aExtN3lMSi80?=
 =?utf-8?B?eFd6NmF6ejNIeFZOSFMweVhHeU9HcW85S0JXbm96a2U0aDlrRjAzSk1sOXBJ?=
 =?utf-8?B?LzFxcGlzQzc3a2lSSERiOE1KVmFOT0IyWTNDdHMwb1RCRGxRNldqOVNGeDdB?=
 =?utf-8?B?bndzMnhGNUU2RHd2YWI3bFBUMzVzYlpudnU0Q2k3R2t0dTVSeDRWcjBDcnNm?=
 =?utf-8?B?YTZaUDVnOEdUOGtzZ2VPNTdTUTF0QlczYndtcGFrN1IxR2MrbzNJY0NsMnBj?=
 =?utf-8?B?WmlkQUJvMjd2VkJDMVJOdTQ3Q2dTUUlUU0YzK0dMMmd2V1g2UW44TUJraDdp?=
 =?utf-8?B?UGkyK2hUa1FCMUZWOGUxU01QM3lObSs2ZjUrejhjMkYyZFZUTmtRbjhVWWhp?=
 =?utf-8?Q?Xluxj0kWz4ygARXM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4762cc68-54a3-4212-82d7-08df082e214c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 13:37:13.3033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jch3rRZkUy+ssP5/3q3xh5UorVq+FW9x9f+502WnX2mfDqgP+r78bUTwcW247kGCMFpGzqGQA2bgLG8/cXmV4KWGASkkdlTvyu11bHqMUTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRRPR08MB11965
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

> Task size was capped to block_copy_chunk_size() regardless of method,
> which sizes a task by the copy buffer. A write-zeroes task carries no
> buffer, so that cap only splits one long known-zero run into a crowd of
> small COPY_WRITE_ZEROES tasks, each with its own request against the
> target.
> 
> block_copy_task_create() already decides from zero_bitmap how far a task
> may run, so add block_copy_widen_zero_area() to that decision: for a
> write-zeroes task, re-search the dirty area under
> BLOCK_COPY_MAX_ZERO_CHUNK instead of the buffer chunk size, and let the
> existing clamp cut it back to where the zero run ends. Widening is safe:
> an overlapping caller waits on the task's BlockReq via
> reqlist_wait_one() rather than observing it mid-flight.
> 
> The 256M cap stays well under BDRV_REQUEST_MAX_BYTES, where
> block_copy_do_copy() would trip assert(nbytes < INT_MAX), keeps the rate
> limiter usable, leaves enough tasks to fill BLOCK_COPY_MAX_WORKERS and
> bounds how long a cancel waits on one request. It is aligned at the use
> site rather than in the constant, since nothing bounds cluster_size.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: John Snow <jsnow@redhat.com>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>
> diff --git a/block/block-copy.c b/block/block-copy.c
> index c0a33599384..16b76484cbd 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -37,6 +37,8 @@
>  #define BLOCK_COPY_MAX_WORKERS 64
>  #define BLOCK_COPY_SLICE_TIME 100000000ULL /* ns */
>  #define BLOCK_COPY_CLUSTER_SIZE_DEFAULT (1 << 16)
> +/* Bounded by BDRV_REQUEST_MAX_BYTES, rate limiting and cancel latency. */
> +#define BLOCK_COPY_MAX_ZERO_CHUNK (256 * MiB)

AFAIU with this new cap we enlarge the range, a guest IO to which will
trigger CBW.  It used to be 1M or 16M depending on copy method, now it's
256M.  If the target is qcow2 - then write_zeroes() is size-independent
and is a simple metadata write.  But what if target doesn't support fast
write_zeroes() operation?  Then guest IO will be stalled for the entire
CBW, and the latency increases.  Please correct me if I'm wrong.

If it's true - shouldn't we probe for write_zeroes support adding
BDRV_REQ_NO_FALLBACK to the flags?  And if -ENOTSUP is returned - don't
widen zero area.

Andrey

-- 
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

