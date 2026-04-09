Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CE9EA3C4A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 10:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAmvt-0006ID-Bn; Thu, 09 Apr 2026 06:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wAmvg-00061c-Gu
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:48:10 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wAmvd-0006Rh-Vr
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:48:08 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6397XvLU3824063; Thu, 9 Apr 2026 03:48:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=7WwzSZpm59dDZGQ5wct/YP9hJmQL2sowM3tOrdwWw
 Hg=; b=LYrFWWU9TM6toeCyf9hqOXk5RrglwAoIl31c7KgdOCRoT8pGtizLeg6a/
 hWW6IhWopLaxrmzIZrk+2UpUwbhMf6j0uXkkKYYXiklYMrgRAmsjzmjHRwWrmBEy
 eLkhzOQDhg9UeHS5dy67KX+OHwDp+VBSz0FUh9znhLIEddtH7sNI8U5/byREIt1W
 UG5LEF5D8FfCN6Xp/U9+POncYR0Io9fpxILcw6HyWEq+rmIxsk0SjBKKv/RzqzJm
 dHMT2RgzxXFzOT8JBOAx9zjgAR/sdUTZ0vv7Xp1eHnWrmlPyH9tIpnj7Rv4XAKqX
 cPChAYFuY1f1jvGGASOwNdzsuvxJQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021095.outbound.protection.outlook.com [40.107.208.95])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ddutasxq7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Apr 2026 03:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHZEEQoGsMRLiAzrZX/H1neULiGLTJYJ7r76s+0mBXzHjh5fhVXgf1q3cIdpgmSpkNfITw/dHQU+2vbChqw3vNtjSd8+vzrv3Rx58kJ2lRoQ/4h824e6Q8+gQDB1BaXuNr6PaogYhibtkZ8lvQAdELrhN2i93K4WxbLkwpk7HMDxKanaZDNGBfoazE/0Qc9RwT4xdZmCiwFQVxBj5Lmb/UeyQlf/n8v1O7A+BcFMl4/woZFGCFmBZwm30k0km8DbgZDX4pvyc6GL4olwM8nRGR/w4fczCqtyN5CHgwzjhJYZuhOvfp8aDeJVyudLy2Pc0l9uPMjFIog7KCCXV0bN/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WwzSZpm59dDZGQ5wct/YP9hJmQL2sowM3tOrdwWwHg=;
 b=KMTB0gLFvVb8KR/8ow9f4CXyPVb3o7cO6HNFe0tRIJovHFx3GmzLF0mDWQgFok4PGshZbqZJrTZmyBrRWbjHeWMzI3zyfxklNEsupp/mAEDl/DMrb/ZLntVCGEK9i02ouNu/U/oJER2OBIA3vIVow6OzTDxAM4VyRLECegbBuAT4E8AKgf8XPpCMKTMHoLsBdPg5AAngyl/OzF9EC1qrv3ENjpFII9sD64Tnwz9fzL4na0nK3HymDDuQZSEFqgdPX7rcs4wdpI91Bfn70nUWrPCPKXKelduIJ81/3+nLSDadXXc4hQfAiS71UFsjjg2BNWYcZLJl99oSJlGdEmpgFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WwzSZpm59dDZGQ5wct/YP9hJmQL2sowM3tOrdwWwHg=;
 b=A1cdbkRIW8juO+1Gwsap48jSjfha8W/OLskseolRdG1omrekqh3e75GOdx/dbckp7y8v9b6R7xWpXVuDnVaOr7XW/hExliQLWkpak9XXetratNs3RNPxcH3o0xHkLRBf5btJneBCUwhVoN4TPT0mk1nb8KfVJwiRye+kZxl0BrhbNpQs77tMrqP1kfg7NCR3c41lw9ay+2XM28nAn9c7hrlnTHgpVAUUiQfKZi8rzwLWpbuDtnaU/BKBb/sBUXMzcOZb5x6SRoIen4L/cnjLJC4hYv7DCeLfJN2X92xsufmJZaefpiUt3AetdFh77dT0FquQ15Xwxu8lNo3iYEJ60g==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7597.namprd02.prod.outlook.com (2603:10b6:a03:319::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 10:48:02 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9769.035; Thu, 9 Apr 2026
 10:48:01 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 1/3] vfio-user: support VFIO_USER_DEVICE_FEATURE
Date: Thu,  9 Apr 2026 11:47:54 +0100
Message-ID: <20260409104756.465294-2-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409104756.465294-1-john.levon@nutanix.com>
References: <20260409104756.465294-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::21) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 54199af5-e850-4359-effd-08de9625787b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: ryECLaGA52H0+GKm3iex0iYMGHAOjUtgn5PiCpUMMQxifN66uUK3+BodaUVzA2qK7Bf20w2lc1rk6HpiMAg6ychOWIb0Ld+ycZo2eRC9JRsoIZTKfsT573JxOZyA2lGqXBLdsrWctKznHl0EXaLsS2tCGTjnp9fxuPJG6BRCUwC6Gv6bFnHdh/tV1tjc8k+C2y7LyFXeegiSZgPbdsRgIKKVh0Aerlk/DDZTtnZe2qklfKwqPjoi46I8w35tYkZd9cX62JPZxJ2cO3A9qmOZFQ9fHCT31eh3iKiMqOouAVxN7m4nOTLv4bsy6oe9JiKqbjw9PTSdQWk/Sz943SmwbbsxzZN5krpf4UbFYQAv2h7RE28gUc6O2v1Iy4USFHH8OR4mUEM5iEH29ULM0d/QlCGnwa27XMELAbtseiZFxEpvuMTXGlg0Rlz/1P5Sc9Gh/E9BGJQDrwbghurk6LGwMbjejPYoZw3FzBspM/p4smLIbT5Zs/spy+s7mQjV9r/BFjd0Vp5L4rPYwkpv6o6sfYIaVmB7REzFFVTg/ZZEGmw3Pq4rWU7STA2DG7TerwEFr9du8UGD6nhDNSR46T08oFZIWtTg9MI56c0ExITsIe8RcBHcYgs9Fhy5rjhe3NkB+xKq1j8aqq/V0p1BsEclweU+XGhL0t9aC7/R3mNN52l8narb/18RFczT7XNpGfU28cE/iot+ldCLmQwzI8DgXZFrAb98jbFcjXrJ4k3yRwc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bleZe9ToNGDL9Gff+YfBpCZtgib17bLY+dasuxt0vPfNMQl+tZIw0BOXExcN?=
 =?us-ascii?Q?wFlxPYGCyoPsUT76N8jtObnn//R4ahGgzuXqkGRGCa8LwCH6e0mAN9eLy5hQ?=
 =?us-ascii?Q?hCkY881funSnb2ksziiUPt2iYwevTbgejjoc+hhMNUKkxGfYPsjeNiPk0lrI?=
 =?us-ascii?Q?Zo/Pd/y+l4BIDIa2SqG3mrWEkC2SuPygDjSs/wpmhdiqMogYpVgqSzu9KOVt?=
 =?us-ascii?Q?vn9ceJCJlo7L4Z5Hd6R7RO8uWgxKFnp67Is7VAlr2Zj4u78hqxsWB5Z4kTgE?=
 =?us-ascii?Q?OffUTlA/sh0CnBEQBFARtN00yvGMBTk0++K49CY+ySiHVwyy/mn766Ed5Thy?=
 =?us-ascii?Q?/K4QNveQegyQsEJcmKh/Iu+KqYztd4cXgvU1PK4JEe7WAgxdhsahd8m2hkFM?=
 =?us-ascii?Q?uqEA8hbKNN1qxD+9bgI1WP15aOB8zuMSJ9NqW1dClXFmX5JzI19mQTdos6D1?=
 =?us-ascii?Q?9ZxemlQxPttcry0t/4DuzTe6YsK4+V7wT66ayrmn1xfnsaiu4mOxI3SPkA9b?=
 =?us-ascii?Q?l7na+yE91fzHXqrh6M29+5xr9zj0b7Y9Gez/mySghgGHXPH5nCGH6Vz8ndp5?=
 =?us-ascii?Q?8kQ8nZvmYOLpZ7p+9hITEkGJ7Ox3Mc2tktG5FzzdYwXHVZvRVHRa3t6TZy5n?=
 =?us-ascii?Q?xWeiYMdFggNUuKUD8TI6GEny+8OzPa7V++ujzzaD7vpJixavSlibpt3GuPEh?=
 =?us-ascii?Q?wD6JkqKdRMBQSpVdneFgc6wZn8Oz0WD1VXg7Xy9snA4Zcx4jGVnaPPmTTDTK?=
 =?us-ascii?Q?p0df3n44MGRQh+xKKCSHhz3L+i6EGvA3WXl2ysipN+fONMLkclKMsNkE6nGs?=
 =?us-ascii?Q?fxRnxAjEnytCu6tKovgexrx/6YiBUNToJJYLL5Xo/TCzVLXo0sq7EmeM7Y76?=
 =?us-ascii?Q?83iKh6gkN9DoAeAMDJI5cbWrAwz4EORg2ZR/6XNzYV+3S1NIAbnqa76d9bm+?=
 =?us-ascii?Q?PYGjlp+dA08TltdFKj/d9nL7oyk7P19jE/s0E5cYlIKctr+GqvHSyS37H8Xy?=
 =?us-ascii?Q?8yZVPFdxlDmxCUAbw5KDq7OljI1NGBQKgDteBtgQb833V80P18oRYf0w4EE3?=
 =?us-ascii?Q?ZTFDEYNwqVp2cIEOPopO2W440/sfFvFJwRFgkYW6iPWIlXii+xxaT3HlE1CQ?=
 =?us-ascii?Q?FTwU2JI9r4enH1pEIQ4cYufJBVvBrM99SIgjjRhcihKV+1qfrX0xcZP9W1cO?=
 =?us-ascii?Q?6ekX1pM11ba5Ron9WZDP6FbJFwyAMaSRZXEELGyKq/bfKr33zhVMzEfWDLDY?=
 =?us-ascii?Q?nBUthjQq4EmfUQEcVMzwUntmyzXqX8AIEBDAFJRf3HZQOSUXsh+/rXJFZbRv?=
 =?us-ascii?Q?5NThSeFhPp0hurTT7px4bOSg2YrzlpeIE/SgZnbbvsh7c+eFxgJY4A7+4GMs?=
 =?us-ascii?Q?HBaf/lTN3Pe7y9vUxgcudb0uWUsAJ+aV13iB34kJ70T53cOqdUGgZDGL70yo?=
 =?us-ascii?Q?t3v3gKI/L47uNXtZs38b8btEwMJZHS5NBReaanMfbUhdkz6k7QV4PTLSXF6i?=
 =?us-ascii?Q?AYmYXMfWsk9hZDBZSql7g6ykGUotDuOk5hLIse3tBepo1DDBY9b4vk/aOqzB?=
 =?us-ascii?Q?+itDtXNVm6Dmdu3MqYbJjV9vXsWkQc1qQaqlIiM3YQhn3E85M1MkanBHnsXp?=
 =?us-ascii?Q?AbZVLMxCphma8hxvstEyWcfoJt4ktamJXhKice5zkuR2qvQAcAE/FkZSl2fy?=
 =?us-ascii?Q?FosR4T8Vp2KGpJ+WDKYDqLD2FfTssotjXKB3NXxMtMi9ed90v1P+ke+foAvj?=
 =?us-ascii?Q?BLQDyzQWYg=3D=3D?=
X-Exchange-RoutingPolicyChecked: Z3EcrduOlz+K0Z+DN1Dyx0F/EvIQ8iOcZwq4izatcR6pHehjoQO7suTsJYQYw/JW4eBjk+WxfJfIPWt0cYIY00FvYYUuAw7jga85mBhZvl6pzZhpxPd9XDWYjjrajBRzmlz0h8ZiJRXznbvaU1d5drq2qoNT6hsJW2hC83NLP6RNYLZFj47Kf/hTxVgzddi8vWKuc1vfoGnky+olKJlV+NaDNWiSLpQWZgZ9LdCuebaYYbfp/qhld/CIe5MElgG9zQz5670wVz5FJbfWDUJzAQUl/REv0nWuXhWDuJik2JTxaT5put/AnQk35hq54yTo5GyNiZGXbzHVAPMbuwXR/w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54199af5-e850-4359-effd-08de9625787b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 10:48:01.7014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QSDROtUJJnFxI1QL5UZri4NFTRtdx7CtAT/uwLYsme7FJdW4pB6i4Ry8YOInaRRmfwfeSRZf/kwk1sAEZLFMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7597
X-Authority-Analysis: v=2.4 cv=StugLvO0 c=1 sm=1 tr=0 ts=69d783e3 cx=c_pps
 a=skfC1x1gg3P3nT2FkZteTA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=P6-GAGG-IN1-BGcB38EA:9
X-Proofpoint-GUID: tkOwU5iIe7bveukNs1low5SC5V8FPxhP
X-Proofpoint-ORIG-GUID: tkOwU5iIe7bveukNs1low5SC5V8FPxhP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA5NyBTYWx0ZWRfX0h3lllCfzEwf
 O0q3Dik843VZQUA00vvVJ9LGMAvFN13BSspd60IgiLUH8M65FJ5JgeIzDh4ajt7kWfwkysHFrY6
 Rrm3HR39LM64GhCKhVFRvteYtULTPENa3+qzIkGt2rsYcIU3SU21U4WwD1e8wsR8UH/jJvnK6K3
 ffCnufO5N1ljpa7KEwl41UP23/8y0weUtU7IaOAEaIrZO4deVqUAu5ySjD/T6zGL5Pm16tIq8XR
 Ly0/bVmZF4/ITIW7SxpH7Ny0rkCsxmeBQCeC4WM+1cHSVt6jeQIGeaIz2DZNCKQ/3aGyep8g4Ak
 tE/8954oiaGNj61pGtoGBvUonErgHKBoJvOK1QjI0m7Ury821AAFmqVbeDJaEIYhSXIaI4XYSmP
 Fx5P4J8EFoUgwjALmMFAEIkSuKhA61Lbcoznlxrb7JCuJVWFs5UUcYJXUe6uFHcgJqZYmzHwCvY
 2BuUQb8C6NzcdGm5Omw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_03,2026-04-09_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Plumb through vfio_device_get_feature to the vfio-user server. Note that
we translate EINVAL into ENOTTY, as the existing generic vfio code is
expecting the latter to mean "unsupported".

As part of adding a trace point, clean up the trace file.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   | 12 +++++++++++
 hw/vfio-user/device.c     | 42 +++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events | 23 +++++++++++----------
 3 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 3249a4a6b6..2a0c31e7c5 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -40,6 +40,7 @@ enum vfio_user_command {
     VFIO_USER_DEVICE_RESET              = 13,
     VFIO_USER_DIRTY_PAGES               = 14,
     VFIO_USER_REGION_WRITE_MULTI        = 15,
+    VFIO_USER_DEVICE_FEATURE            = 16,
     VFIO_USER_MAX,
 };
 
@@ -239,4 +240,15 @@ typedef struct {
     VFIOUserWROne wrs[VFIO_USER_MULTI_MAX];
 } VFIOUserWRMulti;
 
+/*
+ * VFIO_USER_DEVICE_FEATURE
+ * imported from struct vfio_device_feature
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    char data[];
+} VFIOUserDeviceFeature;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 64ef35b320..b8d2b7c1a8 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -74,6 +74,47 @@ void vfio_user_device_reset(VFIOUserProxy *proxy)
     }
 }
 
+static int
+vfio_user_device_io_device_feature(VFIODevice *vbasedev,
+                                   struct vfio_device_feature *feature)
+{
+    g_autofree VFIOUserDeviceFeature *msgp = NULL;
+    int size = sizeof(VFIOUserHdr) + feature->argsz;
+    VFIOUserProxy *proxy = vbasedev->proxy;
+    Error *local_err = NULL;
+
+    msgp = g_malloc0(size);
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_FEATURE, size, 0);
+
+    memcpy(&msgp->argsz, &feature->argsz, feature->argsz);
+
+    if (!vfio_user_send_wait(proxy, &msgp->hdr, NULL, size, &local_err)) {
+        error_prepend(&local_err, "%s: ", __func__);
+        error_report_err(local_err);
+        return -EFAULT;
+    }
+
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        /*
+         * Client expects ENOTTY for "not supported", but the protocol may
+         * return EINVAL (which should only occur in the case the feature isn't
+         * actually supported on the server).
+         */
+        if (msgp->hdr.error_reply == EINVAL) {
+            return -ENOTTY;
+        }
+
+        return -msgp->hdr.error_reply;
+    }
+
+    memcpy(feature, &msgp->argsz, feature->argsz);
+
+    trace_vfio_user_device_io_device_feature(msgp->argsz, msgp->flags);
+
+    return 0;
+}
+
 static int vfio_user_get_region_info(VFIOUserProxy *proxy,
                                      struct vfio_region_info *info,
                                      VFIOUserFDs *fds)
@@ -432,6 +473,7 @@ static int vfio_user_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
  * Socket-based io_ops
  */
 VFIODeviceIOOps vfio_user_device_io_ops_sock = {
+    .device_feature = vfio_user_device_io_device_feature,
     .get_region_info = vfio_user_device_io_get_region_info,
     .get_irq_info = vfio_user_device_io_get_irq_info,
     .set_irqs = vfio_user_device_io_set_irqs,
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index abb67f4c11..84714781cf 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -2,19 +2,22 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-# common.c
+# container.c
+vfio_user_dma_map(uint64_t iova, uint64_t size, uint64_t off, uint32_t flags, bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" off 0x%"PRIx64" flags 0x%x async_ops %d"
+vfio_user_dma_unmap(uint64_t iova, uint64_t size, uint32_t flags,  bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" flags 0x%x async_ops %d"
+
+# device.c
+vfio_user_device_io_device_feature(uint32_t argsz, uint32_t flags);
+vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
+vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
+vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
+vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
+vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
+
+# proxy.c
 vfio_user_recv_hdr(const char *name, uint16_t id, uint16_t cmd, uint32_t size, uint32_t flags) " (%s) id 0x%x cmd 0x%x size 0x%x flags 0x%x"
 vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
 vfio_user_recv_request(uint16_t cmd) " command 0x%x"
 vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
-vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
-vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
-vfio_user_region_rw(uint32_t region, uint64_t off, uint32_t count) " region %d offset 0x%"PRIx64" count %d"
-vfio_user_get_irq_info(uint32_t index, uint32_t flags, uint32_t count) " index %d flags 0x%x count %d"
-vfio_user_set_irqs(uint32_t index, uint32_t start, uint32_t count, uint32_t flags) " index %d start %d count %d flags 0x%x"
 vfio_user_wrmulti(const char *s, uint64_t wr_cnt) " %s count 0x%"PRIx64
-
-# container.c
-vfio_user_dma_map(uint64_t iova, uint64_t size, uint64_t off, uint32_t flags, bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" off 0x%"PRIx64" flags 0x%x async_ops %d"
-vfio_user_dma_unmap(uint64_t iova, uint64_t size, uint32_t flags,  bool async_ops) " iova 0x%"PRIx64" size 0x%"PRIx64" flags 0x%x async_ops %d"
-- 
2.43.0


