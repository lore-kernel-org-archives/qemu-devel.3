Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554E8C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 09:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA44s-0003ei-R5; Wed, 30 Apr 2025 05:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uA44k-0003dx-VG
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 05:49:59 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uA44g-0005Gt-Qm
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 05:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1746006594; x=1777542594;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=K4+FNIpDuk5J9vLuKRAp5QIXqMNXBoOM6SBE/eawmtY=;
 b=Q5xHB7/j/QpVGnDSwhG++CbSQWm0ATgP0Esf/gJH20X662VYYnibWcZu
 yMdQk3snZOFqTozHAO8bA70zhrOZuXmnOodWQPCd4XIhvn6qM7m/+DKmk
 zPSMR7gPCpXBR8D1+SJmK/LBM02KHGYtXK4cCZznCTdRO2lnXneKsIB/P
 190a/0lFbF1d/SyT1oAvquM2WTHVP1qjR95OsyYyXcdN9IX6+jcTJ7+Tw
 KCQyNHB7KbgSP+2lxudtmjPWTlZU92FLCeHDUnd9Ixs/kVS7cKZPcp56J
 MMmVoPkYfQYJKvJI22Ym4UmMrGhiOJsCWmm6B9cu4llktAMtVTjFCop/s A==;
X-CSE-ConnectionGUID: 159tppf4R3OJsDCKc9nmhA==
X-CSE-MsgGUID: keaO4M7aReeEFtB2tADWIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="154310041"
X-IronPort-AV: E=Sophos;i="6.15,251,1739804400"; d="scan'208";a="154310041"
Received: from mail-japaneastazlp17011026.outbound.protection.outlook.com
 (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.26])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2025 18:49:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HD8IRcn1BDtenyxn3jpgiOwI5ExOV6yE8YPp0IKZwLvffBsW5h6CHSoLdmSvO0ntt/THDfWVU7wZMu3AHwcJtY6+J+zwemEZmQGH/ORTvOHyhHn560YEus3hyWF+r9gS+o+Ss2Dgg1YbBWkRkqlrz3Wkfgz9ezhRt930AzLY5NOEJMVK7JnYzU/pKQiCGH2cYO0gJ6JvByVmT75cj9h5UIdnYU0W0txqMKhI5as14c8Ao8QeFHvYqgC3xuuZA27IYKDlCSsFopvfWrF4gAWb+1ufDLQLbK1kA6LPZ231qtnT8q8ljB87lT8qde/yCD4QT/9fmpTKz+3hXUAH39lcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4+FNIpDuk5J9vLuKRAp5QIXqMNXBoOM6SBE/eawmtY=;
 b=AV4WFYbd3uMkLgniKs6LZ//2clrUsw847+CgpyBkh5cAFXsw/a7wg7c/mw8D+czwWnSuRuxIG1hyUVL1SGgY7RwUDFHb3gj/q+eqbIOhXpIqKsTkCYxbQUk73WtGgxWd8ygSl0gx1HQsF2XS88dWikmn9OME9amR6SlWfPYiKumyeRoefKbtUJ/D/w06AJ4N9JgwLM57nRuDXaPo5JI5ui351kgzzS+Dw1t9P+M/vMpSUlmgfvtWzN03bM5Rg5O1YNKABiWJQL1MqR9zMgifeSvqsdIll+Frn6BpsViDY4sY9gk45fpZJ/Lo4/NkuL8BNOwyoJPJe0EvO6cLvJLS4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYCPR01MB6685.jpnprd01.prod.outlook.com (2603:1096:400:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 30 Apr
 2025 09:49:42 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8678.027; Wed, 30 Apr 2025
 09:49:41 +0000
To: Peter Xu <peterx@redhat.com>
CC: Fabiano Rosas <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Jack Wang <jinpu.wang@ionos.com>, "Michael R . Galaxy"
 <mrgalaxy@nvidia.com>, Yu Zhang <yu.zhang@ionos.com>
Subject: Re: [PATCH] qtest/migration/rdma: Add test for rdma migration with
 ipv6
Thread-Topic: [PATCH] qtest/migration/rdma: Add test for rdma migration with
 ipv6
Thread-Index: AQHbnr3GPFM2rsTaa0SkDCwflcGbZrO7WJ6AgAC9noCAAAWmAIAAEQCA
Date: Wed, 30 Apr 2025 09:49:40 +0000
Message-ID: <396fcfe6-7ddb-41e7-ae28-e5210dea7dd7@fujitsu.com>
References: <20250327021234.264161-1-lizhijian@fujitsu.com>
 <aBFAIflmJns_nVIm@x1.local>
 <78c811ed-d6a2-4811-9ac8-48c5c93a2fed@fujitsu.com>
 <6aaafc7c-9876-45da-8cca-5b670b8ccc50@fujitsu.com>
In-Reply-To: <6aaafc7c-9876-45da-8cca-5b670b8ccc50@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYCPR01MB6685:EE_
x-ms-office365-filtering-correlation-id: c853fed7-30d0-4b14-2ac4-08dd87cc53ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?aWFpRkFscHFlUDNSNGg0Ym4wc1BLRm11a2ExazJqTitYZjN2MjlVSStNK1ZT?=
 =?utf-8?B?N2sxUStFcUlpdlNTRTZBNzJuVmRkVTNpeGNPd0U3bTk3TzRxcTA4YVVnaWMw?=
 =?utf-8?B?eHY2VkkxTGJHNm1zYU9JajVaUHk0VzFQa0orNXQ2VFhSUFNjcC9neVBlRjhk?=
 =?utf-8?B?UGNSZWphR0xQVkRSbmt4SDRIWCtuUklqS0JZeW1JUG5Md3pBMTZ6YlV1d2Ft?=
 =?utf-8?B?V1RNQys2ZWpjRzZpMmhvQzV4dHdOY0ZwMmFobkhCQXFxaC94c2MwcHVVS1lv?=
 =?utf-8?B?UzUxL1lXQm5oSmFqekdoNjhZTitxYU9zTXBLdDNURGVPTDVFV29yd3VlT1BM?=
 =?utf-8?B?NDQ2QVhnOVBwL2xkSHRUYXcvRGdaUldoU3pRVnVQSzd2NCswZjNBMUFLMmlC?=
 =?utf-8?B?SXU0cXFEeHd1dEZTNVZFTVhTRTZ5L1JnYSt4YmsyaitUcm1CcXNoSjc2ZzJ6?=
 =?utf-8?B?cXRNU1ZwaGZNdnNaUVFUczd4cGJFVmVYR3ZmR3R3UHR5N0E4a2prOTk5VzRQ?=
 =?utf-8?B?N2o0QUUwUDhrRHNOWkk0bU1WZkUyeDZ4K0w3S2pKOEhpWk1qa3hRRm44MTJI?=
 =?utf-8?B?UjFhazhNVCtIQkJkeXBQSXNxWXAyamt0V0pyTXdEUE4zR25kTklkWGUwMDU3?=
 =?utf-8?B?TTF6NThMQ3VjWk5CTjg0cVF5TmpzSVdJcFJDQ2prbVF2YjJDc3NodDVMWjd5?=
 =?utf-8?B?Tml0R3dZd0Z0ODR5aXpKTHdEajNKOFYyOGRwTzBKOHB2OUgvV1R6VWdyaDRF?=
 =?utf-8?B?RlA5VUlPb3NDamw4R25hUGJreWgrSkY4R3lmMkVPYk94cUsxMVBxYllmRlRw?=
 =?utf-8?B?V1ZSRVlybVpSNVFPZDByYVJydEpQR1N4R0x1akdVYjluM3V5b28wTFBQcUp4?=
 =?utf-8?B?UHVnSEZLNDlndC9rN3JNTnF0cnJhc3puVU5UaGdHcGsreDFXM2lIb1BlVTZj?=
 =?utf-8?B?NjFMaHQxSWwrdGMwRnVKZzRna1FsdWJoTW52OHRCZjltWFBlbFJKNTZ1Zmtu?=
 =?utf-8?B?VHlaOWNqaklKN2V1RzhvZHhvR0ZrTllYbmRMZEdKa2xQaVN0OEwvSkMxY1ND?=
 =?utf-8?B?UVdmblJBY1loQ1hxZEJpWmovU2hvQVBrRVBmZXJpTzNhVkhVdWl6WWRYZzF2?=
 =?utf-8?B?NU1BK1gwNnRHSmFXN3hiS0ZNbjl1UXdCMzFUcWF6UDZ4MXZqQi8xRHd3SzBu?=
 =?utf-8?B?WTNMVTg3ZVl0UHFOZG05K3R2UEc2RWVUcEpzellEbTNPeWtqK2lQU1MzY1NX?=
 =?utf-8?B?UDhrSUlGQTFzVklaVjJNL01rWmNUa3JuU2toNjhLQjNVSXMzZDk4My9yQ1V2?=
 =?utf-8?B?Q2ZiVmxIL2xwTDVqUkdXNzYxTUp5LzBrTVhsemd6cGVLQlU2RnlBZW5LMFMv?=
 =?utf-8?B?V3RleE9GWDVMTGZEL3JqSmVKb2U2K0FrVkc2OThRajVWakNrTUUxb1JCRG9O?=
 =?utf-8?B?cFRvam9qNnBqWHZkVU1NbFAvOW4xQXBxM2dwaElRK2FFRzV0bStJRzFkY3Vh?=
 =?utf-8?B?MmRUb1NXU1Jla1IyaUNVWmF3c2w3Q2J1U0d3eFVKMVBjbWloOWE1YXlKc0J0?=
 =?utf-8?B?b096RTdRSTJvenpkZktYZjRERUttUHV4VHpnazRtOFl2bG84Z1I1Q2xsOU5U?=
 =?utf-8?B?M1YwcnlLaldFbkw3Rjdjc2U3MjBCWjZaTVp3QVo3VTFzbklCQXIrLzlDUmtr?=
 =?utf-8?B?Y0VwSThSeExjWlFyY3o3a3JpSXJ4eW5ycStNeG5oMDVldW5QeDR3Ylo0NFZx?=
 =?utf-8?B?S0hZTmdZTDdKZjBDK1BOWGNaN3NHb25lb2F0MmFiTy9iZnViZG1uUzZyN2xX?=
 =?utf-8?B?UlFFd1pFS0R6RFFGVkpXM3Q4R0k4NjZFeHg3NlB6OVNWMXJqY3lFcGlqUVY0?=
 =?utf-8?B?LzJ6cStOaTVJaFBkZTJObEFxY01WSjlXVDBIZEVieW5DSkFzbTNuV09obmJO?=
 =?utf-8?B?YldyQ1M0YkRTeEU0WlRsUFdLZURybFVXRTN0eE9MbUJEOHFYTVI4ZGJDMGdq?=
 =?utf-8?B?YU9sNmlyS0xiZzZIUWdYUGcwYytRTmZMV203UHo4cXIxWTJwL0p6bVhFb2tm?=
 =?utf-8?Q?XcPSkC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEpSRXZIVmJpODlBQzBDWGFqaXMyb3FpMERwbTJZdFdwN1lKVUN4ZDdmclNr?=
 =?utf-8?B?RWc3NTFleTZNakFWTnJEWjVzcGg1KzlzNC9mSUY2dmFyZ2dabXhzTFlmTXln?=
 =?utf-8?B?b3VJV0xBb2ZiYytIMVlXMUNUOTNsNFRDNGJVckc5amR6bHp5bFFMY3R0aXlH?=
 =?utf-8?B?Ymdsay9HZ2dpRGR4OVo3YlE5MXlGMVAvSGdMY0tHcTNVN0lURVJzZ2tiWWZU?=
 =?utf-8?B?N3Rxc0FTZ2xBNDhBbFdtMk9JUjFWWmRldHFYRCsxRnBycGxNMkdPN3pnbUl6?=
 =?utf-8?B?YlR4dkloQ25Pd2k4Y2dNTDIxWjRTVnVtSmJNWXBLM2RQb3dwejBJdlF5TFNn?=
 =?utf-8?B?MEsxS0d4NktjTzYvMGVBRm50eE82b0hYOVBJYzZKTnNzd2ZBVVFKbEg0T25j?=
 =?utf-8?B?aW5sSnM4V3ZueTVsbHBPVVUyUFovMUxpaDBReG9ybmtYcnBSZmg5ZTFGNWI5?=
 =?utf-8?B?ZUJyb1hKMWhWWGFRQ3V2bXBiN3VmUWFkbWdZWXkyVGt6UnZQVVJzZTVhMEt4?=
 =?utf-8?B?MXVmNzNaMXBFMTByUzU5ZWNvRXpDUVJ6THF3K2Fmd1c5U0hLRXg0bTVOOXNE?=
 =?utf-8?B?Rjh5cFVreFVwZHFBTmxTSmJkcUI4TEl0UURjYnV4cjRRUlZvL1pLbHBKN2VF?=
 =?utf-8?B?MEViZzBnY0d0dE42MFIvaTBYcjlCN0FXRm42TUhtS1Q2WFZ3ZWU4VkptMmc5?=
 =?utf-8?B?N1BsYk1RS0h3YmhUU2k4cnpWYUlCY1lYZFpudU0vRmFaVk5VN2dSSWk2R0Ny?=
 =?utf-8?B?aTk4UXA0NEtITHZsLzBhWlhMZENPOEFsVFZ2VXIrc1g1cnVZVmxVRUNTdnQ4?=
 =?utf-8?B?YXBKaDZhMzlsTW4xRDlhZDZoRFFsVmZra29mSlM1bUs0VExBRzBuVGwrVUZk?=
 =?utf-8?B?cGZpb2RpclgvdlNDMmdFeWQ5MWZ2bzh3dUlnUERnczUxVXphaUMzdHhlOVJO?=
 =?utf-8?B?elJ5ZExURHhSRi94UGJ4T091eU15TEJ4ZjRrU0hQTWRSZTBqY2lUYXg0OXc2?=
 =?utf-8?B?ZDBsREI4MVNGTzliRFdIcnpuRVBueFNyY0UrTmRzSnNqdGsyZWhWT0RZdDVm?=
 =?utf-8?B?MlVzWGt0clNJOG0yMlA1TnZjQmNIUml0N05WNkF2Qys5eGNxaS8yZlgrRXlK?=
 =?utf-8?B?T00wTlIrd2FPMmNkbHF0eVlJTkhFUWpvUGRyeStlNWNpamhQR0hyQzl1TUFP?=
 =?utf-8?B?TUJiQVlvVUVzSU1kZjlUSThPdHo5ZFFHWU00Z29iVkhuQzhBU201dXVMSlRu?=
 =?utf-8?B?d2lGTlVqalpEb1p6V3I5NnBmbHNpNHBqaklWOUtUV0NzT0c5V1hEMWEyMHRq?=
 =?utf-8?B?Uk5Za0VRdjVZNFhxZktDZ3BNYllRUUJER0FReWtvUVNibUVXa2xGNmtBS3JE?=
 =?utf-8?B?ems2RFNxTjJnREJWWjBNOHQrV1RtQjlSMEQ2RUI0ekwyUGM4WHYrUU5lUXdl?=
 =?utf-8?B?RS9pMDNKdTU1eVVhSjhpdTdINithNEl5bm4ybFFweThwenJUcmQ2Sk05NWdw?=
 =?utf-8?B?R2JYeEVsZlBZb2xsOVNUdmxQVjl4ekVQcnh5a2hZSFBxQTEyUC9zMXczS3hq?=
 =?utf-8?B?MGVucEpLUVd6ZUxvSXNmcDMrVjI0MDhaS1VaVnBGRXZUdjg4djJ2cUZHS0sz?=
 =?utf-8?B?bWpOSVBmL0FWaFc3aGxqK0ducnJEcldEYzRsTnd1dmZNZ0FZc0EzdFJyd3FP?=
 =?utf-8?B?M2dIRjdDdzQ0TTMyaENWVG10WVQ0TmxNUTZKcGx4aG82ZExRQWl2S05xcmVY?=
 =?utf-8?B?NWlpenV3VFJiVXlnbGt4QkpTM1I1bVJBa1BvOHp0eklOaVBJZjJwU1BOcWVE?=
 =?utf-8?B?OURJQXlGSmF6djlPRndObUo5S0VQWDRnbUFyejFmK1ljRE95eWRwYjVMM2ZH?=
 =?utf-8?B?OWY0K2ZDYjFNSjc0L3VEcllYWHZNYTJSTnB4MzNpWUpxTGJhZkNHcVdjSktr?=
 =?utf-8?B?dXpFekhhWUwzSG5ZaGhFZ1RVVll2bW4rZ2NPN3p3bDgxQjhNZURGOTBFdkds?=
 =?utf-8?B?RGhyWVJqdktpMjNYT29Mck1IVThhb0JQMmFXS3E1aSsvWFMrQ1I2UjRLTkhh?=
 =?utf-8?B?a25DYUhJYVBMQlpEVFV0bmlveUtHVVJvc3ZBeThaWjhxUjMxYjJ5STZtQUtV?=
 =?utf-8?B?c2JOWitJUHZlZFEyZVhZYVpGYUZtSzFFaHM5Ry9yRWtzTVBsMytZaEltUnlC?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F70466BD6530AC4EACDA7B0A17AA7A21@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +aa5a2fPU6zAXRMGOEOUM1cyIfQuHD6yp6Z3I/MC4jovXpVc3PRpY7JH6gUoQatGIxe8q/HuEENKP5O4dHsq2Hmi7Zq3tCJH0iziwBtJe8aeRG/Dv1671mqPCS+ThFtnrAU1h2VTPYdBjBzZLrL9vc3gzsCBjRm1qwTqUeAh//qX2YPPb/dEN2Se8TeIoinyiN2j4oYIFSCZW78vYnufm4+0PJnfLxHP4hwpcT4oSRnkh6OOZwWkm5kxn6x/ttQ0kiRSjtcV83q0AWIQfbwgl44wivAI2EK77jfFRYN702xYX4FVDHCFK3KW0bI1vR1rWr12cIdtlOpJ7242EpXPeaOMLfY9XSTVP+SJJPW+whRQMPKBpRinaqyyH08/+hom0WljEE/YcVu947Q8ixe8b6o2t/dagQrCO2YnwaGKLgyXX7UGugj3VbvPj8Pjj/67m/hBZogumiuoxZ+jybSt01PuM04ekWBFJhxE6JsENKQcjD65vmQxriYFCxne+tvus8CrwZdfiv9ZA0nKqiMVwFD/imI/miRPPh2mHSDqqKEgOXIc3mERdBobWT2wAyX4zXWXRIpXV74H/S3GAUOo68Pgw0PZ3URLFN3MIomZrsv5wnPbQ9bcfGJ+eICNuzhn
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c853fed7-30d0-4b14-2ac4-08dd87cc53ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 09:49:40.8164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ti5YpDVV3MxQJo+w4wf8LioliSkfo7LITIDfpoY9MKEFVTDjfkwkC9V9kiPzyfuxahzFDGSKbGJ08qQJnR9pMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6685
Received-SPF: pass client-ip=68.232.159.88; envelope-from=lizhijian@fujitsu.com;
 helo=esa8.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDMwLzA0LzIwMjUgMTY6NDgsIFpoaWppYW4gTGkgKEZ1aml0c3UpIHZpYSB3cm90ZToN
Cj4+PiBzdGRlcnI6DQo+Pj4gcWVtdS1zeXN0ZW0teDg2XzY0OiBjYW5ub3QgZ2V0IHJrZXkNCj4+
PiBxZW11LXN5c3RlbS14ODZfNjQ6IGVycm9yIHdoaWxlIGxvYWRpbmcgc3RhdGUgc2VjdGlvbiBp
ZCAyKHJhbSkNCj4+PiBxZW11LXN5c3RlbS14ODZfNjQ6IGxvYWQgb2YgbWlncmF0aW9uIGZhaWxl
ZDogT3BlcmF0aW9uIG5vdCBwZXJtaXR0ZWQNCj4+PiBxZW11LXN5c3RlbS14ODZfNjQ6IHJkbWEg
bWlncmF0aW9uOiByZWN2IHBvbGxpbmcgY29udHJvbCBlcnJvciENCj4+PiBxZW11LXN5c3RlbS14
ODZfNjQ6IFJETUEgaXMgaW4gYW4gZXJyb3Igc3RhdGUgd2FpdGluZyBtaWdyYXRpb24gdG8gYWJv
cnQhDQo+Pj4gcWVtdS1zeXN0ZW0teDg2XzY0OiBmYWlsZWQgdG8gc2F2ZSBTYXZlU3RhdGVFbnRy
eSB3aXRoIGlkKG5hbWUpOiAyKHJhbSk6IC0xDQo+Pj4gcWVtdS1zeXN0ZW0teDg2XzY0OiBDaGFu
bmVsIGVycm9yOiBPcGVyYXRpb24gbm90IHBlcm1pdHRlZA0KPj4+ICoqDQo+Pj4gRVJST1I6Li4v
dGVzdHMvcXRlc3QvbWlncmF0aW9uL21pZ3JhdGlvbi1xbXAuYzoyMDA6Y2hlY2tfbWlncmF0aW9u
X3N0YXR1czogYXNzZXJ0aW9uIGZhaWxlZCAoY3VycmVudF9zdGF0dXMgIT0gImZhaWxlZCIpOiAo
ImZhaWxlZCIgIT0gImZhaWxlZCIpDQo+Pj4gcWVtdS1zeXN0ZW0teDg2XzY0OiB3YXJuaW5nOiBF
YXJseSBlcnJvci4gU2VuZGluZyBlcnJvci4NCj4+PiBxZW11LXN5c3RlbS14ODZfNjQ6IHdhcm5p
bmc6IHJkbWEgbWlncmF0aW9uOiBzZW5kIHBvbGxpbmcgY29udHJvbCBlcnJvcg0KPj4+IC4uL3Rl
c3RzL3F0ZXN0L2xpYnF0ZXN0LmM6MTk5OiBraWxsX3FlbXUoKSB0cmllZCB0byB0ZXJtaW5hdGUg
UUVNVSBwcm9jZXNzIGJ1dCBlbmNvdW50ZXJlZCBleGl0IHN0YXR1cyAxIChleHBlY3RlZCAwKQ0K
Pj4+DQo+Pj4gU28gcnVubmluZyB0aGUgdGVzdCBhbHNvIG5lZWRzIHJvb3Q/wqAgSXMgaXQgcG9z
c2libGUgd2UgZml4IHRoZSB0ZXN0IHNvIGl0DQo+Pj4gY2FuIGFsc28gYmUgc21hcnQgZW5vdWdo
IHRvIHNraXAgaWYgaXQga25vd3MgaXQnbGwgaGl0IHRoZSAiY2Fubm90IGdldA0KPj4+IHJrZXki
IGVycm9yIChldmVuIGlmIGl0IHNlZXMgdGhlIHJkbWEgbGluayBzZXR1cCk/wqAgTm90IHNvbWV0
aGluZyB1cmdlbnQNCj4+PiBidXQgZGVmaW5pdGVseSBnb29kIHRvIGhhdmUuDQo+IEl0IHNlZW1z
IGl0J3MgYSBzZWN1cml0eSBwcm9ibGVtLCBJIGhhdmUgbm8gYSBnb29kIGlkZWEgeWV0Lg0KPiAN
Cj4gTGV0IG1lIHNlZSBzZWUuLi4NCg0KQW5vdGhlciB3b3JrYXJvdW5kIGlzIHVwZGF0ZSB0aGUg
J3VsaW1pdCAtbCcgdG8gPj0xMjhNIGZvciBhIG5vbi1yb290IHVzZXIoaW4gcHJhY3RpY2UNCnRo
aXMgdmFsdWUgd29ya3Mgd2VsbCBvbiBmZWRvcmE0MCkNCg0KU28gd2Ugd291bGQgaGF2ZSBzb21l
dGhpbmcgbGlrZSB0aGlzOg0KDQpkaWZmIC0tZ2l0IGEvdGVzdHMvcXRlc3QvbWlncmF0aW9uL3By
ZWNvcHktdGVzdHMuYyBiL3Rlc3RzL3F0ZXN0L21pZ3JhdGlvbi9wcmVjb3B5LXRlc3RzLmMNCmlu
ZGV4IDlmNzIzNmRjNTlmLi4xZjI0NzUzYzVhNSAxMDA2NDQNCi0tLSBhL3Rlc3RzL3F0ZXN0L21p
Z3JhdGlvbi9wcmVjb3B5LXRlc3RzLmMNCisrKyBiL3Rlc3RzL3F0ZXN0L21pZ3JhdGlvbi9wcmVj
b3B5LXRlc3RzLmMNCkBAIC0xMDEsNiArMTAxLDI2IEBAIHN0YXRpYyB2b2lkIHRlc3RfcHJlY29w
eV91bml4X2RpcnR5X3Jpbmcodm9pZCkNCiAgDQogICNpZmRlZiBDT05GSUdfUkRNQQ0KICANCisj
aW5jbHVkZSA8c3lzL3Jlc291cmNlLmg+DQorI2RlZmluZSBSRVFVSVJFRF9NRU1MT0NLICgxMjgg
KiAxMDI0ICogMTAyNCkgLy8gMTI4TUINCisNCitzdGF0aWMgYm9vbCBtbG9ja19jaGVjayh2b2lk
KQ0KK3sNCisgICAgdWlkX3QgdWlkOw0KKyAgICBzdHJ1Y3QgcmxpbWl0IHJsaW07DQorDQorICAg
IHVpZCA9IGdldHVpZCgpOw0KKyAgICBpZiAodWlkID09IDApIHsNCisgICAgICAgIHJldHVybiB0
cnVlOw0KKyAgICB9DQorDQorICAgIGlmIChnZXRybGltaXQoUkxJTUlUX01FTUxPQ0ssICZybGlt
KSAhPSAwKSB7DQorICAgICAgICByZXR1cm4gZmFsc2U7DQorICAgIH0NCisNCisgICAgcmV0dXJu
IHJsaW0ucmxpbV9jdXIgPj0gUkVRVUlSRURfTUVNTE9DSzsNCit9DQorDQogICNkZWZpbmUgUkRN
QV9NSUdSQVRJT05fSEVMUEVSICJzY3JpcHRzL3JkbWEtbWlncmF0aW9uLWhlbHBlci5zaCINCiAg
c3RhdGljIGludCBuZXdfcmRtYV9saW5rKGNoYXIgKmJ1ZmZlciwgYm9vbCBpcHY2KQ0KICB7DQpA
QCAtMTM3LDYgKzE1NywxMSBAQCBzdGF0aWMgdm9pZCB0ZXN0X3ByZWNvcHlfcmRtYV9wbGFpbl9p
cChib29sIGlwdjYpDQogIHsNCiAgICAgIGNoYXIgYnVmZmVyWzEyOF0gPSB7fTsNCiAgDQorICAg
IGlmICghbWxvY2tfY2hlY2soKSkgew0KKyAgICAgICAgZ190ZXN0X3NraXAoIid1bGltaXQgLWwn
IGlzIHRvbyBzbWFsbCwgcmVxdWlyZSAxMjhNIik7DQorICAgICAgICByZXR1cm47DQorICAgIH0N
CisNCiAgICAgIGlmIChuZXdfcmRtYV9saW5rKGJ1ZmZlciwgaXB2NikpIHsNCiAgICAgICAgICBn
X3Rlc3Rfc2tpcCgiTm8gcmRtYSBsaW5rIGF2YWlsYWJsZVxuIg0KICAgICAgICAgICAgICAgICAg
ICAgICIjIFRvIGVuYWJsZSB0aGUgdGVzdDpcbiI=

