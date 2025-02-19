Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68549C021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklPG-00042W-KN; Wed, 19 Feb 2025 09:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklPB-0003ls-VP; Wed, 19 Feb 2025 09:50:30 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklP8-0007Ze-E9; Wed, 19 Feb 2025 09:50:29 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JBEuNm022547;
 Wed, 19 Feb 2025 06:50:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Fi+vH5LkgI+HN9VSWmPbqx2cBNXjhtbbuBXvylDKr
 C8=; b=P2G8S5lTRCW6xoboERN2KeTRmCBuiORiRKvxpulGJpmIlUb4yEGhaFrYR
 ZeGtnq5Q4rkFSWsU045ExJBXhUjZKIPw1Wch93w0zMo7YJQZBSUzWSfiawSTE25m
 07ulVso1xzXr8GQcCvkusu1A0/uwSEynUkj9/ycBCSY7ytsOSYa96AZg0rq+Fcgs
 xHu6t/fhcOCwymTxvvsuo7krTrb9YEYu3QuF8EI6YciN7BeYSW92QYYjjRs8OiUc
 Y20LAveadncikNk4J92yDEaE3QCUav8yxbaozEpngu/M1qWzmfQgIUPx9WzSdZ3O
 8YaY2+uC1Ig0dRgrOrWKndKFG4Zkg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4b9hy5d-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:50:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUzAKexAdta52D07u5A9y8vOZdOdhNXIQ5lKVijfdoLSbL3G89oClMMuLxB/16KnGKNY4qdAxbV98MoTDOoVITeSvEhgQip3T3xuUXHgNuT32NWfvwlVFZoybMNL4/78rerrjrw0KOUp3D3Yeaa7wvX9m1y6hucnJBW2t/TLQ7o6dwy1UckKek6QewySKZoRLAtEtyGW0/iFSoK5dJWntxuCviTqWTC1IlKfuqyK7XpoK5aHujn1iJlpB65gQ1f/Y1qPX/u++RCADnRZlOEhsH1jUGrklvMkVWpAWQxcK8Mud7nzKhnoUfIJSZqzyQDKgmlFhhmQ1G9nDoK7+AmBIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fi+vH5LkgI+HN9VSWmPbqx2cBNXjhtbbuBXvylDKrC8=;
 b=s0/Pk5dXbpMNpHuwbUZgYkRCJ9hl5WLYaVQhwq+bEgUz0MOPXh+zlY2gk/2F8Kfb8L9Wm9PypaCfnL/Oe4FkstGHCpnJZ0hIyhSheTM16+5WTRNcR7M8dC+/5E7m3g+qjBnskTQZLdYeYTmNqJzfPYIuA1ztF0nt4OwpCNz6VF0aPgfauG8Vvj/UrJAHkvgp/m+aPggGWFDyeM5vgtex5ofbrh4qEsV+IzCr7rARZ/QBtCOFq7vIdy7TWgyTMVbYXy+RGBFG/1yDKBOdsi5m02QR/D17v/X+u+asCIRR4Jy6Ryb4Ls1qiaiEydIojKT6AXWBgSR4w0p/MKYmzK5unA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fi+vH5LkgI+HN9VSWmPbqx2cBNXjhtbbuBXvylDKrC8=;
 b=tyIxT5DQgl2ikD7Ai5QyFJ/yop/WbEoL0QjmyU9ss0MQdxdQpIQa/Y67GjGC/d/ck2WLjw4kJbIFsdSW6w/DtG1Zq51fSQB4tsE+k6htpAPR7SlhZhA672uePFf8oGnIk8mB7va2ocv6QzRdwUHWX0UyU7j63Js53eQmnKpDnbw4GPYDWenSyYLh/c5lzSA1b6Oan8Ov1VDiotlBP9pdJxGxjfBNk3I3Jkx0irY4U2ErTQAyaEE8RNAx1rMKE4o1YT2GrwvyHhZVWS1hljxjTe43FgXErKw9hRa0GB7cqaEUFVhMBfjvtItQe7NvskhhgPlH9yse8ue3fTVqMSzC+g==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV8PR02MB10096.namprd02.prod.outlook.com (2603:10b6:408:181::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 14:50:19 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:50:19 +0000
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
Subject: [PATCH v8 20/28] vfio-user: implement VFIO_USER_DEVICE_GET/SET_IRQ*
Date: Wed, 19 Feb 2025 15:48:50 +0100
Message-Id: <20250219144858.266455-21-john.levon@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|LV8PR02MB10096:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea53429-fa1a-4390-e6f8-08dd50f4bae6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q1OtlZA75qcirFLlk15H4TsfFk4vc6ny86vNCGkGKzezZCHmUtepc3WcVyxk?=
 =?us-ascii?Q?Qp/ia2i4+sDTgvNeBuNmgRIqBlWnRe2U/jND2ooYcck8hI37VPev6PUyBOLF?=
 =?us-ascii?Q?fAr7vYb2Fa7ogsFQARpm++WfRo1OzcWDBqfSjMEZv0YxZ2OtDNSRCx4h+Hem?=
 =?us-ascii?Q?GF76cnTo2+fvyYrxR3AX1a1cxFzz78RMaBz/2yaHB8rO79QSmaFLj+DwajTA?=
 =?us-ascii?Q?BEiprSFjpiKQ55C/l3jEOwkt+Ovj5XOkiMWBCFhhzh5nUuD27+ziqkNHhO2h?=
 =?us-ascii?Q?8CZtA3Z6SEVDg5l+dwKVo3KTsq30+bZCQFFsZkQadLeWDMiTts4dDRa90KOz?=
 =?us-ascii?Q?kMRobNOGfLSdvGOIvlsb6JHxxsW/v0rZ3DZYRq6Pr5YCO3EXvwczMdTw05pC?=
 =?us-ascii?Q?Apq7VKW9wxQp7MlLI1eRYgm4s4watFVVvNkjPljTFJAqrJmQ6CJyLZ3Jhw2/?=
 =?us-ascii?Q?EZ45tKcxZlJ399kSuwAlbuf7g8xXuoKccqO5JBo4BD2qqaBtspL7KPDg5rd5?=
 =?us-ascii?Q?MC3mnagCxIz0tPRS3/lS6fncXCFMjLLnEC6bz80H0JnewHOQ03CM2n4pG5MJ?=
 =?us-ascii?Q?/o8P6nNVcaNRiOGZ6lgVja7qFtRCDKBdAQVOqJZxamBdutvHdac523Beqhhh?=
 =?us-ascii?Q?AsJPxSLSRE6T7hltoIAUcjVca4ZCj6GOZdrL94RFkl57MtWuCQTlFqRLlb19?=
 =?us-ascii?Q?bWTBK8fqau9ElhtDDewBiF2LkyWOS5z1eJPCE3C1CtnfwBt3JBVCVjnS7Jpu?=
 =?us-ascii?Q?0ptN1d87deMpJs6medJhEpe5G8r5kaKMb8g2fbjI8j52gBqUywX6w0/0ji0G?=
 =?us-ascii?Q?UtVH/gPo+W5yvO4mR2WULkcpZ4XKxsnizdbjE4U7+QzzMZFNnLAbvaK9a96L?=
 =?us-ascii?Q?3Ao8WaX/zEmKePuZS7Zm89WITTGt9qq/2fjmm9cZ0tH+2uQ8zeomEKAW++Oz?=
 =?us-ascii?Q?dYsu7qK/aEZRMZfqFXetNpyLKQz6tPpJCw/MjirBPxWEJX0VGFM/WQ+vVk+y?=
 =?us-ascii?Q?KWhCL7kqtHSr/m9eRoi2tkwSEhax2fWyRdlDGIPzSMZdS7W3O3/yRTASPlBU?=
 =?us-ascii?Q?Clbg96+3EDrQDwaXnZ50S5vVGtlZadaPT5za2iUxt7VHmRedEFhvp2zUlTD7?=
 =?us-ascii?Q?EM4yVPbnf32IWxAwdjBMdehtGFwPuR4KKotiaeEH4p6pEQoXyxY2loqCflV2?=
 =?us-ascii?Q?YyJJfHiHfI6moZkinIQY0qKbAFSiCkhg11+62UQiFUpBLrxUVrgiAwB8pjTS?=
 =?us-ascii?Q?X9cjFLAkeCO9gSq0DDFZGByl8j0OTJ37io3i1W30RfTXY8z79mreSdlOo1su?=
 =?us-ascii?Q?xhznqO1xuS54jaLI5NrLq2K/+AkTF43+/I6UpxcyvYihbNU3HcZ4KTmX+sph?=
 =?us-ascii?Q?LNccK+4QzkfnWin6EdvxbD4N8zJD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?faGR9j43ijc+Evj5o50dOjR2mroAi3MLxX/aZwnvS8c9+yMLXc+DYDJu40cU?=
 =?us-ascii?Q?zOn0B4xDJui9oZyOH53wxIhIF+RmN5I7y94dS+FqjwPxpnszPg27dAhAziLm?=
 =?us-ascii?Q?d8v6J34ComWQNPPMuZ+IyP0EHyxiUYilFW+dKsaVqod2Px+T66LUaZ3BkCue?=
 =?us-ascii?Q?bN9ai9OStATG4swRUd/uJRMol5wXUZk0KhZtm/f34GdxQYnzh8N3aiBkJhOY?=
 =?us-ascii?Q?IW+azZtAl3CU0s0ogH58NkeL+tOE22SAUvJEnDgZk6ct3HGfbh/GGslDwsAH?=
 =?us-ascii?Q?aNgbv03ClBawaO/f3IK6dK36GgIJF7WI5w5qNtTWC2GRlsUspRMfghKaTn5D?=
 =?us-ascii?Q?sB/rsjgik3JfhI8zdB71HqpLWDN9b385Nicy/pduxZkGd6DeI4i8adFtSise?=
 =?us-ascii?Q?QmvtHsm2evPfqT4KfKq+l9tlazu+yWSPjJuCl2qFs/0i4qdTVbg9sG0YKWHu?=
 =?us-ascii?Q?Gd017One49XNw14LhoeTxJ/shLtYH7zwKd4jSK70ZNVfmDlKqVJ5TJIOc59B?=
 =?us-ascii?Q?SEs0/QD62nve5KCFfnPH8AzR676rDN+LAVl3LCXhz0Izj1ZOqpzeXoza3QKC?=
 =?us-ascii?Q?OBRShWw8x/lM0h0XxxEtoIBYh7V4/wVLDIVkbvdQSdvxDxkXN9yZy7rstPID?=
 =?us-ascii?Q?Gwxb5ZuSqsGu5m0k0NBPpv4kyUp3MJ/xyqYUJ46zVKYoVYEypK1GNCPH/cdJ?=
 =?us-ascii?Q?RIdt3D2kZS1eMIqufpOgFl+buyml7CA4fFXbNUpWprxAD5GOfywQv7WH+RgA?=
 =?us-ascii?Q?XnJXmgOvEuLjWyot+ky+WhNcFcdZofchGOLC7KLNuQqTLSsCpy86ovkj31JO?=
 =?us-ascii?Q?B29p5h9Z4Cc343q1KSUso5OAPezuXaGqnCcfRGw0CFYkamQyEXjBiwXPN06C?=
 =?us-ascii?Q?cyvKClVK9uUb96iAxraSr3ygrWVxF+SU1StJP0ZOTsHlUA6khTSdkcybyYBT?=
 =?us-ascii?Q?mw9cbSoG5vq3ynOZ5uM2hMM5V21YjdjURIJvxpTLXxwCHSym9IgTn/iv41Ep?=
 =?us-ascii?Q?BxSHE8qsL26C3kqxQwhVCLji/8xAFx86ymQF5yf8adjYHBgT9aBXGwZ2Ao3k?=
 =?us-ascii?Q?ax2hjgZEy5ZuF687TGoS8p86nWs4Pbn74uFiwuJjAceZx0/w7w/LRiu4Gx2g?=
 =?us-ascii?Q?qt3tLFdVOd69jxLEcE2S3YbUD1UE2HezU2P+LtlHKmq14di2vzT38RCq28ti?=
 =?us-ascii?Q?Qkmpd7JAbz9Q82vJF4BBSePHMz8EUuVE4pV5ZS0G6pJX2b6dI3Tn/eC1waM1?=
 =?us-ascii?Q?IT80jbvyKx9976gw1+i6KmpMqUbAIuKO6mUgXA6Sv4V/vHxK2xU9cIIAP5Hd?=
 =?us-ascii?Q?UrdvOA9q634pVIG4CSTcRyZlOVzp+XBXMclGv23/xONB6jRcz/T8ejonPYp9?=
 =?us-ascii?Q?sZu6g/5zGvEJ705bpv8LDaWi9TEz9sPmaHb62DXW2gztrGdY7TIcYwjKKtQD?=
 =?us-ascii?Q?bOBKDjT+wANZ9SMaezMTP+M6t6XqC5XnhsWwAUKJ8QpT7tjMEQcKYv9vd0Hz?=
 =?us-ascii?Q?fIgTjVymTGLJPmW6SzB0Cn/3Vf57hWqybLR4pwNsw35r0GTbIAAYQl3Jj8tk?=
 =?us-ascii?Q?JnKJYBMsombWOaZoL+IzsCe7KPdmS6Orm67VT2Jm?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea53429-fa1a-4390-e6f8-08dd50f4bae6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:50:19.6682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHJEBrDh24mzm2RAoPL80s64IMn+IFfiK5DUEkKQPkZN4CPf22Jya0YF/3tuw3q1vBXEq0J1tqIWwEZ5pu91qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10096
X-Proofpoint-GUID: 1y8wkTbswxcA1klijLwUveemjvN00k8h
X-Proofpoint-ORIG-GUID: 1y8wkTbswxcA1klijLwUveemjvN00k8h
X-Authority-Analysis: v=2.4 cv=HMQ5Fptv c=1 sm=1 tr=0 ts=67b5efb0 cx=c_pps
 a=bqH6H/OQt14Rv/FmpY1ebg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=eeJ3FIb8qCAeb1asaDIA:9
 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

IRQ setup uses the same semantics as the traditional vfio path, but we
need to share the corresponding file descriptors with the server as
necessary.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/common.c     | 140 ++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/protocol.h   |  25 +++++++
 hw/vfio-user/trace-events |   2 +
 3 files changed, 167 insertions(+)

diff --git a/hw/vfio-user/common.c b/hw/vfio-user/common.c
index 1a9033af5c..182ef5ab8f 100644
--- a/hw/vfio-user/common.c
+++ b/hw/vfio-user/common.c
@@ -1179,6 +1179,122 @@ static int vfio_user_get_region_info(VFIOUserProxy *proxy,
     return 0;
 }
 
+static int vfio_user_get_irq_info(VFIOUserProxy *proxy,
+                                  struct vfio_irq_info *info)
+{
+    VFIOUserIRQInfo msg;
+
+    memset(&msg, 0, sizeof(msg));
+    vfio_user_request_msg(&msg.hdr, VFIO_USER_DEVICE_GET_IRQ_INFO,
+                          sizeof(msg), 0);
+    msg.argsz = info->argsz;
+    msg.index = info->index;
+
+    vfio_user_send_wait(proxy, &msg.hdr, NULL, 0);
+    if (msg.hdr.flags & VFIO_USER_ERROR) {
+        return -msg.hdr.error_reply;
+    }
+    trace_vfio_user_get_irq_info(msg.index, msg.flags, msg.count);
+
+    memcpy(info, &msg.argsz, sizeof(*info));
+    return 0;
+}
+
+static int irq_howmany(int *fdp, uint32_t cur, uint32_t max)
+{
+    int n = 0;
+
+    if (fdp[cur] != -1) {
+        do {
+            n++;
+        } while (n < max && fdp[cur + n] != -1);
+    } else {
+        do {
+            n++;
+        } while (n < max && fdp[cur + n] == -1);
+    }
+
+    return n;
+}
+
+static int vfio_user_set_irqs(VFIOUserProxy *proxy, struct vfio_irq_set *irq)
+{
+    g_autofree VFIOUserIRQSet *msgp = NULL;
+    uint32_t size, nfds, send_fds, sent_fds, max;
+
+    if (irq->argsz < sizeof(*irq)) {
+        error_printf("vfio_user_set_irqs argsz too small\n");
+        return -EINVAL;
+    }
+
+    /*
+     * Handle simple case
+     */
+    if ((irq->flags & VFIO_IRQ_SET_DATA_EVENTFD) == 0) {
+        size = sizeof(VFIOUserHdr) + irq->argsz;
+        msgp = g_malloc0(size);
+
+        vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_SET_IRQS, size, 0);
+        msgp->argsz = irq->argsz;
+        msgp->flags = irq->flags;
+        msgp->index = irq->index;
+        msgp->start = irq->start;
+        msgp->count = irq->count;
+        trace_vfio_user_set_irqs(msgp->index, msgp->start, msgp->count,
+                                 msgp->flags);
+
+        vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0);
+        if (msgp->hdr.flags & VFIO_USER_ERROR) {
+            return -msgp->hdr.error_reply;
+        }
+
+        return 0;
+    }
+
+    /*
+     * Calculate the number of FDs to send
+     * and adjust argsz
+     */
+    nfds = (irq->argsz - sizeof(*irq)) / sizeof(int);
+    irq->argsz = sizeof(*irq);
+    msgp = g_malloc0(sizeof(*msgp));
+    /*
+     * Send in chunks if over max_send_fds
+     */
+    for (sent_fds = 0; nfds > sent_fds; sent_fds += send_fds) {
+        VFIOUserFDs *arg_fds, loop_fds;
+
+        /* must send all valid FDs or all invalid FDs in single msg */
+        max = nfds - sent_fds;
+        if (max > proxy->max_send_fds) {
+            max = proxy->max_send_fds;
+        }
+        send_fds = irq_howmany((int *)irq->data, sent_fds, max);
+
+        vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_SET_IRQS,
+                              sizeof(*msgp), 0);
+        msgp->argsz = irq->argsz;
+        msgp->flags = irq->flags;
+        msgp->index = irq->index;
+        msgp->start = irq->start + sent_fds;
+        msgp->count = send_fds;
+        trace_vfio_user_set_irqs(msgp->index, msgp->start, msgp->count,
+                                 msgp->flags);
+
+        loop_fds.send_fds = send_fds;
+        loop_fds.recv_fds = 0;
+        loop_fds.fds = (int *)irq->data + sent_fds;
+        arg_fds = loop_fds.fds[0] != -1 ? &loop_fds : NULL;
+
+        vfio_user_send_wait(proxy, &msgp->hdr, arg_fds, 0);
+        if (msgp->hdr.flags & VFIO_USER_ERROR) {
+            return -msgp->hdr.error_reply;
+        }
+    }
+
+    return 0;
+}
+
 static int vfio_user_region_read(VFIOUserProxy *proxy, uint8_t index,
                                  off_t offset, uint32_t count, void *data)
 {
@@ -1275,6 +1391,28 @@ static int vfio_user_io_get_region_info(VFIODevice *vbasedev,
     return 0;
 }
 
+static int vfio_user_io_get_irq_info(VFIODevice *vbasedev,
+                                     struct vfio_irq_info *irq)
+{
+    int ret;
+
+    ret = vfio_user_get_irq_info(vbasedev->proxy, irq);
+    if (ret) {
+        return ret;
+    }
+
+    if (irq->index > vbasedev->num_irqs) {
+        return -EINVAL;
+    }
+    return 0;
+}
+
+static int vfio_user_io_set_irqs(VFIODevice *vbasedev,
+                                 struct vfio_irq_set *irqs)
+{
+    return vfio_user_set_irqs(vbasedev->proxy, irqs);
+}
+
 static int vfio_user_io_region_read(VFIODevice *vbasedev, uint8_t index,
                                     off_t off, uint32_t size, void *data)
 {
@@ -1291,6 +1429,8 @@ static int vfio_user_io_region_write(VFIODevice *vbasedev, uint8_t index,
 
 VFIODeviceIO vfio_dev_io_sock = {
     .get_region_info = vfio_user_io_get_region_info,
+    .get_irq_info = vfio_user_io_get_irq_info,
+    .set_irqs = vfio_user_io_set_irqs,
     .region_read = vfio_user_io_region_read,
     .region_write = vfio_user_io_region_write,
 };
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 6987435e96..48dd475ab3 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -139,6 +139,31 @@ typedef struct {
     uint64_t offset;
 } VFIOUserRegionInfo;
 
+/*
+ * VFIO_USER_DEVICE_GET_IRQ_INFO
+ * imported from struct vfio_irq_info
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t index;
+    uint32_t count;
+} VFIOUserIRQInfo;
+
+/*
+ * VFIO_USER_DEVICE_SET_IRQS
+ * imported from struct vfio_irq_set
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t index;
+    uint32_t start;
+    uint32_t count;
+} VFIOUserIRQSet;
+
 /*
  * VFIO_USER_REGION_READ
  * VFIO_USER_REGION_WRITE
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 3f5aebe7ac..053f5932eb 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -9,3 +9,5 @@ vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d m
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
 vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
 vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
+vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
+vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
-- 
2.34.1


