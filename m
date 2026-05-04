Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D36FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 23:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wK2yt-0006UP-EP; Mon, 04 May 2026 19:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wK2yl-0006U3-2W
 for qemu-devel@nongnu.org; Mon, 04 May 2026 19:45:35 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wK2yi-0004cu-O4
 for qemu-devel@nongnu.org; Mon, 04 May 2026 19:45:34 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-8353ca0f1f1so944710b3a.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 16:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777938331; x=1778543131; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9okDbXWkrvwpVS8sAduAP2Hw+RvGj6FDoR3Gz9nDViY=;
 b=Zwv7N0Gvr3c/kW3fUgZqfFVCX+GKxZSrl7YXmxyBOdlo2SwIn5RCzazPv7/Ez/19FF
 BmoJ+86T1Iz0XZTjkyUcU/BqpNu2EKk5DgQqsB8Ir1Bt+8L2IyN0xAA/O7II+AD8iY8X
 Hqkv96gqBthxqHBz7cHJD9kq5ycSg9WAUM5xHLniR13x0NooOY2vTKKcSQ4dyiGH6htR
 bNTOO9qNhg6KJsyRXsiTYVemQZak6WK9MkY94h1Q+9qRdDedQXPCP8BOzZb/HVc4/0m9
 zMKH5S0ejiJqabk2urxMN4NY1jZ+IGwLC/VEozqV+dU0zGUAzfqypjdF4v3qNowDYWTq
 Sj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777938331; x=1778543131;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9okDbXWkrvwpVS8sAduAP2Hw+RvGj6FDoR3Gz9nDViY=;
 b=Ccn+VcnOHz7SowoI842rX87HGBCarglZG9pLqf1DwPOyQo0wcHAgmEt0TkrfhRx3AA
 b5o4cI6+m0vODWogR6j/wmCgoUpPaTCjSolMj2E+GXzgmsw5gjqWTNBdTO86KrOR71Wc
 mDt6ARnQNJ1l2N8eJc9n6sTXmJDRMLdWWkTgCLQBsvvZzSj+MHvVeSnKwSKqtaY+cuev
 uHsFf+kyc+rZIJQdlz1Q0WSGCbXNcB/8cjQfeBcTVCgCm0fZRfzmQooRXOItVyIXBAM+
 xlzae4hjDCyW0ZgECo/fO40mnglKBmc3/DoS/i+qMC5+/B8OHVYyxim/igktPrblUBA1
 jHhA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Hpyf1DGM4BY7j2maxhb79YGaUuzPEfMvSm+TragHdEY2ce4RyP72P8eJtNKSti35279WiYOUOUVNJ@nongnu.org
X-Gm-Message-State: AOJu0Yzkkbn1dWHsvxUBZfGmVllOrxhI9tNru0NP78fF9JSsLctunb75
 7Mi0Mc0EqEC+8s9dfZRPEVJ+WT9KAQ0EuekWUzqjCJWJE3TJM244tVMV
X-Gm-Gg: AeBDievirukZun/wjSof7CvwE8mGHurd0QgeUmSndzkPEUWBo4ex9tyTyi8ay7oMtL3
 qMHhSMgkGiKO+4prTwKEApJ8Oq2fbCG0/6xqquRKHPMPDtDF3cVqepcRAOLB39i8d0u4s2yzi5C
 lG7ccJmsiJ97mJZrf4s8+qyblAVggiCqnj6RFp+q06yQsfsmQEEXxKJvsD+i+T016H8zBSEzeuZ
 WVdfAyVHskZ3PyMivpG8rnVQrL19XQg/R48lJJgO7Q7P3vzWSQb2UbISaqT67WD315ATFJd2qLV
 DTQ6Bucp7u2xKILsYQ8b5dlKtRNAJbiGZCd3WadS3IRIP4iVc4UzFG1QV6i/JhyMHq4ybJqzrMN
 A9+XtKgpR+TrWhDib9Gp8gfqzplYVqKBaoOO2RRsMS8MhvJT0YfkjiS7QOEemkZCysKNS9EPZrz
 s4+5jcXHyhBSd0/G5GFIv7sFJHOfgD0Chx3zFG4VsQ43Q=
X-Received: by 2002:a05:6a00:1ace:b0:827:33cb:c7a3 with SMTP id
 d2e1a72fcca58-838fc5ef9aemr1029297b3a.10.1777938329817; 
 Mon, 04 May 2026 16:45:29 -0700 (PDT)
Received: from localhost ([124.158.97.178]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-839679c8c00sm17441b3a.32.2026.05.04.16.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 16:45:28 -0700 (PDT)
Date: Tue, 5 May 2026 09:45:24 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 03/13] hw/riscv/boot: Account for discontiguous memory
 when loading firmware
Message-ID: <afkuWiSIaP1Otvom@lima-default>
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-4-joel@jms.id.au>
 <CAKmqyKPY0oxFzOXxZG5Mgj9qUdFiNg8wMxnCa5V0f0-Oc_sJBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKPY0oxFzOXxZG5Mgj9qUdFiNg8wMxnCa5V0f0-Oc_sJBQ@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

On Thu, Apr 30, 2026 at 09:34:24AM +1000, Alistair Francis wrote:
> On Sat, Apr 25, 2026 at 11:20 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> > From: Nicholas Piggin <npiggin@gmail.com>
> >
> > This loads firmware into the first (low) memory range,
> > accounting for machines having discontiguous memory regions.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> > v4: Make RISCVBootInfo *info const in riscv_load_firmware
> > v3: Call riscv_boot_info_init before riscv_find_and_load_firmware in
> >     sifive_u
> > ---
> >  include/hw/riscv/boot.h    |  5 ++++-
> >  hw/riscv/boot.c            | 18 ++++++++++++------
> >  hw/riscv/microchip_pfsoc.c |  6 ++++--
> >  hw/riscv/opentitan.c       |  6 ++++--
> >  hw/riscv/shakti_c.c        |  6 +++++-
> >  hw/riscv/sifive_u.c        |  6 ++++--
> >  hw/riscv/spike.c           |  6 ++++--
> >  hw/riscv/virt.c            |  7 ++++---
> >  hw/riscv/xiangshan_kmh.c   |  6 +++++-
> >  9 files changed, 46 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> > index 115e3222174f..b2ef64fb1d14 100644
> > --- a/include/hw/riscv/boot.h
> > +++ b/include/hw/riscv/boot.h
> > @@ -53,13 +53,16 @@ void riscv_boot_info_init_discontig_mem(RISCVBootInfo *info,
> >  vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
> >                                     hwaddr firmware_end_addr);
> >  hwaddr riscv_find_and_load_firmware(MachineState *machine,
> > +                                    RISCVBootInfo *info,
> >                                      const char *default_machine_firmware,
> >                                      hwaddr *firmware_load_addr,
> >                                      symbol_fn_t sym_cb);
> >  const char *riscv_default_firmware_name(RISCVHartArrayState *harts);
> >  char *riscv_find_firmware(const char *firmware_filename,
> >                            const char *default_machine_firmware);
> > -hwaddr riscv_load_firmware(const char *firmware_filename,
> > +hwaddr riscv_load_firmware(MachineState *machine,
> > +                           const RISCVBootInfo *info,
> > +                           const char *firmware_filename,
> >                             hwaddr *firmware_load_addr,
> >                             symbol_fn_t sym_cb);
> >  void riscv_load_kernel(MachineState *machine,
> > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> > index 5c9547429a36..4fbc778263cf 100644
> > --- a/hw/riscv/boot.c
> > +++ b/hw/riscv/boot.c
> > @@ -145,6 +145,7 @@ char *riscv_find_firmware(const char *firmware_filename,
> >  }
> >
> >  hwaddr riscv_find_and_load_firmware(MachineState *machine,
> > +                                    RISCVBootInfo *info,
> >                                      const char *default_machine_firmware,
> >                                      hwaddr *firmware_load_addr,
> >                                      symbol_fn_t sym_cb)
> > @@ -157,7 +158,8 @@ hwaddr riscv_find_and_load_firmware(MachineState *machine,
> >
> >      if (firmware_filename) {
> >          /* If not "none" load the firmware */
> > -        firmware_end_addr = riscv_load_firmware(firmware_filename,
> > +        firmware_end_addr = riscv_load_firmware(machine, info,
> > +                                                firmware_filename,
> >                                                  firmware_load_addr, sym_cb);
> >          g_free(firmware_filename);
> >      }
> > @@ -165,10 +167,13 @@ hwaddr riscv_find_and_load_firmware(MachineState *machine,
> >      return firmware_end_addr;
> >  }
> >
> > -hwaddr riscv_load_firmware(const char *firmware_filename,
> > +hwaddr riscv_load_firmware(MachineState *machine,
> > +                           const RISCVBootInfo *info,
> > +                           const char *firmware_filename,
> >                             hwaddr *firmware_load_addr,
> >                             symbol_fn_t sym_cb)
> >  {
> > +    uint64_t mem_size = info->ram_low_size ?: machine->ram_size;
> >      uint64_t firmware_entry, firmware_end;
> >      ssize_t firmware_size;
> >
> > @@ -197,7 +202,7 @@ hwaddr riscv_load_firmware(const char *firmware_filename,
> >
> >      firmware_size = load_image_targphys_as(firmware_filename,
> >                                             *firmware_load_addr,
> > -                                           current_machine->ram_size, NULL,
> > +                                           mem_size, NULL,
> >                                             NULL);
> >
> >      if (firmware_size > 0) {
> > @@ -212,7 +217,7 @@ hwaddr riscv_load_firmware(const char *firmware_filename,
> >  static void riscv_load_initrd(MachineState *machine, RISCVBootInfo *info)
> >  {
> >      const char *filename = machine->initrd_filename;
> > -    uint64_t mem_size = machine->ram_size;
> > +    uint64_t mem_size = info->ram_low_size ?: machine->ram_size;
> >      void *fdt = machine->fdt;
> >      hwaddr start, end;
> >      ssize_t size;
> > @@ -258,6 +263,7 @@ void riscv_load_kernel(MachineState *machine,
> >                         bool load_initrd,
> >                         symbol_fn_t sym_cb)
> >  {
> > +    uint64_t mem_size = info->ram_low_size ?: machine->ram_size;
> >      const char *kernel_filename = machine->kernel_filename;
> >      ssize_t kernel_size;
> >      void *fdt = machine->fdt;
> > @@ -289,7 +295,7 @@ void riscv_load_kernel(MachineState *machine,
> >      }
> >
> >      kernel_size = load_image_targphys_as(kernel_filename, kernel_start_addr,
> > -                                         current_machine->ram_size, NULL, NULL);
> > +                                         mem_size, NULL, NULL);
> >      if (kernel_size > 0) {
> >          info->kernel_size = kernel_size;
> >          info->image_low_addr = kernel_start_addr;
> > @@ -385,7 +391,7 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwaddr dram_size,
> >      dtb_start = QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
> >
> >      if (dtb_start_limit && (dtb_start < dtb_start_limit)) {
> > -        error_report("No enough memory to place DTB after kernel/initrd");
> > +        error_report("Not enough memory to place DTB after kernel/initrd");
> >          exit(1);
> >      }
> >
> > diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> > index 743f31f00578..1d1ddb05a882 100644
> > --- a/hw/riscv/microchip_pfsoc.c
> > +++ b/hw/riscv/microchip_pfsoc.c
> > @@ -618,18 +618,20 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
> >          firmware_load_addr = RESET_VECTOR;
> >      }
> >
> > +    riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
> 
> We should be able to use the new riscv_boot_info_init_discontig_mem() here

Good catch, something like this.

    riscv_boot_info_init_discontig_mem(&boot_info, &s->soc.u_cpus,
                                       memmap[MICROCHIP_PFSOC_DRAM_LO].base,
                                       mem_low_size);

I'll change that.

Thanks,
Nick

