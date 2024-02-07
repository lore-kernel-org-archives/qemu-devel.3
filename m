Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9725DC48297
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 00:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXVy8-0005R2-BK; Tue, 06 Feb 2024 19:39:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1rXVy6-0005QK-0e; Tue, 06 Feb 2024 19:39:14 -0500
Received: from mail-psaapc01on2061e.outbound.protection.outlook.com
 ([2a01:111:f400:feae::61e]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1rXVy3-000200-JH; Tue, 06 Feb 2024 19:39:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3o/Da1/Y4Y3ETl2Kin4Xd8BfwTRWvySFJdx2XKHDit+fu+heolxFlTLmlAeI45DTdkKj46TqJOD0Q5veVy9PQ59LFL91BExR53cimYXowdDctN+0QkIxcjdMIL1M1kSOll5wBRcj2+8izrLbXc2n/7TXNUl7OkZxXKiAiIG5PibOwKMKPTNDtM7mi4dGd1vzMCPTChr1Zci15WulnJsoOAGHktJc6MbdnKOXxbEqjslqjIQLvoxh5Nw/M5Izw2g07/Rq2UZMGGBz2onHCqbI+QBMbo3rn0P9L6x5uCa7N8QQbSWzVUuANXv0rnQ9+ouELd4uk/sXc/IZBSL4z39iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6X63HXHEWcPxEvG3Qx1Vu0VeLxhmSqxLNP7270UJMw=;
 b=ZR0i4Cwx41XcUl3ihS8snaihFVu5uicJrbDbgD8rw+FTUJulw6UcdCp31C5cYY22yIhkg66g8LFcsuti1oAibLyzYqAUuNeBdjps1OsVxynVLI6UEt9aQ9ZbO2BAYuFSwkrxt8eQgtmQ4/Rm6tOw3pH9K+4Wj8rmstjEINBRXXAO7QpLsrml9LW3VWk12XwIccqRdNLEuKzHnhcIYoDrPytErdr2hV/ISx8kZ04DR2e6pLF2tpjqlShScsa1HHL5hWKm7z+IfY901b0pFZLQyI2N7iK1q+w7apivxGmhwfDRFJtWgAPVxr6RzWk58bhmLSdICwvMudKQFxt9WLyCKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6X63HXHEWcPxEvG3Qx1Vu0VeLxhmSqxLNP7270UJMw=;
 b=hUrgVXEfP00ARHHDhkoVugsT0zviGdm77bg0ZfxfcW/I2XQM0j5G4IWuJmgx/3Dw33QsWIn55ctDznd6SjH1Uie3937jmetr+ETUdbjhnPxzi46uDoWItkLZO2XEwqIM92K4l5tr+2ltsoFBcv/c0DiaWRBuTeH/D/GO5t2hzSg=
Received: from KL1PR03MB7744.apcprd03.prod.outlook.com (2603:1096:820:ed::12)
 by TYSPR03MB7570.apcprd03.prod.outlook.com (2603:1096:400:410::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 00:39:00 +0000
Received: from KL1PR03MB7744.apcprd03.prod.outlook.com
 ([fe80::4f80:9452:3322:20cb]) by KL1PR03MB7744.apcprd03.prod.outlook.com
 ([fe80::4f80:9452:3322:20cb%4]) with mapi id 15.20.7249.024; Wed, 7 Feb 2024
 00:39:00 +0000
From: "KFTING@nuvoton.com" <KFTING@nuvoton.com>
To: Nabih Estefan <nabihestefan@google.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Avi.Fishman@nuvoton.com"
 <Avi.Fishman@nuvoton.com>, "KWLIU@nuvoton.com" <KWLIU@nuvoton.com>,
 "tomer.maimon@nuvoton.com" <tomer.maimon@nuvoton.com>,
 "Hila.Miranda-Kuzi@nuvoton.com" <Hila.Miranda-Kuzi@nuvoton.com>
Subject: RE: [PATCH 1/1] tests/qtest: Fixing GMAC test to run in 7xx
Thread-Topic: [PATCH 1/1] tests/qtest: Fixing GMAC test to run in 7xx
Thread-Index: AQHaWVOJkj3R4HlxSkyborOyUvP6ZbD+CQzQ
Date: Wed, 7 Feb 2024 00:39:00 +0000
Message-ID: <KL1PR03MB774450ED922D6301EEB50779DB452@KL1PR03MB7744.apcprd03.prod.outlook.com>
References: <20240206232337.1043760-1-nabihestefan@google.com>
 <20240206232337.1043760-2-nabihestefan@google.com>
In-Reply-To: <20240206232337.1043760-2-nabihestefan@google.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7744:EE_|TYSPR03MB7570:EE_
x-ms-office365-filtering-correlation-id: f17e0f3d-08c4-458d-df11-08dc27752d2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zuibhebpdfojYa9A1dUF8Jhr+T1w8nX7bG0WVGNekXKCMmSILh6o9uSP/ztklwZuJ0K8VzogXSZGEBosw805ioqT+HPjnwczLY4uXG7y8YFWZSyvezAtmhBalbhzl6B/Pqyw62gUW8UVMfd8P+FX8gVX4eVXZ4JAx34Ff+DC+/rmHjkMdtInAqPHT77hOEyj1yoBpqotfvN9RR5JuYIZH4RRWv6d7hkD5hiLFA+icanNj7+RpDar4YMHKIF6WkRbTtmJquZL+8wAHKlZBO6zGGGOI8hkYUaFBwtWm8sjaanj7hnPC5XK9iHSu8fIqpCnXHdKYTlRrlKdnsKMUR0+WW7oEYgoSk5M+vWU8VN82ji6gRoHsncS69Kxy7Jw6v4521gS/3pu1EQAtTpo72SNofxOQEXiRWxkVLAPVuzS346hxJ3GvCbi7rEKowa3uSZADDPqHb4Z3VbLSeJr3vAL0C2tPWYnfBqZTTqYz050dFUR4rNLe4kIWOzdxDmHzNS/T0sbw7uaLfpKMyzjjCicIsxwZ6QIMpBIGx8YRihqjLptRXEGfeBdL/WP2ck7oRGr2dwQuCnBnuq1cRGe0uVN9RpnrzQ6GTOAv9oBqi3E8SZwJ0zsHTucqjaPvxvtwk5u
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR03MB7744.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(230273577357003)(64100799003)(186009)(1800799012)(451199024)(55016003)(5660300002)(52536014)(2906002)(41300700001)(83380400001)(122000001)(38100700002)(107886003)(26005)(86362001)(6506007)(7696005)(66556008)(33656002)(9686003)(110136005)(66946007)(54906003)(64756008)(66446008)(66476007)(53546011)(71200400001)(478600001)(76116006)(8936002)(4326008)(38070700009)(8676002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTRWMzIzWFNVQzBQU2hNRllsZlRYL0dHbDJ0RzQ2dkg4b2E2Uk9BaHVHeloz?=
 =?utf-8?B?QnFGdW5aOUdkaTRwT3F2d0ZFVWV4S1pEVDBRaUc0WWhJbUNTV2NwcWE5Q05G?=
 =?utf-8?B?T051dVFKelQyeHBTMUxya0s5dGFDL0pGOUJGaE1aZXhSWnZXS3NHbkw5NHNW?=
 =?utf-8?B?Q3hya2J5azhKL09vTVUzUFppbmRSb3hIV2ZiWDRPbkhDSDVvWm04eFBDK3A2?=
 =?utf-8?B?bzFzWWZBdXBwZUFMUTdUQjRQbkhvVnREZWI0cUVRUmpnS3N6bStWcXpIZWJ5?=
 =?utf-8?B?cDk5L2xWcDlOVWl4d1o4Z1k3cittZ3JLS2pSdG5WQmVYY0gzNERmRDYrYVNq?=
 =?utf-8?B?MDFCYVBQVW1rY3hQOWZoVnduOEtPdUZJbmhrOU0vT2lTMDlwcGl3dTFzMVdL?=
 =?utf-8?B?WWdrQUx1dytyNXVHWDBjczc1dXhSOEllM3JlU3lVRllqZVZ0b3ZGdzExZFR1?=
 =?utf-8?B?dWlCTkl6TDh3OUtHNmIwZUQwcW9QenB4eTVNWXFhVTlwai9rNFh6eXMyRU9P?=
 =?utf-8?B?U3VGcVEraGl2clZ1Y0VTM2d0VHVTRDJqdkRRejcvdGJYYTRHdzJleHlrVkps?=
 =?utf-8?B?ditCYmZBNWRDemd5ckMyOXlaM2hueHpiYlpRSkdxOGxsWGxNZDNwTFlrUDda?=
 =?utf-8?B?SzZoYUp4MWhEU0h2SU1LQjhNQ0JMVFFZS3NiaStHSVljNitSL1h5SUQ0TTZ1?=
 =?utf-8?B?NS9lLy9TdFN2UHBCL0RaalV2Mm5JYVUweHNVcmVrQVJwVXM0SGhCZDhpM1Vt?=
 =?utf-8?B?aDFBRUlkTWJKT3JRN2JjcFM2SEM5T1ZUTXJ2VWV4QnNaM1R0V1ptZ3J6YzZY?=
 =?utf-8?B?MjBFRFNQTmtFcDNVS2ZXQU8wcFFiaW9rTFhaclFqTDk4L2hFS3hmOC9HTVNN?=
 =?utf-8?B?RXlwN2J5bzMzK2VTdWFXQk8xQUVyQ290czBOTk53aFRTQjNlZEVOdzJ1OGdT?=
 =?utf-8?B?eDZYVitMbnNrejR1VGxzVWRxOUI5R0FXaEd6SjVjYjBCTDVraHBrQ21NSkxm?=
 =?utf-8?B?VEYxbUdZMlQvMXF3cFdVWWMzRjQ4UFBtM1Q5N1JOZHk5TEhEYnpkM01SQVlI?=
 =?utf-8?B?cGhkcWFmcXUvWlE2Tko2dUZnQUhLMTZEcFhCcXcxWXk2RGEybFNJYTA1N3M1?=
 =?utf-8?B?QTkrQmE4QXMwNzU2VDhGUUxsYXpCNmI3MDJiVVBaMEp4am9ZU3lyWWx2WERV?=
 =?utf-8?B?TnllLzJiZzk2T2UwU0dXS1ZVRzJVek1ERkYrZkxXRjh3L2FhN1lDcUxzQVNi?=
 =?utf-8?B?TEpncVM3NE5Bd285eENYcjVrNzdMWGRtZHhFVDk0SE9RWFpYZ3RtR2l6djh5?=
 =?utf-8?B?N3FZczU2bjJXUzBwMnBjTk1laGQ1cHpMa2pZUkF0YVNjblY4N2RpMEZZcXlt?=
 =?utf-8?B?MDNETlk2WmlqVTRxdEc5M1pKT0h3VEpQUm9WZFh1NHlZNjdoL0IvRytla2dV?=
 =?utf-8?B?RnJRemZuL0c3STFFU0tXUnlydXNQWlh5QjUvY2RHSHk2UEVFVFRXaTIrbFdL?=
 =?utf-8?B?S1ZudmljNHZSVjRYMVVzUTBhRFZzUHR3Ty9ySkplcTg5UzlONTZyWDdHVHov?=
 =?utf-8?B?dVIvZkxOUzk4TWlEaWlKMjFrWEZuTDJGUWtjZGxKb0lrZitGRlNaTmlqMlhv?=
 =?utf-8?B?bWozbEJJMmhhcHBvTzYyclN5WC9yUUVpcjhEZXR3dE84YlVqRGpsWC93MzVr?=
 =?utf-8?B?TXh5dkdOSlBuTHZ2dW9rblA0TlQ4OVhBTTZ0eWlvKzJFb21Tb1RMNmV4R2J0?=
 =?utf-8?B?bEJpTkNHZDhMSUNiMVUrRjRTSTFkZ3l6WmNSUjErMm5IMWpMQTg0V2FoWkpY?=
 =?utf-8?B?RUJqeVFBMUpEbWtQM3RTVmRLc3hmalMyNG8wdDh4UGlCd1hkVjVIZ1FnV3VT?=
 =?utf-8?B?eU1mcVVVYUM1Kzg5SFdiNzBweFZPT3dYQjhGNjhuLzgzWC9mSDJUWGVyVG1X?=
 =?utf-8?B?SzNKVGRQdlY4RGpNR0RHeUxhS0p1RXRnNmx2SVQ5ZXhHQ2Q3NGZsNzJwejRr?=
 =?utf-8?B?OU9DbGJaWmZrU1lZaW9DWisyanBSU3lMTFlvQkJoN2xBVHpSU0hVcDdERkxu?=
 =?utf-8?B?YVlkYzB0ZCtsU1BuTTlncDV6YUVsQVlBVzlpeVRRR2Zwc2ZZejNzVzFBc1dy?=
 =?utf-8?Q?d7LZihoYZC5Y7zLt4LJGvUEST?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7744.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17e0f3d-08c4-458d-df11-08dc27752d2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 00:39:00.1968 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5HQ2tE9eX3uABY4l3A2hu3CKRQgs7BNhI5SAbLCbMj9cRgoB4GKL4W1lm7HQhbi3khBXPWAXOy5RfT5ToEaHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7570
Received-SPF: pass client-ip=2a01:111:f400:feae::61e;
 envelope-from=KFTING@nuvoton.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBOYWJpaCBFc3RlZmFuIDxuYWJp
aGVzdGVmYW5AZ29vZ2xlLmNvbT4NClNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgNywgMjAyNCA3
OjI0IEFNDQpUbzogcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnDQpDYzogcWVtdS1hcm1Abm9uZ251
Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBDUzIwIEtGVGluZyA8S0ZUSU5HQG51dm90b24u
Y29tPjsgd3VoYW90c2hAZ29vZ2xlLmNvbTsgamFzb3dhbmdAcmVkaGF0LmNvbTsgSVMyMCBBdmkg
RmlzaG1hbiA8QXZpLkZpc2htYW5AbnV2b3Rvbi5jb20+OyBuYWJpaGVzdGVmYW5AZ29vZ2xlLmNv
bTsgQ1MyMCBLV0xpdSA8S1dMSVVAbnV2b3Rvbi5jb20+OyBJUzIwIFRvbWVyIE1haW1vbiA8dG9t
ZXIubWFpbW9uQG51dm90b24uY29tPjsgSU4yMCBIaWxhIE1pcmFuZGEtS3V6aSA8SGlsYS5NaXJh
bmRhLUt1emlAbnV2b3Rvbi5jb20+DQpTdWJqZWN0OiBbUEFUQ0ggMS8xXSB0ZXN0cy9xdGVzdDog
Rml4aW5nIEdNQUMgdGVzdCB0byBydW4gaW4gN3h4DQoNCkNBVVRJT04gLSBFeHRlcm5hbCBFbWFp
bDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBhY2tu
b3dsZWRnZSB0aGUgc2VuZGVyIGFuZCBjb250ZW50Lg0KDQoNCkZpeGluZyB0aGUgbm9jbV9nbWFj
LXRlc3QuYyBmaWxlIHRvIHJ1biBvbiBhIG51dm90b24gN3h4IG1hY2hpbmUgaW5zdGVhZCBvZiA4
eHguIEFsc28gZml4aW5nIGNvbW1lbnRzIHJlZmVyZW5jaW5nIHRoaXMgYW5kIHZhbHVlcyBleHBl
Y3RpbmcgOHh4Lg0KDQpDaGFuZ2UtSWQ6IEkwN2I5MWU4YmU0NzNlNmExZWNlNjVhMjIwMjYwOGI1
MmVkNDAyNWI4DQpTaWduZWQtT2ZmLUJ5OiBOYWJpaCBFc3RlZmFuIDxuYWJpaGVzdGVmYW5AZ29v
Z2xlLmNvbT4NClJldmlld2VkLWJ5OiBUeXJvbmUgVGluZyA8a2Z0aW5nQG51dm90b24uY29tPg0K
DQotLS0NCiB0ZXN0cy9xdGVzdC9tZXNvbi5idWlsZCAgICAgIHwgIDQgKystLQ0KIHRlc3RzL3F0
ZXN0L25wY21fZ21hYy10ZXN0LmMgfCAxMiArKy0tLS0tLS0tLS0NCiAyIGZpbGVzIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS90ZXN0cy9x
dGVzdC9tZXNvbi5idWlsZCBiL3Rlc3RzL3F0ZXN0L21lc29uLmJ1aWxkIGluZGV4IDM5NTU3ZDVl
Y2IuLjJiODllODYzNGIgMTAwNjQ0DQotLS0gYS90ZXN0cy9xdGVzdC9tZXNvbi5idWlsZA0KKysr
IGIvdGVzdHMvcXRlc3QvbWVzb24uYnVpbGQNCkBAIC0xOTIsNyArMTkyLDggQEAgcXRlc3RzX25w
Y203eHggPSBcDQogICAgJ25wY203eHhfc2RoY2ktdGVzdCcsDQogICAgJ25wY203eHhfc21idXMt
dGVzdCcsDQogICAgJ25wY203eHhfdGltZXItdGVzdCcsDQotICAgJ25wY203eHhfd2F0Y2hkb2df
dGltZXItdGVzdCddICsgXA0KKyAgICducGNtN3h4X3dhdGNoZG9nX3RpbWVyLXRlc3QnLA0KKyAg
ICducGNtX2dtYWMtdGVzdCddICsgXA0KICAgIChzbGlycC5mb3VuZCgpID8gWyducGNtN3h4X2Vt
Yy10ZXN0J10gOiBbXSkgIHF0ZXN0c19hc3BlZWQgPSBcDQogICBbJ2FzcGVlZF9oYWNlLXRlc3Qn
LA0KQEAgLTIzMSw3ICsyMzIsNiBAQCBxdGVzdHNfYWFyY2g2NCA9IFwNCiAgIChjb25maWdfYWxs
X2RldmljZXMuaGFzX2tleSgnQ09ORklHX1JBU1BJJykgPyBbJ2JjbTI4MzUtZG1hLXRlc3QnXSA6
IFtdKSArICBcDQogICAoY29uZmlnX2FsbF9hY2NlbC5oYXNfa2V5KCdDT05GSUdfVENHJykgYW5k
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgY29uZmln
X2FsbF9kZXZpY2VzLmhhc19rZXkoJ0NPTkZJR19UUE1fVElTX0kyQycpID8gWyd0cG0tdGlzLWky
Yy10ZXN0J10gOiBbXSkgKyBcDQotICAoY29uZmlnX2FsbF9kZXZpY2VzLmhhc19rZXkoJ0NPTkZJ
R19OUENNN1hYJykgPyBxdGVzdHNfbnBjbTd4eCA6IFtdKSArIFwNCiAgIFsnYXJtLWNwdS1mZWF0
dXJlcycsDQogICAgJ251bWEtdGVzdCcsDQogICAgJ2Jvb3Qtc2VyaWFsLXRlc3QnLA0KZGlmZiAt
LWdpdCBhL3Rlc3RzL3F0ZXN0L25wY21fZ21hYy10ZXN0LmMgYi90ZXN0cy9xdGVzdC9ucGNtX2dt
YWMtdGVzdC5jIGluZGV4IDllNThiMTVjYTEuLjBkMWJjODEwN2IgMTAwNjQ0DQotLS0gYS90ZXN0
cy9xdGVzdC9ucGNtX2dtYWMtdGVzdC5jDQorKysgYi90ZXN0cy9xdGVzdC9ucGNtX2dtYWMtdGVz
dC5jDQpAQCAtMzYsNyArMzYsNyBAQCB0eXBlZGVmIHN0cnVjdCBUZXN0RGF0YSB7DQogICAgIGNv
bnN0IEdNQUNNb2R1bGUgKm1vZHVsZTsNCiB9IFRlc3REYXRhOw0KDQotLyogVmFsdWVzIGV4dHJh
Y3RlZCBmcm9tIGh3L2FybS9ucGNtOHh4LmMgKi8NCisvKiBWYWx1ZXMgZXh0cmFjdGVkIGZyb20g
aHcvYXJtL25wY203eHguYyAqLw0KIHN0YXRpYyBjb25zdCBHTUFDTW9kdWxlIGdtYWNfbW9kdWxl
X2xpc3RbXSA9IHsNCiAgICAgew0KICAgICAgICAgLmlycSAgICAgICAgPSAxNCwNCkBAIC00Niwx
NCArNDYsNiBAQCBzdGF0aWMgY29uc3QgR01BQ01vZHVsZSBnbWFjX21vZHVsZV9saXN0W10gPSB7
DQogICAgICAgICAuaXJxICAgICAgICA9IDE1LA0KICAgICAgICAgLmJhc2VfYWRkciAgPSAweGYw
ODA0MDAwDQogICAgIH0sDQotICAgIHsNCi0gICAgICAgIC5pcnEgICAgICAgID0gMTYsDQotICAg
ICAgICAuYmFzZV9hZGRyICA9IDB4ZjA4MDYwMDANCi0gICAgfSwNCi0gICAgew0KLSAgICAgICAg
LmlycSAgICAgICAgPSAxNywNCi0gICAgICAgIC5iYXNlX2FkZHIgID0gMHhmMDgwODAwMA0KLSAg
ICB9DQogfTsNCg0KIC8qIFJldHVybnMgdGhlIGluZGV4IG9mIHRoZSBHTUFDIG1vZHVsZS4gKi8g
QEAgLTE5Niw3ICsxODgsNyBAQCBzdGF0aWMgdm9pZCB0ZXN0X2luaXQoZ2NvbnN0cG9pbnRlciB0
ZXN0X2RhdGEpICB7DQogICAgIGNvbnN0IFRlc3REYXRhICp0ZCA9IHRlc3RfZGF0YTsNCiAgICAg
Y29uc3QgR01BQ01vZHVsZSAqbW9kID0gdGQtPm1vZHVsZTsNCi0gICAgUVRlc3RTdGF0ZSAqcXRz
ID0gcXRlc3RfaW5pdCgiLW1hY2hpbmUgbnBjbTg0NS1ldmIiKTsNCisgICAgUVRlc3RTdGF0ZSAq
cXRzID0gcXRlc3RfaW5pdCgiLW1hY2hpbmUgbnBjbTc1MC1ldmIiKTsNCg0KICNkZWZpbmUgQ0hF
Q0tfUkVHMzIocmVnbm8sIHZhbHVlKSBcDQogICAgIGRvIHsgXA0KLS0NCjIuNDMuMC41OTQuZ2Q5
Y2Y0ZTIyN2QtZ29vZw0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18NCiBUaGUgcHJpdmlsZWdlZCBjb25maWRlbnRpYWwg
aW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgZW1haWwgaXMgaW50ZW5kZWQgZm9yIHVzZSBv
bmx5IGJ5IHRoZSBhZGRyZXNzZWVzIGFzIGluZGljYXRlZCBieSB0aGUgb3JpZ2luYWwgc2VuZGVy
IG9mIHRoaXMgZW1haWwuIElmIHlvdSBhcmUgbm90IHRoZSBhZGRyZXNzZWUgaW5kaWNhdGVkIGlu
IHRoaXMgZW1haWwgb3IgYXJlIG5vdCByZXNwb25zaWJsZSBmb3IgZGVsaXZlcnkgb2YgdGhlIGVt
YWlsIHRvIHN1Y2ggYSBwZXJzb24sIHBsZWFzZSBraW5kbHkgcmVwbHkgdG8gdGhlIHNlbmRlciBp
bmRpY2F0aW5nIHRoaXMgZmFjdCBhbmQgZGVsZXRlIGFsbCBjb3BpZXMgb2YgaXQgZnJvbSB5b3Vy
IGNvbXB1dGVyIGFuZCBuZXR3b3JrIHNlcnZlciBpbW1lZGlhdGVseS4gWW91ciBjb29wZXJhdGlv
biBpcyBoaWdobHkgYXBwcmVjaWF0ZWQuIEl0IGlzIGFkdmlzZWQgdGhhdCBhbnkgdW5hdXRob3Jp
emVkIHVzZSBvZiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gb2YgTnV2b3RvbiBpcyBzdHJpY3Rs
eSBwcm9oaWJpdGVkOyBhbmQgYW55IGluZm9ybWF0aW9uIGluIHRoaXMgZW1haWwgaXJyZWxldmFu
dCB0byB0aGUgb2ZmaWNpYWwgYnVzaW5lc3Mgb2YgTnV2b3RvbiBzaGFsbCBiZSBkZWVtZWQgYXMg
bmVpdGhlciBnaXZlbiBub3IgZW5kb3JzZWQgYnkgTnV2b3Rvbi4NCg==

