Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CF2C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 14:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKevS-0008Qq-S2; Fri, 21 Jun 2024 10:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.lugou@provenrun.com>)
 id 1sKevR-0008QG-4F; Fri, 21 Jun 2024 10:07:37 -0400
Received: from mail-mr2fra01on20727.outbound.protection.outlook.com
 ([2a01:111:f403:261c::727]
 helo=FRA01-MR2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.lugou@provenrun.com>)
 id 1sKevO-0008Sz-Cs; Fri, 21 Jun 2024 10:07:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YN1lhebuv/qTx2i/CNUACehnwdO17KOIT9YQBBA4Zs+fEUHkASyjmthIqtuzV6Z/k+vq3B/iPvf9UeZWUO1W5N57BBmp5gS0uw3XuOZ3ZXRyUMfm+HnjJ3GpgqjKW5WuP52GEsvO4c+cMCejjpLNDx///opNPmopbg2nFq0EuFqZULPe7FiuEsQ5B18004UXtp/jfXBBvAAWVM0J5DLxFz440/CND6PwTjeQvtt7k5kFFcqH8gk4+rsXDsS49iKc6KhlOTxYRj9dIF14RomCEVzPBsQi5rUuRkdx+XX2jZT9YnrERprrv1prqct0QMiH9SGIWxpFhVpAZO5YxqwGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvHDRshVWnD2IOiX6hvmW4nwh0M7a6HdOS4lHU7CZq0=;
 b=b7pHL86LYqEYV0RcEbG+NPLVeal7S3qR1Jc/TeSew8Z7hbMLP6M2Txc0HeJ5japCWR8UzJ/olFfiYGoQgLFNIS/rRHx8LxV38hkvLac5Tx30LP6TJaCF2iA7P5m6B8ImWy2tKiYsR9GKDfG9N3lFB7rJm9a0wDggUjOh7y02oxEa1btievWEZ4scS8YUgOKkXEVPnMa9x7YetBQnCvo7kz0yCkKUP9j3883nHLGDvixP668avpY0/+SZGlNETOFAd1WLiuHxJJ7pY5P4zqpGk+4MtX11pvJVuJJMjLidKg2ywWGw3LMh+CvxVXM/aN74JJpCCdViOexJAQ45seWl+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=provenrun.com; dmarc=pass action=none
 header.from=provenrun.com; dkim=pass header.d=provenrun.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=provenrun.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvHDRshVWnD2IOiX6hvmW4nwh0M7a6HdOS4lHU7CZq0=;
 b=cfs/4XBS05nD+81eIqT4u2GNfJz9LUrB2lApJaisb6LDH6fgJvD0f0mjg9oX9O8oHF4yHuwrIM6bZ3+C4AvU2asYR5fBrpU6ELA/Beri/zNeia2mk59JbmVtMSa6jCVoRuQdZLmgpous0kwa13wuclwu8jyVQw7UKZnVbZsX6iJKeCX0XgY2aj3u/p9uBpixtT25SwJN6icYMVszWfSU9D13o6/1RX2SGaJJeWxB+6hPCNuQOzJrJwwGKwgfQZHpX0tjrC2C8qLdw07AQT47NlrIkBKlrPG/kbOguu2QWUVNCWReUCtx58awYw0eXtYpdAQEaT4wfuc+c8V6cTK5QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=provenrun.com;
Received: from PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::18)
 by MR1P264MB1603.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.22; Fri, 21 Jun 2024 14:07:27 +0000
Received: from PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ef1:e8a1:244f:3ca7]) by PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ef1:e8a1:244f:3ca7%3]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 14:07:27 +0000
Date: Fri, 21 Jun 2024 16:07:25 +0200
From: Florian Lugou <florian.lugou@provenrun.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: Re: [PATCH] target/arm/helper: Fix timer interrupt masking when
 HCR_EL2.E2H == 0
Message-ID: <20240621140725.f4hsasmhrhh4joxm@flugou-latitude5401>
References: <20240615185423.49474-1-florian.lugou@provenrun.com>
 <CAFEAcA_+WrzM4fXQMUxMi3L5yiUWMrUGTSZH=NDdYDKUCP+8NQ@mail.gmail.com>
 <20240620135627.qxcrkdx5v7wdurx4@flugou-latitude5401>
 <CAFEAcA-ngrrEUDD7eA_sOLGF+_wRCuQVxTwuCA4pXjRcuJucmA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sbprwg3zdqhknqh3"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-ngrrEUDD7eA_sOLGF+_wRCuQVxTwuCA4pXjRcuJucmA@mail.gmail.com>
X-ClientProxiedBy: LNXP265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::17) To PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f2::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAZP264MB2990:EE_|MR1P264MB1603:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f20dd87-ea58-4291-e40c-08dc91fb7b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/Hi+4rCgODxrM4jvLpMQzN+MyG6BAVE6YQh89vpCdAzteKSUW0ivV8uwgqSD?=
 =?us-ascii?Q?kFeQ22I2YQ7mBBtjmuHgikp5kUu9cjb0xcN+mPYMx2RHCcqI1Nrijlx21Tpx?=
 =?us-ascii?Q?kIOYq9M/YkuM+ntGwA+DPSxvsVqWRG19XIBDcbzWZhtrWEWCC0BDhila6pdc?=
 =?us-ascii?Q?PYR1/hd9mzCrtltGJeN9t/jLLNk6vlFDylepL0gp7ncuwI86JgdHRFAmRH9C?=
 =?us-ascii?Q?mXtCPRENb4kvSsB2iWf4q6TDFplUIAG3lhswn0Wnhf5YMIg/fV8Iv/8RSgo5?=
 =?us-ascii?Q?Ts6GUH5PydNKnYvn+nHwLWjrTV++dBGayIZQF9OiC7BqSFwogdk0LoNkFa08?=
 =?us-ascii?Q?7EpadxPiW/W3DBpZoyKmJvZpaNKnc+GWm2WAOUT25fzCd37dS9qypEh0e7K0?=
 =?us-ascii?Q?Z9BpG+bCNRI3QptZcxcoRppodGMgDFRxp1HYKARYPn3tsafzqO9N5RwgZYsh?=
 =?us-ascii?Q?5LNgEKfChJgPj7US5D8Xl8As32YOT3l9HO5NekXHPerroC31DpG1cvxnvXM6?=
 =?us-ascii?Q?gT5dgD2Ji8pA92m24ZnRCBhCneoFEtiyyNPVifgZTw0mFLYqd0veMB1bVFEj?=
 =?us-ascii?Q?J/4vrdnkugk8AuctVpvpBa4n06MvhVlShTde2exit+ZX2xZ0FwKrRd5Pj2CV?=
 =?us-ascii?Q?igoAaLPp7zwa1mMF2gXyA9ZoX9zxYEAORrnddXNYHJRfGzKVUmA0Fg7egt8G?=
 =?us-ascii?Q?OqIcYnRFHX30FLIQF0h6PBXWIJ34hkgwiS1UYWfQRT6zCBWfrgf09GKH09bh?=
 =?us-ascii?Q?bsgnC1sgeDGHb/qDxmcg0uMrhKIF86kekwxwAP47CyUZZPEJtSggRdhUmNKd?=
 =?us-ascii?Q?oXns+i0raM+hDN9LbeF+ucvXV5755U2Y4l+cmOiJ+H+KTJZpqbwPVQgzvWAs?=
 =?us-ascii?Q?xNGOvbbCWmqyeGORHzsomT3iftXW6Gnejq+D1Pf7i8gP5HVff6aHmAgCEy9c?=
 =?us-ascii?Q?Qb9KiZy3Vb7yZsWVGxbG2I8oQDbe6XeiWX8tnMNdE1gBdUkrkCcZQASi4NM4?=
 =?us-ascii?Q?OADNuiv6c3idF60gzj9+JY5M+41+CUwaKdJNccxx+IVvqFl2NbqDgHJC0XDT?=
 =?us-ascii?Q?grSDp5IVWcwBjLiiPpSIKFuQSe7bEIT1QY0LmY3KrLramxaF/xVBPTyObx4T?=
 =?us-ascii?Q?oKg4BofTJYpx097QJFbokHy+FGl2ocusxE1l1RxkPHuWh/vayLT3QzF4SXL1?=
 =?us-ascii?Q?dbIH8Z2e7RbLCxUPDGBmhLEO97y8jLRRXWFUqtAaRiFM97iyPq9PAfQDoWY3?=
 =?us-ascii?Q?N64KJ2fB1+4tyxUL24TeYzX9a8kQo+oPLlwOuuXZyFbjz/AZTfyFwNXeqeJ8?=
 =?us-ascii?Q?1ymMen2SUbTG4ampfa6uO6AG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(366013)(376011); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xutoX2h/n6Rw0jV3o+YQ+Dd40fqRb8FcZ6o+dDmajErLAZJ7bWDo84f8Plom?=
 =?us-ascii?Q?TDBErxRtrk1TXVECtIGPG8P5T7tt9FSLDe1l7xQG30Yt2eB39jcStioEXqbX?=
 =?us-ascii?Q?ozCw4f96hzdzyyZdcuZNb0tJ/MBYZPT9bcCS3yjgHkwKlBNrDV+21ZOf5aBo?=
 =?us-ascii?Q?u0hklgR164U1fIuu74bRWmUCUpjYafSPN1jJkgxJVVXWk+gV03WHIbDXdyET?=
 =?us-ascii?Q?SHiEnOg8L7bB3Q/tsmsMoXWTcZt810s5jkbEIHiONMy17yXp75IuZa/GoUZi?=
 =?us-ascii?Q?guo/o936OF2QqW/jVGEjDFj1C5SZw6+vIp2MFaaTaZor3Rsx5FBKEaQYqb7V?=
 =?us-ascii?Q?FLwCTKMvVAQoL0P/RaVUcoAK7/Mye1jsVRveBwXLgUuioaX0JDn2NamLIRQW?=
 =?us-ascii?Q?sIArCiXIYcIu8/BMxPJ56bWLUAorSiM4alYiogpUUS1chqBOhzM5z7+wmbgK?=
 =?us-ascii?Q?rnrjKW57YjXL+8dWzDBNFL0+Mocbi/bjOgMUpLxu1YYzElFZcN2hszF3TO5j?=
 =?us-ascii?Q?HOWk+EMklQCj6R+f0V3/Wy3ldJ3/0Pj0LqwLppLKI1+PX5YkpMnpe3on80v7?=
 =?us-ascii?Q?Tgj3t+7m/eD6Ym+wQn55OR/85660rVndHMGLCdfv9Zymy8Oz49NuJaj1/w2x?=
 =?us-ascii?Q?t+ue1DaTSEePK87G+wVsOW1kljZXy7K6GRgnPtSy8ez5ltzlC/OKWHd7ozZT?=
 =?us-ascii?Q?3mdlER6//vwTWJn5tORS2rB1dq6hkvYvwu+T0LnlXfNr/ZM/BKjPfoCClguj?=
 =?us-ascii?Q?heBnx9D/vXtQcddswG24gGVo1PJiLiso7N70cxRTrY13nilRdxxmEw7vuRqg?=
 =?us-ascii?Q?5QOvDYZk0183dTxPDWrSIymdD3WTFbIaKBt1/bMGwUg3kG5N/2zJtv8BOsPR?=
 =?us-ascii?Q?qYXW725v4BmYsv7XCJ2EPX67fGfseRSEeMeiIuOJYev0yjevOQgqk/C71ACv?=
 =?us-ascii?Q?nHj6hMkAYJM/IGITla2sezK/xbkXfgppFDkNmvjcL0DHejgjKSEyohrGQcWT?=
 =?us-ascii?Q?MKUrgR099UeowcC1K5aLbJ86Mz0cJd6pgryoUbDt2iRTnz/vbvZWV3FDWcDH?=
 =?us-ascii?Q?+M+yIGxMLacvg65Cl01Qsj4yioFTLL618VilCHatSowznH77Agiekq0RoDsh?=
 =?us-ascii?Q?sTg7hTHYeWTHx9prcTkBUz3SZnmf0pvJdsU1rt+pITdaJr9HFrXO/ICG984v?=
 =?us-ascii?Q?EC8Gl/vtBN+SEQDSdbdi8ISYli2u4tfvp1MLFd9G5vCy4YOo4RiEnbc9vaNT?=
 =?us-ascii?Q?J1NyezvnQ1bXVHvnicX9iJPJMbd3MvFSEjTVFEBEDB8kV/BRdj9x9W7Fn0aU?=
 =?us-ascii?Q?q7zYSG8yXNQsJlU8RIHHDYPG0OlKGI90R/BPO/n9sr1BANDcZd+QQwtuiQbs?=
 =?us-ascii?Q?APYDNacXtmMI6aBOlZA3B1yBiPxNMulAhCy2SUhuVunM9iLAZ9KdCSrEr9S8?=
 =?us-ascii?Q?2uvKIh1pBZyHyBRChcSkaOxW7Mb66W5zQsWfIBLthV1bCG3wgVzxKQk1adst?=
 =?us-ascii?Q?1/qNPendVGPB8NVKih92cKw2XstwdYS4kH4z+cr31Xaewi0vNREYk59COLBC?=
 =?us-ascii?Q?h4+7qWgS/BvfFkrnjbNnqaCALL+UjJuGtgkjC40rQVLKi8BQhRyRBvMcsEs3?=
 =?us-ascii?Q?VdGoHfK61tcQm/NDMg9x/XiDqmBp3fmUhA18G6Uip/GIgi87oM2Ccl3zQ9gy?=
 =?us-ascii?Q?62+mOQ=3D=3D?=
X-OriginatorOrg: provenrun.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f20dd87-ea58-4291-e40c-08dc91fb7b29
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB2990.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 14:07:27.1203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff654c30-3eb4-4445-b89f-a54a92b1f03d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDIhgy9+t2Ilspv0Eo/i6s+3vIwXjCHyOGmo5ULj6hPs7WtBKQLfsYE4PNxAM9eYeVXpBYFxcoaxWb99bvSbmVlzvCXOb4YTpTE8oTwVM18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1603
Received-SPF: pass client-ip=2a01:111:f403:261c::727;
 envelope-from=florian.lugou@provenrun.com;
 helo=FRA01-MR2-obe.outbound.protection.outlook.com
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

--sbprwg3zdqhknqh3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 08:01:01PM +0100, Peter Maydell wrote:
> On Thu, 20 Jun 2024 at 14:56, Florian Lugou <florian.lugou@provenrun.com>=
 wrote:
> >
> > On Thu, Jun 20, 2024 at 11:43:17AM +0100, Peter Maydell wrote:
> > > For this timer check, we're doing I think the same thing as the
> > > pseudocode AArch64.CheckTimerConditions(), which does:
> > >
> > >   if (IsFeatureImplemented(FEAT_RME) && ss IN {SS_Root, SS_Realm} &&
> > >       CNTHCTL_EL2.CNTPMASK =3D=3D '1') then
> > >      imask =3D '1';
> > >
> > > so I'm inclined to say that our current implementation in QEMU is cor=
rect.
> >
> > Indeed. I got confused with the specification, my apologies.
> >
> > I am facing an issue with QEMU freezing waiting for a timer interrupt w=
hen
> > running with -icount shift=3D0,sleep=3Doff. Bissection has shown that t=
he issue
> > appeared with f6fc36deef6abcee406211f3e2f11ff894b87fa4.
> >
> > Further testing suggests that the issue may come from gt_recalc_timer. =
Calling
> > gt_update_irq before timer_mod (as it was done before f6fc36deef6a) rat=
her than
> > at the end of the function solves the issue. Is it possible that timer_=
mod
> > relies on cpu->gt_timer_outputs, which has not been modified at this po=
int to
> > reflect the timer triggering?
>=20
> I don't *think* it ought to care -- timer_mod() tells QEMU's timer
> infrastructure when to schedule the next timer callback for,
> and the gt_timer_outputs qemu_irqs tell the interrupt controller
> that the interrupt lines have changed state.
>=20
> Do you have a reproduce case?

I do:

$ cat test.S
=2Esection .text
=2Eglobal __start
__start:
    /* Setup exception table */
    ldr     x0, =3Dexc_vector_table
    msr     vbar_el3, x0

    /* Enable and mask secure physical timer */
    mrs     x0, CNTPS_CTL_EL1
    orr     x0, x0, 3
    msr     CNTPS_CTL_EL1, x0

    mov     x0, 0x8000000 /* GIC base address */

    /* Enable group 0 */
    ldr     w1, [x0, 0] /* GICD_CTLR */
    orr     w1, w1, 0x1
    str     w1, [x0, 0] /* GICD_CTLR */

    /* Enable timer interrupt */
    add     x0, x0, 0xb0000 /* SGI_base */
    mov     w1, (1 << 29)
    str     w1, [x0, 0x100] /* GICR_ISENABLER0 */

    /* Enable all priorities */
    mov     x0, 0xff
    msr     ICC_PMR_EL1, x0
    mov     x0, 1
    msr     ICC_IGRPEN0_EL1, x0

    /* Set timer compare value ~0.8s in the future */
    mrs     x0, CNTPCT_EL0
    mov     x1, 0x3000000
    add     x0, x0, x1
    msr     CNTPS_CVAL_EL1, x0

    /* Unmask the timer */
    mrs     x0, CNTPS_CTL_EL1
    bic     x0, x0, 2
    msr     CNTPS_CTL_EL1, x0

    /* Enable interrupts */
    mrs     x0, SCR_EL3
    orr     x0, x0, 4
    msr     SCR_EL3, x0
    msr     daifclr, 0x1
    dsb     sy

    /* Loop on WFI */
0:
    wfi
    b       0b

=2Emacro EXIT
    .p2align 7
    /* Issue a SYS_EXIT semihosting call */
    mov     x0, 0x18
    .word 0xD45E0000
    /* unreachable */
    b       .
=2Eendm

=2Emacro HOLE
    .p2align 7
    b       .
=2Eendm

=2Ep2align 11
exc_vector_table:
    HOLE /* Synchronous, from EL3, with SP_EL0 */
    HOLE /* IRQ,         from EL3, with SP_EL0 */
    HOLE /* FIQ,         from EL3, with SP_EL0 */
    HOLE /* SError,      from EL3, with SP_EL0 */

    HOLE /* Synchronous, from EL3, with SP_ELx */
    HOLE /* IRQ,         from EL3, with SP_ELx */
    EXIT /* FIQ,         from EL3, with SP_ELx */
    HOLE /* SError,      from EL3, with SP_ELx */

    HOLE /* Synchronous, from lower, with lvl n-1 aarch64 */
    HOLE /* IRQ,         from lower, with lvl n-1 aarch64 */
    HOLE /* FIQ,         from lower, with lvl n-1 aarch64 */
    HOLE /* SError,      from lower, with lvl n-1 aarch64 */

    HOLE /* Synchronous, from lower, with lvl n-1 aarch32 */
    HOLE /* IRQ,         from lower, with lvl n-1 aarch32 */
    HOLE /* FIQ,         from lower, with lvl n-1 aarch32 */
    HOLE /* SError,      from lower, with lvl n-1 aarch32 */

$ aarch64-none-elf-gcc -ffreestanding -nostdlib -T qemu/tests/tcg/aarch64/s=
ystem/kernel.ld -o test test.S

$ qemu-system-aarch64 \
        -machine virt,secure=3Don,gic-version=3D3 \
        -cpu cortex-a57 \
        -kernel test \
        -display none \
        -semihosting

$ # Exits after ~1s

$ qemu-system-aarch64 \
        -machine virt,secure=3Don,gic-version=3D3 \
        -cpu cortex-a57 \
        -kernel test \
        -display none \
        -semihosting \
        -icount shift=3D0,sleep=3Doff

=2E.. (hangs until QEMU is killed)

Best,

--=20
Florian

--sbprwg3zdqhknqh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEi2flTDU77YujoiPS7SlcI6rHG90FAmZ1iR0ACgkQ7SlcI6rH
G92HCwf/fThT7HMlU9HhylfXkDfqCqPhp0CSQX6qT71Bm0lPqYgj9nZqpjmR58Mo
NwjqhY+cDCvxd2+mTUE3L3tOhxMQgniALLFjIhwLVRRsuWnEqt7gaveOY+Asjhmi
OXeuMK5lwgyIgOiBmO2wXlZnJa6qt3fmfIirZnkGfYs9WDY12I2gccpPrRP0+3At
yb3+l2Hzl3AnGk7N/QSz9CMeHb0iFIxd95h7vVOAawGJx0LuHdYVcVRmdWWkSS8O
y+ofjCNKC23FgsHb86QP1MHJTE2EFlNtoVQKUArmFO24LgvTJYOK3Mw09eWkiz66
QZBPoAhX/QYjZlaH5iMVJ6uNbIddDw==
=ltd/
-----END PGP SIGNATURE-----

--sbprwg3zdqhknqh3--

