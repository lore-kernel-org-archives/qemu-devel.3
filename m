Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D54CFD2F6
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 01:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNLX2-0001kb-HZ; Sun, 23 Nov 2025 20:38:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.c.chen@intel.com>)
 id 1vNJtD-0004F0-8l
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 18:53:07 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.c.chen@intel.com>)
 id 1vNJtA-0005vg-Bj
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 18:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763941984; x=1795477984;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oOztU4UwE2rwgLQeewW2asiVLkWFZrQinixUzTbgUG0=;
 b=ZXIq3F87h72t+S1NHzsk0xTBekdhnqms13RrCe6yedE1XkNGW71S2Hmi
 7slEyTGfPiCfJdY8kUWgvqMC8bO6xA71+hrL6LAh7oCcEJ9DBtw7zpdLC
 fxJ2tHf98NyV9ynL3Mp+ijOkojD6OjYnZGqc9nLPHd7vYZhyGX6T9I8Xe
 NkDzm5mXQcJOq5HaksAlYXMQLeP4GeYX2/EYN+gZii6d9MxgMqxuzjWAy
 bIdJFi+PXZZZqdWc/OzVMqjbasLK1nKxUTXnQmV+BPhFyBrQeMh8tTeJ4
 YgqGFSEUOLIAhEp/fhEA06E8sdsQ5cVUeSvQxNKajeKpVfznAeZgIPgQe w==;
X-CSE-ConnectionGUID: zLm8ZC83SNiGoMBy8Fd1JQ==
X-CSE-MsgGUID: 622T0K0eTb2zS/dnGAOz7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="77052335"
X-IronPort-AV: E=Sophos;i="6.20,221,1758610800"; d="scan'208";a="77052335"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2025 15:53:00 -0800
X-CSE-ConnectionGUID: YDHCJIhLQcm89sZl0ZysLw==
X-CSE-MsgGUID: eVFrGHcDQEmKIJnhejS8Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,221,1758610800"; d="scan'208";a="197298745"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2025 15:53:00 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 23 Nov 2025 15:52:59 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 23 Nov 2025 15:52:59 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 23 Nov 2025 15:52:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnR3QLY2VwM0IXNQYqnNWH3LHM98n2FhvWrRnU2W3eNC/AWxWZu7hK4PdSKwfB3J4x4Ta0u6Z1WgiGD0GwtY9zgz9pHGruiQUds8dV5a07jj+MM+OipULjmlXMMd2F53C9UHkVJ8AKLx7X2eqyiINl5h8bFJbG3F82fsIbKhXNxRYfM42B4JjDd5yW3/9/VSduDUaDJf2Jbk3NChAcuHfqiYQEcvAobC3E0FWmQrNuwpJ+HZK5I3tsmKz4XuuGn2DihOMjoOcm/6N/nU4GuNxhJvsrF0RDsHjbXzb6sg1TLa3r1MEINdBm3KYfFQfWqZPo+SZ9+9wZYhNe3M5bmx8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoqAOFP+zZvmHU8chhO6kV4kXj3+MRlseV9q2m9HUXo=;
 b=X8TPOmXKMP+TGlOmyduZ0DQtr+p8Ma+O3f35nopbrdmxeiQuXGTt7Dxje64g7UajtR2A14FoEFcidq0sGBPgZYqA/TP6M8d5gEZMcfV60Iej5Ap9QR2O8446QCJPuKdNcz0vHY8tC9BiHOVE5f2ImGgF3gxKMgb+4K7T2/rBzwDJBvKfp7LjJQpHJrbQcZ31S8MNIRfAA48VyqTPQnUBIjUJX3JrMclTtpPluVJNgzb9JcsO3bBvwV9fxjzP0YdjJJPa8m3zESrS1OI99YSHKpqZMtrgUiylgzXt8CA4SbXcoNGX2zM0AD9Yn07IoDOmTq8lK/zqi7J3qMLGt6NepQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.16; Sun, 23 Nov
 2025 23:52:56 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9343.011; Sun, 23 Nov 2025
 23:52:56 +0000
Message-ID: <88580394-372e-444a-8484-b7a50ea175c7@intel.com>
Date: Mon, 24 Nov 2025 07:52:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] dosc/cpu-models-x86: Add documentation for
 DiamondRapids
To: Zhao Liu <zhao1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, Xudong Hao <xudong.hao@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20251120071030.961230-1-zhao1.liu@intel.com>
 <20251120071030.961230-11-zhao1.liu@intel.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20251120071030.961230-11-zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0019.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::14) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SN7PR11MB7420:EE_
X-MS-Office365-Filtering-Correlation-Id: 45026e83-1415-4699-a1e1-08de2aeb6c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGdNcmsxUWR1d2kwTHdNYjExRHpYUitld2JkQzlIemVGYUNuNmo3UFhVZGNO?=
 =?utf-8?B?SmRMVm4rRXBCdTg0OHd2ZDMwbGJ4QlJZcVk5U3MvK01zWm9rMHIwaHdaZVdO?=
 =?utf-8?B?YnVlbDFUd0RKbkRJcVpBZnA4VndvUk1rTjdnYXhSL2RodE5FNFlOaFY3OXQv?=
 =?utf-8?B?V1k0SzRSMXlqbFVJVFNjdi9XQ0NpcU9naWpKRjJMb0tURmZFRURyZzRMT1VU?=
 =?utf-8?B?YjNIY1NVQnFGRXBmQk1ZUEdYMHhvQVVBTC9SL1J5OWpEaUhYMnNOWmtZazFm?=
 =?utf-8?B?UjJwaTcvdWE5RU1LS2ZoZUJuczJpSGpQeEdtU1VZMi9WOG1acHcxMHpoTVN6?=
 =?utf-8?B?SWhQS2Y0SkppZU9EZGVmZDBMaFpmZ2RIK2ducTBjZ3E0Qlk0TnY5NnMrekxI?=
 =?utf-8?B?ZW9PMjc1Y2dtbUs1aTZXUlVaVVY3YVFGa2RRRGlXLzV5Ni9VaW51MG8xbWtJ?=
 =?utf-8?B?cTBPWWxLVVM3U2FxWnVTZVBlMHdLS1ZjaGJtRnBWYXNBdWlFNU1Cd29XYVpi?=
 =?utf-8?B?Unl3VVVtaUw5aEJWUERQQnU0S21FSTk5eE44TEE2Szh2ZzJZcTJ5Ui9NcFBu?=
 =?utf-8?B?KzIwMGVlZzF3b2ZTSExGeU5waG1ON2kweE5rcERjVmd4V2R5cnRhbS8wMUdI?=
 =?utf-8?B?WVAveTF6TWYramlYM1NhZHkwRmV0eFZVR1NMSk1FL2Y2Ti9KZ2ZsaVF2c3pF?=
 =?utf-8?B?WkxaVGZabU1jM0w1OFJNMGU1aGt0elYwNjFnTTdMbGdIdG9seXhub1JBWmx5?=
 =?utf-8?B?dG1ZaGJxSVAxUWs5eDBLQUZHWU1Qdk5qajAwbEtnNFE5THBSTHZxd2RwQmg3?=
 =?utf-8?B?cWxzTHFudWpnZ2R3UnNQZEVNMWUxVHhjSCtVZU9RZFNma3l4dDkzYWczSnhD?=
 =?utf-8?B?c3NiYUhOOGMvbGxnZTI1UlVJWEpwRHIxdEwxTDJkTFQ1RkNiUkZod01oZzZ5?=
 =?utf-8?B?QWRyUVBNeE95Z2FVd1pTMExBYlZ1Vm1ySzdZZjlXN1M1dWZ5VlMvbnkzdlpS?=
 =?utf-8?B?MVRTM1MxdVc2SVFQSHpLamxhdnZKK0RKUDJEY3l3VzkyQWFXZklPTFMzeTNT?=
 =?utf-8?B?V1c5TXFiazJhVVV4bElNUE5wQ2w2UzhuK1VDeHRtUDJ6MzZJNTcrTXgrVVQv?=
 =?utf-8?B?bFJzdmhFUUk0NnZVZ0RMa1FGZnFwWmpaNXF6cUtHTHl6VXczMXcwZ1JFWFlM?=
 =?utf-8?B?ckJEMEJ4UzdZZjdXd3h4K1dEZjRUaDVUSERxT2FtY2ZsaEUxZHU2T2hyZ1F0?=
 =?utf-8?B?RWYvbVFMVEZyclptOEZqeFEybnB2dlphR2g0TTc4MkI3ZVZEbTRMWDd4TFFa?=
 =?utf-8?B?S2xTNlJGUGFlWWZ1T0t3QTZNM3U1Mmd2cUJZakJ5RjRzTEZFZnNyaFpJMTJT?=
 =?utf-8?B?Q3V6ZEd4R1BLQTZEZG1KZ3FpS1RJT2lTYmVZYXIyU2R3dUIvak9pRjJGK0Zn?=
 =?utf-8?B?NHJaTCtaV3dXQjgzL3dwdVJYODVXdWxVbStVVXlNYkxsRi8vcVJMWVpWMWJN?=
 =?utf-8?B?cDY4c2REMmxWc1hGYzRsRTlNVTVRZG00ODVyYk5RWnpYbXVsclkxZm5UR2I3?=
 =?utf-8?B?SzZzKzhJRm1ocnpBWGd4QkVjd25xbnhuMjMxQVd2SnBlZVlnUDFWY1RMdDlm?=
 =?utf-8?B?NnpWR0NYVFhTWk5mQVN3elNZd3FvRVFQVjA5MVljeUwxS08xRXlJc1JTK2ZX?=
 =?utf-8?B?WTg5SjVuc3V2NTZYOUpnU0pyTmhQQlQyaVM5aDZkdVkxN0NwRFcwNlBPcjZr?=
 =?utf-8?B?Wkd0V2JDRGwxNkVjd05WcUFCWWxMNVlEWjhsTlhQeWhtTFVlR0tNc1hvUzVO?=
 =?utf-8?B?OWwzNDlTL05obGloZ2dPRis5WDduaEFFU2ZMclhQRElVMERCVjJLQWdmeEwr?=
 =?utf-8?B?dGFhSHJDYTZ0VFhSRFlUampSNms5ZTRoUlRBaHk5S0NGcW80WkVVV1JCbmdm?=
 =?utf-8?Q?OPpZKWfePvvKrykyCSU3fyiCS8gNH40o?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6020.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEJFa0I5THRDb09YMUhydzZMWGlRVlo4Z1VyTm1HcEFqeG9RT0I5L2ZzN0NS?=
 =?utf-8?B?YkU3VjB0aGtKc21lVTZYcVdLZTIrZG5taXUzS3h6SkhYV09zOE0vYjhKWCtt?=
 =?utf-8?B?aVh1bG4yUVR3czladVJuZ1dJVFgzM3ZPZlZidzdUbUtzN2N6eUdHWVhHYStK?=
 =?utf-8?B?cWd1eFN5a3pDdytITXdybTdyeERyQWQ4QUJyNmpzV0JaY2p5dXozdWZJTUwz?=
 =?utf-8?B?OFB3MSt1cXE4cm1XWDNRNEJBbEVudHlGVExVZGgvL2N1ZkFmR0o4TU1yWVJ3?=
 =?utf-8?B?cFFjVnEzZ3hyUVhHZGNvZmVuNXJlMjNaM3VzNk55RXhOMHJ5eTNPeUUyU08x?=
 =?utf-8?B?NnozeVVlTndMMm9uWWlMdUxrL2dZY2gyOTM2bWZZdXl3OWtORWlNVGMvRHpO?=
 =?utf-8?B?a2Flc3VFcllWTDNkMUtLTHB4Zis1NUFHemtLTEtvTUg4VEFWVDFtRzlMalhq?=
 =?utf-8?B?RU5KNFJsdkhkcWpKWElxOXl1QTBRK0pkTEFINk96dlFnSEhlU1lvbUlrMzdS?=
 =?utf-8?B?azl4OElMRFFmTmdjaU9ibGlYcVFNM1V6d2VuK3M2REpyM0prRklwbkxteno1?=
 =?utf-8?B?Sjl0YktYZi85d2w2MnV4US9hRU14MkVJTGx3Wk5CcWttMGFDK2R0TnF2L2hq?=
 =?utf-8?B?eDA1TVMwclNsZHVhSkVIRkIzUDdzeUFZcEM3RzJ1bU5YNG1wVTArZ3Nsa0Jm?=
 =?utf-8?B?K1M4SEJJTE9aUU1FU1EzS204djlJbGNLZk5SRWtxR1F6WitWKy9oZCtqK3FE?=
 =?utf-8?B?NkJMdXU1SEFtU0EyQ0tFSll3NFdrR2ltUVpvMHRZeE0zTy9hb1ZPcGpDQ0pp?=
 =?utf-8?B?NE1QUi84TFo1Q05uS2o1b2d6WVdkSmo5Z1VEVzFyNHBPK0ZDRE1MZy9Kekxm?=
 =?utf-8?B?SjVLMmljR202bCsvN2FDa0hPbDQ3UXZKTlZnak1Ob2NvMGUvRjRrZFhuQU8x?=
 =?utf-8?B?SURoYk5icVJ4eWtvUkErRU1xZUFPU1BBcUJSd0RtOWZIdVJORFJlTFZFYnB1?=
 =?utf-8?B?RGo2YXlQTUxUZmZvU3oyQVo1UTQzckh4c3U1YXpRUU1VRGovQTRxRktZdmRr?=
 =?utf-8?B?bUh3N0JjbzlneE02R29sWWlpSms0Q2t4TDI5eTBST0pUKzRlT2txczE3Y0t0?=
 =?utf-8?B?dTZJckRKOVhtMzJRMFM3T29ISHpKMldYTUgwcGJmd3ovWFBEdmpPSGdjd2lP?=
 =?utf-8?B?Rk96VEVXUFBIZEs1a2ljcFV4T3hxWUhtZUlsVzBpV1E0OEVJRkhIYVZJU3FD?=
 =?utf-8?B?WnVyTTlXMUFnNFpyQWlUQ3JtMVhIWGVhNXAwRWt3amRhb2VRZU1YUnhCUDdm?=
 =?utf-8?B?Q3JlZnhqRTFpL01NdldYSjhCZ1U4UXg3UFFxTnhxL1dtbkFQYWpzdXJIbEhR?=
 =?utf-8?B?d3RjNVFKb0Z4YW9BYXVlTUpvcU0xOE8vUlZOVXVOQ1dhNmNIZnBJcmIvMHhm?=
 =?utf-8?B?elkvYnlNQnVHU05CTUFuR1FMNFFKR1BBbTlpdjVBTFBJVlZ4a3ZVNmsybkxW?=
 =?utf-8?B?aWlMUlVnS2dUUjVJRDQ3aXNOaHpBMjlWK0pOWlJOYXg0REtJQkhCUG9sVlVF?=
 =?utf-8?B?ck1GT2xyMmpUNlcxdlk3YzJJelp1UGg1VmZSbDh4UWdvR3FHUVpGcElxTHBv?=
 =?utf-8?B?eVRjaDFrd3YvditudGJleFliRHozUzVBMXd4UkVoOXVmLzlPM3BCekpaQ01v?=
 =?utf-8?B?OVRhNGp2UVNMYmJmKzZIQW5oSk1LUHprV2hJYSt5anFkcGU2QXQwRGtJdzdw?=
 =?utf-8?B?OE52QlpocTFkN1VBQ3lJR1BSK0N6T040ODI4KzNEcXIxSG5WS3U1TWpSa2lP?=
 =?utf-8?B?eEtGblRKakJVMkw5aWpYSE1WNmFiUS9pOHg5ZFZremduZFJqZlNQbkNZdmp2?=
 =?utf-8?B?cjBwdkNHY3QzdlRHY1Rrd2FpS2puZlhxSE9DRDRpSjZjQTRIWDg4OWtReElr?=
 =?utf-8?B?SitRRlZvUkJ3RXo1RUhBdU83TFRjcXg3RmwyRkliR3BRQWxmT1cwQ1l0UEht?=
 =?utf-8?B?ekFJNmszZU1NTUtkcmxwdTFaQ0pJaDlPbjNLTmRtd2ppQnlEdUM4UkxkVTZJ?=
 =?utf-8?B?Z3A4eXZVK3Q5STd3K1h1ZFM5aGtFVGdUMTFXZkg2ZjhtL2JYZTdaOE9pSWk5?=
 =?utf-8?Q?JWiqOgyy8bZthkd/hJZSuLcUs?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45026e83-1415-4699-a1e1-08de2aeb6c4a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 23:52:56.1535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+95cjZL1I18GTf6pQT2UAP2oTRtCEcATK1uzIeQqYCOYxWH2J02noPkUmrJSjELTUi6xfp8A2LDArl1mulABQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7420
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13; envelope-from=yu.c.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.161,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 23 Nov 2025 20:38:14 -0500
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

On 11/20/2025 3:10 PM, Zhao Liu wrote:
> Current DiamondRapids hasn't supported cache model. Instead, document
> its special CPU & cache topology to allow user emulate with "-smp" &
> "-machine smp-cache".
> 
> Cc: Yu Chen <yu.c.chen@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---

Reviewed-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu

>   docs/system/cpu-models-x86.rst.inc | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/docs/system/cpu-models-x86.rst.inc b/docs/system/cpu-models-x86.rst.inc
> index 6a770ca8351c..c4c8fc67a562 100644
> --- a/docs/system/cpu-models-x86.rst.inc
> +++ b/docs/system/cpu-models-x86.rst.inc
> @@ -71,6 +71,26 @@ mixture of host CPU models between machines, if live migration
>   compatibility is required, use the newest CPU model that is compatible
>   across all desired hosts.
>   
> +``DiamondRapids``
> +    Intel Xeon Processor.
> +
> +    Diamond Rapids product has a topology which differs from previous Xeon
> +    products. It does not support SMT, but instead features a dual core
> +    module (DCM) architecture. It also has core building blocks (CBB - die
> +    level in CPU topology). The cache hierarchy is organized as follows:
> +    L1 i/d cache is per thread, L2 cache is per DCM, and L3 cache is per
> +    CBB. This cache topology can be emulated for DiamondRapids CPU model
> +    using the smp-cache configuration as shown below:
> +
> +    Example:
> +
> +        ::
> +
> +            -machine smp-cache.0.cache=l1d,smp-cache.0.topology=thread,\
> +                     smp-cache.1.cache=l1i,smp-cache.1.topology=thread,\
> +                     smp-cache.2.cache=l2,smp-cache.2.topology=module,\
> +                     smp-cache.3.cache=l3,smp-cache.3.topology=die\
> +
>   ``ClearwaterForest``
>       Intel Xeon Processor (ClearwaterForest, 2025)
>   

