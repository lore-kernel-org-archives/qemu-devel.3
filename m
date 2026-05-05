Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4CDFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 01:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK4Dd-00089h-Nc; Mon, 04 May 2026 21:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wK4DG-00088D-JZ
 for qemu-devel@nongnu.org; Mon, 04 May 2026 21:04:43 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wK4DD-0007CD-On
 for qemu-devel@nongnu.org; Mon, 04 May 2026 21:04:37 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-8353dfdad62so1399493b3a.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 18:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777943074; x=1778547874; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Pig25E8yo04twK5Yr9qmW2oohe/88B5Uri3IMaFL++w=;
 b=jjbB0/r7SUGwUVlhVc+vBzbvd40sGSXW6/Ot3K4XOeHR4h63cENqbIIR9yYctjdkHS
 leeL1JmTJlWEd90kRrwTWWICr4YXHGZcCv1XqBizKJCCpyxoHa+aUgNkHJNsITF4okRN
 h3SHEGBBJfsEKO/KF4v91e3TVnPV2NorS51+90TkBhAkuR5bsZxe/dmM4YtyvQ1J7O0n
 q0rwuzOuaTuccYGlIwHLPmEy01+d4CFg/QnEndpB/ORBWYl+GdDZRX3qtaqUijkOdAOJ
 hHpzcI9CFk6pTKG/vBWA73cP7I6x+wLuEDrbCa9eonQcwICbn2VwpIzWXusE6V9cw9ZT
 Y6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777943074; x=1778547874;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pig25E8yo04twK5Yr9qmW2oohe/88B5Uri3IMaFL++w=;
 b=poBB8vJ/oab3b2CDhVgt132ebRZPIFAnMG4oAr8ldvwFcTpnlOBvjkGGOEVpX0Fga1
 sfQKhrJF36DFYdRXAA+zCso2H8bm2ch8tjhl30xl1dEoVHMjeEAsW+gfH7p1YoQ0sOQ6
 xp00b7GjavcohHz8TqkyQHj36+BM4q5QsnJkbg0M13veWeShFFLFM9tM5Wkx9YKKYUEb
 4dK4KmQ5xH5gHsibruutJAmQvQoiOLQUY6a6XFqkLtVYoegmso0k8yhs/E7aTsHZx0sf
 tEg48N9Z1ycUSMgY2G5ibpw8j1wBjC4xSWzjr8zYGF4iyBiuq5lgVb0mb+A2zCD0McPG
 XsKQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+h+T0lSTbKepeT31TLOkp+er4dYYd+Kbo6kJ03LI1YtaA9AaHE1SZW/G/J4X7YbcjtyiMRtiSRzrPY@nongnu.org
X-Gm-Message-State: AOJu0YzkCGhHGLewUgsXe5qgVK16uf3yqssoS3SWKN0MVHpKMlvSDjTi
 8YVpXyJVoC51zsoene4Fl/k443wRv86YvLDH+NeUtE4moR8UTzMAZeMf
X-Gm-Gg: AeBDietFWQxM1EXr2F868qZvMTvJWoqn1NBB0XYLh7q183pku3YuQnk1zwfa+VK8ZC5
 fkkqt/5m03BoFwMDJ7prtRDqdV3zNafwig0XujKPF2wVJT1mB7RH6pUTeOr/E8++uwUn+FDYB4c
 BgazWcMQbOczGarh0OZFPJp/+4Ms6nvGMxOSw+a32ts7MZtuv7PfjIpxtXhM+jiH5nNRyTW/Q8Y
 aqerJ1zyhBWlbvSD3nH7lh08qsOt1I0W1UJVHzBHNHHZ8hJetZ12Qkgg6R5CDfsjZk3tAEPRsCG
 q5abN92kUprM2rNsFO5FbMLGMtVY43Jv/piKJg5NQiHnBDI6U0xYy8Lt0mu/esedTDkW/rE1zPu
 FefJqqwULgwS2YoWH7m7ld12+PozxagOQl7iaTeieAVI2ChKMdHNyVXgv5oB4WdtgUudMsQlPTJ
 B5lEZz5ame7S8ABLPbOPKC5RkYJ9P1+YyXnrpMBODSfnI=
X-Received: by 2002:a05:6a00:aa8c:b0:82a:6461:6d15 with SMTP id
 d2e1a72fcca58-8352d2b39d0mr11567864b3a.46.1777943074108; 
 Mon, 04 May 2026 18:04:34 -0700 (PDT)
Received: from localhost ([124.158.97.178]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-839682a272asm131984b3a.54.2026.05.04.18.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 18:04:33 -0700 (PDT)
Date: Tue, 5 May 2026 11:04:30 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 09/13] hw/riscv: Add Tenstorrent Atlantis machine
Message-ID: <afk0kVtQGz7OZ65_@lima-default>
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-10-joel@jms.id.au>
 <CAKmqyKMLwO2uRnzrke+RkCZmdOJPs3Ouyoe=UeuAWnRgitAD8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKMLwO2uRnzrke+RkCZmdOJPs3Ouyoe=UeuAWnRgitAD8A@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Apr 30, 2026 at 09:57:34AM +1000, Alistair Francis wrote:
> On Sat, Apr 25, 2026 at 11:20 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > The Tenstorrent Atlantis platform is a collaboration between Tenstorrent
> > and CoreLab Technology. It is based on the Atlantis SoC, which includes
> > the Ascalon-X CPU and other IP from Tenstorrent and CoreLab Technology.
> 
> Can you provide a link to documentation

Also not presently.

[...]

> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e1942a86eba5..635a380945fd 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1760,6 +1760,17 @@ F: hw/*/*sifive*.c
> >  F: include/hw/*/*sifive*.h
> >  F: tests/functional/test_riscv64_sifive_u.py
> >
> > +Tenstorrent Machines
> > +M: Joel Stanley <joel@jms.id.au>
> > +R: Nicholas Piggin <npiggin@gmail.com>
> > +R: Michael Ellerman <mpe@kernel.org>
> > +L: qemu-riscv@nongnu.org
> > +S: Supported
> > +F: docs/system/riscv/tt_*.rst
> > +F: hw/riscv/tt_*.c
> > +F: hw/riscv/aia.[ch]
> 
> AIA?

Not sure why that is there, there's no Tenstorrent implementation detail
in there AFAIKS. Let's remove that line.

> 
> > +F: include/hw/riscv/tt_*.h
> > +
> >  AMD Microblaze-V Generic Board
> >  M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> >  S: Maintained
> > diff --git a/docs/system/riscv/tt_atlantis.rst b/docs/system/riscv/tt_atlantis.rst
> > new file mode 100644
> > index 000000000000..640cabf7b046
> > --- /dev/null
> > +++ b/docs/system/riscv/tt_atlantis.rst
> > @@ -0,0 +1,38 @@
> > +Tenstorrent Atlantis (``tt-atlantis``)
> > +======================================
> > +
> > +The Tenstorrent Atlantis platform is a collaboration between Tenstorrent
> > +and CoreLab Technology. It is based on the Atlantis SoC, which includes
> > +the Ascalon-X CPU and other IP from Tenstorrent and CoreLab Technology.
> > +
> > +The Tenstorrent Ascalon-X is a high performance 64-bit RVA23 compliant
> > +RISC-V CPU.
> > +
> > +Features
> > +--------
> > +
> > +* 8-core Ascalon-X CPU Cluster
> > +* Dual x32 LPDDR5 @ 6400 MT/s
> > +* RISC-V compliant Advanced Interrupt Architecture
> > +* PCIe Gen4
> > +* RISC-V compliant IOMMU
> 
> IOMMU isn't supported (at least not in this patch), maybe this should
> list things that are supported in QEMU (and can then be expanded).
> Leave the features list to your official documentation (which is
> missing a link here)

Sounds reasonable.

[...]

> > +
> > +static void create_fdt_cpus(TTAtlantisState *s, uint32_t *intc_phandles)
> 
> So generally we only create a device tree for virtual boards, that is
> boards that don't really exist and are just QEMU constructs.
> 
> You said that this is based on the "Atlantis SoC" so I assume it's
> real hardware. In the real hardware do you expect the device tree to
> be provided by the ROM? Usually for boards users supply the device
> tree as part of the boot flow (via u-boot or something similar). In
> which case should QEMU actually generate this or can users just supply
> their own?
> 
> Basically the question is, if you are trying to model the hardware, is
> generating the device tree here correct?
> 
> Obviously the advantage of doing it here is then the device tree
> describes what QEMU supports, which is great. But that can be harder
> to manage when the hardware doesn't do that, as then you have
> divergence.

We went around this same discussion internally and yeah it's a valid
question, we could have explained this a bit better.

In the real (unreleased) hardware and the DT will be loaded from ROM.
I think we should do that when the model and firmware and dt is more
complete. At the moment it has been easier for development to use QEMU
generated fdt.

Is that acceptable to do that now and switch to a fdt ROM later...

[...]

> > +static void finalize_fdt(TTAtlantisState *s)
> > +{
> > +    uint32_t aplic_s_phandle = next_phandle();
> > +    uint32_t imsic_s_phandle = next_phandle();
> > +    void *fdt = MACHINE(s)->fdt;
> > +
> > +    create_fdt_cpu(s, s->memmap, aplic_s_phandle, imsic_s_phandle);
> > +
> > +    /*
> > +     * We want to do this, but the Linux aplic driver was broken before v6.16
> > +     *
> > +     * qemu_fdt_setprop_cell(MACHINE(s)->fdt, "/soc", "interrupt-parent",
> > +     *                       aplic_s_phandle);
> > +     */
> 
> And now we are stuck with hacks like this, which we really don't want
> to be dealing with. Maybe it's best to leave the device tree to the
> kernel.

... Despite issues like this?

[...]

> > diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > index 0222c93f878b..0601ae1a7494 100644
> > --- a/hw/riscv/Kconfig
> > +++ b/hw/riscv/Kconfig
> > @@ -120,6 +120,21 @@ config SPIKE
> >      select RISCV_ACLINT
> >      select SIFIVE_PLIC
> >
> > +config TENSTORRENT
> > +    bool
> > +    default y
> > +    depends on RISCV64
> > +    imply PCI_DEVICES
> > +    imply TEST_DEVICES
> > +    select DEVICE_TREE
> > +    select RISCV_NUMA
> 
> Do you actually need NUMA? You have a numa include as well which I
> don't think is required.

Hardware is not NUMA. It was probably just copied from the VIRT config.

Thanks,
Nick

