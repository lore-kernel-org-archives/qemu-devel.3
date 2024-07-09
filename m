Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5175C3DA47
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 01:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQzd9-0004Yc-0f; Mon, 08 Jul 2024 21:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peng.fan@nxp.com>) id 1sQzd5-0004XF-LG
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 21:26:51 -0400
Received: from mail-westeuropeazon11010048.outbound.protection.outlook.com
 ([52.101.69.48] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peng.fan@nxp.com>) id 1sQzd2-0006ci-7i
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 21:26:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLT0BW7XGaqXtLdHDkflZIIpX9DaeLKFMzaDq0O9sPKJJ77934ghcHuxLX+4hz/oR/hWtSI/ZmawSYkU5JuDLMTUyS0kcJCcl95Dz6Xs3sxAdyg6ZLC3QIEmkuFXzhXRfupfCtDH2pzZH2SmO8x67zeovZivNxzdvnIU5V/NxSDhdBAalCkpw14vU0ilhxUNyyM9ArYrQoIv+j9gmIH/ZrULSUFppkMP5+Hldx4SySyPdRDrm6yjbtyeV8G3unN7x/jwjaf+39o6labVKTIQhlLCw4neRJpevfAlBFO8amAO+PDYi10HbGmE8l5Gur5XH8YGannaP1tQ3xbfr05lRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWr9XteO27XMjnyfHA40GDDpIWSwS3KfNRNQe1auBKA=;
 b=UtOnf2Z89dST1Jq1YjIFOwIe1lppdZFsoiDC+1i4nHtncjjfOytP4UTrX1YE09ikJctzsYdI9/Pucf5nbdcIwTFJqK6Ly0obt5NKsLe07v5dCaPw2rPZ0POg05Vv3Tt6H85KLi6JFUt67twMm5628f8lqqZkDp4rDN2Wc/4sVvIzbBEw4bKtomu31RKtZwoJ1l5f2qFLV5V8+SIonoxyMo9kL9JLg6XpGe7y2m06OrIf/xUU+D3yKjOHAURyqguQoe2q1g48ebxy+b161ifLZmCqNhA1VlX1i8Ia4r3+fuxXVmKSiWm851vyiI3iLkdXceMWgonkoN0J9mlAqTzvxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWr9XteO27XMjnyfHA40GDDpIWSwS3KfNRNQe1auBKA=;
 b=DaK85QcoUqQxPzfUjKgakn745EgG5nHTOn8SISI6ATekRQK0SpuFVSFyQPD3tYoJEDDI+D64/aSP9YTFkLVpww5g7i6fVmHmQWtcPCn1qOpUrFMDt6v2qBoIFTvMhgrIL/u1Q01ElQqMrtSXKG5PH4LKa0KKvwY/U6Wcjc9M4Vc=
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7520.eurprd04.prod.outlook.com (2603:10a6:102:e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.37; Tue, 9 Jul
 2024 01:21:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 01:21:41 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Stefano Stabellini <sstabellini@kernel.org>
CC: "stefano.stabellini@amd.com" <stefano.stabellini@amd.com>, Viresh Kumar
 <viresh.kumar@linaro.org>, Julien Grall <julien@xen.org>,
 "oleksandr_tyshchenko@epam.com" <oleksandr_tyshchenko@epam.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "edgar.iglesias@amd.com"
 <edgar.iglesias@amd.com>
Subject: RE: Question: xen + vhost user
Thread-Topic: Question: xen + vhost user
Thread-Index: AdrK7E1vVcASzE7XRqm0wkYJXBBDZgGm4hwAAAWbpxA=
Date: Tue, 9 Jul 2024 01:21:41 +0000
Message-ID: <PAXPR04MB84590D6686BEA38D07E5700388DB2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <AM6PR04MB59412237BA10A23EB79D5C0E88D22@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <alpine.DEB.2.22.394.2407081539380.3635@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2407081539380.3635@ubuntu-linux-20-04-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA4PR04MB7520:EE_
x-ms-office365-filtering-correlation-id: 15ee2e2a-b06d-48a0-2e7b-08dc9fb57d2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lBz5IIirD/sVD9keMwy90ycf1oz5SELKDaA0p3r/7oRyqN5LEmLbJxrVYLjp?=
 =?us-ascii?Q?INWi2LAT+azWfqu6fJSEHjFdUCiVwOB2SznooNtKB6xbuP9HPs9SU6dGiDdr?=
 =?us-ascii?Q?vmFuB/7S3KUeewo5Ub/7bc0riudkGQpuS7Cxyx4BIb2FtjfEOSlrXgwSwcIm?=
 =?us-ascii?Q?56sP2uywKfeaO86WeKUHhTjqApihoDxHpb3tkvqK4q67wvuMoO1ZoxxNbb0w?=
 =?us-ascii?Q?WGi8ih2RwmCLjjIw4e4jnLmwnVJ5rg6bh5+Q3brT4uusBKY4TCX0vp4B+lsQ?=
 =?us-ascii?Q?5ygeUHWGeMc40xeh0iadwW/TRbo2M936TWp3p9tRXcs6Y0g9P6pm2HvHJuW0?=
 =?us-ascii?Q?2eM6xpmhm77EPcUGGlx896BPoDVzBw03Yoh0ee6UHzGSqYTvusCR82ajAp6a?=
 =?us-ascii?Q?T8T65Ccr/fGqct2UPMayTDAUFMCZolMYUztlqTNdSYOVbWp6oQTANPsXwUqc?=
 =?us-ascii?Q?MY5dI3tezIlpL7aE9BiH+fOVKX3et0ZR4j6HG0rRzeawQdh/MzQi1ZpsCce0?=
 =?us-ascii?Q?iLSW/DK4BOA/AbGJ7uW3TYpOFJ5X6AYV7XWrwd8rqASh1Fm3n3/c74pF86k+?=
 =?us-ascii?Q?OBS1e1ZYk9jk3RlR0WTzwjODzHMVQrYEk36sycNgDJ+adx7asYTwTq2ATYkq?=
 =?us-ascii?Q?go/CIxwX/3l3zaNzUGjb1YoUPPquRDuVJmW25etuVhf/uT92NJE46F0CexzD?=
 =?us-ascii?Q?lBOsShc2xI6IIw0VyjCVOig4fJng9WqMF0JaxfOn6KhbLqoI3A8HP6fGg0EQ?=
 =?us-ascii?Q?ZhUbgzsA/Al4fICfhkXB3g5yqcoV2IvTbVjyfVI2AEPP8G2zA45nhVBkBppy?=
 =?us-ascii?Q?em0Z0tjmfeDUhyHg8/1rT/EtsdN/wG10pMMc0l6Oy031/JVhBjfGtNl5oYmg?=
 =?us-ascii?Q?rqIVKWnlUrYcj8Wc6pmu8Mr4v5SHBvadfJyaMIYixQTGCWP1EqB8KlDJ45g3?=
 =?us-ascii?Q?d88lNjrU/W8/wuCUa0eWEhPUyVSgjFLKPPfptvgxVmqRE0HNqpUlvUeMyNb0?=
 =?us-ascii?Q?yGUb9PrUIJ2SU7onnQ0McEAqArNkvubAX+4ohrHzpRGx8vmv7IZzNUr32hy2?=
 =?us-ascii?Q?WCzQxyCFco2OzUM0OexkTZ4Df68guv9KOyqVH9FpMOsYIV7M4CGgabW3XDxB?=
 =?us-ascii?Q?HBE+b8pm+gkmE9EmpDtnls5BckEvDzLmyetYKNvKY/VjkgAffR7UXANCnOSy?=
 =?us-ascii?Q?FkEJKC81gOoUcvqXCF8XFQc3IMLAGkMSDOqJw7y1pOntCAFAeF+/zN9mJXPJ?=
 =?us-ascii?Q?nGMpSSVd6sg8qDw3+PChAj/e8J1kxfixV/MDkq7dCwLrksbV2y2q1adIq6FI?=
 =?us-ascii?Q?Zn7mIZnN3gtR5kgU244qjWANwGq8KAoDAaUtFZ5dZ11KW/kW2H3UceLI6ax9?=
 =?us-ascii?Q?VTlwar08KX+ASePT0RkKBwP7vAaXNh2pv7AZfjedaG2/R1V3eQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wgbDiZCr1u17co8PiAsMJq7qpZxC8YVICHzdX67o5PyOTeu5H17qr4i0MFF4?=
 =?us-ascii?Q?KuQVfvzPT/KCR8xH2f/L/WJgQHygaXw19OtSvf9uGRNE5x9huAtew57msINA?=
 =?us-ascii?Q?GnpAY578joYNTNeGsxlE/x6Rso0MRwItw9s1JR0JAR4tQw7SuZVcLeiOAUIs?=
 =?us-ascii?Q?P4rV9KIe9xTd2keboUPBLtDMlXHbemWFc4lF89+x/uHgcdOKDuEAmedkCKy9?=
 =?us-ascii?Q?ncTj11RBnBfT47IpR9hLIvwXs9tZAoEL58rnD+8X07W1oKJeVEMQhsg3RRaO?=
 =?us-ascii?Q?6psG1AUArHZVKg2KyDzZzeJ4mvguPOSdFaSNLIHMfAXzyCxrp2lXlRJ/5z07?=
 =?us-ascii?Q?isJOjXoc6MxpWvYPTKC25ygX/MJci0dzOKQfDAn2Pzdpja4eQzy1ttBxtt1Q?=
 =?us-ascii?Q?8e7L1w/AMyP0kzcc/Y8Kb3gu33UjtJOpN7XHhzSjwt1OzkGz0u86vox5ZH1b?=
 =?us-ascii?Q?EyBah5qwegubmKRdsU22/wPaVe0mduSYLU3EQ8Aqyk/Ag35+bNinRW+vFeja?=
 =?us-ascii?Q?LXg9L5kh88w5HD0Ja9DL/GKgQmeN2DOk+Jo9nC4EK6atdlADpsiPHNe//Z6K?=
 =?us-ascii?Q?dEcRwbRoAlYECmwMnT5wO4wUsrmV8UqmEmd1RcWgBTMH/bXlsDXeEQPdpi1i?=
 =?us-ascii?Q?hLhzAzBAfE4SfTvVNKwBJHdES85/JD8FZaphymyld0s6ed+HS+WXrW+xYRuX?=
 =?us-ascii?Q?sBVsxTDDKi7IDFSTZatK19IsJ7AfK4lTzn1HitZBcyrHtkDy2o1s3GEcOplP?=
 =?us-ascii?Q?VspjHweCzmnnDkqsNILtNHWLiavos1Oid/sD60movhUJ8hvg9yWHmiCWzMQZ?=
 =?us-ascii?Q?AoF/xWepWZWZSaXTsuMJ6yJkGmONIbzaMjO7UQwBdZvnpWjIsYJHZxadzM5y?=
 =?us-ascii?Q?VsMmjRPgCS/4YvFF/7aWllIvB/dy1vZdTJIcb/WlaQcVYofrx2jciI+wxLd7?=
 =?us-ascii?Q?FqFxWo6hecLN3BPWh5m1Bh250gazKDjcye2ueRLIosQbYQh4VanoGrPhFjcp?=
 =?us-ascii?Q?bs5pIpczkbLXLSPUSpgH8vkTXYRtQ2jkUQbfBQLL6Psi1EKpYttEp+JNGdUH?=
 =?us-ascii?Q?OGcb5F9lym4P6oI+KwPArFCXEM5JAZMSQwv+Mj/epoPVUpWporfjUXPMtwdH?=
 =?us-ascii?Q?5QGG6QMrPOZtzdaIlbZbIpd1KtvIvv5K1F/2Fht+R3K0R88RDfzEHJdyGDB3?=
 =?us-ascii?Q?xcu+e/rJ878/l7CdXc0dXccc+Q81JPRIbn6lTGWUQ/ReR7O68CeFYTs9rB8Z?=
 =?us-ascii?Q?amPZXFtBW1yTt9VH3B9i0vBSUeCLrLZapoBcAb23uOAjQHHGbhD00d/TQKCS?=
 =?us-ascii?Q?kDObn9KoE1FAHvjLYKgKti7se/a1Ir2epOaqB6GcO6QV8q9ngmosULMfcVXF?=
 =?us-ascii?Q?yVFAuR42lU4ZssogspjL1QtRlOMsA4F29RcE4n3iuw4A8gc2BNuCKM0QW91H?=
 =?us-ascii?Q?Vz+3R5PbqxPbMIS7+rY3mkafqMpEPaJrbaiQ5pvVQeGS90TVYYllmlFTSl8B?=
 =?us-ascii?Q?hAs0nqjoodkyc7g5m8JimPzB6WF6n2mGxphy5Rual2uDL7RSpn48xTC0z/cG?=
 =?us-ascii?Q?wFJ+Z/O3ZL73bs7ABEE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ee2e2a-b06d-48a0-2e7b-08dc9fb57d2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 01:21:41.7783 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/mmN+jFk4Gm0OoKZX3da/Y98bq/PH9kveMTMUs1Po5D42v25+P4+Me97w7XokYhm8943/bzsYdgxHWX+bxvmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7520
Received-SPF: pass client-ip=52.101.69.48; envelope-from=peng.fan@nxp.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Subject: Re: Question: xen + vhost user
>=20
> +Edgar
>=20
> I don't think we are using vhost-user so I am unable to help, but adding
> Edgar just in case

Thanks, just an update, it works after some code changes to Qemu.

Thanks,
Peng.

>=20
> On Sun, 30 Jun 2024, Peng Fan wrote:
> > Hi All,
> >
> > I am trying to enable vhost user input with xen hypervisor on i.MX95,
> > using qemu vhost-user-input. But meet " Invalid vring_addr message
> ". My xen domu cfg:
> >
> > '-chardev', 'socket,path=3D/tmp/input.sock,id=3Dmouse0',
> > '-device', 'vhost-user-input-pci,chardev=3Dmouse0',
> >
> > Anyone knows what missing?
> >
> > Partial error log:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_VRING_ADDR (9)
> > Flags:   0x1
> > Size:    40
> > vhost_vring_addr:
> >     index:  0
> >     flags:  0
> >     desc_user_addr:   0x0000ffff889b0000
> >     used_user_addr:   0x0000ffff889b04c0
> >     avail_user_addr:  0x0000ffff889b0400
> >     log_guest_addr:   0x00000000444714c0
> > Setting virtq addresses:
> >     vring_desc  at (nil)
> >     vring_used  at (nil)
> >     vring_avail at (nil)
> >
> > ** (vhost-user-input:1816): CRITICAL **: 07:20:46.077: Invalid
> > vring_addr message
> >
> > Thanks,
> > Peng.
> >
> > The full vhost user debug log:
> > ./vhost-user-input --socket-path=3D/tmp/input.sock --evdev-path=3D/d
> > -path=3D/dev/input/event1 ./vhost-user-input
> > --socket-path=3D/tmp/input.sock --evdev- =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D Vhost
> user
> > message =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_FEATURES (1)
> > Flags:   0x1
> > Size:    0
> > Sending back to guest u64: 0x0000000175000000
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost
> > user message =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_PROTOCOL_FEATURES (15)
> > Flags:   0x1
> > Size:    0
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_PROTOCOL_FEATURES (16)
> > Flags:   0x1
> > Size:    8
> > u64: 0x0000000000008e2b
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_QUEUE_NUM (17)
> > Flags:   0x1
> > Size:    0
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_MAX_MEM_SLOTS (36)
> > Flags:   0x1
> > Size:    0
> > u64: 0x0000000000000020
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_BACKEND_REQ_FD (21)
> > Flags:   0x9
> > Size:    0
> > Fds: 6
> > Got backend_fd: 6
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_OWNER (3)
> > Flags:   0x1
> > Size:    0
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_FEATURES (1)
> > Flags:   0x1
> > Size:    0
> > Sending back to guest u64: 0x0000000175000000
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost
> > user message =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_VRING_CALL (13)
> > Flags:   0x1
> > Size:    8
> > Fds: 7
> > u64: 0x0000000000000000
> > Got call_fd: 7 for vq: 0
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_VRING_ERR (14)
> > Flags:   0x1
> > Size:    8
> > Fds: 8
> > u64: 0x0000000000000000
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_VRING_CALL (13)
> > Flags:   0x1
> > Size:    8
> > Fds: 9
> > u64: 0x0000000000000001
> > Got call_fd: 9 for vq: 1
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_VRING_ERR (14)
> > Flags:   0x1
> > Size:    8
> > Fds: 10
> > u64: 0x0000000000000001
> > (XEN) d2v0 Unhandled SMC/HVC: 0x84000050
> > (XEN) d2v0 Unhandled SMC/HVC: 0x8600ff01
> > (XEN) d2v0: vGICD: RAZ on reserved register offset 0x00000c
> > (XEN) d2v0: vGICD: unhandled word write 0x000000ffffffff to
> ICACTIVER4
> > (XEN) d2v0: vGICR: SGI: unhandled word write 0x000000ffffffff to
> > ICACTIVER0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user =
message
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_CONFIG (25)
> > Flags:   0x9
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_GET_CONFIG (24)
> > Flags:   0x1
> > Size:    148
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_FEATURES (2)
> > Flags:   0x1
> > Size:    8
> > u64: 0x0000010170000000
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_VRING_NUM (8)
> > Flags:   0x1
> > Size:    8
> > State.index: 0
> > State.num:   64
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_VRING_BASE (10)
> > Flags:   0x1
> > Size:    8
> > State.index: 0
> > State.num:   0
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Request: VHOST_USER_SET_VRING_ADDR (9)
> > Flags:   0x1
> > Size:    40
> > vhost_vring_addr:
> >     index:  0
> >     flags:  0
> >     desc_user_addr:   0x0000ffff889b0000
> >     used_user_addr:   0x0000ffff889b04c0
> >     avail_user_addr:  0x0000ffff889b0400
> >     log_guest_addr:   0x00000000444714c0
> > Setting virtq addresses:
> >     vring_desc  at (nil)
> >     vring_used  at (nil)
> >     vring_avail at (nil)
> >
> > ** (vhost-user-input:1816): CRITICAL **: 07:20:46.077: Invalid
> > vring_addr message
> >
> > root@imx95evk:~#
> >

