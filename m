Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E75BEA3C4A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 10:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAmvu-0006IJ-7N; Thu, 09 Apr 2026 06:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wAmvl-00065g-Au
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:48:14 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wAmvi-0006SI-LZ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:48:12 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6397tK4u2041684; Thu, 9 Apr 2026 03:48:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=DJgBrU89x0Xj39oqDstylv5nGc845iu1BsAVm6rOE
 9s=; b=ZrYdaWVZxzLSt5PTLZ2MPm1bnHG0tPXtE3I535Q1YyH84wojOoj4bkRHP
 DMb4SxETYJKysIdrElTg+de/PG2T5hczDliw6r+fOXDzkZfozYy/e182Qk3L7oNH
 2WZM6VUiIFyiwLsMSFR7PjOUCVxtv4EbDCjnL9QD+/rjTxBMMRFmxH3XXHzYPT02
 8sVDYsz7TUvTo6mH9uaNng0Lu8t8ORHXpiySbm/ZvJzawWg6zhdAQV1cNLTXXmJg
 0talwpn1qghOhUtCIryxuNRcd7ocIAW41T0CETqkmHFK7SHjn46UBDsha+q5ZiHQ
 swkBT04LnelxpduAaH6F4xuQOvn4Q==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021099.outbound.protection.outlook.com [40.107.208.99])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4dcms675rj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Apr 2026 03:48:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OW6SvcXqVWWVtgsvUL9NGmVWh+0tO0b2bqPdKR4JhDZsvz4Gj6ZB4mZDTIpkIo3Hht4wuLX7bo7oH6pxIl8phbsHUfaMr1JIhjLnuFYz4SjbcOc1Q0/uPBVLtCWb01GD4eraibZFged/d2nUMmvALVFQ1JG/KrNc2jD4cojEhSStdDnlYNF9ucXQAvQ5IHycadI8oPZghvLMmjIXR/ycpyJgj5ESoba+zUzYAknU3uuvc3t4UmBHhRb40k8GDqGbpHbshqywsVfzOboG8xWHU2MZQoW6l11sSigSeebQb55pOHC0ox5uDNGFwJ7D1zpUBjU+cVssIfUMfBrnNNZvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJgBrU89x0Xj39oqDstylv5nGc845iu1BsAVm6rOE9s=;
 b=GqL+sPlFoOzS0zgUzPAVQD8QCxECrhAm+FpXup6nRp+z3RvrSuyWOh/BQIl2NCUwYltiIOf8S0HVWXRftlCN1yNRLxh8ZgF+/yozPbAj99BvT2+SP1gBeKx7yGVfVLHvsNNw/RnIO8E7J9907TkxKnFsWwi5jKhe6tagu+hLBkMf5dG7M9ZHTjAU6/9TPuxTt4RLmCFkp4v6viU68i4+RoW/o/FoWGf/vhlkS95OXCdOu3isp12dD2V/zfbBcnGWMorCAn+LcLavH01xmdilIYd4/B0BHrCnf7LYUYz8tOOjFh74VlVGXqp+lu9jBA1YQD5xOwUwlM9cXqEkbPkouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJgBrU89x0Xj39oqDstylv5nGc845iu1BsAVm6rOE9s=;
 b=L/RwbPFEZCj/3zQj+K2Q98hXk2rDdFBhOpOu70+PLtkkfbqMizcvPwi65iKf76U78Hz64w8LfTz4nxKHlfKKcYcpSV9zxXC3l2ESUpgJibKZNb5U4wJqFhBVCGrNCvOHEUXVmVwOFmJrxjV3ifiahb0zGVjptkxEEQHNtptlmNSPEfMhWXbfIZnKxNFXiawe3VnR80sj0qawKHk6ffEUB6+Vr4FVKjPlXWrWMcbJc1HFfQv9xUrPwxYgS3HGxQmznySWSu+SHXc5l9Gm6NJ5901zZvnB/fULijzRHW778G5IQUqKaX9nuIM8xA/wMMYOBBQpr2nejswX+1k2FGXm7A==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SJ0PR02MB7597.namprd02.prod.outlook.com (2603:10b6:a03:319::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 10:48:05 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9769.035; Thu, 9 Apr 2026
 10:48:05 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>, Patrick Mooney <patrick@matx.com>
Subject: [PATCH 3/3] vfio-user: fix DMA write reply
Date: Thu,  9 Apr 2026 11:47:56 +0100
Message-ID: <20260409104756.465294-4-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409104756.465294-1-john.levon@nutanix.com>
References: <20260409104756.465294-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0057.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::21) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SJ0PR02MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: c976a49b-6142-4f1e-ed15-08de96257ad0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: kwTDer9PMMfboeXlc1Y1Z2ezYHuiGGL67QuB8gwLmuk3uUjQjcMV5G4XVhjYubKPd7FB6XHeHN7sYeCiOSgty8A8lEkBNfLHbmhgA33l2wxSg1ufuQzy19XUpfJ6uW9q+q5hkeviz93MB/FajTZZrvejMtfcPbZMEoXVTm2Xo4RdLqQs+jzyvv9MhDQBEGuPYU9n7PbHdJlUpOmMtzLn3i0zgy4Ioo0gjyT3AIXq+6pj7/aY2BVRUtgDCngxM25iSf95sUnrEzZ31HD1PTAkMh0NitKMEnmtdOLjdEgs6g2i6xUTg1zjLCfe7e4LnuuXQFgAxIm9es25fS5c4QyvKX7FP6KdrPoHzRFglB1UdQOVxn2ET3EEnh30dP4taukhOGJUDh1S/6s+xIrPas6OKb9XmGzWPemIdbcLDWsO4YdQmY/vTZakWR9CcIlORdqmss2JyaR/IIYihqKjSRdGi2PiXFAarprWdRcI8IW/CmLnrsfiUZg15qKYfmrqOHUA+aUozJLkPw/ngAhAz04oPtCevcxFs7FTVgSX5PMqdPSAzOy7XdwJGpsoMh4pwccoqCb3G/A5S3mCSx7/4FvybsLGKsgxsivfCUhuYX/Wh7JdF1qtXaykKmJ0olbsY2HSdpR4xXhh87dedpQuo4mudlS9naJ5FumPEpj9hQqFCA1w63PdNIiHEaDzfSMY31n1q1KWui6llP1Igc5aRxAU6txnDm3SttHu55Nc8scPj2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eDiwt4qZfaum/h2WlEYlrVklLd0/1wVc3+HocxmRdViQQpapkhDcJsWVCMgH?=
 =?us-ascii?Q?LU+1Bdz4jWRTVGNPLZIVRQnvDNnA9pID+snbU/c2CoPxzfwpQlEgSYh7/eji?=
 =?us-ascii?Q?JcoDE07ELUovBQc3EQrkIoFmoegZTdbuVkplqg7tATgfc8NcIizfweqLxcHF?=
 =?us-ascii?Q?b+pJz3HZGpPwSnFj3mKjzeZJa4FeA1z0B9/rw1i5cz2x9cxQgv939u5/PCcS?=
 =?us-ascii?Q?v4lf5BTmGCP9TKLLYQkbTG4aL0Abp0EuG7W/ebpXu9uyQOAuOvnl/j9nTOli?=
 =?us-ascii?Q?ejakktA9WoVpL0H6TujMcLo9LvKycs3SjFc5OV2NsN4OlQZVb9j+JsUOurZV?=
 =?us-ascii?Q?Gs/xSxeSrosb9z3cJjvcxF+VIxgpeTNdC3nUlsllCrEiGmVCPsYDyLUXTF9l?=
 =?us-ascii?Q?wzzAQYsUsYnC1E6alkDEUBRHT3WSKS+qus5AFWdswCPv8gFce5M1kAD+Abkv?=
 =?us-ascii?Q?+vzFwF1AM02vcLveCPQyxmIHDI4Vtx8u5oJFs26+TTOwYj5Wyk/sujRVx6Ic?=
 =?us-ascii?Q?D4bxIdHaYc8mWEesoEgrv/kkgqkVWqsLb8Kh8FO8vJ5J88oFomt5eCikPZRG?=
 =?us-ascii?Q?ncLkJU8OP53HhMsTy8OpRn80vRoaYqEt265IA/5jYI/LvzYpMh1wvVvWBs53?=
 =?us-ascii?Q?hKzKT3GvEHpPHoBrKxj8Zo0sWrLzN7C/ujxfN8y2rtHFeXH11m3CfdhGdgRL?=
 =?us-ascii?Q?20CWntqZY1Mpqo8Kpi8jnq4edYF2LoDISH8H9+i3ui6svGf+3iFSQ78cR8Ev?=
 =?us-ascii?Q?/LcwhzqvN6LsBI4P7Y7MKgxgeIIEoYCoCGPqluiY3sUMHhgaIWz3XleBKXW1?=
 =?us-ascii?Q?M45r49LRRLI7oojbzbPSW+kk8qBGfyPb9bnZoN2JLl4g1hRWLV8ehNrmy9LK?=
 =?us-ascii?Q?q01zYBgCM8P28ZG+FE40pXZpEim+ptgRtuz8EQmpDELa9qjwIqrtc2g9bLvh?=
 =?us-ascii?Q?dkjnFD8fA0zIMBnpJT50m62XT4bc1Ds9vEcUHnaKrFb8/bg2inCJOrGK8JCK?=
 =?us-ascii?Q?cDa4G17/hIUZtXffzmR7/tNoO5pRHlRQX1xpva2cMxoESXt/DE28zaPTWGOZ?=
 =?us-ascii?Q?tuCUeZPA/sSsCHp8JBWo25P92R4uOzlhbIJQG2Wll5N9ZCRLDTWUYZGsJQlf?=
 =?us-ascii?Q?iAFXBNfGDOt9rLWxi5wjdyhARqJUxQNB6ZLSmvgzq6zkvtR2DmEy+d05xIDk?=
 =?us-ascii?Q?yg23J86kSIqpVA/r2+4KSIbW0m7dj+yf9Ituvlui4noZvykKqLlRYyOqL0HR?=
 =?us-ascii?Q?K4V/QMMHcT0AbHI1YOELSaSmyVEI7JrlJf83GIqzyllJrQ9YCCdAyLUyXW9e?=
 =?us-ascii?Q?MhGuBsm3IHXqknQclDj1WJJily8XR56uBycTQoSxbcAAN265dHJWnevKyGJO?=
 =?us-ascii?Q?e8FA2ZKW4DIVuKEAhF1MqFDtxiqOZFy6Ymg/Vmop17yPHox2u533Fvh0TZwO?=
 =?us-ascii?Q?nGZtjkPGH/emUGKUopkDZBIhDBuVkXVbsnMaa7xAvCGZt2Ib4dOxayxWbuGT?=
 =?us-ascii?Q?i4d+bR89yhR7scZmauSaJ0EaDRVNWJAgNEjja9FeRJ0SCsM4O+jT3hWg7C3Y?=
 =?us-ascii?Q?VqmN26V5qpXeAiL/fIb55aORzfXRCz1C35iOp+5M/tLIJPPXtpYHPcBFLri/?=
 =?us-ascii?Q?Ati3zHK/4yR/tXHlaNKgL3yjtTCdfm14fbUa5vG7sJKlh8Oc6QKVxvmATO2Q?=
 =?us-ascii?Q?fHZX2SoN3yqyYYr1BYsi/Yyqi6XhN+mTMluFhHCeTigYQFQYnssPeRYOrzzi?=
 =?us-ascii?Q?oYGxrgdu7Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: A8OdHcBTYpsWxtuwouCJCxsYqKpUryxxrqqWAza6zjl6pkXxg0ujoMk65ZM0OW3JcSiEWwVUaI2ocd7yF3x6g7TqogVdcmZqOB7HgzJmAV57X6eymYpn0t+bJdBxhXamYD3ZV+fxIc5uc1o14CTPa+S6zgEseKFKZ9wGYNhJSMpnCW1GK1C1qzUW4tU1anZEDrh0/3Ejdu8Q7ECaxwoYlCyWgFKJ1bkguYvDbsgvRJZH+y8URy6ckKjrPgB+uVYPh43OqBj8YPFPYaDoasaucx6llzJBySteT3UWpQeFv8jHj8lSWkJ0Y4YPu6Bm1UnaFKh5CNtlAEOtbVFo2Le1nQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c976a49b-6142-4f1e-ed15-08de96257ad0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 10:48:05.6254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgKsnEn31gVT0MQCblJFsicvkCHtj9ept28uNXKsbPg21RDc91pKkbBrzHeACwoI9zQFhu3DKXjIxHXc3RLOPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7597
X-Authority-Analysis: v=2.4 cv=Su2gLvO0 c=1 sm=1 tr=0 ts=69d783e7 cx=c_pps
 a=gvdBbcfKwwW3/oSCzHqKfA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=puMWUmrUAAAA:8 a=64Cc0HZtAAAA:8 a=w6TJzBNOSodSHIE7IQgA:9
 a=oJ1xzHRvupUJs7EIRaQM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA5NyBTYWx0ZWRfXwUeemlL69OMo
 JYvZNikD85iHjMFSHYHMMjniQs0mOWFD7CB2K3bdxlkYPaCPa+3M+D9Ny4xPgt/AAHONfUsWaHc
 YZZIF93HXF7okFJLpeMeTbImPef20szEW6muGS7SU1I4fP0M6WnrUxGh5tsBia6dHTJliG8wVTQ
 S/GJH6BLdcEbBM+RCnh5lhvGz727BqEgO//vd7m8mZUWg0sbTnoA+3vwaQRvEaIhd/kWSbpmGqT
 U9YxvXRn5I4GBySYe69pUeojGDZ+Pq8v43PZ+QCgWCpM72GNllzxZO/gfFlIDjCBHIcBoxb3gBq
 RT7L306GdQ1xSlygfDW1jAOmNsnuWycUHcLxxjbKUSbH6lo+6gJsmX9bGTWNeI47/a7RIgApS/4
 P/TJ0UzMzBxrrWXs7NCrCcI3gckl6G48th5/CxOt6Mf4gxSwYkt8OVMC/dC/jWeFyL89q8zRIi7
 WGN4/HGg9SlDvvssHjQ==
X-Proofpoint-GUID: dKNGsafrwZil5F6HPxgZnWjWX6Fp8rld
X-Proofpoint-ORIG-GUID: dKNGsafrwZil5F6HPxgZnWjWX6Fp8rld
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_03,2026-04-09_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The protocol specifies that DMA write replies should include
address+count, but the client code was only doing so for read. Fix that
up.

In addition, add a protocol clarification over how short writes may be
reported in that reply. QEMU never reports a short write via the
count field.

Reported-by: Patrick Mooney <patrick@matx.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 docs/interop/vfio-user.rst |  6 ++++++
 hw/vfio-user/pci.c         | 30 ++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/docs/interop/vfio-user.rst b/docs/interop/vfio-user.rst
index d4766487ea..12deb25102 100644
--- a/docs/interop/vfio-user.rst
+++ b/docs/interop/vfio-user.rst
@@ -1429,6 +1429,9 @@ Reply
 * *count* is the size of the data transferred.
 * *data* is the data read.
 
+Note that whether short reads return an error or just set count appropriately is
+a client-side choice; servers should be prepared to handle both cases.
+
 ``VFIO_USER_DMA_WRITE``
 -----------------------
 
@@ -1469,6 +1472,9 @@ Reply
 * *address* is the client DMA memory address being accessed.
 * *count* is the size of the data transferred.
 
+Note that whether short writes return an error or just set count appropriately
+is a client-side choice; servers should be prepared to handle both cases.
+
 ``VFIO_USER_DEVICE_RESET``
 --------------------------
 
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 64b8b3cb8c..facc79727a 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -109,6 +109,10 @@ static void vfio_user_dma_read(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
 
     r = pci_dma_read(pdev, res->offset, &res->data, res->count);
 
+    /*
+     * pci_dma_read() doesn't support reporting short reads via the reply's
+     * count parameter; in this case, we'll reply with an error instead.
+     */
     switch (r) {
     case MEMTX_OK:
         if (res->hdr.flags & VFIO_USER_NO_REPLY) {
@@ -136,6 +140,7 @@ static void vfio_user_dma_write(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
 {
     PCIDevice *pdev = PCI_DEVICE(vdev);
     VFIOUserProxy *proxy = vdev->vbasedev.proxy;
+    VFIOUserDMARW *res;
     MemTxResult r;
 
     if (msg->hdr.size < sizeof(*msg)) {
@@ -150,26 +155,35 @@ static void vfio_user_dma_write(VFIOPCIDevice *vdev, VFIOUserDMARW *msg)
 
     r = pci_dma_write(pdev, msg->offset, &msg->data, msg->count);
 
+    res = g_malloc0(sizeof(*res));
+    memcpy(res, msg, sizeof(*res));
+    g_free(msg);
+
+    /*
+     * pci_dma_write() doesn't support reporting short writes via the reply's
+     * count parameter; in this case, we'll reply with an error instead.
+     */
     switch (r) {
     case MEMTX_OK:
-        if ((msg->hdr.flags & VFIO_USER_NO_REPLY) == 0) {
-            vfio_user_send_reply(proxy, &msg->hdr, sizeof(msg->hdr));
-        } else {
-            g_free(msg);
+        if (res->hdr.flags & VFIO_USER_NO_REPLY) {
+            g_free(res);
+            return;
         }
+
+        vfio_user_send_reply(proxy, &res->hdr, sizeof(*res));
         break;
     case MEMTX_ERROR:
-        vfio_user_send_error(proxy, &msg->hdr, EFAULT);
+        vfio_user_send_error(proxy, &res->hdr, EFAULT);
         break;
     case MEMTX_DECODE_ERROR:
-        vfio_user_send_error(proxy, &msg->hdr, ENODEV);
+        vfio_user_send_error(proxy, &res->hdr, ENODEV);
         break;
     case MEMTX_ACCESS_ERROR:
-        vfio_user_send_error(proxy, &msg->hdr, EPERM);
+        vfio_user_send_error(proxy, &res->hdr, EPERM);
         break;
     default:
         error_printf("vfio_user_dma_write unknown error %d\n", r);
-        vfio_user_send_error(vdev->vbasedev.proxy, &msg->hdr, EINVAL);
+        vfio_user_send_error(vdev->vbasedev.proxy, &res->hdr, EINVAL);
     }
 }
 
-- 
2.43.0


