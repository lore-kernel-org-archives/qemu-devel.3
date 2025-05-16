Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF608C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 08:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFqSh-0002rJ-6j; Fri, 16 May 2025 04:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFqSe-0002lq-Pb
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:30:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFqSc-0005N1-Ls
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747384229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ei8QiFXqdVQqusOpULjFrFbdN8ZIktz3bo2gvYtGQQA=;
 b=bwZnsmygAXSJhXqsC8g+NQrwARclVUDTHn3juucioyhZ3cHaeWIUewZzTNjTPc33J3RlH3
 YsGWSfxQ3WJBI8ebtwppzMD5cdKImNLSml9XI7iq0mUt4xLnpubjJrgftVFkq4S168ZLJj
 /5WCI3DLNxEnXYOTIzdrAgciRgn6xIA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-QQVlw6tQPJihMjcSdP41Wg-1; Fri, 16 May 2025 04:30:27 -0400
X-MC-Unique: QQVlw6tQPJihMjcSdP41Wg-1
X-Mimecast-MFC-AGG-ID: QQVlw6tQPJihMjcSdP41Wg_1747384226
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-442dc6f0138so9941085e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 01:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747384226; x=1747989026;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ei8QiFXqdVQqusOpULjFrFbdN8ZIktz3bo2gvYtGQQA=;
 b=YziwDRECfVDdSRN+X3zY5TTiVIJIrgXfn8IMm7MKyoDnM9eOSM7uOV3/8vHh80nKE6
 SNiX79Ovp44suUT/twEs/rIeSYBKjb4TOI51kgox5hbAZEpeFmtO8XEM/pOxgfFqXiXe
 DXclnPye2KERU+iwgEYGvD4JF58+ev566ZVcoYFxs+dAjhlO1BmICEjUA9BomA4G7YCP
 mNF6BVVQgsdMjF6m3Y+LuAlx/q7KdAu8sDrFbhWwu62whkZItWJfxmBRy+3fO1TSG5V1
 RJl/6cA+fD809TvG0Vf2iWsLVadj4vRXfHhV9bQZiDU/GHFeVkri+ojUw5pFeDIV4zKz
 Iwzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIx5J/m1rblHWhPbGYAMxJlBRDoYnrGd0+zzjKNu45zU6ShVgCXsM6xjrMy2abYAyFi8PFV48xWY6n@nongnu.org
X-Gm-Message-State: AOJu0YxLpwvoVrjEoVlUuBqKbAnogjAZ0WVI0dqbfyHfVDcr72pznmWC
 xqwIG/1uOKTjrAZVyF5Eyi+VILEOSMKaBLywZ5pK7VH42/G/wQIjoev4DByIkvJgJe+gYNB/gOZ
 iGHoLwSdNiz4Y7OsV8RzOumnKZBYoGUhOpbVESXktNIvXsmkVGQ4GlvcQ
X-Gm-Gg: ASbGncvmI5Y6F8c097RodEaQc+3azu5dhfFfJChSy5Hgt9Ci4p8E2veDe4wBuMOcNFZ
 +2qT34t/Wf6yO11w+o1ImzBdX+MGAQcCxFaeCInWZGqXvwTDyIUZGf9lmdQhr9cz/apWutd+GYx
 n4MozDCX2AAPZKi3EiuyH2VqnAIlf32zLrLS5cMV1rZPO/XqtUvLD7E55pro0Bcn4kFNkqLwbQg
 KiV/bhSBHel6zo83RnjWy+Zoua7XhMGRGKgbviN8iJ8crCYuu2zVvFeNr/rLufC9jvh8Erclt50
 pGIjfuHwTFuB9jzzEY8FWCYKyiUrgqiXbnGkXJ/SYePxloS4ig==
X-Received: by 2002:a05:600c:1c03:b0:442:c98e:79ab with SMTP id
 5b1f17b1804b1-442fd626edcmr22586085e9.9.1747384226319; 
 Fri, 16 May 2025 01:30:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfnbAhb71m1kPEvGjenipuAbchL8tXCVFPiBkx58ReJyhriHITKL3qpC6FFcnv7G6aOlpN1w==
X-Received: by 2002:a05:600c:1c03:b0:442:c98e:79ab with SMTP id
 5b1f17b1804b1-442fd626edcmr22585755e9.9.1747384225876; 
 Fri, 16 May 2025 01:30:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd51477dsm25734495e9.17.2025.05.16.01.30.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 01:30:25 -0700 (PDT)
Message-ID: <b559f44a-531b-4c10-ac6a-53c2cd5bba4f@redhat.com>
Date: Fri, 16 May 2025 10:30:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 20/42] vfio/pci: vfio_notifier_cleanup
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-21-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1747063973-124548-21-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/12/25 17:32, Steve Sistare wrote:
> Move event_notifier_cleanup calls to a helper vfio_notifier_cleanup.
> This version is trivial, and does not yet use the vdev and nr parameters.
> No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

	
> ---
>   hw/vfio/pci.c | 28 +++++++++++++++++-----------
>   1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index bfeaafa..d2b08a3 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -67,6 +67,12 @@ static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>       return !ret;
>   }
>   
> +static void vfio_notifier_cleanup(VFIOPCIDevice *vdev, EventNotifier *e,
> +                                  const char *name, int nr)
> +{
> +    event_notifier_cleanup(e);
> +}
> +
>   /*
>    * Disabling BAR mmaping can be slow, but toggling it around INTx can
>    * also be a huge overhead.  We try to get the best of both worlds by
> @@ -179,7 +185,7 @@ fail_vfio:
>       kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt,
>                                             vdev->intx.route.irq);
>   fail_irqfd:
> -    event_notifier_cleanup(&vdev->intx.unmask);
> +    vfio_notifier_cleanup(vdev, &vdev->intx.unmask, "intx-unmask", 0);
>   fail:
>       qemu_set_fd_handler(irq_fd, vfio_intx_interrupt, NULL, vdev);
>       vfio_device_irq_unmask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
> @@ -211,7 +217,7 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
>       }
>   
>       /* We only need to close the eventfd for VFIO to cleanup the kernel side */
> -    event_notifier_cleanup(&vdev->intx.unmask);
> +    vfio_notifier_cleanup(vdev, &vdev->intx.unmask, "intx-unmask", 0);
>   
>       /* QEMU starts listening for interrupt events. */
>       qemu_set_fd_handler(event_notifier_get_fd(&vdev->intx.interrupt),
> @@ -310,7 +316,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>       if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
>                                   VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
>           qemu_set_fd_handler(fd, NULL, NULL, vdev);
> -        event_notifier_cleanup(&vdev->intx.interrupt);
> +        vfio_notifier_cleanup(vdev, &vdev->intx.interrupt, "intx-interrupt", 0);
>           return false;
>       }
>   
> @@ -337,7 +343,7 @@ static void vfio_intx_disable(VFIOPCIDevice *vdev)
>   
>       fd = event_notifier_get_fd(&vdev->intx.interrupt);
>       qemu_set_fd_handler(fd, NULL, NULL, vdev);
> -    event_notifier_cleanup(&vdev->intx.interrupt);
> +    vfio_notifier_cleanup(vdev, &vdev->intx.interrupt, "intx-interrupt", 0);
>   
>       vdev->interrupt = VFIO_INT_NONE;
>   
> @@ -500,7 +506,7 @@ static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector, int nr)
>       return;
>   
>   fail_kvm:
> -    event_notifier_cleanup(&vector->kvm_interrupt);
> +    vfio_notifier_cleanup(vector->vdev, &vector->kvm_interrupt, name, nr);
>   fail_notifier:
>       kvm_irqchip_release_virq(kvm_state, vector->virq);
>       vector->virq = -1;
> @@ -513,7 +519,7 @@ static void vfio_remove_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
>                                             vector->virq);
>       kvm_irqchip_release_virq(kvm_state, vector->virq);
>       vector->virq = -1;
> -    event_notifier_cleanup(&vector->kvm_interrupt);
> +    vfio_notifier_cleanup(vdev, &vector->kvm_interrupt, "kvm_interrupt", nr);
>   }
>   
>   static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
> @@ -830,7 +836,7 @@ static void vfio_msi_disable_common(VFIOPCIDevice *vdev)
>               }
>               qemu_set_fd_handler(event_notifier_get_fd(&vector->interrupt),
>                                   NULL, NULL, NULL);
> -            event_notifier_cleanup(&vector->interrupt);
> +            vfio_notifier_cleanup(vdev, &vector->interrupt, "interrupt", i);
>           }
>       }
>   
> @@ -2936,7 +2942,7 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
>                                          VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>           qemu_set_fd_handler(fd, NULL, NULL, vdev);
> -        event_notifier_cleanup(&vdev->err_notifier);
> +        vfio_notifier_cleanup(vdev, &vdev->err_notifier, "err_notifier", 0);
>           vdev->pci_aer = false;
>       }
>   }
> @@ -2955,7 +2961,7 @@ static void vfio_unregister_err_notifier(VFIOPCIDevice *vdev)
>       }
>       qemu_set_fd_handler(event_notifier_get_fd(&vdev->err_notifier),
>                           NULL, NULL, vdev);
> -    event_notifier_cleanup(&vdev->err_notifier);
> +    vfio_notifier_cleanup(vdev, &vdev->err_notifier, "err_notifier", 0);
>   }
>   
>   static void vfio_req_notifier_handler(void *opaque)
> @@ -3003,7 +3009,7 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>                                          VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>           qemu_set_fd_handler(fd, NULL, NULL, vdev);
> -        event_notifier_cleanup(&vdev->req_notifier);
> +        vfio_notifier_cleanup(vdev, &vdev->req_notifier, "req_notifier", 0);
>       } else {
>           vdev->req_enabled = true;
>       }
> @@ -3023,7 +3029,7 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
>       }
>       qemu_set_fd_handler(event_notifier_get_fd(&vdev->req_notifier),
>                           NULL, NULL, vdev);
> -    event_notifier_cleanup(&vdev->req_notifier);
> +    vfio_notifier_cleanup(vdev, &vdev->req_notifier, "req_notifier", 0);
>   
>       vdev->req_enabled = false;
>   }


