Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49513CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 08:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS9go-0001L8-0V; Wed, 27 May 2026 04:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wS9ga-0001I9-Dq; Wed, 27 May 2026 04:32:21 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wS9gY-0003yk-Bu; Wed, 27 May 2026 04:32:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9UkZJTzXS2PL3UuHdqSpL+eMd5T1sG8fMq1k/Mm+Nak9+ijryzqneSnuhV0njovYsOS3SQSVtD5iNZc4rYUJfE4c5lq6z7SEN8c4KkcBY028rFx99WwmnLGLcclAXWI2GZ7Yq0ELOZjse72obbVnjL556hsawxh2BL6yJ2kD93voSTZwgBOp+7wF3li6ssHnWUi+M/DSjmMZqXNdk695aSQ43XNa0Be2hz8LKYFY/jzMZTrl/1keF8bPpYGPY6Prpva7XIBzkTKSEC2nII3hM7CSS1EntI/rklSZRVdZVRcHxtSlU0nR7UNVVN6Azv2+DziI0csmB51zXMx4eGb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iab/GHClLrVUHit5Y1KCvDiHkLhhDLZsg9JRpaKD9hk=;
 b=MUnTj5BpnXpHqeW231BDubbGnzTPgpkhZi55fWNVbU2YJYrt0vkHmcR0gKnZz+TC2lKMDUPoysyKUqJACXO5lvX71Vc72ypnIqjKRCOrT1wWSUqnEntZb0NwNiN4SGKEqtm7/HMj22nHyHkD7GKj487jGmpYMgv2KaywTOEBzvCnJHSH4iHK1RPh2m9EsZnoRVymNZNjU5FQ5OQtdCFr0g2SbpYL0kk87biCkd225KB0oC1MnheFal0jQS/J0kleeFh5Uq5rKkdxmAj1QYST5StOwmee8xszYYeR63W6WjEpEJTkq8sqnl0BKfyOlEsu6UGmTzlxPhEaSQl15YN+PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iab/GHClLrVUHit5Y1KCvDiHkLhhDLZsg9JRpaKD9hk=;
 b=nN1hzCEs9fORb5MUBfSQXQomvPwyY0WYdElMxA2Su7iqcy2IUaOZHpErN4NRFoXtkqzw48WL5bm3d2ezD+g08GtX9Z2buLvQLTtLPAha5s8ZfMfVhON2UpxVjtIBK5KQ8MNTyk3FQ9G9/7OQLDj5DpU6wow46ds99IOLTAq97r5ZKCXkZ5G5top7VH674sSW511BjT0AMzQsSRSMVN4L0rfk693+L8IoLrDB78cc30FwJygxu5STMc0UQIq7kNvLUGH074pxUaXC8+t3UmPWxyhKHcXwNhamkucJkUgT4O96a4Xc/F8kT55e6ILvCmc1zkD+Kk2wakq/syQPmSd+XA==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by AS8PR09MB6314.eurprd09.prod.outlook.com (2603:10a6:20b:57d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 08:31:59 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 08:31:59 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v10 2/7] target/riscv: Add big-endian CPU configuration field
 and reset logic
Thread-Topic: [PATCH v10 2/7] target/riscv: Add big-endian CPU configuration
 field and reset logic
Thread-Index: AQHc7bNJcTshiM0caEWOVDP4lfXhBw==
Date: Wed, 27 May 2026 08:31:59 +0000
Message-ID: <20260527083151.17876-3-djordje.todorovic@htecgroup.com>
References: <20260527083151.17876-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260527083151.17876-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|AS8PR09MB6314:EE_
x-ms-office365-filtering-correlation-id: 41c406c9-41a8-4670-7059-08debbca6b8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|6133799003|3023799007|11063799006|56012099006;
x-microsoft-antispam-message-info: xUXUL7DvHTne98CNMy4QMKg3LqT0LoiLIe9cuJExIys79as8HDBcoUd+DSZdrQD2+u7Bn0IptlTfMZ+t2qdsWLTaK4E1uN7QBohklyIwUpmbI34iLAwxRb4EpAKTw+qhaQIMvZ9puzZThNXKPbhO2C3y95q4K5A6Sk1nDAnCuJKVQTbTHfmzKyFxntjSKQvUjEBwVH93oG0mma93XChjEqXgIPbbXoUTaTxJVHold6aGaQdPvrVwOBpwb3R9TanwuojRtdeU8i8wq9ctiXCO/UTk36zCADZDUKr3gnA2lXEsta7Hffy/AoUAIbCtT6Sv+5hPeCJKmBzSz8KS6HCZT8gwv9/iLYkRBaIcYT0dnaUwdfNi9gCQ3+Bn1XWEziChYMN87kBxRKrICXN7oW+FaEBRutsiu9TBd6MdBURTsBrIUu4HoXF4Rc8BiNk9YJSO1bqnZMFBWOPnQ+kWnL8+F73BDubWSUafZMpxGh7PUsB/t0KCWYT1uWCgZbFFiJmaHiO7prpBEXRMNfo21HrI6OqgxTOVFFdShxQFRWp+qOMBeWsV+s/cs2ihHJwtPZxeiatiwDIepkzZnKRStBtGBebcU4uW0oxGvw7ZrO/lpdP3ljKUEmvvWbzx9aZOVGQL0a4X+JWvfoBX0coLFDhuJBAFEsDzDL/VC0JaLyxzZj2WC2Wk2fGP4nMnt/zSO2tOeATsnwhBc0h1vGe5z7fIHDEy8JpDkiO7C2TvR9pGnk8BAJiEV03arEzRSrAhdbcZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(6133799003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ey8fvan4KR5INQU1Z6YaxJF017XyFsEzk1AmckUQ8K7PDAKFroMGjYyuvM?=
 =?iso-8859-1?Q?bc9gAK7wlorAjNGOiKkyqZp/CwGj3Og1UGZlNXY9OewVD8M8E7DCzTvJCv?=
 =?iso-8859-1?Q?+N23CNda6W3WQpK8oOSCMEmsYrfsJm20bNpGFlPs7Ut3IOD22fE0Lj3QJA?=
 =?iso-8859-1?Q?0s89ZshS1D99Po0QrwbrGDaqsEAe3gmWzN31p/ElSV6utBnKCoH2hh7mh7?=
 =?iso-8859-1?Q?bVqy2u3id1x2hNfjwXm5OD0dYPv7RXoErjzUYltjJtmVP25GpRypUJiE7k?=
 =?iso-8859-1?Q?+9Jn73Yy0VjEe3kxSdWMB1sgOvTwIZMbuHj8F0I3gp0WyI65C5TU9lBED1?=
 =?iso-8859-1?Q?3aXjWeKb3sqrYUWXFxPgsS+Wx4bTBlJZ2EnxUU68h3DKPn/uSyM4RIXqkr?=
 =?iso-8859-1?Q?dcMj7z/C6R57botgYYOGNTlAAQ/rCKVIdrZWLt5JUBMvxQj//+fd40ag56?=
 =?iso-8859-1?Q?7iLvoC5PfU/VZE53uuvLr1aLzhOk6zQbYdlrpc2H+rig5hZkRQ6BvKOJSA?=
 =?iso-8859-1?Q?mexheubRHgOk9ni/y+GVacIwfsbdzLkCHoxL38jjkMy4HQwoGqQEi6I537?=
 =?iso-8859-1?Q?THbgsFndejInA56Q+WyLnHIH9S72nmlKaGpLRb5t3rma+yL3k5qefI/hHy?=
 =?iso-8859-1?Q?bSkGzKFucgJv288eUU1NcMp5p9tOq2enT8h8bEwuNdQfbDShkz/4U2LQXl?=
 =?iso-8859-1?Q?TWYVqqRajpdE4iUWWkWPXevUzn/Nrfth3ZdUhzMJMauOWyxpKRbSdhvfci?=
 =?iso-8859-1?Q?7WXnBqXFJjvdrG39QF3I3ZlX0dnztQ9ZUcPJiFLPyvFXgOeUQ79KgBRcxl?=
 =?iso-8859-1?Q?GTDr2YpO1jgTg2U0PJ1hMO4OGgH/JATPcK+WFOhjLbf9PRN9vv1G683srX?=
 =?iso-8859-1?Q?YTK2juUmkD5NyKL4DlmnDb9PDS9LaTG2LDrVzxwof8Rw6lB0dxnKQEqzC7?=
 =?iso-8859-1?Q?ZNWYPbz8T2P7xN14QkhBsWwy8xGx2INYErzKvVz6/ocU4o0ep1eAI1yYpd?=
 =?iso-8859-1?Q?2x4Fx68eoA1TzgeJPiRNJdkQ2SUMS9JL5K4z+6o8F5CCEz0jur1pgmNhAF?=
 =?iso-8859-1?Q?yA+ldWnxFG/hchjsHSU2C/z8+aznNMKMYXahDI34Y5tMX9ECy2qRZvWM09?=
 =?iso-8859-1?Q?N9Ot+08eQEPOqoj9aJI0UVclJ67gT25vCRo9Avz71ta6oMnGufDYSFmcBC?=
 =?iso-8859-1?Q?/M9ez8E7CAlXVmsI+2lYA2GPfvublaERDOg2i/Kn0d8gFx1asMluvMcdXS?=
 =?iso-8859-1?Q?a9cp2WLwuskveRVx4fid/vT0qxQnuUSjTtX+FEUjjwW5TePgocTUKhSN7V?=
 =?iso-8859-1?Q?ZJxQtRVKJluVsVGH29tcj8CwPBRd2JOr52o7zbVmUcIWAGQCz2Y9nnbxAw?=
 =?iso-8859-1?Q?Aap8SsVFXNePWSq4eLs7MgbZYa5qsV6NFr5HGjvD3t12dwH0ZM3ClDxM9V?=
 =?iso-8859-1?Q?4a+t4RVCzwl+jRHZA7/lCBIw3mGe/qqtggqlPh4woI9LJfqVTKMBDHbMin?=
 =?iso-8859-1?Q?ZzHM6ZFHZOPEf6jyzj7cyxsyBoi/JAx8Kj0hyXGTzErUNC7T1ggmVibHVD?=
 =?iso-8859-1?Q?4K4Ri4B6Y72mFG9dtCcCuHEaMPOjG5TMQkixIAsYw6FXYGLVZ65gkpZrNK?=
 =?iso-8859-1?Q?jQcXAgpx39ZulHueZU/BrfCrpMKzx6lqc8ldqukMWJnNp+101orEKjwIMg?=
 =?iso-8859-1?Q?tX/xnwNhsmu/I8NhTphClk6uG6m2LY0blx+RFpePwlzeV/JsCvMzTDcLBp?=
 =?iso-8859-1?Q?dYO60JWyD19gFLq56tF608kI3fPFmQUpWmSgS+ZsLDSrgvxASqnv5N2Msc?=
 =?iso-8859-1?Q?srngzLTH6tKHGB4fa0CRmMS0vUi4h4/L98lG1Hn0Pe/Qd3cACUqi?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c406c9-41a8-4670-7059-08debbca6b8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 08:31:59.4256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ne1vnSDOFi3JP2iNgJh669mMZ+hFLE6hNdaAZq8XoHhp0P+fiAmsHiRAf4BioLAHbUbP7M4RWcHyjHEQqyEVGtEcra7YNdMxLMcokrl5ynk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB6314
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a big_endian field to RISCVCPUConfig and wire it into the CPU
reset path. When cfg.big_endian is set, riscv_cpu_reset_hold()
writes 1 into the MSTATUS MBE/SBE/UBE fields using set_field();
otherwise it writes 0. This makes the reset value deterministic on
both cold and warm reset.

This models fixed-endian harts, not mixed-endian implementations where
the guest can toggle MBE/SBE/UBE at runtime. The MBE/SBE/UBE bits are
not included in the writable mask of any mstatus/mstatush/sstatus CSR
write path (unchanged by this series), so the value chosen at reset is
effectively hardwired per section 3.1.6.5 of the RISC-V Privileged
Specification.

The user-facing property and documentation are added in a later patch,
once the full endianness support is in place.

Also update the disassembler comment to clarify that BFD_ENDIAN_LITTLE
is correct because RISC-V instructions are always little-endian per the
ISA specification.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu.c                | 14 +++++++++-----
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ce15a17c37..42d1b3662c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -720,6 +720,13 @@ static void riscv_cpu_reset_hold(Object *obj, ResetTyp=
e type)
             env->mstatus =3D set_field(env->mstatus, MSTATUS_MDT, 1);
         }
     }
+    /*
+     * Model fixed-endian harts: MBE/SBE/UBE are initialized from the
+     * CPU configuration and are intentionally not writable via status CSR=
s.
+     */
+    env->mstatus =3D set_field(env->mstatus, MSTATUS_MBE, cpu->cfg.big_end=
ian);
+    env->mstatus =3D set_field(env->mstatus, MSTATUS_SBE, cpu->cfg.big_end=
ian);
+    env->mstatus =3D set_field(env->mstatus, MSTATUS_UBE, cpu->cfg.big_end=
ian);
     env->mcause =3D 0;
     env->miclaim =3D MIP_SGEIP;
     env->pc =3D env->resetvec;
@@ -807,11 +814,8 @@ static void riscv_cpu_disas_set_info(const CPUState *s=
, disassemble_info *info)
     info->target_info =3D &cpu->cfg;
=20
     /*
-     * A couple of bits in MSTATUS set the endianness:
-     *  - MSTATUS_UBE (User-mode),
-     *  - MSTATUS_SBE (Supervisor-mode),
-     *  - MSTATUS_MBE (Machine-mode)
-     * but we don't implement that yet.
+     * RISC-V instructions are always little-endian, regardless of the
+     * data endianness configured via MSTATUS UBE/SBE/MBE bits.
      */
     info->endian =3D BFD_ENDIAN_LITTLE;
=20
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index 734fa079f2..9eb47af0a7 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -157,6 +157,7 @@ BOOL_FIELD(ext_xmipscmov)
 BOOL_FIELD(ext_xmipslsp)
 BOOL_FIELD(ext_xlrbr)
=20
+BOOL_FIELD(big_endian)
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
 BOOL_FIELD(debug)
--=20
2.34.1

