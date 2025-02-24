Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF12C021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 08:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmUF8-0001x1-8N; Mon, 24 Feb 2025 03:55:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tmUF4-0001vI-FQ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 03:55:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tmUF2-0007Zq-1J
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 03:55:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740387304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nBllOH8VQKBJvzeiWzNMAVzLMUifYlSd6yj6rxW+MEs=;
 b=czlVgaZ7YeQMKHpw6PWorbhhyrUUOtODwfQycCp3d0bh1Qkq1qZ9AbmyKQFGyZBqYWKmlN
 aIi6ldL2xmsPmRUw9xLaq3dGntTFCOTUgLn2E1wOxllrlR8AXlinlQDiH8a2x/r0dmWYGf
 Y+dLX3to6pvrK32935zOS1+z3xmGzUY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-D55F1Mr1Npq8YEcb8QcC4g-1; Mon, 24 Feb 2025 03:55:02 -0500
X-MC-Unique: D55F1Mr1Npq8YEcb8QcC4g-1
X-Mimecast-MFC-AGG-ID: D55F1Mr1Npq8YEcb8QcC4g_1740387302
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-220d6018858so83874855ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 00:55:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740387302; x=1740992102;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nBllOH8VQKBJvzeiWzNMAVzLMUifYlSd6yj6rxW+MEs=;
 b=j8aaWdtIaueynlgb+PTtGCZceb7D68sVRHXgE2zGoV/lcfCxch1lNp+fIE3hUdP5mW
 DLZUiKI2PYik2gW6Jl6WuHEbT56h5j64t4s3ykOqdRF7JH5N99ZgfoCLW9PgXgFPjpoV
 3ilRAmiS74+0+T/l8lMSQRgc3wsnBANyqHM65+cId1AhEKhLM6Q8yZeR79YhzZ3SQ86g
 kDcry7jG9hiBV+iT5Tjbk6s8VAkgy67BDubR6olEd/Uvd5a7C5vK2FQCgoDRTFrQkNUX
 7e9eHtGWBekX6pnmONkWg0WcjE6knhM5HStUE7NUOUWd2zWVJoc+AJWwd+g635ZKNQez
 UDaw==
X-Gm-Message-State: AOJu0Yz7kubyExZuODcPYdIU9lKhsCd5zOhVLYJPovxHWai67a4Ncavy
 E+dF4kS9crTBWcj0dGNY0+6NW7pKBkgP/zO3/Or9t/rAfP64GBNBSNPoKoCYWVjWb4tp8cncAHy
 FjNhu0XALB/xCODsoS2aqH4o/fItKUCGUYZeA7jaM/sBrUYcTWhHV+/ngxDYhyie6xYwto+EyIH
 Q14ieZl+0F2k/SLxfXWZxQHXoAWqs=
X-Gm-Gg: ASbGncu7cVS97yVJ8kyp+v7YTW/HFhEYtDE1rgj7sBdF8czNGUJ2z+d2IeMt9BbrcWF
 tX7OG6ESgOdQ6Wx0p6swzBQ2lrcsD+d5nB9HTg9hr14KOwx+IX4smqip2UhBUsIN0aMq42hnUXC
 4=
X-Received: by 2002:a17:902:f547:b0:215:8d49:e2a7 with SMTP id
 d9443c01a7336-2219fffb643mr194728975ad.50.1740387301783; 
 Mon, 24 Feb 2025 00:55:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLaWN21WNzxpLHGJ07Nu/TKUQCpuckiye9jvQH9nsp0iFPaIKXugE7w5SxqU34segMBeyjmibIcPQRI5nJ4l8=
X-Received: by 2002:a17:902:f547:b0:215:8d49:e2a7 with SMTP id
 d9443c01a7336-2219fffb643mr194728715ad.50.1740387301416; Mon, 24 Feb 2025
 00:55:01 -0800 (PST)
MIME-Version: 1.0
References: <20250217164012.246727-1-aesteve@redhat.com>
 <aad375d5-8dab-41df-9986-4967ef485a71@redhat.com>
In-Reply-To: <aad375d5-8dab-41df-9986-4967ef485a71@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 24 Feb 2025 09:54:50 +0100
X-Gm-Features: AWEUYZkYtw5iVQQdvOR9CdXx6aMg7mtY9jLZIH8nRmpCJhscDJFf083putmyJVA
Message-ID: <CADSE00+Tq8KVTW3BhLwRiQLQuFmauHRvXh34zP6fvvYFrB_t9g@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] vhost-user: Add SHMEM_MAP/UNMAP requests
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com, stevensd@chromium.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Stefano Garzarella <sgarzare@redhat.com>, stefanha@redhat.com, hi@alyssa.is,
 mst@redhat.com, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Feb 17, 2025 at 9:01=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 17.02.25 17:40, Albert Esteve wrote:
> > Hi all,
> >
>
> Hi,
>
> looks like our debugging session was successfu :)
>
> One question below.
>
> > v3->v4
> > - Change mmap strategy to use RAM blocks
> >    and subregions.
> > - Add new bitfield to qmp feature map
> > - Followed most review comments from
> >    last iteration.
> > - Merged documentation patch again with
> >    this one. Makes more sense to
> >    review them together after all.
> > - Add documentation for MEM_READ/WRITE
> >    messages.
> >
> > The goal of this patch is to support
> > dynamic fd-backed memory maps initiated
> > from vhost-user backends.
> > There are many devices that could already
> > benefit of this feature, e.g.,
> > virtiofs or virtio-gpu.
> >
> > After receiving the SHMEM_MAP/UNMAP request,
> > the frontend creates the RAMBlock form the
> > fd and maps it by adding it as a subregion
> > of the shared memory region container.
> >
> > The VIRTIO Shared Memory Region list is
> > declared in the `VirtIODevice` struct
> > to make it generic.
> >
> > TODO: There was a conversation on the
> > previous version around adding tests
> > to the patch (which I have acknowledged).
> > However, given the numerous changes
> > that the patch already has, I have
> > decided to send it early and collect
> > some feedback while I work on the
> > tests for the next iteration.
> > Given that I have been able to
> > test the implementation with
> > my local setup, I am more or less
> > confident that, at least, the code
> > is in a relatively sane state
> > so that no reviewing time is
> > wasted on broken patches.
> >
> > This patch also includes:
> > - SHMEM_CONFIG frontend request that is
> > specifically meant to allow generic
> > vhost-user-device frontend to be able to
> > query VIRTIO Shared Memory settings from the
> > backend (as this device is generic and agnostic
> > of the actual backend configuration).
> >
> > - MEM_READ/WRITE backend requests are
> > added to deal with a potential issue when having
> > multiple backends sharing a file descriptor.
> > When a backend calls SHMEM_MAP it makes
> > accessing to the region fail for other
> > backend as it is missing from their translation
> > table. So these requests are a fallback
> > for vhost-user memory translation fails.
>
> Can you elaborate what the issue here is?
>
> Why would SHMEM_MAP make accessing the region fail for other backends --
> what makes this missing from their translation?

This issue was raised by Stefan Hajnoczi in one of the first
iterations of this patchset, based upon previous David Gilbert's work
on the virtiofs DAX Window.

Let me paste here some of his remarks:

"""
Other backends don't see these mappings. If the guest submits a vring
descriptor referencing a mapping to another backend, then that backend
won't be able to access this memory.
"""
[...]
"""
A bit more detail:

Device A has a VIRTIO Shared Memory Region. An application mmaps that
memory (examples: guest userspace driver using Linux VFIO, a guest
kernel driver that exposes the memory to userspace via mmap, or guest
kernel DAX). The application passes that memory as an I/O buffer to
device B (e.g. O_DIRECT disk I/O).

The result is that device B's vhost-user backend receives a vring
descriptor that points to a guest memory address in device A's VIRTIO
Shared Memory Region. Since device B does not have this memory in its
table, it cannot translate the address and the device breaks.
"""

I have not triggered the issue myself. So the idea is that the next
patch will *definitively* include some testing for the commits that I
cannot verify with my local setup.

BR,
Albert.

>
> --
> Cheers,
>
> David / dhildenb
>


