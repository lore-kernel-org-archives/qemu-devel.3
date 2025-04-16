Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730E0C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 09:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4zEQ-0000Tu-38; Wed, 16 Apr 2025 05:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1u4zEN-0000QB-KO
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:38:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1u4zEK-0004ku-Iq
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 05:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744796330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ym5B4qTAcY6SnfXLqUnqPnWiLFXuv5QflE36GRht93I=;
 b=cLVJVE9RC4ekfEajsHYF8BVnq2dQDZLB+bGGqqQW3gUl2OjoB1l0xZziKzkpbzkf8XIFPs
 6hXKS2AromSEruGbZ3klpmfzCSCCOTDKGflIHp6ZKI5GW9+P+UwFKMbNkM6aZsXkyZPoMz
 Ooje9u/1EptdMs7uzC93D85HGGeqm2U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-5bnfBgsSNNKOoLbUW13AfA-1; Wed, 16 Apr 2025 05:38:49 -0400
X-MC-Unique: 5bnfBgsSNNKOoLbUW13AfA-1
X-Mimecast-MFC-AGG-ID: 5bnfBgsSNNKOoLbUW13AfA_1744796328
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d0a037f97so39925855e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 02:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744796327; x=1745401127;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ym5B4qTAcY6SnfXLqUnqPnWiLFXuv5QflE36GRht93I=;
 b=MkyrZXa49k98lOjiU6gIMTyDC+wJym9Xrf2eqenxCiMTdwTrLusSLCBrv9dsdCk1L6
 2f5Y4P+YWaFuDXUTWh1cx+LYqRhcWzyhqodP8vXd287KFZTmnDws3um6jUpCibH059YP
 h0vQVnwc7ElVwIGTJe8fQ3wKoodaAKKSMpR+hWVtCc+oGzHoWt/8XzJ9H3P7f4wkv/07
 VBLGhC9WGxsVyeaA2dwzj0Cm+O7wctxyNeoVLEogKNl/mZWcb2cZuZdBX/Nd6mOyhB6h
 W3gAr9e3L6kAigxbM+Pi9bkF2g9Oxq3EZUmoDxKRbCW9Mn0QfNAV95/O1gNpz4ATIn6E
 /Shg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUI9vmdgO4RopdPVnijLPaka6zTnsk1wfsRq1v0cSXA/qOnhWC+Ua5hEiwZLAaROOw7a2SmEBHqes+@nongnu.org
X-Gm-Message-State: AOJu0YzuwRqCpqlaHrOy1M7oUn+qJHrcEbq1xC1rfhyIhq4m7u5fK1wf
 KFgAq4bm+B0nsmCzJOcEcZbA5fBe6bPm62NEvzm0p4x65DG60DgHWqmFVbOGpPP5B7QTLrCz0Ts
 KT29vQ/dautV9F13ikz62zlpuIjTUF+MczdJk7HmGi7ntVAOGdOA0
X-Gm-Gg: ASbGncsItAIBzIg/pNu7IV4awoneaE4DOOCBI3gs90RG+fWqm70hNLx42eiWoKW3SAJ
 8y+bs0xg4l02bbmCVpdy1oItrnTXEgZwa0cHe4wXFNFrY80meksgJz9fN86Sj8G8YXZ0Kg283ZO
 Yu1GTVz/PDPOXtiu//5cDosrsTSfn34EMO7cFBhb1O+qaDd0WoBPcTylF4237so/+Y4fvjgTZRw
 BFncJR9hhXXO6OiU3pwhOlTZQrQTnNmg/GNdGAsRa5eLbwVWwHPV50Av+Jo2UgQQJGFOkphyq31
 U5vsiNgyhA6emlSXOg==
X-Received: by 2002:a05:6000:40de:b0:391:487f:282a with SMTP id
 ffacd0b85a97d-39ee5bb1bd5mr831836f8f.50.1744796326969; 
 Wed, 16 Apr 2025 02:38:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqbBZzeWuTPv6J4bEdkB+52ZC3OugypKQLM7S9fidquU9nCUAc+WkbnPOFQhaZAQLGxyviBA==
X-Received: by 2002:a05:6000:40de:b0:391:487f:282a with SMTP id
 ffacd0b85a97d-39ee5bb1bd5mr831816f8f.50.1744796326431; 
 Wed, 16 Apr 2025 02:38:46 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.148.176])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae96c123sm17161784f8f.36.2025.04.16.02.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 02:38:45 -0700 (PDT)
Date: Wed, 16 Apr 2025 11:38:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Huaitong Han <oenhan@gmail.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, cohuck@redhat.com, 
 pasic@linux.ibm.com, farman@linux.ibm.com, borntraeger@linux.ibm.com, 
 leiyang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Huaitong Han <hanht2@chinatelecom.cn>,
 Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>, 
 Jidong Xia <xiajd@chinatelecom.cn>
Subject: Re: [PATCH] vhost: Don't set vring call if guest notifier is unused
Message-ID: <qyadghh4k5xfy3mibinxwr6m23pett4w7uoi6i55wph255gfvh@p3yusapcxqjh>
References: <20250326082537.379977-1-hanht2@chinatelecom.cn>
 <rqx2ixzzd3vnxirsyone67udq6xjztpp2jihwa7r44ffmdtjol@lpao7euzvcvj>
 <CAAuJbeJCz8btAZCAcg6+7jmEGH-pfcK6Qo1CCo85sC92CXX+GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAuJbeJCz8btAZCAcg6+7jmEGH-pfcK6Qo1CCo85sC92CXX+GA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Apr 07, 2025 at 03:53:24PM +0800, Huaitong Han wrote:
>Stefano Garzarella <sgarzare@redhat.com> 于2025年4月1日周二 18:49写道：
>
>>
>> On Wed, Mar 26, 2025 at 04:25:37PM +0800, oenhan@gmail.com wrote:
>> >From: Huaitong Han <hanht2@chinatelecom.cn>
>> >
>> >The vring call fd is set even when the guest does not use msix (e.g., in the
>> >case of virtio pmd), leading to unnecessary CPU overhead for processing
>> >interrupts. The previous patch optimized the condition where msix is
>>
>> What would be the previous patch?
>>
>> If you're referencing a patch already merged, please add them in the
>> same form you used in Fixes, for example:
>> Commit XXXXX ("vhost: ...") optimized the condition ...
>>
>Accept
>
>> >enabled
>> >but the queue vector is unset. However, there is a additional case 
>> >where the
>> >guest interrupt notifier is effectively unused and the vring call fd 
>> >should
>> >also be cleared: the guest does not use msix and the INTX_DISABLED 
>> >bit in the PCI
>> >config is set.
>>
>> I don't know this code very well, can you explain better what you are
>> changing with this patch and why change the name of
>> query_guest_notifiers?
>>
>There's the case where the guest uses INTx, but the INTx_DISABLED bit
>is set — meaning no notifier will actually be used either. This patch
>generalizes the logic to cover these cases.
>The current name might be misleading. It seems to imply the device has
>notifiers enabled, but in fact, the check is meant to reflect whether
>the guest is actively using any interrupt mechanism.  I felt renaming
>it could make the intent more clear and reduce confusion. Let me know
>if you think it's better to keep the original name.

Okay, now it's a bit more clear, so I suggest to put these kind of 
information in the commit description. It should always contains the 
reason of changes.

In this case I don't know if it's better to split into 2 patches, one 
where you fix the behavior and one where you update the name, but I 
leave it to the maintainers to decide, even one would be fine if 
explained well in the commit description.

>
>> >
>> >Fixes: 96a3d98d2c ("vhost: don't set vring call if no vector")
>> >
>> >Test result:
>> >https://raw.githubusercontent.com/oenhan/build_log/refs/heads/main/qemu/2503261015/build/meson-logs/testlog.txt
>>
>> Does it make sense to have this link in the commit, will it always be
>> accessible?
>MST initially asked me to make the test result public.  I understand
>that embedding a direct test log link into the commit log is not good,
>I will remove the test result link from the commit log in the next
>version, and instead include it in the email reply body.

Yep, I think after --- should be fine.

Thanks,
Stefano

>
>>
>> >
>> >Reported-by: Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
>> >Signed-off-by: Jidong Xia <xiajd@chinatelecom.cn>
>> >Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
>> >---
>> > hw/pci/pci.c                   |  2 +-
>> > hw/s390x/virtio-ccw.c          |  9 ++++++---
>> > hw/virtio/vhost.c              |  5 ++---
>> > hw/virtio/virtio-pci.c         | 15 ++++++++++-----
>> > include/hw/pci/pci.h           |  1 +
>> > include/hw/virtio/virtio-bus.h |  2 +-
>> > 6 files changed, 21 insertions(+), 13 deletions(-)
>> >
>> >diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> >index 2844ec5556..503a897528 100644
>> >--- a/hw/pci/pci.c
>> >+++ b/hw/pci/pci.c
>> >@@ -1719,7 +1719,7 @@ static void pci_update_mappings(PCIDevice *d)
>> >     pci_update_vga(d);
>> > }
>> >
>> >-static inline int pci_irq_disabled(PCIDevice *d)
>> >+int pci_irq_disabled(PCIDevice *d)
>> > {
>> >     return pci_get_word(d->config + PCI_COMMAND) & PCI_COMMAND_INTX_DISABLE;
>> > }
>> >diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>> >index 43f3b162c8..af482a22cd 100644
>> >--- a/hw/s390x/virtio-ccw.c
>> >+++ b/hw/s390x/virtio-ccw.c
>> >@@ -936,11 +936,14 @@ static void virtio_ccw_vmstate_change(DeviceState *d, bool running)
>> >     }
>> > }
>> >
>> >-static bool virtio_ccw_query_guest_notifiers(DeviceState *d)
>> >+static bool virtio_ccw_query_guest_notifiers_used(DeviceState *d, int n)
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
>> >@@ -1270,7 +1273,7 @@ static void virtio_ccw_bus_class_init(ObjectClass *klass, void *data)
>> >     bus_class->max_dev = 1;
>> >     k->notify = virtio_ccw_notify;
>> >     k->vmstate_change = virtio_ccw_vmstate_change;
>> >-    k->query_guest_notifiers = virtio_ccw_query_guest_notifiers;
>> >+    k->query_guest_notifiers_used = virtio_ccw_query_guest_notifiers_used;
>> >     k->set_guest_notifiers = virtio_ccw_set_guest_notifiers;
>> >     k->save_queue = virtio_ccw_save_queue;
>> >     k->load_queue = virtio_ccw_load_queue;
>> >diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> >index 6aa72fd434..32634da836 100644
>> >--- a/hw/virtio/vhost.c
>> >+++ b/hw/virtio/vhost.c
>> >@@ -1341,9 +1341,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>> >         vhost_virtqueue_mask(dev, vdev, idx, false);
>> >     }
>> >
>> >-    if (k->query_guest_notifiers &&
>> >-        k->query_guest_notifiers(qbus->parent) &&
>> >-        virtio_queue_vector(vdev, idx) == VIRTIO_NO_VECTOR) {
>> >+    if (k->query_guest_notifiers_used &&
>> >+        !k->query_guest_notifiers_used(qbus->parent, idx)) {
>> >         file.fd = -1;
>> >         r = dev->vhost_ops->vhost_set_vring_call(dev, &file);
>> >         if (r) {
>> >diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> >index 3ca3f849d3..25ff869618 100644
>> >--- a/hw/virtio/virtio-pci.c
>> >+++ b/hw/virtio/virtio-pci.c
>> >@@ -30,6 +30,7 @@
>> > #include "qemu/error-report.h"
>> > #include "qemu/log.h"
>> > #include "qemu/module.h"
>> >+#include "hw/pci/pci.h"
>> > #include "hw/pci/msi.h"
>> > #include "hw/pci/msix.h"
>> > #include "hw/loader.h"
>> >@@ -1031,7 +1032,7 @@ static void virtio_pci_one_vector_mask(VirtIOPCIProxy *proxy,
>> >
>> >     /* If guest supports masking, keep irqfd but mask it.
>> >      * Otherwise, clean it up now.
>> >-     */
>> >+     */
>>
>> Unrelated change.
>>
>> >     if (vdev->use_guest_notifier_mask && k->guest_notifier_mask) {
>> >         k->guest_notifier_mask(vdev, queue_no, true);
>> >     } else {
>> >@@ -1212,10 +1213,15 @@ static int virtio_pci_set_guest_notifier(DeviceState *d, int n, bool assign,
>> >     return 0;
>> > }
>> >
>> >-static bool virtio_pci_query_guest_notifiers(DeviceState *d)
>> >+static bool virtio_pci_query_guest_notifiers_used(DeviceState *d, int n)
>> > {
>> >     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
>> >-    return msix_enabled(&proxy->pci_dev);
>> >+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
>> >+
>> >+    if (msix_enabled(&proxy->pci_dev))
>> >+        return virtio_queue_vector(vdev, n) != VIRTIO_NO_VECTOR;
>> >+    else
>> >+        return !pci_irq_disabled(&proxy->pci_dev);
>> > }
>> >
>> > static int virtio_pci_set_guest_notifiers(DeviceState *d, int nvqs, bool assign)
>> >@@ -2599,7 +2605,7 @@ static void virtio_pci_bus_class_init(ObjectClass *klass, void *data)
>> >     k->save_extra_state = virtio_pci_save_extra_state;
>> >     k->load_extra_state = virtio_pci_load_extra_state;
>> >     k->has_extra_state = virtio_pci_has_extra_state;
>> >-    k->query_guest_notifiers = virtio_pci_query_guest_notifiers;
>> >+    k->query_guest_notifiers_used = virtio_pci_query_guest_notifiers_used;
>> >     k->set_guest_notifiers = virtio_pci_set_guest_notifiers;
>> >     k->set_host_notifier_mr = virtio_pci_set_host_notifier_mr;
>> >     k->vmstate_change = virtio_pci_vmstate_change;
>> >@@ -2630,4 +2636,3 @@ static void virtio_pci_register_types(void)
>> > }
>> >
>> > type_init(virtio_pci_register_types)
>> >-
>> >diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>> >index 822fbacdf0..de4ab28046 100644
>> >--- a/include/hw/pci/pci.h
>> >+++ b/include/hw/pci/pci.h
>> >@@ -256,6 +256,7 @@ void pci_del_capability(PCIDevice *pci_dev, uint8_t cap_id, uint8_t cap_size);
>> >
>> > uint8_t pci_find_capability(PCIDevice *pci_dev, uint8_t cap_id);
>> >
>> >+int pci_irq_disabled(PCIDevice *d);
>> >
>> > uint32_t pci_default_read_config(PCIDevice *d,
>> >                                  uint32_t address, int len);
>> >diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
>> >index 7ab8c9dab0..de75a44895 100644
>> >--- a/include/hw/virtio/virtio-bus.h
>> >+++ b/include/hw/virtio/virtio-bus.h
>> >@@ -48,7 +48,7 @@ struct VirtioBusClass {
>> >     int (*load_done)(DeviceState *d, QEMUFile *f);
>> >     int (*load_extra_state)(DeviceState *d, QEMUFile *f);
>> >     bool (*has_extra_state)(DeviceState *d);
>> >-    bool (*query_guest_notifiers)(DeviceState *d);
>> >+    bool (*query_guest_notifiers_used)(DeviceState *d, int n);
>> >     int (*set_guest_notifiers)(DeviceState *d, int nvqs, bool assign);
>> >     int (*set_host_notifier_mr)(DeviceState *d, int n,
>> >                                 MemoryRegion *mr, bool assign);
>> >--
>> >2.43.5
>> >
>>
>


