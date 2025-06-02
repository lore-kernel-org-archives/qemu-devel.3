Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C0DC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 13:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM4yE-00089z-NQ; Mon, 02 Jun 2025 09:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uM4yD-000895-7v; Mon, 02 Jun 2025 09:12:53 -0400
Received: from mail-westeuropeazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c201::7] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uM4yB-0002Ae-Bf; Mon, 02 Jun 2025 09:12:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWK+sUxfO8savFYdvROfug883Penl2lZFhyzFbV9ShUOp7FQ3REoUE4JsNCY2eSrgntqoMKEA/7DtmktGAmnkjnm+91bKKO4F0APqfSaq/DWXe/gL6DLTHBRoPlqRhpUojNJWVWNCpceoX+4kDh0B72w6yHmLKi5ZwaP5DEErVx0ogNSc+FOSySIHFPgVlWCfUMP1KxbmXAvcEGpy9N5yOVSYOO6aV0A6q45j/g/1+oSHUdmBIEooN6RNXyYkDrYoGlVrZm9ZR3/Lj7NOiWca5GQ5zGpwGjujjZaa+VujfM5S/qhQKsFI/Qku0jAUFib2yI99LxOZPTi3+8J76vO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFspWcJ5XaY02qtPOfXWnXq0pma88yt/uAq0mM6aHJE=;
 b=CN+vjf/Qfvxuppv2ZP2ijL1XiG6FLAZfukcu1oT/7kxQgkwzllvQ5ydhJjeF5BT+lEUki5eF1lWEnWw8fLheWmykSb8Lqaj7o6Q664n/UkXFOsRjEdJVu7PmG7IpqP6ZD+amGmRZS0o5TUg7x3TuV1grYwTKKfzC0kvm/IOIY15ExsB5+L8LuB92aI/U41htHrhBPreYwPReEvxwpntpXrU09QUQ5JqUqM0hQhbi+hten6RxrcKRkXMTnxNDcxDs/2kufBVbASEM8Nju9d8A0kBCsWyV/+yae8ferO534iz+4JrxwmpQyPXzkUcgIpX++h6fi08maj9QcMkdH2guXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFspWcJ5XaY02qtPOfXWnXq0pma88yt/uAq0mM6aHJE=;
 b=rMzuEBlqXJZ604U9i7wEozu51RriKcudbn80Xtxgo/Ygo+1Lo27BqUTT4SjdhLqBb/4mNUdfLJslQrSsLNjRRBDcp6PI2w+aMYh94bdzJDjDc6dH3Eh0wPSnC/ernfFmLFJzb2NyvKGLjWTukZCt9STVSC5nuknO4Ov15Klb+fkwyt2jsDMZI1Ptj+DVdHMCGSbB3luT6oWoS1Kcx7+fqdbBgTrpOf979Mpd8ckt8ijgL6kblDLvk5RglZzDRDzPBjFpYyS/+hyfLvjgHjFksnCR2FbUhNE9+WrHDXThY7LmKvsRhw+ZbaRwi2PA+My4/Y5r9lPG9Sh02i2umo7QJw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PAWPR09MB6728.eurprd09.prod.outlook.com (2603:10a6:102:383::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 13:12:37 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8746.030; Mon, 2 Jun 2025
 13:12:37 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 6/9] target/riscv: Add mips.pref instruction
Thread-Topic: [PATCH v2 6/9] target/riscv: Add mips.pref instruction
Thread-Index: AQHb08AC/YgTrwxptU6OFiEdXpgCkA==
Date: Mon, 2 Jun 2025 13:12:36 +0000
Message-ID: <20250602131226.1137281-7-djordje.todorovic@htecgroup.com>
References: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PAWPR09MB6728:EE_
x-ms-office365-filtering-correlation-id: cad95955-7193-406a-e815-08dda1d72537
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?uvFAeEzGNiHBBWiMjXwXPG15i9E9Q+6MvqUBIqimNDn6fnR4ZYcrt/wMxE?=
 =?iso-8859-1?Q?9gCUqiy+RDTJmzgjfqb9xC9eN5/7rhOuhJIvIeSrVtq1poYFsx271mYF5Z?=
 =?iso-8859-1?Q?WhL7IFIBsyL25ipmx/iwWC94cUnJtSMihHotnVaTePwCL5Z/EkEmyFv+U6?=
 =?iso-8859-1?Q?zAkqr9D5baEa5cdXVfxwTDsuBcN0Nj/VdcVrM/vXStOy9L2m8FgCbal8vT?=
 =?iso-8859-1?Q?i+JzPEFs/Ke/mkVgSV92Nd+g93N6Gl28wjpWm4eZHsaZg4OBva4UhM/b54?=
 =?iso-8859-1?Q?fcz1dqraMmb9SQhSz8o/hKA6jK3F3fnXgkOmIc7fab5gr8dDy1Pv+wVwNO?=
 =?iso-8859-1?Q?IIIbhh6Iye6YKyB72hHrXikUdssIsjVqOZYj+zKYm/BO5Kuvy9Rb41D1ZB?=
 =?iso-8859-1?Q?e4X0f0XNbcH2Q3wdz8p5a0Jl31F5/PBPnig/vHNU3/voSDPdhMienMLBO5?=
 =?iso-8859-1?Q?4mZrUQ8Mplbys61hpj9AXtSZc1LDs7zR+hg+DNQRi2a+MJ7grMGgjiPY5O?=
 =?iso-8859-1?Q?8kJ+uG+uiVJeSFHlB11EvRnWTO5chyrEXQ6fuWbod72dY4HkGF8D6jkHGL?=
 =?iso-8859-1?Q?d55dyG4Fm6qXrb/liNaqm3RJsUGnjBrCKHMY21EWgDA8WZJgJtG3RxU1V4?=
 =?iso-8859-1?Q?rt7wnZMhC7aJkTRQmLEksQW2ozEBDRgmw7Y/I9QMo3KdeLK4ph9tvLVgls?=
 =?iso-8859-1?Q?UUMQxZIsclur30bUru/acuIh12G9Y5YCvTZa4BC/qn9fn1KrEQ62N8c4II?=
 =?iso-8859-1?Q?0M2KqQrzn/5aeauS8YzLimtmLOvjdMg2Fc88n3hRqPV7+U82BdBAxAd6e3?=
 =?iso-8859-1?Q?OqNlDXbmw6tDI0QWCDj2jqV1IpJaIOc6dYQZQ6xQzz5RLZ/gUmvWNuaqOk?=
 =?iso-8859-1?Q?ojlYkV0JjxxLMmEzS+hR9klekU/7//Xh+dWvf1N3rMFXkT8D68DK/2jEy4?=
 =?iso-8859-1?Q?mtDUl2fQ85coKZbcF73oHWii67q/DNWutwzzrV2TovUl++ZeNip/2WSpj3?=
 =?iso-8859-1?Q?Nua08+KmVhxDUbl5pgUKxy2HvNLnlRtbvsFBLXtOrwn3Zy5lKE+mmqJ2Tu?=
 =?iso-8859-1?Q?8/OQFHZH+CmTuaAHUSiwq2XJ6eHwMfApKC4MRoXV8OYF8TEzHuF1tBu108?=
 =?iso-8859-1?Q?LRVBErJMrq5y4p6hn/sfmd2jlSjsUiqkyo1hd7m24yU8yE4+27x7UTmLeZ?=
 =?iso-8859-1?Q?//hShOIzY8qoBvKF9CG2gnypifjgR3Zv90yC0VCUL8LRaltdXcYDBnhBhp?=
 =?iso-8859-1?Q?ZD/aoayLAVRM2mJdEjA4LRnMOTvNjoBCwAmkwm/Jy9tisBk/oTsbsQhiBV?=
 =?iso-8859-1?Q?J/8ZVgfcfCU7N0a0ToZuGpCpYxkeF802/Aw5n2nKme52phiEEiP9csjAHE?=
 =?iso-8859-1?Q?hn331X/c9d3Fhygm0X92X+8yLwz2EJpln3Z+RdawkjOT+naMpPaCKxculj?=
 =?iso-8859-1?Q?nBJc/n/HMAoNIYFrK1BRSyh1Wmw5QkrW1p7IRVfg3LY7M9RkJKnwvtp2fJ?=
 =?iso-8859-1?Q?Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1a86NHWeErQSPzhYILPI/07wPO4Nf8a93nLdPC1fY1w03XDrrSMu40y3dZ?=
 =?iso-8859-1?Q?MGMK/z+A+ULt56BUeUNhkKXZCxGFzy/4TFvfJp3MxSfqGGKxNQnIfpyyeV?=
 =?iso-8859-1?Q?wZAHw9PaklpF1Gj484Nz+UbXD8P49ey+jHrRLL4B8kjWg/ovSC65byA8Ve?=
 =?iso-8859-1?Q?j3lWbjd+UL7IN33ZH3sUjTew86ciwSXSgFSvXcB79hdbFPm4NXOntlOFuU?=
 =?iso-8859-1?Q?DuaAfjOjKH/k2uhY8REsEGTO+EuyRBRazL2GbFdDlRJaxuuQGPKnpi+MS0?=
 =?iso-8859-1?Q?blJJiWYseUnTHd9YFfWuj2UD+L23k7VvLiuvwbFnzzsDMrC7Us1kQtGQDH?=
 =?iso-8859-1?Q?9mVcb5dTKUPJFrJeXSMt1eymv/5Exh23mi8nVrqTeOSaaBURpU/DglCexs?=
 =?iso-8859-1?Q?jvtnFsh1AG8PDk3kzN3x15FbdpaQ7MBiun5T59ip9lYfhneBMv5x68PuRC?=
 =?iso-8859-1?Q?c4t/S7Qc6a02UVAVMv5yzttrHHTCtfioiviUs//zSOz6y0SSlSgx4KgHjN?=
 =?iso-8859-1?Q?aBEBGwE1T6OrdffoQ4aIJ+l5W4ZoHTLTJSWAuG4xlJ20kUs0wHOUUEwEPJ?=
 =?iso-8859-1?Q?WMJ4pjTdpxim5GWCXsl/at+KQxrc25PQwrms9KB64uJhFt2YoaYkcypxkx?=
 =?iso-8859-1?Q?ERe5yQl2PBR51d5CvnFOQfj0vthNJ1O0LIlugZonRI7oRtuQb/DeXyOAsa?=
 =?iso-8859-1?Q?cuhLQzQpOf738g/bm5f/CXnVUWwOkNxQAqRFheo2aZOMyGocrdduuMbA8z?=
 =?iso-8859-1?Q?7Vcubi6NznLSDopecHoNyCzWOUgcPSAnU4e7QlvrY8BwPYFmIubrLi6GK2?=
 =?iso-8859-1?Q?TOBFh1AOXmZfsoq4Bs9UStfI99gKhPCzr1QN5xGNS09AUKR5R5nvHznrkA?=
 =?iso-8859-1?Q?iOLRPErHaqBeiv7/3gQr5Qe9aTTBdhymF1S5SEb38Th/LE/6rtKPOB+Vbg?=
 =?iso-8859-1?Q?XygYI9sHr5+nPFukDvRPMwFJmWjqK7gXZZWKeTGpXVLT9l5ow+4amoWtMc?=
 =?iso-8859-1?Q?9ELdkKh+qmSqbNrohLiJaRz35KKkUBvlnZnhxsFywQpY1pVNoJZPbLh5C1?=
 =?iso-8859-1?Q?zRy3AfWdQNIe5BVOIHgpIqEkkyVdaihjpNVUoJPnZdrHp3O1iJf25Vp0H1?=
 =?iso-8859-1?Q?s6c6eHkvDYEkWGv+BB0XmTjGvG8d9ehI4Im2L2F/MeIPMj5/956kBwRsCp?=
 =?iso-8859-1?Q?d37BeEE+CKp5YR9g9NaITHYv/Tm9i+YHQy/leKlZaP5VnX/96sD6OZbyh8?=
 =?iso-8859-1?Q?5XqUmcZOBe0S6wt0RSUeL3DnavptOvlCEpHMrU3eeHPrsMp6gCHvws6BLo?=
 =?iso-8859-1?Q?1x/gApkSwq001S7Ffd58Clg9wvjSTQ75jefYrYHakqXyhkzn/hrCLIi1V9?=
 =?iso-8859-1?Q?GzjfPWz1G5kz6wLQ9zOZ9UaJW5UMAFQh0FapRytdAVZLOgDpKzvSMskN/w?=
 =?iso-8859-1?Q?btnbmm1NiyQGCfexAmNaiNaO7ds0Wqzs/g6BhreyqVhKibk9zl41R71Xn3?=
 =?iso-8859-1?Q?ACwGKK207jWRBBkNLSwJpA1ZXCeR5WrbPPeARk/HqWEWxNa8buZzjSVj/P?=
 =?iso-8859-1?Q?NoXSSyAf4mdazAgiFH9L+aKYg3v0+q8oa0KvTtwOoBRtr8UVndXGsG76zm?=
 =?iso-8859-1?Q?8xlW4LoZV3BhVoSFwwvjl0PT9ctvSMXbkPXVGvZl+3sY2Q11D/yVYbmBB7?=
 =?iso-8859-1?Q?54IMPWrLef2sIlB2PLM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad95955-7193-406a-e815-08dda1d72537
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 13:12:36.6659 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r8xo1FNsElK/itu4o3+an9P31QHfY54/ARhpR+3TqalZhAN4ZN21jQTBirg7o65l8VHwjqHl81UpeeUzGPrnDMDWxIfl5PofFb3AMI1WCwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR09MB6728
Received-SPF: pass client-ip=2a01:111:f403:c201::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

Add MIPS P8700 prefetch instruction defined by Xmipscbop.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c                        |  3 +++
 target/riscv/cpu_cfg.h                    |  3 ++-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 14 ++++++++++++++
 target/riscv/xmips.decode                 |  1 +
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f5234a620a..58bfe50e4a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -242,6 +242,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(xtheadmempair, PRIV_VERSION_1_11_0, ext_xtheadmempa=
ir),
     ISA_EXT_DATA_ENTRY(xtheadsync, PRIV_VERSION_1_11_0, ext_xtheadsync),
     ISA_EXT_DATA_ENTRY(xventanacondops, PRIV_VERSION_1_12_0, ext_XVentanaC=
ondOps),
+    ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
=20
     { },
@@ -1361,6 +1362,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
@@ -3182,6 +3184,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 2db471ad17..9734963035 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -22,6 +22,7 @@
 #define RISCV_CPU_CFG_H
=20
 struct RISCVCPUConfig {
+
 #define BOOL_FIELD(x) bool x;
 #define TYPED_FIELD(type, x, default) type x;
 #include "cpu_cfg_fields.h.inc"
@@ -38,7 +39,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
g __attribute__((__unus
=20
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
 }
=20
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index baedf0c466..9ee0a099bb 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -145,6 +145,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
=20
 BOOL_FIELD(mmu)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index 5437148af1..fb80e58b87 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -16,6 +16,12 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+#define REQUIRE_XMIPSCBOP(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscbop) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
 #define REQUIRE_XMIPSCMOV(ctx) do {              \
     if (!ctx->cfg_ptr->ext_xmipscmov) {          \
         return false;                            \
@@ -37,3 +43,11 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
=20
     return true;
 }
+
+static bool trans_pref(DisasContext *ctx, arg_pref *a)
+{
+    REQUIRE_XMIPSCBOP(ctx);
+
+    /* Nop */
+    return true;
+}
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index cb334fa4bd..697bf26c26 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -9,3 +9,4 @@
 #            (https://mips.com/products/hardware/p8700/)
=20
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
+pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
--=20
2.34.1

