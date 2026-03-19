Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7A61075276
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w38p5-0000rV-F4; Thu, 19 Mar 2026 04:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w38p4-0000rA-2j
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:33:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w38p2-0000oa-Ez
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773909215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HnkW5TkmBbhUGG0jH5VbJhi7a7XgbMiDFeA7rDQ0ZPg=;
 b=XPL0ZCmW/7Z9LyYGTJ12qlKXSEa14loQw7by61s2sSv1Z2bzPNSWENYXQGaJh7s/7W4tSY
 NJxrtScsl1YOclHchdMv6N/MBLIZcvfx/wPRzYH8YHbX8fPW617p/9loJGONR3wug/BSty
 pPU5bBuNEXF3BtQZcoc2BxQ/KmWQEAE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-mtF8xJMpNHOYBMMnCNNM_Q-1; Thu, 19 Mar 2026 04:33:28 -0400
X-MC-Unique: mtF8xJMpNHOYBMMnCNNM_Q-1
X-Mimecast-MFC-AGG-ID: mtF8xJMpNHOYBMMnCNNM_Q_1773909201
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-485375aa56eso7233245e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773909201; x=1774514001; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HnkW5TkmBbhUGG0jH5VbJhi7a7XgbMiDFeA7rDQ0ZPg=;
 b=LHji82Vwa3Y8845HvvBP4Ia7XYuF4SJBrb+z+mU0CnMMb4X1ZVAr5rw169gxTJby55
 h36vNhWLRqiQE8fKoKIsiyjqnlSoYEvnCuf/5cM63wwS/ZWA4BbtDQ4TYsLxNZtw1l0G
 QBHjhMzklBEGsbrLVM2dL+co7AP+xrilHmp6S7pLcLm0zPPVNmmKXI7yixCkFbiKnsgP
 dQuHj3vLJsJTIN9VbWJIta8VfUmlSFhMILfX4kNEL4M6zPkaPv/eZtdiVmWmE+c9TGvT
 C5cGbCsoggJCDFzBn4zzmBp4xHokG0H/L6cL7UYKYiXDwFo2J2t7hJ/Hk6KCoz4lsXhw
 7osg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773909201; x=1774514001;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HnkW5TkmBbhUGG0jH5VbJhi7a7XgbMiDFeA7rDQ0ZPg=;
 b=rUc7TkARYZU1IT/B0Q/6+cHyvgZXW21Lbzs7QWCBQaVBL2opS2zHu/tGg7jEZbJ1yX
 oxaYwEYoAA230jvCQRpxQVlxVe4Y3lxODRV300yPg8dPNf1a6fHM1VC4dUnoxDmjrXBi
 HmpEPcyVpvrb4j8RJYTcadN95SYokRFWC+kfhZLZ7zG2Q9IrFEl3/cdC4Jw5b4j8gwjV
 0ZM3UKIsvun1Tgd9ZKrdiEiP3dmd0iPOy1VpUr6mH7VLmd0SB8/Jv1fpADCrGJdhGLSX
 xAn1hTkT9HPO8BWxB8lB7DUbd9YJ409Tmcc0Nd883K1jAWVS3aUn6A3n9+SvRDo1l8W3
 l3tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6i+5CL3CfkvPEH/9hHhvvb+FpnnIVxsFzlCK1jLj5QwhRZwrVnY7+O6DxkhKYZk/BAUPyMzXfEbNP@nongnu.org
X-Gm-Message-State: AOJu0YxM/GuxkPEzPmiIIHq/gzBBtXnMGN3R2c5wJj6uRG66uv2zhjdZ
 qeCEcMNpZJuJlVoWB/Uw7dZu0i2hpP2TbrD57qOABG75/EOJBuktoWon3/0WdhkSRFA4i2l6vkj
 fB+K7Av7Fgyr3BEv02reYbU7mpFP8In7HKrZxgP/MvD9iNJoHKr+Gxv52
X-Gm-Gg: ATEYQzxSq15YKyAP7ZMD6nd6oAVrUEtNvEyIjOj4KtbcN3PTclsthEqxyEpRckvcY6o
 4vU61jasR+1n/LUigP1ZGeZoXxZLs0MN17u0PPGZ+ED05GZ6V1O2FKOU/a7JyUM3ULdgET2Hhmg
 Qjv6Z292KhdKbdvLMqMcP2JgGe4hcjdHbtazsaXczbSXsXAF7JcuxKZeLtU/z/3pMXLGjMJmI9R
 vGqiJ8prCWENgO7v2gmbVFt5zNU1iLecz0R7JrFpuEega80tPPqpBHcIAfeXIJs1ya/jZyI7o0H
 dRTzoZwooAE9QOQChdfxX4vDKskGRFfhjhajczuFqMtO7olJbst3AXR+OORF518xVeY6mFwb7pP
 sEA3D5ge1VO7gwjB0+P38+ESN4LEZaxaZh9LYV2MjgkcUdWpcHeiETU1/y1My
X-Received: by 2002:a05:600c:3491:b0:483:7783:537b with SMTP id
 5b1f17b1804b1-486f4450338mr99717255e9.24.1773909200710; 
 Thu, 19 Mar 2026 01:33:20 -0700 (PDT)
X-Received: by 2002:a05:600c:3491:b0:483:7783:537b with SMTP id
 5b1f17b1804b1-486f4450338mr99716805e9.24.1773909200262; 
 Thu, 19 Mar 2026 01:33:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f4e48ad5sm164422045e9.1.2026.03.19.01.33.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 01:33:19 -0700 (PDT)
Message-ID: <0fe351a8-e08c-401a-af43-578c7be9ab2a@redhat.com>
Date: Thu, 19 Mar 2026 09:33:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/8] hw/vfio/pci.c: eradicate CONFIG_KVM
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-ppc@nongnu.org
References: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
 <20260318174733.1717643-6-pierrick.bouvier@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260318174733.1717643-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/18/26 18:47, Pierrick Bouvier wrote:
> We just need to add kvm_enabled() guard when calling concerned
> functions, but no need to extract those kvm functions since they are not
> using any kvm specific types that would not be visible at compilation
> time.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/vfio/pci.c | 28 ++++++++++------------------
>   1 file changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index df617f1fe46..811e5001de5 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -152,7 +152,6 @@ void vfio_pci_intx_eoi(VFIODevice *vbasedev)
>   
>   static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>   {
> -#ifdef CONFIG_KVM
>       PCIDevice *pdev = PCI_DEVICE(vdev);
>       int irq_fd = event_notifier_get_fd(&vdev->intx.interrupt);
>   
> @@ -206,14 +205,10 @@ fail:
>       qemu_set_fd_handler(irq_fd, vfio_intx_interrupt, NULL, vdev);
>       vfio_device_irq_unmask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
>       return false;
> -#else
> -    return true;
> -#endif
>   }
>   
>   static bool vfio_cpr_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>   {
> -#ifdef CONFIG_KVM
>       if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
>           vdev->intx.route.mode != PCI_INTX_ENABLED ||
>           !kvm_resamplefds_enabled()) {
> @@ -236,14 +231,10 @@ static bool vfio_cpr_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>       vdev->intx.kvm_accel = true;
>       trace_vfio_intx_enable_kvm(vdev->vbasedev.name);
>       return true;
> -#else
> -    return true;
> -#endif
>   }
>   
>   static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
>   {
> -#ifdef CONFIG_KVM
>       PCIDevice *pdev = PCI_DEVICE(vdev);
>   
>       if (!vdev->intx.kvm_accel) {
> @@ -277,7 +268,6 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
>       vfio_device_irq_unmask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
>   
>       trace_vfio_intx_disable_kvm(vdev->vbasedev.name);
> -#endif
>   }
>   
>   static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
> @@ -287,7 +277,9 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
>       trace_vfio_intx_update(vdev->vbasedev.name,
>                              vdev->intx.route.irq, route->irq);
>   
> -    vfio_intx_disable_kvm(vdev);
> +    if (kvm_enabled()) {
> +        vfio_intx_disable_kvm(vdev);
> +    }
>   
>       vdev->intx.route = *route;
>   
> @@ -295,7 +287,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
>           return;
>       }
>   
> -    if (!vfio_intx_enable_kvm(vdev, &err)) {
> +    if (kvm_enabled() && !vfio_intx_enable_kvm(vdev, &err)) {
>           warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>       }
>   
> @@ -350,16 +342,14 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>       vdev->intx.pin = pin - 1; /* Pin A (1) -> irq[0] */
>       pci_config_set_interrupt_pin(pdev->config, pin);
>   
> -#ifdef CONFIG_KVM
>       /*
>        * Only conditional to avoid generating error messages on platforms
>        * where we won't actually use the result anyway.
>        */
> -    if (kvm_irqfds_enabled() && kvm_resamplefds_enabled()) {
> +    if (kvm_enabled() && kvm_irqfds_enabled() && kvm_resamplefds_enabled()) {
>           vdev->intx.route = pci_device_route_intx_to_irq(pdev,
>                                                           vdev->intx.pin);
>       }
> -#endif
>   
>       if (!vfio_notifier_init(vdev, &vdev->intx.interrupt, "intx-interrupt", 0,
>                               errp)) {
> @@ -370,7 +360,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>   
>   
>       if (cpr_is_incoming()) {
> -        if (!vfio_cpr_intx_enable_kvm(vdev, &err)) {
> +        if (kvm_enabled() && !vfio_cpr_intx_enable_kvm(vdev, &err)) {
>               warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>           }
>           goto skip_signaling;
> @@ -383,7 +373,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>           return false;
>       }
>   
> -    if (!vfio_intx_enable_kvm(vdev, &err)) {
> +    if (kvm_enabled() && !vfio_intx_enable_kvm(vdev, &err)) {
>           warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>       }
>   
> @@ -400,7 +390,9 @@ static void vfio_intx_disable(VFIOPCIDevice *vdev)
>       int fd;
>   
>       timer_del(vdev->intx.mmap_timer);
> -    vfio_intx_disable_kvm(vdev);
> +    if (kvm_enabled()) {
> +        vfio_intx_disable_kvm(vdev);
> +    }
>       vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
>       vdev->intx.pending = false;
>       pci_irq_deassert(pdev);



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


