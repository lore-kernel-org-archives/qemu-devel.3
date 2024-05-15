Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815BAC25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 12:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7DeX-0001Ol-1d; Wed, 15 May 2024 08:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7DeV-0001Od-8A
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:22:35 -0400
Received: from mail-co1nam11on2046.outbound.protection.outlook.com
 ([40.107.220.46] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7DeL-0004nO-Np
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:22:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMOCKUfknO01BVdbJiN8asHs5S9Ndd1Qvqr1botxCAt/hPPAKcBo4fpK2U9JwSRUr4vGvKSKzL8a87X8shcK1IMV8AWHxoeVQzdN3vggigygibug7J9gqIPdEw+kbLaoQn5QGLreDqtkSGn0x/Pd4QmkzO4rLMIibifCnpDRQIocJZiMA+1mVLoTZwWUSmm8CnAC6RyuGJ+KPQcI0A6iWIQCYNFZoFVHUr6ASVVaDu0n0pWN5bJRsMZPnxrypJ2ERjEi2c5hfcXw/W8E0nVRPN7NMTtpYR3VWFFrL0zpUdXsJCmJVAWuN+IEh6WlBtIkD6U+LnoaSG+B1+l0QjFARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HalnTZTnj7PmLMeQhyxmmNgILsY2XRZbG/2J7GXXFPI=;
 b=T5TIrqUB8rpeWNeXUtDuwcQJzgwKnaQ+O7oFftFNu0MnrUhWc5PPGjNM/nrSXwTGs+LoD4vUzL1H9ajMM4dd8dVuvM4HhNMPUgIr0oYAhzff1A57ae+k+XC9lpHWvlnLSU8EUjOpRtiKsMOz05ugMFjL6tl2mtBUdirTDVpuV3Ve9vFs2GVT+qrLzy9gikD/woyu2Lizt//qmyy/YDvhJpCWtEEyMGoh3nS+QzRBnX1Y+HhoKUJKa0KmAeO1KJ/wVFLoNmrZ03USqURByWCDMRoxnhoJ+oNR3wBG8NTdirNbtofECijGNvmRXpZ84oGCTEMCDKWbN7xnURjxmLS5/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HalnTZTnj7PmLMeQhyxmmNgILsY2XRZbG/2J7GXXFPI=;
 b=qPMe2ue+dk6BPIKxhjYe6V75PpPqZSMesxuK4IAwIFVDmmRlDolaXqkH+zmolSnkzjTPC6KULelkWcvCP+tijq0VV1E4N0TEleiTJm1J5bXTObXbUC6WuX+dKtNfroGQt8xA73Hjcav2UkJtKfLhaf0QbKlOCzCuD87gHIKgQdJQhdTNBW9xBM+UMeJK0iIOwbDL9ZZwktO+F6YmYL8UXJ/fPEYKoB0JF1wKr5Zw/5t8H4pnZMWWAyRkjsxjCSJdp+BxgRooTukeSz0d9Pmv4NDkraKFd61ej5KUx9uBVLDMrwiAPZ2cvATmgE+urjWkdpQTbW+afWHLLjLmkPTpvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by MW4PR12MB6897.namprd12.prod.outlook.com (2603:10b6:303:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 12:17:18 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.7587.025; Wed, 15 May 2024
 12:17:17 +0000
Message-ID: <020da629-845f-4599-92da-33cf41ad92f4@nvidia.com>
Date: Wed, 15 May 2024 15:17:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] vfio: Add Error** argument to
 .set_dirty_page_tracking() handler
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240506092053.388578-1-clg@redhat.com>
 <20240506092053.388578-2-clg@redhat.com>
 <2e55e1ad-5c40-4ae5-a362-5f7fd610b0e9@nvidia.com>
 <2ef7b720-31a8-48b6-b825-a64b3fe87a1f@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <2ef7b720-31a8-48b6-b825-a64b3fe87a1f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0449.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::22) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|MW4PR12MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: 3690e935-6ee4-4fa3-a326-08dc74d8f63f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TG9ocjRqMVNsVnpsczdXUUhVS2JGS2I2Y0QrTTBVaXNCcUUwY2hUNnBEanJl?=
 =?utf-8?B?TEtZeDBMamp4S3RrbDNRVjQ3bm92ZVk5c2t3Z1VaN0p6MnY5M1kvZFUrNzZY?=
 =?utf-8?B?eXNIQUZPSE1wZTVEMk5ZUzZ5MFlVUGNWMXlrTkdBMmUyWUtUZDNWYmVncmtN?=
 =?utf-8?B?UWNXNERtenN2Zy9sdUhqaTNsKzhOb0F4b3ZKaGlObUY5akU2MFJTc2QrTXVV?=
 =?utf-8?B?UW1OYmtYaVBzS2MyQTRyWndjZk9qbm1YK1hhdE5HWDByZjlZQ1pYd25oUnlV?=
 =?utf-8?B?K3FUZGw3VUhETVRQSlBZNEpmUlM3a2R2OFYzdHpxWDZPbXNXRUJWaGtROUti?=
 =?utf-8?B?ajBXWXBtM0NndkIzUjdwWUMyaFVtNE5pamM4UTRoSUt2TGdtajdRNWZSZER0?=
 =?utf-8?B?THJuVGhUYXNMVnZnTDhaY0llMnVZaTk3bXBSSFhJVEplU2JLNjZGQzBoWHNP?=
 =?utf-8?B?aE44VkpUNEVVcnJWY0RLZGYvQjgvNDNwYnlPb0gwcUxiRzUwVmdCd1RUY2Vk?=
 =?utf-8?B?bXZJa1BMcDhKQ1I2L01XTWZTL0lFVDRTQUJ5ZHRqNm5uK2FhZmpPcUcyZTR6?=
 =?utf-8?B?R1BqMEt1U2JhUDJzT1ZhWStZN3lvZTR1cjdwbUZwWG1xeW53b29JT3I4SWwz?=
 =?utf-8?B?a1ovVnh0WWtHb2NmSnJGWWZwNDNiTktwa1d2bTJOQTdMaVFGajE4dnNWNzNu?=
 =?utf-8?B?WjMrNEpRZ1laOUZYbHpTWjEydDkvRllSTjFCSlh5V2RPMG1lSElnaGNUTDJr?=
 =?utf-8?B?NUpzazJOaXU3aEFPVmt3YlBFMmprK3ZpRVBNSlBZS2h3VENwWk5hL0I5c3ht?=
 =?utf-8?B?ZkhSaEZRQW1WVjk3RzVHYzUwNUtKcStQaVNPb2MrK0JFL0dSMW9LL1ZGdlNt?=
 =?utf-8?B?V2xORS8wQ2I1S0tqdlZzVG9JUkpYR3ZNcFo5T1NaN0NLOHQ0bzlXb21XSnBF?=
 =?utf-8?B?alZJdGFRaVdDK0VWeElzVXFkczF1dlp0Um44bmVMa21hL0UxNFdzMS9LcFZS?=
 =?utf-8?B?dER3b0JpTTFIeklVSDEzN2ZoZlI2NHppcE9KY2NHUmNnSTQ0b0J0UXovV2dm?=
 =?utf-8?B?ZGhwRTJuZElwU3ZpNkRtbnZIM3dEUFdLTWo5Qzhnb1dXaXVTQUNrVW90WWdZ?=
 =?utf-8?B?RzFhemlSUUlSaXkrMnNKYThCRHNncnAwWWR0U25vRlpJY2pkOEphZ3ZIeU41?=
 =?utf-8?B?V3luUWs5MGo2c1oyOCtVRlY3Z0xoZHdqRXZ3RlBqcTEvY09NVjcrQkRtcmF2?=
 =?utf-8?B?bzdGTFdwQlNUSUF6QmRpRzZKQlZNUjhHdGVJekJEaDZSbWxJTHYyd1d6YUNn?=
 =?utf-8?B?ekdzdUt6V2lPS1V4Unkrek80NzhKZ2ZHTWtIZVVxTTd6S1U3SGFTTjdTVXhx?=
 =?utf-8?B?d0owbzI1dnluVUtHMUU5azlpQUpQSm1mclM1b2EvTVVMRjdISTZoRks1OWho?=
 =?utf-8?B?NldYNzllUG5YTUhBUU0yV3VqZ0FDZEIvYXNrbXh0Qng2Y3hqR0lxVUl0SEZP?=
 =?utf-8?B?czh0T0lKZmZTQmsvQlozZUFFdDFQOFUzVHJoR3VPODFYM2xRMktDQS9jcS9q?=
 =?utf-8?B?TTd2bUdNUjZ4NHFpekl3ZWRZTGlCWEFDSlk2TWNsSURXSXZlb0pWd0F1ekdJ?=
 =?utf-8?B?Y3pUa0Q0aXlXRk9mOUR0WXQvQjZpRFJyWkVXb3RsbmUwV0JIS1piNlc2RXN4?=
 =?utf-8?B?aXVtN0t3eFRnaWttbmo0WndlNWJFSHB2Qkdwd1phbFNUTHZJc1FJT3FRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REZBRFMrNmJHZFp4ekU0YmJoN3c5U0RTYUdBMVZVeHlqemJ5RGR3SzIxaHp0?=
 =?utf-8?B?aUhJUjJvQ1l3ZncxUTY1alRvSVZKcG93SStMR1haa09vOUdNT3RadjJBSkRT?=
 =?utf-8?B?RjJEUmM4VjBNUEQwMlFSTThDdzFnY0k4enZQU0xXdmEzNmtPZS9pY0xXbFA0?=
 =?utf-8?B?ZEJhYTlwenJ5Y1lTUDdRK2JFbE1mbm9BaC8yU3QvTDQveUMrYUNjNU5MQ3Iw?=
 =?utf-8?B?YWhKbDJvbVFUMVg2dGFoL2ZPN1pnUWtSR0NIQlRRbHhGUXdWb0QwbmRUK21Z?=
 =?utf-8?B?dmp0NjR5c29uVmpITjh6NS9lWVRNUVdyVTBzeVkzOEFWTXp0QlJ4dTNCdi9m?=
 =?utf-8?B?ZXg0R25XVHp4cW5FbXhRelZHTG1mTi96Y21pRTBkM0doVjVFZHpxaGptTCtJ?=
 =?utf-8?B?aVJIME5hZGx3Z2RURVBTUDJoTkVXbTJGNE90QlpaSG0ybVdYQUN0dHJxamts?=
 =?utf-8?B?UUowbjZGZElCMGhjNmRKdlU5NW1tUm9JSjgyVjZia1dNL0RtK1JJcWl4by9x?=
 =?utf-8?B?MndXajdzSWhDYTJzVHQ0VzZlRmxjcU1Jckg1NVpDYndCeDdTOTBodllXL1Bt?=
 =?utf-8?B?RVpMV0J0bWpoREN3UkluV2RqTGRkYVQ2enZ1MFJhaG5PT3VzdHk0YXNwTlBM?=
 =?utf-8?B?dGc5OGRWUlZVRWVDcENFTkI4emg4UWdKb3hNRFAwM0lBdTBhVDhHWXIxRnpv?=
 =?utf-8?B?TGVyZDYzSmk2TGZxNVI4OC9FY3FSMmxnVkJIa0VsampsVHZYblRjVUg2VFlq?=
 =?utf-8?B?enkzR0EwZExBajZQOVlxVGVHRVhpbUh2cjVueHdPVGI0eGMzdXg2TTBRZ1ow?=
 =?utf-8?B?UU1zT1pXVld0YWZjZEpNbFl3TlBiZkhHZzN5VTlUbTEveTVhYUt2b0M1cW81?=
 =?utf-8?B?TkRDU3hkSHFCc09TU3kwVU1IbWdUOXE3OTdrL1dkNDl5ZTFPN3N3UVkvL0tr?=
 =?utf-8?B?SHh1UVR6K08wRlBFWElrN0J1RTJ6N0p1TE9sQ3RjUzduSUNDV0doS0doYklW?=
 =?utf-8?B?aUg3Zm80RjlmbGZQaTU5UFBhNGJ4UTVoSnU1bFFRZ1ZpMW9vWExGZng5dEQ2?=
 =?utf-8?B?WGNsQ05yaG5iTG1mWjdMYW9KY0hvZHNBU2ZxQTRnRjNEMnhFQVNUOWpLQnly?=
 =?utf-8?B?Vk81Q2NUVURRaWt1ekIzZ1E4S1I3eHlTZHBONnZPSVljWDNnWjZOeHdEWTlQ?=
 =?utf-8?B?UEprdzZwMlMyNW8yL1lpTVpjL3ZUTUdSc0xjTDkvQWtBblB2ZzZxbFk4cWl1?=
 =?utf-8?B?LzFESXJiRzFhVFJYSVhHY0JFZFZYU25FTGFhSlZ6RTEwUktQTDlULzN6M200?=
 =?utf-8?B?eG92ZFhlRDh4U3Z5YTJVcGFpT0RpcGQxNlZwbUlCZ0xpckd6YjB6YThzbUEw?=
 =?utf-8?B?b1lsTk5SakF6ZXFhWFNBQnZ4bE0xWFJNZ2ZaQUF6Z3RFV2o1TGR2Tm1VeWl4?=
 =?utf-8?B?Sk9lV3B1Y05SbFhSa2MzRHZ5WFhuUkZhR1pDdTZaNVljZjEvN3N0bmVqVm05?=
 =?utf-8?B?NTVLUDdTWXl0U2czU1lwenRIMS9nU2hLUldqS3ByMWRaNzJTa1I4TGNrRWk0?=
 =?utf-8?B?SHRlcDhWWXAyajVCMDdiNmVyQXl1WHkyWXRFdlVMVnlYZjUyV3ArenNqZDhy?=
 =?utf-8?B?M2psU2IvaTBUcEFJaHMyWmFRbXptRUJUSEJPdGtPK0tXbXJqZ003cmZNUlBw?=
 =?utf-8?B?KzVYeUd4UzJPNHRLWHVwN3pSK0xuNlE0a2NuS1NFMVRnNEY0djFQVnFJdENV?=
 =?utf-8?B?L1hIUWFoQ3Y0anU0aWZkUHh6SU9tSEw5QXJkWk1YL2ZiV3FqWXE2bDJEcW4v?=
 =?utf-8?B?ejg0ZXM0SGRIck5XR0RCKzFzZFlyVFBQV1gwaDU1cUJkeVNJMG5EL0N3UTFR?=
 =?utf-8?B?VVFCUFRxaDVoejRnaWJUenpibDR2bVpUWXpWVW9FQjR0amJORForMUV0NlVX?=
 =?utf-8?B?UGJCZlRNK0JJaFRUV0xYSk1vT2JhWjMwZmhZZ0JDbFVHT3lEVE1FRkd0NkV5?=
 =?utf-8?B?ZUxWZ3B1M3FRWFhlSm40UkxXN0EvS01LdW1qZngyLzRORGovditkWVBsN3U2?=
 =?utf-8?B?MkJYSTVhN3U5VVlnVWEwZ1JReFo4c1YwK1ZSUWk5b3F5Mk1KT2YvOEVGaEhU?=
 =?utf-8?Q?WV8GwoLzeFrp/+uTclwcsF0ce?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3690e935-6ee4-4fa3-a326-08dc74d8f63f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 12:17:17.6473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3orsLf5uJ/bgW7kxDm2rJpvC3hEtpXQwRBjqkN4e43nAptUEEBFvrkkUnmQHZWNF8OTlZ0O7qhPDIAmEEXALmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6897
Received-SPF: softfail client-ip=40.107.220.46;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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


On 13/05/2024 19:27, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> On 5/13/24 15:03, Avihai Horon wrote:
>> Hi Cedric,
>>
>> On 06/05/2024 12:20, Cédric Le Goater wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> We will use the Error object to improve error reporting in the
>>> .log_global*() handlers of VFIO. Add documentation while at it.
>>
>> First of all, I think commit 3688fec8923 ("memory: Add Error** 
>> argument to .log_global_start() handler") forgot to set errp in 
>> vfio_listener_log_global_start() in case of error.
>
> yes. This is unfortunate. There has been a few respins, the series
> was split and I was hoping to upstream this part sooner. My bad.
>
>> This causes a null pointer de-reference if DPT start fails.
>> Maybe add a fix for that in the beginning of this series, or as a 
>> stand-alone fix?
>
> Since it is fixed by patch 1+2 of this series, we should be fine ?

A fix could be useful to be backported to QEMU 9.0, no?

>
>> Back to this patch, personally, I found the split of patch #1 and #2 
>> a bit confusing.
>> Maybe consider squashing patch #1 and #2 so container based and 
>> device based DPT start/stop are changed in the same patch? Like you 
>> did in patch #8?
>> Whatever you think is better.
>
> ok. Let's see how v5 goes. I might just send a PR with it if
> no major changes are requested.
>
>>
>> In any case:
>> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
>
>
> Thanks,
>
> C.
>
>
>>
>>>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> ---
>>>
>>>   Changes in v5:
>>>
>>>   - Fixed typo in set_dirty_page_tracking documentation
>>>
>>>   include/hw/vfio/vfio-container-base.h | 18 ++++++++++++++++--
>>>   hw/vfio/common.c                      |  4 ++--
>>>   hw/vfio/container-base.c              |  4 ++--
>>>   hw/vfio/container.c                   |  6 +++---
>>>   4 files changed, 23 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-container-base.h 
>>> b/include/hw/vfio/vfio-container-base.h
>>> index 
>>> 3582d5f97a37877b2adfc0d0b06996c82403f8b7..326ceea52a2030eec9dad289a9845866c4a8c090 
>>> 100644
>>> --- a/include/hw/vfio/vfio-container-base.h
>>> +++ b/include/hw/vfio/vfio-container-base.h
>>> @@ -82,7 +82,7 @@ int 
>>> vfio_container_add_section_window(VFIOContainerBase *bcontainer,
>>>   void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>>>                                          MemoryRegionSection *section);
>>>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase 
>>> *bcontainer,
>>> -                                           bool start);
>>> +                                           bool start, Error **errp);
>>>   int vfio_container_query_dirty_bitmap(const VFIOContainerBase 
>>> *bcontainer,
>>>                                         VFIOBitmap *vbmap,
>>>                                         hwaddr iova, hwaddr size);
>>> @@ -121,9 +121,23 @@ struct VFIOIOMMUClass {
>>>       int (*attach_device)(const char *name, VFIODevice *vbasedev,
>>>                            AddressSpace *as, Error **errp);
>>>       void (*detach_device)(VFIODevice *vbasedev);
>>> +
>>>       /* migration feature */
>>> +
>>> +    /**
>>> +     * @set_dirty_page_tracking
>>> +     *
>>> +     * Start or stop dirty pages tracking on VFIO container
>>> +     *
>>> +     * @bcontainer: #VFIOContainerBase on which to de/activate dirty
>>> +     *              page tracking
>>> +     * @start: indicates whether to start or stop dirty pages tracking
>>> +     * @errp: pointer to Error*, to store an error if it happens.
>>> +     *
>>> +     * Returns zero to indicate success and negative for error
>>> +     */
>>>       int (*set_dirty_page_tracking)(const VFIOContainerBase 
>>> *bcontainer,
>>> -                                   bool start);
>>> +                                   bool start, Error **errp);
>>>       int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
>>>                                 VFIOBitmap *vbmap,
>>>                                 hwaddr iova, hwaddr size);
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index 
>>> 8f9cbdc0264044ce587877a7d19d14b28527291b..485e53916491f1164d29e739fb7106c0c77df737 
>>> 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -1076,7 +1076,7 @@ static bool 
>>> vfio_listener_log_global_start(MemoryListener *listener,
>>>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>>           ret = vfio_devices_dma_logging_start(bcontainer);
>>>       } else {
>>> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, 
>>> true);
>>> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, 
>>> true, NULL);
>>>       }
>>>
>>>       if (ret) {
>>> @@ -1096,7 +1096,7 @@ static void 
>>> vfio_listener_log_global_stop(MemoryListener *listener)
>>>       if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
>>>           vfio_devices_dma_logging_stop(bcontainer);
>>>       } else {
>>> -        ret = vfio_container_set_dirty_page_tracking(bcontainer, 
>>> false);
>>> +        ret = vfio_container_set_dirty_page_tracking(bcontainer, 
>>> false, NULL);
>>>       }
>>>
>>>       if (ret) {
>>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>>> index 
>>> 913ae49077c4f09b7b27517c1231cfbe4befb7fb..7c0764121d24b02b6c4e66e368d7dff78a6d65aa 
>>> 100644
>>> --- a/hw/vfio/container-base.c
>>> +++ b/hw/vfio/container-base.c
>>> @@ -53,14 +53,14 @@ void 
>>> vfio_container_del_section_window(VFIOContainerBase *bcontainer,
>>>   }
>>>
>>>   int vfio_container_set_dirty_page_tracking(VFIOContainerBase 
>>> *bcontainer,
>>> -                                           bool start)
>>> +                                           bool start, Error **errp)
>>>   {
>>>       if (!bcontainer->dirty_pages_supported) {
>>>           return 0;
>>>       }
>>>
>>> g_assert(bcontainer->ops->set_dirty_page_tracking);
>>> -    return bcontainer->ops->set_dirty_page_tracking(bcontainer, 
>>> start);
>>> +    return bcontainer->ops->set_dirty_page_tracking(bcontainer, 
>>> start, errp);
>>>   }
>>>
>>>   int vfio_container_query_dirty_bitmap(const VFIOContainerBase 
>>> *bcontainer,
>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>> index 
>>> 77bdec276ec49cb9cd767c0de42ec801b4421572..c35221fbe7dc5453050f97cd186fc958e24f28f7 
>>> 100644
>>> --- a/hw/vfio/container.c
>>> +++ b/hw/vfio/container.c
>>> @@ -209,7 +209,7 @@ static int vfio_legacy_dma_map(const 
>>> VFIOContainerBase *bcontainer, hwaddr iova,
>>>
>>>   static int
>>>   vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase 
>>> *bcontainer,
>>> -                                    bool start)
>>> +                                    bool start, Error **errp)
>>>   {
>>>       const VFIOContainer *container = container_of(bcontainer, 
>>> VFIOContainer,
>>> bcontainer);
>>> @@ -227,8 +227,8 @@ vfio_legacy_set_dirty_page_tracking(const 
>>> VFIOContainerBase *bcontainer,
>>>       ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, &dirty);
>>>       if (ret) {
>>>           ret = -errno;
>>> -        error_report("Failed to set dirty tracking flag 0x%x errno: 
>>> %d",
>>> -                     dirty.flags, errno);
>>> +        error_setg_errno(errp, errno, "Failed to set dirty tracking 
>>> flag 0x%x",
>>> +                         dirty.flags);
>>>       }
>>>
>>>       return ret;
>>> -- 
>>> 2.45.0
>>>
>>
>

