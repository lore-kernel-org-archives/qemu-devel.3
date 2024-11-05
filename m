Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD22D12672
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 09:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8FzW-0002Kz-3K; Tue, 05 Nov 2024 04:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t8FzV-0002Kq-2i
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 04:36:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t8FzS-0005VR-Cw
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 04:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730799403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=826wfRf0fGXQIuaE6MUbmYoSpGGnd7MAEOwmMM4tm20=;
 b=dful5sdjoOcIQ9rr+zPWHzaUI9e0ERLEUgBP8KpZ5C3nF2TpOHbbBAXwV+9eXI8Bm+x1bN
 7QMJxD/Aagm0zLx38eOAlyyE3czbZR5RVgVuIzGf99umjPi2Z4if7bdA5/Z2hq8BX5r2Tr
 w+76AlPskUEwO8kwhStUK4TF5wGvXpU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-Wbsii0y3NcS_LeXxxSg6Aw-1; Tue, 05 Nov 2024 04:36:40 -0500
X-MC-Unique: Wbsii0y3NcS_LeXxxSg6Aw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6cbf039dccfso92124836d6.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 01:36:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730799400; x=1731404200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=826wfRf0fGXQIuaE6MUbmYoSpGGnd7MAEOwmMM4tm20=;
 b=CI92PErPGybDGbd5UNfqisI3ty9mlNP32sQSCSyfBsO9A9o2KDetB2cSNXzYFshwNX
 rXpLpUVm8/o+bykCt2g79wJY3zsUmi5c8eiCOe4sW0NADXnlOjvIpPMfWtKNJlH8Nlsx
 ZOTWlmcjzpAqHBCvBYieugSwAM0IYHh+Tp025r8ft8pLfz+HlTD6a1+9AuUjeiXjqnkq
 fn9neliveMMQHp0FjIEC45gtb7PsLcpSQY5D7Q2UOC3PICmnBaGXchkNJuGxUcbcccB9
 pk0pX6shfQVqSASXktEao/UzZ4N2B9lFXVGGQbMSkyMVCKfr2ztQr6CrziqACXFD6ePR
 MYdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYFUWxtNMNfI2VujmqWC3zlXeiS6utHRbF9A2RuAVSXI94G2Ye+z4NZO4lw03siCj9gQJHphkC3fVX@nongnu.org
X-Gm-Message-State: AOJu0YygHEIALuT3NllIO38/iRFofblONMPDCimTlYvOnt4SneJNgj/q
 Nm9LicnZBVhwAzB/9XoUDuGYJ0a4ojhTp1/UPyGm6K5of66c8Fy3ksaNNq6LSEI7B+RBdxUfcO3
 g1vZFWdU6i/aGH4m2Uix1sF43HOy5ABHFJt/4+bg5SuQjXap1xmx6
X-Received: by 2002:a05:6214:3bc7:b0:6d3:710c:bc16 with SMTP id
 6a1803df08f44-6d3710cbcd9mr126475006d6.15.1730799399724; 
 Tue, 05 Nov 2024 01:36:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQxdllkkwmZ8rBgKAAxJaRWfC4SHMoPmtyBJ+qu/20ggocPATDw3K7Cbvg0BHnDYc7oPnEjg==
X-Received: by 2002:a05:6214:3bc7:b0:6d3:710c:bc16 with SMTP id
 6a1803df08f44-6d3710cbcd9mr126474836d6.15.1730799399301; 
 Tue, 05 Nov 2024 01:36:39 -0800 (PST)
Received: from sgarzare-redhat ([134.0.5.207])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9e7adsm58043296d6.2.2024.11.05.01.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 01:36:38 -0800 (PST)
Date: Tue, 5 Nov 2024 10:36:32 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: eperezma@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [PATCH] vdpa: Support setting vring_base for packed svq
Message-ID: <k2suxbt2qy7ewjrlozlkzrhsa7bbf7xrze33outna65dejuus2@eamj5pdkvpkw>
References: <20241104162124.49867-1-sahilcdq@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241104162124.49867-1-sahilcdq@proton.me>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 04, 2024 at 09:51:24PM +0530, Sahil Siddiq wrote:
>Linux commit v5.14-rc1~30^2~8 enabled the vp_vdpa driver to set the

To refer to a commit, please use the SHA-1 id or even better the form
suggested in
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

So in this case I'd use:
Linux commit 1225c216d954 ("vp_vdpa: allow set vq state to initial state
after reset")

>vq state to the device's initial state. This works differently for
>split and packed vqs.
>
>With shadow virtqueues enabled, vhost-vdpa sets the vring base using
>the VHOST_SET_VRING_BASE ioctl. The payload (vhost_vring_state)
>differs for split and packed vqs. The implementation in QEMU currently
>uses the payload required for split vqs (i.e., the num field of
>vhost_vring_state is set to 0). The kernel throws EOPNOTSUPP when this
>payload is used with packed vqs.
>
>This patch sets the num field in the payload appropriately so vhost-vdpa

I'm not very familiar with shadow virtqueue, so can you elaborate what
"appropriately" means here?

>(with the vp_vdpa driver) can use packed svqs.
>
>Link: https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg05106.html
>Link: https://lore.kernel.org/r/20210602021536.39525-4-jasowang@redhat.com
>Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
>---
>QEMU currently does not support packed vhost shadow virtqueues. I am
>working on adding support for packed svqs [1]. The test environment
>that I am using [2] requires vhost-vdpa to use the relevant payload
>when setting vring base.
>
>[1] https://wiki.qemu.org/Internships/ProjectIdeas/PackedShadowVirtqueue
>[2] https://www.redhat.com/en/blog/hands-vdpa-what-do-you-do-when-you-aint-got-hardware-part-2
>
> hw/virtio/vhost-vdpa.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>index 3cdaa12ed5..5f81945109 100644
>--- a/hw/virtio/vhost-vdpa.c
>+++ b/hw/virtio/vhost-vdpa.c
>@@ -1230,6 +1230,10 @@ static bool vhost_vdpa_svq_setup(struct vhost_dev *dev,
>     };
>     int r;
>
>+    if (virtio_vdev_has_feature(dev->vdev, VIRTIO_F_RING_PACKED)) {
>+        s.num = 0x80008000;

Why this magic value?

Looking at the kernel code it looks like we are assgining 0x8000 for
both last_avail_idx and last_used_idx, but why 0x8000?

Thanks,
Stefano

>+    }
>+
>     r = vhost_vdpa_set_dev_vring_base(dev, &s);
>     if (unlikely(r)) {
>         error_setg_errno(errp, -r, "Cannot set vring base");
>-- 
>2.47.0
>


