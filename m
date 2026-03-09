Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BBCF513F1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 09:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzWcL-0001MJ-A6; Mon, 09 Mar 2026 05:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1vzWcD-0001Lr-Ha
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 05:09:29 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1vzWcA-0002xt-Va
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 05:09:29 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629099jk405258; Mon, 9 Mar 2026 02:09:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=+vOq1exFAv/uU
 SouA18pEjylIOu1nGcSNxGttfvenhg=; b=xm9Gl5aJwlJ/cAzQcaY5WkUcDKEIP
 bkiGv2GZHKUNa8Wy/dowQK4Ode12+sLb/G0jgxi4/wWKucMUk4Loy991xyMIMSEy
 BRHh9VYesGC2GPrrJ3h4X2eeEY0Mk/zK/7ntEfEWBecO6S+RVo3wH5OMdjdKsTDu
 +RtWxWCJZUes+b/ul5uHVmgMZw21KCNYeahmCy22SQEK74tGOFKpUg6QSxKQTEcO
 QCUQGlHpWRzykKY8IDQeUC3iFiRq1snsWNM+TMTs75y6Fb3eGcB3AlgGbAZv/NAc
 gE/OoHi5C6JEYZ35u5p3qnzKmk++UxdxMmjCWTYb9LCFEgEGS6V2xhlVQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021072.outbound.protection.outlook.com [52.101.52.72])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4crk0k349s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 02:09:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1NI+q813/7E5m4CdW45puVWB4mFZawxHQDFIiNVONGcVBCuLjhsyGYXVjsmLKC/gotVL/Uebc9A8US8LyfO9xaWYJdq99Y3VP/WRuZFWRy2+DucAZaaX1J6swvXaOk/J3foZDbnAKxaEFwhi8mGyKg84Ha4rkTp6iGVmW0C8xj/M4RrKy5YpPA1rflF0WP5PemLezQbzGhV3VtwIz9mfuBJ8Lw4Cco5o2FVSY+S32ZZIlDNeXRRwVXIpyLJBAxJmv/qFkeRTdt8mbVgmZwgxLkZQBl+zLBGxU7zyNSX04/qhw2GY8sM2Xh/kY/kfQNAkROg2M68DZhTeWch0WEtUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vOq1exFAv/uUSouA18pEjylIOu1nGcSNxGttfvenhg=;
 b=Nhib9jETSMVZeiDdzMHu1+T5hRep8ciWJrRuAkEgDCZdKhibE1MG9Z0lDL74hAvp+NilZi0FZEH0yuW/TQ2qi8vEklLemwzfHgoZcTtMo21XLcXZbV9ucWShvxDsNi4EhmLBGiFSoSYPJ6D97NUYuKtAFzv/fbg3USyoK+IBo7Ey/1O3D0LnjI8XMa3aVJezKdgCFM6pMOIWB8gONqkte5e9G6kL2z3mTKTJtrR2VaFyHUQqV4kXXh9E42e/DyrBaGIgFwObacfp7hmAM/F9wBbXriXNn7AhZtFxSFgK/+HlsaetN5UAzO9BELo8czQmZrfu12Odp1wUlx5H5kdsKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vOq1exFAv/uUSouA18pEjylIOu1nGcSNxGttfvenhg=;
 b=zDs0gzXgR5CVHCTvkQ/wNGN2Xo+uhJmnNGgf0yJCXoBRY+4bB1J7bbIEQ8B6+hKuEPU5X3psQ8F+yEwS0uwKYpm9oRhsD46uBOiG5X+RGlnJo0KOizC8/YVavzPNeWyA+I+Rkq8hKxZhmamfyjhDUI8Ewp3cGulo0b8GD8823eCZmQiNxawLZ2bE81kGK4n3JykBta/u5wW1OXX000uSWLxVzzh0WAcLOKepdKJEekPAGlk0kgaDvC+WRFvjEUZvRyESPaEt+Oj7wcjacQMD2tZe+Qd1px/G+kG5122lTfDt7tGGA/sY376/Ab5T4jSdy8HkM2CxujHF9nrTI1HsaA==
Received: from MW6PR02MB9817.namprd02.prod.outlook.com (2603:10b6:303:23b::15)
 by SJ0PR02MB8767.namprd02.prod.outlook.com (2603:10b6:a03:3d3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Mon, 9 Mar
 2026 09:09:22 +0000
Received: from MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c]) by MW6PR02MB9817.namprd02.prod.outlook.com
 ([fe80::86e5:3449:a3f7:ee4c%5]) with mapi id 15.20.9678.020; Mon, 9 Mar 2026
 09:09:21 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Tejus GK <tejus.gk@nutanix.com>
Subject: [PATCH v2 1/1] io: make zerocopy fallback accounting more accurate
Date: Mon,  9 Mar 2026 09:09:01 +0000
Message-ID: <20260309090907.956330-1-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0066.namprd17.prod.outlook.com
 (2603:10b6:510:325::15) To MW6PR02MB9817.namprd02.prod.outlook.com
 (2603:10b6:303:23b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR02MB9817:EE_|SJ0PR02MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e9ba1c-b0ac-4e0f-0b78-08de7dbb8d5b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: 9HuGEk0GAnonrxNTiRv+MdNRwKtkQUuJ2P5DhLe2G59yrYXcqQ6I0d6v0lgEAgR4Ja2eJcy67DIBP41D8ck7OyfNQReuHctBXm6nyrTOU8n/f49nRYteVm0NTdM7Cy1Hv3s4oWgHrLfIEPe+n6dEfheoPon5k3yKUiNv6iWY+dhTkZ0gd+4nHlyzooIqualjh8TKBD+PctI8HiEzHJiFDdnUD5K6xilP3mc99xaNqNrOrIpKJBTpqPSciCq8csIhXAhQMWib/YNKcstOuyTru+njqBXN1LXC18dss+v4s7NBfnxm8/rbtvPDSzKrpJR/hnG79tjLa7MNvmL5MYdRyraJQeiX8d2RTIql2/Fa+UMiJPfegzNIW5IIA04IZ5tuYInYFYIPDMJuY4KAlMQWFnSiv58LL2pPVTdDxeEVPtShp2cAY0c/zeyKJplBE3eB1XvzTO6XszWyuWiMKDrlci4GWuRv28Axi4FAb+6mMC6NYyLL104Ni2x0xC+TR3P9O9het9G0rNVU9mST/ZUa+DgBPdAYdxG/DtmCOCRx63UfL0KG1xgeMGmkxQMrgH8Wccy0Wmwd9GiMnFZTKj8RHeGsLK4ZezEv028a+9XmBbgNklPUT1byC/eQj1qzveU/FehXESNVFLAXGe76sarevsFzwJSUNXIAJax9pL3O39RrrmBVjJRHDChTGPYc6s6FJggOLDkHM20yeR3ZnnkSy7khs+d8yKciQUPyepL1UbujmK5Y3YGqc5JNAWYS0fsR4tvOHezPIjzEUjR0k0fdgwXEwhxyMpUbl/9my9zWpHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR02MB9817.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g0/8koKaMm5H1FMy6m9uaTV2pR+RFn87mkqKrYBjVHF9A9JAH6j4/Ks1uQRu?=
 =?us-ascii?Q?axILG+bpJMDSx/1dBs6NifVu1r26e82epeqmH4HnVzafufqJKfk0sLhZsaIU?=
 =?us-ascii?Q?sUa67nexSLP29RSS5yOvJpMm9K13MLsdbG6FncErk3g9u/XA98zGzJxT4YI6?=
 =?us-ascii?Q?97tC4KVFN8lrDP6yP3TcBcR6yyKeNVUG9LpQcggXRyllF6L/mBjnXfqO94no?=
 =?us-ascii?Q?FRuFTZ23WJRYXIYgQxnwwcFnquxLAiQkEgVnQZLWIUfgMRPWbTpjRJ3QPAAK?=
 =?us-ascii?Q?+qrQus7p2pfzCB4GV0YBBTPCLyxqfE0rLRRkHxlYCJAwiCawa7VikCAqvx9L?=
 =?us-ascii?Q?pkDdd9AmCmrMaNE3YVRLI43T6Sgv37MoXQVumUXAii3vV1NG+UjZSVE3LCiy?=
 =?us-ascii?Q?GOuOdqRbwb80ZBWVcy6v1z6jPxQHR4Iy7eQUi+6X7pcn0+f8KpBSJS6Lwe/z?=
 =?us-ascii?Q?KY9veO3BYNtt0wzsXJGktEGjMtVN45O1IEsiuKS7o6k3WYMdg9Muc14eeOCn?=
 =?us-ascii?Q?ePnkkvCeNdjAXAV34kPGKfQQJUNOxfcu3S5yqvGCsKvwOL8JxFW9g2aaYUlW?=
 =?us-ascii?Q?tJfUy5JJzQjiVZys47d7lU7FEZGO4kCWpmIOnYAuFF63/DA+WKxwAf+D27Ee?=
 =?us-ascii?Q?cfXHU3pW/dax6hLHTVz52kIKfpEMS+GSmqAdWM491rT1Gd9A1xln8n3WLjuB?=
 =?us-ascii?Q?E94sSu5Ws3X7BZstVj9tDeM3xzkCo062xDhtD6SQ6kok5Hnx/YSBC36pQ8J/?=
 =?us-ascii?Q?KNP1oDImMaXEkurwmVJMu/TYCSDozVmcT6Ru5WrEi8B9YRPrbuDmrZ8uXSxG?=
 =?us-ascii?Q?IY6F6xcZKKqVXc11X0n6dgMrRBltyjUMlqS0t81BWGwmpivA61qodGC3LQeu?=
 =?us-ascii?Q?fRTkZki1CF5lwIBguEUNswHplpf4dEUA2obIvznsvxn4vtQG2UzSqTrPTmUM?=
 =?us-ascii?Q?ulVLxxJTA9lJmI1nbcxlhQPr3z4smUvGTqHMRgNhQasiE3zsYfZcom8WhGUj?=
 =?us-ascii?Q?vNPXx2pTWaBnp8iVE7Ek6GMHydJiZzLiPaMWlMeDY6ChMqt+SKvCACkx/zG7?=
 =?us-ascii?Q?/Yy7RvIkHvrxePMsK5eVY/GbMQGzF8V03Tef8wUGjSSS7UYU/hSb5Ue2QZv7?=
 =?us-ascii?Q?+RJI5sjsbF+aUGt8LNCuesQImDIEqIo3kcgZFIu5eWamhnnmsLkxwgpcAWcY?=
 =?us-ascii?Q?QTJZddFG2HMqNZujIkMG5velPW9AjVh/iZXrnnXrUWAKQhb5CTlXErxzpO+q?=
 =?us-ascii?Q?rGNbZC32jCYMsfh3gtaufSqw1zcpdQadi9gJ68oKdV+TzXRtMunb/yRnTVcx?=
 =?us-ascii?Q?1yPzoe60sKBtX3InVLxUJdzuC6pp6bhoJV0RW+0YOCkvKlMHHui1eZf3/LEt?=
 =?us-ascii?Q?mPHO1oDUrxMZpy/cerowmlMBh1XvCTicV9/YfYD7dPXxwOzE7K8AQYHo5Adr?=
 =?us-ascii?Q?2UA4TrGXgWEPFzg1kWhAqdcb+OCeqz7cL175G93bFzGWAn5YGq48oNDY+qg0?=
 =?us-ascii?Q?0CsrGbXvI6gTWx1p61GBMn3TFJ94f6cZYX89m2UoimsBLHTcP05jyVZ9XXxD?=
 =?us-ascii?Q?Ggro7roNTsIbBnXvS4MxtQq1sSvOpYXi6nE4ZL17vzn0CCzXmpQ2J+FmfHYx?=
 =?us-ascii?Q?hCiC+Zpy6HOY6WICHXVedHKasZWIY6h+7sGRgo43YLWoQzM07m5wzohQYG3I?=
 =?us-ascii?Q?Me41S3n3CaoYkw4IJXGnkc1mDQMNUjl8K7hBFfEiQa2JxkmgFYrvg/yBSc7y?=
 =?us-ascii?Q?ZpVfDc//Mw=3D=3D?=
X-Exchange-RoutingPolicyChecked: DriDkPgdy1GSGvGEuoQ15P1LwZHg4bwo1KEu7S2F78ds44pWlnnJT+/bhN9AnF0ssm22QA9LIflUmEuPAwbDlPunqmOoWo0wenztgX6M+e46+8tIQDLn4QIEuBSH4E10cgkBCy5Z6aGp8bp0aNma6sI/BuzK08mjyMzPH9k41ofNQqFMxK1e4k9Z7n6zC5o9FDJbTaEXvZZceZUvFw9t0Pi870Yi3uQnNM5BS5nWtntt9XR3vb51dx7b+5RyScNX98h9S10T7zRl0qrmt+X089qPTvOvla0HC6AP573RkckUuLtfAFnvzfsVzpuUajrVKINxBbasFVLrrUVCOv1+pA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e9ba1c-b0ac-4e0f-0b78-08de7dbb8d5b
X-MS-Exchange-CrossTenant-AuthSource: MW6PR02MB9817.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 09:09:21.8048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wug00Y4IUnXFhHA5PvVU0S8/O+6PcO/nFFdXtnGlrc8BE0UnBSXdJ8Ls3rb7ZJbF8s+P5EeOS8V9SiRpn9ApcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8767
X-Proofpoint-ORIG-GUID: Ruu6ph3Ca7MfOSv4DYUOpFcQB-NZceKR
X-Proofpoint-GUID: Ruu6ph3Ca7MfOSv4DYUOpFcQB-NZceKR
X-Authority-Analysis: v=2.4 cv=KrtAGGWN c=1 sm=1 tr=0 ts=69ae8e44 cx=c_pps
 a=m2/28Svseh3Q/SQ6sWV1ig==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=1iCvTkLjoyvijxJEWlIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA4MyBTYWx0ZWRfX84nXkxyWYde+
 ORlFA4QkJAu3khbb4yQ31xuWT/Mbe1tSB33izWToEOm4Fe5BGRsAmfmfyK/VkUcSaLCzYmp84g8
 LEjD43kM/u/lePHf203DvQ8i2545svtwD9LWYUKNP6nXKtGmvXK4UoQUh31q9CZAzYJpeZ/Rn/4
 XqpbSzYvj5KXvV57LnNa+n1y/BGL+14Ambhts8Brq17Uk/Wopb0VS2TpCiwxCeNujrc/uO2ECRV
 a8xXIoKFsDuctZk2Hd0hLx72TMALmEpayB7CVxCH6jbrcGF51X1IGfBdi8M0hGfORdimZN51UPx
 jz23k0c6HDDdV92PuH5hpfS8jlEV0PSCBCZWGrYkGhUydBDfU8yqQLaOLbe216kXqWKtkqJdbZl
 LH20qdjvCR1UM95zSFL3XP6Dorb5wx20e8AgmEKtd+BJjSaEEOwm+vtffYdSuICQjHk9mpj/OmF
 x5qcQBl1my0hVx47zzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Currently, the dirty-sync-missed-zero-copy stat is incremented only when
an entire batch of IO operations fails to use zerocopy and falls back to
a normal copy. As long as at least one IO in the batch is successfully
zero-copied, the whole batch is treated as a success. This hides
individual IO fallbacks and makes the migration stat less accurate than
it could be.

Make the stat more accurate by reporting at a finer granularity, i.e, by
incrementing for every individual IO fallback that occurs.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
---
 include/io/channel-socket.h |  6 +-----
 include/io/channel.h        |  5 ++---
 io/channel-socket.c         | 13 ++++---------
 migration/multifd.c         |  8 +++++---
 qapi/migration.json         |  3 +--
 5 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
index a1ef3136ea..5c5714668e 100644
--- a/include/io/channel-socket.h
+++ b/include/io/channel-socket.h
@@ -50,11 +50,7 @@ struct QIOChannelSocket {
     ssize_t zero_copy_queued;
     ssize_t zero_copy_sent;
     bool blocking;
-    /**
-     * This flag indicates whether any new data was successfully sent with
-     * zerocopy since the last qio_channel_socket_flush() call.
-     */
-    bool new_zero_copy_sent_success;
+    ssize_t zero_copy_fallback;
 };
 
 
diff --git a/include/io/channel.h b/include/io/channel.h
index 1b02350437..70f701ae16 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -1013,9 +1013,8 @@ int coroutine_mixed_fn qio_channel_writev_full_all(QIOChannel *ioc,
  *
  * If not implemented, acts as a no-op, and returns 0.
  *
- * Returns -1 if any error is found,
- *          1 if every send failed to use zero copy.
- *          0 otherwise.
+ * Returns -1 if any error is found, otherwise returns a non-negative number
+ * indicating the number of IO requests that fell back to copy.
  */
 
 int qio_channel_flush(QIOChannel *ioc,
diff --git a/io/channel-socket.c b/io/channel-socket.c
index 3053b35ad8..08b9862074 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -72,7 +72,7 @@ qio_channel_socket_new(void)
     sioc->zero_copy_queued = 0;
     sioc->zero_copy_sent = 0;
     sioc->blocking = false;
-    sioc->new_zero_copy_sent_success = false;
+    sioc->zero_copy_fallback = 0;
 
     ioc = QIO_CHANNEL(sioc);
     qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
@@ -881,8 +881,8 @@ static int qio_channel_socket_flush_internal(QIOChannel *ioc,
         sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
 
         /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
-        if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
-            sioc->new_zero_copy_sent_success = true;
+        if (serr->ee_code == SO_EE_CODE_ZEROCOPY_COPIED) {
+            sioc->zero_copy_fallback++;
         }
     }
 
@@ -900,12 +900,7 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
         return ret;
     }
 
-    if (sioc->new_zero_copy_sent_success) {
-        sioc->new_zero_copy_sent_success = false;
-        return 0;
-    }
-
-    return 1;
+    return sioc->zero_copy_fallback;
 }
 
 #endif /* QEMU_MSG_ZEROCOPY */
diff --git a/migration/multifd.c b/migration/multifd.c
index ad6261688f..726e40903d 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -593,7 +593,7 @@ void multifd_send_shutdown(void)
 
 static int multifd_zero_copy_flush(QIOChannel *c)
 {
-    int ret;
+    ssize_t ret;
     Error *err = NULL;
 
     ret = qio_channel_flush(c, &err);
@@ -601,8 +601,10 @@ static int multifd_zero_copy_flush(QIOChannel *c)
         error_report_err(err);
         return -1;
     }
-    if (ret == 1) {
-        qatomic_add(&mig_stats.dirty_sync_missed_zero_copy, 1);
+
+    if (qatomic_read(&mig_stats.dirty_sync_missed_zero_copy) != (uint64_t)ret) {
+        /* Update statistics if more fallback detected */
+        qatomic_set(&mig_stats.dirty_sync_missed_zero_copy, (uint64_t)ret);
     }
 
     return ret;
diff --git a/qapi/migration.json b/qapi/migration.json
index f925e5541b..94977b8810 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -58,8 +58,7 @@
 #     (since 7.0).
 #
 # @dirty-sync-missed-zero-copy: Number of times dirty RAM
-#     synchronization could not avoid copying dirty pages.  This is
-#     between 0 and @dirty-sync-count * @multifd-channels.
+#     synchronization could not avoid copying dirty pages.
 #     (since 7.1)
 #
 # Since: 0.14
-- 
2.43.7


