Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065EECCD19A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 09:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLHcP-0007Sl-7b; Tue, 18 Nov 2025 04:03:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHcL-0007Ob-QV; Tue, 18 Nov 2025 04:03:19 -0500
Received: from mail-francesouthazon11021100.outbound.protection.outlook.com
 ([40.107.130.100] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHcJ-0003xb-0Z; Tue, 18 Nov 2025 04:03:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0LFMcwtG6l883+PDQHhq5aGOh0SQeyp8/z1yqkCBLQ2fIE1NzRpXOPgwWi0CI1igNHWoloVUHRxPFePf2DzZoPY4MuDqUPHJ/iKtcBazBfYHeCV3hA4qd1GW36+2o+OiBgs3+oCdjzMGFgrC09YWA/kXFyHBShMr6cMendzMvCqLWgQnfC94ozpAdW94Pj+vR2Y5tOa0yGU8m4SQbJiQZCtiHqsX11DUJVw/Rjc0lykqCI0P8I+5UroQJpKuR8OzCoszWe4KsRRLX+BnrcTG4El4zTZ4dPpCxiKcfz5P5E1LsXWic3RzIPy5jZaGCJPltSum3uJllrVNIRBHQXcAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/TwECIyTxKnGlLSNCUXAIqcqKwuX3S1AablrYXs1eE=;
 b=Qne/Bv/WRyY/xxxo8sQgomoHzRL9VRBt5g6pcU3jW71bEGwMxZZUc1plUjVq1rIezPKr/6wRfKp+GRRuMp94sxPPaBxwXge2x0jez2suQX3Y33v+SctZVZx4rEZ8246N6lNudQpnKdR0C316XwNTkCxuLPoOrtPMzuY25FM0jNMEVYgdgK6plq3SFKfarXUuK5aANTEOgp9+VRM8VbHXCskGI/5QRWkaepWV+xumZeSGpLdeSgC76NzZuAHDSheP0C6iEoAp4r8fePVkPOm+KEhsO4JqDdcs4kYkhsB4vTjw34seOrnoCgjScQCbWwMtfL94z57cE081gGlUf2EA3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/TwECIyTxKnGlLSNCUXAIqcqKwuX3S1AablrYXs1eE=;
 b=JrIfqh24g7EI0iTWxkShrNZGmlC0EjB+/4QrOB1cCKvAxMAtM1cT5BhxZzyLjdjfCiXGTJVAYGDmRq5TeptVaS1YDTNCHhrgCvB9HCHz0/EqZbU975FfRS42AhMZ4g2xybSj6WMv7DgYIXOW6Zod2LVttenPl8ha7IOi3CMyB6n8yCPrsM90z+i5Yer1AV4o+L1aR65aI1T8VQ/IMo8LQXvSV8fQakSLUg5divKZ7LMRan3rdNbUqhfS6oN+KKZos1IEoFiMCRNCUp3uBd37FDiJW/ueUFkyzQZgReauaoMo5HypxwzMTY2NhStuhdKaRKSrbBExJBuwm92Bshw8uA==
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com (2603:10a6:10:303::20)
 by DB8PR09MB3612.eurprd09.prod.outlook.com (2603:10a6:10:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 08:58:06 +0000
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2]) by DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 08:58:06 +0000
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
Subject: [PATCH v14 01/14] hw/intc: Allow gaps in hartids for aclint and aplic
Thread-Topic: [PATCH v14 01/14] hw/intc: Allow gaps in hartids for aclint and
 aplic
Thread-Index: AQHcWGl0L9oFn+xtM0Cs4fOU5V4bXw==
Date: Tue, 18 Nov 2025 08:58:05 +0000
Message-ID: <20251118085758.3996513-2-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 24054c6e-dca8-4d71-22b2-08de2680970d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jFzENzSNI04BTB1iXOVUnTUXbTDjsTTih9PbYDuHl7+h42azU9bL+fhxsh?=
 =?iso-8859-1?Q?Kw4oC0SGEollJQ89BV+zUr3SI5cu93KCwdF70sjvlGp1cqHUDvCoG2nvyb?=
 =?iso-8859-1?Q?0gSu0UXKXle8im4oFgHWA/XWvuadnh+J1G4kxEe4i5bcy/blL/OYDvMsJd?=
 =?iso-8859-1?Q?gNiAOpKdUpDfJfyuANhwcdFyUuedlKZlkXmwT+CFunQYHFbIAgLbzoGRSs?=
 =?iso-8859-1?Q?URdI9UakahZ8zoLuYGEmMB7MsnPdKJZrClW/Q9TgFTHjKX1BaRvOZfcwbZ?=
 =?iso-8859-1?Q?gXQSDDRWQDS/siLigy3Tkbflqh9kc0pNLBte5QzKnEB/GpBzT+LdtUQcdS?=
 =?iso-8859-1?Q?A3cFb3FNUY48wVHk/1fz4OFugAosUtv/9L0+eGArE7SbuepXIZT9K0yW1g?=
 =?iso-8859-1?Q?9/beLoy72LZ2qGsDPm5OEqMyIk4sTltCH4iNxVtpJ9uY9s+GNYx2lfAY0U?=
 =?iso-8859-1?Q?nqjKzkJ03Fi+INsngUoB9XHZ4XT/frEzVAhDYEBQkc6Y0uT3aproGrr1wj?=
 =?iso-8859-1?Q?MXZWCOta4Air9QIqMQh95XQB2liXa2iFQimT19yE8Gdc0aO9H+sJpdXkvX?=
 =?iso-8859-1?Q?gxj9dKcYxsBoI3dKDIo2yuwN2ChL2GUpcb/zs7z50+rmI3LddV5sP2b2kQ?=
 =?iso-8859-1?Q?HsxjsyioFdCfPVW18hTJUC2htZujgIWK/t2qByASXNuh/vFFsc+b9OUfcB?=
 =?iso-8859-1?Q?EueLtoHa4KbyOhG5sHFwnEotBaE0O8UPHxJKNhP0eNILIJWdOoyBNhLWjN?=
 =?iso-8859-1?Q?+DQvYc3zsYdxXPiwcVNKGgAxjm5N2Ly+Xc26MiwvmyvpF674u98/Ia3ALn?=
 =?iso-8859-1?Q?bAHZbhh9eV9g1f/ydFUoiO1aXxMrRkjfMHRCYlArvjP/2TdsYwA/XVAkCj?=
 =?iso-8859-1?Q?lhlZ9tLtuY8MwVQeMJNa196NNm77MkYNBLWMD11u6WFTfgFd8WQ4j/14lN?=
 =?iso-8859-1?Q?eopez0EEqkSVwhTfFEF8ewloZwk5e0sbLc2P0tsorMVD35ya0+IOLOSzPW?=
 =?iso-8859-1?Q?yCJ2/GOg+hJKKzn3bs+DSzFbZBjGff72YFApg0J20GMWf6zWO65UERkD4p?=
 =?iso-8859-1?Q?TKwuMlY1bgsHzA4A3yp0rnpz6E2f9md2yYJ42jp0GEaN8WvsazkZc7h1/f?=
 =?iso-8859-1?Q?LP2qSz1+1AW6xkWQbcXcVR+ktn3yb/pi9YgSaTfs/Az+KDXvbSBdFGvFz+?=
 =?iso-8859-1?Q?qewfa0JwQUM7esPNo78YLWz8LLHTBD9br4aa1KV7tK0Dk5+aO+HOLafAo9?=
 =?iso-8859-1?Q?wmFAG9LK65UQC2/rnvYgcwJiuOk0OBiyx07lxSsF1474ZBLNl7oB9bIa0A?=
 =?iso-8859-1?Q?gVztKmU3GMtgPycLKsfU+5cdD27ET/FahhGImw4AcRgM3xpa1t2r67U6As?=
 =?iso-8859-1?Q?IA7Fz7PYk9T7rrlrdk/fEjlyLmXBipVBi3QZ5/cJ4R6MOUVEeRzUn70R79?=
 =?iso-8859-1?Q?bPT2UOp6lbgW8N+/bSIMDLU5vs7RKIZtqmR3usFJmlwklZd8S6nWrL++RG?=
 =?iso-8859-1?Q?kPHQQXBqqaz5QgIvnNdKHnlYzHdRLUcCWG706S9gH3z6fo0GXHj1IU8Hnz?=
 =?iso-8859-1?Q?kN6nhPFbQIQ2HbYaMfP6MUXny+fQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR09MB6506.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QmJ7j/ygljWQGKAP99bhcY4p7hQeC0k6GWAIgDMZM7atCjjHMzQh6S4ArL?=
 =?iso-8859-1?Q?Ow/Kodbr+7bZHvLBxNR0mqJ+PlxPEa3HfVd5JjRugzaDgJoTiNghY3Moz5?=
 =?iso-8859-1?Q?vombmVz96npiOu7qI0MwTWWSOMZ8WJzvmFbS387IqHKkrKbKYSsjKgpwK+?=
 =?iso-8859-1?Q?HBtzu3a5h/Xky4snp6nmIMlTf7QcGWxElfgMeINyXEAHWNbPE2HCtt+YEN?=
 =?iso-8859-1?Q?UEq+fz/hTL5bSkkTsRX/tOtkLs4Pot8DEOvmTEdleD+U8M9aGSYJp0v25O?=
 =?iso-8859-1?Q?MOtIr+h/urB834TN3/yGfz5/xOJCCUBVHwbcrrfxgyLGS0YF35v+UYXAjM?=
 =?iso-8859-1?Q?RLWmZJuchf0PGzARsIJwZkUiCi4ssvu9fLJLrCJDQiFaG8ZABtgMOF0lez?=
 =?iso-8859-1?Q?pnj4hYMgHK4cwGDQkKakPtvTFS8hekqtd55B24nIr3a4Fkc2cERzzQSPmL?=
 =?iso-8859-1?Q?hlehAgWUtCJtjL999hUtW0HZN8z0oelHO7Bgsj5df9yjrMXd98VBWbu/jH?=
 =?iso-8859-1?Q?DAjlG+SIvm03eAvGRxe6YRjvQc9QeUYGcYrc4ev9t/IIo9+XzGi1zEwHc+?=
 =?iso-8859-1?Q?Huj3DH+09TYNXxQr7BIw+/2/RiVBxtjgDQaPkymbo9sSmXOqmI4wI/bFlk?=
 =?iso-8859-1?Q?cawUWF+cX6Ks6MOHuKatGCWDpFnQ5pGS/dJ+d83kIXHeT3WIzadOefIwYV?=
 =?iso-8859-1?Q?y0+qFbrEHm4MvTXz+5YaszK5WPP6ThFzvUq4ioqRhITCqOn+fW9aK49w6+?=
 =?iso-8859-1?Q?9f6J10rkebzbx8/Ft2RgAPUXJUrGxnz4MT4TU/rjGFPJc5JaodUjMWobR1?=
 =?iso-8859-1?Q?6JlrvCrArtK8NNNqGlNVxv/lGw9lm7OddudaVyNCD/g4xfIoXIguElmCX1?=
 =?iso-8859-1?Q?XQozDhfFMu+doMrNFCAUnhH6jqZuGBz6/wwl94+3CThBnzh88v0SkWefL9?=
 =?iso-8859-1?Q?lWDAUG9Jb+jRfMZiL0A+MD406hgBEbPD3Wru9rAaBFpsaGuNFSp6G8oFxa?=
 =?iso-8859-1?Q?aPz9TDM5Q954blBD8X65bMCliTPMZiXBdV2Su0cAFuYEP2UzzgPQTH4Wwb?=
 =?iso-8859-1?Q?QPdKpSt6G2MN/wS122sbmdyjGT/zJf1lvns+8AC1+IxZEbxyVIcHlxxfjr?=
 =?iso-8859-1?Q?sZRtAdNrcNO0S+4I/sNYlRU+SxWZBe0h+uwuJi4A4dxP17bJmDnY5wum9g?=
 =?iso-8859-1?Q?gfkvubcGLRFAc7e+q4qAquQ5VkJfIMFTHVoVHCcQ7R+wHN3cw2elFBkmwY?=
 =?iso-8859-1?Q?thF0XwwsM0IYQgIfVDksyw2HAc9HoUnw0GlhVU5Iqs/umbhMr2+x4/dhu6?=
 =?iso-8859-1?Q?GL/jb8Nj1dkQ2HwNbrVkfg6n/EBKjqV65e2O5BMmzizUxBa3u8Z/BmmoLE?=
 =?iso-8859-1?Q?NXLB3U2Egqz4/7j3Mges6zcnqdsXehWjWP18H6BZszm3zIdQtmpRzAbj31?=
 =?iso-8859-1?Q?0gbff7Cx0WJuVGRAJVAPKRAy85jtr1Ij9brxjNQTdtSQTXGZF58+SB4AU5?=
 =?iso-8859-1?Q?de8va5VJYNavAibYCHYMknU+Lm1yyPd9+8HkOHf0Xop1OJSodhEQrEXpQF?=
 =?iso-8859-1?Q?pbPTl+gkE2uHmNTyBSUmcDSvm/pSJUR5U6+DEH+g62mFDVDrWpVScw310l?=
 =?iso-8859-1?Q?480zwCm1qN0c1jx8f82IAvIstcMesLzgIDcNLjiMOg8Px4EIOidURI8DKj?=
 =?iso-8859-1?Q?/KS3fsQzbtyXFsCEvFY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR09MB6506.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24054c6e-dca8-4d71-22b2-08de2680970d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 08:58:06.0426 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QJizCR4tvHxevqctEvftv0wHl6GbB0F3htYdseDjQRLAiYl+zFptPqu/Q1nImjGqEl5oUoWJujy9QYwYO8DVejmomO6pfmQ2dKGaYp03Z8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB3612
Received-SPF: pass client-ip=40.107.130.100;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

This is needed for riscv based CPUs by MIPS since those may have
sparse hart-ID layouts. ACLINT and APLIC still assume a dense
range, and if a hart is missing, this causes NULL derefs.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aclint.c | 18 ++++++++++++++++--
 hw/intc/riscv_aplic.c  | 13 ++++++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 4623cfa029..e3e019e605 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -297,7 +297,12 @@ static void riscv_aclint_mtimer_realize(DeviceState *d=
ev, Error **errp)
     s->timecmp =3D g_new0(uint64_t, s->num_harts);
     /* Claim timer interrupt bits */
     for (i =3D 0; i < s->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
+        CPUState *cpu_by_hartid =3D cpu_by_arch_id(s->hartid_base + i);
+        if (cpu_by_hartid =3D=3D NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_hartid);
         if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
             error_report("MTIP already claimed");
             exit(1);
@@ -486,7 +491,12 @@ static void riscv_aclint_swi_realize(DeviceState *dev,=
 Error **errp)
=20
     /* Claim software interrupt bits */
     for (i =3D 0; i < swi->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(qemu_get_cpu(swi->hartid_base + i));
+        CPUState *cpu_by_hartid =3D cpu_by_arch_id(swi->hartid_base + i);
+        if (cpu_by_hartid =3D=3D NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_hartid);
         /* We don't claim mip.SSIP because it is writable by software */
         if (riscv_cpu_claim_interrupts(cpu, swi->sswi ? 0 : MIP_MSIP) < 0)=
 {
             error_report("MSIP already claimed");
@@ -550,6 +560,10 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint=
32_t hartid_base,
=20
     for (i =3D 0; i < num_harts; i++) {
         CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+        if (cpu =3D=3D NULL) {
+            /* Valid for sparse hart layouts - skip this hart ID */
+            continue;
+        }
         RISCVCPU *rvcpu =3D RISCV_CPU(cpu);
=20
         qdev_connect_gpio_out(dev, i,
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index a1d9fa5085..77cec8ece9 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -903,9 +903,12 @@ static void riscv_aplic_realize(DeviceState *dev, Erro=
r **errp)
         if (!aplic->msimode) {
             /* Claim the CPU interrupt to be triggered by this APLIC */
             for (i =3D 0; i < aplic->num_harts; i++) {
-                RISCVCPU *cpu;
-
-                cpu =3D RISCV_CPU(cpu_by_arch_id(aplic->hartid_base + i));
+                CPUState *temp =3D cpu_by_arch_id(aplic->hartid_base + i);
+                if (temp =3D=3D NULL) {
+                    /* Valid for sparse hart layouts - skip this hart ID *=
/
+                    continue;
+                }
+                RISCVCPU *cpu =3D RISCV_CPU(temp);
                 if (riscv_cpu_claim_interrupts(cpu,
                     (aplic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
                     error_report("%s already claimed",
@@ -1088,6 +1091,10 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr =
size,
         if (!msimode) {
             for (i =3D 0; i < num_harts; i++) {
                 CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+                if (cpu =3D=3D NULL) {
+                    /* Valid for sparse hart layouts - skip this hart ID *=
/
+                    continue;
+                }
=20
                 qdev_connect_gpio_out_named(dev, NULL, i,
                                             qdev_get_gpio_in(DEVICE(cpu),
--=20
2.34.1

