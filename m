Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01ABD0E6E5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 14:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNu84-0001yK-5w; Tue, 25 Nov 2025 09:34:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=417ea8bb2=Moritz.Haase@bmw.de>)
 id 1vNu7d-0001Gz-Me
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:34:32 -0500
Received: from esa1.hc324-48.eu.iphmx.com ([207.54.68.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=417ea8bb2=Moritz.Haase@bmw.de>)
 id 1vNu7M-0004zg-Mz
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
 t=1764081247; x=1795617247;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dUyew017iGetCB7rsW8b8Kd5ZgekLo6vVRtIL9OvmY4=;
 b=BxYuaJ9cLv/+LVl678X0nmc/lX/yb0HFF43tHAK4LPA1DJ60I/EZGpe4
 YbEIh4Gl/Ol/R0BAl2QRd5dc1NC3ApNnjgmAjCIagxLcs4/GIps8XbFet
 ajHdavA91o+SgLug+esVyjJBqeou3W+tk5REm7fvnk8F3TCG2tVnIh/5m 0=;
X-CSE-ConnectionGUID: 0igD1sKOSLS+AXPKEGspTw==
X-CSE-MsgGUID: PA8qMr/ESrOuJ8hlL6sMhQ==
Received: from mail-northeuropeazon11011060.outbound.protection.outlook.com
 (HELO
 DU2PR03CU002.outbound.protection.outlook.com) ([52.101.65.60]) by
 ob1.hc324-48.eu.iphmx.com with ESMTP/TLS; 25 Nov 2025 15:34:01 +0100
Received: from PAWPR09MB8030.eurprd09.prod.outlook.com (2603:10a6:102:4c8::8)
 by
 DB8PR09MB3609.eurprd09.prod.outlook.com (2603:10a6:10:111::23) with
 Microsoft SMTP Server (version=TLS; Tue, 25 Nov 2025 14:33:59 +0000
Received: from PAWPR09MB8030.eurprd09.prod.outlook.com
 ([fe80::ad5b:1b80:9eef:7826]) by PAWPR09MB8030.eurprd09.prod.outlook.com
 ([fe80::ad5b:1b80:9eef:7826%3]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 14:33:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIEYrfjZnw5fB4Zx7rOut3WZGZKr7Q7aYJE/gsfEJxvrb1NTJREeHzInA3tyENlU2QqkU/s6Tdm2rV8L9sRXyQoKaLZ8DJjwlRm/9nbdgvDU5rAAWxNdef2hri6wCr8/Whn2gWiSjZFKxI+GkGbga4pAlfUbuPNG2RCIc/2Uoh72nyo0X1vZmKncFHycz0jY2rjD2YOdqGpiwaAgbRZNenvIK/C2XVoZ8uJA/nFbOuryhl6Qt82m7d8e+1jiNgTIlGpm/Q/ucOUQdilApBH8N8B71/quM8npJKQmvB/sseMYzE6iurAxUdcmKji7iYX0EGfKqYHOeCkTL5+8Bt3Hmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUyew017iGetCB7rsW8b8Kd5ZgekLo6vVRtIL9OvmY4=;
 b=oI2muKt2iLc3hIGQk3dvev/MKrLvvLvS7amWuufGCW6n7Fa6eL8/3mTls/1t3xg8+XYPiJaP6vNUDgd/Kk2YmJ3g+ftN5l+sRnpS+ndcDWsao+fR+cC8R1ROK1PoOsIx8Ue3LX88ynvEiGqS9LsaS8PNuqJLh/XGrweXMs5gMfRZmPpkaPJIYF8W3x4W8k4FPc+V4mPe9DzZuT8ZoxFqVfG3uWVZHhATI/vsaFImZO9yw1KEEbm/LoU/92aK/Yms3IUkjVrSJc8OCyAKfvFFHAOkmGQStzvs6HWdhcnuuGMSlg78y8cN946g6q5UGog22Vl/jtCp5YLAkTnqjeSUUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bmw.de; dmarc=pass action=none header.from=bmw.de; dkim=pass
 header.d=bmw.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bmwgroup.onmicrosoft.com; s=selector2-bmwgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUyew017iGetCB7rsW8b8Kd5ZgekLo6vVRtIL9OvmY4=;
 b=CtdP5vzltIwFGyWi5XvJGqShKrpi8Iy230QA8ASfwA6bEvjUmoqkQC4AByNkEg4vdSnKeN78TGMtAmSQiDwhX0jKK0iTO3KOXBPnIOYbaXK9ZVDZpXw3DRFr4aF0JPfEstgUmyTcBiU2KRe6LTpL7qBSAhbOQePCYKXPT8Qkx7c=
From: "Haase Moritz, JD-61" <Moritz.Haase@bmw.de>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "petrosagg@resin.io"
 <petrosagg@resin.io>, "nghiant2710@gmail.com" <nghiant2710@gmail.com>,
 "forumi0721@gmail.com" <forumi0721@gmail.com>, "laurent@vivier.eu"
 <laurent@vivier.eu>
Subject: Re: [PATCH] linux-user: add option to intercept execve() syscalls
Thread-Topic: [PATCH] linux-user: add option to intercept execve() syscalls
Thread-Index: AQHcXffG0/XL0HMI+0+t4IpL1X+e+7UDT5GAgAAiB4w=
Date: Tue, 25 Nov 2025 14:33:59 +0000
Message-ID: <PAWPR09MB8030E73D0F7A99CA8248CAB8EAD1A@PAWPR09MB8030.eurprd09.prod.outlook.com>
References: <20251125103859.1449760-1-Moritz.Haase@bmw.de>
 <aSWe0_oaclL83ovL@redhat.com>
In-Reply-To: <aSWe0_oaclL83ovL@redhat.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bmw.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR09MB8030:EE_|DB8PR09MB3609:EE_
x-ms-office365-filtering-correlation-id: 42b411a1-765e-4275-6c4b-08de2c2fac43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?y8d1+1J07XaRzH12ybiE6IDu/gG9/PH6GwmawDya6+KCnf/97y0gj/8Km/?=
 =?iso-8859-1?Q?wsSGKdsXyrf6Xm1HsEkiq4H7TfV8ef2kxpL1LQb+cSoKwL34mLLLWWqp9y?=
 =?iso-8859-1?Q?nkrEkOvKMDoiAG7z1Lj5uCZJA7rn0dQVgp5dsJH5SRUqLrFob5CxJHpeKA?=
 =?iso-8859-1?Q?IVdRF+FDoev/qbW+30CzIODJSb1Pajf/Byl+xLOoRUWu9+L89mBsb3wIGO?=
 =?iso-8859-1?Q?QmuwFu7E6xqfNRJ6GvF5m87l3JhmrXHGkShkV0+miVpEtZuGvzheL/+CR9?=
 =?iso-8859-1?Q?Tatem2FuhUWz0IBTkw1Z0Tvk2iMPXIDSNh4lTHJ4T2g+fR0AfkdJU+orri?=
 =?iso-8859-1?Q?QqGvNM8cmTZdwTK3+jUnhGri/JMPsl2cGP8gU0Yh4aa4fLoKSVEhwBiepD?=
 =?iso-8859-1?Q?kcIUNRD/Lf4P8LzMPVhuvp0gEVPYCbOcAfIBR2JeWpUR3OljCCZ77ZLsXE?=
 =?iso-8859-1?Q?nytwO8qyihizOE4QSrpDt48LGNjOg7hJZu+bgZ0r3YlVuxsrw/973v4eWh?=
 =?iso-8859-1?Q?jyCQa9wWXURIsgARNLC8Z3gl77Jx9b26vXAbXEGeiqajrc7NfdHgdXkjl0?=
 =?iso-8859-1?Q?/VB1PksOOGUkB7iutIbAk2weksbKAGpdbOHKjcem31jk6ZxEqa0s4pncdK?=
 =?iso-8859-1?Q?TyKQbTwj/wqRDKnIYfJ30lyxyfShFMVkOHKNuRGQKwQLO+J7u1zsQLu8jF?=
 =?iso-8859-1?Q?HeMF8Ng06go72+Uo1XMX/pR9nXKfLFJKU5bJA5GZDmnt4kIjJX7Pz5FtM8?=
 =?iso-8859-1?Q?6og7iBbHuQk0yVnqkJ3e3rPkBCBhVbLgesBCUCAbyHRnsLg0A+RF4hqPYt?=
 =?iso-8859-1?Q?ETlDkubFKiDPvyyoDljuwAwp59qcu2+xPa6oB6At1ZabCGRFL2DoVootWw?=
 =?iso-8859-1?Q?WTY6NLEVP84XYMPL1Or1lpZWIhoP69mkprvXwCgIwzZrP0yx+IAFIWWVBV?=
 =?iso-8859-1?Q?F+T/XZUUHtijF9uLtDQAp3DN7myR125xgeM2itNH2Jfv/eD91iJcXLGsbo?=
 =?iso-8859-1?Q?MsEDkL9NYcVbwvXPYhhFuuH2mQI3k9luHCAqtEMXpPdgXA0yzEj0GNgMQQ?=
 =?iso-8859-1?Q?8/+mwmvAiH04SVdkAPiWXxNMmMFyXn034A6oe2eM/lIHnFpkbRKzEAdb3l?=
 =?iso-8859-1?Q?kn/Zdd2oCWzDufSx5IpClEBe7XI7xokCM6DgCpfUtrsy5iFnAZhX79dqdU?=
 =?iso-8859-1?Q?pnyO2XtpHVg3RCcxebO4ouOQcKovgrKL7X6XKgHchwGxZEfDwYS4hr4Kp/?=
 =?iso-8859-1?Q?uDNima0G1beaMmHOtjCcOIoy1lbMLhRwz8Pnw8DLSglvBQG65gfM7q7AIB?=
 =?iso-8859-1?Q?yXuQcpQ0Bl4D7iwWhR0lMCfcNuDlvuUQACOWjVamqwznhloBdBErdO4JAO?=
 =?iso-8859-1?Q?69UVs4y8kvsYNQjxWyDqBNVdGy0lneRBxsYwPaLICtT0RS5iR6z8Mcgab+?=
 =?iso-8859-1?Q?SWReCdibf/ZxbKtc6vJxKbikygGb63r7OU1EoL2GPayfp/Kv7us6S3wPs7?=
 =?iso-8859-1?Q?WhLMR3K+8gUGiiZiBD5wnATow1dyPOL863ZJom6TtxmJ6vh2jsYZgDGIJe?=
 =?iso-8859-1?Q?7EfN7zI308m107RTJFbCYpSag1cQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAWPR09MB8030.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?doaiY6yCMfYGSdlanItxMiOOrFGOpP+cXNsqLnYBdCPUH8UiEVeEidAS9F?=
 =?iso-8859-1?Q?EcdtSJJ1onK6QNQQCO2iXS2miHnzkbjAMtyPjyCnOysgVYLKmhls1LmDt8?=
 =?iso-8859-1?Q?BCOUcmjbsJ1gmJjLpUhbZfKvNEUuvQuMNghBSLnHJfngGx3GfgzsSMi/m8?=
 =?iso-8859-1?Q?JyBQMHTYovUnzpyBJIAhIi9wL9BrVfm8JJEMefdfGPNVhb4jB6hEW02UV3?=
 =?iso-8859-1?Q?xpVrZMzh7eefqMf+EenjCl7YtJaaVy2VaTBOcANBhKorSMlPdzwITmn3tX?=
 =?iso-8859-1?Q?9+gYUqxzyFZoEtdQ1aNisQW47N6NwEd0qAMnQdPg55G5kTHhdfsN8DpPiQ?=
 =?iso-8859-1?Q?VATSkf2pxU4uRQiG2a0RsIy4oJ3P+brJPf2/JYgaoYbS5T845ZSajJb7UK?=
 =?iso-8859-1?Q?zfY/SQDXdQ25BKcBlR6rN89bnM/C3oGTCalJcS4EjJf3Y//6QZ1k+R3q2j?=
 =?iso-8859-1?Q?IXXMVKBxAXEicDlO6fabx9FgayFgxBtUd/ePH+jKqvEBJuzAyPwIn+PI8X?=
 =?iso-8859-1?Q?RhwRhLB2Ka0NVrvRFezgXxzHfcx9sAOR6aHTlrtrWsWFD2RxeNZy4GEURZ?=
 =?iso-8859-1?Q?sjsUDBCr5N4F4iYeEPL8etuy2mq6+iEC/OIDA3BXT48TNxTjM+Lk9pCiA7?=
 =?iso-8859-1?Q?8f1R0VTNe4Awg+K+Tz57+GwDAABJwkWtJWj4DNUdXo8O0pllID6GARHzdG?=
 =?iso-8859-1?Q?7antvO0dIlNNHoGL+Rqs/Yi4Cilf7FQKHMxcmz5rceWdlbV1ZJe6UpB84f?=
 =?iso-8859-1?Q?rosGoO6iOrxyqh5H0CY0eZCzrGKtvqYAbK3mIqFE8gk+nqCCNUtQ7o/hO3?=
 =?iso-8859-1?Q?rTHVbuXLoSrIQfbTQSYcIpXh4/mczMG7uF5MQ+NHqc442I1EeEilW8fEdk?=
 =?iso-8859-1?Q?qpksebZEe9Nsxu+ZdfNBMym0tC3OpdukYxz+WQQ1RbWGKGF0lxOkV6i39W?=
 =?iso-8859-1?Q?bFpVU9ikA8pMyUnzAIrVWMSq5criEsJ09jm+QZFbJXEGTO8aXLs7tEA7PT?=
 =?iso-8859-1?Q?0ixdQgZnsz7ROzq/7wmeMxQSZTbho3Mcv2tZwzzElFCTyMkXW/xMhEosKj?=
 =?iso-8859-1?Q?YjqCBULiSjULxzrBdoZjkoa4NBeCg2JHGgMbAYziPc+xNbE/WSrB35WQGg?=
 =?iso-8859-1?Q?NszyEUZyg7SE4xZNiZZme7lInpK93EF31NX1oB17wvd/DVubdR+0xhlhbt?=
 =?iso-8859-1?Q?7DX7AJuUzaJ+Djlyc1rZCO6z2xMlxtLkm6NzU9iOdmRe1UOAkfoMo6A6VA?=
 =?iso-8859-1?Q?uJlbg5kJpbMRsqQdYaSjiM3qPGDJX1EvXPgnohf2hkRF5cjWICL4o/pInM?=
 =?iso-8859-1?Q?0oceDavbHzxyYyo/1wsOMREomI7o97xgZ5XkzMkM6tTUHPdPOgxWNeuG6D?=
 =?iso-8859-1?Q?CiXi308xTKvyH09pgQ9GHAEDkVRUHd+jh3XhyEQZCGD0yJQrDmpxPiWuVm?=
 =?iso-8859-1?Q?USleEHR0RJlofTkWnarUB5yRMEfBm6geg1U77oKwq0SN9Kl1UHNRFTK+Kh?=
 =?iso-8859-1?Q?+czIxK040c2hyg4YS19r3yB8TINxKacjUGkOMSqO5J5myQ1DqoMKMJlqhr?=
 =?iso-8859-1?Q?eyxhAVa2OLLZpLxEzLSrJahkLLG17ppwVIzxVoR1biEG6r9sazaPBxBzBd?=
 =?iso-8859-1?Q?1IlMXARL5E3AiOiMhyyCw68D2yfD/B4a4O?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 55Zg3tr6lMZcwv/M5b9WiAlx5auJDKaQHll8geYLb9gQnUcsKx/rUHWIeh4bUQu3MNKKNk9qVD9W99NDZrnilPtwoFnZNaghMRmcqNpx5cDvQ+GLCej6fUVFvQA5205nwDB74uAPCA8Hgv8IOBd2Bvy0UobcTf4b7jFkw5VPpVl60+NGlaXeUBLQ1gCqY2usHeglH3Z9Yr/7EQi/565/o6JXOYeEPN56xSksroQHviVMyyOpZ3SxMhdn6Iyx69I07H6rFKVxv6Wbbq5/Fol0gQ/7DKDF4l+saOTckz70JQSTloqU3DKH296yxiVWZna4xGCTYDHz7Br+WZV0wcKnXjqlmBW/7QlSQN6tJyDmtWSD/JPTEWcRxfn3zyD+Bg61RWSDjfhk4eIJ+Vr8Yt680O0NudZeC9Jg+CMWz+d5+wThNkPnURpkZSNS9A+ZkSdZVGMNp+nsM0reiIZZ1rcfV6RzAX6dMoA31xZovLTjwBXvHf9QtdHvxj813WR6V3CJxH+7/blEZxjQDQlg953xwbd58UE2neFAgYPyGCe18dl9nPIKsFexrYBRwNay4tzTxHq+lJWMAbYyQSXEA7fjReHUSqrjYLGHz1rxPuLOMfyi6rrxAcBBN9eUyZeJc5MUTp3nk3YEFarVDp6tv0NANA==
X-OriginatorOrg: bmw.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR09MB8030.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b411a1-765e-4275-6c4b-08de2c2fac43
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 14:33:59.7737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ce849bab-cc1c-465b-b62e-18f07c9ac198
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s8kFJaR8gltzrICAgQBZbTZvFGsSP+ldqEN/tnFF3GqGHDtShXshKWgnfP3P01gEwcBoakIAZ0jwDz8m3wy0/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB3609
Received-SPF: pass client-ip=207.54.68.119;
 envelope-from=prvs=417ea8bb2=Moritz.Haase@bmw.de;
 helo=esa1.hc324-48.eu.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Daniel,=0A=
=0A=
> Did this patch code directly evolve from Petros' patch linked at [0], or=
=0A=
> was the latter merely inspiration and this a fresh implementation ?=0A=
> [...]=0A=
=0A=
it's a direct follow-up with minor modifications and not a new implementati=
on.=0A=
I'll change the sign-off lines accordingly in v2.=0A=
=0A=
> FYI, use of g_alloca() is no longer permitted in QEMU code.=0A=
=0A=
Thanks for pointing that out. I misread the coding style guide in that rega=
rd.=0A=
Will get rid of g_alloca() for v2.=0A=
=0A=
>>=A0 int loader_exec(int fdexec, const char *filename, char **argv, char *=
*envp,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct image_info *in=
fop, struct linux_binprm *bprm)=0A=
>>=A0 {=0A=
>> [...]=0A=
>> +=A0=A0=A0 retval =3D load_script_file(filename, bprm);=0A=
>>=0A=
>> If load_script_file()=A0 failed to open or read the filename, is=0A=
>> it correct to continue executing with this fallback ?=A0 Is there=0A=
>> a scenario where QEMU would be unable to open/read, but it be=0A=
>> none the less possible for it to work int his fallback ?=0A=
=0A=
Will need to double-check on that.=0A=
=0A=
Regards,=0A=
=0A=
Moritz=

