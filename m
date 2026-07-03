Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7017C44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfeMr-0002OR-Pn; Fri, 03 Jul 2026 09:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeMn-0002MC-Fx; Fri, 03 Jul 2026 09:55:41 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeMl-0006TP-8Z; Fri, 03 Jul 2026 09:55:41 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6636r4uX2079548; Fri, 3 Jul 2026 06:55:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=AyeHBVpvuW+1BOCrERJ6Gx5gVhVNlNdx7tAuYX4tm
 ZA=; b=v4G8+r38wURxxtnSCATYQscIEHkhMhxfnMOgFBtR32GfWAo46o1c0qDD6
 Wm+Q3Odd3MrK9fgJbBUu0YNjd85swgsw7PefiD5fYUNVj6Qn4eFQK3jEwRooKPol
 XYnXFMS9DT8+4io1VD2ZF8M9yRYvhGWCWJWK0EhVjyRXcrOd1JuNhcISEN8FRJsz
 EOGbQzj0r7OJSJFzrgYikGBRc6ea8UAqQvkScfKNHW6yQR3l6+0GzvJSyONRwNsy
 poGcGU7jiA9Zk3TWOrdfgA3BfwqCWp1Tv3mZM7b0soOmsBY0AtFGu2h2U1mas1Hj
 N6JDk1Ynkyh8QyAfYCf7OJWxjQOqA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020100.outbound.protection.outlook.com
 [40.93.198.100])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4f6871rtad-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 06:55:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8ZNkMw6ZmjJxc20AhWOzkJIyjxX2RwPtBYqUnF8e52898QWIWlbMiNvIKdOuEAZIxtm8cddYINlJJeAjfY9j1siqHFVe0ApICvOpxrr1R++AWveEu9IHuVlRQRDnO+L98mHfBPGW0HxsyKUl7hXP7lYIDc+8ucRMwOQLuNog7U9cY1Ok0XdicHnAsf1DrGMBXeFcH4gkdYkhhySw8hDuNldrJid2PI/531sap4Ci8bpGE7hjhXuzf98N24MF/Indvadd5GMliJfug8x4cbKYW8Mm+ARZ2jsw+of38d95jzfiaEFPKhg9o/5eoAz7Ns7Sm1oVEWdUjDrv3J5eMwTVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyeHBVpvuW+1BOCrERJ6Gx5gVhVNlNdx7tAuYX4tmZA=;
 b=nVor9WFDzsEZ0yuPs0rEZJ0uVxYYJnCVsdsujBzIoVjM2/fp5av2peuvN/dHbpgx1k+NH4QIwJSc3IsJlHPSor4AIQp0Rcl0JIRrxSVtCY95/c1G8CEcHR5Ct0ElfMqNaBI8FnWVj1nwzwDO07seuP9Pl0NcJaLWj+IyVPSaDgBRZfpPsy9DOLfS8liIJn2b0Z0YiZTGBvSzCYmjX1nhCNG9nGaM0IPvuzMSCJtYlYAvTF+WRsSWpymceeSthjTc5dXm1UW6wRv05Ued+XKMz0OJvFLGEwLx4vpf1T9894hbJlz5W3ksywrSFuc8jc0ko5hGH73DL+sKH9FfTVSu5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyeHBVpvuW+1BOCrERJ6Gx5gVhVNlNdx7tAuYX4tmZA=;
 b=Jq+CWSiDbZoh7WddDcvXzi015DDCWsBP5AkXFUWRE6ACf79tPwJtoRUMuobxHWoB+zqxAF0qJYlFfFN+u5k7DnIdf4iA9fDkgDaoTFbt87/jIW28JiLkqTsS8wQpwSGY3DQp//bv8R7SXo2lYiZfskFybVQCHzk0hykx1QaT6DzLLts/WTI+MqPD5IJsE+/hmPSbGRf9EiT2Rrw2MXHdFJxoPabDKZ51wY7iuT+wN+vBDVDXNIeRKp1VD3HEaPpl3Ev0T8QbShnIP5daRYxJXV9ohueHhkZXlq8meH92gTmtGZYhY25i3miHGZ6RKZGBujqac8//li+bSPLKsX/a7A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSWPR02MB11394.namprd02.prod.outlook.com (2603:10b6:8:353::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 13:55:19 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 13:55:19 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v2 01/12] qom/object.c: rename
 object_class_property_uint*_ptr() to object_class_static_property_uint*_ptr()
Date: Fri,  3 Jul 2026 14:53:03 +0100
Message-ID: <20260703135512.3213964-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
References: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P189CA0052.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::27) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSWPR02MB11394:EE_
X-MS-Office365-Filtering-Correlation-Id: d32ccbfd-cabf-4d46-f9e5-08ded90ab80e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: plcg5bcMxACa9SVITPbSI4wXrr39jMEiX4Rbj0fWLZDGjbo3WVIxaWpHf3tLimoqegCz4iHBwO6iQR4kRfTmf9zJr1NEENzUahVoaMk9KguWnkOGAwUFduD5H+xj+nP5K+uCDrBRV68d9lYtxbVy2PwQAQmMUvsyIfetcCUSIr1b2BeJRVvMu3hV+qpqLSjrw3Bw/c3yM+K2nckgUyocTO1ALwdoOpe1GZP29lXB5EedVPgognmdtFpjBKxy/Oq91lZJ7ZiVWFbp5PiQbhJk1lrNypEPbLkABveWxRARQxhjCwNUzAD/gHrTybija2UcK5Erja7xEDpwXA922k31F+PUy1x64ENTARMFNk5O79PnweceCFA1D8JFK6/nX3kijBcNNZio/gCdMZ+saACx08Zcr2rWRWRwwkx1M3TVZgujtTDFEcijqtTBriXPRQGL81o8pygJC0pL5UuIV3pov3C+oQUI8qg9rF+ceP7ONx37JsFom9IU+z3g7oTFnCa+/IUkqW83Tzjpg+7SyWJBgXdfmq/7W8yTLCePY3SUT2FCgg8U/yngMmXcYGhj1XTOAhXExBEpYT3hSB/DmGUvhmB4QUf31fKr2DQRIOq6ytRTdeAuUYYKKGn/DhKMPiie4jACz2cj5898PBYm0cueUSOMSJl0qGD/boB+1MMomLPSYzDlXkqqd2gzDvDrWz2hOTbmtNy4fCZ1ZkDFSSVHXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zYAJT+LfNIE8b+vQygjHA3I08KqFuQ1P87OhoW8pVYarytR2HFT9Bls1KES6?=
 =?us-ascii?Q?ualAYpYhChSNQov1N0YvStmeqt6YOYOj/oL7Dq3gA1Ik+fQ8XQFI3PWA6nw8?=
 =?us-ascii?Q?mZATpyQKurF4l9iuggFcXLvbjo0ZPI/A2O/+9k6AwWM+Y7hGhc6EHheBIta1?=
 =?us-ascii?Q?rf4lUNGoK96p/gKlcTYkHzZpgDXIF61XhAlvbTWspnmRoIAh4HAHeIlKQ5qR?=
 =?us-ascii?Q?5//qQjGESoTR6fg3hk1r2GZ3us3rcLUFhITW0s5mRl6AwLLU8JNLo4A9mKZv?=
 =?us-ascii?Q?Rd86iD25ZrPgkAXA+HyQQymnet/ouIKLMRhGklkstQgblxDrZTm/nK0g+ICF?=
 =?us-ascii?Q?txwr9k+DlexaNchPOLixCR/D4AiNXvU6pvg9EVmgy64r7miv57wngYpiUdy+?=
 =?us-ascii?Q?AwuHjXU8iUaxJ5mkFxhryymxWkOiP0nzwjpdJagSdFTcgRqLH6V8MelqOF8L?=
 =?us-ascii?Q?pdBR6KPN6yopS81ZzZ4ZGZCv1IAU5vNBDauYKHfHzatnittI9YELTeUKTETi?=
 =?us-ascii?Q?P6ogo4FHrkfxHjBUCa/V+Gztaxhg6YGOik9UEtxbtIb8jy1bR7QU8KXB3Ojv?=
 =?us-ascii?Q?hvdHZjV9RDBQSqZVJYU5Enp4+MP/QTw+oqWy7LCfpb8RSarAeIR6W5H/xsJU?=
 =?us-ascii?Q?/p0nBi4+MDec5RsP/wklO6V/elOGDc8BpOidcWP70+4YrlS/kPPS5BJKFzEC?=
 =?us-ascii?Q?HMYTMxMUsrcmOCMpAIi9FCfRdfv9c2/2IPSTsvlWJclLap2V2+BU17yv/z7S?=
 =?us-ascii?Q?UHSv+Me2VMuy1ZqGeycs6zrRV/0VzCPG2pejzTqgXOpW4EelO/vrtHyJ5lLT?=
 =?us-ascii?Q?SJD/0IBK+R72rwE9nqrvkpi8M98Y68mUS0FHP9tP+Cs4MbI1daSpsAgf72BN?=
 =?us-ascii?Q?5v/BXOQikgf8ZL/dcK/x+Fy0JemSICMwvWl0O4O1OVL2W7DUxJVZBK/Ljglz?=
 =?us-ascii?Q?SghnCCmhXGxSmtiVwB7Bsg+ypTVe1YeYv+RHTc8IikLS99Uflzd6FKGXZL3m?=
 =?us-ascii?Q?0W7lfshGKZxa9T+CFhVWTzxF/1ahIenCdq1Ui2CLDaPWRXdIHR59lagNgeTY?=
 =?us-ascii?Q?BHaA63vK4Akabbo4H6A6ujFKMtki/ePEa/cvXfOjoFj85LkmKyhz5EmREazO?=
 =?us-ascii?Q?9WLq7W1WDU+b5OnGXvDnrw0zmJJ3PGGXXyx0g9xWF23NPCmhixU2pfgYMEVR?=
 =?us-ascii?Q?DZniJPX6W5bDNYrR6aH3enE9+vRjby0Y/qCJovqbpnABSucZJefhBdfAOa/0?=
 =?us-ascii?Q?WDw1wn6zECS79gpL+Udt9bnPeKTLefhjN/HN+gbDFvgvia43qSEI0TFvjrFQ?=
 =?us-ascii?Q?3qpt5fSp5ZhqI4YT4uPmplf3rTwZ7H/PalNVfAb4F5bWqQ7xVJgpVbh16xhK?=
 =?us-ascii?Q?J4CmO/f1OVRU8sFc7c7i8b3ZNa5ghRhtBAmTLdqhSNVMY8F0d8F+ICRHhrXS?=
 =?us-ascii?Q?ETESrWjsinXOX5XTgHqCknFfYMyv1bzwQ2rwTh4Tr7mhODbAbFPqcc7CJwkP?=
 =?us-ascii?Q?lLvERK1oALEG/1i70McnC3kh/FZ21kJcO9PA2WhTeiO61l9lUDoMheHXmnv4?=
 =?us-ascii?Q?rzkZfrLbMsqs+IX8upzIoNT/8m/hV65Ikdx2n7L2/MuGaWY1kDcOG7DUpaJ3?=
 =?us-ascii?Q?3RpTUUG8SiYieRWBep8IF4HWZfJiJ92ZN3e+YlB1dIdeHS0ju/9HocAM5Jrh?=
 =?us-ascii?Q?kWPlxKQ4zk84lRmEhCEv0uoovQjE6f4SmzJZZHo1VTem/nA0y+KBFGaQOx/7?=
 =?us-ascii?Q?HznFnPKQNhPoOejEzW1/UI8KV4OVzS0=3D?=
X-Exchange-RoutingPolicyChecked: SDyvunjaOWeZF8y/m8q50vDYjIXtc6tHpJVyyUdkMtS57o+S5n2s/qqKH6yjfFu9w2geXBBpYLmgMaIzge/PSGuOmNTPbM/A0I7LCyzGxqOwETAXds0EwY/IIoSJgum37Rw9FdNipnFAJjeHzGkoOQzYPTy9QIyGym/gHkBpyCipC7NgGAcRvH33T5SpYhOLmlf9eO73XrfeC5P9bpiD3Litb9Rb9VGbR6Z36Tjg/WnHmZg8wEnHyy1rjuwrHvEnnAw+zOxuV4thZQ0Hxgu9GeRFbRDO1RlpFa6/LNUVnTLc3WAO6u7k4YNyoE2ZKEUl1pWZH/SGigL6iYVCPZ6vLg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d32ccbfd-cabf-4d46-f9e5-08ded90ab80e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 13:55:19.6051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGPTMrGemQR8vU5CGwV5I3xv6mNtkhrtPOxXmU8HHjpvGOgTlYO6+f/Q5G9QNmVGOS08ygoEZ4R6SvIKrOlfhRAVxweB47rGOOeeHW9QCrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR02MB11394
X-Proofpoint-ORIG-GUID: ZgOp_17GNJ3kmoYRrBuf6dGstYU4KA2U
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfXxJ3GT49bYUrk
 Fi6CHr9arYXewSCw2ar/oV7nP71Cq+CRrI8gX5gkG9lcK7yX/xjvfOlashZ2rfLB5DIxg/u4WUb
 MHExlRz9qq62nloqVMiL4rr3RHo5KXk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfXwxOzVLdnF7Og
 trjxYms2yaQ9FV6S36YeelmSWrZFNa9UyL0L8kmFC1bZ7SUtaBKiFnMyx5Zq9VN79e4a9MHTGhx
 qSFpy/ZMsvsyTwsQ9VeZjGKEKfA2NfKkJduqtgRCDa006Wu/Pwpyn1W0Wf+NaQR1g3vyYfF0lBr
 m4UWOx3CjOBpEtxllmQWhyUJNO+RDtWJCWspfG0xsKx7wpANNjIGbBC5CHLDEy5egfB2cXjCIMY
 2FUL2IbyAMto7dwvQEQcu5SOId4fRGLWUck1s+UsphB5aBuJu3ezNrl6hAfy//PzeoTGcFHWEKG
 TjnJqzj1PQqA+y3r6UB4HCwycolZuNUXhkbyK+lfjOOssS+0QxeupGpSkAwmBUSqnivhENbWjWU
 XN6z0PzuY1uv+cMZv36CdtiULy1buC1B2m5Jhfilv+CTZkYBePH5C39nEC+3DrEyFE42s8x0b70
 dkDDcd5EY3EAZ2Xuy2w==
X-Authority-Analysis: v=2.4 cv=S5/pBosP c=1 sm=1 tr=0 ts=6a47bf49 cx=c_pps
 a=rsLXg5VPEOJQy+C7BNxFIQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=KV8Zdje3dD06IRhvuyoA:9
X-Proofpoint-GUID: ZgOp_17GNJ3kmoYRrBuf6dGstYU4KA2U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
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

This more accurately reflects that these properties are held within the class and
not the object.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qom/object.h |  8 ++++----
 hw/riscv/spike.c     |  5 +++--
 qom/object.c         | 28 ++++++++++++++++------------
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 11f55613fc..89c23d45ab 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1956,7 +1956,7 @@ ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
                                               const uint8_t *v,
                                               ObjectPropertyFlags flags);
 
-ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
+ObjectProperty *object_class_static_property_add_uint8_ptr(ObjectClass *klass,
                                          const char *name,
                                          const uint8_t *v,
                                          ObjectPropertyFlags flags);
@@ -1977,7 +1977,7 @@ ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
                                     const uint16_t *v,
                                     ObjectPropertyFlags flags);
 
-ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
+ObjectProperty *object_class_static_property_add_uint16_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint16_t *v,
                                           ObjectPropertyFlags flags);
@@ -1998,7 +1998,7 @@ ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
                                     const uint32_t *v,
                                     ObjectPropertyFlags flags);
 
-ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
+ObjectProperty *object_class_static_property_add_uint32_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint32_t *v,
                                           ObjectPropertyFlags flags);
@@ -2019,7 +2019,7 @@ ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *name,
                                     const uint64_t *v,
                                     ObjectPropertyFlags flags);
 
-ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
+ObjectProperty *object_class_static_property_add_uint64_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint64_t *v,
                                           ObjectPropertyFlags flags);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 9fde0faf39..630b65f569 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -278,8 +278,9 @@ static void spike_machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_str(oc, "signature", NULL, spike_set_signature);
     object_class_property_set_description(oc, "signature",
                                           "File to write ACT test signature");
-    object_class_property_add_uint8_ptr(oc, "signature-granularity",
-                                        &line_size, OBJ_PROP_FLAG_WRITE);
+    object_class_static_property_add_uint8_ptr(oc, "signature-granularity",
+                                               &line_size,
+                                               OBJ_PROP_FLAG_WRITE);
     object_class_property_set_description(oc, "signature-granularity",
                                           "Size of each line in ACT signature "
                                           "file");
diff --git a/qom/object.c b/qom/object.c
index f79b2cf361..d10bf848c0 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2762,9 +2762,10 @@ object_property_add_uint8_ptr(Object *obj, const char *name,
 }
 
 ObjectProperty *
-object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
-                                    const uint8_t *v,
-                                    ObjectPropertyFlags flags)
+object_class_static_property_add_uint8_ptr(ObjectClass *klass,
+                                           const char *name,
+                                           const uint8_t *v,
+                                           ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
@@ -2802,9 +2803,10 @@ object_property_add_uint16_ptr(Object *obj, const char *name,
 }
 
 ObjectProperty *
-object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
-                                     const uint16_t *v,
-                                     ObjectPropertyFlags flags)
+object_class_static_property_add_uint16_ptr(ObjectClass *klass,
+                                            const char *name,
+                                            const uint16_t *v,
+                                            ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
@@ -2842,9 +2844,10 @@ object_property_add_uint32_ptr(Object *obj, const char *name,
 }
 
 ObjectProperty *
-object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
-                                     const uint32_t *v,
-                                     ObjectPropertyFlags flags)
+object_class_static_property_add_uint32_ptr(ObjectClass *klass,
+                                            const char *name,
+                                            const uint32_t *v,
+                                            ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
@@ -2882,9 +2885,10 @@ object_property_add_uint64_ptr(Object *obj, const char *name,
 }
 
 ObjectProperty *
-object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
-                                     const uint64_t *v,
-                                     ObjectPropertyFlags flags)
+object_class_static_property_add_uint64_ptr(ObjectClass *klass,
+                                            const char *name,
+                                            const uint64_t *v,
+                                            ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter = NULL;
     ObjectPropertyAccessor *setter = NULL;
-- 
2.43.0


