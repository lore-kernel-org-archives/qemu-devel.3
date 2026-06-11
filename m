Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CACCD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 15:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXhHZ-0003AU-1d; Thu, 11 Jun 2026 11:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wXhHU-000346-FN; Thu, 11 Jun 2026 11:25:20 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wXhHR-00033W-OP; Thu, 11 Jun 2026 11:25:20 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BEwkBB008438; Thu, 11 Jun 2026 08:25:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=MBSQNQnpf8nhCsknpaDybqOPoxAa2VKie5cWmETkX
 sQ=; b=gFCCy/r4/kBY2B+Ubmqa7/LpUzA6+s7MHSsUq7ieN0aAv569Nos97gn1R
 DqWyc1zhmj7SEeuJq+wOxIQtdtr1mDfd+kf7Du3QOq5j4RZxGW2/sQDdT9VTcLAM
 yvFrPJx2MCA1k5aqSTA+Ka3JN7r36SJoK5WYl2QhsplnNjbrXhyWOSSTC+GimXSz
 t7SLXTY+8JZKiwWfDJK5VpPDVk+6NZ9w6Ja5PDhoBO8fqhpme8Qb3zHotwYrw2B+
 FFM4QS+U1/JHanBgub37GdxB5hdiLUPnREEH7m+UMi7dLd56DpCHU3rUywS6uFLH
 HjPJ/yHkgXGbdudW8XvRoO+J0dMug==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022073.outbound.protection.outlook.com [52.101.43.73])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4eqe5j2faw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2026 08:25:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmrADtShHA+59NKvM8NjW/bTX9npy8+7Xx4C+km5D7S5iYJCcGL14wosjNZpHgwSSnK5W2Y4jLYd7b2d2yqgjSq6gqcEg0oDWcJiE53cshLA/Lx0GZyu5pxWoN5y01wKPHnuGcXfmdhqHyKyU3Opz+oooIuPPeuDQ1K5vWox3VxfptzWogCWQDaZUW/Mrx6Z1Aj+TqKPnpk/TLtHA3J710NSJmQLeCKN7AbmXCy2GmwuV3CJ2F5O47eHmP0ShCKz1nygrAygIIiTjmB0F9dBjX9Rgqv4ccgd9hKQk+xSyyxuSxzI2AclW5jjCTDsz1fWf561wJ6EyjOSA1XZ4ia/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBSQNQnpf8nhCsknpaDybqOPoxAa2VKie5cWmETkXsQ=;
 b=fEK7TmLflWsRoFLEmr1SBm/2bzvArYiEApG9QAfb5Bt6yS3UKzP2Xq3BsHMqA5k1gdtpA0D9sqbsVcDy94RwynnJnjSZooOLlLlo7ijQVIm2jIB/YgqSssigoEXJjJ/fzNe+S22rq4SrRl90nkWCh2aus9CEqmIkM6R0ue7r8wnb/S4H+ZoMMZBGp8J0mG3P/r7tD5NjNtxO2IF68hTOUZz51kbGvQlDKUL90k4dHZqsaaG2GSPjgkaZbDfiJ0bPWJMM9SYNh3mqi29wbtoLxHX0j6J2E3CzEHtWDoei+koiPad72RLoob9SnUdFjIJ2tMNFUPGB0+f9uj/zWKbmQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBSQNQnpf8nhCsknpaDybqOPoxAa2VKie5cWmETkXsQ=;
 b=d5Y2ggbE8NhgSSrcHmRa7NOtzgf3XPz46FVYdvRNWf2y0bvbt0PZauLtsM5cLXe3WB7ucQnnSaXpA4r4o92WH9QpmaTPbPWeOyMUph3sHt+B21c1Ontcu8Joj0/z7WJB1g4aWRYAJxvZUeQrRO3UYbJoSEplz4Qcr+CafYcdR44tGXmUd3t3OCBdUoVf4rsHP9+JanAfLLaaC9ixPngc+vPuBY+8zzkgWx9gMQjH+pWXKTFIu4Y3EHMlRBy6+Bnj85Zy78+PrTO3vqSy1sItj0rBo7kUy+c9zw47T9cj8jr43Qvt/4+CPwbjgwF64QjBCpE5e6m39MHTknvMkFtrVQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV8PR02MB10071.namprd02.prod.outlook.com (2603:10b6:408:181::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 15:25:04 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 15:25:04 +0000
Message-ID: <847d51cc-986a-4054-836b-10e345542b46@nutanix.com>
Date: Thu, 11 Jun 2026 16:24:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] qom: Allow default values for instance properties
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, Eric Blake
 <eblake@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Sana Sharma <sansshar@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-10-peterx@redhat.com>
 <e375fdb7-b4c6-4b02-b2ea-2bce06e4c025@nutanix.com>
 <airDYpBfCyOXqmPw@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <airDYpBfCyOXqmPw@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0073.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV8PR02MB10071:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bbb73da-8702-421a-a58f-08dec7cd9c5a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info: CwTlFDWHMZ3GoVZuVeG3+CQN6dfih2oVcc2AorH6NwUV0189tsFCZfuZvWGmpT/xsKT7JO7orJprBOLAdNWx7CJ59dqnGX0i6ZbHz+N8WGbrGwi9YKG1io3rg0KTF9a8269oDRFDL3H39CcoMYkYN4aN+7UFL3egR38oRWw91a1bAofFo5m/Mq1Vk2R8sx1jZWB8htMJxIwBJppwOCihc0+OGTwZe68jxRmDO7CWFgwJAuYciLeZqr4K2jrWs6nq5bwh4YAuWMH2UdyKshBq5KRTUwWm84a/aGT7nAOYLU0eJfqgkGZBr8Q0OvMxShxVJE5KDHqfJgf28mh9jlKWc8f5AGSnV/NwM5ILDX9YExZK/vIafo6wRAhEvx1kd+OCXUBkbRHypsndsJj/SVHX0R6nx8NUgnPlVjCWTEPNdIok3k0CHRtDKxBfHkPAeGaivYgzYl34kO0BvTOyujvftZuHdo7e/oWcXtB0GqCNYUBG6ULUkfnXEiCssj6J5d3MyMjnO0PYaz+YbWHhXtmt25CdK9KNnoe+RLV2w5oLcYw1Oc4qX+o8m7uXMIG7sh2+bea2f5RqvjcHxjEKR5QaRF0FkbAu5NMIMM8hk/XVw3745egyPu2J2M3SkWE5prsODVWC5617v4QrdL/YeiuO4M4Vy8dAJESR7qvjKbzLj4ltxLCLG2Z53NPzmEglgiPR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(3023799007)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTh3eTBJMG5QNGFQT3U5emU2UU10RnY0MDZrM1AzREpQZ1d3Sjc3YVdGVnpL?=
 =?utf-8?B?RS9qY0c0ZnlzczVNTHJ3YzI3aUMrckUxcEgwSmV4UnU3VUdzSGw1SXNyTXkw?=
 =?utf-8?B?WC80YnJ3Z1cyeFEzMk0xWU5mcjNxaUNNNDBpY0dWRS9QckxHQ3QwRlc4TVBE?=
 =?utf-8?B?Ny94b1ZLek01bzJUUVpqRjZyNE1VR3kyczVON0lZTmpXNWFiRnNvM0UrMmYv?=
 =?utf-8?B?NHpzODcxYklGbHFZTkJtUnpvTEZKSGVpWHdEdzhod2c2UGlncnhhdHpHL1NP?=
 =?utf-8?B?OEpYdW8wQXBadjBtVFord1Z0Sk1EaFpyVzZ4VlNNWW1nOW56V1UxRk1KWDZn?=
 =?utf-8?B?aWZJOEdnV1JwUmlLZ2ZMVGg2UVVNME53SEt3aFZQTHRaNGt2M2RYejNDdlRC?=
 =?utf-8?B?elF3M2FwNFVrdjh4NTFQTlpMOGk4Sk1iL090cXFtMTRTSWR0NTVzeG5wTjlK?=
 =?utf-8?B?ZXRxcVNnbWtkM2JBaWo4Q3BBUVV5OG4wSFVBbVBHZnNaK1JpbVFqVzJRSnBY?=
 =?utf-8?B?RHhCdi9qanI4MEdQY1Z1Q2lqaHhvU0xDUHJwQk94eXllc2MyeTB5d0F2bnVZ?=
 =?utf-8?B?YnVUbjdqeUVCZFpoVnpDSWl0NjVBMS9jTVZyaHlqWDVLNkxUVS80dTJJV2N1?=
 =?utf-8?B?ZmxWWjE1Zk9CRVEzQk8zbmcvSjRBQzhUTFhXSkVQWC9xZHc1RmpQVGRnOUdY?=
 =?utf-8?B?MkZzcjltcHZDaUdpaVdsUjdFY0tLZ0tBbW1KOWpJaUwwdTZBWVpKRk1jaDBp?=
 =?utf-8?B?alRQT053ejdOTjFYLzdXZGJ2VTF2VERiU2tBb05zUWJPdDVJZkkwSTJkdjRU?=
 =?utf-8?B?SEF4aTViUzJsQzVsK09mOWFGcUJpbTJNZEIrRlc5OHNEUkRsUGlpOUVwQi9L?=
 =?utf-8?B?UFgwc0ZJbmw0c1RCYUJxVkpBOUNBcytOK00rdW1IU1NuUEtGeFhuS0JVS3NK?=
 =?utf-8?B?Mk16dWkyOFRLQXlQVGZMNnhydGE1MDRxNXB5SGd3QmJPcXhVR2tKTGpURWRX?=
 =?utf-8?B?UHFMT1M4VGgzS0d2ZVZTQ0FONTN6cDM2SUhnL3hqdCtPaXZ6ODdzV0FDYk9m?=
 =?utf-8?B?OVloNFRSY2FhWXg5OXU3cDNQaEZ4THdrMVhnRzdGWjRZK3B1a1kwSFN2R0o2?=
 =?utf-8?B?NWVvakdzby9FWU9NVHhkTVdVQ2FjRFVCOXlyQ0dxVDdUamhIcTV5cGNLY01K?=
 =?utf-8?B?T1dXbFZPMDJlUW51MlBtajllalRveVd1ZkUyUzJ0cGxRdUhCZWQyMWdsRjRr?=
 =?utf-8?B?REFZSzNvVkM3VExpbno3aWozc3o4WTIyYmN4NG45T1piUEJicGhOT29vdlVI?=
 =?utf-8?B?eERlcXUrSTkwZTRTWUFONGsrOWNmV1d5WDRvRkxDUHc1RkpTM3ZEd3JmN2gv?=
 =?utf-8?B?Qk9SR2FBQUg2bkZkMVgwUUljQ2RZRGhUVENKd3VpVUJESFA3Y0JjRU96OFRP?=
 =?utf-8?B?UWk4VFc1bGtNRzNqZ3crQ0c4SnZCcUVNbnNnbzcwdGVIR2w4ZE9UYVNlQm1X?=
 =?utf-8?B?MStnZ0FmOThTcDBDN0l0OXE3SW16cmMrWjZoc3lwNDlObDFRamZIYnoxanZh?=
 =?utf-8?B?cXY5WS9rOVJ3Zm5IaVVvS1IvMzlvSUF6VlQ5OXYwNC84NWhiRjJCdFliUXdm?=
 =?utf-8?B?OHdLLzhsUDV2b1I0TXVaN3VhbDNLWXltTFdBTERjMVA1Qm04VnEwczZhWm4y?=
 =?utf-8?B?Z0pvRjJwaDhyOVNZdjJ1cnZ3OFNLZzlzTDV5MExlQXNCVFRuVmN0NklBOVEw?=
 =?utf-8?B?ZExWZm9KS0pVdHYzNW5IMmo2WDdPd0R0SWpoN0hzOFBDbmcxbENveDJhYzFD?=
 =?utf-8?B?ZmZGSzcyZHJHQVhpNHdKVnJCald5Ym53bi9YWlpGMzEwRlczM2JaZEh5Q1Bm?=
 =?utf-8?B?NEUzNkh6MGhqVWx2aDRjTEg5VDVzSFZ2b291bGRydi9ib2RNTFBWNWFJajlq?=
 =?utf-8?B?cDVXajBMdVhTVkNqSW5GZCs5UVgwTU0vTjZ2ampDWDY1RTBYV0RwSitvWVlW?=
 =?utf-8?B?LytSRjNEdWJSd05xU3FKd3NseS9RSlJXdkgxc0k5UTJQSjg5NXN4S0FObDFD?=
 =?utf-8?B?UGVKZGtQNElTOGQ1UjVhS0lvQWpDeWN4RlpxeHcvQTVTd0o3KzZ6dnErSEhr?=
 =?utf-8?B?aG9YV3FhUGd0azZGcVVLZkZFZU11dndrVXRnNVJENlZFMmxWdk5DNmJiZlRk?=
 =?utf-8?B?bURPcThjUFdXeUNzT0F2RWNSZlN5UGlHYjdzdDI2bXJaTkxTVElnMHBSNTlK?=
 =?utf-8?B?VUZhbllFOFFtWWhnQitVeTVZMnZwMCtPeDVIL3loWHJKTDNmVVBNbE12d1h3?=
 =?utf-8?B?YUh6NVlZWU5JUURBR2hCa3JTZER2MFdJU09kZ3hZN2xNRU1iT0pGV1VrL3hL?=
 =?utf-8?Q?xpC+vuuahSYWAeF4=3D?=
X-Exchange-RoutingPolicyChecked: TV75UsBHZo4V27Avqnr0IrtIdqItiDq+XxA8DmoceQE6GDVsxW6C+0QgIRU17RmNT8heNeIhcq3aWltXcNkyGOZclPGtOT82vBVXxGz0z0b3QNULXKO91JqpQUgNm+Vn3X+DIevug6Amj7hGIhHLi6Z/pNXP1RQty4VDGf3yXvreKgcPtZWpEIXpzxA8wxDrLLcBfPziyRsPpr3tmCKZzBkmBmGUAwIkf4QmwhurazBmlreRkKo4UXBdX36DIE0DyzQmbVv1wKe6nzfQeuS+jw3aCVKbJIqsaChQuHCkTGBel9HrazqAvtEcTJ+5qFIeM3Fjmhrn0G8fvtR+2f6fHg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbb73da-8702-421a-a58f-08dec7cd9c5a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 15:25:03.9605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YoZlIZhYCbxgQcV7eTEXFFAkrjaob9RCx3+4Vg8fcfNqZBMiNb7zsjxVVh94c0woiWFhYGuK6sLYG81eD8TtzfnXFJKEyufu/WKQzx56xm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10071
X-Proofpoint-GUID: -4JUGJQ1ozjGToDfCiOe0vr5F4ZFa5qP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE1NCBTYWx0ZWRfX7KIk/OnWIQLc
 KGqm3ebe+2SnTLO4KCkk/hbf3iyGD0aag5/oeft8EgPfUbd88QsyQxe6bF9nS7t1+jbSR8i/xY4
 dA4VYa9gO4wENTwWBsxPec1F6OUFCpE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE1NCBTYWx0ZWRfXzKDTwwu84GJZ
 xADDytSOpKQeT0TQVTm6jySHs07w8Kq6x+Jsw9hrjk8pxirq9yf2LoVGuTSas0FqsnEtMh3i67j
 nAo2FpOA4xNPqcSO1tHF7m7WqLEpTzEeEfWefMnHvLcr22qqNMubTa+ry2RDDi2fB3eujDoh2pl
 T0P0HT8Locvg31VEKYCNozEqYo9yhvYkDS/7T3AL49L5zzDCsbSmZMG8EESGqFLk1J7nmPS1lg7
 /xxri+i3GcvfN+ss/TNxmBFf3eFVfThf+ZAQPW8OGq8lN3TtxfMzkLS3+PFZDTQfHGat7OQUQSf
 jK/D7Ox66FTiohJFqun7LurFXUjqXBapfzSVyHUL7WVMFgIM9eec3uq80jri3k7fOiXdMZr+oCq
 cW8fJ9o8bToh9DpKXTd6m8pm6cIPaF9YeOT8FwC1O8IA675MRz/8M8qnmQUHQnzwQcQUMXwT0Dk
 pROurzUwvAg7zKsln5Q==
X-Authority-Analysis: v=2.4 cv=OfKoyBTY c=1 sm=1 tr=0 ts=6a2ad355 cx=c_pps
 a=rss2Ezl/rPWt8HBHL2MHqw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=No7KOe4gR38AFHTK4wcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -4JUGJQ1ozjGToDfCiOe0vr5F4ZFa5qP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 11/06/2026 15:17, Daniel P. Berrangé wrote:

> On Thu, Jun 11, 2026 at 03:08:41PM +0100, Mark Cave-Ayland wrote:
>> On 09/06/2026 18:25, Peter Xu wrote:
>>
>>> ObjectProperty allows default value settings via proper setup of
>>> prop->init() and prop->defval.  It currently is only supported in class
>>> properties, not instance properties.
>>>
>>> However, since QOM allows class and instance properties, it should also
>>> allow instance to add properties during instance_init() and allow the
>>> default values to be applied properly for this instance only.
>>
>> Thinking back to the earlier patches, a question that has come up before is
>> whether we should require all properties to be class properties?
> 
> Ideally yes, but we have the classic QEMU problem of a big pile of technical
> debt that would need converting and always more interesting things to work
> on.
> 
> Most is a boring mechanical task, but there are some awkward edge cases
> around dynamically added properties.

That's true, although we already have to handle this given a codebase 
with the history of QEMU. The most important part is often to take the 
decision and enforce it.

For example, we can take the decision today that we all new properties 
must be class properties but if we do, then we also need to ensure that 
all code reviewers are aware of this and enforce it.

That leaves the issue of the existing code. Our normal acceptance 
criteria is does it pass the regression/functional tests, so I don't see 
why we can't aim for that here?

Back to this particular patch, if we want to make the decision that 
class properties are the way forward we can at least ensure that the 
patches is written in a way such that object property support can be 
easily removed later.

>>                                                                    IIRC one of
>> the motivations for this move was to allow schema introspection, but I don't
>> immediately have a reference to the original discussion.
> 
> Better supporting introspection was the original key goal, but also
> reducing memory footprint for classes  which have 100s or 1000s of
> instances registering the same props over & over. Introspection against
> the class means we trivially avoid risk of side-effects from instantiating
> objects and not completing their realization.

That does sounds like another compelling reason :)


ATB,

Mark.


