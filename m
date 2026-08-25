Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7768DC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysaO-0000M2-87; Tue, 25 Aug 2026 10:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysaM-0000Lu-Dv
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:57:10 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysaJ-00024q-UG
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:57:10 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PEbXDA538037; Tue, 25 Aug 2026 07:57:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=9zz0W2eV8YDodvCruKzIKn8ColNxrrRHHS/+5MCN4
 9Q=; b=WrfSIR1TmZU2Riu+NWazLgUDkFN5bBYxkOYCvhk57dDXtodCB0Yva9vjv
 xLzYqNEByEnZEiNTn5nognB/yBuJhn2FJLZ5dImPM3utXZ9G0RVXMobOrTrr7Tc9
 0lpWTE4RCLWm2unqDIw21sJqwnQlSi65AngdbkvYTjlck9jEy1qMaWRvsIUJN6sY
 ped1cwdysKqwl0BrB18V8L0r4AfO/44kmRryCjC8t36Aj6izGUXvrR2Gf+lVE7zR
 qzF2McVqz0c3y2lPLy3lczkqXjQEfcOYuJnOjiM0TAOId0DCKjYcX9mj86VlOkyZ
 UBGwm0BGYihAM3GVCa4pSyLl2l03Q==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022100.outbound.protection.outlook.com [52.101.43.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g97as0yd3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 07:57:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/vtRU7JEZzwEpQvlCVpxqUPd/hKrvcGxyQJx8c4iGL6xV9KY7VMOoFbbRocamhLc5uq+OAuuk9HdGdxfdOvfl0kucrgRSX23Pb4Cd1m1yUuhk1k0iRco1EwMBflEs1mIp34Z+Ae/vGXHXxnhazuOxn+4FJ4RTIdUu0v4vitM5ePFG8PXwVkKftHCWQge0NC9DzBiGd2xopobMk8oBsujkCrNz7gRtmXTBkv0sj45LvDLLCf3w9Bnl+bJFAnGjuNNqGM7xurdp6vZtSFU2Gn5cv+9/T1mqywp/Zax6qQPHco+BtnyshRlPrUD4VwyEftNASvhU5xBXTbrrcvzKAXSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zz0W2eV8YDodvCruKzIKn8ColNxrrRHHS/+5MCN49Q=;
 b=t643fnTuAmZx88BPfMQwfi2rKO79JPoLHbO2VVAX6ttpVNua6QK+ypCoQg3j3BoIUeKq4qXqkQfXe5B/t5a/pt6Y+7/uuBl36hzRdcS76hGIylm4YSu1kxpSJNaso1xQPvLNKSeKurlHfTNnqeQRiZt/F4D5ZSLNnezeaUUrGOerssVYfB7Wn9k11rpVveIJjtz2KK1ts3HMG8xtaQWzRtzxHXjDSv2JcX8iH1+J3P4B3O06mxtXQPTK9rWb353V0ssIIe6Da+EvctX2xC4uY2F3ckIUXqsj74ruLlqOjPGI0zSol6avi99UPD0MoHXP+uWWisbp91pV0azjZPLJBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zz0W2eV8YDodvCruKzIKn8ColNxrrRHHS/+5MCN49Q=;
 b=a+eLiwP3NOfw4NlOqKRbaAiabDQDghgiF4wnQmRGqoQO2tIqlinJjWHcstxEJUuyRYIVvR6NSm3VvrxGh/zGD1zApeUAVOKoMpuO7MfunOHZTjLyqTUnBxy/Ne6RXJ/VA96hTVZGZoZ6uZk8zs9ffwZA+YaEqW3sXbMoeFrvte5Arryl7/dcTA7JzjnTZAXlaGaGcpVTr+5HTr7EyczcvPhuMbMsTeRGCuSJQIq2ikAjhSBpiIQoQzWJB/nh+c75eFlqodY+XjEl/aHrJC5oyQJVqkAOHPEcU1vOYUrnPzZ8t995rGJjQEryMdPd98aOn74eyDywyQNR/OzpucSrcw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7541.namprd02.prod.outlook.com (2603:10b6:510:58::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 14:57:01 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 14:57:01 +0000
Message-ID: <5661fc3a-d478-4f18-8c0a-55967cb0da99@nutanix.com>
Date: Tue, 25 Aug 2026 15:56:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/74] qom: add object_{class_}property_add_qapi_enum
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <20260818-qom-qapi-v3-12-24b8bbbe3d86@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260818-qom-qapi-v3-12-24b8bbbe3d86@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:806:120::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a2c34ee-4fc5-4657-c63c-08df02b91eb5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|10067099003|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: PPWRmQkuPyRoaBevJ0HOdjv+HNOwK3Upjj4gzKgWp89xsF/rbCPzeUwkT3l18E98Tm9u3wzSrdAVeN4+/FDhdRlY/CMoyjtQLMUNfcdUzwUW2Mi/RngbYPOF0fj44d67dbN8auV0dNx0WOgY9BsduNdTPyFbljssioh+EPmVvroMdvEw7Izi7EJD2NnNqaZ3J2Mt2FJ0NsZw6SjenPUZCG1yrrSL1+ksXGgmL5p3IqgVnhP9SvbNNVfG+21TtJDEVOWdVQ0kv5E6zI7mRj5o2ElhZzGYcVbh6uOBtUrDUhfw9pfXREV1BNde7VQhzl1IQnzASh0GrxDQZ3rI8KSwJ1znupnqfwY+dipXkN1EmfjCe2TC1V1BUkoVFALpROyB9KV3XWFBkvL1Bl8/3zH3vqWfPBWN/7BQ+pvsyp+/veC8SMagZXI/3MS8KxfwbmwLLFhflh6JI5jQ2IhLmHJJFwhuVilvp/GMhCtC3/YsRBjmilxzw3nzOkCfXtS4Ywb//hR2OL/hF+axRkKkGghPNtN9XFPZ59Uwwuf7F0wN3/1Hqa0kK/1PlNpYLLNDQ/o6pGjITZbGSQFOeK0YWHJU6ZBIyMB8JrafO0B/xxm+vnDIBuIMC5KP08SJfbDoPJG68SxtUUGLTPX6aPOzs3vDTDkY5BLaTZk0H+TFtEk3V7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(4143699003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG85UGpnZTcxeFV1YXhqbnRZZlFYQ3BTdEJuK0tQMjR3V1pJbGRIU3pBOC9M?=
 =?utf-8?B?RzR2VzA4Zzg5NnNwNDJiWVRzdnFhajJHQUsyU2RBR2pqY3NwYThuM1hPQUFX?=
 =?utf-8?B?RXl4SklNUnBqT0h4eW83NzEvRGFya1Z5Sllad3pRekFjbmFiQkxGcGFPZVp5?=
 =?utf-8?B?TlUwdktmbXU4ejkycExSWlBvNFZoN3ZQdnVNZkI4a3BML2E0WlQvdkozalQ2?=
 =?utf-8?B?akd6NUR6VVNEWm9Gc3ROS251bXhIR09rM2ljUm45U2U5MnRVTmViL2xHVU53?=
 =?utf-8?B?bUZZSlN2c2hWWG1hL2NyVHdVdytUM2tPWnVsSUJWelplT2lNZmVQam1mMTBK?=
 =?utf-8?B?a25ueU4vdVFHVDZadnh0UTV0NWdFZUhNajN5VWlyQ0Rua1lOa2R1c1pvM0Ni?=
 =?utf-8?B?TGJ6UzkxZ1hSczRNM05ybWsvcmRTUldpL0xqL1QyNW5HYjZrQXpWS2Zwakh3?=
 =?utf-8?B?Uzh0eXpsOWtrN2ZDdzg0TWk5b0ZHSnhwSXRXWWxmSnBjOE5PQkJ6U3EwN1NO?=
 =?utf-8?B?VmY3NzZLZFdoL3R3cTFzUGNlNlJ6Sy9aRmI2OFVjTDV0QzZuSEpNaVVob2lZ?=
 =?utf-8?B?Mml0YVVDcEdjb2NDNTFJOGhIRE9IQmZTWi9kL2t4Sk8wU2ticXhRcHJvSkw5?=
 =?utf-8?B?OXczM1cyWTVGN2RPN3c0OWpyeGxNREluYm1uL1hkcDVhUkFyZTRCNWFIR1Ur?=
 =?utf-8?B?OE5Ocm01WnJJcXhNSGJUS0JwbHJ1YlZPUzVLaDJFWW9Gb0duZlZmOHBKOU4w?=
 =?utf-8?B?Tmp6NUNBQzJnRjlYQnlvNkloNEFsZW9scEtmMWJxbE9KaTdEdUJoUmllWEly?=
 =?utf-8?B?WXZxNERvZDZYdWxmaFFqT1E4NHZYcjRDMy9WaVJJQ0hmbWlhRW13RmpSajNK?=
 =?utf-8?B?b2dMbk9xTTk5UG1jd0QzU2tMQlZ0K1pScitUVStIQW42M0pBenhWN3FqOW1O?=
 =?utf-8?B?YitDKy9Vai93R3hsUkZZdVgvbnlIMjVnN2c3akI4UWM4T3RMTkFpZGxzZHph?=
 =?utf-8?B?eWIzQ1QzaFlUMjJGMkI5Q3ROS0JkMUlkUHFuUElPZ1dMNCtaZWhYYWpycUUz?=
 =?utf-8?B?OGtTa3FUdWdqcm1URElOS1R2Y002ZHNrOEhJdUVvSUNkUkZHZU1weWNGNGJS?=
 =?utf-8?B?TFNURmR1eDNoWVJnc3FyeTZvQWd5NCtURnpGaEhkL3djN2cwZXhIMWUyWWc2?=
 =?utf-8?B?N21WZ1E2WHRpa2lrd1RodURLYVlTMlhJcytSYjhxcE83Tnk2K29DWUY5cjNm?=
 =?utf-8?B?Q0NRb2lzeGhNckZNeVkxRi8vVXRvM1prbStFd1BwR00yVmltb08rTVVkWlZr?=
 =?utf-8?B?VVRSd0tVWitJQUZXZ09DbjFReTRYVStPRm10VUZiVWk1Zkg1bHQzYzQzVHB1?=
 =?utf-8?B?VXliemVleTJINW1hc2d5UUxUN254WGlDK3M3YmZ2VTUyNU1JRDM5Si80WVNL?=
 =?utf-8?B?Rnh1eGN2OWFuYzNBVm5DQ3F0eUlOSkd3TDAvcGlwejVteDZuZkxQZDFJN29S?=
 =?utf-8?B?S3o3STJINjBMMmVFVlRWalphVFVLbHhQWVF0a0xLNno4LytsK0tJQXUwZ2My?=
 =?utf-8?B?MTgyU28rdXpWWDJmR3Z0ZzBOYStsc3BUTWx4K0hud3kzNnZITkllNEhlV0li?=
 =?utf-8?B?Wm8vN09DZDR2UHZKTFREbHE2aXB4UjZibk8wZHp1dmtXNDhkNWpJTkNqMTZi?=
 =?utf-8?B?ekx5K2ZtU1k1MWMvSEh1VFJFZTJjMUdZNnM4S1RWMjg0VmpRcWV3Rm4rYUhO?=
 =?utf-8?B?ZkhuVnhXUE1ZY0tSQktjc3ovWXBSK2dFV21KeEw3UjFzK3VST1RmS2YyRGIx?=
 =?utf-8?B?b0h5UzBBZjl4azMyNEg0MTBDbWgwQmZ5Y2tzMzZnVTZYNitzbDhzcEE2Y0Rp?=
 =?utf-8?B?cy9qb2VvTGJBNWZuK2h3VzEzOHh6WU1lU1RHRlF2eUxraksrNUxzdWNXUC9z?=
 =?utf-8?B?YXJOUGk0MFp3SkxRMEpIVFlNSzRRUzJXSExIdmpQRWRTR2tRQU9aSXlMQTdI?=
 =?utf-8?B?eDQrK2UrdHc1MUJtUHdyM2FjTSt3TU1sVHM0OC9ETTJsaXloS1Zyd09PQ09S?=
 =?utf-8?B?dlFlWlpSREZLWk5hbVNhM2hKMUhaQlBRK0hDOGdYMW5hcGtJT0g5WVdmWWlS?=
 =?utf-8?B?Y09OSURsc2ZvNFdCYW8wSWpJK1FESm9vdVpid2JubmxvZXhoRzd3R2lsVjZS?=
 =?utf-8?B?cGpOWFpnajRkNEVpR1hjWDlrbU9BVjRHQlgwaXEzNW9LdWQ1OW9xQWkxSExH?=
 =?utf-8?B?b0xZK2JPTDFoWEw3by9EaWh1bm1TaUJyQ2lOeE1jZzVES0dOcjUwY1RyU3pG?=
 =?utf-8?B?UW5NV1lxQnVLWndFek9HdFBzSnlhWlVQL3B6YnZIbkZ3My96alhYNXlaZXU3?=
 =?utf-8?Q?sTwl+7KpEq2S7KQ0=3D?=
X-Exchange-RoutingPolicyChecked: opZHpH46TpeElbxGETsurUJDawnvDI3X7J/cfwMikzVVCCULIR+amlRmnxOitpHxKmlXo/6MxlUrwvzNmJU1NpKy/c7El2TZx0mPAtweHcOVfFzu5VkBOf6HO1mg2+O75PiLfgHjPVe7sh9EeA996QJvnMbGX2iQuUCBS/8+wR5HO3SLlmQi8n2WBqSK+tVqK9ObrMKDKEk23Fl5DUDQ7dy9bSXkiWgN7MCnrGFULHNATXxU7khogi36o8/fuZBqSuaRZOwyxeWVUFO3Ed8ZyX4/k0YDn5kFrRLoY6KkGJKNtijrBnNbKoOabahSoLxtScw5av+aL0gfmPr13EmHqg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2c34ee-4fc5-4657-c63c-08df02b91eb5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 14:57:01.7876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JH4nE54gGRJq365PS+CmAyhMQAD/A2s9EZtoog/t2KEO5YKFVfj08zDaYks+FeeDw+R8EVgJzKyOtwj4E9ULM/rA6GU3gL5HvWGdHlCYmq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7541
X-Authority-Analysis: v=2.4 cv=DJu/JSNb c=1 sm=1 tr=0 ts=6a8dad3f cx=c_pps
 a=Us7513DS1gT4knu3Fiol7g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=20KFwNOVAAAA:8 a=ZyLpNrfXefDZNtA_IFcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEyNiBTYWx0ZWRfXwzMWVS1dFXT5
 jqD7dJYAnsP7cE2bcjEhKhzBprDz9g2JDjxYklmu5gFl+5xyRmtlnzPLdLFoMvuZ/r+UJERS9OO
 osarsjDKHKDGtD8W5hZ2ltChmjvX5lY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEyNiBTYWx0ZWRfX4WasZIPoZ+1I
 8wgsWuXEtHVwdsiFtxyTdXqjBIC1hzqRFbHQwuuMLwZtpxGuv0BLVAVfTrmgKuJnwu8EZq9AwYy
 ScOXKPWO60hkjQvKixdbBi6mlctjgCwwUJ3yu16V/k8BmsLf6Tuur+IK7IpXH8Xev4wJIJbQNBm
 mkoj+HaGu3QwxxS++TdE0B15HuxHFt8+5fVvK6EiuoktxEE/PnJhjpFcAck8ovtJ36p58yB6Kjy
 777zLi6a7r2kPGF9aUju+4kHOADS7Ivyl56Uj7F3G+hEbkIwLcKIPcSGWroVo/pdInxwoZJzs1n
 DeBZ1zNIM2OHB0IbEaECPtftctjPqHoUSpr6BUUBrp4pAkxoMxURC50krQzYq676y6vDqolE19l
 e2N1LAFa9wbZ9/M2nU5kbJE3cARGYa0+rjzh0pF1YwjcDEjoTEqFghQ8TePLPNSxGud0o5nXP9T
 uAX4XIwZOQuZb2Pa9kQ==
X-Proofpoint-GUID: -wJcr2pLnBCUU6EJCfg8xoazm7d-TUVp
X-Proofpoint-ORIG-GUID: -wJcr2pLnBCUU6EJCfg8xoazm7d-TUVp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 18/08/2026 12:10, Marc-André Lureau wrote:

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/qom/object.h | 64 +++++++++++++++++++++++++++++++++++++
>   qom/object.c         | 89 +++++++++++++++++++++++++++++++++++++++++++++++++---
>   2 files changed, 148 insertions(+), 5 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 9684db935d23..a03f4bf8f7cf 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1990,6 +1990,70 @@ ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
>                                       int (*get)(Object *, Error **),
>                                       void (*set)(Object *, int, Error **));
>   
> +/**
> + * struct QapiEnumProp - Descriptor for a QOM property backed by a QAPI enum type
> + *
> + * Binds a QOM object property to a QAPI enum, providing automatic
> + * string<->int conversion through QAPI visitors and optional
> + * default-value initialization during object instance init.
> + *
> + * Use the QAPI_ENUM_PROP() macro to construct instances inline.
> + *
> + * @name: property name exposed on the QOM object
> + * @description: human-readable description (shown in ``-device help``, etc.)
> + * @default_value: initial enum value applied via @set during instance init,
> + *                 or -1 (the QAPI_ENUM_PROP default) to skip initialization
> + * @qapi_type: pointer to the generated QAPITypeInfo for the enum
> + *             (provides the string<->int lookup table)
> + * @get: getter that returns the current enum value as int, or -1 on error
> + * @set: setter that receives the enum value as int; %NULL for read-only props
> + */
> +typedef struct QapiEnumProp {
> +    const char *name;
> +    const char *description;
> +    const int default_value;
> +    const QAPITypeInfo *qapi_type;
> +    int (*get)(Object *, Error **);
> +    void (*set)(Object *, int, Error **);
> +} QapiEnumProp;
> +
> +#define QAPI_ENUM_PROP(...) ({                                           \
> +    static const QapiEnumProp _prop = {                                  \
> +        .default_value = -1, __VA_ARGS__                                 \
> +    };                                                                   \
> +    &_prop; })
> +
> +/**
> + * object_property_add_qapi_enum:
> + * @obj: the object to add a property to
> + * @prop: property descriptor
> + *
> + * Add an enum property with QAPI type association.
> + *
> + * Use the QAPI_ENUM_PROP() macro to construct the property descriptor
> + * inline. If .default_value is not set, the property is not initialized
> + * (default_value is -1). Otherwise, the setter is called with
> + * default_value during object instance init.
> + *
> + * Example::
> + *
> + *   object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
> + *       .name = "policy",
> + *       .description = "Set the NUMA policy",
> + *       .default_value = HOST_MEM_POLICY_DEFAULT,
> + *       .qapi_type = &HostMemPolicy_type_info,
> + *       .get = my_get_policy,
> + *       .set = my_set_policy,
> + *   ));
> + *
> + * Returns: The newly added property on success, or %NULL on failure.
> + */
> +ObjectProperty *
> +object_property_add_qapi_enum(Object *obj, const QapiEnumProp *prop);

Same comment here about duplicating the doc comments for 
object_class_property_add_qapi_enum() below.

> +ObjectProperty *
> +object_class_property_add_qapi_enum(ObjectClass *klass, const QapiEnumProp *prop);
> +
>   /**
>    * object_property_add_qapi:
>    * @obj: the object to add a property to
> diff --git a/qom/object.c b/qom/object.c
> index 1bfb6b933339..f5568b9f9790 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1206,7 +1206,7 @@ static void object_class_foreach_tramp(gpointer key, gpointer value,
>           return;
>       }
>   
> -    if (data->implements_type &&
> +    if (data->implements_type &&
>           !object_class_dynamic_cast(k, data->implements_type)) {
>           return;
>       }
> @@ -1772,7 +1772,6 @@ int object_property_get_enum(Object *obj, const char *name,
>       char *str;
>       int ret;
>       ObjectProperty *prop = object_property_find_err(obj, name, errp);
> -    EnumProperty *enumprop;
>   
>       if (prop == NULL) {
>           return -1;
> @@ -1785,14 +1784,17 @@ int object_property_get_enum(Object *obj, const char *name,
>           return -1;
>       }
>   
> -    enumprop = prop->opaque;
> -
>       str = object_property_get_str(obj, name, errp);
>       if (!str) {
>           return -1;
>       }
>   
> -    ret = qapi_enum_parse(enumprop->lookup, str, -1, errp);
> +    if (prop->qapi_type) {
> +        ret = qapi_enum_parse(prop->qapi_type->lookup, str, -1, errp);
> +    } else {
> +        EnumProperty *enumprop = prop->opaque;
> +        ret = qapi_enum_parse(enumprop->lookup, str, -1, errp);
> +    }
>       g_free(str);
>   
>       return ret;
> @@ -2595,6 +2597,83 @@ object_class_property_add_enum(ObjectClass *klass, const char *name,
>                                        prop);
>   }
>   
> +static void get_qapi_enum(Object *obj, Visitor *v, const char *name,
> +                          void *opaque, Error **errp)
> +{
> +    const QapiEnumProp *prop = opaque;
> +    int value;
> +    Error *err = NULL;
> +
> +    value = prop->get(obj, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +
> +    visit_type_enum(v, name, &value, prop->qapi_type->lookup, errp);
> +}
> +
> +static void set_qapi_enum(Object *obj, Visitor *v, const char *name,
> +                          void *opaque, Error **errp)
> +{
> +    const QapiEnumProp *prop = opaque;
> +    int value;
> +
> +    if (!visit_type_enum(v, name, &value, prop->qapi_type->lookup, errp)) {
> +        return;
> +    }
> +    prop->set(obj, value, errp);
> +}
> +
> +static void init_qapi_enum(Object *obj, ObjectProperty *prop)
> +{
> +    const QapiEnumProp *e = prop->opaque;
> +
> +    if (e->set && e->default_value >= 0) {
> +        e->set(obj, e->default_value, &error_abort);
> +    }
> +}
> +
> +ObjectProperty *
> +object_property_add_qapi_enum(Object *obj, const QapiEnumProp *e)
> +{
> +    ObjectProperty *prop;
> +
> +    assert(e && e->qapi_type && e->qapi_type->lookup);
> +
> +    prop = object_property_add_qapi(obj, e->name, e->qapi_type,
> +                                    e->get ? get_qapi_enum : NULL,
> +                                    e->set ? set_qapi_enum : NULL,
> +                                    NULL,
> +                                    (void *)e);
> +    prop->description = g_strdup(e->description);
> +    if (e->default_value >= 0) {
> +        prop->init = init_qapi_enum;
> +    }
> +
> +    return prop;
> +}
> +
> +ObjectProperty *
> +object_class_property_add_qapi_enum(ObjectClass *klass, const QapiEnumProp *e)
> +{
> +    ObjectProperty *prop;
> +
> +    assert(e && e->qapi_type && e->qapi_type->lookup);
> +
> +    prop = object_class_property_add_qapi(klass, e->name, e->qapi_type,
> +                                          e->get ? get_qapi_enum : NULL,
> +                                          e->set ? set_qapi_enum : NULL,
> +                                          NULL,
> +                                          (void *)e);
> +    prop->description = g_strdup(e->description);
> +    if (e->default_value >= 0) {
> +        prop->init = init_qapi_enum;
> +    }
> +
> +    return prop;
> +}
> +
>   ObjectProperty *
>   object_property_add_qapi(Object *obj, const char *name,
>                            const QAPITypeInfo *qapi_type,
> 


ATB,

Mark.


