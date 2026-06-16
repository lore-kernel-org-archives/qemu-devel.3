Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500E7CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 17:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZXnf-0001vp-7b; Tue, 16 Jun 2026 13:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wZXnc-0001vN-TB
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:42:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wZXna-0007Lv-Be
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781631724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2FsF2XDCjnPBqYq4cfv7CJHpfNi+14rTnDulmYcRapA=;
 b=G3d2KqnEDCWBuu2bWX77C5S3S2wRB1tzXau7yfqv/1smfFTynyZIJ/Gdtcc03ACdcQwkrM
 IlXlPXqOMMfZEssoGIbIiF7zHO9hNfLR7AQ7eruITzo8UKIwBFImtxT3O32lfbBSETbFeT
 Fg9fgG9KfSNy95vjxJJupreMoTFhYJc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-1vlXaXmbNuGrkvnA5bxHHQ-1; Tue, 16 Jun 2026 13:42:03 -0400
X-MC-Unique: 1vlXaXmbNuGrkvnA5bxHHQ-1
X-Mimecast-MFC-AGG-ID: 1vlXaXmbNuGrkvnA5bxHHQ_1781631722
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490cc1ae292so415525e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 10:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781631722; x=1782236522; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=2FsF2XDCjnPBqYq4cfv7CJHpfNi+14rTnDulmYcRapA=;
 b=fjcvhlW8H8mPSFUILSmPLCNmFc91OJo4ErHrGaK5mOvlfZQA2MDckfuMImghS3aicE
 ypaRjV7KEFJgEZiFWQ6H8jEUANrd4mlHSsGRM91EgMooHKusJrazulFI3MRwZGTSiO4o
 ybJi965qR2ZTi3A2GTQAiMYbBkaqG1Rllvti1JTgU6oAwhBNzs8vC412uHWTvtcK+9Jv
 MBJVToqkzDvXeZyst+fs3hnWO9T3ohF8cKlh/D/DA3OTLiu81ZxF9ROt7YRa4nbdb+9H
 Nzwxbk+RU6MupnklEpA7W1IwVeokEg163psQ5MHiKtbmlQJBkC3tQhuj7fn8+lcpQhn1
 Vu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781631722; x=1782236522;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2FsF2XDCjnPBqYq4cfv7CJHpfNi+14rTnDulmYcRapA=;
 b=YwkkvzpD2lT7zuu5Xjzb2kJPY0a5gJM6I8b2L+wCqQcqoU8F/cjDoMfNx1wx0e8kUn
 pfKE0YFJRYoCwZDFw70rmNXxkHV0n94D25m81n/gxVC5rxzQE+RyjFUf3HN4xiTYc1xZ
 lEAseyEf+5PngyA6X6Q6gVFlRlhbyyI6Czja5REYGY58pP0VzeKxSy7etfIFwx6m0Trc
 rtYzYycGFpFpDgODD4vDqKLE5swstD3difq5n38YkmjwsA9SOFrBRXCwOeaxJ8HWa147
 PfSWj8ipPBENnbZw+OfzIU4Ok/EZtlB+QgeTmVrDs2hWDti2bgF8Dj7tKaM1wH3A3V44
 H8Tg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+AV/Ayv99fwlNLDO5UTQO4eEUA5JCLIe9VgWKJ6lL+an+mhMFpR/QxgCgMoI9z/UewySd86qf3Aveg@nongnu.org
X-Gm-Message-State: AOJu0YyE1di7D7SKywBCshVEsNOofH261+htbnJow3niKp/CEfjE5qeh
 azJ2SDSmijqXnGGIqgIwokz+0aPHail+rVHEFO13WekIvDpS2dSJLFhZr+9CtflNBpJA7++3hDt
 m0WkynBt8xzhnZNN1ZAfQoPlq3CQ8o1dutyZ8BPgCIN6mTx7G0j2lNRw2
X-Gm-Gg: Acq92OEhu3g/6TXQw5E1jZf/117CBUmAMTy3SFqf/A8Av0Hem3VB1SI11EyqihvExIp
 Px9x/4wW6Vdq1vYQkBks98A0ie52BmjC6Gv9/vTMmX0rHtWZIo2zgKvVIKcR74+S8DWGmb58kNn
 tWZRgSIbcAFlmKlhn7far+BSe9tBlRBAqpQ7scPdyJ1KzJz6nLOmYIPthmV6+bFAylT8S+dEG3C
 twF+4wWe39CqCM+gLi7zGXwvvwY9iFeSMvbxxJoPeShCE+U5Lv/C7s+Udzcsux7i1N05KtymT3e
 Tjigee/w3SEazow7vhaNTlly7ARJX7O9o6ulOwVrTr9UZlA/XsXRpAN+Qb+/ATBk3YAh5pQjrWf
 Hkl+iFNJk0MhiMPnOyCoO1VVvD2e+2bea7xuopK6LrF4iXK5Icl0/++85yJzn
X-Received: by 2002:a05:600d:108:10b0:490:ad1e:1846 with SMTP id
 5b1f17b1804b1-492332f41a9mr7553695e9.9.1781631721595; 
 Tue, 16 Jun 2026 10:42:01 -0700 (PDT)
X-Received: by 2002:a05:600d:108:10b0:490:ad1e:1846 with SMTP id
 5b1f17b1804b1-492332f41a9mr7553445e9.9.1781631721181; 
 Tue, 16 Jun 2026 10:42:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49233434586sm4570715e9.1.2026.06.16.10.42.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 10:42:00 -0700 (PDT)
Message-ID: <c433b85e-c306-4414-9344-aac1a9101fc4@redhat.com>
Date: Tue, 16 Jun 2026 19:41:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/35] vfio/pci: close display console during
 unrealize, not finalize
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Peter Maydell
 <peter.maydell@linaro.org>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
 <20260611-b4-ui-v3-5-72bcbbea0fae@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260611-b4-ui-v3-5-72bcbbea0fae@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/11/26 11:03, Marc-André Lureau wrote:
> The QemuGraphicConsole holds a strong QOM link back to the device via
> its "device" property (OBJ_PROP_LINK_STRONG). When graphic_console_close()
> is only called from vfio_display_finalize() during object finalize, this
> creates a ref-cycle deadlock: the device can't reach refcount 0 because
> the console holds a strong ref, but the console's ref is only dropped by
> graphic_console_close() which runs inside finalize.
> 
> Split the display teardown into two phases:
> - vfio_display_exit(): called during unrealize (vfio_exitfn), closes
>    the graphic console to break the ref cycle, and removes display
>    region subregions while the parent memory regions are still alive.
> - vfio_display_finalize(): remains in finalize (vfio_pci_put_device),
>    frees display region memory, dmabuf, and edid resources. The region
>    memory contains QOM child objects (MemoryRegions) that must stay
>    alive until QOM finalization has processed them.
> 
> Acked-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   MAINTAINERS       |  1 +
>   hw/vfio/pci.h     |  1 +
>   hw/vfio/display.c | 29 +++++++++++++++++------------
>   hw/vfio/pci.c     |  1 +
>   4 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 748ec77beb4..8320b37fc32 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2347,6 +2347,7 @@ S: Supported
>   F: hw/vfio/*
>   F: util/vfio-helpers.c
>   F: include/hw/vfio/
> +F: docs/devel/vfio-mdpy.rst
>   F: docs/devel/migration/vfio.rst
>   F: qapi/vfio.json
>   F: migration/vfio-stub.c
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index c3a1f53d350..cf567115870 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -270,6 +270,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
>   
>   void vfio_display_reset(VFIOPCIDevice *vdev);
>   bool vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
> +void vfio_display_exit(VFIOPCIDevice *vdev);
>   void vfio_display_finalize(VFIOPCIDevice *vdev);
>   
>   extern const VMStateDescription vfio_display_vmstate;
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index 8f91e83da88..cb83d98e9af 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -505,15 +505,6 @@ static bool vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
>       return true;
>   }
>   
> -static void vfio_display_region_exit(VFIODisplay *dpy)
> -{
> -    if (!dpy->region.buffer.size) {
> -        return;
> -    }
> -
> -    vfio_region_exit(&dpy->region.buffer);
> -    vfio_region_finalize(&dpy->region.buffer);
> -}
>   
>   /* ---------------------------------------------------------------------- */
>   
> @@ -547,17 +538,31 @@ bool vfio_display_probe(VFIOPCIDevice *vdev, Error **errp)
>       return false;
>   }
>   
> -void vfio_display_finalize(VFIOPCIDevice *vdev)
> +void vfio_display_exit(VFIOPCIDevice *vdev)
>   {
>       if (!vdev->dpy) {
>           return;
>       }
>   
> -    qemu_graphic_console_close(vdev->dpy->con);
>       vfio_display_dmabuf_exit(vdev->dpy);
> -    vfio_display_region_exit(vdev->dpy);
> +    qemu_graphic_console_close(vdev->dpy->con);
> +    if (vdev->dpy->region.buffer.size) {
> +        vfio_region_exit(&vdev->dpy->region.buffer);
> +    }
> +}
> +
> +void vfio_display_finalize(VFIOPCIDevice *vdev)
> +{
> +    if (!vdev->dpy) {
> +        return;
> +    }
> +
> +    if (vdev->dpy->region.buffer.size) {
> +        vfio_region_finalize(&vdev->dpy->region.buffer);
> +    }
>       vfio_display_edid_exit(vdev->dpy);
>       g_free(vdev->dpy);
> +    vdev->dpy = NULL;
>   }
>   
>   static bool migrate_needed(void *opaque)
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9c06b25e637..78beacd24e1 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3624,6 +3624,7 @@ static void vfio_exitfn(PCIDevice *pdev)
>       VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
>   
> +    vfio_display_exit(vdev);

In vfio_pci_realize(), if there is a failure after vfio_display_probe(),
should we cleanup explicitly the display resources too ?

Thanks,

C.

>       vfio_unregister_req_notifier(vdev);
>       vfio_unregister_err_notifier(vdev);
>       pci_device_set_intx_routing_notifier(pdev, NULL);
> 


