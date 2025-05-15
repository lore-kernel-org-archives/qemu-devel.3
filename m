Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CC9C54754
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFamE-0007uS-8O; Thu, 15 May 2025 11:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalR-0006BU-Nf
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:44:57 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalK-0006Cy-KF
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:44:53 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F8GHec021276;
 Thu, 15 May 2025 08:44:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=OS8ZnygR5pimSkeXzbjaJPNutuK4XK95fbT4iYYxK
 bc=; b=2zygQpkyk2P0nfcdMx6oJO7Lcrfr4JyvtHUOfinPFL4w15YmvxMscFO1H
 9mqJ5UETx7PQMspX0Gj92kHMYR0ke5pAq9DJZ6rrk6/VbMiDimvHHtA/sssh4jzu
 S8OzAcE9+hxKjwaEPR5SkM/d6Y6ZBxmZtMB10m9NDfhcGHYOhjzicj9kcftDhHcQ
 JZx//O/Mf5XziZ4WEa7hs8KrHJB6qfCJCh9PnEKrwwOxnepJcjZacxOPh+BZS7Xx
 3E1l4PCm0EZr+6APi1TOiQ3P/WAUVRarL94V/vbh7l2Gplgsk9I/7r6q/WFOdawS
 YEEW+LLsFiwBIECf8+g5yf2Fm0rkA==
Received: from sj2pr03cu002.outbound.protection.outlook.com
 (mail-westusazlp17013076.outbound.protection.outlook.com [40.93.1.76])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46mbctngvk-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:44:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsvtgN52dbUk9O8BlyRYomtn99r04u5vpNycEPNIiWWTMyllRj2DYmoFYRhLz2C+F3PHAuJZrzelQZyVCimwXw9wIWORo/BuOZ1KPAa+H4cBgeiNzg7mx9nB5gmIoFlz4HOJORQV8YAKYyJjmJM0Va7Ep7G/gmj8V+wGHlofGgHRuAbSVYhMjqplowrqIYYNor2ok2RUQx321IbKbQkGJaGwJVgLyXKstdu4ujjMm35kuUYNqusbR9V5Z7gZkxNvp8RcHvVNYQ96J7YjCUDApWYupJMgQf5Vf6pl/bOXiyspFgaL7JZR7zT1iYpeTz7iv1snbXI2u9dTxlTz2eKM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OS8ZnygR5pimSkeXzbjaJPNutuK4XK95fbT4iYYxKbc=;
 b=OsnVKGO1gNYvk08UZgCujjDNZnj41gHh9cl7e3TFtYlBwc9JfWrjTLHEm267HmdzV60qCb1Wvtqt15O10o6LibnxGkAjpOWZpuFTePEv0br/5lb1lvfZ8b7453YHYtCQ17EejRLG/yU2Cn77Guy+xMkBLAxg57bMyRPgudjg6wV7R3PcGVBEqPEUwIDan6uE/TGsXoARyu2YHsdtkJq573QEPTM0AWF78NVVs5TGVdVCjrIMVWdkW/kflK/HDBCrtG3jcLxojH6Vza8NC/4adcWJVPUY6UIGuUPC3rhPBb2PQY+FZUuXyrT5zyGsTxMJN/LG1VSywmd5oIYf0zKt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OS8ZnygR5pimSkeXzbjaJPNutuK4XK95fbT4iYYxKbc=;
 b=smZtF62NlaZ7J8XneEmi9dzN8F9LNWhXbRS51kbAhPz4h9wmP0xqD1zyF4TgBga5QNcPiGqtUoGriqlm6prd/Lr5uDzXqXlClFuLQ4av9lVrN6nfLVHNvxLTb9vFOoag+M1VPig1Gvifu4DCGbEN+AsxgmPv1NdcEYRwvqwrTlfcKPELu7YrURF8bFQ2OFd8jIVd6C6yE9VihXCmJ1vBxS2cexvrSvdF3hTOu0xqfYKBW4Vij3H45cu0mhGeUqemP7jRl947nBH2EaHaFPpaIGZjjl1SeHJHpOzVJ3i8kAgiPxjHEG0CXqxjNMqUq1VMB4wxfJxUFbKLyHRNBx7P4A==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8470.namprd02.prod.outlook.com (2603:10b6:510:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.17; Thu, 15 May
 2025 15:44:38 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:44:38 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 08/27] vfio: mark posted writes in region write callbacks
Date: Thu, 15 May 2025 16:43:53 +0100
Message-ID: <20250515154413.210315-9-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515154413.210315-1-john.levon@nutanix.com>
References: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: c2992ca3-1b13-4dba-7789-08dd93c76692
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZLRMDBKI8bW2ij0Yo25LmacaCR1MhzCR+Lb0GySWMUZNqQ0oJc789FZSA76C?=
 =?us-ascii?Q?kDbTXtQ3fEKyxqVLnmn9vxJlcgZKm1dAP4R2QIvMBtHVXAnEQLgXAqc1AGPY?=
 =?us-ascii?Q?tOwWd6tFn4UcBLJgrIGhJvZfWs1QMIEQxrkvf/mZ+NNLz0wB7XKyJDcjBPm8?=
 =?us-ascii?Q?hPNRmdWe3+2AN8l8TjHQFjyeLqYNRd+mUxwy4ajHwtRFk9tp8jIBNHVQ2E1T?=
 =?us-ascii?Q?Y8ZhbLDlHEdNpPMLffCwbuoXab3cB9FVJFBuwNL1nKFFJfM1WmHNdHWtBQYx?=
 =?us-ascii?Q?d3DZQPPPsbJTDnC/Dn8Vu94yshz3Kwn2JDtC0/UCR0F78HDInJ8mKUZGEc5L?=
 =?us-ascii?Q?57GcC+hu3BR8rQ+2Fi/Z8q81/y4gSR0z5sTIwpsCwjETUEMRu1WrZruHgFwW?=
 =?us-ascii?Q?PkltEpGM8AePxMuQ9OwDZfEZ9sgGRR79cRvokUkrYZhsNWyDJDldo7j6w8O6?=
 =?us-ascii?Q?NBGya/M92qU5MlphN72ue6SWx4mSmSbMqDQAPHebJEBvBEw+F8gpYvlyOTtk?=
 =?us-ascii?Q?lH6Cwfh7ToUzArtLV/OF7rIgMSE5jzr4UIuttei3FusYYGhQKHujb6VtdHjz?=
 =?us-ascii?Q?ENF8YZcHEBU6QeIB0KM0Lo/Gx7BFgVpg7QmNdTwMf9xEwykf4WGPi/bTQ1BR?=
 =?us-ascii?Q?qw8O5q0TnroQ4819/DVfCIEiBpnPfMRonYriEkP+7asM+OXV6g653yG4DBIa?=
 =?us-ascii?Q?riYaam6kwjKAbYHWChTocZLu8R8B5Zt8YZCd/Jz1VpuorDhgfuf7Kd4gt6fk?=
 =?us-ascii?Q?tgTogw02IID5UYQYpcisjcIYvBa2jxgRFq/2f2WVtpyhYJ9o6DH7oi6F/oIU?=
 =?us-ascii?Q?yaw+CwI0HvJWg1UqRNNz7VJI7xgCutz9na6zv4ZrD5aERMWb2dv6M4WKmiAr?=
 =?us-ascii?Q?JnJyrG8NdY0I4Jso9M0DPi2nHYEsYR+T8iznWgMtH6to3K35LagvhuBnS3OK?=
 =?us-ascii?Q?ZBPOWjDhlHq4lzXa7gt68bnm/Vo87NQBctRM5FGlGmbJdzJ51a3CJ4BqPLjQ?=
 =?us-ascii?Q?1jXnLG7ooY0FmsYCOa8JUfv8P8HqU1P1wQakhd30ujBgec5QOn/ojRJ4jhFD?=
 =?us-ascii?Q?/PrZHvTxy5QYDuPPEdG5CKiWEDZntUvGfs6v//nHh0EVIAQt/DnrRDO8G0Af?=
 =?us-ascii?Q?VS5VfVsMl95jWUhDTWIIEYJKKhrCURcM2PozIXQqk6o2jCQJD+gcRUH9XK5q?=
 =?us-ascii?Q?STtFRh+vdx+RfcMs6xQDUK1INA69TRwZ4EZZIuUXDEFFD96/jbuCYmFJRV33?=
 =?us-ascii?Q?RP4ZFP/KCUYbtJJpUsLdvyYN5hu8UYADim7OEfAQuTh0FvkHNiORvh7EzsMw?=
 =?us-ascii?Q?xnfuzfleEe7xTXrowC8YTcsC+fW8xC2Z1J0IpRWklLULS8IpxOFxdMYQRjJA?=
 =?us-ascii?Q?HC3OzcxkWU/nzm1LfZNDH2LaXjfASr0UWvmaZ09yTBFCQgM8+QE8Ajcu6hX9?=
 =?us-ascii?Q?YylxjE1tR9M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tp3989fXdFIkSpC8xXOHv9jq9CXDE0xZwq2iN+t/jRhLddh4KKnwFJfCz+/s?=
 =?us-ascii?Q?K/52Qrrv3jmFkFQkzK7ewAtCuu1Q7v3s+SoME320OJZFHr5xhKnVvRwP+5/7?=
 =?us-ascii?Q?gKHbUlYuF4sYyrNtZi/Tshjne/q82sZBNsuttOQWwqo+Xf6HSsDlJMRzRjI7?=
 =?us-ascii?Q?xd3+LiqBavVEZYPXSflot12RVb+V//UHCkMKLQHU4VTJTCHOuqDFadQ8f/bb?=
 =?us-ascii?Q?lgAoTJTk86h0meSD21soCxxjMnGbkjvdGvBbuIxaanavSGqp0D7fc8R9YgRw?=
 =?us-ascii?Q?0KN34KBGy3nbAFFna6PraxNtuoiKxGeK5cjNdZKq5mpBTZ4Y61HShs4HZYqz?=
 =?us-ascii?Q?LyBFFTj6q9DDJi1/Y611D3rcumJwv1+fwcwxdnJJiw94a2KUyssCkWng2UMH?=
 =?us-ascii?Q?5ZRrd4At+lqndOa0DFCjDAX6Rf5tHifQEaTAWyP3u3/pkq69IO2gFgUsXxRr?=
 =?us-ascii?Q?kcVQxzZva6e2ltljMPqxyqxw+qW4xbL0EIk7jYhHCXvu2oAjDqybmxlAxHoa?=
 =?us-ascii?Q?bbx3rt1fkGhZp5P/eumqZRZmpMiETN1852tF1K6kaDjTpB3AtXnfev7k0rt7?=
 =?us-ascii?Q?AcVgt5ptV/p4k4REdDp8b0yuEe0+SD9TdspGN8C+3Tek6FEZhvveAQy4frTE?=
 =?us-ascii?Q?ApGXYHj13F4iGgkjQbYle/y7cVvpNmvYhUOpyV7RdTDnabsXR0WewAcr+BjN?=
 =?us-ascii?Q?wFiHQMHnxdQQJVJQD0ILwseh+nDH8ikbc7Kwhq+PaTgaEkEPKn8D9o+y78HS?=
 =?us-ascii?Q?FL7sRZwpv2A9XKMj2D1vemNMTd6O2bwgZVt0P06/viNedfzIWxJelzwlvTeY?=
 =?us-ascii?Q?O/wXKLBLHToqqUcfBoAr2XYf6carev4ecSH5S4PJ1GfHXLX3cMuqDx+jSty8?=
 =?us-ascii?Q?ti1CRlQ4lGd85kr5p7EmRw6zdPNYNpIHUYc4DALrJ+RuFRRsKRoHqxpBhAdQ?=
 =?us-ascii?Q?y6BgZkSd7pGdc3Y+KSXCyz3EkNg6mSVrzBMPZVi+RyMSSRC+IMFceqVzXXYU?=
 =?us-ascii?Q?97sv4LBMasPKQB1AUDtvY1/WXIaN8mJxW46dYahhR+2SyRfFMVNZpzzJ7E7d?=
 =?us-ascii?Q?SAj8XtdQqQvGvrgx8QO5zBA9O7VxX3f5aQekFNFbSYB25W2RO4ivfQ090bcV?=
 =?us-ascii?Q?ZAZCXhNDBMJ1D1A0Qnw41vprumEIUu7wuLibaXrRbw+T8Yh8TDYtHY0bJyzd?=
 =?us-ascii?Q?4l9xSAySX3yWy2nse9inqvEkKSgnai1sCxsr8OkQXZJo4doO6FaUhGXJHK5l?=
 =?us-ascii?Q?3G4a8uK+VDLQOLp5PVqhGsPA7J/HV/RbbfsZ2uM9iQDgmGcNPUuYvt2+7unY?=
 =?us-ascii?Q?tVTJOdsw3jjqsRpY5Lf744UOYh35lCPGfNq54cOLQf4B0UpdSSn5AlD4khrG?=
 =?us-ascii?Q?yjR8G+zxGIeirCEUuRIPgmifrt2VgERbkoUiL+CeWPJGkirYnPcoDL/KnnbI?=
 =?us-ascii?Q?UNHH+USQF4zOi1tlqBLnSuizz8A+DQI0IHIHBepG9MTPDCihGSzG2qxD2j/J?=
 =?us-ascii?Q?tZ/PVJhGfl/91m3PcfwjPTyatqwAL9KfJ3gA46ts6QtO9ZOtkxLzFKEhoWBJ?=
 =?us-ascii?Q?X+wuz4bltit/razCbFVheH513tZ89hdzQ3RQl1f1?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2992ca3-1b13-4dba-7789-08dd93c76692
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:44:38.6673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UylL+ZxVy5DXyR0TLHeLPGobdHtVTTZwASmKHVn26qIfPhZO2LZjrNAqLjXMLV3J97H/kkWa1iMgKfR1d50+Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8470
X-Authority-Analysis: v=2.4 cv=euLfzppX c=1 sm=1 tr=0 ts=68260bea cx=c_pps
 a=OVSnam+0waiSP26xbJD4Ig==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=AhJUW1JONd81xBax9acA:9
X-Proofpoint-ORIG-GUID: PGkq8FSZ5k8r-_KStmJ1ei6ERBxb8phh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfX6QJCGLGIV6NS
 Ns8TuybgwKJFmaIj4mKE8Xr4meiAuyZMyf8IgKUHp0ZNkKEX54ejAgdoWGOKkiRPwjJKlxmOUrd
 rCSUNGLUIayr0E0UsljUv8L9qAHODBQeXd0TddREUfj8Od7lg676iiNW+D2izS605WHdSkro82x
 UuDox/KKWa2iDPCitax6VdSMGy2IBbmUmUM6r4xnTOWTFEjPH+NxTp5kGXC+2XlPJBCVXqt2nFH
 uRysrsZ8EWDNrowDOdl/J9HfACH41dsigWhAIRm4v8S0F+86qWNzbGFR3WuC7mHwJ9uPpdZX1/x
 LklqMXYqkLzrgnOWro/enmtflxpPmcKq5yuuv9DJQsoGR3Hd/TuPyZmin5BRvos4mMQp+xU8yuh
 bTne3X22pNFSp6x2BaJs8XHq1WaOJLxApVK6xS6qVg0pqK2tdCnBMZZz5wR3eirO+YNW4Hx1
X-Proofpoint-GUID: PGkq8FSZ5k8r-_KStmJ1ei6ERBxb8phh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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
index 3f5b296523..84daac5f2b 100644
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


