Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F18CCA468
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3GAx-0002QS-5G; Mon, 29 Sep 2025 11:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3GAl-0002MR-TV
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:52:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3GAY-0000yW-Sg
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759161120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gTXZMTGAUEkDo5lYCzCpAvfXp4kS4tozqmLHAVtTI6E=;
 b=PmimwovFcl9+Evy+TtiiifdrpYjE0K9lagtRp+W2GoUDFUZv08s31Uox/hedc6exKqxQ2t
 w0cBKFmpek4iRGzF7dOieu3VacIr3wZi0Dy7IG72ki4gW3bo/7QNZhRme2c39BzzQNv3tQ
 xP0O7JgqC93vFZoEFH4JebNRu9jrg3o=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-6lPfB9ntN12bxABL-Ux-OQ-1; Mon, 29 Sep 2025 11:51:59 -0400
X-MC-Unique: 6lPfB9ntN12bxABL-Ux-OQ-1
X-Mimecast-MFC-AGG-ID: 6lPfB9ntN12bxABL-Ux-OQ_1759161119
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4e0fcbf8eb0so36244891cf.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759161119; x=1759765919;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gTXZMTGAUEkDo5lYCzCpAvfXp4kS4tozqmLHAVtTI6E=;
 b=VD0dG2/VWzP/TciJq8qDj4PbLce4W49ukbsuL5Gbv1CvKdRb/b2+N9jvhLiJ32m4Ss
 AuP+So+XtoOJs+kwdhVDm3fEBTGzRxBtzvjkkXoviAz07MB1Vu43c4cjk9MUBIDXO/R5
 IeggFKCgWHiPbgnhAKAKUtJ8c5Id0HRSQZHqVQEYy5SJocCpYemWM3biczriiR62fWyW
 4pto87XGbxeytPw71anraqSJ8+JGMW8KGC/fQ82wIidz8XRTfCe2nLcER0VHjC6LzIBz
 ckNTErnkSCThzcDcCHKfvnAUJCKECyqsUpi+7MKbh1iVktA7vkVbeaY+EQwsAQv7Ez4+
 dodg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE6FQfAIvGs6d2v+Gdswo/fcCh8odymtPLWqGVpxtxiPB5DdWkiNN1olTfUQab/+sOk+UVnKA7zY2c@nongnu.org
X-Gm-Message-State: AOJu0Yw3fZV0AsjOsElNDmGpKhXKfip8YeCfTDkbNPjnX5F8n4u2da6P
 xYS42z9cBm9KNFs/EJMWPk4J2ggW6xmmpqyt1wRIfL/kLOmz/YCrgYEQE5oZ/T0S4YOB/mmMgpq
 jTllXkIKVjFfgqJQkWMkLuFAjKc3BhZMViVF8sJr343gLr6Q4NI4zNtUn
X-Gm-Gg: ASbGncuSjRcG9F6UJRMCvGaiiaN3QVzNh9JZ0Xlo+Mpxp8QKyJuFbBAT+S519hl+cUV
 CD/JVMCdhf3REDYJBL4NG/FvN2tQW6QBzlpbUdoV4ncPpG+chyukExQJtldCTn5aXnFCfQWWchO
 5QPhAvQpdK5YZ7e/VSXR+32Pb8Q2YmkdCIGFcZ4/7p6z9SGfI7zevKReNFRBm18M83Hf0/ba8lK
 e0E2CYKYYMVLEdsrzXRE5yzshsl1K24P3kO+iEts1DVniO97/s37Lq9hz/FPQ8o/wHlCqYdQiSL
 YRxb2gJxGveHKh4Vhx5egZOGhNPth+5e
X-Received: by 2002:ac8:7f96:0:b0:4ce:6ded:dba4 with SMTP id
 d75a77b69052e-4da47fec20emr273526031cf.19.1759161118915; 
 Mon, 29 Sep 2025 08:51:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIXOJdGkIDa3DxCJMz3w8dv5fZEgPOfBhMU8weZmnKlQfVQnAWmdKUk/mJ4+1TQxi4StP+FA==
X-Received: by 2002:ac8:7f96:0:b0:4ce:6ded:dba4 with SMTP id
 d75a77b69052e-4da47fec20emr273525421cf.19.1759161118231; 
 Mon, 29 Sep 2025 08:51:58 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4db09f19709sm80615881cf.7.2025.09.29.08.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:51:57 -0700 (PDT)
Date: Mon, 29 Sep 2025 11:51:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: mst@redhat.com, pbonzini@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org, shenyicong.1023@bytedance.com,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] migration: ensure APIC is loaded prior to VFIO PCI devices
Message-ID: <aNqrHBMKRp-9Qhw0@x1.local>
References: <20250818131127.1021648-1-yanfei.xu@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250818131127.1021648-1-yanfei.xu@bytedance.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
>      MIG_PRI_GICV3_ITS,          /* Must happen before PCI devices */
>      MIG_PRI_GICV3,              /* Must happen before the ITS */
>      MIG_PRI_MAX,
> -- 
> 2.20.1
> 

+Cedric, +Alex

queued.

-- 
Peter Xu


