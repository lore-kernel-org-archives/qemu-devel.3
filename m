Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C70C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 00:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpH2l-00055v-14; Tue, 26 Mar 2024 20:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1rpH2j-00055j-Ls
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 20:21:25 -0400
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1rpH2g-00089U-Tx
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 20:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1711498882; x=1743034882;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zrqNpaLvLqVnhrVpSq2BS64peeAJ4mP/SdQEXR1vhRM=;
 b=em96QrarDEK73oIqG8Jvwkp7RJJDuldF9gHwWXPpHBY5IcuaX9lhtqMV
 fXq25bxopt74V+bEH1n8JJ4Evd9mlqPkWgJwpJJDhR8Q0o7q4NHjlo1Uz
 IhaPbaVDMYH4NTPyf9qrAP9quaLlEmeN+BWKm4IfLWiXRivGneNoInBRt
 DhClzwimkjI4BLpX76ld6ZpeiLyh3pETNtVUc3x2LQmxikEEjYvXiDCIR
 P15YsXGZxHPceRpLEgveFsUe02V3u9FSBO8yjcH4KamExxOYYgmuCuROy
 gNPbouY4S9eqFRgSf2mYwaLSvR8sBtdFqB0mIh3Hfw1iSudIWkojgjPNb g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="26280403"
X-IronPort-AV: E=Sophos;i="6.07,157,1708354800"; d="scan'208";a="26280403"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 09:21:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXz2KXqwRhsCpmwUDPhrgRSycMR+conLrupeSis5fvB188ubJczIGJy1pgtEMhn/EIUVvy/m79X87gk+OSyy2Jxyp/xMrvux0DLmtfRDa8m3vyLpt+/Rrb9sWTwksRXO4j47flalhiY1OR3r5ndSbylBPyxwOIh4XTrHPBYV0bRrgXntT0Zdr5lVCC/UqfA21PmFOkc4JGDkyj4uf7XyBKcippoIedwCUrSKR8NAIDyjz1uLjZlvdkDVTM4pDVtOxvBg75frLzc+G1ceOnKw7u0sIM7vSLt+ZjDVY1HJkYDc/Jd/noVPDjCMHAPPQLGhAPRGeMTQmOeb7kuCLo0zNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrqNpaLvLqVnhrVpSq2BS64peeAJ4mP/SdQEXR1vhRM=;
 b=Ur6miAYRTQOTo6QL9UXMjf4N19l5QsWkFEA/GK4Be1B2pQsBwb3kqRlpLhIkTBIpKSAuGIq3IS40SaR7+xNQD4eEfCVN1IrQHsBQYHlIYj8k6/v01YxGeEQb5KNLZCPiAhiaB1P78iRwiZkIRGjcbwWwVrv1NuNhhxiK87BrQ2i6W0RyZHYG7/BLOyssfA9ol38w6GeSazzVQxLpj11q9O56nil10S7DhnQdpnAszeJaJQPL1Mr/5ymubOyzufLrDv96I3d3ODCNhM5z6xZkHiwO1EQ+gbvS9MuQaVM8WxA/3NLESSD04Mohh4fqaoX7dTCZxxfea+N6Of7nxGPBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYCPR01MB10927.jpnprd01.prod.outlook.com (2603:1096:400:3aa::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Wed, 27 Mar
 2024 00:21:10 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d%5]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 00:21:10 +0000
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Peter
 Maydell <peter.maydell@linaro.org>
CC: Pierrick Bouvier <pierrick.bouvier@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "erdnaxe@crans.org" <erdnaxe@crans.org>, "ma.mandourr@gmail.com"
 <ma.mandourr@gmail.com>
Subject: RE: [PATCH v3] contrib/plugins/execlog: Fix compiler warning
Thread-Topic: [PATCH v3] contrib/plugins/execlog: Fix compiler warning
Thread-Index: AQHafyBb+YAKEoJk4ECTAmHsMaIgtrFJXpUAgABqegCAAArSAIAAGSmAgADNcIA=
Date: Wed, 27 Mar 2024 00:21:10 +0000
Message-ID: <OSZPR01MB6453859B9DEC5CE7D6799CE98D342@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240320020115.18801-1-yaoxt.fnst@fujitsu.com>
 <20240326015257.21516-1-yaoxt.fnst@fujitsu.com>
 <9eb2194e-7efe-448a-a511-9d10e589943e@linaro.org>
 <c0bdb1f6-b456-4378-a2ee-b2355ad5bb42@linaro.org>
 <CAFEAcA_0j0HZ16MqR1QtPJPx7xFGJPbW7=Zgo-wHzhpZHRiMCg@mail.gmail.com>
 <0a772baa-73fc-4095-88fb-1dca14d29463@linaro.org>
In-Reply-To: <0a772baa-73fc-4095-88fb-1dca14d29463@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9YWRiYjExNjctMGFjZS00MThlLWJiZjQtMjA2Mzc3ZThi?=
 =?utf-8?B?MDBjO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTAzLTI3VDAwOjE5OjA2WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYCPR01MB10927:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2y2Fp9Dtowr2bo9zwGZZwJ1eJcCEL9XrVCs0S0MjhWiaCk1iuztgNCVfl/LU2zUmofEtiL9vz6vwLUzbvmtq0d0xa1xqTyGK1FRbtF9mEicBElx3tfe+E6wchugbWr9ql1kSrjoqchHprbGEXkOs8nXZUPDNem32Dj/uFeyBQVnxnNp4juo5VDj8dxGmfrYszcdwZfkfDNR0uI1u+ecdG5Xwt7XlUdHLK3ipFK5Tc71gOXyDWRcubGkqgZrKGcIg6khcW+CyE+huF5twpDsBGUbq+6QSzYU+hMfrTzaukL9fw5DaD7B9CpIXCieUube5drrp7UlzIchz9AWRMseIyH+hOVDSxL3rGqKAjAx3nbkaI2+XLa+O7d0p50W1UUBCkk+4cQ+8qrhM3isAsBwAwR4YGSjNjRqnRrVDwDIH6EuJ9BvYm6i0Tg18EHMHOiRFHREmYG+xz7KHLl1iWtZNiX55WqwJSctbSWh8E3c8F/D7fel6ujvpuq6dw36eLHs3MM3w9oXCZU5EUwEQgBuhuKBRlJuOkB/OZwSjDNIqLDXxcl90unO0kTQdJk0rZ1yDCUUB5p+kuXmFElxFg/t7xYmLodfCE2Mz6C44KlhJaRZtb0lHMAGZabtyedJ/X8RIz/Hx1ZbjLwyLEgtO55H3YKjqZuPJDCRxYkxWw2dQdps=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(376005)(1800799015)(366007)(1580799018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUVDbXBPdnpWM2JqZTBhUFNCYkJWQVJWelZia3I5dFdTaGFPcXhVM214Zlg3?=
 =?utf-8?B?QUVtbktKTWkvUW45MlMyUmNsMytXQjNlSUkxMlIrRS9Vd04yaE0xcWFzbHBo?=
 =?utf-8?B?WG9JL0JLa1ZyKzB3OThzM0lyZEVuS2FBVTgwTnZpeVhzMlA1ajFVQy94RkVH?=
 =?utf-8?B?b1RtQWVYcFYvOVRIVVRpTFIvOXRJcGVhaW9veExSZmpNM0FWWDlZSWZvRTRF?=
 =?utf-8?B?cGhYZHFKdjdsT2NhSjl1d0x6VUpmSG9YMGJPR2gwemg1Y0I0ZWNCNVhVTkxk?=
 =?utf-8?B?bXVUQjdrY084UjFuZ2VJbjQzdHlYUEI3azJldWpuRmoza01oRWFnNmFzZ0tB?=
 =?utf-8?B?bSs2Nit2Lytma24zeUIvVXVwR1JSYUs4NDJ5aEY2VTU4MEgvZk8zNmpKRTNh?=
 =?utf-8?B?QnFQMXpxcmVsekFySHpma2l4TzNteXB2aFpCbm9MZnIyS0pSMTI4cStRQWF5?=
 =?utf-8?B?bHI4QXZaVlp3RHNON25qRVl6cFlLc3Z3c3NKRDg0VGNVbFlKa2FBTFpSSDAv?=
 =?utf-8?B?R0NIT2VQTGZWRkRqZGFiTnEzOW5DR2IxTVVuV1MxdGlIQlk2NnZEenBhb1lD?=
 =?utf-8?B?eC83amdWZGQ2TWw3eWd1akRFUWlZdWpGaHJwWkZMS1RVVFVLd1FUd0svYWpu?=
 =?utf-8?B?VEJMZ0cwQWlTZDYzM1M2YjNRdHNHM0MzQjdIbDVQZVNIWlBkNUFHOE9EU1RW?=
 =?utf-8?B?QXY0VlovMmNhNWlLV05IOHAyVndpZGF2UGVIMXZ6bkEwd3JsdkZGbWhhdEsz?=
 =?utf-8?B?Zm1oQjBJZ0I2M3c5d0oycUdOcGI3YkJrbFdZQXhxZU12Z3VkOUVBdWs4YXBi?=
 =?utf-8?B?RmRMM0J0eGgzakZudUd2aUN4bmI3cXNONWZjaWduUSszMGRRV3cvMXlzdGxN?=
 =?utf-8?B?YmI5cjBudU1KSlAxaWoyOVFmckNQZXlFRU8rTGdUdXlMZlFIVlRVM1Z6SlY1?=
 =?utf-8?B?QkFiMHNNRElzM2owdU9zbml5L3BPR2thbmpxc0pxQ2VmOFlIL09ZREJNMVBu?=
 =?utf-8?B?L1J6N094MG1pUVpMMnNwTVBDd29PdWkyNElaNnE2SmJ6M1pHZVhYNmtMV2FI?=
 =?utf-8?B?bUdHL3NubFd0Qndnb1orWGhkbWhhUVVQNnB5NU5iT1FWa2Q1eVpUY0RCSDhi?=
 =?utf-8?B?K2xSZWx2OUhHVGlLd0dOaW1TQTNmdDc0UjNWUzNtNzN2V3E0THpreDI2UjVu?=
 =?utf-8?B?NCtJVGMvL1N6eDBHTWIvcjZPeW1kYS9QSFo5Q1BGSUppTGY5STl3RGZPQnBQ?=
 =?utf-8?B?aTZVQW40b2RpTmltSDFJMVR5YW5GalFGMEZmWksyVFR3b0x5ZGFLY3lSVzdt?=
 =?utf-8?B?NEhrbFMrTDBZWGRqV3hua1NNR0xuemptcHRFRnlzMGRrbmw0b2xOVlZUeTlk?=
 =?utf-8?B?NkdmTlFtYjl1NWRUTlphdXBQTVlxTEh1ZGlNZHRaQnFGQ2k2ZENlVkQyckJo?=
 =?utf-8?B?NjV2RzFaeEVSa2ZXV21McDNEMU0zbkxvcjNFRThpR29zRFB3SHV5WjBUdnhz?=
 =?utf-8?B?NzgwTEJSNmNvNHJycm1Hb3RKdko1TkorbndpTXd6VllmMW5OY3Q1Y1dVbU14?=
 =?utf-8?B?NG9GWXZQblF4SHZtSHdEWmJsSlVCQU5TYzN0VzVsNjJXL2VCeVpEU3dRMm5s?=
 =?utf-8?B?cE5WMVkzdHVuclNnODlxUWRWVnlUeWVhcXhFa3JjaTkwQjNiZzJURXBtZjNa?=
 =?utf-8?B?TGlUV1JDc3R4L2VPMEhQbmpuTkQ0MncxeWZWQUZqRHNvcHQ2SVJrbTlaTysv?=
 =?utf-8?B?ZjN1TzJicFVDSjVBemVzRHlGNnUybU1NNEtzTXIrbzdrc3VZcGcyOXpRb1pt?=
 =?utf-8?B?Zm9CZmh6ZkR3bUZ2Vkk5a0VnVFdFSWJkbWZ5K2ZqNkhtOXhtWWczTXgvbjN6?=
 =?utf-8?B?dkxHdXFWTFNoMFVXTStvMDhCS3MxSzJtV0c3Z3poanpncmFjSTRMRythdXIr?=
 =?utf-8?B?ZjVCSlZWdmNmUlRXeFpXUFRRbU1uWEtRUkN6TFc3NGRBcGxPc2hSK2d3NlpX?=
 =?utf-8?B?VkZleCsxaG9BQUxDZ2t3SnFIelo4V0F5RmhQandjQTVrcGhuMEExbUZVd3BH?=
 =?utf-8?B?NjM1SGxkbGQ4ZFZ5Q3JkRUN2YlkvZmJKS3gzbm8vWkl1aVRDUEI3SE50T3lL?=
 =?utf-8?Q?EV9KJJ4CIIc5vajY9hGss2FIE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PP3KUnt4b65eqYMfr10yzveGOSUyIiGe7m/1RH1fFnL5+YuBmA/sbu2A3gYk5Abfa1Dsxab6hhgK7oZ2NzLYmZ4vHhemayUunRXpqb+1NS/eu6bkqIYeW5AKxbdIMldqJXMVXwci1gU/4pJH3WV9KO5kdt1UpV3dqDbVvv97fMqar3im6Z7+QbnRno3llI9zXLbpQp/V4k9T8qUkv3y9awED21v8PJ1A6aiG1moYNB0BueJhWGdQE5cxrOvX44mHE84SJsHm125DgJw1hxVI5BD1LrYx0I2BGo3w+R+RKgqIoFW69XG3GfzmY1AlGgqsOh4kZpxLaFMCf4nEIMWSqFptSwOe+6ceFneygwtyVtPRjRpzJHWewSQX6Y6bREoO1i5tPjMwWWFGpQFux53gI5NIZvDE50aoh9Ww+yAqudl/pcLmIZ/DRZ8yAyio7eIdShBdkCzk0lfRboGIkBFL/LROMvMzEzaI5qXKP5VeTuD092BM/9RFXEd+2QT+JVgrh/wxnBowF2Zupsw0/E8AklZdet28Yzq5eDawyPiNfn6hrFYKpNjalJythu6UFPP3ur9O3YUsE0Ujn/F+YnNRUFHXVtXdMrDjH1YdrHfyShN/zVQ0265SXOnksdhFLmUv
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab1908c-becd-49fb-7c0e-08dc4df3ce07
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 00:21:10.8497 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2UQbbPCgo2eQ8/vM0I7iYQ3JdRTIsbkgrFiSQ3vVjHqRqwJQ9YO87Pvez9meij9t0AcS3UUyxrpsyV1edAVtBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10927
Received-SPF: pass client-ip=68.232.151.212;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa3.fujitsucc.c3s2.iphmx.com
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAyNiwg
MjAyNCA4OjA0IFBNDQo+IFRvOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5v
cmc+DQo+IENjOiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+
OyBZYW8sIFhpbmd0YW8v5aeaIOW5uOa2mw0KPiA8eWFveHQuZm5zdEBmdWppdHN1LmNvbT47IHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZzsgYWxleC5iZW5uZWVAbGluYXJvLm9yZzsNCj4gZXJkbmF4ZUBj
cmFucy5vcmc7IG1hLm1hbmRvdXJyQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYz
XSBjb250cmliL3BsdWdpbnMvZXhlY2xvZzogRml4IGNvbXBpbGVyIHdhcm5pbmcNCj4gDQo+IE9u
IDI2LzMvMjQgMTE6MzMsIFBldGVyIE1heWRlbGwgd3JvdGU6DQo+ID4gT24gVHVlLCAyNiBNYXIg
MjAyNCBhdCAwOTo1NCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3Jn
Pg0KPiB3cm90ZToNCj4gPj4NCj4gPj4gT24gMjYvMy8yNCAwNDozMywgUGllcnJpY2sgQm91dmll
ciB3cm90ZToNCj4gPj4+IE9uIDMvMjYvMjQgMDU6NTIsIFlhbyBYaW5ndGFvIHdyb3RlOg0KPiA+
Pj4+IDEuIFRoZSBnX3BhdHRlcm5fbWF0Y2hfc3RyaW5nKCkgaXMgZGVwcmVjYXRlZCB3aGVuIGds
aWIyIHZlcnNpb24gPj0NCj4gMi43MC4NCj4gPj4+PiAgICAgIFVzZSBnX3BhdHRlcm5fc3BlY19t
YXRjaF9zdHJpbmcoKSBpbnN0ZWFkIHRvIGF2b2lkIHRoaXMNCj4gcHJvYmxlbS4NCj4gPj4+Pg0K
PiA+Pj4+IDIuIFRoZSB0eXBlIG9mIHNlY29uZCBwYXJhbWV0ZXIgaW4gZ19wdHJfYXJyYXlfYWRk
KCkgaXMNCj4gPj4+PiAgICAgICdncG9pbnRlcicge2FrYSAndm9pZCAqJ30sIGJ1dCB0aGUgdHlw
ZSBvZiByZWctPm5hbWUgaXMgJ2NvbnN0DQo+ID4+Pj4gY2hhcionLg0KPiA+Pj4+ICAgICAgQ2Fz
dCB0aGUgdHlwZSBvZiByZWctPm5hbWUgdG8gJ2dwb2ludGVyJyB0byBhdm9pZCB0aGlzIHByb2Js
ZW0uDQo+ID4+Pj4NCj4gPj4+PiBjb21waWxlciB3YXJuaW5nIG1lc3NhZ2U6DQo+ID4+Pj4gL3Jv
b3QvcWVtdS9jb250cmliL3BsdWdpbnMvZXhlY2xvZy5jOjMzMDoxNzogd2FybmluZzoNCj4gPj4+
PiDigJhnX3BhdHRlcm5fbWF0Y2hfc3RyaW5n4oCZDQo+ID4+Pj4gaXMgZGVwcmVjYXRlZDogVXNl
ICdnX3BhdHRlcm5fc3BlY19tYXRjaF9zdHJpbmcnDQo+ID4+Pj4gaW5zdGVhZCBbLVdkZXByZWNh
dGVkLWRlY2xhcmF0aW9uc10NCj4gPj4+PiAgICAgMzMwIHwgICAgICAgICAgICAgICAgIGlmIChn
X3BhdHRlcm5fbWF0Y2hfc3RyaW5nKHBhdCwgcmQtPm5hbWUpDQo+IHx8DQo+ID4+Pj4gICAgICAg
ICB8ICAgICAgICAgICAgICAgICBefg0KPiA+Pj4+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdXNy
L2luY2x1ZGUvZ2xpYi0yLjAvZ2xpYi5oOjY3LA0KPiA+Pj4+ICAgICAgICAgICAgICAgICAgICBm
cm9tIC9yb290L3FlbXUvY29udHJpYi9wbHVnaW5zL2V4ZWNsb2cuYzo5Og0KPiA+Pj4+IC91c3Iv
aW5jbHVkZS9nbGliLTIuMC9nbGliL2dwYXR0ZXJuLmg6NTc6MTU6IG5vdGU6IGRlY2xhcmVkIGhl
cmUNCj4gPj4+PiAgICAgIDU3IHwgZ2Jvb2xlYW4gICAgICBnX3BhdHRlcm5fbWF0Y2hfc3RyaW5n
ICAgKEdQYXR0ZXJuU3BlYw0KPiAqcHNwZWMsDQo+ID4+Pj4gICAgICAgICB8ICAgICAgICAgICAg
ICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+Pj4+IC9yb290L3FlbXUvY29udHJpYi9wbHVn
aW5zL2V4ZWNsb2cuYzozMzE6MjE6IHdhcm5pbmc6DQo+ID4+Pj4g4oCYZ19wYXR0ZXJuX21hdGNo
X3N0cmluZ+KAmQ0KPiA+Pj4+IGlzIGRlcHJlY2F0ZWQ6IFVzZSAnZ19wYXR0ZXJuX3NwZWNfbWF0
Y2hfc3RyaW5nJw0KPiA+Pj4+IGluc3RlYWQgWy1XZGVwcmVjYXRlZC1kZWNsYXJhdGlvbnNdDQo+
ID4+Pj4gICAgIDMzMSB8ICAgICAgICAgICAgICAgICAgICAgZ19wYXR0ZXJuX21hdGNoX3N0cmlu
ZyhwYXQsIHJkX2xvd2VyKSkNCj4gew0KPiA+Pj4+ICAgICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gPj4+PiAvdXNyL2luY2x1ZGUvZ2xpYi0yLjAv
Z2xpYi9ncGF0dGVybi5oOjU3OjE1OiBub3RlOiBkZWNsYXJlZCBoZXJlDQo+ID4+Pj4gICAgICA1
NyB8IGdib29sZWFuICAgICAgZ19wYXR0ZXJuX21hdGNoX3N0cmluZyAgIChHUGF0dGVyblNwZWMN
Cj4gKnBzcGVjLA0KPiA+Pj4+ICAgICAgICAgfCAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+
fn5+fn5+fn4NCj4gPj4+PiAvcm9vdC9xZW11L2NvbnRyaWIvcGx1Z2lucy9leGVjbG9nLmM6MzM5
OjYzOiB3YXJuaW5nOiBwYXNzaW5nDQo+ID4+Pj4gYXJndW1lbnQNCj4gPj4+PiAyIG9mDQo+ID4+
Pj4g4oCYZ19wdHJfYXJyYXlfYWRk4oCZIGRpc2NhcmRzIOKAmGNvbnN04oCZIHF1YWxpZmllciBm
cm9tIHBvaW50ZXIgdGFyZ2V0DQo+ID4+Pj4gdHlwZSBbLVdkaXNjYXJkZWQtcXVhbGlmaWVyc10N
Cj4gPj4+PiAgICAgMzM5IHwNCj4gZ19wdHJfYXJyYXlfYWRkKGFsbF9yZWdfbmFtZXMsDQo+ID4+
Pj4gcmVnLT5uYW1lKTsNCj4gPj4+PiAgICAgICAgIHwNCj4gPj4+PiB+fn5efn5+fn4NCj4gPj4+
PiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gL3Vzci9pbmNsdWRlL2dsaWItMi4wL2dsaWIuaDozMzoN
Cj4gPj4+PiAvdXNyL2luY2x1ZGUvZ2xpYi0yLjAvZ2xpYi9nYXJyYXkuaDoxOTg6NjI6IG5vdGU6
IGV4cGVjdGVkDQo+ID4+Pj4g4oCYZ3BvaW50ZXLigJkge2FrYSDigJh2b2lkICrigJl9IGJ1dCBh
cmd1bWVudCBpcyBvZiB0eXBlIOKAmGNvbnN0IGNoYXIgKuKAmQ0KPiA+Pj4+ICAgICAxOTggfCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ3BvaW50ZXINCj4gPj4+
PiBkYXRhKTsNCj4gPj4+PiAgICAgICAgIHwNCj4gPj4+PiB+fn5+fn5+fn5+fn5+fn5+fn5efn5+
DQo+ID4+Pj4NCj4gPj4+PiBSZXNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVj
dC9xZW11Ly0vaXNzdWVzLzIyMTANCj4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBZYW8gWGluZ3RhbyA8
eWFveHQuZm5zdEBmdWppdHN1LmNvbT4NCj4gPj4+PiAtLS0NCj4gPj4+PiAgICBjb250cmliL3Bs
dWdpbnMvZXhlY2xvZy5jIHwgMjQgKysrKysrKysrKysrKysrKysrKysrLS0tDQo+ID4+Pj4gICAg
MSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4+Pj4N
Cj4gPj4+PiBkaWZmIC0tZ2l0IGEvY29udHJpYi9wbHVnaW5zL2V4ZWNsb2cuYyBiL2NvbnRyaWIv
cGx1Z2lucy9leGVjbG9nLmMNCj4gPj4+PiBpbmRleCBhMWRmZDU5YWI3Li5mYWIxODExM2Q0IDEw
MDY0NA0KPiA+Pj4+IC0tLSBhL2NvbnRyaWIvcGx1Z2lucy9leGVjbG9nLmMNCj4gPj4+PiArKysg
Yi9jb250cmliL3BsdWdpbnMvZXhlY2xvZy5jDQo+ID4+Pj4gQEAgLTMxMSw2ICszMTEsMjQgQEAg
c3RhdGljIFJlZ2lzdGVyDQo+ID4+Pj4gKmluaXRfdmNwdV9yZWdpc3RlcihxZW11X3BsdWdpbl9y
ZWdfZGVzY3JpcHRvciAqZGVzYykNCj4gPj4+PiAgICAgICAgcmV0dXJuIHJlZzsNCj4gPj4+PiAg
ICB9DQo+ID4+Pj4gKy8qDQo+ID4+Pj4gKyAqIGdfcGF0dGVybl9tYXRjaF9zdHJpbmcgaGFzIGJl
ZW4gZGVwcmVjYXRlZCBpbiBHbGliIHNpbmNlIDIuNzANCj4gPj4+PiArYW5kDQo+ID4+Pj4gKyAq
IHdpbGwgY29tcGxhaW4gYWJvdXQgaXQgaWYgeW91IHRyeSB0byB1c2UgaXQuIEZvcnR1bmF0ZWx5
IHRoZQ0KPiA+Pj4+ICsgKiBzaWduYXR1cmUgb2YgYm90aCBmdW5jdGlvbnMgaXMgdGhlIHNhbWUg
bWFraW5nIGl0IGVhc3kgdG8gd29yaw0KPiA+Pj4+ICsgKiBhcm91bmQuDQo+ID4+Pj4gKyAqLw0K
PiA+Pj4+ICtzdGF0aWMgaW5saW5lDQo+ID4+Pj4gK2dib29sZWFuIGdfcGF0dGVybl9zcGVjX21h
dGNoX3N0cmluZ19xZW11KEdQYXR0ZXJuU3BlYyAqcHNwZWMsDQo+ID4+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGdjaGFyICpzdHJpbmcpIHsNCj4g
Pj4+PiArI2lmIEdMSUJfQ0hFQ0tfVkVSU0lPTigyLCA3MCwgMCkNCj4gPj4+PiArICAgIHJldHVy
biBnX3BhdHRlcm5fc3BlY19tYXRjaF9zdHJpbmcocHNwZWMsIHN0cmluZyk7ICNlbHNlDQo+ID4+
Pj4gKyAgICByZXR1cm4gZ19wYXR0ZXJuX21hdGNoX3N0cmluZyhwc3BlYywgc3RyaW5nKTsgI2Vu
ZGlmIH07DQo+ID4+Pj4gKyNkZWZpbmUgZ19wYXR0ZXJuX3NwZWNfbWF0Y2hfc3RyaW5nKHAsIHMp
DQo+ID4+Pj4gZ19wYXR0ZXJuX3NwZWNfbWF0Y2hfc3RyaW5nX3FlbXUocCwgcykNCj4gPj4+PiAr
DQo+ID4+Pj4gICAgc3RhdGljIEdQdHJBcnJheSAqcmVnaXN0ZXJzX2luaXQoaW50IHZjcHVfaW5k
ZXgpDQo+ID4+Pj4gICAgew0KPiA+Pj4+ICAgICAgICBnX2F1dG9wdHIoR1B0ckFycmF5KSByZWdp
c3RlcnMgPSBnX3B0cl9hcnJheV9uZXcoKTsgQEANCj4gPj4+PiAtMzI3LDggKzM0NSw4IEBAIHN0
YXRpYyBHUHRyQXJyYXkgKnJlZ2lzdGVyc19pbml0KGludCB2Y3B1X2luZGV4KQ0KPiA+Pj4+ICAg
ICAgICAgICAgICAgIGZvciAoaW50IHAgPSAwOyBwIDwgcm1hdGNoZXMtPmxlbjsgcCsrKSB7DQo+
ID4+Pj4gICAgICAgICAgICAgICAgICAgIGdfYXV0b3B0cihHUGF0dGVyblNwZWMpIHBhdCA9DQo+
ID4+Pj4gZ19wYXR0ZXJuX3NwZWNfbmV3KHJtYXRjaGVzLT5wZGF0YVtwXSk7DQo+ID4+Pj4gICAg
ICAgICAgICAgICAgICAgIGdfYXV0b2ZyZWUgZ2NoYXIgKnJkX2xvd2VyID0NCj4gPj4+PiBnX3V0
Zjhfc3RyZG93bihyZC0+bmFtZSwgLTEpOw0KPiA+Pj4+IC0gICAgICAgICAgICAgICAgaWYgKGdf
cGF0dGVybl9tYXRjaF9zdHJpbmcocGF0LCByZC0+bmFtZSkgfHwNCj4gPj4+PiAtICAgICAgICAg
ICAgICAgICAgICBnX3BhdHRlcm5fbWF0Y2hfc3RyaW5nKHBhdCwgcmRfbG93ZXIpKSB7DQo+ID4+
Pj4gKyAgICAgICAgICAgICAgICBpZiAoZ19wYXR0ZXJuX3NwZWNfbWF0Y2hfc3RyaW5nKHBhdCwg
cmQtPm5hbWUpIHx8DQo+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgZ19wYXR0ZXJuX3NwZWNf
bWF0Y2hfc3RyaW5nKHBhdCwgcmRfbG93ZXIpKSB7DQo+ID4+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICBSZWdpc3RlciAqcmVnID0gaW5pdF92Y3B1X3JlZ2lzdGVyKHJkKTsNCj4gPj4+PiAgICAg
ICAgICAgICAgICAgICAgICAgIGdfcHRyX2FycmF5X2FkZChyZWdpc3RlcnMsIHJlZyk7IEBAIC0z
MzYsNw0KPiA+Pj4+ICszNTQsNyBAQCBzdGF0aWMgR1B0ckFycmF5ICpyZWdpc3RlcnNfaW5pdChp
bnQgdmNwdV9pbmRleCkNCj4gPj4+PiAgICAgICAgICAgICAgICAgICAgICAgIGlmIChkaXNhc19h
c3Npc3QpIHsNCj4gPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICBnX211dGV4X2xvY2so
JmFkZF9yZWdfbmFtZV9sb2NrKTsNCj4gPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICBp
ZiAoIWdfcHRyX2FycmF5X2ZpbmQoYWxsX3JlZ19uYW1lcywNCj4gPj4+PiByZWctPm5hbWUsIE5V
TEwpKSB7DQo+ID4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICBnX3B0cl9hcnJheV9h
ZGQoYWxsX3JlZ19uYW1lcywNCj4gcmVnLT5uYW1lKTsNCj4gPj4+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGdfcHRyX2FycmF5X2FkZChhbGxfcmVnX25hbWVzLA0KPiA+Pj4+IChncG9p
bnRlcilyZWctPm5hbWUpOw0KPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4g
Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICBnX211dGV4X3VubG9jaygmYWRkX3JlZ19u
YW1lX2xvY2spOw0KPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+Pj4NCj4gPj4+
IFdvdWxkIGJlIG5pY2UgaWYgaXQncyBzdGlsbCBwb3NzaWJsZSB0byBtZXJnZSB0aGlzIGluIDku
MCBQZXRlci4NCj4gPj4NCj4gPj4gSSB3aWxsIHBvc3QgYSBzbWFsbCBQUiBsYXRlciB0b2RheSwg
c28gdW50aWwgUGV0ZXIgaGFzIHNvbWV0aGluZyBlbHNlDQo+ID4+IHBsYW5uZWQsIEkgY2FuIHRh
a2UgaXQsIHNpbmNlIHRoZSBwYXRjaCBMR1RNIG5vdy4NCj4gPg0KPiA+IFRoYXQgd291bGQgYmUg
Z3JlYXQgKEkgZG9uJ3QgaGF2ZSBhbnkgbW9yZSBwYXRjaGVzIEkgd2FudGVkIHRvIHB1dCBpbg0K
PiA+IGEgUFIpLg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IFBldGVyIE1heWRlbGwgPHBldGVyLm1h
eWRlbGxAbGluYXJvLm9yZz4NCj4gDQo+IE9LLCBwYXRjaCBxdWV1ZWQgdGhlbi4NCj4gDQo+IFlh
bywgZm9yIHlvdXIgZnV0dXJlIGNvbnRyaWJ1dGlvbnMsIHBsZWFzZSBwb3N0IHBhdGNoIGl0ZXJh
dGlvbnMgYXMgbmV3IHRocmVhZA0KPiByYXRoZXIgdGhhbiByZXBseWluZyB0byBwcmV2aW91cyB2
ZXJzaW9ucy4gWW91IGNhbiBzZWUgdGlwcyBoZXJlOg0KPiBodHRwczovL3d3dy5xZW11Lm9yZy9k
b2NzL21hc3Rlci9kZXZlbC9zdWJtaXR0aW5nLWEtcGF0Y2guaHRtbCNzdWJtaXQNCj4gdGluZy15
b3VyLXBhdGNoZXMNCj4gaW4gcGFydGljdWxhcjoNCj4gDQo+ICAgIFBhdGNoZXMgYXJlIGVhc2ll
ciB0byBmaW5kIGlmIHRoZXkgc3RhcnQgYSBuZXcgdG9wLWxldmVsIHRocmVhZCwNCj4gICAgcmF0
aGVyIHRoYW4gYmVpbmcgYnVyaWVkIGluLXJlcGx5LXRvIGFub3RoZXIgZXhpc3RpbmcgdGhyZWFk
Lg0KPiANCnRoYW5rcywgSSB3aWxsLg0KPiBSZWdhcmRzLA0KPiANCj4gUGhpbC4NCg0K

