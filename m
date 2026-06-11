Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E249CD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXeqc-0006eM-DM; Thu, 11 Jun 2026 08:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXeqW-0006di-JG
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:49:20 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXeqU-0002ea-DX
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:49:19 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-660ea43107fso7577873d50.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:49:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781182144; cv=none;
 d=google.com; s=arc-20240605;
 b=MRy+d0QmrNqBJ8ir5dlb5Q1kPHCk/GU9C108FFXUNj0BAGvOaQKVb1OxD10aA3LLuK
 c0lVv9Jgugr29suUuSY97PwknO8yz6pwZ5Ne36J2rax9bQzTK1tvqdeY4zbCYrE3d3Vd
 W0wGmXPBaU9GDAlzP8EzO9HdlKxC4xM/UMabFaAM9bon4oJxiAoo4NIaWaSfcFSZm7a+
 BzOmGv0GqdW/ImUqoKSX+JS1YfFU6UtbgU5seJGnrJYu6N0sJ6vJGxNspi6u48SdHnEY
 1S+W6fz8XSM/0ZwyQ9y51QnDHLbSkEMsyuXuP4A8gWz9zdbeSwv03omgXY4fc5wOxqku
 xoOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qqycDn120OGbgsejPQp28DpSYFYsYk8AKQpL68g/OVM=;
 fh=gNtqrFR6e7sdTKRuHQK+EXx/lt9ipX0xWM3n0kxZocA=;
 b=hqfqVESK7hKrzwsiftNAHOizIXoneQWQU/pbrpFPmi8WQg8bcbNE7siLs1u/Z3zKPL
 aYgT/REiyKa9t1xo4wSn8WHvKQ2iJpFA4DwOBZxsCI6qaqFTSX/tpUNEd5EnxdM2Mviu
 NGbSJVHSa6c/XnAy2aLjIScHGxd+MG63DQZDeIsv6dE2tS9nHVdbfB4POKz+VYD6XaYQ
 sHuS92VHacXUfI1zJFIHpYz7Uo47Ra/7lhazNKc3xgjDw2dwONKIeuJ9OMCRusFNafcn
 m7ADnDLPQ/P0wY+uIR78A5ViN4S2kPwa4QOKzJCLDthpVo8VHO/no+SQWwHudejHDV91
 LGUQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781182144; x=1781786944; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qqycDn120OGbgsejPQp28DpSYFYsYk8AKQpL68g/OVM=;
 b=uQ6pJcfLZjE5kTZVhnvFsGH3kf9e6PD0vzmIrgiDSfxwk+/PDdaM0KUrRqBul5cC1N
 nrgAmWOMHViKBjjBiO8atPqSVzF5BsW7FN4hRQY7T/d1ZRZyT+A2oTAOusIW5RSp89GX
 Ay9qejnJHhdsEzyDy4z1g/3s4X2+JYkManw1NHGh1alf5KKwMQRbJ144IrHWj3UARGVb
 NbleHRwny/iU9gq6KYfI8sWx9gHYc8XDQrGukXqDpTSYomByh0ZS4GlNSFKQyF5W1KEG
 FWP8dMdxE487wtBvnUV8doPScH4kRBh4QvgMVEWxB+t1OfH2gthzmOwZWVVSNgkdgIbA
 v6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781182144; x=1781786944;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qqycDn120OGbgsejPQp28DpSYFYsYk8AKQpL68g/OVM=;
 b=dUm2mGz4Ay6Qpzeu4peweVp/G9aN2mEINKElQ1T5/e1LRI1YZhNS4Z5F0orU3W1NMr
 iuwuQgV9BVk2VSkdXH3mqXtz8ErRT7MkgNx04jebe4yTYTLDRe85fpubXdA9NNtg4mpy
 eE2VHLzm1yrFJHT4ykQMXhrLvLsqMSs13UWvtsinbWhMt67HDeZdg1gJXyc9eKftUG3I
 +Uvankf1UBQOx1fhOWXT/10Rmm9xrhFrAGL/zXe8/+NEb1tB5AJ0gOaDTQMI9VcBgXnm
 cHFnhwg3E543tOmPXYeseDrolQfQLIldNacnkwI+RwjOLZS2a8puToYHVfpr7Ao48Koc
 NtTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2ZeTdzR0SocdkEbqYbYaZpXklAiDcZGCB6CtkvyE5gMAfa3zmyjCdIp5pBtdYem+6FIGzvdEwtIlu@nongnu.org
X-Gm-Message-State: AOJu0YxsijhehtRisbNEToNGfpidcPWYWefErG8uKjUbbxQ4EQvvxrJ5
 Fx/YX91LVC0bQj+5RhjauASO89WR5A5fG70+5KEdEbAhL4zbTKKeBASxpmsRqjb5PtbHV03Fd2f
 a/D9c0PCWG8CEvbPyVv10EfYrP7rGuKdYCkit2ASa2w==
X-Gm-Gg: Acq92OH8TSkQ6ZgWc8g42Y003dfOhFgxvVLOMXXulwgTpLMMtFhzwDtI/k3HEtUakyO
 ++G1mzc58GwBHZdixpqsKECIjIMiZp6lHYb9eUMeU9hvYxhZLijL7xMzn6OvQO2e9v/zPxzCC7w
 Zi3Bn8fAjWDTbtiF/b5rfQjYjjdM3/J4tGwhHvHyR3xeiR4rPuP7Y8fByQ7js5Bv/WZqZqZ8QbU
 jOIJ5S90+I2ZzKnYTCeGRPWlC/s8U0yKgT6xyl/BMsadpa+mkh01rOknH8uyyYHQ2p9IyVd2S/Q
 bnrXHcNCFPkRpcs1QyC5gRvI3XQzGR04m1Q0y7hfkLEOMJyWMoXmN/yUmuT+1Goh0N6FR56A7qL
 HqA==
X-Received: by 2002:a05:690e:d4a:b0:660:3426:3ff4 with SMTP id
 956f58d0204a3-6626969054fmr1966311d50.18.1781182143729; Thu, 11 Jun 2026
 05:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <eb0f0da1-11dd-4437-94fd-a65af55851e1@redhat.com>
 <20260610082637-mutt-send-email-mst@kernel.org>
 <5d8cbd4b-3725-437e-88a3-e0af32164815@redhat.com>
 <e7cc9f2d-ccb4-442f-a1ed-7c5474395099@redhat.com>
 <20260610095712-mutt-send-email-mst@kernel.org>
 <aimEl9QQ_LTRPLtd@x1.local> <20260610121026-mutt-send-email-mst@kernel.org>
 <1e9515c9-7e32-4d95-9b73-aab8bf10bddc@redhat.com>
 <20260611012217-mutt-send-email-mst@kernel.org>
 <3726a607-6cac-41f1-b402-0eed7c4e3fe3@redhat.com>
 <20260611023428-mutt-send-email-mst@kernel.org>
 <0c3f1dba-3b2c-43c5-b181-1426f6da0951@redhat.com>
In-Reply-To: <0c3f1dba-3b2c-43c5-b181-1426f6da0951@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jun 2026 13:48:51 +0100
X-Gm-Features: AVVi8CdkA_O0e4tTX1ZuiWwP5ApvcjMvfT5ewGYi8PdSYO2s37C-Y3yrY1yYGZA
Message-ID: <CAFEAcA8Q9qEaZS8wCpZQ-4jpAnQ9JXvnb7iSeRTdhJ9Y3BcCRg@mail.gmail.com>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
To: Gavin Shan <gshan@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Pavel Hrdina <phrdina@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com, 
 shan.gavin@gmail.com, Alex Williamson <alex@shazbot.org>, 
 David Hildenbrand <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Thu, 11 Jun 2026 at 13:34, Gavin Shan <gshan@redhat.com> wrote:
>
> Let me try to summarize what I understood. As VFIO is concerned, there
> are multiple memory regions for one particular PCI BAR, and they're stacked
> up. The memory regions for PCI BAR#4 of the GH100 card looks as below.
>
>    (qemu) info mtree
>               :
>    address-space: pci_bridge_pci_mem
>      0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
>        0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4          <---- (1) VFIOBAR::mr
>          0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4             <---- (2) VFIOBAR::VFIORegion::mem
>            0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0] <---- (3) VFIOBAR::VFIORegion::VFIOMap::mem
>
>    (1) Its MemoryRegionOps is NULL. No data accesses are routed to this region
>    (2) The data accesses routed to this region is handled by pread() and pwrite()
>    (3) The data accesses routed to this region is handled by memcpy() before
>        commit 4a2e242bbb.
>
> There are identified PCI devices who have quirks, see vfio_bar_quirk_setup().
> Accesses to part of the PCI BAR have to be emulated by the extra IO regions,
> something like below for rtl8168 PCI device, where two extra IO regions are
> stacked up for the quirks.
>
>    address-space: pci_bridge_pci_mem
>      0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
>        0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4          <---- (1) VFIOBAR::mr
>          0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4             <---- (2) VFIOBAR::VFIORegion::mem
>            0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0] <---- (3) VFIOBAR::VFIORegion::VFIOMap::mem
>            0000042000000010-0000042000000014 (prio 1, i/o): 0009:01:00.0 BAR 4 quirk[0]  <---- (4) quirk[0]
>            0000042000000018-000004200000001c (prio 1, i/o): 0009:01:00.0 BAR 4 quirk[1]  <---- (5) quirk[1]
>
> Access on 0000042000000010-0000042000000014 should be routed to region (4) quirk[0]
> and access on 0000042000000018-000004200000001c should be routed to region (5) quirk[1].
> However, accesses to 0000042000000000-0000042000000020 are routed to region (3) before
> commit 4a2e242bbb and the data transfer is done by memcpy(), bypassing region (4) and
> (5). It's not the expected behavior and why memcpy() isn't expected on device rtl8168's
> PCI BAR due to the quirks, answering your question.
>
> With commit 4a2e242bbb applied, the accesses will be routed to the correct region.

The way I read 4a2e242bbb's commit message, it isn't about things being routed
to the wrong region. It's about the handling of areas which aren't in the small
quirk regions but which are in the same 4K page as them. These have to
be handled
via the memory subsystem's "subpage" mechanism. This does route
everything to the
correct region, but if the region (3) is marked as "direct access is OK" then
QEMU assumes that any kind of direct access is OK, i.e. this behaves
like true RAM.
It then does a memcpy access to a BAR that's really a bank of device registers,
and this goes wrong.

> Back to our case (GH100 card), there are no quirks for the PCI BAR (0009:01:00.0 BAR 4)
> so it's fine mark the RAM DEVICE region as directly accessible. We perhaps needn't host
> to export the capability (VFIO_REGION_INFO_CAP_DIRECT_ACCESS) suggested by you. It's
> safe to mark any PCI BARs as directly accessible if they have no quirks attached. All
> the devices except those listed in vfio_bar_quirk_setup() are capable of this.

I still feel like there are different kinds of PCI BAR here ("this BAR is
true RAM and can be accessed arbitrarily" vs "this BAR is full of registers
and can't be handled that way") and the vfio code in QEMU needs to set up
the memory regions differently for the two cases. For your example I think
it would be fine to have direct-access even if there were some kind of
quirk memory region, because for the parts of the BAR that aren't covered
by a quirk overlay the underlying BAR still allows "entirely like RAM,
any alignment and size is OK" accesses.

-- PMM

