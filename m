Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFD4C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uADIT-0007tQ-UV; Wed, 30 Apr 2025 15:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIS-0007sX-EK; Wed, 30 Apr 2025 15:40:44 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uADIM-0006CO-Rk; Wed, 30 Apr 2025 15:40:40 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UBU2qB020471;
 Wed, 30 Apr 2025 12:40:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=x04Hjy4po/YszhwNxQA3sSqmcQf8X1dCG/9HUs9rA
 bU=; b=m19QNlcwcbR7yNa/lcHKwlnF9Q1a6RuF2YaypN/cr9gxBPEE1QyIl7u0/
 r1ZzyNu633PCNnge9T/ek/wiPwYKDBg0XfyS8t9KbpGT4qx2F7wfiSiTgZHWc+ep
 tHILs37n9runfwYSCjZBjyFyj0iGl5gCgm56a8ew+CmqiPLP53RsDb+7Wb4t9K+7
 JzFi6jDLiBZnPTqPc35ZDGwu/v81/7CgyOn7yHeCN8c2du9lHPm5me9rai773Us9
 BCM+iSN0HjeO86Fh/phLJeo0NR5En5OFR0qY5Zf2H0EOEKzdp90XdbWO9jrg8U0l
 Jqb4qaWItyDdELvtEz+xWYFfqIzNw==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010021.outbound.protection.outlook.com [40.93.12.21])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 468w182476-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 12:40:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/0GBSbg09LwouNgtgcqVpUaplSFWE9rz4+2S7k+ZrS9pQw8BxdpeAy8cE7FBjDezRz1bnTg7cY+tAvZ2cHgGUX7oV5ffAfY69yWGdMd42Ke74skQ1AokTI/uRVTlo7PvBlT7hCpbEKRQnjRwZOzacCfLlbIskcDwEZfHjTc9qmUL3vxSU7cb8113sjPyzhX/1uKFkRJuu9JjmpMSr+wbZ0vAm1cbVkWlpgUP0DXnWkKWyqHtZ0OZlP56ugkDZGWw8cwFY9ZmSLM01R/OGXIoUUzFDTU0UhVJkR3ARN2n+4z9V0gf9usuq31s3UnSwqHFXhZbehz3SK4gFXnO6vYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x04Hjy4po/YszhwNxQA3sSqmcQf8X1dCG/9HUs9rAbU=;
 b=vCUU6p9S6tQ2MZCyoRFrB5LtcsR9MDvvoNOw7PBYhLKQAyE5eDV8qPoAAQxSo68+vaPS/0NCwSo1QC9vEXm7A+dxr8u9juls3Dpz5casr3jt2zdO7HU1U3Pwg8wHyyFKeyD7hVBZa00Cmo/kjyTzstMlolUsJ2Co0X4hokTFuNjSSD4gHKtQzbL0N2hAcV+ASv27RpOSy62FMnnI1idUsBc/mGBikxdhCa9isxfyH+uAPsWha2/CgC2mXk5pK2+pDmzr9RIjFqy1I3onC2w3p2csKLpE4GEZNp3mplGnZE78w4+IQ+9+eucgBRJ5XONeM631snTnRD4rWZg81FnWTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x04Hjy4po/YszhwNxQA3sSqmcQf8X1dCG/9HUs9rAbU=;
 b=ErUGuKXzZh7qSZCUKlKmx/PmktYRAcsatrwKXQwzOgjUfaT75yaLGh5Ude0+yzG9pvbpIKxiiEoZVP/2cjLnOaTEZwEgmo0ZMQYdpuO6CGTWRxGI5tOUjvmUOfCgbhY3XcmXSl/1/VfVMqkB/1fMb6Lgubiw5OOfE9R5Fm6O+qF89Yj4mYnWouXxED/kvGvKQ9Ch5ZT5TW1kc9oqVH1MHjIfc6ymqWQUFjLZ+CepZ6LjxGhkupv+jYocCy04wzr56Ysy25IQXQ01MDIX3dX30s/0WbxyO3k4FSUOLU5IPBbNg+dMp3bHEnTbZKfsFuZytICib/OqW63hRCO0YMVR1Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB9931.namprd02.prod.outlook.com (2603:10b6:610:177::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.9; Wed, 30 Apr
 2025 19:40:32 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 19:40:32 +0000
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
Subject: [PATCH v2 07/15] vfio: add vfio_pci_config_space_read/write()
Date: Wed, 30 Apr 2025 20:39:55 +0100
Message-ID: <20250430194003.2793823-8-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6c0807b3-c486-46d9-1961-08dd881ede7d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ukGk1PboKdFmH9Yjc5oI9OHqi1YJrPg9vvk/NbkcEkXEOwz+NCy8JuyKtUux?=
 =?us-ascii?Q?sozW59bqQKIeVlEwdu+nQUuW7SZDVTZpUQg4NXsvtdxAsMhaWQ+H0TZLeKwf?=
 =?us-ascii?Q?uS763CSbEii2/nojHwvhvjwXB0ZWd6B/QhJdWpcZ32QQHN4+wMuzrjwQhRqj?=
 =?us-ascii?Q?H5XyHne/2ZBolJDtKM5eKSjBz31yH3UC0D+2jYiGDFkSkrIuljX9KYlb+st0?=
 =?us-ascii?Q?uKkQQGtpDUGKtWmM8izOKrbLfRETz7hCXiC1cUB5678aLBIr4OIpXM1o6lUn?=
 =?us-ascii?Q?/cdpOtnCVgKGzET0O6cOzomEDHcRYBasOgYqk/kPxCQ9IsRAFIRCb47GedTt?=
 =?us-ascii?Q?O+w0XG/3vOhIGQxTkHHeZ3fPWUaH/pk7jb8b3csw8xtfATLQnBvpZjSK7HXK?=
 =?us-ascii?Q?K31rfXi2BjQF9ImbXnJkjemDIWPBwCYngvplujqYnn0S4fk1sM3b9pT+5lez?=
 =?us-ascii?Q?dVzEKrX03jFdhRMG0j1rq2edZqq8E+CVoX/702DaxnMSBKMLFi1UlCft84a4?=
 =?us-ascii?Q?xfEaULnSdw31RNcpa4nmVUp4vQ83jVG/VBKZCZl6gDxavJ4C1eH42nS4Cq9Q?=
 =?us-ascii?Q?DRgW64OwYv7BVF3z4A23qEooMtFTJwHuAqwlY5bxBih0QYSs7fPYUPTsopYA?=
 =?us-ascii?Q?xXE4X2H1IOYVkfTqIMBRRdrV9nLu797DeL0MuLBhr4corAMiVsSxDuzmIvTU?=
 =?us-ascii?Q?LHIJQck7vZd55pP3EEOnv2sKu+Y6oYIztAes99Fr+Wil4sttqWPl1PBx8kKo?=
 =?us-ascii?Q?TL6Sv/xg+n5nmw1FRM+ES6ZKOuJI8+c6D42FpSncGzZyw72Jlq0NjBUAXwAq?=
 =?us-ascii?Q?lmC16I7P+qCMEBfp0veoX7VYAf/FVUwRDBT+NNI+6WEf0Vu9zI4aWoco2H2/?=
 =?us-ascii?Q?HI2RxrSgPQjdoir63nzRUQx3Ek5Un2Yu5uO9KsfayH3azl+UYv6nlpAZU4MY?=
 =?us-ascii?Q?2EGF3pHIuRrTTFkv5k9UcRggw+XVGWFjWjxb8NArJD6a9At1BgKrIH35wvoH?=
 =?us-ascii?Q?FVtuvojloEz0fN5UqPebKiZjmSscos/IxAyYnyOYoFyzkL+9T3WC+qPr2w+t?=
 =?us-ascii?Q?M32H/20ApuHzfbUQiIBsDph1jhJ9+X650LogS1Drttvdrbs7ir03M4SMAlUv?=
 =?us-ascii?Q?4Bmxt7tyhylTKDs5AmzhAJ8Dl6RRUv3DInYrMFv46gz/NacTq4HmuhAopjZw?=
 =?us-ascii?Q?wVwLdCDL6kRRgUxBqFM+tM0e1JuUdikgWHfLqLL149mzUWZj6BNRNfe/FLO9?=
 =?us-ascii?Q?NW7PVAk1gXEbxud1+uw8vB4DQeYc1Ruper9xrtVwppWKDKfZAFX+Hh3+8Yq7?=
 =?us-ascii?Q?Y8UM0zG6eF9hhT1td56+ch9eUVekR94/IpsbdJPnGJ1iQV9cHhVAB4MjjK9A?=
 =?us-ascii?Q?RW02iIERRcpGuWFzpciMHCfmQPXeh9r/udxde3YznUjyTZ5Pe5FSfWajEa1C?=
 =?us-ascii?Q?gL55FSyH2cA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QdJlwgDk9st82QtPxfSbGmZ7cLKG3KQhSDExcp/bxEAYiJ7B9xU8IH654W/f?=
 =?us-ascii?Q?sAiI+PKvwBlZLH1rmU3TC/41dgAo2Rqj9knoKXCTXOrmtWBYsTud1PM7Pkky?=
 =?us-ascii?Q?Rf8SJPC0wDzM9/gM3+b4q90BZByWeYXFSSKPX0Rqaof2B+lfLe67uUq3+7Ud?=
 =?us-ascii?Q?0WMB82PD3YUStzVVzpFgeDbCUcu4eFXjQMxl6vJkWlJHrC4RK81ztJg4/hQo?=
 =?us-ascii?Q?r/hGqztCY32wqDQ9vJnWpyCP4+79JNu81ncZDAloXdQELD4C2DfEIc61slnM?=
 =?us-ascii?Q?h9ityH5CseWpk3HPYrXEhmyWFaPnga5Pdm5SL43Riw9XnqsT9jMRnPcR2Xza?=
 =?us-ascii?Q?WrmYWNy39OxeAxslY6ooZewpTI2zehmlSEolkUEi0jqPR+imnhgxamkiB1Dv?=
 =?us-ascii?Q?7wacIadXOcBDq1zoR8jHvyJGXNjTOyLKlsv4FpvDSSjPP+JWGwWDWstRYe6l?=
 =?us-ascii?Q?8yGD1k8MjtQmg8CS3n4SbMf/6gUUCX1SVADFv1zlRttCr/qeCBnleMn1Lhgf?=
 =?us-ascii?Q?FXceADWCWyYDUUJ2f94mhaEJFU6REwusF1yQuU6ltNKHLNGxT4oht9SxX7bJ?=
 =?us-ascii?Q?1PeqiyOQ9AeLK/4oBdioy+SVBomiJQo72AMHBtCIgOp3GOuIkR8XPtzJCsGt?=
 =?us-ascii?Q?PYakVgRGqQETf/oAtrZ0JhG/Ck5Hdrwuvpe09srpdm3GrihPeuFPeCXt9T4l?=
 =?us-ascii?Q?cMKMWbgSipR9Nokt7nUnXyrxaaIGl87pXZOJlgfBvNnCYXCE02kZ66VPwWEr?=
 =?us-ascii?Q?QUOLA6A1OTGma/qKc4degqBixolJpWORPAk8RwHEhzw2NSCIEUpE18/s7YlJ?=
 =?us-ascii?Q?fZobBNlnRDEKR0rEEgEyU57tHlA5oFh35+xgT3g9qCAW8xxUAEVP/Tm+x1nT?=
 =?us-ascii?Q?YfZjDb14dzqyxWR4aArUfG3c83L0CvYmirg3+I/egv1ivYb5kjgu0mB3a/zS?=
 =?us-ascii?Q?L1ff4T2OnBQaAG4L466kr6wCtjEpizYyIpLCy6P0holOwTGY41wWqlwiODwo?=
 =?us-ascii?Q?hMKualkfep6MTpFOEOxTKCE2ap6ztlzXSsU0db+Xy9aDyukbFMgHV0fpeClv?=
 =?us-ascii?Q?i/W/We0uS3b7cdei91d6cVYiu1m/KfTdl9d+svACHhQbUs7NU9g4pwfnAxCv?=
 =?us-ascii?Q?bOol7QQDH6ao5hYNgQG4ui7L2rM6N7XQCAMO0xKl4uXKvjXRPcUSMyi23iN4?=
 =?us-ascii?Q?jdaDTOIlalRY1RRXQVnDCPgn9yRKauhKH5HbF4eF5TqQLuUtb2S1Ngymxhgi?=
 =?us-ascii?Q?wGLoNJy6vVoQ34UVmn8CGx1fE/RhzD2ortc8KUbowxJLuWDQsuhXZHCbkWFT?=
 =?us-ascii?Q?MuA9+eR0iKeJXvGQl/CI9nLmrz4aa9bsKeW+lieH+f65yH3XD/lvQxah9ix8?=
 =?us-ascii?Q?aN088O0WSoCwt/JUWnfjK5eQhtTHGphKkKSWJ5mrOsX0aL6bqb4FMbIH50f5?=
 =?us-ascii?Q?WZhfs2d4a/NINWUdwUf/JUJS+un0dct0sT7NmT3xxlz5oV4fW0WgCVSHLKFI?=
 =?us-ascii?Q?uKr29P8jo0lcuPxpPC1oNKqPl8JwX0Petq+Mw98v4iAofHqIx0u+D1woI8wy?=
 =?us-ascii?Q?uff6YVSWtA+hMUaA9ed5Xwgi+O9pB3qjaYx5/YVv?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0807b3-c486-46d9-1961-08dd881ede7d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:40:32.2223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTG6B6fW0bkoh2ZXAQtXJUwuSWbOL8k0fpqxAtWV5DlhXflOBEJmFTm3KJUCq1tg6l3ity0PQGCr1KEeRg/p8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9931
X-Proofpoint-ORIG-GUID: Kvybf0QaaIRCGeb1OFEZegRRh_lnrPHa
X-Proofpoint-GUID: Kvybf0QaaIRCGeb1OFEZegRRh_lnrPHa
X-Authority-Analysis: v=2.4 cv=VITdn8PX c=1 sm=1 tr=0 ts=68127cb3 cx=c_pps
 a=6dLVn7RwcbTzQ1hpYGxp6A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=uWZQxr4v0eqUK10gj4gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NCBTYWx0ZWRfX+DjOaTJcR4nJ
 oDw2PrsepWFMUNq0AN29f7mJ0Z/XLSNXwe89N9cSEdwsDojdfWi6Go6nL/zZzH4d8znGpkX6AF7
 ZeFFun6f7QTl8qadlI90hjutdSC6nbPruXbN4c8eAUSnmoGeV04nUReva5/DSGwxMdQkT6vr2t3
 uCGeZeIkFt9fmoshFxGiTt5CXVHO6PVuhDMxlIHd3tp4oyOhT4yVtJsK16RgEDPYXVfbGq8Cv24
 /QTn9JPpj3QKKovnwu5eG6qnOCWlsFDCWR/c3d2ArUKXrzSiT4pYpKscExWvw0bh2wGAW09zCSK
 4KwHHSxssomvevJdyExCTo/carve0w85xA0Ywi3UUtKrNf1nwwDm+B8rnotmOJnCAOGcS0Uy8Ff
 qi827qaUtEqOAKlKacj8j+h6kbKyhkO9zfnt7omDQMVSeVLTV2ZhtrZSPfEGlrqfUS1eWYSf
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

Add these helpers that access config space and return an -errno style
return.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.c | 123 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 80 insertions(+), 43 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 768c48d7ad..8455010d62 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -967,6 +967,28 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
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
@@ -1019,10 +1041,9 @@ static const MemoryRegionOps vfio_rom_ops = {
 
 static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 {
+    VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
-    off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
     char *name;
-    int fd = vdev->vbasedev.fd;
 
     if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
         /* Since pci handles romfile, just print a message and return */
@@ -1039,11 +1060,12 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
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
 
@@ -1223,6 +1245,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 {
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
 
     memcpy(&emu_bits, vdev->emulated_config_bits + addr, len);
@@ -1235,12 +1258,12 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
     if (~emu_bits & (0xffffffffU >> (32 - len * 8))) {
         ssize_t ret;
 
-        ret = pread(vdev->vbasedev.fd, &phys_val, len,
-                    vdev->config_offset + addr);
+        ret = vfio_pci_config_space_read(vdev, addr, len, &phys_val);
         if (ret != len) {
-            error_report("%s(%s, 0x%x, 0x%x) failed: %m",
-                         __func__, vdev->vbasedev.name, addr, len);
-            return -errno;
+            error_report("%s(%s, 0x%x, 0x%x) failed: %s",
+                         __func__, vbasedev->name, addr, len,
+                         strreaderror(ret));
+            return -1;
         }
         phys_val = le32_to_cpu(phys_val);
     }
@@ -1256,15 +1279,18 @@ void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len)
 {
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
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
+        error_report("%s(%s, 0x%x, 0x%x, 0x%x) failed: %s",
+                     __func__, vbasedev->name, addr, val, len,
+                    strwriteerror(ret));
     }
 
     /* MSI/MSI-X Enabling/Disabling */
@@ -1352,9 +1378,11 @@ static bool vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
     int ret, entries;
     Error *err = NULL;
 
-    if (pread(vdev->vbasedev.fd, &ctrl, sizeof(ctrl),
-              vdev->config_offset + pos + PCI_CAP_FLAGS) != sizeof(ctrl)) {
-        error_setg_errno(errp, errno, "failed reading MSI PCI_CAP_FLAGS");
+    ret = vfio_pci_config_space_read(vdev, pos + PCI_CAP_FLAGS,
+                                     sizeof(ctrl), &ctrl);
+    if (ret != sizeof(ctrl)) {
+        error_setg(errp, "failed reading MSI PCI_CAP_FLAGS: %s",
+                   strreaderror(ret));
         return false;
     }
     ctrl = le16_to_cpu(ctrl);
@@ -1561,30 +1589,35 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
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
+        error_setg(errp, "failed to read PCI MSIX FLAGS: %s",
+                   strreaderror(ret));
         return false;
     }
 
-    if (pread(fd, &table, sizeof(table),
-              vdev->config_offset + pos + PCI_MSIX_TABLE) != sizeof(table)) {
-        error_setg_errno(errp, errno, "failed to read PCI MSIX TABLE");
+    ret = vfio_pci_config_space_read(vdev, pos + PCI_MSIX_TABLE,
+                                     sizeof(table), &table);
+    if (ret != sizeof(table)) {
+        error_setg(errp, "failed to read PCI MSIX TABLE: %s",
+                   strreaderror(ret));
         return false;
     }
 
-    if (pread(fd, &pba, sizeof(pba),
-              vdev->config_offset + pos + PCI_MSIX_PBA) != sizeof(pba)) {
-        error_setg_errno(errp, errno, "failed to read PCI MSIX PBA");
+    ret = vfio_pci_config_space_read(vdev, pos + PCI_MSIX_PBA,
+                                     sizeof(pba), &pba);
+    if (ret != sizeof(pba)) {
+        error_setg(errp, "failed to read PCI MSIX PBA: %s", strreaderror(ret));
         return false;
     }
 
@@ -1744,10 +1777,10 @@ static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
     }
 
     /* Determine what type of BAR this is for registration */
-    ret = pread(vdev->vbasedev.fd, &pci_bar, sizeof(pci_bar),
-                vdev->config_offset + PCI_BASE_ADDRESS_0 + (4 * nr));
+    ret = vfio_pci_config_space_read(vdev, PCI_BASE_ADDRESS_0 + (4 * nr),
+                                     sizeof(pci_bar), &pci_bar);
     if (ret != sizeof(pci_bar)) {
-        error_report("vfio: Failed to read BAR %d (%m)", nr);
+        error_report("vfio: Failed to read BAR %d: %s", nr, strreaderror(ret));
         return;
     }
 
@@ -2450,21 +2483,23 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
 
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
+            error_report("%s(%s) reset bar %d failed: %s", __func__,
+                         vbasedev->name, nr, strwriteerror(ret));
         }
     }
 
@@ -3101,6 +3136,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     int i, ret;
     char uuid[UUID_STR_LEN];
     g_autofree char *name = NULL;
+    uint32_t config_space_size;
 
     if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
         if (!(~vdev->host.domain || ~vdev->host.bus ||
@@ -3155,13 +3191,14 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
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
2.43.0


