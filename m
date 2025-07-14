Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6D1C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubLKy-0006FF-Tf; Mon, 14 Jul 2025 11:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1ubK4J-0002ci-KQ
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 10:22:12 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1ubK4G-0001Ep-BC
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 10:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752502928; x=1784038928;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Jl0Ul4eikNdbFM4Sb6sgEC7mjLf7FXkLtHCdyO7qDh0=;
 b=Bu/aO5ciEaV0vRhlmRuAfHt/ckLAaD0jkOg/e1iI2CnBDaPBFO7uwb3d
 EscTGAaPz745cMMxe6oXjb2rK5Vr2pjKnP72QZ7PWto+e69+FEi+V7pAk
 31PSjidG7pmy4TRSlYT7Y2NbkP/9/5X7e1b34gUDzcTbm9vVBuMJ4OVop
 TfjB6D5lSClQaD6hYmvdjt7UYSRhvkOHRynSYbClc7OLtzbiW7zjjYIWl
 c5s7zPk1ACRn38Ja07JvMjyz65lD6K2MGksYR1JRW7eoqoE387qu/2TOs
 RCSyaBQJDmgigrX1w8lDjBYkorMrVGWIizmIU8c18bJBxpgfeThAHOTU0 g==;
X-CSE-ConnectionGUID: vpQX5d2iRF6Z7mwNBZTFzw==
X-CSE-MsgGUID: 896clAYPTpun5UNo+O9aXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="72272927"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; d="scan'208";a="72272927"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 07:22:01 -0700
X-CSE-ConnectionGUID: eSFxVugRS4iiE27DHh0azw==
X-CSE-MsgGUID: WvXNYMLdSayTOpSwxOpt5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; d="scan'208";a="157498746"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 07:22:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 07:21:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 14 Jul 2025 07:21:54 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.56)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Jul 2025 07:21:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arCrRDiwfhUeBbF7lrQjj6pAf7tKQ9phLttk9rGRz+uZWwgfSjn3BmXw83LDTfjSN3zqlii93XSCXYxH5fznNUJdNiKi1Z3PCZazxId6vhvz2iL0UmXKQ8yygIT8/hod+QLQPy3OLZXkPBkqpTYGW2EXd66r2jWIbXWYJ41vuBNXu3y5oQaY/Xa/cL0iI2cGL7uRAKiV63VKwMGLp6pCBQN5DPnNMQJVrMPc17gSnBfinsN/1Y6d1mwYrDuY+VE+4BIsw6+ma3rcOUeRXigAAIJBWvifbiG6PujNb+YhLqXm7qhHj1aT/EPJltXUtS2gfax+sXqEdtzZX2UeuNCL6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rP531M4dKJM0fvK0RL72yO8C1uBACa5ovTUtCvREpjk=;
 b=yjhSocO5ECibmjU/D+1WeEo049iy9gDrUpaen59/hxbb4ios4f57Z0+bnked129wXdHLakra7AqfV2M0biHZxnuyuzIlWnecevc0AnIbOQe/t6PJxskZgl0QqpK9s6/EtMX3Zm8ejo1EoDrdvcXzoH6Z1pkeERg11Dsgv7lHhwjaQETfhTSE4qRJbmmqZFynwGq9evlKjGXAFvOsmGlPzoR1mTOnfzGaU1OkjFMV04LPvChyvD57qwtkc9jDV0HZz5dGPyzbjLNbXRB7GtyxZ9XS5SE9tKO7jk9yfoe/JuRDZSEIxlNBg4c6RBUcqO6MqBk7xo1jxK7+U+TPf3vVBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by DM6PR11MB4562.namprd11.prod.outlook.com (2603:10b6:5:2a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Mon, 14 Jul
 2025 14:21:47 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.8901.024; Mon, 14 Jul 2025
 14:21:47 +0000
Message-ID: <9ce8b7e6-ad15-4d2e-a430-3896eccc7519@intel.com>
Date: Mon, 14 Jul 2025 22:28:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] intel_iommu: Allow both Status Write and Interrupt
 Flag in QI wait
To: David Woodhouse <dwmw2@infradead.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Le Tan
 <tamlokveer@gmail.com>, kib <kib@freebsd.org>, <jhb@freebsd.org>
CC: =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, <qemu-devel@nongnu.org>
References: <0122cbabc0adcc3cf878f5fd7834d8f258c7a2f2.camel@infradead.org>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <0122cbabc0adcc3cf878f5fd7834d8f258c7a2f2.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|DM6PR11MB4562:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b1e837-2ce9-4d13-17fb-08ddc2e1c467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|42112799006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2w2eHFVT24wcnNoME1hUjVEdi9sRjRTZkwxMGdnWjJuM2txNTZ1NE5qcVdH?=
 =?utf-8?B?WSsvS2lPSEdNYU1vUWFiR2VBY1o1U1hZNzdmWDNLQ0tod3Q2OEVCeU9TcnRW?=
 =?utf-8?B?T2oyMjJRd0RsMjN0Zk5Vclp3c0VmekJxajdpd1pnRTdUS01qM3ZGVFRUVmdF?=
 =?utf-8?B?dC9DQ2VyMGR3OWswU3dpMHQ2RFJIa3YzdVV2K0k3MmNmaFBiVFJOQllEUlRO?=
 =?utf-8?B?QWZOMmxtWGc1a2poOVBlZ1ZjWThWaEZ5RUhtS1MvMHYyd1ovaXRmRWZFLzQx?=
 =?utf-8?B?NTl1RzlleHlJNjZva0RNb1VWWFoyd0kwZ2RpS1VLN0EwanBCUHNGNGNlUmNh?=
 =?utf-8?B?VU0xaUpoZnVLWmpWNE9VajU1cnJOWVc2aGRZbXhVNE9xeFlMenRLVndmWU1Q?=
 =?utf-8?B?T0V2V1BYUFJIVjEyQlhtUkVjN3BTN1RRM0ovakJJYnRnbHU2T0tlV0wwWEZB?=
 =?utf-8?B?b3FaNHgxZjBWdWZlTmtzYjRVZWR6NkpDajdXd1VhUkpoRk93ZWcwRWZRbVlV?=
 =?utf-8?B?TWlCYzNMZ2o0Y3V3NkpNR0xWWm5ERTFkZ01mL3M2cW0vTmJyVElXUkllSHNq?=
 =?utf-8?B?aUthNEllTHQzZ1ZJdFA4d25hbTdVa2dSbXN4c3hTbXBzWUJJSU1HRkZxTTh3?=
 =?utf-8?B?bzFYVU5qODZNWitpeFBlcUEyeVJXdHJYemYyZkVuNVh5YWNYZ3Y0Uk1OOHYz?=
 =?utf-8?B?WU50SmVQaGVKcml3TmlERXllelF2dC9BWVRDOWdPVTJaVWM4WVhydlMyaW9z?=
 =?utf-8?B?OVFzUGU0QWt3c3pjL0VJSU5JOTg4cjlqMGxkRzI1d2ZidXVkSHR2S2cwVjJy?=
 =?utf-8?B?Zkg4VEZqd1loQUluL0I3eWtiamZZdHlReWZxQ3AvK0R3ZnhhYkZNZkNXbVo5?=
 =?utf-8?B?SUN6Si9uRkRickVhUXlmQjI4azQrWXhpV0wvRlVkTVFUNm1jVXZhczhDLzZv?=
 =?utf-8?B?ZVh6Z3NlSmxObnI3ZXloV0s0NktabjdlZWRYSmdlK3lGMGFFNHB3SGc2bnpH?=
 =?utf-8?B?NHpGZS9lOXRzTythOThybW5aWHBidjJDZWRMUEJHa3dheUlrN09YajNjdUxE?=
 =?utf-8?B?aWNjRSttQlFsYzdtd1U2SWk2Kzd1V3hxdUZia0Z0Mmdad0g3MEd0MWxsaG9I?=
 =?utf-8?B?ZXVIdDJjaVdDZmU0dlRWbXpnUUJHMDhPN25KUEVjc1YvYXpYUnQyM1laMktj?=
 =?utf-8?B?S2p5U1pOT016by9FQkkvL3paeU1ZZlFOSFcrS0RkaTlFQUVHYXhrRWxZMnVW?=
 =?utf-8?B?R0lvbTFRaG9UKzRWeHZXdHBtbWFaRVhWNkZSVTllRlRVQ01BdnJWKzU5NE1a?=
 =?utf-8?B?M01ldHc1cDZjbm9tY0ZOTmdSYWdQVlpzdUlUY1lXelZOR0s2TWEzSXFnVjFK?=
 =?utf-8?B?RnhIS2kzUis3ZnpJbHJmRHZZb0w3VGozdzQ5NHhzS1puWVJBSHhhM3RSNHAz?=
 =?utf-8?B?WTlxdDFyTys2cXdhNHFwckFtWW02cGFEUm9LOW9jbjh2S3RkaTloQWV3NytT?=
 =?utf-8?B?bFllN2hBNlBOOE03ZWxhRXJyY29QMUdSNlU4YTM1amtoTlR4dmhBdS9rZjgy?=
 =?utf-8?B?SXdSeUxSVEordHNNaTdEREtlRDdjL3NvOVVsdUxxZnVSUFkrdTBWa0tLVGw1?=
 =?utf-8?B?VHMwRGVBeFpoQVFJam5QV2pKZDV6VW9OeW1IWjBhMjZoeVJDZlUwQnBiVEJU?=
 =?utf-8?B?T28wMWQzNWllVHJ2cjIzQ2pzNkVZYnVUaU9UbElnNkFEZFNDdURjRUt4SlNI?=
 =?utf-8?B?WSszVE14ZWxyVnRZU1dKS2FucG14dHJhaGsvRzJ4M3liK05IdWFpQWNOWjAy?=
 =?utf-8?Q?+D60TntbGjTT8QDdOf37xa1VzLRfSnb4W+s84=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(42112799006); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHBqcm5tVXBCUWpwQlZBQjR6YytJdGJMR1RpZEwyeTVoZHExNjUrRWVwZ1o1?=
 =?utf-8?B?dW83TE9WMGxKVmpYa0hrWU5VZllwdHUrVFV4d1RBY2dtZFFnTjNacXBmV3hk?=
 =?utf-8?B?aXFvZ1JhRG8yV2pqNE1DUEVxM240YTJaUXBBOEROSVJJN0NFQ240aHV3VlJ1?=
 =?utf-8?B?eWRvQWdTSmNxRmo2c0x6NXMwODl3RnlnTmtYc0JaR1NyQmg4eG5IZUxjUXFw?=
 =?utf-8?B?cmR3V0h3WjdxSnBoRVFCT2Y3djRZSnV3dnQvV3MxYml3Q2ovcjFPSW1TOEpT?=
 =?utf-8?B?ZnROaVplYXBYU3pWYjFDV2orcit3NFo0L0JqVlpVTEEwVjhpZGdSU2V2d1Ja?=
 =?utf-8?B?MWxuRzVEK1k5SUVvSFFRMHR6UnhuTlJ5SmZYRzJrR05aT2ZpY2lJYi9QWTZ5?=
 =?utf-8?B?ZVVZY01SQ1RlSkNhVWNRRng1UGY3bzdqRHErMWQwbGgxbkVzUjNVamR5bEk4?=
 =?utf-8?B?WmdKOTh0eklvaTdqejR2dmhzOWs4bFhSaWZwM3hIUmJzaUVkV294OFdUWjNi?=
 =?utf-8?B?cU13eE5aaGMrRUtPa2t2K3pnM2NDMHBFL09mcG9MbjNXRmFabHQ2TWZjOUdp?=
 =?utf-8?B?OXVBNzlLUy9FZ3ZmdmpYb29Qb0VmQ0ZrWmx4bTdMQzdaWm9lcDduVXQ3OTlT?=
 =?utf-8?B?UWNFUCtGVWh6S2NZWFpGM1BRMmcxakFqRWo3UlNhSjFwSG1XbVdNVHZxMUd3?=
 =?utf-8?B?Nk4yUUNPTnRNOEtYM3MyZUVZR29uamJEZEYwZlBiZHVGTCtsOGsxNkw2RHpv?=
 =?utf-8?B?OEMyMEs2K3Arek85UVR2cHAvT0oyTkc0RXJaR0NjMDNneVd5S080QWdjLzYz?=
 =?utf-8?B?b0lZeXVHaUkrR2NWVnpzeDMxczI5bDZNUjVJcHUyU0thbVRleElQdXdCS2NF?=
 =?utf-8?B?bkp1ZnR5QjJVL21meFZSR0pSRHNVaWJndWZ1RC85VTRPcHV2RWtyUEQ4S3E4?=
 =?utf-8?B?T3J0Z3U1QzI1QmJJYTM3MmoxTFlRM1JIMHIwVTJERElhallWZTNwU2drV0o0?=
 =?utf-8?B?WmZiZHBWNytGWndNYVdaa0FnQjhVa1U5dHdZYmI2K0NoYS96anVMV0w1bmFF?=
 =?utf-8?B?bFZTSk5wUFYwL281aEdWWVY4ZWFOUlVreVRrRG8yMFlKUGVGY0JweXhmbGQ1?=
 =?utf-8?B?WjNvNGRCbGVqd3FNanBlVGxEWTRlTWVLSlZRVG5aMmtGZkRsUUlsZTNhZDd3?=
 =?utf-8?B?V1NpQlJ0WGtzTzg4Q0lKU2hRVURrYmFRTGl5dmRRRjVvS0I3cy81TFU2d1gv?=
 =?utf-8?B?SkpBaUx0bStUNzcvRk5mRXZUbkhOaW5jckkxVk5hcWdid1dXeTU0RWtBSXI0?=
 =?utf-8?B?WGgzTkJJZEJGNHY2QVNwVW92SmRLMzlOei9uMnhOZ3JMY2lsWlkyd2ZFUXQz?=
 =?utf-8?B?QnhOWklWUTE1RkJzUlp6V2NPc3Z1OWZYdEE3MEJ1K3F0cU5SSDVYUjJjbGRR?=
 =?utf-8?B?OHhjN2xxMXVUcjJGV0Rad0lpaGxOZHg0YThOU0xxMjh3TjZvYVkvemJML3pW?=
 =?utf-8?B?SVVvMS8wVnlncDZrSDJESi83N1RBd05OTnZ2Z3NuQ0NhaFNFTEhFM2xKSk1E?=
 =?utf-8?B?eWRoNEFmUGp2Rjd1Q056dGx5N1c2R2dmb25yNjBBZWZUQmx5azNZS0hHdHpB?=
 =?utf-8?B?RnJaTGhheU1FZit1dHBWUGlObnhpbitXdEc0OExiYU5kRTBUQVNGRU52TXVC?=
 =?utf-8?B?MC9iaFpFWVA4N2JFRGNWQWZqSnZpN2RyZm45dWM1WEZZNXFCVDlqd2I5MTdo?=
 =?utf-8?B?MndOcDRIZ08zODBESGhtSkFUa3puZG1mL0tvOXhPdlpCcmRjWm43YXpKVnFq?=
 =?utf-8?B?RzVQN3QvQkZLTUNDZGhWT3p0VFV5MVdFMlhRNG5TaXdPeDRyNnlXQkpYNWlr?=
 =?utf-8?B?TXoreFpSNGIyaG0zYWVqbHNuK0ZSV1A1anRVa2tBOUhsZWYrQlpYQ3pBOVVo?=
 =?utf-8?B?M2tiZFdTYnVVZ1dYbm9uZW5FdjNiUFZ5OUxheG4wNXI3N2dNVVB4UDZ6SU9X?=
 =?utf-8?B?YUNjUXFzZFhMVlkyQUtJalN0TFFXTXIwVjc2R1dlUHlodytQYzkzbEdySEF0?=
 =?utf-8?B?QXFhZEtxMXFIVlh4SkszRTBVOGNsODVHWFVNRHYzM2ZzbWVFWU1TdDdkVmFN?=
 =?utf-8?Q?cW+3XxQaFl+I356k1tm2b8m8J?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b1e837-2ce9-4d13-17fb-08ddc2e1c467
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 14:21:47.7796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDC1G6yju54xmHBFg737vq6uc6Bl5cKCwdnXpPgTs2v1ZLM25qI8GRP5dBPRwnb7H5eJMguqAtK4cdglTJ1lXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4562
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8; envelope-from=yi.l.liu@intel.com;
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

Hi David,

On 2025/7/14 16:00, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> FreeBSD does both, and this appears to be perfectly valid. The VT-d
> spec even talks about the ordering (the status write should be done
> first, unsurprisingly).

interesting. Have you tried setting both flags on baremetal and the hw
gives you both the status code and an interrupt?

> We certainly shouldn't assert() and abort QEMU if the guest asks for
> both.
> 
> Fixes: ed7b8fbcfb88 ("intel-iommu: add supports for queued invalidation interface")
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/3028
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> v2:
>   • Only generate the interrupt once.
>   • Spaces around bitwise OR.
> 
> This stops QEMU crashing, but I still can't get FreeBSD to boot and use
> CPUs with APIC ID > 255 using *either* Intel or AMD IOMMU with
> interrupt remapping, or the native 15-bit APIC ID enlightenment.
> cf. https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=288122
> 
> 
>   hw/i386/intel_iommu.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 69d72ad35c..851c4656c5 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2822,6 +2822,7 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
>   {
>       uint64_t mask[4] = {VTD_INV_DESC_WAIT_RSVD_LO, VTD_INV_DESC_WAIT_RSVD_HI,
>                           VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
> +    bool ret = true;
>   
>       if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, false,
>                                        __func__, "wait")) {
> @@ -2833,8 +2834,6 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
>           uint32_t status_data = (uint32_t)(inv_desc->lo >>
>                                  VTD_INV_DESC_WAIT_DATA_SHIFT);
>   
> -        assert(!(inv_desc->lo & VTD_INV_DESC_WAIT_IF));
> -
>           /* FIXME: need to be masked with HAW? */
>           dma_addr_t status_addr = inv_desc->hi;
>           trace_vtd_inv_desc_wait_sw(status_addr, status_data);
> @@ -2843,18 +2842,22 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
>                                &status_data, sizeof(status_data),
>                                MEMTXATTRS_UNSPECIFIED)) {
>               trace_vtd_inv_desc_wait_write_fail(inv_desc->hi, inv_desc->lo);
> -            return false;
> +            ret = false;
>           }
> -    } else if (inv_desc->lo & VTD_INV_DESC_WAIT_IF) {
> +    }
> +
> +    if (inv_desc->lo & VTD_INV_DESC_WAIT_IF) {
>           /* Interrupt flag */
>           vtd_generate_completion_event(s);
> -    } else {
> +    }
> +
> +    if (!(inv_desc->lo & (VTD_INV_DESC_WAIT_IF | VTD_INV_DESC_WAIT_SW))) {
>           error_report_once("%s: invalid wait desc: hi=%"PRIx64", lo=%"PRIx64
>                             " (unknown type)", __func__, inv_desc->hi,
>                             inv_desc->lo);
>           return false;
>       }

I think this "if branch" can be moved just after the inv_desc non-zero
reserved bit checking. Hence you don't need a ret at all. :) btw. I'm
also asking if VT-d spec allows it or not. So let's wait for a while..

> -    return true;
> +    return ret;
>   }
>   
>   static bool vtd_process_context_cache_desc(IntelIOMMUState *s,

-- 
Regards,
Yi Liu

