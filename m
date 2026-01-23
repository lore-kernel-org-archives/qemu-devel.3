Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B314ED7788F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 17:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjKiB-0006Zj-28; Fri, 23 Jan 2026 12:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjKiA-0006Z5-0J
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 12:12:42 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjKi8-0004NV-B8
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 12:12:41 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-78c66bdf675so23567887b3.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 09:12:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769188358; cv=none;
 d=google.com; s=arc-20240605;
 b=BpvPK0dtP51jXAhz5BuzHgBUWiUd7C13YGkoQ3BWl97ZOdcIHY0h79dss812fI7P6W
 f+hT/d3y20hbffrvpFXnJ/lg6IeOsN/OtGU1bIFcgzsBETqCkWaRAvdPtQiGkHja1vev
 GaYF6K9nQTRMxpgExhXxeSJYj3+3VoJpYFxhwCBFIt54aSRrJRrx+ZDI7TwoG4MvGNF3
 g2rJH6/wT5l3cX5FO2qk4Jm/zzHWfdwUHStUd/SEeoRDPTigLWaFASIglOYR1tCVvdms
 /2zbAGNdUxI6j+yGCqUroivysYVHZLMLnmJx6djxI71w4Gssg4lkQtOidOseKRnHqVm/
 Fnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8Fa4sjNTNYLGAlPOTx72tSfXAvWVjL6wvcuD+e+0VuY=;
 fh=HZAlgublxYF9aitSZgstQEd7ObV1zHT5dwHZ5SIyDlk=;
 b=N4sZNpeiP/1eVd8XFSVy74BHO8j6RDzpzUG90wAgUZsX9gcJGm9MnbGvDf64SupS47
 dOfL0HlcCoz7yUjCqCfoLTokiYx65tjXNcqL2TiEpjj/t23Ani2D6FHJ+ZgKYQP0JqnG
 bSYXx8avuNPOtOjWsnmn40laKZ58opniRElFwxDkztNMi2U9eBoCZRab65q9A5NVdAQ1
 tTP5/hY7J3GGfutovIQ6x1HlPemj9OuaWYpepf7hjULa5b3XwTEgbsIppVYyNQ175Q8E
 t6uqRh+6SyGn82lXDMy22+TJUEmkLeppkQQlDh9PA49Q8oqiS2Dk5ynIXzxhJX0yNbrs
 pxdg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769188358; x=1769793158; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8Fa4sjNTNYLGAlPOTx72tSfXAvWVjL6wvcuD+e+0VuY=;
 b=t28+jH0yD0wqGBVDbEuaU5e0adXgJjYUzEq3wey9760LmiRY5LEn5By9Swx+yWaXdh
 7SJeQpb9IYMXL9G7HltyW/sqky3OIVodZudNJ29nQem50v2uv+p0dEC21op3zMQzCgZ2
 +3Fk6/GOyJpmzU690dvZfPF826CNEli+X/IntFE/k1nTZx0fP+6MDtvFpu6v1yS814+d
 ZOOb4OTkGmUIoyKllOou16wX44ag9naLaVUMmL9MoUrKcCx+oSqauA/0vG1lrdBO8Xyb
 e9PxKkI0zQUOrcgB7TznBS1/o4rTW61/IowwrnsfKr1z0uw9do7DMMAP/hdAaVDPDdTk
 o45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769188358; x=1769793158;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Fa4sjNTNYLGAlPOTx72tSfXAvWVjL6wvcuD+e+0VuY=;
 b=ODff4x+3OLRUkt2QQCXJfTGsBJtq6j8bGelEXvTacLl5MK6dlmnUc2c6tEIM1yswzg
 omK4VGf7op75DKnWjRmpLORHJpHDMAVYV+H87rjl+JI8FvXdkInHKijcaTS0xSaodtTt
 QwsmisrK4cgNN3mndNGzRUHv587Ziuax/W4X2bnALr0s6MKgLcaqd9jvinhhlaD+4kT1
 DOai6b642fc/erpGeOw8M96u+uXSf3xwB87+sm+i3hBTss3CUMipV4qjue3foEePp/6k
 gfxScSJzG9k/GSZQ07sRreIHqJjjKDwMQlnwR7R9P1BN86fuJJ98Qw+MWuPbrNdcAlis
 6KMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIbylr2jF3Z4nHWRiJ3TOkxSItu66WulXzkjTT1/YA31EFuhzSr1RQcHZIZwxldQZOow/HcLO8m7ov@nongnu.org
X-Gm-Message-State: AOJu0YykJiX6ui+BJYZUEL45Y7Zfczimvr7L6JpRfk9TTHn2LA8sZvLg
 DvN6GpJXhHkhnKQeneoFS+NIrmOnMNi4nqB52FbLwYu1kfOCxMnsxhg88rpY5qFdz6/ywkiPESA
 pDlj97M2XmtVwvseHtaeiZuiQS+gJKCijhJcVMOz9yg==
X-Gm-Gg: AZuq6aI0IHtOvAiOEvaBSVTh0NidGqeRtdFMs9aLnd0y0RxL8uAu2stpuu/AdCmGPag
 UHmZ8sNq1BpBIgXzgzQ16GoQ12kJhHyZgSn8RSR42500KFhWzNSCI7gkPs4J72I7EpjKngB8jQo
 dBaYZmJ6fD0kV4GNfYlwEsXNH+N16Hc4/D1P+ZVAWKfKn9fGv1oN63HE8e5gMyHMpKbM7VZR6wf
 Dkh656rmjKJITAdgWX0rdh7GBZWLSBsMi4QsN7xG7EqPW7873U4XLSn0mYMaTuZZfqlzw==
X-Received: by 2002:a05:690c:f90:b0:793:db81:f1dd with SMTP id
 00721157ae682-794398bb7f6mr30309487b3.4.1769188357323; Fri, 23 Jan 2026
 09:12:37 -0800 (PST)
MIME-Version: 1.0
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
 <4d1a883b-5465-45af-8dcc-eb905f552c29@redhat.com>
 <20260123114149.000065c5@huawei.com>
 <CAFEAcA8RFqO-U5ayU2u=dNhjHCj=1mJiAv26QihfqNfqQVq1Lg@mail.gmail.com>
 <CH3PR12MB75480D0CDE889070E1F4C448AB94A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <CAFEAcA_8Zd1_C+94wj2c+pJk3ebFT5_Zgt1Ww0qxzFqW=F98xA@mail.gmail.com>
 <CH3PR12MB75482DA817149816D5CD485EAB94A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <CAFEAcA_w=+RHygwsSQVvE6XU44d6+hgKy=bqdD08aBM5_xyn=Q@mail.gmail.com>
 <CH3PR12MB75481DCD5A4A890617429C55AB94A@CH3PR12MB7548.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB75481DCD5A4A890617429C55AB94A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jan 2026 17:12:25 +0000
X-Gm-Features: AZwV_QiXS-nKtKyX6L5SSG3GrmR-B1057OwswGmoT5KWlW6HgSTNLHq9rokg4po
Message-ID: <CAFEAcA-jxKnmD=8A8b5Rur0F1+_5w+JHY2yjkZQvD4wbhMwvkw@mail.gmail.com>
Subject: Re: [PATCH v8 00/37] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Eric Auger <eric.auger@redhat.com>, 
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>, 
 "berrange@redhat.com" <berrange@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen <nathanc@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, 
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>, 
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, 
 Krishnakant Jaju <kjaju@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, 23 Jan 2026 at 16:59, Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Peter Maydell <peter.maydell@linaro.org>
> > Sent: 23 January 2026 15:48
> > To: Shameer Kolothum <skolothumtho@nvidia.com>
> > Cc: Jonathan Cameron <jonathan.cameron@huawei.com>; Eric Auger
> > <eric.auger@redhat.com>; qemu-arm@nongnu.org; qemu-
> > devel@nongnu.org; Richard Henderson <richard.henderson@linaro.org>;
> > Jason Gunthorpe <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>;
> > ddutile@redhat.com; berrange@redhat.com; clg@redhat.com;
> > alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> > <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
> > jiangkunkun@huawei.com; zhangfei.gao@linaro.org;
> > zhenzhong.duan@intel.com; yi.l.liu@intel.com; Krishnakant Jaju
> > <kjaju@nvidia.com>
> > Subject: Re: [PATCH v8 00/37] hw/arm/virt: Add support for user-creatable
> > accelerated SMMUv3
> >
> > On Fri, 23 Jan 2026 at 15:33, Shameer Kolothum
> > <skolothumtho@nvidia.com> wrote:
> > > > stderr:
> > > > acpi-test: Warning! IORT binary file mismatch. Actual
> > > > [aml:/tmp/aml-7QQVJ3], Expected
> > > > [aml:tests/data/acpi/aarch64/virt/IORT.its_off].
> > >
> > > Any way to retrieve these files?
> >
> > They aren't in the "job artifacts", but you can probably do
> > a patch to tweak the CI job to add them, push to your own
> > gitlab fork of QEMU to have it run the CI, and then look at
> > the results.
>
> I forked your QEMU GitLab repo and pushed my series here:
>
> https://gitlab.com/shamiali2008/qemu/-/commits/target-arm.next-smmuv3-accel
>
> However, I am not seeing any CI jobs running on my fork. In the settings it
> shows no assigned runners under Settings CI/CD/Runners, so it looks like
> CI is not enabled.

You don't need to fork my repo, you can fork the upstream
QEMU one. Things aren't set up to run CI by default because
it would use up your gitlab CI quota. The docs on how to
do this are here:
https://www.qemu.org/docs/master/devel/testing/ci.html
-- you want to push it with the QEMU_CI=1 or =2 settings
to get it to run the CI. The docs suggest a git alias
that you can use to make this simpler.

-- PMM

