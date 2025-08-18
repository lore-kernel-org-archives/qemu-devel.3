Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FC3CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 14:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo1Hs-0000wB-KW; Mon, 18 Aug 2025 10:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uo1Hq-0000vx-9Z
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:56:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uo1Hm-00089c-BY
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755528989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qfEhMGQXJHC+wHqOvJebKpsirKO1fnxTDrsuU//G4vY=;
 b=LyVhHOuY3hqMoEO98vLd2Zcw8LzfaAmttP8UUP4z87rrMVMmSWm+PFQMqr+1hGvFXG3W2x
 L/3D884Txx3qtdHGssOmAJApbDG3r/gAWuXRUtQ3U8vN6sUjY8+sVnuMZZ35ca2HkNfQhU
 CzhUcjm9Y66ZzXKS8FYKeLcBXHgRcOE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-TOZw6wWmN5GZ9uNFqZGE0w-1; Mon, 18 Aug 2025 10:56:28 -0400
X-MC-Unique: TOZw6wWmN5GZ9uNFqZGE0w-1
X-Mimecast-MFC-AGG-ID: TOZw6wWmN5GZ9uNFqZGE0w_1755528987
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-70a9f55836dso103192596d6.3
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 07:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755528987; x=1756133787;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qfEhMGQXJHC+wHqOvJebKpsirKO1fnxTDrsuU//G4vY=;
 b=MgID7i8/xK5zp2wAT9qkS9NgdG/HxrbNk8vlAm3vwqN2SauZj3UdJ+TMumNdeyStxz
 bFH6/xWZZ+mWdxR3CpLYW7ipKxg9P0Dgq89gwWBZfEbj3lJgjz/LHBEJTxfw3jiPDlWB
 shinp5pO2SekORMYPc95cBbG6M2nifJ9+SV1EgO0aM7H46hTkWybfOxd8Hq0YG4RzZH1
 gClDWypMwBNC+h1gPYHJe2bl98tzC1XXyjR0zwYVXlQt6ldks8fJ5rBhRr9YDZMS2HQJ
 3HBZ2+J1q6OlePmUiE2QDHwsNlG/EEe604JUBeNWXM0vj/An5iw28jieHsGd1W1eR4jl
 8/fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3xG/OUsIvGh5x6zzHbWryIFQ1qDV0THaBqVHe65lw6NindEV82LiWcII3/OYAEUwrefDEFCkWGUAF@nongnu.org
X-Gm-Message-State: AOJu0YwKEaJ19nPPpmKwIr91cWhDkgF+fzSSkV4Vk9E71tNNgpM6LFIU
 QNBz0GgFQrYlI0fMj6fdlci/R2aEZflauQR0BQkrLNWH7QFOyZMcdpMC0Sz0nyPQ0aDbq5m8+Dd
 h7cYDYZzUGgKpiLxso4cjLpPvNoNUDDYUdGAJDBY7XAYhyoG6yn3EOZZR
X-Gm-Gg: ASbGncuamHi0baf+Xep+p9aAs913mNS/t4HWsAdPTys/RCn1TyX+tqCPQTVPW8W+eMr
 qIVp5TtJy/452NHy6XyivmL43j71G6qXqLx14KJGcUMiq6geryxKqpCDyhzIofKZLwgCce2HDY4
 6Et6hmIrz+O9vsYwELGbfxj/fKLfKtrULRuINfwXESoBMvuZljhzPEDeVx0B5Xw6pBX2XfcIH70
 PYx78Tvvq2D/e0eqogLpkEla5MokiCyNEv1JUHOI7NXN5s5jSD6mSjz62bCV7ey9Irf5RHGETBm
 uGavsK2quDKVVNptPNTPNnwqXipiQeUh
X-Received: by 2002:a05:6214:ccd:b0:70b:7076:cd13 with SMTP id
 6a1803df08f44-70ba7a5e5c8mr173302096d6.2.1755528987426; 
 Mon, 18 Aug 2025 07:56:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoZ3hB1wSgivgF7pRUOr9KwdHLk4zhvgRrpmrU9kew3jmUl0h44Zsm9UviKrfyhuR8F78ndw==
X-Received: by 2002:a05:6214:ccd:b0:70b:7076:cd13 with SMTP id
 6a1803df08f44-70ba7a5e5c8mr173301706d6.2.1755528986839; 
 Mon, 18 Aug 2025 07:56:26 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70ba9380eaasm53841346d6.62.2025.08.18.07.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 07:56:24 -0700 (PDT)
Date: Mon, 18 Aug 2025 10:56:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: mst@redhat.com, pbonzini@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org, shenyicong.1023@bytedance.com
Subject: Re: [PATCH] migration: ensure APIC is loaded prior to VFIO PCI devices
Message-ID: <aKM_CwdEa_VlAAaO@x1.local>
References: <20250818131127.1021648-1-yanfei.xu@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250818131127.1021648-1-yanfei.xu@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Aug 18, 2025 at 09:11:27PM +0800, Yanfei Xu wrote:
> The load procedure of VFIO PCI devices involves setting up IRT
> for each VFIO PCI devices. This requires determining whether an
> interrupt is single-destination interrupt to decide between
> Posted Interrupt(PI) or remapping mode for the IRTE. However,
> determining this may require accessing the VM's APIC registers.
> 
> For example:
> ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irqs)
>   ...
>     kvm_arch_irq_bypass_add_producer
>       kvm_x86_call(pi_update_irte)
>         vmx_pi_update_irte
>           kvm_intr_is_single_vcpu
> 
> If the LAPIC has not been loaded yet, interrupts will use remapping
> mode. To prevent the fallback of interrupt mode, keep APIC is always
> loaded prior to VFIO PCI devices.
> 
> Signed-off-by: Yicong Shen <shenyicong.1023@bytedance.com>
> Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
> ---
>  hw/intc/apic_common.c       | 1 +
>  include/migration/vmstate.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
> index 37a7a7019d..394fe02013 100644
> --- a/hw/intc/apic_common.c
> +++ b/hw/intc/apic_common.c
> @@ -379,6 +379,7 @@ static const VMStateDescription vmstate_apic_common = {
>      .pre_load = apic_pre_load,
>      .pre_save = apic_dispatch_pre_save,
>      .post_load = apic_dispatch_post_load,
> +    .priority = MIG_PRI_APIC,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT32(apicbase, APICCommonState),
>          VMSTATE_UINT8(id, APICCommonState),
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 1ff7bd9ac4..22e988c5db 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -163,6 +163,7 @@ typedef enum {
>      MIG_PRI_IOMMU,              /* Must happen before PCI devices */
>      MIG_PRI_PCI_BUS,            /* Must happen before IOMMU */
>      MIG_PRI_VIRTIO_MEM,         /* Must happen before IOMMU */
> +    MIG_PRI_APIC,               /* Must happen before PCI devices */

As the list grows, maybe it's a good idea we start to document exactly the
reasons inline into the enum.  Can sure be done on top.  This patch alone
looks like stable material..

Reviewed-by: Peter Xu <peterx@redhat.com>

>      MIG_PRI_GICV3_ITS,          /* Must happen before PCI devices */
>      MIG_PRI_GICV3,              /* Must happen before the ITS */
>      MIG_PRI_MAX,
> -- 
> 2.20.1
> 

-- 
Peter Xu


