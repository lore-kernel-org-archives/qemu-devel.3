Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE41CA0FF2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraXr-0008VD-NQ; Thu, 28 Aug 2025 07:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXo-0008Ng-JT
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:53 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXm-0005QF-TO
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:52 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57S9SlST1760097; Thu, 28 Aug 2025 04:11:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Zm1F9op89tc4d4oP/vmKD+56ikoXGlSHJGplnTa7z
 yk=; b=TrI/JQjQSvs5jpp+FCjkHSWkE59O1rnF+xiCrWxELph9nxzynmwcCS8op
 Snc2NtyC/UkyKiui80VVhHQzpxQVlaAYgUZHj5Ryg1cF2V3WKYHw0JwGbn1xxfgO
 ixMAq3xMu9G8j2FPJ3wnPyHatPs/kgrEDZOxF0mrwazyoyPAdFokJS5X94fltJTR
 hXCUH7EermiqpAl/MhUG6/58jrt5uG7eLpyoEbj+eCW3vNrrkQU4h1U9UIU13DHA
 b98MBwvw3vAjoCWnR+ek7W05BxWXALr5OuVSSMof1rU1HD5IDE+Y65oZbU9736lU
 HhxBcFa0n1okkXfQTvXi17cXpQcaA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022092.outbound.protection.outlook.com [52.101.43.92])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48t00vjx2t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 04:11:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3vvIxTa6/G5jMlFmxScWFwE8ZvQ9I5j47uOX+MJ7ITw+PSS2vy+v2A/iwaOp0YvCmfT7LQBxewpak3qlbBe3rVYqdqUGPLvmNlrwXBmcW3V24/yoxgvgBoBwIiCeryUSyyMM0gKxrPaTcrUmIHam6RBfAT418W0WhMxxV9Gxd1y3COLOlXJxW/0+sctqokdTxASfkLlByobLA3VbiaWO6QG/VbBtvtMU3VWPJwXrMcn/Xvz9kAxreF78X+6wCEmRnJ02f6fNM+XAwghi8V1Q7bjgVpwG9YBUg6WufgynJPMIwUWjS6wExgSrTUTZgf2AgCnfep74AWSZnFVIzoPcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zm1F9op89tc4d4oP/vmKD+56ikoXGlSHJGplnTa7zyk=;
 b=NlveT6CyUvdRGoeYw7cIflgBPvmPnVcwLwG3PECkn+jBVbhaHMvImQHLHbEnFfAxYi6urYl9W6LXZ1rjvCvh33aS7v9HrmjWzZBbxdqu88j+ENS/gsqHmRPHECVRd0nllTPqkVEpN7UeBdnCTRVeAgQZihzbjWpg6HAlXoj5lUXxGtjZOE7ERPZ4CLiDufzOQsjTBmAcnlyvbUtE/ZRThU1jGkyw+NtxRfrtwtOrdyX48VuOzDTNFcQM1rNQhUGMizVX7EtuTw1H98zmZ34zbUBhK2GDhh+wQv9AG6eo3hsanQajHLuEjX85L28Y0tOTQhchWiV/H6g50aRhg2gZew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zm1F9op89tc4d4oP/vmKD+56ikoXGlSHJGplnTa7zyk=;
 b=s/zBxXIdC3lVGhD/4Sp5iZTRfakQkkgcQSPRPBSSx/u5MLpPlKT8eDVsBXPk5JiDDNy442tji9QvnDzfke3TPkIA9ezLtavWlByRRk2M8kAEOA8lC7DnBHpjPLMJm38zSwMDjqbrOfiaC9Dl2dClWXVdQ+Th9qW7dInwclJwMRvkwwId0fpKMXxaVnRLyNWiwsmwK+tMAcgzBpnJ18f/ZIcrs/IfM+CJdt96CuJnVCsClehrqCRZyt3/2ulFLGkiR3C+xuk+2IExHH9gHl70XDUKtwf2YZ4TccQGyK+A484sgR6zHD/fJgiE4ezQA7Vf5FU7y1RpPXWqNMpctqQZDg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8077.namprd02.prod.outlook.com (2603:10b6:408:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.23; Thu, 28 Aug
 2025 11:11:43 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:11:43 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7 13/19] hw/i386/pc_piix.c: remove
 pc_system_flash_cleanup_unused() from pc_init_isa()
Date: Thu, 28 Aug 2025 12:09:56 +0100
Message-ID: <20250828111057.468712-14-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828111057.468712-1-mark.caveayland@nutanix.com>
References: <20250828111057.468712-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::36) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 317bc7e9-ae29-47ec-5635-08dde623ab81
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXlPbTRpQ2VIWG10QnBLZmRpVmxFVVFEL2ZEdVV3UE1qbEhveHpvYTI1U1d3?=
 =?utf-8?B?eDgzd25iMGE5M3NEd3hBVVRUWHMrR3hWMmhTdzEzMHNLSTg0QndtWWpudjRr?=
 =?utf-8?B?MXhsekk0TU5xaVd4VXd3TXFyTWxTdzBRemNkT3FkQTdQOFNuYlh6UjdNRUtU?=
 =?utf-8?B?S1FHZm5UODB0RHZTNmN4OFkwU0FDZnpzWVZiT3psR3o5eTRGSzNyUkc5OVlX?=
 =?utf-8?B?ODhBMS9TbkRBcnY0K0MzU3FOMjV2VmVJNnlhVUlhL010VnpRSkp4ZmxHWURC?=
 =?utf-8?B?bU1PMC9mRkhiRDdQajBJN291ejJXVnd6VDk4Zk92UlMzSU9UYWo3c0l3citm?=
 =?utf-8?B?U0NrVHcrajV6MUVFS1RJUmVXMFZmclRja2JTdTc0clArWTcwajVXOGpYdkl3?=
 =?utf-8?B?emY2N3ZobTlPL3FseTl5YjNqL1BUcnBHYzdRc3VXZ2RKL3JGcjUzc0xGY0t0?=
 =?utf-8?B?dFUxRHF1SlhhYnh5V2h2UzEydWwvRlNZWkszM0RQTC9BY1V3RFZlRFZpeDJL?=
 =?utf-8?B?MnBma2hPb3dFVXVMdUZDcHpDamtLRGdpbDZ3eVo3N1pVbkF0Yk5PdVlLc21V?=
 =?utf-8?B?TzVQY3JLS3Y0MkpySDArWkx5dGtXNmtpTGwzcTJMOGM3N0hvN3Q5RTk4Nno4?=
 =?utf-8?B?QTlyZW16RWZubTZOZCtZdjVRcWgyVFgwZXI4YmIwMkZhVXIwR3dqa1NxSC9q?=
 =?utf-8?B?bTRpaEI5YjlrMTVKVmNhNVh5YXN4ZXE4T2xyS2FsbGxXNWt2Y3hueE5Fdk94?=
 =?utf-8?B?N0wya1R4WXlvR3VJeFM1Nzg0clRsa3pDR3dVUXpEWXFrMFVHTlpyYU5KUDc5?=
 =?utf-8?B?bWxPMS9vY0ZORWZQODRBRG9kMk9mVkVqRnFtRmx4VENMZUdLS2xjazNtVWg1?=
 =?utf-8?B?YnBmRXZBYVEyeC9hemFjanlaUGwyMDBQZWRLTUZGdi9MZnN4TFdxRlB2dHF2?=
 =?utf-8?B?WUk0MU1mNmRLUUR2d1BBcTRmTFZvYXFpRFhzME5iRXpNaUZwSlhzNzM3S1VQ?=
 =?utf-8?B?UVF1eEJIaWF2WFRGVkhuVWR1dGVSNjdjQXhmZ2w2ZkUwTExEMnFBemlxTk5i?=
 =?utf-8?B?TURNcTNCRVFtcWJxbGlRUGQvREJtMDBGcEI0aDZoQ3Ivbmo5a2ljNTk2SjNw?=
 =?utf-8?B?ZTl1cUxhbysyWjhja3dUYW5QdkIwWXBxZE9CeURwQm5ZS2tvWG12alJYbEMx?=
 =?utf-8?B?enU1dnBzT3dWaDduamYvQXNwc1l6MGlDL3Uybys1TDdiZ0VKcSt0eFFWOFIr?=
 =?utf-8?B?VkhOOGZJbFh1ZjVESTlvdW81LytwNktReVZKcGhtMGRha1BTUFc4RTB4R3NB?=
 =?utf-8?B?L3RNL1lqc2RYR3lDKzJpcjhZODE3SmhzZmovVmV2dWlHeWJ4Nmx5eEt1V09s?=
 =?utf-8?B?TlhBUzJTbytGYkJOZ25RWjRkOFBFa3pqd01BTFNoaFB3SitCekRnazlCZVJJ?=
 =?utf-8?B?c0VsSnA4VXNWUlQvazB2TFR1WUdFUkpQS24rbGJab0drT1YyN0lJWDdnZ2F2?=
 =?utf-8?B?MExjMWF5TW1SekhBWWhOaTQ1dG5pTDM4SmMxemdQakx5VGFneDdNbHVmQ2NS?=
 =?utf-8?B?WG5pQWVGQjlOMS9VNis1Vk82ZEpoN0Via3V0dFRsaWxBbDJUNmd0SW16azBY?=
 =?utf-8?B?YVJmZGMwNE5DUG1JcjlLQjNiQTNhc2trZjRlRGI0RXJQbDlnRVhYdTdlTS9O?=
 =?utf-8?B?VC9MMjRTcnl0dU1NOGpSK29LWGJ3U3NWbFd6eXRWSklEbXB6Z09PUzFycXZT?=
 =?utf-8?B?WldDenREaXZ2RGtmSnpQVk9LclJ6dFAweWx5N1VodWRMSmFZNkRBak5IM0JC?=
 =?utf-8?B?MTUzdk0vQ05JSTNaYVVhekQzZkl5ZDA5RHloSmh1WmhhZVFlT2FsNXNwa3Bt?=
 =?utf-8?B?RTU3WlRjVHZlbWJoaVJVUzBmMWtDRzRUOGN1R0xJUW9FTC9pSEpleFAzZlpa?=
 =?utf-8?Q?cY5+KpGQDP0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlNvQXE4cnByMkZsMWRiM0N4bmcvOTVEUCtpd0xLV1JlU2JzeFZqWTZjZHZl?=
 =?utf-8?B?YS9kRHEza2xQT0VwWmJjWW5taTdNazdNSnF2NG03NnhZNDFNaW5TVmVObGhR?=
 =?utf-8?B?cWpUazhKUzRIWFMxSCsrQmxwYXdPNi81b2xiT3dTUW5Mdm5CQkhMQXpVOVRr?=
 =?utf-8?B?cE1HcW8xUHJPdnhpK045TE1WWDdPb1NWbk5KRmRlMEJhamJHV2hObEpoaDVH?=
 =?utf-8?B?NTR6bXFrT0FuMDdkZzZ3cnN6YnJjeFg5T1hPK0NjSGhUQ2xMeDB3OTFielVR?=
 =?utf-8?B?V0ZKL09LbnpaVzQwcmFWZVIwZHZBUnI3S1RXNkhOTlhEOFcvaWptUktXV3E5?=
 =?utf-8?B?QVRoZGZjNFV0RnkrK052RzVXa1NUZ01zalFJQXJwR2V6RG5vVjZOb01BaGtr?=
 =?utf-8?B?MWprb05YRXVmOHY5Z05iYnF2dUZGdnEwOFZNbWk2UHdYTHhTYUZ0MHN4QXpi?=
 =?utf-8?B?cmxsYlRvSTR5Z2xqRGJubDJPN3E1Q1haU29kaFFIYUZkWDRSVitUa21pMWhN?=
 =?utf-8?B?ZWxKMEVuZTdQRGNqN0h3QnRIdlRiT1djMW1HdGhXN0Y2ZjN1T0RCL2E4M0Mz?=
 =?utf-8?B?ZXcyellDaGJLN2JMMWcrYkZRTEZ6MGczZGE2bnRRaDBlOFdadkhER3JJNXZU?=
 =?utf-8?B?cEE4bUk1MUJRdGNxV2w1cFZieW4xUVgrcC85dHFpc0F1ejYvaGpVdW1tVyt0?=
 =?utf-8?B?cVBHNUNpSlVBL1JGMERQUjRTZVVxSFNaV1ozc1hsODloT3dTYTUxTERZY3Ro?=
 =?utf-8?B?TDZsMTdJcVZVNm5YdWZNNmtPelpQclBGSGFTa3hQekFPOFlJK1laNlcxZW5O?=
 =?utf-8?B?eC85bkZTeFM0OXVuMkZKOWRna2ZibmlqWTl6TkhvKys5SENkSVhLMjBsbk1m?=
 =?utf-8?B?VnhmcExMTG14YzZjdmlDUU1WNVJMVmxBNzZYSWVWUFJQb3FUOW1ZVzlQM1Q4?=
 =?utf-8?B?eXRCaVhFZW5xR0M5SFNnV3J4Q0pKak5YajdST21hay8ydzhmdEszdVJGVDBP?=
 =?utf-8?B?bHJMUUxZU3Z2LzdZKzIrYkZnelNaMVgyVTYxbzlOQ1FVTTNocEtpNGhTVWxZ?=
 =?utf-8?B?Z01YOFB4WW8xdHpFUjBFaHp5RlJtQ3k4dmZRNDQvTmZEZFNzU1hUaXcrUTF4?=
 =?utf-8?B?d3A0N05SallSSjVoU2JRNWJMS2NOaVM0QjIzR2d5RzllTTB6dWdqM2J4dWov?=
 =?utf-8?B?ZzY1SmEwUEo5WmliazlQSTRTSzltL05uZ0daTzBGN1dOQXhUTXM4UTFkVDh4?=
 =?utf-8?B?S0FmN1c2UmVLck1NVGZrZHVzN20wRmZ6QTNlVWpVTEsvOHVGVnVjMW1FSVNI?=
 =?utf-8?B?RDNQSnlLaEJGNWpuVk9PdlI5NmttVGwxNHJ3cHBtRlVSbEFzTlBuNCtHcU9Y?=
 =?utf-8?B?OER5T2wwRStjcytLUmR5dVJIbzR0S0pWRnhURXJjVmtBdWdzNm11NnJkVWdr?=
 =?utf-8?B?SDJhbnJGVU42Qndna1I0QUZQejJ5QSsvNHFIYXNzdE5MZFAvTTQzeUxxVjhV?=
 =?utf-8?B?d3NEazU2MnkzNzlsM01uUHV0Y0dyR1oyMDVsc1FOTC9vZFRkek5LM3JaY0Q0?=
 =?utf-8?B?NlNIV1k1NklGeXVKN3FlZjQ0bHZCeWhsSGNpYVBmNzFCY1pMUXhQa1p5aWpP?=
 =?utf-8?B?dGQ4MjZoc3EvMTBTZmlMZ3hnaVUzL1VqYzU5Rjd0UkZtSmJ0dm5VVWdhVjNi?=
 =?utf-8?B?UDQzMzJJb3o3SzNtZ1FNT3FVRDA1RXE4SVc1Y0FBUnVqZTkzSE5hS202TUdY?=
 =?utf-8?B?K0lvbWFuU3V5NXArUVFBUEtEeFZpbXluai9OUWZrNFFpczFVdjUxYzYwNnhj?=
 =?utf-8?B?ZXJuMzRyZjZnMDd5KzQvMWFDWTZQM2xYcERHWXQvN0wyc2YxTWlBblhCdStl?=
 =?utf-8?B?MFVObDVZaWlnM3BaeG4zUjQrYVBtc1RsbXMvY2I5cjBQWTJsRENhY0lsd1FL?=
 =?utf-8?B?TENkcGRlS05md3pqc1RjQjV2TklOZXJORm9KNnRINWVDeVByYWNPS2IwMnZv?=
 =?utf-8?B?dHd6WTVCOXZFdzlXMS9GTVRDMDQ5ZmVySTI3eWp5ejJMb1JZRWI3UUFmbklY?=
 =?utf-8?B?UktXQ3JwdllJTERKS2NFT1RFQjJxUGIrdGZRSFV6UXhRQklGVmI2M3QxcktP?=
 =?utf-8?B?aHJLTmhaUTJRWEkvVVVrYWdoOXpyaitaa3dDZ3UrR2s0UStyNDlPNlhIOFY3?=
 =?utf-8?B?VW5aVXFFdzVNYm9VN3VuRnZhVE9xbnZKZGtHaFBxcUZONTZHZ3ZGME5ubUpw?=
 =?utf-8?B?UDdpRHVwQ3YwY2I0MnFWZzRlK2x3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317bc7e9-ae29-47ec-5635-08dde623ab81
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:11:43.2849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0e3+7lMrZlo68g31BnExlB0YcAoGafddY3ggOCuqKbm91zNPhbwOhDFG+NK4t2pSwMISSmRStQHlpU9Z3NPoMHIbOeCtCJQTZ4iZeEN0ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8077
X-Proofpoint-ORIG-GUID: sZ_ojRBU2rMJLkGtKllGLmWvVoo-dXpZ
X-Proofpoint-GUID: sZ_ojRBU2rMJLkGtKllGLmWvVoo-dXpZ
X-Authority-Analysis: v=2.4 cv=C9vpyRP+ c=1 sm=1 tr=0 ts=68b03975 cx=c_pps
 a=VT9wVgPwsxARPCPuKYV0eQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=_jvWDQGc8cL8bECqUo4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5MyBTYWx0ZWRfX+bZm6lxMW5r8
 tlzb3l1qHllqluTLsoK8wWdb1JbRbt9FM9WbkEMV/p3VmCCsFPbUZ27jzRAD5NzstsaCsmCwSvw
 sj6cLMSVdKAAnp1UhtG3VqDxa+ZYL+jKaQ86GN+t+Wbh01rncllg/v6AapZt8i6HdMRMJDDAUSp
 nDIRaLjRX8mMgwZK0SLVDEy8YEJqdZOiPdwPTkKy86KsTePjNnNinpeLXSZpGXIiU45fmJcDhJF
 yts0eklnBzEz+ZMLVzODpQ9qT0eyaBaUcqYHy6Iws7eMcGpO2EPAB1Vn1YKtF7rU4xaayWfjqxG
 kFH14WtzfhCNtArO3J0V6pGi1jHMqDwFdEM5wZnLVCLYqFLcONgkJaA0+eU4cA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This function contains 'assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled)' and so we can
safely assume that it should never be used for the isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 66dc4a5186..fb936748bd 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -503,7 +503,6 @@ static void pc_init_isa(MachineState *machine)
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
 
-        pc_system_flash_cleanup_unused(pcms);
         if (machine->kernel_filename != NULL) {
             /* For xen HVM direct kernel boot, load linux here */
             xen_load_linux(pcms);
-- 
2.43.0


