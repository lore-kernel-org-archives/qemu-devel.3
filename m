Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC55C4452B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 03:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmkSb-0000G2-Qt; Wed, 22 Jul 2026 23:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1wmkSZ-0000Fp-Ej
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 23:50:59 -0400
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <east.moutain.yang@gmail.com>)
 id 1wmkSX-0004oa-0r
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 23:50:59 -0400
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-8f0e5e36912so1234596d6.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 20:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784778650; cv=none;
 d=google.com; s=arc-20260327;
 b=GY/d69pxjF3Zqz5ZeXurb5la7z8hgmK9zWNEE7FPYNIOilj8K6fDDMr+kFLZwjlYum
 FZeI/O/kLBugT8Qcbo3aCNip5AWzgElo2lYOLjulapQwTyoy+LPC4GWRSWEpegp8MXPt
 kdtLA5wDKEWlYkjl8/AgHCNi3AtdQRTkPBu9MHP8ZU6mA4TU6DXGqj7+3L9MemnyAPDs
 zeFa38KkEOAawjC3ILwW90SOcpgK/zWDoDqYNRXdzGhBmKwZVvhqsNTH44km5q/B8O+Z
 l8Rr6zc6qSCWz4ZHMgxE/KNEX0l8GrSnYKWY2jXJIE37PWDi7ZPyEXdkGrHAn6SBTulx
 63hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kPvNM+8N9mMVQz6GF0jb1d/zTRGeuk/WjE6LIHykSK0=;
 fh=fV1rKQ+EpzmDMbkFhX4h45vUd86VYu2E/AHgKAyJ2iY=;
 b=jS3zpQa5uKT8EgY0iub/bTelDZ1HjF2+0o5k0GmQ6prHtY4K99Pr/zY+A8/geIuyEC
 fcJiOKTcEDlryfH+DVqMRQXTQMWUnHB8JgkSFrors9TrI1Gzr/Zy9RHErzxdM23w5oB0
 yJUYHKZl7+GKr3bmuwgpOweO1CReIOIswxcxTs2oRs6YoYWKG7PMd7nn50UkCglEKDas
 seup6Eon/4JLS7Kk0rZQuJ4gx7Z1TJSShXhcUQhNRqsjT5AzloL6wm/6c/Em0n+z2MIq
 C3cF/tM1EBjv4YyTCgf+i8Lw2vYoQeK/gA6RFDv/WxTeDl4HYX5yErMXRNUtz6VICCFj
 So1w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784778650; x=1785383450; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kPvNM+8N9mMVQz6GF0jb1d/zTRGeuk/WjE6LIHykSK0=;
 b=TYHWwXTt2mtoBBWLK7Pc4PfdopmY3S2WwBtHHFIMlPfJbzjwVQA3FQk0UXgbpK1RyP
 rZH+Q4VkMYrc5DJ4DfAmNrL+q6JVrUZry83tZ2jD/xhEGxL9HcIcAqbJCbZtub7LWe4W
 yjAz76D7TwDkqOXAFs7j1pKLZv/hjOVebKfd7RRVyfCdWmLbeac8szWFspZ05cNStvQa
 dm3hgdFuCjprpt3PawSyRjaRIs/POk/XODdnjXels6VdATMTzaw1hFt870Tmh4vLG99G
 oNDt+0n3f13A0viQIwbHKehdY9KxgviA/x0bdSIP1Y0vVWYvjsrzlphk2QdWKciLkRb2
 q1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784778650; x=1785383450;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kPvNM+8N9mMVQz6GF0jb1d/zTRGeuk/WjE6LIHykSK0=;
 b=X275jpAj7rT/pqrjztZdFwZ4MLJ7bMAuQbx9bR6+auJF1+tw/MWE84bVhFWxLWwtvA
 Pyr2KR1B1ltEbX+JmrxTtros/w0bEAROrcyDCdZ23einO4ySk6AqkivbbuWQUksZ1RG2
 dEb11StVpF1jCyuCw/RJ4Q1S8WzKDsuUiVGKjvFc+npyBegdyTzFU663B7O58YWYNBnM
 S7s9w6LaXM0b7Hw+aVn2PWQwAoFjv6cRU6dEWgQ0Fc4VOtMqPQfLiKsiefVWtMIrijUq
 fYA6MVX9tzUOv3vmEaSuEiUYlSawh/9RYz04CjTeRIHrUxf/404e5Hu6n1TBNN+F8OQC
 kaKg==
X-Gm-Message-State: AOJu0Yze0DNtg+GTmTuol4WwOg4/hboTpwTyk4SxkeSBu8KpD2h6E0uT
 eKLESRarBBfnn4NXuti14yRo9R+Ml8rBn//iKK7SHgtoOVwgJtIjkS5YdWlvQ+qhT4Y6ubfC3tg
 4HTCPk7GUJr7DDeqHSEbAcUpHd0NYhnQ=
X-Gm-Gg: AR+sD10yDfB9EnXmhrAa294j+15Sn/mzgEjQ7/bMPLE2ZMayC9iXpdxyBnxv6UdK5g6
 cjtZy7Buv5xk5dMQyxj08UXZnVrRSMHb904fn1CNSDcqeXtE5558l6rdzEZ9dSDJ8L/k+XV6/OS
 VQ5EX4YTPdGxbkmVtqy4bMblsHNlbb773oeBQ3C7aISvae7puXg+RoTOYgRtyndfwyvVGmYn84g
 2Grvc+U28HmMKhELfirrYkxTtNjiTckbtBuKa8NZY0CThq5ENL7Agz5naHI+GA=
X-Received: by 2002:a05:6214:2c0d:b0:8e9:61e9:8d9 with SMTP id
 6a1803df08f44-907ca57d5cemr19962756d6.23.1784778650219; Wed, 22 Jul 2026
 20:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260721130611.539089-1-east.moutain.yang@gmail.com>
 <38865e6b-6e80-4581-9aaf-257a53dfb972@app.fastmail.com>
 <20260721110247-mutt-send-email-mst@kernel.org>
 <20260721230004.2c03fede@shazbot.org>
In-Reply-To: <20260721230004.2c03fede@shazbot.org>
From: Wencheng Yang <east.moutain.yang@gmail.com>
Date: Thu, 23 Jul 2026 11:50:36 +0800
X-Gm-Features: AUfX_mwA4YhV01sw-3xcHLeG5GNp_Vp8JqNtuJ5Uy2qy5RBQirCmDpitYHdGNOE
Message-ID: <CALrP2iVwJqufzvjOdiEiE0FPTHkMjMjhA4H0siaLAuAHmw2wLQ@mail.gmail.com>
Subject: Re: [PATCH] hw/vfio: Coalesce repeated PCI_COMMAND memory-decode DMA
 (re)map for passthrough BARs
To: Alex Williamson <alex@shazbot.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Yangwencheng <yangwencheng@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000072f82d06573f29d5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=east.moutain.yang@gmail.com; helo=mail-qv1-xf30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000072f82d06573f29d5
Content-Type: text/plain; charset="UTF-8"

On 2026/7/22 13:00, Alex Williamson wrote:

On Tue, 21 Jul 2026 11:03:39 -0400
"Michael S. Tsirkin" <mst@redhat.com> <mst@redhat.com> wrote:


On Tue, Jul 21, 2026 at 08:41:04AM -0600, Alex Williamson wrote:

On Tue, Jul 21, 2026, at 7:06 AM, Yang Wencheng wrote:

From: YangWencheng <east.moutain.yang@gmail.com> <east.moutain.yang@gmail.com>

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
the container's fd is closed (VM shutdown / last device in a group removed),
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
ex. pci=realloc, leaving a stale mapping in place.  The finalize also
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

guest kernel. I found OVMF has the same issue, I tried to fix it in edk2 source

code, but the PCI commands are scattered, it's hard to handle it like kernel.

I think it's reasonable to handle it qemu, as the overhead is introduced by

qemu to support PCIe device passthrough.


"we've essentially eliminated that overhead on other platforms with huge
 pfnmap support."

Can you provide some key references about this approach?

Thanks,
YangWencheng

--00000000000072f82d06573f29d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><u></u>

 =20
   =20
 =20
  <div>
    <p><br>
    </p>
    <div>On 2026/7/22 13:00, Alex Williamson
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
      <pre>On Tue, 21 Jul 2026 11:03:39 -0400
&quot;Michael S. Tsirkin&quot; <a href=3D"mailto:mst@redhat.com" target=3D"=
_blank">&lt;mst@redhat.com&gt;</a> wrote:

</pre>
      <blockquote type=3D"cite">
        <pre>On Tue, Jul 21, 2026 at 08:41:04AM -0600, Alex Williamson wrot=
e:
</pre>
        <blockquote type=3D"cite">
          <pre>On Tue, Jul 21, 2026, at 7:06 AM, Yang Wencheng wrote: =20
</pre>
          <blockquote type=3D"cite">
            <pre>From: YangWencheng <a href=3D"mailto:east.moutain.yang@gma=
il.com" target=3D"_blank">&lt;east.moutain.yang@gmail.com&gt;</a>

A passthrough device&#39;s own MMIO/BAR range is registered with the IOMMU
(VFIO_IOMMU_MAP_DMA) when its memory region becomes part of the guest
address space, to support peer-to-peer DMA into that BAR from other
devices. Toggling the guest&#39;s PCI_COMMAND memory-decode-enable bit off
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

Defer the actual VFIO_IOMMU_UNMAP_DMA for &quot;ram device&quot; regions (i=
.e.
passthrough device BARs used for P2P DMA -- explicitly not regular guest
RAM or RamDiscardManager-backed regions, so migration/ballooning/
virtio-mem are unaffected) instead of issuing it immediately in
region_del(). If a matching region_add() for the exact same region
(same MemoryRegion pointer, iova, size, vaddr, readonly) follows, cancel
the deferred unmap and skip the VFIO_IOMMU_MAP_DMA entirely -- the
host-side mapping was never actually removed, so there is nothing to
redo. A region_add() for anything that doesn&#39;t match maps normally, as
before.

Nothing is leaked: any mapping still on the pending list is flushed with
a real unmap in two places -- vfio_container_instance_finalize(), before
the container&#39;s fd is closed (VM shutdown / last device in a group remo=
ved),
and vfio_bars_finalize(), matched by MemoryRegion pointer to just that
device&#39;s own BARs, so a device hot-unplugged while the container stays
alive for other devices can&#39;t leave a dangling deferred entry either.

This does not weaken the PCI_COMMAND memory-decode security boundary:
every guest write to PCI_COMMAND is still forwarded synchronously and
unconditionally to the real device&#39;s config space in
vfio_pci_write_config() (an entirely separate code path, untouched by
this change), which is what actually gates whether the physical device
claims/responds to transactions targeting its BAR, independent of
whatever the IOMMU&#39;s routing table still contains. This change only
avoids redundant bookkeeping of that routing table when nothing about
the mapping has changed. =20
</pre>
          </blockquote>
          <pre>Seems like you should focus on huge pfnmap support on your p=
latform
rather than hack the VMM to not behave like bare metal.  Thanks,

</pre>
        </blockquote>
        <pre>But bare metal does not tweak an iommu during pci enumeration?
</pre>
      </blockquote>
      <pre>Bare metal is not using the IOMMU to map the device into a guest
physical address space, so no, an equivalent operation does not occur
there.  The proposal here is intentionally leaving stale gpa mappings
to avoid the unmap/remap overhead, where we&#39;ve essentially eliminated
that overhead on other platforms with huge pfnmap support.  The
specific platform that&#39;s being optimized here is also omitted, which
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

Therefore, I&#39;d once again suggest that effort is better redirected to
implement huge pfnmap support for whatever platform this might be in
order to follow a proven solution to this problem for type1.  Huge
pfnmap is used both in the CPU fault path as well as the DMA mapping
path, by virtue of generating user faults in the pfnmap.  Alternatively,
iommufd may provide better p2p DMA mapping performance than type1
without huge pfnmap, but CPU faults would lag without such support
anyway.  Thanks,

Alex</pre>
    </blockquote>
    <pre>I noticed you provided a kernel patch &quot;PCI: Batch BAR sizing =
operations&quot;,</pre>
    <pre>the patch eliminates the overhead of IOMMU map/unmap operations fr=
om</pre>
    <pre>guest kernel. I found OVMF has the same issue, I tried to fix it i=
n edk2 source</pre>
    <pre>code, but the PCI commands are scattered, it&#39;s hard to handle =
it like kernel.</pre>
    <pre>I think it&#39;s reasonable to handle it qemu, as the overhead is =
introduced by</pre>
    <pre>qemu to support PCIe device=C2=A0passthrough.


&quot;we&#39;ve essentially eliminated that overhead on other platforms wit=
h huge
 pfnmap support.&quot;

Can you provide some key references about this approach?

Thanks,=20
YangWencheng</pre>
    <p>=C2=A0</p>
  </div>

</div>

--00000000000072f82d06573f29d5--

