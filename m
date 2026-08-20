Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F49C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 07:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwxAh-0003Me-AR; Thu, 20 Aug 2026 03:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwxAe-0003Lw-74; Thu, 20 Aug 2026 03:26:40 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwxAb-0000QW-Vy; Thu, 20 Aug 2026 03:26:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPfhjKCF6Qz2p4J9F9fhhdLSy0DZ0NJIKW6qyofuL3u7bI1TwHM/vl+80FcdeD5iL1FkzR5aA0t/Ct29ieqdcd4tLHl2MEG1OEGWjqQpq4ZKxnZnkS9sjjsthztBcQfXwWLr3gpi6EG37MF9ifT6lphKQv0ZToc8LpUEaB3W3JSEVWbOzl4nPwsARG9iD+OohR6Pqeylc0PLyw8207tPcaJsE1S420IC0V9IusxhXmwzrEqRu54TmakTnsMAc4jez2Jp8rLcbQDgT42iG579yFFJ+5UJvjq5EuswagUMeTnVZXULlEynaSbklQhlSt7jLVlVfSQpm5BgqCZgHcWtzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olPuIuqpBCAKuQwnESfjOes6EKNA609c9FXGCQZjv9E=;
 b=DCbUuqUEIbc8/DEMSaY/VlvOcEXPerECZOlgc/1GIDAaJJS745Rt/HHx2kyfvztEi7+zuFnl0GLt7trMKeyD+TvgGjexBVCfP/uBHYWanXqdOHFvyGI88ZX1jXo+MyO2NaDKD4CoFStUYQyOLldlffQZasPCAavk54mMG5wGjtVDuIdjmeXWiadQYBbhM7zBNi4PAY6WQpNJ3TrS3yo3UyO79dlcPVpF/3+azFrBYWUbiwrhk8bVKoTFhRWov0D5MtWT9gex+w+SYzOgFMDqaM16Ehb6CHL0X7jREY+M9usrTA/SiBMELOKrm+exfVjV6nPt1NFgEUsllPTKxmL68A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olPuIuqpBCAKuQwnESfjOes6EKNA609c9FXGCQZjv9E=;
 b=hFum3FEA1uTN6zMzzjj2VLRCJUtvZfrzydWt235tm/L52Mkj0CNyeqQyn5mdpY5ISk1YjTGKyP/DdVa0G+hiZbLe1iPIDKl/Ywkefk26DmNM7WNmN+ZwZ42myaiGOzXDD+kpbV1L5ml7b1ZKUp4aaEzfpNw1ufWuhMIY4EDjGledY4F2/sfLCZyX0AO/n+P/4m2HIYbXOuYOjH73VCAkkhEg1hLSFIdbXuEmaEtyDnIocsyTSpdhT9HLSimEUOLcWYJdcRYRIHYa43s3BVJhzpIcCemp8Z3keVkEzQyuHacV5gBqrLsZ5zSnK3Pmq5ER2pbS+y0OSUKwEPjP/SbuMA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE3PR06MB8667.apcprd06.prod.outlook.com (2603:1096:101:332::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 07:26:31 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 07:26:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 0/5] Add ASPEED ACRY RSA model for the AST2600
Thread-Topic: [PATCH v1 0/5] Add ASPEED ACRY RSA model for the AST2600
Thread-Index: AQHdKuxUpCU4mynNDESozh2F5CGNJLal2NCAgAC7oPA=
Date: Thu, 20 Aug 2026 07:26:31 +0000
Message-ID: <TYZPR06MB4980FF77730999B1B51EEF1AFCA42@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260813062359.425268-1-jamin_lin@aspeedtech.com>
 <84e7fdb4-1ff1-4301-b145-ddcab7582685@kaod.org>
In-Reply-To: <84e7fdb4-1ff1-4301-b145-ddcab7582685@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SE3PR06MB8667:EE_
x-ms-office365-filtering-correlation-id: c9a1a0f8-4255-4cf5-a757-08defe8c5b29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|38070700021|921020|56012099006|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: 2OKTJ2PkEn3W9qmGflrpBIX2Uk2FGMp7VvDkL4Lx7GCtd5y9+MGICBe9Cv7U04Pa0L78llCJEf6qPyDRAGuvHxe5q+LGIICyD2G5mb2BCMT61ql35J2nU/jBWz+n1Gg97tyynuMstcYRA3qcnRxX/FVE4F8/nYE3rvIyWt5RAbSogMQZUNiEAawwqlbKi0RZ6GZWCfmi2UuqlwoFmi9nn0x6rMhsMyJHcaI3yjFKU+ssB0g9LxwDpAUVdN78AO2PFKLE1O3jlC5SQFtom6z69O+HfTwbA2g9YFksMs+TLHAvpeMLIuFHi7JiXoNaD8pAhf8/lVGBrypM8ZLpOqXRkIGDrCpGLC98UQdXylPmbOiX5wV/se1okeOCsQRwYx7JddKSPONL9r/iUNUtyH7TDpUX0WEJ3SfdiSoRkGUiB35lQHIDEefthNRqkT1p1K6mRtV9/b2seDRLJOVlja71rRqamhXfnSnNml2IN/GkRT9YEBl5eKBBrSmnsdwLJmJfzfmn/42Qp0SJklCzV1sQsm0A4WCLyxxSwIGnGdAptieO8r4KVAOIxfot1c7P6R+fXTGd5fTvZaqYJinzyQAYIPkFBMRrkwWholyU+IESIIMzjdY0AkIz2d8HN4bpT1SrveVXgqwqYYvhTgBLcOE8kjzk4hSNJxJrHEC5M0OnyD95Ivbt282COoLk1NSkmd1x30W5FoTMqpslBpDfI8zbMnWGmzBK0kYZFuQ+0cb0voSWyrv0l813nHczrvdFJlW8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(38070700021)(921020)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHFSRG14WS9pMEFBSEloK2lickt3WWc4NFpackZYRFJjcUFFem5tM3pMZHV5?=
 =?utf-8?B?T2EwYWcydFh6RUt5UWNOV2dqRzluR0pKRUZKYW1QQ0ZFOUwyMUVaekpZc1dU?=
 =?utf-8?B?cW1mQ3ZXaEpYMVhlbXdpT05LcFBMK2xNc1Z5ZG9yWjFiTVl2Uk1mTll3MDRm?=
 =?utf-8?B?U251Z0VIYlEyZm9BZlVrcWZ0MndVUDlkNUFvOVdHKzFWWktIQzJRYVlmU1d4?=
 =?utf-8?B?alBRb0FDbUREYTNMcm9rN2ZhakxFb213ZXZhbTBVa2FCY1NDZ0RxVzhGQmdy?=
 =?utf-8?B?amFtRmxXN0J4Zkd0d0J5VFFkOWdWV1A1WHlqbllFcXpjd3lvYlBIRWZxUUlz?=
 =?utf-8?B?em5DQXhMQ3pMcDkwUVYrZkJhQkJoOFgxQXZQU2VOUnIvVEJ4OEhyMVZlK0Iw?=
 =?utf-8?B?QXBtR3lwWXkyYml1SHhuTHU3VVcrdFMrem12MVRKNjNnU2ZVNlg3elNKWmY1?=
 =?utf-8?B?YldQSGMxczVoWmVDRUw4U245NjdvZmU3Zmtlbno3dEtzNDNZMkdpYkEyRWZW?=
 =?utf-8?B?a3RENmt0QUZPbXhaODQvaUVKUktZc2d3SDZuWW1LTWt6ZUZjVENYK3A4NTRq?=
 =?utf-8?B?Z0Rxc203dHZzdi9RWGNuc0xuanFDSXhrdjNPQm1senp4TlFsb3JHME90RkNX?=
 =?utf-8?B?UEs1eWRFSStBckRaRVFKb0I5RDAxQzBRNFhrYzNZRVBva3VId0hHcnFjTG9s?=
 =?utf-8?B?Ui9SK1B4OW9YTkd2QkI1cDVLbHdMc3VtNzIzSEMwTkVacHJIL0JUUHdYeVY3?=
 =?utf-8?B?dk1TT21Kb29PYVVVMGJCcDIxeTF6SDR0a0l2Y3FBb0s1ZTl0SUwySVVOejRB?=
 =?utf-8?B?bHJmS3dyTzRsdFIydmZIZ1ZsZU1vOHV4SXYvbTBMYVYwSTE2MWcxQVRTb25l?=
 =?utf-8?B?Z09EUnZpUWk1WVhWVVlaVCsrZnpzdXU3NHRzNysra2lRZm1OaEhYMGMzK3FV?=
 =?utf-8?B?bFlZY1JnR3A4WU1tLytIMytwS0N1UzBRSXorbmk5UGIvSXFLY3F5VUhyYXVu?=
 =?utf-8?B?UWxTNHpmemxZM3BDVzdJclp2OE9pVFhYM1AwY2c5UWZNNklEWkVUaDBqUmFh?=
 =?utf-8?B?STNvLzVXcjNzVWp1Q1VTdGl4ckxndVptVFh3Rmw2a2dmdkZzU0IxY29EeVo0?=
 =?utf-8?B?QnlGSmo1MHY5NkRWQnVRa3FEYzNhd1ZSUU1CSTM0V01qbWVxQnZiTEQwR1Nw?=
 =?utf-8?B?R3FVclMzYnBrb1ZJenJ6N1lKZXNkQ1IvZmhwVXh5cm00UEVZeTlWNCtIdmFR?=
 =?utf-8?B?R2pzMmM3TlJNdTNoRWw2TUFhMXdMRGZpZENCK3FqOFdIbUJNY1RIKzBiTTBM?=
 =?utf-8?B?ZWRSTW5BMGR0SC84bllnaXdlOW9scUxyc3RVQ0xYN2RmR0N4ei80U3ZwTkZy?=
 =?utf-8?B?ZmhXTVlIRHk4cUZHVHhObmxOVHR5N0cyL3NnU1RYY1cvb2g1ZmNyREpVbUhR?=
 =?utf-8?B?WjJkUG5JQU51aGZhZmNNZGliTnZWNDBVa2MzVFVDVDN4SWJ2SnQxcmlvWDVp?=
 =?utf-8?B?ZE5tMHpKQzZZMGV2NkNvWTBzUTdiTXI5Z1YwVWJ3bzQwenFReEVrL055aTIy?=
 =?utf-8?B?MnlId3FTb0hOcVNQNVFqWEdvRUovMUVONXFhM1FaaDYveXFKTVJ3cmtEa0hy?=
 =?utf-8?B?c3laWlZINm1UV0lzUGxrU1RLRk8vWW5nUDJjOG5mV2xjNnduUmg2SFZQWEUv?=
 =?utf-8?B?Q2M4YlM3TCthWUxYYUdkM09zaHdmdG94Y2JjRHl0WUZwd2VjcENjQ2JDOHlC?=
 =?utf-8?B?dWkyT0VPYVFKWFo5L1dBZmVzUGZKRnloVjcyZjROK2JLK2hIY1ZRSXJtZ2JR?=
 =?utf-8?B?MVBJMWtEWHVtczBMTjFFZzBEWERaZzJFNmRjUW1OM2IwQmt2MlM5OUpqZmg5?=
 =?utf-8?B?VmN6TWhNL3RoQnpwWWdYRU55KzNVNlR1bHBvQ0J5UzBzWUIxOVJmTjNlR2Y2?=
 =?utf-8?B?VkMxNk1PWWFFMFU1M2lUbGFzLy9WWVNtdWdHQzBOeC9yYklmbnFzbG5mbnlv?=
 =?utf-8?B?VUZabzZaeGJEZmgrUjdhZXAzNkpkR3BrbU8wT3dreEVwOVRwSWQwWUk5VGM3?=
 =?utf-8?B?SUcvMGFzRWdkM3BjTGQ2MzJ2eTRhVjF1WFNkaFJnQ3FDV0swUkRJbmNXMk5v?=
 =?utf-8?B?MVF6Q0FORUhwdDFuNXlJR28rdnZjNDJaVWFTZnk4TktFMmxRSTB6ZWtFWE5R?=
 =?utf-8?B?Ui9Qbmx0NDdzWFZEbURlVFZJRXhWOXpUOUErM2UxaWJRdUo5NjBsRGR2bXlF?=
 =?utf-8?B?QmVqbkVDZHFuQ2xFYmtwMHlpU1h3L1h2N09rbm1iV1ArdVovR2JEcEd2enl6?=
 =?utf-8?B?YWx2Q3RYZVo5OUJ3czlBa21QeWVjOXg1a1dZV29jQkFTb2JkM0p2Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ea2i9XD4bnr/H5+jTaYxCDLm8u3pNahOaOJj+Q+YMfhzgtYSiej7KH2my1XvzEqOqsGZllN0UCeWMHhV5ADdPS8gDqiC0JYQD+VUkMz2Apq4HzM5+k5Y3qxUDojd3Ci4pu3iUew/uqzX4QVTsdgU8nYzkYKwFH1u1Kv+JPalgmtU0Oc00M2H0O25uBaNfkA3dVVeYoZESoA7LNnW9T9bMYoVS6S0HDmBamBYpCN0I0OnI4/AWPihbv5jY73x3Q396PRlr2JgDA1AWgzg5idphv+ziETy8ecm9znc4UYS/hUNhucxHx+HQ4kYDPa9xpxDRxXompWvYrEfp9UuI7QtgA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a1a0f8-4255-4cf5-a757-08defe8c5b29
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 07:26:31.0849 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8JU1LfSRjoZlFp8VyUBVr3m7ULDw7DssfhgckzN1G2Oi3dQFQDUjQkA01gMsvSG0aEYt3PLKZ3ut281LHRNXqt6w9m9QrN8dQHLrFfX/rIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8667
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

PiBsaXN0OkFTUEVFRCBCTUNzIDxxZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBw
YXRjaGVzIENDIGhlcmUNCj4gPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVl
IDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAwLzVd
IEFkZCBBU1BFRUQgQUNSWSBSU0EgbW9kZWwgZm9yIHRoZSBBU1QyNjAwDQo+IA0KPiBPbiA4LzEz
LzI2IDA4OjI0LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gVGhpcyBzZXJpZXMgYWRkcyBhIG1vZGVs
IG9mIHRoZSBBU1BFRUQgQUNSWSBlbmdpbmUgZm91bmQgb24gdGhlDQo+ID4gQVNUMjYwMCBTb0Ms
IHdpcmVzIGl0IGludG8gdGhlIFNvQywgYW5kIGFkZHMgYSBxdGVzdC4NCj4gPg0KPiA+IFRoZSBB
Q1JZIGVuZ2luZSBwZXJmb3JtcyBSU0EgbW9kdWxhciBleHBvbmVudGlhdGlvbiAoYyA9IG1eZSBt
b2QgbikuDQo+ID4gSXQgRE1BcyB0aGUgb3BlcmFuZHMgKGRhdGEsIGV4cG9uZW50LCBhbmQgbW9k
dWx1cykgZnJvbSBndWVzdCBEUkFNIGFuZA0KPiA+IHdyaXRlcyB0aGUgcmVzdWx0IHRvIGEgZGVk
aWNhdGVkIDY0IEtpQiBTUkFNIHJlZ2lvbi4NCj4gPg0KPiA+IEd1ZXN0IGZpcm13YXJlIHVzZXMg
dGhlIGVuZ2luZSBmb3IgUlNBIHNpZ25hdHVyZSB2ZXJpZmljYXRpb24gZHVyaW5nIGJvb3QuDQo+
ID4gV2l0aG91dCBhIG1vZGVsLCB0aGUgZ3Vlc3Qgc3RhcnRzIHRoZSBlbmdpbmUgYW5kIHdhaXRz
IGluZGVmaW5pdGVseQ0KPiA+IGZvciBhIGNvbXBsZXRpb24gaW50ZXJydXB0LCBjYXVzaW5nIHRo
ZSBib290IHRvIGhhbmcuDQo+ID4NCj4gPiBUaGUgbW9kZWwgdXNlcyBRRU1VJ3MgZ2VuZXJpYyBh
a2NpcGhlciBBUEkgdG8gcGVyZm9ybSByYXcgKHVucGFkZGVkKQ0KPiBSU0EuDQo+ID4gUmF3IFJT
QSBpcyBjdXJyZW50bHkgc3VwcG9ydGVkIG9ubHkgYnkgdGhlIGxpYmdjcnlwdCBiYWNrZW5kLiBX
aGVuIGl0DQo+ID4gaXMgdW5hdmFpbGFibGUsIHRoZSBlbmdpbmUgc3RpbGwgY29tcGxldGVzIGFu
ZCByYWlzZXMgaXRzIGludGVycnVwdCwNCj4gPiBidXQgcmV0dXJucyBhbiBhbGwtemVybyByZXN1
bHQuIFRoaXMgYWxsb3dzIHRoZSBndWVzdCdzIHNpZ25hdHVyZQ0KPiA+IHZlcmlmaWNhdGlvbiB0
byBmYWlsIGNsZWFubHkgaW5zdGVhZCBvZiBoYW5naW5nLiBUaGUgcXRlc3QgaXMgc2tpcHBlZA0K
PiA+IHdoZW4gdGhlIHNlbGVjdGVkIGNyeXB0byBiYWNrZW5kIGRvZXMgbm90IHN1cHBvcnQgcmF3
IFJTQS4NCj4gDQo+IE9uZSBjYW4gc3RpbGwgdXNlIC1EZ2NyeXB0PWVuYWJsZWQgd2hlbiBnbnV0
bHMgaXMgaW5zdGFsbGVkLg0KPiANCg0KV2lsbCB1cGRhdGUNCg0KVGhhbmtzLA0KSmFtaW4NCj4g
Qy4NCj4gDQo+ID4NCj4gPiBBbHRob3VnaCB0aGUgaGFyZHdhcmUgZG9jdW1lbnRhdGlvbiBkZXNj
cmliZXMgYm90aCBSU0EgYW5kIEVDRFNBDQo+ID4gc3VwcG9ydCwgRUNEU0EgaXMga25vd24gdG8g
YmUgYnJva2VuIG9uIHRoaXMgaGFyZHdhcmUgYW5kIGlzIHRoZXJlZm9yZSBub3QNCj4gbW9kZWxl
ZC4NCj4gPg0KPiA+IHYxOg0KPiA+ICAgMS4gQWRkIEFTUEVFRCBBQ1JZIFJTQSBtb2RlbCBmb3Ig
dGhlIEFTVDI2MDANCj4gPiAgIDIuIEFkZCBxdGVzdCBmb3IgQVNUMjYwMCBBU1BFRUQgQUNSWSBS
U0EgbW9kZWwNCj4gPg0KPiA+IEphbWluIExpbiAoNSk6DQo+ID4gICAgaHcvbWlzYy9hc3BlZWRf
YWNyeTogQWRkIEFTUEVFRCBBQ1JZIG1vZGVsDQo+ID4gICAgaHcvYXJtL2FzcGVlZF9hc3QyNjAw
OiBJbnRyb2R1Y2UgdGhlIEFDUlkgU1JBTQ0KPiA+ICAgIGh3L2FybS9hc3BlZWRfc29jOiBBZGQg
dGhlIEFDUlkgbW9kZWwgdG8gQXNwZWVkU29DU3RhdGUNCj4gPiAgICBody9hcm0vYXNwZWVkX2Fz
dDI2MDA6IFdpcmUgdXAgdGhlIEFDUlkgbW9kZWwNCj4gPiAgICB0ZXN0cy9xdGVzdC9hc3BlZWQt
YWNyeS10ZXN0OiBBZGQgUlNBIE1vZEV4cCB0ZXN0cw0KPiA+DQo+ID4gICBpbmNsdWRlL2h3L2Fy
bS9hc3BlZWRfc29jLmggICAgfCAgIDMgKw0KPiA+ICAgaW5jbHVkZS9ody9taXNjL2FzcGVlZF9h
Y3J5LmggIHwgIDUwICsrKysNCj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0MjYwMC5jICAgICAgICB8
ICAzMyArKysNCj4gPiAgIGh3L21pc2MvYXNwZWVkX2FjcnkuYyAgICAgICAgICB8IDQ0Nw0KPiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIHRlc3RzL3F0ZXN0L2FzcGVl
ZC1hY3J5LXRlc3QuYyB8IDQwOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAg
IGh3L21pc2MvbWVzb24uYnVpbGQgICAgICAgICAgICB8ICAgMSArDQo+ID4gICBody9taXNjL3Ry
YWNlLWV2ZW50cyAgICAgICAgICAgfCAgIDYgKw0KPiA+ICAgdGVzdHMvcXRlc3QvbWVzb24uYnVp
bGQgICAgICAgIHwgICA1ICstDQo+ID4gICA4IGZpbGVzIGNoYW5nZWQsIDk1MiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9t
aXNjL2FzcGVlZF9hY3J5LmgNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9taXNjL2FzcGVl
ZF9hY3J5LmMNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xdGVzdC9hc3BlZWQtYWNy
eS10ZXN0LmMNCj4gPg0KDQo=

