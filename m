Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9D6C021B1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklOb-0003Ln-SU; Wed, 19 Feb 2025 09:49:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOa-0003LF-FM; Wed, 19 Feb 2025 09:49:52 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOY-0007EM-64; Wed, 19 Feb 2025 09:49:52 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J9K12W024315;
 Wed, 19 Feb 2025 06:49:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=jEz2JX8x79y1IRqol+pvfhT7Ui8Oy5uDhNcOHBeJQ
 K4=; b=tZ7PUcnpvz0Dyur4GItorZYNvXUvO0+v2Jkb/VL8VaU81tYGrHzp+NqpD
 MNXzfx89Om0qS3S8xnaVpBEcHjIk4wcYoUEJsimRYaREHRfCvtrh0X7yTdg+shBK
 IJuiISjDkhihc5RjXdE3TNvvrj14N4X0uRQTYeit8IRBTpRBXwUf73Bt88R7mYJg
 4KUFXPV82kcKPObu88i/wA0pVmJAmHge6M6vVjUWOY/T7V4ay2AF6IinZv8BSCS0
 uPSnaU+iSfhqk7hKXE0fycjmwCNiV36+MnWEq/GX0ZEwgk6rsKhRAB08W+R07eCP
 q1K7llEkX0OMLbrPgEGLCdDGQar0A==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazlp17011027.outbound.protection.outlook.com [40.93.13.27])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4basxrv-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:49:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZXm4gbzwAEhh2LD7uilz+C7bpK8Ilq2Q4KWCXAsyNnDMNAApA8aqz7c4yCz3XPG+ZUjVjzhQ3Y9c7iZPNpDE/nA1QjkOhiyYaHiezml8nrl2dFmTwct1j8KrkjaD1v6M3FhrwDYNh0mjUKux1GWdHR5A4Q220aZAw/x543FaUCdUs1Hhe6k+AgRhEGyro02OBWcfJRoVduaQT1D1t6gw7bkX/H9QZV3JaMGmqwv+L6p05rhJpqS/l/HPxTAgZ/07y5QuJQ1drBdfaIt53pJvwpjt0cqYx//8gkXMYVSDQxnQ6CsHR+X2LDaRsU9BfybMYEADsWulFH30qyWvaHxWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEz2JX8x79y1IRqol+pvfhT7Ui8Oy5uDhNcOHBeJQK4=;
 b=wGSkX86Nr92T5TDo7iNnbkFx30Da39V2lnCR8wT3nm7IOClAxINitklS601g2BjXFUDzA+ass77grGFWuJV+VI4jrWRoJNqKVLBE280Qp7St9jpxaqy8215LejMJ4SyZ62FNew199QTSRZ8fUTg/sN28OzP0ipqX9QtPjXpdo21jiKTN2fVU0Bq3Hb/VY1adQah5RFOGM4LHH3qB20t1U5USfM9v3sREAE/I2wZXg3CIAYrAmwWiDlSS88FEeHtJhMpBpXkfznv+XhnUvV0DFFeXocfwbQogjnEevdyu4eXzZqeqGcOmHsGYsNLgXISkECgw0ZcQy6XQpE+n75D62w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEz2JX8x79y1IRqol+pvfhT7Ui8Oy5uDhNcOHBeJQK4=;
 b=YifWNKVvjsXZfzItdH1tXi+C01of6OGnlUy0lVkONmY8lvlxfPjymLaaUXIGiryeOuURDXnmCyHcPdItX0qf6UJngb01uJ3CmM+CctZ66LGr2yR9M7ksZoCM7S90OF4ARqyOF0EhlMjWNUbPwmZ2kL0s53XuQLD2KduzEIBAaBg4QuM1U0pTJP7UmMqmyUt/vNLb7dDhfX1LbyZy7SQiODG0AbkId2d3PyphPyEz3qlfBluW7WzsOkOLWC81uGtp4RZMOdYAM1VwJyso0572CQkzuDP+6qbIY3u5WgolleVGZTwDRq2JcGyi4k8DvTDa+25LiOf9Rma43PzVOvzyLw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB10559.namprd02.prod.outlook.com (2603:10b6:610:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 14:49:40 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:49:40 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 John Levon <john.levon@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v8 09/28] vfio: split out VFIOKernelPCIDevice
Date: Wed, 19 Feb 2025 15:48:39 +0100
Message-Id: <20250219144858.266455-10-john.levon@nutanix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219144858.266455-1-john.levon@nutanix.com>
References: <20250219144858.266455-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0154.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::21) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB10559:EE_
X-MS-Office365-Filtering-Correlation-Id: 5195534f-0760-4d32-f2e3-08dd50f4a3b1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8dGBbExDSMLelYgUws03h/5kOijffNeqEFqylS/K1Mpde5GA8ID/9+TPUKAG?=
 =?us-ascii?Q?+f7/UQs//1RKZTKsx9I0cY6kREU0/qPCGyT+g8vqUFas4OdSs5wQSdfYlsSE?=
 =?us-ascii?Q?RRZhYaWRGWn86xpty30W3K1lJaFnzMIhu9+fJdFLOLChN6YrUcNf6DpyCeI6?=
 =?us-ascii?Q?zvd/nKobBCOYIAfzBqL3AVHBu0xas4rO0C+IupNntvxOBNatJXit+otl6ydc?=
 =?us-ascii?Q?pMOPNzQPHH0AUPT145Sl+d0sBNRXrvcLUfz34J3cohiAntmahGCMUspPlx0P?=
 =?us-ascii?Q?XhZZzTv35XZ6AD80LkUaTDlJcs3yHOnxS7p7Fkzh/YVFu7rSm48ES1SUfp0u?=
 =?us-ascii?Q?pBfI7SSe5QRNvlybCbmfo9vGdjhT7NCm0I6jRIFHTI6/j90xOgpUnd9lTKW/?=
 =?us-ascii?Q?dHdq28yQAU9Ka7LbSdcAKzra9foAdyPeE85HjR169XPlw28IMnh8gumvty7P?=
 =?us-ascii?Q?Z8kV8c9iJWANJklkY+MXXIoYjspCItiRZpEggSduPMND/4vx0t4G7aA7gGZb?=
 =?us-ascii?Q?NkogSE25c5GKTg+2PEOOFHdRPTrYP55K2rHAUkHCPaEvVDQbMUzcXrzzzAk/?=
 =?us-ascii?Q?zIRGHmGSKAVEStt8Rxz/NLJKmlY6WeRVV17ZFNy12itRqqj4aZVhz1tWwsmP?=
 =?us-ascii?Q?B6BHIV0a58xBguD1fPOiYATqo8dfpntexP9hvROovyxd2hNhbyaAxseDrA2y?=
 =?us-ascii?Q?UPIGapg7hOib9sB/Q2ns7E+FuXBJfaxIV/qJgSHwKt78wL/d5NIzu64xYOTo?=
 =?us-ascii?Q?0+FEa+V2zO4SbWpQkl99gsq/hH5/bl6CvcXovRODHzClWz20E1AENs/DuSPW?=
 =?us-ascii?Q?8xKMU8+2DfJcsm5QiHzg2j2D3iVxLCsvQlitQJQ9BW/WEev8nLRGVCajNGXJ?=
 =?us-ascii?Q?Q/2EJ//1/ib3Cl+wCK6nxkpGzOKvCbM7xJPQT/yyKchSAL44gmLejlKOT1ER?=
 =?us-ascii?Q?tWuOSb41VSb81DDSAimH0wJLVaE4f/NHL5HWdBPdJeElhSTAXvwSjzFY14Kz?=
 =?us-ascii?Q?3your8wuZfAnYnQkTxOy/Nb2XLGsspamnv5c4wsu0Sk9qOBV/bLUuIQ0XzPC?=
 =?us-ascii?Q?ODRQm7+fvlvzo7Bl0/laeUjqAwE8vH6V8zflk8lOmU9HhRqZsQlr3+XUq1tG?=
 =?us-ascii?Q?Jcxa3alIBxhH1eneK5boGJ7ZpTwAlm2g58+Qewi1prCl/heK/1rZ7bBBv7N9?=
 =?us-ascii?Q?Se44D0SkR8jeUPOIjqbnA/ZnFZQuBz+fBDyQYCVqVEYYBwE2QpsdKUaMFuZy?=
 =?us-ascii?Q?0/CUx+oVWmPiAuOPPw/0jLqcAWvst+EFVHFZI1l+1eUr2EMUNKc8YAKP0mtN?=
 =?us-ascii?Q?iIPhPlnD4GKLGOdzrtDLgO5A+c7v5YK2A4YJjAZsis/oTk0ePp3ggNc2XzyO?=
 =?us-ascii?Q?n6C6xZQY2fbM+wVG6ydMx9rE+8PD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+hmviUPo+fhGOtLqey1xwxjHa3lLvOlGVgAVvClIQK9xIazhLki6/sTCMf02?=
 =?us-ascii?Q?iH8gZc/haA7nQBZBeUhlXd664I9FSFD87ox3UKwIrsaVmlgl/Ra63hzf0oQ2?=
 =?us-ascii?Q?XXhITdGCPiOyOR+2tivdfSgHaremUNKkSvrGEGNtg/gxv5y4CRhVm9NZMGpf?=
 =?us-ascii?Q?3WNAvi5sNFLbFyVZ4Ja1F7A8r6xuzWq66YX0WJzJNTU+ZWj38/5s7GuuOjqX?=
 =?us-ascii?Q?H8Ezm5IaGF19FMpNqzHtfSDJTGy0ssCSlzhY+7J0QP9/lwBY/Gf5X/4WXLJF?=
 =?us-ascii?Q?xligfWrDNi7VQAeoIu3Uu76T1rXrl1OOYaWQ7djxiOC7i/Cl5XZQL8YtCltV?=
 =?us-ascii?Q?fkDrfWHRktV98FsSO8P88L8IuE/m2GPG+q5a/lMYUihaMSbL83vcPwIuxu2D?=
 =?us-ascii?Q?3WZWr/WCIdJ74xoJmzn2TQRs7lew5K9Xf4RXEK30onr+23MH4Xg1+cKe89GG?=
 =?us-ascii?Q?UNhi6Q95a9BuYJ3pzz67YqssiznbO4SuL5TYIjRA/XzhyjRmWvQNGO9S5ci1?=
 =?us-ascii?Q?VuGTU/NPSc81mcqZMaG5MWXWmOtyDK3LIPiGCTVDGV/7JETp+CYMwdctYw4G?=
 =?us-ascii?Q?ogvlRnHTC8eSQvPXYJCH4KfKeZmYUZyxPDoeZziAHm/jSRgqF48MpKUl6sPF?=
 =?us-ascii?Q?xtWD95jeW2Mc83dqLiRgCL4vQ1JbtgWC4bNUz8JCL0QgEBxoY025T+b5g6iU?=
 =?us-ascii?Q?HiP4OitzXhpQKJPNbC5IukyaziGaYw2VvVwtvRHq4zoLYnhycsA6ndwwSX0e?=
 =?us-ascii?Q?l7iacv3Wq5ggjpeA0koOTyxyyCbJ0nJznZ6UXJMA4SE2zcSHkx/was34GzX1?=
 =?us-ascii?Q?rmhkgp+SqVGE8sjrmwwf4ZLa8ugJGKDTwUsgogurVj/+BunXd9nL1IRTTD4Y?=
 =?us-ascii?Q?sJ195AkoGcpKEnqYCEGGfQ+hrTvj1gD/rDMP8caHHffJ13Ab0MenGxR5Yxe6?=
 =?us-ascii?Q?5i/65kfS1zQUsLnIFXpX5lKKTc1Kigo7xvn0x025pbj25yEsKVcfDX6ujEbF?=
 =?us-ascii?Q?Dj0l1l0OpRSoDiFFmP2FGEfngEbBaQhFusEWhn2ob3slOyhJeSF+Az6oe0ap?=
 =?us-ascii?Q?r2ZqWz5I4mdT2qbB3XHlzCd443geORVeMgzaJl6zV8PKttocGkp8bDzKQCv+?=
 =?us-ascii?Q?bXfaCggsz8OrzZgb95lsOyPyGOrKuUwcsfOREMd6J3C5X6ujSsBubib/aHZl?=
 =?us-ascii?Q?wkkizfAwy+9uz+FtVDGHkyH168L5RHQhR6EagXzjdmARxqdx3J88bHoZ/zqp?=
 =?us-ascii?Q?/khtOOyJzIUHoTWl+W/iIwHP+hiFHNBU41eD45slTH1KqLIavNem5sHSBp2d?=
 =?us-ascii?Q?FonpjcJAeZYc5LJYSwcD7SNdSSnab9br04+Hz237wAOeeR4PC3BNwXTGvoQS?=
 =?us-ascii?Q?jAccplv4tQCNZuCH2VkOI/w2WR3vpwGgdtrzpgdqo2kbTDIKkXGe0f8nI2OR?=
 =?us-ascii?Q?rCBZKpHddweBgF6ey+5lQu+4epv4BJBY9weV+uF4HR+apNEmHQErc0ijmidx?=
 =?us-ascii?Q?FzDGj40crhQcE57ErLwPsUDog8Ok11fie2yANKG+G1nnSCF4LYMFsFKHqRqm?=
 =?us-ascii?Q?EyOyZI1PtL3k0tNJyd86+DAeEoADyjUHmQq9P9CA?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5195534f-0760-4d32-f2e3-08dd50f4a3b1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:49:40.7094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLJ64eSZFrAkGo5fKFdVlhv5cS7QrLQB3bAFiowqxi1QH/jfx/B68wA0Yr6dfnRokiIhFahUx10HFNVkYTjO1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10559
X-Proofpoint-GUID: NpCNxMONIiklx2Dn0QWsaSaD2M6Oqrpg
X-Authority-Analysis: v=2.4 cv=bfyRUPPB c=1 sm=1 tr=0 ts=67b5ef8a cx=c_pps
 a=U0KzkmEawxegXmCr7eTojA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=Wcf8dU1HRy81hTxyJVcA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-ORIG-GUID: NpCNxMONIiklx2Dn0QWsaSaD2M6Oqrpg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

From: Jagannathan Raman <jag.raman@oracle.com>

Split out code specific to the kernel-side vfio implementation from the
VFIOPCIDevice class into a VFIOKernelPCIDevice. The forthcoming
VFIOUserPCIDevice will share the base VFIOPCIDevice class.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/helpers.c |   2 +-
 hw/vfio/pci.c     | 107 ++++++++++++++++++++++++++++------------------
 hw/vfio/pci.h     |  16 ++++++-
 3 files changed, 80 insertions(+), 45 deletions(-)

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 3c923d23b9..94bbc5747c 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -744,7 +744,7 @@ bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
 VFIODevice *vfio_get_vfio_device(Object *obj)
 {
     if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
-        return &VFIO_PCI(obj)->vbasedev;
+        return &VFIO_PCI(obj)->device.vbasedev;
     } else {
         return NULL;
     }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a4f99fc5e0..812743e9dd 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -239,7 +239,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
 
 static void vfio_intx_routing_notifier(PCIDevice *pdev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     PCIINTxRoute route;
 
     if (vdev->interrupt != VFIO_INT_INTx) {
@@ -514,7 +514,7 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
 static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                                    MSIMessage *msg, IOHandler *handler)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIOMSIVector *vector;
     int ret;
     bool resizing = !!(vdev->nr_vectors < nr + 1);
@@ -619,7 +619,7 @@ static int vfio_msix_vector_use(PCIDevice *pdev,
 
 static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
 
     trace_vfio_msix_vector_release(vdev->vbasedev.name, nr);
@@ -1167,7 +1167,7 @@ static const MemoryRegionOps vfio_vga_ops = {
  */
 static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIORegion *region = &vdev->bars[bar].region;
     MemoryRegion *mmap_mr, *region_mr, *base_mr;
     PCIIORegion *r;
@@ -1213,7 +1213,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
  */
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
 
     memcpy(&emu_bits, vdev->emulated_config_bits + addr, len);
@@ -1246,7 +1246,7 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     uint32_t val_le = cpu_to_le32(val);
 
     trace_vfio_pci_write_config(vdev->vbasedev.name, addr, val, len);
@@ -3084,7 +3084,7 @@ static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     ERRP_GUARD();
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     int i, ret;
     char uuid[UUID_STR_LEN];
@@ -3274,7 +3274,7 @@ error:
 
 static void vfio_instance_finalize(Object *obj)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
 
     vfio_display_finalize(vdev);
     vfio_bars_finalize(vdev);
@@ -3292,7 +3292,7 @@ static void vfio_instance_finalize(Object *obj)
 
 static void vfio_exitfn(PCIDevice *pdev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_unregister_req_notifier(vdev);
@@ -3316,7 +3316,7 @@ static void vfio_exitfn(PCIDevice *pdev)
 
 static void vfio_pci_reset(DeviceState *dev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI(dev);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
 
     trace_vfio_pci_reset(vdev->vbasedev.name);
 
@@ -3356,7 +3356,7 @@ post_reset:
 static void vfio_instance_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
-    VFIOPCIDevice *vdev = VFIO_PCI(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     device_add_bootindex_property(obj, &vdev->bootindex,
@@ -3377,28 +3377,15 @@ static void vfio_instance_init(Object *obj)
     pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
-static const Property vfio_pci_dev_properties[] = {
-    DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
-    DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
-    DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
+static const Property vfio_pci_base_dev_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", VFIOPCIDevice,
                             vbasedev.pre_copy_dirty_page_tracking,
                             ON_OFF_AUTO_ON),
     DEFINE_PROP_ON_OFF_AUTO("x-device-dirty-page-tracking", VFIOPCIDevice,
                             vbasedev.device_dirty_page_tracking,
                             ON_OFF_AUTO_ON),
-    DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
-                            display, ON_OFF_AUTO_OFF),
-    DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
-    DEFINE_PROP_UINT32("yres", VFIOPCIDevice, display_yres, 0),
     DEFINE_PROP_UINT32("x-intx-mmap-timeout-ms", VFIOPCIDevice,
                        intx.mmap_timeout, 1100),
-    DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
-                    VFIO_FEATURE_ENABLE_VGA_BIT, false),
-    DEFINE_PROP_BIT("x-req", VFIOPCIDevice, features,
-                    VFIO_FEATURE_ENABLE_REQ_BIT, true),
-    DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
-                    VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
     DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
                             vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
@@ -3409,8 +3396,6 @@ static const Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_BOOL("x-no-kvm-intx", VFIOPCIDevice, no_kvm_intx, false),
     DEFINE_PROP_BOOL("x-no-kvm-msi", VFIOPCIDevice, no_kvm_msi, false),
     DEFINE_PROP_BOOL("x-no-kvm-msix", VFIOPCIDevice, no_kvm_msix, false),
-    DEFINE_PROP_BOOL("x-no-geforce-quirks", VFIOPCIDevice,
-                     no_geforce_quirks, false),
     DEFINE_PROP_BOOL("x-no-kvm-ioeventfd", VFIOPCIDevice, no_kvm_ioeventfd,
                      false),
     DEFINE_PROP_BOOL("x-no-vfio-ioeventfd", VFIOPCIDevice, no_vfio_ioeventfd,
@@ -3421,12 +3406,57 @@ static const Property vfio_pci_dev_properties[] = {
                        sub_vendor_id, PCI_ANY_ID),
     DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
                        sub_device_id, PCI_ANY_ID),
+    DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
+                                OFF_AUTO_PCIBAR_OFF),
+};
+
+
+static void vfio_pci_base_dev_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, vfio_pci_base_dev_properties);
+    dc->desc = "VFIO PCI base device";
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    pdc->exit = vfio_exitfn;
+    pdc->config_read = vfio_pci_read_config;
+    pdc->config_write = vfio_pci_write_config;
+}
+
+static const TypeInfo vfio_pci_base_dev_info = {
+    .name = TYPE_VFIO_PCI_BASE,
+    .parent = TYPE_PCI_DEVICE,
+    .instance_size = 0,
+    .abstract = true,
+    .class_init = vfio_pci_base_dev_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { }
+    },
+};
+
+static const Property vfio_pci_dev_properties[] = {
+    DEFINE_PROP_PCI_HOST_DEVADDR("host", VFIOPCIDevice, host),
+    DEFINE_PROP_UUID_NODEFAULT("vf-token", VFIOPCIDevice, vf_token),
+    DEFINE_PROP_STRING("sysfsdev", VFIOPCIDevice, vbasedev.sysfsdev),
+    DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
+                            display, ON_OFF_AUTO_OFF),
+    DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
+    DEFINE_PROP_UINT32("yres", VFIOPCIDevice, display_yres, 0),
+    DEFINE_PROP_BIT("x-vga", VFIOPCIDevice, features,
+                    VFIO_FEATURE_ENABLE_VGA_BIT, false),
+    DEFINE_PROP_BIT("x-req", VFIOPCIDevice, features,
+                    VFIO_FEATURE_ENABLE_REQ_BIT, true),
+    DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
+                    VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
+    DEFINE_PROP_BOOL("x-no-geforce-quirks", VFIOPCIDevice,
+                     no_geforce_quirks, false),
     DEFINE_PROP_UINT32("x-igd-gms", VFIOPCIDevice, igd_gms, 0),
     DEFINE_PROP_UNSIGNED_NODEFAULT("x-nv-gpudirect-clique", VFIOPCIDevice,
                                    nv_gpudirect_clique,
                                    qdev_prop_nv_gpudirect_clique, uint8_t),
-    DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
-                                OFF_AUTO_PCIBAR_OFF),
 #ifdef CONFIG_IOMMUFD
     DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
@@ -3437,7 +3467,8 @@ static const Property vfio_pci_dev_properties[] = {
 #ifdef CONFIG_IOMMUFD
 static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
 {
-    vfio_device_set_fd(&VFIO_PCI(obj)->vbasedev, str, errp);
+    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    vfio_device_set_fd(&vdev->vbasedev, str, errp);
 }
 #endif
 
@@ -3452,25 +3483,16 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
     object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
 #endif
     dc->desc = "VFIO-based PCI device assignment";
-    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     pdc->realize = vfio_realize;
-    pdc->exit = vfio_exitfn;
-    pdc->config_read = vfio_pci_read_config;
-    pdc->config_write = vfio_pci_write_config;
 }
 
 static const TypeInfo vfio_pci_dev_info = {
     .name = TYPE_VFIO_PCI,
-    .parent = TYPE_PCI_DEVICE,
-    .instance_size = sizeof(VFIOPCIDevice),
+    .parent = TYPE_VFIO_PCI_BASE,
+    .instance_size = sizeof(VFIOKernelPCIDevice),
     .class_init = vfio_pci_dev_class_init,
     .instance_init = vfio_instance_init,
     .instance_finalize = vfio_instance_finalize,
-    .interfaces = (InterfaceInfo[]) {
-        { INTERFACE_PCIE_DEVICE },
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { }
-    },
 };
 
 static const Property vfio_pci_dev_nohotplug_properties[] = {
@@ -3490,12 +3512,13 @@ static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass, void *data)
 static const TypeInfo vfio_pci_nohotplug_dev_info = {
     .name = TYPE_VFIO_PCI_NOHOTPLUG,
     .parent = TYPE_VFIO_PCI,
-    .instance_size = sizeof(VFIOPCIDevice),
+    .instance_size = sizeof(VFIOKernelPCIDevice),
     .class_init = vfio_pci_nohotplug_dev_class_init,
 };
 
 static void register_vfio_pci_dev_type(void)
 {
+    type_register_static(&vfio_pci_base_dev_info);
     type_register_static(&vfio_pci_dev_info);
     type_register_static(&vfio_pci_nohotplug_dev_info);
 }
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 43c166680a..8e79740ddb 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -116,8 +116,13 @@ typedef struct VFIOMSIXInfo {
     bool noresize;
 } VFIOMSIXInfo;
 
-#define TYPE_VFIO_PCI "vfio-pci"
-OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI)
+/*
+ * TYPE_VFIO_PCI_BASE is an abstract type used to share code
+ * between VFIO implementations that use a kernel driver
+ * with those that use user sockets.
+ */
+#define TYPE_VFIO_PCI_BASE "vfio-pci-base"
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_BASE)
 
 struct VFIOPCIDevice {
     PCIDevice pdev;
@@ -182,6 +187,13 @@ struct VFIOPCIDevice {
     Notifier irqchip_change_notifier;
 };
 
+#define TYPE_VFIO_PCI "vfio-pci"
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOKernelPCIDevice, VFIO_PCI)
+
+struct VFIOKernelPCIDevice {
+    VFIOPCIDevice device;
+};
+
 /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
 static inline bool vfio_pci_is(VFIOPCIDevice *vdev, uint32_t vendor, uint32_t device)
 {
-- 
2.34.1


