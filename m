Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CC2C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHWE-0003Cq-R9; Thu, 03 Jul 2025 06:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uXHVr-0002st-Oo; Thu, 03 Jul 2025 06:49:58 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uXHVo-00076R-K2; Thu, 03 Jul 2025 06:49:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYvqz1DwZtyNNimP4ttOaCwUt+tedAJJMaldHi5WyvKsb9JPyOq5Phx0TaMkedT8op0f/Z5uUWVWlp5AN463mInP8OXwISckO45tvbp3ACJteVPKUnQ769lH2QCEyQgYgeuRRkM+3cih06PNDFH9DgQbZ0K00sSMgCKPIbGvl9XpM6I9PTnC/JifQm/ffqiyvYX14zrEVJ2NgDhtJjIB5UtCyRiQLhBqMFPhgAEM5wIhRtQTvSk7oUYr9pFJaSiy3lyMdTvRcpEQfCHFirDyMSPTJEY+gdlijIjYK3/dJG3Jgeok5GjJVkm5XzEIBnSusl6GuKPat7VFNuuq82KaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVgTFk2jF0peu6V2HTWHvrIe6mZbdxmBqPxQ9R4imxY=;
 b=RauKEvaa2S+7eCuFzEMoiJDSfcl08pBSpxUlrRIiDyDCbwF4w3dP5Roaxgw0+X3Bpgypq4Z2KtesMz0nwD1fWwo4/S5mgQaDqMMFzwPbth4rWrDib2Q5LQv5A0orUzyk5ACj7xoojsEAA+9auaVA3IgGsdGZlriP5kncwWtisgo9/9jsOWqW4oKGVsS7WS3XffDzAD424LGbUaBMjOmVVTSqlV8omhyT71DmOyjp+xGRSKOkg/PRgEo7n5VnLlvXidwy5Ah/BPgrZAlZu/sNMxRva8/4hBe+tbvo5KfiY9S2W29dGiHCqZ+cOdKsVD+re7QTxugq+lc7CRFyvGmO/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVgTFk2jF0peu6V2HTWHvrIe6mZbdxmBqPxQ9R4imxY=;
 b=jw9mHQR32isNUsS9EwMjoHEONVInEruQodGtLMnxC59j0aV/JAhcL/eY5hAJJX16gTWwb9uHiWZBbvE8jGfsBrCtOlwLmzVQ0zXTJ4Piup1D0rsyv9iExw3dvSwVafrkQzDOZTHOlkb52tjdFXDfCAANltA2yNVbSBpMvbU8SAsUfWTNEZBuk1/GrCgmSCcp++fVQTWwFtFLQ8Dqk2eFaUlGkRnuepeWMWjKzHTezRITzVXT8giFPEsRHSzPomVlNzw/xgbn486ojq2E4GGmGlfkqp7H/lnOY8+h8dRnLcAsQgkQHI//3fz9zq0NYLJJQMkRW0DJJfd78lo2M7QPzA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI2PR09MB7288.eurprd09.prod.outlook.com (2603:10a6:800:223::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 10:49:36 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 3 Jul 2025
 10:49:33 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v5 05/11] target/riscv: Add mips.ccmov instruction
Thread-Topic: [PATCH v5 05/11] target/riscv: Add mips.ccmov instruction
Thread-Index: AQHb7AgojcabAz3hxE+u1gC29C90aA==
Date: Thu, 3 Jul 2025 10:49:32 +0000
Message-ID: <20250703104925.112688-6-djordje.todorovic@htecgroup.com>
References: <20250703104925.112688-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250703104925.112688-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI2PR09MB7288:EE_
x-ms-office365-filtering-correlation-id: 75660948-6dc7-4b3e-63da-08ddba1f4bc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?b5fB4NdWTsRjGvAgl1SITPPdus4o5yCqVEdk6d9K/cKyua1w+CeEPehsVp?=
 =?iso-8859-1?Q?uYxyKywqlOTSeQtEVqvYikZzeSMWDk166m5OSLaXi4/9eIW+fCXrq33dkf?=
 =?iso-8859-1?Q?eKDlgwPjNDKIjqLkx6N9G6U0YvImiR3VuExk+tlunZhaHfih2dCVaGYBiJ?=
 =?iso-8859-1?Q?noFx2wG418AmawAp+DeU0RaXAZjgeDr3stfxRS12Po87qYPZZvPld9MK/p?=
 =?iso-8859-1?Q?CLCY5X0IQbcMi7yG0G8cPXI8GCTkd6l4anIlcey0uOssnwHqFFdAwKEIWa?=
 =?iso-8859-1?Q?CUiRJUE+DC8CkIHG+aeccmEn2YUxIfIzkkm4gotuASafCSoNAjBsEJRohV?=
 =?iso-8859-1?Q?jpfASJavurWxA0wuP6wK0WKiizoVoumSG1kkuT2I8wPfojpWc6PF2batmO?=
 =?iso-8859-1?Q?eJU6kIIDGIoPbUXM5PYZ5QtlZ6qmilknjH9zIPH3rF6KZPGef34tXUoRWn?=
 =?iso-8859-1?Q?QK4GSarysQG+92acpFRYfhUNroZgPE860Cd2KTE2qJ1DYqWcb1z1aE4h/t?=
 =?iso-8859-1?Q?pEplxBqmKz2VHBiFC5DwyIbcn4r+/9bLg52D9onSbRYaV6PPuvp9uijGgh?=
 =?iso-8859-1?Q?6qYOPhlMj+bmXNEEYYinnRkpi4D2uizLL3BLngdW9rdFk3rQR4zQpYHZkZ?=
 =?iso-8859-1?Q?MnesFnU6grvnfcbHRzeZQgNTT4lnhsxnm8/M4epwBBimHKFZckO+0LH4lC?=
 =?iso-8859-1?Q?RleQ0O0dodWOavCzGnm7lxIDlmjtwACs8ABb55eVAZq+aOPi9Eu7IoewKG?=
 =?iso-8859-1?Q?HbZ5aODRnMn1RBBhQbX6GNWZBrPlwegE6MeYhliIUX5a4T0QfQWPjGaHKI?=
 =?iso-8859-1?Q?TNwgql+A0TJYCGF1kcK0aFVXL6pR59JPLTzmCpJb6zPHQX0ON7CuQyZk4J?=
 =?iso-8859-1?Q?kI7MlEHKHxQNm9fbkOID5ZREw9fYij/3nOa4aNch23IxGUTgmfyWSbiQF8?=
 =?iso-8859-1?Q?p4LkT+awmO1eIj7c7waoeBp+9zCc8EKpaOm2otsese0Xw345cPjwXiAT1a?=
 =?iso-8859-1?Q?3R2K5f3oPbWNme/7tzBIkKd81yBHshFFF7apl+RyuXFQbY0xmle5gHCYJL?=
 =?iso-8859-1?Q?BTeMeGFMZ/8BCK8Mneg0R4y11738CX94UNfmTRXTlAexxGJxB8y0dw3xvf?=
 =?iso-8859-1?Q?V+ySbfMJ+d0oYFU/qcWr5V+hCB9gbq2G/s2RSwL0SMkH9g116dXhBljhSv?=
 =?iso-8859-1?Q?2lcZLVPAOmtcmGcvfbSeRUf4p0JkB5qxdqPl51cPb4mgl5p0egKEPevO11?=
 =?iso-8859-1?Q?NxcnRI77IuIRRxdYS0azuceN1boUpGkakhe4QolN5k6J3YpZfgaSO69/dk?=
 =?iso-8859-1?Q?FYhKGfA5/KmscFzR/4LMX748MfcGAPqTeGpU27qOI3CJyvfCn+bt/GSrMf?=
 =?iso-8859-1?Q?cqL7pb2PU9KC+RzEmHz6ZedtBD5NVaurcaIUkKA+wDhRiKrs3a1MvgtGTV?=
 =?iso-8859-1?Q?0meZGSth5KgBXzQLuQg3Yl6nR7njYq5B1k8vQFb3pb29lYheYxSWhWWO0R?=
 =?iso-8859-1?Q?Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?z+cxtisAs6fSnLIFdaMIqA2NCtd9l1nDhmZDiTX0LKJKsPpFStv7MLSnFw?=
 =?iso-8859-1?Q?MLoM+TYuLnyqI4YLx0d9OJfYi9WuRXAlSBjmmKhaUaJiJqkr2mH5cunDco?=
 =?iso-8859-1?Q?0OPkgY7HqXiIz+N4EfQhaBkl9jPs/j4eytBMcekgupvQjkPWdUtlNqUerS?=
 =?iso-8859-1?Q?3vvyGc3RGqb5a4lLNV9rnitlYv3l3/JHUlo6Je44GojHZ2k8mL9dUHrGGy?=
 =?iso-8859-1?Q?ocfZD2m0iSqEOADoIDjM36RtSAkIS8FRduhYgLp6LMxxXVPCzQ8GXsNseH?=
 =?iso-8859-1?Q?y/Vvig0LZR5yj0JVVUql1cgYDkn+yFREKCsXzhBLLW8+KBhKqGO1ysQLXH?=
 =?iso-8859-1?Q?Et6T4OYq5U8g5mm28r6gfRNgfHjiYNbm5emcS4A9dO1tyvlI9CBlwZIJ4h?=
 =?iso-8859-1?Q?KMkGPkrYDxGvmB+Ku+AyOWsf6tk6J5MHYPZeu8bYlIy3CTxQFSypFo1fCz?=
 =?iso-8859-1?Q?lgEQ7bpQd4V89T8RiXUtuzKxOBBoid75yiQmnAwfpdAzBYS4ifCFTT+IxH?=
 =?iso-8859-1?Q?ZdSeAc3GHrxwlQUWFmplmbWdjdzddPMw3KJcV5lm+9BFO6F6OuCNyHAYuk?=
 =?iso-8859-1?Q?O2QHto0RJQfgeSNdK73X7pK/7VlziMiOXJMN6JCkvMnrUp0a8Z8LiUPYfy?=
 =?iso-8859-1?Q?1nO6PBQe0jXJm8K76oOHyQS0fbe+z6+7EONrayoSmAy3hcVHkWTFOcvvzj?=
 =?iso-8859-1?Q?NXNesEAJM6PL07bJtGliMYQEPcbTF/YWtxe1vkradLh+IWuq9dINPmft17?=
 =?iso-8859-1?Q?E5kcmbH9ow0/OLRKxzlZr1A4RX5qfNH6uVh+Cmgj9WcmD0T74MifJTpTR1?=
 =?iso-8859-1?Q?8wWnZuWVPEyOPWJh7cGxM4x7MnHFfZmGSd0Wjq/lPjjwKzyr7Ge739BUDb?=
 =?iso-8859-1?Q?efsVHDHswC4WDikuJiv/t4rIjJVLforEFLIPiwddxk4KGucRohHMP0PnyE?=
 =?iso-8859-1?Q?9MI1/weFgwCB57+567+okXEGfRK7v7qxfzIavKXuAGBhqfIS8OApHDj1jl?=
 =?iso-8859-1?Q?Q7ECspXOnT7Ay/P4nDCaHJIaPBUSLXGLA1nnCzVaUc44+12Fl0666iCm4s?=
 =?iso-8859-1?Q?NJ3RUbxC53TLYtNLgDdgHxB/9B3qQlibMv4qfwrOXtpd0AR9uVsmH3PqS8?=
 =?iso-8859-1?Q?9wGy3TV7sQaPy95X9rHua3uKE04qQDmnOEbGBECzvv3E3awcEjYqb7kzri?=
 =?iso-8859-1?Q?+e6V2Og4PwDn+jjLIr3AD9AJXZsqnl4MPo+PY8sF+0qUawpD/u7wT4/gkt?=
 =?iso-8859-1?Q?5kQ50gENoz4hzCSMON5KKrEyL+Ijxl/I7GsjiQveJ8joCrVX6DQ4XaiNWD?=
 =?iso-8859-1?Q?cmiuvs33oXn7XnbUH7jOJoDZwhN15vQR7l57ikrhxX9ZiylgVm65y9qEo9?=
 =?iso-8859-1?Q?/5oA+f9jFHdv/PF22fKgLr/TmgpU38obluh6AJHQGpTfYA0TIeLRbrf/Ce?=
 =?iso-8859-1?Q?7z398C4TwIdYYyNJgo6xXVB7XUUiPHQKYIrWvAT8LAE+bHiVlsAkwaZMFA?=
 =?iso-8859-1?Q?aI+b7ehzdqwyUDOqQeGscUMrKPjDnDX0WHyyQUQ4bZPYqKpkdz5MKqwG5X?=
 =?iso-8859-1?Q?G9PpXpOZZZFM+dV0BHICHXe1mgWc41Lf+KQlNDgqjtoZh3S8N4iS1c3Fw0?=
 =?iso-8859-1?Q?K88lSyBn6TSmFMmOYp+1JbZzX4s5I02uhYivdYpgYzu7OQuMjt1TXwH0EE?=
 =?iso-8859-1?Q?6gjrfhBHA30bsTN65B0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75660948-6dc7-4b3e-63da-08ddba1f4bc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 10:49:32.6981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ++yKUiCcZeKWw8VWlkGI8xxcIvfBSjYmgQYm16OA8QTxoz7lRAX1UhFX7gVExkNIdMEbnfboidP+6FrgxoC0zXmmV7v5A+EymdkI05NsGvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR09MB7288
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

Add mips.ccmov defined by Xmipscmov.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c                        |  3 ++
 target/riscv/cpu_cfg.h                    |  5 +++
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 42 +++++++++++++++++++++++
 target/riscv/meson.build                  |  1 +
 target/riscv/translate.c                  |  3 ++
 target/riscv/xmips.decode                 | 11 ++++++
 7 files changed, 66 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/xmips.decode

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7f453acbf8..52828846c6 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -243,6 +243,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1373,6 +1374,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
 };
@@ -3191,6 +3193,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index aa28dc8d7e..2db471ad17 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -36,6 +36,11 @@ static inline bool always_true_p(const RISCVCPUConfig *c=
fg __attribute__((__unus
     return true;
 }
=20
+static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
+{
+    return cfg->ext_xmipscmov;
+}
+
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
 {
     return cfg->ext_xtheadba || cfg->ext_xtheadbb ||
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index 59f134a419..baedf0c466 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -145,6 +145,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscmov)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
new file mode 100644
index 0000000000..269b1082a6
--- /dev/null
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -0,0 +1,42 @@
+/*
+ * RISC-V translation routines for the MIPS extensions (xmips*).
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2.1 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along=
 with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Reference: MIPS P8700 instructions
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#define REQUIRE_XMIPSCMOV(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscmov) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
+static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
+{
+    REQUIRE_XMIPSCMOV(ctx);
+
+    TCGv zero, source1, source2, source3;
+    zero =3D tcg_constant_tl(0);
+    source1 =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    source2 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    source3 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+
+    tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[a->rd],
+                       source2, zero, source1, source3);
+
+    return true;
+}
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index fbb6c8fb45..26cd11ec00 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -4,6 +4,7 @@ gen =3D [
   decodetree.process('insn32.decode', extra_args: '--static-decode=3Ddecod=
e_insn32'),
   decodetree.process('xthead.decode', extra_args: '--static-decode=3Ddecod=
e_xthead'),
   decodetree.process('XVentanaCondOps.decode', extra_args: '--static-decod=
e=3Ddecode_XVentanaCodeOps'),
+  decodetree.process('xmips.decode', extra_args: '--static-decode=3Ddecode=
_xmips'),
 ]
=20
 riscv_ss =3D ss.source_set()
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index d7a6de02df..a6713b78a1 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1194,8 +1194,10 @@ static uint32_t opcode_at(DisasContextBase *dcbase, =
target_ulong pc)
 #include "insn_trans/trans_svinval.c.inc"
 #include "insn_trans/trans_rvbf16.c.inc"
 #include "decode-xthead.c.inc"
+#include "decode-xmips.c.inc"
 #include "insn_trans/trans_xthead.c.inc"
 #include "insn_trans/trans_xventanacondops.c.inc"
+#include "insn_trans/trans_xmips.c.inc"
=20
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
@@ -1211,6 +1213,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, t=
arget_ulong pc)
=20
 const RISCVDecoder decoder_table[] =3D {
     { always_true_p, decode_insn32 },
+    { has_xmips_p, decode_xmips},
     { has_xthead_p, decode_xthead},
     { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
 };
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
new file mode 100644
index 0000000000..cb334fa4bd
--- /dev/null
+++ b/target/riscv/xmips.decode
@@ -0,0 +1,11 @@
+#
+# RISC-V translation routines for the MIPS extension
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: LGPL-2.1-or-later
+#
+# Reference: MIPS P8700 instructions
+#            (https://mips.com/products/hardware/p8700/)
+
+ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
--=20
2.34.1

