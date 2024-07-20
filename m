Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B896DC3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 18:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVFDy-0006qC-Ju; Sat, 20 Jul 2024 14:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVFDw-0006o7-O5
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 14:54:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVFDv-0005ra-5w
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 14:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721501665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BbCJeSbCymd93FgjcjJ3a5MagDuvsSHnU9m0oO3cshY=;
 b=NssuWqna+hN86uiU7M4IsAFjZR5CY2+IYeh99vNmyraWiJVtWfBRMKKfQorpu9lrrsq7nK
 vA/E4fx+VcbzzUfpraxj/rrjy124kB12dNHbpSL9RayYNp4NekOyc/SHTIgXtfMxLfB898
 vyz9oi76CVcEMaO1g1kHKTwlF2zsuuY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-zvT3c84vPvml5wYIOa67pg-1; Sat, 20 Jul 2024 14:54:24 -0400
X-MC-Unique: zvT3c84vPvml5wYIOa67pg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42666ed2d5fso19684435e9.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 11:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721501662; x=1722106462;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BbCJeSbCymd93FgjcjJ3a5MagDuvsSHnU9m0oO3cshY=;
 b=vZ468V0ovxxpMtx661yaD5n1/pLn4tGPVgYXmZSxjfTuP1j8BNHn8Wlpy1O9XqIjs0
 26plrjGubJhroTZIWQw9p8VsFTDflWuLtNU1YRWUEQk0fZbYMFyioIbQ7icxcZu7KDw5
 ArlIWFH2u6BstMPnrzAXEHetkVWqwsbjoKOrtYHQqusUL3njCPrYBL2uTQiRiI0sJpfo
 1etvXtnHrBoroFJoEYzSHdw3L3YvPMyYUZnsNOqZcUeCpqXa1p2oo8tZCEs/4mHAxb2j
 7KLLjEDqk8Dzlwl/uthz5K/H5tev2Gkd0BVzXT4+X7lXLrRhyULoavZ41ofvAsRcuRun
 6UpQ==
X-Gm-Message-State: AOJu0YxRqR4bMIO1tT3blwghU50tLjtYVN56z+nnWjnrP2A/PEWepspq
 wlynYXFX8x6Vm+7Iej+jpDhyR6yEGe83F5NNLi8/cVUtL4aVQjuz+CPjmh2V82HD8Zxqny+6A5d
 sU4ivDc3HBKGUUIFGHvmpW+w5Xjbs8k4NQeUWAVJuiL1TBRG3aiHDetpuUTG9oWw=
X-Received: by 2002:a05:600c:35c3:b0:426:6c7a:3a61 with SMTP id
 5b1f17b1804b1-427dcf6b273mr12052445e9.3.1721501662400; 
 Sat, 20 Jul 2024 11:54:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3yEf9SQ2WWfRXV02Qv3x65Ly9DxjUgf59bl9eazW7C3Zt43+7JpbCRcqAzReFGRz/RUQKfw==
X-Received: by 2002:a05:600c:35c3:b0:426:6c7a:3a61 with SMTP id
 5b1f17b1804b1-427dcf6b273mr12052345e9.3.1721501661764; 
 Sat, 20 Jul 2024 11:54:21 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878695b35sm4389594f8f.65.2024.07.20.11.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 11:54:21 -0700 (PDT)
Date: Sat, 20 Jul 2024 14:54:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com,
 aswin.u.unnikrishnan@oracle.com, joe.jin@oracle.com
Subject: Re: [PATCH 1/1] pci: don't skip function 0 occupancy verification
 for devfn auto assign
Message-ID: <20240720145240-mutt-send-email-mst@kernel.org>
References: <20240708041056.54504-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708041056.54504-1-dongli.zhang@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, Jul 07, 2024 at 09:10:56PM -0700, Dongli Zhang wrote:
> When the devfn is already assigned in the command line, the
> do_pci_register_device() may verify if the function 0 is already occupied.
> 
> However, when devfn < 0, the verification is skipped because it is part of
> the last "else if".
> 
> For instance, suppose there is already a device at addr=00.00 of a port.
> 
> -device pcie-root-port,bus=pcie.0,chassis=115,id=port01,addr=0e.00 \
> -device virtio-net-pci,bus=port01,id=vnet01,addr=00.00 \
> 
> When 'addr' is specified for the 2nd device, the hotplug is denied.
> 
> (qemu) device_add virtio-net-pci,bus=port01,id=vnet02,addr=01.00
> Error: PCI: slot 0 function 0 already occupied by virtio-net-pci, new func virtio-net-pci cannot be exposed to guest.
> 
> When 'addr' is automatically assigned, the hotplug is not denied. This is
> because the verification is skipped.
> 
> (qemu) device_add virtio-net-pci,bus=port01,id=vnet02
> warning: PCI: slot 1 is not valid for virtio-net-pci, parent device only allows plugging into slot 0.
> 
> Fix the issue by moving the verification into an independent 'if'
> statement.
> 
> Fixes: 3f1e1478db2d ("enable multi-function hot-add")
> Reported-by: Aswin Unnikrishnan <aswin.u.unnikrishnan@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

Well, the user did nothing wrong here.
Either we forbid a mix of manual and auto-assigned functions,
or we make it work correctly.
Also note such change in behaviour will need a compat knob
and only affect new machine types.


> ---
>  hw/pci/pci.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 4c7be52951..82ebd243d0 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1186,14 +1186,15 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>                     PCI_SLOT(devfn), PCI_FUNC(devfn), name,
>                     bus->devices[devfn]->name, bus->devices[devfn]->qdev.id);
>          return NULL;
> -    } /*
> -       * Populating function 0 triggers a scan from the guest that
> -       * exposes other non-zero functions. Hence we need to ensure that
> -       * function 0 wasn't added yet.
> -       */
> -    else if (dev->hotplugged &&
> -             !pci_is_vf(pci_dev) &&
> -             pci_get_function_0(pci_dev)) {
> +    }
> +
> +    /*
> +     * Populating function 0 triggers a scan from the guest that
> +     * exposes other non-zero functions. Hence we need to ensure that
> +     * function 0 wasn't added yet.
> +     */
> +    if (dev->hotplugged && !pci_is_vf(pci_dev) &&
> +        pci_get_function_0(pci_dev)) {
>          error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
>                     " new func %s cannot be exposed to guest.",
>                     PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
> -- 
> 2.34.1


