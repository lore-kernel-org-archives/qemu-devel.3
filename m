Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42B7CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 10:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4dJ0-0003fl-Pd; Fri, 03 Oct 2025 06:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dIy-0003f5-9p; Fri, 03 Oct 2025 06:46:28 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v4dIs-0007P0-N7; Fri, 03 Oct 2025 06:46:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaktRKtpptmQCiEGw+mkawFqBXnx4XV81Roo5Ym2lt5qdi0cRR/rzW3eRIyaEU9q3CIwNEc3SebCyE3ewNVNAy1ouv4iHMu3wy98O1azSoprfbgWophfhOzFVxJ6tSX8lRedx8KwPDkPop/9vkBPMxxoeyUpyKFBeB62Q/RzvIdQi6cwmTN3ur3ol0PDk4xpqXjskpCK0v/gUvB6qgN/+sXmO+SPSpu9oerxH1Rq2d9f8TyHUM3J5kEgksqF/9EDiA/vQEJmpfl/gjZJsVnqPPk0y8HyQM2V2Q0TrSTEv3ictcmZirMtT9iUmALBDRrFJBnSm/GnAwO3TlTvKqNLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNegBw2nWF1GpFhmMfUdekjy189PygKOeeb1B4SdjtQ=;
 b=cj/EeI1VOV2DmimTfQNO4ePiRcoof/bLvgVY+2oqu9xCXgPoYyKJaoePhErMdX5WV4op4FySofmMcET2YeU9WJUc2GbArmk2dfEGL6g+Gcmb6/usg8iXsg3zMdsDYfmNNcjPJVqGMSrL0XemNMx2V0XK7uqlZ5bLUSdXQkj9Y74x5sFeiCyyKZkayHtgnkJ3v2XFBiY0iy3vMz96IKV27AX94X3tAOYeTM1go4dYAWD8uY+x+uFE+DzKrCcitbv7r1E+6pcexinjJAqvigxzsMMbw701hFwaGi/YbbvCjiOQtQ/KE78+yBobdZXYlDf+ALXJxWFEArWSwQRzzjgZRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNegBw2nWF1GpFhmMfUdekjy189PygKOeeb1B4SdjtQ=;
 b=pB9wm3BZKS966o0DiXQIw+WLWA1ELeAeyPxU5Yq/xDT+9dF5EaBTpuKNo9QkInPEagB9+4hKDNi6SulZ45kHkJC6ec94OAilHpv43uBmdZP/Wo1KuiBXeI33KDGDNBoqSWBmpsEuRmjVsazbkn+POIOQtwkN6qNRM6qe2ZgPSLy9H9dIP1/G7TkHiKq9iG6dz1pEf/+KuT4b1f5RaZpWLko64X7wcYADnb+sCNs8bXO27u7FFKpcehy4kFtMKV/L1f5XKm1yVPMlmowJngy77Sd5IuJUWvjxmCDgyw+5N8JqOCZ25gKGx1OcQAl0zpjczNdoEef2BuQ0K60QU/LahQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA2PR09MB7850.eurprd09.prod.outlook.com (2603:10a6:102:418::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 10:45:21 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 10:45:21 +0000
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
Subject: [PATCH v10 05/13] target/riscv: Add mips.ccmov instruction
Thread-Topic: [PATCH v10 05/13] target/riscv: Add mips.ccmov instruction
Thread-Index: AQHcNFLQrMfH89HEC0iAqy7qvH+GNQ==
Date: Fri, 3 Oct 2025 10:45:21 +0000
Message-ID: <20251003104443.51501-6-djordje.todorovic@htecgroup.com>
References: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251003104443.51501-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA2PR09MB7850:EE_
x-ms-office365-filtering-correlation-id: 10200938-4743-4d6f-d1ec-08de0269f37b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|13003099007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?PeVpXpCj1XMMQoTiNX1/T5V2NQ0Fe1+3s7SiUDVLw5POfgm4UPFg3v4dlt?=
 =?iso-8859-1?Q?HqmIx1z66H2XWS03LUVF6ahlLbg4/q1qyMCTovJ1mIzcpMIUE3LmajvtOC?=
 =?iso-8859-1?Q?aQJN7kfqFfhcfjNYgjXDrLHW1AvfSBagXQQxqAC80ATxNoL/0sWeGDZxBF?=
 =?iso-8859-1?Q?YP/2/rwnacEKFQyJg4j85cR+iSWjkH8kwYrbvATvrHJjw9R/sXWFvTXha+?=
 =?iso-8859-1?Q?enkhSfnd5LOUql8h6LWZ1gTFoSPtN8Nf4iNo7ohK6ZAf8MRhZGrgL/ioxW?=
 =?iso-8859-1?Q?nn/e8aJK7iPcWQZCB2S0umVxU3iH+1KenT3EXSNxoyklRTargBD7grk/D8?=
 =?iso-8859-1?Q?3xJZLZnQ9fQRKK4hMWR6FBll/MZEz+uojilAaa6XMFaPh7rGeM0+jY1AKg?=
 =?iso-8859-1?Q?eYb9kCKBHm2hy8GILwR27I+3sSUIfm94oZ2D/TEDY5iALOizKyq3PZ0XUf?=
 =?iso-8859-1?Q?hTWxCwiKTTZGFCMVH5HKtZlUM9UdYC+GL2MTtVcMAIUq/oaBO1kcpYlzj2?=
 =?iso-8859-1?Q?hojiOEPnfbRYlfLZ2Rm8AEkh6g9C3mx18kaLz3DHtIPgGMEuqn30kHnhG4?=
 =?iso-8859-1?Q?Ss1xN7wir/oJPfgS4BQpaCN+qrHXz/L7MQZUOuCfUGZyhOPyc1X+rXcls1?=
 =?iso-8859-1?Q?ckYVuRNEO7vYb8Bn4uuWnjhPpdoNRoHhrPoPdbDAdXl+0mJNFNIRdCPUXk?=
 =?iso-8859-1?Q?TjHP49+b9qorgZvX/Yw7FtzJSqXe0AnajaZe0Z1Hk509Lv8h/chjmizZaS?=
 =?iso-8859-1?Q?klAS46AUsOHA6HAZIajjYxM2RPu4xQuBJcFnlvSfKTImU81BWLeVY1Bs32?=
 =?iso-8859-1?Q?jkJDe0NH+KnorFBYAm0/mUz2Ptk/kqzuEr2pa6sJcSdiwBk3Tz8XtDujyM?=
 =?iso-8859-1?Q?1hg5nLlhOm/fB2gWPLxKqaJE/z504N4nDPtNXIRSJVBo4dIAveSaCUF/BY?=
 =?iso-8859-1?Q?K+guRCS2jxuqGMHna6+8VClsghj4IlyrwwQb3N0pl6eSiG7OHAGbw8H1Wx?=
 =?iso-8859-1?Q?qjFiM9P8sm7gBMMDnnFctc2xOhPFoGerIvmn881AdT8ur9LeMraHyt0O3v?=
 =?iso-8859-1?Q?1JkjXQOTVsbL2pdKEgfe+y4VWv8b8CJkZY4KJU3NOrpm133W3bSX/qyDXr?=
 =?iso-8859-1?Q?F8mQk09MICO1h4czUxILRwrtp2VDBlaNqVfgsyp6hS5Ag6KoMnn8cTIFLf?=
 =?iso-8859-1?Q?h/0njEDsUoXFbULVwEPyrtY1bbwScSYB3h4ImaCkw0zONO6m2SZuQR1Rsd?=
 =?iso-8859-1?Q?5q75dXTXMYv4KagzzoYpxJHg2rKozzwbfQ4r5wlAL10qydLWwGQI1j3f7f?=
 =?iso-8859-1?Q?BXYnxxWfVnSfUs9cn8cc/yoYhj66nDvINa6TCJCYibYFcwVLhhp0l6VOAd?=
 =?iso-8859-1?Q?wDDFBwRJs1yYQTnGpi30+Wi9Ylet4CuMOPInclVCO3lkqnOooSNRjBQWki?=
 =?iso-8859-1?Q?fdyO1LtB3MbJmJ4NcDwgE7sFZJTFDRF3l4UvIhQS+Ds3u76ERzXXdQfA7Z?=
 =?iso-8859-1?Q?0MLVAEtm2Ih/6laNtMQFRVzfE1jTRFT+Fm+zJ8bU1ekw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(13003099007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kHsMXmzJcYxY12IQklEYNp6ez8jbeW1lv+TY34obpEuQGvu83s2hhpV0ig?=
 =?iso-8859-1?Q?Y6IQ37zmhH0e3lzAR7E+zspUIQutBf1pPW1lU2eALz/g1YlY0U121E5SO4?=
 =?iso-8859-1?Q?Ki9Nc1Z6GH1mO9benK4WzsWHCsfnM2sTIyHvdh5Y1WHOECPEl5hLZcJcDl?=
 =?iso-8859-1?Q?IE2ghDFAzQduFCvQATYRsJ8sraYj6oJcZABiO+TQv/pHuOtPKYUZpTly1p?=
 =?iso-8859-1?Q?RJWQ1yleqz4tWGlT50USv6b0UNTbW/VfDWtDhTtHhzlZY2Sav/B044e+Kf?=
 =?iso-8859-1?Q?YA0ItuArFYmkHpOK/RWwu9bC/L7zagAuUAi+EMCSYSV81BU1NAcJkYl0dk?=
 =?iso-8859-1?Q?xDFX07qEBb5EGkDWle2Ja43SdnK+f7MCjIMVQnAvF0wEC2uoFsPtqbjRot?=
 =?iso-8859-1?Q?M7ReiyvV5pIIm+guOidzXTK/SZKO3OCFnrV3Wgm1y2oKVGXjFbNVGG/7Z5?=
 =?iso-8859-1?Q?nhyrXaHhByMcc8jJZPVfueyU3eVcjxVj9dVZDJVFxTjEDV4wkS/fd2Sczv?=
 =?iso-8859-1?Q?xruH4KUF8rG5kddPSA0g+izSjNgoo7U6gGx8j8WsvLddBEVCuOPdDpZgk8?=
 =?iso-8859-1?Q?+u+FPOxkYZiqxmtYAJKjvOYPFMVukRoqyRE+LIxgrY58cKaPjarTNfxLLF?=
 =?iso-8859-1?Q?6IqQqi4kjvwcLA/dOnrSHVi8/sbo20t1jrTIRGHrnM3fP4ZpW4F+qT0UDB?=
 =?iso-8859-1?Q?nr0doTiDlugWLjuqH+S46/VeznD+1cmMdGyIu1IwNp6kIqepI8dY2/ZuOP?=
 =?iso-8859-1?Q?U2Bsnt8vOZnP/LpLg/VIotr5Uj9fgtsyVgerC8+RJwa0hYD5sa22rqGaQy?=
 =?iso-8859-1?Q?twVOPXoSP3Q64ZTMEbJzun6dlqfyFH4gpq/TMq1NxLvzrSrdwEY8DaOetb?=
 =?iso-8859-1?Q?ezTKZrQno8aEsgKaai1TxYu3FvafpNKQmPWkoxxJZuOzBGK5m4fEVx3nn3?=
 =?iso-8859-1?Q?JTmQRb78GmNKg6wXiDBU+ThDPUiCuUeqrW1XeQE+pbNqnerDzJMO5fX9KE?=
 =?iso-8859-1?Q?4x1FN2th+5q01vrxDJKJgZMENmfvhAJF4OlZtBgLpXFEeJ5opB5jZz8K/B?=
 =?iso-8859-1?Q?Yi13tQTzzpGQnD4Cq4J5ZqOdX7/PiDyxyjWJhRrLid7IAfUT7uhf2Mpaei?=
 =?iso-8859-1?Q?38W9MCRzonltdOgVg/gijjSh7sOzjNTwpUzWSMSHoens/28TnVM1zPwb8A?=
 =?iso-8859-1?Q?NxkB1JPbqO6UIu02p1gUKydqxJizSUSg6+vUnc2fHb83J4bj7ErXUVuKWZ?=
 =?iso-8859-1?Q?SWy07Qd2l+CkJ3sHEphBoZ7a17oY55wAGmEjWszGZ+B+E6gFu/CVLWnfIQ?=
 =?iso-8859-1?Q?afyW1QhzxDNl19hhxy59MsAD4kt0q1eR5l751yT3nPI2651kchXh7Ev1gZ?=
 =?iso-8859-1?Q?cKpWzf89LgQkGvzQqb9yx05HHdFyI6cjlhNxpbjagxTOmpuYtuI5TnJnri?=
 =?iso-8859-1?Q?mwrjfCd7jVCmj7/Vo+VEjuVnY+r5PFQ3I/0zs5WAPsIKydajHOGQIUH5Nx?=
 =?iso-8859-1?Q?lCYwPoEjVRiZ0jrCkYH5ZPlZpripvoANTNHH5p49SfngB+xTfMSRtAKMtX?=
 =?iso-8859-1?Q?9Qv9hcdaMQa77e/KXok6Plt8FAwvxxHZPMU9u6YK3gdG0q9tLByxPeKoZe?=
 =?iso-8859-1?Q?hGUqgTiUT7TDMm12YOW3knpoXEcCmcMJglUVtgTUaTlpz4Ik6BZoEh69LS?=
 =?iso-8859-1?Q?Y3fs7DvynCCJNmwHS9I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10200938-4743-4d6f-d1ec-08de0269f37b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 10:45:21.2593 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ugZ1sBQvjGIw6fsb1BxxzvTAzV88XNo/HzWLIwMaPzWuR5UovEoUXdA10Una0RWCImjr/GbOwx/ZzG0yHGni9XcC6Cz4XYnWQ9ndUGvlfIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR09MB7850
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

Add mips.ccmov defined by Xmipscmov.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                        |  3 +++
 target/riscv/cpu_cfg.h                    |  5 ++++
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 33 +++++++++++++++++++++++
 target/riscv/meson.build                  |  1 +
 target/riscv/translate.c                  |  3 +++
 target/riscv/xmips.decode                 | 11 ++++++++
 7 files changed, 57 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/xmips.decode

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a7501dc77b..b03068fc8f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -248,6 +248,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1380,6 +1381,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
 };
@@ -3294,6 +3296,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index aa28dc8d7e..2db471ad17 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -36,6 +36,11 @@ static inline bool always_true_p(const RISCVCPUConfig *c=
fg __attribute__((__unus
     return true;
 }
=20
+static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
+{
+    return cfg->ext_xmipscmov;
+}
+
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
 {
     return cfg->ext_xtheadba || cfg->ext_xtheadbb ||
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index e2d116f0df..a290303ee7 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscmov)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
new file mode 100644
index 0000000000..3202fd9cc0
--- /dev/null
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -0,0 +1,33 @@
+/*
+ * RISC-V translation routines for the MIPS extensions (xmips*).
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Reference: MIPS P8700 instructions
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#define REQUIRE_XMIPSCMOV(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscmov) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
+/* Conditional move by MIPS. */
+static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
+{
+    REQUIRE_XMIPSCMOV(ctx);
+
+    TCGv zero, source1, source2, source3;
+    zero =3D tcg_constant_tl(0);
+    source1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    source2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    source3 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+
+    tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[a->rd],
+                       source2, zero, source1, source3);
+
+    return true;
+}
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 25d59ef9f9..3842c7c1a8 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -4,6 +4,7 @@ gen =3D [
   decodetree.process('insn32.decode', extra_args: '--static-decode=3Ddecod=
e_insn32'),
   decodetree.process('xthead.decode', extra_args: '--static-decode=3Ddecod=
e_xthead'),
   decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decod=
e=3Ddecode_XVentanaCodeOps'),
+  decodetree.process('xmips.decode', extra_args: '--static-decode=3Ddecode=
_xmips'),
 ]
=20
 riscv_ss =3D ss.source_set()
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9ddef2d6e2..66d31b67d3 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1194,8 +1194,10 @@ static uint32_t opcode_at(DisasContextBase *dcbase, =
target_ulong pc)
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
 #include "decode-xthead.c.inc"
+#include "decode-xmips.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
 #include "insn_trans/trans_xventanacondops.c.inc"
+#include "insn_trans/trans_xmips.c.inc"
=20
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
@@ -1211,6 +1213,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, t=
arget_ulong pc)
=20
 const RISCVDecoder decoder_table[] =3D {
     { always_true_p, decode_insn32 },
+    { has_xmips_p, decode_xmips},
     { has_xthead_p, decode_xthead},
     { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
 };
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
new file mode 100644
index 0000000000..fadcb78470
--- /dev/null
+++ b/target/riscv/xmips.decode
@@ -0,0 +1,11 @@
+#
+# RISC-V translation routines for the MIPS extension
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Reference: MIPS P8700 instructions
+#            (https://mips.com/products/hardware/p8700/)
+
+ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
--=20
2.34.1

