Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAE7CCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 11:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v909N-0007OC-5U; Wed, 15 Oct 2025 07:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v909L-0007NU-Lg; Wed, 15 Oct 2025 07:58:35 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v909G-0007oF-7z; Wed, 15 Oct 2025 07:58:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFeFtRx/EFChIoYdtFSq3EGTuZEO2mBdeMFKrr/wVUNIbTc/gNWY6bqBtRhLXBuAYhnqS7swoNHEfWBBf5Jeex4VsJlN+7F1a/x4PXNIpNfTsS9Y0Cx/xbRqy+m0xsc1OO7Ok6CPLLEXTqXPQMeEHZLaL2XiRMx6QPAHLoWZf5mHG+3L7uZy/+IHpQm6NccSvWTE3cGvFOtrk64a0wdDiL+CBq8VfiMI2Zh2PkIzB+JMrhMkPiTKjBahdz3S8qRANhO0Qzc45LcrIFynXp53uSo/Jl7K08l0OjvwcVfgtognnedCwM+PwiP7Lf8/svSgR7jgn8+Z3UmvM2AuTtSkeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksIeetRZ3Mvf38H2ffdYm4vS0vWAgZzhy6QHP28h1lM=;
 b=xTsXo7ABNkCa6h/tWbY5l02AxAHPH2hbt1E+ENH1ylXwHiLEgU5lJNfsKPEiHbXZACWcAPi6cusu7L1euO58O4131OcU6LBIIQr0XxbH6iqN1DmqHZoKOycNOVCZOP7E+KNbdNAKCCvT49h6cUOcDNrQ00MzvYOgA/2dKzv1TxHmnNXIDT8FJVsN4+cGrInNddNlqKUudOqkOEiq2SneAKZaI6blDawVI6cJXJcvhCkxUvYfOFkdjCm/MnrfBUrJpLrGOEoAhV02XqfWK36BCE8z1ta+GkR2AUji/cE8cyy1l+B7CkwKtR128UdZjg/7HWv52Vf6CQ5XVaYjcZJXlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksIeetRZ3Mvf38H2ffdYm4vS0vWAgZzhy6QHP28h1lM=;
 b=sLtG6FY+7NlxL0FTD7lzVoTmqEmv8Y943oerzpCh3aCDoDlJRhsUDPNyHvkwEEKJoA6nlBLBT9LWwlinCyv0YwLY3uWVxedkUb/2m5iypSvySECeiVQFYX0cMRQ8HCfmfR0PXp0N7zED72ZOr2f+N3MXA1uZGqtI72MxTlM+GCv700/uqd/ybIAPfkl91jzjMPC0C2/kvBGL7HmPSQqFw0RG3YZe8X+9JLzT/qUqm2gFRBZVpim4Me3SIdJS7NDrmUz1I8+A+p53y8rLygrH8yiZFK0hVsnVd+IcVzwCGpeWkWFvJ4wEXZARgE0MVUzsv4HG+JeTqmzm9g2utyp9DA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GVXPR09MB6780.eurprd09.prod.outlook.com (2603:10a6:150:119::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Wed, 15 Oct
 2025 11:58:22 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 11:58:22 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v11 12/13] riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
Thread-Topic: [PATCH v11 12/13] riscv/boston-aia: Add an e1000e NIC in slot 0
 func 1
Thread-Index: AQHcPcr/P7dQH6v+qkmdU6oFYcDAkw==
Date: Wed, 15 Oct 2025 11:58:19 +0000
Message-ID: <20251015115743.487361-13-djordje.todorovic@htecgroup.com>
References: <20251015115743.487361-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015115743.487361-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|GVXPR09MB6780:EE_
x-ms-office365-filtering-correlation-id: 20feb054-032f-467b-b920-08de0be223a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?rMP7DK0Hje6l24Phpa/Y3HS5P+jtz9FzliMoFDdZfxi2cZ0/qNXnNUf4EO?=
 =?iso-8859-1?Q?ffMJ4WG6EVBtSsTxd4zAQCMAF5tnnEw/fRrM/I7gPQeOe583HKm8b27EQ6?=
 =?iso-8859-1?Q?oOEDKBuO6zHt8rAYTNwWF6algN/rIr10Bev8VcTZ7pxEvw+KqNkRk3Fohx?=
 =?iso-8859-1?Q?wovYZAm8Yi0D2C/BvQ6vi+gSGp/5c89LAC1X+FLqgo6JKILbgxuD+6c2QG?=
 =?iso-8859-1?Q?fZTdDLwmyIzkX+phCZuK9iqdmwZz179vUZKut/0VyQUL0jh/jRokGbzurc?=
 =?iso-8859-1?Q?+lg2lNt591Sjy7Vzmu+SQvKWVZ1f2vAbmk4ffxXxu2fMHrrWs9+atMBkHd?=
 =?iso-8859-1?Q?VFfmTb4DvBMqLXi/ARWkSf8M2CIXGLmPb+bqpM4zMkEHpnpdEBRU2pDPvg?=
 =?iso-8859-1?Q?5xG+/RmcTJMMcfm49YK32Ai0nxcCRIuAa713Ot1T8Q7zAB6IVIGzoI9Z6p?=
 =?iso-8859-1?Q?dp57BuN80wieu70v+5D4JCVcvSE0i4fzG3clfLnMdsC3/xNg+4lp1UuwMl?=
 =?iso-8859-1?Q?E7qXXrJ+qKCjIOZodDztz2Y+Ki3W88PkIC1J2Y/94MD+dgAyRe5bXHp8Qv?=
 =?iso-8859-1?Q?F04X8Y4r7Mn3nK6hvrcZ6FdphqbksKKLSKlTmG8OTmJVhxviYqiU+kEoMz?=
 =?iso-8859-1?Q?6fza2QUPWNpg5ItgVZ0g0BE6FZR/294i9vhxAP1iqWvU0Afl9A4QwLBfkW?=
 =?iso-8859-1?Q?zOvH8ubiiB3uNCm2BDPFpmrLDCnBxRBBT6go2gVgjS2ZB1tyq8FtXebb4X?=
 =?iso-8859-1?Q?x+RihDtUPJCBlvXUQDV9jMAJkRRTmMXrpK/8+6Kv1oStJix5R8A+4fstbm?=
 =?iso-8859-1?Q?rVamcJev52PD2RBfNl58T0Z78q6N8w7/j4XPghI3g7Cd1HaQI07VgJ8Eox?=
 =?iso-8859-1?Q?cLoClkL0CQsYDdUzF0HLgW56568A1I+0+m+6xPuPCGjwoxqdxGKhepJzMW?=
 =?iso-8859-1?Q?f+VXKKmjgIXvf+U+4Rga52qmq8BSYjXhVwue/PtUoGxz4zQ0ubcG0IByvK?=
 =?iso-8859-1?Q?OrzG1uXacRMbk3vYDtOkwQxD5QHjL7ug+0v4k3rKvdhHCqguSvXnrzJrC8?=
 =?iso-8859-1?Q?soixhF/sytNCk8lfqihUkjy9yY1oyEgDcenG8F/qInVpuDT12doU+NGh5/?=
 =?iso-8859-1?Q?lZZvuGWI26Edn5dFvxIZoJNcMjhc5/pAjpEV0wQVosccLdw9tyW0x49kuo?=
 =?iso-8859-1?Q?lIVZ1ETTzRxsGevjWBc5oNl+J+cqVXGEs/FM8GzpxhO4IXqTnXRC48qrRG?=
 =?iso-8859-1?Q?JFWNlD72pUKUVSUXarAdZTR4pYSkRqPwg7R99VbTCp/ZUmOaUP/XGozfLo?=
 =?iso-8859-1?Q?9c9hhnGd+skpQSTh9/EP1tYEKOmrRq3fKgbsDinfAzQaOUiVeFVBgNPnke?=
 =?iso-8859-1?Q?jI1EOd+iMIve2JQSn6pgkMmtcdTPBqFHMiQg//AiAdPMaxXQpbUL36xis1?=
 =?iso-8859-1?Q?uwPIBe3SRnNWyMkwHgcZZwNSH0jRVN07x3EAFHi9Bv8HFgyn60Q5rFIcX1?=
 =?iso-8859-1?Q?Y8p4bva6Vnncpk1+sz/Cn5wyTECeYpDQjd29G8OzqO08jEJK9xODMJUUHA?=
 =?iso-8859-1?Q?NaPNeEDMVahhqztpOrbWSogi/zY3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FEUOi8xYORAhCQVOr3k9NaEKy8A9DeeQGB6mCHIq9oMwCggzoIGM4F2YHn?=
 =?iso-8859-1?Q?VisEguS5dlP7rgMu5hIhm25wp5xzfA9x5oSoOnUg+HVZJIbtJOVZLOtc5P?=
 =?iso-8859-1?Q?sDOgX5ncCIeeR5hMYtSkBo8IBe77vdLbj2Q/EWU1hUCkTy05QSaEcAQoQP?=
 =?iso-8859-1?Q?bogm8Tzmq0iNektTPytxE5e38SX1wbhGUcuIy7vaGE91NmHlmTLtI+NlR0?=
 =?iso-8859-1?Q?3sjA256fx2iWrueUD8DSEE1n1STGNm2Baq22Jut6Dwg5/ysi4Ygj5MpD20?=
 =?iso-8859-1?Q?lDfNKbqyjgBaM/L2dRbXz0+dnLMAayOo97QuuRji3ZU0qqbWYwPg9HfAFI?=
 =?iso-8859-1?Q?UAkCp2B7u+3jyPZ/MgNqp/ftPxTvlW/1H1Z1iYe1fHgzeyybcOHz9Wxqyo?=
 =?iso-8859-1?Q?bY8vQtRu4vSaNF7b4lpgXwdq3/xsm+i/GWsUQ6mfXP/tdd3H4RbQ8ciJ82?=
 =?iso-8859-1?Q?/8TzWP+nP+0osRKyZ3Gs0lWzd0HgoPUpf0SlqQf2ybuWDMiNUgDjsq1Glw?=
 =?iso-8859-1?Q?fhMDSaqr9gfkxNLN1MqsTaK4cLA8x/SEUxmzklsCGyXcfLCdcJU5U9in37?=
 =?iso-8859-1?Q?/Ep9KrxcH9M6VVDGPFlw/6oZWEqWcFW5An3sNo2uSEnELif/ZWWjY8HLdh?=
 =?iso-8859-1?Q?D7ySiDt9XjIAQGbmupUfMABxHuKyMfffAR95sa+rGQ6qzx3EnXEj7CxOlM?=
 =?iso-8859-1?Q?CWNQbOBDmavvOUhRqQbhTmLg23vq17QIElN1QQK3CA8NsCDGLgK0LVmZGs?=
 =?iso-8859-1?Q?/344ZqRZfAgeIu2DsLNBsed5Hv3yWZWb9kp25pcIlDkiF/tJ5AgZs2vu58?=
 =?iso-8859-1?Q?6a38buuY4GuYRAJ99zJzjBNQh1eSh0iQjO9xYX8cEu84feqny03UvHYoGI?=
 =?iso-8859-1?Q?YgN5Ye+w7hSiK9JQsmn7rhOr6PTKKnxQIjgOzVfadUoz45EoNkn+bZQ067?=
 =?iso-8859-1?Q?/w5ANMzsmXqjBgUNmnnVSAU7GSsQSJuDb9t4Zyqe9NJiOqLQ2zQhNU/siR?=
 =?iso-8859-1?Q?uuEC4jqYCsrKxIiVXq6XFV6P7ptjbexRcBj1S50zvSthzVrSCRHkrqDAF2?=
 =?iso-8859-1?Q?EHHaoLdinMDMks1CtWrup7iAJWF/6jIeG6hJpJB2Es+ypEYkdC4nWdY1jg?=
 =?iso-8859-1?Q?y02RucFT98lh+hAG6qtZ5D8mxAaEJ6LO/MGvbjHwH8JH6yii9NRW0rUc8+?=
 =?iso-8859-1?Q?gPYYcktjcx6ofH/XGUyinNjmfJfltyxzPpstTcffVojIJ73XIe0speGLOd?=
 =?iso-8859-1?Q?5ptJROprUMDXgi419Cuubp6DXECvvzx0JbICL4n2A+ivlh4V4i2oj+HT8B?=
 =?iso-8859-1?Q?j4ohXJS1GvrWzyW4zZpB0R3WLWbQy5dXDe9ITP93NQA37uoA/ijPyU4prF?=
 =?iso-8859-1?Q?JkgY+eJpFJlcAOo0HZnuCXf2tFz6GAogFRSi8bDFwJuhFjxOu8Eq/X5Q37?=
 =?iso-8859-1?Q?DcP78eI7CJ18W1n6XB0lZKqc4SUoGPfYz26f9q7yn7UI1nvgnVgpQrRJhn?=
 =?iso-8859-1?Q?59ml7qZFIqqEaN++TxbN6gaoRuV0oZsPzymgzMhk9Y1tB3PJEgwqgMlE5W?=
 =?iso-8859-1?Q?NDzY2zzFKoT3nXSKK1QIqhi5/ZfQXfOnGKXyT2iw7ZjxJl6BhYdXUJEAVd?=
 =?iso-8859-1?Q?LOORKbyiRZPSrWuyJ6m0KhzQvSoszjse1eOFs/QMvinvjG9XKCwxmbMXM0?=
 =?iso-8859-1?Q?kXmvj8ZOg0NSdywB5ro=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20feb054-032f-467b-b920-08de0be223a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 11:58:19.3867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F56zimge2r/h6/k/zFiX54I+7KoP7WJd7l0iIzkVQS8jDXkQkcwAfyxtm9pSSq4/VE5jW00IeTLWceFnBabnNX93ltop8j2r0tTDBX90F30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB6780
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

The Boston AIA board needs a basic GbE NIC.  There is no PCH GbE
device emulation, so use an `e1000e` instead.  We place it in
**slot 0, function 1** in order not to conflict with the existing
AHCI device in slot 0 func 0.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/boston-aia.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 7d8b91ef04..44be6e03d3 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -424,6 +424,11 @@ static void boston_mach_init(MachineState *machine)
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

