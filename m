Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142F2C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklOz-0003Ug-A1; Wed, 19 Feb 2025 09:50:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOy-0003Tj-3Y; Wed, 19 Feb 2025 09:50:16 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklOu-0007W2-RK; Wed, 19 Feb 2025 09:50:15 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J9LnWt011251;
 Wed, 19 Feb 2025 06:50:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=wP9VKDoVdVMgajX1HZl3mwV4iHY8MTZ1OCowAKPBY
 7c=; b=2K6elqscgQW2lmY7/TZfr0eX2oDuZCnGrM6puEjxtCGgpRlznZsyvAYQN
 bqcAdggYnSQJQpdC5BxNmLuJ9NztlFhG3IkUwHXoWMr1ptGI2lBBzg5nIrSKsOCt
 xZhpH+bjI2+4lCojONqM8JNzWWs1g1nTAX87K48y62G9IDwGQ9wqVm/sHdzugcDL
 p8BhRK7GU2wU39nS8AaH3/UY8r/bO+Ni9iVImKII89/zFtjocaaOd8lYVMwxCgGU
 jTRJqoApYD8/vwhnnxU3pStQHYdWM2z133ESPPrZ22sV6m/JYBD0/ADbzKJ4iZD/
 ev+I0fVqLOaRoXxZ+ouzfR1psqMxQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4bdhxxr-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:50:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=taYq6wQpZ1dhXyK3aWqLP+FcGTW7mJPmirHpjz9wMQyWqG4KKb+g7EtGiCl+ENqzccQ51QrEsjbD7vWh/2pBO9m9Dhy+Vjm2Oxjqjcp5AKruW9SY3/Fao/jtEjQhHS+r0KK7GvDd24GcYfUd+JWbsgIYtRrbqzEvy8GbIfhjKJoPYfBbx8fTkUqpxPRl+8C5Ffzm16ZnXYuzXMUikOdIf5FYXgzKTVHBytyYGXtDJTFlTYf1lQcoKqd8LQeeY2NcHjWUJIrLvB+4h56dgtXpng41q+x3Dk/zjcJejSgT2JfgqbMVyYaNVwDHOpPMt4kxPBgaP9qT+Vi3AKQnGcVt0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wP9VKDoVdVMgajX1HZl3mwV4iHY8MTZ1OCowAKPBY7c=;
 b=sNH5ZOdwpfce/qyujhC2u+DOlH5r+LP0qb/YIZUeeCmo3lTlK9L4pDAY4mlhpiL5tPt4orA2edH3wEax+H56B7mn2qdYBAVI6wiYGRmV96kqnRyDppd0FEZ0UVvEPTHMn7pYVKsxUKfW0uDr1fv1u6AAHzKukxJuZ37bPn8HropGx7p25nRGisKDy25rknlj/BLk8VfJ1ncYBOJiQiDV6VYzS6nfynG00IKmj+WIUBttd/IYhDZCZxco1hDrpbVwOFd11HEr2V4wwc7blYK38ISzfBKptC5LMFp2l249HHf7V/BecXr+CLfrB37Vy2rVj8SeVJ+l2BkWALke+tEo7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wP9VKDoVdVMgajX1HZl3mwV4iHY8MTZ1OCowAKPBY7c=;
 b=A1vskrQqf3lcSWmEDH7QKlT0KRTsZAG/ozwl689snLR/H/QuDWvqR6wqMUdOGfzvnzNCs73+r04ccJECg5idcug4ej752HcLGxmBvro9E4g4UgV4wid9vIrBi4k8iC+q6Av01NPK/RzvyFyN6JwYr602PP2C/VvXW1fliX9LwmqhGTYJ2mURVaw7XiEaROzxcBrc17FkHiBKU7qoSxmQO4BIPvvQX4EiPecngSd/SinhdRhr3/TmfTMmPj3r024ZiaGmm7q+iaQOPFdLDBsEDfr6pdHtSu71WX4WXZ7ASIGuLxwAsZK9w4u84+H6oqjORWac9XXXLx9O8nqid9Uq2g==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV8PR02MB10096.namprd02.prod.outlook.com (2603:10b6:408:181::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 14:50:02 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:50:01 +0000
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
Subject: [PATCH v8 15/28] vfio-user: implement message send infrastructure
Date: Wed, 19 Feb 2025 15:48:45 +0100
Message-Id: <20250219144858.266455-16-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 21d5852b-7310-421c-b7c6-08dd50f4b050
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pDVbP/lJBl7NvouFbqskF+Sc3+RD8+R67JuCIzQh4wnt+fLH5512TPuc1j0o?=
 =?us-ascii?Q?eZacdbslmgR9bXpcQ1hvugPTDZ9j7bEIW7q36j2aHx1GcV1T8hvQdQRc0ek0?=
 =?us-ascii?Q?UA1TbqwL4+S+NfR5Q83IoFCHYPvtlx9ecBoWa313GdkT9mfEWwaM60nvPR4A?=
 =?us-ascii?Q?SKwFYp8D5HENIq5Js99kMFiwvfpEyk397anzEkWQnMg5BPdLS4S1Ju1UCGNZ?=
 =?us-ascii?Q?mc+ZbR0aD9rdNRw0JjMXdQEVLT419+kqnk2nCob/FkkXqOplAWlZe2ZoZ/Hx?=
 =?us-ascii?Q?oFPmZkCUvw7mNXJVN8dnojBW1V0BTcBzKP/YKZEHRDgs/sDwxPQWh1Uw49H+?=
 =?us-ascii?Q?MvxUqghY0qjwIuJ/aYclVzEy691A66PYO/bGdyYpxg/M7W8D1v5kx+sD0vG+?=
 =?us-ascii?Q?94tcEpgZSYoZaobs4/YdvocL2N2NUIGay9d4uIKJk9DxerF2KWwEgasBB5CN?=
 =?us-ascii?Q?vPuMpKag5REXu4J+d/ljdQbi8T9u1cJBb+BauOvPg5T+XlHcJRzitiBXqs7S?=
 =?us-ascii?Q?Cu4Z1idZ0EHqnme1/+t5NvFHUa5Kn5rvgplZFd5HtsaOb0Gt5gIoOGRPJBbP?=
 =?us-ascii?Q?LJ1RDB2b4Q+FqWENQS9mpVYEaOJslk7VDxGeGKXtO7eE4GhXCFAFgRJFt8hW?=
 =?us-ascii?Q?6mE8BpCbNx9MvdfYYbfZcT2KtWUD9PgM0iU1iwAA5AC+hTvQqdlSSEi9u8e4?=
 =?us-ascii?Q?0hjYwHatgfgmUfhplkHhRILkg3Y8ntQPZBMBZuoER8wtqLEdiRqfJGvMUYx2?=
 =?us-ascii?Q?NO7Qs/3lv2ujdCTbqhWjNCZkiugjaLdMbUhX3qOJWe4mis5nhwQQbjyE7Z7d?=
 =?us-ascii?Q?VINsdKzptDffF8pl36w3wgiMBDr2N1uuAyrXaF9yMw6z7DJinHSlJolgsh/S?=
 =?us-ascii?Q?nXRvP8fNYhRP2Z6T69uU4v23Wf29CXOGVFWE/upGtPjFA61b2BPn1xH8vYFM?=
 =?us-ascii?Q?cXr2vOAinYuha0p6eIfJ4/mjolgc8W3p7KgGnTzH6y/hSVosW07qvQT7q2a0?=
 =?us-ascii?Q?JYaVBDdIOUywq0CRW/JSX5mWFXmz7PPLV2UurasbbWvR6+car/J3D7lf6wRe?=
 =?us-ascii?Q?1uTzjxmq9pzqbqcq8Byq7dTed/MmRmmeWFnFLPxZsbz7BHn3rIPfvizhyLv7?=
 =?us-ascii?Q?hddOwXdBdo3EcC80nKhUCpftnSepyBJ9c1OaGmCIHlB+WXwCVh7YB4Hnyjx6?=
 =?us-ascii?Q?z1gmqQCX4yJXEpQ2NLydLOsjr0iCxdYDb31Hf0/C1kVXWL0YSNNI2LwaRpet?=
 =?us-ascii?Q?Vkr+9Xf9o0osAU519FnnnRTIUn6ThmmyJcvYCo09dtoA3qxojCzzopSFyTks?=
 =?us-ascii?Q?NasRA2dJyFh6cMgIVgcfuhx8S8Q+4cylBed2mcizrAyjGksIM7P8JPJ1AupQ?=
 =?us-ascii?Q?uI2fqKQSWgZTb+alzXCr4A3CSqCx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?51gUi3ujjfUmZcOv/pM2udMctb5KrGRi1MFKThN2hYXzb8mXovswDip20dUV?=
 =?us-ascii?Q?xZ4S7Hx35iv+8V+9vdOGo+ZFJiGWtanm7hnVsrgPvMsTa/tBqfrL0T9jPrFv?=
 =?us-ascii?Q?mPWPrDCZe+kq/qAjaEz1/Fv5Y2SIkLXGQHFTW+GcrbqzGLz8cAljAS0N4o3D?=
 =?us-ascii?Q?BES+DTTpWImucNA5kLgAwdXn3UwQ3dXqp19hSct0IjtoF7AUVB+g93XD6yOe?=
 =?us-ascii?Q?VwBwOqlW7XhMfCi6/IJPtmbq6qRknvkssuCZlAO9Q1ttjbLA/rdaK0p4Zuy+?=
 =?us-ascii?Q?GxBmhp9WAduRzisYsGST+3mxv3c2mSUW22Vl38F9ogRYqYo2Ycfmwo1SIME/?=
 =?us-ascii?Q?oACAkWYCJetQR3ztt/Q8X08aW/LT1wbm6d4F3XdNBaABAhYVnM1u2xmuJI/e?=
 =?us-ascii?Q?ur7uaBUDf3MHNd0LDVZ9KoxFdpUjpT6/vzPI8jhGYZOgeJutQR0J7Z1xyP0t?=
 =?us-ascii?Q?TbQhZRYXOel/Hs2VpNUt6Q7uCYkKxLBuO9ZBHfWHVx2PXVNCaxYuvvHSrLLH?=
 =?us-ascii?Q?HvkewENWgEend9AIubyd0I2C2vE4HvtHx1Auoa+xAPe6ZwRn/gzpSHZ6Ss1p?=
 =?us-ascii?Q?k8g6ld9LJRszPdrzbB+KX/+CYHKqTsiru41/SB4OIYy4aD83CLa3wZnq0fwu?=
 =?us-ascii?Q?Ut8yy8Ol8zvXh1euNrZY9sqgDFPZHGVjj8h54yrXl53gmr5K7/VoG3U9DPtF?=
 =?us-ascii?Q?bbU5VD4E77ai6S9S5AUOvgpblyqgtXyAUPFA5koxSS8rh+4K8QkkCBhp4FGy?=
 =?us-ascii?Q?YF3uFgC1FcD7XAd49bgK2v0dqqY8J1B4ofLsFbKI7K00Uvx45KDm9VSDqBPz?=
 =?us-ascii?Q?yz3cYEK8eMlurbE2bZzF8AOxbbrgE2J2V8KM7B8zJJ/EO8DRz49rAwhyLwB2?=
 =?us-ascii?Q?TUMw3YvEbMNbc951IsapoN/BlSt608rMmLDE6qp+669ex6KLuJkC1LId9lYc?=
 =?us-ascii?Q?uOBC9zg7hRmJz0yf37y90zQf4Wbc6ccpasBZWlrKE0elPLXCKxw7OiQU1UQ7?=
 =?us-ascii?Q?wf6xAw/oILOoKhr4Gz9YrkQi6UyTSqp3UugpGm798uNqCoZIdU3A9FDLlQVv?=
 =?us-ascii?Q?Zj4NPMa4HpGZcQglOtJ8r80A8b/8HVA5gl6IrRbX/Kc3L9hTR8tRMVT90yzf?=
 =?us-ascii?Q?ltn4CLASOKrl8X/qe7CBX+IQQzs0TU3B8Rj5/vN8G4ryAbeQjKFd57X7n0pE?=
 =?us-ascii?Q?BnJyGIMDdF/GMlnrOFObMpai08n0sJve16bZd2uzD97iZie77FNZawh0pBPn?=
 =?us-ascii?Q?yFfukg/8LvCDM2OMzE+DDIaBH+t/HPxxfQ+TlmbBU9Cq7EX6X3XiFjAIYKW9?=
 =?us-ascii?Q?AxVrbvsuuqiONYIjmQJuIykst9/7ncKmgrYc9Cq0AL3FkoIBAIDMB7z0zxWE?=
 =?us-ascii?Q?myaoaxIk1YWmQwNAzK0T3S4+df3dbqU9LlyZ2adtFSE1XwYW8lDezs2Q75Gi?=
 =?us-ascii?Q?BXOwE29jrLYEkRfIZGLUFIxiONnFZzbtGxxrwcBQvWYHJmy53RX3Aa1/H3UM?=
 =?us-ascii?Q?TY7auUP3HKk9Hb3+SEUu1FRuF1gGGLMgd7hG2bFLV8Ag6NcLG7Et2KhbKpmM?=
 =?us-ascii?Q?odQX8jLdY5dxZ8EClGJKe6odj6AmP1TrV2l9/Bmj?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d5852b-7310-421c-b7c6-08dd50f4b050
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:50:01.8751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMSRiadyoVeH7Zsn5N+W28jN7jYy4Ou/6YgwOEhH2y9UlrIL8/+7tnaCgnzSNWES5lryVqdZH3TNUQU9NzVomg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10096
X-Proofpoint-ORIG-GUID: CqHtOcj3dmiGAHsheVtgMdn0h_hdlaiJ
X-Proofpoint-GUID: CqHtOcj3dmiGAHsheVtgMdn0h_hdlaiJ
X-Authority-Analysis: v=2.4 cv=Fo7//3rq c=1 sm=1 tr=0 ts=67b5efa1 cx=c_pps
 a=di3315gfm3qlniCp1Rh91A==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=UnscCpd6-9sbi9RN3AUA:9
 a=14NRyaPF5x3gF6G45PvQ:22
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

From: Jagannathan Raman <jag.raman@oracle.com>

Add plumbing for sending vfio-user messages on the control socket.
Add initial version negotation on connection.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/common.c     | 495 ++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/common.h     |   9 +
 hw/vfio-user/pci.c        |  18 +-
 hw/vfio-user/protocol.h   |  62 +++++
 hw/vfio-user/trace-events |   2 +
 5 files changed, 584 insertions(+), 2 deletions(-)

diff --git a/hw/vfio-user/common.c b/hw/vfio-user/common.c
index 2c4ee14ede..634f95f2e3 100644
--- a/hw/vfio-user/common.c
+++ b/hw/vfio-user/common.c
@@ -20,15 +20,21 @@
 #include "io/channel-socket.h"
 #include "io/channel-util.h"
 #include "qapi/error.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qstring.h"
+#include "qobject/qnum.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
 #include "qemu/main-loop.h"
 #include "qemu/sockets.h"
 #include "system/iothread.h"
 
+static int wait_time = 5000;   /* wait up to 5 sec for busy servers */
 static IOThread *vfio_user_iothread;
 
 static void vfio_user_shutdown(VFIOUserProxy *proxy);
+static int vfio_user_send_qio(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                      VFIOUserFDs *fds);
 static VFIOUserFDs *vfio_user_getfds(int numfds);
@@ -36,9 +42,16 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
 static void vfio_user_recv(void *opaque);
 static int vfio_user_recv_one(VFIOUserProxy *proxy);
+static void vfio_user_send(void *opaque);
+static int vfio_user_send_one(VFIOUserProxy *proxy);
 static void vfio_user_cb(void *opaque);
 
 static void vfio_user_request(void *opaque);
+static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg);
+static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                VFIOUserFDs *fds, int rsize);
+static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                                  uint32_t size, uint32_t flags);
 
 static inline void vfio_user_set_error(VFIOUserHdr *hdr, uint32_t err)
 {
@@ -57,6 +70,35 @@ static void vfio_user_shutdown(VFIOUserProxy *proxy)
                                    proxy->ctx, NULL, NULL);
 }
 
+static int vfio_user_send_qio(VFIOUserProxy *proxy, VFIOUserMsg *msg)
+{
+    VFIOUserFDs *fds =  msg->fds;
+    struct iovec iov = {
+        .iov_base = msg->hdr,
+        .iov_len = msg->hdr->size,
+    };
+    size_t numfds = 0;
+    int ret, *fdp = NULL;
+    Error *local_err = NULL;
+
+    if (fds != NULL && fds->send_fds != 0) {
+        numfds = fds->send_fds;
+        fdp = fds->fds;
+    }
+
+    ret = qio_channel_writev_full(proxy->ioc, &iov, 1, fdp, numfds, 0,
+                                  &local_err);
+
+    if (ret == -1) {
+        vfio_user_set_error(msg->hdr, EIO);
+        vfio_user_shutdown(proxy);
+        error_report_err(local_err);
+    }
+    trace_vfio_user_send_write(msg->hdr->id, ret);
+
+    return ret;
+}
+
 static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                      VFIOUserFDs *fds)
 {
@@ -97,6 +139,7 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     msg->hdr = NULL;
     msg->fds = NULL;
     msg->complete = false;
+    msg->pending = false;
     QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
 }
 
@@ -391,6 +434,54 @@ err:
     return -1;
 }
 
+/*
+ * Send messages from outgoing queue when the socket buffer has space.
+ * If we deplete 'outgoing', remove ourselves from the poll list.
+ */
+static void vfio_user_send(void *opaque)
+{
+    VFIOUserProxy *proxy = opaque;
+
+    QEMU_LOCK_GUARD(&proxy->lock);
+
+    if (proxy->state == VFIO_PROXY_CONNECTED) {
+        while (!QTAILQ_EMPTY(&proxy->outgoing)) {
+            if (vfio_user_send_one(proxy) < 0) {
+                return;
+            }
+        }
+        qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
+                                       vfio_user_recv, NULL, NULL, proxy);
+    }
+}
+
+/*
+ * Send a single message.
+ *
+ * Sent async messages are freed, others are moved to pending queue.
+ */
+static int vfio_user_send_one(VFIOUserProxy *proxy)
+{
+    VFIOUserMsg *msg;
+    int ret;
+
+    msg = QTAILQ_FIRST(&proxy->outgoing);
+    ret = vfio_user_send_qio(proxy, msg);
+    if (ret < 0) {
+        return ret;
+    }
+
+    QTAILQ_REMOVE(&proxy->outgoing, msg, next);
+    if (msg->type == VFIO_MSG_ASYNC) {
+        vfio_user_recycle(proxy, msg);
+    } else {
+        QTAILQ_INSERT_TAIL(&proxy->pending, msg, next);
+        msg->pending = true;
+    }
+
+    return 0;
+}
+
 static void vfio_user_cb(void *opaque)
 {
     VFIOUserProxy *proxy = opaque;
@@ -452,6 +543,119 @@ static void vfio_user_request(void *opaque)
     }
 }
 
+/*
+ * Messages are queued onto the proxy's outgoing list.
+ *
+ * It handles 3 types of messages:
+ *
+ * async messages - replies and posted writes
+ *
+ * There will be no reply from the server, so message
+ * buffers are freed after they're sent.
+ *
+ * nowait messages - map/unmap during address space transactions
+ *
+ * These are also sent async, but a reply is expected so that
+ * vfio_wait_reqs() can wait for the youngest nowait request.
+ * They transition from the outgoing list to the pending list
+ * when sent, and are freed when the reply is received.
+ *
+ * wait messages - all other requests
+ *
+ * The reply to these messages is waited for by their caller.
+ * They also transition from outgoing to pending when sent, but
+ * the message buffer is returned to the caller with the reply
+ * contents.  The caller is responsible for freeing these messages.
+ *
+ * As an optimization, if the outgoing list and the socket send
+ * buffer are empty, the message is sent inline instead of being
+ * added to the outgoing list.  The rest of the transitions are
+ * unchanged.
+ *
+ * returns 0 if the message was sent or queued
+ * returns -1 on send error
+ */
+static int vfio_user_send_queued(VFIOUserProxy *proxy, VFIOUserMsg *msg)
+{
+    int ret;
+
+    /*
+     * Unsent outgoing msgs - add to tail
+     */
+    if (!QTAILQ_EMPTY(&proxy->outgoing)) {
+        QTAILQ_INSERT_TAIL(&proxy->outgoing, msg, next);
+        return 0;
+    }
+
+    /*
+     * Try inline - if blocked, queue it and kick send poller
+     */
+    if (proxy->flags & VFIO_PROXY_FORCE_QUEUED) {
+        ret = QIO_CHANNEL_ERR_BLOCK;
+    } else {
+        ret = vfio_user_send_qio(proxy, msg);
+    }
+    if (ret == QIO_CHANNEL_ERR_BLOCK) {
+        QTAILQ_INSERT_HEAD(&proxy->outgoing, msg, next);
+        qio_channel_set_aio_fd_handler(proxy->ioc, proxy->ctx,
+                                       vfio_user_recv, proxy->ctx,
+                                       vfio_user_send, proxy);
+        return 0;
+    }
+    if (ret == -1) {
+        return ret;
+    }
+
+    /*
+     * Sent - free async, add others to pending
+     */
+    if (msg->type == VFIO_MSG_ASYNC) {
+        vfio_user_recycle(proxy, msg);
+    } else {
+        QTAILQ_INSERT_TAIL(&proxy->pending, msg, next);
+        msg->pending = true;
+    }
+
+    return 0;
+}
+
+static void vfio_user_send_wait(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
+                                VFIOUserFDs *fds, int rsize)
+{
+    VFIOUserMsg *msg;
+    int ret;
+
+    if (hdr->flags & VFIO_USER_NO_REPLY) {
+        error_printf("vfio_user_send_wait on async message\n");
+        vfio_user_set_error(hdr, EINVAL);
+        return;
+    }
+
+    qemu_mutex_lock(&proxy->lock);
+
+    msg = vfio_user_getmsg(proxy, hdr, fds);
+    msg->id = hdr->id;
+    msg->rsize = rsize ? rsize : hdr->size;
+    msg->type = VFIO_MSG_WAIT;
+
+    ret = vfio_user_send_queued(proxy, msg);
+
+    if (ret == 0) {
+        while (!msg->complete) {
+            if (!qemu_cond_timedwait(&msg->cv, &proxy->lock, wait_time)) {
+                VFIOUserMsgQ *list;
+
+                list = msg->pending ? &proxy->pending : &proxy->outgoing;
+                QTAILQ_REMOVE(list, msg, next);
+                vfio_user_set_error(hdr, ETIMEDOUT);
+                break;
+            }
+        }
+    }
+    vfio_user_recycle(proxy, msg);
+
+    qemu_mutex_unlock(&proxy->lock);
+}
 
 static QLIST_HEAD(, VFIOUserProxy) vfio_user_sockets =
     QLIST_HEAD_INITIALIZER(vfio_user_sockets);
@@ -480,6 +684,15 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     proxy = g_malloc0(sizeof(VFIOUserProxy));
     proxy->sockname = g_strdup_printf("unix:%s", sockname);
     proxy->ioc = ioc;
+
+    /* init defaults */
+    proxy->max_xfer_size = VFIO_USER_DEF_MAX_XFER;
+    proxy->max_send_fds = VFIO_USER_DEF_MAX_FDS;
+    proxy->max_dma = VFIO_USER_DEF_MAP_MAX;
+    proxy->dma_pgsizes = VFIO_USER_DEF_PGSIZE;
+    proxy->max_bitmap = VFIO_USER_DEF_MAX_BITMAP;
+    proxy->migr_pgsize = VFIO_USER_DEF_PGSIZE;
+
     proxy->flags = VFIO_PROXY_CLIENT;
     proxy->state = VFIO_PROXY_CONNECTED;
 
@@ -577,3 +790,285 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     g_free(proxy->sockname);
     g_free(proxy);
 }
+
+static void vfio_user_request_msg(VFIOUserHdr *hdr, uint16_t cmd,
+                                  uint32_t size, uint32_t flags)
+{
+    static uint16_t next_id;
+
+    hdr->id = qatomic_fetch_inc(&next_id);
+    hdr->command = cmd;
+    hdr->size = size;
+    hdr->flags = (flags & ~VFIO_USER_TYPE) | VFIO_USER_REQUEST;
+    hdr->error_reply = 0;
+}
+
+struct cap_entry {
+    const char *name;
+    bool (*check)(VFIOUserProxy *proxy, QObject *qobj, Error **errp);
+};
+
+static bool caps_parse(VFIOUserProxy *proxy, QDict *qdict,
+                       struct cap_entry caps[], Error **errp)
+{
+    QObject *qobj;
+    struct cap_entry *p;
+
+    for (p = caps; p->name != NULL; p++) {
+        qobj = qdict_get(qdict, p->name);
+        if (qobj != NULL) {
+            if (!p->check(proxy, qobj, errp)) {
+                return false;
+            }
+            qdict_del(qdict, p->name);
+        }
+    }
+
+    /* warning, for now */
+    if (qdict_size(qdict) != 0) {
+        warn_report("spurious capabilities");
+    }
+    return true;
+}
+
+static bool check_migr_pgsize(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t pgsize;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &pgsize)) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_PGSIZE);
+        return false;
+    }
+
+    /* must be larger than default */
+    if (pgsize & (VFIO_USER_DEF_PGSIZE - 1)) {
+        error_setg(errp, "pgsize 0x%"PRIx64" too small", pgsize);
+        return false;
+    }
+
+    proxy->migr_pgsize = pgsize;
+    return true;
+}
+
+static bool check_bitmap(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t bitmap_size;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &bitmap_size)) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_BITMAP);
+        return false;
+    }
+
+    /* can only lower it */
+    if (bitmap_size > VFIO_USER_DEF_MAX_BITMAP) {
+        error_setg(errp, "%s too large", VFIO_USER_CAP_MAX_BITMAP);
+        return false;
+    }
+
+    proxy->max_bitmap = bitmap_size;
+    return true;
+}
+
+static struct cap_entry caps_migr[] = {
+    { VFIO_USER_CAP_PGSIZE, check_migr_pgsize },
+    { VFIO_USER_CAP_MAX_BITMAP, check_bitmap },
+    { NULL }
+};
+
+static bool check_max_fds(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t max_send_fds;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &max_send_fds) ||
+        max_send_fds > VFIO_USER_MAX_MAX_FDS) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_FDS);
+        return false;
+    }
+    proxy->max_send_fds = max_send_fds;
+    return true;
+}
+
+static bool check_max_xfer(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t max_xfer_size;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &max_xfer_size) ||
+        max_xfer_size > VFIO_USER_MAX_MAX_XFER) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_XFER);
+        return false;
+    }
+    proxy->max_xfer_size = max_xfer_size;
+    return true;
+}
+
+static bool check_pgsizes(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t pgsizes;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &pgsizes)) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_PGSIZES);
+        return false;
+    }
+
+    /* must be larger than default */
+    if (pgsizes & (VFIO_USER_DEF_PGSIZE - 1)) {
+        error_setg(errp, "pgsize 0x%"PRIx64" too small", pgsizes);
+        return false;
+    }
+
+    proxy->dma_pgsizes = pgsizes;
+    return true;
+}
+
+static bool check_max_dma(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QNum *qn = qobject_to(QNum, qobj);
+    uint64_t max_dma;
+
+    if (qn == NULL || !qnum_get_try_uint(qn, &max_dma)) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAP_MAX);
+        return false;
+    }
+
+    /* can only lower it */
+    if (max_dma > VFIO_USER_DEF_MAP_MAX) {
+        error_setg(errp, "%s too large", VFIO_USER_CAP_MAP_MAX);
+        return false;
+    }
+
+    proxy->max_dma = max_dma;
+    return true;
+}
+
+static bool check_migr(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+    QDict *qdict = qobject_to(QDict, qobj);
+
+    if (qdict == NULL) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP_MAX_FDS);
+        return true;
+    }
+    return caps_parse(proxy, qdict, caps_migr, errp);
+}
+
+static struct cap_entry caps_cap[] = {
+    { VFIO_USER_CAP_MAX_FDS, check_max_fds },
+    { VFIO_USER_CAP_MAX_XFER, check_max_xfer },
+    { VFIO_USER_CAP_PGSIZES, check_pgsizes },
+    { VFIO_USER_CAP_MAP_MAX, check_max_dma },
+    { VFIO_USER_CAP_MIGR, check_migr },
+    { NULL }
+};
+
+static bool check_cap(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
+{
+   QDict *qdict = qobject_to(QDict, qobj);
+
+    if (qdict == NULL) {
+        error_setg(errp, "malformed %s", VFIO_USER_CAP);
+        return false;
+    }
+    return caps_parse(proxy, qdict, caps_cap, errp);
+}
+
+static struct cap_entry ver_0_0[] = {
+    { VFIO_USER_CAP, check_cap },
+    { NULL }
+};
+
+static bool caps_check(VFIOUserProxy *proxy, int minor, const char *caps,
+                       Error **errp)
+{
+    QObject *qobj;
+    QDict *qdict;
+    bool ret;
+
+    qobj = qobject_from_json(caps, NULL);
+    if (qobj == NULL) {
+        error_setg(errp, "malformed capabilities %s", caps);
+        return false;
+    }
+    qdict = qobject_to(QDict, qobj);
+    if (qdict == NULL) {
+        error_setg(errp, "capabilities %s not an object", caps);
+        qobject_unref(qobj);
+        return false;
+    }
+    ret = caps_parse(proxy, qdict, ver_0_0, errp);
+
+    qobject_unref(qobj);
+    return ret;
+}
+
+static GString *caps_json(void)
+{
+    QDict *dict = qdict_new();
+    QDict *capdict = qdict_new();
+    QDict *migdict = qdict_new();
+    GString *str;
+
+    qdict_put_int(migdict, VFIO_USER_CAP_PGSIZE, VFIO_USER_DEF_PGSIZE);
+    qdict_put_int(migdict, VFIO_USER_CAP_MAX_BITMAP, VFIO_USER_DEF_MAX_BITMAP);
+    qdict_put_obj(capdict, VFIO_USER_CAP_MIGR, QOBJECT(migdict));
+
+    qdict_put_int(capdict, VFIO_USER_CAP_MAX_FDS, VFIO_USER_MAX_MAX_FDS);
+    qdict_put_int(capdict, VFIO_USER_CAP_MAX_XFER, VFIO_USER_DEF_MAX_XFER);
+    qdict_put_int(capdict, VFIO_USER_CAP_PGSIZES, VFIO_USER_DEF_PGSIZE);
+    qdict_put_int(capdict, VFIO_USER_CAP_MAP_MAX, VFIO_USER_DEF_MAP_MAX);
+
+    qdict_put_obj(dict, VFIO_USER_CAP, QOBJECT(capdict));
+
+    str = qobject_to_json(QOBJECT(dict));
+    qobject_unref(dict);
+    return str;
+}
+
+bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp)
+{
+    g_autofree VFIOUserVersion *msgp = NULL;
+    GString *caps;
+    char *reply;
+    int size, caplen;
+
+    caps = caps_json();
+    caplen = caps->len + 1;
+    size = sizeof(*msgp) + caplen;
+    msgp = g_malloc0(size);
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_VERSION, size, 0);
+    msgp->major = VFIO_USER_MAJOR_VER;
+    msgp->minor = VFIO_USER_MINOR_VER;
+    memcpy(&msgp->capabilities, caps->str, caplen);
+    g_string_free(caps, true);
+    trace_vfio_user_version(msgp->major, msgp->minor, msgp->capabilities);
+
+    vfio_user_send_wait(proxy, &msgp->hdr, NULL, 0);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        error_setg_errno(errp, msgp->hdr.error_reply, "version reply");
+        return false;
+    }
+
+    if (msgp->major != VFIO_USER_MAJOR_VER ||
+        msgp->minor > VFIO_USER_MINOR_VER) {
+        error_setg(errp, "incompatible server version");
+        return false;
+    }
+
+    reply = msgp->capabilities;
+    if (reply[msgp->hdr.size - sizeof(*msgp) - 1] != '\0') {
+        error_setg(errp, "corrupt version reply");
+        return false;
+    }
+
+    if (!caps_check(proxy, msgp->minor, reply, errp)) {
+        return false;
+    }
+
+    trace_vfio_user_version(msgp->major, msgp->minor, msgp->capabilities);
+    return true;
+}
diff --git a/hw/vfio-user/common.h b/hw/vfio-user/common.h
index 71c0dea82d..9f4243a67d 100644
--- a/hw/vfio-user/common.h
+++ b/hw/vfio-user/common.h
@@ -35,6 +35,7 @@ typedef struct VFIOUserMsg {
     uint32_t id;
     QemuCond cv;
     bool complete;
+    bool pending;
     enum msg_type type;
 } VFIOUserMsg;
 
@@ -54,6 +55,12 @@ typedef struct VFIOUserProxy {
     struct QIOChannel *ioc;
     void (*request)(void *opaque, VFIOUserMsg *msg);
     void *req_arg;
+    uint64_t max_xfer_size;
+    uint64_t max_send_fds;
+    uint64_t max_dma;
+    uint64_t dma_pgsizes;
+    uint64_t max_bitmap;
+    uint64_t migr_pgsize;
     int flags;
     QemuCond close_cv;
     AioContext *ctx;
@@ -76,6 +83,7 @@ typedef struct VFIOUserProxy {
 
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
+#define VFIO_PROXY_FORCE_QUEUED  0x4
 
 typedef struct VFIODevice VFIODevice;
 
@@ -84,5 +92,6 @@ void vfio_user_disconnect(VFIOUserProxy *proxy);
 void vfio_user_set_handler(VFIODevice *vbasedev,
                            void (*handler)(void *opaque, VFIOUserMsg *msg),
                            void *reqarg);
+bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 
 #endif /* VFIO_USER_COMMON_H */
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index fb6c872768..69806eb863 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -36,6 +36,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
 struct VFIOUserPCIDevice {
     VFIOPCIDevice device;
     char *sock_name;
+    bool send_queued;   /* all sends are queued */
 };
 
 /*
@@ -95,6 +96,14 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     vbasedev->proxy = proxy;
     vfio_user_set_handler(vbasedev, vfio_user_pci_process_req, vdev);
 
+    if (udev->send_queued) {
+        proxy->flags |= VFIO_PROXY_FORCE_QUEUED;
+    }
+
+    if (!vfio_user_validate_version(proxy, errp)) {
+        goto error;
+    }
+
     vbasedev->name = g_strdup_printf("VFIO user <%s>", udev->sock_name);
     vbasedev->ops = &vfio_user_pci_ops;
     vbasedev->type = VFIO_DEVICE_TYPE_PCI;
@@ -109,9 +118,13 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     if (!vfio_attach_device_by_iommu_type(TYPE_VFIO_IOMMU_USER,
                                           vbasedev->name, vbasedev,
                                           as, errp)) {
-        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
-        return;
+        goto error;
     }
+
+    return;
+
+error:
+    error_prepend(errp, VFIO_MSG_PREFIX, vdev->vbasedev.name);
 }
 
 static void vfio_user_instance_init(Object *obj)
@@ -154,6 +167,7 @@ static void vfio_user_instance_finalize(Object *obj)
 
 static const Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_STRING("socket", VFIOUserPCIDevice, sock_name),
+    DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
 };
 
 static void vfio_user_pci_dev_class_init(ObjectClass *klass, void *data)
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index d23877c958..5de5b2030c 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -51,4 +51,66 @@ enum vfio_user_command {
 #define VFIO_USER_NO_REPLY      0x10
 #define VFIO_USER_ERROR         0x20
 
+
+/*
+ * VFIO_USER_VERSION
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint16_t major;
+    uint16_t minor;
+    char capabilities[];
+} VFIOUserVersion;
+
+#define VFIO_USER_MAJOR_VER     0
+#define VFIO_USER_MINOR_VER     0
+
+#define VFIO_USER_CAP           "capabilities"
+
+/* "capabilities" members */
+#define VFIO_USER_CAP_MAX_FDS   "max_msg_fds"
+#define VFIO_USER_CAP_MAX_XFER  "max_data_xfer_size"
+#define VFIO_USER_CAP_PGSIZES   "pgsizes"
+#define VFIO_USER_CAP_MAP_MAX   "max_dma_maps"
+#define VFIO_USER_CAP_MIGR      "migration"
+
+/* "migration" members */
+#define VFIO_USER_CAP_PGSIZE            "pgsize"
+#define VFIO_USER_CAP_MAX_BITMAP        "max_bitmap_size"
+
+/*
+ * Max FDs mainly comes into play when a device supports multiple interrupts
+ * where each ones uses an eventfd to inject it into the guest.
+ * It is clamped by the the number of FDs the qio channel supports in a
+ * single message.
+ */
+#define VFIO_USER_DEF_MAX_FDS   8
+#define VFIO_USER_MAX_MAX_FDS   16
+
+/*
+ * Max transfer limits the amount of data in region and DMA messages.
+ * Region R/W will be very small (limited by how much a single instruction
+ * can process) so just use a reasonable limit here.
+ */
+#define VFIO_USER_DEF_MAX_XFER  (1024 * 1024)
+#define VFIO_USER_MAX_MAX_XFER  (64 * 1024 * 1024)
+
+/*
+ * Default pagesizes supported is 4k.
+ */
+#define VFIO_USER_DEF_PGSIZE    4096
+
+/*
+ * Default max number of DMA mappings is stolen from the
+ * linux kernel "dma_entry_limit"
+ */
+#define VFIO_USER_DEF_MAP_MAX   65535
+
+/*
+ * Default max bitmap size is also take from the linux kernel,
+ * where usage of signed ints limits the VA range to 2^31 bytes.
+ * Dividing that by the number of bits per byte yields 256MB
+ */
+#define VFIO_USER_DEF_MAX_BITMAP (256 * 1024 * 1024)
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 89d6c11c4c..7a3645024f 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -4,3 +4,5 @@
 vfio_user_recv_hdr(const char *name, uint16_t id, uint16_t cmd, uint32_t size, uint32_t flags) " (%s) id 0x%x cmd 0x%x size 0x%x flags 0x%x"
 vfio_user_recv_read(uint16_t id, int read) " id 0x%x read 0x%x"
 vfio_user_recv_request(uint16_t cmd) " command 0x%x"
+vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
+vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
-- 
2.34.1


