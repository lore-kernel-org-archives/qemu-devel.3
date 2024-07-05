Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69687C30653
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 01:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPY27-0001iX-Lt; Thu, 04 Jul 2024 21:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sPY25-0001hG-L7
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 21:46:41 -0400
Received: from esa13.fujitsucc.c3s2.iphmx.com ([68.232.156.96])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sPY23-0003O7-59
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 21:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1720143999; x=1751679999;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=U+pPeiXaL43oLFy3lcErurO+oM9YsVunx8fYk9pQOzY=;
 b=wgM+W7RRfqFBg6EV4gnCzgKe82Z4dG0A6dITS1906g5wq2M2oDvudExr
 Eg6l8xCvf+kW5Mq5LArC3omvL63rzYD3B/Y1wYXuOc/0vck6sJ21cWQTC
 w5iB6Mael1GDRRfqeN5iaqOZk1DKONPvc+mOhJTc0bb5xX7Jkwg7iW4H8
 gj6WMVZ0hH3bwz3IXiXRvrhZYx4dKyb1S/TE3GnryiTeZnRzDGs8v7PIl
 E/JwafhyMa3Y6Cayz7zAgSnKZ5ss4R0h4mkOWMUyYRUMtO2yLonLFQuA3
 DamZmg8hZp4eDxwRTaBmY/4dWtwui/zUf2IebCox3E4SWnJASK2F2Wo3x A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="123843619"
X-IronPort-AV: E=Sophos;i="6.09,183,1716217200"; d="scan'208";a="123843619"
Received: from mail-japaneastazlp17010005.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.5])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 10:46:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8igbwOF+WoGbTAnqjUNCDrtFudxiYUoKJtgCkhNsGesUfPCra+/bsRluADu4vyU65NBZ16VHxaejRbOwie1KfUgxkcd99wV3p0Oe0PqQywYzkxlsMVyuWXeP9DjOoMPeViPgebs5ZGRMcxEkLMNTkHSW6Dp0pHvaEHB/0zcNRh8AieN0DcraH8ISzgdjlaoum4iAwIKs0/plnMLXSb996mJeH62KwL0joK5FILkuPDfgjrtsl0lfPzc+gnCf2njqSkcNo0NnahhI9rsi2QIuoAc94VBdxDb7oRcl0c9aGHsSDNbPH3Y8Td8nS1plARtoZ9vGo59KK+U/c248rjZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+pPeiXaL43oLFy3lcErurO+oM9YsVunx8fYk9pQOzY=;
 b=B8q10wOJA+ekJk/YoH0PfG/rD//Q3yQDVKyGEerIUYhY8a4NHK86Z0NKLdBMjBrVX01zUF32O+OKabz48xDjcI5AbbkLA/zv0oOqQzii3s+BexhY6R5g9fNsT2HOmxmUNNANfdgPVHCTP8CwOrorz2KcfPBz2BvSVdGf3IHibXAksMIYEWPD/o2FL1ssOu2ckZNeSKSqANPwwg8/sIciPJLPuXelckX155EwG2a3CU0ym8hGkpaGyE/8MxxGgJLzcMMJZrCsTEjKN6AFSyAyVy3FMrab7vP0Smw+QYnHTiQ9Pby9VERklE6SvOucGzunwNSYVGGZwHrlLTAgi3tT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB6464.jpnprd01.prod.outlook.com (2603:1096:400:7e::7)
 by TY3PR01MB10905.jpnprd01.prod.outlook.com (2603:1096:400:3b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 01:46:27 +0000
Received: from TYCPR01MB6464.jpnprd01.prod.outlook.com
 ([fe80::882:d445:280b:8484]) by TYCPR01MB6464.jpnprd01.prod.outlook.com
 ([fe80::882:d445:280b:8484%2]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 01:46:27 +0000
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alexandre Iooss <erdnaxe@crans.org>, Richard Henderson
 <richard.henderson@linaro.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang
 <wangyanan55@huawei.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, Eduardo
 Habkost <eduardo@habkost.net>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>
Subject: RE: [PATCH v5 6/7] tests/plugin/mem: add option to print memory
 accesses
Thread-Topic: [PATCH v5 6/7] tests/plugin/mem: add option to print memory
 accesses
Thread-Index: AQHaznNMEQj6r8IykkGEPSh8zeZhqrHnXScQ
Date: Fri, 5 Jul 2024 01:46:26 +0000
Message-ID: <TYCPR01MB64641656B2DEAB7A1966A8EB8DDF2@TYCPR01MB6464.jpnprd01.prod.outlook.com>
References: <20240705003421.750895-1-pierrick.bouvier@linaro.org>
 <20240705003421.750895-7-pierrick.bouvier@linaro.org>
In-Reply-To: <20240705003421.750895-7-pierrick.bouvier@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9M2UxOTk3Y2QtMTIzNi00MmIwLTk1ZGMtNjE3Nzg1Yjdh?=
 =?utf-8?B?MDg5O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA3LTA1VDAxOjQ1OjQzWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB6464:EE_|TY3PR01MB10905:EE_
x-ms-office365-filtering-correlation-id: 633d0f59-e672-4d2a-ff11-08dc9c9448b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RUo3ek5ncEpjUjBGTjhWcElNbm1HdW1sRDBRS0Z1ME5YakpXUC8wVjQzVnNu?=
 =?utf-8?B?eDVGWWtIeldRL1B0R1B3K2tQd2hPU3EwekxSNnQ1WldsZ0NYRStjM1hmV3Q4?=
 =?utf-8?B?TmVranFhTDkwbVFYdCtGVDc0dXJuWlJxSldVWnEwSFpMeUJjbUE3L1pMUmhn?=
 =?utf-8?B?OGZ5d29HMlYxemRkckk5QkU1UzVyd1BKa01EcVVtSlBEcGMvM0k5ZjZkS1pL?=
 =?utf-8?B?V0FYOVJKS1Z3QjhJRFFJT2szV3BTZWhWb2FFeGl5NDNSZTZmUzdtbVlwenRK?=
 =?utf-8?B?ZzVCVCt0TXA0Qk5tZ1lnbWNRV2xVbVRJaUtkZVdqUG94YnZIcG5BMytPTVlm?=
 =?utf-8?B?Z1pkZjJsNVhWOFB2TVE3aFNFR3ZMczd2MHhBa1FmZGJnc3FoaExtNnFUSWo3?=
 =?utf-8?B?bjR1UkxNTTBCL3RGZ0dJOTZkWmNqbWd1TmJ5bFdhbmhha25JV21RT0FGajJX?=
 =?utf-8?B?SFcrQmk3a01URWhGT013QktMcmIxdlJiV1B5NDhha1piVVNxcXZseCtNa25N?=
 =?utf-8?B?dXByS2QvZW5ua3hkRXp3VmVjWEhjcGd2bDRjWHJCVGZsRGV1N0NJTUtFdEtk?=
 =?utf-8?B?S1NRSllva0NrUlRqU3ZNR0pMOGxGNk1KNUtZT2tTbFZrelh1NXVBU3RHc2Nz?=
 =?utf-8?B?eGExMVc5d2w0QW5FWTFvei9RKzRVR2Jad2FOb2QybGN0SVNPNlVWK1VhMkoz?=
 =?utf-8?B?SFRFc3pqa2tJNTY5cjRucDFCQktrS21pbURBQU1WcGtIVVZHbG1TZFd3QmQ2?=
 =?utf-8?B?WWpjdklBcysxcXNXK2V2aVY3V0pBQXp4YzlFRDVPcE90NDRUSHFFb2hzY3VR?=
 =?utf-8?B?Z1l3Q3BjM2FBaTJ3ODN2MWxzTWh6ejIzdTQ0b2JESFkwUXJobHBHbThSUkJV?=
 =?utf-8?B?aE4wdExxanJNZmFxa0VRZFp1Wk9vNGxUcHNaZnZicnJsWjhDWlFFSHR5NTFw?=
 =?utf-8?B?VHVGWWhSU29rYnNnNEczOENKWFJFK3JIMjRsRlNIUGgzM3o1NXJXQkg3bmNx?=
 =?utf-8?B?MVd4aTZ4QU43QmxTaStmTWdrOHk3SHJnOG43c052eG5xNFZuUXBncjZ2cWdI?=
 =?utf-8?B?YWhnSEJBVkVDN0RtS1NwTW02WnBxYTh2WEY1OC83VTQ5SnNXSE9jcWtuWFE0?=
 =?utf-8?B?YzVNTjBmQXg5VUxFNFR3WlgwVHdhSzFoNEVWRGdsUHZ5VEJOMlNBSVl4R2lT?=
 =?utf-8?B?RUdRblRQMFF6NG9ncis2d3E1c2hzOGl2M2ttL2wwYzc1c2V5ZWQ4clM5YzJS?=
 =?utf-8?B?UGJMdml6K0RKUkwwTmx4dWZWTTYxUENLY0VJbXhraUhoYzJOZ2lyT2tJT29v?=
 =?utf-8?B?REpubzNDUzdmdDlLUGY3aFV5aHNPeVRrNWhqWWVOWStvN0c5L3kzZk1kS1p1?=
 =?utf-8?B?eGRHMkxQUGtsY0oyeHZTQy81VmZYa3JHYk9uM2I4dENxRDk5VmZWWnZNMVpy?=
 =?utf-8?B?K3NJZDhab2xibGlEazkyUGQzQzdkOWRXUlY3Mm82Y1VRMEZGU3c1K3RGZllF?=
 =?utf-8?B?ZUZLNm9TTVprcmtobEFacHBTUzFjNWttMUNsOXlabnRreTVqSHQ0VmJvMDJH?=
 =?utf-8?B?Wm5YR3kvSjRQWHFYY044V3BNRldaaFV6SlR6UWtKUisxTkxJVDFDa3BGZk82?=
 =?utf-8?B?aFVMWUcxazRKUkhtLzVsdUVRbmtMczZ3anhRS2VyYnhYRFpjZUJ6Nm11Q2lH?=
 =?utf-8?B?MVBwQmxoTEI3U056TjFyMHZQaGlmeDVBVVFManRvUjhyL2FJaC9FL3FncTVn?=
 =?utf-8?B?dUdmbzdjbGd4NDlmWFpMdWs1NVpBZlFuRC92V3dpdWVYZUZHK1ZMNWN6R2U4?=
 =?utf-8?B?Y3VFTVhiQ2xVWk9sZ1l3Zyt5ZmFjSCtNelBHTTRiS2V6eFFqdWRLN09rbHM4?=
 =?utf-8?B?bDlFRStCNEQwNi9jY2pnZ1pWMDZVZWNmbEVpTFBMaHJXWnczcmFmay9aVk9X?=
 =?utf-8?Q?OxSl8zXm1RM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYCPR01MB6464.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(1580799027)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzlLOHBuaDltVVlmSXRvR01DNHpudnExSlZ4d1BiM1hCK2xYdHRjRWUzL1lY?=
 =?utf-8?B?M3ZQZklVaG5CMGhRQSsxdlN2VFB0TGVVNWM4bWVmZ1pSSnV2VWo4aXkxMHNH?=
 =?utf-8?B?Z1kvVzRiay9hdmRYbC83QWl4RHFLaDF5K1pQblRpcUtxTGtwYWZTWmQ5R0pv?=
 =?utf-8?B?citFWjcyb1ZucGlTSmRqNndGeDJSUFYwL1I3Q1ZvQmxiSzBzY2ovZGxpK1FW?=
 =?utf-8?B?dENGd1U1RjdFNlJ4WjdXTmEzMEFKMjg2Z21NT1V3dVUxQ005RTVXSTZhSjFK?=
 =?utf-8?B?VXhKMlB3eFlEZnVBVXJJU0M2UmJwUEVoZDZuSE9ObXpwVEQybFdnbituVGlU?=
 =?utf-8?B?eXE4NkNQVGxkMWtIRGNqUEhWbFU1dnNyU3Y4anUxQW1ubzBnRzczNTVSUG5j?=
 =?utf-8?B?bnFxb1B0WEJsYlZHaHJjbzBrNGsvb2VqMmZDSkxQRFYvUGVJUUxXN3JUOWlq?=
 =?utf-8?B?bVdpbG5qdUlybmJyS210QjR3aVE2ekwzMEEzeWUzT0krdEJnd3hvVTdPOUE1?=
 =?utf-8?B?S3V3Um1lb1g4MlJtSWRlTlUreWl6Rm5YRG5JODRlWlVjT3N6RVo2ZHcyQU9Y?=
 =?utf-8?B?eXo5S21RaFIySFU0R0FMMkpWRGlJQ1JYN0dHRmRsU1o5UW9DUk1QQ1MwQ2gx?=
 =?utf-8?B?dEpxSlQ2M1hDNzZISndxOVE3USs4SDdOT1prV2I1enphZVcrc1pGZEZZcDdr?=
 =?utf-8?B?RWdzYU1JdXVtaGpvYUMyZnJzejM1Z3VBUWxnWm1TUnFHZVJoMkVGbklmM2d2?=
 =?utf-8?B?cGtjYkhXL3RrZjFHS3ZDaDhOY1NNWllMaTFKaklhUjNLWHZRd0tWc2IwbHIv?=
 =?utf-8?B?K2dGYWs4SHdQcWM5UExyTUVQQkVGSy9sdkdaN3RLd1I0UVdZTlRUbGJrVnh4?=
 =?utf-8?B?aWFrSGs5YkcrUFpNTUZVNDlrR1hlbXBmZDNmSmJOeXlMSjNiNU1Kc1JoWlRl?=
 =?utf-8?B?QUdKNVZMeGdOc2FmdENKYjc3RUN2S09OOGN2Wi8vcm1aQlExRysySFArYzIy?=
 =?utf-8?B?L2VOM2N6QjRpTVRuSm9EdmRnRXBrSUE4WTFaMWhjSHZBWFpxVEFtZjFiUysw?=
 =?utf-8?B?QTB1ZVFEZkJYQjJ2VUJMVkkxRTZkeDJnWDgrcW5DVS81MUx4Yyt5Wi8rTXU0?=
 =?utf-8?B?WWhES2MyUzNrNDJNWXk4ZHQ2S04xcytxNzc4UHdEVk4zTWRIQ2tsdDhUbkRt?=
 =?utf-8?B?anl2R3FVdjdsd2FMYVY1SGVuZ3l2Unh2cGpQeDJZRXp3K05FbCsybENBTnMv?=
 =?utf-8?B?VkVIWWxRZVkwUDZNN1BjMUVNNzQyRGg3bUxxT05VSS9EUkFFdzFNeDhhaGly?=
 =?utf-8?B?dEQ4b1g4RlREY1kvcURLcklnS0FPazgyR0xOTnJRTkZDWGVkemdRS05LclJs?=
 =?utf-8?B?WUZGQ2M2NXRNRkRReElLQVZ2SDFQYitrK1pwY1R6NCtDR1IzOE9VNHZ1cWt5?=
 =?utf-8?B?QW55N3I3Zld5bXpldmZvMm8yQmx1Y0RWREtWL0Rzd2xOa1gyV09lY3pRZTNt?=
 =?utf-8?B?YlJ5YkVnM2wwNnJ2TTBBM0lycVM4SERUZ2h1S3BzVVBDcDNCVjY5QXBMZWJS?=
 =?utf-8?B?NWlJeFhXREh1WGQzbDVtdzJrSzNJM1Z5c0pHbzdra3h5bmd4eWdoZml1ZnVI?=
 =?utf-8?B?RzNyRHl4T0wrbE8waWJhVFdZZ090L1FlSEhOTTZYWU1iZVV2ZCt4U1l6N1B3?=
 =?utf-8?B?OWFtandiVkpLT2xEQmU4b2tONlFPV2J3b1NLaG1KNXVpTEcvQ1FHVkhPdEZ1?=
 =?utf-8?B?Y2NWeUx5SloydkZiTUNnWURiQ2FNd3NDMVZsU3pJejV5YURxenIrMHBjTW5t?=
 =?utf-8?B?SmxVL29JTGV4SUFnaW1DNE96cGdPU1VoOEo0Q3RzWDFmazRVdklPVWJmN0pT?=
 =?utf-8?B?cTVCa2dMRGw0Tjc0VWNmUDN2S3IrdDJ4dFpwekRnOGRIQjNKT3JDbjNRU1VW?=
 =?utf-8?B?d2p6Zm41TnFMYWZwVkluc3JUSEIwYU5wbnF5UEZnakRNU042WGR1ZGpUYy9E?=
 =?utf-8?B?WHo2Ui84cHVQY2J4MXdBQU5Na2MrWGN3cDBXTWl3SnlXV0VoYWp6SGd1N1I2?=
 =?utf-8?B?RElDTTcvaCtTSlE2VXdUUjVyZDc4djFyUE9Tbm5EUGZ3Q251VFZ4aFBkdlUy?=
 =?utf-8?Q?VQDe2TONllBQXwl/YZ6enVBob?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LWo0W04WpzAl3g7jYbzcp8fgJDyHrPNVztpKeYl8aiU0b1EIlbdBLJPYmYHLDV+oZazMMgmEUVO0AjPVcVM3S5l/WIvhhwjLpwBAD4+a1GSSdIP2jCjdk+hDKTe+uOlKheyNKmiGuobVzgRpJ0FRNhsssyQL4anX0wUJO8OewrzQe5XK9J0XZfSoJjbeBJ3t6ITYmuChpq4KT1jbCwsp1vTPBpahCn+Uo6z7bi50qgHTQuifoGusm2npsvM2A9smiooxWpncv78Ssr8UmSn5MaNxIbswK/FTcpOEt6anMndtsAIaslwq6saMk8v4k9/qDJHkpqchvtGirIPUkDfSOa6MefUj1fimEJWw0bzORb0j82hyhgxW8nxZQWL/H3lVeScLyBdtuU/EV7Whjs+kIGeZ0HncbHA0Fwn8nMMIubnFoTTOLtrfX1jhJlwQN0vnvxTVcUtOOPG6VQiXOdDXJ9wAY3Py/LpE1hTvjugBhQ6v62x01jR380ZFitgdWJ1SzBckLEilqLIcRRm3TMTtrRWWNnLhr46CPeev7hVm4eff3NL5BMudhIo9gqAo+A641t34ljRnKoqTHNdRG/6e/Lcu8CSnHEUvUExzMvM4JrXQ1qhj8JhIYkRXNZJFQz8g
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6464.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 633d0f59-e672-4d2a-ff11-08dc9c9448b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 01:46:26.8342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1bdY6KXWhfyKkhoCdlU4CHmkKhSYwBUJkMRdorzCdji1Bstdin8pIGOgy8lXtN0HHFVcks9QIvobDCIDAksGYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10905
Received-SPF: pass client-ip=68.232.156.96;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa13.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

UmV2aWV3ZWQtYnk6IFhpbmd0YW8gWWFvIDx5YW94dC5mbnN0QGZ1aml0c3UuY29tPg0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IHFlbXUtZGV2ZWwtYm91bmNlcyt5YW94
dC5mbnN0PWZ1aml0c3UuY29tQG5vbmdudS5vcmcNCj4gPHFlbXUtZGV2ZWwtYm91bmNlcyt5YW94
dC5mbnN0PWZ1aml0c3UuY29tQG5vbmdudS5vcmc+IE9uIEJlaGFsZiBPZg0KPiBQaWVycmljayBC
b3V2aWVyDQo+IFNlbnQ6IEZyaWRheSwgSnVseSA1LCAyMDI0IDg6MzQgQU0NCj4gVG86IHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogQWxleGFuZHJlIElvb3NzIDxlcmRuYXhlQGNyYW5zLm9y
Zz47IFJpY2hhcmQgSGVuZGVyc29uDQo+IDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPjsg
TWFyY2VsIEFwZmVsYmF1bQ0KPiA8bWFyY2VsLmFwZmVsYmF1bUBnbWFpbC5jb20+OyBQaWVycmlj
ayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+Ow0KPiBBbGV4IEJlbm7DqWUg
PGFsZXguYmVubmVlQGxpbmFyby5vcmc+OyBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQu
Y29tPjsNCj4gWWFuYW4gV2FuZyA8d2FuZ3lhbmFuNTVAaHVhd2VpLmNvbT47IE1haG1vdWQgTWFu
ZG91cg0KPiA8bWEubWFuZG91cnJAZ21haWwuY29tPjsgRWR1YXJkbyBIYWJrb3N0IDxlZHVhcmRv
QGhhYmtvc3QubmV0PjsgUGhpbGlwcGUNCj4gTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8u
b3JnPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjUgNi83XSB0ZXN0cy9wbHVnaW4vbWVtOiBhZGQgb3B0
aW9uIHRvIHByaW50IG1lbW9yeSBhY2Nlc3Nlcw0KPiANCj4gQnkgdXNpbmcgInByaW50LWFjY2Vz
c2VzPXRydWUiIG9wdGlvbiwgbWVtIHBsdWdpbiB3aWxsIG5vdyBwcmludCBldmVyeQ0KPiB2YWx1
ZSBhY2Nlc3NlZCwgd2l0aCBhc3NvY2lhdGVkIHNpemUsIHR5cGUgKHN0b3JlIHZzIGxvYWQpLCBz
eW1ib2wsDQo+IGluc3RydWN0aW9uIGFkZHJlc3MgYW5kIHBoeXMvdmlydCBhZGRyZXNzIGFjY2Vz
c2VkLg0KPiANCj4gUmV2aWV3ZWQtYnk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRl
cnNvbkBsaW5hcm8ub3JnPg0KPiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVy
cmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgdGVzdHMvcGx1Z2luL21lbS5jIHwg
NjkNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDY4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS90ZXN0cy9wbHVnaW4vbWVtLmMgYi90ZXN0cy9wbHVnaW4vbWVtLmMNCj4gaW5k
ZXggYjY1MGRkZGNjZTEuLjA4NmU2ZjViZGZjIDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9wbHVnaW4v
bWVtLmMNCj4gKysrIGIvdGVzdHMvcGx1Z2luL21lbS5jDQo+IEBAIC0yMSwxMCArMjEsMTUgQEAg
dHlwZWRlZiBzdHJ1Y3Qgew0KPiAgICAgIHVpbnQ2NF90IGlvX2NvdW50Ow0KPiAgfSBDUFVDb3Vu
dDsNCj4gDQo+ICt0eXBlZGVmIHN0cnVjdCB7DQo+ICsgICAgdWludDY0X3QgdmFkZHI7DQo+ICsg
ICAgY29uc3QgY2hhciAqc3ltOw0KPiArfSBJbnNuSW5mbzsNCj4gKw0KPiAgc3RhdGljIHN0cnVj
dCBxZW11X3BsdWdpbl9zY29yZWJvYXJkICpjb3VudHM7DQo+ICBzdGF0aWMgcWVtdV9wbHVnaW5f
dTY0IG1lbV9jb3VudDsNCj4gIHN0YXRpYyBxZW11X3BsdWdpbl91NjQgaW9fY291bnQ7DQo+IC1z
dGF0aWMgYm9vbCBkb19pbmxpbmUsIGRvX2NhbGxiYWNrOw0KPiArc3RhdGljIGJvb2wgZG9faW5s
aW5lLCBkb19jYWxsYmFjaywgZG9fcHJpbnRfYWNjZXNzZXM7DQo+ICBzdGF0aWMgYm9vbCBkb19o
YWRkcjsNCj4gIHN0YXRpYyBlbnVtIHFlbXVfcGx1Z2luX21lbV9ydyBydyA9IFFFTVVfUExVR0lO
X01FTV9SVzsNCj4gDQo+IEBAIC02MCw2ICs2NSw0NCBAQCBzdGF0aWMgdm9pZCB2Y3B1X21lbSh1
bnNpZ25lZCBpbnQgY3B1X2luZGV4LA0KPiBxZW11X3BsdWdpbl9tZW1pbmZvX3QgbWVtaW5mbywN
Cj4gICAgICB9DQo+ICB9DQo+IA0KPiArc3RhdGljIHZvaWQgcHJpbnRfYWNjZXNzKHVuc2lnbmVk
IGludCBjcHVfaW5kZXgsIHFlbXVfcGx1Z2luX21lbWluZm9fdA0KPiBtZW1pbmZvLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IHZhZGRyLCB2b2lkICp1ZGF0YSkNCj4gK3sN
Cj4gKyAgICBJbnNuSW5mbyAqaW5zbl9pbmZvID0gdWRhdGE7DQo+ICsgICAgdW5zaWduZWQgc2l6
ZSA9IDggPDwgcWVtdV9wbHVnaW5fbWVtX3NpemVfc2hpZnQobWVtaW5mbyk7DQo+ICsgICAgY29u
c3QgY2hhciAqdHlwZSA9IHFlbXVfcGx1Z2luX21lbV9pc19zdG9yZShtZW1pbmZvKSA/ICJzdG9y
ZSIgOiAibG9hZCI7DQo+ICsgICAgcWVtdV9wbHVnaW5fbWVtX3ZhbHVlIHZhbHVlID0gcWVtdV9w
bHVnaW5fbWVtX2dldF92YWx1ZShtZW1pbmZvKTsNCj4gKyAgICB1aW50NjRfdCBod2FkZHIgPQ0K
PiArICAgICAgICBxZW11X3BsdWdpbl9od2FkZHJfcGh5c19hZGRyKHFlbXVfcGx1Z2luX2dldF9o
d2FkZHIobWVtaW5mbywNCj4gdmFkZHIpKTsNCj4gKyAgICBnX2F1dG9wdHIoR1N0cmluZykgb3V0
ID0gZ19zdHJpbmdfbmV3KCIiKTsNCj4gKyAgICBnX3N0cmluZ19wcmludGYob3V0LA0KPiArICAg
ICAgICAgICAgICAgICAgICAiMHglIlBSSXg2NCIsJXMsMHglIlBSSXg2NCIsMHglIlBSSXg2NCIs
JWQsJXMsIiwNCj4gKyAgICAgICAgICAgICAgICAgICAgaW5zbl9pbmZvLT52YWRkciwgaW5zbl9p
bmZvLT5zeW0sDQo+ICsgICAgICAgICAgICAgICAgICAgIHZhZGRyLCBod2FkZHIsIHNpemUsIHR5
cGUpOw0KPiArICAgIHN3aXRjaCAodmFsdWUudHlwZSkgew0KPiArICAgIGNhc2UgUUVNVV9QTFVH
SU5fTUVNX1ZBTFVFX1U4Og0KPiArICAgICAgICBnX3N0cmluZ19hcHBlbmRfcHJpbnRmKG91dCwg
IjB4JTAyIlBSSXg4LCB2YWx1ZS5kYXRhLnU4KTsNCj4gKyAgICAgICAgYnJlYWs7DQo+ICsgICAg
Y2FzZSBRRU1VX1BMVUdJTl9NRU1fVkFMVUVfVTE2Og0KPiArICAgICAgICBnX3N0cmluZ19hcHBl
bmRfcHJpbnRmKG91dCwgIjB4JTA0IlBSSXgxNiwgdmFsdWUuZGF0YS51MTYpOw0KPiArICAgICAg
ICBicmVhazsNCj4gKyAgICBjYXNlIFFFTVVfUExVR0lOX01FTV9WQUxVRV9VMzI6DQo+ICsgICAg
ICAgIGdfc3RyaW5nX2FwcGVuZF9wcmludGYob3V0LCAiMHglMDgiUFJJeDMyLCB2YWx1ZS5kYXRh
LnUzMik7DQo+ICsgICAgICAgIGJyZWFrOw0KPiArICAgIGNhc2UgUUVNVV9QTFVHSU5fTUVNX1ZB
TFVFX1U2NDoNCj4gKyAgICAgICAgZ19zdHJpbmdfYXBwZW5kX3ByaW50ZihvdXQsICIweCUwMTYi
UFJJeDY0LCB2YWx1ZS5kYXRhLnU2NCk7DQo+ICsgICAgICAgIGJyZWFrOw0KPiArICAgIGNhc2Ug
UUVNVV9QTFVHSU5fTUVNX1ZBTFVFX1UxMjg6DQo+ICsgICAgICAgIGdfc3RyaW5nX2FwcGVuZF9w
cmludGYob3V0LCAiMHglMDE2IlBSSXg2NCIlMDE2IlBSSXg2NCwNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB2YWx1ZS5kYXRhLnUxMjguaGlnaCwgdmFsdWUuZGF0YS51MTI4Lmxv
dyk7DQo+ICsgICAgICAgIGJyZWFrOw0KPiArICAgIGRlZmF1bHQ6DQo+ICsgICAgICAgIGdfYXNz
ZXJ0X25vdF9yZWFjaGVkKCk7DQo+ICsgICAgfQ0KPiArICAgIGdfc3RyaW5nX2FwcGVuZF9wcmlu
dGYob3V0LCAiXG4iKTsNCj4gKyAgICBxZW11X3BsdWdpbl9vdXRzKG91dC0+c3RyKTsNCj4gK30N
Cj4gKw0KPiAgc3RhdGljIHZvaWQgdmNwdV90Yl90cmFucyhxZW11X3BsdWdpbl9pZF90IGlkLCBz
dHJ1Y3QgcWVtdV9wbHVnaW5fdGIgKnRiKQ0KPiAgew0KPiAgICAgIHNpemVfdCBuID0gcWVtdV9w
bHVnaW5fdGJfbl9pbnNucyh0Yik7DQo+IEBAIC03OSw2ICsxMjIsMTYgQEAgc3RhdGljIHZvaWQg
dmNwdV90Yl90cmFucyhxZW11X3BsdWdpbl9pZF90IGlkLCBzdHJ1Y3QNCj4gcWVtdV9wbHVnaW5f
dGIgKnRiKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
UUVNVV9QTFVHSU5fQ0JfTk9fUkVHUywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHJ3LCBOVUxMKTsNCj4gICAgICAgICAgfQ0KPiArICAgICAgICBpZiAo
ZG9fcHJpbnRfYWNjZXNzZXMpIHsNCj4gKyAgICAgICAgICAgIC8qIHdlIGxlYWsgdGhpcyBwb2lu
dGVyLCB0byBhdm9pZCBsb2NraW5nIHRvIGtlZXAgdHJhY2sgb2YgaXQgKi8NCj4gKyAgICAgICAg
ICAgIEluc25JbmZvICppbnNuX2luZm8gPSBnX21hbGxvYyhzaXplb2YoSW5zbkluZm8pKTsNCj4g
KyAgICAgICAgICAgIGNvbnN0IGNoYXIgKnN5bSA9IHFlbXVfcGx1Z2luX2luc25fc3ltYm9sKGlu
c24pOw0KPiArICAgICAgICAgICAgaW5zbl9pbmZvLT5zeW0gPSBzeW0gPyBzeW0gOiAiIjsNCj4g
KyAgICAgICAgICAgIGluc25faW5mby0+dmFkZHIgPSBxZW11X3BsdWdpbl9pbnNuX3ZhZGRyKGlu
c24pOw0KPiArICAgICAgICAgICAgcWVtdV9wbHVnaW5fcmVnaXN0ZXJfdmNwdV9tZW1fY2IoaW5z
biwgcHJpbnRfYWNjZXNzLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgUUVNVV9QTFVHSU5fQ0JfTk9fUkVHUywNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHJ3LCAodm9pZCAqKSBpbnNuX2luZm8pOw0KPiArICAg
ICAgICB9DQo+ICAgICAgfQ0KPiAgfQ0KPiANCj4gQEAgLTExNyw2ICsxNzAsMTIgQEAgUUVNVV9Q
TFVHSU5fRVhQT1JUIGludA0KPiBxZW11X3BsdWdpbl9pbnN0YWxsKHFlbXVfcGx1Z2luX2lkX3Qg
aWQsDQo+ICAgICAgICAgICAgICAgICAgZnByaW50ZihzdGRlcnIsICJib29sZWFuIGFyZ3VtZW50
IHBhcnNpbmcgZmFpbGVkOiAlc1xuIiwgb3B0KTsNCj4gICAgICAgICAgICAgICAgICByZXR1cm4g
LTE7DQo+ICAgICAgICAgICAgICB9DQo+ICsgICAgICAgIH0gZWxzZSBpZiAoZ19zdHJjbXAwKHRv
a2Vuc1swXSwgInByaW50LWFjY2Vzc2VzIikgPT0gMCkgew0KPiArICAgICAgICAgICAgaWYgKCFx
ZW11X3BsdWdpbl9ib29sX3BhcnNlKHRva2Vuc1swXSwgdG9rZW5zWzFdLA0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZkb19wcmludF9hY2Nlc3NlcykpIHsNCj4g
KyAgICAgICAgICAgICAgICBmcHJpbnRmKHN0ZGVyciwgImJvb2xlYW4gYXJndW1lbnQgcGFyc2lu
ZyBmYWlsZWQ6ICVzXG4iLCBvcHQpOw0KPiArICAgICAgICAgICAgICAgIHJldHVybiAtMTsNCj4g
KyAgICAgICAgICAgIH0NCj4gICAgICAgICAgfSBlbHNlIHsNCj4gICAgICAgICAgICAgIGZwcmlu
dGYoc3RkZXJyLCAib3B0aW9uIHBhcnNpbmcgZmFpbGVkOiAlc1xuIiwgb3B0KTsNCj4gICAgICAg
ICAgICAgIHJldHVybiAtMTsNCj4gQEAgLTEyOSw2ICsxODgsMTQgQEAgUUVNVV9QTFVHSU5fRVhQ
T1JUIGludA0KPiBxZW11X3BsdWdpbl9pbnN0YWxsKHFlbXVfcGx1Z2luX2lkX3QgaWQsDQo+ICAg
ICAgICAgIHJldHVybiAtMTsNCj4gICAgICB9DQo+IA0KPiArICAgIGlmIChkb19wcmludF9hY2Nl
c3Nlcykgew0KPiArICAgICAgICBnX2F1dG9wdHIoR1N0cmluZykgb3V0ID0gZ19zdHJpbmdfbmV3
KCIiKTsNCj4gKyAgICAgICAgZ19zdHJpbmdfcHJpbnRmKG91dCwNCj4gKyAgICAgICAgICAgICAg
ICAiaW5zbl92YWRkcixpbnNuX3N5bWJvbCxtZW1fdmFkZHIsbWVtX2h3YWRkciwiDQo+ICsgICAg
ICAgICAgICAgICAgImFjY2Vzc19zaXplLGFjY2Vzc190eXBlLG1lbV92YWx1ZVxuIik7DQo+ICsg
ICAgICAgIHFlbXVfcGx1Z2luX291dHMob3V0LT5zdHIpOw0KPiArICAgIH0NCj4gKw0KPiAgICAg
IGNvdW50cyA9IHFlbXVfcGx1Z2luX3Njb3JlYm9hcmRfbmV3KHNpemVvZihDUFVDb3VudCkpOw0K
PiAgICAgIG1lbV9jb3VudCA9IHFlbXVfcGx1Z2luX3Njb3JlYm9hcmRfdTY0X2luX3N0cnVjdCgN
Cj4gICAgICAgICAgY291bnRzLCBDUFVDb3VudCwgbWVtX2NvdW50KTsNCj4gLS0NCj4gMi4zOS4y
DQo+IA0KDQo=

