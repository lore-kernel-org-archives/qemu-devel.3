Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B002C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4IPA-0004vw-2X; Wed, 09 Sep 2026 09:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4IP6-0004uT-O9
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 09:31:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4IP4-00057U-2T
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 09:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788960712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RfnX1Lb9f3lnYlDI/LMHdWU0GvgM7cujLI/MCOvwsAg=;
 b=AKnHFozXbu/jsKt37+V5JMPJ1Skt+PRZr8glObUG0CJCeyPOqhCkwq3F3C81QE+49tynjF
 UkOAqxFzfLXvbo6R0Amalwy2s4U5GiNkINGZ5BdQvZonVoaDF9uZfKd6ueZM9zKe4KE7/e
 SEjJIgzX/bpEc5h0XRSNS87IznDjBJ4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-3MWOXNhvM_-MeNjnew1VkQ-1; Wed, 09 Sep 2026 09:31:50 -0400
X-MC-Unique: 3MWOXNhvM_-MeNjnew1VkQ-1
X-Mimecast-MFC-AGG-ID: 3MWOXNhvM_-MeNjnew1VkQ_1788960709
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3a58e0ec77eso673261fa.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 06:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788960709; x=1789565509; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RfnX1Lb9f3lnYlDI/LMHdWU0GvgM7cujLI/MCOvwsAg=;
 b=qkJULm6usXV9s/g1xCrNRqJXBZhlHWHqdd/baktgzMDJWDbS/zRR0uyQ+phn5SDwYZ
 WdcjkiCvW+0eZNW85BiE3Gbh06gghPswchHnwIg/lsROszoiCy7df5frkWRvavOuJTOn
 2d9+x091DBog8LEwnI2Fp0Jz+R7A9jIPoSlQqGJAzTBzwkk50HRgHxbw38YP5qlc+WVW
 ++9GtK+HE2nONQ4xAkt41vCm5D/8fbn41Eg8OEEhQxtfn7SSmrYDlx+6GTCJzX95owP0
 N0xexdiRnrbR4lRxP3eCPNMDMv265KJmNv1wTCPQKBYq148fq7IPblPQyg1rIEcdVm9f
 yx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788960709; x=1789565509;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RfnX1Lb9f3lnYlDI/LMHdWU0GvgM7cujLI/MCOvwsAg=;
 b=hK8kOA0wfPUMCook5t2sEbTsuWcrJ/OWZk/jagn1yZgY1euohlfZW6/DuyYQdsaTF6
 9Kyk2WRMNneNQyUCBnO4I18lueFx6s387oQXdzAbu6wFY7P6PsQrvZF28Cdb1R1cCm4q
 qeP05rK59ihawcw014XHLbn+Z2mKcSBeVd9Bxbu35WPoZFslAycMfaActQZQVcwd0jVX
 an06w9dr+sqweBnMChwSUZ0xIiqgh9GXMuGj4n7Kk9QLOfXeKWdtu5BJA477yQdW3tFj
 4IMOfV8eeZEWSItTnoE6i5aJ1iS6aEyMAHfi8Ds9DaxV6S35fHUbpi44q9aYDBBOvGZ2
 ogww==
X-Gm-Message-State: AFuF++m4iFzTCszyymLwdjt1HXsLr5VSL4o4OiJAi9DDfL+k/qOlRIVl
 a33sHCcQSzuv4BKfIF1uJnzfof/Vek6fmOj6qyiELk5vxAMgY1A+xwyMfEjM2Dh5vT23YOep/qA
 m7l6hA38E9hyn1xaFvB7M6mnTkPwJkQpx0SjQFNg5h9tgQaHAmmUpLY1a
X-Gm-Gg: AYBFou0zpH76FMOdAjqw7d3Nu4gW5mtKrLb5MrOsm4kMG5l/ORyoed7xUBmbuEJnoWt
 sdfI+6JfLQYR487DOiyHMD/6Ny6CnwUXU6eSiO0XZLlZU3qm1IIKHB5Ok2K3f8eJpBMGmmL3HQp
 EbwtGGhez6KrHRjH0GIP1hpeVyVzx/lC3+aRMu/VLMBj7dpH/TYitXBwNPvBHJ011CnlJgG6RdV
 29sDSO9NxrfwQtbjRQgkqHjZPBW1lLls2t7lxX+5zNVykvxJ9SARA8TI+mc8K7q/L7gXLDDi/RK
 Z/Sc/nB1CehHLuxEzFENlt+tNt/7UUgMVv1m/YWeJqnNHz+RkX6LcVatEwP/nIOh5tih2/TQCQn
 L9BfcT45PecYO6VoZ1Kq44tE=
X-Received: by 2002:a05:651c:a205:10b0:3a3:74b9:8a7d with SMTP id
 38308e7fff4ca-3a374b98b34mr22615901fa.22.1788960708778; 
 Wed, 09 Sep 2026 06:31:48 -0700 (PDT)
X-Received: by 2002:a05:651c:a205:10b0:3a3:74b9:8a7d with SMTP id
 38308e7fff4ca-3a374b98b34mr22615791fa.22.1788960708150; 
 Wed, 09 Sep 2026 06:31:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a3705cd8d5sm41844261fa.37.2026.09.09.06.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 06:31:47 -0700 (PDT)
Date: Wed, 9 Sep 2026 09:31:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Fishman <afishman@redhat.com>
Cc: qemu-devel@nongnu.org, sgarzare@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH v1 1/2] vhost: coalesce unmergeable sections across vring
 boundaries
Message-ID: <20260909092938-mutt-send-email-mst@kernel.org>
References: <20260909125923.75340-1-afishman@redhat.com>
 <20260909125923.75340-2-afishman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909125923.75340-2-afishman@redhat.com>
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

On Wed, Sep 09, 2026 at 03:59:22PM +0300, Alex Fishman wrote:
> Virtio-mem dynamic memslots are marked unmergeable so listeners can
> track their lifetimes independently. A vring part crossing the boundary
> between two such slots consequently cannot be contained in a single
> vhost memory region.
> 
> Coalesce adjacent unmergeable sections only when a descriptor table,
> available ring, or used ring spans their boundary and the sections
> preserve a coherent GPA-to-HVA translation. Keep unrelated slots
> separate so activating them does not reshape the region containing the
> vring.


I don't get what does it have to do with vrings. If merging them like
this is ok, then it's always ok?

> 
> Fixes: 533f5d667909 ("memory,vhost: Allow for marking memory device memory regions unmergeable")
> 
> Buglink: https://redhat.atlassian.net/browse/RHEL-146583
> 
> Signed-off-by: Alex Fishman <afishman@redhat.com>


No empty lines between trailers,please.

> ---
>  hw/virtio/vhost.c | 72 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 67 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 371dca17dd..76910e2628 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -796,6 +796,70 @@ out:
>      g_free(old_sections);
>  }
>  
> +static bool vhost_vring_part_crosses_boundary(uint64_t ring_gpa,
> +                                              uint64_t ring_size,
> +                                              uint64_t boundary)
> +{
> +    return ring_size && ring_gpa < boundary &&
> +           range_get_last(ring_gpa, ring_size) >= boundary;
> +}
> +
> +static bool vhost_vring_crosses_boundary(struct vhost_dev *dev,
> +                                         uint64_t boundary)
> +{
> +    int i;
> +
> +    if (vhost_dev_has_iommu(dev)) {
> +        return false;
> +    }
> +
> +    for (i = 0; i < dev->nvqs; i++) {
> +        struct vhost_virtqueue *vq = &dev->vqs[i];
> +
> +        if (vhost_vring_part_crosses_boundary(vq->desc_phys, vq->desc_size,
> +                                              boundary) ||
> +            vhost_vring_part_crosses_boundary(vq->avail_phys, vq->avail_size,
> +                                              boundary) ||
> +            vhost_vring_part_crosses_boundary(vq->used_phys, vq->used_size,
> +                                              boundary)) {
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +static bool vhost_sections_can_merge(struct vhost_dev *dev,
> +                                     const MemoryRegionSection *prev_sec,
> +                                     const MemoryRegionSection *section,
> +                                     uint64_t section_gpa,
> +                                     uintptr_t section_host)
> +{
> +    uint64_t prev_gpa_start = prev_sec->offset_within_address_space;
> +    uintptr_t prev_host_start =
> +        (uintptr_t)memory_region_get_ram_ptr(prev_sec->mr) +
> +        prev_sec->offset_within_region;
> +    uint64_t offset;
> +
> +    if (section->mr != prev_sec->mr || section_gpa < prev_gpa_start) {
> +        return false;
> +    }
> +
> +    offset = section_gpa - prev_gpa_start;
> +
> +    if (prev_host_start + offset != section_host) {
> +        return false;
> +    }
> +
> +    if (!prev_sec->unmergeable && !section->unmergeable) {
> +        return true;
> +    }
> +
> +    /* Only override an unmergeable boundary when a ring part spans it. */
> +    return vhost_vring_crosses_boundary(
> +        dev, section->offset_within_address_space);
> +}
> +
>  /* Adds the section data to the tmp_section structure.
>   * It relies on the listener calling us in memory address order
>   * and for each region (via the _add and _nop methods) to
> @@ -833,7 +897,7 @@ static void vhost_region_add_section(struct vhost_dev *dev,
>                                                 mrs_size, mrs_host);
>      }
>  
> -    if (dev->n_tmp_sections && !section->unmergeable) {
> +    if (dev->n_tmp_sections) {
>          /* Since we already have at least one section, lets see if
>           * this extends it; since we're scanning in order, we only
>           * have to look at the last one, and the FlatView that calls
> @@ -862,11 +926,9 @@ static void vhost_region_add_section(struct vhost_dev *dev,
>                  /* A way to cleanly fail here would be better */
>                  return;
>              }
> -            /* Offset from the start of the previous GPA to this GPA */
> -            size_t offset = mrs_gpa - prev_gpa_start;
>  
> -            if (prev_host_start + offset == mrs_host &&
> -                section->mr == prev_sec->mr && !prev_sec->unmergeable) {
> +            if (vhost_sections_can_merge(dev, prev_sec, section,
> +                                         mrs_gpa, mrs_host)) {
>                  uint64_t max_end = MAX(prev_host_end, mrs_host + mrs_size);
>                  need_add = false;
>                  prev_sec->offset_within_address_space =






> -- 
> 2.52.0


