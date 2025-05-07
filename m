Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CD4C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 15:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCgaI-0004rW-CP; Wed, 07 May 2025 11:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCgaC-0004kf-0E; Wed, 07 May 2025 11:21:16 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uCga7-0005so-Jw; Wed, 07 May 2025 11:21:14 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54785SK1025158;
 Wed, 7 May 2025 08:21:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=t3PjoTVSnm7INwGswI8faszeGiHdMjmxbWc4cD/27
 Ww=; b=Hts5zF8rOHSGm1zp0VT7IwbCqpHfBhz/laDzWrLiuzx0SPfwANqiWV6yN
 vfIibw9gJYjvlJa4bqoGvegYhaKLEOMAQnnp1PrG4KWSOu4H0B/YyHz8Ci27e8Dz
 quoBX9BgDevypamOK9P8e2V4eyj7bEhD7CZcx7GFZW2Lk7qj1mRvXVJAaakEXKR/
 V0ObEu15Ame8PBuwXDT0joQzuXn80/+yPy/VPBGski22l3GD3f1X1t0goHI7/vpe
 4Rk0vyQXdWzJghoIrVarMnZPehmxrLcBMWhw5wwxl1D0enF0XfoyQNKIPNxDx/4T
 5MwY5O0FihEkyZMkUQuK1S0zq7Uqw==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazlp17010006.outbound.protection.outlook.com
 [40.93.20.6])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46dh8j1c8x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 May 2025 08:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AX0KWubCYlZNZKAf9bhguvZXqjm24df1L2TM7yHYd+2c8JZ2o849u4/fUMrBxxxnxIOjygsnZIVDzm1fx0G++tD1o4TkUayibIo8ywKJjf8d2moMt6hGgmVZqkbTdi4bhyYF5aoexKy8gaLt4WVB9EsOvr8dpCp3q2MlKkaEJxgK2GnAWAZ2TmY77TlFCt15yRnKCDgd2C6onSMHMW0wajB53X33qyMCUzTkm8mbB+hM7lQpsew7fBrPK6CsAQScUXGxKAKpEpR/My5FuSv/BXKOGe9grYaExxxw7PODSafNa3iNQ3lp+p2xYi95AQw9OnDnxJ3FDEaBJEvb0CDv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3PjoTVSnm7INwGswI8faszeGiHdMjmxbWc4cD/27Ww=;
 b=dkBtSz3JSKWsDVJ/VE31HgntLas03TWTEI6k+lB33BSFmL/Bs6ZfFNSWB5WOkaYQLn3A9DvLlrp73UgdAXqwUOjLYNWDxobhBSiJKyZw6nEyp9tEjmE6swuaFsvdlnYbl98MKQtHwHUD8jHuWY0+LHNa8bFQww9kzBC7/9dqV3JXGxVDx0uMIPpgEpIBPQ/0/Y4LQ/50nb4PY20awN13VGdwBU++r+UBctAA5csagZjCYiE/8PQWgWfzfyd2mykh6cIn9BXmh4H6ULCryyg4K1DBoEqtsRz7Tyw/tDlpoEL7ZindXPXGL2GEShmdGoskUuPeYAXmKqiXksPZrGlofA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3PjoTVSnm7INwGswI8faszeGiHdMjmxbWc4cD/27Ww=;
 b=i2gyLaDlHjzkqCadXMG5YnUj3Ror74F/fmg3aW5GkafWDFd5TkNtQTvPDZBL9PIfQ8o6E8zQTkPHz8jQF+jzBAas1aWjRPc3Z29xFfJ+G9ky8D8/EL7m+D0OMlaDoOhe6n5a+pgsAhFZzheiF/XeGqOZXv7IJtlesZHmH3PIm8gcdF51prcwqtB5RzsZQlwcUwrYTsUtf+ul1ZKCYZesut2K3FVSBRZkdp9lgDL2eQ1Ix8OVj17VzOM8UkfsI8eDitm290joJxukLTABv4oteWcE4S7pqZMPoItr2ZLTju2LdsY1Eexxu/8tpGUjhOIoku454/bLIWGBwc9Mnj7mNg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BL3PR02MB8220.namprd02.prod.outlook.com (2603:10b6:208:342::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.17; Wed, 7 May
 2025 15:20:56 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%5]) with mapi id 15.20.8722.011; Wed, 7 May 2025
 15:20:56 +0000
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
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v3 10/15] vfio: add device IO ops vector
Date: Wed,  7 May 2025 16:20:15 +0100
Message-ID: <20250507152020.1254632-11-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 783f5649-c742-4702-d277-08dd8d7ac36e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AeEecaXPYGH7Mqn40ePCuJFLEgcoEHuK/TiE3lTO9xF52CC6evXS5l/FJtil?=
 =?us-ascii?Q?FZG2Fn69YOyrJlCrNci4PlSn2rYh09akbGgLhs5RagzGPc14bl1yGzk+nOfR?=
 =?us-ascii?Q?CGmg45S8zUM2eaqvMHpt2NdtTBV5NSVObK3cGRrRUvYsB+hdZV1SUgqGt1fK?=
 =?us-ascii?Q?5TdKM02L4TF+P42V3YlaSr61uD4DTYx7Y7/UeOA0Ou6C24mvOJ3nPyd9OBKA?=
 =?us-ascii?Q?DkowXlBRjlPxrQFkAl+CvjX30U9gb8yWXN0/b7elS1e65l90CRdgppBbWg+j?=
 =?us-ascii?Q?0qitSliSPmka1Ty/YlOtziHF6r2apaTD98iRr9+b67AZ/pcZ0Brc2n+fc2mM?=
 =?us-ascii?Q?aowfs+aRPkLRMlcSt7yaeiaVz8+FzFSfzwn+tSMNbHyaTr2D4Euuzrgv7vLF?=
 =?us-ascii?Q?tP9RxV2/il0Vpv1n41/NurJyB+oDb/iEvXCB+pd/aFlN0bnEnrfmO2MvWUZN?=
 =?us-ascii?Q?EYC91rKDRqrgtlnXsxRzPIj9ulp8qA19rKVowGqKimm9fNXhIwHF4o7nNnhJ?=
 =?us-ascii?Q?avr5s9ZA1QfrlIgqUrT1rMdsA/elSGRFBuniVAUNYAyDILg4tLwYI26Z+Z8K?=
 =?us-ascii?Q?1pOnB/4UY+mWK+7s01UGK0A6JbmA02JB6UnuvMA4jmvmm5oZaDULJkzSTiZZ?=
 =?us-ascii?Q?hML8x2g90iiNhwb8lBLHT4YJ6fTS/biHxWQ9aCQ1U6sX1TT8Otk4PHGcCUJC?=
 =?us-ascii?Q?0rayy6JgVpCIHvkqjI32lrbsKL5HYFr0zHTAWA7tS6AXgTZiVkkcWZvLO0tV?=
 =?us-ascii?Q?Ap6fGVBbcNPXNuU+o897LJcwDHknW0ghSW0W79q9AQy+vz1m+8SM9L5bv9kb?=
 =?us-ascii?Q?D9wqV0zvzIkQiKdFqa5a9SWl763Y9/qYfE6aG9ytfxo8+k6HcSahNqvOvW09?=
 =?us-ascii?Q?ZL4LEyhWrqpNFXVUkzht33nAWxKUnK0C3v7wtNDd2hD5764OMTR1J/8CQH3k?=
 =?us-ascii?Q?xihYXFAbvzH4BSPSq4PaeGxT9pU//v1cxNMX3P5XH6eJdosWtJsXGXQ0741p?=
 =?us-ascii?Q?7qWU24pXbqXXw/wFAgru60nI7HFYumLQB+tcK2PkcIrL6euiSd7yKtpby17Z?=
 =?us-ascii?Q?eIUrzT81+KV1vdg6IV14CUQZApDaFa70eVEuG3eBcl+/6gPahgdX1tLUy8u9?=
 =?us-ascii?Q?AwJAQwI2rQQu997mMZbdB5nRFdtBejoVurtmcc1orVpzCOTQ61CT8KQMrcAh?=
 =?us-ascii?Q?jH7+TxhvMT7VXh9JBZxA9ejJY5QZqlAy1JuQ+ju98z3QQEQ1GSJcF6QlG1U1?=
 =?us-ascii?Q?PEYl0Eda69ual94gpxgEhBZZI/JyL1be89b9RS0+LfO+UAG1wiw+8U65ON6I?=
 =?us-ascii?Q?aSdjIuooCV/uaKpekFWunl6EQiQmSmSCSGPmNpb7F43dWf+runHiuk01ewxV?=
 =?us-ascii?Q?gZLEq185e3BHHTIrJp6ky/hZi7eJaGBG/EppS8VMkE/3F7iWq3DtuM1CYcjD?=
 =?us-ascii?Q?DNegd7Xgmdg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rv0zSkdvf7ftpCwBluO00lvCRr0b++Ytf5U3gJUfUoLm2A2lsnL5EqNRmwnO?=
 =?us-ascii?Q?rLqRgdrwrXDaaR7NV4yC2dBPInI7g5SvuzMRV+MvdS7dYrK9K+rpr4rJFQUP?=
 =?us-ascii?Q?X/X6iEWc2PL9Huq2UGOkzujGPZSAfNcyRs8yyPnpDwb+80ohMyfBDeztbJAE?=
 =?us-ascii?Q?vTQ3HJU5WE85SEBnK0pCyPaXtaZz5lZwSsjDzqplbgwooEylyhKo4fG5Sa3N?=
 =?us-ascii?Q?rHQBp+r0JiW5mQayn32bpShXZnziXUoOlVuBzySO96w8Z8UE71T9BxAYPX+s?=
 =?us-ascii?Q?tFIChhzRES+xs/Z03ztP/2VXp3xg+G00kKDxxveWpKG4GhfaGWUclAzs6oDS?=
 =?us-ascii?Q?MCh3xKFbHLDnxYDa8YzDyMt/lZgG0PNshpBBLz4WC/2fLY8njlVTDsbmjREe?=
 =?us-ascii?Q?QOo+cAn2+II+wAXqCRxBrWkW8Cy/bNh7sIA1JXmdyezwzKBLVwHSMuqebXnK?=
 =?us-ascii?Q?JKtcx5o9ic5J7mGj7HVfMZEMCue2PMZ00/715qYTqThBUgynleB+isk+qJ0o?=
 =?us-ascii?Q?9zTZ1cK8xheIfzl2dSJkdrb6Xt8ALnO00dadSqwCLlS5BuCz/lkRYQO3zzsM?=
 =?us-ascii?Q?LnRSlmqPId0jJCethl+ECTUjp1Wh3R/GhRr+s/E85WOD8OOhTMTQenGvNm+i?=
 =?us-ascii?Q?0deVlwX1peN1EeckXU0pgFvdjxAxtutn8w7be5Ta9YxFnohZ1KCFuRcRhHS4?=
 =?us-ascii?Q?5J1iIx8nZjr7csX3iTkQLwdkFoUKkNxUXvxbXLXzFUabHu8DCFiy/beri3/V?=
 =?us-ascii?Q?nGVqjW3HfhOdFEB/qgW+3LV8mrmzNU4StKsVKqn4BK64JRsU9gMyZMenq0UN?=
 =?us-ascii?Q?d1NAteJREzlhRu+l33mPnKPMlkGmE3z73Lpn9YaYEllLbjfPAKXer3P8++Vd?=
 =?us-ascii?Q?d/gNbMMvVEAi4YzewvNdtNLm2RzE7zQ54KM9U1zF8Y0KWl+Prj6U9TxDrM9v?=
 =?us-ascii?Q?4VYaZ7V+q2KddyXfSq3xFA0ovxNw/D9e+Xmd4lau752U0mVGOAJgovewQmeK?=
 =?us-ascii?Q?lCXof7xEXNykcq906dZ3RKbEugGtHa1KcL5YzCx0WJ5wG8D6tEYW8x1ILYAW?=
 =?us-ascii?Q?XqinHuShhDCWUm3PUS2+wRJCGbS6FHa41G/hZHILsgHpHeHq/+sbOoPrfWfX?=
 =?us-ascii?Q?LQmZfmo0td5zIXr0hyWpvMQelV3ScrsNAf3hRqrU9OaP3t+iiwyIp8nM0KXI?=
 =?us-ascii?Q?ZnuO1WDxJGQF2wH+3hBkIIKwV2do1rRD2rUbAkSzf2dmQvhWriNXftuJXWtw?=
 =?us-ascii?Q?Ykqr/XUWGIobe8DXW9Wqxb2dae2U45O/LATLI7q77RSApKs+zs9/+fuo/y2e?=
 =?us-ascii?Q?SmMbAmEolYKmPrqEf27yzFMNmL14H3WPjg8bEn9474y8n3YYi24k3tXf8lT6?=
 =?us-ascii?Q?5tL6IOoX04YjVdtF5oqWNl/A8xh1nb8Y6w/3hT0ylpGA5g2HhpFfy2VXhdRn?=
 =?us-ascii?Q?ihTssqfirRwDiOf2UM+J1Q96EBL71W4DuGkCXyH3WysXUT71g4nNI7zi2xtJ?=
 =?us-ascii?Q?xoTT2r0XXdMF7CzBhe9z2Ezb34mwU9jCkjy8rsvZa3imqesxIet2ZpImqCXz?=
 =?us-ascii?Q?4EELrW8eaT4mIR8m1+60b+HKeYuXAAKnSvjJcBmb?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783f5649-c742-4702-d277-08dd8d7ac36e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:20:56.3367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yMmM6VjjFDEb7WIQaVpUZd8AyifHgu8lTIc/XHAv900ipNnSmZ0Sb1X1OkR96iwe6nmcVrsnQyuyAHKBbgjAJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8220
X-Authority-Analysis: v=2.4 cv=B/y50PtM c=1 sm=1 tr=0 ts=681b7a5e cx=c_pps
 a=4pNSFujyTdcV/+UEb5HSFQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=EI333REZRzQfoknhNBQA:9
X-Proofpoint-ORIG-GUID: B0uZnkVljSiR2a81QtIpS121qXLITIDv
X-Proofpoint-GUID: B0uZnkVljSiR2a81QtIpS121qXLITIDv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE0NCBTYWx0ZWRfXx48E+2/7RBV0
 pO8uhnKMKxJE8BJ25ADvjGy1B71d4rooZCw4tKaK9DEMZXgjGmOx0JMB90MHWBxp3zpcp5294AG
 eeFy57+WRsO1/usPUNIitSYV8oqjrjfUFnCqYrpMbhfINt2oJoAGzcUAVBN0jvEnI20jYp2bJAA
 AZDpS4eVwjO04GwnrvCWAZ0IImn5V837V5Ryqwi7xPY4mprwr/i3TOe3SWtt/RBAm+PFUtXX9dV
 n6v9QUMFDrJyNEZqxWWYBkgNX0oNNRGxGvzOslxQOCncRvALWxVtJ01JJleW9kNcHtUgAkK+Xgk
 blqX3G3pqT7irqX3JLZYo66PgtELhub9lPZWjLxGYgL7YZI8fKVUOaiRxT/tAsislYns9E4IfrA
 7KLW/AFN+DKL2d0AP790cgPBUPwLqEoELkOQjTqffu6zjKznWAOlxp052Bhwtkm30wT1h8yC
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

For vfio-user, device operations such as IRQ handling and region
read/writes are implemented in userspace over the control socket, not
ioctl() to the vfio kernel driver; add an ops vector to generalize this,
and implement vfio_device_io_ops_ioctl for interacting with the kernel
vfio driver.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 include/hw/vfio/vfio-device.h | 38 ++++++++++++++++++
 hw/vfio/container-base.c      |  6 +--
 hw/vfio/device.c              | 74 +++++++++++++++++++++++++++++------
 hw/vfio/listener.c            | 13 +++---
 hw/vfio/pci.c                 | 10 ++---
 5 files changed, 114 insertions(+), 27 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 4a32202943..7e1e81e76b 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -41,6 +41,7 @@ enum {
 };
 
 typedef struct VFIODeviceOps VFIODeviceOps;
+typedef struct VFIODeviceIOOps VFIODeviceIOOps;
 typedef struct VFIOMigration VFIOMigration;
 
 typedef struct IOMMUFDBackend IOMMUFDBackend;
@@ -66,6 +67,7 @@ typedef struct VFIODevice {
     OnOffAuto migration_multifd_transfer;
     bool migration_events;
     VFIODeviceOps *ops;
+    VFIODeviceIOOps *io_ops;
     unsigned int num_irqs;
     unsigned int num_regions;
     unsigned int flags;
@@ -151,6 +153,42 @@ typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIODeviceList vfio_device_list;
 
 #ifdef CONFIG_LINUX
+/*
+ * How devices communicate with the server.  The default option is through
+ * ioctl() to the kernel VFIO driver, but vfio-user can use a socket to a remote
+ * process.
+ */
+struct VFIODeviceIOOps {
+    /**
+     * @device_feature
+     *
+     * Fill in feature info for the given device.
+     */
+    int (*device_feature)(VFIODevice *vdev, struct vfio_device_feature *);
+
+    /**
+     * @get_region_info
+     *
+     * Fill in @info with information on the region given by @info->index.
+     */
+    int (*get_region_info)(VFIODevice *vdev,
+                           struct vfio_region_info *info);
+
+    /**
+     * @get_irq_info
+     *
+     * Fill in @irq with information on the IRQ given by @info->index.
+     */
+    int (*get_irq_info)(VFIODevice *vdev, struct vfio_irq_info *irq);
+
+    /**
+     * @set_irqs
+     *
+     * Configure IRQs as defined by @irqs.
+     */
+    int (*set_irqs)(VFIODevice *vdev, struct vfio_irq_set *irqs);
+};
+
 void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
                          struct vfio_device_info *info);
 
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 3ff473a45c..1c6ca94b60 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -198,11 +198,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
     feature->flags = VFIO_DEVICE_FEATURE_GET |
                      VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT;
 
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
-        return -errno;
-    }
-
-    return 0;
+    return vbasedev->io_ops->device_feature(vbasedev, feature);
 }
 
 static int vfio_container_iommu_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 5d837092cb..40a196bfb9 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -82,7 +82,7 @@ void vfio_device_irq_disable(VFIODevice *vbasedev, int index)
         .count = 0,
     };
 
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
 }
 
 void vfio_device_irq_unmask(VFIODevice *vbasedev, int index)
@@ -95,7 +95,7 @@ void vfio_device_irq_unmask(VFIODevice *vbasedev, int index)
         .count = 1,
     };
 
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
 }
 
 void vfio_device_irq_mask(VFIODevice *vbasedev, int index)
@@ -108,7 +108,7 @@ void vfio_device_irq_mask(VFIODevice *vbasedev, int index)
         .count = 1,
     };
 
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+    vbasedev->io_ops->set_irqs(vbasedev, &irq_set);
 }
 
 static inline const char *action_to_str(int action)
@@ -167,7 +167,7 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
     pfd = (int32_t *)&irq_set->data;
     *pfd = fd;
 
-    if (!ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
+    if (!vbasedev->io_ops->set_irqs(vbasedev, irq_set)) {
         return true;
     }
 
@@ -188,22 +188,19 @@ bool vfio_device_irq_set_signaling(VFIODevice *vbasedev, int index, int subindex
 int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
                              struct vfio_irq_info *info)
 {
-    int ret;
-
     memset(info, 0, sizeof(*info));
 
     info->argsz = sizeof(*info);
     info->index = index;
 
-    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, info);
-
-    return ret < 0 ? -errno : ret;
+    return vbasedev->io_ops->get_irq_info(vbasedev, info);
 }
 
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info)
 {
     size_t argsz = sizeof(struct vfio_region_info);
+    int ret;
 
     *info = g_malloc0(argsz);
 
@@ -211,10 +208,11 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
 retry:
     (*info)->argsz = argsz;
 
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, *info)) {
+    ret = vbasedev->io_ops->get_region_info(vbasedev, *info);
+    if (ret != 0) {
         g_free(*info);
         *info = NULL;
-        return -errno;
+        return ret;
     }
 
     if ((*info)->argsz > argsz) {
@@ -320,11 +318,14 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
     vbasedev->fd = fd;
 }
 
+static VFIODeviceIOOps vfio_device_io_ops_ioctl;
+
 void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
                       DeviceState *dev, bool ram_discard)
 {
     vbasedev->type = type;
     vbasedev->ops = ops;
+    vbasedev->io_ops = &vfio_device_io_ops_ioctl;
     vbasedev->dev = dev;
     vbasedev->fd = -1;
 
@@ -442,3 +443,54 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
     QLIST_REMOVE(vbasedev, global_next);
     vbasedev->bcontainer = NULL;
 }
+
+/*
+ * Traditional ioctl() based io
+ */
+
+static int vfio_device_io_device_feature(VFIODevice *vbasedev,
+                                         struct vfio_device_feature *feature)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_device_io_get_region_info(VFIODevice *vbasedev,
+                                          struct vfio_region_info *info)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, info);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_device_io_get_irq_info(VFIODevice *vbasedev,
+                                       struct vfio_irq_info *info)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_IRQ_INFO, info);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static int vfio_device_io_set_irqs(VFIODevice *vbasedev,
+                                   struct vfio_irq_set *irqs)
+{
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irqs);
+
+    return ret < 0 ? -errno : ret;
+}
+
+static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
+    .device_feature = vfio_device_io_device_feature,
+    .get_region_info = vfio_device_io_get_region_info,
+    .get_irq_info = vfio_device_io_get_irq_info,
+    .set_irqs = vfio_device_io_set_irqs,
+};
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index e7ade7d62e..2b93ca55b6 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -794,13 +794,17 @@ static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
                      VFIO_DEVICE_FEATURE_DMA_LOGGING_STOP;
 
     QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
+        int ret;
+
         if (!vbasedev->dirty_tracking) {
             continue;
         }
 
-        if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
+        ret = vbasedev->io_ops->device_feature(vbasedev, feature);
+
+        if (ret != 0) {
             warn_report("%s: Failed to stop DMA logging, err %d (%s)",
-                        vbasedev->name, -errno, strerror(errno));
+                        vbasedev->name, -ret, strerror(-ret));
         }
         vbasedev->dirty_tracking = false;
     }
@@ -901,10 +905,9 @@ static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
             continue;
         }
 
-        ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
+        ret = vbasedev->io_ops->device_feature(vbasedev, feature);
         if (ret) {
-            ret = -errno;
-            error_setg_errno(errp, errno, "%s: Failed to start DMA logging",
+            error_setg_errno(errp, -ret, "%s: Failed to start DMA logging",
                              vbasedev->name);
             goto out;
         }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index f65c9463ce..da2ffc9bf3 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -381,7 +381,7 @@ static void vfio_msi_interrupt(void *opaque)
 static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
 {
     g_autofree struct vfio_irq_set *irq_set = NULL;
-    int ret = 0, argsz;
+    int argsz;
     int32_t *fd;
 
     argsz = sizeof(*irq_set) + sizeof(*fd);
@@ -396,9 +396,7 @@ static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
     fd = (int32_t *)&irq_set->data;
     *fd = -1;
 
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
-
-    return ret < 0 ? -errno : ret;
+    return vdev->vbasedev.io_ops->set_irqs(&vdev->vbasedev, irq_set);
 }
 
 static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
@@ -455,11 +453,11 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
         fds[i] = fd;
     }
 
-    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
+    ret = vdev->vbasedev.io_ops->set_irqs(&vdev->vbasedev, irq_set);
 
     g_free(irq_set);
 
-    return ret < 0 ? -errno : ret;
+    return ret;
 }
 
 static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
-- 
2.43.0


