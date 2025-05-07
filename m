Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5717C3ABC3
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCgaT-000521-Qe; Wed, 07 May 2025 11:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgaG-0004oS-6l; Wed, 07 May 2025 11:21:21 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgaE-0005un-7F; Wed, 07 May 2025 11:21:19 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547ALmwx025335;
 Wed, 7 May 2025 08:21:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=kKl+r7dGbt+a7mtZZmbGKc+Cz4Fe+KsxEnA/R32z0
 78=; b=SzVRLxBjtV2af26zew1CH3w1LnP1NjIiA9Bkl9fdSqzjM3NT7e/B2HcPP
 8rWEMIzJ7Yi/6cReHKtEUML+CUAwg6UfQ7DoKVv0zCXWQuNFHuDwqB3i/KopOOcK
 zxWCdguSuWUBBzxQHG7G2t8qvsUz+TgYNdOkSO5wEiLLHRemYWRaiaDS3ggeELX0
 kC+SyVcEVVeY3DhCYlYDb87yR0F5nXFaXrdRYUHqg4O11HXbg4V9s0hWV+OZ0ju5
 6DZjEwlCG1t+qqumEQ8cDFVzxZ/uRBnW9KvUySMDPL9v0MdDl9tNs+D/nELDCsrt
 TOU4butW/gyAX61efmJ1sey6W/cdQ==
Received: from cy4pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17010006.outbound.protection.outlook.com [40.93.6.6])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46dgp91ekp-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 08:21:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lj1ClUZjsQmYohnGZQEsqB3huRbrQoyi7RMKAd0DyxPMfFjrI24UTe0jAf2BGEvWhS++68AHlruNF5ZoEdwFolpUYBN19PpAkSxomSEB+LIkw2kiDG2giHfDsgFpkribqrdqH/EIZb7eb3YOQix4LGzsjjNvKi1rRjEKuW7z7BHnXAznqf2ne+N5dF1/Sz6lSIQA/9XcMfOYpPs5365QavNbu34wryqh0yCk0oUS95JVgyeUctOPNGJiWKyKNc+IOgQsAss7+iNzDjgNpujhqNwczxr9xU/nPVUkm29xLmS7tEGm1bBvt9sZCcxIAO8gP4+7QfyBLnXbDyjm3t/Gzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKl+r7dGbt+a7mtZZmbGKc+Cz4Fe+KsxEnA/R32z078=;
 b=meVaAuuFlxGEfXxlkfLFhGj/CpqhYr9xC5Tbzx74xpWOJK+ExnRlpMY9zUg4zv/cIDX1Cejk9FOdgRSD+/ZYsUvCrQTvRWN8TcykSSodK3Ufm/HVlI3PBrQEh65gIrhRq/OVukAtH5wpqOpP6MgXV/j/vcDitoq13rOiLLgLGi01xBjbX297FT0WJX7/ij0ocgpRsg1qZsiNKHcYLUY61/of/DaZW0rf2Vk6FqjFOnt0lFMcAiMJcpmw3Q2NY1uKmmA8JZ/k5Uj56KTGAryCdzGtEt84YA7DT96cFFyhGN8SQ4A5Jjyoiwvvby4YYEjT8+skngGK0hCz/Z6bMhjiDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKl+r7dGbt+a7mtZZmbGKc+Cz4Fe+KsxEnA/R32z078=;
 b=aR1jzOwo9lZFIyKvmpTHfOpAOJIJH87o8w4BSHkC1SrgdRqSQPpukEMuJ8n2qT5dYvwuN6XIt0DUFGIqRmK3LTHSZcHoVFralvt6HNlcaQr0wl7RHFv7jgXKbBQOOuGGxeCoQuz9aSb/UVH6Ps8GvT0uaASu8UqOHs/eEbKcx7XNAbimbQFA/4OoxUXUL4n+HhR7xlR09RfZryNZ5zjYH0vLLqeuOeVQetJZP/LrxZPVfQWX+M+VeLYGMoF/tts9s5s6z/TRwZSL4i2XG/OI54/AoyaxKe4Btt599eKLw/xYF8lIp9GpzBx3bGBgLWi2Ye7860VG5Z3fKEKhoV9/+Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BL3PR02MB8220.namprd02.prod.outlook.com (2603:10b6:208:342::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.17; Wed, 7 May
 2025 15:21:02 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%5]) with mapi id 15.20.8722.011; Wed, 7 May 2025
 15:21:02 +0000
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
 Jason Herne <jjherne@linux.ibm.com>, John Levon <john.levon@nutanix.com>
Subject: [PATCH v3 12/15] vfio: add read/write to device IO ops vector
Date: Wed,  7 May 2025 16:20:17 +0100
Message-ID: <20250507152020.1254632-13-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: fdf5f981-b88c-450b-547e-08dd8d7ac714
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bK3Jvhkbbhv9lDjslYisKNacq8I1c8tmiGHMmESEqnqzbT3volTrKaeMH6DC?=
 =?us-ascii?Q?7EwwaPe26Jl1THx0NIE/LjwQLyM7C+sgc2X0f06RM8EDvKSoExGRKigIwYPV?=
 =?us-ascii?Q?4eUgqmDUU2EiS5G4Xh9+ZxBvIYXMA8cAizDrMqvgWpsOvCBIXgkr75EfHl/c?=
 =?us-ascii?Q?R47EieTvsh3knXmaJHCV2/W3RjQcM94dDcVxUAMwdD7+GT2/D1wzT61psXx1?=
 =?us-ascii?Q?mMoP8Nm8LOmAeL21/11YmU/pdYOooLFB21Yh9A/vPIlUwtSUUMFE4x7Mqkkn?=
 =?us-ascii?Q?hn/aqV7b0KwX/V4BC0dXbJ+OkS2AyDY8qWqySD4JX0rzXOhw/W1HUbzVo9AH?=
 =?us-ascii?Q?lTDQYNz7d6Q2Ic8/YvDXZy+VLbprotM4f6AhUfI2cj3OJ+bua6YrPByuk/ii?=
 =?us-ascii?Q?Jzi8dAMtu1FdQCMwmYleQLl6/yB7VTBFuOA5Zz5VHclJXGBp1Ldp+s+hSjch?=
 =?us-ascii?Q?UCtWnebFmCAX98SImHrVIxWrhMCKEHB66IdXuBUeebMQ8xDyL0L81n2c4uqW?=
 =?us-ascii?Q?JfhYeCq6EbGBNPytbi7C1seeHyWw8NOJGejJDqUy5NEmWgsAqSXltN6ea6F+?=
 =?us-ascii?Q?RvI70qZuUd66Ya7RYJzYZFK1uevtd7zrcqxFpdwRHFR0HbqGSEaM/16jhn7d?=
 =?us-ascii?Q?Ocgz+T9BTlw3tDxuJOs5IOnHs8Ru3JLz1EfoH/xyqdXcWOeZfOtkUM6HZYz5?=
 =?us-ascii?Q?H6RE3fZ0TdoGv32lraeg2wL5aB+r/uo93dyKfUJz7xGx3cEoLNnq/ls1F/S+?=
 =?us-ascii?Q?FH3b8O7OxcpLJ1s2M3jYywHtZOnQJlct2Fg+RTkeO7hjI5eoMo+eyF3tmGba?=
 =?us-ascii?Q?37IxwiByqIa9Tma2CyrpJqbGlx9wOZwvb27ibBCVO3Qc+XqdkxuBjmxml3A+?=
 =?us-ascii?Q?R8TsQW2Txon9+wF8qAth3iVwPEMqGmDZPuxIELMpZ3lrLjoXfZS7tpkoGrnK?=
 =?us-ascii?Q?K9JqdXNNJijoJhB3GvOKTTL0PH8KKuapHe/tPNXxXSCDIZ3OmbEHrOEwKvCk?=
 =?us-ascii?Q?j+ZOI1KOWYiEFGRMbv3pmsI2gQxTPeZCIrHwl4aqboCLleggfZBg81DUsDRj?=
 =?us-ascii?Q?6XFeYS3dyq1tNYMSSoenuZXhLdCYJ0ryfxkcC0PvbuU9zrEbFmB5IkywTzH2?=
 =?us-ascii?Q?hYCiYZ95yhq3oq4Ui+DlLGiITlXDMGB6SPK8Yos3qZZ4260mwcM6J+0HuCTE?=
 =?us-ascii?Q?bXQk1jq1EUjlTTTiQ6cChB8bpO5ARlzfyO8qlzuarsFj/qdVp3+rz1ijL/ga?=
 =?us-ascii?Q?99rFimmoCncPQHaDLh0YnWhWdfbiRSabOw8tbhupe3GnQV0rbJ7SRQCHOunn?=
 =?us-ascii?Q?iDa2D2ChQxvB1TjjDyPWkFtMOUXw8qSm+rT6+l03naJw46KPWPaHSSYjBAuA?=
 =?us-ascii?Q?OLdyfKPsWgQNb752Gzd8/MAbAe3PwlP+s/kMwJGO6y9h/eHuq9wAknEUS8HT?=
 =?us-ascii?Q?3AKcav4PNqw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rVBjosMkpz4NH+cA8LrGsk4nltn96HTCaaFGHZd1xrMRuMa3OHqofJxCSJlJ?=
 =?us-ascii?Q?73m4Di/fjc9+X0Uxvd3/9I5RANucHdqyLEIP7w+3mRiMwbbFnODJ3UjBnpDR?=
 =?us-ascii?Q?3DmDDJ19Oo+uQ+QW7wJzACdkezr0nuemBppUGH2zn16F9shAmQyP8Xp/Pxr0?=
 =?us-ascii?Q?5LIwThGNZIbygTeD8lZgKsnoFHQTzJPoLKIj6z407d2EoOfK41x5mQyWRx4z?=
 =?us-ascii?Q?ya8ZU3mS+uufyRWUNsAh2wU1XU8agF68M52x1TuaPW2KPed91ITxNDVd3T6V?=
 =?us-ascii?Q?18NqJwmXyDqVIUcpRTf2b35/n8Em6vORVnvSJ4QTftqojQtte3ZZ5yv6Mmul?=
 =?us-ascii?Q?I07cvQRBtr252Nrxb4B7Lx1PJfqbb1XRBBlY4s6tP+NzquHnB1pCmD7reSnP?=
 =?us-ascii?Q?DYWzRlYjTr9Y6Ue8mSNRyIlQxYNHqcjvjaNTuU+ys3/Vl4IY1XI/JvAE+0UZ?=
 =?us-ascii?Q?O4Qf2I5/VztBKv/b1HqZ/zkbmlZP0AyD6KC3tq4DrwYPi8UHUuxIOhINpV9u?=
 =?us-ascii?Q?fA8bNQHUE/sehAD0s4s8UqjP7gHak0fp8I5iQ9nW67wYPkepwdBv6bye0IPd?=
 =?us-ascii?Q?1jOqrZfaf+2Nb4WZn5AR8w991Hz+WZpkOe+bdYmOvyzBAquZoNnt7bdKTWQ5?=
 =?us-ascii?Q?o64HUgKZgSJHi+Cb59/ux9e2W6mTbnRAd0mBWgfSVzT3Cy7wJRv2b2PUrMoO?=
 =?us-ascii?Q?qEEfbQ+I6Imp2BSj5f39ibhuJJj/WLzx444Gsx/jQed0+qMIiaZRft1+EaOJ?=
 =?us-ascii?Q?wmH5YhbMGCWfp/4xMG9aZtuZNhuWXEPdBNFDqdCwTGZafXdiv5QY1tmfFvPM?=
 =?us-ascii?Q?uBpPH2LFNeZ9rapT6KckyI6RyOkwq5PZY/QG6+42R0mdyH0y87BZ5OVsIStM?=
 =?us-ascii?Q?uXZPVJ0Jbp7spnn85c0wlvezkKfBW/tOJlCJbrM04hwm0HsGYVpaXKUbWUvx?=
 =?us-ascii?Q?JEScpqSDyW0FaJEffzThkCTlqs3KHZKGb8W2KC+8h/f6Xz2Q/SfhgU/pwAom?=
 =?us-ascii?Q?qKjtaOUuOOlv09DFAt56UHWyv2SMdW3ZeoJ+ANygPfRNTbgqri1pv2rtiNrG?=
 =?us-ascii?Q?rU8MqQd14aSEgW5LrTIb4lD/X7/EiBecqI9Ns5D8AqLGVkS9UsJi3WnA0hFd?=
 =?us-ascii?Q?p0NGr8MLomJTz+TJTFVByLsQW+fl6AvTbIe2UpWFL6CWLOo6yZ3F272ZAaoJ?=
 =?us-ascii?Q?pApNaXpdkWzlS37Z5uzzkZWZM/dGgHoKya2SaWJf3G5Z3KQ0DVQnxLipd2Nu?=
 =?us-ascii?Q?B3k8pYnn2SE/HUf3AErgPDpkHc/9+yQEysfJiB+4EwpayNFPHJ05PwzC0fkX?=
 =?us-ascii?Q?Gyy7j1bwrLc543S1kyK7oobRe15QtPB4HxUd0UWIy56biCB1S+AHZEVX5RWl?=
 =?us-ascii?Q?RMIUax8BeJ1WFMCYyA4qSZboP1Bnop3jddLlmwvmFcuMvA0gpWc/Hp2l/ag6?=
 =?us-ascii?Q?cfBd2Bw6BWlCh+05PYvXWAs/3JNQHSD1Tg5+7gFid8kTbTV2tkHNHL8T6rlZ?=
 =?us-ascii?Q?Wu6jN0Is+uzLSOL3f4qC47bfGN/n3H1rcad9TMaf2C8XHseedYNq3SRJ8DSz?=
 =?us-ascii?Q?Kdvv3HJM1en3R5hM79vkS2ibZkSDCp0RLuVFaYfN?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf5f981-b88c-450b-547e-08dd8d7ac714
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:21:02.3424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSG4oMydP4Q7V/RMHQDurk9/YPIEVqTzeB+wPbcJotFFZDcrAX6FVsSZ1wxahsQyvMvknx7UTjhbHwwBgreu2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8220
X-Authority-Analysis: v=2.4 cv=R6cDGcRX c=1 sm=1 tr=0 ts=681b7a6a cx=c_pps
 a=ox8Ej8V6LcPVg4qe/Ko28Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=YUCnVxA6LD9_ozL8f6kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE0NCBTYWx0ZWRfX7GeTmyTRVRzg
 Ai0LhyUk5p4vEWHwUEyC6CoGf7gjyUyLDUjnd2GetyhtevWXVz4y8Yu9VZaMdZsn/0PqE1mYXB0
 6zWuK7kjkf5oj4ybWvTEN5fYbccodvNiWT1Bnms2lOj+qQRD4sTM7maTn9KzxMAfNJVbDpb4M2M
 3rat3/weGVnRd2Au4wUQnGZzgwZejIdII1KYkboUhIYUID80f5My7pstyRdWeaExNYdDGWscRvh
 TQvGRi3B+u7SVbCZNmu6e93YZAA2ZWSd3ixYbK/O6yDh/OftPXAn7q9/zlu6hgOkPYf9VBu5XiN
 OsFNg1o0fynSSf10+2ah5ReC38XqnsclBpueIJH3vLlX8t9p8/3FN+NDDn9cSG6heQ+RkxLsThY
 QxCP7yZIsFv/bI6+uAG4HLGeFzh/Np2IL9y3uP/mmHpVGhpJTe6RbRTpRM9raon6AJYaay7b
X-Proofpoint-ORIG-GUID: 9Wy-KS78ZJUU138Ow_hxZ7l_8qTBebKV
X-Proofpoint-GUID: 9Wy-KS78ZJUU138Ow_hxZ7l_8qTBebKV
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

Now we have the region info cache, add ->region_read/write device I/O
operations instead of explicit pread()/pwrite() system calls.
---
 include/hw/vfio/vfio-device.h | 18 ++++++++++++++++++
 hw/vfio/device.c              | 34 ++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c                 | 28 ++++++++++++++--------------
 hw/vfio/region.c              | 17 +++++++++++------
 4 files changed, 77 insertions(+), 20 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 4fff3dcee3..8bcb3c19f6 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -188,6 +188,24 @@ struct VFIODeviceIOOps {
      * Configure IRQs as defined by @irqs.
      */
     int (*set_irqs)(VFIODevice *vdev, struct vfio_irq_set *irqs);
+
+    /**
+     * @region_read
+     *
+     * Read @size bytes from the region @nr at offset @off into the buffer
+     * @data.
+     */
+    int (*region_read)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
+                       void *data);
+
+    /**
+     * @region_write
+     *
+     * Write @size bytes to the region @nr at offset @off from the buffer
+     * @data.
+     */
+    int (*region_write)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
+                        void *data);
 };
 
 void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 77b0675abe..0b2cd90d64 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -505,9 +505,43 @@ static int vfio_device_io_set_irqs(VFIODevice *vbasedev,
     return ret < 0 ? -errno : ret;
 }
 
+static int vfio_device_io_region_read(VFIODevice *vbasedev, uint8_t index,
+                                      off_t off, uint32_t size, void *data)
+{
+    struct vfio_region_info *info;
+    int ret;
+
+    ret = vfio_device_get_region_info(vbasedev, index, &info);
+    if (ret != 0) {
+        return ret;
+    }
+
+    ret = pread(vbasedev->fd, data, size, info->offset + off);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_device_io_region_write(VFIODevice *vbasedev, uint8_t index,
+                                       off_t off, uint32_t size, void *data)
+{
+    struct vfio_region_info *info;
+    int ret;
+
+    ret = vfio_device_get_region_info(vbasedev, index, &info);
+    if (ret != 0) {
+        return ret;
+    }
+
+    ret = pwrite(vbasedev->fd, data, size, info->offset + off);
+
+    return ret < 0 ? -errno : ret;
+}
+
 static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
     .device_feature = vfio_device_io_device_feature,
     .get_region_info = vfio_device_io_get_region_info,
     .get_irq_info = vfio_device_io_get_irq_info,
     .set_irqs = vfio_device_io_set_irqs,
+    .region_read = vfio_device_io_region_read,
+    .region_write = vfio_device_io_region_write,
 };
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9136cf52c8..1236de315d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -918,18 +918,22 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
     memset(vdev->rom, 0xff, size);
 
     while (size) {
-        bytes = pread(vbasedev->fd, vdev->rom + off,
-                      size, vdev->rom_offset + off);
+        bytes = vbasedev->io_ops->region_read(vbasedev,
+                                              VFIO_PCI_ROM_REGION_INDEX,
+                                              off, size, vdev->rom + off);
+
         if (bytes == 0) {
             break;
         } else if (bytes > 0) {
             off += bytes;
             size -= bytes;
         } else {
-            if (errno == EINTR || errno == EAGAIN) {
+            if (bytes == -EINTR || bytes == -EAGAIN) {
                 continue;
             }
-            error_report("vfio: Error reading device ROM: %m");
+            error_report("vfio: Error reading device ROM: %s",
+                         strreaderror(bytes));
+
             break;
         }
     }
@@ -969,22 +973,18 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 static int vfio_pci_config_space_read(VFIOPCIDevice *vdev, off_t offset,
                                       uint32_t size, void *data)
 {
-    ssize_t ret;
-
-    ret = pread(vdev->vbasedev.fd, data, size, vdev->config_offset + offset);
-
-    return ret < 0 ? -errno : (int)ret;
+    return vdev->vbasedev.io_ops->region_read(&vdev->vbasedev,
+                                              VFIO_PCI_CONFIG_REGION_INDEX,
+                                              offset, size, data);
 }
 
 /* "Raw" write of underlying config space. */
 static int vfio_pci_config_space_write(VFIOPCIDevice *vdev, off_t offset,
                                        uint32_t size, void *data)
 {
-    ssize_t ret;
-
-    ret = pwrite(vdev->vbasedev.fd, data, size, vdev->config_offset + offset);
-
-    return ret < 0 ? -errno : (int)ret;
+    return vdev->vbasedev.io_ops->region_write(&vdev->vbasedev,
+                                               VFIO_PCI_CONFIG_REGION_INDEX,
+                                               offset, size, data);
 }
 
 static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index ef2630cac3..34752c3f65 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -45,6 +45,7 @@ void vfio_region_write(void *opaque, hwaddr addr,
         uint32_t dword;
         uint64_t qword;
     } buf;
+    int ret;
 
     switch (size) {
     case 1:
@@ -64,11 +65,13 @@ void vfio_region_write(void *opaque, hwaddr addr,
         break;
     }
 
-    if (pwrite(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
+    ret = vbasedev->io_ops->region_write(vbasedev, region->nr,
+                                         addr, size, &buf);
+    if (ret != size) {
         error_report("%s(%s:region%d+0x%"HWADDR_PRIx", 0x%"PRIx64
-                     ",%d) failed: %m",
+                     ",%d) failed: %s",
                      __func__, vbasedev->name, region->nr,
-                     addr, data, size);
+                     addr, data, size, strwriteerror(ret));
     }
 
     trace_vfio_region_write(vbasedev->name, region->nr, addr, data, size);
@@ -96,11 +99,13 @@ uint64_t vfio_region_read(void *opaque,
         uint64_t qword;
     } buf;
     uint64_t data = 0;
+    int ret;
 
-    if (pread(vbasedev->fd, &buf, size, region->fd_offset + addr) != size) {
-        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %m",
+    ret = vbasedev->io_ops->region_read(vbasedev, region->nr, addr, size, &buf);
+    if (ret != size) {
+        error_report("%s(%s:region%d+0x%"HWADDR_PRIx", %d) failed: %s",
                      __func__, vbasedev->name, region->nr,
-                     addr, size);
+                     addr, size, strreaderror(ret));
         return (uint64_t)-1;
     }
     switch (size) {
-- 
2.43.0


