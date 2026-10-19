Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E473ECCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm8a-0001Kk-AG; Mon, 19 Oct 2026 08:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8V-0001DQ-EW
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:40 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm8T-00049h-Hp
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:38 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8QMp03460266; Mon, 19 Oct 2026 05:06:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=uIP/FNzxgTNq6IxC5pZ5ECWrlTbe9ctn/rT0opm86
 Ng=; b=LspzrnUpjMMURQNmDOfRrZ5GbNFT4r5l3yk796eWl7E1KYn8I5xVcFOSz
 GfMPSzYDxolEi+P2+LdLn9beg9MeQrQx5FB4MVTsNRK87fJQWYpJWyiuxlWN05/Y
 kxlHLiTfKsWxoO4ynkuDNOzNl4dHqJuWDYQGL8tw0WGoumUBzMpC/IRXiDcVs3sq
 WW/P5OU9henMh6aaX6WQbhMQU29WwkcEjmHDigVzsXRxkC06GfWU1nTLtjm2Z27d
 evyntFg5kjw8efQRKgzSTaHd6dTRvyogvQjEOQclGYD8YjpqfHIgf6qnViCGQ5tN
 Eb0Flk6IsT8DpmxokW677YfftjVpw==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021116.outbound.protection.outlook.com [52.101.52.116])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4hc8jwkfvj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tl1Cbbeh14uyKMREhbaZrlHjD1ZeRtKG38T/D63+6y5jI+eGDxrYsnQOGKu6CtYnWREPU48y2k3PYto5btxUx2CjU5Gkn7A7LMfIjUX38zZTK0r/YywUl1e4Q0dW7Cl9aPYd7clIyRnuHNxLP31SU8FDv0QY0kWJIyqm+cFBV5d6jLSQq4sUPnm5XEos+5NC80u3WZ6j/biEx8Yo50jFuFPXpR0ZphQGgLZduZUbtt7QepNcGvLR5SLX1s9H2HWEqKLJpWizBJ+bvIjoa+3ppsvydqr49Bp3f82korSfax1HJAPQ25qq+YaAtRwJvQQjf+4rQfyT3Xb9yohSWZwvzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIP/FNzxgTNq6IxC5pZ5ECWrlTbe9ctn/rT0opm86Ng=;
 b=WXqxq7Pa/TnQugITwhFcSlYnzr10SaT2pLhTtJel3bjRV7zX4M17czWIJqcJ7rjdpjv8NpSbxmC3KnYGgFhWfIhMiQBFSzH4/GF6UL/ENTnbB2vVZjrtX5OxtJaUXOd2/7FkVEBGBQmSxn/hmJVofDmK+VooCDL0iKHX02+XkK7sop8P6PhAUH2zXepWv3r0Av6qryZePEX56vGeeXZ+IzWopH7T1f5KaGMqk49GALQ8tKgN6h5oc2KmU6cRatgiSUTVoyeZkV8I76nxl0cRcWMBBBotwPUUTHxg7Ou6oxX1iYpJPcTSbLrMscDhvgB9+azjJbdwcGC+Y8/J6qrlyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIP/FNzxgTNq6IxC5pZ5ECWrlTbe9ctn/rT0opm86Ng=;
 b=A6anItIMk5HDevlYxhvuiZ3TXb0RZbA/QdB7cq+gRGlxymUElbJGD9R8mG282+gT3C5CdnL1GDemK6oVVSKQfR/iMgGOhTsb5Q3PYKEs9Pn0m/A1sPU+ZgW3MXF7I0mUKZApc9yyq+ZjwB7FlcgMB2b7jSXCMtFs+B9GQf69r595a+Tph+Kj3UKUgH4pxshYfo8eN+NTRgOI+A+RGgpSVZFUmRWmRPhkd6eBitdz5Zt3tL1HZR22OaohmAVxi5lfFN2NXzyxq3nxycul85n97yXfOzv2F5JRqCWkidKwOjQqixujJSU3YNQBa3uYx3Ti/55M2mWOOakzR8h+iG8TDA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MWHPR02MB11820.namprd02.prod.outlook.com (2603:10b6:303:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:06:26 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:06:25 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 20/28] i8259.c: properly cascade secondary i8259 from
 primary i8259
Date: Mon, 19 Oct 2026 13:04:52 +0100
Message-ID: <20261019120517.1448687-21-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MWHPR02MB11820:EE_
X-MS-Office365-Filtering-Correlation-Id: d294ac6e-dd68-4da1-c520-08df2dd96658
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: pklBNMQbuYEuZELq9c27A/kzklyb/0vC6PWPxZjj3Z2yrJsqPbGccT+dOuHZrSrzpzpnMd8KSO3P8XkyHZI2HfR7bfMuqSxoSTOQLsNScSSS4ZSMC2TunWgvdaYkWY7taFimiI+9Cn/Vji7d6v32tAUFq4ZD1599S0Rl68J9QrrDYXuaiTp4VxmUDVgEEdh2qbTXOoaEi0Xt0PhSgakaO+sx9MVEQl+Ym7SoHL0jdgipVvGzsP3kPaOoVTrK2jLUPfLpjS/F1YPvIDOKV0WvxGOM3b/tnamgh/yumqam5UXd+a8dxCta8YMeUz71FxaOE7bHDqqR9BDJ1YNgC/1d9gKQUVdqRr2WzD3YQID/YKPafd7y//sAnUF9cK9fucl6BGEhYtGfNkFBgQSPWKNjJZ9zTbEdM+XJx73kXTFPmhON6kvIIRP8Yt8ST8w/N52buvtrtBq5UM/Qi0UBbyvQJX3BF4rYcwZBUtNp3F/fs/ssty36GV27cN6T7Sf08LfJJOpsKZGWeNxuVVQvJIxT1TsOLtzteXcVi8pz7gFCVDb84cPMc3K9UevI9jujp0wg9ITpo0BhY82ADceYRxHsxFfjmAidX5SH9w/EWnCKuA523CeR5UHKhLHsTxcvXoXpOdT3uqfEAGfR29BqamE/O1lwLUhpCF9ECMfiwg6vheE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/mUlG1BDMeUci3klfg+24kUPBOQEI+F6Gk2sgJMGoRc4xu22jEzLLthsO6i6?=
 =?us-ascii?Q?eUlHEMpFwO9BvQMu1q+gK2lu4m5KXBj+A219d/cahtfQSIhMIwWvBu+nJARo?=
 =?us-ascii?Q?aVzhKQ3zQ9LdMDN9f3TWras9Rn1w8qOmKOitFHDEjn0yUucK7wgSaQHbAB/N?=
 =?us-ascii?Q?x4Ygl6hlnSJK6V/pPnC68607BipEzCWFxaZVYX/Ks7HfcMycrVHee+j7m1VG?=
 =?us-ascii?Q?jfbT2reNC0iULkZOrxnQuXQFQ4HOmMEjLYYMdQb6wCp8MOkEjfP9BmGVEq6C?=
 =?us-ascii?Q?DO86uldeOgmtMwkuKyAZI9jciEcauc9p9h+8QS4FKMs+n/K1VcgL7BBSm3Mc?=
 =?us-ascii?Q?+91+95UbAlYQtRMyJSpH6v+qVlDsbNhmAHWd3GMMHL3zjIZXylDTKve/SwlQ?=
 =?us-ascii?Q?ZNYJX0X2kMG4mjnQv2vrhF16Scr18AnhTMQoOmHAgt0yEAuWPoR+keoXsqt1?=
 =?us-ascii?Q?eLvcBus17C/mWtmcaQks46yu+kESNp4uteKmggshsSSAMF42CFP9jMPe1s6o?=
 =?us-ascii?Q?3aBV4B/X3glQFp7R7x49UG7dFS3OacbxtoC6cJ0AWMyugSikvH3IMgxCSPlc?=
 =?us-ascii?Q?GhSKuWK0EHMIFrNYuHJ4GoND/qVlVr1j7datzM7kzRIpfc6TxOiWYNSog9SJ?=
 =?us-ascii?Q?f8nRcfx1E54PNUxrMAtG6nPWij3yQf6GalnLAZ46TX2woLyto1//vM9Q3BPh?=
 =?us-ascii?Q?OxxTHU4JT93do7mVr6i9VYSBXGeu1k6SpzALzj6X0Gs0NWpHV3ehxQGqRR80?=
 =?us-ascii?Q?mBR8rkM+BIM/FKe71fG/ElTfa5WfsndE4G83uRLQ2QUP/XERAtktMfignP6+?=
 =?us-ascii?Q?auztXffxssYJF8UjEIdzkKuubKZn9Phz4Jr/2x4HiyAh5gFIBiKBEpgZF9OB?=
 =?us-ascii?Q?aJaKSUtg75E1ljwlJGulGQrDlM3AKNkC9uZFYmIttn0BtUs2hLjcsrLNDuXI?=
 =?us-ascii?Q?SZmbxGGonm/HpY4BRbsMGDkOf2ISFCrKAouT0dub28ZfNe3GiIK6G5wN1GA2?=
 =?us-ascii?Q?0GvbB/RNgT7HcTS4ELQJx1WbzdupbBKKL24klaDxl+qkyW1VTErayrls38AD?=
 =?us-ascii?Q?1yqQJrfkGtOGxQWptuGzuImPAAbjb8VDfcMGUwvfeuUFGB6a/OtLYun7eHVj?=
 =?us-ascii?Q?ZA2mP+qlFo2gXyyDnzEg7rIHrymRmRHrmssHWSU25U9099aEJEj/ln1rPeAS?=
 =?us-ascii?Q?A9qrQ6qlwr7oJK5Ll/KpsmYhm2p1I8Gm7Rvwx2+iDhGMBB18pyVZT7dKlDTX?=
 =?us-ascii?Q?H7ykj+bfbextZAdjO5H4lcP/V6FIbrShZu44MqIctW+RtgrLpHtan3QnWO6U?=
 =?us-ascii?Q?0xeCLD5smZuOnuZUAeqo+6+Olelm19uy+a2BOWUZfXPDSCWgmxRffirZWw47?=
 =?us-ascii?Q?gxrOs2UFZfmWKTljKXTciiHxgiBm4xci+67z/w+tEV/rsajOimHJ6A9bZ51r?=
 =?us-ascii?Q?v49MMQquCi4Aq8lRMfDeJSwvVvnJEYGGuV083d38jRvAb+/MmnSZZrCHG3Er?=
 =?us-ascii?Q?XRym0vkIldjL20Ropi4Ui4bv3gmS+OEZ4l2goFpM896W5DkUZ3N7TBSqB/8P?=
 =?us-ascii?Q?51y3bE1QBqye85Tr6EH7i+np+VKIFQ7Lh/TVJ4wgCe0lOyaD78/RqGxBTlEZ?=
 =?us-ascii?Q?2gsnT6f52VqT467A54GZzXWW827HnkFn7s6Yw+qal2cPhcGw0/Ob8qMiUL6+?=
 =?us-ascii?Q?2P4I2l0WnsDvuZ2GVjcbjZAuQEg4dHj51IIRHpPTwfy8mGgBBLBj/gHjTwUP?=
 =?us-ascii?Q?pg0QtJ/fN1G5hKzZWtsjiAemnm+Byjc=3D?=
X-Exchange-RoutingPolicyChecked: 3GXP/QreMAWLBtBxQdmBjsYsiS9perNZa16ShBMgwQyGLLLtSF0r5Lv3LlcjZl8Hcb6LtVDwgmtZdgckQwXhrhDMfkzKFa3W9w4iv3z+f5eZKw1CX4oaqwhzbS/TOyDhGmhJq2/ooU4VfocFY1VPr4gDvGunXXbWU8TeP5MSvvj5V4uVJ3Mo3FafaOKZYh2oyh4pj0siz7MYWr59Z/mLIWJFK5vZ31pRO85cTlHODz2QjxpRVQ1ZwfaFGN+cQZSASo3zPkfXNjruK14JFhfnXiaT7uO3BnsTDThUVxlQmHPnUJLgyv6g1/cIB50nsCIWSMoCasWltJV6blUi8QCzag==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d294ac6e-dd68-4da1-c520-08df2dd96658
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:06:25.9657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZmfOJ+lzW6t4JBGTyj/Ko4y8bEj4u3hb2TeDmGFKQBfak+CAjbtygKnED5dZveyKiZ1GKAcE627PqaFwvrbhewMREXCW+tBKgM3YvtOR/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB11820
X-Authority-Analysis: v=2.4 cv=OecNnRTY c=1 sm=1 tr=0 ts=6ad607c4 cx=c_pps
 a=LbO2ZyHrMbRaCxC771SosA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=9VHIr0pmzsvXQOZnOXcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfXzltTkQNNJp2F
 0ry5lpk4hE8rxWb7ImfI2h/BMV95b6BzpIjHO4guqdGtmaLp0WgTYqNApFPISZg9J5KvFbMhkgh
 AV1/TW2iIe8ZuYvDRYW/fzgPIcdoHS1UqzxijsHlRVpVBT2iwYif/2RkRIQ0AQIoVg9dAh8mFLu
 /eye3IbTWNCwEXVq4u/BSO+vuEgD6o93GaZQLM4zuEEwonujleTrpw1PT/L70y+RDFG4Ei0Wpk3
 7L0R6G3z4F/xhrXQgHh7QY9+DkDy+QgfUJFZxjsGZcawCuJJROiBSlYm0YHgFFi/L36jhtb2Uq4
 GXlyUmgXzhySa8jcUsfKhhmAB5/p6F2SvaRfVwYObxodIPfkpvXjFKUrdGhIPbZubKBeAqBnDcp
 RXjcHQib9DhU+QhxqzXafMASANN5tXOu3hgS6bNK8+fecxOhD3DdbRth16W8OmVcsIQ2V4lFjjc
 QnhhmhO5dNs96h0qB2A==
X-Proofpoint-ORIG-GUID: SHKQp29evYl9ERj-kV3SakwNthvdkp5_
X-Proofpoint-GUID: SHKQp29evYl9ERj-kV3SakwNthvdkp5_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX2COTy/uK+vVe
 8yhyNh1p6k4GjQWC6i3OwrfGILO4mKEnuCEBPYPmoWsPOFYeyCFIoD84Lv1A/dsdDVAojl/VL+4
 n6y5JDDDc83ut+Mz+JHRjT+aWAj84g4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
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

Currently the cascaded output from the secondary i8259 is returned directly in
the pass_irqs[] array, instead of being connected to the relevant input of the
primary i8259.

This is a bug fix since in a cascaded configuration on real hardware it is
possible (although unlikely) that the cascaded input from the secondary i8259
can be masked on the primary i8259.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/intc/i8259.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index fe524efbce..d713795ae0 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -504,6 +504,11 @@ static void i8259_pic_realize(DeviceState *dev, Error **errp)
     }
 
     for (i = 0; i < 8; i++) {
+        /* Cascaded input is not usable */
+        if (i == 2) {
+            continue;
+        }
+
         s->pass_irqs[i] = qdev_get_gpio_in(pri_dev, i);
     }
 
@@ -519,7 +524,8 @@ static void i8259_pic_realize(DeviceState *dev, Error **errp)
     }
 
     /* Wire up secondary cascade */
-    qdev_connect_gpio_out(sec_dev, 0, s->pass_irqs[2]);
+    qdev_connect_gpio_out(sec_dev, 0,
+                          qdev_get_gpio_in(pri_dev, 2));
 
     for (i = 8; i < ISA_NUM_IRQS; i++) {
         s->pass_irqs[i] = qdev_get_gpio_in(sec_dev, i - 8);
-- 
2.43.0


