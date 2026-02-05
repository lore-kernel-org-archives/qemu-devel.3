Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E228AE91291
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 08:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnus0-0001K9-Bb; Thu, 05 Feb 2026 03:37:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnury-0001K0-Nj
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 03:37:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnurx-0008L3-1K
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 03:37:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770280664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QtbOTp4fw5iTZGnr+ENb+HeuHFMFoudJx8p1uTPFkQ0=;
 b=HFGZ1XnXe7fRHT8HYhj2vGSsy3uXaSbfnbuXCiOSOQzyiayzE+ep1AbK5hjmOZahES05L4
 I4uvxGMd44GcOGOTcEkQqAyp7pCh3WNEtrwcenAODvMsdt4++ERFSKx8wdFzPgc+Z9Tm9r
 z23fp/abLagsdl4p+yPf6+LqAjbRZF8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-lh_VtAgtNm2bD7hvyXGUJA-1; Thu, 05 Feb 2026 03:37:42 -0500
X-MC-Unique: lh_VtAgtNm2bD7hvyXGUJA-1
X-Mimecast-MFC-AGG-ID: lh_VtAgtNm2bD7hvyXGUJA_1770280661
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4831192e66aso6903885e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 00:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770280661; x=1770885461; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QtbOTp4fw5iTZGnr+ENb+HeuHFMFoudJx8p1uTPFkQ0=;
 b=ZDhU7C5YM0Y+8j/lQknCNLVLGsDtReJLdcq7ZrnJK40qHe2c6OZrgbEhlPp8Y89Uy5
 gf0wsURwYC9nVHWfQqCMoQkT4pzcHV5tmhcNdSzAsDXVccmfcf8TDjfws7X/x+b40jHL
 iZ9n5Y3wxScBWRww/jt6DzVZNS3bjqjBX7O/ZOTFhb+WOQXXtQeRgTjjwNpCvxj2Gjmq
 WncB5UhYoXDfkM+SPS99+io4ak0siv602p/zPwLz+kAxiYAoLT3liK0FIGfQPzEodviK
 YbFlIlpdDH8onyGMTAyDTy5OZRGS9BUbLY4cyv4YONuPlrVL/56XwlVOmO3OK18tGzQG
 RBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770280661; x=1770885461;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QtbOTp4fw5iTZGnr+ENb+HeuHFMFoudJx8p1uTPFkQ0=;
 b=OCytbt1SLq81TUctRYCZVDeuZ2BfYu3sDZtM4qM4zzFsf4uXeC7hP7gVDxbJwr5mZk
 ifSKY2XzW5EFKCPgPts7OiH9UYI6X5m4ASnshChjllUPtAmxrDMBFntE6xMJY+2QZj+u
 Aj4xdoi+PP5hGzQFGqcuznA4gDETcly+i8SFqfejyRAPIJlbpd0Y14biO7WuVcCIT/h8
 Hsxb97qw2Y1tY+j4G2ZMpKg/KaMgZ7KTsBR7iOiFjGFXLuspzubAn+ttTmXa/KmwjZGN
 7mvKy8QTQ1Rf2CyirM1glF0OIDhP0yWDBwlH+n1L0mRu2Ehgzo93Bx/FJhFCdjEq3wMq
 zz9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVymIgWXn701z9DMc6l1CsTZPopBG+16q1emRYOXxr/3dNwl7pcc0woxwWI9c+OnHMZLzQ4BKV74uEK@nongnu.org
X-Gm-Message-State: AOJu0YwHwrEzUMe9wtD8Ttrqx8BTI7WaV9X70SyiLsJJU/RB1Ni7TsVG
 /aMVydhFt+YociFjth7CozgJnodhUoRBqsiiXzpBsTzgizQj0rdinKecQ4TN2MlhealKsW631Bx
 0MIhRDDRFxL0JgQU1UJvM7Vq/jvRxNrt0tyPVek5DDLOHFxX2BRLeb3J9
X-Gm-Gg: AZuq6aILImB8vcxDcdTKCWRvsBnY85d1DtvTc6W2TXpVpcKg2TN7zyzPUTZ8eXCFOoE
 kBHRP2rknfTJXhOldPDmTtmGDpIiJcKuuIRoVcW/jfd4i+w6TG5yJQy6AEb4BR9brEDUkhyXwXS
 +HEyUzpC6NeAx9xmtpkvpe9rlVqSWMJgq2gDVixoQGsw9FOL68sFDen5QcLP++mZ1mtNsDMVeOp
 NubhpEOCxVRWt1fGxf5zFaRzpTcbbLaSPxcz9Gp0PLgNiKGce/Bobb5y8rHxExzDgj1ClWJm9f1
 CqZRDpBisOyKeWKPavFP5Njo4OswuEFR8/Hmn7yumGjP7FuibwWJWnWM3QyZKRtzu235m1/h11d
 x5ZLZCRTCZ3WI8p/iPY66FytGUiUVEHmVDg==
X-Received: by 2002:a05:600c:8712:b0:480:4be7:4f53 with SMTP id
 5b1f17b1804b1-4830e99333amr95744555e9.31.1770280660623; 
 Thu, 05 Feb 2026 00:37:40 -0800 (PST)
X-Received: by 2002:a05:600c:8712:b0:480:4be7:4f53 with SMTP id
 5b1f17b1804b1-4830e99333amr95744205e9.31.1770280660165; 
 Thu, 05 Feb 2026 00:37:40 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d20319sm67377285e9.2.2026.02.05.00.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 00:37:39 -0800 (PST)
Date: Thu, 5 Feb 2026 03:37:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, d-tatianin@yandex-team.ru
Subject: Re: [PATCH] vhost-user: pass GPA instead of UVA
Message-ID: <20260205033629-mutt-send-email-mst@kernel.org>
References: <20260204092339.211650-1-vsementsov@yandex-team.ru>
 <20260205031227-mutt-send-email-mst@kernel.org>
 <23c05b17-f993-48fd-bf41-06d358fd74d9@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23c05b17-f993-48fd-bf41-06d358fd74d9@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 05, 2026 at 11:22:26AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 05.02.26 11:13, Michael S. Tsirkin wrote:
> > On Wed, Feb 04, 2026 at 12:23:39PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > Unlike the kernel, vhost-user backend knows nothing about QEMUs
> > > userspace addresses. We can pass GPA instead and nothing changes.
> > > 
> > > The benefit: open the doors for further implementation of local
> > > migration (live-update) with passing open vhost-releated FDs
> > > through UNIX domain socket. This way the connection with backend
> > > kept live and untouched.
> > > 
> > > Without this change, we'll have to communicate with backend to
> > > inform it about UVA addresses change, but better is simply use
> > > more stable GPA numbers, like it's done for VDPA.
> > > 
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > ---
> > >   hw/virtio/vhost-user.c | 30 ++++++++++++++++++++++++++++++
> > >   1 file changed, 30 insertions(+)
> > > 
> > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > index 63fa9a1b4b..f379408c95 100644
> > > --- a/hw/virtio/vhost-user.c
> > > +++ b/hw/virtio/vhost-user.c
> > > @@ -386,6 +386,24 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
> > >       CharFrontend *chr = u->user->chr;
> > >       int ret, size = VHOST_USER_HDR_SIZE + msg->hdr.size;
> > > +    if (msg->hdr.request == VHOST_USER_REM_MEM_REG ||
> > > +        msg->hdr.request == VHOST_USER_ADD_MEM_REG) {
> > > +
> > > +        /*
> > > +         * In QEMU we pass guest physical addresses to vhost-user server
> > > +         * instead of QEMUs virtual address. Server have no option to
> > > +         * distinguesh,
> > 
> > what does this mean? "Servers don't really care"?
> 
> Yes. Still, we can't be sure, what servers care about. But I think, as
> they don't have any access to QEMUs virtual address space, they can't
> have any logic that breaks if we start to pass GPA instead of UVA
> (imagine, that "accidentally" GPA and UVA are the same for the case).

right, just write something understandable pls.

> > 
> > > but we get a benefit: guest physical address is
> > > +         * stable during migration, and we don't have to reset memory
> > > +         * regions.
> > 
> > curious if PA 0 is valid on some systems (as opposed to VA).
> 
> Hmm, you are right, that's visible thing which differs for UVA and GPA.
> Still, checking UVA to be non-zero on server side seems rather strange,
> as the only use for these UVA addresses in the server is to calculate
> offsets. The server is only interested in offsets inside given memory
> region, not absolute UVA values.
> 
> And we don't write in spec that UVA can't be zero, and we already use
> GPA for VDPA.

poking at some servers to make sure can't hurt.

> > 
> > 
> > > +         *
> > > +         * Look also at vhost_user_vq_get_addr(): like in VDPA, we pass
> > > +         * physical addresses instead of user.
> > > +         */
> > > +
> > > +        msg->payload.mem_reg.region.userspace_addr =
> > > +            msg->payload.mem_reg.region.guest_phys_addr;
> > > +    }
> > > +
> > >       /*
> > >        * Some devices, like virtio-scsi, are implemented as a single vhost_dev,
> > >        * while others, like virtio-net, contain multiple vhost_devs. For
> > > @@ -3021,6 +3039,17 @@ static int vhost_user_check_device_state(struct vhost_dev *dev, Error **errp)
> > >       return 0;
> > >   }
> > > +static int vhost_user_vq_get_addr(struct vhost_dev *dev,
> > > +                                  struct vhost_vring_addr *addr,
> > > +                                  struct vhost_virtqueue *vq)
> > > +{
> > > +    assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
> > > +    addr->desc_user_addr = (uint64_t)(unsigned long)vq->desc_phys;
> > > +    addr->avail_user_addr = (uint64_t)(unsigned long)vq->avail_phys;
> > > +    addr->used_user_addr = (uint64_t)(unsigned long)vq->used_phys;
> > > +    return 0;
> > > +}
> > > +
> > >   const VhostOps user_ops = {
> > >           .backend_type = VHOST_BACKEND_TYPE_USER,
> > >           .vhost_backend_init = vhost_user_backend_init,
> > > @@ -3059,4 +3088,5 @@ const VhostOps user_ops = {
> > >           .vhost_supports_device_state = vhost_user_supports_device_state,
> > >           .vhost_set_device_state_fd = vhost_user_set_device_state_fd,
> > >           .vhost_check_device_state = vhost_user_check_device_state,
> > > +        .vhost_vq_get_addr = vhost_user_vq_get_addr,
> > >   };
> > > -- 
> > > 2.52.0
> > 
> 
> 
> -- 
> Best regards,
> Vladimir


