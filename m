Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB62C27C6E
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 03:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHbBk-0000RK-KB; Wed, 12 Jun 2024 23:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peng.fan@nxp.com>) id 1sHbBj-0000R4-Ft
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 23:31:47 -0400
Received: from mail-he1eur01on2072.outbound.protection.outlook.com
 ([40.107.13.72] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peng.fan@nxp.com>) id 1sHbBh-0003Ov-PO
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 23:31:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I78kO4uOJlrwGBPuzZ9Td3qMAmcR87iFRGHPvv2Vlijsptz7+tChRONXxukWzxwV4NlxerMEs8JWl0UAWtkyATjY5HendD932igfyJFJ1m4+/6xoHzcOVsow2qDlIqHmUjZc3J1fFS+qWJV9be/pKS7jmmLIJCKgwQBYsNKKJXgJzqXUYDE3op+CIagk+vUr2rosEIN5a8AIHavBbSA2b1m7d/lLOi7uewpkHYDNi7LCzzZUVeiGR+F0h6Xa4rtmCZQ1rXa965xn6vdPT3C8W1qIgwebfCLfjk3qK7zHz5/kEszJaqEV3ekII7HI8m29N81wOGDrF9BJA6H7w5jb6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/3cTSpEA1IAhHwkeUvMORs7G55jmLGwxAmzi3DQrDQ=;
 b=F13yepytOtJh/t62Wa4uJzT73DyRxpxqladldYgMPRLHAYWPZoNfGjkMkMe12WPL2z05wD62j+n5PG/b0qquJzYEfKubJbczzdZdhhjoWJ3ucTgoMIVkgXuA2GFmUjO8BEsTRv57nemqP9KUqrmlrf3VLL2Y+kWUajsDVYO9T83ZzCM1j6tiu/TymST5EUA+QMIBpAqoH/i21k92fYFHkE020gONDJYE2Xq1p2hobrhVjqt4que0URPQlbCtJLaeetV+BYJJuXh8T/qh5TZYLP0R0y6sEar6E2uGH6y0BDQAbKbX4Z1kdz5i3MiFXpZmSxJxB5miaZ40AtTbRrsxDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/3cTSpEA1IAhHwkeUvMORs7G55jmLGwxAmzi3DQrDQ=;
 b=sxx2X0QMV4tXb70xMpkuDxbcMtYTKYd00oqxmHGLUXP5cD1oUjMmaGBL18yf6MIL0alAJBpnUy/5H5hIHKVjqQ2O2+d5k4wxqen3pDvZ7dwbDQQfy1zTU1u94NI2/6WWGrv+98Qeo0QHcTb+VuiVdFTqXg16oBcZ/93q/r7JhLM=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 13 Jun
 2024 03:26:39 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 03:26:39 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "stefanha@redhat.com" <stefanha@redhat.com>
Subject: Qemu License question
Thread-Topic: Qemu License question
Thread-Index: Adq9QX7lF9lk8P0xRz+2PWgCJu+f7Q==
Date: Thu, 13 Jun 2024 03:26:39 +0000
Message-ID: <AM6PR04MB5941BDF756878B3CA208D07D88C12@AM6PR04MB5941.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|PAXPR04MB8510:EE_
x-ms-office365-filtering-correlation-id: 95cd5d0d-4709-4a54-d4ce-08dc8b58a345
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info: =?us-ascii?Q?YZQiKWa5QKtJL6JCL0RHnbB3vpm8b1Y6NVlbQSTpQfqwLdIQQRtTgsA2/LwC?=
 =?us-ascii?Q?c4H1cMw6v4QaPhcK4yDahaGBjh627wepBLcgyn/6h1qaB5X/amVOp1XYS7cr?=
 =?us-ascii?Q?nTVhkOO26mwsG1a4sPb8AW9Pnpvto9/3ZH+gtYsOm+zAeZ2/8/i0BtVBuqRo?=
 =?us-ascii?Q?z+wtOXrXIbjrI+bzGwoENTCDpZn7EDiSGYPBlTw/C6gFK7jdnmcuTF2uIMxv?=
 =?us-ascii?Q?T7qrAGGbKDXcJ1Ip+V282XLtexmJuxX5ZJO4hWDsYKR/LmUcvxWB9LAgNhRn?=
 =?us-ascii?Q?ktUVpxqqVXvEyGuFbfYDp0JHWyKFpSQs9H8PhIGaqyj5zBS2wQP+mjXCSlGj?=
 =?us-ascii?Q?XIUhj7CqAFss0Vv8rkyxm5mEBqzqNwUpJi1exIJvEBEosPRykDHyscPluiOu?=
 =?us-ascii?Q?mLHJWoNB4KZb39Mzs66qiVaLc78bB3QBjFGvbVPz0E12NcPs6oYZe907ZtSG?=
 =?us-ascii?Q?t87VTlUXzNyfw64kVb04yBEnFQWaPPv/xBiN4cQori36utu2bZm7p638OEyW?=
 =?us-ascii?Q?az+D6uRK3xIJa3fnmv38GMxAMUTB8Ij/TSUQJcHf7PchGPEKSGOAn829HiXa?=
 =?us-ascii?Q?h0T5uiy80glYDj6AjVJibyXEf2BwAZ0ygJnUoFCayHq7NuqmxYe+dTfM4X8H?=
 =?us-ascii?Q?MGRtwySSoahV1lFH7hC804AL4BiYecHhSzz9vaRuwrskVUJwVX9EwarsVHBO?=
 =?us-ascii?Q?EhJoy9OUSNlTo8eaIfNIp0oTlV+N+AhdLf/tMDehJy3obOhG7mhDc+OCvKXy?=
 =?us-ascii?Q?95e/tijql6aVdpYezWTyL8bB/YbX0Bo4t5PEqK7XtH4UZvZ1TV7kWurRTINf?=
 =?us-ascii?Q?5O5TyfDcS03NWSo0g2uUpz92mwX/FuhOFmV9TE2ouwTLPfa251HSHlJIpVRD?=
 =?us-ascii?Q?ZKSjq5C6fYjU/p/ckWVI7S1PIAA+DLuCSUnnaiS59ZehxH1AU76cULsLZwFL?=
 =?us-ascii?Q?SqQvBpqy1ROspNaf7psV2zUP3usZD/frhRQhcIjyw2dibijqOrxwHSALLYtG?=
 =?us-ascii?Q?INexCYO4QX/tr4SX0GN1KXarnLu+vzyazZ7vyfBqmNINISR0bmYUDFqLo0zU?=
 =?us-ascii?Q?LCThb2cSn9sfbVqsD4gyb39vS0+e9CWfyymhHaFChcKaM2uLR4azUUEO7Ook?=
 =?us-ascii?Q?+QkNiHDncON4uEKLEK4VbPe6ZODNTaSRiQ+2HwPkoY9SlJrnL1NRxPB2hpHb?=
 =?us-ascii?Q?zhVMHFkDI7M27c9DLasm6eNn3zmxnDquxDaLzvpv2EHYvI6DsKi3qTJzCPPp?=
 =?us-ascii?Q?hwddcVnMViK1d+vBYdLBkrR+/FEWhNQ6mzpNjn6u0PI19+6+pYXr/ObLY19I?=
 =?us-ascii?Q?2MGiopebu7z9NkDvH3KaYkSBsvDFEg90l6YqAYn3exHL9eCkBd15NtBH9JNt?=
 =?us-ascii?Q?T1P+d+s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB5941.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(366010)(38070700012); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3FKMfjKgGNnjHkPLz9va+3MgfujpWkag0Ex7GJiGUBoKwgpM8FWs/Riz6qjd?=
 =?us-ascii?Q?TNX4kDB5CxWYJOLd81/sAlBOqNctp7y0wUYBe3xA74OL8CYJFn0mZXs77g1g?=
 =?us-ascii?Q?0O5+/lfi4KidyXXrV1agLEpr2ZO7jPT+XeUpvkS8Tm4XwAmwS7PxAdVyM4mU?=
 =?us-ascii?Q?+VD8rmlvOixWwpl4Mw2/Uuys41FHkQtG4mjnX7a+3F0K9nRtZe+fMWMzWYFy?=
 =?us-ascii?Q?+ffbnBa8dugxwvegBbmOwuj7pPvSVgkuJNjOjBFslNhphtHZVCX77FK6bcv6?=
 =?us-ascii?Q?zEz3aSTqFNXqXYr60ZkAgHixLysgIMnCXrjAVzcOF8UbhZrUYA6edrTTVoYE?=
 =?us-ascii?Q?f/x3yWa8/n2rdNbKQWsJQettPLIEL+sLLyMX9hP8ydyjpVC1LVR53sDYVxfX?=
 =?us-ascii?Q?ELzEJ/YwSt/XgjS5o92SmefQy5j66aUISrufY25oJbTYG66BHRlipxpaHMXw?=
 =?us-ascii?Q?nBdqKoSDEwe17RYA5sZ2pgbcCAZAxaASVIzM9lB9GJEvWqUntYNpcZdisGoe?=
 =?us-ascii?Q?DkEYe8MmGmGT1uDQLkiTCdrQPGb33RLgYtK1b8qemwW/9SYNs3KPEm1Kqp1w?=
 =?us-ascii?Q?niUK/Dno5qivoT3dFbHlcheBcNAjDW7llCNKjAi8Oj4imCwfAMDQlQx2PJrQ?=
 =?us-ascii?Q?dEUu0usksOISQJnBDor5hiZCuzL5HHOmROOM7iXUz3/Vca7XfWMjh6lqsqaI?=
 =?us-ascii?Q?XAC7/81lxgmNNnvKS24oCvHIVgbaibid00srVmp7uJZkf4MWDk2VXCVr7TiS?=
 =?us-ascii?Q?T2j1+Sm1tGnnIzsJIvaD+TTsXHT9xYxS0t1QMxdqbQLY7syA69ENC5sDjX0B?=
 =?us-ascii?Q?MlCxVU/uALqDIU0Y/LamzAkISdBF6/CRdEZoqOq4skoR1cEhzLHS2mIXbc3P?=
 =?us-ascii?Q?p1uI+iTFHBA2B2nVh+1WS9Y8y8Nuihn2y9owdLbXJnwN2AVR5bqIeTJaBnQK?=
 =?us-ascii?Q?z0z6c045XE63ek+81DItW7rARyVLEwX8fKVF6/LHXNs34EJsVRhn8JQCjzum?=
 =?us-ascii?Q?C4wRpEnjX30P7W/xWa9CFAodxWsNtKqqUyh/m0xbeOwZlFUQ1uxzV2yklRbP?=
 =?us-ascii?Q?wyVGlO/qByL5ezy1a4SY2ng5Wd/29dJQwAmhZM3mXYFFdCzIILIAKjE2N01R?=
 =?us-ascii?Q?S82VRm8tfpVqt75i4ZfCj3jN4KiNh7evPaLWJaOdM8Ack/IPYHXmMdgT2tDI?=
 =?us-ascii?Q?yHDB+gu+olF+sMooU3k0WQhdBWTEWjwrKceOvfzwFZKLLWLDZBuGQxP3C58E?=
 =?us-ascii?Q?1kCxZLsy7VxP/AtUUeKzC/fWwQ5qU5p/rNESZCdl+wvrAOdsx+UtZhkKvgh4?=
 =?us-ascii?Q?znswWCg+A3fPvt5/LBD5x+1Xul7CadBchtZYdtjdOAdiJqAw31pXvkboxDDw?=
 =?us-ascii?Q?G6wKZXTK+CkRn+h2nt1SvTZYu6dJ4vA4B49ZOTaQT3Rxq0b6bQFlZDa6fXQP?=
 =?us-ascii?Q?mFn3FFjCWWOsl2EdAhUa5agiLRmFRhArp6nNM4JdLKGnqaogJc6VardBwu7n?=
 =?us-ascii?Q?gcqNotnuJMgLPIgniesybPmxOoMTHkDngTvJsSph8XQhokPgoJiBNCMWke3V?=
 =?us-ascii?Q?pVhKKCtzzmv+Ax4Xrzw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cd5d0d-4709-4a54-d4ce-08dc8b58a345
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 03:26:39.1820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XjU6WjwzHYLqzE3GKTM1RLy+CERW2xhqLZViMlTVhi80d4qsHbae9W4MRCIqfvEaTDxG4i+UVVN2TqoBOKJAyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8510
Received-SPF: pass client-ip=40.107.13.72; envelope-from=peng.fan@nxp.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi All,

The following files are marked as GPL-3.0-or-later. Will these
Conflict with Qemu LICENSE?

Should we update the files to GPL-2.0?

./tests/tcg/aarch64/semicall.h:7: * SPDX-License-Identifier: GPL-3.0-or-lat=
er
./tests/tcg/x86_64/system/boot.S:13: * SPDX-License-Identifier: GPL-3.0-or-=
later
./tests/tcg/riscv64/semicall.h:7: * SPDX-License-Identifier: GPL-3.0-or-lat=
er
./tests/tcg/multiarch/float_convs.c:6: * SPDX-License-Identifier: GPL-3.0-o=
r-later
./tests/tcg/multiarch/float_helpers.h:6: * SPDX-License-Identifier: GPL-3.0=
-or-later
./tests/tcg/multiarch/libs/float_helpers.c:10: * SPDX-License-Identifier: G=
PL-3.0-or-later
./tests/tcg/multiarch/arm-compat-semi/semihosting.c:7: * SPDX-License-Ident=
ifier: GPL-3.0-or-later
./tests/tcg/multiarch/arm-compat-semi/semiconsole.c:7: * SPDX-License-Ident=
ifier: GPL-3.0-or-later
./tests/tcg/multiarch/float_convd.c:6: * SPDX-License-Identifier: GPL-3.0-o=
r-later
./tests/tcg/multiarch/float_madds.c:6: * SPDX-License-Identifier: GPL-3.0-o=
r-later
./tests/tcg/i386/system/boot.S:10: * SPDX-License-Identifier: GPL-3.0-or-la=
ter
./tests/tcg/arm/semicall.h:7: * SPDX-License-Identifier: GPL-3.0-or-later

Thanks,
Peng.

