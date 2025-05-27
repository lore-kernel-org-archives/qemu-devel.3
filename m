Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C10C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 12:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJtWo-0001me-Bq; Tue, 27 May 2025 08:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJtWl-0001m4-Tf
 for qemu-devel@nongnu.org; Tue, 27 May 2025 08:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJtWi-0001RQ-4Y
 for qemu-devel@nongnu.org; Tue, 27 May 2025 08:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748349325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dcGyCCr0YdUesOdX9vj/ueLKGtD9L/19RsFWfNjZGPw=;
 b=H5wga9Fb9jhHwI22VvN+hMO9X8SpEHeUzwOQHA3maFFdRPGVwtT2O7j8Hb3+7nC6lEViqI
 kBMWynq1w7V/NqrWeRP/6/p+lX3trM3Z8qky/7EfzGEp0d+NI7IIFCG4xphI6lsAfKYlML
 Ra8s92lOC4FlykbEgh0aB6NmS7psnu4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-FJslqAJmMb-rd17hOZoFTA-1; Tue, 27 May 2025 08:35:24 -0400
X-MC-Unique: FJslqAJmMb-rd17hOZoFTA-1
X-Mimecast-MFC-AGG-ID: FJslqAJmMb-rd17hOZoFTA_1748349323
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a37a0d1005so1878474f8f.3
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 05:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748349323; x=1748954123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dcGyCCr0YdUesOdX9vj/ueLKGtD9L/19RsFWfNjZGPw=;
 b=u10Nn3ae5mmaHFJM9XFH4da+oAME8gxr+Tl9YIPFzX29CuAcQU0KI4xx53bL6+NRQv
 HnpZ6phv/Z0kPIq33XqL+Z8NZwg3DVONdV64R8FV0QvSieLZkLIgH37pSk6qcOT4SMnl
 A3jqlCZ6ru2lCDJsauPOvQR57i8/xzS5YwlJ+vfL32slOWPaMVdLRwRCYVu/yCjAj9FM
 KcdXA3OvEsTGdSGhhtrwvH1R3IVRIoW4ncbqlxS//s9kzSUDR3Sxyij5AALaQ+qgbMq1
 HQQCUdoBQLXR037GnjurfbCG9PlWTzak7YST9kvGBUcr0C4JOrNDSMd4LW6ah+u7Xqm9
 Rc1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnL0SMeHM8owUpHQsslxuxkhoTafPbiyPni+qmwr31zFouneJ7iQJAb3sGevNeDQjJReQwg7aannwf@nongnu.org
X-Gm-Message-State: AOJu0Yyp+eQ0Ryj2cJfp4xhEWobwil6BdrLscCjkrISLmp+OISJEEb+j
 gms5uiST/DJYG2oKYbU1uCBABXvFLYnCEWIEtMm3T7ziKjBKyXGb9D+uwxm4COADv8uHayNsnop
 iwPmeYn7g41SbY13cxLpKg9yhwm773oIvlAFpvbKVgPcsH5ZSjIUEpyK2
X-Gm-Gg: ASbGncuiBetkONY7Q4kNb7zTlHkik9Lm/M2PYuc28HNFRJcDdGPdj8B1Cc6+VxDDlRp
 nWWbyzSqa7rkFeagZPD3+xPlEAO79tEgKDsABa0kyfPhcoOEocPu0W3imPI3BZB+gTIbvYygQsi
 lhuk2Ah06S0tYi0aGvPpGM+rRbUt1VDaC1/+t5EfOWozDNlyYSuMe99Tub134EsTMWL2SOgTTh6
 Xe6oBEonQ1tMerm5/oHjgPF88iDXOZi4hYqLN5I1fW+noMlyKHtoi4o2jYyTatYv6L/nzh1Kb4q
 wZnWQ96pcf8IbKAdUz7thBrBkaTI2nZJ
X-Received: by 2002:a05:6000:288e:b0:3a3:652d:1640 with SMTP id
 ffacd0b85a97d-3a4cb461598mr10329059f8f.2.1748349323098; 
 Tue, 27 May 2025 05:35:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFh8TCtuq57Pqsz8t7+aGE6m++K2ItL7R1nmjVS7VNY1aaIZ6YvpXq5Hh7X2qMU/iafKbSWPA==
X-Received: by 2002:a05:6000:288e:b0:3a3:652d:1640 with SMTP id
 ffacd0b85a97d-3a4cb461598mr10329027f8f.2.1748349322661; 
 Tue, 27 May 2025 05:35:22 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cfed7257sm9238318f8f.49.2025.05.27.05.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 05:35:22 -0700 (PDT)
Date: Tue, 27 May 2025 14:35:21 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 07/25] hw/i386/acpi-build: Turn build_q35_osc_method
 into a generic method
Message-ID: <20250527143521.0dcd8f8a@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250527074224.1197793-8-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-8-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

On Tue, 27 May 2025 09:40:09 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> GPEX acpi_dsdt_add_pci_osc() does basically the same as
> build_q35_osc_method().
> 
> Rename build_q35_osc_method() into build_pci_host_bridge_osc_method()
> and move it into hw/acpi/aml-build.c. In a subsequent patch we will
> use this later in place of acpi_dsdt_add_pci_osc().
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  include/hw/acpi/aml-build.h |  2 ++
>  hw/acpi/aml-build.c         | 50 ++++++++++++++++++++++++++++++++++
>  hw/i386/acpi-build.c        | 54 ++-----------------------------------
>  3 files changed, 54 insertions(+), 52 deletions(-)
> 
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index c18f681342..177d60b414 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -508,4 +508,6 @@ void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
>  void build_spcr(GArray *table_data, BIOSLinker *linker,
>                  const AcpiSpcrData *f, const uint8_t rev,
>                  const char *oem_id, const char *oem_table_id, const char *name);
> +
> +Aml *build_pci_host_bridge_osc_method(bool enable_native_pcie_hotplug);
>  #endif
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c

I'd suggest to use hw/acpi/pci.c for PCI stuff instead of generic aml-build.c

> index f8f93a9f66..ba1dfe0b52 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -2614,3 +2614,53 @@ Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source)
>  
>      return var;
>  }
> +
> +Aml *build_pci_host_bridge_osc_method(bool enable_native_pcie_hotplug)
> +{
> +    Aml *if_ctx;
> +    Aml *if_ctx2;
> +    Aml *else_ctx;
> +    Aml *method;
> +    Aml *a_cwd1 = aml_name("CDW1");
> +    Aml *a_ctrl = aml_local(0);
> +
> +    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
> +    aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
> +
> +    if_ctx = aml_if(aml_equal(
> +        aml_arg(0), aml_touuid("33DB4D5B-1FF7-401C-9657-7441C03DD766")));
> +    aml_append(if_ctx, aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
> +    aml_append(if_ctx, aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
> +
> +    aml_append(if_ctx, aml_store(aml_name("CDW3"), a_ctrl));
> +
> +    /*
> +     * Always allow native PME, AER (no dependencies)
> +     * Allow SHPC (PCI bridges can have SHPC controller)
> +     * Disable PCIe Native Hot-plug if ACPI PCI Hot-plug is enabled.
> +     */
> +    aml_append(if_ctx, aml_and(a_ctrl,
> +        aml_int(0x1E | (enable_native_pcie_hotplug ? 0x1 : 0x0)), a_ctrl));
> +
> +    if_ctx2 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
> +    /* Unknown revision */
> +    aml_append(if_ctx2, aml_or(a_cwd1, aml_int(0x08), a_cwd1));
> +    aml_append(if_ctx, if_ctx2);
> +
> +    if_ctx2 = aml_if(aml_lnot(aml_equal(aml_name("CDW3"), a_ctrl)));
> +    /* Capabilities bits were masked */
> +    aml_append(if_ctx2, aml_or(a_cwd1, aml_int(0x10), a_cwd1));
> +    aml_append(if_ctx, if_ctx2);
> +
> +    /* Update DWORD3 in the buffer */
> +    aml_append(if_ctx, aml_store(a_ctrl, aml_name("CDW3")));
> +    aml_append(method, if_ctx);
> +
> +    else_ctx = aml_else();
> +    /* Unrecognized UUID */
> +    aml_append(else_ctx, aml_or(a_cwd1, aml_int(4), a_cwd1));
> +    aml_append(method, else_ctx);
> +
> +    aml_append(method, aml_return(aml_arg(3)));
> +    return method;
> +}
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 4f8572eebe..91945f716c 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1111,56 +1111,6 @@ static Aml *build_q35_dram_controller(const AcpiMcfgInfo *mcfg)
>      return dev;
>  }
>  
> -static Aml *build_q35_osc_method(bool enable_native_pcie_hotplug)
> -{
> -    Aml *if_ctx;
> -    Aml *if_ctx2;
> -    Aml *else_ctx;
> -    Aml *method;
> -    Aml *a_cwd1 = aml_name("CDW1");
> -    Aml *a_ctrl = aml_local(0);
> -
> -    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
> -    aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
> -
> -    if_ctx = aml_if(aml_equal(
> -        aml_arg(0), aml_touuid("33DB4D5B-1FF7-401C-9657-7441C03DD766")));
> -    aml_append(if_ctx, aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
> -    aml_append(if_ctx, aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
> -
> -    aml_append(if_ctx, aml_store(aml_name("CDW3"), a_ctrl));
> -
> -    /*
> -     * Always allow native PME, AER (no dependencies)
> -     * Allow SHPC (PCI bridges can have SHPC controller)
> -     * Disable PCIe Native Hot-plug if ACPI PCI Hot-plug is enabled.
> -     */
> -    aml_append(if_ctx, aml_and(a_ctrl,
> -        aml_int(0x1E | (enable_native_pcie_hotplug ? 0x1 : 0x0)), a_ctrl));
> -
> -    if_ctx2 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
> -    /* Unknown revision */
> -    aml_append(if_ctx2, aml_or(a_cwd1, aml_int(0x08), a_cwd1));
> -    aml_append(if_ctx, if_ctx2);
> -
> -    if_ctx2 = aml_if(aml_lnot(aml_equal(aml_name("CDW3"), a_ctrl)));
> -    /* Capabilities bits were masked */
> -    aml_append(if_ctx2, aml_or(a_cwd1, aml_int(0x10), a_cwd1));
> -    aml_append(if_ctx, if_ctx2);
> -
> -    /* Update DWORD3 in the buffer */
> -    aml_append(if_ctx, aml_store(a_ctrl, aml_name("CDW3")));
> -    aml_append(method, if_ctx);
> -
> -    else_ctx = aml_else();
> -    /* Unrecognized UUID */
> -    aml_append(else_ctx, aml_or(a_cwd1, aml_int(4), a_cwd1));
> -    aml_append(method, else_ctx);
> -
> -    aml_append(method, aml_return(aml_arg(3)));
> -    return method;
> -}
> -
>  static void build_acpi0017(Aml *table)
>  {
>      Aml *dev, *scope, *method;
> @@ -1231,7 +1181,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
>          aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
>          aml_append(dev, aml_name_decl("_UID", aml_int(pcmc->pci_root_uid)));
> -        aml_append(dev, build_q35_osc_method(!pm->pcihp_bridge_en));
> +        aml_append(dev, build_pci_host_bridge_osc_method(!pm->pcihp_bridge_en));
>          aml_append(dev, aml_pci_edsm());
>          aml_append(sb_scope, dev);
>          if (mcfg_valid) {
> @@ -1353,7 +1303,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>                  aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
>  
>                  /* Expander bridges do not have ACPI PCI Hot-plug enabled */
> -                aml_append(dev, build_q35_osc_method(true));
> +                aml_append(dev, build_pci_host_bridge_osc_method(true));
>              } else {
>                  aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
>              }


