Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F2FC982C5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6rRx-0007P7-FP; Wed, 16 Sep 2026 11:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1x6rRv-0007OA-IH
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:21:27 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1x6rRs-0007xW-QJ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:21:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3sEPVp2yMIDyUpxBJJn9fWCCXGRp2vMwLLu3TBY8OMtTzhAC5wK2RTpz+3UvLNrBR/R7ZpIQ1/DoaGcKTrCLqkZqkoESQ4ODf4td9ZwWgtr4MgVLLLqPYA49LJaK67hJeQ/m7Au+viAHAjDScZXYxojJFiwjysm+o+/9m3/nSr2fLB+ccjHipEFaMIxF1TdUgZ8fvO81T//ivYceikrU28Cimni0BYjjh94KpL0dDZCAjCPWQdFvM4rz+Q7O2YvjvrWHnHhFTyPdbrygEEE7256w9maUchNbPOfhfSyMVVV4uInQEUrWEYhfVP/uN8zRH4JM6cijq2CVynxDG2Sgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIFzCcENXcuJoZJ9RhcO9wjBJr8igAt1afo1ElBIZRg=;
 b=F91i07eCfGr4zpL0MJjWz/2gC7siEyqdvWG1XHuJ8KdhSpHQDmnyCizefiCAXJYxOJYPnJ/M9DtBk14XVMD27435UN5b832Bx4d4QYRjWwFSZFM5G0MljvInZr4Bv5VMxMoX2Af9fpWbsZf7a3UAlPs1QU99zwSIxI4UqmdXlDx2O3dMYoNHJchZg9y3+dzfj4Fei3SXn0qwSfjWhbVouyDucBd7JC40lbB+9L4OdZXe1adDHtwHOtMmPbM3g669CNBPuffATdM24RW57dZzruyXtyQCIbQ6dyOBAvm4oTlLtJyucYTrrpu/cSvTY3mywyojFgpeuoobfVlt/Qz4hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIFzCcENXcuJoZJ9RhcO9wjBJr8igAt1afo1ElBIZRg=;
 b=xtHatehoydtaZ5NTcX/mpa8gk6M3az7bMCUAkwuvCrLPl9ytrV478r96a7N9QLzfREQhvJmbrm4NHzywkdaaqSiMwRdLZip63fK8hMp4EH/QXZmDGgLhbMEv1HOEJMQFsqWZdS8HrOOoP8gEgf5RDUKTkhYRY346wQpUIIbqMH4SCPb/4U/cCjWCZ63v9SivNVmp8x1/YUBApJM8387OY+DoG/s0IG2Ekp4VpRMrYcUBuFykTQ62kIs7BCv6lwyI8xfOJRzLwU8VpMZpuRHylFeekHRBPb6fkFIjj1iAAI+76qqIBgP5anuFhOLj5sOiuXfxRTsQ1Rr3fZ+hEAuFtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AM0PR08MB5393.eurprd08.prod.outlook.com (2603:10a6:208:18c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Wed, 16 Sep
 2026 15:21:19 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%6]) with mapi id 15.21.0451.004; Wed, 16 Sep 2026
 15:21:19 +0000
Message-ID: <e8984e14-fad1-4010-8b84-f1b6e1c44f5b@virtuozzo.com>
Date: Wed, 16 Sep 2026 17:21:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] migration: defer a post_load which only rearranges
 memory
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260911142345.3999518-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260911142345.3999518-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0086.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35c::13) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AM0PR08MB5393:EE_
X-MS-Office365-Filtering-Correlation-Id: 87125f7c-2936-48d3-f658-08df140628cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|1800799024|376014|366016|56012099006|5023799004|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ri/CvyJP/0CUUWYQQfDKN9O5XxXEqKa5a9pgsSeqaZ+pPUvGbcxfZoGCZLJOuRWS+5B5dkfY1+VQlqOMGHLp4EushhaeBZEQ30T/xssj8pzWyHAzT/TJKyhiOSOOWl0BFto/vwyYIImw9tUU+rYBRp7VOkLlTCx8QsUURYCPagMFxlnv8/xSbKsPk6WmilDqIbCGM469ouw1ZOtLQGI0IeduMGAQCZRAATXBW/+shwGvAZBoafXAJtOvbFvZhcyZc03c2oikBrR+mblZXlCfiIeJawu73OkTCeVHcf/O8m2/aiLuCnVODE0Zb27eRN5DjOzbZyAyGjinqfIVTFV5ZpLyxu40eEO4VaFARiC1SH0FgRDvOtvqDzMEkcMKV58cmvxze2wPAGCBp5CLnx7IskWgjHexS1D0VKipusq7JYgqjbxHys7s2wix3OZwLEKAzLOfeIncvPOmIHx5B8fAQ6LpOFr+Hh8YV9s0Cy8vWDDl874FHSRL0cJAEqevZ3rAW5e4xVPSpo/+7ColWgumcTiKnYXi4z+9dZ71TKhuAEf0WMHFhh2F0m24HKwYFh9y1gpcWl0ucQCuV/2IdSTIqnNDuRRYN/Z4SeEmzE2CnmddjEf0nLHI/ivlZS8ZFKdTZZsFAY9Cv/QypJq3IA7URS0xmliRy2ocZkEgZuXRN7I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(366016)(56012099006)(5023799004)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW9GcEhQZ21wQlI2NGRKdFNHU1NVUStFWThmZXRlWlNQaWYvNjZMdEVycURB?=
 =?utf-8?B?bFFHVzRyRkU0aEZJc2RpcUVMME9tVHp6Ty81emZ2c3RTeklkSHdBMzNPeXZW?=
 =?utf-8?B?RENGN2xvOE9sc1gwVjlXMDFPVFZ0S1ZnbjFSUnpNaFZneE1mZXByU3ZnRzFp?=
 =?utf-8?B?bmllRit4eldhOTFxdHpyb3JjbDM0c3dwZE5YRzNxZ0FyOTVoN0pCZzQwdG13?=
 =?utf-8?B?Uk55N01UNVlIem9hbHZoWUdPMEkxNUd3ZWMzZ3BXbkhhSzNqTWkrSnpNVytP?=
 =?utf-8?B?eEN1bFJQRXEzaTNaWlhxcVNTTkF4bXVUdkFGU0l3NitMMW5qcERlUjlDNHBU?=
 =?utf-8?B?c0QzMGlIcGcxQ0VkeTJDZE8rQVRmV2xFbG9UUUFnbER1N1RBSVpwN05FUzQz?=
 =?utf-8?B?T2UrSm0vKzlSOXhvcTdCZkhBdmFTU0hydzhldjFlTm5vejdDZE5yNFBuVUF6?=
 =?utf-8?B?TjkwVkpyOWpKUW1BYmNsejZVRHZKV0M1aFlDY1RLS0VFU1UxUmFRNERNai9S?=
 =?utf-8?B?cnBWSkRXcnNiVGVYdVBlNXpNYlVmU215TWxtVmViQ0Zsdjc3K3VNWjdJZWdj?=
 =?utf-8?B?NWVCZ3prdFgwQjJ3akN2Y0JVY3E3ZFdCUm9tZmg2N2xPcTk4WHkzN2tFTlA1?=
 =?utf-8?B?QXh2UGlTYUpnenEyR0FaN1JCQ1FrMVBZbFFHazNpbkp4SWQ5OEYzS2MwOTZL?=
 =?utf-8?B?cXY1dWNmaThXbmowWENmQjFSU0IxM2hsVWlTakJXSXpDTWxPa3JuVnRFeEVU?=
 =?utf-8?B?UzdvTmVtYlQ3TVdNSnBVbUZYT1Q0ZmM0T0psVzRqY2cvWmZ4KzB6ZENTZVdi?=
 =?utf-8?B?MnVjVTd0a3MvTmN6azlSTUphNjhkQ2NFL0dCL2RoNW1BY05henhVN2VCNDNm?=
 =?utf-8?B?ZFRFdnF3bk5GTWE1SnRSa1dzYjJudS9CN3lrK2YxckVVNWZDbHhtQmhNQjZ2?=
 =?utf-8?B?YmJDd2xtTnlYdXNNMDV2Q1BlS2QrZW9qdi8xb2dTWTFEQ2x0RUxFajF2cWpw?=
 =?utf-8?B?alJVb1R6QTF3OHMxaEU4a0dwWnIxOTdMY25WM25XZThVUVBYR09kVnlBYnM3?=
 =?utf-8?B?bExkQ2Rrdlc1Tnl0NmlTT2NtcVkvN3lCKzd2V3BsOWkwWDR2VmUrKzdncG9W?=
 =?utf-8?B?ZHNqOW1hbEN3TlVNb0UrUmFNUlpEejJ1YmsyNDI5dnVpZjB2bVhqNnZSY2hB?=
 =?utf-8?B?UVJVS0tSbTU1b3czaGsvT01OY3Q1T1VvTXFIWVVTZkVHWUF2d3o2ekhKcWsx?=
 =?utf-8?B?aElhd0FSUUlRZXM2Qk9xcnlqUzYwaW9ZQ3VTN1VtcjFlc2VPejNxaUg1aHN0?=
 =?utf-8?B?eU54TklVSWlKUVFxQWtzZ0k2VitMb1NRUkcxa1hXZlppNEZrSUNra2VqNEhY?=
 =?utf-8?B?dFMzTEJ4Rk5teG4rVVlrSWVBUDhTL29leTJFWFFzNm1CMDM2SWdEUTB6ekdo?=
 =?utf-8?B?TTh5d3BiY2x5anZ0WTcrRGRheEh0YkNCSjhqYjF1N0d3ZWdTUFAxUUR1eDZw?=
 =?utf-8?B?WCtkZjVYd2RmNURsOVBTZW1kZmt0Y0R2S2V2cXQ1ME5LZjJ3RlRUNFJ0U05C?=
 =?utf-8?B?Q3lHOGhGOTdLT2RlcE5CMDJSaTV4L1lEQVhJbGdGd0JRQjdKekRkMVRqRUlH?=
 =?utf-8?B?VHRHV0QwVmRXR0NpdFdaTGt4OUIwZHpiM2F5VXBuOUc5Y1F2eVZPRG5QYU56?=
 =?utf-8?B?Ylg4djZqbHR2ZlNsL3pBbHAwRzBOeWZacUw4RThpREFqZ2s3V1VGa3hLL0ZZ?=
 =?utf-8?B?NkVabDdVekt0ejZnalRJNFBPWkVVWW01amtrblM4eEc2aXZHSmtDRTA5cWlm?=
 =?utf-8?B?dE9OSWNrdHlWelNObDZFK0lFUGYwQm5jZDFMMVdYWVI5TXJqeHgvNnZobU82?=
 =?utf-8?B?akgzZllEdU1kVjdyZUxwU1dFcU1pNFd3cWlSWDFWVVNsVU56ZFRZbk5PVnhK?=
 =?utf-8?B?TUlrYTUrZDlUeUYrMG40YTF6SDl0NGJwSE5WdkIxSFo2YWVIUGl4SzU1Qng5?=
 =?utf-8?B?QjBPakZ2V1NFTXl4enhnVW5xZEFzbUltYjlVMWpLT05nd1Qrc3dIMTlpQUsz?=
 =?utf-8?B?dWxKZ1VyN2xvVnF4M1dpeTkrMnRMQXpsVWR3Rkk1MFl1SGU4TER5UlFRZjN5?=
 =?utf-8?B?Z0xwZ3JtcVk5dnZzcjFNNnZyVXEzV21SZDM0VW1NTnJucWJqa1g1ZWJnTTgv?=
 =?utf-8?B?VU9vZU1qUnNoM3hxMFF2NU4xcEl3LzIyT3BYSlZDcjcybTNHNlBhT3IrQkkz?=
 =?utf-8?B?Smd4WDdlYkRJY0Y3b0JIcHFRVHlrOFdwQi9lVmExRURCT0dWd3hVS2xSb1Nl?=
 =?utf-8?B?Zk5CcS9WSGFsNzRKRHc5SWpaQU44cHhRMUF2aXo5S3N5SzE5cmM2TXpVOEQw?=
 =?utf-8?Q?pHuLDfcTzeLF8AfVcbBF2qS6dEzYUbsierh3PvC2Ge/Dr?=
X-MS-Exchange-AntiSpam-MessageData-1: ys7TMtgYRj6PcQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87125f7c-2936-48d3-f658-08df140628cd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:21:19.8074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIe+U5gtuF3sxfCbfcRgsfpyQwjNWuEjYofKve4oD7ouhcKKjdeYuOPirvvwfxQvaX5qBy8gGNMHCzz1naeERA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5393
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=den@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

On 9/11/26 16:23, Denis V. Lunev wrote:
> Restoring a big Windows guest spends most of its destination-side time in
> post_load hooks which do nothing but move memory regions around. Each one
> ends a memory transaction, and a transaction commit re-renders every
> flatview it touches at a cost which grows with the number of regions in
> the machine. A hook which runs once per vCPU therefore pays that render
> once per vCPU, and the machine gets slower to migrate the bigger it is.
>
> The Hyper-V SynIC is the case that hurts: restoring the synthetic
> interrupt controller maps a message page and an event page per vCPU, so a
> 64-vCPU guest forces 128 remaps, each with its own rebuild, while the rest
> of the stream is still being read.
>
> Patch 1 adds post_load_deferrable. A vmsd which sets it has its hook
> queued during the load and run once the stream has been consumed, in the
> order the hooks would have fired, with the whole drain sharing one memory
> transaction. Patch 2 sets it on the SynIC subsection.
>
> It is opt-in rather than automatic, and the three preconditions are
> spelled out on the field: the hook must not fail, nothing later in the
> load may depend on what it does, and it must not read guest memory or
> resolve an address space. A hook which breaks the first is fatal rather
> than silently reported, because by drain time the source may already have
> been told the migration succeeded.
>
> Deferring is not free in general, which is the other reason it is opt-in.
> Deferring the APIC post_load, whose cost is a synchronous run_on_cpu per
> vCPU rather than a memory remap, moves 3 ms out of the section walk and
> pays about 9 ms of drain for it. Deferral helps a hook which repeats
> topology work; it makes a hook which does cross-thread work worse.
>
> Measurements
> ------------
>
> Destination-side non-iterable load, ie. the sum of vmstate_downtime_load
> over non-iterable sections, on a guest which has actually programmed its
> Hyper-V state. Five interleaved rounds per point on an otherwise idle
> host, twice; medians, with the spread across all ten rounds.
>
>   upstream                          377 ms   (363-400)
>   + pci mapping transactions        247 ms   (242-255)
>   + this series                      96 ms   (86-97)
>
> Two postings against one problem, so the whole ladder is shown. The first
> step is a pci pair which batches a device's BAR and bridge window updates
> into a single transaction, posted separately and now queued in Michael's
> tree:
>
>   https://lore.kernel.org/qemu-devel/20260903184542.2629976-1-den@openvz.org/
>
> Those two are listed because they change what a rebuild costs, and so
> change what this series is worth. Together the postings take the load
> from 377 ms to 96 ms; this series is the 247 ms to 96 ms step.
>
> Where it goes: the cpu sections fall from 154 ms to 1.3 ms. The deferred
> hooks themselves cost 77 us at the drain, so the work is removed rather
> than moved somewhere the per-section metric cannot see.
>
> The saving scales with vCPU count, since that is how many times the remap
> repeats, and with the number of memory regions in the machine, since that
> is what a rebuild costs.
>
> Guest under test
> ----------------
>
> Windows Server 2022, installed unattended, idle at the console:
>
>   -machine q35,accel=kvm
>   -cpu host,hv-synic,hv-stimer,hv-stimer-direct,hv-vapic,hv-runtime,
>        hv-time,hv-ipi,hv-crash,hv-reset,hv-frequencies,hv-vpindex,
>        hv-spinlocks=0x1fff
>   -smp 64,sockets=2,cores=32,threads=1
>   -m 4G
>   65 pcie-root-ports, 9 virtio devices behind them, qxl
>
> Host: AMD EPYC 7443P, 24 cores / 48 threads.
>
> hv-synic is the flag that matters. Without it the guest never programs
> the SynIC pages and the effect under test does not exist.
>
> Measured with a save/restore harness rather than a live migration: a
> restore from a captured stream walks the same qemu_loadvm_state_main()
> path a destination does, which removes libvirt, the network and the
> second host from the measurement.
>
> CC: Peter Xu <peterx@redhat.com>
> CC: Fabiano Rosas <farosas@suse.de>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Denis V. Lunev <den@virtuozzo.com>
>
> Denis V. Lunev (2):
>   migration: let a vmstate defer its post_load to end of stream
>   target/i386: defer the Hyper-V SynIC post_load
>
>  include/migration/vmstate.h |  40 +++++++++++++
>  migration/savevm.c          |  23 ++++++++
>  migration/vmstate.c         |  67 +++++++++++++++++++++-
>  target/i386/machine.c       |   1 +
>  tests/unit/test-vmstate.c   | 111 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 240 insertions(+), 2 deletions(-)
>
please disregard this for now. I'll come back with v2 which
will put as around 30 ms.

Flatview rebuild should be optimized.

Sorry for noise,
    Den

