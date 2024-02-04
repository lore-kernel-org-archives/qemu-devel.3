Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A4BC4828D
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 02:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWRyn-0002wp-DY; Sat, 03 Feb 2024 21:11:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRyl-0002v0-2v
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 21:11:31 -0500
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRyj-00030W-BQ
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 21:11:30 -0500
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7bed9c7d33fso139065839f.1
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 18:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707012687; x=1707617487; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K6/OJ0BmV9AQkv/EMTPArO/FCB16kWm0ZurC66fQMZ4=;
 b=Ylqjd2+X2zsYjolhQQIxczGPYQH/liQi9BDkX9qOJnSFlAloKejHjhtcZZNZcIt+Ie
 SWMHcQGX/QuaGRiSCpmtAGCuILyzHXkNChTBrPoQbRQCsViqPCyWnIep9UOywSTn5niW
 78Nlooy1RICGmsLoBgmBRs+OhxCZWsR4fBQLialUA6SoZ9h1ob1I9gAgOn3tErqu7uKt
 JMk+3eBfmgAbl3FF/GV89MSK+V+3PwwtE4qAUNM24Nw4XTH6pP+nvnYBh5p6hZumRHBz
 e6XOV4tClyImQ9JLl6BDtzzy/zmgK79GVxonORswME8KwWTZpWJQLS0Uh5uMc6qIk3f9
 eWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707012687; x=1707617487;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K6/OJ0BmV9AQkv/EMTPArO/FCB16kWm0ZurC66fQMZ4=;
 b=hFvAwDWDbuO56FxEwU/rb24lSarksSI8XxvZfpZjbvNMF9IYeB1j3niQoqhUqRfmLw
 B9ppDP4UBO8ALJkC2tZKAXHtcK31Lnt/SZd3u8n22Fs4EpFDFjeA9Mg8xFt+4b9XM9Qu
 sJZsmVNElvyeGC4dyrQI2UzYVHZmGe4rSxCzG+272au2KmO98PDOIxbUVdJe4Kj8DHkC
 p1WMnS/645q7kLntTa+dmH4vsa1AbuevDG8SFQ61H3lnkERU1TV5R/yMDi5HvI8hlztE
 NI6y6v3GJ/FzNbLmlZdDhDsJaSxqRVxHvcvmAXkHxL1Zrr9AnJoeKpKvh30WqWtNG5VD
 XIHA==
X-Gm-Message-State: AOJu0YxzudmHQvq7VrXXBJnKvtbiie8//c8+snM6x9TbN0eZAsFUAkZH
 tAToyFz133bMUeJOmTPMVRrXzTZTT4nslKrJhSyLaCdKMSA8m7ar/gmrFR+EZA34mPecbb5Pk6C
 k4rzAyAYsSheNd8SP+wgobnuRn6k=
X-Google-Smtp-Source: AGHT+IGic839K5Y9Qes0QRKBs+HfM9UkFTRr1O2lY9yDId0Z6B1bd+CCZZIR5XxQoVQvoy4ZcZyMb7NEiRlutyDl9BQ=
X-Received: by 2002:a5e:c116:0:b0:7c0:a13:b212 with SMTP id
 v22-20020a5ec116000000b007c00a13b212mr6839862iol.14.1707012686943; Sat, 03
 Feb 2024 18:11:26 -0800 (PST)
MIME-Version: 1.0
References: <20240202215332.118728-1-david@redhat.com>
 <20240202215332.118728-13-david@redhat.com>
In-Reply-To: <20240202215332.118728-13-david@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sat, 3 Feb 2024 21:11:16 -0500
Message-ID: <CAFubqFv7WghNtxX+oTEpoPyAc529rPusQ7xatAwQ_1cq=LALnA@mail.gmail.com>
Subject: Re: [PATCH v1 12/15] libvhost-user: Use most of mmap_offset as
 fd_offset
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2e;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd2e.google.com
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

On Fri, Feb 2, 2024 at 4:55=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> In the past, QEMU would create memory regions that could partially cover
> hugetlb pages, making mmap() fail if we would use the mmap_offset as an
> fd_offset. For that reason, we never used the mmap_offset as an offset in=
to
> the fd and instead always mapped the fd from the very start.
>
> However, that can easily result in us mmap'ing a lot of unnecessary
> parts of an fd, possibly repeatedly.
>
> QEMU nowadays does not create memory regions that partially cover huge
> pages -- it never really worked with postcopy. QEMU handles merging of
> regions that partially cover huge pages (due to holes in boot memory) sin=
ce
> 2018 in c1ece84e7c93 ("vhost: Huge page align and merge").
>
> Let's be a bit careful and not unconditionally convert the
> mmap_offset into an fd_offset. Instead, let's simply detect the hugetlb
> size and pass as much as we can as fd_offset, making sure that we call
> mmap() with a properly aligned offset.
>
> With QEMU and a virtio-mem device that is fully plugged (50GiB using 50
> memslots) the qemu-storage daemon process consumes in the VA space
> 1281GiB before this change and 58GiB after this change.
>
> Example debug output:
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_ADD_MEM_REG (37)
>   Flags:   0x9
>   Size:    40
>   Fds: 59
>   Adding region 50
>       guest_phys_addr: 0x0000000d80000000
>       memory_size:     0x0000000040000000
>       userspace_addr   0x00007f54ebffe000
>       mmap_offset      0x0000000c00000000
>       fd_offset:       0x0000000c00000000
>       new mmap_offset: 0x0000000000000000
>       mmap_addr:       0x00007f7ecc000000
>   Successfully added new region
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user message =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Request: VHOST_USER_ADD_MEM_REG (37)
>   Flags:   0x9
>   Size:    40
>   Fds: 59
>   Adding region 51
>       guest_phys_addr: 0x0000000dc0000000
>       memory_size:     0x0000000040000000
>       userspace_addr   0x00007f552bffe000
>       mmap_offset      0x0000000c40000000
>       fd_offset:       0x0000000c40000000
>       new mmap_offset: 0x0000000000000000
>       mmap_addr:       0x00007f7e8c000000
>   Successfully added new region
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>

> ---
>  subprojects/libvhost-user/libvhost-user.c | 50 ++++++++++++++++++++---
>  1 file changed, 45 insertions(+), 5 deletions(-)
>
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libv=
host-user/libvhost-user.c
> index 75e47b7bb3..7d8293dc84 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -43,6 +43,8 @@
>  #include <fcntl.h>
>  #include <sys/ioctl.h>
>  #include <linux/vhost.h>
> +#include <sys/vfs.h>
> +#include <linux/magic.h>
>
>  #ifdef __NR_userfaultfd
>  #include <linux/userfaultfd.h>
> @@ -281,12 +283,36 @@ vu_remove_all_mem_regs(VuDev *dev)
>      dev->nregions =3D 0;
>  }
>
> +static size_t
> +get_fd_pagesize(int fd)
> +{
> +    static size_t pagesize;
> +#if defined(__linux__)
> +    struct statfs fs;
> +    int ret;
> +
> +    do {
> +        ret =3D fstatfs(fd, &fs);
> +    } while (ret !=3D 0 && errno =3D=3D EINTR);
> +
> +    if (!ret && fs.f_type =3D=3D HUGETLBFS_MAGIC) {
> +        return fs.f_bsize;
> +    }
> +#endif
> +
> +    if (!pagesize) {
> +        pagesize =3D getpagesize();
> +    }
> +    return pagesize;
> +}
> +
>  static void
>  _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
>  {
>      const uint64_t start_gpa =3D msg_region->guest_phys_addr;
>      const uint64_t end_gpa =3D start_gpa + msg_region->memory_size;
>      int prot =3D PROT_READ | PROT_WRITE;
> +    uint64_t mmap_offset, fd_offset;
>      VuDevRegion *r;
>      void *mmap_addr;
>      int low =3D 0;
> @@ -335,11 +361,25 @@ _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *=
msg_region, int fd)
>      idx =3D low;
>
>      /*
> -     * We don't use offset argument of mmap() since the mapped address h=
as
> -     * to be page aligned, and we use huge pages.
> +     * Convert most of msg_region->mmap_offset to fd_offset. In almost a=
ll
> +     * cases, this will leave us with mmap_offset =3D=3D 0, mmap()'ing o=
nly
> +     * what we really need. Only if a memory region would partially cove=
r
> +     * hugetlb pages, we'd get mmap_offset !=3D 0, which usually doesn't=
 happen
> +     * anymore (i.e., modern QEMU).
> +     *
> +     * Note that mmap() with hugetlb would fail if the offset into the f=
ile
> +     * is not aligned to the huge page size.
>       */
> -    mmap_addr =3D mmap(0, msg_region->memory_size + msg_region->mmap_off=
set,
> -                     prot, MAP_SHARED | MAP_NORESERVE, fd, 0);
> +    fd_offset =3D ALIGN_DOWN(msg_region->mmap_offset, get_fd_pagesize(fd=
));
> +    mmap_offset =3D msg_region->mmap_offset - fd_offset;
> +
> +    DPRINT("    fd_offset:       0x%016"PRIx64"\n",
> +           fd_offset);
> +    DPRINT("    adj mmap_offset: 0x%016"PRIx64"\n",
> +           mmap_offset);
> +
> +    mmap_addr =3D mmap(0, msg_region->memory_size + mmap_offset,
> +                     prot, MAP_SHARED | MAP_NORESERVE, fd, fd_offset);
>      if (mmap_addr =3D=3D MAP_FAILED) {
>          vu_panic(dev, "region mmap error: %s", strerror(errno));
>          return;
> @@ -354,7 +394,7 @@ _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *ms=
g_region, int fd)
>      r->size =3D msg_region->memory_size;
>      r->qva =3D msg_region->userspace_addr;
>      r->mmap_addr =3D (uint64_t)(uintptr_t)mmap_addr;
> -    r->mmap_offset =3D msg_region->mmap_offset;
> +    r->mmap_offset =3D mmap_offset;
>      dev->nregions++;
>
>      if (dev->postcopy_listening) {
> --
> 2.43.0
>
>

