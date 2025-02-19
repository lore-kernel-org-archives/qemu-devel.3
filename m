Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE53DC021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 14:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tklPz-0005TZ-R1; Wed, 19 Feb 2025 09:51:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklPW-000589-Pp; Wed, 19 Feb 2025 09:50:50 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tklPU-0007fC-6c; Wed, 19 Feb 2025 09:50:50 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J9M77f023811;
 Wed, 19 Feb 2025 06:50:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=h10HlgpitvorHBaRD8agt8MJNtXj/9PBe26dcGJVU
 Zg=; b=OgpEOMcSQ/gJlppBv8bJQdE4Qxu9qZgFdgElDv8r2mEA56HWztLI4SQDI
 34/FHdBZSCO9pEf6X9Q2quYtZkoQPP+P0BVlOI/ZLL5N78eR7UyxcAcXP5sajY60
 i+UlzGkjSzAoJcV7miiHF7CmArEDV+97trSZafMYuSFFaOd8DhiE85l1f8jF3EIR
 QvMg2JJi6BqrMBbM3NMTMPO43YlCOc4Ga6b42rWYIoplmydOkQdA7GoYJsQ+T0S+
 iXr8QkAe54CgRVvKY9iNVEE3+hClTlvY3IEM+M38iM1eIChBxzvtkehyM1wC1qTN
 80SVUc9UUXEz8dEe551jeV1+mTIRg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44w4basyc9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Feb 2025 06:50:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwbl9/dkczxmzVfgJOjIcn8h3OH4kCfxX2PU4pB8uXUsIyOSO1ikhvm04/tdvuePK8JiZ7+T9f3/cyUeA5u9KSv0ZqQIX9+LfKp/WexRIWNoYdKFq7S7b3R9X7QV/Lw/sjDR6dhkMSLvBywWuhFq/9pvlNVYeTjxXV1nn+12lHcJX88Ui/KVOrlYYdQpUEZRz0RuLOOKrxNPJnBSBClCBiTYH5xrbG+mVRAbKqYXplzm276ee+lCe7MggUnryn/lPwlHP9UnPkfxRwYAXHJlAjB+hA+Kwg4qzMMKbpcduhB1z8P3OPVRPbuNDWslwbv/XYdwGkfWmUfSRal+KRaBng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h10HlgpitvorHBaRD8agt8MJNtXj/9PBe26dcGJVUZg=;
 b=ePtjnrtUvjTVtu9o9TMVECYOimv8Zbasu2Fh5dMLu2v/obBB5tRB1FOkaPc3dMvnI6ZvOOi0Dhf27JdJ7DgjowL2uZiQTQF7UKOOr6UPCGPLDFNPgF0WZULgRpPUNDBYNd/Ph0RqUryj07J9WmujlIMGb8Ye/HR0Wi0KuN2O/EiyKRvo2Xozj8ZIExwnVkicPC3yZuHY9WzFhR77iKvgDUF1fRwc52Wj9NrDucwNUVQhoa7VG8/XmySagPYPYWUxnKdhGeU8QBd5h03m2tMMaPSs43BCU3Q6Yxjq15BytfadOND6rmmcUgmapwmMF/XcYgBh+QQkixuJjq10OTsrgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h10HlgpitvorHBaRD8agt8MJNtXj/9PBe26dcGJVUZg=;
 b=ntT8i99WW+dBL4wIbsbu3oh0dr/8EgjHod/Y4Qf25ROhgKxaQmZ25vbe93WZ3aJm400ENvzsvS0uE+4Lk2FDZde4ReXwhrzIxNQMb4Hxupx9FpAhQJ/Qp5O/O3OU5XGXUu4xt3VMDlPWpDf/1e5Jqqbd3wcp0a+kmHDze+EUNh+AYQZtOez55iubGpXUHq+JyfzXikCQbzjwtXqqFxwG6V0mW97L8gxSoht9FrICcTh0bdqImp7ZNQVsLS7j3f+TPIJF8aieUrYeB1x6yjPr2TNH6eyWXXroX0t2CYUYH2PCcn9Mf6MPPkbZcLdteYGxIMMExCEyjSMPxJ9GAI7g5Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV8PR02MB10096.namprd02.prod.outlook.com (2603:10b6:408:181::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 14:50:40 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:50:40 +0000
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
Subject: [PATCH v8 26/28] vfio-user: add 'no-direct-dma' option
Date: Wed, 19 Feb 2025 15:48:56 +0100
Message-Id: <20250219144858.266455-27-john.levon@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: cf54e931-1f06-43df-8bfe-08dd50f4c787
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z5+P+hQi8fyTz2VB+8xVk73nds8Uj0gDhhQgQUQ2V0QwoLZarmjvEkzsviOE?=
 =?us-ascii?Q?weL4b9QgIz6iTXufEJCITcFMWZLDNDABDjOM6Gx3CWfuD1QHGMKoTMMXKy3g?=
 =?us-ascii?Q?RN1zQUrsouiE6HMwXZAifDyTUNLufzj22/qMv8vEHklKJ5lW9V1VqLo0DQ7v?=
 =?us-ascii?Q?fedN8zdr/rWHrF9fd2xzjBhXguwDN8sfy7T5U4gwtUTTJgHgrzL/MfYbYC3k?=
 =?us-ascii?Q?ntQtI9McwtcfkKdkYog79UH7zimENM7aSqL8KnWWiHrzrLHay6u62nubS7JN?=
 =?us-ascii?Q?g/uq9h3eVkJp0IuK+4ROYQC+4DcQbRKnfBRwLNNOlasqTSm7it9AbEInn/ze?=
 =?us-ascii?Q?+3LGxVgie8nOsKU8HRIIZpRGDdCCP+Y/ofU8szAXZsCJgjeU3WUIZ9wbhFH2?=
 =?us-ascii?Q?yGYuW1Acr3e954rvXqjW7rZrWbTn5U3XN/x0Mp9w0asQ6W7uehCsUNgiGp/a?=
 =?us-ascii?Q?kjWKRu+s5oe+ZZDpbtjtzo/xPCHX34socVUtBpUYXu6N2izWUtlvDqfFcep6?=
 =?us-ascii?Q?BnXxYrRQtpTg+jOgQBPnxSxdajk3Xku1+4O8izdU75yv1QflknYy92l3Uumv?=
 =?us-ascii?Q?XqQTSFw/+VaBathIw6ryc6KN3aCtHzOUvkAxXJ2j1JWq9Z2w3+rjY29RclxO?=
 =?us-ascii?Q?EtAVYLPSO9Il6Ci74JCmmqTiBpbDX1Zrj5oK3MH/Mzb9M5Ipm8MOdrhxWTVX?=
 =?us-ascii?Q?fzlw9JOhoqJ/2WJJVXJxF2C9AphbD7+aiQTAMozyyLu1PTc02zRpFYnpPirw?=
 =?us-ascii?Q?orenZrrQJ7S6CrAlvTCsG8WPvHSTGG0A7HZY0/LlT1kL5uEyvCSH9drJfH98?=
 =?us-ascii?Q?3u47Z405AtPbMoNH6BTabzj+duf1jJjkCKihfSDT4CTIuO8Hof1lHJ0eG97o?=
 =?us-ascii?Q?zGym4g9RBU0d1fh4SWQg8PdHZmVxrAczVTyh2sicQYHdvAvJIPeVC+YiKaP3?=
 =?us-ascii?Q?LiQmAr5rvAsQRLY5nEpNPOE1u3dfoYwWyv1C2T4aWwXDwE6jrMdffEGMCoVW?=
 =?us-ascii?Q?u/zVBUJxpEstOp88cZkNvh9bjlr3mdMIhfmqTmmiXcYtSQiODHc9Sxv8dgJb?=
 =?us-ascii?Q?ZNP3a2tc2dBWAzBObU41bGKTB5OA4GP9t3SzaEu1nrzeubaqMCoJLpQwNGHU?=
 =?us-ascii?Q?fqsVjx9CjpJ1dkz87HklemwGGHawIb7LYi3/6uyPBkbHxSbenMt6KPp8lXJb?=
 =?us-ascii?Q?hgnNNzmNXXA8DsIgwLOsOUcdyW92Y3pmrNewtI9tq8f5qbkgKTsFKK+vxsKA?=
 =?us-ascii?Q?jO+EoxxsBIMTfwona3qpKYMGP8MmusOEjwlVKSC0fPQliSTSZlDJ80/zMmB1?=
 =?us-ascii?Q?Gohaj69Wk8wLK2XlObDiNr76ES6gPtxiM50Rrq8LED/2U7Zic7SmC0dlVUYb?=
 =?us-ascii?Q?m5RVryGjfOL4Vq1nGUMBMpiSB0tz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ys/07sGmjlRlDdo+wqsA1eG8HgOHFKgRUUtDdgo+0T433c0p51/sXV/x1iZj?=
 =?us-ascii?Q?xIKENU8ly5YSoo6LpGCvvNzZySFQywBID60WHqaILQc7a/euBnfyM3FAzoga?=
 =?us-ascii?Q?uev0gsC+S2VdNZ8GFOmMfmbgUZq/FvfhbtNzEarUni7dW3UXizOmn8kPOLwl?=
 =?us-ascii?Q?OnzJQY1lv2oipO3mwcjRwdQfdqsLCIN+vD8HcDxPxFFkus9sqYspKizsjazq?=
 =?us-ascii?Q?DVqLkXrzhHu8ocluE2tH12R2ZGDr0aJVhU/UXvW2YpLqPkvj0fBjn3BAjT0n?=
 =?us-ascii?Q?dAV8XVqTsy46Qrj5/YI+YbeHchWFc0IU6IJ/drUvFfDdRsGptF50TMb1zivm?=
 =?us-ascii?Q?ssPwyNov61B2o74CEFsP8oXIKkgx72vvKSLCtJtd08W0fcUHN8zdQD1IPsK4?=
 =?us-ascii?Q?FcgWO7pALt1ScVtxnKKLoPrb2jCrJCG7KJQLOyj7xraVoEQHAJBMVsMcesNg?=
 =?us-ascii?Q?0b/Y25Kw1ZuVedq+R1hEHXrMRcyOyDo0dugv9dvPozskrKpnmi9pDQQnFkfE?=
 =?us-ascii?Q?Y8KdjEzeXqHsP2KJO5DWxev3MAvaRUzzD6km/dyeJoGtf0NrlAb7f62VtEn7?=
 =?us-ascii?Q?gMv5fwe7DjGYlm1QjUH8UvolEHcaPC+LOFKBmtSQR6ylq3HBe66DAZmdIzxU?=
 =?us-ascii?Q?SlfyZo51YEu9U62l+RV3FSaRbSrXrEtFIZLND3DkpXVQ7JrgU24mYL6Zhehg?=
 =?us-ascii?Q?f3eURcZSYPjZUn3lSHeWSRwKuI9fQI+UFLBGMo1wMwwcc/eAwTGviaQK8OAu?=
 =?us-ascii?Q?rwwfWYF8r2681IlntqvaeYoy30zERlwXD6hEDFyZg6wqtijL2ibASgb+52ur?=
 =?us-ascii?Q?uontiySWXVy3fp/2deHXsm3Qjm8GteJQVk4mZ5v1qaDsQzJPV4I93OQsnVBu?=
 =?us-ascii?Q?+1ew2iwd93qBTErel/ROeiLE+AJ8bGDKAED1sGOt70DS2peS5rxe4ZF2zCGP?=
 =?us-ascii?Q?6g+SsK9kJA3agVWD2fRJjVQu5d6G92aoR0TND+QewA/iobv5OPDP6fmU72Fq?=
 =?us-ascii?Q?Oc/TxAMcJI7KZ67NEYMKjcJ68lalmtA3cErRcBRI8c5V1lQ76YtKtD+8nDr+?=
 =?us-ascii?Q?HpwJZ/O7Zbh2s5P6pd5gJ1koezDHdhKJ9/J3aUUvgQhlaHXjiPLzqQgEkw89?=
 =?us-ascii?Q?ljI1q9HyS08GkWlJeLagze41o9WclEzLyNLhEPyCPL8Ch4qvMIPLFh8lRvRH?=
 =?us-ascii?Q?httxR+lhV4oSxnKHz6H0t6iZJgBOBfMZPb8JgxRmLl7LI2O9Kyr4CMIecAaE?=
 =?us-ascii?Q?beXV+gbx3u1LlyS8O0ZBEpZG1dmn3tV2+HKli4sKGo77DoOoa0d+WW0GJbfs?=
 =?us-ascii?Q?EXnBtQQePger6e6RgeAE4056hf+0O+04Tqs6eHj9SMXg25SJNBu/jW2YL97d?=
 =?us-ascii?Q?LhffQmlzTwKLBXoJWqP007B7+BHPtwUbWsxqc+3J4PW69kjIqOiZg9oTSX7i?=
 =?us-ascii?Q?etTEbzda5RWn0hSL36ihCIpVmU+gBjU+2Mz2yVN06tqS7lTu3oJl85YyK3Tj?=
 =?us-ascii?Q?NJQVhlXDu24JEh2ZNygjESVm6JB8KeTD1/cdoOXzR6lkvZJU1UIgPES55azr?=
 =?us-ascii?Q?ig7FkZSh/Tn0ZradGcoj5rExoLhaKJH8m6M1Yk+C?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf54e931-1f06-43df-8bfe-08dd50f4c787
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:50:40.7847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiWOfVk38lrc+MhkSGivNYPiJ/rrUQ0gYCUF6X8aCbZsAlCqOv0BynzEbq4AH3MGWp8GXLAvKFzPYEnDt8BqjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10096
X-Proofpoint-GUID: 5WVOL5rPDXsSbDJW0w7rKPmOlm087BwJ
X-Proofpoint-ORIG-GUID: 5WVOL5rPDXsSbDJW0w7rKPmOlm087BwJ
X-Authority-Analysis: v=2.4 cv=d58PyQjE c=1 sm=1 tr=0 ts=67b5efc4 cx=c_pps
 a=WCFCujto17ieNoiWBJjljg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=T2h4t0Lz3GQA:10
 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=9g9m8Zzpkuj7DW7ovtoA:9
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

Normally, the vfio-user client will share a region's file descriptor
with the server to allow it directly mmap() the region memory. Add an
option to disable this, so the server must use
VFIO_USER_REGION_READ/WRITE instead.

FIXME: doesn't actually stop sending the fd??

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/common.h    | 1 +
 hw/vfio-user/container.c | 2 +-
 hw/vfio-user/pci.c       | 5 +++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/vfio-user/common.h b/hw/vfio-user/common.h
index f8c61f2128..72138220ba 100644
--- a/hw/vfio-user/common.h
+++ b/hw/vfio-user/common.h
@@ -84,6 +84,7 @@ typedef struct VFIOUserProxy {
 
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
+#define VFIO_PROXY_NO_MMAP       0x2
 #define VFIO_PROXY_FORCE_QUEUED  0x4
 #define VFIO_PROXY_NO_POST       0x8
 
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index 3974bc8a8c..3880316238 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -102,7 +102,7 @@ static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
      * vaddr enters as a QEMU process address; make it either a file offset
      * for mapped areas or leave as 0.
      */
-    if (fd != -1) {
+    if (fd != -1 && !(container->proxy->flags & VFIO_PROXY_NO_MMAP)) {
         msgp->offset = qemu_ram_block_host_offset(mrp->ram_block, vaddr);
     }
 
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index e65c7eaf02..8a05e69a46 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -36,6 +36,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
 struct VFIOUserPCIDevice {
     VFIOPCIDevice device;
     char *sock_name;
+    bool no_direct_dma; /* disable shared mem for DMA */
     bool send_queued;   /* all sends are queued */
     bool no_post;       /* all regions write are sync */
 };
@@ -264,6 +265,9 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     vbasedev->proxy = proxy;
     vfio_user_set_handler(vbasedev, vfio_user_pci_process_req, vdev);
 
+    if (udev->no_direct_dma) {
+        proxy->flags |= VFIO_PROXY_NO_MMAP;
+    }
     if (udev->send_queued) {
         proxy->flags |= VFIO_PROXY_FORCE_QUEUED;
     }
@@ -402,6 +406,7 @@ static void vfio_user_pci_reset(DeviceState *dev)
 
 static const Property vfio_user_pci_dev_properties[] = {
     DEFINE_PROP_STRING("socket", VFIOUserPCIDevice, sock_name),
+    DEFINE_PROP_BOOL("no-direct-dma", VFIOUserPCIDevice, no_direct_dma, false),
     DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
     DEFINE_PROP_BOOL("x-no-posted-writes", VFIOUserPCIDevice, no_post, false),
 };
-- 
2.34.1


