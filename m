Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400BECCD195
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 15:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA97i-000533-FX; Sat, 18 Oct 2025 11:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97g-00052h-8I; Sat, 18 Oct 2025 11:45:36 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97e-0001QR-Io; Sat, 18 Oct 2025 11:45:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/2eJslaXjXPsltR9c1vLnQoKICwKqmfe/i5NXOgboBkq3lwCdk9K6EOY/K+hgGw+An4r7TJfWOhE4J/2bARZirtOkNmdIEnOhmYKaiMfU4K9pEN/nMuq7wf0gP8VwF3V1clDJ+Di1lXdDpBLFWocPBOcsVwE8EVbLa9KlgxTXUSsU7zQ289lAFsxQtfMMM04lYGypSOQ9rtY8YfAbnCSUyUD3xvTjCvlHxylDZMEg9caL/51QdtL+6b6SHJ4R4UBcQOcj9QahXuN028HDNlkpDwZkpC2kQ1wUpzHyhhQZYemofwaskV7zFOrU/qTMOO8j8e5God5Bm/IpgLLoPg8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/TwECIyTxKnGlLSNCUXAIqcqKwuX3S1AablrYXs1eE=;
 b=viSB8G8DwyMoslQyh3Bje83j2Gh6mfBQZPkamjDspzx7r06ts5F3iiLvVE5ZYxbBNjVZTcu7P0pGh3d87/s8FYNqD81VLk4MBf5z+vOaVdZpdM/KsuB5/sfDz0itKDdTSMlEj4pFhycMpyo3kK3xZCRVTtsnyRndKi+zroQRlq7KWWxji173U7Y9oA2YjL0gcYrUzQwC0DHk0QJl754+pGPOMc0Ooq7TcL/Lt0NL9dgo6LVu0TME7kXc5jju0Az0mkk/XJtHeCTQPLPQBvGIpJTQ3bHLnJIzyp1f3qImyiVIq2vDLrkp86IOe89EpJS81IxO2BCl/eSXm38EIRSfhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/TwECIyTxKnGlLSNCUXAIqcqKwuX3S1AablrYXs1eE=;
 b=er1OOdIV7Vt2GYjyJnBAem2fC0O1QXxp+/xRIYW2EBuwZE1sdn+Eox1aJV5C36PnzQMpyMgyLU1gweMdpSOR/2TTBAmLuw/MvVTyco9nG7KptSq4Ef+bLHmbLIY7AyDlmvGgo1fbXWnDRdkH0F+YvsFc5bFHITxDFQ4Y2f45XFRcNbr03oXqmAp37v+7sb13sykr8nvBZrJnLneefnLNQ5ecNzRoOiposAn+iCDyTAuVfe1bfAWMsoHTGLhdAI3RBgtezabmyZyMRQKWULfqHVeYZAxUPNgrUZI92j4OYEh0hwlH8OPs5gM3gi4q01WgUCaUyHuBg87LHKv8FJHWsw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB4360.eurprd09.prod.outlook.com (2603:10a6:10:154::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sat, 18 Oct
 2025 15:45:28 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 15:45:28 +0000
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
Subject: [PATCH v13 01/13] hw/intc: Allow gaps in hartids for aclint and aplic
Thread-Topic: [PATCH v13 01/13] hw/intc: Allow gaps in hartids for aclint and
 aplic
Thread-Index: AQHcQEY6Z5NPBmc7zkSdmme/I6mf6Q==
Date: Sat, 18 Oct 2025 15:45:28 +0000
Message-ID: <20251018154522.745788-2-djordje.todorovic@htecgroup.com>
References: <20251018154522.745788-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251018154522.745788-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB8PR09MB4360:EE_
x-ms-office365-filtering-correlation-id: bac6a320-37a8-48eb-8f48-08de0e5d5ce2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?DQlj1bmM+VJfuTf6wYKVAf5G/3THTdTElWQXaVH746KnzgS/KB1infQ/xZ?=
 =?iso-8859-1?Q?2kADjYB3apRQz2g97c4xDAaK2v0wFrBlgriXzNbf70KDdP/FU1mG2rM2Vg?=
 =?iso-8859-1?Q?a/LHu5NYI8xq4xkM4bpnb5qHszEQWmAq1uWDwnMhy8Hg9dgghgRRcix4L+?=
 =?iso-8859-1?Q?7iuGwWHbe6WcIB3KrCUGIUIw8nCTNqg/EwYdFoSNE2G6x0iuhqMi3X0JNZ?=
 =?iso-8859-1?Q?KD/jJO664ZWrY+vy5puEZ+hQVt06nDa5F+NwPla/MhY8wcX/lhw3jWjPZF?=
 =?iso-8859-1?Q?EuPY6PIiCZnFDyZNZYiUZXyDXCDyF73haa5594hyl9xZGwlhwqM/qP6GhA?=
 =?iso-8859-1?Q?1Me+5BF/OUbWjMuj8QTH+2mqBgYE2ZkKDtUg4kYRJY7oBjn7q26LJfbeay?=
 =?iso-8859-1?Q?3wqd83DaGUDMv6ZjCqf1Ht6HjFTt+9tM8f5fdKHTPF9gY0uIdgYYpOAjvQ?=
 =?iso-8859-1?Q?bC0o2eb2V2c5SBRIJKKi2+F4iIq6Rf5R3vWht5Pb0rL4gKwjJVZ0Ib1c9t?=
 =?iso-8859-1?Q?QPSExXQRFVAyoVHcnX7ClTe+QKvFK9kZ5VcJh6wbI2BQBnmzKKBKLwf5w4?=
 =?iso-8859-1?Q?VNwWm8bwa9dbVBckWdFu2nlSjQqpYr3ACQCXHftWJIlt2uLBbKgboBa70S?=
 =?iso-8859-1?Q?8la7rJFKSXLfKuy4Gc12ebuPW9ClhFHzz/bJtLxxPCHAtfkEdmlRlFZaXb?=
 =?iso-8859-1?Q?EETLYjcdSxtI8kFvF2SjOxND7/G7RtvPT9GAF1iqEXO9ZSHr8fO/E282Iw?=
 =?iso-8859-1?Q?Vt0vlFdMs7dZ+HeKpL87BDNYd9YYjMjFRrxeZAnkSpsQFvaD5NiwW+WZQT?=
 =?iso-8859-1?Q?dvGOoaqSjaxPn2HBvCkKXblcuLTHjNPTI5nAFaUc9x86f99iR4N6IkcFCe?=
 =?iso-8859-1?Q?w6ndBcIMGjrEvu+IBfVX03jKAxDKs0h0AoNdQKCI7kx78F3PEfTLfSwXMG?=
 =?iso-8859-1?Q?StVg7qIXf24MQDzlTkS9I8gRn0zhjLnuroQR8LMepIC0bZrTSqm/3ac3vH?=
 =?iso-8859-1?Q?jCFrFYwJEZ+sa6kGrliRQenm0fytWHrRhZAB66COJ+FqbwJPuyO8yz/poj?=
 =?iso-8859-1?Q?yMaR2QAaOjXmXqRXd+Hgf/cEiUu15tQh9uQHrUoDHXrGFibqHWmwo8Uyjz?=
 =?iso-8859-1?Q?BhaVCNRtm44RSlyNJhN3hN5txBjBBuO+O0oeb37Pe53Kn5x8UAAyB6ikWM?=
 =?iso-8859-1?Q?YkryF2bpMxTvtGxUdIGQElOJBz5Do8XyUxcyuzu+u3b8iyvlxzhlal2/O0?=
 =?iso-8859-1?Q?OO2NpdMIWmvW40t0VMxOhjMFUTm8Wz6nAPADS3VacoGkvLCL8pI4Rshgf8?=
 =?iso-8859-1?Q?ljTFX0B/aXbaGIfp+kJpvbkOBrLMxqMTlG0uwGSYmyP4rGhD76CBcAQgeJ?=
 =?iso-8859-1?Q?c7taz+b7HDGrOlDTwKOUqehY/AluvmrLkgARJr7H9IW4M5f+3fudqGW9a/?=
 =?iso-8859-1?Q?8frCw44SWWLWI6jVY8+FEGHxfZ0eiGIN9QjFpEq4hUcMhEd4iBrTRGFeHY?=
 =?iso-8859-1?Q?7XjfM3eJLmBgZ7VQmzkVX/CBdrg99UqEKd4c+hePL7r10Anl72wtMRLZgQ?=
 =?iso-8859-1?Q?JQO4IyOumnOGhwuETVzqohAcWeM4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IpTnqT3yCjwF3vx2NijWyOEfByObcsVj44iBoqsF7cBJ0uho2rr4l3pRRN?=
 =?iso-8859-1?Q?GuYuiyLVEVj8SoJJy8w5Lbf1x1G6Y1QUzFa1naN9OvLBpjB4VybuCtugo2?=
 =?iso-8859-1?Q?HhC6+KnrssOinpjriLq3lye9bVOVHFod3h9FxV3BFTpULbb0sLYlA2/Moi?=
 =?iso-8859-1?Q?fpeIxpbrI/bfsAZAdAZIRvN1nfA4b1kcX4fxhB6nkOxzQ4vtbEFO3qpLLN?=
 =?iso-8859-1?Q?bVFB2KU9WIz5L+peig61TBKHc4s+9N916+3TgXCL22WtbaQrUh7QijgUJm?=
 =?iso-8859-1?Q?8sNlKtZhX/QNZ9jEZpOXtgEpfWVh11VEB6sfLYB3cvYo7urbJnLOwHflsO?=
 =?iso-8859-1?Q?Fqm6LzQhR/hhoYr1+7I4UA6LYtmsFHlvoGIa4dCnOhdATIrsr6x0YAowhw?=
 =?iso-8859-1?Q?v6P2wG4XecID3ITInapgkXzXKmkHv5Vie4UzaokiqMJvzbwDnGLsEvWvi5?=
 =?iso-8859-1?Q?yWNDqn2+tZGY/K5JVvAlQomnQ3/yzPiuwCXM4rUxMFflOBAC0ChSrjVBhR?=
 =?iso-8859-1?Q?3T4eXoawWhIxOL22HDfiXOywCVqyMYvSfaz1ZOJtBE4wveh5305mfQ0n1R?=
 =?iso-8859-1?Q?YrecfG8n1fCdRDmC72d3EhCyNAH9twq/yucCeT15Gp142DlLoPDS9nCIAj?=
 =?iso-8859-1?Q?Rs2RKncxtAN8EFpznXl5jB4y8H1IEjwtQ57ji11itpzLOJVmSA2hJNyjAx?=
 =?iso-8859-1?Q?mc82GVdUjeIABvBmrKt8D1MLClDHymuUUeKa3RnibfSydt88XySxiwhQVe?=
 =?iso-8859-1?Q?asqA9oM6sg/0HcKIARNVcAv67hjTSPbFwtaRB25p84oL3FUiUIx8GTTzyk?=
 =?iso-8859-1?Q?rqz9/G1r5ean8FF679sQBSkXjq1HRmLVj0ML0+RGDY+GE+5xxpszbMpR5L?=
 =?iso-8859-1?Q?YeNFrgns39aF9tQQyo9Uy5LdHddUbYaVqW9wNqYRqJa58trLxFtx9GXOwL?=
 =?iso-8859-1?Q?rzsaBTDuKMtS0CAnx+jR39g3eirpzYVEhB+9oHDs9v/OxIRqEG4cbbPiCp?=
 =?iso-8859-1?Q?3wund+V53szftJIjdCCi9Lfiv7+oJbWtJi80rf7X2TSIh5yQEMR2E1fA+z?=
 =?iso-8859-1?Q?FmTeDvH6VGUaUSfO3ehvnh2PKSrAittdGePwYhGlYSUQZ0i3L47jIV2pYb?=
 =?iso-8859-1?Q?uUaZZQZTNhBcTsHlG4VbbYmUrC+eYFqDsAJJePjqkoKP8duO0vQAL6keEc?=
 =?iso-8859-1?Q?7Sg1NusjpRbKxm1Mjq/C/FDPnimjr91ZhNsnIn5nScprbTzT5nBd7G3N19?=
 =?iso-8859-1?Q?TCSLFOH8Eme/FSyzj5JUA0BO5l8oMYUzda0SIg5wajP8fiWfvwVmnOb4u9?=
 =?iso-8859-1?Q?6t43N1dDTmLkzhEkc6H+jVYBqAPMEOHzHUcsr1jyiM2v2rrPn8lsG3Ijqw?=
 =?iso-8859-1?Q?gLYFKM4VrYBZoA2xuMlsdVGB2888O80ZXlCZl6cKwniqx3EjNVE4NKK5u+?=
 =?iso-8859-1?Q?DWZKl3zz/vOTK7m/SG844HD2Um9B6IRxqDdeNqNNDDmRFYspgq0m8l/NBC?=
 =?iso-8859-1?Q?FIm5MvUD4rL7YBHI5TVzBARmkXveyO+CodilvrkYyhtdT4nR6A3rz9+UEn?=
 =?iso-8859-1?Q?r7rNzZg1vs165s3ITIK1IV3Hlj/45/hWKL1nabf0jba41vzzlw2wgnDf4d?=
 =?iso-8859-1?Q?e9KcnQ0Ap/S51AhISHCT/ETVhZr3NdFjVvOyRDB+sSTT1BPrhtu9WqkNId?=
 =?iso-8859-1?Q?fY7V8SMovR5h+ABPKIk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac6a320-37a8-48eb-8f48-08de0e5d5ce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 15:45:28.2257 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: viTyyuHCxkWz2PudYxtY6o4I68cZDB9vNtlSQlxoaGpGn2zPZ1W1pCKmXTEakSTD6bK8mczuiehsbriFV527vJMMX23XmyiQ/lAIZUikyVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4360
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

