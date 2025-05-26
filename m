Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2084AC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 07:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJS7c-00039A-Ii; Mon, 26 May 2025 03:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uJS7X-00038w-IS
 for qemu-devel@nongnu.org; Mon, 26 May 2025 03:19:40 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uJS7U-0005nI-9c
 for qemu-devel@nongnu.org; Mon, 26 May 2025 03:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748243976; x=1779779976;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=E0zvm/HEPedh3NEiX/UiwD1QK7M0C+Ma9b+hd0uV3a4=;
 b=cTvG181pSJ/uytw9O6hsHfGO3f1NxxVQ5sHZn41Ucr6Cpso03XKTWpmm
 6jFgYPO5fQDiR6TGBc8bSMKeBW7WxptJlWJUO25Y0c0wLNvTEbEnyDIKg
 SIwnl5BWQOkl/mEOtqMOYe61d/GrjHlg/SBbUC+T2s0cbX8yJxCzaIYMR
 ZuTgsfc+2hO4Cw5LFV7vVV47Sw/qDCNr2GuXkY0EBcAGhjNNqE5ri/mgX
 PhEKJOOoPXZoWEBjx0KMGuMmTQLFGEM1boV/F2oOSQ9SWngxu3BOxg03y
 GsJWBVtN6mybtge/VuoSQjleWW4socJv+OvQTzRLOcmnv3t3vR82X7teh g==;
X-CSE-ConnectionGUID: Hr1OSJl3QNqlyReSoy56lw==
X-CSE-MsgGUID: /cd8qRhMQfqf6KFdWJgVsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="49323277"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="49323277"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 00:19:30 -0700
X-CSE-ConnectionGUID: VE5QQ+whRT2uRiApvr8jaA==
X-CSE-MsgGUID: hknleBT/R9eijwRt/zHO6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="143201197"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 00:19:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 May 2025 00:19:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 26 May 2025 00:19:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.86) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 26 May 2025 00:19:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSMXK9zt9m5mzoYQKPwKjyGzDZEbCO/bpVJMg0cEm1+4gY9ocodiwrOoJPsusOrJYMk5sJLPUqTCSwQn7pAVUF4RFsHImo7eXBcLtoUjXOCRKalBc8RIqJF5DFY/C86c5anh13Ku0914OjU+X3yMI8QKsdGgrZaGXpX8rS1D07aypfzoAOVw0Zi4cdRvHpbh3lqezlI+0u8rnaQXjHsAbXIO/MyeWi/qRAa12tC5B34Y2yYeiKIEFJXuSyqC6LidPxfaLnjnCVheDzRaE0ys9VG/i8L4w7qvSY2yY2x7n6z86Zvrg+7T8KxbEm5PHgvExPTppvfmc8FMhpjumsKYVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxXV0u2TF7fPR6kO6pjrUTKaf8helyqtJJ7xmITSlL8=;
 b=r91+9pqj8GJMZPTp+oW15TU8btwU1TL/b1UA/IItMry35t6aOykQxfrxp/AiSifwLric6eVNSfWh+7u8409aQaQwdAj1KoaXci2hsRgJg1LOi/2hkL2QFQIXvRjXIqpKe/4xO1+tYP+m8wQQLI+uIHAVuDnGl0kFUwSEO48x96ldt8ImSNAvBW8qvwSUrgaSsG2n3dv8C1y1rH8GRZnskaf+oG8R5uZQE0mACTQv5lBTd7Ga2fXH4L92SrXqt7lV5dWrA9yMitznuMxcDKWDpdqzbZV0nBODm+nkEGMrWNqk+K8UhHp1lL93+mlO0guMSbvl6wwyJliK44LyT8YbRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7287.namprd11.prod.outlook.com (2603:10b6:8:13f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Mon, 26 May
 2025 07:18:45 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8769.019; Mon, 26 May 2025
 07:18:45 +0000
Message-ID: <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
Date: Mon, 26 May 2025 15:24:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
To: Nicolin Chen <nicolinc@nvidia.com>, Peter Xu <peterx@redhat.com>
CC: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>,
 <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU1PR03CA0046.apcprd03.prod.outlook.com
 (2603:1096:802:19::34) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f6638c4-275b-4ea3-bbd6-08dd9c258d49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2xpWWcwaEhGM3U1bUlSVmRYUXp4VUZtMjVOWXJOS2ZWcWFKLzFzNXF3UEdi?=
 =?utf-8?B?QXNhc1FXRTZyVmUzRkJXRG1WUEEwUDFOK2tLSnRIZHlVVnowS1hwMnpYNlZT?=
 =?utf-8?B?R2s3eTMvNmwrV2FTWmRtNG1aNGQrMEozNEpBNTRQSjk5UFZwQ0hUcUhFVDRo?=
 =?utf-8?B?a1ZKQm5HK01yd1hiRzlGalZ0aVFJaHZuZFNEYWQwZU9FZlVWdVU2RmxETU4x?=
 =?utf-8?B?NTZuK01UTVN0cWVOeXk3TFhUWndtTytVRVRsOXVMSFc1aTBQUHVTREV4Lzdy?=
 =?utf-8?B?K1ZyRmhSWjY4bWFKZmdXckNsa3FTMHZkZ0xPeFJJMm1nNzhMenlva05NT0Vt?=
 =?utf-8?B?RkVtNEw5a005MmFQTHc3bEtBWjdrQWJtOTg4bStjYTh1YUF0OHpkL0lxbXJh?=
 =?utf-8?B?VC95Y01nYTFNeklyZGQrYnl0VE95UWwwV08rZnMySTVmcHArV2FML1pPMjl0?=
 =?utf-8?B?MW42bEE3QmtYYVE0SkJ0TUJtNUNreEx3RGlvYzd4U1lVU3lhSjlrUkdOKzVF?=
 =?utf-8?B?eWxjeEJ6ZnNxTUY5NmFrekZUN0s4azBiVU51ZXJCemlXRndYdnkxR2ZLblh2?=
 =?utf-8?B?WDBjc0NjRTNEL0Q2WEVuanJoQ25tbmxHb3phSU1mVVAzMC9oN2doZUdubmMv?=
 =?utf-8?B?V1FNWnRFdW9zc1dUbVFVaXU4YllEcjJ5ZU5HNk5rZUIvaE9Rem1kc1FOdWh5?=
 =?utf-8?B?YnRJSzNtUVArZlNnZ2RIOCtONU92L3cxZGp2YzJ3UzNuU3JFWVVXMXU2cnE5?=
 =?utf-8?B?UnBjWHl4b2J2dTY1bHMzaGZybXNqUFJsR2JNSTVFeTFnMzloZWUza3g5NWxq?=
 =?utf-8?B?OU5zTlhGVXZpMHR5eUd6d0Jsb0JOeWc0T2VwMGQrOXZTaGlWZkh6NEFOM3Rj?=
 =?utf-8?B?MjNqNTlkWGtpQ0IvNEdvMWhpUUJIMWc1dVI0NmFTdGh6TXkxSzArTlRZZVZM?=
 =?utf-8?B?WlFXZUhYRnFpdCtpc09Vd3Z4WFkzcmdIQ1BWOTJ4eERwVkhwTSswdHNCRUlt?=
 =?utf-8?B?Qlpma0wwSndBZXNrT044YnlEa0M0UzBrR1RHV0Zwb0VGejdIQmhkZkczMHZO?=
 =?utf-8?B?VGtUQ1VHcEw1U1lYNVhnMjlwNnN0ZnFHZGpiZldzNFFRMEZGR2JQcVBDSm9q?=
 =?utf-8?B?VUZkZXV0QnU4d3oxUnU0czRLNlpvQVE3V0N6czdxV3lHbWVGZEZvRkdaVHpO?=
 =?utf-8?B?SDBPWEVFb1NiU0NZR05HQkpNUnNONkU4aWtFMldZeDhLdkxLUmZ5M1ZNZERD?=
 =?utf-8?B?aVlQWmJqZzRPMEEvNVZCOE5YNjZCZnJwYWtWRDJOOFVhb0xJdEc1djJOTmhw?=
 =?utf-8?B?bUNudXVuanRxMGpLV2tteGV6NmJ1ZGFneHhPcGozbUM2cHBoNUd5TlVrWFhy?=
 =?utf-8?B?WlAxdVVBQzRWaFk4d2ZMVSsyaGVlSStkMEg3Mi9Qb2NKbVBJTlUxYnV6d3hK?=
 =?utf-8?B?MUJCWHhSVnhhTisycG9LK2lkZHQrSlNSKzJCdUVyRWF3cVlxekh0TlBtNkpP?=
 =?utf-8?B?OTJaOWJZa0pMd0Y1T2M3VXJmRVBOeWtnZjlBd2M3aU9RR1NjK0RtQ1A2VlNR?=
 =?utf-8?B?Y1RvQ0tEbmg3am5kOVdTcG8zVitaNExHajdDVkdzQkt4c3ZTb0pnZGo5Z1gz?=
 =?utf-8?B?Z1hTd2sxajRmS2lBTzFZWGVtWEFtSW5qcWRNRFVNNEdId1NmOXNDNjR6Nkc3?=
 =?utf-8?B?NmhVbkRRZFc0MGZpN2FjU3hkOUp5TXdUMm9pS294Zm92VVZXZVVVZEtWbWJW?=
 =?utf-8?B?SEJ3RnRLckk2czlTSytZemVNUm5scHBFeDQ5NVQzWWpoRmVNdHFZeGF5RnJP?=
 =?utf-8?B?MVUvZGtlUHBvSDE3eVM4M1N0c1BjSm5HUGJ4QjFCYnBzMmxYdi9uOHk3a011?=
 =?utf-8?B?eWZVOWtML2VRNnkvME8vTW5KZks5YjBONjV5KzNEdCsxYkFtTUtscDZtQ1RC?=
 =?utf-8?Q?XvEhsfgnafA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG9jNHpWalNtSlU3Vnp0aEdlQjRwRHFRTjlKWXJNRmozSDAvelVqRUZsS2Yw?=
 =?utf-8?B?V2V0YlZtN0tMYThST3VTOVQwWWN0enVTTS9nZDFXWE1ualZ5Q1RmQ3NYMXdu?=
 =?utf-8?B?MGlocWdCV1o5amNmOElEZ2ZqUUlpSzlpRnVXRm1tUzliRkJqMkdSN3lCQkhz?=
 =?utf-8?B?bkRTRndWK2xMZnA3S3UzU3dsM2hhdHdxTDdlS1lnd0NQRWRPeVE1SDdZYk1u?=
 =?utf-8?B?M1lEUGF2UmtrYzIwWlRzSEFtK0xZU2daSFNlY2w0L3JPYW5WUmthUjdSd2ZF?=
 =?utf-8?B?MkljOXdFK3RnallJZnErRnlhRHNQRlVTaTJoeWQyTkJvT3NkQ3h6Qm45bWtI?=
 =?utf-8?B?M3pOeG1OM2MrSndYdStsZS9pMDh3ZGIxS2wzQU1UdXFRUGFKSklzbnJpZzcy?=
 =?utf-8?B?aWJkL3RmekxKUzFaNTgxQ1ZZRWhRSkxFUmJhdWliblZkV0RGeTRkVEo5Yy9s?=
 =?utf-8?B?TzA0KzJ4c1dCdlVYVFlPK013RWl1MFF2dkZQcEtlUG5WVGVudWhEdnFRYkVE?=
 =?utf-8?B?VjFPMjlHQldGUDZ5K1dLcEUvVzhKWUV1SUU3MGxad2FVcmgxSGZ0WHo4UWcw?=
 =?utf-8?B?NTcvSW1FSmpUQVI3WEE5bE5QZVV1ME1HY01BMGZtdmdTOUhNYTNvNk0vVU1Y?=
 =?utf-8?B?Vmh1Q3A3aXJYdXlpMHo0bHgvNWhEOHIrTEFTcmZlWXFaSzBlcFpGSjRzQ29C?=
 =?utf-8?B?eVB0MGIzMnhhd21OYVNBR002N0VjTVZOV3huV3FlTC9GdXR5MUt5UFdGOGgw?=
 =?utf-8?B?OEJPSFNoTzdWNm1iZVYvZ2ZDNUxibnEvUStaVm9lcXFRL2lCU3lhcTlTcmdw?=
 =?utf-8?B?bjUzYkZQOFFZNE9hOGlmTTJRWmZicHVuWDJYYk02c2IwTFU2aUhBd1dCdkU5?=
 =?utf-8?B?ZUlZWnlYcTlBdHlBdm9JMWxhblUyNG41bmhWQkU0N28veDNIb0xlS1ArUm0v?=
 =?utf-8?B?UkVaMGJ1akJlR0ozT21pQnNDUFJwanZmNnNDdWFRY0c5U2JrYUYzbitzY21t?=
 =?utf-8?B?YTA4SHN3NEEyMFBSQWdTOHpBUkZTV1RQOGlrTVJMbFFqeWRRcWgrODllcnRz?=
 =?utf-8?B?RGVKcnZCdVdUQ01HN0h4MWdCNlVxTWd4c3VrMUF0NHVIb2pxNXFVWVRDbWh5?=
 =?utf-8?B?VjlXN2F6YnpYUDFrdXgreUticVRkZGloUVJGWHBuTjFwc1k0NmhpWGtIOUg1?=
 =?utf-8?B?d2JOanFndmlFTXN5alVNUGg1dGxXSkVTMDI0S2xRaUpvZ2VEN2NJaVhrSkhH?=
 =?utf-8?B?R0lTd3dSTDBUWFo0TlcyT0UzVnlzTmZPTm0wdXFncTNlL3J2MHJDeGN3R05R?=
 =?utf-8?B?U0VWUkR6U3h3TFV5WkhybUMzR1c3N2Q2NGpTT2J5TVZLZ1ZybEJjdlZKY24z?=
 =?utf-8?B?Nml2c3VFbEl3QXQ2ODdISXBaUStWZmgyanNDdUV2VHZnTXZTdm40MnBNaEky?=
 =?utf-8?B?dXVpRDdhcVJxeDV6VjVpdE5OdVFWTUFxeWxKZmowNFZQTks1ZE1TcXpCVXZX?=
 =?utf-8?B?bUk4Ly9ncWthdXlLeVYvWEZMUkhPVFNyOXp4UGRmd05kTitXaSthdjRMM2dG?=
 =?utf-8?B?QTRQNFpsT0JWMU5LekY2a2tTdzlLNk1iNDRxTVV2Rk1kRFBEaW1qS3d0VlVN?=
 =?utf-8?B?d1c1VWN1Tk5pSGxtR2YzaFlwdGQ0eHNDTUxGY3JxZktyb1c1S0ZEWjk3eVR1?=
 =?utf-8?B?MEJwL0tuVkZ0aVdINmdSWSt6K0g1Rkd0VG5McmNVckt2NFBsMEF2YVl2dERm?=
 =?utf-8?B?c0xyeWlaeEtFMlRPU0IwNkh3RThlcXVMK1Z0TVlWL1Z2YzZyWmJOWFVTZGVj?=
 =?utf-8?B?MFRWRHoxNkhZLzNhU3l3OW9OTlNaZ2svV3p4YnpBMk5BMndpcjBXWVZUcDFK?=
 =?utf-8?B?WXVHSlZ1bDNLSCt3MSs1L3gwaVEvOWRGMkpoTnZIeUh2V2Q1OFJFZ0YxNFB4?=
 =?utf-8?B?U0djRk0yOWxWekgzUWtRNThtUVhDc1Z3akp2ZWZ5Y1BHemltaXNHWnN4Nyth?=
 =?utf-8?B?UXB6ZFJCWFR1WFIvMXIzM3RHL3dUVThNbmxRYmxLdWVGT1JPblYzNjNXYWNY?=
 =?utf-8?B?NmdmTU5GR0RSVTlnNVoyZS9zRlBPakhoK2JkcDVORWZPMi8veHFQbXZrRWxq?=
 =?utf-8?Q?9LgINtMOqHK5Th9MTewveSykb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6638c4-275b-4ea3-bbd6-08dd9c258d49
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 07:18:45.6134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cT8pPM5LZefouXjw19W6htpFn1w3EqBdrVqO4MKjFVScLJnXZd5sGGFrPkGAJoBtJPRfwCvERcXaVlJqTouYJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7287
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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

On 2025/5/24 05:12, Nicolin Chen wrote:
> Hey,
> 
> Thanks for the reply.
> 
> Just want to say that I am asking a lot to understand why VT-d is
> different than ARM, so as to decide whether ARM should follow VT-d
> implementing a separate listener or just use the VFIO listener.
> 
> On Fri, May 23, 2025 at 02:22:15PM +0800, Yi Liu wrote:
>> Hey Nic,
>>
>> On 2025/5/22 06:49, Nicolin Chen wrote:
>>> On Wed, May 21, 2025 at 07:14:45PM +0800, Zhenzhong Duan wrote:
>>>> +static const MemoryListener iommufd_s2domain_memory_listener = {
>>>> +    .name = "iommufd_s2domain",
>>>> +    .priority = 1000,
>>>> +    .region_add = iommufd_listener_region_add_s2domain,
>>>> +    .region_del = iommufd_listener_region_del_s2domain,
>>>> +};
>>>
>>> Would you mind elaborating When and how vtd does all S2 mappings?
>>>
>>> On ARM, the default vfio_memory_listener could capture the entire
>>> guest RAM and add to the address space. So what we do is basically
>>> reusing the vfio_memory_listener:
>>> https://lore.kernel.org/qemu-devel/20250311141045.66620-13-shameerali.kolothum.thodi@huawei.com/
>>
>> in concept yes, all the guest ram. but due to an errata, we need
>> to skip the RO mappings.
> 
> Mind elaborating what are RO mappings? Can those be possible within
> the range of the RAM?

Below are RO regions when booting Q35 machine (this is the pcie capable 
platform and also vIOMMU capable), 4GB memory. For the bios and rom
regions, it looks reasonable. I'm not quite sure why there is RO RAM yet.
But it seems to be the fact we need to face.

vfio_listener_region_add, section->mr->name: pc.bios, iova: fffc0000, size: 
40000, vaddr: 7fb314200000, RO
vfio_listener_region_add, section->mr->name: pc.rom, iova: c0000, size: 
20000, vaddr: 7fb206c00000, RO
vfio_listener_region_add, section->mr->name: pc.bios, iova: e0000, size: 
20000, vaddr: 7fb314220000, RO
vfio_listener_region_add, section->mr->name: pc.rom, iova: d8000, size: 
8000, vaddr: 7fb206c18000, RO
vfio_listener_region_add, section->mr->name: pc.bios, iova: e0000, size: 
10000, vaddr: 7fb314220000, RO
vfio_listener_region_add, section->mr->name: vga.rom, iova: febc0000, size: 
10000, vaddr: 7fb205800000, RO
vfio_listener_region_add, section->mr->name: virtio-net-pci.rom, iova: 
feb80000, size: 40000, vaddr: 7fb205600000, RO
vfio_listener_region_add, section->mr->name: pc.ram, iova: c0000, size: 
b000, vaddr: 7fb207ec0000, RO
vfio_listener_region_add, section->mr->name: pc.ram, iova: ce000, size: 
a000, vaddr: 7fb207ece000, RO
vfio_listener_region_add, section->mr->name: pc.ram, iova: f0000, size: 
10000, vaddr: 7fb207ef0000, RO
vfio_listener_region_add, section->mr->name: pc.ram, iova: ce000, size: 
1a000, vaddr: 7fb207ece000, RO

>>> The thing is that when a VFIO device is attached to the container
>>> upon a nesting configuration, the ->get_address_space op should
>>> return the system address space as S1 nested HWPT isn't allocated
>>> yet. Then all the iommu as routines in vfio_listener_region_add()
>>> would be skipped, ending up with mapping the guest RAM in S2 HWPT
>>> correctly. Not until the S1 nested HWPT is allocated by the guest
>>> OS (after guest boots), can the ->get_address_space op return the
>>> iommu address space.
>>
>> This seems a bit different between ARM and VT-d emulation. The VT-d
>> emulation code returns the iommu address space regardless of what
>> translation mode guest configured. But the MR of the address space
>> has two overlapped subregions, one is nodmar, another one is iommu.
>> As the naming shows, the nodmar is aliased to the system MR.
> 
> OK. But why two overlapped subregions v.s. two separate two ASs?

TBH. I don't have the exact reason about it. +Cc Peter if he remembers
it or not.

IMHO. At least for vfio devices, I can see only one get_address_space()
call. So even there are two ASs, how should the vfio be notified when the
AS changed? Since vIOMMU is the source of map/umap requests, it looks fine
to always return iommu AS and handle the AS switch by switching the enabled
subregions according to the guest vIOMMU translation types.

> 
>> And before
>> the guest enables iommu and set PGTT to a non-PT mode (e.g. S1 or S2),
>> the effective MR alias is the nodmar, hence the mapping this address
>> space holds are the GPA mappings in the beginning.
> 
> I think this is same on ARM, where get_address_space() may return
> system address space. And for VT-d, it actually returns the range
> of the system address space (just though a sub MR of an iommu AS),
> right?

hmmm, I'm not quite getting why it is similar. As I replied, the VT-d
emulation code returns iommu AS in get_address_space(). I didn't see
where it returns address_space_memory (the system address space).

> 
>> If guest set PGTT to S2,
>> then the iommu MR is enabled, hence the mapping is gIOVA mappings
>> accordingly. So in VT-d emulation, the address space switch is more the MR
>> alias switching.
> 
> Zhenzhong said that there is no shadow page table for the nesting
> setup, i.e. gIOVA=>gPA mappings are entirely done by the guest OS.
> 
> Then, why does VT-d need to switch to the iommu MR here?

what I described in prior email is the general idea of the AS switching
before this series. nesting for sure does not need this switching just like
PT.

>> In this series, we mainly want to support S1 translation type for guest.
>> And it is based on nested translation, which needs a S2 domain that holds
>> the GPA mappings. Besides S1 translation type, PT is also supported. Both
>> the two types need a S2 domain which already holds GPA mappings. So we have
>> this internal listener.
> 
> Hmm, the reasoning to the last "so" doesn't sound enough. The VFIO
> listener could do the same...

yes. I just realized that RO mappings should be allowed for the normal
S2 domains. Only the nested parent S2 domain should skip the RO mappings.

> 
>> Also, we want to skip RO mappings on S2, so that's
>> another reason for it.  @Zhenzhong, perhaps, it can be described in the
>> commit message why an internal listener is introduced.
> 
> OK. I think that can be a good reason to have an internal listener,
> only if VFIO can't skip the RO mappings.
> 
>>> So the second question is:
>>> Does vtd have to own this iommufd_s2domain_memory_listener? IOW,
>>
>> yes based on the current design. when guest GPTT==PT, attach device
>> to S2 hwpt, when it goes to S1, then attach it to a S1 hwpt whose
>> parent is the aforementioned S2 hwpt. This S2 hwpt is always there
>> for use.
> 
> ARM is doing the same thing. And the exact point "this S2 hwpt is
> always there for use" has been telling me that the device can just
> stay at the S2 address space (system), since the guest kernel will
> take care of the S1 address space (iommu).
> 
> Overall, the questions here have been two-fold:
> 
> 1.Why does VT-d need an internal listener?
> 
>    I can see the (only) reason is for the RO mappings.
> 
>    Yet, Is there anything that we can do to the VFIO listener to
>    bypass these RO mappings?
> 
> 2.Why not return the system AS all the time when nesting is on?
>    Why switch to the iommu AS when device attaches to S1 HWPT?

no switch if going to setup nesting.

Just got a question on ARM side. IIUC. The ARM emulation code will return
the system address space in the get_address_space() op before guest enables
vIOMMU. Hence the IOAS in the vfio side is GPA IOAS. When guest enables
vIOMMU, the emulation will return iommu address space. Hence, the vfio side
needs switch to gIOVA IOAS? My question is if guest is setting S1
translation, and the emulation code figures out it is going to set up
nested translation, will the get_address_space() op return the iommu
address space as well? If so, where is the GPA IOAS locates? In this
series, the VT-d emulation code actually has an internal GPA IOAS which
skips RO mappings.

-- 
Regards,
Yi Liu

