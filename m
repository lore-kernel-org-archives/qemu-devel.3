Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E65FD9E1F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 00:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvlLB-0001Fb-Ax; Thu, 26 Feb 2026 19:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=511ad3126=Alistair.Francis@wdc.com>)
 id 1vvlL6-0001Em-SH; Thu, 26 Feb 2026 19:04:16 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=511ad3126=Alistair.Francis@wdc.com>)
 id 1vvlL4-0004yt-M0; Thu, 26 Feb 2026 19:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1772150654; x=1803686654;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=iRYuOTtwXkbhLDjSoy8B3O5rDWHFm5R/7jZyx8t0Nm4=;
 b=mM4gspGERa8yheniIVDXUB0QD0tmQ7uC2nGsPy1uecMtF4Y3T6I9BUPR
 KkeVLdy4XhNEBarQOzaiLxBcsfZl2i4/Wj7GCsf/Su6HpafemwzWF+Nms
 K7dWnPD28OwKXrEGXiKY9PmPNBK6TuHPzTN4LK4bvHozCxs5hPK69e3wR
 xadTw/grXIcMZGN9xPzo7Mi4JhaH5ts3Z8toX05nduoy5tzkQlVhSCnUj
 ptjwJzNQLOHLy+C6u/Vnmb3aiU3M6SQtxKy//fWimPhY5eF0h1ZNbbP8I
 lPrpApMfPZAoiwaQ7CjCJLdaWUDlpfwlusaanOcqUf+Bog0ETRlvUscX4 A==;
X-CSE-ConnectionGUID: oiCZvPm9TA6mcmZQzxcghw==
X-CSE-MsgGUID: gKOrKOmqQuOebxjLi/nPQA==
X-IronPort-AV: E=Sophos;i="6.21,313,1763395200"; d="scan'208";a="137958258"
Received: from mail-westus2azon11012029.outbound.protection.outlook.com (HELO
 MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.29])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Feb 2026 08:04:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pG690z8kLzZakfSFv9bELW1J/oN6zCAHDuHAyoLSNAnjmm13LKbsC7n5jpLAczgrXBQvAo4X3cS1mJpVzE1Hb6mGXysG76hwVH0o2JyIOojFuM0L0QQNsJhuSQqx33L7FI1VW/vvvfN7TI2AByGbOyRP6kgWAQBgPVXnGEGjqXs9gRNF2eNaFMcEv6GFgkmB97HoBbif6K2U/OD7ihKzfc9kZ6EkWI6ArhxVhLt16VmO65GAkASwRtELI/mQXUqOegbZN/oF2ExV0Rsq3mgaEVy0JmsauzGGvWTXpCe/KlVQ7liVV+uys2UPsWjDCAzn3JscPbPNEQWZhDUZEpK8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRYuOTtwXkbhLDjSoy8B3O5rDWHFm5R/7jZyx8t0Nm4=;
 b=jWF3glOzE7ECaesqxYUTNGQ/Vy4ESIxnDizj8SkjQkL/MzIdfdBzNw7vpDon8MnU8Xpn6mLkJoD6xHA2xYr4zg5uCObcLuSFdXXYQdEyGr3703/L/OD9WmRk2VfTk65OWsNK6CspAxt6/1rn29bo7Dz8vXchWTxYGNTLIqyNTf9oJBhX+Ddc3NaFgZ5LQnmma4lbT+AyBqz6MInvUF3jyG4cYpj6375H+Y08uKU/aVkfreV9OgZlRT9nuCuGP1vxZB+hdUH0qujTmyS/Km+hp5XXdpJfz8OBOx4lFtKld6HjHqxZdCvtu2nvSp28+pCQ6oHSVNb71kaMXe18xFMJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRYuOTtwXkbhLDjSoy8B3O5rDWHFm5R/7jZyx8t0Nm4=;
 b=nyudHhn0o79b9l5YTuEXEJpLbQqIDJL4b0phEVR+qktoT42fG0f0uR0RQSMCOvm5fOVHZcNRDbh5juSeYzeIQTk/1WhGCjQKOZ9uBFv2DSQSARZYmb53/3Yxq7RcuRjI3Ly7xgO8yPc4J473ox9L5oN+RF6OEWIhwmKWxDUw8Z4=
Received: from SA1PR04MB9849.namprd04.prod.outlook.com (2603:10b6:806:4a3::15)
 by PH0PR04MB8550.namprd04.prod.outlook.com (2603:10b6:510:295::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 00:04:06 +0000
Received: from SA1PR04MB9849.namprd04.prod.outlook.com
 ([fe80::705f:2ac8:b2ff:f845]) by SA1PR04MB9849.namprd04.prod.outlook.com
 ([fe80::705f:2ac8:b2ff:f845%7]) with mapi id 15.20.9654.007; Fri, 27 Feb 2026
 00:04:06 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "lex.bailey@lowrisc.org" <lex.bailey@lowrisc.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "amitkh@google.com" <amitkh@google.com>, "qemu-maintainers@lowrisc.org"
 <qemu-maintainers@lowrisc.org>, "philmd@linaro.org" <philmd@linaro.org>,
 "alistair@alistair23.me" <alistair@alistair23.me>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "dave@treblig.org"
 <dave@treblig.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>
Subject: Re: [PATCH qemu 04/11] [ot] target/riscv: implement custom LowRisc
 Ibex CSRs
Thread-Topic: [PATCH qemu 04/11] [ot] target/riscv: implement custom LowRisc
 Ibex CSRs
Thread-Index: AQHconoLxCfsiZ+dCk2H9sN0GJhMSbWVtDiA
Date: Fri, 27 Feb 2026 00:04:06 +0000
Message-ID: <bdcd1226cd1588c746506955ef77548e493cf8b3.camel@wdc.com>
References: <177159976712.8279.7732381632410882915-4@git.sr.ht>
In-Reply-To: <177159976712.8279.7732381632410882915-4@git.sr.ht>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.58.3 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR04MB9849:EE_|PH0PR04MB8550:EE_
x-ms-office365-filtering-correlation-id: 8da668c4-1d7a-45db-ccac-08de7593b965
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|10070799003|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: f156k/DBE//k7c/TMKc0nH8K1RGs+AfxKeO2itGlRp0xQ//9jw/Dh2OWlVRdbHCeJCSr5Lhr3Q9/1ZNKKAXJdJPyMZgBzIYv7TW4F0LNZZUJUzvlGbVv4UyGGAXUMnHa3N6sw2dYveXB61YTVjs8gH5lL1P3umVEVGowfRxGJ1WA245UTozYKdjV8msnCPNn4zWxEjiGjwyfUqZBg5399UuEziabF1nWpVFs7Rri+uXJI2lpa0TfnVe4qQx01OEU9j3mgmPSb8ZunzcMU6D+X2XdwlLs2MOpnsWGWrUpQM5aNL09Yaf49vPaJxterapEqwcpypN1vbD1WT/JAD+KpbK91mqDfu2L6YoSdwBVKYcOYfM3GdvahU1W9jYzvhBg0VA3WHhQhhguMIS2coq4ZH7/7N1O+l4O3UqBNxoHQUUQfobNxlHD0bJPevJ2m7EDUzYLJWDrYpMcDHAbHB5covQaGbqXIB4fHyQpQZ6+uz+UhSEd6VbfQ3CGUe7bZdFqRjvBWR/qGvm2k0UA8D82WD7xdWTrWHQk/I6BrEm97E1aNp3z7hvEdk+ojtMQUPZYJgJWb1bi0Ufli5RGy503WVhcEI9DhsZuEeQ1gZU/NWTsfFTxLCOI/Wwc5X+Eq0vgbKtDqOvfrh6heqN05gLubBu+NYgdlgJeUxjNl9omReT2EM72SZBpvW8vMgzgBxPupL0jVif5fUuEmgIGN6k1ZiXSVYlZJYO9Y5UjHQC8HTItx+VOLmC4aXeZuxbiAZwm0FrOCzwLo8OyHUeShQPxD/CrtlEFAuz9RjUc2kxOeB4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR04MB9849.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(10070799003)(7416014)(376014)(366016)(1800799024)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGFMbTdNNys5UTRJOFZIUHVVNE5zNFBDaGYzUG8xMUxGZHE0VmxiSXRMM1Jy?=
 =?utf-8?B?cndsRVJTVXVDbFU4S2o1amNPWTd3cmdKcW9sQzlmTzZHYXZiKzlaNGo4RWx1?=
 =?utf-8?B?T3ljNldaNUhKdUpyTllBeUsrSzJ1Q1M2dWk2aEdqWlBjTEgwbGNVNDVic0V2?=
 =?utf-8?B?VSs3MWxpais4bytSZlpjbS9pcERGaTl6Rm9iNWJGc2NhMEx5UlJMQVFvTG1m?=
 =?utf-8?B?WjBlZjNsc0djaEJDcUlSZDNjOHpNMFlPZ2VTN0djOEY3S3F3TlFpS3VoNGRy?=
 =?utf-8?B?UC9wVC9PUVRzUkpJVHJuOUVmVGw4MDdTRzRCQzkxcVRldFRYZzJYbE5KdkVs?=
 =?utf-8?B?NHRqMFRIQkJzcy9BdXMyZ2duZm5lWFJOanNpSFRpT0JJUEQ5eTh1UEZoRUI0?=
 =?utf-8?B?QnZDKzVlclBiSUIrN1U4ZjUwZmRoRUR3V3JwRmpPQ2xzVUs1QkRtdWM5dnc1?=
 =?utf-8?B?TTI5dlQ0eCsvZk1Xa05kVndOU0RjeE9BV20rbnR2MmVjRnFZbFlxMlVmMHlN?=
 =?utf-8?B?MVh4R2NxYVFEb25RODFtaEJpdVdKeDNmcnJhR01CLzBUNGJLNlo3bTdIcTll?=
 =?utf-8?B?eC9GckpoQ0VHQThCaXdvdEhDbVlRa0puby8vOC9kNE5vRUx0Und6ZnUyR2w0?=
 =?utf-8?B?dVRia2ZaeFF4ekZtcm1Mc1dWS1lsSnhnUnlieGZQS2hNc3ZZc1hsVmR0UGZp?=
 =?utf-8?B?THNQVFBKOFRuK0JORGFLODR5YWFBSVZLZzZjRDRHcUFiZzR6L0J4L3V5Wno2?=
 =?utf-8?B?RHZCcTM0ZjdSYkxWWllzNUxwbWg0eDhpQ3lEV0FZdHh2UFdIaU81eCtXaHhX?=
 =?utf-8?B?TTFyOHpXazFUVGRjMDdocEtFdEFXRUFuTDBsbnNQOWR1L1lCZGlZcnZ0bTRy?=
 =?utf-8?B?OTNvNUlUQ1hlY0dkYkNaWmYzN05abzJMaWFQTlFaTVpwU0o5Z0F1bzdrYzFH?=
 =?utf-8?B?N2F2c295dzNxY2tKWEY1MVRCcjN1elZVcWhsOTFqOUhLUXpWU2oyeWkveXRk?=
 =?utf-8?B?YW8xRnYxR0kvekhtcStRdmMzNHBUdE1qeEQzQmlDdlRUR0hMQkRkZ1FSank2?=
 =?utf-8?B?cDZRSzM1cU5OVUxvU01GTGxqUVJJQUZoS2hlU09YU0kzZGIzMVlod2llVkxO?=
 =?utf-8?B?dzlqczNVZWtFS3BrUFczV1J2M1orekJwOUNhUGhCRCsyeEwwTXdJMGhucGNy?=
 =?utf-8?B?NkJHc2F2ZFdWOVA2Vnh4NlRrMUxpS25lRi91SmdVdmYwUXhIZjB4eVpKa1Fj?=
 =?utf-8?B?bFhEUytuSVpMaDJnRnowcGsxcmZLT3U5OWVMRFR1YjNydFh2YnRFcGNTZDBl?=
 =?utf-8?B?MnJZRUlmaFFqT1hWei95VW1OU1JtR1ZHWjZKRjNUYlpuYytFaXNkU1p4ZU1P?=
 =?utf-8?B?Wmg1WXUyTlA4Q0NXN2xRb3YvbDJyVHV6a0hXM3dMb1plMTRENkZnbTgxcmhv?=
 =?utf-8?B?dDBrc2Jod1JEWnY1bWZlVmM5Qzl6eEM4UXR6eHIxTTlpTURZQkh6WUFFQ0h6?=
 =?utf-8?B?SVRVRmZ1dTJnK0RjWGFZSmVWbGdyVHhRcE1uN2tKYzJmTVNmdW0zcnh1TWJQ?=
 =?utf-8?B?aTBLK0Q5U3VDdHc5MVhpWk0xN0RXZnFSdk40Y3Q2RTR3SUlLVWRYbmtBZ2Y4?=
 =?utf-8?B?b0dWeUVyZTltT0xHbStOTFpaYnBhSzZTeUxpL1M4WGdMN0ZSSXdPVDhVYlBo?=
 =?utf-8?B?RzE4N0ZsemswY1BmZUtodUdob3dtQndNOG4zOFZVMEkzM0EvcW00a0JjcVR2?=
 =?utf-8?B?Mlc2MWFmRDNMRnVMZ2ZWQmRYRWpTSmFReGlkcDRBclhJbXNnREFCRExHQ1gx?=
 =?utf-8?B?L0VlQkJWenA1Wk1VRFRsZCtLRSsrR1BGVHhKNDNsVitiRU10M2tZYnBlTi9D?=
 =?utf-8?B?WjBJcTFqdDErckpGRXhra1FNT05NMWVCYTR6RDkrc0tGNzRreW1DMG9GMVAz?=
 =?utf-8?B?Qm56WjlGSGJza3FzMUlmR3hYZ3RQOXJCcGVuT2Z4TTcwYTR4VDhsaEFuVVpE?=
 =?utf-8?B?c3ZxandkeGdDU1BqRFp3MDhjalVSZWNsU3kyUjFiSWtGQ00rbnFsdE5uaWJu?=
 =?utf-8?B?Ky9IMWZ1dTZPZUpPSy9TN1BJZFlRZFZHaFBtL0IzYXBrMER6cmloWUpYbkxw?=
 =?utf-8?B?UTBLVjl2WTM1dHZndE1MODlGaDZyT3ArZVVqOUx3QWZ4YzNBSFpBSHFxSzFy?=
 =?utf-8?B?MDVySVVVbFNXL0loNlo4MUdoWW1XWHljdmVlZitvZGEzMGFpUld5YWg4TzZn?=
 =?utf-8?B?ZmtuNU9rTXJBODZmTTNxY2hRMCtLTmRGSi9UWXNMaGt4aWxJd1ZJdjJvY0wv?=
 =?utf-8?B?UFh5V0U4bEIyOEdJTlEwSEdRQkdzL0FsR2pzT215SGZUYWwycExCODRVVS8x?=
 =?utf-8?Q?vd33x3v48l6wSG4wTtNg6/6WA8+NamiPX7wF/WZPIavuI?=
x-ms-exchange-antispam-messagedata-1: EaYM9PeO3b7zuhQvMiM57V0MF2G7Hrw0zV8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31B550EAF0242C45A23A6FBF1A66AE32@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: faNxKTf4rSDLpceLcRtPYVl0Exa/mnjs0kwhDrXxK+8r8S0ux9DByPSSu8p2L8OJ/4D4qLoC1rWrV8PEOAnQDi+SUu5M18CSVyrJy6TkBurrGxaIlORjNIE0cwBUR9sCUjJzgwDk3frdtXACZMnhur3ospdhp3Zb0YPNfTF09ow22rxXHkw4qOJmEryLdmEgkrY6vfZINjtAtcM4fOCe0ZZePqnUsAC97sAFg2hkVQS9j9ddXfaJjw4RvBSxr135TeYvLxYs11KYC0dosoj0VmB2AV9EGFSE/ta8pJ91+LT7QyBg3gcNidXgv0Fy618fSwgn7nbFw1cfdMGYE2X/fuqNr6pXGl1pc3bkp0ZNneEyxJnVyHY+HqoQ6GzQKpXntehalxhnEOTgXPq6824kIPCbk84SeHyUxtFDKEQ2qzRT1qN818pR1/P2UW6rcwHsRlkaUQWZlpgEadArHE4QSz2mSSYycZYbS3B+zKnUB1d+CLQ+Ahrhonf73bao00fTA5qfPG549b9M+qzlOrcEnjCCsWm0TIjgduqNmwlPg3rtGjdivxIR5rQbjSRf8rDtsXX7efzcAHhVeYy5d40Tts8LjD1GqO5hjKtES62L2hyZPYkxHES2ajNOFPIP/4kW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB9849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da668c4-1d7a-45db-ccac-08de7593b965
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 00:04:06.3666 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ua6upHnsyf4xW071F3oEr5kG/DjSRxX8bcmc3qOCk5rloN2qKo6wKYNYNyvi+Y/5fN8Aiy1EmJffHdIiUN3LkhwvNW+wdqpFE+43ySQJ1+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8550
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=511ad3126=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_PASS=-0.001,
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

T24gVHVlLCAyMDIzLTAyLTA3IGF0IDE2OjU5ICswMTAwLCB+bGV4YmFpbGV5bG93cmlzYyB3cm90
ZToNCj4gRnJvbTogRW1tYW51ZWwgQmxvdCA8ZWJsb3RAcml2b3NpbmMuY29tPg0KDQpZb3UgbmVl
ZCB0byBhZGQgY29tbWl0IG1lc3NhZ2VzDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEVtbWFudWVs
IEJsb3QgPGVibG90QHJpdm9zaW5jLmNvbT4NCj4gDQo+IEluY2x1ZGVzIGV4aXN0aW5nIE1JVCBs
aWNlbmNlZCBjb2RlIChhbHJlYWR5IHB1Ymxpc2hlZCBlbHNld2hlcmUpDQoNClRoaXMgbmVlZHMg
dG8gYmUgYWJvdmUgdGhlIFNvQg0KDQo+IC0tLQ0KPiDCoHRhcmdldC9yaXNjdi9jcHUuY8KgwqDC
oMKgwqDCoCB8wqAgMiArLQ0KPiDCoHRhcmdldC9yaXNjdi9jcHUuaMKgwqDCoMKgwqDCoCB8wqAg
NyArKysrDQo+IMKgdGFyZ2V0L3Jpc2N2L2liZXhfY3NyLmPCoCB8IDg1DQo+ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gwqB0YXJnZXQvcmlzY3YvbWVzb24uYnVp
bGQgfMKgIDEgKw0KPiDCoDQgZmlsZXMgY2hhbmdlZCwgOTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvcmlzY3YvaWJleF9jc3IuYw0K
PiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHUuYyBiL3RhcmdldC9yaXNjdi9jcHUu
Yw0KPiBpbmRleCAyNGE0YzJmZDNmLi5kZDMwYjIxZGQyIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQv
cmlzY3YvY3B1LmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdS5jDQo+IEBAIC0zMDU2LDcgKzMw
NTYsNyBAQCBzdGF0aWMgY29uc3QgVHlwZUluZm8gcmlzY3ZfY3B1X3R5cGVfaW5mb3NbXSA9DQo+
IHsNCj4gwqDCoMKgwqDCoMKgwqDCoCAuY2ZnLmV4dF96YmEgPSB0cnVlLA0KPiDCoMKgwqDCoMKg
wqDCoMKgIC5jZmcuZXh0X3piYiA9IHRydWUsDQo+IMKgwqDCoMKgwqDCoMKgwqAgLmNmZy5leHRf
emJjID0gdHJ1ZSwNCj4gLcKgwqDCoMKgwqDCoMKgIC5jZmcuZXh0X3picyA9IHRydWUNCj4gK8Kg
wqDCoMKgwqDCoMKgIC5jZmcuZXh0X3picyA9IHRydWUsDQo+IMKgwqDCoMKgICksDQo+IMKgDQo+
IMKgwqDCoMKgIERFRklORV9SSVNDVl9DUFUoVFlQRV9SSVNDVl9DUFVfU0lGSVZFX0UzMSwNCj4g
VFlQRV9SSVNDVl9DUFVfU0lGSVZFX0UsDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvY3B1
LmggYi90YXJnZXQvcmlzY3YvY3B1LmgNCj4gaW5kZXggMzVkMWY2MzYyYy4uZmFmNTVlOGI1ZSAx
MDA2NDQNCj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L2NwdS5oDQo+ICsrKyBiL3RhcmdldC9yaXNjdi9j
cHUuaA0KPiBAQCAtNDgxLDYgKzQ4MSwxMCBAQCBzdHJ1Y3QgQ1BVQXJjaFN0YXRlIHsNCj4gwqDC
oMKgwqAgdWludDY0X3QgaHN0YXRlZW5bU01TVEFURUVOX01BWF9DT1VOVF07DQo+IMKgwqDCoMKg
IHVpbnQ2NF90IHNzdGF0ZWVuW1NNU1RBVEVFTl9NQVhfQ09VTlRdOw0KPiDCoMKgwqDCoCB1aW50
NjRfdCBoZW52Y2ZnOw0KPiArDQo+ICvCoMKgwqAgLyogSWJleCBjdXN0b20gQ1NScyAqLw0KPiAr
wqDCoMKgIHRhcmdldF91bG9uZyBjcHVjdHJsc3RzOw0KPiArwqDCoMKgIHRhcmdldF91bG9uZyBz
ZWN1cmVzZWVkOw0KDQpXZSBkb24ndCB3YW50IGN1c3RvbSBDU1JzIGhlcmUNCg0KPiDCoCNlbmRp
Zg0KPiDCoA0KPiDCoMKgwqDCoCAvKiBGaWVsZHMgZnJvbSBoZXJlIG9uIGFyZSBwcmVzZXJ2ZWQg
YWNyb3NzIENQVSByZXNldC4gKi8NCj4gQEAgLTk4OCw1ICs5OTIsOCBAQCBleHRlcm4gY29uc3Qg
UklTQ1ZDU1IgdGhfY3NyX2xpc3RbXTsNCj4gwqAvKiBJbXBsZW1lbnRlZCBpbiBtaXBzX2Nzci5j
ICovDQo+IMKgZXh0ZXJuIGNvbnN0IFJJU0NWQ1NSIG1pcHNfY3NyX2xpc3RbXTsNCj4gwqANCj4g
Ky8qIEltcGxlbWVudGVkIGluIGliZXhfY3NyLmMgKi8NCj4gK2V4dGVybiBjb25zdCBSSVNDVkNT
UiBpYmV4X2Nzcl9saXN0W107DQo+ICsNCj4gwqBjb25zdCBjaGFyICpwcml2X3NwZWNfdG9fc3Ry
KGludCBwcml2X3ZlcnNpb24pOw0KPiDCoCNlbmRpZiAvKiBSSVNDVl9DUFVfSCAqLw0KPiBkaWZm
IC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2liZXhfY3NyLmMgYi90YXJnZXQvcmlzY3YvaWJleF9jc3Iu
Yw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwLi5kNjI2MzhiYmZi
DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2liZXhfY3NyLmMNCj4gQEAg
LTAsMCArMSw4NSBAQA0KPiArLyoNCj4gKyAqIFFFTVUgTG93UmlzYyBJYmV4IGNvcmUgZmVhdHVy
ZXMNCj4gKyAqDQo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjMgUml2b3MsIEluYy4NCj4gKyAqDQo+
ICsgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogTUlUDQoNCklzIG5ldyBNSVQgY29kZSBhbGxv
d2VkIGluIFFFTVU/DQoNCkFsaXN0YWlyDQoNCj4gKyAqDQo+ICsgKi8NCj4gKw0KPiArI2luY2x1
ZGUgInFlbXUvb3NkZXAuaCINCj4gKyNpbmNsdWRlICJxZW11L2xvZy5oIg0KPiArI2luY2x1ZGUg
ImNwdS5oIg0KPiArDQo+ICsvKiBDdXN0b20gQ1NScyAqLw0KPiArI2RlZmluZSBDU1JfQ1BVQ1RS
TFNUUyAweDdjMA0KPiArI2RlZmluZSBDU1JfU0VDVVJFU0VFRCAweDdjMQ0KPiArDQo+ICsjZGVm
aW5lIENQVUNUUkxTVFNfSUNBQ0hFX0VOQUJMRcKgwqDCoMKgIDB4MDAwDQo+ICsjZGVmaW5lIENQ
VUNUUkxTVFNfREFUQV9JTkRfVElNSU5HwqDCoCAweDAwMQ0KPiArI2RlZmluZSBDUFVDVFJMU1RT
X0RVTU1ZX0lOU1RSX0VOwqDCoMKgIDB4MDAyDQo+ICsjZGVmaW5lIENQVUNUUkxTVFNfRFVNTVlf
SU5TVFJfTUFTS8KgIDB4MDM4DQo+ICsjZGVmaW5lIENQVUNUUkxTVFNfU1lOQ19FWENfU0VFTsKg
wqDCoMKgIDB4MDQwDQo+ICsjZGVmaW5lIENQVUNUUkxTVFNfRE9VQkxFX0ZBVUxUX1NFRU4gMHgw
ODANCj4gKyNkZWZpbmUgQ1BVQ1RSTFNUU19JQ19TQ1JfS0VZX1ZBTElEwqAgMHgxMDANCj4gKw0K
PiArI2lmICFkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpDQo+ICsNCj4gK3N0YXRpYyBSSVNDVkV4
Y2VwdGlvbiByZWFkX2NwdWN0cmxzdHMoQ1BVUklTQ1ZTdGF0ZSAqZW52LCBpbnQgY3Nybm8sDQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB0YXJnZXRfdWxvbmcgKnZhbCkNCj4gK3sNCj4gK8KgwqDCoCAq
dmFsID0gQ1BVQ1RSTFNUU19JQ19TQ1JfS0VZX1ZBTElEIHwgZW52LT5jcHVjdHJsc3RzOw0KPiAr
wqDCoMKgIHJldHVybiBSSVNDVl9FWENQX05PTkU7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBSSVND
VkV4Y2VwdGlvbiB3cml0ZV9jcHVjdHJsc3RzKENQVVJJU0NWU3RhdGUgKmVudiwgaW50DQo+IGNz
cm5vLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0YXJnZXRfdWxvbmcgdmFsLCB1aW50cHRyX3QN
Cj4gYSkNCj4gK3sNCj4gK8KgwqDCoCAvKiBiNyBjYW4gb25seSBiZSBjbGVhcmVkICovDQo+ICvC
oMKgwqAgZW52LT5jcHVjdHJsc3RzICY9IH4weGJmOw0KPiArwqDCoMKgIC8qIGI2IHNob3VsZCBi
ZSBjbGVhcmVkIG9uIG1yZXQgKi8NCj4gK8KgwqDCoCBlbnYtPmNwdWN0cmxzdHMgfD0gdmFsICYg
MHgzZjsNCj4gK8KgwqDCoCByZXR1cm4gUklTQ1ZfRVhDUF9OT05FOw0KPiArfQ0KPiArDQo+ICtz
dGF0aWMgUklTQ1ZFeGNlcHRpb24gcmVhZF9zZWN1cmVzZWVkKENQVVJJU0NWU3RhdGUgKmVudiwg
aW50IGNzcm5vLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGFyZ2V0X3Vsb25nICp2YWwpDQo+ICt7
DQo+ICvCoMKgwqAgLyoNCj4gK8KgwqDCoMKgICogIlNlZWQgdmFsdWVzIGFyZSBub3QgYWN0dWFs
bHkgc3RvcmVkIGluIGEgcmVnaXN0ZXIgYW5kIHNvDQo+IHJlYWRzIHRvIHRoaXMNCj4gK8KgwqDC
oMKgICogcmVnaXN0ZXIgd2lsbCBhbHdheXMgcmV0dXJuIHplcm8uIg0KPiArwqDCoMKgwqAgKi8N
Cj4gK8KgwqDCoCAqdmFsID0gMDsNCj4gK8KgwqDCoCByZXR1cm4gUklTQ1ZfRVhDUF9OT05FOw0K
PiArfQ0KPiArDQo+ICtzdGF0aWMgUklTQ1ZFeGNlcHRpb24gd3JpdGVfc2VjdXJlc2VlZChDUFVS
SVNDVlN0YXRlICplbnYsIGludA0KPiBjc3JubywNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGFy
Z2V0X3Vsb25nIHZhbCwgdWludHB0cl90DQo+IGEpDQo+ICt7DQo+ICvCoMKgwqAgKHZvaWQpdmFs
Ow0KPiArwqDCoMKgIHJldHVybiBSSVNDVl9FWENQX05PTkU7DQo+ICt9DQo+ICsNCj4gK3N0YXRp
YyBSSVNDVkV4Y2VwdGlvbiBhbnkoQ1BVUklTQ1ZTdGF0ZSAqZW52LCBpbnQgY3Nybm8pDQo+ICt7
DQo+ICvCoMKgwqAgLyoNCj4gK8KgwqDCoMKgICrCoCB1bmZvcnR1bmF0ZWx5LCB0aGlzIHByZWRp
Y2F0ZSBpcyBub3QgcHVibGljLCBzbyBkdXBsaWNhdGUNCj4gdGhlIHN0YW5kYXJkDQo+ICvCoMKg
wqDCoCAqwqAgaW1wbGVtZW50YXRpb24NCj4gK8KgwqDCoMKgICovDQo+ICvCoMKgwqAgcmV0dXJu
IFJJU0NWX0VYQ1BfTk9ORTsNCj4gK30NCj4gKw0KPiArY29uc3QgUklTQ1ZDU1IgaWJleF9jc3Jf
bGlzdFtdID0gew0KPiArwqDCoMKgIHsNCj4gK8KgwqDCoMKgwqDCoMKgIC5jc3JubyA9IENTUl9D
UFVDVFJMU1RTLA0KPiArwqDCoMKgwqDCoMKgwqAgLmNzcl9vcHMgPSB7ICJjcHVjdHJsc3RzIiwg
YW55LCAmcmVhZF9jcHVjdHJsc3RzLA0KPiAmd3JpdGVfY3B1Y3RybHN0cyB9LA0KPiArwqDCoMKg
IH0sDQo+ICvCoMKgwqAgew0KPiArwqDCoMKgwqDCoMKgwqAgLmNzcm5vID0gQ1NSX1NFQ1VSRVNF
RUQsDQo+ICvCoMKgwqDCoMKgwqDCoCAuY3NyX29wcyA9IHsgInNlY3VyZXNlZWQiLCBhbnksICZy
ZWFkX3NlY3VyZXNlZWQsDQo+ICZ3cml0ZV9zZWN1cmVzZWVkIH0sDQo+ICvCoMKgwqAgfSwNCj4g
K8KgwqDCoCB7fQ0KPiArfTsNCj4gKw0KPiArI2VuZGlmIC8qICFkZWZpbmVkKENPTkZJR19VU0VS
X09OTFkpICovDQo+ICsNCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9tZXNvbi5idWlsZCBi
L3RhcmdldC9yaXNjdi9tZXNvbi5idWlsZA0KPiBpbmRleCAzODQyYzdjMWE4Li41YTE3NGE2ZmVi
IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvbWVzb24uYnVpbGQNCj4gKysrIGIvdGFyZ2V0
L3Jpc2N2L21lc29uLmJ1aWxkDQo+IEBAIC0xNyw2ICsxNyw3IEBAIHJpc2N2X3NzLmFkZChmaWxl
cygNCj4gwqDCoCAnY3B1LmMnLA0KPiDCoMKgICdjcHVfaGVscGVyLmMnLA0KPiDCoMKgICdjc3Iu
YycsDQo+ICvCoCAnaWJleF9jc3IuYycsDQo+IMKgwqAgJ2ZwdV9oZWxwZXIuYycsDQo+IMKgwqAg
J2dkYnN0dWIuYycsDQo+IMKgwqAgJ29wX2hlbHBlci5jJywNCg==

