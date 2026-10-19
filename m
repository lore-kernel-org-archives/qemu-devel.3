Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196D4CCF2D3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIlIJ-0007jS-BX; Mon, 19 Oct 2026 07:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIlIG-0007iV-8e
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 07:12:41 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIlIE-0006A7-Nk
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 07:12:40 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8P0Qg3169761; Mon, 19 Oct 2026 04:12:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TAOVXQJDaXE3btj5P/XXf0XEZfGBwKpBJnEaqxNFb
 Rs=; b=1mVjjHfO1kdlif0MWOWLm5e8ieFQbVcq9pdZAE/D4TA7YUt9Jp+7FXwjq
 2L8xjMuLBwLKYfnyUmv3zO3L69+ANdadQS2GEOMhbaMPkqM8OT2yJX2EcDSfnXzI
 B3pZEiZQRO0xdMSIKtXD8uTszF8phdxO+cFmx+sYMRcMIF90t78aOrhdRtDGLl0G
 mgTuX4rZJ9BbZTCwjleVhnThakGA6GEJvLJrB2O/0BiO8SgVfuY93Xp2V8bf2WIL
 l3ASAtLs0rVzZsTaiHpkj8Zi7zRZacJZt8ISYzcvlIOoz4iemf2vdsDwSRCdarUt
 GX0tq571smBzngzSYW4C6JppECXDQ==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020080.outbound.protection.outlook.com [52.101.46.80])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc6j5kfaa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 04:12:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/SsbMWCUlxGgPWzKmd+a32DRZyecIB2Nt73tp7rnmXz3gNOEyF8xQc5uWRw5yY0bbMl7yJU0sj5HqoBR3R3WTlg8CaFmAds2kAh6++eRfdV8Up8Dj4dYxA+zM/k82hzJfD2OXU5hADul0SmU3VmaxLfhC2LJ5vI3yCR9POS104QL9Tah8ZAyfzQR56tGy0pTnqV1xaYGjKtfftsbE5oYt9GOwWqf61BhHKGkO7gO0uLEz3XRmu4BW3IxPZmzi7oYYVjjcgSTKFINV0FvsVOSWafnbn+rr6+w0xYq6XYtnPkibyCyyD/nuDZsRanS1DnloUbLwpZS6FnhtA+bhjhtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAOVXQJDaXE3btj5P/XXf0XEZfGBwKpBJnEaqxNFbRs=;
 b=sOJ4pTmO2AUvEzAngHEXXacolHVB9Z+OO8gFVApUz0NvNWc/ERHVSLfbDmaWExlVx0CzPzwMtw7WrfeDQ62awoOyLhzn08k3SQX9gzYlZ55xjxolL5aCZFlEgeNI3iSDtVHLvUD6ueLYeSidBtq0mNOSUApAcu9NC+sWXfmDmwun8F4gO+enAHbbpuKKO6FT1SsfjNqFV2qiQZAwACLTbrBcqdREeDTuKk0rQKr0CfRPgiKu9JXDhyw7IrxRy5m6vGRRBrn1vCjenyFzJgheE6E2iyXAbEj3gkX2DHZ0OWyLIEYv0QGAGOJgODExH8sQ6sxezOkX4gzi/f/WJ/YH8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAOVXQJDaXE3btj5P/XXf0XEZfGBwKpBJnEaqxNFbRs=;
 b=UO8z96Oc3PqBv8UA/Pa8NGGc1GBh2eCnCQRV5UWu2cxjz3v/nEqekwa3EL80pEtgBPykoPWAEYjZul/P3G9Pbt8/59K7kg0GF/BU6A+1styc3pn2X3V9XAOHX9qITZnU8ZQGyrro0CXc5dAnpJV4O5U56sxwA5Cx4YA7kCj+5o+3Z4I9mNPyDC+UOowL0Hmv/iyOSRo1PSpbE7OxLXvJr7hwHFZ3qkEuyAnj7i1k91/E119thtTEDTQVj2mOwLQ46JtpDD9H+kQiyvyz96K9++9+d/kW1keZNcfF2tdmNxXNYlwmQ5kDIOzathryRr+Or/MwRgxv0cA7YNfqbeht+w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM8PR02MB8005.namprd02.prod.outlook.com (2603:10b6:8:16::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 11:12:28 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:12:28 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 02/28] i8259_internal.h: rename TYPE_I8259_COMMON to
 i8259-common
Date: Mon, 19 Oct 2026 12:10:02 +0100
Message-ID: <20261019111218.1429468-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019111218.1429468-1-mark.caveayland@nutanix.com>
References: <20261019111218.1429468-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:a03:334::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM8PR02MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e3bf4bd-0250-4fbb-ffe1-08df2dd1dcd1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|261009223027099003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2xrAG4AnKtXg/YCQNlw8ziy2mX8C/ZNEwxCwHv0aDoTxqRqsPw8ddTKbkVJFaSgCMjgRLEUdgt032tj+4p6hja4x9SxInOfQNGcqo7E4jglQWOqfHq16ajiCG3puSH0rbvxRq+hR3DxGPpTh9jDyDfkjglurT0TxDY8E6tNMWol+rySh1I8LyFA+bICrWFURJ0IxDt/PSN7wq0FzRVIXO+Cwl9kgwhzFWBJ3Y/0is6N1yfSas3+UaAgK+qOpNp+y2gWe6rOmIZpIAIcNlfQ6K814AjaEQDpJJi19kYAASQlYIVxgh24OR+yldp92BgEoGZUyz6slby+vPKp4ljDYQZi0lA4/f5Y7P+bUB4DdYQlwaHrbw3Op82oqP3MZ2FwYnqy42kCnROX/MEUFt/ALRNfPNRB2FNcPPdaHJ/HFcw338T8RVfTOfslcmjq/SijsLQ+JQgilOt7VHHOvgbBbDHRalRlsUxILoo0Od9MZ5YWLDvngF+RD8wkbl3y/3ZEcwejnZDwTB6Tome+lOenq9C5wc+Ni7XHxOvHHjrKBWsDzoMCscMTL6vXQrlinucSA6YYmArwNiW1XdNqABfnPRcDg4ldGrPl9fPiAx+C6MyesnIRl9nLP+VJoEaSrcqe7VQRMIq50EaiYrOD0EMmqSz/xeKE6CfFDzxfBCC0+yMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261009223027099003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vgrnr+FqSHzaIq6u8kHYUqY3urQQ7ns38snt31Os9Lw7JMAxzmTa2HikGEwQ?=
 =?us-ascii?Q?McwVx5aCO5O66Us7eISyNoAJHMRNf/M75YEvFfOcKDL/k6Ra48pFWWKCQAtv?=
 =?us-ascii?Q?nLmPHcc4n+Ija0SxkBWpG6XZK9MThuXcR+F/41dwRQYVloutrlC+CXiC9rGp?=
 =?us-ascii?Q?DEbg2791ymezBrR8RGf9gkoDSBw+I5j0rABRfG6EMOMv48Nqc1SsiHdd4t5e?=
 =?us-ascii?Q?rlSPOV9kvppxDxDp74baekyjjsFYPZK3aXwkWYl5h4DHOTAy/uNri83qxhjO?=
 =?us-ascii?Q?NzLUQ08on5oThxEFeZBm2UX7FHgXrg18ufF0tbX8qeLOE1ZDphuEDFCi7820?=
 =?us-ascii?Q?iv9xdqZtq3Gq3UYQlPqqTB3nRo/FxGR973IaeaGVKLuBPx5bptwnhip68y7X?=
 =?us-ascii?Q?kfdX4JHLDxSJN4CKSS6hJ9w2m0HArS2SiGMBPxf9lMcNhBlIjTSrWuoydd9g?=
 =?us-ascii?Q?LzxW04YFT1NXnSG15eIA/HlqzsdMSZEkMUUM8e2tlfR57Yb3WHP9fZVu84c1?=
 =?us-ascii?Q?L3x3kxPMoPg8grwk0tDQ9kqZpdXH7C3lQpGn8lM7Cx46mz5ZA8eWKmxPA/RF?=
 =?us-ascii?Q?Z/K50Bg3jnUKB70cyTLIok+f6o00+PcR1/oX0jGIRdjQngMyB8H/Syi0nCjw?=
 =?us-ascii?Q?O7n3pk8dXdeqL92bTCCOIteQdML0U59HNMtxFagNsag9XXXsJBVSZRKuEOaq?=
 =?us-ascii?Q?rzP8itsLw1hsiMwNfBhCw0wb3MzAh0E1hJPZ2avCw7Ir82ABeCEvps9FTDNi?=
 =?us-ascii?Q?f8jDxm8fQvNXpETgA6l6R2546OyNwLkFO05oQvY18WBT/veoFiF0PIGkcRvm?=
 =?us-ascii?Q?5Qmi3HFJB180cI+yxg9K+kGAdhciEZ+6OklrN685TlLJNEkPrDNlCioj8ubs?=
 =?us-ascii?Q?Zna6pAu0O4KbBImiZy1AOWrNSclPfYF+jRypOE6mHMGCRwixU5lJCFcbv5ck?=
 =?us-ascii?Q?stnJ70uZtgPVPEr8o7Tdc7NRO2R5/maKIVH5PGhSCDLOGt7mq3l1V2U8Uw2F?=
 =?us-ascii?Q?zyMq99+HNq55YLQQh9AsoV91YiF/9dTgtVZGqx2ifmUW6gZyeI9+KKGc6RGs?=
 =?us-ascii?Q?KFzAXEw7yW6sLgsuMXTnPPkri7Ufj//UQmiKAD8mt7I/su4oa1CuhMyflzb+?=
 =?us-ascii?Q?AdWR57DzeFuDR0RpxaEhUjaJQ/ZKOq9+hZC6dr1NcyAdrIzhLy5ANraHt7dv?=
 =?us-ascii?Q?QWBELFzLVbYrrYbby0xe5XD2Tf+0UnZi+t+MnoALQIBCwe7sg2QkqPuzGQWr?=
 =?us-ascii?Q?VYR9FX1UycvxTc//yp08FcDyNPdlDCh05ilpc1bS8iZfHLCE78d+sUqKGpcc?=
 =?us-ascii?Q?Q7hO18bCXtHd9GIKHTfYBuhsCBT66HDFDYHifuP/NzadjOPP4/qVxT6nsNhP?=
 =?us-ascii?Q?ZIHCqiSrO3k5ruwg546L3eaHWr/nRhWsXmj4Pt9hz10xddtWxG+iuaKDz2Ac?=
 =?us-ascii?Q?9YzhyTEqsR9TQ+4dL2q5lRLhJBGJD9XA1GGCq2zFsYEeEl5wTPH54J/wKwzX?=
 =?us-ascii?Q?MnRyvdREsB854GZANa8HJ+aMjY9Tqrx7TQO3AOB9JJz1XIe+AFgV6yxEJtKw?=
 =?us-ascii?Q?RXwIdzKUu+kYjbomH8V4v/ck0Hyl4pVTZyzV6BOTuv4HPYH+6gmd36lSEPkW?=
 =?us-ascii?Q?J+9GxfY65Tqq2oPRG0ay5lAxLL196SOBWJDLKO495lIzxSoNdjTrFSGKJXt6?=
 =?us-ascii?Q?rz0AV1Fimk+6nAu5D0g56n53BCuk4jwnjqykcezqKACcafipXm2WBCSxh+WL?=
 =?us-ascii?Q?BedlxtehfocPEnz/2sir3Lt4/JCqihE=3D?=
X-Exchange-RoutingPolicyChecked: fhdMkg6ZBdI/1XgXPQ1bTRARXem/YuHbdbdN1960C1WoH0eWpowHHGoKlc3fbkxFwRn1YI7yhy5FEgZfCOeW9zRtnA0GKbGUZejAJmKLbhxx4hUneFrQL5TOA2ndlPK42QZt6cFtyr7mJVRSFRn07jbZIfft0fY8vMi1BomwEq+dHlU66U3QNqQOQo/xBbH+1daCCWslhY4NpoNFc/9k0JGEO0mLr9DFYuOBVG1YENMKQsD9+EwZOQ6YXbZJf0Jp42bD/jA+XaC15K8fNkzCtA7S6UFkJRnnHzVCZ88R6hOn8jolQRt11+9isJigmGVH60lZZTSvB91p8pT+oW0eCQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3bf4bd-0250-4fbb-ffe1-08df2dd1dcd1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:12:28.6621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2H7OVSzN73JpyY/lpiNqOHIOJE8aydGjvLA5RppCaZLx0G0jyqAPIb+fgTSYnywQXLbDE1kDA6kZuTG02U6R6EYGyBg7CtjQPE3VUuj2Tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8005
X-Authority-Analysis: v=2.4 cv=S+NMU4sP c=1 sm=1 tr=0 ts=6ad5fb1e cx=c_pps
 a=mPoTjFGc+mEQF3C7Fih31Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=xWlEjtkXqD840QCPih0A:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NCBTYWx0ZWRfX1K/niHGfYva9
 ZhH/dk7hINkHNPDPHtrHpoSOvKTSK9trYfrVY/A+xz9mq/frFj3Jx4U2Usza8ykeZylbTdK33iq
 BcES2UJhU1MNuVsixDv/qf7OGc4ikS8=
X-Proofpoint-GUID: -P40TlaFi8yvXvvpa0mbHno9VH3iLt1Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NCBTYWx0ZWRfX75+pxrpGZSGs
 ZnjK8YHfYWKJkyGTU46pr4Gr/HKiaWTUPA4bUVREGgWIwq2UwbHVJvTukuLtHD9jRlmn+o4YSBn
 kFo6mqRBfVEuLyPH6UgLceyup16PkkPk2/S/xroZFhE9c4AuuLgpNXaij1BKdBnpM6cFJC12lOd
 DCZShfa22IfhkFOJlr3ywHUgjVE5RxoHw4cEuw1AOHrnCTYeiiIFN+14AiFSNGikDDHaVR6k/4t
 1XSsKw+le+GkWr85zobl6+pbQTjNYqIxJWY8AswM1YMDqZDpXW82OmGxihNnmdJZDI9Ox3rbKTF
 BiARXczEmqsgdPxzNgXQZHtUXVw/0gKVdja/9vkEHwIRt4b7r1pRRv2ZnG1j4Q0mTliB6BjBNBd
 zPld1FBIpaRsoc8Oa4nLF4TM74sVcwDhAgSKW3dZdPeftzruA5FRLCX6pHdhBlSb/NDQIwRHR6j
 D94LFBLp04521ltDahg==
X-Proofpoint-ORIG-GUID: -P40TlaFi8yvXvvpa0mbHno9VH3iLt1Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
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

This is to emphasise that child types of PIC_COMMON are all instances of an
an 8259 PIC.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/isa/i8259_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 54dc9036cf..289d08b7d7 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -31,7 +31,7 @@
 #include "qom/object.h"
 
 
-#define TYPE_I8259_COMMON "pic-common"
+#define TYPE_I8259_COMMON "i8259-common"
 OBJECT_DECLARE_TYPE(PICCommonState, PICCommonClass, I8259_COMMON)
 
 struct PICCommonClass {
-- 
2.43.0


