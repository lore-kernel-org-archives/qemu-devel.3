Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9B8C7115D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSFNb-0004Dn-8j; Thu, 19 Jun 2025 09:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNX-0004CP-LD
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:31 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uSFNR-0008Co-Dc
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:32:31 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JBwK8o024158;
 Thu, 19 Jun 2025 06:32:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=2bD4Msh/DgvNZqqoBsVjzDGkAWswT+7/lucg1p0zA
 SI=; b=bE4+x7cCfs4I5owB9EEuuVGj7IrhG6DAbvjkSHDlxWwtf6iffBEAw1kg3
 ujGk1IEwV3pQSOYa9Vl7iOdBVRAf8yBmkWcRKdwJS17MTZlK6nyAvLryhMNnU0yq
 B2EP5gX/E9lEvFbZMzKxdGZvW5ccHgzdCHrhmxURNoim2wQUlMIw9IYeliBfRwtT
 19TLjHpfgTR+sb59hgQ5fAWO6Q+RSJcPiLvYvIW6TeVTudaIPY2nBlT7mopvEe6e
 AMgzqK/fBZ9Eth/dnV7H8IfnYsNsTR0IWHbGaoRQef75pJlGf6XCCJGySPSH7Xt1
 Yfzjtl0Y8P7v1cLYwU8XIZr3XTfkQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020080.outbound.protection.outlook.com [52.101.61.80])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47c0vfjedr-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Jun 2025 06:32:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHG86WYsfF0D3LAVynveBnDvIf6/lz3A5BjQHHgqLVKPZ3TTlB1lLiNhKlg1cEs2/wYIXUID0vcCvIIIypX8BL8PtmKIxuVlIb5sBDRYYkDbW+JyF0eLgEuftcyyKxwSkYIioh9KmWz5dGuvoNIuDZn8l8mDDDeOH7Q8/60lL0Oo/zbX74ORo+6FbJ5Ml1f2TysEx0B25GxHvyrZMxhXo3v/TuBCxctZqCBFfam9yq2sFAJIn10o1qPAMeNga1dwnSIUliPeSoEGaQ7DFLgXTY/cqLVFWy0XQT6GyYvsNIayLb80LE2NPpma3bNQjlka3zUcCSiKlYNAdmL+mdzFrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bD4Msh/DgvNZqqoBsVjzDGkAWswT+7/lucg1p0zASI=;
 b=M2Hi4TXDixtRGROXh2tcrowwSXxiC2Ygo+QVKTLPwbrtbiiw2OUWPQrwyD/76LPrSV9rtKTdKlmT5tcKg0fB1X7aBSF+dm9dPbFxmHRPWpGdSBzxpAVvMxFZvUG8ZxJQrl1UyAmotvFFaOH9n+UKTRvYqmjlvc1faPKYsJO6tZedj0sstpgW5Noe7xFohFPU6VOyTTSzlwOxHhzEk8Pd4rbIXxiTQukLr5zMPwPK1YA0VgBlJ6IvmoUrKpSn6Bsz1vIXktN6gIXUnv2itAGSaiHrflKY1nYHolyrOsi/iJdkojFE5OEN1uF6+LCo6iym7vw48TRt4CYAxzHMgI1sLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bD4Msh/DgvNZqqoBsVjzDGkAWswT+7/lucg1p0zASI=;
 b=x6OBl8h9+NjlyiR3Uev8we6I9br5kqOpjniM6dqOWC/Rg61NIR7LROlq+lml1H/ie5mhmSkAXzXsLvmPsEjYs60MbNKhPLhBeadlsdzPEM0DPlDJH+TDoo2UYTUniu16IFr0av214lCDtZdkv63teA94qr1bkAoyqvhNY7vFLGhOxnUWunVGu5uJ0nINhCcpMXEj6FVesW25hQfyaUDY5T05Y15+RH9YJ8YidPzQrpN5tlqeQuaRgatMvEhYubGnbEeSXA8fZlax5XGasrq+dPfgRmfqkqr8uIz14j+9y+T3ZksZPBMPcWtUoZyvTQHhxtI7hv/1c8DQWHJmM+2ROQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB9383.namprd02.prod.outlook.com (2603:10b6:510:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 19 Jun
 2025 13:32:09 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 13:32:09 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH v4 04/19] vfio-user: implement message send infrastructure
Date: Thu, 19 Jun 2025 06:31:38 -0700
Message-ID: <20250619133154.264786-5-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619133154.264786-1-john.levon@nutanix.com>
References: <20250619133154.264786-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::6) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cef2998-b04d-4413-1e63-08ddaf35b09c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7+n1wMskcG/pEfeLz/3qjpUl1kpt8KtsbTSZzZmwCVdMHI1An4f/ApNhS7zd?=
 =?us-ascii?Q?2ctDKfyMLqgd/iBmvgO7fgy822wHl0clmGlgXX9yHZcFJw3E+UlC1504jyZ9?=
 =?us-ascii?Q?DqpiEY+8ndmj9bCKw20LRZbbHNpWqY6uEcIcWuacBtyRoGOBa5p+HHVQ+pwQ?=
 =?us-ascii?Q?rCREP8E6kCSoEUrzUAUzsao/t8Cn30IVCjiXgu4/FpPN8zFmbuvnPEO+bPOB?=
 =?us-ascii?Q?Jj8eGeFJ+C1GIZcN+7B9/VfS2m6sxaZgYC8jVuEb1ToC3NvcREGroGwk/F96?=
 =?us-ascii?Q?hm3L/8BnCUaxDCiv25uDx5ldzAMG6nuNpdzrgnDMjdxfTZWkmTqPUob1Ce4z?=
 =?us-ascii?Q?x/Uyh79YVz0qWXlCdF58s9uDuR7pPxnETFuyQTJPJNXBBkFNzDySxNYwE8yL?=
 =?us-ascii?Q?j5gF5oMIRVU0DFY1sibvd+f+mWBl5YtzAfOXWFnNaLQXSR9xiPRoU+94tAAb?=
 =?us-ascii?Q?TXGH3MtB2cW9H8EOGeeNxX+Z0UlLhuuoJN3G90vqZJkniFUL2iDJwTuRiJM8?=
 =?us-ascii?Q?xPjVGUzvuNz0FhXDzZOd05O3rgcwuLVOxFjxRvXb7aNjDg36BpGjRx2+uLCa?=
 =?us-ascii?Q?3/qA0nUU0+hkJqITlOEN04XXWa/NWSmv9q3rQS/kXZUx4XfKaAOfgaqjr9mJ?=
 =?us-ascii?Q?rF/w8QczyPR6BUtPM6s903Le/mZ9juMOkXJDCa2ya829gUPHOEriMJAOK81n?=
 =?us-ascii?Q?xe9wl9EfmPXkO/fy95Ub2T52xfEj046jBBZF179Cyil1qk0BBKx+5P5lq3pZ?=
 =?us-ascii?Q?lzLG9Dxfja00uAXa08y1NvOQG+mjF08cmCjNEvN3HWA6HfSHcNZmjjDBwhkh?=
 =?us-ascii?Q?vewWWSpwXJGa5ecQ4fUeSA6zunYbr2HxpkQ4SFmxYwhQWhAGRKZLCX6N/bKQ?=
 =?us-ascii?Q?bHcm6luv2sPTgLcAQNElO9KduaQB+Vae7h7hYX7QazFMtrNNwoxKMgLQPkJI?=
 =?us-ascii?Q?JZ2j6BvF6aoI+1WqA6UiObXeTtGkUKrZG5VmAwzfA30F2rBkMKGw1gvHIC34?=
 =?us-ascii?Q?rw2CgAl6En46YDhJR70StoR1e76HHa5vpcqjkzbM9JfoxZ8E+ENZ08nTAal6?=
 =?us-ascii?Q?bPyMGs1Kzo+Qhi0RJBJBKvN5FRNP2C+a/DRhztCbEZCRcStwzWeObpa8Yx4a?=
 =?us-ascii?Q?fo7+uWxivjxyYqRG0qxc3JE3IqPSIPDm9mXnkDQMBioS6F1s68drWF4JP92I?=
 =?us-ascii?Q?AezjBAz8mPNizITKBv3fSpBmlqIYc5zdoLWYTUDuhh9zF352PhWVHRd+cnpx?=
 =?us-ascii?Q?IbXghneiMqwCbMLEVifI9vtslJKp5hgbg70jqFQSeN/7Pb8TrG1gFjyqe7S7?=
 =?us-ascii?Q?gLIRNlBqI4NLty1EyKY74IeqscToLtpBSw5OGeu6MljDFwBX4yBtP0hKUOG3?=
 =?us-ascii?Q?pIYz8AMX36glzWU8phvmrlpal78GwBQKD3VXFkqgH02iDE5vA0D+AUX4q96C?=
 =?us-ascii?Q?QNQ6lwfrk8k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Yd+z9+4yhwxL/zjKFLlWXF4Z6zusqwhYyusPCe2sy9vuvKlr8PX9xwYoa9u?=
 =?us-ascii?Q?mZ50u/KgWEWoK6ewmFduqgDBOLL1hlS1cYopfe7tcxdNRYrJWZBmlU61UjGw?=
 =?us-ascii?Q?zFZTHRg1mdxwxIqEcQ4/CQE3w0ZpEnMwynTyhFn1b0uhJeQzkf5GZBdUABK9?=
 =?us-ascii?Q?UdTWITrOnU5/H3P42eZ0JIfa9JRMZsZ//OcdFUTg3szDTmggW/m5n7GYuRSN?=
 =?us-ascii?Q?FVNHzJnlmrZvOM8byMG9v8uwaAryMPLGBaSk8xar3fEA5ZYPw1sgttO5YlCW?=
 =?us-ascii?Q?7tGmCYHdfAFPsQLEloy7rN+ciTwWzS1QHOZWYByhsKuWrAX0Na5IaNDcn0IG?=
 =?us-ascii?Q?RssKwJ5RYiAWL77UAo5HA4uUbYFbJPbCWpRkgcfe/dEl/tVWq1QGwM2iAqVd?=
 =?us-ascii?Q?lOO3a6Zl2xkdz15jWV482iiv6IrHHHAlfAkWsi6PVcB5lkOsnlpa6ncbENJ6?=
 =?us-ascii?Q?/5BNcEx1PM0RvcxMShglkFC7bbe34/K6+2Si4ME2G0Nf6UurhWIhLUwiW6G0?=
 =?us-ascii?Q?aL0/Qf5n7Eixvy4Z9gmCC3dYLmw9w7BnizQ9/hariEmotNbnGW8N0bll+dei?=
 =?us-ascii?Q?UGzVcWjhUdsers4SXDU21mo/s6INl8/5GjcJRXHZfnT4VK6ZCj8ya9aTVAKH?=
 =?us-ascii?Q?RAggI9SlZxN31iRo2yPz9RREZfWJ2XuL+WoHNM81WQmR8r2UkJ0hocEYydY5?=
 =?us-ascii?Q?5kAdtzOmZMKStO/dbl/gBPM5Y4YEMJFt1NTLVkIxSvdnr1mVSNhZHk477oDD?=
 =?us-ascii?Q?Yb98e1OhLOGNLQNAu1OWIOMID6ibnLBYE91kEVEmqjFSDTkQdYevkChL6u+c?=
 =?us-ascii?Q?sSBdmd+T3uPNZFmaZ1GB52ICoG+r1oSVNEr571fhNeGhC09srztT+lTrWe9g?=
 =?us-ascii?Q?0eQ6+hKC7oVviPEtyR94/6+pfXAPVnqUd1cews/iYcINB5p577afI7hSkQsQ?=
 =?us-ascii?Q?3jek5c+Fde/iAo5R52MtiR/BZ3o5ZowY0ev3BBdMZNL8vZMdq84C2J1gcJVR?=
 =?us-ascii?Q?G+d790z0g69iBy8Cwf/9CB5H/bUhW4d7qZGwNTcB7tQP4QlAOphJT4JIKgBS?=
 =?us-ascii?Q?Zaodeb1NGvUlGf/fdyqkDf70+fvxva2bLoWdkdepRy31XcwbuaN38pHGhQHo?=
 =?us-ascii?Q?DX8GgL74IRIHBv8CRQqDDXX/QqaYWyOxmwfCMbcKri3SQIdx6ENPjJVPlBBN?=
 =?us-ascii?Q?jkLIk9AVWYEZ77ZgymgFwqEnRGkyXTKQMEis8/7YcJ85a56j4ea0z/7/XUBH?=
 =?us-ascii?Q?ZcBvpVDMPzCAp1grBjzVChhJpRIpsVntm6p2iPBivMxKcC1rOv2DvjuN/ugr?=
 =?us-ascii?Q?J6u+NpIgn4HZhl2vKIvam250s8Zhqpu3OTHIVd5pP9N47F4naK3B+cVccXOS?=
 =?us-ascii?Q?05ytGXNdQDFIOuzyAsc7vZrreurFMi+gTtBHD+ST/6h5P+x+e91D2zcUyBkG?=
 =?us-ascii?Q?uEkZEZoBxITzaB6jpH3vXOcCWRWK/PeB0vkwcAM7eo3s4HMxAJfvoYlHT4JD?=
 =?us-ascii?Q?TsvlCFIoHLE3K1KxVmKZNQ/NV1jRDMhEUMLW/wrFcBgDVnstFR6qH6fJ8Wvn?=
 =?us-ascii?Q?kra1zuJse/gFeiw2PIMe7QiDMIEqooKpwpdhWeGe?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cef2998-b04d-4413-1e63-08ddaf35b09c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 13:32:09.1784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzTEJa8eYlMZy2XX0olq+hE6BsJLGG9LA7u4Gx3ZN4VyrFY8k8rV11atTe3NT9TJOAQGpsuH5MB6HOrM27w3sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9383
X-Proofpoint-GUID: i4yyOrdZ95iuZkfNNVyxCzlHxbo0OE0k
X-Authority-Analysis: v=2.4 cv=Tc2WtQQh c=1 sm=1 tr=0 ts=68541166 cx=c_pps
 a=UMsKb9OrGFB5W2EpWsGVZg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=UnscCpd6-9sbi9RN3AUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDExMyBTYWx0ZWRfX6HgQpDsxMzWL
 917Loid+k74HMhp53pTzAw8yEyG36YTtl2BhdiJDGk7iyvhhVxKQgdZncbF3DV7KMaJ+b2D2Gtf
 +xJyHfn/ZcTkK8XdLea9eEraJdNxWvQhDoP3ihJsNs+L0x0INwP6rxUSx2o8EO2RnDXfjT1pyOD
 NR7h3dB5kRYaJ5yCyYHR8q71lD6EDbBqTQF9Hhr1IufUN0LomSjT9CT/xeN1SsLkrmFI5OFYBbL
 g/hzgdWi4JnmV5+bd26rHqQ63qqfVND/6lxth0jT8KIUlJOmd27BCMPlYV4sK7JvCYxu7GOscAE
 fY4qhvGSoZBB5YXRMr4vo/wEPZFmyy+tsgzTiIBX36DhD0FYOROH5QkHq/gpMn9+rMfUxfg7bS3
 leKy2tgaTXl5XFYoHpu6AkiCKM+IW3Cv1a8NK2rrfP7bNHEvBrOFyhDb2afyrrLFtmRj8JCg
X-Proofpoint-ORIG-GUID: i4yyOrdZ95iuZkfNNVyxCzlHxbo0OE0k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add plumbing for sending vfio-user messages on the control socket.
Add initial version negotation on connection.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/protocol.h   |  62 +++++
 hw/vfio-user/proxy.h      |   9 +
 hw/vfio-user/pci.c        |  20 +-
 hw/vfio-user/proxy.c      | 494 ++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/trace-events |   2 +
 5 files changed, 585 insertions(+), 2 deletions(-)

diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 4ddfb5f222..2d52d0fb10 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -50,4 +50,66 @@ enum vfio_user_command {
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
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index ff553cad9d..5bc890a0f5 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -37,6 +37,7 @@ typedef struct VFIOUserMsg {
     uint32_t id;
     QemuCond cv;
     bool complete;
+    bool pending;
     enum msg_type type;
 } VFIOUserMsg;
 
@@ -56,6 +57,12 @@ typedef struct VFIOUserProxy {
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
@@ -78,6 +85,7 @@ typedef struct VFIOUserProxy {
 
 /* VFIOProxy flags */
 #define VFIO_PROXY_CLIENT        0x1
+#define VFIO_PROXY_FORCE_QUEUED  0x4
 
 typedef struct VFIODevice VFIODevice;
 
@@ -86,5 +94,6 @@ void vfio_user_disconnect(VFIOUserProxy *proxy);
 void vfio_user_set_handler(VFIODevice *vbasedev,
                            void (*handler)(void *opaque, VFIOUserMsg *msg),
                            void *reqarg);
+bool vfio_user_validate_version(VFIOUserProxy *proxy, Error **errp);
 
 #endif /* VFIO_USER_PROXY_H */
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index bad2829f5c..61f525cf4a 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -20,6 +20,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
 struct VFIOUserPCIDevice {
     VFIOPCIDevice device;
     SocketAddress *socket;
+    bool send_queued;   /* all sends are queued */
 };
 
 /*
@@ -92,6 +93,16 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     vbasedev->proxy = proxy;
     vfio_user_set_handler(vbasedev, vfio_user_pci_process_req, vdev);
 
+    vbasedev->name = g_strdup_printf("vfio-user:%s", sock_name);
+
+    if (udev->send_queued) {
+        proxy->flags |= VFIO_PROXY_FORCE_QUEUED;
+    }
+
+    if (!vfio_user_validate_version(proxy, errp)) {
+        goto error;
+    }
+
     /*
      * vfio-user devices are effectively mdevs (don't use a host iommu).
      */
@@ -101,9 +112,13 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
     if (!vfio_device_attach_by_iommu_type(TYPE_VFIO_IOMMU_USER,
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
@@ -153,6 +168,7 @@ static const Property vfio_user_pci_dev_properties[] = {
                        sub_vendor_id, PCI_ANY_ID),
     DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
                        sub_device_id, PCI_ANY_ID),
+    DEFINE_PROP_BOOL("x-send-queued", VFIOUserPCIDevice, send_queued, false),
 };
 
 static void vfio_user_pci_set_socket(Object *obj, Visitor *v, const char *name,
diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 31e08cbad3..0887d0aa1a 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -13,14 +13,19 @@
 #include "hw/vfio-user/proxy.h"
 #include "hw/vfio-user/trace.h"
 #include "qapi/error.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qnum.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
 #include "qemu/main-loop.h"
 #include "system/iothread.h"
 
+static int wait_time = 5000;   /* wait up to 5 sec for busy servers */
 static IOThread *vfio_user_iothread;
 
 static void vfio_user_shutdown(VFIOUserProxy *proxy);
+static int vfio_user_send_qio(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 static VFIOUserMsg *vfio_user_getmsg(VFIOUserProxy *proxy, VFIOUserHdr *hdr,
                                      VFIOUserFDs *fds);
 static VFIOUserFDs *vfio_user_getfds(int numfds);
@@ -28,9 +33,16 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
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
@@ -49,6 +61,35 @@ static void vfio_user_shutdown(VFIOUserProxy *proxy)
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
@@ -89,6 +130,7 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg)
     msg->hdr = NULL;
     msg->fds = NULL;
     msg->complete = false;
+    msg->pending = false;
     QTAILQ_INSERT_HEAD(&proxy->free, msg, next);
 }
 
@@ -383,6 +425,54 @@ err:
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
@@ -444,6 +534,119 @@ static void vfio_user_request(void *opaque)
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
@@ -472,6 +675,15 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
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
 
@@ -569,3 +781,285 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
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
2.43.0


