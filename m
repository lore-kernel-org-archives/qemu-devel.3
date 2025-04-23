Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E18C369D5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 12:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Z5z-00036I-3C; Wed, 23 Apr 2025 08:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7Z5i-00030J-6F
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:20:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7Z5g-0002pB-0E
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745410834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FFA5M2JMUu7K6JnLv1cBrHR8Nh9uJuC7xxN13LHbSp0=;
 b=h0Ig5oele2FXSiYoeTFeFrgkBQ9YYIDpBERhGUXCKCT+EJXV6VhFfwKhKM6rlMHHfjakVm
 nGGOxl2VP/L3iKogKUMVlMy1b6DtkgdNYHzz2Ax5d/qvXaun74Ea7M5rw2jlmbYs8ues3j
 wqMW7UKXn4pJ7kQh75qfVQPwyiNn/FI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-pCyt5DxMM9Wyrk7FUBzuVQ-1; Wed, 23 Apr 2025 08:20:27 -0400
X-MC-Unique: pCyt5DxMM9Wyrk7FUBzuVQ-1
X-Mimecast-MFC-AGG-ID: pCyt5DxMM9Wyrk7FUBzuVQ_1745410826
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39ee4b91d1cso400264f8f.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 05:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745410826; x=1746015626;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FFA5M2JMUu7K6JnLv1cBrHR8Nh9uJuC7xxN13LHbSp0=;
 b=xJInqrdAf2IhxoNR/cBj71Rsw3aEMBw6jE4BDOQFS7sm0HBvsjL7scxoYcbSNS2Wn5
 lRnDCdj/fYHaQpEEiriQWDLy+2/oaa+AWHmYpad5NK2rmXI6DqaB0dDeG5jSEEZm5U2J
 +mUEIVeq+q2YHWn+ceTdaUw46uXNZFsrLV/NnKMepuCaw58Ru/jUt6yBxhpRB5Opg4SC
 8mr/3v9SGttpYYslGQQCxvDDSs/xdDmz9epCj3Ny4r5INlG5NIH82+QLSgmNJZcmnewg
 xoHCuTxFgF8dowUmssBC0uYmtZeODp3tRiAz4/2ShG//8UOb/8QB1KQSctgaiGhWXNz4
 DF1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/9tT9S4a7UcHPr0lMqfP8lOLIPF37ta+B4bos9LleqrJto20ifSejybG0jmz3ZvqIYmAdoYA3Vyul@nongnu.org
X-Gm-Message-State: AOJu0YzJUb3chpdfDaaV1KOmqDlS33bwP0DyyiqBaTw6KA3WpLZQpWf1
 6bgJrglAtRXznDxTyqWvAfvAf+b3dFKpDKLYVj2iMeUPoDXmRwttnfxTmTz7+iQ1gGqyPN9QzGW
 e0lgaq0aSFg1T7zLqGwet+jW7wE4TKDbCdU2bd2RRAVgjDYl0YD78
X-Gm-Gg: ASbGnctnd2j/h4pnbqXHXgp5B7EIf6+lclraK5WNV5T0p6ZH5pDxqyioF9TaPtF0atN
 85wWQQd3yNPV7uDeMoq5FCGE5XJlhicspY1Pr/FLxsb8QBZjwL8LdycoRH1zlaBNb5q4dMeU/d7
 jis8ef2mEHNSZu2X9ukx6y53W1g6VpTDkuS/GsOFR0SRyGEBA5HR4DLn5KDWTIrHycjuNSAVvbL
 EuPw+JjD2BF49ovpJbafeSPDxICTaySrvIt+hS0erLzLWwdS2Amw1X8XmD2kVZDyANH7TZnzpoh
 /+/DZo1nc2+6ERbcCKX7/SLnEkqBUphwpK+m5eCCnI0JyyM=
X-Received: by 2002:a5d:648d:0:b0:39e:cbca:8a72 with SMTP id
 ffacd0b85a97d-3a06723a853mr2161287f8f.12.1745410826503; 
 Wed, 23 Apr 2025 05:20:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTlCmQlQ8/RNuxDoGnmKCmzDjM6C43aD21VwlR339gh2Z1LZFFZ2XjnfZRNWV8nrVN8npA1A==
X-Received: by 2002:a5d:648d:0:b0:39e:cbca:8a72 with SMTP id
 ffacd0b85a97d-3a06723a853mr2161262f8f.12.1745410826141; 
 Wed, 23 Apr 2025 05:20:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d46afcsm24031235e9.39.2025.04.23.05.20.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 05:20:25 -0700 (PDT)
Message-ID: <102c78ba-5caf-4f90-a6ff-27072eb6876d@redhat.com>
Date: Wed, 23 Apr 2025 14:20:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] vfio: refactor out vfio_interrupt_setup()
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-2-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250409134814.478903-2-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

On 4/9/25 15:48, John Levon wrote:
> Refactor the interrupt setup code out of vfio_realize() for readability.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci.c | 55 +++++++++++++++++++++++++++++++--------------------
>   1 file changed, 34 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 05a7a62204..02f23efaba 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2963,6 +2963,38 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
>       vdev->req_enabled = false;
>   }
>   
> +static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
> +{
> +    PCIDevice *pdev = &vdev->pdev;
> +
> +    /* QEMU emulates all of MSI & MSIX */
> +    if (pdev->cap_present & QEMU_PCI_CAP_MSIX) {
> +        memset(vdev->emulated_config_bits + pdev->msix_cap, 0xff,
> +               MSIX_CAP_LENGTH);
> +    }
> +
> +    if (pdev->cap_present & QEMU_PCI_CAP_MSI) {
> +        memset(vdev->emulated_config_bits + pdev->msi_cap, 0xff,
> +               vdev->msi_cap_size);
> +    }
> +
> +    if (vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1)) {
> +        vdev->intx.mmap_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
> +                                             vfio_intx_mmap_enable, vdev);
> +        pci_device_set_intx_routing_notifier(&vdev->pdev,
> +                                             vfio_intx_routing_notifier);
> +        vdev->irqchip_change_notifier.notify = vfio_irqchip_change;
> +        kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
> +        if (!vfio_intx_enable(vdev, errp)) {
> +            timer_free(vdev->intx.mmap_timer);
> +            pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
> +            kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
> +            return false;
> +        }
> +    }
> +    return true;
> +}
> +
>   static void vfio_realize(PCIDevice *pdev, Error **errp)
>   {
>       ERRP_GUARD();
> @@ -3142,27 +3174,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>           vfio_bar_quirk_setup(vdev, i);
>       }
>   
> -    /* QEMU emulates all of MSI & MSIX */
> -    if (pdev->cap_present & QEMU_PCI_CAP_MSIX) {
> -        memset(vdev->emulated_config_bits + pdev->msix_cap, 0xff,
> -               MSIX_CAP_LENGTH);
> -    }
> -
> -    if (pdev->cap_present & QEMU_PCI_CAP_MSI) {
> -        memset(vdev->emulated_config_bits + pdev->msi_cap, 0xff,
> -               vdev->msi_cap_size);
> -    }
> -
> -    if (vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1)) {
> -        vdev->intx.mmap_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
> -                                                  vfio_intx_mmap_enable, vdev);
> -        pci_device_set_intx_routing_notifier(&vdev->pdev,
> -                                             vfio_intx_routing_notifier);
> -        vdev->irqchip_change_notifier.notify = vfio_irqchip_change;
> -        kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
> -        if (!vfio_intx_enable(vdev, errp)) {
> -            goto out_deregister;
> -        }
> +    if (!vfio_interrupt_setup(vdev, errp)) {
> +        goto out_unset_idev;
>       }
>   
>       if (vdev->display != ON_OFF_AUTO_OFF) {


