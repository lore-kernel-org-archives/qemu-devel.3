Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F5ECA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 15:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xETEf-000114-0h; Wed, 07 Oct 2026 11:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xETEc-00010q-RJ; Wed, 07 Oct 2026 11:07:11 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1xETEa-0005iA-Pn; Wed, 07 Oct 2026 11:07:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSYov9l7I95VyW94vgMwkWaQk7k+J/zOCLHnzLAAJbaF5HZ5tVb0kYWJwP7CqQCXDhcj/fM9N8ZCYpICK10gMa6wgw5hooCFr1KunV/jWnxtCpcquYJabNTJwO4x1m+akPpVC7apSsIH2HbeeTFX7QsDWW8rUCVFxxqPi261Ed+VmO48jDQjWq98+2kSPEvpqF5YKRATL+X63jcx1VpIfEm/JarHwPhlT1cQjgVweFA99nQy6w4G2K4MlMw0jp5NCnAhr1nEM/O2DJ6Qfgg/MQi58E7zyN9vqxhsxj971Tzuh0r4H4+w0/HrM+qbNZn1V6XP4hPhZQTPUZvRR0VgIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWds8ny7wk1bJ2FHBS9Sd7R7izSde5wpmCkHbriWB28=;
 b=r64fD7nPzv6ErnrT4PiuaYhG4gA2aPEiHNuxjCeZ23XtwaSXkIpntPZt+jQKZlxK4uroLRSCfB8wTsFYNKYVe2Ms3OnD1GtxlLJ9jVd1Y7+csbGnmyvnKcHT/1EQ81J6Gmv+8G/3V52HxbelS6/VIz2d02TPLm/k1+7mfAGY5MHbogNxi0M0pYUA2Z6eC9+tWz0HTtWmigArRFlviBdqdyYE8xErKGzFPjO5Q3FeQISqKtC0d3FFqHR+Id68Ypd/7ogch47RGzbmVfJDLuT1R20xpW+xImmG8wL3+8uKg1860KKFxI2rwskey+436cJaNQbheHc4qlsGYCAW8sJOEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWds8ny7wk1bJ2FHBS9Sd7R7izSde5wpmCkHbriWB28=;
 b=EcXa+m5x1HjvYJmaDhLcxl58rcJQjR38wN2povtKCnzSSKaRvqBUJsNtAl6tsB4bVtixWS+yf0vWUknCNdP3Jf1A5lrsJwk3Ecngb14Bc3lWLwYLPxm5UURyWjlP08/uvaC1l4ZpjzoUEBwX3oJvYD+CKLnV4+Of13z1jPq0+M50dcnVPJRXw28G1CBVlb/bQ9k2ZvLhLLdzSYu3QX7RS0dT74vgaU6euDUv2dlJArJ+gjX1CZ3/Xpa4gLdFg0xIj1UNpL9x3uO6ddawCjgVjILs2WU0EtNUzX7hmNSDlPvuJHeaEACwLZBSIt1pA+g7KUTrxOb2lpbTm7C/T4isnQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PA4PR08MB5903.eurprd08.prod.outlook.com (2603:10a6:102:e9::7)
 by GV2PR08MB8074.eurprd08.prod.outlook.com (2603:10a6:150:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Wed, 7 Oct
 2026 15:06:58 +0000
Received: from PA4PR08MB5903.eurprd08.prod.outlook.com
 ([fe80::6ee5:76c9:a17b:7938]) by PA4PR08MB5903.eurprd08.prod.outlook.com
 ([fe80::6ee5:76c9:a17b:7938%2]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 15:06:58 +0000
Message-ID: <6144855c-f231-41a4-ac6e-b47760b7c8ce@virtuozzo.com>
Date: Wed, 7 Oct 2026 17:06:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hostmem: fix cpr-exec of VMs with bound guest memory
To: Peter Xu <peterx@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org
References: <20260924125800.4188406-1-den@openvz.org>
 <20260924125800.4188406-2-den@openvz.org>
 <cd0292cf-2a87-4716-a8c9-d87853949c76@maciej.szmigiero.name>
 <asZaCerfcnfmAlIw@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <asZaCerfcnfmAlIw@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0045.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::34) To PA4PR08MB5903.eurprd08.prod.outlook.com
 (2603:10a6:102:e9::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR08MB5903:EE_|GV2PR08MB8074:EE_
X-MS-Office365-Filtering-Correlation-Id: 24419048-0113-4616-6943-08df2484a209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|23010399003|10070799003|376014|4143699003|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 919utRFL1qzRXA0ujMnuuZn4Al9w92tIHOp6WRDoiVmLbGPDGqKLmequp16P3Tbf9p7Y1FsMmw0wS4WCGbk9GCGshKPS56Uk6afrmlaizKnr8PkC70wduFwC2QwV67h5C7pPCHMid+vDInqyudeqcoNJhljlufH36ATxSlK/C6KcOTQix7q+nlnLrbLBtPzK0Ln5XQWXCXj3HjKGSzagE1QmLFSVtPTrBgGYEPeTzPr7i17RoTmHtcAkvbGwiLlgDxaAyDgEvcFjig5GR9bQqIlHyrsZk0BFETR+NIxnmpckoaMmm2xFFcTmHibdNQ3qtx9MUHwesTbEfaN4q75cgqCCTptW5NTGFida3SIbAcc0ZRYnwBDixTrSj+DWiBuRYFz9qR/ukPvMJbC6Y+SFR6/M8S2p/ihQMsPNaDL6Yd7tEKSqlq2AJ2rAnw+hEEWIA18xvdERb6dWaDL68mK+E8jnjSM8lUp6z5GUn9LBZbA3mf1TF81e/8WscQfShi/A/PKvhpjsXtdBAa9YM5MHCnFjAahq8/uXJH/0ZgZaVAzYD2qxc/OrDM26nNrtmacifu5C0XesT5tr7BRDdhbU2Z4o5tDHJyjzINT4IMfMYSXxaTIYuBvw1ZRt+hEIq17IwdDyghNJnVZsYttLIG1j+y0avvKZA4FHIv0qPBGYavs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR08MB5903.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(10070799003)(376014)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHdaN3hBNzRoa1dJZkxIb01pVVdvcEFlY1NVcWNIdVM3SFJqWDcyZnN3UU5x?=
 =?utf-8?B?U25FMGIvblBWQ3Nwam1MbjVxbUxKcFhmTHdkakwzY2hFejNGL0M4NmkrNG9x?=
 =?utf-8?B?K2Job2NLckErUlhNcDRmNFhMYmM4Q0V4blNnZEw1U2ZQbFdVWStFeFN0M3A0?=
 =?utf-8?B?SFc2UEJ1eER0dzMvbVAvUUZNZkE5MzRja2h1VHhrQ092K2pLY0JTUk5xWmlB?=
 =?utf-8?B?OEEzaXdkZE8xZmc2SnZmYlo3WGFZT2Y1eUVHU3NoTCs4Qm1ua1VCRU05ZE95?=
 =?utf-8?B?Y0NXd0JiNTBoOFVpSUVnY21qNkFaUHVXamZzSi9zcmQxSDk5aEsvaGc2bnNo?=
 =?utf-8?B?QWcxOHFMVzdheHVXS3l5bURZT2VkdjhBMi85blNBNzllcWZJZE11R1ZZZGZB?=
 =?utf-8?B?Kzc3NDN0aWRmWW9ORHFHT0NLVlpCYmRZZVJ6V2pLM0pFNlR4UkxkOGdmM250?=
 =?utf-8?B?Vmo0b1pCTit0SFFwTlRRNjBVeWIwUUVWQzBqZFMrUFdBUmJPZ2lteHBLZmhY?=
 =?utf-8?B?NUorYmJzckFkbGlkM2l4Y1RsWGpJN3dwNmNjdUR0Z0V1QWdmMnBIalZQTFF2?=
 =?utf-8?B?SDVlOFdHQVpSWDlnNXAwZDJOMUljYkpzWjdYdFpDWUx4bmRxYi91NWVZZWZE?=
 =?utf-8?B?VFBXM3pObU8rcXZ5R3krc1hRdllubUZCbXFVM1lPZUFCZVM2c0hGTis3aUZQ?=
 =?utf-8?B?dWdrb3FhajBsOXphMDdlN2NYVjk1OHFGMEdJdUxYTkdFbFA4c2IyWkR6UUdz?=
 =?utf-8?B?SC9ESmI5dEJtNnlIc3ZMSjNBdElDeER5d3k5YVY2MUtQM3c5UUZFdFVvUjB2?=
 =?utf-8?B?Ti9NaHQweDc4RGJHd0I3dHlaaFQ3bjBjMlJSYW1kWjF4eW44amY3VVVaOXJQ?=
 =?utf-8?B?eTBEMUV3ZEFDcUtWenI2cWlTZkJ5NXhBWVVzdDZvMW4xWDNxZm5YMS9aRjV4?=
 =?utf-8?B?dmNzUnYzL0tlY0tjaUZVZXM1UGNQa1hHbjJiZi8xd2Y2Nld4VzUvODlLUldm?=
 =?utf-8?B?dEg4M1ByMk93RzBKbERZbTBzd3RsU3g0UEZqRnhDR2dXOExLOVFnZzZ2M3Y4?=
 =?utf-8?B?VzBBMEJsUHM5R3k0UFI1cWpEa2JlQW9rQ1Z0NFB4SVBXcURQS0U2UUxEK3Vm?=
 =?utf-8?B?STMyeHQ1Y1ZVam9Sdk1vMksxZHBwMTJRakwxc1dvVDlrTTl1YWt6aTR5QW12?=
 =?utf-8?B?V2xUMFF3S3BwMEt3KzB5djl3OEZsdFNQT3lLcDNMYUJrNUNpbXBPbDM5VHZj?=
 =?utf-8?B?OGZiTk12VVRHMWEyQm1oVWZBUS9NNDI2QnRPQllHQlQrcFJXejN0L3hmaVVp?=
 =?utf-8?B?d0FuUTFjZi9LQS9jUkc4bFVvd2NPcnkwK3hMWC9JS0FsNmVJZFIvVGFhS1l4?=
 =?utf-8?B?L3JlWW5JYnQ3UXFwTk5mdDk3ekJCaUVZdUVtK2FRcFpHM1FkLzdjYUpiMjMx?=
 =?utf-8?B?YVlwT3dxalJWUkxzS0xTTk9xN3pESW1ybWNPVXhuUWRQR2ZTR21FdThvTjlU?=
 =?utf-8?B?cFdZd3REcFBueXNPL2d4S2hjNndpbEZOYnJkY09aazRiT3REL2xSVnFPSnpG?=
 =?utf-8?B?ZTh6c1Jmemg0ZzdtajFFVWtnSmM4enNWRThQV1RaKzdtSk5nNlVpT2kwUEpD?=
 =?utf-8?B?SThiL3JxSEFFem5MVlhPTHUrRFlKa2VIcE9Yd2VObGpiSkVzSXovLytGSU54?=
 =?utf-8?B?cUZGWHdBV2JFeU8vaTlWeStpeFMwV3FLdTlsMmRJb2ZvUlhhc0o5SVo5c0JC?=
 =?utf-8?B?Yzk5SEpMbSsxNG44YkY4cDlZNmRBVEEwc3pBM1VUYWF4VmNYM2YwM21nZFM3?=
 =?utf-8?B?UHpodzB5WFZPaHJ1ZDVsSzMzbkxBQXNJNHZ3aEFWbmRGQTBoc0NBYmNHTDRC?=
 =?utf-8?B?Tm1iejg5OEppWmxaM2h5dnNpNzJXdlVaQmxWelk1ditNMTB0amZFclQ0SnE3?=
 =?utf-8?B?bjhGVWVXcUFBc2tkdnIxUTV5YS93cU55MUd3R2h2NXJEcVczOW1vaGVjbFA3?=
 =?utf-8?B?VEhZOVU4blhKaGVpaVh3N3FqMGpTekdQVUowWElCQlVKYTZjOUQyM3Z6SXFq?=
 =?utf-8?B?RU1Tdjc4YWtjQzd0QitFT0lkZHBIRkUxVVAwakpxS2JlejdvdWFWejc0Y2xv?=
 =?utf-8?B?RXVuN2pWamsrQldqb25ZSDZ5VXR0TmpXSk14Rm1MejQ0QXJXL2pzV2V2bWxy?=
 =?utf-8?B?c2kxb3dYTlREempoajV5MGJySEtqKzU4cUVLTisrR1hpSWFsdy9PWjNobTgx?=
 =?utf-8?B?QUl4UTlOYkVZRGJMSlNCYjEvRlFRcC9EVG5lVXlOWWJKTldwbEhmQ0RQUlQw?=
 =?utf-8?B?YXVKbGRkWlVPY1Nodm9nUlVUeUVQTlhXV0d2QTR2a3lHL2c5cDFSTjh0NDNy?=
 =?utf-8?Q?Sb1DmPTF5TyTSfiz/Bcr2a3rxBhlTOioD93xxA+/glPGT?=
X-MS-Exchange-AntiSpam-MessageData-1: ANz0DWa1ck1SbQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24419048-0113-4616-6943-08df2484a209
X-MS-Exchange-CrossTenant-AuthSource: PA4PR08MB5903.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 15:06:58.5017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ftMAEkfgzwM+FOk8UtzBSBuH1x1YjeQfvy4AiJGXbvZ7oj7AQ347dLsHG4KZ0J0jTTc+f/lzB+TyYw7qYM/5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8074
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=den@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

On 10/7/26 16:41, Peter Xu wrote:
> On Mon, Oct 05, 2026 at 09:00:47PM +0200, Maciej S. Szmigiero wrote:
>> On 24.09.2026 14:57, Denis V. Lunev wrote:
>>> From: Denis V. Lunev <den@openvz.org>
>>>
>>> cpr-exec kills a VM whose memory backend has host-nodes when the cgroup
>>> no longer allows those nodes.
>> What's the use case for starting a VM with a limited set of allowed NUMA
>> nodes for its RAM backend(s), then moving this process to a cgroup that
>> excludes all these nodes?
>>
>>> The old QEMU saves its state, the new one
>>> exits during startup with
>>>
>>>    cannot bind memory to host NUMA nodes: Invalid argument
>>>
>>> and the guest is lost.
>>>
>>> Guest RAM survives CPR: its fd is passed to the new QEMU or its backing
>>> file is reopened, and the pages stay where they are. For shmem-backed
>>> memory the policy set by mbind() lives in the shared object and survives
>>> as well. host_memory_backend_memory_complete() treats the memory as
>>> fresh anyway: it calls mbind() with MPOL_MF_STRICT | MPOL_MF_MOVE and
>>> preallocates again. cpr-exec keeps the PID and the cgroup, so if
>>> cpuset.mems has been changed to nodes outside host-nodes since the VM
>>> started, mbind() returns EINVAL and QEMU exits. Where it succeeds, it
>>> only walks or migrates pages that are already in place, while the guest
>>> is stopped.
>>>
>>> Skip the NUMA binding and preallocation on incoming CPR. The source
>>> blocks CPR while any RAM block cannot be preserved, so every backend
>>> created in this mode is an inherited one.
>> Are you sure that CPR incoming QEMU can't be launched with additional
>> "unused" memory backends?
>>
>>> This covers cpr-transfer too,
>>> where the new process may be placed in a cgroup that does not allow the
>>> original nodes. For a file backend outside shmem the VMA policy is not
>>> restored, which affects only pages first touched after the update.
>>> Memory added after the incoming migration completes is back on the
>>> normal path.
>>>
>>> Fixes: 2b7e9739fad8 ("physmem: preserve ram blocks for cpr")
>>> Suggested-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> Cc: David Hildenbrand <david@kernel.org>
>>> Cc: Igor Mammedov <imammedo@redhat.com>
>>> Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>> Cc: Peter Xu <peterx@redhat.com>
>>> Cc: Fabiano Rosas <farosas@suse.de>
>>> Cc: Mark Kanda <mark.kanda@oracle.com>
>>> Cc: Ben Chaney <bchaney@akamai.com>
>>> Cc: Steve Sistare <steven.sistare@oracle.com>
>>> Cc: qemu-stable@nongnu.org
>>> ---
>>>   backends/hostmem.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/backends/hostmem.c b/backends/hostmem.c
>>> index 02846b597d..26c7fce1cb 100644
>>> --- a/backends/hostmem.c
>>> +++ b/backends/hostmem.c
>>> @@ -24,6 +24,7 @@
>>>   #include "qemu/madvise.h"
>>>   #include "qemu/cutils.h"
>>>   #include "hw/core/qdev.h"
>>> +#include "migration/cpr.h"
>>>   #ifdef CONFIG_NUMA
>>>   #include <numaif.h>
>>> @@ -365,6 +366,10 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
>>>       if (!backend->dump) {
>>>           qemu_madvise(ptr, sz, QEMU_MADV_DONTDUMP);
>>>       }
>>> +    /* Memory inherited over CPR already has its pages and policy */
>>> +    if (cpr_is_incoming()) {
>>> +        return;
>>> +    }
>> TBH silently skipping all the rest of memory backend
>> initialization makes me a bit uncomfortable.
>>
>> First, it effectively silently ignores the memory backend
>> NUMA setting on the incoming CPR QEMU.
>>
>> Second, it also skips the backend preallocation step below.
>>
>> Instead, would just turning the mbind() hard error in
>> that case (on CPR inherited backends only) into a
>> warning make it work?
> I agree on the questioning of the use case, and I think we should
> understand that better before silently skip some failures.
>
> It already sounds like there's a mixture use of ways to do numa assignment
> to me.
>
> IIUC host-nodes= should only be used if static binding is desired, I don't
> think one should change it, e.g. qom-set doesn't really do anything live.
>
> If flexibility is needed, cgroup seems reasonable, but then host-nodes=
> should be unset, AFAIU, otherwise there's the involved question of how
> cgroup manager can talk to QEMU's manager so as to update that field.
>
> So to me, the real fix is if memcg used stick with memcg, set whatever used
> to be host-nodes= to memcg upfront, then tune with memcg forever with no
> host-nodes= parameter.
>
> Thanks,
>
The problem is that we come to this situation with
OpenStack on top of libvirt and only after that
we see QEMU, which is just obey rulez from it.
It is very complex to say how we are able to reach
this situation in the real life. My problem is that
this case was not alone and we get a lot of VMs
died on this update (around 30) when QEMU has rejected
bind in production.

QEMU can not control this (command line arrives from
libvirt) and just dies (almost silently).

I understand that this is difficult to argue and the
kludge is not fine, but crashes are unfortunately
real :(

Den

