Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC88C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 05:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEM2u-0001bF-0e; Mon, 12 May 2025 01:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uEM2q-0001aw-I3
 for qemu-devel@nongnu.org; Mon, 12 May 2025 01:49:45 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uEM2n-0005q1-UV
 for qemu-devel@nongnu.org; Mon, 12 May 2025 01:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1747028982; x=1778564982;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=b4go6Iqr90sOjqbqcJPVEckQHRlc7ncpeVeNDX5MKX0=;
 b=L1HDvDAh3LCFgKzOH9Ys/QGhDnZ4Q6/YqEQA3yrxMjbO4mvHeoEuKAW9
 XmS2IroYhNtkxgREmqH6FOu475XVwDU84sD+Sdw0xsPQkphflGagC+rBn
 d5ZM9C5TXcHQnqN9vtatnkDRaV59MzqpPGCNVCej7yAgK62NSQoTBG1gr
 3kyRGVeEI8DJrd0MCNeQCjx9bSp/zePBt80q0/OAXLU0moConIMrTfwLF
 a/q/cx2juxSYT9FsIMwt3LVBnTQN4OgRUMfTJi0/aAR8NfLPx6rX2op56
 r47SFWYiBKhydzDAR1o/3iJX8BoJ1xEJILHCyKwbepJJ31qrN+fSMHfdm A==;
X-CSE-ConnectionGUID: tuRHxZleSzW5SmrUlKB2SA==
X-CSE-MsgGUID: ITqnU4C8Rt+YsHFA8QDAJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="155151953"
X-IronPort-AV: E=Sophos;i="6.15,281,1739804400"; d="scan'208";a="155151953"
Received: from mail-japaneastazlp17010005.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.5])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 14:49:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4KrIsPYpO28YSPD5aYMUWHGVkVUjUoXhQ5DOOR12Oni1f2yluq2l0Mpy1t4OZqoBu5sRy9Hxf5fRhVa3U79iH2HRW61QcwFYYsz2/BQaZ0fEd1BqcHAkwxk62+qKp2gLtnvLTZp8NwHyUtdqtlN0pr1yu4/w3mO3QDUMYeGV9PfNKYCWFBk4KKYv8/R5iyBPOoCb23lczNpKg1BSbdJbZ3IORM5cxOtC7UeAvBVCTKnXpt/oW6UKSBUxDjcnjyR9RCE30WsSPgT8LHwXPnhdyu5CZkJNIGHXLkyxiT3WCG5myO3m2xRxGyAaFTz8bsD0nV9tJkZ737gB+CKPJD90A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b4go6Iqr90sOjqbqcJPVEckQHRlc7ncpeVeNDX5MKX0=;
 b=QflN/fCce0nAQhYAVbFzLPdXuN+oXSoiYpLUasdt/gDwAC9FpJDhm3ATPJuQ1igZDBM3GXIR8U9GOmk5TFBXMbB0MILvmjoXgFrv8Uzbm6cbDBFmbiXDBJT1jzG3EZ9Um3SbCUhvFdJxiu/MZkfM0Z+QcyZbrH1Ct/2kY1FtgY+NUXtBn5JKCKZJJJbBaSHc5nD5PH1oExT/oJavI4Ysza2Em6MUaBd6bTCazdA+jrRxFmibYps95nZxfFxX5/Mc2q5NiZboFsveihQBq2HE1qQ4N4iEi1GzTj/r1CIKtMIr6gVy0Gz8MKLpWVjnGUGS2aZj/E8PXEaLFWc/3gT67A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS9PR01MB15425.jpnprd01.prod.outlook.com (2603:1096:604:3c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 05:49:31 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%6]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 05:49:31 +0000
To: Peter Xu <peterx@redhat.com>
CC: Fabiano Rosas <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Jack Wang <jinpu.wang@ionos.com>, "Michael R . Galaxy"
 <mrgalaxy@nvidia.com>, Yu Zhang <yu.zhang@ionos.com>
Subject: Re: [PATCH v2 2/2] qtest/migration/rdma: Add test for rdma migration
 with ipv6
Thread-Topic: [PATCH v2 2/2] qtest/migration/rdma: Add test for rdma migration
 with ipv6
Thread-Index: AQHbwIOak4tCOfFxCkKUGyXpLJfvXLPKbjwAgAQT/YA=
Date: Mon, 12 May 2025 05:49:31 +0000
Message-ID: <2d71077b-351b-4580-ba4f-67720fb41a0c@fujitsu.com>
References: <20250509014211.1272640-1-lizhijian@fujitsu.com>
 <20250509014211.1272640-2-lizhijian@fujitsu.com> <aB4gJh8drTWmcQfy@x1.local>
In-Reply-To: <aB4gJh8drTWmcQfy@x1.local>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS9PR01MB15425:EE_
x-ms-office365-filtering-correlation-id: ae5be849-ce7e-4b36-1b6d-08dd9118c452
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Uyt2d2swSlZua0ZlT0I1MzR2dUV1azdSSFB2azAwbUlrS2h3VFdNcXlERVlU?=
 =?utf-8?B?MFgrUUVYNUQ2bFBSNXF1VWQwc0ZOZHdpaVhQQS96Z0p3YnJzYVJuSkdYKzRH?=
 =?utf-8?B?TklyY3c4YzJNMmVBSGVJeWFUVWxibGZEdExudnFURHd5dXBJRHVCNWgwaHdI?=
 =?utf-8?B?aEhHQko4V0dSaUJVS2o3T2xFNWdMK3BrcHIxdDdqL2duZ1VXMlUyRHNGeDFC?=
 =?utf-8?B?S1NmUnpCNVBnK1RkbWNRazBIMElsL3NOZmNPOEhFZ3Q5cUFZanRhbllERXZr?=
 =?utf-8?B?RDJKMGVMSUdURFAybDdFNmttQkpKK3p5U0pYbkJNR3VaZmpkalV1VXhLNmZM?=
 =?utf-8?B?U1lDWVluRncrVnRUVnN0cmJvOG1DR0J5WGFzS0FPUDhCRXhCa05YUFo2Nm9q?=
 =?utf-8?B?NldaNGloaTQvWStIUHBsZzNUekxLcUwwSDA3blRpTWpkaWFwc295TXZYMXcx?=
 =?utf-8?B?Ym5IOThhZXdmalhrZlNLbkRnZURGWUFZbzJmazVKTUNUTlIxa2lPQnU1NnRG?=
 =?utf-8?B?NXZEMzJGRFFMcVZVcmw3eTg0VlcxU2Fldys4RG1zNHVCSzNRUXZjTU5Kb2FO?=
 =?utf-8?B?UnNpT1pwTGRRVGkxOUJGT0dGaXBzTW1ES0xCc2xQS0JrdTdjdUV1ZlAvb09Q?=
 =?utf-8?B?NXU5VkFpNXFiRU45SlF4SUVLRGFQUG5XNXp0a0JBTTNpc1BjSHZUbHpabXJh?=
 =?utf-8?B?M0xVbjRsNDVvalV4TVZoejY4TXNwUFgvYnRpcUsxaktOT0VLTUVUWTZjdVZl?=
 =?utf-8?B?ZmJYZExpVHp4UUs5RWxFZFZEWGo2Z3NDYmQrV0hSdWxvam1pRWl3MDdpS1pL?=
 =?utf-8?B?Q2tid0pFOUx0SVozU2srYklKV2NPaWJ6RVlubm5zbkR1cENGdmY0cndyai9U?=
 =?utf-8?B?N3pETU1Rc2RHcXBad2g0dy81WFVYSEs0NHRBbTA1SStrdHRIQS9wenlZd0FC?=
 =?utf-8?B?elcwTTBxVGg3bzFxK0hMU29nSUVtYVpmWVV3cUpUVENBMkROVU5DOW5iVStW?=
 =?utf-8?B?cDVKUDRMSGc0ekhsR2FtcEIyYVVPdHFKMlpsVmV0RDZmT3pzUGsycWM2aDNa?=
 =?utf-8?B?eDIxV1hiK2s5enBzL0dQTFNvTmJwQlpFUHJ3MnRuamhpVG1XYUVMYkxoSnlE?=
 =?utf-8?B?TmVEOWdReUdLMnhlZTlVcFVGa3pqSnpoQ2JUMDdRdU9FUlN2VnFMRktxdTdw?=
 =?utf-8?B?ajFLdFcxYk1mcU52cVM0SEF4eVFVMUsyU1hVazRhZjV5M0RZOG9sazM3MkFI?=
 =?utf-8?B?ZVpCaEhxWUVNRGh0cnBna0p5SmJuOXRlZmk1MFdPTmRXNUJxS0xIcHVjQ1pt?=
 =?utf-8?B?R05WS2QyZFBiU0V0V0l3WDlab0FhZkgrSnlJQUhFd0wxYURoQytTenlRVnRV?=
 =?utf-8?B?UGZTNWtRZXR2eENpSU5DelFmSk5lbVVFNEQrbm5TYkg4b2NzY2xETU1oMzN6?=
 =?utf-8?B?UXFNUEZodDNlNURraWdFb1hUc3ZWRlc1T3FrUzFya0FtTlpYeVFDL1IyUFRr?=
 =?utf-8?B?R3FBVDNJYXluMWJWc211cng4MUcya2xmTkRWaFU4TWswWThKQU5BY1ZIbmZ4?=
 =?utf-8?B?ZCs5RGRkaDdNUE0wd05GUnBoanZPQjFrYzl0UytmQXl1OVRMVk1zQVZXd0Vm?=
 =?utf-8?B?WXdvbkNMcitxK0R1YlpadStGTzQvL2JHSXV0VGNFZTVkZ1dxRFVxbE1zT2hQ?=
 =?utf-8?B?RTl3UkRsSldpRTY3NUdMaFdjQ2NjbmsxSUJ5ekZjZ2g2WjREQ2wyWXFrbkpa?=
 =?utf-8?B?b0cySWFya3drV2dXTzFTRnhDZGszUTBjeTZnUy9mUGZMbm1HbHUzbi8waGRO?=
 =?utf-8?B?TjJaVzdxd0tDeUhVakF4T0xOaXl2NStQNDFpUTFpY0g0Yzgva3JUYW5pZTB3?=
 =?utf-8?B?V2dEeDhidjF3T0lyMkFHazVXOVpURDVzZzRBT1drb3lIcCtjN0JBR08vYWd5?=
 =?utf-8?B?SlcrMzRsMWFDTDNzd0RRQWFvME1ReU43eThBQll4UXYwdWlHZ0lpUTV2cUU2?=
 =?utf-8?B?TmNCdlFVMWlUd1c1Y1NJbzNwVWx5enlUL0FtaHBEVU5qcU00LzNpcFRwZFpn?=
 =?utf-8?Q?NkzrAp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjY2L2hpSTJzS1pUaGI1VHdKNHpGdk5KU3JDWlhlQnV0d0Z3L1pOalNUT1g2?=
 =?utf-8?B?WGpUNG1GSDMvWVJwaStMbXVEaHFOL2hJdGh3dFFPYU51UC9YSmlsSnF3VUFv?=
 =?utf-8?B?TkppTlRmM3VpSjBCMXBELzhuQmp1SFJESWhpSjBDTmNGeG1ZZGVHbWdWTTBH?=
 =?utf-8?B?T0NGMithU3ZyS1E4by9pQ2VXUTlBLy9wQU9UN25BeHZDTkxUaFQ1OWRpOThR?=
 =?utf-8?B?L0paUkNrdEVmYnRGTjdVSDFxVTdnaVVzTmhhVlFueXJoVHpqWnFvd2FrYzVB?=
 =?utf-8?B?ZEU0enJTY1V3L3llSFZUODQ0YnJZNFR4WWhIaEVEK29vQjBqZ0xqU2x0QzZ3?=
 =?utf-8?B?aGJvQTFrUVp0MlUvVktvK3cwc1BxQTk3TVhJK2JRRUN6cFlYbTJ4SUdvMnFZ?=
 =?utf-8?B?L2t1d1BHTTI0R3NKeDZxc0l3elNHZjFNQjFNL1dCRm4rZlJycjZBQW5NQXZj?=
 =?utf-8?B?U091M2QyUjBzYllPbzROT0NIK1gyNm5jZlMzNUIwS2k1ZkVIVHRySW5sVnkz?=
 =?utf-8?B?aElMVlhRU3NTakNlaHpGU2hyVGQyQ3MwbWNReG5uUzdjZHVuTitqQzlzcWhp?=
 =?utf-8?B?Wk1zbmJVWVJOT1FuQ0pyQ1lUQXpOYmg5bzlNb2Q3ZGNteEVpVXQrQ3RJSU9H?=
 =?utf-8?B?Y2p2bitiK3NMVlUvS2RIMExaUk5hbTdhOHBSSXZ6d3JQcTdtb3kyZzVRV2hJ?=
 =?utf-8?B?TUYrWXZVenRHb1pSeHljdzdvU2dOMmdUSmlPbVI3WkgrZ3o0TmNsTzBZTWZw?=
 =?utf-8?B?MjUvMDlGdEd4Q05BaWhsNlR2dmc0eTJGK2VOc2pjalhkby9KNVpNdDVQL1FU?=
 =?utf-8?B?REsrWFE4cm12TXJEb3dDSnJvTG1MelRLYm90VnBmTktqUWVwVnhPamFwQzY1?=
 =?utf-8?B?L0lwSzBqZyt5Nklic0VCdFdFOFp1QXRjZHBsWWtYdlVBcWI1ZzZ6KzRaZFpQ?=
 =?utf-8?B?ZFZhWHpRV1A0Wmw1UTUzS2FpRDkvMEdCTTJEVUxzUkVGY2MwV0x6MjRjU09w?=
 =?utf-8?B?OFBZTWVEZytMQVVrQVg0M3NxTEhrWjNqKzE5eDkrSXcrcmxiZGlLbzJzMVNK?=
 =?utf-8?B?SGxBYzd1cjlKTDdxeVp6QWtzU1VHa3FxV0ROQzI2djRjUDVneEpzZDBKaTZy?=
 =?utf-8?B?WTc0RkRiUXZXVFpvcU95SGFtVmF4aW1sN0RPaUdjT01NeE5mU0hlQU9oNUkw?=
 =?utf-8?B?QnVTRmVjNXpldHdkT0llT3h0TFRGZHRvdVF4UkVHeUIwT3p5UExaZWREbEdp?=
 =?utf-8?B?N3kvYWJXeCt1SGtFQTBBYjZ5b0RSQ1pYZkJQOW9sSWJFVHhISEl1cFplRFBO?=
 =?utf-8?B?Nkx5UnpwcFFZVjdIZ1l6cDdNZy8vMjVocjN3NnFXUXNxQ2xTQmJRM2lvYzVj?=
 =?utf-8?B?Nk9FQ1dQdzB6ZlVlc1hzLzR4bGlIdTFQbkVJbnBDSjNCbEl6N2s5dERMZ0d6?=
 =?utf-8?B?N3dROWtFcUlpYkIvM2JDZ2dqWThUR3FmMGIyK0doZitoVUVoMEhCRzNXZjBO?=
 =?utf-8?B?UmhIdU81STM4ejFTTkVQVnhZM3VONVY2VzNyZCsyV1YwaXBWQXBBcWNscThR?=
 =?utf-8?B?bjlqQldUNlQxYXZNdjhhY1UwY2hZZjAyVEFHMmhhSHlmR1ZWcGdyUG14Zzdm?=
 =?utf-8?B?QzJLc2ZPVlkrYkZwc1NTYUtyUjFlMDQyUzRGMXhtOWRISGp6Y0libnZTTkxF?=
 =?utf-8?B?NzFJR2Z5eXcyTTdSUnEzcXVicXFhYmpKVkdTTmRPUzQvMkN1Mk0zSkJ2MHo4?=
 =?utf-8?B?QWxid3VtMmxWcVRtcEFBU21na28vV0RVWjF0bUh2WjJkTGMrTHdqYVZaWHIx?=
 =?utf-8?B?SnZKbXJ6VlZEWVUyeE5wbVpSbndmZE5FdWhWK0RSdmx1c25aNTB5ZkdaN2tt?=
 =?utf-8?B?R0dhQmxyazRxZVF1TGNPTWdJSkhQS2pVTkhJNlduZVo0aFpKL3EzMWxqMW1T?=
 =?utf-8?B?N0x5NVJUbVoySmFPTlpma0pxdGhkQUZybFEvMjFhbFBJWFJYZHRpS1lFVmZJ?=
 =?utf-8?B?ZWV1eVhXMkxXNDB6TXRBVFlOTUlWbWtCajJuM1JoREhRV0dyVi9kZW8xYWVt?=
 =?utf-8?B?WkJmdnhuOUZ1NjVlaHRXaitSa1FSZXZ5OFE5aUlnU25SZmJJS2xSU3p4WktL?=
 =?utf-8?B?ejBLei9rOGh4TThRcmFub3cyZDZLMUhUd3h4NEVtMjk4dmJ6djVFdmxCNDhB?=
 =?utf-8?B?TVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52D11127DFF623489B0824AA554A632C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cGsPGzlvOmDvHVxfSHtZDq3Y2oUoPjApmdfouOj9YOddNxc9x+mta4h+6VMoce/sZE4uYtZesia28ZM+gvGUvev0XWwWOBxM86sciZaGYkZxtOn6stzxf4wDn/K4lqt2dH9sNqag2mnz0jffYsvk+mJevYxUjmqThZsgYzT1Jw5n9XYsTQnxgc0ZxXZyWwJERFMY32PMFkGmP8xnwR4xNv4wm0V2crKTgcP3kGw5rqIIbA4tY3XclWjysTrG89B03PqOHg/rfZaNxE//Zul0k6YlVB83/3MehPhGwT3jK3LZE12fHOIAoijMtJrGjVBSs6rDdJi2paikp3fpklMvQvvcNc3d1bHxMwFVwnieqDZZtTpvuwt173FMxDStEeHdF+9YTobDHOSYY23aCKZBq9jRX+rZOuOpau4/SlG8c5EvxGZhnZEB66/NXgpYVw0fQk9TD+54zRbVjZeqVTAUnEhAiyk9eBnFLVfk90HRvGbX35eaDfBFC1gSKsxp51lNacNodn1efpWt0GRMAa7IeTBW3Y3fyrF42AL82b1u6ziVtFCAjO27PbGaDtAc2MEZ8clDUJ1XPdYWbP+L0nQWqcW+4dc9PS+/wE40kdlGU+ruDABZUePVPsjlwMSpuDhG
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5be849-ce7e-4b36-1b6d-08dd9118c452
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 05:49:31.5327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZZXOFHzAVTL+msNp7bsk/wX7CGTxuqDCvIKwMGlXWfluRMDlRagXwvx2tKCGodaQsmOb72wWQNj2Lrd1i+UKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB15425
Received-SPF: pass client-ip=68.232.159.90; envelope-from=lizhijian@fujitsu.com;
 helo=esa9.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

DQoNCk9uIDA5LzA1LzIwMjUgMjM6MzIsIFBldGVyIFh1IHdyb3RlOg0KPiBEb2VzIHRoaXMgbWVh
biBJJ2xsIG5lZWQgdG8gc2V0dXAgdHdpY2UsIG9uZSBmb3IgZWFjaCB2Pw0KPiANCj4gRXZlbiBp
ZiBzbywgSSBkaWQgdGhpczoNCj4gDQo+ID09PTg8PT09DQo+ICQgc3VkbyAuLi9zY3JpcHRzL3Jk
bWEtbWlncmF0aW9uLWhlbHBlci5zaCBzZXR1cA0KPiBTZXR1cCBuZXcgcmRtYS9yeGUgd2xwMHMy
MGYzX3J4ZSBmb3Igd2xwMHMyMGYzIHdpdGggMTkyLjE2OC42OC4xMjMNCj4gJCBzdWRvIElQX0ZB
TUlMWT1pcHY2IC4uL3NjcmlwdHMvcmRtYS1taWdyYXRpb24taGVscGVyLnNoIHNldHVwDQo+IFNl
dHVwIG5ldyByZG1hL3J4ZSB0dW4wX3J4ZSBmb3IgdHVuMCB3aXRoIFtmZDEwOjIyOjg4OjE6OjEx
MGMldHVuMF0NCj4gJCByZG1hIGxpbmsNCj4gbGluayB3bHAwczIwZjNfcnhlLzEgc3RhdGUgQUNU
SVZFIHBoeXNpY2FsX3N0YXRlIExJTktfVVAgbmV0ZGV2DQo+IHdscDBzMjBmMw0KPiBsaW5rIHR1
bjBfcnhlLzEgc3RhdGUgQUNUSVZFIHBoeXNpY2FsX3N0YXRlIExJTktfVVAgbmV0ZGV2IHR1bjAN
Cj4gPT09ODw9PT0NCg0KVGhhdCdzIGJlY2F1c2UgbG8vdHVuL3RhcCBpcyBub3QgYW4gdmFsaWQg
UlhFIGZvciBtaWdyYXRpb24sIEkgd2lsbCB1cGRhdGUNCnRoZSBzY3JpcHQgdG8gaWdub3JlIHRo
ZW0uDQoNCg0KDQo+IHJkbWE6W2ZkZDM6NGZkYzo5N2M5OmNhNGU6MjgzNzoyOGRkOjFlYzQ6NmI1
YSV3bHAwczIwZjNdOjI5MjAwICAtZHJpdmUNCj4gaWY9bm9uZSxpZD1kMCxmaWxlPS90bXAvbWln
cmF0aW9uLXRlc3QtUUVCNDUyL2Jvb3RzZWN0LGZvcm1hdD1yYXcNCj4gLWRldmljZSBpZGUtaGQs
ZHJpdmU9ZDAsc2Vjcz0xLGN5bHM9MSxoZWFkcz0xICAgIC1hY2NlbCBxdGVzdA0KPiBxZW11LXN5
c3RlbS14ODZfNjQ6IC1pbmNvbWluZw0KPiByZG1hOltmZGQzOjRmZGM6OTdjOTpjYTRlOjI4Mzc6
MjhkZDoxZWM0OjZiNWEld2xwMHMyMGYzXToyOTIwMDogUkRNQQ0KPiBFUlJPUjogY291bGQgbm90
IHJkbWFfZ2V0YWRkcmluZm8gYWRkcmVzcw0KPiBmZGQzOjRmZGM6OTdjOTpjYTRlOjI4Mzc6Mjhk
ZDoxZWM0OjZiNWEld2xwMHMyMGYzDQo+IEJyb2tlbiBwaXBlDQo+IC4uL3Rlc3RzL3F0ZXN0L2xp
YnF0ZXN0LmM6MTk5OiBraWxsX3FlbXUoKSB0cmllZCB0byB0ZXJtaW5hdGUgUUVNVQ0KPiBwcm9j
ZXNzIGJ1dCBlbmNvdW50ZXJlZCBleGl0IHN0YXR1cyAxIChleHBlY3RlZCAwKQ0KPiBBYm9ydGVk
DQo+ID09PTg8PT09DQo+IA0KPiBJdCB3b3VsZCBiZSBncmVhdCBpZiB0aGUgc2V0dXAgb25seSBu
ZWVkcyB0byBiZSBydW4gb25jZSwgc2V0dGluZyB1cA0KPiB3aGF0ZXZlciBpcHYqIHN1cHBvcnRl
ZCwgdGhlbiBpbiB0aGUgdGVzdCBydW4ga2lja29mZiB3aGF0ZXZlciBpcHYqIGlzDQo+IHN1cHBv
cnRlZCBhbmQgZGV0ZWN0ZWQuDQo+IA0KPiBXb3VsZCBpdCBiZSBwb3NzaWJsZT8NCg0KSXQgc291
bmQgZ29vZCB0byBtZSwgSSB3aWxsIHVwZGF0ZSBpdCBpbiBuZXh0IHZlcnNpb24NCg0KDQpUaGFu
a3MNClpoaWppYW4NCg0KPiANCj4gVGhhbmtzLA==

