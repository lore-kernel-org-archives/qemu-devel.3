Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D7ECAC5B2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Leq-0003vF-FG; Wed, 24 Sep 2025 05:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1LeQ-0003hH-8G; Wed, 24 Sep 2025 05:19:03 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1LeH-0002zm-Es; Wed, 24 Sep 2025 05:19:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLKeXbh9+j0zlt0/BT15E2CT0B1NpNGEWUMh14yAVGYWIMpyuxpeFKw4qwsc8qPbivr0hQVzVNAiXqWJThilwVIdg4BP2tKjvYpl7pMgatTBROcsx3G7tafZuan/h7xwWnAzgG+qByGocqWazPxRKe1ViURys2CwFZiZBMnPqDvYxhEjrXkcv98p4N/auZUt9S3tIlm6AuQ5mb8jxjHyOtWe0Fc2s6kGY1M9n4lo5CcBzQ9Cy98Gs5tZt/Ovs+YsLdb6QLEJCKWKue6i1h600mGS2TYoL/WsgRWV968YHlOraIrHwJtm/cy/fsJ4bvSTpHd+WI10O5H1pCXeY6QTCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnCq6oAHcDE9wLU9sZyEZDc+HMO9X+rmjmzPK2pBu4U=;
 b=u+Npw7Nv+JQ6Glq9FMkMIgKb814riqZEBD6RfP+aDxfRqW+nl+8MeGb/iucebiaY+jVpSOg24Y0O8KVdbsvYm7Rb4E0xZs1KxxsKwxFKvHCGFkxteap3a9xWC2U5eBBG3kjGQBPkMHCf9KQrhl4woX4xexFvla8HV+kY5oAgHJAvTgoJqCzvGhlqMH5O7aEbS1ScFSJWJxH4tNsBg+1ZkR2tQmjt90XITVykMl+jwWYC/ttAH7tTJ4DGQh2lOdwo0Hf3HJ+jDBIPaDpmgHNHF1ObNqxsbEuVvrONKQdM7lBC2Be51syE30eEUmtSXSmTthUZ4QqO65VPwBRhIOzyww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnCq6oAHcDE9wLU9sZyEZDc+HMO9X+rmjmzPK2pBu4U=;
 b=a1lbXKWL6S0oqbqclL+pxv4dYUKq9a/NH0Ak4GR7nlmldoX/4QgZOJKfEzjnzieDEaf8Q36sdfRGGIwlk8B380XnYKz0MadljuDvlkCMJxmt4jbAad74/p+PZYofHSnq/iIoHpOArfWvDvIwMm8M4+Zw7BtIpdFr3gqkdKz99bkbQMq/hzXNBU1wcU2VY9vj4tmvV7cuYBSdJieczMcDYqBvytOyI0NQ8DLoOGTJoeTLrL591AEz2P5L00yZo18oZdkKn+pdSf7r3pf4XtS7GtsJ3rpLF1RJI/HuPgtIj8zJVMnnvH54E5R5Uq9U9um8PTLGmmGlnFW4XEFpGaCPZQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI0PR09MB7826.eurprd09.prod.outlook.com (2603:10a6:800:21b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 09:18:20 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 09:18:20 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v8 08/14] hw/misc: Add RISC-V CMGCR device implementation
Thread-Topic: [PATCH v8 08/14] hw/misc: Add RISC-V CMGCR device implementation
Thread-Index: AQHcLTQol+4S5fOIZkCwK+zeVIiXLQ==
Date: Wed, 24 Sep 2025 09:18:16 +0000
Message-ID: <20250924091746.1882125-9-djordje.todorovic@htecgroup.com>
References: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250924091746.1882125-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI0PR09MB7826:EE_
x-ms-office365-filtering-correlation-id: ff685668-40f1-404a-8626-08ddfb4b4dd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?VIeQxMF+nZOqi3e703t7sRwVwcuhK9hqYw1m1VgPRHzteAms4dnCvp7uaV?=
 =?iso-8859-1?Q?Ovb2C5UAe/MKqektZMxOav+Elpo4mzQWwLMD0F7mMNIcbX08nqRm8og7UJ?=
 =?iso-8859-1?Q?7DV4bRpO6Gp2rgAMGJMt5d3Xx3KidjGOJlDqUR9jP37yfielFcSU3ZLmsc?=
 =?iso-8859-1?Q?8eMSZGQSEeclcBZ45dMUze7wegUvIBVLa3vm9yqutM31M87jiS1eZiTYY6?=
 =?iso-8859-1?Q?QRoWKRR9YUG0YcTYezOeJaoaHS4/dYcX3w5vPNsRfez4m4G/dE2XoC6ClO?=
 =?iso-8859-1?Q?nsAEvOjUzljf4TxjdrYb2tiakOXiOaJwIH3lX/1mHPma3nFLqB2HnaExto?=
 =?iso-8859-1?Q?JsSQcMiJQfCZOWMpEU29c0dWTozQ6woPf6fba9mKueiaBkJUJFL4QDKHbb?=
 =?iso-8859-1?Q?7JmEo4k9mbwyvCc5W/JrsbKHzWv+sshaTM/5CxUlpdnVkVYPDQZ0k0chUj?=
 =?iso-8859-1?Q?tHDKj8plgRHxN7w+4+/pXa75ub5560b+V9dSJmuSUTXlbsS4baASLG0vBG?=
 =?iso-8859-1?Q?WHnWJv9juMOAl8ZCaTHSZoIX9Qyz3mzjygsAELSrnbm0naW0HtUoyRtVhJ?=
 =?iso-8859-1?Q?74VEoHU5+DCwfl00tDMNNpkCUy9XAavc8sdoIe5YPdEjtWNzeFg4s3KycX?=
 =?iso-8859-1?Q?d/tkFnroxVVYWCdvT9HTSjpMHRhRijxCFJeBvnRDNcKyg12v0thYZtwKIk?=
 =?iso-8859-1?Q?4itNatCDsMZU8pEzIgefteCmFWLXIJaa9elR24aFmqN7/ZWgJCU578uWG5?=
 =?iso-8859-1?Q?69ei5+0Qsq7Ws8ISxH9ZTqt/qWHyVmkrm75K6SaGNS9cNi41Z3e3IGIzNj?=
 =?iso-8859-1?Q?qqNZelcMhLFxACxQ9//pxJoRPr3iL3AMCI3IheKjTwk+MTyTCRVUg9pqci?=
 =?iso-8859-1?Q?QPaeGmig1lHnzNreVUEKTP2zrX2vb9/sqQDbhTdOjT3macfomStlNIaYbX?=
 =?iso-8859-1?Q?jB8JABuHJWO4DKVQjAnjOx+/lJ8QXqsmpi94R53Kykp63f/QFgtL2b1F2y?=
 =?iso-8859-1?Q?XpeYWFXV/+aBzc3yvGK8sqPQLJtnHGLG6JRnQ5uJEhFRAEqWtJ45XcpRNM?=
 =?iso-8859-1?Q?NRBMQWKbF37f7KENE3Rds4+2VEF79Fu3mevp+u9EEtMZ+DiQB7SqwewKW2?=
 =?iso-8859-1?Q?ErQRPkb9lJC5LpLqk3mnSsM+qolkmC9hk0x9yP4XJaSwMa1KhxjeL8HNjz?=
 =?iso-8859-1?Q?hVmWUY/MSEASB50uaIcx3qxTp/s9yTWSPaoQcfn/254U7ODaGE+QLCVg2H?=
 =?iso-8859-1?Q?JHxNljPcyk7PG87iUQmD4MjYSWWBftFpx8leaeDVQ0RP+Mn+GykKG6V4b2?=
 =?iso-8859-1?Q?jN6qgy5zMDpxjXsDWPnpLV2x5Gd/8VrRJ+QFJT77TvrfUEcaUeSCKxO8aq?=
 =?iso-8859-1?Q?8gc4f7i9A9ubrusPMPAnFp1//smfKN+fUtO3ArGYKCnugz9Ncb5jaxhStp?=
 =?iso-8859-1?Q?KsdcQfRQkYGxvDh6rGGA3IMWHdcp6zyLkfV+zMyPtdxRwXjXfPp/kqaqGL?=
 =?iso-8859-1?Q?dikSBTi+xj0xkkMwafJiu9Np2QHwvtZvMdxlk0V4DChQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tUAfvxsVkJtggf+eXxU05koU+LB0vlQxEfJwCji1bmUIE0YXC87zbKgf/m?=
 =?iso-8859-1?Q?A0Q7QnWnn9rTA2SRwCLFVwsTBmNtCN1WRtHGqh9M8Rf3/F4geJQpXoWnw3?=
 =?iso-8859-1?Q?vaOdmGeprVkyC67k7QguqVuF0HEYGE/ao2mW566iN0lw77vnZi1PQlONFu?=
 =?iso-8859-1?Q?uESdJgGANwCTDFL8UXinBrTaLDZrSW831hSPSkIZwVZ/YCOab12JWpOfso?=
 =?iso-8859-1?Q?HR1Yr9bmHMl8v1N4/HJBg07RSdJxN+Am/47NEcBSdv7QSh2vZGY/1XS95Q?=
 =?iso-8859-1?Q?LdTdRyTyCjalsz/NTOYi+/ROqfBD+QR60ETU2ceQ26dODh5wPibbSXCko7?=
 =?iso-8859-1?Q?hgzAEUNy0Y6mfqXcuUK+j2sSYpr0Pvff5c0WrjL/vBPRSYlTHd9Jqy00CS?=
 =?iso-8859-1?Q?3IFdJXAn0acoChRxwnYObzyspHaFg45ilvR7AmYWvUCrZzaDQrBEBDIx7l?=
 =?iso-8859-1?Q?3Yyt6KRJ2nVCLrb5o2pAwjx60CHXnHXgqVedQ6SEDGO7WyzPWvboOyRF9s?=
 =?iso-8859-1?Q?DY947ccfyGhq6TkeYjLxvb1l/uYjUZ5jtqxSBiod1s6RbmOxN8ZHnq9i88?=
 =?iso-8859-1?Q?6W5At1CLc5WiIMFYXhYydIIptYd2ATH4356Sy63DQCpp2+4QaUCRHo7fNf?=
 =?iso-8859-1?Q?a9G0ssQcHfc/7Y9AIX93eDAsrSLk1mcdzOusRTVBXpghucKHB4NMgIT+r/?=
 =?iso-8859-1?Q?WkvVdlvro/Oj1OroxVoCSUlIqZHvVghBiBp8KmN/VEQ4Uu7wjz6rodDeUA?=
 =?iso-8859-1?Q?CPNHyM52LX6hq0Jhaq5JI1dfr59VyCrRo48c4SbnnvM6qcLqazbpFQSm3b?=
 =?iso-8859-1?Q?uibAl2AmXtrQeAAv5NoXyI9HIAAe12/I7M0hMggrSS42fB2e0C013l19Qr?=
 =?iso-8859-1?Q?Cj7xyT32lvZZ3Zb15+gqtzT6IqZXtiEeitJ+tJRtZv62eb8Ij6NFbFxW8a?=
 =?iso-8859-1?Q?oqi99Ejtm5h3I3C9DA2RC4uomraCsneTNC+purAKtLbpKZrkbZS4iI/5ip?=
 =?iso-8859-1?Q?oodOa7e05EBvk+ZyMVMKNwobfxAvMoTmeGCAjlP1aYtFb0+rCDCTDLz0Xx?=
 =?iso-8859-1?Q?DbVS1nvClzS0QMD/+rqnM8gzfwsZBG5kR1VFoqIo7jjFdkkQnVAKdTGb+Q?=
 =?iso-8859-1?Q?4yPqSjHVab9UCjsWoLP18O+CQujHdDTtukiw864of3MW64/a90pkSnuJ6E?=
 =?iso-8859-1?Q?OiR3GXTdr/9rhhYJ9jHWF7ogutwPpJeFKHNtJKU4amICIezWkO55V9mLri?=
 =?iso-8859-1?Q?3xd0OQH/9dtsWEYqA8VscOBaDGQ0oQy5Oo0csE7NMEGms9b4aY5Gp+YWsQ?=
 =?iso-8859-1?Q?+D1z9r7D7vgqcBln7fwGidFO/UKjQD0sT4UAUQ8CeD2pqSH4COSHkfq5ft?=
 =?iso-8859-1?Q?TjFQHSkpiW5WVxCTEC44xW32BpTjUBmsXwmwbE8oiOVrnxfNMYemRoYkh0?=
 =?iso-8859-1?Q?7hYNiW8cfJ/pCDXqy3TqwEMEIzZJukDxqSYXz5OI9GPNhSytWbPTvzrJ1Q?=
 =?iso-8859-1?Q?bOyNaBhef4hyLw6CQgMxPACKJzatLXg8wkhYLeI85ynxx8IqzAr+foyqqV?=
 =?iso-8859-1?Q?l6A7GY/xjYfdCnla5+Ihp+g+TVYTGEodEImn9hU503zMy4Z6ohS2SzTdiO?=
 =?iso-8859-1?Q?K+/q6rzf227lX3KHQMe+k9D46H461Wg74Ukuay58uKqcTGkzxZKejYqkS5?=
 =?iso-8859-1?Q?/3O2d3xHJ91AWyKLOqI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff685668-40f1-404a-8626-08ddfb4b4dd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 09:18:16.1230 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +4gDARigM5Ah/1QpaUoMpOy63AarPwDTiI06PfuYYQ0sAd5ZhA2RAgSqYxtQ7GtBUiFQqgKnBlvE2HnT5RA6ftS3llfKBqA5IU7bPk3kuQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7826
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

Add RISC-V implementation of the Coherent Manager Global Control
Register (CMGCR) device. It is based on the existing MIPS CMGCR
implementation but adapted for RISC-V systems.

The CMGCR device provides global system control for multi-core
configurations in RISC-V systems.

This is needed for the MIPS BOSTON AIA board.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/misc/Kconfig               |   9 ++
 hw/misc/meson.build           |   2 +
 hw/misc/riscv_cmgcr.c         | 246 ++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_cmgcr.h |  50 +++++++
 4 files changed, 307 insertions(+)
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 include/hw/misc/riscv_cmgcr.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 4e35657468..c72927c3ff 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -121,6 +121,15 @@ config MIPS_ITU
     bool
     depends on TCG
=20
+config RISCV_CMGCR
+    bool
+
+config MIPS_BOSTON_AIA
+    bool
+    default y
+    depends on RISCV64
+    select RISCV_CMGCR
+
 config MPS2_FPGAIO
     bool
     select LED
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b1d8d8e5d2..ef891e465b 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -157,6 +157,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files(=
'mac_via.c'))
 specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'm=
ips_cpc.c'))
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
=20
+specific_ss.add(when: 'CONFIG_RISCV_CMGCR', if_true: files('riscv_cmgcr.c'=
))
+
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
=20
 # HPPA devices
diff --git a/hw/misc/riscv_cmgcr.c b/hw/misc/riscv_cmgcr.c
new file mode 100644
index 0000000000..cb8351a3bf
--- /dev/null
+++ b/hw/misc/riscv_cmgcr.c
@@ -0,0 +1,246 @@
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
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/misc/riscv_cmgcr.h"
+#include "hw/qdev-properties.h"
+
+#include "cpu.h"
+
+#define CM_RESET_VEC 0x1FC00000
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
+    /*
+     * For boston-aia, cpc_base is set to gcr_base + 0x8001 to enable
+     * cpc automatically.
+     */
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
+    /* Validate num_vps */
+    if (s->num_vps =3D=3D 0) {
+        error_setg(errp, "num-vp must be at least 1");
+        return;
+    }
+    if (s->num_vps > GCR_MAX_VPS) {
+        error_setg(errp, "num-vp cannot exceed %d", GCR_MAX_VPS);
+        return;
+    }
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
diff --git a/include/hw/misc/riscv_cmgcr.h b/include/hw/misc/riscv_cmgcr.h
new file mode 100644
index 0000000000..c57d4ada1c
--- /dev/null
+++ b/include/hw/misc/riscv_cmgcr.h
@@ -0,0 +1,50 @@
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
+#define GCR_MAX_VPS             256
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
--=20
2.34.1

