Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DD9D1CA3A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DQG-0002fP-73; Tue, 05 Nov 2024 01:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t8DQB-0002Vh-Jd
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:52:12 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t8DQ8-0003S0-Q3
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730789529; x=1762325529;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=33Miaitj/x/0Ld6mKaxI5KaMqY98cVtdgWaB8kWYctM=;
 b=ezZ0w+a81hg/ekf6Jj/mnXOnhaTFSGG5zJ0CFNKv3/j9T0bWUzYfTL7z
 hSzF4FLlOqrCp4MBP/BO2wSGT4cfNVZECPZ6y8prm9WvcqFwO3ximFJd3
 z0LQpXbLm/Phk+JZeQ7wT13yKXnhq81QuYGYOUAEaVRu5usJR/GEINqcY
 G/vR5mcKTmhH8W5Be03PgmGZB414pQgNr6zOM5/ZdlJIl70iu2fA7hFPu
 a7xF3nQ5wheZnUbrsKeRQOnSrTQhSElsOz0rzXDg5KkLd7mxrT2uzKJnK
 ZYa6CHYC0TQPisie5fLfsMESQ42ng3JOhLlj69OlkkUuanSqINbk29CdB A==;
X-CSE-ConnectionGUID: rcbcMZCNQmC2qkiv/Zjk/g==
X-CSE-MsgGUID: hBOLUOKGQJ2w0AyDhE7BpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="34301583"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="34301583"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:52:05 -0800
X-CSE-ConnectionGUID: shfQ373fRtKuAwMfqPWPOQ==
X-CSE-MsgGUID: AUhM+bNiTvG2O46Sccf3sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="84713038"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Nov 2024 22:52:04 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 22:52:03 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 22:52:03 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 22:52:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/jq/RbGjavl0qGkr5V+m9E1+8V/biJgZmOK67c5YGHE4SqfzDrLSGWcK6DxTlHKqNFwNEVjfVWSN5CjH6cTqKb62ox5sitC4XWFQiN2zuwEx3xrzstWCnOCmIDTyuFj6Ajh6tQs+LqfY1ielctVjBgDghMxlLUc1kiG2TfgzkgQbSjQH7WQTVDbp43ZOXybEo5pYa38h5A7UARx62MshJ8/QMbnW0o+mBLz98Jl7rTnVSIAqsSy/2nFUmf2huuyAFlVhFjGloinywQAm+1UQ835pwY6a7EgFnn4nyk+miNTzPFy5o7lqYnCUEVYq7ylPUINGu31kI43SFJT6zvtow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMWU/GKV4XUdFFwYsHHCYbSapybYORwc5ziPNlAYmf4=;
 b=ozrFHLBKZbJ1BEwO+webrA5dbs0uB+j3nzYQC0YdXO61cnKKV9Ja6B4GOpHr69ivazq2VOxt/5t2wDY2UJIaKo2oQR7w2q01C31OMry8kHMYWXHwx3hZ9pRkeiFuxFbm/o3MvqmVJjYOLMo8AqFCH4ux5F+5f9EMiU1kF+8mp+iQNiaMDdBA/Mcr3A1+iy00MHSGOZtjqQsd1UwCXWdl3bDkMfYStvOSu4Bf4HudNfbmczYI4cRVR976URZDcW1RNe8gWaeA9m4EcT2RuRVWfPdyPYJIK2cA6j8T9y3dDhCcUbG0y4qPpwQjOR7XFw+pqMTvCON3mFoi/NaF8GaApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 06:52:00 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 06:51:59 +0000
Message-ID: <ac55daf3-c8ab-475a-bed3-2e3e3e8fb661@intel.com>
Date: Tue, 5 Nov 2024 14:56:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] intel_iommu: Add missed reserved bit check for IEC
 descriptor
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>,
 <clement.mathieu--drif@eviden.com>, <chao.p.peng@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
References: <20241104125536.1236118-1-zhenzhong.duan@intel.com>
 <20241104125536.1236118-4-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20241104125536.1236118-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) To
 DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CO1PR11MB5089:EE_
X-MS-Office365-Filtering-Correlation-Id: f5517193-0e77-49a0-a7d4-08dcfd66587e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGhhSFVNR1BwMVY4Wm0yQzBQOXdkSWdPRmR0cUpHaHJVbWdTR2pJZytEVFli?=
 =?utf-8?B?YVdKQUx2SVg4SFBMQ0pFUE1BMGF2V3BCazhnY0N5NE9lM0JnMVZwRlRqS1c3?=
 =?utf-8?B?RnRHU0k1K3lNR1dDNjc4WFRvUmtQUG1ZYXBsdmdUeGp6UjhEeUNTY1lmanVN?=
 =?utf-8?B?RW1xcjcrRGdIMndBcG13R0lZM280aWtvMnVlT0p0cTNVbDZMZ09iY0s3Q05l?=
 =?utf-8?B?ek92ZnlZN2IvRGEyNWdYbHREcHNUaGUxbWtpeGRWRWVEcWwwdlpHdHJkTytR?=
 =?utf-8?B?b1NQNG9xRFBPSldWQ3A4Zzlwb2IwZ1VTem1SandBV3lGcElmcFVTUkIwTVlR?=
 =?utf-8?B?UEV0cWpraUxkS2dZZTRTdS9LanU1dGN6cFhMbm5nVEczeCsyNHgrR0xDTjFj?=
 =?utf-8?B?Q3NuY3F4RjZwWWFCRE1QUXllTncrVzVGUzFOQWV5M01NaFNiMnRYY1FWK0xM?=
 =?utf-8?B?b2NyNXBZb0JpcHJ1SGx0aTJYZUNIK05UOVBYd3Z4eGU0Y2QrcFRDZ2NYZUFn?=
 =?utf-8?B?YjB0N1FCY09wckxpalVWK0xwTTRGWnJwdmVTazFjL3BJeS8zYUxlN0VNYUI1?=
 =?utf-8?B?ejdwaWVoTUZMcHpPTTFobk5Sa3NCdElCL1FmUlNWUllRN3luUGtNTWNGd1dp?=
 =?utf-8?B?eVRDUDRqTjlzQzR3VFhaTFpKb3B5YUtaNUd0ZUQ1bGpWd2JHclQ5TG9jWUEy?=
 =?utf-8?B?WmJwMGNmOTdmbVkzS2ljZ01hanhkd2YzcUtTblF3Z0J2cUsrLzdjMkl0ZmhZ?=
 =?utf-8?B?STF3Q2d3bWpxKzk3Vnd1UVE2TGZDdmR2QUxRNU5Qem5VYkI4ZGttUVgrSnBO?=
 =?utf-8?B?dVNmME84Z0JlUjJHb2JGRlBIUVQ5Y2sxYmUyeUt3RzFmL1JicU83ampJOHFM?=
 =?utf-8?B?ak9CZWxMSGVUR0RYVk9YbVFCcU85bjdZQ2c3b0tta3Q0NWlDaWd5ZlFWSGVz?=
 =?utf-8?B?aXJxKzR5cnpmTTg0SnFvalAvRkE2VnJqdEt5eXlwYXNJRVVLWmRVRTlzd2R1?=
 =?utf-8?B?MjFzVE8xcFBTY0JZNmtNREI5VzBuZGlMSWdsOGtZRHUrVHZXMUxMVEdvSDcy?=
 =?utf-8?B?ZFVzeHNmODRLcURWeU1ObDhVVlFrbnl3aithellzYm1ZZDF6R2NIQWxPaE5y?=
 =?utf-8?B?VWt4aG1FczM2RG1FUGdMWXAzQ1pkSGRBVWVIWGZQVmQ5UExSVUlmRStNeXRm?=
 =?utf-8?B?RSs0b0Vla1lnUHlYKy9ZTFYybjlpbDFGMi9VMkgwem90NmtnTnE5R3lkK2Z2?=
 =?utf-8?B?d1BJcndpS0UyZ1JZQzVsTTVTZ1huWnhta3dwUEdaZldBdGlkSnFtOHZhemQ3?=
 =?utf-8?B?dDR1dllMSzBMbHhYMEJQMDZ6ODFWM0xaZ3JTZE5YeE5YWEFCVU02a25CbVF0?=
 =?utf-8?B?QnhZN0xpZFNlRGdnWi8wbzhHdk5KRjh5dERycWRNd2JBVGo4UllROWNDMXdC?=
 =?utf-8?B?L0lwWDhsTDAwTGdxSStXVjFtbFFiWmVaVjRtSzZSN2pXeXYvVmJSUGxVRC9W?=
 =?utf-8?B?dVVnVkc5TEk3Q2FBcDJXa3FPT0hPV2ZYK1VRa25VTENTa2dwUEp4UWF0WkJr?=
 =?utf-8?B?dnV2UUh5aVBBK1pRTWZnQllzc1NWNFZMbTJlSXpKRXloS3FHdEo2MWNrS1FF?=
 =?utf-8?B?L0FPS09mSHJ2SmdJU0tiMnZBVXFpcFBweS9LMHVaUnJVWllWTzRzZGdtMUlL?=
 =?utf-8?B?VTdIWU4xdHQwcWUwQVNvM3JxcDFhNjlVWGcvckJPaitYRjdsOHZpNFIxWElT?=
 =?utf-8?Q?+M+SH/dOV/Gc+z4lEuTLJNIJjYIajOrIR6STNMj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWQvbDl5YVdrQlEzWStZU1d5VXZtYk9TTXlvVi9iSThzcTVoQXhoMEZHeHpl?=
 =?utf-8?B?V1E2SmRXVmpmYzJoZEIwWDI0UXNsNWE3UTBvQngwU0hwbVliUllPR2FoQzFr?=
 =?utf-8?B?V0FYYzRqemRwYVpVNHZBVFJqOGJLUzdOSC8xVGRXRWg4N2NlcWo1OU85YnRv?=
 =?utf-8?B?TmM5bU5EOE9MNVZTOEh1c1djV0xhL29PdUh0SUlzMUFRNnplNDMyMUF5ejdp?=
 =?utf-8?B?WEZ6bEVqbTF1SWI0V2JpNW9sQ1JiOWplYlJUd28yVWZwMlgyUjZrRmdrVUlP?=
 =?utf-8?B?aGYzU3prczhGVGo5NXlvelBxQlJRTmlQY3NSU0ZoTktUZWtsY2c0VzY0QW1m?=
 =?utf-8?B?S3dNaUVzamZUN2tMNFJucko4dlBiNTBQdHA2Y3ljamdHNlhrN3o3b05KejlL?=
 =?utf-8?B?N1RGZ1Y4bStmMnNSUERTSjMzbDJ5QkNxalU4aFlGQlNoT0lHMjNBUmFlTk5I?=
 =?utf-8?B?bFBWRGZ3Y0ppVTd4Q0ErL1kwVWdqaU1QMEZJSkJjU0tKcFNDZSt1OE5oWk91?=
 =?utf-8?B?OENldjllQjV4Q2tQMjJRcDRYM3JxTjdRWWJ4S2swNCtnaGd3cGNXOFZCVC9O?=
 =?utf-8?B?L0JITUMycWFuY2NobTJpSVJMb3lOeGt0R242ejNXTW01L0ZRZ0xJSDlRdGov?=
 =?utf-8?B?VEN2RHRGRWdkOTNOQVRyNENJWnN2NTQ2SEl5N2ZxaFRzNndpUnFEWnkwY3Nw?=
 =?utf-8?B?aHpxVWdkSmtheVZHWUIyVThGbU5RUU9waGdubmE2aWFXN01KRS9tdEt2czlJ?=
 =?utf-8?B?WS9LSWFoaVhmMDZnaXFSMmI4bXE3Rm9zOStVWnRZSUpJQ3BVVFprbHJhdUpk?=
 =?utf-8?B?cHY4K0x2d0prZ0pENzlnNlZwOThsV2ZTbHVYTDE0QTVVbmxxYUdTZXJ4emU0?=
 =?utf-8?B?bUVKQ2NmNTduQi9BeWR5YlN6blQ1c0wxR1hXR0xzMkhiSGJ5cU8vOFJmUVI4?=
 =?utf-8?B?K1diL0s5T2Z2cVlYU2hXTnlVTHVLa2UxSk5zODJ1SVJsWjJBeVByY2g2MnB4?=
 =?utf-8?B?NWtKblZ1YitUZFo3R2xQY0VWYlNVSUxndnoyNkpTQUNaU216RnNjb1UxbTZQ?=
 =?utf-8?B?aFphSVV2a2h0eVJ1SFlkN2k5bm8zcHVpYUxxVjRyQnZwaGtwNWlHYUlSRitU?=
 =?utf-8?B?djBSY2NpODVSSGpxdmhRZjRsL3RyVm5QZ3h5aGZjUkFEMFBLMkdFZVNSb2FQ?=
 =?utf-8?B?clhvam5pSVhEM2J3RnNkbjJvdU9FSVN3NFJOajhPS1JRMjFnMjdYUkZzTkpl?=
 =?utf-8?B?OVZ4WGZMM3N0cGV5K2V4S3ArQVBKdnAzVXJDcGlSQ0FpSjVIeW1UMkZjQUlQ?=
 =?utf-8?B?YTMxN3VkdW1PeU9lWTNkdGdWV2VycGY1UnZaOUx2d2paWFRTdEt4SzVYVzlH?=
 =?utf-8?B?K3BCZEdQSEh4R0YxZllhZjJlZ2Jmek8wMDVpMXMvRGM4UTRUaFg1TGpwVTBu?=
 =?utf-8?B?L1R3dWZyK014cDc2U0tMYXZTLzIySjFXaFF6Q2hHUFRwU3VmWDZzOWdVNkVY?=
 =?utf-8?B?U2kyRXFxM3ovMkNJN0ZRTWRyNG9kZk5qUGpaUlNZbmM2RkZoMTEyajh5c0I2?=
 =?utf-8?B?eGNRcmtZZDI3eGRlejhOR1RVdEtaaHpSc0dDcytZTkZwZUN3VzlUNmVYV1Zu?=
 =?utf-8?B?S1A1T1NFcXk2M2xTREFYMXNrYmtUVUNBdHUrQ0xyQWJGWURBTTErQnhpanlu?=
 =?utf-8?B?ODB3bGNzUEJyM1NVUlcyVFZBMVQvUXNkR1BrbVlHbytydm00eG1FSzFjUWxX?=
 =?utf-8?B?YkswWlZxby90cDFPSm4rczRkbXNidnduTmxYbjNLUGtld2NUVzJCNEtncUhu?=
 =?utf-8?B?T3J2NUNmZktiU0w2TmhwVnBjMkw5TEJTN090N0Z1a2lCN01aZ3Znd1FoS1dl?=
 =?utf-8?B?eTZuNmZLcU5taURNRFJ1NGRQV3NmMXFtZjZkZGlqOEFsd2U2K0Q4OFhqMVg4?=
 =?utf-8?B?WHJtNkd3R3lIejlrQUFFUTltMjhBbnR4ZWJlSit1ZCtBYW1GaDBxUWx2Ymda?=
 =?utf-8?B?b3RPSlRMNE1wRmVQcHJtU1lzU1R4bXhROC9XZkt5RzQvbWxDS01ncXg1Qksx?=
 =?utf-8?B?SVRFaTR4dDBKeWNiNzRiejRsMnE5dWJHM2dmRERsaDFJOTBrdFhSYXBRQkVC?=
 =?utf-8?Q?SYPPW6WFR+32WXKR83LPKY1F8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5517193-0e77-49a0-a7d4-08dcfd66587e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 06:51:59.4096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdCfpgbvHk75xluBVhGlMB96TUX0DRGvbEjVfqUcQFo6Lvy54eE3rS3cYTStzfSzlOPCRj0QajZ8PjtiFq2a6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5089
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On 2024/11/4 20:55, Zhenzhong Duan wrote:
> IEC descriptor is 128-bit invalidation descriptor, must be padded with
> 128-bits of 0s in the upper bytes to create a 256-bit descriptor when
> the invalidation queue is configured for 256-bit descriptors (IQA_REG.DW=1).
> 
> Fixes: 02a2cbc872df ("x86-iommu: introduce IEC notifiers")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h | 3 +++
>   hw/i386/intel_iommu.c          | 8 ++++++++
>   2 files changed, 11 insertions(+)

It might be updated if patch 02 of this series has been respined. But this
patch is already in good shape.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 75ccd501b0..4323fc5d6d 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -410,6 +410,9 @@ typedef union VTDInvDesc VTDInvDesc;
>   #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI 0xffeULL
>   #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0f1f0
>   
> +/* Masks for Interrupt Entry Invalidate Descriptor */
> +#define VTD_INV_DESC_IEC_RSVD           0xffff000007fff1e0ULL
> +
>   /* Rsvd field masks for spte */
>   #define VTD_SPTE_SNP 0x800ULL
>   
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 2fc3866433..4c0d1d7d47 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2692,6 +2692,14 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
>   static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
>                                        VTDInvDesc *inv_desc)
>   {
> +    uint64_t mask[4] = {VTD_INV_DESC_IEC_RSVD, VTD_INV_DESC_ALL_ONE,
> +                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
> +
> +    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, false,
> +                                     __func__, "iec inv")) {
> +        return false;
> +    }
> +
>       trace_vtd_inv_desc_iec(inv_desc->iec.granularity,
>                              inv_desc->iec.index,
>                              inv_desc->iec.index_mask);

-- 
Regards,
Yi Liu

