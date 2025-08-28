Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27FBCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 10:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ura5T-0001ZJ-3X; Thu, 28 Aug 2025 06:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ura5E-0001XU-7i
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 06:42:20 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ura5B-0001i3-PO
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 06:42:19 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57S8Oucf1758401; Thu, 28 Aug 2025 03:42:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=+lVxrUxb11kdPySmazdQGCnD73JrH7KUFJGR4Sc6r
 4o=; b=YBuuyiciabETBZjiR9YXXE3jtCHGCSjz7nC511fcYnrx3IdelDJtcdjXS
 61GCzyBY0xLM2q4GhzAGdL/w1qgRdLQVlrwMIIaqT7em289chwsTsO13Q24OPiZc
 zaHmoQ4jrzCmMBHjW4mOAh46ezQkBLZiVMF84R9WiXk3kg3yd4EhuQIdOSAlfSPX
 GF4BNup2UbNbMEGU04f3TuhNr1f3y+NkL9lSNnMD5j4vBb3lLLOgUVe7MGK1LEf7
 ky7gJCtXrB7kAWc/kY5QPm80FtHjzbicVTnyR8eg9PH4bCZY7o94BtbW5PCpjQli
 PfByTG9R/8gs8mW3yy2NwvkhHdyiw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2111.outbound.protection.outlook.com [40.107.244.111])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48t00vjv9m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 03:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIWS7+tfExzW8LSsMeXgIqZGUoleEgNhgZk+2SkLnkjWVILP4/VZCrHObgw05UfzNLH2Y5H901oj5MjygG+qFpM8W2AqRtlFjWtNRwhyPCQZd+IIuvQ2CDIeLQCD2s1dcL5sJQL1nLF4qgAOI9xmtsinlYWxjYWbeSqFcX1wfVX7q9wfqzg52ztkz0GWYovXe1uOte+8PhWZ/hdH4HPlrVYUGHd957Dc2b1JuJAJ+dapNhK7pgEDKlwtsRcc9wzBElwVEc3s5Zp3rqP/qIqIjasYg8KtPtItLfS6cJ6gML8aj4dBvSsKWGgNy2L+B8nkE6savYXhOA8qlpLb8ZT1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lVxrUxb11kdPySmazdQGCnD73JrH7KUFJGR4Sc6r4o=;
 b=Ss8JumWdQyerWvVxjH9gqv186LGdsblahzxVwOV3YKAF2BN70CWf3DOax7GeDvVjOKXArwzeaSb3Qk/KWcnvsODLHKKNmfSUjV55DcVaupm19D3vi6ICrII7jk0UruRMiS/hspk0i/6N2QyVdbBEvjyqdBEwN7BqAH8ZoH1+msBDJos9fls83KlTc/a8KYW8f8yDNwpv0kiPzYWUiO9OkNoHJ3b8cl9IX1rmDLDMx+OL+1K8YYWrPCLpn54IdXRtXRPbYkYdf4+npHhPF9JgsQODdeKv3TNpYQXtsj4U5qjBEifYpoyDx6Bx5HYoHY6Cu8ciH2ooiju9ky5Gy7sQ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lVxrUxb11kdPySmazdQGCnD73JrH7KUFJGR4Sc6r4o=;
 b=w7ifJ4kUkeQhUDwxfuDu13cnxNttbFhsEDDfwx0hw+PTlqZbw1Om4mZgcDINhSTGMsVtrSBruddwF8AgU45eIDoakkEaFimNkaX5sow9OMzK8e6HlrHGb1tg8dt2ZtEszl9jtkStkHt7WOaUwRhhBV9ENtek+lmvNpPWzrBHht8LofsstwEYFb6gztQDM5ia4KziKGN08B+D8ba0Xt9tN3wAfwQM2SMHogldXFr3wtkfapbbnJTw4gRwPTSlbWMBPGQ7OOT1+KdJhOcyWg8c2yRCSTmtgC+woFciCVtIQUlwbIqXxuQcoM9QXFEwAvDQBq2BaSkSpdIgp2s6owM5xw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH3PR02MB10197.namprd02.prod.outlook.com (2603:10b6:610:1be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 10:42:05 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 10:42:05 +0000
Message-ID: <1e005bf5-4c02-4906-bed8-7d7a55681dd1@nutanix.com>
Date: Thu, 28 Aug 2025 11:42:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/19] hw/i386/pc_piix.c: restrict isapc machine to
 32-bit CPUs
To: Xiaoyao Li <xiaoyao.li@intel.com>, pbonzini@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, imammedo@redhat.com,
 qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-2-mark.caveayland@nutanix.com>
 <3c2e9fbc-db80-4dd6-a1a5-deeabb8c0194@intel.com>
 <58c515a4-292e-4aec-b57e-73be89b9c322@nutanix.com>
 <a37565e6-77fc-4bf2-8c6b-6f1b22f6c01f@intel.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <a37565e6-77fc-4bf2-8c6b-6f1b22f6c01f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR10CA0021.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH3PR02MB10197:EE_
X-MS-Office365-Filtering-Correlation-Id: cb226628-25e5-4fb5-6401-08dde61f878c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFhacGtKK0RueXluTzFCcStEMGhWNWZYUGhaN25CZWFQaXVNZVVJcDFJbllF?=
 =?utf-8?B?TGgySE10SE1hWmdHdmJWbWFGaStqdVZteWNNS2g4bkMvOCtabXNqUUxVNFB2?=
 =?utf-8?B?M0ZhdDIzdjRUVXIzUzZUbFU5LzlpZS9sckRiWUV6L2Nhbmt2MzVzUFNkQ3Nv?=
 =?utf-8?B?VVhXb01zN3Joc1pSN1JEaThVdU5sN1UyeEc4NWxGOHpYT1k1RzlXTlBIUzVy?=
 =?utf-8?B?TGszbGV1aVFlaVBCQ0ZDVzNsUGU1MUs0a2JSNjJQdnk4MC9xVUlTQ2tQd3Iw?=
 =?utf-8?B?b3ZPWWlxRkFZL3BRR2RiS1hzbGJKSzl6LzJNb3VvVXlYQmcwUkREM2ZLL0ha?=
 =?utf-8?B?YWg0VUJpZldZUmttZmZ1QWMrMzdwTDQxVGU3Wjl3Z2VBYXdmQm94RVZLaEt6?=
 =?utf-8?B?R3ZtdHFCWGp5a0FTRjFjQUVoK2o0Z293NjFvVnhBZlJGMjY3Nk4zalFWK2pO?=
 =?utf-8?B?bko1WGU0VDN4TzBXWnhTczd4R1BLNEdYeTZEZFBtMThCVjNzVjRxeElDZ1Ev?=
 =?utf-8?B?SitzSUxxcmdPNytjeWdXQzd0WlYwY2kyL3NuWlUyUktCOXl3eE0xTHpza3VE?=
 =?utf-8?B?RXRvcnhKRVgyU1d1Y0hyU1h5NHdsSWEvcW0vOXpXclRTeWwwb25hd1orVU9G?=
 =?utf-8?B?ZUZIelRxV3Z2ZzhZM3pmc1JVN2pNYlphV3hteExONlMxQWd1YnZLMnpYQ016?=
 =?utf-8?B?Y0ZNNFVFVUx2ODYzcDBoSWZtOHJlQnlUL1dYRUVyclZRWkowdEFXeDg2anFY?=
 =?utf-8?B?cTRDb0JtRDhJTGFsczQxMHZqMWRiTnhPSDZZMENNaUd3UnI4SWphbldhbFND?=
 =?utf-8?B?d284RGlXOFhMUTJEVHVXanZMclJua2tVTXJQbS96N2hEaFh2bXYvUmJyV0Vt?=
 =?utf-8?B?NlpmRUFTcEwydnhDQ3VoUlBRbE9QSDNzSEFFYUYvVjhWdWlYa2xlLzlIVDBH?=
 =?utf-8?B?L0U4MWw1eVBtREhmc2cyaUFsSkR6MnJaSk9PSVIxTjE2MVNnRGhIR1FEZXRl?=
 =?utf-8?B?TEo5QnpsME84Z2RsWFQwOUdhdCtJaGRxSldHWWNmUmFXakxXRVJkV0hTQXkw?=
 =?utf-8?B?UDVDSUlLVnNFNmZWa1hjY1ZMQ0UwbWtvOXNaOGZvMWR5eXBiYXNWeGJGNmxo?=
 =?utf-8?B?VkNEU3ZRMmp2c3dycTNxL25kRldZbFdiMkpHNmJDWk1yMUtlb2JXcEQ3WHJx?=
 =?utf-8?B?M2k4aDFsL2kweVJOMTM1K0dHdFhQRWd3M0Y2WW9rN3hwaHhYVmxQUzhnTXE1?=
 =?utf-8?B?elVrWU5IZXlkTFB1ZlU1Z1kvaW41dng2VnpDdWtUQVUwM09tOGRsdmlhdFlH?=
 =?utf-8?B?WXpEMjdTL1Y1czF3VExjdFBNc0krM3NDcFpuTkNDU24wVEpzR2tVNjVCQ2k3?=
 =?utf-8?B?OEllaWk4QW1mL2VLS2w5NkMxS095K2h5cjhVbU5uM0tZa1ArVUtDQUpKdW9y?=
 =?utf-8?B?bTdXQmN5YUw1T1pSUkh3eHd5TTBUYjZLUU9KeEx4TFJOMnEzcVZYMUI2ZzZw?=
 =?utf-8?B?YTNpQnRMc2N6d1N4VVV3UUV3MWozaWJ6c09ubzVtYzhtcUJvYzU5OGlNUEZI?=
 =?utf-8?B?YTNqR1hOeFhFMkZqZmFDYlRwQlk0VFRaUjZnTmlMeG95M042eVhvZjFWZ0Y4?=
 =?utf-8?B?S2JyMk0rNE1wbW9pWXR3UVlkbmpkcVNTOUd1VEhNb1p2T3JiRmNMRllvNTVt?=
 =?utf-8?B?NXZScmpWVkNwRGhOTFcrV2hrZWtsTmNIWE16MFRQTkQyMlJjRDlPMjlpSFU4?=
 =?utf-8?B?bXVlU1N0cjZGL240RWRvY2w0L1lQMXV4S2I0R2xwbGFKR3NSSk1xZFRhdW9u?=
 =?utf-8?B?UWtRdHVhWTZua2k0L0w4M1UrSFljdGVPZnRkNUVWanhHRit2RnRXNkN6Y1kz?=
 =?utf-8?B?eGVLZHdzQnhVaG0rMjYwWnJ0aExCVnNQT3pIeENXQ1ZNNTFiS2JzKzJNOTlN?=
 =?utf-8?Q?5qpFcFC7S5I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkpoNGw2c2RBQjQ4M0tkUm1qNG12NXdMVkEzWEhlYUM1eHdvMGJCZHEveG5V?=
 =?utf-8?B?MjF3eWRSK1p6VERSMUVqN1l3L2Vud2VwRE9rK285ajVPaWVhQVoyeHJEUTNV?=
 =?utf-8?B?bkxENXZQWVk2TlVtakl5QktxN09WVmcyRUdkZ2RQbWJsczhHVVlBL0dIQ21l?=
 =?utf-8?B?Sm1maU5KS0VJTGNlb3NSRk1VNUFXd2V0ZHJYUktFcmgzTExtdTZTckN0UkVp?=
 =?utf-8?B?clprM0JSaWFMU29saHZKQkpWMWYxb3lybE8rYUxEMlhoenloWVBMbWlJNlcr?=
 =?utf-8?B?QzJjd3ZXNi8yZktHTFU2U1RiNy9aWjEwYjc0Z213bGNuYlhoTFJlL2g0bGIr?=
 =?utf-8?B?Znp3S2JOTWNKOHkvUEVXc0VNaHpNdW1wRnh2eUpiaTlQWVVGbXNKZmcvMGFP?=
 =?utf-8?B?Wi9ZeTZ0T3p5MWRUOEkvUVd4a1ZDK0kyYmdIOVltZVlHbUx0LzNnSytpR2VJ?=
 =?utf-8?B?QlZWZlBzbzMyMUtPNnJuaTlSWml4Y0RWczkyYStudW5sQzJIZTBUaWYwZWdL?=
 =?utf-8?B?Sm9zanJXU3Y1L1Vsd0JOTndySHhCRmwwaDBzSzJRTzJpbVJlQnBrbm84eGk3?=
 =?utf-8?B?WENhRzZHUStsRGFpellYUFNnSW9rS21JRVc1UG1FODdZNjEvOHdZdWRxa2xl?=
 =?utf-8?B?LzVRcXI0UWV3ZjFta1I5VE9FVkpqa2dMZUwzcy96RGxVVldWaSs3cm50L0tH?=
 =?utf-8?B?TkN4aHozTEZyMWJIcnB5RzUyTTA1S3JpbHYzQm1Tb2taVXRvU0hJWStVQmcv?=
 =?utf-8?B?TXN0T1VnZXg1d2M3SXRqekxoRVFvNTRaaHJQQ055b0RxTXpGL0pCbkNMdzNl?=
 =?utf-8?B?a3JlMGszR2lTYmdpK2tsdGhmd3QxRHBPSWsrcHVnNTVUMTRzdVYyeGcxV2R2?=
 =?utf-8?B?NEp4eUV4ekxrVllySTVwQnRLb3BseUhXNDdBVHhIcGxNU1d0eGlqUjBmVlNw?=
 =?utf-8?B?bEI5TlZFN2pOQTFkem5pQUdpUDNxS0tvbTNkYUluWUpMb3hKamZDVDdKTnEv?=
 =?utf-8?B?Z2NFWklra1pNZzZNRHhveGc5aWRFS3hncEVTUVJQWUR6MHVTNXFDVzdzY3Fw?=
 =?utf-8?B?bDZDNXhJS3JSaGNOS2hwc01OTGxML3FnZXA2RERMMTlMREVrczUwS0lKVU8y?=
 =?utf-8?B?YXRvSm0rN0krT3h1QnBOK0dmVkFvM240UlIvNkRLVzBXK3k2alZDZjNuUEE3?=
 =?utf-8?B?RGlWMStmelh3Q2dBWXd4MndDNXoyckFHOGRmNGUwZDBMRGRrcmE3VEMyNXJh?=
 =?utf-8?B?T2VHcHRHWmNIbVh3dFA0Q2tDUnR4TWpWaWNwOUxuYVE3dHlyREUvaVZOLzd0?=
 =?utf-8?B?MU04ZjFHdUE4RmhKMVhmK2RmbHpuK3JzTzQrMC9uUDlBaEY2empmaEZnd3lw?=
 =?utf-8?B?dXFMSUVpajcxbzBHTC9sSEdpZjBHazN3Y3RXL0p6NkhpQkxOTEM1aytMTkZl?=
 =?utf-8?B?MTZpM3BoaWpqcytEcEdxNFMvWDZpdmg0enRnY2p1RFRuQkdsaDdEby9MRG42?=
 =?utf-8?B?WkV1cldZYTV0R3VwdnE2SFhUeXdXTXo3dVd1RGp3Y3RWZ0c5WHNwUzJ1K3Bl?=
 =?utf-8?B?aGFlT3hXdENwZnEybXBWeXRlRjdOdlNXT1I5Nmp6amljYUVuNFV2YmUrMGxm?=
 =?utf-8?B?Zm1sOFEwRjR6TkNqNW81RGdLeVZRbEUwWS9wcHlLeXJaRkZFaVJtUmNFTTlh?=
 =?utf-8?B?K09ZNklSMmFuRHBzNkdjRERlWkRkcXBENTBjTFZFMzRpaDFVcW5XWjVRSTVS?=
 =?utf-8?B?aHJEZGl1eWRpNzI3eVdmV1FTOVVTSlVxVVBISUg2K3ZQWkJHeTV1VlpBZmhu?=
 =?utf-8?B?anRhdkRESXExMXpIWWs3Tnh5SE9SbzF3MWxMZWVLYjU0S1Y5RzNSSGNwbEV4?=
 =?utf-8?B?TGNHT0ZBTTRkNjZSZzVxZjBrQXQ2OE5Na283Z0xCakw1bDNDWDNZeDd3cDd2?=
 =?utf-8?B?L2xvYTViQ2FJNFNVSkp3WTN6UGVQOTVaakdieEJQM0Z6Nk1FWmRDREFmUkF6?=
 =?utf-8?B?dVRGdmNueUZNbmR5V0NWeEI3UkwzVDh4aGo4b1IxR000bzJkN3gwaEZ2dVJs?=
 =?utf-8?B?RkFoR294MTFhQk01OFJmN1FqT0FaL1NTbDU5d3orRU9NWUVaQ0l0MXMwdnhn?=
 =?utf-8?B?NU5jRzhrRTVxUXEvZSttYWkvTzdTbHJDRXRqNUVMYnAxVncrS2pocFFPMUY3?=
 =?utf-8?B?OGVkNnNLUUdPekdWZnArVzVLWUIyOTNZcDdNV1JOZVlxVVZKRlVlY0YwOG5m?=
 =?utf-8?B?TkJKcjE0Z2hBRnFzRGFyYURucnpnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb226628-25e5-4fb5-6401-08dde61f878c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 10:42:05.1778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ch5CQFSy+VWHVfJYoBqum5v3HzBGPEEkRS44gunChDeplD1Cad06bUIdQ25j/cKZEdb2bdjduziMZezPHdp2dhAoteEHYwYLdK61cFKTsD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10197
X-Proofpoint-ORIG-GUID: W2HA8-9Vosv81nNCtym9vjZ2nNgB_Wsr
X-Proofpoint-GUID: W2HA8-9Vosv81nNCtym9vjZ2nNgB_Wsr
X-Authority-Analysis: v=2.4 cv=C9vpyRP+ c=1 sm=1 tr=0 ts=68b03284 cx=c_pps
 a=f3W5XOz7tIKFJfa9Mwj+Sw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=URCL-POpdj1iClxjB4cA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA4OSBTYWx0ZWRfXx+y3wmIZ7uFU
 kDEAtPGzMxP0o/MGnaGnqCEdA73Qkx87C7pEZUcXBw2IkGOOGXQj1YU1+Dhlt/HVbOeaDhiy2Dz
 DFzF7rdFrc5zepB7rZIKNLvcB/FQfMoHtkJO7STyTz6ZtVlP1JmCRMc2jVHp0Hfy1nUXBj2/J3G
 TnoXKafjLS8TfVmTnY3wp0bo/V6V823+ziy69sboG1UozUe9RpIQU7OaORle90lnlCtPA3Dk9Sp
 YGWqTEr8de10xBN7xILrt3QRolWpYjcQHlHsDRFkL8ehbvzFfZku3Rnr1EHaEQfgmDCx1bNsW7A
 SXTHD8cKpLbFO0fRc13JOCNEA/ai+aVBtc+IcpV63UWEAxnghOirZwUmdSBBtI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 27/08/2025 12:50, Xiaoyao Li wrote:

> On 8/27/2025 7:10 PM, Mark Cave-Ayland wrote:
>> On 26/08/2025 08:25, Xiaoyao Li wrote:
>>
>>> On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote:
>>>> The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst 
>>>> it is
>>>> possible to specify any CPU via -cpu on the command line, it makes no
>>>> sense to allow modern 64-bit CPUs to be used.
>>>>
>>>> Restrict the isapc machine to the available 32-bit CPUs, taking care to
>>>> handle the case where if a user inadvertently uses -cpu max then the 
>>>> "best"
>>>> 32-bit CPU is used (in this case the pentium3).
>>>>
>>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>   hw/i386/pc_piix.c | 26 ++++++++++++++++++++++++++
>>>>   1 file changed, 26 insertions(+)
>>>>
>>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>>> index c03324281b..5720b6b556 100644
>>>> --- a/hw/i386/pc_piix.c
>>>> +++ b/hw/i386/pc_piix.c
>>>> @@ -436,6 +436,19 @@ static void pc_set_south_bridge(Object *obj, 
>>>> int value, Error **errp)
>>>>   #ifdef CONFIG_ISAPC
>>>>   static void pc_init_isa(MachineState *machine)
>>>>   {
>>>> +    /*
>>>> +     * There is a small chance that someone unintentionally passes 
>>>> "- cpu max"
>>>> +     * for the isapc machine, which will provide a much more modern 
>>>> 32-bit
>>>> +     * CPU than would be expected for an ISA-era PC. If the "max" 
>>>> cpu type has
>>>> +     * been specified, choose the "best" 32-bit cpu possible which 
>>>> we consider
>>>> +     * be the pentium3 (deliberately choosing an Intel CPU given 
>>>> that the
>>>> +     * default 486 CPU for the isapc machine is also an Intel CPU).
>>>> +     */
>>>> +    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
>>>> +        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
>>>> +        warn_report("-cpu max is invalid for isapc machine, using 
>>>> pentium3");
>>>> +    }
>>>
>>> Do we need to handle the case of "-cpu host"?
>>
>> I don't believe so. I wasn't originally planning to support "-cpu max" 
>> for isapc, however Daniel mentioned that it could possibly be 
>> generated from libvirt so it makes sense to add the above check to 
>> warn in this case and then continue.
> 
> "host" cpu type is the child of "max", so "-cpu host" will pass in the 
> is_cpu_type_supported(), the same as "max".
> 
> While we are changing "max" to "pentium3", I think it needs to do the 
> same for "host". Otherwise, "-cpu host" won't get any warning and expose 
> the native features to the VMs that are mostly not supposed to exist for 
> isapc, e.g., the LM CUPID bit.

That makes sense given that for compatibility we would want to hide more 
modern features from the guest, particularly if running legacy OSs.

I'll make this change and likely post a v7 soon as there are quite a lot 
of changes here already, and wait for any further input from Jiri or Daniel.


ATB,

Mark.


