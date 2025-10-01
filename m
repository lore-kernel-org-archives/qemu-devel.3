Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17CACCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 09:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3tTP-0004cZ-JD; Wed, 01 Oct 2025 05:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tSn-0004N6-3I; Wed, 01 Oct 2025 05:49:34 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tSh-0004yS-2r; Wed, 01 Oct 2025 05:49:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRNRWTYik75tD35YgWkjCs6xS40MLgO6YBloqMRmONKtYrIj5JyM0cfbgheeUViGG4htqbiJOSeEYXTS+Q4zOE6O74fx6CCWFHwW6UXAitYwK/C0iuxy6V6djKTkeRsDSRm5i1TGDA/ZPZDMd7iCw0bLluNgMUjDuVDdCx+Tnj4A7YDcnhD9Ik/hjl/bixRctldsi1kvQtREqwV62P9J+IbO4TeMtAScumgGq607Xxcjq4WBhbTKMDhMJyncp0KNmIJN9IohcqkTPzJ3ZkHKOSnzZRKbBfhoMhqRLojSO0IFL+jNvoK0aQeCEG3OKBurig3Poo1oAPje4nsJLng0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyW3Q7ZQ6oaIBLODAOp8zDllh3sILwEUmncfhjuRgAc=;
 b=GwA4frOi7xFz4u9MX2KXUZslWRJx1OwA8J7pujD/u/uxejTrSkuOuyLHhekvCVPQt45o7bbqALOw6dljf1lvVln1qNOjzmQW400ZmEU93IBXy35DICEl54qdrHcak3xA50mEM9J8ERsES11WMyOuly6sSq9PkFTghsPaJEBfWfwkAZRSae6DdaIEUmbup4g0RFIY2H1EJEm7vMIxEmzhPpk0zl8KUJnuBwl3CgiyLhgUMA1hTv9C3CAWIwAgM9uZ3CySVjKGjCcFUUgr4kT4iLxZ83nGJIBKW0+RzHB7cGMqu85jgdoy9rq8i9dSnYd2MNoTzzHHKfWL035PlqmcGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyW3Q7ZQ6oaIBLODAOp8zDllh3sILwEUmncfhjuRgAc=;
 b=dh3EdoUTjp8yUjHrYB45woaElLIUwutoPX5RimRNp/W6Z0AThz+u9qcKgTk+O6c4AacCxYiAwqHmrm32YXEPk1RLsZ67LN6qZgi6m8iU2cIJdo/AAlmIlT4miOkgM7CYgAK/mrEwcSexHOTztw7iYobFrRiNEoj66uoDlWfYZuoEqJA34ciq1j0pFwcLtYSq3Tc3hbBzRVRlG85uKqj0ku+sOVBpIYTIEzfv09fZxTiTsEnXGg8q0S5eOW6nCopcXrK1UTYsmjQ3JTB5lzXPicQiP8j2mcREnPcCLwcQBIb+93b9fqiQ3RTWNy4AHrQMld/tcwmJ0Po9kFQTNXcEQA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA1PR09MB7820.eurprd09.prod.outlook.com (2603:10a6:102:44a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 09:49:12 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 09:49:12 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>, Djordje
 Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v9 08/13] hw/misc: Add RISC-V CMGCR device implementation
Thread-Topic: [PATCH v9 08/13] hw/misc: Add RISC-V CMGCR device implementation
Thread-Index: AQHcMrikNNK3YEIRF0Wucy2X22Jmgg==
Date: Wed, 1 Oct 2025 09:49:12 +0000
Message-ID: <20251001094859.2030290-9-djordje.todorovic@htecgroup.com>
References: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA1PR09MB7820:EE_
x-ms-office365-filtering-correlation-id: 44fd0d9e-7aa4-4194-2049-08de00cfc6c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?B1ZfPzHaqvxga2wPoYij1yDt9SSth/nqW+WHlh+E25/Sf0RrYOPQzf8ut7?=
 =?iso-8859-1?Q?nTW+WyLobj/6t/2KeqjrjoBLJhgIDx9iKxJm26hKSWB2w8W5Y750CY2Qm+?=
 =?iso-8859-1?Q?Vex+jvbXYWnbRM9LlB3g/zj1eh3JlB6l6BQINtCkJRsiedmqufXU8AK8zF?=
 =?iso-8859-1?Q?p4ytJTFrRDCDujN2HZQKl3+Zy7SlAaRjvhHu/7RiqODxnyrlnrw9A3QMSh?=
 =?iso-8859-1?Q?i4D/PsDX8f15ueFlUtXeNptlrDwNPjTl4helNKcjFpCdJpdsI3GmnGttWe?=
 =?iso-8859-1?Q?Du/hs6wPiOY8/2mI4wI5MGLfDoVTU85oTzqsqdzK+cBmTAiG58g/LozYrh?=
 =?iso-8859-1?Q?HGpk67k1o4yxJqXIs3cYt4DoBKG90orElPpluYZioe98NrYBXyqAL+9zP/?=
 =?iso-8859-1?Q?CKImZh/LzD52p5pr+FUwYuPfJtAinmVzM9w8Azc03qp4+QqYlHpFD1nxXY?=
 =?iso-8859-1?Q?ALh7Yy3Oqnq7mBIVGJWnjokbZCK4sBU58ucdOQRUDveThK+GeMEBGjom62?=
 =?iso-8859-1?Q?e71hokY3jTRla+OASAxtZOleuSIqp2RllXnQwLomXPFFPpOheD/tRFqQBS?=
 =?iso-8859-1?Q?9UhUaA/5qI4zsBG/k661xNRt6qimrmShNICGUB0t6bnzEczzyz6cNmqYM7?=
 =?iso-8859-1?Q?lrKXKJ9I0Gfn9nw6uPt954JEjQ7m4GCUwQv2ebo87bnIMxfr6q76wogX9J?=
 =?iso-8859-1?Q?Uwysj3fPxsVtw1f1l+kKipvLrS8ahkJUYFtUTg6DNDlRzlpMBGSyN+gKXy?=
 =?iso-8859-1?Q?RCn6LhsNMfVjOzbqacE/V8Bn7FK03/s3/jHaQuqVN+KpfVJG9XPm6qQZbd?=
 =?iso-8859-1?Q?BHByzViF9Cg0EloUY0yAC3cAkwgab1XJ37FuqX2sQgYtGd4C5KhkxzUqmI?=
 =?iso-8859-1?Q?WSMrHNrj6qqFErHh3hVo5OJFo3zApedXIlqCBaBr4acw1jSDES5F6yX+7z?=
 =?iso-8859-1?Q?WScQ2uEL0z2aWOxc+gnM1YnyLsvucC9XdFJ6ufvajEMHfGZHxqXphJKo2l?=
 =?iso-8859-1?Q?2IMUP7eH2YqTqX2Sw2KTTe/sV0kDRQts1dmCiURYn7lEyQHYsjHNcYStSV?=
 =?iso-8859-1?Q?x/nx3TiM0fom1JYe/ByQMfIE76UAK1TjxS0qU9uF7OJUDg9jlUZAzst+Cz?=
 =?iso-8859-1?Q?wB/E3/aGo8CVvaiabXI1tDauoOi0OyRijvWQUzkUzVCFQVeMDVIJV6Vji4?=
 =?iso-8859-1?Q?uNfjfpOPClSTB8zDZQrAtCWgo58MFO3ez/b37d3ixjXdRjE8D91TGsI9NE?=
 =?iso-8859-1?Q?VfYybFBdH+nKSNwZuMKLK2JAqwQnZyD3xsS7oC7v/dK7aNyMEhAYCHoTz8?=
 =?iso-8859-1?Q?cjZX4G2QYVBfyQQP/R2l9LykfRN/ImAkv51ZrGk5sQkbcjs8HOHw8m0Xsj?=
 =?iso-8859-1?Q?hfMgqnzgmv+lelInX4byHjoPS0yf+dtY/7wE7GOnvbl8uhRep0XsHnkgLw?=
 =?iso-8859-1?Q?edS+djOfbJel5bTN6OTbTqMbCuiN/Ou83mj1XbWrN3wdddTiXTxTF5VYad?=
 =?iso-8859-1?Q?Z++SAO6hjUpGTood/eMicM3rYlUFd5KQMDb2Jp/EUtkQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?f0DvKRS60bQlPSm5JgkLbxLsox24uWxBuj2PZ3W12r5ydQ5LhbwKYl3jUG?=
 =?iso-8859-1?Q?EspN5ZDI1kZ92w7BXoXCd2DMFeXrBynhxadEuM/427/ss3F/ptetfWFWcL?=
 =?iso-8859-1?Q?jQwpzdnVXF2xYn+wCvV56UHRxvbksfRAhVNVq3kbKRC8zg2ZlOUaEydAa+?=
 =?iso-8859-1?Q?9V8e/tAQWRVX+OKGiCSchaIO5qxpo5cZp6JatA0hCkB0zxw/odvB4brEgI?=
 =?iso-8859-1?Q?3wEfbpSqC0ny/QjAgZNESmWsT6JWuHhL6S+FgOJtNTIcr8ITY57JJvPUeW?=
 =?iso-8859-1?Q?TD0l8c3jkV3mj4V2RkSPTSawJHFH99gBNQQS0/ar7BlFPzunLpLDi1WITl?=
 =?iso-8859-1?Q?o4XbPF97dr4c7NrUzs1jzP48NQGwBU7iIJ/hXDv5AK2+U44KDYFGXNIWTj?=
 =?iso-8859-1?Q?KixACt2hARlYa5XTbUZHnAE7P9F5ysNOde10Or3WcKr8ju3QjZbThWFi2e?=
 =?iso-8859-1?Q?PQrIUpQEu47/qMnF8p1aySBvhQRZ8pzyKibqDhFm/prGLkgN4qEz631GIg?=
 =?iso-8859-1?Q?Mha260dwmDxdiUyYUHmQuUpVOVD/bsqs3ov9qqyFKEscKG3yWHQPpGr49m?=
 =?iso-8859-1?Q?syxthpRVWFcSiEoAnyzBZSvwtSnVYWoj5ClwfmjGOUqhY/sDyRrzCsnG66?=
 =?iso-8859-1?Q?V/AatW61Q83/AlZDakcU0I7FBee71NSvFIqllZX/lHz0QNCs+pyUYzAoE2?=
 =?iso-8859-1?Q?KJUu0t+eMJhZGvSgH/gK5dhuE4u2Cv1xJb+EwlicSPobaK9VW9rPVYOuIZ?=
 =?iso-8859-1?Q?XlzrcX7r6C633sqhNPLO6r8T4ESQWza/8SIW08Jug0YEcWsB7Ze/DO8/N9?=
 =?iso-8859-1?Q?4AaViJxZRZBjACpYQTLzjmocjw04aMlsPD9khKgxo6RzX0fHx550tcF81x?=
 =?iso-8859-1?Q?N9waLhrGoBjSDkykRy1ezTHmMMX2CqIAtUgcA4jQfI2kXVfH7lHEZj6Ou2?=
 =?iso-8859-1?Q?ERi7h3VkUAaaMaEwki+T+8zPCT+SgVXzfGAUQmK/dTvODfClhZ6i4pbS34?=
 =?iso-8859-1?Q?TwwSZB619u3xfIDANhO1vRAQhUqbXy03cY0e7T5/ZZKQlmEpyjgO3dVEWL?=
 =?iso-8859-1?Q?F7q3jdexBE15pEUnt5wXOtUMM46lzimCxgjuNA8KHEpmBTGzYW6l0rPHvy?=
 =?iso-8859-1?Q?La3o7RQKqI7b221ajXaMYOMzACoulfU5q/Rd02DSOkvWHPExuJ20uNmJPg?=
 =?iso-8859-1?Q?oFvYbneBbAhEx6fg3djLwbmeIh6s5ZVyrkhcgdMZq9mrtlSYqXCh0jrydL?=
 =?iso-8859-1?Q?PKnJrjCoZHI9HVsP6MsMqPSrLxYq32Y+OfOSaXS9NzBKVTjVN6GXRPvRWK?=
 =?iso-8859-1?Q?h5QwIU8JlijAMqXcepQTKAFf6xJDcTHMe08zd6PjwHrsEzZIyrbpeMegHi?=
 =?iso-8859-1?Q?3gxcg/+z300Injcn/eK1Y786psqW5xdx7i8jVlGQRbL/2KAnjgTyKbCJD7?=
 =?iso-8859-1?Q?vGmk8FRBCYTlVkZumnTiXqb8Qh31Umfu0Bpo0+Obl14/6KdCuIz27VrYDt?=
 =?iso-8859-1?Q?IK4Ic2TwHnwyx3ybzsB7AwDHG8L8w1DHfF++/TNEibg5TuaRW+oeHqmvTP?=
 =?iso-8859-1?Q?s99VJ9XrpNbTmu9Px4FQ8TuRjO+QiFMUPjov6MvkvyS0mApiyKzzp3NMAk?=
 =?iso-8859-1?Q?yGULaxSnGq55vGetXRbxbZWGmMWy72Ld26gYfkLlTKbBVyJaigw0+akkYB?=
 =?iso-8859-1?Q?06R3c5Qy0N0Q+fRi6os=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44fd0d9e-7aa4-4194-2049-08de00cfc6c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 09:49:12.3867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ap+tTZZOYHHPs6D+fAzaHB2kTFNj1VYFUR2C6BCrjWc6vvVWCuMojZkgCNRy0e7fIa2kXkJwcO4G2UcYaPLmM0rbcWX38k8zRNZymhgipJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR09MB7820
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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
 hw/misc/riscv_cmgcr.c         | 248 ++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_cmgcr.h |  50 +++++++
 4 files changed, 309 insertions(+)
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 include/hw/misc/riscv_cmgcr.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 4e35657468..222efb12fb 100644
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
index 0000000000..8e7b86867a
--- /dev/null
+++ b/hw/misc/riscv_cmgcr.c
@@ -0,0 +1,248 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
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
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/misc/riscv_cmgcr.h"
+#include "hw/qdev-properties.h"
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
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
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
index 0000000000..c57d4ada1c
--- /dev/null
+++ b/include/hw/misc/riscv_cmgcr.h
@@ -0,0 +1,50 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
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
+#include "hw/sysbus.h"
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

