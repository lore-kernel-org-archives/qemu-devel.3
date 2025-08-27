Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8892ACA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urE2j-0005PJ-PE; Wed, 27 Aug 2025 07:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1urE2i-0005Ov-4z
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:10:16 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1urE2f-0007mm-0w
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:10:15 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57R2lW8x2963738; Wed, 27 Aug 2025 04:10:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Yv26ozlgG5ZOy2xKJYTuP1qa/keCSnOzago80va1Q
 qQ=; b=VM0o/Fm/NlTo1B3AbIciGKqum6GKeral1+ZiASdoYjxugOhDA4bMX0kZc
 Mz9XH7YqsAddLVI+KedWLMSoQLkKe+nBdEc2gE/7xQCTz/c8eoskWmNEgvTNZsWg
 VYabavNs1nzOvfGRJ7+OsAlJgf8fG5kF+6uJIlW3wC9a/Q6rp4Cm4V4P4oNjYzdJ
 Ipandfp9+afl0jzOqMN3+ofwtro/xxkPPYs62RtYVX//IwXhkgoHF7WZZIcQBKMF
 ZcVXnIqCtw7KO2DtjyHUdACka6aO9QxagmmqJhIUevvRVCh7tBVPOaYRxCw63tpV
 Gmfsl/xu15hzJuMYX4tMSJs6orQIg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2112.outbound.protection.outlook.com [40.107.243.112])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48rx6jmk1r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 04:10:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPz0+No3ecWQtjRnD/YXeL983zW86r/MPKO8DvVv6d7xzGpFOqO5PL4XgnXIqPf3f3z4hyU7P4QIQxYAy3lRilEZgdq11kF6TxLFbauLSoMsaj5ubeO4ooFMIURjCty/G7N9QOF2A1YKGP8MtU3wF7w/K0mIE8n1quzCC0WrWDdIH7VOiYx9WWiAa9X8gKibrswWsh+HIeJi8mtNMmsDeKuN5RNSoW/3idgL3FNTGpNZu7oSGjiQ4jHzBdoDpqcT78AwtDgcrYcefaWEFmGHzWJ7rlFd02zMb4/uTu9maIUtvPDCMu+03bCzcpMUUBc9Uh2bfnfFiRNxKKEGpJlGqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yv26ozlgG5ZOy2xKJYTuP1qa/keCSnOzago80va1QqQ=;
 b=QFWuEEilFAT4aDT5LALcZsLBbw892SUa6dqT6nDrf1AuYPmzCnnHY8iQZPUlZWWKrzKSziKm62BghaPbue5K/f/G0GJfg6SFziUSYpzbKz3R+rJDbIbSrYtsQGn4zmN6TheoHZMI68xq3MM/8MY3mHFP+LQFs/zAjb+GaEYa+neEDUMlnT+1aNNTa7kcMvjapTSKEEXKeS5dFY4pqULx0MLISB0LesO0jnIkaWn4EOyYNUkZ1YJDHV+FmxJODqR++7JeWkAhVs7DH7E5zxs+LHhygnYC2ds8uK0lJRfyoN20uHE+EEaBNeqR3h9fvAXCNtA2lY5CdDUBVtPWsvAvbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yv26ozlgG5ZOy2xKJYTuP1qa/keCSnOzago80va1QqQ=;
 b=ZwH4f6OE3ddlm5By7owiCv2gfZiQFMt7vppMnh9ybjD7uQJt10a4nO8XDMM68ZSkgAJInuiKoFXbdGXfB+eyQw989kStNjstIMukZ/gNefsRJGJoNPqjZC8N85iHnbuUULWHGEdyy6aaF5bRsoR/IBQZ74GtcFWHjjrlaHV2eLTyJZloWZhKrkPTlTRLeK10iP90h0sXP4FJFgRzV59oBfnGsUlvcQsHYpjrkqozHVZpEGp2sAikJantGjU5MgAYtA3BMyfs4sSsV1AWXbvUOj4v128sIrzCCApD/eVk80lhTkh2tyVhqmwNnTMQg4BRGZxFghrP2SL6jTXjQSqSjQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA1PR02MB8383.namprd02.prod.outlook.com (2603:10b6:806:1f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 11:10:04 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 11:10:04 +0000
Message-ID: <58c515a4-292e-4aec-b57e-73be89b9c322@nutanix.com>
Date: Wed, 27 Aug 2025 12:10:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/19] hw/i386/pc_piix.c: restrict isapc machine to
 32-bit CPUs
To: Xiaoyao Li <xiaoyao.li@intel.com>, pbonzini@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, imammedo@redhat.com,
 qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-2-mark.caveayland@nutanix.com>
 <3c2e9fbc-db80-4dd6-a1a5-deeabb8c0194@intel.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <3c2e9fbc-db80-4dd6-a1a5-deeabb8c0194@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0018.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA1PR02MB8383:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d759756-7ac5-4204-be22-08dde55a4640
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFNaNk5ZYTNqMjlVMHRwbnhPTDE3cUR2akd1b244VlR5Q2hyNlZ1WmJhV05k?=
 =?utf-8?B?eGIxWmxRV01rbUFZbE9jMk5yNVYvRFRiTks2K3FXWkV2Qzlzbm1lOGN1dFhw?=
 =?utf-8?B?NE5TYS9pdFRXL3JIam9wbWhpWHRacExobXcrSld6RHVNTFFuOGxId0xobkZz?=
 =?utf-8?B?YkhYMEhzWStmWWxsZzhTN0x5aXpORXdRcStXcGdpcTFKelNjbloxVXc3d1I2?=
 =?utf-8?B?aHNUTEo1RmdsK3BXcGtLRm4rK29BT050aDRHZXRBVnRhRnVrb2txSHZzanY3?=
 =?utf-8?B?aFlHMU5lVE0zdnN2QUNiMmVRWWtqQjVlS1VvQlFyMWpiMnd2MUVTdGMwWVdR?=
 =?utf-8?B?SDFYd0U0R0dnQWQxaXZDcjZDcHpnVzA3NnYySGNBZVl5eWFUQm9xZG4vQ2lX?=
 =?utf-8?B?VkRxUEQ4U2pSdENxaGUwTVdlSVlZbkRIWFdTMlNiWmRKRWFyMHdOajlkR2Iw?=
 =?utf-8?B?cHNjdnA3MUNWK0UvU3kxSXdlQ1IwUlRKcVlDWjREUCtqOUx3emZyR2pvWHZ1?=
 =?utf-8?B?VzA1OU1YcVhsSFpPNW5xU2Y2aHRUcWRyWm55eGZhMWVHczNrRkZWNVZPYW1o?=
 =?utf-8?B?MERqUWlhQmpuTml2Wng1S2t2OENKVEgwRDVmN09mWHFSYXVzb0h2KzNWZjRT?=
 =?utf-8?B?Si9uZjhSdHVrNmRDY0NtNHlSYU5KMXlrNUd4VFBMZGNDUWZUd2wyQ3RWU2pi?=
 =?utf-8?B?NWp4VWsvb29ZNWpxeHhCb28yRkYxRjFoakpBcENxUE1HV3Jjb0pDUU1lZysr?=
 =?utf-8?B?aEJRR09tMEdNZTFuZ0g3clJTd280NE5xNzVha0tpMUg3Vm8wSk9sMERnNitZ?=
 =?utf-8?B?VlBpZnBXc3VpTmpVcGlTU2dUWElBN2RFUUNycjNRSXV3bnV1YW1Nalh4QzAx?=
 =?utf-8?B?Smg2cVJHaENlZk9NUllGbE45TTlqYXo5NTRzZDhweXBBQlpxdEZndzRQUysz?=
 =?utf-8?B?N3JpMFBOcWlUNzRxNStMajVQU1hqZWVFZFNZSFVvakhtZnQwQ2IwV29UR1dk?=
 =?utf-8?B?VnZ0YWVyTVpZMHlyMC9zd3NWdGJqbW9VK0NDbEFmaVA5R0ZWM3l6RzB4VjFS?=
 =?utf-8?B?UjhrbmtwcFFNTVZVcngvYVRoaEtNMWdxNzJkZE1WTkZRdVFXSzI3S09uOXhy?=
 =?utf-8?B?dGRHdnQxaVNnTnEvNk5VUUYvZTJKWEpnVjZxZjd2ZjBMRWk1VXNrdXkxWENY?=
 =?utf-8?B?cnFDZzZORWFSM3JYb3k1cEw0c3ZBUnN6YTBCeE05UkFIWVpSbTBld3lWQ3Fr?=
 =?utf-8?B?MHFBV2wzTm5WK0NwaDVFYVhDUVBneFg5SEtUSkV0ZFdYWUQzRER3TWxORkFW?=
 =?utf-8?B?V1lIODdVR3NxOHk2UkFtVnRPaERtTXRwTmVmdjIvdVk3ZGxmRlQ5RmFHbXVY?=
 =?utf-8?B?enV6SEtIeU9SdzBLZTVrV3NIR3UvdW96YmtHK0E5bXhJR2VtclhpYVJjM1Bo?=
 =?utf-8?B?ZjFJWlZSMmZOZThrRTFTNlZTRURTRjErLzhEbk1wRDE1Q01MSTNYL1h0NDNG?=
 =?utf-8?B?Sm9DSzFGb1lZcmsvejZFS21OVDBGR29XZHc4dUpMeGZ0NzdFVnJTVHU4ZGJD?=
 =?utf-8?B?Vit6eDB2NlVhTVVSOWhxRnBmR1EzYzFJcE1ZbWFTWjQwUXVEeHlFUmhHc09s?=
 =?utf-8?B?bFR0bHN6Ymp5dzFQQ1pIekJmeUhNRUxqVGh3NUdDSzBKTmhZaUwvL2t3TS9I?=
 =?utf-8?B?VHNJcmNSTDlhTjBObUV2WldqQ3BXNENkQWRUcEtSTTFLQjUrU2Nya2I3MzZy?=
 =?utf-8?B?Y0p0TnI5WWR2U1M0K0lZMzRWTDNoWFlFYTJwc3RhZW10OUpyUkxKTE02NXU5?=
 =?utf-8?B?RStHTG8zOXMxeE16YkFHTVFDaFIwMkZ3RTgvZXBtYVFjWUdpdm9KS1Z6QzdJ?=
 =?utf-8?B?WXpsT3I4YWlWR2JQMEZCVVdRaVlvVDBhZ3Azbk1HeHhvNEE5cjBoUEtoUXQy?=
 =?utf-8?Q?edjxChXI+0g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXhiUFZ6Y2dkZnhSQXNOS1IvK3pnR2xvZC91YnZSMWZzZ0tMbjJGV0xFcjAz?=
 =?utf-8?B?eE9QcUYxYkNDaUJ5V2RJaVcrcG8yTVVJQ24vMWp6aWZxVmV2RWc0OHVtWUYz?=
 =?utf-8?B?bDJ1dGw1elJSc3V3TTBEWWpBMVJqN3JvNGFIODJ2dDNCM3o5MFlEalFuT2tH?=
 =?utf-8?B?akdPRzlqT3JxRjU2N2g0ZG5ERVpsUEVuWUtPcmxRbG4yTW1XSzE4YmVLOWVt?=
 =?utf-8?B?NzFNeVRtTHZLZ25tZi9XMWtFVUhNWE1jNUdHQVBRSmxzZVdKdmlYSVRJdmRi?=
 =?utf-8?B?eC9UT0N2VnYxT1ZNS1lNUWs5MFZQVjF1RXIzQUx3WElqQ2VmWDRxdXNYak9R?=
 =?utf-8?B?WEpJd21ScEgyWlFDdDdqYnJiTzV3eEpFMXNTdDVEaGJYWlRHVWMrZU1xakNs?=
 =?utf-8?B?MnAvUDRXMDE1SGI3Qjl0QkwrMVZBOWd0bjg5aXRuSW1JUmR0Mi9tRVZRWjQ2?=
 =?utf-8?B?R0JXcGJPVTFUMENzVjM0RWRIS0l1TjkxNkdqUGFUaHlxZFU4L0k5bWxFZ1BI?=
 =?utf-8?B?WHE2bFN0Z2RnbXZNSmpQcDYwQVdCUVFuQm1idXpXM24zZXgwL2U3KzNrcW5x?=
 =?utf-8?B?cHViOFR3ZE1UdnNQWVNHU2UvMmtlY1NFNzRQRDFKa0h1Qzl4eEo0TERkZFVr?=
 =?utf-8?B?Mzc3TGFoSzFZU3JxZVdtV2VxS2lZNFY1YkFWalR0OEg4algxY2kzSnlxcDI0?=
 =?utf-8?B?bk11MGxHcHVmbEFJOGMrUDRCcEgxUlNMekZ3VDc3ZWFlaTlJSWo0d1VXdGhx?=
 =?utf-8?B?RWN6NlEyeXJDQWd1SVRhQ1pzMkhFTkNmVC9HZldVSXRQRDBEYVpPSzFnMVY2?=
 =?utf-8?B?N1FzZDcvOEVkc2hYcVBWYXY2YmhhMmhQTXZ4dGxRTlltV1FIMmhqLzQ2R3FO?=
 =?utf-8?B?bmpIczV2OVBmRWxaNVF2Y1lEZEMraVl3M2k4TWUxa0NUQTZ0TkpHMkZSN0Nj?=
 =?utf-8?B?eE1WZ21IQUhnUlZFTmszbWxhRWUyM2FoMXNPbVZtUTh0dk8wcnlHVjc5N01y?=
 =?utf-8?B?L21YejRpSFE1aFFQcmQyOU4zckxwMy90b3ZKSEpOVWhCNW9nRkIyUFFUR3FP?=
 =?utf-8?B?b28wenAzaVo3WHZvSVJaMXVWWWtmaU9TSkIxN0Ixd21MWndnQVNNU2tXNGJN?=
 =?utf-8?B?T0NwaEo4WmROaXlTNzIyV2ZKWDVzaXN0cTgwZ2QyWjRBVUdTTm5JejExT2lk?=
 =?utf-8?B?SjA3Tm9SOU44c3ZIK1Vqckh5cXNyYXpvV2FtcmQ5U1BGZGo0dy81QUFMajVK?=
 =?utf-8?B?RlFuZlprK0FudWJBamlkNDF0RVZMTDBqa0FkSnJLNllvOE9jVnV4dXR5MkZp?=
 =?utf-8?B?UWt3VjhGem9pSzE1SkhpVFFSWERLLzBzRGZtZGJuaFBPR3QxOFpmOGE0Q0Jl?=
 =?utf-8?B?UWZ3aXZ0MjZ4bjZMbXhMdDl4VlVwT0tpY01JRm8rY0Z3dFlwQ0YwZVJ6bUNS?=
 =?utf-8?B?NVR3WnpkVEcydm1QSDJVWmlmQ3NwNzg0UCs5aUlPZGxuWDlhcnhaNW1XK1Vt?=
 =?utf-8?B?V2ZOaEtVWGJQZytwVXlTMlFLSXMranpzakFvQjNaSWNHRUF5VXhCRVZrQTU4?=
 =?utf-8?B?SjZwUzNtMk5Ja1oxNm95azBUMmVUQWZOa1NWdGMyTkNIeFQvZkQ5ODFKK2hm?=
 =?utf-8?B?eEwyRVdmOEVESlNjdzJwd0pRamsrWEVzUW11dTNHYlhVVWFlWk9DbjNnYVZz?=
 =?utf-8?B?V1hQTEJLSWJyQ0k1dmY0QzNDK0V4OC9rM2IwS3owa29EeTk0c1Buc3gvTTg5?=
 =?utf-8?B?VVd5dk5IaFJZek8xd054M3B5bC9iNzZ4UEpJUWZqZWs3akhSK0NXUGRXY1Fv?=
 =?utf-8?B?OEJ4U2ZKT0xyRGpKQ2s5dXBtMEhic1FVZ1htNUt6MnR0a2Y5WVJhd3Exb21Y?=
 =?utf-8?B?ZVozVUxxKzM2NldSaWkya1dTS3o4VmhzVmVaSlVFUDJCaFp4NXMxbTExVjdN?=
 =?utf-8?B?L1BHY2lCdURVWGhSKzNQYUpQdGN6S2VJR1J2eThaSnBIeTYzazRERldEcWZR?=
 =?utf-8?B?R3lxWjgyYk1iMEpMTCtLeFpOTVFiSGJoK1d6cW1oS1hMVFFzcUsxdmMvNlUw?=
 =?utf-8?B?aHFEOG96Nnk2TzdlWHBic3c0ZUUvOFNSVlZoYU1hVWMxWHVod0RLTmlrSkhX?=
 =?utf-8?B?V3FiNE5vOTA4cnZKSkJ1S1dvVkZtc012R29pb1ZkTVpSV0hLRWdrOXEya3NJ?=
 =?utf-8?B?UGwzMzBtMWZVdjc5Q3hUeFBqcVp1TDN4anhMenZLQndmSmw0YUQyKzR5eXlk?=
 =?utf-8?B?MWw5MlVMQjlSbk5hSno1WEh4NkdBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d759756-7ac5-4204-be22-08dde55a4640
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 11:10:04.6940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bG5csJcbewlToA+/IMblxC0CuoDP/OAeCFst80Ib+ZwulmKlQ1oExnPHfk1Yu13wR+MSjTc8MtXJVTgQ3zEK1ZjuQ5TCXCF0T50IvdND1eA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8383
X-Authority-Analysis: v=2.4 cv=WvUrMcfv c=1 sm=1 tr=0 ts=68aee78e cx=c_pps
 a=+PpozFyv/4R/82JvxB1TJw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=pXDFnWviBpLdDA-whmQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 4wang_N11slBhrf6Z8UO7HX7zeUw4piC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDA5NSBTYWx0ZWRfX9L4s+Feh7+y+
 PS51KQe4QVmnGsdm4asvU88y5jO5oIv4C89aULriqeH0S1l8d/JxLFYZhCU4KTBevjF1v2/ssnd
 o2qDh2pBrPsBEjaL4LkXhJJuRWA6i9WwWBPErfem3j1PooJgBttnDb+N50bnzVRQWSnHueyL9Xg
 T/iNrntXf7/FRVW6Mn4soOtWae+Y8DJQ1aIzHm0H3KC4zKwylub9KJWKZDl+p52evf7tMaC6VFL
 p4lE68csb8GQm/UmBwXNDhABh5M0CcdtvZcH64zl0+tfj6rZPjHuR1+hhlA361k6u89oLxQPECI
 xqdQe0HYFi5VWZ3n+xJkTUsJFuB9NeroLgItcr/vHF1g1Ouns+J1botYjBhXmI=
X-Proofpoint-ORIG-GUID: 4wang_N11slBhrf6Z8UO7HX7zeUw4piC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On 26/08/2025 08:25, Xiaoyao Li wrote:

> On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote:
>> The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst it is
>> possible to specify any CPU via -cpu on the command line, it makes no
>> sense to allow modern 64-bit CPUs to be used.
>>
>> Restrict the isapc machine to the available 32-bit CPUs, taking care to
>> handle the case where if a user inadvertently uses -cpu max then the 
>> "best"
>> 32-bit CPU is used (in this case the pentium3).
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/i386/pc_piix.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index c03324281b..5720b6b556 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -436,6 +436,19 @@ static void pc_set_south_bridge(Object *obj, int 
>> value, Error **errp)
>>   #ifdef CONFIG_ISAPC
>>   static void pc_init_isa(MachineState *machine)
>>   {
>> +    /*
>> +     * There is a small chance that someone unintentionally passes "- 
>> cpu max"
>> +     * for the isapc machine, which will provide a much more modern 
>> 32-bit
>> +     * CPU than would be expected for an ISA-era PC. If the "max" cpu 
>> type has
>> +     * been specified, choose the "best" 32-bit cpu possible which we 
>> consider
>> +     * be the pentium3 (deliberately choosing an Intel CPU given that 
>> the
>> +     * default 486 CPU for the isapc machine is also an Intel CPU).
>> +     */
>> +    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
>> +        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
>> +        warn_report("-cpu max is invalid for isapc machine, using 
>> pentium3");
>> +    }
> 
> Do we need to handle the case of "-cpu host"?

I don't believe so. I wasn't originally planning to support "-cpu max" 
for isapc, however Daniel mentioned that it could possibly be generated 
from libvirt so it makes sense to add the above check to warn in this 
case and then continue.

>>       pc_init1(machine, NULL);
>>   }
>>   #endif
>> @@ -806,7 +819,19 @@ DEFINE_I440FX_MACHINE(2, 6);
>>   #ifdef CONFIG_ISAPC
>>   static void isapc_machine_options(MachineClass *m)
>>   {
>> +    static const char * const valid_cpu_types[] = {
>> +        X86_CPU_TYPE_NAME("486"),
>> +        X86_CPU_TYPE_NAME("athlon"),
>> +        X86_CPU_TYPE_NAME("kvm32"),
>> +        X86_CPU_TYPE_NAME("pentium"),
>> +        X86_CPU_TYPE_NAME("pentium2"),
>> +        X86_CPU_TYPE_NAME("pentium3"),
>> +        X86_CPU_TYPE_NAME("qemu32"),
>> +        X86_CPU_TYPE_NAME("max"),
>> +        NULL
>> +    };
>>       PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>> +
>>       m->desc = "ISA-only PC";
>>       m->max_cpus = 1;
>>       m->option_rom_has_mr = true;
>> @@ -819,6 +844,7 @@ static void isapc_machine_options(MachineClass *m)
>>       pcmc->has_reserved_memory = false;
>>       m->default_nic = "ne2k_isa";
>>       m->default_cpu_type = X86_CPU_TYPE_NAME("486");
>> +    m->valid_cpu_types = valid_cpu_types;
>>       m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
>>       m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
>>   }


ATB,

Mark.


