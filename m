Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2593DD262A2
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 21:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viJDc-0001Lb-1B; Tue, 20 Jan 2026 16:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <polina.vishneva@virtuozzo.com>)
 id 1viFOm-0007bu-8r; Tue, 20 Jan 2026 12:20:12 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <polina.vishneva@virtuozzo.com>)
 id 1viFOj-0002BV-A7; Tue, 20 Jan 2026 12:20:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzUZdmJyT+Gkh/n8X5k2xlbJDGTgRMIdv0Wmhmbq1UI88as3r86AreFSRNYPm88M548Jz2NPhukesyVYleKVATVO8PLXtwLr92AEozlA8r+yoTyt2ST9hUwc2S+e+AwO6QMzJL5I17uKrH7emAlRs2UCFqmnpQvZcShelbo2V7A6C/Xj0KFlrDbH4y/7jZGtWt4T4oeyVbOMK4AOmPgboBExZ9t5ycE6VJWaBVzzHZTTUP9l1NZMxsnZ4DvO4TvMHXSI9KjFIBnZJhz8E2ayRJ4QEhb/AGVPhbM58ZOCnkFrlJ8nDJpmRFOhDLeZNHFEoBhI+xa6vFk8I72/r6sybg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0Xh4ceCeDfiTO5cKjbooSv2hJYxuYu4FUtkk3Nhil8=;
 b=ffg0I5GsUs1sTprxKA/j2KOoMekF6MnGmxMLpNqkH1ftoZcakrIrhwHL3GpqwjNPIcdTpy/VbG1Q0ULSGrVsp2Ky8Axa8Eqj94VSoR98+LEXtDvOGsxualXgVMQQXNbYTa2YGB1Tculdg/DSRu3XMjBgsRr9zMWd+4BCs8MeLGgo78hWj/OGLJUb2tr8xRdQjy8K4+A67n1KhqmvLNS11Xd6yx/hkXkDoZSJI836YlVymZRzgofchIFrsYEZABLg1x+XwrE7x7Xdvd6RVFJFBzfXXwmsoz4+7QQ5jMBwtNBKaFJn9GjG+vsU4Ub2SJF8X8EnH3N7ZKX5fkm9FK/5Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0Xh4ceCeDfiTO5cKjbooSv2hJYxuYu4FUtkk3Nhil8=;
 b=JVF9duhxFwGP7SwMHl7qfXNTWgH90aARinhuvn6kgV0aU1LifPp+a274INCSGjcmewMb1u0yNBYZYcZpSVuBpY5pUdyLphdGL4ACrgg4ISAyour4r07nvmxt4yL0CnmymxSXLYIU6gyqKOkqnCTIb2zfsinfMiXEQ913szVXSKjdSjPpPro2KiOu4TMT3rmQ5jRWHWF2Z/WzRP5DdCt0Jjvgazpl+ELRX2QTMo4WLJRAHdJxT3aFou4Xz8NyETdxCPQDrcLOT6HBOpvSAW7PAOzs33S/Z2moL6o3X1R0e7i+goPvuQAqcPxCPVO8drCwIjOus1RZspCrhxTFRFQctw==
Received: from DBBPR08MB10697.eurprd08.prod.outlook.com (2603:10a6:10:52a::5)
 by GV1PR08MB7801.eurprd08.prod.outlook.com (2603:10a6:150:58::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 17:20:00 +0000
Received: from DBBPR08MB10697.eurprd08.prod.outlook.com
 ([fe80::2318:7df7:a744:15d2]) by DBBPR08MB10697.eurprd08.prod.outlook.com
 ([fe80::2318:7df7:a744:15d2%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 17:20:00 +0000
From: Polina Vishneva <polina.vishneva@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Polina Vishneva
 <polina.vishneva@virtuozzo.com>, John Snow <jsnow@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Eric Blake
 <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Den Lunev <den@virtuozzo.com>, Andrey Drobyshev
 <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH] block/qcow2-bitmap: remove inconsistent bitmaps when loading
Thread-Topic: [PATCH] block/qcow2-bitmap: remove inconsistent bitmaps when
 loading
Thread-Index: AQHcijEBVEmfG+2NzEK88XM4OUkPjg==
Date: Tue, 20 Jan 2026 17:20:00 +0000
Message-ID: <20260120171226.1042260-1-polina.vishneva@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR08MB10697:EE_|GV1PR08MB7801:EE_
x-ms-office365-filtering-correlation-id: 151f3f95-8221-46fc-45d8-08de58482475
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?dIdwvOPkEGDvJU+41IuEQf+jHiMgS/iOkKB5WFceGCHzRljzyk542j6PtE?=
 =?iso-8859-1?Q?hu0Vwtm9wO5rwdDe6WTyVB/P9vQRajYHFXEMxgRvV/jpyw0q2lvFCqWShW?=
 =?iso-8859-1?Q?xPfczwsh9j97uaR0JWcF0gNxUKyloE88SfgVzjWjJKzNhgJxpTObSfhvqS?=
 =?iso-8859-1?Q?b8Cauf+8zcQWaDfDo2EBj9ks2zXcuntHlLodj3eqPgWwqE+770hjuDB+Jr?=
 =?iso-8859-1?Q?WYUzPOhjItNTcuewV/+3sYdkzHkfrKVLQiBZA0NxaRAdVZBzmtg6O4Df9B?=
 =?iso-8859-1?Q?pw6JvRz2QtPu4Ir+5ESmUfA+rTf1jvDBExkjEB0vxKBhDIZvyTCWUEAZFJ?=
 =?iso-8859-1?Q?u77P+oPKdPr8t6vXbrbmu9MehJ/rb65uuz/1DqTqRq5NUNVAHR0YpAWhE4?=
 =?iso-8859-1?Q?1tMYQF/EJ2HgoIb5nRpC5ryMf/FWW1ceucHGH7z1ADU9TrGZ0rwPubhKOA?=
 =?iso-8859-1?Q?OBFT59rueyPi5XqkQRrxtsA8TmRJduVLlNXYv8p089MXDrpuYcto/5LDz1?=
 =?iso-8859-1?Q?7XfJYfsky9ZJTkSLPrs4oqA1M33DjV4VCWSIvIYYTfDgfSrOrxaacesb4/?=
 =?iso-8859-1?Q?+XaQTbLhlxM3PVdoB2khiAjowplMtlkcfozG1DGSkmdCGyO2C7QAQi3LBq?=
 =?iso-8859-1?Q?1bPvSLe76xfOymQPTU6wrCdfs5oaFLuB3tPQXPs28/lQU9QCjWJSu1Jxw9?=
 =?iso-8859-1?Q?YOmyFW7eUQgN1ETGcCuGCuyxbKbgDCvSOBk00mKzrvNnP4tk7baoPrJlKG?=
 =?iso-8859-1?Q?9GYlkgionJtspKFsExFuF9J/YJOJ77vtcj+tX3oAk1sNL8Szi2hoCBcNap?=
 =?iso-8859-1?Q?mjds2iZeYzWcd6avhPJydTc59nSuFNoiYMMoT3LWqrAWcnDWe+UbbT/bCi?=
 =?iso-8859-1?Q?n06HgnbqbXX5I6pPR8CLkvg28W934tz3thdw9Gkp75d5IP28Al6UBcJh+A?=
 =?iso-8859-1?Q?+5EuGTza3WCAPXPHhSAJBYcESpyPdDK8eE0BQrJ3N9+4U9tEw8dUOiMZxj?=
 =?iso-8859-1?Q?BssAShuaf5NyRaNPrkpx0lnhCW1q/lpYLvFaczl292sXqZBl1AWZK9BQNH?=
 =?iso-8859-1?Q?ukEsFs7AKlWDAPNBrlKIt4HUuB/ocJ3t4HVhD7OLLXetNMdYnrCcHGk7De?=
 =?iso-8859-1?Q?BkLywq3MLIY5/4S5mvrRZd1UoAoyuIW2/glOlyqr5W/zfF/C/v/vjqPi+m?=
 =?iso-8859-1?Q?Znr4T4gE+/1zVGKJeKQU2O7c5z4li49OA4DOWhIhCOK9JHaHC5GE3ckvIa?=
 =?iso-8859-1?Q?Kd64QbiqQe/LIfYPSeWTirDgCkQGrDqPrfiaWsyMucvoSG9+wCR5zs8vE9?=
 =?iso-8859-1?Q?kB+3w5FMhnzU2jlet5cdHLvg6ZRLfKuQDmGdjy5WTup9j0vIyCEBSIhQt/?=
 =?iso-8859-1?Q?q69DU6wqs+NYLNTwrQLPMGqhVq92FjUv6Y5wv9yNsK3pWUbA26zMCwjcxc?=
 =?iso-8859-1?Q?N6U55Hy3ffmq6gC47zv7moQUM/nUIa2+n6Av/OMCV1QROtnVaq94uoWHb/?=
 =?iso-8859-1?Q?3PlbNtPFuTVDzgtNsskWlxDL82+cOdx7xB5GVcHrilwYmGlRxg2g1VwnPY?=
 =?iso-8859-1?Q?wFsl2Kl1ua8u/Gsz/sAQ/nmI+r+yufOutuWi3IJvxYWNvwUgNFg0g857kd?=
 =?iso-8859-1?Q?gmJZ46NNzJYYjUimIn1so0gfRbG9onKBNXXALwLpzVwGuFffsUy91DUaF5?=
 =?iso-8859-1?Q?NwnU2RHogQA8wr7E83Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10697.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3+oEPd3QsmF2a4r8BC2GxPgj199+LiBJiUjUmMnuFRZZk5BTngY8tbcGNK?=
 =?iso-8859-1?Q?N1YY3oztGKPQGwCrJfiDhQh47O//b6kdDM0heNKFmkg4mObWfhn8CffQFT?=
 =?iso-8859-1?Q?Ct47OxPj/3qNvE+gwCrSOHYB8eo59gjn8CrrmwnGEg2P1S7bkzjonr82Dy?=
 =?iso-8859-1?Q?QENNZzsXmI5kGmDOeXn1BZOW05rQRO41sdKe6iPwsHPUmtQbxfIzZuvyyY?=
 =?iso-8859-1?Q?ewIJv+1BTyFRQvzL/vQnSfazFLUnILyNEnrb9B9mbiLOq+hxgJFp1/BfM7?=
 =?iso-8859-1?Q?usZ/ub6ACFSOC357IJ9Ws/vGSXr32dnl1Os9Xovi8hmWPg4azMGAVOsDu1?=
 =?iso-8859-1?Q?9qEv9yJPtZHMoqyfEg/TsHVCNq9wsUNb7BhNJexWAnzfLsj7bbZifPti4c?=
 =?iso-8859-1?Q?3uJ8A7Dx+/2cmPszC1pJRVLmW39CFOKFXByWOPxvuFCCiMtD71URa29W4n?=
 =?iso-8859-1?Q?8hbiaGy91XyZmiNtLoguUS8Z0EmFd89KaksNZ0SHILj/ji1IOR7d+eUUK6?=
 =?iso-8859-1?Q?IHrcDLombc7HqW6BKW+00oG6I8FwtzWvWUpK3UXd0q9gIRgCeno6AbmJrT?=
 =?iso-8859-1?Q?tLU7rR+7y5dydTXV5GB+6aQ4Gwkf+9Fj2kO5BApFm68QVLeU31ApWzy3IK?=
 =?iso-8859-1?Q?WwzVWfZ7gHVYJmlxKOCGud4h9EXohCTcfOSUInbdMcv3zFHLGJ5hVxeqIf?=
 =?iso-8859-1?Q?yYqaCEHsd7RHdpIbyqf0AwPN2LuOuxXRD4jfnO/TnxGODKgs0/AyZsSPJg?=
 =?iso-8859-1?Q?0nHDvHtzPkLExZyaj1We/qM9ydp1F0gfWgUF7TaGP6RY5nZN2bsYap4KIW?=
 =?iso-8859-1?Q?nI3zB6m4SE3krflD5nRJvxLg7J+efGM9nqhZmuRxcZq75Cso88BDdsn/pB?=
 =?iso-8859-1?Q?facUOLluZ7Xg9CR/Al47LPeHj9lFofSVC9QYtZ08nzytjXeCvlk3Ibbb3k?=
 =?iso-8859-1?Q?ikRTN4lsEqp/EwOZec/xpCslNyFEcrci+cHKY+NW3Xsfng7olfDHvRZO5o?=
 =?iso-8859-1?Q?8gRrewwq5AZQ9lvZoqeKCnsBje/sB3OnHWZaYHLxAhMnS4Xdp6/sfXXYd4?=
 =?iso-8859-1?Q?WChVJDhDIDJ4tTapmITVyzXETtVGsoNpljyCh6CfCcsH2CKlAApDYEH7+i?=
 =?iso-8859-1?Q?/JOStY+zaECA6nGQYzfNPDCY2P6OxbPQqEv8pxaXDG6Q7+FpnmeGOdm/xz?=
 =?iso-8859-1?Q?HWDqSSl0KUNDAvyPb2iUPE/HgROFNDEqo1By1ncANfaDp7dbSNFL+0PQio?=
 =?iso-8859-1?Q?f159mBhlG9ZI57kILQKhXRtYyqvjLy4yqezNGpKNapgH8V58wiQDzDdasc?=
 =?iso-8859-1?Q?3iEK+mIUUnLBWEzk0nSGqQ/7xlWpCRo4Df3DBaxi9vyX/PygaMIhsDvPKH?=
 =?iso-8859-1?Q?hMHMwovWE1EhqWLwqXPes4ymWxYAsqpGWF7jWi9twSRqpyZcjfQwjvmhub?=
 =?iso-8859-1?Q?7pEh8gPls+3exILmLbJ7KJFXTm/bmrsiLlZd/dpq/VyzYOXyB3aoMjpq7P?=
 =?iso-8859-1?Q?3aznz83tdx8novja0HGItZ1P1AMs2pP/KJbXA0DYiMGY6sjMWZoTk8i1xG?=
 =?iso-8859-1?Q?Kq20Gopj1wx283wZTK+UxrCVVMPSJVf1Rejx/X2D+rL1/dqW7srWtr+wEJ?=
 =?iso-8859-1?Q?YrLIqHPYs/Uoz1Sxi1V9/2JKBsDxUGjSZPIQMFAJd6GRoTa+rTK44QK+Gi?=
 =?iso-8859-1?Q?QJhnE3CkwinKV0K1RNcY/E28QjE77W6ak4sKhuv1X+JYbX8wJ0ELwtfiN+?=
 =?iso-8859-1?Q?BYFdOTvkp8aqNHM3ZfgueJZWM6F3H4y4Cj93pmlCGgET9lZnJBRKZSvqYD?=
 =?iso-8859-1?Q?8rvTDnhWPg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10697.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151f3f95-8221-46fc-45d8-08de58482475
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 17:20:00.5014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AKavQV2xtwps69o7d9tZpot6StYW9LMfubCOzTtWY8leyUHqfLh/Yk3T/9SZXlsgBETbj+oKymtX9WYfUOhrcZtl/dC4li5iYxz3SnOQcMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7801
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=polina.vishneva@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Jan 2026 16:24:53 -0500
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

Marking the bitmaps that are found in_use in the image as inconsistent=0A=
works in the most cases. However, in some cases, like migration,=0A=
it's critical for bdrv_dirty_bitmap_check() to always pass.=0A=
=0A=
Instead of asking the user to manually request the deletion of=0A=
inconsistent bitmaps, delete them automatically if we can,=0A=
while respecting the possible edge cases like repairing an image with=0A=
overlaps.=0A=
=0A=
Originally-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=0A=
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=0A=
Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>=0A=
---=0A=
 block/qcow2-bitmap.c                          | 111 ++++++++++++++++--=0A=
 block/qcow2.c                                 |   9 ++=0A=
 block/qcow2.h                                 |   2 +=0A=
 tests/qemu-iotests/tests/migrate-bitmaps-test |   2 +=0A=
 tests/qemu-iotests/tests/qemu-img-bitmaps     |   2 +-=0A=
 tests/qemu-iotests/tests/qemu-img-bitmaps.out |  36 +++---=0A=
 .../qemu-iotests/tests/qemu-img-close-errors  |   3 +-=0A=
 7 files changed, 132 insertions(+), 33 deletions(-)=0A=
=0A=
diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c=0A=
index 256ec99878..6ab857ad1a 100644=0A=
--- a/block/qcow2-bitmap.c=0A=
+++ b/block/qcow2-bitmap.c=0A=
@@ -30,6 +30,8 @@=0A=
 #include "block/dirty-bitmap.h"=0A=
 #include "qapi/error.h"=0A=
 #include "qemu/cutils.h"=0A=
+#include "qemu/log.h"=0A=
+#include "qemu/error-report.h"=0A=
 =0A=
 #include "qcow2.h"=0A=
 =0A=
@@ -958,6 +960,48 @@ static void set_readonly_helper(gpointer bitmap, gpoin=
ter value)=0A=
     bdrv_dirty_bitmap_set_readonly(bitmap, (bool)value);=0A=
 }=0A=
 =0A=
+int qcow2_remove_in_use_bitmaps(BlockDriverState *bs)=0A=
+{=0A=
+    BDRVQcow2State *s =3D bs->opaque;=0A=
+    Qcow2BitmapList *bm_list;=0A=
+    Qcow2Bitmap *bm, *next;=0A=
+    bool removed_any =3D false;=0A=
+=0A=
+    if (s->nb_bitmaps =3D=3D 0) {=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,=0A=
+                               s->bitmap_directory_size, NULL);=0A=
+    if (bm_list =3D=3D NULL) {=0A=
+        return 0;=0A=
+    }=0A=
+=0A=
+    QSIMPLEQ_FOREACH_SAFE(bm, bm_list, entry, next) {=0A=
+        if (bm->flags & BME_FLAG_IN_USE) {=0A=
+            qemu_log("Removing inconsistent bitmap '%s' at image '%s'\n",=
=0A=
+                     bm->name, bs->filename);=0A=
+=0A=
+            QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);=0A=
+            free_bitmap_clusters(bs, &bm->table);=0A=
+            bitmap_free(bm);=0A=
+            removed_any =3D true;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    int ret =3D 0;=0A=
+    if (removed_any) {=0A=
+        ret =3D update_ext_header_and_dir(bs, bm_list);=0A=
+        if (ret < 0) {=0A=
+            error_report("Can't update bitmap directory after removing "=
=0A=
+                         "inconsistent bitmaps");=0A=
+        }=0A=
+    }=0A=
+=0A=
+    bitmap_list_free(bm_list);=0A=
+    return ret;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Return true on success, false on failure.=0A=
  * If header_updated is not NULL then it is set appropriately regardless o=
f=0A=
@@ -969,9 +1013,9 @@ qcow2_load_dirty_bitmaps(BlockDriverState *bs,=0A=
 {=0A=
     BDRVQcow2State *s =3D bs->opaque;=0A=
     Qcow2BitmapList *bm_list;=0A=
-    Qcow2Bitmap *bm;=0A=
+    Qcow2Bitmap *bm, *next;=0A=
     GSList *created_dirty_bitmaps =3D NULL;=0A=
-    bool needs_update =3D false;=0A=
+    bool needs_update =3D false, removed_persistent_bitmaps =3D false;=0A=
 =0A=
     if (header_updated) {=0A=
         *header_updated =3D false;=0A=
@@ -988,7 +1032,7 @@ qcow2_load_dirty_bitmaps(BlockDriverState *bs,=0A=
         return false;=0A=
     }=0A=
 =0A=
-    QSIMPLEQ_FOREACH(bm, bm_list, entry) {=0A=
+    QSIMPLEQ_FOREACH_SAFE(bm, bm_list, entry, next) {=0A=
         BdrvDirtyBitmap *bitmap;=0A=
 =0A=
         if ((bm->flags & BME_FLAG_IN_USE) &&=0A=
@@ -1008,6 +1052,32 @@ qcow2_load_dirty_bitmaps(BlockDriverState *bs,=0A=
             continue;=0A=
         }=0A=
 =0A=
+        if ((bm->flags & BME_FLAG_IN_USE) && can_write(bs) &&=0A=
+            !(s->flags & BDRV_O_CHECK))=0A=
+        {=0A=
+            /*=0A=
+             * Remove inconsistent bitmaps.=0A=
+             * This is to avoid errors on migrations, when=0A=
+             * whenbdrv_dirty_bitmap_check() could be called on a bitmap=
=0A=
+             * marked as inconsistent, causing an error and requiring the =
user=0A=
+             * to manually request inconsistent bitmap deletion.=0A=
+             *=0A=
+             * In case we have a corrupted image, there's no guarantee tha=
t=0A=
+             * update_ext_header_and_dir() will succeed.=0A=
+             * This would render some images impossible to repair.=0A=
+             * Therefore, skip it on the image open if we're in the check =
mode=0A=
+             * (and do it later when the image is successfully repaired).=
=0A=
+             */=0A=
+            qemu_log("Removing inconsistent bitmap '%s' at image '%s'\n",=
=0A=
+                     bm->name, bs->filename);=0A=
+=0A=
+            QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);=0A=
+            free_bitmap_clusters(bs, &bm->table);=0A=
+            bitmap_free(bm);=0A=
+            removed_persistent_bitmaps =3D true;=0A=
+            continue;=0A=
+        }=0A=
+=0A=
         bitmap =3D load_bitmap(bs, bm, errp);=0A=
         if (bitmap =3D=3D NULL) {=0A=
             goto fail;=0A=
@@ -1015,6 +1085,7 @@ qcow2_load_dirty_bitmaps(BlockDriverState *bs,=0A=
 =0A=
         bdrv_dirty_bitmap_set_persistence(bitmap, true);=0A=
         if (bm->flags & BME_FLAG_IN_USE) {=0A=
+            /* Reached in check mode or readonly mode */=0A=
             bdrv_dirty_bitmap_set_inconsistent(bitmap);=0A=
         } else {=0A=
             /* NB: updated flags only get written if can_write(bs) is true=
. */=0A=
@@ -1028,15 +1099,31 @@ qcow2_load_dirty_bitmaps(BlockDriverState *bs,=0A=
             g_slist_append(created_dirty_bitmaps, bitmap);=0A=
     }=0A=
 =0A=
-    if (needs_update && can_write(bs)) {=0A=
-        /* in_use flags must be updated */=0A=
-        int ret =3D update_ext_header_and_dir_in_place(bs, bm_list);=0A=
-        if (ret < 0) {=0A=
-            error_setg_errno(errp, -ret, "Can't update bitmap directory");=
=0A=
-            goto fail;=0A=
-        }=0A=
-        if (header_updated) {=0A=
-            *header_updated =3D true;=0A=
+    if (can_write(bs)) {=0A=
+        if (removed_persistent_bitmaps) {=0A=
+            /*=0A=
+             * Bitmaps must be removed=0A=
+             * (possibly along with updating in_use flags)=0A=
+             */=0A=
+            int ret =3D update_ext_header_and_dir(bs, bm_list);=0A=
+            if (ret < 0) {=0A=
+                error_setg_errno(errp, -ret, "Can't update bitmap director=
y "=0A=
+                                 "after removing inconsistent bitmaps");=
=0A=
+                goto fail;=0A=
+            }=0A=
+            if (header_updated) {=0A=
+                *header_updated =3D true;=0A=
+            }=0A=
+        } else if (needs_update) {=0A=
+            /* Only in_use flags must be updated */=0A=
+            int ret =3D update_ext_header_and_dir_in_place(bs, bm_list);=
=0A=
+            if (ret < 0) {=0A=
+                error_setg_errno(errp, -ret, "Can't update bitmap director=
y");=0A=
+                goto fail;=0A=
+            }=0A=
+            if (header_updated) {=0A=
+                *header_updated =3D true;=0A=
+            }=0A=
         }=0A=
     }=0A=
 =0A=
diff --git a/block/qcow2.c b/block/qcow2.c=0A=
index e29810d86a..eb6da74d34 100644=0A=
--- a/block/qcow2.c=0A=
+++ b/block/qcow2.c=0A=
@@ -634,6 +634,15 @@ qcow2_co_check_locked(BlockDriverState *bs, BdrvCheckR=
esult *result,=0A=
     }=0A=
 =0A=
     if (fix && result->check_errors =3D=3D 0 && result->corruptions =3D=3D=
 0) {=0A=
+        /*=0A=
+         * Run the removal of inconsistent bitmaps that we've skipped on=
=0A=
+         * qcow2_load_dirty_bitmaps().=0A=
+         */=0A=
+        ret =3D qcow2_remove_in_use_bitmaps(bs);=0A=
+        if (ret < 0) {=0A=
+            return ret;=0A=
+        }=0A=
+=0A=
         ret =3D qcow2_mark_clean(bs);=0A=
         if (ret < 0) {=0A=
             return ret;=0A=
diff --git a/block/qcow2.h b/block/qcow2.h=0A=
index 96db7c51ec..542630bfbd 100644=0A=
--- a/block/qcow2.h=0A=
+++ b/block/qcow2.h=0A=
@@ -1039,6 +1039,8 @@ bool coroutine_fn GRAPH_RDLOCK=0A=
 qcow2_load_dirty_bitmaps(BlockDriverState *bs, bool *header_updated,=0A=
                          Error **errp);=0A=
 =0A=
+int GRAPH_RDLOCK qcow2_remove_in_use_bitmaps(BlockDriverState *bs);=0A=
+=0A=
 bool GRAPH_RDLOCK=0A=
 qcow2_get_bitmap_info_list(BlockDriverState *bs,=0A=
                            Qcow2BitmapInfoList **info_list, Error **errp);=
=0A=
diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-test b/tests/qemu-iot=
ests/tests/migrate-bitmaps-test=0A=
index 8fb4099201..dc69bb9433 100755=0A=
--- a/tests/qemu-iotests/tests/migrate-bitmaps-test=0A=
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-test=0A=
@@ -197,6 +197,8 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):=0A=
             log =3D self.vm_b.get_log()=0A=
             log =3D re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)=0A=
             log =3D re.sub(r'\[I \+\d+\.\d+\] CLOSED\n?$', '', log)=0A=
+            if persistent and shared_storage and pre_shutdown:=0A=
+                log =3D re.sub(r'Removed inconsistent bitmap.*\n', '', log=
)=0A=
             self.assertEqual(log, '')=0A=
 =0A=
             # recreate vm_b, as we don't want -incoming option (this will =
lead=0A=
diff --git a/tests/qemu-iotests/tests/qemu-img-bitmaps b/tests/qemu-iotests=
/tests/qemu-img-bitmaps=0A=
index 7a3fe8c3d3..90743d4eb9 100755=0A=
--- a/tests/qemu-iotests/tests/qemu-img-bitmaps=0A=
+++ b/tests/qemu-iotests/tests/qemu-img-bitmaps=0A=
@@ -137,7 +137,7 @@ echo=0A=
 =0A=
 # Prepare image with corrupted bitmap=0A=
 $QEMU_IO -c abort "$TEST_IMG" 2>/dev/null=0A=
-$QEMU_IMG bitmap --add "$TEST_IMG" b4=0A=
+$QEMU_IMG bitmap --add "$TEST_IMG" b4 2>&1 | _filter_testdir=0A=
 $QEMU_IMG bitmap --remove "$TEST_IMG" b1=0A=
 _img_info --format-specific | _filter_irrelevant_img_info=0A=
 # Proof that we fail fast if bitmaps can't be copied=0A=
diff --git a/tests/qemu-iotests/tests/qemu-img-bitmaps.out b/tests/qemu-iot=
ests/tests/qemu-img-bitmaps.out=0A=
index 74b81f703b..8062ae1114 100644=0A=
--- a/tests/qemu-iotests/tests/qemu-img-bitmaps.out=0A=
+++ b/tests/qemu-iotests/tests/qemu-img-bitmaps.out=0A=
@@ -118,6 +118,10 @@ Format specific information:=0A=
 =0A=
 =3D=3D=3D Check handling of inconsistent bitmap =3D=3D=3D=0A=
 =0A=
+Removing inconsistent bitmap 'b1' at image 'TEST_DIR/t.qcow2'=0A=
+Removing inconsistent bitmap 'b2' at image 'TEST_DIR/t.qcow2'=0A=
+Removing inconsistent bitmap 'b0' at image 'TEST_DIR/t.qcow2'=0A=
+qemu-img: Operation remove on bitmap b1 failed: Dirty bitmap 'b1' not foun=
d=0A=
 image: TEST_DIR/t.IMGFMT=0A=
 file format: IMGFMT=0A=
 virtual size: 10 MiB (10485760 bytes)=0A=
@@ -127,29 +131,13 @@ backing file format: IMGFMT=0A=
 Format specific information:=0A=
     bitmaps:=0A=
         [0]:=0A=
-            flags:=0A=
-                [0]: in-use=0A=
-                [1]: auto=0A=
-            name: b2=0A=
-            granularity: 65536=0A=
-        [1]:=0A=
-            flags:=0A=
-                [0]: in-use=0A=
-            name: b0=0A=
-            granularity: 65536=0A=
-        [2]:=0A=
             flags:=0A=
                 [0]: auto=0A=
             name: b4=0A=
             granularity: 65536=0A=
     corrupt: false=0A=
 =0A=
-qemu-img: Cannot copy inconsistent bitmap 'b0'=0A=
-Try --skip-broken-bitmaps, or use 'qemu-img bitmap --remove' to delete it=
=0A=
-qemu-img: Could not open 'TEST_DIR/t.IMGFMT.copy': Could not open 'TEST_DI=
R/t.IMGFMT.copy': No such file or directory=0A=
-=0A=
-qemu-img: warning: Skipping inconsistent bitmap 'b0'=0A=
-qemu-img: warning: Skipping inconsistent bitmap 'b2'=0A=
+unexpected success=0A=
 image: TEST_DIR/t.IMGFMT.copy=0A=
 file format: IMGFMT=0A=
 virtual size: 10 MiB (10485760 bytes)=0A=
@@ -174,10 +162,20 @@ Format specific information:=0A=
                 [0]: auto=0A=
             name: b4=0A=
             granularity: 65536=0A=
-        [1]:=0A=
+    corrupt: false=0A=
+=0A=
+qemu-img: Operation remove on bitmap b0 failed: Dirty bitmap 'b0' not foun=
d=0A=
+qemu-img: Operation remove on bitmap b2 failed: Dirty bitmap 'b2' not foun=
d=0A=
+image: TEST_DIR/t.IMGFMT.copy=0A=
+file format: IMGFMT=0A=
+virtual size: 10 MiB (10485760 bytes)=0A=
+cluster_size: 65536=0A=
+Format specific information:=0A=
+    bitmaps:=0A=
+        [0]:=0A=
             flags:=0A=
                 [0]: auto=0A=
-            name: b2=0A=
+            name: b4=0A=
             granularity: 65536=0A=
     corrupt: false=0A=
 *** done=0A=
diff --git a/tests/qemu-iotests/tests/qemu-img-close-errors b/tests/qemu-io=
tests/tests/qemu-img-close-errors=0A=
index 50bfb6cfa2..d72567171d 100755=0A=
--- a/tests/qemu-iotests/tests/qemu-img-close-errors=0A=
+++ b/tests/qemu-iotests/tests/qemu-img-close-errors=0A=
@@ -81,7 +81,8 @@ for max_bitmap in 6 7; do=0A=
     $QEMU_IMG commit -d "$TEST_IMG" 2>&1 | _filter_generated_node_ids=0A=
     echo "qemu-img commit exit code: ${PIPESTATUS[0]}"=0A=
 =0A=
-    $QEMU_IMG bitmap --add "$BASE_JSON" "good-bitmap"=0A=
+    $QEMU_IMG bitmap --add "$BASE_JSON" "good-bitmap" 2>&1 | \=0A=
+        sed '/^Removing inconsistent bitmap.*/d'=0A=
     echo "qemu-img bitmap --add exit code: $?"=0A=
 =0A=
     $QEMU_IMG bitmap --merge "good-bitmap" -b "$TEST_IMG" "$BASE_JSON" \=
=0A=
-- =0A=
2.52.0=0A=
=0A=

