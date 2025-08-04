Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5D6C87FCA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 02:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uikre-0006oK-7N; Sun, 03 Aug 2025 22:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uikrU-0006kO-OW
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 22:23:40 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uikrR-0007ZA-OZ
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 22:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754274217; x=1785810217;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qnDVP3sI7hpiV7Z2KtR+qwqdOXPiUjGbU1BTJxLVMb4=;
 b=Qo+JdjIabQE1boU+mEJUsIyTGF6E+uO0NC+Xd1fUHfktd6IhmFkhUOFW
 0ySADEKU7OJvnt8x4dhHg3xwk+FsH0E3AEg1tqVYXxJQdJYW9tK+ywbUs
 CS6SWAJHhpxWK8f51lFLfN92RhEnXLkxi229Lr/BWa9UXX+dCACkMJ8xI
 uH9xbXIPfOPs8mFQUy8XtBG2bgU3EwKVIGPyH4UC0kApBi2BucI7sqUk4
 +FzzcURiqqPbfAOkvYPX9jKgbdrYQaZv9QvI+cEmxB2RT0bGPDURBOkZ8
 xFygIpNOmVuJ3Pkkg9VOsd5MyqLU1qETq1b0wn0v5boBU6OLyk9MILyhG g==;
X-CSE-ConnectionGUID: G8XSnVDATc2fvLWw3gkjTg==
X-CSE-MsgGUID: aNnfb3btTYqcZ+0Ft7emPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="67976458"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; d="scan'208";a="67976458"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2025 19:23:33 -0700
X-CSE-ConnectionGUID: 94joPzZZQWK9R83+DvANjg==
X-CSE-MsgGUID: n4pTD/LhQ1CYATZqaq3ryA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; d="scan'208";a="164483912"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2025 19:23:33 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 3 Aug 2025 19:23:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sun, 3 Aug 2025 19:23:32 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.67)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 3 Aug 2025 19:23:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7UDUmMCpTJoKf/nj54Bjvxb4GemkVYHxO1CHvTzYeP0Oenm/IhLagQq34qXijsTdwm4nn0TzAwdQ+ZDjZcVC+CdKwToFHELuKF+68UmbyjTMmu27kXJVjEsfjTqTev6PdXo2I2xemcz0gUbCz346fL+Ue1tA/865J7SFXo+dvAV5okjgKdEvX0papNzHm8g6Enyw3aJysd4Fqvp53w8Bjt2A0V8h/0/Y4gIG+dt4A+ZtCs3jpnVG0v+WA9nOI756+Xz2yPY+Z8lijRd0w6moAS5WT/Saf+pibyNl6fRVhWT8Xnslx0sVuW9Rf5cYRueDwxBwLTq4X5d4JEkZmuNSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnDVP3sI7hpiV7Z2KtR+qwqdOXPiUjGbU1BTJxLVMb4=;
 b=rfCX8gZr5Pe+QF0I2k5AaFDqVNsc3K+1iq+CBCuNluhzYubZBUynyVe3RKYjF/MuEbBxKvalIcns5oakembff9ChyplrSicffkVKtG67o47+8g7Ph1pj1W5CYW9WbN0Mk5gJhW9sTu+AtYlH8ngeTs+omtn++sC3d0w/g5gxknmVN+/9QOkuLnYJnX/JCMccby+ovchPY46c+3A9Oz4ROCvs0tK7KGoS3S7ZFroB06apqZsmbuzsBBQAw3MMx8BirB/9gnfefK7aPOEx38q544SsHuLfO5/LdxPNebH9g1l45R08L1vphTfrgwDPzkrJiGH8X+GPzh8p7PN5/l8lSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MN6PR11MB8195.namprd11.prod.outlook.com (2603:10b6:208:47f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 02:22:49 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 02:22:48 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, =?utf-8?B?J1BoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpJw==?=
 <philmd@linaro.org>
Subject: RE: [PATCH v3] vfio: Introduce helper vfio_pci_from_vfio_device()
Thread-Topic: [PATCH v3] vfio: Introduce helper vfio_pci_from_vfio_device()
Thread-Index: AQHcAoz/W/Dqu93ZF0WSs3LZ3mV1R7RNSQwAgACdSACAA+GAYA==
Date: Mon, 4 Aug 2025 02:22:48 +0000
Message-ID: <IA3PR11MB9136F23BEBE45615549D86269223A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250801023533.1458644-1-zhenzhong.duan@intel.com>
 <8b599c19-1901-4707-a8ca-943f61c0e2f9@redhat.com>
 <ed8451bd-853a-429e-987c-4ec86e01efe9@redhat.com>
In-Reply-To: <ed8451bd-853a-429e-987c-4ec86e01efe9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MN6PR11MB8195:EE_
x-ms-office365-filtering-correlation-id: 35acd332-5320-433f-d333-08ddd2fdce30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bmd5UGJxc3VKcHovNUtKVDVJRkNsYlZwazRhUjRSRkx5TnBQTEMxWGtLREEr?=
 =?utf-8?B?YWx3K3NUVkp1b0M3aU5MQTFINnlFK2FpdkRQb0NLUDZ3a2JCR2V4d1M0ekRu?=
 =?utf-8?B?bm12VlZIQVZDU1AwZjV5T1BoWWR6U2hIaVFuN25RekhxK216SzlUbnJPdkF6?=
 =?utf-8?B?UDJuWW1ZeG8xUXRxS2FOSGFPRXo5QUxXN2p0WEpvSW1saGtyNHAzWWZXeEps?=
 =?utf-8?B?ZWIvOTBiRDZhby84V1JnUW0zR2UyVmJKZndrZXFRK2lJTzZJcWFUSWc2Umw1?=
 =?utf-8?B?MUhUcDVhUUhhd05Zd2ZZWlMzWDJaV1pxOFpXMWpYWU1YdVJQUW82RlR6R1J6?=
 =?utf-8?B?OU9MeFhENkhreWllRGVTQXIxaXlOSTlPay85bkdJK0dnS1dxTnlJQkNVSzRG?=
 =?utf-8?B?OHEyVWVpbE5DUktCRklTTGplNHpYMVlwQmpOd2J6UXVOVFhGb0w3S1hHWEIw?=
 =?utf-8?B?aGRGQ3ZiVFpWSnh3YUMwN2x3WTYrRU4vSzNWUVQ1OSt0dHIxU3ZhNHJqSzll?=
 =?utf-8?B?SVNJMW1hNGUxN2gvR085TGFQOTlnWG55TVAvTDg0dXJIQyt4WDhocFVsNXFu?=
 =?utf-8?B?T0Z4WWpRUDNOWmVhakNzUXAzL0JaRCs4SWVJWHhNbzdGQWVzc1YzNmN5UjEw?=
 =?utf-8?B?VzU1TlJBQzNmOFI4U1F2cnhQZVM0UnBtRWIvNjBQNkNtV0RHdjJtZzBJU0lX?=
 =?utf-8?B?UFVXSmowUUM4bXh0dHBNZjlySS9lSGFqSDVyNWpSZFV3bkIzRm5pVGl2OVph?=
 =?utf-8?B?OE5TQmNDTFVhSWFvQ2Z6bHlhRzBXVFRoMzlzWFhDNFJMYTdWMy8xd3cxNVVL?=
 =?utf-8?B?UEZzYmpxQU0xQlZRcVh0TXBtL3lacjFaczlPWEc0d1B5bHkweVhoQ2NIU0Iw?=
 =?utf-8?B?Mm5UbVVXKzRNQW9rRE95TDhCVm5OQk5EaVdsbWtBbXZsMHIyME9kU3NrT0x4?=
 =?utf-8?B?UDREQkZhK3lOUGZ4NnMxMUZkTmFLc1lzc1E2MUNNSDIvcGFPd1NRcDFoMC9I?=
 =?utf-8?B?YjA5aFlnSllyakQ4bW1QdGplMWRyQ0xqcHQxYmZEek1ENnFJUDJ2VkZVSjBy?=
 =?utf-8?B?RVZ1M29BUFFoc21WemdTZ251bTFMVUN3NE9WZTNjWkJDeElNYldtQ01GL2pI?=
 =?utf-8?B?bmVxdkZGWjVFQVJsUmhKWnhoRmw2K1NRSXNCQ3k1S3paR3E5UnFjalh6TmI5?=
 =?utf-8?B?c1VmdWNlREpoZHB6VHQ5K3Vzd2xaQ2FZUnVVSmtnb1V2Y1grNzU4V25kU2xQ?=
 =?utf-8?B?QlVRZjFIbEZ3TWtZcmdTRWtZV3ZXMkJwN3VZUHR5NjJpR3d2dW1DVjFMUEY5?=
 =?utf-8?B?bm1JWW4xd1NIZFBXUkE3akFUZ0xnQkxEeklyZEVrL013c3Z0cnZJemczcnc0?=
 =?utf-8?B?MTRUUFBDUytsV0RDcUxwYzZueFNDVGxrMTdSQlNMbmZWeGc1SEtOY3Y0NFpJ?=
 =?utf-8?B?RGQxcDMyTzVwRVZVQk1yMDRLZzBEYXlPRGVZcjJhZmR4b3g1YldEMXJlT1Zr?=
 =?utf-8?B?cS9GYStncU5aeUJ4UDFmWG9HRFpuL05RbEFwYUJSaWxkWHBsOWtrSEE3TnFV?=
 =?utf-8?B?eTVDR2ZvVm1vanVBajgzSDBUM2JNZGVOLzlkUWJ6dExVRkp6SFN6OHY5Vk83?=
 =?utf-8?B?LzgwcG00WU8zUnpqNm9wdGN0RXE1dWp2V1V0cWdSMkJMQ0lCRm05cGxJNm1s?=
 =?utf-8?B?UE1tYUZtdnVqM3h2K2FYQklWSzJGRXE0SDVmeVlxakM0VnQ2UGc0MlRyTVFB?=
 =?utf-8?B?MHZRM0dxR2YrOEdScVVtSGZORlRBMTlucGw1ajJQR042QWVLaldoUEhJMlFR?=
 =?utf-8?B?czdYSWtxeHFVT3BRN0Fkd3hiZEJMQzgwVEFqUE1uZ1p1UWhUelQyYzR1UXZy?=
 =?utf-8?B?Zjh0V0JyaU01VERHZ3BYRUFDZWtYT011bzRMTElOZDN6dGpyN0NPU2hKY2Vr?=
 =?utf-8?B?cFhSeTZ6NjFmQXI0UFZDMzhxVTJkSGxBU2lNOWNGUFI1ZVp1UlVUaTBmK0hW?=
 =?utf-8?Q?lEppTKKCpDxWGLjYDu/EzMOmcwdzVQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c004Y2N0YU9MbXd2TmM4VHllb2VIVEZsY0wzQndGbjR4VjNQM3E2cEpPeWlz?=
 =?utf-8?B?d1pQY3BXNzBvRDNuQk03MTlDM3h0UVYxZWJ5d04wT1FRR2hNa3hydDVCMTgr?=
 =?utf-8?B?aTQwRTgveUNUY0VrMTRYdzRtRjZOaHppTTBudUE3ZWMyTVZIczBQblRuR3lK?=
 =?utf-8?B?d0RRWXRVNC90K21nenh2MjR4UFRuVW9qS05zZWNJT1lWSHRnVVkxVDNLc09K?=
 =?utf-8?B?cjFmSEUwUWFWeTlzTit1Q24wVGdZcnpZR3lFVS80RSt5Ulh6ckpsMzNleEll?=
 =?utf-8?B?L1VYS3g2OXp1MDdZcDVXMzZJdnQ3OTVmbG00dHc5OEdjNFY0WXJ1MWZZb2xu?=
 =?utf-8?B?RUUzQ0ZjYmhlN1lPeXZaeHVSMW5KUFlYY09Rc2lUSTZtUjY2b1hHamRCK1B3?=
 =?utf-8?B?dWlMeVZmSTV2TEJHL2svRC9zeTh3MlpEZzhQZVNqNGQxaDdkVTkyZk5ZeVZ2?=
 =?utf-8?B?aXMrMkd0ckFGcjlsRUpLZVBuS0pBV2xnVUN6dVIvaXh2c3ZBSmxiOUdvc3g0?=
 =?utf-8?B?QkVoSXlWWnBKRnpTMEd0a2xseHZjQ0lIT2gweWFHWVliL2RMZkp3cEhKTUNR?=
 =?utf-8?B?cDFJV2VGTHVFbUFhU2tUSjZtRDJuUTcramlNS1VTT1RNa09lK2RhdHFIM3J6?=
 =?utf-8?B?a3Y3cUM3d1dVZ1FMSzIrUm9LaG1KcjBwYWptTjFwTUJsRFB6bTBLZDdrMFZQ?=
 =?utf-8?B?OUtzalNNZVJ1RUw5YzBFUjVKTEtCVURCZVJHamFOM3RqK09nV1RvSGc1eDNX?=
 =?utf-8?B?YzVWbEZoY3VTY0tIUGttZGVLVVBBa3pYTUZPMmtFTkRmTGVYaGZvL1pXOWVl?=
 =?utf-8?B?bmtPbEtlc0wvWnF2Y1pqZ3N5OUdLUk5nYXlhVXFPTklBTi9NTTc2ZzQrcHk3?=
 =?utf-8?B?dGdQdG55N3dXL2JYOTNBTGp2QS84MHR5QWhRUFRLcVNFUklwNnNLbUZwbmRW?=
 =?utf-8?B?SHFiK2p4TFJ2NWt1TFVYRklpM1IxeWJtUUxuRXl5ZHRta1VESFBIcVU5WHhX?=
 =?utf-8?B?dUUwMFFHdW9xZTFyamFON2U1T0p5TlJTUk5xYlI4RFJFVE1GNXcrZzhnRFdx?=
 =?utf-8?B?UUE3M3QrZUN3c2NwdUIvUzhCaStleko4L2hLenE5czRDem9hMGkrTHV2WUF2?=
 =?utf-8?B?V3Z1TGVCeVJCZExMcHhvQUZzMjU3N3lUOUZmS3V3Ly9tODJvdHk5NnVySlhw?=
 =?utf-8?B?dUNhNFZvL05HN3E2NzhnS1ZIUkdOYWpIMFY0eExoaCtMNU1vMVZYQkhKVjgv?=
 =?utf-8?B?cDFXdXBjZWR2RU9iTXdIRjM3MUxNdTV3S1ZwRUtEblFzUXlic0thNVJqUlRI?=
 =?utf-8?B?L1ZldHp2TmppaWFLeWIxQlFFdDRydlFwRzVLZ0VzZGg5VDRRdzNpYkZWRDRt?=
 =?utf-8?B?R3NWV1h2Smxmb1N3d01kUHhSUWlZL0FodlRPRUNuNnArYW9RMXFnaVhHczR1?=
 =?utf-8?B?MU9tOThIMXdKN0poYkJkQ0kvd1FuanNBQ0N6NGc4Z0RVZlhmeE1NWUpDa2xi?=
 =?utf-8?B?M1RHbEt0cU9sWHJiUFF6ZzNDbTYrVUtTN3VuVHE1RmxOYnFPUFpDN0EzQTlm?=
 =?utf-8?B?Z2NlellLK2VuR1g3ZGRJYkxXSGJjb1pDVGdYbXczVy9kdVZSWXErRkhERCs0?=
 =?utf-8?B?TDhqMjV6aTNjMlFpdExUekFTNjdkNy9uRXl0UXdHaUJyRVFSNVRHNXdLaFI0?=
 =?utf-8?B?SmgrMTJtL0NCZVpkc0JDek9HZVF5eU85Qmxzb2s3dmNSc2sxY3VnTzVsYlFh?=
 =?utf-8?B?SHhXRHJ1aEFyUkN0NzFjUngxakRsSC9pZFpGWWEyWXIycHB0bHN5MEZ0Mndt?=
 =?utf-8?B?N1lSVHR1K2FvWDZzLytoUlZBaUZYVVlZcHJGZE1YQTUwRU5wWUx0a1YxSjZi?=
 =?utf-8?B?d21pQkxac3ZZcTRwa3U1QU5zNDFxK0JUM3lhZklyOUgyZkVvWHMyWU0yVzgv?=
 =?utf-8?B?RGUrVDFHR2xHTmtkRGYrY3BKVFgweEJXVDVMTWh1YXdtTGNDekxPN3c4WFRY?=
 =?utf-8?B?bFZUNFdXWGp1cklQWnFUeUp4Tm9wbTgvWm1mYWF3T1Z6T2UwZk5ESmhFenJS?=
 =?utf-8?B?eHRFWHF0RllnQ0ErcVdzU0J5WWlSMDhsUzRpU0MxNnZSc21UVTRGVkpmcTZj?=
 =?utf-8?Q?HJ5eLngDSV9207k16ypynbwnU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35acd332-5320-433f-d333-08ddd2fdce30
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 02:22:48.3853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fPZ20QLvgss7E/+Stemfl5izBUcsRL6S1hGvSeYSUQ2EOIPP3agjQUhfYmRXp6kAgRqQF50xAOeWI4ZnZ/92ZP1L+2TtjYLcdnNMWocvGsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8195
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzXSB2ZmlvOiBJbnRyb2R1
Y2UgaGVscGVyIHZmaW9fcGNpX2Zyb21fdmZpb19kZXZpY2UoKQ0KPg0KPlpoZW56aG9uZywNCj4N
Cj5PbiA4LzEvMjUgMDc6NDIsIEPDqWRyaWMgTGUgR29hdGVyIHdyb3RlOg0KPj4gT24gOC8xLzI1
IDA0OjM1LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+PiBJbnRyb2R1Y2UgaGVscGVyIHZmaW9f
cGNpX2Zyb21fdmZpb19kZXZpY2UoKSB0byB0cmFuc2Zvcm0gZnJvbQ0KPlZGSU9EZXZpY2UNCj4+
PiB0byBWRklPUENJRGV2aWNlLCBhbHNvIHRvIGhpZGUgbG93IGxldmVsIFZGSU9fREVWSUNFX1RZ
UEVfUENJIHR5cGUNCj5jaGVjay4NCj4+Pg0KPj4+IFN1Z2dlc3RlZC1ieTogQ8OpZHJpYyBMZSBH
b2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFu
IDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4gLS0tDQo+Pj4gdjM6IGFkZCBvbmUgbGlu
ZSBjb21tZW50IHRvIHRoZSBoZWxwZXINCj4+PiB2MjogbW92ZSBoZWxwZXIgdG8gaHcvdmZpby9w
Y2kuW2hjXQ0KPj4+IMKgwqDCoMKgIHJlbmFtZSB3aXRoIHZmaW9fcGNpXyBwcmVmaXgNCj4+Pg0K
Pj4+IMKgIGh3L3ZmaW8vcGNpLmjCoMKgwqDCoMKgwqAgfCAxICsNCj4+PiDCoCBody92ZmlvL2Nv
bnRhaW5lci5jIHwgNCArKy0tDQo+Pj4gwqAgaHcvdmZpby9kZXZpY2UuY8KgwqDCoCB8IDIgKy0N
Cj4+PiDCoCBody92ZmlvL2lvbW11ZmQuY8KgwqAgfCA0ICsrLS0NCj4+PiDCoCBody92ZmlvL2xp
c3RlbmVyLmPCoCB8IDQgKystLQ0KPj4+IMKgIGh3L3ZmaW8vcGNpLmPCoMKgwqDCoMKgwqAgfCA5
ICsrKysrKysrKw0KPj4+IMKgIDYgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgNyBk
ZWxldGlvbnMoLSkNCj4+DQo+Pg0KPj4gUmV2aWV3ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxj
bGdAcmVkaGF0LmNvbT4NCj4+DQo+PiBUaGFua3MsDQo+Pg0KPj4gQy4NCj4NCj5JIGhhdmUgbW9k
aWZpZWQgeW91ciBwYXRjaCB3aXRoIDoNCj4NCj4rLyoqDQo+KyAgKiB2ZmlvX3BjaV9mcm9tX3Zm
aW9fZGV2aWNlOiBUcmFuc2Zvcm0gZnJvbSBWRklPRGV2aWNlIHRvDQo+KyAgKiBWRklPUENJRGV2
aWNlDQo+KyAgKg0KPisgICogVGhpcyBmdW5jdGlvbiBjaGVja3MgaWYgdGhlIGdpdmVuIEB2YmFz
ZWRldiBpcyBhIFZGSU8gUENJIGRldmljZS4NCj4rICAqIElmIGl0IGlzLCBpdCByZXR1cm5zIHRo
ZSBjb250YWluaW5nIFZGSU9QQ0lEZXZpY2UuDQo+KyAgKg0KPisgICogQHZiYXNlZGV2OiBUaGUg
VkZJT0RldmljZSB0byB0cmFuc2Zvcm0NCj4rICAqDQo+KyAgKiBSZXR1cm46IFRoZSBWRklPUENJ
RGV2aWNlIG9uIHN1Y2Nlc3MsIE5VTEwgb24gZmFpbHVyZS4NCj4rICAqLw0KPg0KPlNlZSBodHRw
czovL2dpdGh1Yi5jb20vbGVnb2F0ZXIvcWVtdS90cmVlL3ZmaW8tMTAuMi4NCg0KVGhhbmtzIEPD
qWRyaWMsIGxvb2tzIGJldHRlci4NCg0KPg0KPkkgZG9uJ3QgdGhpbmsgaXQncyByZWFsbHkgbmVj
ZXNzYXJ5LCBhcyB0aGVzZSBhcmUgaW50ZXJuYWwgQVBJcyBhbmQNCj5ub25lIGFyZSBkb2N1bWVu
dGVkLCBidXQgUGhpbGlwcGUgc2VlbXMga2VlbiBvbiBpdC4gSSBndWVzcyBoZSBwbGFucw0KPnRv
IHZvbHVudGVlciB0byBkb2N1bWVudCB0aGUgcmVzdCA7KQ0KPg0KPk5vIG5lZWQgdG8gcmVzZW5k
IGEgdjQuDQoNCkdvdCBpdC4NCg0KQlJzLA0KWmhlbnpob25nDQo=

