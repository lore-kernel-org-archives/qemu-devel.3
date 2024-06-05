Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44848C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 15:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEsRD-00053d-M3; Wed, 05 Jun 2024 11:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sEsRA-00052q-DD
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 11:20:28 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1sEsR6-0005Nz-Gr
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 11:20:27 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2eaccc0979eso385301fa.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 08:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717600821; x=1718205621; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgufYDfr2vSd1Um9j1aWhMIkNPmsx68QKSVorSRWLCU=;
 b=CgpkRkcGHqL3T7B7a2I38qGAYc9QfR40F4xyKqwYjCeJpaoPZxoqCcS3twnV1qI7HZ
 UmXvteT9DzK7ZcNPs+oBb6JfeEeN/yHzAnE4lG/Y/z706fQpIfle4fOfBgGUbXZk+oOm
 YSaOmMpNo8YZY3+HWGgllpcI+aaSx9ACx2zNdcYbIQld584maC5UoZdBPRcx+vwwzz1e
 51yr+feoyEOo5Hh4eOuJOeunRp+VJASzeizaEoieVDA3D6MdtodGzTMZmWyWv5mHsLmr
 bWjZGgQ4Q7g5Ky8nQqlAdcy+4KWtZvAsUMzsVNs0nniZkWFyhRVqYZMinOVXLQZQq+z5
 c1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717600821; x=1718205621;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pgufYDfr2vSd1Um9j1aWhMIkNPmsx68QKSVorSRWLCU=;
 b=PfomMe0p/HlqKzr9V7vQo9EmYdcwOgY4Otq9qyAwwNXGrTDEBY5TGQrJ77P7iWLHla
 YsCKOPcmiG3ndXCgrCZOSfBCNcS7vBpWlV+xsNzRLOHEwJv5X5/NFuK6LECsfEQB9gT1
 rZdCxKs/iFMWBRAFarBIABT7Dmi+3pxpGmeBmjB1qF34DqfIjdsMxYPDKIm6oJiwvU38
 B5HFvA7/Uj6kqwte7BYqiNbaAnl/zxosfW3ln99mpiEJWoe7j3geZ7vfwPvZNFu0RVCc
 CW8qxaTSwlAmTSooXSbeAQYQ2aCQJAOZDUmyIYuWn7xaSViMsKyTl1Byl7+6nn/7/nHt
 IRKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtrzwjYTfQZPWZUNdSdP1Sk20mjseuumiOyM5CBjr2PR/ewepeoJaF4tw1AJ2D2CHQxHf9lmerQPWcStSWOaKBhNOE+2I=
X-Gm-Message-State: AOJu0Yx2/+B8CiVaBaA7ozm+50soWQATyUhHObrZijE/mwfYRBprAk75
 svV0REv4FyyV8k5JGQFxFxUA+7oehAAiMICpGUbegycAvRnwmRQdRDY/4U6JaKHoHtRNlusyi1K
 JqYOGl9/NGCaNhRFdN5vz5GyWhC4=
X-Google-Smtp-Source: AGHT+IGE6GYNMmXUQBguSUuW7NXW16cLFfTY4JjF3bHBZXlJ8225AvsS2VRsp+QiTLN0SdszmIoQLHSe1iF+u9afPoM=
X-Received: by 2002:a2e:86c6:0:b0:2ea:7def:46d0 with SMTP id
 38308e7fff4ca-2eac79ba55cmr16318091fa.9.1717600821125; Wed, 05 Jun 2024
 08:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240530152223.780232-1-aesteve@redhat.com>
 <20240530152223.780232-2-aesteve@redhat.com>
 <20240604185416.GB90471@fedora.redhat.com>
 <CADSE00+yvsOhiJJg0ePgr7AYVCkjm9xWNj7KpAOFMwj2wuEpGg@mail.gmail.com>
 <20240605142849.GC135899@fedora.redhat.com>
In-Reply-To: <20240605142849.GC135899@fedora.redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 5 Jun 2024 11:19:57 -0400
Message-ID: <CAJSP0QUL8VNsYB-D1gaBoE0nrXAQozELU4fwNqoFy5FC9OiEng@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] vhost-user: add shmem mmap request
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com, 
 slp@redhat.com, jasowang@redhat.com, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=stefanha@gmail.com; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 5 Jun 2024 at 10:29, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Wed, Jun 05, 2024 at 10:13:32AM +0200, Albert Esteve wrote:
> > On Tue, Jun 4, 2024 at 8:54=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat=
.com> wrote:
> >
> > > On Thu, May 30, 2024 at 05:22:23PM +0200, Albert Esteve wrote:
> > > > Add SHMEM_MAP/UNMAP requests to vhost-user.
> > > >
> > > > This request allows backends to dynamically map
> > > > fds into a shared memory region indentified by
> > >
> > > Please call this "VIRTIO Shared Memory Region" everywhere (code,
> > > vhost-user spec, commit description, etc) so it's clear that this is =
not
> > > about vhost-user shared memory tables/regions.
> > >
> > > > its `shmid`. Then, the fd memory is advertised
> > > > to the frontend through a BAR+offset, so it can
> > > > be read by the driver while its valid.
> > >
> > > Why is a PCI BAR mentioned here? vhost-user does not know about the
> > > VIRTIO Transport (e.g. PCI) being used. It's the frontend's job to
> > > report VIRTIO Shared Memory Regions to the driver.
> > >
> > >
> > I will remove PCI BAR, as it is true that it depends on the
> > transport. I was trying to explain that the driver
> > will use the shm_base + shm_offset to access
> > the mapped memory.
> >
> >
> > > >
> > > > Then, the backend can munmap the memory range
> > > > in a given shared memory region (again, identified
> > > > by its `shmid`), to free it. After this, the
> > > > region becomes private and shall not be accessed
> > > > by the frontend anymore.
> > >
> > > What does "private" mean?
> > >
> > > The frontend must mmap PROT_NONE to reserve the virtual memory space
> > > when no fd is mapped in the VIRTIO Shared Memory Region. Otherwise an
> > > unrelated mmap(NULL, ...) might use that address range and the guest
> > > would have access to the host memory! This is a security issue and ne=
eds
> > > to be mentioned explicitly in the spec.
> > >
> >
> > I mentioned private because it changes the mapping from MAP_SHARED
> > to MAP_PRIVATE. I will highlight PROT_NONE instead.
>
> I see. Then "MAP_PRIVATE" would be clearer. I wasn't sure whether you
> mean mmap flags or something like the memory range is no longer
> accessible to the driver.

One more thing: please check whether kvm.ko memory regions need to be
modified or split to match the SHMEM_MAP mapping's read/write
permissions.

The VIRTIO Shared Memory Area pages can have PROT_READ, PROT_WRITE,
PROT_READ|PROT_WRITE, or PROT_NONE.

kvm.ko memory regions are read/write or read-only. I'm not sure what
happens when the guest accesses a kvm.ko memory region containing
mappings with permissions more restrictive than its kvm.ko memory
region. In other words, the kvm.ko memory region would allow the
access but the Linux virtual memory configuration would cause a page
fault.

For example, imagine a QEMU MemoryRegion containing a SHMEM_MAP
mapping with PROT_READ. The kvm.ko memory region would be read/write
(unless extra steps were taken to tell kvm.ko about the permissions).
When the guest stores to the PROT_READ page, kvm.ko will process a
fault...and I'm not sure what happens next.

A similar scenario occurs when a PROT_NONE mapping exists within a
kvm.ko memory region. I don't remember how kvm.ko behaves when the
guest tries to access the pages.

It's worth figuring this out before going further because it could
become tricky if issues are discovered later. I have CCed David
Hildenbrand in case he knows.

Stefan

