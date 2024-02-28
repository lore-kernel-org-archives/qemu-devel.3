Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B249FC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 16:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfMiV-0003jP-4m; Wed, 28 Feb 2024 11:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sriram.yagnaraman@ericsson.com>)
 id 1rfMiT-0003j8-PS; Wed, 28 Feb 2024 11:23:33 -0500
Received: from mail-am7eur03on20600.outbound.protection.outlook.com
 ([2a01:111:f403:260e::600]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sriram.yagnaraman@ericsson.com>)
 id 1rfMiR-0000h6-Uy; Wed, 28 Feb 2024 11:23:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcKnHxyx8Pa00UNu6jr1pYh1StG2cH8VCuOPoAs7IVI0tx3LHZViNPc8jnueqdr7lsjqNr/KtaHamcQsFeigKnlFhTrLxdyfeqj0vzDr6tTaG2do1Q8WkgfyBwotbtKd/GxTg7TNsdGv4IA8RLcx+75zJ3fYD8FAhgs6pvIugX39TdoXV5C2sVUSnmkrEyqNezBnyjoYJ/ur5l9ZUxCJXF0yNcgHmOE6zsfrqp1FILxJbExNqR31mAIfp83LBrHMMVdk0mOIgv4Go1bqeS11uAQukGImDPe5bz/THhyZ3wTaDAOLbeEABFqOFrrh82odQOx9DuEaYLYFyMpdRnPYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqdqHu7LSknc4ubPvFGDjS5G4tXsH0TvINtePkjJa5c=;
 b=TSRQBZbkdgkeNYVXvN958+wBEr9+zclwbdfZMo2/HwU/uGAR7CAIsa+WWuVqadiiWIaovjCqU2rUuiMurXnV/xaFH7FuSfnvhds5Xv61CXXsZwMKswJ8cYFEYeTaBJNjEDBQF9Mb2TyYS1xCIEgvMQgOFeutKUhNeknxXOQkZ7dSeEIe3rLAoqgRUzzmkVjDk/ohhYkR27exGtzjfM7qKJd9VIyuWeOj2LETZV5DlrwrXYWT7K08+hN4ZMPXuWa2z2ZS6UnhrmkEI3L2LqCWJm4AZuv6Vzf93L7qklcUGg7f4j6Fj1d0B6valKwZ8DjYy03KrGCzTmbHZklOv7hh1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqdqHu7LSknc4ubPvFGDjS5G4tXsH0TvINtePkjJa5c=;
 b=HKXR0J0zWO1DaxRCrKV01nA02Z5AMgeS8UK4tnewTJK/uJO548qswRhU8+vTrly3Lv5LnQzL4b3riSq8MFi1Uc9SUetafHYrTJMqLc9eckvYJOkwYLz7AjfL6YuZ/b4YDHpw1ls5IDmpR9ll7eoVakG2PRee3I9NexdecUPR73h9bOrY/utEAE53OnzZU+X5s9npk/r7t5BC/0dZtd51/urNkv+xBbgYzLW80OOUfYTQZova9wMNOK5iTM5OSrXT7de7t0kXM8NwMFjH4opfI3jQGb61wZuXbno3AgwmUoS6UwaEkVZBH+VIr9X5xwozW6eKSc39zzKqGf4FWJu9Bg==
Received: from AS4PR07MB8412.eurprd07.prod.outlook.com (2603:10a6:20b:4e3::19)
 by DB9PR07MB9784.eurprd07.prod.outlook.com (2603:10a6:10:4ec::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 16:23:28 +0000
Received: from AS4PR07MB8412.eurprd07.prod.outlook.com
 ([fe80::3507:c490:b2f:ab2c]) by AS4PR07MB8412.eurprd07.prod.outlook.com
 ([fe80::3507:c490:b2f:ab2c%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 16:23:28 +0000
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
Subject: RE: [PATCH v8 03/15] pcie_sriov: Reset SR-IOV extended capability
Thread-Topic: [PATCH v8 03/15] pcie_sriov: Reset SR-IOV extended capability
Thread-Index: AQHaajoBhRwmApIjzkqNcTiWtYxk97Ef4yOw
Date: Wed, 28 Feb 2024 16:23:27 +0000
Message-ID: <AS4PR07MB8412339C60640B86A894664B90582@AS4PR07MB8412.eurprd07.prod.outlook.com>
References: <20240228-reuse-v8-0-282660281e60@daynix.com>
 <20240228-reuse-v8-3-282660281e60@daynix.com>
In-Reply-To: <20240228-reuse-v8-3-282660281e60@daynix.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR07MB8412:EE_|DB9PR07MB9784:EE_
x-ms-office365-filtering-correlation-id: 24ebc32d-2bd2-41a8-70cd-08dc3879987c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e0huxwhosOak0r6BSfqOBwCIAuXqJMOPHnzuH5bXSzSjJHPnofb7/sWGyjwEycoO8zONyteL8szekC0GuSVw93AYXteGp3uiYLEVVnHPXn2RFLlwwX0oY8Q3HRGrPwjgL6GIxi5XG+2Sv3qhsj+VNL2BeA0AyMHyuMvfvOaHas7H5EvEeZNJk+ZbR7SNl42wjJjxaRENnbxkqq2/E6SGsy7EN4WQtFW77kcQt8EaJapei+KAJDgGDTvU42z7f3gvuecojJuQOKTD6+WOE26MmIdDAHfSQPMKDBaiy5AQVl61K8o5X8VZ47i7QqZhwq0NGnHYSQx37bYg0ckL03VCSQ7OX1mOOrPNyZpuLMOvyvE+wFTSJXXiG1CFrTWTARutmaT4YPJWsDTHQEFY3jh8fa6vSKlrCVc54bK+ckAc7lGpvhIg5Gq00MX7DGRMm/13i2xiuqa3ER6EmwO5nMp9bBgbqC58xF/l38u0Y0GVdqr55EpBnzMTs9So/a/T6VH/8J0KR0bka9BDN8mJbcOFv+SDYz779G14tR2xMVvtMHHR+ELGfqEMvNuizqsYniQXKSthSxN5NB7Ncbyw8gfuzLJ2zF8whY7gRg8C9VjgP8IXZQxDFSf8pDbAZuoqiwvo36WWBISmInTHgTk9pHMhiyR8Zca3u00eNqo4Si+XHfSzxzFNvfe5E+F9AmpteVILVRQGjNSADXPW9cXa8THJ/xKFhYh0kCPCdAJT4fnpK6M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR07MB8412.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009)(921011); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTdUeWkwdlhZMmNRRUZ1UnJQQjJtYmhwUnJmcFhiMDEwcStvdE1ZZkxCSDNq?=
 =?utf-8?B?NFNYaWFqY3QyUFRvRGJjZVBxN2tBa2RKTW8rOUVOd1dwcmZPZmxIRm1vbTdt?=
 =?utf-8?B?dXJKc1pwQnhoZDBWM2F2MkxGVWcrTS96U2dGN0RDQWNRSEF5MWtVdnZhbUxO?=
 =?utf-8?B?TWQ4M0gxTWVwTTdpM1hWN09yazRQUGtkQUVhdTQ0MlJpR0ppaVkxN3dhTWd0?=
 =?utf-8?B?RVk4aE9iWHBVS2k2UGg3WUY5ZUlWUENUN1kxYVJidk1aTGNPN0RpWU1UQVhi?=
 =?utf-8?B?TGtyaDdwRjBzU2krTUM2cUtWZS9SRnpYMGNjNjluVTA4djJWclIwcFBhMHhv?=
 =?utf-8?B?SzJjQit2S3hZWTlkdnR6Y2tHVnNlSW0yT0dRdEszWWNSM21vaXRmc2k4YkY0?=
 =?utf-8?B?RVJDZkhMbjIveXVoRDl5bVByWTRCTGFrMHA1SFMvRTNSZU41K0kxWWQ5QkpB?=
 =?utf-8?B?L1FDclQ3YUQ2dnh3Y3FXOVRhTzVyQWxZaEZiNUtLckdpL1gwV3llWVIrT0V5?=
 =?utf-8?B?OWllVGh3RXl3eTlzOVdMY3ZpQlVBY2V6bkFDTk8zU1BCanV1OFQ5Ynp5V1l2?=
 =?utf-8?B?d3R1Y2IzUTRRTU5ER1RxbHRWWFBLQ3hVZS9vdUNDdGVuQkd4VGV3Rk5ZblJ0?=
 =?utf-8?B?eVZWUGVvYTJQdXhsTVZGbmJDREtGdUxjRlRBZy9icVZzenlSS05WVnZzeXcx?=
 =?utf-8?B?YmUwMWpJcXlFU29nOUVZQ0YyeTFWOHB4QzJmR0YxU1lNd2txcXFFRk9tbnRw?=
 =?utf-8?B?OUtHZmZoeTU5S3pxTlJRTzBxNXE4ai83cTJJOGI5UWYvU2Y0VWxHMU5mVGtZ?=
 =?utf-8?B?Y21FT1dVRk43OHlFMm1Ea1A1ZzVKTmg5R2p5dnFjcG5MMUxGak8vRHlpUUp3?=
 =?utf-8?B?a05GTTdpRmRGSGZOZGs3WEpoeENMSFlwZzk2OEtjVm1KbW5DWC84bU9UZjNX?=
 =?utf-8?B?TWd1bWJhWHBXbG9vQS9YbXgyV1FGZHJlMmNBSEpCbWQ4dStnRDVpd0kwQlBC?=
 =?utf-8?B?Q3ZXUUtFTlRaRjRDYzMvVDY4QVpldk1IWFBRM1FwY3F2QndmSDZzL0tBS2R6?=
 =?utf-8?B?cFp1TzBCczh1Si9sMlJrbTdVdEtOMG1NalVBYjloRExKOGQrTEtnNlJZM0VE?=
 =?utf-8?B?Z2ZKMkZoYWlEbEpmQVNyVGxTK3g0anExci9aaEJZaFk0ZGh0b0dqOGJFMk5W?=
 =?utf-8?B?aElWemhmS1RmdU05d2VUVXFVMEtBb0dQd2N2Nm9MWnlPenlVNEhHS21pbVZT?=
 =?utf-8?B?Z1RQRVVKbE9lYlZpb3JUaWc4dFdheWYyZ1VuaUlsYkhpb0RxelZycTdUbzdH?=
 =?utf-8?B?a1B6Qm50OHFxdWNrVVJwaXpKcHdSRVpodkJWRkZwNTZodG5EejRCK0FORUdK?=
 =?utf-8?B?TGV1WWFYQmM1Q09HYmdLdmdWNzBDVVBaam5aRmRlZ0llQkt4OWxyeVJ4OXVX?=
 =?utf-8?B?QXNtQUZEdzVXTGR1RTJxRlJhNG1YUlF5ZlVpaDdqRjc0aWFmY1JmWENWSDRQ?=
 =?utf-8?B?b28vRUlHZXhvMWZhQ3RMTWY1MDZ1dmVhMEZaRkVEVGQwbzdHN3NUbEt1NEd0?=
 =?utf-8?B?MHF2MmxCaWdjbXFodUgwUWwvV3lvdmlJVHgvSWRVeERiWEdTYkd3ZW1uVWhx?=
 =?utf-8?B?MldqcHAvSU8vdW9lVVA1UlBxbk5MRGN0RkFKNElGTGFJYzhKcDVSZThqSjMz?=
 =?utf-8?B?bzVIZThTMTNnYXVmWENMY1FXYjNUME9ObTFXUDZsbk05YlFlQTEwM1hZajRC?=
 =?utf-8?B?WTBERVY2RDhYNWxFdm5FQmdFRTMxR2hhT2YwdVNTRkVVdVlMNk9uenNkU0ZX?=
 =?utf-8?B?SkEyWWxLcThwSmVaMkI5Zy9IWEx1dnFzWTRCL2VyVkFlWkV1RjlDcnVEVjFE?=
 =?utf-8?B?V3ZPczRORDllYjFjNmVNSXVBUS83QzArS3ZFYkxqOXlEOUJ3OERxR1F3SWN2?=
 =?utf-8?B?eWJDcXVSR2I2UjVUZ1NJTW5uY2xnc3dzWW5uRy9nUDBRWDZSMERkZ0oxK2Zi?=
 =?utf-8?B?Mm9hVEtwR1hsbnNBVEY4K29EL0J5ZExIbHlNeDNIRFVuZXJBYWIraXkzMjhp?=
 =?utf-8?B?TktqZDNTTDJBbmlkRDdNOEpxT3JKbTdIWmN6enh3MkVPQXl5cjF3ZEtERGlM?=
 =?utf-8?B?ZUdLSnF4aHdPY0pxUDdWckNzOTBDaEdyNkJzZzEzOUtwMHNxREl3M0xXUjJB?=
 =?utf-8?B?VkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR07MB8412.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ebc32d-2bd2-41a8-70cd-08dc3879987c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 16:23:27.9676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: no1qzlT8JxPBumOAIplbKoumK3uQOgnHFbden30PDzO5bBNQsQzIrgVULVehB0HAQVOi/wP6yDLlYapOB4YF6KM3KSb7zICyl4msvEYoAyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9784
Received-SPF: pass client-ip=2a01:111:f403:260e::600;
 envelope-from=sriram.yagnaraman@ericsson.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
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
YWtpDQo+IDxha2loaWtvLm9kYWtpQGRheW5peC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2OCAw
My8xNV0gcGNpZV9zcmlvdjogUmVzZXQgU1ItSU9WIGV4dGVuZGVkIGNhcGFiaWxpdHkNCj4gDQo+
IHBjaWVfc3Jpb3ZfcGZfZGlzYWJsZV92ZnMoKSBpcyBjYWxsZWQgd2hlbiByZXNldHRpbmcgdGhl
IFBGLCBidXQgaXQgb25seSBkaXNhYmxlcw0KPiBWRnMgYW5kIGRvZXMgbm90IHJlc2V0IFNSLUlP
ViBleHRlbmRlZCBjYXBhYmlsaXR5LCBsZWFraW5nIHRoZSBzdGF0ZSBhbmQNCj4gbWFraW5nIHRo
ZSBWRiBFbmFibGUgcmVnaXN0ZXIgaW5jb25zaXN0ZW50IHdpdGggdGhlIGFjdHVhbCBzdGF0ZS4N
Cj4gDQo+IFJlcGxhY2UgcGNpZV9zcmlvdl9wZl9kaXNhYmxlX3ZmcygpIHdpdGggcGNpZV9zcmlv
dl9wZl9yZXNldCgpLCB3aGljaCBkb2VzDQo+IG5vdCBvbmx5IGRpc2FibGUgVkZzIGJ1dCBhbHNv
IHJlc2V0cyB0aGUgY2FwYWJpbGl0eS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFraWhpa28gT2Rh
a2kgPGFraWhpa28ub2Rha2lAZGF5bml4LmNvbT4NCj4gLS0tDQo+ICBpbmNsdWRlL2h3L3BjaS9w
Y2llX3NyaW92LmggfCAgNCArKy0tDQo+ICBody9uZXQvaWdiLmMgICAgICAgICAgICAgICAgfCAg
MiArLQ0KPiAgaHcvbnZtZS9jdHJsLmMgICAgICAgICAgICAgIHwgIDIgKy0NCj4gIGh3L3BjaS9w
Y2llX3NyaW92LmMgICAgICAgICB8IDI2ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+ICA0
IGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvcGNpL3BjaWVfc3Jpb3YuaCBiL2luY2x1ZGUvaHcvcGNp
L3BjaWVfc3Jpb3YuaCBpbmRleA0KPiAwOTVmYjBjOWVkZjkuLmI3N2ViN2JmNThhYyAxMDA2NDQN
Cj4gLS0tIGEvaW5jbHVkZS9ody9wY2kvcGNpZV9zcmlvdi5oDQo+ICsrKyBiL2luY2x1ZGUvaHcv
cGNpL3BjaWVfc3Jpb3YuaA0KPiBAQCAtNTgsOCArNTgsOCBAQCB2b2lkIHBjaWVfc3Jpb3ZfcGZf
YWRkX3N1cF9wZ3NpemUoUENJRGV2aWNlICpkZXYsDQo+IHVpbnQxNl90IG9wdF9zdXBfcGdzaXpl
KTsgIHZvaWQgcGNpZV9zcmlvdl9jb25maWdfd3JpdGUoUENJRGV2aWNlICpkZXYsDQo+IHVpbnQz
Ml90IGFkZHJlc3MsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHZh
bCwgaW50IGxlbik7DQo+IA0KPiAtLyogUmVzZXQgU1IvSU9WIFZGIEVuYWJsZSBiaXQgdG8gdW5y
ZWdpc3RlciBhbGwgVkZzICovIC12b2lkDQo+IHBjaWVfc3Jpb3ZfcGZfZGlzYWJsZV92ZnMoUENJ
RGV2aWNlICpkZXYpOw0KPiArLyogUmVzZXQgU1IvSU9WICovDQo+ICt2b2lkIHBjaWVfc3Jpb3Zf
cGZfcmVzZXQoUENJRGV2aWNlICpkZXYpOw0KPiANCj4gIC8qIEdldCBsb2dpY2FsIFZGIG51bWJl
ciBvZiBhIFZGIC0gb25seSB2YWxpZCBmb3IgVkZzICovICB1aW50MTZfdA0KPiBwY2llX3NyaW92
X3ZmX251bWJlcihQQ0lEZXZpY2UgKmRldik7IGRpZmYgLS1naXQgYS9ody9uZXQvaWdiLmMNCj4g
Yi9ody9uZXQvaWdiLmMgaW5kZXggMGI1YzMxYTU4YmJhLi45MzQ1NTA2ZjgxZWMgMTAwNjQ0DQo+
IC0tLSBhL2h3L25ldC9pZ2IuYw0KPiArKysgYi9ody9uZXQvaWdiLmMNCj4gQEAgLTQ5Myw3ICs0
OTMsNyBAQCBzdGF0aWMgdm9pZCBpZ2JfcWRldl9yZXNldF9ob2xkKE9iamVjdCAqb2JqKQ0KPiAN
Cj4gICAgICB0cmFjZV9lMTAwMGVfY2JfcWRldl9yZXNldF9ob2xkKCk7DQo+IA0KPiAtICAgIHBj
aWVfc3Jpb3ZfcGZfZGlzYWJsZV92ZnMoZCk7DQo+ICsgICAgcGNpZV9zcmlvdl9wZl9yZXNldChk
KTsNCj4gICAgICBpZ2JfY29yZV9yZXNldCgmcy0+Y29yZSk7DQo+ICB9DQo+IA0KPiBkaWZmIC0t
Z2l0IGEvaHcvbnZtZS9jdHJsLmMgYi9ody9udm1lL2N0cmwuYyBpbmRleA0KPiA3YTU2ZTdiNzli
NGQuLjdjMGQzZjEwODcyNCAxMDA2NDQNCj4gLS0tIGEvaHcvbnZtZS9jdHJsLmMNCj4gKysrIGIv
aHcvbnZtZS9jdHJsLmMNCj4gQEAgLTcxMTYsNyArNzExNiw3IEBAIHN0YXRpYyB2b2lkIG52bWVf
Y3RybF9yZXNldChOdm1lQ3RybCAqbiwNCj4gTnZtZVJlc2V0VHlwZSByc3QpDQo+ICAgICAgICAg
ICAgICB9DQo+IA0KPiAgICAgICAgICAgICAgaWYgKHJzdCAhPSBOVk1FX1JFU0VUX0NPTlRST0xM
RVIpIHsNCj4gLSAgICAgICAgICAgICAgICBwY2llX3NyaW92X3BmX2Rpc2FibGVfdmZzKHBjaV9k
ZXYpOw0KPiArICAgICAgICAgICAgICAgIHBjaWVfc3Jpb3ZfcGZfcmVzZXQocGNpX2Rldik7DQo+
ICAgICAgICAgICAgICB9DQo+ICAgICAgICAgIH0NCj4gDQo+IGRpZmYgLS1naXQgYS9ody9wY2kv
cGNpZV9zcmlvdi5jIGIvaHcvcGNpL3BjaWVfc3Jpb3YuYyBpbmRleA0KPiBkYTIwOWI3ZjQ3ZmQu
LjUxYjY2ZDFiYjM0MiAxMDA2NDQNCj4gLS0tIGEvaHcvcGNpL3BjaWVfc3Jpb3YuYw0KPiArKysg
Yi9ody9wY2kvcGNpZV9zcmlvdi5jDQo+IEBAIC0yNDksMTYgKzI0OSwyNiBAQCB2b2lkIHBjaWVf
c3Jpb3ZfY29uZmlnX3dyaXRlKFBDSURldmljZSAqZGV2LA0KPiB1aW50MzJfdCBhZGRyZXNzLCAg
fQ0KPiANCj4gDQo+IC0vKiBSZXNldCBTUi9JT1YgVkYgRW5hYmxlIGJpdCB0byB0cmlnZ2VyIGFu
IHVucmVnaXN0ZXIgb2YgYWxsIFZGcyAqLyAtdm9pZA0KPiBwY2llX3NyaW92X3BmX2Rpc2FibGVf
dmZzKFBDSURldmljZSAqZGV2KQ0KPiArLyogUmVzZXQgU1IvSU9WICovDQo+ICt2b2lkIHBjaWVf
c3Jpb3ZfcGZfcmVzZXQoUENJRGV2aWNlICpkZXYpDQo+ICB7DQo+ICAgICAgdWludDE2X3Qgc3Jp
b3ZfY2FwID0gZGV2LT5leHAuc3Jpb3ZfY2FwOw0KPiAtICAgIGlmIChzcmlvdl9jYXApIHsNCj4g
LSAgICAgICAgdWludDMyX3QgdmFsID0gcGNpX2dldF9ieXRlKGRldi0+Y29uZmlnICsgc3Jpb3Zf
Y2FwICsgUENJX1NSSU9WX0NUUkwpOw0KPiAtICAgICAgICBpZiAodmFsICYgUENJX1NSSU9WX0NU
UkxfVkZFKSB7DQo+IC0gICAgICAgICAgICB2YWwgJj0gflBDSV9TUklPVl9DVFJMX1ZGRTsNCj4g
LSAgICAgICAgICAgIHBjaWVfc3Jpb3ZfY29uZmlnX3dyaXRlKGRldiwgc3Jpb3ZfY2FwICsgUENJ
X1NSSU9WX0NUUkwsIHZhbCwgMSk7DQo+IC0gICAgICAgIH0NCj4gKyAgICBpZiAoIXNyaW92X2Nh
cCkgew0KPiArICAgICAgICByZXR1cm47DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgcGNpX3NldF93
b3JkKGRldi0+Y29uZmlnICsgc3Jpb3ZfY2FwICsgUENJX1NSSU9WX0NUUkwsIDApOw0KPiArICAg
IHVucmVnaXN0ZXJfdmZzKGRldik7DQo+ICsNCj4gKyAgICAvKg0KPiArICAgICAqIERlZmF1bHQg
aXMgdG8gdXNlIDRLIHBhZ2VzLCBzb2Z0d2FyZSBjYW4gbW9kaWZ5IGl0DQo+ICsgICAgICogdG8g
YW55IG9mIHRoZSBzdXBwb3J0ZWQgYml0cw0KPiArICAgICAqLw0KPiArICAgIHBjaV9zZXRfd29y
ZChkZXYtPmNvbmZpZyArIHNyaW92X2NhcCArIFBDSV9TUklPVl9TWVNfUEdTSVpFLCAweDEpOw0K
PiArDQoNCkp1c3QgY3VyaW91cywgZG8gd2UgbmVlZCB0aGlzPw0KT24gTGludXgsIEkgdGhvdWdo
dCB0aGUgUENJIHN1YnN5c3RlbSByZXN0b3JlcyB0aGUgcGFnZSBzaXplIGFmdGVyIHJlc2V0Lg0K
DQpPdGhlcndpc2UsIA0KQXNzdW1pbmcgY2hhbmdlIG9mIG15IG1haWwgYWRkcmVzcyBmcm9tIHNy
aXJhbS55YWduYXJhbWFuQGVzdC50ZWNoIHRvIEBlcmljc3Nvbi5jb20gaXMgYWNjZXB0ZWQsDQpS
ZXZpZXdlZC1ieTogU3JpcmFtIFlhZ25hcmFtYW4gPHNyaXJhbS55YWduYXJhbWFuQGVyaWNzc29u
LmNvbT4NCg0KPiArICAgIGZvciAodWludDE2X3QgaSA9IDA7IGkgPCBQQ0lfTlVNX1JFR0lPTlM7
IGkrKykgew0KPiArICAgICAgICBwY2lfc2V0X3F1YWQoZGV2LT5jb25maWcgKyBzcmlvdl9jYXAg
KyBQQ0lfU1JJT1ZfQkFSICsgaSAqIDQsDQo+ICsgICAgICAgICAgICAgICAgICAgICBkZXYtPmV4
cC5zcmlvdl9wZi52Zl9iYXJfdHlwZVtpXSk7DQo+ICAgICAgfQ0KPiAgfQ0KPiANCj4gDQo+IC0t
DQo+IDIuNDMuMg0K

