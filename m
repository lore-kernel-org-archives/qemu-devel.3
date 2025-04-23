Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5960DC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 17:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7dj9-0007e9-MC; Wed, 23 Apr 2025 13:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1u7dj8-0007cc-IM; Wed, 23 Apr 2025 13:17:38 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1u7dj6-0000L3-T2; Wed, 23 Apr 2025 13:17:38 -0400
Received: from movement by movementarian.org with local (Exim 4.97)
 (envelope-from <movement@movementarian.org>)
 id 1u7diz-00000000GPP-2yKx; Wed, 23 Apr 2025 18:17:29 +0100
Date: Wed, 23 Apr 2025 18:17:29 +0100
From: John Levon <levon@movementarian.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH 07/14] vfio: specify VFIO_DMA_UNMAP_FLAG_ALL to callback
Message-ID: <aAkgqXP1NjCfwKbG@movementarian.org>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-8-john.levon@nutanix.com>
 <3cc6ed06-7ee4-42f4-a09e-03d8fe922537@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3cc6ed06-7ee4-42f4-a09e-03d8fe922537@redhat.com>
X-Url: http://www.movementarian.org/
Received-SPF: pass client-ip=139.162.205.133;
 envelope-from=movement@movementarian.org; helo=movementarian.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 23, 2025 at 07:01:23PM +0200, Cédric Le Goater wrote:

> On 4/9/25 15:48, John Levon wrote:
> > Use the new flags parameter to indicate when we want to unmap
> > everything; no functional change is intended.
> 
> I find these changes confusing. Most likely there are not well presented
> or I am missing something. Some more below.

I don't see any way to further break up the change unfortunately.

> > +/*
> > + * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
> > + */
> > +static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
> > +                                 hwaddr iova, ram_addr_t size,
> > +                                 IOMMUTLBEntry *iotlb, int flags)
> > +{
> > +    int ret;
> > +
> > +    if ((flags & ~(VFIO_DMA_UNMAP_FLAG_ALL)) != 0) {
> 
> VFIO_DMA_UNMAP_FLAG_ALL is a kernel uapi flag. It should be used only with
> the corresponding ioctl(VFIO_IOMMU_UNMAP_DMA) and not internally between
> QEMU routines.

Happy to use a different define for the flags if you like, but surely it's
better to have a flags field so it's extendable and it's always clear what the
meaning is? Problem with a boolean is you just see "true" or "false" in the
caller and have no real idea what it means until you look it up.

> I think adding a 'bool unmap_all' paremeter to vfio_legacy_dma_unmap() would
> make more sense.

Having said that I'm OK with going back to just a simple boolean if you'd really
prefer.

> >           }
> > -        ret = vfio_container_dma_unmap(bcontainer, iova,
> > -                                       int128_get64(llsize), NULL, 0);
> > +        ret = vfio_container_dma_unmap(bcontainer, iova, int128_get64(llsize),
> > +                                       NULL, flags);
> 
> Why not unmap the halves here instead of in the backends ?

The whole point of the change is that right now the generic listener.c code has
a workaround that is specific to one particular backend. vfio-user doesn't have
any need to unmap in halves and in fact *has* to pass an "unmap all" flag.

In theory, neither does vfio if the flag is supported, but I dropped that patch
as I couldn't figure out a clean way to use it WRT the dirty tracking code.

regards
john

