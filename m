Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A094C7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSFOZ-00053c-Rj; Thu, 19 Jun 2025 09:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNq-0004PT-1F
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:52 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNl-0008GT-Su
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:49 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JAvH24013023;
 Thu, 19 Jun 2025 06:32:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=27jtgJpP8H4CRv82Q0qbKLjrICwoiKBrJDaYNaJgJ
 Us=; b=K7yVakyIeYN+6EcyLPZuRm8YG184EBf/TZSgWHIXTe4CwmHMwbQLB6pJE
 Y8jM0IqusMyC8vrzKKsgFgCexvaFJwA8b6DDVvK2EJOn2PPpKxKtoE6A/QLdrGCq
 bdAqaVrj6uNCbJhEy30NC9oxq98TlVjTYiL9sanEDfhlLw61Np1mTr4lfg/7Cplo
 mqtSD2Gb95I7IZhTmdsKnIIAPbUZusOS7wVGDwnM/NNvdwytZ2mwfKxL2+mF+Wyc
 1Lyj/YuK2E/0SFrVozWQmXBgHNLV7HTK4NryMoTGgcjbhszG4afNK4AoPbRPEmQR
 lJV1L/G7y6oPeOvdme4xdJPThwydg==
Received: from sj2pr03cu002.outbound.protection.outlook.com
 (mail-westusazon11023091.outbound.protection.outlook.com [52.101.44.91])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47976j3rag-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 06:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdEOZmMdawCDaHHjiexYzE4tKT/3OhyDtDBYKiMX7PxgGtgJiXBaVj/jYzMOOLvmtLDVaWZZTdkNeglGiVGWXTTae/97qE3Py87gVKWZHE9KBTdm//0d2KjtGcGi3hUE3P1iZ096lJEA3ZA6OqcQlhZqP87Jch8oeR1cLYRPWnAKgZ4LzMSQ0U/WMrgPOkAvfN7RpyrqDMSFCsWr2amnWZdyAsCsHnQnzlrePMLx3730l2Q+NS7ojX1rRKdHTUSz0iWtj8xxTpZx8VNjaw76F0mpeyrViMAJ6e6L8AP6sWxEoRbiDPZJQYc3Ql2UVnMkxxQP7yI6tbLqdTaLiO2Fpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27jtgJpP8H4CRv82Q0qbKLjrICwoiKBrJDaYNaJgJUs=;
 b=SjLTqsO6aBJNFUnN8XzEq8M4eCM/HCpHCDVBSrpnGglWGTV3yFV9nfKqkIc3GFIyO+yrxSGV8Fm5dqexXyl9SzqFfrJrl19dMWOXt/a/PZosKhEEi2fYb3/+ddlgBt+ba/MWITxT9gIKSfRxVZO8kPeCRhcUL/4QLg0I1Hj4bWWWn91Z+TzKFeknFH3lRmRCGNsMfDkIz76JmmI7RTwFTvp+ERh+CsdZN8sxl1RS5hS7EFaoNX+VZEFowzVOXffHHYQyzdF6s2P5HXtpzSHQT/N6Lqf3cGyy17mC8fb5bPjyoP1HvgRy14AeVc5vlW/WpIlbsQ5qQ2U0mP5E0XLH5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27jtgJpP8H4CRv82Q0qbKLjrICwoiKBrJDaYNaJgJUs=;
 b=vVv0XimqnCxQqmK3CQCO8hUR87md9UsaUKT2N8eH+XrX11R8p32cSskWBswXuzKDHXJWZZzz7kPi/hslMIoQyTVCNEssYq6+a0j8iJq+q7xK3UtHUssePDmfl9qknE3/lXgu8DYuawUv8/xunjyaJh6s/vbMsbkDOe51UCsu9VHfykU+PZhJrg0U4HBlRfsgcHCi5CFdLsCopzNtSuma7ma9wvIv00MVV+nBWZvV8kfaKFXOoLo1e11eohE6EKzkSVNVWL1a9rZRyJot7WT1wyXjyeT8CDgy7ygt3ysUT1PcoyBCzBmKV7MbatSbd/9xZxNFft5y/T7fLvuVMpBO2A==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB9383.namprd02.prod.outlook.com (2603:10b6:510:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 19 Jun
 2025 13:32:35 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 13:32:35 +0000
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
Subject: [PATCH v4 15/19] vfio-user: add 'x-msg-timeout' option
Date: Thu, 19 Jun 2025 06:31:49 -0700
Message-ID: <20250619133154.264786-16-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7a86b4f2-6efc-4887-cf7f-08ddaf35c087
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j7ML2KhWasmGS5808mxFAuDZxxbSWxisKCn57kkhAHhXRVp3mA2P0okXN4wV?=
 =?us-ascii?Q?5D55TlGepDRsGygI76TrGTgiqZ6V6JGwW740/NzGgG1scyOr5K3tN7VN9mZ3?=
 =?us-ascii?Q?dnVFNlIKrcx0G423zdIItWukvjcv3wd5wux6KeEpEJsA+Y5UY9V0mA7qG2Yl?=
 =?us-ascii?Q?c4xKarQljA54VVQZ5dttVLmEg4gPO19Y0cA1+4FE4Iol80WKBIfiR6hB0/CB?=
 =?us-ascii?Q?vu70k9ewBsJa6lfjElgVBnVlxPagMSRfxzMSWzVyaVWCvtY8CyDsBLo9n+9b?=
 =?us-ascii?Q?WgKECTMqyhZwv1EErr1ujcP5f411lOH9SH0s/s4jldxoogHuMMbqVK1zxX1w?=
 =?us-ascii?Q?Vjdwysm0HFODL3P0RnItfYEijKcmx5yDCcshYIjZt1n4F+trW3N8CcXUCrQg?=
 =?us-ascii?Q?8Qa4i+PPx88Zv4HDL10nDCNy4FX3uXn+A6w4rWJQL50MA2iWAV0bmBdrrC1N?=
 =?us-ascii?Q?RfqG+x9GlUa6TA6tki8LzzNKkfjAYY86t/J8tjxzimUH6fhVeNdJPYL0jusc?=
 =?us-ascii?Q?hnFBO/3a7XDSZkmT7p1Mrosf1HIHSMP6I8kbQ3vlqwFX6vb912srt/NegvgM?=
 =?us-ascii?Q?NyeO3/Oql9rW54PJDScZvApA9ZoI7pqO/axA9YMRrJJ8lv1taVE0Iq9XtPy1?=
 =?us-ascii?Q?JyZ2WA6Yr8oOELZWVfqC2Zo1noVN5gFeKFze8DutFuM1zX0aEbQEBByigHNq?=
 =?us-ascii?Q?IuAogcFNljuJscpBXBwzRtH/tEDYqCFRkApduS5dx3+bIuPqPhqPQP5CfYeC?=
 =?us-ascii?Q?3XA4b6kyPQzTq/jvDGAvaR23UsgHDpg5brD7nziexlgeOKH11ocKhrbIMlUu?=
 =?us-ascii?Q?bAusVYKJaxe1NFh0rG1Ij8RzT4l8keUCkPtS9zGV+GL7rrpktT1LEyjAsFn+?=
 =?us-ascii?Q?Ny9wur8S+dN9WDhOETJw5T/2HPoUSxmzW1cPZQ/sqHOuEFaUd14I5+B/Gx81?=
 =?us-ascii?Q?bkPuHzWa+hB7b03N6zxkxSbxQTl1hUOZTzYVu0gjFk1FsFyFD2pgKBwwje4e?=
 =?us-ascii?Q?bO8XjmjBRJ05s6fHQW7uWnsmFYAp8/6cK3J/By7uD80FBgeBqGe6KXBY3E57?=
 =?us-ascii?Q?fBuRH8NZG1ZX0eSTwJowDPiq6CzPgCqu/zIcFk8UgMgkrptD7XaSzTEG72CW?=
 =?us-ascii?Q?zrwLBW4WIPHQhRm+GoG1q2F1UwpuRzqZwoi5MqW1xx518G89a0wDoZ4lmhqo?=
 =?us-ascii?Q?35GGHHFGC+cmMsCXXQFoNwr+0utpWvVSS/98PIu9NBr47x7pgc2w3o2MWhmw?=
 =?us-ascii?Q?NBe+5UWKwcLyPGqOe8WP6YeZ5NSnoCITiOnqLs0SFtXue8gEHlpNL+xOlKk1?=
 =?us-ascii?Q?grQFvJ27H0HwaLxyEdFimXKlHWk7G6Xh2uwVRoY58p+9EA9LauMKrQbgpW/b?=
 =?us-ascii?Q?lIv//7Fyp6nP/gHICl5DbU5dQPL0qr6TJ5xw37jIwGTyhYuqkg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AhUMT47+5VqlucGRAcCnLNbsbxxPieq4Z6gToWKXysR8yX8pWeOqqS4NHTy+?=
 =?us-ascii?Q?vGdV89TMFOuNWKR/I9TRWruTrqqaizGc/Uxq3YEpaWb/Z4bz8hWbET3Isdvd?=
 =?us-ascii?Q?GLDGdamZqkU0wxqMbNO6ahYRQ3Q+zVYQsTWutI+0aOh0ahsCLyFRiqbk20pO?=
 =?us-ascii?Q?Cl/pSTsoebqyBMDvUviMr6UdP/UCB3imO0VbqFHazMFIZTax3tqzFsxkD0Y6?=
 =?us-ascii?Q?mxYcyLfgEzTqLaRSbmG7m+LzeXEBsxR1JxgG7b+63aqdrqlO+x5G8oSNU1nV?=
 =?us-ascii?Q?fF3x43aVJMDVYcqNV85Ps4dgjeWP3hJrSkbS+Zv/Llaw/5bCVs6F7FYi4gWv?=
 =?us-ascii?Q?Pb9Dz0jYn1MvjE9HLMfXytP+WbAHsI5tO4BYvspyxKSSUJaj0rnURHA4st6o?=
 =?us-ascii?Q?89eXgZm6ZIxuH1zBmbCEV3uq3ltM9csKRPoDGN9/QYF87oDWLqCeJ4Sn3Q/y?=
 =?us-ascii?Q?le6YuDGe+xY3En1/th9nlXhDbmxq7Mqxg3c2h+T5kjVMaLAQiUN5klSsi4+I?=
 =?us-ascii?Q?b0jCvF/LBEU0Cp/UCf55mgcgsdXzc1wMoFPHikKPNEMxYDvHw1ivNlfIVwcg?=
 =?us-ascii?Q?/1A5EOhMiGcU+a3ie27HGFaFTdae4ZPXYDGJ2nDhV43ztZY5qwVmZcvNhkAd?=
 =?us-ascii?Q?usKCwDC7tvPR/36RrIPu+0axyGHCVXa90aVl2Vp6tUmCBL+izvasqVnYdPIj?=
 =?us-ascii?Q?0+qqEAN4R6kyZCVK2usAIXhkm4oAzlP2xgaZU2pDnS8HeMQrhWhn/bBDKIHj?=
 =?us-ascii?Q?o54Q+451m6og5btz2OXaIVi4zOCjfJ6/Jvl2sJtAOh4Uqg33MrNrOB/2G1af?=
 =?us-ascii?Q?n3PP0Js279d/YSy5EzxrVriXVrsXFYHUU0dYIeuTFtnvp6XwkWLETwZy2gEW?=
 =?us-ascii?Q?meBGmxPj/rbVuLpH2nwYn18ESqJ/v53M2n7pjHPAcqoM6633XxCLWD0ND76E?=
 =?us-ascii?Q?mtfAY8U6G6b6/wtbj1XmIAmVxIpkVByEJUItlUB+atewvFHRGbGs1b0lMy3V?=
 =?us-ascii?Q?1JTHMvGRbbH9bWEdBGdGih4aMRVzuccDzFrdpE7NTXwBipeBLsdYcazMLFwV?=
 =?us-ascii?Q?2Gkyda/52cOX4WLiSI1WGeAclQ1sb8HTIAvTY/FfiBjDYdUpLhNOIuQOCt7U?=
 =?us-ascii?Q?25yIzvRh6ffdtQ7ELv3e1Fwn4U7Hvvp8XbiCBoPR5fuKWQg2SxpEFgtDNJGb?=
 =?us-ascii?Q?q4DTIKzpdASlTRkgILtwsOcXQANgYRbigkahM99MOi8ejbOKofp7Qw6FDIAK?=
 =?us-ascii?Q?D3CHJ7+HfXJpuvNUcVNS3BsOx6A0vUjogNm+CAM4nL9LaXmgior6LHz+xFEM?=
 =?us-ascii?Q?IaCkvMz95Clavh7vw5moS0tqMI7G2Gcc4XrsLtjJdjtYC11uZm3Pxwa65BSs?=
 =?us-ascii?Q?RTUZoWjUkExu59l7Q9Lh0qtZ3avZVmadUQifeiYXJO60xj/WacIw5jUSaPQc?=
 =?us-ascii?Q?SGnvcTsBl65pKYSDGUoK9QyRhS05AySAWEwc8MFPDMZoXSCc8UUrobZXzQ6H?=
 =?us-ascii?Q?oLl4nlRkLDZOYFG1dJO3DW21CkpWR0PyVj9AXaPqqr8acFTwv+6ygajvBYQN?=
 =?us-ascii?Q?4v7HbRYH+sBZXwxuUc9IeNylwHsQvV2gzgcBceLk?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a86b4f2-6efc-4887-cf7f-08ddaf35c087
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 13:32:35.7945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BAWhCZjO3cPBYkW3FJsdASECmT3fYCFzs0wkBgVJP+7s1j9wGkHzRYgPefhtn5j+KYunVR/cQsepD/XjHkY7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9383
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDExMyBTYWx0ZWRfXwt9/mB121hXQ
 NIN/oRJVZVQuqPtmRXyq1Y926tewPWabsvw9AnR3pYiFkV9BQDsts0FQRL5N+RJAkDzhgzSQ2nK
 53xUbgWSgh4HoXirj9dXP67L+7XZCALjhcDkLWR5orula+WcIVatpladwn4U/w5hiwWGui2R1Ma
 aMwq/pNRPOOGNq5tFAZQzWPsv/dqBxJgN9Uh/WNtwdePEE/JJUNHNUaDS12AIi6SX/8ZLNWE5Cu
 yXn/agog460ICVfPKybD6NOpz7nrGtjQH5yDYql/OKTnS/ZrO0VlTbzstaGncI+2KVYnSx4qA3y
 D7MXsuIdes9xbiiNA6py27XYQX8RbnMPGfW6tTvo4541nd+916mcWei4oEjjHD9DcyN3ZcH/V2X
 kA91uJbOcbbqUV597sP9hrRFXvSnW4q5Vovs21coZ+3uGTzNGUHQHjmz0dIWZsWS+dlP5DKA
X-Authority-Analysis: v=2.4 cv=RcqQC0tv c=1 sm=1 tr=0 ts=6854117b cx=c_pps
 a=b9bpObgcEOTp51h0EtjbnQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=Ql6ANm6PklPDYutWWPYA:9
X-Proofpoint-ORIG-GUID: XHkatDk-2MIW6O8brOCl4jEs-EPmh8U8
X-Proofpoint-GUID: XHkatDk-2MIW6O8brOCl4jEs-EPmh8U8
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

By default, the vfio-user subsystem will wait 5 seconds for a message
reply from the server. Add an option to allow this to be configurable.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.h | 1 +
 hw/vfio-user/pci.c   | 5 +++++
 hw/vfio-user/proxy.c | 7 ++++---
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 2712a55463..127defaefb 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -67,6 +67,7 @@ typedef struct VFIOUserProxy {
     uint64_t max_bitmap;
     uint64_t migr_pgsize;
     int flags;
+    uint32_t wait_time;
     QemuCond close_cv;
     AioContext *ctx;
     QEMUBH *req_bh;
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 040660d197..f260bea490 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -23,6 +23,7 @@ struct VFIOUserPCIDevice {
     VFIOPCIDevice device;
     SocketAddress *socket;
     bool send_queued;   /* all sends are queued */
+    uint32_t wait_time; /* timeout for message replies */
 };
 
 /*
@@ -267,6 +268,9 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         proxy->flags |= VFIO_PROXY_FORCE_QUEUED;
     }
 
+    /* user specified or 5 sec default */
+    proxy->wait_time = udev->wait_time;
+
     if (!vfio_user_validate_version(proxy, errp)) {
         goto error;
     }
@@ -398,6 +402,7 @@ static const Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
                        sub_device_id, PCI_ANY_ID),
     DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
+    DEFINE_PROP_UINT32("x-msg-timeout", VFIOUserPCIDevice, wait_time, 5000),
 };
 
 static void vfio_user_pci_set_socket(Object *obj, Visitor *v, const char *name,
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 198217565b..33c3532021 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -21,7 +21,6 @@
 #include "qemu/main-loop.h"
 #include "system/iothread.h"
 
-static int wait_time = 5000;   /* wait up to 5 sec for busy servers */
 static IOThread *vfio_user_iothread;
 
 static void vfio_user_shutdown(VFIOUserProxy *proxy);
@@ -662,7 +661,8 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
 
     if (ret == 0) {
         while (!msg->complete) {
-            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock,
+                                     proxy->wait_time)) {
                 VFIOUserMsgQ *list;
 
                 list = msg->pending ? &proxy->pending : &proxy->outgoing;
@@ -722,7 +722,8 @@ void vfio_user_wait_reqs(VFIOUserProxy *proxy)
         msg->type = VFIO_MSG_WAIT;
         proxy->last_nowait = NULL;
         while (!msg->complete) {
-            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock,
+                                     proxy->wait_time)) {
                 VFIOUserMsgQ *list;
 
                 list = msg->pending ? &proxy->pending : &proxy->outgoing;
-- 
2.43.0


