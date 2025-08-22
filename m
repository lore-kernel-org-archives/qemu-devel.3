Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81F1CA0EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQf4-0001eE-4s; Fri, 22 Aug 2025 08:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQf2-0001ds-JE
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:24 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQf0-0000hS-Ej
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:24 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57M8QQU8656691; Fri, 22 Aug 2025 05:14:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=dWFWovc2KtPVIaOEbxetuia65GMUJCJkkmz1pITsB
 ng=; b=v1FnDGoXmADQ6BEpEXnNXyoBKXASwefXehSdxdLlagLyKbLXt9uHj0e0E
 IrZC5zQYMrBCbhBk/sOKbFP1R6tZmuKOI2uGLcWrsAZjMMXvvl9LptjQL99I3M3R
 4KETIc4Me78AuEcd4X1no4IufOBaeoZqf5fsYSxPNE+lOk32uRIxCoyhnvSpOdlg
 YQLIZ0EVs+wKEQZAMEZHS8ExVzFR1nknNCwi9BKPxkXz1qp808uT2oaP48ET+ZM1
 VoJqvlpwLHVvDbtcGfp+TgUtE778s0z4cDmRNsy6OZVzu9JHwOwXhJfoanw9LYvn
 vwR/BLOBx2CcL5U8iV69H93E9DUtQ==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2098.outbound.protection.outlook.com [40.107.237.98])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48mye7yjfv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 05:14:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v97CmLdKI/h5oLXhjgijHNqNTGw7J1MOaKr6dWrt5/AcSdf6EfWgBcjqqjjsiMz+Dt8fDb+ELk7SG8/r4OiyNB8Ejd0WySMLJQ/ZKRqvlPJXz6UqhP1AqggBvySPoeFUReaUYZJlYWNoMardLVUQSV9vSm0GmoA4OSlPOfIFT4AJkDZnq4jMDhBegDQjfnHfvhc5nU2BCxPtSwKfy3V/nwKmeyMuQxdaOtKVFa4w3h+rkvTxfd+0pW8BD2YDfEEoXBzH4pXcYR4kN+Uin+OmBq97NtaRX4We2zKdVzt1jWIQCBhw5tshVrOrTHOODzHxlVsUaFDaka5PMwORVD9iXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWFWovc2KtPVIaOEbxetuia65GMUJCJkkmz1pITsBng=;
 b=sWWclY+sxnm+vntiPN1AbZGgSEkatQzlC3eoqYElTMdlYiVBn0Dy3dt6E8yUT2lClbkjxqO29ExU303tgVPHy2F4LIGoAAtKnIT1antRdHHV+mKFNkwLEh4kW39uBlRgL+UAEgeLoVEKlz5ciCQmYgEMwjIGToiU1sesZ2Etak+eQ5qlwAJuREDTsG9IBmP9EXSW50fzL+YYtjTj/Sw6JLkicvPnWcG7IIRMhWlSqXShekAInY+8XHu6OdcXuf4yTs4yuwDqy3t0A37ATBSBVqPYHO9K4EX+3ox2DkyGSC8NyCk8xWCGDA2k7v4O65n5vf/2DJHXmCw+sWPtz/AtUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWFWovc2KtPVIaOEbxetuia65GMUJCJkkmz1pITsBng=;
 b=hzRbjOZwKsKhA+3MJ7YemNNbw+XD/TKfmQ8wY1T9O8yBP8CeBliSB1gIIxbR8PsUnIia1uf8oOrxOwLLDGMewSIpeFE8t6T4TKzZxQbHGogjyDFfbcscMjhnhCoJ240indK+wF6pef3ILZmRhdyfcYUoFXWgYEWrlvW42YhJFe3+baU1qK91Hgf1BmV2AFlDzjzOY0+o1zfto8x7IsCsiuVBcS2XjOKogbuMUo6Hy/NnQnCwSHw3jo9AEm9UCjN//wobhBfpHNbRy30S2FWDekxHS5+VsUcksBHqzXg7V0e8rnZFJsUYz5VJy1ogf7Suz59y96PHkCvBE/cMlNmSqg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7725.namprd02.prod.outlook.com (2603:10b6:a03:322::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 12:14:19 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:14:19 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v6 09/19] hw/i386/pc_piix.c: simplify RAM size logic in
 pc_init_isa()
Date: Fri, 22 Aug 2025 13:11:55 +0100
Message-ID: <20250822121342.894223-10-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822121342.894223-1-mark.caveayland@nutanix.com>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0076.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::29) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 6804789b-f86a-44c6-a259-08dde1756b88
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5XJbgOxEGUqdvO6xwcoBsYCFXuSUN5eBXiG2HMJqqUtdD21AMmIgXzHqn/Ww?=
 =?us-ascii?Q?NrQAvyUJnYxRKSAZLQjQ90ubhhCFm1wh66qHZMz5md33NoqqB6VOXUMsx5ep?=
 =?us-ascii?Q?ApTz29JTfaXeuKVWZlQP9YS84KLze85vjy2u2QXrWMrUpCUEmSD1VDXfwaUk?=
 =?us-ascii?Q?X9ZoC3WSnbpN3QP3ASqEBv6xyfscYPzfTiRd8kALW8/9gswdcIkP59u7FeND?=
 =?us-ascii?Q?csTQRptSkOvUDLzD95PmbRvi/Yf2Lem34H0IWcGPFS0nJvX4xKTkhfxWY/xZ?=
 =?us-ascii?Q?kFbHP9yOWhAnFZ+q+dfqBwg+uEL8kifUwzEDQSg6iEIl9JST9UNMzvQIfRic?=
 =?us-ascii?Q?F6rTFDcaId400uL7+8KEjM0T1UWNKIhWkebcW7az3E1gxAfIfd8noN2lBaWk?=
 =?us-ascii?Q?UJ0iktryEFhjpK9Sp/yLIFtI1HBBNtyTm3f24qbL9ubg+K+lHDCTl6derrWY?=
 =?us-ascii?Q?KDTmp+4maFI8ezgU1PTqk/8CQSIOdijBUTO/+5EHpSJNz+qHMCf2MTSIPsB3?=
 =?us-ascii?Q?r0bZUH92BSSldo76WH1+MRompEfGPdgA3Yech/VaimqgzIwwV54tvdptFnYP?=
 =?us-ascii?Q?uVoIAoi7m7iUT+Eittu+DTMFrpjFqUlqPHo4PESfCLdyE1X8jX9ny/ldL/62?=
 =?us-ascii?Q?/fLNd//Pp1J2VTaYbrdGen3h5y5Up7a52mvDyqhqUm1jHmECQbPMbIK8nS4C?=
 =?us-ascii?Q?c6PykwvkHJFrlApB+1vlfTieoyjfG1WLeIqFV0wKvWmythiz/ZbrTR0cqDp7?=
 =?us-ascii?Q?qe6E8u5+TSq48fND3DbxFgBUxqsWtny+xzY9LiPXftwc0pJqAy9FauQESP5T?=
 =?us-ascii?Q?b+wV+D0HZLMb2UMTSGRf3asw3GNNq/5rpcNureYsViH3V3NM1tMbNdNKniR5?=
 =?us-ascii?Q?X/d1o+Rt1wSYArsPV798dUju4A3fJXSAT/oS0OnNeMbUwD6lff/0XER68mpF?=
 =?us-ascii?Q?JMlRQXuYjj9muzKJOLhwwcLsKZXRPHDtE9v3EUBeVn9iwIIiR2z3XleKQrpH?=
 =?us-ascii?Q?zXs4YzaLioleipGBSVuYpBG8dQClBRldnPPc981yrWmvmYxLrOO9/Eveggao?=
 =?us-ascii?Q?X1HB5kX2oH+o8wV2jRmukzYqigroz6it2QCgRagDYZrLpSps+OYVzAQ03h3k?=
 =?us-ascii?Q?5Fdyi0RUWEDc2kINT3QSqaCgosftmJ7uum+P4mZ7vIcgaAzjjXFBYHn9gFh2?=
 =?us-ascii?Q?E6cV1rii2MNjDIBBqErb+oS6abAnI1zovVE3oFwlQuS1MqavVh3xfgtz3oh7?=
 =?us-ascii?Q?vpiN42oAwGYHNt1tYS0wG1iFGf6w1x4faCDph0bXsjfymTs7rJRMrby0Uong?=
 =?us-ascii?Q?SgyAupFagwwDjOWTL0DazFfDBKYOb8QUxMV+8AZb66rS1rr69PPma5byFC2v?=
 =?us-ascii?Q?UvfGSeumvwoQ2NFLiJCJq3tqkZRjau9a1df9si+w2mzAFL9GsRlR0Pp2GBLR?=
 =?us-ascii?Q?/L0BN3CJ04o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A/bDzUfn2CQtPOxkq3ZPhSKMDdBiIQPJQpBK33WInJUzITOtInYogrntcIlA?=
 =?us-ascii?Q?pJv0uNJW9Uny5ZNaED1qz2AGjj6ptXEgODRZS/Nuyt7eYV7dw90I1RQdzczG?=
 =?us-ascii?Q?g5Jiz8VRZz0YGxfyvIzOurLUL0PlCchJ8eqk9B2ptWLxwzngXv5Ioa4I7UuS?=
 =?us-ascii?Q?tpasR284RAiLXFsZsN1TOozxWbh7m+euDKMTkXhLv9KykPF3/B1m1UkeRHni?=
 =?us-ascii?Q?G74ZbbMGR/ArgtBY0t9nebspK1o6JQByHtrF0xLQqD+GkTlme6d+HaDH4fNp?=
 =?us-ascii?Q?cuxicfnFFZ+avMNlU8K9Jlc0CQrY6aUFD2XJ8lF+iv7338Hq3v7pTwudCCKs?=
 =?us-ascii?Q?uCPkP/NxpORVuhDm98DpYM1HL4KDSLiJHIlKTOI2dNlJf4HpMu8NEB/ntsDR?=
 =?us-ascii?Q?tLol1zKoPTj0mMt/A57u+VWUVacJxj29SLW1Av19CPSKUvxYjiX/czy9WKM+?=
 =?us-ascii?Q?kR/OJ0TODt28GP2lLKK6DyhYKeOhnFrq6F/Cnw2nsWZ977+VccNFx5f6UDtq?=
 =?us-ascii?Q?elZBdH/dia/SORP+rpsty2sN5vwbzCYVN9V6jlZ8mK2ppcA1OGK68RS2vDM/?=
 =?us-ascii?Q?8btW21iPDdMLzPu/Qb9u1l1LJufgyEYdBcuMYDaHBL/7j6IDTv/4baMu7Jfv?=
 =?us-ascii?Q?WF+dyRBBdICTnpb9CzjJzVe0iOUc8VYks32oHXha9oypf+QwBr+Jd3P1KKmO?=
 =?us-ascii?Q?FWv0da7nOd+nvdFdmSy/TaMl1Nr7RvKzbbDJj3RFG3DvjWtY9pxT3ps+d6b5?=
 =?us-ascii?Q?PRFmGSqU7ZwvxBFE0koOl8X/iFrZa8GFS6ezd4dmxcwiQ1NGgL3c1NtgFk3d?=
 =?us-ascii?Q?btTSUXfAJlHenyI32UdmLwAXEcvdaW+qKEOC7lotiv4KKZKFc2zu9g4I9hE1?=
 =?us-ascii?Q?OK0Ldja9NqoljTQiH4ZTPmr3sdxCRD/LCX7Qk022lml5223f+fnyTcA7rwSs?=
 =?us-ascii?Q?ax+7FkrxSO160puKUDgYvI4OsAhrZ4aNTaO+nxI2Ryqr/mBl4mWnJ34Smkh5?=
 =?us-ascii?Q?VZ4noCdz50EyWDvt6aU4PU+Azp/VCr66KJWSkdSrM8bn7Qa7E1w899zMn6uC?=
 =?us-ascii?Q?P+1nHC5pHDbsy2Z6wop7xs4EF2q9TVb3kf4G2d05Z57rh6nJ0hMiOcC0jtb5?=
 =?us-ascii?Q?64eUWXhgCk/ux/o/T3E10XYhGeDrKy1lkA+MtswkXJs79sLZK+m7DB1dNRko?=
 =?us-ascii?Q?da4ofetga4Tn8qrt2UpSY3ZU7L+tTz/JhOfZ3LZSYSO+1HvTnO+xS7gQ7Iqz?=
 =?us-ascii?Q?njZAWtauRf2TwIzqeJZd8KVQ5U+joIeb/F4xkuukvKB1jj0PyEtgsjJmbdol?=
 =?us-ascii?Q?0hbNNCJLBwrTiF8ZjVEqDzGNVWzD41ArDnTdx6t9efHVY1sb3oW/YO0qVWvF?=
 =?us-ascii?Q?Q0zNPMOXZeN0H2byk1EmIEVrDCTHAE0UdBKsIjY/8KOxdm4NsaKDKjGtQ54Q?=
 =?us-ascii?Q?c5zlxGSIGL+XvhbNOTtB3AZUQIDymwFAq5IV0lQ4bIw0qvYpkIhqB36pf+ZB?=
 =?us-ascii?Q?6AjRQwMn7qAxXGUR4ccUY+t1V6JihiXRMjad/hrRv4zLlI8eF7fZSd8ycFve?=
 =?us-ascii?Q?I0aQSGOQi/Sn69lUQkUV480yi17MA0OUswYOFaVpHxQamba7OYEQKdO7hKE5?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6804789b-f86a-44c6-a259-08dde1756b88
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:14:19.0636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWiQ5Ln36tcEMtU32m9xM2PvskJOIQW0TolMSiBwOxlv/fa44YAaSi4h7+iHsZqG4RwA+GXXXs0Ta1qkQUrb8hf1GfCsXrTwM5fZOnaFFmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7725
X-Proofpoint-GUID: _44SQwIlUndCiTgop2JaFBaIrDv8cPwr
X-Authority-Analysis: v=2.4 cv=CoXmsn4D c=1 sm=1 tr=0 ts=68a85f1c cx=c_pps
 a=EhLtey9IgjUMM8ik5sEfyw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=puX-rZ3iWx3qy-NnaecA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDExNCBTYWx0ZWRfX46eVr1JLEB6x
 v15AzDfqnKGmkGl6ys5WzzvJKNofpCCNJfDS2+cavE3TqpxvvAbm01op4nI1C3oF8NGMA+cFbmU
 9TbSEo6Qu7PBsVcjug++c6KTC4g9bl8n+z/wQyktdVBOeTqfzyBr8+/Q+Xh4SjDinfdmdUT3L9z
 n2SCQD1w/0c30jqUfecT2mO/lGEg9+4OxVGwv44a6m4bhWExwEf1xzNmdjrThE/svmrBr602rLe
 YjSic/NFMmE1pRoftayqcCLgE0Mia8bg4Q6THetQFUjzQfp7jYsoy+lv/486d4jEiz1s5q5JKYg
 rP+TKnj552PlYS3//Fjc8OyyV7eaGWdVpojGcVwlRE1pAabmjWyhRBImaEcDFZebi/Dwbhq8H/Z
 yUx+fyyfh/hOpUW/ghtYeTGKtrYeFQ==
X-Proofpoint-ORIG-GUID: _44SQwIlUndCiTgop2JaFBaIrDv8cPwr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

All isapc machines must have 32-bit CPUs and so the RAM split logic can be hardcoded
accordingly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 58 ++++-------------------------------------------
 1 file changed, 4 insertions(+), 54 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 816124c027..fc94937ad4 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -444,69 +444,19 @@ static void pc_init_isa(MachineState *machine)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
-    ram_addr_t lowmem;
     uint64_t hole64_size = 0;
 
     /*
-     * Calculate ram split, for memory below and above 4G.  It's a bit
-     * complicated for backward compatibility reasons ...
-     *
-     *  - Traditional split is 3.5G (lowmem = 0xe0000000).  This is the
-     *    default value for max_ram_below_4g now.
-     *
-     *  - Then, to gigabyte align the memory, we move the split to 3G
-     *    (lowmem = 0xc0000000).  But only in case we have to split in
-     *    the first place, i.e. ram_size is larger than (traditional)
-     *    lowmem.  And for new machine types (gigabyte_align = true)
-     *    only, for live migration compatibility reasons.
-     *
-     *  - Next the max-ram-below-4g option was added, which allowed to
-     *    reduce lowmem to a smaller value, to allow a larger PCI I/O
-     *    window below 4G.  qemu doesn't enforce gigabyte alignment here,
-     *    but prints a warning.
-     *
-     *  - Finally max-ram-below-4g got updated to also allow raising lowmem,
-     *    so legacy non-PAE guests can get as much memory as possible in
-     *    the 32bit address space below 4G.
-     *
-     *  - Note that Xen has its own ram setup code in xen_ram_init(),
-     *    called via xen_hvm_init_pc().
-     *
-     * Examples:
-     *    qemu -M pc-1.7 -m 4G    (old default)    -> 3584M low,  512M high
-     *    qemu -M pc -m 4G        (new default)    -> 3072M low, 1024M high
-     *    qemu -M pc,max-ram-below-4g=2G -m 4G     -> 2048M low, 2048M high
-     *    qemu -M pc,max-ram-below-4g=4G -m 3968M  -> 3968M low (=4G-128M)
+     * There is no RAM split for the isapc machine
      */
     if (xen_enabled()) {
         xen_hvm_init_pc(pcms, &ram_memory);
     } else {
         ram_memory = machine->ram;
-        if (!pcms->max_ram_below_4g) {
-            pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
-        }
-        lowmem = pcms->max_ram_below_4g;
-        if (machine->ram_size >= pcms->max_ram_below_4g) {
-            if (pcmc->gigabyte_align) {
-                if (lowmem > 0xc0000000) {
-                    lowmem = 0xc0000000;
-                }
-                if (lowmem & (1 * GiB - 1)) {
-                    warn_report("Large machine and max_ram_below_4g "
-                                "(%" PRIu64 ") not a multiple of 1G; "
-                                "possible bad performance.",
-                                pcms->max_ram_below_4g);
-                }
-            }
-        }
 
-        if (machine->ram_size >= lowmem) {
-            x86ms->above_4g_mem_size = machine->ram_size - lowmem;
-            x86ms->below_4g_mem_size = lowmem;
-        } else {
-            x86ms->above_4g_mem_size = 0;
-            x86ms->below_4g_mem_size = machine->ram_size;
-        }
+        pcms->max_ram_below_4g = 4 * GiB;
+        x86ms->above_4g_mem_size = 0;
+        x86ms->below_4g_mem_size = machine->ram_size;
     }
 
     /*
-- 
2.43.0


