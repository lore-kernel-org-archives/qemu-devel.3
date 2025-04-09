Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CB3C369A4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 13:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2VnA-0006Cz-UM; Wed, 09 Apr 2025 09:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2Vn9-0006Cg-Q7; Wed, 09 Apr 2025 09:48:35 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2Vn7-0005c5-N2; Wed, 09 Apr 2025 09:48:35 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5394KCkY013833;
 Wed, 9 Apr 2025 06:48:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=rR9V28JDgt5opNsu9/R0xl+qLHN6JE+OBMZWRsZR4
 YA=; b=t7k4uHwqd+4WNADf9xRV4eDG82TQDp1bkLyA+HocIkm+UpR/qR3AUmuz5
 joBwhwqgYZaE7Acvhp0RZywunNoNYjVLWID+Wed+tPSTCpCuTUIwNtkzhqYeoBos
 1HrYnBqAbl6tEZj7B0dl4+L8ke30VqcwB9eAbbOmlWz4usY/8xUFAO3nq6YWfz5/
 MtNkegYRcXq1rCfEJ3clpLvqXtxZpIbCCzFwIL2GI6Tonh2Zzj3ATdMqMT3HXOhe
 QKsX8jBM43IpbI4muLOr+CLWDkDyTvz+qVSVtR83MZJPuiMMMgO9NAWBqFBCziSw
 pjUZcJe2ov9tmQOsmwGVKRxy7ZzBQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazlp17012033.outbound.protection.outlook.com [40.93.1.33])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 45u42xhapg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Apr 2025 06:48:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owfV5GBL/MZtd9Z197d5OfTS/uZTTT2oqPwWsstOJzoLtZo6o4pGxk5RWEwKv8H5kBiYq9gCqtcD8f2hIeUSXZviWuBhRt5lB6kh9CJBBD1rS0qTjaeqmlxVMzQhMVoU6xD+DsznssKGRPNx1USo2IgdRdNayCc97W5p4qPkEf0CkVSqiPAcjTHok35+gLcB2L/A2Yo+/YI6Ul52qllawIiqHATMiXfwV29K6TMLTS9DxHFmYPo6YUopouxvJoFqFdI7o+eqXbACfP+n3eYRQXOgwWm5cCFigOd40Wj3c7zQppsG8dmmg+g1ouqoxOx27yybYOPjT8TkVvcM+pTi8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rR9V28JDgt5opNsu9/R0xl+qLHN6JE+OBMZWRsZR4YA=;
 b=XpyOgLNNYq9qofeew5xOpGOhbkefRq2r0P2NWAh9GAKBTq9lMlr+my6WaSHdx13ekCHqrm6nPkb1YFQYQUAVo7HpYgQpzpgZYkDBdylYiXRkmUYESSmENLYBlKlWF3gpAwLbYoQqft4yVaXXVplGytXe50fMSW695PNow/Dm9W0nOxBBGWmc/jTM+Flytc8hz/uUxH6aObrIFrDbx9H9VOMeNRzqE3b+iLB5JhaybbzhPBcUBHvMu63HZISJrE/onlQH+mp1DD6fcOxwZvbD/vyeyBmmfQlywBYkaJKcde3dIzu9FTgSxkF4xccbqTquMp6XW8salSBghG32aRgZhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rR9V28JDgt5opNsu9/R0xl+qLHN6JE+OBMZWRsZR4YA=;
 b=zCQbJQ2oszA+huHu1z/0nZ9XSl/OES/XkW9PUgeNCcrkDmQmKj16+u+oEuN8nHNsF/lDi2DH/0qF4JxNe4zCKiB4eO3JFkF5KlfvzLiwxVSEJVc+K9eFpQopS9caa4H/X6U/b3ctBeC2oiya6z60k2QHZ0MEbdGsDyMqS2Y9F5aqj9DQ8jslvsheJv+SIEgrkSUbe9XG2u50Xit8WPKnRDVfPb1j2RJdZgf3ueMWSEM21rDvO6Ffft7a83WqXnzv8uIVq6+f0TTKL0VMGoXrW69Un+UQHQWpfaISjGUBG2/UfF41OgYnt8bph53ThoxKkVZmAXYRckyFOhQIAdcuqw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by MWHPR02MB10356.namprd02.prod.outlook.com (2603:10b6:303:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 13:48:27 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 13:48:27 +0000
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
Subject: [PATCH 03/14] vfio: add vfio_prepare_device()
Date: Wed,  9 Apr 2025 15:48:03 +0200
Message-Id: <20250409134814.478903-4-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5c4d7640-bdc1-4508-5079-08dd776d3463
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/zRmNKfUnV9eRVcG5CqtFWfE8SoKJnCGHsSAXZ8i+qO1UFtD73qjr90ko4Uz?=
 =?us-ascii?Q?1um6uZ18I9VASuwhfmbrY5dRNtpSMd0UnPH/yUv9XllC0zAxl8ualhPmBqTH?=
 =?us-ascii?Q?xLbeXP85ftFRDeFgQU5s42eeFv6MYs9vJHQBA0LMLQMc8jaEzuuMxrtjj87N?=
 =?us-ascii?Q?M8IuksRgjWfosTn2JODbCc6mDfC09alkYEMeDDR0oQCVKlXsDJ4uV8hyMcO1?=
 =?us-ascii?Q?unExKgcjVcAP4Alx6aKBlra5XyAopA+zn2+vaKfl8oBHsXpKFbvZyn44IZyu?=
 =?us-ascii?Q?0lFZEi7Zm2z44pJtddJsaS3ldaIqc0K78m4nLEWwmrnDIIYWmp7DOtB+cjyS?=
 =?us-ascii?Q?cor1hROfx3qqelKEVWeb4ssi2rqGahAS3jxY6tHBqT6YY62a+i0zbdUMshZx?=
 =?us-ascii?Q?MOQGASMG0PbsHF8EVWJ56ESDUph1Y+Dp0dl56yZwUmdsJ1+d9O2MC0KIYc+i?=
 =?us-ascii?Q?jIszrJ+RA5ZreSPjCh/snpmWFzutXQIoGl/VhsDvO+fCoHX+4HlpagFdXIEv?=
 =?us-ascii?Q?iZArWEGCluaJuxC8uK8knHqbOU67Tr5yNbPUFheey9TVbUAEor8+4DkmqYay?=
 =?us-ascii?Q?zq5d0aGJPQ5G+rbC7LvPAMcTTFtT3VPC1hEfm0cJ1iAs9k7VR+WJfBS/20j4?=
 =?us-ascii?Q?4gJw4ONjErt7cXWffTya9JJDrD6TwN7E8Dz37NksC2KUQCrDqYVmV0BvjaOS?=
 =?us-ascii?Q?R/klbtR/G8X7c3s/ZE11BVHQE4iDPdVTRAIUZbpAA7I5GvJhciWgSu3NJCKf?=
 =?us-ascii?Q?YVOnuzcLtkdi87uEauGO7xhGurYscLb6vAv/rxko7g3S8YhFZDq4t0yakNl5?=
 =?us-ascii?Q?HRRrxwSJu8iNS0Gpce6xkhx315hKYs75/j/ZCBRiQFeH6d8iyE0O1S5PMSy9?=
 =?us-ascii?Q?gQnIXUApJBNnL10f4TBpOkpYBHW3cAez0DRLhKKVJ9Gr+TlRGDo9UaaxbxAK?=
 =?us-ascii?Q?3LROrT+eGNatwbxFpBT0yLmB2QdV9xkNh9UxeJKs5SF/D5xOD4VwjVUUpiDO?=
 =?us-ascii?Q?pOzE1TOEwfSUHtsXMdyY/OwVroDNfCcahLfNvAXRlc4b4xc+iw3D40AWNrB3?=
 =?us-ascii?Q?ZK44qdeeJ8lVuyNDz/2JXcg767D6d5W803A/qr++IRFVyb7Q9bJ8mz8ZJrg0?=
 =?us-ascii?Q?Tb3/MGvnyPqFzd+PpQSmdaXYPLi+2bexnIhbo5oJzfmJzw1R25L24gZrgvx9?=
 =?us-ascii?Q?N5wUVUmOFE2YUhcWnDOhxE3eeDqslpEo5zpY2XcWo0a4DknIyIqM496ZPNTQ?=
 =?us-ascii?Q?sE0QLWzW14tcZBZcJCi0xyxgfByW2+V8A6BgCjRr+oH4LTR1IDBrXV8gPHku?=
 =?us-ascii?Q?uDV5Zi5Nq+Ibov8kbXStJieVjCWiEvNrhrdFvzCCZqv/KClJvPwjTVs1I6Ck?=
 =?us-ascii?Q?Vjk3tpeN94mKqeBoiGEfO6BS46Tt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VMpTYSElSRXZhLGn3L69DXxRI4UiEyouXvWawHlESoxn2OJdO6QKGqgzUlS9?=
 =?us-ascii?Q?BPR7MBrQaMjJDsk9MtwFY4eL7U53P8Qnu5xiHQUyRmxioOxI8hyKtWRYBYs3?=
 =?us-ascii?Q?wspn0d5y8oZ9N8th/YjKwpPbn9wQ6MrEQvk9/JAGUYeyLFwK+1iSOj8A1cfP?=
 =?us-ascii?Q?6KvtrRKgD+WmyXtMRsmvjLpWcJJdm6/zGSf5V3M23Uh0wb8Fgur451USTWwf?=
 =?us-ascii?Q?8Sc9g+za5sJE8QbhEbZt/WkS+dpyWG98tvLdFQVoDai9DYXv8zfPBV/A7yqQ?=
 =?us-ascii?Q?3EEEVjYf+aP2rh+bizOVE9c2B803bnvqqSbOI4fsC+SDyISHKAHAa2iAfnG2?=
 =?us-ascii?Q?HYqwQOWPvnsTjYw3cRJdg20nvFbAVKWxY2a6vCOY+eQR6SYwyEB6o4vxx3dM?=
 =?us-ascii?Q?uKJbeDb9js/6IyJ9KSxyeNtsFl3hEK8WUzEPL8oAGZDBhSqSLbj5Yfr0C34R?=
 =?us-ascii?Q?JHrU5qrdvDzVFJt7EA123lw+ki9G+QZ6IFhO2gM0/mUKab2ISmZ5fAmG3aep?=
 =?us-ascii?Q?XLltcx4BCJ9FC1Hh363wxS5QUwjwzSdv/QJ67OyR87KIhEf4XyyrwUuhHyZI?=
 =?us-ascii?Q?BcysvA30k93tMdnAvOfyDQhD3kxQmfhatX0+KFtw7ky8lMMOdaHGBeokBv5q?=
 =?us-ascii?Q?RQurt26oT7JCk05pUWdVZbCyxVq95x7IseC1Uw5Z+UrCDFxhOVNeMY15Tz6U?=
 =?us-ascii?Q?tghxZo6ym5VsRrdhLK7YmXlha1yxi+NYUR97p5s+4TbAUVfJseZEKxGkhDgr?=
 =?us-ascii?Q?W05S/D5s0a6l2fqVDNVD/5kSRgILQyl/3etNc2nDbZ54e7EvteDKmWER/E+o?=
 =?us-ascii?Q?SQuIk/xYTbCXfe0avaupZJM7Q20SW6VrF7N4uMTEg6ZnmQxeEPeCpwnQtTYr?=
 =?us-ascii?Q?dKKWC/Qd1n4ExoA/uUia50bUqYIdOfhJD1wPZ5V6VJwfnJ2FNKMIWKLII7ED?=
 =?us-ascii?Q?GuAtSQMJfvC1KUy64s16cTrMGzdLkVUG7i14Cnj0WRLrR4uS0+hZ1hfD8ZQP?=
 =?us-ascii?Q?8N2xcWwT1EPQbJNoNiR7O2zlAfAk0qenboQGvWMo/cLBWScRdNgNdJ+ehaUT?=
 =?us-ascii?Q?pCfleqVmkNpa/WbKNLI6RzZDQFIOBpm6tc8wCYSpDElnbGgZRruB/QfD3fLi?=
 =?us-ascii?Q?BednzS/Zn9TCQNFp17N5XghlK82sgCOWko82eaLJ3oTCy6rzYeFUG4cQTDWh?=
 =?us-ascii?Q?EvuH9e96DcdJjyqjU8FHe6oKWEJ9VbgoqRq8RPJTgjgAdDKvVd0TswMnXqXw?=
 =?us-ascii?Q?oL9mOl71HcyUd4tBkV1c4IXKPwwuTERfMMN2yLC6fc8YLuiMsYJemFndATaw?=
 =?us-ascii?Q?+vtB9vZI2Wwyfqe9zyAoBJ+SxkfW4ljcEW4D65fZNzBTBAPqbMDokwKpOvSG?=
 =?us-ascii?Q?CrIcWF2sgT8qfy0ZYO1CzIdCXzXVItN+yIiXVOng19azv1rkI0qEbPBZV/QG?=
 =?us-ascii?Q?o3FXYupqA8flB+XSrZsD67aqDHw8YzbnOWLOLCO2FHNi6C1q3nyA98C2x0hz?=
 =?us-ascii?Q?yGMRT9cTjnQlsChrpLhC5+pel4QXI3iB/O4AERTkAYJYfYje3CcmGVvA/CZQ?=
 =?us-ascii?Q?ZSdSpQcNCPIK6c7pHGpZ2SjAjo03xiK0nfu+1kWX?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4d7640-bdc1-4508-5079-08dd776d3463
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:48:27.2080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94/ASm0ilQZUo9UVt+DBVlfkRhTnhwdTTfxq380cid7raIihrrkUCnQTLRuu+2ZjDm6kI0NeYzI615k+oBef9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10356
X-Proofpoint-GUID: XthCq4EzMPmiIi7wVMEqtVULCaPtMK9K
X-Proofpoint-ORIG-GUID: XthCq4EzMPmiIi7wVMEqtVULCaPtMK9K
X-Authority-Analysis: v=2.4 cv=LMxmQIW9 c=1 sm=1 tr=0 ts=67f67aac cx=c_pps
 a=eo5EBrZojstUK48b9mIPDA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=PEtKgAuwMexoxjSetS4A:9
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

Commonize some initialization code shared by the legacy and iommufd vfio
implementations.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/container.c           | 14 ++------------
 hw/vfio/device.c              | 14 ++++++++++++++
 hw/vfio/iommufd.c             |  9 +--------
 include/hw/vfio/vfio-device.h |  3 +++
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 23a3373470..4fc181d33b 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -811,18 +811,14 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
         }
     }
 
+    vfio_device_prepare(vbasedev, &group->container->bcontainer, info);
+
     vbasedev->fd = fd;
     vbasedev->group = group;
     QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
 
-    vbasedev->num_irqs = info->num_irqs;
-    vbasedev->num_regions = info->num_regions;
-    vbasedev->flags = info->flags;
-
     trace_vfio_device_get(name, info->flags, info->num_regions, info->num_irqs);
 
-    vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
-
     return true;
 }
 
@@ -875,7 +871,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
     int groupid = vfio_device_get_groupid(vbasedev, errp);
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
-    VFIOContainerBase *bcontainer;
 
     if (groupid < 0) {
         return false;
@@ -904,11 +899,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
         return false;
     }
 
-    bcontainer = &group->container->bcontainer;
-    vbasedev->bcontainer = bcontainer;
-    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
-    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
-
     return true;
 }
 
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 4de6948cf4..4d940ddb3a 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -403,3 +403,17 @@ void vfio_device_detach(VFIODevice *vbasedev)
     object_unref(vbasedev->hiod);
     VFIO_IOMMU_GET_CLASS(vbasedev->bcontainer)->detach_device(vbasedev);
 }
+
+void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
+                         struct vfio_device_info *info)
+{
+    vbasedev->num_irqs = info->num_irqs;
+    vbasedev->num_regions = info->num_regions;
+    vbasedev->flags = info->flags;
+    vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
+
+    vbasedev->bcontainer = bcontainer;
+    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
+
+    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+}
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 48db105422..1874185fcf 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -587,14 +587,7 @@ found_container:
         iommufd_cdev_ram_block_discard_disable(false);
     }
 
-    vbasedev->group = 0;
-    vbasedev->num_irqs = dev_info.num_irqs;
-    vbasedev->num_regions = dev_info.num_regions;
-    vbasedev->flags = dev_info.flags;
-    vbasedev->reset_works = !!(dev_info.flags & VFIO_DEVICE_FLAGS_RESET);
-    vbasedev->bcontainer = bcontainer;
-    QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
-    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+    vfio_device_prepare(vbasedev, bcontainer, &dev_info);
 
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
                                    vbasedev->num_regions, vbasedev->flags);
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 66797b4c92..1a2fe378d0 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -129,6 +129,9 @@ bool vfio_device_attach(char *name, VFIODevice *vbasedev,
 void vfio_device_detach(VFIODevice *vbasedev);
 VFIODevice *vfio_get_vfio_device(Object *obj);
 
+void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
+                         struct vfio_device_info *info);
+
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIODeviceList vfio_device_list;
 
-- 
2.34.1


