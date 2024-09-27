Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEE5CDD1AE
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 13:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suAz5-00050o-Gg; Fri, 27 Sep 2024 09:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1su9dT-0001EY-MS
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 07:59:47 -0400
Received: from mail-am6eur05on20723.outbound.protection.outlook.com
 ([2a01:111:f403:2612::723]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1su9dR-0007XA-K4
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 07:59:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X61IzleMkYObWWNDsO7a6ECi9wsC1ECunfi7kGMtNHmNUzYvFfayWS6GUmyL8AeaWDKFGN2Ej8PwZ9GnAJEvwnABd5c6KJGegBLoeBv5lgfMFC/91aO7vO9NhN/rDAmRWuF7pBXfeLV9ZtwBwH9FGD4p73RqgFfDUbVMNjrYYz+6kDe+pnYen3rCMf/nmANRfr2UpLfU/R/8LBhq63uYmBIRRtKQjZWckLzEdYK5cnEW3NrJHGyfq5FjUkYQ0kBtfSrON8Tw2/Kx2oZBDv5tRqNZ5ZPKuvC5BmYUQq/VA3kqkcQgy7LkgL6wWffxE1tHMvv0lN53LGSxQnMtAqesGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Unt3jiBSp6zmou9tYNFC9JLAgT0afKjmcwM9wMXElI=;
 b=pDTCBaLLz6+Z4UhyRfmRhbI5wiAy9gfMnl0HAbLpmGaw3jFm3nUlFfFzjQJF9iVpyibL8kTc1ozRMQ6eKKC5ooU+0HJkOeZ388+r2a8wFmIKFvCh0xBzKlLW3h6uRoIdzCqkLhjVb8p+6pr5evnPl5kfBaVdgZSSWX0Yeq+ngmyj3ys3p81bLdTCDcY10hV4kjHSAoj2BTVonoaIgE9Bug65mGAwKlUcb5uymsfCC/7fxJhHCfV8w+4kmQh176+oMIs2DswCmJZ7qxRfnduTv0m/4NN4h6Vg2QsdYzQ8p01VmcCrjqFKPU24q6lSJSKXbwi6foUxQ51itSZ7RlOeaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Unt3jiBSp6zmou9tYNFC9JLAgT0afKjmcwM9wMXElI=;
 b=nFale9nupcSsf5hhftZ6AeAFg5Gnv6xAjNVcAEY38FMdn8Z3btWDoSwYV8+ydolYU7VNkt/UZ92AVmLpNthTG7aZuGK613jPhojLbmGrZl0nrlB4UPO1nanOzpkxgxVm2fEdwk66aSD2GiDXsWRQ/e2yGtn4AjsdnN8seR48yqD9UJByEKHhKpG1CTg/wu2x72uD0dMR3qYe6trPno8ohSa+8edHc4raId2Zdxh2liRDnF3W6FgUKlVGnqeBQ1xYAS1K5SQEkeuMQnkOlsGjW4hblM0tg6mAHC68GwRh7ilcaUhkU+PHcsvNa/Axnh9BybwcUaekdvMWHcp9mA+qLg==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by GVXPR09MB7199.eurprd09.prod.outlook.com (2603:10a6:150:1b8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 11:59:42 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%7]) with mapi id 15.20.8005.021; Fri, 27 Sep 2024
 11:59:42 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, "cfu@mips.com"
 <cfu@mips.com>
Subject: [PATCH 2/8] Add support for emulation of CRC32 instructions
Thread-Topic: [PATCH 2/8] Add support for emulation of CRC32 instructions
Thread-Index: AQHbENO8SiRZltEFZkyzEoUZw7ShBQ==
Date: Fri, 27 Sep 2024 11:59:41 +0000
Message-ID: <PA4PR09MB486489692D843DDFC25F3CF1846B2@PA4PR09MB4864.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|GVXPR09MB7199:EE_
x-ms-office365-filtering-correlation-id: a8c1d4f0-a61a-4838-54f3-08dcdeebdf01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?qBL8iQoUQmpTMhvxpGqtzD6TsU3nTgAHe8dNitNjBgacAmI6vFtPouobce?=
 =?iso-8859-1?Q?QhPAivNEpWYCkohIWvDxok5Ug44HZTt9YzDnn2A/k82Z6fkqbBYSbqHuYM?=
 =?iso-8859-1?Q?xN8o5mi15yA2pyK9MYLDt6zjaOGfvZIdFNQGAL8GIuenexhzOl62TpspiD?=
 =?iso-8859-1?Q?SuN+HVAbVmqjcASWaQdD5Mtyx1jHI4tNvByY6zrmOjbnviaGsKlABzVT/D?=
 =?iso-8859-1?Q?r5oB/NRgNBpznT/zqohpGf2pybbebD/+d4Ky57Ddn4OXqX7HtY51QkCwKN?=
 =?iso-8859-1?Q?XDf+9W1+CQRAqV5Bg58t4Js13+9lhjKChD4fWNlWHnaNpy/9VR/VItCMme?=
 =?iso-8859-1?Q?6Xo3I6Bf6Vl8bttnk7Hi3L382nbh0a7h3mqD6kL6f/9rt4llu8IpmtVifd?=
 =?iso-8859-1?Q?fdAcWwPWNGe+iWG6Z3gOa9/Nn+KZjth5cfqgr2YiTyoIKJvQFpjrkbWC7l?=
 =?iso-8859-1?Q?QW1wKXlHHLU+RUjUUu5LxDsnh9XRgQvXKCnbU+b0RQfDAmPCHvdNeOYqXc?=
 =?iso-8859-1?Q?JjorunsUvOZ2SSmKoZMoIe/mXlDCfGVTQE+fYI4brbJ8lPux/kaTyL5OVt?=
 =?iso-8859-1?Q?a694hRmSvz1rzrPhoDzIjiamKHg9WVeT9SvOFHMgO0GzzwhTuVQg+a+5Ef?=
 =?iso-8859-1?Q?o9S2PKQ35GawtPBQ/RSYXl9KjZD/WByQhZXyKm9lZWF/q4qEJk9zYe9/bl?=
 =?iso-8859-1?Q?I8BHU6+MW/x8/ncKLazXkFVLVzNmBdnSSWq5/0k3HGY85TAwUyK+T9ZStI?=
 =?iso-8859-1?Q?A4p3BhSGqFYEku66af5+ad4v/Yj5q7D5aPj2aBHI5stInegUcDwDnCBH8p?=
 =?iso-8859-1?Q?8237uP3lMkgQEmsbnlKb+UTgwSxYKivRLvLNWGV35/2ae4ktYQPwqX14Zm?=
 =?iso-8859-1?Q?SfU7jzk9oZnPn5jnkggQs07Sf2LoC4M9j8alKnERaky9u/ysWLOgKBVPOP?=
 =?iso-8859-1?Q?MtH7hGCqIqHH0+/EO7x+/tN/Qad5U8jO4UqwMOiidrpIfZeCDjJ7dG3VDl?=
 =?iso-8859-1?Q?vxN7jlB60gLS0V+3+QcmDPCizaOJIRXNXf6Davhh5h3/BNX7gwbSCZycTR?=
 =?iso-8859-1?Q?x9c0yCUet1UNBjDYKf7CJOaJ+4ZFbZAWCUF0no5RX63RYdFNobW0wm/vtk?=
 =?iso-8859-1?Q?aBwuF+SIgrGbJ6D69xyPPpGVvN8mrDBO/vnxOToZRwqKK7uKv7qO8fuj03?=
 =?iso-8859-1?Q?cT+LtUWOviX8oIv12R7alD17rj8bKyc0vLT1fAv+4mOALTDI4qGXKQrdks?=
 =?iso-8859-1?Q?tyemdlRRYVG6du+GPlEo98oQhkhSflj/SZCAa0ze0CVQshp+RN/2y6DqOw?=
 =?iso-8859-1?Q?v1YfTuQtX95FrgVMfKsfnDX+QsNQjX+8xgcG0+KRp8p367elNXLWFdHSQI?=
 =?iso-8859-1?Q?WI+5JfcV8C8Q0ROl5DxxLOpANOVBXk/v6UXmuKxZVWD8c9Hipa1d7y8Jxy?=
 =?iso-8859-1?Q?VjoTr2p4Yo65RW+C33jCjD7FRecBcAVasnt7nA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?paBkFnoi+XyzdhrZ/4o2p0JbamxJLMX+prYsTtdWp6eDnhZHaStJKCa5Pq?=
 =?iso-8859-1?Q?n/jSkJsewqCFjQIlb+T626HaoFMrCAKJ+oltX7Ah6m2MyT3FXkQzgIdOh7?=
 =?iso-8859-1?Q?akPSkMTlKzxTSfLU7YE6kXwkcdLAqCRlfVY9EkV4vaYybkJgpT0238SGdm?=
 =?iso-8859-1?Q?3mP+Cqw8imttUpWsd9Nva4IF6k4HcjTvhfJ+LZ1D7wWJam+LysWwfLSfd8?=
 =?iso-8859-1?Q?FX9KOzVF4L2VVf46W+Bx9oaW5LcT4LJaSTpavMAIkYc0n5nF4xTxIXz9/+?=
 =?iso-8859-1?Q?32bghbOEvfLf3qpCodAFYWYZe8op6yf0K1ONocvvLxyYzae5EF1sZ260mr?=
 =?iso-8859-1?Q?OzxCimxhUG/tsaSDvKd9LCJH/1HqTkHC41SBgNe6Lg/8TWIgx7PqVC2o26?=
 =?iso-8859-1?Q?8ofxijlkb3TD+Ys51HW4j/EUUEhPb+tsdsCsh8lfXCwe0BPSE5BagemT3J?=
 =?iso-8859-1?Q?tQ+ef92TPkrA1H2hfNFhYykuWzb7RyGWWoG4r1hdw1nRqsWJcOelQ2CvHq?=
 =?iso-8859-1?Q?80YZGH8XPekYg8M99VcqqXhNKMa0kMcg+NLfQLXu5IiaivWu3W7nRx6H9Q?=
 =?iso-8859-1?Q?Vz8a7Ay1QfN1BzzLxVtVkt+wYzyxcy2aiQRxOjjJA9wZhO2WMXkKsZ2LqM?=
 =?iso-8859-1?Q?Lh85Xj7/+ICTrvpLu3EjGbe0N0ue0HUOkC5Vujm/r8aMHRDxvCET4ZTOa5?=
 =?iso-8859-1?Q?EsIo6ON2+7PgLsIRYyklmfFaAgDybeGQE9n4VrM21TDAmV1yaJVgDGPrPE?=
 =?iso-8859-1?Q?CnBFdGaFymTUAdBm/v77qShuFU/77ZdBqAnTzcQHxlBsJcEsl8n+/Lzvkt?=
 =?iso-8859-1?Q?Ow+X5qrvPRgNtRyfEegox4lS/fWMj7ykty70S3kc1AEFChHuHJev4GYD4r?=
 =?iso-8859-1?Q?trgCVBDM29ARy8zBOIeyrVBlZ2ongB0KjZ8DHgVPV8pehMmpLqnGozXlE1?=
 =?iso-8859-1?Q?HkBjXrmMTGfXOKDFcHlDUxhh3yE4Mr5VkMtuPST2Qza1UPxyvBrKl3yJ/m?=
 =?iso-8859-1?Q?TNdhL7tjurn0faxpEDOi11X5DF9u1aNEsdYx6KliCkps8hmFjh2VVG/HeY?=
 =?iso-8859-1?Q?2aj0NigsiyYscJbdcBGUj0QjJAkIEdOE3giKVr6X5BBQblMB7eq1Y3epGB?=
 =?iso-8859-1?Q?zp4wJw+48+cGX0+/ZLK5CElAKdCdassfcBPPMIGqbEewBV+JXpe+s/UV1K?=
 =?iso-8859-1?Q?fnJ7eQQqsxB/Bl3SFWNT7rzpDZoZMc63EfFg9csCyMgh7v1CiKvGeIsBaa?=
 =?iso-8859-1?Q?l6igsLPzofOG15fm6DnXqDbAgzu9Su4pfF3w0QDMgMI5z9KgtEPfPWVNxD?=
 =?iso-8859-1?Q?PkzrSiU10HKg+G7aHXLXXm/Z9X7dqZ0V/bKDK7yXhQF6QacowrxmbWWt2z?=
 =?iso-8859-1?Q?Hh2iQixG7ArQzgVhBuAcxZqrErTxXGevz1rkOBBr/jN2JMjoTL/deIFOD+?=
 =?iso-8859-1?Q?DUB4X9fsndTn63flX7Sn9dkXwrgmfH2DvO8Ws6g667FjkjnC/rmW6+XzhT?=
 =?iso-8859-1?Q?K4sC/CphlWdxK5RdOfsZBR1OY+m3cz5BihL1jemzCdMqZu8Ov0gqQ7mgHG?=
 =?iso-8859-1?Q?HZ1r6zpB6ekXOLF3LEBsYuj7zXPnm0uNwJlnIP3/icmnoyfKE5lHCZ8qyt?=
 =?iso-8859-1?Q?4+LN+GfmrV/cnAJ4x/qczJIkcSORMZcx4qQc58mEVGyaNEY4AK4EsVfA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c1d4f0-a61a-4838-54f3-08dcdeebdf01
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 11:59:41.9592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9uBFCLEZhygZJCIXAIIkTipyTIGsFaYtrtr1EF8z8ThYBZG8Yc6R4L68XUJrKUbRgc2Y1Fbdj7qRsqxWWuJ62aECyvKKGpAWwGwLinhwGG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB7199
Received-SPF: pass client-ip=2a01:111:f403:2612::723;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Sep 2024 09:25:47 -0400
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

Add emulation of MIPS' CRC32 (Cyclic Redundancy Check) instructions.=0A=
Reuse zlib crc32() and Linux crc32c().=0A=
=0A=
Cherry-picked 4cc974938aee1588f852590509004e340c072940=0A=
from https://github.com/MIPS/gnutools-qemu=0A=
=0A=
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>=0A=
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>=0A=
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>=0A=
---=0A=
 target/mips/helper.h        |  2 ++=0A=
 target/mips/meson.build     |  1 +=0A=
 target/mips/tcg/op_helper.c | 26 ++++++++++++++++++++++++++=0A=
 target/mips/tcg/translate.c | 37 +++++++++++++++++++++++++++++++++++++=0A=
 target/mips/tcg/translate.h |  1 +=0A=
 5 files changed, 67 insertions(+)=0A=
=0A=
diff --git a/target/mips/helper.h b/target/mips/helper.h=0A=
index 0f8462febb..752748d5e6 100644=0A=
--- a/target/mips/helper.h=0A=
+++ b/target/mips/helper.h=0A=
@@ -21,6 +21,8 @@ DEF_HELPER_FLAGS_1(bitswap, TCG_CALL_NO_RWG_SE, tl, tl)=
=0A=
 DEF_HELPER_FLAGS_1(dbitswap, TCG_CALL_NO_RWG_SE, tl, tl)=0A=
 #endif=0A=
 =0A=
+DEF_HELPER_3(crc32, tl, tl, tl, i32)=0A=
+DEF_HELPER_3(crc32c, tl, tl, tl, i32)=0A=
 DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)=0A=
 =0A=
 /* microMIPS functions */=0A=
diff --git a/target/mips/meson.build b/target/mips/meson.build=0A=
index a26d1e1f79..d2d686fc0c 100644=0A=
--- a/target/mips/meson.build=0A=
+++ b/target/mips/meson.build=0A=
@@ -7,6 +7,7 @@ mips_ss.add(files(=0A=
   'gdbstub.c',=0A=
   'msa.c',=0A=
 ))=0A=
+mips_ss.add(zlib)=0A=
 =0A=
 if have_system=0A=
   subdir('sysemu')=0A=
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c=0A=
index 65403f1a87..22600697f0 100644=0A=
--- a/target/mips/tcg/op_helper.c=0A=
+++ b/target/mips/tcg/op_helper.c=0A=
@@ -25,6 +25,8 @@=0A=
 #include "exec/exec-all.h"=0A=
 #include "exec/memop.h"=0A=
 #include "fpu_helper.h"=0A=
+#include "qemu/crc32c.h"=0A=
+#include <zlib.h>=0A=
 =0A=
 static inline target_ulong bitswap(target_ulong v)=0A=
 {=0A=
@@ -143,6 +145,30 @@ target_ulong helper_rotx(target_ulong rs, uint32_t shi=
ft, uint32_t shiftx,=0A=
     return (int64_t)(int32_t)(uint32_t)tmp5;=0A=
 }=0A=
 =0A=
+/* these crc32 functions are based on target/arm/helper-a64.c */=0A=
+target_ulong helper_crc32(target_ulong val, target_ulong m, uint32_t sz)=
=0A=
+{=0A=
+    uint8_t buf[8];=0A=
+    target_ulong mask =3D ((sz * 8) =3D=3D 64) ?=0A=
+                        (target_ulong) -1ULL :=0A=
+                        ((1ULL << (sz * 8)) - 1);=0A=
+=0A=
+    m &=3D mask;=0A=
+    stq_le_p(buf, m);=0A=
+    return (int32_t) (crc32(val ^ 0xffffffff, buf, sz) ^ 0xffffffff);=0A=
+}=0A=
+=0A=
+target_ulong helper_crc32c(target_ulong val, target_ulong m, uint32_t sz)=
=0A=
+{=0A=
+    uint8_t buf[8];=0A=
+    target_ulong mask =3D ((sz * 8) =3D=3D 64) ?=0A=
+                        (target_ulong) -1ULL :=0A=
+                        ((1ULL << (sz * 8)) - 1);=0A=
+    m &=3D mask;=0A=
+    stq_le_p(buf, m);=0A=
+    return (int32_t) (crc32c(val, buf, sz) ^ 0xffffffff);=0A=
+}=0A=
+=0A=
 void helper_fork(target_ulong arg1, target_ulong arg2)=0A=
 {=0A=
     /*=0A=
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c=0A=
index 333469b268..256fa0893e 100644=0A=
--- a/target/mips/tcg/translate.c=0A=
+++ b/target/mips/tcg/translate.c=0A=
@@ -430,6 +430,7 @@ enum {=0A=
     OPC_LWE            =3D 0x2F | OPC_SPECIAL3,=0A=
 =0A=
     /* R6 */=0A=
+    OPC_CRC32          =3D 0x0F | OPC_SPECIAL3,=0A=
     R6_OPC_PREF        =3D 0x35 | OPC_SPECIAL3,=0A=
     R6_OPC_CACHE       =3D 0x25 | OPC_SPECIAL3,=0A=
     R6_OPC_LL          =3D 0x36 | OPC_SPECIAL3,=0A=
@@ -13691,6 +13692,30 @@ static void decode_opc_special2_legacy(CPUMIPSStat=
e *env, DisasContext *ctx)=0A=
     }=0A=
 }=0A=
 =0A=
+static void gen_crc32(DisasContext *ctx, int rd, int rs, int rt, int sz,=
=0A=
+                      int crc32c)=0A=
+{=0A=
+    TCGv t0;=0A=
+    TCGv t1;=0A=
+    TCGv_i32 tsz =3D tcg_constant_i32(1 << sz);=0A=
+    if (rd =3D=3D 0) {=0A=
+        /* Treat as NOP. */=0A=
+        return;=0A=
+    }=0A=
+    t0 =3D tcg_temp_new();=0A=
+    t1 =3D tcg_temp_new();=0A=
+=0A=
+    gen_load_gpr(t0, rt);=0A=
+    gen_load_gpr(t1, rs);=0A=
+=0A=
+    if (crc32c) {=0A=
+        gen_helper_crc32c(cpu_gpr[rd], t0, t1, tsz);=0A=
+    } else {=0A=
+        gen_helper_crc32(cpu_gpr[rd], t0, t1, tsz);=0A=
+    }=0A=
+=0A=
+}=0A=
+=0A=
 static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)=
=0A=
 {=0A=
     int rs, rt, rd, sa;=0A=
@@ -13705,6 +13730,17 @@ static void decode_opc_special3_r6(CPUMIPSState *e=
nv, DisasContext *ctx)=0A=
 =0A=
     op1 =3D MASK_SPECIAL3(ctx->opcode);=0A=
     switch (op1) {=0A=
+    case OPC_CRC32:=0A=
+        if (unlikely(!ctx->crcp) ||=0A=
+            unlikely((extract32(ctx->opcode, 6, 2) =3D=3D 3) &&=0A=
+                     (!(ctx->hflags & MIPS_HFLAG_64))) ||=0A=
+            unlikely((extract32(ctx->opcode, 8, 3) >=3D 2))) {=0A=
+            gen_reserved_instruction(ctx);=0A=
+        }=0A=
+        gen_crc32(ctx, rt, rs, rt,=0A=
+                  extract32(ctx->opcode, 6, 2),=0A=
+                  extract32(ctx->opcode, 8, 3));=0A=
+        break;=0A=
     case R6_OPC_PREF:=0A=
         if (rt >=3D 24) {=0A=
             /* hint codes 24-31 are reserved and signal RI */=0A=
@@ -15346,6 +15382,7 @@ static void mips_tr_init_disas_context(DisasContext=
Base *dcbase, CPUState *cs)=0A=
     ctx->abs2008 =3D (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;=0A=
     ctx->mi =3D (env->CP0_Config5 >> CP0C5_MI) & 1;=0A=
     ctx->gi =3D (env->CP0_Config5 >> CP0C5_GI) & 3;=0A=
+    ctx->crcp =3D (env->CP0_Config5 >> CP0C5_CRCP) & 1;=0A=
     restore_cpu_state(env, ctx);=0A=
 #ifdef CONFIG_USER_ONLY=0A=
         ctx->mem_idx =3D MIPS_HFLAG_UM;=0A=
diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h=0A=
index 2b6646b339..ce2c1da6f4 100644=0A=
--- a/target/mips/tcg/translate.h=0A=
+++ b/target/mips/tcg/translate.h=0A=
@@ -51,6 +51,7 @@ typedef struct DisasContext {=0A=
     bool abs2008;=0A=
     bool mi;=0A=
     int gi;=0A=
+    bool crcp;=0A=
 } DisasContext;=0A=
 =0A=
 #define DISAS_STOP       DISAS_TARGET_0=0A=
-- =0A=
2.34.1=0A=

