Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334C4C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6nB6-0002p4-Bb; Wed, 16 Sep 2026 06:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n95-0001Ln-1J
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:48 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n92-00033r-GP
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:42 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G8JrHB700573; Wed, 16 Sep 2026 03:45:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ltDhewVOxH5BIDFITuFF3S3YzHHvPXtjOOTxeIvEY
 0k=; b=mWxOnbPIybvQPEWqgbBSAS0KfdaXAQcDGrvzReQkEbLjId6pdBOUiRqb0
 VyMXcS0bJUJvhi5mLSsK3rlpKhRSOrQ+rv+jN46aEFVHq9plinrGf4JK7Vx7HYdc
 /Eq1t8yh9TNu5FWLEeaqMjXQklR0Cb01lOg7mtxW6CVvXD/M6hO2xHT5GJS2WTYr
 PNjA5nS6p+Gf2hDqs8nMpPTlChlsLeYot5FMun3lvz87zgn0CKRpEegcLveBhR2T
 asnkFztAzAutBoGCBm32QmDERjCd9ZZRVFnnS4qS27MCx0lN8TqQcr+PXka1wSnX
 sADp6D1kFD6aFJyRjpCUzke/hq08g==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021119.outbound.protection.outlook.com
 [40.93.194.119])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gqa0ka9xq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 03:45:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8ypQl+IrGsTzYmc+VrPAaOR1r6Ntw/opRWBH34Gp2rl02pe2YNSM/0cRTxjCfdx/rIUpxEl+ykjCfCwuE0I3Yr+1Vf2oGauOHyilkvt0x9owt6GbdJgLPc90g/DnDaONQ/2G/5PM//vKMgl2yrMcY29SxUH3p0+0+ojgFO71z9bHF9i/9lc27f9lwhJcCV5P4nCHLPAIjfv8/v4xna2TQILNuhNZmFUf7LBg5OHH+YYLpThXC0pmB+/VKPPtVaGFTq0JBHbSk65omf6ccfZBmEfJbk4Npt65Wq+2asvZ0YASSnyZ8p+yaFhJh4bPxAl9EMOB7knDjWkqUwKlKDfGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltDhewVOxH5BIDFITuFF3S3YzHHvPXtjOOTxeIvEY0k=;
 b=mDBO+/8t5BKeOdf5kcZwaBcZB4328h2w4Mkw5u5iSlak5cN6svDIHpMxSl3LUgcc38jkwG1/kTlJPlAd4dUtR2kqM9PE0/1nzdSRwjv6iHxshHeY/JbXS7UNQrTqLth/5FRCbBgiXZrv9UhuZiBhHSGcnpkQluIHVnBqUUifItjqetJUboPeCdOheWC1P09Xf/HRg1gTH+WOjoiNVqIDQJPkvUM5osle8b3nMKJ5dIvkwHNclPCoiaA4kwqDSNWOqLPOahgXYAfpsTl272uHOG4LRK3v7fM8xJnt91YVfsY5/ldL6iUMddamzMLzxVUtg0Ah+MELH35BppTdgnQxQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltDhewVOxH5BIDFITuFF3S3YzHHvPXtjOOTxeIvEY0k=;
 b=h+fBzxXMZzbeXRlX8daQQx7bnosXt1AjjxzpTy9RxDoBH8hKqHAsR5gpQ8qWMz5zQiWc+dFfcjcz9d+nJAHRP2kDDFyhLbZtH7E7fOrCXdAzw7yh90V1xeRMcowFlmQ45eYi+TPUmpXqyHwQWVxQahYMVenKBkbU5EJHeRTCSMP53mDSl4l4P0RicGy15kEFE046TYbbCGFJTu+qOdQtm9CuraICAVv2PZjV2oLW88wuzav5qDc4UzL/GwtCubP498OhJmyaXDzecLCH9ey5UcYG2A7Gf0vmGPiJS/wFR/os2gsO5+kZPJFlnFbVQrnovu5TZauWx0SWPYjZeq5JsA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PHXPR02MB11343.namprd02.prod.outlook.com (2603:10b6:510:3cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 10:45:31 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:45:31 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH 15/22] kvm/i8259.c: introduce TYPE_KVM_I8259_PIC device
Date: Wed, 16 Sep 2026 11:43:43 +0100
Message-ID: <20260916104435.600211-16-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916104435.600211-1-mark.caveayland@nutanix.com>
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0224.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PHXPR02MB11343:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b3878d-70e3-4cf6-8b81-08df13dfa0db
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|10067099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: XlXoTM862QELIzTTHjHasT7T9OoYtP7Wae/N70KYeqZeL31ekCOiDQMJ+BtSli4D7FuQTk1vkx6N4IINR074ry+aDFMIXC09W9LnPWUFOpts7Zm7W0uL/8ILLmTApQ4W+OSvP6pTysZHZcMp33FRcXTuFMG6aRDXqk6pjoLqdn0hCF4gYtliExHDefpLGjU1YVK2qwGBBMjT2i4gmHf1sHoAdZR0gL/lM558gXhCe18n6D5HD8tBsDSmLIltMspWsVPfBZ36T2mv+Hha+JW3Sn7kxJGXxncz2Q+VzdGGTdEwhvT5SiZwtNqLuXcXHkraNwyFAdrKyoYBTi9stIU4uScwHb6ozJpJU6zSKdSd3p1/BSsUhdNT5WRDs4kR0XdJ1+xh5bydBU1bM+FuoYOl55/RemLJPp6/9fS927PnYn3cHfs3pIlTDXNNOx/3Nd/7mQDeYERYV4L8jkAbXNC1YMPgSvEioAWVbhtwd3FkpM84WoR8x+5G1AWXvDkOBIpzkYsE7gxQ9kPz15KGN/ohn/11urmUpU+4Jfk6L6zjqQLdVoL5/P6pQv5pIaJj08HhtSXiydHlXYhffS8XGXzE4PmpQAulOo8Vqu9OaWa9R/3NEluqnesI2ypfjOep+W/OZTTZ71IKpPDZRiNO8kjrjREi+i4JeNBZXcb36u3g/tg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(10067099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?28KCIf911ApyxylgPf1uidPuvnRpiOvHhF4B2FNc/oP0tnZRO3Ccc2GBg1vZ?=
 =?us-ascii?Q?XIVyuDwkPohmWWj6xxTUUYGYcs5y2wLhMGtgelUYZLlahl7dY6TEkcQHqksp?=
 =?us-ascii?Q?J76bacDHGQXXv5ztkmrzMfekLblkEmbCZL3xuFB1c5M4VCnWX97Rit9N3eLp?=
 =?us-ascii?Q?jPuKLGZseTPjjZh9Zp4V2VQ4LhjzerM04V8UpZgDWmQ9Yks3n2Kj7bslroV7?=
 =?us-ascii?Q?JmkK4YLYHR/VsjbUOvcUC/MzETecauJXQPOCnEby/bVo8rcxbkeyPtLh9UND?=
 =?us-ascii?Q?t+gZiR9ALLtDbs2uabkbFEQVIgE39bALqZ0Fb7tmLqbtZdoAF+iHavGre/7j?=
 =?us-ascii?Q?g5UeU1cCKXj72AiEQOBB6NhfF/lBfK72eqpFAXx+79fJg0oDaNxS/tBPcBD3?=
 =?us-ascii?Q?uWBSMLHnfpiXe/vm6Q2O6TbRhQS7Bbs0V3QNZnAYk2M5wLTSbqFNoCfRIDJA?=
 =?us-ascii?Q?vv+DKEBxjWVDndPg0/uZEw40/ouFxLZYr3nMf+4KgDThck2Jl4BBbSikVedk?=
 =?us-ascii?Q?B4xb53GkDav19HZh+HirzuxFNZv9NvqvNkhO7iYvwnLlPPvcvlPq4CJ1yB2T?=
 =?us-ascii?Q?RKvn/PX9MP/9WRLC6Q6svl4PHZFx9YutxKV53zhnP0+1SL7cmp29fDxFrVcT?=
 =?us-ascii?Q?a3OJtCiBBQ4rYe1Bfg7qIAupYs46XxctUhe1k0XzL2U+6GnfUj1d2e3qFCOm?=
 =?us-ascii?Q?mOLdQ2+7dy8b/of0jepwycP5ccvwWwcQsb4se09qZPF6fGYmifcuZKUKlCGC?=
 =?us-ascii?Q?wR21tVr+t2E6/4+NTct8g9GVLwcB81/m6EbJjIqspYgMd7ZLxj+H5O68sU9F?=
 =?us-ascii?Q?1GFSutjYdJsstPRdHaT54f66w1xYdaK1hWX29mTcDbEtjSg2adCqT3SioDZy?=
 =?us-ascii?Q?oUVh+PyTqMO+g8D/qEjJM1gA6GOwc0pKtKIKgRzpy0kRQgUgcQwAdQSew9kQ?=
 =?us-ascii?Q?KYePYdjthpGa5RGVlMI6HqcAideE8GlXOKDkTCuNlN4Pp6daBU8oJtgTjVrM?=
 =?us-ascii?Q?r8w68YeTR8wJ9BW4kZSbbmK833mfBssOzfTOtGGz0Y4+6j1b9eru48tcq0LR?=
 =?us-ascii?Q?w/OMTsrmdJQviDGmm+0WIEfI5baKksAY+wOJF5QoKKTeuQ5/LG0828GzbfmN?=
 =?us-ascii?Q?HzPS4czfQdP7K9AnzN/6M7rDOnzXAx8TmtrZlZT+H1/CCEFKeGUXgy+EuAgD?=
 =?us-ascii?Q?07iTaKCUl2+aWZ5+YriCaeGo9q0inYkdVDYf5LXPQoBzxvKvARfpiqhH7fud?=
 =?us-ascii?Q?X5zZGicqIGWCBNvILavp+twwUU0kVA/qoA7YPvwJa9yKhqGOwSSUinihzi3H?=
 =?us-ascii?Q?CWUIwoTfsLp5pkXRtovS/pHoga5pGYANAmwqPOxVQhobLDv7geguZkU0THzQ?=
 =?us-ascii?Q?xsaywAHtovyJ36G5ExGTVcmQ2tvn9a4zSQvZoRyaK4vvoUrzmYSMrHrkiIMS?=
 =?us-ascii?Q?2z09n2+GNKxvRxVXFQijHfR3uPCQYvmkXuuzPmMLnRrTteO9rIi2dKP/QekP?=
 =?us-ascii?Q?0WErm5gHZx1ruUeBo77XJZqKLp7ljT0nS0B0UdLqlFX4m2+ziHJk8gwavppb?=
 =?us-ascii?Q?zN4oQEsbaBBkfc879sOja9lruSS3YRjWzLXlwb6SMIBhYu+w9tNn88EHFlYs?=
 =?us-ascii?Q?WSY6ssJ4HOhIey4tSdsB7pS+lQvA91ybLTrN+m5aOJI4w4DnDIUbZEC7SIJL?=
 =?us-ascii?Q?YMoTMSrTcTH46diRbgAXeXS31lpwId2Zb0+AT2U0x4NCK/DJLS9cLU8Fc+3x?=
 =?us-ascii?Q?uhtRDYul3eRZM1DWV3Vu4KeMcR9I4gM=3D?=
X-Exchange-RoutingPolicyChecked: XJVhPw+63izdzpFrqJ3YvOlHjghh4Y9E/gNhUFdzFuaaxN8d/B+KfzsSt+8iq2lnxxnl1esN6X1J2FdosL9jPLupaGgTKEl4rtOx0x/b+HdTnn4n2gF+w28pwaQJDP/a5FbMgYdaXLkaEJFQ+edZ2OWRbs9fY+TJpboQD0l8gnu3YAgpqQWuvojn7SZNHnbDyiSEjuLAhQLybKlRI9+ROjueaexww+D71ETQtmKt1s5k/BjT/JjaQfb701DvZtLAmvpXcG/uVw58FRrCs2RyUhF4KFurcE8ED5SytFaNjWbrxltYXbgtk+8DyfToN6ZitlxmNhQovSS6kmrLkYh09Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b3878d-70e3-4cf6-8b81-08df13dfa0db
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:45:31.0196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNYoYZn0QtEYCNygkpIMnHxIEOurJvq2W+XeuIIYijDwgXK71QMnrBupo+8bnfi0QAFqVXPXb4yEQ+ItpxGoRFUwEkoGYhyVlO8OYyRhJFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR02MB11343
X-Proofpoint-GUID: T_a2ioT64h1SRz37BaKhPISEOa-ScxtI
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX27lMZ/R2MGJF
 PXGDVMGD1a0xFW7hWzB19B1OlxwAnrM3npfFjq5JpRzAK/PiXcSUixMfBfFvJo+pWdpYuzDuAHi
 gF8qi5k2FgzZ2Cm0vruc/OhAjU2WKdM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX7qOPq2+hJAXL
 KfHgNAkraJHUE+miHuWArTxFhhmC9DW+yvNOzmwyCYc/PiWtaZaudKn+AtBpQWDc+fZSafIoPR6
 OufkW5igW6e6W9X5PlydS7LaDV/8E6U0NuEUJYPDPIXA7Bh0FBbDVrY4uyxKxIItu2ETln6rbfw
 6C7Tp48aeEFNFSAxslpvjVVaYW2ZU7FewMMpPAkQyVGWAUckbPnsZTeENZqutX2WZampasEOzOa
 3X69iCyO2Uubs6uqrh9RCdLUgkA2qYBS1QWLSJA92CV8H2kZjdT1RG6LouYsi2AFPe++qN5i6vV
 t/GswpbWsSAQWZR77SLdwrX4zWgcf4gj3kKsS+HO0BJcZ5baXlWooP+jZsbCWN61cGR55f7svpt
 N9iBueTSC7oit8DyHgUszPLXB0UvMOM3e/hxy+Aw9z68OZN2tNOZte9mtl6slHiXW/KoFkLq8or
 Lvmia4h0yhgfcVlG6oA==
X-Authority-Analysis: v=2.4 cv=P46vFSAu c=1 sm=1 tr=0 ts=6aaa734c cx=c_pps
 a=GdOSod5Hi6qnJTGfnwF89g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=CV9Lyex1vB-al1NDbmIA:9
X-Proofpoint-ORIG-GUID: T_a2ioT64h1SRz37BaKhPISEOa-ScxtI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
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

This device represents the KVM in-kernel PIC for an x86 machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/kvm/i8259.c | 91 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 3 deletions(-)

diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 9793473163..0ae5caa655 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -16,11 +16,25 @@
 #include "qemu/module.h"
 #include "hw/intc/kvm_irqcount.h"
 #include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
 #include "system/kvm.h"
+#include "qapi/error.h"
 #include "qom/object.h"
 
 #define TYPE_KVM_I8259 "kvm-i8259"
 
+#define TYPE_KVM_I8259_PIC "kvm-i8259-pic"
+
+struct KVMI8259PICState {
+    DeviceState parent_obj;
+
+    ISABus *isabus;
+    I8259CommonState i8259[2];
+};
+
+OBJECT_DECLARE_SIMPLE_TYPE(KVMI8259PICState, KVM_I8259_PIC)
+
+
 static void kvm_i8259_get(I8259CommonState *s)
 {
     struct kvm_irqchip chip;
@@ -120,10 +134,21 @@ static void kvm_i8259_realize(DeviceState *dev, Error **errp)
 
 qemu_irq *kvm_i8259_init(ISABus *bus)
 {
-    i8259_init_chip(TYPE_KVM_I8259, bus, true);
-    i8259_init_chip(TYPE_KVM_I8259, bus, false);
+    qemu_irq *irq_set;
+    DeviceState *dev;
+    int i;
+
+    irq_set = g_new0(qemu_irq, ISA_NUM_IRQS);
+
+    dev = qdev_new(TYPE_KVM_I8259_PIC);
+    object_property_set_link(OBJECT(dev), "bus", OBJECT(bus), &error_fatal);
+    qdev_realize_and_unref(dev, NULL, &error_fatal);
 
-    return qemu_allocate_irqs(kvm_pic_set_irq, NULL, ISA_NUM_IRQS);
+    for (i = 0 ; i < ISA_NUM_IRQS; i++) {
+        irq_set[i] = qdev_get_gpio_in(dev, i);
+    }
+
+    return irq_set;
 }
 
 static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
@@ -137,12 +162,72 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
     k->post_load  = kvm_i8259_put;
 }
 
+
+static void kvm_i8259_pic_init(Object *obj)
+{
+    KVMI8259PICState *s = KVM_I8259_PIC(obj);
+
+    object_initialize_child(obj, "primary", &s->i8259[0], TYPE_KVM_I8259);
+    object_initialize_child(obj, "secondary", &s->i8259[1], TYPE_KVM_I8259);
+
+    qdev_init_gpio_in(DEVICE(obj), kvm_pic_set_irq, ISA_NUM_IRQS);
+}
+
+static void kvm_i8259_pic_realize(DeviceState *dev, Error **errp)
+{
+    KVMI8259PICState *s = KVM_I8259_PIC(dev);
+    DeviceState *pri_dev, *sec_dev;
+
+    /* Primary */
+    pri_dev = DEVICE(&s->i8259[0]);
+    qdev_prop_set_uint32(pri_dev, "iobase", 0x20);
+    qdev_prop_set_uint32(pri_dev, "elcr_addr", 0x4d0);
+    qdev_prop_set_uint8(pri_dev, "elcr_mask", 0xf8);
+    qdev_prop_set_bit(pri_dev, "master", 1);
+    if (!isa_realize_and_unref(ISA_DEVICE(pri_dev), s->isabus, errp)) {
+        return;
+    }
+
+    /* Secondary */
+    sec_dev = DEVICE(&s->i8259[1]);
+    qdev_prop_set_uint32(sec_dev, "iobase", 0xa0);
+    qdev_prop_set_uint32(sec_dev, "elcr_addr", 0x4d1);
+    qdev_prop_set_uint8(sec_dev, "elcr_mask", 0xde);
+    if (!isa_realize_and_unref(ISA_DEVICE(sec_dev), s->isabus, errp)) {
+        return;
+    }
+}
+
+static const Property kvm_i8259_pic_properties[] = {
+    DEFINE_PROP_LINK("bus", KVMI8259PICState, isabus, TYPE_ISA_BUS,
+                     ISABus *),
+};
+
+static void kvm_i8259_pic_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = kvm_i8259_pic_realize;
+    device_class_set_props(dc, kvm_i8259_pic_properties);
+    /*
+     * Reason: must be wired to the ISA bus via the "bus" property
+     */
+    dc->user_creatable = false;
+}
+
 static const TypeInfo kvm_i8259_type_infos[] = {
     {
         .name = TYPE_KVM_I8259,
         .parent = TYPE_I8259_COMMON,
         .class_init = kvm_i8259_class_init,
     },
+    {
+        .name = TYPE_KVM_I8259_PIC,
+        .parent = TYPE_DEVICE,
+        .class_init = kvm_i8259_pic_class_init,
+        .instance_init = kvm_i8259_pic_init,
+        .instance_size = sizeof(KVMI8259PICState),
+    },
 };
 
 DEFINE_TYPES(kvm_i8259_type_infos)
-- 
2.43.0


