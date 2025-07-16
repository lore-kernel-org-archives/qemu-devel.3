Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C033C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 03:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubtFl-0002qv-Ps; Tue, 15 Jul 2025 23:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1ubtEy-0001E4-Q9
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 23:55:33 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1ubtEv-0002Ym-Gn
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 23:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752638129; x=1784174129;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QWSbQezyCIoCIfrTstXkM+ju8a2hQXe0R8sMt3XZRgA=;
 b=Wp6bSXKWDsLCIb2IGWOP6s3PKnCu9qcL1Q+ujA892UrcPhvle3oG0emX
 tX4We8h5O4VOv1rH4GUwkEVRCCRZOUdosk3y+8FtIRBBSs2DSU9YcZayR
 h0O5E6kFXZBY4Lk3KZ1GYKQgy0cWQJPRAuzDHhb2HuXALY9Zf1MkP16Sx
 dTms6RO4yGK9X9/v4eoLGwyp75Hi6PJO36k2ecXh88KP7Cq+vopisKJds
 A5OguF1Edg/pTVX8js0euyLhJuSjHXB1z4kcVBc8OrIFvPswxVLrahTrM
 khc40RwFxNdB7Da0jM3/gpBG9TJwVm/HsWjl4idku+ki3XaRP2BU9RQu4 w==;
X-CSE-ConnectionGUID: kxLxSpU7SXGJqjTm6RRzdQ==
X-CSE-MsgGUID: tqeVRcAXSa6m1vSMjHIXVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58529429"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="58529429"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 20:55:25 -0700
X-CSE-ConnectionGUID: vPWW4D1aQTenkE/efEwikg==
X-CSE-MsgGUID: qhyhn/1tRB+zku6hZy7DHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="157198587"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 20:55:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 20:55:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 20:55:24 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.71)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 15 Jul 2025 20:55:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKz7r0ksS4eAZAzmwYmnXoCV8uncI7MX/zu0e3PuCKPtO3f+Bv7J4YE5Ie2p24HF65LlvAP2iw7lFyN0dxXOXL6eBRsUV+MOiQGPOeQVSjhZMobY97/KYbCI7Pczmcca0YidVERLdjX3BiXHCMkFNS/pWqh/XtyAjxGfGGR9TAxcpjyGyHkb201hMI8e85q3QoLQtjVI5SY1IVESlgOS93yvpp8ufolLxdoyVUozuSRg56GLWb/hutt5xsclebJU3f1WsPHd5LjWast8+NV4zsfwhLhSpOtRWOfTvOQlH50FVSxAd0QryLv89aXt77PWlQCjX95QQiHkeIzJzXt0nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0VVVD6c0N/RuqHmhSG3Qyap2pVPm0MJi+HOHF6+RZ8=;
 b=hMimc/MJlr4RmiFp5iylp90j49ZUcGmhP5O31c2QnYAmy9OIvUfVmpsNJfn6NvejBFRXDTebvAg4LbR5MX3jakSB5O/O9bUy82nXwHP8nG8F6C/Q/6G4gWgPrcm0PUd7+BMZMu+Ckb/W8zQY6ZxaSyn8MTSykd/t7XgVvv/+cu7l12mGPTjiQd2YHx4r7B/2X1ivNSNMs6i7UtA9N4UlS1M0dIJodWhkaunkDEq2Un9cHBnAuWoPLksQ4O+H4lKZmP0WbPJ7gHmcfr33QxIgvJU0kmntkBKSYOOn3yrIkRwhr1ZvSsE3dZzZzm00nNWcuz10fm7TVcQ2GFhRrmZfXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by SN7PR11MB7706.namprd11.prod.outlook.com (2603:10b6:806:32c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 03:55:22 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.8901.024; Wed, 16 Jul 2025
 03:55:22 +0000
Message-ID: <1d00dc9f-7647-4aa5-9ca5-987a06ce4292@intel.com>
Date: Wed, 16 Jul 2025 12:01:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] intel_iommu: Allow both Status Write and Interrupt
 Flag in QI wait
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>, David Woodhouse
 <dwmw2@infradead.org>, Konstantin Belousov <kib@kib.kiev.ua>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Le Tan <tamlokveer@gmail.com>, "jhb@freebsd.org" <jhb@freebsd.org>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <0122cbabc0adcc3cf878f5fd7834d8f258c7a2f2.camel@infradead.org>
 <9ce8b7e6-ad15-4d2e-a430-3896eccc7519@intel.com>
 <4FE9A8E3-5BA5-46D3-A1FA-EA1B7C85C058@infradead.org>
 <aHV0-wDJImAjRPPp@kib.kiev.ua>
 <afe3881b-1193-4d89-b0d0-6c316e54684f@eviden.com>
 <7cf6b91c1e1ea8b50d116f738215bcb55732b214.camel@infradead.org>
 <d84bdcab-3d2e-4731-a9aa-b8094fbaf7e8@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <d84bdcab-3d2e-4731-a9aa-b8094fbaf7e8@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0177.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::33) To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|SN7PR11MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: d24e5475-16db-4d91-2baa-08ddc41c966a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|42112799006|366016|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akJ5cEoySG5uZzJHNFZvbWQySGNVbXlQVGNhbitXa1czOUhMLzBPaXJ0K2ZI?=
 =?utf-8?B?K3FTYXRjS214dVN0d21aZGtYTnl5cmI2dFZNazh0R0xwait2U1VQdlNHSmJx?=
 =?utf-8?B?MVJYMkVrQ21YK3F6TXcyUENIUmx0aWZWWVpPWjgwanRHM05GRHZkeVlVR05n?=
 =?utf-8?B?WW5zMy9TTmlkb0pJTWRteFJ5bEtBQ2E2Nmxpemg0U1pJaUEzcjhSaDZ6dnh5?=
 =?utf-8?B?Q1JJOWdMYjc0NUUwWmlkMDFMQVZwV2JxN0pNSjFQbE1ZTi9ERmFUK0N6aXpq?=
 =?utf-8?B?SW5RL01HZXlrdUdqVGVXTDUyd2JmTUhMbElaT3dwUEVoM1AxakpUTzBuNHkr?=
 =?utf-8?B?MXlnY1BJeFh6T3FWcDZaVExldWozd3FHTTFBOERJcjN2WGZEajdvZXc4d1dN?=
 =?utf-8?B?SnNZaTF1SGd6MFdMK0RibXNYOVJIeit1ZUh6NUY1cUtyL211NDZoQWZ1YzMz?=
 =?utf-8?B?NlF1UTJWQThKTnUxd0RJZGlHZVpzeWhNYzdxdVFtTC9hRi9NZ2JxUE00YTV2?=
 =?utf-8?B?NitMVThQb3IzUkIxRStTVzQxdGRaV2tPNTdHOXk2M05zTGVUcUFacWRyZk5i?=
 =?utf-8?B?L1pydC8yd3hNRWJCRlNUQ1JtWkV1N3BtNlBhZlB4ZW5CMnFtWk1VS1Foc0Jl?=
 =?utf-8?B?ODIyY094N2U1K3FNMUxDcWcwZWlIRlpEZnhJZ2kwMis3ajcvamRVL2hxYnMy?=
 =?utf-8?B?akg0Z042YWU2M1kvSzJwbTIvdndiZzZHNWxLWm95d2dnK0wvei9XYURYWGpl?=
 =?utf-8?B?aS8ySmpiRVhBNTg2MVdvMzAxWXZmL0ZxaGNYWWxDekdpZU54OG1GZWhWeUJC?=
 =?utf-8?B?ZWxpOExnUDdLNklVWWhoeXpkUGhkcDhrUjZwMUw2SWxtdnV4dmI0d0k0Y214?=
 =?utf-8?B?MW5mQ1V3MHhiVzJTZjdIaE5JZnBZVmxmdWUxNWlOUnN4WlR1SW55ZnVVSWJ5?=
 =?utf-8?B?UGlZb2hNSHl5aDZPMk1qczByRFV4OEwxRis0OE5lS2tEZ3lzNmR5cGFmV1ov?=
 =?utf-8?B?KzZJdzZFQ3Y3Z1VWandUa0poV3djVXpDbUhLeTFma2JacUdIcnpXNGJvOTRO?=
 =?utf-8?B?TE1QK3N4eFVXQ20wcEVySVY5TEtpbHMxUzhLUVYwQVZ4YXlIY1VVNnVzUnps?=
 =?utf-8?B?WUxjWk81QzVWWnpYOXE3STN6RnpDelQrYUxTcS94cFdLVGhOSjBwZjhJUGo1?=
 =?utf-8?B?RHlZL0JySmVRcElpK01pQkROeDRJOFByeGVWUGhxOStXWmhWMmYyQXRndWY2?=
 =?utf-8?B?T0lWUnVIUkxVR0g5NnBMRHZ0WkRiWVgyZlRRcVpXVjVmdkJFbkIxR25kR2J2?=
 =?utf-8?B?TW1uYkZWZUNlbGM3RDdsZ1RRS2ZuZXlKUkh5TGM0UnhIVWkwUFlqVG1VeHVT?=
 =?utf-8?B?ZDRma3hHN2ZjbCtaSHZhMEpKV3hVaG5zaEZJeU1XdXhWK0lKcWFnR0JkQ0Np?=
 =?utf-8?B?RVF2a0dWQTZPMUdXcGJrUnNnV0hJSHdsVG5Qd0YvLzlaWmpjbVY4RVdzditP?=
 =?utf-8?B?VDlJN1FhM1kvTnhrNFR1VkVaU1UrbjZReXluaE1xQWNMZjhUbGU1ZXFENmZZ?=
 =?utf-8?B?UHIrYTdqVjdVdG1mWVk0S2RWakZIdkt6a3IyZm1IMzBvenhQUWhJcEJFRVFF?=
 =?utf-8?B?RXQvVW9hb3pBUFhLMVZWeW9CZmFXVnpRNGp1aHc2MDZwZm1vajVvMjd5Vml2?=
 =?utf-8?B?a0hkU2lRdzFlVHkvVnZzenpLa3B1L1RFWHkwZlF2Z2ZieGRxcm1zT2J5Z1JQ?=
 =?utf-8?B?bWJUUXhDVXgxMjRSeGhBTjZ0blBsM3JnN3gvcFdEUmdSem53SGZuOFZMVElp?=
 =?utf-8?B?M01oa1M4anZHdWhEcnE1OWpVSk4wcFZqSHA1c2lUWlpWU3h6NWNqcnltQ0NY?=
 =?utf-8?B?NC9XK21mc0hEYzBIaXdXazRYYzVIV3prWEpyc2EyQ2FXOGcyd2ZlSytYOHlL?=
 =?utf-8?Q?+Oh+/CKZyFU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(42112799006)(366016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vmx2aGpGeTZENmpxVGZqaGwrUTVvSGpTUzNlTGQwbm95L0FNNkVrUDl3Y3Mz?=
 =?utf-8?B?VjBpcWVHZUhZVktUVmhwOWYyVXUvTmRqdmRZN05NOEZ6WklrK00rRmt2NEty?=
 =?utf-8?B?TDJ1czl4bUJwRnJIeFYyQVRvdG11dUlyRzM5Um9LUXUrV2FaMGNoU0c0TUUz?=
 =?utf-8?B?ZHJRNU9YaHo2UHVFMUpENWJCUWMreW4xZmUvM08xQ0lGTUtYNVRiVFB1UEsx?=
 =?utf-8?B?RS94Q29hVmsxZFdsakdpbzhQVTBaZkorM2tNVjNyRTdxNVhLWjF0ODBiK0cr?=
 =?utf-8?B?NE1uNEVZaXV6Vzl5aC9iZFdBeGVPRUZRcTRrQ0FmQzVrTytKZ1lUWjY0MzZC?=
 =?utf-8?B?ZkdlcnZCWGk0VDFXeU9iclZEUjBTdXZNODd3Q3Y3dzJ4NVd2d3dDREFMNm01?=
 =?utf-8?B?bWRjN202Q3AxQWFybEh4cEN0QXhDVTNBWmhXZWM3aEp1Q3M5WWdjT3VWK3V4?=
 =?utf-8?B?OHlTRGl4bGxYRXlzQXZUaWR6OThCbHJqNW1tWVRhcmpsSTZiaitUamRkdGFI?=
 =?utf-8?B?YkFZVTNXV2M3ajZLZm5BSG5Va2tScGRPcWp5VzJGVkR3bks5eGtNdVVodDc4?=
 =?utf-8?B?aTNRVXJLZXUxa1hHS25MdmZFek1UQm9CTUozM2FyMER4U2h1ZXpnSVJHQkRJ?=
 =?utf-8?B?K2xrVmpjTUdmTFN1Y2t4ZlZZcG9oejhFT3llNHZTMlRZYisxejVQZVRESk90?=
 =?utf-8?B?Mm5XUU11YUM4bTg2aGpwVStRY25OM0wxeEhBWk55VXg3Um5mWDB3Q3BaV2RV?=
 =?utf-8?B?ZHk5Sm85Ym4yd1RkM0tUMVRER2VGVFJ2ZW44VHZLdDNyaWtYa013aGRKT2p0?=
 =?utf-8?B?NjJRQXhlYVZzdklYbHppVi8rbzBGQXByN1daUWNYZnM1R3dtenB4aGtmRG16?=
 =?utf-8?B?T0hIUENySTRYZzNqZUdHa0JENmRoVCttVStKeFJkaTdIaUdlMXVDVjRSSWNa?=
 =?utf-8?B?OEswNmZQUHdZVDdTVDlUZTU0VmN5RUkyZU9oOE1ac2xnbmdUQTBpUEZuUEp5?=
 =?utf-8?B?UDZuRStoaU5oUko4VldDWWlUZjJCSU5KNlpzdHZDZ1Y0KzhaM0tqbnlxV3N3?=
 =?utf-8?B?b2tOeHJFd1YrdTkwSEJZK0dOeUFHZHE3OGJoMXFBc0thNEZvemVuVWdUNVRx?=
 =?utf-8?B?ODlJOGE0dzVQZkwxUDVJZVord0k5cnd5aTJya0g0ZjZMVzVNY1VPeEFFd0Qz?=
 =?utf-8?B?a3AwZnRwU1Q0WEVFVkY3VHF3dkFxaUxpbUdlUmZWVUZYSXlhY3QxT0pnYXpZ?=
 =?utf-8?B?L1hiN0RjdkhVZ2hxeW5xZ1lpeUlFd3hYTVpUVE5CQSt5d1h1dXpPQ1owOHV6?=
 =?utf-8?B?ODhNOHJIZVFFU1BrUmc4NnE0QnQ1LzNjNUNjTzF1TmxzKzdnOGMwZHllYU9O?=
 =?utf-8?B?QWoyMFR3QkhqeUlyTXlOaXBSRHpkYSt6ZEoyZjdoYU9zWmE2S3o3WWdjVk51?=
 =?utf-8?B?NCtpeVlSTUZtdTh3b3p5bE1waUhyb3hJNzhGUlVLckg4NjBYc3liclZOSzVh?=
 =?utf-8?B?dUtCSTJNTllxcHZCSU15Mmt2Rm5KZWE5b204dXhnMHZmdi9INkRxT3JTZThy?=
 =?utf-8?B?R08zRkxQS3hwUVQwR1MwcklRa1NjNFdtcVgrY3JERHlRTVdZL25wQmVXcTdi?=
 =?utf-8?B?amRRMThJcjExQ3F5a1dybXlCSjFMeEhESE5mUHpjRUdIWEFZT1VkRGUrblVV?=
 =?utf-8?B?K0FsV21HcVc0YnVtT3Ard1ozai9oWHZrSGcyajNxdnp6c3JyNjY3eWFlOURy?=
 =?utf-8?B?UmVFcHdzQWV2cVpBelpMSHZGam82M0RWQm5EL0daay9NYXlZdS92QUQ0cmIz?=
 =?utf-8?B?WjFCbjlDYlZnQ2ZEdStoUEtTVnhsSjRJZmZ4TFBuV3lXenRRRW43V0dPUmtT?=
 =?utf-8?B?ZFoyVnZuRzluMUxkTkdONDlPa2k4MXlNQytxVUlNbm8zOCtza0ZCRGxnc3Qy?=
 =?utf-8?B?cEIyL01zVmNGYTZEb2kyaUxya2xNODBVWEZsdkRJS0N5dnl6RG1BQTJ2aGMr?=
 =?utf-8?B?ZWI4QjdxSTBUd05HSHIzdW1UOXZ2RkVwSzRhNmNOKzEvYkgxV3UyK01tR0hD?=
 =?utf-8?B?SmladzNiZFZwdVRuVEY4SXR6RFZnYjhvRDZaZi9ZRWh5SjErUXN0N1JjWElT?=
 =?utf-8?Q?gPxNQSUZG+mG8R0p8qlrhZDbj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d24e5475-16db-4d91-2baa-08ddc41c966a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 03:55:22.0843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXPTkqUfV2bEaW4S+0lqIDUuUw3+KuLuQoP0HiMzKR91PfvVDUg8mMX7i1PEHNFoV9iM7RX0d045JgBj0gFuWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7706
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15; envelope-from=yi.l.liu@intel.com;
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

On 2025/7/15 20:27, CLEMENT MATHIEU--DRIF wrote:
> 
> 
> On 15/07/2025 10:27 am, David Woodhouse wrote:
>> On Tue, 2025-07-15 at 06:11 +0000, CLEMENT MATHIEU--DRIF wrote:
>>>
>>>
>>> On 14/07/2025 11:22 pm, Konstantin Belousov wrote:
>>>>
>>>> On Mon, Jul 14, 2025 at 05:41:22PM +0100, David Woodhouse wrote:
>>>>> On 14 July 2025 15:28:09 GMT+01:00, Yi Liu <yi.l.liu@intel.com>
>>>>> wrote:
>>>>>> Hi David,
>>>>>>
>>>>>> On 2025/7/14 16:00, David Woodhouse wrote:
>>>>>>> From: David Woodhouse <dwmw@amazon.co.uk>
>>>>>>>
>>
>>>>>> I think this "if branch" can be moved just after the inv_desc non-zero
>>>>>> reserved bit checking. Hence you don't need a ret at all. :)
>>>>>
>>>>> We want to return false if the memory write fails, and the
>>>>> interrupt has to happen afterwards.
>>>
>>> Per spec: "Hardware behavior is undefined if the Status Address
>>> specified is not an address route-able to memory"
>>>
>>> Do we want to trigger the interrupt even when the DMA fails?
>>
>> Yes, we do. That's a quality of implementation issue. Just because the
>> behaviour is 'undefined' and theoretically gives us permission to do
>> whatever we like to the guest, we should still be as sensible as
>> possible.
> 

Personally, I'm fine with generating the interrupt even the status write
failed. But to avoid potential conflict, I've also raised this question to
the VT-d spec owner. Haven't got a clear answer yet. To further understand
this, may I ask some dumb questions here. Why FreeBSD set both SW and IF
flag. What is the usage model here. Would software consider that all the QI
descriptors prior to this specific wait descriptor has succeeded when
either the interrupt got invoked or the expected status is written back?

Regards,
Yi Liu

