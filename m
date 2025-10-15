Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C719CCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91EE-0003Ip-C9; Wed, 15 Oct 2025 09:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91E8-0003B1-7c; Wed, 15 Oct 2025 09:07:37 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v91E1-0000nK-Of; Wed, 15 Oct 2025 09:07:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfod+S6HqHI913MwJbnon3pMiU0uz4nFhiMXdwXdiT2GCu9e/zAAqILAL0bMLwFj+M5rMVP2ITdAOg4Ynwg5ZyzrdpA+AfYxixLwfraBmsNj4NhtB9Xqv/itA8as9aBrVTZebWDFPpiDkSpgV2+n81n3ARNH5vbwz2wWlBhHQdbiFR9hiXJheL4wxlG02XKqeoU8p70DHgGWRo68+FjKu8cqycN26P2QJ0k3P3k3zEefYWJd/5O3ONaC/yXAKOYYzFXxkosstGt2O4WtzWKb1rl2HkcoHe/4CsvtBcyhDHWg1ofOWDYBwEmjm40OrObSu4QyXQWlqV+/VLaSZndObg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2braOq5ecbz3Vm8ktPLzy3hIhWI8JevJoJP4vfqqmZ0=;
 b=kR2OdzuqEl+oJituQGMnxLSgM1Bjl9JWSSB0CKRBeV5hWcaiSiuNaq/mZf4Alu4iK2aAEUiaelDfUNjNeGAYaGeNoWw7t8+HXnSBzg4earuXtdflRORhqJK1eXkkY0rumhoPUSA5L/8URPK9/8I62uvzRdK1jvicWf1zviGeY6b9jSx+g/f6SbPNN9BtZcsCcI6cf+zW2dC0ZmKuJiYadgt9evIR3Z04+6coBJVC9dvV4KkDDB90ZYAoblJbfW5Ws8mlPHfmej362O/608SweyL4pNkliVYAgjCk9Dq97Do6cxYO9gD+N5TCpFLnnmpCQ+dVhb7me78956ckA2R7Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2braOq5ecbz3Vm8ktPLzy3hIhWI8JevJoJP4vfqqmZ0=;
 b=khUOQL49ldknT5dv0ysN/ISUtWM/m30/05Q9y3UAcjIwbwOhLLyBIGgD9rNoOkCcZAEpybSqIAk571yetisht2SAYSFyZBFqo9PpImDRg7u/w7x2nQKQqooir8YVbKN4MzflhHUVNW57CaWQcARRHr9hpb/w0v0hdbq1Ipp+Fz9ChZfJ/TImTaDB9so+zhxo7j52/tYUiZhJx0+N3JK9NfWRlN/adO8a3d/QgIpfAxqlNJXbYRhfVxr3ZNx6Bt2EupU6b++k/lCyS9p4we5EGzXPSmxaPi8ugTNu4yy2aO2IU/PnpJTMDfvYiJanilrjDGawZW5w5cu81aDhfgJ9Yg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB9PR09MB6057.eurprd09.prod.outlook.com (2603:10a6:10:3da::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 13:07:05 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 13:07:05 +0000
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
Subject: [PATCH v12 05/13] target/riscv: Add mips.ccmov instruction
Thread-Topic: [PATCH v12 05/13] target/riscv: Add mips.ccmov instruction
Thread-Index: AQHcPdSaQafPSW5SH0WR1xc9aijrwQ==
Date: Wed, 15 Oct 2025 13:07:05 +0000
Message-ID: <20251015130657.571756-6-djordje.todorovic@htecgroup.com>
References: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB9PR09MB6057:EE_
x-ms-office365-filtering-correlation-id: a3c829e9-53ef-444e-b433-08de0bebbd49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021|13003099007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?GNvXtc8cFZHq8tty64R0YhZuQ7kpoEHlVOV3rSIz5AMnF6PkuIWsSiS05H?=
 =?iso-8859-1?Q?9h0aDynvt8lHAGKr0uIFM0APtVYWid7lsPkg76KyX49V4LyagC0CuXgy1j?=
 =?iso-8859-1?Q?84wHm1OlVUUFc/EzDT8q0RkXKQ69L+OKVpIkD6ASOYmBV6K2gyM3Y1/FYC?=
 =?iso-8859-1?Q?01Kvgw5BP/m7a99KM1MPUg6yEbj6VYm5ty2m8AbdvHdlXZQ8+Inx7q+kXh?=
 =?iso-8859-1?Q?sb9dbrC9jkR+SmE5m3aL0Pgewk+y/fi7VUNY/ho9Xl92yQDErl6/nCPliu?=
 =?iso-8859-1?Q?ecy/Jv4BFMUg0Y2IwOXTtCztZ1xacgWlj+zyFa8M0lKsWY3kD+SfDMBzCL?=
 =?iso-8859-1?Q?ma4SjHw2YvAdOQl2FBLAPUnnyhr+L528munwU8X5buD7ca/Aml8hwh/O4V?=
 =?iso-8859-1?Q?jKZz0MzuxJqmR7JVULjDrKrJ8wm22lGQQC8Bn98wZTY2DEhwZ2zLTH2ZKl?=
 =?iso-8859-1?Q?pFZgEK28TwyNLyZG8mC75leVUXfl0niM32Azy53v6WnNAOJRpyPuxT/wdb?=
 =?iso-8859-1?Q?2aLFTUTyIPi0v9QNNzHk3qpQqIvBqE78ewahZyYsvx/ilemfu6U7t0eWcD?=
 =?iso-8859-1?Q?SsHGys1A42m8MqmahKbMgdexdsvE2BGe8zwCTMRKieJfiBaASvLuNEbsBQ?=
 =?iso-8859-1?Q?hwCdgiC8G53Xaj8ttMKtVk+3PeyFgu6k4+p8qiKddRIcqdiy7WyQjRfiXO?=
 =?iso-8859-1?Q?UTFogxW6/QV3MVM4FuK/Z+peBjA1FcPRyRrCkD20GKepgjcKWUDqre0G+G?=
 =?iso-8859-1?Q?4qRRlyhEHUAEFU5Pk/kdxSyPB6TcD/myhurICzF0WTVaNHwumK2RRBz8AN?=
 =?iso-8859-1?Q?ECHx9qbkOIUXAygznbpNLOWX6TbpGJtF59EGbI9EvTMV+XYDZECv1oqClr?=
 =?iso-8859-1?Q?v440kT8DwQ/spAla7OOnCrKFCpEYHJnCS//1TetfVdMmd6rg6AHg8RhsKa?=
 =?iso-8859-1?Q?peqEcHJLogasAwTEQd0o/qpRf22hTBauzW7Xv+2S1E+vD7Yk0sWf1sIFXb?=
 =?iso-8859-1?Q?D636q7o8UaEU0wVApZ6VAENrpDDvGJkN5agpzTt1QEmrReFutQlbILTxz6?=
 =?iso-8859-1?Q?va8+gLMjGNaI9VSB8iJl4tNB6q0q4XNH91TBUKnh74maCJckGFxRNEFuk9?=
 =?iso-8859-1?Q?7yNHewkpOfqXOSOG0g9bCna4/m1l+kSUb4HjhyJLq+ckMmIvNfNxX2nFGt?=
 =?iso-8859-1?Q?LjHKY18nuFc3k1CiRo1okLTcqjceGzGYhtsHCDNldsJIBCDhx96n3OnY7G?=
 =?iso-8859-1?Q?f00USSFxfvllu7fa4WSM6qLanHdrDQWaGrjlpXplpvX080IiuyCidTTnFg?=
 =?iso-8859-1?Q?5duCyf0f3zp2fp2VbSWKQHQOEuxXjLzDrC2C0XglJT+dYTxRupHUxnQcrf?=
 =?iso-8859-1?Q?CXEiwvULkrsonECFQGksOp0c2Q/mjFevomwnjWFCZBhGFeqwMichsVpi7O?=
 =?iso-8859-1?Q?FZ6HZf+7xxjN6Nv5+ZJ4Mwb+asdR2HwxmdVCGkXIijBxu756F7YHyzFaHx?=
 =?iso-8859-1?Q?l1PX9iMVv76AZSdeXs5qdXqt/g3nkCtE0WT3ZF/vsWF0iE21Zde0olL1w7?=
 =?iso-8859-1?Q?B7Zf5OkF5yeiyjt7dueB+7kPjgkI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(13003099007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?84M00PeRPgnJ7Dpor1upn9mIae4BEyNkD2EZPvjVQFcVf4WZj4f4938R/z?=
 =?iso-8859-1?Q?9UJVer0QWOd0rsuX22vsuWq64UrRPWvMga6fbuO6l3rlA+MUGwoEsdv17h?=
 =?iso-8859-1?Q?neA/x2rWBVi2qBBenzFChEesYYjeeaHw2xZ9k96i0xCWTfy1ygNV43cXTv?=
 =?iso-8859-1?Q?jgNqPv36R4aDgX/71zuGeE1Radafcgf1gzPJg/CjPlc7hwSJEJi8wCMrRV?=
 =?iso-8859-1?Q?/8G88aiwhaa2eBboC48YO1kCJ5hGqBWoQg1amM1mzjpa/j5beu3uyumcF+?=
 =?iso-8859-1?Q?lo+RtAS5mqevhwBYLP2cpkDDivFei95WBI0l6Qw8QNt1Tz3lutOIHcmSlv?=
 =?iso-8859-1?Q?Fy8DLsXhUOcqWhBcYp7zkMcQHnaYNjzdGwdxNjq24LgK2sKZSMljDsmNc3?=
 =?iso-8859-1?Q?xTUw+oh+ujXIM32+TIDVziYP5xXBFCQiBiowP4A8aqHiFoumHJyH08ZS91?=
 =?iso-8859-1?Q?lpQHCLiZ39UOM8tnTS+RgU5C1Op30xUPQT34b17htWlpMy8KXX0Him8+/3?=
 =?iso-8859-1?Q?j5zt/OfZWfXqsl3tEtSAVlmd+PEdLbXn/nheciaP6KVtYsMk+AYqih5Ewc?=
 =?iso-8859-1?Q?zQvjvSBlV7XZnBITtIazTSJsTyVl1VYWm+jUEbH3mNWhhuv/+tnJOJDWG3?=
 =?iso-8859-1?Q?UQum5HIRpmqak56HD5Y7I/kDmy/1YBbb1fhwprZ2t0ajS2vcVPrmyRyWQP?=
 =?iso-8859-1?Q?Xh86Jfn+EfXhsH9VZaKkf371pOXq/YV6jMnh5TeYqL0UhAnTdBOb+vncgL?=
 =?iso-8859-1?Q?8DbB3GE3Lhrt7HEewZhlRU58xprS9Os6x7OBb6/l23l/NMgc1h8wV2+x9k?=
 =?iso-8859-1?Q?59WnhQQLg6lolKXjDUppqjR0Wkh/rXAIeURXpTfDRZ03FjqVrnj5zxYGAk?=
 =?iso-8859-1?Q?Xxswnz0Pp+UAxDD5NWs1zk7H6YHg0c4HCYMRiQ0m2NIjSxrFagBDFNetpy?=
 =?iso-8859-1?Q?Dub8l5szYHY11jynFskrnM/0xgOBU7c7qn5EPrfKkz6X3K7dv0Podwmpht?=
 =?iso-8859-1?Q?sBfj/q8pw4CWwHZ7y6ol48jmwHoDEYALDxtJPOJbKsE/Fv8n/mE6pUhK1B?=
 =?iso-8859-1?Q?eQlRFSHZMkHJI392IXK2CMa7cd8dQXcemtxfHT+EtnnH3GEkPdtiCsJ/wO?=
 =?iso-8859-1?Q?zCO7vljcTtq5YB5BvtJ1ZK7fW4Ojda2M8XZRO1wVLWv6AwHmbKMA6CX6cr?=
 =?iso-8859-1?Q?LGtzrNy6YU3zjKJT+hHUrWBnw0EdVHJDwioS+WVa7cwknh25rMiEMl+NpT?=
 =?iso-8859-1?Q?OZTRW/bC2fjBG27xzcfuspPUBaUH6T6N3v8fgygNkn+Htf7YE0UoAYwwax?=
 =?iso-8859-1?Q?/W8S3qkqMcpCih22+PRf4GBrAkgyT43pdtvNmibUQDk5Hr25Yvqq0il2u4?=
 =?iso-8859-1?Q?FR+LI5hayP/dWb9DWWRkXkNeE3r5bl/q6f2oAA5qtfqxmUin29Q2APKvbQ?=
 =?iso-8859-1?Q?zN1DXHW4srv+KJwsWXqKnyjuZt1UKBb0fxqvb6CXCDOBQaFDsuIRYwhSsE?=
 =?iso-8859-1?Q?f6guz3dqG+gf19TAa2hU5ma6/r9D8MfC7HpXJDlk+jY5guPlTo41bqx+37?=
 =?iso-8859-1?Q?vHsKIwv83RY+2na4fldGH8HQkbO2+KiAQzG04a9KDYeCIFFxkKaqeE32KC?=
 =?iso-8859-1?Q?MsIZdnyxwKPhtbmdzQo59mOk8LnBDp+O9uZ8ie2E11t85i/LS1CnSaxdmS?=
 =?iso-8859-1?Q?XAwfqRMhHWXuNUAlUiQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c829e9-53ef-444e-b433-08de0bebbd49
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 13:07:05.1165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xuEUcfXZhO0ibhVo9EHX896EaDM5ByNYPSP354q/3sPqLJRIpu9g9jeoIMlpej1BKGvzHbXcYVn4XxHf+t8xF0/5dRX9a54LryywGicO+TU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6057
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                        |  3 +++
 target/riscv/cpu_cfg.h                    |  5 ++++
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 33 +++++++++++++++++++++++
 target/riscv/meson.build                  |  1 +
 target/riscv/translate.c                  |  3 +++
 target/riscv/xmips.decode                 | 11 ++++++++
 7 files changed, 57 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/xmips.decode

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2fd0ced25f..87cb367676 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -249,6 +249,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1381,6 +1382,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
 };
@@ -3295,6 +3297,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
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
index 0000000000..3202fd9cc0
--- /dev/null
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -0,0 +1,33 @@
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
+/* Conditional move by MIPS. */
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
index 25d59ef9f9..3842c7c1a8 100644
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

