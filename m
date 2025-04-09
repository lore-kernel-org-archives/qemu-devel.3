Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1477C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 13:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Vo6-0007FG-Nt; Wed, 09 Apr 2025 09:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2Vnj-0006j7-Iy; Wed, 09 Apr 2025 09:49:12 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2Vnd-0005hQ-Nz; Wed, 09 Apr 2025 09:49:08 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5394K8ZT021298;
 Wed, 9 Apr 2025 06:49:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TUd5ZO0tIvlbkARgD8HA6YU9H1bK5AQZPm+rqZ8vQ
 7k=; b=o7GUGBjodYTY8PkmQkHmvpeMq3MG7l7p5UceGBTBaLaTowh6LlokowW0l
 FYmX+e1m/z4NiAIsg6HDBreFXeerb2q83huXreUrS4+3wpuphpN2mIwhMD7F4OCg
 T4frAFCRad7+p1wWtp1Aet7A9RSFlsTWKUUIOamGOGr2m17TGquPr9oxygxN/vlh
 h0n5Cc2/dRsko6eqzYNolpyPEm9kzcDHQAz1UNfl1kY2X6Ptpe6hOWJ7vzm6Zw9h
 KNIqZXbwQmDrwJyjta7+9z6LxDs7Q46p8DtlEYnC28DHoFTh0ZJqu5MXVbUHnG5N
 PD5+ZMAadh/nD/CTB1BdWogU7xuWg==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010022.outbound.protection.outlook.com [40.93.12.22])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 45u42xhaqr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Apr 2025 06:49:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDTb6/RymD0gkBQotD7dm+TtvAH3fmQL48M6wlvIP0Ltq0EbN8Qi1euhuIcQxfkOc5O2jXJMVIOXZy6ZFiuibu6y5u7hqaR+4XEBYjgU6loMzyaXM8Vaz9yWpU1HV9fZarlI7JSykZyLhmMCTrqlxN3jhtU0TFkXv/XGDTRAyTOIwhivKhl5vxxh5XjMze4dtAwa5XkqG/mFTw42JsVPRke51Lv1lVYubFyngey7cVQr2dfi+BynUnK5UTQ1ZgSgAHsfrjZRjoLJPaHpnqHTiAErNinFJfB8krg02bYw4rNy6+EQNB2RzKqcQZ/sdMMqEpOJVzLtE74/5b34NqD47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUd5ZO0tIvlbkARgD8HA6YU9H1bK5AQZPm+rqZ8vQ7k=;
 b=l13d7epcggQwQChj42RQ5ILajI+ii0pR+0Dwy8+VB90d3ynlio6eORftv+b05ftZtDooM7A3U7O21FaKwzBm5bSSylwUI/Eq8tIuI5Jlyv/nmW4sEwcMnnfJFkhdIhTHYVDDBD8dj3thARna6wq8cPr1QF2HVUGYtEQGZd3hxPOIKyyGeYEZUX/yUEqRQGXxMHTVRnSdV8WGRjtHg410Z9C4d7wsHPgcIOHoXWDoiCNPpwbWXXmXYn9k7bMQDCDzx2+I36AvCSGX5sa1LN+NcZrbbHo+fWo/YxpvwtiRz/9PbmIWK1MEFsPdLZyhHp6dovba7y8T7EUabBwjTOK2aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUd5ZO0tIvlbkARgD8HA6YU9H1bK5AQZPm+rqZ8vQ7k=;
 b=oC6Vj7D/Y9bkGncU5DtoxkvydKCFzOFTqEPF15h2ZMDDJo5A376EjHcWYtcdunYsywYJTBOxbWKx/Um3cbHyBDD5Et9jWTpYIa2Ot7ZaPnvbxf35YUbRVtHr7TGSmHwdodtkep169KuzuKgIWOt/qo6FO6JD77rExYZpQy+aFQ5RhuOrajDl3mLWzTNCY0zHCIINJ+3cL5/lvxG7EGHCZvSIOHDIHGAGKLsxA9UaOhj8wMPYjxWdKa5lNESEckjx9fK0PHiUcl2P1ks8Acp9OrsJwxBX34QgWfdQ3ARDnfIF2s8ud+xjPfS+tc6wUzkNuaO7rsjgg0dTZR8PIFdAkw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7486.namprd02.prod.outlook.com (2603:10b6:a03:2a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Wed, 9 Apr
 2025 13:48:57 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 13:48:57 +0000
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
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH 13/14] vfio: add device IO ops vector
Date: Wed,  9 Apr 2025 15:48:13 +0200
Message-Id: <20250409134814.478903-14-john.levon@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 3889b53b-2b45-4ef5-70c8-08dd776d464f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KaYYDBYd+ygrfMZc0mVnehK6a1hOtLjCxTHTJuFgVpG49rSFC8jr6D+7DJMz?=
 =?us-ascii?Q?tbEjrH7Lb7/jMO9NKPjPkyAuegTriDMHCU32yCWMCrsXvF3SVGAZMYr0Tju5?=
 =?us-ascii?Q?MKIin2gTAw3oPpv8do7o/J6n9kcgBbMcHs4VOQkvezdADAA+OT0FsWZz8rro?=
 =?us-ascii?Q?4RrbT2pb4LDIdRrgdYkSpA8ravhuPEGwIFVZ0IP0/TV+Dc3Z0mWUva60HTIu?=
 =?us-ascii?Q?BJYdBqa/Qgaw4fNTz8ccTJhbq2Mj4dVpxhg+0JSL0Wx5DBa1K9G+OZb6HSz6?=
 =?us-ascii?Q?ntSwQPb+rhTFvbjDz9OccEYwCz/sRcyaUwNFjqSwyLe0N2o3iNc+j2ggeFUa?=
 =?us-ascii?Q?SEGD792fzMAEWQSZsEeAW4HoZa0yL13AxEjzEkyU9rowGro9pRxuC5WnIbW+?=
 =?us-ascii?Q?Ko+T6NEU8bIkKATb8ZUrocSrjF9Y51JCJJXZcilAip1JgQbzJ2ec/0cOseR/?=
 =?us-ascii?Q?waBiyYsjpo7GrrMUdJOL4VYraron28VjY4+ecGHCFQn+f1XGTLa5RpXotM0A?=
 =?us-ascii?Q?a1pJxrH4RboB7uwkwDws7FOqLkEfVudUm8Ftm1UVjYAeCydgHab9p7d9S/e6?=
 =?us-ascii?Q?WG6eenhD4hddFN5iiJ46ktHFVJlt+BaR5MjcfWN8CzidyAloea4k8TJIpiVu?=
 =?us-ascii?Q?uXKrueaCTy0a5aGHCiBr18aCHMylA2/kYWwBc6h6qb/z9ihrYhZtosSOVtuI?=
 =?us-ascii?Q?bVNrShSCHRJwqK1bqlGPKc7BGsi7IdVxglq3bpzHAbdIx0yQnVTwBo9lkcWV?=
 =?us-ascii?Q?gWaOwXDhCSv+5Vyurb0o7bjXzJRACMOvyQls4GwAa3LvXBT6eL6HSGda9P+7?=
 =?us-ascii?Q?mQWK99biaSNGYZA6I/jPcEaahfD8VPh2VJAGUgN41GNDlM7cKI6l2/audHFA?=
 =?us-ascii?Q?AcATBRa2VzS1MhrH9mbpspSysOWA0k4k0v82FmGmYitQzb32ORWc5qXDqMUg?=
 =?us-ascii?Q?hR6elvwtsaYeUPkGkSN/6zs0Rc+FHxD80f5USJLFnlLp4gykZqQHB/0Tx7QU?=
 =?us-ascii?Q?/ZszZXOCAx+XZqYOH3HTWJlDkwjyGOv+LYhCIg2PLamBpKeTmOmVzdQ2p7uN?=
 =?us-ascii?Q?9H4nLJX0TY3b6NleDhL0CoBjsvgMH+Kw6ijx1LGbA6Ff0f9zzVVQbsw/fa65?=
 =?us-ascii?Q?GYCVYHjg/vqTpmXij0sgmCmCqk3D2rBwAi21iXLWH5VSDJg8TB04dsK0Bw1g?=
 =?us-ascii?Q?iDNADryL6isoGiD1wf2SJrF/bLDG/zEpI/uACMGCzt5UbYrwUYQVgUkh56vs?=
 =?us-ascii?Q?55bH1yPewWu0YUeeSkDB7QPe7GAKUqvsyaP4UVCfZNbgUoE0bQR2kiD7lmgS?=
 =?us-ascii?Q?Dqah2IKg4g+ggVmk2V2TlRsrr60d2FZ7NojLEdnISNQPHZ53Cf7YNSYsoXMl?=
 =?us-ascii?Q?wwX6M+PXIWv0WC2lr4WGOfGRAic9JxvKTMBhUzH/gReh4D3n6ahAlL57H5IC?=
 =?us-ascii?Q?G2F+08+iQto=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lUumT4WJ6jX2rGqzgome8bSJ9FOUrerghGWshzvuedAIxHELD60GAqBdLq5C?=
 =?us-ascii?Q?GRAdqe1I+7PAFiQXTZLdRcEYG52sUiuj5rElmoc80dUAfFpifN9bXlRqzIZu?=
 =?us-ascii?Q?5nF0ljn19fuk1N/rfj1vTHG1ogcO0NutQXJ4U7ukuQmOKEK/KtZaWZNyy+Pz?=
 =?us-ascii?Q?lzABqxROTQ7RfaJpK/oCz7sLy4wmw9h7KOPF69XDHPtN8IcfNiiiUnzHzVvS?=
 =?us-ascii?Q?SXULcvOW5ywOuc3AHNi/P3p08QhXSeIdSb5rsXUofcqp9ghN3hC4fpRA5BuP?=
 =?us-ascii?Q?JtOzN8SFhUcTUhuEOjirijZYwbJBhnjvypWiKJaeM/TY2L57CHRPQAPRgom+?=
 =?us-ascii?Q?hHgd3yYWfp1Qrub6xBJWoF3/nUw8+PBpLRjpmgM46a6xOUQhkQ/vyJKdj8XG?=
 =?us-ascii?Q?qCxhTYa3Ve9wewIA7n/NOTlB3tyyoU/Shxjbdmu4UZNEwkR0+r1Qoaub2Juw?=
 =?us-ascii?Q?L2l8w+QoDWxpYvJc/vIIrdAFFbS4pONotAY92N9ZbA8FpqJSxG0oqqACXuL1?=
 =?us-ascii?Q?wwLZ+fr/Wt+CdiAiu+AjP2WTDoeRjz9wTmg4aLw5xuqw5LN/HsvboUZ9pwVx?=
 =?us-ascii?Q?0Acg8ZYkI2Du8FPI2V/xQgXQbVXwV1hbVe7Ki20pnJpmvUn5h4lv4ROY9LmZ?=
 =?us-ascii?Q?npmBfRcVMrX6Y3rSeKSHRSv4dOZH4clunOytjENppKuDtRsAQ2kI7xgjyRaA?=
 =?us-ascii?Q?dkl6H3x86ewadypxpWlH4pXoDtYwyO9k9dRxW0sWX4Y0dvQePX8fjYHYbR9F?=
 =?us-ascii?Q?/pon3nt9WwElOUMrRgV3ee2Q0R0aAE++XWVsrLEoXNVWaibJsw6xHjx+pa8h?=
 =?us-ascii?Q?FWTEi8Gy7JrqMBrjPRhV8gF0v/VES5KrDfqQa+r5mHzLksX8xUHTKIHiXHst?=
 =?us-ascii?Q?6hITqtx3lvW2aunFQaKPKXPzPyjJjlkH1xYUlg9QHHzUNzp5gkLNEU9QfjHZ?=
 =?us-ascii?Q?mzgO/mv/bMd5BBFRaWA39mEdizZQOtXQ5v2ZO3L5ZjgdX7iKkpZkRV6HnyRd?=
 =?us-ascii?Q?q+WrRAYiSgDNjdztDcvK/Rax9p7u2jNNPUzQjNABbZpgPujngJWs1+OVS8cH?=
 =?us-ascii?Q?QRtnluxOZ+aM2zpnIl0B5IvlrJmtNWPIHkYYp31m+9oe6+XL8138zTGATI3/?=
 =?us-ascii?Q?hx4G4/P++fLp+2Jb9Hfb5yH4jibxrQzvigU0OhQzVNGjsQeKQmnik+LDFfnl?=
 =?us-ascii?Q?Qw+j7O0p7YImMFe7+0UT8O79PYbQx2C1Khi0XI7SUTox4/h6Bx0lnGQ2oRJS?=
 =?us-ascii?Q?WDcdWtVZleJ+X/0T8Pxv6kHpuiwCzSm/aEIL9FH7GWNxI3x2gttvDsGA2D0k?=
 =?us-ascii?Q?e9fdewBjuIDk4DbANM/jj1Te9HFJLWZ4P4mbJ5hl3FEZ2Kp06Xof0QZYGBh2?=
 =?us-ascii?Q?tDUDgmOuvcf216Tmye7P6JQfMcdvbyi3B9fyoRJmhiXQ34f+VvCAKEURZEzp?=
 =?us-ascii?Q?psFpk6imvxMLZ9o1AEpWSWwbEAtqDjYNe1jv4UBWqdlYigMEyNWqjvoUk+EJ?=
 =?us-ascii?Q?ph+QSPgQwYGle0A3TkaYhApmn7PvQueDzgzygAmusGUwzmLXGfDYNmIYzw6c?=
 =?us-ascii?Q?QzKToQr4qcC2lNdkioQoSMvuOOyTZnPFDx6yRMVU?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3889b53b-2b45-4ef5-70c8-08dd776d464f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:48:57.3881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EaEl9Q8eYBwpeYBwQDhp0e6XiJpk++AUT9GxSkvnEJICRf0q2Mw48D//MT/RkSF5VlQrx3oZlqf3eOGC1wn5OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7486
X-Proofpoint-GUID: lPaqEjSGMDWeO50XQoR8B3CJpT-1GCj-
X-Proofpoint-ORIG-GUID: lPaqEjSGMDWeO50XQoR8B3CJpT-1GCj-
X-Authority-Analysis: v=2.4 cv=LMxmQIW9 c=1 sm=1 tr=0 ts=67f67acc cx=c_pps
 a=tQsPtMi3p37jOgXbkrwZvw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=dodWpOyS_J-MCs3LZaAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

For vfio-user, device operations such as IRQ handling and region
read/writes are implemented in userspace over the control socket, not
ioctl() or read()/write() to the vfio kernel driver; add an ops vector
to generalize this, and implement vfio_device_io_ops_ioctl for
interacting with the kernel vfio driver.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/ap.c                  |   2 +-
 hw/vfio/ccw.c                 |   2 +-
 hw/vfio/container-base.c      |   6 +-
 hw/vfio/device.c              | 102 ++++++++++++++++++++++++++++++----
 hw/vfio/listener.c            |  13 +++--
 hw/vfio/pci.c                 |  40 +++++++------
 hw/vfio/platform.c            |   2 +-
 hw/vfio/region.c              |  17 ++++--
 include/hw/vfio/vfio-device.h |  24 +++++++-
 9 files changed, 155 insertions(+), 53 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index f311bca5b6..b6233b2107 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -229,7 +229,7 @@ static void vfio_ap_instance_init(Object *obj)
      * handle ram_block_discard_disable().
      */
     vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_AP, &vfio_ap_ops,
-                     DEVICE(vapdev), true);
+                     &vfio_device_io_ops_ioctl, DEVICE(vapdev), true);
 
     /* AP device is mdev type device */
     vbasedev->mdev = true;
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 14dee7cd19..aee52b5a8d 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -676,7 +676,7 @@ static void vfio_ccw_instance_init(Object *obj)
      * ram_block_discard_disable().
      */
     vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_CCW, &vfio_ccw_ops,
-                     DEVICE(vcdev), true);
+                     &vfio_device_io_ops_ioctl, DEVICE(vcdev), true);
 }
 
 #ifdef CONFIG_IOMMUFD
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 613fe1a00d..16fe5f79d2 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -198,11 +198,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
     feature->flags = VFIO_DEVICE_FEATURE_GET |
                      VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT;
 
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
-        return -errno;
-    }
-
-    return 0;
+    return vbasedev->io_ops->device_feature(vbasedev, feature);
 }
 
 static int vfio_container_iommu_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 102fa5a9b4..545d9f1faf 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -82,7 +82,7 @@ void vfio_device_irq_disable(VFIODevice *vbasedev, int index)
         .count = 0,
     };
 
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
 }
 
 void vfio_device_irq_unmask(VFIODevice *vbasedev, int index)
@@ -95,7 +95,7 @@ void vfio_device_irq_unmask(VFIODevice *vbasedev, int index)
         .count = 1,
     };
 
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
 }
 
 void vfio_device_irq_mask(VFIODevice *vbasedev, int index)
@@ -108,7 +108,7 @@ void vfio_device_irq_mask(VFIODevice *vbasedev, int index)
         .count = 1,
     };
 
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
 }
 
 static inline const char *action_to_str(int action)
@@ -155,6 +155,7 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
     int argsz;
     const char *name;
     int32_t *pfd;
+    int ret;
 
     argsz = sizeof(*irq_set) + sizeof(*pfd);
 
@@ -167,7 +168,9 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
     pfd = (int32_t *)&irq_set->data;
     *pfd = fd;
 
-    if (!ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
+    ret = vbasedev->io_ops->set_irqs(vbasedev, irq_set);
+
+    if (!ret) {
         return true;
     }
 
@@ -188,22 +191,19 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
 int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
                              struct vfio_irq_info *info)
 {
-    int ret;
-
     memset(info, 0, sizeof(*info));
 
     info->argsz = sizeof(*info);
     info->index = index;
 
-    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, info);
-
-    return ret < 0 ? -errno : ret;
+    return vbasedev->io_ops->get_irq_info(vbasedev, info);
 }
 
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info)
 {
     size_t argsz = sizeof(struct vfio_region_info);
+    int ret;
 
     /* create region info cache */
     if (vbasedev->reginfo == NULL) {
@@ -222,10 +222,11 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
 retry:
     (*info)->argsz = argsz;
 
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, *info)) {
+    ret = vbasedev->io_ops->get_region_info(vbasedev, *info);
+    if (ret != 0) {
         g_free(*info);
         *info = NULL;
-        return -errno;
+        return ret;
     }
 
     if ((*info)->argsz > argsz) {
@@ -332,10 +333,12 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
 }
 
 void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
-                      DeviceState *dev, bool ram_discard)
+                      VFIODeviceIOOps *io_ops, DeviceState *dev,
+                      bool ram_discard)
 {
     vbasedev->type = type;
     vbasedev->ops = ops;
+    vbasedev->io_ops = io_ops;
     vbasedev->dev = dev;
     vbasedev->fd = -1;
 
@@ -463,3 +466,78 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
 
     vfio_device_get_all_region_info(vbasedev);
 }
+
+/*
+ * Traditional ioctl() based io
+ */
+
+static int vfio_device_io_device_feature(VFIODevice *vbasedev,
+                                         struct vfio_device_feature *feature)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_device_io_get_region_info(VFIODevice *vbasedev,
+                                          struct vfio_region_info *info)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, info);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_device_io_get_irq_info(VFIODevice *vbasedev,
+                                       struct vfio_irq_info *info)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, info);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_device_io_set_irqs(VFIODevice *vbasedev,
+                                   struct vfio_irq_set *irqs)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irqs);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
+                                      off_t off, uint32_t size, void *data)
+{
+    struct vfio_region_info *info = vbasedev->reginfo[index];
+    int ret;
+
+    ret = pread(vbasedev->fd, data, size, info->offset + off);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
+                                       off_t off, uint32_t size, void *data)
+{
+    struct vfio_region_info *info = vbasedev->reginfo[index];
+    int ret;
+
+    ret = pwrite(vbasedev->fd, data, size, info->offset + off);
+
+    return ret < 0 ? -errno : ret;
+}
+
+VFIODeviceIOOps vfio_device_io_ops_ioctl = {
+    .device_feature = vfio_device_io_device_feature,
+    .get_region_info = vfio_device_io_get_region_info,
+    .get_irq_info = vfio_device_io_get_irq_info,
+    .set_irqs = vfio_device_io_set_irqs,
+    .region_read = vfio_device_io_region_read,
+    .region_write = vfio_device_io_region_write,
+};
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index bcf2b98e79..7ea9e0dfb7 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -821,13 +821,17 @@ static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
                      VFIO_DEVICE_FEATURE_DMA_LOGGING_STOP;
 
     QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
+        int ret;
+
         if (!vbasedev->dirty_tracking) {
             continue;
         }
 
-        if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
+        ret = vbasedev->io_ops->device_feature(vbasedev, feature);
+
+        if (ret != 0) {
             warn_report("%s: Failed to stop DMA logging, err %d (%s)",
-                        vbasedev->name, -errno, strerror(errno));
+                        vbasedev->name, -ret, strerror(-ret));
         }
         vbasedev->dirty_tracking = false;
     }
@@ -928,10 +932,9 @@ static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
             continue;
         }
 
-        ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
+        ret = vbasedev->io_ops->device_feature(vbasedev, feature);
         if (ret) {
-            ret = -errno;
-            error_setg_errno(errp, errno, "%s: Failed to start DMA logging",
+            error_setg_errno(errp, -ret, "%s: Failed to start DMA logging",
                              vbasedev->name);
             goto out;
         }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b40d5abdfd..ff2b15ff02 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -381,7 +381,7 @@ static void vfio_msi_interrupt(void *opaque)
 static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
 {
     g_autofree struct vfio_irq_set *irq_set = NULL;
-    int ret = 0, argsz;
+    int argsz;
     int32_t *fd;
 
     argsz = sizeof(*irq_set) + sizeof(*fd);
@@ -396,9 +396,7 @@ static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
     fd = (int32_t *)&irq_set->data;
     *fd = -1;
 
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
-
-    return ret < 0 ? -errno : ret;
+    return vdev->vbasedev.io_ops->set_irqs(&vdev->vbasedev, irq_set);
 }
 
 static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
@@ -455,11 +453,11 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
         fds[i] = fd;
     }
 
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
+    ret = vdev->vbasedev.io_ops->set_irqs(&vdev->vbasedev, irq_set);
 
     g_free(irq_set);
 
-    return ret < 0 ? -errno : ret;
+    return ret;
 }
 
 static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
@@ -917,18 +915,22 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
     memset(vdev->rom, 0xff, size);
 
     while (size) {
-        bytes = pread(vbasedev->fd, vdev->rom + off,
-                      size, vdev->rom_offset + off);
+        bytes = vbasedev->io_ops->region_read(vbasedev,
+                                              VFIO_PCI_ROM_REGION_INDEX,
+                                              off, size, vdev->rom + off);
+
         if (bytes == 0) {
             break;
         } else if (bytes > 0) {
             off += bytes;
             size -= bytes;
         } else {
-            if (errno == EINTR || errno == EAGAIN) {
+            if (bytes == -EINTR || bytes == -EAGAIN) {
                 continue;
             }
-            error_report("vfio: Error reading device ROM: %m");
+            error_report("vfio: Error reading device ROM: %s",
+                         strerror(-bytes));
+
             break;
         }
     }
@@ -968,22 +970,18 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 static int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
                                       uint32_t size, void *data)
 {
-    ssize_t ret;
-
-    ret = pread(vdev->vbasedev.fd, data, size, vdev->config_offset + offset);
-
-    return ret < 0 ? -errno : (int)ret;
+    return vdev->vbasedev.io_ops->region_read(&vdev->vbasedev,
+                                              VFIO_PCI_CONFIG_REGION_INDEX,
+                                              offset, size, data);
 }
 
 /* "Raw" write of underlying config space. */
 static int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
                                        uint32_t size, void *data)
 {
-    ssize_t ret;
-
-    ret = pwrite(vdev->vbasedev.fd, data, size, vdev->config_offset + offset);
-
-    return ret < 0 ? -errno : (int)ret;
+    return vdev->vbasedev.io_ops->region_write(&vdev->vbasedev,
+                                               VFIO_PCI_CONFIG_REGION_INDEX,
+                                               offset, size, data);
 }
 
 static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
@@ -3405,7 +3403,7 @@ static void vfio_instance_init(Object *obj)
     vdev->host.function = ~0U;
 
     vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_PCI, &vfio_pci_ops,
-                     DEVICE(vdev), false);
+                     &vfio_device_io_ops_ioctl, DEVICE(vdev), false);
 
     vdev->nv_gpudirect_clique = 0xFF;
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index fd176c18a4..28eedfa571 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -650,7 +650,7 @@ static void vfio_platform_instance_init(Object *obj)
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_PLATFORM, &vfio_platform_ops,
-                     DEVICE(vdev), false);
+                     &vfio_device_io_ops_ioctl, DEVICE(vdev), false);
 }
 
 #ifdef CONFIG_IOMMUFD
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index ef2630cac3..35fb81c04a 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -45,6 +45,7 @@ void vfio_region_write(void *opaque, hwaddr addr,
         uint32_t dword;
         uint64_t qword;
     } buf;
+    int ret;
 
     switch (size) {
     case 1:
@@ -64,11 +65,13 @@ void vfio_region_write(void *opaque, hwaddr addr,
         break;
     }
 
-    if (pwrite(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
+    ret = vbasedev->io_ops->region_write(vbasedev, region->nr,
+                                         addr, size, &buf);
+    if (ret != size) {
         error_report("%s(%s:region%d+0x%"HWADDR_PRIx", 0x%"PRIx64
-                     ",%d) failed: %m",
+                     ",%d) failed: %s",
                      __func__, vbasedev->name, region->nr,
-                     addr, data, size);
+                     addr, data, size, ret < 0 ? strerror(ret) : "short write");
     }
 
     trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
@@ -96,11 +99,13 @@ uint64_t vfio_region_read(void *opaque,
         uint64_t qword;
     } buf;
     uint64_t data = 0;
+    int ret;
 
-    if (pread(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
-        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %m",
+    ret = vbasedev->io_ops->region_read(vbasedev, region->nr, addr, size, &buf);
+    if (ret != size) {
+        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %s",
                      __func__, vbasedev->name, region->nr,
-                     addr, size);
+                     addr, size, ret < 0 ? strerror(ret) : "short read");
         return (uint64_t)-1;
     }
     switch (size) {
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 967b07cd89..cb2f581826 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -41,6 +41,7 @@ enum {
 };
 
 typedef struct VFIODeviceOps VFIODeviceOps;
+typedef struct VFIODeviceIOOps VFIODeviceIOOps;
 typedef struct VFIOMigration VFIOMigration;
 
 typedef struct IOMMUFDBackend IOMMUFDBackend;
@@ -66,6 +67,7 @@ typedef struct VFIODevice {
     OnOffAuto migration_multifd_transfer;
     bool migration_events;
     VFIODeviceOps *ops;
+    VFIODeviceIOOps *io_ops;
     unsigned int num_irqs;
     unsigned int num_regions;
     unsigned int flags;
@@ -140,6 +142,25 @@ typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIODeviceList vfio_device_list;
 
 #ifdef CONFIG_LINUX
+/*
+ * How devices communicate with the server.  The default option is through
+ * ioctl() to the kernel VFIO driver, but vfio-user can use a socket to a remote
+ * process.
+ */
+struct VFIODeviceIOOps {
+    int (*device_feature)(VFIODevice *vdev, struct vfio_device_feature *);
+    int (*get_region_info)(VFIODevice *vdev,
+                           struct vfio_region_info *info);
+    int (*get_irq_info)(VFIODevice *vdev, struct vfio_irq_info *irq);
+    int (*set_irqs)(VFIODevice *vdev, struct vfio_irq_set *irqs);
+    int (*region_read)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
+                       void *data);
+    int (*region_write)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
+                        void *data);
+};
+
+extern VFIODeviceIOOps vfio_device_io_ops_ioctl;
+
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info);
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
@@ -154,6 +175,7 @@ int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
 bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
 void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
-                      DeviceState *dev, bool ram_discard);
+                      VFIODeviceIOOps *io_ops, DeviceState *dev,
+                      bool ram_discard);
 int vfio_device_get_aw_bits(VFIODevice *vdev);
 #endif /* HW_VFIO_VFIO_COMMON_H */
-- 
2.34.1


