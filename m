Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1432C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdURQ-0004SG-9z; Thu, 30 Jan 2025 08:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1tdURL-0004AU-Mg
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:18:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1tdURJ-0000M7-Ot
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738243116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wU5VCMblafH3dlFa/9oBS/z/DZJvRZbkOVt362Eamgc=;
 b=SBn1yTN5a+qPld9NgHeiVC4vwO+mtq0qy2ahHo70GmLcYfmQ97J0EmCfe/5TsFNTbTRuhh
 dVWO5h98YpgwHlxkDJknWIGLt28q9HsW8YXevAFinIUCPeRYIq7LKOVjHGOV+BAEIoTdYU
 P2DLsMbadd6xq/LizxCsvsBKlsNLbvc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-XZt2bf3mM-u7oVIS0MjiAw-1; Thu, 30 Jan 2025 08:18:35 -0500
X-MC-Unique: XZt2bf3mM-u7oVIS0MjiAw-1
X-Mimecast-MFC-AGG-ID: XZt2bf3mM-u7oVIS0MjiAw
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3021bd72334so4685651fa.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 05:18:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738243112; x=1738847912;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wU5VCMblafH3dlFa/9oBS/z/DZJvRZbkOVt362Eamgc=;
 b=UC6NWiUMfK4/2aosWKICcbpzjYeOw530Klf5eqUdPOxfo/zcaQpdD5TQVGqStiYz/H
 K9X5llzTFqR5Uobtv29TnR38KbP5owjhHMCDx5xUlZfmHYowvLnlqSJUtQHDjVWPDxwg
 sFGorDLN3j+LoM2QA9z4aTaEcT7Ngp/Z1nGdAjcauGOcqch5zkGj/9Rr14mOe/wHKuSR
 cSgPw4CJ8bg6FBaQ6v5DlB2YKNqzoogXQI6/Psb6WMBo4lA45uOYQcsuXwLQ3h35D8Lr
 Pw1zmE/q7qh32zuaxwLxsolGg7dYUBBQT8fDhp8uSWUtDr76Z8GQ57D5G/p/BGmvcQ4h
 mv5g==
X-Gm-Message-State: AOJu0Yy7KN9rca1LRR+sr+KM/h99qXIrRFqGNLt0UokFRRd/bnjioNxh
 OZdeM0t4Nn297dZOcnddSEl6LwO8MTjBP3MILaDyTCFiRv+j7kUEYYlOsOZ3zfaAscib7zQQJ8F
 1yXAkG01YHwHiUcjoGDGuBDcJh8T4ZVFAozI2VERKW9UGfJVrfsZhrVMZ3STEOmjgo3zA97ixu9
 sjWXTFzywKWbWPuLSlhgVhGC1BH2I=
X-Gm-Gg: ASbGncu6Q2rdNCfik+j40PJ4bqmHsVRo7ct2UqMDeafkp3IjT4MHrUDYKisrcv1oyMM
 wYCEgszXxDkPml3wGH7OzP0XAS2shLxAbZy+AwEzDxbysQHAbTj/hPGso3S1hUQ==
X-Received: by 2002:a2e:bc01:0:b0:302:29a5:6e01 with SMTP id
 38308e7fff4ca-3079680c529mr23772551fa.2.1738243111736; 
 Thu, 30 Jan 2025 05:18:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh81WaT3sMOjH++oNqdxplWqEbxUFeZEsHqOlrishXepUazo5r9xXI8X+gxSY1/e/zeNDZrD/MYKwE9wYtYIQ=
X-Received: by 2002:a2e:bc01:0:b0:302:29a5:6e01 with SMTP id
 38308e7fff4ca-3079680c529mr23772411fa.2.1738243111324; Thu, 30 Jan 2025
 05:18:31 -0800 (PST)
MIME-Version: 1.0
References: <20250128185705.1609038-1-david@redhat.com>
In-Reply-To: <20250128185705.1609038-1-david@redhat.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Thu, 30 Jan 2025 14:18:20 +0100
X-Gm-Features: AWEUYZmnVdm42ZVveBuBz9RXQvEp_DVrFRY8ADFYWI5mR8MFdRL3Lf6IVkyemtw
Message-ID: <CAMXpfWu7JpZssjH46_CfYkfwkVkz9Qys3OWCzgpsiNwT+pvg-w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] s390x: support virtio-mem-pci
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Boris Fiuczynski <fiuczy@linux.ibm.com>, Michal Privoznik <mprivozn@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series has been successfully tested in s390x. Here the detailed test s=
teps:

Boot up a VM already containing a memory object
/home/qemu/build/qemu-system-s390x \
...
-m 4G,maxmem=3D20G \
-object memory-backend-ram,id=3Dmem0,size=3D16G,reserve=3Doff \
...

Check the memory devices
(qemu) info memory-devices
(qemu)

Check the PCI devices in the VM
[root@localhost ~]# lspci -v
[root@localhost ~]#

Hotplug a virtio-mem-pci device and check the memory devices
(qemu) device_add virtio-mem-pci,id=3Dvmem0,memdev=3Dmem0,requested-size=3D=
1G
(qemu) info memory-devices
Memory device [virtio-mem]: "vmem0"
  memaddr: 0x100000000
  node: 0
  requested-size: 1073741824
  size: 1073741824
  max-size: 17179869184
  block-size: 1048576
  memdev: /objects/mem0

Check the PCI device is correct in the guest
[root@localhost ~]# lspci -v
0001:00:00.0 Unclassified device [00ff]: Red Hat, Inc. virtio-mem (rev 01)
Subsystem: Red Hat, Inc. Device 1100
Physical Slot: 00000000
Flags: bus master, fast devsel, latency 0, IOMMU group 0
Memory at 4000000000000000 (32-bit, non-prefetchable) [virtual] [size=3D4K]
Memory at 4001000000000000 (64-bit, prefetchable) [virtual] [size=3D16K]
Capabilities: [98] MSI-X: Enable+ Count=3D2 Masked-
Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
Capabilities: [70] Vendor Specific Information: VirtIO: Notify
Capabilities: [60] Vendor Specific Information: VirtIO: DeviceCfg
Capabilities: [50] Vendor Specific Information: VirtIO: ISR
Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg
Kernel driver in use: virtio-pci

Resize the virtio_mem device and verify the new size
(qemu) qom-set vmem0 requested-size 4G
(qemu) info memory-devices
Memory device [virtio-mem]: "vmem0"
  memaddr: 0x100000000
  node: 0
  requested-size: 4294967296
  size: 4294967296
  max-size: 17179869184
  block-size: 1048576
  memdev: /objects/mem0

Finally, try to perform a failed unplug, resize the device to 0, and
unplug it seamlessly:
(qemu) device_del vmem0
Error: virtio-mem device cannot get unplugged while some of its memory
is still plugged
(qemu) qom-set vmem0 requested-size 0
(qemu) device_del vmem0

Tested-by: Mario Casquero <mcasquer@redhat.com>

On Tue, Jan 28, 2025 at 7:57=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> This is based-on [1], which adds MSI-X support to virtio-balloon-pci,
> but can be applied independently.
>
> Turns out it is fairly easy to get virtio-mem-pci running on s390x. We
> only have to add MSI-X support to virtio-mem-pci, and wire-up the
> (un)plugging in the machine.
>
> Tried some simple stuff (hotplug/hotunplug/resize/reboot), and all seems
> to be working as expected.
>
> The kernel in the VM needs both, CONFIG_VIRTIO_PCI and CONFIG_VIRTIO_MEM
> for it to work.
>
> [1] https://lkml.kernel.org/r/20250115161425.246348-1-arbab@linux.ibm.com
>
> v1 -> v2:
> * There are no transitional/non_transitional devices for virtio-mem
> * Spell out removal of "return;" in second patch
>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Boris Fiuczynski <fiuczy@linux.ibm.com>
> Cc: Michal Privoznik <mprivozn@redhat.com>
> Cc: Mario Casquero <mcasquer@redhat.com>
>
> David Hildenbrand (2):
>   virtio-mem-pci: Allow setting nvectors, so we can use MSI-X
>   s390x/s390-virtio-ccw: Support plugging PCI-based virtio memory
>     devices
>
>  hw/core/machine.c          |  1 +
>  hw/s390x/s390-virtio-ccw.c | 20 ++++++++++++++------
>  hw/virtio/virtio-mem-pci.c | 12 ++++++++++++
>  3 files changed, 27 insertions(+), 6 deletions(-)
>
> --
> 2.48.1
>


