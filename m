Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468C5C54E92
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOWU-0003BK-8r; Tue, 20 May 2025 11:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWR-0003Ai-L5
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:04:51 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWP-0002QB-Nf
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:04:51 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KAc4jG027978;
 Tue, 20 May 2025 08:04:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=GoZDkXZDuVpkYtV5ZrjkcwXGy0Yt6C0u28B1WtDoW
 G8=; b=rM1daFpcUz9ZUKMAggq2esKi7XTNaN+t6+Ek41FJKYFDoaHd3Oi/DUahP
 NwfHa9t7CZWrq/UYEbLbtjuwNACiujeBTNnCGCpwanaWwYykeY3ELK1TWyFBxDJM
 xvcAahp1zwkdKbL3eIQVx3zV000kkPDsM9kA0VcvOgGzRK9PXUsiRJWT2eJ4lRv6
 T3flbdH87Hh4vtaH4SsiQqL7d+w3L/CCf5EpyYicptgaeMKrFGxxLhCH1N3nyB2u
 3kfDD3WbQwmuBKH3JBr4X/tJxlm7Hd70rbZ5SxEYQj98AJLYI1a6hplnJg6oyak0
 +bg3vsWCCMYY/z8VYpQ1yWWKgfUHA==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46qvhvc71q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:04:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1y2EhQc8zqAcbc95P9PrM0Z8IgHWmWe9FvcekkHoDs98MbPPCr8Y8NYvC/rZRbL4G++FHbD2qAaVTVE20s5f57hgl3mOGzv+aCEX67yCc/Ar72BI1xT+Sljiqam/9fyz3Bt49a9A0QnW6stE+1lerWFW5igwlQ8jMGDVXIh34MBXUnBw2DANYkj3WYC66VMPA/OAJyS4CIRFunorYHKlYfARUN+5HasKE13vxVazK+3SM+Ry+l0MKs9iPIDCUQCNFTca5PBuxu/03MTv+9lOGsJAXOdgN2rrRQ5BNyci56gORzkloPphX0H2svWizawr7FpkEceuyNUaT7JSv+Lfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoZDkXZDuVpkYtV5ZrjkcwXGy0Yt6C0u28B1WtDoWG8=;
 b=jXAIWP85UuvDmso7lpHHzEw1LY7ffnAah/1aLg4cb7R0d5zLW+TkHNOaUd/F1raa2goIutN7sIt+U5L/+GABPFHjqR9p9lFYi77GrPrMc8synCCu4uyyLKZ3Xzu5YelKYRKEn74bYK3CCj7VXyCuIS4tTdADupMVqkTZjCbNwouptycZ+9ysVa2R1737GcZA8uvMZNSLuEe9il5kYXlB1uIAPJOZT0U3/+RobfmQ2fE5btOpwOvnlfzOJvkS9c59XCzMIX0FouM9JzgCFy9cJCkqwLDKF/ZB+4DXN7jN6fF5vYPKz47mP5cYq7SUUejfo0tBtvUGoxJ0HW2KavYWHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoZDkXZDuVpkYtV5ZrjkcwXGy0Yt6C0u28B1WtDoWG8=;
 b=gql2yrS8+EY1RjHjqF1KyMiHaCuau6ngylSQIvvtB79Na8nZweCJfDKJT9DXgkJ6JBPTJPqSokfLU7XoqQ5jnAihhCINMPBrLjaYL435lND05rvwT27LCwFy6M7TfK1MQRU795Di5kcC7kmOGdc+kmJ2ACsrN7J9rNJhWgEm6UHvxFiNjZKH1/JEDm7DVZhYemTPzwLDJfTCyOC4jnUhCSX5z1kRAPG0v+KJbQxhIanko99Ps4l2GgCF6rxNbDLqgW4w16A6P/MIeUFbAjZ3jpmk76FagP0J+g7h3I/nA4ZQ5oBILywgxTl4NuMfjJ8zbdICS6QhiNCI82sX6FVXCQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:04:44 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:04:44 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 08/29] vfio: mark posted writes in region write callbacks
Date: Tue, 20 May 2025 16:03:57 +0100
Message-ID: <20250520150419.2172078-9-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150419.2172078-1-john.levon@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: aab83cef-c8b0-4938-8752-08dd97afa787
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b92LGqmXoXRPJKwcV3OG4IvbXEjQmZOc58RoPJpPwD3Y+WJJjQobX4nJLNod?=
 =?us-ascii?Q?jvXS2edi/vBoQkJiRW6Aj4O/DX5CANDjt0hWjg0aWLDocBvKHv5S6rWitmc8?=
 =?us-ascii?Q?c/rwcMCXDMC6zOni4tlCe+l6/V7+ADpv6FeuDUS3dWH6aacS/lrbe3OB8j3N?=
 =?us-ascii?Q?nLU652ZN5BCCAkL79f7zOdX8QTqPaGTYJ5wr/uorCU7KehudmQgi9GJhAMze?=
 =?us-ascii?Q?XMtrwiqageN6Ma/zGDR/Dv4haCwRiVvTeQsAp7PG6X1OWl/3dVY6WTVF0Y58?=
 =?us-ascii?Q?NAShSmmWDyMwvnBb9iKvWXkIongb+L1dwobnNsc17PIrKMj2ki284EzfJfoI?=
 =?us-ascii?Q?r96SUrEleNTl9bWSYBxunY4Ig/0vDvBa772KYFqquttqjm5ju7dO8/oNLhIJ?=
 =?us-ascii?Q?evQKdJitDlV5gJ83AU2NAhwqamQbi3H7CiXj/3jCGSsfKMSRuJcsaW3qE3bB?=
 =?us-ascii?Q?8MC0r7153KWpamUpn807jGYWSxCq851HpnR7LODDJueQCZLMB2O7bi/yKsgB?=
 =?us-ascii?Q?Fu6V62Tju5KpldgooeaaViFYJYlujEnxjSNQE6oCu1md2MhyKJCmJuxVqc8J?=
 =?us-ascii?Q?zUYdSkCo8mGWqg/Rf15lSbypBz43miqE95CKGd7xIbBO4Q4Op/X3s26sH7cN?=
 =?us-ascii?Q?U8LMpCpDRXf7q1k1ShgDkIZZB0utmrlqyaJFUEQ2P711HGaX64MzYhlIsUEB?=
 =?us-ascii?Q?q4m4l1po5FB0NRZQ3bY/kDVAD56Xe5wPzzdKJusmYXaFoVxDIoyad2BzUbeY?=
 =?us-ascii?Q?CWY89IvruJH57wFzWD2LcNsf5dSWY+RpUXWDD6GihYwzdlLpa4ySBCONIJXZ?=
 =?us-ascii?Q?lfvqsq78pZj/PEMUcZ+7Om8n90ibfx9G89S8DJWSJbcJJPvMoNuWr5woeLln?=
 =?us-ascii?Q?6tBSr3JHhn8XXLpf43diV2Xx0FypMGUuHJ5Xb7hcyRtMlgb+hnKGlCVEFpGx?=
 =?us-ascii?Q?Fnyjx3sNv8XRl+oFV7Od/dXSZL/kFGApyj8f8xDFR79N/Uf8wNteWRsOZqLZ?=
 =?us-ascii?Q?KYBZ3efPH6JIyRKCl898QhHKedukg8MAAnSK3L/1S4RuITamQ2lcrGYdTtaS?=
 =?us-ascii?Q?/OtIs1d+AejdjDdujHJ5dFnq2AXjLQ66vJlMHWYiFYka79yu51Qh6uitNSti?=
 =?us-ascii?Q?L48CQkFHKlso5vUCG+wG+bWsXR/WU7ob4GlInQruTBmIAZHhzlUhQrj15am+?=
 =?us-ascii?Q?Fk1Yanr+cyqRynOcqgbVoq7pjoSzMhDIDlgigQp6RQHw87c/lHgLunWFbxNW?=
 =?us-ascii?Q?t0rHt/3OWJ21s6aELP8BdZokwpfpssUsfJOHahM2LEC0xnr8GYi+kg1W2TBF?=
 =?us-ascii?Q?XzRp/OBEtKvrmGip2/ifucb1Jqg22E9vD6Bf79+xKZG64Uk+2bmOnOMVgzXv?=
 =?us-ascii?Q?E+C+hJnNDe/GrMRinCBaBrDKj+TEcYqsN4mlHQf1AKtmANj8OQU+kAIhylzG?=
 =?us-ascii?Q?scU4h3EBSyk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g3922siAzi00v9N8iiFvPaqXFdh+EtoY4c4tckQfFf4lG1p33IjNHam+bSMo?=
 =?us-ascii?Q?TscU25BP/zUZpsbvzTvwn6+NknrsARbvmuRC06kkzVxH3TEe/64OabZhf24N?=
 =?us-ascii?Q?KrPDOBZYjdj97kkgWe+I6D6fdbnhYjJCXR1FJVwEm5sGUwU0IncgbByqrnYM?=
 =?us-ascii?Q?Gd8lJIZH+tIOusRRuaA1kXlqHLGqBxmztZr1Fs54EIWNvxAu43pR7GfRBKcO?=
 =?us-ascii?Q?ROvHv/iA/3dLWi7ou9perJUg9KRgn/n5GqTox9J9gGAv45O5OaATZ4uJHYbO?=
 =?us-ascii?Q?Zkb5+YDrGk67m+sisaYYyLcHsUn5Y5+r50WWs96mmwU9USgfwJ1xJnDME1uo?=
 =?us-ascii?Q?riVs+Ujc16eADEFwiexmRTlMzbgAGCALOG5Tp37QoCfGz/FdzxCZzBWGkmW3?=
 =?us-ascii?Q?s8snK3LTMGGC8M63AixF8+WCJiZL2e0rGUmV3rF961vtTbgr5mmmdFx6kOde?=
 =?us-ascii?Q?47jw0yRFe+HbM9INpSNEPbky/+KcDHQE37I53g779mo/GDkrHiGctvpMcGTV?=
 =?us-ascii?Q?rAyJad9Z3qkqQzsHpdglEUk98ml+ezQS0DRC1cdjOggfKJLQdeN16h4OoKk7?=
 =?us-ascii?Q?APLPNMOzIjVcid8iVSwYphbQd5CqCz9CA9xY+wnSk14dz6sGoIYhDFPdUhgK?=
 =?us-ascii?Q?WP6S21U2FL3BitMKCBaFur6EX7FIaNBAp75R4Ux5DTENGtuIxo8V+1DVASLe?=
 =?us-ascii?Q?mPXA77uux+S1LXF6NVy+zyeiXe7FD1FCnf9Gtt9DhGy3ct8EdCWDSpv2TFOD?=
 =?us-ascii?Q?P8X2Xs4RehV+pYl7ajSxXEcAzZlKZ5smC+HMWicqcUT6MzpoyOStFGmauWfD?=
 =?us-ascii?Q?uZnRfb5ZhYwnyIIhAmLVKtpjRsuAwa50FZ9PKBoJow5MnDxCqGT0wP0BC4jT?=
 =?us-ascii?Q?yWzNok7qggI3KV8I5ysOZcuZa6zFGk3Va6T3fgOjEIvd9AD2Lr5KKwzSKU++?=
 =?us-ascii?Q?B8XjmL3rYxoliRJz10cg//BYpJTdVF0Fk09jyRYKD5QaT/kQpG/WiFPdVCR8?=
 =?us-ascii?Q?7PHepfobBEyTmik919LMoqD14OQo5ph3IuErk0U40xGXpPf0xwsvqr/AcZXU?=
 =?us-ascii?Q?zSiYvZnP5nnT8Do5QG0e5IggwEwJerF7POtFrvkp5QXCnoGon9Vl7ZS7eNUT?=
 =?us-ascii?Q?l9tnDKG/U0Ze1shhNLBM4Y+3KflglSXBLkQbVgH8R4zjsjrDEm1G1j2nfuqg?=
 =?us-ascii?Q?2EBu8qfGwSNebR53QuQvU/Z8xUY5zRew7tBG1Xio+PHZfS651qicq7nlBp03?=
 =?us-ascii?Q?notRwBAbEAwn+xYjoLJN/PLXAGV75caCbGi+7o7Tr8FzGicuqmMdWeuSu8Lu?=
 =?us-ascii?Q?BcEOfqnu9szUj6YmtjuShdd3QDNdkBHNGSAlL+1rJhCmV9hVYocPF1tbsdf8?=
 =?us-ascii?Q?FcmvbECv7KQsTUnTFbckFwY53FsHLmURu4++064TzIn6CklMzTgr9bBxc1Yo?=
 =?us-ascii?Q?r3BuKst4urnwWl/EwtUc6+INEWXWFu1PzP7+NFs3mZZqJGRV6flc72JpUSPT?=
 =?us-ascii?Q?8qVXTD1uHHQ6ZqRfwBPQ2cbvOTFg9OSEDO0aAsMwrI/NFi+evx5bHSO97ttt?=
 =?us-ascii?Q?G05xLwhZbKg6um9O7f8RpuLswfrw5NHS8HA5DHb/?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab83cef-c8b0-4938-8752-08dd97afa787
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:04:44.4019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGTsgaIv2LmGdw437hE323m2Pe+JFr3ODiK7E/9xq+9xt4MiA9ubIN35rs7JqWdWo1c7cy9J8+1HJ/xMc49jNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX2Ahfa4E9RTKI
 FOTclLeYSMtPV+P0C1YxqmfUMSwYx1Z6kwRI8USOpQgGuRsmsmcF91hNpiqTMNdv7Ihs4U7uUhL
 z5VF4TBPZ+c4unMYOPct0OQEIhpLxSnfP+zov55I1RpISnK2Kzs5OHOrwr2a7SDkeJb2d65aXeK
 xmB4lZQbsF49XYCpG72fkjch3+Vz+Y3cYFK/9w4dC0GOzJyk8Om24uuPm29sRU7ilg3fKlqddrS
 gZIVyOjXsi+xzyTk44uA5nXQ8RBVQfLeUbbXIawzjiWTxyPNO2C53o0MUdcvOtktatRooi2Ac1H
 QKwCcV9k4KyfzESuGIMdGgsc5xMyLG5lOVV47uM9qRS25OTxhZkzoNbBZ1VsGgMqhEJs9OyTi9Z
 dv1CEKoOXIjAYWdYzS4DBsjqw1bbF6jgWN0oePlSsyKYfp71SPjh2CFak+fAWJVOxbeHRb+l
X-Proofpoint-ORIG-GUID: rDDdY9MqPOpXsoYjWg4kQyyzsuJhkSXD
X-Authority-Analysis: v=2.4 cv=KINaDEFo c=1 sm=1 tr=0 ts=682c9a0f cx=c_pps
 a=mbHLYBybxRkByWxHAZWYkg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=AhJUW1JONd81xBax9acA:9
X-Proofpoint-GUID: rDDdY9MqPOpXsoYjWg4kQyyzsuJhkSXD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

For vfio-user, the region write implementation needs to know if the
write is posted; add the necessary plumbing to support this.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 include/hw/vfio/vfio-device.h | 4 ++--
 include/hw/vfio/vfio-region.h | 1 +
 hw/vfio/device.c              | 3 ++-
 hw/vfio/pci.c                 | 5 ++++-
 hw/vfio/region.c              | 3 ++-
 5 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 5cb817fd6a..a23ef4ea13 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -207,10 +207,10 @@ struct VFIODeviceIOOps {
      * @region_write
      *
      * Write @size bytes to the region @nr at offset @off from the buffer
-     * @data.
+     * @data; if @post, the write is posted.
      */
     int (*region_write)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
-                        void *data);
+                        void *data, bool post);
 };
 
 void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
diff --git a/include/hw/vfio/vfio-region.h b/include/hw/vfio/vfio-region.h
index 80e83b23fd..f1ae5125ba 100644
--- a/include/hw/vfio/vfio-region.h
+++ b/include/hw/vfio/vfio-region.h
@@ -30,6 +30,7 @@ typedef struct VFIORegion {
     VFIOMmap *mmaps;
     uint8_t nr; /* cache the region number for debug */
     int fd; /* fd to mmap() region */
+    bool post_wr; /* writes can be posted */
 } VFIORegion;
 
 
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 41db403992..cb1a212b8f 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -572,7 +572,8 @@ static int vfio_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
 }
 
 static int vfio_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
-                                       off_t off, uint32_t size, void *data)
+                                       off_t off, uint32_t size, void *data,
+                                       bool post)
 {
     struct vfio_region_info *info;
     int ret;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ef38b4692a..3d1dbdac38 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1016,7 +1016,7 @@ static int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
 {
     return vdev->vbasedev.io_ops->region_write(&vdev->vbasedev,
                                                VFIO_PCI_CONFIG_REGION_INDEX,
-                                               offset, size, data);
+                                               offset, size, data, false);
 }
 
 static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
@@ -1820,6 +1820,9 @@ static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
     bar->type = pci_bar & (bar->ioport ? ~PCI_BASE_ADDRESS_IO_MASK :
                                          ~PCI_BASE_ADDRESS_MEM_MASK);
     bar->size = bar->region.size;
+
+    /* IO regions are sync, memory can be async */
+    bar->region.post_wr = (bar->ioport == 0);
 }
 
 static void vfio_bars_prepare(VFIOPCIDevice *vdev)
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index 3c93da91d8..936502b37a 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -66,7 +66,7 @@ void vfio_region_write(void *opaque, hwaddr addr,
     }
 
     ret = vbasedev->io_ops->region_write(vbasedev, region->nr,
-                                         addr, size, &buf);
+                                         addr, size, &buf, region->post_wr);
     if (ret != size) {
         error_report("%s(%s:region%d+0x%"HWADDR_PRIx", 0x%"PRIx64
                      ",%d) failed: %s",
@@ -200,6 +200,7 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
     region->size = info->size;
     region->fd_offset = info->offset;
     region->nr = index;
+    region->post_wr = false;
     if (vbasedev->region_fds != NULL) {
         region->fd = vbasedev->region_fds[index];
     } else {
-- 
2.43.0


