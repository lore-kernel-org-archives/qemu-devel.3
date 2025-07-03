Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FBDC83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHWI-0003Mf-Ew; Thu, 03 Jul 2025 06:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uXHVo-0002sE-IB; Thu, 03 Jul 2025 06:49:54 -0400
Received: from mail-westeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c201::5] helo=AS8PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uXHVl-00077q-Jv; Thu, 03 Jul 2025 06:49:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpxZPImJ8eaEjNtnjlh9LTgS0QxF674RXygVYA+ily1FIkv14FN2DzEXLbTB8ytPz9qf6rUe/IRL9xXt4CdUWVsEju85hyPPInzXQNovS+G3sVivTShYAavtCC+Gav8ALMSSMmXar2ZlsZ5j4WewKor/nPDgreMPLtS5GOr9r/tyLohnnvvIq33AQesETWHTDyfJSeP87dgHtnYxepwaA+/E95yfovKEOnuoPYKa9cAzWGMdRsCiG3s0wp87lFhYUxhb1eU6ugaDiEnCzwz66AtQeZKqL94EloYaFVjm2zr1D3fKfgcM6HPZMWNhMb2AMuVedAe0Q5xsqtqXrIMMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olRv4jsjZxdXkxjlY3whVpxPKAkA9/DRmiZdUgthpg4=;
 b=Tx1toUCgMGOdjTuNCZWiUSa/rtp0HH2XmwLSJuSTbuej7yQBCHI8EhFQ5xAvyQm+kYysKsNeVoqSxYZ7toN52fczo9lapkbK7G4zwR/oyrLAz/vCDlnzrcdx0813xpx7rcwsXo/dXK2BTpQ0dMV86YYJ21blv0gF5FqxPGE/g4irYIvbHeN+f3ZG8Q/F/hVpO6LBi72foNAOsrsUALNsnAwHh3R+e0IPPZAPK6o8H6BD5akeRtgSllht+lwelEkbG/9S8FAg8T3icMsfFtD4bVtIssTmE4xBVXbScDlGXCWGsGIZmPT33CfZlUUuu9SRHPTArYP6g48nFrECiSNmMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olRv4jsjZxdXkxjlY3whVpxPKAkA9/DRmiZdUgthpg4=;
 b=TELQlzJJUaS76XJXLOTLhEv1bdd+7s3mmw6s2dV2Q4UKRpdbi0F4pBez+EBtblhbZKaKwY6H9teB77OmSCEMuQ6rwhLetJDbXjo1qNV2M7+vYaGFIFJ8mClT/6AVjHX7o2xYpYzbNzeryNgiL+f8xcCgon90rcQRtJuW61HhgHrdj9gLm4SgEz+kPmHDM8sfjFpi886ZC1js1rWc7QZaZsRu4pqCjc1yTM+mt1uUaSHKbLoaAlzacGCdEQ9FCJZE0JyoqnGRk8Itd7jJw9zLRU2C1AZaTFECmYZgj/S7vDATnTpzaioiD+PqEP/DHwpKny86VozNN7viGg+gEhAH+w==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GVXPR09MB7293.eurprd09.prod.outlook.com (2603:10a6:150:1bc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 3 Jul
 2025 10:49:37 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 3 Jul 2025
 10:49:37 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v5 08/11] hw/misc: Add RISC-V CMGCR and CPC device
 implementations
Thread-Topic: [PATCH v5 08/11] hw/misc: Add RISC-V CMGCR and CPC device
 implementations
Thread-Index: AQHb7AgpwI4ybOWM00q+wnzcqfnZDQ==
Date: Thu, 3 Jul 2025 10:49:33 +0000
Message-ID: <20250703104925.112688-9-djordje.todorovic@htecgroup.com>
References: <20250703104925.112688-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250703104925.112688-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|GVXPR09MB7293:EE_
x-ms-office365-filtering-correlation-id: d8d2e294-cb4b-41e4-e66f-08ddba1f4e39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?AJVp13/Zgwk0qS1VgjRJtj607ZYsb7suQw8hI71Gfd4dNlEw2pXUrSQcj8?=
 =?iso-8859-1?Q?YGRiTCzu2cxc4nF0UBEqjT72a/vx6iCLC7x8k+vWQNbSpa3U0Ih9CcYQUT?=
 =?iso-8859-1?Q?ktGoqxexuN/61HOWudthj8/Axy9JyBE4fchOCjOPR2MdGaACtLOx9mbyDe?=
 =?iso-8859-1?Q?B3yhTK+3mBvwHLiupgU0aGxzwI0jxC45G/EZzmyYa/++F66V4BKakH1Kf9?=
 =?iso-8859-1?Q?zby3Hph9NHZYq7yCKE91aYek9YzDhYP/J3gGmVlMWa7TCdkeOvRo7cbXyb?=
 =?iso-8859-1?Q?xheVStjar7in4x2SLmdvoXrLE0fqQ5ZE0wL6baBK8zAC+4po/vS8GXa8m+?=
 =?iso-8859-1?Q?fSv+jaAusj6L7afOM+fWTs56EaU0wZyndamwQfNTaI9HdLshp6qmwvRtGr?=
 =?iso-8859-1?Q?7cVwSy1h8Y6vvF6tVwFJmcIH+ro2MUuR3NQ6F9fhOjCCL4shml7Gy2Vx45?=
 =?iso-8859-1?Q?SkO9p8AMsQv2FYYf6/8AM2qzLV5GpUScyGHQdi6n25e2VRM+PBFqtemjfX?=
 =?iso-8859-1?Q?OH9FbY6OKyAoExbonKR0JfCrqo7KI6xBiTTP8wyWVcTmZCbv0UwTlZP9fD?=
 =?iso-8859-1?Q?XBBWzo466U6wN+IkpHz1C6BOrMIJQoERdx2lE2jIdQi+KucwlHW1wMUFdY?=
 =?iso-8859-1?Q?kdnq1Ls6OB29gxwXDaS0b8BrWFEpy7N+WTzE8TSeHjNvn2+0SM9bKn9TKB?=
 =?iso-8859-1?Q?P0EAH1DkTu3dGVhr9ZWXrR8MR4XX4mKim78YLwkT+GDG4W6nhkw8gYYuAN?=
 =?iso-8859-1?Q?IYjomMVq94R/oDkaCpSRmr0c5JrdbKqdj8mrFutnDy36OlR2aQHc1MbE7B?=
 =?iso-8859-1?Q?Xn0I6TYS41l4UtIJf+7SpbyIAFvgJf5ZUf/taAgKKzqIw3ef+uqCjTA9eX?=
 =?iso-8859-1?Q?8YKcIEt24JdNyyERgAo7yAFJpwE0/1GQpnTW0r7NL3LUksMKz4/PHp3KNY?=
 =?iso-8859-1?Q?gYM1JtiZTcmoWhEeqdxcbTRU+80yOUUblvijSLuRCkvsxe8JbHlPkgdMJT?=
 =?iso-8859-1?Q?JD424GmC6ko2ToGjUCo4P1gvwjtiAWNMNEPCaC/56pYDs65xGOWRW4da22?=
 =?iso-8859-1?Q?MsNxI1/TDckgyjV54fDjyIwOafgLUnuwlgPA0X8ezf9SSLb4JXlO4BKwRn?=
 =?iso-8859-1?Q?5V1eWYe9mnctJeLnk9nuKuWGb7aVtXpb5Ia2DNrNcikI3LXJGOjG1mIn2y?=
 =?iso-8859-1?Q?OJp8FiI+lT4ZQXNcPVtSZS4UOrU0YUJBIGQeFrE0peVKmu99dQQmdkev9X?=
 =?iso-8859-1?Q?3g8/VSv35mI3/nOlHBa7CvatCVva1Ufsf2UTzjvQXuWdL6M860cLCETJb/?=
 =?iso-8859-1?Q?ngl1wAzLE+HQ7k/xAIU5mv5gjL1o3HdNresh5brFNX2jwuMhKIHSEVztVV?=
 =?iso-8859-1?Q?VVxeSICdpwMJIna0robPd0heaXodpEbQAMyk6bHzJRV3wHOXe0hO7J41Sl?=
 =?iso-8859-1?Q?wHKPHtMJpeajeb4q1q/gPXdk3g/tRPqR+zNFC5q2J10grslxEjI4BV+oA2?=
 =?iso-8859-1?Q?X+0AMyU1WlRAsDo3EzMubiAGLCKUQgfaH14/uUdtDEd/mIszFXR39VNmVA?=
 =?iso-8859-1?Q?7E13Ems=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6R6BmEsluFrkhKl6jKiKjW3wRyfsz2MYQcwmd+VvgviCSImISMvILLEH8z?=
 =?iso-8859-1?Q?N2sAJH9Jq+J5zJ4a3z+ugXiAHoPR+arus0TWOSGDUY5Iea4dYwKgf2dKhT?=
 =?iso-8859-1?Q?VdvFjfx3jp3piI0u9vBfcuKU1bFb2kYdfT3vsEYvtRod7w/SkALLic0ilJ?=
 =?iso-8859-1?Q?8y+LbEXrdkGyvL059vHAsINYxUfWxQ7YSgrAjDv+uidtM3ATqnTOvr0NL2?=
 =?iso-8859-1?Q?r2ls7whpE2F0JD3vgghKGsblcYXGLqeXwBynFKVSjMrdR4W98lI+P9txjj?=
 =?iso-8859-1?Q?dw5dJCimK/+W4P4UDSYXJ43EibpKmF4z4n8y3DaEK3CrXqVUc3Iv9loJyc?=
 =?iso-8859-1?Q?DySwCkP12lGD0ezUkX58sMBnImoXPd8F1reqsrg9Ux98g3ypZMn2k4axyl?=
 =?iso-8859-1?Q?Dvc6bIdpYMPJJQdBNd3K2tCrsrQUP+7KRLYRhu8cPCkeW7/UZZk6rR404+?=
 =?iso-8859-1?Q?7RUvCyqeX+O8mr8yJ0Ms7DGWC1VQT4vdz2GgT9ywk1OO6GnnKtA6tKOHbM?=
 =?iso-8859-1?Q?vK2Wsla7mYYVv9wZ9GHl0hciNfYPD1/fd26K1QCHm5K9tVzXpbJc6vf/7D?=
 =?iso-8859-1?Q?nfjJvXB0/j/OBOnUADs+Otqj7C/vi5+8Mlrm4yhrOYeSCDTORaqRfB6Cjj?=
 =?iso-8859-1?Q?F56i76MhI5I//erYKTZU2r5IHxUfVHwKRV0CW6EQWRtrIyxsSjpFV+Tmkt?=
 =?iso-8859-1?Q?decQqYL1cxaECOckgj11gNUNu7IBhZ6g0hQUEwkSSeiNvSPB6pDHSVrvxX?=
 =?iso-8859-1?Q?J2xrtLC3fSblrnptVVrASF3dRC7Gb4fthwie5763pm0GO0pnlFeX1d/P4r?=
 =?iso-8859-1?Q?agi8vY4mCWYr0P/J6jkzKYry9x53G04yfPm94se52z172kIUIQNiM3M/yL?=
 =?iso-8859-1?Q?Q3DBWGXCy4iWtio+WYcag7rxEeMcb3Cm9lmWt9EAJiwny6UsW+WZew+E50?=
 =?iso-8859-1?Q?5YI6bRkd7JADM37jGK0/shjXSzlMh5O8lHUt3EFusTkwznQq5X0RDQ2YHB?=
 =?iso-8859-1?Q?b7oae7UI8qoch7V8Jz+kqoK9NboDfYCRU7K2N+b4DnBMg6mu9K57sg8w5p?=
 =?iso-8859-1?Q?tKXKp/UQ6lRKonWiKia/sauXxMzWr7braj5UmEWiJN1Fv6YhSCGKaKVmKG?=
 =?iso-8859-1?Q?7jzDdo/5dr5YM0oVSXW0q75Bwy4O9yBnmsugXb0lnjq+F2pW02iMkFXZsM?=
 =?iso-8859-1?Q?DgLT/QrRCpoMVzX5I+DZ/rM9Gg6jDPYQM2BkLvkDf+TYPgW93wZVzSvK/i?=
 =?iso-8859-1?Q?ZumArE6JAZXwK92DEgfHjbsPCvXyc7m7UxXFBXB6g4g0yNgNh7pb77+Sd7?=
 =?iso-8859-1?Q?HKCeq4NDhuqlWOSKLOznxKVhZ4l0kSH7YrTUA7Lz84obzC1SS+xDOzwUcf?=
 =?iso-8859-1?Q?8RCJBaNO6X1Y9pkg8Ax6oEbBW07eDVIFTLw83SH9SmJRFYQCYZE5s1toFc?=
 =?iso-8859-1?Q?LEnw9TosZMBIiMHmN09DuMTQIH2oylFiB1O9lRLhePzNe4CGDk2mhpis3Y?=
 =?iso-8859-1?Q?+ldSSzFIxCvwoT8Gxmtw95/ZrIEuzN3CDtkeqJDVGzdDdblaETORnPpL0b?=
 =?iso-8859-1?Q?bilHe/Iu+Py60i1e9Gs1MN39YZKTG4C5yKSf6G2/J3K0kKodlJyODXu3za?=
 =?iso-8859-1?Q?9GUZKqmV7V/8z2UVTOCAj3+WwXYlFmsJSBr6xcggKNsQa5v29ohWJ2K82v?=
 =?iso-8859-1?Q?pudX4za112QtbiCWQbY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d2e294-cb4b-41e4-e66f-08ddba1f4e39
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 10:49:33.6161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 01j3sLLn4zj1VQfH2S2jNhtBsP7vBGDp44kRVpzSrlszU1k9SPMarHBZkffiXXqk5/pgLCJkURulMcdNfDK4cqqw7NG4JxCJjwPQ4boGBnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB7293
Received-SPF: pass client-ip=2a01:111:f403:c201::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR03CU001.outbound.protection.outlook.com
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

Add RISC-V implementations of the Coherent Manager Global Control
Register (CMGCR) and Cluster Power Controller (CPC) devices. These
are based on the existing MIPS CMGCR and CPC implementations but
adapted for RISC-V systems.

The CMGCR device provides global system control for multi-core
configurations, while the CPC device manages power control for
CPU clusters in RISC-V systems.

This is needed for the MIPS BOSTON AIA board.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/misc/Kconfig               |   5 +
 hw/misc/meson.build           |   1 +
 hw/misc/riscv_cmgcr.c         | 205 +++++++++++++++++++++++++++++++
 hw/misc/riscv_cpc.c           | 225 ++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_cmgcr.h |  78 ++++++++++++
 include/hw/misc/riscv_cpc.h   |  70 +++++++++++
 6 files changed, 584 insertions(+)
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 hw/misc/riscv_cpc.c
 create mode 100644 include/hw/misc/riscv_cmgcr.h
 create mode 100644 include/hw/misc/riscv_cpc.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index ec0fa5aa9f..65a89637ed 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -108,6 +108,11 @@ config STM32L4X5_RCC
 config MIPS_ITU
     bool
=20
+config MIPS_BOSTON_AIA
+    bool
+    default n
+    depends on RISCV64
+
 config MPS2_FPGAIO
     bool
     select LED
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 6d47de482c..05b1c0f3cc 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -152,6 +152,7 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files(=
'mac_via.c'))
=20
 specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'm=
ips_cpc.c'))
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
+specific_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('riscv_cmgc=
r.c', 'riscv_cpc.c'))
=20
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
=20
diff --git a/hw/misc/riscv_cmgcr.c b/hw/misc/riscv_cmgcr.c
new file mode 100644
index 0000000000..cfc58d8bc2
--- /dev/null
+++ b/hw/misc/riscv_cmgcr.c
@@ -0,0 +1,205 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * Copyright (C) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/misc/riscv_cmgcr.h"
+#include "hw/misc/riscv_cpc.h"
+#include "hw/qdev-properties.h"
+
+#include "cpu.h"
+
+#define CM_RESET_VEC 0x1FC00000
+
+static inline bool is_cpc_connected(RISCVGCRState *s)
+{
+    return s->cpc_mr !=3D NULL;
+}
+
+static inline void update_cpc_base(RISCVGCRState *gcr, uint64_t val)
+{
+    if (is_cpc_connected(gcr)) {
+        gcr->cpc_base =3D val & GCR_CPC_BASE_MSK;
+        memory_region_transaction_begin();
+        memory_region_set_address(gcr->cpc_mr,
+                                  gcr->cpc_base & GCR_CPC_BASE_CPCBASE_MSK=
);
+        memory_region_set_enabled(gcr->cpc_mr,
+                                  gcr->cpc_base & GCR_CPC_BASE_CPCEN_MSK);
+        memory_region_transaction_commit();
+    }
+}
+
+static inline void update_gcr_base(RISCVGCRState *gcr, uint64_t val)
+{
+    gcr->gcr_base =3D val & GCR_BASE_GCRBASE_MSK;
+    memory_region_set_address(&gcr->iomem, gcr->gcr_base);
+
+    /* For boston-aia, cpc_base is set to gcr_base + 0x8001 to enable
+       cpc automatically. */
+    update_cpc_base(gcr, val + 0x8001);
+}
+
+/* Read GCR registers */
+static uint64_t gcr_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RISCVGCRState *gcr =3D (RISCVGCRState *) opaque;
+
+    switch (addr) {
+    /* Global Control Block Register */
+    case GCR_CONFIG_OFS:
+        /* Set PCORES to 0 */
+        return 0;
+    case GCR_BASE_OFS:
+        return gcr->gcr_base;
+    case GCR_REV_OFS:
+        return gcr->gcr_rev;
+    case GCR_CPC_STATUS_OFS:
+        return is_cpc_connected(gcr);
+    case GCR_L2_CONFIG_OFS:
+        /* L2 BYPASS */
+        return GCR_L2_CONFIG_BYPASS_MSK;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Read %d bytes at GCR offset 0x%" HWADDR_=
PRIx
+                      "\n", size, addr);
+    }
+    return 0;
+}
+
+static inline target_ulong get_exception_base(RISCVGCRVPState *vps)
+{
+    return vps->reset_base & GCR_CL_RESET_BASE_RESETBASE_MSK;
+}
+
+/* Write GCR registers */
+static void gcr_write(void *opaque, hwaddr addr, uint64_t data, unsigned s=
ize)
+{
+    RISCVGCRState *gcr =3D (RISCVGCRState *)opaque;
+    RISCVGCRVPState *current_vps;
+    int cpu_index, c, h;
+
+    for (c =3D 0; c < gcr->num_core; c++) {
+        for (h =3D 0; h < gcr->num_hart; h++) {
+            if (addr =3D=3D RISCV_CLCB_OFS + c * RISCV_CORE_REG_STRIDE + h=
 * 8) {
+                cpu_index =3D c * gcr->num_hart + h;
+                current_vps =3D &gcr->vps[cpu_index];
+                current_vps->reset_base =3D data & GCR_CL_RESET_BASE_MSK;
+                cpu_set_exception_base(cpu_index + gcr->cluster_id *
+                                       gcr->num_core * gcr->num_hart,
+                                       get_exception_base(current_vps));
+                return;
+            }
+        }
+    }
+
+    switch (addr) {
+    case GCR_BASE_OFS:
+        update_gcr_base(gcr, data);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Write %d bytes at GCR offset 0x%" HWADDR=
_PRIx
+                      " 0x%" PRIx64 "\n", size, addr, data);
+        break;
+    }
+}
+
+static const MemoryRegionOps gcr_ops =3D {
+    .read =3D gcr_read,
+    .write =3D gcr_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .impl =3D {
+        .max_access_size =3D 8,
+    },
+};
+
+static void riscv_gcr_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVGCRState *s =3D RISCV_GCR(obj);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &gcr_ops, s,
+                          "riscv-gcr", GCR_ADDRSPACE_SZ);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void riscv_gcr_reset(DeviceState *dev)
+{
+    RISCVGCRState *s =3D RISCV_GCR(dev);
+    int i;
+
+    /* Update cpc_base to gcr_base + 0x8001 to enable cpc automatically. *=
/
+    update_cpc_base(s, s->gcr_base + 0x8001);
+
+    for (i =3D 0; i < s->num_vps; i++) {
+        s->vps[i].reset_base =3D CM_RESET_VEC & GCR_CL_RESET_BASE_MSK;
+        cpu_set_exception_base(i, get_exception_base(&s->vps[i]));
+    }
+}
+
+static const VMStateDescription vmstate_riscv_gcr =3D {
+    .name =3D "riscv-gcr",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(cpc_base, RISCVGCRState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property riscv_gcr_properties[] =3D {
+    DEFINE_PROP_UINT32("cluster-id", RISCVGCRState, cluster_id, 0),
+    DEFINE_PROP_UINT32("num-vp", RISCVGCRState, num_vps, 1),
+    DEFINE_PROP_UINT32("num-hart", RISCVGCRState, num_hart, 1),
+    DEFINE_PROP_UINT32("num-core", RISCVGCRState, num_core, 1),
+    DEFINE_PROP_INT32("gcr-rev", RISCVGCRState, gcr_rev, 0xa00),
+    DEFINE_PROP_UINT64("gcr-base", RISCVGCRState, gcr_base, GCR_BASE_ADDR)=
,
+    DEFINE_PROP_LINK("cpc", RISCVGCRState, cpc_mr, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+};
+
+static void riscv_gcr_realize(DeviceState *dev, Error **errp)
+{
+    RISCVGCRState *s =3D RISCV_GCR(dev);
+
+    /* Create local set of registers for each VP */
+    s->vps =3D g_new(RISCVGCRVPState, s->num_vps);
+}
+
+static void riscv_gcr_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    device_class_set_props(dc, riscv_gcr_properties);
+    dc->vmsd =3D &vmstate_riscv_gcr;
+    device_class_set_legacy_reset(dc, riscv_gcr_reset);
+    dc->realize =3D riscv_gcr_realize;
+}
+
+static const TypeInfo riscv_gcr_info =3D {
+    .name          =3D TYPE_RISCV_GCR,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVGCRState),
+    .instance_init =3D riscv_gcr_init,
+    .class_init    =3D riscv_gcr_class_init,
+};
+
+static void riscv_gcr_register_types(void)
+{
+    type_register_static(&riscv_gcr_info);
+}
+
+type_init(riscv_gcr_register_types)
diff --git a/hw/misc/riscv_cpc.c b/hw/misc/riscv_cpc.c
new file mode 100644
index 0000000000..004f0e8062
--- /dev/null
+++ b/hw/misc/riscv_cpc.c
@@ -0,0 +1,225 @@
+/*
+ * Cluster Power Controller emulation
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licens=
es/>.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+
+#include "hw/misc/riscv_cpc.h"
+#include "hw/qdev-properties.h"
+#include "hw/intc/riscv_aclint.h"
+
+static inline uint64_t cpc_vp_run_mask(RISCVCPCState *cpc)
+{
+    if (cpc->num_vp =3D=3D 64) {
+        return 0xffffffffffffffff;
+    }
+    return (1ULL << cpc->num_vp) - 1;
+}
+
+static void riscv_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
+{
+    RISCVCPCState *cpc =3D (RISCVCPCState *) data.host_ptr;
+
+    cpu_reset(cs);
+    cs->halted =3D 0;
+    cpc->vp_running |=3D 1ULL << cs->cpu_index;
+}
+
+static void cpc_run_vp(RISCVCPCState *cpc, uint64_t vp_run)
+{
+    CPUState *cs =3D first_cpu;
+
+    CPU_FOREACH(cs) {
+        uint64_t i =3D 1ULL << cs->cpu_index;
+        if (i & vp_run & ~cpc->vp_running) {
+            /*
+             * To avoid racing with a CPU we are just kicking off.
+             * We do the final bit of preparation for the work in
+             * the target CPUs context.
+             */
+            async_safe_run_on_cpu(cs, riscv_cpu_reset_async_work,
+                                  RUN_ON_CPU_HOST_PTR(cpc));
+        }
+    }
+}
+
+static void cpc_stop_vp(RISCVCPCState *cpc, uint64_t vp_stop)
+{
+    CPUState *cs =3D first_cpu;
+
+    CPU_FOREACH(cs) {
+        uint64_t i =3D 1ULL << cs->cpu_index;
+        if (i & vp_stop & cpc->vp_running) {
+            cpu_interrupt(cs, CPU_INTERRUPT_HALT);
+            cpc->vp_running &=3D ~i;
+        }
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
+        if (offset =3D=3D CPC_CL_BASE_OFS + CPC_VP_RUN_OFS + c * CPC_CORE_=
REG_STRIDE) {
+            cpc_run_vp(s, (data << cpu_index) & cpc_vp_run_mask(s));
+            return;
+        }
+        if (offset =3D=3D CPC_CL_BASE_OFS + CPC_VP_STOP_OFS + c * CPC_CORE=
_REG_STRIDE) {
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
+        if (offset =3D=3D CPC_CL_BASE_OFS + CPC_STAT_CONF_OFS + c * CPC_CO=
RE_REG_STRIDE) {
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
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .impl =3D {
+        .max_access_size =3D 8,
+    },
+};
+
+static void riscv_cpc_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVCPCState *s =3D RISCV_CPC(obj);
+
+    memory_region_init_io(&s->mr, OBJECT(s), &cpc_ops, s, "riscv-cpc",
+                          CPC_ADDRSPACE_SZ);
+    sysbus_init_mmio(sbd, &s->mr);
+}
+
+static void riscv_cpc_realize(DeviceState *dev, Error **errp)
+{
+    RISCVCPCState *s =3D RISCV_CPC(dev);
+
+    if (s->vp_start_running > cpc_vp_run_mask(s)) {
+        error_setg(errp,
+                   "incorrect vp_start_running 0x%" PRIx64 " for num_vp =
=3D %d",
+                   s->vp_running, s->num_vp);
+        return;
+    }
+}
+
+static void riscv_cpc_reset(DeviceState *dev)
+{
+    RISCVCPCState *s =3D RISCV_CPC(dev);
+
+    /* Reflect the fact that all VPs are halted on reset */
+    s->vp_running =3D 0;
+
+    /* Put selected VPs into run state */
+    cpc_run_vp(s, s->vp_start_running);
+}
+
+static const VMStateDescription vmstate_riscv_cpc =3D {
+    .name =3D "riscv-cpc",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(vp_running, RISCVCPCState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property riscv_cpc_properties[] =3D {
+    DEFINE_PROP_UINT32("cluster-id", RISCVCPCState, cluster_id, 0x0),
+    DEFINE_PROP_UINT32("num-vp", RISCVCPCState, num_vp, 0x1),
+    DEFINE_PROP_UINT32("num-hart", RISCVCPCState, num_hart, 0x1),
+    DEFINE_PROP_UINT32("num-core", RISCVCPCState, num_core, 0x1),
+    DEFINE_PROP_UINT64("vp-start-running", RISCVCPCState, vp_start_running=
, 0x1),
+};
+
+static void riscv_cpc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D riscv_cpc_realize;
+    device_class_set_legacy_reset(dc, riscv_cpc_reset);
+    dc->vmsd =3D &vmstate_riscv_cpc;
+    device_class_set_props(dc, riscv_cpc_properties);
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
diff --git a/include/hw/misc/riscv_cmgcr.h b/include/hw/misc/riscv_cmgcr.h
new file mode 100644
index 0000000000..9ce2ef34f3
--- /dev/null
+++ b/include/hw/misc/riscv_cmgcr.h
@@ -0,0 +1,78 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * Copyright (C) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef RISCV_CMGCR_H
+#define RISCV_CMGCR_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RISCV_GCR "riscv-gcr"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVGCRState, RISCV_GCR)
+
+#define GCR_BASE_ADDR           0x1fb80000ULL
+#define GCR_ADDRSPACE_SZ        0x8000
+
+/* Offsets to register blocks */
+#define RISCV_GCB_OFS        0x0000 /* Global Control Block */
+#define RISCV_CLCB_OFS       0x2000 /* Core Control Block */
+#define RISCV_CORE_REG_STRIDE 0x100 /* Stride between core-specific regist=
ers */
+
+/* Global Control Block Register Map */
+#define GCR_CONFIG_OFS      0x0000
+#define GCR_BASE_OFS        0x0008
+#define GCR_REV_OFS         0x0030
+#define GCR_CPC_STATUS_OFS  0x00F0
+#define GCR_L2_CONFIG_OFS   0x0130
+
+/* GCR_L2_CONFIG register fields */
+#define GCR_L2_CONFIG_BYPASS_SHF    20
+#define GCR_L2_CONFIG_BYPASS_MSK    ((0x1ULL) << GCR_L2_CONFIG_BYPASS_SHF)
+
+/* GCR_BASE register fields */
+#define GCR_BASE_GCRBASE_MSK     0xffffffff8000ULL
+
+/* GCR_CPC_BASE register fields */
+#define GCR_CPC_BASE_CPCEN_MSK   1
+#define GCR_CPC_BASE_CPCBASE_MSK 0xFFFFFFFF8000ULL
+#define GCR_CPC_BASE_MSK (GCR_CPC_BASE_CPCEN_MSK | GCR_CPC_BASE_CPCBASE_MS=
K)
+
+/* GCR_CL_RESETBASE_OFS register fields */
+#define GCR_CL_RESET_BASE_RESETBASE_MSK 0xFFFFFFFFFFFFF000U
+#define GCR_CL_RESET_BASE_MSK GCR_CL_RESET_BASE_RESETBASE_MSK
+
+typedef struct RISCVGCRVPState RISCVGCRVPState;
+struct RISCVGCRVPState {
+    uint64_t reset_base;
+};
+
+typedef struct RISCVGCRState RISCVGCRState;
+struct RISCVGCRState {
+    SysBusDevice parent_obj;
+
+    int32_t gcr_rev;
+    uint32_t cluster_id;
+    uint32_t num_vps;
+    uint32_t num_hart;
+    uint32_t num_core;
+    hwaddr gcr_base;
+    MemoryRegion iomem;
+    MemoryRegion *cpc_mr;
+
+    uint64_t cpc_base;
+
+    /* VP Local/Other Registers */
+    RISCVGCRVPState *vps;
+};
+
+#endif /* RISCV_CMGCR_H */
diff --git a/include/hw/misc/riscv_cpc.h b/include/hw/misc/riscv_cpc.h
new file mode 100644
index 0000000000..1946c3507a
--- /dev/null
+++ b/include/hw/misc/riscv_cpc.h
@@ -0,0 +1,70 @@
+/*
+ * Cluster Power Controller emulation
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licens=
es/>.
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
+#define TYPE_RISCV_CPC "riscv-cpc"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPCState, RISCV_CPC)
+
+typedef struct RISCVCPCState {
+    SysBusDevice parent_obj;
+
+    uint32_t cluster_id;
+    uint32_t num_vp;
+    uint32_t num_hart;
+    uint32_t num_core;
+    uint64_t vp_start_running; /* VPs running from restart */
+
+    MemoryRegion mr;
+    uint64_t vp_running; /* Indicates which VPs are in the run state */
+} RISCVCPCState;
+
+#endif /* RISCV_CPC_H */
--=20
2.34.1

