Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616CEFD9E25
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 23:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvl6t-00060k-Mz; Thu, 26 Feb 2026 18:49:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=510b84ec3=Alistair.Francis@wdc.com>)
 id 1vvl6s-00060W-88; Thu, 26 Feb 2026 18:49:34 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=510b84ec3=Alistair.Francis@wdc.com>)
 id 1vvl6q-0001XY-A4; Thu, 26 Feb 2026 18:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1772149772; x=1803685772;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=2Pjmc1/SeQEo/OsrQrVwVzjLqQ9wcfYwwwA4b2FS1Bg=;
 b=Wm1g1J/+090ryQh66kY0JecDmbFEULZHeBcWnGJaPIPcOF9pWFbq7P6M
 KFEQiq+v6SXG6WxZizsdhL6vaNKwqbU8zD3y9oNrzuxnCZT5/usFzepuc
 o/PYiDP9lyixInhzMzf53W6Yp+RNe5zJGRgNGh7RxKSWzT9QREbDySCvn
 W9EG8RQj22T4QgMUBC040181wcY7dpts/EdUkfHxgHIADUNlN9fuO/XzK
 eeatHSmXSS/3639ixzpeUdhRjbrBWjQkvloX5diB9cBoqlm3ZdG00Ahzn
 XSuKluq2mCKFM1uO64C+XN2/lFQuXAQHSi+ZeP33oMvszbfER15N/EM+g g==;
X-CSE-ConnectionGUID: xR4Q/ur3RlqVUA/2RmJgZw==
X-CSE-MsgGUID: sfTvcFfOS46kPlFJqSWKtA==
X-IronPort-AV: E=Sophos;i="6.21,313,1763395200"; d="scan'208";a="137957384"
Received: from mail-southcentralusazon11012046.outbound.protection.outlook.com
 (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.46])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Feb 2026 07:49:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8+1cpya6Gc643bzPIkdk/sjABJ58vch4ARTjXrXCjINSpm7t9dgQ24cKiYeo2Z5KP2RbJ/N5A/vHG37wGUQfVEChnWPL+JkRKe/VdmV9pnWMT0Uz99lnFIKoknBUiQC7u9I70Fgc6HgG+WUhdipemITeqaFiYhIjznBQxsSFZrxTqS+BmCYCWcF2Hn7/T1DFlxElMW6ZWTHb7FF6fdsT9CuEFsQUcZDCxnVX1uvt6x1EGlj3PpmNuKWWbRA2ah6/TTsoFqcm1/g3wyLek71r+wXexjblRfETD8jp7s+VEv83ayStssREwzu6onOqRjZ3AwLacNRKM7VgHzP253Irw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Pjmc1/SeQEo/OsrQrVwVzjLqQ9wcfYwwwA4b2FS1Bg=;
 b=t/NfpqVTGjuFyLJ56HsS1v/jezoGc/E2t4hSc1S9VF0LskwKPb9js1lOK8Etw3q69g619UMVYtgSOoqg+4G9M5Ansx3gYUtooSX9W2vbcgv+AAy/oOR2np+DUrOCyAi4Ztbh+coNbX4rfiB/+kN1MUcFQg6KzU0xjFWBAfB4KlYiAYApbOpLOQQ9U9bMJAQ8byW4so9eMq7+Se3aRuG+/CFe5YkEKrvX4+rs0BWP0xORhpTfcLD4S5b3EC4heptU7BvsVQBc03i4xaMhABmkkA1y35sSlA2VLV2XhKEJo0jchaUueGC4rTz5y8EkkQDMQbQ05UnMHpDLoiaeXF130w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Pjmc1/SeQEo/OsrQrVwVzjLqQ9wcfYwwwA4b2FS1Bg=;
 b=ZFlJpGsBU0tbaE1I5V5jK0xb+aDKGeGiU7iTSB8z3fzFADq/5XQHydcX3SJS6Gvd57kKYzHSy7ftOoFhl6E4THYOK8ykfYk5WTn+VLvK7IckRKR4cs9sd+AgLnk7jq57oe00KgNI26+K5aiNT2SYDr31LECySaFyzfKT1CW8zJs=
Received: from SA1PR04MB9849.namprd04.prod.outlook.com (2603:10b6:806:4a3::15)
 by CH2PR04MB6997.namprd04.prod.outlook.com (2603:10b6:610:9d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 23:49:26 +0000
Received: from SA1PR04MB9849.namprd04.prod.outlook.com
 ([fe80::705f:2ac8:b2ff:f845]) by SA1PR04MB9849.namprd04.prod.outlook.com
 ([fe80::705f:2ac8:b2ff:f845%7]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 23:49:26 +0000
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
Subject: Re: [PATCH qemu 02/11] [ot] hw/char, hw/timer, hw/ssi: fix device
 definitions
Thread-Topic: [PATCH qemu 02/11] [ot] hw/char, hw/timer, hw/ssi: fix device
 definitions
Thread-Index: AQHconoJ81X4IOC6kEybIHl4p24Xs7WVsB+A
Date: Thu, 26 Feb 2026 23:49:26 +0000
Message-ID: <bc9ac78dbd90d68e087f89d2fc7b4370033894ec.camel@wdc.com>
References: <177159976712.8279.7732381632410882915-2@git.sr.ht>
In-Reply-To: <177159976712.8279.7732381632410882915-2@git.sr.ht>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.58.3 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR04MB9849:EE_|CH2PR04MB6997:EE_
x-ms-office365-filtering-correlation-id: 0e444796-18e5-4936-6a99-08de7591acf3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|7416014|10070799003|376014|366016|38070700021;
x-microsoft-antispam-message-info: uRAATjEiiPOOPQfVVYnGio+X0/HHPrb8iGUNuzDkKZIKlxpb3uU4rEkjFwPi12XqeQzRRrUXXfGU/jT4W5Bfzn8A9TESOKNNgJ+5M1QTEnVNiVO7VfEvY6SPeI+NzSwVcXBrYMWfEUSjZ/das3YE+r87t8U2r+Vy22JAKm4KzmEi2OP2krNxxdMzYyRnocR9IGyUPZdf0V4WakXqJ8J+8gbD4pngLfuC+WMUGmQ9n8Fh8oJJdodEnEzeCEvLVxjOk/KiFg/ACytXNlaYb/7odU5TUI0Afp8Rjvzk7/dIrPNX41IbAwi972OSarYOiLfjpnFG8yEd3AZSGuh6/lbvAWrVZm249GMWF14G3F0DdQuEb8n94z5gn39j6j4aiPPTm+fjrtOLMECfOlbcKWZAAKlnRbc5lQARhSb+5yRQAfYLEvBp9FcijTPLWdM4nkLsgTMvewUGpHtYzLyR62+o1tGIseJMRVXOJ95DvW54k/TKe9+VjQt3K8LwG8Mi2gpeK0kSz/eh/oUleZsZufqIXXwUpp+aTegti+sM6sppmdeEaYbV+X3oYZR69lLdZ4uDtVatN3sX/j99OJN8oBXr4Bdkqkz6o4snppkjQEy9vZ3+YVgjaZPWQ4c7Iqyl3knt97uRKDlqoxJGLfBsg6ON97UZfjhkXltsBq5y6S5voBhhR+iqp2d4yEEY9PyTQpALhjHUqr4Ohn5jrr2BqAei31iPLeD4YfpsuWT5id8B58kmTBcrE8nISPG06DOY3H83dISnEQJpJoWQOBL9LGMu9SijqR165oedPXg8V54Xn0U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR04MB9849.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(7416014)(10070799003)(376014)(366016)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVRMbmhwUmF2VFU4cWRTVFBmZGdmQW8xdzUzWVVwOS9xK0hOUE1ZT1pmRVVF?=
 =?utf-8?B?SWFIRGNFR1AvaHhiV3lTbEdXaURQdFFGVlExbC9acUN3VllZN1dRNnF5WXBt?=
 =?utf-8?B?bWdJL0E2M3ZUZHMvbTZjbUlxWDlpRGorVFNabFJkcStYU1hoSUhPME01WGxl?=
 =?utf-8?B?U2FNdDd1UVdyOGxvak1JenJ6bmlFYmxvMy9XZVRRNS9GSjZIWElOSlVXYnpw?=
 =?utf-8?B?eldDTlo1SFMzWml0bllnOEdEYTBSZ0JRODRJZlJTQnNJYU1SSDUzWjhiVFF3?=
 =?utf-8?B?YmtLK0ROOVM1RmxFcW9QcURubVBRNHlOS0hCVHo0Y2xZWVA0Z3lkaUVnZHgw?=
 =?utf-8?B?ZUM0ZDhEVDBRL3pVcVl5Q2hpUVVxM2ZCSEVTaUtEWnlmYitSL1RtSWhqUjMz?=
 =?utf-8?B?WnovMEtXeW9kRlFMd25xMWkvalR4aUZnYkFWblJrdkMxT2VXYm1QblBwalNa?=
 =?utf-8?B?eHM1S1JkdVUyNmhQNHk3dnNOUjR6UkkrQlQvSVZOS2ttT2ZRelRSVkQyNnRu?=
 =?utf-8?B?NENPWjFlOGNZNFJkTUd3dnlZWnE2RzBJWmhhaFJVd2lvd21BMHdiT2JpRnpB?=
 =?utf-8?B?QVhrYi9haDZJdkV6RFhZRUxEcTUrejZVR2pWTmJ5ZnE0Q0FERk5RT001b0Q5?=
 =?utf-8?B?M2dqa0R1TWVQOGlYeXRzQlMvMS8yWThZblZTc1hCRnZyN2tnTmpKaVVnNEIr?=
 =?utf-8?B?ZmZuZmhsaVZSYzIzWjBrWFVaNDhNWEl2N2p1L2pxVWxOZjdxT3dVSjMrOG9G?=
 =?utf-8?B?TG9paERSSEl2c3pzbDI4VlJwVHZiY0x5NUkxWFFPTkU1K0JKcUo5MXpCdXpl?=
 =?utf-8?B?QnkwQnhhV3FvcEdGRU9vLzdtT1VuWkFYSFdnaWN1MVlHbFBZYlZEa2lnSlZX?=
 =?utf-8?B?TzA5LzJMWktiZlcwYzM3UnNIaHBZMGNmekR2ZFZWNnVsNm9TdUdsdEpPSEVh?=
 =?utf-8?B?enR2UlZaajJwQU9DYVl3Z1dUS0FGc2dJME91RURKZzRwTjFEL2s3Z1BpcVRI?=
 =?utf-8?B?UUN2RHVyTjVZd2Iwc0JJVlhTK1NESHBYZHA3VUpkNThHUjJWOENaRmQrNHpR?=
 =?utf-8?B?WWtwSVBxa0V1VzJsanUrUzlhM1hMcUhka3puVnY3NzY0TEt5dDg5SUJqYVY4?=
 =?utf-8?B?ajNIWVNvMXpXVzRRU1l3ZS83QlNLM01QWXg1dXBZS0tkYVFFMUVEOWhxRU1m?=
 =?utf-8?B?b1NNVGx1YTNVMXA1SlJkWDFneGt6QjhmNks1N0hZdDNrMFQ2UkRuQ0hSVDZv?=
 =?utf-8?B?UkU5eS80OURxVGMrSldXcWZzd0Q3ZzduNWk0ZmwrYXhWNXJ3a1dmSmFlVDd3?=
 =?utf-8?B?MGtJQmd3VmJnUTJ1Z3JvbEl0RGtoZW80aXZBdTlWR05MT1M4QlV0a2ZEU3M2?=
 =?utf-8?B?NDFWWFl5UFFicUlVR3BFekNrVmRIUkVaOFhQYm5STWZqY3gzdnBZS2NhYjNj?=
 =?utf-8?B?blp2VmtkR2FzSmlOdkFMa0tTWjdBTkJhUHd6RkFVZ0hoUm9pb1IrZVhvc2xj?=
 =?utf-8?B?WGd6b0tsMVQzMzdkRElSWmpLRWtacC84TWR5ZGk1QTdxRVgvRk9sRk5ibVVn?=
 =?utf-8?B?VXlqSVQydzV0SlJ5ZEh2VVhTaGpkYmpycDhoMnNZdjYyQ3JlVXJqdGNNNjdX?=
 =?utf-8?B?b3JCVzRSYll2N3oyQzAreU9tZHRoM3h2K1ZObk9mZ3R2QW5DODUyWVRhTEdu?=
 =?utf-8?B?bm9hMzhYVEgzRWc5NSswWWNhTTNiUVgvWVpIYTR0UFdzYzR2SnJSNXY1Znlk?=
 =?utf-8?B?S1NTRXBVMEdpUkYxekQ5bVpwK1B6U3JBTSsxQlpYT1ROSGpVbG41ejVkclMx?=
 =?utf-8?B?aEFVMVFrWnlCT2dsYkxBaHkyZ1lIQUtRUERTcUNTUGE1Sy9kQ3NUWVV1b0s3?=
 =?utf-8?B?Q0NCUmphR2w4SjB2ZDl1NTJ4dTQrdWhuRmw4QVcwRk1mTWhrM0VUd0ZkMFZ0?=
 =?utf-8?B?TDB4UEdXU3Fyd3NUMDBybnRRVXpsYlBxakVNVjlIajFPUEU0Mk1qMkFsZzNW?=
 =?utf-8?B?T0t4YW1Cczl3RFdXWlJuaGtCSWxNZXJuY09RNm9oVzcwSzJURHFOTHkzNTZI?=
 =?utf-8?B?QkF2aEJld3ErYVhnZkYzVU9xQmZoTnJFZWRFdW5waEVndHdyalpkcmlxRlpQ?=
 =?utf-8?B?YTJ3dkg1Qy9NYy8vNGw5TnZUWGVNb005dlh0VTNpenB5ZmZISjduYjBjRGtY?=
 =?utf-8?B?dHJzc2RVTzdwVkxNVjExOUlPS1B3NG94dmxOVGczd24zK1FoTWdIODdOWDJB?=
 =?utf-8?B?UHBCQ0FWaHZCV0RWaWszUzBxL2lVeC9DRHo5aUdUSlZOdEU3RkYwUENYT0Ja?=
 =?utf-8?B?bFIwbjZ3QSt0dndRcXdRUkU3WXRteGxySTcwOEd3Z2xqOVR0SnU0Q1pYSmc1?=
 =?utf-8?Q?a6PIO1bcY4tr6U8QQWo9mRy3E3+R5OJbwMv6EKxRmBcpl?=
x-ms-exchange-antispam-messagedata-1: Vkxb7AG5JBnHfutdQYZ7oGbTT6pH7zMb9XE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CE23DB7A71EDF498C9D1B5FC6D118B4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GDiRdeaHWZjcIqTlF5oaDWFIVuJFjqnqX/hWAgd8796D/wLUNmo+iYS+bax1Q7EnO56nEVW/iq8TDc6aD62lUhzyoCcGCFpZyCkM/OhQ4IgnNnmUz8HZNKm3IZiaXo10dWo3iwO3hjVWGOOmIwF/WXdG7zZ/qqlY/JV5DQ7DEFR1kIk++TqLSaLDJVaclQQ2WsTdahuDkzTU/welLJ32TM780uWYPhgDACAo5YR5ectTwG5/G1CntUAXc+hu12OdfndO7Bvt7BO3oERwEwIbRkaKn1oAfHwfocc38dDObZHrAguuvCI/PsChkz7OR2QgqGr9SXaA8zZtC6gtTUxB4DNuXXS+BsMUEQmdwIUSjnzqQIbpkRPgUNyc/c0Zfdkyam0we1IkztQl+w8/7ZGPWXnN9d1lDgSwrZD/E0dHbpCCW9rGNyrlf8CBcMfJZqXuxKNegmvS6lKkD02LN36NzZyWGkbmSB15mEo8/mc2WA40FaFl2oKzqpyAtS3FDh2axJWnmSo172WHVtYEg+CbwYpN3OVdaEaJNOexMB0rHTYopNfknDkYDiXa62nfoYUw0DKpqOdzOrmme4ZvEBDQh6mo5+/DOQVbh0pp2XUDtn3SrNz9Ma0U3f0Mij2kUKTh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB9849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e444796-18e5-4936-6a99-08de7591acf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 23:49:26.5480 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F6K4forzq4H8UPuED9gy5FKQsXpShjC/t+LpO4hXJYRs8m1f7Lw9uDBsSUExQCJKi363FjHpM0lGnKu8S2Pl5o8oeMpiiJU6lMqezmm+Plg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6997
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=510b84ec3=Alistair.Francis@wdc.com;
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

T24gTW9uLCAyMDIzLTAxLTMwIGF0IDEzOjE0ICswMTAwLCB+bGV4YmFpbGV5bG93cmlzYyB3cm90
ZToNCj4gRnJvbTogRW1tYW51ZWwgQmxvdCA8ZWJsb3RAcml2b3NpbmMuY29tPg0KDQpZb3VyIHBh
dGNoIHRpdGxlcyBhcmUgYSBsaXR0bGUgbG9uZy4gWW91IGRvbid0IG5lZWQgdG8gaW5jbHVkZSBg
cWVtdWANCm9yIGBbb3RdYCBpbiB0aGUgcGF0Y2ggYW5kIGNvbW1pdCB0aXRsZXMuDQoNCj4gDQo+
IFVzZSBhIHNlcGFyYXRlIEtjb25maWcgc3ltYm9scyBmb3IgSWJleCBVQVJULCBUaW1lciwgYW5k
IFNQSSBkZXZpY2VzOg0KPiBoYXZpbmcgYW4gSWJleCBDUFUgZG9lcyBub3QgaW1wbHkgdXNhZ2Ug
b2YgdGhlc2Ugc3BlY2lmaWMNCj4gaW1wbGVtZW50YXRpb25zLg0KDQpXaHkgaXMgdGhpcyByZXF1
aXJlZCB0aG91Z2g/DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEVtbWFudWVsIEJsb3QgPGVibG90
QHJpdm9zaW5jLmNvbT4NCg0KWW91IGFyZSBtaXNzaW5nIHlvdXIgU29CIGhlcmUgKGFuZCBpbiBv
dGhlciBwYXRjaGVzKQ0KDQo+IC0tLQ0KPiDCoGh3L2NoYXIvS2NvbmZpZ8KgwqDCoMKgwqDCoCB8
IDMgKysrDQo+IMKgaHcvY2hhci9tZXNvbi5idWlsZMKgwqAgfCAyICstDQo+IMKgaHcvcmlzY3Yv
S2NvbmZpZ8KgwqDCoMKgwqAgfCAzICsrKw0KPiDCoGh3L3NzaS9LY29uZmlnwqDCoMKgwqDCoMKg
wqAgfCA0ICsrKysNCj4gwqBody9zc2kvbWVzb24uYnVpbGTCoMKgwqAgfCAyICstDQo+IMKgaHcv
dGltZXIvS2NvbmZpZ8KgwqDCoMKgwqAgfCAzICsrKw0KPiDCoGh3L3RpbWVyL2liZXhfdGltZXIu
YyB8IDIgKy0NCj4gwqBody90aW1lci9tZXNvbi5idWlsZMKgIHwgMiArLQ0KPiDCoDggZmlsZXMg
Y2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9ody9jaGFyL0tjb25maWcgYi9ody9jaGFyL0tjb25maWcNCj4gaW5kZXggMDIwYzBhODRi
Yi4uMGNiYmFlZGIyZiAxMDA2NDQNCj4gLS0tIGEvaHcvY2hhci9LY29uZmlnDQo+ICsrKyBiL2h3
L2NoYXIvS2NvbmZpZw0KPiBAQCAtOTUsMyArOTUsNiBAQCBjb25maWcgSVBfT0NUQUxfMjMyDQo+
IMKgwqDCoMKgIGJvb2wNCj4gwqDCoMKgwqAgZGVmYXVsdCB5DQo+IMKgwqDCoMKgIGRlcGVuZHMg
b24gSVBBQ0sNCj4gKw0KPiArY29uZmlnIElCRVhfVUFSVA0KPiArwqDCoMKgIGJvb2wNCj4gZGlm
ZiAtLWdpdCBhL2h3L2NoYXIvbWVzb24uYnVpbGQgYi9ody9jaGFyL21lc29uLmJ1aWxkDQo+IGlu
ZGV4IGE5ZTFkYzI2YzAuLmY0N2ZhMTFiYmUgMTAwNjQ0DQo+IC0tLSBhL2h3L2NoYXIvbWVzb24u
YnVpbGQNCj4gKysrIGIvaHcvY2hhci9tZXNvbi5idWlsZA0KPiBAQCAtMiw3ICsyLDcgQEAgc3lz
dGVtX3NzLmFkZCh3aGVuOiAnQ09ORklHX0NBREVOQ0UnLCBpZl90cnVlOg0KPiBmaWxlcygnY2Fk
ZW5jZV91YXJ0LmMnKSkNCj4gwqBzeXN0ZW1fc3MuYWRkKHdoZW46ICdDT05GSUdfQ01TREtfQVBC
X1VBUlQnLCBpZl90cnVlOiBmaWxlcygnY21zZGstDQo+IGFwYi11YXJ0LmMnKSkNCj4gwqBzeXN0
ZW1fc3MuYWRkKHdoZW46ICdDT05GSUdfRVNDQycsIGlmX3RydWU6IGZpbGVzKCdlc2NjLmMnKSkN
Cj4gwqBzeXN0ZW1fc3MuYWRkKHdoZW46ICdDT05GSUdfR1JMSUInLCBpZl90cnVlOg0KPiBmaWxl
cygnZ3JsaWJfYXBidWFydC5jJykpDQo+IC1zeXN0ZW1fc3MuYWRkKHdoZW46ICdDT05GSUdfSUJF
WCcsIGlmX3RydWU6IGZpbGVzKCdpYmV4X3VhcnQuYycpKQ0KPiArc3lzdGVtX3NzLmFkZCh3aGVu
OiAnQ09ORklHX0lCRVhfVUFSVCcsIGlmX3RydWU6DQo+IGZpbGVzKCdpYmV4X3VhcnQuYycpKQ0K
PiDCoHN5c3RlbV9zcy5hZGQod2hlbjogJ0NPTkZJR19JTVgnLCBpZl90cnVlOiBmaWxlcygnaW14
X3NlcmlhbC5jJykpDQo+IMKgc3lzdGVtX3NzLmFkZCh3aGVuOiAnQ09ORklHX0lQX09DVEFMXzIz
MicsIGlmX3RydWU6DQo+IGZpbGVzKCdpcG9jdGFsMjMyLmMnKSkNCj4gwqBzeXN0ZW1fc3MuYWRk
KHdoZW46ICdDT05GSUdfSVNBX0JVUycsIGlmX3RydWU6IGZpbGVzKCdwYXJhbGxlbC0NCj4gaXNh
LmMnKSkNCj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L0tjb25maWcgYi9ody9yaXNjdi9LY29uZmln
DQo+IGluZGV4IDAyMjJjOTNmODcuLmU2YWEzMmVlOGYgMTAwNjQ0DQo+IC0tLSBhL2h3L3Jpc2N2
L0tjb25maWcNCj4gKysrIGIvaHcvcmlzY3YvS2NvbmZpZw0KPiBAQCAtMzgsNiArMzgsOSBAQCBj
b25maWcgT1BFTlRJVEFODQo+IMKgwqDCoMKgIGRlZmF1bHQgeQ0KPiDCoMKgwqDCoCBkZXBlbmRz
IG9uIFJJU0NWMzINCj4gwqDCoMKgwqAgc2VsZWN0IElCRVgNCj4gK8KgwqDCoCBzZWxlY3QgSUJF
WF9TUElfSE9TVA0KPiArwqDCoMKgIHNlbGVjdCBJQkVYX1RJTUVSDQo+ICvCoMKgwqAgc2VsZWN0
IElCRVhfVUFSVA0KPiDCoMKgwqDCoCBzZWxlY3QgU0lGSVZFX1BMSUMNCj4gwqDCoMKgwqAgc2Vs
ZWN0IFVOSU1QDQo+IMKgDQo+IGRpZmYgLS1naXQgYS9ody9zc2kvS2NvbmZpZyBiL2h3L3NzaS9L
Y29uZmlnDQo+IGluZGV4IDFiZDU2NDYzYzEuLmM4ZDU3M2VlYjkgMTAwNjQ0DQo+IC0tLSBhL2h3
L3NzaS9LY29uZmlnDQo+ICsrKyBiL2h3L3NzaS9LY29uZmlnDQo+IEBAIC0zMiwzICszMiw3IEBA
IGNvbmZpZyBQTlZfU1BJDQo+IMKgY29uZmlnIEFMTFdJTk5FUl9BMTBfU1BJDQo+IMKgwqDCoMKg
IGJvb2wNCj4gwqDCoMKgwqAgc2VsZWN0IFNTSQ0KPiArDQo+ICtjb25maWcgSUJFWF9TUElfSE9T
VA0KPiArwqDCoMKgIGJvb2wNCj4gK8KgwqDCoCBzZWxlY3QgU1NJDQo+IGRpZmYgLS1naXQgYS9o
dy9zc2kvbWVzb24uYnVpbGQgYi9ody9zc2kvbWVzb24uYnVpbGQNCj4gaW5kZXggNmFmYjFlYTIw
MC4uYTNiYTMxOTI4MCAxMDA2NDQNCj4gLS0tIGEvaHcvc3NpL21lc29uLmJ1aWxkDQo+ICsrKyBi
L2h3L3NzaS9tZXNvbi5idWlsZA0KPiBAQCAtMTAsNiArMTAsNiBAQCBzeXN0ZW1fc3MuYWRkKHdo
ZW46ICdDT05GSUdfWElMSU5YX1NQSScsIGlmX3RydWU6DQo+IGZpbGVzKCd4aWxpbnhfc3BpLmMn
KSkNCj4gwqBzeXN0ZW1fc3MuYWRkKHdoZW46ICdDT05GSUdfWElMSU5YX1NQSVBTJywgaWZfdHJ1
ZToNCj4gZmlsZXMoJ3hpbGlueF9zcGlwcy5jJykpDQo+IMKgc3lzdGVtX3NzLmFkZCh3aGVuOiAn
Q09ORklHX1hMTlhfVkVSU0FMJywgaWZfdHJ1ZTogZmlsZXMoJ3hsbngtDQo+IHZlcnNhbC1vc3Bp
LmMnKSkNCj4gwqBzeXN0ZW1fc3MuYWRkKHdoZW46ICdDT05GSUdfSU1YJywgaWZfdHJ1ZTogZmls
ZXMoJ2lteF9zcGkuYycpKQ0KPiAtc3lzdGVtX3NzLmFkZCh3aGVuOiAnQ09ORklHX0lCRVgnLCBp
Zl90cnVlOg0KPiBmaWxlcygnaWJleF9zcGlfaG9zdC5jJykpDQo+ICtzeXN0ZW1fc3MuYWRkKHdo
ZW46ICdDT05GSUdfSUJFWF9TUElfSE9TVCcsIGlmX3RydWU6DQo+IGZpbGVzKCdpYmV4X3NwaV9o
b3N0LmMnKSkNCj4gwqBzeXN0ZW1fc3MuYWRkKHdoZW46ICdDT05GSUdfQkNNMjgzNV9TUEknLCBp
Zl90cnVlOg0KPiBmaWxlcygnYmNtMjgzNV9zcGkuYycpKQ0KPiDCoHN5c3RlbV9zcy5hZGQod2hl
bjogJ0NPTkZJR19QTlZfU1BJJywgaWZfdHJ1ZTogZmlsZXMoJ3Budl9zcGkuYycpKQ0KPiBkaWZm
IC0tZ2l0IGEvaHcvdGltZXIvS2NvbmZpZyBiL2h3L3RpbWVyL0tjb25maWcNCj4gaW5kZXggYjNk
ODIzY2UyYy4uMmZkZWZkMGQxZiAxMDA2NDQNCj4gLS0tIGEvaHcvdGltZXIvS2NvbmZpZw0KPiAr
KysgYi9ody90aW1lci9LY29uZmlnDQo+IEBAIC02NSwzICs2NSw2IEBAIGNvbmZpZyBTVEVMTEFS
SVNfR1BUTQ0KPiDCoA0KPiDCoGNvbmZpZyBBVlJfVElNRVIxNg0KPiDCoMKgwqDCoCBib29sDQo+
ICsNCj4gK2NvbmZpZyBJQkVYX1RJTUVSDQo+ICvCoMKgwqAgYm9vbA0KPiBkaWZmIC0tZ2l0IGEv
aHcvdGltZXIvaWJleF90aW1lci5jIGIvaHcvdGltZXIvaWJleF90aW1lci5jDQo+IGluZGV4IGVl
MTg2NTIxODkuLjg1OGUxYTY3ZGUgMTAwNjQ0DQo+IC0tLSBhL2h3L3RpbWVyL2liZXhfdGltZXIu
Yw0KPiArKysgYi9ody90aW1lci9pYmV4X3RpbWVyLmMNCj4gQEAgLTMxLDcgKzMxLDcgQEANCj4g
wqAjaW5jbHVkZSAiaHcvdGltZXIvaWJleF90aW1lci5oIg0KPiDCoCNpbmNsdWRlICJody9jb3Jl
L2lycS5oIg0KPiDCoCNpbmNsdWRlICJody9jb3JlL3FkZXYtcHJvcGVydGllcy5oIg0KPiAtI2lu
Y2x1ZGUgInRhcmdldC9yaXNjdi9jcHUuaCINCj4gKyNpbmNsdWRlICJody9jb3JlL3JlZ2lzdGVy
ZmllbGRzLmgiDQoNCldoeSBkb2VzIHRoaXMgbmVlZCB0byBiZSBjaGFuZ2VkPw0KDQpBbGlzdGFp
cg0KDQo+IMKgI2luY2x1ZGUgIm1pZ3JhdGlvbi92bXN0YXRlLmgiDQo+IMKgDQo+IMKgUkVHMzIo
QUxFUlRfVEVTVCwgMHgwMCkNCj4gZGlmZiAtLWdpdCBhL2h3L3RpbWVyL21lc29uLmJ1aWxkIGIv
aHcvdGltZXIvbWVzb24uYnVpbGQNCj4gaW5kZXggMTc4MzIxYzAyOS4uY2MwMmFhMGRkYSAxMDA2
NDQNCj4gLS0tIGEvaHcvdGltZXIvbWVzb24uYnVpbGQNCj4gKysrIGIvaHcvdGltZXIvbWVzb24u
YnVpbGQNCj4gQEAgLTMwLDcgKzMwLDcgQEAgc3lzdGVtX3NzLmFkZCh3aGVuOiAnQ09ORklHX1NT
RV9USU1FUicsIGlmX3RydWU6DQo+IGZpbGVzKCdzc2UtdGltZXIuYycpKQ0KPiDCoHN5c3RlbV9z
cy5hZGQod2hlbjogJ0NPTkZJR19TVEVMTEFSSVNfR1BUTScsIGlmX3RydWU6DQo+IGZpbGVzKCdz
dGVsbGFyaXMtZ3B0bS5jJykpDQo+IMKgc3lzdGVtX3NzLmFkZCh3aGVuOiAnQ09ORklHX1NUTTMy
RjJYWF9USU1FUicsIGlmX3RydWU6DQo+IGZpbGVzKCdzdG0zMmYyeHhfdGltZXIuYycpKQ0KPiDC
oHN5c3RlbV9zcy5hZGQod2hlbjogJ0NPTkZJR19YSUxJTlgnLCBpZl90cnVlOg0KPiBmaWxlcygn
eGlsaW54X3RpbWVyLmMnKSkNCj4gLXNwZWNpZmljX3NzLmFkZCh3aGVuOiAnQ09ORklHX0lCRVgn
LCBpZl90cnVlOiBmaWxlcygnaWJleF90aW1lci5jJykpDQo+ICtzeXN0ZW1fc3MuYWRkKHdoZW46
ICdDT05GSUdfSUJFWF9USU1FUicsIGlmX3RydWU6DQo+IGZpbGVzKCdpYmV4X3RpbWVyLmMnKSkN
Cj4gwqBzeXN0ZW1fc3MuYWRkKHdoZW46ICdDT05GSUdfU0lGSVZFX1BXTScsIGlmX3RydWU6DQo+
IGZpbGVzKCdzaWZpdmVfcHdtLmMnKSkNCj4gwqANCj4gwqBzcGVjaWZpY19zcy5hZGQod2hlbjog
J0NPTkZJR19BVlJfVElNRVIxNicsIGlmX3RydWU6DQo+IGZpbGVzKCdhdnJfdGltZXIxNi5jJykp
DQo=

