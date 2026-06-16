Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22378CD98EF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZEk-0005Io-Q4; Tue, 16 Jun 2026 15:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZB2-0000wa-RM
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:10:28 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZB1-0002YI-2j
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:10:24 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6611669cd16so5266740d50.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781637022; cv=none;
 d=google.com; s=arc-20240605;
 b=ZCioq3HNyc/vLDYWENQUrBihrSbR+N2UBWOFQCO7sLoDLmXcQe6kdV0/7JvnYq1hVw
 xqY9X3XQHBvTQ244n6Nr4ojUfWZR64a99YwktUlVbVU6GcGIgOH78Frv9qFZDpP45TCO
 Y81JOR7XXe1cGdi6drF3hNXhPqWuhe1rbEbjSTJgySDTkTNuXkodhLv2EaMc/zoKDCjm
 J5guTpmJO/7f1cpO2ILDAKJv9CfvMZwCB1HDEy8/I7x9v7Erg44BXRoCXmEmMZUxCE1/
 wrH04GY2GFj7W4NKgGU1RponsvOl/jPcVA4i04YuKDM4zhuxdDhqvUyUePcdB+yd1Ayd
 JYDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zt1u5yo8KpsvoBi6Lkm6pYSEdByUzcnyDFZX+BWoIDc=;
 fh=KAb1cMWmhAbDQDLO5e1PIj0cHh/E0CyMJAya4dH/PKw=;
 b=WxvIDVbxQJsdVZ0yHle7iumICf8eKRqtXIK8afkHazJuYlqB/QGJPpvEvggf9QSJNi
 UTxxAXVcgX3Nlm3j7F72No2R60YMaxRC+LdEZ1N91Bd+6SozqHVMM95VRX9EW/VfHCDv
 PkCQFtqmWBGX4pEVfrcVkgarTjzRaVGSRxKxgdDqPPTKq0UokW6+8vApnEhLLxmzEQE0
 rOzCZa1enHreeafMjP54tyI8anVO1H0/tSIz20/Yvb5hxZB2hT4lx3hd6IfyE9hMyzCn
 kUaFfIc9akSeJ4IBYsS701fj+xkyIrs9B5Jvpbzwy/f2dC3XLP1hd4lM0dAXCC2UGvMv
 cg/w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781637022; x=1782241822; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zt1u5yo8KpsvoBi6Lkm6pYSEdByUzcnyDFZX+BWoIDc=;
 b=xfzneVOYT0zH3TLhFInng2uN8B+JYDna+a+LM7ltR5SJSxA3kiERKJfCjvOH0ILqo1
 OCHxfTbjbZQQr69om8griJwJMJHOjK8XJ8A5Ka2/0XfGWCscvuX5JE7rdL8hArX/k9Vx
 f0VBmNumqPAeejrIjWuUqh00JGyczFOfdDpo8a3TcYu6ZiT3ZbMn+2VoWOATUpTXG+i6
 KYhbdcjX6w0VWJyAJLMwyPvpV2rAbDg/jHGq/kgCULca6WpO8iAu1A+IghLUkPbef2o0
 RRlfZYDl8f8m4jW1/stBaxBRU00gleKlYuj0Nw/J57APhg8/HZ0X3j8SUPkZgB25l0lY
 Y4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781637022; x=1782241822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zt1u5yo8KpsvoBi6Lkm6pYSEdByUzcnyDFZX+BWoIDc=;
 b=UEUylFmk2RoL0oC88H/kboowOQmbI8G6Dm6C+CbnRBzUTxdrMajl971FWBsDcRhK86
 UCzaXyCP9IGvPKYTK53JJTeIJxFAc8n8XQzNrr9NvbV8SCgFb/FKgM2Ypy2JuTKiGNNE
 xVb8Mvh5uiC2ZfxPfhbrUYk45BEGNXtvoToiH+bVBoP8ACLQGg9bPviZZbwA+/6yYYt0
 PgPpgyEscCrM+Lmf28s87MBOzUwcZ4o3xXb8fsqzgrePsG7iddWPmbMdTmEKR6/W9Bp2
 EKWLBhFVdctLvwWHSS/IKOF/A5JWBPmfYmBIW3/84xvYpfOWAxhPT5wmvo9nwGHB9JSq
 74TQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8E976y3Yi9lZuZPi8uISjDqquLOPOEkd88zxBUwXcFt1ORcuG+lv2ZgJJPKcxdJqEOJJPBTu/oibZu@nongnu.org
X-Gm-Message-State: AOJu0Yzgo0tDyO1WhL9DGioIudXD6nH6oun81BQRfDBWn9q3AIA0qDw6
 ScE31WFYzWTg8RuqyWPYeyZY821Joz29u76KEB3gscTNpCprddgEnrsgX6qY7EGpIlF8kQ4Dvo/
 2Jwz0x7U3DcbzZXnm5BB1/wpAcRz4pxc6UWkCfdktmQ==
X-Gm-Gg: AfdE7cnwcdn7VasdfA/D7BScau7rbRcCV8XVlDg9iD2dX71UUSNSPH6pBCIYNESa+Y3
 ga05PpNPHT6uTU06n3nEQd+oqFVhYMx55nVWHAMc259fK+GIyv+PD+RMf320bNs3cWCO3IqVgAW
 yU+x+c4XVIcF4nWcJkbtTKLjKK0RK5f1NlDQ2Nvx/FSUrrtXTZPk9UeXS28cyy9s3rPAyu8bmjD
 3IXVnULEoBk/GXBZjKAV2KmXIoooUNmBb7qXj5BL/X159UHPaj1vdKiWjtFYYD+6leSBvbDjZ0Q
 75F3u7HCr+m97kl8ILu0tWXtLhmRTu7C2QTngNDjOBMmtfY53UdTh7EJ38dvBZ+tPgA=
X-Received: by 2002:a05:690e:43ce:b0:660:9441:9e71 with SMTP id
 956f58d0204a3-662cbc8219bmr432669d50.37.1781637021808; Tue, 16 Jun 2026
 12:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
In-Reply-To: <20260609112552.378999-1-skolothumtho@nvidia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 20:10:09 +0100
X-Gm-Features: AVVi8CcFb-wu-HtHG00MzUT_0etC8PCflRyVOVD26ahu-isHgbvRZBK5fHj0aOA
Message-ID: <CAFEAcA_c_g+Kw_vz7A4D8oQV5fwvcg00gagQ9Ph4_S1dntBFwA@mail.gmail.com>
Subject: Re: [PATCH v7 00/31] hw/arm/virt: Introduce Tegra241 CMDQV support
 for accelerated SMMUv3
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com, 
 clg@redhat.com, alex@shazbot.org, nicolinc@nvidia.com, nathanc@nvidia.com, 
 mochs@nvidia.com, jan@nvidia.com, jgg@nvidia.com, zhenzhong.duan@intel.com, 
 kjaju@nvidia.com, phrdina@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Tue, 9 Jun 2026 at 12:27, Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>
> Hi,
>
> Changes from v6:
>  https://lore.kernel.org/qemu-devel/20260601114221.457995-1-skolothumtho@nvidia.com/
>
>  - Addressed v6 feedback and picked up R-by/T-by tags. Thanks!
>  - mmap the host VINTF Page0 at IOMMU_VIOMMU_ALLOC instead of on VINTF
>    enable (patch #14)
>  - Reset the per-VCMDQ Page0 cache when a queue is freed (patch #19)
>  - Distributed the reset teardown into the patches that introduce each
>    resource (patches #18, #21)
>  - Added a VCMDQ readiness helper and renamed the Page0 backing-pointer
>    helper to vintf_lvcmdq_ptr() (patches #18, #19)
>  - Trace the VCMDQ Page0 backing, hw vs cache (patch #19)
>  - Renamed patch #24 to reflect the changes accurately
>  - Updated the design and lifecycle documentation (patch #30)
>  - Based on top of Nathan's "Resolve AUTO properties" v6 series [0].
>
> Please find the complete branch here:
>  https://github.com/shamiali2008/qemu-master/tree/master-vcmdq-v7-ext
>
> Sanity tested on NVIDIA Grace. Further testing in progress.
>
> Feedback and testing are very welcome.



>  hw/arm/smmuv3-accel.h         |   48 ++
>  hw/arm/tegra241-cmdqv.h       |  384 +++++++++++
>  include/hw/arm/smmuv3.h       |    3 +
>  include/hw/arm/virt.h         |    1 +
>  include/system/iommufd.h      |   17 +-
>  include/system/memory.h       |   21 +
>  backends/iommufd.c            |   64 ++
>  hw/arm/smmuv3-accel-stubs.c   |   12 +
>  hw/arm/smmuv3-accel.c         |  194 ++++--
>  hw/arm/smmuv3.c               |   10 +
>  hw/arm/tegra241-cmdqv-stubs.c |   16 +
>  hw/arm/tegra241-cmdqv.c       | 1119 +++++++++++++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c      |  127 ++--
>  hw/arm/virt.c                 |   37 ++
>  hw/vfio/iommufd.c             |    4 +-
>  hw/vfio/listener.c            |    6 +
>  system/memory.c               |   10 +
>  backends/trace-events         |    4 +-
>  hw/arm/Kconfig                |    5 +
>  hw/arm/meson.build            |    2 +
>  hw/arm/trace-events           |   11 +
>  hw/vfio/trace-events          |    1 +
>  qemu-options.hx               |    8 +
>  23 files changed, 2024 insertions(+), 80 deletions(-)
>  create mode 100644 hw/arm/tegra241-cmdqv.h
>  create mode 100644 hw/arm/tegra241-cmdqv-stubs.c
>  create mode 100644 hw/arm/tegra241-cmdqv.c

Hi -- I just noticed looking at this diffstat that it does not
make any updates to the documentation to describe this
new feature. Please could you add something (e.g. to
docs/system/arm/virt.rst, or elsewhere if more appropriate)
that describes whatever this new thing is and how to use it,
in terms that make sense to somebody who isn't deeply immersed in
the SMMU and this Nvidia specific bit of hardware ?
You can do this as a followup patch, as I've already queued
this series.

Also, a bullet point for the Changelog giving the short
summary of what the new thing is would be nice. This
cover letter was too cryptic for me to be able to guess :-)

thanks
-- PMM

