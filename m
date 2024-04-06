Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B52C67861
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2024 20:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtCIl-0004k3-7K; Sat, 06 Apr 2024 16:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maysara.alhindi@bristol.ac.uk>)
 id 1rtAng-0007yz-Qv
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 14:30:01 -0400
Received: from mail-vi1eur04on2107.outbound.protection.outlook.com
 ([40.107.8.107] helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maysara.alhindi@bristol.ac.uk>)
 id 1rtAne-00059w-SW
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 14:30:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwspSmcDWF8524KHWLr9RC+tFApbgH4x64MUqH4wYIUo/FlkOep92tZ3/BIJXSmNZ0JsjPkgHNh6WbOi58PTF5cCIXsnASVB7eSH8iwQyA+D9eNCoHKO3BIsQMf60wjrbnE9DeDyGsvOwZjmQ44tbMc7wVxPYMmPHtc0x1Pp6keGHaaKURd4HOqHHudVjfylAHzUEF8n/V2V/jfM13vF6h4K/QdUd5ozV0NQEjz2Ef5Xia/SEcfH9fMEYxH0BMqXTsJ0yA/KftyLINWuAR4BJzPurlm8NcTjjG5wRtYwY0KkVOKWphZTDUqxHa5OF38fJBzXuJQd211GEghRcLpvyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNjGyIXdwn4Oj2Q3xAzlbnHuJqUhkAadADW5gOddBqI=;
 b=F6xFKk9Yqzk85re3t2aCiLj8fDo9NWAbaAOwvEb/giKUDol7TKtpfPY3ZSQZ9YuX295y5sd1pvyc/ZsA4R4NXUDRJaAFTduCq7rsRGInEYZseRnD6dElegLMDHhiLKOi7vIKhAYyWf/WOfTL9a5mguGgHsBEVw9MllB4O9u6F2U3VMnMGTa7b03djHgm/QflNQ+PK3bbWoz3oGiNEY+7EMzpX47DDIuBD69VZzfV+NX5kz6kCg9AjSubxHV9AMGguYT23dwqJ5cExce7EoQX6Erq50fmlPz3DpHUFtSjdZoe2QFxYQkQyNZGbtUHth4jsouF7xYxeVDP60wqqGU0Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bristol.ac.uk; dmarc=pass action=none
 header.from=bristol.ac.uk; dkim=pass header.d=bristol.ac.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bristol.ac.uk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNjGyIXdwn4Oj2Q3xAzlbnHuJqUhkAadADW5gOddBqI=;
 b=Q/MiZf4Xrry9PunU369B1BUVu+O/+yJytc5UGI4LZmI4vGQIkCK/9HiNSC2yxnFS3KlYpjidEW9zMBlRzPIiubMjqJxck6EFcSIefNdHxvqtlSfKEomJ6gUZnJpYeIF0JLhJCUAlOle9sjts0krp79finGb8wpq8hRNMoYsM7khuiEnUeDkDfAijGK8zkZwYjIuZ8hQxC/GaiTelrOgVjD5tgXusz4LBy/889qa3YIBLdUSSztoGwqHUN9qVFu+soeBZ2/sBvzF3B/L+4qskVvVKMdnWvKy2e15zKVEGR83VCXpVb3TA5g8e8pY8/lLr5PzFmTiEnoPEDGi7XgPX+Q==
Received: from HE1PR06MB4137.eurprd06.prod.outlook.com (2603:10a6:7:9d::31) by
 AM7PR06MB6424.eurprd06.prod.outlook.com (2603:10a6:20b:118::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.10; Sat, 6 Apr 2024 18:24:53 +0000
Received: from HE1PR06MB4137.eurprd06.prod.outlook.com
 ([fe80::db97:ef3a:2a63:3baf]) by HE1PR06MB4137.eurprd06.prod.outlook.com
 ([fe80::db97:ef3a:2a63:3baf%7]) with mapi id 15.20.7472.007; Sat, 6 Apr 2024
 18:24:53 +0000
From: Maysara Alhindi <maysara.alhindi@bristol.ac.uk>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Looking for developers who know how to use Seccomp for a paid study
Thread-Topic: Looking for developers who know how to use Seccomp for a paid
 study
Thread-Index: AQHaiE+jTZtj2v6cckqU0DPgSjZB+Q==
Date: Sat, 6 Apr 2024 18:24:53 +0000
Message-ID: <HE1PR06MB4137EE81B7B56F3ECF1D1559AE022@HE1PR06MB4137.eurprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR06MB4137:EE_|AM7PR06MB6424:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JRNa4tJgnZA8QGCuZ5/ND/EhoOVN7KPJ3WoPM67ckd2LAOwpuaZ3lx923GTO74atjTNeXzG0T+yXL0HcV9rSJBYxY5eDKvNoUsi0JR2wG/kk+GfF8r+o8uoHVJKsnhEpxQmCJdHT7Z+iiiYsldwJB97txiXtrNYovmfH6K+utislTsoDQjHRyJZU2/rXeJ44tid0TO4EIXj2EnhpTnp63ZFmIc82l/GqnBBomLOQlsuqgp0PYNXWHZN2AUNroqcQX5ya4QP+8FO4sROZ92qS/Xdt9Cl8Y/n5Nm1Ugh0e1/+xHh4m7IGsp836mud6X50cfXcQscFnY6s0XX0xaFFZ03vVBHDOrfMOw7ouzWc4x4Gx9+01gtPnrgSPMRW19inmgCTjlxAkoT5Xv35JaYhWVKOML0cDBJj6vSbVEUCF2y4hmvq6sJj8J4chuMl1K5JT3zxmU9LHYL5YQ/eGaeoFJ0QWzQcqyCaph8ZDHstvFEy9GTLs3A9h1zJwAsoHXZRamERFPsI9ZhNT2AYTGXuej+UgVyOPM74BzgWO+V5jK9yuKGvOvYeeKuqRKSwZoIi85MpkkiOVvyyprInEzHmqjIKuGgDSueTOQZCNyanH3So0hFIMSY1K+YbBYWExdYBZWVT4CQ/60kqTX1jjdzFJ6NJvIVJrI0RTGmB/xmZ0wRo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR06MB4137.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pufSVyne34lR5khAZSWjctjsi+wHYcUpgoKA+n4WyRCC8I2TveEwE9KYX4?=
 =?iso-8859-1?Q?IwgrgicCMzBfKhmjgScl4s1TatzW7jZ5r72wbb1yIwPbbOGT8RYWIceTfW?=
 =?iso-8859-1?Q?9f8Gb6SFhRQWTbmx+pyeXwMiWu18uyt5cSPSoxc7mqleSP09liKIcMQjls?=
 =?iso-8859-1?Q?JOSuh5j19S68YFO7W8PolGlLs0G/xU95s9V3mU4+9jPldnAqyyrP067OLx?=
 =?iso-8859-1?Q?vs+y9EQSlVQZMFzYdqkyMKSd5VGfS39phANOu7QsifPw4KYDHUV8LJxJjf?=
 =?iso-8859-1?Q?rahbCj+b0+Hb5QRHGCQPVaN7/9g2lQLLO8F4oQvwuKAeUqRrWLnCg4V0ge?=
 =?iso-8859-1?Q?kyH8YGYrVOuq9l5KrUpaEz10AxXu5T/svbQ0LboNULNDmvQZ38dKiOfbPM?=
 =?iso-8859-1?Q?MyZmS58gduCQq6PQOBEkMdFdWF0+rYZwj9MxLznmJPJ6Pn9ZligGlkXuh3?=
 =?iso-8859-1?Q?lfSvQTBo2x6sppZllumfS6yDylmtzobw0DXVclwFNyDZQhkvqzUiDiGk1D?=
 =?iso-8859-1?Q?NL8IhdnCdZUntM860zL4QWqkguRuJ1MhlOLy8cmFGGh6ZVgIGMrpag/xfS?=
 =?iso-8859-1?Q?/oDwqL4o4I3QYuXdz9IIRWQc2YI37cPLw8n1ivcQRhtcYe/UoLSsBlRl9Y?=
 =?iso-8859-1?Q?Cglp+qBr18E7DuAUKep52mbhFXjhh4jx654JDnNj51FlZYe8hbmLJCpEy7?=
 =?iso-8859-1?Q?8ggDFll3VCCFI2gaUNMZIT259PmmtZh3C20/3StWxaYkkui/er+VzcTWQF?=
 =?iso-8859-1?Q?dTSt32l6/KTfVu21z+VJtOv0XhY3+pjziSPrLVLopJAqG/JjTGkSDcgbHC?=
 =?iso-8859-1?Q?RIYb1AgTy0qrNF3ndcg1RqvREl1OC58FmrAfgFb4pzZmikUJn1fgaxkth2?=
 =?iso-8859-1?Q?A0KtUtEI7vPpXJgghap1B/V04CbsevoJTGOrZnxVzBzngqAM5QFhHH7gvw?=
 =?iso-8859-1?Q?nKt3ddGeCdHRQFRadiKP8y/gy2oOM6RM48jzms3REBorvz6yP1FClcTJZK?=
 =?iso-8859-1?Q?Vi0TNrAa04D+IMRa59I9HuS/wCXJ3nC9m5kFX0Yf2BWwrPq0q1JW00GszR?=
 =?iso-8859-1?Q?5g71TNZuwIXuWJW1CHRG4m7+XLjIzJiMlzoIQDwrceTUAQzmuqpaMW9qNY?=
 =?iso-8859-1?Q?kGgHeVUOGaEG56Q3Hpukg0slmzpkqNA4EjWZoldBCjennpOQdismYiw9ny?=
 =?iso-8859-1?Q?19PuZTZLXts4kn7yDqc+ukfZGBXZBc1iO7GK/tXPmysg6M9w24TEQLM6n1?=
 =?iso-8859-1?Q?shArzXCFfCHbTRV4AN4s2M5eiR0nO6DRCHxOE4Ur2HlrgcniqEeBB/BQ/U?=
 =?iso-8859-1?Q?o/rIV+osN+2s8ZTf1zOYUW0Ooi8pgiqOoH3F/pwJq+KabsK0TxDT8AMjMv?=
 =?iso-8859-1?Q?kOvdUpv19MLTThHLAqjid02jbDqH/Fvo4D5skLEku3bv7e6RBrrDxCX7WI?=
 =?iso-8859-1?Q?H3TkdQHZeu+EB9S42Piz8rb04dJJr80khxKRyUVgRNnUmyNEPcHjXSafQ+?=
 =?iso-8859-1?Q?UZC6wkfTfrEwU05aAHf3u2H7IscOPAZDy9I587fQQUnOKjMWIUyOWEsG+T?=
 =?iso-8859-1?Q?iabjbXvcgX9CX6ji/2o01mm9EgYMC80+T15JK2duMgyl0DLSm/XWTHNMxB?=
 =?iso-8859-1?Q?FL7uJKxJrPYaGRU6yB+owd5dWhF2wpXmEL?=
Content-Type: multipart/alternative;
 boundary="_000_HE1PR06MB4137EE81B7B56F3ECF1D1559AE022HE1PR06MB4137eurp_"
MIME-Version: 1.0
X-OriginatorOrg: bristol.ac.uk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR06MB4137.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2c7916-34f3-4515-a85c-08dc5666da8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2024 18:24:53.2855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b2e47f30-cd7d-4a4e-a5da-b18cf1a4151b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8M50rJaQeOPvjp7ZONVh5VhtQNa39P2kQUC30LREnq34ScWziDgibHOWvHN1jSorsJeiuDwpWvdbGIDG7F3NhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR06MB6424
Received-SPF: pass client-ip=40.107.8.107;
 envelope-from=maysara.alhindi@bristol.ac.uk;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 06 Apr 2024 16:06:09 -0400
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

--_000_HE1PR06MB4137EE81B7B56F3ECF1D1559AE022HE1PR06MB4137eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello

As QEMU uses Seccomp to implement its sandbox, I thought that I might be ab=
le to find participants for a study I am running on the usability of Seccom=
p. I hope that it is okay to post this in the mailing list.

I am looking for C developers who have experience with Seccomp for a 1.5-ho=
ur study where you will be asked to use Seccomp to sandbox a simple C progr=
am. You will get  (200=A3 Amazon voucher) as a reimbursement for your time.

This study aims to evaluate the usability of Seccomp and is part of a PhD p=
roject.

If you are interested, feel free to email me at: dl21421 at bristol.ac.uk
I am happy to provide the full details of the study and answer any question=
s.

Thank you
Maysara.

--_000_HE1PR06MB4137EE81B7B56F3ECF1D1559AE022HE1PR06MB4137eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hello</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
As QEMU uses Seccomp to implement its sandbox, I thought that I might be ab=
le to find participants for a study I am running on the usability of Seccom=
p. I hope that it is okay to post this in the mailing list.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I am looking for C developers who have experience with Seccomp for a 1.5-ho=
ur study where you will be asked to use Seccomp to sandbox a simple C progr=
am. You will get &nbsp;(200=A3 Amazon voucher) as a reimbursement for your =
time.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
This study aims to evaluate the usability of Seccomp and is part of a PhD p=
roject.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
If you are interested, feel free to email me at: dl21421 at bristol.ac.uk</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I am happy to provide the full details of the study and answer any question=
s.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thank you</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Maysara.</div>
</body>
</html>

--_000_HE1PR06MB4137EE81B7B56F3ECF1D1559AE022HE1PR06MB4137eurp_--

