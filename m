Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4943CCD193
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 15:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA980-0005E9-50; Sat, 18 Oct 2025 11:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97s-00059N-SN; Sat, 18 Oct 2025 11:45:48 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97q-0001QR-TS; Sat, 18 Oct 2025 11:45:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLciRRk4xHajc3mR63sz6Aa9o9d/ZkgkM5pkZJKdvcrsy+CFGbiWanVzBnmjemcOe8ZM+MMJBqfIpgC6W1XYKllKr9kxJErw4PvfAd1uLR2YzaYXAt5+NnUIR8XN0H3jcHK4ZZvy6iPHjfxiqMeOwkPXI6bbSENSBKvYEIeQdJLvaHlJzI6hxzch16JultxwXU/1GWIZCe2sZMfYRzWODzZU+ifcObKh896mIJQJI/rPfmuSRcGhSV86lJv14+U/SLVHATbycvqlaHoJzUa1UCGgRSGkqaRUh6e1Z/IEpsSeW1ibsDryCrdqMOrl8ghBJq9mDi7T6r6LVEj0GC52PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1uJ1nZcMszuOEYS2dgtFT0UIQ3DHUQLHvvIi5VaMoM=;
 b=pya+gDw38nrtKpaaMwzHou9CVtzLPfuZQZmPlf8XS5ri/e5lmT3DZjnkI3l1CJs3t1OcDC5acB26kJkoJrEroUrB0S1WWkpsVLNL7HcjSJ9ZaIt0A89EbLZGlnLub20Z9aXgX3LmVWu8lEyXZMPGG8vCNZOkIFRCA0MpPvqDIB309Oev3JaGsJBzNcEPy9oUWdei6oEdIFqicaie+6/PrrsgUrGWsFLRpeTTFEMbrhankYBzUr6I1HcISEW2E5gw4OX3kBxy5ezW7tuNyIYrb67vIr+anMszxvZL5WAyiLq1ciHYeWM3ZW8HzZfmLY8CgXDGXuN+2keF6uXJZZXFmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1uJ1nZcMszuOEYS2dgtFT0UIQ3DHUQLHvvIi5VaMoM=;
 b=l9HoWY4aVhJRDXga2ZDcDhCQ5uz/RaBvVtwHLArpUVWgV83T/2M0O5UeQhn/fD8YR9EwLsi9M4/Spg7V6OEhRCRo+Dt1dG9hqtHAyrga3rPJmof1kkDvYwzuVlgzWsjixrcxifUqrHsn3TCpjOUd9wFwJMzjDclZWDexmyxg8sS74h222MmJWqx50qZoZj2tZn0gq90vtK6M33mM41Dxju7elEMo9cKXnQMt2+hrUxF3Z7BxSr2EngOmNr+hH7lux9iVZ/iOJT9VBn8wVjF+b+ifMh17BH0+5tTyT8A57Jgn1fR1GFdPIj5sNgK/t9ShBWMNyUXFNld6pHbQx42w8A==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB4360.eurprd09.prod.outlook.com (2603:10a6:10:154::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sat, 18 Oct
 2025 15:45:31 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 15:45:31 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v13 10/13] hw/riscv: Add support for RISCV CPS
Thread-Topic: [PATCH v13 10/13] hw/riscv: Add support for RISCV CPS
Thread-Index: AQHcQEY87XvaD3ZYQkWjETra8q9DHQ==
Date: Sat, 18 Oct 2025 15:45:31 +0000
Message-ID: <20251018154522.745788-11-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 30433ae6-a9b0-41bb-7b29-08de0e5d5eaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?DjtQ0sZ90qCYNfjmxiuHPsyDh0BP3JXM3170TH1+6bzyJerMySKJThYjPf?=
 =?iso-8859-1?Q?aHHtR+ycfLfGpW16j/HtcybvhZexXI4ncWX29IrV/ON16hnfZCSVcDhOvt?=
 =?iso-8859-1?Q?aMRexWgrMb4Tsn1JFVWaqZSpzlh4u7m3fFPUOfRPu3mA9pA1PMyLKf71R0?=
 =?iso-8859-1?Q?NNbR0Az7LSclclwIwC9D2mIXMNtYZAA0sKMLuLfRC7UR3mBwg7azTrrQ69?=
 =?iso-8859-1?Q?X8QW3gtLICr1w40XwUvCXnnb7n72IsFtC/2PBevOGLt0dOjnDATy3cO9AU?=
 =?iso-8859-1?Q?DT/NY+Uuo4Azv3DLJUI1uH7umCclpgiZmSL3/dTIleJGVpRVdcWV0+J7gg?=
 =?iso-8859-1?Q?GJJuB+zk55FljhdYV6XvsSA++ICrVzwWNbKxe88mbD0L0fyQxB06Ej7ULS?=
 =?iso-8859-1?Q?1/oqCndvsD8pdVRzZk/aMhZMBRQ1CKdOLVAGHRfL3HWyUNDpzhWWyM7SVt?=
 =?iso-8859-1?Q?DpAqkArNHL9BHdpCz5Uv/EOBnXcF8JJxSJRMGzlbZ0sjwBB2SHsoxTLd13?=
 =?iso-8859-1?Q?WrxOWrluMGUmhFi0JemnTQ5bZQQt4HKj7X2K32XfDXo58LQNB0pg6GSqNM?=
 =?iso-8859-1?Q?lVwcDQbEZkVamdmajceNn+hkLmXYqu8L4RHLEqUs3J43E5cs89VVPYYLm4?=
 =?iso-8859-1?Q?Ts0syqvNENRIao5+otFQXKablVrzcFwPyjqQ4dAmj3yp7NTsWVPsq0Ey3p?=
 =?iso-8859-1?Q?+/qzFzuz2SxSThHXws6FhbzerTCCj4UZBr8cb3au45BHXjh9J8g2nAs/mo?=
 =?iso-8859-1?Q?CnU4NcXBSMYg+CRi24KBCR+tyH9pXgl33m6/5DWNs0v0j/UqFeDp2SOKY+?=
 =?iso-8859-1?Q?lk/Y8naPwNvPkwkodekYUXQFqXB+I+3NfL9fISCoMimcSob07m7vOQfRll?=
 =?iso-8859-1?Q?RHRLkcLZXaYa0kImdHocB6NI9cwLpIKKMW1Gg6EFyhZUfhBgRoIxJ+DIsO?=
 =?iso-8859-1?Q?ZLUTRM5bxDyV9uwXLuKSwhwqv/g6/XArkBSi185jfZH1T12VQHAp4jsrd8?=
 =?iso-8859-1?Q?Ahn+W3OBGRhEyvdAhF3zuivkemEC2bANTm2xg0jUZzkUGtPBKBpmLntZU4?=
 =?iso-8859-1?Q?cMn46ruAt1Nqq9uBrP/3J/IkuDhJespX/4eTDDcgOjnbS+8buBp1X2dqQ0?=
 =?iso-8859-1?Q?zLnC7/R8qBLoVldgaCJ62lqrLBDx3GjWJsUbgJsiu8Eq3hp1cSOxDgdDNu?=
 =?iso-8859-1?Q?28JlWOd+8RqW9Z7oTJ7ZgrkJt2umUirZqxaX3nBdXBHFUXUp86HJvM1Sj+?=
 =?iso-8859-1?Q?jNMtTk3L1qkiYp8axmoBAqrnCH4+3uSr+EdPwjQ/IkIbIpCMUl8YpDrv5R?=
 =?iso-8859-1?Q?TMn97yklwPmeFJnL8BLkdhP/VhC3FMaJqsUWobl38h+xVEDbxHh5YvGm7c?=
 =?iso-8859-1?Q?R8e8hpAAHzBXSEOBGczwrV9yzUsodLXYZYM7Q3oDuHnb5bMT2m1Bfj9aoB?=
 =?iso-8859-1?Q?16uZFgahxm36fKnytGNZjrBf7CPOGfzWXkPPsAxlwEEMSFlGzuDeBVSE4t?=
 =?iso-8859-1?Q?1xULgGXgmur/3eqEyQA6KXtHEZ2FNKuT8Y0Kf1P+xAD84H28+QYCVnMO8H?=
 =?iso-8859-1?Q?M/cW4DahbLMGxv3poQZOS5kMOrkE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1RY4JbFCwIJ7NYYFkGmcxL5ejY4rrrKkqGYsmnsBK0Q0HymiORgQMdtGwq?=
 =?iso-8859-1?Q?Qk1/LSDPDryMO7Gifk3vMSMoLmXRj5Wzi9zCVrEVReY9y2/gxHEnPmmUy4?=
 =?iso-8859-1?Q?KY6fB+fB6jNKkR9VY7sj/0ULPKGCtD+CtvEpAJ4qxmMkAu9oAc5aXSzBc3?=
 =?iso-8859-1?Q?uNyYYDMbzsax4+PbHy98wswKjZrRLKfx0hJdV96qzcovMApXDvuEH9Ff3q?=
 =?iso-8859-1?Q?C/KsiBNcT/v4o87AlT1JfSqRX2rkpliRH+srlSccAvIivz26Opkuq4n0VC?=
 =?iso-8859-1?Q?tUaCzUPvXBg3btCAWU9KeboOYDxReJQ7zHYjmzeYEkGnBXr58pXvuTFV1N?=
 =?iso-8859-1?Q?FqUqeZLH9dLUtHm967K1PRrwpcLpu+toj7COj0ybNVcYOqv2u2ckTf/vY3?=
 =?iso-8859-1?Q?TXlVmS47a4XCce5siphebJYmekI89r+PDOO7mrdcjCG0QJCh+/zslooIBH?=
 =?iso-8859-1?Q?7SIxc18mBLll2dTaba2P1WJ25mlUDUuNvlXoCOv2jgaHBQGzJaB1JleEcW?=
 =?iso-8859-1?Q?DCojs6iUzLtZu2bwVqtXzzSt0ChlCLAPuv5669ZzxiTsF8FBpv5PufNHKy?=
 =?iso-8859-1?Q?ZEo/FerdhrnoMARvG+GZ3iwHkc7hmqIAqlYZQVq7f+1+x9Xg1cZiyrFJb+?=
 =?iso-8859-1?Q?cXnwtIbB8hjlRkZbt3K9jPinl9riSYLwuR9m9NYcLKGqb41IN2mtw7DRVx?=
 =?iso-8859-1?Q?Szk3+/M8hotSHzAQ+YM1BIbKFX6bUw4bEX3f7c6nsf0CMWYHesN6knQnZg?=
 =?iso-8859-1?Q?gCyo7g985V76dlmC3SdLLJzzhalZ8h814H6FvSqtanOroo9zGqzRBBX+8P?=
 =?iso-8859-1?Q?bS0mLNpLH5Yn0/+jscuTRWOO/ACvqWsAe/ku/bcvqNugzz5rXcXydvsIkD?=
 =?iso-8859-1?Q?FUDGK3XTVWSdZicM5mHwR2Lf0P64e1/5x8zFXcGGVRnwXvhSQKssy0SaC9?=
 =?iso-8859-1?Q?ieZM3wn/4jS20sIS8n7NtpSoxkJamCrSOyZwyXr9uKtele2NPXtGo7o8rD?=
 =?iso-8859-1?Q?cPjzLg4PCKxjht/lkW0ylCNc0hdiAV8AdJJ41eqvoA9mPHRYxWC87Kkipp?=
 =?iso-8859-1?Q?cyfiRzp/wNqrNQd3v8rTXDt9tsHV1w5dkMps2ty8mJB1HyMgWYuusCGKlH?=
 =?iso-8859-1?Q?tjVXUe2R+ahJ2c6s3SoWimK6Gly73/sGtnomNTG5LFWXJlg3GtHn38/ypt?=
 =?iso-8859-1?Q?vBTcBPpdtg0hpbseoBEHNTcgiLnXd8jizoa4I3EaYBVfCLSlxI1uNDMefs?=
 =?iso-8859-1?Q?9hlh3JeUeQa59UgclPVW992NGwTdfsAoonZu6ORCus38oFmS9FGWVrYnSK?=
 =?iso-8859-1?Q?oK2lZhPGuCSdT6dzJ3lTs8E7V8U4JDoWZginiVklYEwTON10RorzqefNXs?=
 =?iso-8859-1?Q?aikqA+uKd0s7c7aZ1E8nvPhE55UiZAEJz2aIfnkCVZH1qe+S9ZHP8zrByQ?=
 =?iso-8859-1?Q?FvB+BRRmZAr+P3zRIgSk0FEKKS7GNy6oa7kOHEde3jdbun+z6ecltl2mRN?=
 =?iso-8859-1?Q?dCUFXDRG5ihjPigsdFBwAWFzrH4yU0ZsFHyd7Pv9Hsu8GTDDSLn2RI2RoP?=
 =?iso-8859-1?Q?c3oGEa8kTkdWtsnkzV4pyL6OlzPOvcLYecUynS/K0XsDzpDLyHPKO8bZjy?=
 =?iso-8859-1?Q?uesoD4OI+isZfuclLRl9jpVe+Xce/4HhtfhuNrbgpS4uN8xgdtussJY/GI?=
 =?iso-8859-1?Q?UaPOIMQPmZxZbyMO6ns=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30433ae6-a9b0-41bb-7b29-08de0e5d5eaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 15:45:31.5974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q6qVaPSr6OuvF9od3mzlWp10DdA8+6+AMZkRjlDkZdlm8P7enk67Wb+6PCPwE3Mv0yt6Pqur7mb5gZh2FKVmeKXTHCp9VPvRN6Dc9tpeFUo=
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

Add support for the Coherent Processing System for RISC-V.
This enables SMP support for RISC-V boards that require
cache-coherent multiprocessor systems.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/misc/Kconfig        |   4 +
 hw/riscv/cps.c         | 196 +++++++++++++++++++++++++++++++++++++++++
 hw/riscv/meson.build   |   2 +
 include/hw/riscv/cps.h |  66 ++++++++++++++
 4 files changed, 268 insertions(+)
 create mode 100644 hw/riscv/cps.c
 create mode 100644 include/hw/riscv/cps.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 2b308ec9b0..a2726abccc 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -127,12 +127,16 @@ config RISCV_MIPS_CMGCR
 config RISCV_MIPS_CPC
     bool
=20
+config RISCV_MIPS_CPS
+    bool
+
 config MIPS_BOSTON_AIA
     bool
     default y
     depends on RISCV64
     select RISCV_MIPS_CMGCR
     select RISCV_MIPS_CPC
+    select RISCV_MIPS_CPS
=20
 config MPS2_FPGAIO
     bool
diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
new file mode 100644
index 0000000000..8642d87fbc
--- /dev/null
+++ b/hw/riscv/cps.c
@@ -0,0 +1,196 @@
+/*
+ * Coherent Processing System emulation.
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "hw/riscv/cps.h"
+#include "hw/qdev-properties.h"
+#include "system/reset.h"
+#include "hw/intc/riscv_aclint.h"
+#include "hw/intc/riscv_aplic.h"
+#include "hw/intc/riscv_imsic.h"
+#include "hw/pci/msi.h"
+
+static void riscv_cps_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVCPSState *s =3D RISCV_CPS(obj);
+
+    /*
+     * Cover entire address space as there do not seem to be any
+     * constraints for the base address of CPC .
+     */
+    memory_region_init(&s->container, obj, "mips-cps-container", UINT64_MA=
X);
+    sysbus_init_mmio(sbd, &s->container);
+}
+
+static void main_cpu_reset(void *opaque)
+{
+    CPUState *cs =3D opaque;
+
+    cpu_reset(cs);
+}
+
+static void riscv_cps_realize(DeviceState *dev, Error **errp)
+{
+    RISCVCPSState *s =3D RISCV_CPS(dev);
+    RISCVCPU *cpu;
+    int i;
+
+    /* Validate num_vp */
+    if (s->num_vp =3D=3D 0) {
+        error_setg(errp, "num-vp must be at least 1");
+        return;
+    }
+    if (s->num_vp > MAX_HARTS) {
+        error_setg(errp, "num-vp cannot exceed %d", MAX_HARTS);
+        return;
+    }
+
+    /* Allocate CPU array */
+    s->cpus =3D g_new0(CPUState *, s->num_vp);
+
+    /* Set up cpu_index and mhartid for avaiable CPUs. */
+    int harts_in_cluster =3D s->num_hart * s->num_core;
+    int num_of_clusters =3D s->num_vp / harts_in_cluster;
+    for (i =3D 0; i < s->num_vp; i++) {
+        cpu =3D RISCV_CPU(object_new(s->cpu_type));
+
+        /* All VPs are halted on reset. Leave powering up to CPC. */
+        object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
+                                 &error_abort);
+
+        if (!qdev_realize_and_unref(DEVICE(cpu), NULL, errp)) {
+            return;
+        }
+
+        /* Store CPU in array */
+        s->cpus[i] =3D CPU(cpu);
+
+        /* Set up mhartid */
+        int cluster_id =3D i / harts_in_cluster;
+        int hart_id =3D (i % harts_in_cluster) % s->num_hart;
+        int core_id =3D (i % harts_in_cluster) / s->num_hart;
+        int mhartid =3D (cluster_id << MHARTID_CLUSTER_SHIFT) +
+                      (core_id << MHARTID_CORE_SHIFT) +
+                      (hart_id << MHARTID_HART_SHIFT);
+        cpu->env.mhartid =3D mhartid;
+        qemu_register_reset(main_cpu_reset, s->cpus[i]);
+    }
+
+    /* Cluster Power Controller */
+    object_initialize_child(OBJECT(dev), "cpc", &s->cpc, TYPE_RISCV_CPC);
+    object_property_set_uint(OBJECT(&s->cpc), "cluster-id", 0,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->cpc), "num-vp", s->num_vp,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->cpc), "num-hart", s->num_hart,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->cpc), "num-core", s->num_core,
+                            &error_abort);
+
+    /* Pass CPUs to CPC using link properties */
+    for (i =3D 0; i < s->num_vp; i++) {
+        char *propname =3D g_strdup_printf("cpu[%d]", i);
+        object_property_set_link(OBJECT(&s->cpc), propname,
+                                OBJECT(s->cpus[i]), &error_abort);
+        g_free(propname);
+    }
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpc), errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(&s->container, 0,
+                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->cpc)=
, 0));
+
+    /* Global Configuration Registers */
+    object_initialize_child(OBJECT(dev), "gcr", &s->gcr, TYPE_RISCV_GCR);
+    object_property_set_uint(OBJECT(&s->gcr), "cluster-id", 0,
+                            &error_abort);
+    object_property_set_uint(OBJECT(&s->gcr), "num-vp", s->num_vp,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->gcr), "gcr-rev", 0xa00,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->gcr), "gcr-base", s->gcr_base,
+                            &error_abort);
+    object_property_set_link(OBJECT(&s->gcr), "cpc", OBJECT(&s->cpc.mr),
+                             &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gcr), errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(&s->container, s->gcr_base,
+                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gcr)=
, 0));
+
+    for (i =3D 0; i < num_of_clusters; i++) {
+        uint64_t cm_base =3D GLOBAL_CM_BASE + (CM_SIZE * i);
+        uint32_t hartid_base =3D i << MHARTID_CLUSTER_SHIFT;
+        s->aplic =3D riscv_aplic_create(cm_base + AIA_PLIC_M_OFFSET,
+                                      AIA_PLIC_M_SIZE,
+                                      hartid_base, /* hartid_base */
+                                      MAX_HARTS, /* num_harts */
+                                      APLIC_NUM_SOURCES,
+                                      APLIC_NUM_PRIO_BITS,
+                                      false, true, NULL);
+        riscv_aplic_create(cm_base + AIA_PLIC_S_OFFSET,
+                           AIA_PLIC_S_SIZE,
+                           hartid_base, /* hartid_base */
+                           MAX_HARTS, /* num_harts */
+                           APLIC_NUM_SOURCES,
+                           APLIC_NUM_PRIO_BITS,
+                           false, false, s->aplic);
+        /* PLIC changes msi_nonbroken to ture. We revert the change. */
+        msi_nonbroken =3D false;
+        riscv_aclint_swi_create(cm_base + AIA_CLINT_OFFSET,
+                                hartid_base, MAX_HARTS, false);
+        riscv_aclint_mtimer_create(cm_base + AIA_CLINT_OFFSET +
+                                   RISCV_ACLINT_SWI_SIZE,
+                                   RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
+                                   hartid_base,
+                                   MAX_HARTS,
+                                   RISCV_ACLINT_DEFAULT_MTIMECMP,
+                                   RISCV_ACLINT_DEFAULT_MTIME,
+                                   RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, fal=
se);
+    }
+}
+
+static const Property riscv_cps_properties[] =3D {
+    DEFINE_PROP_UINT32("num-vp", RISCVCPSState, num_vp, 1),
+    DEFINE_PROP_UINT32("num-hart", RISCVCPSState, num_hart, 1),
+    DEFINE_PROP_UINT32("num-core", RISCVCPSState, num_core, 1),
+    DEFINE_PROP_UINT64("gcr-base", RISCVCPSState, gcr_base, GCR_BASE_ADDR)=
,
+    DEFINE_PROP_STRING("cpu-type", RISCVCPSState, cpu_type),
+};
+
+static void riscv_cps_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D riscv_cps_realize;
+    device_class_set_props(dc, riscv_cps_properties);
+}
+
+static const TypeInfo riscv_cps_info =3D {
+    .name =3D TYPE_RISCV_CPS,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVCPSState),
+    .instance_init =3D riscv_cps_init,
+    .class_init =3D riscv_cps_class_init,
+};
+
+static void riscv_cps_register_types(void)
+{
+    type_register_static(&riscv_cps_info);
+}
+
+type_init(riscv_cps_register_types)
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 2a8d5b136c..9023b80087 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -15,4 +15,6 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-gen=
eric.c'))
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan=
_kmh.c'))
=20
+riscv_ss.add(when: 'CONFIG_RISCV_MIPS_CPS', if_true: files('cps.c'))
+
 hw_arch +=3D {'riscv': riscv_ss}
diff --git a/include/hw/riscv/cps.h b/include/hw/riscv/cps.h
new file mode 100644
index 0000000000..00f17112c1
--- /dev/null
+++ b/include/hw/riscv/cps.h
@@ -0,0 +1,66 @@
+/*
+ * Coherent Processing System emulation.
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef RISCV_CPS_H
+#define RISCV_CPS_H
+
+#include "hw/sysbus.h"
+#include "hw/misc/riscv_cmgcr.h"
+#include "hw/misc/riscv_cpc.h"
+#include "target/riscv/cpu.h"
+#include "qom/object.h"
+
+#define TYPE_RISCV_CPS "riscv-cps"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVCPSState, RISCV_CPS)
+
+/* The model supports up to 64 harts. */
+#define MAX_HARTS 64
+
+/* The global CM base for the boston-aia model. */
+#define GLOBAL_CM_BASE 0x16100000
+/* The CM block is 512 KiB. */
+#define CM_SIZE (1 << 19)
+
+/*
+ * The mhartid bits has cluster at bit 16, core at bit 4, and hart at
+ * bit 0.
+ */
+
+#define MHARTID_CLUSTER_SHIFT 16
+#define MHARTID_CORE_SHIFT 4
+#define MHARTID_HART_SHIFT 0
+
+#define APLIC_NUM_SOURCES 0x35 /* Arbitray maximum number of interrupts. *=
/
+#define APLIC_NUM_PRIO_BITS 3
+#define AIA_PLIC_M_OFFSET 0x40000
+#define AIA_PLIC_M_SIZE 0x8000
+#define AIA_PLIC_S_OFFSET 0x60000
+#define AIA_PLIC_S_SIZE 0x8000
+#define AIA_CLINT_OFFSET 0x50000
+
+typedef struct RISCVCPSState {
+    SysBusDevice parent_obj;
+
+    uint32_t num_vp;
+    uint32_t num_hart;
+    uint32_t num_core;
+    uint64_t gcr_base;
+    char *cpu_type;
+
+    MemoryRegion container;
+    RISCVGCRState gcr;
+    RISCVCPCState cpc;
+
+    DeviceState *aplic;
+    CPUState **cpus;
+} RISCVCPSState;
+
+#endif
--=20
2.34.1

