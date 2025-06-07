Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F7AC5AD49
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNhA1-00034O-6g; Fri, 06 Jun 2025 20:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9z-000348-Sl
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:43 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9x-0006R2-P9
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:43 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556N0Rt7023133;
 Fri, 6 Jun 2025 17:11:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=9s8GGmvHd7YbLvsT1cNsRFjqwTXQbF/N8tWvGuRlB
 X4=; b=Y2t+ZSEBtZUmnmGIwot7rDasOPywYpZn3nWhNG/N4xwjlt+tTfZa9TlLr
 sWJJenq9SHz2TNF0rlCofb++w2UOzJSXxClfobYduHI3wJ1n3GhbWsawpInyA+nx
 8UWC20iXV8ax2V+be1nhiMx1TU/8CJC9jQ5xCXlYko2Xq3jpSXrxa45dPGkSjdDJ
 5uA2zVN4zTXI+YxDbm9IsPr8kfI2FGFvtMUkux57JeRDTIi93uQ3w03ZnVlJGSEF
 +3gpDlNQBlKamURzoKQcTIN7HPztgGJByRqkde4e+WOhgRyEd1FI6jqAFL8orkXa
 UTa/P3bFdXUFg/J/tiqFY7Zu/LNPA==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2126.outbound.protection.outlook.com [40.107.212.126])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 472njsxqb2-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 17:11:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRyqt9KFcA1e3K9spFbi5dlaxBolS/VRDx/2sKl5r92R1ejgauSANdORV4gHjYdDpEc1FdxSC9ZYX2kqp45HcdozIpE5M1P8T9rv4557e41cGFHIepr0wb9WaIspZBIR+bzY0mqMvHzbr3nK4X7TNx+U3qx0929j4SU7NjSJoohvRRr6onXFWD6nu8u5dz5NUSz5WbfsEdfolTDGyGoHP4X+tQpgxnbwNzrH+FZFe2KdrXoFU0bRaucG7QZ8bKCnhhiAIFNaMsXjMk1DFJ8G4bhzXcH3est6I6WaISE2St2VNHaP6lQ4q6bD77eE1ANqBe5kvtBrwLMZIoiyh1OXZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9s8GGmvHd7YbLvsT1cNsRFjqwTXQbF/N8tWvGuRlBX4=;
 b=csawmvjo8AdFpzNVAVpJM7YxJyfKVQKKnztZZe2+7H4ZtBhxFX3AnBGbUOrmT9xZnQXAZf6ybdhZNgXNxbe7ctF9wUc9IeIGHCMN43maLj3E+/JUegeLFRfc57LC6OIiT9PHBvdU5ifZS5poOjXE7fEaan3YH49DGM58VMFPmxVy2FTrQk6/aywo1Pl28dw10ORm0FcAwEXdIbVi9BoxWFjJeky987+QGW7A4mRb6WKYIKoIzeN3wbh8fe9uXx85wnXCZXu875hnaLojoQ4AzDmVYctnHS5/n/bUQ9mh9cBL4qXj6zv+FXwCANn/G9owv/3e+1agZgqHpq3kuPmP5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9s8GGmvHd7YbLvsT1cNsRFjqwTXQbF/N8tWvGuRlBX4=;
 b=yZvc7sRCG4B5CYlPGTdMAY/mRrmSLQQLEbkI2SIwPlewDU2kb5bQeAZ8r7oqnsJK7WdQV8p8SeTGHuRDCvpcomp96eFan7sYyauNHtRBDWMzb3qlRfz2tBfinBU9DCTKu45sWh6GMgXdDCOb5AtYJ/0M+XEQqEYtWcc6eSKV2LRYkeFHzKuSoWXzXcyaExXuPtHoBRtoQR8XIAVMJtMhLPyxx0qJlYzUBcQzlzsTiFF2XoYEo3IL6l/EludXdAd7V9TEXLy1IJyaTBo7TX9TsFZYhg2Z0RKxjfbFul8nY7ABAqHDpJIHgPOeYh2ePwjH6aIE6U6rgx5J2Wqy66Ak/w==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CO1PR02MB8441.namprd02.prod.outlook.com (2603:10b6:303:154::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.17; Sat, 7 Jun
 2025 00:11:25 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.016; Sat, 7 Jun 2025
 00:11:25 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, John Levon <levon@movementarian.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v3 18/23] vfio-user: implement VFIO_USER_DMA_MAP/UNMAP
Date: Fri,  6 Jun 2025 17:10:50 -0700
Message-ID: <20250607001056.335310-19-john.levon@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CO1PR02MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: acf2b94b-b746-4a3d-3dd8-08dda557d73b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KHOm3rgVa41x8vlS+uZHqF+pQ0BcDOgStXHJyAeqAxR36N+tO376olDOYtAf?=
 =?us-ascii?Q?nI1JeC+P1xFDFJnAMCvjD25VAgSMcA39+goZCEb7qRYOKmvIzEQ4vpMsKfHn?=
 =?us-ascii?Q?0A+3Z6hu3iL9JpZ+muIxhsG68Dg/QpxlR3vWBsvfCRcw21uGkzBMcyKe8a0Q?=
 =?us-ascii?Q?a+qwa8bseUoV3KrSfHKzYUdG+R3ndfRkWUA8LozuKpQJEOQdReq7v3f/yhDG?=
 =?us-ascii?Q?09gZ6nAVjvlkIa0KfQ8NyxiOHUge0gvhAqvOJVbBAmyzj/W+XmcOQGU/Za5/?=
 =?us-ascii?Q?uYQdUiyfLHqTr0u6gWQ5EMexxGRIl+ujPzUaBZjZc+pdTatyqv67eZx7Q38j?=
 =?us-ascii?Q?4I2gjr0WcqFVZ5p3NUa1SkdMBi8lJsX8hN86yqumWkSbfuHzKEfUoADYTpFG?=
 =?us-ascii?Q?iJLoEyaF5RuHhSxxv8W079bCALwTMtkS8q9XWg0w3xMKsxRLSdhOoyDl2iai?=
 =?us-ascii?Q?bwkMIRXOAMW7REuCbJaBRwz+/1qSRkYMj78NxzZ41IVK3l4fxJUoQsPXtjws?=
 =?us-ascii?Q?gPl7B09PU4ARmBBdM7LDxHHKWviZNL6x6PmYpmWDXehjVGorLsqz+ahPVXos?=
 =?us-ascii?Q?5Dy2liapfZlrBrqjcj7+LmT2uqrlLU8YHcNYuJDugN9W9K/yTrHpeFpBHGbL?=
 =?us-ascii?Q?/XNMRC5QaxGIuSNPAoejmPTEsccKG/2XF07SqoB09uZ+1Pql2ou9yCUxEAOk?=
 =?us-ascii?Q?bTYefH0fTjc5hVYMjOq3UoxRs04s8sWHk3tUZq1uWYXoQf2K7aQ1KT23wqMz?=
 =?us-ascii?Q?XUTW17QiBafbW8059cIr1v3xaOf9ZqVNVS2fE0L+ryH0k582F8ZN+313MBf7?=
 =?us-ascii?Q?ljySxQsHDnctxdD3Wp4KwKqoTF7HEgGPnDDkuMk6IuExUFXtzgLFsbQn42Bd?=
 =?us-ascii?Q?ddI0i4m0HedKMZ/7KnhyY28FW0tTtV91pxEGxRibTKW0IMgPxFiLFZT1s7SJ?=
 =?us-ascii?Q?ZI2X4iEepDi4dXs1GVrZNTfdutyf88z6UAFRGNEeU2X9784BNz6SUUd+P1QB?=
 =?us-ascii?Q?YhJwpygWivYNvQmJAOJlmhYmWhu4Fr3Nb/b5YLPd+zQdUYdP8/iw/M3xbCu6?=
 =?us-ascii?Q?JY9bPToEvZFK+pOVlJMpyvzCOtsKLOAo2hNitT/dywyCz7HxcpTqkHFbtMhk?=
 =?us-ascii?Q?HGeB1PKZnY+xZpHwZUpkKLyucn7/cVlUBDmRSWHhPAd/UGnBxXOE3eDg/b0n?=
 =?us-ascii?Q?BbUVp1EufQ1l0to+z/cREIAWuM2W+LoBMVbGppyfu0yTSrC2WO0V4EICUNbx?=
 =?us-ascii?Q?Y+boQf2F5iNmVRlIt7UUX3SXiC8KKLGRfH6uDgDaW9x9F/iGN2Xj7iq0441e?=
 =?us-ascii?Q?W/PRSOE8ZFoXDKNrQG5XlAQ/SwWtKm1HbnafsuCnGhyXnvGlC4zK7n7I469m?=
 =?us-ascii?Q?z258PYKpXjTmPcR2vpekrBCazmCtrk39azMvIItyf9S16WcmBZfN1rZmf7Of?=
 =?us-ascii?Q?9cOF8RDEp1A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bykdDqr2knG2iPXfKC/lUpr9Hb+7sMfH4StnU5cT78ZOZH3XbrDqhjGMt0g+?=
 =?us-ascii?Q?w1+r/SmqoYYLTS159ZttN50O9uRy33UAUti30b9+tjHw1VRPrW3sdY7iBrw3?=
 =?us-ascii?Q?jhajQl+J1AdKi+UKpTmT5hpKxSW9oh2d/cOCDgqfgHPn3jGOnlxm1ho0VD91?=
 =?us-ascii?Q?gE3Er7Nrbx4WNNHKOIi7giWWjVbMm37SK3wXHfkw1WwkwXmpF5TQ9Aj1YraS?=
 =?us-ascii?Q?84GrE0o8rw6I4M1wcFFahF0vL8/WOlhp2X+CZLMkAdZCDrV3+Mop1wWfztOv?=
 =?us-ascii?Q?XGsX9DlYqNoElCsOz21HHFlP8uKV38+02K1mYClad3dd3eA5gz+8QUak55ZM?=
 =?us-ascii?Q?4bv1NCDwyZ3Xpv9Pz9Zy5dCb+SU5vTrDSYtXYjJH0IJ89BAVhxl0g4hFg7IR?=
 =?us-ascii?Q?tJZqwm+FzGpybVVdAF7Gtsw39afc38en8hE5SCIN42NrgANdKPRCc5qU26iP?=
 =?us-ascii?Q?ePU7cZjOxOe9A8Okj4fUaWhBmKBa1jG+QFNCZ7sf6sSF7IDCnDh9vFGv7oHa?=
 =?us-ascii?Q?Wq9hl/eoJQEAECbPVt6ZWzosLli118IgUQmptiyM3Tc2qXRd0/bj1TcMcq1O?=
 =?us-ascii?Q?bwbBRLdhiVjvnveP6/Jxpn5MikrQp5S4KUnvgVO/Y6B5RheFmYcZsOgdFoCD?=
 =?us-ascii?Q?covTrgzA+49DK266/RnR4g/cdwaTyoeaHfUM/ps+g+lHrXe95A+NEMVQTNE5?=
 =?us-ascii?Q?NvT8Z6kb4FylVzcRfHQJZOlA9dvoMMNw6iU+5+ioD2shyLb3JtMwaAmlaSi2?=
 =?us-ascii?Q?ecB8se+Qp8xRQiksiyMV4Bk+R6w0OPl1XhPO1pOZSG574ih49MVedWipzatR?=
 =?us-ascii?Q?pvSHMn802nPC0XETcwE8Li4zVdMF1SCv5/rJvXT6npj2szRBTi616M74ADcS?=
 =?us-ascii?Q?xC4CxMwvlneJ114nwsb+lMK1sbgqJxCQ2b2JL3g/vyZnOY5fF8rHyT8Cjgfk?=
 =?us-ascii?Q?a6meB0TBE1tYMXrpegO8rGKkeC/vwqSnutQB1akltwTWlrTZruyIkwYD/8Zn?=
 =?us-ascii?Q?2gktJgtBk+QwL8m/QLZGby4MAtmqdGlQkzUZ0FVaJ6Tnnoa8j3JMCq9h4Q4w?=
 =?us-ascii?Q?f3oirpo+fKgVK5rIeYaqYA6kwTAfiZhJ+us6NUpu89gfIEXgJTzCerPIfkfE?=
 =?us-ascii?Q?xlG3rSKPZeQo1C9OjAZBHE329VXOe9XlP+nmSTmtDlcJAJCJNsN85wJGO9U8?=
 =?us-ascii?Q?ICUNpNJe66S910MLyPgFpNZf+iHSVYR1SDdW0mE4sIqo9xheJGThYcxer+2m?=
 =?us-ascii?Q?+obTv3rcGtX4HVkrh9BLqRh8wPicW9AU0OKxm2rmd1JTcrvjtnomxcb45+C0?=
 =?us-ascii?Q?175zC2+qFL47BupPuluxLpFeSrCu/IqDwO6bk3ZHsedoJ+TuqIH38r7GD9IH?=
 =?us-ascii?Q?bRfsu/n0KKQfLhNy3MegkKn7DM95SEuCbZAKg+TLhTKizumE6H7f1hLcV/jM?=
 =?us-ascii?Q?GADsbCGF0Z41QSteMH/7tDg/6bDsDGFbWv3NO426FqHJKtyeIW+g2oO5jJe3?=
 =?us-ascii?Q?6li1kJg9kHp6GXJ+JUYyIJAVI1aEghB/qo1CWYJqtfw/CkYWhDhtQy6SQ7Y7?=
 =?us-ascii?Q?baXIpEDk+J9Qe037/bpQh8Zi7BVtzdGLUIfog3aw?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf2b94b-b746-4a3d-3dd8-08dda557d73b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 00:11:25.0387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7y1n1dgQK4BaNMh2UtdkT82L443aCnDnQTN2c2qTcoIK35JKwVxUwR6Rh5QXSumMzbpNoBH/T7yG7caO63j6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8441
X-Authority-Analysis: v=2.4 cv=f9JIBPyM c=1 sm=1 tr=0 ts=684383b0 cx=c_pps
 a=JomqzcHDjT5Ni/tnCvtrfQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=RQZ_2NmkAAAA:8
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=QltQKaWwH6ua0DdkohUA:9
 a=46pEW5UW3zrkaSsnLxuo:22
X-Proofpoint-GUID: -un85e7K5-t7RPu05QAYDX7gTiOVlCcl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5OSBTYWx0ZWRfX5Tm+xCAeihnY
 ECRrNfrQ1QE6EMEFBY4iML/oH/fCjNMehHD0tE+TyXlDCyVdm9S1wL/Hu7MErPtc78G551DNwUT
 Y4jImeO1JfPSh4DXb8HlAw/lbjWV0oTF5ihtHjtJd0rdL1ezftXGfGu5y6zopoa4oyl/MJtz2NH
 t3kcek6Fgt51hDY/7PH9Z2wXRoCquEtZ4eYmGYcRk0HpHQqYcshmN0FmAC+eGTbXGZMwIQpMYS6
 /RHOxZA9dSr5lCXNk2VYfxDYYFpwlR2SukhzPYyQ3rjRP4Lw4oBCijipzRlo0aEjrGXW2Wnn3IK
 NBHWr40ofxOlGxErZpApqxIDo+IlnOrdQJ9QfkmBA0uKHFi/nE1Wilgyjm9hf5fzSL9cbuZMs1j
 ce/5+o7arC8CjyQ0X8XghUIYnDBRlN3G/Rx60ilTdBqYcpKSa5HDDp9aQutGRc6YDbBHzYK9
X-Proofpoint-ORIG-GUID: -un85e7K5-t7RPu05QAYDX7gTiOVlCcl
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

From: John Levon <levon@movementarian.org>

When the vfio-user container gets mapping updates, share them with the
vfio-user by sending a message; this can include the region fd, allowing
the server to directly mmap() the region as needed.

For performance, we only wait for the message responses when we're doing
with a series of updates via the listener_commit() callback.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   |  32 ++++++++++++
 hw/vfio-user/proxy.h      |   6 +++
 hw/vfio-user/container.c  | 107 +++++++++++++++++++++++++++++++++++++-
 hw/vfio-user/proxy.c      |  77 ++++++++++++++++++++++++++-
 hw/vfio-user/trace-events |   4 ++
 5 files changed, 222 insertions(+), 4 deletions(-)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 920b9c44ec..4fa6d03b3f 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -115,6 +115,31 @@ typedef struct {
  */
 #define VFIO_USER_DEF_MAX_BITMAP (256 * 1024 * 1024)
 
+/*
+ * VFIO_USER_DMA_MAP
+ * imported from struct vfio_iommu_type1_dma_map
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint64_t offset;    /* FD offset */
+    uint64_t iova;
+    uint64_t size;
+} VFIOUserDMAMap;
+
+/*
+ * VFIO_USER_DMA_UNMAP
+ * imported from struct vfio_iommu_type1_dma_unmap
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint64_t iova;
+    uint64_t size;
+} VFIOUserDMAUnmap;
+
 /*
  * VFIO_USER_DEVICE_GET_INFO
  * imported from struct vfio_device_info
@@ -178,4 +203,11 @@ typedef struct {
     char data[];
 } VFIOUserRegionRW;
 
+/*imported from struct vfio_bitmap */
+typedef struct {
+    uint64_t pgsize;
+    uint64_t size;
+    char data[];
+} VFIOUserBitmap;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index e2cfaeead8..01fed3f17d 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -73,6 +73,7 @@ typedef struct VFIOUserProxy {
     QemuCond close_cv;
     AioContext *ctx;
     QEMUBH *req_bh;
+    bool async_ops;
 
     /*
      * above only changed when BQL is held
@@ -102,9 +103,14 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
                            void *reqarg);
 bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 
+VFIOUserFDs *vfio_user_getfds(int numfds);
+
 void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
                            uint32_t size, uint32_t flags);
+void vfio_user_wait_reqs(VFIOUserProxy *proxy);
 void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                          VFIOUserFDs *fds, int rsize);
+void vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                           VFIOUserFDs *fds, int rsize);
 
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index 38e9cf8d8a..5a109c591e 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -21,18 +21,119 @@
 #include "qapi/error.h"
 #include "trace.h"
 
+/*
+ * When DMA space is the physical address space, the region add/del listeners
+ * will fire during memory update transactions.  These depend on BQL being held,
+ * so do any resulting map/demap ops async while keeping BQL.
+ */
+static void vfio_user_listener_begin(VFIOContainerBase *bcontainer)
+{
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                 bcontainer);
+
+    container->proxy->async_ops = true;
+}
+
+static void vfio_user_listener_commit(VFIOContainerBase *bcontainer)
+{
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                            bcontainer);
+
+    /* wait here for any async requests sent during the transaction */
+    container->proxy->async_ops = false;
+    vfio_user_wait_reqs(container->proxy);
+}
+
 static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
                                hwaddr iova, ram_addr_t size,
                                IOMMUTLBEntry *iotlb, bool unmap_all)
 {
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                            bcontainer);
+
+    VFIOUserDMAUnmap *msgp = g_malloc(sizeof(*msgp));
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DMA_UNMAP, sizeof(*msgp), 0);
+    msgp->argsz = sizeof(struct vfio_iommu_type1_dma_unmap);
+    msgp->flags = unmap_all ? VFIO_DMA_UNMAP_FLAG_ALL : 0;
+    msgp->iova = iova;
+    msgp->size = size;
+    trace_vfio_user_dma_unmap(msgp->iova, msgp->size, msgp->flags,
+                              container->proxy->async_ops);
+
+    if (container->proxy->async_ops) {
+        vfio_user_send_nowait(container->proxy, &msgp->hdr, NULL, 0);
+        return 0;
+    }
+
+    vfio_user_send_wait(container->proxy, &msgp->hdr, NULL, 0);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        return -msgp->hdr.error_reply;
+    }
+
+    g_free(msgp);
+    return 0;
 }
 
 static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                              ram_addr_t size, void *vaddr, bool readonly,
                              MemoryRegion *mrp)
 {
-    return -ENOTSUP;
+    VFIOUserContainer *container = container_of(bcontainer, VFIOUserContainer,
+                                                bcontainer);
+
+    VFIOUserProxy *proxy = container->proxy;
+    int fd = memory_region_get_fd(mrp);
+    int ret;
+
+    VFIOUserFDs *fds = NULL;
+    VFIOUserDMAMap *msgp = g_malloc0(sizeof(*msgp));
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DMA_MAP, sizeof(*msgp), 0);
+    msgp->argsz = sizeof(struct vfio_iommu_type1_dma_map);
+    msgp->flags = VFIO_DMA_MAP_FLAG_READ;
+    msgp->offset = 0;
+    msgp->iova = iova;
+    msgp->size = size;
+
+    /*
+     * vaddr enters as a QEMU process address; make it either a file offset
+     * for mapped areas or leave as 0.
+     */
+    if (fd != -1) {
+        msgp->offset = qemu_ram_block_host_offset(mrp->ram_block, vaddr);
+    }
+
+    if (!readonly) {
+        msgp->flags |= VFIO_DMA_MAP_FLAG_WRITE;
+    }
+
+    trace_vfio_user_dma_map(msgp->iova, msgp->size, msgp->offset, msgp->flags,
+                            container->proxy->async_ops);
+
+    /*
+     * The async_ops case sends without blocking. They're later waited for in
+     * vfio_send_wait_reqs.
+     */
+    if (container->proxy->async_ops) {
+        /* can't use auto variable since we don't block */
+        if (fd != -1) {
+            fds = vfio_user_getfds(1);
+            fds->send_fds = 1;
+            fds->fds[0] = fd;
+        }
+        vfio_user_send_nowait(proxy, &msgp->hdr, fds, 0);
+        ret = 0;
+    } else {
+        VFIOUserFDs local_fds = { 1, 0, &fd };
+
+        fds = fd != -1 ? &local_fds : NULL;
+        vfio_user_send_wait(proxy, &msgp->hdr, fds, 0);
+        ret = (msgp->hdr.flags & VFIO_USER_ERROR) ? -msgp->hdr.error_reply : 0;
+        g_free(msgp);
+    }
+
+    return ret;
 }
 
 static int
@@ -224,6 +325,8 @@ static void vfio_iommu_user_class_init(ObjectClass *klass, const void *data)
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
     vioc->setup = vfio_user_setup;
+    vioc->listener_begin = vfio_user_listener_begin,
+    vioc->listener_commit = vfio_user_listener_commit,
     vioc->dma_map = vfio_user_dma_map;
     vioc->dma_unmap = vfio_user_dma_unmap;
     vioc->attach_device = vfio_user_device_attach;
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 34df9bba7b..6d1446c38b 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -31,7 +31,6 @@ static void vfio_user_shutdown(VFIOUserProxy *proxy);
 static int vfio_user_send_qio(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                      VFIOUserFDs *fds);
-static VFIOUserFDs *vfio_user_getfds(int numfds);
 static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
 static void vfio_user_recv(void *opaque);
@@ -133,7 +132,7 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
 }
 
-static VFIOUserFDs *vfio_user_getfds(int numfds)
+VFIOUserFDs *vfio_user_getfds(int numfds)
 {
     VFIOUserFDs *fds = g_malloc0(sizeof(*fds) + (numfds * sizeof(int)));
 
@@ -609,6 +608,36 @@ static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     return 0;
 }
 
+/*
+ * nowait send - vfio_wait_reqs() can wait for it later
+ */
+void vfio_user_send_nowait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                           VFIOUserFDs *fds, int rsize)
+{
+    VFIOUserMsg *msg;
+    int ret;
+
+    if (hdr->flags & VFIO_USER_NO_REPLY) {
+        error_printf("vfio_user_send_nowait on async message\n");
+        return;
+    }
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    msg = vfio_user_getmsg(proxy, hdr, fds);
+    msg->id = hdr->id;
+    msg->rsize = rsize ? rsize : hdr->size;
+    msg->type = VFIO_MSG_NOWAIT;
+
+    ret = vfio_user_send_queued(proxy, msg);
+    if (ret < 0) {
+        vfio_user_recycle(proxy, msg);
+        return;
+    }
+
+    proxy->last_nowait = msg;
+}
+
 void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                          VFIOUserFDs *fds, int rsize)
 {
@@ -647,6 +676,50 @@ void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
     qemu_mutex_unlock(&proxy->lock);
 }
 
+void vfio_user_wait_reqs(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg;
+
+    /*
+     * Any DMA map/unmap requests sent in the middle
+     * of a memory region transaction were sent nowait.
+     * Wait for them here.
+     */
+    qemu_mutex_lock(&proxy->lock);
+    if (proxy->last_nowait != NULL) {
+        /*
+         * Change type to WAIT to wait for reply
+         */
+        msg = proxy->last_nowait;
+        msg->type = VFIO_MSG_WAIT;
+        proxy->last_nowait = NULL;
+        while (!msg->complete) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+                VFIOUserMsgQ *list;
+
+                list = msg->pending ? &proxy->pending : &proxy->outgoing;
+                QTAILQ_REMOVE(list, msg, next);
+                error_printf("vfio_wait_reqs - timed out\n");
+                break;
+            }
+        }
+
+        if (msg->hdr->flags & VFIO_USER_ERROR) {
+            error_printf("vfio_user_wait_reqs - error reply on async ");
+            error_printf("request: command %x error %s\n", msg->hdr->command,
+                         strerror(msg->hdr->error_reply));
+        }
+
+        /*
+         * Change type back to NOWAIT to free
+         */
+        msg->type = VFIO_MSG_NOWAIT;
+        vfio_user_recycle(proxy, msg);
+    }
+
+    qemu_mutex_unlock(&proxy->lock);
+}
+
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
 
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 053f5932eb..7ef98813b3 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -11,3 +11,7 @@ vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index
 vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
 vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
 vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
+
+# container.c
+vfio_user_dma_map(uint64_t iova, uint64_t size, uint64_t off, uint32_t flags, bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" off 0x%"PRIx64" flags 0x%x async_ops %d"
+vfio_user_dma_unmap(uint64_t iova, uint64_t size, uint32_t flags,  bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" flags 0x%x async_ops %d"
-- 
2.43.0


