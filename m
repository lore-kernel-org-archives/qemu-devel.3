Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C8FC54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 01:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rePbp-0000aN-JD; Sun, 25 Feb 2024 20:16:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1rePbl-0000ZR-7B; Sun, 25 Feb 2024 20:16:41 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1rePbf-0000fs-Lh; Sun, 25 Feb 2024 20:16:39 -0500
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 41Q1G4gB002411;
 Mon, 26 Feb 2024 09:16:04 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 26 Feb
 2024 09:16:06 +0800
Received: from ATCPCS31.andestech.com (10.0.1.89) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7 via Frontend
 Transport; Mon, 26 Feb 2024 09:16:06 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (104.47.110.41)
 by mail.andestech.com (10.0.1.89) with Microsoft SMTP Server (TLS) id
 14.3.498.0; Mon, 26 Feb 2024 09:16:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUBlwHK94X7YM/7kIjtevO8hPhVh/yi320QHEpelYmxhlhtk428/b2T2avOtH78hFgCLrGzyPJK0ESoVpumkPt3LwniQfdc3779voebTOUbwXIbMr1SNq3YkDyapNpcUtwTTbtANy3gCGloNcFKFJSJHlONFOgNeEyZ6HS48ePJjVa4Opl66umb26I/RCLy75BMuojCoCjnM2kSM6OgajBjMoPbGHk9e6eINNDbPSV1N0l9Zo0I+V5LzMlaUEYLbmtcWhUlsicMfMhTq9T9FlpTLUe5753LBSO4XR46GnrRGVCkYeJ6vY+AYVxyprWJ1fjorEeWMLlis50pArkiLbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fE6uO5v7JHkNPWARK+gpnBUrgI8pKnEai+1wok+/CU=;
 b=TOdZYX5LB4HAoFFBrbaVM8bg40G4A+V5NCQhGBOtA5dV1gjZbEIjv5w3pFUUkwgypCcWzLJtwHBKIUv2FvReOMBaUFmEZuduObdcILTynI0TP8TBOsMbIUvM17Q1/y508oOyq+k8gOWUs2LGMdQkO0mqDGSt2Hj7YPkGP3IXQz77wNRfK5iSi70RYIhLTUNcoOMbN0JsRN+1Wkni1SJsMQlNN736G9Qbrk4Mcv0/0GhJw/21e460Ts+Z+jxaWX3+mOBhQkb4Qr3vVXhoWLek/TPSVtwoYE4Ey5lS2TDELbEIyzS55EqdE2z63Wt8SKkXX3Rk70aAw/mzFRKKVYLtog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andestech.com; dmarc=pass action=none
 header.from=andestech.com; dkim=pass header.d=andestech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andestech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fE6uO5v7JHkNPWARK+gpnBUrgI8pKnEai+1wok+/CU=;
 b=UUd6Ce60bT98SwAEzjve/vf3DN6IvGdMqSWSC/UABkEeP4ljbpENteLB5HdfTdEv46D3NjP4Kq3mYs+NcHj6MEuzjeiEAYkHNq0XD2pOfDb8CcoNqwILOzwigiE09ZlN3EklF/lTqQOHxQz5ohQH0UZF90WSrslX1F+2duy7MTsTMqB8adaMnbFRdjkWxrYtlXAdTp7rFbaazX/53sdwMLu+B8Z3Meg9UExpToQdoPlBjb3iSgnC7tSjd8oCE4jxY5sNqNxEU0GjZgdguDQYt2rraE/QDnHTCH95LD55g/Tp+a/7bIjhCvteg21oZQcmV0VBd6BYB0X8i+FVHJjXmw==
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com (2603:1096:101:69::14)
 by SEYPR03MB8432.apcprd03.prod.outlook.com (2603:1096:101:20a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 01:16:00 +0000
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::9523:69b6:faf2:3b83]) by SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::9523:69b6:faf2:3b83%4]) with mapi id 15.20.7316.023; Mon, 26 Feb 2024
 01:16:00 +0000
From: =?utf-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>
To: Alistair Francis <alistair23@gmail.com>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alistair.francis@wdc.com"
 <alistair.francis@wdc.com>, "bin.meng@windriver.com"
 <bin.meng@windriver.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: RE: [PATCH v2 0/4] RISC-V: Modularize common match conditions for
 trigger
Thread-Topic: [PATCH v2 0/4] RISC-V: Modularize common match conditions for
 trigger
Thread-Index: AQHaZf8ElbG3tGFZyEOf0hz6xTVIErEbyIoAgAAJWUA=
Date: Mon, 26 Feb 2024 01:16:00 +0000
Message-ID: <SEYPR03MB6700C2BF43C958F591025714A85A2@SEYPR03MB6700.apcprd03.prod.outlook.com>
References: <20240223022119.41255-1-alvinga@andestech.com>
 <CAKmqyKMkXf8mJvwh2vDEGh2fq-5AP2yz2Y9k-UH1D6MuW6CgTA@mail.gmail.com>
In-Reply-To: <CAKmqyKMkXf8mJvwh2vDEGh2fq-5AP2yz2Y9k-UH1D6MuW6CgTA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andestech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6700:EE_|SEYPR03MB8432:EE_
x-ms-office365-filtering-correlation-id: f64299bd-8fcc-44dd-1a96-08dc36687e58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k4UsyMzo/zfzW+X/PaZ/Os0zQYaPD+K43xHkJ3UM1+Npzk2EIDG7gL6+FkBM9WfbrTGUblSX7XLKq4k7XNED+FAv+j5CW+m1ip9/8GH6KrBw22BgLo6cT4/BbSVK9v7GYIYfFI0KL/sciLqjIbMI7wmlNahmPKRHotbsz+k2fR1caNWvteyNhZfhQjw0bsszN9e/1aplYQ47C5UbxFhQIzGC/yGJb0y6JsuE3S/KY5uxVECyv32+EKvF2LShkcXfOM5oEbdWuIRvl2pypvRwXS+HYwo/hVrEGNvqxbQ1iszo1/DipP31fMnGVDh4rDOat+qK0OMgLnS45GOZQAsMWive6yGvAha/TcFl61Mp0YRJA7nZ0wSqtjX2BANPH+PgKoyu4dQNaoj63AT4NmJHCPaN/mswiP4gp8eymY7aMeksMc1E4q/WNKVfYceGA5tPEPcECJkiu30TT5knIplvOMwhN6/ALQ4nAI8wtypb4UHfDehk8qYSMKJVXUBrzqV0CcIns70kdrcHhkoXQRxZ95t3fMs+15P1hUlJJYvTINQbOJxVRmOsx5QzbczX+IyhnE8M2mMpQbNRyjW8gLCHYUiqgCCil+Z8eSOvzhVnlVVlAkGfKIN0asq9sryVnkNjp+AMnz+aG42XrgLQ7z7zbixKeq7wFrBkfAjLKOSvtKUiUO7wzRHEkmJ6gGMrtpmlecuDNrFxuZx0q2dm0b/zXQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR03MB6700.apcprd03.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(230473577357003)(230273577357003)(38070700009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0MrbUFaWU9PVUVycGthYVEwWUhRVGtwT0hZM1RpaThjdWZEcEpvbzAwQnNw?=
 =?utf-8?B?L3hRdEJyd0VmR3ZMSTRueS9hK3hpUVhJblVmRFV2S2gvZWorU1JNQlNsY0NE?=
 =?utf-8?B?Nkgydm01TytabFpvWDZndmJkOWc3RTdBNjRiZHMwK25jUHEweitnVFdDYzI0?=
 =?utf-8?B?NVFVdW1rUkJUT3lzUmcxVENrQzRXeWFmVWxXdUZLYnFiRTBXekVRN1hKdDZr?=
 =?utf-8?B?cTJsNjEvK0ljV0tiaFVDK1RCSkZHTGoxSElYWnNEN2xKbWdHM215WmY3N1Bs?=
 =?utf-8?B?Sy9aVXZmUEZBS1l6dXJ6dkNsZkN6ajY4a0lyczBQcmNIaWdUVG1yRk0zTXlQ?=
 =?utf-8?B?TEliNUk0eTlpNnZRb2E1d3N4WWgvR29oUXVhMThuQXBRQkcvTTRXMnIveTJh?=
 =?utf-8?B?d2gvNmk5d1hPaDRodkovUGx3bTdDK2MrN3RZaHZ2ZldlMTFyeDI0eHpwcmdy?=
 =?utf-8?B?eitmdHZ3YXZTdHgxQ1dEenJmalpveGdlbGUvYjFZU21UNjdZNnRsT1RJdy9y?=
 =?utf-8?B?ZFhoTXZNajBhZjRWVjc2dnV4ZmxiQ0xOTDZTdjJoV1greGJoR1VOaWlBZ1RG?=
 =?utf-8?B?QTM4SUVEUEJHcloxTUo3WUpUMmtLUGdVTVdla0dZV3dpeUx0N05RbHdURE5w?=
 =?utf-8?B?dVM1cGhXSnNSelVXUjBZODgwNGV0RTZhQVdkWjU1Z3BEdW1oazVLaWJScWtw?=
 =?utf-8?B?REsrK05yM05WZTNLRUVuUFRuT3MvZDFKUG1GdlhCdXAvMjd2Y2ZDVm9Wa1h0?=
 =?utf-8?B?T1B5Z3JmbjNqSGw0Y1dXcE1qdGVWbW1MbWFHaFoyM2g1NXhXMFdXbVd1NlhN?=
 =?utf-8?B?Y2RoUEN3VUxwbHZEaGM5SWJQV2Q0TlFPaFRka2dWZkt0cWdOUXJaays0T01G?=
 =?utf-8?B?VGdCU3RrR21yK0NSU3BmbzlQZjZvWGpwZGlNZWIzczRFRkpDczVoQWI2eWVC?=
 =?utf-8?B?Nm94WDdNNkRHbDdBS0owSWhzRVo1ejUrTjJ5NW54ZGtpL1h1cUFRNXcvT0lv?=
 =?utf-8?B?UHVxZ0xoZXB4cmRWazBzaldxQ0VyTHM4TFkzUEx2cHNFdGJlOGRkVWN2VGll?=
 =?utf-8?B?dGVqMmM2c09nMGY1UUdPYW1hNWpsdzBEcFpuVjJCK1VOOUJVSlBBKzhsWUdH?=
 =?utf-8?B?SW12c0w3dnRUUXNGUmw5UUVKR1ZhNG5hYnZpbFZoMzNFMXlNeXVBZENteHNR?=
 =?utf-8?B?ZG54eXpZQ1R2cCtsRWJvVzFtZnJPYmFib3pGNUNXRCtFUmhUMFRpRFBubERN?=
 =?utf-8?B?N2V2VVh2NlgwZU1mL1dCdTdYRFJtMG0yVVVEdm1IRU1OREsvVU5wS0pUMTBJ?=
 =?utf-8?B?enY3K1RFU0xZdXpCSmJWTUtQN2ZCaW5zNkp5VEhlL01tQnRKT25UMkloWlps?=
 =?utf-8?B?aGYyb3BEcW9YQWlvaTRLMWpLOWxJREttRkg0RkdCbVJ6Ryt6WGxTclFMNzUy?=
 =?utf-8?B?ZzdZUEZOU1F6Ym02VWFqc1FhenpKd3NIYUVWRVdZa0U1dDVHaWtoNkZTMTVr?=
 =?utf-8?B?QmNYdzM0bnhlSDNEUW1RZmxaazArc1lCWUdaQlNiSjQvLzhBZUY3aFNBem1Q?=
 =?utf-8?B?WDhPSTNMRXRKL1NGdzZ5aFRiNHgvNStEenNaMDFRVjBjZXVlTWxNSi9MNFly?=
 =?utf-8?B?UE9GSlZES2NUVzVBejROMFNUNDM5cmpPWWNHN3RSa3dMN3hENC9rR0hlNlYz?=
 =?utf-8?B?Ylg2cjlrSGl1M1hsdnJldlQyVWtGT0JlZVNXSzRGRHJXYmJpRi9VTUhhSzB5?=
 =?utf-8?B?UzQ3eFduVzkyaDZMRnRSam83WHpJc1Fic0svVVF5c2ZaVHNJRDB4Q2xCSk96?=
 =?utf-8?B?UzlNVUNYNHhYYjYyWFJqaU9ldkd1QzZHN25XdGFEY3NhSXhFQmpzR05hSmhi?=
 =?utf-8?B?WkI1ckVmbDhRWnJiVHowWHhuVmZaV2cwcmQ0RlpKazQrTGxKVm41Qk5CQUhq?=
 =?utf-8?B?TnVpMzBhdVJGMFVrUklvZnpVayszWldzRDB0dFlQRlNyZXFGSGRrZFpPR2o2?=
 =?utf-8?B?emswcmllUTI0cHg4RmxJblIrVEx0YXg5U3MrVlJab3hRYWJBeDNYN1JlS1gz?=
 =?utf-8?B?aGkvWndNa2hFRExxS1ZOKytsbVEyQzFTaWNVV2JXVXdVeVJhczFDOWFuZHRm?=
 =?utf-8?Q?KDokbP5KQmnT0itXHu1ZHNwgN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6700.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64299bd-8fcc-44dd-1a96-08dc36687e58
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 01:16:00.3550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3ec21b7-ec6c-4041-9add-61aea8171458
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eEeJlFHR2CNTWnSffNzHwgPw2zCUKCkHdoLWmOrP/xt8obbhxe+c4vXwSCsc1PASB687p6id3BdwrFdrcnADzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8432
X-OriginatorOrg: andestech.com
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 41Q1G4gB002411
Received-SPF: pass client-ip=60.248.80.70; envelope-from=alvinga@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
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

SGkgQWxpc3RhaXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxp
c3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIyM0BnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgRmVi
cnVhcnkgMjYsIDIwMjQgODoyNSBBTQ0KPiBUbzogQWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy
5ZiJKSA8YWx2aW5nYUBhbmRlc3RlY2guY29tPg0KPiBDYzogcWVtdS1yaXNjdkBub25nbnUub3Jn
OyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbTsgYmlu
Lm1lbmdAd2luZHJpdmVyLmNvbTsgbGl3ZWkxNTE4QGdtYWlsLmNvbTsNCj4gZGJhcmJvemFAdmVu
dGFuYW1pY3JvLmNvbTsgemhpd2VpX2xpdUBsaW51eC5hbGliYWJhLmNvbQ0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYyIDAvNF0gUklTQy1WOiBNb2R1bGFyaXplIGNvbW1vbiBtYXRjaCBjb25kaXRp
b25zIGZvcg0KPiB0cmlnZ2VyDQo+DQo+IFtFWFRFUk5BTCBNQUlMIOWklumDqOS/oeS7tl0NCj4N
Cj4gT24gRnJpLCBGZWIgMjMsIDIwMjQgYXQgMTI6MjLigK9QTSBBbHZpbiBDaGFuZyB2aWEgPHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gd3JvdGU6DQo+ID4NCj4gPiBBY2NvcmRpbmcgdG8gUklT
Qy1WIERlYnVnIHNwZWNpZmljYXRpb24sIHRoZSBlbmFibGVkIHByaXZpbGVnZSBsZXZlbHMNCj4g
PiBvZg0KPg0KPiBDYW4geW91IHNwZWNpZnkgd2hhdCB2ZXJzaW9uIG9mIHRoZSBkZWJ1ZyBzcGVj
Pw0KDQpJbiBnZW5lcmFsLCB0aGlzIHNlcmllcyBkb2VzIG5vdCBhZGQgYW55IG5ldyBmdW5jdGlv
bmFsaXRpZXMuDQpUaGUgb3JpZ2luYWwgaW1wbGVtZW50YXRpb24gaGFzIGR1cGxpY2F0ZWQgY29k
ZSBpbiB0eXBlIDIvMy82IHRyaWdnZXJzLg0KSSBqdXN0IGVsaW1pbmF0ZWQgdGhvc2UgY29kZSBh
bmQgbW9kdWxhcml6ZWQgdGhlbSB0byBiZSB0cmlnZ2VyX2NvbW1vbl9tYXRjaCgpLg0KQmVzaWRl
cywgd2UgbWF5IHdhbnQgdG8gY2hlY2sgb3RoZXIgY29uZGl0aW9ucyBpbiB0aGUgZnV0dXJlLCBz
byB0aGlzIGZ1bmN0aW9uIGNhbiBiZSB1c2VkIGZvciB0aG9zZSBwdXJwb3Nlcy4NCg0KV2hlbiBJ
IHRyYWNrIHRoZSBjb21taXQgaGlzdG9yeSwgaXQgc2VlbXMgdGhlIGNvZGUgaXMgc3VibWl0dGVk
IGluIHRoZSBmb2xsb3dpbmcgY29tbWl0cyB0d28geWVhcnMgYWdvOg0KaHR0cHM6Ly9naXRodWIu
Y29tL3FlbXUvcWVtdS9jb21taXQvOTU3OTllMzZjMTVhOWFiNjAyYTM4ODQ5MWM0MGY2ODYwZjZh
ZThiZg0KaHR0cHM6Ly9naXRodWIuY29tL3FlbXUvcWVtdS9jb21taXQvYjVmNjM3OWQxMzRiZDIw
MWQ1MjM4MGM3M2ZmNzM1NjVlNmE0MzIxZQ0KaHR0cHM6Ly9naXRodWIuY29tL3FlbXUvcWVtdS9j
b21taXQvYzMyNDYxZDhlZWIxNzQ5MGIxYjFlOTY5ZTJjZThmMWVjZDgzYmZiYg0KaHR0cHM6Ly9n
aXRodWIuY29tL3FlbXUvcWVtdS9jb21taXQvYzQ3MmMxNDJhNzU1MmY1YjBlNDAzNzhkNTY0M2Ey
ODEwZWYxYjExMQ0KDQpTaW5jZSB0aGV5IG1lbnRpb25lZCB0aGUgInR5cGUgNiIgdHJpZ2dlciBh
bmQgIlNkdHJpZyIgZXh0ZW5zaW9uLCBJIGFzc3VtZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIGlz
IGJhc2VkIG9uIERlYnVnIFNwZWMgdmVyc2lvbiAxLjANClRoZXJlIGlzIG5vIHR5cGUgNiB0cmln
Z2VyIGFuZCBTZHRyaWcgZXh0ZW5zaW9uIGluIERlYnVnIFNwZWMgdmVyc2lvbiAwLjEzDQoNClNp
bmNlcmVseSwNCkFsdmluIENoYW5nDQoNCj4NCj4gSWRlYWxseSBpZiB5b3UgY2FuIGxpbmsgZGly
ZWN0bHkgdG8gdGhlIFBERiB0aGF0IHdvdWxkIGJlIHZlcnkgdXNlZnVsLg0KPiBUaGVyZSBhcmUg
bXVsdGlwbGUgdmVyc2lvbnMgc28gaXQncyBoYXJkIHRvIGtlZXAgdHJhY2sgb2YuDQo+DQo+IEFs
aXN0YWlyDQo+DQo+ID4gdGhlIHRyaWdnZXIgaXMgY29tbW9uIG1hdGNoIGNvbmRpdGlvbnMgZm9y
IGFsbCB0aGUgdHlwZXMgb2YgdGhlIHRyaWdnZXIuDQo+ID4gVGhpcyBzZXJpZXMgbW9kdWxhcml6
ZSB0aGUgY29kZSBmb3IgY2hlY2tpbmcgdGhlIHByaXZpbGVnZSBsZXZlbHMgb2YNCj4gPiB0eXBl
IDIvMy82IHRyaWdnZXJzIGJ5IGltcGxlbWVudGluZyBmdW5jdGlvbnMgdHJpZ2dlcl9jb21tb25f
bWF0Y2goKQ0KPiA+IGFuZCB0cmlnZ2VyX3ByaXZfbWF0Y2goKS4NCj4gPg0KPiA+IEFkZGl0aW9u
YWwgbWF0Y2ggY29uZGl0aW9ucywgc3VjaCBhcyBDU1IgdGNvbnRyb2wgYW5kIHRleHRyYSwgY2Fu
IGJlDQo+ID4gZnVydGhlciBpbXBsZW1lbnRlZCBpbnRvIHRyaWdnZXJfY29tbW9uX21hdGNoKCkg
aW4gdGhlIGZ1dHVyZS4NCj4gPg0KPiA+IENoYW5nZXMgZnJvbSB2MToNCj4gPiAtIEZpeCB0eXBv
DQo+ID4gLSBBZGQgY29tbWl0IGRlc2NyaXB0aW9uIGZvciBjaGFuZ2luZyBiZWhhdmlvciBvZiBs
b29waW5nIHRoZSB0cmlnZ2Vycw0KPiA+ICAgd2hlbiB3ZSBjaGVjayB0eXBlIDIgdHJpZ2dlcnMu
DQo+ID4NCj4gPiBBbHZpbiBDaGFuZyAoNCk6DQo+ID4gICB0YXJnZXQvcmlzY3Y6IEFkZCBmdW5j
dGlvbnMgZm9yIGNvbW1vbiBtYXRjaGluZyBjb25kaXRpb25zIG9mIHRyaWdnZXINCj4gPiAgIHRh
cmdldC9yaXNjdjogQXBwbHkgbW9kdWxhcml6ZWQgbWF0Y2hpbmcgY29uZGl0aW9ucyBmb3IgYnJl
YWtwb2ludA0KPiA+ICAgdGFyZ2V0L3Jpc2N2OiBBcHBseSBtb2R1bGFyaXplZCBtYXRjaGluZyBj
b25kaXRpb25zIGZvciB3YXRjaHBvaW50DQo+ID4gICB0YXJnZXQvcmlzY3Y6IEFwcGx5IG1vZHVs
YXJpemVkIG1hdGNoaW5nIGNvbmRpdGlvbnMgZm9yIGljb3VudA0KPiA+IHRyaWdnZXINCj4gPg0K
PiA+ICB0YXJnZXQvcmlzY3YvZGVidWcuYyB8IDEyNA0KPiA+ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDgzIGluc2VydGlv
bnMoKyksIDQxIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0KPiA+
DQpDT05GSURFTlRJQUxJVFkgTk9USUNFOg0KDQpUaGlzIGUtbWFpbCAoYW5kIGl0cyBhdHRhY2ht
ZW50cykgbWF5IGNvbnRhaW4gY29uZmlkZW50aWFsIGFuZCBsZWdhbGx5IHByaXZpbGVnZWQgaW5m
b3JtYXRpb24gb3IgaW5mb3JtYXRpb24gcHJvdGVjdGVkIGZyb20gZGlzY2xvc3VyZS4gSWYgeW91
IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgeW91IGFyZSBoZXJlYnkgbm90aWZpZWQg
dGhhdCBhbnkgZGlzY2xvc3VyZSwgY29weWluZywgZGlzdHJpYnV0aW9uLCBvciB1c2Ugb2YgdGhl
IGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gSW4g
dGhpcyBjYXNlLCBwbGVhc2UgaW1tZWRpYXRlbHkgbm90aWZ5IHRoZSBzZW5kZXIgYnkgcmV0dXJu
IGUtbWFpbCwgZGVsZXRlIHRoZSBtZXNzYWdlIChhbmQgYW55IGFjY29tcGFueWluZyBkb2N1bWVu
dHMpIGFuZCBkZXN0cm95IGFsbCBwcmludGVkIGhhcmQgY29waWVzLiBUaGFuayB5b3UgZm9yIHlv
dXIgY29vcGVyYXRpb24uDQoNCkNvcHlyaWdodCBBTkRFUyBURUNITk9MT0dZIENPUlBPUkFUSU9O
IC0gQWxsIFJpZ2h0cyBSZXNlcnZlZC4NCg==

