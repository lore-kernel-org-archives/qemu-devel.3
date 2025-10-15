Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4B0CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 12:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v90AC-0008Bq-Kj; Wed, 15 Oct 2025 07:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v90A9-00087E-MI; Wed, 15 Oct 2025 07:59:25 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v90A0-0007oZ-0i; Wed, 15 Oct 2025 07:59:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spvdal4HnN5Xzwk+gWinnMXvGVqIZKOon8S5d/KH9m2VAj/9KdwC3Pk8nKJqjY7xbJzUfQZYeV+ExM42ozlawL1zWxl1MH2ykj3gl4sCEjJK2tXEvwbIly3+oyzNlnRxtvYtyaAA5wVXj3COAuZgh9celdvSZON1a3RYoO1EWKTDnh17tCsifyp+jHd+KVqeR5auSHSMohz9bPvQA6n4F1ZHKcRA/vqfJQeODv4W+03tuAU669RgjM/FwH9NC2zfUtZ8iYSCHzM1sgvpwXrxysgn91NNKa4+vlu8v/Fp0j2aPqate7UOqy2TtWspYIVGJVx73Mfrqq95Tdb2Q5777g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlMsA/MEhKVlYqorsoIGEZeCEH5EmohMbuJcJ+fqK2E=;
 b=gQ5UeG5nETOiw7MKphyijXKummeTeZOaNg/4/T+Xt3C4qMGgrVP+qfAhEYgZu77Jj7DEQPihQ6sTK7EvV/CY/IiyU74flBKVNB5SeqPfUeSPE3uMc2udDcJGxkytfmfTkvtt/UedRuAfzFvLxsfxaVE89g525mDjGArjPcwdmXKUlxwfoRrwjnqk7ZQ493vXN+E5BQETk6YaQ9RKycn0+dlQQ0qzgVEB0k18tYgXC516HX85qZ7I9j4BSiNiDIUWi7GU56f+wDFcXPLt3+bGSzcmq850mYu72Ge6wE9bbFCj4jYWxU2afgPsEzEmfHXXjpeZT3DTjKHUkLHhXjOpdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlMsA/MEhKVlYqorsoIGEZeCEH5EmohMbuJcJ+fqK2E=;
 b=fJdYFddLXVc/4NZGXjve9vHkLCFJnUQHbyEI5l0CQncR95Um9LflTlvAbMTwChY8CHf+rJG54KZac6l4n6JsXDLclJsjwQx4fG5SuRDRJitHCKUC4/Ll7+HDUoWEKSd4X61eHBXST6vATQ/N2x5e1e/hLZtJxrCiyBAoMFMAjI9GJhpznQgnFRo/Uwx59kI2oh2mmqPLyJtZ4D4Vkp3D/0FPM/T8g8BakYiuPQeXUE4ccav2E5bWq696W59tS9k4HHxVOUqv/rCkqb8ubJoghWNJz7c99YHbJj3s4/y1jb5QjmVL1SP3bqWbW/gLQwivSV61U0S6ah/9mi0+5msTUw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AS1PR09MB5739.eurprd09.prod.outlook.com (2603:10a6:20b:477::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 11:58:21 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 11:58:21 +0000
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
Subject: [PATCH v11 11/13] hw/riscv: Add support for MIPS Boston-aia board mode
Thread-Topic: [PATCH v11 11/13] hw/riscv: Add support for MIPS Boston-aia
 board mode
Thread-Index: AQHcPcr/kmb9bz3OhUyTiBSssL/3LA==
Date: Wed, 15 Oct 2025 11:58:18 +0000
Message-ID: <20251015115743.487361-12-djordje.todorovic@htecgroup.com>
References: <20251015115743.487361-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015115743.487361-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AS1PR09MB5739:EE_
x-ms-office365-filtering-correlation-id: 5dd6355a-fc54-45a4-46df-08de0be22371
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?hRVUrThj93+0+vQtApyiHwh5O6Y7Ojui2/j+8WAwEdeJjAuN8mZ4fVSM6b?=
 =?iso-8859-1?Q?MXughxKxpllyX1cz7JDAarKh92cE4i3Yq7DCEWdNIqohOkYsSGPbUe+BXB?=
 =?iso-8859-1?Q?vq/NX7MZy25JTCJ5YFOxX7ggzOg8TkZmjUYGL1BnG17Qq/3NPXOnPri3CE?=
 =?iso-8859-1?Q?IRNSBsoXkkAjpBLNZvzo0+zComc9VLUdeD0U3N3VuiqggzSfalaV0cdvp1?=
 =?iso-8859-1?Q?bGI8Mt/BXK/LV5A4jWX5H+Tr5zP4mS1bGwqocCowUJiCS3P0h70pUSJD/K?=
 =?iso-8859-1?Q?OtfEhR8Z+QFJuchioKDP4I+1GywniH8BlOKsUp/P3HTLRKG9t1ZUt4Ed7f?=
 =?iso-8859-1?Q?JCzBb0lPjGmHoMV1NNEWFDqO7E17Pe/Cteggdy9F9LF/pi/9Ey/84ySggF?=
 =?iso-8859-1?Q?8+QLtvtMMuAKME5hcdHUVURESpq/Szi+DXZgFiUCnCgzDkbw2LFL4A88Yg?=
 =?iso-8859-1?Q?sW4kYpN2tmCW/jVOScSjytn+ylu8MX6cXjPRNiPaQ36ArMPiB8EqL9KqMh?=
 =?iso-8859-1?Q?CUVVw6cFIZnxxhTXB3RN+W1eYmk3md3YwWmGm2QKPEifTnHiRIFzwl5jwW?=
 =?iso-8859-1?Q?w1qH6id7tyBZZv84Q109Oyftz/iB5zeYkHprtdSi2VZkNeRMJineCbxvV5?=
 =?iso-8859-1?Q?foTaC+AybSDFnrwd3mA790fzQysSck7eRmFuTRZCYV+rjiGY+CFX+KHwFv?=
 =?iso-8859-1?Q?Dj/3Th6hnO19qvroeiLcpS90lDQV/RMf+yuPtLFSEWEpqYAJbU/vfFz+4Z?=
 =?iso-8859-1?Q?IoEuuC2DcGaGJLVlP35Bp2yG1tXKj7vowoFZ7oO+vBxhxQj2703C3fKRdJ?=
 =?iso-8859-1?Q?tOqJym0N+Fxp5L15ZJK+icR1fLBa+Zk9QC6kJ0cmoqbN0uYMQClijMdmng?=
 =?iso-8859-1?Q?XoydyBVW45ryuZwgtrw+E30bsXkCiYq5rBzTi/RICP4VJ+8LtXZklrlRpS?=
 =?iso-8859-1?Q?IKI8GSBnuHZeb1mdzPtiV1266u8pYjDzwUSNR+aURafMUWe8HN6RuCfDOF?=
 =?iso-8859-1?Q?VMW1WzxjKCSF3f9ytjtwKOE37icW5EMuXpN9+HtdFa92t+QTB58cet4qCy?=
 =?iso-8859-1?Q?gb9CH2soNk07hOCbSpNG4eGsOODFdty6DdIxtq1utrbQha3YIuJit/qgij?=
 =?iso-8859-1?Q?Eg5XtoJxOiklvIhazuNk5bd4daMF+rLZCLMtDq0iOfSoMJvl4SIl0Ts7rB?=
 =?iso-8859-1?Q?e5pi4jiJyhONgYseO64RV5krKnmUf2fAGPvSzaf1+AA3gofkMcQxWKoLaD?=
 =?iso-8859-1?Q?roEd0SVqog4giAPTfVmq111SluLlr7CfvY6f1NYByrAZC84c8BhHrVkVNG?=
 =?iso-8859-1?Q?nCtGIQGwdKNE2/Gdh+Zm/nENnYlGGDJwO418kSMHizWih36+ptHq7+LKcR?=
 =?iso-8859-1?Q?F3ICuMBcrR/p+tqHt9GwQN+sZV7I346GH8VQwJ0qhKu9du/z0NVkAfzB6f?=
 =?iso-8859-1?Q?URIaz6iJiCQwAWAwli6YURR98dkDqEGl+bdJVoKHEbKZ6CCsOwMBCZ4mTs?=
 =?iso-8859-1?Q?uuzFzauW6abh1IsWbWRuk9YCbJ/NdCqVeg+/oRz49G9jriFUp1WTkwFCIf?=
 =?iso-8859-1?Q?wY8eZsSWTUIjQQGNHrvNP5bQ9k1s?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ex2TU4KAerGxxESHKrRpEKNHs641Q7li4ph1F4FqtUQRgbZMesuoAQOwDh?=
 =?iso-8859-1?Q?+euBQ05G1UZq/N3AjOIYAyA8BdehwM+LHD0jSdOOrLxyEn58Uda6NTt45n?=
 =?iso-8859-1?Q?IbsKadY9NaDCtS4GGHT7KS2ssxFuDFSZgBwJsd35P93lFiQIB8DGAwZufZ?=
 =?iso-8859-1?Q?LhIfNS1WuLDXe2hkLmJeutgJhOXWs1obKA276hezRvkMDbN/DLWPpabBhZ?=
 =?iso-8859-1?Q?qtO1EFPr3vpE8vzjz0HQoMOq4PggY1VBWZJtwScux9lV5U5uMFmnH7b1VV?=
 =?iso-8859-1?Q?EEt3EG6fT9ZEka7NW5lEjZxVou2lJjQmqcQfJR50iEK34AgKlgP6Lihdrr?=
 =?iso-8859-1?Q?H37hkSmFQHa0kxY8HQMM7r5H4mLN23cdeCKBkx8tP4uiELl0eS9/yWOUmQ?=
 =?iso-8859-1?Q?skAGYyiD+ftvFuaF7ld5No9IAWfHtSZYv76wCjIP7AqlEbZmB1+mte3Noo?=
 =?iso-8859-1?Q?8LdVJ38Tz4RiXbbqDgX7uXKnbCIeUvKPwa0I3ArYlcoUp1F42Ip2cxF67w?=
 =?iso-8859-1?Q?QTDSb2RlIcDX7KdfgoCIa1PPQ1vy7WV+jXjt76iDXcU+KXPalBiqQxB7H9?=
 =?iso-8859-1?Q?/nYS7RMVu7dqyrZwobginzifa/h9CRIroNviDwtBuLicCXzqp/wCcPP/p7?=
 =?iso-8859-1?Q?YNN9kmUTXAxQVPEs1HD/hPIX5yYneRL3uOwTtI22HjS2hop7xp3bDE7p18?=
 =?iso-8859-1?Q?wsEqqAYaCoIxZMJPwX0PjBmAddiyPiMhdblaJtxaxBWWKyT3Cqj3CrxCT4?=
 =?iso-8859-1?Q?McjJaKVOFirNoEG6nceGV1UadEi9zfOqsRNCGNHKzfTBHFR41QE/7SO+iM?=
 =?iso-8859-1?Q?D45nyukKOkLoZlDhYfyGfb8TGfaJvB7nKj+Pu1M1FdbHRNj0i+xrCsnDiC?=
 =?iso-8859-1?Q?GZY+kl52jrBf40wpOiT6GeSMeQ2LT3iKdDNqqo1sq1KPyL9RomY/vJcSnB?=
 =?iso-8859-1?Q?xEVkG8GwExPdyD9GsCUMj7ADmNdJPpILPOG3rAXC103jLKCiElR8fkaK6n?=
 =?iso-8859-1?Q?wnJmAUsnqS4P9JUnltJ700j2zUNETPvgeKoV368K506P209F3vh9c++YVm?=
 =?iso-8859-1?Q?ehVc/7HF6thNehFkWRYP6QHH3AIh+288OxWbZdbCevF+pbcSpsKVkG2Cuc?=
 =?iso-8859-1?Q?TUL3qRyL1b5u6KapL7LUVbFuZxbw/LFPIQnd3q1jT2W78KPW0E/s7CS5BU?=
 =?iso-8859-1?Q?g3SVGm059D3XuJrygXh/bS9N9iozLPNTxTk1UmtilXeoKDgNpdPtvpAV0U?=
 =?iso-8859-1?Q?8TPoPlcYZEQsndOJrIyp3g5HGfGyMDoZ3BUXf1bRI6nfell7s/C+lKeYV6?=
 =?iso-8859-1?Q?LPLZsGNEbmdqFHhbdXWBFdcFUlny82gYUt/rxdPZp4eeMQsrwe0w5mr9E+?=
 =?iso-8859-1?Q?60jGDgb/SY1w74ITDI+j1jv6gm6LYyBNCd276JZzQ2YxZYXS94VJAInT3n?=
 =?iso-8859-1?Q?15WToBu3wZgP3MBKLEcI/mg9s2LbM6wfrV33dRhr3cCdOCrHKh91prJM09?=
 =?iso-8859-1?Q?DsxhLNNR1L5nVWhe8DvoAJYOG6q/zXd2Phu3XB3/3v+eqUwiVG1LqXmAl8?=
 =?iso-8859-1?Q?CACjBMv6nqdGL5rxDvikWZm91I+Vc/wNEQ65/VHRrUrPuVCIOZppkMgxi2?=
 =?iso-8859-1?Q?E6i7t9ruJ49OUG7lzyS9qulAay8B6mlhtRp9CMAOvNlBXvtl1Uz10GDJCF?=
 =?iso-8859-1?Q?I3wu68RhGJ9RNkUYcG4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd6355a-fc54-45a4-46df-08de0be22371
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 11:58:18.9292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gpf+IDL45k+mTJ73qtu4OXAZcXf+GrB4/m9GyAVubD8rSSD4ZvufbHFyQx/HYzUUHnqW46f4xbLTxs/exeVFA0IFuIt3KiQlmT80vO0v0yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR09MB5739
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

The board model supports up to 64 harts with MIPS CPS, MIPS GCR,
MIPS CPC, AIA plic, and AIA clint devices. The model can create
boot code, if there is no -bios parameter. We can specify -smp x,
cores=3Dy,thread=3Dz.
Ex: Use 4 cores and 2 threads with each core to
have 8 smp cpus as follows.
  qemu-system-riscv64 -cpu mips-p8700 \
  -m 2G -M boston-aia \
  -smp 8,cores=3D4,threads=3D2 -kernel fw_payload.bin \
  -drive file=3Drootfs.ext2,format=3Draw -serial stdio

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 configs/devices/riscv64-softmmu/default.mak |   1 +
 docs/system/riscv/mips.rst                  |  20 +
 docs/system/target-riscv.rst                |   1 +
 hw/riscv/Kconfig                            |   6 +
 hw/riscv/boston-aia.c                       | 471 ++++++++++++++++++++
 hw/riscv/meson.build                        |   1 +
 6 files changed, 500 insertions(+)
 create mode 100644 docs/system/riscv/mips.rst
 create mode 100644 hw/riscv/boston-aia.c

diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/devices/=
riscv64-softmmu/default.mak
index e485bbd1a3..a8e4d0ab33 100644
--- a/configs/devices/riscv64-softmmu/default.mak
+++ b/configs/devices/riscv64-softmmu/default.mak
@@ -12,3 +12,4 @@
 # CONFIG_MICROCHIP_PFSOC=3Dn
 # CONFIG_SHAKTI_C=3Dn
 # CONFIG_XIANGSHAN_KUNMINGHU=3Dn
+# CONFIG_MIPS_BOSTON_AIA=3Dn
diff --git a/docs/system/riscv/mips.rst b/docs/system/riscv/mips.rst
new file mode 100644
index 0000000000..97096421e1
--- /dev/null
+++ b/docs/system/riscv/mips.rst
@@ -0,0 +1,20 @@
+Boards for RISC-V Processors by MIPS
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+RISC-V processors developed by MIPS support Boston-aia board model. The bo=
ard
+model supports up to 64 harts with MIPS CPS, MIPS GCR, MIPS CPC, AIA plic,
+and AIA clint devices. The model can create boot code, if there is no
+```-bios``` parameter. Also, we can specify ```-smp x,cores=3Dy,thread=3Dz=
```.
+
+Running Linux kernel
+--------------------
+
+For example, to use 4 cores and 2 threads with each core to have 8 smp cpu=
s,
+that runs on the ```mips-p8700``` CPU, run qemu as follows:
+
+.. code-block:: bash
+
+   qemu-system-riscv64 -cpu mips-p8700 \
+         -m 2G -M boston-aia \
+         -smp 8,cores=3D4,threads=3D2 -kernel fw_payload.bin \
+         -drive file=3Drootfs.ext2,format=3Draw -serial stdio
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 89b2cb732c..3ad5d1ddaf 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -68,6 +68,7 @@ undocumented; you can get a complete list by running
=20
    riscv/microblaze-v-generic
    riscv/microchip-icicle-kit
+   riscv/mips
    riscv/shakti-c
    riscv/sifive_u
    riscv/virt
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index fc9c35bd98..0222c93f87 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -128,3 +128,9 @@ config XIANGSHAN_KUNMINGHU
     select RISCV_APLIC
     select RISCV_IMSIC
     select SERIAL_MM
+
+config MIPS_BOSTON_AIA
+    bool
+    default y
+    select PCI_EXPRESS
+    select PCI_EXPRESS_XILINX
diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
new file mode 100644
index 0000000000..7d8b91ef04
--- /dev/null
+++ b/hw/riscv/boston-aia.c
@@ -0,0 +1,471 @@
+/*
+ * MIPS Boston-aia development board emulation.
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+
+#include "hw/boards.h"
+#include "hw/char/serial-mm.h"
+#include "hw/ide/pci.h"
+#include "hw/ide/ahci-pci.h"
+#include "hw/loader.h"
+#include "hw/riscv/cps.h"
+#include "hw/pci-host/xilinx-pcie.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "chardev/char.h"
+#include "system/address-spaces.h"
+#include "system/device_tree.h"
+#include "system/system.h"
+#include "system/qtest.h"
+#include "system/runstate.h"
+
+#include <libfdt.h>
+#include "qom/object.h"
+
+#define TYPE_MIPS_BOSTON_AIA "mips-boston-aia"
+typedef struct BostonState BostonState;
+DECLARE_INSTANCE_CHECKER(BostonState, BOSTON,
+                         TYPE_MIPS_BOSTON_AIA)
+
+enum {
+    BOSTON_PCIE2,
+    BOSTON_PCIE2_MMIO,
+    BOSTON_PLATREG,
+    BOSTON_UART,
+    BOSTON_LCD,
+    BOSTON_FLASH,
+    BOSTON_HIGHDDR,
+};
+
+static const MemMapEntry boston_memmap[] =3D {
+    [BOSTON_PCIE2] =3D      { 0x14000000,     0x2000000 },
+    [BOSTON_PCIE2_MMIO] =3D { 0x16000000,      0x100000 },
+    [BOSTON_PLATREG] =3D    { 0x17ffd000,        0x1000 },
+    [BOSTON_UART] =3D       { 0x17ffe000,          0x20 },
+    [BOSTON_LCD] =3D        { 0x17fff000,           0x8 },
+    [BOSTON_FLASH] =3D      { 0x18000000,     0x8000000 },
+    [BOSTON_HIGHDDR] =3D    { 0x80000000,           0x0 },
+};
+
+/* Interrupt numbers for APLIC. */
+#define UART_INT 4
+#define PCIE2_INT 7
+
+struct BostonState {
+    SysBusDevice parent_obj;
+
+    MachineState *mach;
+    RISCVCPSState cps;
+    SerialMM *uart;
+
+    CharBackend lcd_display;
+    char lcd_content[8];
+    bool lcd_inited;
+};
+
+enum boston_plat_reg {
+    PLAT_FPGA_BUILD     =3D 0x00,
+    PLAT_CORE_CL        =3D 0x04,
+    PLAT_WRAPPER_CL     =3D 0x08,
+    PLAT_SYSCLK_STATUS  =3D 0x0c,
+    PLAT_SOFTRST_CTL    =3D 0x10,
+#define PLAT_SOFTRST_CTL_SYSRESET       (1 << 4)
+    PLAT_DDR3_STATUS    =3D 0x14,
+#define PLAT_DDR3_STATUS_LOCKED         (1 << 0)
+#define PLAT_DDR3_STATUS_CALIBRATED     (1 << 2)
+#define PLAT_DDR3_INTERFACE_RESET       (1 << 3)
+    PLAT_PCIE_STATUS    =3D 0x18,
+#define PLAT_PCIE_STATUS_PCIE0_LOCKED   (1 << 0)
+#define PLAT_PCIE_STATUS_PCIE1_LOCKED   (1 << 8)
+#define PLAT_PCIE_STATUS_PCIE2_LOCKED   (1 << 16)
+    PLAT_FLASH_CTL      =3D 0x1c,
+    PLAT_SPARE0         =3D 0x20,
+    PLAT_SPARE1         =3D 0x24,
+    PLAT_SPARE2         =3D 0x28,
+    PLAT_SPARE3         =3D 0x2c,
+    PLAT_MMCM_DIV       =3D 0x30,
+#define PLAT_MMCM_DIV_CLK0DIV_SHIFT     0
+#define PLAT_MMCM_DIV_INPUT_SHIFT       8
+#define PLAT_MMCM_DIV_MUL_SHIFT         16
+#define PLAT_MMCM_DIV_CLK1DIV_SHIFT     24
+    PLAT_BUILD_CFG      =3D 0x34,
+#define PLAT_BUILD_CFG_IOCU_EN          (1 << 0)
+#define PLAT_BUILD_CFG_PCIE0_EN         (1 << 1)
+#define PLAT_BUILD_CFG_PCIE1_EN         (1 << 2)
+#define PLAT_BUILD_CFG_PCIE2_EN         (1 << 3)
+    PLAT_DDR_CFG        =3D 0x38,
+#define PLAT_DDR_CFG_SIZE               (0xf << 0)
+#define PLAT_DDR_CFG_MHZ                (0xfff << 4)
+    PLAT_NOC_PCIE0_ADDR =3D 0x3c,
+    PLAT_NOC_PCIE1_ADDR =3D 0x40,
+    PLAT_NOC_PCIE2_ADDR =3D 0x44,
+    PLAT_SYS_CTL        =3D 0x48,
+};
+
+static void boston_lcd_event(void *opaque, QEMUChrEvent event)
+{
+    BostonState *s =3D opaque;
+    if (event =3D=3D CHR_EVENT_OPENED && !s->lcd_inited) {
+        qemu_chr_fe_printf(&s->lcd_display, "        ");
+        s->lcd_inited =3D true;
+    }
+}
+
+static uint64_t boston_lcd_read(void *opaque, hwaddr addr,
+                                unsigned size)
+{
+    BostonState *s =3D opaque;
+    uint64_t val =3D 0;
+
+    switch (size) {
+    case 8:
+        val |=3D (uint64_t)s->lcd_content[(addr + 7) & 0x7] << 56;
+        val |=3D (uint64_t)s->lcd_content[(addr + 6) & 0x7] << 48;
+        val |=3D (uint64_t)s->lcd_content[(addr + 5) & 0x7] << 40;
+        val |=3D (uint64_t)s->lcd_content[(addr + 4) & 0x7] << 32;
+        /* fall through */
+    case 4:
+        val |=3D (uint64_t)s->lcd_content[(addr + 3) & 0x7] << 24;
+        val |=3D (uint64_t)s->lcd_content[(addr + 2) & 0x7] << 16;
+        /* fall through */
+    case 2:
+        val |=3D (uint64_t)s->lcd_content[(addr + 1) & 0x7] << 8;
+        /* fall through */
+    case 1:
+        val |=3D (uint64_t)s->lcd_content[(addr + 0) & 0x7];
+        break;
+    }
+
+    return val;
+}
+
+static void boston_lcd_write(void *opaque, hwaddr addr,
+                             uint64_t val, unsigned size)
+{
+    BostonState *s =3D opaque;
+
+    switch (size) {
+    case 8:
+        s->lcd_content[(addr + 7) & 0x7] =3D val >> 56;
+        s->lcd_content[(addr + 6) & 0x7] =3D val >> 48;
+        s->lcd_content[(addr + 5) & 0x7] =3D val >> 40;
+        s->lcd_content[(addr + 4) & 0x7] =3D val >> 32;
+        /* fall through */
+    case 4:
+        s->lcd_content[(addr + 3) & 0x7] =3D val >> 24;
+        s->lcd_content[(addr + 2) & 0x7] =3D val >> 16;
+        /* fall through */
+    case 2:
+        s->lcd_content[(addr + 1) & 0x7] =3D val >> 8;
+        /* fall through */
+    case 1:
+        s->lcd_content[(addr + 0) & 0x7] =3D val;
+        break;
+    }
+
+    qemu_chr_fe_printf(&s->lcd_display,
+                       "\r%-8.8s", s->lcd_content);
+}
+
+static const MemoryRegionOps boston_lcd_ops =3D {
+    .read =3D boston_lcd_read,
+    .write =3D boston_lcd_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+};
+
+static uint64_t boston_platreg_read(void *opaque, hwaddr addr,
+                                    unsigned size)
+{
+    BostonState *s =3D opaque;
+    uint32_t gic_freq, val;
+
+    switch (addr & 0xffff) {
+    case PLAT_FPGA_BUILD:
+    case PLAT_CORE_CL:
+    case PLAT_WRAPPER_CL:
+        return 0;
+    case PLAT_DDR3_STATUS:
+        return PLAT_DDR3_STATUS_LOCKED | PLAT_DDR3_STATUS_CALIBRATED
+               | PLAT_DDR3_INTERFACE_RESET;
+    case PLAT_MMCM_DIV:
+        gic_freq =3D 25000000 / 1000000;
+        val =3D gic_freq << PLAT_MMCM_DIV_INPUT_SHIFT;
+        val |=3D 1 << PLAT_MMCM_DIV_MUL_SHIFT;
+        val |=3D 1 << PLAT_MMCM_DIV_CLK0DIV_SHIFT;
+        val |=3D 1 << PLAT_MMCM_DIV_CLK1DIV_SHIFT;
+        return val;
+    case PLAT_BUILD_CFG:
+        val =3D PLAT_BUILD_CFG_PCIE0_EN;
+        val |=3D PLAT_BUILD_CFG_PCIE1_EN;
+        val |=3D PLAT_BUILD_CFG_PCIE2_EN;
+        return val;
+    case PLAT_DDR_CFG:
+        val =3D s->mach->ram_size / GiB;
+        assert(!(val & ~PLAT_DDR_CFG_SIZE));
+        val |=3D PLAT_DDR_CFG_MHZ;
+        return val;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Read platform register 0x%" HWADDR_PRIx =
"\n",
+                      addr & 0xffff);
+        return 0;
+    }
+}
+
+static void boston_platreg_write(void *opaque, hwaddr addr,
+                                 uint64_t val, unsigned size)
+{
+    if (size !=3D 4) {
+        qemu_log_mask(LOG_UNIMP, "%uB platform register write\n", size);
+        return;
+    }
+
+    switch (addr & 0xffff) {
+    case PLAT_FPGA_BUILD:
+    case PLAT_CORE_CL:
+    case PLAT_WRAPPER_CL:
+    case PLAT_DDR3_STATUS:
+    case PLAT_PCIE_STATUS:
+    case PLAT_MMCM_DIV:
+    case PLAT_BUILD_CFG:
+    case PLAT_DDR_CFG:
+        /* read only */
+        break;
+    case PLAT_SOFTRST_CTL:
+        if (val & PLAT_SOFTRST_CTL_SYSRESET) {
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Write platform register 0x%" HWADDR_PRIx
+                      " =3D 0x%" PRIx64 "\n", addr & 0xffff, val);
+        break;
+    }
+}
+
+static const MemoryRegionOps boston_platreg_ops =3D {
+    .read =3D boston_platreg_read,
+    .write =3D boston_platreg_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .impl =3D {
+        .min_access_size =3D 4,
+        .max_access_size =3D 4,
+    },
+};
+
+static const TypeInfo boston_device =3D {
+    .name          =3D TYPE_MIPS_BOSTON_AIA,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(BostonState),
+};
+
+static void boston_register_types(void)
+{
+    type_register_static(&boston_device);
+}
+type_init(boston_register_types)
+
+#define NUM_INSNS 6
+static void gen_firmware(uint32_t *p)
+{
+    int i;
+    uint32_t reset_vec[NUM_INSNS] =3D {
+           /* CM relocate */
+           0x1fb802b7,     /* li   t0,0x1fb80000   */
+           0x16100337,     /* li   t1,0x16100000   */
+           0x0062b423,     /* sd   t1,8(t0)        */
+           /* Jump to 0x80000000 */
+           0x00100293,     /* li   t0,1            */
+           0x01f29293,     /* slli t0,t0,1f        */
+           0x00028067      /* jr   t0              */
+    };
+
+    for (i =3D 0; i < NUM_INSNS; i++) {
+        *p++ =3D reset_vec[i];
+    }
+}
+
+static inline XilinxPCIEHost *
+xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
+                 hwaddr cfg_base, uint64_t cfg_size,
+                 hwaddr mmio_base, uint64_t mmio_size,
+                 qemu_irq irq)
+{
+    DeviceState *dev;
+    MemoryRegion *cfg, *mmio;
+
+    dev =3D qdev_new(TYPE_XILINX_PCIE_HOST);
+
+    qdev_prop_set_uint32(dev, "bus_nr", bus_nr);
+    qdev_prop_set_uint64(dev, "cfg_base", cfg_base);
+    qdev_prop_set_uint64(dev, "cfg_size", cfg_size);
+    qdev_prop_set_uint64(dev, "mmio_base", mmio_base);
+    qdev_prop_set_uint64(dev, "mmio_size", mmio_size);
+
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    cfg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion_overlap(sys_mem, cfg_base, cfg, 0);
+
+    mmio =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+    memory_region_add_subregion_overlap(sys_mem, 0, mmio, 0);
+
+    qdev_connect_gpio_out_named(dev, "interrupt_out", 0, irq);
+
+    return XILINX_PCIE_HOST(dev);
+}
+
+static void boston_mach_init(MachineState *machine)
+{
+    DeviceState *dev;
+    BostonState *s;
+    MemoryRegion *flash, *ddr_low_alias, *lcd, *platreg;
+    MemoryRegion *sys_mem =3D get_system_memory();
+    XilinxPCIEHost *pcie2;
+    PCIDevice *pdev;
+    AHCIPCIState *ich9;
+    DriveInfo *hd[6];
+    Chardev *chr;
+    int fw_size;
+
+    if ((machine->ram_size % GiB) ||
+        (machine->ram_size > (4 * GiB))) {
+        error_report("Memory size must be 1GB, 2GB, 3GB, or 4GB");
+        exit(1);
+    }
+
+    if (machine->smp.cpus / machine->smp.cores / machine->smp.threads > 1)=
 {
+        error_report(
+            "Invalid -smp x,cores=3Dy,threads=3Dz. The max number of clust=
ers "
+            "supported is 1");
+        exit(1);
+    }
+
+    dev =3D qdev_new(TYPE_MIPS_BOSTON_AIA);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    s =3D BOSTON(dev);
+    s->mach =3D machine;
+
+    object_initialize_child(OBJECT(machine), "cps", &s->cps, TYPE_RISCV_CP=
S);
+    object_property_set_str(OBJECT(&s->cps), "cpu-type", machine->cpu_type=
,
+                            &error_fatal);
+    object_property_set_uint(OBJECT(&s->cps), "num-vp", machine->smp.cpus,
+                             &error_fatal);
+    object_property_set_uint(OBJECT(&s->cps), "num-hart", machine->smp.thr=
eads,
+                             &error_fatal);
+    object_property_set_uint(OBJECT(&s->cps), "num-core", machine->smp.cor=
es,
+                             &error_fatal);
+    object_property_set_uint(OBJECT(&s->cps), "gcr-base", GCR_BASE_ADDR,
+                             &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->cps), &error_fatal);
+
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
+
+    flash =3D  g_new(MemoryRegion, 1);
+    memory_region_init_rom(flash, NULL, "boston.flash",
+                           boston_memmap[BOSTON_FLASH].size, &error_fatal)=
;
+    memory_region_add_subregion_overlap(sys_mem,
+                                        boston_memmap[BOSTON_FLASH].base,
+                                        flash, 0);
+
+    memory_region_add_subregion_overlap(sys_mem,
+                                        boston_memmap[BOSTON_HIGHDDR].base=
,
+                                        machine->ram, 0);
+
+    ddr_low_alias =3D g_new(MemoryRegion, 1);
+    memory_region_init_alias(ddr_low_alias, NULL, "boston_low.ddr",
+                             machine->ram, 0,
+                             MIN(machine->ram_size, (256 * MiB)));
+    memory_region_add_subregion_overlap(sys_mem, 0, ddr_low_alias, 0);
+
+    pcie2 =3D xilinx_pcie_init(sys_mem, 2,
+                             boston_memmap[BOSTON_PCIE2].base,
+                             boston_memmap[BOSTON_PCIE2].size,
+                             boston_memmap[BOSTON_PCIE2_MMIO].base,
+                             boston_memmap[BOSTON_PCIE2_MMIO].size,
+                             qdev_get_gpio_in(s->cps.aplic, PCIE2_INT));
+
+    platreg =3D g_new(MemoryRegion, 1);
+    memory_region_init_io(platreg, NULL, &boston_platreg_ops, s,
+                          "boston-platregs",
+                          boston_memmap[BOSTON_PLATREG].size);
+    memory_region_add_subregion_overlap(sys_mem,
+                          boston_memmap[BOSTON_PLATREG].base, platreg, 0);
+
+    s->uart =3D serial_mm_init(sys_mem, boston_memmap[BOSTON_UART].base, 2=
,
+                             qdev_get_gpio_in(s->cps.aplic, UART_INT), 100=
00000,
+                             serial_hd(0), DEVICE_NATIVE_ENDIAN);
+
+    lcd =3D g_new(MemoryRegion, 1);
+    memory_region_init_io(lcd, NULL, &boston_lcd_ops, s, "boston-lcd", 0x8=
);
+    memory_region_add_subregion_overlap(sys_mem,
+                                        boston_memmap[BOSTON_LCD].base, lc=
d, 0);
+
+    chr =3D qemu_chr_new("lcd", "vc:320x240", NULL);
+    qemu_chr_fe_init(&s->lcd_display, chr, NULL);
+    qemu_chr_fe_set_handlers(&s->lcd_display, NULL, NULL,
+                             boston_lcd_event, NULL, s, NULL, true);
+
+    pdev =3D pci_create_simple_multifunction(&PCI_BRIDGE(&pcie2->root)->se=
c_bus,
+                                           PCI_DEVFN(0, 0), TYPE_ICH9_AHCI=
);
+    ich9 =3D ICH9_AHCI(pdev);
+    g_assert(ARRAY_SIZE(hd) =3D=3D ich9->ahci.ports);
+    ide_drive_get(hd, ich9->ahci.ports);
+    ahci_ide_create_devs(&ich9->ahci, hd);
+
+    if (machine->firmware) {
+        fw_size =3D load_image_targphys(machine->firmware,
+                                      0x1fc00000, 4 * MiB);
+        if (fw_size =3D=3D -1) {
+            error_report("unable to load firmware image '%s'",
+                          machine->firmware);
+            exit(1);
+        }
+        if (machine->kernel_filename) {
+                fw_size =3D load_image_targphys(machine->kernel_filename,
+                                              0x80000000, 64 * MiB);
+                if (fw_size =3D=3D -1) {
+                    error_report("unable to load kernel image '%s'",
+                                  machine->kernel_filename);
+                    exit(1);
+                }
+        }
+    } else if (machine->kernel_filename) {
+        fw_size =3D load_image_targphys(machine->kernel_filename,
+                                      0x80000000, 64 * MiB);
+        if (fw_size =3D=3D -1) {
+            error_report("unable to load kernel image '%s'",
+                          machine->kernel_filename);
+            exit(1);
+        }
+
+        gen_firmware(memory_region_get_ram_ptr(flash) + 0x7c00000);
+    } else if (!qtest_enabled()) {
+        error_report("Please provide either a -kernel or -bios argument");
+        exit(1);
+    }
+}
+
+static void boston_mach_class_init(MachineClass *mc)
+{
+    mc->desc =3D "MIPS Boston-aia";
+    mc->init =3D boston_mach_init;
+    mc->block_default_type =3D IF_IDE;
+    mc->default_ram_size =3D 2 * GiB;
+    mc->default_ram_id =3D "boston.ddr";
+    mc->max_cpus =3D MAX_HARTS;
+    mc->default_cpu_type =3D TYPE_RISCV_CPU_MIPS_P8700;
+}
+
+DEFINE_MACHINE("boston-aia", boston_mach_class_init)
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 9023b80087..533472e22a 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -16,5 +16,6 @@ riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files(=
'microblaze-v-generic.c
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan=
_kmh.c'))
=20
 riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
+riscv_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('boston-aia.c'=
))
=20
 hw_arch +=3D {'riscv': riscv_ss}
--=20
2.34.1

