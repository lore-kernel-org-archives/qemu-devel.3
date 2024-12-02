Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D34FD10DA0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 06:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHzYb-00064e-KF; Mon, 02 Dec 2024 01:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1tHzYZ-00063t-OC
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 01:05:15 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1tHzYX-0000za-4A
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 01:05:15 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-53dd2fdcebcso4200674e87.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 22:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733119511; x=1733724311; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GisRIIVFJOhNsOFfrYvIqLASrIH2WPDMnI3BEboU0qQ=;
 b=Ei/jTBY01wiMY81/POpRdnfBnKW9h2gHm5kHitHAhdQP8+MVZTqrQ+gMtkbzhIO7Nx
 eUcjtAbCtKHOc8w4nZaFCsojIGrvAZKXY1SBpSPCNfHqtaGHWf/NlFjNtS8N+2W0BcKS
 qFcdRjwkSO0+R/4+Oo8ucDzD5mDGKS3UM5ObwaOXn4pFanzLKYKGpYYckzHDSmL1p5Xv
 kHLLZcM7AaCyVmtDTGbUUcAWpKJ/bqBd97IGXuOKMx17iz0DkPN272i2sNgPn3uBQ1P/
 6sN85RplktKbkLUE2KJPLfDmeViA59nE8BRbW0rnH80Eu1RqVCmXpq9W9yrdUn7NyMGe
 hSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733119511; x=1733724311;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GisRIIVFJOhNsOFfrYvIqLASrIH2WPDMnI3BEboU0qQ=;
 b=DT6wlIKDy+1kdLaHi8kXarJ6ZUEPquEtP1ioB6UaXUCXCCINZ/VEIfUwNfvlf80jsW
 oZ16PsQCm7/h+yLsmtvsLYpOhlFpYlqLF55AtHMEt8kA9UGYLglMDMs2QyveKOkjgUuU
 Z+zpYy0SZRKUhxBN0iblaEQQxJdgPBQ4O7hiU69OuoEBIb1WHJ2tJwzohvs9FjZJgThx
 RmHmBjxrfx/rm+kEzy2FJZxsrbe4v0CcW3ev4wob0+uk2XSM9mpXkdUWwbrESqosopd2
 keEFNNag2iJCTRo7ns2zTMGhYC5Lt6hNJXtXo/O6UVLSfCzsNtzSaBBgS5yVfb/pQO1A
 vlUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6t7RngGeB0CN7jbWNx7CQjry2F/EXytlt4xduXTybQ1aalSDevN8pRPQvva1yp+eu8EUODLKC0VGo@nongnu.org
X-Gm-Message-State: AOJu0YzTCn5z7wqO+CZ0ZAh9qreKNCMiZnMv3fOoFSE4EqysTe5ItDv8
 Zup0xWs7gvk5bZHYpvhywMPZ8AllTwAkZDsYKCWsnAzZUGXipMKhJBny2O8XvUlKYReBouzyxYw
 8cuuOuu9KQ/UvhaAq2M8SlLMjIKaU4kQ5+fH0Nw==
X-Gm-Gg: ASbGncvJWM4nLxoFinub/RcDkWW7qlIQLcFtfQ8Xn/657nI+VV3MnTzH2xw3hfZvAlm
 2GNVU/WrLziTWQV+lavAXDmGpuMgPLw==
X-Google-Smtp-Source: AGHT+IHfo9w45R8AY9ijuZAOoYGY0sjCl4GYDdqD59pLe8hl6xMQSLhnHjwmX0EgBdU9Gl90ghPiCFh2l10MyS3et9Q=
X-Received: by 2002:a05:6512:3da9:b0:53d:cb91:2f3e with SMTP id
 2adb3069b0e04-53df00d1afbmr11467790e87.22.1733119510609; Sun, 01 Dec 2024
 22:05:10 -0800 (PST)
MIME-Version: 1.0
References: <ZyRUcGKKS6NbIV5O@Asurada-Nvidia>
 <20241101115501.GS10193@nvidia.com>
In-Reply-To: <20241101115501.GS10193@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 2 Dec 2024 14:04:58 +0800
Message-ID: <CABQgh9E3ba1F_4bTxkzRmt0sDmyVR+hbxocnqSvrvwerFZwiug@mail.gmail.com>
Subject: Re: nested-smmuv3 topic for QEMU/libvirt, Nov 2024
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, 
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Eric Auger <eric.auger@redhat.com>, Mostafa Saleh <smostafa@google.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Moritz Fischer <mdf@kernel.org>, 
 Michael Shavit <mshavit@google.com>, Andrea Bolognani <abologna@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 nathanc@nvidia.com, 
 arighi@nvidia.com, ianm@nvidia.com, jan@nvidia.com, mochs@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=zhangfei.gao@linaro.org; helo=mail-lf1-x12f.google.com
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

Hi, Nico

On Fri, 1 Nov 2024 at 19:55, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Oct 31, 2024 at 09:09:20PM -0700, Nicolin Chen wrote:
>
> > FWIW, Robin requested a different solution for MSI mapping [1], v.s.
> > the RMR one that we have been using since Eric's work. I drafted a
> > few VFIO/IOMMUFD patches for that,
>
> I also talked to MarcZ about this at LPC and he seems willing to
> consider it. It took a bit to explain everything though. So I think we
> should try in Nov/Dec

When boot qemu, reports this

qemu-system-aarch64: warning: IOMMU_IOAS_MAP failed: Bad address, PCI BAR?
qemu-system-aarch64: vfio_container_dma_map(0xaaaadd30f110,
0x8000200000, 0x10000, 0xffffb8031000) = -14 (Bad address)
qemu-system-aarch64: warning: IOMMU_IOAS_MAP failed: Bad address, PCI BAR?
qemu-system-aarch64: vfio_container_dma_map(0xaaaadd2bc310,
0x8000200000, 0x10000, 0xffffb8031000) = -14 (Bad address)
qemu-system-aarch64: warning: IOMMU_IOAS_MAP failed: Bad address, PCI BAR?
qemu-system-aarch64: vfio_container_dma_map(0xaaaadcf90000,
0x8000200000, 0x10000, 0xffffb8031000) = -14 (Bad address)

Will this also be solved in the new MSI mapping patchset?

Thanks

