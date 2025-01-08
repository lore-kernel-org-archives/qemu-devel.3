Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5DAE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUdX-0006US-Bm; Wed, 08 Jan 2025 06:54:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdS-0006TE-Vx
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:07 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tVUdO-0002Gq-06
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:54:06 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5085doxg029507;
 Wed, 8 Jan 2025 03:54:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=qmzXfCh60HOKeC0hCwPA6A3vwTCuURLH8gSK5DPdh
 Z4=; b=avI/lF7KHfjancqqMDSTgYBhfVTyND6mXIBRkcC3/Lsa5svuZlDMjk0pH
 BhmFNMvYgQtJx9iM1loB7lMF+zQologBlCTTxUKAHC9jMoGtkLd5XfdpHDYax2o/
 8ij6R55DmJpF5/43uq3jwzEO/VUWtsh3z/tJqFj1KfqT/U6FPbJ47bLP69oepRlB
 9DIiOIdIBKFh8VTFjmurlwoIC4xwiN+JFgKebP2hLPMHeIdMN1b8RSjE39oG0iRg
 g/Dief+lR0PORP9W2djBkmdN8zeTkegR29KPWN2Z5EoLS7OwBoXnFxvJZQCIRl9t
 Li7DJov5+7Vsy8PdOopzG5l6j4E0w==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 43y26xqhax-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 03:54:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSsl6dRMes4LjNRJ6iVojPa7XlZBAVing4+Zdq2h7uP/lmMTYo/lafYYKMlt3w3tVSvGhNK6vQ8gjSGzRumo+t1ClR8erom4YEG+BxFuvK3gbAW6Vl4bH94OookfGHIF9kekZ5gQlh6W78r8L39pqoWPUoHVR1Nca4gipiPTZP9RStDV48eTPLrvvmm+1QAbow27CaPMsU2V6Jn+pbmItQmxttcDf93veFWfZ8zdOpJTkZfSRhea467kBxOOC03iY0MfYJ0RvY1gdYcdnMeixkWQdNiFWkigKnjTMaCDwY1MI1MuFXdmifkax2XsYxzKE2ntUEKq+6CGo5Rx7VoOqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmzXfCh60HOKeC0hCwPA6A3vwTCuURLH8gSK5DPdhZ4=;
 b=gX2tz0OwnaN5Dd7HCwEBKpjzTnxKnFYEDPqISXmN/CLF6MC2Anl1nXd28LO0S4Xur/r6nAKJzBjdUCw/yoWRorFy+ll6Hv0PGJtDOamiNh7PAZGntDZniDz3pq321pBWqE6Dr4gITsrpsOe2qsaGj12rOgG6BNdMGm0Dgfsz0NJbd5YJTbuKCjdHrVB0APaFoQ63wn5uwxSj/P5QQOIfAp9khQx8a/uTuorYdv+IHunuZpj1G7e8ItJtz3NAA2+I9Nnr5rOje4DuyOnA5/sla5acyqyzJEzbIbGIsTaGOJR47srGGtC9eVFOI0dd2D7B2PVbob4uFpMnqPkG493rsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmzXfCh60HOKeC0hCwPA6A3vwTCuURLH8gSK5DPdhZ4=;
 b=jcsInNhJUrCQKao6oVIqEE14R6Hm1pO8jlsYqC0etec8WPAZBRZDyrJKR3taQcE1VjxJzFTp1jxhd/ZwsdWbB1F1ijTOTa13R910ML8dPemMvyp5AsJqAFiilNIRt4Mg/v8N4kbP6ilMvvwe7gOSbknZHA/6sbZhzSl9lE5TiZkNZrY27kV7kHdiF223qAoQcA+igzlDtKOMqOcw+w1W9O1fnmgXJJWiVV9pZ2n6MqNeSTDwMt4T6I1RvC81MNpjVEdgm0vRim+J8h0v0mTRr7GlSQ23BqQ6vuI78kEMe79X9kpJ0mJFddwEF3kcZs9WzGBWOHpx3Mxor/+NC05jzg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB7670.namprd02.prod.outlook.com (2603:10b6:510:50::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 11:53:56 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:53:56 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: elena.ufimtseva@oracle.com, alex.williamson@redhat.com, clg@redhat.com,
 jag.raman@oracle.com, thanos.makatos@nutanix.com
Subject: [PATCH 20/26] vfio-user: proxy container connect/disconnect
Date: Wed,  8 Jan 2025 11:50:26 +0000
Message-Id: <20250108115032.1677686-21-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108115032.1677686-1-john.levon@nutanix.com>
References: <20250108115032.1677686-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0066.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::14) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f96c32-c3c5-4f54-c5b2-08dd2fdb2144
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1IU3uMrXDbQP9HuIC2NpmGN9uhm5chPFVkUg/NNxLnEPTcXiFNjQRDLZC9z0?=
 =?us-ascii?Q?0dd/MQdFWQ1kY7/G+B2Kd/WcL+Pnx9Kcp/TCVYy3zv/pVrCmD5Di+B3wS6cy?=
 =?us-ascii?Q?0HyW5lzfPyA40X8Bj/u0958fFVL1WlgCWrTvC/8QcIuL6LQhxLn482rVBMey?=
 =?us-ascii?Q?u4152rOQTUxOe8Ch798/DmwSPDBg5VF8s6+oLrUYPtRVFM11FCjS/ysvziyD?=
 =?us-ascii?Q?ssrjIx3Ip0GEI/a1z1MaHHM+byorHerxbUEcSMMWhfA5eY/gsZFjXieGGUHp?=
 =?us-ascii?Q?JZymML7GranF5H/yxoANApfQ7tXc2yN1D2vGa99K4oP+HZQ3nmLDwjgsS29o?=
 =?us-ascii?Q?VEgG3I/rccZ9DusEjQhXS62IU2TmSJdih4pMRr+gHDSe+I0mX2/vKiz5TIB7?=
 =?us-ascii?Q?0BDFrUewet7AOyvLUYgcDXYLo0BBVQY6ZkhM55fnwSyIjkCNcDMJA7U0Hz1G?=
 =?us-ascii?Q?FE6S/ZOT81CxgO7laLEkmWv/l5qBwN8TsvCc7BpGCGnJAzBCPX04l5x7l3U+?=
 =?us-ascii?Q?qfnYnqNVcNJavFHiqexuc4HQZLP0eAP33tl9WOluCOl+2RKgx/YPWFI1bwoU?=
 =?us-ascii?Q?989aeHV5xcVDb5DM8ebUr0PKqx4fvpXiAJaBPbTSWwdqOwIfDwwV7t/YsJAk?=
 =?us-ascii?Q?KCARFZWpSnmZwCtJSr9An6okwr5uwgk+lzj1fF1d8HMOZQMWehVHuw86iitg?=
 =?us-ascii?Q?vS5yf8Vo8mgod6b6egQWdWA2Mxu/0W8mkAjzHiXxmmWoA5yDXxVMu/lltR2r?=
 =?us-ascii?Q?dxf6PD0NXN5+U1STCQyMayIcEYGG9/BY0OGHL4O6ARluXJGF0bu5k9oETgaO?=
 =?us-ascii?Q?76Wqy0JrptxfrHMPR8PuvZCQwTg39kBAlJXlJYfiwly65rZ/j01Mz9/kPj69?=
 =?us-ascii?Q?z+G3LBWseOxJMSeDNEjBqvtTZ+k3fNfOHveDJwxXMqgRU+FWRzxivXQBNAk+?=
 =?us-ascii?Q?11Zj2M+93h1jsT8JGiw3W0qNnM4UAnyRw9eVEGoGBd5z68oK2LjLLjqdlb3f?=
 =?us-ascii?Q?nEbaaX1SgJBeccYGfZ/V8XP7mLtTv7eTAoDO6atDb40iRceP8iNWnOzcW6Xh?=
 =?us-ascii?Q?9AUriSJ85YWONRyM90/lus530/KF3zk4pR24GAq8jbTfbkxLTQmgDy9t+tBn?=
 =?us-ascii?Q?MCmoMNku/TZssH8Fbxiprxp713+GkF2XrW6S7SgLZordTkVV1mPwkDMLAjR+?=
 =?us-ascii?Q?GzNNGDaYgPhjcjvCJHGSEWX982VCWBXdxwfjMUVN2EsfhUDmicZC8sZagb0i?=
 =?us-ascii?Q?ZfmkFe/Em+yz/wkDrDDInJ0ZfUpFqqVgTMZoJrElx/4ABoIIGwQQJYf0t4rI?=
 =?us-ascii?Q?k5YhcG21yrtkLmreuob/EE7eYDoalx6eaqXnEOFXYf9eq3/X6AEy4BocT/UM?=
 =?us-ascii?Q?tWzneMpBM37rX0VkA3RtA1THfjyt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VwSy415bwnV2gXYl6pzjmbD/ySYVuf+ewu1aPEdxSYIR7wl0IVQ4hIfk5zfy?=
 =?us-ascii?Q?o7lRRHj0J9s+DzO3NswlOkp5dh4BwYRsOT7aRB1Ovx0v3HvRMAiedCut7N9Y?=
 =?us-ascii?Q?h2hVjPo+pcEcWNPlZun82VaRNLQOjwUmQWEtTTHcpeib4tVgewX1EirlWWys?=
 =?us-ascii?Q?7Chsh+jPJjJP/dxs+k0843lyW1x0WEFqazYbF1UWXaTpGSKEI6nvWnoDwPvW?=
 =?us-ascii?Q?HcbrLW70eChNdLgltV0X38YVZ8zD6DNgkZARv12T8kTGvwEL/ViTINFyvWz5?=
 =?us-ascii?Q?2rVyIaHaM2G03PK7FxD9/MBRWRbqQVpXM7qbIaeunMMA1UdtPzyKdNzyVOEM?=
 =?us-ascii?Q?W1D3YljNgyDV6yT/MwfVGqLNYw42pKGJBpqm0gHLnrxSHP+mc/CEeiI213i1?=
 =?us-ascii?Q?8IfJEbIvMeZQRz++qkrSCrb4xO+gTb3GhfLJ4cn/rKSapwbMZdPjPdErSSQp?=
 =?us-ascii?Q?odmSQqjySEtgFOoKlG1rki2oIj/Zksa4wCDVCho1twlS0NjXZhNze2ehWhRm?=
 =?us-ascii?Q?WZSJVsF+MQWyVPNE3U0ApRZ96ZKQGaQnMhzCJG3XYTeEKjebzAoE73Gu7SDd?=
 =?us-ascii?Q?tpXNeXU2T53dIV02UpL+ATfBMhC0zBsFbSM0oRYAZGDrqoWbTYXEe52XSk54?=
 =?us-ascii?Q?QRhNe0AFOyrsftxfNp8m9MnidP/jyoGRFPsLdaOgog1ATNj58h2Ia1REvJJh?=
 =?us-ascii?Q?rNci41dYbtYqmVN0nlIsR3QHgL6L0YXr9rjBUjo9MsCFyJca0OK3XdYTmLBn?=
 =?us-ascii?Q?nyYZZNrC3JvaW6PvNH/+3dKKJe/jhvnG3mKNG9zCt7EiC4sa8WEw363qKWvJ?=
 =?us-ascii?Q?77+46PCKPhNzc1TI7mAEuw1on4v7LVc8JXD7z/77FxVOvGqsLOMeNwYiKk+y?=
 =?us-ascii?Q?XcCtR0D5IVrxb/eJ2Pl0HlJ039NOzvANzOcynUIsofnQ25k/RStBJb0BdnxM?=
 =?us-ascii?Q?YiN5ndSi9wxu9pPN7YQDRmQSWVb5YXwWoH3Yk3zUMQPueLfqnScOsz5FEx+J?=
 =?us-ascii?Q?6ch0cOO7qn4l+7uZBG9M2c5ngIHTybee04VMmEcRzosNosoBn4aEUPWC3BFX?=
 =?us-ascii?Q?OBruRXJMm93PejXA0dCiimOOkZKB3nj39Vopzhh9kA+TL9oGKLpEb58gpkRM?=
 =?us-ascii?Q?EYF3DUshHal0eE08mxdKbmF2YnUziUSl4/S9p5HXzeDm1XKmJwdyK1Y0CwiF?=
 =?us-ascii?Q?JhUeC+SBX/RqdoLhmDfha0zSSCPKAbr1MDmNOP5DIabu1o1eMwYT9xd+8xxL?=
 =?us-ascii?Q?iYBtEZGgOOtLjict/OpTCpEn0avpHXhS/6M3v4M82PWl/wBnza/AbjmdbCDw?=
 =?us-ascii?Q?uYiMS8lk5nCw+O9hVfHQGXmCgLpopGYj4Ip5OweZ9CEvJqmO9uf/HTByjZih?=
 =?us-ascii?Q?SrJ1VFenE6BrucCKp0zS7dBF0pCrK5N/SzNJ4hLw2hJHmnghGjSgQeFKQmnJ?=
 =?us-ascii?Q?o+uYLPOFv2ov46qhWcYREKsGrZsjobBo7Q86KB5G06ayscunLdYZaAkLC/0t?=
 =?us-ascii?Q?lfOR8cLlNQ+zOl4yJsNzMUih9eg8WwIpIBrXET/oqMd0s2R0vZ/FWz+iNGXS?=
 =?us-ascii?Q?JHNW6VKPwXL4BwPA/cM6ihwf87CSDIEVdCF2h1n0?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f96c32-c3c5-4f54-c5b2-08dd2fdb2144
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:53:56.0372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7in9F0S0+GKV8ucvY1PobqUzWXnPRBTjfYFHM1Ajm1NW5qher2FI+PmG2S2UH5tAoUsnyG5CQkF/vfCH47sOcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7670
X-Authority-Analysis: v=2.4 cv=Z/cWHGRA c=1 sm=1 tr=0 ts=677e6758 cx=c_pps
 a=MPHjzrODTC1L994aNYq1fw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VdSt8ZQiCzkA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=ZcKNbaUmCdg_AYcUWpoA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: 5gWBneKDYybk7qXVCKyya92MbQMmpjMp
X-Proofpoint-ORIG-GUID: 5gWBneKDYybk7qXVCKyya92MbQMmpjMp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_02,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jagannathan Raman <jag.raman@oracle.com>

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/container.c           |  4 +++-
 hw/vfio/user-container.c      | 43 +++++++++++++++++++++++++++--------
 hw/vfio/user-protocol.h       |  2 ++
 hw/vfio/user.c                |  3 +++
 hw/vfio/user.h                | 10 ++++++++
 include/hw/vfio/vfio-common.h |  1 +
 6 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index e017cd4b08..5f8d949beb 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -911,7 +911,9 @@ void vfio_put_base_device(VFIODevice *vbasedev)
     QLIST_REMOVE(vbasedev, next);
     vbasedev->group = NULL;
     trace_vfio_put_base_device(vbasedev->fd);
-    close(vbasedev->fd);
+    if (vbasedev->fd != -1) {
+        close(vbasedev->fd);
+    }
 }
 
 static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
diff --git a/hw/vfio/user-container.c b/hw/vfio/user-container.c
index 201755e3d1..99839edeed 100644
--- a/hw/vfio/user-container.c
+++ b/hw/vfio/user-container.c
@@ -55,15 +55,28 @@ static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
 
 static bool vfio_user_setup(VFIOContainerBase *bcontainer, Error **errp)
 {
-    error_setg_errno(errp, ENOTSUP, "Not supported");
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                bcontainer);
+
+    assert(container->proxy->dma_pgsizes != 0);
+    bcontainer->pgsizes = container->proxy->dma_pgsizes;
+    bcontainer->dma_max_mappings = container->proxy->max_dma;
+
+    /* No live migration support yet. */
+    bcontainer->dirty_pages_supported = false;
+    bcontainer->max_dirty_bitmap_size = container->proxy->max_bitmap;
+    bcontainer->dirty_pgsizes = container->proxy->migr_pgsize;
+
+    return true;
 }
 
-static VFIOUserContainer *vfio_create_user_container(Error **errp)
+static VFIOUserContainer *vfio_create_user_container(VFIODevice *vbasedev,
+                                                     Error **errp)
 {
     VFIOUserContainer *container;
 
     container = VFIO_IOMMU_USER(object_new(TYPE_VFIO_IOMMU_USER));
+    container->proxy = vbasedev->proxy;
     return container;
 }
 
@@ -71,16 +84,18 @@ static VFIOUserContainer *vfio_create_user_container(Error **errp)
  * Try to mirror vfio_connect_container() as much as possible.
  */
 static VFIOUserContainer *
-vfio_connect_user_container(AddressSpace *as, Error **errp)
+vfio_connect_user_container(AddressSpace *as, VFIODevice *vbasedev,
+                            Error **errp)
 {
     VFIOContainerBase *bcontainer;
     VFIOUserContainer *container;
     VFIOAddressSpace *space;
     VFIOIOMMUClass *vioc;
+    int ret;
 
     space = vfio_get_address_space(as);
 
-    container = vfio_create_user_container(errp);
+    container = vfio_create_user_container(vbasedev, errp);
     if (!container) {
         goto put_space_exit;
     }
@@ -91,11 +106,17 @@ vfio_connect_user_container(AddressSpace *as, Error **errp)
         goto free_container_exit;
     }
 
+    ret = ram_block_uncoordinated_discard_disable(true);
+    if (ret) {
+        error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
+        goto unregister_container_exit;
+    }
+
     vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
     assert(vioc->setup);
 
     if (!vioc->setup(bcontainer, errp)) {
-        goto unregister_container_exit;
+        goto enable_discards_exit;
     }
 
     vfio_address_space_insert(space, bcontainer);
@@ -120,6 +141,9 @@ listener_release_exit:
         vioc->release(bcontainer);
     }
 
+enable_discards_exit:
+    ram_block_uncoordinated_discard_disable(false);
+
 unregister_container_exit:
     vfio_cpr_unregister_container(bcontainer);
 
@@ -136,14 +160,15 @@ static void vfio_disconnect_user_container(VFIOUserContainer *container)
 {
     VFIOContainerBase *bcontainer = &container->bcontainer;
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    VFIOAddressSpace *space = bcontainer->space;
+
+    ram_block_uncoordinated_discard_disable(false);
 
     memory_listener_unregister(&bcontainer->listener);
     if (vioc->release) {
         vioc->release(bcontainer);
     }
 
-    VFIOAddressSpace *space = bcontainer->space;
-
     vfio_cpr_unregister_container(bcontainer);
     object_unref(container);
 
@@ -177,7 +202,7 @@ static bool vfio_user_attach_device(const char *name, VFIODevice *vbasedev,
 {
     VFIOUserContainer *container;
 
-    container = vfio_connect_user_container(as, errp);
+    container = vfio_connect_user_container(as, vbasedev, errp);
     if (container == NULL) {
         error_prepend(errp, "failed to connect proxy");
         return false;
diff --git a/hw/vfio/user-protocol.h b/hw/vfio/user-protocol.h
index 48dd475ab3..87e43ddc72 100644
--- a/hw/vfio/user-protocol.h
+++ b/hw/vfio/user-protocol.h
@@ -16,6 +16,8 @@
  * region and offset info for read and write commands.
  */
 
+#include <stdint.h>
+
 typedef struct {
     uint16_t id;
     uint16_t command;
diff --git a/hw/vfio/user.c b/hw/vfio/user.c
index be2fba522d..4b1549cf8e 100644
--- a/hw/vfio/user.c
+++ b/hw/vfio/user.c
@@ -18,6 +18,9 @@
 #include "qemu/lockable.h"
 #include "hw/hw.h"
 #include "hw/vfio/vfio-common.h"
+#include "exec/address-spaces.h"
+#include "exec/memory.h"
+#include "exec/ram_addr.h"
 #include "qemu/sockets.h"
 #include "io/channel.h"
 #include "io/channel-socket.h"
diff --git a/hw/vfio/user.h b/hw/vfio/user.h
index 1f99a976d6..9039e96069 100644
--- a/hw/vfio/user.h
+++ b/hw/vfio/user.h
@@ -11,7 +11,17 @@
  *
  */
 
+#include <stdbool.h>
+
+#include "glib-compat.h"
 #include "user-protocol.h"
+#include "qemu/osdep.h"
+#include "qemu/typedefs.h"
+#include "qemu/queue.h"
+#include "qemu/sockets.h"
+#include "qemu/thread.h"
+
+typedef struct VFIODevice VFIODevice;
 
 typedef struct {
     int send_fds;
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 593e304ee0..06cdf05c61 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -123,6 +123,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
 /* MMU container sub-class for vfio-user. */
 typedef struct VFIOUserContainer {
     VFIOContainerBase bcontainer;
+    VFIOUserProxy *proxy;
 } VFIOUserContainer;
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserContainer, VFIO_IOMMU_USER);
-- 
2.34.1


