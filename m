Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DB9CA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 12:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEn1r-00029m-Jn; Thu, 08 Oct 2026 08:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xEn1q-00029P-5V
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 08:15:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sraymaek@redhat.com>)
 id 1xEn1m-0004PC-JS
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 08:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791461712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dZX6r4vKJ8FPoIU5CgN0q8Lbzo6PLIke90cpme6C594=;
 b=Q64C7Jyi7BdNfcp7Dow3qoR/r8iuu0tSfntvlLBqEy3B/dirqMTMVeZHSIe4tgKAN0mSPq
 Rj7XaikuHdNzWFU4Hu9zVZsrWVNEdmfKLSlNUnwZa7oARmrSpGmAc13AKeaEh/yg7ns480
 WbXAAhyHmxaFmyCdZOTtP1gWWnBbWAc=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-p3RvwND7O8-f4JhH7Oqa2w-1; Thu, 08 Oct 2026 08:15:10 -0400
X-MC-Unique: p3RvwND7O8-f4JhH7Oqa2w-1
X-Mimecast-MFC-AGG-ID: p3RvwND7O8-f4JhH7Oqa2w_1791461710
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-677d10671b7so5459208d50.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 05:15:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791461710; cv=none;
 d=google.com; s=arc-20260327;
 b=gsi1RzEsprMVYdm2b6Z8HZLkDcA5pcn8+lAWi3yZzQxlK+OrNhyofTC6EgzlYiYYHU
 JsHNETp2iQmr7rlU1qmZ9yZovehuuLw/TBLyLSEharq3+6g6myRzSPWd9J4rXhoIfw7i
 uGiOJEFA1pqLGN89QPBNAuGkOanb8KPBTBP61dOyJ1OIZpycRFD+mVkxu1F4exqM3waQ
 INexVcgqGsCaDtrh6nJ3clBV5sIDVulpGxhXXK32RdjzqFEA6v/DCJYSATz35rwCVm9D
 stWOGG0WV9QfZeBp5Ii6Qysdj+PZF36izzkzIFptt/8ze8Wf1JdkJhfNGX6iRG+Cri6Q
 fo0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dZX6r4vKJ8FPoIU5CgN0q8Lbzo6PLIke90cpme6C594=;
 fh=Yjabpnh3+VZotmTrKhDwnmyrOWycwAvu3EkihPtu/IE=;
 b=Nr3IP7XMmJE3xBbg5FPCk699P3/q3pBLQr5R5rdAx6CfAuSgu2gi41xrgqg+bTofaX
 ttr1AnXAxD3P8CM3mJsl/4vcRj4g5yTsh9g1OdrmnurIqgq+uROqlGzSEcG0rwHU1nyd
 pmP5oArNXagYGcVDrB9Xw9rPKlzBoxqJJItTpDZHTsXLW92JEJz9n4UepPNoo2JJ9yOr
 TzXR7ztaQiibXCxQd7PjvVsS7/4oVmcGiVjYbztWuD/kN5SBpqQrFSkag9y/cJSAu+cC
 Ah4y2vUpqVG8O9JQqB0wWfHVZibE8TQhGlECvH+h7BwK5zZllnxZ1lzw0i/5fatfVsTh
 eGUg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791461710; x=1792066510; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dZX6r4vKJ8FPoIU5CgN0q8Lbzo6PLIke90cpme6C594=;
 b=jNiZ+4b2WZQoTlcTH6h01dGMSiGAlnwyrY+iDvFvS0EcrUNmCECp1KkOFrRbvJtZFn
 ojraBDkiJoyN0oDyTe0SHaCrjGWbRGkBGawbUjSjRYH0cOBSLhjdas+lr+G1D9dm6fr7
 vsnBndDzmU8RcR77huI8PMPpj8JGiSzWLp5NJS8hUFqbnbED2xiLoCOr48EbnxoL/upP
 iuN0Z/LHbMmsHoz8HrFRMZAFjwwjo4F/BvFvekHbkab4lENZ3OCGxOLy3yCgg0CUPIto
 iFLRLzlv4A+QSqNLOdCljN0Bp3CQhKKJgPxQhd2lPxPp3n6QxZd4CdnI73fmx4hWVdWl
 +c7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791461710; x=1792066510;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dZX6r4vKJ8FPoIU5CgN0q8Lbzo6PLIke90cpme6C594=;
 b=qH4DuNcseN8JotZfU32LVpNWgbQCPa0V46lasbGd5BkHwLxugYY/FLpMgaw9wnUqp+
 OnGT40JFZSPnTf+I1ZNMyZgwE0MtSlkRvzIHs+4Rbg2l3AJEAMTWPJngKJGKnjubqBFB
 s/g4cD9q4YbPdTjtVUOA6dFrK4pQE6ICqEAN8wENG4TGB5JtQSLgBmUS6dyAgUA+3Hqw
 9PpJq0Ajtfg+AObOrfeqcwA7uEfUgy4l5n8hIFvQMrBUEUhZc7QXIltwo8eR+Bh6FWba
 oA9xvHWtZ0uGpb89/7TIH41J6Khl6dhppVQWs0SVn5WsSeHSinjIilFxBvQlmIPUP67Q
 Eaaw==
X-Gm-Message-State: AFq9FYKhn7VdETQRpZeWUxwYCU96Rf9XJBt/eXW1J/UqicSVI+WIkGc5
 T3O5ldRxOQJS06qukM9tEjV3zaIH31G4DbiWUu3MVhF9UdXTjymLMBPN/wHAoQKeIabOSJoK+f4
 yWuS4YMQUg7ZpwNn7GFbmjK7jhQo6spzlVQcrnKo99Jl5tpAiRmw7L7YZqG1xz+8DlUM6XlzXoZ
 FnsiTqheuS0qoFVq0Gk8TmSG2CaQYz8xE=
X-Gm-Gg: AYBFou2TUNdrwSAtM2MTkkF3QkTaBHvaDVnMBtzHrVUfDnTtMf2zUkl5as82uRS/0vt
 lWaA8kfV1bR8DdbbegzbXKV3Zz02UKJnXqXe5IZxOQ23UI69zPyYhGqghslWLvEEO74gadJ1j5T
 xs2FTxEud+Aj87aQOAv0TLmVNyPfSSpAy42uRIyvZvMx/rEPFQTIbLxr/YtLVs4eguynVg0IS5N
 u0fhYHU02fZMv7RTQ==
X-Received: by 2002:a05:690e:150d:b0:677:c303:464a with SMTP id
 956f58d0204a3-6790a288da1mr2988039d50.91.1791461709927; 
 Thu, 08 Oct 2026 05:15:09 -0700 (PDT)
X-Received: by 2002:a05:690e:150d:b0:677:c303:464a with SMTP id
 956f58d0204a3-6790a288da1mr2988029d50.91.1791461709437; Thu, 08 Oct 2026
 05:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20261005133316.198087-1-sraymaek@redhat.com>
 <asZXGMSjDidiL-Yd@redhat.com>
In-Reply-To: <asZXGMSjDidiL-Yd@redhat.com>
From: Sanne Raymaekers <sraymaek@redhat.com>
Date: Thu, 8 Oct 2026 14:14:32 +0200
X-Gm-Features: AclHuK9PvRAbSV8X1a3KyYiVrzQ5QMOQi5U4sSDmA3WcPm3vz264xxD7_UkF-I4
Message-ID: <CAHfd8XB8my63Gvk=O9uaOg5-xYtFE1A4uy-w28ZKcs2jspyVVg@mail.gmail.com>
Subject: Re: [PATCH 1/3] block/vmdk: align stream optimized data grains on 512
 byte chunks
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, fam@euphon.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sraymaek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Kevin,

Thank you for the review.

On Wed, Oct 7, 2026 at 4:28=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 05.10.2026 um 15:33 hat Sanne Raymaekers geschrieben:
> > According to the spec: "Each marker and its associated block begin on a
> > sector or 512=E2=80=90byte boundary... There are five types of markers:
> > compressed grain markers,..." [^1]
> >
> > This means that instead of aligning grains on their typical size (64K),
> > in stream optimized disks, grains should be aligned on 512 byte chunks.
> >
> > [^1] Virtual Disk Format 5.0 Technical Note.
> >
> > Signed-off-by: Sanne Raymaekers <sraymaek@redhat.com>
>
> One small thing about the series as a whole first: It's conventional for
> QEMU patch series (with more than one patch) to include a cover letter
> (i.e. [PATCH 0/3]) that gives you the chance to explain the big picture
> and what the series is about, and others to distinguish what is a reply
> to the series as a whole as opposed to the first patch specifically. Not
> a big deal, but you can just use git format-patch --cover-letter for v2
> and edit the cover letter file before sending the series.


Ack, will add that in v2.

>
>
> For this patch specifically, it shows a real problem in the VMDK code,
> but I think the solution isn't quite right. What currently happens when
> you write a compressed 64k cluster:
>
>     1. get_cluster_offset() finds that the offset is unallocated and
>        gets a new cluster_offset
>
>     2. get_whole_cluster() is normally supposed to initialise those
>        parts of a newly allocated cluster (with zeros or from the
>        backing file) that won't be written to.
>
>        Because we pass skip_start_bytes =3D skip_end_bytes =3D 0 for
>        compressed clusters, zeros are written to the whole 64k starting
>        from cluster_offset.
>
>     3. vmdk_write_extent() writes the compressed data at cluster_offset,
>        overwriting the zeros we just wrote in step 2. The data written
>        here can be much smaller than 64k if it compresses well.
>
> If this happen near the end of the image, the 64k write has a side
> effect of leaving the image larger than intended.
>
> Your patch replaces this with writing only 512 bytes of zeros in step 2,
> however they are still immediately overwritten again by the real
> compressed data. So it's not necessarily that the write has the wrong
> size, but that it's completely unnecessary I/O - compressed writes
> always cover the whole cluster, there is no rest that should get copied
> from the backing file.

So if I read this correctly, while vmdk_pwritev always passes the
cluster size (128 (granularity) * 512 (sector size) =3D 64k) to
vmdk_write_extent, vmdk_write_extent will still write variable length
data grain markers.  This is in spite of the "n_bytes >
(extent->cluster_sectors * SECTOR_SIZE) || (n_bytes <
(extent->cluster_sectors * SECTOR_SIZE)" check at the start of
vmdk_write_extent. vmdk_write_extent will just make sure it aligns the
next sector on 512 bytes.

>
>
> So I'm wondering if the better fix would be calling get_whole_cluster()
> only if !extent->compressed in the first place, saving us the memory
> allocation and the I/O that will be immediately overwritten again
> anyway.
>
> You could also argue that skip_end_bytes should be passed as n_bytes or
> extent->cluster_sectors * BDRV_SECTOR_SIZE for compressed extents,
> indicating that there is nothing to be copied, but even then skipping
> get_whole_cluster() would save us a useless memory allocation.


So I think that makes sense. Because vmdk_write_extent ensures writes
are always aligned on 512 byte chunks there's no reason to check and
allocate it beforehand.

>
>
> >  block/vmdk.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/vmdk.c b/block/vmdk.c
> > index cd8b4ec7c8..3cdca06fff 100644
> > --- a/block/vmdk.c
> > +++ b/block/vmdk.c
> > @@ -1460,9 +1460,11 @@ get_whole_cluster(BlockDriverState *bs, VmdkExte=
nt *extent,
> >      int64_t cluster_bytes;
> >      uint8_t *whole_grain;
> >      bool copy_from_backing;
> > +    BDRVVmdkState *s =3D bs->opaque;
> >
> >      /* For COW, align request sector_num to cluster start */
> > -    cluster_bytes =3D extent->cluster_sectors << BDRV_SECTOR_BITS;
> > +    cluster_bytes =3D strcmp(s->create_type, "streamOptimized") =3D=3D=
 0 ? SECTOR_SIZE
> > +      : extent->cluster_sectors << BDRV_SECTOR_BITS;
>
> Doing string comparisons for each request isn't great. I think
> extent->compressed should have the same meaning.


It makes sense to use compressed as a proxy. I wasn't 100% sure that no
other VMDK formats include compressed extents, but I guess not.

>
>
> >      offset =3D QEMU_ALIGN_DOWN(offset, cluster_bytes);
> >      whole_grain =3D qemu_blockalign(bs, cluster_bytes);
> >      copy_from_backing =3D bs->backing && !zeroed;
>
> Kevin
>

Thanks!


--=20
Kind regards,
Sanne


