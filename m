Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AB6C5475B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 02:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri3by-0001YD-KZ; Wed, 06 Mar 2024 21:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1ri3bx-0001XT-4B
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 21:35:57 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1ri3bu-0006Yc-6w
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 21:35:55 -0500
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 4272ZQom039717;
 Thu, 7 Mar 2024 10:35:26 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from ATCPCS31.andestech.com (10.0.1.89) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 7 Mar 2024
 10:35:26 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (104.47.110.40)
 by mail.andestech.com (10.0.1.89) with Microsoft SMTP Server (TLS) id
 14.3.498.0; Thu, 7 Mar 2024 10:35:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyKsEeBK21oeIlFfL+oliRqvy5dh1qiLFaCPdOd0uq23rcSW+UdH5u8Dtr0kGsuBJATsY3FQaqD7EbggarYg8omKJ32SkhHSG1LP6musVjnWuPrXxwbgo4uoA1WCniiqPYzZW5OTGjju/QhUYhLaHeT67E21DACvF3c7+ppdwgfzf9dNK18eSkFoVeq8E3ndfQHp5nDnwGqOckdsBim6XRVDk7BYUVc6HqAanEGhvbna2LkBu5VaDUWQpoOl8piSdDxmE89cqSzDrdceovIJWsVqpml0iArtIvMf2neGGwWuoKjnSSkyy89K9yDq0QE8fAddS6/LSrp09PJ+sssAHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuoT+NfaJ79cF3CnO9x2+/ulKn5qCkSFsV/PnB8MlD0=;
 b=MNafQ7KzpKlQQNAtuJYZF9qDtAOQymY++AI6j15iJ1bACQsoNGaMt6VBgpX7tRNjqcEP1UrQ5iaY/Nm3EHv6bRinW56LU5hwnf4NPN9sKUiY3pgvdSQbr/Ch9tSrZrLsHOf/YF1ueDaLvjHe9rD8Qq2Vvi30/KHJ/V9tKwMrz4eKbRhRx64/ipt0PIL2N+wBbl+5+nyV3Q6WtrzEEFsBOBmTbwc4x7RmbC6jf6tzQoCQmBtO5xenn98YmYfx+KwaGXrm665mwUzjZ9eYQ9SvaVNhsVcAy5yDZaoFyua+EmFoP2m+KQofJqIXFus7uKARaaKlNCHhCsQLOBx0FiXpqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andestech.com; dmarc=pass action=none
 header.from=andestech.com; dkim=pass header.d=andestech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andestech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuoT+NfaJ79cF3CnO9x2+/ulKn5qCkSFsV/PnB8MlD0=;
 b=adLGAlyu8pM8ybSEMIlbMF0X0Q6xWWL4hLNHeXTYET265EwScWBgHZEdFKUcADb4hh2x8zmmlKoCX1Z5YYiar6Hik7EN86Cb/7G+N9pr7GEUFnoaq61Ad1y/JlptHogpZ5xgphud1LUSOmRh6bDA/GtGhUISBd3843V3hwfdN+LfY1gvktIYxkBKDYEKc9tu3s1U4RL/ieE8P0EWr0zKbUndKSZI4/vtXdbADdhrc4t/2QcVUUbPKsv8Q+2VC7jhy2xXwa0wUSi7ApAJWdU91WscinJ7tyc8+22Jw9981eyVa6pwPAUYIoQJ+3OtwIKSnxuPOzOPk2sw9Kn5hOMPxg==
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com (2603:1096:101:69::14)
 by KL1PR03MB7150.apcprd03.prod.outlook.com (2603:1096:820:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 02:35:21 +0000
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::a36c:edb4:2568:ca70]) by SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::a36c:edb4:2568:ca70%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 02:35:21 +0000
From: =?big5?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmcosWmt9bnFKQ==?=
 <alvinga@andestech.com>
To: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "dbarboza@ventanamicro.com"
 <dbarboza@ventanamicro.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: RE: [PATCH v4 0/4] RISC-V: Modularize common match conditions for
 trigger
Thread-Topic: [PATCH v4 0/4] RISC-V: Modularize common match conditions for
 trigger
Thread-Index: AQHaaRuw1Ic9+cKyFUOVkNF4KptLBLErnOcQ
Date: Thu, 7 Mar 2024 02:35:21 +0000
Message-ID: <SEYPR03MB6700853CCA2198D3E7DA7E7DA8202@SEYPR03MB6700.apcprd03.prod.outlook.com>
References: <20240227012405.71650-1-alvinga@andestech.com>
In-Reply-To: <20240227012405.71650-1-alvinga@andestech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andestech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6700:EE_|KL1PR03MB7150:EE_
x-ms-office365-filtering-correlation-id: 9c6aeb6b-8293-4497-7e6b-08dc3e4f3c57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sp1KYZhhQpQYLh/7apmqHi3u1rrse357LGteFHxrTrdZ6UZa9oImyvzgX058b1MCSU7I/AlnxLmgdrK/uLPPsGzFwM3/1UXJwjj+9klhXTw4mRpiB2rRuIxia2eKFZu1xY3QAQ4sEuT2BVC4gNPVxiPNmynAaRCQT6IBIXN+dn2uLVoytR9OzhJ3Rc5s8hBzmZD5acoqLfqcMQk8mnfeSw5VxnhVt6EwlxzruT1pRWL4Yp9GN4Td2sNBRC27YjerDxqyIectITFnbOmviY/GcKE8Qk6RtnU+DkZS0JIWlJ/GPpX6FJmpQM9OtJJdDtTgOIVrQdVltQuaHw4rDBbEl9XjKTc0bCuvJumUUH9g0jUCX4ak8qdfu1C+vXHUQ95YaR7Azz6B/mrkN6mRAtprC+znS1On4v/41TDy7cV+BsLlXO+W/oU1kCTZ9NXioGmlXLHlxF97fQEo9o+TZE6JGIjY28GuqyemyOy2dENWXZ8ONtv+PGwiRjxN/k7XFCWCM6500gL34ZHDnae3KaarBh/a/ri+JRkdKM9EzPGXOeMO1oz5vjuNtk9KTIovbMLUgjmz45NnpDNBEKxwM41/5D6YGFpqiAo5E1ZSu9xMqGB0lRyZqpVQEoAHWTCFBMCokCxVzL9ZBPz/af9g74pbZ2+8B4yGTZZ3UZn0YuDB328=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR03MB6700.apcprd03.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?WVY3YlRJaHEvV2QvZ2RPVCs4WFBiYlV4ZTRhQlVqWlE3WHBJOE9oRUp6VGdpYnlJ?=
 =?big5?B?QytQMyszZDZoUkNwM0FpLzZtaUFhWW9LNXM3ZEtkU2lnR0hTTWkzWmtreGlOS29z?=
 =?big5?B?SXVjdXBWRmJUWGtiSFpEYWlaRXQyZVcwMTU2c3JtV2F5SWMyOEoxTzBLVitkM3gz?=
 =?big5?B?QTd3a1lUMk1BanR6WVczMEpvTXBsMGoxdjNXcFU5a2RFcXlVTVhETE1sRnM4ekZl?=
 =?big5?B?MW82V2d2d1N2ek9UclpHeDdJSHBXaU9oQU4yaTcrblBzZGpaaURFU3ByYlZ3Um03?=
 =?big5?B?cDFYNExXdVBXcVR1QzliRkZlSlJoYytHM21ZR3NKaDlvUWVKK0FDeFgwRkIyemkw?=
 =?big5?B?VzVEbHJUWFdCbnprcThVQmFXSFVsb1c3WVBFRW51MjZXaElkdTJTV3JlbHNpaE4y?=
 =?big5?B?WFRhc2JiR3hOUVZ0bzFTS05CM3IxZHZReXR0empZUU50bC80V1dKbWc3TE94YkZa?=
 =?big5?B?aDI1VlNNcXFNSTBZVnB6a0RFaXJPd2ZDM2YzbC9GRVN2ZmdGWk5Kc1ZTSDNHN1Zo?=
 =?big5?B?b0E4L3FEcU9MQm93K1MzaFp1ekpGdGo3RjMwYVJ3VnUva2IzMnNQTCsvT0VlTjlJ?=
 =?big5?B?aVdyS29wYk1NNUlWNVZxZ2hPMmNOb01wcnoxazRIbzcwWGllVkozK283c2JtMmh4?=
 =?big5?B?bkprTWpvOUFBTllRTkZrbUF4ekR5bEs2TTJrbFlFWWJGUVFuRFRhRnNla2VVeU9p?=
 =?big5?B?MnhxdkZQdkp0MlIyUTJ2bHVYOGRTNWI1cExBQkhJTEhQQ3FCZHJMZy9sYlNubjZE?=
 =?big5?B?ODVCQ1NrV0Qvb3hmM1BXZm1kSmc3N3MyWkFSaDVxQUNnTEl1a3ZsRTVuTGtiMm1r?=
 =?big5?B?NXhacngxMXdIb2pXYnhPMEtodlV0MUhzV3NMWE9HN3B4T1dmNXV3RlpRSlRpN0NE?=
 =?big5?B?RlRvM2ZZUHFuS3FPeDhlYUk4blRuMEppbTU4dmt2TDc1YSszTC9SSGhSd1ZWWHR6?=
 =?big5?B?WUNtbEFZUlBOcVJjSDNzYU55UXNQcGJYem9Sbkp0Zk5iTjRtaWFHK3djVVdQQlZH?=
 =?big5?B?b1JpQUlLMGRmZGhmN2dzQjhDbFlNWit6MDFRbS96RnBCVXV5Ym91SUlzb2MwZk5E?=
 =?big5?B?L05tamtmSXJ1cEJWSkRkYjY1LzRONlZyY0hQSXRwbVFFUGtZaHVLRG93bENzM2tW?=
 =?big5?B?TGxKYXUwbmJRMzNUZ1prWTVEaW9FNGtiU2RzWTNkWThnbGNqd0xvYlNUWWYwQmRj?=
 =?big5?B?WGhWMlR6RWVnNEtNQWpIdVI2T0dUd2NqMEh4K1RhdlpGc0c4YjNCazJOb0xYUjBC?=
 =?big5?B?ZU1nUGNxUGlVTnExK3JvZElUQWlvM3hCcyt5RlZYNFV6SlQyUVhlKzBtSTdHTDg1?=
 =?big5?B?QUVyak1aVDhaZE1TN3lmNHRzTXdWK09zWDZwVWJ3YTV3ZkI2aGVHTE50YVJ5OXJR?=
 =?big5?B?WndLaWoyUWNwQnN5V1hJTVpuaHY2QUJ1b3ZkWW5vdGtxSnpFQ0lES0w5RHA1aFdU?=
 =?big5?B?RkdSQUhjcm90dnYyUUhmRjU5bEZRZ1JwZ2h5b3U5eEluc2pGSVYwQmhSd2J3OFhR?=
 =?big5?B?cnRGb0pYMWxodk9GSm1FbnFBVFpxWEJpMmEzVW1Xd2lQRUM2ZXVnaXd1bk1IWW1U?=
 =?big5?B?QW8wVVByL3grNFJlVjJtOFpQMVBGdGxzaTY1ck5NRUdKVFo3Mk43ais5UGdGN2R6?=
 =?big5?B?L3ZlSmJYNk9HMjhMME92Nm9GUEVoQ09DL0VvMTNnNk1uL0dPS2hGb2R1YXFKL09p?=
 =?big5?B?bjI2TCtaRTVMQzJzanRTYVFpbkhhTWJGMERzdEM2aEN0T1pUWk5FeENxa2xDZmxO?=
 =?big5?B?U2VEUDR0TTJCUHlQNWVpTVpEU1hyRU5vdk54ZXBOYXlEUFhPOTQvRDRnWXpqcW9J?=
 =?big5?B?bXlPRVkxTFc2d1ozeTNWU1JrVG5LMW96YVlNSkM5RnRDbE9UQlcwRGp3R2xBVzV4?=
 =?big5?B?eTI2eSs5c1hQVW5DVTREcUxtS1F2MEhIeUUzTTVuNUptT3JhaDZWdHFjQ0VtZXVT?=
 =?big5?B?aEkyT2xrZUJVQXJlQU8vcmFWY1AzWmY3OEcxTS9kN2toaE83N2NOdGxQQXcrWElV?=
 =?big5?Q?Zd0NiI8UYzurJgnG?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6700.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6aeb6b-8293-4497-7e6b-08dc3e4f3c57
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 02:35:21.5180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3ec21b7-ec6c-4041-9add-61aea8171458
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Na3/Y7Iwc1KPtl08pfaVAtJ13kG8+YoCFlxlNnyzkc4qGzay9wJ4EOE14NxZSVn8bmStuaKWAjlsYdV2v2n5Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7150
X-OriginatorOrg: andestech.com
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4272ZQom039717
Received-SPF: pass client-ip=60.248.80.70; envelope-from=alvinga@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: 45
X-Spam_score: 4.5
X-Spam_bar: ++++
X-Spam_report: (4.5 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_CHARSET_FARAWAY=2.45, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

SGkgQWxpc3RhaXIsDQoNClBsZWFzZSBhbHNvIHRha2UgYSBsb29rIGF0IHRoaXMgc2VyaWVzLCBJ
IGd1ZXNzIGl0IGlzIHJlYWR5IHRvIGJlIGFwcGxpZWQsIHRoYW5rcyENCg0KDQpCUnMsDQpBbHZp
bg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFsdmluIENoZS1DaGlh
IENoYW5nKLFprfW5xSkgPGFsdmluZ2FAYW5kZXN0ZWNoLmNvbT4NCj4gU2VudDogVHVlc2RheSwg
RmVicnVhcnkgMjcsIDIwMjQgOToyNCBBTQ0KPiBUbzogcWVtdS1yaXNjdkBub25nbnUub3JnOyBx
ZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbTsgYmlu
Lm1lbmdAd2luZHJpdmVyLmNvbTsNCj4gbGl3ZWkxNTE4QGdtYWlsLmNvbTsgZGJhcmJvemFAdmVu
dGFuYW1pY3JvLmNvbTsNCj4gemhpd2VpX2xpdUBsaW51eC5hbGliYWJhLmNvbTsgQWx2aW4gQ2hl
LUNoaWEgQ2hhbmcosWmt9bnFKQ0KPiA8YWx2aW5nYUBhbmRlc3RlY2guY29tPg0KPiBTdWJqZWN0
OiBbUEFUQ0ggdjQgMC80XSBSSVNDLVY6IE1vZHVsYXJpemUgY29tbW9uIG1hdGNoIGNvbmRpdGlv
bnMgZm9yDQo+IHRyaWdnZXINCj4NCj4gQWNjb3JkaW5nIHRvIFJJU0MtViBEZWJ1ZyBzcGVjaWZp
Y2F0aW9uIHJhdGlmaWVkIHZlcnNpb24gMC4xMyBbMV0gKGFsc28gYXBwbGllZA0KPiB0byB2ZXJz
aW9uIDEuMCBbMl0gYnV0IGl0IGhhcyBub3QgYmVlbiByYXRpZmllZCB5ZXQpLCB0aGUgZW5hYmxl
ZCBwcml2aWxlZ2UgbGV2ZWxzDQo+IG9mIHRoZSB0cmlnZ2VyIGlzIGNvbW1vbiBtYXRjaCBjb25k
aXRpb25zIGZvciBhbGwgdGhlIHR5cGVzIG9mIHRoZSB0cmlnZ2VyLg0KPg0KPiBUaGlzIHNlcmll
cyBtb2R1bGFyaXplIHRoZSBjb2RlIGZvciBjaGVja2luZyB0aGUgcHJpdmlsZWdlIGxldmVscyBv
ZiB0eXBlIDIvMy82DQo+IHRyaWdnZXJzIGJ5IGltcGxlbWVudGluZyBmdW5jdGlvbnMgdHJpZ2dl
cl9jb21tb25fbWF0Y2goKSBhbmQNCj4gdHJpZ2dlcl9wcml2X21hdGNoKCkuDQo+DQo+IEFkZGl0
aW9uYWwgbWF0Y2ggY29uZGl0aW9ucywgc3VjaCBhcyBDU1IgdGNvbnRyb2wgYW5kIHRleHRyYSwg
Y2FuIGJlIGZ1cnRoZXINCj4gaW1wbGVtZW50ZWQgaW50byB0cmlnZ2VyX2NvbW1vbl9tYXRjaCgp
IGluIHRoZSBmdXR1cmUuDQo+DQo+IFsxXTogaHR0cHM6Ly9naXRodWIuY29tL3Jpc2N2L3Jpc2N2
LWRlYnVnLXNwZWMvcmVsZWFzZXMvdGFnL3Rhc2tfZ3JvdXBfdm90ZQ0KPiBbMl06IGh0dHBzOi8v
Z2l0aHViLmNvbS9yaXNjdi9yaXNjdi1kZWJ1Zy1zcGVjL3JlbGVhc2VzL3RhZy8xLjAuMC1yYzEt
YXNjaWlkb2MNCj4NCj4gQ2hhbmdlcyBmcm9tIHYzOg0KPiAtIENoYW5nZSB0aGlzIHNlcmllcyB0
byB0YXJnZXQgRGVidWcgU3BlYy4gdmVyc2lvbiAwLjEzDQo+DQo+IENoYW5nZXMgZnJvbSB2MjoN
Cj4gLSBFeHBsaWNpdGx5IG1lbnRpb24gdGhlIHRhcmdldGluZyB2ZXJzaW9uIG9mIFJJU0MtViBE
ZWJ1ZyBTcGVjLg0KPg0KPiBDaGFuZ2VzIGZyb20gdjE6DQo+IC0gRml4IHR5cG8NCj4gLSBBZGQg
Y29tbWl0IGRlc2NyaXB0aW9uIGZvciBjaGFuZ2luZyBiZWhhdmlvciBvZiBsb29waW5nIHRoZSB0
cmlnZ2Vycw0KPiAgIHdoZW4gd2UgY2hlY2sgdHlwZSAyIHRyaWdnZXJzLg0KPg0KPiBBbHZpbiBD
aGFuZyAoNCk6DQo+ICAgdGFyZ2V0L3Jpc2N2OiBBZGQgZnVuY3Rpb25zIGZvciBjb21tb24gbWF0
Y2hpbmcgY29uZGl0aW9ucyBvZiB0cmlnZ2VyDQo+ICAgdGFyZ2V0L3Jpc2N2OiBBcHBseSBtb2R1
bGFyaXplZCBtYXRjaGluZyBjb25kaXRpb25zIGZvciBicmVha3BvaW50DQo+ICAgdGFyZ2V0L3Jp
c2N2OiBBcHBseSBtb2R1bGFyaXplZCBtYXRjaGluZyBjb25kaXRpb25zIGZvciB3YXRjaHBvaW50
DQo+ICAgdGFyZ2V0L3Jpc2N2OiBBcHBseSBtb2R1bGFyaXplZCBtYXRjaGluZyBjb25kaXRpb25z
IGZvciBpY291bnQgdHJpZ2dlcg0KPg0KPiAgdGFyZ2V0L3Jpc2N2L2RlYnVnLmMgfCAxMjQgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDgzIGluc2VydGlvbnMoKyksIDQxIGRlbGV0aW9ucygtKQ0KPg0KPiAtLQ0KPiAyLjM0LjEN
Cg0KQ09ORklERU5USUFMSVRZIE5PVElDRToNCg0KVGhpcyBlLW1haWwgKGFuZCBpdHMgYXR0YWNo
bWVudHMpIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBhbmQgbGVnYWxseSBwcml2aWxlZ2VkIGlu
Zm9ybWF0aW9uIG9yIGluZm9ybWF0aW9uIHByb3RlY3RlZCBmcm9tIGRpc2Nsb3N1cmUuIElmIHlv
dSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHlvdSBhcmUgaGVyZWJ5IG5vdGlmaWVk
IHRoYXQgYW55IGRpc2Nsb3N1cmUsIGNvcHlpbmcsIGRpc3RyaWJ1dGlvbiwgb3IgdXNlIG9mIHRo
ZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaGVyZWluIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIElu
IHRoaXMgY2FzZSwgcGxlYXNlIGltbWVkaWF0ZWx5IG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJldHVy
biBlLW1haWwsIGRlbGV0ZSB0aGUgbWVzc2FnZSAoYW5kIGFueSBhY2NvbXBhbnlpbmcgZG9jdW1l
bnRzKSBhbmQgZGVzdHJveSBhbGwgcHJpbnRlZCBoYXJkIGNvcGllcy4gVGhhbmsgeW91IGZvciB5
b3VyIGNvb3BlcmF0aW9uLg0KDQpDb3B5cmlnaHQgQU5ERVMgVEVDSE5PTE9HWSBDT1JQT1JBVElP
TiAtIEFsbCBSaWdodHMgUmVzZXJ2ZWQuDQo=

