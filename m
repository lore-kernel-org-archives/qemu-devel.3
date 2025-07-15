Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC77BC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 14:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubh4A-0003HU-48; Tue, 15 Jul 2025 10:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubgTW-0004YU-U1; Tue, 15 Jul 2025 10:17:45 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubgTR-0002HA-QE; Tue, 15 Jul 2025 10:17:41 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FAT5tD011282;
 Tue, 15 Jul 2025 07:17:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=9P9QpVOQJ2yPORX
 HHWicEv2FfwjK5heVUkD4Or74G2E=; b=fIAhfEx8NZtBwU669RO8ycZheY0G7hu
 184IcupmagNQJ98MQrLIW3Yw865KFKkuoz7WSEP9yhWakR95ITW0dr5j4TkobzG2
 AdnTBj7eFXDdFP7lifx8REh3lJG2XQCZueDq1Ou4BRlH7j7S2O2dXe2OWQKcCd6H
 33OL6Y8oeDha5KcqlCx7EC7gaPchzDgZdwQtiPPiE/erq7/PyGM/Bf5yv+fHIv3+
 UZKCWPRlUqAE9xs90tBc1IMp6VWnZusTYwi9YX0WVXp4Ay5P4k+YnZjeahNPjVrD
 OqBSc850NVfWXGg7uuISZFuj3kfqOHyQjMGDYIPjDbnt+N4HeItJsAQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022115.outbound.protection.outlook.com [52.101.43.115])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47ukmapjab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 07:17:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lP1Ba5MPHu/WKI2e8ohpNHXmwS/sH6jkjk/NtNp/eXJiAflrzBGGu6xSqpa1g2QAD4IXnieiu9Tm+yvJQ6QLd7ntCzlNC4/nQLt7UNMNMkq1hpAWGN01/0E7BuUHp5d3MPOAL5dtmbXPo8iPmfvnHOYJshaXyP1oX+q1HM6lgO21YV63jD2hrGQ7Da9JixAxwYXATHlzVrESOVElpRyJx2eG6wRwJIlm0WPxcyTbbr/N/bQK6DXbjXS2jwvx8vm2TQJjeAkyGTF6QZT1nIVUNo7urNAop5L3nX/K/1S5Kui6qUBEesh80TpFuTVzg9FE5Jzl0TjZ6e0dNJvt0WUXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9P9QpVOQJ2yPORXHHWicEv2FfwjK5heVUkD4Or74G2E=;
 b=ogsWxOYrzAbWJEGBAjU68fQO3miIWO2AmyiPnvDk1O8ijx4feYfBUoSuvzyKFxYhszKAWJlDrJgcAIFfZ8FJATzlRZzmPrP8YUxn2pCTusOQsl0SyVOxTyEpdnjEU/3tLLXYaRx31WYW6QHyT3T7KjlbVXqQuPSQfZiTJ7WJqMr6A+Jz6UcKJ9pM+d+oGS//pEf/u+E6qfgqBe/Z98ADmeegRK1r6fAJaxYZI6zXhUpTaKGducO2777QXczzS0daViRGAZL+3K8z473wT2IQvBDYrbem14MzWSI1cCNwxGJNugarfdnc1ethpkqW7/H+umeRIouyuoxRKPfkotebAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P9QpVOQJ2yPORXHHWicEv2FfwjK5heVUkD4Or74G2E=;
 b=dbr9Eu2msFeS8Wrdc1AAunCqEAkl8NbxgIOJliFf/WJsu75cOx1SuWTLv3ijS0Gn5zkSJztyhD2qg1pxPVVjnWOruESjhVJDYrMxaxA4jgKjrMSTUbVgU4RxMGgfsiiParOfccf94ndia/FqY/BofuLwi+Odjr3nJhSUsZ+ukImJmIaL0gi5kzPKt7wYqQeDosO0aChypt2ulhfh4kyeUok6kuuU3WtlWU4+Cl4yfCbPWkyV7nIgDYmrpwT74IV7TcKzsrpuVhHQCSvuDgmQNwgCJtD3fSsjS2hAIINLJr6BKsjSz/AFbRCzbQ78OGgYa9H/MkisCgu0qhu3Gz1MVQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS0PR02MB10760.namprd02.prod.outlook.com (2603:10b6:8:1fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Tue, 15 Jul
 2025 14:17:12 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 14:17:12 +0000
Date: Tue, 15 Jul 2025 16:17:07 +0200
From: John Levon <john.levon@nutanix.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 thanos.makatos@nutanix.com, alex.williamson@redhat.com, clg@redhat.com,
 steven.sistare@oracle.com, tomitamoeko@gmail.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 20/22] vfio-user/pci.c: use QOM casts where appropriate
Message-ID: <aHZi46a-RRI29cxT@lent>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-21-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715093110.107317-21-mark.caveayland@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P189CA0052.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::21) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS0PR02MB10760:EE_
X-MS-Office365-Filtering-Correlation-Id: c2810e2e-f4a2-4fe7-7892-08ddc3aa4ae2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o/BaGx04Hi1D6XyUEaFS1aKYgTjC9HybjvQfNnGrkDdeZ/cZo70vGAvtoGrQ?=
 =?us-ascii?Q?nn6pHI/7H0xA3c0Yt6rMT912ndeOYShUMZEFglIVJgMaY8b9+XiUhL/FkZBb?=
 =?us-ascii?Q?I3WFfF2Ah4iOqnplkArzvs5txgL5PyYomKCmKMAZohi8VPrhHYmfh/E0eiad?=
 =?us-ascii?Q?76HixjyyJdKEnqYZ82lA+4oEqjTfPNh6NpU0eHwH7UNC3mAgWQj+Dzv+U7vN?=
 =?us-ascii?Q?L/dX+BCjnB18fzdLSFCnVqF3etGVr9JJiURPmP6O6rQ4d5iY9pQJ0uUkMlEw?=
 =?us-ascii?Q?oG3ZDKz389PPRbuvJhQiJUQMbTshT18vsGAkHnSuK/6x2wxso4XIeW/kuoKt?=
 =?us-ascii?Q?YIEZuRBFj/APpd23QcHnZKiET+nwSPVDauHeHBs33j4p6qlSSgMoCx88+OLS?=
 =?us-ascii?Q?Fa6twh3Lciu3oIhQx40xhHbtrt8dujv3wGTOQfc5kCTclsjOOVzhdM6AVDUg?=
 =?us-ascii?Q?Y1wRcbaSy1sv1vB44okabMXLB71xQNwtLUCTBk3pJch/AFgDWakX6KLOSpm+?=
 =?us-ascii?Q?kZeDvP83RX1yp+ftes/EwekTs5ms18JRDDtvGv4mi2Bj+t4T+OLfjOSdMUvs?=
 =?us-ascii?Q?UmUKieII5oTG+Z/BXv20iasLNLcPG0GFle3j3+RgEO5lcHs1FqKB9hF41mk2?=
 =?us-ascii?Q?TFaTeVyd/3SwUUH28phE6+aPCqEzlbrMsoasnqC0ZgzL3RKmteamdfTRe/w5?=
 =?us-ascii?Q?/ro0v47mWs270ojJWX18IgrQsRmm7GD9BUXWGE07ioIC/3YESdLo53RGDKoX?=
 =?us-ascii?Q?TJ2FufCJ0xAQJmtHuxbRqHLVfHbZD0+/NuZ1D27C3VRmU3CRYPgvAD/9+xsa?=
 =?us-ascii?Q?vtF5Zl60uW9XoboieY84r9/zL4UffJRy58YUbkOfguA2nRyOMfhAhR3Ak2fY?=
 =?us-ascii?Q?SAQgs8I4jKrEjMbkV2xWZQz1m8hta6FGCKjVzKQSRPR5rA/adQoQWJk14jXf?=
 =?us-ascii?Q?Zi86OvPJVWqXKMFcLQC4u+/qG2rJGW3WK4Kn/yb4CDMyq8VLvP1JC55CeGbf?=
 =?us-ascii?Q?2aN88xGVTLAUYPDN7TqWBOMyUGr/Wuon6xJgMZGMAO1oTBtWPsR8sRv2b65K?=
 =?us-ascii?Q?98Q2PAOryIuPQuIb/ZoUpQoD+9IW1JXzi0alxqCtn18rVZL4U9n/A5O6BZaH?=
 =?us-ascii?Q?9fU5zcyxznPbDinoyd3jkS5LHGJwi7u8ePCIezNMKfSMjhauPAQgrDearIRJ?=
 =?us-ascii?Q?JW+lGSkeAfklT4jnIzJw1d48muv5tEvYo/Fz/jcvxrQ5CSBKrK7D46iUOAYW?=
 =?us-ascii?Q?HlWXUmo0XqJZU5mQaQfjHkGwoC0FNLvpyHYZCGHP8sedn4Pqx0VNVGmwJOV9?=
 =?us-ascii?Q?45yl0tgedAjGqTyJ2Veo1IP1viRHW1t+KoJJgbzOGETMtDq5oPeY5PnikuwH?=
 =?us-ascii?Q?quE/Ve96/Xo8d1G/8aQOoPPdObmVKNEZo1HwO9DDDSuvubUxl7j/rSqR6Jpi?=
 =?us-ascii?Q?35JgSAPA8pI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GhFWTURhE8sOaDmqZGl4BKeA8ZMYQFXzPL7Jw1Sf7uZ8Yy5QcJPYGGMrco3u?=
 =?us-ascii?Q?auyPKSaojHW9AArB4D056c9pfGUHdhr1cPjez/Bs4xSfxiDYkT0zHqbDaZxH?=
 =?us-ascii?Q?5J3LS1LerUV+vfBgpMe//90nebzeyulGCf2+0A4amPbCyEmTrfNwiJ5ELiIE?=
 =?us-ascii?Q?ClosibfAEojKSmhE9xRZkdJqWU+a+cDyrugbth+lbwLA0k3uKmKikrK2LECk?=
 =?us-ascii?Q?Y2iA3XEGMVlUBeQ1pEwywZltadTHzVIRfpf0tXuWj+wesgbJvnIM5kYOnyLC?=
 =?us-ascii?Q?asV2gQ00DTt4+JNn+r7vqhnHdmoP2W57xdT3nTpY1ZustuVcYJU3HT03VEuI?=
 =?us-ascii?Q?jxqgQSmq1jfJYD2eDkLznRLdUHFbVexHO0q6pglGNzT/1sjib84lwDJ+gtgc?=
 =?us-ascii?Q?fIyzXotQTyn1vHlU+fxZ4MPYpQSS0+OLkfGUx+dajTIy+NkNmkGnqYTpAk5G?=
 =?us-ascii?Q?cW9hGygaRekDICW4fdLmde5ifEHh0KsIf664IgsjBfugNojKqifiZsMzsncc?=
 =?us-ascii?Q?4nN6MdQoAN6Xi5wd8oGt0vRfhuzJqmtosFpwFucqxbVpCel64czpwh17+kEm?=
 =?us-ascii?Q?XgMXNUv+JuU6Xj1InHoX0AEuGv/yp+bnwShvxpbSZdJvajs0bk9iFJi5hCPW?=
 =?us-ascii?Q?8/KkrxDzi3Cdj/uADMOOVMBdNbXh2fkJSDj7FzUC8k2aEY9biYSRuddXcBR9?=
 =?us-ascii?Q?uM+Nm3/sM6TlEZ5gy/AblsNDTH54liSy3//ZjdwVusGzPvfut0MhH10ufKIB?=
 =?us-ascii?Q?TEV9G3WhwbR/Wiag0KEcV5rD0VMorwNcH8iNeiZ+bH2CTk0GuUEgJ24Rvo48?=
 =?us-ascii?Q?CR1TK74nC+IJ9NQ56MuqzoolSMiGJFlU4lKvsXg1KKRLBouQA3RxuamIGg8H?=
 =?us-ascii?Q?xV6LTLQMgJaDeAaUT8g4LEkGY/BAIXHRR0Au9THGwIUvFc2c7PMKPVPOZzZx?=
 =?us-ascii?Q?H1220W5/Ywy5v4fyZo2rcq+rTaOTDtvzozNK1tiIgHS+wzXAljW4P5RklQwV?=
 =?us-ascii?Q?Os/6mlGSPcmOkFwmwEjcLIX+pLonb+HN098T92TraRxhTaJ91WeG2MQ43786?=
 =?us-ascii?Q?ELb98OX+WuKrRjq7kposHzl3c4y8QmmUgQC44Xjmx0nF0pIV/YFLeHlYrWP+?=
 =?us-ascii?Q?tBJ+/uke2gp1EEcYnCJ77sWQzmPlLa5q32/NYf+OZGv4V5tSxAPpa/hq8gkq?=
 =?us-ascii?Q?A2J40yfkAv2mPHUO0WCWecsajV6ZEegIYk0xR9sYlA6IweI3lHLTSARswQRr?=
 =?us-ascii?Q?VqhgPFBdHYqZJuayehzFAGFv1ptiJRGht+FzizNKuxxjFPtUencrbzxMDlLW?=
 =?us-ascii?Q?b6Hf2B5n2RC0QQynPsZiaLUJvQ03XRmpgnNX88HNgNIUjkhagkoMuanMeSPA?=
 =?us-ascii?Q?MP9CPudXUWLWBUJWTicLiKEs5AxB/JM1yGgzxYUAsITTkGRsZ+fZIk9n1QrW?=
 =?us-ascii?Q?Rw1oUiKnNddTj4NRi1N1EgYtzg3wLm8xEn4g3vjCR/bP6WEbXkiLI07pqIO7?=
 =?us-ascii?Q?vZfmTBB22GiX/lWyZqQa3mrBtkh604ofOg6ZIVCNd0vWy8UtUlRVme1ft9m6?=
 =?us-ascii?Q?izb5AT7kvEZalQJJh5hk2jitt7SM1USMOy0X6WgstS6bIwSDA7MFt2pQjX46?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2810e2e-f4a2-4fe7-7892-08ddc3aa4ae2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 14:17:12.6229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hT4wcr12s1XHa95rjCLxynqSVudhrXve7BZUk9jj1zXnDRvq1tlVJOitqQIpyt25t6U0dUhtfWcysQz0y1hMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10760
X-Proofpoint-ORIG-GUID: CaDKuouKu5zrPoktysg0AsIAwsyqk8A9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDEzMSBTYWx0ZWRfX10fpBG8HxQPI
 oaDEjtq6ObAqOr1gKrIaSt8QK3QDO7YUNbojYqyd6Od3O82krfepQSXrZUpusYj08F5WvDDjzHP
 JOR2IoBmXrafCl2XL2b8qb4B20hSe+93+QidbVhAdgOn6IUuBZjunUVTGWdDNAkqVEj1PBTrPE9
 eECk41oHZDMEaNFa35Osi1gGI8g55FIHxWGxAI46Lbv3GjFnKtKPw1/yw7Ry4w/hFTjIC5TS8Gp
 PrX6GxJAICkSoAJDobBGLSu137+M2Ij2gpwiQ7si/IQrNsWvzIXQfEIJGn0fYXuBO09K3q/L4Kw
 9cN5wf380LAkuFhDsKgAKsOIqn9u4vP4fbOfiEj2L4w1b3Iuc0ZdHicXm8RBqdsR514R+iMWNlx
 tFZ873mHNZyBI4hmhqU80KpqDj8qoVOEWZjE0qjKUsW3dwGM7kSiv0j4A/G7KO0sdepA9Hce
X-Proofpoint-GUID: CaDKuouKu5zrPoktysg0AsIAwsyqk8A9
X-Authority-Analysis: v=2.4 cv=UcVRSLSN c=1 sm=1 tr=0 ts=687662f8 cx=c_pps
 a=Ta6zJQCUzi71fP58ADEmYA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=IK-tqZucCzuqFRcn4SUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On Tue, Jul 15, 2025 at 10:26:00AM +0100, Mark Cave-Ayland wrote:

> Use QOM casts to convert between VFIOPCIDevice and PCIDevice instead of
> accessing pdev directly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/vfio-user/pci.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
> index 9380766548..25a1dc0529 100644
> --- a/hw/vfio-user/pci.c
> +++ b/hw/vfio-user/pci.c
> @@ -65,7 +65,7 @@ static void vfio_user_msix_setup(VFIOPCIDevice *vdev)
>      vdev->msix->pba_region = pba_reg;
>  
>      vfio_reg = vdev->bars[vdev->msix->pba_bar].mr;
> -    msix_reg = &vdev->pdev.msix_pba_mmio;
> +    msix_reg = &PCI_DEVICE(vdev)->msix_pba_mmio;
>      memory_region_init_io(pba_reg, OBJECT(vdev), &vfio_user_pba_ops, vdev,
>                            "VFIO MSIX PBA", int128_get64(msix_reg->size));
>      memory_region_add_subregion_overlap(vfio_reg, vdev->msix->pba_offset,
> @@ -86,7 +86,7 @@ static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
>  
>  static void vfio_user_dma_read(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
>  {
> -    PCIDevice *pdev = &vdev->pdev;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>      VFIOUserProxy *proxy = vdev->vbasedev.proxy;
>      VFIOUserDMARW *res;
>      MemTxResult r;
> @@ -134,7 +134,7 @@ static void vfio_user_dma_read(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
>  
>  static void vfio_user_dma_write(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
>  {
> -    PCIDevice *pdev = &vdev->pdev;
> +    PCIDevice *pdev = PCI_DEVICE(vdev);
>      VFIOUserProxy *proxy = vdev->vbasedev.proxy;
>      MemTxResult r;
>  

Reviewed-by: John Levon <john.levon@nutanix.com>


