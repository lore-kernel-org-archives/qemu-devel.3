Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37149C5B549
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 19:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLo1n-0001BL-NV; Sun, 01 Jun 2025 15:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLo1k-0001B9-W5
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 15:07:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLo1i-0008Ls-OG
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 15:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748804840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hzi8BzaQpU2H8PE4l2A++Hh6+qmvJmyb19nE2w5CDg8=;
 b=h8HWISjnmzyIxw/oBC7TTSyEFWuTz1AYuq30CMsXnTv2idRDhTzCg9KAz+jh9THykbqlM0
 9kjt1fCTqO5t8PpBFRJZvrLZfXD3599d/P7kxL8QGcmThvNQ7Rl5rtITNMTHrNFxwgKgz1
 kgKjH2NPD1eGmJGrPwFAl+amxWq+gCI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-G8Al_Cq8NXi7I4_d4P00XA-1; Sun, 01 Jun 2025 15:07:19 -0400
X-MC-Unique: G8Al_Cq8NXi7I4_d4P00XA-1
X-Mimecast-MFC-AGG-ID: G8Al_Cq8NXi7I4_d4P00XA_1748804838
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f65a705dso2307160f8f.2
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 12:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748804837; x=1749409637;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hzi8BzaQpU2H8PE4l2A++Hh6+qmvJmyb19nE2w5CDg8=;
 b=OHjIKz3tg5eoBgWRvZKGL0gueb5rxtPWhhddlDHQxFBTVHlniAoWW6NiZ5qqYWrySz
 LzV9VDu5d+fWrL/lKvf7bLSaq+PDwfjlNFxf9+T7suupL4RuPCBdJkstC22Cetozz2WY
 CMNpeMGzOZldYUTr/vvGYByFiGQ+6RdieuA8gMVkDFUQZOOrI706GcbbiHi7nWtAdKGk
 X45jRgCdAuJ3OlTn316M29ZM1dCnhzPRfnvHExBxRYw/MtjLNfW/p2drcXp7bCvVhlL6
 J+9tMetQff+/h6agHcgXws3U5UwJDSHIbtjqLUOofbyrF5q04Z+B4aWtIzNG8mPXinjg
 pAJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6UTneoNcvETTNsZyNzWGqZ12fImkBMTpkEitNunLDSxHUxHALCBRMKGvTg7RtFHruiqdO8w3ZOTug@nongnu.org
X-Gm-Message-State: AOJu0YwhbYTT6nuaaaINtGb9nDEX3N1D/ysUZiIM0PUlxzVdKOIyMlCY
 FqA4UAGdTidQzU32ISm1nCjvIbZSnwLVxHaMaJXYfL5Y6TrTYyYRjg43b2vOYoW/X4yhd+H8V/I
 wTezS4pdTa4IS0Zqgxkeszpi0+yRd0IHXTH2aVxXoWc3eI8SWdFp1w+yUTk6TSLy4
X-Gm-Gg: ASbGncvNfVg64XuGTi+vDIzqrNIWpcVDZW+Cfc3a2WCvpcKP9GX2fBD7LyuQmOLOc4h
 zmrN7qehz5CODYaYMmcX8EERLylkTUwIzxvTp+v38DBMNIimaXqV25F7rrYOp+XK8MREslp2mJ5
 va0WmJTTAx9+QNwMLVRL52iMgOdqXj1HuW4USHQM+XVu7NAyw9CdOs1Hc2ztM7pTo3Ax+jfrp3T
 jjk4KgGmtb0aeQ05MciesFl7uV4uQfke/IcwC1WCNVb8Cq2shkL1XEJj0VJDlDFCKhOqgN7It+S
 A+1EhA==
X-Received: by 2002:a05:6000:1aca:b0:3a4:fa09:d13b with SMTP id
 ffacd0b85a97d-3a4fe3a7dccmr4647347f8f.59.1748804836810; 
 Sun, 01 Jun 2025 12:07:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBvQ1ZDheJ+cTSTB5MmmU+maPQh9mQ7OL+LNlU8FoxFKfz3gMvNYR2/9ZKxuLujfILo/ZV1w==
X-Received: by 2002:a05:600c:470c:b0:450:cfe1:a827 with SMTP id
 5b1f17b1804b1-45126573571mr49491545e9.31.1748804825729; 
 Sun, 01 Jun 2025 12:07:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f8f1basm95349345e9.6.2025.06.01.12.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 12:07:05 -0700 (PDT)
Date: Sun, 1 Jun 2025 15:07:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V4 16/43] pci: skip reset during cpr
Message-ID: <20250601150607-mutt-send-email-mst@kernel.org>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-17-git-send-email-steven.sistare@oracle.com>
 <d62bd9c6-1660-4d16-8d7d-5445ba6c5031@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d62bd9c6-1660-4d16-8d7d-5445ba6c5031@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Jun 01, 2025 at 06:38:43PM +0200, Cédric Le Goater wrote:
> On 5/29/25 21:24, Steve Sistare wrote:
> > Do not reset a vfio-pci device during CPR.
> > 
> > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > ---
> >   include/hw/pci/pci_device.h | 3 +++
> >   hw/pci/pci.c                | 5 +++++
> >   hw/vfio/pci.c               | 7 +++++++
> >   3 files changed, 15 insertions(+)
> > 
> > diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> > index e41d95b..b481c5d 100644
> > --- a/include/hw/pci/pci_device.h
> > +++ b/include/hw/pci/pci_device.h
> > @@ -181,6 +181,9 @@ struct PCIDevice {
> >       uint32_t max_bounce_buffer_size;
> >       char *sriov_pf;
> > +
> > +    /* CPR */
> > +    bool skip_reset_on_cpr;
> >   };
> >   static inline int pci_intx(PCIDevice *pci_dev)
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index f5ab510..21eb11c 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -32,6 +32,7 @@
> >   #include "hw/pci/pci_host.h"
> >   #include "hw/qdev-properties.h"
> >   #include "hw/qdev-properties-system.h"
> > +#include "migration/cpr.h"
> >   #include "migration/qemu-file-types.h"
> >   #include "migration/vmstate.h"
> >   #include "net/net.h"
> > @@ -531,6 +532,10 @@ static void pci_reset_regions(PCIDevice *dev)
> >   static void pci_do_device_reset(PCIDevice *dev)
> >   {
> > +    if (dev->skip_reset_on_cpr && cpr_is_incoming()) {
> > +        return;
> > +    }
> 
> Since ->skip_reset_on_cpr is only true for vfio-pci devices, it could be
> replaced by : object_dynamic_cast(OBJECT(dev), "vfio-pci")
> 
> Thanks,
> 
> C.

True but I don't really like driver dependent hacks.
what exactly about vfio makes it survive without this reset?

> 
> > +
> >       pci_device_deassert_intx(dev);
> >       assert(dev->irq_state == 0);
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index 7d3b9ff..56e7fdd 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -3402,6 +3402,13 @@ static void vfio_instance_init(Object *obj)
> >       /* QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
> >        * line, therefore, no need to wait to realize like other devices */
> >       pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
> > +
> > +    /*
> > +     * A device that is resuming for cpr is already configured, so do not
> > +     * reset it during qemu_system_reset prior to cpr load, else interrupts
> > +     * may be lost.
> > +     */
> > +    pci_dev->skip_reset_on_cpr = true;
> >   }>     static void vfio_pci_base_dev_class_init(ObjectClass *klass,
> > const void *data)


