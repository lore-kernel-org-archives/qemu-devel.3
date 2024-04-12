Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A74C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 06:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvA27-0001Ci-ML; Fri, 12 Apr 2024 02:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rvA25-0001C4-Vw
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 02:05:06 -0400
Received: from mail-co1nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2416::601]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rvA24-0000FV-41
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 02:05:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBFcWUyKwx7TZzqp4u0UornyQEul7DOnOe75ELvMRtbw+4hDzk91ByPhc8OyHZqWEZ0YKSqmMSAd5k+d/QJ17JlAWdMV37i3auMaBg9vF1Iz7h2+dTa8xefdJwzIhqyu2Qriktpcx3MEPrUAITdLdneZfRarn4LJfoPGGN5iJOSkQ7+692Rf7pefmyOVyS6fCxREd7Uw+TBut266HodC/048NL4ZLwxRa9UDLWJ14dlG00yYQy8i2MtUm81OlBtiVY+H+v5vprbD7r3FcNE5jMl7kDasST478x61mc8oU27MShv28DVsMKah1uZSE99ztKQQv/rPNVNqa8vixVMxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+XsEQqGng7seiAWe3fx8zgZPTMPoZkTNuYIXUpwT5E=;
 b=DMh2BA/w1XtCRWFYvnXRLijTlO+ByWIX+joM8zNlw968sAcKIIxjXWASUeveEeZPmdlmg5M1zUVlGGQXnhZY0/r/xQ9xOpn/pJYUSWE9/hFUMl15SGeGuY05cscZRpgO52DlH3M4jKa6oMRIc1pp5qTijV+8SC+JMKEmUbJVttTViAGxzoTOddP73sTO05++cMxgwmJyaWT/m4PjFc2EgYVTT05GPcCuJGxLoFePrgAxLztID/Vb8BH8VpgHrLPw2T1nujuM+XSP1SYFkhS0rTO913JwleDxUC6xCWsI+nwUTNhWAAhnYYrQCzLwiAv0mJWcjq3ktmrBVESfVFNyEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+XsEQqGng7seiAWe3fx8zgZPTMPoZkTNuYIXUpwT5E=;
 b=Imux39j72fpxmNJLcCC2r19KlwaZUJuo8NfAvAscmBiKFTrGmlp3hCgyWKi3OcEum113uRA/d9MQ/guHDxybNZ7jA5206RDfbNZCd82RSZNlJOJO9JViBkPhraV1PWCXAqOpRHFJcJeZenGOJYGN5Tm74sI8X8D1uW5ApnfoLLg=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 06:04:58 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285%6]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 06:04:58 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huang, Ray"
 <Ray.Huang@amd.com>
Subject: Re: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Topic: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Index: AQHagPw4nwt3E6Dxr0GcatBwmH6cBbFM+5kAgACHiID//5QEAIABse2A//+IQICAADj0gIAGTJQAgAdcY4CAAI4zAIAH/+mA
Date: Fri, 12 Apr 2024 06:04:57 +0000
Message-ID: <BL1PR12MB5849D4F87AEA6059CE71AE34E7042@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240328103903.408290-1-Jiqian.Chen@amd.com>
 <20240328103903.408290-3-Jiqian.Chen@amd.com>
 <20240328065606-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849ACCD6602EAB88BE2FED9E73B2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <20240328083503-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849C37A0B0E1AF02644C203E73A2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEt=V4V4JgT08o5_f7tj-eNZDi2GB4=H_Qp7xALrRxBWhQ@mail.gmail.com>
 <20240329064431-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849AA89DC28465714590B56E73E2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEu6uEF+4P3_3Q5tw4TNZ9dj3GwJh+h_BtWDfq3WeUhKJQ@mail.gmail.com>
 <20240407074848-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240407074848-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: IA1PR12MB7662.namprd12.prod.outlook.com
 (15.20.7472.008)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|PH8PR12MB6914:EE_
x-ms-office365-filtering-correlation-id: 63adcc98-0dfe-41db-0ef0-08dc5ab67b81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pgwOV/xnLXupWqgV+FfTefa5IHpT4iHPIoOs2wGSjfvmxAGMvZtk+2lxSxHFhssZ0ez31D88V2yR/LOZoBaawGec0x5lYvMXDRZhvIbEqum05Qe3C6wN2EVzkag5MFOlKw+YIxl/obH55KhlAXqwdE3ElfRC86yjKVGF3lYoIy3B0Z+KE2z+BRLbZh1BCxgHsyR10O58Eb5J7hQssF6MWN+VnRty06u5hbj/KcOuZI/tkf8jgPyC52Zbg3jYHfE094Fpdnw5ODo1QG7ljKYgiW928Mjd/iTlE5NGQ9slsE4+w2JqSyCUwSyUZsC9OVwjmRkC1KOzekrrFyCGcujh9aW/B2s59RFyIb202rl5mxZ3ZpFLP9wY5zLoF3QtoJAZu0zJXbuca2jWpy4dPxUm7/YuOjw+WJAUN13vFtergx6X2PWzmjhE544GmeZJzk9HhjxBCQTRySZF3DCXmk0dqnAOq8zV50ZXhEdphSM2t1U5suXKE3UHES5tFFhd9tV5gJXay0557lIPEPz09PtYU7eHfQKEdh0THQ7dWMOc6WmKn7smp0U87YkDyrEXpyxWiEPQmDXUfvsXmxkqX7061zZ/OSZzoO9NRnxnCe6FQRQLTwgrtvRxUatlLEWoUI+bbTBGbkjxNM3C4OIKmu3t4NCdBpt/2wDoR78mCpTjmptjLBmwsIoshddYy4IA7lfZt4S+jNU7FSEiW5b6fAy0vv7Iw7qVnncAurNu9jQK7JE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWt6VHJUbG9NRk5ZbkkzeFFrKzF3cDd2aUVwbnNXNGFpd0ZiNktRK2o1SjVl?=
 =?utf-8?B?VHg4cEY0b0s2ak5xbG10MWtWdW4rL1l0aDdReDc1UmYvUTBESHhqN0VVV0tI?=
 =?utf-8?B?NWYrdkRWeUcvZURML2JtenZWb0Z1WndyZXZ4K2kzd2ZNd1ZXNUxIUzNFWDhk?=
 =?utf-8?B?MUMxTWZmaDlEYThRRzlIbk4zcEZFMmRFUzlFRkxZbmV4MU5ZZ2hLUVdPZEhx?=
 =?utf-8?B?cVZ6ZytVcGhQM2RZUnprci80VVQwQ1luUzNHa0g1K1JyeHAwNGtDSjJKWmky?=
 =?utf-8?B?OFhIV3czWHBNZlYrSk03OWZrcXFiOWpoT3JNT3hDU2lhSXE3WGIyWlFOS0cv?=
 =?utf-8?B?OGNTZ1BBOTBXS0h0dEpPL2hXTlI0YmNsdkluVXBIZmNhZmc4RnhVWm14Vmds?=
 =?utf-8?B?d1NWWmpoL3hndngvSm16RkZJSVhzcUxMeXNqWVlkQkR1YTc1MzdyVnpaUHV3?=
 =?utf-8?B?amltMy9HUi9nME5va0xTME5FeUs0Zlpzak1mM2o5MUtVbnlNUWtVb1hxYUZt?=
 =?utf-8?B?UlF6ek9qdkROdWtZUVFCK0QvYVNKWWtXQUV2Vys5T1FXRUU4eDBMdTRRTWdl?=
 =?utf-8?B?aVdSWjJKMjk3cnlxT0tSNEFoTVUxWnI0ckoxN2RUZHl6Qk1qb0VkZEF6ZFFj?=
 =?utf-8?B?VmVNSW5MbllINzIxRnVtWVR5TERPN3hmTWZLRS8yc0JWWUJsbzB4MndIT2tl?=
 =?utf-8?B?WG03UDVFTDZCS2t2bWZjQ1FTL21iSUdJRS9NR1ljL1hrd1lsZjdZMStKU0cv?=
 =?utf-8?B?Rk5RR3h1QnUzOFUwTVEzRzlFSGI5VzdtSXJULzArNGJ2NUNTY0JkZDYzTzg0?=
 =?utf-8?B?d21hb1l1bG94MjhWVkUwcHR4R3JnUktZVFdta3k3bS9yV1E0eCt6aVB2QzBI?=
 =?utf-8?B?SU1FeHpNRnArTFdoN2g0WEwvRFlZelJVQlJWY2w4UUh5TXY5UklJc21Ka2RG?=
 =?utf-8?B?cU5rMmRkdTRPN25nYTgzV3dYdWc1WUZDNkJTL1JrVGtkTXNnYTV5Q2k5R25H?=
 =?utf-8?B?akR3TUZjNHhDYzZRaEd3STRCejhuNFRPN1RkYUpob0Q4cFJ4UDl1c3VyN0oz?=
 =?utf-8?B?MFFTaTNLTXNmbzBwOWVYSVRoYnlyL0VNSmpodUZPeitWRzBuMTkycTdnVml0?=
 =?utf-8?B?VXM5VG4wdGZ5Nk0vYnZra3JWRUd3MHEwR285Qk8wWERSOVk3ZStFOEwwK2Va?=
 =?utf-8?B?a3RmTWk5SHhKcjA5SHZwVG1DYVc2Wk9hN1lMQmFIVWZaUEVQRE5yVGo1cmgx?=
 =?utf-8?B?Mit6Q0JESjFxbGl5T0x4QTh5dTcyS05QUzlqWVF1blpiR2ZqRWxSZlQ4YUJq?=
 =?utf-8?B?bXI2QnVoOFZEeUVTNWdRbE1PaEhmaEwwQUM0bWF3MmNWbmRKWHlZTkhrUTZi?=
 =?utf-8?B?UC81QmRsanlTWVpJOVhJRDdUSWs4Y0dHS1RQTmhMTVgrc2VVYytON0pSb3ZK?=
 =?utf-8?B?bWwycGlXY1ZCcVBSYTlHSnl3U2NlUkJQVGl3ODRKVGY4a1dkc1ZBZUs1cTJN?=
 =?utf-8?B?bGpzUlpEZnRucnplMXg5aXN6cXBLZUJwN3JkbUxPbnJqWVo4d09IdlJoM1U0?=
 =?utf-8?B?d3Uya3ZMWTRiNFhycXl1a05HT1ZSVHYycjdQZDk0RzRGRXBPYy9JMExMSkV2?=
 =?utf-8?B?Q0FIT2FmRDFkd3J6Zkd2ZS9wQm55T215TEhKYmRoNUZ4OTQzZmJ5aWxyV3o5?=
 =?utf-8?B?bzE2eHpTTnNkdG0rMUc2Ky9Vc2crNytMOVoraWJBSHNsejl0WW01d2o1Wk51?=
 =?utf-8?B?VnIzcGVKdEY1eHM4U3Z6czRMTGpWc2NFRnFCcHdvNFZQSDVybVp5QTRycVIw?=
 =?utf-8?B?amtUL3VvbXcwMUovSGRTVFQ1d2krTlVPU0VwV3JERSsybkdReDJhYldrL1ZU?=
 =?utf-8?B?ZVpULytDUGFTU2cvdlpiOUlEU3J0Wm8wc1BZVm5Cdm1zTkEyMzZYSFd3cmFa?=
 =?utf-8?B?clJ2RXJhT0R2UDc5QTZLYW5SQWR4Z0tDZllDaEo1Z09jNU1YSnJTZ3hjSW1i?=
 =?utf-8?B?MTRWQ2tROVdTV1hpZ2JLSWFDMVpaYWtTT1VKZyt2NVFZczAzVGdzYUdKZTVr?=
 =?utf-8?B?d0x3dE14ZFgrUHNwVVVzMkt3OWt0aVgvVUdQMkJJdlM4L0lvM3g2TVlSZm9X?=
 =?utf-8?Q?Lpuc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <421B357E5509854498BCB723C430E71D@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63adcc98-0dfe-41db-0ef0-08dc5ab67b81
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 06:04:57.9743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a749RfOeS+u7y2gekJHTrHUTlHCwvSI8ZUZEhxWv1/ggea+Hx/zhqCjxtLUd4luJnjmwP7FRLw3vyzG505i8pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6914
Received-SPF: permerror client-ip=2a01:111:f403:2416::601;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

T24gMjAyNC80LzcgMTk6NDksIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToNCj4+PiBJIHdpbGwg
c2V0IHRoZSBkZWZhdWx0IHZhbHVlIG9mIE5vX1NvZnRfUmVzZXQgYml0IHRvIHRydWUgaW4gbmV4
dCB2ZXJzaW9uIGFjY29yZGluZyB0byB5b3VyIG9waW5pb24uDQo+Pj4gQWJvdXQgdGhlIGNvbXBh
dGliaWxpdHkgb2Ygb2xkIG1hY2hpbmUgdHlwZXMsIHdoaWNoIHR5cGVzIHNob3VsZCBJIGNvbnNp
ZGVyPyBEb2VzIHRoZSBzYW1lIGFzIHgtcGNpZS1wbS1pbml0KGh3X2NvbXBhdF8yXzgpPw0KPj4+
IEZvcmdpdmUgbWUgZm9yIG5vdCBrbm93aW5nIG11Y2ggYWJvdXQgY29tcGF0aWJpbGl0eS4NCj4+
DQo+PiAieCIgbWVhbnMgbm8gY29tcGF0aWJpbGl0eSBhdCBhbGwsIHBsZWFzZSBkcm9wIHRoZSAi
eCIgcHJlZml4LiBBbmQgaXQNCj4+IGxvb2tzIG1vcmUgc2FmZSB0byBzdGFydCBhcyAiZmFsc2Ui
IGJ5IGRlZmF1bHQuDQo+Pg0KPj4gVGhhbmtzDQo+IA0KPiANCj4gTm90IHN1cmUgSSBhZ3JlZS4g
RXh0ZXJuYWwgZmxhZ3MgYXJlIGZvciB3aGVuIHVzZXJzIHdhbnQgdG8gdHdlYWsgdGhlbS4NCj4g
V2hlbiB3b3VsZCB1c2VycyB3YW50IGl0IHRvIGJlIG9mZj8NCj4gV2hhdCBpcyBkb25lIGhlcmUg
aXMgSSBmZWVsIHNhbmUsIGp1c3QgYWRkIG1hY2hpbmUgY29tcGF0IG1hY2hpbmVyeQ0KPiB0byBj
aGFuZ2UgdG8gb2ZmIGZvciBvbGQgbWFjaGluZSB0eXBlcy4NCkRvIHlvdSBrbm93IHdoaWNoIG9s
ZCBtYWNoaW5lcyBzaG91bGQgSSBjb25zaWRlciB0byBjb21wYXRpYmxlIHdpdGg/DQpPciB3aGlj
aCBndXlzIHNob3VsZCBJIGFkZCB0byAiQ0MiIGFuZCBjYW4gZ2V0IGFuc3dlciBmcm9tIHRoZW0/
DQpJIGhhdmUgbGVzcyBrbm93bGVkZ2UgYWJvdXQgY29tcGF0aWJpbGl0eS4NCg0KPiANCg0KLS0g
DQpCZXN0IHJlZ2FyZHMsDQpKaXFpYW4gQ2hlbi4NCg==

