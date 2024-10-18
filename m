Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B6CD30008
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1mtD-0008MI-5z; Fri, 18 Oct 2024 09:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1t1mt8-0008La-TC
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:19:30 -0400
Received: from mail-db5eur02on20729.outbound.protection.outlook.com
 ([2a01:111:f403:2608::729]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1t1mt5-0005az-9l
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:19:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y625CU7ol1sb7JvK+30yQjcVoU/nubhqOPNGwGan26/BvZHWPVjgVb0BrD2XRv5xSbJxHOy/rO1rsi3fIMOxbl7k7HsYFtoEBbGUpLbYOq60FBMhSP8zbvDfp1NAgg/rSt4O4ort2U5S9uDWYKjCaO76noQ5jrEell8dWlbgCgxHbdZDA2bLkohcH4JvARDAO0FSY6StQ0Q+oi3RLsZyWm/X956+F4tYmr2DSjvHkYOlJmEk4Ibpb/GtzHvMErvNWq3BxsRFvZNus/qJl+CKIdbt+gWcl0ST1i6+pcpbteGPltTd9gVkeaP8pzJq+BfBt8NP1m8kvwa2ocSI+k5JDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laIGXlrPJrOF4CIktZeKC+Mdh4KBEEY17olu7zYoTvo=;
 b=uABqNze6KglPDG3Uddb3IB5Wkw4A5BriTfKf953rH9vSBGO7sZcyaqt2gYeujVscSwR15iZyaPUJj+iVoxSy8Zc9Js9dvbiWq8y5w8V+MGFJCO8l1xikjRqAHvoAyHFRlUmTWweGF209a7Wqd3EQR3+AgFXchPE7XAdDmpJMRM4ZhpxfaNSkcJNfmOS9/3FRKZko8u1DgGBwaVyMoUl6s5QWuP2rtZUr0CBOQwOWOk73WRVNjYFtW6ak9l9a6TV8fTNyuFjLBy3//ouz9XPhjIRYk+r7S2IAWEYz6NmaTJC/n3g9/3+0TMeTrsfTQvZSh8r/iSK/WfA+bB5FLM95Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laIGXlrPJrOF4CIktZeKC+Mdh4KBEEY17olu7zYoTvo=;
 b=CPUHeKPsthbHHjYidHEDK5cqcwEBE3p5YD3Smaxwlk0Y8tHBpsR8386Rhv9hegZeCXARTca1T56wseLeAAvOE/rVvnZ3h62XmcnThH/2BrXY2nKQnKT2U77Y2FwE0zYVjJLjFeu3KWs2Hz98tLd5VnaMGNe1dK7X6V+IjhjZDFmKK6K8r4DSyz9Cxs2u2J/zcZKhy1PJU52NG2fgWSygKvot+oaLD1smjWeVkgvTY+pN482b21Xf1TJ6XsQh25A/G5uDli9GMEo7ByRxkR16MOwrgbGs/TXxGWR12n1e0TDNrWynrn2MQ7ETBPJK45WQ9Tjm6yy45YE7UXFApcGptA==
Received: from AM9PR09MB4851.eurprd09.prod.outlook.com (2603:10a6:20b:2d4::13)
 by GV2PR09MB5889.eurprd09.prod.outlook.com (2603:10a6:150:ae::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Fri, 18 Oct
 2024 13:19:20 +0000
Received: from AM9PR09MB4851.eurprd09.prod.outlook.com
 ([fe80::2fed:370:dd45:13a2]) by AM9PR09MB4851.eurprd09.prod.outlook.com
 ([fe80::2fed:370:dd45:13a2%6]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 13:19:20 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, "cfu@mips.com"
 <cfu@mips.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: [PATCH v2 2/8] Add support for emulation of CRC32 instructions
Thread-Topic: [PATCH v2 2/8] Add support for emulation of CRC32 instructions
Thread-Index: AQHbIVx/R3c9oMbvj0aG2U7xVQ7y0A==
Date: Fri, 18 Oct 2024 13:19:20 +0000
Message-ID: <AM9PR09MB4851159EEED6EFB71176524684402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR09MB4851:EE_|GV2PR09MB5889:EE_
x-ms-office365-filtering-correlation-id: 71509ca5-f32f-49a3-d824-08dcef7779bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?3OL3NZJA75IuPmnPTC8f9afEoRNV2bvk8WYbF5NIoTwQDSGeDvtxKkTJ2j?=
 =?iso-8859-1?Q?9DGl17jQrL+zlTlbxc/L2fycElqsIeyueBBNtjt/bCaCl8+eB3oh9lriEm?=
 =?iso-8859-1?Q?GoUJrgsdDJ0B2AhTN/5cF1z8JQXhmzCtr72IjTNxrgN3/Bsmw7Z/8DUg0/?=
 =?iso-8859-1?Q?GQTOtgUaszI6F44RATaJFrCr7Z3tEl5+SehmczoOgAuXfw+aIXQde6cpsA?=
 =?iso-8859-1?Q?zqCQvTRva028kKkipsLh0GzsILMVUSXUsSvnwvlBDd/a9CQzL4nv6i9HRe?=
 =?iso-8859-1?Q?6ifct1keLDezIGYEIqz6GfPqADeTtAADXq40pOXBAd5hZHNRnKkgMefwS2?=
 =?iso-8859-1?Q?AQ/uXthmdWvdpP4I2AW/g29Xc+s22GOJnLItoT1GGtiNM5XNfDoMgbMK2n?=
 =?iso-8859-1?Q?jdDoTGJcNDuiO2pPvTvi3g4Kqud0yZ8+W6LGaNpLFA/5RxQHkeILMpb1sp?=
 =?iso-8859-1?Q?Y4e7mcSzqBWG0GgFIuFsEmSCQTSNh5VTBw2W/5QBi12rhTnBNio8wzxc88?=
 =?iso-8859-1?Q?lNfHIOZtpjxSvRDyo1pcnqYukeCQ7buqLfy3Tzmq/SfHc2Pi5vanl6k7Lo?=
 =?iso-8859-1?Q?xK4jF+MDVEl+meorRxHqZbLDRLOGL3LNRVX4dJ8zrLi/Dwcyd3Qa2WyPH2?=
 =?iso-8859-1?Q?j9BFIDeLtH7t19TIoKk5Kn93kC0KXXoAPL44CDWWWcL4tB/+XYlpPr3GWc?=
 =?iso-8859-1?Q?VJ+5NA7h883FRGteR/lSKfCdynPMsWRulPnIIH0VKRYnY0HPZyaDCAl2Ja?=
 =?iso-8859-1?Q?Wxz1YoLvAOuiEIeiuVjxL0GpwXuSq3fIwMlkwl8QgJDqzwVFa5uD/vDaT/?=
 =?iso-8859-1?Q?Vyqw4qIUvY8NM1KtVmGmXPXQ04NaqjEw+fqw2HK3QHYbbq5sR0qc2k9IBA?=
 =?iso-8859-1?Q?jqtoCosBhRApAMk2a3/J20yPIfCL/B6LBN85gBfzq/qB0LY4dF5Vm7+zfA?=
 =?iso-8859-1?Q?xKKdUnNXr9ynWI6BOSVoMroNirHM02PimfB8DkFa+kidYqmRMJWDeCbcsm?=
 =?iso-8859-1?Q?ktHOTaayfRR4qouL3vWCvcDZmot+18wiX5yLyauWMVblCN1tyfIKKVtaKg?=
 =?iso-8859-1?Q?bDqRewRFyb9oX1WWaCwhJ19V0pMIM132ffh5F6r840Ail8ts3TxVPkDkMR?=
 =?iso-8859-1?Q?nSqld3rU+K7X2SO9MnDzFvChZLLiJBqvsM+ckoPyszpOk7XSR2NY1nbh3N?=
 =?iso-8859-1?Q?1+Lig2+RyLbtMSoz8NwDkAuphgQu9cJVQRsZhjPHHdjdzp8TwrwB/X2mjS?=
 =?iso-8859-1?Q?MiyNnfVCWYpFYIyWPHR3oSWTr+AGfy9+31M7eVv3EN5fTnMIO42hVEcS/m?=
 =?iso-8859-1?Q?cvLq2r+3DRnu3mcpr+0oURsDCA5/IVem0lHX5zxXqpkNm95Euke9hh0NRX?=
 =?iso-8859-1?Q?XxrrFlsyuR67sj5cNWxHeLY30fV0DA9LyQLJRdaSpbk+SMBv/SeLCBJROz?=
 =?iso-8859-1?Q?y1wOQjGdfZpH+Esh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR09MB4851.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DMDnApg9hmB+PytEEqPTC412QNbncpSV3mDapvNz5waf7JsNZSC2fS9Sj4?=
 =?iso-8859-1?Q?MLw5rtbLA2xV6f8HXe8QGjayFUPZbykyLGYhOaMt4hDDGuSXCUDEldjT6x?=
 =?iso-8859-1?Q?EP84e+Ndzt1RQiZHLKFxrlnp/3B9dIvNESi6QKY7+672oy15mltg2n4FJx?=
 =?iso-8859-1?Q?dgT0Ek03S+FEk3WNgEiHNZbIBlO+OXWrKSrni7Sh3d71qSKU6DyopdDwv9?=
 =?iso-8859-1?Q?7QOlKWSMbv58SFJW8N5B3bD9QvTQt1Tmb7xqlmOzaAvRH/KLX6yei7JWE0?=
 =?iso-8859-1?Q?lyuiGkxeOIP8YlneVsRuakNwsBlZbgjRRk1m5EcDk/XrBiAAzEIXYdxqpz?=
 =?iso-8859-1?Q?tivrdirgM9keinfeGN6Xn6gtB07TQjrVim5QhTz5iMChtx15HGU8aVt4km?=
 =?iso-8859-1?Q?FmGh59TfCJ6u3+pjngHs6OUFMjNaXJCsEU0Bbt4skTgB4hIfrHBhJfFDiG?=
 =?iso-8859-1?Q?EwAmBvjSXBCtgvHnXCt4A93T47o4lNM3nM+tbQhkEOmIWe25YuyK/LPtYb?=
 =?iso-8859-1?Q?7n8FPdfRTAatAyUJQV/mx/y7U4TWbBIF/rIGnTt5TPpLND0e6UL5SD5pW4?=
 =?iso-8859-1?Q?wX8Z9yvgK3pL8FRGiB5mItWZnuKLC5nLT0VgknSahWrfLXNuWax+Kyt0cH?=
 =?iso-8859-1?Q?WxFFO61LKE0QeGXvClA6nO/kWIMXn1Sc6oLt+QEhwDf4XOC4bUFcwHjImS?=
 =?iso-8859-1?Q?6HOy86EMoRWWET+6NYfzQbG4g/fkZ2/1/BEgmNaaj0cAStzT/0OKvv3SQw?=
 =?iso-8859-1?Q?UpWP9oU69UkVvKcCZgr5wF8ew7VIMODudVqZPUFW41lthOiOAWHQLsz1RX?=
 =?iso-8859-1?Q?hpsZnxaEx0ezNReNmYil91Kqi79ngc5HUeyZoz8u3MkDb6i3iYUVePT+9/?=
 =?iso-8859-1?Q?+5V3Fi04xC98mVyvGRrk0GpKKD0z4xsCuBIjYCYUczkcjHPKAtdunemmaK?=
 =?iso-8859-1?Q?dU58Nl1mRSSAhnkpD/xEWr0bMWGzC5384Jk9jWufqh7TY96PbPdSz0gPa0?=
 =?iso-8859-1?Q?QquzHHhgzj3R6OKH6cHx51quSZLbCtjC673KQ89fej7cFp5rudwlqyCjnY?=
 =?iso-8859-1?Q?TrtfwOgKH9olQQ4U7aUP/bbNzsEO/GOuy9R8iPF1och7DJwMJRa0+yQ8J3?=
 =?iso-8859-1?Q?DWOJu3L+vdx8CTisdzM07rnE1AaFRmPGlizv/RcdrPjb6UmGxZEbS6Kr1c?=
 =?iso-8859-1?Q?4Qj1ghpUPtxdh1OjTX4Ajq3D4WvhjCGa4jIXhvxo5gRM5VF0fmWJlusA/M?=
 =?iso-8859-1?Q?+jmWaN7SOsxwJJ0yp5oF9Cxy1iSLyfinqb1vYdfVf72Hs20WjNjrQEBmFC?=
 =?iso-8859-1?Q?+qjGLST74QsgXAvVvg951cVVYJ42KxmJETRPsvsJKkqPubtjqrGLUScctm?=
 =?iso-8859-1?Q?L7BhrzoMLTm0waT/qwV9/efXCzYbtDg9WqVWFTIR9bWuQrGGFWibvBGpww?=
 =?iso-8859-1?Q?OcoU7o8uQsHKWpYhwMSz+8rxAv7i9hQf00Ll30vUyf5PXdf33dO4uYTjVF?=
 =?iso-8859-1?Q?IUgsdjqu6cXrnt+7FVDJO4FE6XY3sXzPt7L9UO2Mus6I9J+80HcE7AFmOw?=
 =?iso-8859-1?Q?SSMee39sqLk9Lrsi9he+z4qIBlfGkTKHl+QiY2KTDxoJmfvDR+GdYugrrI?=
 =?iso-8859-1?Q?cFm5tAUGV0pMD26g1xFGgU/Lm8at/ayVJlVi524f5ep9MmnskveXw7Kg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4851.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71509ca5-f32f-49a3-d824-08dcef7779bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 13:19:20.1892 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GS2JOb6lE7V3pb81xZbkoN0E3v73cU6rgt1gOSLu7FmagXW9FzsMRyz+mUpLxj7UX7bctisXSUCnwTD6Qc56/Nfj4btTjDLKtLGQERG0Fp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR09MB5889
Received-SPF: pass client-ip=2a01:111:f403:2608::729;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR02-DB5-obe.outbound.protection.outlook.com
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
2.34.1=

