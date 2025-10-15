Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7E9CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91EY-0003QG-ML; Wed, 15 Oct 2025 09:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91EV-0003Ol-3W; Wed, 15 Oct 2025 09:07:59 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91EN-0000mp-Mn; Wed, 15 Oct 2025 09:07:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmgM1z4sgmKC08wprmS0g7WcQKWyPpKMixJEzvXbylHhAU80bhUyq+8+Ae8M62+E1lW9RV+SCFgGg+dVZ4FuMIUbGVMvkbFk4uhVGD8eL7b1D3845brTtm6eK4nXBsc5dBP9Jf1iVy39ymy4olvRlP+gA5P9zGoSQpvq4ClzhfQegiNfDhHz5lMbSUbYdrhLgqKPU2z6WO1/bDN5hngOKo5wO9uxKD1T6/qPbY0hrqMRasqBEKFef2sx6KiABkI4hnvJu5twkx8ZXOwnDxshz32saN4qqt9Lqf2ENmp3Aw/EV8fn0lJA23THrkhapG0hWLQFtBr7hm4zXMYNf0YR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvWSndUPaVYQQkHsmo+vl8oRxpG9eJoh0LxPt4lJ8ik=;
 b=D1PuQ/Jim7LhRr1C/JDZGayWVXxYzzWYIqXtZeo7nqf+auxuSqQ2rG02q9hdwzRvFaRJ2T15jUKY/7fMD+qlSuMK8mJhR9ybqYInbmpDURIjzhC8VLbJMQfh6VMx/TG4D9XUFgXGiT7wWOgfSsmMTOk+oekpxETDyH3iTHPd3TrbUY3ZHJvzcp6H7VM+YYXA/Krv/fv1carb85whn5nhgP8z+uNCull8NPK31JPrpJtXj0ZLI3FP+FOxkNq7WW/O1S5qjYfAZlkvSUB3THDWKCRXna1mA3W5L5bwIpVkB7ADCgs7kazy2XVwvHZbfMeuUOsMflsgV8bHNFbXsbFusg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvWSndUPaVYQQkHsmo+vl8oRxpG9eJoh0LxPt4lJ8ik=;
 b=HqR69/1af5tqbQgJLyOGe5vS/fnAIuRpDjoIzbFjCyMLbSBUpJVUflDKMUtJcPhCqs0IWbi3IfftXT4sIXqA0hPnRzCGredvKZxi6vgnerSqhF1U9R0PYXeUvau/8eLGoDm25yR8wU/s0JyGahQ1JpEWsXve+KMLi6ZDmWK5JYICUNx/SwfwfP0RlMNQAmLiiG+/1/6J14q+4i6i2ezWPo7E3LgOebe3FRKy87HY+tLFU9OtcMaxeFKgn45QzcnMvrlcjZ4O4ftahNA3gSumZvM6NoTGJykd5Jp6au/UbFmu8mVdh3fJuuqYKEp9PXicI+lLBXvTBfyIzF/AqOdhUw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB9PR09MB6057.eurprd09.prod.outlook.com (2603:10a6:10:3da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 13:07:07 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 13:07:07 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v12 09/13] hw/misc: Add RISC-V CPC device implementation
Thread-Topic: [PATCH v12 09/13] hw/misc: Add RISC-V CPC device implementation
Thread-Index: AQHcPdSbkdM7UwidgEqmO1t7Yk+PyQ==
Date: Wed, 15 Oct 2025 13:07:06 +0000
Message-ID: <20251015130657.571756-10-djordje.todorovic@htecgroup.com>
References: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB9PR09MB6057:EE_
x-ms-office365-filtering-correlation-id: 57f90412-8845-4606-c15f-08de0bebbe47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?7+1f0tXF83rc5GdbDUHW+ueAnjlysF2dgfuc5hcDeps4kDZD+PsotKCqQJ?=
 =?iso-8859-1?Q?2TVZ8iqKu1DZ5uhraXmpaHEgAMEnt1j2loNV/kHJd4fazwbNSFtolgVsi7?=
 =?iso-8859-1?Q?YWVdio5VMLhf+MIQCfVF7yRzQFgff63IrXHSAG3osojcQ1RD3Gbq1kCgMT?=
 =?iso-8859-1?Q?OZ2zi/tnlJAMl3M5gJ7DCHXKOdKhmgjOUuRj0mwVsZcoq/XGpZFIkLb0aR?=
 =?iso-8859-1?Q?gkwl0jHsNT8VSzW0sq+MgR075r65RxTVI+EyRz1svF/n4SfMVRQmpkPttG?=
 =?iso-8859-1?Q?iqtIzHxohM7PgN7Lehl40YH5g6tOM3VlckaWc4M77MiSoD7mdC+pyHVsvh?=
 =?iso-8859-1?Q?DNpjKGGc65wpTLmGdpMC+M7zV9aP7vcLddsslAaDuoEobmnZU+ofU6udhA?=
 =?iso-8859-1?Q?6wtTa9d37N30N795ABsUJB+4nEykU8uCwfvJzBxC2H/yzJM5nhVifw7Tye?=
 =?iso-8859-1?Q?swcUGPwSULDDvC4uAy73ygscZ0q/CNGY5MthHIqcXtYe9O7dS96S/Deu7s?=
 =?iso-8859-1?Q?DOvnmYZJpvYJoGlgpwr8plyOjpTEIYWAy+BhBdeC/WF/6PW6pd7RS+8qk0?=
 =?iso-8859-1?Q?1UwLLMGzckEhC7muUl6zUcl+viaBMjdw3MwcCsXSrQGuBgM8pdakoYSsOS?=
 =?iso-8859-1?Q?++TwsSb0tkd9Q5Fa2UXFgVv5BYKVO7x79NN974yz4GUiF+6OMfIFmLIhgJ?=
 =?iso-8859-1?Q?SIXjK5f8UXqcUg/3i8sYchNcxaELeUVZtQgL7lHTRPmEOipF40NyIvI4aD?=
 =?iso-8859-1?Q?Uqs+pmaNpK1hSz44ldBGTyhf4yFGuttxOaBpXU9yU3NwqruBRge8DYbzeh?=
 =?iso-8859-1?Q?AK6SXw3Yegtv2xJmVPjbuyi/75hiRRGCnhe3h86OdrLwqpTOdnD+70Jfsi?=
 =?iso-8859-1?Q?/zMqtNmiiIYCigvvEt4MCjeqd8HGzN1MqPVfseeYnfMD1HcxY9+BOCyK5o?=
 =?iso-8859-1?Q?4Pei3htj9IipotjuYNrK2PEy+bDx5A8Zx4MhJGrxmMMl2K6NJrCbFvX9rB?=
 =?iso-8859-1?Q?LNQVo6dX6YAmJNiT+EWhVqdkKo5+6CgrERFEflALtglnaM9kkBERaAwajI?=
 =?iso-8859-1?Q?UiIbdFHa0UUUZ2lnPrKGSeivAeqBrAL4zJCdQl8UXP7rwXKL+chtTqSbwb?=
 =?iso-8859-1?Q?Lv0yrOecg8egdBAaqEVQ7ZVuzA5h3MbXYz+C/Lnc346n+y9I43OsRuWe58?=
 =?iso-8859-1?Q?PtVLXpwSe/VOrkBIm/CwSzwgXTX09jvbItFUoxYOdUt4iSxThjjgury3C/?=
 =?iso-8859-1?Q?y5/0YdFpXUjoCbS9epuwm9713TxVSiTvcn/D81x5XdIz5B8cuJ5nsauy8h?=
 =?iso-8859-1?Q?Lvb8GWUdIY9oCqXmCwbcUIN4x4ncyFGGUHPHZyeOhAdmlv/NgETiv8YTn8?=
 =?iso-8859-1?Q?jTuS8Dgxvtbd1BNrnxK16LEhFo6es4jT1wty174iMILu49iZZOfpvsp9Rh?=
 =?iso-8859-1?Q?gl6+Xbs9AaF+2jAcixPWTbYleOzGPpIPKXAT/EhJy9ygZS8nvSQ/3193Dx?=
 =?iso-8859-1?Q?aZ5mAPGpnNWYVtRmKvoDSxtyz17Jsa3sNg9tqqrpM+VeN2DcWI3EdDMzbd?=
 =?iso-8859-1?Q?gkuAPn5Wd4vppYbeWpLM3InlWiQo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JS91qx1Rr7+4BjMcnfca/djr9PTMEredN0P/TLQMiczRF8ZJqhvccKfZHS?=
 =?iso-8859-1?Q?Hw+zAV63xBy6LEgw/WDY5TFuDMkA6wtVkI9Ia3e7+cW0Zice0QqDrUxWY9?=
 =?iso-8859-1?Q?VYZtxkwstft9VB+alkDX/amw21EDzqIIth4ObLcErOIFMWeXRKaQg/4sai?=
 =?iso-8859-1?Q?5o4Ld77Greb9BZAh6k97RR92Ga01siv5ieYpczopPW0YjneAF9fDXdGQeJ?=
 =?iso-8859-1?Q?h+pOS2drW1214k6hSGnMQYOulMMkC/lE+HBDhOepTEEfUxo8syWdo12JE0?=
 =?iso-8859-1?Q?fMfbDYAhkrshG+mk/NUOK8vGlgqFfhDNsegsXn5i099E2eWJyVYRcmpKuR?=
 =?iso-8859-1?Q?NCUcvbMvuhsEAdwGs4/HSy28pogjGDwn7STh0bRR2QVKZkYMRpq1JPiNl7?=
 =?iso-8859-1?Q?xoXWdTcvonvlppRdhOC7jvhdFbc3Pb9QubND5Zzqpg8v+s7F/1ykhUwTW6?=
 =?iso-8859-1?Q?NTGuCk5quv44rBFyxqpWfPPx+SWJHgvqhoQaPiKGabsfx2JP1b0FjLlHbX?=
 =?iso-8859-1?Q?7vcBuQRUXz5e1EHoAkb+Q/05uZFxihMEYCRCvgguMIYPmUwehTDQwXCIA+?=
 =?iso-8859-1?Q?AsbxMLKEnr1jubUQy+GeekifY0kuprJP/kmPz33IcgtfJkXONWNx3jRfpJ?=
 =?iso-8859-1?Q?QIfEuVqHWzK1XvV66JWT0IGtVUq7qcF2EFV2xGz0xnsnPmfYleIXbmrO06?=
 =?iso-8859-1?Q?l+dA1fYFVccw29uaPdZm9WPXloD31nb6vMN9G2RlChK8329f1LL8AXOmPU?=
 =?iso-8859-1?Q?2QF0rI8g3YSuToxOujUREa9ypWLlOnULJL68yppsAZvY/qqoqMQkDjA6CO?=
 =?iso-8859-1?Q?m8ol9UolzDmASD2y/mrv5mGo8xIqkRtY+y/IIdIySUbcS6tAlUyAbwUR6v?=
 =?iso-8859-1?Q?rQT1nZHa15OG7I07xVipX4xpwmTd3Jma6cOVrDEOG41o+g5QPrj6wqoqK3?=
 =?iso-8859-1?Q?dDxTVI5z0eYS1TaNb3JcuIG9H82gt7K3bJtY8X81wc14hy268JbeAP06vN?=
 =?iso-8859-1?Q?KTSpYNLF8ECGSMwbzvud1bxtPuzQpaAeogH7HKyCkiqQdByn1cNmTr0JzX?=
 =?iso-8859-1?Q?jx2GY4h27PvJR0FhEj76eX85XRN0utTS8uGNa9RQviwvrUWj+5JPzoJp86?=
 =?iso-8859-1?Q?6Z1m7DVB/DQ5rZjq/EUMQkKthplcs1m4MGP5W1WWoidd5n8kcHBD4Wobqc?=
 =?iso-8859-1?Q?r2HCCSGMfUtxvxDZSJ6p8M0AGYFrrk9v9CYS1cB/qMyvyN8P2rVNxDjbAc?=
 =?iso-8859-1?Q?8BsZoq6XjAWuJEp/RJ512hQQgXwVyl/xe9/8Nj2NbRbjMB4Q9xoNmOGZe3?=
 =?iso-8859-1?Q?XRWxWwlVSwGxm6TMNvUCliFf2P1znH9K1xRtTfy6AtBzDS4hJmzBtbBWaZ?=
 =?iso-8859-1?Q?ndRmTdlcitrHZojRduU0wVDP0JHTxrvuY95sqCekExldBAOMakQitGgZMs?=
 =?iso-8859-1?Q?iaK5k4qamKXD45ngtSwBdtkYun1EcBDWIUVBZcrMTmgxpm7viKRya5J5C2?=
 =?iso-8859-1?Q?oM7JEPQBxdR9eHhq+sbTqrmy/OVFL8TylKnKfbLxl3Jf2AB4vfgGwM+SWW?=
 =?iso-8859-1?Q?Arf8nGajuP22G+na5VtP558sMlQSeGeZriX17g7kVjxm5yQwytRA9+TDSl?=
 =?iso-8859-1?Q?LyqO1WtDQXXvp2CPRNavpoOpvcCS/0UJbCG4wZ1mt7/PFZSEi12x/Ei0UB?=
 =?iso-8859-1?Q?jhObfQH3HEUFo/PYlM4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f90412-8845-4606-c15f-08de0bebbe47
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 13:07:06.7888 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MAeXwQK74C5iYbzqPz/GgkOU+v8XtO8j3rTKX5TJRYNy86h1EIS4symNBVbgGXgY9cOxYppFMKjEbc9sqjvKCfcH3FHHYn1aFRrj4wjGiEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6057
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

Add RISC-V implementation of the Cluster Power Controller (CPC) device.
It is based on the existing MIPS CPC implementations but adapted for
RISC-V systems.

The CPC device manages power control for CPU clusters in RISC-V
systems.

This is needed for the MIPS BOSTON AIA board.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/misc/Kconfig             |   4 +
 hw/misc/meson.build         |   1 +
 hw/misc/riscv_cpc.c         | 265 ++++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_cpc.h |  64 +++++++++
 4 files changed, 334 insertions(+)
 create mode 100644 hw/misc/riscv_cpc.c
 create mode 100644 include/hw/misc/riscv_cpc.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 222efb12fb..2b308ec9b0 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -124,11 +124,15 @@ config MIPS_ITU
 config RISCV_MIPS_CMGCR
     bool
=20
+config RISCV_MIPS_CPC
+    bool
+
 config MIPS_BOSTON_AIA
     bool
     default y
     depends on RISCV64
     select RISCV_MIPS_CMGCR
+    select RISCV_MIPS_CPC
=20
 config MPS2_FPGAIO
     bool
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 489f0f3319..32b878e035 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -158,6 +158,7 @@ specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files=
('mips_cmgcr.c', 'mips_cp
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
=20
 specific_ss.add(when: 'CONFIG_RISCV_MIPS_CMGCR', if_true: files('riscv_cmg=
cr.c'))
+specific_ss.add(when: 'CONFIG_RISCV_MIPS_CPC', if_true: files('riscv_cpc.c=
'))
=20
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
=20
diff --git a/hw/misc/riscv_cpc.c b/hw/misc/riscv_cpc.c
new file mode 100644
index 0000000000..344f855847
--- /dev/null
+++ b/hw/misc/riscv_cpc.c
@@ -0,0 +1,265 @@
+/*
+ * Cluster Power Controller emulation
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Reference: MIPS P8700 documentation
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "qemu/bitops.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+
+#include "hw/misc/riscv_cpc.h"
+#include "hw/qdev-properties.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/resettable.h"
+
+static inline uint64_t cpc_vp_run_mask(RISCVCPCState *cpc)
+{
+    return MAKE_64BIT_MASK(0, cpc->num_vp);
+}
+
+static void riscv_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
+{
+    RISCVCPCState *cpc =3D (RISCVCPCState *) data.host_ptr;
+    int i;
+
+    cpu_reset(cs);
+    cs->halted =3D 0;
+
+    /* Find this CPU's index in the CPC's CPU array */
+    for (i =3D 0; i < cpc->num_vp; i++) {
+        if (cpc->cpus[i] =3D=3D cs) {
+            cpc->vps_running_mask |=3D BIT_ULL(i);
+            break;
+        }
+    }
+}
+
+static void cpc_run_vp(RISCVCPCState *cpc, uint64_t vps_run_mask)
+{
+    int vp;
+
+    for (vp =3D 0; vp < cpc->num_vp; vp++) {
+        CPUState *cs =3D cpc->cpus[vp];
+
+        if (!extract64(vps_run_mask, vp, 1)) {
+            continue;
+        }
+
+        if (extract64(cpc->vps_running_mask, vp, 1)) {
+            continue;
+        }
+
+        /*
+         * To avoid racing with a CPU we are just kicking off.
+         * We do the final bit of preparation for the work in
+         * the target CPUs context.
+         */
+        async_safe_run_on_cpu(cs, riscv_cpu_reset_async_work,
+                              RUN_ON_CPU_HOST_PTR(cpc));
+    }
+}
+
+static void cpc_stop_vp(RISCVCPCState *cpc, uint64_t vps_stop_mask)
+{
+    int vp;
+
+    for (vp =3D 0; vp < cpc->num_vp; vp++) {
+        CPUState *cs =3D cpc->cpus[vp];
+
+        if (!extract64(vps_stop_mask, vp, 1)) {
+            continue;
+        }
+
+        if (!extract64(cpc->vps_running_mask, vp, 1)) {
+            continue;
+        }
+
+        cpu_interrupt(cs, CPU_INTERRUPT_HALT);
+        cpc->vps_running_mask &=3D ~BIT_ULL(vp);
+    }
+}
+
+static void cpc_write(void *opaque, hwaddr offset, uint64_t data,
+                      unsigned size)
+{
+    RISCVCPCState *s =3D opaque;
+    int cpu_index, c;
+
+    for (c =3D 0; c < s->num_core; c++) {
+        cpu_index =3D c * s->num_hart +
+                    s->cluster_id * s->num_core * s->num_hart;
+        if (offset =3D=3D
+            CPC_CL_BASE_OFS + CPC_VP_RUN_OFS + c * CPC_CORE_REG_STRIDE) {
+            cpc_run_vp(s, (data << cpu_index) & cpc_vp_run_mask(s));
+            return;
+        }
+        if (offset =3D=3D
+            CPC_CL_BASE_OFS + CPC_VP_STOP_OFS + c * CPC_CORE_REG_STRIDE) {
+            cpc_stop_vp(s, (data << cpu_index) & cpc_vp_run_mask(s));
+            return;
+        }
+    }
+
+    switch (offset) {
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Bad offset 0x%x\n",  __func__, (int)offset);
+        break;
+    }
+
+    return;
+}
+
+static uint64_t cpc_read(void *opaque, hwaddr offset, unsigned size)
+{
+    RISCVCPCState *s =3D opaque;
+    int c;
+
+    for (c =3D 0; c < s->num_core; c++) {
+        if (offset =3D=3D
+            CPC_CL_BASE_OFS + CPC_STAT_CONF_OFS + c * CPC_CORE_REG_STRIDE)=
 {
+            /* Return the state as U6. */
+            return CPC_Cx_STAT_CONF_SEQ_STATE_U6;
+        }
+    }
+
+    switch (offset) {
+    case CPC_CM_STAT_CONF_OFS:
+        return CPC_Cx_STAT_CONF_SEQ_STATE_U5;
+    case CPC_MTIME_REG_OFS:
+        return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
+                        RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ,
+                        NANOSECONDS_PER_SECOND);
+        return 0;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Bad offset 0x%x\n",  __func__, (int)offset);
+        return 0;
+    }
+}
+
+static const MemoryRegionOps cpc_ops =3D {
+    .read =3D cpc_read,
+    .write =3D cpc_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .impl =3D {
+        .min_access_size =3D 8,
+    },
+};
+
+static void riscv_cpc_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVCPCState *s =3D RISCV_CPC(obj);
+    int i;
+
+    memory_region_init_io(&s->mr, OBJECT(s), &cpc_ops, s, "xmips-cpc",
+                          CPC_ADDRSPACE_SZ);
+    sysbus_init_mmio(sbd, &s->mr);
+
+    /* Allocate CPU array */
+    s->cpus =3D g_new0(CPUState *, CPC_MAX_VPS);
+
+    /* Create link properties for each possible CPU slot */
+    for (i =3D 0; i < CPC_MAX_VPS; i++) {
+        char *propname =3D g_strdup_printf("cpu[%d]", i);
+        object_property_add_link(obj, propname, TYPE_CPU,
+                                 (Object **)&s->cpus[i],
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_STRONG);
+        g_free(propname);
+    }
+}
+
+static void riscv_cpc_realize(DeviceState *dev, Error **errp)
+{
+    RISCVCPCState *s =3D RISCV_CPC(dev);
+    int i;
+
+    if (s->vps_start_running_mask & ~cpc_vp_run_mask(s)) {
+        error_setg(errp,
+                   "incorrect vps-start-running-mask 0x%" PRIx64
+                   " for num_vp =3D %d",
+                   s->vps_start_running_mask, s->num_vp);
+        return;
+    }
+
+    /* Verify that required CPUs have been linked */
+    for (i =3D 0; i < s->num_vp; i++) {
+        if (!s->cpus[i]) {
+            error_setg(errp, "CPU %d has not been linked", i);
+            return;
+        }
+    }
+}
+
+static void riscv_cpc_reset_hold(Object *obj, ResetType type)
+{
+    RISCVCPCState *s =3D RISCV_CPC(obj);
+
+    /* Reflect the fact that all VPs are halted on reset */
+    s->vps_running_mask =3D 0;
+
+    /* Put selected VPs into run state */
+    cpc_run_vp(s, s->vps_start_running_mask);
+}
+
+static const VMStateDescription vmstate_riscv_cpc =3D {
+    .name =3D "xmips-cpc",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(vps_running_mask, RISCVCPCState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property riscv_cpc_properties[] =3D {
+    DEFINE_PROP_UINT32("cluster-id", RISCVCPCState, cluster_id, 0x0),
+    DEFINE_PROP_UINT32("num-vp", RISCVCPCState, num_vp, 0x1),
+    DEFINE_PROP_UINT32("num-hart", RISCVCPCState, num_hart, 0x1),
+    DEFINE_PROP_UINT32("num-core", RISCVCPCState, num_core, 0x1),
+    DEFINE_PROP_UINT64("vps-start-running-mask", RISCVCPCState,
+                       vps_start_running_mask, 0x1),
+};
+
+static void riscv_cpc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
+
+    dc->realize =3D riscv_cpc_realize;
+    rc->phases.hold =3D riscv_cpc_reset_hold;
+    dc->vmsd =3D &vmstate_riscv_cpc;
+    device_class_set_props(dc, riscv_cpc_properties);
+    dc->user_creatable =3D false;
+}
+
+static const TypeInfo riscv_cpc_info =3D {
+    .name          =3D TYPE_RISCV_CPC,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVCPCState),
+    .instance_init =3D riscv_cpc_init,
+    .class_init    =3D riscv_cpc_class_init,
+};
+
+static void riscv_cpc_register_types(void)
+{
+    type_register_static(&riscv_cpc_info);
+}
+
+type_init(riscv_cpc_register_types)
diff --git a/include/hw/misc/riscv_cpc.h b/include/hw/misc/riscv_cpc.h
new file mode 100644
index 0000000000..713455eb83
--- /dev/null
+++ b/include/hw/misc/riscv_cpc.h
@@ -0,0 +1,64 @@
+/*
+ * Cluster Power Controller emulation
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef RISCV_CPC_H
+#define RISCV_CPC_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define CPC_ADDRSPACE_SZ    0x6000
+
+/* CPC global register offsets relative to base address */
+#define CPC_MTIME_REG_OFS   0x50
+
+#define CPC_CM_STAT_CONF_OFS   0x1008
+
+/* CPC blocks offsets relative to base address */
+#define CPC_CL_BASE_OFS     0x2000
+#define CPC_CORE_REG_STRIDE 0x100 /* Stride between core-specific register=
s */
+
+/* CPC register offsets relative to block offsets */
+#define CPC_STAT_CONF_OFS   0x08
+#define CPC_VP_STOP_OFS     0x20
+#define CPC_VP_RUN_OFS      0x28
+#define CPC_VP_RUNNING_OFS  0x30
+
+#define SEQ_STATE_BIT       19
+#define SEQ_STATE_U5        0x6
+#define SEQ_STATE_U6        0x7
+#define CPC_Cx_STAT_CONF_SEQ_STATE_U5      (SEQ_STATE_U5 << SEQ_STATE_BIT)
+#define CPC_Cx_STAT_CONF_SEQ_STATE_U6      (SEQ_STATE_U6 << SEQ_STATE_BIT)
+
+#define TYPE_RISCV_CPC "xmips-cpc"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPCState, RISCV_CPC)
+
+typedef struct RISCVCPCState {
+    SysBusDevice parent_obj;
+
+    uint32_t cluster_id;
+    uint32_t num_vp;
+    uint32_t num_hart;
+    uint32_t num_core;
+    /* VPs running from restart mask */
+    uint64_t vps_start_running_mask;
+
+    MemoryRegion mr;
+    /* Indicates which VPs are in the run state mask */
+    uint64_t vps_running_mask;
+
+    /* Array of CPUs managed by this CPC */
+    CPUState **cpus;
+} RISCVCPCState;
+
+#define CPC_MAX_VPS 64  /* Maximum number of VPs supported */
+
+#endif /* RISCV_CPC_H */
--=20
2.34.1

