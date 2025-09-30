Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94484CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 16:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3cr0-0001Yc-6M; Tue, 30 Sep 2025 12:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3cqq-0001V6-SY
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 12:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3cqg-0006Ln-QZ
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 12:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759248300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZlhTY39ZFTvy+ACcQNOPkDtgjlTGiPLtUMGkljH0ZYI=;
 b=gPpBM9mTqRoFS+gxZw5USZes6dABUa2UaNzoShNvf8uQiYwN81w2WhFuasQUjpUDZzeA7Q
 yZXoQe/ok7nyz0cJwT4T6bPv/aCETP05RGY7n6U0njb/9tiVLvbOMI0J9vLgLZHAOtxvuS
 BFc+a+VxRHeyTqlC4xnxqx7EKY+Qxb8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-Tdsl3r4HNRWLQCUg92FRbw-1; Tue, 30 Sep 2025 12:04:58 -0400
X-MC-Unique: Tdsl3r4HNRWLQCUg92FRbw-1
X-Mimecast-MFC-AGG-ID: Tdsl3r4HNRWLQCUg92FRbw_1759248297
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-78f3a8ee4d8so111259216d6.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 09:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759248297; x=1759853097;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZlhTY39ZFTvy+ACcQNOPkDtgjlTGiPLtUMGkljH0ZYI=;
 b=tlGH6PaenBYxxLnrjd6embv3bagpb73BfSrZWcUS7ZYTgUviqNyD1qvj74Nf0MJGnE
 Wu3kXRPgbZSfl/gdlCk6mjYbwM9hqvNGZIbI4EcHXm9JvznH1kfxzMft1/OdHJtPU4dK
 RJGSojoFKQ/ZHvnsxKpho/Dgf04kN8AUuklLFmLpf8DWP0p5EIorW1g6iZZBJowNdnsN
 EwrCYX/FhPJpErP7Qhu1yR3WQnn4bMsl3ct3NqXBoMdnGiHWIaZYclhxALixgGn1zn+I
 Xvu2rw7h+YUhPmQip9Ap9v2d4nnTbg46KM2rYhYfRKo/Tu21LADDsAZ9jvtCLsCNFBQP
 cOXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVcoSN86Ud8y/9kU16Kn1DbC7pqlosdiUzAxqCDLUzKZxnCVpt8tNyo2tVT1xbKbJ889QrEycRCp3t@nongnu.org
X-Gm-Message-State: AOJu0YyGJcTuLWBTpkdwcDlO/c/rkcojdMRFsr7XNKZmNAtnfCKUoMp6
 pDD4ImTeI2ji8uGrJK1hE6CCg2f2OeasJmlhH3/ncGpAt/Fy51A3z2ghpp6hbrcWIAzCRquQa3K
 +wvmOTiPS+t/mpo4CN6K9pIUthU2JC1FgLA1sS0dLXR5DWkWFbfZ6y6wL
X-Gm-Gg: ASbGncv40P9YgBiZPfNXlw/hU2V52dWZhgVIPfjlQnaiyS0MAUsLyEe8uZyO+ewbg4E
 K7jdG3py/FwGBfTsI05tBKo+kMkUrsQ2lbMry8JRFpgTtNjcxQeh6L72l1cBdhKD3hZt0WxG5Fy
 PfrqV/Kv4ppnpCCcFwc2+fomk+zzvqQ43SEWrw416WgD3W7aL3d4vvRSyvvIphOUdoYZSCPMEkB
 w6qH8jC0njlDFKbAf/6tNPI0YNJy7XwEBwSpETbGzIebgRQZRaTnHUxRWY69CfKvtWQoHpZuGaa
 XxkVlgExXI9Ac7QfQbzjWhFD2mJm2fzV60XcHg==
X-Received: by 2002:ad4:5dce:0:b0:805:7dfb:2bd7 with SMTP id
 6a1803df08f44-873a9a79943mr5024576d6.63.1759248296898; 
 Tue, 30 Sep 2025 09:04:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJq95r/jNZdnkI+w3oh1CI5XEhmleBCIeuuI2YJlreeQD7aA9XZa4slQC+583OruvEbZxPMA==
X-Received: by 2002:ad4:5dce:0:b0:805:7dfb:2bd7 with SMTP id
 6a1803df08f44-873a9a79943mr5023546d6.63.1759248295962; 
 Tue, 30 Sep 2025 09:04:55 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-80166781d27sm98929496d6.45.2025.09.30.09.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 09:04:55 -0700 (PDT)
Date: Tue, 30 Sep 2025 12:04:53 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Yanfei Xu <yanfei.xu@bytedance.com>, mst@redhat.com,
 pbonzini@redhat.com, farosas@suse.de, qemu-devel@nongnu.org,
 shenyicong.1023@bytedance.com, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] migration: ensure APIC is loaded prior to VFIO PCI devices
Message-ID: <aNv_pQylwDRPJusi@x1.local>
References: <20250818131127.1021648-1-yanfei.xu@bytedance.com>
 <aNqrHBMKRp-9Qhw0@x1.local>
 <3553e934-f05e-4cab-bf1b-17c149dcfb59@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3553e934-f05e-4cab-bf1b-17c149dcfb59@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Sep 30, 2025 at 10:27:34AM +0200, Cédric Le Goater wrote:
> On 9/29/25 17:51, Peter Xu wrote:
> > On Mon, Aug 18, 2025 at 09:11:27PM +0800, Yanfei Xu wrote:
> > > The load procedure of VFIO PCI devices involves setting up IRT
> > > for each VFIO PCI devices. This requires determining whether an
> > > interrupt is single-destination interrupt to decide between
> > > Posted Interrupt(PI) or remapping mode for the IRTE. However,
> > > determining this may require accessing the VM's APIC registers.
> > > 
> > > For example:
> > > ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irqs)
> > >    ...
> > >      kvm_arch_irq_bypass_add_producer
> > >        kvm_x86_call(pi_update_irte)
> > >          vmx_pi_update_irte
> > >            kvm_intr_is_single_vcpu
> > > 
> > > If the LAPIC has not been loaded yet, interrupts will use remapping
> > > mode. To prevent the fallback of interrupt mode, keep APIC is always
> > > loaded prior to VFIO PCI devices.
> > > 
> > > Signed-off-by: Yicong Shen <shenyicong.1023@bytedance.com>
> > > Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
> > > ---
> > >   hw/intc/apic_common.c       | 1 +
> > >   include/migration/vmstate.h | 1 +
> > >   2 files changed, 2 insertions(+)
> > > 
> > > diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
> > > index 37a7a7019d..394fe02013 100644
> > > --- a/hw/intc/apic_common.c
> > > +++ b/hw/intc/apic_common.c
> > > @@ -379,6 +379,7 @@ static const VMStateDescription vmstate_apic_common = {
> > >       .pre_load = apic_pre_load,
> > >       .pre_save = apic_dispatch_pre_save,
> > >       .post_load = apic_dispatch_post_load,
> > > +    .priority = MIG_PRI_APIC,
> > >       .fields = (const VMStateField[]) {
> > >           VMSTATE_UINT32(apicbase, APICCommonState),
> > >           VMSTATE_UINT8(id, APICCommonState),
> > > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > > index 1ff7bd9ac4..22e988c5db 100644
> > > --- a/include/migration/vmstate.h
> > > +++ b/include/migration/vmstate.h
> > > @@ -163,6 +163,7 @@ typedef enum {
> > >       MIG_PRI_IOMMU,              /* Must happen before PCI devices */
> > >       MIG_PRI_PCI_BUS,            /* Must happen before IOMMU */
> > >       MIG_PRI_VIRTIO_MEM,         /* Must happen before IOMMU */
> > > +    MIG_PRI_APIC,               /* Must happen before PCI devices */
> > >       MIG_PRI_GICV3_ITS,          /* Must happen before PCI devices */
> > >       MIG_PRI_GICV3,              /* Must happen before the ITS */
> > >       MIG_PRI_MAX,
> > > -- 
> > > 2.20.1
> > > 
> > 
> > +Cedric, +Alex
> > 
> > queued.
> > 
> 
> Perhaps we could group the interrupt controller priorities
> under a common MIG_PRI_INTC ? PPC is very much the same,
> although we managed to order restore from the machine load
> handler IIRC.
> 
> Anyhow, LGTM.

Agreed. That, when introduced, can also take ARM's into account (that may
need a MIG_PRI_INTC_HIGH for ITS).

Thanks,

-- 
Peter Xu


