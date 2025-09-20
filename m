Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C49CCAC5A0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 04:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzpZO-0003Yl-Lg; Sat, 20 Sep 2025 00:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uzpZK-0003YS-8Z
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 00:51:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uzpZI-0005vt-AM
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 00:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758343886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bqa34mDZPi3WKCc5GCklaTSocWnxPsmAKVyoXQOSbrA=;
 b=TDNflHH5a7NufwljERkzY78BjoqpSdDkppDkr71bGR/vRndRGOuV4pD9oMEiq+VODC7yUL
 Wz9sOG/4C8FZ+aN1J/UrZGDBzNPsfbIeCMIzoydPLqkADZX+nDb0K0YLi7WNT/22uPhqIh
 L8HH7uiCouZ/WqRcH2brXcAYOI8x3O0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-qCV63dGLOEelRd8Bd5A5Fg-1; Sat, 20 Sep 2025 00:51:18 -0400
X-MC-Unique: qCV63dGLOEelRd8Bd5A5Fg-1
X-Mimecast-MFC-AGG-ID: qCV63dGLOEelRd8Bd5A5Fg_1758343876
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-62f599f0f5aso3069915a12.3
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 21:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758343876; x=1758948676;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bqa34mDZPi3WKCc5GCklaTSocWnxPsmAKVyoXQOSbrA=;
 b=htuDB9yMuM0X/nCZpAmiH1K+RgkhqmTH3lMI1fE5V4rAPvl6fi01d9pMICt8YnAxW7
 UClgvVq/yULcCy1ihRPaZnavsRoy9Q+xMZLDhCgdX9FKyjBOgb2k8ODHCpebkRfYc64R
 NqS/Xhtd8E1S8z4gjY0NZAnzOOYY7NMVex4ap4E6KTDhPdysfyNJD6X9FtO9rPhyvMDE
 uCLgxoo5QgdK+O/FZjg7cW0SLIGAi8TRX+d14hua4jQI+/UvJzULOMv9dcIHhka7xH9D
 vaX4lVfuX96D0+nMTXeJGMGBqM+Wn/4tlyM0J54l6QQaiHTU8kwKx+0Fd1UebAAZBGeD
 xA4w==
X-Gm-Message-State: AOJu0YwcZX+xuVZydIZDOzJzSoCUh3tpDynvUuGAYbTn62/koyJpaF15
 BON8LAur8cikKm/scfFTvizqDWIReKBhS/G5RHZMDSsXc7BpXzKhs0bJH+O6x3jt6Kh3RlvQreU
 rqBMFQE1VDnX1mrFMwTvmYVVZGBCjY8VvDEvkRFJq/RgLKz4NC3JPPIwH
X-Gm-Gg: ASbGnctX4MpBknDhXN9/a1LhSCv/ewuzsViy9KaN1YPPT14eakCjcJVLJmi7pWBBFDg
 CTGJjM7UVpRe7Xy1wWbPu4pjhtby9FgP+p5qNCP9XHsP0UMEhNJc5ybQfNvJPN0FTrKYxKWlnv6
 /nXNDcGlu/JRaQR2cZP6NCYNfefqk2PHj7WM2e4SdqQSH29y+ja2FMp4kPYpB4qwnm+J2/eGMWD
 isB6fCNSC0roTKytrUOPMyG9QWctBfXGkBehisrh2aZg+Le//jN0QmM3AOSDv0mORmtD2mYLXO5
 GwEb00Bo47CX0uUU7MkxRzwirqdR
X-Received: by 2002:a05:6402:348a:b0:62d:a8f3:4bbd with SMTP id
 4fb4d7f45d1cf-62fbff6458dmr4689386a12.0.1758343875972; 
 Fri, 19 Sep 2025 21:51:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOrwVRG6kSUy2x+xWLMbvIETYf8FdC+wLPtDZws5SdinrMwXV7iBTpi6fsGWKsW020oLo+Sg==
X-Received: by 2002:a05:6402:348a:b0:62d:a8f3:4bbd with SMTP id
 4fb4d7f45d1cf-62fbff6458dmr4689366a12.0.1758343875515; 
 Fri, 19 Sep 2025 21:51:15 -0700 (PDT)
Received: from redhat.com ([31.187.78.57]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-62fb10537d1sm3653499a12.24.2025.09.19.21.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Sep 2025 21:51:14 -0700 (PDT)
Date: Sat, 20 Sep 2025 00:51:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] hw/virtio: rename vhost-user-device and make user
 creatable
Message-ID: <20250920004637-mutt-send-email-mst@kernel.org>
References: <20250901105948.982583-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250901105948.982583-1-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Mon, Sep 01, 2025 at 11:59:48AM +0100, Alex Bennée wrote:
> We didn't make the device user creatable in the first place because we
> were worried users might get confused. Rename the device to make its
> nature as a test device even more explicit. While we are at it add a
> Kconfig variable so it can be skipped for those that want to thin out
> their build configuration even further.
> 
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-ID: <20250820195632.1956795-1-alex.bennee@linaro.org>


The confusion refers to users expecting
to use this in production without bothering to register
an id with the virtio TC, then the ID they hacked together
gets taken by Linux and everything breaks.


What exactly is the "test device" and the use-case here?


Maybe prefixing the name with "x-" like we do for unsupported properties
would help? I'm not sure, given someone on list already said they are
using a "wifi virtio" device in production with a very similar hack and
without talking to anyone.


> ---
> v1
>   - add review tags, ready to merge
> v2
>   - keep the -base name on TYPE_VHOST_USER_TEST_DEVICE_PCI
> ---
>  docs/system/devices/vhost-user.rst            | 20 +++++++------------
>  include/hw/virtio/vhost-user-base.h           |  2 +-
>  ...ice-pci.c => vhost-user-test-device-pci.c} | 17 +++++++---------
>  ...user-device.c => vhost-user-test-device.c} |  9 +++------
>  hw/virtio/Kconfig                             |  5 +++++
>  hw/virtio/meson.build                         |  5 +++--
>  6 files changed, 26 insertions(+), 32 deletions(-)
>  rename hw/virtio/{vhost-user-device-pci.c => vhost-user-test-device-pci.c} (77%)
>  rename hw/virtio/{vhost-user-device.c => vhost-user-test-device.c} (87%)
> 
> diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
> index 35259d8ec7c..bddf8df5ed5 100644
> --- a/docs/system/devices/vhost-user.rst
> +++ b/docs/system/devices/vhost-user.rst
> @@ -62,26 +62,20 @@ platform details for what sort of virtio bus to use.
>  The referenced *daemons* are not exhaustive, any conforming backend
>  implementing the device and using the vhost-user protocol should work.
>  
> -vhost-user-device
> -^^^^^^^^^^^^^^^^^
> +vhost-user-test-device
> +^^^^^^^^^^^^^^^^^^^^^^
>  
> -The vhost-user-device is a generic development device intended for
> -expert use while developing new backends. The user needs to specify
> -all the required parameters including:
> +The vhost-user-test-device is a generic development device intended
> +for expert use while developing new backends. The user needs to
> +specify all the required parameters including:
>  
>    - Device ``virtio-id``
>    - The ``num_vqs`` it needs and their ``vq_size``
>    - The ``config_size`` if needed
>  
>  .. note::
> -  To prevent user confusion you cannot currently instantiate
> -  vhost-user-device without first patching out::
> -
> -    /* Reason: stop inexperienced users confusing themselves */
> -    dc->user_creatable = false;
> -
> -  in ``vhost-user-device.c`` and ``vhost-user-device-pci.c`` file and
> -  rebuilding.
> +  While this is a useful device for development it is not recommended
> +  for production use.
>  
>  vhost-user daemon
>  =================
> diff --git a/include/hw/virtio/vhost-user-base.h b/include/hw/virtio/vhost-user-base.h
> index 51d0968b893..387e434b804 100644
> --- a/include/hw/virtio/vhost-user-base.h
> +++ b/include/hw/virtio/vhost-user-base.h
> @@ -44,6 +44,6 @@ struct VHostUserBaseClass {
>  };
>  
>  
> -#define TYPE_VHOST_USER_DEVICE "vhost-user-device"
> +#define TYPE_VHOST_USER_TEST_DEVICE "vhost-user-test-device"
>  
>  #endif /* QEMU_VHOST_USER_BASE_H */
> diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-test-device-pci.c
> similarity index 77%
> rename from hw/virtio/vhost-user-device-pci.c
> rename to hw/virtio/vhost-user-test-device-pci.c
> index f10bac874e7..b4ed0efb50f 100644
> --- a/hw/virtio/vhost-user-device-pci.c
> +++ b/hw/virtio/vhost-user-test-device-pci.c
> @@ -18,13 +18,13 @@ struct VHostUserDevicePCI {
>      VHostUserBase vub;
>  };
>  
> -#define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
> +#define TYPE_VHOST_USER_TEST_DEVICE_PCI "vhost-user-test-device-pci-base"
>  
> -OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_USER_DEVICE_PCI)
> +OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_USER_TEST_DEVICE_PCI)
>  
>  static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>  {
> -    VHostUserDevicePCI *dev = VHOST_USER_DEVICE_PCI(vpci_dev);
> +    VHostUserDevicePCI *dev = VHOST_USER_TEST_DEVICE_PCI(vpci_dev);
>      DeviceState *vdev = DEVICE(&dev->vub);
>  
>      vpci_dev->nvectors = 1;
> @@ -38,9 +38,6 @@ static void vhost_user_device_pci_class_init(ObjectClass *klass,
>      VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
>      PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
>  
> -    /* Reason: stop users confusing themselves */
> -    dc->user_creatable = false;
> -
>      k->realize = vhost_user_device_pci_realize;
>      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>      pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
> @@ -51,15 +48,15 @@ static void vhost_user_device_pci_class_init(ObjectClass *klass,
>  
>  static void vhost_user_device_pci_instance_init(Object *obj)
>  {
> -    VHostUserDevicePCI *dev = VHOST_USER_DEVICE_PCI(obj);
> +    VHostUserDevicePCI *dev = VHOST_USER_TEST_DEVICE_PCI(obj);
>  
>      virtio_instance_init_common(obj, &dev->vub, sizeof(dev->vub),
> -                                TYPE_VHOST_USER_DEVICE);
> +                                TYPE_VHOST_USER_TEST_DEVICE);
>  }
>  
>  static const VirtioPCIDeviceTypeInfo vhost_user_device_pci_info = {
> -    .base_name = TYPE_VHOST_USER_DEVICE_PCI,
> -    .non_transitional_name = "vhost-user-device-pci",
> +    .base_name = TYPE_VHOST_USER_TEST_DEVICE_PCI,
> +    .non_transitional_name = "vhost-user-test-device-pci",
>      .instance_size = sizeof(VHostUserDevicePCI),
>      .instance_init = vhost_user_device_pci_instance_init,
>      .class_init = vhost_user_device_pci_class_init,
> diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-test-device.c
> similarity index 87%
> rename from hw/virtio/vhost-user-device.c
> rename to hw/virtio/vhost-user-test-device.c
> index 3939bdf7552..1b98ea3e488 100644
> --- a/hw/virtio/vhost-user-device.c
> +++ b/hw/virtio/vhost-user-test-device.c
> @@ -1,5 +1,5 @@
>  /*
> - * Generic vhost-user-device implementation for any vhost-user-backend
> + * Generic vhost-user-test-device implementation for any vhost-user-backend
>   *
>   * This is a concrete implementation of vhost-user-base which can be
>   * configured via properties. It is useful for development and
> @@ -25,7 +25,7 @@
>   */
>  
>  static const VMStateDescription vud_vmstate = {
> -    .name = "vhost-user-device",
> +    .name = "vhost-user-test-device",
>      .unmigratable = 1,
>  };
>  
> @@ -41,16 +41,13 @@ static void vud_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
> -    /* Reason: stop inexperienced users confusing themselves */
> -    dc->user_creatable = false;
> -
>      device_class_set_props(dc, vud_properties);
>      dc->vmsd = &vud_vmstate;
>      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>  }
>  
>  static const TypeInfo vud_info = {
> -    .name = TYPE_VHOST_USER_DEVICE,
> +    .name = TYPE_VHOST_USER_TEST_DEVICE,
>      .parent = TYPE_VHOST_USER_BASE,
>      .class_init = vud_class_init,
>  };
> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> index 7648a2d68da..10f5c53ac09 100644
> --- a/hw/virtio/Kconfig
> +++ b/hw/virtio/Kconfig
> @@ -126,3 +126,8 @@ config VHOST_USER_SCMI
>      bool
>      default y
>      depends on VIRTIO && VHOST_USER && ARM
> +
> +config VHOST_USER_TEST
> +    bool
> +    default y
> +    depends on VIRTIO && VHOST_USER
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index 3ea7b3cec83..48b9fedfa56 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -22,7 +22,7 @@ if have_vhost
>      system_virtio_ss.add(files('vhost-user-base.c'))
>  
>      # MMIO Stubs
> -    system_virtio_ss.add(files('vhost-user-device.c'))
> +    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_TEST', if_true: files('vhost-user-test-device.c'))
>      system_virtio_ss.add(when: 'CONFIG_VHOST_USER_GPIO', if_true: files('vhost-user-gpio.c'))
>      system_virtio_ss.add(when: 'CONFIG_VHOST_USER_I2C', if_true: files('vhost-user-i2c.c'))
>      system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RNG', if_true: files('vhost-user-rng.c'))
> @@ -30,7 +30,8 @@ if have_vhost
>      system_virtio_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input.c'))
>  
>      # PCI Stubs
> -    system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('vhost-user-device-pci.c'))
> +    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_TEST'],
> +                         if_true: files('vhost-user-test-device-pci.c'))
>      system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_GPIO'],
>                           if_true: files('vhost-user-gpio-pci.c'))
>      system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_I2C'],
> -- 
> 2.47.2


