Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004B4CAC5A8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 14:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0hg5-0006fi-M0; Mon, 22 Sep 2025 10:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v0hfw-0006ew-Di
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:37:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v0hfs-0000qX-4z
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758551866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I5VnwZq8SLucKddVIJn8RlwJeuvWeozdmjk1NVTdsp8=;
 b=T8VK2IGlvbGqja8fq82tE+ZE/NR6jMZRCeyUtG21nO3aXz2htKiQTXZniqVcCEnQpdM3PV
 1NoNJcZAAP6wk06yHld+0ka75iQjmhrLFbmtX+XBY7X7r3CQ8Twl80aS8ij+Qy5sdeXoIP
 hQ2mLtSAxM2j2D7e25K3EAZA0j1NVFg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-doL8aDXWP-uwGVbd_3evig-1; Mon, 22 Sep 2025 10:37:45 -0400
X-MC-Unique: doL8aDXWP-uwGVbd_3evig-1
X-Mimecast-MFC-AGG-ID: doL8aDXWP-uwGVbd_3evig_1758551864
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ef21d77d2eso3702986f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 07:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758551864; x=1759156664;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I5VnwZq8SLucKddVIJn8RlwJeuvWeozdmjk1NVTdsp8=;
 b=jj+pYLVt9yu1CdKRpZQDQPTyXCdVn6WFl7UFPa+4wMW6OIhsJApfyLbeRY1Cee15TC
 94B5f7aMz0Y68RMwE5PG5P6KDpZFz/6KdljyO6L6SNE/t49lamU4pXVTXgP03drzUEOP
 g9s7JPinFBRXh4v7uATy7zcN5FK2k0h1+BbGQ9l0OdGq6vP9ezPejgasxQhavIsGztWk
 bCeLy0jDqT+IiBHzl2HnJqx6bcl3kVXA7kD0v34e+a9KNrMGHL5KRNPtQD/nykzmwF0p
 YUiIMEmTA7oz/JuZnB8diQ07Ay+xpV59qYOtJw+SvpZxXcI25lQSyyGv4q7YZ+mdLtxE
 Px2Q==
X-Gm-Message-State: AOJu0YyVizAuNi4x26BkcMfLnSmvch/SJvlMGmie3HpJ9S8BoVs0gWvh
 RPTyE3DgmbVdui6l8e3ABZy5DGEQ3lE1FhalchktChLqbzpkVd//v26n66S0LQSyrCFYEOoklq6
 X0jJve5wqPU6DouX3Yd8yf8huyPQZMDkeF7Nqw0jgSX/IowCrCgViC1Qv
X-Gm-Gg: ASbGncthHYZiogjULAh5Y4ftp/EnpzJETC1b0GbX3DwcGXjGMqDUaUPdsJ6Sj/QoLF7
 tNq7oSISR0+qiXNiiL3lyfVqsKOT9Mk+pDaxa2za+C/2PdIhTxKkGVlyUyFtytVYlyh7cb/EFc9
 dnLW34OzPqEMW1Q9ftL6gQr6LLQexZuU1JGMg45YI40DG00VDqTtWlkG63wzL+6HmGEqbHH81Xu
 qQy+N2GxXbnqJ5Gh46Ab8+HH7NQ55ZbO+o/OU8fvfNRrfjkKw8+8UO9WDhXHqVoA4EslSam8W9I
 ZnSPyJiJpdN+5EahUStG8tfqjmrG66pqxqw=
X-Received: by 2002:a05:6000:2209:b0:3ec:e285:546b with SMTP id
 ffacd0b85a97d-3ee8558132dmr10716082f8f.50.1758551863604; 
 Mon, 22 Sep 2025 07:37:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0CsznD0OZh+FlT7aBEW5W34iOW5uE8JMagmcTGR/6V1Ay9n94RcK0CWryXIIjAT/Fagw6mw==
X-Received: by 2002:a05:6000:2209:b0:3ec:e285:546b with SMTP id
 ffacd0b85a97d-3ee8558132dmr10716060f8f.50.1758551863133; 
 Mon, 22 Sep 2025 07:37:43 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f00cc58b91sm14146974f8f.1.2025.09.22.07.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 07:37:42 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:37:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christian Speich <c.speich@avm.de>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] virtio: vhost-user-device: Make user creatable again
Message-ID: <20250922103658-mutt-send-email-mst@kernel.org>
References: <20250919-vhost-user-device-creatable-v1-1-87eefeea7f68@avm.de>
 <20250919160526-mutt-send-email-mst@kernel.org>
 <32x5pe3iz6v2vu5imktyxwajk4vdhamhc7yhfmtzuylcvdkunl@wvdfyo23zueh>
 <20250922065614-mutt-send-email-mst@kernel.org>
 <4yg4y2miiso6c4c6qtlowji6ak3kid5g66ncen4uljsone67ta@c6s22jbk4ckz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4yg4y2miiso6c4c6qtlowji6ak3kid5g66ncen4uljsone67ta@c6s22jbk4ckz>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On Mon, Sep 22, 2025 at 01:11:33PM +0200, Christian Speich wrote:
> On Mon, Sep 22, 2025 at 06:56:31AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Sep 22, 2025 at 12:40:33PM +0200, Christian Speich wrote:
> > > On Fri, Sep 19, 2025 at 04:07:19PM -0400, Michael S. Tsirkin wrote:
> > > > On Fri, Sep 19, 2025 at 04:30:53PM +0200, Christian Speich wrote:
> > > > > This removes the change introduced in [1] that prevents the use of
> > > > > vhost-user-device and vhost-user-device-pci on unpatched QEMU builds.
> > > > > 
> > > > > [1]: 6275989647efb708f126eb4f880e593792301ed4
> > > > > 
> > > > > Signed-off-by: Christian Speich <c.speich@avm.de>
> > > > > ---
> > > > > vhost-user-device and vhost-user-device-pci started out as user
> > > > > creatable devices. This was changed in [1] when the vhost-user-base was
> > > > > introduced.
> > > > > 
> > > > > The reason given is to prevent user confusion. Searching qemu-discuss or
> > > > > google for "vhost-user-device" I've seen no confused users.
> > > > > 
> > > > > Our use case is to provide wifi emulation using "vhost-user-device-pci",
> > > > > which currently is working fine with the QEMU 9.0.2 present in Ubuntu
> > > > > 24.04. With newer QEMU versions we now need to patch, distribute and
> > > > > maintain our own QEMU packages, which is non-trivial.
> > > > > 
> > > > > So I want to propose lifting this restriction to make this feature
> > > > > usable without a custom QEMU.
> > > > > 
> > > > > [1]: 6275989647efb708f126eb4f880e593792301ed4
> > > > 
> > > > The confusion is after someone reuses the ID you are claiming without
> > > > telling anyone and then linux guests will start binding that driver to
> > > > your device.
> > > 
> > > Thanks for clarifciation, In our use-case we use mac80211_hwsim which is
> > > in linux upstream (with the ID 29). So I think a potential reuse here
> > > is something that linux upstream already deals with.
> > 
> > So just allow that one?
> 
> That would solve our problem.
> 
> However, I'm finding it somwhat odd to artifically force the user only use
> QEMU it the "allowed way". I'd much rather see that virtio-user-device is
> usuable as is (and mac80211_hwsim is not a special case and just works).
> 
> Regards,
> Christian

We can combine both. Want to try?


> > 
> > > > 
> > > > 
> > > > We want people doing this kind of thing to *at a minimum*
> > > > go ahead and register a device id with the virtio TC,
> > > > but really to write and publish a spec.
> > > 
> > > I understand this desire, I'm not sure how this relates with the ability
> > > to let a user create a vhost-user-device or not.
> > > 
> > > Kind Regards,
> > > Christian
> > > 
> > > > 
> > > > 
> > > > > ---
> > > > >  docs/system/devices/vhost-user.rst | 10 ----------
> > > > >  hw/virtio/vhost-user-device-pci.c  |  3 ---
> > > > >  hw/virtio/vhost-user-device.c      |  3 ---
> > > > >  3 files changed, 16 deletions(-)
> > > > > 
> > > > > diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
> > > > > index 35259d8ec7c666aa0c56497b8261f48d77216ad5..2d130f9767dbb1cbb85cef43c63dc9a8d7b30d4a 100644
> > > > > --- a/docs/system/devices/vhost-user.rst
> > > > > +++ b/docs/system/devices/vhost-user.rst
> > > > > @@ -73,16 +73,6 @@ all the required parameters including:
> > > > >    - The ``num_vqs`` it needs and their ``vq_size``
> > > > >    - The ``config_size`` if needed
> > > > >  
> > > > > -.. note::
> > > > > -  To prevent user confusion you cannot currently instantiate
> > > > > -  vhost-user-device without first patching out::
> > > > > -
> > > > > -    /* Reason: stop inexperienced users confusing themselves */
> > > > > -    dc->user_creatable = false;
> > > > > -
> > > > > -  in ``vhost-user-device.c`` and ``vhost-user-device-pci.c`` file and
> > > > > -  rebuilding.
> > > > > -
> > > > >  vhost-user daemon
> > > > >  =================
> > > > >  
> > > > > diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-device-pci.c
> > > > > index f10bac874e78429c633752a4ce9db28385b3bb07..c76a856c9b9a67d941a93929244216658ff2a156 100644
> > > > > --- a/hw/virtio/vhost-user-device-pci.c
> > > > > +++ b/hw/virtio/vhost-user-device-pci.c
> > > > > @@ -38,9 +38,6 @@ static void vhost_user_device_pci_class_init(ObjectClass *klass,
> > > > >      VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
> > > > >      PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
> > > > >  
> > > > > -    /* Reason: stop users confusing themselves */
> > > > > -    dc->user_creatable = false;
> > > > > -
> > > > >      k->realize = vhost_user_device_pci_realize;
> > > > >      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> > > > >      pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
> > > > > diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-device.c
> > > > > index 3939bdf755222a281da8ca22243d7d4f16990a66..1bea496afd0137ba9b42009f6252acf6800528d1 100644
> > > > > --- a/hw/virtio/vhost-user-device.c
> > > > > +++ b/hw/virtio/vhost-user-device.c
> > > > > @@ -41,9 +41,6 @@ static void vud_class_init(ObjectClass *klass, const void *data)
> > > > >  {
> > > > >      DeviceClass *dc = DEVICE_CLASS(klass);
> > > > >  
> > > > > -    /* Reason: stop inexperienced users confusing themselves */
> > > > > -    dc->user_creatable = false;
> > > > > -
> > > > >      device_class_set_props(dc, vud_properties);
> > > > >      dc->vmsd = &vud_vmstate;
> > > > >      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> > > > > 
> > > > > ---
> > > > > base-commit: e7c1e8043a69c5a8efa39d4f9d111f7c72c076e6
> > > > > change-id: 20250919-vhost-user-device-creatable-b7f9b7b5bfb2
> > > > > 
> > > > > Best regards,
> > > > > -- 
> > > > > Christian Speich <c.speich@avm.de>
> > > > 
> > > > 
> > 
> > 


