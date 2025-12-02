Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FE9CFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 10:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQO11-0003tE-04; Tue, 02 Dec 2025 05:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vQO0z-0003st-4V
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 05:53:49 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vQO0x-0000Qx-1L
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 05:53:48 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B270ptb3553440; Tue, 2 Dec 2025 02:53:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=RqVmMMFrrpuFcxoOEifRdtylrpR+JDgeIBAsIueP+
 bQ=; b=2ueBm6gqT+nZH/cqs1r7Ow9/4DDJYUxxXTnXLMsaYdHewgpdODCrkha8w
 RLpP9aGw/ptyAVVSCx/uZOdJv060/RbsQi9lBqhKZX8WM0sXWwfrkZh8VH07ZEAz
 LuNp/6gVNYopNjCpmpS5CDYjb0AIoTIg2mBPvG04xajeyBiWLHSCPYEDQRDa8FXP
 6HQJH/r/5A7JtVefHM6rmiuz0LmQ11ElcLDzeImbAmXTvVOQGuWFO6x7LEMfj0Bc
 nW2Fq16mZDetjOKn4Nild8dypYDt5ZeG36+pgtLpPjaWlSe0EAUHhQCKfdUcc8gQ
 yCx3gbsciAOdt8X6AKuoyenpUKRBQ==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022099.outbound.protection.outlook.com [52.101.53.99])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4as9rajssy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 02 Dec 2025 02:53:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ax+vxrqoRLqN09cOWk628BBYLCLhD7S62wI4aT0LC1KTkdU5OpkWKBXQ5rewQ9lcRRbF6IbTmgPLIfe2unJ0F/otzGfGuw8UapCp6HJoBVcD+0dIN+zqtU7LzLf0KewXoE3aeCq8g9W/Y9WhC8Jetex1rZQ+0TdjkS8TTWm9gSDqgOUQTbbHpzIwvlgSQdjyZIMTqRSRTSUWDh7LEyGWTP3vJ74RHwEIo2anNhvBCSsV5VZnEutwQ9ovnL1ncC3sU+a7Rbnjqecd8zKIk2WwD8IccFJbRa8g3PxwojtRQFhYpmHzhZjPCEOaWcE2a69dHbIOMfGBzS65q0w4HZ9hnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqVmMMFrrpuFcxoOEifRdtylrpR+JDgeIBAsIueP+bQ=;
 b=drg7C8RqvpSXHPglmZYyWqLimf3IgJiZ8TtHiHheKjC2CaiE5YjZk+QcWiw1Ek9hOLlRahFrLXlAfCycjee1bRhktlXmZsPBaPKi+3fq0gKZeug54ZdnsyEAUexpIXcJmy/s8kvQgkTIa44isN+XeupQFcc3h+jMCYez1SeMFnWS9eJrcY7Qc2uKbSLeTkrv3Q3S/wZd50Nyfo2PtN+ZokekMqcOEcZloH0ueDB5Rqs1JXI3NKrTdmRczLEnujwJkxZA0aY9OeWWb9VTUmwwdak5vp/lc3iXMLr/pZPD5XDQvgjB2PEo+t0DxgzIFr+KG6XYA2L9Sgsbm3CJopIVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqVmMMFrrpuFcxoOEifRdtylrpR+JDgeIBAsIueP+bQ=;
 b=R35hcXNCwxNVNPLkIURWdOM4SdGtmhEro8ZN9SqCBsdlHcsWr2rPtvV+S5u72HH5JJDiBc8sBj0QStq3T3pATwh0KpSwqPo7Mfwd2xhXDp9Kr/gRpUEUfDeSnStlv2TWFWWcFRD800ANwES63LjNbXlF8iyn0tvezjz3Wik2Dnip9gdtl7P/hwp6Od7jZinCdf8do35RcrG3A+ZJXpfM3IMWBBtwAj9VDKdf4nDfSiMnqx/fLmMxkkeuoKqkeJZpByveQjG7Mm62TRuxUUHtWtuGpSP2oh4fkQFtjGDiPRYe4n9n9dtIFG/0nhifGataZw6k3J7Aoll/RDZQncT69Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS1PR02MB10347.namprd02.prod.outlook.com (2603:10b6:8:218::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 10:53:43 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 10:53:42 +0000
Message-ID: <b7a282bc-bd97-4101-bf88-b69aef59eb54@nutanix.com>
Date: Tue, 2 Dec 2025 10:53:39 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] vfio-user: refactor out header handling
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20251201095621.2786318-1-john.levon@nutanix.com>
 <20251201095621.2786318-4-john.levon@nutanix.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20251201095621.2786318-4-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0088.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS1PR02MB10347:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a59864-bf0f-4f2e-e7f2-08de31910f02
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDJuL0V3djA3R2k1UDNkLzVVcGR6MjN2TXBYd0FHT0VZSWk4T0o3dHM2Vzdy?=
 =?utf-8?B?b3NvY1RNN1hxOTNYUHpHL1VpbW1EblNzanViMnk5em5hMGhsT1VJdHora1g0?=
 =?utf-8?B?cEd2UVltZmRXMUI1WmpJS1F0MWNGYVhKNnFNVm5vbys3WEFmNGtOVkI0aE9z?=
 =?utf-8?B?TXY2U2ZRVjNsSTRXKzI2TnZwVnUzaEE3WnFuOUF6Z24rWUdISDBWcVk3Yzg0?=
 =?utf-8?B?bC9OUE9jTi9Tc29pQjlwczQzcnZDU2k5b2ZDaFBmY1NMN0NFM3UyUzBNbXY4?=
 =?utf-8?B?RVhzQ0NTM09JbmNIRE8zeW5wUkkrNk92c2gvczFodkZGUEhIelUvQ2tOdHU1?=
 =?utf-8?B?bVNPaFV6Z1RncjhYbzFMYTdkbmdaZ3d4L3U4M1RaVk5iUjF5SWJidlV6bTl6?=
 =?utf-8?B?Q0JibklXUlZDaWhNblJZVUR3NnlQMTdzR3hSYnFFWFh6ZHdzSEVMRytTek1y?=
 =?utf-8?B?d3cvSlhhN0JaTkM4UlNaOEMvZlpqOWY1UzhPMGVVaU1iYWI5UDEzaVdydFBm?=
 =?utf-8?B?bVEyRWJrdUEzSXFFcjRxTjZDQTltSkNXeXhmM2VTL01BcGEzRkp0bk1STGlB?=
 =?utf-8?B?R1IwVTF1bFI4dnA2aVUxNzlWYWMydmc0VXdybGNEOWNxaWpOdGhnVlpUTjY4?=
 =?utf-8?B?b2VjT2t3SlJiMTloVUFBNnJVbXRHMjZiMC9jWEI2UUlZZG40NVlnakU2WGYw?=
 =?utf-8?B?ZWNZcnluc2RmR0RHcHRwenhzQk1ST0d2WHYrOVhUdjNRQmlzWUhNWTRxK0Uz?=
 =?utf-8?B?SHlUeFZaQkRpdGpZbjBic0NoNTE0K0tFYWl5UlJkMkcrZ1JMM3pDS2pJY3pW?=
 =?utf-8?B?c3B0dWFpeFg1ckNOYzFySms1YXpYeE5hK0k2ZVZtNkhQQ3lSRjQxMFVaSVJR?=
 =?utf-8?B?dGVlU2lCRTNtUHBrZENNSDJuQUppdlFTalliZUdSMy9OdVhpVWJvczdnQlFI?=
 =?utf-8?B?YjgxR3ZldzJhdlVoa3FxTW80MUJhUm5sMnJhYWxyWjJiSXZ2UlkxL2Qxa3hm?=
 =?utf-8?B?WWo1dzcwRCtnUmVKUDBicjE5NkRWT0o2c3hWMloxZFhrMStXSmZuZmI3Vnhy?=
 =?utf-8?B?OVp1Y3RxNlZ0a1IrNnRORFdTb2U1RHhzb05ZSnNIVjQ3MVFJb3JrL2UySndP?=
 =?utf-8?B?VVRaMnByeVV6dmNGM1FIWWdSWHlxZ2YycnJpZk50SkdYTkVTWDQzOUpHU1la?=
 =?utf-8?B?QWtlZnFzcVY3cmU0Y0JyOENHYjV5OGxUaDVTaXRnSEhSZlBSQ1Z3WWJZNHlQ?=
 =?utf-8?B?c2xWZENiNjBKanNuWlA4bHZHdjd3Z0dhc0EwbjBxb0lMMGIvTktUclhYdmpH?=
 =?utf-8?B?QkhTVFJSSXIwUGllZHYvQ29iNVplZmpiMFEwZkNXRFlucndMSjZYOW5yMkZH?=
 =?utf-8?B?ZCtGbmpUTnJCQ3pPVWU5VjZkVkVtR29xbG91VU1PYlNvUFRyR1htYWRLdnAy?=
 =?utf-8?B?YnpyVFZXKzc1MjEzNTA4dWFqcHBqTm1BaktPWjdUL2dRaDB6K1NkNkE5cmdK?=
 =?utf-8?B?ZVZiTldkL0hXU3pTRWdlZFQ2Umd5VlZnZ294YWhPRTBGT1VrdTk0VndWT3NI?=
 =?utf-8?B?aHZPN1VBdGdqcmVoa1pTbjlYZFZkVGZLdzNLbDIxWVlFeTZIb3dma3JDbmJr?=
 =?utf-8?B?Z0dIR1pZNGl5aGM3WVNkZFBxektLLzFWaTB2UW16elRCK2kyTExSTXRhVVZq?=
 =?utf-8?B?S01oNkJYQWtZRG5jbEU3RVJuWXJZZUJlME82VTN0UW5pSUtIb01sTnZkeU9R?=
 =?utf-8?B?aTVpVkFpQ2tvNW1JdFEvMmZmL2ZXbXlZd1E3NnBHNk5QcWVVeHVFVWUyZUwv?=
 =?utf-8?B?RHNuSEVCK3JnUkFSY25RUFFpdTJRays1L0RKRFBlU1d0aFJBRjc1VmMvdita?=
 =?utf-8?B?KzJPYkw0M29BZzBoYXU5NXE4ZXlXc0FreHllVXd5Y2daaE83bExkdTBRNml3?=
 =?utf-8?Q?2Oi6iujw9ooFqvXDem2RQERB6PHPwyI/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2NUR25hZ3RCK2RlZXhVQWlReXBYNVhSdnBTWCtYVFM0Y0U3R0p0RS9GNkhv?=
 =?utf-8?B?QUJ2dzRKdm9TM1ptWDl4eVdRUlA0V1ZmV2xtbGVnS3FMOW4xQTlDMDkwT25k?=
 =?utf-8?B?ZnRkSUVPRnFxS2l3VlllQ1NxaFJoQWJ4U1daUUZQSjlXWHkwdlRDVGJGZU5H?=
 =?utf-8?B?blZpeWJwc3JUcXFwRGdGZ1g1b0NnMXovZDVLUGJKaTZMYTY4eEw5MEhDZHlZ?=
 =?utf-8?B?N3FheWdFUzZQMmlhdWFUZTRVdDZwRzJEeHBPZ0l4V2hPRUZXKzFvVlYxWFIz?=
 =?utf-8?B?QWRyTXR2S1puYjVVNEtIcU1BMDhMZmxPZFZ0c1RsK29MSFpSWEYvT0JKMEU0?=
 =?utf-8?B?blQ4QjhlZmR5MDg0U2ZWdHNCa0JYOGdwTllEVEJVdlMvWFJmcU5KcDV6SStC?=
 =?utf-8?B?OGFtNkVueGh6elV2eWNWTUVBc1VaS29DL3g0TFRvZ3dsQXUvbXRDbWVCVklG?=
 =?utf-8?B?UmtUSTRXQUcvTXJPOTd0VEU3NTZJV1JscDA4Mm1MOGhUMlBxYVNNcmdqVXha?=
 =?utf-8?B?c2xxeXJTYjhvTkZ5d0dOd3F3NHp2S2tmQVdGVkQ0YmxUYlZzbnVWR0FnMlhW?=
 =?utf-8?B?VGtaMDAzMlcrMFdoMmxkQVZhK1htN1FxS2lONUJVUG1IQkVaTXlkd0hiRDRK?=
 =?utf-8?B?MUlGOHc1cDN4V0RSTVg2QnJSblZMWkNVNHc0eGJ4L1JPMVVQTXR3NGJiK0p1?=
 =?utf-8?B?Y2NBeEJINnY1bkJtb0lja0dPUXhJY2hmZFEvTHBiZGg1NG95bWNhS3FZY0Na?=
 =?utf-8?B?cFdYUHdQR09BODc0MjFSV2VaWktOOEtlN2JSZjZqYUZkR0dUczAzSUNUS1BF?=
 =?utf-8?B?RUZTZms5UUxLTDkyNmZFLzJjckw5aFZpbUZCQ3V1dEM0aDg4NVQ0OEZ0RlJ2?=
 =?utf-8?B?M01ITUlnMmhjOThtMnV2dFBvVlBzTEgyaUNVd2hXcGlYazBLMlpuVlV5K1Qr?=
 =?utf-8?B?RGVUejkzYW1OY3YwV0JsNFkyNERvSEYxeHBycWtyWlY2YzNDYkRxcjEramNs?=
 =?utf-8?B?Y2toMUFmbjE1Z1RKQVgrNlZVb3lZNFpYa1gzRy9mQVZlcU0rSnVNcnU5Q00z?=
 =?utf-8?B?QVVWTE1aUW5ibHd5UllhUTEyOTFOV0VtcGkwOXNTWUdZYWppeStHRjg1Tngz?=
 =?utf-8?B?UmFmQm5WdEhmRk1RVC9zb2lvMnFBT2wvN3c5YU9rWER2bWN6NElOTGx2cHlz?=
 =?utf-8?B?VVM3eCtqN0t5RGJYQlcvdVZFVkRlU29SUUZXVXlsMVpvQWd0bmFkQ2xoUEg3?=
 =?utf-8?B?VW9ET2JScllodVlDTDRlVTFlbjhGOWR0SndNVHZ4N3BKdDJkMzFpM1FxK0Np?=
 =?utf-8?B?UisrNnZ5cnZnVE00c2ZnVHdXOUQ3cHhPOGw1TDI3WllMZVhMUjdUQktUOHZQ?=
 =?utf-8?B?c01qRmJBVjgwVVJrMDN0Mzl6TzQ2TW1ydDJSOE52MSs2blRkOHRPZTYvdytD?=
 =?utf-8?B?TjBuWGRzVm5BbmJhMW1tM0hzbWhya3pGZVAzZGV1ZjhXd1BTQ0J5MWxiOW9l?=
 =?utf-8?B?SW5RK2YyZ3VCMytIamZVTmtFdFVKSkVMWElEWmxnc29PdGRJbjl6Z1BieHZQ?=
 =?utf-8?B?SGZab0tCOFVuU0c5Vk82TUd1RE96VFJvUjd4ZkdPaVZ4QVdpemtHaTJiWnYv?=
 =?utf-8?B?Nmd6TkFIcG9CRGJDaktVZktMcVNCN3JTcTNJVGFkV2dJOTZOQStmZ0FnUFh4?=
 =?utf-8?B?eHRZTXV4bm04Yjlrem93emZxc1pWaXRwbTRnTE54ZFlESHd6blhWSHcxVVpT?=
 =?utf-8?B?WlZ5Z3ptRlVwUjhOWDRTbk15dUwrUm5TTGJzWFNLSFFFaCtjbk9NR0Rjc3dW?=
 =?utf-8?B?YXJHQmJ5cWxoOFFlejJ5SmY5TDlGUUdMazJoZzZnLzlJZCs4SFZmeE5zWUxP?=
 =?utf-8?B?ajdBNnFRdUFwTWltQ3ZmdloxY2pJK0o3VnFrbTZuVUE4OHgrMkZVNHR3cVVi?=
 =?utf-8?B?c0tyMHNHSGZJYlZiTmZJalJlMTloRlAzUW1TbllXaVJXczlhL2JHbUxSVkt0?=
 =?utf-8?B?aTlVTG5nRzJrYUtxanloYUhQdkpWaXNuTllONmtWc1hLM2hMS29vUUhwczEx?=
 =?utf-8?B?K3VSOXByc1J0YnR5RzZFcERzeGRiUEpKYVZDS3padEY4andoTkw2UnFIeUZZ?=
 =?utf-8?B?QzhhbmpQeEtGSERRRVNkWXhNempwYVpmN0dQYWN0UmhKVUVlTEc3L0NZNlRK?=
 =?utf-8?B?WmJiNVYxSXo1QzVmOS9zVVpEMnlsTHRWU1M2VG8zaG1kSS80QytYZzRYL2pE?=
 =?utf-8?B?S1daVVNIdktkcnNVYUJScnNseVpBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a59864-bf0f-4f2e-e7f2-08de31910f02
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 10:53:42.9193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSqLuDCk9knaPx2opGXWktRykBpoL0YzrXdJakR8TViXqdqaneoV5pRpvL4OxZQnYslncr5hEFXWCE+13E65K2BftzccqM/wW9+n1fmG9ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR02MB10347
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDA4NyBTYWx0ZWRfXw5rHJcsV23n9
 ed5R316lrs3iLG5z/zJWTBo83tN9PxSZ1HUzKQeutdz7p1r+J3QTvjOg6kRx1zC9QbDPK4V0oMV
 elArH7dATz186p6tC5ZJKZerWLXjFX62/HJhJlJ+Xn8Rh3AzZcXGegd0iGyE8rmaYayBjlcJZ/J
 ecMIlOU6sj/4mBbEnp5M4dLoFbACXeD4Ms3xA6lAPuHTWezU5iCvDH40Ajh/s7cswT5sgszDNUe
 awV9HXqYr4x05eKkMCuJDiZOv94cWUqKN/A5wLkfwE/uMtO8NDJ2YVFzDY/wLv8qTBxiRJ85k7j
 FkZ77DMhsdzSA3K+FRPCiq1aVa7OnuYSa2Q7sjo/B/vn1hvNIvFW9SrMI0p6drJ+UCPZnwK6sPb
 CisVaMZzkSEELs0PMZUbGYjU0shjLg==
X-Authority-Analysis: v=2.4 cv=V7xwEOni c=1 sm=1 tr=0 ts=692ec538 cx=c_pps
 a=qlJ2pVgRLkKXdQ82XtY8Hg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=S4gMLzi1CUBw9ywHssYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: b69WjvpWx4l47J9155qM14h6Twt31zHB
X-Proofpoint-GUID: b69WjvpWx4l47J9155qM14h6Twt31zHB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 01/12/2025 09:56, John Levon wrote:

> Simplify vfio_user_recv_one() by moving the header handling out to a
> helper function.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio-user/proxy.c | 101 +++++++++++++++++++++++++------------------
>   1 file changed, 60 insertions(+), 41 deletions(-)
> 
> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> index 82c76c6665..87e50501af 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -218,6 +218,61 @@ static int vfio_user_complete(VFIOUserProxy *proxy, Error **errp)
>       return 1;
>   }
>   
> +static int vfio_user_recv_hdr(VFIOUserProxy *proxy, Error **errp,
> +                              VFIOUserHdr *hdr, int **fdp, size_t *numfdp,
> +                              bool *isreply)
> +{
> +    struct iovec iov = {
> +        .iov_base = hdr,
> +        .iov_len = sizeof(*hdr),
> +    };
> +    int ret;
> +
> +    /*
> +     * Read header
> +     */
> +    ret = qio_channel_readv_full(proxy->ioc, &iov, 1, fdp, numfdp, 0,
> +                                 errp);
> +    if (ret == QIO_CHANNEL_ERR_BLOCK) {
> +        return ret;
> +    }
> +
> +    /* read error or other side closed connection */
> +    if (ret <= 0) {
> +        error_setg(errp, "failed to read header");

Can we use error_setg_errno() here to record the real underlying return 
code in errp? Otherwise with this change it gets lost due to 
vfio_user_recv_hdr() always returning -1 if there is an error.

> +        return -1;
> +    }
> +
> +    if (ret < sizeof(*hdr)) {
> +        error_setg(errp, "short read of header");
> +        return -1;
> +    }
> +
> +    /*
> +     * Validate header
> +     */
> +    if (hdr->size < sizeof(*hdr)) {
> +        error_setg(errp, "bad header size");
> +        return -1;
> +    }
> +
> +    switch (hdr->flags & VFIO_USER_TYPE) {
> +    case VFIO_USER_REQUEST:
> +        *isreply = false;
> +        break;
> +    case VFIO_USER_REPLY:
> +        *isreply = true;
> +        break;
> +    default:
> +        error_setg(errp, "unknown message type");
> +        return -1;
> +    }
> +
> +    trace_vfio_user_recv_hdr(proxy->sockname, hdr->id, hdr->command, hdr->size,
> +                             hdr->flags);
> +    return 0;
> +}
> +
>   /*
>    * Receive and process one incoming message.
>    *
> @@ -230,10 +285,6 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
>       g_autofree int *fdp = NULL;
>       VFIOUserFDs *reqfds;
>       VFIOUserHdr hdr;
> -    struct iovec iov = {
> -        .iov_base = &hdr,
> -        .iov_len = sizeof(hdr),
> -    };
>       bool isreply = false;
>       int i, ret;
>       size_t msgleft, numfds = 0;
> @@ -257,45 +308,13 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
>           /* else fall into reading another msg */
>       }
>   
> -    /*
> -     * Read header
> -     */
> -    ret = qio_channel_readv_full(proxy->ioc, &iov, 1, &fdp, &numfds, 0,
> -                                 errp);
> -    if (ret == QIO_CHANNEL_ERR_BLOCK) {
> -        return ret;
> -    }
> -
> -    /* read error or other side closed connection */
> -    if (ret <= 0) {
> -        goto fatal;
> -    }
> -
> -    if (ret < sizeof(hdr)) {
> -        error_setg(errp, "short read of header");
> -        goto fatal;
> -    }
> -
> -    /*
> -     * Validate header
> -     */
> -    if (hdr.size < sizeof(VFIOUserHdr)) {
> -        error_setg(errp, "bad header size");
> -        goto fatal;
> -    }
> -    switch (hdr.flags & VFIO_USER_TYPE) {
> -    case VFIO_USER_REQUEST:
> -        isreply = false;
> -        break;
> -    case VFIO_USER_REPLY:
> -        isreply = true;
> -        break;
> -    default:
> -        error_setg(errp, "unknown message type");
> +    ret = vfio_user_recv_hdr(proxy, errp, &hdr, &fdp, &numfds, &isreply);
> +    if (ret < 0) {
> +        if (ret == QIO_CHANNEL_ERR_BLOCK) {
> +            return ret;
> +        }
>           goto fatal;
>       }
> -    trace_vfio_user_recv_hdr(proxy->sockname, hdr.id, hdr.command, hdr.size,
> -                             hdr.flags);
>   
>       /*
>        * For replies, find the matching pending request.


ATB,

Mark.

