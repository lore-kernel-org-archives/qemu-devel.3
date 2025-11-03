Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9782CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 16:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFxbg-0006tX-19; Mon, 03 Nov 2025 11:40:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFxbd-0006tN-OT
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 11:40:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFxba-0001pR-6D
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 11:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762188025;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qYdigO7E7d/2aCy/B6THt/OXTaB8dbhzPGoVuPDxj84=;
 b=CJZzEqM8w3Ma1IkmXOi9nNHnuA+dee1VlVQ62lIJx4vtI5kS5P1dMW6uxSYHgTvswyPLhj
 i8CM8U3gQ1HqeEYlZpAlZMrLzH3WgY95LzdjPXir+EK7+7B7sABjHwjCOwCIncuI8wBXqX
 uUjjtjs9nLJa8s/Fv1eOAxiBQhTSeH4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-6txfZh33OxKsbqbUUaFzUg-1; Mon, 03 Nov 2025 11:40:23 -0500
X-MC-Unique: 6txfZh33OxKsbqbUUaFzUg-1
X-Mimecast-MFC-AGG-ID: 6txfZh33OxKsbqbUUaFzUg_1762188022
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-429c17b29f3so2125372f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 08:40:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188022; x=1762792822;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qYdigO7E7d/2aCy/B6THt/OXTaB8dbhzPGoVuPDxj84=;
 b=q0I3+0yDgGm6Q6a/i6waj+dNtvu6QKUGzZF6taymKR24g15cGiNXQSPq3BPs9mFfI5
 LDJvy+7HQWu3cOhu1PeR5sK6Qm1sZWdVIe9u5aA0pfZytJlhrwrPfLThkIZXMcLsYO9w
 xf5xpEHBHcxp0+cMV3YHA4YKyjlfBGStah23EYjY8JLJsR/QyWiSg7W3MxU8L4Id98cg
 zYpXaBu5yu1SuW9ir6EhomHxLJ7Mdce2Jd/MgFOAwZIzpK6mNhptRexYTSo29yOCsVIq
 qhbI8CVnsRKzvYTIiEQxg9NYoWtWBnrQ2DCu1i8NwN445Uei82m+8KfJc92HaHMBtFWz
 q5YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxXmmez+WZ6OOzu8YkSymUAt45V444ZbC7cH3wuydRYHOaFaXIFXL33JmvH2H9AkZ0hjM+jRNBio5I@nongnu.org
X-Gm-Message-State: AOJu0YxRV/MAPLpmiad3TC8JRiWAqmkgAfOGxnNjeZ1nkLPFYFapR42N
 4ucZ1/6kZtvkReTZ6NP8/bJajTtpOg5Nu6DxJ6xrGrwB7ABDVUEqvqYlRJmUmpQ4Bj7qpxW4vXI
 up8HvWt7YfPDvI383bWzoSmatLIcteDKn1kP+8Lv/fterkYcX2GGqvbSr
X-Gm-Gg: ASbGncuKCMwL65v7LyEfiV+3yQjYg3Z0cZ+Gm06T8V2fgBHpC2J5XOHagS3zjSPvJ/u
 4qdgXgdNnrJ1favU37ZjNZ2Gvim9URYohchAUnKJCsGhq/krCHsdmu25eL8MsCSxfcK6aoR0ojO
 h4tYCzukmYjIVBTc1oypDc3fHgFEesPYLzM0Iq/tQqSKgPIALpbFScpZ9yIg3UDlRHegozbWbv/
 ssboDfizzqk+6/vXqUgquzMaJNLNp68t/O5w3dFEygN6h9nbqVUrfhVzOJML6053OzFVy/zUeeC
 vXL7oc3XTxXVezWFtytpHuhBHOGNt46isbPuwlvNlrbVXd8Yc71USpiQtODEifEvqM8qTlqMKQD
 Y9Z0t8JeIsmW+GtyZd07nt9nDOYL5cG569CiVdtvo6/UBJA==
X-Received: by 2002:a05:600c:4447:b0:475:de68:3c2e with SMTP id
 5b1f17b1804b1-477308b0a80mr118011285e9.40.1762188022442; 
 Mon, 03 Nov 2025 08:40:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcmDmBDDTblegsTnzis97lGhsb1+OfuXi/Vp+c3nUXcADVV8mT/x//FbSMd+Cqs1qmqFWuTg==
X-Received: by 2002:a05:600c:4447:b0:475:de68:3c2e with SMTP id
 5b1f17b1804b1-477308b0a80mr118010915e9.40.1762188022021; 
 Mon, 03 Nov 2025 08:40:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c2e677csm164317705e9.3.2025.11.03.08.40.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 08:40:21 -0800 (PST)
Message-ID: <64dc9240-82cd-460a-8834-45590aec7f25@redhat.com>
Date: Mon, 3 Nov 2025 17:40:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/32] hw/pci/pci: Move pci_init_bus_master() after
 adding device to bus
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 kjaju@nvidia.com
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-8-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251031105005.24618-8-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 10/31/25 11:49 AM, Shameer Kolothum wrote:
> During PCI hotplug, in do_pci_register_device(), pci_init_bus_master()
> is called before storing the pci_dev pointer in bus->devices[devfn].
>
> This causes a problem if pci_init_bus_master() (via its
> get_address_space() callback) attempts to retrieve the device using
> pci_find_device(), since the PCI device is not yet visible on the bus.
>
> Fix this by moving the pci_init_bus_master() call to after the device
> has been added to bus->devices[devfn].
>
> This prepares for a subsequent patch where the accel SMMUv3
> get_address_space() callback retrieves the pci_dev to identify the
> attached device type.
>
> No functional change intended.
>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/pci/pci.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index c9932c87e3..9693d7f10c 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1370,9 +1370,6 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>      pci_dev->bus_master_as.max_bounce_buffer_size =
>          pci_dev->max_bounce_buffer_size;
>  
> -    if (phase_check(PHASE_MACHINE_READY)) {
> -        pci_init_bus_master(pci_dev);
> -    }
>      pci_dev->irq_state = 0;
>      pci_config_alloc(pci_dev);
>  
> @@ -1416,6 +1413,9 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>      pci_dev->config_write = config_write;
>      bus->devices[devfn] = pci_dev;
>      pci_dev->version_id = 2; /* Current pci device vmstate version */
> +    if (phase_check(PHASE_MACHINE_READY)) {
> +        pci_init_bus_master(pci_dev);
> +    }
>      return pci_dev;
>  }
>  


