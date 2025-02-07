Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948D0C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 17:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgRgt-0001cU-Ny; Fri, 07 Feb 2025 11:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tgRgs-0001bc-5R
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:58:54 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tgRgq-0006E4-I2
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:58:53 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e5b107c4346so1879338276.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 08:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738947531; x=1739552331; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lqiveB9osXI8XARFYdujgt/1317iAppaAA9K/dytfNw=;
 b=Vdt/tc6VcRN/kGueVQ4ACjzgUZWgSfNA+vFG33FA944SQ0yK+TEAArqWdzWk4I/ggj
 xqVodAXMI0cGPwOanppuf/4lOXBuKtXWyzOXybgWbC5VpXJz4WCfi4RZLlNkwuri0+ZA
 V/ESszHXw/9QwB1KDIZqdcDeRddlbp8dqEvvhGhuKqpDXpBFEY2kAlar/R/f7ZqAd7Yu
 Pm8C/Kd+l4xhIFt8/tM1A/nMNuLao+8w2Sz8MCJL1w/UbKB5lpNQOUIp94l2nAh5fp/t
 j+3owrmFZyv7BUSk+Z3PlAxuey2zOaRxBjmevamMG+fX9tH4HBDeMJicSJ4639Yhdwtb
 JvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738947531; x=1739552331;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lqiveB9osXI8XARFYdujgt/1317iAppaAA9K/dytfNw=;
 b=cKe6ZLbe5GpcPz+nxIxW8qFW3xofhi12nPNgq9HDvbGCmP1k2Pupt/0vDYok3N4A7h
 SUPGmtsTNKmu9bQ9kYY3pgJ9UOnsRWLl2nBQmCfhKfzxZtF0yr2p5bEyaloES6jjyBPc
 b4gW0w8RD3rdIJp2iwo88ZaDKT85PUaWO9Pca26NfsZvuAYFHZHz6CrO5iPrbJlhJn1F
 FJvsuq6yS59+2cc1Zwb9n2fAJWTt5xLAJmMEEJFRRQib+1G7+uMBFGXSpwnOT63LPQ6g
 phZYyDDntjUsjEmhsQhhwAIqG3rjn+CKbdERrjQQsj8/Y0y7QnaYzOSIhCuLr8TI7f+d
 9cJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWjlj+LO4kZO1TDgl73XwsxzuTO+Qr9BVKXBM3bRXN7f9GtSpnRyIFzPUSQUmUe7pAtF0DxQ7uQBF2@nongnu.org
X-Gm-Message-State: AOJu0YxIVrdWy0rCwbAfos4KopqA1/wPdjn3D6LWeU//Ro2DARzLFwte
 xZILTb/oYDw/Kl2GF7VQ/TWX9dlfLJCHI3iSaGf0djAyCSkVKo2YJWStjea2XxVDqncJAWR/0oT
 bOzT+mvsV1zWtoiQkIa9KLv/Ar7Lax8nYIMhmVA==
X-Gm-Gg: ASbGnctaiE/n91ZYQZs1/X5S50/+9axsP3IkyClN54ZOccbZQhIN8u5a6viK9rvALoa
 eLFWceBTnihOWcIBjdxBMmaan9E8V4rb2dR+hRQxDH/8otLATDq7aG5irD63D5pUZ+kYfkUtqpg
 ==
X-Google-Smtp-Source: AGHT+IEUS/FPK2OBKKJJcX1ajxFP8zY6sHEl+WxjMUlHz7eO6RT0R8KK+YTMt1obvE8jm7pXQKfpmU/Le0/MjXkYPZI=
X-Received: by 2002:a05:6902:2682:b0:e57:fd58:ad51 with SMTP id
 3f1490d57ef6-e5b46176227mr3076012276.1.1738947530971; Fri, 07 Feb 2025
 08:58:50 -0800 (PST)
MIME-Version: 1.0
References: <20250206142307.921070-1-eric.auger@redhat.com>
 <20250206142307.921070-5-eric.auger@redhat.com>
 <CAFEAcA_LgrBRbafVQ0vLGPd8xG=wsLjWnKTJ2JSEREYUqgRQBQ@mail.gmail.com>
 <7102d470-ac72-4c02-b8bc-20f1379a4843@redhat.com>
In-Reply-To: <7102d470-ac72-4c02-b8bc-20f1379a4843@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2025 16:58:39 +0000
X-Gm-Features: AWEUYZn8C8vUHzllJmbOc_heUb0gKDMG_YpbjTi8jXw7jhfGEEwsVKT-MCiG41o
Message-ID: <CAFEAcA-XK5GwT0b_Ff-8fYnWcDgzaE-0Ei-YqDoXv-aXFGNXUQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] hw/arm/smmuv3: Move reset to exit phase
To: eric.auger@redhat.com
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 mst@redhat.com, jasowang@redhat.com, imammedo@redhat.com, peterx@redhat.com, 
 alex.williamson@redhat.com, clg@redhat.com, philmd@linaro.org, 
 zhenzhong.duan@intel.com, ddutile@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Fri, 7 Feb 2025 at 16:50, Eric Auger <eric.auger@redhat.com> wrote:
>
>
>
>
> On 2/7/25 5:37 PM, Peter Maydell wrote:
> > On Thu, 6 Feb 2025 at 14:23, Eric Auger <eric.auger@redhat.com> wrote:
> >> Currently the iommu may be reset before the devices
> >> it protects. For example this happens with virtio-scsi-pci.
> >> when system_reset is issued from qmp monitor, spurious
> >> "virtio: zero sized buffers are not allowed" warnings can
> >> be observed.
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> ---
> >>  hw/arm/smmuv3.c     | 9 +++++----
> >>  hw/arm/trace-events | 1 +
> >>  2 files changed, 6 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> >> index c0cf5df0f6..7522c32b24 100644
> >> --- a/hw/arm/smmuv3.c
> >> +++ b/hw/arm/smmuv3.c
> >> @@ -1870,13 +1870,14 @@ static void smmu_init_irq(SMMUv3State *s, SysBusDevice *dev)
> >>      }
> >>  }
> >>
> >> -static void smmu_reset_hold(Object *obj, ResetType type)
> >> +static void smmu_reset_exit(Object *obj, ResetType type)
> >>  {
> >>      SMMUv3State *s = ARM_SMMUV3(obj);
> >>      SMMUv3Class *c = ARM_SMMUV3_GET_CLASS(s);
> >>
> >> -    if (c->parent_phases.hold) {
> >> -        c->parent_phases.hold(obj, type);
> >> +    trace_smmu_reset_exit();
> >> +    if (c->parent_phases.exit) {
> >> +        c->parent_phases.exit(obj, type);
> >>      }
> > If we need to do something unexpected like reset
> > register values in the exit phase rather than the
> > hold phase, it's a good idea to have a comment explaining
> > why, to avoid somebody coming along afterwards and tidying
> > it up into the more usual arrangement.
> sure
> >
> > If I understand correctly we need to keep the whole IOMMU
> > config intact until the exit phase? What's the thing the
> > device behind the IOMMU is trying to do during its reset
> > that triggers the warning?
> The virtio-pci-net continues to perform DMA requests and this causes
> some weird messages such as:
> "virtio: bogus descriptor or out of resources"
>
> Also VFIO devices may continue issuing DMAs causing translation faults

Hmm, right. I guess this only happens with KVM, or can you
trigger it in a TCG setup too? Anyway, presumably we can
rely on the devices quiescing all their outstanding DMA
by the time the hold phase comes along.

(I wonder if we ought to suggest quiescing outstanding
DMA in the enter phase? But it's probably easier to fix
the iommus like this series does than try to get every
dma-capable pci device to do something different.)

thanks
-- PMM

