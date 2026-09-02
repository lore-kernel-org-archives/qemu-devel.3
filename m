Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F73C61DD3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 01:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1a1l-0006v9-89; Tue, 01 Sep 2026 21:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6980a3afb=Alistair.Francis@wdc.com>)
 id 1x1a1k-0006ut-9P
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 21:44:36 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6980a3afb=Alistair.Francis@wdc.com>)
 id 1x1a1i-0002oJ-KW
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 21:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788313474; x=1819849474;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=KnDCtOrUoS8P3XVFGh9vP6OPCk9eqe+DIZYbnnLNKpk=;
 b=EZw37/+taTS8ksUYJgBknRD+HxW5H81IjQe2lJL1gM3I0Bz92Bm2+YC/
 eo2+q4yMKgh0r4+mLUIqTTzsnoyliaWfyNg+D9bnCY54mJFjDBPFGfrT4
 ryCWtt4ONfUKoe1HECEWj0kcMU6Fl6+Tqn33FhASNdYXi4PklAGRfc/FI
 QbZ9vUuZ6s4sU4ARdK+JQzBozucmhEaWP2ku2TBYxnd/4nClvL9D2aO+M
 yHV4AtUmO2lvfLjOIS1DrAp7FYsCElujp9dQoYX7+H3Q/6zS7kElQIZvU
 GoHMCNwq5AV5edI/AqgQoorHxLHqXQ7W94yQwGnEbQinOJXyhB1P0SmTM w==;
X-CSE-ConnectionGUID: Kq9yR8q6QxGnZjmqCSvjhg==
X-CSE-MsgGUID: kdAdO9lNTx6bsHaq6xgQjA==
X-IronPort-AV: E=Sophos;i="6.25,257,1779120000"; d="scan'208";a="155665954"
Received: from mail-westus3azon11011026.outbound.protection.outlook.com (HELO
 PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.26])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 Sep 2026 09:44:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkPc4KioHfxPbWXHojCcAnkN1/dvf3ILeG2FI777v/sUDjwceEHgioAbAEYANitenvI6qGod8jtnjzH0kfp29S84h148TaN5vUGZ4FUKs1PLt92mxWlK2Vp8hQsotY2e2Q8dRq7bytYNUcP7HSwxCG+iiLZanJEchq5Ha/zQw4pERORveq6KPj4HrJDZclxn9tZtOoI0JgyAszoiKTcZxS9FbhZasRuEq6mwT0G+w5JyqL6eEB/SEoHuWtGInggAGrOOCjmKQyTydR6smn7GBOCb0FnIarrZvwRGO+gmgOqx1d9LbOKI3PZh9d2fsepcPFJmXoPcgWZtz5ttpkLz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnDCtOrUoS8P3XVFGh9vP6OPCk9eqe+DIZYbnnLNKpk=;
 b=UJNm2BJRRiEFTziWJ0ht/dsKH5MgNTTKS+1GcRRaGHpSj6EOpOW7PbcnX4CuS8IEptBMt+6bEK2yEYmYrX0osEcVNKKHbK80k5h7YPLkXpi4LK9L4MI1CiYhPIQpi5qk2CNXzCi3aI6gued3H7YkEBgT6SdfGUb7MKx/ytLB0YUVQScvnNxWTbeMaXfyU0vlDzOERvOHlOgQKJxEKLGBjfgLpPj32bzE+IyIStxoORkhPiBl4Cwy509JaGS4NCxN1opAVkmQoJt65kY5fMyIet6NGa9FV7XCYGl9HS3Vol2e7tl8Vu2TxuqG6FntX630X4nb3onvhGk/jHdo0ul2mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnDCtOrUoS8P3XVFGh9vP6OPCk9eqe+DIZYbnnLNKpk=;
 b=CDiGsEkIfSVUHnkJMnc29uimSDljP0HYtUSseUMe5GZMBRV26NqjLghFLwewDZWVXLXpTbNDMdiL00wUuQuTkMW7OrppfyMyF6UwgXI8R62+eKRCKvWHsWfDMU9svrNp3KWQquihitN5AEQAHYI01N6SqjYVLp3cGqgPaJ9R6pM=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CO6PR04MB7697.namprd04.prod.outlook.com (2603:10b6:303:a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Wed, 2 Sep
 2026 01:44:31 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 01:44:31 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "philmd@linaro.org"
 <philmd@linaro.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "kwolf@redhat.com" <kwolf@redhat.com>, "balaton@eik.bme.hu"
 <balaton@eik.bme.hu>, "mst@redhat.com" <mst@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>, "berrange@redhat.com" <berrange@redhat.com>,
 "imp@bsdimp.com" <imp@bsdimp.com>
Subject: Re: [PATCH 3/4] AGENTS.md: make the human part of the design process
Thread-Topic: [PATCH 3/4] AGENTS.md: make the human part of the design process
Thread-Index: AQHdOi0HRzcklzpxAEys18lcTi8bz7a6hNYA
Date: Wed, 2 Sep 2026 01:44:31 +0000
Message-ID: <1316742a2f16feb94ff18ee157f24c91a91be1f3.camel@wdc.com>
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <20260901161422.314581-4-pbonzini@redhat.com>
In-Reply-To: <20260901161422.314581-4-pbonzini@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CO6PR04MB7697:EE_
x-ms-office365-filtering-correlation-id: c6db9244-ea0e-4172-9892-08df0893bbae
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|19092799006|23010399003|7416014|376014|6133799003|22082099003|18002099003|56012099006|38070700021|10067099003|11063799006|5023799004|4143699003;
x-microsoft-antispam-message-info: uQvhW4opjXDwk8R1MJ0SJecxggl/o6U8qHKCnfnFutt7YHGMkrIfL6DJkChbCKJYwOkcdjHJ5XP779vviwCE8oG4Cr2umJq3IuUIlDXdHkZoSXWE8w4G5MfTbhZp1aefIjS90+4YbavieTD4CcwBcLs3+2OwzBNODcDP58J34RTHZk/YGxPg/bPZqjOiuB8DUQdcK+IsHabqxyciSG8mdrYjc5G+Chr4h2rZmbCMrK0N1vR9LIsmMaKew+uchZrmCpVyy1y4/UZSbrQ6wy8rOru8BOV/f7fJ910CljOv6Oac1h2DdslolWGQ2zCT7Kpo6ZHbDguqbM9VkgUtcxiu5utGEZN3mPp6mpzlnwPNJTqbidjKm5Xv2Q8kiClUmi0UlrPV7OXjO0InJp8335sStDeIPOYa3ZX9fHxpOQ6laiS0EJYVuukqcI+AzpAQeADj/rsKGM4/CJkayHL4vdiHkZPzhVRh/YBCpZshfp0n1twAwoVzfcPuxQj1PxcI9nuvUms8ZL0HDAHQsvvzi1cnu0DCufTEEykPixiaR78VJbNjvglHhgXi6vNP2kCstD+qWtjnrztZFL9F76lIaCv+Eatmy4Gnzs4+TVgxw25Kp/53zSHUpq5tCy2GXHzFMyFTHGIt99v4Yf+RpXpV/meDRgcDIVhlcrU7/7VrqbjrtP8MNxWKIRIqJBOzQujxowQV+aOXjN+oVkVjuSuS/6QETBWVRtN2QakM6XckkzncIYU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(19092799006)(23010399003)(7416014)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(38070700021)(10067099003)(11063799006)(5023799004)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bW1hMk4zWEx6bXZnZU5VWG5LY0hiM0R1SWhWM2RxcjY5WGNrdE5yTWhqQmpv?=
 =?utf-8?B?Zmh2SEszc1hNaElKUGFnSHpaZlNseTFYOUhzM3N5SndSZk9BV3I4V21qQ2RF?=
 =?utf-8?B?SVp3TmVGWDJhSGk5NGJhTjN3SytOdkFVdEZlQUtqVFpyUUZEQ0hqK2lVTE9N?=
 =?utf-8?B?S1B4ZDI4Sk9QVUVMbzVRcm43eWd6QzRnb1JEMGs1ZklPTVFUU0xIbyt4cFB6?=
 =?utf-8?B?RE9QYllyei80YmxtRjRhV1BsWlMwVk5OUEJ4TDgzRTBTb0FGcnhEK2lJUG9X?=
 =?utf-8?B?THROOGJtL3pVbnhOOTZzeEdqT3VnbFB3c21nSzEwUTd6N2RRM0xuVUNQMERr?=
 =?utf-8?B?OS83Szk4M1pjR2t6VTVtMXhERnhuMVJUV21PNG1pbSs5MW9odEVnNGhXUVNr?=
 =?utf-8?B?M1o4NW05UnlDVDlkdTRidXF6RzZiaEdzbkI0S0Z5S3JRWXJPRDlScTZSY1Nr?=
 =?utf-8?B?a0EvTFpKWlBxOVZTQmhDZElYSG9WOE5zTVpKWFJ0Ui9yTzZ1S0NMakl0MUFy?=
 =?utf-8?B?QStsV2M0OEUvOXU3Szh0UEZReXF3eUthVEgvakhpQy9WaEhXaitXcFlQcmMy?=
 =?utf-8?B?RWlML0ZRaGxBSlVobWtFNk1TaFozRitSM2c3cGwvZmVHQUgvNHVWd0ErRlNk?=
 =?utf-8?B?dHZlMVY4RzdLV1lEMUVtV1k5ODRPcTZDL2NTNGlnYWJWM09xMHlYYjdkdHla?=
 =?utf-8?B?TVdSYlg2WXJ2YnU5Wm9iL3lFMzZ5VkNwWDYrekJKRTNuM01oYXA4bmdwaHFh?=
 =?utf-8?B?czFITklRMFJFKy9jbzVXb0U2WFZIeGV3WWRFaDNsNG1GWFhKcUVUZWF6QVZt?=
 =?utf-8?B?RU14TXU2dTFzYTZYbGxXK3B4TXZsekdvQ2tQWCtSdC96RE9VMTVUb3dFWllw?=
 =?utf-8?B?Z3ozSTJiTWdPeXdMaEFkRU16NENRQ2dheFpDN2wrc2pWYW1rSXhMWVZOUFRn?=
 =?utf-8?B?YS9vcENYQkRYdmZvaTU0M1NqZ0pSWFR5cU5DR3EwVzVGNmUvVDQzSzN0MlFk?=
 =?utf-8?B?bmdOd1lTZG5zekxmakFDUUszOHYwdUZqc1o0UkVtQ25ybFRINVFCcEZRU1dH?=
 =?utf-8?B?WFk0SS9UUXcwT01kQlRyQU12dzIremN0ODkwK3l6dnRHSWt6dW15TWdnK0hJ?=
 =?utf-8?B?SzRrcTl4MjEzRklFdHU1TlVlWUtlb0Y5M292UWZLbTVQRDM3UmdzZW9RTWg1?=
 =?utf-8?B?S01kdUJGZVRxTFFxYlNCWGpGcWVyWW0veWswV3VOeFBickIyQnJIZVVjTCtS?=
 =?utf-8?B?aUE2MVN0VER3ZHRnRmF5T2NUcHp6KzJHcnFnOHhNVDMvZlBsREg4eENjZ3U1?=
 =?utf-8?B?K1hqRU5tVEJKaE5pVW01TlprTFVocHdNNm1DUUxVcC9WbEVCaUhpMDJBdzRs?=
 =?utf-8?B?b3Y2WWszMERrNHZPOVFIbGVLQXo5N28zZFBYVDVNMlBTWVE3T0dFWFBKdEFI?=
 =?utf-8?B?WWltWmtmbGMvd2RzeE44YTErSHlFVlNCclJzOTZaczNOQ1ZzTFR4NldCVHU1?=
 =?utf-8?B?c3ZkRVh3cXUvRDdiYUdlckhvMTJocnlSZ0pNNEtUZ3QyTnVMZDZyajZURC9l?=
 =?utf-8?B?blBDWTVQSExTNmY1L1llV3pzQlB0eDBwTm9KOWw2cTdLVFJaRURJTDlvRmxa?=
 =?utf-8?B?czlrVlNCTExDcnYwSnpXMTZXeGRTcjAyTVc1MEM4RUw5WC9lem5yYUZMVjVn?=
 =?utf-8?B?TGxRdEpOZnFCL2lOanhaSmk3UXFzT2daMjRlWWJvUVNtcEZLUGRKcFIwZXVo?=
 =?utf-8?B?WmFXd2txMHBUMVdjUElHOCs1ZTFzOHI4b0srU0FqR2tkenFBdmc3RUVyYXIr?=
 =?utf-8?B?MkZHZks1YXAvUjBDb1ZaYVJzM01WQkpKeDBUbUFjeHdQRFo4QTE5Ri9QRXc0?=
 =?utf-8?B?T0NnSG9QUFB5VXBmZlYrTDI4ZG1aNUxMUjJ0MEVCbFVxcHZSZzFzVk51aWxP?=
 =?utf-8?B?a0hQVWhwVWdOWnpNK1ZDYmhveHZMM2VOOUdodTZjN04wMm83TjZnejNFcEF3?=
 =?utf-8?B?Rzk0bHltZkJDa29BYXQxUFBXVEdDeHNWa3lWM0w2NFdVbDk2WWpOTEpEYS9U?=
 =?utf-8?B?MmtzVzlyWTRtWXRISWJIaHIrQS8xUFowWW1iQ1VQdzEzUm9ha04rUGRKdHVz?=
 =?utf-8?B?bkNDQUQvZzZFZWRYMmhyT0dsUzhtdGcyRzBXWVhqWDBFM0RLWWprdThtaU4r?=
 =?utf-8?B?aDdPc2VBZEo2cTNkYmxOUlJLRiszM2FqMUszNTQyOTEwWDlRd3NzdWRRMjNh?=
 =?utf-8?B?QTh3ZE1taExlVUlJcGtNMlpacUJkSjNwVUJGSnhGdGh6b3NJODE5aFhmUmg0?=
 =?utf-8?B?Ym5tcEZiVkNqQ1o5bTV5aUlacHloWkZVZHo5NzNINGJDUkV4MFpHVkxDMEg1?=
 =?utf-8?Q?c09WaerBYu5HsMC94ht6NOdEpxV7P9cgWbokISb+KZlYK?=
x-ms-exchange-antispam-messagedata-1: a3E0YuCZt2LUFPTBw+ye6Nn7DCNNqlI9Keg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A3B2431F977C0418F199788EF63E47E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oiEJjOYbpp37wEGfltSwLISoLm3es+YnCWVOfrCeW45SUvtBgAyeF9XNgdfo9ioJy9avEkiwQWs9PgvM0LdEjQ6P91pWqq+I8/HT8ZINuMMOVfPQ2YAjbJvVTx3oTOWHuDIuPQPOwWdl+oxNX2QVo79BZjoDvt+fDgxrBVrzb1OdusC3S4i9Buug+SJr+BEifyzINpUBgW+TPZN8YEz/dnjAvREKRoosFNt7AFUg3DFRWHOhoFDhiBin3DCk58jOwH09gG7Ww2RW0t08dEAgctYCfk//rkURnCGaFMFV8Ma8B3ReimPjnIRb1M1E+syYIYk08sEGfuwONcNmW1WDKw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NDD7t/avYC+55iq4v6imPDOlmNdfutDDl8IiLbx7WAH6/Zq2Dz7KGcPuwPxzQqp6AFTZg3osf1b+TfgQX+JKaBHYUtc9bSV6WLQoIkuyecheO3sLuO2UIc1ReUdjnjdmuzMKYYd249WL8x0gZS+QfkquG8NjDLbGkvrRr5IUYvPk5IHhXSCxCNMqy5Wiu7J1v3M52VN2Q5N6OnZDTXBtZS/qi+/06brjWsHB1TRh9JMvBaE4ZRrqobdcaHo2mqwrb+/3wtlkLETze90BTJc93iQ0jDP0d9b3bZtniAaVoyQgKMDYrG5Z+fjpeSdh5ecc1KhLYcZ6US9ljeljKmcwMvcKhkRRVJkGRxyMsLthiDQLcwODj2RNmD/usmAj2kYFf405Xk2RUAxFpAmfek7f4AAO+4JASgtm41jNhN/LgJaqWxBbKXoYs2039RS6Dveb0aDvHE2mKhEtq7/U6OTeeW5IuVN9n3h+rAQQAvhUXuzAWdbOpF6WISJuAjyLLNTBw3AzFXd2YPWm0/vGmR2cFnVUFa1aHYJLyQs6MAmGm5z9pSgdre+VBISMazMZlTda4/UALhi+1sJMV/2DA3ht7cDTmOeKO+PNL8jT6kb8b3yuxyL9ID609vZw9BJ121if
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6db9244-ea0e-4172-9892-08df0893bbae
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 01:44:31.1771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uDyEGRtQuUTRJLlzZcodlFFTrNorjQ4fcunIvVv+QbhnDeR+tjH99GobiQ5eOCKwJiqOCZRznwrKejHjXXnuUYiHz0S8a0HErD0mMo05kcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7697
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=6980a3afb=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

T24gVHVlLCAyMDI2LTA5LTAxIGF0IDE4OjE0ICswMjAwLCBQYW9sbyBCb256aW5pIHdyb3RlOg0K
PiBUaGlzIGNhbWUgb3V0IG9mIHRoZSBleHBlcmltZW50IHdpdGggdGhlIGZpcnN0IHZlcnNpb24g
b2YgdGhlDQo+IEFHRU5UUy5tZA0KPiBmaWxlLCBjb3JyZXNwb25kaW5nIHRvIHRoZSBwcmV2aW91
cyBjb21taXQuwqAgVGhpcyBhZGRpdGlvbiBpbXByb3ZlZA0KPiB0aGUNCj4gYmVoYXZpb3Igb2Yg
dGhlIGFnZW50IGZyb20gdGhlIHZlcnkgYmVnaW5uaW5nLsKgIFRoZSB2ZXJ5IGZpcnN0IGFuc3dl
cg0KPiB0bw0KPiB0aGUgc2FtZSBwcm9tcHQgaW4gZmFjdCB3YXMgIkknbGwgb3JpZW50IGluIHRo
ZSBjb2RlYmFzZSBmaXJzdCwgdGhlbg0KPiB3ZQ0KPiBzaG91bGQgdGFsayBhYm91dCBkZXNpZ24g
Y2hvaWNlcyBiZWZvcmUgSSB3cml0ZSBhbnl0aGluZyIuDQo+IA0KPiBJbiBmYWN0LCBhZnRlciB0
aGlua2luZyBpdCBwb2ludGVkIG91dCBmcm9tIHRoZSBzdGFydCB0aGF0IHRoaXMNCj4gcmVxdWly
ZXMNCj4gcHJlLWFycmFuZ2VtZW50IGFuZCBhc2tlZCB0d28gcXVlc3Rpb25zIChob3cgdG8gcmVw
cmVzZW50IHRoZQ0KPiBwcmVzc3VyZSBhbmQNCj4gdGVtcGVyYXR1cmUgaW4gdGhlIFFPTSBwcm9w
ZXJ0aWVzLCBob3cgbXVjaCBvZiB0aGUgYmVoYXZpb3IgdG8NCj4gaW1wbGVtZW50KS4NCj4gRXZl
biB3aXRoIGEgc2luZ2xlIGRhdGEgcG9pbnQgaXQgc2VlbXMgd29ydGggdHJ5aW5nLg0KPiANCj4g
V2hlbiBhc2tlZCB0byBjb21taXQgYXV0b25vbW91c2x5LCB0aGUgTExNIGFsc28gY2xhcmlmaWVk
IHRoYXQgaXQNCj4gd291bGRuJ3QgYWRkIFMtby1iIHRyYWlsZXJzIGFuZCB0aGF0IHByZS1hcnJh
bmdlbWVudCB3YXMgb24gbWUuDQo+IEl0IGluY2x1ZGVkICJNZXNzYWdlIHdyaXR0ZW4gYnkgYW4g
QUkgYW5kIHRvIGJlIHJld3JpdHRlbiBieSBoYW5kOw0KPiBub3QNCj4gZm9yIHN1Ym1pc3Npb24g
YXMgaXMiIGluIHRoZSBjb21taXQgbWVzc2FnZSwgYSAiaGFuZG92ZXIgbm90ZXMiDQo+IHNlY3Rp
b24gYWJvdXQgZGVzaWduIGNob2ljZXMgdGhhdCB3ZXJlIG1hZGUgd2l0aG91dCB0aGUgdXNlciBp
bnB1dCwNCj4gYW5kIHRoZSB1bXB0ZWVudGggcmVtaW5kZXIgdGhhdCB0aGUgd29yayBtYXkgb25s
eSBiZSBwb3N0ZWQgaWYgYQ0KPiBtYWludGFpbmVyIGhhcyBhZ3JlZWQgYmVmb3JlaGFuZCB0byBy
ZXZpZXcgdGhlbS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBhb2xvIEJvbnppbmkgPHBib256aW5p
QHJlZGhhdC5jb20+DQoNCkFja2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFu
Y2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgQUdFTlRTLm1kIHwgMTYgKysr
KysrKysrKysrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvQUdFTlRTLm1kIGIvQUdFTlRTLm1kDQo+IGluZGV4IDhmYjk2ZWJmYzM4
Li5jM2NiNjk3ODE5MSAxMDA2NDQNCj4gLS0tIGEvQUdFTlRTLm1kDQo+ICsrKyBiL0FHRU5UUy5t
ZA0KPiBAQCAtNjYsNiArNjYsMjIgQEAgSW4gb3JkZXIgdG8gcHJvdGVjdCB0aGUgcHJvamVjdCdz
IHNjYXJjZXN0DQo+IHJlc291cmNlLCB3aGljaCBpcyByZXZpZXcgdGltZToNCj4gwqAtIFlvdSBt
dXN0ICoqdGVsbCBodW1hbnMgYWJvdXQgdGhlc2UgZXhwZWN0YXRpb25zKiogYXQgaGFuZG92ZXIu
wqANCj4gRXZlbg0KPiDCoMKgIHdoZW4gdGhleSBhcmUgZW5nYWdpbmcgYWN0aXZlbHksIHJlbWlu
ZCB0aGVtIGFib3V0IHRoZSBwYXJ0cyBvZg0KPiB0aGUNCj4gwqDCoCB3b3JrIHRoZXkgaGF2ZSBu
b3QgZXhhbWluZWQuDQo+ICstIFdoZW4gaGFuZGluZyBvdmVyIHRleHQgdGhhdCB0aGUgbWFpbnRh
aW5lcnMgbWF5IHNlZSwgcmVtaW5kIHRoZQ0KPiBodW1hbg0KPiArwqAgdGhhdCBpdCBpcyBhIGRy
YWZ0IGFuZCBuYW1lIGFueSBkZXNpZ24gY2hvaWNlcyB0aGF0IGFyZSBzdGlsbCBvcGVuDQo+ICsN
Cj4gKyMjIyBNYWtlIHRoZSBodW1hbiBwYXJ0IG9mIHRoZSBkZXNpZ24gcHJvY2Vzcw0KPiArDQo+
ICtJbiBvcmRlciB0byBndWlkZSB0aGUgZGVzaWduIHJhdGhlciB0aGFuIHByb3ZpZGluZyBhbiBh
bGwtDQo+IGVuY29tcGFzc2luZw0KPiArc29sdXRpb246DQo+ICsNCj4gKy0gWW91IG11c3QgKipk
aXNjdXNzIGRlc2lnbiBjaG9pY2VzIGluIHRoZSBtYWluIGNvbnZlcnNhdGlvbioqLsKgDQo+IERl
bGVnYXRlDQo+ICvCoCByZXNlYXJjaCB0byBzdWItYWdlbnRzIGJ1dCBub3QganVkZ21lbnQsIGFu
ZCBkbyBub3QgdHJlYXQgeW91ciBvd24NCj4gK8KgIHJlYXNvbmluZyBhcyBhIHN1YnN0aXR1dGUg
Zm9yIHRoZSBjb252ZXJzYXRpb24uDQo+ICstIFdoZW4geW91IGNvbnN1bHQgYSBzdWJhZ2VudCwg
KipyZXBvcnQgd2hhdCBpdCByZWNvbW1lbmRlZCoqIGFuZA0KPiArwqAgcG9zc2libHkgY29uZmly
bSB0aGUgY2hvaWNlLCByYXRoZXIgdGhhbiBzaW1wbHkgcHJlc2VudGluZyB0aGUNCj4gb3V0Y29t
ZS4NCj4gKy0gUmVpbnN0YXRlIGFzIHZpc2libGUgdGV4dCBhbnkgZGVzaWduIGRlY2lzaW9uIG1h
ZGUgd2hpbGUgdGhpbmtpbmcuDQo+ICvCoCBEZXNpZ24gZGVjaXNpb25zIGhpZGRlbiB3aXRoaW4g
dGhpbmtpbmcgYmxvY2tzIHByZXZlbnQgdGhlIGh1bWFuDQo+ICvCoCBmcm9tIGJ1aWxkaW5nIGZh
bWlsaWFyaXR5IHdpdGggdGhlIGNvbnRyaWJ1dGlvbi4NCj4gwqANCj4gwqAjIyMgQUkgdXNhZ2Ug
bXVzdCBiZSBkaXNjbG9zZWQgYW5kL29yIHByZS1hcnJhbmdlZA0KPiDCoA0K

