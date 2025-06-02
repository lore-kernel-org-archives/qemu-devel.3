Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DA0C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 13:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM4y8-000843-VJ; Mon, 02 Jun 2025 09:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uM4y4-0007zr-Sr; Mon, 02 Jun 2025 09:12:44 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uM4y2-00029C-UD; Mon, 02 Jun 2025 09:12:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Srnqu3yihMm4QVOUcX4tJB/NNAqgSvb8pbamZVL/GVzoKGItrw/tDTTw9vRFqjIUT2fJ8JcTWPmC7sHCayf3HrOtXrgLPpdlLVfbDjgydA/2TMqt1OsAlcPcyDHFoluIfEy7xtzrzSNHuhEHH5vxXbDESl52UiXHFjJB/+ukcUlSz/pUV5n9IPBw+zo6570MqhSC4nGdqnNpkSmXeDrQATGmAS70n9mJ/zO3AE0ZXcaH0FzE4A8nR2sapsIGpUb/bjQ5qDYfXMGBMR99eTXYkKJxeIfbsO19bCKZeuTlJlbfVN/59xfmiesJSYicogtatsy8sTkf0qF3vXLL1i5kBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ae+yv7mEYmfnrFx3F3733qCPc9igzoMaFyQjIliq77c=;
 b=LCjGQ3ND8a7nIFA+W30v6lk/umk07TU1TNZ9pBYhTv93A5HAJdFqQevyL7FpdHFIuZ7dMW/QGeZISoVxNeK09+889CSd40N5tIpM24YqZoIEB981ZthzhaTpkQv9SR9esL66YCZdDhP1JEC4UKTPsaJUGLLn7Fz/3Bh5bqvZFcyu5J2O2T1xgHNRhOeVSdd6j+lXGHNS8gd/0v8jBAoxQpTN9YQLes2PYF3rZWzIf+7fMWGxz8oAk4aT6+cOn0F4jzyOcV3N8iRNmzgbE3tIpKtbc3aQex5v9nngGc2mi5N68j5qRDFVwODx56iAyyJNyt1h19WanRh11ITwTg9C/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ae+yv7mEYmfnrFx3F3733qCPc9igzoMaFyQjIliq77c=;
 b=h9zrpjCVqDcdlHE+x/QQwjUzQUeprHPbS8XrB0bZXh96Na9aLOKViwzfUt5pPfdpkB0ig2/5PEqk2ja21pysyei/30tF5L646fqOAk995NcT2ScAef+O1X9mIp12559FfLMBdY1/f/2DXRd7NzbRwlvpJ2H7lhFsCGaj+QHQBTO+ALhc4sJyVfelYYmM+MSm+Ixp9L1vCBSyx1NSFNVjEgs0B9Dkebd/m7QEPl+GEEZsMKKUsgFgoN53EUqFf6H1EcK5H+eQFNJ5FC3YQ4w79uIuNKv9DYn/UEiudPR+vWiv9djxs+7xvX69sB3ltEnpcuSSdxFE7qEh6eIsrs/W6A==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by FRWPR09MB8123.eurprd09.prod.outlook.com (2603:10a6:d10:19c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 13:12:39 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8746.030; Mon, 2 Jun 2025
 13:12:39 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 9/9] hw/riscv: Add a network device e1000e to the boston-aia
Thread-Topic: [PATCH v2 9/9] hw/riscv: Add a network device e1000e to the
 boston-aia
Thread-Index: AQHb08ADf1jsYulmHEW34I7hgkj9yw==
Date: Mon, 2 Jun 2025 13:12:37 +0000
Message-ID: <20250602131226.1137281-10-djordje.todorovic@htecgroup.com>
References: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|FRWPR09MB8123:EE_
x-ms-office365-filtering-correlation-id: e0d0093e-4f69-4787-ca64-08dda1d72697
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?3AxBJZhjYbKSVNGUtpt1CH7K+sdne3kRa1jIv1J8PFG509ksR9YPD8zb6q?=
 =?iso-8859-1?Q?/yi6vsNoJK3TpdthhGTbdiGpKo48yuqbSdMjm3AX0n09+FYnz5mynzM4/x?=
 =?iso-8859-1?Q?QIHC3x5zu2aHRS7n1YtGubdusftvn9svh4+ccHPcp3p8CKLuZRJPUE03Bx?=
 =?iso-8859-1?Q?1KFEuq87CD3ofWCj49chxZbtTO2bWwsG+P6HZEnv1pzNlMJlda++CwMjis?=
 =?iso-8859-1?Q?T/8FA0H1g90TimmtbgulQJtRPFm1DQab+XgwjtAE+8HiXbDSwnOyiqr+Mg?=
 =?iso-8859-1?Q?GLPK1ZZEeENJWqrQSxS6OcDzmNqDObvUv0Xld/eqh+ycV2NbjbGBYl66kj?=
 =?iso-8859-1?Q?mQ7+Ia+NRPfz02kkQcOo/YeegnqYeh4JSVjpkN4jf/qMgJ3ywgGn9WHpaL?=
 =?iso-8859-1?Q?m+MMFRqQ5YaARb/rgi4UYASvTLuPOdOfCjaOqGkwonvddF52m2aIaa8ob6?=
 =?iso-8859-1?Q?zv0PilkyoAsIieRHAM0F4ZcxMn/bscIRilyRWVh0aHSkaYS9sWb7i1yZy6?=
 =?iso-8859-1?Q?xz42TbfH63yTD4WzuwZFWeNSnh6jFLiJdaVUSuh6WL8MaVfdOFbKRgFgx5?=
 =?iso-8859-1?Q?Ej7KomL0dDch+FykIhcWVIWs7XXxDRVn2PW3HwMqOuM82NG5DzdgdMJ5B5?=
 =?iso-8859-1?Q?sPgdt5HgaDTxs5CeTXCfOHo5zK8dTE/Vu8VGZ7fryzGuBHoUD1uPkb00Ai?=
 =?iso-8859-1?Q?pqe8GXkbuI4azdw78naKpB6bsJxhBDMb1YLGLm7x01PYb+j4U+wb4h7p/L?=
 =?iso-8859-1?Q?ahWkUQjLUP+okaX0PVBELPqztCi06CGirivXKA8dVkXEOupn5sWTyTaCDn?=
 =?iso-8859-1?Q?e/X/BdoVH0WFeQqhf3mI4VVJ+5Y3LkIjvyeKmKUxdL1IBJ3ICChZPiSwxV?=
 =?iso-8859-1?Q?6rl0M0atHRE6CyntdT+OIUTqPNWgv/JCZQQy3i/NpUaZqSB95Kc+VFwpmP?=
 =?iso-8859-1?Q?jixjAfQY3mqwC8bV9MZkrpUbMBdQAJDj3fUz3cZMFwC2tns9Sq/prJfrfs?=
 =?iso-8859-1?Q?pGQwPbT2dWcZ606dfdrmCJ0N6OHxadtxZHkBMxhjMXjHJxAAZYdTaFLiy0?=
 =?iso-8859-1?Q?EEM1v/wOTKObbnPAJm4uKhqueTEFFqNztn94I+eu8QdA3DZhR88YzT6qKs?=
 =?iso-8859-1?Q?JhyKF+w9B3VTWPn6I/J6TxSzTCIq281uPfxQLuxofOEqUc+FbVIwnX/TXT?=
 =?iso-8859-1?Q?KtJaRlQSumhU4nHIuE/0TgfKED9gouXGCRvSP2hpHQeAFxd7K2ZLXiGTjE?=
 =?iso-8859-1?Q?YYY/c/0/LjnGw+lm0ZBPdRLrsrbSuDR2R5X2zB6Nh4Wfq77NOC30Vhd7AE?=
 =?iso-8859-1?Q?ySd3sG5gjUfLy08Y7K/98P4qwgMcrEaUAMidvOCpg5FFwwHiFrF+RcGw6l?=
 =?iso-8859-1?Q?u0xYyyuGRtgQ8Hgi774VHDo1kHRM+NgimiZBBvte+rPt5j7JEvZw/fu708?=
 =?iso-8859-1?Q?xTkfgLaktSxL7r1qvtewAHiWxV9gUU8SY3xNnqxSV9RzBximz9S9KSp0ee?=
 =?iso-8859-1?Q?RW3OcUyMwuyGsPnWA+vRXY00eHD4If3veLDXOyEvGBqWZ+PAtZRLqC0boH?=
 =?iso-8859-1?Q?8n9KNlw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?j/5rVJ8MimJ3sEFl3xr2Pbx3U1LTRS9lLpoGPKH1yoP4N4MAAOfR3MVJ9l?=
 =?iso-8859-1?Q?btboML5Lpg1U4t5sGFWSet4JWn9or0dl1813qe/Vc1lGRfJ9g8DZA8ZHu+?=
 =?iso-8859-1?Q?tTdsNGZLofr8un9v0grVS7TPBdD1xVZwAiNR8z5yKsWr/HuP6LgCLHNCTJ?=
 =?iso-8859-1?Q?HObeFeNPSS1xwOyHvjQzlmN2sBvV+HWWHHUhIFAGAPLrZSzYYphLFSk3Tk?=
 =?iso-8859-1?Q?GmzNrxxkyBsdNt4uUgb5WHSdjjiJBm/biR/73g5hqSyDbBY2C68GQtNb96?=
 =?iso-8859-1?Q?uiF8MzcEYPSYsV3mLtThBNbSg7J+5QLrjJeSIB/82ZB8jiSmnW/mOKrh0u?=
 =?iso-8859-1?Q?FE06KpQ2GC4nH6DT4bbHYTxobu5wwhdBuC/IxnketHN+KFrU2ZM64+PamN?=
 =?iso-8859-1?Q?m/ot2PXb+BBrD+Zt7FopSAz4Zbm5kE2/Kv6otwpYKXQB+dBRbK2T+vu81M?=
 =?iso-8859-1?Q?G79xuhgdmIHxuK/FJ1qnH5Q/8BJAwcsP9CGFItFTUlpva96BxWTdwKoXFc?=
 =?iso-8859-1?Q?fxty5IMUQlG4cBkhg7jLfNoTOVci8no9JAik95EanMRcAWXa1jEsiIOKnf?=
 =?iso-8859-1?Q?6vZ9y/5WvTtIpNRo2+lJxdezV5kTMeBrwMcbYvg3aUnND4SpLES/QvBn1d?=
 =?iso-8859-1?Q?+YtIla7dBe4Dv69mytxuHVmNklay4Pr6zxJfDT9F63yUBvmDPmi2fbLgLj?=
 =?iso-8859-1?Q?YaQugnqDX+HoK70KEA20O0PDOsEBaq+FzF7x5wP8aSpINzT38Mlf+YxbFn?=
 =?iso-8859-1?Q?LWTAfN8+O7MAEAppsciGVEXHdBhoZrpiJS8wsqcnPEywKeW1nHxki5Bs8Z?=
 =?iso-8859-1?Q?zrJDs3pdNCgEw/vfGGtFEpaYS4xMYCyWVkLJvXJtSfLTiuRCL/edIqCjYx?=
 =?iso-8859-1?Q?dzjnOXNmv1XZRdrWUAX9kfFu6HyxayCA+oq515UJVAzUqKNZSIkWmdimLg?=
 =?iso-8859-1?Q?ko5tXkSy5D7MWkjLTcR0UxBtAp6VDWJ3YPdJ32R9+aDSnFwC3hzc9xwhOO?=
 =?iso-8859-1?Q?z4Ky2IVmvtHSFBXHch7BT1PxMoHMmbKqhp/KHtgxtNaMxgnYvLIkU8fm/9?=
 =?iso-8859-1?Q?fq+DS+XZNbt4VupRljG6oZuTq3n1HU0235AZBfJiT0OaFZAV12eIaPFg8o?=
 =?iso-8859-1?Q?mnE5/wSnLXI4A8dkfK54fmhl50NpWzxTDOv3y36RodU3O8W9Aqr+xmtOkx?=
 =?iso-8859-1?Q?drFzcTS6W2XATSan2YbslGeGzxNTFDlrZobriCKImaeJT12ApjhLHaIBu8?=
 =?iso-8859-1?Q?09Lh9FfJUfoo7qOM+6GBHF+oVqJVXSv5ycrnHmSewBCilkGufk9ZmIY1Wi?=
 =?iso-8859-1?Q?tLHAY4PF38Q1sOczEFI99BdlsrNwmGjc9qRbezbsfmcdW5HfnLXaQMPkg8?=
 =?iso-8859-1?Q?gMfd1iI67w2SiH1JXolFQsADmJFt3PnfWwSjILGKWKCJFDFQJ/cveDgUKq?=
 =?iso-8859-1?Q?GgEJP36bQTZ7NFgPN53rnXFJn52j7gs4Uw44F6cl4ZU0qNQfo/AC8yPAjA?=
 =?iso-8859-1?Q?ZFGfySoOpCDbaWHTqLijuRI5l83AKfg8kOodw59xBAllI22gRWT8p5bKaf?=
 =?iso-8859-1?Q?5WVHH11/s217nJjfMVeLeYBm7YdDuCJB+WDnEn8k1+hryBsww0ZolCi9zb?=
 =?iso-8859-1?Q?SXNG4JyjcyI/RLcGCI31g/RJElkc96SlH7cfvumr9eyv6BDOjKXEdlx0rw?=
 =?iso-8859-1?Q?AfhabbXnbKp6nZpGHUA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d0093e-4f69-4787-ca64-08dda1d72697
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 13:12:37.8577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yNR76ypqE7fCWrRRo+Sz0w+xenb584ir1vcRNiiS15FsxgeIqz9rszDL6RpI+2KdW6z432JCjhVcLw/6IyyzDc/OVYvcLLv8beqasULFgXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR09MB8123
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

Add a network device e1000e to the boston-aia board model.
There is no pch_gbe emulation, so we add e1000e in slot 0 func 1,
instead. We need to pass func to call pci_parse_devaddr to find
out slot and func.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/pci/pci.c          | 15 +++++++++------
 hw/riscv/boston-aia.c |  5 +++++
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index f5ab510697..23f7f02837 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -974,14 +974,15 @@ static int pci_parse_devaddr(const char *addr, int *d=
omp, int *busp,
=20
     slot =3D val;
=20
-    if (funcp !=3D NULL) {
-        if (*e !=3D '.')
+    if (funcp !=3D NULL && *e !=3D 0) {
+        if (*e !=3D '.') {
             return -1;
-
+        }
         p =3D e + 1;
         val =3D strtoul(p, &e, 16);
-        if (e =3D=3D p)
+        if (e =3D=3D p) {
             return -1;
+        }
=20
         func =3D val;
     }
@@ -2045,13 +2046,15 @@ bool pci_init_nic_in_slot(PCIBus *rootbus, const ch=
ar *model,
     int dom, busnr, devfn;
     PCIDevice *pci_dev;
     unsigned slot;
+
     PCIBus *bus;
=20
     if (!nd) {
         return false;
     }
=20
-    if (!devaddr || pci_parse_devaddr(devaddr, &dom, &busnr, &slot, NULL) =
< 0) {
+    unsigned func;
+    if (!devaddr || pci_parse_devaddr(devaddr, &dom, &busnr, &slot, &func)=
 < 0) {
         error_report("Invalid PCI device address %s for device %s",
                      devaddr, model);
         exit(1);
@@ -2062,7 +2065,7 @@ bool pci_init_nic_in_slot(PCIBus *rootbus, const char=
 *model,
         exit(1);
     }
=20
-    devfn =3D PCI_DEVFN(slot, 0);
+    devfn =3D PCI_DEVFN(slot, func);
=20
     bus =3D pci_find_bus_nr(rootbus, busnr);
     if (!bus) {
diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 6ed5c636cc..34cc0abe79 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -437,6 +437,11 @@ static void boston_mach_init(MachineState *machine)
     ide_drive_get(hd, ich9->ahci.ports);
     ahci_ide_create_devs(&ich9->ahci, hd);
=20
+    /* Create e1000e using slot 0 func 1 */
+    pci_init_nic_in_slot(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e", NUL=
L,
+                         "00.1");
+    pci_init_nic_devices(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e");
+
     if (machine->firmware) {
         fw_size =3D load_image_targphys(machine->firmware,
                                       0x1fc00000, 4 * MiB);
--=20
2.34.1

