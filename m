Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932B9F3C240
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 12:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzZWp-0006iq-41; Mon, 09 Mar 2026 08:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vzZWX-0006cH-9M
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:15:52 -0400
Received: from mail-dl1-x1241.google.com ([2607:f8b0:4864:20::1241])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vzZWT-0007tq-9t
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 08:15:47 -0400
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-12713e56abdso6579866c88.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 05:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773058543; x=1773663343; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VA0sy7fn8lN3mTt8/UgUn2z6o5yUo0J4OR6zdZ3Cw7E=;
 b=NkLl4X6o1KMmZQYc1VyKD52iTP22oL/bJ+B2pOgFnTOQMG64eX9An67HPZlq/KE828
 4FMeN/9pFIhOKJkSb8lGsJQ3F4cSHHsANduF27NgLRDEOaxntpFxxyMIyICoT9guKb+3
 Ze7fkUOUWvON6bOW2x5VLvyB73Q28l8k5j5uZCJYDNquflU36IA+bhTfKucCLSaaRa41
 YQxxk1mSdmjrhQGLRNjzYK4IWHYNSSVlkqS5Y18vZ81Nt3tZaQqgn/NK3Hp+V9URtORA
 yCWK57HwTZOqYIjL7YPDhS/axO88TnjT364J5HjuoQkUnjFfD1fGHuzJ2sAim5Bnj6N5
 fyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773058543; x=1773663343;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VA0sy7fn8lN3mTt8/UgUn2z6o5yUo0J4OR6zdZ3Cw7E=;
 b=bX7vXtn9WYTHZ7ODTMpoJ4RkvFOoLMHPln9v/tCx27nuj/Z52O/pIXFdvEEgiaMKcX
 9rqzzbBhD9sMt0m+RUFYNK9Xk2hfscfDCBOF2dpJiefrNmK8giANRjrrysWK/+p8LZa1
 XgT5qK6RXT8MLi0D9NKeCnLHVsj29ReL54xlbm92lkq7M/q5dShhcN3QDW8jWXeVmmuf
 EXF34HmK6lSuSAw93/tLlI7/Kcb1R0EilT69rE/eRWGZZxKuwEi7G7j7Wl5g95TKR515
 7XszenzGryuhQSNB6xt/QHT96mYNCm5GpYAnnxfylBDv5z3p4IDUtnu5fZJ2urip54Hu
 bAsQ==
X-Gm-Message-State: AOJu0Yxg+Byr+dgBrpetVI1hi07CWJDheMk5Z1q4h8yG/oS3snaVUkxL
 Khi0lKWVoUguBdH/b05CaT6WPDxSmggfjNtCrBYVsB718gpj6nhMTBkK
X-Gm-Gg: ATEYQzzzUtXQaz4ZFMA6Sit+P/isptoyN9x674BKlLR6Mbv2ZHbDbNE+A2lvtBzP1yn
 t0kcuVT5C9+W4LKqrua6zFYxYe6ydUCgmNNfXbc6LdPp6lzlPCTMp2SgzM0vm9FeLjL7IGkjidY
 VMYJr1VmTd1t6Q8CxWuoOk7Zia7C+nFYvg4MzrWlPtBOAitCEw8bXzMM9mb0FSsRhdyJpj8yVqa
 OVxDv0zQWyl4/XuZ9R/DnlrtttN2CjZFxlc3onEwdULkS9OgkP3p+bkN5R1oGSaYxAVBdAQA0xd
 zVbcjuJkrDJaJZTIDMnGD+xemOFo6Sc3BIUqTmBo/mUGf0qtw7A2lTn7ONYsjr0+M9FERWFe/Gf
 eBz5dFKDX+9VZdZ32Vq0GxK2aSKdagYYSD5tGemwJOhLO7Dl8KzZbYouGU8yq0EqIgSYx9W1DGQ
 Y3xa9bvlF4kXM0LyGSeV/aboC/6vFtXpHwkzpXStTrgfWWMLme+ViLwvXKhd/fvMqyq4VA0A09J
 rvSgpeb6aWXItZD/yFkPcajJg44jUY=
X-Received: by 2002:a05:7022:699b:b0:11c:883d:1ef0 with SMTP id
 a92af1059eb24-128bbfe716emr5544805c88.15.1773058543044; 
 Mon, 09 Mar 2026 05:15:43 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-128c3f5a102sm9437010c88.13.2026.03.09.05.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 05:15:42 -0700 (PDT)
Date: Mon, 9 Mar 2026 20:14:52 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Helge Deller <deller@gmx.de>, 
 Eduardo Habkost <eduardo@habkost.net>, Song Gao <gaosong@loongson.cn>, 
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>, 
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
Subject: Re: [PATCH 2/2] accel/tcg: address_space_translate*() will pass the
 correct iommu_flags
Message-ID: <aa65nTMvERTjuEwr@ZEVORN-PC.localdomain>
References: <20260202075358.2137740-1-jim.shu@sifive.com>
 <20260202075358.2137740-3-jim.shu@sifive.com>
 <aaUkfa3DfURTV83t@ZEVORN-PC.localdomain>
 <CALw707rZM3ObmC-ckeRtcAgww=1uONetrBP-VqAE4aij5G1mHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALw707rZM3ObmC-ckeRtcAgww=1uONetrBP-VqAE4aij5G1mHA@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1241;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1241.google.com
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

On Thu, Mar 05, 2026 at 01:35:51PM +0800, Jim Shu wrote:
> Hi Chao,
> 
> 
> On Mon, Mar 2, 2026 at 1:51 PM Chao Liu <chao.liu.zevorn@gmail.com> wrote:
> >
> > Hi Jim,
> >
> > On Mon, Feb 02, 2026 at 03:53:58PM +0800, Jim Shu wrote:
> > > Instead of IOMMU_NONE, address_space_translate_for_iotlb() now can pass
> > > the correct iommu_flags to the IOMMU translate function from the
> > > access_type.
> > >
> > > Since RISC-V wgChecker [1] could permit access in RO or WO permission
> > > only, the IOMMUMemoryRegion could return different section for
> > > read and write access. To support this kind of IOMMUMemoryRegion
> > > in the path of CPU access, we should pass correct iommu_flags here.
> > >
> > > [1] RISC-V WG:
> > > https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/
> > >
> > > Signed-off-by: Jim Shu <jim.shu@sifive.com>
> > > ---
> > >  accel/tcg/cputlb.c        |  3 ++-
> > >  include/accel/tcg/iommu.h |  3 ++-
> > >  system/physmem.c          | 16 +++++++++++-----
> > >  3 files changed, 15 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> > > index 2a0f4cfff62..404a8607b9b 100644
> > > --- a/accel/tcg/cputlb.c
> > > +++ b/accel/tcg/cputlb.c
> > > @@ -1050,7 +1050,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
> > >      prot = full->prot;
> > >      asidx = cpu_asidx_from_attrs(cpu, full->attrs);
> > >      section = address_space_translate_for_iotlb(cpu, asidx, paddr_page,
> > > -                                                &xlat, &sz, full->attrs, &prot);
> > > +                                                &xlat, &sz, full->attrs, &prot,
> > > +                                                access_type);
> > >      assert(sz >= TARGET_PAGE_SIZE);
> > >
> > >      tlb_debug("vaddr=%016" VADDR_PRIx " paddr=0x" HWADDR_FMT_plx
> > > diff --git a/include/accel/tcg/iommu.h b/include/accel/tcg/iommu.h
> > > index 547f8ea0ef0..2a79f859834 100644
> > > --- a/include/accel/tcg/iommu.h
> > > +++ b/include/accel/tcg/iommu.h
> > > @@ -20,7 +20,8 @@ MemoryRegionSection *address_space_translate_for_iotlb(CPUState *cpu,
> > >                                                         hwaddr *xlat,
> > >                                                         hwaddr *plen,
> > >                                                         MemTxAttrs attrs,
> > > -                                                       int *prot);
> > > +                                                       int *prot,
> > > +                                                       MMUAccessType access_type);
> > >
> > >  #endif
> > >
> > > diff --git a/system/physmem.c b/system/physmem.c
> > > index 2fb0c25c93b..337137489de 100644
> > > --- a/system/physmem.c
> > > +++ b/system/physmem.c
> > > @@ -683,12 +683,14 @@ void tcg_iommu_init_notifier_list(CPUState *cpu)
> > >  MemoryRegionSection *
> > >  address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr orig_addr,
> > >                                    hwaddr *xlat, hwaddr *plen,
> > > -                                  MemTxAttrs attrs, int *prot)
> > > +                                  MemTxAttrs attrs, int *prot,
> > > +                                  MMUAccessType access_type)
> > >  {
> > >      MemoryRegionSection *section;
> > >      IOMMUMemoryRegion *iommu_mr;
> > >      IOMMUMemoryRegionClass *imrc;
> > >      IOMMUTLBEntry iotlb;
> > > +    IOMMUAccessFlags iommu_flags;
> > >      int iommu_idx;
> > >      hwaddr addr = orig_addr;
> > >      AddressSpaceDispatch *d = address_space_to_dispatch(cpu->cpu_ases[asidx].as);
> > > @@ -705,10 +707,14 @@ address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr orig_addr,
> > >
> > >          iommu_idx = imrc->attrs_to_index(iommu_mr, attrs);
> > >          tcg_register_iommu_notifier(cpu, iommu_mr, iommu_idx);
> > > -        /* We need all the permissions, so pass IOMMU_NONE so the IOMMU
> > > -         * doesn't short-cut its translation table walk.
> > > -         */
> > > -        iotlb = imrc->translate(iommu_mr, addr, IOMMU_NONE, iommu_idx);
> > > +
> > > +        if (access_type == MMU_DATA_STORE) {
> > > +            iommu_flags = IOMMU_WO;
> > > +        } else {
> > > +            iommu_flags = IOMMU_RO;
> > > +        }
> > This maps both MMU_INST_FETCH and MMU_DATA_LOAD to IOMMU_RO. Is this intentional?
> > Some IOMMU implementations might want to distinguish between instruction fetch and data read.
> 
> Thanks for pointing out it!
> I don't know IOMMUAccessFlags enum now has IOMMU_EXEC.
> I think mapping three access_types to IOMMU_RO/WO/EXEC is more
> accurate. I will fix it in the v2 series.
> 
> >
> > Or is the current mapping sufficient for your use case (RISC-V wgChecker)?
> Yes, RW is enough for RISC-V wgChecker now. We don't distinguish EXEC
> permission from READ permission.
> But I think supporting RWX permissions in the generic code is better.
> Perhaps future devices will distinguish RWX permissions.
> 
Thanks for the explanation. It makes sense that wgChecker treats instruction
fetch and data read uniformly at the IOMMU level given the current RISC-V
spec.

I agree that adding full RWX support in the generic path is the right
approach. Having the mapping explicitly cover all three cases:

  MMU_DATA_LOAD  -> IOMMU_RO
  MMU_DATA_STORE -> IOMMU_WO
  MMU_INST_FETCH -> IOMMU_EXEC

will make the code cleaner and ready for IOMMU implementations that do
enforce execute permissions separately. Looking forward to the v2 series.

Thanks,
Chao
> >
> > Thanks,
> > Chao
> > > +
> > > +        iotlb = imrc->translate(iommu_mr, addr, iommu_flags, iommu_idx);
> > >          addr = ((iotlb.translated_addr & ~iotlb.addr_mask)
> > >                  | (addr & iotlb.addr_mask));
> > >          /* Update the caller's prot bits to remove permissions the IOMMU
> > > --
> > > 2.43.0
> > >
> > >

