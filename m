Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57E6C369A1
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 13:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Vo6-0007FP-OI; Wed, 09 Apr 2025 09:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2Vnn-0006nT-Dg; Wed, 09 Apr 2025 09:49:19 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u2Vnj-0005ht-NG; Wed, 09 Apr 2025 09:49:14 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539DT60G025416;
 Wed, 9 Apr 2025 06:49:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=wi2jtWbsQUBkOPHldM0psMluwrKR0ryayA5kJploI
 Wk=; b=XUJUc6XWQME7NCJ9+oOOdVFfFKA7b2PGxGJyE0esxxl52Ojgw7X3fNGky
 Ld446jnjhmUxCqnBPL0kTjRIFv7wzM0IJ6boet+e4NZTKOxb840deeBUkIejeS+5
 OwVAhdCJDU07Pzq+WzeyyRkLe+a+rbIKVafKzIlKJpc5nSU5cWRQ16i3P1PPuVv2
 bcweoPdIkiA7FS4cztkXlsRU5M5bI7m672pLe8STiPzQcViKhLe9rWilVXlbOiZG
 ESuQEJzPgcc4HqK5u8oIWAIV02d/p3q3B/d8kzsohnedOpNI74se5UTscpLAlVQ7
 d31Hhqh140UEY577HCxC4/2mcA/pQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 45u3kksbjp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Apr 2025 06:49:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKGxEZxAIpG1dlOkxYBpkiCMOGe5bG+Zsqha0N7rRLXLFrZQzsc/ZsGjLNLsozGNZe5lJNnSAK9LZzj0u9XpGVIW3H+oYC4Quy8iJ4MAf2MD2qwFl8Jh848vQGtSXekpmcvZ5QGFbEcc3MKbucNzAuefjcZzBT7Ko2+dOBjYTdbD2PZKFpCJPDYCQBlA9g7gCX7AVT/9nfTl+Je21KUPNVk0P1ZfrLgOLq72FlXPSQ1pabBkTMyK8t6ms6TkuVIWX7aseySLElV5Psus2g3F1LEzRgObWB3yeBwVYNIuBQeCaeTqLcatRBz7f8c0WXl2igGsbE5iEm6jEzAK9hqbvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wi2jtWbsQUBkOPHldM0psMluwrKR0ryayA5kJploIWk=;
 b=OFFKfIiNNS/hpoSK2sjZdCghg6jia6lzZaem0pdjwEQabmzlIk1tDsdTDBIWmgSIuzx5GmrhpAp3g2+DC4OYgwxkg5RECRz6a0wsKFV2JtA3Fn3YYgy7cbEIalN1VRwOqrmm0C/DmR4P+nxsm9FtlvZ3q33GNsF/N8cHtV+Rk4cIvWEUFBn9Q3h173ichfi4k8oGb6J3UJ259YiRrZeDmN5D7uY3a/Af5FCNRAviWMgIcDkE9fHdovVR+YIYzhXzgxdYPNfESeGVIlhhQfBeOzLJtlUXuPopbQbpkQkTBUzodzKM+U6VZdmuD1zz5Ty1ph0zx3jOmXIZRPMvs8QC7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wi2jtWbsQUBkOPHldM0psMluwrKR0ryayA5kJploIWk=;
 b=TDihb3pI9Rxdkvi+x0OYenidxG+m4BRt0ngwckwRj3SFdJ9uaUbo5JJTmVmTRQYxUiXwgMPpXj7d4RlCBccaNXj9gGhZI9uvgCdZm/N7kToB+QGdRxQjyyQG0h5Oo6mBVaTCi8e+QZRJCozcd+1yBwRhV41TuRxdNNi61u2NOw/KFANqq/xhw6WimY3ZqYtwUcEw5eSFGuzKhvb1J8md3yaj7QHihqOdQVXAJCPs0eOP9/5wb8nTXRGychWdc41Y+sQ6//O+LSdf7C6jHcy4gDuX/18h/1Iiq0M201cCByxVyW9bS6OOFLBOajqqABOjCwiXNUOEEmISJZwX9puzAw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7181.namprd02.prod.outlook.com (2603:10b6:a03:29b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 9 Apr
 2025 13:49:00 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 13:49:00 +0000
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
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH 14/14] vfio/container: pass MemoryRegion to DMA operations
Date: Wed,  9 Apr 2025 15:48:14 +0200
Message-Id: <20250409134814.478903-15-john.levon@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb4599d-1caf-498f-e630-08dd776d4831
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/l9MxAQo5Pi//wkZ81j9cMB0bM8WG/dE6vLcmfxlwYVRKL0dTZY5laISnoi+?=
 =?us-ascii?Q?455oLwQ2X0R9pUxg6QXx+4wT/EtjzU5Ap4MY/rNhRBuuxh/BbfiBYdekfTMG?=
 =?us-ascii?Q?fRxunymyxm224QNWUDKIluwQw48tVi7gXsijXH3ZHNXXU4ZxSAiB1LCNO8nz?=
 =?us-ascii?Q?6EeLEpgmrfhrV61Ym+hlWo8Qz5sbrCpxIZJhz9cC5NUwc980/T4soORNrn+Z?=
 =?us-ascii?Q?MlwfDh20ITS5O9A9p1/Dxmn/OdC12Fsn2Z8g6LgyutGOEXIt2GtmmAx6BBgn?=
 =?us-ascii?Q?YeAwPdlL/4VHlVCqnObXiwDk3yIkMjXfjEGDJyoCjsFXhzActIb/dh6hyHoL?=
 =?us-ascii?Q?e0GX5FoHzCuLlXtZzQr1MkXoXmQbubHyksdKfw7taziUkUEmvaZgbdjpx9il?=
 =?us-ascii?Q?lo/iN8no5dxkMXS7rABA658gaUmBEgvE4psJEoQ1/GbT9LKsBtE+bJoWGJm3?=
 =?us-ascii?Q?Lka5TAcvZNUWfukhsZzmhF9HW9VP7rjckxo6O0WFt+wIZSh5igOe6hwLgvxW?=
 =?us-ascii?Q?s3qWdCiJkVq7kMZPaCnkPyS02o935oIV6+RxROhwUKUJz7eFym4q5blSng63?=
 =?us-ascii?Q?/7NtYgbSXa7STbH5hKz+cQbP4LT5GhXZTp0vS8nFmwH8ESwL64zrOZXTdLlz?=
 =?us-ascii?Q?iT/241M1rmPBMljpc/5+r0hoGsKwHrXc54oREq6xNyUrEHKgdJs8hEagnsLe?=
 =?us-ascii?Q?kOAqHe5e1LxRnBta7MhH1fPgap/dTFa8foW+7DsThhVvof4SKDMTWAGOvsx8?=
 =?us-ascii?Q?uDbACRIRjw+lDZABd1JyRHpAumoGbA0A3muj3sfnpLeup9gNxCLqxmJtuegs?=
 =?us-ascii?Q?rCTKOz1g8iLnpNrvp/tfJUKkxP3SLMLJt5G6o3ulUySkwNFNsWp1/rhq24cf?=
 =?us-ascii?Q?hlLM/I1yugMfMLQeER6h2ll7/mlXwnx99Zpg+hOwOzQjocOCNtrd1DqizNXs?=
 =?us-ascii?Q?j9AHvSg+r///QopVuGc2WTBdDomeLPxP8EJTWlv31XXjz4QVVUsrlal3fmH0?=
 =?us-ascii?Q?42KEFryvbLJnWRpw66sMO/hn1CBhZLgs1HVBHxSAK6irlxZ2tm/Np7qqQq7A?=
 =?us-ascii?Q?BxGOBLUCvC+hgOTJkdrf7VREHDEYmkTBlLehtCqYrdbhQ7G/eYJ876NgsASm?=
 =?us-ascii?Q?P01mMUfIFS6ttTrZ1uCzOEZIVJkS7LCX76v3LTN6nagzvTJyFO4Wi06j9MLe?=
 =?us-ascii?Q?IwmcgnWLOccooipVctay1J784LNKjuDmvBTNKM1UvAU6Ajn+GZxTx6xlueAj?=
 =?us-ascii?Q?cqksunOJoA+3V6y9jO+qivphksQJ4NFwdZBoATMlSZC3Xedb6xX9rM1mDexQ?=
 =?us-ascii?Q?0BE9lck48P6xgDvx1f73Pc/t8jgwsxPDGY6RxUNIaAMr9yEpwEb0H6p6lWix?=
 =?us-ascii?Q?zATboNFpp2MFoGwwhR4Sz8h76m/RG9tFpzPke2/mhr4WX1QSCKjcA0QDllKZ?=
 =?us-ascii?Q?oFMnG8++ECA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cRTYeh68hkgqcluotEsFmThZz9h+DedXoIGlTedoc4O5k9w1iRAW9LkLg1Yr?=
 =?us-ascii?Q?9zgEaVdNK8MTys5RhUmDAA+uPu2D4CvvEEFM7TznrnuaCIJfCHa7cFJmKEIs?=
 =?us-ascii?Q?hRQPmtdhxiDuHvFLK4KMtnxSw3zyPCbqVs9Fe7+debQKWXVpFbFzqJ0mbIbK?=
 =?us-ascii?Q?+PtNM4hAjnCi3Sg8jOYg384Fdt3rKMh7GmkMGKvOfPBibvZQXSXF9+iUeOTo?=
 =?us-ascii?Q?pwfbWG3adcKp94XZbCc8w9OyxxEv2uEKcYs2mnThSplHQsLilvoGjqtoKKek?=
 =?us-ascii?Q?zltq19wXfN80T0dZz4/PnD3M5Fh8k3G0LPd/KPtx+LqNt0oPqF4Gv2tVsEwP?=
 =?us-ascii?Q?YTx39rPndif8CKXl1iISYpWr7HqY/ZG82vaiBR16Xd0Fw/Y0WQDk2GKOSlAe?=
 =?us-ascii?Q?9Bwtcf7sZnIZ1wt2T8wZbxbXwDTGUVUR5jGEq9kliZv/yyoToqhs/NtFQ1XR?=
 =?us-ascii?Q?BaKfAnHAJatKalBGfyQLcFHOuSoMr3ShiX9ueYVgKm3eIM1E6ZjCfL0srn+2?=
 =?us-ascii?Q?goHsWqKoASZ1xz3Rj9rI1TQCdK7X3gL1cV96GJPTXJq673L1Vyb/I1qNK2Uy?=
 =?us-ascii?Q?f79HB5H1vAad/z/g/k6KahybIA2uQPHyKqBZOXr+MmFWhWgWyddL2TICksxZ?=
 =?us-ascii?Q?6P8mvoLGnq7Wtxe633R0oW5Fr1p0nxVbRbF7ZUZ6DUy5pWMC2GGAUa3UF6aB?=
 =?us-ascii?Q?jyvzdjUEfE93teYZMqtadk8Bvc82s3pmf/lBq80ag22i+e6g8MuIuVNvOT60?=
 =?us-ascii?Q?o6OvJrkyDUg0pD8xL6GX8c8nkFo+1eSacU+3NQalhREAzTncFNHWekC8Swe4?=
 =?us-ascii?Q?yZsrfNtGfsvv1TCGCLpwh7zSJvvES1HrhzPdoCcoE+GcBT8h8qI8hpsAWb90?=
 =?us-ascii?Q?YXx9nDTwle32GKeppTGntxmSXTEuFLFFGJ5GIM/2pX1sHMuacfuzfQBejEs2?=
 =?us-ascii?Q?9YYSRJjMif5Mb1+dQviftnPcEFcFwZE/XfBhYKFRhtcoqad+Gov13UBRUkXN?=
 =?us-ascii?Q?0R87afq6hO5R4ZniATWHaPnw+gotzY9iRnYtuXbZS/1b0EdQYvzCbv+JOrZ1?=
 =?us-ascii?Q?hJuP9l1k24mdADhKVABqPgaOPAGC6ip1/iOkgV7srDPxr4UO+1lyQ7QY1DXB?=
 =?us-ascii?Q?OIHZU3iOcSoCe/FgGgquAABd70vMuIss3tjcVqRQUkRSRpzTXuC7D2m25cek?=
 =?us-ascii?Q?sts29/AyrPXKEG2vCWADvc8bpqN6gX29XuCHMErJoOTRUzG3LB8MX+0AiM+m?=
 =?us-ascii?Q?wDGBn4PJ3Zq3GbzXq2V8z8av/T7+vT448IDUcbRB1h6u8rlnafTAVeesdKZ9?=
 =?us-ascii?Q?Ix63sXjc8iRpUbhV8lVWDZBLrNkt6FkHwR3xJxNgKF++kcvxINz147cA3I9k?=
 =?us-ascii?Q?hsj6MgDO2qd40qH+9T+PxnLPrHXez5gXAE5sURNx9owIVw/uF9cGd3vXHfp3?=
 =?us-ascii?Q?sjUtuVprbH9avzE/AWJasUt4ph/zRLsV/xX0O4uPomeV03y1KsJv/q2mz+Yi?=
 =?us-ascii?Q?j/+zi2NpLFnacAxWecSu6Kvz4pEe9izWcjInvAGlWlxHFGrglpufFV/pIQHA?=
 =?us-ascii?Q?L4dqqpoLqIlrlp0mYpLFC5lv6RrTxXPtmUJ0qmiw?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb4599d-1caf-498f-e630-08dd776d4831
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 13:49:00.4343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hw9Rgzx0TUe8sWUYgwfF60Cr6y1AOuz1IZdDuQm49Q52oFn6KCDc3L1aWQ36sjHJANC7N4zIY8WBhQMa4Lyouw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7181
X-Proofpoint-ORIG-GUID: 2DsHcFRSvXyDijvudD8nezNBc9J18dOd
X-Authority-Analysis: v=2.4 cv=d+b1yQjE c=1 sm=1 tr=0 ts=67f67acf cx=c_pps
 a=+tN8zt48bv3aY6W8EltW8A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=7zwm0VwvlM8wVqh4CGEA:9
X-Proofpoint-GUID: 2DsHcFRSvXyDijvudD8nezNBc9J18dOd
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

Pass through the MemoryRegion to DMA operation handlers of vfio
containers. The vfio-user container will need this later.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/container-base.c              |  4 ++--
 hw/vfio/container.c                   |  3 ++-
 hw/vfio/iommufd.c                     |  3 ++-
 hw/vfio/listener.c                    | 18 +++++++++++-------
 hw/virtio/vhost-vdpa.c                |  2 +-
 include/exec/memory.h                 |  4 +++-
 include/hw/vfio/vfio-container-base.h |  4 ++--
 system/memory.c                       |  7 ++++++-
 8 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 16fe5f79d2..55c977ec33 100644
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
index 61333d7fc4..587af60e57 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -215,7 +215,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
 }
 
 static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
-                               ram_addr_t size, void *vaddr, bool readonly)
+                               ram_addr_t size, void *vaddr, bool readonly,
+                               MemoryRegion *mrp)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 22e5b16967..4fd3c0d9f3 100644
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
index 7ea9e0dfb7..cb06a63a0c 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -94,12 +94,12 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
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
@@ -127,6 +127,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
     VFIOContainerBase *bcontainer = giommu->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
+    MemoryRegion *mrp;
     void *vaddr;
     int ret;
     Error *local_err = NULL;
@@ -151,7 +152,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
         bool read_only;
 
-        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
+        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &mrp,
+                                &local_err)) {
             error_report_err(local_err);
             goto out;
         }
@@ -164,7 +166,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
          */
         ret = vfio_container_dma_map(bcontainer, iova,
                                      iotlb->addr_mask + 1, vaddr,
-                                     read_only);
+                                     read_only, mrp);
         if (ret) {
             error_report("vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx", %p) = %d (%s)",
@@ -234,7 +236,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
         vaddr = memory_region_get_ram_ptr(section->mr) + start;
 
         ret = vfio_container_dma_map(bcontainer, iova, next - start,
-                                     vaddr, section->readonly);
+                                     vaddr, section->readonly, section->mr);
         if (ret) {
             /* Rollback */
             vfio_ram_discard_notify_discard(rdl, section);
@@ -558,7 +560,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
     }
 
     ret = vfio_container_dma_map(bcontainer, iova, int128_get64(llsize),
-                                 vaddr, section->readonly);
+                                 vaddr, section->readonly, section->mr);
     if (ret) {
         error_setg(&err, "vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
                    "0x%"HWADDR_PRIx", %p) = %d (%s)",
@@ -1022,7 +1024,9 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     }
 
     rcu_read_lock();
-    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
+    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, NULL,
+                            &local_err)) {
+        error_report_err(local_err);
         goto out_unlock;
     }
 
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 7efbde3d4c..eb02b081d4 100644
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
diff --git a/include/exec/memory.h b/include/exec/memory.h
index d09af58c97..f79ff332b5 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -747,13 +747,15 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
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
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 6eaf2b2430..47ce016d8e 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -78,7 +78,7 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
 
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
-                           void *vaddr, bool readonly);
+                           void *vaddr, bool readonly, MemoryRegion *mrp);
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
                              IOMMUTLBEntry *iotlb, int flags);
@@ -124,7 +124,7 @@ struct VFIOIOMMUClass {
     void (*listener_commit)(VFIOContainerBase *bcontainer);
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
-                   void *vaddr, bool readonly);
+                   void *vaddr, bool readonly, MemoryRegion *mrp);
     int (*dma_unmap)(const VFIOContainerBase *bcontainer,
                      hwaddr iova, ram_addr_t size,
                      IOMMUTLBEntry *iotlb, int flags);
diff --git a/system/memory.c b/system/memory.c
index 4c829793a0..de4f955a66 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2185,7 +2185,8 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
 /* Called with rcu_read_lock held.  */
 bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
                           ram_addr_t *ram_addr, bool *read_only,
-                          bool *mr_has_discard_manager, Error **errp)
+                          bool *mr_has_discard_manager, MemoryRegion **mrp,
+                          Error **errp)
 {
     MemoryRegion *mr;
     hwaddr xlat;
@@ -2250,6 +2251,10 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
         *read_only = !writable || mr->readonly;
     }
 
+    if (mrp != NULL) {
+        *mrp = mr;
+    }
+
     return true;
 }
 
-- 
2.34.1


