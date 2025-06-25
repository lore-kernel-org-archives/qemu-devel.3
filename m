Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53D6C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 19:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUVpF-0007yk-2R; Wed, 25 Jun 2025 15:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpC-0007yC-Qw
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:27 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpA-0003ER-CN
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:26 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PECg0G020023;
 Wed, 25 Jun 2025 12:30:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=zsYxzGKPziKrs
 DnG+EpOiV0AD5jzmZwF4KmUykFdjzo=; b=2I52eKakzyBXlRSZYHM/rBfrrRfUk
 BkFKDC01lSLY3FXOQBrVifcw58cRNKXj7uPuRQzjohW1ftbZ7MJAUi+XrXeCcoor
 B+3p21l4twdqpOvXzwrO3Kl7uJjQUcXoiL2xIlu7xTC7LxqnvqkIIXQ5/SKMRF1V
 zOUMYEBhbXRRFV7tMxKrGElziLsdGjia3MaRg4G9trm5AUuRi7OF3tMqpjv7jhtV
 9VSbdDTAD0Egq8kNp9t94fmDU8Y4BRlA2/c+/YB8+zwR50+JzR16wdjUgdP+bg5C
 TCkvl+tGlwm1uloa9m7eRP4uk5Sm2seMmc65FDAQxo49beh/0/CgvHWxg==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2104.outbound.protection.outlook.com [40.107.100.104])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47dtuhaqmt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 12:30:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgEu84FnESNTe5Og0Zv98CeMfkI6Aq2b4YI+Xqe8AqguN+vBjm5cCOsp24h5IP7BiAFKM0CWwbPmLkFFlzeZgpX4M+h0Msm5p7aGh2zGnhf35HJUY+yVJlDIX8LUWCzFGz3g9Y2YwI0L7u8DBUAYpBfY69iHbJF4k39T4avG0oLSW0qLD2H/PyivOD6I+U7uaX3xWiYMgauwgDkbEzqZnA4tb1dSX3J4oxBAmAjlqxVAqWlh8pigxdQsEOLeIgGoxtumaUvF3Fn31CF6LE4X1qMNmu04zsgsETpuRvF/gK9t96A05Wmhi1AoR/bB/WjO9uj604FB4yYpAcPyryIfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsYxzGKPziKrsDnG+EpOiV0AD5jzmZwF4KmUykFdjzo=;
 b=c/aJN308K3vI2el/jcLg/4OH25VK1TpIxTLWrQ0fKt6KyTRU5iZzOZcm8hy43m3xZhX0+TZ1TXd5Vd0PaM/U0wWsEdOtgjLUaILAD2zq9878aGJ6DPgSWkkQNZmPfj4uewM3Jt6IpaUZ7DHuQ+SBSTwYjEKaE6VHXV4myZJ7fLPIluDwogayrc9c3ORhn04vCdyzQVye8FUXyVyFuXP00mJXdPiVOS6pLsFz0/8ZJLfbGjRs/wGalPWyCwcRAqKzX+F74qwHlhqyF6A/EoKUzO0fcO9xsK1Oad1BYYf89XAxOL+yxPJIsbMFQ59MeVnos6FnQC2CdIF4yh37oO2k5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsYxzGKPziKrsDnG+EpOiV0AD5jzmZwF4KmUykFdjzo=;
 b=PUhuy+ZcBTiBEE6Tfvdugy7ECHAYjJTMEeS6HskviaUMinXUAWr3oj7N50JIAYt45tpjT+7iDPjEyJhdDjKod+7T3G28j7AYlOkS60rJxxDtEzLk9BBVNNxD5pqKmoqiP3hy8cOG9zndBGDaZtzQe0r9Im5gqb96JrSFqQErk3aZPauZ5BughGvdZ7c+bjB5a3S6r56bdePTaEFS/0KJ+bE6zPVxrjp4f7K+KP58Fi4PgvXsv5bqNnni0qqOZGlX88PHLOsaEDTz4j2SLzPMBTFETCKExv95k1+PTh7GM23v68OUXL59VuAqWxQttQAo7BwYT2ArBxNcnbHvdZ8hRw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8535.namprd02.prod.outlook.com (2603:10b6:510:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 19:30:18 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 19:30:17 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 00/19] vfio-user client
Date: Wed, 25 Jun 2025 20:29:52 +0100
Message-ID: <20250625193012.2316242-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: 5beba085-7e4f-4853-69ab-08ddb41eb6fa
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUFvMmhwSTcwd3NUQ0RJZ21xQVlxd3VralVqT0cyQnIyMTFtWG9Ld1J6T1dL?=
 =?utf-8?B?L3A3MERGU1piQ0Ywc0YxQlg0RHNnK1V6RDVIY281QUZHcGpDLzRKcno4OGVu?=
 =?utf-8?B?NGViU0QrMEJXdjBtSyttUklmRGE5SkJlb2FmVEhXb0FPVFB3RlQxcU9pSUMz?=
 =?utf-8?B?Y2FJQmZvWmJWdTREbWhZeXZQaEF0cm9ITXN2WUhGVDhIbm1SRXZYZ25PdmRB?=
 =?utf-8?B?RXNkdnE2Ynkwd2Ixc2dLanFVeHYzNHhKdjh5WXlLYlIxazI3MmVaMjFSSEJp?=
 =?utf-8?B?QkF0OGhBTDgwOFZOYnZwa3RrSmpxT29RS1plK3duS1JBMUFUUVlOa2x3ZXpm?=
 =?utf-8?B?Q0Y5NnFZTHAxakMwSEQvNmpaaGU1cmdmeUhWL1BhdkFzYnFjMm4yQVZTUGxj?=
 =?utf-8?B?eTBQRU9uSTFlaDRNTlRnUGZIMXdSaC9PSWhxQmVpYWF2TjJ0MGZJYXhrNHNp?=
 =?utf-8?B?RC81MlZSZXlxS1dHcWgvbWVqTVdPSXAxWlhkc1A4Ukd6TlkzY3YrSUZtRFps?=
 =?utf-8?B?ZWJYeUh4U0JLdFNKc2wvbEZ4NURjRUgvdHFQSUZxU04vbnRadTYzYVZWWUd1?=
 =?utf-8?B?VkxVeHpXKy9tZ0RSREYrN3FvZTAybkxXMFQ1TFp4ZDdxNTd3aWwvYTdURHI1?=
 =?utf-8?B?TmlCMUpudWJhTGcxd0xmM2ErZ3BxYmErS2FvaEJzQ3ZiQyttOFp1Q3phZ2xZ?=
 =?utf-8?B?ejh6K0VIaG5qVVZ3c3VEVU9KQy9pUUlYa29aMjBJdkRlSzBjTkoyaFQzbk91?=
 =?utf-8?B?MDI3T0Erb0FiekZFTWx2V29aN2UyR29qTnF5NWZCWms3cXc0a0M1Q1VRa2c5?=
 =?utf-8?B?Tng4UTc1L2xtSU85ZkRXWlFOaW4vSzZORm1jdEVLdDd1U2hqblhFS1duRDRw?=
 =?utf-8?B?NFdkNlpiai9LRUpVTVAzNk4zemJLdFV1d3RqRWR2UkNuWlloNXA5RTJJbUo3?=
 =?utf-8?B?WDBEU29jN0dIVHdTZEFZcmN2MVlzM3V1NTRkWDJVTkZabllrcW9vN3ZWZjVJ?=
 =?utf-8?B?OTUzVXRiMUdJVisrcElNT0l5ZkVNUVpxOVdEVkFDa1pGV2k3aVloZzdIQlRs?=
 =?utf-8?B?c0xMa1pLSnBsRVArbmQ1VnRLdGRmWWN5UTRvVVJDbkJycFBEb3lmRm9rU01r?=
 =?utf-8?B?Mk4yd2E1TUZKM2VZWWw5NVJVejViQWR3QWtFdm5XQVR2eXdNN1pTek9mY3ZG?=
 =?utf-8?B?Sk9GR3pTdDcwWFVwMlVtekxMdjV4K3pGaWplOFhNV0ZRR3d0Yi9XaVhsRSsx?=
 =?utf-8?B?U1dKVkpjdXBSaVlxbnJQSDBkY0o1THFKbEZUWHU3SzJhL1RjRDZva3BpZGZM?=
 =?utf-8?B?Mm9YUk9lTCt1N04vdTREZkdDd0oxUUZMWTcxZTUzTVFya282SWtQNHp4amYv?=
 =?utf-8?B?TmkvM3NvQlF2OFRCa2dZM1ZzZGY0U0tHbFRjRWZ2b0YrQXBGa3JoWk9PMitj?=
 =?utf-8?B?aUs2SHhqTk9lTGRTZlRVL3JNQjZsMWRZKytTYktuWGdFd1c5Rm9rVjZhczJk?=
 =?utf-8?B?dS93ckNEcGpJL05zK2tnR0NmNnBJaW8wMWhsR3lTM2d4UkhNMHptT3ZXQlpR?=
 =?utf-8?B?UVVad2RZUEdtTDVHL3lVbDdTRGFZcVZEdW9rbTdZOVFYTSs4eUs5OFVVOE5T?=
 =?utf-8?B?V0NhT1NNc3J0VEtOTURCTFg3cnhveVhBMzJNM1d0Vk5oT2d4VzFNeXVPS21l?=
 =?utf-8?B?czlNSGVKNmtic2p4d0k1M1RqNjNITWk4bG1iM3JVYjNPNldYbTlENE1zcEJq?=
 =?utf-8?B?WHdrYnpzREZ0aXVwT1BWZStaUXdTcGJUZDFuTTFHVnlWVm5tdG9SMEsvcHRu?=
 =?utf-8?B?ODRWOEJxZ0lMdUlUSFliN1ZhYzdBbVJPS0d1dDVZNFlodGErM05NWHhmL1Fl?=
 =?utf-8?B?a3ZCM2V6UkwxUERYNlpDcy9aa0ZPWkNkYU1ZOFdzdDFuKzlGMFJkczZXL3pk?=
 =?utf-8?Q?srqLrYFPDpE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEg4dmpySGQreU13aGpIVURVOFhJVHJiZllaUi9XT0ZaRmtkU3NwS1AzZGpT?=
 =?utf-8?B?eVNia3hEQWJpcXJZU3J2dnE1aXJtT2RKcE1PZytDMWZXeUt6b2F4QkdaMlhP?=
 =?utf-8?B?b1Nod2ZvVXNoMWhwdWh6bHVVeVVxZXB5OVEzUWxmVnk1R1BXTmRPTG5KUDFp?=
 =?utf-8?B?YXlicFZJQUZ1eEo2SzRQQkRWckc4a084SDY0dnBLNjE5UVhZMndwY0x6WVZx?=
 =?utf-8?B?YWpXSEhQTkNEWU1PUkhIekpJM1Z0L25QbmNidmgyWUlWeXc5QWxsN3k5Umwx?=
 =?utf-8?B?RHM3S0lBYW5MSEl3VGdobWdVb0pWYVFJTU1EQUUyUjVrT0JSUy85VHVTSWhu?=
 =?utf-8?B?M1lnZ2pMN0pZMXhJQk9wc08wTFNVemJQTVlLZTNkRmVzUzFkYlZyeWRWdG1C?=
 =?utf-8?B?US9kSzZaa01IeWhRb2owWDV2WGJkSkp5cGlzUmM3MFlNWExOZWlqWmE0aEZM?=
 =?utf-8?B?U0NrT3Z2R3Fla2JjQnhpNTZ3eEJxaHR3R0VwOTJJdlpHSForNk9tdmE3clc2?=
 =?utf-8?B?RnRPeWVVVjFJZDIzYW96VUltKzZuOE1MbW1scTQyK0c0WTJSS3Z2SFQyMTZM?=
 =?utf-8?B?ekJoczlVQ05XOTJnbnN2bVZhVUtRVXJRN21LY1V4Wm93UGpaMW9ycTF0RWRD?=
 =?utf-8?B?ZGxGNCtleHRnQXBOL0ZtOWdIOVNEaWorREh6ZmJyaGpYZ2JURUI3M0ZFWXVU?=
 =?utf-8?B?VUFUdFFKRzZWUjh3OVBpYUk4cFg4Z1Q1ODNOaVhTdDduckh2ODRYVXZqUVRW?=
 =?utf-8?B?VFlaUmd2eklxUWNLT0h3eWdqZFZyeHo5Rys3MWlmOTg0UjlLOFBNc1I3ZU92?=
 =?utf-8?B?SWtKeEdJcnQycG1aRmk1MnBxV2E2ZEVnbW10V1N6Y3NuckxKS200V0h0U0wv?=
 =?utf-8?B?YnZFRHRHVnR4ZkJVYVRCY1ZTaHRNczJXTWd4NW9KOTFpdE03ZG1XZDlNREFi?=
 =?utf-8?B?NFo1LzZWWGxaWWhzbzFTTkFmbE85R1hKWFFXSTRLZlh1M3pvOGZrdiswaVBv?=
 =?utf-8?B?TTIySEt6K1hERVB3eWg0SFVaNkd3Rm5SSUVHY2xLNUppVWNkM3VEQ1h0eVZl?=
 =?utf-8?B?c2RTZE5BZkRqdkpPTnB6N2tJUlFSMXJ3Y0N0R0s3OWdLNmh0OWVUNWFSamND?=
 =?utf-8?B?Tm5VdHZMRVkxTitaRWQxVnAxTGJlSmVoRVRzbjM4SFM4RHdUTlMwbzlCOUkx?=
 =?utf-8?B?dEpGakFCUTIyRmFvTjc4dHd4UXZodGpIdlhqWUZSWTdmbXJwemNCaTBROE51?=
 =?utf-8?B?YldzNHB5RmdjQjlUYTBDZ2ZwUzRwZVVGS1c5T29xeUNyZ3BTUGpPdWhMUGJz?=
 =?utf-8?B?MVcxdVMrVUVLSnRkNnlIbU5kRFpOYzZiZVNOWjl5WXV5WDJkVCs4aUNDd3Vh?=
 =?utf-8?B?QlZwY3Erdm9vQ1FSQUd5Z1JDWHRrT2Yxdy9CYnM4S2NPRlYwK2xsS0I0bDVI?=
 =?utf-8?B?Yk9EQTVwdjdWSnh3djBqNllWdnd5WWZDNkxBWXdpU21yRjM0ZXBieG5YNDBL?=
 =?utf-8?B?ZHVsQ0xxM2ZPdkxjMGZjdzNORWRQdzhVaHNWSmhIemNFandyQ1N3aERUem52?=
 =?utf-8?B?cUFuNTYwak9ubEk3c1pnV1BKSDdTbkVOcG1WOFBIOWVuVzNQNGpQR0xYRnhE?=
 =?utf-8?B?UFd4dXBSaXJrRkNnS1FudXhyWnhnOFBXS3N2b3YwdnBRME5MN3ZiNWVaQ2cr?=
 =?utf-8?B?TjlmUHY4TnVybkYvT3lPVUZndXVIOE9zQlVwa1VEemRmYUpXeFFrYWgxL25v?=
 =?utf-8?B?alNLMEtUN0d3ZXV6bllyR1BZcVBOYncybkJ3bm00UFdEZWl1TThFMEdtWEtv?=
 =?utf-8?B?Tlp6d0U3QjduZFRMYUJGdGZpdSt6NjZPa3FwVkpmQWthVklKMFlYL3c1emdN?=
 =?utf-8?B?cE1jLzg0bEI1cFhZbHU4WmFGQXVoTUR2d2dyUW9hV3hXNHlYUFVoRkxpSEts?=
 =?utf-8?B?NVNNZDhsSENtNWFMSE90dE5wRkdzNjZKUnIxNm8wN3ZvYTRFOXpTK2lVZG1r?=
 =?utf-8?B?U1FGa1E1UURjZm93RFowOHJ5WjFGZkNvSlljRDYxbGdOcUx5MXA5L0FPYU1E?=
 =?utf-8?B?ckRZRGFMTEY5UGtKSndoczliSzNFaCtGcTEwY3FZZTBQL1FEdzRpN2YrWXIv?=
 =?utf-8?Q?9b9E7OYCpxYRUDzz3MDsiAtUT?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5beba085-7e4f-4853-69ab-08ddb41eb6fa
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 19:30:17.3539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oi4gsgTyc+7kwVbIUkCybpYLTLYhk0bqAtMjk0I2Xw+smgzuR8S5qyaxTk+X+hPeQbKkJ+E57qSDy3IuckF2xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8535
X-Authority-Analysis: v=2.4 cv=UK3dHDfy c=1 sm=1 tr=0 ts=685c4e4b cx=c_pps
 a=5gyuRtdJujVkdqj/J6De9Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=JNVa9dCp4ZnOD5rxRnsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4nJWfYPpGRRzUvgctnw5-d4z6v4uIY3M
X-Proofpoint-ORIG-GUID: 4nJWfYPpGRRzUvgctnw5-d4z6v4uIY3M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0NyBTYWx0ZWRfX2ylO2xZV9gFk
 P0O8/9niZbRDz9QH6SQ6wxSyWXNzvr0vopL4u2KCEWB+sPqESRoRWJP6ZdlWHCtR0pTd2ZDrmtb
 tT9sGCWVdydP4jL7M2XwjmRT9sZ5ANO8w4cVaOdj0NaRlGwTbXarEdoXjzkwNHktrvPTno2KUdo
 pSLtwaajrghc34kkeRRVIXzgqRb6LV+tiuWzLeUrfLNZY2AYsFRIIXPidtt9dFHyXH5CMdGe5iQ
 DtlFu8zZaxTtBcp/ymLqcRasPpLmbTgujY9he+yeiShKjoc8lSw+7kkLOQiwmUl3AKDDjnwvhrG
 F7vyvwNfMCI+xFFhc37ddd9vaSFWBtManSTz1ZLnDG6uO2c5DlklYEeXocZ929GlvqK27+yWpm1
 u8jExq+wsWwFnnL4H6KnJ9+bHLy7Ybku3pT0JhF/vuPDy7iNk0kTinT0Pfd/KuR0od8/Oa2b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The series contains an implementation of a vfio-user client in QEMU.

The vfio-user protocol allows for implementing (PCI) devices in another
userspace process; SPDK is one example, which includes a virtual NVMe
implementation.

The vfio-user framework consists of 3 parts:
 1) The VFIO user protocol specification.
 2) A client - the VFIO device in QEMU that encapsulates VFIO messages
    and sends them to the server.
 3) A server - a remote process that emulates a device.

This patchset implements parts 1 and 2.

It has been tested against libvfio-user test servers as well as SPDK.
A functional test is still being worked on.

A previous version of this series can be found at
https://lore.kernel.org/qemu-devel/20250619133154.264786-1-john.levon@nutanix.com/

Changes since last series:

 - fixed SPDX identifier nits
 - code review changes for error handling

thanks
john

John Levon (18):
  vfio-user: add vfio-user class and container
  vfio-user: connect vfio proxy to remote server
  vfio-user: implement message receive infrastructure
  vfio-user: implement message send infrastructure
  vfio-user: implement VFIO_USER_DEVICE_GET_INFO
  vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO
  vfio-user: implement VFIO_USER_REGION_READ/WRITE
  vfio-user: set up PCI in vfio_user_pci_realize()
  vfio-user: implement VFIO_USER_DEVICE_GET/SET_IRQ*
  vfio-user: forward MSI-X PBA BAR accesses to server
  vfio-user: set up container access to the proxy
  vfio-user: implement VFIO_USER_DEVICE_RESET
  vfio-user: implement VFIO_USER_DMA_MAP/UNMAP
  vfio-user: implement VFIO_USER_DMA_READ/WRITE
  vfio-user: add 'x-msg-timeout' option
  vfio-user: support posted writes
  vfio-user: add coalesced posted writes
  docs: add vfio-user documentation

Thanos Makatos (1):
  vfio-user: introduce vfio-user protocol specification

 MAINTAINERS                           |   11 +-
 docs/interop/index.rst                |    1 +
 docs/interop/vfio-user.rst            | 1520 +++++++++++++++++++++++++
 docs/system/device-emulation.rst      |    1 +
 docs/system/devices/vfio-user.rst     |   26 +
 meson.build                           |    1 +
 hw/vfio-user/container.h              |   23 +
 hw/vfio-user/device.h                 |   24 +
 hw/vfio-user/protocol.h               |  242 ++++
 hw/vfio-user/proxy.h                  |  135 +++
 hw/vfio-user/trace.h                  |    4 +
 hw/vfio/pci.h                         |    1 +
 include/hw/vfio/vfio-container-base.h |    1 +
 include/hw/vfio/vfio-device.h         |    2 +
 hw/vfio-user/container.c              |  370 ++++++
 hw/vfio-user/device.c                 |  441 +++++++
 hw/vfio-user/pci.c                    |  475 ++++++++
 hw/vfio-user/proxy.c                  | 1356 ++++++++++++++++++++++
 hw/Kconfig                            |    1 +
 hw/meson.build                        |    1 +
 hw/vfio-user/Kconfig                  |    7 +
 hw/vfio-user/meson.build              |   11 +
 hw/vfio-user/trace-events             |   20 +
 23 files changed, 4673 insertions(+), 1 deletion(-)
 create mode 100644 docs/interop/vfio-user.rst
 create mode 100644 docs/system/devices/vfio-user.rst
 create mode 100644 hw/vfio-user/container.h
 create mode 100644 hw/vfio-user/device.h
 create mode 100644 hw/vfio-user/protocol.h
 create mode 100644 hw/vfio-user/proxy.h
 create mode 100644 hw/vfio-user/trace.h
 create mode 100644 hw/vfio-user/container.c
 create mode 100644 hw/vfio-user/device.c
 create mode 100644 hw/vfio-user/pci.c
 create mode 100644 hw/vfio-user/proxy.c
 create mode 100644 hw/vfio-user/Kconfig
 create mode 100644 hw/vfio-user/meson.build
 create mode 100644 hw/vfio-user/trace-events

-- 
2.43.0


