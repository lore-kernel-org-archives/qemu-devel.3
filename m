Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B299FFF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 08:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHzz7-0007IQ-NS; Wed, 29 Apr 2026 04:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wHzys-0007Fx-H6
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 04:09:14 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1wHzym-0007ZC-8B
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 04:09:12 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ba6b39871a3so111666566b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 01:09:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777450145; cv=none;
 d=google.com; s=arc-20240605;
 b=ZRYAeWL047Dqd+k1aOI3Y6lsnICyr5MUF8bTvmmswkPJxPOpzIU/WH2plQJZPyb8US
 0dBIy6U/eEvFo5Kdh9x1+z8LIRDIHUb4BmXJR03u4u2D4Jyo18I2LRR+fw+RhC++kID5
 tjCH59Tnh2p1JlAI91XHG6YkhsMyTibvXNNZVxSbujd1p07hjgrlirsUakOyJMze1R21
 hU/6z6Y1TflIiEwgkX+yytwTbOuWyB6gqPt8KW8QeREzre9QfJW9iI7Qo1JbavFXf5/F
 mCo1gz6RwXGMvnmbRA/zZDgN17P28rxgKzmXB1DirWsNJKebCnzL3EsWuPSzMjCxVIhy
 e2Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8DGl+xCaRMQmJRrQBYDIXynLmoFr7h453ckiT7GmLow=;
 fh=NX/RkK8NlS2Ov+x46b1s22NYb6qLuiuqJyZLvKgl/YM=;
 b=Jji25spGqQYUnrv2AMwQ9ssO48W+KSReu7vF6UylpRXLjf/QJNv7T/z1SKIMFDXk9c
 ToT09NxxOwjltHr7f+jDtj56+mHh2v3hV/oAKe8+pNRa6qo56V4Gcd+Gn/6vGUE4vj6j
 JIzQKV4dk3EXX/Qs54uBrmjzYkN9uEmdF0wqM1WrCVt9jHlZgfc/jEyANLILDGq0cKA1
 Gx8fds7EXQK4L9X4A2J+4GNsg8fhMfs6GWPV1ckCgkJzm+DtW/zQKdqWLraHbDzfqtw8
 QAR27V/0AYgvvsSmt98RPKCCE214iDJKdL6EYhN2AAl/cBgvzstZYzPO7+3zn1teGhTI
 bI5A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777450145; x=1778054945; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8DGl+xCaRMQmJRrQBYDIXynLmoFr7h453ckiT7GmLow=;
 b=RSFKKaEECaQQSiLN/ezdvJ6SWspZT9o6jMurtt7v3H1g6q/cWYYg7QPlQ45lAlTHxN
 la0IS8CFUhVMaRM7Ag/XTcti7TabVAVJkkaHc4QonxK3Ksw4G/mjPwJGSsOVJQl+aWaV
 xcBzAi6p2TcQFeFlHCv+vWII6CNqhuRKWhsKKfq0CjCEBOFVp5XDGNPg0hEDOrsVJg6r
 Wb5+igodNuU64s55NlcF21gBTnhanuzpSGE68eyDm2iN5m+/yeb6bBiqoiMKM5nOmWvC
 KGAiMtCCbppCdA1tYzfarWuJQ8bK7TNlvd7bYk2nf71Nau+nNaZLOVoNv6Ie7Dr3YY99
 Jixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777450145; x=1778054945;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8DGl+xCaRMQmJRrQBYDIXynLmoFr7h453ckiT7GmLow=;
 b=W8Ru4aqQO8fK7KgGdeDs1LvzzkS+ucW6nc/Ux6J0UHviFwoTNv+Sw2KXzys52Tfnlc
 kzkLkYyE+wqOAGrRGnNsWKE+SCEFdB1qVz4HSPpcyu1p3dXdh03NoCHQVJWsIe4hRO0n
 vgqvol7tHqikjHCR7xMPtBmYq+PWtIKsNdIipXhXbRq2yFqbL8vqpdUm9j8ticbSJ2Z9
 f2oQLtUTkBBcWN5I8beUKtKv+gqTzKYdkzShmy8AaGvtwMiBIpnJ6kIeQW7qnNlnrGoJ
 +r2e0VPDUeKJLmFAjOwqSgXHWDJuenxzDfANeM9bAl6hToDH2z4bcOG5eFVoxecOX8ID
 XRBw==
X-Gm-Message-State: AOJu0YxosSqkY67Kioj5zwcjJ2O0DUMGmIKDCRdDT+JoPEi+MuvTCQMI
 wJaILpLjPVu7P3dZJwygkrlQvL9QAV9nGvobmk0CUfHiaDn4xd3tIffouahBY0ZRJIBpoetQKcv
 WOYm7HE1mjXefj44tp3lJbLLov9is98gW3PE1zKqx7g==
X-Gm-Gg: AeBDiesEYGQENrTYtXkB9HQMUWqMi4jUzEZa42d9GCrSbgl3cYjZZLXiw00eG1ue6UC
 VT1pNATPKfXzNWKGVKVYgDnvmrBjCBc6yyvKaAhD5cwKwLQI27M4heQrH5j2Qc/FgCKWN3ErXyJ
 wMgj7fwlPZUc10WczWrYOVsKQafYd9qJJqz3ADyYwUU0QksOWIe3rtYPT7UmRjwK8WqtRgLik1r
 NgjoRbJ+OG1VaUvmG50GeZOdTrMvIS1uLcAsWpIfEPI03KQa7sP6auYV8qAhnmea0RUrVcfNJzT
 BG947o5Fo6Tw6P1pjxKbmZ34yqpAMjo=
X-Received: by 2002:a17:906:8f13:b0:ba4:ebe4:d2f2 with SMTP id
 a640c23a62f3a-bb969ebd8fdmr81349366b.4.1777450144644; Wed, 29 Apr 2026
 01:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260421162912.3295598-1-jim.shu@sifive.com>
 <a422dbe1-7955-4fb1-b88a-0d091c525019@oss.qualcomm.com>
 <CALw707ow5D9nSmNARckozOmKOTBpOATFFNPMski9Y-yjD6RiWg@mail.gmail.com>
 <bc5d23b6-1d2e-4509-a148-be39114213b7@oss.qualcomm.com>
 <CALw707qmq813FDueR2e-Sh_MiD8gtoHFxR9nn9N-Mt5rKFXamw@mail.gmail.com>
 <df045780-3766-4439-9868-11d6c120187d@oss.qualcomm.com>
In-Reply-To: <df045780-3766-4439-9868-11d6c120187d@oss.qualcomm.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Wed, 29 Apr 2026 16:08:52 +0800
X-Gm-Features: AVHnY4J9CgKy4hhryQGwK8WHxjS39AEt4nV_A1wmll0hMUx0p_vFA_f5HEu1OhQ
Message-ID: <CALw707qhPxYHqBZVJFaYJmBfaSEZwamKxg82bRs9BrEmtZK82A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Defer the IOMMU translation and support access_type
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>, 
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Bastian Koppelmann <kbastian@rumtueddeln.de>, Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=jim.shu@sifive.com; helo=mail-ej1-x62f.google.com
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

On Sat, Apr 25, 2026 at 6:44=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 4/24/2026 8:15 AM, Jim Shu wrote:
> > On Fri, Apr 24, 2026 at 2:25=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 4/22/2026 11:16 PM, Jim Shu wrote:
> >>> On Thu, Apr 23, 2026 at 12:01=E2=80=AFAM Pierrick Bouvier
> >>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>
> >>> Hi Pierrick,
> >>>
> >>> Thanks for discussing the design!
> >>>
> >>>>
> >>>> Hi Jim,
> >>>>
> >>>> On 4/21/2026 9:29 AM, Jim Shu wrote:
> >>>>> Note: v1 title is "accel/tcg: Pass the access_type to IOMMUMemoryRe=
gion"
> >>>>>
> >>>>> Incoming security protection devices feature more complex IOMMUMemo=
ryRegion
> >>>>> implementation in the CPU path than ARM MPC device. For example,
> >>>>> RISC-V wgChecker [1] may permit the access with only RO/WO permissi=
ons.
> >>>>> Consequently, the IOMMUMemoryRegion could return different sections=
 for
> >>>>> read & write access.
> >>>>>
> >>>>
> >>>> The consequence is not directly implied for me.
> >>>>
> >>>> Why having a single translation and page protection handle read/writ=
e
> >>>> access is not enough here?
> >>>>
> >>>> What is the (real world) use case to return different physical memor=
y
> >>>> locations depending on read/write access for a given virtual address=
?
> >>>
> >>> When permission is granted, the wgChecker device returns the original
> >>> region of the address, called the downstream region
> >>> When permission is denied, the wgChecker device returns a special
> >>> MemoryRegion for error handling, called the blocked_io region).
> >>> This region may trigger an IRQ and a bus error. Additionally, memory
> >>> accesses to this region will result in 'read 0, write ignored' rather
> >>> than triggering exceptions from the MMU or MPU.
> >>>
> >>> Consequently, implementing RWX permission checks on security
> >>> protection devices may return different regions (either downstream or
> >>> blocked_io) depending on the access type.
> >>> This design is similar to the existing ARM MPC device
> >>> (hw/misc/tz-mpc.c). The primary difference is that the MPC only check=
s
> >>> the physical address rather than RWX permissions, meaning it returns
> >>> either the downstream or blocked_io region for a single address
> >>> regardless of the access type.
> >>>
> >>
> >> It is indeed, a big difference. Translation with MPC device still
> >> results in a single address space being chosen.
> >>
> >>> I also considered an alternative design where CPUTLBEntryFull stores
> >>> both the successful permission and the blocked_io region of the IOMMU
> >>> region.
> >>> In this scenario, the slow-path code utilizing CPUTLBEntryFull would
> >>> check permissions and return the blocked_io region if access is denie=
d
> >>>
> >>> However, the address_space_translate_iommu() implementation supports
> >>> recursive IOMMU region translation.
> >>> if multiple IOMMU regions are encountered during a single address
> >>> translation, storing only the first region's permissions is
> >>> insufficient.
> >>> Ultimately, we still face a situation where RWX permissions might
> >>> return different regions separately (e.g., downstream,
> >>> blocked_io_iommu1, and blocked_io_iommu2).
> >>>
> >>
> >> The "blocked_io_iommu_X" is a consequence of the current choice of
> >> implementation, but I still don't see why it's an absolute necessity.
> >>
> >
> > I am open to removing it if the community agrees. I believe platforms
> > with the ARM MPC do not use multiple IOMMU regions when translating a
> > single address.
> >
>
> I am not expert on the topic, but it seems MPC is mostly used with
> microcontrollers with trustzone and is much more limited in scope than
> WorldChecker. WorldChecker seems to be a mix of MMU + IOMMU + something
> like Arm Granule Protection Table in a single external component.
>
> I am probably biased by Arm "World" implementation of this (out of MPC),
> where CPU and SMMU play this role, instead of an external component.
>
> Going back to MPC, the translation is still deterministic and not based
> on type of access. From what I understand, MPC can statically forbid
> accesses to specific blocks, simply based on original address.

ARMv9-A GPC verifies permission within the CPU MMU and IOMMU. It
performs checks when the memory transaction is travel from the source
(such as a CPU or DMA) toward the system bus. In contrast, RISC-V
wgChecker is positioned directly in front of peripheral devices. It
performs checks when the transcations travel from the bus toward the
target devices. In this regard, the ARMv8-A TZASC [1] and ARMv8-M MPC
are architecturally similar to the RISC-V wgChecker.

We can monitor all memory transactions in the SoC by implementing
security filters at either every transaction source or every
transaction device. These 2 designs are both reasonable, representing
different approaches to SoC security architecture.

ARMv8-A TZASC [1] is also the target-side filter and includes RW
permission checks. While the TZASC device is not supported in QEMU
now, it could also leverage these generic code changes when
implementing it. Target-side filtering with RW permission checks is
not a RISC-V only design.

[1] https://developer.arm.com/documentation/ddi0504/c/introduction/about-th=
e-tzc-400/tzc-400-example-system

>
> >> An alternative would be to treat all accesses as MMIO, but I guess you=
r
> >> goal here is to optimize the code path where we access RAM?
> >>
> >
> > If the downstream region is a memory region, it will update the TLB
> > flags and vaddr in addr_idx for the successful permissions of IOMMU
> > region.
> > To explain further: In the alternative approach, we would obtain the
> > downstream region, IOMMU permissions, and the blocked_io region from
> > the IOMMU translation function (which would require an additional
> > return value or API to get the blocked_io region). The TLB entry will
> > handle the downstream region as a non-IOMMU region but will only
> > update the TLB flags for the IOMMU permissions; it will also store the
> > permissions and the blocked_io region. The slow-path code checks the
> > IOMMU permissions. If permission is denied, it will perform the
> > transaction on the blocked_io region instead.
> > We can remove the lazy IOMMU translation if using an alternative approa=
ch.
> >
>
> What I was suggesting in my question was to force any access to a
> MemoryRegion handled by a wgChecker to go through a read or write
> callback, and to do the actual check there.
>
> For instance, MPC redirects blocked calls to:
> static const MemoryRegionOps tz_mpc_mem_blocked_ops =3D {
>    .read_with_attrs =3D tz_mpc_mem_blocked_read,
>    .write_with_attrs =3D tz_mpc_mem_blocked_write,
>
> So I was suggesting something like:
> static const MemoryRegionOps wgchecker_ops =3D {
>    .read_with_attrs =3D wgchecker_mem_read,
>    .write_with_attrs =3D wgchecker_mem_write,
>
> And redirect all read/write to those callbacks, thus turning the whole
> range into an MMIO range. Thus my original question to understand if
> your main concern is runtime performance or not.

Yes, runtime performance is also critical to us.
We have positioned the wgChecker in front of the DRAM [2] to partition
the memory for each world.
If using the slow path for DRAM access, Linux will be too slow to boot.

[2] Add WG support to virt machine:
https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com/2025102=
1162108.585468-4-jim.shu@sifive.com/

>   >> Why can't you reuse existing page protection mechanism for this,
> >> authorizing read or write? WorldChecker just seems to be an additional
> >> check on top of existing translation. The fact it's an "additional"
> >> device is a design/implementation details, and could simply be part of
> >> page protection mechanism. It might require some additional plumbing
> >> when an interrupt is raised though, to redirect this correctly instead
> >> of signaling CPU like it would normally do.
> >>
> >> The fact is does different action based on read/write attribute does n=
ot
> >> really fit very well with existing implementation, as you noticed. And=
 I
> >> wonder if it's worth changing the global design just to optimize this
> >> (optional) use case for RISC-V.
> >>
> >
> > In the SoC architecture, the wgCheckers are positioned in front of
> > devices (either memory or MMIO). When the CPU or DMA sends
> > transactions to the device, the device's wgChecker first performs a
> > permission check to determine if the transaction should be forwarded.
> > If we move this check to the architecture's tlb_fill() function, how
> > would the CPU code determine if transactions were sent to the device
> > (or to the upstream region of the wgChecker)? The CPU code would need
> > to be aware of the memory tree hierarchy to do that, which I believe
> > is more difficult to implement.
> >
>
> The memory hierarchy has to be known anyway by the component dealing
> with that. Currently, TLB is responsible for it, iterating through the
> different regions. However, it could be wgChecker code that does that,
> or tlb_fill() for RISC-V.
>
> My only concern with existing design is that it pushes all that on
> generic TLB code, for a feature that is optional and only used by
> RISC-V, but still impacting all architectures.
>

I don't think current address_space/flatview APIs can determine if a
PA will access an IOMMUMemoryRegion and return that specific region.
To perform this check in the tlb_fill() or wgChecker device, I would
need to add this new API to get the correct wgChecker instance and
perform the permission check of it. Thus, this approach still requires
modifying the generic code to add the new address_space API.

I can try my best to minimize the changes of generic TLB code, but it
is impossible to support wgChecker w/o any modification of generic
code. Original MPC patchset also adds the CPU-side IOMMU region
support to address_space_translate_for_iotlb() [3] and adds the
TCGIOMMUNotifier.

My v1 patchset has fewer modifications of generic TLB code, but it
relies on ping-pong TLB entries for RW permission seperately. It is a
little tricky and may not be easy to maintain. I tried to formalize
the changes of TLB entry for the IOMMU region with RW permission in v2
patchset via lazy IOMMU translation.

[3] https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg00666.html

> It's not a no, I don't have any authority on this part of codebase, but
> just a question to understand why it can't be solved another way that
> would be RISC-V specific.

As I mentioned above, ARMv8-A TZASC also has a similar design.


>
> > In the current QEMU architecture, when a security protection device
> > sits in front of a device, placing it within the memory tree seems to
> > be the most suitable approach, similar to the ARM MPC device. The
> > address_space*() API can check if a transaction will be forwarded to
> > the device and perform the permission check via the IOMMU region. Both
> > the CPU-side address_space_translate_for_iotlb() and the DMA-side
> > address_space_translate_iommu() handle this. The only missing
> > component is that the CPU TLB cannot handle RWX permission checks for
> > IOMMU regions within the memory tree.
> >
>
> I understand this and what you want.
> I'm really open to it if anyone else has feedback on this, and help
> decide if it's worth changing generic TLB code for this use case.
>
> >
> >
> >
> >>>>
> >>>> I'm not against the goal of this series, but trying to understand wh=
y it
> >>>> went in this direction, which complexify this already complex code p=
ath.
> >>>>
> >>>>> To support such IOMMUMemoryRegion behavior in the CPU path, the des=
ign
> >>>>> of IOMMU translation must be updated:
> >>>>>
> >>>>> 1. address_space_translate*() must now pass the access_type to
> >>>>>       IOMMUMemoryRegion.
> >>>>> 2. Since IOMMU translation results are too complex to be fully stor=
ed
> >>>>>       in the CPU TLB. we will defer the translation until the actua=
l access
> >>>>>       occurs. Also, TLB is allowed to store the untranslated IOMMU =
region.
> >>>>>
> >>>>> To implement deferred IOMMU translation, this patchset introduces t=
he
> >>>>> following changes:
> >>>>>
> >>>>> 1. tlb_set_page_full() no longer translates the IOMMU region
> >>>>>       immediately. Instead, it stores the untranslated region direc=
tly in
> >>>>>       the TLB. A new slow-path flag, TLB_IOMMU, is introduced to fo=
rce
> >>>>>       access into the slow path when a region has not yet been tran=
slated
> >>>>>       in the TLB entry.
> >>>>>
> >>>>> 2. When the CPU utilizes a TLB entry in the slow path, it should pe=
rform
> >>>>>       the lazy IOMMU translation of the access_type first. The resu=
lting
> >>>>>       translated region and access type are stored in CPUTLBEntryFu=
ll.
> >>>>>       Since the slow path always performs lazy translation first, w=
e can
> >>>>>       switch the CPUTLBEntryFull content to the correct access type=
 before
> >>>>>       use.
> >>>>>
> >>>>> 3. To accelerate memory access in the fast path, lazy translation c=
an
> >>>>>       update the addend of the CPUTLBEntry when translating the reg=
ion to a
> >>>>>       host memory region. We restrict the IOMMU region to have a si=
ngle
> >>>>>       non-zero 'addend' across all permissions. If a second 'addend=
' is
> >>>>>       present for a CPUTLBEntry, QEMU will trigger an assertion. Th=
is
> >>>>>       limitation is sufficient for security devices, as their "seco=
ndary"
> >>>>>       region is typically an IO region used to emulate device error
> >>>>>       handling when access is rejected.
> >>>>>
> >>>>> 4. To support non-slow TLB flags, lazy translation can update the T=
LB
> >>>>>       flags in the 'addr_idx' of the CPUTLBEntry. Lazy translation =
only
> >>>>>       updates the flags for the permissions specified in @prot. Thi=
s
> >>>>>       ensures that each access_type of a translated region to maint=
ains
> >>>>>       independent TLB flags. For example, TLB_DIRTY of memory regio=
n will
> >>>>>       not be "polluted" from other permission that translated to di=
fferent
> >>>>>       region.
> >>>>>
> >>>>> Both RISC-V wgChecker [1] and RISC-V IOPMP [2] devices require this
> >>>>> feature.
> >>>>>
> >>>>> [1] RISC-V WG:
> >>>>> https://patchew.org/QEMU/20251021155548.584543-1-jim.shu@sifive.com=
/
> >>>>> [2] RISC-V IOPMP:
> >>>>> https://patchew.org/QEMU/20250312093735.1517740-1-ethan84@andestech=
.com/
> >>>>>
> >>>>> Changed since v1:
> >>>>> - Remove the ping-pong TLB entry behavior. Instead, defer the IOMMU
> >>>>>      translation until actual access in the CPU path. Provide a IOM=
MU
> >>>>>      lazy translation function with the special handling of 'addend=
'
> >>>>>      and 'addr_idx' fields of CPUTLBEntry.
> >>>>> - Fix the checkpatch warning.
> >>>>>
> >>>>>
> >>>>> Jim Shu (5):
> >>>>>      accel/tcg: Pass access_type as an argument of tlb_set_page*()
> >>>>>      accel/tcg: address_space_translate*() will pass the correct
> >>>>>        iommu_flags
> >>>>>      accel/tcg: Provide early AS translate function
> >>>>>      accel/tcg: Add IOMMU lazy translation function
> >>>>>      accel/tcg: Support IOMMU lazy translation in CPU TLB
> >>>>>
> >>>>>     accel/tcg/cputlb.c                   | 247 ++++++++++++++++++++=
+++++--
> >>>>>     include/accel/tcg/iommu.h            |  17 +-
> >>>>>     include/exec/cputlb.h                |  11 +-
> >>>>>     include/exec/tlb-flags.h             |   4 +-
> >>>>>     include/hw/core/cpu.h                |  15 ++
> >>>>>     system/physmem.c                     |  60 ++++++-
> >>>>>     target/alpha/helper.c                |   2 +-
> >>>>>     target/avr/helper.c                  |   3 +-
> >>>>>     target/hppa/mem_helper.c             |   1 -
> >>>>>     target/i386/tcg/system/excp_helper.c |   3 +-
> >>>>>     target/loongarch/tcg/tlb_helper.c    |   2 +-
> >>>>>     target/m68k/helper.c                 |  10 +-
> >>>>>     target/microblaze/helper.c           |   8 +-
> >>>>>     target/mips/tcg/system/tlb_helper.c  |   4 +-
> >>>>>     target/or1k/mmu.c                    |   2 +-
> >>>>>     target/ppc/mmu_helper.c              |   2 +-
> >>>>>     target/riscv/cpu_helper.c            |   2 +-
> >>>>>     target/rx/cpu.c                      |   3 +-
> >>>>>     target/s390x/tcg/excp_helper.c       |   2 +-
> >>>>>     target/sh4/helper.c                  |   3 +-
> >>>>>     target/sparc/mmu_helper.c            |   6 +-
> >>>>>     target/tricore/helper.c              |   2 +-
> >>>>>     target/xtensa/helper.c               |   3 +-
> >>>>>     23 files changed, 354 insertions(+), 58 deletions(-)
> >>>>>
> >>>>
> >>>
> >>> Regards,
> >>> Jim
> >>
>
> Regards,
> Pierrick

Regards,
Jim

