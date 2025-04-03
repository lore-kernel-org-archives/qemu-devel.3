Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73903C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 09:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0GyG-0004jQ-7E; Thu, 03 Apr 2025 05:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1u0GyE-0004j0-GD; Thu, 03 Apr 2025 05:34:46 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1u0GyC-0001ZN-Q4; Thu, 03 Apr 2025 05:34:46 -0400
Received: from movement by movementarian.org with local (Exim 4.95)
 (envelope-from <movement@movementarian.org>) id 1u0Gy6-005pGz-Tt;
 Thu, 03 Apr 2025 10:34:38 +0100
Date: Thu, 3 Apr 2025 10:34:38 +0100
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
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v8 05/28] vfio: add vfio_prepare_device()
Message-ID: <Z+5WLqQRqrxSpNBV@movementarian.org>
References: <20250219144858.266455-1-john.levon@nutanix.com>
 <20250219144858.266455-6-john.levon@nutanix.com>
 <3369ecab-21ea-4198-9ffa-73307a795f69@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3369ecab-21ea-4198-9ffa-73307a795f69@redhat.com>
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

On Thu, Apr 03, 2025 at 11:19:34AM +0200, Cédric Le Goater wrote:

> On 2/19/25 15:48, John Levon wrote:
> > Commonize some initialization code shared by the legacy and iommufd vfio
> > implementations (and later by vfio-user).
> > 
> > Signed-off-by: John Levon <john.levon@nutanix.com>
> > ---
> >   hw/vfio/common.c              | 19 +++++++++++++++++++
> >   hw/vfio/container.c           | 14 +-------------
> >   hw/vfio/iommufd.c             |  9 +--------
> >   include/hw/vfio/vfio-common.h |  2 ++
> >   4 files changed, 23 insertions(+), 21 deletions(-)
> > 
> > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > index eefd735bc6..4434e0a0a2 100644
> > --- a/hw/vfio/common.c
> > +++ b/hw/vfio/common.c
> > @@ -1569,6 +1569,25 @@ retry:
> >       return info;
> >   }
> > +void vfio_prepare_device(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
> > +                         VFIOGroup *group, struct vfio_device_info *info)
> 
> I would prefer that the first version did not have a 'group' parameter.
> Let's add it when needed.

I think you mean something like this in hw/vfio/container.c:

vfio_prepare_device(vbasedev, &group->container->bcontainer, info);

vbasedev->group = group;
QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);

As it's the only consumer that actually wants a group.

thanks
john

