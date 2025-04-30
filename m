Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C066C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uADIc-0007zo-60; Wed, 30 Apr 2025 15:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIU-0007tl-EY; Wed, 30 Apr 2025 15:40:47 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIS-0006D1-Jb; Wed, 30 Apr 2025 15:40:46 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UDpuEp004896;
 Wed, 30 Apr 2025 12:40:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=0JCQklG/D+016dQeqWDNDFJ8upw4pb5CR+vFnJ/gx
 K4=; b=TZJEUrKkrtyR7ShD9+wXnT45Z+oZrd6L+2OxZdhVKdoxQJcG/2me7qn6n
 VB5nrffBK7MzUfsY5hjSn7w9N7xJWdY4HgajqXXgS9BtPBtRY95JMQHdyxa+L7v7
 qqumYKvNx+Q2kJXCb220qpHS5l3N2UZQil8K9rT0KDEQ8RlebQxdEwZ1yeXcDsNi
 4GIJKnrlN95cPGRQ38nkMXVUOWtOT0Sgh2sX67R4GnyYlc8gIZng8dg1x02Y2kz8
 Duu+urRQ4LQ4HPgDcZPioLuZmfNJVRgzzvhDeC6rVVtLeAkyNMPgrF+eVOdDOMGs
 HtXWX51KaallWu1H0Y0wZu12J6eaA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010002.outbound.protection.outlook.com [40.93.1.2])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 468y109yca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 12:40:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9KNEfculltHKpp5TRccrnAGvw95fudu7iAWWNKoIz7eaoFxlOYQ7MgTGPoVkmfxZR/4lakT+mbCfRxZ3Z5WEs07sYIJgdT0YTNyPLam7WZrUNppK6UI87Amim0wepGnHwXGuEz5Can3Ksdh6353uMXu40wj3r0TpLVjmjjoJvMni/eCKc8rFOExsWcodJdLr6p5G90tYhibXciaaeUcDBu28trMy1K5qsyWbZoM1pBk7G9Q4jSd4u2jeH4OKtVQrcKUf4Ap/Ws4GBXrZb+NKo0OA4Svx1XhzPZj8YsTGsGc88/PSzEEd9ZIyjAM1SB0aZEEEVf0fQFQ4/FTGipxvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JCQklG/D+016dQeqWDNDFJ8upw4pb5CR+vFnJ/gxK4=;
 b=qN/THOfbn/3051bMwJozhG4XEAd5nYylIJM8mbS2CudR2dPFoVUmh1hsRo4VIUyhKa1OxwAK9hBtbq6tudLZq41JOwO/WChlVb0kmIgwVt7upKWFK3kabAGWpTxuDMdG2kUigimXxeHk4AbrVMcSsYEO1TUMGrBHHGbD6B5z7lzQTlCIjHXMnuFyhMPCIiTfB/dvopbDk35cNA5LC/6Ig8DMP8UTw67Td+yH6FY8Q+98MAVkX8PQPWowMOBNgjyLv4vBiqOKQH9X0a1jp4BUDBo8iHI6zKcX+aTMnIKl+GKn2eo60mJFCoNmRVGx1uHK0AvL3E41MACf1dmOEE4L+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JCQklG/D+016dQeqWDNDFJ8upw4pb5CR+vFnJ/gxK4=;
 b=N6FhnJyUOq9laA5OLMyfbuSxrN/X5eEgawKx7PeC9QCJWG7UcjTHkvpc++qZ/kGO+ZnaFRIN3wK65wWRPeM7WbGRZSBnzsB58a7XI0BiBRJCBJlRG0UOOUEKPse3JfpEVr/42C543J9gh6k54SNd89QzQpjSSTbHImETd15ywEDZOMB3P9UsaOgBqdUar4XzfyVzAl2giepxwj/E4ekXESUXTgbOq6gxchOr03xoCaHdqFuZm5km5kwFRrcZs06rFLBerxFGI7ZGnXXivuYRlf4gLPtVCL+9B8KwuzAETI2aYcH3MjTQk7Flp60D9kNlEE8mqH895VO7V//9jOR0jg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB9931.namprd02.prod.outlook.com (2603:10b6:610:177::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.9; Wed, 30 Apr
 2025 19:40:38 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 19:40:38 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v2 09/15] vfio: implement unmap all for DMA unmap callbacks
Date: Wed, 30 Apr 2025 20:39:57 +0100
Message-ID: <20250430194003.2793823-10-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430194003.2793823-1-john.levon@nutanix.com>
References: <20250430194003.2793823-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::34) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: db7fd43a-13d9-451c-40b7-08dd881ee22c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sWRo3uvKiveRtE265o8rKjL9ZrWOJ3HJi/4FGjuu2CUMYfCxjuUCNjhYJGQD?=
 =?us-ascii?Q?js+ats5zxsxYu+N1jtVKiuTumnVpN8Eg55/g+pGV487HjJIL06crceMm5PYM?=
 =?us-ascii?Q?N+9/tfAEib1hFILwH0K4ubITP7BfqeOXFRp2iHRPqlpCe27EPKon5fuHLry7?=
 =?us-ascii?Q?bLEDrfai/kY9tDKtDEox5IxjESqARDf2MZiKbn7N0ZI9SKrDMu+YW76nSM4U?=
 =?us-ascii?Q?0oipIGnLeGc9LtcJ2dYl0bqcAETkkmMNjHySeET6e+F6140o31zMZhCTqYS4?=
 =?us-ascii?Q?r/fqLJDzJAaV/o3Y5OYYKNKWX1wzMjPqxTxdl3OKxl2Q6epwxpZr1LEN818o?=
 =?us-ascii?Q?SWPt1jZt8bXHDfLB0BEBNUewAswzqSHCveTQIivxIKaWXvb7lRmzV318l5iE?=
 =?us-ascii?Q?R7gAUGXeYDjfSKpaxnOibQP5k2OwZOej/e0rYaPt5CwwT7Za3qQkjfSdCGhV?=
 =?us-ascii?Q?Q3dli3pB4WOKq4PH+s2NHeUZAwx4oGCODMlPt53I0I7QzGdzLx5WFCZS2aZN?=
 =?us-ascii?Q?jO3V5Kk+JGcbqedRjeDrFDTT3ECS09mb0hOuiwXNXd/+Q5K8MJRyfgMEYWDA?=
 =?us-ascii?Q?xvw5GelF+i0NXhIXKhT0iRPccz3QrYPlrecZMqf6xB0d6X97BAzcxvk6C2Ci?=
 =?us-ascii?Q?p/PNCjC6rIa8T6duNSVzgB2Z1mhoaZp764vJ56udw/ocHcOavUNHKe2M1Exk?=
 =?us-ascii?Q?1uybVOGftb+97iLHE2329tCnucOPKWyZm+eb/UmuvhZTwgWUsdqy1ZPWgdlL?=
 =?us-ascii?Q?tEiivXi3RYNUIZMNiDJfyJhOG9sCYLWEEjBN622lfEF8HJLcFmZVOJEEcUkp?=
 =?us-ascii?Q?1tG4ACeBeUnZmas5Y068mUZuyswbYF8IvNe19sA15dfioVblb7OuccFIbZIo?=
 =?us-ascii?Q?mntU4bDzG13Yihekp9JHzLKvvevXCVD1F3woT11YvJA1OUkD+32kXmCLjpbl?=
 =?us-ascii?Q?DbHGvnPf3FHL8eghJlI6wht4DlQyPotWmIgAIO1sY/mXcLExt5AK51UR5dyF?=
 =?us-ascii?Q?GnLxim/rB0ybK1LYIkF9zbJjtzDQs96p8jsEXZ19RApyzw9UGUWOKzIBjKBy?=
 =?us-ascii?Q?fnAw9rIbIlx9RlBCdecCOuOLOKlCiXBaPwqSe6Ts7PSYvGJNVjPNvYtYjgF6?=
 =?us-ascii?Q?yBwDoHQyZl8Nomxg05YwSjgyIGQJ2lrlbf8C9c8UnvvlUpixFpS9GkxPtvcQ?=
 =?us-ascii?Q?177ZC7V5aG43yRmH3aHdKdgYwvoNDcOVyMyGaGoy40zqxvwvoU4P3vBPah9e?=
 =?us-ascii?Q?NwDVabarP0ilzLet2KaG69dQ1v8ezfbzsCpom0j0VQzdTjcKicYSE4JfcQ27?=
 =?us-ascii?Q?JWuyMlOQ2eVCsqq0fZRILuRDjZ8br64oyaoQYtElgYy1vx297z5MQ07j6Y+A?=
 =?us-ascii?Q?owKqTEdXfhFrNkd1MzqaoSrKvDyG1pXhXrNCAif1BQV3UQdv/ZWFfGzPvvjl?=
 =?us-ascii?Q?IWBXTuyrKcI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S3zD1MxkrEkeNfDqQLR/XaS8r0Pv79gFwHOyTFuboKy5Ii+Prq9+i4avOwaf?=
 =?us-ascii?Q?DcYdjQEd9UuokUZkkmN5eB4QpGbYFqZZdRVC0zJMgUoycuannXub650Rm5IZ?=
 =?us-ascii?Q?JFjhTV4h4fVuQiDRLZmYKtdqngAB2OJNIceF3U5XkXmbwBTvenXEpff6EvbL?=
 =?us-ascii?Q?iQtyacy9W489cFkel55WU3jrdi6Tzc01ZCoTGxAgvtqUnxaxbbVzr9clVHyB?=
 =?us-ascii?Q?K2E4LqwREEH8WxOmz1mxqJb1iA4T8wsZ2YNjflR8kFZ6mqpx9b/6WJ6hXdDq?=
 =?us-ascii?Q?7Mt1D3tv34p2WAkkGFVM28nteA8IQhjrng6pl9QDyW40sd138Sv7vPoyfHL9?=
 =?us-ascii?Q?Ss/qGnbmcofXXH1D795bfoNol0BZTCOmEKPSr3LmpW8TvsxAdsBj6asppAB1?=
 =?us-ascii?Q?oLaOpZJa1aqH2zgTChp/VrlG0/VdiH+kw8imFZz7f3gArDbxnOyuW+5u6Rk8?=
 =?us-ascii?Q?oyWnrxSbnkhCCtfgfcN0s7oR6sU2iEAft13qui+o0tVCr3ScnmB2zif8QeL7?=
 =?us-ascii?Q?YVwrFKU6OslDjph3a37jguIgEgN/jr5/ywWIx60Fl0TgIslu3G4vi9M7ivMv?=
 =?us-ascii?Q?+ZwTfayhnuEgHs5ehezXFwuTgQk3SuU9zwxo4R4lqx8gPxleFqJs3t1UPgZ7?=
 =?us-ascii?Q?tsRtk9WWP5bxRLBJSPn3GbIJDCrN9mciigMeoQ76NsUSX8LfiqqIrxuzPJQv?=
 =?us-ascii?Q?g7Y+O+rEdVNgFl4ufTeVLviQ8amzNk+XlMBoXUgWKB24TlOY4mOk/J5A1NoB?=
 =?us-ascii?Q?4fc9raejiuUyfJkCb6DL6HqbA6v1JrZUvOEnStxUifftaXRVf43tAp33WYHp?=
 =?us-ascii?Q?9SMW58upSIO+ivRRhJYmEERquOQrSTKM+aj+japemhYBkejpdyCfNPu27Fh4?=
 =?us-ascii?Q?j/j/1a6v5RfE4MKiCf2KRiX9Ced2j0b1M18HQWQ8dpZu60hh/g32JZavVrrj?=
 =?us-ascii?Q?4Hz8CYO99Y/6SHkW1mWRa3BjUbCefN2sIiYPMI7KDjOi2vjl2Mgk+QR5lExQ?=
 =?us-ascii?Q?B1/bUS4WB1WzT03JJ3FG3tzIcK2EJXC1D5N8shrAeqyIlB+dB8VAmnLenD6j?=
 =?us-ascii?Q?D0Zi8gAzFblIu70NaM7Uo1rac8cZUjHAJQMCcoCLAdCVFn65RtP/EM8FyRWa?=
 =?us-ascii?Q?F5QmIbJiYU4QhYxLFTL72rUwrPg2T0zDF58EoOJ5yAZzIKPzxSdmViG1uA7y?=
 =?us-ascii?Q?5EOOZgVzHzxvyaV1DqGNWiLza+USropLJVw9+/au/WhkULt0bEAolrtSG2fk?=
 =?us-ascii?Q?oHQoJDeu0U6EUn7OhKVrRIuG56AnQitcs4hcUWAcnM1jrTxgOhcEjNMfq13Q?=
 =?us-ascii?Q?9jebgZDl6/Uq4zahNghXNFMKNEOxJLgpa5bShy9qrqsdKkTMtTQ32JwXGmrT?=
 =?us-ascii?Q?hAKTVnQ70PPvIXFbPVIl9iBjicbaAVbOn7owYFEftqP6UwWZz2af4qw7CaY6?=
 =?us-ascii?Q?nRa94mtHdnacK8TcM/Y2QvtXXnAxHc5+HJ7s+A5y54YvycioCEpqGqljyoMa?=
 =?us-ascii?Q?Kj+Y3b2T+k71Sa0Ieq/ICPIc1dQhxGZF1vaAU8QOas1N743RVq+8Sq64abxt?=
 =?us-ascii?Q?FTUkBXI38HPvqymI6vJRuCNBbz/YKc2dE6v0e9Wt?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7fd43a-13d9-451c-40b7-08dd881ee22c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:40:38.3613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+qRtHyNDCcBoURcElk8zOt4QAMclgIE0KYH6CFAAVZ+0RsLU6Esj9voLMdDM+upVUVeX2sbT87eNWYoeHjzRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9931
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NCBTYWx0ZWRfXyHb/mKHoQ6C4
 u0DXMiqx0qVtJ81VcbK8tH4AGnT46WDWmQuRB3kdaOSZ6mWObpbUpBG5JgHYRptsWqlWzePsvw9
 doK+F1yhjYChD8UcF8OiPsK5y8H0IHCMzVXUuksyeJfdTmu8lwyX+1HExUgfDJ24GuQFyjLXrd4
 2ah98uxqJccbC8QI45pivroaA3+HnC2lYhYrJqF7APHXnTYGycUHdTYjgG5BZeBAhfSPFq2F8wG
 rIru4QSBmGCoV0QY8xkD86YXAnoos/RR+DgVdZuS2FSrUhj0DEGeMxdGovjBDzo0uFISFefgt6V
 Cjn8b0WiHq68C2Mvqi2gjwumQ90z+cdzH6APO5r7nYfoKdROWec8Lxy+XAThHaMePpQiLzBDQMZ
 8JZq6JlJNnMma7pKRFgVRsT+8NR17C/DFm3cSr0H8itciCz3y1oEpaPxA10s2cdZK/ayVJuc
X-Authority-Analysis: v=2.4 cv=MNVgmNZl c=1 sm=1 tr=0 ts=68127cb8 cx=c_pps
 a=Ku5Q1SXtyGRHaGBacwLxwg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=q38O2AW38pV3Lvc8SEkA:9
X-Proofpoint-GUID: hMTCmfnDzfIIGs5xnJHJO2gghMHLBWzl
X-Proofpoint-ORIG-GUID: hMTCmfnDzfIIGs5xnJHJO2gghMHLBWzl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

Handle unmap_all in the DMA unmap handlers rather than in the caller.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/container.c | 45 +++++++++++++++++++++++++++++++++++----------
 hw/vfio/iommufd.c   | 15 ++++++++++++++-
 hw/vfio/listener.c  | 19 ++++++-------------
 3 files changed, 55 insertions(+), 24 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 766ba5a275..1000f3c241 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -119,12 +119,9 @@ unmap_exit:
     return ret;
 }
 
-/*
- * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
- */
-static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
-                                 hwaddr iova, ram_addr_t size,
-                                 IOMMUTLBEntry *iotlb, bool unmap_all)
+static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
+                                     hwaddr iova, ram_addr_t size,
+                                     IOMMUTLBEntry *iotlb)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
@@ -138,10 +135,6 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     int ret;
     Error *local_err = NULL;
 
-    if (unmap_all) {
-        return -ENOTSUP;
-    }
-
     if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
         if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
@@ -185,6 +178,38 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     return 0;
 }
 
+/*
+ * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
+ */
+static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
+                                 hwaddr iova, ram_addr_t size,
+                                 IOMMUTLBEntry *iotlb, bool unmap_all)
+{
+    int ret;
+
+    if (unmap_all) {
+        /* The unmap ioctl doesn't accept a full 64-bit span. */
+        Int128 llsize = int128_rshift(int128_2_64(), 1);
+
+        ret = vfio_legacy_dma_unmap_one(bcontainer, 0, int128_get64(llsize),
+                                        iotlb);
+
+        if (ret == 0) {
+            ret = vfio_legacy_dma_unmap_one(bcontainer, int128_get64(llsize),
+                                            int128_get64(llsize), iotlb);
+        }
+
+    } else {
+        ret = vfio_legacy_dma_unmap_one(bcontainer, iova, size, iotlb);
+    }
+
+    if (ret != 0) {
+        return -errno;
+    }
+
+    return 0;
+}
+
 static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                                ram_addr_t size, void *vaddr, bool readonly)
 {
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 6b2764c044..af1c7ab10a 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -51,8 +51,21 @@ static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
     const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
 
+    /* unmap in halves */
     if (unmap_all) {
-        return -ENOTSUP;
+        Int128 llsize = int128_rshift(int128_2_64(), 1);
+        int ret;
+
+        ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
+                                        0, int128_get64(llsize));
+
+        if (ret == 0) {
+            ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
+                                            int128_get64(llsize),
+                                            int128_get64(llsize));
+        }
+
+        return ret;
     }
 
     /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index c5183700db..e7ade7d62e 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -634,21 +634,14 @@ static void vfio_listener_region_del(MemoryListener *listener,
     }
 
     if (try_unmap) {
+        bool unmap_all = false;
+
         if (int128_eq(llsize, int128_2_64())) {
-            /* The unmap ioctl doesn't accept a full 64-bit span. */
-            llsize = int128_rshift(llsize, 1);
-            ret = vfio_container_dma_unmap(bcontainer, iova,
-                                           int128_get64(llsize), NULL, false);
-            if (ret) {
-                error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
-                             "0x%"HWADDR_PRIx") = %d (%s)",
-                             bcontainer, iova, int128_get64(llsize), ret,
-                             strerror(-ret));
-            }
-            iova += int128_get64(llsize);
+            unmap_all = true;
+            llsize = int128_zero();
         }
-        ret = vfio_container_dma_unmap(bcontainer, iova,
-                                       int128_get64(llsize), NULL, false);
+        ret = vfio_container_dma_unmap(bcontainer, iova, int128_get64(llsize),
+                                       NULL, unmap_all);
         if (ret) {
             error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
-- 
2.43.0


