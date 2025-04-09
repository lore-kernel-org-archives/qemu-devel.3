Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADBDC369A1
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 13:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Vo7-0007Mz-QF; Wed, 09 Apr 2025 09:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2Vna-0006ak-1c; Wed, 09 Apr 2025 09:49:04 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2VnW-0005fy-9N; Wed, 09 Apr 2025 09:49:01 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5395fx1L010967;
 Wed, 9 Apr 2025 06:48:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=WBtodLEUiNa2GOVf4/6i3ZIGHgcW33zMtZnO00P0f
 ko=; b=xfcKD4RDyKvVpq45MEVRC/ude218RuLMa2GVEHn62wSX00HVU5V5C9Lij
 O4VaU/yiMbE1lnAUfqotvfxg7eNsPk9w2Vj5wBgms/qRerjZvKobuzXtGXFHbqOT
 m/mtjx6dJ/sEmSubs0Cx/8rSCq8BwKFv3pEl3ACgm+KqiqpJ7YvK/IkKK9JE3uHz
 5XZskh4zjoJljwct2a6p8MigvMy6ruI2ZlWZsPHSKwsXNZVVfALUsxx9PcNsa0eS
 CORdvnFfrU5yLgv910kp98Cb0thYAKD/KpJNDocgwEEqwPOrnoQ2lXeDa/bynlLX
 afo94OyNS8OGpu2hwinO8ZKewYDCw==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazlp17012036.outbound.protection.outlook.com [40.93.1.36])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 45u3kksbja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Apr 2025 06:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Llp+WSXA2w0jchdZzTA+KW+rsIlVmT3hDN3a+LCMaDJ7FH3Rb9wrAQoVRBavPHNM0POiH8T8V7WA5QV1rFeVgEnPgezaUL9MRvOXsLX74anCD6+RTpdoyRupTtWk2TBgzUlPJAt3fLINQ/jeaAwf65JYEmJj+Jm9jpQia4RcmpihIwZKBrOZCHc9SQm1I3i7AdkbCQ7cZ6vTv6SKS446yfY5gR1B3V0nDMJvy3BxER8ivvcZFHZwJpAcJ/6PQiQDY6m8P46RPCa5Cd8U8olrVOtpWExRzzpgl5WyGY6QHHWNCQuCz48H2qGtUvQEDi8h2qYMC/nx/wn+P7Yl12CZzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBtodLEUiNa2GOVf4/6i3ZIGHgcW33zMtZnO00P0fko=;
 b=N5mOhOfNpDiv9nSSdhsuClkOeVq3Qx42Tz9x/FoqEuvHhKcq/F5NtTOVu/YZzJBB8eU2xPccif7TAWh8JgJqApyd953tYVXVQdKAitKTdqTYYkzOUCS8FRqz90pfqs3yJkXW6n4iDlrcfv1j8Gf0ESfrZYGr7TNhy34ZJZlYITmEfJGHXDB4dDxqZA27IFc71ubb0IlUYvWUZvkOiawRSbVnuB1wFKComeW5oTNCCsXRtfMNEHVZozSVfay4XsQOKL1NmvcN3UCDvQGnNn1auHO27YhVsLEFWjrQvL81byGOVRrSrPb8jmAtqpYwn0Rykvovn5h8kYO0LK7DEWILOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBtodLEUiNa2GOVf4/6i3ZIGHgcW33zMtZnO00P0fko=;
 b=l6o2hbdePjPQOr8eOHsrBfc94co6HpewkMaUwK6igdeoiPFGac2JnZsiZ8H98uFRGf7Y7hN8ZgthMxJL4ZNtmD0EVGO+WbgrEB6qVq2541ru6f3FR3ry8yaO2pia18sraG17ug6OWF6w7dztvpxCxy0FC88+hI58QCT12oOiXNjV2heUQ/iGjFV9ZZiOjec0OTf86Gld18pvbB4zbbTk8DxpwCCd4gP96nNrK0WGoyaSpbl8nzVdhsjusMuIerYbGR53zfgYGQv7zbbYVxStgAxftzYz/Fq5+Na32BfPaY4DBEe3MWx51LDdhGVpMv+b8TSprB20I6OU3IZ/pJLKkA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7486.namprd02.prod.outlook.com (2603:10b6:a03:2a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Wed, 9 Apr
 2025 13:48:51 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 13:48:51 +0000
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
Subject: [PATCH 11/14] vfio: add vfio_pci_config_space_read/write()
Date: Wed,  9 Apr 2025 15:48:11 +0200
Message-Id: <20250409134814.478903-12-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: b07b5fef-a894-4b59-c753-08dd776d428b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KGajkUEOUBL7palq3HSHow0kYB6chL7+j0xqK5X6sMnmIBzAnqp/jcxRiM6R?=
 =?us-ascii?Q?5SGXcSvc+ibnc5lZxnDeR4oCDMDER8cDF8cINVVkA57f+dycRyZ/rw18Tpxp?=
 =?us-ascii?Q?NyyGRjklttHWwCpILih+c615mKqv6GgnbJJIt/2XlbCBeXMHso584bFNn8tY?=
 =?us-ascii?Q?UB3BG9kKHP+vLGEoKoU96QNzIPq6WoQnUfD9wvWO7J9sbwV2CkFMcR5fK1Tk?=
 =?us-ascii?Q?PSdwbf5uaeoGg+uLCxlsRzpE0NzrtsT7rso/jP/XxgEU1GT+TNiY/U1dT0GA?=
 =?us-ascii?Q?wYJtMPin0K+Nzq7us1TzK2/ie1O1jadeEk1oIhU0cjO8O/G0ASS+Yt0zybD1?=
 =?us-ascii?Q?3EAZWFccJiDsE+tVQsgR2zBZIDcn94yFNLyOtU99+1RYKNED2fOTX4/SljN/?=
 =?us-ascii?Q?qS+I5iZyjEO6mT21GScZV5BRAo2Hl1rvN7rEPzwismIZfdVjC0X5h3YOhN87?=
 =?us-ascii?Q?Ep4979p0FQ4qWhCMKCtyb1Wh7k4rQQ5txWkS/6k0oTjYl/vyGI2oNv/pQ6IQ?=
 =?us-ascii?Q?c4CPr2B7vbk4knsIGpgrgoCV30zf9U84siVF/UVTJGSTMTkjQgKr8sPOP1f1?=
 =?us-ascii?Q?azC3/GzFsrD9zjaQKws4B9gQhrG9Q3nYz/IEI03ltjG4sjyDFsFqKhojfjnP?=
 =?us-ascii?Q?w568zkv4tydU0fOm3mfknxaSbbi886cMKNSDDWwJa/QV9nc/P3RmccY+qq7f?=
 =?us-ascii?Q?8ko2Dmys2xX02aVu19fT+sRKyP87drwaszhwjJEXtbzLFEMoCcHbsN0EO8Qa?=
 =?us-ascii?Q?4X4v2Gjakf/wfp1p6hGNGsTxPyxi0FM6Zz+gFljpU7fteQHNAhkevXo3WKVM?=
 =?us-ascii?Q?AduasjBcfF0FBjWg7NE6ZILqLmMPY31SSxT8tboPYrEcqlcaf+Za01IwC30J?=
 =?us-ascii?Q?1VInuLlXqb9CG3MBXuf0m3xy9znPmVwBBfdkqQCR7sx4IpIv+ECexqQOLDFo?=
 =?us-ascii?Q?Rv41qBYWgwAbz+OSEfiNfvsItbBLRQ2m/hO5fzPbyuaGRtRqdLcSDPIWZKmq?=
 =?us-ascii?Q?gUKlryrUxD9PQF7fK82OWNUnsmLb8E4SoNeF8pR20Gn9w4mBR2Xz5t8vDusx?=
 =?us-ascii?Q?xC/tfc0lxuWlsApCpXVVa5ao80Tbc366s02zbOGvyXrhn8gA2jvdiIIHFOCb?=
 =?us-ascii?Q?x/NNLwzkSz1J2h1Z2BX8StNeWQpLKjwR3sW18ayl/SdoxapxqpGQ/dpOG1yd?=
 =?us-ascii?Q?Ec5zHgxuy8R5CU1sV50KdUG1tBjV2pkkDDDuv0oEz+0Krjm042QLkJslSHga?=
 =?us-ascii?Q?Fgnk6q2V9XdW69ZoJsF4koT1YW/FLhVvSnR2YW1TB1AGIXG9xs1nWMaLJ5FI?=
 =?us-ascii?Q?f+o8eUnmtVuUyclMDuW7ne5DONMGINJhmjlfclm34hXE0py89nfVAbwxwPp5?=
 =?us-ascii?Q?NtKu5we2U7moa+HwmOTOfpL/7GCG4seVhcWkEQKRhxfDCCJTW+p9qihZTGte?=
 =?us-ascii?Q?t/uObBE8Tws=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SYj/ciMG5UP0l2rY+ZcXEyTHKBbY9DLjTcU5mMRKk/0JZ0/yMvJ3S1civLKf?=
 =?us-ascii?Q?CZMQaXb+cDj8zPog6dhcl8Zhmu0PqL1Sxyi8t+5GscrfXXQcGkpLNJOaVoFO?=
 =?us-ascii?Q?BbT/RTYP4tiRgaTJyJPN3dFvuHg1fzS7+m/pdf8Wg1eriRmNDCfQ0unuhLSA?=
 =?us-ascii?Q?x2MY2Odwh5DbOnQDaOKBDCsQcuhwKFSCz5OF4xGCHMvxaOn4/YBzZF2ZEZDo?=
 =?us-ascii?Q?VNxhE7jvO2dEni5alu3y61vcE5JyOCyXLSHpjWiLIOWX9jzunfVFO3LFXJK1?=
 =?us-ascii?Q?jGZ/4+cWBuTKEfdYlOZM65es5333vTSUZFieXwP1Edzp8GHKSU0Ady5lqKaD?=
 =?us-ascii?Q?l4H/V1lemPrdpCn9DoOzD7vpSswHp2hsnTmNDfCQ0rr5yTE93vr1pIPlucHn?=
 =?us-ascii?Q?lTWqFZ/lmCluDhLU0HpuGGAkvLKNKqT89zMuBjW6b6ftNbnb5z8lsKlhPj1/?=
 =?us-ascii?Q?cdsJVCqz8rC0dey2uPOq0x/wv6i3EhpeJyVyA5FEzPMw85NaUihh3OW15qRr?=
 =?us-ascii?Q?VdC6sOfX9HewyrweZPUCm8gCiO27UqQXvlU3eNuF404NldsF49YcEbXiGpXl?=
 =?us-ascii?Q?aCBUH6cIV2HuKLJ2g3Di9Q05UStvclyKcjwougbn6+4+MIxLi0cWQYBehXW0?=
 =?us-ascii?Q?s/m8EB4pkzEifMmw4A1Xhio3vmaq9oA+V/5C79OKxn+q1MjZ5grAOtkayOcN?=
 =?us-ascii?Q?s4bKMSORyuMPpo5UMGGjZQsMxC9EL6WWRDca1mUZgyGIZD3GUvTV1QATJ6Ft?=
 =?us-ascii?Q?be7Qdu6GuaByIWI+XRrQdRhodakimBQLGS2RRvfF2IAPUQ8oTujZaKOCGnBD?=
 =?us-ascii?Q?/jTx0Lrm4lbnhF9h7SKM+iiS61Wj8nLnTs1Wk7IGEDCtZP4yTFqQpRKpxyo8?=
 =?us-ascii?Q?uzYwJS8LhBVgBmacg1DVCtR69lSeMVrRil0K0lKYKWClwAdQsBNm1OYseRgs?=
 =?us-ascii?Q?wVQ1rvapPnENR8Rr6O+yetKnt8RLWj7TJ+4Z+cNBhgCWKV5r9jLmXITjBqp3?=
 =?us-ascii?Q?MKaKTbegV2njhb1KOB2BNLXoiWsBkiLibNdyUY261fu6/iJuatokiMxcWdJe?=
 =?us-ascii?Q?+1uI2xhxxJqZ6MVkWJqVGL30WHnmaTIIvDbkQtEBxuJL/g08N0MKkNANetEU?=
 =?us-ascii?Q?EQdf/V7inbBznmQ+lKPRk1IxcJE7AbIZVqZ/QlReEC97K62jBjxLF9HIp+P8?=
 =?us-ascii?Q?RQFNI+7I0hyiyeqhjC8zm32ZAO2fxkFml7FhYkLvjAxcdeM5rN4dAOfuEDQk?=
 =?us-ascii?Q?IAcxDTuNMtLk2FMTymmalog87pItj7D+r5QLPIO5jP9yMHfAZ1iF4z8Ho7TK?=
 =?us-ascii?Q?LMGARM/WeL5MJZ5T9Uz/c0nnLA1oYkrR07ceqCQZXFUhfiAmXnjeY8/pkXr3?=
 =?us-ascii?Q?vGD92NGfHQO5ZcKO1EXEy1I02bH+8sM7SZV2wMKYQqSxpzCudGsh6xWGDIHH?=
 =?us-ascii?Q?qYBkxC7MANSVWy9+jGaFenWwdIH5EwGxEoYYHJaSTeg9jizQOl+b3kl1HAeN?=
 =?us-ascii?Q?s+KUY5BorHysDwWyrt3m89euuwknAHwUlC4b2yOFAdI0YUxLTiDv1l0CVQLF?=
 =?us-ascii?Q?9uiAgEiBN+DoTY8/w9Wsb2GS+JZqwgD0ZUATOTW2?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07b5fef-a894-4b59-c753-08dd776d428b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:48:51.0821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYJCxMGS2yguHCltz/PdMaaB73eJc1z2W1ipx33QIUDPlkkUDMPSXBW0jjfKPTYPLK+YR++oNEkLtR1/do714Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7486
X-Proofpoint-ORIG-GUID: 0kofZXopyUvpt9bg8t-GkTxVGWA3DcmQ
X-Authority-Analysis: v=2.4 cv=d+b1yQjE c=1 sm=1 tr=0 ts=67f67ac4 cx=c_pps
 a=eoA+jwG2N97X2eoE7Om4vA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=uWZQxr4v0eqUK10gj4gA:9
X-Proofpoint-GUID: 0kofZXopyUvpt9bg8t-GkTxVGWA3DcmQ
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

Add these helpers that access config space and return an -errno style
return.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.c | 134 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 91 insertions(+), 43 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ddeee33aa9..c3842d2f8d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -964,6 +964,28 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
     }
 }
 
+/* "Raw" read of underlying config space. */
+static int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
+                                      uint32_t size, void *data)
+{
+    ssize_t ret;
+
+    ret = pread(vdev->vbasedev.fd, data, size, vdev->config_offset + offset);
+
+    return ret < 0 ? -errno : (int)ret;
+}
+
+/* "Raw" write of underlying config space. */
+static int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
+                                       uint32_t size, void *data)
+{
+    ssize_t ret;
+
+    ret = pwrite(vdev->vbasedev.fd, data, size, vdev->config_offset + offset);
+
+    return ret < 0 ? -errno : (int)ret;
+}
+
 static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
 {
     VFIOPCIDevice *vdev = opaque;
@@ -1016,10 +1038,9 @@ static const MemoryRegionOps vfio_rom_ops = {
 
 static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 {
+    VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
-    off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
     char *name;
-    int fd = vdev->vbasedev.fd;
 
     if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
         /* Since pci handles romfile, just print a message and return */
@@ -1036,11 +1057,12 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
      * Use the same size ROM BAR as the physical device.  The contents
      * will get filled in later when the guest tries to read it.
      */
-    if (pread(fd, &orig, 4, offset) != 4 ||
-        pwrite(fd, &size, 4, offset) != 4 ||
-        pread(fd, &size, 4, offset) != 4 ||
-        pwrite(fd, &orig, 4, offset) != 4) {
-        error_report("%s(%s) failed: %m", __func__, vdev->vbasedev.name);
+    if (vfio_pci_config_space_read(vdev, PCI_ROM_ADDRESS, 4, &orig) != 4 ||
+        vfio_pci_config_space_write(vdev, PCI_ROM_ADDRESS, 4, &size) != 4 ||
+        vfio_pci_config_space_read(vdev, PCI_ROM_ADDRESS, 4, &size) != 4 ||
+        vfio_pci_config_space_write(vdev, PCI_ROM_ADDRESS, 4, &orig) != 4) {
+
+        error_report("%s(%s) ROM access failed", __func__, vbasedev->name);
         return;
     }
 
@@ -1220,6 +1242,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
 
     memcpy(&emu_bits, vdev->emulated_config_bits + addr, len);
@@ -1232,12 +1255,13 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
     if (~emu_bits & (0xffffffffU >> (32 - len * 8))) {
         ssize_t ret;
 
-        ret = pread(vdev->vbasedev.fd, &phys_val, len,
-                    vdev->config_offset + addr);
+        ret = vfio_pci_config_space_read(vdev, addr, len, &phys_val);
         if (ret != len) {
-            error_report("%s(%s, 0x%x, 0x%x) failed: %m",
-                         __func__, vdev->vbasedev.name, addr, len);
-            return -errno;
+            const char *err = ret < 0 ? strerror(-ret) : "short read";
+
+            error_report("%s(%s, 0x%x, 0x%x) failed: %s",
+                         __func__, vbasedev->name, addr, len, err);
+            return -1;
         }
         phys_val = le32_to_cpu(phys_val);
     }
@@ -1253,15 +1277,19 @@ void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t val_le = cpu_to_le32(val);
+    int ret;
 
     trace_vfio_pci_write_config(vdev->vbasedev.name, addr, val, len);
 
     /* Write everything to VFIO, let it filter out what we can't write */
-    if (pwrite(vdev->vbasedev.fd, &val_le, len, vdev->config_offset + addr)
-                != len) {
-        error_report("%s(%s, 0x%x, 0x%x, 0x%x) failed: %m",
-                     __func__, vdev->vbasedev.name, addr, val, len);
+    ret = vfio_pci_config_space_write(vdev, addr, len, &val_le);
+    if (ret != len) {
+        const char *err = ret < 0 ? strerror(-ret) : "short write";
+
+        error_report("%s(%s, 0x%x, 0x%x, 0x%x) failed: %s",
+                     __func__, vbasedev->name, addr, val, len, err);
     }
 
     /* MSI/MSI-X Enabling/Disabling */
@@ -1349,9 +1377,12 @@ static bool vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
     int ret, entries;
     Error *err = NULL;
 
-    if (pread(vdev->vbasedev.fd, &ctrl, sizeof(ctrl),
-              vdev->config_offset + pos + PCI_CAP_FLAGS) != sizeof(ctrl)) {
-        error_setg_errno(errp, errno, "failed reading MSI PCI_CAP_FLAGS");
+    ret = vfio_pci_config_space_read(vdev, pos + PCI_CAP_FLAGS,
+                                     sizeof(ctrl), &ctrl);
+    if (ret != sizeof(ctrl)) {
+        const char *errmsg = ret < 0 ? strerror(-ret) : "short read";
+
+        error_setg(errp, "failed reading MSI PCI_CAP_FLAGS: %s", errmsg);
         return false;
     }
     ctrl = le16_to_cpu(ctrl);
@@ -1558,30 +1589,39 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     uint8_t pos;
     uint16_t ctrl;
     uint32_t table, pba;
-    int ret, fd = vdev->vbasedev.fd;
     struct vfio_irq_info irq_info;
     VFIOMSIXInfo *msix;
+    int ret;
 
     pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
     if (!pos) {
         return true;
     }
 
-    if (pread(fd, &ctrl, sizeof(ctrl),
-              vdev->config_offset + pos + PCI_MSIX_FLAGS) != sizeof(ctrl)) {
-        error_setg_errno(errp, errno, "failed to read PCI MSIX FLAGS");
+    ret = vfio_pci_config_space_read(vdev, pos + PCI_MSIX_FLAGS,
+                                     sizeof(ctrl), &ctrl);
+    if (ret != sizeof(ctrl)) {
+        const char *err = ret < 0 ? strerror(-ret) : "short read";
+
+        error_setg(errp, "failed to read PCI MSIX FLAGS: %s", err);
         return false;
     }
 
-    if (pread(fd, &table, sizeof(table),
-              vdev->config_offset + pos + PCI_MSIX_TABLE) != sizeof(table)) {
-        error_setg_errno(errp, errno, "failed to read PCI MSIX TABLE");
+    ret = vfio_pci_config_space_read(vdev, pos + PCI_MSIX_TABLE,
+                                     sizeof(table), &table);
+    if (ret != sizeof(table)) {
+        const char *err = ret < 0 ? strerror(-ret) : "short read";
+
+        error_setg(errp, "failed to read PCI MSIX TABLE: %s", err);
         return false;
     }
 
-    if (pread(fd, &pba, sizeof(pba),
-              vdev->config_offset + pos + PCI_MSIX_PBA) != sizeof(pba)) {
-        error_setg_errno(errp, errno, "failed to read PCI MSIX PBA");
+    ret = vfio_pci_config_space_read(vdev, pos + PCI_MSIX_PBA,
+                                     sizeof(pba), &pba);
+    if (ret != sizeof(pba)) {
+        const char *err = ret < 0 ? strerror(-ret) : "short read";
+
+        error_setg(errp, "failed to read PCI MSIX PBA: %s", err);
         return false;
     }
 
@@ -1741,10 +1781,12 @@ static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
     }
 
     /* Determine what type of BAR this is for registration */
-    ret = pread(vdev->vbasedev.fd, &pci_bar, sizeof(pci_bar),
-                vdev->config_offset + PCI_BASE_ADDRESS_0 + (4 * nr));
+    ret = vfio_pci_config_space_read(vdev, PCI_BASE_ADDRESS_0 + (4 * nr),
+                                     sizeof(pci_bar), &pci_bar);
     if (ret != sizeof(pci_bar)) {
-        error_report("vfio: Failed to read BAR %d (%m)", nr);
+        const char *err =  ret < 0 ? strerror(-ret) : "short read";
+
+        error_report("vfio: Failed to read BAR %d: %s", nr, err);
         return;
     }
 
@@ -2448,21 +2490,25 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
 
 void vfio_pci_post_reset(VFIOPCIDevice *vdev)
 {
+    VFIODevice *vbasedev = &vdev->vbasedev;
     Error *err = NULL;
-    int nr;
+    int ret, nr;
 
     if (!vfio_intx_enable(vdev, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
     for (nr = 0; nr < PCI_NUM_REGIONS - 1; ++nr) {
-        off_t addr = vdev->config_offset + PCI_BASE_ADDRESS_0 + (4 * nr);
+        off_t addr = PCI_BASE_ADDRESS_0 + (4 * nr);
         uint32_t val = 0;
         uint32_t len = sizeof(val);
 
-        if (pwrite(vdev->vbasedev.fd, &val, len, addr) != len) {
-            error_report("%s(%s) reset bar %d failed: %m", __func__,
-                         vdev->vbasedev.name, nr);
+        ret = vfio_pci_config_space_write(vdev, addr, len, &val);
+        if (ret != len) {
+            const char *errmsg = ret < 0 ? strerror(-ret) : "short write";
+
+            error_report("%s(%s) reset bar %d failed: %s", __func__,
+                         vbasedev->name, nr, errmsg);
         }
     }
 
@@ -3099,6 +3145,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     int i, ret;
     char uuid[UUID_STR_LEN];
     g_autofree char *name = NULL;
+    size_t config_space_size;
 
     if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
         if (!(~vdev->host.domain || ~vdev->host.bus ||
@@ -3153,13 +3200,14 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
+    config_space_size = MIN(pci_config_size(&vdev->pdev), vdev->config_size);
+
     /* Get a copy of config space */
-    ret = pread(vbasedev->fd, vdev->pdev.config,
-                MIN(pci_config_size(&vdev->pdev), vdev->config_size),
-                vdev->config_offset);
-    if (ret < (int)MIN(pci_config_size(&vdev->pdev), vdev->config_size)) {
-        ret = ret < 0 ? -errno : -EFAULT;
-        error_setg_errno(errp, -ret, "failed to read device config space");
+    ret = vfio_pci_config_space_read(vdev, 0, config_space_size,
+                                     vdev->pdev.config);
+    if (ret < (int)config_space_size) {
+        ret = ret < 0 ? -ret : EFAULT;
+        error_setg_errno(errp, ret, "failed to read device config space");
         goto error;
     }
 
-- 
2.34.1


