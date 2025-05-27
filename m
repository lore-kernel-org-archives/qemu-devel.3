Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D1BC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 12:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJtPH-0005xp-P7; Tue, 27 May 2025 08:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJtP6-0005xU-VF
 for qemu-devel@nongnu.org; Tue, 27 May 2025 08:27:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uJtP0-0000LJ-CF
 for qemu-devel@nongnu.org; Tue, 27 May 2025 08:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748348848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0i6h4e894s0nKCm3mA+2R5S8qNrj+2OrK1R+9fSF0s=;
 b=FWXB+3TfQ4LcNiwLqUpEt+62Wp/NP2IUEHqEdx9aJ8xG7IniHLJzApYbIKKcSfj8wlOe43
 8s3ufi8wq5jrx3eV5MWe6+9bn7DItdivl9A5Uur4L0N+7vCubY2yXYkaRfX+N6f6nj4eAZ
 DwZv5CbzG9PzCFZwgy9Vo42lEPWgrLQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-Ag0BCKy7OF6TCtcCNHwcxw-1; Tue, 27 May 2025 08:27:26 -0400
X-MC-Unique: Ag0BCKy7OF6TCtcCNHwcxw-1
X-Mimecast-MFC-AGG-ID: Ag0BCKy7OF6TCtcCNHwcxw_1748348845
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-441d438a9b7so19325555e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 05:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748348845; x=1748953645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E0i6h4e894s0nKCm3mA+2R5S8qNrj+2OrK1R+9fSF0s=;
 b=VGCZc8Zl7XQR4YLW/1NOvkteWPOqsHtLRboR0Ice+Ozy8of6y6XdMWg7GRV+GkS0Yq
 hculCUneJ9CftzFh3BHrJJ3fqm0oei2GgNGW72BcvrMhRmyokrEEN7PWwhy/lHHPuGlx
 MSTxdYeOcfECDxPYySdPVQfXHeqEKqn/zOR58iY5i0QbFEQBzjKClG3dhiJUuljnSC3f
 hdFU6jbJN82OCy3Zi6ntNK/y34wyeXcmuu+fOInv+0d9G84HrmBfPcdM0lKnumOirCvB
 SdiRGEj1FBcPD0PfgtxKdtz/C4okdsbTWa+AIKFnUIBMmPm9wMF0ue2i1JOzuJaXRrAe
 bQyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJmXDfhzt9dUoHC7fGzitDmptMZQjdje5R4eErqr6rUuBL4J6CU9YLWATTsOd2gkRbVSBFJ9e67bVd@nongnu.org
X-Gm-Message-State: AOJu0YwSxXUXrEL7SrFsjwExLoEaz7MBWYtxsGPnLQbkJKcmxItKBP/6
 xHU1J4XZVOVkrSe0M1hrW1SNmLCUrilm9ejc5HVExNlZcwXDIu6sP4nfizhEiSkvGzEe40Oa7x5
 y/IyPNkdKLIDaQYpsS+Gwn9yjHNGqsu4b5gphyo4kVR2K1avXzPYPh5/D
X-Gm-Gg: ASbGnctlmjRO4z3MCvab9AYaUOPVd+RzTXXGIT/IPfyIGShBNSI7vHW7W972yuHxaCC
 btiF7aRIgh1YH+3TeAMi2jghyZHWOpFh6kSyIow0EG/y5tfnk5weJp4slZPzHyjzkMEIFZ2s/SW
 DVWlBoQoZtKEDnZOVYN5IL7ewP0xHEfVX63Lfg34qGmze2DdxOkuL2/FU8MvGUj9D3fbUdS8JcW
 3iSPG9avn/WGo9yPg4XTpUhWgHRkL1rl0T59oj2jjMHxNEzNWJyFbs0+ycLuzghuUp2HM/u8fy1
 kDV5A9VhWQK4Sk+u6z9W4CjFsm2/d1kH
X-Received: by 2002:a05:600c:4e15:b0:43b:c857:e9d7 with SMTP id
 5b1f17b1804b1-44fd1a229bcmr4459635e9.5.1748348845221; 
 Tue, 27 May 2025 05:27:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMrZn1KPkU+nTxhFGrVnnWm2fEOZPVhprW9bVNEo2OfszhtnRTwJ1KM0aGUxN7ydUgc7SmiQ==
X-Received: by 2002:a05:600c:4e15:b0:43b:c857:e9d7 with SMTP id
 5b1f17b1804b1-44fd1a229bcmr4459315e9.5.1748348844879; 
 Tue, 27 May 2025 05:27:24 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f381465fsm268435155e9.29.2025.05.27.05.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 05:27:24 -0700 (PDT)
Date: Tue, 27 May 2025 14:27:21 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 04/25] hw/pci-host/gpex-acpi: Add native_pci_hotplug
 arg to acpi_dsdt_add_pci_osc
Message-ID: <20250527142721.4abd02a2@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250527074224.1197793-5-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-5-eric.auger@redhat.com>
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

On Tue, 27 May 2025 09:40:06 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Add a new argument to acpi_dsdt_add_pci_osc to be able to disable
> native pci hotplug.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> 
> rfc -> v1:
> - updated the "Allow OS control for all 5 features" comment
> ---
>  hw/pci-host/gpex-acpi.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index 0aba47c71c..f34b7cf25e 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -50,7 +50,7 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
>      }
>  }
>  
> -static void acpi_dsdt_add_pci_osc(Aml *dev)
> +static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
>  {
>      Aml *method, *UUID, *ifctx, *ifctx1, *elsectx, *buf;
>  
> @@ -77,11 +77,12 @@ static void acpi_dsdt_add_pci_osc(Aml *dev)
>      aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
>  
>      /*
> -     * Allow OS control for all 5 features:
> -     * PCIeHotplug SHPCHotplug PME AER PCIeCapability.
> +     * Allow OS control for SHPCHotplug, PME, AER, PCIeCapability,
> +     * and PCIeHotplug depending on enable_native_pcie_hotplug
>       */
> -    aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1F),
> -                              aml_name("CTRL")));
> +    aml_append(ifctx, aml_and(aml_name("CTRL"),
> +               aml_int(0x1E | (enable_native_pcie_hotplug ? 0x1 : 0x0)),
> +               aml_name("CTRL")));
>  
>      ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
>      aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
> @@ -192,7 +193,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>              if (is_cxl) {
>                  build_cxl_osc_method(dev);
>              } else {
> -                acpi_dsdt_add_pci_osc(dev);
> +                acpi_dsdt_add_pci_osc(dev, true);
>              }
>  
>              aml_append(scope, dev);
> @@ -267,7 +268,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>      }
>      aml_append(dev, aml_name_decl("_CRS", rbuf));
>  
> -    acpi_dsdt_add_pci_osc(dev);
> +    acpi_dsdt_add_pci_osc(dev, true);
>  
>      Aml *dev_res0 = aml_device("%s", "RES0");
>      aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));


