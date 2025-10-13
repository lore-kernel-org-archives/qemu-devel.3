Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296EECCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Hx6-0007CA-Qp; Mon, 13 Oct 2025 08:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v8Hx3-0007AY-Aq
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:46:57 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v8Hwr-0008P4-0J
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760359606; x=1791895606;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=54cZbyw4cKUMwpHf7L4oFJULxdZnGeB+oyjQnkJVYgM=;
 b=Ugo35bsQDlzKrUknZ803hM56WNe19cfbSjvR8vBb/zEfjeOpUmXSdBHC
 dYOcmVJRMobXT8BjzDhG8Cd6iaKn123MH+JuLBde12BH7FS9tXPiwJPaB
 9SNUmwgqd/HjLreWrub/p49IjfcNfA9MGEKFL6TR2PLvG3ikZ0Tnbetkg
 NMdTfOV1xx30bnVXma3FuD7lyB5YE43a3pvW+5AphJnQ8fmSqmqQF9cB2
 4gzel2fH41fqBNcbQNONTLw+T0eVnBa1dQ5RCqVJjaKl8P9UBt1KSjShz
 5BHo9d4adcgvW7EHC6o/JfRmpQZfo1v+hZrAp1JltuDl88xRJTuEN0YTG g==;
X-CSE-ConnectionGUID: RfmCRrXQS2KcyjeCMU3AIA==
X-CSE-MsgGUID: XLD/fvqQRYa5eVD6iilCcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="85120975"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="85120975"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 05:46:38 -0700
X-CSE-ConnectionGUID: 29NO5hjmQhyV7sckjKPWOg==
X-CSE-MsgGUID: 8RaPGRZyS9+areQLeJNEbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="186881392"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 05:46:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 05:46:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 05:46:36 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.44) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 05:46:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjD2aoX809TOO0aXbZPXgn5MgxakOMwCOuGU2mQ1stdhWEYOhTZqurVKQoU1/AGRSJ0TmLJKCmM8iOV0Lqh0ALCXUwR5IR6tXQnxKXpnOpITQMcmTO7WW2GXat7C+sEbihV4aYRNttb+i9jcr+MfIDalITrg3sNNKPC3SBVGXgAaBTfuhDIcJ7PD9+5Md3+qilt508qivYTDn9iwylgj8Hb9aa/H3WjTcqJwJnPY4JVYLf3DDBxtfbosQEFKsklkEgrGjn4HKH5GO4k1LQPNJ1OBm/k2W+AAGQ/HmIDL+PZylBcMbmVPfSyw9cuuYZdcSQmLcEawUqFM0v3V/Qb7QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T14wRZXIk44unXXP1agcYETfiiRET7okyX9F5IIn6kQ=;
 b=mjbkf+ssyeusXeR2bzVAImV59QGOBdyoEVO3k7iHywTxOdnQaj4JdYIE3BycIGuLG0fzfO2ZJ7GIN5jBmYuwbvlZFdWdzEb3d0KNwWE0vcdJgtTPlWI5L6Y2tkxhGjLvH9ZP/T0thghCl3MEAsTxQnJpLY+i8dPYbAxmFv2mHuRvex57j2aYjTR4DPfHdCIimvo0T3tJ85PomcFMZO+D8kxIKr9Zx1kMKsfFbtAb3T/IygTA+43RCprDpLxe2qx9x5CwUNT/kyWUSWLSnOcdUTGfmy4rLs8Zbp4yffn/+TPUgXY93fOnnIrFaKSogKzLYKgXnjlR9Sh37D3DqDybRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by SJ0PR11MB4782.namprd11.prod.outlook.com (2603:10b6:a03:2df::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 12:46:34 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 12:46:33 +0000
Message-ID: <16dd9714-7c62-4541-9ea2-fa2855601df7@intel.com>
Date: Mon, 13 Oct 2025 20:53:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/22] intel_iommu: Handle PASID cache invalidation
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-13-zhenzhong.duan@intel.com>
 <42881757-3e8d-437e-80e6-aa2d409523f6@intel.com>
 <IA3PR11MB9136BEE4A582292AFA94A62792EAA@IA3PR11MB9136.namprd11.prod.outlook.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB9136BEE4A582292AFA94A62792EAA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|SJ0PR11MB4782:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db974a0-d09a-4c58-0ef4-08de0a568a23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|42112799006|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0ljYTFIeWc0RTlDRk1oTm9CcG9helF0dmZ1R0hYKzN1a3J4R2E0UCtTN1Nx?=
 =?utf-8?B?NDJzazU2WGt2Y2FWcHUyMFp6a1VGU1pOb3BSM1lVODZUeFRSOFQ0SWkwb0VP?=
 =?utf-8?B?RFRTRXpFUGhwVnFja3V3RnNOU2szamVnR1hybDZycWZMeFJodWNOQXNIaVBt?=
 =?utf-8?B?eGp3ZEIvYzIveEdOdkY2T3hHcjQwTSthWlVXUEtuaXdTZEVNOGY5QzdxUHpX?=
 =?utf-8?B?V2hTMXlyTDNOTjZtK0lvclZGSUhuYnkwbGZEeVE0OEdwVkxDd0dhVXhNNHBO?=
 =?utf-8?B?bDgvK2RRZFcyZTRBRkw3ZGtjcm51dnU0ZDhqSnVJRHpDWnlvWXM4dHdtL2hr?=
 =?utf-8?B?TUJmRVVweitYOGxCMXN4d3hhMHh5N1ExREpMeTljWi9qUWxWS0ZtdmROazdr?=
 =?utf-8?B?ODBsSXRjQlY3YlJrZmI4d3FLb2w3TDNMdlJHTW1lR1VTaXNDZmtzejFWZmZi?=
 =?utf-8?B?S3BJNXhIU1FLbFcrSFl5UDJBNU5zY0RicHMyRTRPYVVIMTJmSWthNXk2bDRS?=
 =?utf-8?B?NWZNbGErbFVDbnVwelIxbUNmZkJjdXFON3dIelppVDUzYnBBR1RKcytmL3k4?=
 =?utf-8?B?cElXYlhVSDdpaHRHSFhWalNKMVZDOHZaZllhMmgzSzlKclZSSHNERTZBRlRQ?=
 =?utf-8?B?eGpnYndHWm1RN1dwOWcyQWV3YzIybEV0UzY1ZG1ZWEpJQVlLUXZEa0YwTUps?=
 =?utf-8?B?TUxlV1RqMDhNb2EzY09DTTBxNjd1Z0UwOE5iYkdHVVFLQTUrSXZtNEY4am5O?=
 =?utf-8?B?Zmo1a3pWc2ZVRzB1bWQwTFdyUUJnNjEwRjg2TTZVS1pobUpFVDIxZU9mamlU?=
 =?utf-8?B?eUE0RlJvM1ZqTGVpanl2cTZEOEVIMHhwS2xVZWFCZFdaSVVPV0NuM084ZFRp?=
 =?utf-8?B?OFdOK3hjaWNDVFR1SjloMnFmdlJ3bXJ6Qktwam1ZV3FvT2RELzNLM2kwUDJz?=
 =?utf-8?B?RFAvWHhOWG44NlB6aXNiOFZZM1lreXZRanJpNnRYd01wTjRMcGtMWnh1UnlC?=
 =?utf-8?B?MjNFbmNrWWFJNmFUU2ozanVuY2F0YXhyNEFaN3JHazl2dXJrZnYxVHI0T0N1?=
 =?utf-8?B?S3dNNExabTFYVFovaitZcElFRGIzWFZaZ0FpdHNNK2dXdWpWYkpGVGVCV2JZ?=
 =?utf-8?B?MFZDTDR4a0toUnp4WEJMZjE0VmlUNzQ5SUdDd3ArS1JpVVcvK09JejEvRnpZ?=
 =?utf-8?B?Y3JpbXQ3UVBETzAyeUNWY01iL0FEaHI5by9CcE5xM2trZ3ltOTZzSVlodlJx?=
 =?utf-8?B?SXJFY1pOZ0NRRVhLRnhrYmVBUExDM2ZGWmhvRkpTYk1xVTBHL1lpK2JJQzFH?=
 =?utf-8?B?QXBIbXhQYStnZFpRdGkxd3loWTFNV2FjN3VZNTZEMXI0QXQ5dElndllXZzFH?=
 =?utf-8?B?bFpzN25KenB5M3VJNzloRnhURVlrUWhsTS9icW5xZjZXZmRxTUduWlh1RnVP?=
 =?utf-8?B?NXpPRFVvTnAxL3VsWHpraWN6WHR2MXFCVHJnVk92aVhiRXpTVVVlei9XVWdX?=
 =?utf-8?B?RFMrblhkMzNUMVVNdGFRTDN5SXoyN0VQYktKeE5NZ0Yra0pXSk9vbDRiQW16?=
 =?utf-8?B?MExhQXpzTVhHTDluNGtoV2oxcjBJdmNRTG42QTREcGZYdFZFQWpzVG5HWTJi?=
 =?utf-8?B?SXFzVjduOTMzZS9lMWlBTS9paXh2bGoveHVRZjBwcVBYY2tNOXZHS1dOWi9L?=
 =?utf-8?B?VStEeUpZUTREODFqd08zYkNPTzU4UExFSzVKSmh3VktUR1Q1YW9WOCsrTTA1?=
 =?utf-8?B?cnRPa1gvQ0lDY0p4d2IwNGNRaXhOdmJkYitPUzRzMXJsTU41cjBZRzVRY2Vy?=
 =?utf-8?B?eHNRajRnV01qLzRzU0Z5VElBb0hpcDZMbjY4R2Jka29vSTNRdXlIWjFDTjFF?=
 =?utf-8?B?b0JxV1o3OHBDVG1mR3BteE5ZZ1NQN0pOVUxRMDBJVFM1eC9oeFBZWGhENldV?=
 =?utf-8?Q?BuPAi6RvBxbkE66xVx3x612d3vnkx3pW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(42112799006)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnZqeVhQRXE5cE1NKy9QbUt3RkYzUGwrc2tqQklBczYrWjhsSW1wcGY0Y1VV?=
 =?utf-8?B?c1BGZU5UN1FpL1h6enM5RTk4a0RBNG5VUTRFR0p4Q2FnY0xNRk5PZnhPenNK?=
 =?utf-8?B?YnNUdWJ0WUpYMUxEdzNJYW4yVlZXZldsUzVNVjdLUGlmaFZUSDJFYTREcG5x?=
 =?utf-8?B?bTZOYytkcytGbzcxczNQdXJERW52aVJPNjBaalg1UytwSy9SUkJNUnRUMjdZ?=
 =?utf-8?B?TTk1cTM5U09SR3A1Z0pLZ0dUQzBycGsybDI2TjNrN05QdGVTNkpKZzBXSWZw?=
 =?utf-8?B?dEtLRHBkTVowZzBlcHlWVG95ZnJOdW1HMHVLWVhxSEQ2bVoxUFpCY3FlOU92?=
 =?utf-8?B?QlEwWXc0akZ4Q0x5S3NQSEVlcVphY3VDVU1uNW8yVkVEakkzdlZ3WEZ2c0dw?=
 =?utf-8?B?MzRpRG11eXZ0ZHd6Nmg1endYQ0RKVTI5M3lpUk50aWY2NTFmU0w3THplTEpr?=
 =?utf-8?B?UWFVOVJPRnFsNWhWdjZicVladGF1d1lvbDNPTkszblJNTnpuMDRoNDQyMUVj?=
 =?utf-8?B?U0p1cGNDRUh5ZWpqeHZwcWx3YjRmNHh4bHh2eVJpRTIwR3E4U1ZoTktqVXJF?=
 =?utf-8?B?RWZQb0oxN0RhUENNcE9lNlFFVElpSVNaVGc4cDhhdE5VVDR2Z29WLzZ2L1Bm?=
 =?utf-8?B?Sk9ISWgvYkNWS0ZtT3ZUNS8rVURpMmsrNmYwb3doalBBc0krSzkwc0dXdzhF?=
 =?utf-8?B?RDY4SXFBOU50d0N0RGRld1NZS3p4bGVNZjlZaDJIQ3lzNjdUZXlTN052YUEr?=
 =?utf-8?B?K2V5d25RaGdJYmZUS0lOeHNmK3ZNYlIwbDdvZjB0SHV2N2Z1czBtUXFQQzNx?=
 =?utf-8?B?ZlJ5UjBOVnlVVS9MckFPazRkL2xiTVdBNVY0SVo2U3BQdEpFL0p5NGJBZmZy?=
 =?utf-8?B?OE9TWWhvUlZsV3Y4Yk0vM203UjhnbDBQbTBxL2lZSytCRk8wL0g0eEozdGhm?=
 =?utf-8?B?ODFyMEQ4WnVnV3B3R0Evd2loWHkreEFXWENKTTVwT3JzUDVDYkxkNEV0ZHdE?=
 =?utf-8?B?SU5RcFJxWXgrY3p2OGsrcFVwVHYvUm92Q3h4NmltOEh3RE1Mem5yd001bE5t?=
 =?utf-8?B?WjZra0tYSmhQYy9nVG1uMVgwUWpoZG1jdldsakRrWndaUnV0RVdRWUl1c2Ft?=
 =?utf-8?B?RlYwMlQxSEFJdnhqajBZczdDaG9ENDVCN1RqdStOVTA2MEExeDI3OVFvcHhT?=
 =?utf-8?B?dmpCWTBvVWRNbDlZTDVWVWd2QTZacVVhaUVFaWxEOE5UK2llVUtweWJTNnZ4?=
 =?utf-8?B?Y1ozekszZVhtc0puWFdkYzlaVEVjRExJQUtzWkdXd2x3MkJQZjBwZzRWaW9C?=
 =?utf-8?B?UEZFSzByOGtKam15dFNENjFLSm1qakxLRkRYajJ2ejRIam1jVHJ3MDJxWVNx?=
 =?utf-8?B?ZWVsKzZiczN1dHRIckZFb1ZkK2tUTlprRFQ1NktIOCtnR25DRmt1RUxhQlNS?=
 =?utf-8?B?SGoxaFFWRTlReGRmenBJSGFWbkU0bTM2enNnL25DcEc3SDJiNjBLUkFPbU5m?=
 =?utf-8?B?OTlKSlozRG05aTEwOGhSYUdGc2UzaGtVd3lSeGZBc2QvT0p5K093ZDNGbVdD?=
 =?utf-8?B?STFVVk1qODUzWXp3cWJ0bFplQWR1SzBKSGdheHdVSDltRXhySS9Uc3JrdytU?=
 =?utf-8?B?R1BGVW4rMHZFMGlwVHlrelp0OGszeTZUenJlVERNMzJ1ZXlqSDIxT1M4SFkw?=
 =?utf-8?B?RG1MbzA5aWVyZUY2My9scnJCR0JUSEZ4N2VGaUVobHU4eEQ4eEU5TjdvNGE1?=
 =?utf-8?B?ZnNjcnc1NjJySlN2ZkVZTXFocng5UmFRK01IYit0VVg2T3I5eVBxT2pZS0dS?=
 =?utf-8?B?MEVTWDdFdjFTWWZwTmxnMmk5T3lkUnpxYTRaZ0hEeXFzUTYzN2h2SzBCUEpQ?=
 =?utf-8?B?U0Vzb01nRkVLYnFLMVc0MWRNRDBlZnZ6TkRoeDVwZXhxMXNlM1B6N2lsemVn?=
 =?utf-8?B?ZlgzZ0Zyc25WTVFBWjZkVHJxYU1nRnJOa1pqdnpwUEhlbi9oOW5jdzV3R1lJ?=
 =?utf-8?B?SzJ3Rkd0NDF1TEQ1UEhMTEk3SUoxVlpta0NQNXVoM2hBQUppU3JBZDNWQ3Vw?=
 =?utf-8?B?dHlpYTlKUmFHTkxUelpqdWNVcEJYVWRwSHRyNVZnZXJ1QXlrYzIxOTc4U0g5?=
 =?utf-8?Q?WYotmZk8XCFWLCdjbPPaeOKjL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db974a0-d09a-4c58-0ef4-08de0a568a23
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 12:46:33.7609 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hYPh+NrltAfkcCeps3MCZ1/EG54D4S7kDKVl3y6bI9ngRWrrwzLiBk0eIh4PCa67XKaMNLssZAebDvADxf8dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4782
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2025/10/13 15:37, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v6 12/22] intel_iommu: Handle PASID cache invalidation
>>
>> On 2025/9/18 16:57, Zhenzhong Duan wrote:
>>> This adds PASID cache sync for RID_PASID, non-RID_PASID isn't supported.
>>>
>>> Adds an new entry VTDPASIDCacheEntry in VTDAddressSpace to cache the
>> pasid
>>> entry and track PASID usage and future PASID tagged DMA address
>> translation
>>> support in vIOMMU.
>>>
>>> When guest triggers pasid cache invalidation, QEMU will capture it and
>>> update or invalidate pasid cache.
>>>
>>> vIOMMU emulator could figure out the reason by fetching latest guest pasid
>>> entry in memory and compare it with cached PASID entry if it's valid.
>>>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    hw/i386/intel_iommu_internal.h |  19 +++-
>>>    include/hw/i386/intel_iommu.h  |   6 ++
>>>    hw/i386/intel_iommu.c          | 157
>> ++++++++++++++++++++++++++++++---
>>>    hw/i386/trace-events           |   3 +
>>>    4 files changed, 173 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/hw/i386/intel_iommu_internal.h
>> b/hw/i386/intel_iommu_internal.h
>>> index 9cdc8d5dbb..d400bcee21 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -316,6 +316,7 @@ typedef enum VTDFaultReason {
>>>                                      * request while disabled */
>>>        VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
>>>
>>> +    VTD_FR_RTADDR_INV_TTM = 0x31,  /* Invalid TTM in RTADDR */
>>>        /* PASID directory entry access failure */
>>>        VTD_FR_PASID_DIR_ACCESS_ERR = 0x50,
>>>        /* The Present(P) field of pasid directory entry is 0 */
>>> @@ -493,6 +494,15 @@ typedef union VTDInvDesc VTDInvDesc;
>>>    #define VTD_INV_DESC_PIOTLB_RSVD_VAL0
>> 0xfff000000000f1c0ULL
>>>    #define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
>>>
>>> +/* PASID-cache Invalidate Descriptor (pc_inv_dsc) fields */
>>> +#define VTD_INV_DESC_PASIDC_G(x)        extract64((x)->val[0], 4, 2)
>>> +#define VTD_INV_DESC_PASIDC_G_DSI       0
>>> +#define VTD_INV_DESC_PASIDC_G_PASID_SI  1
>>> +#define VTD_INV_DESC_PASIDC_G_GLOBAL    3
>>> +#define VTD_INV_DESC_PASIDC_DID(x)      extract64((x)->val[0], 16,
>> 16)
>>> +#define VTD_INV_DESC_PASIDC_PASID(x)    extract64((x)->val[0], 32,
>> 20)
>>> +#define VTD_INV_DESC_PASIDC_RSVD_VAL0   0xfff000000000f1c0ULL
>>> +
>>>    /* Information about page-selective IOTLB invalidate */
>>>    struct VTDIOTLBPageInvInfo {
>>>        uint16_t domain_id;
>>> @@ -552,6 +562,13 @@ typedef struct VTDRootEntry VTDRootEntry;
>>>    #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL |
>> ~VTD_HAW_MASK(aw))
>>>    #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1
>> 0xffffffffffe00000ULL
>>>
>>> +typedef struct VTDPASIDCacheInfo {
>>> +    uint8_t type;
>>> +    uint16_t did;
>>> +    uint32_t pasid;
>>> +    bool reset;
>>> +} VTDPASIDCacheInfo;
>>> +
>>>    /* PASID Table Related Definitions */
>>>    #define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
>>>    #define VTD_PASID_TABLE_BASE_ADDR_MASK (~0xfffULL)
>>> @@ -573,7 +590,7 @@ typedef struct VTDRootEntry VTDRootEntry;
>>>    #define VTD_SM_PASID_ENTRY_PT          (4ULL << 6)
>>>
>>>    #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted
>> guest-address-width */
>>> -#define VTD_SM_PASID_ENTRY_DID(val)    ((val) &
>> VTD_DOMAIN_ID_MASK)
>>> +#define VTD_SM_PASID_ENTRY_DID(x)      extract64((x)->val[1], 0, 16)
>>>
>>>    #define VTD_SM_PASID_ENTRY_FSPM          3ULL
>>>    #define VTD_SM_PASID_ENTRY_FSPTPTR       (~0xfffULL)
>>> diff --git a/include/hw/i386/intel_iommu.h
>> b/include/hw/i386/intel_iommu.h
>>> index 3351892da0..ff01e5c82d 100644
>>> --- a/include/hw/i386/intel_iommu.h
>>> +++ b/include/hw/i386/intel_iommu.h
>>> @@ -95,6 +95,11 @@ struct VTDPASIDEntry {
>>>        uint64_t val[8];
>>>    };
>>>
>>> +typedef struct VTDPASIDCacheEntry {
>>> +    struct VTDPASIDEntry pasid_entry;
>>> +    bool valid;
>>> +} VTDPASIDCacheEntry;
>>> +
>>>    struct VTDAddressSpace {
>>>        PCIBus *bus;
>>>        uint8_t devfn;
>>> @@ -107,6 +112,7 @@ struct VTDAddressSpace {
>>>        MemoryRegion iommu_ir_fault; /* Interrupt region for catching
>> fault */
>>>        IntelIOMMUState *iommu_state;
>>>        VTDContextCacheEntry context_cache_entry;
>>> +    VTDPASIDCacheEntry pasid_cache_entry;
>>>        QLIST_ENTRY(VTDAddressSpace) next;
>>>        /* Superset of notifier flags that this address space has */
>>>        IOMMUNotifierFlag notifier_flags;
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index d37d47115a..24061f6dc6 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -1614,7 +1614,7 @@ static uint16_t
>> vtd_get_domain_id(IntelIOMMUState *s,
>>>
>>>        if (s->root_scalable) {
>>>            vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
>>> -        return VTD_SM_PASID_ENTRY_DID(pe.val[1]);
>>> +        return VTD_SM_PASID_ENTRY_DID(&pe);
>>>        }
>>>
>>>        return VTD_CONTEXT_ENTRY_DID(ce->hi);
>>> @@ -3074,6 +3074,144 @@ static bool
>> vtd_process_piotlb_desc(IntelIOMMUState *s,
>>>        return true;
>>>    }
>>>
>>> +static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
>>> +                                            VTDPASIDEntry *pe)
>>> +{
>>> +    IntelIOMMUState *s = vtd_as->iommu_state;
>>> +    VTDContextEntry ce;
>>> +    int ret;
>>> +
>>> +    if (!s->root_scalable) {
>>> +        return -VTD_FR_RTADDR_INV_TTM;
>>> +    }
>>> +
>>> +    ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
>> vtd_as->devfn,
>>> +                                   &ce);
>>> +    if (ret) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    return vtd_ce_get_pasid_entry(s, &ce, pe, vtd_as->pasid);
>>> +}
>>> +
>>> +/*
>>> + * For each IOMMUFD backed device, update or invalidate pasid cache
>> based on
>>> + * the value in memory.
>>> + */
>>> +static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>>> +                                        gpointer user_data)
>>> +{
>>> +    VTDPASIDCacheInfo *pc_info = user_data;
>>> +    VTDAddressSpace *vtd_as = value;
>>> +    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
>>> +    VTDPASIDEntry pe;
>>> +    uint16_t did;
>>> +
>>> +    /* Ignore emulated device or legacy VFIO backed device */
>>> +    if (!vtd_find_hiod_iommufd(vtd_as)) {
>>> +        return;
>>> +    }
>>> +
>>> +    /* non-RID_PASID isn't supported yet */
>>> +    assert(vtd_as->pasid == PCI_NO_PASID);
>>> +
>>> +    if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
>>> +        /*
>>> +         * No valid pasid entry in guest memory. e.g. pasid entry was
>> modified
>>> +         * to be either all-zero or non-present. Either case means
>> existing
>>> +         * pasid cache should be invalidated.
>>> +         */
>>> +        pc_entry->valid = false;
>>> +        return;
>>> +    }
>>> +
>>> +    /*
>>> +     * VTD_INV_DESC_PASIDC_G_DSI and
>> VTD_INV_DESC_PASIDC_G_PASID_SI require
>>> +     * DID check. If DID doesn't match the value in cache or memory,
>> then
>>> +     * it's not a pasid entry we want to invalidate.
>>
>> I think comparing DID applies to the case in which pc_entry->valid is
>> true. If pc_entry->valid is false, this means no cached pc_entry yet. If
>> pe in guest memory is valid, the pc_entry should be updated/set hence
>> the bind_pasid operation (added in later patch) would be conducted.
> 
> We get here only when pe in guest memory is valid, or else we have returned in "if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {" check.
> 
> If no cached pe but valid pe in guest memory, that means a new pe.
> For new entry, guest constructs pasid cache invalidation request with DID
> field filled with DID from pe in memory. We don't unconditionally cache new pe
> for all devices for one pasid cache invalidation except it's global invalidation.

I see. yes, intel iommu driver has already used the did configed in the
pasid entry to flush pasid cache per caching mode. But there seems no
words stated this in spec. Anyway, I don't see any reason why a guest
iommu driver wants to use a did unequal to the one in pasid entry when
this is a newly set pasid entry. So it's fine to me now.

btw. it would be nice to note how you support the global invalidation
since it's no more part of pc_info->type.

Regards,
Yi Liu

