Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9F7C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAXS-0006gU-VO; Fri, 11 Jul 2025 05:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAXA-0006Lr-6w
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:59:12 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAX8-0004uQ-5r
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:59:11 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B7U4qn016883;
 Fri, 11 Jul 2025 02:59:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Gc9uDzoGYC3VSV7gw+vOn+Dzi5l/V/ZfVf35082tL
 LI=; b=L+XZMz0DCtKSZuY8mMhTc88y72xwNHZiQVGA8WYra+ZYhTwq0mLd+HTEF
 oDm6qkAxRTr2yux4MjhcphNT0IFgrif6xB7J0bmuefhY6Me0lR8K7AB+lTUDKK7P
 HS7Sd0D1fs5NcaXv92CZfRDlwpcHFv2MkZ+yxFM3XGwFSctb0MGAm4wc3tIcqcvr
 dYBvmNDQl33HE0hLXBHNticNvMReT+q+5gu6TUPgQboP68YMFG8QUTrnZuphUZQr
 f0MvwjJh7SapZJu9DDbASeazvsTjkT7Vc90FDy7P25FwelLlZubS7GtWJuP+RiTP
 iDFH/ah31Ceh2nqzUwuayZCVHd5qQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2135.outbound.protection.outlook.com [40.107.220.135])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47ta49k6ee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 02:59:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBAZTfmoDPUekQ91TIeiUQbBqeGMZnnmp7/1cn2qqD+lOQqf8KvBZv+cICPsX2GXuFmPAqRB78+9IKZNmud6WtoiOoQmlcy56xKoQIHzNIQQ1DQY3Jvw6H3qT6AsWbiksXx9wtUtP+SxfGnoUKrp0blcijUIO9Sp3ANXLOq/1vDWUTwFOUHpn9Lhxt+/skeuhrSqq21UQk7w+Nr8vYsatWoNJERWJ8eQT08BQR6xQ/+jm9ZuDSZdNIgU1yIEMn52RJAsrGkWJHnUfm0ied6rN6FPkBTXGwQM6M96Rw+sdT5pR6Z+A5Mesrt0O+19SM9znV8eb8fzCZkUtLc+voCAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gc9uDzoGYC3VSV7gw+vOn+Dzi5l/V/ZfVf35082tLLI=;
 b=aIISmP3ZS1WJeGU7qJRtDdg6+E1i/CaCOePWLywTes9dC7IxDEZ47O0SVI2y99Gw79DGz9qmMGoxVzKm0QqQ8326071OojrXZ9kXWjZPWr8kyCTvSCcn71f3H6DnJ5Zo59AeYviPZusFaysZEAGgK7gnTX12rz60eHesCeICX9CciKHr/ika9puYi3/iCBI+cHVGICfjbGbvf3+5oH3vTuiuh9WWPFpZ138YO2f/AeG08Uq+LQVs5hxYLjK6u98ttu9B6NdtFADANNns/Ru7hEERttsHNzoFmRi8iGczX3hmwSQorfQ9E7SR0FOHay4/ZIoqZTtGIOFnNBoix2bcsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc9uDzoGYC3VSV7gw+vOn+Dzi5l/V/ZfVf35082tLLI=;
 b=V6MyUvQZnvbMuGZithQUzSxAbekTEH/Lx2QEv4+/Cpp+CZ5YwMUiqUCoVx1MnkLi+nTnyQs21UNfwphY+iPlOcUzLoSgAPYpCAkZF1SYdZJPXZhDcBxG3etNUgsxC3OT1Cyx02S+xd9E3F8D91Jq0ZCNUIEjQhP9d0mTPkRqpWKrN91p7LvNK1W9lD8r7guAO7d3QOGnZTxN4AQScRexnMv9rKRFvw+UNZfHbSehE4Rxu2FiUHUn1LfULOwmwjYL/uSqsao0bqUnqTFySuuUX4m+MDsUZOMWEOy0YOS8qON97YGIgm3hf3jdAyN8ZaU82ayemWoV6p+lF3FEwKA09g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB7918.namprd02.prod.outlook.com (2603:10b6:408:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 09:59:06 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 09:59:05 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 14/19] hw/i386/pc_piix.c: hardcode pcms->pci_bus to NULL in
 pc_init_isa()
Date: Fri, 11 Jul 2025 10:57:16 +0100
Message-ID: <20250711095812.543857-15-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711095812.543857-1-mark.caveayland@nutanix.com>
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0039.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 7755bcc0-486b-4d40-1009-08ddc06191fa
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2hZZnNTd0s2amFuQ2hjcXg5cGlhUndSSm1ncjBWNy9sRXBaNmJXZ1RyN2Vm?=
 =?utf-8?B?U3hmdFAzZ2Zad0xHbDZzNnpTZ0JhOWFpWFYwWjFuZUgzOHgySnVqcVQwL1RV?=
 =?utf-8?B?eDJXcHE2cFNHYnBtZjRaM2FHRXQ1ZTFnRG5aUCtkSExBL0ZiSmZJckxyVkVX?=
 =?utf-8?B?TEsxYmVvQUJVeVJmZUxjK1p5NTVidDd4RW1GaHpwNk9ocGlGVy8vYmJxSUtw?=
 =?utf-8?B?WG5vY1phZE5MSWlWYnVpdFBNUUk5b3VwV3MrbFBIUGNkdG1aSVd4RHBoVlg3?=
 =?utf-8?B?My8xTFc3dUpvbmZDQ0puSEdRODY4TVZHTE5sdG81WmdIWkk0K09EcjM1WS9a?=
 =?utf-8?B?bGM3N2VLUnhPU2lRME5Hd2h3L1RCRHVLbjB5L0tKcm1tUVRlRTVMbGQ2aHRD?=
 =?utf-8?B?eksrSTYxSVZXczIvc2Y2b29ab3BqV1RMRndiRW0xbUY3OVBMVHZ2MjdwSFA3?=
 =?utf-8?B?VWtLS2RHYWZWejlPSCsvWUFjcnRncXRDS3dkMnl2c1dGRTRUNmJTOGlvNUFE?=
 =?utf-8?B?L3M1bDRSWGdYQXlDOVZUdXFJSGNsNFBrazkrMXRNcGtNUlpSQTZ5NEVrZ1dL?=
 =?utf-8?B?alZZMlF6cjlRSUNab3E3L3ZzUVNjeWdwSGFwcnlJWXNTWkR0MVpFT3RYS2t2?=
 =?utf-8?B?RkRDT3lvdXpZSXVyVmllSUdvM0JKWG5ZL0N0Y20wUUZFblFkM3ZUS2JtQy9v?=
 =?utf-8?B?bHhxR2QxWjIzcTNVdE5NaEVucGd3Z0tPMzQ5emk5QjRtVUJSMlpLb0x0ODBL?=
 =?utf-8?B?bWFlNW01WXpIOXMzZ3NlbDBPRDNDbk92azNVRGpZL2Y3UHR3KzB6WnRwZXdV?=
 =?utf-8?B?NkpJQWxZbmQ4UkpYNS9TWmxXQTM1eUR3bStmWWJ2Uk56UE5MN2hzaHZ6T1gw?=
 =?utf-8?B?V2ppL1B5bUkvYUlFUHZTV1M0R3c4ZDh4cXIvZE0wT0hyR016ZzMzY3JMckVp?=
 =?utf-8?B?RzZrZmpNcENtYjJjNXhUN3ZTTzBHQUp3QjJXTHgyWWZoZ3M4czdKRTlSYzFr?=
 =?utf-8?B?a3d1elJNcG5EdWU3ZUlNU2tBZzBEZHZuUmR1M1g0ZHZ0NW1XampVa3A3ei94?=
 =?utf-8?B?SXBQYkRYZ1dwMXQySzI2Z3M5aGpnS2hoVkxBNlIwdEJCenNvRUMrbmdyNjNU?=
 =?utf-8?B?UHJOZUVuMDQ4UkMyYnF4ZjljazhNSzAzZy9xV2R2Z3RKNDh3VDFHd0VCeUJE?=
 =?utf-8?B?bXMvMTB4cXJ0WHVRU3E2WGVXdkRKOG5WbllLenpyOThtbXVIYnBEd0RXNnRE?=
 =?utf-8?B?Y1NVY3hmTzMvczgzSFdaekJGTVdGQXVkdTB2SFBXRHdpN29OdTlkNXNEdnh3?=
 =?utf-8?B?RG1FTllHcm80Y2pHdmsxNUV3ZGZsbDBsd3I5LzROTUpJb0VHejllR0c1M0xm?=
 =?utf-8?B?cEhCNHNBTHNjUzcwcmdOMS9JY3U3aEswVzlXbGRmOHpvZnJ5WlB4QjVMZzVW?=
 =?utf-8?B?MDRmZ043TTloVWx1cVFjWmtkWnIzSmFjQ2YrazM3eDNZdisrM2VsQ1lrSTN1?=
 =?utf-8?B?NnhvSCtEbUZQZW1CYklGbXJCTC9VT0VSZytBeHNOZ1lJV1JRdXFMbUlHdlQ2?=
 =?utf-8?B?dGpEM0tOWWtvcVJINVNBL1dwaTlPME50NGRYUDVZenBpdVhpVExQdHNtVEJB?=
 =?utf-8?B?TTVodjNRNUR0Z2M5cE5aM1RJNHQ2d1N5bURLakNrZmlxZ0FzOEsreFdlc3V5?=
 =?utf-8?B?cVAwM1FUOHhJd0h6NW9JelB4K01TLzV0YlJZR3locm8ra2hFZC9KQ2JUWkZV?=
 =?utf-8?B?U0RWN2ppZjVERlRlQ09qY29LYlBjaE45RTViTTJTblpwaTY0WGtFTjZaL09K?=
 =?utf-8?B?b01GNHZ1RG5JNkYrRTUyKzN2Wjg2SmZCRjF3S3U2Rk9nZEh2M2lScWxqZlZx?=
 =?utf-8?B?ZHZhNkk3QTRtbklaSTJkQVNIaWVCQkNoZVVmQ0dKL3MrbHRhR1djdmt2SWNQ?=
 =?utf-8?Q?/QBIo85UCRc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU1FMG5jY3Z6dHNTb04xVjR3ZGRjVm0rTHMyaVZCWXNGZjY0MERtaUNNVlVJ?=
 =?utf-8?B?NzhsVTNCZDRyMXV2S2g4VUVuS3BGSnJCcmN0WHp2RDBtVWJRQXVtSmxFNDJ3?=
 =?utf-8?B?NUlZOEN1L0hWbE1xd093WitlZDhqcW4rZXhKYVZtOFZwWFdodFoxQWhqbU10?=
 =?utf-8?B?cWYzeWozZy8yU2VGbjlNaHhRUVM1UmZkNDBSSzVoQ2hDZlVjdDd5R2FBY3dt?=
 =?utf-8?B?REUwd1pQL3h4U0ZKR3NXVGhzZDZhVGVNVHVaSll3ZXcySXNzdWR3RldNZ2M4?=
 =?utf-8?B?QTM3VGlKWDN3Wk1OT3B1TmZKOTZNYWVwNmdiSzUyRm1HYzhGd2ZQalhRaEl0?=
 =?utf-8?B?U3FaU1AzTk5rRlNxWDkrWDZhekJxSnZyUXhIYXhrSzZua0NkSnBUaDJCSC9Y?=
 =?utf-8?B?VUNGQ2EvUkY2SVdnZWFxRUVFc3lWL2MxV2IrMzVQVzBPV1JrYitiOWttaDlm?=
 =?utf-8?B?T2dBbFVJcURRUUpWSlUzV01raytyZFdPOU9VZ1ZmbjhKMHhOMm9kV2diR0ls?=
 =?utf-8?B?UjFaSDkxb0hLOXg2dFEyVE4yQzZJanpqSG10cU9MQVJzTFVBNGgzRUlvcW5F?=
 =?utf-8?B?SlVTcCszZ1p0RGx1ZUpVaVIzY2V2c3ZieXIyRjBxSXM2WXhCNHlNQitHQ21H?=
 =?utf-8?B?ZU9pQ0djcmh0bGF0bk5QU0ZCZW93VkFTNm5lMlA1aVlZVTh6WWp0cTJBTTlv?=
 =?utf-8?B?VldGb21YWE5BM2l3YjF5MEx5bVlaT3h2ODZsSkNFV0c5dlNoeGlKK3hOVjd4?=
 =?utf-8?B?QVlJdXdjOUpZODByeElGUXYyS2hxQ09PM3ByYU9WN0JESlVsanZ4T01ReGVK?=
 =?utf-8?B?YTNiWW5uODd1TWZBcWx0OGRDOGl4M0JKTWgrSUN3NTN1YW56ZE43SldKYkt1?=
 =?utf-8?B?SGEydFdySzIxdlE1Q0xBMk93dmZNT3ZBWmhzTXpuVE04MTcxSjFpK2NvS2xo?=
 =?utf-8?B?aEk2WENSZnhpclZjaVVHR1FRcDVBWEVCNW9kZWxJMVZTQng0NC9iSzErOG1S?=
 =?utf-8?B?TmhCZEJwSi9tcDQwa2praVdSYmxSZUJOYmFvMXVWK1hNczlENTdBQW9paFZY?=
 =?utf-8?B?aHhsbFVlUTVYYlVITUdnSWlWUEN5YStMR0VOWUVaay9QcjJtRW9TcGlpUmVp?=
 =?utf-8?B?aG82N2lJMDcyZ1drMFRyaHJRdUI5eCtYdFEvSUVxbkFuVFkwSVpzZ3F4Yjk5?=
 =?utf-8?B?SlM2K0UyaWZKeERwU1Q4WWV5ajBtdDE3eUpBSTRTMHFUSVdGd3RKWlB5aURz?=
 =?utf-8?B?c0N6bnJmV3FxVS9uRjdxK0Q0UlJhdkNxV0xuSmNxUFJHRjdDVU9JTmxDWjZG?=
 =?utf-8?B?WTVaY3p5SmFRSlJsaFc4RUxzRWhOZFh1bkhmSm9Yc29lNStkS0Zmd1hCT0hQ?=
 =?utf-8?B?ajJIYXpMRFpGRXhiK2xuQlBDaEk2U2pnK3BaQlRLMXUzV0FsUUUwaVdabWox?=
 =?utf-8?B?elZCcXUxdTA0ZEZlMU9XU1d6ZktuOHl6dHpVTUlhampJTncyR0ZkdVZrOVRD?=
 =?utf-8?B?QWJjWmFsSm1Ld2lJWjVueVdZRVZ1UzdEaTFsNWIyZUZ4aWpsakxMZ0RBM3hz?=
 =?utf-8?B?MndjWFFhT3FyNmVIZUh2eVlXb21hS2NRZ3YvckJIZUxjTGIxTG8yV0dEc3Rl?=
 =?utf-8?B?S3NrRFJQSGZoMjBLWHJzZ2pWdDJKcmNEQ0J4cWpzRTJEdFUwYVV6M28wQko0?=
 =?utf-8?B?MkszWTM0UTFOVjgrZCtWemxwbklEQlZVRWFRRU81MXlEN2xub2dxUlFxMENy?=
 =?utf-8?B?OFVQSzZvejZOTDNoWTFaMkpZNGFualNvVUQ1SmpFbmM3MEFaNGRHRTBoenRC?=
 =?utf-8?B?eFZ0VnJVa3NQV1FiaW56VTdERm5QZVVmajBIeHhLaVU5RXppNjErek1tYXBi?=
 =?utf-8?B?N2ZDWkdJWCthTjNFdTF3N2k1aXZSVU9BMEtES3hybFdxSHhyemxJUiswM0VU?=
 =?utf-8?B?ajU5MGFOdXJtYmhrb2tkUUFnRVNFcnBPSGNuL005Wm1INExYUmxiQmtjNE04?=
 =?utf-8?B?K3JObERpVnJhYy9lbEhKbGUwakdKK21OYlNuRFlmbkpoWGw2MDJaSHBRK2Jo?=
 =?utf-8?B?VFFKeVRISUNDcDU5Z2U5bjJrVlhKOGtZbU9nM2Z5NXJwU2NGQnhjMDRGSTJs?=
 =?utf-8?B?dUtuallHbDZYZVozZHE5MnY1dTRrTDdrbzlGendIM3QxaWxPZGs4MDgwclpt?=
 =?utf-8?B?MG9USWZ0SUw4WU5aVE5YQzJoMFNlZkQ4ZFNkMHZzU0FUamErcW5WaXdJTDRK?=
 =?utf-8?B?UzdueHZPUGxDQXFvNThLaGUxQ1ZBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7755bcc0-486b-4d40-1009-08ddc06191fa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:59:05.0750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JemeSdZAANG39rPxPE7OM5yMxuEzLEhfAhY6yeJdz5v87+5Wb0txvdXX4znTWE32oSmCXsRaJiLDNmJC25pEeOxPsDGvOQkDqy8RmnNXOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB7918
X-Proofpoint-ORIG-GUID: App1hqPG40xkWSTtfVfn3E9YpCfYK_8b
X-Proofpoint-GUID: App1hqPG40xkWSTtfVfn3E9YpCfYK_8b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MCBTYWx0ZWRfX+Sn/KXEmstBB
 UQ4ydPBO5vp4gL3bLSn8E5B4s7+V1AC/PH01PtWPPGLTVF4SKxaaANYJT1FUC9ToUFwHl487uAJ
 bvS6y0nA2/S6dR56lmoXMf1K3GcZn+xXzkyyqbBS6vZDNi/3LYN6JrXeYmVLRlH0hZI5QTL4u5y
 R21yzsYmCTsS0R6efnO974NT7uexG2q0GQ22dcTHR88AWW8ykDELy1aZMdf+2lONs5jaKdFRist
 Mgv2Yh7ym+i4gmHeYdQ4WI8yO1avMKhzvmMy59IpHf4cbu6sPp+4yKYtptRgGHtQ06wsoWT9ZKv
 /bfbQfydebbhioLL13v9qPM+sNmceYUHOpXfRcx+apvLg+zT9tsa/pJeLMJyMUCo4TcYU/z2zNh
 pIh3IXbgrSKi9eOTEjwAt/dHpOg38ptfaVmAhERg67pPZPOx9hAez2vy5clQna3vMKVhlshV
X-Authority-Analysis: v=2.4 cv=fNg53Yae c=1 sm=1 tr=0 ts=6870e06c cx=c_pps
 a=lnUO1cdkCGsLc4nFgqdZCg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=m4-MuDShih0a2sssyXkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

By definition PCI can never be enabled on an isapc machine so hardcode the PCIBus argument
of pc_nic_init() to NULL.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 8277aaef1c..f6cd1e728d 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -501,7 +501,7 @@ static void pc_init_isa(MachineState *machine)
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
                          !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
 
-    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
+    pc_nic_init(pcmc, isa_bus, NULL);
 
     ide_drive_get(hd, ARRAY_SIZE(hd));
     for (i = 0; i < MAX_IDE_BUS; i++) {
-- 
2.43.0


