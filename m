Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608B0C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 14:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTMhY-0004mL-Ln; Mon, 15 Jul 2024 10:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTMhS-0004kD-UG
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 10:29:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTMhQ-00050p-Ve
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 10:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721053748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ws5PhTNz0P/VmMKF7+lfhX1BUlSXeiJ4GRC/jFYnuDo=;
 b=f9qBWMeDflJWQ/OWM5lbxGBBAHEMCRcGECtypRKjofrgb14wo0cRlwFnEILeSxgyHCl/uO
 HeRC8ItNeAIwPVBLQJKsHtSCr/pjf7TK95JdiP54TtcmvoOYr/FsuTO8F5IscjXOXbXAA3
 Gdhk3EAH1o6XeZWjc/YUjJwCMNpNJXE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-uCAeWkUmML6TWi2x8A8COQ-1; Mon, 15 Jul 2024 10:29:06 -0400
X-MC-Unique: uCAeWkUmML6TWi2x8A8COQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52e97e5e3a8so4355965e87.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 07:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721053745; x=1721658545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ws5PhTNz0P/VmMKF7+lfhX1BUlSXeiJ4GRC/jFYnuDo=;
 b=NFoTdVgi7H/IoWUkQYwJetDGzy6Fnk5vmxuer9TkgIOUE0oH6ScLzJVw8ZLkTiVIOE
 O3g56Wumw/epPzZat7GTs0qQz3aeXwjXeKaDVT6jvm6cxapZuRw7z9P3gTpj8wkm/g8F
 ZQFF+0H8rLYcskOAKer+9y9BH/i7EMtBEY/m0XlyflTy4m97R381csATz+EpFjV8SVhn
 hyksR+QW7KpG2l/egIyjSInapx1b3/ApCjuVghBsCw0dm0R8b8n0h0AREB9KCUjhB+Qh
 jo2rvWQEzoLSz8DIN7+AxIrF2o4T95vI1EQ/IuBkG5MfuRJXRv32fDle6sI0SlZI3fM6
 e99Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6wPYTNur2fNcu52tLCDxrSeLIZFJGVnZWVrnFxStFzqU3DNAEnhX2LSzI4ovAF7MQ3kNzSxwCZmxxTYfEng+x0BCRkgA=
X-Gm-Message-State: AOJu0Yxan0r0i/v0n4N34wXochD251oVEi0SfC1oJi87N5kxRqrcACt3
 Ym7xB8EHfzbKgu4QwI7n5fdtE/ykgA6saojg/kGGhrzv74u/eaHO+dPVeCxDi4y8OwTgCY54aLX
 AbPb/sVLtQqloW50voxxRvcX9N9tS7Wt800+B/E/wdKDYfvAD0fGE
X-Received: by 2002:a19:7508:0:b0:52e:9e70:d068 with SMTP id
 2adb3069b0e04-52eb9991982mr11692867e87.4.1721053745078; 
 Mon, 15 Jul 2024 07:29:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS/AvLqLDzlSBdLrXM7r1k4epfASzSntpsp9ap0YGiwKCK/6CpZnxUO86eJKxb6L4kz1F6rg==
X-Received: by 2002:a19:7508:0:b0:52e:9e70:d068 with SMTP id
 2adb3069b0e04-52eb9991982mr11692846e87.4.1721053744689; 
 Mon, 15 Jul 2024 07:29:04 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef44b4sm89667445e9.42.2024.07.15.07.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 07:29:04 -0700 (PDT)
Date: Mon, 15 Jul 2024 16:29:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <linuxarm@huawei.com>,
 <linux-cxl@vger.kernel.org>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Dave
 Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, <eduardo@habkost.net>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v5 07/13] hw/pci-bridge: Add acpi_uid property to
 TYPE_PXB_BUS
Message-ID: <20240715162903.3573fb47@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240712110837.1439736-8-Jonathan.Cameron@huawei.com>
References: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
 <20240712110837.1439736-8-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 12 Jul 2024 12:08:11 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Enable ACPI table creation for PCI Expander Bridges to be independent
> of PCI internals.  Note that the UID is currently the PCI bus number.
> This is motivated by the forthcoming ACPI Generic Port SRAT entries
> which can be made completely independent of PCI internals.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Tested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> v5: Add missing property description.
> ---
>  hw/pci-bridge/pci_expander_bridge.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 0411ad31ea..b94cb85cfb 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -85,12 +85,25 @@ static uint16_t pxb_bus_numa_node(PCIBus *bus)
>      return pxb->numa_node;
>  }
>  
> +static void prop_pxb_uid_get(Object *obj, Visitor *v, const char *name,
> +                             void *opaque, Error **errp)
> +{
> +    uint32_t uid = pci_bus_num(PCI_BUS(obj));
> +
> +    visit_type_uint32(v, name, &uid, errp);
> +}
> +
>  static void pxb_bus_class_init(ObjectClass *class, void *data)
>  {
>      PCIBusClass *pbc = PCI_BUS_CLASS(class);
>  
>      pbc->bus_num = pxb_bus_num;
>      pbc->numa_node = pxb_bus_numa_node;
> +
> +    object_class_property_add(class, "acpi_uid", "uint32",
> +                              prop_pxb_uid_get, NULL, NULL, NULL);
> +    object_class_property_set_description(class, "acpi_uid",
> +        "ACPI Unique ID used to distinguish this PCI Host Bridge / ACPI00016");
>  }
>  
>  static const TypeInfo pxb_bus_info = {


