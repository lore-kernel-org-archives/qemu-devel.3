Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A630C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklPH-00046d-CZ; Wed, 19 Feb 2025 09:50:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklP9-0003fJ-Ro; Wed, 19 Feb 2025 09:50:28 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklP7-0007Z7-GJ; Wed, 19 Feb 2025 09:50:27 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JBEuNi022547;
 Wed, 19 Feb 2025 06:50:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ryOwBWkEr0cGzO0zYpHTYTJrOd2B666yTBCakbU1S
 uY=; b=Fqv+bDmsL6Op5sP2px5xDMVL0iKeaQFEamoKE+YYjDwCeotLFGep1VCVr
 yplE9xl6iIP897dUlGh+cUAdID9n/SN/WGexefBoSxI5S+uOWi45xe7DvSWAI4b4
 gvS6jd3VC3M4EDhIMPwMWqFdVIhQy50sPP+WKNd4LMYf0sy5Ojv/NryjLEYGMSgp
 Y0HS07AE9lZ5f3YMJqhxh2BtWdFLmQji/PyodKW2r0aKt+OZTj9vIP/lt3FQZ4oB
 kyf1kk0319fChPh4sZ5F/MgG/Pc2dS751LLviRRigaFFXKoH1wSxIQRjgLRy5yDl
 apGv/H4G+fpOFmBt1PBB0Luw5XEAw==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4b9hy5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:50:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSuICd9IavAThBCsk7ZdHpoN6Yf/lCyOyIZstxtuQ2xrG3mFwDBDqQ6AjbdmhOik6KpBDgdV2ro0ZTW1JcHPPAxASh+uV/QyDJGPUpSZh8G9t+JTMbUUDG1dutJw8esxOr7QXQOarx0OBx6klQ2NM93TyKKe2nembpuE94NOVaM+947TQJpIthnX/zoVjBllmOnZ6N4lW7n5JUm5SZZgLubFMAIttyO+khGlI+mcSBgY6gNCmyDX1CCqda/yB4mUNcXnSFMHvuT6Kb8C4KJEYm2/Vo0660sUf9x6reb/k7ZR6pLOXtKgfBd3HJpud+unrj/FLOTm5IdorECbWCQg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryOwBWkEr0cGzO0zYpHTYTJrOd2B666yTBCakbU1SuY=;
 b=qJDAVHuwJZRqATF7fgfiic+KGNTlkNYreEFl5ZlNqL6sM7QRQDzslPUAUYyYr2wjTvI7pT3KuwPCScdEjpwK6HEVCIos9x9MFW1E5yIkwabNy4iHdxpcFCM3wCEzBjJD+H6O4GDXuSWeioQbKecY9pLZhIeT502MbmEYr+Hp9tU1oymhsh9rpybK4DkFueq/yfjciMbhpFM5F0mYDpg+GQg9yKpe0RYAKQr7pxJxRGFf2XZ3Y3Ma+WmBkpUgulZAf1DZ8XA0c7aTCB03Fe/OUrXauKxTQD6MmnnEhHqCobb+xVZgxzCsZfFa5O65lEHVbgDKpl0StBwjZKGrrV/4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryOwBWkEr0cGzO0zYpHTYTJrOd2B666yTBCakbU1SuY=;
 b=lZFn5+0eabTLqeZC0dwPtBPGeYrasM522aO8v5ojBTbf2Bm4nn3CzaZrY11sxYXN6wYxGVCIgN3MzCpTn5lF8xZBmM0BhsC+AlimEkWIdtPj/1ZYzy+Mdv0ltInqa8Uvu0VU1uJuh2/dQV2VvXWjzZy0PEwPwnc5+t3Hi3nIBYNM7/km59/5/tJfhvOOcUtWWLRWZhWqZxeDIOS9r6smDqs7zq2xYBKPPEj0K0WimGV94JgtSc9JkzzAudH4ZiN9rbQ8tP93L0KNTWrjiBRLKqtHawFoAmJ27cupDJlTl90BIglyPvoIyzqEcGj0WRRjoygl3XZaKZLyOGo02UVneA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV8PR02MB10096.namprd02.prod.outlook.com (2603:10b6:408:181::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 14:50:05 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:50:05 +0000
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
Subject: [PATCH v8 16/28] vfio-user: implement VFIO_USER_DEVICE_GET_INFO
Date: Wed, 19 Feb 2025 15:48:46 +0100
Message-Id: <20250219144858.266455-17-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8b4e1796-7b8c-4dde-7402-08dd50f4b281
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gIYqjAQRRMegzxxbIGFRWYeSFttVRM8IwTjXAwp5XP58T2mvxBp1sgEnvZol?=
 =?us-ascii?Q?9nFq1kfZH4NTaKc89wCnAgQM0oj54FmK0DUFf8xc1KKyKHxoSPDElmBiz5SR?=
 =?us-ascii?Q?IpFos/ZCzBXmnCNAwG7Poh5tz/YmwDwDLGndnnGxYQhV1MuX1oZymM0R65LZ?=
 =?us-ascii?Q?cnwQu0oonF//prEEw0QP+guPNBwwwhkMOYI2aZqFVBZCxM5acZ4epj2DxPnp?=
 =?us-ascii?Q?JQWGbTvBxOV1B96kK+Ol4g4sq8Rib8ejXCuX4jElwrVVGNcGX2Gw/B5BlyLw?=
 =?us-ascii?Q?KjsAivCYnwz7GyixPsvS0J3RE70RWT0V+0Pae0d7vRwQlElToEWF/iB3tDnP?=
 =?us-ascii?Q?XI7g7BovaO1aSAuG1slSyhXUoKuZxMR+Rrr2hMorCASbvc4j36txGlg4X1vY?=
 =?us-ascii?Q?ATuBrSFA4pxsRwyayaE4HXnEHlucSIViqPNwazQ+L33vJeCCd8/VEHYxY1po?=
 =?us-ascii?Q?OGsHneAsreB61kt5RUd14cVxcYAHQET/U3c1FTEqrGQ0C1d0jKo5v6Oc6ZFB?=
 =?us-ascii?Q?48W2DswfTHBAqeiXoDGlaDjCb9p9Nd2rpbOefqthmQW/ZrbSUPy7j9T0+JDy?=
 =?us-ascii?Q?Abf1pjBNRqxW+lIRgHMyo/5U5R8ev43ZXiUUD+6bMkEvDV12sX9k3iTOzWWp?=
 =?us-ascii?Q?a2y4FQbT36smZWYP192dmZWLb32CQzKz+BIBuDv/TIHJQe01lV6n0W9eZtqh?=
 =?us-ascii?Q?0bhjUs/2MzxtGThU/nQ7zkOQ56VC7CU5S2LS2tJ8hkGDL6gx0inR9smpAfTS?=
 =?us-ascii?Q?xAYDlFRvvNrFnVFku97h4FciWReaFQgbxQzMmGuM8ZM7DoxGhViXodTzZ22U?=
 =?us-ascii?Q?hOMhowySqkCq5cz+CfUlWv+xoSkh/VPlGHam8vYifAgJ+8FlP7AJvckiZ0pv?=
 =?us-ascii?Q?lQRb1LUku5f73yp8Dnyz3UYrhontKYQlNQWUfatoZOQUAjOfF0kJLfirOScq?=
 =?us-ascii?Q?VZXXPpgvqPXDimO5JiMkhwb7+2C3YKWWi6965QriAmWD2s8j2GV7qorOsvT2?=
 =?us-ascii?Q?+IjJLp8YSHVXylRhKnMOfjlm6VTfyuenu8dyMIF83X2OPBsio1X8QKbx4xZP?=
 =?us-ascii?Q?JMbfHSejmVNS1y+c6ycT4BW/MzqOHezLD2HG2ubfttk2SKRe+1I8f18EtXYR?=
 =?us-ascii?Q?An9usg5Xk4WQYJ7jTQfa5ji5G8tir9hLtdPrOmaRpTNO5kyjMOAJgJyhG422?=
 =?us-ascii?Q?dEmtJKmtFIdtnE6tRF+kUbe5+ihZMZnSegI4A0jmVv1kRNNQbXE9spt5zu+0?=
 =?us-ascii?Q?3APAZ4f8txYoPvOAhxORnjknxiIKQ4gMQh/2cnmwciPQQfuhqvw/+28XeIh6?=
 =?us-ascii?Q?nWNy3pqus3fY6Ga6IhApkREr/atmVVVjgndSIFycz5AEIpHlIKcMEdIUZd3I?=
 =?us-ascii?Q?yeN9/H0NyWxb9z+uoF2N+HLn3wRk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1nt9gmwReRrjsYdO+sWMveCv/bYnpe5UVuOrhrlnuttZlbIOAia0NRG33R8f?=
 =?us-ascii?Q?nRok1zCrcuqvyxxBv+dBYaKP/N78Oi0jXf8NMNCW/7HfAsCUZV4mJxsSJC6r?=
 =?us-ascii?Q?by6IdagoY+4hC67esKsMikApfjgSUTTMm+zNEUm6h4XBB4FYttkUv4ipahoi?=
 =?us-ascii?Q?l7w3ftGr1hbswdRBPwoxhUzcUvlCz08ZCaPnfFVyGkvf8L1KGl0nEh9ImYI8?=
 =?us-ascii?Q?0fSDHxPRj1wAOVhmwoycMaHu8Sge5cyUgOs1KkRq1UXxOerU3rIxfuoHtI2o?=
 =?us-ascii?Q?kGOA/B16cJp1dx6Pm0QBujnwKzUNAWlCoyHA7Y5d01bubMpB9hG75V9tQsr9?=
 =?us-ascii?Q?1kgu+bvQUcx3/2rIZIcoca8r89EOTdEJx2DPLuJw/Mc4uD1zW68KdXnQXXqj?=
 =?us-ascii?Q?shiNtp9gOqLvt2tNAEueoERbQvWMJ06yu867dLhadyK5rLNAklpzC5LRhX+q?=
 =?us-ascii?Q?V2bi9NsUay67/OrFJULm/wbsNxh5s1L5xI4vhJNj1XHE5bNGUqOgxtEg/rpl?=
 =?us-ascii?Q?Ln8CcxHSBT2pWf3NfGI/FcYURTYue8JVBYXZ5WDIMlVwXpBAGS3CJSYLeXc0?=
 =?us-ascii?Q?QrltvJlcktkXWAySUOkmDjgXxWxDDHrOkKPEHBmy8ZEIUBEp7DDMKffTvzBo?=
 =?us-ascii?Q?+lsYb18+EWQvusJbM0LLYkONW9/oxO20N3o+p4LOiQdSEC7VDMITcuZ6R7OK?=
 =?us-ascii?Q?VayxgHgRIJsAC+u2UctEPyeavTIVYSu69VmJsi/cNNxICagm7VjVLexKmpkF?=
 =?us-ascii?Q?ZByKLa0qvxP5pN49wHNvaEHPS/249tlqeFQVd1n2o1umma/eCPXjhliFgIil?=
 =?us-ascii?Q?9lmol1W5n2+x4ogpkBa5awzahfhPFcX1AP4XyqUFm2m1DcCE4PbZB1iYs4bi?=
 =?us-ascii?Q?qEfvW8Awix2IWFymwodjO3A7e6Z1jmab+hrDuQIlk4bRVG7GXP283uZjkvDl?=
 =?us-ascii?Q?ZpfEMcFUUtrbgtH6disBH2iO524O1GEjHZw56A7B6R0P72dD42sKF1wLOz5w?=
 =?us-ascii?Q?rwGbuuW5WbFPnOVMk00nSP+/Xby3do4KOIyKzqL+nM3Nm1Sh8gBqPMmuYJGU?=
 =?us-ascii?Q?Lrrw8NuBAfmo5/Ua/COPUFWnrV9ToItpogAQDJ/QyhJkpZy1qbdkOR8+hxH4?=
 =?us-ascii?Q?Efvdq1XWOMCiLKi0urZxzhTrqM4DGqjVIdNtKCoRbsJ4/l6+GYfwpmk+a5Y0?=
 =?us-ascii?Q?oL1r4xgjhIphWvA+X2nZUpAie8kiN4ujDTFLDJIJcp90MkPS+1Jh2AAAQQvh?=
 =?us-ascii?Q?3kmknqwiEw51q88Y9N+mSkbkoOOdUcWgiULE5TrfQdRVTIxynfwCPEiES7QX?=
 =?us-ascii?Q?0wFZWAyWxoZLMJH/7kxrHIxo6jOxtoc8wAlGeDwFIN4XfniPwdZ+240i5XiA?=
 =?us-ascii?Q?iVgArakkE/MTu8YkfcKDEBLztpDFdvgNG7berC+9fClsnKtozgt6C142Ewz6?=
 =?us-ascii?Q?g3WHvM9EQEJcFoyvyPaxcPsxnZ1Swa1lBsZdKdohZXsiBMzXSj1CdPg2s//z?=
 =?us-ascii?Q?D3gW3/M15YnFzSiFYSfhS61QK2oB7NmBXMdRDHqBSd/3a6XQ5E3Dj0osRipH?=
 =?us-ascii?Q?Ok7f+v1VFUyjW7CiFH6DZz28g8IurD/OxXQMLCoX?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4e1796-7b8c-4dde-7402-08dd50f4b281
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:50:05.4794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7d3l+cDBAWEIFb83KNDyZall0UtE7H2ThD5bY1+GMvLxztDqyVAzXPjAyupxkpqI+Xt08ucJeOOlYiZ/CHKYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10096
X-Proofpoint-GUID: Dc41D4D_I3yjh-4qinkryyGFf1mmHN2X
X-Proofpoint-ORIG-GUID: Dc41D4D_I3yjh-4qinkryyGFf1mmHN2X
X-Authority-Analysis: v=2.4 cv=HMQ5Fptv c=1 sm=1 tr=0 ts=67b5efad cx=c_pps
 a=bqH6H/OQt14Rv/FmpY1ebg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=1OX1_22eDB2b9HH4iF4A:9
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

Add support for getting basic device information.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/common.c     | 34 ++++++++++++++++++++++++++++++++++
 hw/vfio-user/common.h     |  1 +
 hw/vfio-user/container.c  | 10 +++++++++-
 hw/vfio-user/protocol.h   | 12 ++++++++++++
 hw/vfio-user/trace-events |  1 +
 5 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/hw/vfio-user/common.c b/hw/vfio-user/common.c
index 634f95f2e3..55d1da4e51 100644
--- a/hw/vfio-user/common.c
+++ b/hw/vfio-user/common.c
@@ -30,6 +30,13 @@
 #include "qemu/sockets.h"
 #include "system/iothread.h"
 
+/*
+ * These are to defend against a malign server trying
+ * to force us to run out of memory.
+ */
+#define VFIO_USER_MAX_REGIONS   100
+#define VFIO_USER_MAX_IRQS      50
+
 static int wait_time = 5000;   /* wait up to 5 sec for busy servers */
 static IOThread *vfio_user_iothread;
 
@@ -1072,3 +1079,30 @@ bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp)
     trace_vfio_user_version(msgp->major, msgp->minor, msgp->capabilities);
     return true;
 }
+
+int vfio_user_get_info(VFIOUserProxy *proxy, struct vfio_device_info *info)
+{
+    VFIOUserDeviceInfo msg;
+    uint32_t argsz = sizeof(msg) - sizeof(msg.hdr);
+
+    memset(&msg, 0, sizeof(msg));
+    vfio_user_request_msg(&msg.hdr, VFIO_USER_DEVICE_GET_INFO, sizeof(msg), 0);
+    msg.argsz = argsz;
+
+    vfio_user_send_wait(proxy, &msg.hdr, NULL, 0);
+    if (msg.hdr.flags & VFIO_USER_ERROR) {
+        return -msg.hdr.error_reply;
+    }
+    trace_vfio_user_get_info(msg.num_regions, msg.num_irqs);
+
+    memcpy(info, &msg.argsz, argsz);
+
+    /* defend against a malicious server */
+    if (info->num_regions > VFIO_USER_MAX_REGIONS ||
+        info->num_irqs > VFIO_USER_MAX_IRQS) {
+        error_printf("%s: invalid reply\n", __func__);
+        return -EINVAL;
+    }
+
+    return 0;
+}
diff --git a/hw/vfio-user/common.h b/hw/vfio-user/common.h
index 9f4243a67d..11a80d4e7c 100644
--- a/hw/vfio-user/common.h
+++ b/hw/vfio-user/common.h
@@ -93,5 +93,6 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
                            void (*handler)(void *opaque, VFIOUserMsg *msg),
                            void *reqarg);
 bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
+int vfio_user_get_info(VFIOUserProxy *proxy, struct vfio_device_info *info);
 
 #endif /* VFIO_USER_COMMON_H */
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index 7b1c202517..c079d6f89b 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -16,6 +16,7 @@
 #include "exec/ram_addr.h"
 #include "hw/hw.h"
 #include "hw/vfio/pci.h"
+#include "hw/vfio-user/common.h"
 #include "hw/vfio-user/container.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
@@ -152,7 +153,14 @@ static void vfio_disconnect_user_container(VFIOUserContainer *container)
 static bool vfio_user_get_device(VFIOUserContainer *container,
                                  VFIODevice *vbasedev, Error **errp)
 {
-    struct vfio_device_info info = { 0 };
+    struct vfio_device_info info = { .argsz = sizeof(info) };
+    int ret;
+
+    ret = vfio_user_get_info(vbasedev->proxy, &info);
+    if (ret) {
+        error_setg_errno(errp, -ret, "get info failure");
+        return ret;
+    }
 
     vbasedev->fd = -1;
 
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 5de5b2030c..5f9ef1768f 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -113,4 +113,16 @@ typedef struct {
  */
 #define VFIO_USER_DEF_MAX_BITMAP (256 * 1024 * 1024)
 
+/*
+ * VFIO_USER_DEVICE_GET_INFO
+ * imported from struct vfio_device_info
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t num_regions;
+    uint32_t num_irqs;
+} VFIOUserDeviceInfo;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 7a3645024f..6b06a3ed82 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -6,3 +6,4 @@ vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
 vfio_user_recv_request(uint16_t cmd) " command 0x%x"
 vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
+vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
-- 
2.34.1


