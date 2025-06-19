Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDEFC7115D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSFNu-0004WW-Es; Thu, 19 Jun 2025 09:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNo-0004P9-UG
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:49 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNl-0008GS-Sq
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:48 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JAvH23013023;
 Thu, 19 Jun 2025 06:32:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Z9o5YubL1i4HRBF8nKK3/9MxxJxTJXZT/EZtnIjvN
 QM=; b=VdGJcI/eoMRx4EfFbVP/xx0eZVqW2z0cpg60D196dCW24nMV6QG5pm8CI
 PdjXvgmj1gBZneuxPsX1ppxx1bIMG9KG/x7HPZ/hycvWOefiDPFqtIymIbXI5vAW
 VzfM0IAz+e8FSwoLVFkRguf5rs7gTKPsfiRxSvdRSQYakmW7Q1NF8oBks7+bMlGP
 Te2rDwNyIGAKY3ZUFmVKE+cYEbWrPIKPemrdU1k8/nMOQVIR/KakgZ6HKgl7FP3U
 HXqaVz55Wa5e+bcNK61FU6ha07VGeygzt6ftwcAUY6cBX1mwTAYST18l6NjnAFhp
 Ux32iYCJ5pzW7qi5fpEK9Yb5vIYGA==
Received: from sj2pr03cu002.outbound.protection.outlook.com
 (mail-westusazon11023091.outbound.protection.outlook.com [52.101.44.91])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47976j3rag-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 06:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlEa5wvYS5NbGmtUQK073rXjdOiQSJcQwDAbIf015GnL5YZ+rfd4AcE13hGqwwq9sFLOIV2mm+roil7pn1/7asrHntpW0k4VGrcGn6CJK/vXs7GUJ26a6JEfQY+6FSXYin6r+Rm96NW6QDjjuKZIfZAa0oLEAWVD5RD2sjlpvZ8kyO+37eEK+IR77SO0HrVN9N9TzfTho83U9hCeAqXPuvP1HWE9VHfF5uz3wSxxCTvNEpJCIRMVcytila3s4JKhmSGirVpTz40naaEaSEKKh2HHdz+koFWpiZRpF4H8WV0WH1gqaHAWckVWtnFc6TbKfVs6WAmXlcaCGhUJFJFEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9o5YubL1i4HRBF8nKK3/9MxxJxTJXZT/EZtnIjvNQM=;
 b=rQtRK1p3I92bFnFNpeGDPtAOPuQTDBm1omgozUmZ/FKKDYdAuTckdTDsb0L4VpBDlDJk6uGkpcLhZ6GPA4qOn9APTZawkCwiyxzrAy6IDSm86psOt+JBEpfxM6R/bmoyIr072Sz6PVVl/TrdrVTCaF/A7WlVNXkRIskRhdy7mAuu6PAKHaL8iKK4JuB8SnqFSamR/GTwCtV7iAEtaAr4eb7nbfHh90TQnXs6cgBNKKQZAmhODnoYsgFkui0WzxWV0xKMk/p06YHu3K5Des9d8JMb+xp3aTYthRDOQ5DsvRzeJlpBNmcqfPeQlnwFtQe0hF8SZywKSL1Xbe1WD+pY2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9o5YubL1i4HRBF8nKK3/9MxxJxTJXZT/EZtnIjvNQM=;
 b=GDFfL9PV7QPYnWq5UxzHXF+0XDasSDR0oxNndSjTYWjNQvcybk8mVa8J22A8pBde/6ECrSOPMor4Lq5uLUoTKm/3h5NwzqlbVxSmxyekmzMMCNW60fZUWE075A3TUMVLofMbkEv+7EGIzmZAAhgtLNxNIqOTb/jYGSTtecR5UQQAbTZdJsSMkgbOJFODaz+9ho5esLRlMRJK1gF9MIJpjm21zzaTuomBAkYjN7DvMAuYL67erlATXHPb3pVAixkXSdNcXpxud1r4QUZZAYiR1nDCO2YNYsEXCeo2tUawzn0Vkxvhy+8zAg8lz8p4Mr18/wLe5EXWHG2kIWSOJCze1Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB9383.namprd02.prod.outlook.com (2603:10b6:510:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 19 Jun
 2025 13:32:33 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 13:32:33 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v4 14/19] vfio-user: implement VFIO_USER_DMA_READ/WRITE
Date: Thu, 19 Jun 2025 06:31:48 -0700
Message-ID: <20250619133154.264786-15-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619133154.264786-1-john.levon@nutanix.com>
References: <20250619133154.264786-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec00104-f45f-4353-15b9-08ddaf35bf1f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5l0sllaBlCA3kd3QmtlhqkQWDtDa+Qwsbxid2PSi3g8vUMKkE+2NVuIH6/fz?=
 =?us-ascii?Q?JzrBgx/2XIl/ukRy8yrBqfaeXOuCJAo1XYqXD6IE1M2SQNHD6t19QSOdIUxM?=
 =?us-ascii?Q?7jvROMf/CRD5TcKZ/Ueys2lZxgpJtNcbuP6idfuHCPKfTNXCGfV1d5aRgqJT?=
 =?us-ascii?Q?GwmGlbsdZaj0+++Vtms1caskuHNnlyZNkRvA8ueZHapkM7br9KMgyByQ7Pr/?=
 =?us-ascii?Q?3GkZ6AHByjzKuo3mExi0BSiZyZswGrvt5G6jJftmN7JcS4AH8njcm7ZlyMsP?=
 =?us-ascii?Q?IiFUx4zsLtr75FeWyQAcvdU19uaHeIFEATPUkhbY4Q+9W0iHq0k4/UNhkrWr?=
 =?us-ascii?Q?EvjtL2TAL6TPRjgd3/ZpbfXM+R4JCtR2Bc+Dc22FupSwGFJYjEH91so0/KFa?=
 =?us-ascii?Q?wlbXHAOD/Mke+BUU22m56khVWbxdDPJivwotMxgitza/teKl1Db/ETRAxGbI?=
 =?us-ascii?Q?3Bct2lZ2D8GV4xMJAqIQDL/smAyAXuHkg5WO5U2J+FOn+kwbWwVssbModPFr?=
 =?us-ascii?Q?BKhd/sEYRA3+0Zu/s00G6HoKdn1trxx17WYegOETt8HpDgNHkOKOPYIc4hBr?=
 =?us-ascii?Q?ruhaQJA9bjZBQjMfo2WtWTZ0BgOkF0iGeH23nZZVGOgJUHc3I0B1+/B0f7Tu?=
 =?us-ascii?Q?HOIdYGQUWZgE3OwG3oPxwQMkTiX44Os/C29Ql42y1RgiGq1InGm/q7ncuLog?=
 =?us-ascii?Q?NY2MqbfdYqV/RlaqRjjc5zuXyJbqrNw+LpLbZEyFMe7zQeVMd/zDOcTS92kl?=
 =?us-ascii?Q?wq8FAC98TxnVSK1dvybBDUSEwHxkbVFgv1Yi+exhgm3Kz1eLLk+omU8yHCDA?=
 =?us-ascii?Q?1Hm32QWPvRAG5dWqERZ79+5OKT5Xe1wVGJby5K4ETQb7EgVqcni9dEZ3HEtO?=
 =?us-ascii?Q?RxJaPsyxlFmTVJXJvf0kmRyvBcjKErerK0d9PY4qdPq+3DhiquqBniyOACRB?=
 =?us-ascii?Q?pPzx/6mckI6Uu+qyXzm3lWs0lGA1Yxau0azHpfzEYfStAhbe1bqAqiw5Ba/8?=
 =?us-ascii?Q?B0jnV6Tl5foKox3kRVsAHUheLSavHNE2Bh31+dx9FSLmWjEDWpXN5xGSAYbm?=
 =?us-ascii?Q?Gh3ZUBzoPfK5fvpi4KYpEBIQ9YEfbeTvkhrAuoR4QMAELkzPNctAbBosozYN?=
 =?us-ascii?Q?3ZSqK14Tq0LM3AMx91gx3nxH/LiQRHm6Lx/ykrz5jJEGDHoN1RFRvL6jVH0W?=
 =?us-ascii?Q?Ps0zlkQEusqGUraZ3io8ewdUsKyVtD+t1oMzbiveaE4kymHdKDTd0frNGTC1?=
 =?us-ascii?Q?wg50lgO/tirE36hNDjLQncF8MLzS5a1/uFKwkqy1rpiV6n0g55HZ8NCbd4nW?=
 =?us-ascii?Q?dRgE05a3ZZ+UTFkh3aH4PycBKbrlKTVM3e9ZIGDgnBccW8CWu1JmP4JBmA+/?=
 =?us-ascii?Q?6ABrfPLK4zR5PfP1CCCXCzwtQQAV2T5sS/OKN9P2vqCqbMtve1hD1N0R4KGm?=
 =?us-ascii?Q?D8W1Ozi5V+U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jpC+tSDMAnTL/CGy+4JIMjo7nI0ey+7NnsI21HwYcFx4d10ariID/9qwgZTH?=
 =?us-ascii?Q?zKWgyqjrpIQVumitdnVAPMXk/CkunapYUOqzTmonnrGH54n/yb39KXNuhZrZ?=
 =?us-ascii?Q?+f98ax6sL9cwRAWhGvTYCFec5ncqQCkhD5c2aMhVYymS4Wu2STZ/9uu9sNKp?=
 =?us-ascii?Q?dlSaniWLb3NLu092MenZbwCkVM9RkJEgFf2eR0fdzhf8XgHNBrcsqynFqLFb?=
 =?us-ascii?Q?qkeNvy3gq/vhrV9QGJ0QNYR1m1tvCDQjQcWmW3fjXiNzmytXO1UPzT+LvyFs?=
 =?us-ascii?Q?UO8nWiEePYNGFTLM4+KfdKx44wnaVX407sv51TVK0jHGZnoVD1HvIDa6hsaI?=
 =?us-ascii?Q?Bk48zIIrDDcSvrzdjaoELIuJFID4klmuZ+m8voThKroB4th44+Ws9M89HnHi?=
 =?us-ascii?Q?UPsUdEm+w1um+eh7iM4Zc+QgHuvgSG41MwythrrNxBt6z8LHcjZwIBIB6nr0?=
 =?us-ascii?Q?6ibKHzFnnuoYxocll7pjYxcyclmfmB0at0XNhwqmft8rgnS5kN+MjqW6X83G?=
 =?us-ascii?Q?aGriWGdEUMNF0rENIQmdzmayiM1e7qHK/UYE30tVZcz1rpebSkY0hmQwNaRC?=
 =?us-ascii?Q?oY2Ekl/Ybhqx1I+Y830qoP4rsxl0r9dz3xubQBYm6CUdXr+gSFx/xBEbbrXX?=
 =?us-ascii?Q?USCl8o/bnWarUm3VdbMi98uWg0ZB1+XN1oFTYV4ceB1+zFeGmgfcxQ94h9oR?=
 =?us-ascii?Q?VzI+nfgM23EhlMVMPpXWbn9+tBGTet/9KSPdSsAai1cX7XZiEhNp9yRKkoDv?=
 =?us-ascii?Q?kplWFOwjQar5vg5u4DAe40XaNqtxi6nKBPEqTB4Erc1YAmJpvw9pvV8IXOsi?=
 =?us-ascii?Q?k+bpZFOu10j1cosV1imkF4sS8Sak0cMsr0t6hutf/dG4S0XKPk8PE4V7VgjJ?=
 =?us-ascii?Q?ueSZ7qpkIv7WYSMaVQteEL8YN/OnHly0bVRjEBn7ZxT6LQBJKkYQK16gLGIg?=
 =?us-ascii?Q?2yTY0iUjbW+mWTyFCwcGvalMmW8XH5zM+GaFl53sKLy5ocMSOJnmvuqlfTnH?=
 =?us-ascii?Q?NnLXfkG4uSK/3mffPwaPpXlel5OpGpzqfml+zcP035lRXoavDDvVv4FETg0k?=
 =?us-ascii?Q?YovCh/12FzVfPHGYSsp59QGBZC/vVFYE4MNB9KVbV+td7NsyaQ/Kc6g1ksEq?=
 =?us-ascii?Q?Tvy2wL6p23AbmRrtR3Or7ZcFcp87MFP9uDZbzH7Re89NGGO9NkyTC87THkWz?=
 =?us-ascii?Q?8mJZu8FbdjYLE4ja3KRCzcQa/CAYMBzW9mVfB0YRHQGWHXGroZ8HbkLI6J6I?=
 =?us-ascii?Q?H0l9d460gy03Z3UEvCGPjnPl36+oqFYUcqL/AoNg/FTYW9JvwPua670ifCY0?=
 =?us-ascii?Q?R+DWmTICS7OMdxDNWSAd5pTbpZHaLCQMqlTXWzqnrYRcJPMe68VPv1u0bxVD?=
 =?us-ascii?Q?xR8fVaBMgPzscaZAxGGdGycfAMuedYqlgrNK4ygfHxz/L/d00vIk738Yqvvt?=
 =?us-ascii?Q?8jBZkifugJn5LdaqaGmyoX8zqQsPmgpUlw39N3qHk5F5RHhkXla4yIt4ux60?=
 =?us-ascii?Q?5gSZ5JXlHr0Lfhz97E8DtZM9muMjxLKdkK8DZwqlJtdVR7Xf83JjYYvHRcxZ?=
 =?us-ascii?Q?zFQSfJ44oi5bbwCL83d5lWbSFaeNEj3OitKeEb/l?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec00104-f45f-4353-15b9-08ddaf35bf1f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 13:32:33.4398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfwN7cf0OqjbHZDqmD7QMyHY2xLZtDVFixExdgUhTZH1BvzXaZVp/Fdfe1AeQ1/lxYYGTjOfoiGaGr1nf88xTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9383
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDExMyBTYWx0ZWRfX6KtQwpf8KPqI
 C51IxbRZSw6JP6m85Dbk5s/VFSHmbB6POJbgnaDfC34Z4VuKulwtfoEmuKNFhNxMkWSuy8g+HuD
 mOYY7eTdf/Lvgjgkb4ygaNUqzsb1bNPNZRSPiwE3UWyln0qi89fmwnoAmWkeZPac+tibIEEM6Md
 qwgftUR8+k0HvBHRoEXQIb9DIkPOJAYaDFU4PEGX18JfmaOBexNSpTp4igzSLJIjIMGv67fKnuY
 cIw0pK6WIjbGNstPY5S6MOhBmN51ythpjZdfhtycUxD7CimAhGf4MTCsYm5EJSDSObCwzXuN0sb
 FfMQa+evIuP6ynBKWsYNXDrMZoCO0ydX2O1LC06qiVNaqLFQSFrfhAwV+UCs/LYMBXhOV1/30aA
 d4WR2Qi/X40Nu5qBdP8iu8RT6PLO9XYSYcyz1cwSRySN/t5iCLD9Vgae7sp061nmwbVi1zf3
X-Authority-Analysis: v=2.4 cv=RcqQC0tv c=1 sm=1 tr=0 ts=6854117a cx=c_pps
 a=b9bpObgcEOTp51h0EtjbnQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=vgBDHfCE-WenxT7XOAUA:9
X-Proofpoint-ORIG-GUID: J7DoYLeYUycfWMV2Cq1eMrtUHo5VM9DD
X-Proofpoint-GUID: J7DoYLeYUycfWMV2Cq1eMrtUHo5VM9DD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

Unlike most other messages, this is a server->client message, for when a
server wants to do "DMA"; this is slow, so normally the server has
memory directly mapped instead.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h |  13 ++++-
 hw/vfio-user/proxy.h    |   3 ++
 hw/vfio-user/pci.c      | 111 ++++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/proxy.c    |  84 ++++++++++++++++++++++++++++++
 4 files changed, 210 insertions(+), 1 deletion(-)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 524f3d633a..3e9d8e576b 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -200,7 +200,18 @@ typedef struct {
     char data[];
 } VFIOUserRegionRW;
 
-/*imported from struct vfio_bitmap */
+/*
+ * VFIO_USER_DMA_READ
+ * VFIO_USER_DMA_WRITE
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint64_t offset;
+    uint32_t count;
+    char data[];
+} VFIOUserDMARW;
+
+/* imported from struct vfio_bitmap */
 typedef struct {
     uint64_t pgsize;
     uint64_t size;
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index a9a36e4110..2712a55463 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -101,6 +101,7 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
 bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 
 VFIOUserFDs *vfio_user_getfds(int numfds);
+void vfio_user_putfds(VFIOUserMsg *msg);
 
 void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
                            uint32_t size, uint32_t flags);
@@ -109,5 +110,7 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                          VFIOUserFDs *fds, int rsize);
 void vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                            VFIOUserFDs *fds, int rsize);
+void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size);
+void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error);
 
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 49d12763ab..040660d197 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -9,6 +9,7 @@
 #include <sys/ioctl.h>
 #include "qemu/osdep.h"
 #include "qapi-visit-sockets.h"
+#include "qemu/error-report.h"
 
 #include "hw/qdev-properties.h"
 #include "hw/vfio/pci.h"
@@ -80,6 +81,95 @@ static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
     vdev->msix->pba_region = NULL;
 }
 
+static void vfio_user_dma_read(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    VFIOUserProxy *proxy = vdev->vbasedev.proxy;
+    VFIOUserDMARW *res;
+    MemTxResult r;
+    size_t size;
+
+    if (msg->hdr.size < sizeof(*msg)) {
+        vfio_user_send_error(proxy, &msg->hdr, EINVAL);
+        return;
+    }
+    if (msg->count > proxy->max_xfer_size) {
+        vfio_user_send_error(proxy, &msg->hdr, E2BIG);
+        return;
+    }
+
+    /* switch to our own message buffer */
+    size = msg->count + sizeof(VFIOUserDMARW);
+    res = g_malloc0(size);
+    memcpy(res, msg, sizeof(*res));
+    g_free(msg);
+
+    r = pci_dma_read(pdev, res->offset, &res->data, res->count);
+
+    switch (r) {
+    case MEMTX_OK:
+        if (res->hdr.flags & VFIO_USER_NO_REPLY) {
+            g_free(res);
+            return;
+        }
+        vfio_user_send_reply(proxy, &res->hdr, size);
+        break;
+    case MEMTX_ERROR:
+        vfio_user_send_error(proxy, &res->hdr, EFAULT);
+        break;
+    case MEMTX_DECODE_ERROR:
+        vfio_user_send_error(proxy, &res->hdr, ENODEV);
+        break;
+    case MEMTX_ACCESS_ERROR:
+        vfio_user_send_error(proxy, &res->hdr, EPERM);
+        break;
+    default:
+        error_printf("vfio_user_dma_read unknown error %d\n", r);
+        vfio_user_send_error(vdev->vbasedev.proxy, &res->hdr, EINVAL);
+    }
+}
+
+static void vfio_user_dma_write(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
+{
+    PCIDevice *pdev = &vdev->pdev;
+    VFIOUserProxy *proxy = vdev->vbasedev.proxy;
+    MemTxResult r;
+
+    if (msg->hdr.size < sizeof(*msg)) {
+        vfio_user_send_error(proxy, &msg->hdr, EINVAL);
+        return;
+    }
+    /* make sure transfer count isn't larger than the message data */
+    if (msg->count > msg->hdr.size - sizeof(*msg)) {
+        vfio_user_send_error(proxy, &msg->hdr, E2BIG);
+        return;
+    }
+
+    r = pci_dma_write(pdev, msg->offset, &msg->data, msg->count);
+
+    switch (r) {
+    case MEMTX_OK:
+        if ((msg->hdr.flags & VFIO_USER_NO_REPLY) == 0) {
+            vfio_user_send_reply(proxy, &msg->hdr, sizeof(msg->hdr));
+        } else {
+            g_free(msg);
+        }
+        break;
+    case MEMTX_ERROR:
+        vfio_user_send_error(proxy, &msg->hdr, EFAULT);
+        break;
+    case MEMTX_DECODE_ERROR:
+        vfio_user_send_error(proxy, &msg->hdr, ENODEV);
+        break;
+    case MEMTX_ACCESS_ERROR:
+        vfio_user_send_error(proxy, &msg->hdr, EPERM);
+        break;
+    default:
+        error_printf("vfio_user_dma_write unknown error %d\n", r);
+        vfio_user_send_error(vdev->vbasedev.proxy, &msg->hdr, EINVAL);
+    }
+}
+
 /*
  * Incoming request message callback.
  *
@@ -87,7 +177,28 @@ static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
  */
 static void vfio_user_pci_process_req(void *opaque, VFIOUserMsg *msg)
 {
+    VFIOPCIDevice *vdev = opaque;
+    VFIOUserHdr *hdr = msg->hdr;
+
+    /* no incoming PCI requests pass FDs */
+    if (msg->fds != NULL) {
+        vfio_user_send_error(vdev->vbasedev.proxy, hdr, EINVAL);
+        vfio_user_putfds(msg);
+        return;
+    }
 
+    switch (hdr->command) {
+    case VFIO_USER_DMA_READ:
+        vfio_user_dma_read(vdev, (VFIOUserDMARW *)hdr);
+        break;
+    case VFIO_USER_DMA_WRITE:
+        vfio_user_dma_write(vdev, (VFIOUserDMARW *)hdr);
+        break;
+    default:
+        error_printf("vfio_user_pci_process_req unknown cmd %d\n",
+                     hdr->command);
+        vfio_user_send_error(vdev->vbasedev.proxy, hdr, ENOSYS);
+    }
 }
 
 /*
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 315f5fd350..198217565b 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -359,6 +359,10 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy)
         *msg->hdr = hdr;
         data = (char *)msg->hdr + sizeof(hdr);
     } else {
+        if (hdr.size > proxy->max_xfer_size + sizeof(VFIOUserDMARW)) {
+            error_setg(&local_err, "vfio_user_recv request larger than max");
+            goto err;
+        }
         buf = g_malloc0(hdr.size);
         memcpy(buf, &hdr, sizeof(hdr));
         data = buf + sizeof(hdr);
@@ -673,6 +677,33 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
     qemu_mutex_unlock(&proxy->lock);
 }
 
+/*
+ * async send - msg can be queued, but will be freed when sent
+ */
+static void vfio_user_send_async(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                 VFIOUserFDs *fds)
+{
+    VFIOUserMsg *msg;
+    int ret;
+
+    if (!(hdr->flags & (VFIO_USER_NO_REPLY | VFIO_USER_REPLY))) {
+        error_printf("vfio_user_send_async on sync message\n");
+        return;
+    }
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    msg = vfio_user_getmsg(proxy, hdr, fds);
+    msg->id = hdr->id;
+    msg->rsize = 0;
+    msg->type = VFIO_MSG_ASYNC;
+
+    ret = vfio_user_send_queued(proxy, msg);
+    if (ret < 0) {
+        vfio_user_recycle(proxy, msg);
+    }
+}
+
 void vfio_user_wait_reqs(VFIOUserProxy *proxy)
 {
     VFIOUserMsg *msg;
@@ -717,6 +748,59 @@ void vfio_user_wait_reqs(VFIOUserProxy *proxy)
     qemu_mutex_unlock(&proxy->lock);
 }
 
+/*
+ * Reply to an incoming request.
+ */
+void vfio_user_send_reply(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int size)
+{
+
+    if (size < sizeof(VFIOUserHdr)) {
+        error_printf("vfio_user_send_reply - size too small\n");
+        g_free(hdr);
+        return;
+    }
+
+    /*
+     * convert header to associated reply
+     */
+    hdr->flags = VFIO_USER_REPLY;
+    hdr->size = size;
+
+    vfio_user_send_async(proxy, hdr, NULL);
+}
+
+/*
+ * Send an error reply to an incoming request.
+ */
+void vfio_user_send_error(VFIOUserProxy *proxy, VFIOUserHdr *hdr, int error)
+{
+
+    /*
+     * convert header to associated reply
+     */
+    hdr->flags = VFIO_USER_REPLY;
+    hdr->flags |= VFIO_USER_ERROR;
+    hdr->error_reply = error;
+    hdr->size = sizeof(*hdr);
+
+    vfio_user_send_async(proxy, hdr, NULL);
+}
+
+/*
+ * Close FDs erroneously received in an incoming request.
+ */
+void vfio_user_putfds(VFIOUserMsg *msg)
+{
+    VFIOUserFDs *fds = msg->fds;
+    int i;
+
+    for (i = 0; i < fds->recv_fds; i++) {
+        close(fds->fds[i]);
+    }
+    g_free(fds);
+    msg->fds = NULL;
+}
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
-- 
2.43.0


