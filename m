Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAE2C9EC72
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 11:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfG9d-0002xv-Sy; Mon, 12 Jan 2026 06:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1vfG9X-0002vM-2q
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 06:32:08 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1vfG9U-0002Jk-Nz
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 06:32:06 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60C9GeNd1978786; Mon, 12 Jan 2026 03:32:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=6CzeoI7NAHssxTUP30IgKtjCm9Xls+b69uBxt8n2s
 Zs=; b=dcq77kNUA6rHVFdvhxePjGfiEdYfnl1ps73FJvALLXO1/3mfOJYfVv3Dc
 tpcC3x44JWBx7NAxD+0UnTJWMQnQy2X8Plc636pace2ZIXHnT+ioe0yyaqS81SOH
 KEbFRIwL8eKT56J9HTsIwhmhfSFScMJNTRKDmFcjuUk3dQYB0W2QoIEKzWGNt9CT
 kBKXtNoQSxY3/nWCVBZyGyPpqXS1FX/ZxKBzGbYml7oyutrFfIiFwPkUoiDUjVcx
 zKrlE5MPH6pdHggYcGbe9BZ22JKRAVSaAa4jl2YkHONjzFGPP16NQgis2VR6dd0U
 rZ1PLgVijIyhcpsQW7mn7hrmJDWxQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023122.outbound.protection.outlook.com
 [40.93.201.122])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4bkkys39e0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 03:32:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlKjkZ7JNm4tEX/kdmIv2IgCPf7jZ7VgWNgyQWNPwJpjStEBtOSjTHsNg+UbuCl1TNkrydMNyEXD0SGWr8QgPIhWcFbLL6uSi2IxGtHFgWCAM4Y05Iwc02V8eJlG+Lyru984NVabfbpIP+ykhkwySiKSJXIY5BPJSFNTSXICRgGlzrT2ZPr1r3I2a/E6zrVJbI26Pbq9HgwcZ64q3yYAU8bnawnzvtup0AkbXg8a4DXCGkIc8idjkdOU1xb54Y4sSOikYWSkQb2XPVyJleIWGJWomRKsSgBjPE8blKfHuTENlJphmh6EADFjjAEHq44u2yf1LA+yjumCE2ojzj/Z9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CzeoI7NAHssxTUP30IgKtjCm9Xls+b69uBxt8n2sZs=;
 b=QZz/D2O6Sq4Pj2nKQs/C3JgSDlo2TmsN5VhPmiUs5ldJ+sUIfy2xLGLXLlgtYizHrshD2TQaR/ElYsMSA0JPtNl1/QMD6cASm91w52qWCChSxiQOC22dRQ4B+cQL60vweh8EgRRqjekpCFyxYIuYbrjQkVgf1/xvweUIxFTBvJSAyPKwPDAgxe9jOISgllOftluCb7mLuuit8DII+HfX6SJapUDQNegj/XQdZgP9cfc11fqsK6Kx7ErkaoYhMIBDnFPNncCGJtDUhAUC6oM8w/9KspDYy/3daFxtkIbhQItyc0+sCO/8DKavdtznbd++w4tJrk6jRPJcvXv2sBJ8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CzeoI7NAHssxTUP30IgKtjCm9Xls+b69uBxt8n2sZs=;
 b=fwWvEltRIo6mfVkdgtr/AK9nRcpO/9/VNvdLAqJ+PfSyaC5kb1Mok87t3WEW6zfSD1sCLxxVdAcMRFqJfoTOtpvSnqCJ+zfg/Mt4aq3sPjrcxTm+8+q7DD1uQ6Bs7g+NpsTdFF6fzARNa8pusHoejgHYa7HYwfS4yctWyPwEt72LP5baPQnUuFEhu4+swFhrOOph3WAUSv2qgD0Le1XagD+QpqvgpoOE/Krf693igSAKZnlEtqLrlytR4/RCncYfBIC0wFDPZ5PDuH38Z1Np8dy5Fr3SzZzVi+mYwtZuf+wMWpSRgFvaAqMIEZO2LAsixRb1DfJL/C73sp3moQkH6g==
Received: from PH7PR02MB9992.namprd02.prod.outlook.com (2603:10b6:510:2f5::16)
 by DM8PR02MB8071.namprd02.prod.outlook.com (2603:10b6:8:18::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Mon, 12 Jan 2026 11:32:01 +0000
Received: from PH7PR02MB9992.namprd02.prod.outlook.com
 ([fe80::e2e9:fa4e:10d7:f7c1]) by PH7PR02MB9992.namprd02.prod.outlook.com
 ([fe80::e2e9:fa4e:10d7:f7c1%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 11:32:01 +0000
From: Florian Schmidt <flosch@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, Florian Schmidt <flosch@nutanix.com>
Subject: [RFC PATCH 2/2] Add HvExtCallGetBootZeroedMemory
Date: Mon, 12 Jan 2026 11:31:38 +0000
Message-ID: <20260112113139.3762156-3-flosch@nutanix.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112113139.3762156-1-flosch@nutanix.com>
References: <20260112113139.3762156-1-flosch@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::14) To PH7PR02MB9992.namprd02.prod.outlook.com
 (2603:10b6:510:2f5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR02MB9992:EE_|DM8PR02MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: 41438703-af75-4b01-791f-08de51ce3423
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UCAqBP2wLmhGyTtB8sUStl0NELFHPvEEXXYopIU4qeBRLUjt6cC8mTuqcJoy?=
 =?us-ascii?Q?J9+rDPMAfiVOdjWqlpOlKkqyf6MbEaSUva9CJUcVeE8RyLiqYT1DVPxOV/Po?=
 =?us-ascii?Q?OVQa/PUN8w2YF5/mDCEeA8ZN/HWZMBB4XcK5nTBH66WrPQXtitaHxSLUX4lb?=
 =?us-ascii?Q?G88FHcQpi9/C6lbZP47WAzDt75OutHy9lqtGbRc23hDDWLxiCVyroeYjb8xc?=
 =?us-ascii?Q?FkRNHhEcE4RuTixwQUzNt5XshPYpwYBph4WTeHuNCRkFNcF/wW8oUh6Fm79b?=
 =?us-ascii?Q?/3wpCM7Nv3zT17mbxZMqfMRqVEXUVjquGyBj1trYeUuTCWpGOfQArAgnDHtT?=
 =?us-ascii?Q?zzxDQ6UPrdv0O+Lje+Uf0JckTP+BxqzC7LOjnJ2GtTLnovUqfmONIkdN9gGW?=
 =?us-ascii?Q?9FXh0CSJFk1lbR+FDYEqgeapdlcGKVHpGr0AbT4ZOVg9+pYAOShGp/Ak61P6?=
 =?us-ascii?Q?f1XuxVQuzuHinFPau+tzUXwN18L40oAtgJ9XlUVTluNN7X585QZirm4GLYM/?=
 =?us-ascii?Q?rrcnyXjPh1EepR5B2STwUyKvHOUIMzcDF3PFBv2+uOVpNuOhhtSrh2VhfJQ9?=
 =?us-ascii?Q?GwcSYmIWleL1Hee3iVv48ZnRJNrt4pNmMXdc9evppaXm5XeWB/O9tS18tsL1?=
 =?us-ascii?Q?4e5TE50vh3FzLbWQn26/uiGGR0UuGU4I7aaFAK9rfRGc9bne4ymFbfsBRmci?=
 =?us-ascii?Q?n+gCTTxhMNWb6UJbDblcmitiRPaIWZ8kjxkAHAvRM7wPGbbMAg6yoYBSMNpN?=
 =?us-ascii?Q?pYh8hPkpKRFh7i5M1EcjQdGwkiQf4FjeqKU8E/FIHw6hzZXdbaoYyfsloTqf?=
 =?us-ascii?Q?W0A5qN2rUKT04sZ2slzgF+fauZr7vddweeZTStBIWHWoGQykToJCYhoGz7J1?=
 =?us-ascii?Q?C1yllMaOxE4QrDxr5HMY5wFc9X6L4aqlgw8y14sKm6DfblFxHKJth9HkGB6J?=
 =?us-ascii?Q?uHSvR2y79634If2LfFWw77e4fQ1DDfzmAddmvV5HHK4+WzfHpbiCrfn8TSFc?=
 =?us-ascii?Q?IAb5vbBPyKXSXwwPtbdkEpQV0nRORaLz0umdytKHveLyixU5DZ8dYD+eWo3h?=
 =?us-ascii?Q?P3CPE/YsKBrKQd8oiOw/fVKPVbAfLW2b1DTN5r6OhmRba+e1nRwJwjMnbgE7?=
 =?us-ascii?Q?AKKpU+PEZISgvmi4Xq1Dak0NWGd3raZMfiTU9anjnsBiOBMguSjVXjpR2zqQ?=
 =?us-ascii?Q?bum1LdX2LT+EEVp1V4JrmxeyJC4b7X32cd70OGm5vop+lAdHgNL4ofNIZA+F?=
 =?us-ascii?Q?j5TnMDkf8b/LMrtbGvidu4a5MJn1rWPubJYUDVq9Om0LLMemVZBw/oJWHr3e?=
 =?us-ascii?Q?fB1mH8BiS0HK5PNrUq99nGyQYmqMJgQUEWbrcWSFXe76l2qX/8ns+8MDp4jR?=
 =?us-ascii?Q?gYchCiDkJRBycIowFUsPAB1UiVBbeQ778UknxGC8zOTbGWC9rHsFXfXT81yo?=
 =?us-ascii?Q?/iqIZh7rqNLBhcJF+QR0ZAjazYV99S+DxGK+/QcS8QTkPfiTrFmcH4ojPDH1?=
 =?us-ascii?Q?BeUNRGOedmHgJFiMlOXNoM7DKBbwKaW7j6uJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR02MB9992.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IKM9HNQxNaLnI8B1+QUUC+C+g7hwNy2PfMvbQ4DvulHGKcNMBas9FrEcat/i?=
 =?us-ascii?Q?BEfzswFXEkODY0L/N59fe+A11JeIlwLg/+wq136u1imuMc3o5vSYBN1wJU6G?=
 =?us-ascii?Q?Jhhs0e9NY0GaCfIs6uRXIKDDc/C8m1cm0K+lkR7giEX/DAoqbe/d+sZrQqjK?=
 =?us-ascii?Q?mrl1GiX7JzrdvEQtZe8g2h97ajBwW0wJ3BAwGNiiQ9iV/TTo4s59g/ZRI6GD?=
 =?us-ascii?Q?dqTKaVRHNSI3a0aBPkkmIesJxS/ti2Xz8PcUdS53uxnDV0EmSfdhSZ0C6h88?=
 =?us-ascii?Q?sP7tfE0JiO/sVUxS25mMXWyFHPAJXACwzWR5dYgChZN/Y4dFfXpb1b25cbe7?=
 =?us-ascii?Q?Sp7Hk/3l5qvU1dVvG8+YjrzeRqFBK0dsdcV0nVe+fDoAtVoZxdLLfH0+D2Y3?=
 =?us-ascii?Q?gXJvNMwnQUUQsCBIIdzTn0umeZze3uFjXsa78eO/31MYYfp8aj17IWLLPg2X?=
 =?us-ascii?Q?ZbEbRn217U+f1lHgktCrYPRVJYSO3WQ7pmtcRuU2TlrbsLI3sZFgCoWTNo3v?=
 =?us-ascii?Q?ER+vP+DS10QdihliSBCe5GmPVU18watFbdXYDXeN8l1y0XYrC2QsFnVFNB5y?=
 =?us-ascii?Q?B8twIHPgbREjLVLO3CPMmB9jOzYs3QdBAW+SE1LOPFb2GUDoPPoFCwLEYjRU?=
 =?us-ascii?Q?RD9bhQUSkd6zh/GYC6MJqt25p7fQcVJfJ/zFPuKL6eZTIyaxQrgndd6lidom?=
 =?us-ascii?Q?0thCEq9O9mpguK6PqHcgU42aLpoJv3xOx7As8YEWi7uVxlIwht5ctPGACTvR?=
 =?us-ascii?Q?s4QQ7/DNTqOafe6QDUFprJQ0Rj2RT00cqo9i2drgWJ+9s+xvkHrmbKoDlHH3?=
 =?us-ascii?Q?XZBzQcCPGTvXGqyCcPCbg4e9XykaVgYJP7Dzgda6mYwpVnOKe2GckDlibhS6?=
 =?us-ascii?Q?8/X5LVkNpozQub1G13iitrSnuIbUNnkinrsOBeyfxEfjsset5WJIAk3lML6J?=
 =?us-ascii?Q?7P4jFWlPTJR+HWzPU50mTwfBYo7G35CN/ENVrnPXAOuJjDKU9pS5cMn8MXVz?=
 =?us-ascii?Q?5CHvzbqhj7+iey6dXvSpgYeMkH/Adbc6SZOG9CZyGLvHJ4RVUMy1+AdrXdf5?=
 =?us-ascii?Q?y+Fqa+II6Aek1T7qBSy50KDfNonwl71wa5qvTTQB4x5UxFWGB2iQSyqlQUWz?=
 =?us-ascii?Q?8DlRRxZw31/ZUdzrPnvf3QwcAH7EgUE49hs3JLhXru0nxKn2SF08zsFd7R2Z?=
 =?us-ascii?Q?CQDwOCq+3z1U5LeBjg2eitBM6XxiobWmYekpViqJKMzTMe2KcdaY7noQALGO?=
 =?us-ascii?Q?T5nPPzw5iwJVr+lMTV/xj46081SNNSslB5TqP6g7xaG3UoYKKxNlzjxCmx8U?=
 =?us-ascii?Q?FkKEtkthDUJaoDMgk9PaN64SvpVSUHEBPiIZZg7ONjdce2bZgawqbATFZc8+?=
 =?us-ascii?Q?jbMEcIzkb+VpbbOvEsTwK0YQ0zL73hzmGP6s4GB3tOvBimTftmbB/sq+v3gA?=
 =?us-ascii?Q?c84PLziSER3sTIdsA6zd9BKZFGreWKSknurTI2vxAFnDiYpUxfcy11GCczSm?=
 =?us-ascii?Q?dCn6zSkWDnwyfdOTroOlcExV4V3e9ADFWbWK4jQiKnRFNZCiSyWmRkYBeQSn?=
 =?us-ascii?Q?yjzdDhiMkN/hIimrzyYM/PorYwPQB2ET6W6AIRkldv9lgbtx5A/sDimX3YJV?=
 =?us-ascii?Q?HoZnmJ51HDyZnpNNbtATgly8cAjYHcGm9o5twrV89+p65nYuT6tZE53fQQ1U?=
 =?us-ascii?Q?lo/ZcyKa6DetPLhFB+Hszl9eMyBAF22Fz9Jc8Eefuw4alQVJtJGjDE4ytnVC?=
 =?us-ascii?Q?OtOJWkRVc1aX/d+bCSd19fCAhM8u7VM=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41438703-af75-4b01-791f-08de51ce3423
X-MS-Exchange-CrossTenant-AuthSource: PH7PR02MB9992.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 11:32:01.3998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVYWWbQhotPfwrWEl3GbDJNocYVC9rFvHdcLY6HOc5/avl5rgUrtX0PejMEVCXLUF+LmTpICETHH/uvmaYWucjqGVE9pOZFl7Bip6mlHltw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8071
X-Proofpoint-ORIG-GUID: XkHZ1an0_-qnaseZE222Nc08UsNzNQFH
X-Proofpoint-GUID: XkHZ1an0_-qnaseZE222Nc08UsNzNQFH
X-Authority-Analysis: v=2.4 cv=J8unLQnS c=1 sm=1 tr=0 ts=6964dbb2 cx=c_pps
 a=FNmKuShaFFLZE4HaRSHjWw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=kxB6lYKRGD2xpD5JXEMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA5MSBTYWx0ZWRfX4HkcP4GA5LkZ
 GAFsGqWlcOgm0OCAtYoVCxslTKsU87vNnWDyhe9HzIR9Xk1DlvOsupGHz0BsiSop2TQl0Sia2Pf
 eig/vtxXfGXF8fMj1dGVNhf3LJfwhiZ4pue9uanwXuWmhrj1O2Lgtg0IUXsDZcBnxfEdPvZPv2q
 oxJ+NQcw274l5oQR1p8fS4dFOgwqw2yrS0WlisQpryBT+7HMBwTRcW+dTFL596OoIWKq3wqtRmf
 99hwwpvj41mKXdUT+RCuj0uo5v2CHh011DzwKqsZgdbbL4bXsJG2pMpYHjKWs/Y5pJd06xYSZsJ
 KiDMgs+D4pcdTitn/RPTCx07O07y1zH3VZH+4TAOp3c7jFGmqHd9AAqz6oQR5rRUVXWTRr27IHB
 mxm9HppRn6xNF992YO65v65sz+B7xgZvn3+wsANgg6q76XchT8/w8HRQ89iaTnV83yDoRcotkFd
 c4rLn61MXNRrnrALBuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=flosch@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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

This call allows a guest to ask the hypervisor which of its (guest
physical) memory ranges were already zeroed out by the hypervisor, which
means there's no need for the guest to zero them out again at boot.

For now, we simply send one entry back that says "all
64-bit-adddressable memory is zeroed out". This seems to work fine.

Note that memory devies hotplugged later will still be zeroed out.

Signed-off-by: Florian Schmidt <flosch@nutanix.com>
---
 docs/system/i386/hyperv.rst      |  5 +++++
 hw/hyperv/hyperv.c               | 34 ++++++++++++++++++++++++++++++++
 include/hw/hyperv/hyperv-proto.h | 11 +++++++++++
 include/hw/hyperv/hyperv.h       |  5 +++++
 target/i386/cpu.c                |  2 ++
 target/i386/cpu.h                |  1 +
 target/i386/kvm/hyperv-proto.h   |  5 +++++
 target/i386/kvm/hyperv.c         | 12 ++++++++++-
 8 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
index 1c1de77feb..7d2be2109e 100644
--- a/docs/system/i386/hyperv.rst
+++ b/docs/system/i386/hyperv.rst
@@ -256,6 +256,11 @@ Existing enlightenments
 
   Recommended: ``hv-evmcs`` (Intel)
 
+``hv-boot-zeroed-mem``
+  Enables the HvExtGetBootZeroedMemory hypercall. This allows a Windows guest to
+  inquire which memory has already been zeroed out by the host and thus doesn't
+  need to be zeroed out at boot again.
+
 Supplementary features
 ----------------------
 
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 13a42a68b2..d1b15c089e 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -727,6 +727,40 @@ cleanup:
     return ret;
 }
 
+uint16_t hyperv_ext_hcall_get_boot_zeroed_memory(uint64_t outgpa, bool fast)
+{
+    uint16_t ret;
+    struct hyperv_get_boot_zeroed_memory_output *zero_ranges = NULL;
+    hwaddr len;
+
+    if (fast) {
+        ret = HV_STATUS_INVALID_HYPERCALL_CODE;
+        goto cleanup;
+    }
+
+    len = sizeof(*zero_ranges);
+    zero_ranges = cpu_physical_memory_map(outgpa, &len, 1);
+    if (!zero_ranges || len < sizeof(*zero_ranges)) {
+        ret = HV_STATUS_INSUFFICIENT_MEMORY;
+        goto cleanup;
+    }
+
+    /*
+     * All memory we pass through will always be zeroed.
+     * (Check if that's actually true!)
+     */
+    zero_ranges->range_count = 1;
+    zero_ranges->ranges[0].start_pfn = 0x0;
+    zero_ranges->ranges[0].page_count = 0x10000000000000;
+    ret = HV_STATUS_SUCCESS;
+
+cleanup:
+    if (zero_ranges) {
+        cpu_physical_memory_unmap(zero_ranges, sizeof(*zero_ranges), 1, len);
+    }
+    return ret;
+}
+
 uint16_t hyperv_hcall_signal_event(uint64_t param, bool fast)
 {
     EventFlagHandler *handler;
diff --git a/include/hw/hyperv/hyperv-proto.h b/include/hw/hyperv/hyperv-proto.h
index f1d1d2eb26..5bf5684d11 100644
--- a/include/hw/hyperv/hyperv-proto.h
+++ b/include/hw/hyperv/hyperv-proto.h
@@ -36,6 +36,7 @@
 #define HV_RETRIEVE_DEBUG_DATA                0x006a
 #define HV_RESET_DEBUG_SESSION                0x006b
 #define HV_EXT_CALL_QUERY_CAPABILITIES        0x8001
+#define HV_EXT_CALL_GET_BOOT_ZEROED_MEMORY    0x8002
 #define HV_HYPERCALL_FAST                     (1u << 16)
 
 /*
@@ -192,4 +193,14 @@ struct hyperv_retrieve_debug_data_output {
     uint32_t retrieved_count;
     uint32_t remaining_count;
 } __attribute__ ((__packed__));
+
+struct hyperv_get_boot_zeroed_memory_range {
+    uint64_t start_pfn;
+    uint64_t page_count;
+} __attribute__ ((__packed__));
+
+struct hyperv_get_boot_zeroed_memory_output {
+    uint64_t range_count;
+    struct hyperv_get_boot_zeroed_memory_range ranges[255];
+} __attribute__ ((__packed__));
 #endif
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index 921e1623f7..54cd2fff72 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -101,6 +101,11 @@ uint16_t hyperv_hcall_post_dbg_data(uint64_t ingpa, uint64_t outgpa, bool fast);
  */
 uint16_t hyperv_ext_hcall_query_caps(uint64_t sup, uint64_t outgpa, bool fast);
 
+/*
+ * Process HVCALL_EXT_GET_BOOT_ZEROED_MEMORY hypercall.
+ */
+uint16_t hyperv_ext_hcall_get_boot_zeroed_memory(uint64_t outgpa, bool fast);
+
 uint32_t hyperv_syndbg_send(uint64_t ingpa, uint32_t count);
 uint32_t hyperv_syndbg_recv(uint64_t ingpa, uint32_t count);
 void hyperv_syndbg_set_pending_page(uint64_t ingpa);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 37803cd724..d4160f3334 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10492,6 +10492,8 @@ static const Property x86_cpu_properties[] = {
                       HYPERV_FEAT_TLBFLUSH_EXT, 0),
     DEFINE_PROP_BIT64("hv-tlbflush-direct", X86CPU, hyperv_features,
                       HYPERV_FEAT_TLBFLUSH_DIRECT, 0),
+    DEFINE_PROP_BIT64("hv-boot-zeroed-mem", X86CPU, hyperv_features,
+                      HYPERV_FEAT_BOOT_ZEROED_MEMORY, 0),
     DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
                             hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
 #ifdef CONFIG_SYNDBG
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2bbc977d90..a42eacd800 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1463,6 +1463,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define HYPERV_FEAT_XMM_INPUT           18
 #define HYPERV_FEAT_TLBFLUSH_EXT        19
 #define HYPERV_FEAT_TLBFLUSH_DIRECT     20
+#define HYPERV_FEAT_BOOT_ZEROED_MEMORY  21
 
 #ifndef HYPERV_SPINLOCK_NEVER_NOTIFY
 #define HYPERV_SPINLOCK_NEVER_NOTIFY             0xFFFFFFFF
diff --git a/target/i386/kvm/hyperv-proto.h b/target/i386/kvm/hyperv-proto.h
index 4eb2955ac5..ec38b717e4 100644
--- a/target/i386/kvm/hyperv-proto.h
+++ b/target/i386/kvm/hyperv-proto.h
@@ -94,6 +94,11 @@
 #define HV_NESTED_DIRECT_FLUSH              (1u << 17)
 #define HV_NESTED_MSR_BITMAP                (1u << 19)
 
+/*
+ * HV_EXT_CALL_QUERY_CAPABILITIES bits
+ */
+#define HV_EXT_CAP_GET_BOOT_ZEROED_MEMORY   (1u << 0)
+
 /*
  * Basic virtualized MSRs
  */
diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index 1ac5c26799..f92ea7e0a2 100644
--- a/target/i386/kvm/hyperv.c
+++ b/target/i386/kvm/hyperv.c
@@ -55,7 +55,9 @@ static uint64_t calc_supported_ext_hypercalls(X86CPU *cpu)
 {
     uint64_t ret = 0;
 
-    /* For now, no extended hypercalls are supported. */
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_BOOT_ZEROED_MEMORY)) {
+        ret |= HV_EXT_CAP_GET_BOOT_ZEROED_MEMORY;
+    }
 
     return ret;
 }
@@ -122,6 +124,14 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
                 hyperv_ext_hcall_query_caps(calc_supported_ext_hypercalls(cpu),
                                             out_param, fast);
             break;
+        case HV_EXT_CALL_GET_BOOT_ZEROED_MEMORY:
+            if (!hyperv_feat_enabled(cpu, HYPERV_FEAT_BOOT_ZEROED_MEMORY)) {
+                exit->u.hcall.result = HV_STATUS_INVALID_HYPERCALL_CODE;
+            } else {
+                exit->u.hcall.result =
+                    hyperv_ext_hcall_get_boot_zeroed_memory(out_param, fast);
+            }
+            break;
         default:
             exit->u.hcall.result = HV_STATUS_INVALID_HYPERCALL_CODE;
         }
-- 
2.39.5


