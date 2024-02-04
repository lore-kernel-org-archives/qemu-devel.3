Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD0CC48291
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 02:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWRyF-0002ny-TB; Sat, 03 Feb 2024 21:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRyE-0002no-Nf
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 21:10:58 -0500
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1rWRyD-0002yE-0R
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 21:10:58 -0500
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7bf7e37dc60so134068339f.3
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 18:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707012655; x=1707617455; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U//JnNByF3s7dHrdc6UomuNIhpZwtB79mzqnFqpoc20=;
 b=Z63KwU6+d0PhTNp8T88AjojZf87pozdDzePlUTUOeP3vIm3gAx+HY0LsPQin+mvIBC
 pMcQcgM7v4OIQWCEq3Xz17Q4vJ38tWU4ZcD29m9CCbRklYrAp/u+q52QAdChifmidtL4
 BPb0vCPqpfD48EMVwdUY3w/Do6arR1ahUF2HP7gPJxiZEgZrSh8hkot31dK83NkIioIg
 EJX6VaAvESLsZefa3iLi3QjRtD3FqEEeFT5oNUXn8UjV2Skmj7SV8HyqumGC+yu76yto
 VyyqNTGxW8jcFYwQ5IjmoSy1rY1rwMW/fxv7AMF53OUE/4eYOUQttpXeoOD3SfwG0Qih
 YE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707012655; x=1707617455;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U//JnNByF3s7dHrdc6UomuNIhpZwtB79mzqnFqpoc20=;
 b=BHGiXWf7nH+ZxPzmj8BFwPojbhg03evf5iVzfLprwBE7m4r4QowOW8cx01vOSAuqFb
 8ORDrNOHmeIYYt6a3vOF3smOJG04NU//pxRsupQuhBKwhP6XOUAxm4c+8AsXBZKspMcC
 XPL1RET+usrbZe8kcfy7aahP/2e8lMqRkehhd4i4o6tpBsPGOmk5M2K+J45ruV3krwWG
 6ealVelqHNimWHHCxPNXgg709qErahHgLwz89Qe4Hx/8t/tjAeRJgoml2tmb5KlCvKy1
 MTY8/uSGwLNTDIKLX0PfVZ49QIJqq8QTFHMxIiS/vAEs6rDF6ww9xRqxm58b0Ew1aUCg
 YjKw==
X-Gm-Message-State: AOJu0YwGqCCvGhQZaWn/WV/xqerVqnTQqw21/dimZvoyNiGvJ/DtDqhW
 tUysYY92XoasWiEGZli9SmjmvcSIE2HA5TDuY0FueAk02udJzpQmbiPYB9Qm8RQSo1H1JWY0Ayb
 dpK1ByhYB7sUEVFJTUE+BfI9hQqw=
X-Google-Smtp-Source: AGHT+IEtjwpwbrctDsGL3DhZ2v2fgVYmIS3nxckL7uPK85Gzp94CPNeM4eYvhTjQrPG8ghMe/0PixcWfQeCMSTaE3g8=
X-Received: by 2002:a6b:4e0d:0:b0:7ba:9546:2d6b with SMTP id
 c13-20020a6b4e0d000000b007ba95462d6bmr13204640iob.4.1707012655551; Sat, 03
 Feb 2024 18:10:55 -0800 (PST)
MIME-Version: 1.0
References: <20240202215332.118728-1-david@redhat.com>
 <20240202215332.118728-12-david@redhat.com>
In-Reply-To: <20240202215332.118728-12-david@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sat, 3 Feb 2024 21:10:44 -0500
Message-ID: <CAFubqFvC24ng0kHJectz3zN3UDHR6T+Cs7J+RUfm+zT92HR+Zg@mail.gmail.com>
Subject: Re: [PATCH v1 11/15] libvhost-user: Speedup gpa_to_mem_region() and
 vu_gpa_to_va()
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2c;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd2c.google.com
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

One comment on this one.

On Fri, Feb 2, 2024 at 4:56=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> Let's speed up GPA to memory region / virtual address lookup. Store the
> memory regions ordered by guest physical addresses, and use binary
> search for address translation, as well as when adding/removing memory
> regions.
>
> Most importantly, this will speed up GPA->VA address translation when we
> have many memslots.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  subprojects/libvhost-user/libvhost-user.c | 49 +++++++++++++++++++++--
>  1 file changed, 45 insertions(+), 4 deletions(-)
>
> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libv=
host-user/libvhost-user.c
> index d036b54ed0..75e47b7bb3 100644
> --- a/subprojects/libvhost-user/libvhost-user.c
> +++ b/subprojects/libvhost-user/libvhost-user.c
> @@ -199,19 +199,30 @@ vu_panic(VuDev *dev, const char *msg, ...)
>  static VuDevRegion *
>  vu_gpa_to_mem_region(VuDev *dev, uint64_t guest_addr)
>  {
> -    unsigned int i;
> +    int low =3D 0;
> +    int high =3D dev->nregions - 1;
>
>      /*
>       * Memory regions cannot overlap in guest physical address space. Ea=
ch
>       * GPA belongs to exactly one memory region, so there can only be on=
e
>       * match.
> +     *
> +     * We store our memory regions ordered by GPA and can simply perform=
 a
> +     * binary search.
>       */
> -    for (i =3D 0; i < dev->nregions; i++) {
> -        VuDevRegion *cur =3D &dev->regions[i];
> +    while (low <=3D high) {
> +        unsigned int mid =3D low + (high - low) / 2;
> +        VuDevRegion *cur =3D &dev->regions[mid];
>
>          if (guest_addr >=3D cur->gpa && guest_addr < cur->gpa + cur->siz=
e) {
>              return cur;
>          }
> +        if (guest_addr >=3D cur->gpa + cur->size) {
> +            low =3D mid + 1;
> +        }
> +        if (guest_addr < cur->gpa) {
> +            high =3D mid - 1;
> +        }
>      }
>      return NULL;
>  }
> @@ -273,9 +284,14 @@ vu_remove_all_mem_regs(VuDev *dev)
>  static void
>  _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *msg_region, int fd)
>  {
> +    const uint64_t start_gpa =3D msg_region->guest_phys_addr;
> +    const uint64_t end_gpa =3D start_gpa + msg_region->memory_size;
>      int prot =3D PROT_READ | PROT_WRITE;
>      VuDevRegion *r;
>      void *mmap_addr;
> +    int low =3D 0;
> +    int high =3D dev->nregions - 1;
> +    unsigned int idx;
>
>      DPRINT("Adding region %d\n", dev->nregions);
>      DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
> @@ -295,6 +311,29 @@ _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *m=
sg_region, int fd)
>          prot =3D PROT_NONE;
>      }
>
> +    /*
> +     * We will add memory regions into the array sorted by GPA. Perform =
a
> +     * binary search to locate the insertion point: it will be at the lo=
w
> +     * index.
> +     */
> +    while (low <=3D high) {
> +        unsigned int mid =3D low + (high - low)  / 2;
> +        VuDevRegion *cur =3D &dev->regions[mid];
> +
> +        /* Overlap of GPA addresses. */

Looks like this check will only catch if the new region is fully
contained within an existing region. I think we need to check whether
either start or end region are in the range, i.e.:

if ((start_gpa > curr_gpa && start_gpa < cur->gpa + curr_size ) ||
    (end_gpa > currr->gpa && end_gpa < cur->gpa + curr->size)  )


> +        if (start_gpa < cur->gpa + cur->size && cur->gpa < end_gpa) {
> +            vu_panic(dev, "regions with overlapping guest physical addre=
sses");
> +            return;
> +        }
> +        if (start_gpa >=3D cur->gpa + cur->size) {
> +            low =3D mid + 1;
> +        }
> +        if (start_gpa < cur->gpa) {
> +            high =3D mid - 1;
> +        }
> +    }
> +    idx =3D low;
> +
>      /*
>       * We don't use offset argument of mmap() since the mapped address h=
as
>       * to be page aligned, and we use huge pages.
> @@ -308,7 +347,9 @@ _vu_add_mem_reg(VuDev *dev, VhostUserMemoryRegion *ms=
g_region, int fd)
>      DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
>             (uint64_t)(uintptr_t)mmap_addr);
>
> -    r =3D &dev->regions[dev->nregions];
> +    /* Shift all affected entries by 1 to open a hole at idx. */
> +    r =3D &dev->regions[idx];
> +    memmove(r + 1, r, sizeof(VuDevRegion) * (dev->nregions - idx));
>      r->gpa =3D msg_region->guest_phys_addr;
>      r->size =3D msg_region->memory_size;
>      r->qva =3D msg_region->userspace_addr;
> --
> 2.43.0
>
>

