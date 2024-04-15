Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B262DC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 08:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwHyD-0006cR-KV; Mon, 15 Apr 2024 04:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rwHyA-0006c1-Kd
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 04:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rwHy8-0001ut-EV
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 04:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713170739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdTQCTLd1OKAmeTn6fUWW+7eanONkG3Om71bIHqYcys=;
 b=M0diz4E75ZXbB8/9OkiZMgdld8n9kz5ibfyxX9ItdQJx4UQH5IsIWRt/UhG5D/DvHTpBwx
 WlOYlIqxmuUKzJTjPtUTDTyUm6+dJFfR3muyDss2pXS9/n2F1x7ObPQHoOyZ++0jDhRCCe
 U/wLVkT6aaqYDXFSck9xlg5d8/67Kq4=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-p4tG-mEdMue7ZNqeRIQfIw-1; Mon, 15 Apr 2024 04:45:34 -0400
X-MC-Unique: p4tG-mEdMue7ZNqeRIQfIw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6ee128aa957so2080996b3a.2
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 01:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713170734; x=1713775534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PdTQCTLd1OKAmeTn6fUWW+7eanONkG3Om71bIHqYcys=;
 b=U9578/1pI5OFGBrYCnSrGVKvZcfSmQD3aGSiaQWm9cKyaEmdFg/1IJqr7jUnjWsncA
 DTK5CjMVdEI+7Dt1Ok/YySAC7YHS4RJSJkSosrDGt9+p5FvPctAWbzx5ReqdlJUVkois
 k3L7Z8yKdfhGZA23flU3pC7aY5hrERJB5pyS9mvvHvS3d3JaqnoUK5tEy5kzB8AHqnSU
 EL15CulZFaXBc7JBZuIz2IzV+hFD2iIp/q69qA0gu1DPN4gPlCp2/GW1MHorbOzF2ty2
 GD+MD1sapNt0uKsPnM5mrMwV8p/tvb7Gty9AQBTKZBYLvV3tk6csu4ztHs7wk1aikgpO
 lmyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE8xS4TfcmjqD2TLZS457u2PYz9FR8ycmQWnls+UEGpSU75GWq8QhNw73C3dRaXIke66HZnMZfEU9iH/ShjpOLiUemlr4=
X-Gm-Message-State: AOJu0Ywprez6l7aadFrVCGNh9LhnLd0RxCd8JS0I0t0lk9k/4uxCEtfp
 ou1ZkznMmB1qDSroPvQ+zzTOIX6TroGNqHCZUyBRcF8BP2cshwFAzmQ6r+JfsxLA1+B5OIZGPLv
 pEESa7wIVewzCb9S0oNQK/E7H2W/ScpUhQkxetOxo2fJnjfMsLFANhIjO1gW76+/qkWlQVsyQjs
 BFBNIkGL92L6mZ0Rxo6JnZV3ey4pc=
X-Received: by 2002:a05:6a21:615:b0:1aa:282e:8dcc with SMTP id
 ll21-20020a056a21061500b001aa282e8dccmr517832pzb.59.1713170733862; 
 Mon, 15 Apr 2024 01:45:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+bmciiazboxdFdI/kvdYgs9neLcnoQx0V8Fv/MAuCDrOYTH0f1aCgiDA/+oBfhAekqQsy2jL8LOkfT9XZW/4=
X-Received: by 2002:a05:6a21:615:b0:1aa:282e:8dcc with SMTP id
 ll21-20020a056a21061500b001aa282e8dccmr517817pzb.59.1713170733527; Mon, 15
 Apr 2024 01:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAJaqyWcL7DRSj7bPK=MfAZoTw-GgZCKr4on3U0Q8jmRd2OZSPg@mail.gmail.com>
 <20240414044353-mutt-send-email-mst@kernel.org>
 <CACycT3uXtwQ+TPrBxrz5VcFxYWWQ7vfsYU8nwgstYZ_GhRov_Q@mail.gmail.com>
In-Reply-To: <CACycT3uXtwQ+TPrBxrz5VcFxYWWQ7vfsYU8nwgstYZ_GhRov_Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Apr 2024 16:45:22 +0800
Message-ID: <CACGkMEvvR7k4djutzG0Ypr5fmUVLdBUqgk_8NX09W+1MmHB2=A@mail.gmail.com>
Subject: Re: Discrepancy between mmap call on DPDK/libvduse and rust vm-memory
 crate
To: Yongji Xie <xieyongji@bytedance.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>, 
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, 
 German Maglione <gmaglione@redhat.com>, Hanna Czenczek <hczenczek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.127,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Apr 15, 2024 at 3:28=E2=80=AFPM Yongji Xie <xieyongji@bytedance.com=
> wrote:
>
> On Sun, Apr 14, 2024 at 5:02=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Fri, Apr 12, 2024 at 12:15:40PM +0200, Eugenio Perez Martin wrote:
> > > Hi!
> > >
> > > I'm building a bridge to expose vhost-user devices through VDUSE. The
> > > code is still immature but I'm able to forward packets using
> > > dpdk-l2fwd through VDUSE to VM. I'm now developing exposing virtiofsd=
,
> > > but I've hit an error I'd like to discuss.
> > >
> > > VDUSE devices can get all the memory regions the driver is using by
> > > VDUSE_IOTLB_GET_FD ioctl. It returns a file descriptor with a memory
> > > region associated that can be mapped with mmap, and an information
> > > entry about the map it contains:
> > > * Start and end addresses from the driver POV
> > > * Offset within the mmaped region of these start and end
> > > * Device permissions over that region.
> > >
> > > [start=3D0xc3000][last=3D0xe7fff][offset=3D0xc3000][perm=3D1]
> > >
> > > Now when I try to map it, it is impossible for the userspace device t=
o
> > > call mmap with any offset different than 0.
> >
> > How exactly did you allocate memory? hugetlbfs?
> >
> > > So the "straightforward"
> > > mmap with size =3D entry.last-entry.start and offset =3D entry.offset=
 does
> > > not work. I don't know if this is a limitation of Linux or VDUSE.
> > >
> > > Checking QEMU's
> > > subprojects/libvduse/libvduse.c:vduse_iova_add_region() I see it
> > > handles the offset by adding it up to the size, instead of using it
> > > directly as a parameter in the mmap:
> > >
> > > void *mmap_addr =3D mmap(0, size + offset, prot, MAP_SHARED, fd, 0);
> >
> >
> > CC Xie Yongji who wrote this code, too.
> >
>
> The mmap() with hugetlb would fail if the offset into the file is not
> aligned to the huge page size. So libvhost-user did something like
> this. But I think VDUSE doesn't have this problem.

I think what you meant is that VDUSE IOTLB doesn't have this problem.

Btw, I think we need to understand the setup. E.g is this used for
containers (bounce pages) or VM (hugetlb or other).

Thanks

> So it's fine to
> directly use the offset as a parameter in the mmap(2) here.
>
> Thanks,
> Yongji
>


