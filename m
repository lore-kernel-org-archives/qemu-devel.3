Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CF6C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1mAk-0007qN-9d; Wed, 02 Sep 2026 10:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x1mAj-0007q6-9f
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:42:41 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x1mAh-0002C8-JK
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:42:41 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682CXVDO1205836; Wed, 2 Sep 2026 07:42:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=3sfzP32pv2uhpcCKx5g+hf5QhpSAac7mb8iPDw3Xh
 2w=; b=bAIoEqz3pbCnBBeZXHRBIbOudzlC/ZUU38JjTqSO1bQMryUx5lvYul9sM
 zMRHirTBnX2t2OoPPedL6W+Tnql4KGVR+diKC1T6S20l7ecVUcuI77HUfADAPVgk
 SULoLdpnlq9kobEL/uYz3gAGx39PSmun8h1cOjwu3KltAUZ9tzWk6xeECkgqP0VK
 IqKVZ+46CZhxhYLPJFn6zBbWiyjBB+B7k83GTAzuEnlqdD8s3afYZXqHJskVpXgV
 OGEwkevwyqKyzwFxLGvbejtKaS0TETBtPNOd/4136nxHYqyN54I1oEwO8RMTxLjl
 WKZjUWAW8M7PAiKOKknaOwfFSnTsQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020119.outbound.protection.outlook.com
 [40.93.198.119])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ge100u3xq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 07:42:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vw7u3Zv8xc8XlZjQiRQLGP3JKitu2kTnR66FnhA/j/Ly5H8Kj3d+s1ekTPtcoJ9ZQHSl4ViyKQuorCBIPMugck5iRDZbuviXXuaA3+nnP2cEmo7JkS5HlzZXIx74SiTYTlLOpY8ml79M1NTG6uab1/dUz2RKUECxAUv9lpYCzlfeGTGTw2YqpJiTt4DsZ7AmJnmGeLIuPrRKpm29atk0/bH+f+zq+WoBFtMwhQJSPXX8kcPm3072npmGWf0ChnCE6FgXq97UwNslvmX5vvRGDKpSZTRNNun4ergm83/kbk4qa1LYIzRIJSDBSMhH5aSdkOfFe1RMuxz1PSPP3Ck8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sfzP32pv2uhpcCKx5g+hf5QhpSAac7mb8iPDw3Xh2w=;
 b=IFjQVZb4FzokO1Bul/UhJEZb53s9MRRkkTwsUss7sU5df1V595mjxHl+Gq9G0U3DRfEXwSOHNSvYBm+sDfdy9bk3UxdiDGFMy+19tEwNvsNPzB+DhhzAeyJj5B3mlIcYPO9YsqMBj1BKrAdbWEax8XaLcBjIYiEP/GwYrM7EJsQ5Lh//U9fwRknsE52CodTOQfJHqJ5ExNc6N9AwbBoJTjDMW2b+Kr+b0EDeHFcsEIckq0i6+WsmwFZi0/FnFWDLaYP7iula60ixWCLOqsTJdR04AI9mpqDCXZ9ujB92Tg20OPNFALk5PwXW1ok2wYFJTv/ZVZGvC7ZefGIF59BIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sfzP32pv2uhpcCKx5g+hf5QhpSAac7mb8iPDw3Xh2w=;
 b=uVaGo2X9CvvnHqJMNuipKG1glbEzQ7pJz+eFdgKxtoeXRNZCeBOWmXuOdzEbQ9VeA4V1ic+27faIKKGQqUPsLkt1zVUEIKx9F8o8sEgk2VO70bZC0jxFQJCddKJhhUdjE8+LK4oJJzPJRHrb3Q4UqlAX1GbgF9lvhdzXRvI1s9nwboYAiGF2GVqPmfQ+GvaWDgrQWKSnAfV0xxLTWyNnKfkSerouM+LctpLAHaVfotkuAFY/8wwePEPpCODWXHfzHT/P5rdoGdv0935QTxYdlOTcS30jpmZss7PaNus6VUN0Ell6u3BMTNE8MIkhwHt9YrIh3VJwnyI4dvUZXltltg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BY5PR02MB6978.namprd02.prod.outlook.com (2603:10b6:a03:23f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 14:42:35 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 14:42:35 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v3 6/8] hw/i386/pc.c: convert PC_MACHINE_ACPI_DEVICE_PROP from
 object prop to class prop
Date: Wed,  2 Sep 2026 15:40:53 +0100
Message-ID: <20260902144207.2553037-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902144207.2553037-1-mark.caveayland@nutanix.com>
References: <20260902144207.2553037-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::23) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BY5PR02MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 0015ef89-9e1a-4496-bf9b-08df09006d30
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: mQVdrliEKan1wOGslobSzOh8TUIcOUPI+7OvGFDp0smdieGQu+3nJu99eCiFuUeRK2riUYwISQTDd0J6opzo+uDcYGagmJyrsb5ATJlZ0wi+OxhvVH2aktWVBNVOVjxcLo0T6fcyZ06Wjnd+yavcT/cW5MOY9X2nXViDOCyCTw/9TEOFrUr8WhXSgt5MVYLOji5RfZUhmX/uhDqUIvvvrzewh/OjFa+5a8HhoW0OznKzIW6dADK5dfDO9O/oAwvgeyjSMsXLSPD2wiija/C0sEsn4oGTE3mwH4+rJiu72Q5PILKKWDO+8d+2K7g1rxBtcvhRE8iYD2GJEl2mv0PAyuemw+8f0q8gwRN4edS4EDrR5UM0FsgptO0EzWlBd06+DaSLlX5UYg/RXyEJT3g3Ap6UTpMh3eI2D+L+8OdGdUIytJUgleNaufqFgfJeBXMNwaF0a3pJvSFXIMm2XKHU2DcaNF7sxjWk7dn8xGeLETvlYRIJ/szr9G40O5aIzbgXLZLSx1A1FsCRcq7hEXSnoM+0C0pRasCcO2+lP9GE3nKFSheZmvAy0IuLssJosYEp69rFtUwojuSDbflu0UpJc+gv4zZcwnkoSq0QlJQtM4BS85A3u9O9EMm7FMAxyMgdXRTTnzE1GS+iBepQOB0YHlsnm42dpznWu1z5uUeuokw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjIwS3l4clFUT3NJSEVYUlNSM3VyNUtGa1lNd3pPdUViYW4xYTJNTTBLMXkx?=
 =?utf-8?B?MmVpcm1YUm9OU2crOWNtOEVlKzRvVGFKYVRhakxwZjlPNGZ5UnAxbERQUmlt?=
 =?utf-8?B?eE9PenhBdnBDMllIcTNOajQwTFJXdFZ5YUlNdlRZK0NWa2VLV0tOZTZCa3c1?=
 =?utf-8?B?UkcwdmZSZjYxSnE3amNndXZkeWtjSTFVRkd2RVk0WDRseUtrWUE5bFh5NVBH?=
 =?utf-8?B?QkFCWlo4eG1DaDRzR0V2c0lWRysrQ0s1bkVEOC9ISWQ5am53SWdwMU9WUHNZ?=
 =?utf-8?B?a3VIU1gvMjEzRmkvQklQbUhMN25xNTFyOHhRNXUya2FxVTFwaVFJZ1VuNHQ5?=
 =?utf-8?B?UWdnLzA5RmVPYnNUZGtmd1gyWVJtMk80WEhGMmQzb0UxZFBUWHh0VGxqQ1JT?=
 =?utf-8?B?R1BNUW54NlpxNTVobHNzdWZsZW4vclo1M2FZRFN4T0hwQmp5bWszYnJWSUtD?=
 =?utf-8?B?cGhpMFZ0ZlQ2VmdNNEZGL3FadXBMUGRYMEtEUWVCMjZBZEluUXU0ZkdmNDd1?=
 =?utf-8?B?MzRIeEx2Umt6ckxCeXpWV2lkakxhK3M1WmhnbW5oaTlnZjN5UDE4aVJTM3JD?=
 =?utf-8?B?ZFlkNHNxV1B5UU05SXhTVnBYNWtTNFF1MDV1YU4ybnlFWHV6bHUzMjlHVUNi?=
 =?utf-8?B?bE1kbXNDQ3R6d2dGZU1yVlQ2NjNaT1NpRThaczZsTHNnY1Uwd0dqZzU1Z1VW?=
 =?utf-8?B?ckRRRnJDS1lrQkR5Z0NsNGZwWUVLOTdhcmN0WHRHamNIZ3lNekdJeXJrOFR4?=
 =?utf-8?B?Tm9RNjVtM3piZDlvRFI4Vzg5VklDRXZJbVZocEVGYkxQTzdUNlBzakRCb1Za?=
 =?utf-8?B?VjNibDJYbWxaVDFFc2VlWFJrT3A3LzBmU05HRDgwM3BCbHErd1o3VHltS2RL?=
 =?utf-8?B?cmRmOGFERzcvTTZtTy80dm8wNmw5OEttczZCRVlwZm85TE8rcHF3czhwQVNE?=
 =?utf-8?B?VmU2dDZxMVM0SXNCZkRWbVhCc1NEcjUwZi9weXNaeUttcFdFcUMycDYzSW5w?=
 =?utf-8?B?aWM4V1V2dEYxWXhFWVFxUEJFNjVKcnpHdUV3TXBQNUpHNXh4UlN4N09TcGtp?=
 =?utf-8?B?OTArS0ZTSGdEQVdIMmQwMzlmNjhCL09rWmhUTWpPMGdjazlYbUljSFJyZ0NE?=
 =?utf-8?B?anJycFF0L3ZlbGEwV1h2VE4zUUlwNmhUajB2QnZRcEpFU3MwdGkzQ3Z6ZXYz?=
 =?utf-8?B?eVZGdVJmZlBUSDU1TXp0ZlZMb0ZlazExRlppN3FsUjB2ZDZmOXVqOXlWdFUv?=
 =?utf-8?B?ZDZwbG1LVlM4OVlScmpIbnJYT3RYVUtjYkZtNW5aSzRUbVBlandLUnpBRHc4?=
 =?utf-8?B?bld6NnFqNEN4b2xOTUZOeVBLRGwrSkNSWllNcnFFMklDYkpBZHA3aFFuYm8y?=
 =?utf-8?B?MnNSd3A0WlRmdnZOZk9wQ1M5QmFGd0lZanFJVDFjSkJyckluVWRtL3RMSzJ4?=
 =?utf-8?B?ZUVzVVRYcWJkSlRFYVJDdnJxN1NWV0t2Q3o3VnNlcmpiVmw5QmVJQmJWK29G?=
 =?utf-8?B?R29WVlVCdUJUMkVTWkxVd05VdjFsTi96V2Mrd2lPV2pKUm0wTWZ6YUdPTUhI?=
 =?utf-8?B?Mk9xWkdEODJKNjBtYzhhVExIclNhVVF6cllnS1RSYS90bXBMOElKQnFKcnFO?=
 =?utf-8?B?c3ZmZ2xzeWloSThxY2pnL0FVRTVPemtBdkVFdEs3YkNkR1NQT0RJN3pBQmg0?=
 =?utf-8?B?L1l5RGRXemR4V3JuZ3JyVUZrN1dmMjR2VHdRVVNRWXB2VEQ4N1A4K0NjWmo5?=
 =?utf-8?B?NUQ5RnNZU1JvdUdIc2NLKzl1QVlUYlZLY0EvbDQyUzlSdXFxSmNYZExqek1C?=
 =?utf-8?B?WWlaejdXSHBHM0E2OWxVOU5OVllWTzlQVVovRGoyVGJkOFFsQXNsYWZPdDVj?=
 =?utf-8?B?YXpWZ253OUl1MHlPTXl0alZCa1hSbGJZNXMyRVUyd0x4LytwRjBUbnN6RTdy?=
 =?utf-8?B?UDFUR3VTMy8yQkxTSXRqOTkwOW5TWTBSN0IxVFFDWVpyWXJYRzEzMmFSdU52?=
 =?utf-8?B?NmdVbkVUbE5uR0JuRWRQUk1qOHZwbXpZekhSTGxSK29hV2d2eXdDNUZNOXpq?=
 =?utf-8?B?SkxOTGViNjZLaGt5YnJvNWJ5aFVrNE1vVm5GdUdqOE5VYTEzL0p0M2ZMNUtT?=
 =?utf-8?B?dnRhQzlKckxyOXlGN1JqUHB0dzRkcWs2NURHbGNuQUhBNWRDbFN3NlN2VWdk?=
 =?utf-8?B?SlJ5dC9ZUzVQNS9uWGtDQjdWVFhJczBnQlBTYTJQUzNySnF4OTRUbk45cEda?=
 =?utf-8?B?NEpvd3F4S3JjSDVYalY2cFBBQ2syc24wdVoxRHlJSkhyVXV1M25ENnY1VEZn?=
 =?utf-8?B?Lzc1TkdLWEJVR2tTN0Fzb0JqYTVYdU9wemdzTHVFOVE1a090TWMzSE10dlJE?=
 =?utf-8?Q?LfU89gyLlOttVgZ0=3D?=
X-Exchange-RoutingPolicyChecked: zOpZvfylfckESMe7SckfxvBFB7BPTOZbnrbZ71MPQre5NQnnP6P8b7XkYgLZtsmF2JlzdfcTEhdQAtoreM5ZWbriTvZ3cZiI+o21FZjccTdaEOjnZR42YbBaLWzIejkhbLLT4KA8/68Kkx1YPwSBBAiFIsu5+zsgxyK8hXtltbbwUlxOYizS5poQC6IdBctZlCWhPni2AMlg7zu3q0N2XSfudDOqB29TCUeq6ZSqgZPM5+eRMRyIjtMSZbWPUn2e4jSKeWDRhMZa+zHnVm+c8wMzHv3CMt1c45yxITp1XOIRkBL1DN9+AvZdpwgkZ6fxzrKDc7C2ic6PL0lhDoYoxA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0015ef89-9e1a-4496-bf9b-08df09006d30
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 14:42:35.0296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ps0+Jzx4aIjQJhQiPR0SVhK7BgGPwoKs6wxrFFzs4v1yxM8pyW4WRjjX5xF554theR205iRfxkrGHicdklJkBR4nYHAxMGYGaycoHdHLuII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6978
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzMCBTYWx0ZWRfX1k6I6PyMRbpE
 xmm/uET3eIYKHcmiGl+wOzlqtkoya5O8880NMcooWuJfVOTsYkr2POpt1SDiC9p2xQC1L/VlIXE
 1a/nKbqL4OpxYXNdIg58GFGedHkcH2g=
X-Authority-Analysis: v=2.4 cv=JZuMa0KV c=1 sm=1 tr=0 ts=6a9835dd cx=c_pps
 a=su6dv7EX1thkUT4YzH3YWg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=ByzZujTaoW8sYEn9Xg8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: q6u4ffD0stcAAos_8IrBG9uwzfKA_f76
X-Proofpoint-ORIG-GUID: q6u4ffD0stcAAos_8IrBG9uwzfKA_f76
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzMCBTYWx0ZWRfX7a5n3HmzhfsY
 00rMBZkWd+DyoWDq29qX6q1ssw+yiYCSVeqmZB7OVgDunTuJ3UluGc+sP0Gcbwi38vX3idCeKLp
 bKV0R1GOwULzuJpkd02i/KSix3+66FutjBIyENfCI8/pCCKKrdvEvtSpPwZUnKpRo52UgSenprW
 DTRs4Lm/g9yLMK3Tg+89ZYJP6YQOxOQiMt39C1Pd32GaCtjnb4m5P9GHfCy9mDYZA+hh0Adqb8T
 YWLgDN0tZvDG5pxhI9T8wEWQigBCiAYj4fUWH5a+DgGftb5ENNydQw8xvyLRf2Itx0RtWZzwxrX
 jccAAfw2KWQACWSaI3mijiXT2rX8SAj+Q8U19Bypy/n8FE9mS65pSz5z++bVEUqtJLPqMdetsPe
 LZMIWTTp7kh7go9BLCkldycPC+bVN+bVQEOknCpJvch2gW5R01NtgGUcYxfdb+zx9F/U3ScCaKa
 Hoyr8RChJxdmf/iQJwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/i386/pc.c      | 5 +++++
 hw/i386/pc_piix.c | 5 -----
 hw/i386/pc_q35.c  | 5 -----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f8969ddebc..876ebaadb8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1795,6 +1795,11 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
                                     offsetof(PCMachineState, alias_rtc_time),
                                     TYPE_MC146818_RTC,
                                     "date");
+    object_class_property_add_link(oc, PC_MACHINE_ACPI_DEVICE_PROP,
+                                   TYPE_HOTPLUG_HANDLER,
+                                   offsetof(X86MachineState, acpi_dev),
+                                   object_property_allow_set_link,
+                                   OBJ_PROP_LINK_STRONG);
 }
 
 static const TypeInfo pc_machine_info = {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index a929cc4dec..63c4667ea3 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -306,11 +306,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         /* TODO: Populate SPD eeprom data.  */
         smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
 
-        object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                                 TYPE_HOTPLUG_HANDLER,
-                                 (Object **)&x86ms->acpi_dev,
-                                 object_property_allow_set_link,
-                                 OBJ_PROP_LINK_STRONG);
         object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                                  piix4_pm, &error_abort);
     }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 94cd71124b..c3ce9c5649 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -247,11 +247,6 @@ static void pc_q35_init(MachineState *machine)
 
     x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
 
-    object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                             TYPE_HOTPLUG_HANDLER,
-                             (Object **)&x86ms->acpi_dev,
-                             object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG);
     object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                              OBJECT(lpc), &error_abort);
 
-- 
2.43.0


