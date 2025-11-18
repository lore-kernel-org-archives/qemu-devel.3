Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FC1CEBF92
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 09:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLHXh-0008BC-GP; Tue, 18 Nov 2025 03:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXg-0008AL-01; Tue, 18 Nov 2025 03:58:28 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXd-0003VY-Vu; Tue, 18 Nov 2025 03:58:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLuZaH+Yzyhzx6gGyXHKjKNI/GRyqQDznZY3YHcGr7PZ9/uCZDK0xm2miF94oPJLTfksod6wS3vdKzKSg9a8FYidQPzhalOJ5v9Q+sJuH0gRo1+cLy07RTkb0Pw/avbyr+0EaO0Ur76VNPEpI6au0P1uKpIpWhdNbKKIBjO9Bf/bR5PR7/SFxcs/H5Zm0gEqTbr7ghLy4Kk9/XMurcae3RN5/mQCpC1mT0bQzmW+PmGYBVYB9uQBWUjjG6ztWUyHJHngSqp00irtA2UnQzVogoopcXxmP0juPxtchLMo4kJv9QH/Eo/KMVHlOstx/If5qMbvvrWVBeeUl0QtxlYsdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rD7NsZztFtW3xVK32pM36ulHIFJFWt4Xdv66bn0owNU=;
 b=y6zX6O+hXbtpD2N+LXyq9bxPqg5ktxJnGKcBGPN36K3xyVBp2SUgi9pJkZm4t8k1T507+/tanBJJa9taH99fK7u0FeOMhQvtPhybPsIYLOQNYghAlYWzaMaWQd67VbjXwVTQmu0nFqs42vydlwT3KnhBB75gcmNraUEfKOIJEa2CE2rlV6AOWWQaYE+elAPECl78/JaqBTunq6oNaSBJcPJHibSbtwYjwME0mLrU+DrZcyEjok4fqugvLTCW8rzSRSmIcI05tz+ORH477LaE72doO4be53CMFfQ129UXCiK+3/bi3sPXDvQbk96KoeH+4N2MjCoG0II9NwpEFKA3pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rD7NsZztFtW3xVK32pM36ulHIFJFWt4Xdv66bn0owNU=;
 b=gNror30g0reaTcGtYtnumA09GF8RavkiggMNHX8+HYvM1WUbnfsbAxaltWzGjJRYTNWaoEum/5Z8HcHpxaBxs94+xLbQQUIBLvcjElLY0mKnigDTQpf+EcinFwkgFhdwCR3TUxGNeLz6zrOa53CJCEK5l0VE+XhUUHzoX/5sdV1yzcUr3WSwcwGYHXcM1+dtnST+eGGHlLLzy851A+u0IJ3ADOohVfXr8orvlp6Z5XuhXgscPuFoZ/LapyYx+eLJKay/DOIZmQZM0Zj08Nc81D3wCBrvmlLo5e9D8k78X8om+w+QNyjFNwrS6qZA/rZQYEVs27kDFBGIfyjfzsGEDA==
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com (2603:10a6:10:303::20)
 by DB8PR09MB3612.eurprd09.prod.outlook.com (2603:10a6:10:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 08:58:08 +0000
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2]) by DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 08:58:08 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v14 07/14] target/riscv: Add Xmipslsp instructions
Thread-Topic: [PATCH v14 07/14] target/riscv: Add Xmipslsp instructions
Thread-Index: AQHcWGl1/NuyHqnaUUe/iGAPOEZHqQ==
Date: Tue, 18 Nov 2025 08:58:08 +0000
Message-ID: <20251118085758.3996513-8-djordje.todorovic@htecgroup.com>
References: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR09MB6506:EE_|DB8PR09MB3612:EE_
x-ms-office365-filtering-correlation-id: eabe0df4-96a8-4ba9-84d6-08de2680980c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?z3ywUOPBwSqnZmhwb0wwutPufPCSsyDYYYlm0ZRciclj8D+zebUfMajpTI?=
 =?iso-8859-1?Q?wYlWC0zGBtC/GO9fqmgHbleiTUZ334MAuczM7XTDTihuY8f2cRx8uGG7x0?=
 =?iso-8859-1?Q?JnM+xKFT+cFs2rr8wUfOkKAXXvx3iJqowh8vhec5luLJzQEc3UWIXwGs59?=
 =?iso-8859-1?Q?xjmBqEiig1/2567br/XRTaAjgihtdGwjgbaCUNFQoTwpYQlsRfNBzCv0Zn?=
 =?iso-8859-1?Q?kQ77xfkrbIG61e+8f96Mr04PwyjHU7qRXrNe8hXfL8rDeqzgHOJ+0MTbrI?=
 =?iso-8859-1?Q?2GZxVNCiveDQveN6iQpYdYLxEtrttXIWnC0RtTipx3KhPdsauY49tmzYO/?=
 =?iso-8859-1?Q?V1ZBohwkINfjBQtoKTBUrUPxwn1bzbFGZDHa9UCI1BoyxhqxL0OIofjkf+?=
 =?iso-8859-1?Q?T/NqfEmCQ4YHjlxyOU2kxSdN+PJsuTl6ux9XcpXIDEK1PQaXFWisJykkVD?=
 =?iso-8859-1?Q?8K9vcCY3Ia7rDhrwXJ2SWGPBd2IJ+Sc7j5wIQaFlwwCdxHY6wyLxTrvvy9?=
 =?iso-8859-1?Q?os+1DKu98r7VJRjlc17tDcwNyXDhtzcIZOIF20+sog2j8tFXKBGGajkDyq?=
 =?iso-8859-1?Q?8wDJ12WgsTHECoi56HFZoQCPH0oScihkb0nvlGNYDFglyqH+qhOXtHvrBT?=
 =?iso-8859-1?Q?XAAAyRjZNhKNtfGvpMPlGBp/KVWTvVP/XWh3v2ep3oDG2jH+fBoT5tP74j?=
 =?iso-8859-1?Q?aVbbS9GChboYYu9jBhfEqj7inS6ABVwzpeUV42kK124H6KieWxScwH6NBN?=
 =?iso-8859-1?Q?IWrvAclRSTtqG+RiY9ti2mDBczzGynLaeU68WNWl7byvfLfCNGeB+0JOz4?=
 =?iso-8859-1?Q?JgpmkAcDA1qu5kezjbCplGgnPJklcslDcm7m6qD1yJFoRPFEuMNpyH19cm?=
 =?iso-8859-1?Q?iUic7irTt2xDB3C6/0FM7VqctUv8xUo6BY1HGzJJC9aXeZALAqqEuD3W5G?=
 =?iso-8859-1?Q?UV5z7lC5fUxnxr3u+RidVvjbWdLPA1i2axegxUG2iVnV945/ByErhSzRfv?=
 =?iso-8859-1?Q?rVB0xNgYPR61+E3NEl3jwiddImcyvvT9ioOLdhY3gj8C2Ej9FTR5ubpZZH?=
 =?iso-8859-1?Q?ZvNTxvpig6EjEM6gtbitzoS6sGlNZQO09kmSd62QxL3Dn5zEaM1qWcbL20?=
 =?iso-8859-1?Q?f6GtNZ2h63SQrAkY+CISpdzUa8umeVgriLe2zdhaeolbK93l2d4VRk+GDp?=
 =?iso-8859-1?Q?knpNxewwYeppVHX1YWz2aQVRVG8HPo2cwIMeN0Qm37jreZemxU+Pq89fwo?=
 =?iso-8859-1?Q?r2xoCz4o0obZ5AcFxI4Me5QEaPOAK82P+r16+E69Sur0f+t0aIn6ft7L7m?=
 =?iso-8859-1?Q?mSdja7VfpY3cQRmqb1wva4CnSvxaTBvHwitORPAGoiCu9a/lvetvDMkIAO?=
 =?iso-8859-1?Q?rKmhVhbQoMIAVP5T2AU9cIVKKsohLJPy7HREp3qKg4aYkyIR6aKSAAUPON?=
 =?iso-8859-1?Q?RVEbFvGDSM21kC/zNWFLyAOfIPWG/U9MHZrGXnTZ8EvDrEGz3hPUx/upwh?=
 =?iso-8859-1?Q?4O3EBMkvPKULLu6adJfP72f+bswpmMgPTJ7y+yP+p68XYcZf8aPmJtvn9O?=
 =?iso-8859-1?Q?+t1jrJNmzvybW2fZ/f6clzqiVFHw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR09MB6506.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pcc3wNe4U6GiIMbbDCXpniLKXirulQT5CRZ/XPpEutjU66+CuFk6klFb0f?=
 =?iso-8859-1?Q?/NJsz2lx3w1y8mAQxJNg/SpOS9xkLS785u8jOkT/vM+iOdmtjUAoZi09YJ?=
 =?iso-8859-1?Q?DWpp8C2ZjsIw5csoMObWHkCrBG/jhf7FxAqYWZiqDsdxM+Osx4HBTRpEIG?=
 =?iso-8859-1?Q?s3Upo/G1sHNQ9MtMddOxUMA35nwrkndY1X3DC+fh0tSKQX4yR3WaMiEmgk?=
 =?iso-8859-1?Q?94gSNs1DZHGD2vWllSpO8rRAVYj15NnwsMWlMzSRV0CzcrDWYUkJPOu22c?=
 =?iso-8859-1?Q?+ingI/y+Vl3XPewBUQEao8oS58xdzNXoYoKhAd8bXbKbm2p5X2/iW9jS3X?=
 =?iso-8859-1?Q?TLHwtAJKd6WNtjZ0lTRJeoUBIOQDa/voKvx9Wsir4ZzOYPKQwTt/3N4bei?=
 =?iso-8859-1?Q?hp8cBWcVBtQaJ7MnrSHV2H4hvGs/4+KdoVh7FDQQlYSW10X3gijyPX9rBt?=
 =?iso-8859-1?Q?Q6slk6EpdzQRgML9ucbIN2zRgfTHQyfACu6HCDsBNbWkS9NQnOP447MRPR?=
 =?iso-8859-1?Q?xESIb0xJ7NAC6+FnueeDAdr5qax7caqHqa2L5V7mYrb8rMMgr5V0wL4tfm?=
 =?iso-8859-1?Q?+7mcWTc8EWXhpZIPCeUpYqxNk7UTFAFvv61ao3Ab+sILwCu8ho/66jBAbQ?=
 =?iso-8859-1?Q?c7IJ0XCKtDf6vtCyP2nhTryYieBlYDUpyFJ+3p7lyNdZJY1Ju8YBT+segR?=
 =?iso-8859-1?Q?90SsL2PbCXu8QIRFKFi7msNnS5jXzrJBlx7Rx8HSjbWDzaw6vokPj5nVpc?=
 =?iso-8859-1?Q?AeMoIMGwlUag0Qrr2G56gzxlS09Opn5uT+t38FhsloFlMYm0QnoY19OCZ4?=
 =?iso-8859-1?Q?uUHLwmNrCQ7ObK8BGvqVaSY2wBg+So1IFHSW1/emJ3dxRfi8NGovQ/NaMD?=
 =?iso-8859-1?Q?YOcaJF+4f/msUhV4aK3EAnA5gmITnvV9uE1jyRLAw+DzIkQR0Gix60CKLG?=
 =?iso-8859-1?Q?lGZGK96WluWGHd4VBWSwzf7C40nU0pPeIHpdH2qKoVGyEMWrUDl8t/HPpi?=
 =?iso-8859-1?Q?S6q5DvbMz3U8+doy2GuqIHi2B1yZZUGpVbIPB0dCW0xkaOgN2Vg2m/1xLR?=
 =?iso-8859-1?Q?qWxFRbHfuJHR2y0OgLaJgczOgZN0GJwa3/XrTU35JYNbSlF8eDy58cp3qd?=
 =?iso-8859-1?Q?h+aupyUXyaSZDRzjh/To4poNtLgpgpRyXSCd2tixAUCIqbrquZFMgvcnNZ?=
 =?iso-8859-1?Q?Ho7Y4SFV5ft07NZHZwyla7ZnzY5xgmafEPJ5stta9n9/rNICkW3YgffVNX?=
 =?iso-8859-1?Q?a+OAX6GDJrmKasYRMt6qb1ePcAE84VavVlUfP1O7qaDNEQpk2JYaBCFwqb?=
 =?iso-8859-1?Q?hK0qN3GXaR3fMqk/fqgxkF0K/LEhi0enrJf+N6C1extqS97TxdFckvxg4g?=
 =?iso-8859-1?Q?n0CfcukwkkUw7Zh7dXiGUnVh7XVOY24hXHiOW88KGfnNy0OZVpnVyXIlFA?=
 =?iso-8859-1?Q?/DuGbW9d1FU5X49QnIgGo0kHAEK9uQ03iVKvTsQzyWBVoNcv3bBJd9tAnk?=
 =?iso-8859-1?Q?p9drUD2/HWsj7sCO536LTuY/1qXUVTCbkI9na3joZhPQaXcIg682MAw67B?=
 =?iso-8859-1?Q?drk35N4RDX6BznLcIHgGTi3Q2OQnt9gDbavd1vT7VzCrB0J9Czgrt7RVLd?=
 =?iso-8859-1?Q?iUlZ00bwLKgMgeM0szCCNlo+1IZPseYoVHEDkQAAg8qJnu5y0gFEg0dW3k?=
 =?iso-8859-1?Q?YwD+4BftxUj5deoB2kM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR09MB6506.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eabe0df4-96a8-4ba9-84d6-08de2680980c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 08:58:08.1153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fVHCaPjSsvcZaoD1b1bK7Rq32MVlzbVp/WrQoKxnIuSxnYDfVXOQolccF+k+KIo671HpQS7IE3YVVhIHJQYAvL9SEwiApUuSxCu/oEr68G8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB3612
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Add MIPS P8700 ldp, lwp, sdp, swp instructions.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                        |  3 +
 target/riscv/cpu_cfg.h                    |  2 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 88 +++++++++++++++++++++++
 target/riscv/xmips.decode                 | 23 ++++++
 5 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9fda450683..c09ce9fc62 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -251,6 +251,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
+    ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1385,6 +1386,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
     MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
+    MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
=20
     { },
 };
@@ -3299,6 +3301,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipslsp =3D true,
         .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e4d5039c49..cd1cba797c 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -38,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
g __attribute__((__unus
=20
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov || cfg->ext_xmipslsp;
 }
=20
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index dd3ee7ba2b..7c624ab677 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -149,6 +149,7 @@ BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
 BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
+BOOL_FIELD(ext_xmipslsp)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index bfe9046153..9a72f3392f 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -21,6 +21,12 @@
     }                                            \
 } while (0)
=20
+#define REQUIRE_XMIPSLSP(ctx) do {               \
+    if (!ctx->cfg_ptr->ext_xmipslsp) {           \
+        return false;                            \
+    }                                            \
+} while (0)
+
 /* Conditional move by MIPS. */
 static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 {
@@ -38,6 +44,88 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
     return true;
 }
=20
+/* Load Doubleword Pair. */
+static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 =3D dest_gpr(ctx, a->rd);
+    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_y);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+/* Load Word Pair. */
+static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 =3D dest_gpr(ctx, a->rd);
+    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_x);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+/* Store Doubleword Pair. */
+static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_w);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TEUQ);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TEUQ);
+
+    return true;
+}
+
+/* Store Word Pair. */
+static bool trans_swp(DisasContext *ctx, arg_swp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_v);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TESL);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TESL);
+
+    return true;
+}
+
 /* Move data from memory into cache. */
 static bool trans_pref(DisasContext *ctx, arg_pref *a)
 {
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index 4215813b32..3174f17aa4 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -8,5 +8,28 @@
 # Reference: MIPS P8700 instructions
 #            (https://mips.com/products/hardware/p8700/)
=20
+# Fields
+%rs3       27:5
+%rs2       20:5
+%rs1       15:5
+%rd        7:5
+%imm_9     20:9
+%imm_hint  7:5
+%imm_v     25:2 9:3               !function=3Dex_shift_2
+%imm_w     25:2 10:2              !function=3Dex_shift_3
+%imm_x     22:5                   !function=3Dex_shift_2
+%imm_y     23:4                   !function=3Dex_shift_3
+
+# Formats
+@r4_immv ..... .. ..... ..... ... ... .. ....... %rs2 %rs3 %imm_v %rs1
+@r4_immw ..... .. ..... ..... ... .. ... ....... %rs2 %rs3 %imm_w %rs1
+@r4_immx ..... .....  .. ..... ... ..... ....... %rs3 %imm_x %rs1 %rd
+@r4_immy ..... ....  ... ..... ... ..... ....... %rs3 %imm_y %rs1 %rd
+
+# *** RV64 MIPS Extension ***
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
 pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
+ldp         ..... .... 000 ..... 100 .....  0001011 @r4_immy
+lwp         ..... ..... 01 ..... 100 .....  0001011 @r4_immx
+sdp         ..... .. ..... ..... 101 ..  0000001011 @r4_immw
+swp         ..... .. ..... ..... 101 ...  010001011 @r4_immv
--=20
2.34.1

