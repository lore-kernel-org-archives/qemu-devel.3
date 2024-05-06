Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235B0C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 10:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3vG9-0001pD-KG; Mon, 06 May 2024 06:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s3vG3-0001kH-88
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:07:43 -0400
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2417::601]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s3vFv-0005sq-BH
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:07:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2YY2dyuV1yKjSiXLhOV7QswYAvoGNr+3ckh5S20+jQwWISjGjlI9Osu8DpwI2AjNBe+GbKP95vqtUmq5Sko/ewvvpKhZ1yQ62/dMMkRDy26BgxMob0rLBw19lzbNe5CvsEiil5CXZDyReWjw8oT2FTVxYFMoHJtRr+KrJXmGIaKFxZq+fgEmTL5HfiRudIsANU+vMpAnVdud4s0JJfk2bOMVYbMj3gfr2wnn58LiVslpTDnFWZjroeaR8V0OSWCNSu9KbKwS80t9ZMFqe0lJNMO0CSpb6yoFXL+z6gOqwby7pUd8JHAJalWO7oh4+AmVmtXtczAnaixVprPAquKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41jLKEhCz5VBmAnZg9m8r8InCFpgBbVhn2QcHVl78Ls=;
 b=e4ELVzZynMJ0K3CRjTHZ/Tc0ipsDsFsrQGH+wD2knIllmTPeUraIhiclXxEfW+vwWsawZStLqUFI7XgRexvg+GwBXHJiluwFNKF1lab5x0WsK4h4iAfOk40Fv4/3jn2yxlTBluO7ZqaYgAlSQIRJ5DJAQZP23C7rPEpFUTQdi/u3frN4K4Fa3MF1if8m/kqnbJSGYogsNVa6Zwwo9LD/JiQG/1NGt/2WqZ3586yk+EQBEDU4KjRtsqJbv0axjVde46bDtc5vkMauGKtRcvtFVa7VFwzGCWoPRBJZqHTImabznoK5VtikhdctqWrGejmUY7mipCaGQeP9XuHMRgOVSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41jLKEhCz5VBmAnZg9m8r8InCFpgBbVhn2QcHVl78Ls=;
 b=O/TWrRA46DxmqgVFF+4lJG4BeRIvUOp+MmBd2hguJoTJo3pfaNsXgslYwMsKeXgLsRVXZt7FkeGZ9SV/QCuXQW9V0vVO+siEnTaFtCgidd+/RN7+hYA7m7bKRv+8FrufE50v9IU4g8a3O7i8AHDNEjt11zzJIO69LD9xFBAuxz7ANuYElawkq77rZX5IHm9jwUf/t+yIEZJX+5OO9goyi8iwjthB0kbRWTQgsplv2QZq31nwCJH1JLEdLd+3u2dwDqrZe9XJvozSIUdkVBcvSamlpvKSBKPTGXmc9NAL8DZ2Qk1Lc7+MEYDx2AvWfIFNV7mUpJrSz1FUD2CgoCtdkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ0PR12MB5662.namprd12.prod.outlook.com (2603:10b6:a03:429::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Mon, 6 May
 2024 10:07:30 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80%5]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 10:07:30 +0000
Message-ID: <d3eca5c6-f156-41e4-a160-1fc26e7c0e21@nvidia.com>
Date: Mon, 6 May 2024 13:07:24 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] qapi/vfio: Add VFIO device migration state change
 QAPI event
To: Markus Armbruster <armbru@redhat.com>
Cc: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20240430051621.19597-1-avihaih@nvidia.com>
 <20240430051621.19597-2-avihaih@nvidia.com>
 <fd972eee-068e-489e-ab45-e1985115a128@oracle.com>
 <703aab34-1704-4ede-8398-17c0137f6e17@nvidia.com>
 <87ttjbsfrs.fsf@pond.sub.org>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <87ttjbsfrs.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0637.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::14) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ0PR12MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: 71bb551b-d4fe-4a08-fb1c-08dc6db45730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3poc3NhS2kxay9CK1B1a1V6UDhXd0pIMFc3Y00vNFlkWkl0Zk96QUttVDB6?=
 =?utf-8?B?ZVNlNHJVdzkzNFVadnBGY2Q5NFc0OTJtazVBS1c1L005dmM5czF3UUI5WmxR?=
 =?utf-8?B?RXkzRG9CTU80YXFoK3NzTmxXK3NRRFpMaUhZZjBtc0dFS1BxU3NDeHpXMXFE?=
 =?utf-8?B?TXZSSU15WkY1TWJTR0Q3TG5vdllTZnVSTVV6MG00UFh6Vmc2c2xaSXNqbng0?=
 =?utf-8?B?V0ZXQVgvYURMRTJ3NWhueHV4WXJEZmJkdTVmdzQ4Z0pTcnYya1hBSG9nVVVG?=
 =?utf-8?B?ZjVQalRQc05qLyswMHBXZHdmN2ZFTVRTb2JXYStOUE5xMThKSUxCREhoQlF4?=
 =?utf-8?B?WHBGZ0pEblhtUm1vWllDUmFMTDhZYlBxQmdreVRxdVhVcTBoSVpHTU1FMDJa?=
 =?utf-8?B?Uzhwbmh1azJCK014clNDengzRXRqZlZxNnpTVCsvcnNRL2NUenpUYnVrZDBX?=
 =?utf-8?B?WWJpTHFCWWcrQVY1NXYxejdaV0NXcHJNbVMrdzhFK2o2bWZWRGFqMVNBazAr?=
 =?utf-8?B?b3ZURm04MHB5RDc3R2JtcHA3YXRXTm94S0M4MWZnbjM0Z3Vna3V2cExNdjBY?=
 =?utf-8?B?U1RZSDRDU2dEN0VRd0VwM3FFTUhMbUF3djlPbm83ZHJuYjIvdGxsSzgzOW9o?=
 =?utf-8?B?RG5WZmFwV3Y4a3ZOUkhPTXhGdnZ0d2tTd05sN1hIMlhRbmwwdEZYbjhaSFRD?=
 =?utf-8?B?TzFqaXVFYkZjRjhpcStpVTRqQnRPV3d2Q2NKeHpWNHprMkxZOGZKUkVsb3N5?=
 =?utf-8?B?WVkxaWIrQjJMbnljNHJpcDg4QVFJakhQWmRHSkNKVW1XSVlnaWlJd1hOblVz?=
 =?utf-8?B?U0dpT1VSNUcrdFZxSnRoNWdzTWRBU1g0ZG9UOE9JTGh4a2RxT2tZSXhlT1VO?=
 =?utf-8?B?SlpjWDJRUFFFRFp1NVpEWlVWaFc1cUJ6alJqeHhjR1JlU2txcE5hVklScUR0?=
 =?utf-8?B?N0R0emY3bGRhRzN3RkxodFdsb2xTd0QwcWMxMjdXb0lST0x0VGx3NG1ieENB?=
 =?utf-8?B?eUdGS2ZwbVk4RUlwLzdxWVAwaFpNczV5MlJQeDIzdkkvOGJEcWovZkEreVRU?=
 =?utf-8?B?TmVpU3RlTlZ2Qkp3bWVSWFRoNTROdTQwNHdDREVGYWtlUjkwNnNTWVROUnVr?=
 =?utf-8?B?MlRIRVgzcW8yaWEvR3kyM3RqQytCVE84eGFhSGtodG1rMEdMTHJvWnVUSzlI?=
 =?utf-8?B?UGVqUkRrTlBXTzQ0ZFNkU2pKZTNQVThxOUlSdFdLTmIwSTZjQjJEKzFFY1Ux?=
 =?utf-8?B?SWRENmZDL29CTmVuL2dsekhpV1ZQZ1JYd05oNEV1YWd5OU43U0dpMFVPa0tD?=
 =?utf-8?B?SUdSVFZVTTg5T2JVK2tPVFRHL0lJRkIxNzNIc09IcHFHdTJhc2ZueG1EVXRq?=
 =?utf-8?B?RGl5WVROc1BaMXlKalQvc1dwSDhiS2FxZUQweXBHOEdUZEdRV2JQazR3cFVK?=
 =?utf-8?B?cm91UHJoU1hObWNLS2Vka2VNVHl6cURoVkZCR25TRG9ueHhmRUd5M0cyc1l5?=
 =?utf-8?B?ZE83U0ZVUThUOS9JTDJwNjRVajFPSmo0dmRHbkMvZUhUVU90bXZuU2pGU29t?=
 =?utf-8?B?OU1QWThsekVuOEM5Vkx1amRpVlFQT3llTzN4NnF0VTd6aC8rV2M2SG9TSmY4?=
 =?utf-8?B?VElZR05GSHJTMVNoVFRmV3ZteTJCeU5Ja0ZrL1dtWUJodTZDUVVaSXp2V1cx?=
 =?utf-8?B?MFRTVkJZODMzTG5hOFo0c21mZGE3eFo1VHlzKzdLQmZLbFdxV2JnWjFBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUM3RmhFc2s3WS93VTJ5QVhrUUdnQlhkcU00b2NzMlBKNTBQZEE4TnpKancz?=
 =?utf-8?B?UnJ6NkpjUnp0VDE0SHFKeDhLdk8rbnJranN1SlN6WHFDa3JtZEFBLzFoaXhu?=
 =?utf-8?B?MVFPVjhyV0xibGdYREJYU0hRNjkrL29INkNlRzQ1OVhWTW4yOGVtaWs0N2hH?=
 =?utf-8?B?Uis5VDRuOVlJNkJScTNNUGdCTVhPNHFHR3h1QVc0UDdOeU9VQTlDMUtCdC9I?=
 =?utf-8?B?R25mWUVlVS9Sa2wxbDFkU1BqOHZXQnpYYXE4SFpLdTJZNk04Sk9pams2MEVL?=
 =?utf-8?B?cW11bW9jRi9yMXlrWFFRMm1YMzFGdEFUYlRmMkNuNWx6cXo5blhaNmVZQVh2?=
 =?utf-8?B?aU9sazdyV2FUMkxoRDRmU2R3SjV2bHlXVHVHNDV4K2lKTy9pZWtWZWVOdWhh?=
 =?utf-8?B?TTVxR1JoQ2xnZEF0THI5KzZMcXA2Tm1vbVBwUkczaS80dEhYUFp5ZlRRVkRU?=
 =?utf-8?B?WExENDRMQTg2VFVKUStZTmwrcVpxMWNZbFlFSXVldHdNaEMxbk81T2JUNHFZ?=
 =?utf-8?B?UjVUSzBHaEtnYWt0Y1N0Uk9wWUhpWVlIbExEVmJtdldwdjdTTE9rQ1FnL3ZX?=
 =?utf-8?B?U1NkRzlKQUNIUXcxZ3kzeUhtdnB0QVE2T1VlZXVuSysyZ1Y5YXRKQnRjOUFP?=
 =?utf-8?B?WUk1ZjQrS2VXMy9tZlF1UEd2dzd1Slk0N0RhTEd1UzhEaGwrSmtSajBFYTAv?=
 =?utf-8?B?cC9aRjdaZEZ2UklNN1Z5Tm1iVVFUUDcrREd0NTA2VDhUcytabWpwYnRJNGZ0?=
 =?utf-8?B?d3BUVWlkTDFpTi95RGtFbjd2eDBMSFp5OWZ1alBXcGk3R3VsZVRScDFoa01K?=
 =?utf-8?B?WEZyblV6aURLTWRpZmVySm1CODN0K3pvSlR4QzRnWXpiVmxMMUh6cDR3ZWlr?=
 =?utf-8?B?MFQ4UEJkYjc3a3pCZE9nZmcxRVNRQWF2QWtvd2ZHRXRZRVlrSVdOOEtZajIy?=
 =?utf-8?B?VGN4RDNnUWc0VzBXU00xYXNrbktPRzFtWDBzODU2VC9VakxEdW45dk9GSW0y?=
 =?utf-8?B?VDd1aWhmLzUreEhLWFk0a2h0SXNkNHd6UzN5Sm9sM3lWeERCa0hzZ1ordUlV?=
 =?utf-8?B?TUVqMi8xSDVCNnUxRFpjTWVmQ2VkTXAxUWE2R2Evb25GeGZRVXBwSjF5TEcv?=
 =?utf-8?B?bjMyREc5NGlseTdVZVgxNkY5RjB1VzRnZXBHVjNSQTAvRGxNTnY5RTlPY0lo?=
 =?utf-8?B?cXBzQndRSlhrTVRmL2xWOHJYTHlnWTh5N2h1cFR3TlNRNkxBRlRpaWwva0RR?=
 =?utf-8?B?RTVGUm9GQkttZ3BLMW5DY0ZtT04vU0NrU0p1eEZZR0E2aXdmTXFJcTNCeXU2?=
 =?utf-8?B?cThubGpVSFJKUGdsdXRFbUl1bHlNeWlPbm5GdVhzUEo2NUswVHR3c0ZkbDA3?=
 =?utf-8?B?aXhFaklGZVExUk1yelVveFE5b05QUGRDOFBBYWRFT3ZFR2J4blZ1NTBxTnM1?=
 =?utf-8?B?d1ZHUXZ4OTRpWlV1THpHZ3RyMFVMODdNUEpESjNWNExKTmgyLy9qZm5oL05O?=
 =?utf-8?B?aTY0c1hkMmpBYllwZUxzb2VjM0ZXbUhxSVM0amdOVlV0eGxtRG1oMjc4K2tT?=
 =?utf-8?B?QUdxK041b1Y0ellUVk1IOVFWRElBOER6NEFyN0FYa1lXbVAySXJZTk5HdHJ3?=
 =?utf-8?B?bERZbFEraEhwVS80WmthRGgraEw0RXdxYWNFL1ZYRXkvdFI0TUtKbTdwOW9R?=
 =?utf-8?B?Z0F4ME1mb0ZiSmhSWjNuc2I3R1VCa2RRRVF3QitKL1pBUUx4dXYyZXlzWkpo?=
 =?utf-8?B?R2d6OFVJT1lnQlJob3pNUjRHcklybWFiVVdpQ2xhMFFyOXZzR2pYT2piWkE3?=
 =?utf-8?B?VkZ5WnJQY3BlRHRxWTN5dyt4YVVEMUlsV1ZoUkdFdWxQMVdJc0FPMk43ckJs?=
 =?utf-8?B?QjJPTmtmV05CNDJmUEN0M3NJblpvd0lLWmNMRTdzdzU5OGo0T0xDMG9WeVJL?=
 =?utf-8?B?dU1YK3VGVjl5N1dZQmJiSkl4dG0yOGhDSElQN0hHeGUvOWlZa0JNdUlSN3F5?=
 =?utf-8?B?UCtWQ1RBOGJrVHlyc21DaUU1Q2JaR201dFpjZmZsYW1vcXlDU1paNmR0enMx?=
 =?utf-8?B?RHIzTkMxNmdXOS9wLzBZMnY2aytraVlrY1dsTlZzeXBhSGZ0NjlORTVQNzRo?=
 =?utf-8?Q?eadqQ7omuM+LORMJzixyLgwVt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71bb551b-d4fe-4a08-fb1c-08dc6db45730
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 10:07:30.5945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYk5X909t6yOCbmU2tdzz+5CbCufz4hWYmkXjS3LaeMEHSlE9jF+pQr8Y5iNJ/WFR7sxY6t9kJIEZYyeGfTwvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5662
Received-SPF: softfail client-ip=2a01:111:f403:2417::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
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


On 06/05/2024 7:52, Markus Armbruster wrote:
> External email: Use caution opening links or attachments
>
>
> Avihai Horon <avihaih@nvidia.com> writes:
>
>> On 01/05/2024 14:50, Joao Martins wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 30/04/2024 06:16, Avihai Horon wrote:
>>>> Add a new QAPI event for VFIO device migration state change. This event
>>>> will be emitted when a VFIO device changes its migration state, for
>>>> example, during migration or when stopping/starting the guest.
>>>>
>>>> This event can be used by management applications to get updates on the
>>>> current state of the VFIO device for their own purposes.
>>>>
>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>> ---
>>>>    MAINTAINERS           |  1 +
>>>>    qapi/qapi-schema.json |  1 +
>>>>    qapi/vfio.json        | 61 +++++++++++++++++++++++++++++++++++++++++++
>>>>    qapi/meson.build      |  1 +
>>>>    4 files changed, 64 insertions(+)
>>>>    create mode 100644 qapi/vfio.json
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 302b6fd00c..ef58a39d36 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -2159,6 +2159,7 @@ F: hw/vfio/*
>>>>   F: include/hw/vfio/
>>>>   F: docs/igd-assign.txt
>>>>   F: docs/devel/migration/vfio.rst
>>>> +F: qapi/vfio.json
>>>>
>>>>    vfio-ccw
>>>>    M: Eric Farman <farman@linux.ibm.com>
>>>> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
>>>> index 5e33da7228..b1581988e4 100644
>>>> --- a/qapi/qapi-schema.json
>>>> +++ b/qapi/qapi-schema.json
>>>> @@ -78,5 +78,6 @@
>>>>   { 'include': 'pci.json' }
>>>>   { 'include': 'stats.json' }
>>>>   { 'include': 'virtio.json' }
>>>> +{ 'include': 'vfio.json' }
>>>>   { 'include': 'cryptodev.json' }
>>>>   { 'include': 'cxl.json' }
>>>> diff --git a/qapi/vfio.json b/qapi/vfio.json
>>>> new file mode 100644
>>>> index 0000000000..a38f26bccd
>>>> --- /dev/null
>>>> +++ b/qapi/vfio.json
>>>> @@ -0,0 +1,61 @@
>>>> +# -*- Mode: Python -*-
>>>> +# vim: filetype=python
>>>> +#
>>>> +
>>>> +##
>>>> +# = VFIO devices
>>>> +##
>>>> +
>>>> +##
>>>> +# @VFIODeviceMigState:
>>>> +#
>>>> +# An enumeration of the VFIO device migration states.
>>>> +#
>>>> +# @stop: The device is stopped.
>>>> +#
>>>> +# @running: The device is running.
>>>> +#
>>>> +# @stop-copy: The device is stopped and its internal state is available
>>>> +#     for reading.
>>>> +#
>>>> +# @resuming: The device is stopped and its internal state is available
>>>> +#     for writing.
>>>> +#
>>>> +# @running-p2p: The device is running in the P2P quiescent state.
>>>> +#
>>>> +# @pre-copy: The device is running, tracking its internal state and its
>>>> +#     internal state is available for reading.
>>>> +#
>>>> +# @pre-copy-p2p: The device is running in the P2P quiescent state,
>>>> +#     tracking its internal state and its internal state is available
>>>> +#     for reading.
>>>> +#
>>>> +# Since: 9.1
>>>> +##
>>>> +{ 'enum': 'VFIODeviceMigState',
>>>> +  'data': [ 'stop', 'running', 'stop-copy', 'resuming', 'running-p2p',
>>>> +            'pre-copy', 'pre-copy-p2p' ],
>>>> +  'prefix': 'QAPI_VFIO_DEVICE_MIG_STATE' }
> Without 'prefix', you get VFIO_DEVICE_MIG_STATE_STOP and so forth.  Why
> do you need a QAPI_ prefix?

VFIO uAPI already defines enum vfio_device_mig_state and its values 
VFIO_DEVICE_STATE_STOP, VFIO_DEVICE_STATE_RUNNING, etc.

I wanted to emphasize these are QAPI entities.

>
>>>> +
>>> Considering MIG can also be interpreted as Multi Instance GPU elsewhere
>>> unrelated to this shouldn't we be explicit here? i.e.
>>>
>>>           VFIO_DEVICE_MIGRATION_STATE
>>>
>>> ... to avoid ambiguiosity.
>> I used mig to avoid long names, but I don't mind changing it to migration if that's clearer.
>>
>> Thanks.
> We generally avoid abbreviations in QAPI/QMP.
>
> The event that reports general migration state change is called
> MIGRATION, and its data type MigrationStatus.
>
> We could call this one VFIO_MIGRATION, and its data type
> VfioMigrationStatus.

Sounds good, but how about VFIOMigrationState (I'd like it to relate to 
the VFIO state)?

>
>>>> +##
>>>> +# @VFIO_DEVICE_MIG_STATE_CHANGED:
>>>> +#
>>>> +# This event is emitted when a VFIO device migration state is changed.
>>>> +#
>>>> +# @device-id: The id of the VFIO device (final component of QOM path).
>>>> +#
>>>> +# @device-state: The new changed device migration state.
>>>> +#
>>>> +# Since: 9.1
>>>> +#
>>>> +# Example:
>>>> +#
>>>> +#     <- {"timestamp": {"seconds": 1713771323, "microseconds": 212268},
>>>> +#         "event": "VFIO_DEVICE_MIG_STATE_CHANGED",
>>>> +#         "data": {"device-id": "vfio_dev1", "device-state": "stop"} }
>>>> +##
>>>> +{ 'event': 'VFIO_DEVICE_MIG_STATE_CHANGED',
>>>> +  'data': {
>>>> +      'device-id': 'str',
>>>> +      'device-state': 'VFIODeviceMigState'
>>>> +  } }
>>>> diff --git a/qapi/meson.build b/qapi/meson.build
>>>> index c92af6e063..e7bc54e5d0 100644
>>>> --- a/qapi/meson.build
>>>> +++ b/qapi/meson.build
>>>> @@ -52,6 +52,7 @@ qapi_all_modules = [
>>>>     'stats',
>>>>     'trace',
>>>>     'transaction',
>>>> +  'vfio',
>>>>     'virtio',
>>>>     'yank',
>>>>   ]
> The new code is in the intersection of VFIO and migration.  Putting it
> into new vfio.json instead of existing migration.json lets you add it to
> MAINTAINERS section VFIO instead of Migration.  Up to the maintainers
> involved.

Sure. I will keep it as is unless someone thinks otherwise.

Thanks.


