Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF243CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 20:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzhOM-0004pO-4s; Fri, 19 Sep 2025 16:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uzhOK-0004oY-94
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 16:07:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uzhOE-0001mJ-Ky
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 16:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758312447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1XdwT1Ln2spkiUpfH8kV44iubjsEUf/WQT6VPbEVlgA=;
 b=ejiJlldra8rnAmw3IT1mOHs7OLkROWwDI8GdCXtcNGUDeIgIJe8FvcWDHY3lQjkR70ouSC
 oSQTkxlGxpyBUE5ccQCxeTK2iGXSGMhDVjZ82Ds/HTjhMdxQkVxhmpnr7k3uSD1iyDb438
 M5ZbohRp8iSbwzabVAeXzJyo8gWOSXs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-kKbC6fJSNXyPZ8OHDpDugQ-1; Fri, 19 Sep 2025 16:07:24 -0400
X-MC-Unique: kKbC6fJSNXyPZ8OHDpDugQ-1
X-Mimecast-MFC-AGG-ID: kKbC6fJSNXyPZ8OHDpDugQ_1758312443
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b04a8ae1409so236110466b.2
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 13:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758312443; x=1758917243;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1XdwT1Ln2spkiUpfH8kV44iubjsEUf/WQT6VPbEVlgA=;
 b=pd1wRpLCLiN/e89NSqwQfqerqeNi2GpbGoL1wxHUNFVKpfwLNfhc6ERLrLsVDDjnEQ
 SZI8FjeZE1vWZ5T7KMD/7KZESOMzwDObtQUg7WKEAqwLe4cjz5pKysWmu1KcjVcWZ3MK
 ELZ4qtlg0FsFWVDBhfXT1cMMbRcrmKWqzxArxmfhtYLF5EfRkzzTW+gNCdho1hJQQnQf
 KRVaUEfzzw87QMmtBdEEV9bPGJGKMB5j3aUeh9gmhFd7vUr4wLwaJQi94/GMWwFHqMKV
 azzZgqyq3uV9DV+swrzkpjrvjxhcU76eCye9HTT2UouRB40OekZ3ZouIJH1W0u/JkGou
 2Kqw==
X-Gm-Message-State: AOJu0YzVm4wAGSnkOMuhdaQWntifOERpM7qgeQ4Jf2o6r6MAQU9f4iBI
 PCkXVbBzfFT5vzCSyxvrq8HxCDTX5c48wwWvhXDhVDfv5AFbeO/uT0cqDg1FAJYQB6NNdO1IvTt
 /9jcLSZRpH7LhHrJPoVTWTlLFUpGXEYYBnKMJVRdfNHMq92d7H130b2OP
X-Gm-Gg: ASbGncsE4QPhrYCUMsygGCdep/lDBkuA9MefvIfNNV+ggI6WOSsC750FnUfhaXMM5Jh
 Yfq71DQVu/DbbS1jI9N0y6q1DHeLHrBN2Q4XqPxKpaEf+DT3qVDyUH7Bbohl8LvAFrayt/p1K2Y
 gyYslKbRX1GDI9d4MO6zCU+FA5hgoh3ZjKVhxAYr+XKdIHoY7p2aZ9h67N95wn2Nto6hlXydOTU
 sn1GVeQbYAZDws9wF21q3HIU6P3cqaSlEKXPJMQLDgMTzwak0SIsA5npMZ1Nxn/L98RExckDnWT
 smoLBE0M18giaRQzAvBJlNkviDee
X-Received: by 2002:a17:907:3e28:b0:af9:414d:9c2 with SMTP id
 a640c23a62f3a-b24ee6ef579mr497129566b.3.1758312443384; 
 Fri, 19 Sep 2025 13:07:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSeov9MpenEiabdtwvgSr9s2k9XCgBB9HA7YvXYctPzvp4AWZzFgcA4EP6kx5LJq1Gooblxw==
X-Received: by 2002:a17:907:3e28:b0:af9:414d:9c2 with SMTP id
 a640c23a62f3a-b24ee6ef579mr497127066b.3.1758312442819; 
 Fri, 19 Sep 2025 13:07:22 -0700 (PDT)
Received: from redhat.com ([31.187.78.57]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b1fc73ba1e8sm501930166b.31.2025.09.19.13.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Sep 2025 13:07:22 -0700 (PDT)
Date: Fri, 19 Sep 2025 16:07:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christian Speich <c.speich@avm.de>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] virtio: vhost-user-device: Make user creatable again
Message-ID: <20250919160526-mutt-send-email-mst@kernel.org>
References: <20250919-vhost-user-device-creatable-v1-1-87eefeea7f68@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-vhost-user-device-creatable-v1-1-87eefeea7f68@avm.de>
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

On Fri, Sep 19, 2025 at 04:30:53PM +0200, Christian Speich wrote:
> This removes the change introduced in [1] that prevents the use of
> vhost-user-device and vhost-user-device-pci on unpatched QEMU builds.
> 
> [1]: 6275989647efb708f126eb4f880e593792301ed4
> 
> Signed-off-by: Christian Speich <c.speich@avm.de>
> ---
> vhost-user-device and vhost-user-device-pci started out as user
> creatable devices. This was changed in [1] when the vhost-user-base was
> introduced.
> 
> The reason given is to prevent user confusion. Searching qemu-discuss or
> google for "vhost-user-device" I've seen no confused users.
> 
> Our use case is to provide wifi emulation using "vhost-user-device-pci",
> which currently is working fine with the QEMU 9.0.2 present in Ubuntu
> 24.04. With newer QEMU versions we now need to patch, distribute and
> maintain our own QEMU packages, which is non-trivial.
> 
> So I want to propose lifting this restriction to make this feature
> usable without a custom QEMU.
> 
> [1]: 6275989647efb708f126eb4f880e593792301ed4

The confusion is after someone reuses the ID you are claiming without
telling anyone and then linux guests will start binding that driver to
your device.


We want people doing this kind of thing to *at a minimum*
go ahead and register a device id with the virtio TC,
but really to write and publish a spec.


> ---
>  docs/system/devices/vhost-user.rst | 10 ----------
>  hw/virtio/vhost-user-device-pci.c  |  3 ---
>  hw/virtio/vhost-user-device.c      |  3 ---
>  3 files changed, 16 deletions(-)
> 
> diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
> index 35259d8ec7c666aa0c56497b8261f48d77216ad5..2d130f9767dbb1cbb85cef43c63dc9a8d7b30d4a 100644
> --- a/docs/system/devices/vhost-user.rst
> +++ b/docs/system/devices/vhost-user.rst
> @@ -73,16 +73,6 @@ all the required parameters including:
>    - The ``num_vqs`` it needs and their ``vq_size``
>    - The ``config_size`` if needed
>  
> -.. note::
> -  To prevent user confusion you cannot currently instantiate
> -  vhost-user-device without first patching out::
> -
> -    /* Reason: stop inexperienced users confusing themselves */
> -    dc->user_creatable = false;
> -
> -  in ``vhost-user-device.c`` and ``vhost-user-device-pci.c`` file and
> -  rebuilding.
> -
>  vhost-user daemon
>  =================
>  
> diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-device-pci.c
> index f10bac874e78429c633752a4ce9db28385b3bb07..c76a856c9b9a67d941a93929244216658ff2a156 100644
> --- a/hw/virtio/vhost-user-device-pci.c
> +++ b/hw/virtio/vhost-user-device-pci.c
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
> diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-device.c
> index 3939bdf755222a281da8ca22243d7d4f16990a66..1bea496afd0137ba9b42009f6252acf6800528d1 100644
> --- a/hw/virtio/vhost-user-device.c
> +++ b/hw/virtio/vhost-user-device.c
> @@ -41,9 +41,6 @@ static void vud_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
> -    /* Reason: stop inexperienced users confusing themselves */
> -    dc->user_creatable = false;
> -
>      device_class_set_props(dc, vud_properties);
>      dc->vmsd = &vud_vmstate;
>      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> 
> ---
> base-commit: e7c1e8043a69c5a8efa39d4f9d111f7c72c076e6
> change-id: 20250919-vhost-user-device-creatable-b7f9b7b5bfb2
> 
> Best regards,
> -- 
> Christian Speich <c.speich@avm.de>


