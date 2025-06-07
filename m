Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C46C61CE7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNh9d-0002zw-Ou; Fri, 06 Jun 2025 20:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9b-0002yq-Mi
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:19 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9Z-0006PY-O9
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:19 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556Kw9UO017955;
 Fri, 6 Jun 2025 17:11:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=JN2u1IJiIG9UH70AwmwkajUabBWu6GamPx886iAAW
 Ww=; b=PuggaElhhLDigxLyNOSZIbzgNonHjZWACyBWQy7qbr9EBUuSeXKStmm5C
 RK30OeCRiPhNKUPvFhp1zgqgozl54QvOWXOZNSlXH2PBYrJrvTmsdXdBCDh/kPm8
 bsu3iYE/GsFxVjOMpPEYACL2B3aDsrMx7uKkPVqusKl1FN1Sbtl3TKzgNdiIJNil
 jbrTbhoER3WDf9dwBDapc6lvcoyjmlF1Bm5gBqyJCTMC2vlMEX3wJffFCjaLPYuM
 lguQLeohn/ytNjyUFlPWtMmVpcVRF/jmgvCtTR7jCVfmZK1cuP6e2CcQRASQ+FA5
 JFIfj0EYOE1eG81uQbARbzAkjY1Zw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2139.outbound.protection.outlook.com [40.107.223.139])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4747u3r8fh-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 17:11:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQqTXSQgaQOcDnSr2wmPYkVkwdBQniwpeECUft8q9JNgpUpNIuX/RtAxG0smzPzcKBm/9Rgx/fbyIjvsRhSKj4tFEDdeR77FifGK5GJ4v4gnDZoGydwP1MfNhAfrldh6+OwK4xlTtznqnFDmAhMxEEi1AfOnjwGcbyFF8RK0Vfb/os8WVzpshbpY0UovD58szs0fAwiiZ4zQ9gsQUtfvIQnIxc1z7xFh1GRVK98Ld1NbqmU86huwu+T2qnca0oDB+JqZRrak/IzV0631tEgahYzbRAGbZQGByIg267PBPYeLabvPBAqLNF9uNI6a6irFRPYdQZuXi/xNcJc34oEkKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JN2u1IJiIG9UH70AwmwkajUabBWu6GamPx886iAAWWw=;
 b=bUsxmOsG56h4AYmUz4HRLKju3PkjX/YqGIZBMJG6yHxSDq6CC++bPPohxS3NV5Bo6Ju9xQVdon0CsdzeGoJYLVJCgzTWh2MFZu7s0ARDgsQlCyw5WIZuOzb7mJooSkTm4hvUFibXLxSLd4Y4AyCp4uGpOkrUx6uDU9JG+7GWaVfKjGzqX1+hG1DdlS3B/+KUvhoE94SZheAAjFhAspv8pTuy+t9zafczKFBXPVUxCoLWjXkzlsO9m+v8r2cWNoOzyM5eqse65gr8y7XWwxEUzMs20yO0M6QujOJWyWEHjJzMMmIT16En7vC4FJZ6GaG/QY6fUm9BRTV9iMpmX0nCJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN2u1IJiIG9UH70AwmwkajUabBWu6GamPx886iAAWWw=;
 b=DzVCpR0UuMPzKBDmTJ3AFGen0BzrkOeTIaKbS/zvP220+np5CQzrqJ/MsLEFy2Ftj8RFfQi0s4JGeS2I9FwUFlCzC0SvIl3QYUBdpKv+rR9gHhA3TLT47JJ3DvKN8kiwAhrkhMCS7gFWqehb6VOjjZljb6J89f84CVIv5SWDZCdBI6nWaTAf5UEUskS1FLbm4FZ7OyQC0MJo/12ASQxyzLrN6/ZjgnGML7+NkaVFmz0M/xhejMKtN3sRtfzurJhQAPceNsCITpVxtT0m61d/eL057EyZsgrcHPAmco7Y1CMSrOigVz8pJbp7fZYXJyurAHObJBrr4MRPTJKvPq3MJA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8715.namprd02.prod.outlook.com (2603:10b6:510:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Sat, 7 Jun
 2025 00:11:14 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.016; Sat, 7 Jun 2025
 00:11:14 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v3 11/23] vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO
Date: Fri,  6 Jun 2025 17:10:43 -0700
Message-ID: <20250607001056.335310-12-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607001056.335310-1-john.levon@nutanix.com>
References: <20250607001056.335310-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::19) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e185ac-1c58-450f-0612-08dda557d119
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x8BUzLDlZV83di7aMwxk+6FBVGQuuWF4CQRRctdnxISnHShBqZqPNBp2MisG?=
 =?us-ascii?Q?qQBksFPHw6a30b0s+5Y1FB0GSg/OIDKqLjU0T451byTOdxu7jNNuSGL9s5f8?=
 =?us-ascii?Q?6lAJco2ja1DjnHjywAx+luLQDW371iZjb1X6fD7oCfNEf1NP8eXgd500Xa0/?=
 =?us-ascii?Q?rhNz/p2CBBUair3tYk+ctNUGc8GDzViK2zGeOYTKjUTbj9MIf5YLVB8euBiG?=
 =?us-ascii?Q?3gJumf2ST6uPXXWZVqXKCsOcvIh22ApE6l13vICE6MLUe8NQaR9nhEq/H3Sq?=
 =?us-ascii?Q?4TYB5AVnCh1oEKBZS51i2VYHna+wRsjoq7UoD4FIX0moTqlvrvEpH9qLPQMj?=
 =?us-ascii?Q?ZIXXFulanvkuu6qpXCTnCmuM3Ie7qyeBVmQGDYxrlr2EqNqSGrbM2P+fB2UI?=
 =?us-ascii?Q?+4w9spLsDjechCVKOsmYxHIBIFWcqXAVXDmqFfdASveZsQsdTJ5OuNYncZt0?=
 =?us-ascii?Q?ZPSIbGxhz3NYBUfCU8xSEQnHsZ96Fxe99HH4evpysTsPqvAXUGtjQZX6K465?=
 =?us-ascii?Q?uLauz14+nFWgYIk+wdZU8M2b9MoqfB0hhnJliYj3sO3d+3S08wx8mOpg3wSa?=
 =?us-ascii?Q?Mub7U+l9p30LmMfSiC3IqEGhFdp3E4kB+GkIE69/9WgYV0kR4W4wDYSDfOXM?=
 =?us-ascii?Q?ur60v33nnsckwE7HWh7cmU1r3ABtHx9ZPpuALagyl3n/9Gw7MKzXUzhpsog2?=
 =?us-ascii?Q?3ST0KRJIK11951RkanSZFW5dsZJNyHrVJ+wNuJjm1EjrA7lil2U2V4G7DUCf?=
 =?us-ascii?Q?q525lXIgAGlwO6NTQk/6uk6kJ8b0fHUBU1AuFnWLi0NJltjXjtt6WI7DPO0X?=
 =?us-ascii?Q?KeL1ZBnn5GgRHAxeBBfn+BlzowtqXzbdpP0Eh6fD2cYQK3yn/8DXLBmD9IAx?=
 =?us-ascii?Q?dzGhtKSz8ADupvM3C+J/tQkkv74GIXPtadIz/u6kyNhwM+aGt9fPjivJV5ww?=
 =?us-ascii?Q?e5lWV6UWgiuX6Oy671DcRSt5WRrJ0uTY6LMe2xhA1as405VeFE+cDIIyc20e?=
 =?us-ascii?Q?Tcj1xW3geqwBBD89t/i6Y8O6dvO/+0Fw8luSPQYkCnnC/Dn1ug8FUyYQaLDk?=
 =?us-ascii?Q?8bPB34xrdKN6/JtxmcDVcQKYneGCTYG6HBF949d/OF+EXr97rkvwcmU+LoUm?=
 =?us-ascii?Q?kMwhNgJIeL5xWs1PACoUdY3ao0v2ebgcdrH1fdIllSGzLbmXrgNBE4M90qJO?=
 =?us-ascii?Q?iQEK1/CSkdF/dMm/2yq8sMJFm//awrFO7fUlYy+bEXup5wPQ0bO/bT7WAPHB?=
 =?us-ascii?Q?IsrVS16az+1qvFP3vsm0YbDx9l9yCBSgID1nf1AvGNPGPeFHMq6uVEcCddMB?=
 =?us-ascii?Q?VO7bASuCl5mr3gUNi6ECvXCTfANw7AOYb9fgtDYubcljPgTgqhsAh8yNcIOd?=
 =?us-ascii?Q?DQtRDKeiA9ekeOYqaaDufCZyLcTR9eZFkxOZ0fe3bM2vCF9qCI98Rru/2Jsp?=
 =?us-ascii?Q?xtLTnX/Zd4c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vYDhRYt+f+ia+PGRoGEz9Q/a4CVmavjULoYa5blP1SGLpGKB5DmvzlONW20Y?=
 =?us-ascii?Q?DMQJtFQzKkmnjwSZvwyRqefFsR7x7qHXP2bLqc2ZPelpGOFa+oWIUwme+Mer?=
 =?us-ascii?Q?OSVH1n322rj6h0CXcu6322ATLF+/fjS65mKsFrZGFKJltbpLayCafEiYvJDO?=
 =?us-ascii?Q?Dxg4kd5EME13z+W07zUVHsE/ctTBXLNUdam5Me68pcJn6SaQC/Xy+Z28Rmry?=
 =?us-ascii?Q?4187kuHninKoyL0fFsxjpEvNvf6IcCFY4SWjgPXRhfLiEKoUfAiiwPD/3rkw?=
 =?us-ascii?Q?KQoK/1/rQc0D9fnOvjIaeYQimx2NVfVEM9kyOiEVJr2oc8EAW5CMqBLIGX65?=
 =?us-ascii?Q?t5YZKVaCqZ7fJA3t2EZuDohqToQoywv+0jWuDEsl13pD2PraxqA6BZ/hVwV/?=
 =?us-ascii?Q?jJA2Oo/29PARjtvvCiWFK2mb5mqG5jyzGqFeQs0ostgl2JYwizHQ0rJbQA8h?=
 =?us-ascii?Q?+iVKXzsYeXZBS6Vow3MrAgMus9bzr2svB7q9gdB9BbXKUJll/ZH1DogK9bn9?=
 =?us-ascii?Q?+EzwNV8Tliy3e4Rg8Z8hx1G4dnOqAQGK0hrAj+7dyGzy4iXUBp4ewaQCjSm6?=
 =?us-ascii?Q?/AGFrcnHraykB/h6eCpNZIUYVPjb+Gzqi3XSLDZODLK7rSJ+GcFBpV8ndq+l?=
 =?us-ascii?Q?NEynzcyvEmnB0CrbxGlzXfcuDqF1CSbPFRyrxlWYSgEpQ3QijOkg4pID9/iS?=
 =?us-ascii?Q?MYRdnEsaH9GnXJn5JJHG0Tiv5ntAI44RcoH+TDhrL1qTRr/uTQjCNMoahRTv?=
 =?us-ascii?Q?5j+An+X3t3r2p0eqxyZQCqQfETscYLkH2i81kGg2TR82nx2tm1tY2f1lmPNB?=
 =?us-ascii?Q?RBOc/r5ULoQ1/M88pwFnyJIgLBV9MRl4+20DVGoSS5/0aB7z+fvGsRC3RE5t?=
 =?us-ascii?Q?6ML/aSmDYk9MhG54pU8Xhg53CPZqjzmDgFiOw5+t9S1aSHg+lQIFF2UQ3lJM?=
 =?us-ascii?Q?l6Z7Oik5L2h+jqP/5i+/2SQFOyQTcJMIf6qpAq7JMgih63o5oqM983MkXwhw?=
 =?us-ascii?Q?nQaxFiBWx6F5mtsU97zQ2sJmXG9n2vftBaRrX2Ec5sAM+LiYPJ7pwrhwP9xh?=
 =?us-ascii?Q?Tc9/GHFlaSJOz64InqsaMLXBokWTsmxlMRbFudJzQRM5Vtg+O6fI3u0JSNRA?=
 =?us-ascii?Q?qfrPb6CuyuPEOPBmsXuvYmNsg0pb1r0+OFcXMDS291mkGIgVhTmRS7c+a3Pl?=
 =?us-ascii?Q?U0io06p3MW3g1dWu7sGMBewuX5k8AlEAeo0tx9rXNYpHr7QzsQ9UksH3wqrZ?=
 =?us-ascii?Q?IeefUrBloEtxTvhtIBITlkBT7c7jNH0Og/0hjgpWjwF6tF6jKcagUbHK6es0?=
 =?us-ascii?Q?uLP4C+6tZ9GZmEcP5Fy+ziBTvdjgZW4pxqfPVx5+kBPA11ZkaazzSxI+TVWJ?=
 =?us-ascii?Q?8EgNpSMribSmjwImWfSuaB2QlLAj5xLch6hoWcwHi8iI+AeXL2zYH2v290wM?=
 =?us-ascii?Q?StPKZi3bZLHLYDgg2IVHlnBeccfi7pE+X6IeL8BnBiZnISjjK1yejCdossgZ?=
 =?us-ascii?Q?QRbhOJGVn0rdb42TqZcoTq7Vb3GiTGV04M7xrq886hwhJ6znGCnVNgi/NGQA?=
 =?us-ascii?Q?9uANlPd8fNdbQa0NTY9c8Z282rpPN5SHs02xAuTR?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e185ac-1c58-450f-0612-08dda557d119
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 00:11:14.6889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RqptReJnj9QmYcXxZua3AAyQJvShoe28EPMEiPfwQvfrxpxLR3kVBjtY4QihMhvrflpFMvkBtIylCbjYbYa7nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8715
X-Authority-Analysis: v=2.4 cv=cpSbk04i c=1 sm=1 tr=0 ts=684383a4 cx=c_pps
 a=Cb1kLmlYO8D/Z2wQFUco/w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=u1fsugoMv0NfKDGiTLIA:9
X-Proofpoint-ORIG-GUID: grmvhtQ3h4tHs78IiYavJvXKQGq6R2AV
X-Proofpoint-GUID: grmvhtQ3h4tHs78IiYavJvXKQGq6R2AV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5OSBTYWx0ZWRfX0OCsQHBts3T/
 BJfd6cU+nWzOy8g2d6eRyDDgcRNFdOb7+aPDMy+3bXAPJNKVu8rSIYMwzQbF489g2VM1tlqPobv
 Q0uQnnUMYB6zgqNGBWAEmoU7CJijvqadTJ6v5DuwZxLvNAPsiRx2B2CvNm7BldpKUTbOZhyRkDa
 Dlh2wkKgo9+AEzuJe54fgHdo/sZpPmsH0Ascxp7xB0NihL0x+U+XUJ5xVKvIcY5OHWcobAK5fIN
 JPL3uHqYRzkBP7hc/KtT4cgRRv891N3WWLAsdRe+Cn4dyGGvfA+GLPo2lyAPVY0uujuJx/IZILE
 j70QFL9W4Oi8Qx6P0BZVpyVLvIW3xqANGnvO2m6AdsMp7B8NfdXlE9hGNPIpRhBTyT+ijByOTy9
 YzgYI98NePd2ktszPdIa6IW8UXH9oJs3mDObXc9a1eICDTpCvSGYsf/OnQtrbfxfVeS/GTw3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_09,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

Add support for getting region info for vfio-user. As vfio-user has one
fd per region, enable ->use_region_fds.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/device.h     |  2 ++
 hw/vfio-user/protocol.h   | 14 ++++++++
 hw/vfio-user/proxy.h      |  1 +
 hw/vfio-user/device.c     | 68 +++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/pci.c        | 11 +++++++
 hw/vfio-user/trace-events |  1 +
 6 files changed, 97 insertions(+)

diff --git a/hw/vfio-user/device.h b/hw/vfio-user/device.h
index f27f26b479..a5a2aa9ba6 100644
--- a/hw/vfio-user/device.h
+++ b/hw/vfio-user/device.h
@@ -20,4 +20,6 @@
 int vfio_user_get_device_info(VFIOUserProxy *proxy,
                               struct vfio_device_info *info);
 
+extern VFIODeviceIOOps vfio_user_device_io_ops_sock;
+
 #endif /* VFIO_USER_DEVICE_H */
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 648badff46..1878d44c51 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -127,4 +127,18 @@ typedef struct {
     uint32_t num_irqs;
 } VFIOUserDeviceInfo;
 
+/*
+ * VFIO_USER_DEVICE_GET_REGION_INFO
+ * imported from struct vfio_region_info
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t index;
+    uint32_t cap_offset;
+    uint64_t size;
+    uint64_t offset;
+} VFIOUserRegionInfo;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 9c6b2cdf35..e2cfaeead8 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -18,6 +18,7 @@
 #include "qemu/queue.h"
 #include "qemu/sockets.h"
 #include "qemu/thread.h"
+#include "hw/vfio/vfio-device.h"
 #include "hw/vfio-user/protocol.h"
 
 typedef struct {
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index e081033ff1..57793e6b2b 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -48,3 +48,71 @@ int vfio_user_get_device_info(VFIOUserProxy *proxy,
 
     return 0;
 }
+
+static int vfio_user_get_region_info(VFIOUserProxy *proxy,
+                                     struct vfio_region_info *info,
+                                     VFIOUserFDs *fds)
+{
+    g_autofree VFIOUserRegionInfo *msgp = NULL;
+    uint32_t size;
+
+    /* data returned can be larger than vfio_region_info */
+    if (info->argsz < sizeof(*info)) {
+        error_printf("vfio_user_get_region_info argsz too small\n");
+        return -E2BIG;
+    }
+    if (fds != NULL && fds->send_fds != 0) {
+        error_printf("vfio_user_get_region_info can't send FDs\n");
+        return -EINVAL;
+    }
+
+    size = info->argsz + sizeof(VFIOUserHdr);
+    msgp = g_malloc0(size);
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_GET_REGION_INFO,
+                          sizeof(*msgp), 0);
+    msgp->argsz = info->argsz;
+    msgp->index = info->index;
+
+    vfio_user_send_wait(proxy, &msgp->hdr, fds, size);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        return -msgp->hdr.error_reply;
+    }
+    trace_vfio_user_get_region_info(msgp->index, msgp->flags, msgp->size);
+
+    memcpy(info, &msgp->argsz, info->argsz);
+    return 0;
+}
+
+
+static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
+                                               struct vfio_region_info *info,
+                                               int *fd)
+{
+    VFIOUserFDs fds = { 0, 1, fd};
+    int ret;
+
+    if (info->index > vbasedev->num_regions) {
+        return -EINVAL;
+    }
+
+    ret = vfio_user_get_region_info(vbasedev->proxy, info, &fds);
+    if (ret) {
+        return ret;
+    }
+
+    /* cap_offset in valid area */
+    if ((info->flags & VFIO_REGION_INFO_FLAG_CAPS) &&
+        (info->cap_offset < sizeof(*info) || info->cap_offset > info->argsz)) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+/*
+ * Socket-based io_ops
+ */
+VFIODeviceIOOps vfio_user_device_io_ops_sock = {
+    .get_region_info = vfio_user_device_io_get_region_info,
+};
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index bcef0ea341..c2e7283489 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -14,6 +14,7 @@
 
 #include "hw/qdev-properties.h"
 #include "hw/vfio/pci.h"
+#include "hw/vfio-user/device.h"
 #include "hw/vfio-user/proxy.h"
 
 #define TYPE_VFIO_USER_PCI "vfio-user-pci"
@@ -101,11 +102,21 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
 
     vbasedev->name = g_strdup_printf("VFIO user <%s>", udev->sock_name);
 
+    /*
+     * Use socket-based device I/O instead of vfio kernel driver.
+     */
+    vbasedev->io_ops = &vfio_user_device_io_ops_sock;
+
     /*
      * vfio-user devices are effectively mdevs (don't use a host iommu).
      */
     vbasedev->mdev = true;
 
+    /*
+     * Enable per-region fds.
+     */
+    vbasedev->use_region_fds = true;
+
     as = pci_device_iommu_address_space(pdev);
     if (!vfio_device_attach_by_iommu_type(TYPE_VFIO_IOMMU_USER,
                                           vbasedev->name, vbasedev,
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 6b06a3ed82..1860430301 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -7,3 +7,4 @@ vfio_user_recv_request(uint16_t cmd) " command 0x%x"
 vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
+vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
-- 
2.43.0


