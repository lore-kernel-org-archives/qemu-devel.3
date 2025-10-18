Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A3ACCD195
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 15:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA97r-00058U-DH; Sat, 18 Oct 2025 11:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97p-00056t-6i; Sat, 18 Oct 2025 11:45:45 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97n-0001Rh-48; Sat, 18 Oct 2025 11:45:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOazUK+C8HeMOTURv12FFAUBx5RDG3q9gn+RA6bJpdhJCqEjv6Ym2GuHwhi0ukC4sak785qJhEMkROuYbIgLaonxGwcHaEGr/aejHbR9QzHFDNEyFoYQDehSW8E9qPCDnsC7ZPtLf7T47t0FNspaNrR9OlBWA/qPy6IDpWRMYkxodrylyDZnPhiVYcNokGyp4F8KABWQ9hVl9wlrLsOzJkTrCjrCpOjVqCt1IToff8U9MT2febRiSPNdSzQqh7pW1oDoQxm1qe9aVM89AiJCrc2MolBhivv7uZaeBolk4ydt9uLZ3l/5t88qQbWewyO+QvSbj1sAbhtqlglPT4avQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rD7NsZztFtW3xVK32pM36ulHIFJFWt4Xdv66bn0owNU=;
 b=Iaq+mFiKbXW5yy7HBHPewUxQYhPVz0+gQgjtaYRZsB7jnnAzkIah7iOx58+O6Lh8HwnaaIQyhmuYUMgDu2XKz5Z/UByo0AgBLVMbhTgqgXrWm3lR8VLWShwiV282H8u4sUgRabPaIlWOezbEjQIto0fkem9LOCs8R0HC0d3sdz2GU8/yCx8SVLHHnqrQ6ieEvAu69Lx8yKcUhus0QfZydcoE842SEobuRoAvh73p05ieNeXx9W07Vblh4E9ObKmGMmahX1C7OMQKwjfn/KJXPs7sWmA63upDPOlfq//NladbfMhVDIzXMy+aqeBcA9Cbr3tCTnCtpDYOxtLhCzunFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rD7NsZztFtW3xVK32pM36ulHIFJFWt4Xdv66bn0owNU=;
 b=W6eJ6XwDaUzySsiRD5KYGb0FYzT2Iklya5qkUF7cCaaZOoXB3TRBqVVM/o/ozNemlJwaE5F5Y2+RDFFTnncRlviZvGSHv0pfPKkrtMPTyjfgzeWhjKqxCPlcAPJZq8TFQyCDU4VFeOG5d3mWNeK7B7OYXbtyYgqEgNDwt+BFRGx6iFRjL7jyWIic7qFLWQ/oOivB4mXzbBi5hdQ3/Yc/xsQHoY4Ty3WbWlPNK74ORKeyUl/LfRyMqr3twgyQO1sdCHbJdlkn2rd+KfHTIVbD/nIg8Vf/HhOh5lAjAC1QP4TnNbnTQbmXzGGyBJklxq+CWf23blL1sAWuhHkI2JZmyQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB4360.eurprd09.prod.outlook.com (2603:10a6:10:154::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sat, 18 Oct
 2025 15:45:30 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 15:45:30 +0000
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
Subject: [PATCH v13 07/13] target/riscv: Add Xmipslsp instructions
Thread-Topic: [PATCH v13 07/13] target/riscv: Add Xmipslsp instructions
Thread-Index: AQHcQEY7/aNsEhoFzkuu28+RNx6AqA==
Date: Sat, 18 Oct 2025 15:45:30 +0000
Message-ID: <20251018154522.745788-8-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 272a8ab2-91db-4153-86ab-08de0e5d5ddd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?sps9QOuSYsqoN/xXpTn25ZwPYEZlwF+K4fhunIV2XC9efDvh7PTQLbVTJo?=
 =?iso-8859-1?Q?PSLpOU2eWZDNcX5T9RyZB0PGsaSnac6sZD9S04Hivj3BIhLTy6xFwnJPjw?=
 =?iso-8859-1?Q?uZgCztBGw+ycmydAT4zVGefieObsQqs9WurBlyzpn1uK09SzboZjtyOhff?=
 =?iso-8859-1?Q?NMtvcwoyQ6RP5/2dJInCBiPLlatRUE1R7YskdnugDPSmN1xsMOLjLk67zA?=
 =?iso-8859-1?Q?fdYLW5jhJp7PTT6NcEZQOCtnP2hgUmHzbgI0+2rwM2oG3kEV3ICQme3IsK?=
 =?iso-8859-1?Q?ORqk1MQqWfbJyVq2ESAw5PHGGxl+vMqnCb/cz3EQWA9PuN/YLYyKYxP1Yl?=
 =?iso-8859-1?Q?Zo71ARe17qV03OzUcW3drckf4zJwN2Hi/tnrol7eZOYY3AvFccK9SI583G?=
 =?iso-8859-1?Q?X992jTeMrJ57apPAl+q4uvvg661z9NN9mQKG+iVC4u39T4qUsW/9d8JjY0?=
 =?iso-8859-1?Q?Ig1WJTgbRcP1SQGwls8nNniNgXcfm+iFhtFfEQGSxNrt5C7xRtvxg12VV7?=
 =?iso-8859-1?Q?qJUrvOsX2K+6Sam7RNBmxzQRkxyniXwyvTUsXkFq2FF9g+mbhC5LkC4OoZ?=
 =?iso-8859-1?Q?5RPZ98nlhEV1fd/USyV5cf3aPjQFd6u/xqKUhneImj4e8Lz/DIMLc6f8hy?=
 =?iso-8859-1?Q?sxHqbXZisqe6HqLeeOyQDgT4j6WGTb4rCxSktqlJttgPJCoUZgIKThTZnV?=
 =?iso-8859-1?Q?Q18WETAlX6LxI1+3ZKcbjwcfiQ2s8t1wkTei5NSr/5BkygYj8Oq7436PD1?=
 =?iso-8859-1?Q?HbQi60m6jZgQKwju6Es/SrOqMU2Mj4SJabbuZnpQ24gdnTYWYCIXYJ2oK0?=
 =?iso-8859-1?Q?8YDZ0/gCrLwycJo49se7FHdmbG3I4RVNn8sYU71lFKgdaoZXCnvqILya3T?=
 =?iso-8859-1?Q?KltX4vZkrNp8duuiVTeVMNX7ID45Wm5G7Y5RWoQVtNUdgu+K9vQ+6pde6n?=
 =?iso-8859-1?Q?fXHqtXsmss4kCTAMBDQn0d4xKdQQ3sS7jdhDlsS+JXOeEWAMPxJiUn7Aw8?=
 =?iso-8859-1?Q?iiKHOuLnj18m1kkVDkvpLm3JxmVYQkKVtlyk6LgMLhXjmNwwqyOqEA1I7E?=
 =?iso-8859-1?Q?4RF6JelGjDwEZ8NhY2zEHJllf3PfYV1//O31x13AzQUE3WBHY0SlBZoMyk?=
 =?iso-8859-1?Q?njukDK/Wyjkn0qH0qL3hbVdmaCTrzDSDAygRQCis+6rwSsVHlhzmusisji?=
 =?iso-8859-1?Q?Cwl+DyYGRUUwOBl19M3vW1wEmB2sNHMeQgJRfpihfA+cwiqnRJHIEgRRB8?=
 =?iso-8859-1?Q?6B+NqbnjElr4SkNlenyo11k128U7o0H8Y/NBuqm5eVh1uhfDxld0yR8fnT?=
 =?iso-8859-1?Q?mZsXnVGYlDBbPtpYCq+Jxz+lVfckW8FB+O8X4lyqY5nuGPZOa22JdPAphm?=
 =?iso-8859-1?Q?kHyN7OeM/vovllaYYpcuN+wfSKjPMiQPZQUMA+HY/jGRDrNsfZpJIkt89X?=
 =?iso-8859-1?Q?LRfwT0s9tD2OsX5WHTUmw/I2vF+hWlA8rTuyMWCnzjfA2dTyMri5jyWAeA?=
 =?iso-8859-1?Q?12CQtV+xFuTkHmVM76avICPal05vQixXxxXR3b9JB8XHg0KTs09B0G3cB4?=
 =?iso-8859-1?Q?QI6o/q5RlLAShPuU0QVdbLApJZSi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mE2n7e4/kuoeWlCuPamitphRnMO4ql/+YrWpo/6jnAjxwFsEQ+DUf6CZXk?=
 =?iso-8859-1?Q?7FQgai2PHw7qzjOjMhzaNrpqewwzxuoWYyD2sYz0dcFJxrYxfxq4HgPjW5?=
 =?iso-8859-1?Q?yGCz2QBuaRKjpGg8txEYXS1rRkni7JcMUf7XdcfumV3Ws39iLT+q59im5s?=
 =?iso-8859-1?Q?V+biqz/K9EOwZ3FbXv3nOYnDZW0rmpYXlgF2C5zhfIvoJ2lG7f4Gwr8cUg?=
 =?iso-8859-1?Q?loYApsc1PYviide0S0LDz7rWymmCPJTPDcHZKdQ/cnPXInOYKk9Tc0UXOd?=
 =?iso-8859-1?Q?cKqsUCiW/61VohnnOB5eE7PQLkGFVE1d9zEM9VMddQqyg2/pNUKXJfffPD?=
 =?iso-8859-1?Q?gXQcHMZ1xHuzZbwR2sdRU+3qsNdl2o0OpAtPG9eikjbvQ3/QchN/Nd6TLK?=
 =?iso-8859-1?Q?e6EplBgO6M2HoMRiXrWLqPEFTZSvKeif2d1AiJoTcV0y4bfwKWsEAg/EX4?=
 =?iso-8859-1?Q?W7OfuMUaQqsgBtcDSDj0wYjBcRoGgkSFm9JyhkJpPR4WH62VZeql6yKR5Y?=
 =?iso-8859-1?Q?m1/z6hbDdOe8oqB3Rh/mc6kDPWquV8NQeH3XgKPeZGjHy6X6BsFSbt4oW5?=
 =?iso-8859-1?Q?voiU3H5s1NyJgtWOJhbUzju7QMg8LDtJqKSU7BXA0dT7uO1ELALizsHu6B?=
 =?iso-8859-1?Q?UGD4dn7NMS+LN3jGXUf8T4CP21xl6YJQHMdk7FwHIpCE/tWnhatjpLc2wb?=
 =?iso-8859-1?Q?bVuuiAIewwfQ0SjXvkHmubPhgUlNkEY2SMxQsPZaV0+4MobfYOKIwxZ6CR?=
 =?iso-8859-1?Q?DeW09hkBVGoBWBRpQX04euf9giZVynCnBoutWNh7CIDN7bHFEFGxfRPt7w?=
 =?iso-8859-1?Q?FGy/izxqZh/67ufuY5cvYsfKvXd/X0rnxPl6rUMqNtBnFPyz7T7OiSWjtP?=
 =?iso-8859-1?Q?hZSWs7e1Wb7e7IF07815wnf9qgVZZSYfzTrLjoMxjGk4MX1Mr5OMRY1xA8?=
 =?iso-8859-1?Q?M+v1RJ/V3yL4IddRhmwHr+TYRoCNW2ZWolrGwwSXYP9OeMcJs3oXjsG8Rx?=
 =?iso-8859-1?Q?tse5rUihTw2wcjR5HBSuDys9i+Ic+yHm3Mfix/AvLLVbnTQqzquE06/GGN?=
 =?iso-8859-1?Q?te3jN5R1RBCDam46SbIEZ8ZPRSGwK66dWkijFHxnI4ET5F51Y8neBvlQxs?=
 =?iso-8859-1?Q?rNpgS6avjAlubMv5Z3HdM+5LyiyBbRDPEEm+Q34lLNyyoSla8FeYhoJPNO?=
 =?iso-8859-1?Q?Y1pZLfjGu5Pl//gECuEEIiHvNKpZkKPsU7l9oG2zsmH/bf9chml7CGZv+K?=
 =?iso-8859-1?Q?2OCagIJEdVhAABuOPxOsv+YF+ObB9fzwbhIDm8j75T78K59oSTCoZftkuP?=
 =?iso-8859-1?Q?vQsY5ygV22MgRq3zv8kF9gjZAWGDqXhYfboy/6k8WKX4NIj1PKOxyF7Zt9?=
 =?iso-8859-1?Q?gqhM5GBiAwBdmJ4WWTL5XXeXaSpvzqU/pG11JRR/vLLnWpSDXXxnUI1vvh?=
 =?iso-8859-1?Q?uzC1uxZKnDzZ/6YttY5AQgyywIpmY4MPRyKZAb6AjB/fZGbl79LBVOkPy+?=
 =?iso-8859-1?Q?MoV1DWXxePkMsXP30IoTJxy9tiEfznGHB0XylYIovecKTwPaf+qDRrZuZe?=
 =?iso-8859-1?Q?XMon1cm70fiz+weg1k6jC0mVrwlWU2SwB7qd94Qy0ow+e3DrT7NpEiD11N?=
 =?iso-8859-1?Q?uK1lhABcqKaD8YP/u+ms9qFHIbLoxiRjrG8SbyOh+4vqzGThKcz9Idwxp4?=
 =?iso-8859-1?Q?sATLZjuDW914jzSkmGY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272a8ab2-91db-4153-86ab-08de0e5d5ddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 15:45:30.2540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yzmQxDsxi5FKq53OD2b9bBESeRdRuNW309Ysw5+3i/jigGDbHlxOmSZtoW7TQiNkbWdiGLDjX29I+HvZBYzEfAbczMhuNhVCGjIs0WKUvTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4360
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Add MIPS P8700 ldp, lwp, sdp, swp instructions.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                        |  3 +
 target/riscv/cpu_cfg.h                    |  2 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 88 +++++++++++++++++++++++
 target/riscv/xmips.decode                 | 23 ++++++
 5 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9fda450683..c09ce9fc62 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -251,6 +251,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
+    ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1385,6 +1386,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
     MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
+    MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
=20
     { },
 };
@@ -3299,6 +3301,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipslsp =3D true,
         .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e4d5039c49..cd1cba797c 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -38,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
g __attribute__((__unus
=20
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov || cfg->ext_xmipslsp;
 }
=20
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index dd3ee7ba2b..7c624ab677 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -149,6 +149,7 @@ BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
 BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
+BOOL_FIELD(ext_xmipslsp)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index bfe9046153..9a72f3392f 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -21,6 +21,12 @@
     }                                            \
 } while (0)
=20
+#define REQUIRE_XMIPSLSP(ctx) do {               \
+    if (!ctx->cfg_ptr->ext_xmipslsp) {           \
+        return false;                            \
+    }                                            \
+} while (0)
+
 /* Conditional move by MIPS. */
 static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 {
@@ -38,6 +44,88 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
     return true;
 }
=20
+/* Load Doubleword Pair. */
+static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 =3D dest_gpr(ctx, a->rd);
+    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_y);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESQ);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+/* Load Word Pair. */
+static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv dest0 =3D dest_gpr(ctx, a->rd);
+    TCGv dest1 =3D dest_gpr(ctx, a->rs3);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_x);
+    tcg_gen_qemu_ld_tl(dest0, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rd, dest0);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_ld_tl(dest1, addr, ctx->mem_idx, MO_TESL);
+    gen_set_gpr(ctx, a->rs3, dest1);
+
+    return true;
+}
+
+/* Store Doubleword Pair. */
+static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+    REQUIRE_64_OR_128BIT(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_w);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TEUQ);
+
+    tcg_gen_addi_tl(addr, addr, 8);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TEUQ);
+
+    return true;
+}
+
+/* Store Word Pair. */
+static bool trans_swp(DisasContext *ctx, arg_swp *a)
+{
+    REQUIRE_XMIPSLSP(ctx);
+
+    TCGv src =3D get_gpr(ctx, a->rs1, EXT_NONE);
+    TCGv data0 =3D get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv data1 =3D get_gpr(ctx, a->rs3, EXT_NONE);
+    TCGv addr =3D tcg_temp_new();
+
+    tcg_gen_addi_tl(addr, src, a->imm_v);
+    tcg_gen_qemu_st_tl(data0, addr, ctx->mem_idx, MO_TESL);
+
+    tcg_gen_addi_tl(addr, addr, 4);
+    tcg_gen_qemu_st_tl(data1, addr, ctx->mem_idx, MO_TESL);
+
+    return true;
+}
+
 /* Move data from memory into cache. */
 static bool trans_pref(DisasContext *ctx, arg_pref *a)
 {
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index 4215813b32..3174f17aa4 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -8,5 +8,28 @@
 # Reference: MIPS P8700 instructions
 #            (https://mips.com/products/hardware/p8700/)
=20
+# Fields
+%rs3       27:5
+%rs2       20:5
+%rs1       15:5
+%rd        7:5
+%imm_9     20:9
+%imm_hint  7:5
+%imm_v     25:2 9:3               !function=3Dex_shift_2
+%imm_w     25:2 10:2              !function=3Dex_shift_3
+%imm_x     22:5                   !function=3Dex_shift_2
+%imm_y     23:4                   !function=3Dex_shift_3
+
+# Formats
+@r4_immv ..... .. ..... ..... ... ... .. ....... %rs2 %rs3 %imm_v %rs1
+@r4_immw ..... .. ..... ..... ... .. ... ....... %rs2 %rs3 %imm_w %rs1
+@r4_immx ..... .....  .. ..... ... ..... ....... %rs3 %imm_x %rs1 %rd
+@r4_immy ..... ....  ... ..... ... ..... ....... %rs3 %imm_y %rs1 %rd
+
+# *** RV64 MIPS Extension ***
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
 pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
+ldp         ..... .... 000 ..... 100 .....  0001011 @r4_immy
+lwp         ..... ..... 01 ..... 100 .....  0001011 @r4_immx
+sdp         ..... .. ..... ..... 101 ..  0000001011 @r4_immw
+swp         ..... .. ..... ..... 101 ...  010001011 @r4_immv
--=20
2.34.1

