Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C260CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 14:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXgpM-0002Rj-3D; Thu, 11 Jun 2026 10:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXgoo-0002GO-JM
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 10:56:01 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXgoh-0005B5-OW
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 10:55:42 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-66077f6c438so7293157d50.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 07:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781189725; cv=none;
 d=google.com; s=arc-20240605;
 b=LlpB8mdMC53ctrqiGe5+aDywMvYDHSc2Z2icPz1tqdH9p5k/n3x8Q34VnVo6YhX+h5
 +3e4MrVvRF/9RYIx1OVfaVysW0f6wgCtTWxC75QKh+r9YSifDLFgHhDwcDS5uf0bA/d5
 Cm4vlNl56wki0MX5RPUFbavC8NY4dQuvMEAywNXYPFyOnaiSScDLnAOkxYTp3+Cfj6vA
 2oGS9g9If7ihn9Vxr0gK10lsjr1J+1YsTK0ovg/t4fNJmWoHQuB2o3UJqMkLT2dBXIxQ
 eAanAlSdF02MXbqtzTZaY7AoJ576sILxCMh1bVG98DBYEUJF5Z2+sHvNHBoRJAHOPtUA
 KHiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MjLlFne7RMFlE8jgLAmOVQNVSIku/G1TjR6tfj9BSYk=;
 fh=3+nW6YVXy3f1yhjxYaGjJTBSfDddEJGDtf2Ya2+D+Fc=;
 b=Yj0IwSefj91LS/Jg2SbSinaL95XAeq/9rH8bJQMF1MmzVuh68InAa5yvar7IW6KPjr
 kuBTREj4hiW/ffBMR90nzBa6kLVm42CcWeYLN60h4vrVUZy1+4xuapWIsPrECTnuCIuA
 j+YZbIImhKho/8eAJ1RD9xVNQ2SVxD9+IaouqJKbTXipoYdq/HAQFfnxJqiIzE7RtaYX
 7LCVgEoyOG2hfCU2fxSIRE3UW9KNGY/JUryQq0ZxKnAOYhwMWsxMH7XlbTFK09fKe+dW
 9oHYYcSBX1sGFyN+0/BP8D+UKxfd2DxrRYTr6hzvXSakVSM+XyJuvx+NvxjJ6pw5oo7Z
 V3nw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781189725; x=1781794525; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MjLlFne7RMFlE8jgLAmOVQNVSIku/G1TjR6tfj9BSYk=;
 b=R6+k1RyJdRkjnrbL9fV879tVwyr7wPnSSJZWr0q61Yl7eCwMTHCRCofcMUTOXa+edd
 lrrBvVV2AI99CwIjaVowX7us2ibH796bsabeLcCfJesuTyhaFwAfu5kVZTwcA1a2fkaL
 Val4bgB1CxAvcHLTavdip+25Lp70VYmhxA6MTcv/PWy25o+i1sbSoAlKNTOmPwq3sAxD
 MHZ70ZRfF4Qqjxx1w0l+o3VUzRz/vY+IA1vgiVdcPscR+44eAWvdg2X4hLe6Ia30NenM
 tzDc4tEnT4q4AIrw3+y51AJcSlWlGLQbEdAU0rLw8nOATsE00r5E23v4Ntw6Ru0MvF2R
 KJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781189725; x=1781794525;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MjLlFne7RMFlE8jgLAmOVQNVSIku/G1TjR6tfj9BSYk=;
 b=j9JNSfs05wRl/zYaq1Q0ZAbGiWUfRaHjB3AK/9QEcmWhl85qsI70TSDIyrBXwHbmNG
 spqTsbQVmYMMMO+sRpjEBcHAMBVNrYJaIlfYDDB1J53FFxopEM7xVNC4TxFs4GsSypD2
 qDS44m+MDpJAbSZL2wWJsY+OiLYxABjOKGOgADZ8U9f8gtBWlz+BdgW4ubRBF/R3Fq4x
 XVssURdgtr0c8qIXloTpSf77JbiQlmA06Vgpqkv2hYdDvrE2VdmHaeXIj1APFB/fFuZM
 6Es5JsbNQF8kYCq1UlKB1P8oSrtKxCTZ0LN0VMt79jujIuUCpHEwNq3ZFyhR1mPmj/3E
 4ZNw==
X-Forwarded-Encrypted: i=1;
 AFNElJ96gG2AxhY5LEGkaj1qJQU+ptFKuyZQpsNrJkvGlrCD7ys8zAdq6BextLcnFeYMSknTM9HzGyOaKg3D@nongnu.org
X-Gm-Message-State: AOJu0YxJVx7xGBAAiOg9xHe+Pyw9iqpwu0jnfkuqX7eT885LeilCiWQR
 7MRwXj3y+qM8hEJ9MzUbTHMLJ/1kMPXshmjiPkVO5qBeEGN2Yc/NSA0lR8hJOP2BN5xitWx72vq
 QPRxYEAKiklJepw4AL8J4dhEqpUkVQ1F/qNczFTew+w==
X-Gm-Gg: Acq92OEaAbdL7ZPwdhxj6nbKsg0Vbx64YhKo8TMOUxSCJHee1RTVycju41LUaEIriF5
 5e/UjJuHo3OT/LrYW6PK61LI91VBypmkwmYCymJwoNEmdzgDQFZF3m/Ro6JtEIKxzxgfaNOv5Hy
 E/EqDdiRvuNarkrZl7KX5yGzBOSxtdcv1atKaSJFxGH7nMs46vwqTMVMGWCoBfO3ncbz9c1hb4I
 hWgk8LOB90vS4UaDtR5VdiultrvFCJ2tDYOvQ6z4z7nXl7LlaexmDZ+OimSoQzKYe4/3ZmD6thL
 Dlddwkye/tCe56GcNSUC3Wm7pl6IX6Cc1F3tj3Yof3UnC3mA6f8BIsqD1HKQcTPuivrkyuFEgd5
 REg==
X-Received: by 2002:a05:690e:4194:b0:660:ea4a:4903 with SMTP id
 956f58d0204a3-662696514cemr2867113d50.18.1781189724630; Thu, 11 Jun 2026
 07:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <e7cc9f2d-ccb4-442f-a1ed-7c5474395099@redhat.com>
 <20260610095712-mutt-send-email-mst@kernel.org> <aimEl9QQ_LTRPLtd@x1.local>
 <20260610121026-mutt-send-email-mst@kernel.org>
 <1e9515c9-7e32-4d95-9b73-aab8bf10bddc@redhat.com>
 <20260611012217-mutt-send-email-mst@kernel.org>
 <3726a607-6cac-41f1-b402-0eed7c4e3fe3@redhat.com>
 <20260611023428-mutt-send-email-mst@kernel.org>
 <0c3f1dba-3b2c-43c5-b181-1426f6da0951@redhat.com>
 <CAFEAcA8Q9qEaZS8wCpZQ-4jpAnQ9JXvnb7iSeRTdhJ9Y3BcCRg@mail.gmail.com>
 <20260611093049-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260611093049-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jun 2026 15:55:12 +0100
X-Gm-Features: AVVi8CcrkmK07O1DQpfSH99m1cJBH3FkoCpN0gfGD78TtSdWd1qLWH7HPAZnjXc
Message-ID: <CAFEAcA-8Hv0o3PibjH=8jixsHyunH2HkOAMQVqHkGr34b1Ascg@mail.gmail.com>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Pavel Hrdina <phrdina@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com, 
 shan.gavin@gmail.com, Alex Williamson <alex@shazbot.org>, 
 David Hildenbrand <david@kernel.org>
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

On Thu, 11 Jun 2026 at 15:10, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jun 11, 2026 at 01:48:51PM +0100, Peter Maydell wrote:
> > On Thu, 11 Jun 2026 at 13:34, Gavin Shan <gshan@redhat.com> wrote:
> > >
> > > Let me try to summarize what I understood. As VFIO is concerned, there
> > > are multiple memory regions for one particular PCI BAR, and they're stacked
> > > up. The memory regions for PCI BAR#4 of the GH100 card looks as below.
> > >
> > >    (qemu) info mtree
> > >               :
> > >    address-space: pci_bridge_pci_mem
> > >      0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
> > >        0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4          <---- (1) VFIOBAR::mr
> > >          0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4             <---- (2) VFIOBAR::VFIORegion::mem
> > >            0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0] <---- (3) VFIOBAR::VFIORegion::VFIOMap::mem
> > >
> > >    (1) Its MemoryRegionOps is NULL. No data accesses are routed to this region
> > >    (2) The data accesses routed to this region is handled by pread() and pwrite()
> > >    (3) The data accesses routed to this region is handled by memcpy() before
> > >        commit 4a2e242bbb.
> > >
> > > There are identified PCI devices who have quirks, see vfio_bar_quirk_setup().
> > > Accesses to part of the PCI BAR have to be emulated by the extra IO regions,
> > > something like below for rtl8168 PCI device, where two extra IO regions are
> > > stacked up for the quirks.
> > >
> > >    address-space: pci_bridge_pci_mem
> > >      0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
> > >        0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4          <---- (1) VFIOBAR::mr
> > >          0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4             <---- (2) VFIOBAR::VFIORegion::mem
> > >            0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0] <---- (3) VFIOBAR::VFIORegion::VFIOMap::mem
> > >            0000042000000010-0000042000000014 (prio 1, i/o): 0009:01:00.0 BAR 4 quirk[0]  <---- (4) quirk[0]
> > >            0000042000000018-000004200000001c (prio 1, i/o): 0009:01:00.0 BAR 4 quirk[1]  <---- (5) quirk[1]
> > >
> > > Access on 0000042000000010-0000042000000014 should be routed to region (4) quirk[0]
> > > and access on 0000042000000018-000004200000001c should be routed to region (5) quirk[1].
> > > However, accesses to 0000042000000000-0000042000000020 are routed to region (3) before
> > > commit 4a2e242bbb and the data transfer is done by memcpy(), bypassing region (4) and
> > > (5). It's not the expected behavior and why memcpy() isn't expected on device rtl8168's
> > > PCI BAR due to the quirks, answering your question.
> > >
> > > With commit 4a2e242bbb applied, the accesses will be routed to the correct region.
> >
> > The way I read 4a2e242bbb's commit message, it isn't about things being routed
> > to the wrong region. It's about the handling of areas which aren't in the small
> > quirk regions but which are in the same 4K page as them. These have to
> > be handled
> > via the memory subsystem's "subpage" mechanism. This does route
> > everything to the
> > correct region, but if the region (3) is marked as "direct access is OK" then
> > QEMU assumes that any kind of direct access is OK, i.e. this behaves
> > like true RAM.
> > It then does a memcpy access to a BAR that's really a bank of device registers,
> > and this goes wrong.
> >
> > > Back to our case (GH100 card), there are no quirks for the PCI BAR (0009:01:00.0 BAR 4)
> > > so it's fine mark the RAM DEVICE region as directly accessible. We perhaps needn't host
> > > to export the capability (VFIO_REGION_INFO_CAP_DIRECT_ACCESS) suggested by you. It's
> > > safe to mark any PCI BARs as directly accessible if they have no quirks attached. All
> > > the devices except those listed in vfio_bar_quirk_setup() are capable of this.
> >
> > I still feel like there are different kinds of PCI BAR here ("this BAR is
> > true RAM and can be accessed arbitrarily" vs "this BAR is full of registers
> > and can't be handled that way") and the vfio code in QEMU needs to set up
> > the memory regions differently for the two cases. For your example I think
> > it would be fine to have direct-access even if there were some kind of
> > quirk memory region, because for the parts of the BAR that aren't covered
> > by a quirk overlay the underlying BAR still allows "entirely like RAM,
> > any alignment and size is OK" accesses.

> Yea, and I feel this is the main part:
>
>     The assumption here is that accesses initiated by the VM are
>     driven by a device specific driver, which knows the device
>     capabilities.
>
>
> Frankly I don't get why a big hammer of disabling direct access
> was taken, when all we apparently need to do is to make sure
> small aligned accesses through BAR stay aligned and same size.

If you say an MR is OK for direct access then in my view you are
saying "any access of any kind is OK", because you're permitting
the pointer to be directly returned as a host pointer from
address_space_map() (at which point the caller might do anything
with that memory). That is not OK for every BAR, only for ones where
it's really RAM.

> I guess it felt safe - a vfio specific change, and emulating device
> accesses was assumed to be slow path, anyway.
>
> Except it no longer is with people wanting to do direct io
> into device BARs.

> Isn't it basically the below?
> At least I checked asm and it produces the correct code.
> And then the whole pile of hacks can be reverted?
>
>
> diff --git a/system/physmem.c b/system/physmem.c
> index 7bcbf87573..aab4390d40 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3272,7 +3272,29 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
>          uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
>                                                 false, true);
>
> -        memmove(ram_ptr, buf, *l);
> +        switch (*l) {
> +        case 1:
> +            __builtin_memmove(ram_ptr, buf, 1);
> +            break;
> +        case 2:
> +            __builtin_memmove(ram_ptr, buf, 2);
> +            break;
> +        case 4:
> +            __builtin_memmove(ram_ptr, buf, 4);
> +            break;
> +        case 8:
> +            __builtin_memmove(ram_ptr, buf, 8);

Nothing says that __builtin_memmove() is required to do only a single
access of the right size. memmove() can do all kinds of things.
For instance on aarch64 if you get into the actual glibc memmove then
a memmove of 1 byte will actually store the same byte multiple times.
Or an architecture might decide that it's more efficient to do an
8-byte write with two 4-byte writes even if there is an 8-byte access
instruction.

If and where we need to provide guarantees about "this access will
really definitely only do this size access and it won't break it
apart or anything like that" then we need to either be using compiler
atomics or else inline asm.

(I think there are places where we do need to be more careful about
what we do with accesses to real RAM, for where we're emulating a
device write to RAM that's updating a data structure shared with the
guest, and things like writing multiple times can cause problems.
https://lore.kernel.org/qemu-devel/CAFEAcA8dwHV8F48kb-013rxkG9kKcZhym9_qarKmoeUfeh0YWw@mail.gmail.com/
is an unrelated example of that, which I haven't done detailed
analysis of yet.)

thanks
-- PMM

