Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2F3C369A2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 13:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u29Jd-0006XS-PN; Tue, 08 Apr 2025 09:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1u29JX-0006T4-In; Tue, 08 Apr 2025 09:48:34 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1u29JS-0003CE-Ga; Tue, 08 Apr 2025 09:48:31 -0400
Received: from movement by movementarian.org with local (Exim 4.95)
 (envelope-from <movement@movementarian.org>) id 1u29JL-007ZZ1-DO;
 Tue, 08 Apr 2025 14:48:19 +0100
Date: Tue, 8 Apr 2025 14:48:19 +0100
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
Message-ID: <Z/UpI20CWedqo94y@movementarian.org>
References: <20250219144858.266455-1-john.levon@nutanix.com>
 <20250219144858.266455-9-john.levon@nutanix.com>
 <d0f99d52-4d8d-4b1e-9e83-ec39b5357a44@redhat.com>
 <Z+6wtZAfSayf+CG1@movementarian.org>
 <33a54cce-c9a3-4724-97ef-64ac6a96e5b7@redhat.com>
 <Z/AUXIyeZjUWwdPu@movementarian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z/AUXIyeZjUWwdPu@movementarian.org>
X-Url: http://www.movementarian.org/
Received-SPF: pass client-ip=139.162.205.133;
 envelope-from=movement@movementarian.org; helo=movementarian.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Apr 04, 2025 at 06:18:20PM +0100, John Levon wrote:

> On Fri, Apr 04, 2025 at 06:57:46PM +0200, Cédric Le Goater wrote:
> 
> > > > why not populate vbasedev->regions[index] in vfio_get_all_regions() ?
> > > 
> > > Good question. I presume it's not possible for us to ever look up a region
> > > that has somehow appeared *after* vfio_prepare_device() ?
> > > 
> > > We'd end up off the end of the array in that case anyway.
> > 
> > I was confused. I thought we were caching VFIORegions ...
> > 
> > Anyway, this is an optimisation and I fail to understand where
> > the VFIO_DEVICE_GET_REGION_INFO ioctl is called on a hot path.
> > 
> > Is it for interrupts ? Please explain.
> > 
> > Do you have figures ?
> 
> That's a great question that I don't know the answer to (like much of this code
> I just inherited it). Let me try to investigate.

I found one reason. hw/vfio/pci.c stores VFIOPCIDevice::config_offset so it
doesn't need to do a get region info on every config space access.

But after the refactoring, vfio_io_region_read() gets passed a region index (the
idea of a "region offset" isn't meaningful to vfio-user).

Without the cache, the kernel vfio implementation:

```
867 static int vfio_io_region_write(VFIODevice *vbasedev, uint8_t index, off_t off,  
868                                 uint32_t size, void *data, bool post)            
869 {                                                                                
870     struct vfio_region_info *info = vbasedev->regions[index];                    
871     int ret;                                                                     
872                                                                                  
873     ret = pwrite(vbasedev->fd, data, size, info->offset + off);                  
```

would have to look up the region offset every time.

regards
john

