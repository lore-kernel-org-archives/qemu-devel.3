Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B42C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 15:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2XZG-0007xL-Ux; Wed, 09 Apr 2025 11:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2XZE-0007wk-Sj; Wed, 09 Apr 2025 11:42:20 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2XZC-0006tO-Ui; Wed, 09 Apr 2025 11:42:20 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539A1krX003671;
 Wed, 9 Apr 2025 08:42:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=swym0vmww9EbBv5
 haph+CLkdgM5FgiQEOXf4QGp6W5g=; b=noqOBA3jruVObNAWXDqsodiaeromVhK
 3db82185zWezJ1N60Pf7q2YxXPqkvV2bjHrq2sxhXNAeFtv/vcoW7L57Jyc2cREI
 zs24YbhHtsP72CxcuifuKBCXWgW/BnPlTJx7qemwV7U5IdVtpgG/RBNxVlImiAdj
 eBz/F1ReC5yTJNvno9mTA+yV28JCm2C3I50C94QZTNd04GHCSyfibXwlfgK1kqqP
 xEcEm8cwbyhOv3PYInPgch3vPsievsV2HrGzjcCRoAb/9ZVeiPSOA7RCrbdNdRaq
 xD8PnMzPqIncvrpdgsyQRE1sg7/iKXJzBU+jd6dzRvdIdbFZrU+PXcw==
Received: from sj2pr03cu002.outbound.protection.outlook.com
 (mail-westusazlp17013074.outbound.protection.outlook.com [40.93.1.74])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 45u22ajf8y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Apr 2025 08:42:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2Xf1xYshKgxCuYIPwoIy3vBukmKWx/OdSawhSC/NyloEhtN12IevI3zgAnYW0YNmB+o3PumLakRBV7sIlAzH3VJMc2t5+ZXoSyo9JvY09AmPSUzYzCrkDGzgd4FJ/+kdjhT45kEsi1DpjFsQF4b/rj/aUxUpPzHnEovqEbjp0yDtf1JJuOp5xcKW58Sx4GuVUZXto+qoYuY2jnki4KSiXOsBP5u4s5zwQywTlAPDzkUZVajVm8mjVwkyZyKWUqZx6LGqpPiBX0IjjEURDt9Nl5XQaNngeSswmqDLhrBpKq4yxcPopA930Yn/CgW2dGtNZ5BTf89zsuYDH+gMDa+2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swym0vmww9EbBv5haph+CLkdgM5FgiQEOXf4QGp6W5g=;
 b=pJMWNtiy3WKY2skImE6b7+cUvzfTp33h52Nw4PX7TW3BSgEbtUbX6OrZ1QcdPcUIuPIf8aaodd+ZtN7WHT7mrBiQkPs73sK19jSlT2+J9rUIMxKhXCKp9LYsQG1OsUv3Vt5ISOXRmmkgNOIwxrIdPPQwfhduh8H46gAWap6Cai6b4VLmFZMMzhZv0AJFqbVTZrwxYrAKstxIDtzK6YeXRePInZHUcI/6yYg3Cyn65SQuXNYik8YXgki5hGUmxIU7Jxug5wWFZZlPUwFWGJaMhUz7ijReL0xAqOg0/xCK8q+TH5YOn5uIKvW7shN8GThYs2i2Bv6iTRUj8ma0QARLGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swym0vmww9EbBv5haph+CLkdgM5FgiQEOXf4QGp6W5g=;
 b=jv1c1kxs3j3oy1Mv1cWzpXtLkI60iW3S0kSFucwkOMg9qzq8nL3vDztCRmJzGO4Aq+r0abqceuCiH3052hglZdVpdjADZUm/RU2El85CxzkI+DY3eLs6dX3bYN11MaeSiJ/jzRY140Fp3JKFpWi4GU2RceeZnF1GejCYqkrPJLgyYM5rYRzgPs9H5ehrc4R4MtmO2NpipSqxJWBiSSBenwlkMu/ENuI2s7ZKkvAG7TVTuVcRBa0qmi5PJIsKGMq8d0aHrQruZoMlU2QOyYkvWoSDPFBTmS8fREVE968f6+hcPo0q32OsPUnAwizgFZh6E8vygQqr+o6eKBgEWaR/lg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ2PR02MB10099.namprd02.prod.outlook.com (2603:10b6:a03:559::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Wed, 9 Apr
 2025 15:41:56 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 15:41:56 +0000
Date: Wed, 9 Apr 2025 17:41:51 +0200
From: John Levon <john.levon@nutanix.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH 02/14] vfio: refactor out vfio_pci_config_setup()
Message-ID: <Z/aVP8VYdf/RiK1b@lent>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-3-john.levon@nutanix.com>
 <593da0e4-6e0b-4edf-a0ff-7ff066baf4b8@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <593da0e4-6e0b-4edf-a0ff-7ff066baf4b8@gmail.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AS4P251CA0002.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::8) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ2PR02MB10099:EE_
X-MS-Office365-Filtering-Correlation-Id: 6410ad1e-98d0-4efe-616b-08dd777d0f11
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N7SRfpR6F0xdQGg6bDMSQjYtpfFnO8KpHXqGq7K1bgWc8g+r8W13/S5bZ+HK?=
 =?us-ascii?Q?mkdwHpraNdwIiET+YD55dQom1eM9Dh5TfLoSYCncHnX6o+oh7SgMnp65+eiN?=
 =?us-ascii?Q?iyoMkEUHH+o+86u8dyYzOoivxe0n9QGzg7z73o+saW4+MUh2Jb5X2ZiPRjtf?=
 =?us-ascii?Q?B9++wAc8pJ0iAyR+PY0jO5IormMNvGJtt45HhwBYUNgLs1UiOQ3lUYEs3iR1?=
 =?us-ascii?Q?yGSoqQ96S15zqsuRWTAjcxfSP9cakvUx6ms49F9AIy6DAtl7W+SlkyoD6I49?=
 =?us-ascii?Q?XIvbzrA9vNiCHS4atl/WX95QKviNAUDsMQOm0W0nSgaUvWZFHdE69j5N7UHw?=
 =?us-ascii?Q?u+kXKBCd0gbWuoD6acgUNLKbN3l7MJGrnIGfNMAF7MgyKFHvfvZt+HahER+8?=
 =?us-ascii?Q?yNfw6uUYpWQYL9exosCSFcxCyetKesdChEl/IAhM997uGl6wWpKEwJeXeqj5?=
 =?us-ascii?Q?PiOgCvOqM7By0VAyfy1q8ojsEv4jh0cu4Tk+0tfV+q9FaBTI2B42YToeWnZA?=
 =?us-ascii?Q?rUOhw/WhHQ0//LmdlRa7N1/3PQN+RgHHu9VcKMQAvoRFx5bA35QB4JROSPsS?=
 =?us-ascii?Q?AAf64Ohx0JNG7VCRDW2B91lWae3+eS09jaWd6mrWAw/p+15mh/BgnHaJOG1R?=
 =?us-ascii?Q?+CfyeBAt92K/aNqST1RrgVhsuZ8hUKi3tSlmwrRFNYyVsZrBJLPanrvVqB4A?=
 =?us-ascii?Q?8xMSzIocL9ZuWm7GYpqnLJXxM1EeCOm7Lwvrhj+KF9Unme99mSqd46mlnhot?=
 =?us-ascii?Q?M9kcv/GN/w8MPJRf8bAJC8QNAnkKOh/OqjuIXe/mram8itZV3d/W/mqRpXZw?=
 =?us-ascii?Q?JQCbKhSosG7H7Y9CCsRyn8v/y5h8xu1OUzOsRW7vpnTS/O9cn4X4R46mZ4ZI?=
 =?us-ascii?Q?gWXDcIAV2OlqYhhIYhnZTgU2NRIt/2SKQKe0PcKQ7sDKWERpZRPz3OLiMda4?=
 =?us-ascii?Q?oL4pJW3xzKLEY6aNfi7vTITzm19UIwGmnjeyBp5O7+lQUNboWtI9KS86CI7/?=
 =?us-ascii?Q?ZyX1h38CiuzG9QDoAJ0qLgDy3SNAXF3HUJ83Vfrr4Ud9BybzxLqC87HVXKHm?=
 =?us-ascii?Q?IdphLkmHbbyzxzTe85CpvWy071DFvmWszomTiCDuXexN37m51L7H6K0zU8ao?=
 =?us-ascii?Q?a/otSS54HjQVEEdPRQoW3Vq7A32Yacat3Y2jN8b9fvbNJIzKYRJpWOkj3EoM?=
 =?us-ascii?Q?t2Ry44+rlF809tEhKfeRIb+MxTKNBm9vrsFcmhLAaSU9fNVK3qhFYSuz7wZI?=
 =?us-ascii?Q?gVzePn03U/J8Qm9zQJfUsvhk+3Io2a6khRpPiI6ONVvujYDQY3pWr+qr+PXT?=
 =?us-ascii?Q?eVMIg7TPB29hLUQ67ETb4+m59yCIuJoh2JVjsqy3XS6qvKySwD4eurGL4qED?=
 =?us-ascii?Q?Vip/+5aOw9BGFtJztVdvym4JL/vG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ggfhG+wXjBRe4X917Z34VnOHzeK3OrEaLQdgik4iiXpDb+UIB9tiYPDUuMHk?=
 =?us-ascii?Q?I9suEgx2UXNLWwT/JhTsiHgJZqfgRh8QcjyqIZLAip3BQPqQdpVg//pqex3h?=
 =?us-ascii?Q?8yb5+D30fQUuYfBpsYKrwQFXXGSPQGok4fiUN9/3iHyyRdVvDaNRLBGHdZev?=
 =?us-ascii?Q?yUepu4dBziNUC9sWTYfbW2PpSCLuMl59JWn7E3trlvhNQPRr5JL+Zt7Bdnqm?=
 =?us-ascii?Q?dAM8JcdjzXhuqRH6M8IicnhYPb1U02gTCZG0e5YQ3JkCO13vKP/O5HHhOPoV?=
 =?us-ascii?Q?Z4MAQz2gxTvzZYbD4bJpssrxGeCz/fFiZFdEykPX8nrTY014m1OG7fJM43xC?=
 =?us-ascii?Q?EpaXDXkaS0erDq5iBbc9uYhQb6bwdb+vJ4+dvPLoEa24Dn5XdjOc7OQ439/F?=
 =?us-ascii?Q?lNj3ZnUYTQfVBesEx110z9NkR68gVIsZxUk7sf1pWGX8TH2Q0Fzil49FIdgd?=
 =?us-ascii?Q?Zw5J4W6yVBB/t8L4bIDhnirsw9WHUI3blNqXCsSA/nSGTDDVLF5j5WAEBCh8?=
 =?us-ascii?Q?1V7VEdqVFDDWeQOqZCEzeOv2hTLAboIPP3nOArIDyQqqwqTtNTpdLiOyiszv?=
 =?us-ascii?Q?JNwvmMzfD2QyPKmmmNxstAoE2e8MrDD6Mi4W8jfJdIC11w4dm9ApaBkWoaz0?=
 =?us-ascii?Q?o9kEMwWq/Dd6p1/AGxoxkX0yaWQc9BqL9ODtEswx71ZgjgYNd+BvfgwMpxyh?=
 =?us-ascii?Q?cLdCZ/HDJ7qD27CNTzqwZwjIxR0GXPzX48VfkH9Ten8Bg9BhwHt69tINkqWy?=
 =?us-ascii?Q?5ohVyeZ1ZZt/SzhyGPaB9qu9pV47m6WJOpV9blQstaJl1qHLy3l4Co4MASrH?=
 =?us-ascii?Q?B9j7zGRShKBWkDCtBGM1/9ktXnR8cck82Gpht6NrIHs8296xewPEUfl6CVUD?=
 =?us-ascii?Q?VYLFzWWy3hEHJ+154WuSUJlYgNWRRiF2UBsDJbtqMgL5XhbFEiwWsRL0IyIa?=
 =?us-ascii?Q?vK1EUGd9kO24gvvruAz5aShZfz5uj9w7tMxfDSZMLZbbvWDfAqxM0ltNfQuO?=
 =?us-ascii?Q?HDXK/4otWqDvlNG7OQlEc7tAyPoC9k8/zU8gunh5bHyx4AQpZWRlmqQW5waI?=
 =?us-ascii?Q?Bc9OvTRndwVtp7iMgtGBy3MvYVV2WlPnMbX+yrwN37wU2Vpwo4NLk0rCDW1W?=
 =?us-ascii?Q?3hcv4DE6FYLfRR+GNJg4jivqBwrfPDv2429kWmnXd/xbdWcVmSLCS2siIMIS?=
 =?us-ascii?Q?n7CEjejBYDOWKfbUv2G4lAGVMDbAo8dfm/Lx3iEFjHzbKUDvjT6Xs47R0Ny3?=
 =?us-ascii?Q?53a/wXxcRsML6hjKqs3Z1gttjFxzswWsLLsVeo++a73H0SgyO7x01sWLpBcq?=
 =?us-ascii?Q?8kYjeeVcFjdPaTAiPsWiZ09DLwMB5tpnu8q6OgPElyG0GO5k3EY9yK90q+tY?=
 =?us-ascii?Q?aYGTNE5DCNBRwWveJ25nK12ar5CWUjyyTrSRxP5Uq3DJ986dR841N7sWQYjv?=
 =?us-ascii?Q?8uySS6GO8W3JSjOa2kvlGGbT8kIqL5S2rBlM88UiM1kurbidH+r7c21/m8yh?=
 =?us-ascii?Q?U7N9s2DqVr7QwCFllEmTnAhJrJEhIOER3lD8E7ZTLWcY/Bc9GeIKlac2jbVh?=
 =?us-ascii?Q?A3Yti/6BVmEOi7m6QokyzVtEJ6kGfjUFiNg6YM/6?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6410ad1e-98d0-4efe-616b-08dd777d0f11
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 15:41:56.5435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6QDSviMCYGDi9vgI+UXo9zJJ5yNzG/MX7QvIp0xFy9EZ05H1n7iiAy0I4num5Hcu+epGDxXk7KTs1KsjpltybA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB10099
X-Proofpoint-ORIG-GUID: CcCx_3KKA0TQzsbBNR0A4NINzLcygLD8
X-Proofpoint-GUID: CcCx_3KKA0TQzsbBNR0A4NINzLcygLD8
X-Authority-Analysis: v=2.4 cv=Xtf6OUF9 c=1 sm=1 tr=0 ts=67f69556 cx=c_pps
 a=i5O+0KHWwz6AHTILDS7dZA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=0pXGIeEMlBia7p4PQMsA:9 a=CjuIK1q_8ugA:10
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

On Wed, Apr 09, 2025 at 11:38:01PM +0800, Tomita Moeko wrote:

> On 4/9/25 21:48, John Levon wrote:
> > Refactor the PCI config setup code out of vfio_realize() for
> > readability.

> > +    if (!vfio_msix_early_setup(vdev, errp)) {
> > +        return false;
> > +    }
> > +
> > +    vfio_bars_register(vdev);
> 
> Probably we can also put `vfio_config_quirk_setup` here as it deals with
> device-spcific config space.

This should be harmless (I think), but...

> I would personally prefer keeping `vfio_bars_register` in `vfio_realize`
> so that it matches `vfio_bars_exit` at the end, just a minor nit.

... this means that vfio-user (when it exists) can't re-use the function, which
is the underlying reason for this refactoring originally.

regards
john

