Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E094BCAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13UP-0007xw-Ab; Tue, 23 Sep 2025 09:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13U1-0006g3-EY; Tue, 23 Sep 2025 09:55:08 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Tx-000443-QR; Tue, 23 Sep 2025 09:55:04 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N9Yjps2985871; Tue, 23 Sep 2025 06:54:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=E5PawF9LNJdckPbimiheXX+/q2W73/2UkxagmtvI3
 X0=; b=u7qX6CLklkPpuAwqhC3ZT3Jei/9lYuA8++CNfGQ/+qfCyAXQxcDcwLRDL
 Njd2T/TqGj4TMnadM6XDVJqaMSlF7ZWYSV6I+o2eDCvRWMTQ6LSEi277HiOuj9KY
 hVf4o3DPqcd5r2ryJOKqBrGz0arMLqhgs4UUCaFxfytUqDNgaoqWt6aDTOV72nkz
 2tm6nERqiAOCN4ureqTac8OMF1Vt+keQTFP1p+cps/W5G21u+Z9MeRRPcioZ546u
 DmpzyCI8eiARF4TcvwQR+jMp9O8GK47g17E2y4qwpWexokpdkGAAEcsmvRrhOqiN
 TuKbyCzUpOAEB5/Oi8kZldGKH0lyg==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020111.outbound.protection.outlook.com [52.101.201.111])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49b6tju02s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:54:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrZa9OjXCZ2UMtdvic4fO8/cpiUuR9PMmh8ZuJk2KCZWvaRQjcEM0SQs9QKfNOJfd/liodpuNb7GKGLJo7eRl4w6/9L96uXYUOuGdJE4QjGcfRVAjbYfs3+gsuWvoV65nc6SyfrHgnL8C5GFsFKv8u4TiVPF/WVQYVhge52TyM+hBfTr7osTv4d3QfcPDRkWQKYvTAGuoQ1vNEuYs72h3idnk1Ujuu29WLqJDyAQtXz9iDEomNYdqY/t57IL3D0fCFK6VJA8KlDm6Z65DPt05IU8aMVRQNb9bJx2HR5qx3Cq80utgQENeKGtL/X4HJRDtbEhOiBM9PdnOywbLY2zjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5PawF9LNJdckPbimiheXX+/q2W73/2UkxagmtvI3X0=;
 b=ASi8yyAFWolXjI7BfaKL3GNX7+RTOFBjQFRtA6D4/ua063Gtv2HyaHfQEI4Cr9Gp5mPgQqWMwDeABv8n2DPRzYcxuuBbO2EJA7uKWepQG8J8Iu1KCHf+5hk5Qie1W1cpmZe6bmUEDx9SgKuJSQBZqpzejim5ZsD6fkCqCiuOoOyXlESrrkY8CbIK1I9dZRqKzN31JoTtgAFkaHLmEnWzCiGdFsgFOXaShRhRxOnAYE4KCm0hvRqxK9mYrRHv//LfaV7D7zU1AXm4BE9J/N3ULIoDUZH3SFWlKbk26SHEBCNs86fsQ/fan2wKLI5r6yarzdulx0S3jIXx247cr6nJMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5PawF9LNJdckPbimiheXX+/q2W73/2UkxagmtvI3X0=;
 b=QVlG1bihJhCkD7ft26tOWQacB8D0rPnYRD2vTV2QKLT1cm6a634mNnxnW69UYZ5fNNtFD8nzb3Vkpbwcl4zQY7UuheSlOcVxuPnDdGF2bq4sT9w4x909UNECxHvkbW7wyxo3zkBHzm7y2k5Tk9PkRkgiL2+ctr9A1SBbNXQr1lobXAiSXBx3OB6Thz1vauS+5VL6B/7wvgWNc5dsJv8KI8xFgjUa/HAkGpHK8Ez72h/pvAv1omj9pXvhfn62UujFi6PB2W2b84p1WOkI5IG7qESHtHLZpKKEfe6kJ53jywJkO3DAlvKq7ToRLlHHa/YbfYWyiFp/7aS/dg0WwAVRaw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7742.namprd02.prod.outlook.com (2603:10b6:a03:320::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 13:54:54 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:54:54 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 16/27] hw/vfio/types.h: rename TYPE_VFIO_PCI_BASE to
 TYPE_VFIO_PCI_DEVICE
Date: Tue, 23 Sep 2025 14:53:22 +0100
Message-ID: <20250923135352.1157250-17-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0096.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::49) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e390a6-8180-4a7a-8bac-08ddfaa8c61c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OXp/dbHhT5Ot4wlnECva4u4kNSav6d/V1ZpIYaZb6kqQLq0vu7xkHuqlQefR?=
 =?us-ascii?Q?ZaglDVrJDX3KQEZQlxgA3XVZb/ZL+divhdQYJ1CC3EepvhQm2zxKVmQid2ol?=
 =?us-ascii?Q?ldy7abK9aFRbVH9/HrZaOfRXzmkJqgty5cbe/21xjaeT6IMvu+wV73auWkrP?=
 =?us-ascii?Q?hN9fWHz/Y+b01ecYaVPuhl+WremoZKzADkTkft2/q3oVWhholppQmXxSzBAE?=
 =?us-ascii?Q?eAfRpI2GqSORoa7rwdY89JNQVvDoTbFZgSn81LB0OKsMadnJrtkwu70QLdoP?=
 =?us-ascii?Q?7WbWk883aILZCB4VR34DJlNuCpmjsOI7wP0RSbkqhotBBsbuOtspi4ANXDqS?=
 =?us-ascii?Q?8oU3d1jbu7Lsg/AU2EFjE/9okGAlVf3lC42cdNPzuGdboHWQvQrAFCz+K+Zb?=
 =?us-ascii?Q?qLP33PhY0BfMmFq9AsmOPwMeo3XgWIcuq+8Tsr/xgkXHMBvfRjnnJeFIZHen?=
 =?us-ascii?Q?imrhy/u9gxqel638NNuANqwyMZi8BDfXT7EtAFrFifpWygQ3CcY0fzHJ6KNf?=
 =?us-ascii?Q?ixwMEhEC38nF2Zr/0UoP9R1qsAPHBQiL5nkyIP+2ZiY2xVPFwvqEibZ6jqoY?=
 =?us-ascii?Q?TVzxTok+/EM0POsKEadpw6/INJLjwuUsUYSvrncbnZ3YfblX8ipYNLcETYGl?=
 =?us-ascii?Q?4OhPrlQW5HRt9XQGlWMcflCRAhzb8Mat3UB0n2wvvZy7lF3tI2GjDbEQvplW?=
 =?us-ascii?Q?JbO8qW8kKgC7K4NCnSyE1sRIilc1h4yAsxOLpZ6wKfN2LBHzVWJB/h2Y8ePL?=
 =?us-ascii?Q?7uco1C3sri9LoibKGlEqgtEkybPl1qV/pVgjQFS0T6hEjxcRhuEEgaYd0QQV?=
 =?us-ascii?Q?pSHREkl1dZdrTUSqq3tEvxldNl0ZEQynsAseCRi85/5RAe5Wf/G50EPec6ZJ?=
 =?us-ascii?Q?SxdWnAfEq2vpeNC8Ho2NLcR1CgzCgI9ZaT2Gx37OR0vRyFQnpaXBoK1jPcfS?=
 =?us-ascii?Q?+dijmLE09OE+fo1vvo5kobmU5JyeuZxII8qkWAgumjne2/FHIDPKbCL8zMsm?=
 =?us-ascii?Q?YTj8Oqq47vpKwkNKtArU1Og9EqABYzP0wsd39NjG92w4500Z/3sAyN7gt9Rx?=
 =?us-ascii?Q?ef1QekzEVmiYJbfxj8eDv4SXq0OoWf1DKzC09dDRf9wkK28FlpjdXQp60ruu?=
 =?us-ascii?Q?xnUAFZkfOINArXGoY2ufou6gTT38zf1ktRNYRkRzfE2g5fWoOV6jX6/YTum/?=
 =?us-ascii?Q?C9zQ0+dQISMLTAHZ1XhyUhRbzeDA5WiM5VPmk9YAlX+w9YvSb7vqgOz28M5o?=
 =?us-ascii?Q?Z276d9vsKTHeeJP2L37HWVW7pOzFpMRaDhi2LMJnqO0UAoJlauwWkDMwj+hC?=
 =?us-ascii?Q?dEiAjnhKIdgQTVPBHyTLQ5o+i9UAG6P1t3SYCvQM2g7t054+0LRpoAQstvUJ?=
 =?us-ascii?Q?OzkiQ82w3n+S5wmABKVIBjQgf8IXpzCsRmD7zcmbnfdiqUaHy6eYKh2N2UKM?=
 =?us-ascii?Q?WUQUV3aDE8N0u/t86JFRHR2X0AZryujT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ha+BdPcfrbX3UrFcDEcjmTEBdQCUuqPblD6L3vHQslEZ/X2NOLvk/gKuHOIQ?=
 =?us-ascii?Q?pJCXnfHVUudGzagfWylja39lkQK0gxzkngIFFtPlXuaqxlNfufJ5WGNbt+v3?=
 =?us-ascii?Q?qpkwEK2l/8uxSBxW7dwCy6zoSvBlAHvUAdzYbv5RKI+VZoJZvZSTx2cixeQq?=
 =?us-ascii?Q?Gri/Gu01JOQIV9ZFRS7YdVx/1UNIJtzebMgos1hgKewvsikQd12YM8twigPF?=
 =?us-ascii?Q?Fn5jdJGkWR+87gXR2V/od5B8z1l0M5JXjcZgQQDwgsAoRmoLSE/keIpZXL4f?=
 =?us-ascii?Q?x+Lml+Xzx3DRBrmMfhGJR+6/VdOn1VPSuep1voxnWxhJARv6T79rs0BCnSvd?=
 =?us-ascii?Q?p9P9PY7TV7+zOvtwBTSoGz7VV1d9wRw6oxKirzgE9UwFYt6lAfw7HNhAMAYo?=
 =?us-ascii?Q?ko7mYjVLjkcvi2Z9wKZdboCEZimoBq9vm3koQUJSNdegfOK5YfYMs0z+gI0F?=
 =?us-ascii?Q?9pigCP6lEgqvK00dsmkm3h/l4+IEmRy3AfANOEFzuk9T6dkvUKbXjW84fP/L?=
 =?us-ascii?Q?GsieB9c2FY2RpFIjRSCmRugMuXuuapRpwJ8O6dz3giaE16z8QAqlZdXOuFXf?=
 =?us-ascii?Q?ZY7LHDmZXuUpAzjFA47b32GbF5LPVQ3+uhwy1RB6xuH2UepJBlrIGVuFTqjM?=
 =?us-ascii?Q?u+o3W2kLyEk/d7NMieHeN9vwufBocW/+mymrDpLXUZvD0HDrma6WfOY914j1?=
 =?us-ascii?Q?DQjZP1vQO6ljXTGAM+9i3eAG96FjTKRDg3xn7Hs5issLXmhWyEhOTdwoQrHC?=
 =?us-ascii?Q?OHSf7eLVIYnCyaJHIFUkvC7cEbsX6s+2HivHXvcw2JLK/AZhcSFihMpMuf+n?=
 =?us-ascii?Q?5P9MDEIBmlBeHkxEUYXDH0XD4pbAzxTg4qLLQgYUW0g7TA0p0UhQOZc52AS2?=
 =?us-ascii?Q?5tEGwB8kMz1QGm/XxlR5W/mjfJY/SXbCW5Y0vezeejN+hI3hXIKIH0sJOd/2?=
 =?us-ascii?Q?C82coDjqGIiW6Mc6/YPAvr/z7N/gbH0HwCZ/ifLV2SBj2STOkS4BYEl0rSER?=
 =?us-ascii?Q?zNX5tLXlLrIgAsgwjJEUPHp2G1b0SplH0OXVZs9poiYBP3RYnRoCfoLXYTV/?=
 =?us-ascii?Q?77i48bbZHfnAhUGKRVixal8aL29vpLNByLksFYCKzXI9HzCXRq7NxL2FU2nv?=
 =?us-ascii?Q?jRGh3HHqnalwtcyBzaqhAfnegezLG9DDKz5jiRws+z+ZKKl6BYoUz8mJV3Vr?=
 =?us-ascii?Q?dRjFYWTqJJUdMEBorn89otDUGArBR0T6nNW52yhghXzV7Zvj+yZjtmqtiZ8M?=
 =?us-ascii?Q?fcVEox/zKKulG7iyp4rQ5ZLCkfTsHO8Iw+imcSOhOd6qu9NEu976cdhvRyjH?=
 =?us-ascii?Q?9pV24uRYtcpiMajvCwLMvjLg0fh9kmJtHEomeMbXCeHK7EMXhPxgZ3QVSOnJ?=
 =?us-ascii?Q?885FL95An2G2/Hu3r/PGacQv9mZzUmarJmemf1V0Kw6b1wqao7NTcoVXE5YY?=
 =?us-ascii?Q?uJQ1vCukY/n0qr5T6xeUipRPIHaXgeigs4TQM/tMhYLgq5LPrWNJptNqIl3H?=
 =?us-ascii?Q?8Y2wLfv34gTjGsxuLx4jUSUlWFprNgU9Zqmb3cF+RKW22J9+r685RBxY7yty?=
 =?us-ascii?Q?WX4w9fmRLohi21RvBq+dMcd2kB2OdMRuc19zOfNqkTPs8K75ThhjmDkzv56a?=
 =?us-ascii?Q?AngjvZECn0ZiN+UfPHpaeYSelULr9ayk6iq8Ns5TwjAwCLBBSDqQDxV18uvP?=
 =?us-ascii?Q?os6qqA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e390a6-8180-4a7a-8bac-08ddfaa8c61c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:54:54.3787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZY2CoNzd0og80H1TN0XRkRFhPiFGVJhlMID7cXYTBjVCn2jJdxJOdmbtu5cfHnsd4V9z1DRtyYTTjy+z811cjW7Y33Wm/tmSkXSCd3wgYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7742
X-Proofpoint-ORIG-GUID: Ym-XG3_XshT-U98umnikWRHipwD9gLES
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfX61JVcieRfTfL
 wmIE17hmBp4VuC6EmfcUBhDsgV8xllaakB+E1J4o0XTZms6OUHPPG0rU31irHZkESlog/U5J71U
 GBuM8KW3TSSIILBhwcybdwaM8rvPIzQtYT7QY5HSoW/7MVS+ZLZVI1I7OTyPj7yDV5fKrLKkX2O
 9DcHsh3hYSYr6f2TArzMgLlT/+iYnMqzA3w3ucH28cecrI60fYBmtlKCHE+oWNIbd8irNNX4AGv
 zbplCJQEvoJ/glL020VgauWmWwY0QD4ciCjcXZhvJ57G4VDJlZl4u5Vk2aVfo4bh1Xu2AnZa928
 suUySw8m+0c5D6PrDiVyc9vNaCEJVhs88G8AyPVAqEHXyelq47GY8S2YvTjYq4=
X-Proofpoint-GUID: Ym-XG3_XshT-U98umnikWRHipwD9gLES
X-Authority-Analysis: v=2.4 cv=BJSzrEQG c=1 sm=1 tr=0 ts=68d2a6af cx=c_pps
 a=oMcH3klX4F/By2Lov16jbg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=kqlIrpWXdM3z53z3dXEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

This brings the QOM type name in line with the underlying VFIOPCIDevice structure.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/s390x/s390-pci-vfio.c | 14 +++++++-------
 hw/vfio-user/pci.c       | 13 +++++++------
 hw/vfio/device.c         |  2 +-
 hw/vfio/pci.c            | 28 ++++++++++++++--------------
 hw/vfio/pci.h            |  2 +-
 hw/vfio/types.h          |  4 ++--
 6 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 7760780aff..9e31029d7a 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -62,7 +62,7 @@ S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
 {
     S390PCIDMACount *cnt;
     uint32_t avail;
-    VFIOPCIDevice *vpdev = VFIO_PCI_BASE(pbdev->pdev);
+    VFIOPCIDevice *vpdev = VFIO_PCI_DEVICE(pbdev->pdev);
     int id;
 
     assert(vpdev);
@@ -108,7 +108,7 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_device_info_cap_zpci_base *cap;
-    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_DEVICE(pbdev->pdev);
     uint64_t vfio_size;
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_BASE);
@@ -162,7 +162,7 @@ static bool get_host_fh(S390PCIBusDevice *pbdev, struct vfio_device_info *info,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_device_info_cap_zpci_base *cap;
-    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_DEVICE(pbdev->pdev);
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_BASE);
 
@@ -185,7 +185,7 @@ static void s390_pci_read_group(S390PCIBusDevice *pbdev,
     struct vfio_device_info_cap_zpci_group *cap;
     S390pciState *s = s390_get_phb();
     ClpRspQueryPciGrp *resgrp;
-    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_DEVICE(pbdev->pdev);
     uint8_t start_gid = pbdev->zpci_fn.pfgid;
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_GROUP);
@@ -264,7 +264,7 @@ static void s390_pci_read_util(S390PCIBusDevice *pbdev,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_device_info_cap_zpci_util *cap;
-    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_DEVICE(pbdev->pdev);
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_UTIL);
 
@@ -291,7 +291,7 @@ static void s390_pci_read_pfip(S390PCIBusDevice *pbdev,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_device_info_cap_zpci_pfip *cap;
-    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_DEVICE(pbdev->pdev);
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_PFIP);
 
@@ -314,7 +314,7 @@ static void s390_pci_read_pfip(S390PCIBusDevice *pbdev,
 
 static struct vfio_device_info *get_device_info(S390PCIBusDevice *pbdev)
 {
-    VFIOPCIDevice *vfio_pci = VFIO_PCI_BASE(pbdev->pdev);
+    VFIOPCIDevice *vfio_pci = VFIO_PCI_DEVICE(pbdev->pdev);
 
     return vfio_get_device_info(vfio_pci->vbasedev.fd);
 }
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index e2c309784f..efceae69de 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -234,9 +234,10 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
 {
     ERRP_GUARD();
     VFIOUserPCIDevice *udev = VFIO_USER_PCI(pdev);
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     const char *sock_name;
+
     AddressSpace *as;
     SocketAddress addr;
     VFIOUserProxy *proxy;
@@ -346,7 +347,7 @@ error:
 static void vfio_user_instance_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     device_add_bootindex_property(obj, &vdev->bootindex,
@@ -371,7 +372,7 @@ static void vfio_user_instance_init(Object *obj)
 
 static void vfio_user_instance_finalize(Object *obj)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     if (vdev->msix != NULL) {
@@ -387,7 +388,7 @@ static void vfio_user_instance_finalize(Object *obj)
 
 static void vfio_user_pci_reset(DeviceState *dev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(dev);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_pci_pre_reset(vdev);
@@ -421,7 +422,7 @@ static void vfio_user_pci_set_socket(Object *obj, Visitor *v, const char *name,
     VFIOUserPCIDevice *udev = VFIO_USER_PCI(obj);
     bool success;
 
-    if (VFIO_PCI_BASE(udev)->vbasedev.proxy) {
+    if (VFIO_PCI_DEVICE(udev)->vbasedev.proxy) {
         error_setg(errp, "Proxy is connected");
         return;
     }
@@ -464,7 +465,7 @@ static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
 
 static const TypeInfo vfio_user_pci_dev_info = {
     .name = TYPE_VFIO_USER_PCI,
-    .parent = TYPE_VFIO_PCI_BASE,
+    .parent = TYPE_VFIO_PCI_DEVICE,
     .instance_size = sizeof(VFIOUserPCIDevice),
     .class_init = vfio_user_pci_dev_class_init,
     .instance_init = vfio_user_instance_init,
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 963cefc053..64f8750389 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -423,7 +423,7 @@ bool vfio_device_hiod_create_and_realize(VFIODevice *vbasedev,
 VFIODevice *vfio_get_vfio_device(Object *obj)
 {
     if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
-        return &VFIO_PCI_BASE(obj)->vbasedev;
+        return &VFIO_PCI_DEVICE(obj)->vbasedev;
     } else {
         return NULL;
     }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6e8b872275..6d2ca710c8 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -305,7 +305,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
 
 static void vfio_intx_routing_notifier(PCIDevice *pdev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     PCIINTxRoute route;
 
     if (vdev->interrupt != VFIO_INT_INTx) {
@@ -660,7 +660,7 @@ void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr)
 static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
                                    MSIMessage *msg, IOHandler *handler)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIOMSIVector *vector;
     int ret;
     bool resizing = !!(vdev->nr_vectors < nr + 1);
@@ -755,7 +755,7 @@ static int vfio_msix_vector_use(PCIDevice *pdev,
 
 static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
 
     trace_vfio_msix_vector_release(vdev->vbasedev.name, nr);
@@ -1346,7 +1346,7 @@ static const MemoryRegionOps vfio_vga_ops = {
  */
 static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIORegion *region = &vdev->bars[bar].region;
     MemoryRegion *mmap_mr, *region_mr, *base_mr;
     PCIIORegion *r;
@@ -1392,7 +1392,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
  */
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
 
@@ -1426,7 +1426,7 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
 void vfio_pci_write_config(PCIDevice *pdev,
                            uint32_t addr, uint32_t val, int len)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t val_le = cpu_to_le32(val);
     int ret;
@@ -3396,7 +3396,7 @@ bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
 static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
 {
     ERRP_GUARD();
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     int i;
     char uuid[UUID_STR_LEN];
@@ -3556,14 +3556,14 @@ error:
 
 static void vfio_pci_finalize(Object *obj)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
 
     vfio_pci_put_device(vdev);
 }
 
 static void vfio_exitfn(PCIDevice *pdev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_unregister_req_notifier(vdev);
@@ -3587,7 +3587,7 @@ static void vfio_exitfn(PCIDevice *pdev)
 
 static void vfio_pci_reset(DeviceState *dev)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(dev);
 
     /* Do not reset the device during qemu_system_reset prior to cpr load */
     if (cpr_is_incoming()) {
@@ -3632,7 +3632,7 @@ post_reset:
 static void vfio_pci_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
     device_add_bootindex_property(obj, &vdev->bootindex,
@@ -3673,7 +3673,7 @@ static void vfio_pci_base_dev_class_init(ObjectClass *klass, const void *data)
 }
 
 static const TypeInfo vfio_pci_base_dev_info = {
-    .name = TYPE_VFIO_PCI_BASE,
+    .name = TYPE_VFIO_PCI_DEVICE,
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(VFIOPCIDevice),
     .abstract = true,
@@ -3762,7 +3762,7 @@ static const Property vfio_pci_dev_properties[] = {
 #ifdef CONFIG_IOMMUFD
 static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
 {
-    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
     vfio_device_set_fd(&vdev->vbasedev, str, errp);
 }
 #endif
@@ -3918,7 +3918,7 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
 
 static const TypeInfo vfio_pci_info = {
     .name = TYPE_VFIO_PCI,
-    .parent = TYPE_VFIO_PCI_BASE,
+    .parent = TYPE_VFIO_PCI_DEVICE,
     .class_init = vfio_pci_class_init,
     .instance_init = vfio_pci_init,
     .instance_finalize = vfio_pci_finalize,
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index e0aef82a89..0f78cf9cdb 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -120,7 +120,7 @@ typedef struct VFIOMSIXInfo {
     MemoryRegion *pba_region;
 } VFIOMSIXInfo;
 
-OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_BASE)
+OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_DEVICE)
 
 struct VFIOPCIDevice {
     PCIDevice parent_obj;
diff --git a/hw/vfio/types.h b/hw/vfio/types.h
index c19334ff25..5482d90808 100644
--- a/hw/vfio/types.h
+++ b/hw/vfio/types.h
@@ -9,11 +9,11 @@
 #define HW_VFIO_VFIO_TYPES_H
 
 /*
- * TYPE_VFIO_PCI_BASE is an abstract type used to share code
+ * TYPE_VFIO_PCI_DEVICE is an abstract type used to share code
  * between VFIO implementations that use a kernel driver
  * with those that use user sockets.
  */
-#define TYPE_VFIO_PCI_BASE "vfio-pci-base"
+#define TYPE_VFIO_PCI_DEVICE "vfio-pci-device"
 
 #define TYPE_VFIO_PCI "vfio-pci"
 /* TYPE_VFIO_PCI shares struct VFIOPCIDevice. */
-- 
2.43.0


