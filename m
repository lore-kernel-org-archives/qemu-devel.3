Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A2BC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n8X-0000Nn-NF; Wed, 16 Sep 2026 06:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8O-0008RA-MM
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:02 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8M-0002lq-03
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:00 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G8NpPu539450; Wed, 16 Sep 2026 03:44:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=prUedyp4AYuc7mLB5VI6y/YZt603NMIJq8WEZ9TCJ
 CA=; b=FIBYkMQKRY8M7UhxUNQSJvQ4jvq22gaAwa7lYbJLyKlXEdCRcZthh6oSx
 PA7ZtsmyiktmbYj8FIBvGWROVhwqYwRDC1scewmC0y/CrT1+wy5Q/MreJgkdMDnF
 jXyPdTAAkVvJDmkY8/qD+WoqCUmH5RkY0Pr01HVrkN85Ot8GBqoCSA583PVrVcFo
 s4ZMkosZ/hU8yLZM2HZ3LpSncEu/EfAQj0DpRmFjkUaZTJaOR1Qfn5ooHJrE/RaY
 H/GzClR1ii35zJl17RNkbeFrssSakKSQtgXX9nWVQ04ftv4wXgkK2ToCT45Kso5M
 O8L2nW3YtblrFc+G0h8ucSKTdqxow==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020142.outbound.protection.outlook.com [52.101.46.142])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gqa0pt9xh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 03:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flhFFEppQEBRdsHvOmRubo5NntVuDipcwFr6iadkFrI41ndIBqwa2gILt/QNrRCgMMuWJFMvzS1Kh4hzHEaIso/g/7MAtHyGAyuKgcPMm8/dJ3S/OcM23xbVUl3KnNTA6LYQrhRZfw0tmgrZKTWYRDCpz43D3PR2wWKfJ0BJ66XEgre4fgMZyzXv1VUFWPnV0tP+/N7MqJLH5YYWtpo6tbvvLbYAl3a9+wBgLSwSbBXXKKblS0utOdybx25ismav1iDJoc5gsySLfDVJwRTvae3BS4o3APpf8r6M7wGNRN15bMqsbwCwDjWGH51ZBHGZQDBwMT+KMhfNft38EfCl2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prUedyp4AYuc7mLB5VI6y/YZt603NMIJq8WEZ9TCJCA=;
 b=Ib3WNAbScNxPoRiv9cjY774vkDzGAeltmam54wTaJBvQ1QYCYbES51CKHWc/4HU93u+cZiy55yR8UwhSE0NylBJmtTCYN3h8cV+CVzxmbIqCFd6A3hYlG3RflBHEj9G17JWYXY5x7pqke8PxxgGVncBPUiqKghceeYg/Lx/bBmOiWoqF6iep3leWJjumPk2NznL0ZZ3DVYk3gM7APxp5UzvGzgneUXP4erutTTNQmR6ZaVQdjz7C/qSebDM359gubHNHYWqyBvE7uB5iK9yVGkMKZasXVPUHe5w1aXA7pfVFnl6fyWPzuYMYjY06pTV3eNJ9r1tVX8LgON5IEVvfPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prUedyp4AYuc7mLB5VI6y/YZt603NMIJq8WEZ9TCJCA=;
 b=Xfvxz5kMUI7cPZkRE5O/VeNgwqUKCgSW1AM8pfAfMFvjeL2TjgKzYxdBtqkX/hrypzJP1pGrjnL2xf0OjE4liIqxMlJQ6vXGYZXShYuUAAsMkozPIkOtWFkE1NzbSPeo8tLIucOKp+cOusy9xvfeHYG6rItAtI1F1k67SIiHxtwevoArEvPZqgV3HAUOHdP1QzVp3kw5kZT2faFYR7pdVk8DWUb5tbvpQNJ3OwjzIpratTgj0lKkjn8oB9cnCR1gEbpfWRpCBAnwfAU7nSComssNUZHO+bE7x4EmdTxN/7v1tL1QIGfCHx5MJTC8/DFCsi9yWj7oS4ZJGtBs0/jceg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MW4PR02MB7380.namprd02.prod.outlook.com (2603:10b6:303:74::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 10:44:41 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:44:41 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH 01/22] i8259_internal.h: rename PIC_COMMON to I8259_COMMON
Date: Wed, 16 Sep 2026 11:43:29 +0100
Message-ID: <20260916104435.600211-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916104435.600211-1-mark.caveayland@nutanix.com>
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MW4PR02MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: b928cdc9-c82a-4b3b-cb26-08df13df837f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 78SkZK4UYr7breG+pCgv55dS6aPSQVRgF0mjs1+rCRh7cigI75iKm1oRfZW5NsAl9pwbAPDEFK463uUdh+4rxAh7qO2rZ2R3/WOeXLkSrBh1waGcHiokxogWH8pD24R16YzkyGKqJxur28+nriKF/vVP1wRzFt2jmgKyjkPiBIpPkrPuSaiz5rdH7hFx/kcx3KdGl2jF4OkNYd6zQIhF4r2eBUErog+P3O9qstKlaSBcfjjU/KaSoOkWLTWCSmKce8SvoRyReldBIrkC9BWDItakSU+qpU4yGSI5ZX4tjJcD1nhTBSaLyYQxvEq6L0FXA8ufQ/Sh/2FM0GWMU7QP7+I9BWZTg2DLoi5HEhqhPwHEYzyOg5E3rhIAQ60Vl9oYiOm2pA0C+Tz4gmnTlbA08mlpJv0or04kDLtwE+vS+PVjf12K8gEMOHFRp3wmxhqVX/dZywIFjfRzioUMBHPXJR/9Ukd7WmFIL+5GW1yrsSRnmCpz0aDNiZm9sJcwZoqwScpFkC4JEIwKC2BHg8hJMifFLSSIXvvbT5IelOQkDGo/Nh0l3gAlbdVxGOimsVzkeLX5TuPTs8w0cY+H3VibTNdw2DEo/dsMASulNNbGAmyN5fHw5VaFsPwBuzpn1T0RZP2o5mOiafimOx+MVJXgQPWpFAbJlI5e+nVC3AQdLnA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RH+VyBB8HlGNe00NDjHfYo8XhmlIniyU6P6S9VYvU9U3PmlVC6/6jZ6k/fkS?=
 =?us-ascii?Q?WZv0/M9hC6EoxCajWQnud7cV574I/KId+B5eDa5Jq0q5c2qDQBwAB6Sznx8O?=
 =?us-ascii?Q?BOuq0Q1EubOsTgLsnGzyP/T0f/SR5eerX3obqQJMlynIj6fMPFn4S7DUU3q6?=
 =?us-ascii?Q?V5OQaNxy4sizA6Qi50TK4YDeguV6eEMrrPBe2xmOL5rOWqobMGIjGXXyY8sP?=
 =?us-ascii?Q?EDfC9A6EnSOhgCPPKcOWdbpy/de29HTTS70IvpVdmtsaUzeu0em+tPwqzOyE?=
 =?us-ascii?Q?OB/A12vLKB2/lmYuW7kLoUFgxQwH+uPOuDtamQtbnOWbmjq9FbDfgP3toPAe?=
 =?us-ascii?Q?1E0TeHFpq4DnH5neOlPPJmvDoRQwLMHkc3ukaxTQpLCt7Z+AbUloT+MRuQU0?=
 =?us-ascii?Q?BS6vP1G9BkKKpjkecBcjO7Z4RLiA6/1K62puqf6K2w4h0yMWE6RbzQe/Cypz?=
 =?us-ascii?Q?Iau6ztZFdFpNrywO1uzFVf8vOx2dHVmaQPGseQHlx9W1QnzDB/kOdDUX3xEe?=
 =?us-ascii?Q?RZU2RmmU+RppWtr0pd2n+ibK0yaLSii8h9iA8If2EUStvPVf1XvOXp42Ffof?=
 =?us-ascii?Q?x+6NG+Xqr46d3uiZZkePBwuPlpnmsD3g+1X3ywsHVPKvzytXJ4hVyc2q1UDr?=
 =?us-ascii?Q?wcBocxHSpV8BSSMdn7T9yRZm5x3f39p7FlqCNVuPEQmS7lukRYmeeYv0XFnZ?=
 =?us-ascii?Q?kAXVXA3/tytaO4bA3F03u2YhwEdJyIkiAr5cnfX+wHRoT/otJKnW0+lDIPGh?=
 =?us-ascii?Q?wcdCUbKUy6Gb2swtKlw1Vc31YublLys5NgTAi5VXHBCKr/VPuC2QyfqPc3tf?=
 =?us-ascii?Q?rsbu3RnwKj1yHTBXn4sj5SgBz78AwkcLpvue+Hu7Ku9CZTLtqAEsraByKJsS?=
 =?us-ascii?Q?hkUlMOP67ElisIYZq1nfLk5fHH3GbPDs/Phnljcj1gBL79MFW6oPOX0JgCbJ?=
 =?us-ascii?Q?6FgUZF1BSohvdXFJyKVG73r8qBneQipgeDXC6htz7PDrOAUhnH05SSGY+5E1?=
 =?us-ascii?Q?ZPtVPPRs5wH/YDhIgt7HJj3rVauNld6LQRC+iJ99Dar9FxSm1FAa84eG/YZv?=
 =?us-ascii?Q?Q/HF4uDQ1E6u414Z0Vj9qE5XP3qG//Ib9oQBgxl1RxMw+8jLExahuSKaMlI5?=
 =?us-ascii?Q?eELIIsnYeg+ngalyfFRkS3UwghKdJvfVbfjQY3BtLVP4mXHCA14AlEEl/ELA?=
 =?us-ascii?Q?UX4Pjl5teXFIiRKfUzvJp7yP8MgpVhH1VfdwqY6aaGV9Ky7iWSAlrXPLSC//?=
 =?us-ascii?Q?aMiQBrpWedMTLjw1Uf+QFdmCXRGOf8MAuc0OiWMRFwyag4wuqm5O5p57tkSV?=
 =?us-ascii?Q?gA6zrO4EhdUOyeDH+/KhD7f/uAFm+cw5qtYG38J54P6ufQ70EUlWS9y/ogcr?=
 =?us-ascii?Q?lE2lP7+YraXNkGCf7rsvhhZdfYl34dzQzrSbvfQVeXXNQ4gikWRlUhRYIicO?=
 =?us-ascii?Q?L6Lx+7eE3iPJBefXJ9g6XNuxCZscD/wne1/TzHFJDeP4EUP6gZzBCNV9ms5m?=
 =?us-ascii?Q?XHapHj7hkZ0xKsruQRywFzmXs1Q4j2zmNKvyJb36RLIeMqW8/JQPilvTf1Tu?=
 =?us-ascii?Q?ie+FFplp2k0vvRug8ZuqokstwhiUQASAVjYQuSWE8MrYLRvzE+bRKhV1e+lK?=
 =?us-ascii?Q?tFOvevm0M59z4Z41SHJgi8aoPZojR0FAghIFx6oZgvUtdPSERVj0pXPv5RGh?=
 =?us-ascii?Q?WItkY0LOUT48qbwQHzeY6Psdg+LVpuFpUdMeCxWzuatHsc60pgJPocfuVryv?=
 =?us-ascii?Q?Oavh5/25Lru2pKC8dumP4necU6OUH9E=3D?=
X-Exchange-RoutingPolicyChecked: tLU+vcdoC2UwaurktwJti4xWLmJqH+1lYmZ20NF8d13hWD64gtR0+JTcY/4GQoBVbrwA5nhMvSNqfAfzxL67Dg4Sp4mIr3dgvYHVvWeY4SzfbFiCBsbL3aMDaKMfbxPIp5y1AG0+M/SofbI19wIAKfHSDhDfLN0YFSx1RqULFmaCdU4pQkmWVDkoIRASXGxolOa8aVEGD7t91YyzZE+axjesPSA/QRrWsUSuJ7Y57uGVIMecojT+4yASGSGjmv6FDesuZAizFDG8DhofCq3NDB9tBZtCbNIGeLr659i3b4SMFXcOCdgt+DnUWiN3S+lstOmYUKKVVAuowQ+QXzM6gw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b928cdc9-c82a-4b3b-cb26-08df13df837f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:44:41.7065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZI/IjMG42zOcz+IcxJU8s/D5Qkfx9ZQutCyLilBvdMm7of6moT5t/xxVz/KnhjKdWbR+vJ2k0Cu6w+QL4SxKKkRguyLp+ljRjUn/weieRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7380
X-Proofpoint-GUID: u7lcTM77ncOdzjWAb2vWC9dhAk_goSs6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfXy0BXZ3ibuEtP
 Ai0e2uYsGgUOy3BZHRotvBrYPXqUUtrE27e3Q55/2kT7RHX5Sj6zY/vp33xiKikGCL1yJgT7C04
 /oHC4joucQhgpyBvRjPTYWR202ynoME=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfXw5C/Lkpm3pHb
 8Xrk419VfF/FFnYM03Ha4Zee0RLoLdk3BxURbQ/lCo/du0Ig0aLVGj0NPk3qW3+X4ATC4wEvnSs
 Oa9n+lS1FxSsKb7SpfYpEb//gHnAivt7aSUwa5rh0DWN+dmaibKH4v/r3xjPa5+Z9nvP+Ar/k1z
 TUji7GdYKjpSuN5GrEm/YRomDwzPSS8ZfYUQMGORfFVTkgqkGXSoP1dSWGR100nBVWLJyqroo+a
 HUdftljsy6t4Lo/EyMtmdDa9cqkc2Kyj6aa8TqzdLMAVYDwhCQ/cxxdXmHr97TLq9TOH8SbXqIW
 KKKKcFMx8/TbCPsrmCsdRCDL4Ez6776oi7eXetX+Wj5chaohDrcDHOPAFhgbP5nyukflNr0S3nb
 G8CgzTHOZhtP0aiFdfdA28EgaDz4iPvoWrdEBuZTvAUzfph+ovKydiqjd0LAAH6UomMibmwH/Cv
 CSANQ5cdqOVid9Vf4pA==
X-Proofpoint-ORIG-GUID: u7lcTM77ncOdzjWAb2vWC9dhAk_goSs6
X-Authority-Analysis: v=2.4 cv=Ps4G/AM3 c=1 sm=1 tr=0 ts=6aaa731c cx=c_pps
 a=iw/g3Nm1s12GBgadF/0+Gw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=XF9Y1ugsmyLceZbb4BIA:9
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

This is to emphasise that child types of PIC_COMMON are all instances of an
an 8259 PIC.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/isa/i8259_internal.h |  4 ++--
 hw/i386/kvm/i8259.c             |  8 ++++----
 hw/intc/i8259.c                 | 10 +++++-----
 hw/intc/i8259_common.c          | 14 +++++++-------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index f9dcc4163e..54dc9036cf 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -31,8 +31,8 @@
 #include "qom/object.h"
 
 
-#define TYPE_PIC_COMMON "pic-common"
-OBJECT_DECLARE_TYPE(PICCommonState, PICCommonClass, PIC_COMMON)
+#define TYPE_I8259_COMMON "pic-common"
+OBJECT_DECLARE_TYPE(PICCommonState, PICCommonClass, I8259_COMMON)
 
 struct PICCommonClass {
     DeviceClass parent_class;
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 66f37e1303..14029783e5 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -103,7 +103,7 @@ static void kvm_pic_put(PICCommonState *s)
 
 static void kvm_pic_reset(DeviceState *dev)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
 
     s->elcr = 0;
     pic_reset_common(s);
@@ -122,7 +122,7 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
 
 static void kvm_pic_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
     KVMPICClass *kpc = KVM_PIC_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(dev), NULL, NULL, "kvm-pic", 2);
@@ -142,7 +142,7 @@ qemu_irq *kvm_i8259_init(ISABus *bus)
 static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 {
     KVMPICClass *kpc = KVM_PIC_CLASS(klass);
-    PICCommonClass *k = PIC_COMMON_CLASS(klass);
+    PICCommonClass *k = I8259_COMMON_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_legacy_reset(dc, kvm_pic_reset);
@@ -153,7 +153,7 @@ static void kvm_i8259_class_init(ObjectClass *klass, const void *data)
 
 static const TypeInfo kvm_i8259_info = {
     .name = TYPE_KVM_I8259,
-    .parent = TYPE_PIC_COMMON,
+    .parent = TYPE_I8259_COMMON,
     .instance_size = sizeof(PICCommonState),
     .class_init = kvm_i8259_class_init,
     .class_size = sizeof(KVMPICClass),
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 8f2aa1f0fb..52e24d333e 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -218,7 +218,7 @@ static void pic_init_reset(PICCommonState *s)
 
 static void pic_reset(DeviceState *dev)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
 
     s->elcr = 0;
     s->ltim = 0;
@@ -387,7 +387,7 @@ static const MemoryRegionOps pic_elcr_ioport_ops = {
 
 static void pic_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
     PICClass *pc = PIC_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(s), &pic_base_ioport_ops, s,
@@ -418,7 +418,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
         irq_set[i] = qdev_get_gpio_in(dev, i);
     }
 
-    isa_pic = PIC_COMMON(dev);
+    isa_pic = I8259_COMMON(dev);
 
     isadev = i8259_init_chip(TYPE_I8259, bus, false);
     dev = DEVICE(isadev);
@@ -428,7 +428,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
         irq_set[i + 8] = qdev_get_gpio_in(dev, i);
     }
 
-    slave_pic = PIC_COMMON(dev);
+    slave_pic = I8259_COMMON(dev);
 
     return irq_set;
 }
@@ -445,7 +445,7 @@ static void i8259_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo i8259_info = {
     .name       = TYPE_I8259,
     .instance_size = sizeof(PICCommonState),
-    .parent     = TYPE_PIC_COMMON,
+    .parent     = TYPE_I8259_COMMON,
     .class_init = i8259_class_init,
     .class_size = sizeof(PICClass),
 };
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 8ceb5841b9..e2f997e161 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -56,7 +56,7 @@ void pic_reset_common(PICCommonState *s)
 static int pic_dispatch_pre_save(void *opaque)
 {
     PICCommonState *s = opaque;
-    PICCommonClass *info = PIC_COMMON_GET_CLASS(s);
+    PICCommonClass *info = I8259_COMMON_GET_CLASS(s);
 
     if (info->pre_save) {
         info->pre_save(s);
@@ -68,7 +68,7 @@ static int pic_dispatch_pre_save(void *opaque)
 static int pic_dispatch_post_load(void *opaque, int version_id)
 {
     PICCommonState *s = opaque;
-    PICCommonClass *info = PIC_COMMON_GET_CLASS(s);
+    PICCommonClass *info = I8259_COMMON_GET_CLASS(s);
 
     if (info->post_load) {
         info->post_load(s);
@@ -78,7 +78,7 @@ static int pic_dispatch_post_load(void *opaque, int version_id)
 
 static void pic_common_realize(DeviceState *dev, Error **errp)
 {
-    PICCommonState *s = PIC_COMMON(dev);
+    PICCommonState *s = I8259_COMMON(dev);
     ISADevice *isa = ISA_DEVICE(dev);
 
     isa_register_ioport(isa, &s->base_io, s->iobase);
@@ -118,7 +118,7 @@ void pic_stat_update_irq(int irq, int level)
 static bool pic_get_statistics(InterruptStatsProvider *obj,
                                uint64_t **irq_counts, unsigned int *nb_irqs)
 {
-    PICCommonState *s = PIC_COMMON(obj);
+    PICCommonState *s = I8259_COMMON(obj);
 
     if (s->master) {
         *irq_counts = irq_count;
@@ -133,7 +133,7 @@ static bool pic_get_statistics(InterruptStatsProvider *obj,
 
 static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
 {
-    PICCommonState *s = PIC_COMMON(obj);
+    PICCommonState *s = I8259_COMMON(obj);
 
     pic_dispatch_pre_save(s);
     g_string_append_printf(buf, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
@@ -146,7 +146,7 @@ static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
 
 static bool ltim_state_needed(void *opaque)
 {
-    PICCommonState *s = PIC_COMMON(opaque);
+    PICCommonState *s = I8259_COMMON(opaque);
 
     return !!s->ltim;
 }
@@ -220,7 +220,7 @@ static void pic_common_class_init(ObjectClass *klass, const void *data)
 }
 
 static const TypeInfo pic_common_type = {
-    .name = TYPE_PIC_COMMON,
+    .name = TYPE_I8259_COMMON,
     .parent = TYPE_ISA_DEVICE,
     .instance_size = sizeof(PICCommonState),
     .class_size = sizeof(PICCommonClass),
-- 
2.43.0


