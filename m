Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC43C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reVJg-0006xk-3T; Mon, 26 Feb 2024 02:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1reVJY-0006vC-89; Mon, 26 Feb 2024 02:22:16 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1reVJU-0000gA-Cc; Mon, 26 Feb 2024 02:22:15 -0500
Received: from mail.andestech.com (ATCPCS33.andestech.com [10.0.1.100])
 by Atcsqr.andestech.com with ESMTP id 41Q7LkGv025803;
 Mon, 26 Feb 2024 15:21:46 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from ATCPCS33.andestech.com (10.0.1.100) by ATCPCS33.andestech.com
 (10.0.1.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 26 Feb
 2024 15:21:48 +0800
Received: from ATCPCS31.andestech.com (10.0.1.89) by ATCPCS33.andestech.com
 (10.0.1.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7 via Frontend
 Transport; Mon, 26 Feb 2024 15:21:48 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (104.47.110.41)
 by mail.andestech.com (10.0.1.89) with Microsoft SMTP Server (TLS) id
 14.3.498.0; Mon, 26 Feb 2024 15:21:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+u385Cn/GNfnR1lj2j4q/MRLckC5N0oQurKV5JH520/uGuM2xLlJNDcHGWUQxygGC1TF2c7hyV7SuyYQI3FUr/9TYGVD/98J0jdwGHRs8+lfFJ5JcsaYErLBKItogTwG8NFTpLX2a2qrZhDjm860EE9uDX6yyB3KUaiy4jY4ADCersH0LEGO24ZpXhDk7diJiIKOOTCAngKv4FVqqfaLrz37L/pyhI0Yd6GjdfSQcskjWXa3eYVX3mZP6JZUP/wtwXpy5/zh81j1ukZP2CeTSsyg9Z9pU0ntPKvK8v8dT5n3dHCeBw2GShjOaxaF3Oisz2evhI8P97Ji5RKC1A1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4P5kO69IPDVaDDdrBD9pQg5ryJf8xLelzXmeH4XNnE=;
 b=OP1U2ClucZ6aLth2hPHPDWTs10kWAuCw+rzIXpT9ZnMe4U0Bc+ceBic27jZeecAw90Vt2VvVgMYp0uma0Tmzh3r7N02JO2HR9BJr7f5JpP0pKqSWWXMvY6BHtw2/r0R8KFYhOgph7NlCIm3l6KRdKedEhUhOBkR46SABfsdpUsdGZtaOibCglf2+emdiHf2UbzLdmb3UyvXqhosFW3sDn5hCK8a3PGJecywZXXIEzN6Kaa0d3waFSNV7ydyKdhMkx/o9wIiZe6u0gDc9kwOvknJ3L7rSTkGIEYR0UniKMWya72/zgvlEXVSVzTtQWvh9IKk7FVERQK1fHve94QwyjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andestech.com; dmarc=pass action=none
 header.from=andestech.com; dkim=pass header.d=andestech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andestech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4P5kO69IPDVaDDdrBD9pQg5ryJf8xLelzXmeH4XNnE=;
 b=W3uwctNhxPVMNZjlSX6vdzdu7uBmUbp4JZbWi1/05OMn/PzJXA/VqbKn1P+l0TjsPDQBdotzKp8g6K7c0wTZfnCmpUTPyjgXVdk+wZSTG8+O/WYBy4G2U4x2zb3uQJhap9GSsjiE0UGGuaaCzBRCwq0rsjhuKaMFV9tl6tQR/CBYmgKJoM5RmW2m++ZmNPKtXe3zTn7iAdh7p3Ta9QLWsctA3lGPFs0hS8cHt7kCiKeaTdPb7aFzxgRaz1h32zZL11fhxVhrkT8jfId2bN2NbND2NBBtLlWyhcJGjJ4LL0Y4mj5h5yTquUZBOpvjdIsDNpoIuFj/Re8miaKfqsrSbg==
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com (2603:1096:101:69::14)
 by KL1PR03MB5668.apcprd03.prod.outlook.com (2603:1096:820:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 07:21:35 +0000
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::9523:69b6:faf2:3b83]) by SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::9523:69b6:faf2:3b83%4]) with mapi id 15.20.7316.023; Mon, 26 Feb 2024
 07:21:34 +0000
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
Thread-Index: AQHaZf8ElbG3tGFZyEOf0hz6xTVIErEbyIoAgAAJWUCAAGC9AIAACa5A
Date: Mon, 26 Feb 2024 07:21:34 +0000
Message-ID: <SEYPR03MB67009D5DCA919BA9F2E883DCA85A2@SEYPR03MB6700.apcprd03.prod.outlook.com>
References: <20240223022119.41255-1-alvinga@andestech.com>
 <CAKmqyKMkXf8mJvwh2vDEGh2fq-5AP2yz2Y9k-UH1D6MuW6CgTA@mail.gmail.com>
 <SEYPR03MB6700C2BF43C958F591025714A85A2@SEYPR03MB6700.apcprd03.prod.outlook.com>
 <CAKmqyKPa--pcYiZ955qqRhYeeUP2LXE5d=LVuCX58aYCGEgy1Q@mail.gmail.com>
In-Reply-To: <CAKmqyKPa--pcYiZ955qqRhYeeUP2LXE5d=LVuCX58aYCGEgy1Q@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andestech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6700:EE_|KL1PR03MB5668:EE_
x-ms-office365-filtering-correlation-id: 11898e8b-8c83-4cc4-bce1-08dc369b9025
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wwcUY8iW77JnQ+G6tDax+NWiQTfYQ4qSYJHXjnLYD0pUgU75vNdo+XxMJy+JYC3nCjJ0tlZIcWiXTDyHUP0vFFGFZfD5/WInhDVa7jrg4x7ORtu9Ai/MgUUOJ5+cTjltvhKxyAIsspLF7+lpgPK1GiC8P7pcu1pPezMT0ouTint0NaWh5vglH3ZF3krcC47+kOgRrsqXPWNqT+1Z/+l/ul/q4KVksH4l2jeXxq2lE1iXHEnXvfDSeSjf1yJBdIiKbepTGbQKCMBg3nqN21c2tyZzDYsIjYL+HoLm1xUfqN1iMFkhYpdCQpPKdaNh3rjqYX42f0qovqftyla3lSTiGOA0/qavBYZUfyofbLlPMtC9LgLBs4zpuedTSNAEhXdLTBASCsLZPmjYiirFNsCNZDKviwqfhfSX0oNC8oaRIlzWmIKiFIxR56mFkFyjDbpD/ufaZGFQuB8PcMyNZV9ZAcN16CK5t3yz9TteBiZAtGIxjvWlJarqd90E2dJduisibfAhC+FlEe1WqmDpWCCPukDK/CIXt4Gv9yCsu2dzwhEpxO9kjkYOIfxXSRxaJ9PdRa+PspzCBdCHtuPc42NtSDUAAYPW3O0ZUNlC+dP54lYj1q9BePQcWX+1b5UwtxokuUNpXI9g8bWSqP8Gl7HEO+GSVU0Df8LMwlPnG5Melwfl9iLxakNDKtbMVoLrNFAIoDrb4ThK3p00OutnX8Z5eQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR03MB6700.apcprd03.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(230273577357003)(230473577357003)(38070700009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVc2NlVJS1dXcUFpOFNLVThDVE1Pc1ZUMmc5MFhvSHFTd0Z2ckIyaXJ6Z2Qz?=
 =?utf-8?B?TWdQT3BVRTNVV0J3Y3YzM1lXUm91VTR3RjVDcUxtYVRpS000M3BEcU04MjY1?=
 =?utf-8?B?bjJpTEZMU3VkZmQ3anl0bWw1TWtLb25xQmtxU3BhYkEyeXRHRHQzandaVzhY?=
 =?utf-8?B?S1JScGViV0ZDQXdWNDJ2eEhFdWlJVnpDeVF6Zi95TldUc0JrN1VlaFVleU9M?=
 =?utf-8?B?R1laOWJZKzhuL0ZDNVRQelhYcTJmTlNaNVRFdXhwTEdCR0tMZnp0cTF1RzBJ?=
 =?utf-8?B?alJtdGxLK2hYWVg0WitQSTRiU2ExeGlHWDcyVkgrUmIyL1JiN2ZZN0xOeURP?=
 =?utf-8?B?M21jNGxoUXM5dlhUR3JEN0lPd0o2UTZCS3lBK0RRaHRZVTdkTnZ1WHo0cXNP?=
 =?utf-8?B?Ykh0VDlJclB6a1c3cVhqcklUOW5aYzFZYks1ZTFrMGRPMmYxc25ZNHV6UDE1?=
 =?utf-8?B?NGdzRDhsanZmcG9VVEFmNVZ2VW95NkNPMDFUMDVsV2NGR0pwWHRpbXpzTkgw?=
 =?utf-8?B?VVBXMHZ1ZmZLMW9lZlFYMHZuVDFxemFzdk9SNkZyd0VYTjVuQmszaEZ4ZVBy?=
 =?utf-8?B?eUpCMndac0JEQ1lYbW96cVpzcHhMbXRZTkFNam5kcHp1TmJsSWovUlR6cVdh?=
 =?utf-8?B?ZlZqUGtRRlhlZndJMzNjNmlwbkhFaDljL3JwZStkL1B3UWVIN1A1TmFpdGxt?=
 =?utf-8?B?S1FGc3pIQ2p5bUNhMDQwVXVYM1d0bEtTRkgwRlBPSW53bThySEFJT0U4bUNO?=
 =?utf-8?B?K0lRalJxai94V29XYUhhSXU4TmN0OXhoVVIrTmJoZm9sSVJDeldrLzREQ2Zo?=
 =?utf-8?B?NFVEK2Z0TG9xclBzdXV2REFzTDhtSFFRZXZ2c2hjZndhVnc0ZU14TEFwcGpU?=
 =?utf-8?B?YXN0MmhjZnVlYTFqOXBZbzF1VG9sRUVhNFJjdG1ieEN3ZHR2Y2xOVFc4OFJH?=
 =?utf-8?B?dDlQZVU4SDJ0aE40cnpsam5nL2RaalNSczJ5L2tLUi9FUnJQQjBsdkJTd1d4?=
 =?utf-8?B?UUdhcit0MjZ0WEJZZDJrSzFmNG1wWXFmT1ZnWURBVjhaQUlTaWU3Tjd0bVJr?=
 =?utf-8?B?eWxxZmFJRGN5OU13TVIrcStKeFJ5RkZySDVmMndwc3FYYndubFNLeXJnVUp3?=
 =?utf-8?B?YjY3RHZyZ0YrMjcxNGFZUGlGaUhYcWdOdWZkVjVVWnppK1RnVG9LWW9pNjl2?=
 =?utf-8?B?Q1IySlpzK0ZzTlNqV0x4S1VEUkY0NHNsTkx0M0FrWUNoMXNwTTd4blhkV1Bz?=
 =?utf-8?B?VUZLWlY1VkpZR0lCRVJEWmhHbk1vTFpYczMrY2U3RldValZyUWJwRDBKNG9h?=
 =?utf-8?B?azhza2NwUHBlZVNwUkRWbE5oM1ovZ0p1cUkvOWhvZUpUcTJHUHZSanZSU0tD?=
 =?utf-8?B?Y0g0VFFWdTRBUEZqV2x5RWE3MkkramdweXliZFo3UjU5YTZNSXJsK3lESGUw?=
 =?utf-8?B?MzFjZDJuWmcxWVVkUkNISU9hcGxMRXhNYUxFVDlHZlFjeUlBcWdydEMxMlRp?=
 =?utf-8?B?Rlp2N3d5ZXZCZjhsYmlyWG12U1VTR1k0bXF1b0dzWFRGSmpsNUFZMW4ydkdt?=
 =?utf-8?B?T1ovaHlGMklNeElQR1pxRVg5UCtvc2h1SDY3dktBQnI3UmNURjQ1dW0zVHlv?=
 =?utf-8?B?YmlwdjZKQmtvZDBBVnVkVlVIVzZ4S3ZNY0VzKzBlT1ZRUTRIQjVVNHNTaTAz?=
 =?utf-8?B?emg2eGlNZkd5ejdmMjVIQ2pTTGMvRGJFY1hKTUlzQTVrYkhpTnlNMUs3eGR2?=
 =?utf-8?B?WUMwd0Zzd284R0JQMHRsRDRZd1RWMXBKV0FWdWVEZnhWc3dYZjF0SnYycEJS?=
 =?utf-8?B?ZG9xWFN5cUErK0ltUTl5d3R0Yy9jOEpSMlBsNjZ4M0poVmd0NzluejhKUDZs?=
 =?utf-8?B?cytCbHNHSTEvZnQyOHd1OWhjeUVmVmVCY0c4WFlHWng1OUJNUTZnckVSOGhj?=
 =?utf-8?B?alFhOXFNWUtObG4rLzl3RlJseW93UGVjYU1PWjNYWEhzNzZqYnlXYXZWWW92?=
 =?utf-8?B?UEZEcXNsZE8xSm1uclBZRy8zb0FkZ0FJUWNnK1o0dGZoSktxYVFsQVpJSkgy?=
 =?utf-8?B?UG5vUi9EN3hWdWFzSmQyV3IxdUxTT0FHYzVxWmRWWllxR2J2S0NmUXBSSTlG?=
 =?utf-8?Q?ZaTFMX8ui0zZgS4LhjpNQGYk2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6700.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11898e8b-8c83-4cc4-bce1-08dc369b9025
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 07:21:34.5658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3ec21b7-ec6c-4041-9add-61aea8171458
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4aTDypK4LK01EgLuw6jP+2j5fk+L3ZSGKwcM5+AysiilewuYfBwsRMmnSnp3Q3shpmuih2rjwTiZX9CsfZ0Sew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5668
X-OriginatorOrg: andestech.com
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 41Q7LkGv025803
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
cnVhcnkgMjYsIDIwMjQgMjo0NSBQTQ0KPiBUbzogQWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy
5ZiJKSA8YWx2aW5nYUBhbmRlc3RlY2guY29tPg0KPiBDYzogcWVtdS1yaXNjdkBub25nbnUub3Jn
OyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbTsgYmlu
Lm1lbmdAd2luZHJpdmVyLmNvbTsgbGl3ZWkxNTE4QGdtYWlsLmNvbTsNCj4gZGJhcmJvemFAdmVu
dGFuYW1pY3JvLmNvbTsgemhpd2VpX2xpdUBsaW51eC5hbGliYWJhLmNvbQ0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYyIDAvNF0gUklTQy1WOiBNb2R1bGFyaXplIGNvbW1vbiBtYXRjaCBjb25kaXRp
b25zIGZvcg0KPiB0cmlnZ2VyDQo+DQo+IFtFWFRFUk5BTCBNQUlMIOWklumDqOS/oeS7tl0NCj4N
Cj4gT24gTW9uLCBGZWIgMjYsIDIwMjQgYXQgMTE6MTbigK9BTSBBbHZpbiBDaGUtQ2hpYSBDaGFu
ZyjlvLXlk7LlmIkpDQo+IDxhbHZpbmdhQGFuZGVzdGVjaC5jb20+IHdyb3RlOg0KPiA+DQo+ID4g
SGkgQWxpc3RhaXIsDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4g
PiBGcm9tOiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpcjIzQGdtYWlsLmNvbT4NCj4gPiA+IFNl
bnQ6IE1vbmRheSwgRmVicnVhcnkgMjYsIDIwMjQgODoyNSBBTQ0KPiA+ID4gVG86IEFsdmluIENo
ZS1DaGlhIENoYW5nKOW8teWTsuWYiSkgPGFsdmluZ2FAYW5kZXN0ZWNoLmNvbT4NCj4gPiA+IENj
OiBxZW11LXJpc2N2QG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gPiA+IGFs
aXN0YWlyLmZyYW5jaXNAd2RjLmNvbTsgYmluLm1lbmdAd2luZHJpdmVyLmNvbTsNCj4gPiA+IGxp
d2VpMTUxOEBnbWFpbC5jb207IGRiYXJib3phQHZlbnRhbmFtaWNyby5jb207DQo+ID4gPiB6aGl3
ZWlfbGl1QGxpbnV4LmFsaWJhYmEuY29tDQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAv
NF0gUklTQy1WOiBNb2R1bGFyaXplIGNvbW1vbiBtYXRjaA0KPiA+ID4gY29uZGl0aW9ucyBmb3Ig
dHJpZ2dlcg0KPiA+ID4NCj4gPiA+IFtFWFRFUk5BTCBNQUlMIOWklumDqOS/oeS7tl0NCj4gPiA+
DQo+ID4gPiBPbiBGcmksIEZlYiAyMywgMjAyNCBhdCAxMjoyMuKAr1BNIEFsdmluIENoYW5nIHZp
YQ0KPiA+ID4gPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gPiA+IHdyb3RlOg0KPiA+ID4gPg0K
PiA+ID4gPiBBY2NvcmRpbmcgdG8gUklTQy1WIERlYnVnIHNwZWNpZmljYXRpb24sIHRoZSBlbmFi
bGVkIHByaXZpbGVnZQ0KPiA+ID4gPiBsZXZlbHMgb2YNCj4gPiA+DQo+ID4gPiBDYW4geW91IHNw
ZWNpZnkgd2hhdCB2ZXJzaW9uIG9mIHRoZSBkZWJ1ZyBzcGVjPw0KPiA+DQo+ID4gSW4gZ2VuZXJh
bCwgdGhpcyBzZXJpZXMgZG9lcyBub3QgYWRkIGFueSBuZXcgZnVuY3Rpb25hbGl0aWVzLg0KPiA+
IFRoZSBvcmlnaW5hbCBpbXBsZW1lbnRhdGlvbiBoYXMgZHVwbGljYXRlZCBjb2RlIGluIHR5cGUg
Mi8zLzYgdHJpZ2dlcnMuDQo+ID4gSSBqdXN0IGVsaW1pbmF0ZWQgdGhvc2UgY29kZSBhbmQgbW9k
dWxhcml6ZWQgdGhlbSB0byBiZQ0KPiB0cmlnZ2VyX2NvbW1vbl9tYXRjaCgpLg0KPiA+IEJlc2lk
ZXMsIHdlIG1heSB3YW50IHRvIGNoZWNrIG90aGVyIGNvbmRpdGlvbnMgaW4gdGhlIGZ1dHVyZSwg
c28gdGhpcyBmdW5jdGlvbg0KPiBjYW4gYmUgdXNlZCBmb3IgdGhvc2UgcHVycG9zZXMuDQo+DQo+
IEFoLCB5b3UgYXJlIHJpZ2h0LiBJIGp1c3Qgc2tpbW1lZCB0aGUgbWVzc2FnZQ0KPg0KPiA+DQo+
ID4gV2hlbiBJIHRyYWNrIHRoZSBjb21taXQgaGlzdG9yeSwgaXQgc2VlbXMgdGhlIGNvZGUgaXMg
c3VibWl0dGVkIGluIHRoZQ0KPiBmb2xsb3dpbmcgY29tbWl0cyB0d28geWVhcnMgYWdvOg0KPiA+
DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9xZW11L3FlbXUvY29tbWl0Lzk1Nzk5ZTM2YzE1YTlhYjYw
MmEzODg0OTFjNDBmNjgNCj4gNjBmDQo+ID4gNmFlOGJmDQo+ID4NCj4gaHR0cHM6Ly9naXRodWIu
Y29tL3FlbXUvcWVtdS9jb21taXQvYjVmNjM3OWQxMzRiZDIwMWQ1MjM4MGM3M2ZmNzM1Ng0KPiA1
ZTYNCj4gPiBhNDMyMWUNCj4gPg0KPiBodHRwczovL2dpdGh1Yi5jb20vcWVtdS9xZW11L2NvbW1p
dC9jMzI0NjFkOGVlYjE3NDkwYjFiMWU5NjllMmNlOGYxDQo+IGVjZA0KPiA+IDgzYmZiYg0KPiA+
DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9xZW11L3FlbXUvY29tbWl0L2M0NzJjMTQyYTc1NTJmNWIw
ZTQwMzc4ZDU2NDNhMjgNCj4gMTBlDQo+ID4gZjFiMTExDQo+ID4NCj4gPiBTaW5jZSB0aGV5IG1l
bnRpb25lZCB0aGUgInR5cGUgNiIgdHJpZ2dlciBhbmQgIlNkdHJpZyIgZXh0ZW5zaW9uLCBJDQo+
ID4gYXNzdW1lIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gaXMgYmFzZWQgb24gRGVidWcgU3BlYyB2
ZXJzaW9uIDEuMCBUaGVyZQ0KPiA+IGlzIG5vIHR5cGUgNiB0cmlnZ2VyIGFuZCBTZHRyaWcgZXh0
ZW5zaW9uIGluIERlYnVnIFNwZWMgdmVyc2lvbiAwLjEzDQo+DQo+IFllYWgsIHdlIGFyZSBhIHdl
aXJkIG1peC1tYXRjaCBvZiB0aGUgdHdvIHVuZm9ydHVuYXRlbHkuIFdoaWNoIGlzIHdoeSBJDQo+
IHdhbnRlZCB0byBiZSBleHBsaWNpdCBhYm91dCB3aGljaCBkZWJ1ZyBzcGVjIHZlcnNpb24geW91
IGFyZSB0YXJnZXRpbmcuDQoNCkRvbmUsIEkgZXhwbGljaXRseSBtZW50aW9uIHRoZSB2ZXJzaW9u
IG9mIERlYnVnIFNwZWMgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0KUGxlYXNlIGNoZWNrIHBhdGNo
IHYzLg0KDQo+DQo+ID4NCj4gPiBTaW5jZXJlbHksDQo+ID4gQWx2aW4gQ2hhbmcNCj4gPg0KPiA+
ID4NCj4gPiA+IElkZWFsbHkgaWYgeW91IGNhbiBsaW5rIGRpcmVjdGx5IHRvIHRoZSBQREYgdGhh
dCB3b3VsZCBiZSB2ZXJ5IHVzZWZ1bC4NCj4gPiA+IFRoZXJlIGFyZSBtdWx0aXBsZSB2ZXJzaW9u
cyBzbyBpdCdzIGhhcmQgdG8ga2VlcCB0cmFjayBvZi4NCj4gPiA+DQo+ID4gPiBBbGlzdGFpcg0K
PiA+ID4NCj4gPiA+ID4gdGhlIHRyaWdnZXIgaXMgY29tbW9uIG1hdGNoIGNvbmRpdGlvbnMgZm9y
IGFsbCB0aGUgdHlwZXMgb2YgdGhlIHRyaWdnZXIuDQo+ID4gPiA+IFRoaXMgc2VyaWVzIG1vZHVs
YXJpemUgdGhlIGNvZGUgZm9yIGNoZWNraW5nIHRoZSBwcml2aWxlZ2UgbGV2ZWxzDQo+ID4gPiA+
IG9mIHR5cGUgMi8zLzYgdHJpZ2dlcnMgYnkgaW1wbGVtZW50aW5nIGZ1bmN0aW9ucw0KPiA+ID4g
PiB0cmlnZ2VyX2NvbW1vbl9tYXRjaCgpIGFuZCB0cmlnZ2VyX3ByaXZfbWF0Y2goKS4NCj4gPiA+
ID4NCj4gPiA+ID4gQWRkaXRpb25hbCBtYXRjaCBjb25kaXRpb25zLCBzdWNoIGFzIENTUiB0Y29u
dHJvbCBhbmQgdGV4dHJhLCBjYW4NCj4gPiA+ID4gYmUgZnVydGhlciBpbXBsZW1lbnRlZCBpbnRv
IHRyaWdnZXJfY29tbW9uX21hdGNoKCkgaW4gdGhlIGZ1dHVyZS4NCj4gPiA+ID4NCj4gPiA+ID4g
Q2hhbmdlcyBmcm9tIHYxOg0KPiA+ID4gPiAtIEZpeCB0eXBvDQo+ID4gPiA+IC0gQWRkIGNvbW1p
dCBkZXNjcmlwdGlvbiBmb3IgY2hhbmdpbmcgYmVoYXZpb3Igb2YgbG9vcGluZyB0aGUgdHJpZ2dl
cnMNCj4gPiA+ID4gICB3aGVuIHdlIGNoZWNrIHR5cGUgMiB0cmlnZ2Vycy4NCj4gPiA+ID4NCj4g
PiA+ID4gQWx2aW4gQ2hhbmcgKDQpOg0KPiA+ID4gPiAgIHRhcmdldC9yaXNjdjogQWRkIGZ1bmN0
aW9ucyBmb3IgY29tbW9uIG1hdGNoaW5nIGNvbmRpdGlvbnMgb2YgdHJpZ2dlcg0KPiA+ID4gPiAg
IHRhcmdldC9yaXNjdjogQXBwbHkgbW9kdWxhcml6ZWQgbWF0Y2hpbmcgY29uZGl0aW9ucyBmb3Ig
YnJlYWtwb2ludA0KPiA+ID4gPiAgIHRhcmdldC9yaXNjdjogQXBwbHkgbW9kdWxhcml6ZWQgbWF0
Y2hpbmcgY29uZGl0aW9ucyBmb3Igd2F0Y2hwb2ludA0KPiA+ID4gPiAgIHRhcmdldC9yaXNjdjog
QXBwbHkgbW9kdWxhcml6ZWQgbWF0Y2hpbmcgY29uZGl0aW9ucyBmb3IgaWNvdW50DQo+ID4gPiA+
IHRyaWdnZXINCj4gPiA+ID4NCj4gPiA+ID4gIHRhcmdldC9yaXNjdi9kZWJ1Zy5jIHwgMTI0DQo+
ID4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4gPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA4MyBpbnNlcnRpb25zKCspLCA0MSBkZWxldGlvbnMoLSkNCj4g
PiA+ID4NCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4zNC4xDQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4g
Q09ORklERU5USUFMSVRZIE5PVElDRToNCj4gPg0KPiA+IFRoaXMgZS1tYWlsIChhbmQgaXRzIGF0
dGFjaG1lbnRzKSBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgYW5kIGxlZ2FsbHkNCj4gcHJpdmls
ZWdlZCBpbmZvcm1hdGlvbiBvciBpbmZvcm1hdGlvbiBwcm90ZWN0ZWQgZnJvbSBkaXNjbG9zdXJl
LiBJZiB5b3UgYXJlIG5vdA0KPiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCB5b3UgYXJlIGhlcmVi
eSBub3RpZmllZCB0aGF0IGFueSBkaXNjbG9zdXJlLCBjb3B5aW5nLA0KPiBkaXN0cmlidXRpb24s
IG9yIHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpcyBzdHJpY3RseSBw
cm9oaWJpdGVkLiBJbg0KPiB0aGlzIGNhc2UsIHBsZWFzZSBpbW1lZGlhdGVseSBub3RpZnkgdGhl
IHNlbmRlciBieSByZXR1cm4gZS1tYWlsLCBkZWxldGUgdGhlDQo+IG1lc3NhZ2UgKGFuZCBhbnkg
YWNjb21wYW55aW5nIGRvY3VtZW50cykgYW5kIGRlc3Ryb3kgYWxsIHByaW50ZWQgaGFyZA0KPiBj
b3BpZXMuIFRoYW5rIHlvdSBmb3IgeW91ciBjb29wZXJhdGlvbi4NCj4gPg0KPiA+IENvcHlyaWdo
dCBBTkRFUyBURUNITk9MT0dZIENPUlBPUkFUSU9OIC0gQWxsIFJpZ2h0cyBSZXNlcnZlZC4NCj4N
Cj4gSSdtIG5vdCBzdXJlIHdoYXQgeW91IHdhbnQgbWUgdG8gZG8gaGVyZQ0KDQpPaC4uIEl0IGF1
dG9tYXRpY2FsbHkgc2hvd3MgdXAgd2hlbiBJIHNlbmQgZW1haWwgb3V0IG9mIG91ciBjb21wYW55
IHNlcnZlci4NClBsZWFzZSBpZ25vcmUgaXQgaGVyZS4NCg0KPg0KPiBBbGlzdGFpcg0KQ09ORklE
RU5USUFMSVRZIE5PVElDRToNCg0KVGhpcyBlLW1haWwgKGFuZCBpdHMgYXR0YWNobWVudHMpIG1h
eSBjb250YWluIGNvbmZpZGVudGlhbCBhbmQgbGVnYWxseSBwcml2aWxlZ2VkIGluZm9ybWF0aW9u
IG9yIGluZm9ybWF0aW9uIHByb3RlY3RlZCBmcm9tIGRpc2Nsb3N1cmUuIElmIHlvdSBhcmUgbm90
IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHlvdSBhcmUgaGVyZWJ5IG5vdGlmaWVkIHRoYXQgYW55
IGRpc2Nsb3N1cmUsIGNvcHlpbmcsIGRpc3RyaWJ1dGlvbiwgb3IgdXNlIG9mIHRoZSBpbmZvcm1h
dGlvbiBjb250YWluZWQgaGVyZWluIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIEluIHRoaXMgY2Fz
ZSwgcGxlYXNlIGltbWVkaWF0ZWx5IG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJldHVybiBlLW1haWws
IGRlbGV0ZSB0aGUgbWVzc2FnZSAoYW5kIGFueSBhY2NvbXBhbnlpbmcgZG9jdW1lbnRzKSBhbmQg
ZGVzdHJveSBhbGwgcHJpbnRlZCBoYXJkIGNvcGllcy4gVGhhbmsgeW91IGZvciB5b3VyIGNvb3Bl
cmF0aW9uLg0KDQpDb3B5cmlnaHQgQU5ERVMgVEVDSE5PTE9HWSBDT1JQT1JBVElPTiAtIEFsbCBS
aWdodHMgUmVzZXJ2ZWQuDQo=

