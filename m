Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D20C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 13:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Vo0-0006rT-OM; Wed, 09 Apr 2025 09:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2VnX-0006Zj-Fa; Wed, 09 Apr 2025 09:49:01 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2VnT-0005fo-LE; Wed, 09 Apr 2025 09:48:58 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539AOBIw003397;
 Wed, 9 Apr 2025 06:48:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=icqY+0ndLgLvbnshgprH45yu+aYSHBxbrH53ZmSoB
 T8=; b=pwIeZxeA/vsjhlhMUABPAPHt4+aWnDyXkwqFjKneFlGqN/QwrjAkxBO4T
 geUcpr4r66ipCOGg0Oq9dZV7EYAhPGImzfLQCC4K32nYwuTNml9yoL5s/FSemYNX
 +l055O7DGP0cZPc42W94VQY+tvSCTfDvm97fx2MYLrzOxq9x8CV3cyD8hb9GfPkP
 CKQqRMMeLvESOpNFJmMuGg8YtkshLJw7zK9afGl/2LV7NVnarexE+nPVj5cDQC7G
 UvLOAqaSc2ylzRG9WXbdHUoKTSNYuK6tI8JsWnmZtyKArTBJCTM66GmfZqQ9l+Lb
 ppEirt8m8NhJFS+4jLPMrKBQgQBJA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazlp17012038.outbound.protection.outlook.com [40.93.1.38])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 45u22aj4ux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Apr 2025 06:48:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wddFmyhLsElIUNrG9iBowwgzBS8Nl8R8e6LulF4CEYu7b8nRmUMq8mfKKb71E1sTS+iIhZJa3ataXSwYn8oMHDb2Nef8qd/jjCyMADQjpj38NgSX5e8G4Sx32ESNnq+orZ6NVs36mZ/hCgwYmcODELSwRAj/9yiDf/woHaCRAUxBcn0aVi8OxU/UzE0mQpaJwhHB4nTcb5JYabW97BOaWj9szTZhWCQP21CN6uicLs5i0r/B0yPeSSVeMQH+zuWwBvFf93t3oAFKyFK9zp6yLTcpctobW1NnhhFE3TrGcK0AG9QfGsSYw3Qo6FDGw02l3fDNUbd5KzjISZfi2NCX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icqY+0ndLgLvbnshgprH45yu+aYSHBxbrH53ZmSoBT8=;
 b=XSDJGMU0JzAuu4Eyrmw4jvz7FO8t9g7TYsYXgf3LP+EcL41QgscNmnrlLcU0KlrANwOi8uUCC7nvh3QVE7ZbjyvbkrmdtMEqq2gMI303dKmuCXn7dWEKe85a+E5IGClMVbdsQGQCHoMnQSvM0kp92ol5PZYd45d0JjACdpbNXfOrb5cbrSvmsEktHAwRrlDpxVa0HeiMxatr5l3LKMYtJEvcoXsa/XawF35+FvXJvRR7/Z4NzVhNe3nByr9JeAR2uj/OKfu8ptNE4V04mULPcgQNNq5aiBCuMAMf4MnxwJ1AVdotSTu5ngZpNiRqLz3DfcjJuNEXQXiGFHN05VhB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icqY+0ndLgLvbnshgprH45yu+aYSHBxbrH53ZmSoBT8=;
 b=EgEh2i655UxXsSPRJOZgCfzgihuXhUwgx5Dc9Iz1op7HlZimKpAWpg70GhIQionhn1c8K45TmBSMUioENTlkOFV0CtlUtyn8ugBYUjGMrn0lVN+38Um0NavQiNuGEq7+YYzrm8GT29u97q8cFarRUH+O+8/cSd8wWQcWyYWerMch47mawhUGFVxcOKvInpYHoACRCaorBT1xAI+J3oC4SS/REMzy9NjJvzaKmQSqrJgJdL7zBE11gBjgHM5bgfv8kCctl1YOfzVzm7U1Vdgh6iUDJjU3VHdmtTwED3W3QyWmNkMsiYw343GQSruIB2ogTagO3FBuvk5qkq44zSBdWQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by MWHPR02MB10356.namprd02.prod.outlook.com (2603:10b6:303:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 13:48:45 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 13:48:45 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 09/14] vfio: add vfio_device_get_irq_info() helper
Date: Wed,  9 Apr 2025 15:48:09 +0200
Message-Id: <20250409134814.478903-10-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409134814.478903-1-john.levon@nutanix.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0028.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::33) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|MWHPR02MB10356:EE_
X-MS-Office365-Filtering-Correlation-Id: 647d1eb0-3713-45e4-39fb-08dd776d3f18
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/mkDEUJ9dYzbx7PuEfD7pOPjKmMHnRf1CprmKr6WmYJyGoefjn2uM3pOMhc/?=
 =?us-ascii?Q?9sosDH96D7uFZf5F6pFgoy7T2jOGeYgQSYZMB72k0WJ3WS/4OB6DT/9WpcVG?=
 =?us-ascii?Q?rCNBhLLoS4P3NBL2bQ4bGGpebNmFi7P85hufaV9OIeVmazwn6y4TYbYUjdvg?=
 =?us-ascii?Q?8X4wg35qPEVDvy8wLiwVoYzxzb8z6kASp7mjTEouL4LXWbrhHjxkPGm9iDQ2?=
 =?us-ascii?Q?wmYXhKTo0qhdKw8Nge/lb5FyT41+yXlQTfVjOBIHg4wEpuE5L40KuFyzUYdC?=
 =?us-ascii?Q?CcxlRCjis//J9vaDcpV0oDQioNce6Qk/FuMUC9C23kC+Hp6NQriyJFYJ1Yys?=
 =?us-ascii?Q?d6DRkmSQhICG8tb+IPLPedIsjXqk3C5VQkBPAhTxoJtCdchfDZYZMziH6gAY?=
 =?us-ascii?Q?Hlit5upzN5AYUxRmLRAxj6PqII4SHjexLeatRWByBYadvSQHcvgvD/Yg/Slm?=
 =?us-ascii?Q?Y0VWNDen7YgCQaUsh+dDuioDEhJl5CJb8Ttdhm70kw9YxQKMC3SUEApRWwb8?=
 =?us-ascii?Q?aIlkZJseFMgJgNGXlkZ3RR1i1OTUBDtSRhXLdcrQv/8KKgh+AILVIi9i7C6+?=
 =?us-ascii?Q?T1CbEkaBS+UMPb3GDCq52FlMXDXcMnieJRZ3KcsrcKjKseuGq4i54hgD7s1R?=
 =?us-ascii?Q?BxcVzkFELexXv3L6/2kkjzayGBYUNUqwZDa5CqKfGynfR7coetc7aF61FHA4?=
 =?us-ascii?Q?K0jELk45sPBkRT2169iEa5nnd6zb08ENbiIXnzv0I235qCG/HOqLHCbiPjms?=
 =?us-ascii?Q?pKdC4Wgvf2orJGcAF4IEAaVmarl/Axhmd5LMyvogZfLKsvH+RSLl5KaVaV+5?=
 =?us-ascii?Q?Xm7xbmu3Gv8OB5v94Phps5qvxXuMlEvVerTwk9lhNfpmwZJSxsU3PhrXm4X4?=
 =?us-ascii?Q?Y+Z+8Pn5qubHmiyz4dotbfWx0EvnF5gHs2IozeSmALqPOLBbKXPI+aJDA2S7?=
 =?us-ascii?Q?A7W8qCf/ZGTrl1+aaD0pqjjFbBbB1AR2DcZZF5X0pxhXBoy8mXWpYjeKTOgq?=
 =?us-ascii?Q?3Uq1HPbP8yxjnelj4/rHVmw5ud28M9lE9FuFXdaZJZy24Sk7qIZ0hYnI3jjT?=
 =?us-ascii?Q?EK3mUDZC7gZ5b9wWyY4PyMeygPBylV9Pv76RDACyO2pFHchGXD4Sh/1QMZg3?=
 =?us-ascii?Q?ad1ZpSRQzsXHSNisooY2PqUdOlFT3nlcQQzWs5BunurKUpYjJIHnVtub4uzi?=
 =?us-ascii?Q?wfdP4jIcR0wU1hQkj73H3XvUpJQilzE8smfNlHvCluaQJzL069Ehqo1kqyhO?=
 =?us-ascii?Q?D8zKl4SaxqcLF98YGdeFDoAZPh2uZZbPDmxoeoGkrqBr5rvpuhVZSLO/8G5y?=
 =?us-ascii?Q?YONoPeWdPZNFyoTFosm5Ybbscn+HQUKp2OGpAKyTSzOO4kcKUOJMxZx8SOSk?=
 =?us-ascii?Q?i3hH2UyF3Jk7gLbja5dAqq5xxO+K?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OIOQF0oEiJLnAbyCt/HW1KjJCHV83935meZTBsSqHYj5u2b17+urNpi0MhbA?=
 =?us-ascii?Q?1qQgY9VNCJEvvtgXFbWizN0UTKR0WIUD4Bhe0BrXFrMzD1NFgU+H1aCZz5gb?=
 =?us-ascii?Q?EefpAj4odL6/mo4L2/8YwpUqt0laxGr5nYZZBdrnsUZNZkrL9lX5F8MmcqAa?=
 =?us-ascii?Q?Ab6/gMNC66Cuk0FmKZqY3vHMqHyxvtZh6LdtosUNdwc1/cjsRVTQgVMQ1NN1?=
 =?us-ascii?Q?RrK9oBkh0WXF3z1hS2H9G8zwCm/54vaOEQrjKnkgqGHhXr4U6U8/robZNhD/?=
 =?us-ascii?Q?amO2dIRLJe5wTy5SewYAcRLZ4CvVytDa1f7CFIlaQ2256oPj1vtxBlZv7J11?=
 =?us-ascii?Q?r4EBFP+PdmjXmDZNuJDodosTErz5r3eOVFnzybrtmE5MUrAFGVyrI8hZ8FdF?=
 =?us-ascii?Q?pCyHxmRtUaFv6+jgnxPEJvJ79EANt2eiqmiwU2sB0/NzJOe/OT/8VrK3JE12?=
 =?us-ascii?Q?KQeh/xJOXnNLquo9W7oH+CpTVJi/hVMH9r/7iXCwZCl3SgKhbiouWVIMlyiH?=
 =?us-ascii?Q?HOvIbAosDWSaAuu1ow8Z6e+nWRq0eQYipC7nvF64dvFJr8xVvsvB23wZ/Duo?=
 =?us-ascii?Q?kuTwGNy75+rVk8IkRrtveZsKYeuhiDVm9Q9VKTQM9Cyshz26vTlur3Y82STt?=
 =?us-ascii?Q?gp63Z7zrzViC4yXEH3rsf9wqi+RNDrPCBECc23HAC3pdKc7u6CYufxA8Yd8w?=
 =?us-ascii?Q?iZEoq3E7uTzQn77UaroxxMmoDYdU3Zp/j/WnrQeArn5GH/upk9HyhL9lK1H1?=
 =?us-ascii?Q?G3Xrwx79FrMZ5EqoLY1p3i8AgvTKJUova960mahVhfHvy6ypDNxVKV1WG1PS?=
 =?us-ascii?Q?rWvzVdRY9WxTsOGIetn/qOJ696rUIvmmBsISjlSCP/oiiXRD8lsUE09NRooJ?=
 =?us-ascii?Q?7mCdPCuwz3uKZHbF56DnLvxMaTuRwrmWZcncyWn26knbs4w28gW9O9nsPueA?=
 =?us-ascii?Q?kbUlFqJ6trwT+zezqV4ozgo6lE9IB2B/rKRef8uCeVcAlXTJTSZ4Grjugc0I?=
 =?us-ascii?Q?B68U31w3CR/R9Er4hD6BdQoDqV/s9n4XWPO3hew9+FuOAWzEwUGdmKPewEWH?=
 =?us-ascii?Q?H2JRggQozZGTAy7f5MBGDw1sY2gwPcFenhvXls88ICnozd3GTMx4sakfh1Vs?=
 =?us-ascii?Q?TYv+/AFOznHh7aiZuEE3IjmZfPvAQ+42nsrpvWhhDhxwKW9IXyNMhPzR4LVD?=
 =?us-ascii?Q?raNuAa3z8GVQi+JNjRxmtaFroXNWfZWA2npAP3rAyIoujPAzR4gm7a+lnuNK?=
 =?us-ascii?Q?Cijfez3Pir1t95ettk3eqpUW4MDYRvLuAeXVcOiK8XyODoy2vDiOdCIoNA+j?=
 =?us-ascii?Q?yA3r+H0FklUsnDV8w9CiiFe1Ppua6TLK7mF68zhCyI24suTumXfjKcyqH04C?=
 =?us-ascii?Q?Qb6FiOfynHzVG9FoBN4DiSqTLa5jRyIulmY4OkdA6KRNAGa2VbhjTdKWDY4w?=
 =?us-ascii?Q?3epL5Mfwia/7VRdeQdyP0/4tTgJ94L4QToymzY9u94/MInKuYEj+FcI3aB+c?=
 =?us-ascii?Q?gHe1SPTCvMECTKyphnLWGdcfDd0Dr0mmt0l4uDBHfqmEtVMBEeMPKsDKLFU7?=
 =?us-ascii?Q?6KxMCwFw08GWFDPbifRW83t+84ycUoJuKzifwBLz?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647d1eb0-3713-45e4-39fb-08dd776d3f18
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:48:45.1627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1pcjSTL5EoPvAFUwGvSM9/nLQnhCVvgxgX/fwiyNOeNJbaiNpljEDlcnO4vG002jZQT4VcDUJLXe07f7JRXiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10356
X-Proofpoint-ORIG-GUID: 4HP9G15rMBbMBzSF_wu8oy9rxqzdgKkX
X-Proofpoint-GUID: 4HP9G15rMBbMBzSF_wu8oy9rxqzdgKkX
X-Authority-Analysis: v=2.4 cv=Xtf6OUF9 c=1 sm=1 tr=0 ts=67f67ac0 cx=c_pps
 a=a0mreH8AhMfks3Nq6fhO9Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=vT2z2tywOHHVet3RVBQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

Add a helper similar to vfio_device_get_region_info() and use it
everywhere.

Replace a couple of needless allocations with stack variables.

As a side-effect, this fixes a minor error reporting issue in the call
from vfio_msix_early_setup().

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/ap.c                  | 19 ++++++++++---------
 hw/vfio/ccw.c                 | 20 +++++++++++---------
 hw/vfio/device.c              | 15 +++++++++++++++
 hw/vfio/pci.c                 | 23 +++++++++++------------
 hw/vfio/platform.c            |  6 +++---
 include/hw/vfio/vfio-device.h |  3 +++
 6 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 4af7379d4f..f311bca5b6 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -74,10 +74,10 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
                                           unsigned int irq, Error **errp)
 {
     int fd;
-    size_t argsz;
+    int ret;
     IOHandler *fd_read;
     EventNotifier *notifier;
-    g_autofree struct vfio_irq_info *irq_info = NULL;
+    struct vfio_irq_info irq_info;
     VFIODevice *vdev = &vapdev->vdev;
 
     switch (irq) {
@@ -96,14 +96,15 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
         return false;
     }
 
-    argsz = sizeof(*irq_info);
-    irq_info = g_malloc0(argsz);
-    irq_info->index = irq;
-    irq_info->argsz = argsz;
+    ret = vfio_device_get_irq_info(vdev, irq, &irq_info);
+
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "vfio: Error getting irq info");
+        return false;
+    }
 
-    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
-              irq_info) < 0 || irq_info->count < 1) {
-        error_setg_errno(errp, errno, "vfio: Error getting irq info");
+    if (irq_info.count < 1) {
+        error_setg_errno(errp, EINVAL, "vfio: Error getting irq info, count=0");
         return false;
     }
 
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 98aa0000da..dac8769925 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -376,8 +376,8 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
                                            Error **errp)
 {
     VFIODevice *vdev = &vcdev->vdev;
-    g_autofree struct vfio_irq_info *irq_info = NULL;
-    size_t argsz;
+    struct vfio_irq_info irq_info;
+    int ret;
     int fd;
     EventNotifier *notifier;
     IOHandler *fd_read;
@@ -406,13 +406,15 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
         return false;
     }
 
-    argsz = sizeof(*irq_info);
-    irq_info = g_malloc0(argsz);
-    irq_info->index = irq;
-    irq_info->argsz = argsz;
-    if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO,
-              irq_info) < 0 || irq_info->count < 1) {
-        error_setg_errno(errp, errno, "vfio: Error getting irq info");
+    ret = vfio_device_get_irq_info(vdev, irq, &irq_info);
+
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "vfio: Error getting irq info");
+        return false;
+    }
+
+    if (irq_info.count < 1) {
+        error_setg_errno(errp, EINVAL, "vfio: Error getting irq info, count=0");
         return false;
     }
 
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index b9473878fc..2966171118 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -185,6 +185,21 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
     return false;
 }
 
+int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
+                             struct vfio_irq_info *info)
+{
+    int ret;
+
+    memset(info, 0, sizeof(*info));
+
+    info->argsz = sizeof(*info);
+    info->index = index;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, info);
+
+    return ret < 0 ? -errno : ret;
+}
+
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info)
 {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 090b2f2ef0..ac53c43f2b 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1555,8 +1555,7 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     uint16_t ctrl;
     uint32_t table, pba;
     int ret, fd = vdev->vbasedev.fd;
-    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
-                                      .index = VFIO_PCI_MSIX_IRQ_INDEX };
+    struct vfio_irq_info irq_info;
     VFIOMSIXInfo *msix;
 
     pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
@@ -1593,7 +1592,8 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     msix->pba_offset = pba & ~PCI_MSIX_FLAGS_BIRMASK;
     msix->entries = (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
 
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
+    ret = vfio_device_get_irq_info(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX,
+                                   &irq_info);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "failed to get MSI-X irq info");
         g_free(msix);
@@ -2737,7 +2737,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     g_autofree struct vfio_region_info *reg_info = NULL;
-    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
+    struct vfio_irq_info irq_info;
     int i, ret = -1;
 
     /* Sanity check device */
@@ -2798,12 +2798,10 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
         }
     }
 
-    irq_info.index = VFIO_PCI_ERR_IRQ_INDEX;
-
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
+    ret = vfio_device_get_irq_info(vbasedev, VFIO_PCI_ERR_IRQ_INDEX, &irq_info);
     if (ret) {
         /* This can fail for an old kernel or legacy PCI dev */
-        trace_vfio_populate_device_get_irq_info_failure(strerror(errno));
+        trace_vfio_populate_device_get_irq_info_failure(strerror(-ret));
     } else if (irq_info.count == 1) {
         vdev->pci_aer = true;
     } else {
@@ -2912,17 +2910,18 @@ static void vfio_req_notifier_handler(void *opaque)
 
 static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
 {
-    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
-                                      .index = VFIO_PCI_REQ_IRQ_INDEX };
+    struct vfio_irq_info irq_info;
     Error *err = NULL;
     int32_t fd;
+    int ret;
 
     if (!(vdev->features & VFIO_FEATURE_ENABLE_REQ)) {
         return;
     }
 
-    if (ioctl(vdev->vbasedev.fd,
-              VFIO_DEVICE_GET_IRQ_INFO, &irq_info) < 0 || irq_info.count < 1) {
+    ret = vfio_device_get_irq_info(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX,
+                                   &irq_info);
+    if (ret < 0 || irq_info.count < 1) {
         return;
     }
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 877d69b7aa..fd176c18a4 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -475,10 +475,10 @@ static bool vfio_populate_device(VFIODevice *vbasedev, Error **errp)
     QSIMPLEQ_INIT(&vdev->pending_intp_queue);
 
     for (i = 0; i < vbasedev->num_irqs; i++) {
-        struct vfio_irq_info irq = { .argsz = sizeof(irq) };
+        struct vfio_irq_info irq;
+
+        ret = vfio_device_get_irq_info(vbasedev, i, &irq);
 
-        irq.index = i;
-        ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, &irq);
         if (ret) {
             error_setg_errno(errp, -ret, "failed to get device irq info");
             goto irq_err;
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 3563a82ede..9522a09c48 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -144,6 +144,9 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
                                      uint32_t subtype, struct vfio_region_info **info);
 bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
+
+int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
+                                struct vfio_irq_info *info);
 #endif
 
 /* Returns 0 on success, or a negative errno. */
-- 
2.34.1


