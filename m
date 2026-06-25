Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2023CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 11:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wci0N-0003cg-1l; Thu, 25 Jun 2026 07:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wci0K-0003bu-GT; Thu, 25 Jun 2026 07:12:20 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wci0I-00047J-Ni; Thu, 25 Jun 2026 07:12:20 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P3cdfG4113637; Thu, 25 Jun 2026 04:12:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=oRH77LieyTUBtgxolpWzlpdc2kQiagN+c5KS9sY9I
 3E=; b=NUTjkBN2ilaBoaqasBVEJVls2QsLqvavs9lyhNA3+mS+KW4IUtj3XTyJZ
 Ud1Ka2DAc5BnP+5PBd72yfKgKPY5/iAVBUjG4+qhalsV9hwjlMPbiBQ5WCS/tbTU
 4yL/pk1EM330m8YCPMijct5rwCc9/ug5UuN7LsP+4WyjTXPG7eGHeX5OOCBsuc70
 PKvZfmK1JhWWRQ9Brc4LZ6M/07/uim06+I8oiolCQLbeTtE/Ul21V7ippy0OMVft
 P1fuJ+rbghyExEI5J2yLLQU9N23tPWPe2BUDMDHYf69E31gBvHsNwRlHYxRciHp5
 vMnNbOdH4Q6D5i8qAXZPjLwZwqxlQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021100.outbound.protection.outlook.com [40.107.208.100])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4f01dkvf54-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 04:12:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2y3zEQNxT1WSDjLK1EgDEL/D/PXfBGwP+Jv4KKP3pkLRKvJOdWY5PMYSDe0D/qaFuK3/bI4L2wmUIm/1V5lrniBLIkuiGdHy9+yIxV+Mt2qS/P9tBgA5+78BFmsZTItR97gH2ik+S8wXllkylgUd/eG/MYGxo69+O6qHQ47fqKLDSHdk5grTMAsWEaKdrl0k9wdp8l4cnIOdBpcpvVadVhcWXI5wgdp4kpMcplt08ksgKVHlUG86Htk+4Ulf702qWrI/g5lvHkRPhD/wgMBMon54eq7ST/+uce/5PBR0UsyC4lHWgjC9EYcwBYNAFFtDx9Av5jZi/UnNWwHdeIFVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRH77LieyTUBtgxolpWzlpdc2kQiagN+c5KS9sY9I3E=;
 b=JALdh7HXiwOF9EzYcvXtYbYbt66ENj/wIWGN6LjhaQpDcHvhAINLfp7puxf/ZXbJfHK7Gkybmy0E0CUTZOf4UeOeTv1OoXIDJFxjEu9cEv1DrZ1awUb9U6NQYcrgPr8wXbLDCq6RZCtT1XiwrTXQhAho3Q6irXSlKcoUwXDITtHs61as3VrzjQ0rWsFPhAlWkq2ZDLgWB3W8vRkn+ZRC0KKUvzeWxUsYYI5j0wCs+xotShmo/j/iU6XEqosgt2AAkpsnG8PIlvekGAVtzxEi+oPpxkteQ3nv530qKnVWAJiDOCHvDgiCLsuQNV72keBh+11gGdYlkG9RBnqvJ+QIqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRH77LieyTUBtgxolpWzlpdc2kQiagN+c5KS9sY9I3E=;
 b=vzix6wGfHvLPtPbqCFPP4rqJw3Ax6+cOzl8mFDT6IGuyXMPOxC8R/0UU91MpF0xk+AdTYGPSGl1CNwfypghO8Bf7wpOwXsptOnjYydm8eJrwjpP1jFql7mQJV8cNBfg+4+5cy4qKGy4MWpEg2H1qLyDfhrr/5vZlhMfIDFIOEMastqD17QwrXCOEZSOey9+6PCzX2vnUA+o4n8AxbPeHYAOeRUvxZZl9svImneD5YdAx14A2YfXUBD5ufkRURIVXQrQHdvk8zL1Kdot4rZLhzlmF9LDGoitQGz+RzKBSKejElX026ukrPh97YUlspozaYlwIMf3ZAXlvcQIje0w0ew==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB7869.namprd02.prod.outlook.com (2603:10b6:408:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 11:12:08 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0159.016; Thu, 25 Jun 2026
 11:12:08 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: kfting@nuvoton.com, wuhaotsh@google.com, alistair@alistair23.me,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 1/1] hw/adc/npcm7xx_adc.c: convert NPCM7XX_ADC object props
 to class props
Date: Thu, 25 Jun 2026 12:11:17 +0100
Message-ID: <20260625111201.1645847-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625111201.1645847-1-mark.caveayland@nutanix.com>
References: <20260625111201.1645847-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR22CA0009.namprd22.prod.outlook.com
 (2603:10b6:930:16::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bf297bd-e18a-4fbd-b59f-08ded2aa98cb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: LvXxr2gLdXHX6NhKPmnf7r8NGtYY6GEAb6/6X4t/wr4ONO1YfL2enXl4+7+oMStLJi9pD81IvYz94eMjvXoBnvsaCB8zW8k2M5PpsYW//APFiAQdCYnj6aTKidnevqHAS2/8FWlLIWkClCoqYhgBZJ75frxrCPgJGzAoQ8CEkAFOnza4HaWGN4GAGOd9sJ6oiFzPaepHdWhwVQ52PkE91F+Fo3/712+1ujnwTwT4em7XVK2wMxSHNIlE+jTFtUgw+klUelNye2Tu6bHn11h5Vk3raMakU7WQu4CAKeCfU8OjXOla2hdvG69RMHYp82V9xwjiEDVoudRmWwMShPt6vBSVHEN+8OBcJvebLDynZfg1MNnMEFdtrNNGiWZM3OoUwg+bnmsU7ufAhsO9nQbCW6rVjs0aNckgTfIUldnFHUzF0/G5nXb+X3zoXBwocvJ2/aosmd+v8trWWM1TK3jcCFM6et28pONP+sMC9zoJG/1r71+tqIn28WhnqhmtMjNBl06WrqIuixoI44kW0xtPwKHwJIGuum05irBI3GgmTLaXiftw7ZKhtdMIzaOKAX45s6lp/6Nc+AqoJ1e0/71a/AaktFPrlnbzDspxXmtZyYxmb+/RJBCcj2NlNgNUGMnvujS1nly9SsQoWVdS7wPMtjW/nr/A7epde3J7gYvwLvg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ezOZFBwXl0b+eVVc9PjSyyuUb1IgsLO3xirvOzoY0hzfwx21/e1ff9ls1X1E?=
 =?us-ascii?Q?vsq8bUrZ6GLi6y8XV6dWR+ajGVDgwmbhOQrVEP9BkK0snGAlRdl2vVwOHvDa?=
 =?us-ascii?Q?K3KmaCKLaPTcdy2sCWfhyFOQlEtzbh3sYxKySsLTGtiOBOOOHnGvKik8atgU?=
 =?us-ascii?Q?Q1m31jmujGLU9DZ37UMbmTfH52Hp8zJiHxKi1NXCI8IQlobMS36YyDODfDlZ?=
 =?us-ascii?Q?zyofileQQPkohhN57xmUglzrEz6vEvdA5jxR32GiRX/9htzVCPuitnUZdO4u?=
 =?us-ascii?Q?MsaMfRJGP5WgjSlhVKdX6aS6m+lkwjm/Lmv0RSGgoOy/56w+Md21OSXlAFDA?=
 =?us-ascii?Q?LO3Ok5mknLVyR3k8l8fpH2z8a1FY0oSpyjr5auc2Rk3FGfwOx7TdwRWxwrUU?=
 =?us-ascii?Q?R27jsV4Bc5BYxLjVC7F1gh74c0awG60yN0lVAoJucyT0XFQ/naXTIwvRUSBY?=
 =?us-ascii?Q?w0bFh3SDwiBDFXVZn+XAgwxBAC1DwWTRpdwMsv2SwSx8EyijhBTp/5pwLRBU?=
 =?us-ascii?Q?ps/4pxXhC8AHPoP14LgcdWdl7M9IJ2ObX3q3sEPCFTblyWddTehLzOZ8CTW/?=
 =?us-ascii?Q?RqhHS7Lgo4JoymtD8Tna0/FGUKqg9iWlncUND2YLExR+xoQSTrwagPzROzbL?=
 =?us-ascii?Q?1+hR2FicqjadsEpLAj7Ty6q7PTjasA7+A6TTLWQDai3C+IOue+dX/vT/QKlP?=
 =?us-ascii?Q?MmIIv/Lo2YHUXV2T3Sw6psDQMaONLDq44deZwXyTRq6aThhOZZqS89/MutM4?=
 =?us-ascii?Q?AC2WJBZhNx4tyqCHB7KB0wCVFM6qUPmG8o5UJeC9IuJaTx4pfGa2BPM2Raoq?=
 =?us-ascii?Q?8Bi8YuB3BpVt1UPoSgIyELMpBVto5H01qTfWq41f1PI+QeXTUEPteDJFI0Qg?=
 =?us-ascii?Q?4OnW+YbGaFwVJaGLalp8LV6H3YH2eUvjnDatC6RPnGh9NDo3DRMrwhAGXio6?=
 =?us-ascii?Q?IdbwhfRwzpqw2D4tGyuCcur2zmcHFxuq2C8CNerHIQV+I4l2xnZ5LrEgv3SR?=
 =?us-ascii?Q?nrBzCIuFzxno4nyCjos02pZvb1LXWEVoEpKpvthy3e71qiuEDz2LPTY/+q7e?=
 =?us-ascii?Q?4nURKDNtrWh4uDvTkPNiCW9E+wlgY06+5c2B94PdNXB9wsOcRpkd03jrdGSH?=
 =?us-ascii?Q?0ds1uthjoyH4w+ME5dZZqVlTFErdFhF9v2bzMN3KehF9KALMvWnIYLim8fj2?=
 =?us-ascii?Q?V2/yxfzrd9E4t5ZItAUnG90G5+Il8BSqYGOSsuYm2ObNxDA3R/OgnllxBmSA?=
 =?us-ascii?Q?NydF24LZVjpbL13nmOk1X5LdHbS+2PBKhrd5YmVjZBz6wMuClOCZSlsV3vrp?=
 =?us-ascii?Q?e7YRCc7kREN045FxwMK5Xwz2ivIi0LJwL3xVI9khzk/FayX4gCvmJESbdtll?=
 =?us-ascii?Q?7Dm3t+tgP43+P9xOOyZxN24KGdijGSoguM53MNT5wBONiceoNyrDa9TYnJ3V?=
 =?us-ascii?Q?bv8mKw2ZepiZxgEZiAmAKvzjCV2eDr6gXShO2QGwXJRx8XskyAXI0vjtChAF?=
 =?us-ascii?Q?dZ/mEdH/3LANxXMQvlSC1PP+OhSducRGSZ+myoy+1xKiH1IuHOSsKik26Wmu?=
 =?us-ascii?Q?936dGnabTSyY1MP4bBYAFOmbzHsEnqVuwQGnFaesLnuK1RyhJFzScXF5dX90?=
 =?us-ascii?Q?NlrL0mpORcdhpeIfvX+s6tG8clRrqtHqKBZCbxL85stR2ziyNoB8fc6qpIV6?=
 =?us-ascii?Q?PpfxwkhGZ6JMyvJhT/H6KSWj/iGJpfs8huKulATkG6ML06WQs62AVp9Ep+aP?=
 =?us-ascii?Q?HHTWt/QkrDkqaQHOlarmbuudPzqkJnI=3D?=
X-Exchange-RoutingPolicyChecked: Ox+B/7dCVunxd7mrkOlfkrz4uuGwxc0Y76ZJzVD2gPs20BNgQ0rA3mA+MR+8HNq0e6hJBBQrzyTOu20IFESDAZW8AJtcPTl4Mq0DR+o6kWwR7YykC0LZTgvl27ZHDkFFW8aByLnQOYCWmwSMhatRxeU/ysS9AljHJZOC/jsZCfA+N2nU7wYrZNzp/sxp/do94ZNKcACT+mDvaJ/IZAp3ZPslueimas3T7ariuj18qWiEO0nCy5eQhTKWlX0YzXm/J7qRhb7QPWZ1eFnElCtW8bSNd4vwPgjqMC/QgM6xc8kRPA7fIgqcJRpphjPwMzTCgTJq9TT0KyWzWfYWHbmGlQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf297bd-e18a-4fbd-b59f-08ded2aa98cb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 11:12:08.3891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jtgr79Pvx3QAQjswkwp/fUN95XX0qTFKC1JFp0R2a5wCaXULVfoRABvjYl/Fd1J9Qgma4lB83vVFXBonBWSUaR2SwkbGZEBo0hCO72uIF7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7869
X-Proofpoint-GUID: nfewXz0-_Yl5ElU1cor6Ebw6yvt76l2B
X-Authority-Analysis: v=2.4 cv=LYkMLDfi c=1 sm=1 tr=0 ts=6a3d0d09 cx=c_pps
 a=EgTKCgcPzLllfVGnvYq9fA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=S-_rI3sWpzOQp-ENfYcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA5NiBTYWx0ZWRfX1k9FVtGsFcQ5
 GnER7oJXQS/IKrfsTA/EjFdm0D4Yq1QYWMEOrgbOdtQR8pTQ41LvFWcHFEJRs9D8pVjGjK1knmb
 McFksq5LCzPHKFWzqHIXkS6LNGrFjgP0zPCWlUmjFUMu66yyds6utdhvd7nVud4i5eBsxSLbeML
 USEGs8yxWQVxAgX0/OUsTeVBE/5Il3hA028EIn7ccT/58FRunGOa2Tk2/0uIXVwnqPn6eipUqcQ
 dHuQkLnn1BSFYQTwCHFpAH7j+0fN0lN/mrRlm5WtVh7qwhZ1hns6ZnUUNlUHMnzti88HpjbJoeD
 HKFdxfanLWQLmCuTNrnxjKezxghmFbqbHsEGraFlhF/drI4s0CCRLEQ1TMTc9pv6GwgO1eGsGU1
 pJE7ZZJsKkHs/rzTSKGTEk4Y32OZzpYNl4WupgD3JxS/btoVehxN1SRuSeYjt2wxa8vh667lyOQ
 ufjsho9WVxf9itoCRnA==
X-Proofpoint-ORIG-GUID: nfewXz0-_Yl5ElU1cor6Ebw6yvt76l2B
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA5NiBTYWx0ZWRfX+hobPelbKIeO
 BCxpQSAoQ3zRpkbjKKkiOI3Xnx8FyOtEeQGute0qVpKcb5ovqHqaJxIkeNb5oe6Tv1IvdsbEgBS
 GpKJBcaiShvAsIP78hNDpuxxMVBFF04=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/adc/npcm7xx_adc.c | 77 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 7 deletions(-)

diff --git a/hw/adc/npcm7xx_adc.c b/hw/adc/npcm7xx_adc.c
index 3584c27c75..833e01a913 100644
--- a/hw/adc/npcm7xx_adc.c
+++ b/hw/adc/npcm7xx_adc.c
@@ -20,6 +20,8 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/core/registerfields.h"
 #include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
@@ -229,7 +231,6 @@ static void npcm7xx_adc_init(Object *obj)
 {
     NPCM7xxADCState *s = NPCM7XX_ADC(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    int i;
 
     sysbus_init_irq(sbd, &s->irq);
 
@@ -240,15 +241,63 @@ static void npcm7xx_adc_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
     s->clock = qdev_init_clock_in(DEVICE(s), "clock", NULL, NULL, 0);
 
-    for (i = 0; i < NPCM7XX_ADC_NUM_INPUTS; ++i) {
-        object_property_add_uint32_ptr(obj, "adci[*]",
-                &s->adci[i], OBJ_PROP_FLAG_READWRITE);
-    }
-    object_property_add_uint32_ptr(obj, "vref",
-            &s->vref, OBJ_PROP_FLAG_WRITE);
     npcm7xx_adc_calibrate(s);
 }
 
+static void npcm7xx_adc_get_input(Object *obj, Visitor *v,
+                                  const char *name, void *opaque,
+                                  Error **errp)
+{
+    NPCM7xxADCState *s = NPCM7XX_ADC(obj);
+    uint32_t idx, val;
+    int res;
+
+    res = sscanf(name, "adci[%u]", &idx);
+    if (res == EOF || res != 1) {
+        error_setg(errp, "unable to parse index from %s", name);
+        return;
+    }
+
+    val = s->adci[idx];
+    visit_type_uint32(v, name, &val, errp);
+}
+
+static void npcm7xx_adc_set_input(Object *obj, Visitor *v,
+                                  const char *name, void *opaque,
+                                  Error **errp)
+{
+    NPCM7xxADCState *s = NPCM7XX_ADC(obj);
+    uint32_t idx, val;
+    int res;
+
+    res = sscanf(name, "adci[%u]", &idx);
+    if (res == EOF || res != 1) {
+        error_setg(errp, "unable to parse index from %s", name);
+        return;
+    }
+
+    val = s->adci[idx];
+    if (!visit_type_uint32(v, name, &val, errp)) {
+        return;
+    }
+
+    s->adci[idx] = val;
+}
+
+static void npcm7xx_adc_set_vref(Object *obj, Visitor *v,
+                                 const char *name, void *opaque,
+                                 Error **errp)
+{
+    NPCM7xxADCState *s = NPCM7XX_ADC(obj);
+    uint32_t vref = s->vref;
+
+    if (!visit_type_uint32(v, name, &vref, errp)) {
+        return;
+    }
+
+    s->vref = vref;
+}
+
 static const VMStateDescription vmstate_npcm7xx_adc = {
     .name = "npcm7xx-adc",
     .version_id = 0,
@@ -275,6 +324,7 @@ static void npcm7xx_adc_class_init(ObjectClass *klass, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
+    int i;
 
     dc->desc = "NPCM7xx ADC Module";
     dc->vmsd = &vmstate_npcm7xx_adc;
@@ -282,6 +332,19 @@ static void npcm7xx_adc_class_init(ObjectClass *klass, const void *data)
     rc->phases.hold = npcm7xx_adc_hold_reset;
 
     device_class_set_props(dc, npcm7xx_timer_properties);
+
+    for (i = 0; i < NPCM7XX_ADC_NUM_INPUTS; ++i) {
+        g_autofree char *adciprop = g_strdup_printf("adci[%u]", i);
+
+        object_class_property_add(klass, adciprop, "uint32",
+                                  npcm7xx_adc_get_input,
+                                  npcm7xx_adc_set_input,
+                                  NULL, NULL);
+    }
+    object_class_property_add(klass, "vref", "uint32",
+                              NULL,
+                              npcm7xx_adc_set_vref,
+                              NULL, NULL);
 }
 
 static const TypeInfo npcm7xx_adc_info = {
-- 
2.43.0


