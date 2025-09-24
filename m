Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10347CAC5B3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LeT-0003j1-WB; Wed, 24 Sep 2025 05:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1LeF-0003fd-UC; Wed, 24 Sep 2025 05:18:53 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v1Le5-00030I-Oo; Wed, 24 Sep 2025 05:18:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4M9rb9TYEY+M5sepGG0dOy0LBRn2wOzpnO7P33/oXeFaeOL2lKBccpftOANDvUzvaytBZ79bkfccf9tMJRNvSp4YiElV+ej9r0Il62pApblH/UegEJCMpDT11bLY2fbtpUiTg6fkl2VbdZT8F8mlbsql6nntPOLOBHZRxgbqrZhCf5+EfVgQUElC3KH/pJptbrMxZvwkAS6l8O+oE4k9PZ0qTvnVzZ1a4IzsZn/IaNRLJp69ZAhn+287oF3/Y5COFOZQOyu5G291ZVtE7cauYv9Q63cTPAOsYj+OrHkPK/nHSig6wGHsDTPznP/kWkmvCikBbRIFixDksZiyX+O6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLk7qeibHyM4jwJNNMnzAr4bJLPccwF/LcWhF4/N7kM=;
 b=WS+W9yff7SKqerFI5uXHMU3sJyAwPDxJnUvtqdiRspqW6qHJng4JMAhA+CoZj8IMNeBPFlgBjMun02MTqn++mD+TNWZ3wCSYPZGbLwUFoN48at+ixI1N/P/FgB5Vdjem3K18uaQzXKnt7J7GkY6dnqmzVdvQHrGq0rnNkJ52dt+ThtOB4ZfpviIic2w5RBGvq05i56UaWI1BuFtzIhnDm8sEJbfs5H5CRO6m2TwrnVJVITmhfDSTEX0heDUXRSdbhPi7vVLuIycBBCq8EPmOaVet2rvFBvMLsASi0eiYpNquLXWhIdaTTrQlrMmUCaOAPjHFCKMKrzC31rybpyvy1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLk7qeibHyM4jwJNNMnzAr4bJLPccwF/LcWhF4/N7kM=;
 b=jUFHh0YGFlEDmsZUpYcOsEKWUOGC5KephPEQxOIA7KXGsQ9nbff2bkNy6xXrj/3jLL9LaHF4miMizOjUJ3PxTHaKcdyUppXaAI3GrLBmfAu0Tifyg1tmn9GJnB79u9UrmnqDslcR0tcmE9EmKSnxF4POUVTtkXPNuSM4UYPBv46hK2eN3K1x4xrwXoQYdB9qP3wCOfg47yo9ceJ8uQCPedApa0WeqUWtvDZIFQK+ZlqVkPlLeL5UhnMAMuRJ1Mpzp+jPBwwibIbT/dduJlenTYr/VxuNSiZzAFR1qAvoS9QVwzivGrj8TPmzHmIdQHGtnAiLsVNMkmrI6b4YNINGZA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI0PR09MB7826.eurprd09.prod.outlook.com (2603:10a6:800:21b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 09:18:17 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 09:18:17 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v8 05/14] target/riscv: Add mips.ccmov instruction
Thread-Topic: [PATCH v8 05/14] target/riscv: Add mips.ccmov instruction
Thread-Index: AQHcLTQoWSpKDJHluUKn3i5ozAIurw==
Date: Wed, 24 Sep 2025 09:18:14 +0000
Message-ID: <20250924091746.1882125-6-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 92f1882e-915a-4b36-a670-08ddfb4b4c1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|13003099007|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?IJKrQ5LzlIc38TW5p1ruqo/cQytGB6eRbEkkBXlM+ev0/GdtvTQGVDBJ0D?=
 =?iso-8859-1?Q?zdn7uD4petmzt6M1nKi5Qt3cIlhBi3EEzx9ijf8gSdGvjNZrxTTnaw3ER6?=
 =?iso-8859-1?Q?LGELejo3iTGpVn6IuCwl9nPWIwGFRNAhD7DAvnkGbG12UqUXIZY4zi6bHN?=
 =?iso-8859-1?Q?BnTqcOlRNrICfZA9nFYydvcxDjhM2QeAdM5qur9j4/O5/AgFhZYq8xPizF?=
 =?iso-8859-1?Q?nmMS+xhdISftyasWAqAJExIbQXB/a3pkI2n5houPEo/r72f2+3GLRZz3h6?=
 =?iso-8859-1?Q?t6Ymkzv8aTAn5IfsjPyBZXn8AQziIE93iCFtKJqyGZkCHZarhZ4NwzKSB2?=
 =?iso-8859-1?Q?cCtrRPpMlA+J+sFBX/9L88UA6X3muOLXEwzNWDvJaJENY3ppFG98gHoSer?=
 =?iso-8859-1?Q?qpcexz0c+/Mg+HTIJtuYVaBUPLy1aFHDiQzCPmMS3stOtV2jqoA5VYmN3F?=
 =?iso-8859-1?Q?6RKa2LTV2X1BOUoeqDln7lLAutOjf1FC/IWLwpYB91NyoqhqiJw4hCNAJ8?=
 =?iso-8859-1?Q?sotVtaeycd/A/L89u6T6eAMXhgUMUwUgs0Rnrrs0mBL38yiX/VDEWGIaas?=
 =?iso-8859-1?Q?iaPjGWAL+ddf4Sl3x0RtwXkAhY2xIuSR6vMqlpuE1fESdtw5pSLDUlmdrA?=
 =?iso-8859-1?Q?P0V4AdbdrfTsK3GMK+YdODNthOBzn0DE7Q1n6dKqLKuDO8zZ+ow3HI0TEw?=
 =?iso-8859-1?Q?TxD5++SejKzLOt0BTrWODyXo+MFVojRvQI3ps6a5NO5m8enmo5Zecvz2GD?=
 =?iso-8859-1?Q?F9c4HHGgukdsmuZCkHBGBqZ2RwaxuSuOHq54AWdJjAlHVqi0Q6yYpU/Vi3?=
 =?iso-8859-1?Q?P2WLifmxF6joYMcGIgGkKqpjLSYdes6olwqWsT3/HTXK7GFm2TepYN3I48?=
 =?iso-8859-1?Q?NFtH3M41pk57RW4FGzBkkkAXrZQ5/GBa9ScBWUzgCEsl+hpUKVJTzuFwdt?=
 =?iso-8859-1?Q?mFFo2aU4r1s0bDoWakO6JEalUSA0o3OmZhhLtVuluwgKAJu14Mslir+CHm?=
 =?iso-8859-1?Q?a5q1GlCYkLI2SqkUzwr4C7Qo+mciqkEy6c2pCkIus+UM2VGmjnYbo28jao?=
 =?iso-8859-1?Q?AgI8Dabw3Y5134PcTIUHo5wcg9AI35LBpJs11ZHWIoPGCnG6H1aPK0qLfR?=
 =?iso-8859-1?Q?2yfVlUjc1zigy+S83wsop9fIDlyYQ9gMgzbwwwHB7RjbLIxoqrNkHx8syc?=
 =?iso-8859-1?Q?gUEuQez62r0GeKhFpM693Wqfq6Chc2wpEI10+tZKdvr66Yr+jLszY78Hcc?=
 =?iso-8859-1?Q?Jmdt8m2rzNsWA9fI8PhWA7xPJ1XRr2u+4I+FuTHpOsdzGzDidIDCYLJseg?=
 =?iso-8859-1?Q?OX030vfqlfCWqiJ/i5XS2TCcOIKZohCBTZ3thNpNRNGQ6swM9pg+H2wScC?=
 =?iso-8859-1?Q?O1x3CXg6YAcyRfg3SpBMSUUVQM1DiE8H7ZXrgwcQtD6xlRAIJEqQJYnjXI?=
 =?iso-8859-1?Q?C1uXfpoGJGbcD74antBL85zRTckEvj52pkUMvHj8O/mmPlyiQIfIVVV4un?=
 =?iso-8859-1?Q?I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BZZpMCkMNCCAUa23QgCHYrkFJgOLfXLjX9Frjs/s7UK0d7JlcZ+wCSccfJ?=
 =?iso-8859-1?Q?/QmWv0HgQeuVqNjvUVz1p28YWhfPDrpLVWHSxa/lUGk3pYu6cllGUQsdXL?=
 =?iso-8859-1?Q?p8Q5b0iRwz6USSXIoGVEAswLqUbyP4pipOyu7aLXfAsZeHw0WYD5svH/Ei?=
 =?iso-8859-1?Q?BYDUy5/zsGMQKUkGQDR/8CkYWzf4dM/HigFxrVQzMAtSkQNG9eWGTHupMv?=
 =?iso-8859-1?Q?Tg1wjvxyo6dLK0WVbuSQDZW1WHpP068ZMc7czEDlVdRvens7aKklXVSiTZ?=
 =?iso-8859-1?Q?idUjkbHsQfHH6OWidwaZY00GfZur3nZD2PeLF43lzME7usBTvd6D9l3uma?=
 =?iso-8859-1?Q?mC1xnA9+pGIsY+acz7coFnfEGIXaI6GZ200mtuWVdhOGkWwjjzTOZedtfM?=
 =?iso-8859-1?Q?fa8S/Z9JLw++kDJgnxNur1KSEzfFxxVpuJbsNxUs5n4km7xxiLgCpr5Avy?=
 =?iso-8859-1?Q?uYCXLpNg+cjgHTH1cgy58e+IMuCNyIasSInN9MQIFOrOY8kLaB8LcrYlb8?=
 =?iso-8859-1?Q?fTtoo4wCIfDYDKpofokum2aKZlWH5Ye6OBNoxNx3V0m5n/4mglZoxViSFd?=
 =?iso-8859-1?Q?XWmjD4rmjpK+KnowqepEPq77qCYqgpd3UJiwK6dc+8e2/T1v8W9uw5ACdI?=
 =?iso-8859-1?Q?aH9HKiIIwxWkdFkka/l+vlpBGIFhsMgAnI0SAguZIS7Yzx8lWtsh/iV4qZ?=
 =?iso-8859-1?Q?gjhh/HHLgTW4LexTOuvhNM3s6BnP5LY2j6Xp3vacbGoKMTs9AmvXqzfPFp?=
 =?iso-8859-1?Q?FbrP4G3NeVqRZLmnDhHbUt+KoK7QEMhZ5nvVeZQWeaoA7tKYX+uR1Au21s?=
 =?iso-8859-1?Q?VizHpisSkDFSfhZktmNaYmrF0lpvmCxpCIMxb9LuoR3ZlC/newaZlXyaXl?=
 =?iso-8859-1?Q?tm05Fv8iLtBUNXYZyFv63NN3kqlY2vTX+F+VAUgbr2gx6MnLuRYXjQbBnH?=
 =?iso-8859-1?Q?oqeUva7L301lv4WfPXHJGWoSv9PUR5DxukwseXED8hfS86Nv5nsIlRaJXH?=
 =?iso-8859-1?Q?We/gln+A3I07MRwKqYD23gr3obGhJ3Jual+6zEGGYJs6yfxpTsH2UsYeUf?=
 =?iso-8859-1?Q?CgPsZUZJdHceShgZxzCy5uKF0OLY4mxmi3Y27clHIBAtkjXzQC5tcl6QCC?=
 =?iso-8859-1?Q?X78RDUqitLqj2eJ0W9Zb11HZETWv1ZjJRJmMdtdfDvn0hfWc+IQPS/ZWHo?=
 =?iso-8859-1?Q?ZqL2UX9OcbnooM/vtZ7EZkA6VCaLiQuSB7kAiBLEA1BF8yPfLbQTynLC+e?=
 =?iso-8859-1?Q?AkcUpXwfpOnnSKIg0Ak5jUsi5Q9q1+fHmbK8zJohJg21jj2+JAriP6wHmK?=
 =?iso-8859-1?Q?8FqYy0JAEws8Rcm1rzMoQnu2s7DmoD8UV4hit80vd/iq8S9Q4Noconj3DT?=
 =?iso-8859-1?Q?OcDugXSnAX0HyJqCIyXPp/sjeJucjRnt3jGNYRKHuz+voo2+kei/Fi7SQV?=
 =?iso-8859-1?Q?rZS2EkmTXi6GPbor7TdOGeJhX4a1LzAglhBOb6a9DqPljp7f7/7AlGKH4v?=
 =?iso-8859-1?Q?ETSe3U2SgW+STaTrtZ7kmA/aiD9pDWIsU3yfUyTpb1y8EFUMTkMis6MPjD?=
 =?iso-8859-1?Q?JSB1P7szZeS4RnSrqSg92zj9vtsyhsehnDwns++/M2hKWbx+g+xxHFmr/p?=
 =?iso-8859-1?Q?XFBIXr9Uevl92grlAqRXNZANT7p6AnrV/tX82rlWZXF/8qKRtIicKc9YeR?=
 =?iso-8859-1?Q?Qx33+70PTQV3YjSfwWY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f1882e-915a-4b36-a670-08ddfb4b4c1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 09:18:14.9416 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hR7KJWKeVe80cHq5R3IW3LgWln1rm3p1cGowIyevQKLSAEpWiSHSGfAIGojXwsjTFLfGVfcZDPMiQ8NUSfO101bN9/uMmVIlLi/PxYCyBco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7826
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

Add mips.ccmov defined by Xmipscmov.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c                        |  3 +++
 target/riscv/cpu_cfg.h                    |  5 ++++
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 32 +++++++++++++++++++++++
 target/riscv/meson.build                  |  1 +
 target/riscv/translate.c                  |  3 +++
 target/riscv/xmips.decode                 | 11 ++++++++
 7 files changed, 56 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/xmips.decode

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1a1ea7fe9a..77fbf67776 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -247,6 +247,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1379,6 +1380,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
 };
@@ -3293,6 +3295,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
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
index e2d116f0df..a290303ee7 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
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
index 0000000000..045034ae32
--- /dev/null
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -0,0 +1,32 @@
+/*
+ * RISC-V translation routines for the MIPS extensions (xmips*).
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
index 9ddef2d6e2..66d31b67d3 100644
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
index 0000000000..fadcb78470
--- /dev/null
+++ b/target/riscv/xmips.decode
@@ -0,0 +1,11 @@
+#
+# RISC-V translation routines for the MIPS extension
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Reference: MIPS P8700 instructions
+#            (https://mips.com/products/hardware/p8700/)
+
+ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
--=20
2.34.1

