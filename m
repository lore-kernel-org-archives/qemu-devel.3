Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EE0CCF2C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHio8-00020B-Sn; Fri, 16 Oct 2026 10:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHinz-0001zE-Lj
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:21:09 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHinx-0006bA-Kr
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:21:07 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5EQK3216017; Fri, 16 Oct 2026 07:20:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=WF5AeoPHT0crPwuGB8Idx+PPfmDLai7p+PANfpaNO
 44=; b=IL57ft5+FqXvY3lASfy/b5Yf1U5Y9lKzMVm06rQFaQVeQrAmTCszmOagB
 5+F+qAXuhm+vsu3jyHh6fldauxCqc+GdJZa5jShG0rzaI0eeO60sTnTLdkCgLd42
 twDTveUdh0Uo/vivPvThlNJD2wOQxGpvcw5jFoX/9NEg+j9vmMHswKK4QSo1M968
 vE1Xu2nXxPUIH9JCgD0QTJyg6R4B5uDY6GJ5LAZ5hzYubKqcFtzMHCbWU85nMl9I
 yT9qKTtzsNll0PLLBqQjeXkFRGLnQlNS3/bwKBRTTsmMcUdOxGyxx3Cw6J5zxGlv
 qQew4dCNBauLE5unvN7SMOYt/Q1QQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020140.outbound.protection.outlook.com [52.101.85.140])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hb045k1jx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:20:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXL9dyRhNJ1+T+XDWaB9f9HfcMNGQyv7E7ahqh4vrjCTLVlqNnScEI4D3CAb3dPA5sFVW+WZL07hyPxY+5UdZJmvoMa4o6aATlMZzOr7hPsvRuBbG6wY9nIAQ2vVKR23otkxq7EXD81LgKPxP9NE3YVd0hpOkBVBjCAd6h+i5sPtXlQF/P4MDi1P9YPJXQfF9Kyu2I6snOw6UapI0XckWpmlJaRZI2KaORfWLOzRgTpg7ENf8SDdUsXrcmEv2KBTyU2OWKaRrhyfCadrF5cImV5aEJynk1nZ58w18M3qQ+EAeIzLgy415nOGa66OrkEMCImvYLqDRYrnYb3ARPMIHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WF5AeoPHT0crPwuGB8Idx+PPfmDLai7p+PANfpaNO44=;
 b=HhmrhqE0N7harBKkIghv9ieKYnnPbWB1LUIW8GFKIFglO0vXPDqpIonZ7qWgMEjU6HYMRNAKvwqxvrW32ho55ZQLYFv3IU4zbhQulhM173Kvdx4y/a9eAx91PFVNDhFoZtR8N6yQjllt0qbpfLwC7bAhil8u9mUeCUbqaXJZi3eP3oQsDkdnWF4n7xgzTf+gQDYUKvObUmOti4nR0WKxOgoLZd1FpXlxec/XA4Q1EvMR+eg50Is7TB/EQb5yKRHFh48Wlo65go+nFS6Ql1WUgSaKBvkLJsSdiroFO54ks1TKM0sfjoDC9aNQZ90Z+a93NgJPhjgPf45pSbn+mH5WuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WF5AeoPHT0crPwuGB8Idx+PPfmDLai7p+PANfpaNO44=;
 b=s8PQNfXLeRvFqPPtRUuYWa/R+2neOsbNcD6vUZ/LNgVQHg2w6dQcYQeMcXOB6O6GE+S0qOWRV+sGfc3NO1LbYHfgS4MFKR5G/3MyMWOVGE791j/X71q2ASbdXQePKA0SyXDP6Bp0s2dGWRVyJP9q0K9NFUWX1Ne0NDSQtmm1SKDe4IybsQXOdTsJbt7HVVGcmS1pbijs5Gic0SEJ09nMarJ7clG6Q6jBx557LAb7v75+Kf6nERpgYcerVf4WlEdOd2Rs0eH+cp0VHeTknz8R6dk826kv/GkNwqI6x/VDRYDLXrn23WgVSVcMIs6mfPPFziNOxfoLZI8fL8kZDbYexw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL0PR02MB6547.namprd02.prod.outlook.com (2603:10b6:208:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 14:20:56 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:20:56 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 05/27] i8259.c: rename PICClass to I8259Class
Date: Fri, 16 Oct 2026 15:19:11 +0100
Message-ID: <20261016142031.1204281-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::16) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL0PR02MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7f2c11-d811-49dd-fa38-08df2b90b1c3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|10067099003|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: zgE61EnzlnJwmGbNnQcaYqrLejX9/l7Zf1FBzmVPf5ym5NN4+yf0fSiqrKQ8wVfhe535naiKK2iOU6MXjg5LAFGVtMpCcV12uEkHc18kDOYAUdeTgRP9Wh3f8gXpq66AfoOhWZq8q8YkXv17q3YegCO6uPEGIfFvK4YVoIQ2TCAc2aZ4jeGnoxKyDCZizyZUt0DuWyQzDm5A4HRaCaGC51AzgXxnCafg/+ktU0fwe85oifQw34VXhwVwNFJl93e9uzrxH3rUKmlL/SojQQGQzGaFy0NLDPXTI3OPnBOLYWShEW1reqjwSI+kjH8HPCOK3N2bXxGm+/FnvTm5Vf9z63Cy2TtWDJj78pCAQ7amTkd5D+DDHlsPXs59hSMRf1Fg8cZOinpO35stb0wDnUC4QdX8xy34LuBiU8I6pDj+LI5Ptzf5v3HqCT8otfno9IHV3vgUT2s8C5whc+ZeUssWWP4STL1fzghP7GGes0Iu1ZtUjUepE+oSIWfsLsA3y5ORv9PAFLt96jT8wRWhMQgFXdf0kECqXomeW6INMLlf8Aqr0m/kl9CAZkqFOjeKt+ANgvJUt2ldhqRv3PJ1+JL64x1MHxJcqm8Lxv/6eSnpSp0JTYR8N5qyAfamLPv4wHC9rmTnp3rQfa5hnRmqX/AWqi5BSqOqwdi0+s4LsqZ4q5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(10067099003)(18002099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/11Iwd8NePoOUtx0QFEWndPYBQH4iHjEfL7jwCwV33TNkh3S4sNGpkKkWZd1?=
 =?us-ascii?Q?alLehAJqCDFT0gmqeQL+RXWb9v8q7Tz8MOIn+Z5y649amLLkILoX77ptML+y?=
 =?us-ascii?Q?qRCgQqspgo29kINnWMly0P/7uJ+nmQ4vr12d5fMXZilnk59E8h5Sj06cC5dF?=
 =?us-ascii?Q?MZ9vLR9LXcpmhvEw92tBanVbzWdA8QKl7u3RjVrunEWxGe5uQXq5CXn4cbxd?=
 =?us-ascii?Q?ov7KsGrwrcnoMS7t/UMyh5TK9PzmZ/EXj28lF26ymKhahR6IWLtVhr6eFB18?=
 =?us-ascii?Q?QrLAglfT8U24e9hlA6OPhVCw5hOqwZp8V+6PBkovoGa8KdXGpCEvMuH8WLme?=
 =?us-ascii?Q?e2GvRRT/Ej9RpAXNdfFLeqWEBoxslmRq+byCfomccMgmvQR7Xz/0Dz1/Bm2H?=
 =?us-ascii?Q?a8P2sL8VUZU8zQJ/C1t23uRaX1BthILksia4JVhCDCPxWEkdnuIPrTGZYkUM?=
 =?us-ascii?Q?jVgXQY92drxRENIRTeLlcsLGTWiiODkr8Nphazj/BwpY7dQZaW7CjgUekxm9?=
 =?us-ascii?Q?ySbwN+YnOhcN9jgR7Ssu583olKrqIn1rQCWeKgth0e36LprsOoY0fNFFvJxf?=
 =?us-ascii?Q?xTrRBvATqwCZWT4XNwgwJOtRe2VBjN4JyhnSKCbZZjJzv5b/pICEWJS56JvB?=
 =?us-ascii?Q?zgdGcCCnl3/xTY4vdh7c+nLUie+aeid6NffEiM0eOgvpyjhbbZb1a9+m7Q9V?=
 =?us-ascii?Q?0o6OoHPoN3Y8DsjOJHHmLEZIUcVmjMdKZXtDenuW4BgBQGVck8w4NpZZ/nfD?=
 =?us-ascii?Q?GSHQke1zc0bj8V/jcxuy4kNzkI7rwUA7pXCh/5cCxGugVf7q7oZ3j5hgydi5?=
 =?us-ascii?Q?2vGL+3QUY+ZCQxcisy+zWicJBxgMkKjUXaqVCIrqJJZK24NiF8t8YDPCPklo?=
 =?us-ascii?Q?MFUurfJkHwAOX9Pl5us60v756LYoOvgpIZNw/5BHB2ONY7Tcv5j86cgDUHR3?=
 =?us-ascii?Q?lyvqxMI4L7RYyMguF5ohCqu7EUfiz2IkzJC3V1SLPjExp965UzMhAYxQ4XkP?=
 =?us-ascii?Q?07/ohivgAu9CRvTvlRv0w1C8Zz7Yfw8ZR+5GadUuh3LCfdvFHGNq6ZlJwtdc?=
 =?us-ascii?Q?iiuj0CELKIXiQkbrIpwqEKcz8cxFTxOum5mimqMqcPUJLkdKWHf/+rcdU4jJ?=
 =?us-ascii?Q?zWm1+1nE4/VbP5zG19c/phZj5N3dCQ0dWzmwaUvoMrqGEDDS5zinnXReaisM?=
 =?us-ascii?Q?uqZDToh2Yd7q09xDdFdVfoGAONrTLVext0fG8YUECKd0il4W38D7XabMP2Kp?=
 =?us-ascii?Q?enCAcH8sjkg2o9uNX3JA1RHiZLlWPzxg94pvCZiZ7ySfTkSzJjF7FXZ6a6LO?=
 =?us-ascii?Q?wKjluxmcIhK6f/+bmgOdBhI3VkD6DcKGIAo3PhdnEbZug3FbHeU/m9BH5W2B?=
 =?us-ascii?Q?gnhjI47ZXUieXIaNYgWzg4jvx1sVxxtsj5adcmDSnotaGiaX/WlL8vfHZH3S?=
 =?us-ascii?Q?SiTnZcdNRwdUmPibHH4YRfhNoHNcQfDzpJ3k04qtYgIS9RzdQ0A15cGC3g3P?=
 =?us-ascii?Q?cHh93pfKFAyEs921bJTg2tQ5Jlk+tUIarBc7kEwFnFDwc9+2YdsEnQxqXn2U?=
 =?us-ascii?Q?j+sxJ623XMSlFXimJiO0azLhjKTfB1Ca8G/npgqSQ5mHgGbe4HkIG2cmjKp4?=
 =?us-ascii?Q?IshruQlkq4RS9WQ3RTjqpxPR7HiI8buwetrSqqJTY/n26NxZfocRrLwbRVJw?=
 =?us-ascii?Q?mCJDCJtZYUOQIYEolY5OdmfAkufFGgKi4w5Z/W9JsRmtAIqGk2fNEBDLQ9zi?=
 =?us-ascii?Q?qCTG8A/CnWpoNzMzy7Yjx/NQZeUgNpo=3D?=
X-Exchange-RoutingPolicyChecked: xkC7VepcR6NLCgyuIsbZYg3STBiuU4YbGSZDXNqxLrdgZcHVILD94rbTqCMHgR3yT+j/Tx/5e/nsuVviLO4gBGYeHu+atvCmUxayEcXpHIHxb/R48AS+cFg+tqm+X9qFZfp6TIAoy+ZcWE6WvwmhwMqMaSn2lQyhDPCSevZHOgnhYFpUASTX+GLK1wXG6Ls8y3LsW+kKgj7U/FN7ZRT+gRmMANsyH5ObQeb4eKR3tX9AGwGxEP+HLg1GqjlKPcbr6gPlCoWJqJ9k7J2/iVWL0GmEFCsaUNykw4hNvq56gmsk6NHoOJfeKUERI9a30qfCJor8z7t64Eaw1zRnfF53zQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7f2c11-d811-49dd-fa38-08df2b90b1c3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:20:56.8698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fqiy9Hf/UQwpDJouxNQwX6mLOohfndE/LCQXvVTLrx6AL9ntPfh8YAojms3Q0J8LZTuImQSnocX7LvdMTc9gVa8rb4kTvp1wt1+dpcqVxE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6547
X-Proofpoint-ORIG-GUID: bv-vv57VaUbVt5VsAORtPjcAszYEGDPv
X-Proofpoint-GUID: bv-vv57VaUbVt5VsAORtPjcAszYEGDPv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX6KLEHSq4fgdX
 LgM0nFwxOUvJjC+kVA4XLJQVViT147ljYYZ58SvoKiKYZN1t7R0PwlF2a19TQqVId7/wapEepPZ
 HsAeFkVEqZdLy6yg/DBNsKniYdfvKwuh+aHfr5lHkGupmVlUxcEfJWFQNBsNn9inDsrD4nBHKKl
 6A+c8/T5hdteRbb4CLjKDa/gAr816mSVS8/56o+8nWB0wFeKVP36N5vt7FhCjCNJH0vi1sM4ZXA
 IhRtDPcZ4OIqchdefZUvuH3CnAct0TlpZjoyCgxBMqiDh9syJYfcb5t7dVokMHmS0Ww6aIs5nhv
 LMFEEaYoFwIeUAgW42UV2aQBHxm9Hyke1Bv+PrZyDAAtDzQPPwz9g2x01cycCYOBJBFFrbRv1hU
 9mKt67NhfZSGl/PVF91yioTFbLwuake6ZBrFwNxFOCs/8FnrLwH9fwEeLWWH5aEtEfoeBLCXqmE
 XjJh5OjTW/PcwKYlt2w==
X-Authority-Analysis: v=2.4 cv=V/ToQuni c=1 sm=1 tr=0 ts=6ad232ca cx=c_pps
 a=qT2ADiACooojDGKohgXUBA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=VZfxMas_8fVelDOVPvQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX3IgsO0r50NJf
 cJdwP/Soo9Jh3cArSnNbNAVxNZPsJslTfYPliElJ1rzOCWb2Kfx1qzPxWoR4RjhzsYm8VJP9DXI
 LsbOlfhP6CuvPgPLdZuBX6Oa7nmD0jw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

This is in preparation for its use within a QOM type presenting a single
emulated 8259 PIC.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/intc/i8259.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 547e86c5f4..856075a754 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -35,15 +35,15 @@
 /*#define DEBUG_IRQ_LATENCY*/
 
 #define TYPE_I8259 "isa-i8259"
-typedef struct PICClass PICClass;
-DECLARE_CLASS_CHECKERS(PICClass, PIC,
+typedef struct I8259Class I8259Class;
+DECLARE_CLASS_CHECKERS(I8259Class, I8259,
                        TYPE_I8259)
 
 /**
- * PICClass:
+ * I8259Class:
  * @parent_realize: The parent's realizefn.
  */
-struct PICClass {
+struct I8259Class {
     I8259CommonClass parent_class;
 
     DeviceRealize parent_realize;
@@ -388,7 +388,7 @@ static const MemoryRegionOps pic_elcr_ioport_ops = {
 static void pic_realize(DeviceState *dev, Error **errp)
 {
     I8259CommonState *s = I8259_COMMON(dev);
-    PICClass *pc = PIC_GET_CLASS(dev);
+    I8259Class *k = I8259_GET_CLASS(dev);
 
     memory_region_init_io(&s->base_io, OBJECT(s), &pic_base_ioport_ops, s,
                           "pic", 2);
@@ -398,7 +398,7 @@ static void pic_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_out(dev, s->int_out, ARRAY_SIZE(s->int_out));
     qdev_init_gpio_in(dev, pic_set_irq, 8);
 
-    pc->parent_realize(dev, errp);
+    k->parent_realize(dev, errp);
 }
 
 qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
@@ -435,7 +435,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in)
 
 static void i8259_class_init(ObjectClass *klass, const void *data)
 {
-    PICClass *k = PIC_CLASS(klass);
+    I8259Class *k = I8259_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_parent_realize(dc, pic_realize, &k->parent_realize);
@@ -447,7 +447,7 @@ static const TypeInfo i8259_info = {
     .instance_size = sizeof(I8259CommonState),
     .parent     = TYPE_I8259_COMMON,
     .class_init = i8259_class_init,
-    .class_size = sizeof(PICClass),
+    .class_size = sizeof(I8259Class),
 };
 
 static void pic_register_types(void)
-- 
2.43.0


