Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22610ECD9AA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 23:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo9AD-0002u3-Qb; Thu, 05 Feb 2026 18:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vo9AC-0002tt-Jt
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 18:53:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vo9A9-0000Yl-LO
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 18:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770335608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9j96w1HVtAqHFcBLjPoauX92yE9h75L0VrcshLwSxSk=;
 b=SqUdg1pDGBo50MAMrIia+wcb49Fr7p2h7NM5y6vmgpm6GfZCMiLctEiRotbk1lXkb57GoI
 oQBY/yuh2oUrfZucllX0x0OoS+ZOjlQImHdTdW+xkN42Fs5dgZ3DKrSPCnirnhCiFPNXiy
 4IuJgiaD6Y2ESF72++uXGLDizbfD1i0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-7CL4u3pCN7qXNnl0WlKQrQ-1; Thu, 05 Feb 2026 18:53:26 -0500
X-MC-Unique: 7CL4u3pCN7qXNnl0WlKQrQ-1
X-Mimecast-MFC-AGG-ID: 7CL4u3pCN7qXNnl0WlKQrQ_1770335605
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48071615686so18443515e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 15:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770335605; x=1770940405; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9j96w1HVtAqHFcBLjPoauX92yE9h75L0VrcshLwSxSk=;
 b=UFpdcTthNP2tmrty7FyVkF/RLN6ELeavRv5V5boBBg4dPFaKM/MFXwuUof1S4IkGW1
 e39Hg+IO7GqplwDcQjT1phlUrPlq9t7qAAswxEKheBOxzeC80i9dG5Ar4fWasOwsjjNz
 Z1TwAttDZ3GzUckDvI/kAMOoahDj3wR7+s8XvO9cRIDUcIIUG0TymbqEsIrmto+IgrNH
 QKwDg/XWpoASr2+7mVf1ijIO+wzpkDa442AdAmMF2wWiFllhDP+KbyXuAyOe0RQDkMw1
 LsgZKvDuGkZ8vGGUcdIrAtyGlkn+XwZSUOCWbkeQbkCF9Tgjy1HnD2tZI1oKtf3KUwPu
 /LVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770335605; x=1770940405;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9j96w1HVtAqHFcBLjPoauX92yE9h75L0VrcshLwSxSk=;
 b=dl6nYjHCiv+nAd3nmnR1gOX1/gZbkqEb5OSlIPIU4Gf+yCrEERx/6TlJ6WkC4+V2Iv
 0NbgRufDf+GyQPrNIGXn2MDI1v/Yf/e26s8NegrxoZDpfPWAhD1jPFxYCIDs1LOCIvJr
 mnH9S3K2LsRmzFAiVJOvjnbK2/TCKWxBtP90cNb7YMPms7+Wzr/0DFOmhfFsSY6NKFps
 yusTlsaOCU6Iw8Pwn5QsQRz9KUqflJob93vMKSRelRBaqTyyFdx+5SSJoREEaBk3/eSP
 FVb9Bd2weEXSrAyoGSdU4EpMMRWEhg9TofFv5LhQB/LbWoST524NzWHQZPaoA0+wimp6
 NnKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmJwgL16x7JdzKuxtF0aUc3RRGly6IqOwjFvbrgzSIO+QUY/fEOWQ6kYQjRSUSCQUSL99IA8Evgnyk@nongnu.org
X-Gm-Message-State: AOJu0YwoYqdq/15xx/NnGtliiN74MUbfHbt5Qtfd0ecYDJ+AsRFn2PQz
 Pz9tX9olAcYPAI5Bx7ABQGWSOgYqywqdGQGxNPIOHfWX3p9ncgj44oPQ5wqCGM+GoQY/DPRWErl
 4z5WZKD2kdpesjRiHP0OE82ObKopZO9YYfexElGpLIisSaarGC7NfT0Hk
X-Gm-Gg: AZuq6aIN3HfRax1CvYu0xarRIjmpPSYhfPjs6oHclRNnl+G2F+UAIsrfae91Vg7oy8R
 eXy9ZSLZq+53fYbGPKXTNacVHaxXURnRY9hkssV1F8Fl3JqrPdrG4wX10+12TBTBk4vdFi7YSW0
 Bl0Ga3cqb/PLArSGFaUDe5cALQZArHzwrn7SFQV7wwBQYzcQ8rYQspWBWlsQ2K49gIyQMxUAfms
 wzaJfvQ4ALSvvgBeRqJerc8VixH28oMdmj2ANnAbjvzTLgd6tXRjB04XP0uL3U76iJV7wMJPMpZ
 aJqLJazTqbVPM8gUUQqtwmQcVC/LIPAgaj5DnG6Z3niCp/uUtHJ03ofnwAs9hTc/1DeMBaCPKzE
 PjjIkvAe3RWXH9tfeXxUixwhM4gcQlNPrdQ==
X-Received: by 2002:a05:600c:19c7:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-483201db067mr15251545e9.1.1770335605244; 
 Thu, 05 Feb 2026 15:53:25 -0800 (PST)
X-Received: by 2002:a05:600c:19c7:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-483201db067mr15251335e9.1.1770335604805; 
 Thu, 05 Feb 2026 15:53:24 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296b2facsm1683016f8f.9.2026.02.05.15.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 15:53:24 -0800 (PST)
Date: Thu, 5 Feb 2026 18:53:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, jjherne@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
Subject: Re: [PATCH v3 11/14] pc-bios/s390-ccw: Add support for
 virtio-blk-pci IPL
Message-ID: <20260205185110-mutt-send-email-mst@kernel.org>
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-12-jrossi@linux.ibm.com>
 <62317e7b-c992-46cf-9df8-faad2fcc4b9c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62317e7b-c992-46cf-9df8-faad2fcc4b9c@linux.ibm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 05, 2026 at 03:43:10PM -0800, Farhan Ali wrote:
> <...snip...>
> 
> On 1/27/2026 8:15 AM, jrossi@linux.ibm.com wrote:
> > int virtio_pci_setup(VDev *vdev)
> > +{
> > +    VRing *vr;
> > +    int rc;
> > +    uint8_t status;
> > +    int i = 0;
> > +
> > +    vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
> > +    vdev->cmd_vr_idx = 0;
> > +
> > +    if (virtio_reset(vdev)) {
> > +        return -EIO;
> > +    }
> > +
> > +    status = VPCI_S_ACKNOWLEDGE;
> > +    if (virtio_pci_set_status(status)) {
> > +        puts("Virtio-pci device Failed to ACKNOWLEDGE");
> > +        return -EIO;
> > +    }
> > +
> > +    rc = virtio_pci_read_pci_cap_config();
> > +    if (rc) {
> > +        puts("Invalid virtio PCI capabilities");
> > +        return -EIO;
> > +    }
> > +
> > +    vdev->guest_features[1] = VIRTIO_F_VERSION_1;
> > +    if (virtio_pci_negotiate()) {
> > +        panic("Virtio feature negotation failed!");
> > +    }
> > +
> > +    switch (vdev->dev_type) {
> > +    case VIRTIO_ID_BLOCK:
> > +        vdev->nr_vqs = 1;
> > +        vdev->cmd_vr_idx = 0;
> > +        vdev->config.blk.blk_size = 0;
> > +        virtio_pci_get_blk_config();
> > +        break;
> > +    default:
> > +        puts("Unsupported virtio device");
> > +        return -ENODEV;
> > +    }
> > +
> > +    status |= VPCI_S_DRIVER;
> > +    rc = virtio_pci_set_status(status);
> > +    if (rc) {
> > +        puts("Set status failed");
> > +        return -EIO;
> > +    }
> > +
> > +    /* Configure virt-queues for pci */
> > +    for (i = 0; i < vdev->nr_vqs; i++) {
> > +        VqInfo info = {
> > +            .queue = (unsigned long long) virtio_get_ring_area(i),
> > +            .align = KVM_S390_VIRTIO_RING_ALIGN,
> > +            .index = i,
> > +            .num = 0,
> > +        };
> > +
> > +        vr = &vdev->vrings[i];
> > +
> > +        if (vpci_read_flex(VPCI_C_COMMON_NUMQ, c_cap.bar, &info.num, 2)) {
> > +            return -EIO;
> > +        }
> > +
> > +        vring_init(vr, &info);
> > +
> > +        if (vpci_set_selected_vq(vr->id)) {
> > +            puts("Failed to set selected virt-queue");
> > +            return -EIO;
> > +        }
> > +
> > +        if (vpci_set_queue_size(VIRTIO_RING_SIZE)) {
> > +            puts("Failed to set virt-queue size");
> > +            return -EIO;
> > +        }
> > +
> > +        rc = set_pci_vq_addr(VPCI_C_OFFSET_Q_DESCLO, vr->desc);
> > +        rc |= set_pci_vq_addr(VPCI_C_OFFSET_Q_AVAILLO, vr->avail);
> > +        rc |= set_pci_vq_addr(VPCI_C_OFFSET_Q_USEDLO, vr->used);
> > +        if (rc) {
> > +            puts("Failed to configure virt-queue address");
> > +            return -EIO;
> > +        }
> > +
> > +        if (vpci_set_queue_enable(true)) {
> > +            puts("Failed to set virt-queue enabled");
> > +            return -EIO;
> > +        }
> > +    }
> > +
> > +    status |= VPCI_S_FEATURES_OK | VPCI_S_DRIVER_OK;
> > +    return virtio_pci_set_status(status);
> 
> Should we also enable Bus master bit as part of the device setup? QEMU
> though has a workaround where if we have setup the ACKNOWLEDGE and DRIVER
> status flags set then it would enable the Bus master by default since older
> Linux virtio-pci drivers didn't do it (https://github.com/qemu/qemu/blob/cd5a79dc98e3087e7658e643bdbbb0baec77ac8a/hw/virtio/virtio-pci.c#L480-L487).
> But latest virtio-pci drivers seems to be doing the right thing, so not sure
> how long this workaround would be supported :) .
> 

Please do. linux 2.6.x is ancient and there's no guarantee we will keep
supporting this indefinitely.


> > +}
> > +
> 
> <..snip..>
> 
> 
> > diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.h
> > index 96c17ac3c7..883b00e0c6 100644
> > --- a/pc-bios/s390-ccw/virtio-pci.h
> > +++ b/pc-bios/s390-ccw/virtio-pci.h
> > @@ -71,6 +71,8 @@ typedef struct VirtioPciCap  VirtioPciCap;
> >   void virtio_pci_id2type(VDev *vdev, uint16_t device_id);
> >   int virtio_pci_reset(VDev *vdev);
> >   long virtio_pci_notify(int vq_id);
> > +int virtio_pci_setup(VDev *vdev);
> > +int virtio_pci_setup_device(void);
> >   int vpci_read_flex(uint64_t offset, uint8_t pcias, void *buf, int len);
> >   int vpci_read_bswap64(uint64_t offset, uint8_t pcias, uint64_t *buf);
> > diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> > index 956b34ff33..f65571a920 100644
> > --- a/pc-bios/s390-ccw/virtio.c
> > +++ b/pc-bios/s390-ccw/virtio.c
> > @@ -17,6 +17,7 @@
> >   #include "virtio.h"
> >   #include "virtio-scsi.h"
> >   #include "virtio-ccw.h"
> > +#include "virtio-pci.h"
> >   #include "bswap.h"
> >   #include "helper.h"
> >   #include "s390-time.h"
> > @@ -112,6 +113,8 @@ bool vring_notify(VRing *vr)
> >       case S390_IPL_TYPE_CCW:
> >           vr->cookie = virtio_ccw_notify(vdev.schid, vr->id, vr->cookie);
> >           break;
> > +    case S390_IPL_TYPE_PCI:
> > +        vr->cookie = virtio_pci_notify(vr->id);
> >       default:
> >           return 1;
> >       }
> > @@ -119,8 +122,43 @@ bool vring_notify(VRing *vr)
> >       return vr->cookie >= 0;
> >   }
> > +/*
> > + * Get endienness of the IPL type
> > + * Return true for s390x native big-endian
> > + */
> > +bool be_ipl(void)
> > +{
> > +    switch (virtio_get_device()->ipl_type) {
> > +    case S390_IPL_TYPE_QEMU_SCSI:
> > +    case S390_IPL_TYPE_CCW:
> > +        return true;
> > +    case S390_IPL_TYPE_PCI:
> > +        return false;
> > +    default:
> > +        return true;
> > +    }
> > +}
> > +
> > +/*
> > + * Format the virtio ring descriptor endianness
> > + * Return the available index increment in the appropriate endianness
> > + */
> > +static uint16_t vr_fmt_descriptor(VRingDesc *desc)
> > +{
> > +    if (!be_ipl()) {
> > +        desc->addr = bswap64(desc->addr);
> > +        desc->len = bswap32(desc->len);
> > +        desc->flags = bswap16(desc->flags);
> > +        desc->next = bswap16(desc->next);
> > +    }
> > +
> > +    return be_ipl() ? 1 : bswap16(1);
> > +}
> > +
> >   void vring_send_buf(VRing *vr, void *p, int len, int flags)
> >   {
> > +    uint16_t increment;
> > +
> >       /* For follow-up chains we need to keep the first entry point */
> >       if (!(flags & VRING_HIDDEN_IS_CHAIN)) {
> >           vr->avail->ring[vr->avail->idx % vr->num] = vr->next_idx;
> > @@ -131,11 +169,13 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags)
> >       vr->desc[vr->next_idx].flags = flags & ~VRING_HIDDEN_IS_CHAIN;
> >       vr->desc[vr->next_idx].next = vr->next_idx;
> >       vr->desc[vr->next_idx].next++;
> > +
> > +    increment = vr_fmt_descriptor(&vr->desc[vr->next_idx]);
> 
> If we are only returning 1 from the function vr_fmt_descriptor(), why not
> just set increment=1 or remove it completely and keep vr->avail->idx++? That
> way we don't need to do any endian conversion?
> 
> Thanks
> 
> Farhan
> 
> 
> >       vr->next_idx++;
> >       /* Chains only have a single ID */
> >       if (!(flags & VRING_DESC_F_NEXT)) {
> > -        vr->avail->idx++;
> > +        vr->avail->idx += increment;
> >       }
> >   }


