Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A973DCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 09:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3tTL-0004Z6-QC; Wed, 01 Oct 2025 05:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tT9-0004U8-Ec; Wed, 01 Oct 2025 05:49:56 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tSw-0004v0-8C; Wed, 01 Oct 2025 05:49:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYSqaGcLqB8mbFT2xQLzvdEV6Hf+BjwXlulO8/SjsQOTx4G1b4sot/1NsVQxZLcdqwsSnCVmrpfQbIJgJeYQZB4kD1xsSP0dRB1BHlcZGcX2ZbsVQfD54iRTTx9wwDq9IZHMJgRAXU71eAAibGkUKNU5AXdPwgpOpyCuerAvC5rhTG23hxxlQlneP98uy7fDOGWZ5ZwzSBbjW7eLIRGVwETHeVBuz6/zz6TQMwOwA3ylZtoLenqKpqfgdhtn9V7/soJARShEH5DuevIm3RH70YpNrxN7ZsMraoyJOV8Y7OlfZ/nZpFflRWuHf4zcPGa+942ebgG8NwGGKFEstqDSHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJFOVbEZ8nUj/Opg5ppkZ3jZU+zTWdAZu/lor0AO2wY=;
 b=OA3UhEFAILRY2pZ50tVDUF4aId8nPHhngx3F269UbRd4bDtCPIQth2POZv29byrAjCOTZsNzfdOZpu+vXEwmEhHS7kPg9KG7v4czz3Rk2aaXIGCwEJ0AzFHTU+V9uvuZdFU6XV/TLwvkJNOUFrUm3BvsKdXk2OY0RU2loSLSWrkJi9J3IJWF8Rdg6XNmbilSkxi4O1TmRctzwBnRIpwKHOC4SRpA5YALgFGgjlxz6PTwHQP6ny0qbkhi7v50a6seBNDD5Aykl1PohbKg6yS4KqxRriDPS1DjZHS+n0+ybDtsXd4heA2bNGU8Htaskyo+znterjzgrkmgiB86DgPhMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJFOVbEZ8nUj/Opg5ppkZ3jZU+zTWdAZu/lor0AO2wY=;
 b=Nf2yIucmPrORW0L5qqkW84VX+TKuJuw634PF9PaLoJMDpD1w7D8Ac9Hh3/NsFc/rs6djnfjJYf1PJPOjHKLAdXwmqgN5pDR1HqcifLxwLs4CA1rjRKBnmkcfYZlHXswnb8TlhxOS8LKmg19TsDLJHJSwobU52um3aXG4wiUPPsdrZ4v8ZAasopyraUeHGpjZtBEpz62AQyCEfg0wsVtdVB3svv14udGYNMJaDlNEcugxp6C7gz5czSYKlccYJ15VdveqdNYjxXm6itS87uBvXSH8gWQmMOPwqMmKcUuPxE6fNTUMkZlW++L7HjOly1VHiiNICHCKPpxfYtgbfTjAVQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA3PR09MB8279.eurprd09.prod.outlook.com (2603:10a6:102:4b9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 09:49:10 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 09:49:10 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>, Djordje
 Todorovic <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v9 04/13] target/riscv: Add MIPS P8700 CSRs
Thread-Topic: [PATCH v9 04/13] target/riscv: Add MIPS P8700 CSRs
Thread-Index: AQHcMrijD4wkVu/m/0aDfxuRXDrcNA==
Date: Wed, 1 Oct 2025 09:49:10 +0000
Message-ID: <20251001094859.2030290-5-djordje.todorovic@htecgroup.com>
References: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA3PR09MB8279:EE_
x-ms-office365-filtering-correlation-id: 2dd398c2-94a2-40dd-bebd-08de00cfc5b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?sabJ6QbE7wUAm3jznD4m0i+0c0y2bJ7C6iOF2Sf06TCY3p9UxTox17ZGYA?=
 =?iso-8859-1?Q?weS2afNpP0AKjpB1cse52O86Bg3Ov3/F9KVsX+pFeO30eyTStxh+/skDxy?=
 =?iso-8859-1?Q?CFmu3HLxl0MQyhkZgR4RosXIxNpDpuRa0UGzU/f+/OBcfnFbR1dX03ZogK?=
 =?iso-8859-1?Q?1IvLVY7fClFKHn8rqn4dix+5tAuiJV9IZ7blHl4GYXtWznnfcskeeJ46xz?=
 =?iso-8859-1?Q?JP7k8FcY9mfoIJYDTlozSaxGi/72dOaVtM5i3eG0TxmiBi59mPOZfFaiNo?=
 =?iso-8859-1?Q?ZKd2pjtkWIbjxnFMorF3RIBjYpuOYY6C3zbTeXZSMfpGURPL7kdIOTxF3b?=
 =?iso-8859-1?Q?zcoSUvM0KNsDdCQYQfRsCFlOVyrY6Qaqq5PXKTb53z6RIAqz/kvT/dY8pm?=
 =?iso-8859-1?Q?gj97whwUsGyGoyq4kwbOS2hVVvrVp6sQknF+yZqBRF8Iudv3PBSEKqTzu6?=
 =?iso-8859-1?Q?IWvBzJtiqVquScxEiiXrRWu8ie8Ok+IJkL/4p1dkPyZ3x0diYoHPhXGKsI?=
 =?iso-8859-1?Q?86W51s78fCv53aVNGfjBPJo8rpnd5zcYZe3zkHy+BQDC/GFHbGu3KuNsXs?=
 =?iso-8859-1?Q?ypIGHyD0Cny9yFkTsc9gC6jdKzTYpdTZzkOPDXp5+BwyhRXZXBCAg7DmJd?=
 =?iso-8859-1?Q?E7OEtevYr4WsEd6mYzoGdzwXJ3Yd6JKn4ThtM5E1LYfyYuDzKf5DIS1Gx+?=
 =?iso-8859-1?Q?bmUD+5Defai5aD9fsoEQPta4nmnqqRYyjc+ANkhrnw1exHg/52TGe5IGpy?=
 =?iso-8859-1?Q?4eA0yFJowQua400dE2+rE2yEOgloRJpZp7U6k6fvMCscvK/VORZ62dnO0V?=
 =?iso-8859-1?Q?2sOjwEcPAZpRDuQ5cfoH4cqCbbkZ7FanPRu7dfKD8mHAigZ8CIUXKgSr6B?=
 =?iso-8859-1?Q?bQ+/YBugtzZKWO4dHkcr4gFgHMn8DFCPVvChogckmbkxOwyWALk5ogMmVv?=
 =?iso-8859-1?Q?OUEMIyLT1T0b0YNHlkVWMBnWf1SsI3GYI8VPPXCgKKiQADJggXxdn40QeO?=
 =?iso-8859-1?Q?ueELf0b+a8Q/BB7lxfnV59FrRnHFbLEyfp6wACzncDlvn2ZTOugjIpM5Zz?=
 =?iso-8859-1?Q?hrPHKgiZ0eQSRIsDkPE62qROwRIZgu2+3likOjtIuk/8kUxZRj4vK/S9Mg?=
 =?iso-8859-1?Q?0tmNrMLloY56ozb/g6ZqSN/ufm6a4H46yDSvmb4P3ETaLCeycldchFFNZJ?=
 =?iso-8859-1?Q?EExZ4w1NOTbX1atrZWOfcgP4hpIWOnC0ngrtafs+YSCfOma6vmB5eY2SvG?=
 =?iso-8859-1?Q?Tv/nQApMv4x183eXVwm0GheXmtHpJjd0acbQTr0yypZRkGrNZzx5c4CObl?=
 =?iso-8859-1?Q?aLGC2zK8viKeKvMPuPiHrqb13meor20GlgsXaNXEaYdUJDo/FH4U4EMBcC?=
 =?iso-8859-1?Q?ZZcm/zdBi26vDjQQQZ6NDziO/wJlV6NyYMSosI0CFdXM/nL1c1gOTnzLX0?=
 =?iso-8859-1?Q?n7igV1kuWgmcxsJgo8bz5cAvLEzvlQgKZWiwf1D09qjwH5V901uu6+LRC8?=
 =?iso-8859-1?Q?d6zJSGk6BPEtnY0eF5dIJit0qQRMYimoCNF1za6tD7uhDpM95JxqrlCKOk?=
 =?iso-8859-1?Q?+tzfXt9qs/3CEGiFcNDUOyIcxNau?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?57rajKyZ5aOBfnwjmGZTKUvntuvWu0G6XpL6loBqvCigIwJTJcgx/JBk/E?=
 =?iso-8859-1?Q?Ysfa4KoODlW3JsfGbMIUF7rbfZPhZ2P5JqClfkZFn2fWFEaodui8ZEju+G?=
 =?iso-8859-1?Q?8xywiiqifzUv39V2z6m3E/d/GOXkRqw9PDOnl9ZZk5GpRoDy86F6yoPfj+?=
 =?iso-8859-1?Q?fjiMYKh+VQYISTepwurFJQW+m3yhhHKUidLEt5lEASN8rHgFl8TsyJsUO4?=
 =?iso-8859-1?Q?7yehLfQ79NR5bTMXT7gZssWr7DiK2EyakvHz7BMfZ1vqGqTEprY0FqGPU9?=
 =?iso-8859-1?Q?wWBhiPmP3TA8iviNj4m725STCHu5wUj7BklEa8wRYhbl8zhL6ImcZX/wzS?=
 =?iso-8859-1?Q?2T3W3zcd/snNK96CcGD45fHtdGhDvO3zGJ/YSSlbL6ANmvKLdXW4/dAfIi?=
 =?iso-8859-1?Q?J1Fm2BORRVg33r6BC8NcguEgA+UO7HjmyY6ODCygWKmoolmFV2xd6nxZtm?=
 =?iso-8859-1?Q?ekplPpoOdrTjg+a5gC+Jda8srJj9NAv7COxowySUMZiGzPi7CiVKYD4Zl+?=
 =?iso-8859-1?Q?HZToMxPEtsAO6fIAMwxRJWTdolFAxGTSJrnL+aSrdKmXd99ydLptK7GqKy?=
 =?iso-8859-1?Q?2SPLeub3RCisQPdyMFW/Wz/IBCXIZb1RjxT+25sOLco1HR80A/Lo4oGNnB?=
 =?iso-8859-1?Q?Fnn4wEewITCT3ifg6y1MvFBt2+T49wszyzjFD41eLZImqvw24+E+JLcmMk?=
 =?iso-8859-1?Q?R85b5vpLvnBwVt/w50+f88+XWOofsHQlPQfaniGQxx8sSYQYK45ckExX4D?=
 =?iso-8859-1?Q?lVgOxwt1B/K1ClAHRxmctbET2MzdnUowYiHGdaITRLZdpY0SmjEItOqgse?=
 =?iso-8859-1?Q?OMNL0Lm/EM/16/oSrezFRh2ArQeP0hl6OuCqydZHH3Hd1z0bSxLHx+Wb/Y?=
 =?iso-8859-1?Q?SzYYuNOevURzpqkVPc/YUuCEj6P+JsKkjvgsuNX8MmwRANDEV+tLr19NoH?=
 =?iso-8859-1?Q?W5CSZ86rYy97jmbLwh8y1M8TBRe7T8+wQGx+V02/Q4xK1wJrDLk+ycodmn?=
 =?iso-8859-1?Q?8vOOysJEtK8e87oPXYW+1EoukbR7HOXpTSZ6p2JHvwLyLwRVUIrMV/PuOX?=
 =?iso-8859-1?Q?vgj9EAy4k+XNFBllPcMRNClosURHyblxi17bPmsRAb6ZqQGC/WMkO9XumJ?=
 =?iso-8859-1?Q?2wF6vnzjZqx6OSrqbWa7/voo5ViKm8+bwMaConlmKCt3C9S6Mys/k9DxiP?=
 =?iso-8859-1?Q?1X6DXKy3a0JSElbQQXA7hTNrhf5k50fBNLqC9XlFuCyurG8XXa+dh4ZhsB?=
 =?iso-8859-1?Q?k0snpwV5WqQg0rHKgtT6M8eyFVFVKTu1vQ9dS9Vwb6zvQLUnJREpspTLGk?=
 =?iso-8859-1?Q?AEVJ29GORc+XX/UsGOFKZMm2+bkg4oqytb+0XrKb2DWWTQ1Cv8CjKUly0w?=
 =?iso-8859-1?Q?F5BXv+LhA5wo/+LeEadgjD/eVTj3CAvLLtgyFOQDqrKQ6g7zQRcaakV9mh?=
 =?iso-8859-1?Q?t8aKuezkyex6ZfxfaqifnogFhq6+YclDzHbD3eRyKLONrdxhqncGTTWsGP?=
 =?iso-8859-1?Q?p6zbxob6cbYQj8OW2bUBeD56ER3r7QVtEFI6YTPbs0a5R/JMdg+e/F75P6?=
 =?iso-8859-1?Q?A9+GwRb//l4F3cEwrU9ipFLDf5895bRcR5NI4dkUX7zmbuAGY6u1HfE2Dw?=
 =?iso-8859-1?Q?l/MbhIrIJE8tZsswICJhwud595r/f1zIpcKZ55ZcXQQ0fXxycn5+issgKp?=
 =?iso-8859-1?Q?QHZg8I/v1qCq7b3tnYo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd398c2-94a2-40dd-bebd-08de00cfc5b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 09:49:10.8550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kuDr4Ia7cb05inmH9Kq5K0iVKloyVPrvXvgDnWOgaL7XaUu0TcRytohfk1O1JRC2kkxmKov5nE4CqmFIdmcUUPXvK3k7viCfoO1YDeppyZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR09MB8279
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

Define MIPS CSRs used for P8700 CPU.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c       |   3 +
 target/riscv/cpu.h       |   3 +
 target/riscv/meson.build |   1 +
 target/riscv/mips_csr.c  | 217 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 224 insertions(+)
 create mode 100644 target/riscv/mips_csr.c

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6e0bd6b798..1a1ea7fe9a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3295,6 +3295,9 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.ext_zbb =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
+#ifndef CONFIG_USER_ONLY
+        .custom_csrs =3D mips_csr_list,
+#endif
     ),
=20
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 34751bd414..234210c6b6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -987,5 +987,8 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32=
_bit);
 /* In th_csr.c */
 extern const RISCVCSR th_csr_list[];
=20
+/* Implemented in mips_csr.c */
+extern const RISCVCSR mips_csr_list[];
+
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index fdefe88ccd..25d59ef9f9 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -36,6 +36,7 @@ riscv_system_ss.add(files(
   'debug.c',
   'monitor.c',
   'machine.c',
+  'mips_csr.c',
   'pmu.c',
   'th_csr.c',
   'time_helper.c',
diff --git a/target/riscv/mips_csr.c b/target/riscv/mips_csr.c
new file mode 100644
index 0000000000..822e25e346
--- /dev/null
+++ b/target/riscv/mips_csr.c
@@ -0,0 +1,217 @@
+/*
+ * MIPS-specific CSRs.
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu_vendorid.h"
+
+/* Static MIPS CSR state storage */
+static struct {
+    uint64_t tvec;
+    uint64_t config[12];
+    uint64_t pmacfg[16];
+} mips_csr_state;
+
+/* MIPS CSR */
+#define CSR_MIPSTVEC        0x7c0
+#define CSR_MIPSCONFIG0     0x7d0
+#define CSR_MIPSCONFIG1     0x7d1
+#define CSR_MIPSCONFIG2     0x7d2
+#define CSR_MIPSCONFIG3     0x7d3
+#define CSR_MIPSCONFIG4     0x7d4
+#define CSR_MIPSCONFIG5     0x7d5
+#define CSR_MIPSCONFIG6     0x7d6
+#define CSR_MIPSCONFIG7     0x7d7
+#define CSR_MIPSCONFIG8     0x7d8
+#define CSR_MIPSCONFIG9     0x7d9
+#define CSR_MIPSCONFIG10    0x7da
+#define CSR_MIPSCONFIG11    0x7db
+#define CSR_MIPSPMACFG0     0x7e0
+#define CSR_MIPSPMACFG1     0x7e1
+#define CSR_MIPSPMACFG2     0x7e2
+#define CSR_MIPSPMACFG3     0x7e3
+#define CSR_MIPSPMACFG4     0x7e4
+#define CSR_MIPSPMACFG5     0x7e5
+#define CSR_MIPSPMACFG6     0x7e6
+#define CSR_MIPSPMACFG7     0x7e7
+#define CSR_MIPSPMACFG8     0x7e8
+#define CSR_MIPSPMACFG9     0x7e9
+#define CSR_MIPSPMACFG10    0x7ea
+#define CSR_MIPSPMACFG11    0x7eb
+#define CSR_MIPSPMACFG12    0x7ec
+#define CSR_MIPSPMACFG13    0x7ed
+#define CSR_MIPSPMACFG14    0x7ee
+#define CSR_MIPSPMACFG15    0x7ef
+
+static RISCVException any(CPURISCVState *env, int csrno)
+{
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipstvec(CPURISCVState *env, int csrno,
+                                    target_ulong *val)
+{
+    *val =3D mips_csr_state.tvec;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipstvec(CPURISCVState *env, int csrno,
+                                     target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.tvec =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipsconfig(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val =3D mips_csr_state.config[csrno - CSR_MIPSCONFIG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipsconfig(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.config[csrno - CSR_MIPSCONFIG0] =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException read_mipspmacfg(CPURISCVState *env, int csrno,
+                                      target_ulong *val)
+{
+    *val =3D mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0];
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mipspmacfg(CPURISCVState *env, int csrno,
+                                       target_ulong val, uintptr_t ra)
+{
+    mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0] =3D val;
+    return RISCV_EXCP_NONE;
+}
+
+const RISCVCSR mips_csr_list[] =3D {
+    {
+        .csrno =3D CSR_MIPSTVEC,
+        .csr_ops =3D { "mipstvec", any, read_mipstvec, write_mipstvec }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG0,
+        .csr_ops =3D { "mipsconfig0", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG1,
+        .csr_ops =3D { "mipsconfig1", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG2,
+        .csr_ops =3D { "mipsconfig2", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG3,
+        .csr_ops =3D { "mipsconfig3", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG4,
+        .csr_ops =3D { "mipsconfig4", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG5,
+        .csr_ops =3D { "mipsconfig5", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG6,
+        .csr_ops =3D { "mipsconfig6", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG7,
+        .csr_ops =3D { "mipsconfig7", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG8,
+        .csr_ops =3D { "mipsconfig8", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG9,
+        .csr_ops =3D { "mipsconfig9", any, read_mipsconfig, write_mipsconf=
ig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG10,
+        .csr_ops =3D { "mipsconfig10", any, read_mipsconfig, write_mipscon=
fig }
+    },
+    {
+        .csrno =3D CSR_MIPSCONFIG11,
+        .csr_ops =3D { "mipsconfig11", any, read_mipsconfig, write_mipscon=
fig }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG0,
+        .csr_ops =3D { "mipspmacfg0", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG1,
+        .csr_ops =3D { "mipspmacfg1", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG2,
+        .csr_ops =3D { "mipspmacfg2", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG3,
+        .csr_ops =3D { "mipspmacfg3", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG4,
+        .csr_ops =3D { "mipspmacfg4", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG5,
+        .csr_ops =3D { "mipspmacfg5", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG6,
+        .csr_ops =3D { "mipspmacfg6", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG7,
+        .csr_ops =3D { "mipspmacfg7", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG8,
+        .csr_ops =3D { "mipspmacfg8", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG9,
+        .csr_ops =3D { "mipspmacfg9", any, read_mipspmacfg, write_mipspmac=
fg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG10,
+        .csr_ops =3D { "mipspmacfg10", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG11,
+        .csr_ops =3D { "mipspmacfg11", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG12,
+        .csr_ops =3D { "mipspmacfg12", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG13,
+        .csr_ops =3D { "mipspmacfg13", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG14,
+        .csr_ops =3D { "mipspmacfg14", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    {
+        .csrno =3D CSR_MIPSPMACFG15,
+        .csr_ops =3D { "mipspmacfg15", any, read_mipspmacfg, write_mipspma=
cfg }
+    },
+    { },
+};
--=20
2.34.1

