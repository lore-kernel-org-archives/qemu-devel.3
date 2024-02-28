Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D0BC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 16:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfMUu-0007Lx-2S; Wed, 28 Feb 2024 11:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sriram.yagnaraman@ericsson.com>)
 id 1rfMUX-000796-Ve; Wed, 28 Feb 2024 11:09:12 -0500
Received: from mail-he1eur04on20601.outbound.protection.outlook.com
 ([2a01:111:f403:260f::601]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sriram.yagnaraman@ericsson.com>)
 id 1rfMUO-0001NM-FU; Wed, 28 Feb 2024 11:09:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0FTjX/nnPeXxu1/leqG2KOr0lhzmSaMJSqVSKHyJ4bo1oHXAdxQ4ACN7Ut74Zj/MemakB6LmMi7XlTjJMIgt1wvnC8lOhbmUvammQtialSb4+cczjWoBRC2ud5kZIpAmQRhDmx7wrQ+Atbdv3xyClhgKm8kPMRCsHUIav4z6KKHu2bbq78fPyvFcvQw75bu7KDDKahc2x0Cu12UxdItiWyT7EKiakwrjcGjy95bu44MpvJ1DJS6lJQTBVuh4d/A3yOd2oGhBRkxIwL65zsdbGCr8v/ij+LEJnUAQ8o2lRDTPrC1MPOxS2tyiuTdCj0+Az+YlOICPZq4/4foCBqCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuEpQFqIzyxot7KpvrdTX8T9jJbWcccPoA5LFoYfwdc=;
 b=N1ypPdkzcRYZP3yPRLx3sQ8byYkZqzQyLZfm2ws+houl24tSJw92p+4lG1XjeTbdenguO4TEQQlJLBeDTUn9R475RKKN5E7bSXYS+08ZrnsG8qFpuDKuDwNP6WAoCiqvaN9oJ+EnKOpfJ49jnCXz6zP/IWXm66J5EZRE0K3MtDDn8/a058koCKq23RnOprRAGNZc9wf9A1YIgFlFgEAlCWexDUsq3ekLeJp+6WET/93Nr7FRlfbfCzVOzgqaHDglaAgTJcY+oxcLG4nbGosQOwrTFzNoBUZthJKyiSWMvfRNpiSOawwAPYpZAIrlc391EpLPAUkC+DGHjRRo6H0Q8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuEpQFqIzyxot7KpvrdTX8T9jJbWcccPoA5LFoYfwdc=;
 b=Do6Uz+RMBQGYLTY1NOo4Vp//d9hvk5HGr0TU01nDnj1VwMifOhcPCHlEHayZl+cI6jXRzdov2MvyRUH4D/hdDFMEgIyN1NcGCXMVw0kWIv54okzbJtR2lGQsnmBp6ZDrcnCpkBiWOjX5rpjMkyFErLkUrdNLMWxuNKucPgUV5fGxVPIUh1e4KI7tleGiujpAdIsb02A+pWTyPWafFoQWwxU/SbRMbnQs6xirLhohBU7DStuquO6ZwUn7Cn8H1EMfydMYTaTpJbm0+3AIZvA9NAT4pENHhBdx9+fARNyehUI3pKDsRC59qRk7/Fras0adx03oCpaecxRRxXmwWi4dtg==
Received: from AS4PR07MB8412.eurprd07.prod.outlook.com (2603:10a6:20b:4e3::19)
 by DB9PR07MB9691.eurprd07.prod.outlook.com (2603:10a6:10:4ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 16:08:52 +0000
Received: from AS4PR07MB8412.eurprd07.prod.outlook.com
 ([fe80::3507:c490:b2f:ab2c]) by AS4PR07MB8412.eurprd07.prod.outlook.com
 ([fe80::3507:c490:b2f:ab2c%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 16:08:52 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Jason Wang
 <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, Klaus Jensen
 <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Subject: RE: [PATCH v8 02/15] pcie_sriov: Validate NumVFs
Thread-Topic: [PATCH v8 02/15] pcie_sriov: Validate NumVFs
Thread-Index: AQHaajn+Z/EkXMw/lUG/muhCROdQqrEf4vPw
Date: Wed, 28 Feb 2024 16:08:52 +0000
Message-ID: <AS4PR07MB841257B76EFCFCFE13D51CB890582@AS4PR07MB8412.eurprd07.prod.outlook.com>
References: <20240228-reuse-v8-0-282660281e60@daynix.com>
 <20240228-reuse-v8-2-282660281e60@daynix.com>
In-Reply-To: <20240228-reuse-v8-2-282660281e60@daynix.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR07MB8412:EE_|DB9PR07MB9691:EE_
x-ms-office365-filtering-correlation-id: 98ab17a8-68f6-43b2-85c1-08dc38778e9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IeWhYq6SVJIf+7D+nOTFDfNack1j45b/GEzrmoU5ZrXqm8g59hb7BpJYvAdD0Szi762TK6sA7UokzCFgXUvjVASupvnXg0ThZIGLmVXpGewIK6NwuN47lc+Q3Yv25YyzbdWjbW6u6h12Tpnz/i3cFK+8kNVnhejj0vjYJBEgGUrH3IcQ24o9v7s9keWPiULCSMwGQewAE9xIsVwg1nPO6EbE6xUz57/6JjD1/BQnJ2Jr1W+q3h9O4npO7zmUnWbs3/Qws5HdaIMp0i00bOGRaBYxO2nNQER7vB7a99yUoI9scQMscqUe1tAeQWfM77dc9s13TuJZMJSbx768XWvoTBjA366Y2gaLChpzJ20qaGrr1Ybz9N8J83B4Zi90ieRZxMRz8OCk2oo9IQj0mFIkCBmGDJ1mGc+JPxs11XQ0zrEdOyAxHP27MsqUyBN8vdYFRBM7vZkoHDp/wSKu+LD3afLFhxyMBMWhJF5sDLS7rnPr367kRTk48c5bxBCxfbwrIqmacYFnkPi+7Z63cL/NEgkdR/b4NwAn8Ih579ALWCtiHyL5lP2lFQpYBX3+vAMmpBwH0aMuoQSQ4Sg7oBxVo6MB4aWYaV7jtUbwdtzhSJgDJOtcGHLrDKeEnaDzsAtGv7Cte31TX9UqofGbG+rwnfXzwKSyhLQ5BP6KhbTMLyCVRr15Hw4lKh78z8OkEBYoXJw98ot5TZcBuRKhDLuK+M43VmKxtVfohVrkgnckXbE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR07MB8412.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(921011)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXhmVFpZTjlVZE9hS05hSTROUnhsL1RnalBNWW5QNnEvMXNOTC9IcUtQSTRM?=
 =?utf-8?B?MWpJbWp6SnVFdlhxN3BNT3NoUzU4ZzRPUmpmNUdhKzQrZ3E3VkFkMlVUM0NG?=
 =?utf-8?B?cGI0VTUrd3NjZWpaVFRsYnU2ZWxSNXNXWVRxQk8yMUQ4WUl3UVRjb1Nmcjht?=
 =?utf-8?B?c05VSEJtK1VjYzI3VkR4WnFlb0xOejBsd1ppaEFRd0dxQmkwdmpNaUo4N0o5?=
 =?utf-8?B?bm1YNmZXTy9KenNZQzh0VXBETUMxSTloYkNkSS9QUHRNc1RZL0xjNm9MQjJw?=
 =?utf-8?B?SFNzSHR2L1hKeXRZU3BGWGxKSCthWkhiRDVwN2tBWjlTNjJUNDNJeC96eUFI?=
 =?utf-8?B?UG80YUVCUG5oL3lTeTVlWW1qZWUwc3hNMTJLK2JnZXRXME8xVmFlOUROajBm?=
 =?utf-8?B?OG5FNW5HTHRDOG12Rkt1am1OajFJSmRjOVJvWnRyTjNiVDZrRWJVVytoM2tQ?=
 =?utf-8?B?Uml5VUlHWEsvZnFqb3RtZmlCRHY4UmRpczFBQkFSUmtPTjJMRUlPMHg1RUU2?=
 =?utf-8?B?MnBlNTBsd2wwbXRxTjJZazRYNUNpVGh1cGcyc2pyeEZMcEgwRGJ0WXJ2V1Vw?=
 =?utf-8?B?RHd5eE1kSG9IUjJKam1aVFFXZWkrVXlNOG03TnpFbmljU0N1RFNXM2lKbTB0?=
 =?utf-8?B?RFMxdlJyZTdsMzdzaWxoRmU1bUZCK1FiVHBiVGxoUUJCU3kyZUxsSWEvRk50?=
 =?utf-8?B?MkZPTWhHWkMxaHAxUFhJTDhpK043bnc3dmNOOGlEeGlSRENzVDVqSng5ZXQ0?=
 =?utf-8?B?RmlwNzdkMkVTQjZnQUluOHVQK2RBeGNYeWo1cmEyRVAwbFhWNmRZY24zem42?=
 =?utf-8?B?VWxMRGxXWDdWRzlJNlh0SUYrNHBpaFV5TStmb1drV0FPQStFQW5qTzhJcDdF?=
 =?utf-8?B?MUxMNzY5YUI0MkhVZmxPUjFibFlGcmV0OW5TRlpKanFvM2lkYVVtMW9KWDQ3?=
 =?utf-8?B?TGhMYUZybzNrYWswUVd2N3pNcFZRbHFmYlI3WkdTZE85RmM4MWlMV3l1Q2FK?=
 =?utf-8?B?S1dQQW1LcDg3QVVySkpQUXkzYnZ2OGM0NE5lZjRTaXpvQUR6KzFGSFllS0Fs?=
 =?utf-8?B?MVpmY0hoMGtTb2w1OEZIRG1sU2NDVi9Ebm9TblJDTURGUU9RWE5IMWlmbktE?=
 =?utf-8?B?SVphM1E4NEpicGRxUS9WYVMwRnhPWnNpeVZQQnU0TlNPeFFHYU5SSzdUWjcr?=
 =?utf-8?B?VFpaYjJ6UklDclJnQ2FycnVVRmVrTGlLTU5LYmlJcUFBUUk5dUNxNXBNMXdu?=
 =?utf-8?B?ek5WZVl4WlRCV2ZlSTBDbk5sMm5JdnhyN1pDRXJMT1lCOHRyRldpK05BZXVw?=
 =?utf-8?B?ZGJlN01BdWd3M2E5eVM5T3MxbnFoU0JNQ2puaFhqaWZwN0Z3aDFEVllvU3ZN?=
 =?utf-8?B?VEExdEs4M2NOc1R2SldkR2xYaEI0STYyb01xYy83UWNMVkRVV251TDE4d3Ba?=
 =?utf-8?B?OUFBZDQ2eDJ3bFQ3WG5DVld0MVRjN3JMbkRsK0RmRmpnMlFGSWo0SU4rV2No?=
 =?utf-8?B?SnVRN0s1OUJjYjVUZUx6R004SndVYWFOdUthSWw2ZStTMkpQZERCTy9sdzJE?=
 =?utf-8?B?QXlqdklwTUxpalZIdmpHS3Y5ejcwQlFOT1Rpbm9BNncxUmIzQ0pQZWdUdVY2?=
 =?utf-8?B?dFRFeHlQQzEvclFlZ0dkdmtWVis3YWNlcHdDN1BrQWdOd2VCUFJjcmN2a3pE?=
 =?utf-8?B?dW1DcGJ4cmtyVE4zeGpFdk1JZzhEN2VGaWYzZUhWRStESkc4U1ZxZ05WVmtT?=
 =?utf-8?B?ZTFlcHlWTUlibDNvdEpUNXd0YVVNdEJqQWlTZWVwRUpEbFZQWXBUbER5YXpX?=
 =?utf-8?B?QXJjOU1UdVdUY3oyOVpvWWYwMUE5M2c2WkpYKzFvN2dmUzlKSFA4ZmsvMVNF?=
 =?utf-8?B?bHpwQks4Ni8vaTRuR0w4TnM2REt0cHdVSW5VMDFsQWpSUGZSREFzdGVyUExV?=
 =?utf-8?B?NEx5dXJqNTRhc0hwN3BWL2ovT0ZaQnlobkhCUUlPdmpjZ3dLQnM0OUR1N0U3?=
 =?utf-8?B?UUNmUkw5cm0rRXFST3JqMlJEVURjaGczbzZlVGlZWENZaER1dmQyTDkxOGx0?=
 =?utf-8?B?RXJCM2c1K2RGSVV1WkR1endncGpqQ29zeGxybS9LU0lMckgwb1hXQ0ptZWlY?=
 =?utf-8?B?M2ZzNFZRZ0hsd3dqWUFLYjM4cTlERC9WSU5tVHA5NVVibG9KUHo3Yk13YzVo?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR07MB8412.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ab17a8-68f6-43b2-85c1-08dc38778e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 16:08:52.4661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mmSGNvXkdoGcOLRFwH4rZPNbAu3Cr1kjXIfSexTewgRx60+xVBVpSAVuAL1Xu98ec0GerCZsL+ttrtBLPX6Mfi6d0TyQ18oYXx35TrqV3vY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9691
Received-SPF: pass client-ip=2a01:111:f403:260f::601;
 envelope-from=sriram.yagnaraman@ericsson.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWtpaGlrbyBPZGFraSA8
YWtpaGlrby5vZGFraUBkYXluaXguY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIDI4IEZlYnJ1YXJ5
IDIwMjQgMTI6MzMNCj4gVG86IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJv
Lm9yZz47IE1pY2hhZWwgUy4gVHNpcmtpbg0KPiA8bXN0QHJlZGhhdC5jb20+OyBNYXJjZWwgQXBm
ZWxiYXVtIDxtYXJjZWwuYXBmZWxiYXVtQGdtYWlsLmNvbT47DQo+IEFsZXggV2lsbGlhbXNvbiA8
YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+OyBDw6lkcmljIExlIEdvYXRlcg0KPiA8Y2xnQHJl
ZGhhdC5jb20+OyBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPjsgRGFuaWVsIFAu
DQo+IEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT47IEVkdWFyZG8gSGFia29zdA0KPiA8
ZWR1YXJkb0BoYWJrb3N0Lm5ldD47IFNyaXJhbSBZYWduYXJhbWFuDQo+IDxzcmlyYW0ueWFnbmFy
YW1hbkBlcmljc3Nvbi5jb20+OyBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPjsNCj4g
S2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPjsgS2xhdXMgSmVuc2VuIDxpdHNAaXJyZWxl
dmFudC5kaz47IE1hcmt1cw0KPiBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCj4gQ2M6
IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgcWVtdS1ibG9ja0Bub25nbnUub3JnOyBBa2loaWtvIE9k
YWtpDQo+IDxha2loaWtvLm9kYWtpQGRheW5peC5jb20+OyBxZW11LXN0YWJsZUBub25nbnUub3Jn
DQo+IFN1YmplY3Q6IFtQQVRDSCB2OCAwMi8xNV0gcGNpZV9zcmlvdjogVmFsaWRhdGUgTnVtVkZz
DQo+IA0KPiBUaGUgZ3Vlc3QgbWF5IHdyaXRlIE51bVZGcyBncmVhdGVyIHRoYW4gVG90YWxWRnMg
YW5kIHRoYXQgY2FuIGxlYWQgdG8gYnVmZmVyDQo+IG92ZXJmbG93IGluIFZGIGltcGxlbWVudGF0
aW9ucy4NCj4gDQo+IENjOiBxZW11LXN0YWJsZUBub25nbnUub3JnDQo+IEZpeGVzOiBDVkUtMjAy
NC0yNjMyNw0KPiBGaXhlczogN2MwZmE4ZGZmODExICgicGNpZTogQWRkIHN1cHBvcnQgZm9yIFNp
bmdsZSBSb290IEkvTyBWaXJ0dWFsaXphdGlvbg0KPiAoU1IvSU9WKSIpDQo+IFNpZ25lZC1vZmYt
Ynk6IEFraWhpa28gT2Rha2kgPGFraWhpa28ub2Rha2lAZGF5bml4LmNvbT4NCj4gLS0tDQo+ICBo
dy9wY2kvcGNpZV9zcmlvdi5jIHwgMyArKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9wY2kvcGNpZV9zcmlvdi5jIGIvaHcvcGNpL3Bj
aWVfc3Jpb3YuYyBpbmRleA0KPiBhMWZlNjVmNWQ4MDEuLmRhMjA5YjdmNDdmZCAxMDA2NDQNCj4g
LS0tIGEvaHcvcGNpL3BjaWVfc3Jpb3YuYw0KPiArKysgYi9ody9wY2kvcGNpZV9zcmlvdi5jDQo+
IEBAIC0xNzYsNiArMTc2LDkgQEAgc3RhdGljIHZvaWQgcmVnaXN0ZXJfdmZzKFBDSURldmljZSAq
ZGV2KQ0KPiANCj4gICAgICBhc3NlcnQoc3Jpb3ZfY2FwID4gMCk7DQo+ICAgICAgbnVtX3ZmcyA9
IHBjaV9nZXRfd29yZChkZXYtPmNvbmZpZyArIHNyaW92X2NhcCArIFBDSV9TUklPVl9OVU1fVkYp
Ow0KPiArICAgIGlmIChudW1fdmZzID4gcGNpX2dldF93b3JkKGRldi0+Y29uZmlnICsgc3Jpb3Zf
Y2FwICsNCj4gUENJX1NSSU9WX1RPVEFMX1ZGKSkgew0KPiArICAgICAgICByZXR1cm47DQo+ICsg
ICAgfQ0KPiANCj4gICAgICBkZXYtPmV4cC5zcmlvdl9wZi52ZiA9IGdfbmV3KFBDSURldmljZSAq
LCBudW1fdmZzKTsNCj4gDQo+IA0KPiAtLQ0KPiAyLjQzLjINCg0KQXNzdW1pbmcgY2hhbmdlIG9m
IG15IG1haWwgYWRkcmVzcyBmcm9tIHNyaXJhbS55YWduYXJhbWFuQGVzdC50ZWNoIHRvIEBlcmlj
c3Nvbi5jb20gaXMgYWNjZXB0ZWQsDQpSZXZpZXdlZC1ieTogU3JpcmFtIFlhZ25hcmFtYW4gPHNy
aXJhbS55YWduYXJhbWFuQGVyaWNzc29uLmNvbT4NCg==

