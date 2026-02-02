Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA427E7DEFC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 16:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmwVj-0006mf-BN; Mon, 02 Feb 2026 11:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vmwVh-0006kv-1E
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 11:10:45 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vmwVf-00037H-4U
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 11:10:44 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 612AcVwl3163161; Mon, 2 Feb 2026 08:10:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=6Rz7Q1ZgwoOSJu+FgaZqB/HP93+wSAzjDInJoiynO
 5Q=; b=V1gsLxHQjILnhmM2wEj7XmoNPYjnjUZ7bgR1+SDSwerhOfMWEJxag+vTP
 lgsR46v3pcnO6d08IriUwXDteyE4UgqNyWbWQjkBYTkm6uiPC4mwLVTv7bOQukTH
 L7m8ncp7TPTKlwbbxlhdll4qWy69+owleRBZ1DLOXaUHgvlssDBaP4t14hnOgWGw
 rElSlU3bGUHQguOb+z9vO6S2ewu+7nUc8r50kNSO/HX91zEzhYcPb0gR70J71FM1
 Z2p6bTV107+yJFDDt44H+97jsPkikDRv59I6tWDFv7QaoYjhBkxDaX7UFyub3DqI
 G1yVSOzxoRyZ3f/e/8j69Vrmnc1MA==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020130.outbound.protection.outlook.com [52.101.46.130])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c1j50m0s6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Feb 2026 08:10:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVx6NedEwJ4Wmq+s9gb1FEcAMxYZ5eWXy3soiZ+XPoaavM1wiTjPkZTENl2bXz5P7iktC+TtfNbopUXKhsQEX8ikRL8/yeSSssDSRkZCYlbJdPhK0i6zV9UaYNzLWf1sWQf9rJ60cPF4t+u3mhu51aAT9OS8tRmQyum4fj4TKRiBt0erd6pNobjWimTPxEsI+OlanHbkfF2epbXVjrDIebMtqBH4iaY/DTgDV5yY5f2HnOr0KCTwc8PmnhTG4fo4tsZJkqwVuyGDNV/vyuR8KoDbIiso3XdgZv8ZHYp//91ufrFJWeg26Z24xj3gcE4Xd/XCZ4HKWc1a+L1kHG6ebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Rz7Q1ZgwoOSJu+FgaZqB/HP93+wSAzjDInJoiynO5Q=;
 b=a/dLuv4MYW8UJ6RGYq1cMuMaeHvLiBpnReIH0bSDHzBtmqjS5uI6MTK4Q2PdE+Y4ZY0Wxx9gn/ZiKWoUsS1ObUdDyGF+HU5kcBjGIeypFOfvVBMsqwFM5jCR3XOVZOgqNqHC06CUTbL8ijPsJ+/SpISpcZseTTed9guHAMNmuhP13kqDKQEuieDHH/EB3mcNCBBDYzAjVNNe8XO1Bzs3Ly4nJMB9xkmzLOfd9NcrPBA2fkdizM67SmCaVS+6jkekjwhMx2P3+ono8FUpcEzSbf5AB+mbx4OugbwQSD7xXjVcNpkPESeavQXj9+JS7CMVVlO7S7p8/ewbWUUAlqz1jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Rz7Q1ZgwoOSJu+FgaZqB/HP93+wSAzjDInJoiynO5Q=;
 b=aCQ4JaptrBTTu+SxvRB8CuOSxCTWsCQbwfApVLujcq6FlOCmrOIVcbTObd8U3GMMA6JG7yKjo2rz14g+EpFV9nTSxYUqqUoIK5HJztOqhN5Bmarqmecz62IZeLaTL9beOy3d9uDiH+MzQ9clBNad8FtVObGPvgSAyPaIHyGgCsHs3cqhI6aaGw1if0EKqBlVDLCxwU4K9pswIDoUHtymAS24gSocZYI7dF8zE3Go+rxZRYwJ0nT/3VEduGz4TYr0sNrgwygGq+OsUQlzk5oDEETdoB7RuGRr4KwOvdAoQFTBHZ8eQJuZN+Fa02UHUTOIrV38qwagJtcRTwym3zHEwA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB8970.namprd02.prod.outlook.com (2603:10b6:208:3ad::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:10:36 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 16:10:36 +0000
Message-ID: <1f17199f-fffb-48b5-ab9f-2367b517b04c@nutanix.com>
Date: Mon, 2 Feb 2026 16:10:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/37] audio: cleanups & add a manual test
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0164.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::29) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8688e4-8231-474d-ff0c-08de627599d4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVFLbnBWbjBIVDZXN2ZYZXNnZndPQlkvUnBXY1ZDTWxYMXB4TTM2WXFlRlJI?=
 =?utf-8?B?MXk1cko0ejE3ekdVTm1YbHErc21YdVJYRUt5ckpTT1F0RFNhcDMxUlNKRHg2?=
 =?utf-8?B?ZEl3WXdUMXBMZG1QLy9lQkNyRFZwa3ljaC9UbUtTOGJQZUxnRmM0U0lWcXlU?=
 =?utf-8?B?azBNOVRlYVNleUoyOWpZSDdmU1F3UjlLUXN6TUNhZ3ZRWWJGWHlMQjIramNU?=
 =?utf-8?B?b0U1VENmbHhyWWVONnRTWnRxRjljUkFUVDdkZm1sYWloM2E4MExVL3lLYmVR?=
 =?utf-8?B?K2lSMXVPc24wZWd6S0I0VmdNZEZ0VjVUODF2WitidlhibTFtNWNPRURDbmhx?=
 =?utf-8?B?RWhXWkEzdVpCNGl4dlJ0eGJMSUQyNGxxQ2JBZEE1YitmdTF3MzJ0TkJIdTdL?=
 =?utf-8?B?dVUyb2FhK05FUEJmQTZJV3BkWFplM2hwazZLNGFZdlFkYlRUbWtzcW9ZSGJm?=
 =?utf-8?B?UGU5NGlZcXlxNEoyUCtuMEdwU2dMUWZMR01vTDRJdWY1WUg3RWh1emN0SWpV?=
 =?utf-8?B?TTl2YkFmUnZDaVdwQVlGY09hSWQrUHkwVkp6Ulo5dGY3N0xLb0NqTUI2U00y?=
 =?utf-8?B?QXNRUUlXMWYwZ3FaU0V3bituWU9ublFobGFVd291Y3ByVUh2amNxS1pURDM3?=
 =?utf-8?B?MTkrc2tqN2NCMHdaRWpMMVNCSXZVTHE2Vk1ZSmRqeWhaMEpkNmc1VDRyNWY1?=
 =?utf-8?B?Z3YvTlNCOWlsMkxXUWkxRmVVeUVURmZQYTZaNHdpdGt2Rkgzall6Q1RkVW1K?=
 =?utf-8?B?TGJiMDA0SElPaHBpZGd2RTBtVFA1ZDlaMmFJOWpETnI5S2JPN1NldUxsNVcx?=
 =?utf-8?B?RjkydWJDV2hqKzFhREk5ZVIzcE44OFFoZnFuZ3hsM09XYVN0bnczVlBXWnJn?=
 =?utf-8?B?QXFObVF1bXR2eHdpM0pURlBiQ0c2V1ptVVRYRHVDSHFXK0s2bmN1RytQeXBE?=
 =?utf-8?B?R1cxQnArT0xwTy9tMERuUVdHT0hQRk1UYWhVcWRTUVpxMlRFTnZJV2Z3RVlD?=
 =?utf-8?B?OUQ2NHduVzAwc0ZRTllNa002SGQxVlVFamtDOVE2Tks2UkZQbTdEMll2R1g2?=
 =?utf-8?B?c2NVTmwwV1hvdmEwaU1HNFI3a3dxcEdtUHhoS2xaaVcwYXV3UVE3aUZmNFN6?=
 =?utf-8?B?bnJXVG1ScWJ5TDMzUmJwYUZpNHVpYUFuYlpuRW9ud3NscU5EK2NhNUJtQnMr?=
 =?utf-8?B?YkVnajd5aExaemtQUU1NZnJ6TU1SQnM1alcwN0czbVdGbEZKQ3RINlBxRW5B?=
 =?utf-8?B?dGNlZGpva2FPZVRFZ0pMRlJVT3hNN2JVOThvR2dSWlhPVTFJVzVqeFFBYjVr?=
 =?utf-8?B?ZnArV0lsRysvWTN4NUVRK0NLWklOazN3UmZDcUVNU0lRbkJmbUp3ajdIZkRz?=
 =?utf-8?B?UjVXeVRiM3c3aGhSRzNTYkVyZjM4eE5GV0NwMjU4Y3EwaVkxb1BzS211Mkcy?=
 =?utf-8?B?V3JsSzU1TWJvY0lGV3l1V0Z4ZjB5VHVLLzI4bDZQTGU4MnFpS1QxSW8zR2hP?=
 =?utf-8?B?VnJtSWIycUN3d0dyZnVrdmxSbHRyNkFPb2JtK3B0YWJZZGNrWUpjRkVSRE0x?=
 =?utf-8?B?NzhBcWhFTW5Qb0Q2dUhLK3lkdjJKKzBpNzdLSE45aG9Ta3lEeXVTQ3JMMDc0?=
 =?utf-8?B?UEdRMVlNdTBxY3lTTENIek5WSHdGZ2pSQk9CYVZqRExSY0hHcFR6d2toNm90?=
 =?utf-8?B?WkJHdnRTU1NsUlA1RjNML21OSWZGSlBmcU5hcCtZZUFOWG9nTk5hRUJBU2dI?=
 =?utf-8?B?VWNxR2MxMTFDeUZYNnhDVzBxeW50TFhSL3hUZ3Rpbno2SjBkS2pYNGVnL3lT?=
 =?utf-8?B?WGJSK3J5bzNzNlMyOFdDcURIR2RsMUNLTXNXMEVncWJtbkErQ1d4Z0FQVXJ5?=
 =?utf-8?B?bytxd2d0OGgxUUFzR1RUQkRsMnRnem5WOUFRcHFOQ0c0NVI0TTVGNXdadWVa?=
 =?utf-8?B?bFRmbnRQa0hFNGFQWlZrSzh5NURmRlFPSXVPbHliNGVWSjcva0lUTjFPNkE4?=
 =?utf-8?B?MlRlRU8rZG5tQVBVdFRUaWYwYTY4UU1TS1U2YitnbWNES3QzRmxlK0RaVXo0?=
 =?utf-8?B?WXBOWGkrVWhDZ04reW8wQVZ4bzRUM09nanJ5dXNndyt2VTA1Ry9rNkN5dWVW?=
 =?utf-8?Q?haXw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHNkNXNLQ3VzbW5lQWZaaVZUUlQybFd4cjdRNUdVOEdsK1djTjhlVitsU1VK?=
 =?utf-8?B?UjVETnUrZVVOc0NRNUM3dk1kd0Q5cHFNQjRyYlRSeGZ3ekViaFBMS3NoOVhU?=
 =?utf-8?B?N1lhSzlxU3VDWUVpdytPeUtncEJrM0ZZVTFQYm1vSXNzbFdTM0U4MDZFbzFi?=
 =?utf-8?B?OFpjMWxaaFozZWdzUmZOSFpteGE0UWJwcGRRT3NFb1lIM3EzVmZTWWFkTi90?=
 =?utf-8?B?aFBLa3poWElzMFEzL0svSE9Dbk5pcCtyRTY4MFZidjRIVjJyQkw2RTJVVkor?=
 =?utf-8?B?U3VaUHRRNG5wcEJ3ZWFla05McXl5R1lvN2lpRTN4dFdGMEE1ditENXg4aVRH?=
 =?utf-8?B?ZmZucUhyU0h5eHV0MlZvSURVZXhCMzM5bnN0VzlMU04zU1BQcUFCekJ6ZVdS?=
 =?utf-8?B?ckNKcElBb21PeWFDRkllR1hRS3ZLRjJuV0o3K2tPRmdQenErSmpGcWNFdGhu?=
 =?utf-8?B?V0hJUVlJbkdUS0VteVNPZUFMMTJEL0QzOW0xWUs5STdMcW1kNzN2L055Y21v?=
 =?utf-8?B?QjFqRDU2UkoxeGJkOWlQOHowMWFoVys3cmExRzFpbk9yK0xPTjVaYmNsWmhy?=
 =?utf-8?B?TkNjeVA0RDhoTWhlUGZYRE92dnFJNit1VVhtZWJrc2M3cWUzWmxjY3E4Y2V6?=
 =?utf-8?B?RENtTzcrRWxFc1ovUk9uZnRlY3ViSjlzb1pNemFmY1RoTit6Rm1OSEMxR2Rp?=
 =?utf-8?B?VEM4K2JtZDVHR0ZVVVFYMlRObWd2cGVBVnR6L0RuYzBnc2drUkhVU2p4UUtF?=
 =?utf-8?B?STlEelYzVzJlOTIwVzArM0tNSDltQUJPd0JxcVYzdFA2WmVHQVVWVkxUdnlC?=
 =?utf-8?B?bEdWd054UTE1WWw1bklvQlBwZzFhZ290WEQ2bXdmTUNSUUFoNFQ2MTZZYnU2?=
 =?utf-8?B?MWxLRWROVk1rL0dCeE5xUll3bXdFTjh5VUVKNllVay84T0wzN0xJdHBrczhj?=
 =?utf-8?B?Zk9tTFNpOGQ4TXZ4UUY1cmVGOWFWM0k5K3dEdTNiOGY3emlqMEZ3TEpYcFMr?=
 =?utf-8?B?KzNob1p3NUNMOE03Wkg3ZmFIQzVlSEtxOUsyZGFhZzhRQjFrZ2ZtTVo2RDlJ?=
 =?utf-8?B?UTQ4QndYcXFON0cvL3hxcDNkbHNEVFB0elM2MnliZGtzR2hMWXA2WTREM0F5?=
 =?utf-8?B?YzhseHRoUXJPQzBvT28yYjVBNWxhK0RDWEFCRy8wc3F0Z2dQY1dtY0VFVDl4?=
 =?utf-8?B?cmIybCt5emZnUkdESll2L3NKNXcyYkUxZUNvSWh5NWswMDNaV09NS3BJZmkr?=
 =?utf-8?B?aDdyMGRSM1RzMlV0WUppeGlPUk5BWGRBVE9IMFkwVWQ1UnE4bkc5M3pvMmtN?=
 =?utf-8?B?N0xzbGRZZy9vaXhqRVd3NGRZVzgvek9CcE53WXNMRVllck8xbVZSNHA5Y3BN?=
 =?utf-8?B?cDRMSTd3ZENtUExDcmlHY3lvaFNKUlIvV0VjaXFQQWZqUmtDQVgrL0NUb2Fy?=
 =?utf-8?B?OE9WVHpVVjF3L1Jmci9STEpuanZJVEJBMnBMaTdnUU1mMGNFQmgvRFp2Z3VV?=
 =?utf-8?B?ajJpbXkzRlJRbWlsdnloT3cxQmp5Vk8vS0wyK1l5Tjk4ZUs1ZW1LWTlIWVVB?=
 =?utf-8?B?aVRJZjM1d0lIZEtBam1SUmZWT3d1bkdDL2tLRklzaUZmckpMUDJLeWlQVmZj?=
 =?utf-8?B?b3FaeDRpbDUrVUM2MWdiQzlqYXlQcmpIRmxMa0FVTzdNMW9QdW5kVkxxbFFE?=
 =?utf-8?B?WTkxa0JuVFFLZjlMV3hMZ0llTTFoZFJTUHFmUDBFQmZKRXlzZnp0UUw1eUtq?=
 =?utf-8?B?SFUycFlXOEhhSlhxWjRsd1BFWW1icWxYaUZYR2VsalhDU3U1VUdYUnd6cmZi?=
 =?utf-8?B?Y24rYVk0TmFITUY5bGpQcFlhNUhRaDl4MlNOSkxUM28vN0ZteDVNSjV0dlJT?=
 =?utf-8?B?WlFxT0lScW1CYmhFR2Nab2VVc0VIUkNKc2dybXo5Ny85S244Z1RmRmFxM1JP?=
 =?utf-8?B?WHZnN3pLQ3ZGZzV5MnI2YVdsN2hZb3BWYjdPSE01VytWVW8vSTZBOUsweVBM?=
 =?utf-8?B?K2xoQkg1UXFZYWFhTEhJK2pzWkprbHlTSDNQT3ozUDZpaDFKQkFBRmtiTVNT?=
 =?utf-8?B?RXE4aHNLMnpVMTFGWGVKSDlCMEJJbEZOREtDcGFaVk40YjVYRUVDa3lqMktl?=
 =?utf-8?B?dUZOQWFNSkQzbjh0MXhQVTBkR05PV3NGeDlrbmkvV0RpcDBzZVRSbU0yaXhT?=
 =?utf-8?B?Vm4vTmM2ZVZSaW54VzZYNEFybDJGc1FycDlQakgrUW8rdXUyMnU3WGhuQldi?=
 =?utf-8?B?Q3NyQnhrTmVUVmRoK1p3d3AvdjR5OUh1WWswR1FtTW1JQytTU09BVVhOR2lU?=
 =?utf-8?B?eVYrWUJUQUxMUFRYaFRaak1lNzlvNitVakhmUVY2c0hEcGw4VmNNVnhkMU15?=
 =?utf-8?Q?aWSLE9QtCL1MlTk4=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8688e4-8231-474d-ff0c-08de627599d4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:10:36.6181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYKLzx8bDjaTMr6iVwYAOqTB4F3IqCXA2J7yhN8yJcGHn3s/az9wuEO5gK32Sl28e1RYs6QnRLECvEq/U7KSWExdkcik/LUv48Qc/VuoFV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB8970
X-Proofpoint-ORIG-GUID: u2XPXravVlk39l8TgrCOy7JFoWLopG_h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEyOCBTYWx0ZWRfXzsQ7g6oTLVcg
 8wqeSdxGiIOsLsryo0qtmNXxktwuz2Pi316wFyOm4IzQwY8JVI4FqmMxR57/nil77hdQnEHme4r
 HqbQbhtUotKjYfkLZeYTf6cD9kbngXVukhugKQZNzCLGZjNrC5JcmEt+vW4H6c60IeNHfp+Tbxy
 X2svvE5J5xoZQZ6ezm0Bp63r9TwMs14hkrBFK3OK1UlQsCc9N3qIXDIaePrrnyK0NlSVq3BkeWa
 aN84lETloZpN2RYzTJc7ivvCCfyn2dhetWFjttctcZwbCD+w1kQ8XkeIb/npDQciXKy7L+lPo+J
 n//yHgZGeTlw1YyUj19+G0iGJeKcELPIZYaU2Hf/tL6QAMF76rdK9S/t8L2g7XxLup8RNN621wo
 is/GyRa0hO6qjbROsi7HqZU2Tsy7xJC3uwGC09b3rC7o9pAAzJH0mnsxjqzn89TrRmPkAIKOUhT
 bvKFjRkofM24yCn/XpA==
X-Authority-Analysis: v=2.4 cv=FNMWBuos c=1 sm=1 tr=0 ts=6980cc81 cx=c_pps
 a=9hhwatWKa7/vLw/BZzsOGQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=R_3FxeouoDMaj8naW50A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: u2XPXravVlk39l8TgrCOy7JFoWLopG_h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> Hi
> 
> This patch series is part of an ongoing effort to clean up audio/, initiated in
> QEMU 10.2. Some of the patches were previously posted as part of the "[RFC
> 00/24] audio: add GStreamer backend" series.
> 
> The complete series finalizes the migration to QOM and improves error handling
> and logging.
> 
> Marc-André Lureau (37):
>    audio: remove obsolete/obscure functions
>    adlib: remove dead code
>    audio/adlib: drop ts_helper HWVoice field
>    audio/dbus: make "dbus" the default backend when using -display dbus
>    qemu-options.hx: clarify default audio backend selection
>    audio: replace vm_running with runstate_is_running()
>    audio: list backends as modules
>    build-sys: create a libaudio
>    scripts/modinfo: add type annotations
>    scripts/modinfo: remove trailing ;
>    scripts/modinfo: use in instead of find()
>    scripts/modinfo: use f-strings
>    scripts/modinfo: use argparse
>    scripts/modinfo: make --devices optional
>    scripts/modinfo: add --skip-missing-deps
>    tests: start manual audio backend test
>    audio: constify audsettings argument
>    audio: introduce AudioMixengBackend
>    audio: simplify audio_init()
>    audio: move object creation to audio_driver_init()
>    audio: add QOM module-objects for each backend
>    audio: remove set_dbus_server from audio_driver
>    audio: lookup "audio-" object types, and realize them
>    audio: drop audio driver registration
>    module: remove audio module support
>    audio: keep a strong reference on the backend
>    audio: make list type declaration private
>    audio: make create_pdos() private
>    replay: remove dependency on audio/
>    audio: make all the backend-specific APIs take the be
>    audio: make AudioBackend truly abstract
>    audio: split AudioBackend
>    audio: AUD_ -> audio_be_
>    audio-be: add common pre-conditions
>    audio-be: add some state trace for debugging
>    audio: split AudioMixengBackend code in audio-mixeng-be.c
>    audio: make audio_driver init() & fini() optional
> 
>   meson.build                                   |   25 +-
>   audio/audio_int.h                             |   59 +-
>   audio/audio_template.h                        |   78 +-
>   include/qemu/audio-capture.h                  |   24 +-
>   include/qemu/audio.h                          |  132 +-
>   include/qemu/module.h                         |    3 +-
>   include/system/replay.h                       |   11 +-
>   replay/replay-internal.h                      |    2 +
>   audio/alsaaudio.c                             |   30 +-
>   audio/audio-be.c                              |  276 ++
>   audio/audio-mixeng-be.c                       | 1983 +++++++++++++++
>   audio/audio.c                                 | 2245 ++---------------
>   audio/dbusaudio.c                             |   46 +-
>   audio/dsoundaudio.c                           |   27 +-
>   audio/jackaudio.c                             |   27 +-
>   audio/noaudio.c                               |   27 +-
>   audio/ossaudio.c                              |   31 +-
>   audio/paaudio.c                               |   27 +-
>   audio/pwaudio.c                               |   27 +-
>   audio/sdlaudio.c                              |   27 +-
>   audio/sndioaudio.c                            |   27 +-
>   audio/spiceaudio.c                            |   27 +-
>   audio/wavaudio.c                              |   27 +-
>   audio/wavcapture.c                            |    7 +-
>   hw/audio/ac97.c                               |   42 +-
>   hw/audio/adlib.c                              |   31 +-
>   hw/audio/asc.c                                |   20 +-
>   hw/audio/cs4231a.c                            |   18 +-
>   hw/audio/es1370.c                             |   26 +-
>   hw/audio/gus.c                                |   11 +-
>   hw/audio/hda-codec.c                          |   36 +-
>   hw/audio/lm4549.c                             |   20 +-
>   hw/audio/pcspk.c                              |    8 +-
>   hw/audio/sb16.c                               |   22 +-
>   hw/audio/via-ac97.c                           |   20 +-
>   hw/audio/virtio-snd.c                         |   36 +-
>   hw/audio/wm8750.c                             |   43 +-
>   hw/display/xlnx_dp.c                          |   16 +-
>   hw/usb/dev-audio.c                            |   18 +-
>   replay/replay-audio.c                         |   51 +-
>   replay/replay.c                               |    2 +-
>   replay/stubs-system.c                         |    8 +-
>   tests/audio/audio-stubs.c                     |   53 +
>   tests/audio/test-audio.c                      |  582 +++++
>   ui/dbus.c                                     |   20 +-
>   ui/vnc.c                                      |    4 +-
>   audio/coreaudio.m                             |   27 +-
>   audio/meson.build                             |   10 +-
>   audio/trace-events                            |    4 +
>   qemu-options.hx                               |   22 +-
>   .../codeconverter/test_regexps.py             |    1 -
>   scripts/modinfo-generate.py                   |  146 +-
>   tests/audio/meson.build                       |   18 +
>   tests/meson.build                             |    1 +
>   54 files changed, 3999 insertions(+), 2512 deletions(-)
>   create mode 100644 audio/audio-be.c
>   create mode 100644 audio/audio-mixeng-be.c
>   create mode 100644 tests/audio/audio-stubs.c
>   create mode 100644 tests/audio/test-audio.c
>   create mode 100644 tests/audio/meson.build

Thanks for the work on the series - QOMification of the audio backends 
has been something that has been on my wish-list for some time :)

I wanted to do some local testing, however when I try and apply the 
series I get the following error:

Applying: audio: split AudioMixengBackend code in audio-mixeng-be.c
error: sha1 information is lacking or useless (audio/audio.c).
error: could not build fake ancestor
Patch failed at 0036 audio: split AudioMixengBackend code in 
audio-mixeng-be.c
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Is there a branch somewhere that I can pull from directly?


ATB,

Mark.


