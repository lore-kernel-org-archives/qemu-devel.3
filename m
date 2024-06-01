Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BF9C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Jun 2024 04:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDGoF-0007DR-E1; Sat, 01 Jun 2024 00:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sDGoD-0007D1-AT
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 00:57:37 -0400
Received: from mail-dm6nam10on2061d.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::61d]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sDGo9-0004qk-J6
 for qemu-devel@nongnu.org; Sat, 01 Jun 2024 00:57:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNbm5PtQCoz6jhm8EmdPCvG7TqJsZ++ZX419/w1CO63S8YPJjNKe6LFM9tCdMnT6xJAEjQR80anEyXxqig2yQ1m8TKNNMk70qOMCa3gw839rfcQQwzYrGLwl+ue3XaXeMx8DOj4ingnrCGxYzLjEWKocm1X2ymN3DrIs4DwmWJtu8OFqraW4DkkptGMUK0UZIGPoryGIx/z53ji7KqLCHGxHG+vSd2BHnwaP5imNQCwC/mOSD7SQ1QgFeX6Y1+UHYdgCB4EU6C9Z9koohS0bQQvU0BzrNiaNVXgo1HfksuLiunNkj2FJSAkbx8u1okOnf16CNFX/G82RdwQBrtyUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcE3FY7b1AI7YTwrSZvhdmM4/kFWiiktdVViSggGEkM=;
 b=Gv9VU9moM5spU0wepEGLbrfh+utGyHa+zt4qTICiSK5hKYAXUoeGGgvev35/u91YPMwi2gjILaHLEPhbLvYVEcPndQk0H/eiEpejCu3bHyCmc48zXRkQIOt2t7JKEkHmiuj7vU9AcyGGXd2K/fbNShax3BIcnAyLs1IbSXVVsyRdiv0fIvWYQCSr/dWZowShaeF0yPbUyRFFuwdGZoxZ6HmMYGxnYX7F8xyyNpz4H9/QfIWpbEfEoaUDKb6BGVi8jiKzGQ7Ktqk3TxXMa20l1WJqI9YnMLOn96ZeDAKiv4zqR1JwaTtFpH6p+/AKLb0vXH7BszszXAF52n6XGgrCXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcE3FY7b1AI7YTwrSZvhdmM4/kFWiiktdVViSggGEkM=;
 b=5Cka5kyhygOXJvlmG1jbpf/7VGXKjEktlTyzv71cxm6VYakA3BrNu8D7/4uxAOAlOQNbaZyjuUcMdO8mDi6XErbnUUmtYIQ3qDbaqqK/KNOu7u8CqF9ABJUDW1SbsadIx8hTGYjIk7CFMDPBQhl8DP15k14ibfeRlvTOWL7MGdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Sat, 1 Jun
 2024 04:57:27 +0000
Received: from IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48]) by IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48%5]) with mapi id 15.20.7633.021; Sat, 1 Jun 2024
 04:57:27 +0000
Message-ID: <05d89881-bdbd-8b85-3330-37eae03e6632@amd.com>
Date: Sat, 1 Jun 2024 06:57:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 00/31] Add AMD Secure Nested Paging (SEV-SNP) support
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, brijesh.singh@amd.com, dovmurik@linux.ibm.com,
 armbru@redhat.com, michael.roth@amd.com, xiaoyao.li@intel.com,
 thomas.lendacky@amd.com, isaku.yamahata@intel.com, berrange@redhat.com,
 kvm@vger.kernel.org, anisinha@redhat.com
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <CABgObfYFryXwEtVkMH-F6kw8hrivpQD6USMQ9=7fVikn5-mAhQ@mail.gmail.com>
 <CABgObfbwr6CJK1XCmmVhp83AsC2YcQfSsfuPFWDuxzCB_R4GoQ@mail.gmail.com>
 <621a8792-5b19-0861-0356-fb2d05caffa1@amd.com>
 <CABgObfbrWNB4-UzHURF-iO9dTTS4CkJXODE0wNEKOA_fk790_w@mail.gmail.com>
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <CABgObfbrWNB4-UzHURF-iO9dTTS4CkJXODE0wNEKOA_fk790_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0344.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::7) To IA1PR12MB8189.namprd12.prod.outlook.com
 (2603:10b6:208:3f0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8189:EE_|PH7PR12MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ed1ddd-37f3-4478-747f-08dc81f75550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2pXbldVVkdYWHpGOHpzaUlpVUtaSUozc0t5Y016RnZMM3VxY05FdEh2ZUE1?=
 =?utf-8?B?YUxCTEtndGExL2YrRVhDeEVJemw3UjFaT29qNGc0OWNyWm1GbENMOEtBVDlr?=
 =?utf-8?B?Nk9xSEIvaVNHblF0eFFjMjVIZjNUKy9mY09YZVoxd1p4NmFtbnNueHZGVHB3?=
 =?utf-8?B?RVZPdGhIZktFQXZWa1h6QitQT0pEcVhtc0tyK2NNaXVpU0dyYmU5MWNNV2Iz?=
 =?utf-8?B?eU5sdzZHN0VFY2hlVGlFRkJ6SEY3eEU4RTJjU04xRUlvcG1zTGZSdENnMFJ4?=
 =?utf-8?B?NDBEbXR2VnNMaUk3Z0svZ0o2eHA1QXJBY2cxbXc1c2E3dWRhQUhpYVd5NDRD?=
 =?utf-8?B?bkpYOE5BRXNNYXJEUVBYV281VFVpSDNmOEg0Q1gzWFBvVE45VERXZERKMCs5?=
 =?utf-8?B?YTJLenA3MG52QzQ1WHRvNWV5M1ZmZnhlTWhSR0xsZERXN1p5VWpjS1l2aHZl?=
 =?utf-8?B?ZHpIelcyaDUzbHJKa1UwdUpTaytJYVMzVGh5SEM0LzQyWTcxR2lIYk8rU1VI?=
 =?utf-8?B?ejlhdk9VSk9HZkxrc3FBb09rdEdtZm9ZaS9GZnArakxweEtBUEZhaFZ0eXEz?=
 =?utf-8?B?VDJBM1g0bkNLbmkwUjEzR2E4TThjV0toS0dVWnc1TXBXZUhlSVJBdHVVY3JK?=
 =?utf-8?B?WmsyMGVlRHdGaFl2WVdpcGZiMGxJdmx3UkZlNENVcG9kUU9GU0ZVS3QzcWY3?=
 =?utf-8?B?Z3Yyc01jV0RVSmRGbXJUWGZWODJ0eHhSOTl5aFRLZ0RWNXM2Ujg3SlJLM2xa?=
 =?utf-8?B?RXRma3ZVWGVLekp5bHMwZTBlUC9sSkc5M0dCSFpXWWJ3SGVvZWJoRXA5R3pR?=
 =?utf-8?B?V0ZncDhvRzRqVUFFYjZVdXFLRHJPYndRVlJHWXordmFBTlZhVjQ5SFVZd01j?=
 =?utf-8?B?TUZLaVRtZjRRV1BrajdtZUovSHBUODdsSnZvSXVEMy81cFFtbkx4bGpXbWVM?=
 =?utf-8?B?bVprTFJKRVZlVlhEUkVqVER4b3NGcXc4ajllV2RUc0Y1VG1OYjE1RDdWSnJN?=
 =?utf-8?B?MDljTi9nQlNwQ2FVa1diaGJOMkFSdjN1Mnl2L1dEMVRqa0poYnZwd0dXMkcy?=
 =?utf-8?B?WWVnNEJtWEl1dWU0a2prcWxFMHhONHdxMTAwdGw5TnoveXdFNm5vdGtYdXAw?=
 =?utf-8?B?MGJaVFc5UUNobFFXQ29VMWZ2TnBScmkvTVRVeVJJT3JKS3FNZ3NJRFJsTEpI?=
 =?utf-8?B?WW55aW1hQUl2TEl0bUNraEhtN0xoKzN4d2U4MXN4NmFDb2o1eGxqK2xrTVFv?=
 =?utf-8?B?bFJOWmpwN3hvcmxIVGxnWm5XT1BYVEozMGtKdmplbkZ6MjZRZ0FLM253d1FZ?=
 =?utf-8?B?dXl4UkJsSXpFazFIUEpFbG9MbGNGWFBaVzdubjF5NWg5anNIYldXbjNZWWd2?=
 =?utf-8?B?VGR3WTcrNkdUbzdpQU5GeGR1L2dSQ0hxblh0WHJlSTZPWmg3YjdleXlSU2VX?=
 =?utf-8?B?UkxqWGxYSlNqN2FLY3dzTmlxSHVrL0swdXZZVTAvMStIQk1tcndacUdjL2hl?=
 =?utf-8?B?K2U0U1MvZFZuNTMxYU15TkdEZjJkd2RVWDlFM20vVDNxU3VhQ25oc29ZZUUz?=
 =?utf-8?B?SU41V1hWNFgxY2w1KzZOOVgvVUZ0LzFqeFphYjNSa1hXM3VpTXQ4VDBIa0Yy?=
 =?utf-8?Q?oT6QmyHmHKOVoRkk8vnM7fOazue8rmAk2nz5RXOJNUcc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym80TUhHdjZ3ZVU5TGlFenh5MXgvSzNQc05qM0RTei9jOVIzdjFiMXNRbTN0?=
 =?utf-8?B?UWdjWkt6L3RBRjVRVnNtWE5jbWZJYVBtL2NYSXVDR2RmRTRla04xcVRJTzJT?=
 =?utf-8?B?ZXkzcFlpUG8xTWp0YS8zbnJNVk9OVUNJYThwRzQ1Wk5uZURmN0FpTmQ3STBi?=
 =?utf-8?B?K3V4ODBpcTJabEh0eG9ETU5TMUVTSzNLdnRuWmRkamE0UnVjdHg5Ylpxd1dX?=
 =?utf-8?B?cVpqL2pEN0x4YWZ0QmZJS05Lb2xOSFYzdjE1TGdUOXRTS1hiZ1NvcGVlMmQ2?=
 =?utf-8?B?RUZ2cDg4bTh5YlFzQ0k1UnhHdGRLUXpkaTNFb3h3YkZaazVRZVRseXlSUjRE?=
 =?utf-8?B?bnZ6TXBpdGxtd25IN2Fnd3VSSkhmbHRuQ0oxZjZudmU4SnZETDFpc25WN1dP?=
 =?utf-8?B?NHdWME1xNFVaZTJKdTdqS2xVSml0a1E5Mjc0UzNtV3RPcWZmQlFLbS9oYzEw?=
 =?utf-8?B?OGtONDMwUGtpeDRUcXVxNnF1Y09zVUxRdEZaaW1qRjF4bnVNTGowZG5zNWxH?=
 =?utf-8?B?bEtxOFNCMUNtb2ppMDJrWXNzdC85NTJFa2M2MFpKVTFhc2pyLytaQmV6WDJj?=
 =?utf-8?B?QWZ3U0xYaWVVSEV4VkJUSGo1NjB2dERSckFTYmVFeit2d1MybENSVmp3TmpN?=
 =?utf-8?B?ZkpiVDF6VE9nMjVZWUN3M3NZUWpuTFlUcUEzTHNHeC82Wjh2VHpXdkZzZENa?=
 =?utf-8?B?dUpXeVl1KzBSd2pPekplU1U3Yi80TzF5NzZmMzZWVWNpWTBhSTVPV0pzT2Nk?=
 =?utf-8?B?WWNwUHFiLzB4bGVaT3VCdDdQK2ZxMmwwSmpFOFdnSDVwdnd0ME1ONmtkVktm?=
 =?utf-8?B?aVZNUnJ4WnZIYXBzeU9pc3psZi8wcDYxdkhjYm1mUXhNdlV6aUhsR25RNG1N?=
 =?utf-8?B?RHVRY1FYNmh2QjUrQWE2NmdtamExK0E5M3NQaitBQytnSDk1NXB6UmlDK3Nl?=
 =?utf-8?B?ODRLK0xOemUzclR4M0JZcE00ZmtBVUhqM0RZUUtSZGRPQzlJbDJuYjI3MTAz?=
 =?utf-8?B?d1UwUVc0K0RQNWVvTUl2Vkx2R1lOYVZoRkFBeGZmN0QyYlNXR08xZlNmREM1?=
 =?utf-8?B?amhwa0dySGpsRXNzd25RUzd0TmlqMUtPbm95S1V6R2dRNGJsVm5UZnAzMm0r?=
 =?utf-8?B?Q0lWbktOQ2tSSnhIMHRPK3dySmE0Q1FFNUhBSnFXQnEwbmZQdEVNajBkUnNt?=
 =?utf-8?B?NTdwOHp5d3RVUmFDYUNPUlJYT1Y4NElyMHZ1NXNycDBUeU12bVRzYTV0REJk?=
 =?utf-8?B?eUlqL3RmVnFKaTFzOTVMVlZpUHZ1ZDdjUVdyc0J1NGN0Yk9QQkI3TkRkdGhq?=
 =?utf-8?B?K2NLeGs2VTZuaS9nZkhzcy9pZU0xd2JlVlV2QTVUd1pNT3R0bGtxNjRCd08v?=
 =?utf-8?B?Nnkwbm9RQkRvQ1IyZ3gwQjN1MmRYZUhNNFJsM0RqR1k4bUVVYU80SjRHWDFL?=
 =?utf-8?B?SkxINlRTWXJXTHRXQ0dNejI4YjFrMzNPVytuMHpjTWNiTWFhK2JHZXJVUGVZ?=
 =?utf-8?B?UlQ3b3YvZkZnY2FRODA4ajlCeHhrcnhNcDJMZGJJREJhK2FIY1RLdzVNcjcv?=
 =?utf-8?B?aUtWZHIzS0dkOEtUc1VRN1NaUHJpMllMbWlnRFQwRWxGZVIrUGVHVWcrUkZn?=
 =?utf-8?B?VEVVVzltNExoc090UW5IeFBJOU9ZQUYrV1FJU2pLTkI0Y21hU3REeFJ2RzlY?=
 =?utf-8?B?WmQxS1dZcmsrUGMrR3pDQnFCVXBPaHhZYWFKamVxb2FiNXdpbmNEVXFETFFj?=
 =?utf-8?B?NUR1bTNkVFp1UXJmVm5uRlBqUjJ5ZTJENmhQZ3luY0dvZDc5aTRPYyt4bzNm?=
 =?utf-8?B?R0tXS0JuMVJtYjZGaVJqczRrby9NdlgrRkQ4VlJuU3F4ZGp2VndsQStOa3Mw?=
 =?utf-8?B?ak51OVZIU3Uwb1VpU3ljV1hjUzIzZk5rOVpDRzhGd0M4T1FhWlYwZE9kNzRX?=
 =?utf-8?B?U2pYUzRCMitaMGdlTW4wKzJTeCtQb2VkNzVzSndTeWpMMHVqenZVOEVCbEIy?=
 =?utf-8?B?eEgrVmJkR1dZanViU2tnaDZFRzBzY29SOUJlUEFrRkhuUFNwTHRsRWJQUmFK?=
 =?utf-8?B?TnJxdTJVRW5YZGdFMWgxdzNUWmJyU0JCaEFScjJYMy9FbGZLcURRVktlZjkx?=
 =?utf-8?Q?ZtLhfC1c1Ki0FpxEpqMSGwWYg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ed1ddd-37f3-4478-747f-08dc81f75550
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2024 04:57:26.9696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqCBSEeaT82zjFDyEkapP7+K316X++3croIkt8JWP88qO9eIga1QTgHgv3xcdn1S/b4zFieEZA+IJM1jAWf+ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665
Received-SPF: permerror client-ip=2a01:111:f400:7e88::61d;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.299, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Paolo,

>>> please check if branch qemu-coco-queue of
>>> https://gitlab.com/bonzini/qemu works for you!
>>
>> Getting compilation error here: Hope I am looking at correct branch.
> 
> Oops, sorry:
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 96dc41d355c..ede3ef1225f 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -168,7 +168,7 @@ static const char *vm_type_name[] = {
>       [KVM_X86_DEFAULT_VM] = "default",
>       [KVM_X86_SEV_VM] = "SEV",
>       [KVM_X86_SEV_ES_VM] = "SEV-ES",
> -    [KVM_X86_SEV_SNP_VM] = "SEV-SNP",
> +    [KVM_X86_SNP_VM] = "SEV-SNP",
>   };
> 
>   bool kvm_is_vm_type_supported(int type)
> 
> Tested the above builds, and pushed!

Thank you for your work! I tested (quick tests) the updated branch and 
OVMF [1], it works well for single bios option[2] & direct kernel boot 
[3]. For some reason separate 'pflash' & 'bios' option, facing issue 
(maybe some other bug in my code, will try to figure it out and get back 
on this). Also, will check your comment on mailing list on patch [4],
maybe they are related.

For now I think we are good with the 'qemu-coco-queue' & single bios 
binary configuration using 'AmdSevX64'.

[1]  https://github.com/mdroth/edk2/commits/apic-mmio-fix1d/

[2]  -bios 
/home/amd/AMDSEV/OVMF_CODE-upstream-20240228-apicfix-1c-AmdSevX64.fd

[3] Direct kernel loading with '-bios 
/home/amd/AMDSEV/ovmf/OVMF_CODE-apic-mmio-fix1d-AmdSevX64.fd'

[4] "hw/i386/sev: Allow use of pflash in conjunction with -bios"

Thanks,
Pankaj
> 
> Paolo
> 
>> softmmu.fa.p/target_i386_kvm_kvm.c.o.d -o
>> libqemu-x86_64-softmmu.fa.p/target_i386_kvm_kvm.c.o -c
>> ../target/i386/kvm/kvm.c
>> ../target/i386/kvm/kvm.c:171:6: error: ‘KVM_X86_SEV_SNP_VM’ undeclared
>> here (not in a function); did you mean ‘KVM_X86_SEV_ES_VM’?
>>     171 |     [KVM_X86_SEV_SNP_VM] = "SEV-SNP",
>>         |      ^~~~~~~~~~~~~~~~~~
>>         |      KVM_X86_SEV_ES_VM
>>
>> Thanks,
>> Pankaj
>>
>>>
>>> I tested it successfully on CentOS 9 Stream with kernel from kvm/next
>>> and firmware from edk2-ovmf-20240524-1.fc41.noarch.
>>>
>>> Paolo
>>>
>>>> i386/sev: Replace error_report with error_setg
>>>> linux-headers: Update to current kvm/next
>>>> i386/sev: Introduce "sev-common" type to encapsulate common SEV state
>>>> i386/sev: Move sev_launch_update to separate class method
>>>> i386/sev: Move sev_launch_finish to separate class method
>>>> i386/sev: Introduce 'sev-snp-guest' object
>>>> i386/sev: Add a sev_snp_enabled() helper
>>>> i386/sev: Add sev_kvm_init() override for SEV class
>>>> i386/sev: Add snp_kvm_init() override for SNP class
>>>> i386/cpu: Set SEV-SNP CPUID bit when SNP enabled
>>>> i386/sev: Don't return launch measurements for SEV-SNP guests
>>>> i386/sev: Add a class method to determine KVM VM type for SNP guests
>>>> i386/sev: Update query-sev QAPI format to handle SEV-SNP
>>>> i386/sev: Add the SNP launch start context
>>>> i386/sev: Add handling to encrypt/finalize guest launch data
>>>> i386/sev: Set CPU state to protected once SNP guest payload is finalized
>>>> hw/i386/sev: Add function to get SEV metadata from OVMF header
>>>> i386/sev: Add support for populating OVMF metadata pages
>>>> i386/sev: Add support for SNP CPUID validation
>>>> i386/sev: Invoke launch_updata_data() for SEV class
>>>> i386/sev: Invoke launch_updata_data() for SNP class
>>>> i386/kvm: Add KVM_EXIT_HYPERCALL handling for KVM_HC_MAP_GPA_RANGE
>>>> i386/sev: Enable KVM_HC_MAP_GPA_RANGE hcall for SNP guests
>>>> i386/sev: Extract build_kernel_loader_hashes
>>>> i386/sev: Reorder struct declarations
>>>> i386/sev: Allow measured direct kernel boot on SNP
>>>> hw/i386/sev: Add support to encrypt BIOS when SEV-SNP is enabled
>>>> memory: Introduce memory_region_init_ram_guest_memfd()
>>>>
>>>> These patches need a small prerequisite that I'll post soon:
>>>>
>>>> hw/i386/sev: Use guest_memfd for legacy ROMs
>>>> hw/i386: Add support for loading BIOS using guest_memfd
>>>>
>>>> This one definitely requires more work:
>>>>
>>>> hw/i386/sev: Allow use of pflash in conjunction with -bios
>>>>
>>>>
>>>> Paolo
>>>
>>
> 


