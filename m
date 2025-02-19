Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A80C021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklOJ-0003HC-B3; Wed, 19 Feb 2025 09:49:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOH-0003GY-IQ; Wed, 19 Feb 2025 09:49:33 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOF-0007Aq-9Z; Wed, 19 Feb 2025 09:49:33 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JBVcSa008853;
 Wed, 19 Feb 2025 06:49:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=UHAnUw18hvZ4CndV3ruk0AynqvJjp1s0gnGiSY7SI
 vg=; b=ExFF4vMYl9JTMlNFZXTvZZjvnMvNbkFKpnjUZuUEwvn5LtqxL7IWuPt9H
 zk710KiYVjIET6mXI++DLLdgF4nRxMDW3bYhPvxpqOnBEqcIF1UyRh21VU01lfBi
 Hnzprhq3VkQjgvyyLf+Ox6jc0k1JDjRv9EjHRiZpVq+D40ZRJ3DbCDWiwVWAAY4b
 9GXbw5xUBIxqg2sGbQ5WgpXssoHsar8IVxBBM3HHTVmbQx5KaNRyIMuonfhPjUaW
 jMdPmJLtQPlnq8vN4nrwwvDuUzhIqKmSFKV5r8J2kFXjHASngwBv/ca0yK6ocpP6
 CGo05intoyzrdJTc4sAqtqQbFVl2w==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazlp17013060.outbound.protection.outlook.com
 [40.93.20.60])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4basy8w-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:49:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaiPKZpYXT+8stJ3m//FV0JSi2SOi4bEdFVumFlZqImvC0k6m2KVaH686eG9ckGd05RhXHRn96e2yBLSf8HA80YsoU826+TNydalZERLd1oWt2NUi2fxwCxBZmrCiPZWrbkM8G3A6AcbQnCPLW45uPdVVub1ry+pwONrqk1V/ftj88q8Fi2SpLgLA2qNIRHDG/BzjptHsQywoiZtNHI+4Hslq8/d+8YGmXZzPd18bX9W8oCWaZwOrC7n1uxrYW2uMlqOTgl/2+YniZAI/Xf2mhR6TAJe2brzPFEbPUeg3x1+TOaHMo9BRLNEqmLR7kh/qt69OQ9HcDCuIy3dEZsu3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHAnUw18hvZ4CndV3ruk0AynqvJjp1s0gnGiSY7SIvg=;
 b=ahAj8Z3+LafwiYAjwSJ+gPHP3KZ3g6L1fpYYQea0pipxgSvnmsgvAOGCfTFSPJCZd+udWjjLufDvjdLWjGG1rdpULtZIHcXq/SYcyRwQ18gxLb+YcSN7z4CKH8VkN2mZnBqrZDwXIlyBQ9p/WwPv6OfN2691TjVzs+1I8TyS/71Er2MscOvaw7HdnRMsBZvl2IjtrOmbhUXe83l/hUdoVBWnLVwarbsZ1NGx0+4Lm8xt+90xvF3XzoWmvg2zPeTTMNpUhUngoUXGvg0B3vTty8Ix+kyEm9RHdm18f6JHTqTRWT7C2i0c9DT4NTw1PPUf1oXHdXZ3BvwY9WbzExNe3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHAnUw18hvZ4CndV3ruk0AynqvJjp1s0gnGiSY7SIvg=;
 b=Yao/eFFiVqOpnnD4l/xb0rDs5Fvn2y6WUygIqyiIo3URUotBT5b67RaDZkoQ+bFyBkV9BlIBv1ME67rYLK2T1gl8p6a3I9tuBed2dsLD6ohkEmGn+2+lXqnqz49IHA5drU6j7qFqqHuBz3noF5y9b0qd9MGTbP0R0bpmDx0vzMNu3UAGpTMwPpcQurqBj2y6BXEGy6LI+wcB+u7EKg0DgspwHLOGuNGZ9cGvhW9Cd0DR6jCKb3G5KyE4jpYaGuml+xVGDIABqnFXx9yhkpK3iTe991QUxErWhjJuK/G/no6XnoqF7ok5QcMbec8c6sGWCHFX8NnxnuG6U5yHuM4NlQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CH3PR02MB10559.namprd02.prod.outlook.com (2603:10b6:610:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 14:49:25 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:49:25 +0000
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
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v8 04/28] vfio: add vfio_attach_device_by_iommu_type()
Date: Wed, 19 Feb 2025 15:48:34 +0100
Message-Id: <20250219144858.266455-5-john.levon@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CH3PR02MB10559:EE_
X-MS-Office365-Filtering-Correlation-Id: 49fac329-03c1-403c-e66b-08dd50f49a35
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aziQnzZDnXBaNemCA2+LkDHB9CR0YRXlzw2fVCZhWKXsmNk8NgNBIjoNji+j?=
 =?us-ascii?Q?w0MrO5GDakmEDL81SCOj+aVOoWKT1aYqLElv2tGu3w0+wUEhV2CUf7QP4uPY?=
 =?us-ascii?Q?Npuhu7OZ8v8z+ivrqNwfvDkB7tPBs0d1S2soEB6qPr/X1N4YRG/TwnjP3Qod?=
 =?us-ascii?Q?yjc18n65zetDxD8xF127T/Oqizcrqw7Pmyn8d2WueEWDH/EfB0kJN9aCn1my?=
 =?us-ascii?Q?tt/OxQC/Pur/Vh4nNKg8BRnt/CG7mhFJ/DhnYI/LaxZhPtyV/6iylS/ebr+k?=
 =?us-ascii?Q?pWbsmvafnBrnUyfVM74eWAfaHAJdyhSl9GQepBkHHTBBc3jyZB7QZv0Ybxla?=
 =?us-ascii?Q?rW8tw1ffLRPDTjRDaIJ74tclBWNzWNRCQFdbld1dXqzNv0GYdCwtWggC4Th4?=
 =?us-ascii?Q?SsUxbB07xtSZ99IjYB3lW5q/v5Lapyrd5OqlKObkaWbJa0nLQwzWJM9RbRDX?=
 =?us-ascii?Q?zTBIPeSkhYpbuGXTkQ68WhjsdlxJb12i6QfIGkLSWDY62oKgeTbs+iBoO6CK?=
 =?us-ascii?Q?7EDDN7lF0HGNxqLksYWF5lhepe3Ql7ocP9ZEyUkLbx+9MULnOpcF/WLPU4+8?=
 =?us-ascii?Q?Kz1X7Thtl92qRELmEISv8/rrVoa/7JnKVV1K3zw5f34rs+yZmsUol4kfOl23?=
 =?us-ascii?Q?xxMr4/SY+9djCF8hc8mmEf1w5B7O3SQ6sNajZkNo4HqcI78rBImCJwCKw9yK?=
 =?us-ascii?Q?ZBGMel340CRqfQ0PD0ByQ3MIMKJkSDSS58aguJKC8IgOajX2Z5OT6G2pzcpo?=
 =?us-ascii?Q?IW0JyeWdMsvJYURl97CEYkIgdkCBDjCmw53z0HMKrQ3kH2qkGLAT2COHxkv9?=
 =?us-ascii?Q?rjgSRbPcK+WZP95FiUgjtovCgpYT3Bcr5+4sifXji4EvBnKxNeAICGdSmUNP?=
 =?us-ascii?Q?gSCmek39x3S+XzI6NC95ztaoMmB0h0XzGbWnJJ8OPM4tCk4EkIUqbEUEMpsH?=
 =?us-ascii?Q?MJnvQEyrGd3lr92MfX8e5pE1i3XJ72p7f5uHjHQcK1IWjCqP70fEXqkBtIKI?=
 =?us-ascii?Q?XFrMAnZtlYKbznpPE2NJhOBHIyqbt5WADxhgBKZLkZMSZQEW6t86usw4JMRu?=
 =?us-ascii?Q?jHb25+kD1g6UZf/auJbvvKVCW3E11J5xNOg9cdhk4ZaRU0mWzvAKCtISqWuV?=
 =?us-ascii?Q?5iNNqWXf3zZr0RLpMBbydFUeD0vD5dQ4Q+MUNLoEJs1tnjBh1D840styw+dL?=
 =?us-ascii?Q?5wFwi3/1Me5wo4NGnpY/Oz+Pth7tnHCbwu3/yASRTXOsUjGiA9IRLPI2h9jk?=
 =?us-ascii?Q?k5Ysw2yHz42V2VIRSuYjMUgWFV2E7X3XLQO7eMyaZWXXlnpwaOIHgVcZD5zC?=
 =?us-ascii?Q?KXw8/HdJ0QAyiCQvQqzOBWB5LM8DmFyk+BiqOZYn2uFQGR7DOy+Hbwh3ErXc?=
 =?us-ascii?Q?8PSoiMFYmSekeFPBBsxysWAz9bLD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cSGfoOJXLIoI8ltWJV3W7BlRfwyJOTwtB2dN5QEd9KLh3YS37ThWPdy+ECtU?=
 =?us-ascii?Q?glaxqYeLgdQweS7U/di+5k+jhz3fblC0ITzu+w/ST6BkAAk9BNYgjKgon7/z?=
 =?us-ascii?Q?yRI89BmhEP4Z9zVxLvxFVUWUTEBZo/lDeAAMDhxnwen+mFELhbPjN+Y8FR1d?=
 =?us-ascii?Q?Vxme/xRjG14rFa479UOqMm3gn0RDcnPvL4f2YcImIkmyYae+qwjE36A3rZs3?=
 =?us-ascii?Q?KI8fSb8AMFOxAokbYiSUvf3QlwkCJSplVFVBz0B9kBtQd+NHmM5vTLT3qs1C?=
 =?us-ascii?Q?1cTdsmLKmQAaaL7iU4NB09J9Pjgm6KtxKxfBMNfH1YYMGJ43SvmNAUM0OCpP?=
 =?us-ascii?Q?1NQq15Ft95K+VSg+mQLyPP0kAOUN/b8H9qVHCnF6hUSOI5FCaC2paZAdpTR4?=
 =?us-ascii?Q?eXlqBNy1kSLO48vCYCKcBHdN2aqTr1GZryH0V7Zab07RWgAFKfIBdvIbr+q1?=
 =?us-ascii?Q?vMojwFaJD6bD5DI8V9b92aF8Z7eAUtWJe4BZEt71TrgszSxolX4S9OGnYNhR?=
 =?us-ascii?Q?1hRHJ78AgcNDmiwPn8s4dt77n3nlkkc7JVBQjwvqqI3YFn9oKZwnqn692CVb?=
 =?us-ascii?Q?pXq4KBaQ1RPilhOEs94lUqLBJEmhm3kbodIYQ/IdaLMB7NCVDtKOdGUXKez2?=
 =?us-ascii?Q?3LLtwpyU0o3RkBAzzRBzan7E7KciPTp9i3B7x8Zjjj8Tj+zPPY0lX1avplvj?=
 =?us-ascii?Q?/9RK8pAP7OXM14qFC0xEjaof9GG+VZ1xoasHi8JLsVuof43fjyRH8BOUlA96?=
 =?us-ascii?Q?nzBS30Y6H3mJO3ra+aAKP239+U72Av5b7Pse1IbaKXjpIR5N9gZ3ry5aZQLk?=
 =?us-ascii?Q?z9o9Kxn4xmjY3GwWVxyxlWMvxVTGSnCINiIitfDq/XagSRWql68kvhKewtWi?=
 =?us-ascii?Q?iJAvAyQ+Yr6XVrcAf1L64QLEYOqtqk66TJwl0XXK7YbPhSyMehZQdx2dA/5R?=
 =?us-ascii?Q?iLdXG/VE8EcCR4/Kf7zyT/e8/6mW5itdxkMaEPARMQ+oPEG7QJJw/AIhSqPE?=
 =?us-ascii?Q?to+IHwjjnZH0RHna3oCrRv/fMk4D2Zw2gZKbHgFOsuL3RaPjt49k8fQSNSkU?=
 =?us-ascii?Q?iV7WkDRial5lHvpijmk43ltGd1KHRObOPeMp2MP4pJi2U+fLoqKMoiTt38AD?=
 =?us-ascii?Q?tuVz14fqHbZOVPKXGdI3hQ5X+np1etaWujLZDQtVr/fNN8ELxIwYvz+schbS?=
 =?us-ascii?Q?Z3vxuOqUIuaBE2gLG3AOGbQkIBhiIUDyAjdDTEBVvDL+lvu+1dDjvqAaiVlK?=
 =?us-ascii?Q?OiZMRlUWc5gNwg7bXgopMEh0t7effsx7TmTGd+xDzh90ah+L0QCzwzM+FR7L?=
 =?us-ascii?Q?otp13jgLZbGysTXHzNGd8cAW2q7COJcN6BcdJo7X/wycpBMXbYJIbn3s/6Hi?=
 =?us-ascii?Q?AvV8Wd/ISI8VodUjT5yYRvbfNlFXhw1ppTGKn2lfYQZ5MAwjIc/X+4fwI8Jx?=
 =?us-ascii?Q?SAYNMU+QAVcY0egXxDTvpvRsqddTE/0/Rcsgdp2VO/WdGJfu+Smf0LT0P9Wj?=
 =?us-ascii?Q?f/lUy8nGt+O+f1WX++24KJfLgMvk8m9/K+Y/UgRtN2dUrSOdP+U3OGLTPCM2?=
 =?us-ascii?Q?513hxBUhCa+Gqx8YecVoGMZOl8df60TXkSFdUJ3j?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fac329-03c1-403c-e66b-08dd50f49a35
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:49:24.9180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S268tu0+I+q50bDpfxc7JLYRJ5RuD9WyNRyU57DupAfZvVRLtif5SD+GOa0WDUguVibWJu5uDq/AsBy2300wkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10559
X-Proofpoint-GUID: 9KB3nlOKFlMHb_RZWsuKSzSlGY3dvWfo
X-Proofpoint-ORIG-GUID: 9KB3nlOKFlMHb_RZWsuKSzSlGY3dvWfo
X-Authority-Analysis: v=2.4 cv=d58PyQjE c=1 sm=1 tr=0 ts=67b5ef78 cx=c_pps
 a=4HTA/yvmbQxnAJvhdENERA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=1ktPcj0v_YJIm58XXvYA:9 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Allow attachment by explicitly passing a TYPE_VFIO_IOMMU_* string;
vfio-user will use this later.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/common.c              | 30 +++++++++++++++++++-----------
 include/hw/vfio/vfio-common.h |  3 +++
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index b49aafc40c..eefd735bc6 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1569,25 +1569,20 @@ retry:
     return info;
 }
 
-bool vfio_attach_device(char *name, VFIODevice *vbasedev,
-                        AddressSpace *as, Error **errp)
+bool vfio_attach_device_by_iommu_type(const char *iommu_type, char *name,
+                                      VFIODevice *vbasedev, AddressSpace *as,
+                                      Error **errp)
 {
-    const VFIOIOMMUClass *ops =
-        VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
     HostIOMMUDevice *hiod = NULL;
-
-    if (vbasedev->iommufd) {
-        ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
-    }
-
-    assert(ops);
-
+    const VFIOIOMMUClass *ops =
+        VFIO_IOMMU_CLASS(object_class_by_name(iommu_type));
 
     if (!vbasedev->mdev) {
         hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
         vbasedev->hiod = hiod;
     }
 
+
     if (!ops->attach_device(name, vbasedev, as, errp)) {
         object_unref(hiod);
         vbasedev->hiod = NULL;
@@ -1597,6 +1592,19 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
     return true;
 }
 
+bool vfio_attach_device(char *name, VFIODevice *vbasedev,
+                       AddressSpace *as, Error **errp)
+{
+    const char *iommu_type = TYPE_VFIO_IOMMU_LEGACY;
+
+    if (vbasedev->iommufd) {
+        iommu_type = TYPE_VFIO_IOMMU_IOMMUFD;
+    }
+
+    return vfio_attach_device_by_iommu_type(iommu_type, name, vbasedev,
+                                            as, errp);
+}
+
 void vfio_detach_device(VFIODevice *vbasedev)
 {
     if (!vbasedev->bcontainer) {
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index f4f08eb8a6..c40f8de6bc 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -252,6 +252,9 @@ bool vfio_device_is_mdev(VFIODevice *vbasedev);
 bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
 bool vfio_attach_device(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp);
+bool vfio_attach_device_by_iommu_type(const char *iommu_type, char *name,
+                                      VFIODevice *vbasedev, AddressSpace *as,
+                                      Error **errp);
 void vfio_detach_device(VFIODevice *vbasedev);
 VFIODevice *vfio_get_vfio_device(Object *obj);
 
-- 
2.34.1


