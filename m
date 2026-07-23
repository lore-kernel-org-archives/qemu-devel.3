Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB37C531CF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 13:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmtjX-00020J-38; Thu, 23 Jul 2026 09:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1wmtjU-0001ys-5B
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 09:45:04 -0400
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1wmtjR-0001oZ-Dd
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 09:45:03 -0400
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-9030f8ea3b3so8194466d6.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 06:45:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784814300; cv=none;
 d=google.com; s=arc-20260327;
 b=k/DiazdhDCyQX1fuR3zgIqGPgSfLEQTGD19f4okpU+gkNC98f7SNDcDThMLMVWrVHF
 cH98Tx/ElaRrOLdPfUEsPQfYz7h6t2f8Wih+gm3K07ajQKFW3M1xv857tJxLpkir/CPv
 Ok0iFDchLUf3kdTHtJUmAi8VInFuYc5x899HvpuKMgp1n/9a8fv/hQwjie1Wu03alZym
 lOUx9VP6+69JmO/Jaje0nePTeif6hqamnkkJs+SxhIH180VI84+VR0LjT6HBF+QDgQHI
 g+cedzAv90miXeYtsnsmx7pV0Luavzjb8wpyO/tGxzBpsPSs0qq6UH8tsoOv9m3LR7cC
 F3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CKg3psub7IhW/zWpyuw8ZaLOER8JPrzU23YtIaxwsCA=;
 fh=IFDTAd8NtiuDSt/U0Zw9Fsu0Ha2c+vekKbBBL/VRTVU=;
 b=ClFYUDV8WpyLIGvr7dHGLnBna04M3WCIJUmMsD14xYm7pPGyWrZpxmmqSYhe4c/cTD
 jaSPTyIFPFoPIeoC1SmGuNpLcIKcC0S//yapRfIfHVQgzZyLtv7z6oCVDR2b31473jlq
 lmmtVTYV/7u5Wds8zTbrBx7OBX5zqL1zESX4yEf5kfvHHsnoZlNAiYpYmJe+NAK8zwg0
 UZ7TG6Ekx+NdrZaMEQj8MUd/MkXTGI8dAax9effTcVohc2ta3ROot/0d8jU/HkAB/wty
 yjZZ9HsaK1eeY/yKcWU6i8I/0zQHJTWj3Y/9R+Ij192I98Fqss62XiJ3bF25UI4+QHjH
 1u6w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784814300; x=1785419100; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CKg3psub7IhW/zWpyuw8ZaLOER8JPrzU23YtIaxwsCA=;
 b=dLMPVIvhJGv/VMEcTHUvZUwafrH8mXA5f9g7gUC1cZp/RJpDtLkg5/9yfTgca4lVny
 JbEtbjGh+Uyhe4HOt8TpdQCe7cTQPK4I5ttNdNP6acN7xGEDm4Yu2cRprWzhbfHNwjSp
 4MQEYgF+SEnFBJWmgfJ4F2hxrQtsYcnUNWDqmSv61uxmXxmwqICrqBeGpILAVk5IS7zO
 EvdjUkl8gTYY5MKUoROiA/27Tl/yJOtXfBvmYpeaOjDLt9UOmxjuX3IKiOB/Xe0ai8oS
 djSfyDm93H2bvU8mtgUut4auot+x0iy3raRvgHIqTQDaD47T/XLuay5Q8g13o95FzLlx
 W3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784814300; x=1785419100;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CKg3psub7IhW/zWpyuw8ZaLOER8JPrzU23YtIaxwsCA=;
 b=NZfaq6EBDt8xdCje0MFOPztF4hkXOkHqBHFv9hJP4Z8ax6KkERRGmDyfGFfyz5+N2S
 MmkzUxNwJLuo3b2I/rrMrOuNvTdbhYsZrEaQpbMZk6tUAmRwjF6eFTT9yFIQMoEt+/06
 BUD1Di8z4R7kWbD/6srpIXTkv++8Ndgt2tBkWy8WfLzL/PiboySvQSoezycaz6jlsEMh
 b0O2hkoBG4j+zz4+PfUxY3H9Y66jBkCWR3f4ZJQ07DQVyNNmBer7PjDtHlErLVBLVbil
 akiyoAtEm/pfXXk7LOMpzZrnDmmNyiDwecjlIWYsCXV7DIIM3PXBbDUm3HYAvInn4T+A
 V8Fw==
X-Gm-Message-State: AOJu0Yw9M5DH+6NCcKnJem+ZPWcVF9tXuiowr1Mlxv5WqX3iUXE05DRC
 J/2juffzXDZ2lFFJsy/ssgU4zmfbfIF+tUzjF1O4MGEuH7TowbQJkzlhj2NG1XzhbXmB2V0+ce/
 rID3NtQd+5qiUZJRzP1upg49jAdGueuI=
X-Gm-Gg: AR+sD10+7JD3OsLm8xpwlm9zpKdaxCmceVx2+AXIovAQj82T9jBb5cjMJ3zJpaDMFHu
 ZxpmR1xhvEWq68au9Jmjlm0Q3DuX0Nq6xL2614wKOLi9LICzOzqSxuNNuBoXJ0CKLfTYnT5CGNH
 V6Z3KLjmbDKjUG3ymEMVLYDgHX6/tsQOFfRABMEZUDKeEFPes8TZ4NwAB8sN5qfx1G4Sv0NGV/+
 xm5FwW0MtZ/N1HmZJcKJQ623ufxrBhFcC7o/JX00kLk639M6q5oMVsp1cGPp1bdMpF4ogSXXw==
X-Received: by 2002:a05:6214:4293:b0:8e2:e366:15e0 with SMTP id
 6a1803df08f44-907ca25045emr34985816d6.2.1784814299624; Thu, 23 Jul 2026
 06:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260721130611.539089-1-east.moutain.yang@gmail.com>
 <38865e6b-6e80-4581-9aaf-257a53dfb972@app.fastmail.com>
 <20260721110247-mutt-send-email-mst@kernel.org>
 <20260721230004.2c03fede@shazbot.org>
 <CALrP2iVwJqufzvjOdiEiE0FPTHkMjMjhA4H0siaLAuAHmw2wLQ@mail.gmail.com>
 <c3b5a5f5-0c3a-4793-9dd6-206ba0b6ed72@redhat.com>
In-Reply-To: <c3b5a5f5-0c3a-4793-9dd6-206ba0b6ed72@redhat.com>
From: Wencheng Yang <east.moutain.yang@gmail.com>
Date: Thu, 23 Jul 2026 21:44:47 +0800
X-Gm-Features: AUfX_mxC1_iw1JyfAo_sCphFW48mPHmZY5VUdxjPgNafqbaPV2ZFYb3rZsCAfnM
Message-ID: <CALrP2iVpdgxARSOtCOAj54tiy_+YrNBTu_DS=e_5HVGfC_-ffg@mail.gmail.com>
Subject: Re: [PATCH] hw/vfio: Coalesce repeated PCI_COMMAND memory-decode DMA
 (re)map for passthrough BARs
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Yangwencheng <yangwencheng@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000051b8fe0657477653"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=east.moutain.yang@gmail.com; helo=mail-qv1-xf29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
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

--00000000000051b8fe0657477653
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2026/7/23 15:37, C=C3=A9dric Le Goater wrote:

Hello,

On 7/23/26 05:50, Wencheng Yang wrote:

__


On 2026/7/22 13:00, Alex Williamson wrote:

On Tue, 21 Jul 2026 11:03:39 -0400
"Michael S. Tsirkin"<mst@redhat.com> <mst@redhat.com>
<mailto:mst@redhat.com> <mst@redhat.com> wrote:

On Tue, Jul 21, 2026 at 08:41:04AM -0600, Alex Williamson wrote:

On Tue, Jul 21, 2026, at 7:06 AM, Yang Wencheng wrote:

From: YangWencheng<east.moutain.yang@gmail.com>
<east.moutain.yang@gmail.com> <mailto:east.moutain.yang@gmail.com>
<east.moutain.yang@gmail.com>

A passthrough device's own MMIO/BAR range is registered with the IOMMU
(VFIO_IOMMU_MAP_DMA) when its memory region becomes part of the guest
address space, to support peer-to-peer DMA into that BAR from other
devices. Toggling the guest's PCI_COMMAND memory-decode-enable bit off
and back on -- something PCI enumeration/attribute code does routinely,
sometimes several times for the same device (e.g. disable before
reprogramming a BAR then re-enable, or generic driver probing during
guest OS boot) -- currently tears down and rebuilds this mapping every
single time via vfio_listener_region_del()/region_add(), unconditionally.

For devices with very large BARs this is expensive: mapping a 64GB BAR
into IOMMU page tables measured at ~8.5s per call on this hardware, and
was observed being repeated 3-5 times for the same BAR during a single
guest boot, because nothing changed about the underlying mapping between
the disable and the following re-enable.

Defer the actual VFIO_IOMMU_UNMAP_DMA for "ram device" regions (i.e.
passthrough device BARs used for P2P DMA -- explicitly not regular guest
RAM or RamDiscardManager-backed regions, so migration/ballooning/
virtio-mem are unaffected) instead of issuing it immediately in
region_del(). If a matching region_add() for the exact same region
(same MemoryRegion pointer, iova, size, vaddr, readonly) follows, cancel
the deferred unmap and skip the VFIO_IOMMU_MAP_DMA entirely -- the
host-side mapping was never actually removed, so there is nothing to
redo. A region_add() for anything that doesn't match maps normally, as
before.

Nothing is leaked: any mapping still on the pending list is flushed with
a real unmap in two places -- vfio_container_instance_finalize(), before
the container's fd is closed (VM shutdown / last device in a group
removed),
and vfio_bars_finalize(), matched by MemoryRegion pointer to just that
device's own BARs, so a device hot-unplugged while the container stays
alive for other devices can't leave a dangling deferred entry either.

This does not weaken the PCI_COMMAND memory-decode security boundary:
every guest write to PCI_COMMAND is still forwarded synchronously and
unconditionally to the real device's config space in
vfio_pci_write_config() (an entirely separate code path, untouched by
this change), which is what actually gates whether the physical device
claims/responds to transactions targeting its BAR, independent of
whatever the IOMMU's routing table still contains. This change only
avoids redundant bookkeeping of that routing table when nothing about
the mapping has changed.

Seems like you should focus on huge pfnmap support on your platform
rather than hack the VMM to not behave like bare metal.  Thanks,

But bare metal does not tweak an iommu during pci enumeration?

Bare metal is not using the IOMMU to map the device into a guest
physical address space, so no, an equivalent operation does not occur
there.  The proposal here is intentionally leaving stale gpa mappings
to avoid the unmap/remap overhead, where we've essentially eliminated
that overhead on other platforms with huge pfnmap support.  The
specific platform that's being optimized here is also omitted, which
makes it impossible to determine the ongoing need for this code.

The scheme here effectively assumes that a region_del() will either be
followed by a region_add() that cancels the deferred unmap, or the
deferral will be executed on finalize.  It does not actually account
for cases where the guest might remap the BAR to a different address,
ex. pci=3Drealloc, leaving a stale mapping in place.  The finalize also
appears to be using a different MR from the one deferred, such that the
IOMMU is actually only unmapped due to close().

More importantly though, this entire scheme is relying on a gap in the
vfio type1 IOMMU backend, where clearing the memory enable bit of the
command register zaps the CPU mappings and errors faults while cleared,
but does not generate unmaps in the IOMMU.  IOMMUFD resolves that gap,
generating a move-notify/invalidate on the dma-buf, which results in an
IOMMU unmap.  IOW, the premise of this workaround is broken in the
direction that VFIO is headed.

Therefore, I'd once again suggest that effort is better redirected to
implement huge pfnmap support for whatever platform this might be in
order to follow a proven solution to this problem for type1.  Huge
pfnmap is used both in the CPU fault path as well as the DMA mapping
path, by virtue of generating user faults in the pfnmap.  Alternatively,
iommufd may provide better p2p DMA mapping performance than type1
without huge pfnmap, but CPU faults would lag without such support
anyway.  Thanks,

Alex


I noticed you provided a kernel patch "PCI: Batch BAR sizing operations",

the patch eliminates the overhead of IOMMU map/unmap operations from

guest kernel. I found OVMF has the same issue, I tried to fix it in edk2
source

code, but the PCI commands are scattered, it's hard to handle it like
kernel.

I think it's reasonable to handle it qemu, as the overhead is introduced by

qemu to support PCIe device passthrough.


"we've essentially eliminated that overhead on other platforms with huge
  pfnmap support."

Can you provide some key references about this approach?

Check these related commits.

Linux :

  commit f9e54c3a2f5b ("vfio/pci: implement huge_fault support")

QEMU:

  commit 00b519c0bca0 ("vfio/helpers: Align mmaps")

Thanks,

C.

Thanks a lot.

The two patches above establish huge-page mappings for the CPU,
saving memory allocated for page tables, and using huge pages also
reduces TLB entry consumption. However, the issue I'm running into
is that OVMF's frequent PCI_COMMAND operations cause QEMU
to repeatedly invoke VFIO_IOMMU_MAP_DMA. While huge pages
can certainly reduce the time spent resolving the PFN corresponding
to an IOVA, they do not eliminate these repeated calls themselves.

For a GPU with a relatively large VRAM =E2=80=94 say, 64GB =E2=80=94 the cu=
mulative
overhead from these frequent invocations is substantial. In my testing,
passing through a 64GB VRAM GPU to a VM shows that a single
ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) call takes roughly
8 seconds.

Applying the two patches above might help reduce this time. I'm currently
running QEMU 8.2 with kernel 5.10, and directly cherry-picking these two
patches results in conflicts. I'll spend some time backporting them and
see how the results look.

--00000000000051b8fe0657477653
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><u></u>

 =20
   =20
 =20
  <div>
    <br>
    <br>
    <div>On 2026/7/23 15:37, C=C3=A9dric Le Goater
      wrote:<br>
    </div>
    <blockquote type=3D"cite">Hello,
      <br>
      <br>
      On 7/23/26 05:50, Wencheng Yang wrote:
      <br>
      <blockquote type=3D"cite">__
        <br>
        <br>
        <br>
        On 2026/7/22 13:00, Alex Williamson wrote:
        <br>
        <blockquote type=3D"cite">On Tue, 21 Jul 2026 11:03:39 -0400
          <br>
          &quot;Michael S. Tsirkin&quot;<a href=3D"mailto:mst@redhat.com" t=
arget=3D"_blank">&lt;mst@redhat.com&gt;</a>
          <a href=3D"mailto:mst@redhat.com" target=3D"_blank">&lt;mailto:ms=
t@redhat.com&gt;</a> wrote:
          <br>
          <br>
          <blockquote type=3D"cite">On Tue, Jul 21, 2026 at 08:41:04AM
            -0600, Alex Williamson wrote:
            <br>
            <blockquote type=3D"cite">On Tue, Jul 21, 2026, at 7:06 AM,
              Yang Wencheng wrote:
              <br>
              <blockquote type=3D"cite">From:
                YangWencheng<a href=3D"mailto:east.moutain.yang@gmail.com" =
target=3D"_blank">&lt;east.moutain.yang@gmail.com&gt;</a>
                <a href=3D"mailto:east.moutain.yang@gmail.com" target=3D"_b=
lank">&lt;mailto:east.moutain.yang@gmail.com&gt;</a>
                <br>
                <br>
                A passthrough device&#39;s own MMIO/BAR range is registered
                with the IOMMU
                <br>
                (VFIO_IOMMU_MAP_DMA) when its memory region becomes part
                of the guest
                <br>
                address space, to support peer-to-peer DMA into that BAR
                from other
                <br>
                devices. Toggling the guest&#39;s PCI_COMMAND
                memory-decode-enable bit off
                <br>
                and back on -- something PCI enumeration/attribute code
                does routinely,
                <br>
                sometimes several times for the same device (e.g.
                disable before
                <br>
                reprogramming a BAR then re-enable, or generic driver
                probing during
                <br>
                guest OS boot) -- currently tears down and rebuilds this
                mapping every
                <br>
                single time via vfio_listener_region_del()/region_add(),
                unconditionally.
                <br>
                <br>
                For devices with very large BARs this is expensive:
                mapping a 64GB BAR
                <br>
                into IOMMU page tables measured at ~8.5s per call on
                this hardware, and
                <br>
                was observed being repeated 3-5 times for the same BAR
                during a single
                <br>
                guest boot, because nothing changed about the underlying
                mapping between
                <br>
                the disable and the following re-enable.
                <br>
                <br>
                Defer the actual VFIO_IOMMU_UNMAP_DMA for &quot;ram device&=
quot;
                regions (i.e.
                <br>
                passthrough device BARs used for P2P DMA -- explicitly
                not regular guest
                <br>
                RAM or RamDiscardManager-backed regions, so
                migration/ballooning/
                <br>
                virtio-mem are unaffected) instead of issuing it
                immediately in
                <br>
                region_del(). If a matching region_add() for the exact
                same region
                <br>
                (same MemoryRegion pointer, iova, size, vaddr, readonly)
                follows, cancel
                <br>
                the deferred unmap and skip the VFIO_IOMMU_MAP_DMA
                entirely -- the
                <br>
                host-side mapping was never actually removed, so there
                is nothing to
                <br>
                redo. A region_add() for anything that doesn&#39;t match
                maps normally, as
                <br>
                before.
                <br>
                <br>
                Nothing is leaked: any mapping still on the pending list
                is flushed with
                <br>
                a real unmap in two places --
                vfio_container_instance_finalize(), before
                <br>
                the container&#39;s fd is closed (VM shutdown / last device
                in a group removed),
                <br>
                and vfio_bars_finalize(), matched by MemoryRegion
                pointer to just that
                <br>
                device&#39;s own BARs, so a device hot-unplugged while the
                container stays
                <br>
                alive for other devices can&#39;t leave a dangling deferred
                entry either.
                <br>
                <br>
                This does not weaken the PCI_COMMAND memory-decode
                security boundary:
                <br>
                every guest write to PCI_COMMAND is still forwarded
                synchronously and
                <br>
                unconditionally to the real device&#39;s config space in
                <br>
                vfio_pci_write_config() (an entirely separate code path,
                untouched by
                <br>
                this change), which is what actually gates whether the
                physical device
                <br>
                claims/responds to transactions targeting its BAR,
                independent of
                <br>
                whatever the IOMMU&#39;s routing table still contains. This
                change only
                <br>
                avoids redundant bookkeeping of that routing table when
                nothing about
                <br>
                the mapping has changed.
                <br>
              </blockquote>
              Seems like you should focus on huge pfnmap support on your
              platform
              <br>
              rather than hack the VMM to not behave like bare metal.=C2=A0
              Thanks,
              <br>
              <br>
            </blockquote>
            But bare metal does not tweak an iommu during pci
            enumeration?
            <br>
          </blockquote>
          Bare metal is not using the IOMMU to map the device into a
          guest
          <br>
          physical address space, so no, an equivalent operation does
          not occur
          <br>
          there.=C2=A0 The proposal here is intentionally leaving stale gpa
          mappings
          <br>
          to avoid the unmap/remap overhead, where we&#39;ve essentially
          eliminated
          <br>
          that overhead on other platforms with huge pfnmap support.=C2=A0
          The
          <br>
          specific platform that&#39;s being optimized here is also omitted=
,
          which
          <br>
          makes it impossible to determine the ongoing need for this
          code.
          <br>
          <br>
          The scheme here effectively assumes that a region_del() will
          either be
          <br>
          followed by a region_add() that cancels the deferred unmap, or
          the
          <br>
          deferral will be executed on finalize.=C2=A0 It does not actually
          account
          <br>
          for cases where the guest might remap the BAR to a different
          address,
          <br>
          ex. pci=3Drealloc, leaving a stale mapping in place.=C2=A0 The
          finalize also
          <br>
          appears to be using a different MR from the one deferred, such
          that the
          <br>
          IOMMU is actually only unmapped due to close().
          <br>
          <br>
          More importantly though, this entire scheme is relying on a
          gap in the
          <br>
          vfio type1 IOMMU backend, where clearing the memory enable bit
          of the
          <br>
          command register zaps the CPU mappings and errors faults while
          cleared,
          <br>
          but does not generate unmaps in the IOMMU.=C2=A0 IOMMUFD resolves
          that gap,
          <br>
          generating a move-notify/invalidate on the dma-buf, which
          results in an
          <br>
          IOMMU unmap.=C2=A0 IOW, the premise of this workaround is broken =
in
          the
          <br>
          direction that VFIO is headed.
          <br>
          <br>
          Therefore, I&#39;d once again suggest that effort is better
          redirected to
          <br>
          implement huge pfnmap support for whatever platform this might
          be in
          <br>
          order to follow a proven solution to this problem for type1.=C2=
=A0
          Huge
          <br>
          pfnmap is used both in the CPU fault path as well as the DMA
          mapping
          <br>
          path, by virtue of generating user faults in the pfnmap.=C2=A0
          Alternatively,
          <br>
          iommufd may provide better p2p DMA mapping performance than
          type1
          <br>
          without huge pfnmap, but CPU faults would lag without such
          support
          <br>
          anyway.=C2=A0 Thanks,
          <br>
          <br>
          Alex
          <br>
        </blockquote>
        <br>
        I noticed you provided a kernel patch &quot;PCI: Batch BAR sizing
        operations&quot;,
        <br>
        <br>
        the patch eliminates the overhead of IOMMU map/unmap operations
        from
        <br>
        <br>
        guest kernel. I found OVMF has the same issue, I tried to fix it
        in edk2 source
        <br>
        <br>
        code, but the PCI commands are scattered, it&#39;s hard to handle i=
t
        like kernel.
        <br>
        <br>
        I think it&#39;s reasonable to handle it qemu, as the overhead is
        introduced by
        <br>
        <br>
        qemu to support PCIe device=C2=A0passthrough.
        <br>
        <br>
        <br>
        &quot;we&#39;ve essentially eliminated that overhead on other platf=
orms
        with huge
        <br>
        =C2=A0 pfnmap support.&quot;
        <br>
        <br>
        Can you provide some key references about this approach?
        <br>
      </blockquote>
      Check these related commits.
      <br>
      <br>
      Linux :
      <br>
      <br>
      =C2=A0 commit f9e54c3a2f5b (&quot;vfio/pci: implement huge_fault supp=
ort&quot;)
      <br>
      <br>
      QEMU:
      <br>
      <br>
      =C2=A0 commit 00b519c0bca0 (&quot;vfio/helpers: Align mmaps&quot;)
      <br>
      <br>
      Thanks,
      <br>
      <br>
      C.
      <br>
      <br>
    </blockquote>
    Thanks a lot.<br>
    <br>
    The two patches above establish huge-page mappings for the CPU,</div><d=
iv>saving memory allocated for page tables, and using huge pages also</div>=
<div>reduces TLB entry consumption. However, the issue I&#39;m running into=
</div><div>is that OVMF&#39;s frequent PCI_COMMAND operations cause QEMU</d=
iv><div>to
    repeatedly invoke VFIO_IOMMU_MAP_DMA. While huge pages</div><div>can ce=
rtainly
    reduce the time spent resolving the PFN corresponding</div><div>to an I=
OVA,
    they do not eliminate these repeated calls themselves.</div><div><br></=
div><div>For a GPU
    with a relatively large VRAM =E2=80=94 say, 64GB =E2=80=94 the cumulati=
ve</div><div>overhead
    from these frequent invocations is substantial. In my testing,</div><di=
v>passing through a 64GB VRAM GPU to a VM shows that a single</div><div>ioc=
tl(container-&gt;fd, VFIO_IOMMU_MAP_DMA, &amp;map) call takes
    roughly</div><div>8 seconds.</div><div><span style=3D"background-color:=
transparent"><br></span></div><div><span style=3D"background-color:transpar=
ent">Applying the two patches above might help reduce
    this time. I&#39;m currently</span></div><div><span style=3D"background=
-color:transparent">running QEMU 8.2 with kernel 5.10, and
    directly cherry-picking these two</span></div><div><span style=3D"backg=
round-color:transparent">patches </span>results<span style=3D"background-co=
lor:transparent"> in conflicts. I&#39;ll
    spend some time backporting them and</span></div><div><span style=3D"ba=
ckground-color:transparent">see how the results look.</span></div><div>
    <br>
  </div>

</div>

--00000000000051b8fe0657477653--

