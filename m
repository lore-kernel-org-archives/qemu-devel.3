Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25E1C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 16:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfMig-0003oJ-Ic; Wed, 28 Feb 2024 11:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sriram.yagnaraman@ericsson.com>)
 id 1rfMie-0003mv-V0; Wed, 28 Feb 2024 11:23:44 -0500
Received: from mail-dbaeur03on20600.outbound.protection.outlook.com
 ([2a01:111:f403:260d::600]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sriram.yagnaraman@ericsson.com>)
 id 1rfMid-0000jF-GE; Wed, 28 Feb 2024 11:23:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRccI1lx4nQ/6aNrTXdCTpINQgWlU7io768DW/PW2MFrU7+pOcdxjzBUaL8N2XDwWAkFYaItd+jS649/paQGQcQ7J/kZBLR14HKaX5KA+DvhzXNNOHJxL+YNOverIHK6PXyl29fnILDALS+2hnl7FeI130qdE+DGI2xq0CL7DiHZ+d+TXFDszLLT4t2udFl4Lc7Tsp1yviS6YRz1SUeHPx7mB8DVmCBhxwCYr8iIGNeg7Rh6JaMSPR5+1QyfIeuzQib39ZhrGE6lwspEN3rMuvvGZEzvDJNMxaRstP48YDzMURhWqiujnMHzx2/mB2VS7Q3pTbjzRqBKcTCxsLzWhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYqpxj6Kjlw+utTqIOy6dT6gFiBYUf6EIFzpsnYAPKQ=;
 b=Flaogo36auRQgxgnIAgzf7AjnfYj6t6ztY9SV6gPzZyGMkmcioo4uW7oQpjixNO0rDCmNw5GC6hnr606fUwhbZUcgPHwugTi/SwGUwWrM2aPpWAv3Yag4Z6G5mlXtK8M/LBWb8EGoRgzQ9nliutpNhGosSeT/ZmTz+wSA1qGzsZxZ8D2zp8LqOR7VZ46zfyBR1Dq/SsYEDMjMOaE5A3UR0DAjuW8kTlLdRsCa9LWgiW5zyI5R7T7O30ZXNa3qTchqKizT/UHb5zht1S49nb+3CojCH3O17mA00LKfrlwR0rT4o2lfX/zPBEdgNuXF4MPIYRCsQgjd6oMKESfQdiCZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYqpxj6Kjlw+utTqIOy6dT6gFiBYUf6EIFzpsnYAPKQ=;
 b=XbA3J1BaHanB1B1YHhG894eUamnF3R7w6bPE9SMvXCb1ZmoYOvHS3MOUMQPy/C6hnIiDqRmMUpFN/1Nlf9UTxRMu7AZklkW9M1UJONVIdieWFkGDDBQpL93BsP08WEjgdCXDsPWRMlrAEeKeTWQ0rnlGTWvWpusb9vlineXHqSYbsX3Ge06QT/WCCfTzVJ1/0HySFnb74EMzVyBfiKooYggg2Dso/fpRwN6KBsoE+xl2N7IVqwt33evgo/sq053+YpS/t636eWmUlYow14W7WYuopnTiE6Gk543L4gPOhotloWAc4wxKTJqyEdDxMjKLy26+SIZAnzriGjp2TkOUug==
Received: from AS4PR07MB8412.eurprd07.prod.outlook.com (2603:10a6:20b:4e3::19)
 by VI1PR07MB6303.eurprd07.prod.outlook.com (2603:10a6:800:140::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 16:23:39 +0000
Received: from AS4PR07MB8412.eurprd07.prod.outlook.com
 ([fe80::3507:c490:b2f:ab2c]) by AS4PR07MB8412.eurprd07.prod.outlook.com
 ([fe80::3507:c490:b2f:ab2c%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 16:23:39 +0000
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
 <qemu-block@nongnu.org>
Subject: RE: [PATCH v8 05/15] hw/pci: Always call pcie_sriov_pf_reset()
Thread-Topic: [PATCH v8 05/15] hw/pci: Always call pcie_sriov_pf_reset()
Thread-Index: AQHaajoIVe3nCZ15lUKkI4lEo2R4eLEf5OkA
Date: Wed, 28 Feb 2024 16:23:39 +0000
Message-ID: <AS4PR07MB841202E00137A2E5EC0976F490582@AS4PR07MB8412.eurprd07.prod.outlook.com>
References: <20240228-reuse-v8-0-282660281e60@daynix.com>
 <20240228-reuse-v8-5-282660281e60@daynix.com>
In-Reply-To: <20240228-reuse-v8-5-282660281e60@daynix.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR07MB8412:EE_|VI1PR07MB6303:EE_
x-ms-office365-filtering-correlation-id: 781df07c-81c7-4515-d4ec-08dc38799f29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TMMoW5GAi0ExlRAc7S8eqUhNddLi7dmY3XgFAyDSmjBGceO0vejNCKkUDJwhVbryp39HLYkzsnKJAqX5ruNnV1g1utZu9NzMeE5afDG2Bxluiq5dRpnxKqPyVvcfecZHT4GhiaSU5kV0RuH0GG6oCu3weWUHqZZbTamfx4ulnTL5FDb+RXoNN1k1wU8unVeup/VKHnqQL96qWNkGo5iamza9fa0PK1qeULc8RtN6Xu5zA7Zk0Q25SLcqC3GN5Wk1nkdMULfLiPxj20ImPmeVUq031MFh1XUNrurjJRahcwwZN9r7xGskZGh4koZk+wm2+CAI9O6rtPD9SksVDEUCzv0U3XYaBRUXR1+M9vkEsyNHRBBNgEQGKfqcqUMQbBwE3RwaDuYWKLmLeIS82IkwYjiRy4pddaKU5bNJR6OcrZSTTgR5WQEUYFF+bJ0wgZMoukMXTdikBwQFkiJQyjWNrovpuI+RirGj4xpQIhj0FZA2qi+SFwAY5Uxx78tCWShItP1wEK3MpJU5tTsqAF/lUGrrsKP9iDYbOxu18x256hC+Aro8ND6c7n01gFqcsX3Cm7hegnFQfIkEdjjmIV6ttXW9YZO4HbDMBYKvUh8JHd24TTv7lyZ+6LohF7bJ+dNbH47XXxw7UOOPwOaUEMpWJs1W4qdHsjEKb0xOumL2hs9qurExmhNoOfrhvOfhcYmEgzcEyet6qPzcqN9WSW1YD6D5caBgSixpE2zlSnNxoeg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR07MB8412.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009)(921011); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmJGZjhLUUxmM2dVRFZQdjRCemp6SXBSYU01TFZ2K0M0UUR1VlM2bnNEWXBk?=
 =?utf-8?B?cm9JY1NxbThkdlZvZFFQOVkvTmpmeXJNVXBscDlaelhoaG5aWjhMbUlldGlv?=
 =?utf-8?B?eCtNbXhTZjhQRmpUVjdJU0NYUytmVHE5YmJTM2xEVnhNa2xtNWlmaDQyUmtt?=
 =?utf-8?B?RmQ4Y2JDSnk3UkFEQlNuQ0UwdjEyTkdOZi92aGFJN0l4YlRwdytidGsvQUds?=
 =?utf-8?B?cWZvcVA4eXBHVlJhNVoyTXMwb3dLRUx1UGNOWS9Pdi9SWDhad001dE50V004?=
 =?utf-8?B?YkxuMEt5TXFRdEVmS0xYRXNGaXpDdXA5S0RpbjU0MWI5cXhLbFI5SmZEams4?=
 =?utf-8?B?RURKUGdqMExiZkNpb2ZFbm9MUGI4SzBhd01QV2w1Skd0Z1B3QVV6L1BiRjEz?=
 =?utf-8?B?c0dUd215TnAxL2xRSVFoK3lrTFIrZ3BJSWk5d1haai9pbU4rMTU0amw2RlBi?=
 =?utf-8?B?andmelM4eTRZT0hLYWdhZjNBdmJzM2xOcitodEtMRmkwSHB5N3FQeDZaMjdY?=
 =?utf-8?B?YVVMTDJUeHNRQkJZamx0aXlvVFFUakQ2YlBtRVJVbGl2S2xNa2R1Mk1lK0Z6?=
 =?utf-8?B?dGppYlk2K290WEM1VGZxVzREeWd4YTZQeU53R24yU3FWQ0dmMmExcDZmZkcz?=
 =?utf-8?B?cUtrK1V5Y1VLeTV6NUs4ejN4NkhrWVU1U29VZVJmN01mWlBjNHU0Y2c1Z2xR?=
 =?utf-8?B?QnpzNk5wZ29qWWVzZ1ZLRXN6UDFrVnlSb002RzhSeFFQYUhpeFZTcXZrZ01s?=
 =?utf-8?B?RGRHdmRxYXpTN1o5MHJlS3pjZVdRUmxnc2MxazAzNEFzWkJ1dVpFejBQbFJF?=
 =?utf-8?B?ZDFteWJHLytmUlJZVnNJQjZCSHMrcEo3azhmbktxL09mM1I5d0tKRk1UQzRR?=
 =?utf-8?B?WEswaEpoQnVZdGR1QUtBbnFWK3JHaGVheHZFRTU5YlZ4L01URmFWNDIrNEFq?=
 =?utf-8?B?SU4rZXk3RzJGWjZ4WVNMcWx2ODFZd2RNdDFrZlNWTGY3YjhsMUJKendFRG5L?=
 =?utf-8?B?Y05hcTJEL3MyQWRzR1BxdURVc1IzcjlUM1E4eFV3VllrTXZ0MlhJNlc3K0lR?=
 =?utf-8?B?cEs4YjNFMjZKNFpjZWpTYVJrbFVoaHUwUWZpTEp0aHRPcXVLcWVURTNVVUs3?=
 =?utf-8?B?dHg2SmtrYllwbHhGbXNOcDl4TjJhY3F2UkRrU29wSUxBbThCY1dvQ2xvK3kx?=
 =?utf-8?B?SDYwcm5ZdXBVUVRsaHo3MWRQUHhrckI5S1lheDBnRXErY3ZFTHVyUHJHdVNV?=
 =?utf-8?B?dlpoTXdUTkk3VXMvSVg0a3JHV1hPalZ2c1dramJsa2luU2hYRXJVUUdveEFj?=
 =?utf-8?B?cEZoNE0vZmlaZTFFOUc2UXVwNTAzZytHaHFZak5EeFdlZlg2T2VaL20wdEFO?=
 =?utf-8?B?eVZkbzV0TkZNZ2w1NnN0Lzl2MnNSTlYzQkFQeko1TysrYU9PcjVaVm0yc1ZY?=
 =?utf-8?B?a2QrUVhqWWloRzN6RFA0WEpLaFQ1WnVWem1ZcFJWQmpkZ2NlbWpXTHU5TU1i?=
 =?utf-8?B?QTBSMW9LaC9kb3RKTlhibDBUMjhhRWJuU2pObkdPWXNWY1RFaEhXaEdrRFI4?=
 =?utf-8?B?UktjN25GNUUwbUNNZ2orN3hpVUp1TGRNNHF6bmg0Yk5ON0JlNXRaRTMxYm5m?=
 =?utf-8?B?c3VYdW5JVUlTVEFlQ2dDUWdmSk5oR0RuYkhJMnlRcVhad2JSYWJqWEtOeHRm?=
 =?utf-8?B?VU0vS25KVkphMlBjaVprQ21vK25tSS9uamdzenVXcjlOTXNVNkxoNXltam4w?=
 =?utf-8?B?ejlCVmt3dzhMZ0VKZkZFc28vUGVPdXBHaHN5WEZIZnBZaXpieENqU244VWJt?=
 =?utf-8?B?Tm50ZkYraVAxYlluOHZjV1FFejBGOUV0ZHp3UjBzaWdHYWVCTVhMYXE3MGNh?=
 =?utf-8?B?NENvcFN4T1FYeTJTYmkyaU5naG9iZjd4UXB6cEppNXhkbXRuY2ZJSkZESVhD?=
 =?utf-8?B?cEFnaHlyQVNIa3VEQ0g1UGNjWE9RUzViN0kxWkhoYkt5ZU5IaEdJS0FPK3Rp?=
 =?utf-8?B?RkcrVzN1TzhaMnFuL1lpaFdRNGdWUTdjYlA1bENOT2grUmZ2OGNSZyt5K2lN?=
 =?utf-8?B?Q3hwWGRKeEROMlhXc0RVWkhJMXJ5ZmZCSVBtMlpTZDNPcmxYaWpMc2U2YTB5?=
 =?utf-8?B?Witob1Y2OThqSVhwbDJlUXZuQUcvd1BBQ2g4QTRoSlNmUGk4a1drK2poYklI?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR07MB8412.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781df07c-81c7-4515-d4ec-08dc38799f29
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 16:23:39.2056 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ny5Jc+z9wMEKfALv4NWiK9rY0aiiyQPzlRdcgRP5+JLXxWO8DhM8i60jNz1eDQTZx5C4OEoqYjpEKDajDdVSroHDPOSQEjwpdCDZ4KWxd5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6303
Received-SPF: pass client-ip=2a01:111:f403:260d::600;
 envelope-from=sriram.yagnaraman@ericsson.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
YWtpDQo+IDxha2loaWtvLm9kYWtpQGRheW5peC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2OCAw
NS8xNV0gaHcvcGNpOiBBbHdheXMgY2FsbCBwY2llX3NyaW92X3BmX3Jlc2V0KCkNCj4gDQo+IENh
bGwgcGNpZV9zcmlvdl9wZl9yZXNldCgpIGZyb20gcGNpX2RvX2RldmljZV9yZXNldCgpIGp1c3Qg
YXMgd2UgZG8gZm9yDQo+IG1zaV9yZXNldCgpIGFuZCBtc2l4X3Jlc2V0KCkgdG8gcHJldmVudCBk
dXBsaWNhdGluZyBjb2RlIGZvciBlYWNoIFNSLUlPViBQRi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEFraWhpa28gT2Rha2kgPGFraWhpa28ub2Rha2lAZGF5bml4LmNvbT4NCj4gLS0tDQo+ICBody9u
ZXQvaWdiLmMgICB8IDIgLS0NCj4gIGh3L252bWUvY3RybC5jIHwgNCAtLS0tDQo+ICBody9wY2kv
cGNpLmMgICB8IDEgKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNiBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9uZXQvaWdiLmMgYi9ody9uZXQvaWdiLmMg
aW5kZXggOTM0NTUwNmY4MWVjLi45YjM3NTIzZDZkZjgNCj4gMTAwNjQ0DQo+IC0tLSBhL2h3L25l
dC9pZ2IuYw0KPiArKysgYi9ody9uZXQvaWdiLmMNCj4gQEAgLTQ4OCwxMiArNDg4LDEwIEBAIHN0
YXRpYyB2b2lkIGlnYl9wY2lfdW5pbml0KFBDSURldmljZSAqcGNpX2RldikNCj4gDQo+ICBzdGF0
aWMgdm9pZCBpZ2JfcWRldl9yZXNldF9ob2xkKE9iamVjdCAqb2JqKSAgew0KPiAtICAgIFBDSURl
dmljZSAqZCA9IFBDSV9ERVZJQ0Uob2JqKTsNCj4gICAgICBJR0JTdGF0ZSAqcyA9IElHQihvYmop
Ow0KPiANCj4gICAgICB0cmFjZV9lMTAwMGVfY2JfcWRldl9yZXNldF9ob2xkKCk7DQo+IA0KPiAt
ICAgIHBjaWVfc3Jpb3ZfcGZfcmVzZXQoZCk7DQo+ICAgICAgaWdiX2NvcmVfcmVzZXQoJnMtPmNv
cmUpOw0KPiAgfQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L252bWUvY3RybC5jIGIvaHcvbnZtZS9j
dHJsLmMgaW5kZXgNCj4gN2MwZDNmMTA4NzI0Li5jMWFmNGI4N2IzNGEgMTAwNjQ0DQo+IC0tLSBh
L2h3L252bWUvY3RybC5jDQo+ICsrKyBiL2h3L252bWUvY3RybC5jDQo+IEBAIC03MTE0LDEwICs3
MTE0LDYgQEAgc3RhdGljIHZvaWQgbnZtZV9jdHJsX3Jlc2V0KE52bWVDdHJsICpuLA0KPiBOdm1l
UmVzZXRUeXBlIHJzdCkNCj4gICAgICAgICAgICAgICAgICBzY3RybCA9ICZuLT5zZWNfY3RybF9s
aXN0LnNlY1tpXTsNCj4gICAgICAgICAgICAgICAgICBudm1lX3ZpcnRfc2V0X3N0YXRlKG4sIGxl
MTZfdG9fY3B1KHNjdHJsLT5zY2lkKSwgZmFsc2UpOw0KPiAgICAgICAgICAgICAgfQ0KPiAtDQo+
IC0gICAgICAgICAgICBpZiAocnN0ICE9IE5WTUVfUkVTRVRfQ09OVFJPTExFUikgew0KPiAtICAg
ICAgICAgICAgICAgIHBjaWVfc3Jpb3ZfcGZfcmVzZXQocGNpX2Rldik7DQo+IC0gICAgICAgICAg
ICB9DQo+ICAgICAgICAgIH0NCj4gDQo+ICAgICAgICAgIGlmIChyc3QgIT0gTlZNRV9SRVNFVF9D
T05UUk9MTEVSKSB7IGRpZmYgLS1naXQgYS9ody9wY2kvcGNpLmMNCj4gYi9ody9wY2kvcGNpLmMg
aW5kZXggNjQ5NmQwMjdjYTYxLi5lN2EzOWNiMjAzYWUgMTAwNjQ0DQo+IC0tLSBhL2h3L3BjaS9w
Y2kuYw0KPiArKysgYi9ody9wY2kvcGNpLmMNCj4gQEAgLTQwOSw2ICs0MDksNyBAQCBzdGF0aWMg
dm9pZCBwY2lfZG9fZGV2aWNlX3Jlc2V0KFBDSURldmljZSAqZGV2KQ0KPiANCj4gICAgICBtc2lf
cmVzZXQoZGV2KTsNCj4gICAgICBtc2l4X3Jlc2V0KGRldik7DQo+ICsgICAgcGNpZV9zcmlvdl9w
Zl9yZXNldChkZXYpOw0KPiAgfQ0KPiANCj4gIC8qDQo+IA0KPiAtLQ0KPiAyLjQzLjINCg0KQXNz
dW1pbmcgY2hhbmdlIG9mIG15IG1haWwgYWRkcmVzcyBmcm9tIHNyaXJhbS55YWduYXJhbWFuQGVz
dC50ZWNoIHRvIEBlcmljc3Nvbi5jb20gaXMgYWNjZXB0ZWQsDQpSZXZpZXdlZC1ieTogU3JpcmFt
IFlhZ25hcmFtYW4gPHNyaXJhbS55YWduYXJhbWFuQGVyaWNzc29uLmNvbT4NCg==

