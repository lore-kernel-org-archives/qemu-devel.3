Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D477FC71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 11:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSaFK-0004C8-Vk; Fri, 20 Jun 2025 07:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSaEg-00040M-1F
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 07:48:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSaEd-0002Yd-3X
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 07:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750420120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nrtutyhe3vPjXSe4x5cAA5qlcu9MfmOyH4uCxbGo/+A=;
 b=Jb8F0EGMOW+METDZa+q2ycOUrxl4lWJCO14ILUtpPUeiE0KKRNjMoVjILZh5oGxIdAtFYz
 lp+wO8pudy4O/YoprnzHsJ7j4OHxc6Xz6VoEz4KMZGPEZbeSpDmROwM5z7rcg9uH8Q6W5m
 NgDsKOadJmCIQvfdB6vC6J6C5stBD68=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-H6R9EAhoMwOK7twIf9zb1w-1; Fri, 20 Jun 2025 07:48:39 -0400
X-MC-Unique: H6R9EAhoMwOK7twIf9zb1w-1
X-Mimecast-MFC-AGG-ID: H6R9EAhoMwOK7twIf9zb1w_1750420119
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4edf5bb4dso1398987f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 04:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750420118; x=1751024918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nrtutyhe3vPjXSe4x5cAA5qlcu9MfmOyH4uCxbGo/+A=;
 b=N+suZA+c2Ue/1xCDhn7cs1mhKk/3Cw15Vo+3N5enUjMlYHVKCxW4ntcOr/LshKC05y
 Ryb7E7pvJApTM35J889DccmAQ9+nnsrTLX7oJi39DZ8glIyyP5p5rE7TP0C/ah4oNJDy
 CeGVZtiJnDEupDAakZx9wJPkM0/5Uw7E2h57k/2YvSAHmKns53kWnLibeGBse1P+Tp1H
 hhidZFYaL+OT/uHAzCGdviL4JFDAIljRZ5kft39WW0qz78QuVodNGhEap+fpMgmch2Hy
 YfEGSA1UmHOuFHsa6bxA+9wT0c1MbS/nz33A/u4u7MDpNu0t+GG5QYz4sNhau9zqjmxY
 z6SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3w2fsdkiGmkaIAmgZIHVR0kREs+cjfhgLBF6a4wXSN7xlrLtiMc8mCc6ZYz/orLdvD+CJ7e500LJd@nongnu.org
X-Gm-Message-State: AOJu0YyY/d3KjVyAb1uUzoALF8e3TynkXl4DxzRcPvrli4E49JtiFUvp
 jhYMIx+lv2DiEtUf0fk95QVhnnAX+kWviUKGsY7xLdPxnbchoVDFcuQJD1A/WqvKlBNTCcdLFOe
 iQGgRA2Be/IuI7oDbfjopn5czSU/hISOD6Fj+sDNxcX8PDM203StlI/hl
X-Gm-Gg: ASbGnctHmZITQIFwAV2UM+Yi8dkcH2H1sQsTICmERjMklB9Cq7haKsRvXBlUL/8fu5m
 zxrpcLMJDkaAxcssHcdClXJc6WqZxsdXbmcIZjHqW3KWq0fBu2X20zIeC8QHAxfboBVmZSMEfU3
 Tuqc0co3ZwT/4oImsPTykWNe5VmCH1XaiEwHb72kumW9OCIQPt2VVS8gm3TqrVlElBjHuzm62SH
 jDScax5mpL3IW0dtBxbBwRpMjVN7Ek1GldT0apmNWWOvYaoIFFWC86Hcc/b7Ry6HSeRdkn4/PVD
 ZIqU8KGXCOde
X-Received: by 2002:a05:6000:18a4:b0:3a5:527b:64c6 with SMTP id
 ffacd0b85a97d-3a6d12bb700mr2313682f8f.1.1750420118511; 
 Fri, 20 Jun 2025 04:48:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfVVd09eRNyrPL6rNYMIEosnlkscXQgFr8nIp8vNLRO1rhMgrCHeKReeLjM4HQkx/1TAXhcA==
X-Received: by 2002:a05:6000:18a4:b0:3a5:527b:64c6 with SMTP id
 ffacd0b85a97d-3a6d12bb700mr2313648f8f.1.1750420118109; 
 Fri, 20 Jun 2025 04:48:38 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f19e7dsm1905605f8f.38.2025.06.20.04.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 04:48:37 -0700 (PDT)
Date: Fri, 20 Jun 2025 13:48:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v3 06/29] hw/pci-host/gpex-acpi: Split host bridge OSC
 and DSM generation
Message-ID: <20250620134836.5f467b6e@fedora>
In-Reply-To: <20250616094903.885753-7-eric.auger@redhat.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-7-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, 16 Jun 2025 11:46:35 +0200
Eric Auger <eric.auger@redhat.com> wrote:

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

I'd get rid of wrapper, but it's not something that worth to fight over,
so

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> We take the opportunity to move SUPP and CTRL in the _osc method
> that use them.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v2 -> v3:
> - moved
>     aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
>     aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
>   into the _osc function. (Jonathan)
>   hence discarded Gustavo's and Igor's R-bs
> ---
>  hw/pci-host/gpex-acpi.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index f34b7cf25e..80fc2bf032 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -50,14 +50,12 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
>      }
>  }
>  
> -static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
> +static Aml *build_host_bridge_osc(bool enable_native_pcie_hotplug)
>  {
> -    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx, *buf;
> -
> -    /* Declare an _OSC (OS Control Handoff) method */
> -    aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
> -    aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
> +    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx;
>      method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
> +    aml_append(method, aml_name_decl("SUPP", aml_int(0)));
> +    aml_append(method, aml_name_decl("CTRL", aml_int(0)));
>      aml_append(method,
>          aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
>  
> @@ -103,9 +101,13 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
>                                 aml_name("CDW1")));
>      aml_append(elsectx, aml_return(aml_arg(3)));
>      aml_append(method, elsectx);
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
>      /* PCI Firmware Specification 3.0
>       * 4.6.1. _DSM for PCI Express Slot Information
> @@ -124,7 +126,15 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
>      byte_list[0] = 0;
>      buf = aml_buffer(1, byte_list);
>      aml_append(method, aml_return(buf));
> -    aml_append(dev, method);
> +    return method;
> +}
> +
> +static void acpi_dsdt_add_host_bridge_methods(Aml *dev,
> +                                              bool enable_native_pcie_hotplug)
> +{
> +    /* Declare an _OSC (OS Control Handoff) method */
> +    aml_append(dev, build_host_bridge_osc(enable_native_pcie_hotplug));
> +    aml_append(dev, build_host_bridge_dsm());
>  }
>  
>  void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
> @@ -193,7 +203,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>              if (is_cxl) {
>                  build_cxl_osc_method(dev);
>              } else {
> -                acpi_dsdt_add_pci_osc(dev, true);
> +                acpi_dsdt_add_host_bridge_methods(dev, true);
>              }
>  
>              aml_append(scope, dev);
> @@ -268,7 +278,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>      }
>      aml_append(dev, aml_name_decl("_CRS", rbuf));
>  
> -    acpi_dsdt_add_pci_osc(dev, true);
> +    acpi_dsdt_add_host_bridge_methods(dev, true);
>  
>      Aml *dev_res0 = aml_device("%s", "RES0");
>      aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));


