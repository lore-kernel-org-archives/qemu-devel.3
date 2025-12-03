Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1121AD12691
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 10:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQjht-0004Wl-5y; Wed, 03 Dec 2025 05:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQjhs-0004V6-IU
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 05:03:32 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vQjhp-0002z4-1l
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 05:03:32 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B37xXUZ834742; Wed, 3 Dec 2025 02:03:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=oXdd5n/XaBMniqmEaSEBt3nyhMNGJswskVf0WygY8
 d4=; b=pzuEAuVF/gu6E9RzXIqK39tfm7GDWA6IeHV/7vM1ogIunYt3lMcl4rkND
 sPW8HCSzCNu3B6LK6+bk0QhlHWUdSvuYxB5NaMUphn7LoVq+SrGNIhfSBfbuSqeg
 GUXjTwS/xwPZ/SJYZSbvz9FthKlPq4iztW/9wmrD3UsU7JVV2s+4U2zkIEQvQvQ7
 f/R9Pv7pEReWMiK1iEP56R0QCzIbQQmDIb33kRiYQqxRz00uuacMw2bqVL5XAZIp
 rwzOvvm3N5hF7VZAYXtB4jFtienVwl85uZABw+ZQlPVMyx+ePI7v4Skrl90bZ8Nl
 z5hmPlkV8GuU9Bs0ZK4DtVOiuatPQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020112.outbound.protection.outlook.com [52.101.85.112])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4at4909wwb-5
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 03 Dec 2025 02:03:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bi7F2ccoMw50Ubpx7Xh4hQHpawIok+JW434dtidAfeM8Cmw2VojbL3NeCvyqIt3jzd1Hvnpd835UJC3PxDmWuKxn7+8fIDBnAPp8ApVLBniqxWaG/c3x4RZSE4+jYS58nuIEPRgcIczcLmx3yrOHJkLvuGs9dKv2Uj6I2ftEKnKKdPwKUAWY4nGNi80onfCcOwesTJ6VZXgptisp61Tq6ZMeTKe5x0gffNMkp1EWqBhNDUS5Fr/ESDROoqJmFDRgyGbHsgB86HlWApr+t86psPU8Rq5pGKqaPNKeUxVK/OQrQt8Od1zjJ+iJeDhSh4mBl/3cvHj0N1mOZTlaf/FM6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXdd5n/XaBMniqmEaSEBt3nyhMNGJswskVf0WygY8d4=;
 b=v7p7RO0jIIgwq/XD1y97BPkVXoY3Z6mniWTR4Owny/SIJ4a+sXtDFY+eLoeP+6ZP1uKihfouR205drj62amXSY/+5qpEuE7HsBEPqQ/ntpvekacn6uRfDSxFaGBpzRaZl2VHg7beBwp7TFw2x4kEzTl6VQLzXQB+PIL2Ja8Tr76MBIX91AT3U45hgHv1ei58KgmZGHxB/p5CIjx2yynDssI8KlfE+oX2DseDFKeecFPzRzu4TeFij3D6+G3B+T8McG3m89iOocV+YEHM5hUKC4iECvIOrEw+r/L2sbMq8CL24sV5GgwH26hO4EDuzvnoji+6JaRkKsG3Rw+9Q2z1yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXdd5n/XaBMniqmEaSEBt3nyhMNGJswskVf0WygY8d4=;
 b=vy4VigcNYDof79RjG+56MLE4dsa3rwpLsuhuvC/S1xFMKFKltQ2xcOA8sWG3/Uedr6l08XT/es1HEXovOnfun+nt6rOQ8CCSPDcQn/wLln69eZByBFFSINnvN7PSxre+7cJrygasYg/pLek6hyKEsaZh96myGr/0JKsqyDXMxZRqjv2NVE8e+zsV0XuL17hcbt1yNUOGYLiy3h4vGwtwzvHSiZ6zaIU2xz+2yYhbgfB8clJFrPCFPpRlVzSYpKzU/TUt1tX20/gLBpDNBavS8rVPY0iwELoCiKK5yGdfHVtUyrpEewB4lSMixTJH3F3rcyf4kq655MNBgxFH5Obt6w==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS0PR02MB8927.namprd02.prod.outlook.com (2603:10b6:8:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 10:03:24 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 10:03:24 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 4/5] vfio-user: simplify vfio_user_recv_one()
Date: Wed,  3 Dec 2025 15:33:14 +0530
Message-ID: <20251203100316.3604456-5-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203100316.3604456-1-john.levon@nutanix.com>
References: <20251203100316.3604456-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0456.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::11) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS0PR02MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: 296c6fa8-b614-4f48-fc12-08de32533232
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FfkJRr+iGqk3Qtu0bG0vEmkvDWefvHrVFjZBjGV2iUpGLKLoAsuqSV4A/5nG?=
 =?us-ascii?Q?U2x9VHLCItP1Vzl/9xJ5NKVM/zyeFAbl0r8wEWGclFAIRSGsn0eZ5gCtCcGP?=
 =?us-ascii?Q?OdXh75fYVNvIH5Ybth+npU5wq0R+HiK0X53YSkHLjE0svGaClbFvIleEyIor?=
 =?us-ascii?Q?pmtqgPPruFF/7zcEfLOm9MNq2FIbA+zPJam172i+WIaT7vwwlA6oMi6axEJ+?=
 =?us-ascii?Q?mY721PEpOv56O2cdPGcOlpweNJLrmXxKhQU4WafliFj9/fdCBaMxXhIUUEyO?=
 =?us-ascii?Q?6Lo1F4zpKV6EPlltsfU+twENORpxloxBda1PYnYJfIby/P8YmjgwrcOsdqm5?=
 =?us-ascii?Q?4euqdczvYeFrhnNQaXzcOs8wEFYCHxGNppx4JTT5ZlZCUC2CkpbEJNjdLd0S?=
 =?us-ascii?Q?7naxJzxYfbd4s1S3+00xAFvOo7y9CRyN2Ht9fIOjlThEnf7ZeCChhWuA+pLc?=
 =?us-ascii?Q?ljq+MDyHOge/0M8FYVbVUf5fYEmfUHViywRcOcRxzI/Ay1COBf9wHBxjk/nQ?=
 =?us-ascii?Q?U7kDF1kfRw+izyT01wDI7cJQUgyelZu7z8BRYTl+r/Qz8IBHI/yIP9NXIaEV?=
 =?us-ascii?Q?o/2xeSTjHVCyN6Pz9HeD191eOPUKIYtk2WzEegUHF/hFQDAoF+PblilKHtH1?=
 =?us-ascii?Q?npljnc0BlN1QPViS5uydSEw+JR95ZLd5Sp1Y/Y57EscmIfp7dOFa9eCGPlj3?=
 =?us-ascii?Q?9Obm/kJnRD/YYGoxXWONsTluLZc6Qj+giwIn8jQj/Eb1nkwsEqR84LN8FZ4c?=
 =?us-ascii?Q?L2lPRHxhrcWkoQehsWy3kZgPvLYEeKcVD74fdYxKhAC9BvWNlVSV/K2UTfgQ?=
 =?us-ascii?Q?K6pespYH4s4IVBQbOw/C0tsTF3vCWuKC1t8O2pZ3nSCvm7N4DC3PHl/QXl7T?=
 =?us-ascii?Q?OeMxik0NthlHnm2Tm5gWsdsnbQdpRQSqZ2woQ6HkHv0sWhrJ2wRLbbYvOhj3?=
 =?us-ascii?Q?pR3BQGHFN188vdlw5zQ9FaBrBo5TYJvP+GKLqKmxtZ0wNBkHF3JiDMZQRmf8?=
 =?us-ascii?Q?iw8dcJPVs+qq+35YMaYlyZ4E+ysFZ7z1Gc8lVWF/EjhH03HIV6mLjpHw83W1?=
 =?us-ascii?Q?mCSiMRC1azr7sC6Hz414rfnI6mIxeLOEvmLZ9l1/DaUJ3BPeseRhDNX6Bhyg?=
 =?us-ascii?Q?GaInoeRaPU/9tb38Wfp6CGyRiQNgUKsbOEI7NUH79ult8+ui71IAJzu63lY4?=
 =?us-ascii?Q?G3xuacN8MzxdyUN3mmMD2QmL5D/MP5XA/0kKci2u+ki/M6ywjVWMr1tAp4MN?=
 =?us-ascii?Q?0hx3u6owHeey+6PDY6l+a2AAkQNIkkTEsj6giV5YhbyErG1ecprgJtQ8GD8c?=
 =?us-ascii?Q?WsnsmxfVjN2SsDfo/1AmhKk/oMAIRLHyndaNKOt8YA9DZfyO6zUZv+qySscI?=
 =?us-ascii?Q?BmO6ePkn4iIrzpncyW1VBbg9Ph5S50Tve3gFnrt9fUcNiuMuqIPBNT8a+1/K?=
 =?us-ascii?Q?rlyFVCrOLwMvnNaSbRzlwDzPDcwcAtxx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RRwsZwqzjnvD1v4bG2AcJ8RLxBe3zMqWUkQpqBnGTBqPakZUPizeQEVhQTt8?=
 =?us-ascii?Q?agBSjhPtz/9LAVHX818MO0fHgi40cGw5oM9HxkM5ZJaGqcHhusmHrIaXJopV?=
 =?us-ascii?Q?OE2ZXQfkNikkYq9zHL0PVKh47JshhJNhZM3NlG+KaiistS/9ArYSxmfgId1E?=
 =?us-ascii?Q?99VDDnagb3E94otheYBGPzwz/HZS4U0F0ayAgCHix2KTSLZgEPXSQ39aBRyh?=
 =?us-ascii?Q?u/NWvUsVYohVinNRgYiuv5JWp/gyB9SPApVKsY2ywgfH8aK6DOI1J7CALVyc?=
 =?us-ascii?Q?s4x4u568/ijWKvXYcMp+chiEjYBPPOxhJWeHzn/VuD/lxN41Xh9Kmmmghd13?=
 =?us-ascii?Q?bessT8ZzG50+HHCKF0dW7rwFLKqkLCfV+YFoqnMeIFXVfMyA3oLseWna7P2q?=
 =?us-ascii?Q?pYEYYrNJBii+yzACduDwsC8z5PTujNda+fQxB27x2j3ZtkcmcFoOvyKJV6vM?=
 =?us-ascii?Q?wBuOYeXeCytZMZ90N/jt0LcVopPv+7rKZJ0rcfnRZrk4YaBYqLvaYp5noLm4?=
 =?us-ascii?Q?erSAXGfDOZITDsAAlxdP+DQFnYb9Bmk6uKfjCw25JKRCtVqnRmByRvzEW47d?=
 =?us-ascii?Q?xX5lAAIbLz+fHipi1YnqUdX9v+1VbNwPLdfXy8l44v4FN46aditm4NG5uTZw?=
 =?us-ascii?Q?2GWEKrJh3x2DkK6HqnVxmnF0pzFwty58z+GB/+63SQAMGK2AAqW/N0UgeFcS?=
 =?us-ascii?Q?h10HBAHZE81xSElzxzc+qyVH6S6bp6U9Dv7UhVwBdaEKuuZqXY9s8VdwW/xg?=
 =?us-ascii?Q?/5latY0Cg2tjRb75jQJDyr1UzO1CIyi3/HEEYKQDOmOTGqy3iz8Hx78g5wSs?=
 =?us-ascii?Q?EG/e/FniYbgjgIJLm4ZPE8Dj4XviiloHbR/1C31GN4IMsaVcl07WFDMAJBob?=
 =?us-ascii?Q?t4nxQd3QcGhhXoBiuhxXG5GyXcCJYJEq/IEdHA0ottJuZ6OfCxHW5lG/Bj3U?=
 =?us-ascii?Q?ZyR/3u5x0xiWC0VT0d6BKdwnytZB2ZzRN++tDfiAPIPGFKdmQgIC1BkMvNf3?=
 =?us-ascii?Q?0qr1T4RIJ3+N+iSxljEEZnKlGyRyac0ckSXcGdLTcc7ZYVwHfUkCyO7c7+m8?=
 =?us-ascii?Q?mRg63m0tGIkZXnquSjcRETLaG/8CcVjSnlHoj0jsiPdSxk/q9KulGJDLW5IP?=
 =?us-ascii?Q?J3YxOu1kPw8epYsQdgtpJiZ4F3talSZS6Wzro+WujKimjfYct5eTSONOBjug?=
 =?us-ascii?Q?uF4h1d1wanZ4lU9A02LA8r5696Vngi2e6od+21a27+quUSQ1Zb0yPAHy86Uy?=
 =?us-ascii?Q?2ENn3VF7BchCkl9fmiaSRszd3W6jd9/pR4q4Zn4XDeePD6L5luvjweSxOJhZ?=
 =?us-ascii?Q?AEOoYVIUxzwlF3NVaTEsdi/8IvANLrUP/ViD5/86P68HGVmmj6KIfhihMC6V?=
 =?us-ascii?Q?dtHge6yk+eq1rnMMZJpVgUSIIONk5YVlc18lZKcEWVtusxkvkOf0M707vgmI?=
 =?us-ascii?Q?eCuicexmoDtSsV1AnUq1a91VMsjqD5uLgMArx6iMHLbsE87pJWsiW6WOZVwG?=
 =?us-ascii?Q?4qfVT+WQLS4QffwNrOTy93QpJUTfh2VXj2VxvSvG/6t0o9j81eUCRgwoyAbG?=
 =?us-ascii?Q?NlR8DqyrnXmJcT3UQ2oQDz7P87KwUQwPOe1qIz4Y?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 296c6fa8-b614-4f48-fc12-08de32533232
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 10:03:24.0143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8vMfX8JIUqj4UZYpn71p6aNipxBg9cs98SW5KgRqY4OJV+06OXUSy3tH33Ioa6pScGbShIT4YSJjuG9oAzXUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB8927
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA3OSBTYWx0ZWRfX/5AK+wX+Ni1b
 EIsUXlsjuPMXjHdiaEAM0pzoRG6T7kgvttHvPQXXwbq261V7V6dVHsqtnGFt9WOJUOJuXeY36vj
 bPcj+MbTUCiDYcwN4eAmrQB84+VXk5j5HC7PstagZlSCtTPFC+B7un+XSU0qMbZrMlWlOApsaYt
 hFvm5C8EOBJnhFQI8f8I+gVUF9bAvjozpmUKXaFTldfKIvSZWZwP2xij0b6pxvNRvyu0zfdWWrq
 LfsVeZt7Twb9iELvVoezgwIgRQYIpuVH2qxu4uiNCk1DSZ/pjpJ0ua6exiWL6onVAL3cbMef1Xs
 na4znUCocX/zA1lS5aOMCbG60OaQnt4QR1If3gx5bsyWK271TfgaLZNMefaGViP5R8G9HqkjATc
 rQv9d2IBs5VjUXP6kLNqHiKMaRsIgQ==
X-Proofpoint-GUID: qNdfC6pUQ-84XVcpZ0uGUDKsS3VMISvB
X-Authority-Analysis: v=2.4 cv=Gu1PO01C c=1 sm=1 tr=0 ts=69300aed cx=c_pps
 a=1sVWB/l5Kn3omZIicXSEwA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=jnA1zMGvAcXXG4Qj4jYA:9
X-Proofpoint-ORIG-GUID: qNdfC6pUQ-84XVcpZ0uGUDKsS3VMISvB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-02_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This function was unnecessarily difficult to understand due to the
separate handling of request and reply messages. Use common code for
both where we can.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.c | 68 +++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 38 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index e0f9202535..f2601eada5 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -281,15 +281,14 @@ static int vfio_user_recv_hdr(VFIOUserProxy *proxy, Error **errp,
  */
 static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
 {
-    VFIOUserMsg *msg = NULL;
     g_autofree int *fdp = NULL;
-    VFIOUserFDs *reqfds;
-    VFIOUserHdr hdr;
+    VFIOUserMsg *msg = NULL;
     bool isreply = false;
-    int i, ret;
-    size_t msgleft, numfds = 0;
+    size_t msgleft = 0;
+    size_t numfds = 0;
     char *data = NULL;
-    char *buf = NULL;
+    VFIOUserHdr hdr;
+    int i, ret;
 
     /*
      * Complete any partial reads
@@ -317,8 +316,8 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
     }
 
     /*
-     * For replies, find the matching pending request.
-     * For requests, reap incoming FDs.
+     * Find the matching request if this is a reply, or initialize a new
+     * server->client request.
      */
     if (isreply) {
         QTAILQ_FOREACH(msg, &proxy->pending, next) {
@@ -332,51 +331,44 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
         }
         QTAILQ_REMOVE(&proxy->pending, msg, next);
 
-        /*
-         * Process any received FDs
-         */
-        if (numfds != 0) {
-            if (msg->fds == NULL || msg->fds->recv_fds < numfds) {
-                error_setg(errp, "unexpected FDs");
-                goto err;
-            }
-            msg->fds->recv_fds = numfds;
-            memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
-        }
-    } else {
-        if (numfds != 0) {
-            reqfds = vfio_user_getfds(numfds);
-            memcpy(reqfds->fds, fdp, numfds * sizeof(int));
-        } else {
-            reqfds = NULL;
-        }
-    }
-
-    /*
-     * Put the whole message into a single buffer.
-     */
-    if (isreply) {
         if (hdr.size > msg->rsize) {
             error_setg(errp, "reply larger than recv buffer");
             goto err;
         }
-        *msg->hdr = hdr;
-        data = (char *)msg->hdr + sizeof(hdr);
     } else {
+        void *buf;
+
         if (hdr.size > proxy->max_xfer_size + sizeof(VFIOUserDMARW)) {
             error_setg(errp, "vfio_user_recv request larger than max");
             goto err;
         }
+
         buf = g_malloc0(hdr.size);
-        memcpy(buf, &hdr, sizeof(hdr));
-        data = buf + sizeof(hdr);
-        msg = vfio_user_getmsg(proxy, (VFIOUserHdr *)buf, reqfds);
+        msg = vfio_user_getmsg(proxy, buf, NULL);
         msg->type = VFIO_MSG_REQ;
     }
 
+    *msg->hdr = hdr;
+    data = (char *)msg->hdr + sizeof(hdr);
+
+    if (numfds != 0) {
+        if (msg->type == VFIO_MSG_REQ) {
+            msg->fds = vfio_user_getfds(numfds);
+        } else {
+            if (msg->fds == NULL || msg->fds->recv_fds < numfds) {
+                error_setg(errp, "unexpected FDs in reply");
+                goto err;
+            }
+            msg->fds->recv_fds = numfds;
+        }
+
+        memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
+    }
+
     /*
-     * Read rest of message.
+     * Read rest of message into the data buffer.
      */
+
     msgleft = hdr.size - sizeof(hdr);
     while (msgleft > 0) {
         ret = qio_channel_read(proxy->ioc, data, msgleft, errp);
-- 
2.43.0


