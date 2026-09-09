Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D84C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4IlO-0000yQ-1i; Wed, 09 Sep 2026 09:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afishman@redhat.com>)
 id 1x4IlF-0000w6-5W
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 09:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afishman@redhat.com>)
 id 1x4Il2-0000Dg-Kz
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 09:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788962072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bah/aL4bFekXSnkATNvfGIlEy5lDBk2Epx/GvtRJNrs=;
 b=MWzq/TcYldUAeExQUWPKiUYh8hNSnaH2Z4NFb7YHkCdSV8wlYgxINU/UmCEMaR8aRv1s0P
 kPc0sP9f1srOTQvit1H8zfb5coSoNEA0TSzztXk+4BAyxWvVCAv9LJ2dYJ4QZ6mHmOsfJU
 DHO/Uyg5RQ+8P4mg9IhUELI6nwtbG8c=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-6rwm9Tg4N2SVUrVe2YxznQ-1; Wed, 09 Sep 2026 09:54:30 -0400
X-MC-Unique: 6rwm9Tg4N2SVUrVe2YxznQ-1
X-Mimecast-MFC-AGG-ID: 6rwm9Tg4N2SVUrVe2YxznQ_1788962070
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-53001b668a6so73840421cf.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 06:54:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788962070; cv=none;
 d=google.com; s=arc-20260327;
 b=oGbzgyT/Alq2i1fTHuprEtL5OqC2bvUlOTQG7EbXUli9dk0msh2Ks/Ulp4sFCS4e4N
 IOnhWYUEMqRM/jUYtSMzCOb7nxpoFqeBAh7soIO2/ADkd4G2ivaa8EKAe8rBD1EEbQOg
 nWGthzt0oKebe0mXCU6KaQDLOnnubePuv8pGR9xmrus30jD39TVCZ4Je7YRzIaaCMsqw
 QAYoFlfRtTkNAV8cdpBiklBWDl+cAGOa0uEgxmm/oZ4x+NTEmWbiE/mrUbRJpfVABT9U
 H++dY+chvvAepIc/hzVyBEnUwC56UIk+aN0CGEli+hYLJlNV/jh8MLVI8YDHfwq/4Khq
 LjvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bah/aL4bFekXSnkATNvfGIlEy5lDBk2Epx/GvtRJNrs=;
 fh=ikIROAe4FG7GY6nFHcpMBS0Tm5PK5AkxRv1HH7kUZUo=;
 b=GCn7l+0EhQB+IbfaGCWUmNeOJw8Od61c9cHcrsqpaKLcaZsJczfLReOTVgQkdCNS+V
 FPqaDVezxj11LAobEjDxWEff2JWjCRFa6oPt+70i6SS95EyRIHwOnCSnFOXARkkhm5En
 VuCt9pLI8H0+KAH/QAIKgahbFgr32WQUi4s0ny45ilBhI1p/PGD1zGxVkqPnkwcShGUC
 8gMjylDO1DH+kIkawA7ubn6RutG9dNJhTmUkbg940mHbYD/VQFZUV7BkfpCLWQi4vzv9
 c37tHI4h63Q6FNH9CoOW0EgghFQi7e47GqYPfX4rxo49V/1v1bYHdNUwfDkUH/tgh6JY
 SZQA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788962070; x=1789566870; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bah/aL4bFekXSnkATNvfGIlEy5lDBk2Epx/GvtRJNrs=;
 b=ei01cLxuPwoh33AObE2pqHkKm9D/Kw0IO8UWtAu4d3Nzj+fcmptP6KakIs8CX91qS1
 6VAXPx+BxeyrqBw8wCyXgGqZ+tj1/o4halhYfGix+aNDG1szPR/Edjfdj4D0oGnLoPzO
 JLQkRtJ71qaLyD5aBO4pSQDgAndxHeZ46GdSU1Xf7nl04sRO+KXA4akU9kRRq2jGEmER
 +Nbf/OKDyR6Ubd2BfpNtF4Nn5vxVY5j4O53uBfbt/Wg4Y6IWV+zdWm1WJh9dmir+uem5
 v+x1UpeZFF3p8BAay8sT3mTgPVqcBH0odhOm4Feo1HR3wrDgg62HlngnWrLxFT0FUHJ1
 ZIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788962070; x=1789566870;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bah/aL4bFekXSnkATNvfGIlEy5lDBk2Epx/GvtRJNrs=;
 b=NdMpBT3W/IzoLYGIlqnLGX28PpEw3rEZLaHpf0E2hbWkrrD+xbAEQubykQyFPz0al1
 Ri/aaGCE92hGUg/9EJLdYi1bam2NFY7p+QhMFv7MVwkbvm8pqgiMn0DO2etojw6JU1ZR
 npVeMRzLEya3QTxE6mj+SS7gOgCQ6Hdvt856ouLfq1FGyG0j7i81rqG6IpvUUKmZ88HP
 BhVKJplN6QJVGNGForNZZ8TXwdfsgKMNAlyH1+BrydR9nNqXSuwdX6unwwF/MLOPD0Rc
 UluyduHadyD5QvbyLRlstZStp4pK0ezECHDFzfLBfWCUfTpBdyknEu08v8vpIagv0k++
 +WTg==
X-Gm-Message-State: AFuF++ntSRrkrWfM/qssRv3jcBFwoJd2MFx325zS+FQZogMRQh6Ar1sC
 CET6o+2ZvpsOv+nCiRpxUbsK0eY7Mv8amQB0X7AkgCpucg+wBPFKHCsDKFyIs+Wf1d5fj8z8ilN
 g8TLFigawEIhpu5qpMNoZawqUo3o2vmukpzLs5mDspl47oMAdcv6wcqmVUsw4fAQBzvm0Si8Z2q
 +3Tv2iHHBfgPuuhpaVKU7S2eSo5niLwKk=
X-Gm-Gg: AYBFou2X0i9PDlkGpbQdt/MyXQQZEGkbCVfnQKV+m2D/0u5PQHYlqK21cfnRpaUX5K9
 UdWg3rVU+PbOLbOhQ02EXSSLLOLJRQ4loewKfNWQpwgTTE3WfBWsxxbYOUlGT4iB81xKHsAKLzj
 vyIm9wIrCg/klqoIf61FWVIhQsjTDV7NDIM02eyCb9Gqxgqd6DfS0r7y26zv8IMBJ4kPeJUgRaa
 jlAhN4pi+lENB2lehjnyCkI0Jz8cHII9kZyToruSAx1bt8=
X-Received: by 2002:ac8:7d0c:0:b0:530:42e4:effd with SMTP id
 d75a77b69052e-530549600e1mr394890731cf.42.1788962070177; 
 Wed, 09 Sep 2026 06:54:30 -0700 (PDT)
X-Received: by 2002:ac8:7d0c:0:b0:530:42e4:effd with SMTP id
 d75a77b69052e-530549600e1mr394889911cf.42.1788962069230; Wed, 09 Sep 2026
 06:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260909125923.75340-1-afishman@redhat.com>
 <20260909125923.75340-2-afishman@redhat.com>
 <20260909092938-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260909092938-mutt-send-email-mst@kernel.org>
From: Alex Fishman <afishman@redhat.com>
Date: Wed, 9 Sep 2026 16:54:18 +0300
X-Gm-Features: AcwNN1WUbfOz48S36tSVYg7qJ41jIK8XBeAKu52Ky3jsJb11D386cS4GuazUS9U
Message-ID: <CAGqnWRYWVd8JcVbdd289LaDusMUcgydFLmViHGjX4GQ83BJ6HA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] vhost: coalesce unmergeable sections across vring
 boundaries
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, sgarzare@redhat.com, farosas@suse.de, 
 lvivier@redhat.com, pbonzini@redhat.com
Content-Type: multipart/alternative; boundary="000000000000a75bd3065b0d3005"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=afishman@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--000000000000a75bd3065b0d3005
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It is not desirable to merge every coherent adjacent section.
Virtio-mem sections are marked unmergeable so that their lifetimes can
be observed independently.

For example, if regions 1 and 2 are merged, unconditionally merging an
adjacent region 3 would change the vhost memory table from:

  [ region 1 + region 2 ]

to:

  [ region 1 + region 2 + region 3 ]

This requires removing the existing region and adding an enlarged one,
even though region 3 is unrelated to the vring.

At the failing boundary, regions 1 and 2 must be represented as one
vhost region because a vring part crosses them; otherwise ring
verification fails. The patch limits coalescing to that necessary
boundary. Region 3 remains separate and can be added without reshaping
the region containing the vring.

I'll fix the empty lines in the next version.

Thanks,
Alex


On Wed, Sep 9, 2026 at 4:31=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:

> On Wed, Sep 09, 2026 at 03:59:22PM +0300, Alex Fishman wrote:
> > Virtio-mem dynamic memslots are marked unmergeable so listeners can
> > track their lifetimes independently. A vring part crossing the boundary
> > between two such slots consequently cannot be contained in a single
> > vhost memory region.
> >
> > Coalesce adjacent unmergeable sections only when a descriptor table,
> > available ring, or used ring spans their boundary and the sections
> > preserve a coherent GPA-to-HVA translation. Keep unrelated slots
> > separate so activating them does not reshape the region containing the
> > vring.
>
>
> I don't get what does it have to do with vrings. If merging them like
> this is ok, then it's always ok?
>
> >
> > Fixes: 533f5d667909 ("memory,vhost: Allow for marking memory device
> memory regions unmergeable")
> >
> > Buglink: https://redhat.atlassian.net/browse/RHEL-146583
> >
> > Signed-off-by: Alex Fishman <afishman@redhat.com>
>
>
> No empty lines between trailers,please.
>
> > ---
> >  hw/virtio/vhost.c | 72 +++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 67 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 371dca17dd..76910e2628 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -796,6 +796,70 @@ out:
> >      g_free(old_sections);
> >  }
> >
> > +static bool vhost_vring_part_crosses_boundary(uint64_t ring_gpa,
> > +                                              uint64_t ring_size,
> > +                                              uint64_t boundary)
> > +{
> > +    return ring_size && ring_gpa < boundary &&
> > +           range_get_last(ring_gpa, ring_size) >=3D boundary;
> > +}
> > +
> > +static bool vhost_vring_crosses_boundary(struct vhost_dev *dev,
> > +                                         uint64_t boundary)
> > +{
> > +    int i;
> > +
> > +    if (vhost_dev_has_iommu(dev)) {
> > +        return false;
> > +    }
> > +
> > +    for (i =3D 0; i < dev->nvqs; i++) {
> > +        struct vhost_virtqueue *vq =3D &dev->vqs[i];
> > +
> > +        if (vhost_vring_part_crosses_boundary(vq->desc_phys,
> vq->desc_size,
> > +                                              boundary) ||
> > +            vhost_vring_part_crosses_boundary(vq->avail_phys,
> vq->avail_size,
> > +                                              boundary) ||
> > +            vhost_vring_part_crosses_boundary(vq->used_phys,
> vq->used_size,
> > +                                              boundary)) {
> > +            return true;
> > +        }
> > +    }
> > +
> > +    return false;
> > +}
> > +
> > +static bool vhost_sections_can_merge(struct vhost_dev *dev,
> > +                                     const MemoryRegionSection
> *prev_sec,
> > +                                     const MemoryRegionSection *sectio=
n,
> > +                                     uint64_t section_gpa,
> > +                                     uintptr_t section_host)
> > +{
> > +    uint64_t prev_gpa_start =3D prev_sec->offset_within_address_space;
> > +    uintptr_t prev_host_start =3D
> > +        (uintptr_t)memory_region_get_ram_ptr(prev_sec->mr) +
> > +        prev_sec->offset_within_region;
> > +    uint64_t offset;
> > +
> > +    if (section->mr !=3D prev_sec->mr || section_gpa < prev_gpa_start)=
 {
> > +        return false;
> > +    }
> > +
> > +    offset =3D section_gpa - prev_gpa_start;
> > +
> > +    if (prev_host_start + offset !=3D section_host) {
> > +        return false;
> > +    }
> > +
> > +    if (!prev_sec->unmergeable && !section->unmergeable) {
> > +        return true;
> > +    }
> > +
> > +    /* Only override an unmergeable boundary when a ring part spans it=
.
> */
> > +    return vhost_vring_crosses_boundary(
> > +        dev, section->offset_within_address_space);
> > +}
> > +
> >  /* Adds the section data to the tmp_section structure.
> >   * It relies on the listener calling us in memory address order
> >   * and for each region (via the _add and _nop methods) to
> > @@ -833,7 +897,7 @@ static void vhost_region_add_section(struct
> vhost_dev *dev,
> >                                                 mrs_size, mrs_host);
> >      }
> >
> > -    if (dev->n_tmp_sections && !section->unmergeable) {
> > +    if (dev->n_tmp_sections) {
> >          /* Since we already have at least one section, lets see if
> >           * this extends it; since we're scanning in order, we only
> >           * have to look at the last one, and the FlatView that calls
> > @@ -862,11 +926,9 @@ static void vhost_region_add_section(struct
> vhost_dev *dev,
> >                  /* A way to cleanly fail here would be better */
> >                  return;
> >              }
> > -            /* Offset from the start of the previous GPA to this GPA *=
/
> > -            size_t offset =3D mrs_gpa - prev_gpa_start;
> >
> > -            if (prev_host_start + offset =3D=3D mrs_host &&
> > -                section->mr =3D=3D prev_sec->mr && !prev_sec->unmergea=
ble) {
> > +            if (vhost_sections_can_merge(dev, prev_sec, section,
> > +                                         mrs_gpa, mrs_host)) {
> >                  uint64_t max_end =3D MAX(prev_host_end, mrs_host +
> mrs_size);
> >                  need_add =3D false;
> >                  prev_sec->offset_within_address_space =3D
>
>
>
>
>
>
> > --
> > 2.52.0
>
>

--000000000000a75bd3065b0d3005
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><pre dir=3D"ltr">It is not desirable to merge every cohere=
nt adjacent section.<br>Virtio-mem sections are marked unmergeable so that =
their lifetimes can<br>be observed independently.<br><br>For example, if re=
gions 1 and 2 are merged, unconditionally merging an<br>adjacent region 3 w=
ould change the vhost memory table from:<br><br>=C2=A0 [ region 1 + region =
2 ]<br><br>to:<br><br>=C2=A0 [ region 1 + region 2 + region 3 ]<br><br>This=
 requires removing the existing region and adding an enlarged one,<br>even =
though region 3 is unrelated to the vring.<br><br>At the failing boundary, =
regions 1 and 2 must be represented as one<br>vhost region because a vring =
part crosses them; otherwise ring<br>verification fails. The patch limits c=
oalescing to that necessary<br>boundary. Region 3 remains separate and can =
be added without reshaping<br>the region containing the vring.<br><br>I&#39=
;ll fix the empty lines in the next version.<br><br>Thanks,<br>Alex</pre></=
div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Wed, Sep 9, 2026 at 4:31=E2=80=AFPM Michael S. Tsirk=
in &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, Sep 09, 2026=
 at 03:59:22PM +0300, Alex Fishman wrote:<br>
&gt; Virtio-mem dynamic memslots are marked unmergeable so listeners can<br=
>
&gt; track their lifetimes independently. A vring part crossing the boundar=
y<br>
&gt; between two such slots consequently cannot be contained in a single<br=
>
&gt; vhost memory region.<br>
&gt; <br>
&gt; Coalesce adjacent unmergeable sections only when a descriptor table,<b=
r>
&gt; available ring, or used ring spans their boundary and the sections<br>
&gt; preserve a coherent GPA-to-HVA translation. Keep unrelated slots<br>
&gt; separate so activating them does not reshape the region containing the=
<br>
&gt; vring.<br>
<br>
<br>
I don&#39;t get what does it have to do with vrings. If merging them like<b=
r>
this is ok, then it&#39;s always ok?<br>
<br>
&gt; <br>
&gt; Fixes: 533f5d667909 (&quot;memory,vhost: Allow for marking memory devi=
ce memory regions unmergeable&quot;)<br>
&gt; <br>
&gt; Buglink: <a href=3D"https://redhat.atlassian.net/browse/RHEL-146583" r=
el=3D"noreferrer" target=3D"_blank">https://redhat.atlassian.net/browse/RHE=
L-146583</a><br>
&gt; <br>
&gt; Signed-off-by: Alex Fishman &lt;<a href=3D"mailto:afishman@redhat.com"=
 target=3D"_blank">afishman@redhat.com</a>&gt;<br>
<br>
<br>
No empty lines between trailers,please.<br>
<br>
&gt; ---<br>
&gt;=C2=A0 hw/virtio/vhost.c | 72 +++++++++++++++++++++++++++++++++++++++++=
++----<br>
&gt;=C2=A0 1 file changed, 67 insertions(+), 5 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c<br>
&gt; index 371dca17dd..76910e2628 100644<br>
&gt; --- a/hw/virtio/vhost.c<br>
&gt; +++ b/hw/virtio/vhost.c<br>
&gt; @@ -796,6 +796,70 @@ out:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_free(old_sections);<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static bool vhost_vring_part_crosses_boundary(uint64_t ring_gpa,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uint64_t ring_size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uint64_t boundary)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return ring_size &amp;&amp; ring_gpa &lt; boundary &amp=
;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0range_get_last(ring_gpa, rin=
g_size) &gt;=3D boundary;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool vhost_vring_crosses_boundary(struct vhost_dev *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint64_t boundary)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (vhost_dev_has_iommu(dev)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; dev-&gt;nvqs; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct vhost_virtqueue *vq =3D &amp;dev-&=
gt;vqs[i];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vhost_vring_part_crosses_boundary(vq-=
&gt;desc_phys, vq-&gt;desc_size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 boundary) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_vring_part_crosses_bo=
undary(vq-&gt;avail_phys, vq-&gt;avail_size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 boundary) ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_vring_part_crosses_bo=
undary(vq-&gt;used_phys, vq-&gt;used_size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 boundary)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool vhost_sections_can_merge(struct vhost_dev *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const Memory=
RegionSection *prev_sec,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const Memory=
RegionSection *section,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t sec=
tion_gpa,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uintptr_t se=
ction_host)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint64_t prev_gpa_start =3D prev_sec-&gt;offset_within_=
address_space;<br>
&gt; +=C2=A0 =C2=A0 uintptr_t prev_host_start =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (uintptr_t)memory_region_get_ram_ptr(prev=
_sec-&gt;mr) +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 prev_sec-&gt;offset_within_region;<br>
&gt; +=C2=A0 =C2=A0 uint64_t offset;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (section-&gt;mr !=3D prev_sec-&gt;mr || section_gpa =
&lt; prev_gpa_start) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 offset =3D section_gpa - prev_gpa_start;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (prev_host_start + offset !=3D section_host) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!prev_sec-&gt;unmergeable &amp;&amp; !section-&gt;u=
nmergeable) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Only override an unmergeable boundary when a ring pa=
rt spans it. */<br>
&gt; +=C2=A0 =C2=A0 return vhost_vring_crosses_boundary(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev, section-&gt;offset_within_address_sp=
ace);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 /* Adds the section data to the tmp_section structure.<br>
&gt;=C2=A0 =C2=A0* It relies on the listener calling us in memory address o=
rder<br>
&gt;=C2=A0 =C2=A0* and for each region (via the _add and _nop methods) to<b=
r>
&gt; @@ -833,7 +897,7 @@ static void vhost_region_add_section(struct vhost_=
dev *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mrs_size, mrs_host);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 if (dev-&gt;n_tmp_sections &amp;&amp; !section-&gt;unme=
rgeable) {<br>
&gt; +=C2=A0 =C2=A0 if (dev-&gt;n_tmp_sections) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Since we already have at least on=
e section, lets see if<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* this extends it; since we&#3=
9;re scanning in order, we only<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* have to look at the last one=
, and the FlatView that calls<br>
&gt; @@ -862,11 +926,9 @@ static void vhost_region_add_section(struct vhost=
_dev *dev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* A way=
 to cleanly fail here would be better */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Offset from the start of=
 the previous GPA to this GPA */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t offset =3D mrs_gpa -=
 prev_gpa_start;<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prev_host_start + offse=
t =3D=3D mrs_host &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section-&gt;m=
r =3D=3D prev_sec-&gt;mr &amp;&amp; !prev_sec-&gt;unmergeable) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vhost_sections_can_merg=
e(dev, prev_sec, section,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0mrs_gpa, mrs_host)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t=
 max_end =3D MAX(prev_host_end, mrs_host + mrs_size);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 need_add=
 =3D false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prev_sec=
-&gt;offset_within_address_space =3D<br>
<br>
<br>
<br>
<br>
<br>
<br>
&gt; -- <br>
&gt; 2.52.0<br>
<br>
</blockquote></div>

--000000000000a75bd3065b0d3005--


