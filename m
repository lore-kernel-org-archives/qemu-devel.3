Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DB8C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHVi-0002ok-Vg; Thu, 03 Jul 2025 06:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uXHVh-0002oA-Ay; Thu, 03 Jul 2025 06:49:45 -0400
Received: from mail-westeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c201::5] helo=AS8PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uXHVf-00077q-7U; Thu, 03 Jul 2025 06:49:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PB3tcPxQ03aTZqX8yFIx2eedqwFyugyLStt1sXzArwFtfy4OzjdHIwz35WLrPEbG7ygHv6Omwd/kryzyjcBW1t3VAgmaXnTIVM4ADEdF6polthfFq3btV9JP1+Lo9BR0wUUeN1c+p6arASHBeoqSt4pjsQUltlEpm96p+YORZIT1+MhiZVQ3ijUuF89gwXQeYbmBnYZG3+J93pNc966nnRxMXM3LL6CxnEc/CnSFi1vUHbT2fdEY8/5Kdm3FSb3i9RXQHJJohbMpPTmTmOEv2kxTNr+emr8xrs6FyCf66NKQuCtU7Vt9rDf4FsSZCo2Qw/HW1VKWp9RYz0Pz5ZlPeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgUMR/B/2lw0HsJHZUG6gbrefWN3NSXV1lBPi8zFQro=;
 b=uaU7+gfDOL+8MZMTGz/z9iIuQ5nJucteBodjymBYiqEVIh5zo6xn5wxYdmDoArhJyQ+5jEgkwXVnDegn3hoDC+O0q1bjr1U20iAaw7f0ryuBdzpw+wUEEY+0Q4hvS5Z/XLh17Ddc5l5Tkmynq+pH9uCctDtMeL7ilSIFEjkttyUn09xpWJlYWCyjO+MKnHkQVTT77H9Me5vfLeQo89FHWIWnPV6Y9E31AFxnwwmUUWSfEDBtACEoBI/qVoPWbYIudBv78Z1H2XAz1NRw/UjYSlvVF/KcxV5X6zjmC61LMAoYHx6QMVy2tBz8s3UJlY9vmhL+4Y1uv0uvwSGdM8+ktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgUMR/B/2lw0HsJHZUG6gbrefWN3NSXV1lBPi8zFQro=;
 b=cjnhwVJG2iuAEEGJYxfiYtKXsrxcHKoW8XaKy1HelIru4HgAkax7rgY+2hA9v8PWzv5OJEP+b32p2qA4YdvKy58ZtDKAA8xfuz2ZNataZzKzGrOWvVJn1+A/8w/Bsg9O66rbcnXMX/stiKQZSUjuEI5+649dpR7dz2ZTtKj4RCQct0NGqn+w+LI2/We+mdIPKEdtZYS41/ExXx42czjrjUgHJEpxrW3rQ9O3hvQ0OteC3n3rVe263GL400/g/BC5fjbJk4XxZ8ZQZGhO1Ee13O3aJLcXZK1gNIqWnu4YqQxnVlNjZV4ysPSByXR5yL0a6H/2W/G/TgdNz9KGMcy4FA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GVXPR09MB7293.eurprd09.prod.outlook.com (2603:10a6:150:1bc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 3 Jul
 2025 10:49:36 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 3 Jul 2025
 10:49:36 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v5 06/11] target/riscv: Add mips.pref instruction
Thread-Topic: [PATCH v5 06/11] target/riscv: Add mips.pref instruction
Thread-Index: AQHb7AgphBxP0cJfiEWZAfKdTGxKjQ==
Date: Thu, 3 Jul 2025 10:49:32 +0000
Message-ID: <20250703104925.112688-7-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 8bd86ca7-9f80-478f-f3f0-08ddba1f4d6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?bI41F2TPXTRdjTCV9HQ9DQFdpMq2ApehcW4BEEjMf1vmvwN6oiQAzfm3FU?=
 =?iso-8859-1?Q?GN7Tc8xog6tSO2utJbfr2ecjXdf9O1LZpMivXEOAIr0nxN5zAJ41XI9cV3?=
 =?iso-8859-1?Q?kQm8SZxnl8exoPzCdsejMV9LLoUkeBbmMltdihUB+51zArRJTiw5SK+Hw2?=
 =?iso-8859-1?Q?rC6Z8aQoT/BeOfR7A4iAQVHGExcs+HisJ8GChvBmXlQ+Y1UpXAJViX42Tp?=
 =?iso-8859-1?Q?2Qn+5itGXKl0IiSPfeVlW7KP7sNBaMZWxlMA64DxbGTnS/UTE/U47twqgW?=
 =?iso-8859-1?Q?dSqa5JQUyKQKgjXTjDpeimiNCDAd3b7SImj4798nr3zVqdM6ei20t2bfCr?=
 =?iso-8859-1?Q?wVMyyRHycDb8vhra8k25Oh8LxiZBf2pQJE3IOrt2DE6/LplW290dBNDjPI?=
 =?iso-8859-1?Q?0kSJOH8sKwzCMM3chmvxWeRUcbNr2f3hqw8f1OBWEaUQ5NfnTCspIfSv/8?=
 =?iso-8859-1?Q?17PkpJ4odKR2wYPnHdhbm2CizlO7BKVAPJORmUjxo3vF6Chi5YBkyxHupu?=
 =?iso-8859-1?Q?n22HTCoYRXCcqnWV4ZxI1Kfed8q/aWU5eJOZw+KY5NJAcfE1n26VgMzhr0?=
 =?iso-8859-1?Q?4/jJPfHEiA6aeMM5ILt3IrAY6jmI0edAx+dXeKVQktNxHV9cxsy9SRljdL?=
 =?iso-8859-1?Q?AxuY2m2QO3NxepRvgqluyMig5PKmb0Lkh358PYMECynU/ayCwkrGF0TGIV?=
 =?iso-8859-1?Q?gOkYdO4EWojz9q1+6fw52jWLglI/YYySwkltFfUz9fghVX0KZqk8jZKNu9?=
 =?iso-8859-1?Q?E2eizMerSl79ZtNg6Lz356Qk0CxShbqbeiQf4tXaNtLuknkd8S79nPNsOc?=
 =?iso-8859-1?Q?tK79Dw7XVx7rYiKgxYTjXnt0mBeb2lbZOa5ftePs4QRvwl+dM8Eg17yI0N?=
 =?iso-8859-1?Q?JpAkUhIk/PWsUfHrBVcCJU8xR0tWghD+PzlU9Fr+woxakte0rhkY+e6gYD?=
 =?iso-8859-1?Q?vrRbsYNQxivS0GV2twMYwwnPRaZ3hgt34NTCJAokTD5CLrmQWvlYslKcJp?=
 =?iso-8859-1?Q?+qZsTHvkcb2cTDBzg4jI4YRw+SS9lvQrEN3afsA8nsFbvSs6HiTKKuo8IR?=
 =?iso-8859-1?Q?9s7QcAi+3sBFehN4g1RFZn7Jz7zlDjPyTy2rM44lF/SJ7yIWoj2B+j7vdD?=
 =?iso-8859-1?Q?6iSq7eJTTTYRj1xqct06wou8EcTFZtJT+XOMOMz+4sMm35h9iKXVnE58gr?=
 =?iso-8859-1?Q?6gdXBmqMUR9+DSlgs1zd5rSh+9QK9BcEkxyw0+P9D9c9lcYkI/w3LpNLnV?=
 =?iso-8859-1?Q?qFEl++jXXBUyaXnZ0wzcPJlI7aq7n+TQgCETYapveaAmfk6gzT4PscWHgA?=
 =?iso-8859-1?Q?RFt0nMsYOgjhpwq0s7cV0ugUjQOoJw7bCJXkFUkSNbAeROVWv0k77B/KMn?=
 =?iso-8859-1?Q?t3lf+tD7lTqmAX6PurD0gbkq5PpkOeGKZ6oXTjM+IcWW78jD9qcZryw81u?=
 =?iso-8859-1?Q?ay+03dF6X75rfCIlzgNc0nB9ygQWzhQXF/kcgOYMVSLSXxCJaamRGhLeDH?=
 =?iso-8859-1?Q?Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oQ+eKby0pGsa2okv20SRZnzhvh+MXBedAXM2A/iTnBEWYDSHPhXMEAv/I8?=
 =?iso-8859-1?Q?CVlLEz8w5yFiHbZ7GAipyMYCrD6E8vNKfM6/bWUSk5yQBwjdKtS0BScQfa?=
 =?iso-8859-1?Q?Gb5v3Whzl3rlCl5DVH/sQI0MBIBN7kxlqR7/KANanDJLBlrcuFSnE68KUA?=
 =?iso-8859-1?Q?PJ/s9k+kbf4rupICua6MZfKHy8zjeO+i7PjZzZbMIST0ZkaFtvKQE1yxR8?=
 =?iso-8859-1?Q?UcRe9heom7T0ggU61JBvSriDbfcptaf60hHMaO98AhU2b2co/98flXne35?=
 =?iso-8859-1?Q?1ZE1spL8AqZUnBn6/3U7fdRPFWQRTVQ6m9dM8zt682yA8Vgu1zqrYj+L2S?=
 =?iso-8859-1?Q?eRbiyA3WKAoDumgoS1WvsmTVQ+cSwPESoj44uukAZySND6Vmr+wGQijvI1?=
 =?iso-8859-1?Q?LMaPJkmdcrdShr9AxPfW2YqYc2SlxYCvrfI4d+wKm3XJ/ZwU8hzYPu46bB?=
 =?iso-8859-1?Q?H+vKeLmduA6chskHRtYXxvfZkLr3ykP9ETRegbM7bYNF7J7nmv9x0ZuwZL?=
 =?iso-8859-1?Q?tVrRo/FsdrMPuQ764Dnqr2cWLcyzlyCY+KI0qcLUO3oB1SfLrJLFIFRNYm?=
 =?iso-8859-1?Q?ptoCV5atiPPKF8cIeHhymNDxrhVqWZ4k/64lHyH0/XKZ2iYg6EjFsi/gJR?=
 =?iso-8859-1?Q?6V2U612HQnrUefXckRCgPyKAD1XkpCYtwF0RvTb61Gp84LKOkzOalW7d4C?=
 =?iso-8859-1?Q?UMT5lf5COz9m4G+nvDZv/ZMckO+Bui2qLZ1KDjR9K3DLv1lsrEpUBBQH5A?=
 =?iso-8859-1?Q?kiysbUCtwSOTxCoaQHXu81Y3RH60zXCxQbuaIwHmGO7t09QW/IVhUsOfr8?=
 =?iso-8859-1?Q?3khXy/RSokw9GPz6dj8g8GTdNlK7nF8IE+i4VNyXN52Hh+TkujAf+3r+5p?=
 =?iso-8859-1?Q?t1+61qUGBdg3XOz7BrnmgaDnc78jeC48E56arNC01nizb6qPwYfrt7KMxJ?=
 =?iso-8859-1?Q?a1HoX4sgF+ZQEk4ZoUvqBiDnezBhUAbkWohcV9f2KW9RAeOQ0/thkt0anj?=
 =?iso-8859-1?Q?aKl/fNqVwMbUJkbQxbXpCm/4qdKGMoD/qoQoO4j2QeLLKDnHBirW/9sz0E?=
 =?iso-8859-1?Q?SIorQLAABsZA0xeklLYrLtipVZY3LplFh7UYZcIQZtLOyY8gUnx6lxE3Fy?=
 =?iso-8859-1?Q?/UMpBCFrLE9F2ylVK32mXVobyQfo5CZSgBSFQmzOhsXdYtSTeyrcN0NC1q?=
 =?iso-8859-1?Q?sVPRb80MiXub7curnk/WA2pZDDpPwoKpJSLUPbv/9SVI+bfcG8zsseh2Iw?=
 =?iso-8859-1?Q?p8nqXxE91XddOmMHoIpJOtZV3Vd6rEfbc7fO7yCX+QIG8huoPqj1AAdRWh?=
 =?iso-8859-1?Q?25Nj3IbhJ6DLRsmdtu+evraMb6U+xsCErwPva0UtgUx4OtnhZ6L1AI9zGO?=
 =?iso-8859-1?Q?APN3A4sJYtqeHk0LI3C7lj2uqloEBGy5CkuznHdqJ73wO9aFUMI29aCtd0?=
 =?iso-8859-1?Q?g/H4ShbTFamp8cRBxRFrNdEp4pEOlMQ+Cu032qA3maoSn4FOrgcOK48PzW?=
 =?iso-8859-1?Q?R3x1ydoxxHL/dTPhSUue40P8upk37eCXzgDVKm1vEiLs4p/eXuSyQbwwvA?=
 =?iso-8859-1?Q?1rWoKdNkQZ5zcwfI+7Q/m9jxJErk19Rb4tAh6/OIdoiLWS+231xkP6PsDQ?=
 =?iso-8859-1?Q?nD2MiTMeTXOgFY3QMjc2bsfL3hs74EkZp/Lua8J4fqHkOZmLblWShrWj16?=
 =?iso-8859-1?Q?U5pAKeSQ7lXUVGxpAGo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd86ca7-9f80-478f-f3f0-08ddba1f4d6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 10:49:33.0128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dXg2aIZ/UetzyUj8xNUeOKNyjpi1JgstZ6E2N9Nb53YEQBumxW7ihYZgdbTLjeWSgeTuosnxVnzCv2Y+7f/9fOd3/FCiMtnlh1VqMFnea4M=
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

Add MIPS P8700 prefetch instruction defined by Xmipscbop.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c                        |  3 +++
 target/riscv/cpu_cfg.h                    |  3 ++-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 14 ++++++++++++++
 target/riscv/xmips.decode                 |  1 +
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 52828846c6..d280648b55 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -243,6 +243,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
@@ -1374,6 +1375,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
@@ -3193,6 +3195,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 2db471ad17..9734963035 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -22,6 +22,7 @@
 #define RISCV_CPU_CFG_H
=20
 struct RISCVCPUConfig {
+
 #define BOOL_FIELD(x) bool x;
 #define TYPED_FIELD(type, x, default) type x;
 #include "cpu_cfg_fields.h.inc"
@@ -38,7 +39,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
g __attribute__((__unus
=20
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
 }
=20
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index baedf0c466..9ee0a099bb 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -145,6 +145,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
=20
 BOOL_FIELD(mmu)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index 269b1082a6..6555a6062a 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -19,6 +19,12 @@
  *            (https://mips.com/products/hardware/p8700/)
  */
=20
+#define REQUIRE_XMIPSCBOP(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscbop) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
 #define REQUIRE_XMIPSCMOV(ctx) do {              \
     if (!ctx->cfg_ptr->ext_xmipscmov) {          \
         return false;                            \
@@ -40,3 +46,11 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
=20
     return true;
 }
+
+static bool trans_pref(DisasContext *ctx, arg_pref *a)
+{
+    REQUIRE_XMIPSCBOP(ctx);
+
+    /* Nop */
+    return true;
+}
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index cb334fa4bd..697bf26c26 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -9,3 +9,4 @@
 #            (https://mips.com/products/hardware/p8700/)
=20
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
+pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
--=20
2.34.1

