Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B49C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 16:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0N0G-0006Et-2q; Thu, 03 Apr 2025 12:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1u0Mzy-00067N-HK; Thu, 03 Apr 2025 12:01:07 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1u0Mzw-0001fX-As; Thu, 03 Apr 2025 12:00:57 -0400
Received: from movement by movementarian.org with local (Exim 4.95)
 (envelope-from <movement@movementarian.org>) id 1u0Mzt-005wkW-76;
 Thu, 03 Apr 2025 17:00:53 +0100
Date: Thu, 3 Apr 2025 17:00:53 +0100
From: John Levon <levon@movementarian.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [PATCH v8 08/28] vfio: add region cache
Message-ID: <Z+6wtZAfSayf+CG1@movementarian.org>
References: <20250219144858.266455-1-john.levon@nutanix.com>
 <20250219144858.266455-9-john.levon@nutanix.com>
 <d0f99d52-4d8d-4b1e-9e83-ec39b5357a44@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0f99d52-4d8d-4b1e-9e83-ec39b5357a44@redhat.com>
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

On Thu, Apr 03, 2025 at 05:46:03PM +0200, Cédric Le Goater wrote:

> > +static void vfio_get_all_regions(VFIODevice *vbasedev)
> > +{
> > +    struct vfio_region_info *info;
> > +    int i;
> > +
> > +    for (i = 0; i < vbasedev->num_regions; i++) {
> > +        vfio_get_region_info(vbasedev, i, &info);
> > +    }
> > +}
> > +
> >   void vfio_prepare_device(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
> >                            VFIOGroup *group, struct vfio_device_info *info)
> >   {
> > @@ -1586,6 +1596,8 @@ void vfio_prepare_device(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
> >       }
> >       QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
> > +
> > +    vfio_get_all_regions(vbasedev);
> >   }

> > +    /* check cache */
> > +    if (vbasedev->regions[index] != NULL) {
> > +        *info = vbasedev->regions[index];
> > +        return 0;
> > +    }
> > +
> 
> why not populate vbasedev->regions[index] in vfio_get_all_regions() ?

Good question. I presume it's not possible for us to ever look up a region
that has somehow appeared *after* vfio_prepare_device() ?

We'd end up off the end of the array in that case anyway.

regards
john

