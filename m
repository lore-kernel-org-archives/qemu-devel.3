Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBA4CF65DB
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 12:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkLId-00046y-QK; Mon, 26 Jan 2026 07:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vkLIA-0003DK-Nv; Mon, 26 Jan 2026 07:02:08 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vkLI6-0003pu-2Y; Mon, 26 Jan 2026 07:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769428918; x=1800964918;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pY+bouT9+14iU3ymZ3zw4vClI+SAncCjRatyAhoBk5g=;
 b=gEI4QABa9/0nDATlqdJw1piPbmzv0Oz1qAtHXhA/TobROL+qvW9+5pms
 QGw6wxeNTrwdw6093E5zD+eeHL4dlh9QRHNyh9rsikmfnQ86osPXTJCYK
 OCsmIDmOsuHC7LaRsjFOXhjr898eMVPIviG15Nn28jmYxmfuRk4sf3EZ1
 fmXrYAg2q51PLzxNwCHgdhRhmzeZxZv7iv1rTHS1xKcfxJ2z6pAt9loVk
 RQsr/zno90dufSqgt1Fz2pPTssq0erj+Ly/uu3HxmfY0GT4FzkZ4lom27
 vvyqoqmTpKO0QKf1cr3GzEYw3jd4olG20NvzggByKkwXYTVRu8O4RBSq/ g==;
X-CSE-ConnectionGUID: 7MrAahb3Tka3Y9eEnJRUwQ==
X-CSE-MsgGUID: kYZ0k8nQQwWTwD5tgqf5tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="96066822"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="96066822"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 04:01:55 -0800
X-CSE-ConnectionGUID: 8QvMjUIlQ1G+Q8fl5Fvcpw==
X-CSE-MsgGUID: k5fj/77IRsOglFs/ARFhRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="212525630"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 04:01:54 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 04:01:53 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 04:01:53 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 04:01:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgPSjKpe47jguQOrt7ChzLewpv47ivDb314lAd6+1dpPD38i1P1JNUSc+EUnOZFDIUOHeMHnVVMll/rrlbAywrfXmRK8ecCYNLmMQv528L36cUFUvvP4Wwz+3SGBbRZTIoTMcl19FKSD164vD4u3qIZR1hMad0fA3k4ZnNfwExy8S//XMRZ/6FIqzXHAQb2GPnBEcRO4sImtMN4AkO2tELoZPtYlSglNUbg0d1VvNk7TQoLhZ6MKbe3xlxBLZDDCkkWKVGE3CkMlmbyE9J+UnqvbBRAAisomNYkqvFEX04UVwkLssgrzfctmuyUvACaAt76RQ3Mg+V7jom4dkeKC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAs1wW/LeBwM/WaNIXua4Y1qXi8mEcxTGGzADTq+Bc8=;
 b=h4ps/GsRZwkSI7JkdAeXPZXYYewfyT0oiMTM79ziRZW6jNG78JFt1K+Pv0l3lT7tK+f+GgrDsQLVurVZOqoVLYlwdTLHv1ZbgR0xr7smsvbhgT5uKGrIEYkGtgba3FdPFWwYAi7S6PuFgoE/TSSR6VgzGspZjZNnt/P/on8CbEybtQUWQJtnXxMZ9BNMtRa9nyC26dPIE4OCuftEPqwymGUIWotMkdymtYasp5xG7cyAl48GTHAdOCrF8j/VCOyO+tEBMQBWhTH8+1QZANFJGDz1q/UPsmtJoWYWc2PIDmJMKzddsLBiKG+x0xPjSguVwqhCl4X5nF8lrYUgXQslyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8492.namprd11.prod.outlook.com (2603:10b6:806:3a3::7)
 by DM3PPF6A4412A55.namprd11.prod.outlook.com (2603:10b6:f:fc00::f2a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 12:00:58 +0000
Received: from SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c]) by SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c%7]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 12:00:58 +0000
Message-ID: <9a217f24-c44d-46da-b3e6-d954c49c23cf@intel.com>
Date: Mon, 26 Jan 2026 20:06:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 32/37] backends/iommufd: Retrieve PASID width from
 iommufd_backend_get_device_info()
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-33-skolothumtho@nvidia.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260126104342.253965-33-skolothumtho@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0044.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::6)
 To SA1PR11MB8492.namprd11.prod.outlook.com
 (2603:10b6:806:3a3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8492:EE_|DM3PPF6A4412A55:EE_
X-MS-Office365-Filtering-Correlation-Id: 15625a05-8d01-44c6-29ec-08de5cd29115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|7416014|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHE1M3M2cEZRcmV1ODRKZEV3bjRUQ0tDZVVYTUhKRVdVRnpPQVNLTUovdlBp?=
 =?utf-8?B?WWs3RGcxcnFVRTBVbmJqdlhlTFhFUFdOTC9yd2FLeWR4aFFIcXRSc3dtNU1k?=
 =?utf-8?B?eXZNeDBRUEh4VE9XYkZNOTVWQnlHS2NjNUkyekJPamIwL1FWSDFET0dvbCta?=
 =?utf-8?B?dXI3NHhGVjArM1VqN3g2cUlCcGN5WEdCZXNJc0hZQklObGN0N2k5RjRDS2po?=
 =?utf-8?B?MDl2bU1uaU1naGtrT1JwTnVCVTVDZXFMQUIwWmtxckZFZkhIMlgxVG1NMGk4?=
 =?utf-8?B?V0FzaVNIbytYKzJHZlhXd1NmWklEMWxTajVjNG9WbjBJSko2Zm95OXppRm9x?=
 =?utf-8?B?R0hGVjFhOWxqRFNYL3R5VUt1c2xPUktjcXZENlk0bnE0YXc4Mi9kOVE4WmJs?=
 =?utf-8?B?bC9JaEJleS9TNklNTjdQT3hxWHkrRUFFN21zUS9LNEhrMWlUTU1QNjZqbTl1?=
 =?utf-8?B?Q2JGQmxKVFljb1BHVEZIYnVXQkZhc003a1E0NGk2OTJybWd0dzBEVHVDV1Ra?=
 =?utf-8?B?KytIMnplejdwbXU4SDB1alhmcGplMHUvclJoOUNRa2lGYmswWWhyaFY4U0ho?=
 =?utf-8?B?RGU0UEZHSklhR3ZUc29kWG5ZTHRuNEU3RTFxTnRHRncvK0o2eWZWdkNQK1ZN?=
 =?utf-8?B?Vm9NT1RDdVRac3lTM2JaY1l4NFN1L0xobGwyZ1JmZ2RoN3BQamhxVmZjeGNV?=
 =?utf-8?B?Y1ZJTWRLSVI5OXMwUG83Y0tjZHNaVkZRaDlHcWFNaHgvSVFpWUtqU1I4QUZl?=
 =?utf-8?B?KzA2NVdhWTN1eWhHNzQzL2FHTXNyeGxFaFZEb3ZoWjVyMHNTRVh1bHhYdGwv?=
 =?utf-8?B?cXVRY0o0YzJQNkFwRGI2Uno0YkNiWHF3SDlkMDIyMHRJdEtQVFQyL2d6QjEr?=
 =?utf-8?B?dVZ3Rzl6M2FaZmlBaDUwaHNjVU5BTmRLYXVmVjNpanh4QkFMUWVuNTI0Ujkv?=
 =?utf-8?B?VEtpN0hXd3lXaU1iWEtKaFkyd3RzTE5haHB2QXNqbEdVQ2dlRDBqdXN2UE1T?=
 =?utf-8?B?bllmRHhHdlRrRWVoa3doY21hb2Iwc2ZZSHBSYjg0S1pzSCtJcGI1S1czUG5P?=
 =?utf-8?B?ZENITDRiYkt0WEJ2d2lpaEpDZjZSRnJqdTJKRFJpcTZOWnJIaWFqQ0dGanlh?=
 =?utf-8?B?cmZPaWRtbFlpMHNzQkpMQXF1V3NOb2JSWlhSR1I4eUZIczdPTFpTYjBMK2Iw?=
 =?utf-8?B?bkxqb0gxTGMwVVQwdGlCV1g2bG9PSjNEbFpTNFQ5QkdseWx6ZE1Vc1QwcHNL?=
 =?utf-8?B?MXlaUFpZOUtRVjVybDluYUpFY1h4aUhhTkM0aFJrbDFuSmc3N1JFeGhvTFVI?=
 =?utf-8?B?eWRnTjg1UXY1alQ4NHlEeDJkZkdUa1NOMzNyVWozTTM1cVdPeXRxZ29TdEp0?=
 =?utf-8?B?NjBPM0FkMEtpQXBYTHV4MkEvSzM3ZkN1QkdLSDVMV3oxbEV5dlV1aElnUjlK?=
 =?utf-8?B?RnBCbVM5Tk0rbTB3ZmZQN1p1Y0VOT3JjbXdvSFNqRWliRmNCb1VKWmJ3ZkVK?=
 =?utf-8?B?ZFZNL0hSVTRIT3hKM1pHRC9aaW9qUjRwN2lHbmEzb0RvUFdUblZRSjhvSEFG?=
 =?utf-8?B?VHJERkdCb1pGYi8yeGpiRXVBVHEvQ2JvQU1SeEh3VmdjckpMbTJhZ0VCUm9q?=
 =?utf-8?B?K1NnOFNvMFdSU0EzZ0RpN2I5V05jcjJMcTk2clpnT2RLK0paelczT2lYYzVm?=
 =?utf-8?B?KzV0TnE4SkprVHpRRm82TXlESTFOazQxYWRhbnFWOUljZ3RzTzViTGZ2Vmcw?=
 =?utf-8?B?ZjYvL25JRjZxN0E2RllTcFBveU1tdGcxSjZvQ0dhSy9PclBrQnM0RUtPcklY?=
 =?utf-8?B?M0dCM2Y5a001QlU0Y2JmTE8vSmNPK2lKTStmeWc2N09IRWQvb1J2NDBJemRo?=
 =?utf-8?B?LzZ1VkdYMlk2M08xamY4ckQ1VFhyT085M015K0hFWGViWWN5c1g2K0dVQm42?=
 =?utf-8?B?ZlJmS1BFQXZOLytpdExsdThWb3dvd2NlblhUSWwrck1uWkVhRlVuM2EvVEIw?=
 =?utf-8?B?V3oxSHFFZ29ZcDR2NEpKZ2tBc1dFZjZYRnE2WnREVFdLdjZXcTE1L1d3Tll3?=
 =?utf-8?B?cG9PUGlHekw0R3J5SUtUZDk5a2kwL3VvcDF6eUhWNnVqL3JIQkdpUitrNm1P?=
 =?utf-8?Q?ZUgc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8492.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(7416014)(376014)(366016)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFRJdnV6d2NyQlM4amJheHBMNHFEaVpGb1M5elN0NFllU3JqQUpPV1V1b0pC?=
 =?utf-8?B?UXlQdFlwTWdPY1hwaXJRQjBEZkt3cGludEhrU0w2a1I2d01qMVJuWC9FdVRu?=
 =?utf-8?B?Q2VvSGZkZEJ5UTBNZWZwSjV0Z1dSNk5BN1Byd2xzeklxSHpNVDhITStmQUd0?=
 =?utf-8?B?L2dPOE1HMFNRMi94bHZSeUU2YkRxOVRHei95VzQxTHh4NHNXTE81VWFsMEdy?=
 =?utf-8?B?Uit3OFZRK2Vpc0hCbUlpT3pkN2VvUWtwK25WL1RMM2RGNzQ1MDFHOUtaMDdm?=
 =?utf-8?B?THRTWlk3ajRmUFRoS3A5cTZrNkdDMnBqYjZpUzVLVGtuMkpRWW9GMmVkeGVq?=
 =?utf-8?B?ZExHdUJJb1RjNmY2OExkQlRpL3p6bHNJZU04WG9ubFBQeFplNkpaUDZvcnkw?=
 =?utf-8?B?amsrUGFDYXVjdUt6SmE3alpWbWFTNCtYRUQvWWpzR1pJYTk1SEp2aDdhU2V4?=
 =?utf-8?B?eGRmQWdNZ3VkNjRoVDNkWWQ4ZDNnaVhXc3U2TzcyZS9COEJoUkVDT01Jak9s?=
 =?utf-8?B?THJJYzRBNk1PRndQQnAyT1MrWVI1bURsMUxtMDQ0QkV6YndLSUI3U3hMYW1E?=
 =?utf-8?B?Q3F3TWRtS2t4MDFOWXlUQ2s2WDJGc0lNSVlOUnpJa1RrOTBzTm95dkdUc1dx?=
 =?utf-8?B?NHZnbko5THRZVWcyUnJZOVNWb3I0SDVNWXZDa2FZd25ZTERLakQvaHFTZThP?=
 =?utf-8?B?RndsUzJTT2hRWGN6Y29OL1Jsck9BODdjdm5HSE9GSXNFNjNrdmdrWkRlV0l4?=
 =?utf-8?B?WnVjOHJXODE1SFA2VHEwY3djUmhFQ0Q5VHcvcTRkdkw0YTJQRStOUkNNYUJT?=
 =?utf-8?B?TEFsSjVkSldpeFBJUmllZGIrUUNTaWtuSDd6S09xeFVFa3NNUFdZRmM3alY3?=
 =?utf-8?B?N2Z4Tmc2S0RGSmdMUVRsZ2xFY29mY1N6dElyNVV4U2pQU2pzb0ZpUzJEUFIr?=
 =?utf-8?B?NEh2bGVZU2RvUTdqbVAxcHdTVUEzby84Z0NvZ3hjMGhiQnU3ZFJXMnJuUWtN?=
 =?utf-8?B?ak9Cd1hnWmRtMDdnejg4V2xtR0hENEJtaWk3dzVhdXFla1NlRVIzYjZhWG9L?=
 =?utf-8?B?NTdvYlJqUVRBdHl1ajZKU3JEc0Y3WWNYemJLc1hCbTkxTkl2czlpVWpmRWZm?=
 =?utf-8?B?V1ByMnhrZDE4YnIrRW81akRrYkdEZGxKTEtVWUZFMXZmbEhQcFpVdjgzOHUz?=
 =?utf-8?B?aWVrYUtQaHlFUmlsY2JyQXluKy9NRzJJNGh4U1h3SC9yMTBnMytJMWJ0ODhK?=
 =?utf-8?B?aU9zVlUybzNWUlRZU3hUTk1CV0trRk52ZGsyTFlvQjRubFhYbWNKbXBVMktO?=
 =?utf-8?B?VlJKUHVjQXRiSU84VTlzdXZvNEF4cmwzeVFCenVuVWNJM2tOVk9KTXFLc2t0?=
 =?utf-8?B?NzZFWXZIeXlLZ1E0c0ZNbGJFNUhzeWxSMjJ1RkU4UGFpd3AvdTF3am1BWU9V?=
 =?utf-8?B?TW1HanVCM2VNSnorZjZtTytzL05McFNMVGhVWHlIMnlFMlRwZHdySko1WkQ5?=
 =?utf-8?B?ekNyblArejVKM3VydWVoSUZJS0lLZjc2Y2tNV0h5TDNTNXE3bGFoUG50MDRz?=
 =?utf-8?B?Mjl0WGovY21TQUJ4NCszeTdBSFhmRnFwUGlYTjV0eWVMcVgrVXIzT3FRbHFI?=
 =?utf-8?B?R0NLUjZ5YjFJb0orRjAvTWdtOFBTOTdkK2p5NmNBOEYrdUl4QkUvZC9qbkpD?=
 =?utf-8?B?V0lidU8ycXdvRTg2b2syNGE0RDg0aGludGNrdHhhWnl4YUtJcm5mYnYxNy9n?=
 =?utf-8?B?anQyQms0ZS9QNDlZS0xpUUlNMUIwWTEwSzVLZVBFLzBlQzNUM0g1ak5IM0pW?=
 =?utf-8?B?azYzNkkzNUVDK0ZQUTQzS1hIME8vTk9pbU9tRHlUbFJUYWtyY1E5Vitkd1lr?=
 =?utf-8?B?aFFVWjF4dzRmbk5jb3dMVVd5Nmc5QVo5L294STUvdVhUeXNVV3hvcmdidWZG?=
 =?utf-8?B?VlRIbUZUbGVFLzl5MTZBUldsamNSOXJtQk1LTGFSak05Q2E5OHpQaEF2OXZO?=
 =?utf-8?B?UWtNSGFBdmhzNjVtY21lRWFYc3V5d1hSUnlkcGlkc083L3l1S2k1dU0raHA1?=
 =?utf-8?B?TkE3OXc2M3lIaURQeVpJYUkySkxrTXFrME4zSFE4SDRYMEN2Q21ENGdhN2RZ?=
 =?utf-8?B?b1NqYXh5ZG1vOWMyWFF6T0VqcTJSTHFpbVNWTXRPVWVKdGkwM2dFelkzd1Y1?=
 =?utf-8?B?dDZ5RHhmTWRjNEhaM3NLYVFvVEVEa3FvOFVjaXkyRkduK0xDTloraExwNXY0?=
 =?utf-8?B?WDlVdEYrYzhPb1p6c3UwSFR3TlJrU1lEdlFIdU0xeXR5S0NCU21YaXZNQVhO?=
 =?utf-8?B?RGhFWVlMMk9TalpiZDJTem5RdUE4d2Q5TmE0Vy9EeitsRS9KRHg2dz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15625a05-8d01-44c6-29ec-08de5cd29115
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8492.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 12:00:58.3344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DfzUTWzzdsfuMjjiShZV2rr73kLmNdYKF6nyNEENT4kMmLVGPeemmYDsF5DHFdhBLloITZHCg/ou6bDasa9hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF6A4412A55
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/1/26 18:43, Shameer Kolothum wrote:
> Retrieve PASID width from iommufd_backend_get_device_info() and store it
> in HostIOMMUDeviceCaps for later use.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>   backends/iommufd.c                 | 6 +++++-
>   hw/arm/smmuv3-accel.c              | 3 ++-
>   hw/vfio/iommufd.c                  | 6 ++++--
>   include/system/host_iommu_device.h | 3 +++
>   include/system/iommufd.h           | 3 ++-
>   5 files changed, 16 insertions(+), 5 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index e3a3c1480e..9b63d74083 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -389,7 +389,8 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>   
>   bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                        uint32_t *type, void *data, uint32_t len,
> -                                     uint64_t *caps, Error **errp)
> +                                     uint64_t *caps, uint8_t *max_pasid_log2,
> +                                     Error **errp)
>   {
>       struct iommu_hw_info info = {
>           .size = sizeof(info),
> @@ -408,6 +409,9 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>       g_assert(caps);
>       *caps = info.out_capabilities;
>   
> +    if (max_pasid_log2) {
> +        *max_pasid_log2 = info.out_max_pasid_log2;
> +    }
>       return true;
>   }
>   
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index ea420afeb7..342944da23 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -121,7 +121,8 @@ smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>       uint64_t caps;
>   
>       if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
> -                                         &info, sizeof(info), &caps, errp)) {
> +                                         &info, sizeof(info), &caps, NULL,
> +                                         errp)) {
>           return false;
>       }
>   
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 2947e1b80f..131612eb83 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -398,7 +398,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>        */
>       if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
>                                            &type, &caps, sizeof(caps), &hw_caps,
> -                                         errp)) {
> +                                         NULL, errp)) {
>           return false;
>       }
>   
> @@ -939,19 +939,21 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>       HostIOMMUDeviceCaps *caps = &hiod->caps;
>       VendorCaps *vendor_caps = &caps->vendor_caps;
>       enum iommu_hw_info_type type;
> +    uint8_t max_pasid_log2;
>       uint64_t hw_caps;
>   
>       hiod->agent = opaque;
>   
>       if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid, &type,
>                                            vendor_caps, sizeof(*vendor_caps),
> -                                         &hw_caps, errp)) {
> +                                         &hw_caps, &max_pasid_log2, errp)) {
>           return false;
>       }
>   
>       hiod->name = g_strdup(vdev->name);
>       caps->type = type;
>       caps->hw_caps = hw_caps;
> +    caps->max_pasid_log2 = max_pasid_log2;
>   
>       idev = HOST_IOMMU_DEVICE_IOMMUFD(hiod);
>       idev->iommufd = vdev->iommufd;
> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
> index ab849a4a82..bfb2b60478 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
> @@ -30,6 +30,8 @@ typedef union VendorCaps {
>    * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
>    *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
>    *
> + * @max_pasid_log2: width of PASIDs supported by host IOMMU device
> + *
>    * @vendor_caps: host platform IOMMU vendor specific capabilities (e.g. on
>    *               IOMMUFD this represents a user-space buffer filled by kernel
>    *               with host IOMMU @type specific hardware information data)
> @@ -37,6 +39,7 @@ typedef union VendorCaps {
>   typedef struct HostIOMMUDeviceCaps {
>       uint32_t type;
>       uint64_t hw_caps;
> +    uint8_t max_pasid_log2;
>       VendorCaps vendor_caps;
>   } HostIOMMUDeviceCaps;
>   #endif
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index 567dfb7b1d..80d72469a9 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -71,7 +71,8 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>                                 hwaddr iova, uint64_t size);
>   bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                        uint32_t *type, void *data, uint32_t len,
> -                                     uint64_t *caps, Error **errp);
> +                                     uint64_t *caps, uint8_t *max_pasid_log2,
> +                                     Error **errp);
>   bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>                                   uint32_t pt_id, uint32_t flags,
>                                   uint32_t data_type, uint32_t data_len,

