Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292A2C3ABB6
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 00:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC5wE-0008K9-NK; Mon, 05 May 2025 20:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uC5wA-0008DS-RR
 for qemu-devel@nongnu.org; Mon, 05 May 2025 20:13:31 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uC5w8-0000EP-Ls
 for qemu-devel@nongnu.org; Mon, 05 May 2025 20:13:30 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22c33e5013aso53806785ad.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 17:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746490406; x=1747095206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=95nicEv/pebZ2dv/tqhPrPqYsFHepwR8uuN7J2iSccQ=;
 b=qUqIL1GrsuE4f8wI6BBlTKGsUoc88cztHI3msJtJ5FLk7e6R1YjTzVS23EhfSOzqnF
 0VQOoaOJLgJjQ+AV9+zPst11sU5KluvUqHY74l8/49/TLqM8gBWvsc1le+0tpcz8U8Wo
 F/R4CXSPe2V7YZGbdICj/ZXK3aICPFVMEnGG43IXPfCSz9/+exMucP5TOsoYQFYRVvPp
 kjS3zhq96WBfSv7FeDJt9gTFvASo5ISh0f6Snd87d3ASFDOaPZDbIu33wr7p7XgJ+SUv
 LHlaAlHIzyCrXHJsAgzxQpqY23M4Q1iOuG4gxgcv2nIiabB2GYR+UjQoVScq3tmbZCZR
 CdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746490406; x=1747095206;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=95nicEv/pebZ2dv/tqhPrPqYsFHepwR8uuN7J2iSccQ=;
 b=m6Sp1y9nI2WSP7TDmQ8k/N8ru57bzurS4IZI7ZvrTtVgrBag3YQqOIcDE//Sd5W1vO
 VOUXINLPc0j5WAl4AU0g7ylabKi2xc5zsWD17elgwsSxCAfxa2tad/kulO6osqbQDAgN
 0JSyBBf5VdP/BCZR1WDQ/6eBH0R5wp0XR31Vc4cYtnGEqzKw69SURKzdyEhWE6CHsh0Q
 rtpcr8Rkwo+bV7ELHi3DGTQelk5r3gjN87LWXJ+t5rikDTdueSvax/oWpTLdYiH7dnPo
 7PzifrelSrEzQfn4vuePFMeYTAgWlBR8iGEKa/3BqaZ8DK/tOm7RdG+T58ugbgxidlav
 teWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfhejZaTf7nJpV9DjG1AHbOuxYkU+MwLrnjjr6lKjd/ULerW56phiohKCD5/fGklnDcje+maZ3Y4eJ@nongnu.org
X-Gm-Message-State: AOJu0YwEdUH6T5/isTOlIT4UZuWnCZYDZSGaQSQ3hI8Bl3MGAS5Ej6q2
 LLfo4dBa6zVm/CKZm/8z6hXysXTpJ1JbRzqsgIBVyFtS85uylAlULPppv6TQp7w=
X-Gm-Gg: ASbGnct102YsMhVUdo2TiWvILLMjG8GL3nt+TxHx5xk+wryD7Re15gNW2s2+Z5UL3KQ
 PzQeYjEzwfh7/QxIiMQgGFZqMjVuM03HLXfVYik3/KMeStRrmVzmgdbMLa4Cl4Q57c3/rGOX+O4
 ER7hHfT2jdyW3kVkGhHFvfewm2uGsGgMBvU1OlwBItwgefJOrB8h+Vf348etkecj6PJEiZgwoU7
 qiqos+mlpEOn32JYcRoLoRCRIeVXCRzTx0lxvbNR9fs1xd1yjs6jfXtWHFtS/0ztXO4CXL/b2kP
 jeStKnDpV7pwNxfh7ETTWsCx3cKfXywrty8X1nrXjNHu7A/PY0IysWnVrLOo1SXD2cXnkeK2IfR
 r4tKa0OugV+2jv7wrcXU=
X-Google-Smtp-Source: AGHT+IG3lB8L+SJPwtQ1ENJHVQlKxNcq3fXcxK9NyiptNcEgfNom1f+84OVVUdlhwp7BVX3xmk9zLQ==
X-Received: by 2002:a17:902:c408:b0:223:54e5:bf4b with SMTP id
 d9443c01a7336-22e1ea7f87emr141150145ad.25.1746490406482; 
 Mon, 05 May 2025 17:13:26 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b400:8604:71fc:f75a:e2f5:e7b5?
 ([2804:7f0:b400:8604:71fc:f75a:e2f5:e7b5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e15228f9csm61545515ad.178.2025.05.05.17.13.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 17:13:26 -0700 (PDT)
Message-ID: <560db275-200c-4e68-bc39-8b9ec9119c9e@linaro.org>
Date: Mon, 5 May 2025 21:13:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [RFC 08/24] hw/pci-host/gpex-acpi: Split host bridge OSC and DSM
 generation
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com
References: <20250428102628.378046-1-eric.auger@redhat.com>
 <20250428102628.378046-9-eric.auger@redhat.com>
Content-Language: en-US
In-Reply-To: <20250428102628.378046-9-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Eric,

On 4/28/25 07:25, Eric Auger wrote:
> acpi_dsdt_add_pci_osc() name is confusing as it gives the impression
> it appends the _OSC method but in fact it also appends the _DSM method
> for the host bridge. Let's split the function into two separate ones
> and let them return the method Aml pointer instead. This matches the
> way it is done on x86 (build_q35_osc_method). In a subsequent patch
> we will replace the gpex method by the q35 implementation that will
> become shared between ARM and x86.
> 
> acpi_dsdt_add_host_bridge_methods is a new top helper that generates
> both the _OSC and _DSM methods.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/pci-host/gpex-acpi.c | 31 +++++++++++++++++++++----------
>   1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index 4016089893..9d9f5ed7c6 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -50,13 +50,10 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
>       }
>   }
>   
> -static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
> +static Aml *build_host_bridge_osc(bool enable_native_pcie_hotplug)
>   {
> -    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx, *buf;
> +    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx;
>   
> -    /* Declare an _OSC (OS Control Handoff) method */
> -    aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
> -    aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
>       method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
>       aml_append(method,
>           aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
> @@ -103,9 +100,13 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
>                                  aml_name("CDW1")));
>       aml_append(elsectx, aml_return(aml_arg(3)));
>       aml_append(method, elsectx);
> -    aml_append(dev, method);
> +    return method;
> +}
>   
> -    method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
> +static Aml *build_host_bridge_dsm(void)
> +{
> +    Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
> +    Aml *UUID, *ifctx, *ifctx1, *buf;
>   
>       /* PCI Firmware Specification 3.0
>        * 4.6.1. _DSM for PCI Express Slot Information
> @@ -124,7 +125,17 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
>       byte_list[0] = 0;
>       buf = aml_buffer(1, byte_list);
>       aml_append(method, aml_return(buf));
> -    aml_append(dev, method);
> +    return method;
> +}
> +
> +static void acpi_dsdt_add_host_bridge_methods(Aml *dev,
> +                                              bool enable_native_pcie_hotplug)
> +{
> +    aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
> +    aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
> +    /* Declare an _OSC (OS Control Handoff) method */
> +    aml_append(dev, build_host_bridge_osc(enable_native_pcie_hotplug));
> +    aml_append(dev, build_host_bridge_dsm());
>   }
>   
>   void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
> @@ -193,7 +204,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>               if (is_cxl) {
>                   build_cxl_osc_method(dev);
>               } else {
> -                acpi_dsdt_add_pci_osc(dev, true);
> +                acpi_dsdt_add_host_bridge_methods(dev, true);
>               }
>   
>               aml_append(scope, dev);
> @@ -268,7 +279,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>       }
>       aml_append(dev, aml_name_decl("_CRS", rbuf));
>   
> -    acpi_dsdt_add_pci_osc(dev, true);
> +    acpi_dsdt_add_host_bridge_methods(dev, true);
>   
>       Aml *dev_res0 = aml_device("%s", "RES0");
>       aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

