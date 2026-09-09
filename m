Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676A2C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4K9s-0005Un-L4; Wed, 09 Sep 2026 11:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4K9q-0005SC-Q0
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:24:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4K9n-0005Z5-Gu
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788967453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VPuid/pYwxTsIV7lDKlEN6CYjkkgR6miOX6a9Erxs68=;
 b=CA2RK8jXHv81wUT26v0IXpem7zBF6vUGdlk5mImkK6ErBFXKaMExPFw7XJNQYAjCYTl1M/
 BQJxVVc1phY4QDrcs1cpF42a++LkayamNsVhXdFR6+vuKU2+r6X4YzqCnpn/eJz3/gByoZ
 DCy1Sa9Fl/OOFF4wX7m4OFEamnIOm8k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-iwjYJwtuPfCNLjnOQuNjKQ-1; Wed, 09 Sep 2026 11:24:11 -0400
X-MC-Unique: iwjYJwtuPfCNLjnOQuNjKQ-1
X-Mimecast-MFC-AGG-ID: iwjYJwtuPfCNLjnOQuNjKQ_1788967450
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f4bff865cso3721780f8f.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 08:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788967450; x=1789572250; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VPuid/pYwxTsIV7lDKlEN6CYjkkgR6miOX6a9Erxs68=;
 b=pOu1hChSA4kHf8pUPM/bdhB+yOW1345GboUUL9w8xBTbs9QcVcB2LswluNAcuw16G4
 HsQIoT+yXHsB4Rzx9qmXJVUY5mB0kxl7bpfMqIfT3f+I2NsYmiTQTHDWm3BOCT/HRQqY
 tMVxxjP95xPcWAgDuJPgF1sMaw8aKjN4BLAroq3fR29AyUyJu4XMfv8DN7UHRUBzLmoF
 lEIoZzJ7qO+Fe38znpzTQYlqbULjRqdUhzKJJF8AWU0ycmgjBNW7nVmOLLKAReb8j3+V
 Rg4EATIT2X3WwwCe19vwaWrpoyNURxZcs/970ZtIkN6dgKOGAGWfwpkJc0T5tW+NY6K4
 bexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788967450; x=1789572250;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VPuid/pYwxTsIV7lDKlEN6CYjkkgR6miOX6a9Erxs68=;
 b=a+BTBOROz1SfLCXHcIRY5madtX18Hme5wrzB+fvY5NzX1SSm1r+Hl6seLiA/dVUKTj
 Bcho2rpVwv1LLRJiSuVxIh15ATQS3OEvvD6JupRtwedVdoF/StC6okFpnmvhC/pNqxzd
 DvevDwxnPTU9KzW8/k2ZrHHMchCgYiU7mfI8SE0zUtu+xrkAdzuk+VPWmbyaPPuSfm5R
 ov4zo1zHevIU7IIifRD/uKYauLWTsMNQzzrtM0Dm/jZJ9WzaFRpNxG5tzSMXg2awB5ey
 mgBYL4W0zgV+byXMbsJlyz7mCHa9OZF7I8PE591HOKXy2rULaPVFErbLEZuCqM4uB1DW
 bZ9Q==
X-Gm-Message-State: AFuF++miF75+dIXtO5pGYtZ6uqnWWl/7dnKvu0oog5Z9UYKZmAEoXN+z
 TATMvxyZ6K9TYBzusk8g0rFFW/gu3oEDCq8SchZ5pP8jArKHwb3AJE3WmYyMyH9f2/Cwq/xdn7k
 9aI0nVGe66chiCLvDMTsEBQV/moQfkvWi/2ly3vYh3W2PvUK347j8/D7G
X-Gm-Gg: AYBFou0dOgMPoGeAsXI+hm7s8QSEZ+YKQPxZxJKjtFZO6DyYPtCTvUTH0FX22/T1UQ2
 OZk8QEWx826k4XSy4NZHNSw101HqrS7pxXb9tTksvXWCzT6gOq0DwGN1UDqUyLLCXM1yMUCm2ka
 gH8TNZSEtujVntNv1+3/7BYnssnNAvfFeUwlI1WP2oDzuy/3T244pfAGcstbt/1LGYPotPlEds4
 McObD8MqXPnc1nKNGeadJ3B0chpZucWi2RBzFgz+PqHgiajGD7Bbd7nIDYve4PTdAyzOGe2/YsH
 ObFVJ1qcFGNzFAVQjXQbHQDBNsZ3Yk6g3RRbHepRid+a//nQhSKB3qKz2KG4gehF3gaIpfm1ULW
 rsLB68+ur/KFw9uKU+woBvFs=
X-Received: by 2002:a5d:5f91:0:b0:485:acdd:1524 with SMTP id
 ffacd0b85a97d-485acdd16b2mr9091308f8f.11.1788967450135; 
 Wed, 09 Sep 2026 08:24:10 -0700 (PDT)
X-Received: by 2002:a5d:5f91:0:b0:485:acdd:1524 with SMTP id
 ffacd0b85a97d-485acdd16b2mr9091192f8f.11.1788967449452; 
 Wed, 09 Sep 2026 08:24:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c81c3sm45356011f8f.26.2026.09.09.08.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 08:24:08 -0700 (PDT)
Date: Wed, 9 Sep 2026 11:24:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Fishman <afishman@redhat.com>
Cc: qemu-devel@nongnu.org, sgarzare@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH v1 1/2] vhost: coalesce unmergeable sections across vring
 boundaries
Message-ID: <20260909112304-mutt-send-email-mst@kernel.org>
References: <20260909125923.75340-1-afishman@redhat.com>
 <20260909125923.75340-2-afishman@redhat.com>
 <20260909092938-mutt-send-email-mst@kernel.org>
 <CAGqnWRYWVd8JcVbdd289LaDusMUcgydFLmViHGjX4GQ83BJ6HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGqnWRYWVd8JcVbdd289LaDusMUcgydFLmViHGjX4GQ83BJ6HA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

what does this mean?

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

So what?

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

You are still changing the "lifetimes" thing presumably? why is that
not a problem here?


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


