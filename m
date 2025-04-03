Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A29C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 09:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0H8R-0006E4-7d; Thu, 03 Apr 2025 05:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1u0H8H-00068g-Rz; Thu, 03 Apr 2025 05:45:10 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1u0H7u-0001x5-KU; Thu, 03 Apr 2025 05:45:09 -0400
Received: from movement by movementarian.org with local (Exim 4.95)
 (envelope-from <movement@movementarian.org>) id 1u0H2F-005pNP-5W;
 Thu, 03 Apr 2025 10:38:55 +0100
Date: Thu, 3 Apr 2025 10:38:55 +0100
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
Subject: Re: [PATCH v8 06/28] vfio: refactor out vfio_interrupt_setup()
Message-ID: <Z+5XL1Ou7iZ+TS/R@movementarian.org>
References: <20250219144858.266455-1-john.levon@nutanix.com>
 <20250219144858.266455-7-john.levon@nutanix.com>
 <d68a6f8a-9c8e-41e2-9290-ef041c0e10d2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d68a6f8a-9c8e-41e2-9290-ef041c0e10d2@redhat.com>
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

On Thu, Apr 03, 2025 at 11:23:09AM +0200, Cédric Le Goater wrote:

> On 2/19/25 15:48, John Levon wrote:
> > Refactor the interrupt setup code out of vfio_realize(), as we will
> > later need this for vfio-user too.
> > 
> > Signed-off-by: John Levon <john.levon@nutanix.com>
> >   static void vfio_realize(PCIDevice *pdev, Error **errp)
> >   {
> >       ERRP_GUARD();
> > @@ -3157,27 +3188,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
> >           }
> >       }
> > -    /* QEMU emulates all of MSI & MSIX */
> > -    if (pdev->cap_present & QEMU_PCI_CAP_MSIX) {
> > -        memset(vdev->emulated_config_bits + pdev->msix_cap, 0xff,
> > -               MSIX_CAP_LENGTH);
> > -    }
> > -
> > -    if (pdev->cap_present & QEMU_PCI_CAP_MSI) {
> > -        memset(vdev->emulated_config_bits + pdev->msi_cap, 0xff,
> > -               vdev->msi_cap_size);
> > -    }
> > -
> > -    if (vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1)) {
> > -        vdev->intx.mmap_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
> > -                                                  vfio_intx_mmap_enable, vdev);
> > -        pci_device_set_intx_routing_notifier(&vdev->pdev,
> > -                                             vfio_intx_routing_notifier);
> > -        vdev->irqchip_change_notifier.notify = vfio_irqchip_change;
> > -        kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
> > -        if (!vfio_intx_enable(vdev, errp)) {
> > -            goto out_deregister;
> > -        }
> > +    if (!vfio_interrupt_setup(vdev, errp)) {
> > +        goto out_teardown;
> 
> is that the correct exit label ?

Thanks, missed during rebase, it should be out_unset_idev

There is also a bug in the self-cleanup of vfio_interrupt_setup(): it's not
doing timer_free(vdev->intx.mmap_timer);

regards
john

