Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0FEC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyrRf-0003jU-3h; Tue, 25 Aug 2026 09:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRV-0003fy-Ip; Tue, 25 Aug 2026 09:43:59 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRT-0002UH-Qd; Tue, 25 Aug 2026 09:43:57 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PB13Qf1484538; Tue, 25 Aug 2026 06:43:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=w4T0+Qn7ryoAzjIhoqiKrq1z6YDI4LGCCkt/PA530
 io=; b=MnqRnyVpRH2kRd2K2Oglb5sFHV/syvPVZ86oJgvxCjAwB83I2yzt4LxmJ
 M4u9eMXhBKWpsM3E3E/x6S28gtuk2NBw8iiEwUU64KFpFzWpNkZJ6g+lajh+Grv0
 LHEb6bpxuLLj6fPnL/q+9PpownOKwejONAld2muxTAa8Zf2ph45hqmpfxZo6y7Mv
 KrOIaGsB+yduBunvv6JPJVIPXP/wuNoWM8NxE5h4MxrnEfNTEw8KDuOptZWFIga2
 Pyz6/tlvB4mf5U93HaUlztliS0V7KX4u46d+Dq3vo/K2KDrVci3teSJJC/tPo1eR
 q6uMusEyxkLUk7nucPKS6A4K4INgA==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021074.outbound.protection.outlook.com [52.101.62.74])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g783qxhwx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 06:43:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mi1ZsC7RlGw3O6/9tfPU3//rrrrndAW6u4uPowxaPH+sZGkzMrWTf/7a4v5PaGPPBssxT0OY4CtYxub+q7aPPzoamHn62OIedz1RRLVlmvDBP6YqAdb5xDa17QK1lE6Ep8nk3JMYDKEi6W4OzZwnQbWQU7VdHg+sIPy2ArxXI0AFqFF+FxJad4I4ZQ01VMh+uQdh+oR/p5v/KnPMgbanCJIjr7u1XFD/SEm40oztIWQ+63FFC6eSRYw7r4yMoQfhTaDTiBJ6vV4eGrHKh3Jv5jPjJnYYE1/GASy7SRtOaf3pXVHE54nC6IpbBdRx8Gvj4HHzZK04V0ciqrcenAavHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4T0+Qn7ryoAzjIhoqiKrq1z6YDI4LGCCkt/PA530io=;
 b=e5UrWlX110bvlO3Wd0BE1YRlxbeMAL6Pm6aFwv8vnRyDHzCYVFKB8ZRSn3j3YFyeoH/nd4XJXWqWliuU5ePyK1H07BxEmmwdlvg8cmJLovFBv1LGz+6/V11+PePyuop6cp/5/TDnKJ+2n+tqIXhjLb0htqpjaEqSHiL4crWDeRJEVrpq/wVH6M88TkZRPRbyCTptmdLKmBW4NpQ/TyxjKekveEE9j5v8+t9uRew84cjnYiTZxtRAKKDGtzbYfenx9zYi4uAiTAkmJgpcvrO2YjALuEFu//JMngSSWF2YmwckQP6ZRlguVpRmQcpL2ovTlv/wLFXx8ARXIkC+Zt9dBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4T0+Qn7ryoAzjIhoqiKrq1z6YDI4LGCCkt/PA530io=;
 b=mDvR2mMo9wEHFn7UC9+iRP+9ueN3xuai90AXOfcLdJIEBcZ/Q3TKkllGSoluEoTH/j8dSPoX1rOwcFpSLpHT/Ti70Qljok2jqmkpADuH/703HczYWdD0/puZt+tmq6abwajtTtpMzIxd4kjyQE/+XK/w8oglqNvwUJxMdr/r3v5aYu5gqyILsho8Cidn6McQknStpbD+h+NOIOwJpK26V/HG2qF7MmVFubyQNAuG8HaXBpHehlkoeBYek9FKefSsbrfQh+SD0HEX1KOJYxtUwq5ibUzxx//KjMwAaC7fFQRTG5tT9NdA9cv2AgS9rsf8zIL7LYmR5vbCDkywRCFz/g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7557.namprd02.prod.outlook.com (2603:10b6:510:54::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 13:43:41 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 13:43:41 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v5 06/16] hw/isa/lpc_ich9.c: convert ich9_lpc_initfn() object
 props to class props
Date: Tue, 25 Aug 2026 14:41:27 +0100
Message-ID: <20260825134320.1039012-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
References: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0091.namprd11.prod.outlook.com
 (2603:10b6:806:d1::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: e01f88d5-fc50-4778-2102-08df02aedf58
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: iPWKF5v6vRS30/SK24Y3S1XXtVSesi9Z1T08U/eTOBDTQdIlAtJp3tAGiU832cLUiTXbX7+4AAVYbPy1xgn1eeSx3s7BWoax4U1zPSYbnQ3nuaT1jKDkpfmJSamzATUBlk1EaIoeeleFk+6152+4n8PBNCArc5y38mMouAhjQW1Gy63IdT19N8z6fdJUUk683ExKeF8Nu8dy0108XsKmPDDJknl6uEaV9ahB3OlikrGtp4KppxTW8fxv0wIc1gX9hYpMSDmuF4dRx0xNXLYMYjld787XepzBF7YcCetucdEYMFi4tHI2PQqoUXqsCsK9p0djOCBdm8Dvyx0h768rvlXjRtNZbnqUv/oXeeReHZ1cF+px42TUuDdsFxbsapTmu3JTjXO9DYloH6HRMRcOuC09+O5Mv4LSMqnisNXk+gl4uxS8F/VcjQywCZQWxP0TV8Pzy99vsJmvq3OhmDFK0irgOzTyE+6V8jD/oSrDUQd3lEJ0Rx07XHAUVtJ9s0NfKHHZgp/rpI/kDw7f9kGNFE1QIfcdsYhGC6QMiEjb7H/hOC5LJqxyE/TqyUL0pXymb3tO9eoKx3QLdmIXkWdVbmU/1NhC2BlKS+EzvO2jq5uZqZZ6hiTLTb6Gto3AaFav77/89CdqVbdtCQV1azaAx+Fa0tIK0Y22lWYo7VOuz21iOly7ClACXAIDZq8KH0RgW7F5O7g+m+4Lid7LEOiPFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWx2a1pzTFlFWFI0OURYMDBxN0oySG1kQUw1S3ZCSHNUbHJ3Znd0NGZwc2Zm?=
 =?utf-8?B?MExyN1dzb1NLN3V0WEVpUmJ3UHhDWFlZYm45Rmw1alpiUzJKSXB2VVVqQit6?=
 =?utf-8?B?RUhveGFxd1ZjaWdPSnlVWXc3bXJyNEVRdTF5enVpc3R6MWdLOVR5S3FULzNh?=
 =?utf-8?B?NG1yaXJuNTVGV0lmOVluS2ZsOWJud29ONGRPVjB5cVAyaXFVb2RwUDRMZHJQ?=
 =?utf-8?B?SWNmVXptTjRpY3k5L2hPclRHclI0WXp0STR2RU8vbjZVUzFGQ1NrNUVzUG9S?=
 =?utf-8?B?NzM2MkdpRXgreTZwOTFKcXpNNkZwbFZIQWt1THJoNnRYR2NFb3oyYlVwa3dl?=
 =?utf-8?B?OHVVM0xkWXU5WEg3ZEJ3c0xWWjl5cHBKZmF5NENiZDZRT25aVGpudlBOckdL?=
 =?utf-8?B?bFROVGZGZTFkTkFsbFcwdGdrc3RVb21JTlliMVloV0I0Syt1VTlPVDdjMTBi?=
 =?utf-8?B?RGRFK1lBWVllbTFtTjdJWDRBMlRQWnFTNHhlRWRhdUpRUWNLQ2hZeEp1Uzlp?=
 =?utf-8?B?a0JRNXh6ZEJDWkJZdjB0c1k3QStQWGdzQUhuSUpCUTUwQXBrK0dBZDBRN1BO?=
 =?utf-8?B?R3E3N1VQOFNVSlJkVE0xTU9rT3NTWm9oOEZ6SU55NEg2QWRseHpVanBCU1lw?=
 =?utf-8?B?QWNIdlAyckRha2xwdUtKazM2eDRlZ05PRG1tMVBOeTdhWVVjUnhnREZpdUMr?=
 =?utf-8?B?VmIxUFpzZ3FxTUxKK3U1bTBwRW9YOXlCSnNFZ0FiMUZnTnZmUVlXUW5jYXFM?=
 =?utf-8?B?NkZaOGpXajNrS1lSVTMreTBhMlluaG1OSFltSW5mSXdXV1h3NXUzbHB1U3h1?=
 =?utf-8?B?UDh4aUgvNXV5cndiU094TVpFMWFvMnBMVWl5VEFHZmdNMjdhaWtwdHFKdHdQ?=
 =?utf-8?B?VkU4NzdmZ3pvSytrU2l1Qm9yOUZMbGxDNEplamhtVFBGOXFWOUhDTjR1RENy?=
 =?utf-8?B?VVFGYWVqaEhRMFlwcENrL05PT1VFUmFPUnpyM3o5TEFjY3ZBOXhlWWQrOGhU?=
 =?utf-8?B?SkJrT011WnRqVExGSGtRbnQxRHcycmhDcm5WdDdoZVJaeXBIYlhVbnBwdHg0?=
 =?utf-8?B?QUJ2UWZXUVVteDI0Y1VyOUhNdlNzdkh2dFNYdnJnb0duRC9VRmxpTXFWWHZP?=
 =?utf-8?B?NXZjL2prZi9LK3JjR2VaRmhFY1UxbU5UWmZVWG9JN0kzQ2l1aHcvT0FsU1B3?=
 =?utf-8?B?a2M1Q1F2SEVLZk9hTitWbjhYeFU0U1JQV0EvM0RtVlpvVHlZdjdROXFMSk10?=
 =?utf-8?B?YXphZlcvb2lNZm9GSVpCdjBOc1oxWkUrU0hwdTlESTBiR2pBNGt0RzNoeEZV?=
 =?utf-8?B?OGs1ZzFUQTdYOGh0SVYyM2R5a2pTMk1uRlFiVk95dE5OOGp4ZHM2SGppL0N5?=
 =?utf-8?B?MWVUMFR6RHY5TksrZEFkajVUaC8wR0c1LzNSWVVqRzBuOUNoQUFPRHNFa1Vt?=
 =?utf-8?B?MUF2V2ZnNVh2RHFTQlFSVXNFK3lvN1dKV2xSb1pjL040NUtGb1AvVlJ4K3BL?=
 =?utf-8?B?SVFpRk1LT0Fqd2ozT1g0dVJNbjAxZlg5c242TnNVaVRYakhhVFg1aU14Ykxk?=
 =?utf-8?B?U0VYTVRBZjFtWmFDK2NsS3VmK3p5djlObCtqaExCTnVaMmwxUFJoR3NoaTJu?=
 =?utf-8?B?RmFyUXBBMW9rT2wyTE93UGZscktuRkdLallySmpqNXd0R3FmTUZPalZlTjk5?=
 =?utf-8?B?NkxFSVRiZEpLaHBnRlpTeWszL0M5YjBVaFdwRE1YbmJQUGltSmFKbktYMzFP?=
 =?utf-8?B?MGx3Vy9WcmtycVFVVTVpOHlpcTFoWGVXdGhDKzNOc1FnY1dJU2Vudmp2RjJU?=
 =?utf-8?B?VjRONElKb3VoM2xPYi9qbWJwSjhRZjdaRGs2cVRkbXNjNXJkMHUxUXFYT0Zt?=
 =?utf-8?B?dzZzVUlVMHIrZUJPZkNxaWM5YkMwRFV4b3Z5WTZ4OG5DZ1dMVFZsNWViZnlK?=
 =?utf-8?B?M05SWUZnZlpVMG1KZFRoa2p0L3ErcTVxa04ybk9WbDdYYk90QUZJYWc3NGsr?=
 =?utf-8?B?ZnZZV3F2UnBVemFhT0ZwejNNaW9aMTFtUUJ0SUdaR3EzQTlRZ3REcUhGWk5Y?=
 =?utf-8?B?dWM1eDdNZTg1N09vOWNpNWRYLzJaOEFnUEZYV0xxZGtBWFZwMnNSTHM4cUt4?=
 =?utf-8?B?VDVod3NRRm16U2Q3UTlvRitsR2Zrb3hHQm5CdVVGWVpUUFNSdWZjUFp4NVo5?=
 =?utf-8?B?MjljbVlrY0Q1aWoxbEFIVHdQMzFnUWdJSzVUUS8rL0RKUktlRHRKRlhhbnY3?=
 =?utf-8?B?c1NJMlRlVXVSaDhKdWdncC9QVVVkQXgvaTNOMktXWHJHV2FhUFc2Sm1JY21L?=
 =?utf-8?B?MVRQZWJvTXlHeVhCQUx4eitwMnoyZjIvRE1sajFSOStBN1dobU93OWJSSG5P?=
 =?utf-8?Q?91nYNP8Jvie94CT8=3D?=
X-Exchange-RoutingPolicyChecked: abvMge0MsNLvEm9S9vOduSqNiOOUvxPvD5AhNRun4FNUxwEZ3spAcrIU8UawqKlD0VdUMl5mXQdDRQm4Ore18s+9jd8vVO2ytE7cbc6hJGUfVgMYXJTE0FxyAp+RD96NCQE7trzt6he1zGAkxdzPi6qBHxFwCc8gR7NbFN6ELiEvavVisA+6Wu21XW+x7h0Lio9fNaMCpIvU2vI+7SIP3OZkMAiBRinwRUING+XhyOoXzhUkbn/IH/rHyMj8DIegUhKe5OzUjneMi7xHVlqNDObVOBMFUUcu+eW0Jk2Hio4EhXfGNxe7ys7RH/ZOphP89XRrhJ4bCr9JkbqaXqbvxw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01f88d5-fc50-4778-2102-08df02aedf58
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:43:40.9719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sq3uhoDty08TNNJj1inLHAamMw5Wt1RCrAqYovSMRVf2yQjbVyfC1SnWjtD3vSWbIVJEsHSlAtjoGWLIIUeEFtHG5+S52UMSmuEr8bA5Auk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7557
X-Proofpoint-GUID: l7T69RVhBPIAkB2l4GBe1EQxYGHXBJL2
X-Authority-Analysis: v=2.4 cv=KdfidwYD c=1 sm=1 tr=0 ts=6a8d9c0e cx=c_pps
 a=GnodoI7vw6685P6KDJTVEw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=oOh_xqB7XwJDYdBhmPMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfXzGIcQv8RsNwu
 Tfk92sRMYVwPcqwyaPXgEV6l+evwnD/LSwSqkbENRAmeCjPblvFa4IR6dmhkheSC6vrPpNQB/yG
 1IWqM5ExArP0nP97kaoXqUIT5SETvoc=
X-Proofpoint-ORIG-GUID: l7T69RVhBPIAkB2l4GBe1EQxYGHXBJL2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfX1R7PhLE/fp/W
 HYU8M93Wr2iXhWRSNQfqh5NJEUkkPOZ4vzqh/I+5kFMDNdwhIpL86a+tmoebmvMxf2B8E/hlZ7O
 Irw1+YBAj//7FDl93K3oYzIhq42kMMq+RZdatR4K//icrYlS7tgUC5ZUaNHM5Shr+ZbTF66SgZe
 rzdmAyJCyrnLSqISpWip5m3qt0E9Jfp8P3wS5fQmfO+7qr1iIzod69WHqYzbmCIKZ3E9V96iAlX
 LydcKQPFur4AJlUNz6hK7fh733sVewNI7ltqHlfBD3ASJCDqSRyRmUPZ4dScp85fWy/SJ3boiix
 nTxliLZkkRr1a9ECXr/GyhvU3v32f7qu3asxkovcB6a+o64yFgkH5xIip4yI1pLx3qMDWhF1NDJ
 /OJq80WkHH/cEgrC58IZCdygna3hFLabNvXADElmxbQ9VCzQY4ZAHYDB3w+8oecN5uV0t93zV2X
 Zdf1JVEjLgRJeknXVVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
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

ACPI_PM_PROP_SCI_INT can be updated to use object_class_property_add_uint8_ptr()
with OBJ_PROP_FLAG_READ, whilst ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP can be updated
to use object_class_property_add_uint64_ptr().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/isa/lpc_ich9.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index edf9783ec8..07c9509cf4 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -683,24 +683,11 @@ static void ich9_lpc_initfn(Object *obj)
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(obj);
 
-    static const uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
-    static const uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
-
     object_initialize_child(obj, "rtc", &lpc->rtc, TYPE_MC146818_RTC);
 
     qdev_init_gpio_out_named(DEVICE(lpc), lpc->gsi, ICH9_GPIO_GSI,
                              IOAPIC_NUM_PINS);
 
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_SCI_INT,
-                                  &lpc->sci_gsi, OBJ_PROP_FLAG_READ);
-    object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_CMD,
-                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE_CMD,
-                                  &acpi_disable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint64_ptr(obj, ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP,
-                                   &lpc->smi_negotiated_features,
-                                   OBJ_PROP_FLAG_READ);
-
     ich9_pm_reset_properties(&lpc->pm);
     ich9_pm_add_properties(obj, &lpc->pm);
 }
@@ -888,6 +875,9 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
     AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(klass);
     AcpiDevAmlIfClass *amldevc = ACPI_DEV_AML_IF_CLASS(klass);
 
+    static const uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
+    static const uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
+
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     device_class_set_legacy_reset(dc, ich9_lpc_reset);
     k->realize = ich9_lpc_realize;
@@ -912,6 +902,23 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
     adevc->ospm_status = ich9_pm_ospm_status;
     adevc->send_event = ich9_send_gpe;
     amldevc->build_dev_aml = build_ich9_isa_aml;
+
+    object_class_property_add_uint8_ptr(klass, ACPI_PM_PROP_SCI_INT,
+                                        offsetof(ICH9LPCState, sci_gsi),
+                                        OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint64_ptr(klass,
+                                         ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP,
+                                         offsetof(ICH9LPCState,
+                                                  smi_negotiated_features),
+                                         OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint8_ptr(klass,
+                                               ACPI_PM_PROP_ACPI_ENABLE_CMD,
+                                               &acpi_enable_cmd,
+                                               OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint8_ptr(klass,
+                                               ACPI_PM_PROP_ACPI_DISABLE_CMD,
+                                               &acpi_disable_cmd,
+                                               OBJ_PROP_FLAG_READ);
 }
 
 static const TypeInfo ich9_lpc_info = {
-- 
2.43.0


