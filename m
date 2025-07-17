Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AC7C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLJu-0004WV-AM; Thu, 17 Jul 2025 05:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL54-0006fL-JW; Thu, 17 Jul 2025 05:39:10 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL52-0002PD-Ov; Thu, 17 Jul 2025 05:39:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwcLNTntV+rUxImezhV722XyZ/npQuIEY4jH9CkhCRdHAVxwyNU//AoOL/v4RfNGs37XmluiytZm04DpllQ+mjIM46+vwT4RyO/ar1Mk5hJzccrW2TIf99IK5ZEDgwGBjXgIA1XoTMJBb9E6Bvk9NSWZLmISHAFwKafGPSt0X8Bp9mS+CpehxGLbHX5tF5JR9VlPTouKESTPnv66XoGGRABMjUgFpZ91ivTFUUjvUMg7W5j5ltyVpVBMFHhC7fwXK5zt6RCxI0m9eQm9n3g6RXxVlbBhtX0MJzO6hZ2RKq7J8/H9tBxu/14ZDr/fewk8HvG5UJ/HNb+WXWJ3Q5RvVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=stP00jX1Zpg8QI0O6rGdb8ayZsAeKUy93YFimv48Nuk=;
 b=PEKTNIEZumIZLHvBTbofspa/KzP/CfaubKODwE8osRrEOTexCqSke02tp+3nP9j8v0ArK0hzMJpSb3xDZt/M2FE49Z2bjz/tT7ODHzZusvSRWV6M9ljUdaRttfVPiQow7GSQkcscCW+pAmqXlesj1XiGWsHqiO5g/UqhC6e7IoGDCJRMjUeLt3ENpK/8bzK4LBaG1FyPUuOer72OHBX0h9jbKkTGB3w4ELBFMSkpfY6QYH73AtgNcd83Sm2u/V4+euTEiG11LNcKwbjDU0lEhO0tv622Ajo8R6DZkI1r58LL4CGSx9Bd9uPdLa2kbcafJiiGQC6hgkwvj6qKsP340w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stP00jX1Zpg8QI0O6rGdb8ayZsAeKUy93YFimv48Nuk=;
 b=HLhyZIb7QqjNiZvtaFME6iS583/jSdXCZgoqfrIpxeLP837SleHu0b+zbDDRniCpv+xbmrceZ49petvVS6LXqi5uBDFnsx2PughsRqyz/QG1HPHmZS3p/ERKVPZ3B8glrD+i+kyyaNFhxULAcE6UbXOSK2kvp/sufyY8xXux16IrdXT6RXfQeocrbUREF2V7bEPG5+Y3ZETbpDcSa9F2JItV19gAJoGZLhZ9bgJjMOmBUZpIUKt+dlVCb9Rkhutvuc/ExXcaMFcRlV/QUp5T3NnoajOwpj8UQjyLSlFsZwE5HgRgvuAl2YRonCDOtI7CYzCuEBJ/wl6H6o94IC/HBA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI1PR09MB4318.eurprd09.prod.outlook.com (2603:10a6:800:155::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 09:38:43 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 17 Jul 2025
 09:38:43 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v6 01/14] hw/intc: Allow gaps in hartids for aclint and aplic
Thread-Topic: [PATCH v6 01/14] hw/intc: Allow gaps in hartids for aclint and
 aplic
Thread-Index: AQHb9v6UHa5Begn5/ESGcxg9plOYvg==
Date: Thu, 17 Jul 2025 09:38:41 +0000
Message-ID: <20250717093833.402237-2-djordje.todorovic@htecgroup.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI1PR09MB4318:EE_
x-ms-office365-filtering-correlation-id: cbcd5f4b-aab1-4f0a-4386-08ddc515b84a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?DLvbaulxrIwqRaf1JiYdd2kszLVIN3IkKUpyeoX18TUuJfCrKvCagDCyo1?=
 =?iso-8859-1?Q?jPOeNug/PvgIxNDBLFBy5epupYOD6zGTOjmwFAlM3SVfiL7rlpzKzfhpD3?=
 =?iso-8859-1?Q?w9wTtqck/d+CHZDypSJNJEAt0J7dYaf4SG6Y4tVdefBic9+7NdDhio6z8f?=
 =?iso-8859-1?Q?8e8ijYwtqcA3rDk6hunaTTEMlarM+QQ4sYrCtyy8wfDvZ4xuoWnMdtB4/3?=
 =?iso-8859-1?Q?dRQzlIWHAIZAcjBT0qPn7+0H0AlhkworX1kJySZV39D+duFr23HNpCDUhi?=
 =?iso-8859-1?Q?kd1j/26L/hnqsU4UNA6VPzQEuoMkMLyJKRcPtvrtTfHFxQUDKT7umEhfWw?=
 =?iso-8859-1?Q?zlUZvNNYVJxnJ7DP63vDJhRmZwNGdx/2z9a6OkluSDR0KDlMcveiImbLRU?=
 =?iso-8859-1?Q?GN7UeiHltxiYR/KkKdcxTFC1msuWTqp0lDs5e4QHrEhLpjY1kazLlgYh8L?=
 =?iso-8859-1?Q?kp7y9z7/Hh5EhfLuORIQdS6dG3l1b7Q6LAk6pi/WU7h14GRM3Rv1nDTuWT?=
 =?iso-8859-1?Q?GHuGhpCJqo4YnRabgHKGkHnq3yKXjWBezWEHa5hdSJL88/6mGvWM8cIgmN?=
 =?iso-8859-1?Q?7Rx2ESRbaHTIbOPKQy1Vxm7d7YFeFy/9QaJiBUoaolp+FdhmieTcYBtgnh?=
 =?iso-8859-1?Q?P74V19T4dZhu9/wIGexOLiTwMnQUNWOi0RREibnw+7ghZQcD/rVCDHZXau?=
 =?iso-8859-1?Q?lGeA+uWmuqy+P5IGp1FE8io0bxbdRYW6F4JMoSWk3Qp8Xv/1MWgd2YdgxV?=
 =?iso-8859-1?Q?QYSCn1afYCUdceVmU8tTX4GVRiHbKa2FBaCfXJa5VULywOkohaiJQIR1n/?=
 =?iso-8859-1?Q?TKwHw6eKJEGnPLgXLZcCKpQA16zyLPyWIVazWMXLmwRXKhSL54EHfxpWGf?=
 =?iso-8859-1?Q?KMJ/kcwCJHTwknJAG9GoZGYbfuLSCxzjS05NdD8+qCw0tBSYxlMTwn7Aum?=
 =?iso-8859-1?Q?XUPdZsgFcKAgNcrQL6NTjM6fzUm2kL48nGaO13SezSV6mXVuZ1oKjGArqN?=
 =?iso-8859-1?Q?uChOjuw2qvawjpJOFht7/gjbV5L/XfYGw2eiwMMm7eNIIoaGASyKY53pm7?=
 =?iso-8859-1?Q?hVWN9UYsuUo5d1wTyJY0A9qyTCegqyd0qmHnBU/I3b8nutZUoytqug+YbF?=
 =?iso-8859-1?Q?y7L5GMejSIIDlNsW4N9Xqb/hQJQCswblplQI5zvYnt+tuD9PCSlR9g4JiV?=
 =?iso-8859-1?Q?du43SajkLicgVrW18fShUf7dV8vVK0ZzkzeScN74eTURZtgNQq1W12H9wI?=
 =?iso-8859-1?Q?8tj6oWBXqbGKQRSoBi0Rv53tIQkTnuKiZCRZeEjDqOiy5noA3emfLu2dUz?=
 =?iso-8859-1?Q?BJRbIhtaz42ltFYvRY/eDFtBGhV37hN347uFfmjD8B4buVT2Q7qo1FGvv6?=
 =?iso-8859-1?Q?sGR3oO5qGsILjg9akSxdExM1f1duLHhHenVev7KcrfyoxOEdC3n34mS6f2?=
 =?iso-8859-1?Q?vT3D72/voThMcNpSwj33eWHeJlqJQ8FI3crZod0w73AseVTiPgueplJsfe?=
 =?iso-8859-1?Q?lr7RB510RfinYl1XXNcuhK6qiJf3uMqxrrViBfiom93w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Z0cBUZfBd/6tMjv1TXv/dg5PDMdQNx9QG+Dbx/wwyAUozSI7+ndkY8lDqX?=
 =?iso-8859-1?Q?13Nl33ucv3EBlcuUGX/KlJ7fuVFdZ0l4XV6pIAVX9HLVXgt421Ysb5JVfS?=
 =?iso-8859-1?Q?Gl4+9ujnkSds5uKHOqzp+n20R7XmJNhphZP0bpB2C9vQJNdfIP61N2kOSB?=
 =?iso-8859-1?Q?oNQUNyOF+fDTlux6dLy7OvqICz/cQRGfldQJwGO1xMYHLQxmJyIXfG6uOc?=
 =?iso-8859-1?Q?iJXTLq0wk5g/BJexV8SRMYsNFM1GKsnT95i4UzGQosT5V0fdW3qIL4Rh8p?=
 =?iso-8859-1?Q?3zgssrTNX4iaVDCI0o7Lp+dTCVhY5cDGYmTrr3c/Li7gxFMXKiidIn32tB?=
 =?iso-8859-1?Q?+OXR4e7MhLuwBHklt1n+lbQTqmIe/YX2Nhu5EMNxgxzD3lcd20cYLVPtX2?=
 =?iso-8859-1?Q?mkhuS9lgS/hwMuhm62LrufEuRyTOFllvvN7koCqNp+8PqSPQ/PcHpkybwD?=
 =?iso-8859-1?Q?bd2XIaVdjg/vDh8r/HPIw3orkY7N3BZl2yYoWGI6ZwGJfARQeIT95SDono?=
 =?iso-8859-1?Q?ezGX0w/2tZ4kg7h2woiWaQFUjvsp8chlSRoUfhpRIDrO30CHZHNNH8qL50?=
 =?iso-8859-1?Q?BwKufU3+vPdRSMmcWRcAUkQ6ZETDCCiYbrwzqQGdiwSE/fvqcs+FngvZCp?=
 =?iso-8859-1?Q?LhR3Lk4XbLsIBrwc2/fyOuS6x2edPse4vOIBbytqsv7di4XlERZdHvlrPR?=
 =?iso-8859-1?Q?UZDFujiqTCDKQ5R6YZQknuaUd2vCFWV5OP5ZCSvuBpjQsNnTy03wtZNSyM?=
 =?iso-8859-1?Q?bx83qwf0gTlTuMx/k/p9aPOLlIOsvO5AkL1Ih0J2cNvjS8MgrtdoyC0sNe?=
 =?iso-8859-1?Q?Qwlge77dbsr4OdsDbs2aKwmYQ9Lx6HSd1YuPz1PDPrUPmMv6nplOr30k+o?=
 =?iso-8859-1?Q?X7gxwXddsR2dBBRGwXfxOS9EWtr0lzlr0WtMtYVpEZqfyZ7FUfgQREUB7Q?=
 =?iso-8859-1?Q?b4DkkQNXqBxP9rGN0lrVL1emWR9a6dl1RNl+TCx6V/Wh7m61leO1904T5Q?=
 =?iso-8859-1?Q?iBumYxRysI2PuOTvb5i5kzmOclbg2dmXO+o+LkQqpngP0mwRahfGvYKQdo?=
 =?iso-8859-1?Q?lbMWl0oJTLkK0Y3B4dXPqCx4UNFppMYro+X0lcIW/oXrPCxUwo9fWbG6Fi?=
 =?iso-8859-1?Q?tzgXrA0/RbeizVP4fCx/LbxW1+sxkQ8lwa2QDT5EKiCRynByaXc+Jt3aJB?=
 =?iso-8859-1?Q?6AVa9xjuFRW3fE9CuO8XJErevpdgPcillo3qSiH7qGtlj7/HyZYPMPVMye?=
 =?iso-8859-1?Q?KvgkSBJ1p/hZf88cS5IjKAUTm1/LWUlQ12ujyXGlYUhw7p5ZMHnsaPsys9?=
 =?iso-8859-1?Q?3zl4S6Kv7uIMfVSUYji4PA6Ch8m3lnaxYfZrE60jem1i2oto/bMDRx9YCa?=
 =?iso-8859-1?Q?NnOlrqsv2LnqFhwmeONVP6eke8AY5VhhzvDPTGz0ehMjdrc1s1ytY2Qpdw?=
 =?iso-8859-1?Q?1+54q5xrUZLW+qLdbPkNjtHiyRDDe6r/H9E2FDf1B/P7fVbNAkjUYKubri?=
 =?iso-8859-1?Q?NCPVceHT1f7lG5J1WV5W89PGxkFXcivHUpGK62jJEJ9F8kOID5/HnyBZPF?=
 =?iso-8859-1?Q?NHMmzyV6YiNExBQiAeKcn49+XjATe9EmZyiurhzSJEWquXWf0I3o2+8hZN?=
 =?iso-8859-1?Q?8kns5bOqX9yKYim0tnfx7g9jE0saNvjhOZt4hOI/iXX2NvZkxtvE0uf966?=
 =?iso-8859-1?Q?7DaJgcvBamMCc1HlM40=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbcd5f4b-aab1-4f0a-4386-08ddc515b84a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 09:38:42.0028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FqY3UOJ3XFtEdebelqySLOajcGjZyfKG1prHBTvwlIYN7xUqwLxuWasXS8Qm6u3UhrcXBerUcWba1J6FkSH+XqxijpJ5/gDBG9KYJSfPM4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB4318
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

This is needed for riscv based CPUs by MIPS since those may have
sparse hart-ID layouts. ACLINT and APLIC still assume a dense
range, and if a hart is missing, this causes NULL derefs.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/intc/riscv_aclint.c | 21 +++++++++++++++++++--
 hw/intc/riscv_aplic.c  | 11 ++++++++---
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index b0139f03f5..22ac4133d5 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -292,7 +292,13 @@ static void riscv_aclint_mtimer_realize(DeviceState *d=
ev, Error **errp)
     s->timecmp =3D g_new0(uint64_t, s->num_harts);
     /* Claim timer interrupt bits */
     for (i =3D 0; i < s->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
+        CPUState *cpu_by_hartid =3D cpu_by_arch_id(s->hartid_base + i);
+        if (cpu_by_hartid =3D=3D NULL) {
+            qemu_log_mask(LOG_GUEST_ERROR, "aclint-mtimer: invalid hartid:=
 %u",
+                          s->hartid_base + i);
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_hartid);
         if (riscv_cpu_claim_interrupts(cpu, MIP_MTIP) < 0) {
             error_report("MTIP already claimed");
             exit(1);
@@ -481,7 +487,13 @@ static void riscv_aclint_swi_realize(DeviceState *dev,=
 Error **errp)
=20
     /* Claim software interrupt bits */
     for (i =3D 0; i < swi->num_harts; i++) {
-        RISCVCPU *cpu =3D RISCV_CPU(qemu_get_cpu(swi->hartid_base + i));
+        CPUState *cpu_by_hartid =3D cpu_by_arch_id(swi->hartid_base + i);
+        if (cpu_by_hartid =3D=3D NULL) {
+            qemu_log_mask(LOG_GUEST_ERROR, "aclint-swi: invalid hartid: %u=
",
+                          swi->hartid_base + i);
+            continue;
+        }
+        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_hartid);
         /* We don't claim mip.SSIP because it is writable by software */
         if (riscv_cpu_claim_interrupts(cpu, swi->sswi ? 0 : MIP_MSIP) < 0)=
 {
             error_report("MSIP already claimed");
@@ -545,6 +557,11 @@ DeviceState *riscv_aclint_swi_create(hwaddr addr, uint=
32_t hartid_base,
=20
     for (i =3D 0; i < num_harts; i++) {
         CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+        if (cpu =3D=3D NULL) {
+            qemu_log_mask(LOG_GUEST_ERROR, "aclint-swi: invalid hartid: %u=
",
+                          hartid_base + i);
+            continue;
+        }
         RISCVCPU *rvcpu =3D RISCV_CPU(cpu);
=20
         qdev_connect_gpio_out(dev, i,
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 8bcd9f4697..c7846753fe 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -899,9 +899,11 @@ static void riscv_aplic_realize(DeviceState *dev, Erro=
r **errp)
         if (!aplic->msimode) {
             /* Claim the CPU interrupt to be triggered by this APLIC */
             for (i =3D 0; i < aplic->num_harts; i++) {
-                RISCVCPU *cpu;
-
-                cpu =3D RISCV_CPU(cpu_by_arch_id(aplic->hartid_base + i));
+                CPUState *temp =3D cpu_by_arch_id(aplic->hartid_base + i);
+                if (temp =3D=3D NULL) {
+                    continue;
+                }
+                RISCVCPU *cpu =3D RISCV_CPU(temp);
                 if (riscv_cpu_claim_interrupts(cpu,
                     (aplic->mmode) ? MIP_MEIP : MIP_SEIP) < 0) {
                     error_report("%s already claimed",
@@ -1076,6 +1078,9 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr s=
ize,
         if (!msimode) {
             for (i =3D 0; i < num_harts; i++) {
                 CPUState *cpu =3D cpu_by_arch_id(hartid_base + i);
+                if (cpu =3D=3D NULL) {
+                    continue;
+                }
=20
                 qdev_connect_gpio_out_named(dev, NULL, i,
                                             qdev_get_gpio_in(DEVICE(cpu),
--=20
2.34.1

