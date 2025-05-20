Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F1AC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMU4-0001mP-1I; Tue, 20 May 2025 08:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uHMTt-0001Wm-09
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uHMTo-0000vt-43
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747745636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3XuVLvoiyJmbyMc3LDiHIkNXHnQsJF4Ai2mSBK0II7Q=;
 b=chgOA1N25p7gWIelRaaqxW9XlhkWJsko7F96IWZRJZe3fZ4g7jy2lQfRRBhB6CJf7in30t
 E0xRxl2wP7Jdav6uDj17HBZpI0YQrSzp0P6FCPVQePiZTJOt1Au8Ht2sGKNl5X5O0J5mKh
 sWNZubm6YT1MEw9yy/9a4Vjfl+tZfng=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-IJZIVxs2MlG1dR16mhuTiA-1; Tue, 20 May 2025 08:53:55 -0400
X-MC-Unique: IJZIVxs2MlG1dR16mhuTiA-1
X-Mimecast-MFC-AGG-ID: IJZIVxs2MlG1dR16mhuTiA_1747745634
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a35989e5b2so3418077f8f.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 05:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747745634; x=1748350434;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3XuVLvoiyJmbyMc3LDiHIkNXHnQsJF4Ai2mSBK0II7Q=;
 b=uAg541uv9IBvgHraaaXjgxZIatASiS3bAMoYYjRIRKBhSenqGvXeJTxa2NMQFpCskG
 YqbPUCZEfPXGLZ7O96ALbyos5PFpSjhYtpShd4FUfqvYi38Q+LnFpw8XDsq612plfmbq
 n4eRGKAFEz91fJB6W5coarKlLXUQOJU4aV+N8zO4HpPLZWksU3MDeGRv/+WP8KdcEjcx
 7oRDwxHALuKNLhw748XlEP6LCoD0wFFs53+arI1E31inJsN0mrXVR55yauvlmBPn6Pko
 Qe9HOwqSTDp3qUqELYdkxzxuSOhZTGDlPNjUYN+QLBlkHug3dM45U6ITUgJUsTWHvENt
 b/8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz9bX6fYO1icItxJw+Se0M1N3UyTbm0n0Px+M0EFeUrIqJrFDIVK2M/w6hdyTkIxfjCN9MfB8GwY9o@nongnu.org
X-Gm-Message-State: AOJu0YwFGQTqMQVo5r2ldbDriihI1vNQIYp6K1YyRqjcPT0oAE6r/91e
 Kz08qFtiXg3LicfVej0Tzf+x+KAwpkreH3TBpz6jzFM2k12GLyDYHdICd1KpF2JnubTJN56PmZA
 lX9cAzvP6+bMusIjZMXKzHr7LKiRDa5OfQCfBHV1B68gFETHWlYU+HJmF
X-Gm-Gg: ASbGncs1lfrL13SiZBJOqe+lfs/EOLdcQQ2UVH7nzRAgT9HpkTfaCPgAjFgJ/+49vRd
 7cZoGVZiRDrNf7zGB7p28vJectP/M4e1tDMLjUJ4c/O2JBkQEvsGnejKttaePXLOdGJO4t6XyRU
 SajEPoUw3AL6Jc8uU8XmwAsW3e1nmXbsWJu8BnF+TwBN33/Y6zt1IVXbX8dt35IZa37qEqGmf9j
 C371fD3PuG4UG3TQYbPmhwi/TWd0d3KRNshpxOrOS1JcQWwkY0QHI/lHvWBMyDCYiUwLvx0CSgO
 vPCSuujB2fbsVBQJARDkz0DZc2x3c5hSaEV+tyek2qlufWlAe6vFFSZWjr+s
X-Received: by 2002:a05:6000:420d:b0:3a3:7593:81a1 with SMTP id
 ffacd0b85a97d-3a3759384b2mr5252135f8f.43.1747745634060; 
 Tue, 20 May 2025 05:53:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKttOhLBzn1gC2FqbkrBG+oTjVRv0eUjzRoycM34bj7OnWoqCBdC4NwDSSckYfkIwFp48f7A==
X-Received: by 2002:a05:6000:420d:b0:3a3:7593:81a1 with SMTP id
 ffacd0b85a97d-3a3759384b2mr5252103f8f.43.1747745633474; 
 Tue, 20 May 2025 05:53:53 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it.
 [82.53.134.35]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca5a8c4sm16161020f8f.27.2025.05.20.05.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 05:53:52 -0700 (PDT)
Date: Tue, 20 May 2025 14:53:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Huaitong Han <oenhan@gmail.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, cohuck@redhat.com, 
 pasic@linux.ibm.com, farman@linux.ibm.com, borntraeger@linux.ibm.com, 
 leiyang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Huaitong Han <hanht2@chinatelecom.cn>,
 Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>, 
 Jidong Xia <xiajd@chinatelecom.cn>
Subject: Re: [PATCH V2] vhost: Don't set vring call if guest notifier is unused
Message-ID: <js757hz2wuwhjafk7z2gmfqxdb6d5hhjx3ul7bwqst5qdqa5b7@f2lhjb6itxo2>
References: <20250513112825.1731347-1-hanht2@chinatelecom.cn>
 <dmtvkhqkwdv7rzum6c4gs3uiekwckou3yp7w2ql6tijxshoiju@w4rplxvassk6>
 <CAAuJbeJ4+cop8m_9sy6VJtafADhxxmkwaFMZvfo_mmpmFU0Vxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAuJbeJ4+cop8m_9sy6VJtafADhxxmkwaFMZvfo_mmpmFU0Vxw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, May 20, 2025 at 08:30:39PM +0800, Huaitong Han wrote:
>Stefano Garzarella <sgarzare@redhat.com> 于2025年5月20日周二 19:41写道：
>>
>> On Tue, May 13, 2025 at 07:28:25PM +0800, oenhan@gmail.com wrote:
>> >From: Huaitong Han <hanht2@chinatelecom.cn>
>> >
>> >The vring call fd is set even when the guest does not use MSI-X (e.g., in the
>> >case of virtio PMD), leading to unnecessary CPU overhead for processing
>> >interrupts.
>> >
>> >The commit 96a3d98d2c("vhost: don't set vring call if no vector") optimized the
>> >case where MSI-X is enabled but the queue vector is unset. However, there's an
>> >additional case where the guest uses INTx and the INTx_DISABLED bit in the PCI
>> >config is set, meaning that no interrupt notifier will actually be used.
>> >
>> >In such cases, the vring call fd should also be cleared to avoid redundant
>> >interrupt handling.
>> >
>> >Fixes: 96a3d98d2c("vhost: don't set vring call if no vector")
>>                    ^
>> nit: there should be a space here.
>>
>> If you need to resend, I think you can fix also the one in the
>> description.
>>
>> >Reported-by: Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
>> >Signed-off-by: Jidong Xia <xiajd@chinatelecom.cn>
>> >Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
>> >---
>> >V2:
>> >- Retain the name `query_guest_notifiers`
>> >- All qtest/unit test cases pass
>> >- Fix V1 patch style problems
>> >
>> > hw/pci/pci.c                   |  2 +-
>> > hw/s390x/virtio-ccw.c          |  7 +++++--
>> > hw/virtio/vhost.c              |  3 +--
>> > hw/virtio/virtio-pci.c         | 10 ++++++++--
>> > include/hw/pci/pci.h           |  1 +
>> > include/hw/virtio/virtio-bus.h |  2 +-
>> > 6 files changed, 17 insertions(+), 8 deletions(-)
>> >
>> >diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> >index 352b3d12c8..45b491412a 100644
>> >--- a/hw/pci/pci.c
>> >+++ b/hw/pci/pci.c
>> >@@ -1712,7 +1712,7 @@ static void pci_update_mappings(PCIDevice *d)
>> >     pci_update_vga(d);
>> > }
>> >
>> >-static inline int pci_irq_disabled(PCIDevice *d)
>> >+int pci_irq_disabled(PCIDevice *d)
>> > {
>> >     return pci_get_word(d->config + PCI_COMMAND) & PCI_COMMAND_INTX_DISABLE;
>> > }
>> >diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>> >index d2f85b39f3..632708ba4d 100644
>> >--- a/hw/s390x/virtio-ccw.c
>> >+++ b/hw/s390x/virtio-ccw.c
>> >@@ -936,11 +936,14 @@ static void virtio_ccw_vmstate_change(DeviceState *d, bool running)
>> >     }
>> > }
>> >
>> >-static bool virtio_ccw_query_guest_notifiers(DeviceState *d)
>> >+static bool virtio_ccw_query_guest_notifiers(DeviceState *d, int n)
>> > {
>> >     CcwDevice *dev = CCW_DEVICE(d);
>> >+    VirtioCcwDevice *vdev = VIRTIO_CCW_DEVICE(d);
>> >+    VirtIODevice *virtio_dev = virtio_bus_get_device(&vdev->bus);
>> >
>> >-    return !!(dev->sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA);
>> >+    return !!(dev->sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA)
>> >+            && virtio_queue_vector(virtio_dev, n) != VIRTIO_NO_VECTOR;
>> > }
>> >
>> > static int virtio_ccw_get_mappings(VirtioCcwDevice *dev)
>> >diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> >index 4cae7c1664..2a9a839763 100644
>> >--- a/hw/virtio/vhost.c
>> >+++ b/hw/virtio/vhost.c
>> >@@ -1341,8 +1341,7 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>> >     }
>> >
>> >     if (k->query_guest_notifiers &&
>> >-        k->query_guest_notifiers(qbus->parent) &&
>> >-        virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR) {
>> >+        !k->query_guest_notifiers(qbus->parent, idx)) {
>> >         file.fd = -1;
>> >         r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
>> >         if (r) {
>> >diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> >index 0fa8fe4955..d62e199489 100644
>> >--- a/hw/virtio/virtio-pci.c
>> >+++ b/hw/virtio/virtio-pci.c
>> >@@ -1212,10 +1212,16 @@ static int virtio_pci_set_guest_notifier(DeviceState *d, int n, bool assign,
>> >     return 0;
>> > }
>> >
>> >-static bool virtio_pci_query_guest_notifiers(DeviceState *d)
>> >+static bool virtio_pci_query_guest_notifiers(DeviceState *d, int n)
>> > {
>> >     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
>> >-    return msix_enabled(&proxy->pci_dev);
>> >+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
>> >+
>> >+    if (msix_enabled(&proxy->pci_dev)) {
>> >+        return virtio_queue_vector(vdev, n) != VIRTIO_NO_VECTOR;
>>
>> Why are we moving this check in every callback, can't we leave it as
>> before in vhost.c and here return true?
>>
>> I mean here:
>>      if (msix_enabled(&proxy->pci_dev)) {
>>          return true;
>>      } else {
>>          return !pci_irq_disabled(&proxy->pci_dev);
>>      }
>>
>> and leave vhost.c untouched.
>>
>
>Thanks for the suggestion — your approach indeed achieves the same
>effect while keeping the interface unchanged.
>However, I feel it might lead to some misunderstanding of the intended
>semantics of query_guest_notifiers. My original intent was for this
>callback to represent whether interrupts are actually in use by the
>guest, and in that sense, checking whether the queue uses a vector is
>part of that definition.

Okay, but IMHO these should be 2 patches, one that fixes the problem you 
mentioned (to be backported to stable, so with the Fixes tag), 
minimizing the changes. And another patch where you change the 
semantics.

>By splitting the logic — checking msix_enabled and pci_irq_disabled
>inside the bus callback, and virtio_queue_vector() separately in
>vhost.c — the semantic boundary becomes less clear. While it works
>logically, it can reduce readability — particularly because the
>virtio_queue_vector() check semantically belongs under the
>msix_enabled() branch, and combining it with the pci_irq_disabled()
>case (INTx) could make the logic less clear to future readers.
>Additionally, the set_host_notifier_mr interface already includes an
>int n parameter, so adding it to query_guest_notifiers is accepted.

I'm not sure that delegating the call to virtio_queue_vector() to each 
bus is an improvement honestly. But we can discuss it on the patch.

Thanks,
Stefano


