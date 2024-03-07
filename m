Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AAEC5475B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 02:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri3hi-00038g-ED; Wed, 06 Mar 2024 21:41:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ri3he-00038H-8p
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 21:41:50 -0500
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ri3hb-0008BS-UO
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 21:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1709779307; x=1741315307;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=QcOKru82/xw4e3p5SZDS7aKG1Qii+CZXjAy95XDiwYQ=;
 b=XPRoTwGp120nMfUbUcJLQPjskpM0N9+hpPog/RdrHlt1arNh29XlUc7D
 fNYiK7Rw5PT333keBTlE47CxJewFsJGG5Rkhed/6vK41ht1DR2EWJCu4x
 pCyORaW64d2pOKTqIbC4Ou2tVE1vny0DWRNH9933mb6FKjzeWhDsjCClr
 KtemrGBnZCcRpTyMoa2G+coocO0aa89Q/PgW5XZ6ZoEN9EMnHLlC5L3Eo
 7C2qH7x2FAh+91mAzlqq0/kNMZsJHKy6sCra3OLHoZ9fMUXGZ+Igu5AMs
 6OSQ+YTh6sCyct7qwAb7hQMm7KGI8IGuggmFWYYJzypdX8JlaisntmyNB g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="114030373"
X-IronPort-AV: E=Sophos;i="6.06,209,1705330800"; d="scan'208";a="114030373"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2024 11:41:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyRqaCE5WuEZhFmeGW5jQQwnI4npITQbGyauBcVj9fyOnZ9UJ2fT/aNb96t0rxfdW2AdUf5HljvcLgigziCcsd596rnt42f9k3OIrc7RbuEZ+PgIvb+yC5wZm5EIoX0kIv2YledJ2eKV1eu7m8a7v8EnQnH9GFy3FR03o6UHoQhHoWgKxYTSvwI7YauMxCs4vYKh6mNuhKRtxEznC4rMxSWkZ5/yAJT++HZluKhwp8FqAphIUwomnkliadpmFdsI7DN5B8n2X8zPTUL8GyQn9SAJ5nQ+CZp+4BuHIB7iaGPEZ5YHzzD1QZRDMSvHyIXD/R53/7/s2u8zuTcdV7Hn5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcOKru82/xw4e3p5SZDS7aKG1Qii+CZXjAy95XDiwYQ=;
 b=lswSmB9/EowTmtrXk5GaPFG24m+k6+e4rJVtOV5Ov/9pjNxADwFB4EeHzR1XPx1VUzSvpnMnmhVu8SvY2wq14FdhcoWcZEOa0AmY69lonRb9vJQQWV5jo21WmF7aslLKIaFGlzseEyZga/2D2AVaiPzhYCpU4F7d9z8A55hMNV4NgAr80zCaIkCTHkJAIvMaRP8IJwrRSgpNcXS/h45yFMCRdUi8MyJsrDrETL2zAZsD/t37xDdPlYO5NgfZQE3aGxC11y8HONzqi2IHu5Y4XgUmYZ27FSOIOherwNcJNlqFAdoXoKTt28Tu42cl4v5+o6x6qFnuqxJwte7PVMAlPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB1905.jpnprd01.prod.outlook.com (2603:1096:603:15::14)
 by OS3PR01MB9318.jpnprd01.prod.outlook.com (2603:1096:604:1c6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 02:41:38 +0000
Received: from OSAPR01MB1905.jpnprd01.prod.outlook.com
 ([fe80::74c6:da1:e8d5:49bf]) by OSAPR01MB1905.jpnprd01.prod.outlook.com
 ([fe80::74c6:da1:e8d5:49bf%6]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 02:41:38 +0000
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Yu Zhang
 <yu.zhang@ionos.com>, Het Gala <het.gala@nutanix.com>, qemu-devel
 <qemu-devel@nongnu.org>, Fabiano Rosas <farosas@suse.de>, Peter Xu
 <peterx@redhat.com>
CC: Jinpu Wang <jinpu.wang@ionos.com>, Alexei Pastuchov
 <alexei.pastuchov@ionos.com>, Elmar Gerdes <elmar.gerdes@ionos.com>
Subject: Re: Problem with migration/rdma
Thread-Topic: Problem with migration/rdma
Thread-Index: AQHab0TXYpucrQ/C2kiIvKCQ3mii3rEq6K0AgACquoA=
Date: Thu, 7 Mar 2024 02:41:37 +0000
Message-ID: <a0d9e2c2-3687-4b7d-8fac-887ce262c38a@fujitsu.com>
References: <CAHEcVy7HXSwn4Ow_Kog+Q+TN6f_kMeiCHevz1qGM-fbxBPp1hQ@mail.gmail.com>
 <04da4267-8fe8-4653-90a2-f64e3be64037@linaro.org>
In-Reply-To: <04da4267-8fe8-4653-90a2-f64e3be64037@linaro.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB1905:EE_|OS3PR01MB9318:EE_
x-ms-office365-filtering-correlation-id: 51e05480-862d-4c9f-a5cc-08dc3e501cd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v2UhvggU12vXN337hIBGqfMj55ocWoy7k4ubhiVfgGt/p/j4BSUo861nzWJVci+v75E3TFB0XkqHCKlK3ABcVJA/+sszJlQjWQVhr69tYhQsaAYdeLGsk/hr1eHr5WsnhuFYF0O03zX6j7Sry/Yip+wYDu8AL2FRAHfCZSmq/9t5u1eS9tcQI2yzcBUT5jK2k9B7McmLdkTCw2VLhHZSGislHg/835wM9JQEFpSiGtICKqh2inTKkmVzSKso7WcDjarf0YIPjuGj0mYIC8578y5m1yPaSTB1erIgvQo3XJcCTA3rwLbbKcxiBmsOJJA1Y0jn/Zzv21sVbGgy951m3EWoQZbVwJfA4HsvRHKgiDoYda5FwwcDKlk4e0FMwa5Cx4ZinFlrWQj28LpWSIacAxd+oPKG9dat95sRS/YI76kdy1IZCC81YqO3sBjfnzwNu+lgbF6Pe6pW22tzmmSnTBiS41TOz6QIxuQ9Bn9Fe7DFdDCJwJjj+1bxW9zZR4Z3Q2CSNacmkRIghC+B3FNMSgfI/NmK40qo5rXhsJd4wZra2lnVu20KGSuq6Rh9CJ+gVlLtDt5/5xJ1u/j6NsX+jaVwgpWAogK5htAomNkSttIiQieDWJQlOmHrTH4gMNyJ7lODDRQsgxLJ9yFjloo4CeUmk4ItagPjSejMSQGhSzsKqCK8H+P+1HqJdy3kT4vIuaxhj5NArb0uqWvB/TtPOPQxhB38KxObjm0o7Lbxbqm/CDZ/wc1vFa22QhP2wGoJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSAPR01MB1905.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009)(1580799018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STV5ZGhGMi9CczFPMkJZRmUwZzhFV0JObWl2MlZ6VVdBNGQ5c3MyYThaQXAv?=
 =?utf-8?B?SmFPUEhSQmgvL0lMbWV4bEc1Y2duWWpwbEVOSXBMUjBaYjFFM3R2VkNyQVlB?=
 =?utf-8?B?MEp3alZZSU5ZZ1o3bENQUUhPcXhwTVdOakdCdnFPSG9HSTNrZEZ5aFRUSzBD?=
 =?utf-8?B?M1VZL3JaMnpxTjJEYkRveFR0NXU4c1VCNUFwbVlOSmszeUllUFQ1YVI5eHkr?=
 =?utf-8?B?WEdkRlI3K2JNOGcvb1RINllPQ3RoSlpMbnBrUXhNTmNjWDVWaFBkYXUwd3B1?=
 =?utf-8?B?ajZrUngwZUV1TG14YnljQTlJNW5uWDlIOXNBRzl6SXRBUkYvN3Q3UkVJbXFW?=
 =?utf-8?B?MnhPRzdOcHVONVNUQ0IxVTFFQjF3Q1NSVi9vbTFFMGZVeFUrbTdzTVRCd1gv?=
 =?utf-8?B?SDVKZHdneld2QUhpZGs0NkZCUmsyeDZ0WDZsT2hxbWpsRCtGVmdBZ1E5SnVQ?=
 =?utf-8?B?Q2pReUNPYzZrZXhLOWJSVjlFVUtMV3h6d0wvSDhtd3BGUFNZQWV6VGpPcTRJ?=
 =?utf-8?B?K1RrY0IrdkJlbEtqM05IM0UyV29CdkNxS3dZbCtTTUFYeXA2bEpxS2NHakNy?=
 =?utf-8?B?K3poR0ozSldmRHdiWXd6bm9TT2RVOFNqSHJmUUhUUzBiOEpUNmRadnU0Kzhh?=
 =?utf-8?B?QzdtM21LT3ZJWUlLeG5pRG53S0V1RFo4TUExWTZJOExlK29YNnRsSExrU05Q?=
 =?utf-8?B?bXQyNWRpTkN2ZmMwUVB3ZzBjS0VaMWtvU2hSR0RHYU82VjFqcjVVNXU0dk9v?=
 =?utf-8?B?NW5DNTFsbWZiSlZnVk4wZ0tlbmpiamk2c25sRGJpN0pDK1FtQm51OGx5VjNJ?=
 =?utf-8?B?Y2tmV2xuN0txQnRhRXlWZVROdjJQcHdRa3NZV3Q5aGx4SG1rVlBHais3T01h?=
 =?utf-8?B?Zk5GWXhuVU1BeG1CRzI4cVo1azdJY3o0ZHorYUZocXdWSS90SzZjNTJiR3Jh?=
 =?utf-8?B?REU3QWN2NXMxRGZmVHFtMTRJSTg3Mm95YXJxZmJVN1lOSXByTVRYVEszQyta?=
 =?utf-8?B?NkhmTzlQQ0t4NHgrSndDL3JtWGNWQms4d09ZNmt5V0FTU1RaUU9LY1pwdDhY?=
 =?utf-8?B?VW91OGdYNXB2NWI3Nm1NYmZTQVZMdTFGVkwrZ2ZBMituMWRRT2JMMmFka0Vr?=
 =?utf-8?B?d2hqdEllb29zVncrYWN4ejdhWVA2UGpLMDNONHFtNkZtM0hXN1hTVG1hWU9R?=
 =?utf-8?B?amF2QjExdGttVFRDdDdPSDU1SmNZNzgxcGh2UjFCck1KaWh2VUxwK3lUOTVh?=
 =?utf-8?B?cThweXYxTjRCZmpyL1hqL3h1Q2Zzek5KN3pVMTJ1V1M2a01UZ3dyWmRBT0pV?=
 =?utf-8?B?eFdPcjY3Tmx3bTkwN0p0aDFlOS9vckxDRnhiczFKNUV1SHVGakZLbUJjUXJu?=
 =?utf-8?B?UGtYWDMzUzVpUDNlcG10T2x6dWlYajB0U1BMQ0NEZlB3QWpmMGV4SmkwNDJY?=
 =?utf-8?B?SnlxMHpjaHpLYUYwQ01EK05vZ2Y1L29ydTZ5OEhrOUxDZkpaSUlxSE80RTZG?=
 =?utf-8?B?QUZvZFZxaWo2YUhvRVQxNkhEejVaQytNV2hkS3ZjdHhEWjJua3QwejZDL0F5?=
 =?utf-8?B?YUJEdjhyMmFDNmhiSlN3MGZlS3VvUTlBZ05nT0NjOThXWEVBQzBBRHBCN2o1?=
 =?utf-8?B?MWZJWHZEZTNUWGQrVTNKZ1doUkkyL1dFbXc4cUZBVzBVR2tLQXhFM2p0UWdK?=
 =?utf-8?B?eG0vWTZCRitBTFRjeFlrSDB1cUt4VkFSTFFyRHlVZEdrazVoa2sxSkxDQS9n?=
 =?utf-8?B?VnBoQU15Z3NmZ0x6eUdFTHNxeEcraEZoemc3NFdwdzF3cGZjMlc4R2E0UnN1?=
 =?utf-8?B?U3F3ck1zWHJjVURYazRycDRMM1dteGZYejJFSDkzMDU0NUR4aHdwV2g1ellv?=
 =?utf-8?B?ZXFNSVRVbVhOaG15N3c3U1hQNWk3S1hZVWtKWjA1Mkp2bnNCdnAyVHIzS1NO?=
 =?utf-8?B?Ymx3MWUveHpxSmsxTFVTOW1Jcy9QTGRiNjdpMWFwMWF5UFROMkF6UWpibU00?=
 =?utf-8?B?SllSK1pFUDVhMURSMkVld0NHMXFKZ0pEYldIUkNBVldMR1BXcjd2Ylh0dVk4?=
 =?utf-8?B?alJlb291VXBhdE5XcUg4UmdaUEszbUsvYWVSUzBaZGptZCtjSGQrSUlrSHNw?=
 =?utf-8?B?ZW5FWU5INnRvRUFQN0pHWE9kb1oxdmpVaHcyUFlrMkhTQkRNWkQxK0V5Y2Q0?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E3B196939E0B94394007131D7B0433D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YVHQG/noK4pd0Dw6nC5l/A/eaWBkE9Sl6qnXsipd1HfKInxn9/OwmZ0/2FW06jMEZBSnZBzHDEySlrcbJN0pwY2RJQcV7XFt+nmpJPbXgeqgVdjRLFvlAFMWIUwNL0hc5EfPMDhMoAFiEOIL9OgGjTNTb/roj2DGpLCMlVhDu8o5/09yajvqaph/jWdBB25DKhpHeyjnQ96V+r+V5mbwAw3N3BKLGGUwh5Q5CZH+LozI3J8ZwLRb9qob2IQJ3ihy1+B3uon46nlOFVjS1nlytLvI4BmK/CUHtcPjjovRfhYwRz5aTHEMzsdi5iC3dDIDp7CpGmAlPLaDzSa36d8MbiMCs7mbVHSbVuAvZK6HkMxrEyVuPqSylGJ6nAikLbWly9SvLwM2cZSQySS7x92JO4W+K9+fYA3bt9RY/rxiyw3VC6sED2kzZaWHiJzJQ7PSZYockGGkyaVeDoOFmxMWEh9Ujxb33cVvx73kJR5ZpRcD7RBqCWONnZYIffuOI9gQsJjzhSC3bL4Dd9Ux3cW64nMWZeC2Y4p43rBbtq1PUxEq26GrERQz3ooO1RNaJj7W+ssZeUUcyAj4d64qDl4KrZtkrcEQsS+TbjhGY32ADpPbzzN2UK4eoj4BMv+FpmAi
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB1905.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e05480-862d-4c9f-a5cc-08dc3e501cd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 02:41:38.1074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oJrvq2OMUDxHfUl7tcY+52VdxPbvpKt/IT8yy7yKcfJiVjPXjM11IK8xc7HaER26aFpnDPKx8xF3QAuQh/pZmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9318
Received-SPF: pass client-ip=216.71.156.121;
 envelope-from=lizhijian@fujitsu.com; helo=esa11.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

WXUsDQoNCg0KT24gMDcvMDMvMjAyNCAwMDozMCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3Jv
dGU6DQo+IENjJ2luZyBSRE1BIG1pZ3JhdGlvbiByZXZpZXdlcnMvbWFpbnRhaW5lcnM6DQo+IA0K
PiAkIC4vc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCAtZiBtaWdyYXRpb24vcmRtYS5jDQo+IExp
IFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4gKHJldmlld2VyOlJETUEgTWlncmF0aW9u
KQ0KPiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+IChtYWludGFpbmVyOk1pZ3JhdGlvbikN
Cj4gRmFiaWFubyBSb3NhcyA8ZmFyb3Nhc0BzdXNlLmRlPiAobWFpbnRhaW5lcjpNaWdyYXRpb24p
DQo+IA0KPiBPbiA1LzMvMjQgMjI6MzIsIFl1IFpoYW5nIHdyb3RlOg0KPj4gSGVsbG8gSGV0IGFu
ZCBhbGwsDQo+Pg0KPj4gd2hpbGUgSSB3YXMgdGVzdGluZyBxZW11LTguMiwgSSBzYXcgYSBsb3Qg
b2Ygb3VyIG1pZ3JhdGlvbiB0ZXN0IGNhc2VzIGZhaWxlZC4NCj4+IEFmdGVyIGRlYnVnZ2luZyB0
aGUgY29tbWl0cyBvZiB0aGUgOC4yIGJyYW5jaCwgSSBzYXcgdGhlIGlzc3VlIGFuZCBtYWQgYSBk
aWZmOg0KPj4NCj4+IGRpZmYgLS1naXQgYS9taWdyYXRpb24vcmRtYS5jIGIvbWlncmF0aW9uL3Jk
bWEuYw0KPj4gaW5kZXggNmEyOWU1M2RhZi4uZjEwZDU2ZjU1NiAxMDA2NDQNCj4+IC0tLSBhL21p
Z3JhdGlvbi9yZG1hLmMNCj4+ICsrKyBiL21pZ3JhdGlvbi9yZG1hLmMNCj4+IEBAIC0zMzUzLDkg
KzMzNTMsOSBAQCBzdGF0aWMgaW50IHFlbXVfcmRtYV9hY2NlcHQoUkRNQUNvbnRleHQgKnJkbWEp
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfcmRtYV9kZXN0X3dhaXQ7DQo+PiDCoMKg
wqDCoMKgIH0NCj4+DQo+PiAtwqDCoMKgIGlzb2NrLT5ob3N0ID0gcmRtYS0+aG9zdDsNCj4+ICvC
oMKgwqAgaXNvY2stPmhvc3QgPSBnX3N0cmR1cF9wcmludGYoIiVzIiwgcmRtYS0+aG9zdCk7DQo+
PiDCoMKgwqDCoMKgIGlzb2NrLT5wb3J0ID0gZ19zdHJkdXBfcHJpbnRmKCIlZCIsIHJkbWEtPnBv
cnQpOw0KDQoNClRoYW5rcyBmb3IgeW91ciBhbmFseXNpcy4NCg0KSXQgd2lsbCBiZSBncmVhdCBp
ZiB5b3Ugc2VuZCB0aGlzIGFzIGEgcGF0Y2guDQoNCg0KaXNvY2sgaXMgZGVmaW5lZCBhcyBhIF9h
dXRvcHRyIFZWVg0KMzMzMyBfYXV0b3B0cihJbmV0U29ja2V0QWRkcmVzcykgaXNvY2sgPSBnX25l
dzAoSW5ldFNvY2tldEFkZHJlc3MsIDEpOw0KDQpJJ20gc3VycHJpc2VkIHRoYXQgaXQgc2VlbXMg
dGhlIGF1dG8gZnJlZSBzY2hlbWUgd2lsbCBmcmVlIHRoZSBtZW1iZXIgb2YgaXNvY2sgYXMgd2Vs
bA0Kc2VlIGJlbG93IHZhbHJpbmQgbG9nLiBUaGF0IHdpbGwgY2F1c2UgYSBkb3VibGUgZnJlZS4N
Cg0KPT04MDkxMzg9PSBJbnZhbGlkIGZyZWUoKSAvIGRlbGV0ZSAvIGRlbGV0ZVtdIC8gcmVhbGxv
YygpDQo9PTgwOTEzOD09ICAgIGF0IDB4NDgzQTlGNTogZnJlZSAodmdfcmVwbGFjZV9tYWxsb2Mu
Yzo1MzgpDQo9PTgwOTEzOD09ICAgIGJ5IDB4NTk4RjcwQzogZ19mcmVlIChpbiAvdXNyL2xpYjY0
L2xpYmdsaWItMi4wLnNvLjAuNjYwMC44KQ0KPT04MDkxMzg9PSAgICBieSAweDc5QjZBRDogcWVt
dV9yZG1hX2NsZWFudXAgKHJkbWEuYzoyNDMyKQ0KPT04MDkxMzg9PSAgICBieSAweDc5Q0VFNjog
cWlvX2NoYW5uZWxfcmRtYV9jbG9zZV9yY3UgKHJkbWEuYzozMTA4KQ0KPT04MDkxMzg9PSAgICBi
eSAweEMyRTMzOTogY2FsbF9yY3VfdGhyZWFkIChyY3UuYzozMDEpDQo9PTgwOTEzOD09ICAgIGJ5
IDB4QzIxMTZBOiBxZW11X3RocmVhZF9zdGFydCAocWVtdS10aHJlYWQtcG9zaXguYzo1NDEpDQo9
PTgwOTEzOD09ICAgIGJ5IDB4NzI2ODNGODogPz8/IChpbiAvdXNyL2xpYjY0L2xpYnB0aHJlYWQt
Mi4zMi5zbykNCj09ODA5MTM4PT0gICAgYnkgMHg3MzgyNEMyOiBjbG9uZSAoaW4gL3Vzci9saWI2
NC9saWJjLTIuMzIuc28pDQo9PTgwOTEzOD09ICBBZGRyZXNzIDB4MTNkYWEwNzAgaXMgMCBieXRl
cyBpbnNpZGUgYSBibG9jayBvZiBzaXplIDE0IGZyZWUnZA0KPT04MDkxMzg9PSAgICBhdCAweDQ4
M0E5RjU6IGZyZWUgKHZnX3JlcGxhY2VfbWFsbG9jLmM6NTM4KQ0KPT04MDkxMzg9PSAgICBieSAw
eDU5OEY3MEM6IGdfZnJlZSAoaW4gL3Vzci9saWI2NC9saWJnbGliLTIuMC5zby4wLjY2MDAuOCkN
Cj09ODA5MTM4PT0gICAgYnkgMHhDMDU4Q0Y6IHFhcGlfZGVhbGxvY190eXBlX3N0ciAocWFwaS1k
ZWFsbG9jLXZpc2l0b3IuYzo2OCkNCj09ODA5MTM4PT0gICAgYnkgMHhDMDlFRjM6IHZpc2l0X3R5
cGVfc3RyIChxYXBpLXZpc2l0LWNvcmUuYzozNDkpDQo9PTgwOTEzOD09ICAgIGJ5IDB4QkRERUND
OiB2aXNpdF90eXBlX0luZXRTb2NrZXRBZGRyZXNzQmFzZV9tZW1iZXJzIChxYXBpLXZpc2l0LXNv
Y2tldHMuYzoyOSkNCj09ODA5MTM4PT0gICAgYnkgMHhCREUwNTU6IHZpc2l0X3R5cGVfSW5ldFNv
Y2tldEFkZHJlc3NfbWVtYmVycyAocWFwaS12aXNpdC1zb2NrZXRzLmM6NjcpDQo9PTgwOTEzOD09
ICAgIGJ5IDB4QkRFMzBEOiB2aXNpdF90eXBlX0luZXRTb2NrZXRBZGRyZXNzIChxYXBpLXZpc2l0
LXNvY2tldHMuYzoxMTkpDQo9PTgwOTEzOD09ICAgIGJ5IDB4QkREQjM4OiBxYXBpX2ZyZWVfSW5l
dFNvY2tldEFkZHJlc3MgKHFhcGktdHlwZXMtc29ja2V0cy5jOjUxKQ0KPT04MDkxMzg9PSAgICBi
eSAweDc5MjM1MTogZ2xpYl9hdXRvcHRyX2NsZWFyX0luZXRTb2NrZXRBZGRyZXNzIChxYXBpLXR5
cGVzLXNvY2tldHMuaDoxMDkpDQo9PTgwOTEzOD09ICAgIGJ5IDB4NzkyMzZGOiBnbGliX2F1dG9w
dHJfY2xlYW51cF9JbmV0U29ja2V0QWRkcmVzcyAocWFwaS10eXBlcy1zb2NrZXRzLmg6MTA5KQ0K
PT04MDkxMzg9PSAgICBieSAweDc5RDk1NjogcWVtdV9yZG1hX2FjY2VwdCAocmRtYS5jOjMzNDEp
DQo9PTgwOTEzOD09ICAgIGJ5IDB4NzlGMDVBOiByZG1hX2FjY2VwdF9pbmNvbWluZ19taWdyYXRp
b24gKHJkbWEuYzo0MDQxKQ0KPT04MDkxMzg9PSAgQmxvY2sgd2FzIGFsbG9jJ2QgYXQNCj09ODA5
MTM4PT0gICAgYXQgMHg0ODM5ODA5OiBtYWxsb2MgKHZnX3JlcGxhY2VfbWFsbG9jLmM6MzA3KQ0K
PT04MDkxMzg9PSAgICBieSAweDU5OTJCQjg6IGdfbWFsbG9jIChpbiAvdXNyL2xpYjY0L2xpYmds
aWItMi4wLnNvLjAuNjYwMC44KQ0KPT04MDkxMzg9PSAgICBieSAweDU5QTdGRTM6IGdfc3RyZHVw
IChpbiAvdXNyL2xpYjY0L2xpYmdsaWItMi4wLnNvLjAuNjYwMC44KQ0KPT04MDkxMzg9PSAgICBi
eSAweDc5QzJBODogcWVtdV9yZG1hX2RhdGFfaW5pdCAocmRtYS5jOjI3MzEpDQo9PTgwOTEzOD09
ICAgIGJ5IDB4NzlGMTgzOiByZG1hX3N0YXJ0X2luY29taW5nX21pZ3JhdGlvbiAocmRtYS5jOjQw
ODEpDQo9PTgwOTEzOD09ICAgIGJ5IDB4NzZGMjAwOiBxZW11X3N0YXJ0X2luY29taW5nX21pZ3Jh
dGlvbiAobWlncmF0aW9uLmM6NTgxKQ0KPT04MDkxMzg9PSAgICBieSAweDc3MTkzQTogcW1wX21p
Z3JhdGVfaW5jb21pbmcgKG1pZ3JhdGlvbi5jOjE3MzUpDQo9PTgwOTEzOD09ICAgIGJ5IDB4NzRC
M0QzOiBxbXBfeF9leGl0X3ByZWNvbmZpZyAodmwuYzoyNzE4KQ0KPT04MDkxMzg9PSAgICBieSAw
eDc0REI2RjogcWVtdV9pbml0ICh2bC5jOjM3NTMpDQo9PTgwOTEzOD09ICAgIGJ5IDB4QTE0RjNG
OiBtYWluIChtYWluLmM6NDcpDQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0KPj4NCj4+IHdoaWNo
IHdhcyBpbnRyb2R1Y2VkIGJ5IHRoZSBjb21taXQgYmVsb3c6DQo+Pg0KPj4gY29tbWl0IDNmYTk2
NDJmZjdkNTFmN2ZjM2JhNjhlNmNjZDEzYTkzOWQ1YmQ2MDkgKEhFQUQpDQo+PiBBdXRob3I6IEhl
dCBHYWxhIDxoZXQuZ2FsYUBudXRhbml4LmNvbT4NCj4+IERhdGU6wqDCoCBNb24gT2N0IDIzIDE1
OjIwOjQ1IDIwMjMgLTAzMDANCj4+DQo+PiDCoMKgwqDCoCBtaWdyYXRpb246IGNvbnZlcnQgcmRt
YSBiYWNrZW5kIHRvIGFjY2VwdCBNaWdyYXRlQWRkcmVzcw0KPj4NCj4+IMKgwqDCoMKgIFJETUEg
YmFzZWQgdHJhbnNwb3J0IGJhY2tlbmQgZm9yICdtaWdyYXRlJy8nbWlncmF0ZS1pbmNvbWluZycg
UUFQSXMNCj4+IMKgwqDCoMKgIGFjY2VwdCBuZXcgd2lyZSBwcm90b2NvbCBvZiBNaWdyYXRlQWRk
cmVzcyBzdHJ1Y3QuDQo+Pg0KPj4gwqDCoMKgwqAgSXQgaXMgYWNoaXZlZCBieSBwYXJzaW5nICd1
cmknIHN0cmluZyBhbmQgc3RvcmluZyBtaWdyYXRpb24gcGFyYW1ldGVycw0KPj4gwqDCoMKgwqAg
cmVxdWlyZWQgZm9yIFJETUEgY29ubmVjdGlvbiBpbnRvIHdlbGwgZGVmaW5lZCBJbmV0U29ja2V0
QWRkcmVzcyBzdHJ1Y3QuDQo+PiDCoMKgwqDCoCAuLi4NCj4+DQo+PiBBIGRlYnVnIGxpbmUNCj4+
IMKgwqDCoMKgwqAgaXNvY2stPmhvc3QgPSByZG1hLT5ob3N0Ow0KPj4gwqDCoMKgwqDCoCBpc29j
ay0+cG9ydCA9IGdfc3RyZHVwX3ByaW50ZigiJWQiLCByZG1hLT5wb3J0KTsNCj4+ICtmcHJpbnRm
KHN0ZG91dCwgIlFFTVU6ICVzLCBob3N0ICVzLCBwb3J0ICVzXG4iLCBfX2Z1bmNfXywNCj4+IGlz
b2NrLT5ob3N0LCBpc29jay0+cG9ydCk7DQo+Pg0KPj4gcHJvZHVjZWQgdGhpcyBlcnJvcjoNCj4+
IFFFTVU6IHFlbXVfcmRtYV9hY2NlcHQsIGhvc3QgOjosIHBvcnQgODA4OQ0KPj4gY29ycnVwdGVk
IHNpemUgdnMuIHByZXZfc2l6ZSBpbiBmYXN0Ymlucw0KPj4NCj4+IG9uIHRoZSB0YXJnZXQgaG9z
dCwgd2hpY2ggbWF5IGluZGljYXRlIGEgY3Jhc2ggcmVsYXRlZCB0byB0aGUgbWVtb3J5DQo+PiBh
bGxvY2F0aW9uIG9yIGEgbWVtb3J5DQo+PiBjb3JydXB0aW9uIG9mIHRoZSBkYXRhLiBXaXRoIHRo
ZSBwYXRjaCwgaXQgZG9lc24ndCBoYXBwZW4gYW55IG1vcmUsDQo+PiBhbmQgdGhlIG1pZ3JhdGlv
biBpcyBmaW5lLg0KPj4gQ291bGQgeW91IGJlIGtpbmQgdG8gdGVzdCB0aGlzIGFuZCBjb25maXJt
IHRoZSBpc3N1ZT8NCj4+DQo+PiBGdXJ0aGVybW9yZSwgSSdtIGNvbmZ1c2VkIGJ5IHRoZSB0d28g
c3RydWN0Og0KPj4NCj4+IHN0cnVjdCBJbmV0U29ja2V0QWRkcmVzc0Jhc2Ugew0KPj4gwqDCoMKg
wqAgY2hhciAqaG9zdDsNCj4+IMKgwqDCoMKgIGNoYXIgKnBvcnQ7DQo+PiB9Ow0KPj4NCj4+IHN0
cnVjdCBJbmV0U29ja2V0QWRkcmVzcyB7DQo+PiDCoMKgwqDCoCAvKiBNZW1iZXJzIGluaGVyaXRl
ZCBmcm9tIEluZXRTb2NrZXRBZGRyZXNzQmFzZTogKi8NCj4+IMKgwqDCoMKgIGNoYXIgKmhvc3Q7
DQo+PiDCoMKgwqDCoCBjaGFyICpwb3J0Ow0KPj4NCj4+IFRvIG15IHVuZGVyc3RhbmRpbmcsIHRo
ZXkgYXJlIHVzZWQgdG8gY29uc29saWRhdGUgdGhlIHNlcGFyYXRlZCBkYXRhDQo+PiB0byBhIHdl
bGwtZGVmaW5lZA0KPj4gc3RydWN0ICJNaWdyYXRlQWRkcmVzcyIsIHdoaWxlIHRoZSBzdHJ1Y3Qg
d2hvc2UgbWVtYmVyIHJlY2VpdmUgdGhlaXINCj4+IGRhdGEgaGFzIGEgZGlmZmVyZW50IHR5cGU6
DQo+Pg0KPj4gdHlwZWRlZiBzdHJ1Y3QgUkRNQUNvbnRleHQgew0KPj4gwqDCoMKgwqAgY2hhciAq
aG9zdDsNCj4+IMKgwqDCoMKgIGludCBwb3J0Ow0KPj4gwqDCoMKgwqAgLi4uDQo+PiB9DQo+Pg0K
Pj4gSXMgdGhlcmUgYW55IHJlYXNvbiB0byBrZWVwICJwb3J0IiBsaWtlIHRoaXMgKGNoYXIqIGlu
c3RlYWQgb2YgaW50KSBvcg0KPj4gY2FuIHdlIGltcHJvdmUgaXQ/DQo+PiBUaGFuayB5b3Ugc28g
bXVjaCBmb3IgYW55IG9mIHlvdXIgY29tbWVudHMhDQo+Pg0KPj4gQmVzdCByZWdhcmRzLA0KPj4N
Cj4+IFl1IFpoYW5nIEAgSU9OT1MgQ29tcHV0ZSBQbGF0Zm9ybQ0KPj4gMDUuMDMuMjAyNA0KPj4N
Cj4g

