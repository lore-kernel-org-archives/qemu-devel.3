Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4F8C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ZTM-0005Id-Ot; Thu, 10 Sep 2026 03:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4ZTK-0005IT-Tw
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 03:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4ZTI-0007Lg-Gb
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 03:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789026321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GoOh0APyljjRD1QYihvNl3dAkXQ666cRZIPTT+iwIsA=;
 b=UvstTt4haBdwij/ncVUIjiDVoGtMi3vq4QzlkmCePz0uSkYZuhyer/rHRD1+rBIg7iZBQz
 YnRJEk/nfKKvRCn8uOh8/MSJpaqiBLGjHf2oLQxST1BLil73IU7lsmpLbaf+HV3RQR9fRn
 o1Q3HHOuOmEgdBapshYN7NAWyk10F0g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-A47HLWi9OyCMcJJltlA98A-1; Thu, 10 Sep 2026 03:45:18 -0400
X-MC-Unique: A47HLWi9OyCMcJJltlA98A-1
X-Mimecast-MFC-AGG-ID: A47HLWi9OyCMcJJltlA98A_1789026317
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-482db84a6eeso5969671f8f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 00:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789026317; x=1789631117; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GoOh0APyljjRD1QYihvNl3dAkXQ666cRZIPTT+iwIsA=;
 b=Vfiv4N5wvDdiYDMe4mixOffvlN7zhj1a70tgVJdC7AQYAknkrhGxyDmZWmw4DyKJLc
 iuxNacW6v+w6UphIFXV0vZhltqP0TZQYqq06rsINys45RT/3Cs9GlzI4d5+oEscuGZTw
 FhAK8YsyF5xWQd93AltwWkwYy97/QJyAWjB86C3+GmCVvo/3rbprJkOhnltcajGHkZ3v
 mZpSzwrvwIEr6KSG30EDf4A8aHnABzS7mRWeYfPg+hGL5dvy/0XvScSQAx6i6fdmzYg8
 Dt+Tw4ypkD42uPp1+/JbQYvrJRhpK3neczohDVXZn3LP7bV7WFrt9pX8dPMQkjsm+8gO
 WlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789026317; x=1789631117;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GoOh0APyljjRD1QYihvNl3dAkXQ666cRZIPTT+iwIsA=;
 b=SoP02Hl2L4Yt0STpTtoURIxc6D066ux3uO2gmbFZ3tKvfCf2LqgzW9nxGq9pK7iUvn
 TTbzpkgOM58fbBzoTiEafuVDKv8BiZfM0wh9bEyvBbMGYJAH/rqBOEctOLVEir7Xao79
 A8dz9igOFU3yfsCgyl2LJIjqNUzRWzyZA1xZUwB7iLF32nZ3MybELGjO2QvjKwAfJ7Ra
 jyXdUlvY5Ym/A4AMcd4K0XJUQWh+uWE+mIgypCzhDBvtXWYmmUg0YaqLJbfjcbBzOmdV
 xAOBHn7UBVvWRagGHbImy3dhPs4VR/OvFFZhVmQmM2k2+d0Hj8c8kqhFSH20cv0jEBN9
 BoIA==
X-Gm-Message-State: AFuF++k6rowsOJRr/oM0085APgMgD3a15lengH553scwfmbviajGiL2n
 Uw4R8Ek6VtqGcYVNYJIK0Zc39ONx0963VJUQ1o1uc9i2pEpbTmIV9L+4G6OU3B4Nqg3McEnc43A
 SeaCJTK84yB+6xDKsDeF1e/11sQxfp57Hos7OIYoxMdgmFs8S4ONySOsy
X-Gm-Gg: AYBFou3oxjjwG9hFZdENDYiw8a7G3Ys56Gexf5iZ7vkXh5lhakKDxsMR69F5bcbd9hh
 AtSv3HJJ9R8qS0AwkYa4HAMfp4rSX7YewYy+XAey+h/KK5UKnP8vgSk8g1EDyj/vyXUXmbZ/boM
 6Q3cyVD/n9fX9Zf4gxklkK34cpzboxwhkPrUBydK+FOJPLsTORjoauowj3wDc+fclUNR40i1mIf
 bM3Hcgac5LPQqnlohQVWSWlvFBhhXKmc8DZB7wSkGuZ39tjgnHkaSgWJSrPbFgPXZsRhL31gNY4
 Iug4dKbVXALm+VWp/b9HvlaHnur1Jo+gu4H3WaaJC9ayNwed2vFXw8SUoy/rOrF5t7fIh2FnEtz
 PfMrDxR7oD7KCL8HJYkmco4I=
X-Received: by 2002:a05:6000:4a0f:b0:485:877d:ea8e with SMTP id
 ffacd0b85a97d-485c23d101fmr12389144f8f.14.1789026317154; 
 Thu, 10 Sep 2026 00:45:17 -0700 (PDT)
X-Received: by 2002:a05:6000:4a0f:b0:485:877d:ea8e with SMTP id
 ffacd0b85a97d-485c23d101fmr12389009f8f.14.1789026316580; 
 Thu, 10 Sep 2026 00:45:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858dd90e1fsm53445934f8f.28.2026.09.10.00.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 00:45:16 -0700 (PDT)
Date: Thu, 10 Sep 2026 03:45:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Fishman <afishman@redhat.com>
Cc: qemu-devel@nongnu.org, sgarzare@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH v1 1/2] vhost: coalesce unmergeable sections across vring
 boundaries
Message-ID: <20260910034352-mutt-send-email-mst@kernel.org>
References: <20260909125923.75340-1-afishman@redhat.com>
 <20260909125923.75340-2-afishman@redhat.com>
 <20260909092938-mutt-send-email-mst@kernel.org>
 <CAGqnWRYWVd8JcVbdd289LaDusMUcgydFLmViHGjX4GQ83BJ6HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGqnWRYWVd8JcVbdd289LaDusMUcgydFLmViHGjX4GQ83BJ6HA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 09, 2026 at 04:54:18PM +0300, Alex Fishman wrote:
> It is not desirable to merge every coherent adjacent section.
> Virtio-mem sections are marked unmergeable so that their lifetimes can
> be observed independently.


To be more specific. If qemu sent add regions first then remove
regions command, we will never try to access an unmapped region.
Doesn't this solve the problem? The only issue is we can temporarily
need more regions, but that is maybe fixable.


> For example, if regions 1 and 2 are merged, unconditionally merging an
> adjacent region 3 would change the vhost memory table from:
> 
>   [ region 1 + region 2 ]
> 
> to:
> 
>   [ region 1 + region 2 + region 3 ]
> 
> This requires removing the existing region and adding an enlarged one,
> even though region 3 is unrelated to the vring.
> 
> At the failing boundary, regions 1 and 2 must be represented as one
> vhost region because a vring part crosses them; otherwise ring
> verification fails. The patch limits coalescing to that necessary
> boundary. Region 3 remains separate and can be added without reshaping
> the region containing the vring.
> 
> I'll fix the empty lines in the next version.
> 
> Thanks,
> Alex
> 
> 
> On Wed, Sep 9, 2026 at 4:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
>     On Wed, Sep 09, 2026 at 03:59:22PM +0300, Alex Fishman wrote:
>     > Virtio-mem dynamic memslots are marked unmergeable so listeners can
>     > track their lifetimes independently. A vring part crossing the boundary
>     > between two such slots consequently cannot be contained in a single
>     > vhost memory region.
>     >
>     > Coalesce adjacent unmergeable sections only when a descriptor table,
>     > available ring, or used ring spans their boundary and the sections
>     > preserve a coherent GPA-to-HVA translation. Keep unrelated slots
>     > separate so activating them does not reshape the region containing the
>     > vring.
> 
> 
>     I don't get what does it have to do with vrings. If merging them like
>     this is ok, then it's always ok?
> 
>     >
>     > Fixes: 533f5d667909 ("memory,vhost: Allow for marking memory device
>     memory regions unmergeable")
>     >
>     > Buglink: https://redhat.atlassian.net/browse/RHEL-146583
>     >
>     > Signed-off-by: Alex Fishman <afishman@redhat.com>
> 
> 
>     No empty lines between trailers,please.
> 
>     > ---
>     >  hw/virtio/vhost.c | 72 +++++++++++++++++++++++++++++++++++++++++++----
>     >  1 file changed, 67 insertions(+), 5 deletions(-)
>     >
>     > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>     > index 371dca17dd..76910e2628 100644
>     > --- a/hw/virtio/vhost.c
>     > +++ b/hw/virtio/vhost.c
>     > @@ -796,6 +796,70 @@ out:
>     >      g_free(old_sections);
>     >  }
>     > 
>     > +static bool vhost_vring_part_crosses_boundary(uint64_t ring_gpa,
>     > +                                              uint64_t ring_size,
>     > +                                              uint64_t boundary)
>     > +{
>     > +    return ring_size && ring_gpa < boundary &&
>     > +           range_get_last(ring_gpa, ring_size) >= boundary;
>     > +}
>     > +
>     > +static bool vhost_vring_crosses_boundary(struct vhost_dev *dev,
>     > +                                         uint64_t boundary)
>     > +{
>     > +    int i;
>     > +
>     > +    if (vhost_dev_has_iommu(dev)) {
>     > +        return false;
>     > +    }
>     > +
>     > +    for (i = 0; i < dev->nvqs; i++) {
>     > +        struct vhost_virtqueue *vq = &dev->vqs[i];
>     > +
>     > +        if (vhost_vring_part_crosses_boundary(vq->desc_phys, vq->
>     desc_size,
>     > +                                              boundary) ||
>     > +            vhost_vring_part_crosses_boundary(vq->avail_phys, vq->
>     avail_size,
>     > +                                              boundary) ||
>     > +            vhost_vring_part_crosses_boundary(vq->used_phys, vq->
>     used_size,
>     > +                                              boundary)) {
>     > +            return true;
>     > +        }
>     > +    }
>     > +
>     > +    return false;
>     > +}
>     > +
>     > +static bool vhost_sections_can_merge(struct vhost_dev *dev,
>     > +                                     const MemoryRegionSection
>     *prev_sec,
>     > +                                     const MemoryRegionSection *section,
>     > +                                     uint64_t section_gpa,
>     > +                                     uintptr_t section_host)
>     > +{
>     > +    uint64_t prev_gpa_start = prev_sec->offset_within_address_space;
>     > +    uintptr_t prev_host_start =
>     > +        (uintptr_t)memory_region_get_ram_ptr(prev_sec->mr) +
>     > +        prev_sec->offset_within_region;
>     > +    uint64_t offset;
>     > +
>     > +    if (section->mr != prev_sec->mr || section_gpa < prev_gpa_start) {
>     > +        return false;
>     > +    }
>     > +
>     > +    offset = section_gpa - prev_gpa_start;
>     > +
>     > +    if (prev_host_start + offset != section_host) {
>     > +        return false;
>     > +    }
>     > +
>     > +    if (!prev_sec->unmergeable && !section->unmergeable) {
>     > +        return true;
>     > +    }
>     > +
>     > +    /* Only override an unmergeable boundary when a ring part spans it.
>     */
>     > +    return vhost_vring_crosses_boundary(
>     > +        dev, section->offset_within_address_space);
>     > +}
>     > +
>     >  /* Adds the section data to the tmp_section structure.
>     >   * It relies on the listener calling us in memory address order
>     >   * and for each region (via the _add and _nop methods) to
>     > @@ -833,7 +897,7 @@ static void vhost_region_add_section(struct vhost_dev
>     *dev,
>     >                                                 mrs_size, mrs_host);
>     >      }
>     > 
>     > -    if (dev->n_tmp_sections && !section->unmergeable) {
>     > +    if (dev->n_tmp_sections) {
>     >          /* Since we already have at least one section, lets see if
>     >           * this extends it; since we're scanning in order, we only
>     >           * have to look at the last one, and the FlatView that calls
>     > @@ -862,11 +926,9 @@ static void vhost_region_add_section(struct
>     vhost_dev *dev,
>     >                  /* A way to cleanly fail here would be better */
>     >                  return;
>     >              }
>     > -            /* Offset from the start of the previous GPA to this GPA */
>     > -            size_t offset = mrs_gpa - prev_gpa_start;
>     > 
>     > -            if (prev_host_start + offset == mrs_host &&
>     > -                section->mr == prev_sec->mr && !prev_sec->unmergeable) {
>     > +            if (vhost_sections_can_merge(dev, prev_sec, section,
>     > +                                         mrs_gpa, mrs_host)) {
>     >                  uint64_t max_end = MAX(prev_host_end, mrs_host +
>     mrs_size);
>     >                  need_add = false;
>     >                  prev_sec->offset_within_address_space =
> 
> 
> 
> 
> 
> 
>     > --
>     > 2.52.0
> 
> 


