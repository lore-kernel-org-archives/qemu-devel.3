Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761EEC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfb3x-0002QH-Hy; Fri, 03 Jul 2026 06:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wfb3v-0002P2-Kz
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:23:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wfb3t-0007vW-Ul
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783074236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z82EVgcw6kXxwotyyS4NHVr58vsvYPMldM2a4HNYQGk=;
 b=Yiw85NUQBCZnn+qrWuSSGUMUoYY4RXQdcjKMHBDTyTSlEAjpiDUxLfc7P40HZ6pt6aMePg
 EujXNKmUhWFo8/+GvL1z0scjazN6wazES9aCcddurmTRltavBd5G/EMhEk9VlauQRByUth
 cc32ASiE/R4OHLegOsytpRvz3ikJX50=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-m4tS8USxO2CtvJhwXVHmrQ-1; Fri, 03 Jul 2026 06:23:55 -0400
X-MC-Unique: m4tS8USxO2CtvJhwXVHmrQ-1
X-Mimecast-MFC-AGG-ID: m4tS8USxO2CtvJhwXVHmrQ_1783074234
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-493c588b6f2so3281675e9.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 03:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783074234; x=1783679034; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z82EVgcw6kXxwotyyS4NHVr58vsvYPMldM2a4HNYQGk=;
 b=ifxLRf+nXNQ1xarW+5uglGk/3i70J6Jz5jJslvQAv2VrVNgjoe2L6A84bT6tfV2wzq
 Mcu0HTSD71JHPLjeEFOa1LpbQhUCkd2bgenJJwYniw6A6yHG0RLbjiIqi1R5wLLb/H+O
 VdDZeI7zsGap82jwI07gBo0ccLJVuAHbCxTvdvx70X+86/1IcxgPzXoLikd7HVWhJ362
 m/AJcxXyGICg8ECwCABCjCnyDdgeYBAjiQU3NYPlbr6qSeagl8XdB1Mkn8BWfMUVDZFD
 cjeL25AwEIboCbZk4AFzw5URlDoBoIjV/u1UX4dtntk9XmA5IT0Db7E6N+4gWFYoxX8r
 2ZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783074234; x=1783679034;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z82EVgcw6kXxwotyyS4NHVr58vsvYPMldM2a4HNYQGk=;
 b=Emv+5qgXIQ/+BD2s6pDhd8bGSppPlrvpkVuLVCOaCYfwODB/bf5Q8w/Nqn8eRkXRdx
 lVUnvVgMqDajiiqamszugsCzaNxgVYAh1kRHsyEJW1qJApiHFvCXSlNve1y23Gw+bI9G
 tdHVZ2AaPLkewxaBwLbkeyzfS7zEcTqdVkhSJunlqh2SvtTlJHrrsT+3UdhnUhfUTLO8
 eCp5FpxZw548WHiNqz1OSZMQE+bQzXDTRYltr9bkDr3aW3VZZLiRON4ZRosze1/UGWWY
 UC4YfLjViHD4GZkic3yluD1qS8G+ojSbvxqLvlyxwJmwHhLv0cugYlK3kcWKryJoTf2f
 +0Mw==
X-Gm-Message-State: AOJu0Yx08KSH14lJPIv8271lxx/p0LrWRdHjtHpkC9dBB0ynJKbId6aG
 HS8GyiXFKZMfh0PCuQCD50oE3WrwPOBQNPyJqX9UI9akr5HYmZLyuuD/mu5kC/50tLWK902Uvny
 GBkE8aN0MzAFO7cfWpGTAVIld0RFsIPyeQubZwpjaoUht/1YFH0h1cNG5
X-Gm-Gg: AfdE7clqrMn0QUNFRWyuhd3y3FzX45OUWw9WyFC1VqFh48cM8Fn0P5h0zgWCCUChi/p
 zkjTZ6c1Ac0f5xENtZ5mPvbJVqohukkaD1nZ61ONj8dbx6X6Xgvlo1IGtu4t1gFZO6o4PgQyDGe
 t0kDXK+/8uktAwIjcYy1GupWwzcuuT1AZx7lGV/RlrkTa+Uzb5K7tIP2Re12fIS7Gc+bNjn0de1
 0gtHn+J/Zlf++Oy08I+Y3WJBOjoD0XJZu+AnTMEi/fP6Drgz7dTdABBbYzSCT2N32NsuHiQetFE
 PE+y/2Co8/4td0rZvlXPjNfYjTw2JkDyoghhGU30CSvuWvrHkp/ADoItyqzqWX7t8seqn+CMoWb
 XoYsEoFSCekSRwImk8r+q15TL2HDFDmMc
X-Received: by 2002:a05:600c:1c1c:b0:493:c1a1:68f0 with SMTP id
 5b1f17b1804b1-493c2b6e672mr164492295e9.20.1783074233705; 
 Fri, 03 Jul 2026 03:23:53 -0700 (PDT)
X-Received: by 2002:a05:600c:1c1c:b0:493:c1a1:68f0 with SMTP id
 5b1f17b1804b1-493c2b6e672mr164491775e9.20.1783074233145; 
 Fri, 03 Jul 2026 03:23:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63ba97csm120590005e9.12.2026.07.03.03.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 03:23:52 -0700 (PDT)
Date: Fri, 3 Jul 2026 06:23:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: Re: [PATCH 0/5] hw/nvram/fw_cfg: Document and tighten up register
 layouts
Message-ID: <20260703062108-mutt-send-email-mst@kernel.org>
References: <20260529174639.451353-1-peter.maydell@linaro.org>
 <CAFEAcA9GDPyd19-fdoepJesSbw=eZfPtPDTsa++yZ1F=j3p87Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9GDPyd19-fdoepJesSbw=eZfPtPDTsa++yZ1F=j3p87Q@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 03, 2026 at 10:41:32AM +0100, Peter Maydell wrote:
> These have all now been reviewed. Since fw_cfg is marked as
> Orphaned in MAINTAINERS,

I don't think fw cfg is good as orphaned.
Any takers? If not I guess I will have to add myself there.

> I'm going to take the series via
> target-arm.next. Let me know if anybody would prefer something else.
> 
> thanks
> -- PMM

Pls go ahead:
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


> On Fri, 29 May 2026 at 18:46, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > We support the fw_cfg device on more architectures and machines that
> > we let on about in the documentation.  Luckily most of the new ones
> > (notably riscv and loongarch) have followed the straightforward layout
> > that the Arm virt board picked. Allowing every machine type to have
> > its own special-snowflake register layout has no particular benefits
> > and tends to result in guest OSes accumulating ifdef ladders to deal
> > with all the unnecessary variation.
> >
> > This patchset:
> >  * updates the docs to present the arm/riscv/loongarch memory
> >    mapped layout as the "standard" layout to be used by all
> >    new architectures/machines in future
> >  * adds the layouts used by various existing boards that we
> >    didn't document (PA-RISC, SPARC, PPC and MIPS)
> >  * tightens up fw_cfg_init_mem_dma() and fw_cfg_init_io_dma()
> >    functions so that they don't provide flexibility to the
> >    caller to pick their own weird new layout. None of the
> >    callers were using this flexibility, so it's better to
> >    have fw_cfg_init_mem_dma() give the "standard MMIO" layout
> >    and fw_cfg_init_io_dma() give the x86 ioport layout.
> >
> > thanks
> > -- PMM
> >
> > Peter Maydell (5):
> >   docs/specs/fw_cfg: Document all architecture register layouts
> >   hw/nvram/fw_cfg: Enforce standard layout for fw_cfg_init_mem_dma()
> >   hw/nvram/fw_cfg: Enforce standard layout for x86 fw_cfg I/O ports
> >   hw/nvram/fw_cfg: Remove support for I/O port fw_cfg without DMA
> >   hw/nvram/fw_cfg: Document fw_cfg_init_mem_nodma()
> >
> >  docs/specs/fw_cfg.rst     | 28 ++++++++++++++++---
> >  hw/arm/virt.c             |  2 +-
> >  hw/i386/fw_cfg.c          |  3 +-
> >  hw/i386/microvm.c         |  3 +-
> >  hw/i386/pc.c              |  3 +-
> >  hw/loongarch/fw_cfg.c     |  3 +-
> >  hw/nvram/fw_cfg.c         | 22 ++++++---------
> >  hw/riscv/virt.c           |  3 +-
> >  include/hw/nvram/fw_cfg.h | 58 +++++++++++++++++++++++++++++++++++----
> >  9 files changed, 92 insertions(+), 33 deletions(-)


