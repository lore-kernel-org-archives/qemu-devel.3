Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332BAC7EE32
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 12:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUmBC-0007Bu-B6; Thu, 26 Jun 2025 08:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1uUmB9-0007Bj-7Y
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 08:58:11 -0400
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2418::600]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1uUmB6-0003PX-QS
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 08:58:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzrgygF35Ib3GgzNP3AIOHJox/+6Cso6QxN/hlitLqCodTIoSBo24yTobaZVlgKdK7pfAcdZkanZMFVdn8iEs7hWg/9xGibuSh+v2m+K+dU4eF2yiYokC56uOq0bcDQIpJzIsAUzWQqzyjlw7+lFd+Iaq/X6QnXlCkiAsT2ItVTCbTDyxvzBWpP20CtG0tfabjhZ5wOace3UHOrcCy6tzq7E8s4nrTwZuKPwIBiFw+KGGn6sEYPYm2qrEq0vzTjnCOpW1ZpHczg7IXkjSyQYuED8FP2UTuB5L2koVRlYfgQnzAbndV4vvQHY+lBtnNDBpoOxN4TwceKHKlLcp5Jydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdX2Q5ABUIKtNvLkzSKdvJKt8LuBtDCrM7d8aJnZpsw=;
 b=p1rMrk+oXzuqqwoNa3yIFCNfHEZqGBvE8W6pT7PbvK7xBRVVQvDUAPhH1z+SeEFRMLLXEU2fhtF8WoRrk0F6fCZykyMAZbFwHuSE16MSFNv/VlPx2p507QLs0k0eMsKJ9sKnU8gkoI33FcYT8AHIcm9TO46cvVQswl8gOw4zIyTQlvTkcPVaXRDAfy7bhQ1gNuFlcOtbEoymXpYsrO23DIuqERsxCmGMymrWQ9lxEuK6jSOaN5e7IwTgyvmfvT/dn5WCKHbqmT4yuITVZDtwy5DQIH73+JpliXw76O7WRMc6V/eJr79sENEOBoMFXo7cK/mGTUdkcOy2XyFji+WMqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdX2Q5ABUIKtNvLkzSKdvJKt8LuBtDCrM7d8aJnZpsw=;
 b=fF0+BGo2OItyjjzoXYfnwYTcmG883kOIujkojK9h+d1zcE4G8rbZcD6291xwwZt2f4baKKGkFkAGdHBlmqSJwSL08MgNMlgizz0omHwhVYGASCGK3OAOUAAyoXL/Rp+/3Paa2iDtAt0mQ9R9TG1e8bISFalwL9d6PNNE/0OfJrU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB7355.namprd12.prod.outlook.com (2603:10b6:510:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Thu, 26 Jun
 2025 12:36:21 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8857.022; Thu, 26 Jun 2025
 12:36:21 +0000
Message-ID: <2412d030-2732-4bd3-9009-e76d5fa9ba29@amd.com>
Date: Thu, 26 Jun 2025 18:06:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] amd_iommu: Fix truncation of oldval in amdvi_writeq
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
Cc: ethan.milon@eviden.com, mst@redhat.com, pbonzini@redhat.com,
 mjt@tls.msk.ru, marcel.apfelbaum@gmail.com, richard.henderson@linaro.org,
 eduardo@habkost.net, suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, brijesh.singh@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, philmd@linaro.org
References: <20250617150427.20585-1-alejandro.j.jimenez@oracle.com>
 <20250617150427.20585-9-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250617150427.20585-9-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH7PR12MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: ed164a20-f426-467e-409d-08ddb4ae0de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXhNczl4cEp2YU9rbm53SElrdHV0YkdnS3NkM1pLVlJ6TWNQMWROeEJRV3FE?=
 =?utf-8?B?Rk1GZUs5U3FRUDczdEJmRmNyd1hyUmY4RDZLNkxSRTlQL3N0MmRsTHkvRWtR?=
 =?utf-8?B?RGNWWHpoQUk3QmZ3azYxM1hUTVVmNTZzclV5ZCtlWUtaUTQvN2lVNHJyM2xl?=
 =?utf-8?B?dXJYZEt1QkM3QzhIdEdzK253QVVqalZWKzkvdEM3L1dYTithY2FsZ0dyOWd1?=
 =?utf-8?B?M3ZlQ0NEQjA3VVdCVGRJQzNZWXlQYk9CY2gwdE1xOHRWWDRlQjN3VmxiNEFn?=
 =?utf-8?B?eVROTHBaYTFZd1k2YWlCZGpvSnhKbVh4ejFpOWlwS2VTMkZVMFZTVTBseGZQ?=
 =?utf-8?B?eEwwdVdVbTgyM0NpRE9XOHBlVkE1bGxOWjZoL3p0YzRncFRXdC8xbm9wOW1S?=
 =?utf-8?B?OENsRGE5WkF6ekZOdGtORUN1T1BZdERxelJqYTVOSFNlK29mbFIzUGRneERN?=
 =?utf-8?B?cW96S1ZhOEZOam42ZXp1eGZLS1VHMlFEYUZkcjBmclZmTkl3cG00T21LRXJW?=
 =?utf-8?B?NmFLSkovOXhXTEp2ZkZOd1JYaml3cmlqS3Z5Wm1PcUNRN0Q4NUp0aGI5OHJR?=
 =?utf-8?B?b0RUdGg2SmVCcUdObCtDSzhYQjg5bG8reTdycVlTaEg2YlVhc1FuWUhEUHNF?=
 =?utf-8?B?RzlzUVk5cmxzbWYzT01VbFhoUjZsTzl5SzZQSkNxTjRVQ0I0WUdsN09yYlAr?=
 =?utf-8?B?VTU4aUtra0c4UEJNVTNucVUxKzJjQnVYM3FtcDIveXZCMkYvY1VvVHB1RTBF?=
 =?utf-8?B?Q3dPQmhrU2xnSmZFR2d0T0x3MmJVd3lZNkJoNUVXRzJpQ3Vqd2NBT25sYk5l?=
 =?utf-8?B?eWRSd3NWTm5raVBuVHEvdDVEeEp0Z2ppT3pWbWNjY24rOVUxVTl1NElxakdo?=
 =?utf-8?B?TVpIZ0NKeUg5aTMrUkJycVJUZ0xSVllFTXQ0UG1kbUduWG9WMGg1ZDJaTlRq?=
 =?utf-8?B?VXlPY2dMYjcrUTVhZDNiaUpCdTJBQlpmcjlyQlRPQ2V2Ty9MZURxYmhTeVJY?=
 =?utf-8?B?RDhwdWpYRkppU3dTRW5tbHFJNTR6SnVmZXNCWUx3b05Rc2xjUHR0QkZvMzFH?=
 =?utf-8?B?TnM4ZGJjNWVDTWlmanJ2bzRzb3QzMDNCSGtqRWNUOEwrT0F5WWRwSHNvc3do?=
 =?utf-8?B?ci9HZG9RNlRQY2tZQ2o0MEtUN0JkMGxmanVVUkNMVG9sQUszYzVPeG5zN1hy?=
 =?utf-8?B?WFZJVGlUcTByUHQxU3NjUytDSG5vSGNGUDJ4dzhXdDRsYWR6RHlZWGVlYWN2?=
 =?utf-8?B?T1grWVlzZS9OTWJ2NmFxOGVJd09qNXBYcllNRmxlMjFYUnkyeTh3clBOZVNM?=
 =?utf-8?B?UHEwR1o5cDdpbDI2TmZkTGhYb05WRU1GOGtwS3hCd0NYQjJsQjlwUHhyZktB?=
 =?utf-8?B?TmNLZ2htZGxoWm5CTC85OTE2d0czQXpXd1Nnc2JZbVlBdkhZTlJ2V3BUN3Vn?=
 =?utf-8?B?UkNmcnZWMHNET2FpT0tkcmJ1WDBMYnROUGVvTXVJNjVIWHFMb3VManV1Smk2?=
 =?utf-8?B?ZmU2ZFo5UE83NHNzSnlFdjF0M2VlSitNS0NIMG1mT2JlWUlGbFJjUXcraTU4?=
 =?utf-8?B?U1MyL3k0MkRLNTFHYW5JYmUwRlJScFJkWHZKTWVITGZMNjVTRUpyT2xTdlJX?=
 =?utf-8?B?SGoxT0krSG1DczFGL1Q3dTR6YUVjVlE3RWRrdHB4eXpaNXZUMWs2d1dOZVli?=
 =?utf-8?B?Z3FvdmUvWHJxWDA0TEZ2dVdmT1dJU09RUDJiTzhRakxaalV3SlhqdzZCWEQw?=
 =?utf-8?B?YW50TWpiMTU0NlIrQTE3SFRuMVFvM3pjeVRLVXVVcXQvakdQWDVSanNMVml6?=
 =?utf-8?B?WndoY1hxek9YcTRUa3RzM0Z5VHZ4a3dRS1FmT0dYZlBkdllMckNCVlZoR0Ex?=
 =?utf-8?B?cDNFdUFjRVNJZ0QzcTQ2ajUrSVVsSGpGbk51SlFFZzJFUS9uT0dka3pnSkg1?=
 =?utf-8?Q?m0pr1Fl/aPA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWM4OU5JUkJqN2tjNmN0UUNaVmxsbzNvYnZYTWhNaXZCZ2F0ZXF1Ti9HRStw?=
 =?utf-8?B?VHFjcUFqN2VYZ1ViY1lzYndFM2FaMlFvcHY3Q3h4T21VMVoyZVVwRC9uK0FM?=
 =?utf-8?B?Z0J4dkVZQUtMWlFkaG1NT2JlVjE4elplZy93MXJMUmxqMzY3d1orZGk2R3FJ?=
 =?utf-8?B?eG5zUW9iazJyZTNPSG1UZTVuVVJkYzN4SlMvenFJS0gxK3U0dFpLMnUrZlBU?=
 =?utf-8?B?bjJieDBVQ04velZxSlo4MU0rR002NEhia3dFT0dGRURTWktVd0drUFRtNnlw?=
 =?utf-8?B?SG1lQ0tOUGZOWGRZaCtSTERsdjF1bklSWDlNYmdvM1duV3hUTEkxYk1WVE1Z?=
 =?utf-8?B?RjdvaU4yaUpVLzZjeUFnVUtSL2Fsa1A5ZGpNSHlXaTBsZ1ZXQlA3V2h3bVUr?=
 =?utf-8?B?dDB0Z3F3WXRraFUwenMzb2pMSVh0VXlKSFN0SXp5djhYaVY3V29Pdmw1eE5B?=
 =?utf-8?B?cHBjUFZ5ZDExL2o0K1Vpc2FYZTZSY254dnJXTVUyaHlOdjZsU1BoVTBwSXg2?=
 =?utf-8?B?NnJsZWxiZEZlTWRLNm9ERER2K1N3VnNrWWltYXVZOGpJeHh0eDNqYkV1N3Vy?=
 =?utf-8?B?dURXQ0x5dUd4b3BINkRleWJFYnMzQjM2NCt6UUZQczNJOUJHMlQwQUNWclhr?=
 =?utf-8?B?eUVXWVUyUU9HdkNqVEFiSExYLzUxTFhobUtWRHA5cG5qWnNvdmN2WHNsdzBJ?=
 =?utf-8?B?MHQyM25zZHlYMDNldW1kUkgzVlJkcWs1TGlyd1ZVb2s3alJZc1BXbDIwKzl6?=
 =?utf-8?B?Yk4ydGNNb2duaW8zNHBrSDFvbW1qdWV6aHlySVRZbVg4bGowY1pyUDNMN0Z3?=
 =?utf-8?B?Y09kWW5PdDlZT2UzajB6djdKSGdiWmtMQTNhbWJSSjJiZnJGWW01bi9rNmFP?=
 =?utf-8?B?TU5BNjNwcEJlRmR1T1IydXZqVk1kcnorYmpUbis4ZytMbnoxVk1rWkpCVDEr?=
 =?utf-8?B?b3lUa1I4L0ppamdSRTZTYm9RWVBYcnkxd3RRK3VQeTlmdkhDQUFNaTRoaEVN?=
 =?utf-8?B?YUZlWE1VS0I0c3FUMUQwdVNOZnd5OVVabkZpSHR2Y2xXL1pnNjFyY1FVWlpN?=
 =?utf-8?B?TVJrdmJOR0x0UUhhRk1yUlJ5Umx5VGorWFNQTTVMUTl5RWk5V1BPOFpqODQv?=
 =?utf-8?B?L0I5dmgzelBYNjg5VlZuQUdoU2lHTEI2Rk5VMEFzVHNBZTd4aXJxczlMaC9r?=
 =?utf-8?B?ZUcxYnFVSGRZbUxoZ25CZWlBV0ROVUQ3TGFFK1AxaElJUncxdThzRnJ2REZo?=
 =?utf-8?B?SkFpR2l2QWxrZ2lHTUFGVG5BYnZLUzExTG9sUlQ4bzE2NHRlZXZEbVZWbHdp?=
 =?utf-8?B?UC9LeGdFd2tOVjdqdTM1QkxnNTUrQ0cvQXFlaTA0Z0ptK0NIWGtNRmszZVFq?=
 =?utf-8?B?SElIT0R6NlNRbFJUaldqNk9mWEpGTW14VDhnbGdqeS9BZndnZmVRWCtEUFRO?=
 =?utf-8?B?bWJ6YnMwdW5BRE9Pci9LeXNadmFQVDFua0UvbjYrTmUwZHNneXdnbTdncEl2?=
 =?utf-8?B?MSthcHN0d25zYlh2RU1hTGxDSjBya1dIT3lORGRGS0YwbnNlM0w0SzRJLytF?=
 =?utf-8?B?L1JEWHc1WkFJbXJzRVBWVjZ4NVRiTm9hRzZCamxGL0lzNS8vRUJrQU1DallG?=
 =?utf-8?B?czQzLzBmMldpRmZzbFh1alJxYm1QMDlMV2wxcUNoYTZyNWpUQ3NwREdoOWQx?=
 =?utf-8?B?NG5pTVAwdGVSQklMWElXZFN2RC8vMWV5VnUrQU0ydWx6UDlRMGt0M0tYWGNx?=
 =?utf-8?B?M2VSWEtTb3QrWlhqS1ZGQUpjaDdySXNrc3BFQ2VpeXZGbnZXTEh5MC82eUxB?=
 =?utf-8?B?R0ltRWZ2WDZiSG9kcnRhNDZjU0V2aFVhencrTld6M1RQa2Y0WDN3WHdROHBx?=
 =?utf-8?B?RTRhWFRYbHNuczNJVno4R2YyTXJOTndXb1dWWWZERzlsblJaeThnOTlUWTFO?=
 =?utf-8?B?ZXo2VjdLckFQcVVTeVY2WlZyRzlwWCsxYjJuY3VoRWpySW16dnh5MFNVdlBZ?=
 =?utf-8?B?M3dHRHFqWmZDbkhwNlFiVzhVRXVkT2RiSlo2dEs2QmdjcHNLZjVaczFRcG83?=
 =?utf-8?B?bjlsU0tiejZIdlJianpLZzQrRHhDbC95bDlFejc4MUd1QzBBUSthdDhFY1ds?=
 =?utf-8?Q?fE0w7z+TLoQ1484/adxH+SWzg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed164a20-f426-467e-409d-08ddb4ae0de2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 12:36:21.0641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qgwv7xOYUOfUtVcmqwyx+ZlpJWjt4bHNDadOhnQymt5NU+lFAIkbkgfiqaZPifEhm60TlzTDQ698RQpKq5PF4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7355
X-OriginatorOrg: amd.com
Received-SPF: permerror client-ip=2a01:111:f403:2418::600;
 envelope-from=Vasant.Hegde@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 6/17/2025 8:34 PM, Alejandro Jimenez wrote:
> From: Ethan Milon <ethan.milon@eviden.com>
> 
> The variable `oldval` was incorrectly declared as a 32-bit `uint32_t`.
> This could lead to truncation and incorrect behavior where the upper
> read-only 32 bits are significant.
> 
> Fix the type of `oldval` to match the return type of `ldq_le_p()`.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
> Signed-off-by: Ethan Milon <ethan.milon@eviden.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


