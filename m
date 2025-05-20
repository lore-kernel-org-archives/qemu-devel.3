Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38236C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOWH-0002zI-GK; Tue, 20 May 2025 11:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWE-0002yi-Q7
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:04:39 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWC-0002Jt-Mu
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:04:38 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KBfwAM026470;
 Tue, 20 May 2025 08:04:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=bpWehmf7MN0fSB2ReUF9Kx68krZ9XDKB46l6jV1yu
 Ls=; b=xni7JwscIHHtBp16/Fj2EboArtrSlM07sLWTmA+RlPazdNqNJ/kj2Hm/Y
 vXRKmJdqOYNlLcPFGT87lRaegvjUZkSbreBB8H+PnG+SMxZCutZJX8GdT05IRHZG
 sparBOJRTBAPQ/2B3JSTyVM9Sst9BmxrEvFWqA4yUKRet2PFvhf7bo4oOV7NmKDB
 Kei7me4BoflifONp1re4LjbUY9jMhAQPShA5sl2GgRbqqm9ccfACmmreB3OAchJw
 o/7bzEq8XRPoniU2E2XWQWnISHQ418xMUL5hKdNK9tdl/jjyM5wP4+7kgY5esng7
 8Nf+kPQUEy9QxhPZ7uTfxnk9+k3RA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010001.outbound.protection.outlook.com [40.93.1.1])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46prjheabe-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:04:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MO/RPjgpeCkfmt+eZQ233tQpGL4AZ5CteALZyA/RIXVyTkDgdf660/fsB5M8pZZI1ZYY2B/Nk0Nnk9UEOw4hUwUrUL0/Gxgz2GomH6Vhke24WhixmPb5bsFJhGxdsKw+8jknOYtRd7Zve5LsoD6TcwlSJ2NeQJT4gVKeqkhnlA9qocopGGi4oVP+TbvUkdi9cKpkEw+SlVixERV0OR/FB9mMkXQtxD6CfQpH8uGGtlbnwtnLi50qetez0xoAE2xrjMOAjR1mcbDNHt6/e386hOQm7D66+qFTK8lxUeoKQZP2qjZU0x6d5vfRwRFUodpZbP9V33UU+KFKM2Dgtp85xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpWehmf7MN0fSB2ReUF9Kx68krZ9XDKB46l6jV1yuLs=;
 b=XTwo66aFGU/uTL9C4RM19oycESG80KWg2rjieTJeswCzFsdR7TVBQwX9kyiaNvsvpYzMk+NObyJebNV8W/OK3UHBrQzpFUoEqzpWc+ZcNk9qwVS3lD3PNwFvy6xLkOXWmG4GBiU/Z7YfW518YLKwBALSgrqH8fiS5N64pVlknH4i8Vl1zigPFE1PHPFVv1YZH73spr/d/VAjMR8frON26FQTIKiprqZ58uuXFlHwEAbK0dS+hZcT/zOo1sYFQ+YRLhtUW2c3KOmVNSHTZKzGEG6C+buMi1fJTVM2oz9qcLdspTx5MvSp+7wGrajfEQZtrd0GLSEio/sRaj4t0R8npQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpWehmf7MN0fSB2ReUF9Kx68krZ9XDKB46l6jV1yuLs=;
 b=eSBTmAV/BaKdNaDMeu9Z5HoBnttcWVxT6RwtMWLn8+0pCoKvCOO5hYLxWa4/L7s3r6xn08lawDphmnMFIm95g9oWrXI/bNXFvLA9EbKoEi81KjSRZlAavAZDk4kThpcGelgLqNlSUq2ibzfQRS6J8NUPEkwjDOaA7PG0a0P0LiokyO24QUsJcQA8XJ7FUDGuSuQESxv7M1PmBgo1xL3y3KoY8IMiZgtrOJMpSFhtuK5A0wnNSdCihRFX+AryimUtZJsR0XxwLjVCrivJ51X1ub+vdbqhyV8Wd8jLGqJRk/dtbka+tI7WSsVvWyfKypY/OxXW4bQr8d6Fmsj8KnIA7w==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH4PR02MB10612.namprd02.prod.outlook.com (2603:10b6:610:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.16; Tue, 20 May
 2025 15:04:28 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:04:28 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 01/29] vfio: add more VFIOIOMMUClass docs
Date: Tue, 20 May 2025 16:03:50 +0100
Message-ID: <20250520150419.2172078-2-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150419.2172078-1-john.levon@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH4PR02MB10612:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ad557b-0508-4967-8bb0-08dd97af9e04
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kZQGNicbSnw+iMwPH5QCWXoMmSxch07GTEKr2t7YZX6BdsP6aZTOfGguVzLH?=
 =?us-ascii?Q?zBtI9Ata7gntxsm1ZwgmGhcfHLsiP6qo0bWg9+/CZYqStLGSzblhKivcjAOv?=
 =?us-ascii?Q?s5xKGVpmJYvk+fArLiNtk3FnHSvzOx3Z+JUQGsI4cC9EDVWMDXsBsj5LVcHN?=
 =?us-ascii?Q?jYXtkp+SarhRr4p3yYJTgANchE94yIrMxECb2D3FOB/2AbFG7jh2man5N/Qr?=
 =?us-ascii?Q?a8gRzF5htP4s4zJx/tiilFTPfZdujfZ5hADuIq8CuvWBDx6u//5d4Tw47NCX?=
 =?us-ascii?Q?Z1pbEIqnLiGxnPr4aAEBvvKTeN4bor2XxLjKqHC9N6HP41ajgzciHHX3KDDJ?=
 =?us-ascii?Q?zcyGb9PwkkIf67RUjVKD8iyggpAUIKPFWYw8Mfel44q4FDvWrhlschPEVbhX?=
 =?us-ascii?Q?vexB3NnQpiFiyRLegRH/iGODp9zAegeHnzDX7LYHkoAkAh32q7qwwn1mArlH?=
 =?us-ascii?Q?2tE4F+kaiDvfSdabFKyaWPg/6vOqADYN+4QRsTiDiBs5GVCR6qpMpe1/xUgY?=
 =?us-ascii?Q?GD39s8epuod7ExmfYktDPvRH3AiVrHNWOC4DNWHHAdw1B+0hokLqvaln2O5q?=
 =?us-ascii?Q?GNALHLrpRGpbwlHlb6leXx97DMuFRpiS1ITuO3KY6+wLVYGfoVvFfCoYUEkP?=
 =?us-ascii?Q?0S9g9fqV3p0Ud4l4HgZ4YORUVyM2X2LyOJnB2c0k92EoBvtJGYHacGag/d0D?=
 =?us-ascii?Q?xcQofjZICFKPdZ8lmzrHN8+aVsCOl6MD8Lauygo2PZgmEye8R+Hz2Zn05i6B?=
 =?us-ascii?Q?vna77ev+izbmNeDS64WCtqIxfmTCTM9RO9kvI4wD2plpsAFneREDhuQI+qHe?=
 =?us-ascii?Q?MCxrLZYOU/DF/xv8Ra/Y8t3y1uw15TtAIjoeVMxhJtJQyiEJj1Ra8YsLIy9E?=
 =?us-ascii?Q?psdw/wHA3djXYFWzthclpIXF19wRlVso8YrFQjNPOAlGQeTSWgPP4Cjlu4s8?=
 =?us-ascii?Q?Qsl+pp1Su8B5o2U+qSiIxtIoM5jdITAW7J0uunb3WwxXLh+rSnGfaTNtOn5D?=
 =?us-ascii?Q?sjECFLAJvy+kDUe83KN3GyXb3aMYb52CnCVleVbFCPaIuloIm7jH5nTqa8ad?=
 =?us-ascii?Q?0OA4nxREm/RiF/0IUBRNz4vz/9RpH90Vz+OXDtkvW80WJpDjpHaD6NJS7PJg?=
 =?us-ascii?Q?vgMG/I+6HrwkEbI2XVLEzof2uvPYfnSHhF+HSD2uyKrT1S5fqlPj3WEoC1Ct?=
 =?us-ascii?Q?9dcSizE8LqdUPonRYIMJ+FtJIJ+J9y1AtGuEcQZl64HXqqWb9kfZcwSn6ote?=
 =?us-ascii?Q?2PD6X1Xp7eM/WfgkFsl7yc1UmyBFsaVbF+3voIWgj9CnSR+SZhPVZ5WaM0cI?=
 =?us-ascii?Q?knBXn/i4fEU/ipj7AkTd2+QBvyq2+6cgOX4PjCWkuq3kbpXSW88gW/3oK5sT?=
 =?us-ascii?Q?ZpLDU9MOGoFN8/dWS98eIgvpkjksnO8PbxULjNY8vgHV6NkPAHhUQBiQ6cj1?=
 =?us-ascii?Q?+c+VMCx8Xgs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gv4JaJdRcL+Z+leSXrGwE6hmEjij7ygLnGzEFZimbhW3U+V+ZAZOmix8yCKh?=
 =?us-ascii?Q?Evr028YucMDh9HKzy9OObQn32DRrWfijijAggsGFfN1YwBKYEC4Onb/AGMi3?=
 =?us-ascii?Q?vbiTTCdUrAWX+rh6PMyVwJ4of32neCATfk8VVhg+Z+7KHecD69cWwEKBj+TE?=
 =?us-ascii?Q?/U078WuM1WRWWghPRI1ute8JxU8VXeXCvG+xa4X//2ahIUPmiM6IbfPcY/bW?=
 =?us-ascii?Q?tG11Ze0FEi7a4ZaRVzl7zCQqkI1X8iRj8NFeb+BhVNF3wCd2/g47fY5T2kw4?=
 =?us-ascii?Q?46LDK0j47vrFfwY1a3k4SqINDEHaNk5nqKCybgfXz8XtFuVTlNx2AtvNHp2E?=
 =?us-ascii?Q?XGlm9kMoopOuzCBlV6ER9V4/GtWFuDJxsydJH+80nYqUvKBDo7AViDeC0rs2?=
 =?us-ascii?Q?bAaFvO9L8WIukb2E8dD+7Wr/Yh6zFmoq5bP+HmpOULCLw5jRQnEBWtKQvNbz?=
 =?us-ascii?Q?n0ykRznuRYMR8o0Zobb/G+LCTAWpv3F4KrBLFX+/s9lwwdVlXVaW5SE7siGw?=
 =?us-ascii?Q?/X9DqRYlZn0ykTsjAvGwsFSmMJiQR2tX7NoT5uxdX6KTANu42QR4kOgQidXb?=
 =?us-ascii?Q?Yo5uhnC5YlJELhH2NFRXX3r2gB/P0Piys9UqowXoxVj20wZXvWhEKw29cfiE?=
 =?us-ascii?Q?ulZq1xlrZ4j35Ji+yZVtGgKs9n9CijE+W6RP0dHhN1xZv93WnOQ3Z/YbRlof?=
 =?us-ascii?Q?PDwg81SWtM/1c9IMEAvNqSzaSIxpuM+Lq/EzKESWZunVBZAiZNwB+1q8GBfa?=
 =?us-ascii?Q?y2X69Xq56vMng1as+SdOEnQkeaZd7zCTzClx2kFwvHTsXwKUbOiYwH71Eddq?=
 =?us-ascii?Q?l+BjWSD1oKL3lOfjzheCY0JElVJ5LcFfY6RxU6MRtJ3p7mPxJ6CHJPmMEzLH?=
 =?us-ascii?Q?vwWUEnGb1Tr1cU90PBshJ7wNrGtflXfwO2iRp/4I432XKQlI2Ln7ZKq4opQ0?=
 =?us-ascii?Q?6iDbJYR2uFyOckBPCcH2XZ8pGCD8wXGYnayyqYG/89Qgd9Ze29chPJ1mR3Dx?=
 =?us-ascii?Q?FlEgjvNCQRZ8WrrBIKcU54efK7LbV7jN1yoyJhawPX8JP1agDODDZ9hnbBB9?=
 =?us-ascii?Q?SF3JviKBfDOOC2H407lFcQEaq4cKh3n0lSVoIETU819DZZx4uAa/BsIdT/SS?=
 =?us-ascii?Q?BpJsWr7+Rspr3rmTr7ik6gf0+PWI4SbMV4skbXWSDYPWXM+kE3zyoSTdkFYn?=
 =?us-ascii?Q?Enu+zerwZIkPxXLJ26s9BNHKIqYCi2C4bM6S1Ryj/GGFm+xVztVtePCA5gc+?=
 =?us-ascii?Q?t4zk6fz8fKJHD4mnNN0Olger2qkVH53mC5NCJ2lKqZAIrGKIjyZuscBobE8y?=
 =?us-ascii?Q?SEzkaN/h/TFMFqzh/qvEnPr89mAX1TuWQEznUlRY+RLMo2WpxdjJIXUO+Ks5?=
 =?us-ascii?Q?DdlchWyMPuNu+COH/yLoeYhu/mfWyxfNrqs3Jm9KwlLan1Bs1VGYhJSFc3J7?=
 =?us-ascii?Q?Exd8zK+1Q+RuAVswL+0GT64Jz3x2vvte2xC+Y4PJ/jcQhlkgvUao+EGvGUl8?=
 =?us-ascii?Q?r73MfyxY3zyRQahlXXmY38Qg0lqFpepSvlHuLIi0X98zTuOlwnFLd2+gZIx2?=
 =?us-ascii?Q?nCkyNyoYh5C2M7DmlUaAudrqSlxlVEqMigITdow0?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ad557b-0508-4967-8bb0-08dd97af9e04
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:04:28.4377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsiNmTqeymeNwMrSiyHZ18xDTrtLqaLZGpECB9TI1+t6D1NqxZJUUX+UANxpSh4s2u97MYo0a8E9aMoyyfqbKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10612
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX9aKOXXQLhU4y
 HMGCbZWzST1n7XHTiu9LmBRunv4e3QtwABAgxZjt/6TAeiYwCZCJKFjeYibQv1RQzECeY/pNV4A
 j92HXJ26YBDM0pQxcE7kWZllL+zyTE7mzhDM1YoPcz8u6h4yFjI1F+AwhyxdF8A3MKsJXjd8ndp
 hazNG9VB4vltcgz93pwdTJCj1wU61JtzuGG/1ol+KZQyceyqdcx+KrYwDWIRd07GZf1rpo72ppe
 aD+q3s/uYKcgzeKX8qZMWtDE45XUq04kfuD569MR1T1iMTm4dT4+5VMaQLMBtSL3GUWDZqv4Jfn
 OyCcqpWqxYXt+H9Qdi5ZfJBAsXg5viXZEOrJGkspC4V4arputIOJ7lxoCAGZ6jqkjU6rBdg8so/
 7bFLTq4AcfK59/lAxWPlhRB1wlsAC41+fpfqsKHE+8cckuaJe93ICrXbPjvKNWUb+46vewvN
X-Authority-Analysis: v=2.4 cv=T+SMT+KQ c=1 sm=1 tr=0 ts=682c99ff cx=c_pps
 a=zbudaZmfUx0dwwhLSrpPog==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=PpfnBm1fC9UCdYKfmFUA:9
X-Proofpoint-GUID: _DR6w3bDnQVcLu1eqnhOAeiIBIqhADmV
X-Proofpoint-ORIG-GUID: _DR6w3bDnQVcLu1eqnhOAeiIBIqhADmV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

Add some additional doc comments for these class methods.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 include/hw/vfio/vfio-container-base.h | 64 ++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 3d392b0fd8..41c49b2aa5 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -115,13 +115,52 @@ OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
 struct VFIOIOMMUClass {
     ObjectClass parent_class;
 
-    /* basic feature */
+    /**
+     * @setup
+     *
+     * Perform basic setup of the container. Returns true on success, or false
+     * with @errp filled in on failure.
+     *
+     * @bcontainer: #VFIOContainerBase
+     * @errp: error filled in on failure
+     */
     bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
+
+    /**
+     * @listener_begin
+     *
+     * Called at the beginning of an address space update transaction.
+     * See #MemoryListener.
+     *
+     * @bcontainer: #VFIOContainerBase
+     */
     void (*listener_begin)(VFIOContainerBase *bcontainer);
+
+    /**
+     * @listener_commit
+     *
+     * Called at the end of an address space update transaction,
+     * See #MemoryListener.
+     *
+     * @bcontainer: #VFIOContainerBase
+     */
     void (*listener_commit)(VFIOContainerBase *bcontainer);
+
+    /**
+     * @dma_map
+     *
+     * Map an address range into the container.
+     *
+     * @bcontainer: #VFIOContainerBase to use
+     * @iova: start address to map
+     * @size: size of the range to map
+     * @vaddr: process virtual address of mapping
+     * @readonly: true if mapping should be readonly
+     */
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
                    void *vaddr, bool readonly);
+
     /**
      * @dma_unmap
      *
@@ -136,8 +175,31 @@ struct VFIOIOMMUClass {
     int (*dma_unmap)(const VFIOContainerBase *bcontainer,
                      hwaddr iova, ram_addr_t size,
                      IOMMUTLBEntry *iotlb, bool unmap_all);
+
+
+    /**
+     * @attach_device
+     *
+     * Associate the given device with a container and do some related
+     * initialization of the device context. Returns true on success, or false
+     * with @errp filled in.
+     *
+     * @name: name of the device
+     * @vbasedev: the device
+     * @as: address space to use
+     * @errp: error filled in on failure
+     */
     bool (*attach_device)(const char *name, VFIODevice *vbasedev,
                           AddressSpace *as, Error **errp);
+
+    /*
+     * @detach_device
+     *
+     * Detach the given device from its container and clean up any necessary
+     * state.
+     *
+     * @vbasedev: the device to disassociate
+     */
     void (*detach_device)(VFIODevice *vbasedev);
 
     /* migration feature */
-- 
2.43.0


