Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29D5D7832E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 15:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI7vJ-0007pS-GV; Mon, 02 Dec 2024 10:01:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1tI7vG-0007on-4P
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 10:01:15 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1tI7vB-0007ui-Ox
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 10:01:12 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-53df119675dso5185498e87.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 07:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733151667; x=1733756467; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QHUKdkjH1ExuAKJHwOZ2wBGvPuCPG/YW+zEyhB5n//Y=;
 b=SXfaD8zoalzFoeo5Xye5DCdxT0hZwquPZw11HeBhiY1oJZJ9wkJ0WJ9N1WCrA1WbD6
 SDe67J8KsySctHWsJHBZmCUKsw0zZl1h1MnfNaBYZs8tgh5ZNmscvEKrn0rz6W8pWSCF
 3lcaIhlnGmMm7MnBG39HAgkxo6zbBKryMC4TjblAS7N9kUNLGyXVmxxcYY4TJm4XaimP
 98U9BT0T6Sp4faRJ7eTPUDS1QXNmaur4+1gkoU7E+GxkGMtrgcRxQ85NAkWaTM53Eqnk
 YKHit9g/nrF7GKwlu5l8BVXSnEeVJbZ+GM5DZkHc/Fo43iPkWjhEpZVUDQISKl4z0gd4
 70Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733151667; x=1733756467;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QHUKdkjH1ExuAKJHwOZ2wBGvPuCPG/YW+zEyhB5n//Y=;
 b=R43O6DEP8qIF5ssloptGr7CNVZcYasz0XWnG28AUvMhtj616aEG9S0cY6h47xIxdhl
 RsFBxxdFE/m9l2p1Sdvt8PUb/B40sVfIuf9ntJu2MZth51Y42xrc1+Lqqn9Qtnqwf4zB
 qTaAIJuF5F2TBavbFm3rP8EFJABNUlCOnJiSi+s4BPrnHNFnIcfL19voTRBoT7iyMmlS
 mL84oof1r+HHHjqO1wo8dhqY6eeiXluwZUQjboR4YW1WsMvCgsw4SxbvmWoU6yvhpT7B
 XYAClE7F8wohtwoNK9kIBqj3wDlIODOhQs4mKrHcjkHUaYt81m4q5dN0QeAeNMi2R/MP
 rsCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURRyhF4WdP9KEcTnCyP6dU+r7DNqrX0/wtVcPNJKiWR0qv1Pg67bGoJTe7uPPZD1IclrFPlIpUg0Ed@nongnu.org
X-Gm-Message-State: AOJu0Yx259YDi4u5n7zFyFQvAZ7U/+yTZ2Dm1Pn1ban3M7oxDKnNrmr0
 H55QNIAw9Kyem9Auq67DBBXQtXV0DgHQGWe8Wpn113WEQt3FlQlywGyHbIX4d8tmIaXhR9L0ekM
 YKvvk8xqQb8UP+Hh9kgfkvhSSBBibyfPJEFZFAGKHS6fP4e+mBbtegZ9F
X-Gm-Gg: ASbGncsRNF6bZcVnbxGJysTYIiaNOB+zMnxwdPnh+u46HXHro2O/V7mcJU21LXJxgiA
 elBUDgbdk7gOtfn4YWTMk0W060X5dsA==
X-Google-Smtp-Source: AGHT+IFsMUm4A3RhVg2xwoeGag6BeOWfrfdprSVaJcQSW2GEuLyG97UeNpEh7iZzrNn+TCXCEGRtwaQ9gn8UeC+vu6U=
X-Received: by 2002:a05:6512:398c:b0:53d:ea3c:2ba0 with SMTP id
 2adb3069b0e04-53df00d12afmr13706971e87.16.1733151665962; Mon, 02 Dec 2024
 07:01:05 -0800 (PST)
MIME-Version: 1.0
References: <ZyRUcGKKS6NbIV5O@Asurada-Nvidia>
 <20241101115501.GS10193@nvidia.com>
 <CABQgh9E3ba1F_4bTxkzRmt0sDmyVR+hbxocnqSvrvwerFZwiug@mail.gmail.com>
 <8f9d105371be44f1a1f6ba0f268d8c68@huawei.com>
In-Reply-To: <8f9d105371be44f1a1f6ba0f268d8c68@huawei.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 2 Dec 2024 23:00:54 +0800
Message-ID: <CABQgh9FnTotT9N0tfRRbXn4WdHJVj7Zvi1aWz7=cWptEuGED3g@mail.gmail.com>
Subject: Re: nested-smmuv3 topic for QEMU/libvirt, Nov 2024
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, 
 Eric Auger <eric.auger@redhat.com>, Mostafa Saleh <smostafa@google.com>, 
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Moritz Fischer <mdf@kernel.org>, Michael Shavit <mshavit@google.com>, 
 Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "arighi@nvidia.com" <arighi@nvidia.com>, 
 "ianm@nvidia.com" <ianm@nvidia.com>, "jan@nvidia.com" <jan@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=zhangfei.gao@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 2 Dec 2024 at 16:07, Shameerali Kolothum Thodi
<shameerali.kolothum.thodi@huawei.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Sent: Monday, December 2, 2024 6:05 AM
> > To: Jason Gunthorpe <jgg@nvidia.com>
> > Cc: Nicolin Chen <nicolinc@nvidia.com>; Shameerali Kolothum Thodi
> > <shameerali.kolothum.thodi@huawei.com>; Eric Auger
> > <eric.auger@redhat.com>; Mostafa Saleh <smostafa@google.com>; qemu-
> > arm@nongnu.org; qemu-devel@nongnu.org; Peter Maydell
> > <peter.maydell@linaro.org>; Jean-Philippe Brucker <jean-
> > philippe@linaro.org>; Moritz Fischer <mdf@kernel.org>; Michael Shavit
> > <mshavit@google.com>; Andrea Bolognani <abologna@redhat.com>;
> > Michael S. Tsirkin <mst@redhat.com>; Peter Xu <peterx@redhat.com>;
> > nathanc@nvidia.com; arighi@nvidia.com; ianm@nvidia.com;
> > jan@nvidia.com; mochs@nvidia.com
> > Subject: Re: nested-smmuv3 topic for QEMU/libvirt, Nov 2024
> >
> > Hi, Nico
> >
> > On Fri, 1 Nov 2024 at 19:55, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Thu, Oct 31, 2024 at 09:09:20PM -0700, Nicolin Chen wrote:
> > >
> > > > FWIW, Robin requested a different solution for MSI mapping [1], v.s.
> > > > the RMR one that we have been using since Eric's work. I drafted a
> > > > few VFIO/IOMMUFD patches for that,
> > >
> > > I also talked to MarcZ about this at LPC and he seems willing to
> > > consider it. It took a bit to explain everything though. So I think we
> > > should try in Nov/Dec
> >
> > When boot qemu, reports this
> >
> > qemu-system-aarch64: warning: IOMMU_IOAS_MAP failed: Bad address, PCI
> > BAR?
> > qemu-system-aarch64: vfio_container_dma_map(0xaaaadd30f110,
> > 0x8000200000, 0x10000, 0xffffb8031000) = -14 (Bad address)
> > qemu-system-aarch64: warning: IOMMU_IOAS_MAP failed: Bad address, PCI
> > BAR?
> > qemu-system-aarch64: vfio_container_dma_map(0xaaaadd2bc310,
> > 0x8000200000, 0x10000, 0xffffb8031000) = -14 (Bad address)
> > qemu-system-aarch64: warning: IOMMU_IOAS_MAP failed: Bad address, PCI
> > BAR?
> > qemu-system-aarch64: vfio_container_dma_map(0xaaaadcf90000,
> > 0x8000200000, 0x10000, 0xffffb8031000) = -14 (Bad address)
> >
> > Will this also be solved in the new MSI mapping patchset?
>
> Nope. These are not related to MSIs. These mappings are required for
> P2P DMA between devices and is not supported by IOMMUFD at the moment.
>
> See the discussion here,
> https://lore.kernel.org/all/20220426103507.5693a0ca.alex.williamson@redhat.com/

Thanks Shameer

