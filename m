Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F46BC369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 09:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4G9g-00025u-Uy; Mon, 14 Apr 2025 05:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u4G9V-00025K-FX
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 05:30:56 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u4G9S-0004gP-HV
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 05:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744623050; x=1776159050;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pIjHRfiV4CDSwKoxi9lXjFufhBsgNNP+BSD/uAds9ok=;
 b=abYv3G0rDaoeeLjC9HwAmJhsus/9PrSnu/OhP3uZMqFLQlq72KB3T428
 +OXvOWH1fkJN4wVCSajSdZLEBAlupyZukVYLFZwv4CV2qb4bBM4QvGir3
 7q+0q4jNA989oStMADef6hgWl14dlkUXA8nmMKFVxOd8XHD2cLUUxfTD9
 oYuT2aVIo3IuWzshRhmCoe0jUsu/gS8/HAqTCV7CLPbp34czv5ABxuqSG
 lq96NWmc/2vCH0s0LZhT0h83UtMJj36AU78oi4ttEqBiYe0ptoXGuq0kv
 A/x2sJ1ZlIAPZ8ZBmnIn/OqjOm4BTo8qlNyax0lLtIY1mzmREnPH9QNCT g==;
X-CSE-ConnectionGUID: IUkzNqg/RdWyb6f0T1rIFQ==
X-CSE-MsgGUID: BhyX8/9NT4CP+xnwze2nrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="48785935"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; d="scan'208";a="48785935"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2025 02:30:45 -0700
X-CSE-ConnectionGUID: sEslMysuS8m9CDKD97t1bA==
X-CSE-MsgGUID: Y+esMgp6ShKM1X5DJolkBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; d="scan'208";a="134825489"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2025 02:30:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Apr 2025 02:30:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 14 Apr 2025 02:30:44 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 14 Apr 2025 02:30:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXAe1MxZ6InMGvXA4tMnpAg8Doh6xR7G/2yxQLGL6AJrmz0FW6FDIaYlctyagZ4T3kNEWlnKLTRfiQmTOSDo/011JQGGBbJLGBfaLKd50gUmpGqeWtD6FOzhBBwjhrkLpZK/RSRFD7shuyE9L1COHClngAwG36uvZjuPErBbc2w3Wy4g7i52MkoWoNm3CXjw3ckYjhcIx06RY0uknepoYncW2kM8E0xHbQbtUtqHCC+1XKigOtqFC/6U/a3Wsky/+tp7wphVDoHkjutrhScrx7HvsaBE1hX6aLs3uUK326qlb9wDVr9757qfe+m+/CtMg1FhakOWSmIWkCF018+hGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIjHRfiV4CDSwKoxi9lXjFufhBsgNNP+BSD/uAds9ok=;
 b=M9ZIT8vBukG6c2Rt2xL4vjG6eL+OUP6PwZY70rLLpzpdzQxsEwzXxE3rL9DJs2S2uAecgAb+xnKikLCs+v8Jf5dvI30TK5Iedxp7YaH/3UDqKwYs/40eum7GXzNnmODRFwbmtW6+PW6JLJAVhC9A5xuj87WxikXGyrvROkG22ix+JP3vPluTh8YZAP5SYFRM0YKzn0Z+sHZOpSuGKWwSjsXgDh55pqKzOSnrqK9f2Kjb6+yywsKYcOYSLqW86yRxn90TYlIO+pAaKKD1qnu13vg1jtoVCpgezY4wjWf4zVsd00xtkXSpShvylQSLTrqelQy+15IziHBkd64mdYOMMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7083.namprd11.prod.outlook.com (2603:10b6:930:51::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Mon, 14 Apr
 2025 09:30:41 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%3]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 09:30:41 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 1/5] vfio/iommufd: Save host iommu capabilities in
 VFIODevice.caps
Thread-Topic: [PATCH 1/5] vfio/iommufd: Save host iommu capabilities in
 VFIODevice.caps
Thread-Index: AQHbqstnyFbNUaToNUifB0k78FO5YLOeVAOAgASGe0A=
Date: Mon, 14 Apr 2025 09:30:41 +0000
Message-ID: <SJ0PR11MB67442F23FF7EB269ACFE26A192B32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
 <20250411101707.3460429-2-zhenzhong.duan@intel.com>
 <08b72d7a-2202-48bc-8b1b-78c93b3e7cfd@redhat.com>
In-Reply-To: <08b72d7a-2202-48bc-8b1b-78c93b3e7cfd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7083:EE_
x-ms-office365-filtering-correlation-id: 23127133-0992-47d4-a4e1-08dd7b37064a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?YTVBdDlPRE9PS0g4eGd0TGxIaTRjd2VESWdOZjQ0M2hKMENGb28xWXdlQnpu?=
 =?utf-8?B?encvK1RxZytlQlRndnNkZnprM043RC9BNmgzOEtpNHVrNEo0Q0orRXRRRTdi?=
 =?utf-8?B?elBpRlRsOUlYS0JyRXY4bGN2cTNsNUdmN3lZWDJZUFVkbjAxQVNKSDNwUDBw?=
 =?utf-8?B?L3diQS9XOGM0RW9mcWdxMmVHSjZGZWlSV1RiM1BWaUU1NG9wRzFIbWE2cjZP?=
 =?utf-8?B?Tm9aM1RSRVJMYzJjVngxaThpTExHZUNET0cwR09KeWhXbHQwdmk5bVU3Qy9H?=
 =?utf-8?B?T0p3Y2FBRTROQVlGM0RSVXovOGpTbkxGWGpXblZRYlRmdUtSVkI4VC9KNWhF?=
 =?utf-8?B?QzB3aDhCR2ExcmwrRFVPb2NscVFEbUtXL3gxSDVGRUhudHd3ZGJ3b1FybVRr?=
 =?utf-8?B?TEEvR25XQk9WdEhqTDVQQWVRU1k3SFBITEdjMjlGMFZFTTE1SVlSc203NlJ5?=
 =?utf-8?B?YW5TRFhGeEpPWDZMVmhqalJuRVR1YmNHTjNjK1R6UlNvSUNFVE04RGlxc1I2?=
 =?utf-8?B?TDJGMXJFUVFRMFBuZFBmQUZJTGZaYTZyS3RCcTdHdDVkM1huTDc5MVhWVzhm?=
 =?utf-8?B?WmdacUN0aTNzSFBvN0lta0NPVE8rS1pTN1lvc0RGNUNQclFuN3ppWU1MVU1Z?=
 =?utf-8?B?UHNVd3hJeCtZa3RWNTl2SGFnRlZVNGllZUFCZndoakU1VXpmRjkyL2t2OVov?=
 =?utf-8?B?U0h1Kzh2MktueVFxcVVZTFBtZXA2TTgvUXBINHJ2bHF5Z1VSQzhDYjFYdzlW?=
 =?utf-8?B?aDJnL3lId3kzS2Q3Rit6UGlEQ2haTS9xZzIvOU5sNEl6ekJjRkxUK1d0K0Vz?=
 =?utf-8?B?UWsvVEZGV3pOWkF0WklnMm05eW5ITVpWbnlOWnRTMzRRV0JDMS9JZlFIbU1k?=
 =?utf-8?B?aStielQzZkNZRzJyV1lodzl3bFNoOWc2NG4zeERVMmMreTJWUVkvUHBKUmlJ?=
 =?utf-8?B?eGtBbC84UFI3VUkvaUhQVFRZZTJyUDIwQzFJMnE5MVZlTW4wVTFxRlFoQm9I?=
 =?utf-8?B?bkIvcytzbDFBWWlsK3VaOFN6SndEaWRzNXlnZlQ3WUlyWjVBU1J5Q2I1K2Nx?=
 =?utf-8?B?ZFdyVGtHU2g1bWlVcE5sYlhzRGsyeFJ1ajZNejVtUjU2Q2c1c3FCcC9pendp?=
 =?utf-8?B?anc3NzM1QjR1U2VFeHkydm0yRG9qRHN2OHU3eWttQXJUQnVVYlZUWHNraVBF?=
 =?utf-8?B?TklYL09zMnNxR3piaUtaUU1CaDRFVXZnZ3I5OXkxY2c1WXUxc1BBRTFoaFp0?=
 =?utf-8?B?OEJmbE8rNWIwV1lmZzNSYllXZlZlUWk1dCtxL1F1OGlNME42K3NoL1ZvZXVr?=
 =?utf-8?B?OFNNZ2o0Q3RGOGpBb3VnRElQNHdxWVVjVnFab1QrSnRYYXJXaXNGcTdGSmM2?=
 =?utf-8?B?T3VVcThvT1lNZmU1N2ZMNGRiQTJXczlDdGp6bFVKWklJeThiMEFOdnBqNThu?=
 =?utf-8?B?eFQxNExXajR5bnpmVXBCQkQxaHlmSVlvUnF0ZEJDTUZaOUJDbXJXL0g4aldj?=
 =?utf-8?B?b0M0RlBGUVpQWUM3RHJDSmtZVkZjNjg5Q2x2QVZ0NVRyLytGS3E3b3lNU3Za?=
 =?utf-8?B?ODlvUVZNL0NlSmtHUnhES0UzbUd1UW5nMjdBbVB5TmhDNHA0RlYxb2YvcDI3?=
 =?utf-8?B?U3ByOFRHZjdCOEhVTUJyRHhWWVB1cGpFeThyUHdxOTJLNWUyV1Y3eStXUFJC?=
 =?utf-8?B?ZmtWaWRkTzFlZDJJVGFBMmJQZEZ5SFVLN2R4V2hEczRpTTJHV21ETGpKSVpR?=
 =?utf-8?B?UzN1L3VvQkwrOVBLOHc5Y2NPdmxvQ1cvbWU0cjFrMXM5aVoybnZxKzA5cTZO?=
 =?utf-8?B?UTZ2QVNCVVV4b1NJdkJaYmZibVVzZ1VSaUFCVm1wUkVoNTAvYzRQRDRnWXgw?=
 =?utf-8?B?NURCZmd1aUM4THJUWkQzQzZSRzJuN08yc0ZnRm9aU3ZjNThVWDRsWnVuY2NJ?=
 =?utf-8?Q?WrP8XjJdVog=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzY1THNNNHpucHk1S01DZjlieDZNaFBwZzJEVEdxRHRmOW04WnZNcXVOYnIw?=
 =?utf-8?B?Q2MwVzA2RXVDQVEvaTNXS1B4QWR6MkoxS1lRMmM0bEpDVVkrZjNOdFF4ZnpG?=
 =?utf-8?B?cHc3ZmJGWGp0ejBBc1NiaG40L2xDUnNFUnFqVlk5a1NqRDdmSTIyY2tWN1Vh?=
 =?utf-8?B?YzlVT1JIc3ErUnVmSnQyMldSZ0NVQVBDQ2V5RU12MzUzZW1JRUJyTm9leHNF?=
 =?utf-8?B?WjVPUFlQNkhMQmZIcjVFeUMrbHpqbDNuTHVWZ2tVa2dybndJYVo3bExZd0NG?=
 =?utf-8?B?dEJaK1I1Sy9pMXltUU9zRHA1RXU4UjJVQ3phd05hRXlLb09jSUFpdWo1Tjg5?=
 =?utf-8?B?V1FRMFdPNXJHNFpxcmIxc05DUmVPZVZMR3c2UHArOHZ6WUlnMWlWL1JPR0ZQ?=
 =?utf-8?B?V3Q2azgrckZxTVBTeFVVR3RLS0grbUVsWHN0cGd3R2ZNcTBHUk8wellQVlFo?=
 =?utf-8?B?TlZrT09GN1g1WktKWThpQjJLRGtiNWpINGRQYVd0cUhOalBOVVNldlJTUzdG?=
 =?utf-8?B?S1hrY1ZTbWQzMVA0aHhIWnNzUW1tTjhzVzhoM3U1b1kyc3hYVDh0RjJCdkEy?=
 =?utf-8?B?SEc1MUZQcm01UHFDZUEwZS9INzcwM2l1QUVSNjQzOTlhSE9lSEZLeGo0RCt5?=
 =?utf-8?B?SnhlUGJZVTBnLytjRUY3Sjd4bWZ6WFJRc1c4SnhXMnNtanU1bHl5emxWWjNZ?=
 =?utf-8?B?QWRLQ2FET1MyS1EzQlhPRm9MWVlzOWNyYTRCUllyUWMzMGROcmNIa0ZHakt1?=
 =?utf-8?B?Y1FtUU5wR0ZWTnBJWllFTndxb0FZSnF5TllpUEhBRUd5NXlpLzJKUTdCL0VT?=
 =?utf-8?B?S2RLVmhwOHBtNEIwVTRueUpmWElqYU9ROEJjb01lNUhUV2VLR2JSWTZZOTJ6?=
 =?utf-8?B?eTYvblB3RkVQRnBCUnJiZktDeUdUQnBSYXVXLzJ3SmM5ZlZORFpZUzczRVli?=
 =?utf-8?B?ZHNOTDAweDhIYjdZckpmT3AwNUlETVdYYmFrejU4YUhTdVM2OXQ3aVhZTGRE?=
 =?utf-8?B?WEhncHZjR281WE9RTGxDc3NkVUw1OFBueVRXMFY0OTRpSUVWM1haMnNWRERG?=
 =?utf-8?B?Um5Xb2ZUR2wrZTFyYjh3L3VkRkdKWWx0SGVqVUxUdVZUdmpGeXVPcjl6NSt6?=
 =?utf-8?B?L0hDMzczcXpTWFdjazNvY0RmZS9yL2tSS2FUOTRvdHA1Qkk4Y0FEY2tWR2lQ?=
 =?utf-8?B?aHhZSFhRWEtGM1hBYkUwZ2F6Um9KZ2FLdncySnBkTy9CK1pwUXhQZVpwNGZq?=
 =?utf-8?B?eEdKTWJUQ1ZSbzl1eTlFRUNTR0FOUHQrM2hnY3MybllYN1JqcENmV2QxSXpS?=
 =?utf-8?B?Sk1NQWRSUXVlMWUrRE44S2JOYTNrOUV4MnREWnRuQjFIUEh2SGwreFhmSy9x?=
 =?utf-8?B?dlZLaHNGS3NONit1cnpIS05SS2FFbThrZ092cTIwaHYvTHhjMy9GMGp3RXAv?=
 =?utf-8?B?UVVIWlJkS2xKbFRzSFd2bEVXYXJvOU9RcCtxOGx3aWVycVByeGw4OFV2TzM3?=
 =?utf-8?B?RmVDUHRMSGlQemM5THVjaWZLTEFVU2hNMXBya2Q0WnRka2w4aTBiNlFMa1NJ?=
 =?utf-8?B?ckxMYzBQYW1mcEs2VGdieURvalRxcTVta2hKR3UrR0dSOHV4L1dnNXhJejNN?=
 =?utf-8?B?ampNRm1QdXZ6N29EczBhbkcwZ2RhUzAvVzIzMVlBKytlWURJSTJTN01GM0tC?=
 =?utf-8?B?bEVNSE9nSTRqVkRjQUdKbG9ZNkxmSGg5N1lCeUdxRExrY3FpVW8zc0VyT01B?=
 =?utf-8?B?QThQN3NWVlYyaGc5RFpYZ1grcHhuU2tvVkJVRUM0cEM5YUlJenRxbDA3ME5n?=
 =?utf-8?B?QnR2VVZOVEpkalRxWnMzWFpYSkcraGtKREw2ZUZBNXBMYmZYNElOS1IvSEI1?=
 =?utf-8?B?MVZHWTY4c05hZXgyQnhUdGRSRTQrRHc4R1UycHRKSlU4Ni91ZjFpbGNhY0hj?=
 =?utf-8?B?d3paM2M5Y2ptakUyRW0rcUtFRDRpM09UKzRVVmcxd2tjdE1SREthVEVFZzVz?=
 =?utf-8?B?aEt6My9YR2swelBsTHlpVWIvdVJVZFRwMzJGWEtvUzU2dnVLVkZrRVVram82?=
 =?utf-8?B?TTNaYkhQbFp2NU00S0g2UDBFNFE1VkI0QldXTkVDL1VuKzFVbGYwQnpSRC9y?=
 =?utf-8?Q?Tzf/QzdJPMfrCqcSJ8qgv+DAN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23127133-0992-47d4-a4e1-08dd7b37064a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 09:30:41.4943 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y2/p42yTtcYDv1M60aPf90InVdoThaBiyp6bcEI1bxRRMx27zTZOfopGjysZ08C7L4PQtDXxF0Aa8LQ0aQ+m66i/Q6wm3tGUkq3M6B6LNbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7083
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIDEvNV0gdmZpby9pb21tdWZk
OiBTYXZlIGhvc3QgaW9tbXUgY2FwYWJpbGl0aWVzIGluDQo+VkZJT0RldmljZS5jYXBzDQo+DQo+
T24gNC8xMS8yNSAxMjoxNywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBUaGUgc2F2ZWQgY2Fw
cyBjb3B5IGNhbiBiZSB1c2VkIHRvIGNoZWNrIGRpcnR5IHRyYWNraW5nIGNhcGFiaWxpdHkuDQo+
Pg0KPj4gVGhlIGNhcGFiaWxpdGllcyBpcyBnb3R0ZW4gdGhyb3VnaCBJT01NVUZEIGludGVyZmFj
ZSwgc28gZGVmaW5lIGENCj4+IG5ldyBzdHJ1Y3R1cmUgSG9zdElPTU1VRGV2aWNlSU9NTVVGRENh
cHMgd2hpY2ggY29udGFpbnMgdmVuZG9yDQo+PiBjYXBzIHJhdyBkYXRhIGluICJpbmNsdWRlL3N5
c3RlbS9pb21tdWZkLmgiLg0KPj4NCj4+IFRoaXMgaXMgYSBwcmVwYXJlIHdvcmsgZm9yIG1vdmlu
ZyAucmVhbGl6ZSgpIGFmdGVyIC5hdHRhY2hfZGV2aWNlKCkuDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5
OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+PiBTdWdnZXN0ZWQtYnk6IEVy
aWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+IFN1Z2dlc3RlZC1ieTogTmljb2xp
biBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25n
IER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBpbmNsdWRlL2h3
L3ZmaW8vdmZpby1kZXZpY2UuaCB8ICAxICsNCj4+ICAgaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5o
ICAgICAgfCAyMiArKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIGh3L3ZmaW8vaW9tbXVmZC5j
ICAgICAgICAgICAgIHwgMTAgKysrKysrKysrLQ0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDMyIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9o
dy92ZmlvL3ZmaW8tZGV2aWNlLmggYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby1kZXZpY2UuaA0KPj4g
aW5kZXggNjY3OTdiNGM5Mi4uMDlhN2FmODkxYSAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcv
dmZpby92ZmlvLWRldmljZS5oDQo+PiArKysgYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby1kZXZpY2Uu
aA0KPj4gQEAgLTc3LDYgKzc3LDcgQEAgdHlwZWRlZiBzdHJ1Y3QgVkZJT0RldmljZSB7DQo+PiAg
ICAgICBib29sIGRpcnR5X3RyYWNraW5nOyAvKiBQcm90ZWN0ZWQgYnkgQlFMICovDQo+PiAgICAg
ICBib29sIGlvbW11X2RpcnR5X3RyYWNraW5nOw0KPj4gICAgICAgSG9zdElPTU1VRGV2aWNlICpo
aW9kOw0KPj4gKyAgICBIb3N0SU9NTVVEZXZpY2VJT01NVUZEQ2FwcyBjYXBzOw0KPg0KPklNTywg
dGhlc2UgY2FwYWJpbGl0aWVzIGJlbG9uZyB0byBIb3N0SU9NTVVEZXZpY2UgYW5kIG5vdCBWRklP
RGV2aWNlLg0KDQpUaGlzIHdhcyB0cnlpbmcgdG8gYWRkcmVzcyBzdWdnZXN0aW9ucyBpbiBbMV0s
IGNhcHMgaXMgZ2VuZXJhdGVkIGJ5IElPTU1VRkQgYmFja2VuZA0KYW5kIGlzIG9ubHkgdXNlZCBi
eSBoaW9kX2lvbW11ZmRfZ2V0X2NhcCgpLCBoaW9kX2xlZ2FjeV92ZmlvX2dldF9jYXAoKSBuZXZl
cg0KY2hlY2sgaXQuIEJ5IHB1dHRpbmcgaXQgaW4gVkZJT0RldmljZSwgSSBjYW4gc2F2ZSB2ZW5k
b3IgY2FwcyBpbiBhIHVuaW9uIGFuZCByYXcNCmRhdGEgZm9ybWF0LCBoaW9kX2lvbW11ZmRfZ2V0
X2NhcCgpIHJlY29nbml6ZXMgdGhlIHJhdyBkYXRhIGZvcm1hdCBhbmQgY2FuDQpjaGVjayBpdCBm
b3IgYSBjYXAgc3VwcG9ydC4NCg0KSWYga2VlcCBjYXBzIGluIEhvc3RJT01NVURldmljZSwgSSBj
YW4gdGhpbmsgb2YgYSBjaGFuZ2UgbGlrZSBiZWxvdyB0byBhZGRyZXNzIEVyaWMgYW5kIE5pY29s
aW4ncyBzdWdnZXN0aW9uOg0KaHR0cHM6Ly9naXRodWIuY29tL3lpbGl1MTc2NS9xZW11L2NvbW1p
dC9lMDVmOTFiMmE3MjRjZWZhODM1Njk2OWNiNDMyODRmN2MzZWMxMWQxDQpodHRwczovL2dpdGh1
Yi5jb20veWlsaXUxNzY1L3FlbXUvY29tbWl0L2UwNWY5MWIyYTcyNGNlZmE4MzU2OTY5Y2I0MzI4
NGY3YzNlYzExZDENCg0KRG9lcyB0aGUgY2hhbmdlIG1ha2Ugc2Vuc2UgZm9yIHlvdT8NCg0KWzFd
IGh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDI1LTAzL21z
ZzAxNTUyLmh0bWwNCg0KPg0KPkkgd291bGQgc2ltcGx5IGNhbGwgaW9tbXVmZF9iYWNrZW5kX2dl
dF9kZXZpY2VfaW5mbygpIHR3aWNlIHdoZXJlIG5lZWRlZCA6DQo+aW9tbXVmZF9jZGV2X2F1dG9k
b21haW5zX2dldCgpIGFuZCAgaGlvZF9pb21tdWZkX3ZmaW9fcmVhbGl6ZSgpDQoNCk9LLCB3aWxs
IGRvLCB0aGF0J3Mgc2ltcGxlciB0aGFuIGN1cnJlbnQgY2hhbmdlLg0KDQpUaGFua3MNClpoZW56
aG9uZw0K

