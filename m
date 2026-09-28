Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAD1CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 03:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB22I-0001pW-Ei; Sun, 27 Sep 2026 23:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB22F-0001ot-D8
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 23:28:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB22D-0004zt-9h
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 23:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790566094; x=1822102094;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=HsRt/vA9t0dplBkhcfdUgWIdO+tpVdKwFhT1bfTxhcQ=;
 b=qQPuezpjqzDS5qtdAJEtuVw3exhMDRSb/OGoQq/WnATALPJ9/nJZIhb2
 l73+G6iAX2mdKhYg9t+Nms0zlFAcia7Y8Ae9s9pxYICciMjabdJFieIMd
 ymkR3xdAfblHvCTlxbDOjiNlwLEPo5NdjX3iGvpwgfBINkWQme9vodtUD
 FS2zflsl8I38zhCpZdg0T4+eOoi09et3ftVmEImB6q/npPEIInBzWi7fg
 L4QUZHPS7k0uzTQIQU1ANdl8x31iRiaNVaUW8KAZXEcDJGfpQOqRKk7/p
 STrCHvlbGPFhuKifCjmw4VXsSG29ya3gTwi9X4klzjFgeE27f9iZ1ypkF A==;
X-CSE-ConnectionGUID: pUqsHGynTAGKYHFXeJyM9Q==
X-CSE-MsgGUID: Y4FviTCWTH+pSEyqLgk1zg==
X-IronPort-AV: E=Sophos;i="6.27,127,1786982400"; d="scan'208";a="152491638"
Received: from mail-eastus2azon11011042.outbound.protection.outlook.com (HELO
 BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.42])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Sep 2026 11:28:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPfzUQKf3hWUfnYYb37JQre32N1gULy5gdLskHwOJl+/deqSVKxuNHShtNE6Azdjqb1l17iSAIj53R+mk2ITnWE1IO2N4WoAY4ITgAKh/0cxcA9ovARYdSgQx3C8quwdtJGKQpsX/x7fqNAYfXx6Lg7fJ4Adv982YJeeKewdRy3nIpb+zqlQL99sXZ3ms7L6vPq1oJlHMarrJ/uUmvEp6Dk9FjSJ97MyiTql49lf8hLQu0i7/pE4qIHyE21r9ibPHnO1Jb4Lav1pmP+aFYhjbQ5tpHts5NCPBSnt7vaHPown/J4Kd+5n9tg//G0VutniTwKxmcOp6JlSjuoNhkTDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsRt/vA9t0dplBkhcfdUgWIdO+tpVdKwFhT1bfTxhcQ=;
 b=vjk9arB01lYUKINZYrNPyswyrYW/ah/QS2dkAj3+hym0zfOdvz5tGlqNMOr9RSo+z/usXau09MHeBYVCgloWXyJQymJ2/aUOqrL/OPB6AO23GBFD5yuRQauSPVPpSIX+FAZU5LdseHV1EK2Lv9YMBLdkush4DaLAL+siy3rKKEIEbKtycH7XzySPf1WYeL069ptzBQesPANrOjL0ifUbzDJzKiACgbm/hMA4EmdTYhyURYvohUc9HMQmcFeFI2Kf1qkeYObb12C3KkhW+Gp8jUKcUlRpO/RHjDoJNFw1CPo42laxhu/koyUdRwoAedG+I59ExbqA+UPv1QPCd9xobQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsRt/vA9t0dplBkhcfdUgWIdO+tpVdKwFhT1bfTxhcQ=;
 b=rDJhxZPkGGi+vujI6hCg6+w8bT+ICrAetxux+A3lRUV3SKzG5O/hu3qRdRdTJ4HzAG28+RRy4hfYydPI6Fcs9Q0Ue8NeN5tcO+VED7rXGqGZ2Ua5o3zO92tOxcX0xD9FNu2AD+spONWvtMrS0ZdaoVB+lbVh5m7qsfY8pavMHv0=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by MN2PR04MB6366.namprd04.prod.outlook.com (2603:10b6:208:1ac::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 03:28:04 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 03:28:03 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "max.chou@sifive.com" <max.chou@sifive.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v3 01/11] tcg/riscv64: Return tcg_insn_unit from insn
 encoders
Thread-Topic: [PATCH v3 01/11] tcg/riscv64: Return tcg_insn_unit from insn
 encoders
Thread-Index: AQHdQ90p73US2yqqUEOmgsMUZYYkbrbjawEA
Date: Mon, 28 Sep 2026 03:28:03 +0000
Message-ID: <44b5d4ec60a533348c5e775ad0b6ef38d232c907.camel@wdc.com>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
 <20260914000814.785155-2-richard.henderson@linaro.org>
In-Reply-To: <20260914000814.785155-2-richard.henderson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|MN2PR04MB6366:EE_
x-ms-office365-filtering-correlation-id: 8de8cafc-c728-4ac3-f6ef-08df1d108134
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|23010399003|10070799003|38070700021|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: MbDXOtL5KNF3o475lhACfCbdJ0+ryxO56lDBxUTc0I7SMDRjUKo9hyqDrS2FuZ2YS2ClyC92ABxmqi4ulP8R6JFKlSMYoChyn/Pl0BV/qKLWVnbrHz74ASCh924hXwRMptXj04RunjnItvZ0S7TjA7jz6aKC1Y9IKQrzkcg3ilAklktPVQ8zXZD+ycVub7rc5dLn30r0jZBrqelvFQ5Z2FmPSJOOi/iXjfCRpzPpAUh2ZYMnxpD3SqBNmLkBnx1FdF/SGJMh7ODfMvuDP0TJHZvmSCB1kvbQ/UwXqYKx8+s8E7LAfV9idw7dtwZhwrqkfyTvGGZ8BDR3qjPKidaGkyaGze69a+9g2+vo6WxmplaTB488byZf+3EOtUviJ69KcAox3KzplDF78ip+W5GF7BrjyV47to+1eRqsjxNQRTghHJ73IxkHBc9CiYgv39cCtaEQym6vBwqlmgE0C9AOTMk3xkVoctjWmLt5wB1i7oeKzrMVU7wzwjnzwcSG596aSwFkUrcZ9kx3EfACVzXv9vpdmQybQ6HcfVVg/Hho3DgU5ZfxPO8unEf1RLhOkE34zffFaJaRKeHG1hVNmzCitAAFZmxQYvs9HLwSK0TIS2eNz6P8OrZAgh0ZumNZILWAdOHv3nV+F0GuAFo2L5k/akaO4pXEV7S4EA4rwsMtuEnrMdXLkgNM/didJi+gSZTfBTib3P+wQhjavFw3Q4KLe/KjjEw2gZQttqmwJy/VroU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(23010399003)(10070799003)(38070700021)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVl2Y3U4ODloeEI4cktjL2dJVks0YVdoM3A3NmxaRXFkRHVGSmlLWHRWNFJH?=
 =?utf-8?B?NnBRaFFWK1grb2plL2lOaTRPclpzN1p2UFgvMXNzN2xwdE1YNEhjWlpPK20v?=
 =?utf-8?B?dTVJRFhjektnRStHVExFc1BoUUx2RC80aTBNNlViSW1UamJQbGR5TGgyanZ5?=
 =?utf-8?B?V1dYQUVBalpNQ0lNMEk0bXJKMndPMHhaR0xBZldldEpQZnVHa21zM2JoNytU?=
 =?utf-8?B?NzZSNmxiakNnWFFRSjZIcFhFSWpDNXdNbHZZVFJLaDg1OTZobU1vUktDcDhB?=
 =?utf-8?B?eGZMNGoxaHBWdGc1ZGp6RzFHNUNDL0tZWGpNWjRPRUtBKzNUdzk1aW5lSDU3?=
 =?utf-8?B?QlNYNnJYdkprS0FocllPMzVHbDRpKzRWTW02bGFZVGt2WERMeUhzUDZRVGt4?=
 =?utf-8?B?YkVIa1Ava2lEUEhHYW5BUGdZZ0xndjMwVGhWdFM0bUozc3dqM1NBcXFQR0xY?=
 =?utf-8?B?MTh2L0IxVXoramNDY0JCclBlUEJhZzVNb1lOODJLeHVScGRsMTMwYkwrTUV0?=
 =?utf-8?B?alA0aUdxcXRNRVU5TU1iVWpyVzRVRi9lVnJvQ21ZZjI0RzdLOXkzbzFub3lB?=
 =?utf-8?B?NzBJUGswOStqUjhLQmp4c0h6N3gzTFd3OG02TGNNdC85WDNBcFEyM3JCS3N5?=
 =?utf-8?B?ZzMzcmlpRldoYUJJOEJBZTBmVU1scE5lcGlMdUt3NHJBWDUrc1hydXZUemJ6?=
 =?utf-8?B?d2hZb3QxUDlwbXFoNnY2S1Niek5ZTWt1bWZsN284Um8xa3g1V1BqVWpLZUQ2?=
 =?utf-8?B?S2NUc0RXUlIvTGtFYVBDVVZHQ3FNR3p0U1g0NHE1TFBQaUdDaU5ua0R5c25a?=
 =?utf-8?B?SUpRK3JidGtHQU96WGRJMTh2K0l2TldQMDhVdHZSR1M4c05RV2o3THNYZDJ1?=
 =?utf-8?B?ZWhwOERpSHlSSmZsUzRIWjZIUUo0RDNTNzJOTzErUU1YN2YwcFk2MzIwZkJD?=
 =?utf-8?B?TXVKbmZSd205emdKZCswbmorZjZiS05GanpERHVCOHdwbUtUcFE0Yk5rR2RJ?=
 =?utf-8?B?UTBhV0pXa0E4Qk90T1pycjNTSVBRZTJRUW9WNlAvNGh4a1QrNTd3b05hT1l2?=
 =?utf-8?B?dzUzbUNxMDRlN0pOUklUd3QxblFHVWg0MjE4MVIxWmZYT0d6Q0ttNnlQRnpJ?=
 =?utf-8?B?WHo3UThPUi9GNzYrT2d4UGpobnR4K2lQMFliZFJpaWtjbjl6Ry8xeS94aWFB?=
 =?utf-8?B?U3plSmZ5RG9FNXJKQ3hQVzNZeXJIRlkrQ1haYlNPV3lIcm9WSlFZcnVyQjV4?=
 =?utf-8?B?WjhwWk5CRVVuR3JoQkc4NldCT0xNeUtOOWFUYVA3RzB2RUNWemJaWUxubWxt?=
 =?utf-8?B?Um1TamtpME1CZkVPNUVCMVE1SzJvU3NtcExPWE91VTBuT0p4SzBLZnNzYnJs?=
 =?utf-8?B?aUg4QUphMHIyVUg2NUtXenZXUnJDVGpJTHk5SVdaalNhK0N2OU9qN1NsNjR5?=
 =?utf-8?B?eS9kR0tkc0p4WTNvaFROWnVDcFdmaDRqL1JscGYrdkY2dk9FK3NXK001V1FB?=
 =?utf-8?B?UjBlMjNxd1VHWEhMQU4vZ2F6S3VlN1NVTUJFNkhTUWpvOUNFV0twK2Z5cWMx?=
 =?utf-8?B?N3hTWnY3WVBCQnNpeFVSMVZXNm9GMWFsbXJETzlrTWhXWHhmUEljZnFhRTdx?=
 =?utf-8?B?c0NCT3FVTEFOMmVNZ3BhRHllbzBycWxsbGNmUUxrZ1M3QlZpN3owMmJvalZq?=
 =?utf-8?B?RmFOVW1lcm9IRXVPNzlHRmZyczZaNldicG5PQmVIL29SazlORXE0aHlBSXNm?=
 =?utf-8?B?aVYrdllNMmV3TWdoWnFCYWRpQzR1WGRhWHdlWDVaU1RlMHFoRURNbTAza1Rx?=
 =?utf-8?B?VVBMakVQY0hhYldDK084UEJHaWRIWEl1cXQrR0Q4ZWRPcnBSSmkyU2thMUM0?=
 =?utf-8?B?SkNqZWd1b0owWmdaTlJxeDFrZDUxUk4vaWo1Lzl1MDFYOENEOGRNUmZIZWha?=
 =?utf-8?B?ZTNNWjZXZ2RnNzFHQ05HZElTWWQ4V1dueFdVbU1meExiTy9HZTNURDJndFla?=
 =?utf-8?B?b3FSRDBWOXhmVExLWkRYcGowZU1mZ2dBbkljZmo5eWV6aHZHeXhEaE4wL1do?=
 =?utf-8?B?NHBISTlITnVhK05IdFZqYm5zVllqVDJCeG42VisrOXpQd2NxUExDVEkxelo2?=
 =?utf-8?B?YVpkSzNtcFc0Y2xtalhaYmVwOXA1MFoyWU03QkZLRHkrVUZKMnVKTm5CR1cx?=
 =?utf-8?B?aWhmTkxsakk2eXprVVpEeUVrd2ZlRjlLNHpNb0ZielpDYzQ4ME16TkpESm5v?=
 =?utf-8?B?VTFqY0FjR0Z6MHFFWUNzblkyVXhpS2VzSG5XaDlSNFkyUmRnYWt0aXFMUUV4?=
 =?utf-8?B?NzQ3STBldEQ3UG1kTWtsQU9xK3VrY3VuRFVXMjJGd3ZDMzd3OStOYTFYQVM0?=
 =?utf-8?Q?YnVQy+LjgTFAqJRkqYQCzx+t35gF7YGuYMn1K0jvLAaFx?=
x-ms-exchange-antispam-messagedata-1: RVH+t04VNdYWql4mEFCuMMMnSDHrl/YPJVs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1623066DB072844394D0D4842D0F2CDA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3ebhaYFG4bcxUWWcCmEgXl/l/4wUd5fsTkSsjLDvci01cDit72JDP7XUTqcwHX4xt1I6/c+/x3KPER9Te8rsJBqR8WBQib96yQbloXC3+YceJ5TXccToG/8aGosP9Qe2sNn0VL8XIQ9FYuqrDMV5T2gk929gEc347mU5T7f3naI0bq100nlREJkUEaYPnY/L47u3Uwh7QEwT1VEIacHKtlivEpVPMnreEXkJxLHHl9G05B2/cEKViImfdWYQHoXBv5ykJOGkgYA8M3WxokXb3BiqvuUqPqd/ko9zm1aCUhN7sad4XzQ5Y+TlSkDczBE9+68MrD1wsqQalZeDWQBhKg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WfmE1AR8gpqoQD7JnIZoBFxUqHO15bQr+Hc/2ePFvhb70DaaRWsR+9SiUnRoahpyrfiQNs5PPyCC4zZ99/hZGxeRQpu1ZUoI1eLzOiB8dZ1ElOwgDhG5SIbiwEtjMUeAh4jHYlAkR59q7d07Owu/ePvkgziQ5ZpvZHLgPCPFLz8KWrTXcjBd3Y+FoJ1Odl+vP6kL48/HtL7VCmDYFk6QPhpX+2nuLE/4kaNrm2J+C0gwI6i5EMSlcTDnYCJlKc9OFwMeX1wkn0TeiqK4X6QfWERWjsXYbcZEBt6DeELQEBsTggG8x83aNJa9m7Xc/EWLuwvO7Tq7xNJTWUtJFHC3g36y1b4zd9hMmHsT/C72k91vMS79c1V1OCYnL2kgmt91LIBHYw5dIS3uxImOIEFv1LtqvRQYLrJlcChBQ+Ln+xYZaHiHZwIUOuVPKu+GE39m9NeasKO8obYGTirc+CtlIJevpmfDHgH2gsfQVXSPsj8owiUB4TYH9VOIwyQdtYpsPpvGvCIvy6qMnfmxkk+d3tD5avYDnztptSR6WwQG2EtbSJkJnHbAoTxbqAdqDp+sJhTI4chSd1hmIQvPfdCKW3UIpYB+iPOH4TUxeoLQRke0z7KlUqWc5RSwDUO2MDSD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de8cafc-c728-4ac3-f6ef-08df1d108134
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 03:28:03.4212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GYAzO3TOM7oarMZHXVHd9/IwtqrtrjwakGxm7fHsbo/fM8Hld184IOkCvHawfsUv8c82B76qoEBm0wGOFZiYnomYmWk0N3XKiERSSJIrIJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6366
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=724888370=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

T24gU3VuLCAyMDI2LTA5LTEzIGF0IDE0OjA4IC0xMDAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToNCj4gUmV0dXJuaW5nIGludDMyX3Qgd2FzIGxvZ2ljYWxseSBpbmNvcnJlY3QuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJv
Lm9yZz4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNA
d2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gwqB0Y2cvcmlzY3Y2NC90Y2ctdGFyZ2V0
LmMuaW5jIHwgNDcgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQ0KPiAtLQ0KPiDC
oDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS90Y2cvcmlzY3Y2NC90Y2ctdGFyZ2V0LmMuaW5jIGIvdGNnL3Jpc2N2NjQv
dGNnLQ0KPiB0YXJnZXQuYy5pbmMNCj4gaW5kZXggMmNlOWQ0N2E2MzMuLmEyNjUwM2ZhMWVkIDEw
MDY0NA0KPiAtLS0gYS90Y2cvcmlzY3Y2NC90Y2ctdGFyZ2V0LmMuaW5jDQo+ICsrKyBiL3RjZy9y
aXNjdjY0L3RjZy10YXJnZXQuYy5pbmMNCj4gQEAgLTQzOCwyOCArNDM4LDI4IEBAIHN0YXRpYyBi
b29sIHRjZ190YXJnZXRfY29uc3RfbWF0Y2goaW50NjRfdCB2YWwsDQo+IGludCBjdCwNCj4gwqAN
Cj4gwqAvKiBUeXBlLVIgKi8NCj4gwqANCj4gLXN0YXRpYyBpbnQzMl90IGVuY29kZV9yKFJJU0NW
SW5zbiBvcGMsIFRDR1JlZyByZCwgVENHUmVnIHJzMSwgVENHUmVnDQo+IHJzMikNCj4gK3N0YXRp
YyB0Y2dfaW5zbl91bml0IGVuY29kZV9yKFJJU0NWSW5zbiBvcGMsIFRDR1JlZyByZCwgVENHUmVn
IHJzMSwNCj4gVENHUmVnIHJzMikNCj4gwqB7DQo+IMKgwqDCoMKgIHJldHVybiBvcGMgfCAocmQg
JiAweDFmKSA8PCA3IHwgKHJzMSAmIDB4MWYpIDw8IDE1IHwgKHJzMiAmDQo+IDB4MWYpIDw8IDIw
Ow0KPiDCoH0NCj4gwqANCj4gwqAvKiBUeXBlLUkgKi8NCj4gwqANCj4gLXN0YXRpYyBpbnQzMl90
IGVuY29kZV9pbW0xMih1aW50MzJfdCBpbW0pDQo+ICtzdGF0aWMgdGNnX2luc25fdW5pdCBlbmNv
ZGVfaW1tMTIodWludDMyX3QgaW1tKQ0KPiDCoHsNCj4gwqDCoMKgwqAgcmV0dXJuIChpbW0gJiAw
eGZmZikgPDwgMjA7DQo+IMKgfQ0KPiDCoA0KPiAtc3RhdGljIGludDMyX3QgZW5jb2RlX2koUklT
Q1ZJbnNuIG9wYywgVENHUmVnIHJkLCBUQ0dSZWcgcnMxLA0KPiB1aW50MzJfdCBpbW0pDQo+ICtz
dGF0aWMgdGNnX2luc25fdW5pdCBlbmNvZGVfaShSSVNDVkluc24gb3BjLCBUQ0dSZWcgcmQsIFRD
R1JlZyByczEsDQo+IHVpbnQzMl90IGltbSkNCj4gwqB7DQo+IMKgwqDCoMKgIHJldHVybiBvcGMg
fCAocmQgJiAweDFmKSA8PCA3IHwgKHJzMSAmIDB4MWYpIDw8IDE1IHwNCj4gZW5jb2RlX2ltbTEy
KGltbSk7DQo+IMKgfQ0KPiDCoA0KPiDCoC8qIFR5cGUtUyAqLw0KPiDCoA0KPiAtc3RhdGljIGlu
dDMyX3QgZW5jb2RlX3NpbW0xMih1aW50MzJfdCBpbW0pDQo+ICtzdGF0aWMgdGNnX2luc25fdW5p
dCBlbmNvZGVfc2ltbTEyKHVpbnQzMl90IGltbSkNCj4gwqB7DQo+IC3CoMKgwqAgaW50MzJfdCBy
ZXQgPSAwOw0KPiArwqDCoMKgIHRjZ19pbnNuX3VuaXQgcmV0ID0gMDsNCj4gwqANCj4gwqDCoMKg
wqAgcmV0IHw9IChpbW0gJiAweEZFMCkgPDwgMjA7DQo+IMKgwqDCoMKgIHJldCB8PSAoaW1tICYg
MHgxRikgPDwgNzsNCj4gQEAgLTQ2NywxNiArNDY3LDE2IEBAIHN0YXRpYyBpbnQzMl90IGVuY29k
ZV9zaW1tMTIodWludDMyX3QgaW1tKQ0KPiDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPiDCoH0NCj4g
wqANCj4gLXN0YXRpYyBpbnQzMl90IGVuY29kZV9zKFJJU0NWSW5zbiBvcGMsIFRDR1JlZyByczEs
IFRDR1JlZyByczIsDQo+IHVpbnQzMl90IGltbSkNCj4gK3N0YXRpYyB0Y2dfaW5zbl91bml0IGVu
Y29kZV9zKFJJU0NWSW5zbiBvcGMsIFRDR1JlZyByczEsIFRDR1JlZyByczIsDQo+IHVpbnQzMl90
IGltbSkNCj4gwqB7DQo+IMKgwqDCoMKgIHJldHVybiBvcGMgfCAocnMxICYgMHgxZikgPDwgMTUg
fCAocnMyICYgMHgxZikgPDwgMjAgfA0KPiBlbmNvZGVfc2ltbTEyKGltbSk7DQo+IMKgfQ0KPiDC
oA0KPiDCoC8qIFR5cGUtU0IgKi8NCj4gwqANCj4gLXN0YXRpYyBpbnQzMl90IGVuY29kZV9zYmlt
bTEyKHVpbnQzMl90IGltbSkNCj4gK3N0YXRpYyB0Y2dfaW5zbl91bml0IGVuY29kZV9zYmltbTEy
KHVpbnQzMl90IGltbSkNCj4gwqB7DQo+IC3CoMKgwqAgaW50MzJfdCByZXQgPSAwOw0KPiArwqDC
oMKgIHRjZ19pbnNuX3VuaXQgcmV0ID0gMDsNCj4gwqANCj4gwqDCoMKgwqAgcmV0IHw9IChpbW0g
JiAweDEwMDApIDw8IDE5Ow0KPiDCoMKgwqDCoCByZXQgfD0gKGltbSAmIDB4N2UwKSA8PCAyMDsN
Cj4gQEAgLTQ4NiwyOCArNDg2LDI4IEBAIHN0YXRpYyBpbnQzMl90IGVuY29kZV9zYmltbTEyKHVp
bnQzMl90IGltbSkNCj4gwqDCoMKgwqAgcmV0dXJuIHJldDsNCj4gwqB9DQo+IMKgDQo+IC1zdGF0
aWMgaW50MzJfdCBlbmNvZGVfc2IoUklTQ1ZJbnNuIG9wYywgVENHUmVnIHJzMSwgVENHUmVnIHJz
MiwNCj4gdWludDMyX3QgaW1tKQ0KPiArc3RhdGljIHRjZ19pbnNuX3VuaXQgZW5jb2RlX3NiKFJJ
U0NWSW5zbiBvcGMsIFRDR1JlZyByczEsIFRDR1JlZw0KPiByczIsIHVpbnQzMl90IGltbSkNCj4g
wqB7DQo+IMKgwqDCoMKgIHJldHVybiBvcGMgfCAocnMxICYgMHgxZikgPDwgMTUgfCAocnMyICYg
MHgxZikgPDwgMjAgfA0KPiBlbmNvZGVfc2JpbW0xMihpbW0pOw0KPiDCoH0NCj4gwqANCj4gwqAv
KiBUeXBlLVUgKi8NCj4gwqANCj4gLXN0YXRpYyBpbnQzMl90IGVuY29kZV91aW1tMjAodWludDMy
X3QgaW1tKQ0KPiArc3RhdGljIHRjZ19pbnNuX3VuaXQgZW5jb2RlX3VpbW0yMCh1aW50MzJfdCBp
bW0pDQo+IMKgew0KPiDCoMKgwqDCoCByZXR1cm4gaW1tICYgMHhmZmZmZjAwMDsNCj4gwqB9DQo+
IMKgDQo+IC1zdGF0aWMgaW50MzJfdCBlbmNvZGVfdShSSVNDVkluc24gb3BjLCBUQ0dSZWcgcmQs
IHVpbnQzMl90IGltbSkNCj4gK3N0YXRpYyB0Y2dfaW5zbl91bml0IGVuY29kZV91KFJJU0NWSW5z
biBvcGMsIFRDR1JlZyByZCwgdWludDMyX3QNCj4gaW1tKQ0KPiDCoHsNCj4gwqDCoMKgwqAgcmV0
dXJuIG9wYyB8IChyZCAmIDB4MWYpIDw8IDcgfCBlbmNvZGVfdWltbTIwKGltbSk7DQo+IMKgfQ0K
PiDCoA0KPiDCoC8qIFR5cGUtVUogKi8NCj4gwqANCj4gLXN0YXRpYyBpbnQzMl90IGVuY29kZV91
amltbTIwKHVpbnQzMl90IGltbSkNCj4gK3N0YXRpYyB0Y2dfaW5zbl91bml0IGVuY29kZV91amlt
bTIwKHVpbnQzMl90IGltbSkNCj4gwqB7DQo+IC3CoMKgwqAgaW50MzJfdCByZXQgPSAwOw0KPiAr
wqDCoMKgIHRjZ19pbnNuX3VuaXQgcmV0ID0gMDsNCj4gwqANCj4gwqDCoMKgwqAgcmV0IHw9IChp
bW0gJiAweDAwMDdmZSkgPDwgKDIxIC0gMSk7DQo+IMKgwqDCoMKgIHJldCB8PSAoaW1tICYgMHgw
MDA4MDApIDw8ICgyMCAtIDExKTsNCj4gQEAgLTUxNyw3ICs1MTcsNyBAQCBzdGF0aWMgaW50MzJf
dCBlbmNvZGVfdWppbW0yMCh1aW50MzJfdCBpbW0pDQo+IMKgwqDCoMKgIHJldHVybiByZXQ7DQo+
IMKgfQ0KPiDCoA0KPiAtc3RhdGljIGludDMyX3QgZW5jb2RlX3VqKFJJU0NWSW5zbiBvcGMsIFRD
R1JlZyByZCwgdWludDMyX3QgaW1tKQ0KPiArc3RhdGljIHRjZ19pbnNuX3VuaXQgZW5jb2RlX3Vq
KFJJU0NWSW5zbiBvcGMsIFRDR1JlZyByZCwgdWludDMyX3QNCj4gaW1tKQ0KPiDCoHsNCj4gwqDC
oMKgwqAgcmV0dXJuIG9wYyB8IChyZCAmIDB4MWYpIDw8IDcgfCBlbmNvZGVfdWppbW0yMChpbW0p
Ow0KPiDCoH0NCj4gQEAgLTUyNSw4ICs1MjUsOCBAQCBzdGF0aWMgaW50MzJfdCBlbmNvZGVfdWoo
UklTQ1ZJbnNuIG9wYywgVENHUmVnDQo+IHJkLCB1aW50MzJfdCBpbW0pDQo+IMKgDQo+IMKgLyog
VHlwZS1PUElWSSAqLw0KPiDCoA0KPiAtc3RhdGljIGludDMyX3QgZW5jb2RlX3ZpKFJJU0NWSW5z
biBvcGMsIFRDR1JlZyByZCwgaW50MzJfdCBpbW0sDQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVENHUmVnIHZzMiwgYm9vbCB2bSkNCj4gK3N0YXRp
YyB0Y2dfaW5zbl91bml0IGVuY29kZV92aShSSVNDVkluc24gb3BjLCBUQ0dSZWcgcmQsIGludDMy
X3QNCj4gaW1tLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFRDR1JlZyB2czIsIGJvb2wgdm0pDQo+IMKgew0KPiDCoMKgwqDC
oCByZXR1cm4gb3BjIHwgKHJkICYgMHgxZikgPDwgNyB8IChpbW0gJiAweDFmKSA8PCAxNSB8DQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHZzMiAmIDB4MWYpIDw8IDIwIHwgKHZtIDw8IDI1KTsN
Cj4gQEAgLTUzNCw4ICs1MzQsOCBAQCBzdGF0aWMgaW50MzJfdCBlbmNvZGVfdmkoUklTQ1ZJbnNu
IG9wYywgVENHUmVnDQo+IHJkLCBpbnQzMl90IGltbSwNCj4gwqANCj4gwqAvKiBUeXBlLU9QSVZW
L09QTVZWL09QSVZYL09QTVZYLCBWZWN0b3IgbG9hZCBhbmQgc3RvcmUgKi8NCj4gwqANCj4gLXN0
YXRpYyBpbnQzMl90IGVuY29kZV92KFJJU0NWSW5zbiBvcGMsIFRDR1JlZyBkLCBUQ0dSZWcgczEs
DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRDR1Jl
ZyBzMiwgYm9vbCB2bSkNCj4gK3N0YXRpYyB0Y2dfaW5zbl91bml0IGVuY29kZV92KFJJU0NWSW5z
biBvcGMsIFRDR1JlZyBkLCBUQ0dSZWcgczEsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFRDR1JlZyBzMiwgYm9vbCB2bSkNCj4g
wqB7DQo+IMKgwqDCoMKgIHJldHVybiBvcGMgfCAoZCAmIDB4MWYpIDw8IDcgfCAoczEgJiAweDFm
KSA8PCAxNSB8DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHMyICYgMHgxZikgPDwgMjAgfCAo
dm0gPDwgMjUpOw0KPiBAQCAtNTQzLDIwICs1NDMsMTkgQEAgc3RhdGljIGludDMyX3QgZW5jb2Rl
X3YoUklTQ1ZJbnNuIG9wYywgVENHUmVnDQo+IGQsIFRDR1JlZyBzMSwNCj4gwqANCj4gwqAvKiBW
ZWN0b3IgdnR5cGUgKi8NCj4gwqANCj4gLXN0YXRpYyB1aW50MzJfdCBlbmNvZGVfdnR5cGUoYm9v
bCB2dGEsIGJvb2wgdm1hLA0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIE1lbU9wIHZzZXcsIFJJU0NWVmxtdWwgdmxtdWwpDQo+ICtzdGF0
aWMgdWludDMyX3QgZW5jb2RlX3Z0eXBlKGJvb2wgdnRhLCBib29sIHZtYSwgTWVtT3AgdnNldywN
Cj4gUklTQ1ZWbG11bCB2bG11bCkNCj4gwqB7DQo+IMKgwqDCoMKgIHJldHVybiB2bWEgPDwgNyB8
IHZ0YSA8PCA2IHwgdnNldyA8PCAzIHwgdmxtdWw7DQo+IMKgfQ0KPiDCoA0KPiAtc3RhdGljIGlu
dDMyX3QgZW5jb2RlX3ZzZXQoUklTQ1ZJbnNuIG9wYywgVENHUmVnIHJkLA0KPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUQ0dBcmcgcnMxLCB1
aW50MzJfdCB2dHlwZSkNCj4gK3N0YXRpYyB0Y2dfaW5zbl91bml0IGVuY29kZV92c2V0KFJJU0NW
SW5zbiBvcGMsIFRDR1JlZyByZCwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVENHQXJnIHJzMSwgdWludDMyX3QgdnR5
cGUpDQo+IMKgew0KPiDCoMKgwqDCoCByZXR1cm4gb3BjIHwgKHJkICYgMHgxZikgPDwgNyB8IChy
czEgJiAweDFmKSA8PCAxNSB8ICh2dHlwZSAmDQo+IDB4N2ZmKSA8PCAyMDsNCj4gwqB9DQo+IMKg
DQo+IC1zdGF0aWMgaW50MzJfdCBlbmNvZGVfdnNldGkoUklTQ1ZJbnNuIG9wYywgVENHUmVnIHJk
LA0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHVpbnQzMl90IHVpbW0sIHVpbnQzMl90IHZ0eXBlKQ0KPiArc3RhdGljIHRjZ19pbnNuX3Vu
aXQgZW5jb2RlX3ZzZXRpKFJJU0NWSW5zbiBvcGMsIFRDR1JlZyByZCwNCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1
aW50MzJfdCB1aW1tLCB1aW50MzJfdCB2dHlwZSkNCj4gwqB7DQo+IMKgwqDCoMKgIHJldHVybiBv
cGMgfCAocmQgJiAweDFmKSA8PCA3IHwgKHVpbW0gJiAweDFmKSA8PCAxNSB8ICh2dHlwZSAmDQo+
IDB4M2ZmKSA8PCAyMDsNCj4gwqB9DQo=

