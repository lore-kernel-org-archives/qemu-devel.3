Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AB1CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 08:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMiN4-00086E-Hh; Tue, 12 May 2026 04:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wMiN3-00085z-7U
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:21:41 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wMiN1-00016J-0C
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:21:40 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b936331786dso656878266b.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 01:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778574097; cv=none;
 d=google.com; s=arc-20240605;
 b=TSbNsD9tUngz2/W7cbFmi8mIXFEY6NWSiEoeXT5XbQNcq3YfuiKCXB6UmJ31eEtKZP
 o+dYA5GYDtb9PPch3T0Bl6vQE9MbH0KVx6uNvXrgEbgEOXYN/86USkpsZCfA9qfFdisr
 hf6ejNRR0u5uO3YrPe6/y27OKuuwsZ+ROd6JAJRBFTvMsxljUiTwIwHFgIPKtM4bo1yS
 Jk/5luMuxBvMcfk1OhNJIRMIu5Y9jXmPTHRzLatgQ353ebeHL6bnDJ8rS3PWk4YUsb5T
 TqpP7RTzADWB5rY1Qv1sYG9v7HMehQksUI61RIqPcZ5aty8AA9vZafK3gqFcrq88xGsL
 C1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uUOxGd80AnLF6YbB2SO1qPOc6FbMqLxCbZaTqgxmuhk=;
 fh=c31XcMlvyGc0XUCc8nwdRkMfWOIlvv4COTwpPi8qTnE=;
 b=bk08ooHS6J0FHAEbOZSh63gRrR2zHPC+hQ3OnyZxeMFSedvs9o5oPqixZUX0nqcelu
 HKA9POg9q4dJhXQidVOJcsvP9+1ROI2L7lFeQW3xZg+aJ3BqeefgQxnlymb072KXpEjp
 km+TZPCu7LAU2E69zFu7DZyqIRdvFRprMvuepJWGaJUqCrh8SaFz+KOkkLaBwlkgS2+8
 M6VNHytKQs9bBOqHc3BvaE1fBVi2jZL2C7bywSZep7hbl42NZ6SgUlpkKL8b7InpJeHt
 0hUkK74gGRDdA8PlH5IGw2JKDmsI6owPTi8TSFH8EGhZInfMT1fZ0nyzZ5zRwEjp43fY
 CS1w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1778574097; x=1779178897; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uUOxGd80AnLF6YbB2SO1qPOc6FbMqLxCbZaTqgxmuhk=;
 b=Gz/YluKegsN60AYrpMaNIkHUhjcIE1zx/ElqDU4YnPuLM8hApy5WJkrc5F8CCodle4
 H5yZqAU0nSkjoUuxPEJ6U+FwjCDt7VgfJZrVk/8monacUKpyNSzaBL+YVNsG3OQsaZdC
 todChF32pM47Ti+4iFkWfbDI8LW9raR+ziQa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778574097; x=1779178897;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUOxGd80AnLF6YbB2SO1qPOc6FbMqLxCbZaTqgxmuhk=;
 b=en5V5wPsRT93nUtJtZvQULRHQsLi6M0ePR8w+5d8zp6OUNKbmbmEqkz+N/qKkON0gD
 eqlentB23CAsXAZ7bnYhE3RamiLkyVubYs2XG+1H3l9mUAQ5PuM4RV6hCjAUxTemxgaS
 6L3WXKT7tpuKM/XYl2OYpBaR1CRepbGD2qSQvkxo8/W+GsljbH5nOi0oYbXTF2xG3NG8
 LCv/LCAcG6ApQ5u1RhEQwGzK2xwSfXbSmuhc5IzoFqPEqqQeF2M7pKTKyZdy1u1cGjV7
 gEMv15ibizLebzHFmyl61E2+48ArPUmrEqrI1kingUHFr67KmkJw+waHSIBbrUAgBKcQ
 xuDQ==
X-Gm-Message-State: AOJu0YzwqXOtQGXu5iS3g2gg36wuVmiE9uFzf6x5fH+SvA1j83EqBJYj
 TcNHK839NFUs/ZY1IP7Nl+NVNo3bIUy4o03DsZGrRS/57vMYyUHFDBdzon48C6+eUgjCQgiMaQX
 VtzlHhgAKebyWUpAyxonED8e3mDUV8ikUYd6yj3sB6g==
X-Gm-Gg: Acq92OFNqaDZMW5JaQG2G2pJNVP1/pnwEuek8YSwIYfUULKYeN1KM2ZSUY0/BGlK4KH
 yMaAwXXpl5KhnQVB2M8xjQW1zFoQcqmHiS5GigtvO2I/dHoxsW1VNAiZ1AjkQgaohjqajg4n+eX
 9OHyQKZZL9FEmcaiK7Q9WVdM1MsEmA+efzD4t4hjpBzivOyfSHFGMSiigsK5Htfs1Nsn+3Wn6RJ
 YCAzrgUO0MdPntdiobSRP9Kts7/YdFxhyICuU/ydWMEY+X/9UZJrf25m1bKMyilYp5ygBhSWGb1
 6SnEEk7LSvXPNVHsZC4PHFHlYa8ZB1qAALQ2A3Y=
X-Received: by 2002:a17:907:d18:b0:bd1:e34f:8364 with SMTP id
 a640c23a62f3a-bd1e34f895amr280816166b.36.1778574096865; Tue, 12 May 2026
 01:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260511151131.483217-1-alexander@mihalicyn.com>
 <20260511175944.GC536999@fedora>
In-Reply-To: <20260511175944.GC536999@fedora>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 12 May 2026 10:21:25 +0200
X-Gm-Features: AVHnY4L-gpeGbRgJRS0C95moxiUHqosngP2u9omyaob8T5Fvu9HO8XTC3Rqqgsg
Message-ID: <CAJqdLrpyJCS_GRYxZ11dAvAAPf9T=_ZqeUmv97Nv4Vqrtu2NDQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] hw/nvme: add basic live migration support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 Klaus Jensen <its@irrelevant.dk>, Zhao Liu <zhao1.liu@intel.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x633.google.com
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

Am Mo., 11. Mai 2026 um 20:00 Uhr schrieb Stefan Hajnoczi <stefanha@redhat.com>:
>
> On Mon, May 11, 2026 at 05:11:23PM +0200, Alexander Mikhalitsyn wrote:
> > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> >
> > Dear friends,
> >
> > This patchset adds basic live migration support for
> > QEMU emulated NVMe device.
> >
> > Implementation has some limitations:
> > - only one NVMe namespace is supported
> > - SMART counters are not preserved
> > - CMB is not supported
> > - PMR is not supported
> > - SPDM is not supported
> > - SR-IOV is not supported
> >
> > I believe this is something I can support in next patchset versions or
> > separately on-demand (when usecase appears).
> >
> > Testing.
> >
> > This patch series was manually tested on:
> > - Debian 13.3 VM (kernel 6.12.69+deb13-amd64) using fio on *non-root* NVMe disk
> >   (root disk was virtio-scsi):
> >
> > time fio --name=nvme-verify \
> >     --filename=/dev/nvme0n1 \
> >     --size=5G \
> >     --rw=randwrite \
> >     --bs=4k \
> >     --iodepth=16 \
> >     --numjobs=1 \
> >     --direct=0 \
> >     --ioengine=io_uring \
> >     --verify=crc32c \
> >     --verify_fatal=1
> >
> > - Windows Server 2022 VM (NVMe drive was a *root* disk) with opened browser
> >   playing video.
> >
> > No defects were found.
> >
> > Git tree:
> > https://github.com/mihalicyn/qemu/commits/nvme-live-migration
> >
> > Changelog for version 7:
> > - rebased on top of recent main
> > - addressed review comments from Stefan Hajnoczi:
> >   - better incoming migration stream validation (SQ/CQids correctness)
> >   - endianness bugs are fixed in qtest (validated on s390x)
> > - added RWB tags from Klaus
> >
> > Changelog for version 6:
> > - rebased on top of:
> >   https://gitlab.com/peterx/qemu/-/tree/vmstate-array-null
> >   (see also https://lore.kernel.org/all/20260401202844.673494-1-peterx@redhat.com)
> > - addressed review comments from Stefan Hajnoczi:
> >   - supported "full CQ" case by serializing NvmeRequest state
> >   - added qtest for NVMe device migration with full CQ
> >
> > Changelog for version 5:
> > - rebased on top of https://lore.kernel.org/all/20260304212303.667141-1-vsementsov@yandex-team.ru/
> >   (as Peter has requested)
> >
> > Changelog for version 4:
> > - vmstate dynamic array support reworked as suggested by Peter Xu
> >   VMS_ARRAY_OF_POINTER_ALLOW_NULL flag was introduced
> >   qtests were added
> > - NVMe migration blockers were reworked as Klaus has requested earlier
> >   Now, instead of having "deny list" approach, we have more strict pattern
> >   of NVMe features filtering and it should be harded to break migration when
> >   adding new NVMe features.
> >
> > Changelog for version 3:
> > - rebased
> > - simple functional test was added (in accordance with Klaus Jensen's review comment)
> >   $ meson test 'func-x86_64-nvme_migration' --setup thorough -C build
> >
> > Changelog for version 2:
> > - full support for AERs (in-flight requests and queued events too)
> >
> > Kind regards,
> > Alex
> >
> > Alexander Mikhalitsyn (8):
> >   tests/functional/migration: add VM launch/configure hooks
> >   hw/nvme: add migration blockers for non-supported cases
> >   hw/nvme: split nvme_init_sq/nvme_init_cq into helpers
> >   hw/nvme: set CQE.sq_id earlier in nvme_process_sq
> >   hw/nvme: unmap req->sg earlier in nvme_enqueue_req_completion
> >   hw/nvme: add basic live migration support
> >   tests/functional/x86_64: add migration test for NVMe device
> >   tests/qtest/nvme-test: add migration test with full CQ
> >
> >  hw/nvme/ctrl.c                                | 1007 ++++++++++++++++-
> >  hw/nvme/ns.c                                  |  160 +++
> >  hw/nvme/nvme.h                                |   12 +
> >  hw/nvme/trace-events                          |   10 +
> >  include/block/nvme.h                          |   12 +
> >  tests/functional/migration.py                 |   22 +-
> >  tests/functional/x86_64/meson.build           |    1 +
> >  .../functional/x86_64/test_nvme_migration.py  |  159 +++
> >  tests/qtest/nvme-test.c                       |  395 +++++++
> >  9 files changed, 1742 insertions(+), 36 deletions(-)
> >  create mode 100755 tests/functional/x86_64/test_nvme_migration.py
> >
> > --
> > 2.47.3
> >
>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks for reviews, Stefan! ;-)

Kind regards,
Alex

