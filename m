Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CF2D185F8
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdqH2-0002b0-NI; Thu, 08 Jan 2026 08:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vdqGy-0002Za-S1; Thu, 08 Jan 2026 08:41:56 -0500
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vdqGw-0005qf-LN; Thu, 08 Jan 2026 08:41:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZpGgEGnZJC+8pjnGzCUPvBuFwxc9bKR6gNLOLi3BsBW0flac3ZpgUo59LHOpoq0ai8iRuGpejQjyEp8pPsblaM72csH+Z8Qeq/h2BERweSO+GeHYHlbvQsdyEFmuJY00LeBlX3H6GsOt3m9ZSg46xo/ImC4XGekZmtX70Ojf1JjdbVDC5qn90UHrK7COAvwTMOmIjEkH3d6YvmSTltQw1k01l838ckxzG2kwsqztP50aMaOfTjBuZzSeu9ktgIlExwW6HmcJIvoJ3TvYQUpMZjGabYgR+UzmMv4oVtpKD+nAaY9ejyN1J0VZvXAnyBbp4UOiiXyCMjY/TF04P6hKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DS+RijtbLR7zlvn1u1UMQJmdCspKkZ7qLbSkV72LxOA=;
 b=hbbFjUglK+58uq9K9Fb5OXCj4wtUL7OC/kPh1XS3WYZ1BnlaIZl9eB5KFYm05tNOFD8deJP2npncN2pqww92U4HpnA1qFL8fDEDVa0PYc4KRPBT4TDIte2Ajy9JPKDaH+Q69R7eSaGEl9EUkXXdHv1sebN/ieUsTIJvXg0ew2MtG/Mwr0uc6xiHvGU/74tVn+RTzMrrCzHZAnCFmvHm/kfr1cXaBSch19JsGCRPsn6u+OJg5kr1Cu0Y6ETbQlsHzOZAkpFyLDlGWCcagwbVEZQwPfyBZkG2CTTTl5/AQsXZV8dE+HlsKu8YkTGROSlR4tJ74DZ03SB88gQZJoC9IyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DS+RijtbLR7zlvn1u1UMQJmdCspKkZ7qLbSkV72LxOA=;
 b=IKAS6TmTCE/L3KSycf5G1KNNavP4FKPBxvXEIiXnEt9dPqLK8gZTVQK1lRO9GLVghKJSoU0ykrvuEUjmi+c3e8dHsTzFpqfjYegvonX2LU+WMeASfG1n6TkX7C5Bn/5IXHAKureI5k/bP1atgGdmE5IrmuKkZ3i29gcFQ228ip1lQ9Ac6giQL3mjIzTOA7RKkXl7XToOatwTanAkM16N2wp1BWY46d9vQUGJvqBXke5yqraLELT7N8R+J/3SME7+RC1N2gENsvSErZrV0R7iETtZ4eDyMVGG0vqN6w8MLiZ8lsPG393uPzhfxayKCpGk2jXM9T0EClZrJsGsh49RqA==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by AM8PR09MB5226.eurprd09.prod.outlook.com (2603:10a6:20b:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:41:38 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%6]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 13:41:38 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v16 07/12] hw/misc: Add RISC-V CMGCR device implementation
Thread-Topic: [PATCH v16 07/12] hw/misc: Add RISC-V CMGCR device implementation
Thread-Index: AQHcgKSDE8Xh0wlrjEqzf8hW9ssSNg==
Date: Thu, 8 Jan 2026 13:41:38 +0000
Message-ID: <20260108134128.2218102-8-djordje.todorovic@htecgroup.com>
References: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB2796:EE_|AM8PR09MB5226:EE_
x-ms-office365-filtering-correlation-id: 68308911-e52c-4031-66e7-08de4ebba643
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?GO9SWN+EnssgQWLvfbTog0D9SBiOpuN3TBVw7uKBEsWpslqh3nEblRlR0x?=
 =?iso-8859-1?Q?ibkC9q4vPA8jmNj5qHI0Oaa+2Uyixq97TyACjpuLkJGvkPI+EXZbzy/W+c?=
 =?iso-8859-1?Q?kZ8QsuTVH6hz7EaTy7iduaELawr3KyG0yl5o2+CmMppAp/mqb0m1cNkHMZ?=
 =?iso-8859-1?Q?1Rj1DrB9iK3cmjkEuqL3kMFkSD3gdyKidF74Wl2HV9i9AiPFW3XV9XqcOu?=
 =?iso-8859-1?Q?G8aIK0WLsNkghh+9EH2hn+enyUmbJFj1O5dwzThIcMMWWZAgGxIHWGjuT2?=
 =?iso-8859-1?Q?pXVPm4QxXkQ9N1M71f5+4fgJUHHBDm7FgBNbK8rQgV6F50fdJpuGhO5hT6?=
 =?iso-8859-1?Q?tXK74Csm3rCZAVxK/Wu6sLSPjq5sJ4Mtn4sIwCyZwo1FV/WLrSJrbDzESL?=
 =?iso-8859-1?Q?v3gLUSubfxM9/e2LE5lWcWkouV+AHg/BVyCrk1cDloDykVZrDTU3PEZGF2?=
 =?iso-8859-1?Q?rISCXwCCoJrw8JAoe+JQkXqe5qjKd4Vam8xdSFbGRURiY3nbnjOr1z+H1Q?=
 =?iso-8859-1?Q?BtB9rMzfGHaxK2r25JftURQ2TTQ1W/oPdO6wc8LkURlZpFajbvPAGw0v/d?=
 =?iso-8859-1?Q?Mr/1zmc//OJP52U8W0UPyjBXeuihVnyCQjT9esgbP9Pjd4S50ihvWwBwmZ?=
 =?iso-8859-1?Q?wWazJ1t0GKM5L0xhFXlYQEfUnEFgrjVZD1Lfgkw2dm/0v3OXUcx/+nWWHb?=
 =?iso-8859-1?Q?XCxcdLXI4kDqqTxjDQxnpjwjLRTsFGB6E01I/fma1FKbICnKUPAbPexFB+?=
 =?iso-8859-1?Q?qjXWQxds3S5p6C4qALeCn1PuQFuPMwxtJ8Xl4E6gAgt1hg/ynFf5tqS5+p?=
 =?iso-8859-1?Q?jGCZeC6vY3B24a7jUe3ASeeT38zniuxDLmVZR0Z/LElMJg+SjeNydFjLy8?=
 =?iso-8859-1?Q?Wz1F+mshTzCIUcUTSAQoEcqdRx8E/MtZGvEY3tl61d0ML/pNAKGBqs52eh?=
 =?iso-8859-1?Q?y5my4Sgr8nXknMYlSJyE50ao5dtAQbNMJfRZrjQOYg7Jm5dGCI4ZIdY4Ao?=
 =?iso-8859-1?Q?HV72jwU4IcVJTQgpwDYQj6AQ64+5sdZSZ6XR3+vZ4UooVxcZXIZbwAqp1i?=
 =?iso-8859-1?Q?JNWHHJzWEG4hyoWLjSLrp63Yv2NklQ5NbQtcmmHnwAiM9bRAPELw+iYKTF?=
 =?iso-8859-1?Q?fNwYTFCZ1kO9F6oCtZerZVN1R4ec7zHc0mZnCcWXRQ70xw2/29vHIczJYr?=
 =?iso-8859-1?Q?JFggvDpIFW8ewv6udNbO9YjyYVolN43KUkVs9I0Wed5Sduhda5kPiPkOyj?=
 =?iso-8859-1?Q?IAHqIgP421pir4qvOYmz7HKQ3srlzkx9TtC/lQ5YjmzpEfEspQA4V5KKMe?=
 =?iso-8859-1?Q?lTfTt8KnNmG/5/dKCUZH9MjBJsnGTFuD5PCWMErUiC5aEbae7mVEmbCYLJ?=
 =?iso-8859-1?Q?0YUogTVdbC0l4QOIIiTY6+ib7sJv5bPWWd5VLt5itVDhewsNmib0iRwsGH?=
 =?iso-8859-1?Q?3+TZZTykvTAIcSM+DAYu+SiIDhIRIBO4zkgr/FRWuQoDzrFeGwn7f7jhnx?=
 =?iso-8859-1?Q?G4Ux+TyfzNUYYv/TJh437VXaXGGDulNfE3VRPHkXt5YVYqeSpWlJ0a9yVy?=
 =?iso-8859-1?Q?NqbvOMtxizXD7SE6tX9fz0LXAm2n?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EaqJMjn23pEo20jHLg2F19XBYiSo9DwK0U/QhsOndhWoEgC00YW7FqySs/?=
 =?iso-8859-1?Q?izyasOspPi8FbDrQ0HCFdG3JMhxYN6o+AeArCtwzxrggOB32HcDoSVNn3S?=
 =?iso-8859-1?Q?v9KztisuS7bprevHkK6FqDGeJQ08W8aCuyp05P5UT4u5uoI307TKs6IaNj?=
 =?iso-8859-1?Q?TxuwQMu4zpBZbu8tZtLP5APJOY2M7Cb2Zvezp+t3UKSeS/3JvLCNHHFMd5?=
 =?iso-8859-1?Q?CKMOqFkngJNVst0A7qR+49jcL0FDbX+6GohG/xhCAfOFLtdSicOdsR8nWW?=
 =?iso-8859-1?Q?yBlA7jeLipmT2hT7F3QGLS7kQnCR3Ktep2D5AHLJEy2ER4OusYJ3w+HpZ3?=
 =?iso-8859-1?Q?LuxL4d551+Xi4ef7eUF0Dt2RDppesU7d6d2lISPiSZLnePiFKgZMLr87NB?=
 =?iso-8859-1?Q?6/YmaDYu7qT/8K+D/hXqXFjrN3nDL15t/TW4rAi6cndyQLiMKQAsvoKtdP?=
 =?iso-8859-1?Q?dk4Rnr1w2qoON9wblA4LsUPEmBKRnpTzFbdqlGKbBXBqxRgraiDC5hSTVF?=
 =?iso-8859-1?Q?ufBWwsUa6AW9dA7MsOrhauolGF8aajNKB+AxijlOKNZp6VOd/t4yPV8c5/?=
 =?iso-8859-1?Q?RPLROpfVxK1M9dU+1CUKjwwujxj1O/1mZDVl75twYpIHJTboC8FeLQ8PIl?=
 =?iso-8859-1?Q?9Dodla1QconaTwOIk6k20Bfmm5ZKgiDrUemXWXo3J4wJQYYuj3CdhwIAJw?=
 =?iso-8859-1?Q?qK41MFONCLHPtOtchz5xsbb2yyR3zaglldUwTXd1akoIuBzOIqR75acxbK?=
 =?iso-8859-1?Q?lvl2LQ/xz5duchOF5gmEgPWeWeWh2KpAjrDINX3yJHrimNWRIi9Har3ZaR?=
 =?iso-8859-1?Q?WQytfV4SncxXnfG/w3AQQO2/mBC+EZNnATnQNMyREkQ4PlVTKIW6cwwAIo?=
 =?iso-8859-1?Q?QMIWl/uTzoR79/TmOqXpWOFuh4bdBO/Z/sljV/ZIg5/ZpAB/+P3xGeBakn?=
 =?iso-8859-1?Q?d3LVN7d1XR3HX1fbslfaulD7cK/iQ8sBUbeXlKJ/0k9iSeaLjRy3zncv+5?=
 =?iso-8859-1?Q?kWP4/2WzhAxtJxqYESGUpmRKKSpRQCfHY0MdQ4jL7T18vpZy28yozm4BAM?=
 =?iso-8859-1?Q?L9dTR85cL4HhWUQElKzWGn2nu5bTcJBSXR5QeTNGVRxVNE7vVasayLUpux?=
 =?iso-8859-1?Q?wTfuT24ZOBT77A5xtYB6YUw7oWeJfrhOgzUYijEIvinNRO73BO2LJsX/cZ?=
 =?iso-8859-1?Q?7CSRbdJdi9xoh2byp7z7lY48lQ3lDebLZqOCSXpOZd//ADOjcrxQ9jKRvu?=
 =?iso-8859-1?Q?S4QHKAgqJvLjldBoWIpJdB7SVi3FTjO5O+MGepGgqxz8O2H6/2nOH8RVUl?=
 =?iso-8859-1?Q?xkc8SPNipMKyZ0luw7RiaBWjnD7+ro/7Vih3ITwyWOOXPWNu+zKl/qNz4G?=
 =?iso-8859-1?Q?DkK7mUaM2iNzUsifGhDALguRRNkeqd9N7GbkXZjg+GcAA7BLCbzJNzCJoH?=
 =?iso-8859-1?Q?V5q5bxCmoQ+X0o+7QUnWWHs6P87VdQ83SBdqulNnqCk/tId5V31Gp7krIG?=
 =?iso-8859-1?Q?yBbwuBKlLIlVrnFMRnUPrSnMmiG4S5SzPmnWmrBgZ7VD3P/uTJMLLWEeft?=
 =?iso-8859-1?Q?6Mi5phim7/1plRdH9axOPdnvg59EZi9bhMxEnW/7n++VkL3Byih14cHvx/?=
 =?iso-8859-1?Q?kzYthL29SfDJ9I3ugmvdl5r+cBA9GUWBeIEc+urWQq7B1CcH+sUjdtZS20?=
 =?iso-8859-1?Q?JJfe7K8l08+b7caZ2O+Y1+xzsSuqRpdClXU8N9RX3vyGCpkBF//boa5lTh?=
 =?iso-8859-1?Q?biZLDQmqiSVmKDj+QvFcV/AqV3FULdnoFonRz0HEeU5Kxj29HMFYgNDp2K?=
 =?iso-8859-1?Q?nUf7R23Gfkw6K5cCR+ZUwgplqfAgThQcybkJJ4iXbNegc7MtF+lX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68308911-e52c-4031-66e7-08de4ebba643
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 13:41:38.4732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mWYqilBrA2m5VIS8ZFI0KhB/J5/udpwBsXCFIGiiBclvdcDqLNFvbjmODFcc8fnYHEmnsUqEJLjL6moaqxj5hk+KUp82OIZvAhg+61vlwXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR09MB5226
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
 hw/misc/riscv_cmgcr.c         | 243 ++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_cmgcr.h |  48 +++++++
 4 files changed, 302 insertions(+)
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 include/hw/misc/riscv_cmgcr.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index fccd735c24..404500979c 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -121,6 +121,15 @@ config MIPS_ITU
     bool
     depends on TCG
=20
+config RISCV_MIPS_CMGCR
+    bool
+
+config MIPS_BOSTON_AIA
+    bool
+    default y
+    depends on RISCV64
+    select RISCV_MIPS_CMGCR
+
 config MPS2_FPGAIO
     bool
     select LED
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b1d8d8e5d2..489f0f3319 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -157,6 +157,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files(=
'mac_via.c'))
 specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'm=
ips_cpc.c'))
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
=20
+specific_ss.add(when: 'CONFIG_RISCV_MIPS_CMGCR', if_true: files('riscv_cmg=
cr.c'))
+
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
=20
 # HPPA devices
diff --git a/hw/misc/riscv_cmgcr.c b/hw/misc/riscv_cmgcr.c
new file mode 100644
index 0000000000..b0294e7663
--- /dev/null
+++ b/hw/misc/riscv_cmgcr.c
@@ -0,0 +1,243 @@
+/*
+ * Coherent Manager Global Control Register
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * Copyright (C) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Reference: MIPS P8700 documentation
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "hw/core/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/misc/riscv_cmgcr.h"
+#include "hw/core/qdev-properties.h"
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
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
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
index 0000000000..1878d98fc6
--- /dev/null
+++ b/include/hw/misc/riscv_cmgcr.h
@@ -0,0 +1,48 @@
+/*
+ * Coherent Manager Global Control Register
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
+#include "hw/core/sysbus.h"
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

