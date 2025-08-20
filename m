Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE752CA0EED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 07:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uod6D-0004Pq-Cq; Wed, 20 Aug 2025 03:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uod6B-0004Pd-Gv; Wed, 20 Aug 2025 03:19:07 -0400
Received: from mail-bn8nam12on2062c.outbound.protection.outlook.com
 ([2a01:111:f403:2418::62c]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uod68-0000zf-Ih; Wed, 20 Aug 2025 03:19:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCbA/ke6YlZT2AM6ZTuWLtl/uUFbb02NwDm2DIurqDIGec+GmTBAHlUNvGKEUIk+aTBGvZHdpN9vJC4BQcziCaCC15OOb2Z+Z2cfRQqsVfvx/onEyUMIkjsr86SnzVfswwgN98XJ28vhLyeCBh+rXa0Jzpj0whbne8pxsrUPqbV3e9I8xeT3xPlSU4yp33WZabN4mN355HdtlHWXyRCbDiSuim4YAUO1+AthIz0zHFd19SVRKqIggJ/MOaCf2g8Xfu40gYfmiCNCSHdZyYNm02DGqIWnmtSDQOKiYMhFasoaxQqaIMfHWhD6hVsBGLW4AmkSVUT0Ntc/gd3KSUDgqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sQ0f+CJlFWVdvfk3U9YHHrK1XgNvtqFqlNtv0aOcag=;
 b=XwOwZT9DqgbolQDakN7VGidOlOFZe5NaiFjzjBZNWy5SKQz5fxNWokTGuU/20m01wUlj7d3J7ezC+XEZzgG1VYH9sSceAEis/aj/BptEa03mVzutVQWlc39gqgMHblKaaT/TM4s2EYhoIDEJJuYdtsT8l5LNDtKEarnaBRawHN4Oi3JYWMvasTnxi6lGkldQKd6jwZT0sufFTnkwndJ6rv4OI4Up7sR2GsAUmXnDCbkuXU/0oDYwsh2KUSXqEho7jcXF1FsIAqkLrPQNXHY5VgoAD64km3G/FgQWgsIdBkHVXHBPdlyxvVEDegu6EIV9E2H+vjz5VPxUZ+8V5EOjfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sQ0f+CJlFWVdvfk3U9YHHrK1XgNvtqFqlNtv0aOcag=;
 b=4UjU/5bimo8saHARznfYF2ChVu1F290o/oaRWzcYG0r5TvAQFeqGKOa3R1xgm2VamFHrHGYxE2QJOqvDpdpcAoiFFJV1qX642h9DUaRVmpxIP2Kovj+nAnmJ1BNG44p4fxo1JbuSuY9brkLdvLPVbK/CjGGHmhUfOLy07mQD2l8=
Received: from CH2PR05CA0003.namprd05.prod.outlook.com (2603:10b6:610::16) by
 CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.18; Wed, 20 Aug 2025 07:18:54 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::af) by CH2PR05CA0003.outlook.office365.com
 (2603:10b6:610::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Wed,
 20 Aug 2025 07:18:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 07:18:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 02:18:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 02:18:53 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 20 Aug 2025 02:18:52 -0500
Date: Wed, 20 Aug 2025 09:18:45 +0200
From: Luc Michel <luc.michel@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, Francisco Iglesias
 <francisco.iglesias@amd.com>, "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Frederic Konrad <frederic.konrad@amd.com>, "Sai
 Pavan Boddu" <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 13/48] hw/arm/xlnx-versal: VersalMap: add support for
 OR'ed IRQs
Message-ID: <aKV21WpfZ8u054zc@XFR-LUMICHEL-L2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-14-luc.michel@amd.com>
 <CAFEAcA-x_CYWPM2TeGSTLjCj==3JY_uyvfFmR=nLi4pRLw-P2Q@mail.gmail.com>
 <aKMrBdNhtqHVHRYw@XFR-LUMICHEL-L2.amd.com>
 <CAFEAcA8eop95ojfZw3YbDrWfrv1fZ5QYSmwx_oDThxMCiMMeDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8eop95ojfZw3YbDrWfrv1fZ5QYSmwx_oDThxMCiMMeDg@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|CH3PR12MB9147:EE_
X-MS-Office365-Filtering-Correlation-Id: 76dc5fe2-fba5-4340-3c75-08dddfb9d227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i5XuAQ0IiIihAOvqd+1ICLToP97ZhgA8KCyUNzEeNgs/wtx6AJSw6DfcY/II?=
 =?us-ascii?Q?Z0GYQyNl2BjlvBQ/XynypDBtCyTy7fQBIr5BOESeUnO1D3vC2GgiCGTuQ95/?=
 =?us-ascii?Q?WdjIfa1oC2mHia5It9a+iunnkjRx0nzvo7AMtyGEnWEN05pziRWTAtIhbTQQ?=
 =?us-ascii?Q?qPFyiBPVnbdZEPSBaNeP8Wh1SuXqdcrIqvCO3Av0CO7nFB29+fNbLOXX3F6x?=
 =?us-ascii?Q?MAeemKLprd3bMwSsP2/Fb7+hxTNAruKc0AKiPIeSa8Fw0awt7QGb3qxcMXhW?=
 =?us-ascii?Q?XRUWosSQYLiioPdW8O6KPbh3XN/tU9Rbx/nxy4PIQfxZmtGBEfltKsvuSar2?=
 =?us-ascii?Q?D78CyLsisvCFftLcjJREb6goC3MIjrYZ5nkZ9Fk+mXiB8C/zK1NmcJsEOdUs?=
 =?us-ascii?Q?Y2JIND/AAlEFUIQKLb6QEn9Sz01pgPKup+8OGbgUyQh6SV0qmrNAsKa75whf?=
 =?us-ascii?Q?WoCWLn1td6APBDdCP/N1w7ywBYBpc4k5ZBJs3D63pnxNOtsmVU/GprP4Qbrk?=
 =?us-ascii?Q?oHFfsI4ag9CaikdzQ7Kmr8/cQ2vicOACYUZlfaWEKMJ6YgrNuDP61lFIJPYf?=
 =?us-ascii?Q?Su2PHkugQKUtdPbixRFqV1ryBHgq8kZvWFykpMUzFdC6Fg1dZdoTgp43KIDC?=
 =?us-ascii?Q?OM/Nx7rttBnO2HCLAEjjuNWUO5fZfflCFwYZreBbfMnCdcqEDXl4JDopMx72?=
 =?us-ascii?Q?rOIv+G7fR5/drR1F88ffCLGoAlnsb40q7X5k4XbobOg2j3EEg02y55kEFp81?=
 =?us-ascii?Q?ug/N0TP8JwLczZlNjsw53SF5uaFAFSpFvvmCsN8U2ZBQ/AWC/TvwwBqrSZia?=
 =?us-ascii?Q?VqwkpuIGd7rrdAgZKQG212RpVXHNBRC+mLTw6GNLq8iqst+AKw9i2qyKWyGP?=
 =?us-ascii?Q?unxmDAst93PHms/vRIrtX1W2ZMvAW4XFjMhF3TK6fxIgVa2EFmgm8FOa5qrD?=
 =?us-ascii?Q?4VELQeI5kLHpqPKlx5zGR6iYlGUBdqp6ZkeEYZBXR6a1780C1T76Pz8jyfne?=
 =?us-ascii?Q?J9P7LZhCccYbUdp6bCEJk/YwmjeFLDxwrgX8JxONOyNN2GbnrDIRyN2JPNMP?=
 =?us-ascii?Q?TyHU/VOSBK1ALKSlfs1YnMtVvLKzPf6j2smju9kTuRGFQHjpQJY/sm88WFoU?=
 =?us-ascii?Q?9l8BQ5Y3MCJBSxqa4QUDPEJK+f5MRXZFNJsmzgLrPfy0BonJCPw+G7xxPNts?=
 =?us-ascii?Q?aV+7JYX///pk9n67sMUYUF6ycMbPe9K0C2iqBI6pJFJ5AKKALZ+ZWJuCXFfc?=
 =?us-ascii?Q?56NS199s3R0ULWp4RP/Xcz9EkbszzC7MxR/skIR3hCeWG1moeODEZlvrbuK4?=
 =?us-ascii?Q?adnB/06xfB9fY1UkXmDqjbmtUN0VC9mYSR9DPTrvLyS+RiVebwDdoAiisjCY?=
 =?us-ascii?Q?KKnwwPS/JIlsQyQOwTjTy0sTOySo4lfXDNP5F050Z77MNFhpzWZ5yVjjaIhp?=
 =?us-ascii?Q?Z7bxgDYhlSe7ToS5b7cfaJcsZaZRoUsXCpBgStW4tE+U1SjvIBsVwnGqlAx3?=
 =?us-ascii?Q?3ys2+gLrQNhEMEvU9ZlidtR9dyICHbtifIc3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 07:18:54.3676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76dc5fe2-fba5-4340-3c75-08dddfb9d227
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147
Received-SPF: permerror client-ip=2a01:111:f403:2418::62c;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

On 16:25 Tue 19 Aug     , Peter Maydell wrote:
> On Mon, 18 Aug 2025 at 14:30, Luc Michel <luc.michel@amd.com> wrote:
> >
> > Hi Peter,
> >
> > On 13:24 Mon 04 Aug     , Peter Maydell wrote:
> > > On Wed, 16 Jul 2025 at 10:55, Luc Michel <luc.michel@amd.com> wrote:
> > > >
> > > > +static qemu_irq versal_get_irq_or_gate_in(Versal *s, int irq_idx,
> > > > +                                          qemu_irq target_irq)
> > > > +{
> > > > +    Object *container = versal_get_child(s, "irq-or-gates");
> > > > +    DeviceState *dev;
> > > > +    g_autofree char *name;
> > > > +    int idx, or_idx;
> > > > +
> > > > +    idx = FIELD_EX32(irq_idx, VERSAL_IRQ, IRQ);
> > > > +    or_idx = FIELD_EX32(irq_idx, VERSAL_IRQ, OR_IDX);
> > > > +
> > > > +    name = g_strdup_printf("irq[%d]", idx);
> > > > +    dev = DEVICE(object_resolve_path_at(container, name));
> > > > +
> > > > +    if (dev == NULL) {
> > > > +        dev = qdev_new(TYPE_OR_IRQ);
> > >
> > > Here we create a device...
> > >
> > > > +        object_property_add_child(container, name, OBJECT(dev));
> > > > +        qdev_prop_set_uint16(dev, "num-lines", 1 << R_VERSAL_IRQ_OR_IDX_LENGTH);
> > > > +        qdev_realize_and_unref(dev, NULL, &error_abort);
> > > > +        qdev_connect_gpio_out(dev, 0, target_irq);
> > > > +    }
> > > > +
> > > > +    return qdev_get_gpio_in(dev, or_idx);
> > >
> > > ...but then we don't save the pointer to it, so the only
> > > thing still hanging onto it is the QOM tree.
> > >
> > > If you want to change "embedded device struct" into
> > > "allocate memory to create devices" that's fine, but the
> > > SoC should still keep track of everything it's creating,
> > > so that (at least in theory) it could clean it up on
> > > unrealize.
> >
> > I'm not sure I fully understand your point:
> >
> >    - The OR gate device is parented to the "irq-or-gates" container,
> >      which is itself parented to the SoC. So finalizing (freeing) the
> >      SoC would trigger a cascade of free calls to the children,
> >      including those objects right?
> 
> Ah, I hadn't noticed that we add the object as a QOM child
> of the SoC here.
> 
> It does mean you can't ever get back to the OR gate object
> except by walking the QOM tree, but I suppose that's OK.
> 
> It would be helpful if you could run "make check" under
> the clang leak sanitizer with your patches added, to see
> if it complains about anything. (Unfortunately it will
> definitely complain about at least some pre-existing
> leaks, I suspect.)
Yes I did that before sending my series and fixed all my leaks. As you
say there are some existing ones, mainly in the register API (IIRC it
does create an object that is not correctly parented).

I'll send v2 with your other remarks addressed then.

Thanks

Luc

