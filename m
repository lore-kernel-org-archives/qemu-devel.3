Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E2ED75E3B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 13:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tETIe-0007Mm-OB; Fri, 22 Nov 2024 08:02:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1tETId-0007MM-HF; Fri, 22 Nov 2024 08:02:15 -0500
Received: from mail-bn8nam12on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2418::606]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1tETIZ-0004Dw-T0; Fri, 22 Nov 2024 08:02:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVEEbNsFfat/SQp7vC0JcNJgI34s4jANEl4RuSeih8mt6WVL5TRlmeUH5Mlpfm+K4UjTyCXCmSTMiCCSiBcSYSooHbvhRlyPHoebwmvBP77lefc0g0gKvaNhpUrDUK2Gs93n/SwvgRWjzFmcLSkCkfFMyQsFH16irzd74GsDDfHoD8V2aWDqKteotiWXSHFAm/SoliVcWJHe+KzCOp2cUa94z0+4VbjUJF2IQfijWo4CyM6UGkDZKd1suKImMRrW6RVB9hKA0U+HWOXclQvM6YmAjcolgMzCXMuXVuIFSrxe6cH20cce59l1r0aonF+lV41qHK+KkA1HmIN3KW6vZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQgBr32Z1W5AYXAGhBZZNgjlXspFRHL2gtEop17wnKU=;
 b=r1pUJK77yBwUFNoeWHMHYwStaBqTfjfVFXIqyHbNpNKVzivYprHZh2TDxjTAHq1QvzVQaDY/T2dk90Gpn+1Ilqv1kWAT4rFbLf6MK4QeNpx3wGoVwofzRiyFmz05WHgqAbq1pe3Baou+Y9pbaD8fMqwTT8rYOMrB/5Gy5aTbOaPhFgiJuquHXh8c//ulVMH2pP4qx7/X11cqzozKuyNmPk9dw4Mf0S4PWKPz4mxUOJGSfwW8xDsjJfd7XCowWcsUxS2MdFJI4Wc/4KPSjY2Rxc9wXm9dBUDjipQaKie0Vom3B5T76QIinFOauHdE1A3BMV/gNaJ+pVgxcvFThfra3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQgBr32Z1W5AYXAGhBZZNgjlXspFRHL2gtEop17wnKU=;
 b=BXMCqVmx4oDMOJR24m6GoqFQ+TxV6Sb2q3Aad6CGpx7XGoWchHmzsoM/CGAQ7ZfkBaFrN1kvbeussgLify3YL1aWT5piPaKTTGNC+X9uscP6PdVP2t4v6samB5oEEVIx66Qvt4IgC8XMHqYwiKeCvqnAd+uwuZJqqLpqjyB0pwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by CY8PR12MB7266.namprd12.prod.outlook.com (2603:10b6:930:56::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Fri, 22 Nov
 2024 13:02:03 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%4]) with mapi id 15.20.8158.023; Fri, 22 Nov 2024
 13:02:03 +0000
Date: Fri, 22 Nov 2024 14:01:55 +0100
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair23@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 'Simek Michal ' <michal.simek@amd.com>,
 'Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= ' <philmd@linaro.org>
Subject: Re: [PATCH v4] hw/riscv: Add Microblaze V generic board
Message-ID: <Z0CAw2BK4kk2vpL5@xse-figlesia-l2.amd.com>
References: <20241119144956.728384-1-sai.pavan.boddu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241119144956.728384-1-sai.pavan.boddu@amd.com>
X-ClientProxiedBy: FR0P281CA0217.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::9) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|CY8PR12MB7266:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f9ae095-2417-4529-da62-08dd0af5dba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rm5SMEFSOWdOYm1XZ3VJOGhhY1JncmlmSG5JbmJBblpZWENJTTZhbVVLcEJo?=
 =?utf-8?B?QnBQZTBBZHlhVHZlUHVpZ0phazJJeGpYbk40UDV1V0NNVU5mdi91SmE5bnhR?=
 =?utf-8?B?UFkwbE1WOEVFUmNIbzJRd2hRM09qK3p2RGx3TjUreHlOaDJkeFd1TTZpa2c0?=
 =?utf-8?B?Y21ua1ltSXRoVlVVb1pNc0hVUGN1N1ZsZ0dSMTRoQS9MajgyMldENURGRWpS?=
 =?utf-8?B?RWZXSG1LVFA3RDRNUmE4UUhGblBITWlWQVdXb0ZERVoxcFVwekNQdjczaks4?=
 =?utf-8?B?aFlyL0FDb3hxbkVFY0Y5VGlVbU9QQkt6QnFoWW5HbUJ5QVhLeGxNV2JEMXMv?=
 =?utf-8?B?UjNQWlpQaHVmNEFWOGR4OWpJdWNGUkRxNEI4V1praUlFclh6N05WT0w4ajFx?=
 =?utf-8?B?NnFyckJFZDNqNTVwd2dDejNBdFJIbVovczN1WlArMCtjWE9MZVc3NzJNMFJz?=
 =?utf-8?B?REYzQkgvMlRoWWhXT3FkVXkzQVBLalJiUTNKZW1yRGFPS0dVWlNCNzVoTEFW?=
 =?utf-8?B?WlVKKzJhd0ltMnNMeEZMWHg5bFJxUTVEdHBsbzMvd3FZb0k4eFZFZzhoa3hB?=
 =?utf-8?B?cEpmNlRrb1V6ZnFNYytFT3ZUYndyczVqK3lLbVlmYUxFVThuam0zb3Bob0hM?=
 =?utf-8?B?Skl6NVZYcXNvUmFOdEhxdDFQL0x3VC9oSzhyN01KbzNiQVhET3ZvVUh1bnQy?=
 =?utf-8?B?SnRwUStaT1NCRmVMbTF5SHFENVlheWxEMm1xb0tVRE9iMHNzdnZnNW10RlFQ?=
 =?utf-8?B?REdyUnNkSFFISDNpRnZEUS9YWGxvSzhncy9Vdzl1YVl2MkpXVHFnRTV6RXV5?=
 =?utf-8?B?U04yOVRmQ2ZWZk1yMVZtc0YrWHE3dm1KdUcxQzJkVW5Va0huaDdCcnJrVFhp?=
 =?utf-8?B?bityZVVQT2EzQ1N4VmFIenJEenlIQ3JTWFlyaFJRWXEzQURGd01PWC8zMDRR?=
 =?utf-8?B?TzloWExFaTlKNUtaRHliQ3FOVm9IMCtYU2wzV1NjVnMwZVZ3WlFUdlhGNXgw?=
 =?utf-8?B?NmllQTJ4S09CZHdkMUU3cUhPUVVwcEpMTk1CbWl2ckNFL2ZCQytjUVNNemVn?=
 =?utf-8?B?SGlUc0VZZ1hsUzRRNzZGQjl6Sk40K2YwQmdaaHk2cFJZVVZKWVZqT2ROelpz?=
 =?utf-8?B?Y3BJOW5ya0w0TnhncUluSTh1SWdFbmFuaUg2ZTJlcmlVK05jdVIxejRYOXZs?=
 =?utf-8?B?KzZDOCtsNjBvT3BsRmx0ekN5LzFDNWJ6ZWprazcvbzdyYTJ6RGQrUU8wdlQ3?=
 =?utf-8?B?dlpYcDdlSVYyV1lJMXh4RWU4RXRwQi9UdU5jM2Via2kwd1dFNVdqTU94OG9m?=
 =?utf-8?B?RzZCbXZra2lCVXIraFFPV08xQVB1cnZwUy9YVmVwSFdZaDlhYkhmb2VJRVQx?=
 =?utf-8?B?ODltTFArNFIzWENKTngxTWxjZDg5dEdaamZTT0U5VDk0bEd5aGJmZmwwZU9r?=
 =?utf-8?B?TjZrd00raEhNeXBka1pONmIxVEVPcjg4dUZUTTI0aWhRSWRQUlFxMk0yMkZx?=
 =?utf-8?B?SGM4VmJuci9sd084S2t6UGQ2ZHh0N2pBK1FDeGh1S2RpWDBZSjFTRHFySGda?=
 =?utf-8?B?NnJLeTFERmVGMHo1L0JFODM1M3d2bVRtWnBoU0l5bWpRRkhnd0VPZTNUZ1JH?=
 =?utf-8?B?a0lHaE1KS2JDVVYvWWtvemIxazVhb2tVZFp2MStQZ1Z1WGh0ZHEwVmN0WXhN?=
 =?utf-8?Q?vaEb9zI0hf0QoQPQiWMm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVZFejE0SmZrODZVZFJrL2RuejlicmJzL05zN0gwWVJYYncwT3F0QzlyNU9H?=
 =?utf-8?B?WVFaUFRsaXgvQTlQdGJsOGhJak9VbDdScU5sbm5zbkpqTGg4NjRUNEY4bGpK?=
 =?utf-8?B?c2VnZ2tGOVNUTG9va3E0WDNQdTJXcXBseS9zeUNTeDhQaHhxckIrR1JVbTBQ?=
 =?utf-8?B?U1FoREsxWENCbWNBZzErKzBwL2YyNFBSY0twWjM5WFNPY3VobFZ1SUVLNlpE?=
 =?utf-8?B?bHBhM0FDZ3pGbGI5Z0xqK3VZYWVIcHJYNmFOWTlzWlFyV1JvQTdBOG5OdERr?=
 =?utf-8?B?VTcwcWxhL2dCQnJ2a2t2T0s3N1BpZ1ZrajcwTXNkSEFqV3Q0Tlc1MXhLTHpF?=
 =?utf-8?B?NXQ1SzhwM3ZwVHZrb1hvVEw2NGVSYnRxdjc0TTlLanpPMjVadU5tek43cHBU?=
 =?utf-8?B?a0FUd2JUaHNVNWQ4N1VBZzhZMCtJQlcrcmV2Q0FYRmtiTlJvdGhqOURTbFMr?=
 =?utf-8?B?L1pTZFVZSk5wMmdBRjZvNnNwNUVDMmIvWGliVGVuQmhSNGJtWnV2WXIzaWUy?=
 =?utf-8?B?ck1adXBmeWNCRllQNmkxbjFnTzFSMXN6YlJpVVBYK1Y0dHNtaHhCRnVVM25o?=
 =?utf-8?B?K2FBTFRGd0pUZkxYR08zdXpjME0zOEdxbllmaFhDQ0pBckJCMlJCWnhMQ1NV?=
 =?utf-8?B?VWZrU3V1RExPanVDWXpZblY2YktXc1N4V0NpcThyaURWZnNFWlhCRG1DYjFo?=
 =?utf-8?B?OGRrOEVHZjFKd0tHbmROVXN0eU9TWk50ODIydFBlaTlqOGgxRmVWSHl5TVhn?=
 =?utf-8?B?RHFSZzY0Ni95QU5TMzlmQit4ZmNFYzl1Y21Sd2dlRDNTa2ZPUGJuYTBJN3ZU?=
 =?utf-8?B?VlNuWWRzOVpuY3NaVUQ2K1l2NVRKQnFIOGM0VGVVUHBYQjhXWFFQTks3RnZ0?=
 =?utf-8?B?VDYwSWRpUjFYajIvTE9OeFF5MkV5Q0dRZytyODd3RkJwMHpzaWE3RmdIZk8x?=
 =?utf-8?B?Q1grU0prWk13bDFtZUVoRlo5Y1R5QXBqaVBMYjlNODcvN2lwbTNqSytQTmgx?=
 =?utf-8?B?cjc0UXRqM3FNeVFTdTVxbXhCK3M5ZTV5NzVXLzRJMTFIOGpkaS9Da1ZZNjlP?=
 =?utf-8?B?cytMaHlWckYwejFKekk2Mm8vbWtaK012Yyt6cTlTbkdSb2dqZzBzN2trV2ZC?=
 =?utf-8?B?ZGVVTGJLNWRVUjRWSFRlWVV4SFRyRVNaa3RuQ3YxeFB3NmhucTJyeU1CK2Nm?=
 =?utf-8?B?MFk3bkNmZU96ZlpNMmZ0L3hGUTRERThGRVlQTnJnemxHdlJKUXVXdVRkUS80?=
 =?utf-8?B?ZGVNQmpGQWl5V3U1d1g2NkhoSXROcjd6cE9ITWZDTFRpR3VGVXRpYzVxcmtM?=
 =?utf-8?B?cTEvQXJBaVRLTXp4WU00Mk1FYkZCZTJkS1pmMktjcENxYUsyMHdBaXpqUVU0?=
 =?utf-8?B?RFRkcXpXcmF5MXBkWk42WjU5SGV6Wi96dlE4K1pmbUEwc2ZrYVV4UVhTQUFY?=
 =?utf-8?B?TDlDRWJ1aDNJV3c3TTNIb0phYVhKVHlMUjk0SEFDMEhqSWJuVDhhcDRVSExx?=
 =?utf-8?B?VFc2c3NiSVZHR3Q5aGd2M3ZHaXZNQUhjcW1RTTJ0bmM5SnFPb0lSaDQ4ZkFr?=
 =?utf-8?B?NVFTK3BpNlRHNEJmOS9aK1I2R2lpcHNEMzdUSUJoTXFvcFdXZWJxKzVsa0Nn?=
 =?utf-8?B?V24xZ1B3TS9vT080S2ZiRVZTUWV1SjF0bHByRDE1MjUwSGtPcDQwTjJBK01O?=
 =?utf-8?B?Y2oxd2srNkpKZ1h5UjZ0cjE2WklhSXJBcjhaUElqSHI3MWRVOXlRWTdzVmw4?=
 =?utf-8?B?dXJuUkg5eTVoVGQxOWhjcnlWYUM0TjJRa05qUU15cWJFblpwbW1rQUNvOTFQ?=
 =?utf-8?B?YjlqR1hPZnhLdlRndTJpVmVqSUtTUnVMYU9pSVRhTUtaRVJmV0NTSzNUL1Nm?=
 =?utf-8?B?TXlBeXh5WE9uNmV2dmJyZzQvcUxjY0pqN2ZjL0ZkbWpLOU9lbG12Vk0yNEZS?=
 =?utf-8?B?eFhEeWcvY2ZsZWZtWmZTeTQ2L0hnS25TYTJ4MURJejMwMCtCSjMzeTV3MHF0?=
 =?utf-8?B?dldhc2E5S0ErMng0ME4rQ21FczhSZXF2TUEwNXFLUFpENWhSRDFMMmsySTZZ?=
 =?utf-8?B?dlBBeWJXNWY3WDRTNGNaVVpJdjczK2JIekVJdVdNS3NxaE5MS3hsR0hhd1RW?=
 =?utf-8?Q?c5D1rLBMXAJ4BEIVhiJlR1ONQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9ae095-2417-4529-da62-08dd0af5dba8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 13:02:02.9245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Her3axfZUlY+fh6Y/pK5fcThF4vhKaLLR62E60a/DLe/SpPY56NUPhNgWJJOMWM24wfBmIFvFc0qs8KSaGypVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7266
Received-SPF: permerror client-ip=2a01:111:f403:2418::606;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 19, 2024 at 08:19:56PM +0530, Sai Pavan Boddu wrote:
> Add a basic board with interrupt controller (intc), timer, serial
> (uartlite), small memory called LMB@0 (128kB) and DDR@0x80000000
> (configured via command line eg. -m 2g).
> This is basic configuration which matches HW generated out of AMD Vivado
> (design tools). But initial configuration is going beyond what it is
> configured by default because validation should be done on other
> configurations too. That's why wire also additional uart16500, axi
> ethernet(with axi dma).
> GPIOs, i2c and qspi is also listed for completeness.
> 
> IRQ map is: (addr)
> 0 - timer (0x41c00000)
> 1 - uartlite (0x40600000)
> 2 - i2c (0x40800000)
> 3 - qspi (0x44a00000)
> 4 - uart16550 (0x44a10000)
> 5 - emaclite (0x40e00000)
> 6 - timer2 (0x41c10000)
> 7 - axi emac (0x40c00000)
> 8 - axi dma (0x41e00000)
> 9 - axi dma
> 10 - gpio (0x40000000)
> 11 - gpio2 (0x40010000)
> 12 - gpio3 (0x40020000)
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>


> ---
> Changes for V2:
>     Make changes to support -cpu switch
>     Remove setting of default board
>     Include doc to toctree
>     Remove setting of 'imac' extensions as they are available by
>     default.
> Chages for V3:
>     Replace virt with generic
>     Update doc with supported riscv extensions
>     Change base CPU to TYPE_RISCV_CPU_BASE
> Changes for V4:
>     Improved the doc based on comments
>     Disabled support for Double-Precision and Hypervisor extensions
>     Updated Maintainers file at riscv machine space.
> 
>  MAINTAINERS                                |   6 +
>  docs/system/riscv/microblaze-v-generic.rst |  42 +++++
>  docs/system/target-riscv.rst               |   1 +
>  hw/riscv/microblaze-v-generic.c            | 184 +++++++++++++++++++++
>  hw/riscv/Kconfig                           |   8 +
>  hw/riscv/meson.build                       |   1 +
>  6 files changed, 242 insertions(+)
>  create mode 100644 docs/system/riscv/microblaze-v-generic.rst
>  create mode 100644 hw/riscv/microblaze-v-generic.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index acc7405aed2..100a138d8f2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1619,6 +1619,12 @@ F: docs/system/riscv/sifive_u.rst
>  F: hw/*/*sifive*.c
>  F: include/hw/*/*sifive*.h
>  
> +AMD Microblaze-V Generic Board
> +M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> +S: Maintained
> +F: hw/riscv/microblaze-v-generic.c
> +F: docs/system/riscv/microblaze-v-generic.rst
> +
>  RX Machines
>  -----------
>  rx-gdbsim
> diff --git a/docs/system/riscv/microblaze-v-generic.rst b/docs/system/riscv/microblaze-v-generic.rst
> new file mode 100644
> index 00000000000..5606f88d570
> --- /dev/null
> +++ b/docs/system/riscv/microblaze-v-generic.rst
> @@ -0,0 +1,42 @@
> +Microblaze-V generic board (``amd-microblaze-v-generic``)
> +=========================================================
> +The AMD MicroBlaze™ V processor is a soft-core RISC-V processor IP for AMD
> +adaptive SoCs and FPGAs. The MicroBlaze™ V processor is based on the 32-bit (or
> +64-bit) RISC-V instruction set architecture (ISA) and contains interfaces
> +compatible with the classic MicroBlaze™ V processor (i.e it is a drop in
> +replacement for the classic MicroBlaze™ processor in existing RTL designs).
> +More information can be found in below document.
> +
> +https://docs.amd.com/r/en-US/ug1629-microblaze-v-user-guide/MicroBlaze-V-Architecture
> +
> +The MicroBlaze™ V generic board in QEMU has following supported devices:
> +
> +    - timer
> +    - uartlite
> +    - uart16550
> +    - emaclite
> +    - timer2
> +    - axi emac
> +    - axi dma
> +
> +The MicroBlaze™ V core in QEMU has the following configuration:
> +
> +    - RV32I base integer instruction set
> +    - "Zicsr" Control and Status register instructions
> +    - "Zifencei" instruction-fetch
> +    - Extensions: m, a, f, c
> +
> +Running
> +"""""""
> +Below is an example command line for launching mainline U-boot
> +(xilinx_mbv32_defconfig) on the Microblaze-V generic board.
> +
> +.. code-block:: bash
> +
> +   $ qemu-system-riscv32 -M amd-microblaze-v-generic \
> +     -display none \
> +     -device loader,addr=0x80000000,file=u-boot-spl.bin,cpu-num=0 \
> +     -device loader,addr=0x80200000,file=u-boot.img \
> +     -serial mon:stdio \
> +     -device loader,addr=0x83000000,file=system.dtb \
> +     -m 2g
> diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
> index ba195f1518a..95457af130b 100644
> --- a/docs/system/target-riscv.rst
> +++ b/docs/system/target-riscv.rst
> @@ -66,6 +66,7 @@ undocumented; you can get a complete list by running
>  .. toctree::
>     :maxdepth: 1
>  
> +   riscv/microblaze-v-generic
>     riscv/microchip-icicle-kit
>     riscv/shakti-c
>     riscv/sifive_u
> diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
> new file mode 100644
> index 00000000000..427e3baca7b
> --- /dev/null
> +++ b/hw/riscv/microblaze-v-generic.c
> @@ -0,0 +1,184 @@
> +/*
> + * QEMU model of Microblaze V generic board.
> + *
> + * based on hw/microblaze/petalogix_ml605_mmu.c
> + *
> + * Copyright (c) 2011 Michal Simek <monstr@monstr.eu>
> + * Copyright (c) 2011 PetaLogix
> + * Copyright (c) 2009 Edgar E. Iglesias.
> + * Copyright (C) 2024, Advanced Micro Devices, Inc.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Written by Sai Pavan Boddu <sai.pavan.boddu@amd.com
> + *     and by Michal Simek <michal.simek@amd.com>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
> +#include "cpu.h"
> +#include "hw/sysbus.h"
> +#include "sysemu/sysemu.h"
> +#include "net/net.h"
> +#include "hw/boards.h"
> +#include "hw/char/serial-mm.h"
> +#include "exec/address-spaces.h"
> +#include "hw/char/xilinx_uartlite.h"
> +#include "hw/misc/unimp.h"
> +
> +#define LMB_BRAM_SIZE (128 * KiB)
> +#define MEMORY_BASEADDR 0x80000000
> +#define INTC_BASEADDR 0x41200000
> +#define TIMER_BASEADDR 0x41c00000
> +#define TIMER_BASEADDR2 0x41c10000
> +#define UARTLITE_BASEADDR 0x40600000
> +#define ETHLITE_BASEADDR 0x40e00000
> +#define UART16550_BASEADDR 0x44a10000
> +#define AXIENET_BASEADDR 0x40c00000
> +#define AXIDMA_BASEADDR 0x41e00000
> +#define GPIO_BASEADDR 0x40000000
> +#define GPIO_BASEADDR2 0x40010000
> +#define GPIO_BASEADDR3 0x40020000
> +#define I2C_BASEADDR 0x40800000
> +#define QSPI_BASEADDR 0x44a00000
> +
> +#define TIMER_IRQ           0
> +#define UARTLITE_IRQ        1
> +#define UART16550_IRQ       4
> +#define ETHLITE_IRQ         5
> +#define TIMER_IRQ2          6
> +#define AXIENET_IRQ         7
> +#define AXIDMA_IRQ1         8
> +#define AXIDMA_IRQ0         9
> +
> +static void mb_v_generic_init(MachineState *machine)
> +{
> +    ram_addr_t ram_size = machine->ram_size;
> +    DeviceState *dev, *dma, *eth0;
> +    Object *ds, *cs;
> +    int i;
> +    RISCVCPU *cpu;
> +    hwaddr ddr_base = MEMORY_BASEADDR;
> +    MemoryRegion *phys_lmb_bram = g_new(MemoryRegion, 1);
> +    MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
> +    qemu_irq irq[32];
> +    MemoryRegion *sysmem = get_system_memory();
> +
> +    cpu = RISCV_CPU(object_new(machine->cpu_type));
> +    object_property_set_bool(OBJECT(cpu), "h", false, NULL);
> +    object_property_set_bool(OBJECT(cpu), "d", false, NULL);
> +    qdev_realize(DEVICE(cpu), NULL, &error_abort);
> +    /* Attach emulated BRAM through the LMB.  */
> +    memory_region_init_ram(phys_lmb_bram, NULL,
> +                           "mb_v.lmb_bram", LMB_BRAM_SIZE,
> +                           &error_fatal);
> +    memory_region_add_subregion(sysmem, 0x00000000, phys_lmb_bram);
> +
> +    memory_region_init_ram(phys_ram, NULL, "mb_v.ram",
> +                           ram_size, &error_fatal);
> +    memory_region_add_subregion(sysmem, ddr_base, phys_ram);
> +
> +    dev = qdev_new("xlnx.xps-intc");
> +    qdev_prop_set_uint32(dev, "kind-of-intr",
> +                         1 << UARTLITE_IRQ);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, INTC_BASEADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
> +                       qdev_get_gpio_in(DEVICE(cpu), 11));
> +    for (i = 0; i < 32; i++) {
> +        irq[i] = qdev_get_gpio_in(dev, i);
> +    }
> +
> +    /* Uartlite */
> +    dev = qdev_new(TYPE_XILINX_UARTLITE);
> +    qdev_prop_set_chr(dev, "chardev", serial_hd(0));
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, UARTLITE_BASEADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[UARTLITE_IRQ]);
> +
> +    /* Full uart */
> +    serial_mm_init(sysmem, UART16550_BASEADDR + 0x1000, 2,
> +                   irq[UART16550_IRQ], 115200, serial_hd(1),
> +                   DEVICE_LITTLE_ENDIAN);
> +
> +    /* 2 timers at irq 0 @ 100 Mhz.  */
> +    dev = qdev_new("xlnx.xps-timer");
> +    qdev_prop_set_uint32(dev, "one-timer-only", 0);
> +    qdev_prop_set_uint32(dev, "clock-frequency", 100000000);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
> +
> +    /* 2 timers at irq 3 @ 100 Mhz.  */
> +    dev = qdev_new("xlnx.xps-timer");
> +    qdev_prop_set_uint32(dev, "one-timer-only", 0);
> +    qdev_prop_set_uint32(dev, "clock-frequency", 100000000);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR2);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ2]);
> +
> +    /* Emaclite */
> +    dev = qdev_new("xlnx.xps-ethernetlite");
> +    qemu_configure_nic_device(dev, true, NULL);
> +    qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
> +    qdev_prop_set_uint32(dev, "rx-ping-pong", 0);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ETHLITE_BASEADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[ETHLITE_IRQ]);
> +
> +    /* axi ethernet and dma initialization. */
> +    eth0 = qdev_new("xlnx.axi-ethernet");
> +    dma = qdev_new("xlnx.axi-dma");
> +
> +    /* FIXME: attach to the sysbus instead */
> +    object_property_add_child(qdev_get_machine(), "xilinx-eth", OBJECT(eth0));
> +    object_property_add_child(qdev_get_machine(), "xilinx-dma", OBJECT(dma));
> +
> +    ds = object_property_get_link(OBJECT(dma),
> +                                  "axistream-connected-target", NULL);
> +    cs = object_property_get_link(OBJECT(dma),
> +                                  "axistream-control-connected-target", NULL);
> +    qemu_configure_nic_device(eth0, true, NULL);
> +    qdev_prop_set_uint32(eth0, "rxmem", 0x1000);
> +    qdev_prop_set_uint32(eth0, "txmem", 0x1000);
> +    object_property_set_link(OBJECT(eth0), "axistream-connected", ds,
> +                             &error_abort);
> +    object_property_set_link(OBJECT(eth0), "axistream-control-connected", cs,
> +                             &error_abort);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(eth0), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(eth0), 0, AXIENET_BASEADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(eth0), 0, irq[AXIENET_IRQ]);
> +
> +    ds = object_property_get_link(OBJECT(eth0),
> +                                  "axistream-connected-target", NULL);
> +    cs = object_property_get_link(OBJECT(eth0),
> +                                  "axistream-control-connected-target", NULL);
> +    qdev_prop_set_uint32(dma, "freqhz", 100000000);
> +    object_property_set_link(OBJECT(dma), "axistream-connected", ds,
> +                             &error_abort);
> +    object_property_set_link(OBJECT(dma), "axistream-control-connected", cs,
> +                             &error_abort);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, AXIDMA_BASEADDR);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dma), 0, irq[AXIDMA_IRQ0]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dma), 1, irq[AXIDMA_IRQ1]);
> +
> +    /* unimplemented devices */
> +    create_unimplemented_device("gpio", GPIO_BASEADDR, 0x10000);
> +    create_unimplemented_device("gpio2", GPIO_BASEADDR2, 0x10000);
> +    create_unimplemented_device("gpio3", GPIO_BASEADDR3, 0x10000);
> +    create_unimplemented_device("i2c", I2C_BASEADDR, 0x10000);
> +    create_unimplemented_device("qspi", QSPI_BASEADDR, 0x10000);
> +}
> +
> +static void mb_v_generic_machine_init(MachineClass *mc)
> +{
> +    mc->desc = "AMD Microblaze-V generic platform";
> +    mc->init = mb_v_generic_init;
> +    mc->min_cpus = 1;
> +    mc->max_cpus = 1;
> +    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
> +    mc->default_cpus = 1;
> +}
> +
> +DEFINE_MACHINE("amd-microblaze-v-generic", mb_v_generic_machine_init)
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 2e88467c4ab..e6a0ac1fa1d 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -25,6 +25,14 @@ config MICROCHIP_PFSOC
>      select SIFIVE_PLIC
>      select UNIMP
>  
> +config MICROBLAZE_V
> +    bool
> +    default y
> +    depends on RISCV32 || RISCV64
> +    select XILINX
> +    select XILINX_AXI
> +    select XILINX_ETHLITE
> +
>  config OPENTITAN
>      bool
>      default y
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index adbef8a9b2d..140bcb55d64 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -11,5 +11,6 @@ riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
>  riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
>  riscv_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
>  riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files('riscv-iommu.c', 'riscv-iommu-pci.c'))
> +riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
>  
>  hw_arch += {'riscv': riscv_ss}
> -- 
> 2.34.1
> 

