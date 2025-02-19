Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B914C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklPD-0003sM-Ra; Wed, 19 Feb 2025 09:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklPA-0003fV-3P; Wed, 19 Feb 2025 09:50:28 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklP7-0007Z0-Gy; Wed, 19 Feb 2025 09:50:27 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JBEuNj022547;
 Wed, 19 Feb 2025 06:50:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=DkbgFufOS5IH+aPw9Pa3u+L+Aso3ErcJHh7tPyw9n
 Vg=; b=Iz8XpC/no/9fiKhXAVElyuqZSWXL71RYP9dz5/usmCW1i4Kkjcbtp3iK3
 leAUklqL9tqUPddtU3tn43cQ4DaV6IwKQpheTb0PuNfUV0d++9kL6GZ54Xx+L5Ho
 2ucZXa6mLo/1E9+HIJpExSaR07YUeS6nRvXawn8hfNSxRB3TT8jbMwjtotv/dl1B
 YOdwXTyk/QBd5zaO6YSNGVhzUPDriC0zxik0BjL7lQ5ULy1iZM3WLdUQXh3WzPiz
 807mmkLsw4j3mZnckTiZnkNleBe8TzrvjMrnZhh6WJClclr2EDrqIZUXu5Dq2KcS
 V0ps8jZTvIEAM75WFuvSxIzWwE5dQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4b9hy5d-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:50:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEoRTR1SbHcg72LDyCUpVjAmdyBMXZiyC9aLnEhcb0opRJDXetS0M8I6HluTCPE7+KaX1e1OcdvGfphgNw4+GaE7cIHWz5JyxYQJCRCfbx2yGWEoRp626XkiT7MLDhs4fFFV2Fgp/6Su7eCkvJBKUVFx6+lkeTBu+yLayMyXk7t/hY/S9OiA1XQ9S9lWyYaKvXhyGpnkhyVli8U3xgQ6YLiXMVVWDkBUZVjHC0NAFBYwj2130OCHLnG6Ht06hzFUK6vrE2A4ard/rqNSFotuLKYhcRE/l3HcNc1jh0KyhZbvFRU4VYLww05k/ZudCUHfz8eBkXavYW6x+Peh6Okvhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkbgFufOS5IH+aPw9Pa3u+L+Aso3ErcJHh7tPyw9nVg=;
 b=cphWG/UF1b4u4DZqob+DbsnqRv13rb4OgV6t4iNEpy0hhHK3EfmqTbZow6LVjiZU3cLBlwXKrFaEUbpIEJ6o/k+nlCqSZQtlsiuviFWDpP0xDgXcVCkGb5WqdSKqG7sy/obvjgH1Kd6RG9xGtjp6Ap1s3ocpbxC7dJSzMfMBoWxpCmAoFpjYirG/XTiuo04oyAvet0kNuPy0zFOOtIwW5bV2/8WXFlGPXEYLSFSD34rc3yJmSMjtka/YslmI2DIhMN4U/h5H//kxSHR8bIn7vXo7uNtxlT9kJ2eaE9RqfW+Rmnt0m+zHDi17icmW1h7hjLyIBrnn/OmbCQcb/oQQjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkbgFufOS5IH+aPw9Pa3u+L+Aso3ErcJHh7tPyw9nVg=;
 b=nIILOxO1idhdT2zmRuQnm16gfGVqfAw1FFALf4Un9L+h12+OqCZVMDzYz1vEbRRCINR7jNJ0KXn+U9F3YWL9fLUYERcyzCLoK3jf+83gEboFH4dPGQNzMIQ/PP0CiFjP5Y1JgCiQES6GqtpXZFpNQIoYnXdYUUJT9Fff/9lrVHM9Qc33G5KCB6GzJJPdOv0jsYmMc4tDn6UEK5/ntIyDbzTUc/kLvtPZWRSh+7lOBpZpP1Kma34Euo4zVLlZ/dqXOBhIocqCfdMMDNIIIRaz5lFccb8Q65E5McsJiZnr3VzGrr2rgC+xri5Tq4HukfCd96un0aMbq6DiLIqaVgpZqA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV8PR02MB10096.namprd02.prod.outlook.com (2603:10b6:408:181::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 14:50:09 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:50:09 +0000
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
Subject: [PATCH v8 17/28] vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO
Date: Wed, 19 Feb 2025 15:48:47 +0100
Message-Id: <20250219144858.266455-18-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 55383ad4-b038-492e-cbbe-08dd50f4b4ae
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q1QQHZuNRmqQSrb0wpCwEyy4yhHe1G+szfFDWNF8dAsvhQo9nXU0R27+BAvh?=
 =?us-ascii?Q?XyH5RpddJmU2CxIsCjo+8b2ikQLoxXQyQw/AHg6i10plWB0zvE0KiCSotEGD?=
 =?us-ascii?Q?R5JWI/m1OFV8oU4DE45LEpLCDTusnYLqdyAwA+ajnvG5U++OmxsW5p5AsSmg?=
 =?us-ascii?Q?7+GSWhxLMpw/04F1bcsS5fDY1/H1OM1xjOAbfmndNE21NmE8Z7bIIP+pRx+M?=
 =?us-ascii?Q?anU592h7LTN65Lq+lWYZ65IHRV1BIextumk4wJcFo6PcjzutD8FlOk+9drZS?=
 =?us-ascii?Q?OC7bqAbJNwWn4SV8bnWrx49FvKbupILrgBSAuSOBoqiFrEqthaxGiE17bxBG?=
 =?us-ascii?Q?EKK0KSCuvOBa0BYGym67cWJ/r3+HcxzwUX9LmBeajDqDkNqd5vMe0AzSu6k5?=
 =?us-ascii?Q?FfEkjXq1MPx2ePbuc4tDDVCYH1zeb7nafOJvn2WcBmlkNKDhMv80yPmkQtXJ?=
 =?us-ascii?Q?147Iesz5d0c5+S9zMXP72N+CwfQtEw8NBMC7nK12Fa65ZthCyZQWuwIUAsL4?=
 =?us-ascii?Q?Fuw9POXf+lPlvB0hWHoj5Lt8aoDRX/qEW9UttAoDXG+LnMfM5fkz1GiUItT1?=
 =?us-ascii?Q?OGUbuwTLXdXEyoqGpIHnEc+Z6EddeiijrEdxmf1YWTC5yFIYB3JKKmg7GEif?=
 =?us-ascii?Q?OQdQjAqvKqIyh8IiEKqYH0CTxHI97LVZlw21XZ6bw78sOVfyJhjI9JkvrNpg?=
 =?us-ascii?Q?F6VPLZRvA8JIEooUGZXyjaPTNXRe61/MjXxxPSUjAhEC3lvHA3q7Q9DyXI0h?=
 =?us-ascii?Q?LAot7e8+ZiRekFC+8FqYwSJbGC+pJ3OnkG3Divs2pUll6fh3XN5THw2Xl0Cm?=
 =?us-ascii?Q?zK8avyGJtpVixBBOzf1OIzbM6K2V1CN+HD3/70i2Ua8VOrgoYuBZuraPd/We?=
 =?us-ascii?Q?hJ+eVhXdKy1qi/rmyHZFC8Udct9RYdkuUamJHN431mh2Ya8kT47z0HaP6nEG?=
 =?us-ascii?Q?RRXZkNxcRTuzE9U7ffi4NyC6IvkeDyRmYGhPdnGe0yJitwO4K09ILF+2peg+?=
 =?us-ascii?Q?AeOw3mchFt0HJj+9f4bq4Oax1/pYf0idFtZ5wbZTF+T/OGpVIEgFLA1YsT9w?=
 =?us-ascii?Q?PyS6JjljgRaU5tAj+44dXr7GCb8blzCazk7Ub/V/L1GKycXZtj/+Onl6I2XD?=
 =?us-ascii?Q?kIIkz9ASa87npTfkwU77yb3RyFitpHJKkqAACaxLrfMHPFocJr5cg2ZjcOgY?=
 =?us-ascii?Q?292HsHWyvm3CtIIxHRa/D/uQSTplmH4olREHUF3R1W8PQaiyuJ4XXz6YZ+gY?=
 =?us-ascii?Q?5SDx5ixKTCbkZgF+aFGuQuEBujNJJYZZaDuJmjOmxUO5Y9mpMEOyNxnA04U1?=
 =?us-ascii?Q?Mz3HCV8HnvM3jflpzmyhdQy22y/jqNYgULwaeAWNWdPpJwfmX/V87Q6XxwGf?=
 =?us-ascii?Q?ign0MPR2NryaCqtKU6lDQ81HQ+j7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0COByQiI4MBNzbOGYjo+1B3sGAHKsmJyPvzQZFXxSIY3nw7RbdGrVjHL22DK?=
 =?us-ascii?Q?PJE0HLq98p63YfsVGJI0yKksDYLPmSQLhm3vpP6msYnlwmlZ5c8ByqA4DxJj?=
 =?us-ascii?Q?SOdGdpeH2NVWVyt4eKQ2CKQ7twhNJZwy0TvlVQEQZ1y7FQM1Uh2cFt8/u8XC?=
 =?us-ascii?Q?R0SK3wnSEznfEdwxygI2i/0OAJLkkbmGy4dA4WM8G44VHxJKFzbBLW1ZuNya?=
 =?us-ascii?Q?4zJCJaE5MF3CxtLozvZYqRTDtZr6YFfwOqJfD2tDDh4FsPL0myrDcEojwwGZ?=
 =?us-ascii?Q?qCFkkziX/c4kulIF+zNGFCeNtTTphcuooRFoFSaE+b+uL9PbpUGHuF6oFJpz?=
 =?us-ascii?Q?NbUUMBcqmgvM8Nyg7aG9fDdn4hHvMEaf0cp7ivkgyq5hEhlZgG3KmL0O486t?=
 =?us-ascii?Q?qs5i+7lr0l4P4TM741Gy4o1GGPs1sy5LQuEakQJCCG37+HdyLUc1QyrWUwFC?=
 =?us-ascii?Q?Fn8qzVBL9NOE4Gr7GH0zoiMSodePU/5RQOdOLnjtB94/ZiXQzVYq0x7zXnjl?=
 =?us-ascii?Q?ara90o5zbDSLKANIOvqkKiroyhI2EEkyrLSNg8OGfvz3oGU3vASDGPu03SBf?=
 =?us-ascii?Q?287bii8Po+5rMKig6n/WBXXegErJeu3G+FrC6CVKFdGL9l830pXhwfPw5HcZ?=
 =?us-ascii?Q?3CKlv2Fw+0+UWJFQmcb9jrpf+Nm8KTBEDvNUeo5UZ80LhrXH0FAHFL94d8At?=
 =?us-ascii?Q?4oc1Ar5/bsHJfnHE5/u58hr8OsL8sUSNk+JORpSpzOW/VhLKXcV5KSmKMmT2?=
 =?us-ascii?Q?50dvSdOeeHaBDw+qc3uWVMb6ZHKZQbAaTASL520p/PsVhnLn/ai4Ux8OA2dV?=
 =?us-ascii?Q?xO14HamGAIOSiX7c9u2Ww/7/cs1HOGSMednJMYV9iVB4gvIDO28IhP4bJMpt?=
 =?us-ascii?Q?fvg8U1UOETVnEocP6bA12gK9UDxABoNDE+vK7Sox+lcaX1vQK0h/31H1EtDt?=
 =?us-ascii?Q?5rb5DRwYLhD6JZ+GFouYCGj42saGoDpKrKyGizg9HfoaEddtXPl7FHGlastd?=
 =?us-ascii?Q?cmogMUnXj/ZyE98mgyHR+dENNM9S9MQ0A5FkxfUNQ86BT8FWpZJ756PBtpZE?=
 =?us-ascii?Q?utTGQO0mVVATCTJsIut/J0ofo7BSu7Paly8KVMn2ObYTjf8zgeutGfVOgwmb?=
 =?us-ascii?Q?Eo9oIPhAC/H1wbEp0kpeJaCmPGZk1VI2gf5TkbkpQdqjqfXcdBq9Nox8rMIW?=
 =?us-ascii?Q?ZzSEDHWrsx3VHARZH+zyMplJd9XVzMz59Acg/cc3bMgGPCy1k3kOaJeoL7pC?=
 =?us-ascii?Q?EYfK4OXuhUlHUTjBXbTr5+Zlki4y9ybj5m9VaJUda6IwBAQhYmPb68ECJVBd?=
 =?us-ascii?Q?qC2GGlGxq6tlrVLRwtg30kCJQDTOJWc0A9KRdPN5vAS6H9ZplV85rnpXs1HO?=
 =?us-ascii?Q?1wjZqqH4b9Wgr/xGJiV/XToR7t9L91jHtcxHScBxAWbOo5drh9YQuMPlkHWJ?=
 =?us-ascii?Q?c9JiL4X1YJ+aZbkrtY5DE0AuQWTlASJdXfVZlg6SE/R6J509cIeq+1wsocgj?=
 =?us-ascii?Q?EJLPvGKmk1qGfkxUE6ekMjmiBvob85tLgKaFs+qNud9D99Sq0yXRxirG3QBg?=
 =?us-ascii?Q?NJWxkj7gUWjHGKRFJxNW5/pS13Ezr5L2+1m6+FS3?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55383ad4-b038-492e-cbbe-08dd50f4b4ae
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:50:09.2302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQPEDYxqt/Je5DRc7GJ/rgvzGl4p3VTPzT+0zZRh80chosmNSIgC7qtIV52Zt+RlQxBMUSjdpmfSnmgfFOm07w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10096
X-Proofpoint-GUID: 0RjrKGk_Rmfm7_9pHQv96GDnfqU4dl9W
X-Proofpoint-ORIG-GUID: 0RjrKGk_Rmfm7_9pHQv96GDnfqU4dl9W
X-Authority-Analysis: v=2.4 cv=HMQ5Fptv c=1 sm=1 tr=0 ts=67b5efae cx=c_pps
 a=bqH6H/OQt14Rv/FmpY1ebg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=NH85Zxiy9fDlYZs8F5cA:9
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

Add support for per-region info fds. Unlike kernel vfio, vfio-user can
have a separate fd to support mmap() of individual regions; add
->use_regfds as needed to support this difference.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/common.c         | 68 +++++++++++++++++++++++++++++++++++
 hw/vfio-user/common.h         |  2 ++
 hw/vfio-user/pci.c            |  2 ++
 hw/vfio-user/protocol.h       | 14 ++++++++
 hw/vfio-user/trace-events     |  1 +
 hw/vfio/ap.c                  |  2 ++
 hw/vfio/ccw.c                 |  2 ++
 hw/vfio/container.c           |  7 ++++
 hw/vfio/helpers.c             | 28 +++++++++++++--
 hw/vfio/pci.c                 |  2 ++
 hw/vfio/platform.c            |  2 ++
 include/hw/vfio/vfio-common.h |  5 ++-
 12 files changed, 131 insertions(+), 4 deletions(-)

diff --git a/hw/vfio-user/common.c b/hw/vfio-user/common.c
index 55d1da4e51..7b96d715cb 100644
--- a/hw/vfio-user/common.c
+++ b/hw/vfio-user/common.c
@@ -1106,3 +1106,71 @@ int vfio_user_get_info(VFIOUserProxy *proxy, struct vfio_device_info *info)
 
     return 0;
 }
+
+static int vfio_user_get_region_info(VFIOUserProxy *proxy,
+                                     struct vfio_region_info *info,
+                                     VFIOUserFDs *fds)
+{
+    g_autofree VFIOUserRegionInfo *msgp = NULL;
+    uint32_t size;
+
+    /* data returned can be larger than vfio_region_info */
+    if (info->argsz < sizeof(*info)) {
+        error_printf("vfio_user_get_region_info argsz too small\n");
+        return -E2BIG;
+    }
+    if (fds != NULL && fds->send_fds != 0) {
+        error_printf("vfio_user_get_region_info can't send FDs\n");
+        return -EINVAL;
+    }
+
+    size = info->argsz + sizeof(VFIOUserHdr);
+    msgp = g_malloc0(size);
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_GET_REGION_INFO,
+                          sizeof(*msgp), 0);
+    msgp->argsz = info->argsz;
+    msgp->index = info->index;
+
+    vfio_user_send_wait(proxy, &msgp->hdr, fds, size);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        return -msgp->hdr.error_reply;
+    }
+    trace_vfio_user_get_region_info(msgp->index, msgp->flags, msgp->size);
+
+    memcpy(info, &msgp->argsz, info->argsz);
+    return 0;
+}
+
+
+/*
+ * Socket-based io_ops
+ */
+
+static int vfio_user_io_get_region_info(VFIODevice *vbasedev,
+                                        struct vfio_region_info *info,
+                                        int *fd)
+{
+    int ret;
+    VFIOUserFDs fds = { 0, 1, fd};
+
+    ret = vfio_user_get_region_info(vbasedev->proxy, info, &fds);
+    if (ret) {
+        return ret;
+    }
+
+    if (info->index > vbasedev->num_regions) {
+        return -EINVAL;
+    }
+    /* cap_offset in valid area */
+    if ((info->flags & VFIO_REGION_INFO_FLAG_CAPS) &&
+        (info->cap_offset < sizeof(*info) || info->cap_offset > info->argsz)) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+VFIODeviceIO vfio_dev_io_sock = {
+    .get_region_info = vfio_user_io_get_region_info,
+};
diff --git a/hw/vfio-user/common.h b/hw/vfio-user/common.h
index 11a80d4e7c..30a3125ea3 100644
--- a/hw/vfio-user/common.h
+++ b/hw/vfio-user/common.h
@@ -95,4 +95,6 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
 bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 int vfio_user_get_info(VFIOUserProxy *proxy, struct vfio_device_info *info);
 
+extern VFIODeviceIO vfio_dev_io_sock;
+
 #endif /* VFIO_USER_COMMON_H */
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 69806eb863..fdff6c99e6 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -108,6 +108,8 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     vbasedev->ops = &vfio_user_pci_ops;
     vbasedev->type = VFIO_DEVICE_TYPE_PCI;
     vbasedev->dev = DEVICE(vdev);
+    vbasedev->io = &vfio_dev_io_sock;
+    vbasedev->use_regfds = true;
 
     /*
      * vfio-user devices are effectively mdevs (don't use a host iommu).
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 5f9ef1768f..6f70a48905 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -125,4 +125,18 @@ typedef struct {
     uint32_t num_irqs;
 } VFIOUserDeviceInfo;
 
+/*
+ * VFIO_USER_DEVICE_GET_REGION_INFO
+ * imported from struct vfio_region_info
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t index;
+    uint32_t cap_offset;
+    uint64_t size;
+    uint64_t offset;
+} VFIOUserRegionInfo;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 6b06a3ed82..1860430301 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -7,3 +7,4 @@ vfio_user_recv_request(uint16_t cmd) " command 0x%x"
 vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
+vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 1adce1ab40..54b1815f1d 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -162,6 +162,8 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    vbasedev->use_regfds = false;
+
     if (!vfio_attach_device(vbasedev->name, vbasedev,
                             &address_space_memory, errp)) {
         goto error;
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 8c16648819..085a3fc6e6 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -586,6 +586,8 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         goto out_unrealize;
     }
 
+    vbasedev->use_regfds = false;
+
     if (!vfio_attach_device(cdev->mdevid, vbasedev,
                             &address_space_memory, errp)) {
         goto out_attach_dev_err;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 0e1af34ce4..ddb86edb65 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -890,10 +890,17 @@ void vfio_put_base_device(VFIODevice *vbasedev)
         int i;
 
         for (i = 0; i < vbasedev->num_regions; i++) {
+            if (vbasedev->regfds != NULL && vbasedev->regfds[i] != -1) {
+                close(vbasedev->regfds[i]);
+            }
             g_free(vbasedev->regions[i]);
         }
         g_free(vbasedev->regions);
         vbasedev->regions = NULL;
+        if (vbasedev->regfds != NULL) {
+            g_free(vbasedev->regfds);
+            vbasedev->regfds = NULL;
+        }
     }
 
     if (!vbasedev->group) {
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index bef1540295..4ed393420e 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -365,6 +365,12 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
     region->size = info->size;
     region->fd_offset = info->offset;
     region->nr = index;
+    if (vbasedev->regfds != NULL) {
+        region->fd = vbasedev->regfds[index];
+    } else {
+        region->fd = vbasedev->fd;
+    }
+
 
     if (region->size) {
         region->mem = g_new0(MemoryRegion, 1);
@@ -443,7 +449,7 @@ int vfio_region_mmap(VFIORegion *region)
 
         region->mmaps[i].mmap = mmap(map_align, region->mmaps[i].size, prot,
                                      MAP_SHARED | MAP_FIXED,
-                                     region->vbasedev->fd,
+                                     region->fd,
                                      region->fd_offset +
                                      region->mmaps[i].offset);
         if (region->mmaps[i].mmap == MAP_FAILED) {
@@ -568,12 +574,16 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
                          struct vfio_region_info **info)
 {
     size_t argsz = sizeof(struct vfio_region_info);
+    int fd = -1;
     int ret;
 
     /* create region cache */
     if (vbasedev->regions == NULL) {
         vbasedev->regions = g_new0(struct vfio_region_info *,
                                    vbasedev->num_regions);
+        if (vbasedev->use_regfds) {
+            vbasedev->regfds = g_new0(int, vbasedev->num_regions);
+        }
     }
     /* check cache */
     if (vbasedev->regions[index] != NULL) {
@@ -587,22 +597,33 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
 retry:
     (*info)->argsz = argsz;
 
-    ret = vbasedev->io->get_region_info(vbasedev, *info);
+    ret = vbasedev->io->get_region_info(vbasedev, *info, &fd);
     if (ret != 0) {
         g_free(*info);
         *info = NULL;
+        if (vbasedev->regfds != NULL) {
+            vbasedev->regfds[index] = -1;
+        }
+
         return ret;
     }
 
     if ((*info)->argsz > argsz) {
         argsz = (*info)->argsz;
         *info = g_realloc(*info, argsz);
+        if (fd != -1) {
+            close(fd);
+            fd = -1;
+        }
 
         goto retry;
     }
 
     /* fill cache */
     vbasedev->regions[index] = *info;
+    if (vbasedev->regfds != NULL) {
+        vbasedev->regfds[index] = fd;
+    }
 
     return 0;
 }
@@ -775,10 +796,11 @@ static int vfio_io_device_feature(VFIODevice *vbasedev,
 }
 
 static int vfio_io_get_region_info(VFIODevice *vbasedev,
-                                   struct vfio_region_info *info)
+                                   struct vfio_region_info *info, int *fd)
 {
     int ret;
 
+    *fd = -1;
     ret = ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, info);
 
     return ret < 0 ? -errno : ret;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a7084a7690..4ab3bfa2fa 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3175,6 +3175,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         name = g_strdup(vbasedev->name);
     }
 
+    vbasedev->use_regfds = false;
+
     if (!vfio_attach_device(name, vbasedev,
                             pci_device_iommu_address_space(pdev), errp)) {
         goto error;
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 51534fd941..a76cc6a194 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -575,6 +575,8 @@ static void vfio_platform_realize(DeviceState *dev, Error **errp)
     VFIODevice *vbasedev = &vdev->vbasedev;
     int i;
 
+    vbasedev->use_regfds = false;
+
     qemu_mutex_init(&vdev->intp_mutex);
 
     trace_vfio_platform_realize(vbasedev->sysfsdev ?
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 699e8a9376..ab7fa7135a 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -59,6 +59,7 @@ typedef struct VFIORegion {
     uint32_t nr_mmaps;
     VFIOMmap *mmaps;
     uint8_t nr; /* cache the region number for debug */
+    int fd; /* fd to mmap() region */
 } VFIORegion;
 
 typedef struct VFIOMigration {
@@ -139,6 +140,7 @@ typedef struct VFIODevice {
     bool ram_block_discard_allowed;
     OnOffAuto enable_migration;
     bool migration_events;
+    bool use_regfds;
     VFIODeviceOps *ops;
     VFIODeviceIO *io;
     unsigned int num_irqs;
@@ -158,6 +160,7 @@ typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) hwpt_next;
     VFIOUserProxy *proxy;
     struct vfio_region_info **regions;
+    int *regfds;
 } VFIODevice;
 
 struct VFIODeviceOps {
@@ -202,7 +205,7 @@ struct VFIODeviceOps {
 struct VFIODeviceIO {
     int (*device_feature)(VFIODevice *vdev, struct vfio_device_feature *);
     int (*get_region_info)(VFIODevice *vdev,
-                           struct vfio_region_info *info);
+                           struct vfio_region_info *info, int *fd);
     int (*get_irq_info)(VFIODevice *vdev, struct vfio_irq_info *irq);
     int (*set_irqs)(VFIODevice *vdev, struct vfio_irq_set *irqs);
     int (*region_read)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
-- 
2.34.1


