Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAC6C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62oO-0000qH-3k; Mon, 14 Sep 2026 05:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x62oI-0000ov-LU
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:17:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x62oF-0006CL-B1
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789377424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8aDrc3Q2MSD+jjlh/G8W7XjtNbahufiafhXwtdVy2YM=;
 b=J9HFzi3DGNE46b8dYUYS9YKOBqctIs5vlHJWEsmyExf0eV740bypQwFD2mKU44zVw5Bnri
 aHtIOMUsXsuAzDthOErnXz7p3QTOXYfo80+Yy6kdPmmgz+5opqpFQiJRc7WHeY8CexZeCg
 uH7qKNxS19YRgN9BYknikuf9I3gjpE0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-5gTBYLKjOAqqh3ukC6y6Yg-1; Mon, 14 Sep 2026 05:17:03 -0400
X-MC-Unique: 5gTBYLKjOAqqh3ukC6y6Yg-1
X-Mimecast-MFC-AGG-ID: 5gTBYLKjOAqqh3ukC6y6Yg_1789377422
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49cd83ca361so28687295e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 02:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789377422; x=1789982222; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8aDrc3Q2MSD+jjlh/G8W7XjtNbahufiafhXwtdVy2YM=;
 b=sJ0gpvFKYsbf6f+R2hj8NdcppEKlozhk+56t8lJZteJXHIvId9h/Tc5vv3mE8Ycrig
 g92IoNOhVNUgIOYg90/tY+yX6pbMqeE225LYrMiphqPYSkA5DkOlvos9LodZ4iEnB87O
 +oTzL6o7iaP1a11pgxlHR+KopkGtLzb6O2e9McSxk3HMMkzR86AP1Em9zhvbzm8vNQX3
 /4qA9C6CREz7UaNAHup8lbTMNjmq3L/LJ2+fCUkTUhJ73Yu2RBDSEG8kyYbPeb+skQrl
 LtMBo2zn924ghLdGFNFM0fFOzbGmrb6+wv44upWtXtRJumFUXUNzNvR9iD0B4BVDmFUo
 FxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789377422; x=1789982222;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8aDrc3Q2MSD+jjlh/G8W7XjtNbahufiafhXwtdVy2YM=;
 b=UsYMsirALE01lDb9GIyN5JIp7cjry6xkKUUsVPEKbaFex41VF6c56sxR5lIKEh8BHk
 bXinGu6orwP8JzsREkCy68V8J0yJNijn3/bipE1ae9sbc/pe+m6aShzLf3ErvTbb/13f
 3CgS+pykGj+o6r4V2iJfEOmtP70mgDkI+D2UyD+DrjXxFGM6leF6qrmKY1cHhCGIdi+t
 qGmzkbaVZv9iwd3R2/OxrpEIbx9bwrWSR+1wMu9maMhUna6fIA96xWglv3kRr8L8/fac
 Gb0RbXvYt13jYRt5a+7ZkwMCW6ZKnZNInEtH2PZ/Gru6sHZAEDEzkwW1Wngb3mj+AC81
 x8hg==
X-Gm-Message-State: AFuF++lOzOGSUSRo924LPn5rOP0syKIsF7WZju/hqjOxrDOJNdplZhk/
 i3q46GUYxWhdDle0/mV4wt4+aDilJf3pTKcYWjrWwh7e8GZeClv6ONu++2M6czNCEYBN0BKIWc+
 5ha57QCwkLCHyc0czGXfpQfxJ8ZVE4O6l4I0WLTwzgmhiJzSycAmHJj6W
X-Gm-Gg: AYBFou3Vt34K9xypWZug660/XkWODdf901GDDjD4XCUGfLrQ7Sp5qV1a/qt9VtrkKsC
 FrSUXsr2FPtxv8vElFG1Zi3H1AJnY6fb6BVu22vGrkmFxcCDaTZtB289km7HsETWWhQPBT1FhpE
 GxwSE1ziewGiorp5ujShjsGDhKVyNnfCFL4CV6qJo271pUzkDG4Lh8E6GtPg7lvOvsRqAugyRZK
 wQ8hKxdfT+X4Qdl8DiVhTr1dLu+YmFi59mp00bg8Lm7CZ9jJMsZ1bBkDMlAhNttcSGXWk+1eGjF
 TNKnNnx4xjm9Vxdq8JFniivnkHsX0R5rBf4Mrp+WRJdlP6DMhROH15aTqD23HYWUbtblk6BCMe+
 IRPMPuSrKri8OKFgxGQsZ/GM=
X-Received: by 2002:a05:600c:1546:b0:49c:fc6c:be0d with SMTP id
 5b1f17b1804b1-49e7a685a0cmr17754925e9.19.1789377421521; 
 Mon, 14 Sep 2026 02:17:01 -0700 (PDT)
X-Received: by 2002:a05:600c:1546:b0:49c:fc6c:be0d with SMTP id
 5b1f17b1804b1-49e7a685a0cmr17754425e9.19.1789377420915; 
 Mon, 14 Sep 2026 02:17:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e63c9a7c9sm507577375e9.13.2026.09.14.02.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 02:17:00 -0700 (PDT)
Date: Mon, 14 Sep 2026 05:16:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org
Subject: Re: [PULL v2 01/75] virtio: fix exit(1) on DMA mapping failure
 during migration restore
Message-ID: <20260914051629-mutt-send-email-mst@kernel.org>
References: <cover.1789117222.git.mst@redhat.com>
 <5ec2a0b21fe5b8e1419a94a753636088d6b0409b.1789117222.git.mst@redhat.com>
 <CAFEAcA9sG8ijHjbJ6g8m0JZfpkAQ_Ow_Qxd2ep8Lui2Qe2L7hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9sG8ijHjbJ6g8m0JZfpkAQ_Ow_Qxd2ep8Lui2Qe2L7hQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 14, 2026 at 09:47:30AM +0100, Peter Maydell wrote:
> On Fri, 11 Sept 2026 at 10:01, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > When QEMU restores pending virtio requests from a migration stream, it
> > calls qemu_get_virtqueue_element(), which calls virtqueue_map() and
> > virtqueue_map_iovec() to re-map the saved DMA fragment addresses into
> > the destination address space.  If the addresses in the migration stream
> > are corrupted, and as a result dma_memory_map() returns NULL or a
> > shorter-than-expected length, virtqueue_map_iovec() calls exit(1),
> > terminating the destination QEMU process instead of failing the
> > migration cleanly.
> >
> > Convert virtqueue_map_iovec() and virtqueue_map() from void to bool.
> > On failure, virtqueue_map_iovec() unmaps any entries it has already
> > mapped and returns false; virtqueue_map() similarly cleans up the in_sg
> > entries if out_sg mapping fails.  qemu_get_virtqueue_element() now
> > checks the return value, frees the element and returns NULL on failure,
> > allowing the migration restore path to propagate a clean error.  The
> > callers in virtio-blk, virtio-serial-bus and virtio-scsi that invoke
> > qemu_get_virtqueue_element() during load are updated to check for NULL
> > and return an error code.
> >
> 
> Hi; Coverity points out an error in the error handling code
> added here (CID 1686764):
> 
> > -static void virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
> > +static bool virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
> >                                  hwaddr *addr, unsigned int num_sg,
> >                                  bool is_write)
> >  {
> >      unsigned int i;
> >      hwaddr len;
> > +    DMADirection dir = is_write ? DMA_DIRECTION_FROM_DEVICE :
> > +                                 DMA_DIRECTION_TO_DEVICE;
> >
> >      for (i = 0; i < num_sg; i++) {
> >          len = sg[i].iov_len;
> > -        sg[i].iov_base = dma_memory_map(vdev->dma_as,
> > -                                        addr[i], &len, is_write ?
> > -                                        DMA_DIRECTION_FROM_DEVICE :
> > -                                        DMA_DIRECTION_TO_DEVICE,
> > -                                        MEMTXATTRS_UNSPECIFIED);
> > +        sg[i].iov_base = dma_memory_map(vdev->dma_as, addr[i], &len,
> > +                                        dir, MEMTXATTRS_UNSPECIFIED);
> >          if (!sg[i].iov_base) {
> >              error_report("virtio: error trying to map MMIO memory");
> > -            exit(1);
> > +            goto err_undo_map;
> 
> If dma_memory_map() fails on the first iteration, we will jump
> to err_undo_map, with i == 0....
> 
> >          }
> >          if (len != sg[i].iov_len) {
> >              error_report("virtio: unexpected memory split");
> > -            exit(1);
> > +            dma_memory_unmap(vdev->dma_as, sg[i].iov_base, len, dir, 0);
> > +            goto err_undo_map;
> >          }
> >      }
> > +    return true;
> > +
> > +err_undo_map:
> > +    while (i-- > 0) {
> 
> ...but since 'i' is an unsigned type, that will mean that "i--"
> here underflows to an extremely large value. This loop will
> then iterate many times unmapping random things.


I apologize, since when is 0 > 0 true?


> > +        dma_memory_unmap(vdev->dma_as, sg[i].iov_base, sg[i].iov_len,
> > +                         dir, 0);
> > +    }
> > +    return false;
> >  }
> 
> thanks
> -- PMM


