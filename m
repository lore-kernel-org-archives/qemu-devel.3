Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E952C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZn26-0007e4-75; Thu, 10 Jul 2025 04:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn20-0007W0-2f
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:28 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZn1s-0003VC-ME
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 04:53:25 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A2vb2T006138;
 Thu, 10 Jul 2025 01:53:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=8SiU0eDlUrnuh
 ACPgkGG8FChMUMFsekOT4T3oyDufHI=; b=ao0XfwqAcxMy1ElS/Zvsvj39qpk0b
 Md2hGd+OrqfSJGyLJ4BRVNWZeRLpkUf7kOWg8GLNwP8TamxEjL7eFEfs6mfg/zqb
 yskLNRt4iqA5ti2A8IfWbFLfA6pynGptu3Lxl9O/wz0NY3WIk/bFrGP79g7rIrPM
 tUFPhQfIgEknVUpY8Ddg70pj2CQDSDY5AzSigZptY4hHTpIzYO7bg0X3pophlT3J
 yRL/1h+g37pR1OcwcD3Muvk4FKyNEbvp9HHVF96J+AjyHF8RtZm7y1Tz6d6e7uoi
 tCSxaU463tkLMkvwG1FVY/jhqSOPWWpVseBKqKW2QBF3nFOuCYQAbL4zA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2133.outbound.protection.outlook.com [40.107.223.133])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47q3m150jj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 01:53:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3ITVFjkdeDufQviTzvn9np32oRV25g8RgTzP9R9ynEQy/7LD7Uno5FyeoiLOtW3CCeDrvPL8IkTTTiwihf4f8t8ixn+Uy1GapzO27MtE05mhQYilR0dHT1/k6HyYZZndYyFxC/Q27yaSiF6BSLpA3mWM3TCMarUAV99sbyB7ukBauqQEpc7Ukw6B2ornTd8WNUAfiM2nAhj9Z07Z9JP22CCxrmyKZKSYarEPxw5UEH2QEHHxEADL2QxjS07a9VONVga0uWnPuINEbuVaso9z4iLU4DaJLqmLX7aOQbLzZ5eHLuZtT4/Y9JVPn6r5JRsMRxmjD5+69zIFJkUv3I5MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SiU0eDlUrnuhACPgkGG8FChMUMFsekOT4T3oyDufHI=;
 b=iJ7/qj2k9ZhCvdrNiKM7Cr2215X0RH93HlGvxY1McbYlYoyCavGlvc81YDJYSNIHJIcHW95tvl610IDdHBKyHwzgPkuXorz8E0H0pEtnVR1JBMd1/s+SzbCz+Facl8gmQIJk63cVrPIWh8kGMD7A5r+iYeRUqVTJwxO1IPeOhe0yhrXScckdpOgOUidSbcq3Cdd6ZOAkpxElN69bof34O99hLIr5NI5BWTXr6X3DR+byGn7WTJHihBbihL1FzBnKdXzj84YhAj0wTYF0uSDN8Oi8w49Ws+PKjf/N2s/6oxRw3Y/P+gFe6wo98fYm4axXwwqvtDPbIznw2MIwS5iwig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SiU0eDlUrnuhACPgkGG8FChMUMFsekOT4T3oyDufHI=;
 b=XGbGkH0FQk+s8WBypw3WFV5fc6DnwP2jpNbcwboazeBMSVVxADeTMasrAmZFK8a8WaqV+5gfhG6PbZwj1ZLPzco11rhEcgtjpspo/iUCszGpK9Wx0esHUVQuwJOjMIgOq+MFK2/aux73W3R6xB5n/1hE/5qNNA33tjZQ+3tkruTU3obrZkRNMvudmILIpRIU3bfe93+/+pxiBBLf6MH/enlzU48i+TnGr+hiCsnMnUJ0Y57bCmcgFNwkDls+1xq77WjokkLlFqcV+Iy+2Hzf3QFNreG1GuLepONdmkZo6PmBFZAdvOWfIdPKQkPMBHLXUWvFUlEmsb5mns6BouJdSQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CYXPR02MB10266.namprd02.prod.outlook.com (2603:10b6:930:e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 08:53:11 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:53:11 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 00/18] hw/i386: separate isapc out from pc_piix
Date: Thu, 10 Jul 2025 09:52:15 +0100
Message-ID: <20250710085308.420774-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P251CA0020.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::25) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CYXPR02MB10266:EE_
X-MS-Office365-Filtering-Correlation-Id: 453d2801-0163-4566-788c-08ddbf8f32bf
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkJBVERTWWpld0FXQjVDbFdCNjN2YisxS0V5RkNmTHRrUVVCUXBsZmRZY0VL?=
 =?utf-8?B?OXU0Q20wT1gySytpaURVdUl5MDZwN25ZRm8xaFgzL2NNN2diaFVWYy8zZWVy?=
 =?utf-8?B?bm5DbThkSmpqdFJuS1ZPSHh1UHptMU5CRVduaFR6K1dqNFdmUGlPYjRJS3NG?=
 =?utf-8?B?OHVuRlFUTmNxUVBacVQ5RjR6N2dvdU1WbW1Oa0lmZld3V0wybWxhWmNtdWc5?=
 =?utf-8?B?N29lT25Yb2k0OExlMGxQbHlXd2RJYmtrbjJ2MVcyWHBDTGRKMWFHQWxNY284?=
 =?utf-8?B?N2JTQXVOSFdmL0RZeGpKeStsRWZna0x6RGhVN3J0eWFOeStzTmsrYUFnbGNY?=
 =?utf-8?B?bU9CVWZyaXFJZ0FtZ0Z1dDhxalNDcXBJMGs2L0M3eHg3c1VOWHVxdjR6MTFL?=
 =?utf-8?B?cGtOOVRoL3dWcDA2clF0SGw0dE9USnU4MnJwNThqb3FFajRtR2diMzFsdjBG?=
 =?utf-8?B?cFdodEdGZmQzYVR5VnJOK3o2SFJuMkFSYzJNMFZEMDF6cVJucFZ6Y0RLS0JT?=
 =?utf-8?B?elZqcFdyOVRCTEt5czVoMWZrc2xWeGx1RXY4MFVrNVl6S1RONGx5ZkxqK1h0?=
 =?utf-8?B?MHUydzNDU0F0UkZvZGwvakgyUFBhWXJPSmFRQmtkRnM0Tnl0YTBVeVBPL0w3?=
 =?utf-8?B?TTA4K29pVTFSM0M5MW5oRnBKYm5BSG13c2RkKzdtV255dU9XUTc3MkFRRUVX?=
 =?utf-8?B?ajYralVtZnFIbktvcVlQMzY4YUZEdk1OWEgyTnJjaGYwTHB3N0xkcVVmc1Vh?=
 =?utf-8?B?aXliYWJLSHB2VlpHL1ZickxNaVJ6N0NOeldibHQ5VUpubjJWcmgxYTBVa2xZ?=
 =?utf-8?B?SUd4dzU0Mi8yNDVzUXdqejZLbU5kY2RjZE9OMXJGRVRsNE5sQmhaM2FMTTdj?=
 =?utf-8?B?Q2dxbTBQdlhoOFVWNklpVmtXWGVyZjBlaXExQ3NOYnUyckluWlV3SzRLai91?=
 =?utf-8?B?U2Y0MWFNR3IwdlZDSEkxTjhwTVRFUHZTZFhXVzE0YW85UENLdnJ4cjYwaUpP?=
 =?utf-8?B?dmJYb3VLY0xTekMreXRVcHlqTXVucFRRcDRoc3NZTE1BckVIOVlSa3dGK2J0?=
 =?utf-8?B?UVJWY2FPS0o0RlRqc2pqekhvdXVLWCtseExHTnRtL0tKblhMNjRKWTNiYTFS?=
 =?utf-8?B?aGI1a3hHaWdzZnhHZXh1czc1MFFXemtHYmtDeWJaOENvUFBHZ0NEQW50ZXlL?=
 =?utf-8?B?ZGw3KzdIN1ViTzNkYnNnQnBEb1gzZ2FUVEhkZ1licWpuallBS1NBc28vTXcz?=
 =?utf-8?B?ZVZnZnJmZHVWcGpIbkxRMFhVVkQxYUJpSVhYbVo3aEducUZwL25kY3pDUGY2?=
 =?utf-8?B?MWNIalUzdUwvUGxMSnpNVG1XdjJMb1F5STFEY3NJNENhZUdxY3hiUndXZDls?=
 =?utf-8?B?RDc5Z2F6TGNsYnQvZ2c1VmNUbVd4eGE4MEJuSDN6K1NUV2tpR1llNXE0enM3?=
 =?utf-8?B?cjVUb2dRZkhvU1BtTUl1QUJCRjlJNWZvcHQ3clM2ZDRjblhCRWZXTWdMZ2dz?=
 =?utf-8?B?M0k1dmwwbytheHBaRC9hQU9JZEdDYmQxayticmExYkxHWWVxTDJOVWtYN0Q2?=
 =?utf-8?B?cWN4Zlo3d3UvcXlBeWRkSHF3WlRtaVc3UEIzMmFseE50WHhkNkp5SlRZNFZ1?=
 =?utf-8?B?MWNua2VkU0xJNTZZYkh6dWFPOHBob0dRZnRqMG9RNXJjcVRxeG9qOFh0UFFi?=
 =?utf-8?B?dzJzUW5lR1NoWVViMzIwTURKOE9ablZURWd4bVFnS1kwMGRib1JZaUswNTYx?=
 =?utf-8?B?RldJWkJPbGxscW5mbEloa1BqREthZDVDaklOczh5Y202VGM2bm91dnBRTkJE?=
 =?utf-8?B?Y0N4OWtoOHkxYklJQ1hhaU9uWTRlZWw3UWZTSzAyeXlrUkZjMGhlNSt5L2xH?=
 =?utf-8?B?V1NVZkNQejNHdDlUQ09kM0JhQlFLUUdUaTlKbnIwUWVXVHQxaG5kaTM5Vnhu?=
 =?utf-8?Q?wGXCf6ba1EU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXZVdEN6R0t2V2FZOVZDNGFhMXhqMkcxVzJ3a0JzNXo2SUpYUituYm5sL0FB?=
 =?utf-8?B?OEV4TFBzREJ5cEZCdTNUMWxGdGEvdmVaUlNnQnF2Q2NSamxrSis1czYyRXgr?=
 =?utf-8?B?aG9qTE9yMk5UNUZjZlRuVjQxQkQwRXU5THFXZi8vSkpsSmlMVWFwL3VUcHlr?=
 =?utf-8?B?YndWYzFhSG1jSXBjTjAxK09nRnN3TTVKaTRINm4yM3NodzhDTzYzbHZEUE02?=
 =?utf-8?B?c1NNZTBZY3ZTMDVYR1NmMk5KZThDTnpYSk5mb05mRDVUaStSdXZmTTdQcUUx?=
 =?utf-8?B?Qy8zdUxQekJxTzlxKzMyMlg5OUlZZjFrU0h0VjJiSWt2MW9xeDNyRTlMTUR4?=
 =?utf-8?B?SWo5b0tidFRtdVFObTBXQWFIT2Q4Y2d3TmtzY3g2MTdTeEhWTnQrRnUwTHoz?=
 =?utf-8?B?WldmYWh1bDd0dHUwK1lBN09FM1ZWb0FSZXNEb0tkYUsreUJ0YnRBS0RpK2l2?=
 =?utf-8?B?Q1Z3ZGFNZG0xdlBLYkJ6dStEblJ3RXFtZE9MVDNZdzQ4dk51eVd6Q3Jsdk1U?=
 =?utf-8?B?RXZRUE8rbEhMSXZKYnB1ZjROcGdZTlE1QVpDMDJmb1lWbTI3TkxlTDRFME5M?=
 =?utf-8?B?eVFSTmNEdEt1MUE0RTRNSHBuVGZVOEF6ZzR6QThpV0JZNUxTdWw2ZlQ5bDVT?=
 =?utf-8?B?UnRZRm1YTTFJWk1RODlJQTB1K1V4TEh5L3V3N0I1aWk5VG5zWjVRTVpFNCt0?=
 =?utf-8?B?TnNsMjB4aVRoYlJVeDc1MFk4MlpNWWREaDg1aWVGa3U3cUdsM2NaOVNQOEhk?=
 =?utf-8?B?ZUlUdzB0QkxwSVBNU2VPOWRzL2FjRU9rdENOTWVmdmZoSlZlbXo1SUdMamhD?=
 =?utf-8?B?dnk4Zm1zTERBejBDem5BdUJoSzVBQUt4a2ZQZmVVcjBnc0tiNUwzK0FGT2dU?=
 =?utf-8?B?ZFdSeHRpMHozOUpRL3gvcjVSVkhyR0kzOXZ1UENwaXUvbnNlbTBSQzNiUFJw?=
 =?utf-8?B?bTA1MEhHMngyS1RqRENjbThTUWI2ZjB6czZpeTQvSmZkaTh0VUVzSTJmNVN3?=
 =?utf-8?B?QTVRT3ZWYlF3TDIxZTg3MWZPVnpUOWo3R3BHWlpVWUJVK3lPL2R0ZUdJSkc5?=
 =?utf-8?B?cHNHeUtuWDJkek1XS21yRVhlNUdtYmJ5N0hLL1phU240eDhHSmVsSGM1c0l0?=
 =?utf-8?B?TjVac2U2VTB1KzU0bzhscGJtUDUraGxxN0FuaitEbGFBeHp1eXh6a0IwQ0ZT?=
 =?utf-8?B?dmhvaTYweStkUzlpbjQzYTBiN2tHZVF3Kzl2Q3VQeWpDUi8vakZYbUhmTFQw?=
 =?utf-8?B?SVBhWjRDSS9hcXA5cER2WmpVZHFKQjd1SVQwVzZIVGEwWVV1RUJxY2pTd0Za?=
 =?utf-8?B?a0FXSFlQRG1RZUVYYVhWTlNwV3d3aWV1Z2t4SENQM2tjL1J2Mm1Cd2ZiUHdO?=
 =?utf-8?B?cE1iY2orZXZGanZBanF0aUhZeGxZMUtlckVDQUZESjBieWZPaDJVNjlYeGp0?=
 =?utf-8?B?cjhWdXVVNGQvbU5WeUVzZWVIWWVVLyt3dHdjbUlkZFg0QVIydWowQXU1M0Fy?=
 =?utf-8?B?eGJ6SU5WNzVsb2xrUUYzd29BSm5wenpqYjYrS2RVUVpjc2FaQndLM2pqVUdk?=
 =?utf-8?B?OWwzZnNRK1A1MDlZdEVqU0p6NUxVdWl6TkNLd0VBM1RzZC9idS9ycVlNQWlv?=
 =?utf-8?B?bzBFSDBSdUhtdlZCMmI1RzZyR1d0TVk1WTdoOEZNS2hXMjJkTUc5M0pVYXQ5?=
 =?utf-8?B?QUtqZlI1SEl3ZjYxb05sQ0xZQVhPTWVoN3JpTksvYzRSU05vdmdxTXZYd3ZT?=
 =?utf-8?B?TWhOc01KWGlqKzhzc1dPc2RhYzk0UjdQVFZWYUNIemhmeTdtSlI2aW5SeFc3?=
 =?utf-8?B?aVhRMmtZREcxdEZrTFF5ejBKdjZPRHZkQUgyUTUzc3NZODl6NXNRWTRFWUg2?=
 =?utf-8?B?bVQ0SmN6Z0NlMHUwQi91LzdLYy9WRSsrVFRNTWwwUTNZWWlxSUdhQnpJSFY2?=
 =?utf-8?B?Ny81RXdTYkVtWEVhQ0xXL2lCZmp3T2hIa2dlUThsN0swRzlWR0tzbi9JNlVO?=
 =?utf-8?B?Uzd2c21xWXZYMDlvd0hwalJkR2lEY0g5RWtHZlY2Tlp3UzFKU0tqUUxQK1B6?=
 =?utf-8?B?YU5UR01LMElSNDErU2lJUXgyK2tpVXN4WkJ4MHBMelBKd3ZkWkpkZ0pHMWM4?=
 =?utf-8?B?MXl6U2NSelhMK2E4MGliQkpiekJVQ1dJZjlnNSs4Mk1RNzI1Q0h6TGJoK0pM?=
 =?utf-8?B?UEYrWWJDaGt1YTFBamVIQmRzMU8rZlMwWUJmWElTUG01aTE2SmJaS3dxbW8y?=
 =?utf-8?B?d1FhU2hkRWoyckFYVFF1aVhaU0l3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453d2801-0163-4566-788c-08ddbf8f32bf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:53:10.9822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/aA+euqiMEfS6K6tTj8QkW8WPp0m3blhx8dS3zt7CHf1LjauC0YTqCmaijcl93Wywwm3sMcT9FolTJQL7Jqi4aZLVIFAXSyUAOJMr1Di2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR02MB10266
X-Authority-Analysis: v=2.4 cv=Nffm13D4 c=1 sm=1 tr=0 ts=686f7f79 cx=c_pps
 a=80ol81Y8LmzNtep4GdLCmg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=mDV3o1hIAAAA:8 a=64Cc0HZtAAAA:8 a=HUHtNuVqNzIun27e13kA:9 a=QEXdDO2ut3YA:10
 a=Y4I1g1QRc_YA:10
X-Proofpoint-GUID: AQqR7qPD1H2b0nV1DhsZChrO1wxk0ufF
X-Proofpoint-ORIG-GUID: AQqR7qPD1H2b0nV1DhsZChrO1wxk0ufF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA3NSBTYWx0ZWRfX3qY6NxaGMC+6
 iSjzQkxKjQMtUxjuxBi0JWd249RqXrotDfgdfiGX87TN9/jXBwY/AecgLLxKK6mBUF7UWm+WIQh
 dJl4AUNAldLEv9wp7aZT8hWnF6+k9dh+morI1l0DZgQodTblYJltK501ENlowW9TLAvLPIr6Mwk
 aUDoncP61WS2FdIYL64LLQgsjZMqHURKRZisfiFNDrpse+2EpxjwoQmb9nS2xtyUY9vZDTrQ2IW
 wn9V0hATmbj8WMJniRopVmC9qS6y+EVsq5NXMzn3I7Z20d+a05q2r6jMmmR5Q9hr988mr6Sc/H/
 QpdfnH1igC2vOiiPrLwzBxFFAj68ExbCyMVZgsY6mN7IRGVNOPSL6DQ1VEUnb/nL/YzFcvPwptI
 ZtvjY43+IQKdrZ6cQ4Z8E8BlRiKwsQI43c6g1rV/CdAH6TeKoQ9v7QbiD1dxW6G/iylACb+p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

For various historical reasons the initialisation of the isapc machine is closely
intertwined with the initialisation of the pc machine, which is preventing some
future improvements to the pc machine initialisation logic.

Since the consensus [1] was that the isapc is still useful for testing and running
older OSs, this series splits the isapc machine and its main initialisation
routine pc_init_isa() into a separate isapc.c file to reduce the maintenance
burden on pc machine developers.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

[1] https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg06137.html

(Patches still needing review: 1-2, 6, 8, 10, 14, 16-18)

v4:
- Rebase onto master
- Add patch 2 to remove unused loader.h header as suggested by Bernhard
- Add patches 16-18 to tidy up the pc_piix headers and the pc_piix/isapc
  rom_memory variable after the isapc split also suggested by Bernhard

v3:
- Rebase onto master
- Add patch 1 to restrict isapc machine to 32-bit x86 CPUs as suggested by
  Philippe
- Include logic in patch 1 to handle the case if an isapc machine is
  launched with -cpu max as suggested by Daniel
- Add patch 13 to tidy-up pc_init1() for the i440fx-pc machine in the same
  way as patch 11 does for the isapc machine as suggested by Bernhard

v2:
- Rebase onto master to account for the fix in commit 0b006153b7
  ("hw/i386/pc_piix: Fix RTC ISA IRQ wiring of isapc machine")
- Replace verbatim MIT licence text with SPDX identifier as discussed
  with Daniel


Mark Cave-Ayland (18):
  hw/i386/pc_piix.c: restrict isapc machine to 32-bit CPUs
  hw/i386/pc_piix.c: remove include for loader.h
  hw/i386/pc_piix.c: duplicate pc_init1() into pc_isa_init()
  hw/i386/pc_piix.c: remove pcmc->pci_enabled dependent initialisation
    from pc_init_isa()
  hw/i386/pc_piix.c: remove SMI and piix4_pm initialisation from
    pc_init_isa()
  hw/i386/pc_piix.c: remove SGX initialisation from pc_init_isa()
  hw/i386/pc_piix.c: remove nvdimm initialisation from pc_init_isa()
  hw/i386/pc_piix.c: simplify RAM size logic in pc_init_isa()
  hw/i386/pc_piix.c: hardcode hole64_size to 0 in pc_init_isa()
  hw/i386/pc_piix.c: remove pc_system_flash_cleanup_unused() from
    pc_init_isa()
  hw/i386/pc_piix.c: always initialise ISA IDE drives in pc_init_isa()
  hw/i386/pc_piix.c: assume pcmc->pci_enabled is always false in
    pc_init_isa()
  hw/i386/pc_piix.c: hardcode pcms->pci_bus to NULL in pc_init_isa()
  hw/i386/pc_piix.c: assume pcmc->pci_enabled is always true in
    pc_init1()
  hw/i386: move isapc machine to separate isapc.c file
  hw/i386/pc_piix.c: remove unused headers after isapc machine split
  hw/i386/pc_piix.c: replace rom_memory with pci_memory
  hw/i386/isapc.c: replace rom_memory with system_memory

 hw/i386/Kconfig     |   3 -
 hw/i386/isapc.c     | 167 +++++++++++++++++++++++++++++++
 hw/i386/meson.build |   1 +
 hw/i386/pc_piix.c   | 237 ++++++++++++++------------------------------
 4 files changed, 244 insertions(+), 164 deletions(-)
 create mode 100644 hw/i386/isapc.c

-- 
2.43.0


