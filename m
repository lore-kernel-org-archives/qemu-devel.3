Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF55C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHWL-0003RW-8q; Thu, 03 Jul 2025 06:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uXHVr-0002sq-6j; Thu, 03 Jul 2025 06:49:57 -0400
Received: from mail-westeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c201::5] helo=AS8PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uXHVo-000791-JT; Thu, 03 Jul 2025 06:49:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LORd9ZaeRQ2qyLaq0k7MhQuWpCO9BfTnW53WW33oX/cT9fMB3n7HcbvGUdYGlPvJon/UegELdwIVvgLPNSXRNqIMYh7yO+w6cK3w22xNM2++Ri2E3WlUTfMVWcpfxX+SXty9kMTq730RXs9A95+2TrskIvJTL1uLgHrzU1qY/SENOiqqZYtpPXaNYgc8dXuhqgb2kI3t+vmQ2D8E+HkNkeMZElttcmmbsXHsTsrQiv6RNMXV7QKpED3EwPihb9XPsFRxvsQ4+i13PpPcgDgEXaPzwxjOf4+tq8MhopyLkVSzQSPhff42r3IU8NbaPpjHz0Ohr+H7qO6FkpJcEnx/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtuR6zo0b9wGMcwlP1CvWNgQfDmJjE5qC4lblMy+0+8=;
 b=cKHIm3POw9u7onB1kQIpLD2k1uXZ2reD4EHhyZt4QcbyQvbFKI1VVhQzMwVLRUASDKalXBnYlQB41W6R7vaQ5YLU922DueQRl2ZOEjydPjrAFjxKa1KsoiYEH9axMaS0/dQi4q7uttL/DIMo+Po90zBI4eLgbcaHjcWHKyACaRTo4WyCDVxpTxnoL6fICYXm2Lm7rrSfzms+EdPO0cgpIpVs5bZ8vWmw+KBp8RJAAJ7eGKRt3rcEXPumlpBHrFDs1O61FBj+FxQGaqDrKeg3pl0Kh5TIwrr3zFtRr/jnolE3UMhiTzwL7FDBDSn/nyUma8flnlOpzEbF+9b4SkSnmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtuR6zo0b9wGMcwlP1CvWNgQfDmJjE5qC4lblMy+0+8=;
 b=aOjkgivsQOxDWYst/XsjSSWlaelRySiKf0VoZLTnsfqA5pl9tSpj16HBKTZbuQpNHtFrn3MX2WMkk2ECZPu2KZn0wDnHmW/Dpg0qtxwHI6zG0Ysxyd/38SJBFMCo+kOISBXgqmw8VnvzPd6rLAL7R//eg5xZkGoYLzSTNWet14TCXcupa81tT8vkCxBSxBGw9bfmwTX224XEdzTVbfh1aXWd6bUxt4VQOZemaG4qTRkBHFmkCjgD4YGRTKyvgAN9lYtVmYYsNK2Q+bULANKz8orJERtnTVpKdSgsKuVi8c4LM8T2sQcFBS2YrdPhsiSSxfXDB1a6tRIF9qZYBXQP6w==
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
Subject: [PATCH v5 07/11] target/riscv: Add Xmipslsp instructions
Thread-Topic: [PATCH v5 07/11] target/riscv: Add Xmipslsp instructions
Thread-Index: AQHb7Agp5Cs9/ei7VUG8T0/nHGfsmA==
Date: Thu, 3 Jul 2025 10:49:33 +0000
Message-ID: <20250703104925.112688-8-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 26f11a99-ee25-4e8c-a5b9-08ddba1f4df7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?80CgoQRY7P7iMP6tGqpCM6arnqknl9Z2vdqflCas/u78DkHH2FVRLpotmR?=
 =?iso-8859-1?Q?ciJxmCbcpwuOCg8BeuQDGNv8N2ONYw6CZHAubc/dLsmqZFrjjd2HTuYSyI?=
 =?iso-8859-1?Q?DFlcrMj/GdRCGPaRZMTDZ0s3x57jhQhZbXwjXXZayhWeVn+PC30gvtrbem?=
 =?iso-8859-1?Q?NPWU2UkdIStZOQoknTO/8bR0MLYI/mQBmNSPdshjxtwkHg+SrJOKtFjBFF?=
 =?iso-8859-1?Q?G3LExISAcaRIJWuNMSWpSy0sWERtOaSfvrQt4olj8s7xUoyeeWT8AIsB1B?=
 =?iso-8859-1?Q?PHmoveicuiGR9U6yWstjVHSZI59lrLLmHzK1KDW0xDg2crwuxxsmLgXo67?=
 =?iso-8859-1?Q?/MS5bZEsGiZOhK9I6CD5UmS18EXN4kdac81X2jBU/4ixOWhrF2kLWF1ich?=
 =?iso-8859-1?Q?rcecy/2zTJxmAJ6+Yhes+FTJc7sIbsJB3Cb79IAUEWfgCA9MJoyTUjezuY?=
 =?iso-8859-1?Q?lzGz02rpuE3y1O6+NLa5fb/ru/gGQZDyhFQ3jQw5Sj3a9pOteVEf8HTU58?=
 =?iso-8859-1?Q?cW7Oc1JNTUTVz9Z70kf3gFWYnVvcRwV/TFTy+XY0gYZaEubMJz7q1yCk7H?=
 =?iso-8859-1?Q?7nNqkSns7f1ftgpGiqEd8DBlepRMxR7jee9CemFrNTyuuof5lq9qqC9wSA?=
 =?iso-8859-1?Q?Welivft16Xjx6cFAVEc2vJaDWqsS2mZbkdSWDGmZmmm58acKs94/nSlsAp?=
 =?iso-8859-1?Q?Rb6J4wFLRFe5OcSxzbY2LhKV15i762TvuuCu44hSkz4sfhqtzhW7aE1HdY?=
 =?iso-8859-1?Q?l7akCw23pWlpk1xUPBPE7cD7f6HHYx1u+Ayr9PIvIVrPN+j7Q5QvKeWR1h?=
 =?iso-8859-1?Q?qu2YgWPh9xqGlALMLc2A+gjCKTf2yK3w7CFtPLylrGuEZmkAt6FmtZoZLG?=
 =?iso-8859-1?Q?zHfwP9lHFcaEfqLNDCUSvY3nH3PYgdyKbVM/7g88/6C91KQ2z23dEXwgCJ?=
 =?iso-8859-1?Q?5Vg+VZ1nk+Rq/eEmQHamzeUmroQQyFJksGoW7WHCHeYIX5+bQEXZNuw8kP?=
 =?iso-8859-1?Q?fGJYump4NvVT4W+tav07whlQjeiB4lSxOKUXbEl8hZoKXVwhhevYTwhnUG?=
 =?iso-8859-1?Q?ebKVsfqCw6kS9aVXmveSYVLgJiPLhme2s0cSWLWRvdaWPkVM9onzE3qTwh?=
 =?iso-8859-1?Q?4dCtP0l5M43u9fyI2+lw2v/ikmgD/Fk4Y5vLfBKX8AzhQLY5iYUr0vXgMO?=
 =?iso-8859-1?Q?n3GupmUq9N7VVLZ5rFBcodCVkM/0p/0dBQjkoi5FBuwb1Ttskz8q2Xfh7U?=
 =?iso-8859-1?Q?Xu5SFnPtMcMS9nzae2zoe1JB5UL5IdmUtRAP4vvWkzsW149jgO61QTv07Z?=
 =?iso-8859-1?Q?QIh1pjjJemTeJ0m1dnq6E7yXsucH3Y1CFoQELbKsEE0vQn39vb53Oqqs6x?=
 =?iso-8859-1?Q?E1QpcZUD8qSCmrwb05QxQ0xYmCPghc1y4nEhLxVLs1eDtVpmYqQvUAh+0u?=
 =?iso-8859-1?Q?YUtOYkJvdNUgHAjoU/RaRm2l9z5gg5qMfP4ydM1CNEGs1KnnT+Xe+ywUuN?=
 =?iso-8859-1?Q?o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vi5g54hMGAkpTLrakRITHBOp+TEhctEoACxnJBbO9Iisq/65f5ABnesvA4?=
 =?iso-8859-1?Q?xIGl0Hi1OpqGkt8h1g+CGWjxrNbAw+3o/flJhaAdS2SbNy51pIj8mxQtSg?=
 =?iso-8859-1?Q?OiM3Syf597LZIjICT8MIpePlf/oLPDqK0AuRpgB8RoFdJaM4f3Sy6d4X+K?=
 =?iso-8859-1?Q?/HzA/t/26YB7UEcmDv6Aak+4sZGs8gRtmxhc4Af3FGCYHJIObhmk0TuTsr?=
 =?iso-8859-1?Q?MtsJtA7iaOXhmJZuc9SaNkZaTTxl0M4+lAxqDBG3qQjN9jdOQSEtTX+InM?=
 =?iso-8859-1?Q?YVMaIkbES24Vtxe1ckVw0Rer0CZjaUz9UK+XqwRNxAZt6R+XX4eTr+SPhI?=
 =?iso-8859-1?Q?VBfsgoH1bbgDnTadtU7F0W0pXuWVoGYAFvrjb+qlOQpRKoPjrXd7yhfwjI?=
 =?iso-8859-1?Q?LdJrrarNOPLdiyr7HLmKl54gq/yQDb/96llgah05VWIOlHrGAT4DF7z11w?=
 =?iso-8859-1?Q?BoZGpfj/3mRPbnZeE2XGEA0wOAgnJPU27M9tm1+jaYrHiNQUeKWbspZXXm?=
 =?iso-8859-1?Q?9y+7r7vz0swBqRlfF5K5YUS0FxNeaByN27+GBsfzLBM7dYpNG+c2CYyI+R?=
 =?iso-8859-1?Q?7uV2qLuiqiARTO85bEm4Qi1rmpPeG633Mm5yhp7yrjvc/ZkzxUR6aBAKhy?=
 =?iso-8859-1?Q?IQ0aqQ1TXQNlTsF9QkbtPSzilLw8Ry6qCkp2DGjHuh1VoeP2anB6FA1AIm?=
 =?iso-8859-1?Q?QXtKj72xDIKUboXIHooKyHm8BAdEuBiR7iJ2g5mU0O9+7zcgUxADbHgZf/?=
 =?iso-8859-1?Q?N8DPJweysaDIfzI/E6CzyYiwBluFf/8NrLOO2MmpolfXLLup6S9DP8M+VJ?=
 =?iso-8859-1?Q?D8s4hfTvafp+Mwk6ZvTqsSZh9YyLiQzm6+KWAoUrL+CIVHLq1RHxc518MP?=
 =?iso-8859-1?Q?XUZbYpQWD05PouM+ioXYIAa4tNxtKZNSCZB+YxOI8NY1f9wfHWg5+9vbE6?=
 =?iso-8859-1?Q?m6VbNG7KrfoJwIZW2kA0WABx0ovI8+xqeI4APIhO6Bl7v5+tbm9l1t73UI?=
 =?iso-8859-1?Q?zK83kzEUf1mfi2UCxBxhzhN0VcMoQLnAnlRuZ4HzTXm+S32BGHVrLahrOr?=
 =?iso-8859-1?Q?wch3vZFzQ4JFuxux3AJjg3tO+qzUXNsBfokc+vrq5JUutnhB+3LrQIjXe1?=
 =?iso-8859-1?Q?WvkhCtEAx+H6xXDSCHL+oYTJJdf52tgtjmYSFUADG5ZgSH0zY7Pb7sReQW?=
 =?iso-8859-1?Q?CLhlRXGvAAVfWC6zWKXwWpnlp/0/2i1CdHRTtzEbtDNbaWgOScowY/DGhf?=
 =?iso-8859-1?Q?4JZI5fAi0OvwafglDO7lDbOJx+pjV6K2WGy0bhCnJwuYHT3AdgSE7Fouc9?=
 =?iso-8859-1?Q?gFr9Q+8Zz38ddQ4BdTHEiua202HkNO+WEA2v47t1skH6eKD2pGs7KPr4kT?=
 =?iso-8859-1?Q?YSGh08E2mPudyGed4ugZWGq5+KWaRsnHQOBeQsrLTA98jukgYH0TjsYhzo?=
 =?iso-8859-1?Q?ua4SbMJMt1tQzkS0LA+HtJJBYgvDgQFcq6B75oGLqnkUb/bp0yKibkQDTY?=
 =?iso-8859-1?Q?TF/YQ9sgGGzRP7Vt29AKdFe/14r/1MhJo+ryDkJ5rJ8UEMMzKn5Npmte/d?=
 =?iso-8859-1?Q?iOveGTn70PBVl885WSm0j8E8AF5uvJI/6e7oZNTrSuUMSJ5FJ186sfThuA?=
 =?iso-8859-1?Q?yXosaVm5pCTOxIb0GJcOZqMonPQIMka9Fm5IWYsv0RuGSpbDvfKdPDoYsL?=
 =?iso-8859-1?Q?tPsQNAWaWEoG/erOJfc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f11a99-ee25-4e8c-a5b9-08ddba1f4df7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 10:49:33.3026 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SANkj688Nh3is+8x1knqVTaZRu1VLnLeT6Iqo3M+2EqCHPlo+kEO4pldR/7Dkb5jSbpyT2JLLgfPt6fy/JIfHYg/Jojs/mbI37T7nlw8QK4=
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

Add MIPS P8700 ldp, lwp, sdp, swp instructions.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c                        |  3 +
 target/riscv/cpu_cfg.h                    |  3 +-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 84 +++++++++++++++++++++++
 target/riscv/xmips.decode                 | 23 +++++++
 5 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d280648b55..fcaee6628e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -245,6 +245,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
+    ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1377,6 +1378,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
     MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
+    MULTI_EXT_CFG_BOOL("xmipslsp", ext_xmipslsp, false),
=20
     { },
 };
@@ -3195,6 +3197,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipslsp =3D true,
         .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 9734963035..cd1cba797c 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -22,7 +22,6 @@
 #define RISCV_CPU_CFG_H
=20
 struct RISCVCPUConfig {
-
 #define BOOL_FIELD(x) bool x;
 #define TYPED_FIELD(type, x, default) type x;
 #include "cpu_cfg_fields.h.inc"
@@ -39,7 +38,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
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
index 9ee0a099bb..b5195959b2 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
 BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
+BOOL_FIELD(ext_xmipslsp)
=20
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index 6555a6062a..d2720a6770 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -31,6 +31,12 @@
     }                                            \
 } while (0)
=20
+#define REQUIRE_XMIPSLSP(ctx) do {               \
+    if (!ctx->cfg_ptr->ext_xmipslsp) {           \
+        return false;                            \
+    }                                            \
+} while (0)
+
 static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 {
     REQUIRE_XMIPSCMOV(ctx);
@@ -47,6 +53,84 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
     return true;
 }
=20
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
 static bool trans_pref(DisasContext *ctx, arg_pref *a)
 {
     REQUIRE_XMIPSCBOP(ctx);
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index 697bf26c26..99c98d4084 100644
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

