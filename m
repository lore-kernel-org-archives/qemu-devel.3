Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721ACCCD187
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 12:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7v7V-0003Df-TT; Sun, 12 Oct 2025 08:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v7v7Q-0003DN-L5
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 08:24:08 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v7v7M-0001wa-GZ
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 08:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760271845; x=1791807845;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zS58L9wXrTrAo52CZt05iGwR62vaSvs+7ApqGzADYh8=;
 b=nI/H4uC/gnH4MByoAONW61LMBd2DtlsGPZdI7pfYnlVeJclJNAGFxyM9
 7d43O36XmiWsMNVG02oPRi8REKcmtxF6f9KwHzhsXmEqh20NQUWB2poiW
 OE56ipFentgJE9Rzc1T17kpX9wGtQ96lqbTj5Ej8Tt7fKdtI7YvuS3UuD
 nrRrSnjYMZ+waqPxLBLl5J0eCL2mCs7pB7DYsK/T5/Z0+zaJKdGVLVhLv
 u0Yr7XlDUp+WrmU1VmT+ipomEpq+px1wgxfM5bgSIhd1rPSuO4jes8nht
 R8KQIiH0tHp3mXnC9jtkC0xLTHAfZwFrNPgKM1VjZAQNHw+zp9EbMJmj0 w==;
X-CSE-ConnectionGUID: nAGz3daDSi6H+qPM3CZPGw==
X-CSE-MsgGUID: ZMXM57ZXQeejWWJt6jlCmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="62126458"
X-IronPort-AV: E=Sophos;i="6.19,223,1754982000"; d="scan'208";a="62126458"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 05:24:02 -0700
X-CSE-ConnectionGUID: eCuoB4edS22yidSBNXCMDg==
X-CSE-MsgGUID: zd3P4zXmSmuiT+/f6QmV9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,223,1754982000"; d="scan'208";a="181790152"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 05:24:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 05:24:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 12 Oct 2025 05:24:00 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 05:24:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaMinZSZpgH8cLxnalOucj1PZpM26LIDSYdEIlC3yR8hVV+ahBZdG9lSY7wuGp6dD0DoizB66gASzv4tBLn88iFcjgPSGt9z5Q2hoqfE3sx+FZhKFWjJQH55BLHO4ZkBJxB3XgBr3yQhn+24JSmgadZbA+NByvx7ZMzxuO7G3sjBVztNKYGEF1MlPOvkJ4GKbsC0cPrA6yKuT0j0oSIL7QM4D0HVuyERZAmnMREnbMZL8xXxa4gtarXfMKqB1AzA62mtNGismDK7c+jbTkNDB27Jw1mZw1NSTGY7mx73ZpmCLzjxJF9oGkD3n72ClkMLDVmX2ewsJE6yaIiMirtXUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kxjl+F8bO/bK6/rzdPHnI3mLIEtc5ufO6LbTOLyKjE=;
 b=P0dRyMq3Pm6Ro0aqftv37waPTKgG5mdPqbO8EsuaGwxpIbFSAnm2ulz6HWHmV4qdfJjZ/fRAsMqjyZjqYTHYZN5ozoGYs+PaZYda2ssX0cwmPbuXT5rC7FpDJIjiZyq98L2cAIDiSVFOzIySsAwxLR4Rv8K3ZnBlGZrQo1DYD5C3L3o4GgdEq38YQRzlP9a62AWFzXy0UgYpMomYW5R9/Kmsu8g41E24+3IzVErd5RPlGcHCKUiyXZ1zB4hbU0iMBtUbQO0QvOEtmbKXaEP+WC5RxnpBBKNndn0s9EhPA+gucyIbNAf1zmEQ9/XPvuRP5jltRVJnY8FMS38ihHIiAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by CH3PR11MB8704.namprd11.prod.outlook.com (2603:10b6:610:1c7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Sun, 12 Oct
 2025 12:23:57 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 12:23:56 +0000
Message-ID: <7c7055dc-7e24-4bb3-b179-6d07b2e89e90@intel.com>
Date: Sun, 12 Oct 2025 20:30:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/22] intel_iommu: Delete RPS capability related
 supporting code
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-3-zhenzhong.duan@intel.com>
 <2a12ee15-6314-4c03-ae2b-fb0e0809c924@redhat.com>
 <IA3PR11MB91368FAFAEE280E24B5AD33892EEA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB91368FAFAEE280E24B5AD33892EEA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU1PR03CA0037.apcprd03.prod.outlook.com
 (2603:1096:802:19::25) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|CH3PR11MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e76987-33c9-4356-774f-08de098a36d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|42112799006|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3pzdTJaa0FIOEFrMzF5c0c1d2ZDdEZ2Yjg2c0o0SVVDbkdiMmR4MGEwK1g3?=
 =?utf-8?B?K2dWdXRhKzE2dTE0RzNlZFZNZllJNFZuUjA1b1l3WEljelZuUFhxM3dtOFlh?=
 =?utf-8?B?Uks3cFMxR1JJQjA1OWZ4RldYR2EvS0ZhVWJlNjlPTnFTWDBGQXQvRTh1S1p5?=
 =?utf-8?B?Smhidktmd01PVFNxa3BDTVlkTi9GRytEZm5SbEZQK1o5c0tZaXlCRkxYT0JO?=
 =?utf-8?B?bXR5OSthVHlGL3dubys3SmRnTjFXM3A2cUp4dlhTVFJtU3NScGY4RExSNFdS?=
 =?utf-8?B?eC81ZHJEdVhsTTlUL2hLOUN5Vk1SaHcxRGVMUXBtQUhvZHFmR2lYd1JIcS9B?=
 =?utf-8?B?Y1MzUlh1NVdIb0x4T3JWZkdrenpZZS9Sa05XdU9CYnFOWVhFTk80UkxlZ2xo?=
 =?utf-8?B?N1FZQ2ROZUZVSGFKeG1Hd3JxcUlXZ0FjK2JaRzJ3N0JNbVFrU3N4UUY3QTdT?=
 =?utf-8?B?c0tXdU9GWFdRQ3ZKVHR2SytwMVBnVFJwRS9BNllFdW0rRHFacmU1ckhFL2tK?=
 =?utf-8?B?ekJBRk42cHp2dzNOVWNocXNHakJWT1N3amExTkhJNkZBaWVOVDB0NHc4dGhO?=
 =?utf-8?B?V0RvU1o2Z0pyTWdOb3k3d2RiS05NajUwZy8wSlp4ZGIzdGdKbGRUbUYxQTZy?=
 =?utf-8?B?am1CdVZWdW8rNmNVSkJUSFVjU01VVjJ3ZU9RY0NsMEVpMGtwUWRRMGJ5cW5j?=
 =?utf-8?B?ZDlFa1BjWjRLTG1rcXV0WXljcTNpTFNDc1RZYlNOdzNLajkrL0laRGRKaHdZ?=
 =?utf-8?B?U25NUGJsVzJROFlOTzczVnpXQmFMMHRWSmhva0VrK05NL0NDZDVvbVU0Qzd1?=
 =?utf-8?B?dTd2VXJMcWVaOEs3ajhPL0F6TmplQTVNSlNIRmhRR1ZsRGtURFcvZ1BOZEpI?=
 =?utf-8?B?cnBXZk5idDB4UmVNZ1hPZm96LzBva1BjbVNvbEVzK0NsWkVSQXcxU1ZLWHFR?=
 =?utf-8?B?b1FPaVFVZ216dkx5OTF4K3JlNzVzUER5d3lPdzRWUVBEUDZoSnJUTUFWVDhZ?=
 =?utf-8?B?eGhLd2ZkV05SRzZhd3hRRzB3V3hGQW40bWhPZnNkdVN5M0R6bkFUTXBrajA2?=
 =?utf-8?B?ZTRydWZxQUx6em1MZVFCRXdCbVpuZS9MQm5FL3dESkh5S1lTeTlySDdLWXV6?=
 =?utf-8?B?QUY0QXljNkExaEtGTGRFVndsZ2NyekhVUTdiaVRsT2h2YkVYR2VqTGsxdUFk?=
 =?utf-8?B?SDNna2d5NTlXMjBiRUJCSHE1aWZnYTlFZi9WWWFiREx5N2R4Vkhnakl2Q1k4?=
 =?utf-8?B?R3JaYVlseHd4RnpwaHg2TXdLMmVVR1RRVWZmUFdGL1kzSVhPcEYyNllOSGV2?=
 =?utf-8?B?TGVUZEJTQnhMbkRBbUVWOWhsWS9OaEpyT09yYXdRZ3JWNmx3UTcwZDdHVmEy?=
 =?utf-8?B?d01IV0VRdTM0ZUVWbE5WWGJvT1ZOK09sUXR2VWhrVWZ3OEsydElNc0Z5RWts?=
 =?utf-8?B?WmVuVG55amF5YlhURHgzV3V3eUJ5dVJ6dWhNbTBLOWI2VGpBTkE0T0pzOW9C?=
 =?utf-8?B?Szk2ZmJFTStaQmpXNm1aT1J1MjY1U0lGdG15U0ZtNCswUlUzTDdFM3Bjd1lh?=
 =?utf-8?B?YXNWMUZNMUxWSU9nSVpRYW5salBHQnVjc2wwRWRua25Pd21WWnEwS2ZGMGhF?=
 =?utf-8?B?STV5ZkhmdmlrOEt6QUFkZWhLVnd2dUNobnJxNnhvUTBaelhWMDBtOVpORHpy?=
 =?utf-8?B?VG5kMGhBMGpVOXMyRlNTNmd2d0pkRWZUVkF0RUJxaFF6dFVXWjJtNkNLSFpZ?=
 =?utf-8?B?dHJvMVdmT3ZvV0F4T3ZnbmFRM3RGb21kNGFSZzU0VnNBb1dzZEtqT2hKMUtR?=
 =?utf-8?B?QVdVZXVneG0wcDNsUUdjazRlTXAwOFdjTzZaTWRFSXNIMkxzeGZ4SWNtVVFM?=
 =?utf-8?B?d2h4c0swNWZaQTFBRkFMRFJ0THA3c1F4Rkx6L3FCNXEwd2E1eVg3TGpOWTMz?=
 =?utf-8?Q?APAmredQwcX061r71Lpy0au3b5DU+BFR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(42112799006)(7416014)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlpoUUZrdkJGazIvTm91amV5cFJob3JITFZqYUZCNVNiQWFFU2l6WVl1bmZy?=
 =?utf-8?B?aUY3NTBCc3VaUWpsZUFTR0ZEa1g5eEdveDVRTlMwMVhMdGEyMDQxS1dpS2xj?=
 =?utf-8?B?QjM5M0RIS1NvU3RLUmJrMXZqRkVaaUNTc1VOamFRMDFGckRUb1BZaDV6RURJ?=
 =?utf-8?B?QVVxWkpsNmo0UzNsR2NWV05nS2JNZFdsOGtXbHRMWmtHOXB3Nk12emJMakp0?=
 =?utf-8?B?VGhWOTExUDNPWUpFbHcrSDlLNmVLSlZQUzJ2OW1tajcrOE5QaVVsbFhWZm1U?=
 =?utf-8?B?MnpQaDg5TnBLemhlVS9xQmhqN2VJMlVlcXBMYmxUSHd5ZjM1dER0ekdVYVNl?=
 =?utf-8?B?c2xxcWNFdGJSTXMzNUxnQlpudDNqak1Cd3IvNmJHTTM0TkRTWkM5OTB1TGkw?=
 =?utf-8?B?bk1qZnd4emF5b3ExZStuOXNicjl3ZVF2emcyUDBqOWRxVHZ1cXhGck4wUWdx?=
 =?utf-8?B?Sk5nS0RKSjBzMzg3Z3NKRThmcDkxekZCekZzSU1IVjFNaVpOM28vNkQ4cTVQ?=
 =?utf-8?B?RlR3MFNLcjg2QkFseU05Mmt0bXFVVFdDSDNqaXhuWlAzSEQ0eThyK0pMY3pw?=
 =?utf-8?B?amJESlNFcExTbGlIc0F1YVVMTVhsL09XYm9kMmNKNTYveS9iMjVVS1FIdFhs?=
 =?utf-8?B?SWFNUFQrRkE5U2l1OFBXdXRxOEw5d29GNGpkZ0NFcFpXdW1FcUNXM05RNTBh?=
 =?utf-8?B?TlNvaFIwTnVRZGkzbEFQME40OWF4eStiYjZaZUdlTUY4ZjBRcTVTbitkV2lJ?=
 =?utf-8?B?QXNlWWM2UlMxMlFJVWZCLzNDVVpZcDlxeHo2WkpVc2ZpWUt1dnFJTVRTMmd5?=
 =?utf-8?B?RVgvSXNtNlhvM0NGOGpqTlRzSzlLdHl0QS9ORXdydkE2TFhOMjBtZnZxL1lh?=
 =?utf-8?B?VWo1VlQvRG04NDRINlNiaHBLQTlLYUdFcEJURzhuZnQ1aTRiYWZudVRhUHpG?=
 =?utf-8?B?TjM2M1RZcmNvdzAvT2RhenJuWm1OdkVzS0hiWjd0dVliZEFYSHZjVmZwU2h3?=
 =?utf-8?B?Rk9rS1piYy93N0IyMlpGTE5yUWhpMExybWNheG52d3kyWkNyRGp0Q1hVMU9Y?=
 =?utf-8?B?cUY5ZjNSTjkvNVRKQmRGZk94SlFWdTFyYVNHNlVhQkZlUGJDMWFUSkpOVjg4?=
 =?utf-8?B?Q1VxUUg5MWUramlscHRvMkU0N1VKTlN3VHpzQkRhQ2RENmMzcmxjUWJtaWtz?=
 =?utf-8?B?RW1Zb2F5SnJnc0MzMlBYazhwSUZlMW9SZEdLYi9NaGxoaDcxRVV5NUVGenBQ?=
 =?utf-8?B?MXltNU5pSy9IdFEyUDZCR0VnWVlSZUY1S2lsRzB1Q3JGTDdZU3lsL1RROVd2?=
 =?utf-8?B?NTg4RHFadWxUczhzVjAxN3RVQm80VFVQN0Y0cExIbkVNVkttQzhEeVNBMVc0?=
 =?utf-8?B?N2hKd1ZFSVR2Zmo0Rm56QmRZaHc1WGlyUnN3QnAyRzQ2eXNQRnkyT04veW94?=
 =?utf-8?B?a2lNcDNFU2NaV2t6VkQreG41c0h5U090OS9RWVpCZSs2ei9CZGRoQ1BQZmkr?=
 =?utf-8?B?bEprODJNR24xTFlmaXBnKzhCa0tXSFFWVlpxMTlDRTZVQTlja0lvSXQ2dmoy?=
 =?utf-8?B?cDFHa0tuTTNKR2ZZUnl3aHJuZExjeGR3eXRUZ2F6Y3o3S3kzVkZGOUpGWUtN?=
 =?utf-8?B?YjBmb3BrV1I2OFdUUFM4aDZPd1BXVjJxck9XellmZkdoMGNhcldwb29mb29X?=
 =?utf-8?B?SmtmVU82SkEwd1JqQnhpb2ZXSVgzMlNKeG5RZzVNL2szNzhuZUlEdVcvdFBN?=
 =?utf-8?B?VG5rVGRzdnhhUFAxRzByWGVDb01KUG9UVVhCZEVKRFNJV3B6aE90SDdsNHk1?=
 =?utf-8?B?MUJXK3ZFOUpQMm1CMFRxdGdwRzdqM0lFbUMwT0swZzVibkJUT3NmejNzNlpB?=
 =?utf-8?B?U3YzSDc3U0dSbWkxUStwVCtVU1RPaEVWYnBZUzFvMktmbXk3STM3T3pCQWZS?=
 =?utf-8?B?UzRQemZLaDlwRlFMY2RyRU12QTVtbHhnS2V5Y21aa0prY1c3SDRBdXRSV1lS?=
 =?utf-8?B?alZ1d2VSZ3hZcE8vTUpVMVgzRlZScENya2FjS3JOczg4S1ZDa2h1cDllYUxq?=
 =?utf-8?B?S0haS3llMEpUTFBxenNhOEVkanByai9RSnRaeTVOTDZROHkxckp3WHcrOEx2?=
 =?utf-8?Q?q721INmBozHO830ZGSNi2+rWg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e76987-33c9-4356-774f-08de098a36d4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 12:23:56.5924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJdZVLJgOX3YkRUY+OG0d2WMsu5WmOQw4xofOV0ZvdWNzWWs1ST/hHvQwS5/EziK0HlxZ+8OIB9G68lrc/YLMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8704
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 2025/10/9 18:10, Duan, Zhenzhong wrote:
> Hi Eric,
> 
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH v6 02/22] intel_iommu: Delete RPS capability related
>> supporting code
>>
>> Hi Zhenzhong,
>>
>> On 9/18/25 10:57 AM, Zhenzhong Duan wrote:
>>> RID-PASID Support(RPS) is not set in vIOMMU ECAP register, the supporting
>>> code is there but never take effect.
>> takes
> 
> Will do
> 
>>>
>>> Meanwhile, according to VTD spec section 3.4.3:
>>> "Implementations not supporting RID_PASID capability (ECAP_REG.RPS is
>> 0b),
>>> use a PASID value of 0 to perform address translation for requests without
>>> PASID."
>>>
>>> We should delete the supporting code which fetches RID_PASID field from
>>> scalable context entry and use 0 as RID_PASID directly, because RID_PASID
>>> field is ignored if no RPS support according to spec.
>>>
>>> This simplify the code and doesn't bring any penalty.
>> simplifies
> 
> Will do
> 
>>>
>>> Opportunistically, s/rid2pasid/rid_pasid and s/RID2PASID/RID_PASID as
>>> VTD spec uses RID_PASID terminology.
>>>
>>> Suggested-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>   hw/i386/intel_iommu_internal.h |  1 -
>>>   hw/i386/intel_iommu.c          | 49 +++++++++++++---------------------
>>>   2 files changed, 19 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/hw/i386/intel_iommu_internal.h
>> b/hw/i386/intel_iommu_internal.h
>>> index 360e937989..6abe76556a 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -547,7 +547,6 @@ typedef struct VTDRootEntry VTDRootEntry;
>>>   #define VTD_CTX_ENTRY_LEGACY_SIZE     16
>>>   #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
>>>
>>> -#define VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK 0xfffff
>>>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL |
>> ~VTD_HAW_MASK(aw))
>>>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1
>> 0xffffffffffe00000ULL
>>>
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 71b70b795d..b976b251bc 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -41,8 +41,7 @@
>>>   #include "trace.h"
>>>
>>>   /* context entry operations */
>>> -#define VTD_CE_GET_RID2PASID(ce) \
>>> -    ((ce)->val[1] & VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK)
>>> +#define RID_PASID    0
>> I would call that RID_PASID_0 to make it more explicit in the code
>> or even it is a PASID to PASID_0 would do the job too.
> 
> OK, will use PASID_0
> 
>>>   #define VTD_CE_GET_PASID_DIR_TABLE(ce) \
>>>       ((ce)->val[0] & VTD_PASID_DIR_BASE_ADDR_MASK)
>>>
>>> @@ -951,7 +950,7 @@ static int vtd_ce_get_pasid_entry(IntelIOMMUState
>> *s, VTDContextEntry *ce,
>>>       int ret = 0;
>>>
>>>       if (pasid == PCI_NO_PASID) {
>>> -        pasid = VTD_CE_GET_RID2PASID(ce);
>>> +        pasid = RID_PASID;
>>>       }
>>>       pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
>>>       ret = vtd_get_pe_from_pasid_table(s, pasid_dir_base, pasid, pe);
>>> @@ -970,7 +969,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState
>> *s,
>>>       VTDPASIDEntry pe;
>>>
>>>       if (pasid == PCI_NO_PASID) {
>>> -        pasid = VTD_CE_GET_RID2PASID(ce);
>>> +        pasid = RID_PASID;
>>>       }
>>>       pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
>>>
>>> @@ -1510,15 +1509,14 @@ static inline int
>> vtd_context_entry_rsvd_bits_check(IntelIOMMUState *s,
>>>       return 0;
>>>   }
>>>
>>> -static int vtd_ce_rid2pasid_check(IntelIOMMUState *s,
>>> +static int vtd_ce_rid_pasid_check(IntelIOMMUState *s,
>>>                                     VTDContextEntry *ce)
>>>   {
>>>       VTDPASIDEntry pe;
>>>
>>>       /*
>>>        * Make sure in Scalable Mode, a present context entry
>>> -     * has valid rid2pasid setting, which includes valid
>>> -     * rid2pasid field and corresponding pasid entry setting
>>> +     * has valid pasid entry setting at RID_PASID(0).
>> s/at RID_PASID(0) /for PASID_0?
> 
> Sure
> 
>>>        */
>>>       return vtd_ce_get_pasid_entry(s, ce, &pe, PCI_NO_PASID);
>>>   }
>>> @@ -1581,12 +1579,11 @@ static int
>> vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>>>           }
>>>       } else {
>>>           /*
>>> -         * Check if the programming of context-entry.rid2pasid
>>> -         * and corresponding pasid setting is valid, and thus
>>> -         * avoids to check pasid entry fetching result in future
>>> -         * helper function calling.
>>> +         * Check if the programming of pasid setting at RID_PASID(0)
>> of pasid 0?
> 
> OK
> 
>>> +         * is valid, and thus avoids to check pasid entry fetching
>>> +         * result in future helper function calling.
>>>            */
>>> -        ret_fr = vtd_ce_rid2pasid_check(s, ce);
>>> +        ret_fr = vtd_ce_rid_pasid_check(s, ce);
>>>           if (ret_fr) {
>>>               return ret_fr;
>>>           }
>>> @@ -2097,7 +2094,7 @@ static bool
>> vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>>>       bool reads = true;
>>>       bool writes = true;
>>>       uint8_t access_flags, pgtt;
>>> -    bool rid2pasid = (pasid == PCI_NO_PASID) && s->root_scalable;
>>> +    bool rid_pasid = (pasid == PCI_NO_PASID) && s->root_scalable;
>> I am not keen of the rid_pasid name. It does not tell what is the
>> semantic of the variable. rid_pasid is an actual field in the CE.
>> does that check whether we face a request without pasid in scalable
>> mode. If so I would call that request_wo_pasid_sm or somethink alike
> 
> OK
> 
>>>       VTDIOTLBEntry *iotlb_entry;
>>>       uint64_t xlat, size;
>>>
>>> @@ -2111,8 +2108,8 @@ static bool
>> vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>>>
>>>       cc_entry = &vtd_as->context_cache_entry;
>>>
>>> -    /* Try to fetch pte from IOTLB, we don't need RID2PASID logic */
>>> -    if (!rid2pasid) {
>>> +    /* Try to fetch pte from IOTLB, we don't need RID_PASID(0) logic */
>> It is unclear what the "RID_PASID(0) logic" is. All the more so we now
>> just have to set the pasid to PASID_0.
> 
> You have keen insight, yes, this piece of code could be further simplified.
> We don't need to check rid2_pasid anymore, just index iotlb cache even for PASID_0.
> 
>>> +    if (!rid_pasid) {
>>>           iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
>>>           if (iotlb_entry) {
>>>               trace_vtd_iotlb_page_hit(source_id, addr,
>> iotlb_entry->pte,
>>> @@ -2160,8 +2157,8 @@ static bool
>> vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>>>           cc_entry->context_cache_gen = s->context_cache_gen;
>>>       }
>>>
>>> -    if (rid2pasid) {
>>> -        pasid = VTD_CE_GET_RID2PASID(&ce);
>>> +    if (rid_pasid) {
>>> +        pasid = RID_PASID;
>>>       }
>>>
>>>       /*
>>> @@ -2189,8 +2186,8 @@ static bool
>> vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>>>           return true;
>>>       }
>>>
>>> -    /* Try to fetch pte from IOTLB for RID2PASID slow path */
>>> -    if (rid2pasid) {
>>> +    /* Try to fetch pte from IOTLB for RID_PASID(0) slow path */
>> PASID_0?
> 
> With simplification as above, this code is useless and will be deleted.

yeah, this code is really confusing. I saw "if (!rid_pasid) {" and
"if (rid_pasid) {", the two if branches have almost the same code.
I suppose just different pasid value. So the two should be able to be
consolidated.

Regards,
Yi Liu

