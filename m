Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2EACA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 07:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwxo7-0002Bw-2d; Fri, 12 Sep 2025 03:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uwxo2-0002BQ-T1; Fri, 12 Sep 2025 03:02:50 -0400
Received: from mail-dm6nam12on20625.outbound.protection.outlook.com
 ([2a01:111:f403:2417::625]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uwxo0-00058E-BM; Fri, 12 Sep 2025 03:02:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRuArVILtj9ItgeYzpyqz3UgG9XCBwL7bSK7m7JTDP7GKxY5QsDpGDv0R4iLGjYRPgI9VfrHq0abAyAnMiIWAgZAQiu7cwIS6b+0LzA85cCDa/djaJQFQceGyn3gFyJHTnH6EUVO2QtFdGgCcpjRpxmlkpNuwsq85FwurBqjLtN0MJD7dv5Pnrny6KyE3MSkWotO/CzbPQmpWdXPaHpgOdgeQic2QUEJ0cSwHcxAt6XUbtHondbkYzIfgdVfEKuNS6CAVnerePoeMijruX7NOysHbXpj3TANa+Rgf7dHhduxUw1+d1Jm6YGOSDT/hZ8ZT65yWGX0fJJJuCe4NgAUVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCXZU9e44H5BTdIejBMDoFHy7Dvoep10JIIACPAt2Ak=;
 b=nxzdt9JMkgN5xlYgX8ERhlowvxnnWzKqzq8+NWSPLMzeABlsvAMDrndrgsUiXlp//a7kPvnBzon6KP5OtVAdl75JFyfqSwyibv2AhXhvkXBkEeXbdmR2PGJTl9tJWdaiToy4+Iti5dJ5EjApoHvC3PCD/4d5XheaF3OcEvxPRuB9TnpQdyw6RhZGfCLFzyO5HuA2IB2OC66tKaXM0xpaljWBfAmKW57KhntwOBMEVbZBAvCHcRvj519ExBlgKKTNgqGc67gfCcFelyCSL9mpdoPNY+B1tIkhbK8pdpz0082Nn5bA3IYJAxqtOIH51Osfacxn0Xju7IKKAPqj9R+KTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCXZU9e44H5BTdIejBMDoFHy7Dvoep10JIIACPAt2Ak=;
 b=AEwmXdnRbdttcHyntg9/UF3maHp/6TMG9Cnk/xv6z06PP8HucoISjg5TF3QyBZQU6ON4TOreFthiLMxoRkiZpR89XqNouRk5r0EBZq/GaEbLseZM5lNj60c21C0SDiFg+wi/f2Jbg+zgyk1Kk2r84ey00b3IgGBbEYqZZLA5fQQ=
Received: from BY5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:1e0::11)
 by IA1PR12MB6388.namprd12.prod.outlook.com (2603:10b6:208:388::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 07:02:41 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::f1) by BY5PR03CA0001.outlook.office365.com
 (2603:10b6:a03:1e0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Fri,
 12 Sep 2025 07:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 07:02:40 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 00:02:40 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 00:02:40 -0700
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 12 Sep 2025 00:02:38 -0700
Date: Fri, 12 Sep 2025 09:02:37 +0200
From: Luc Michel <luc.michel@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, Francisco Iglesias
 <francisco.iglesias@amd.com>, "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Frederic Konrad <frederic.konrad@amd.com>, "Sai
 Pavan Boddu" <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH v4 39/47] target/arm/tcg/cpu64: add the cortex-a78ae CPU
Message-ID: <aMPFjZuTsXSBiqeL@XFR-LUMICHEL-L2.amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
 <20250822151614.187856-40-luc.michel@amd.com>
 <CAFEAcA-wnyWketgmq-gQYfgxMkDq16VDNZQCvM3uA1OE__=PAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-wnyWketgmq-gQYfgxMkDq16VDNZQCvM3uA1OE__=PAA@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|IA1PR12MB6388:EE_
X-MS-Office365-Filtering-Correlation-Id: 439f9f56-bf85-4152-ab4c-08ddf1ca5d5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aVWFpFwEbVUgCtdv+qdJUUSKkfvPjmy92RW+c/+LDFRwdkVT23SUTYDvx6kw?=
 =?us-ascii?Q?OthacFL+sf/kwKJH7B6N7nHhiC/DVdenAB4kvoHKk1PV//NY4X2UyhrfZYK3?=
 =?us-ascii?Q?VTAy5QAgIo6eHJhMtX7Ag2+Kj7Z52ufbXsc+BguSGo8XFDd58xl6wXolKP/m?=
 =?us-ascii?Q?40Wrq7EUrgBpwsvLR0vw5H38vPU32kT/vbiMhEgThJgYs2vg5+qgvYeBpTO0?=
 =?us-ascii?Q?ovZqf0O644jo/dNa9ET4BXC8CqZuYzwDvQXGZJN910GVtF3SMod7aqZf2FpJ?=
 =?us-ascii?Q?8E8KhnAiO6g/+X197/8dFODapS0iBoaPhHZoZ8qemYyXGKoYMbgDxxtEu0qq?=
 =?us-ascii?Q?WePReTOJmCbyQkQIIuCyToa2Qvf3VECSJ9bXOELlwt7JxrWqCTWHilxp0REX?=
 =?us-ascii?Q?lpepN2x+1t8zRqEWBCbyq0D6xTgNlChF75yUyE4BpGaT03kuJ3pgLQrxq4+n?=
 =?us-ascii?Q?bP2wf+1dMjOcTcrOslF6hKPs601kjXLRhv9chBwHtQKQXKkr6lg6nRSt3CR9?=
 =?us-ascii?Q?NcxpNb/ktnODjkoL/9GO2jUL9jvhfFh1XYphb5MH8yEZM4yP6o3ZdQAB7XQi?=
 =?us-ascii?Q?4GjXLPj3iQYRKgu71pkiXXPLZIKQgj7pe6YVAf8wZXQVSiGcmwkZ0T0TuttA?=
 =?us-ascii?Q?ritsGuTEIYYAsVGRzypZn04bkXlUCo8AZrLWDp/5S0CIJB6qgJTh5eeOWngx?=
 =?us-ascii?Q?IlEOsoJfwSwS8pCMmG09/i9YS0jN/w8nEG4G7glBh+YcE39AEATWVd9M9xMn?=
 =?us-ascii?Q?fJvkdwnQnaT3DBVI7OwakighyykSu7xexC0b54pCvinYnS0/jiLF/RaAjv/2?=
 =?us-ascii?Q?/9u/Va3U812VFVVzJpBkktpViFK24w2Hbhu4VbFCjybfoosE36toqX7zTet0?=
 =?us-ascii?Q?Q3/CPcDZoyltamnfoSUlXBkXec8JiKijfk7wJj91mraPBkwH6WyqM55x74Rp?=
 =?us-ascii?Q?qenTLnc9CWvaJAeDBBQ+f5nK5EC1OaPF/fHJ3dEWs7hawQPoTk8w9DFwQV/4?=
 =?us-ascii?Q?aNe7USCRgysEa7LiQqvjrHlVZYjzm00JBPVrMICVXNK0emT7x+BeMqD677tz?=
 =?us-ascii?Q?38h/HiUdaKviRt/oy1lVGeUnxZh/VXNIkcXn22iZztnqsWGyhbMuHWMkcXrw?=
 =?us-ascii?Q?SG2/hRbKbULgThnmQmvq7oC43ZFj367TTHDp3zxhrWSpeTlQquV1xeE4Uhei?=
 =?us-ascii?Q?D/GUo+esvn3dxXcf48OGWli6fw60jhXTKWSxS08yrZU0JtSJUwyKAIXP5uGZ?=
 =?us-ascii?Q?QB/ttnXV8SvtoxcYiK173+GOWk+vYXgBZ4DgDPBG9nEmmf2F8/5wxRbA9DKx?=
 =?us-ascii?Q?7jMrkLcvV2uJNnKSoIWJwpWDOA+DvmH5N18fMdHPrTighjFZ7xxISrQpjwsI?=
 =?us-ascii?Q?d0NB1lkJX3bZzKWgZanQuuN/T2IMS2Aoe//rMxkZ85rlEZLgUwPkSwDy5f3+?=
 =?us-ascii?Q?QjriGdZWzLUdkL4rQFKp3AwINzWXgzsJbBy9OrImES4bzTEPOX8Rh4RrAF7A?=
 =?us-ascii?Q?kvDozrPW8TAWD2fDEAQ/vlRrHXvb04ssYfZi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 07:02:40.7054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 439f9f56-bf85-4152-ab4c-08ddf1ca5d5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6388
Received-SPF: permerror client-ip=2a01:111:f403:2417::625;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 15:31 Thu 11 Sep     , Peter Maydell wrote:
> On Fri, 22 Aug 2025 at 16:17, Luc Michel <luc.michel@amd.com> wrote:
> >
> > Add support for the ARM Cortex-A78AE CPU.
> >
> > Signed-off-by: Luc Michel <luc.michel@amd.com>
> > ---
> >  target/arm/tcg/cpu64.c | 79 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 79 insertions(+)
> >
> > diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> > index 35cddbafa4c..b56677c1a5d 100644
> > --- a/target/arm/tcg/cpu64.c
> > +++ b/target/arm/tcg/cpu64.c
> > @@ -404,10 +404,84 @@ static void aarch64_a76_initfn(Object *obj)
> >
> >      /* From D5.1 AArch64 PMU register summary */
> >      cpu->isar.reset_pmcr_el0 = 0x410b3000;
> >  }
> >
> > +static void aarch64_a78ae_initfn(Object *obj)
> > +{
> > +    ARMCPU *cpu = ARM_CPU(obj);
> > +    ARMISARegisters *isar = &cpu->isar;
> > +
> > +    cpu->dtb_compatible = "arm,cortex-a78ae";
> > +    set_feature(&cpu->env, ARM_FEATURE_V8);
> > +    set_feature(&cpu->env, ARM_FEATURE_NEON);
> > +    set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
> > +    set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
> 
> From cpu.h:
> 
>     /*
>      * ARM_FEATURE_BACKCOMPAT_CNTFRQ makes the CPU default cntfrq be 62.5MHz
>      * if the board doesn't set a value, instead of 1GHz. It is for backwards
>      * compatibility and used only with CPU definitions that were already
>      * in QEMU before we changed the default. It should not be set on any
>      * CPU types added in future.
>      */
> 
> This is a new CPU type, so don't set this.
> 
> > +    set_feature(&cpu->env, ARM_FEATURE_AARCH64);
> > +    set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
> 
> The TRM says this CPU doesn't have a CBAR register, so
> don't set this.
> 
> > +    set_feature(&cpu->env, ARM_FEATURE_EL2);
> > +    set_feature(&cpu->env, ARM_FEATURE_EL3);
> > +    set_feature(&cpu->env, ARM_FEATURE_PMU);
> > +
> > +    /* Ordered by B2.4 AArch64 registers by functional group */
> 
> There is no B2.4 in the Cortex-A78AE TRM. Please don't
> just cut-and-paste things from other CPU definitions.
> Similarly for other comments here referencing TRM sections.
> 
> In this case what you want is section 3.2.4.

Sorry. All of this come from the fact that I mistakenly used the r0p1
revision TRM. Section numbering seems to have changed between the
revisions.

I'll redo this based on r0p3.

Thanks

Luc

> 
> > +    SET_IDREG(isar, CLIDR, 0x82000023);
> > +    cpu->ctr = 0x9444c004;
> > +    cpu->dcz_blocksize = 4;
> > +    SET_IDREG(isar, ID_AA64DFR0, 0x0000000110305408ull);
> > +    SET_IDREG(isar, ID_AA64ISAR0, 0x0010100010211120ull);
> > +    SET_IDREG(isar, ID_AA64ISAR1, 0x0000000001200031ull);
> > +    SET_IDREG(isar, ID_AA64MMFR0, 0x0000000000101125ull);
> > +    SET_IDREG(isar, ID_AA64MMFR1, 0x0000000010212122ull);
> > +    SET_IDREG(isar, ID_AA64MMFR2, 0x0000000100001011ull);
> > +    SET_IDREG(isar, ID_AA64PFR0, 0x1100000010111112ull); /* GIC filled in later */
> > +    SET_IDREG(isar, ID_AA64PFR1, 0x0000000000000010ull);
> > +    SET_IDREG(isar, ID_AFR0, 0x00000000);
> > +    SET_IDREG(isar, ID_DFR0, 0x04010088);
> > +    SET_IDREG(isar, ID_ISAR0, 0x02101110);
> > +    SET_IDREG(isar, ID_ISAR1, 0x13112111);
> > +    SET_IDREG(isar, ID_ISAR2, 0x21232042);
> > +    SET_IDREG(isar, ID_ISAR3, 0x01112131);
> > +    SET_IDREG(isar, ID_ISAR4, 0x00010142);
> > +    SET_IDREG(isar, ID_ISAR5, 0x01011121);
> > +    SET_IDREG(isar, ID_ISAR6, 0x00000010);
> > +    SET_IDREG(isar, ID_MMFR0, 0x10201105);
> > +    SET_IDREG(isar, ID_MMFR1, 0x40000000);
> > +    SET_IDREG(isar, ID_MMFR2, 0x01260000);
> > +    SET_IDREG(isar, ID_MMFR3, 0x02122211);
> > +    SET_IDREG(isar, ID_MMFR4, 0x00021110);
> > +    SET_IDREG(isar, ID_PFR0, 0x10010131);
> > +    SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
> > +    SET_IDREG(isar, ID_PFR2, 0x00000011);
> > +    cpu->midr = 0x410fd421;          /* r0p1 */
> 
> r0p3 is the latest...
> 
> > +    cpu->revidr = 0;
> > +
> > +    /* From B2.18 CCSIDR_EL1 */
> > +    /* 64KB L1 dcache */
> > +    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
> > +    /* 64KB L1 icache */
> > +    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2);
> > +    /* 512KB L2 cache */
> > +    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 512 * KiB, 7);
> > +
> > +    /* From B2.93 SCTLR_EL3 */
> > +    cpu->reset_sctlr = 0x30c50838;
> > +
> > +    /* From B4.23 ICH_VTR_EL2 */
> > +    cpu->gic_num_lrs = 4;
> > +    cpu->gic_vpribits = 5;
> > +    cpu->gic_vprebits = 5;
> > +    cpu->gic_pribits = 5;
> > +
> > +    /* From B5.1 AdvSIMD AArch64 register summary */
> > +    cpu->isar.mvfr0 = 0x10110222;
> > +    cpu->isar.mvfr1 = 0x13211111;
> > +    cpu->isar.mvfr2 = 0x00000043;
> > +
> > +    /* From D5.1 AArch64 PMU register summary */
> > +    cpu->isar.reset_pmcr_el0 = 0x41223000;
> > +}
> 
> The register values look OK; checked against the TRM.
> 
> thanks
> -- PMM

-- 

