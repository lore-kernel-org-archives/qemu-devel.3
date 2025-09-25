Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AB8CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kFX-0000f4-MV; Thu, 25 Sep 2025 07:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kE6-0006dS-5s; Thu, 25 Sep 2025 07:33:30 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kDt-0008PY-3m; Thu, 25 Sep 2025 07:33:26 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58P9gfb01809588; Thu, 25 Sep 2025 04:33:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=uWY3ZfdpuEDvPMbDC1cVKypUkLaCNVLdzZ2f9IGMM
 Y4=; b=M25w9Y4ETDNFrVwTaYmM1v8zYLcQtqPZptG5QA24bUF0WD5ciobYPrZcL
 5Qlwz/mGnQ4oy8MZBP7XQcrrPUQMZdSxZk9/8/qGGZBSquWcWHTBpscgPleoeYRw
 zCOoPskEj+JSblj1EsklLrDPjdkA17uwjPlhtnW9Ux5CIZ5LppTyEsx4T9I26p/J
 IBu2K2g0EjBEDfLM9FD4XEPcuZtGu4vB3GiF2zR1iokXLvjnxp2Xp5/tvj3DgEsE
 rKC+IVIhjv8LB71JX+lrKJ7MujZv9FpHQNfYEgcVAA2CJRTtSU+1L+jFMnB+bzn+
 BXdVVdHNA8xuCYPBF/BGfiD65nFsg==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023096.outbound.protection.outlook.com
 [40.107.201.96])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49cgtjaucg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:33:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sddnLi4y9cMfbGgh/oqhqOMkic41u5ShCWLpeiHv9IaSJxBS5OL3RIGkYWVdrpwBAb42nYaLEHmaYwWMrsEcwooxUxETYXN0ELbu1Eg8KaCcvabwQ59rssLwPoWpl+meJ0mUBJzOGgLTQNL49jKa/uFxGOpA+Nc4cKR4qsfpBqoZZVHGwFc0bo1shQQ7xlulK47dZFizCWKd9z7ga5WpYUpp0+z6G7/+WcM17lhMmlbHQ3/aXs3FDZ+lmXhmEZYNK/hkmhdIxf0gADIcpURQ9y9fFkFXOMcJ2NC104aQPs0ef6lzJHLY1cUqNtnTe/Ar2czwQTlzVHx2/v5xCJ0rhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWY3ZfdpuEDvPMbDC1cVKypUkLaCNVLdzZ2f9IGMMY4=;
 b=nZ9Cj8kwEleNx6IUEQkV6u7goFPhoDkUbwLEgyw1MzTRY9Rt2S8EYktxzrOEQ7ANvNR9bf9KWAvCCr/S2c8FOD8jHKSocMgsd1bFYnS9Bu4YCg7yvGGnv71HSNo8dfxE6N+uEKHL4dyxKP+5Uyw9i/LP5Ol3tZjYfc63Dl7ZKqo7G00kXhud/GBR6QmKTlPJmR9kb1xag+jbqCf911nsN11OYbkfSE2VXkwEEt0279ogVFpNNRu0lzIFlWKoL0rzdgJ9+o8GMpdSNzvaQF9jo4Tq72gSn4MGCLgczLoGh0N7t666tkPviIqUHhwNMOibXZYJbbNygbG4AWEKBgX6PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWY3ZfdpuEDvPMbDC1cVKypUkLaCNVLdzZ2f9IGMMY4=;
 b=lOpklWH8+je4FS+LXiUnW00uI46o4QO7PgHrkxK8hYa9hZxzAyFmILcXd1oCC8X1uRRECaGHCgh5Fkxiv4BVyfoDgPhLnylz8uXZky2qY4JLwGw8aYbzYD4rqCo6QQPyJJYPOmsHDBJ9tHXbebh8ZxMkysjAm58hmIeI7Tu7guVkm4gLPs4VlEryu7bNwlcYSAt1AvMgiuXLOC18DuAPpD2hoOt9ipxxymupSMFPmPo+AIiu0uhZnVS6SADW87G834zXkHgWb0kyK3W2p8EEdwCEVYWzKKVzh/bObVPjJGLPvCsFWmB5fjPDu3xau+nautqNWbDFKT/oiT2VPSyNHg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA0PR02MB9854.namprd02.prod.outlook.com (2603:10b6:208:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 11:33:04 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:33:04 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 18/28] vfio/pci.c: rename vfio_pci_base_dev_info to
 vfio_pci_device_info
Date: Thu, 25 Sep 2025 12:31:26 +0100
Message-ID: <20250925113159.1760317-19-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0040.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA0PR02MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e228ad2-5159-4e64-12cb-08ddfc274ae2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDdvanBZQVdMOVUvWmkycC9sT3kvMVJwakRickRueEtIZ2VwL1FWYTFHVUJi?=
 =?utf-8?B?azdWSmRDa1NnL2Y0SXluVjhhaml4RlQ3M3d3Z1ZpMXlqdlFvV3dvZFBYK3ll?=
 =?utf-8?B?RmNqYW1penZoUEdhOFVtK2RNbXdEWGUraGJFbTdjRnJ1YUFqNkk4THNOWUFD?=
 =?utf-8?B?bmJQSHRoZE9yeU9IM0RXVjJMNHRaWlZZZFVZK3hrdnJobStJamd1c1M1TE9x?=
 =?utf-8?B?YVpPNVNEQ3BwRjl3R3kyZzBMUmN3WGltUGVJc3U4ZmVSVWFSa2xRK1hOdGVr?=
 =?utf-8?B?bW9OWkkwUC9MMUFJRjdLT1F2Z0t5NWZFeEcwR3pSM25ISWh4VzFqVkZFMGJO?=
 =?utf-8?B?S0E0Mml1by9zMnRwc05ETC9BVnpQRFE4QmVudXdibVhTK216bGk5T2d5eC9p?=
 =?utf-8?B?MFZZTktXRkVaZzlOTGFnazFEMUhaOWd0NGx6QklmZUNSWlc3SzlyZGI3c1I4?=
 =?utf-8?B?dW1GNktSamZwMk00ekFZY2s4TDlweFpCajJuQTkyak0yYUlhcTRReTZ0WlBr?=
 =?utf-8?B?bDR5bGhWUEdMT2wwandlUDBSUllrN1pLVEx5Qzk3QjhXNGV1TUQ1bTBHQVYv?=
 =?utf-8?B?VTF4TVRPUEZGK0ZFWGpjZld3NklFdHRQN1pqZWxGNkdKV0RWSExrR3JqTzhi?=
 =?utf-8?B?SEVTSzVULzFxbkd3N2gxOWQ4SVlBQml1dlJmdWlFL0l5NStxck1ZNHJnRXNn?=
 =?utf-8?B?QnJ6ZnJER2JrUXJlTWxmeHpJakZJZGZyMWZsNUUvOVBpbkp0N3pBZGlxbUVm?=
 =?utf-8?B?blkzR3FLd1BOZTVGTHlXaGZqSWttUHZTSmxGQWVUU3N3R0pBaFNOdzlXS1BG?=
 =?utf-8?B?a1VjaG1YYlFMUFBRVis1UFBlL0t1KzF3dWo0V1ZJaU9NbUR3bWROSkQyQldW?=
 =?utf-8?B?Q2xXZnJ2aVdnS3B4ZU4wcE9XMWpBSzlSWm45YVYvZ1VtVkJ2VWJpbkxGZkxD?=
 =?utf-8?B?NU1WdnU5R0NMMXpLZmE0UklOTGJQZ3A1a25vMTN4UXVDc3pDUUdyWERjNVlE?=
 =?utf-8?B?MWRRUXkwS0hxVkFZa3BGNjY0UmR0Z3c1dzJMNS9LNVJGL2RmNktVNERyQkh4?=
 =?utf-8?B?Q2NxY3ZldTQyVUF3Qkx6LzJ5SDdKc0c2dkdRMEx0TEFudkxJVWZMOCtBNEpZ?=
 =?utf-8?B?dGVrMitYSmpGS3Nhbkh1NXBYdFFFQWkwUmNPbDNsQTUvWHhmUFRpMWRQL1FX?=
 =?utf-8?B?Umw2RmhsNHFIbko3VzZYUkF6bXlrc2NOYjlYK0drZ0tWWjJPdWg4TzNnK1hu?=
 =?utf-8?B?OUozWXhOWjBaYmJaT2tpMS9VbVV2ZG1ydjhjMGI1SXZubXNjZk50Uk1hanFp?=
 =?utf-8?B?WEtYVnpIbkQvemYrZEpUWWYvdTBHUndSNkIrelk0STdvdnRLTmJ6N1VBbHJ4?=
 =?utf-8?B?S215WE5uZ3RycHhkODdVaWFFaWFrMzh0M2w0OVREQUFpUTk3QldvVmhNOTlC?=
 =?utf-8?B?S3RSSVRQVldIa0RqYU5qUU5WV2Z5amswVmZER1BreEJzcGQreVU2VEN5VnJ2?=
 =?utf-8?B?Z2dFaUtXTVNqTHYyaFRzWHpaYkpUdDY0V0RSQkFYdGNxa09rakZPVnJmVklO?=
 =?utf-8?B?VVVRK0FzRGdOb0J5b2p3S1djTVFLSTgyc3FlYlE1SG5ycHhwN0RUT1NrSitI?=
 =?utf-8?B?WUJ4QkU5cmtidVRRNXV6VE84OGlpUnZOUmhCZUFxdDJLeVpjMmNIYldvS24z?=
 =?utf-8?B?Uno2a3FoZW1vbmhmS2RtRmVnTzgvOVJTVlpJSlhvcTNaNDM5MWpiVHZpWFM3?=
 =?utf-8?B?UzVkNWVHQWNsNU1wT1BXbzFrUUtnT0c4aHRieDRuZEpLNWRPeUc1ajhlQ2JI?=
 =?utf-8?B?OUpKZ2srWEN1YTRxNFNMMkhsTW5uSDFuZmRLSDA3d04wM2ZNNktDQ2plTEhh?=
 =?utf-8?B?UDJORVNkZFUzYS92OFo1UklUbGh3cFBzbVYxV253Sk1GcjdRNjRVL1RaVDBR?=
 =?utf-8?B?NTdVNUM4Ykd6MHJVa3V3VytZMGZDalBrNUdqWERMaUNvRXQ3U0JlbEpXV2R5?=
 =?utf-8?Q?iGIWUwnbp0bWlc8EZv4qVnt4sg75tQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emtCRVJlcmFXeEhiM2xldWhPV09lWnJOcG14c0pydGFrNTBIOHdubHovcWM5?=
 =?utf-8?B?UkJqY05uMTJuSC93bU1odmtkL3RNSFkxQXJSVVlOVnAzQWN5NndnRFBVTVpv?=
 =?utf-8?B?ZHhCUjQ4TUllZ2NPZGJ6b3lET05UU2ZjQU1McWplL3NLNk1JNE9FbEdpRkEx?=
 =?utf-8?B?bmpqZFRNM01PdGwvcmZSa29xY1VnUnJTTzlwT3JMK0V6YTNzVm9kbEVaRVNs?=
 =?utf-8?B?emwxS3hYSGFZcEc2SkZSamdwT1ZxR3JlMi9yTVUwLy9YaTFFQVNsakR3WEVX?=
 =?utf-8?B?K1ZpZnBPbmVsR0hBQ09zN1p1ZmU5TmhSOHM2Y0oxR3dLTjdEVnBjSGJTNFJp?=
 =?utf-8?B?RjR0UmU4cDlwK2JBZ1FKenJ1eFhFVDRtUTdLR3hZNkVxZ0xwejh3b2IwQUtq?=
 =?utf-8?B?Y2ZlS2xpU0NFUk5rRDhCN0NGRWZyeG54Q0g2d09YZHpvWHZ4bXBwUXB1VGpK?=
 =?utf-8?B?QmxENjJVbm14c0svYVFKOWpURTJjWHArdmhJRUlXazNHdVpjZnZDQm1nRksr?=
 =?utf-8?B?NVhjWFZzVXRNOGNpcTBmV0ErT3pWTjVhSlI1WXBIRWk2OS9kZlFiZ215bkt2?=
 =?utf-8?B?WWRZYWtOT2t1dFJLZ2JOTENwcFpoV0J2dCsrQVk4bG1abDdIR2lJZXk2WUQv?=
 =?utf-8?B?UWtQMkgzUmRhZXZkeG9yMThCMkhpLzBxWkpCUnhOVmR6ei83VzlFZ2VPRFla?=
 =?utf-8?B?WTJKaENqdUlIQnBIcG91M1l6MFl0QWNTN1VGNmdVODNkUVhSa0ZuVm0xZ28x?=
 =?utf-8?B?WENhY2dMVXRlMHJaVUlRNGsxYllYN0pUNGh0U1YwZmVTdE1ycFk0bHkvQisv?=
 =?utf-8?B?elh1WXVnY0ZXV2JxRld5eG1EV1psVjlka1ZPbEVjYTJhN00xRm1oa1QvT1U1?=
 =?utf-8?B?bDRyYVY0SFdWWXdWMkg2SDc0ck85Y0p1L2RQWHZKUzN3RURKb1lqTkdRSjF1?=
 =?utf-8?B?SW5IdmxTR2syRXdwdG9mUHcwYy9kbnlyK1gvZ09GZzVBRU9qL2h5cHNWcTk1?=
 =?utf-8?B?b0xYYzRvaGMzanJJV3FicG15VlFCQ2JLb2tBVTJ5UXoyemE5b2lmeHh1U0Vt?=
 =?utf-8?B?VC9wK2U2QjdsblpGdDQzeWhJbURaYUVtMXNyZFpOc1NMTzkvN2M2bkVxL25G?=
 =?utf-8?B?U2NRWmdwVTRwOGM4cDJZRkJUT2FkUDlYWmsyY3FkSFVHbFZROTlKVnRRUTAy?=
 =?utf-8?B?K1ZJc2tlSkttOTdZQjFuN2QrSXFTcVRnN3FKU0c2Q2d6MmNwQTQrZ0c3cjB0?=
 =?utf-8?B?OHYvbE9KSHoyb1pqdUR3aURPOGpZUEwwRlluakxkanZuUEZGWDdCTEp1QXlV?=
 =?utf-8?B?ZWdwdC9VbjZXak8yeVJJbVlYN09SMVBIVHQxbGFLMm9ZcmQ3OENzbDZmcENZ?=
 =?utf-8?B?b0VISlVaalNPT2VHU21DZ0lBVlRoK0g1OUd5RlYyMDFVQkp3U1RsOGtvWUJ4?=
 =?utf-8?B?NUNDRmNnN2xRRXNmQW8rZ3I5M3dtQ3JUd042ajRaZXYyY0pGMkt3b0VTQWs3?=
 =?utf-8?B?UmFyVzUrMlpZbk1sRktiektUNlhjS1RjQmJ0RytiZGhYTFJFcmlRS1huek1M?=
 =?utf-8?B?c1NIai9hTzZvbUdjQ3ZVb080Z3M3ZG5wbUNjZjNYRUNjY0o5VnVLUFJSRUtK?=
 =?utf-8?B?RWFzaGVXOER3a0pGdHBGYjUwNmp4dXNJVWhaWmFXY3FzdkRlcnV5NUtyc2Nn?=
 =?utf-8?B?R3pzaTcxQ01uRThsUVMxbThaRGpXdzBtRCtyMUN2U1JmTHRPSGZBcTVGcWh6?=
 =?utf-8?B?QTBHcEt6MHlVbGhodk05bmFpR05CRkJXN3pjWmNkNzZiVUxYb1piODhXZHU5?=
 =?utf-8?B?SjFSVmF5NjBVeGwrd3VTZlNFNmRZT0gxd0xDSVFsVGtHejIxSkFHNjQzM0Zn?=
 =?utf-8?B?bm1mODVsbTRjamloSVVQWE1NcmdJMXVlb1VnK2hqV1Y0bThhdSt0d04zK2xp?=
 =?utf-8?B?TXVWOHdzY0U3Mm9rd0NoODR4K1pOT0R3YVdmdGJTeGFibTNCRDJySEk2VFM1?=
 =?utf-8?B?V1Boa3duMmN2VWhDUFZvQU40UUUrWkFSbkZVa2Y3dC94R09YSk41cFlOSWFs?=
 =?utf-8?B?Zk50SSt6SmpQSFdvMVNlUzhuNVh2RFJ1RkpYYk1qWWRaRzdZZkpja1lVZ21a?=
 =?utf-8?B?YmhqNEU1S0IvU2R0ejRRdjE1bnZRcnd3TTE1RndBS3pCVENRUU9GZ1dBUFBB?=
 =?utf-8?B?K2VJdlpTMGxLY0ZpMXhIaThLRG52cStqZnhoOTFBNVlaN3ByRUk1bTNvOGYz?=
 =?utf-8?B?MXlRMS9hdTdDd0wyNWQwMjV1TVpnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e228ad2-5159-4e64-12cb-08ddfc274ae2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:33:04.7581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZ1EfCE/x6uiVXGYUPH3/1VxII6jH9Ps0ZTJgQmjjq1J+wWEIKfK65fK2V7DJulEnmUeRHCS1eV10WhQD43gpXxG9jSVM85fPP6fr4nvEv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9854
X-Proofpoint-GUID: ImYjcGjwyaWVuNArbaC8Nh5Mz9qKS1Op
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfX6P9Z+q/cuLwk
 FMk1WdCxlYT9n0s4TzAQAlEiJA/9KoaGvsqEMoRlW3WtiMZm0nG1ugV7kZQgkzl7sQjS/LP7mgb
 Uet6dyphaSN8qL1Ki6/98oUZyuRO5cjAAnGlvkcQgeW/u4+x99yqCyYqizevkKBjnJPUKkmAWOu
 izMKMi4/OA+Kc7zfY4YJmaP7wRJ7vtJpszF/wzw4D/uo2kRYg/zx1BMOe6xEiXdJI+w15Qb5SJC
 D7hWCElEXgpfvtvFoYVhvik81668bdIyZP0X+RjndJyyp06kDx/jx7e8G4MWgCoC5n5AEoQmei1
 0Iu941LxoaHwaAmQYgXBMHEWhBelxtsirFJnDbWS6IviIJkRxlvaLSEd+kc3no=
X-Proofpoint-ORIG-GUID: ImYjcGjwyaWVuNArbaC8Nh5Mz9qKS1Op
X-Authority-Analysis: v=2.4 cv=MoVS63ae c=1 sm=1 tr=0 ts=68d52872 cx=c_pps
 a=sJccSC7dVDMb2XAcf7Pejg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=-an67RP_g-7o1LT8KO4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This changes the prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9278b46711..6c4c47825b 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3668,7 +3668,7 @@ static void vfio_pci_device_class_init(ObjectClass *klass, const void *data)
     pdc->config_write = vfio_pci_write_config;
 }
 
-static const TypeInfo vfio_pci_base_dev_info = {
+static const TypeInfo vfio_pci_device_info = {
     .name = TYPE_VFIO_PCI_DEVICE,
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(VFIOPCIDevice),
@@ -3969,7 +3969,7 @@ static void register_vfio_pci_dev_type(void)
     vfio_pci_migration_multifd_transfer_prop = qdev_prop_on_off_auto;
     vfio_pci_migration_multifd_transfer_prop.realized_set_allowed = true;
 
-    type_register_static(&vfio_pci_base_dev_info);
+    type_register_static(&vfio_pci_device_info);
     type_register_static(&vfio_pci_info);
     type_register_static(&vfio_pci_nohotplug_dev_info);
 }
-- 
2.43.0


