Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1EFCC6B24
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGwjq-00004v-D7; Wed, 14 Oct 2026 07:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGwjo-0008Vy-7A
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 07:01:36 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGwjl-00026v-Fy
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 07:01:35 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E8Bfbw3105948; Wed, 14 Oct 2026 04:01:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=/h5X6ade0D1KIgeNMgTJgrE+TeCtanc/wn/Z6/pSn
 Ho=; b=QlSMOEG23qfShfEShRW/RaP+lfjAagXsF1d48LnulJPlxSMqY5kg4xNSu
 ADKx+auj/Cd6zt7iuU1YpFPAMLaHT+xZD/992ycQpYVqMHno1o1ilSoa97RGIHL7
 118/xrf1gNSOyMcnZnrBRC6F3qzN9JKQEW1deEiyedVDXd9V0jzuXIEqJONtNEWB
 nGmjK0Qz6GB8xJQLf0abfhkehkLt5E9zfmnglDbc98l5Ud8Ydb+2skz/OZahGRob
 pE9RXkf/i5dvKOc6HUfDuqI+qQcICAjmYr1HzgGulHOq99sjCzDOaKbYd7ipETgv
 Tg1FhkWtO3Q3txlXbcwC/kMimFtjQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021101.outbound.protection.outlook.com [52.101.52.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4h9nym2uv8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 04:01:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Edg7kCsQctUWad08IM+inWPJzAThecjhyFfxB78R9JcIMoUk/yPkq4w84qw5z0aSwZLTlq+mfiJSJ3SJuyzLtMvIgBkizLng4C0uD3a/WFRBcO7gnROrr+71P7HZ60fGgFchGY3BZmpoghJrW5uZiA7QuTKbaNZqD21736Ptj7gseSWF+7U8iDBN93txHrDwGLSQ4b4wtvIo3flfUajg9YFBgjOPCox0e/fKHXj2so5AQ+6RaQp3YFgE4YFcQL/r7Bwlc7bs+QgNZx31UsoSWsAyYTgrOeM2tByEXudTpsNZmcrgBD2b7fOB7ii0HiUmQGQ4Pakb4fUF0xtnOxzrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/h5X6ade0D1KIgeNMgTJgrE+TeCtanc/wn/Z6/pSnHo=;
 b=o7aIYXF7q7lFnkNiXV6VBInmUOkqDbsokZXBjLiVlszNeUKpRBIkQDpNpmRarTfRYzUOG5Q40tB0uLyNeRNODSFTekCU/7xgy0t3eqs0OXWum69Syl6PEMMg4wk5KQmVxRZblTXO2TKacbdolu7jtOTVJa/xiEsQm+NnufD3RhJ9Q31Tki7r/onYCmq8OLtm36Of0AhOXSd2J3OoJeLddpoodOmDIOUHvQ60DrD5PoN5DVtnnsYAEOoV5z29TZiDu7++F107CE+uocPK5WpUKLdmwTa4//2EP/0xlSDbWJ8xaRjM0P45yKyri5VNfS3CcjlqmeNSNQviPQeqd4NuZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/h5X6ade0D1KIgeNMgTJgrE+TeCtanc/wn/Z6/pSnHo=;
 b=jcZskxjl4Z76EDAkMGlyZEdmqxXMA4I4pAUWVhrug5bura3gRhJ9Nzk0x/IWydTX2qO2YqyJoIk6zzVsFRWsDrHjCEqzJ4E+jhIKA5CxAbfxqRSeLvc3Dt/26qA366ey79uz9cQiZADI3oQH1aae5ZDpNXe+Q54T0Uo9tzCd+LbneyYl2U2eCgUqVrgv5zfh31ub/U+Wa4gripOmvNZfuTkmaKlqQxOzJQbiVMd/PqzBQbg4YFASauCLqvxs81NfoR1BThvComNiiWiwn2TJfk6yXj6QrBsMI0ja4ukL8D7A8B3ng1NJvN4BgV/zTQvvqVgnpt8rijLuMsc7HZYWAA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA0PR02MB7209.namprd02.prod.outlook.com (2603:10b6:806:da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 11:01:24 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 11:01:24 +0000
Message-ID: <64f44dfe-2a44-46a0-8dd9-53d1a1aaecaa@nutanix.com>
Date: Wed, 14 Oct 2026 12:01:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/22] i8259.c: use i8259 prefix for functions
To: Peter Maydell <peter.maydell@linaro.org>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-9-mark.caveayland@nutanix.com>
 <CAFEAcA9MzduZYdWu6VSot8SLaQi_MaeKJdJCUS1YdPWb2y47cw@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAFEAcA9MzduZYdWu6VSot8SLaQi_MaeKJdJCUS1YdPWb2y47cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::23) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA0PR02MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: fab1b8e9-0b62-4999-4069-08df29e27cd7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|4143699003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: TM3B1roEPsFmcC7jxz7zUAzAK6OnPrRC2IBJHaPW3e55awn68AFK7IdG1ZGORRnaAMiuOYMIE9xVd2y/JlvGsLyUF4DsDIxphPGlJY/FzbIEr1aJfuKQBjh/Cf07YzXQ/BI2D4EXT3raQWTWBoVhr2HsLk/bNPta0W6rIHsLikeKekFujCIqA5CpXKGYeYI+sf+61TTHjfQDKOXEBfu43tX0EnTHpilhR1vXbQsw87Dji+OYPKl8ZWmyMPvSv8MNpFHpY7pL6JavEXRSYt3IwirjOXwWk7qeZJH+P6d7+VFXaj5gwbzhtoSaV9X/P6LI0hpHbqlQYa4Xs/1VR7DuUGBi+4MM9VlmrV/wq1roECsE0hwwwMUpdbYn6fqmfRVsUHuwphHKmQh7n0koq0LP1jMEH+YEV3QDymY3S09YlwH/haKeWsoLx8DOodiXo06WRAeSfxOP9bn/EBwaNifR/6fLbLkwE7mafka17vDOoIB4F5Lhq/ngnaFKDvSrlLFx0V4rnhoeG6OfFEgQri7Xr0WZFvX26xRZ5vrr7yLk6PfCePUxCNDnh8NiPxwuGmD5C/cE93MvK88/FzRV4jG8aDjVli0DOxZpTuDwkNBOnys411h/+phuFFdsXkdzulWr7gmrg+BlRFtCBV6zLTKtvUGrtV66ikb8OD5AFoPlLds=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(4143699003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1N3ZlhkdmtYdmhtSWJiUnZ2SGIveVppRk0vazhpdkZyNnpMTFk1eHEwaHRr?=
 =?utf-8?B?MENoTHlaS1RFbXB0SVMzSVRUekpadXIveHRaV0J6cVBnZXJYczRBTmg3ZGZR?=
 =?utf-8?B?UEdpY0gvQ2lSUXo1anFoWDRZN0l3QnpZSHhvSXRseUIxUEIyYWsyQ1c0ek5o?=
 =?utf-8?B?TlZXS29QbW5lU3BlSTFGekh6V0Y2YmZsMWZMWm56dnVZck5CalBnZ0dWb3Iv?=
 =?utf-8?B?dkdYNVoweG43OUhoYnJaU2ZVempLYW1HTlQ3dkx5RndXYlRrOERjb2thTVJh?=
 =?utf-8?B?NjVtWFFsMTVsaDMrTTdEWjF0UTJFenc4WHBnY3h5b2ZmZlpxU1ZEcTJPc0py?=
 =?utf-8?B?TkRRcWY5Yjg3bzh0bVM5d21KUUxENjBqMmt6ejlKekVTa29TSVFITjlYc0hR?=
 =?utf-8?B?Vmp1RFRhNlh4YXdaUVg1UVc0MjBnbEdSQmQzRlBQTm1vZW53NWpxYUQwa1V3?=
 =?utf-8?B?RUs0dVl6ZGRiaVRNL0E4Q3dBZ3dhYWZUWmtvZUJTUGRFc1JrSmlUczJGelNz?=
 =?utf-8?B?YXNDRklOS0JMMmxiajVBS2Y2TzhmUkM2ZWJ4L0MreXZwTkpIOUVrNmdPY0JR?=
 =?utf-8?B?RXNVV2dPTlF3Rit4K0JnY283dExweWlaUXpqMkladEVuWFB2VG5hL2NCSGhN?=
 =?utf-8?B?NmNkMlR4em1Jb3RZaDVYaE85cUNNYjJqdVdydERYc0hBQkVUeWVpb1Z3LzJ3?=
 =?utf-8?B?T0JXMVJLK3E3cWRBRTBvQTNpK3lFblgzYlB6ZkgvL2JJOE9uR2hoMm1JSnpo?=
 =?utf-8?B?aUlETm51YzVhQ29iQXdCY0wrUGVIa2JRNmZycEd3cElDamt0TTNSbnZKclJi?=
 =?utf-8?B?VURPTklsZjRRLzFtanBhZ1VDWkFTWk56Z1VVZlplVVQ5NGdQaW9QN0JBVG5F?=
 =?utf-8?B?UjlmeTlrL0QvOU1JbklxT0pMcUlMZStQd25TckhUVmZTRWNzQk9xR1JHTitt?=
 =?utf-8?B?NlhPM001amExa2Y3VkY4K1RoSHRCamFMUm5SUE1JRDh0eExQek5tK0EwTkF4?=
 =?utf-8?B?cHdRcVhkaXZQR3ZrS1hOZXEwVHZXOXVtaURlcHNpdFowWThvK1l0dUhGenRy?=
 =?utf-8?B?c2lmNEVvNXV6dE81Vm5zY3owU1l1eEc1MFNwb3JyNFl1bzVCeU9lcTRaWTBn?=
 =?utf-8?B?eXBIUEp5UWJ5MjdhSHVKc0lrdUJvMjhCWS96eW1DSkwwaTRvKzk0dzgrU2sw?=
 =?utf-8?B?a3F6WGVtZEN6WEhaR1o1MExYdVdSSjVWUjM1SVJ0TjVRRS9rWFA2dS96NWQ4?=
 =?utf-8?B?WXczRDRWb2hqVXdodjRzVzhLb1JoZzJaVnp6Z2FKZW4xM2xBdXFybW51NU1x?=
 =?utf-8?B?UUhTZVA0S1ROZjNzM0NuRkpPQ0g2RGt1T05FVDFWTk9uSXc3WXBhM2NYMUg4?=
 =?utf-8?B?RGxaN3lPT25mS0tXY2xNRUQ2dXRMZExSeUFnQzVXMVZIa3BUekJ2TzFiakp6?=
 =?utf-8?B?L3pzZGxQWU5BQ0ZRNGtCcHZZazJsYm5saW5yVGxQL3Z2VmdMUmdJK1BHM25V?=
 =?utf-8?B?SHU2RC9JZlhMVmFUREtlaVB5cENOUFpMeGllUzFkakRVQUxRRHhDMEIxZEx5?=
 =?utf-8?B?NUpRZzNjbkdwQ1NqcEk2MDZ1WDNnZ3RiMjRIb1FTZCtuTVZqRWhxd1l3L3RX?=
 =?utf-8?B?SXpYa3ZFRmlUb1M2TUVXcnJnQnIzQ0NKaXFENzlMOEwvcUs4OEFnOXExOXFV?=
 =?utf-8?B?eThKbUJLTUVyLzBUWDVEVldYem5pSGp5QjgwWUI2eXpYMDEwRGR0cHBVL0JI?=
 =?utf-8?B?MWlmY0xEKzNCYzRKQkU3QXJzeEFvenR2N3hvYWJmWmQrSFdSNWRqSEYxSkxN?=
 =?utf-8?B?a2J6UW5jUWJiSjRBSU81NjdzYjFNUXE2WnhYTlc4UDdieFdXVEFEMGxxVksy?=
 =?utf-8?B?eDY5QnE3SFowUVM5ZHF3Vk9GUnVuck13M2p3anlJb0l0Vis0ek1XZ2pPd0lR?=
 =?utf-8?B?SGN2R0JtNTNsUkJTNkFvcW5aTFFBbnJTVGhjY2psL05PcEYzSUZLR0tUTE9p?=
 =?utf-8?B?WHB1K1NLYlhOM0NSblVzVEJ6dGl5VGQ1ZTJTNThJTHlnOXplT3ZKQjIwSHk2?=
 =?utf-8?B?K3hCaExJeHJsQ21ONHloNU5aNXAweU9KMGZDZ2s5WWZodTR3NmdqZDFCeGhj?=
 =?utf-8?B?V2I3a0xEUU1LTmFpOUUzVmNDZzc0eW1PdnVMRFlYQVpjRnEzeDdlSG1MUHR1?=
 =?utf-8?B?Qk9mb2hBTDNFU0ZmaDg5dWxSQndiZjljMTR5UnpCemIrQXJQL0d1NG9Cd3ZD?=
 =?utf-8?B?L29pR3dCOXZoa0ROS1lqZVVPckpBZkZFc3N1WWZ6aWhXOEZZWGdrdVZsWlZD?=
 =?utf-8?B?VnArL1NrQk5PWitMa25GZnhEUjl4YnBlSVJsZXlYYXdHbzVZU2Y2Ly9PUmNK?=
 =?utf-8?Q?mSSrJVLXPFYfpXMM=3D?=
X-Exchange-RoutingPolicyChecked: oRSjGyR2IkFO1q2vHhELQO2L5c8riDPZys9Fjvo4t+yFjPcfikitb6MPPE11t/VFVXeG+YM+sYYzH+M6kyv5838GrsiWGpfu4TDz4ALn0EaBDnYmf1Qd/Gvy0rTuFWuV/8XbvJY79PoQ65BvxGs3FhDdUHqJ7MLXKmS2hQ49Yhsu0rnBjC5e8yQuPgNYMQCi9fkVZ3MrLAyU/gJBCqA2e1GMSAE4c4wldgumgtYBcMH1HoZazcGKI8M2uVkY9UIBonww6t2UQRdsoBxmh7iScSX70S8l/6qAas0p1WlNQdIbYezeu3OYIGEKAgBFAYhr70o2jOo/gDU36yHu8AM0Dw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab1b8e9-0b62-4999-4069-08df29e27cd7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 11:01:24.5951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xT7mI8jsGJlPxIljHguUyhCZ+N8925DKfYt1uQ3RAyVaUEbm5pu0gr6bpW4qoypRXohQfRPqVJl5VZJ5CAamiJsSlaYt9drkulTiXpGVYN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7209
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA0MyBTYWx0ZWRfXyu8/JglFJp+f
 HZaEd0NWJ0rNcoZSAc3wYh3tmtuHiiQaZCIlC2J7sDm+btpiqM44X0HqLHXa+36CWr/0b67RXH4
 BoXYx++/uCpYrv6xAnelsz4rHDc200ayhBW71muf7pj6URumIHTW9mSlxwqrF5bgsD95F0+adLK
 QpTmcB/H8LWIjlNebty2d5EwIra+k266IooF5uoQcAIyrCPYUq70CZG+pEJwdwZA3WU19SPeYkc
 nxZLZfkMcIQavmP917+XHhcLnP+gCdDlE8mXOQs1Wl4E6b+SboX+3vVB5WnS5mHanaiaBzZvys2
 eR8wVVKXVUAy0e8EHx71YFGastkUdTSFQC/Tc3a6RHx18TWgXdjNV8O+PGYjnRQkhxEaoQz3Ntn
 vMUhq6UEZVJcmUEWQybt0W9GIQXJ56HpEF6zHOQmHbkFCBxIGKbm7gYqRAIlL6Fsgp3p1ImtaWr
 RkT1VZNVxEGaotYqNEg==
X-Proofpoint-ORIG-GUID: 42QwuES6200Ydmh-CpijHrmnnDXYbpYb
X-Proofpoint-GUID: 42QwuES6200Ydmh-CpijHrmnnDXYbpYb
X-Authority-Analysis: v=2.4 cv=OIuyTiaB c=1 sm=1 tr=0 ts=6acf6106 cx=c_pps
 a=3cYuoP5kWG2k1oDcrssWdQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=VlnWKJzpNakxCJ2wiJAA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA0MyBTYWx0ZWRfXxcVNmcaxvyRK
 TCHB+WwDD6anKREk+sJcGuV/8utMT+YhkugqLOT2Q21YSqxg3wTsPOmXmzrL3fxe0sUVhlHaEHa
 DxJAqgjSwe9vV11KVmFUs9JitwO+Nhg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 13/10/2026 16:58, Peter Maydell wrote:

> On Wed, 16 Sept 2026 at 11:49, Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> This ensures consistency with our normal QOM-based naming convention.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> FIXME: rename trace events?
> 
> I recommend removing FIXME comments before posting patches, it avoids
> the possibility of reviewers suggesting you do the extra work :-)

Ooops, sorry about that :)
> I don't believe we make any claims about stability of trace event
> names, so we could rename them. Should be a separate patch if we do,
> though.

Okay I'll rename the trace event to match in v2.

> For this patch and with the FIXME line removed,
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

ATB,

Mark.


