Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6F2C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCgaV-00052p-DR; Wed, 07 May 2025 11:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgaJ-0004ur-6g; Wed, 07 May 2025 11:21:24 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgaF-0005vH-Jw; Wed, 07 May 2025 11:21:21 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5478Rjo1015395;
 Wed, 7 May 2025 08:21:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ZYJUL5i1DNOnkIv5melLYgSYxp4MJ6kiuTupsBv6q
 iM=; b=HAz9NB1NpoXJunQ/dVtFQR2UhAN66f9T8uWZ+rmwP8LF48K2a74omSYJC
 uzewc9FEyGNsojvuRRszBiIZCYqXJNPefb5opXEbVqq1r6+3djlxLgD+dCbbAa5T
 jWdWV1Mkqf+DQ+7O/mZrLQn2I2faL4oD2706u+vPwbr9d40BKBHApGlUVqfHE5ME
 NQgcdr+1zF63IUptKknHr7OG9fwxguIXBKQ0DLAkp0lwhl00I+wVebqKYWyVQ58y
 CRISbVNO5nBYE6j2l4UephRXNX30NYzHr3pqvUJ8fav/YNogfBBsmQ3Jp3jxKYSb
 gxXitcDgMYiIUI9avJ9I7fJsKmi8w==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010018.outbound.protection.outlook.com [40.93.12.18])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46dh8j1c9r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 08:21:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xc8RAoNB1hWgmIt8CkY+Ewk1WDj7Uwr2qvaE7QWBD7BS0tsySadWhMVYrZjqa0Xb+4N71oHzzVaTFV0op23husjMbs3M7ZQV7gZb7MAiVUck8ElUxvFVVEJlcksXo28WEBetWgMVwgXJZiPJa6lPGpACoi2I6dMzL5bdbFncsf1aC7v3E+z+15ZMsdvbnoqc8caCxf+KMLwHSeAL/u1LA3vZTrijzyJ9W3I8YCo7wJjIu2AH2EiUtucYIFCgIhCiOT6zZPeCG4RwY4NLS+nOJcRehg536w8k2Wc6tBtA67PR07XIMVRj0BhcpPq8EX18mHZh9Xt9tBlzWmiQLFWB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYJUL5i1DNOnkIv5melLYgSYxp4MJ6kiuTupsBv6qiM=;
 b=BNLQzNj6vRdcUC5N5N59djZe8xHVrKQRZjFEKgT82gb9tFSUW/ixXFwtta1HvzVuuuYd/qAHy6qiIK4j5ktcKt7D6RNIbtOuxSXEg2Dgav8PilKA7t8snudJWAZ2YLyNL4hAQYpSvq/YQSjSdaCE3O6gcniI1cvYdQYi3ZPNRez++7CKGVu4b70lJqiYFnkjRrZyHxHz2Cv1JIc6Z69BYCf0u/dmThDKTfGP0+xG+ODSCat7bKC1m8k220POmhvyPev2FczM4I/W4kMxTaDtaUD47wQwQtH3Ii7Yx2XOYS9eyoMBSEkL0a+3it3Kci9bYd1/dmkRnCeNgGw2RNDnNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYJUL5i1DNOnkIv5melLYgSYxp4MJ6kiuTupsBv6qiM=;
 b=mEwS95DrgWh7x04VvYZgE5ATmgiPwaoGtzWniHhQiDTKK334PZJVqXQn6jqddYCKGAVuqVQrIQwPWwNv56oXmnI42q+6+HcXYXtY0Sp/n+aC+k1Et6jEZEW+uyqu3MVw+53LluLj1F8sAN1gEhNeyOwXHpKkvcKnGz5Wf2HK6FMK6NxFukCKEu6jcjIFT2K22GznrlSnR6G5ORhlXag3rMHHtxIdJcJurN5EEc5MObkl43+K25eBlgboQfRAcpgC857EndpWlOmKVtkjaDmq+3xU/YQp3Jm4892BKNsoT2Id+poqzWdnT6tbWcrr4jlEIWdYWRFktNosUk2zMtQXmA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BL3PR02MB8220.namprd02.prod.outlook.com (2603:10b6:208:342::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.17; Wed, 7 May
 2025 15:21:11 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%5]) with mapi id 15.20.8722.011; Wed, 7 May 2025
 15:21:11 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Tomita Moeko <tomitamoeko@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>, John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v3 15/15] vfio/container: pass MemoryRegion to DMA operations
Date: Wed,  7 May 2025 16:20:20 +0100
Message-ID: <20250507152020.1254632-16-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507152020.1254632-1-john.levon@nutanix.com>
References: <20250507152020.1254632-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0055.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::22) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BL3PR02MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0a100c-b091-47fd-a98d-08dd8d7acc86
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tDxEq2RBGTv8FQFso2Iy9mn7JUtaT+DGE5o6pYA1TCb+DfK1LZn9aR/bVUWd?=
 =?us-ascii?Q?le91iBTkDHayGjkbO5T9DpXkBqTDp741rmvc0pCnCikvI8CNG1rNLre/m4ev?=
 =?us-ascii?Q?9XV+bRImSKZqAEsxrhgUzQYf6C65l4wKmCZvCAtuH/OAcHOcQeddRJu0HKd4?=
 =?us-ascii?Q?/eNWtg503iOmgBDWvKMMgOU8OKo/EuZxeTRZlg5O+n578RbP9mlAu0G3UkHc?=
 =?us-ascii?Q?H/8uIxSG5UkFWMuxPof3WWAqpfYN0FhWhNTpPbl1xNs8TdkFW5RLIbRfaK8J?=
 =?us-ascii?Q?j1ElQqcvjErz0WquqkuNCFnxQxaWmL90urhNDTRHcIXIPihDtKLbuPd3V4ep?=
 =?us-ascii?Q?U7hJBccutwFFlt64XVrVF7ZMnff5GR/X0OlsOae549xkJEWjPVkL8wCmfPkG?=
 =?us-ascii?Q?A8ftf4z/ZRBc5wnCGwGxQHLBZkuAB/N1L3L57URd498QCkOu4eEp1md+LSwN?=
 =?us-ascii?Q?1AXZ4joHFqteVkh4D3oINotnxheNPM+ZfSAYKKvlk65CPY+iBO6NR8pKJ+Vn?=
 =?us-ascii?Q?c84rWw+EBNUa9G3zx1EGfqHcgYy0K1MaWBtMw+QFzWkz4fmjEVV97dAfwNv0?=
 =?us-ascii?Q?/gjzjE9cJ83mBhFXgKBZG6iAh4jlIw/ktqJtVMXdLge6cWS7CKSev1yttHXQ?=
 =?us-ascii?Q?YKP7yYsWHWLqZDjyrMOPAj8LhSLhwX/2j3vE2BQ6UYy1JDesUSBPIJHZoRcN?=
 =?us-ascii?Q?5yWTWjskH76zbPXkLdo+WgP260aR4Vq+r6CSJThFos2rV4oGphSM/GanBxJ9?=
 =?us-ascii?Q?HQMvY98mR5e/MbeG2Fqk0SEF5rVQYrbIQ/5tKKCrDevHbNolJHa53p2R2q9J?=
 =?us-ascii?Q?6wwBbydJGBzuucQDjgFGRAFs6X85nRCqNNYg7XuChEWR4OACh4btoD9z4RAS?=
 =?us-ascii?Q?xW0eZik43McsRoIqeIezsZ282wKoJHPVsgGYPbOWT9dCoqitXk5rYeiV7k24?=
 =?us-ascii?Q?WJY4ogESJUsZ0ifhzjD3+s2MCNT1i+kvS2gA6djqIKNF+fwMuBj2ER8WH8ez?=
 =?us-ascii?Q?fMmS0saMRtz/e1Nhz7HkhwUhitxWEWUcJ7pUseF36Pa9qkHmexUQZxxYWZ2p?=
 =?us-ascii?Q?5ljY7L+rX0LRG2snxr7sHAl/05bQfHGOE+o0/ZvRd999PULOYfp8mVDzizPG?=
 =?us-ascii?Q?Qh0VM59e3MKvFJvEeXF5QNn03ZHBnlROcUX/egxegQiEdgAdWCY5hln1q1FO?=
 =?us-ascii?Q?w3usdFbXkDW55Lwb8xuMLMw1VzdEgnj76TKEeeneIHh/Q9WUtVUBJp/jB2Ul?=
 =?us-ascii?Q?Sb2o5BftuOLKxmUiR9mOco39CiLZ0UbK0eArUsR3E2wGWxLzcueIu6ut2zfK?=
 =?us-ascii?Q?JaQcZyvBs71NzMrIqNwSCVFozztYJewEt2pgyrqiHSiZstn1y0Hq95NS7vPK?=
 =?us-ascii?Q?KcTiTJaYEq4u1kb8qK8GosDhnKwyOIN6Ofh+5s2GxOx6SXvpTbfaWJy1Y+Qx?=
 =?us-ascii?Q?2Lv5Knq0gAg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J5lvFmQ8JbyZzHLX8VjE/5hI6vVIo6J20WHglppnX8EANjFkcgHVdYOQ3w6Y?=
 =?us-ascii?Q?2OO7g9VR2jrIrbg41NiDiKajvmAYyYJItsX89qFPSLs92LK6J3Af45He+MuC?=
 =?us-ascii?Q?mPc1js+Gy7SkfVlsHvIXQ5iOF/gdAl182maOC7olK7+zIDvF0cLuB55vZ4U3?=
 =?us-ascii?Q?Vwp3Q4A6W7BRFYg2TSbSYBUdXQx8QaqjUUck06eIVYP2zjZuUq52WMxtxPlF?=
 =?us-ascii?Q?Q5UTL59a/WbBid6XIP6d4VVxk1yfKVjVys814fMC2yuKm31RoMD7tnhKl2aw?=
 =?us-ascii?Q?TGaiU3FrghPi2K5xaDNvIGpeNxnSA9EadoKUtVyWBYRE7RojOIi/6RTzYYGE?=
 =?us-ascii?Q?S6+YpRE9sdsiLTde/SRbYZaneWXd4mYF6ni0SlTnKm9LOs6OTlF2vlKeIep8?=
 =?us-ascii?Q?HtLXpmYb2+J3PXSOMg0OvhS8wkMyHzMUL2zJmRr1JU0qq0o05A8pJlx5CLP6?=
 =?us-ascii?Q?4tUEzFVJk+U8GJy7J38jBZlemjpXGw5/1rzKELsMNShyNGO2jeT8/O8vGaVe?=
 =?us-ascii?Q?KK3pEyQt9No++ACVtk6C0CU9VDG7+2kOKecKM7/wyCWeWiETc/OSDTYC3lgq?=
 =?us-ascii?Q?Ed1Z7FVKfQZW5xgSwG+/ydsr0LrulBctOCxpeJjOtbdCHWaFC7p+AhaWGjdW?=
 =?us-ascii?Q?FQ3qmpvjrtwg/TC4QTYEvfYJfoO+s9753sBnqvWbKOqawgMiiQNXOSR2211A?=
 =?us-ascii?Q?x7jYc47qxFh1KTikuMSq3hghVG1E2psqUOKp0mXr6N5BFctNRcycZuonEGsY?=
 =?us-ascii?Q?At1kOCD60M2VWPL7bDTgC6LJzDLxf1iDXjpAL92JrgMs9vIuhR2Yw+1TYBhH?=
 =?us-ascii?Q?m1tkN+2hF8r5uZFbCmG8RKrWbSPk0SK2Ueited0Eg7HKUA8DsvSyA1p8A1ut?=
 =?us-ascii?Q?gRN2iSm8bDh4kNiuBdkaL8PiCGS2IP6zPiV7p5aN5C45vBeJSET+AcRtZ46g?=
 =?us-ascii?Q?39dcW7RvIqkKUDuhy1gYe/CksHSQgfXki6CffiTjwitpGygY6XukhahouX5a?=
 =?us-ascii?Q?0L/548JMl40K4q2eYtxxIYxwtP1CaOlDvlpT7CjMRZZtkWtdkWZo6WIwXvMI?=
 =?us-ascii?Q?742fvyr6X3zwoUHDFOThut3nxCKk2QdTbAWvjHILb8Crgfm/ZkHfVGTE85eO?=
 =?us-ascii?Q?Kg7nMobPkttrNJ4SViXEssCdrbAzlGNY4Z9ukIneU5x/KSlcXYDxPTres+E8?=
 =?us-ascii?Q?KFy55BWxRWKWtRMwuVguq+QNavZm+khe7AOvXOS6YRtKmJ0pteyJxVDDWYhL?=
 =?us-ascii?Q?3iIR1Qk3AI7Y7kecVHc06DkcGcNCgxeCmeEC0io7rS0sYmeToxMOS4G+aIBe?=
 =?us-ascii?Q?AnceGiauh3Ob6+i+1IKelLJ7AClmvbLLIqhKeaqDxmsjK+YTqNS2NVcqfSiz?=
 =?us-ascii?Q?BhKelN87KLwtCM5Fu0TYDYjVmujmORlUxWUITDwWHLsSYijDxQuUGDH5Cps9?=
 =?us-ascii?Q?5SH3Oh8OagT8Q6+cmGUw+F6xaYV1UN4ziP0d2WKXbjmJgEAtZQgGxon2qUTE?=
 =?us-ascii?Q?ilXu71EetzFnR4GmGXZmSubBXiJieoerCn2TLj6QYZJCB2nJfKg236gT9Juf?=
 =?us-ascii?Q?XrhBa4uFSl4qN6T6W63hxR9BenGH9pxa4O2N+LL3?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0a100c-b091-47fd-a98d-08dd8d7acc86
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:21:11.5067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ak8SpGmSY6wQ+3sW32jyQQLkx20FNeHqCG53whpOjasAXnunEKe2IEKf+F6MvpRKAeIpiCV6aMXhhJHElvySLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8220
X-Authority-Analysis: v=2.4 cv=B/y50PtM c=1 sm=1 tr=0 ts=681b7a6c cx=c_pps
 a=iOysuCQqHAn0ffzU2nlaNQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=xgrxZqKpKNu6QxwLMNwA:9
X-Proofpoint-ORIG-GUID: gPSHLJkn4GTCAISvEPLpnsnbh7VwtXFi
X-Proofpoint-GUID: gPSHLJkn4GTCAISvEPLpnsnbh7VwtXFi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE0NCBTYWx0ZWRfXxZl4v+FhChES
 rXD1kdmN6Pq4YtYeA12JOr63/EnfxLXaH/7vBnjqF91/T2ukf5BlzLvMzlLpzxOErS9ZzFzSjf7
 nFECj2MQ9muuzqGH1rbwX6Jm/zVYA5gXMZ3LnVVOvMEXsrqGvXikzxpEmFIj9fyxnmMb3z5VNK1
 8StGzMn4l/LJukSuKYVq0bGJkX5uJNgJVJL5Bbgq+A2VHdfkuipkwNXNPdsaCZKlQxSXUvAPi+X
 MypC/gMqXoQoUjBl3TA1981vD5W6yqmwDnWz7JEnq9LnNX3FcGkxzE2Tvr8T87CTwaIlaH3Z1gU
 rNKhMVIIm7Z3uOFE+HkXrMMfJCo/ZlSifwW1S3jCNE35Xmp7w6DcDTLwkoDHtylLE5X9eaNKD8b
 qp3xTxaub/t9lvSmznq/6IRVAltDYwsyTBypuzMIWdhPpUUtTp0IX5UQ2QQiyEtuqNmm4DM4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_05,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

Pass through the MemoryRegion to DMA operation handlers of vfio
containers. The vfio-user container will need this later.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 include/hw/vfio/vfio-container-base.h |  4 ++--
 include/system/memory.h               |  4 +++-
 hw/vfio/container-base.c              |  4 ++--
 hw/vfio/container.c                   |  3 ++-
 hw/vfio/iommufd.c                     |  3 ++-
 hw/vfio/listener.c                    | 18 +++++++++++-------
 hw/virtio/vhost-vdpa.c                |  2 +-
 system/memory.c                       |  7 ++++++-
 8 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 3d392b0fd8..359b483963 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -78,7 +78,7 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
 
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
-                           void *vaddr, bool readonly);
+                           void *vaddr, bool readonly, MemoryRegion *mrp);
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
                              IOMMUTLBEntry *iotlb, bool unmap_all);
@@ -121,7 +121,7 @@ struct VFIOIOMMUClass {
     void (*listener_commit)(VFIOContainerBase *bcontainer);
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
-                   void *vaddr, bool readonly);
+                   void *vaddr, bool readonly, MemoryRegion *mrp);
     /**
      * @dma_unmap
      *
diff --git a/include/system/memory.h b/include/system/memory.h
index fbbf4cf911..eca1d9f32e 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -746,13 +746,15 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
  * @read_only: indicates if writes are allowed
  * @mr_has_discard_manager: indicates memory is controlled by a
  *                          RamDiscardManager
+ * @mrp: if non-NULL, fill in with MemoryRegion
  * @errp: pointer to Error*, to store an error if it happens.
  *
  * Return: true on success, else false setting @errp with error.
  */
 bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
                           ram_addr_t *ram_addr, bool *read_only,
-                          bool *mr_has_discard_manager, Error **errp);
+                          bool *mr_has_discard_manager, MemoryRegion **mrp,
+                          Error **errp);
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
 typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 1c6ca94b60..a677bb6694 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -75,12 +75,12 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
 
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
-                           void *vaddr, bool readonly)
+                           void *vaddr, bool readonly, MemoryRegion *mrp)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
     g_assert(vioc->dma_map);
-    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
+    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly, mrp);
 }
 
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index a9f0dbaec4..98d6b9f90c 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -207,7 +207,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
 }
 
 static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
-                               ram_addr_t size, void *vaddr, bool readonly)
+                               ram_addr_t size, void *vaddr, bool readonly,
+                               MemoryRegion *mrp)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index af1c7ab10a..a2518c4a5d 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -34,7 +34,8 @@
             TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
-                            ram_addr_t size, void *vaddr, bool readonly)
+                            ram_addr_t size, void *vaddr, bool readonly,
+                            MemoryRegion *mrp)
 {
     const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index bfacb3d8d9..71f336a31c 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -93,12 +93,12 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
 /* Called with rcu_read_lock held.  */
 static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
                                ram_addr_t *ram_addr, bool *read_only,
-                               Error **errp)
+                               MemoryRegion **mrp, Error **errp)
 {
     bool ret, mr_has_discard_manager;
 
     ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
-                               &mr_has_discard_manager, errp);
+                               &mr_has_discard_manager, mrp, errp);
     if (ret && mr_has_discard_manager) {
         /*
          * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
@@ -126,6 +126,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
     VFIOContainerBase *bcontainer = giommu->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
+    MemoryRegion *mrp;
     void *vaddr;
     int ret;
     Error *local_err = NULL;
@@ -150,7 +151,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
         bool read_only;
 
-        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
+        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &mrp,
+                                &local_err)) {
             error_report_err(local_err);
             goto out;
         }
@@ -163,7 +165,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
          */
         ret = vfio_container_dma_map(bcontainer, iova,
                                      iotlb->addr_mask + 1, vaddr,
-                                     read_only);
+                                     read_only, mrp);
         if (ret) {
             error_report("vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx", %p) = %d (%s)",
@@ -233,7 +235,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
         vaddr = memory_region_get_ram_ptr(section->mr) + start;
 
         ret = vfio_container_dma_map(bcontainer, iova, next - start,
-                                     vaddr, section->readonly);
+                                     vaddr, section->readonly, section->mr);
         if (ret) {
             /* Rollback */
             vfio_ram_discard_notify_discard(rdl, section);
@@ -557,7 +559,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
     }
 
     ret = vfio_container_dma_map(bcontainer, iova, int128_get64(llsize),
-                                 vaddr, section->readonly);
+                                 vaddr, section->readonly, section->mr);
     if (ret) {
         error_setg(&err, "vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                    "0x%"HWADDR_PRIx", %p) = %d (%s)",
@@ -1021,7 +1023,9 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     }
 
     rcu_read_lock();
-    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
+    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, NULL,
+                            &local_err)) {
+        error_report_err(local_err);
         goto out_unlock;
     }
 
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 1ab2c11fa8..4c4b3d1371 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -228,7 +228,7 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
         bool read_only;
 
-        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
+        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL, NULL,
                                   &local_err)) {
             error_report_err(local_err);
             return;
diff --git a/system/memory.c b/system/memory.c
index 71434e7ad0..79671943ce 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2176,7 +2176,8 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
 /* Called with rcu_read_lock held.  */
 bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
                           ram_addr_t *ram_addr, bool *read_only,
-                          bool *mr_has_discard_manager, Error **errp)
+                          bool *mr_has_discard_manager, MemoryRegion **mrp,
+                          Error **errp)
 {
     MemoryRegion *mr;
     hwaddr xlat;
@@ -2241,6 +2242,10 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
         *read_only = !writable || mr->readonly;
     }
 
+    if (mrp != NULL) {
+        *mrp = mr;
+    }
+
     return true;
 }
 
-- 
2.43.0


