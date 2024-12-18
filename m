Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C6DE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 17:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNxZt-0003iH-Fc; Wed, 18 Dec 2024 12:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.mackay@oracle.com>)
 id 1tNxZq-0003hZ-Vw
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:11:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.mackay@oracle.com>)
 id 1tNxZl-0004Hd-IY
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:11:14 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIGtrjm019612;
 Wed, 18 Dec 2024 17:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=63h3vhWRvKhjQOeP5T340kECp4MuBjcmOC9K7fbPtTY=; b=
 LNQdcZmnnozqTGZkA2N4Dw48NcYQTaOD1j7XZipMwOnOjg1H0ta0ZZRbClh6K33g
 LJpxSV/ZevQ5x08j3Dw1AOVzWC/QLMWsofMMphXE9UHinSqnuj6KldinEn2xDj4C
 SbBTf2LOv+k7WnAGItOPJ5/CrIvVWu8j6pob8DIgIfF1lawxA9DKcXBL0yTPCa5c
 4Om8IltGSIZTIVthOxDF1MefETObzQVQ7UxKePhXy7anEIuwDYTyJeZQpUy3SirT
 cwaXQUyxyqWaXEpBtkEFipEyrEEzIdxNpMGV+yq6kPp4/a8HyHo8EpXjzw27p8pA
 4MaX2/g7k9xE27opkoq/+w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0ec94bu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 17:11:05 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BIGdM3N018408; Wed, 18 Dec 2024 17:11:04 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0fab80a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 17:11:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PteZHYBvDOHy6WlN1h55ZdysfoDr2b3uM9ASHXRN2tRE5MKozqEMFpG8aRdWEciK1+uOqZPLiF0v7yGxdUixFV4FvuJwxUfpx+5LI3vIzaDld9gfO2DxvyCKBByC204e06mQohD5THmpw0+iZ6jz6n6ca1g/KyQKocJGlyust7dao648anp5B1WKx2qUyqI1xn7Fz5h+kmLyCYqkxqhTFHst/zgi07eYPRAN+Eb30hK8ZjFSlF+E0Pw8cuAsqdKCl6Bd/kEndyVojZR1+CRJ3uOGfsTzKap2gheTMwIghrpMk/Q1JSf5q/pVeCPavguCcth7pYdDAPLN5Ugna/GuVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63h3vhWRvKhjQOeP5T340kECp4MuBjcmOC9K7fbPtTY=;
 b=emGC9U8YQurqQ6hjJFZKrvefvAtj4R8w1Clvl54no7LUpDciz4fbuBKcQ807822KL9xlghBMavJKdrIQKFvCR1+HFTHhxse3u/gn4OxrWXZkWpdgTpDUDNH3xEYxuoFu81qoX63sjxtotOW8sHSndD2gzravi0ewrfTjcIM10qmHg8OXC54r5Oj0M1h4RUm0pDaG3/8SMYgbwd1vWpbftsZTjtp8t0zGYLcnt4W0ZhCLLzyGCYrBOYcv5Rmhe39ZtsAonsrSwfLJmKL0eCVhxvSJdJBnHIWxmaGnuJGLo2QaeHZAHZwSc6zXoFlp26faW64CPoz0SUKjF6AF8b3cfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63h3vhWRvKhjQOeP5T340kECp4MuBjcmOC9K7fbPtTY=;
 b=z3C0KRbnXH8NrZvGga9gaPd4ZBirNSbMReMvztbnpzMH2wLs16NitouB6M0mYaygdOQ5bGrcqUcXdngNzfBrEVbdLgJm7ezuLCfvpF1VsB8rTR7hcLG2URBDWkd0NrMT+4FrjtPixsG+zhi/ZQ0oBtmLVcASnSlAnLdXthNxvSA=
Received: from MN2PR10MB4269.namprd10.prod.outlook.com (2603:10b6:208:1d1::8)
 by CY5PR10MB6094.namprd10.prod.outlook.com (2603:10b6:930:39::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 17:11:02 +0000
Received: from MN2PR10MB4269.namprd10.prod.outlook.com
 ([fe80::f430:b41f:d4c4:9f9]) by MN2PR10MB4269.namprd10.prod.outlook.com
 ([fe80::f430:b41f:d4c4:9f9%7]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 17:11:02 +0000
From: Eric Mackay <eric.mackay@oracle.com>
To: imammedo@redhat.com
Cc: anisinha@redhat.com, eric.mackay@oracle.com, mst@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 0/3] cpuhp: ensure that cpu hotremove works the 1st time
Date: Wed, 18 Dec 2024 09:10:53 -0800
Message-ID: <20241218171053.5723-1-eric.mackay@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210163945.3422623-1-imammedo@redhat.com>
References: <20241210163945.3422623-1-imammedo@redhat.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0878.namprd03.prod.outlook.com
 (2603:10b6:408:13c::13) To MN2PR10MB4269.namprd10.prod.outlook.com
 (2603:10b6:208:1d1::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4269:EE_|CY5PR10MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: 6581100e-e2dc-44c4-0721-08dd1f86f35d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NfVwzm5GctQPnnHbRgogROiD1Ob5dXRiPwyry8giRXpkpjNKfNOhs1zrvN98?=
 =?us-ascii?Q?jkvvSFRvwhNKlcgvA6qdftI43u+n3XloyvkTjCGydqXhkMLihxqhkG10EBE6?=
 =?us-ascii?Q?UPeB7FGBFx8ncqEjqHV2ORKVY6DHgoH6Z1J2vmgEgkssMn16vkRKFFqEfA7K?=
 =?us-ascii?Q?/vdAPbGXLcoa7/Lc1xCIJDqBUWSWQhfKwvo4NPWP1TrkHvFKX47fyGmRWSbQ?=
 =?us-ascii?Q?r9uYIyEOhSIjuj8/FszATuy37HYBsaOsJc1xPP+zV+VPTHxX89+8kztVwJ9i?=
 =?us-ascii?Q?wH20PQ5FShy6GSH2OKYqE22oZIB6LhARl8JVe1prp09eHNKXt0C89TV0HZcE?=
 =?us-ascii?Q?XnZhjbtPE/ziczakgiXDte5uAWrh1JR8334503xQ7mBKtOovwPRrE1yRmBO9?=
 =?us-ascii?Q?Vtz189WAHfNylJwx7RzpeQpUS4FnUZJ6ee3QZAA351hs+D5MhJVWXRZLGckp?=
 =?us-ascii?Q?y+aFlW6ddrOmShcgMwtW75Q6mkkkB9FhzAOgajGHr0lRG+tkG6ZB+fkSWJVI?=
 =?us-ascii?Q?XoQRv5VZYBUDoOFm6QBigAV9uDjTa5mCqnkNxzuv9oDo+LM3wziVK+vG4KiQ?=
 =?us-ascii?Q?R01hPxsneBQ+NpODE8OygHjS2JSuj7fr3GqVkPt6Fk2yKPHBWqyVdB5RMJtE?=
 =?us-ascii?Q?miHYt6AeUD7RAXPRGAVikf4Z4BIELQEpZzfvUcO3V7bHC8uZd7vwkmN94fqE?=
 =?us-ascii?Q?QnSNN6OepKdkhyFKRaoh4LzIeMZSyxOxHYm/7cXXrQjU5FeZZlU5DwCyzU2z?=
 =?us-ascii?Q?TQ2U7VpS71Ilq36ps4GUS+2vvD3drG2HpGpX7Fmbw5k5NY05nw55RIVluRZf?=
 =?us-ascii?Q?HSV4oyaEux73nk+a+zu9ID3lNzhI5l0uHrXKX0xS9vol7bbIaC9k/1n/GSrv?=
 =?us-ascii?Q?AiI6y8nVAS6obFjxS3/UZkuZ7vClIf+vK3KtAyGL5u+jtiGaRqi1Bsg6VX1z?=
 =?us-ascii?Q?e1c1jkmJCdBN5LUVEJ2/sNpY91kXXYgpY5J4pSCTFujk/oNUWgbo3/RVggsK?=
 =?us-ascii?Q?kIast7lHSZ0urOZVasCHBTNMbF74O1uHEGv7Vb/SnlSa/sIV6CDaU7RLcnCg?=
 =?us-ascii?Q?SNJ2aZtZwocbPWiVJ/VYbPvh82LXUoVADL8E7rmeAq14xJIOsMyMewUDwXGR?=
 =?us-ascii?Q?/64f+55BhlnN1V06UrbPVdjVZIv4k1pXGDCKNTgrsfMACl8jpkPo6/SqxJo1?=
 =?us-ascii?Q?WIcBHdktxNkoRtraWeczXNnLg7Zte24m+dHCg5udyXO+y4h61FYYNHoHC5kV?=
 =?us-ascii?Q?IOyB8u4+CYlzJ2gpKD4iwe68Nzc+80huNZAIwDO8+x78dZy04l77agvfWPUK?=
 =?us-ascii?Q?BWHvAR/9Ttmtbd6rGUTT9uQvdzLlZgMgekV0xUu5SEm18nta0nKrMBal9OfP?=
 =?us-ascii?Q?CiY1gy0skC8JY+nybUQbjXzN+bHU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR10MB4269.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ERpFXkdtV+/gJi/cmpFLlQfbS4EsGNAUWta1vpThBw9TXYFPJgxZn6prTLAl?=
 =?us-ascii?Q?zXOGwzFxSmA4p+7xVuGPg0pRfVU1k0QQTdoKaqbubiFYwJ+nCPmawB2z0MZ9?=
 =?us-ascii?Q?iTJj1Ndo1P/D3gLzGrbDzEjQ0cDx5m9hjMO+eZ7jarLAyzqeNPeLhuwx5GvC?=
 =?us-ascii?Q?26r0UEePq1Tkn1fYdFfnv27dfP6gy5Nz7L+gcl1xu8c2Yp2pXdyqBgno9bHy?=
 =?us-ascii?Q?0AKpcW1lID9dh9hWPW9gs0pbO7MOFB6HkLNeEbt7CoKGSu7dgGd0B6ErV2le?=
 =?us-ascii?Q?j1tkqRnOE6OkXK2jxZ/q7YS/g+i3185oHPdSUXXdRtTLT7ONuH4vWOY1qPne?=
 =?us-ascii?Q?esgo7czrtF4WxJWwPN89C3LhZC8WlHYXyo5ShG+4Z9P7YfY1EYD+S2zxaIL5?=
 =?us-ascii?Q?EawsSs9dqcO5IYn1RrM2+hs/KVmipxXPZRJrdBJC0Pf/6338TSu+EEfyGicn?=
 =?us-ascii?Q?dwGNq9fFg0Od5nwFwMZekCwBRRy6ynqtJ+630muXAzkKa+0awRvEMTsO9PNt?=
 =?us-ascii?Q?dTebwwL94xEahE+6CsmCynToaHAyQN/KK85K8+pKK63tCpYj3mLsrvNcN1qU?=
 =?us-ascii?Q?s+v8Bd0hLhGUD5BgixVornLBCDLLFpiKOkfl/MSaEYpJbzE+7DyY2Zn+mhtc?=
 =?us-ascii?Q?msjPz8bRck/qbf3abYfEO0gmKpbzqqqUjF4JVD/MV8i/p3TydYWl0K2dWfSs?=
 =?us-ascii?Q?S+/nAXieVkzGwjdgXeXMRZoJCddvBmjDXZ4USYOky5KxRFt65wmKhnCPIm4d?=
 =?us-ascii?Q?4/M7CMiDL9AT731HewdYgTljCfTsCNd1hbxRIA9djGFJYAVxhfUzRWDz1vwx?=
 =?us-ascii?Q?Ceoamwvyx7yj4KTp7WH83SqadnXcqFb94r0iIvUg4YzYhqkB+3feVTLLGDdT?=
 =?us-ascii?Q?kyKJS7kY2GxSrASj01p4XpISAYIa2loQ+5d1adLK+2b/xLgRPkB/PNiyGWhv?=
 =?us-ascii?Q?0/pkLOcNqczYDbPgWpslk8dIzkdbwtiR6x8T+dbMB6Bt54JOeLX32v34+J6S?=
 =?us-ascii?Q?vYFhWtTQfQGwG4rPAgGgtsYKxO+uErS7vEhciUBU9DnFgzhZLdkNmQGXpbM5?=
 =?us-ascii?Q?UtLusjtX/04CXcPHEPNkqeTO4rrNJLn/Pm1Ww6m9Fc6EEoOVDIa+12r14DD1?=
 =?us-ascii?Q?cpV3zIQrUMeL4aeQLTRDok5eJfIlUSKjpks55Xiq4UU0viGd5FV7RBS5PCwu?=
 =?us-ascii?Q?P32/tWmX0GdbOYnWMaW92+QkL0LwOeRLFxDYVCsBM41H9Y/xNJrPpNb5TVBv?=
 =?us-ascii?Q?miJWWAJSQ5/a/PfF6BVxx3vhPoFZJ69P3su91XiY7Er7aDelRujbK+R3+awS?=
 =?us-ascii?Q?FKCUaiOqGuWgMLrMkvWAvhaQdvFFUIoMPs/2z1ojqGa8GJgCsoNMGGbYZ4fU?=
 =?us-ascii?Q?Q7V78OfM6OLfmVi/tj6nXkUKsMnjRZQuOkirqX0QouQd+pU21WK128RJhAA/?=
 =?us-ascii?Q?KOY1mbOoyuT66BDh9AFpvMBFPn9KwuaR5tAzaPgY4WxsVp1HSCY1ESTAzy5u?=
 =?us-ascii?Q?9gLHkivaBMD+didahpAKvddTrZP5X0O9WWHj1nyAJChHTQX7CUo0BpY3hYMA?=
 =?us-ascii?Q?bodzzPbCMuItBUb81RHtKULpL/61mkWbtz0u6bV8apPhKOrXyzI+QRt8Ug3v?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: B6CwO2LMQ6r7PFCzBFEHU8RmFijw5N5hOCc2YCj/u/eKOff2cybo0S4XRxhGTeibNkWfP10GriPHUsoFolz7nTfmMajjLwBNJMtTYAQp4FIAGhZAgta8dfD3pnnFfq7ECgxoWAMYZnz+H0/Soo4UKCU880Q6MAzd3DFXEYugAAO70AWhKKW9dBDdTIbRJHCKHkPXXukvvKEJCM9k+/t1hSmxRavP75OeQlM1Gmojt4pZwxVm7W6LbWxcuM4JXSr2eTgfAkxgOUMqMz9MNVl1FIBAwfNUchVHWtNL4N/qlYqZ0Gp5TLZAh1Q/DWh66EjQhRJJY7qRGwmMgOK8BGEedkVWv28zZkbfxeFHUrCiesnfFXq3S45RGVgKnUCyzGwbzlejnZHLU6jJvzsSfv2TPKJiWjEtRAqmde7U+qTTIyMgF8J4nWK0cvSzL/TRKHAPb33UUhTF/8rjbgqgnDOrmavt5dz8Cp09fa6eCyn9qbefkqbNyYEnjET4yeVSoRHqu7QjHGRzUMKiAmpHmsb6SMX2GaxQLdahcNn4fuVTISlaSGkFmuLKQD7jUIVjLRNwNkU1mmtk1SGvh3fGE9O7NMTANXmsSnJOX/1MJRCNnbg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6581100e-e2dc-44c4-0721-08dd1f86f35d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4269.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 17:11:02.6946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4gyFit0mVoANhKYk9b/KUPlkRq55SWrQDbMN48gFPPnEdwwx34uaFoby2bfNwxaETFk+NL1tqqDSH6VkmJ51A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6094
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-18_06,2024-12-18_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=870
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412180134
X-Proofpoint-GUID: u0W5rAjUQmreGE6Z88dnXMfEBMUD8TMH
X-Proofpoint-ORIG-GUID: u0W5rAjUQmreGE6Z88dnXMfEBMUD8TMH
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=eric.mackay@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Tested-by: Eric Mackay <eric.mackay@oracle.com>

