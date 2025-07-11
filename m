Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85EDC83F22
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAWu-00068b-R8; Fri, 11 Jul 2025 05:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWs-00064V-6n
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:58:54 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWq-0004qb-Cb
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:58:53 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B76bqB025499;
 Fri, 11 Jul 2025 02:58:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=39a61ttw/5umG2hAm3Vs2Bra93sIZ0MTERbxhQtXT
 NY=; b=KpHVzAoMwQ/Bg+zslM1wNFAeJq/BaHsOwJ4RAyBP+8u45N2VGL80pGDFK
 VlSzYkTLxaA58huKgrXYiynoHrdrRpwUzK72J+3GSK7Ar3xNk0CJzz17fNhGzbT1
 4KR84HXZdhGTvsecIpe3Zv/SvNZKT9q2wM03x1pyDH7439tygQextRC2Z3vlCvtB
 GIsvzR65WRn62RklevMBAF7/AE7RhZJG+Fx1pQ8PDA8s0gnGfqbONtgCaFh8/MK8
 DWQOv15SCsPrKbiBNxWaJz5i5pkKTQVI0kOgfRHY8ShAa/LUvBtreBPKF7xZY6qf
 yYYOAODH4RJfjHSa00EeGD1w3Lg+g==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023106.outbound.protection.outlook.com
 [40.93.201.106])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47q3cf118p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 02:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pS2slKbXbRak52LqX3SdR+tpgSHRyzscf5YqvJrZVPIV4kGINIBiKUjLIrKMmrYUKX5SGjk0JUsGbluwjEUIZRAqQZZcV2pJtTgMdecexV/aGJpNrL5ovAOJkZKGSCvrtE/osNAf8eBGm+eJoe6WJpFugXnTE26XHSFSZSpMKELQDdZHD+RcZzfVJ5EVQjeBEMF+pXgD2O0EAXHobUrzykij0/qGrk3+6Rr8zZ3X7ocN1Y/0LrP0uVZRBgqH3Hp8k4OgbZWbqYJ7kAJLo71ZcrQ3qy4+lXfoLGv7SF+dVRNIt8/qzR3e3Tlw3Mx9b7AAVfTQY1OCkLEg+8B+gRGMAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39a61ttw/5umG2hAm3Vs2Bra93sIZ0MTERbxhQtXTNY=;
 b=URkYlTXFM8VZOyWr5B4oC4Va3SZHyis/lEvj7sHlYabGkSWAK3gqvAPmjxmJvYHJZV6Fa88FiNiNtBnudRKR55n6Nlz4rNF/CeEgWjcFBYMg32SX+g0vXSBJnfikBmudkQSzi4urL7Mb+OLfYc/dR3kvuAYN3vSqdRtGu1sMW55IaSihggt+wt2g/41ixtb4XbdfAtKksBdkZ1pyLQKLFeKZU3rz70a3kVIvzaJUo+pBt1i2ihA61XkbsT+NnuIDY9YktJ2YWxA2yDWEm8dWoYKTKIHwxw77SHkX5PUFgrXXsUFOZleAAUeGLuOTpx0bZ0sM3VozuqZ+pgpY/Fjyvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39a61ttw/5umG2hAm3Vs2Bra93sIZ0MTERbxhQtXTNY=;
 b=WeC0r0iYSanGXBg1LmzIOTZkr21KvDptgvWEziPpto+bBGPyA+9ifNSLfjsIKElN+e6XoXwlcM+W1pyDslrrvKZhood5EpHLuDSmWTrKBSqC7rCuqOaovJbqWE/FlEgrrUgAqUfS5TUTAYNMAJVY9vfJUL96TuiJM4SQFW3VhAvMcosW3o+kQATBH8RlK8LvIDZy4DtI+v9/7rENo9EiKJIwzWNgU+JjQua98wUbazpTemoja2OUDYT0PoAEl0leJ037H6G+m2wV0AnsNWNoPh5W9AYqSti+mP1YY05WA+rWR5LHDf07K04QQyynCKx/+CxxqoZcLI8Jifq83RypnA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH4PR02MB10681.namprd02.prod.outlook.com (2603:10b6:610:246::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 11 Jul
 2025 09:58:48 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 09:58:48 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 09/19] hw/i386/pc_piix.c: simplify RAM size logic in
 pc_init_isa()
Date: Fri, 11 Jul 2025 10:57:11 +0100
Message-ID: <20250711095812.543857-10-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711095812.543857-1-mark.caveayland@nutanix.com>
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0278.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH4PR02MB10681:EE_
X-MS-Office365-Filtering-Correlation-Id: d068cabc-fe29-45c5-d02c-08ddc061880a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WrtKnrtwmY8nd6+oMkE8wsNU77nezWuc4+n8svnHdxgz+mjE53ysQys8bW8G?=
 =?us-ascii?Q?iDRtU6KSg+P1bLDmrHB9jGjOgo/BY1M0ULWhRBFbi8rNSBlOpXIGRHFWIEEM?=
 =?us-ascii?Q?gyvmTYb/fDSEHIbZlo2exmyWXt9MPWf/Na31PfFysu990oLtrjIhHhw3sX89?=
 =?us-ascii?Q?jkrjVgUswg51jfJS1cK/Z/grDXUpF7hWVL4m7DGXi/Ef9RrSAfmzPjK/XP9h?=
 =?us-ascii?Q?cGaZ6jiQmvATb2KbzKuFsJCsuoWPVf2Hy3siX611y7Y1Pau6kjfkUE0qI4aM?=
 =?us-ascii?Q?+9GkSVEXknVUhusgqLj4iUXEGamf4QrzvL5/UkqBh6rXI0IbCqtD8JvIcCH3?=
 =?us-ascii?Q?Mm4LfLJordPNf6mWSehTpMbMd75FqBcunuDIvPTor5Y9GwB+eFYfjhq6ct5v?=
 =?us-ascii?Q?qhjPYmGOdUUQ+0qOEBD+K4EorAW8CFIjThe36Y0Tx6RP/sWcx5W5mBGFE4fy?=
 =?us-ascii?Q?C+7beW2XiFxuHMXmF5v2LE//YcG63LY+cDnFm31cXqBQuHBTcZYMNums8Sn0?=
 =?us-ascii?Q?DJmzWOYi7Gg7leuAJoqwzBjpE1lG+heNn1aylTCoz66q7QVr9AwkpzrAsUZR?=
 =?us-ascii?Q?O/MY6fSXHrSarIiuktVd5cF+iryQfjPw9l+9hhzBTFxVamxbesHZ9QB8LCAq?=
 =?us-ascii?Q?fJoJS3ChkebVpPgFAQ0KsUfSgAlmpUsv9Vut8gcFzQQsDxzUuAGF0UrHnv0I?=
 =?us-ascii?Q?RmAN5cEytdoIig6WuFdoP/O2J8Lq6R2F6nB3uteH8zR/d8NjgwMDai0/jawY?=
 =?us-ascii?Q?/jLi4v1Q/6Uvf6Y2ylFbvg8qP4fyzpM5PMu1QMOlx8Aw4VZ6Kq04/7o+Y7OW?=
 =?us-ascii?Q?clL3+n6I2ujxfdC/dNuxwpCcQ61yNVYW6/DPb7MHcnbnb/cOBsceMnfzJmdR?=
 =?us-ascii?Q?RzZDHzAX98g2rInCprtDvpIJSW28t8/OPera2j9AYN6JJIMCy8h1FvaiOUxZ?=
 =?us-ascii?Q?h6s+gMTZoaKtvayolbEjGHjqJycA7j7RNUD2LD3Ax1MsJrXtrSO7mdnWaHpI?=
 =?us-ascii?Q?OsIgxO8TYuzOulecHP4uR4zOOsXVm7WgVrd+CZPv/uPATBDH6BTp/eXn8mkp?=
 =?us-ascii?Q?wJB1UWxS8S8Q09VinWr4ltlhVs2D/IGCigT2OiYtv1T7voYuzQiUTvrtZVRg?=
 =?us-ascii?Q?rRZVo5c6hehFUuiFhs5Q9uTd/8h+v8K2iMpgc3dDUoszauuLVS1sCa+MKDTy?=
 =?us-ascii?Q?CthgDS3DZgaGJSnUi/gJcvUduBXO/3vxSVEV8j2K9Bmq6WRBFd7C4Tv46D0U?=
 =?us-ascii?Q?u5BX0ErUI1c70WZCCIayKwngyimET1SgRtMsQOa24TAowq+CX3PNkTUFkbqf?=
 =?us-ascii?Q?WCKQg52ocvifc30ldlqNgagksIA6/rKX69oYdsNNSqYg2JnqnPPAxYtTGnPe?=
 =?us-ascii?Q?RjsWSdiMrNB5sQgMxHMA88E6QKXCBgdRDv9/O9F9SPYupmrNKvCyrCniW58y?=
 =?us-ascii?Q?8BDlxQcKkHw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bmqOnRCN7HN9CHAUlsL257w6P7ljPby9hcQneu/+FWPzfEOtKWnFeK23uKTh?=
 =?us-ascii?Q?ZtXI8t+kLAcO2KMZunSYb0GNDFJVU2imse6alwNJxCaZaYG7yaE9GSDwRVI9?=
 =?us-ascii?Q?XkbLFp5hLaiJW4yE6qftKrcaSxafm9X9FJUkCSfU95pWpcmY+TO0BZhGicxd?=
 =?us-ascii?Q?Vln9cM2GFozliVABm2NF0ZLydWK96gVb43uW1w97AxUXQ4JpDNAfow5CUJhM?=
 =?us-ascii?Q?twH1LoUOba0V6cTfZN/uaSOP0hvPvGFCfatkGvSCCSgXkGd8JenymZeyuWSP?=
 =?us-ascii?Q?tuJWpzuYC/KXH1gf8PKU11PQNm1b/LiVm2Y5TIxonlD1gv0mZ+6NR7wxGqTu?=
 =?us-ascii?Q?BuwZgY0w/41EuIAgEh0985DUkDO3XpM9/RI8aDV8BYjcIdq1QxnZk6pz2yJv?=
 =?us-ascii?Q?7qj+81ts9qwo1Y0S3fdS08mWLI/ILbwlhAuor2cXRKMn8QuSk1P7iMs1wrES?=
 =?us-ascii?Q?+rG2y7d6YZHk5x6452GS//QFgCXMGjrgpwmkq7LW2DrAcFRjGXTkd7cz/oRt?=
 =?us-ascii?Q?AvGjj/zUD4nLPbrGUYcNIbQ4wEztfq0B6L5qVk7V8G0t7hhJSn3y+Wh+CjZg?=
 =?us-ascii?Q?06lJY5ejfd/GUEEZVfXpFFodjDtYdgGrvAwwAcWMKSd0AQ201RHZuksOtP33?=
 =?us-ascii?Q?6efwN/rjMc2xMnJn0Cs/1QLEFS2yogbk1hBnueC9Z5Mwkp8jT9M3aEkOl/TD?=
 =?us-ascii?Q?c9JO3tW4+7FDs8LpmWfaB3GBLXMfpz5pZlWYwPHAUgQmn4j8hUWtyYsPozfy?=
 =?us-ascii?Q?2ZpqsIKq4fx8Mb0c9G39onF+W9XaVbHKaQsUPKUwjehNWgXWrsi061wFzHSu?=
 =?us-ascii?Q?kCzQMhBU6UWdKA3Eoz7icNUihlKlTc+9NgDkwhMN+mCcqo1MHo9SgQBgd4ou?=
 =?us-ascii?Q?MFzrI0+aEDnwb3ibtjGMezgkuhHA1nZdycouecSNn9CCAjY2a+fzRQhTYcjy?=
 =?us-ascii?Q?5scfkSgKVpe/D8+PJF9TCEc8tgGaSKZcObCAWkyHWNg2vVBiqHFv8UMUumYJ?=
 =?us-ascii?Q?fC3XHZxmJSJ+T7HzqKOAIhLF5gff7e2e2Y/bvM1rmj/PeoR4joEiRBKP5TMp?=
 =?us-ascii?Q?NARAz8Co6KsiqzOSpgGYrVigeM0SMwE0Oq8CIPIs57utVczOFdph9nTEIyaE?=
 =?us-ascii?Q?K8ybrwQ51/QWNKZj8bV9ft9wCX0/rm2SH4bBBdNgpdaznWvvGmuj56BmI2Fk?=
 =?us-ascii?Q?co6T9U7bFA2SH2xYCt+yQcbs/R4llQviit8xQi8qdgepEmFz5mi0VLMUyQoG?=
 =?us-ascii?Q?wFRhlHKfqQwmelEJRxUeUd5lHWw7fcwG46fD4xf58XZwqRk/FLUEMVsBrQeH?=
 =?us-ascii?Q?Gen9ZFc7lNi8IDsPWPFr/fjQkCzzQY3C0SXCCPqxp/HbbZdP6D23lG9pMOKL?=
 =?us-ascii?Q?IpW8WDC2wwA3QGt17NpeDs6jRGr/4vjvyFtd+9dVisVTJxj3EloU5V5K3V3E?=
 =?us-ascii?Q?Orx0Tn0MkQ+20VnbAuZqaW2dZbeN1sZXDVbLfMTSOrCd8ggyckVOVbQtmy1y?=
 =?us-ascii?Q?dXE170nSc1s9zkYArc8u58sdUpSVQQasmUC0YKUWl1dtfPSi5/EI0yzK433C?=
 =?us-ascii?Q?HzZH2jcN6anA40BUrsrNUjyHynenTbmGxzU5OkkBl192W85yL5/Zb4h6iMK4?=
 =?us-ascii?Q?1bgBEr52NmWDEK2XzHvYILXWYr/R8zZgadk/nWKV35FykWjR17GWr8tY1bix?=
 =?us-ascii?Q?A2RoLg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d068cabc-fe29-45c5-d02c-08ddc061880a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:58:48.5226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfGf5feDEifsrgN9cwOnduA7azrH/MTfmi5c6+NrjjW9i00l6yLopHf7q3k8fwkN7Y7d4Q719BT0eSrC4yqA2WyvB5KEGS1ZoBQGJzX3guA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10681
X-Authority-Analysis: v=2.4 cv=U9SSDfru c=1 sm=1 tr=0 ts=6870e05a cx=c_pps
 a=h/zdu8LGojurgwVeJVxNZw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=puX-rZ3iWx3qy-NnaecA:9
X-Proofpoint-ORIG-GUID: nLm1mFOz5xNA07hMD9rSmDz_G73segRo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MCBTYWx0ZWRfX5fwQm0jfwOmb
 0c/+bhXUbOm1KrwpfFsnEBB7drwT3nUyslDxci7v/tUelXFgSafIwlYJARr3Knp36McP2prkMP9
 qiu6qYLG1g3w8L+6YjFRJbJ0MJZBsxNPko6K6YHYer2GNSh/0S3Nav36xrszkBXT0KaaI6v1dB6
 jNTivWxZkvVBvmEeiiVHY8al3mju2dcyKz4wpUEYvm1SMgqk00suNNsLQ0EXdEbhrAT7Fj6etKx
 si7XlGrGkBeLmyJELswMxR2F7QYK8gW3ODKaH5uCcoD5SH6ZNmSK02psPrRPBHTv7vZ1dTDu0NK
 pwbdgBNlKYlT93uzwKqeDED4+ZjMWA7qBU9dx5cXcVEpfik1JpbTr+xoCMeSd4EmFisqtt9v2kt
 a4vFMX2BmVVXsthc6azwaFCqf3ysHYuU4nlOWgNo/bOY/CS5qbSdc2f7p83c+qodRB1cQ3na
X-Proofpoint-GUID: nLm1mFOz5xNA07hMD9rSmDz_G73segRo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

All isapc machines must have 32-bit CPUs and so the RAM split logic can be hardcoded
accordingly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 58 ++++-------------------------------------------
 1 file changed, 4 insertions(+), 54 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 78f50a7893..fbd9500061 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -426,69 +426,19 @@ static void pc_init_isa(MachineState *machine)
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
+        pcms->max_ram_below_4g = 0xe0000000; /* default: 3.5G */
+        x86ms->above_4g_mem_size = 0;
+        x86ms->below_4g_mem_size = machine->ram_size;
     }
 
     /*
-- 
2.43.0


