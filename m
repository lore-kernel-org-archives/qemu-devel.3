Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA77CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQft-0002DW-K8; Fri, 22 Aug 2025 08:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQfk-0001v5-KL
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:15:10 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQfb-0000qX-CW
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:15:04 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57MA7uhJ2824419; Fri, 22 Aug 2025 05:14:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=PI/FQYmenBP1zsQQ9NjjUqx0YjtIT1nxqjGbtKBVB
 ns=; b=kqltZ7rWiDSRztsOGyG8BfAeN/SaeJJx7z7o5K4QXuFNcDrWVVFUzkY68
 CPlBKNl6IgYeiL3IILiFX2GWdztd8FasqZRr6Z3hguwpDkgnos9UEtAX3wau//SN
 Whw9sxuye09wgfTx0K9AANRzhWhYt/ksUxVaNYR7Ndtxh/8nhN23VQ+vK26T6+ZR
 S6WH8ghgeyVSgXXCjcBY9z5+wf4Xoo+vwrYJwveIhqc5WyO7efcNeRlAx4mjlA38
 9T73y+OFQzGrlXzRXMPOWZa01Iayh/VcGqdrCwA1C6cQig+hGT6rMuJNeqndd1p+
 we7Rtys1GcgpwSDTjfKalZaDE5EfQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2095.outbound.protection.outlook.com [40.107.220.95])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48pphe080n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 05:14:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVEYMYu/D+ncY0Pb+vamwgtLnZX7cvTKF3fWEaCYc+2OfrwAIFGAZ3QQesobikCZ7ynVl1Oa96LGb6+ifiK7wuQnQ/RGveiSmT3Ywyl5oitq+43GeBAPwqqfcc1nlY+00ccCtrr9fJ/mK5PinSbba/txj77ujx5vdp4L1FqDjjEL9b7ehNDLnmivZuHCbXF3YI/7Pv+AQwLRFIH4/5/dSvNGejoHicDt6Qde4SFaiVfjROta2pNoTYjADThqiZubIJFbhGTfjszVsyYIRCQr62doq3mFNigpz52fNzSGIGMopO1LiZ9efeZxav2ia4UcoOEySsRGZlYZILZWad58bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PI/FQYmenBP1zsQQ9NjjUqx0YjtIT1nxqjGbtKBVBns=;
 b=wNA571R4fVclbuHmqJXH0OQNkUPeYpDFsckaU/5y3ZqJarFSpqm4yf1bNaaYABDK+6YR5yE4OuDfjNFeJRHkPG8/91rBW1t4dsYtbarcj8C49zb99rBI87Ox4i1tU6RTOYgc5e7WssY+6Co6EhMOKAksYYi/sEUPAdBPaKcejXBHQb8Mm9LaaDlM7b++lMEvciAiSU5jFF8/r1TYtxYHcWjpqc+j0eazx8NQ6/dCh4KmXkj+autSd3/CNMs8+huCNsmWHjWT51SdpckBSy7eHk/HAD7b+/kyM+4UabDpW55EKZKKnFcOHH1X0h8LQrdZxiMkZ6lVmua7ExVU8lBQRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PI/FQYmenBP1zsQQ9NjjUqx0YjtIT1nxqjGbtKBVBns=;
 b=BHhQ4nXFhLY5RtxPpbvc5xueQh76+JAYFJv3xduif7vhIJme5qgxrF3ksGTFyw1/EKSg/AxqXZIFjvfhpNRqmw6PvEVNIJpmGCIALNyW4QD3xl6kiW72UQ3D2Zg+a8JsURnqRGnElFgHVONfToAJks7Kovbq4JmrxWZSox0c6LCxE0x73EKpNAoMbV0XE2mCVdSgoG8ikhlC7tRsmasMxEuk7MOscYdtqVPR3ksoxiOtcl7loe0Zn2ngRdTf7+WR9yK9ZJ771xFAKO8S27s8NAaz2qBK6tOtLW9R7UosBWvCCbxa5vMTgCvNI2y5YR3zFVu5xThWWoGaPgYBuXoU0A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7725.namprd02.prod.outlook.com (2603:10b6:a03:322::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 12:14:45 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:14:45 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v6 17/19] hw/i386/pc_piix.c: remove unused headers after isapc
 machine split
Date: Fri, 22 Aug 2025 13:12:03 +0100
Message-ID: <20250822121342.894223-18-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822121342.894223-1-mark.caveayland@nutanix.com>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0175.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::44) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f1623c-f423-45a1-24c5-08dde1757b59
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3JHckNlZUQ1WHFnazlpdjZvRE44eHkxZmQ0THE1TXJlTHZhQUYvcWxRZ2Zi?=
 =?utf-8?B?RU5ZclQvYVR2aXBQMmM1eVZzYTVoNWR1ZzZ5eXJFWTdPQm05S1VzVzFBemFm?=
 =?utf-8?B?YTl4eWxibkhBVlhGSklvcHhaSHdXQnVhQlplV2JnMmhtUS9kdFA0bC94Q001?=
 =?utf-8?B?RG05ekIyUHNoVGVqdlZMVmh6aXhYODVDV2JxSFJKWWdaRFVHWHQrQkxuanRZ?=
 =?utf-8?B?WHlnQjZjMW5iT1ZVRGdWRDhjS1VDc3llWCtTMUx5ZmdqcFJZQ2o1ZDRCOTFv?=
 =?utf-8?B?MzF6citFQkNYRlI5L3doSWVnTWpWZ3hpZzVtcHBGV1hkekh2MzI3dHFIY0Rj?=
 =?utf-8?B?TjJ2cG9ma1l3U3dZOC9lb3kvRG5mMDl1eVB0emZabUVSMllwWDc1NGZsODNV?=
 =?utf-8?B?djg5QVNBR1h5NmxVd3AzQ25TUlJVUXg5VmNjRTVqU2lrVWs2SFhQY3ptQ0R0?=
 =?utf-8?B?REtIUTBPRXB1eDFlc0dQa2V4TGxiTUZMdzJKMHpsZTFTVWVHM1hWS1lXYVRU?=
 =?utf-8?B?NlZ1RUU1TGpDOVR2UFNBRlFlcHRTR1h0ZHlPOFFoaVJoc2YrMG91OFI2Qi91?=
 =?utf-8?B?R1Y0MnhhSTNFMGNROTRQOFVPN0JVMWlIRDR6clpyRUxtZzkwd3lYTWNoQnNy?=
 =?utf-8?B?d0lrS3BHczFhMGZJaGlZeGQ3cHlCbGkzcHhHVnpHd3RlaHdTS0lWRWw0Tkda?=
 =?utf-8?B?MGdrTFJ4UlJZTURyWGpoUVUzZVF0R0kyTFBtTjZJZEpVeTZock9zSjFZNW5n?=
 =?utf-8?B?UEUvV2ZQMUZKN3pWRkJvT2xWMjUrT3BLQWdvYng5akpPMTJMTHlITmpUNUQx?=
 =?utf-8?B?d1VUbzc1TU40T2RmNFJhcGtBNVZqa01HRlVPL1B1TWlRRlhmSXlrTUYxVmpj?=
 =?utf-8?B?MmxCOWVxc3M1UGtlUlRGdWs2Zjg4azZSemd3SVMwR0JaU3RzVFZqeTRERkFG?=
 =?utf-8?B?OUF1U0srSVdjSDBPa3JTWjNFa2hRL3lkMUF4cXdKR3NVYzNlYTh4Nkp6cklu?=
 =?utf-8?B?L255WTdXc3Y1OWxLTUVPQzVCcitGMzNxODZ2cXlYYm1ZaEtweGRlNEdrdnZh?=
 =?utf-8?B?aE85dW53a1I0Tm9IOXV3WUNaV0dRamhqTkllbEt0VGQ4aHZyaVJzNWhyZWdv?=
 =?utf-8?B?Mk1seTZlUkw3SjdLVlpodFZTUDYxMTBoSWJqcEQyWXBEOE5LRU14cGZkdHRC?=
 =?utf-8?B?Wk5lQkU3SmRlcmVSd29Sem9EOVJJTTh6Z0w0dFZDRHJYbEw5KzRXSUd0Z2VI?=
 =?utf-8?B?Y245TzRENGZMeDV5cC9zUE9td0N6VHlKQUw3aFZMNldrWXlEVHNhT2NkNHJ0?=
 =?utf-8?B?VmY0dEFRdUcveGpPcjdrZnJmV0tpYkxBc201Y2tXNlNSdURtS3RBOFFhR09I?=
 =?utf-8?B?TXFPMzRKL292OVk4ZkFkR0dBd09ieHRmZmJrS00zYVF3NmlrM3YwMnIyVEQ5?=
 =?utf-8?B?N04xSkhtbDJXdnBVN1I1KzNrbVhFemhqaW85NC83MmpiUm11bmt3L2JDcXQy?=
 =?utf-8?B?cDUvUUt6QmUxOEZlZEYrald2dkwrWWlZOHMrRlo5M2dJTUJLT2JzTW9JcVl1?=
 =?utf-8?B?TFRQNFJqM2d0TU82dU1sVGhuY3BmeTE1VDhVYlpsMnNCN2ZuUXNHeUNyR3Iw?=
 =?utf-8?B?QmxNeW5CYjFLVlBNQzlYaHJjcEVXMVN6RTdJcmJJWmYvOVN4U0lyaytmRHlQ?=
 =?utf-8?B?enBsNVB6VC9GNlppcmhUWGR6VGFaTjJHSk82amw5UXc5akh4V1V4My9PRXRp?=
 =?utf-8?B?Ri9lWkc0aWtudEdHamFrNWdSQjJPc0hGME9kaHVaRE9qRFFFbE9KdkdBenlv?=
 =?utf-8?B?M3BrckFJbVhnYTcyb2p6MUFUZXNHV1cwTHZLMitMOEgvSDNnUHc5WkpFdy82?=
 =?utf-8?B?bEhLTVl0Q0Y5d0R3bkFGWSswcFg2ZjBHQURySWo1SlZPUGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGdSZ0JBdGdIUnF6d3hQc0k3ZnVGSzRxQ2s0Vi8rUTFSNmNMZFBoVW5UWG4w?=
 =?utf-8?B?NGdGUVc2UTZPVHNZcU04VkpWKzhSeENaVTZqa1ZyOVZSaFFmN3dOQzZDWXpu?=
 =?utf-8?B?aWg1N2lBSTFmNTdyb0lPQWZZZk5qMGFkZzFZV1RGTDJ5MWZSYjgvYm53cWJE?=
 =?utf-8?B?aHViTytCanVIOWNDL2tra2c1ZXowd0Q2MlpCVytRMWdKam96aEFHOHB1ZFBW?=
 =?utf-8?B?akp1amVJeVRWSnRkWGJkZEdHT0ExN3ZpSWRwTVA5SWROdnpLS2pmVWxXcDMw?=
 =?utf-8?B?eFpKSFE0dWJzVTlGd0ptZWRoeTVENFZDSWZyMUlWVDY3NFhSK2h3RzNXUlEr?=
 =?utf-8?B?SERlRDQwSEs0MEJUNnFNSS9JMFMzenpyYzhyMktCSW5MdGR0Q0NMQ0JjUXRj?=
 =?utf-8?B?TGhlQnhja3I4L0lwWmg5K21JRVh0bzlqTCtVd2xLY1RTYUZ4RWp5c3VXcEhT?=
 =?utf-8?B?bkdUUjdYdWY1K0pLQkY1OHpYMmNGU3pwalZSVlNvN1VpcTJqUjBKc3VDM2Fv?=
 =?utf-8?B?UlVraGFmczg5dERhdXhLY1J6U1IvMEcwS3VKdjYvcnNKSFF3NHQweWltM1RU?=
 =?utf-8?B?enBDR3pYY01GNFZpNkc3VzBkcEtHU2Q4M0o3MzB5ZytBSG9kNUh1SzFualR3?=
 =?utf-8?B?bkpvNytoU1pqTUU3ei9yRndkRm5pWERUcWFuWXB5QmVweXE3RUhqV1E0V0J3?=
 =?utf-8?B?OHcweDFLc0R4YU1NaXlHeDArem5FbEthTzNLMHhDZDBweERqQ3RnZWJKTEZC?=
 =?utf-8?B?VzAxZWFpeU9FSElMcjA0SWNlT0VJYm5kSjMrYThLd0E4TXdWZ0JZc1dBSVpM?=
 =?utf-8?B?MjJaazFwUVpkWkFaR1AxdzlidWRrY1FCOG1TQzZSbEcyQXEzZHlxZSs2OXBm?=
 =?utf-8?B?Zlg2ZUNmcHFJQzk0aDU3dTAxK09VYUQ2d3FMYjE0TDVsNzlxZGV4SjlqbG9S?=
 =?utf-8?B?VnF0a1lhaisxSGc0UXVhNE13THpEVHdYdHowdVBwS1JobkQxRkhJRkxPaWww?=
 =?utf-8?B?RkxPbkYxVlVQL2t3cmdwUGlSR1dGNXhYd01BaENkMVpDZlZWdERLNVBpb0x5?=
 =?utf-8?B?NzhvUkNXR2VWRDJBbFBHQjFyY3VvdzR5eFE3TFJyNmFYUWVGRG1VckVveVd2?=
 =?utf-8?B?aFdNc3dRZ3d6Y3hEcnVJUk9vbDI5T3RIWFlPSFBMRlFJYUdYUEpEK2hvN2I3?=
 =?utf-8?B?Zk5RME9QOHBnU1BTeC95aUlac1puYWs4UWV3TnpPWlJndDZWSnNaV2o2T0pl?=
 =?utf-8?B?Ti96OXdSZWRwSVR2ZktmN1VlTzMvM0hRMGl0WWFUTis2eWlqekJIOGlIaHVK?=
 =?utf-8?B?UXFreTBmdW1DUW1GNkZKRjhLS0t5VG1ENTgzc282S0JibnJwUU15dWM1b0po?=
 =?utf-8?B?WGJ2eDBLRHFndlppbUQyWXV6eWJlN3ArUlhvWlN4eForWUZqQTYrays3SGt4?=
 =?utf-8?B?MlI2bm1wMG0vQW02dUpjN3F0THJ6RlJNc3d4eW1hS3dqanFRNGxOTURVNnRz?=
 =?utf-8?B?K2pETkZQbjFSd3dLeGtLbjVsV2NjQnA2VXcvakhoTUFsbmZ5b2JLZVJpT1Jp?=
 =?utf-8?B?bTc2UXIrZFlEWGJBT09iUjlnajRTSzU0K2pibUVFeVI4Q2FUcWxvbW9IcFdi?=
 =?utf-8?B?NkJCNVVodnN6ejQ0Ly9IUmcxRzI4Sm93cXAxbHNwTEs0SURBT3ZIUERpOVAr?=
 =?utf-8?B?YTJKN0RFUjhzNVJvRWhudnFUSVlJZ2sreGx2eVIzN3ZqWENGUXZhY3VnZU1Q?=
 =?utf-8?B?bWllbEJ6Ry9Ra0hzUU4ydkthUngyektzSWpRWklQYVVEOWJtams5UGpoaThY?=
 =?utf-8?B?S2dFbnhMY3BWZTQ0dDRZd0R4c1g5YitmVHdiUGkzTGhqbGJWUWFJMXZBMzZk?=
 =?utf-8?B?aldTeUpYNHFEbFhKdjJNSHluNlZFaXJyQmY3RTN1QkIxRncxZktVeGZjcWJ2?=
 =?utf-8?B?V29tODdvL0lqNFJ3bUlYanRZdC9HYjJzNVlHWGhadTNBS0ltOTUra0JvdnJn?=
 =?utf-8?B?MUI4d0hwTStlaS9UVyswemF2VkpBZDlDY0RHcnFtSnZGV09ESmRjZzZQbldm?=
 =?utf-8?B?Z1ltdmRyU1A0dHdJM0UrK2c5V0o4QXpDM0poaWJGdlZ0WjM2UGdTSHNhR28v?=
 =?utf-8?B?RmhvNUdCTTRFY2VvR2t1NElxc3lWTjBCRkExL3FjNW82dGhNQjltcEJDQlFF?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f1623c-f423-45a1-24c5-08dde1757b59
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:14:45.4915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFxyksSAlDaZuI7Z9ZizirYkoqPTJOYMMnZLE6O4TmM17VsGY3nFJxCiXu21i1Taw8U24fdbUOsKfkqwLtRam2w9g6hdzOxjY/kFQeM93b8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7725
X-Authority-Analysis: v=2.4 cv=PvLKrwM3 c=1 sm=1 tr=0 ts=68a85f3f cx=c_pps
 a=YKE8LuPMBYZ6rjMuwm3XPg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=W95sc-WnjIl6KLOMV5AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 3FutNbSTCHSPMcoCLB3PEVidSb76Pvjy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDExNCBTYWx0ZWRfX3DBqdD+bGRXO
 I1c9sh8d9fBoiZKcYnii63oXuYsHzgDUdTN4vX9SHf1jHS6sPIO6nCRExGNhnjfnTuFgELlqfnr
 SPLKTzgdXcLBjWAyQYu8OQqknpFkqsqWFO2b9ulAodbS5Fxdw8RPZ43pNqvW2Nf3nYZ9DAPz87z
 mAuuztjHB6GVA4Sy0mSBnfTpUWznTe+DJvpQUTp/LAYTqIpF9XTG2Rna+yNrjgn6je5CMc8iDQO
 UBTzWIwvm4YL/dUREGvQuMmCkj70S/1B8GsxAdnClxcvafFcUEnll+Y3daXIGR63VE1zhqx7Hul
 u1lJmXeFDm+IRPr2rITHgzRcC7G3qXh3NlojG2TjxmLLwGKj4gug8XuUH7Flf8ZlN+kRKWWhWAn
 pcnqAooSqelRJSAAzRBYu/5jmeo69A==
X-Proofpoint-ORIG-GUID: 3FutNbSTCHSPMcoCLB3PEVidSb76Pvjy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The headers for isapc-only devices can be removed from pc_piix.c since they are
no longer used by the i440fx-pc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 05713662e4..5babdc3e4c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -27,19 +27,16 @@
 
 #include "qemu/units.h"
 #include "hw/char/parallel-isa.h"
-#include "hw/dma/i8257.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/apic.h"
 #include "hw/pci-host/i440fx.h"
-#include "hw/rtc/mc146818rtc.h"
 #include "hw/southbridge/piix.h"
 #include "hw/display/ramfb.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_ids.h"
 #include "hw/usb.h"
 #include "net/net.h"
-#include "hw/ide/isa.h"
 #include "hw/ide/pci.h"
 #include "hw/irq.h"
 #include "system/kvm.h"
-- 
2.43.0


