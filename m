Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E65CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 14:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzcNl-0006VV-Ha; Fri, 19 Sep 2025 10:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uzcNj-0006Uy-8n
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:46:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uzcNd-0004uT-Kg
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758293185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A7VMo2oDb08dA9CCKSxIBR5Dj8JPSc0okdXrVy8mlsI=;
 b=Sn4ezel8Tu/tEPmjTG38SnLrka0+NVoqAMJKS8LFI4iRMkeEAl0dq2TsrzopIVkQtDLN8z
 4dQDEc23eJzwn5h97uLGSaA1XMNr19Rz0pcW7CeAxkv0fk05BGav2cmZmi6mbnLEAMJ7X9
 ZGsPu3M7zTFiktXptnrX0PMkzTkUUXQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-mAla354jO1CPu1gU4GhTGQ-1; Fri, 19 Sep 2025 10:46:23 -0400
X-MC-Unique: mAla354jO1CPu1gU4GhTGQ-1
X-Mimecast-MFC-AGG-ID: mAla354jO1CPu1gU4GhTGQ_1758293182
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45f2f15003aso14295085e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 07:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758293182; x=1758897982;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A7VMo2oDb08dA9CCKSxIBR5Dj8JPSc0okdXrVy8mlsI=;
 b=RtNI+Hajz/w0oE2aPXR57lqtCACXcA4GvGpjjE/apnQb4iM5SPjNvZ5mXThQw8JaCg
 By5xnXI5ktLpaXYvabHUjIyd4XiJTaei1fGeC4UDR1EjlzWbj5u+JL0AWQBN51CTwQNe
 ZTn+I8odg6tJ7SXX1QbEDUXCVjMq1t0sXxUH+6o+WyVRbf8Xo7G8xx15EkQX/LFv+IXb
 t7iB5zX1nbhD0Aj5rMIZAgCEgEZxmvHVOWehYLGQ3VDr5zP2gTVbovZ33Tg0WMX+LH7b
 GQaDMkq7SC4iMLqoTvsjWIxaY9eEIDfc9s7TjIVqTZyb40No5mOnjI7bVTcwTVSQz5cN
 AsAQ==
X-Gm-Message-State: AOJu0YyDpceYKy9MmLvGhOIO+DethQBNvjQ8H3EBsXZroZ0eWo7OzEkW
 Lh3C+sV6Mjv5wMEnwGzlfiIAKCaPZpoKZ4nw937wDODuvP5WpVcq56srWql9IcWqG+Jn7w9sowd
 W8Ehi50Pjx78ew8ulzEoNUTzHvA1Q5yQoe+dSF3XLOYjKWEPNMKwtIOh4
X-Gm-Gg: ASbGncu0H0CpZOzZ1oT9iRF4D1Pq7dNnq4eykIlDHXXYKbYerkU6BsaSHUfWuFs3fxV
 t7BTSC7PLs8VLlrHq0p1E/iF7ZJJMzQR/FVZTFowuWXhoTllZwGvl6QBFa/byUSQLMh73wS3Aqo
 EX3D4TL8+nypB8TLzyxfrSFQq1sRYcPgcfB7cjtUcOFz7ikeMMVQOb+ZOA5b4KTGIsJMOl90++S
 qSvYlB6+sQY3VKLAu0NF5PDTysvHrq8MKc8bpa4nC6hx8WPK5GSCJ1V0SANpY9KfcFAOSv4b3ZI
 YgaesmQGM8E2G1p44VFbI+lva9gTaTnjegAc1B+qq33T
X-Received: by 2002:a05:600c:190c:b0:45f:2843:e76d with SMTP id
 5b1f17b1804b1-467e6b64cd3mr35821385e9.4.1758293182450; 
 Fri, 19 Sep 2025 07:46:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFru3dcpzZ4DQLVrBnKU2viVlnSPNqPgs5L1VsgiFJQ3l+sHspg97lhEDGMzM4rCsbG01rPdA==
X-Received: by 2002:a05:600c:190c:b0:45f:2843:e76d with SMTP id
 5b1f17b1804b1-467e6b64cd3mr35821095e9.4.1758293181951; 
 Fri, 19 Sep 2025 07:46:21 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.144.126])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4613ddc01e6sm124936265e9.18.2025.09.19.07.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Sep 2025 07:46:21 -0700 (PDT)
Date: Fri, 19 Sep 2025 16:46:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Christian Speich <c.speich@avm.de>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] virtio: vhost-user-device: Make user creatable again
Message-ID: <vugv2kmwkhguq7tx4hxkwrwgknxgmy7zkqmwkogc2sjiofyhzs@ue77hrnka34p>
References: <20250919-vhost-user-device-creatable-v1-1-87eefeea7f68@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250919-vhost-user-device-creatable-v1-1-87eefeea7f68@avm.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 19, 2025 at 04:30:53PM +0200, Christian Speich wrote:
>This removes the change introduced in [1] that prevents the use of
>vhost-user-device and vhost-user-device-pci on unpatched QEMU builds.
>
>[1]: 6275989647efb708f126eb4f880e593792301ed4
>
>Signed-off-by: Christian Speich <c.speich@avm.de>
>---
>vhost-user-device and vhost-user-device-pci started out as user
>creatable devices. This was changed in [1] when the vhost-user-base was
>introduced.
>
>The reason given is to prevent user confusion. Searching qemu-discuss or
>google for "vhost-user-device" I've seen no confused users.
>
>Our use case is to provide wifi emulation using "vhost-user-device-pci",
>which currently is working fine with the QEMU 9.0.2 present in Ubuntu
>24.04. With newer QEMU versions we now need to patch, distribute and
>maintain our own QEMU packages, which is non-trivial.
>
>So I want to propose lifting this restriction to make this feature
>usable without a custom QEMU.

Alex already proposed something similar:

https://lore.kernel.org/qemu-devel/20250901105948.982583-1-alex.bennee@linaro.org/

Thanks,
Stefano

>
>[1]: 6275989647efb708f126eb4f880e593792301ed4
>---
> docs/system/devices/vhost-user.rst | 10 ----------
> hw/virtio/vhost-user-device-pci.c  |  3 ---
> hw/virtio/vhost-user-device.c      |  3 ---
> 3 files changed, 16 deletions(-)
>
>diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
>index 35259d8ec7c666aa0c56497b8261f48d77216ad5..2d130f9767dbb1cbb85cef43c63dc9a8d7b30d4a 100644
>--- a/docs/system/devices/vhost-user.rst
>+++ b/docs/system/devices/vhost-user.rst
>@@ -73,16 +73,6 @@ all the required parameters including:
>   - The ``num_vqs`` it needs and their ``vq_size``
>   - The ``config_size`` if needed
>
>-.. note::
>-  To prevent user confusion you cannot currently instantiate
>-  vhost-user-device without first patching out::
>-
>-    /* Reason: stop inexperienced users confusing themselves */
>-    dc->user_creatable = false;
>-
>-  in ``vhost-user-device.c`` and ``vhost-user-device-pci.c`` file and
>-  rebuilding.
>-
> vhost-user daemon
> =================
>
>diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-device-pci.c
>index f10bac874e78429c633752a4ce9db28385b3bb07..c76a856c9b9a67d941a93929244216658ff2a156 100644
>--- a/hw/virtio/vhost-user-device-pci.c
>+++ b/hw/virtio/vhost-user-device-pci.c
>@@ -38,9 +38,6 @@ static void vhost_user_device_pci_class_init(ObjectClass *klass,
>     VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
>     PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
>
>-    /* Reason: stop users confusing themselves */
>-    dc->user_creatable = false;
>-
>     k->realize = vhost_user_device_pci_realize;
>     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>     pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
>diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-device.c
>index 3939bdf755222a281da8ca22243d7d4f16990a66..1bea496afd0137ba9b42009f6252acf6800528d1 100644
>--- a/hw/virtio/vhost-user-device.c
>+++ b/hw/virtio/vhost-user-device.c
>@@ -41,9 +41,6 @@ static void vud_class_init(ObjectClass *klass, const void *data)
> {
>     DeviceClass *dc = DEVICE_CLASS(klass);
>
>-    /* Reason: stop inexperienced users confusing themselves */
>-    dc->user_creatable = false;
>-
>     device_class_set_props(dc, vud_properties);
>     dc->vmsd = &vud_vmstate;
>     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>
>---
>base-commit: e7c1e8043a69c5a8efa39d4f9d111f7c72c076e6
>change-id: 20250919-vhost-user-device-creatable-b7f9b7b5bfb2
>
>Best regards,
>-- 
>Christian Speich <c.speich@avm.de>
>
>


