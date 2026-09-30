Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154DCCA5FBE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBp40-0006rb-99; Wed, 30 Sep 2026 03:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBp3x-0006qi-9J; Wed, 30 Sep 2026 03:49:13 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xBp3u-0004tV-6w; Wed, 30 Sep 2026 03:49:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3ag5goU+TqfC3EIPi6zpM6GOiTuhoZ0Qx92cuXFlEl4yQ+/eeuf1MGQojwa7OsIcoDuakoEFtRNqh2cykNtcAPxvOwg67eGoVD0aRadMFOVEop32qwf/+M9q3+oFnVBN/XtajvA9RWlOBIfPdZngBetWd/OXQFBx+rSzOIOOEREgdjxOIv8tWMFcFJXexaQSHVCrl3VdEuU7ubbLDPKhFzXKnZm0eJBpmbqb07Mdv8EramZWXfO7v6AfXbSm8Gjhu5DOoVOQ4zrTt750riGl4bp1TFyJuGP30K+c2lNbVEke4txSwddyhVvTgkbo3kRi3AcNW1E0H2gpaQ9T+9TFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BI92GaD4lavK32+nBnolC32qoXBNycf09cjeZBzPbkw=;
 b=JV5i1hfxfYL+RaXB4T80jUeFmSQTYPLmg566IEmbbS2N37g7useZw86jIygAVytPfb4PBhQzMaV5U6rBKQx5raZGlq1/0QZt81W+PQKSbKRsm1efOdiwXBNdq29ttrLtBnOluilYcupKfLMexTl5+VrV8Es1z2avawwCf+4SbLhRd2kNQvcsF+n7PZ/iuwL1im7304C/8njoE0GRATN+3aza+uUCjD+NY0t6JgU0F/fk4d4rjrNcNUqNM41lF/+Oj8G2UoaTV0S6mh9h6XkbPHtGuwKzhyzQBkkBeaBYTAsCYoSRQgkW65nzQUVmzHdJsUMRJXcPGNaBQ4zzJbPrdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BI92GaD4lavK32+nBnolC32qoXBNycf09cjeZBzPbkw=;
 b=CotU8F+QunyUDYNn/Jvt6hnuflPW3cGLAyhl7ClMeERoeUdAfEzcsEyXgs384Pp4tjxeP3IDgTdmD8PSoR40/3aHZ2Q7ShcoAtWRxVOR84fdE//lBxquFXpa/k/H3E/ilnpelAfa6IAjwFFiWh8g14hZ4yjZZmM86XFC6L0wXoznidyURHwDve3OzxqpNPFdxmdJUCnhZyxk/uoP0fEfZbNrkrpOjwZVm2hEw8zFVTtQtTt1uA5fFwYggNpR5kr6eWij+knagKjUD2LXFL1J26j2Vr5VykFWnbJaOx7Sd92t1wz9iTp6oM3g5MFGAxi1dYjoSyRJvFStxw6VzNMbKg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB6202.apcprd06.prod.outlook.com (2603:1096:101:c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Wed, 30 Sep
 2026 07:48:58 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 07:48:58 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>, 
 "clg@redhat.com" <clg@redhat.com>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 00/19] hw/usb: Add a usbredir server transport and
 AST1030 UDC support
Thread-Topic: [PATCH v1 00/19] hw/usb: Add a usbredir server transport and
 AST1030 UDC support
Thread-Index: AQHdSnEERPamrUtxCUGTRaU5xPzZPrbmyiMQ
Date: Wed, 30 Sep 2026 07:48:58 +0000
Message-ID: <SEZPR06MB7362735328EE335AB120EC9CFC8B2@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB6202:EE_
x-ms-office365-filtering-correlation-id: 67b6fa0c-4aef-42e8-72c4-08df1ec748ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|22082099003|18002099003|3023799007|921020|38070700021|56012099006|260925021911599003|260925021311599003|260925022911599003|10067099003;
x-microsoft-antispam-message-info: n5+lkeE2Qm71LreJjRpkGTlb5g4L5IPmQtLEyK2B/2LKDWYsTSNStn6lkB2kRArF1Pw2OcoYZGmXLJCvLpRwrmGn6Zfq/JYZX6HhCioiIdU4xhzlDg6fTvFous73NtKciGoTJXqLMN1hPNZ1zbDKUH8QPqmd4Gj013Ngp5DDCO6PVZfp30aGQu4tiECLVZuXYd9DmlXQVkRsubl8VO8MkWbJZSgQLnTFNClAujlU9yAjyqc5VoAIsFFqbP3/H9tkSesU1NoEs0dmmbrG/bJvhk5vnE8X9hZRjJ1+i1Mt0EiIaxtlyn00gkPAD4YKECFRedCqXzvEfm20JuRV4mWdhqWNww/uBXcJuUP4hJIzrnz8pmCjmFnIMVvlVcPHdXh9wpBJ1rw1fbWktmfJ3kxYfCZeky1lwa0eK1UFJHWFFHPZNtrIv1//l0zrHl1OjKP5JtPOBguTPBBRyy/oNlvW5zl8KKXByshvlPtCRK/pWLjgqufSGSbQzIheJuouAiXLGMd0L1XQyeYDD545OmFQkWtW54bJ59GTDM+zPNl+U+ACwXc4yWE2WsrEyNqoqy+0JDPTbOG/x2GBacj2y1WD/9LZZ3Cffhi3AsiT+6lx3EYRWaEoKjm96xI9sE18UrMAhQKs67hlWauOxIwzCAf6p6BulucjVq7Ydd2cLsuHnqQlFASqB5e2z8sM6BDJXV3v
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(921020)(38070700021)(56012099006)(260925021911599003)(260925021311599003)(260925022911599003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Et1ll0D0DsDGK8sTBv+6dG2Xz+c3gRlmS1aK9jZQcM7q8ZuQfBoJqADWMu?=
 =?iso-8859-1?Q?uK9kjcxBuGaK4lhJ2XCgOVFuLbyhEWhSDOa7TVHTQWxIZ3TOKUcy1968cC?=
 =?iso-8859-1?Q?HTfqMtnVNmgCZUIjDwwNnWQA5ZFwZZj25lTag4vAVZ7b9XAmXLBUT3pFCx?=
 =?iso-8859-1?Q?uOBrQVASosw9Uobgrlvm9t9U26BFbtWPw3hHhix8/runSYy3eI2wTxwtUy?=
 =?iso-8859-1?Q?VQfzhFZxLji322Q6omBuDdZ5Krpt2uxlweI9BMptBWJ4B7KWbLqMNnEnn5?=
 =?iso-8859-1?Q?sWm2Qp2HhTTe0KyMoOfeSO98C8BeMvQScmsBEeDBbO/m4DZqZ6POd+SMl8?=
 =?iso-8859-1?Q?fdy1rI+Qv42+9rJlvTauR9QwchyS0XOddjFQIcltmyXyh0Q2yEISnO3jJu?=
 =?iso-8859-1?Q?PCe2vkrexjxGBLzVZkNksFY3oP1077oECMYK1oYm7OJapZZpaYsOxj/OuT?=
 =?iso-8859-1?Q?mtuEPO92rACqnKVNYx7Y3srkmTHxk9mKzV1gUzypm8Z0l3gMQauCsqD6Hz?=
 =?iso-8859-1?Q?5XuHZmm0PhufCF6H1xYsd6OgCw7p03L5tgotTI20Fyi9yWnpG7bNmXlKg8?=
 =?iso-8859-1?Q?y/l3XedISgvc+5b6++ofIZuUn0ziD9CmL1/BSzUZm07JJRXy29n1qV3Xlx?=
 =?iso-8859-1?Q?W4eUi41FCFKjprmSkEFk4BXUUiQjcLc1EgvbwCbCDjL65rnga3llSfTvY+?=
 =?iso-8859-1?Q?FCixsUVuPzdPuciBpWVwXC8Fte37QudwW/27Xar9+e/SGHzXwK+OREO09I?=
 =?iso-8859-1?Q?imEXuBHiE+82laKQEOUBY1O855KbqmiBukQShbWVmzSDA721ZOwqAaD95V?=
 =?iso-8859-1?Q?I23kklCWIc4JNGNCzQBiMNDhW48kwjW5l9e5gTN42V5VBBi02L0E64ipka?=
 =?iso-8859-1?Q?xi/R0g/5jrRKOI2F/mwlsF4hsGQxOqE7OZOSePC2Yoc197z/aVtiQmzHX6?=
 =?iso-8859-1?Q?eH058AFLp2qiOXE5ThE9UhtT9iUQnn59Qt7bmvJ0KghM+R4PyslJ9tXiK3?=
 =?iso-8859-1?Q?6LKB3tUJN5apxhRohPAsx06NWFo5/nGZkCO4CCZ3CxAD93GHxs4tIRN0PA?=
 =?iso-8859-1?Q?Ce3EBRh7/mLQS1dO7yG9Q6AbKoftsPDEbX0mXD1B8RjMMgU/sMOT3zxJiD?=
 =?iso-8859-1?Q?yRTQ5L2M7qceOBCLqGenBWGx3AjrR6ePlamlu2H7M52jIzozcTE76+fxo/?=
 =?iso-8859-1?Q?8HQ3r1zBLS8KSDEQlI/Nrpq3vbFlXip0g9UVAwKkEzQwHN9xGlOK8Qxdhj?=
 =?iso-8859-1?Q?4IEOs1OOCEFbbaepdfyh9aDa2arpQ4vWJCyl/Ss33PGRh74gY8sKBMwfbR?=
 =?iso-8859-1?Q?78JY9xHkX6DZGXzxEWuXcnnrMVa+immQZ0rqB8Ie3CxZXcwTEpW5ErdEBZ?=
 =?iso-8859-1?Q?LSY1fIH/AXWVlv1d8a4Bx4gJF1ILRenMqCglrxsyBqi52a5AGr1oGbhtRo?=
 =?iso-8859-1?Q?S2qUjcEChM86WOY/P49URq9A1pQmZUnspkovlQmQGkYnJDgpDu5dyMvtwa?=
 =?iso-8859-1?Q?PY5BgTgvTkK2XcftUWwGku49Zq8TqlQ21PLpWT4RCZMX99ylyTHLJfWolF?=
 =?iso-8859-1?Q?2I0fPLFCYLHDjQUGc9pBuXbJ2T4DTT8VKNZRZECOlEa52UkuULdogCzDpV?=
 =?iso-8859-1?Q?C3AjFfvbWI0SdH1LJnQhJBsaIOoXLzSyFXMnn8qMBXPKhpeByeUPFwIFdq?=
 =?iso-8859-1?Q?G4SHV3gEzecT25JZd5QE1Iy75Hk9GQrKM3wk11IegMZPtzc2nJTZWx3Qzi?=
 =?iso-8859-1?Q?Agp1JrZXsDZSOH2kDmHFOekLgqHAXQb8Xnfm1zea/26GhjW8uCV1owph44?=
 =?iso-8859-1?Q?DHyxwOIOzA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: V7V3qNQYsDl89xPle4ALVj2QCv7zwgph1XSK2wlEb3nBiBrSQ5DxVUPUK4Z9OYVg942GuLyeuEfPsG4bGHKwoBbHTtFk8a/00b/fPpP45C3myN6upZ22g/22lZDGbpbJJOI5So9b1cWMac1kLKRWUd38wic7nbkW8RIk2Dl28kOWRTYSyglEYdTdGCtLZ4Z4HTZrSji3P1QjDPS6+JQMrZ3HHColfZ+wBprEcOAovvGwI/MA2wKqRuVnhvcehj7/E5ITvwFKiFUZZCNA3liKaJpg2pSZBL98qZDnWSseRWaHeOFYBeXbwi0C6MxpjgXsrDIU3PzVn4GkpmGB3v5+LQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b6fa0c-4aef-42e8-72c4-08df1ec748ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 07:48:58.0985 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oqi91zMJEVMiItXEiVWqig7fi8v1fiWY2DlBLsA6p90ELf8msDjsZ9DI0f5nssC2CAODBvOdE6sJZb7igfKLWGslP8tQ73haydOU6HSnIo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6202
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

+ Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>
+ C=E9dric Le Goater <clg@redhat.com>

Thanks,
Jamin

> Subject: [PATCH v1 00/19] hw/usb: Add a usbredir server transport and
> AST1030 UDC support
>=20
> This series redirects a USB device emulated in one QEMU instance to a USB
> host controller emulated in another one, over the usbredir protocol, and =
uses it
> to bring up the ASPEED AST1030 USB Device Controller (UDC).
>=20
> It is the second step of a larger plan to model USB device-side support o=
n
> ASPEED BMC/BIC SoCs, which has three goals:
>=20
> 1. Model the ASPEED UDC (AST2600 / AST1030). The AST2600 also has USB
> host
>    (EHCI) controllers, so that work targets the AST2600 UDC: its gadget c=
an
>    be attached to the SoC's own EHCI bus, letting the guest enumerate its
>    own gadget and exercise the UDC end-to-end.  [Done]
>=20
> https://lore.kernel.org/qemu-devel/20260902021542.3194812-1-jamin_lin@as
> peedtech.com/
>=20
> 2. AST1030 UDC. The AST1030 has no USB host controller, so testing its UD=
C
>    needs a second QEMU instance. The UDC gadget is redirected out of the
>    guest with libusbredir and attached to another QEMU that runs a USB ho=
st
>    (a VMM, or an AST2600 / AST2700 guest).  [this series]
>=20
> 3. ASPEED vHub, as a longer-term goal towards BMC KVM / Virtual Media
>    support in QEMU.  [future]
>=20
> This series implements goal 2.
>=20
> The transport
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> usb-redir-server exports a locally emulated USB device to a remote USB ho=
st
> over the usbredir protocol, so a device emulated in one QEMU instance can=
 be
> enumerated by a host controller emulated in another one.
>=20
> The left column is a request going to the device. The right column is the
> answer coming back. The middle hop carries usbredir messages over a socke=
t.
> The top and bottom hops carry USBPackets inside QEMU.
>=20
>     remote QEMU: guest driver -> EHCI/XHCI
>              |                     ^
>    USBPacket |                     | USBPacket
>              v                     |
>     "usb-redir" (the client)
>              |                     ^
>     usbredir |   chardev socket    | usbredir
>              v                     |
>     usb-redir-server (the server, this series)
>              |                     ^
>    USBPacket |                     | USBPacket
>              v                     |
>     any USBDevice, "-device <dev>,bus=3D<id>.0"
>=20
> "usb-redir" (hw/usb/redirect.c) is the client:
>   - it takes a USBPacket from the remote guest and writes it to the socke=
t
>     as a usbredir message
>   - it reads the answer from the socket and completes the USBPacket
>=20
> usb-redir-server is the server. It does the same thing, but backwards:
>   - it reads a usbredir message from the socket and runs it as a USBPacke=
t
>     on the bus below
>   - it takes the result of that USBPacket and writes it back to the same
>     socket as a usbredir message, for the client to read
>=20
> A USB device has to sit on a USB bus, and in QEMU a USB bus is always mad=
e
> by a host controller. So usb-redir-server makes one and acts as the host
> controller on this side. It models no real chip: its cable is the chardev=
 socket.
> The real host is in the other QEMU.
>=20
> usbredir carries one device, not a bus. A hub cannot be exported: the pro=
tocol
> has no device address field. To export several devices, run one usb-redir=
-server
> per device, each with its own chardev.
>=20
> AST1030 gadget to an AST2700 host
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>         QEMU #1  -M ast1030-evb              QEMU #2  -M
> ast2700a2-evb
>   +-----------------------------+      +-----------------------------+
>   | Zephyr   usb_dc_aspeed      |      | Linux    ehci-platform
> |
>   +--------------+--------------+      +--------------+--------------+
>                  | MMIO                               | MMIO
>   +--------------v--------------+      +--------------v--------------+
>   | aspeed.udc                  |      | EHCI3        (usb-bus.3)
> |
>   +--------------+--------------+      +--------------+--------------+
>                  | USBPacket                          | USBPacket
>   +--------------v--------------+      +--------------v--------------+
>   | aspeed.udc-gadget           |      | usb-redir
> |
>   +--------------+--------------+      +--------------+--------------+
>                  | USBPacket                          |
>   +--------------v--------------+                     |
>   | usb-redir-server            |                     |
>   +--------------+--------------+                     |
>                  |                                    |
>                  +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D unix socket =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+
>                            usbredir protocol
>=20
> Testing
> =3D=3D=3D=3D=3D=3D=3D
>=20
> 1. AST1030 CDC-ACM gadget, enumerated by an AST2700 host
> --------------------------------------------------------
>=20
> The device side owns the socket and has to be started first.
>=20
>   $ qemu-system-arm -M ast1030-evb -nographic \
>         -kernel zephyr.bin \
>         -chardev socket,id=3Du,path=3D/tmp/usbredir.sock,server=3Don,wait=
=3Doff \
>         -device usb-redir-server,id=3Dudcredir,chardev=3Du \
>         -device aspeed.udc-gadget,bus=3Dudcredir.0,udc=3D/machine/soc/udc
>=20
>   uart:~$ usb enable
>   uart:~$ usb print 1
>=20
>   $ qemu-system-aarch64 -M ast2700a2-evb -nographic \
>         -drive file=3Dimage-bmc,if=3Dmtd,format=3Draw -snapshot \
>         -net nic -net user \
>         -chardev socket,id=3Dr,path=3D/tmp/usbredir.sock \
>         -device usb-redir,chardev=3Dr,bus=3Dusb-bus.3
>=20
>   root@ast2700-default:~# lsusb
>   Bus 001 Device 001: ID 1d6b:0002 Linux 6.18.36 ehci_hcd EHCI Host
> Controller
>   Bus 001 Device 002: ID 2245:1030 ZEPHYR Zephyr DFU sample
>=20
> Data was checked:
>=20
>   2700 -> 1030   echo '1234567890' > /dev/ttyACM0
>                  1030 console: Print Data: 0x31 0x32 ... 0x30
>=20
> 2. A plain usb-storage exported the same way
> --------------------------------------------
>=20
> Any USBDevice can be exported, not just the UDC gadget. The machine on th=
e
> exporting side is only a container for usb-redir-server, so it does not h=
ave to
> run anything.
>=20
>   $ qemu-system-arm -M ast2600-evb -nographic -serial null \
>         -chardev socket,id=3Du,path=3D/tmp/storage.sock,server=3Don,wait=
=3Doff \
>         -device usb-redir-server,id=3Dkeyredir,chardev=3Du \
>         -drive id=3Dusbdisk,if=3Dnone,file=3Ddisk.img,format=3Draw -snaps=
hot \
>         -device usb-storage,bus=3Dkeyredir.0,id=3Dmystorage,drive=3Dusbdi=
sk
>=20
>   $ qemu-system-aarch64 -M ast2700a2-evb -nographic \
>         -drive file=3Dimage-bmc,if=3Dmtd,format=3Draw -snapshot \
>         -net nic -net user \
>         -chardev socket,id=3Dr,path=3D/tmp/storage.sock \
>         -device usb-redir,chardev=3Dr,bus=3Dusb-bus.3
>=20
>   root@ast2700-default:~# lsusb
>   Bus 001 Device 001: ID 1d6b:0002 Linux 6.18.36 ehci_hcd EHCI Host
> Controller
>   Bus 001 Device 002: ID 46f4:0001 QEMU QEMU USB HARDDRIVE
>=20
>   root@ast2700-default:~# mount /dev/sda /mnt/usb
>   MOUNTED
>=20
>   A 4 MiB file was written, unmounted and remounted, and the sha256
>   matched.
>=20
> v1
>  1. Add a usbredir server transport
>     1. Add a usbredir server device
>     2. Announce the exported device
>     3. Implement control transfers
>     4. Implement bulk and interrupt transfers
>     5. Stream interrupt IN endpoints
>  2. ASPEED UDC
>     1. Make the SETUP buffer byte addressable
>     2. Support single-stage IN transfers
>     3. Clear EP_POOL_ACK when no endpoint ack is left
>     4. Mask the reserved bits on register writes
>     5. Use the endpoint max packet size for OUT transfers
>     6. Test the usbredir server transport
>     7. Add the USB device controller for AST1030
>=20
> Jamin Lin (19):
>   hw/usb/bus: Let a bus opt out of automatic hub insertion
>   hw/usb/redirect-server: Add a usbredir server device
>   hw/usb/redirect-server: Connect usbredirparser to a chardev
>   hw/usb/redirect-server: Announce the exported device
>   hw/usb/redirect-server: Implement control transfers
>   hw/usb/redirect-server: Implement bulk and interrupt transfers
>   hw/usb/redirect-server: Stream interrupt IN endpoints
>   hw/arm/aspeed: Enable the usbredir server transport
>   hw/usb/aspeed-udc: Make the SETUP buffer byte addressable
>   hw/usb/aspeed-udc: Mask the reserved bits on register writes
>   hw/usb/aspeed-udc: Clear EP_POOL_ACK when no endpoint ack is left
>   hw/usb/aspeed-udc: Rename the transfer helpers after their DMA mode
>   hw/usb/aspeed-udc: Store the EP_DMA_STS write first
>   hw/usb/aspeed-udc: Pick the EP_DMA_STS path by direction
>   hw/usb/aspeed-udc: Support single-stage IN transfers
>   hw/usb/aspeed-udc: Use the endpoint max packet size for OUT transfers
>   hw/usb/aspeed-udc: Add trace events for the transfer paths
>   hw/arm/aspeed_ast10x0: Add the USB device controller
>   tests/functional/arm/test_aspeed_ast1030: Test the usbredir server
>     transport
>=20
>  include/hw/arm/aspeed_soc.h                 |    1 +
>  include/hw/usb/aspeed-udc.h                 |   13 +-
>  include/hw/usb/redirect-server.h            |  116 ++
>  include/hw/usb/usb.h                        |    1 +
>  hw/arm/aspeed.c                             |    6 +
>  hw/arm/aspeed_ast10x0.c                     |   17 +-
>  hw/usb/aspeed-udc.c                         |  290 +++-
>  hw/usb/bus.c                                |    3 +-
>  hw/usb/redirect-server.c                    | 1604
> +++++++++++++++++++
>  hw/usb/meson.build                          |    3 +-
>  hw/usb/trace-events                         |   36 +
>  tests/functional/arm/meson.build            |    1 +
>  tests/functional/arm/test_aspeed_ast1030.py |   52 +
>  13 files changed, 2088 insertions(+), 55 deletions(-)  create mode 10064=
4
> include/hw/usb/redirect-server.h  create mode 100644
> hw/usb/redirect-server.c
>=20
> --
> 2.53.0

