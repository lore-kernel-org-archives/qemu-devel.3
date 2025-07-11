Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D17CC8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAWo-0005vJ-6H; Fri, 11 Jul 2025 05:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWk-0005me-FA
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:58:46 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWi-0004ot-Rg
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:58:46 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B8HRNk032175;
 Fri, 11 Jul 2025 02:58:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=/HXPt6nEo0a/ya0GNERWxCMOQvb4mTJQ3WCdZfI4R
 nE=; b=gAg50d0vB8zwu7eekBDdkJXpuTN5Cv71tp+/MVbFM2bDMHiIh8MYE6TDR
 nrtHbzskky8bi7RYmV5nzVt3VeTRZVdYZZfxj1EtB45LhZKf9OQeY3bMBeGvBSKp
 2xxBGsj8cPNsSDXjK6kYdAPyL3cpO/8OZF3y8g+Ddw26dDUbmHQK3NMXZsFe7P+A
 az9BqchE0JjHqlWSkdgXpiIoO8J9hpp0J0X7VHUEIkgZfjGXBOgSaBIg+tHjxHy3
 FmVsVqhkvUZLM85mYgCo4/59WQFVW6aOSCjlVpvnhKiQ1mSwsBH9rjD0+RGuRS9M
 o8jAqnaFAlDA5utyBoWDlKW4+FDrw==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022137.outbound.protection.outlook.com
 [40.107.200.137])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47q1karqmk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 02:58:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXk2/w3ygxIElxMzm942qXe3U+vwy/6Xo3vpJA84m63vwPpFgjmb1gYMYRbh4acft6oYTi8vkka7y4RFZvntXL+6KwmxA5lOspO/y/EbmJ/MgSeYiZqyS2prCigoTK3UJe+zl5TMFm/pN6Oq4LJR+qIdZAW19Jrura9Zgwnh5ZaQYwrZu88rXc6r41e0NUBJwx4/VvV7XiswIfp8nrJwf9WvH34nqIVzldUVSaRJhB1drx/xcrIKXpVu+bjQoqAdZtnwIwJQ5VB0IcXhMeugVoYsXlAhdXRK8zJ3oOjwIv00SGVvSjmZsE0RCKwaqms9Yalxy92irYKYALP730PSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HXPt6nEo0a/ya0GNERWxCMOQvb4mTJQ3WCdZfI4RnE=;
 b=lA1OLrS8JexvPrkHtm+hV0Uv1cWM3h3g29HbckuyWdV1h0gNRJq8A6/tvPcNj1lnqjgxgMA5mU4D8VpnsTnjgwnUMATxSBKgaB+ZZ1vW0Npp9i1v1MQdm8KTJgsjgDqaSs36Vhykj+dBJtgYQM6Mc1c0tSDHQpmPeYMzS4XWcOZF5M/g47ayeHPUslf4jlueiFtdeNKzNqHbbIDBJfvnmBjjrCAEZA/wzwoVLSGyRVCKKgdvZPeKW4f5Ke0r2An1eUBsnuA47MpdYeOdLhPEffDOzxzZjzD4I7q5rBwyQttbXxYHixcDpQke78dZwv22ZEgNumyjVHGtnBRQixDwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HXPt6nEo0a/ya0GNERWxCMOQvb4mTJQ3WCdZfI4RnE=;
 b=ylO6fiFdSV+yEQWZlruI8FaBPA8iWpglZeN3uiJaIwwL0mCo7s+qsz+1s+9DZQabzG7A2B8UyRm0u2OnKOqOaVhC4d3bAsAFoTk/VfTZsrD8e2ZwY2NBv2JUfZbD2iEuem0Wo3DWP12MXiJOl8VST3bYmlIRn+WGO8uCJj05tBeNHK7Mwe+R3uQc9QG0c/B6UXaJrPx75/jQ13mYpPaDGirH6VC+5XUMXEowst+SZXSsutD+ol+q5JTwHvD+4GCtDNy3+UUg+CIHwvi1Iob7CGhvQLBKcsUB6hLSNojBbicZ8weCybHSDJbwEa4kVwWzZjX+Uk6txKa9eaP+7kXy5Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH4PR02MB10681.namprd02.prod.outlook.com (2603:10b6:610:246::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 11 Jul
 2025 09:58:41 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 09:58:41 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 07/19] hw/i386/pc_piix.c: remove SGX initialisation from
 pc_init_isa()
Date: Fri, 11 Jul 2025 10:57:09 +0100
Message-ID: <20250711095812.543857-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711095812.543857-1-mark.caveayland@nutanix.com>
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0174.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH4PR02MB10681:EE_
X-MS-Office365-Filtering-Correlation-Id: c94db840-23f0-46fd-1cf0-08ddc061840f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JgVidmkgyWm/a198+Hy+J7bTowmLi7SGuMyyIbwjG4/RzEEX1+XPxqyaLkjy?=
 =?us-ascii?Q?urTae0/nyuMkog2bYcHKO/PT6nlRv3iIKvH5exkBJMNR6yhf7n4eA1OEAUeM?=
 =?us-ascii?Q?65xpCPLMVQwnN3q3n2R4tWIaOmhlsiI6JfK855BRL1BGvQOEHZbSiexrhC1W?=
 =?us-ascii?Q?8D2dqBNkne6fqiSxbsk5SkIWGxlyevYyVPamLXTLr0gzNqbctR2r57g3qwI0?=
 =?us-ascii?Q?l+52jQ3XVrDJ8mOC63gfDwswbTGf+1hc7IH+JUknXd2ijvJ6NYpRI4LgIPn9?=
 =?us-ascii?Q?YKeeXu86JcrK4sImpO+LCG+VMqHwc5nu5AB+UJyQT2mc/0F7X3TiroOSn4Ny?=
 =?us-ascii?Q?/8YPISUM5KSQviNfqZu0z0T7sH4VmPZ/SXakFfqijHyiTda1LMmCigkeTQlf?=
 =?us-ascii?Q?uxl+pg6qQC/CWzCF/MQe6zHkKX6OU0SmnWFu38azdFzRqSM2Kp2Ud9G3klFv?=
 =?us-ascii?Q?CJYJDFIlU9QA/tRpDGNIMdDJurP6l8btSep07DtUZEOFbRUaj+dywwJCzu3f?=
 =?us-ascii?Q?hSYefLfCxhZj1AFlg0mMFHBZTDYutP0xciodaDuOnwNrCtfhiyiaKoDxiC/D?=
 =?us-ascii?Q?cBstaOwod/X4h1JJnU/rb6KzlqgT8g31gyVWzWeMF4fESjYeVNoCniPF2S+t?=
 =?us-ascii?Q?UnNK6IdyXrf4cUFfdaruG6HM+kJb1KmrhBND7BnFK2tCrYhFGYod7VUl6Nw2?=
 =?us-ascii?Q?zBa0y0HKHovkAKCVFBflQGrybL80wugI2p0w5j9z7mJoqObsgoE3U3RUBMRz?=
 =?us-ascii?Q?Zcv9RTCCg8VIzsGHAqe51cyFS7B+xI3bpYZqQuD8yTO9rPx7G0HXiyD+vnsL?=
 =?us-ascii?Q?Qrhg74BV2I6t05Rhdv2OEyjh8Piip4XCRCnjuGDkkFxewc8l81YRYQhH3qaF?=
 =?us-ascii?Q?uhn16sDR49kyjjoce3P0Hm60+00jkf1gKpKay6W0yi65UTqPy1xvWtsbUR7e?=
 =?us-ascii?Q?ohsJze/jrAsKXzEaLHEel8aMUnnfLw/bo68gOEmvggRwP3rxtJV0Ec+81aG+?=
 =?us-ascii?Q?5AxLLtvZDsMmegJPH5Q2Dt73namaBYjhsO2vXPJhCYjVP7PTm8oQ2xF1GkfB?=
 =?us-ascii?Q?dorZ4V+o/hZzV3qcSbBRp9gPoD28gCKvEUfT2vsdVf/Z8zZaH0ZWATC0a8BU?=
 =?us-ascii?Q?ZN/IRmkScmsZ1MluqC1j8EfrEXVh8JG7JC1gHgzmwY0FGbzvUVDn5Y46GCDj?=
 =?us-ascii?Q?vQ4mE9aFlNUbHCaTIwSdrFSStHqD6ggnzcy77bJ+7BQXNSnQi8cgcyaDDdwH?=
 =?us-ascii?Q?fTBTxKzNL7NYuPPJdV73ECdEqF9ccoNdLYp9uelPLKqGoHrM7P9mE3LgNheh?=
 =?us-ascii?Q?IgwJ67iKZA0UIxJLgXnn1KVTjTYLo2Gj2mWxABtjvpIqLHPN/I1AYOnLlfLq?=
 =?us-ascii?Q?JnHZNRK7DVjsWf7Yw5FoNtxjUgm3K503vn4V6QVE+YVumAeMfmhWu7zyl55G?=
 =?us-ascii?Q?3LZ/6v3/awQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7porHKURqe3k7iqIU2Xu17vzxIrtns7qQEum1QuqrjZcaa7EbCqBFCzCuK+a?=
 =?us-ascii?Q?S22NAEjsNqHSovHUIP8TQcX8Zm8Ev3k/HBKOz3wFfU2A0mr24GdYJiO2u8Zh?=
 =?us-ascii?Q?OWgQt2ZS43W3BjOZT2ZX4sMes9e/wbEmotUy8A21NKzud7OF6UOcBV5441ch?=
 =?us-ascii?Q?gpYZ7rCVuBy56CcGUgAi6v3Tl8N4hPhCTmeAoIcpNIC8BjyGLA/yMDYH7fqj?=
 =?us-ascii?Q?Q4gZDvzlaMTreRkoNS6wFMqZ+l6kXZ2uRpI3vyUUebTxGDn17da3Y5FOFLDR?=
 =?us-ascii?Q?/8D+zHVhnRDJOH96JEa6MAHxtSLskHUJz9xrFBN5HMNAXKAYlpsVft07SbRq?=
 =?us-ascii?Q?mLFo8PQ6JYQlZjY6qdnVNCvDSCRwjVZqktFbPuszB9N9FIe2KgJBpFBCT2mQ?=
 =?us-ascii?Q?qCTTUpR9IoTCrv23YIyKuGOZOIZJncU9RsAT7v1EupphU00WTQvbwoMvimD1?=
 =?us-ascii?Q?vN02f6LjwTMjgzgzxCD/nehHt4YrRW3UZpP4x0C5d0MRw2fHWIYgfZAe0VB0?=
 =?us-ascii?Q?VgmBQDjoEDmSyIkQRhstVvbAWLrnuTOOGDbSXP9RIBIBlBzO2zG6VkTBzy5H?=
 =?us-ascii?Q?i697BoUhRaXfTdr4Grhimj3a7Q4/gK1NTVawzXQfBYGxaE2Bc2ufj5LUC9OJ?=
 =?us-ascii?Q?Jgd/uts4PddkwAhYv+pSZiBKDbvNPvfvrsmiez5ZnQfw+P2LsDmFwLpADV2Q?=
 =?us-ascii?Q?0750U2I0gRQ7XoKWDU/FzZ/Xojgusk4CRtKnKt2e4x5xqkIduQK3hUlgE1JC?=
 =?us-ascii?Q?0ocAelBESFB6WqmaOf5Ze+U/7SaiNI+Hi0rRtPmWfXxyuBI1Tczbffoo8kA3?=
 =?us-ascii?Q?ATpHXiIt8ONUd815/Auk/Cw/fqthI5d2DMpiOEkJEKGi6NPvmUuV8/eCbhm9?=
 =?us-ascii?Q?cWM4Lq2EKGm10E4oLs4LUYhJbsb8F3wYBZ0Ime2xtmLKDeMG92lURKMpiqu8?=
 =?us-ascii?Q?ru46MtsLs/2aU6eILbvQuEaIHeZgPdicLGjAIkxoRK6t2wAAI1A5HMPsYlsW?=
 =?us-ascii?Q?n40EP245P8zWcr2Fk46onRdxsKy68gz3l5lH6U3hPkSWcYk5ZMOf0R/uaicm?=
 =?us-ascii?Q?lKMMZZzhyk7YvR17/RNj6VbOg5PpBKgFjb12ZZ3MG4RItDOXmhhFjwNKaMuZ?=
 =?us-ascii?Q?iVFtXKZoi8bXlZSQuCrKdMe+jOEfuv/abdVV+1dqKYlFlF80pYyCtn13+Xlg?=
 =?us-ascii?Q?Yk52zg/zZHLXcNO8n41mRq4WXWlU52WKkGGWKiNOEFVCl1O8C3JCFvalekW+?=
 =?us-ascii?Q?ekCWruHdyp33AubH4IGPtAdUfHofPrNHsQSQHZZEKTiCvkAYwXpghDi9ESlG?=
 =?us-ascii?Q?eUk1Pfjrmr/2DOuikNgPtLXRT4p+Uw+tdE24oL7f0a9Le8Sh4+FvrSeL4wIi?=
 =?us-ascii?Q?gSW9/S35Lu6h6hmhPtXWNaBHt4zhCSFVyShvYuSqQFgEsTCzbAa7wS/J4UCb?=
 =?us-ascii?Q?rbb5xFWrwESUAPsNaY7R/I1DRaDIploKABtpLNawupiPZp6p7Qt2yBqQFM3j?=
 =?us-ascii?Q?W8hT4J2/XsZql7GAz3NMggU5gi77rVA+aq9epBHNhcSrZpFpDCCLRfGWjbKA?=
 =?us-ascii?Q?B3HjXNFob1R/aZtWTTG0bz5pJnXntiFkvJWfNvK2H3DLTnViu9phcCpfNXQs?=
 =?us-ascii?Q?agP9pjQZR9mOfmtmnhRDifQpznOYGlIeB/wS9hfBTH1XbyQr2lxX7d9u19bL?=
 =?us-ascii?Q?SDsCBA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94db840-23f0-46fd-1cf0-08ddc061840f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:58:41.7369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzTlvoaAIdv0qK4AIUxmMNF2WRQl3rwD4uY4h2F4y3eQx/hAE9wy0dAsI5LtwVTsnwKQkDvJy71ifYORcwe862o5VfWqa3otVTRJzr+iSnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10681
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MCBTYWx0ZWRfXz6aJ5LrJhsAb
 /B6xJdFrPqewGHvJ3bhR6SVW/fZy0VeeqB7aQ3en341OKXBHriLdHEPq91ydVYpW1bzenNJgVQR
 1ulClucQ77+SgOhS9jJWcOoZJEOiV6RWM25PfspQ0vLeETXH+c+7cJnL20OORHwHWwnwaUeAiHF
 HuAxj9hG57s3LLGxMXl3fYH6EPfCOXeHQTh2Z2v34bQ68aqGfumSCJIAgwjCXYtnkhaTQGDXHPe
 YuwdKR3ex/yKWxwi/zBvQk5QxlOBW2tfc0arBmfr09vLpYH20sxO4FG8MQ7hVaaQRPyGYVdSSgW
 zUHYcgJn1lCrZGsXWIfnNPAJ/X+2oE86g9Luah/LLU/hJVXCK4fksKigzjwiGnHnpf+bbSPjgYj
 8mHPPAWpX/qj6VpttKFE490NbV5JVNDV6Yril8bDPh0YEmr1wGgG2kVeySpRTRa1oQMf7anr
X-Proofpoint-ORIG-GUID: Mggllu1b7rMl2MXF011Dw6tCJKKR_CFg
X-Authority-Analysis: v=2.4 cv=Do9W+H/+ c=1 sm=1 tr=0 ts=6870e053 cx=c_pps
 a=fuE/7uQEd4exF76fV1vK5g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=yiTRickECGlooSfTVXsA:9
X-Proofpoint-GUID: Mggllu1b7rMl2MXF011Dw6tCJKKR_CFg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
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

The Intel SGX instructions only exist on recent CPUs and so would never be available
on a CPU from the pre-PCI era.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 16d666f97e..c49be1d799 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -491,8 +491,6 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 
-    pc_machine_init_sgx_epc(pcms);
-
     /*
      * There is a small chance that someone unintentionally passes "-cpu max"
      * for the isapc machine, which will provide a much more modern 32-bit
-- 
2.43.0


