Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C90FC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJl0-0001Y0-2A; Wed, 29 May 2024 09:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sCJkx-0001Wb-1l; Wed, 29 May 2024 09:54:20 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sCJku-0003Lr-S2; Wed, 29 May 2024 09:54:18 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 37040444B1;
 Wed, 29 May 2024 15:54:06 +0200 (CEST)
Message-ID: <954a3d28-839a-4e62-b843-51d67f818396@proxmox.com>
Date: Wed, 29 May 2024 15:54:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-pci: Fix the use of an uninitialized irqfd.
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240522051042.985825-1-lulu@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20240522051042.985825-1-lulu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

Am 22.05.24 um 07:10 schrieb Cindy Lu:
> The crash was reported in MAC OS and NixOS, here is the link for this bug
> https://gitlab.com/qemu-project/qemu/-/issues/2334
> https://gitlab.com/qemu-project/qemu/-/issues/2321
> 
> The root cause is that the function virtio_pci_set_guest_notifiers() only
> initializes the irqfd when the use_guest_notifier_mask and guest_notifier_mask
> are set.

Sorry, I'm just trying to understand the fix and I'm probably missing
something, but in virtio_pci_set_guest_notifiers() there is:

>     bool with_irqfd = msix_enabled(&proxy->pci_dev) &&
>         kvm_msi_via_irqfd_enabled();

and then:

>     if ((with_irqfd ||
>          (vdev->use_guest_notifier_mask && k->guest_notifier_mask)) &&
>         assign) {
>         if (with_irqfd) {
>             proxy->vector_irqfd =
>                 g_malloc0(sizeof(*proxy->vector_irqfd) *
>                           msix_nr_vectors_allocated(&proxy->pci_dev));
>             r = kvm_virtio_pci_vector_vq_use(proxy, nvqs);

Meaning proxy->vector_irqfd is allocated when with_irqfd is true (even
if vdev->use_guest_notifier_mask && k->guest_notifier_mask is false).

> However, this check is missing in virtio_pci_set_vector().
> So the fix is to add this check.
> 
> This fix is verified in vyatta,MacOS,NixOS,fedora system.
> 
> The bt tree for this bug is:
> Thread 6 "CPU 0/KVM" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7c817be006c0 (LWP 1269146)]
> kvm_virtio_pci_vq_vector_use () at ../qemu-9.0.0/hw/virtio/virtio-pci.c:817
> 817	    if (irqfd->users == 0) {

The crash happens because the irqfd is NULL/invalid here, right?

proxy->vector_irqfd = NULL happens when virtio_pci_set_guest_notifiers()
is called with assign=false or for an unsuccessful call to
virtio_pci_set_guest_notifiers() with assign=true.

AFAIU, the issue is that virtio_pci_set_vector() is called between a
call to virtio_pci_set_guest_notifiers() with assign=false and a
successful virtio_pci_set_guest_notifiers() with assign=true (or before
the first such call).

So I'm trying to understand why adding the check for
vdev->use_guest_notifier_mask && k->guest_notifier_mask is sufficient to
fix the issue. Thanks!

Best Regards,
Fiona


