Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7D8C3601E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 09:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0H8Z-0006Lq-HX; Thu, 03 Apr 2025 05:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1u0H8Y-0006L2-5V; Thu, 03 Apr 2025 05:45:26 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1u0H8W-0003TS-3O; Thu, 03 Apr 2025 05:45:25 -0400
Received: from movement by movementarian.org with local (Exim 4.95)
 (envelope-from <movement@movementarian.org>) id 1u0H8T-005pRl-HG;
 Thu, 03 Apr 2025 10:45:21 +0100
Date: Thu, 3 Apr 2025 10:45:21 +0100
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
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v8 03/28] vfio/container: support VFIO_DMA_UNMAP_FLAG_ALL
Message-ID: <Z+5YsQ0kWIuMpMic@movementarian.org>
References: <20250219144858.266455-1-john.levon@nutanix.com>
 <20250219144858.266455-4-john.levon@nutanix.com>
 <7aee0391-256c-40dc-a2a1-328065d6dd08@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7aee0391-256c-40dc-a2a1-328065d6dd08@redhat.com>
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

On Wed, Apr 02, 2025 at 06:49:50PM +0200, Cédric Le Goater wrote:

> On 2/19/25 15:48, John Levon wrote:
> > Some containers can directly implement unmapping all regions;
> > add a new flag to support this.
> > 
> > Originally-by: John Johnson <john.g.johnson@oracle.com>
> > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > Signed-off-by: John Levon <john.levon@nutanix.com>
> > ---
> >   hw/vfio/common.c                      | 24 +++++++----------
> >   hw/vfio/container-base.c              |  4 +--
> >   hw/vfio/container.c                   | 38 +++++++++++++++++++++++++--
> >   hw/vfio/iommufd.c                     | 19 +++++++++++++-
> >   include/hw/vfio/vfio-common.h         |  1 +
> >   include/hw/vfio/vfio-container-base.h |  4 +--
> >   6 files changed, 68 insertions(+), 22 deletions(-)
> 
> This is difficult to understand. There are no functional changes right ?

+    ret = ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL);

This is new, we previously never even tried to use this.

> I think it should be broken down further to clarify the changes.

patch 1: add a flags param to the callbacks, always zero
patch 2: pass through unmap all flag to callbacks
patch 3: check for unmap_all extension and use it

That sound better?

regards
john

