Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4D6CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 09:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZPpV-0004Vd-FP; Tue, 16 Jun 2026 05:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZPpM-0004U9-7U
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 05:11:25 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZPpK-00057Y-Fu
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 05:11:23 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-662bf1dab83so267574d50.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:11:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781601081; cv=none;
 d=google.com; s=arc-20240605;
 b=H/ABBNoxQSzo0nPJ+k/173KkxER0jcdkfOoXYneDA8CAFNOAuDc9XfXkxdX3AyaWD4
 zIL2sx3zWk4rm3YOZ1WzSYXLssTt8P2/tU2PGBD9O6uI+GePqO4202X4hHSVsrqaLv7V
 LN7RZq2htxN0w9Fk8HH30IfoAX3GV09txhJXjBHatDj6FKPIPDaQn3dJlEsnK2qQtgqk
 LQ2sCbIPy1YXYS+2lHslo++Nz7lq6pQoOzOEjYy5rrsdXYRh0ZgAD4144xRoqVWvRkW9
 wSI0QpVqYvxNzwmU5R/+e9hxlGSVaeKRkHxTZ8XKq3sXFbEn6QpbpX2/7ROM0jIpFgdX
 6n2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=L0adLwwRq+XgATs97Jp6ZsqjH+7IFjtVVPKtKt1IDmM=;
 fh=NVzD5W2jwGENGBmCVOgCIrssA/JXe9bHEx2shrw9Z9o=;
 b=S/xwDgNVTIR6LOpZCvNreLibFr04Ww6xRMGcTYiUPHNu4htPFGxpB2/zF0DyXtJWxi
 o/fXQh+9+S/HmOXAq0acdO020waRZgS8jUgepX7Uzh9hUrbgLA9FGRzEakLtu0rFmyH3
 D9NZJ7r9T0IH8G5JYySCxFQIAwsHqYML5GDl1wtefu2BpNSkAmShiUFJ6EbcdG/9itFW
 KOzt4GlbBqVt2FmyPp2NzA0esWTJHVnP5WIGeEyKzDJRW83LXJERodyt0EPsyez0jt4x
 miCoC9VHIzlOmA2qMr07RL7kD9x+6taIEnm1jKmd7lwWjb2hjxyhi+/3yCgAiMR8KDuu
 xxFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781601081; x=1782205881; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L0adLwwRq+XgATs97Jp6ZsqjH+7IFjtVVPKtKt1IDmM=;
 b=MDjsG7Ju1DYfQMteU1qKVoMkQ3F1MpQKOyJC9pQ5VRO05fXt7YsFd/ReInsooxiX9d
 +1/Fed0oMLxRvTsRAcxrHdfvyjSLXgOUmY+216VISCYIqmV9oBafVS0glR9mW2HxDRsh
 umysa3x+7WaDGfU0C10YjK47+G5+LCOgv2UJM6er6cm3t8Ky5YOcOosljrUDQMGIXkKK
 XI+wyoDRs5d9w6H7lTTBbMq/oXkbvThZHdvIjLr4sH6dcBM5q8548pe7qhFmo6R0nA39
 H1RASKEQMs6lYBW5L1E4aHBCo6++QSQMGVHy+90eW3S7NPEjJwi/bZAEj/KCsr2RlwuN
 VbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781601081; x=1782205881;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0adLwwRq+XgATs97Jp6ZsqjH+7IFjtVVPKtKt1IDmM=;
 b=eRm+cKW9s/s6okN7Dk+X2jfIcKjsXd3NTt2lunFEnFgDWKCD4QkPhgyMkfJrFJJ9d/
 fP+0Ewp1WDPp2Mhsx3V7q5Q3GzVudmN+Lg7llkPzEjdMK+D+u0sJW7yhQR6UgGh/dC+N
 fDzGND2RYxRqGQy8n5TFnhDK4isOzoCBu2I7J+ZewWZV1nBuMsWZ3ucooovIPtBCLLY1
 6SrbhpYpndE+O5NqEuFGY6vdJbyG6DJ8Az4apCI9XBEoaL0YVzSjcmunrYKlvcq/GS7y
 iD2mBBoNANuxA8VFK0uTY4/RMLHtsuIIXifCXGZFwkAjlE/Ob4BXIPGCRVrd3MzvR37Z
 Ut2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9freP7iMw+91Y76SK826vLNHC97cVeuXq3xLmGF3lDjTIzjFPkQMu5POBvpsdTwIrUgVo6QUjy9ZUP@nongnu.org
X-Gm-Message-State: AOJu0Yw4xZ92ppcmB1bvdXy6S/Lfu7syX+tVqPKK1PzA7I0kwX/yys4Y
 fHZC1Ad+n/WpYY4aZ7yiLZ2uftv9u6Gz9hNHJVLgDJ8Mr0XchbTQKCYMMVWdPINyBkKc9F6A7qL
 D46OkiOx3nxaoCWj0fDihwWJiwhAVv5WbOvkw7NKMRg==
X-Gm-Gg: Acq92OFYpqmZ8rsCRi3JrRaPxa0ZUs19Dv/XLJcW0TOpTeE8MwewWyOQHICTnI78ZSA
 b7Jrf+CVS9zULZC+374YWMqeTT7DteUnLRa7eGQHS7BulHA550ZA4k+1Vp7j/IDlJbeDYls+YyX
 S9N4OFGgx2RG21ACwxm7LuryP6EcH2VB9i56PFBPIVdjqQLR/ZR5pV+6zx5fYNi1U+pV2cjF+C2
 ljXlX25XDwpwTrqrb5CAW3NI8DULeNHIRiMefSNIx/BMIcvpsOlg/t2AjLMFQRmKto8I6htG8pO
 tmCzXIFiKZgSX8H/QbIm3t8BYw8/MNFd0mkCKvAm1zNDHagc7GZEwyAGtEy41V0lkiI=
X-Received: by 2002:a05:690e:4384:b0:660:6441:d041 with SMTP id
 956f58d0204a3-662850c23camr10544400d50.39.1781601081395; Tue, 16 Jun 2026
 02:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
 <79e43ff2-00fb-4cab-ae8a-21e5fb23d8e7@redhat.com>
In-Reply-To: <79e43ff2-00fb-4cab-ae8a-21e5fb23d8e7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 10:11:08 +0100
X-Gm-Features: AVVi8CcEKc8eksUBKud53I6Ko-HiYZy8MP2zfij8wAvv6o1FaUgi-aDX7-uCQY4
Message-ID: <CAFEAcA8F-0Rj-=uhfpdkP=K6yO-++uVDzB0zwWBbYeagDgWcyQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/31] hw/arm/virt: Introduce Tegra241 CMDQV support
 for accelerated SMMUv3
To: eric.auger@redhat.com
Cc: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 clg@redhat.com, alex@shazbot.org, nicolinc@nvidia.com, nathanc@nvidia.com, 
 mochs@nvidia.com, jan@nvidia.com, jgg@nvidia.com, zhenzhong.duan@intel.com, 
 kjaju@nvidia.com, phrdina@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Thu, 11 Jun 2026 at 16:52, Eric Auger <eric.auger@redhat.com> wrote:
>
> Hi Shameer, Peter,
>
> On 6/9/26 1:25 PM, Shameer Kolothum wrote:
> > Hi,
> >
> > Changes from v6:
> >  https://lore.kernel.org/qemu-devel/20260601114221.457995-1-skolothumtho@nvidia.com/
> >
> >  - Addressed v6 feedback and picked up R-by/T-by tags. Thanks!
> >  - mmap the host VINTF Page0 at IOMMU_VIOMMU_ALLOC instead of on VINTF
> >    enable (patch #14)
> >  - Reset the per-VCMDQ Page0 cache when a queue is freed (patch #19)
> >  - Distributed the reset teardown into the patches that introduce each
> >    resource (patches #18, #21)
> >  - Added a VCMDQ readiness helper and renamed the Page0 backing-pointer
> >    helper to vintf_lvcmdq_ptr() (patches #18, #19)
> >  - Trace the VCMDQ Page0 backing, hw vs cache (patch #19)
> >  - Renamed patch #24 to reflect the changes accurately
> >  - Updated the design and lifecycle documentation (patch #30)
> >  - Based on top of Nathan's "Resolve AUTO properties" v6 series [0].
> >
> > Please find the complete branch here:
> >  https://github.com/shamiali2008/qemu-master/tree/master-vcmdq-v7-ext
> >
> > Sanity tested on NVIDIA Grace. Further testing in progress.
>
> Successfully tested on Grace-Hopper. Feel free to take my T-b:
>
> Tested-by: Eric Auger <eric.auger@redhat.com>
>
> All patches are now reviewed. Peter, please consider pulling this if you
> are satisfied with it, in addition to
>
> [PATCH v6 0/9] hw/arm/smmuv3-accel: Resolve AUTO properties <https://lore.kernel.org/all/20c8948f-1933-4410-96fc-10a2d53cb40a@redhat.com/#r>
> [PATCH v2] hw/pci/pci: Enforce pci_setup_iommu_per_bus() is called only
> once per bus

Thanks for doing the testing and review; I've applied this to
target-arm.next (after those two other patches).

-- PMM

