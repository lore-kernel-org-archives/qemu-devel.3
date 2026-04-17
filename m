Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BBCF43688
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDfyK-0004Xi-Dh; Fri, 17 Apr 2026 05:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDfyA-0004Bq-2s; Fri, 17 Apr 2026 05:58:39 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDfy7-0003Ve-Uw; Fri, 17 Apr 2026 05:58:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a64GkfynwXyM9WkKG3wQTF4gQiAtmZmnQoL057AJaZXv1rfeH1lCrsgcVKumgQDbGdD6kofP4DfQe+uP44iK8N3vA+048sEHK/e5JVsdJ6f8+3dTleCmUHuL6Wf4nbO8bxSk0AGjFzcERLn4Rtu5GBOWNDIZpCaOf2DVt5XC5GoMx1BtFJk3SoIGwJX4jlFiFA/d8ykia5KaFxoaEWv6aZws4ddi+6JrwbarNNFseNKJp4+d4N3IZhVIolJ07naT0LlZXuE38W2wT2JIr+0ksv/Z2CVJ85p6muzHmvg/h5ilPssBdLlC7PYl7nhrSIMvU+H5DvOJL7ocuVBdhPF15Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vowQtslXiXWtsRVqm2kaGecg4lFLb9VHfsYQBMo3Sw=;
 b=c12149v3mQ3U+K3Vcg2ZjOVAG/+SfZ2oe410bnHAQYUJYbIJHD3jNngIrcypVTkPkoS3GJRihvSF5l5Rq+IBr6U6q0V4Dn82ZHYZq139oitLlNqlGbordJT0K6bYyU4baPzIDMwt5KU9kuOI6hJSwOaTbi/uxuud6Ckj3qAY5FhHwy+wthgr4Sd3ueK7bUQoTD5hzSOrxwVrw30Wrr1uo48P9CzD4f6SugeCFxWYuJS92I2dwg8OL8Kge5U1fR/4ASKgHR6DqRTM6aEjZhGtBexQ+qtA+j106vsWygMjGMYZwS3GMntZUjmyGCGUftm9cgWCUehYnf+lhdNKwJ+1JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vowQtslXiXWtsRVqm2kaGecg4lFLb9VHfsYQBMo3Sw=;
 b=qN9jWH5S9Y7EHfVFaKnR3c8vvdBxol0K/17XdpPpAkv9LeeOkW97hPhay3fN1+RpjYjZ2K0J2pJNzPHcTOGf5HgYNyaBYWZLzVd+bFcDd4qHkOjjgYcz6wRD7woamYGEDrGHitS0WO4nxpOmkw0Zels9bm91sE9DiBticbwm5VBeZ/4D0sAMVyFgj3uLgpKaNiyRQ5+Ucsr749YK5Jra9+Igo8GAedPR1CqmqbZ6HSb3+vgttpiAZeLokmYr+VDvHbnGbYI5AttFpqvVS4RYsAezbM0pUFdkMhrmYTBDo8WibiMfrk/YVOkc6ruyitkvOMpeY6a1pPTsBX3kbR6l6A==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by GVXPR09MB6976.eurprd09.prod.outlook.com (2603:10a6:150:1bc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Fri, 17 Apr
 2026 09:58:31 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 09:58:31 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: Alistair Francis <alistair23@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com"
 <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "thuth@redhat.com" <thuth@redhat.com>
Subject: Re: [PATCH v6 4/7] target/riscv: Implement runtime data endianness
 via MSTATUS bits
Thread-Topic: [PATCH v6 4/7] target/riscv: Implement runtime data endianness
 via MSTATUS bits
Thread-Index: AQHcxdz70J0jqOWNlUqTEQuyJ5XzX7XWIH+AgAz1QwA=
Date: Fri, 17 Apr 2026 09:58:31 +0000
Message-ID: <ac9002de-f4c1-4bea-b41b-1854fc2e48cc@htecgroup.com>
References: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
 <20260406154935.144674-5-djordje.todorovic@htecgroup.com>
 <CAKmqyKOXJZuZ1Xh-x_DYkgoQSrv4+BLvzYbCHvdgE-geOz2W=A@mail.gmail.com>
In-Reply-To: <CAKmqyKOXJZuZ1Xh-x_DYkgoQSrv4+BLvzYbCHvdgE-geOz2W=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|GVXPR09MB6976:EE_
x-ms-office365-filtering-correlation-id: 962ec2b4-15cc-4d00-90ee-08de9c67e179
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: oW23Z5OPFUT1DGjq6RDbAKYnGvDSIQUAsDzHUpFuheBEsPT7fg1cVj47PeXSV8wno+SRJmeBecE2tt5D18lTn0PGy+K5/cGjLBi2tO2NbTP4a3QrbMEkHVMHDs/8OR7rjqJJ7dxeS0Xkct5nzj4SCI5Uzi6DeUjmJgMgOW3SbrsrjdmAUBSbfbYVjfP2dtxMO46ZaR5Iw8l7j3bjkn0EFETQm3E93tTJLCUJOsyRtmVNYUDudOLfvBniGQ3s3PAJi6RTVSuVzd75d22GN1SlZj7aThx9mT5qRGAyDJX2lPqU26M9yKNTqKGNoDajlKL8qhA+Dy8HXqnk9bbzvYhnMEUW0ctdDWmS5th/XqvYLaRsirkYp7Wd/FpWAO3RH77GdWDew39pua5HagRKCUYQqK7GO7g9d8Ojxfk6JzJj7WBSuj39HkkvulaHXCMibtxc2bjmqCTNseOs8vPzppMCu51KzBW/8Ve0SaDND3YvBr05wnXe/qNDR3UcUr0UirSJNuugYDnGmPZIqBJ5NMhK6AJFFfHosEcItilfnJh9ihBAVmJtSUL94UKciIT4h2vAF7NBalDIChg3NNSwCZVHy36OC8iPfHcGjYITv8DsIooTcs7oeYSEtAy/x2yntt0XgnRFi7hmRFACN3Px41upDdo/zHtTn05D/yCzwJiLI5hlhNM45/FD3xjj6e4Kc1PkIHuD93YcYVwQa78Rv5kSXvXUxr6whK0Zjg+fPh0QFiQlbOkdlrUNcAfO23A8zOC1cNmC0fiStiruPApkkUnE8gA/Wi5Q3mee7G+xoeqb3hM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjZUVitTREJTTnhSc0hOOTluaHRNOUEyMXZMSk1lWHhIR3A1cDU4OW9TYjBL?=
 =?utf-8?B?OFFDQk5IVU5yemZJeC9CSWRnaFI2emJ6QUR5Ym9WNmFGMUNyWHZhNW9VdlRE?=
 =?utf-8?B?Q0JEMTRSZjBlcis0VkNHalBJVTgxTnU1UWg4aWVZdUdsZzJMUzJmVEVFMDNP?=
 =?utf-8?B?QWt0eTFGQTlNRUdiRi9wSFV5MG8rK1NYOVljcGI1SHI4bkcrcGJuM21sLzJK?=
 =?utf-8?B?LzZ6QmpvTVR0cWh1S0Y5NVYrajdsTXhPSnBFd0FyUXpRVnB5ZWxrelJoWXVn?=
 =?utf-8?B?Zm1LQUxsZzQyUEdyVUFqcURsdUlTRHYzRVhhYXl0b2tqdHkwVzNtOGhQbHZq?=
 =?utf-8?B?NHM1ejFybC9tVm56TGJNMk1yNUw0UkdyM0NTbzIveXR0SFAxZEtDZmVna3ox?=
 =?utf-8?B?amdWTzRjQ2laTVkrSVF0LzloejB4ZUwrZlNVRFhUMzFLOXplcnRkWnA4ZkFk?=
 =?utf-8?B?Umc2VlZXUENrbHpKRElvUW9PTTh4MytQV1RTbWZob0tLdWhpaUJrZ3phV2hV?=
 =?utf-8?B?OTdPRThjNFhCaTRUZnNmVEV6blhoaC9CTHA0UHdFcGo5Qmd0aFp2dnNvNThF?=
 =?utf-8?B?a2I0cXhEd1dTbEJZbG81R0UrSytTOTduK29Ub2V2ZTlWQjk1anpta1pLcllr?=
 =?utf-8?B?bWFhRHdkcFFLSGZHU3pQektEYTZGdkdaMTlGYml6ZmsxUUozYmp6QWFiWFl1?=
 =?utf-8?B?aDNRaG4vZWl5bDVQZEVrRDYvZkwrVXlNQlROL1EzUVpjT21HZVJZbHF5TWQ1?=
 =?utf-8?B?ZzM1QzVLeFNIMjhLdXJyNmUxOTZZaWJtOGZ3R1FFMjRBYU5Ga1kxRGRldEpZ?=
 =?utf-8?B?QVQ3djh2UmZxRW56T1VLUjl6ZU5ZcjZkZ1JhTGVlck9yTzg5VTJRZ241Q1hi?=
 =?utf-8?B?ejdjUllsdXB1QkwxWSs1ajlrVkEyaHdVMGI3a2NXSmJ5T0E2TnpmRkthWTlw?=
 =?utf-8?B?K0FhRWhhUHJDTE1OSThydWlFd0IzdFYvem85TWJxNFhUSXBqQkJWNURHNG1m?=
 =?utf-8?B?UDlhS2FnS2svN0NQWDYzSnhrRk90MFhJZ0ZuR3RPajV5SmdyR3Fzc2lvekVr?=
 =?utf-8?B?RXRiVzlRMEtsWlJ1RkczTnRuZmROZUl2QmdLenhqekxHRm1scndGU2FBd2tT?=
 =?utf-8?B?NjlMb01MMzdjdUlSdzhzNFZHZVd1TllFcGJBbWdyeFZWMHc3M1lQSm5PR1Fw?=
 =?utf-8?B?cS9rYTk3V3I2WmdsOHBRSUduMmtaTDI1WUxNQ2Foa0F4aENDaWY4bHQvaURX?=
 =?utf-8?B?ZzBDUGhhK3RRQW1QVGVzMzNLV04xeXpNdXdmMXc4d1lYSWZVVWxDOERoSG4w?=
 =?utf-8?B?UFpDVE5IVlQ1K2wwVEt0ZFgwRE1US2RLR2tobXE2NGVUOStkeTZFdmNaVkpL?=
 =?utf-8?B?YWtqNWU2dUZsUDR3WXQ4NXVGRVVkZGlIaitWdm1lWUp5UEVjUWhKb2ZIRTNW?=
 =?utf-8?B?T1hBK0xTUVhKQmJFZitUWjB4MnZhTThiZy9UM1ZaTzl0TG5JNUxxSnkvN3Bi?=
 =?utf-8?B?b1lFZ2NpQVF1Z2pKME9qRGVxdWF1WG41VzhIdzQydEpIeFR4YVRZMnFacjcz?=
 =?utf-8?B?VlVEWGM3L21XVFlIcDBZQkpPZFJ2TWJpVFJsSFdHYXV0RDJWTUN4T0g4cG4v?=
 =?utf-8?B?TWJ0aXd6WU9kWFRFelUwOUIvbGN2bS92UEpQNGxPWEpQTSsxcEoweXlLZm9N?=
 =?utf-8?B?RTVQZEFWVWkvVFUxZnJyaWJLeE5KWmVnOThlT09JVVRSMkZrZlV5WkcyMDBW?=
 =?utf-8?B?ZFZRK200QnVOQ1dSdXBOZmRBMEQxUW5ldGo4N2Y1ZzZtWHR2L3J4ckpMNld5?=
 =?utf-8?B?Q21WQWhUU0xWcUdubXZsdzFMakY4WGNYOTJDTVkrVUFEbkp3dzkzS2o3bGN3?=
 =?utf-8?B?VDJPNmpMd29kNmtJbG1Xd3lRaVkvaUxudmtGaTBBWTJjYVpTNGZMVENKaGVS?=
 =?utf-8?B?WVRaSW9odWg3S01JcUtGZFd5SkIwNjk5TitDMldsNGFTMzk3NHZKaHJBMlZG?=
 =?utf-8?B?Q3B3SUJzQ3NFd3JOMFJhUFdYQzMrYmNubkYwVmw5eVpWNEw0VzFVdWZxc2ps?=
 =?utf-8?B?bTVRQTBEMThxZWdkUmJUN1A4WE1aa0ptSnNnTmJXQktrQkNlUWVHWW1iRXNI?=
 =?utf-8?B?Ym5XSklPaEtaMDlnZDVGSmNoeVVZQkRzcTRsMzRHVW9ZKzRydU1TTEZUYjE5?=
 =?utf-8?B?TmVsazEreFBzeG9EU0RGdDFCdlA3bjdBaGhIdVM3NFM2dXEzdFhsY3p6cUxu?=
 =?utf-8?B?Z1hWSmlTUVZvb2JXMjYvV2FjWjZzajM1NFovYTFUbEJMOWZoNUp1RE9iL095?=
 =?utf-8?B?bFlSamRVVCtuTERYUGhXV09ySEZtenhDNy9FaHg2NUFjR1BVTDA4VklVRVVq?=
 =?utf-8?Q?x2Hk0MkWyx+X+4VQtH3zzSwLVCGDVEOLla3g5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA93DA7DF031904EB9F20946635B659A@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962ec2b4-15cc-4d00-90ee-08de9c67e179
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 09:58:31.1373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BWksXmRwRoy0ZYezT0tEq/dxzC4Fd1U8jaBxbTigfp2d26kQpLELqVGFw5jl1U5+BDIRxSt2ZY/ebreNfw8OneVyhIwDdB7YBsToqgrKhLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB6976
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

DQpPbiA0LzkvMjYgMDY6MDUsIEFsaXN0YWlyIEZyYW5jaXMgd3JvdGU6DQo+IENBVVRJT046IFRo
aXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUg
dGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBPbiBUdWUs
IEFwciA3LCAyMDI2IGF0IDE6NDnigK9BTSBEam9yZGplIFRvZG9yb3ZpYw0KPiA8RGpvcmRqZS5U
b2Rvcm92aWNAaHRlY2dyb3VwLmNvbT4gd3JvdGU6DQo+PiBJbXBsZW1lbnQgcnVudGltZSBiaWct
ZW5kaWFuIGRhdGEgc3VwcG9ydCBieSByZWFkaW5nIHRoZSBNU1RBVFVTDQo+PiBVQkUvU0JFL01C
RSBiaXRzIHRvIGRldGVybWluZSBkYXRhIGVuZGlhbm5lc3MgcGVyIHByaXZpbGVnZSBsZXZlbC4N
Cj4+DQo+PiBUaGUga2V5IGNoYW5nZXMgYXJlOg0KPj4NCj4+IC0gQWRkIHJpc2N2X2NwdV9kYXRh
X2lzX2JpZ19lbmRpYW4oKSBoZWxwZXIgaW4gY3B1LmggdGhhdCBjaGVja3MNCj4+ICAgIHRoZSBh
cHByb3ByaWF0ZSBNU1RBVFVTIGVuZGlhbm5lc3MgYml0IGJhc2VkIG9uIGN1cnJlbnQgcHJpdmls
ZWdlDQo+PiAgICBsZXZlbCAoTUJFIGZvciBNLW1vZGUsIFNCRSBmb3IgUy1tb2RlLCBVQkUgZm9y
IFUtbW9kZSkuDQo+Pg0KPj4gLSBVcGRhdGUgbW9fZW5kaWFuKCkgaW4gdHJhbnNsYXRlLmMgdG8g
cmV0dXJuIE1PX0JFIG9yIE1PX0xFIGJhc2VkDQo+PiAgICBvbiBhIG5ldyAnYmlnX2VuZGlhbicg
ZmllbGQgaW4gRGlzYXNDb250ZXh0LCByYXRoZXIgdGhhbiB0aGUNCj4+ICAgIHByZXZpb3VzIGhh
cmRjb2RlZCBNT19URS4NCj4+DQo+PiAtIFVwZGF0ZSBtb19lbmRpYW5fZW52KCkgaW4gb3BfaGVs
cGVyLmMgdG8gY2FsbCB0aGUgbmV3IGhlbHBlciwNCj4+ICAgIGdpdmluZyBoeXBlcnZpc29yIGxv
YWQvc3RvcmUgaGVscGVycyBjb3JyZWN0IHJ1bnRpbWUgZW5kaWFubmVzcy4NCj4+DQo+PiAtIFBh
Y2sgdGhlIGVuZGlhbm5lc3MgZmxhZyBpbnRvIGNzX2Jhc2UgYml0IDMyIChhbG9uZ3NpZGUgbWlz
YV9leHQNCj4+ICAgIGluIGJpdHMgMC0yNSkgaW4gcmlzY3ZfZ2V0X3RiX2NwdV9zdGF0ZSgpLCBl
bnN1cmluZyB0cmFuc2xhdGlvbg0KPj4gICAgYmxvY2tzIGFyZSBjb3JyZWN0bHkgc2VwYXJhdGVk
IGJ5IGRhdGEgZW5kaWFubmVzcy4NCj4+DQo+PiBOb3RlOiBpbnN0cnVjdGlvbiBmZXRjaGVzIGNv
bnRpbnVlIHRvIHVzZSBNT19MRSB1bmNvbmRpdGlvbmFsbHkNCj4+IChmcm9tIHRoZSBwcmV2aW91
cyBwYXRjaCksIGFzIFJJU0MtViBpbnN0cnVjdGlvbnMgYXJlIGFsd2F5cw0KPj4gbGl0dGxlLWVu
ZGlhbiBwZXIgdGhlIElTQSBzcGVjaWZpY2F0aW9uLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IERq
b3JkamUgVG9kb3JvdmljIDxkam9yZGplLnRvZG9yb3ZpY0BodGVjZ3JvdXAuY29tPg0KPj4gLS0t
DQo+PiAgIHRhcmdldC9yaXNjdi9jcHUuaCAgICAgICAgIHwgMjggKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPj4gICB0YXJnZXQvcmlzY3YvaW50ZXJuYWxzLmggICB8ICA5ICstLS0tLS0t
LQ0KPj4gICB0YXJnZXQvcmlzY3YvdGNnL3RjZy1jcHUuYyB8ICA3ICsrKysrKy0NCj4+ICAgdGFy
Z2V0L3Jpc2N2L3RyYW5zbGF0ZS5jICAgfCAxMyArKysrKy0tLS0tLS0tDQo+PiAgIDQgZmlsZXMg
Y2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL3RhcmdldC9yaXNjdi9jcHUuaCBiL3RhcmdldC9yaXNjdi9jcHUuaA0KPj4gaW5kZXgg
MzVkMWY2MzYyYy4uZWY4NzBkMDViMyAxMDA2NDQNCj4+IC0tLSBhL3RhcmdldC9yaXNjdi9jcHUu
aA0KPj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdS5oDQo+PiBAQCAtNzAzLDYgKzcwMywxMiBAQCBG
SUVMRChUQl9GTEFHUywgQkNGSV9FTkFCTEVELCAyOCwgMSkNCj4+ICAgRklFTEQoVEJfRkxBR1Ms
IFBNX1BNTSwgMjksIDIpDQo+PiAgIEZJRUxEKFRCX0ZMQUdTLCBQTV9TSUdORVhURU5ELCAzMSwg
MSkNCj4+DQo+PiArLyoNCj4+ICsgKiBjc19iYXNlIGNhcnJpZXMgbWlzYV9leHQgKGJpdHMgMC0y
NSkgcGx1cyBhZGRpdGlvbmFsIGZsYWdzLg0KPj4gKyAqIEJpdCAzMiBpcyB1c2VkIGZvciBkYXRh
IGVuZGlhbm5lc3Mgc2luY2UgVEJfRkxBR1MgaGFzIG5vIGZyZWUgYml0cy4NCj4+ICsgKi8NCj4+
ICsjZGVmaW5lIFRCX0NTQkFTRV9CSUdfRU5ESUFOICAoMVVMTCA8PCAzMikNCj4gV2Ugc2hvdWxk
IHVwZGF0ZSB0aGUgY3NfYmFzZSBjb21tZW50IGluIFRyYW5zbGF0aW9uQmxvY2sNCj4NCj4gQWxp
c3RhaXINCg0KVGhhbmtzIEFsaXN0YWlyLCBQaGlsaXBwZS4NCg0KQWRkcmVzc2VkIGluIHY3Og0K
DQogwqAgLSBVcGRhdGVkIHRoZSBjc19iYXNlIGNvbW1lbnQgaW4gaW5jbHVkZS9leGVjL3RyYW5z
bGF0aW9uLWJsb2NrLmggdG8NCiDCoCBkb2N1bWVudCB0aGUgUklTQy1WIHVzYWdlIChtaXNhX2V4
dCBpbiBiaXRzIDAtMjUsIGVuZGlhbm5lc3MgaW4NCiDCoCBiaXQgMzIpLg0KIMKgIC0gRHJvcHBl
ZCB0aGUgbW9fZW5kaWFuKCkgd3JhcHBlciBlbnRpcmVseTsgY2FsbCBzaXRlcyBub3cgcmVmZXJl
bmNlDQogwqAgY3R4LT5tb19lbmRpYW5uZXNzIGRpcmVjdGx5Lg0KDQoNCkJlc3QsDQpEam9yZGpl
DQo=

