Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9D9C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 12:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaCU6-0002hq-ES; Fri, 11 Jul 2025 08:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uaCTo-0002Nc-5Z
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 08:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uaCTg-00086z-NO
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 08:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752235422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qXA23HO/2Tzbznn5FOz78Bw76jvZ5gTQzFqnsZN+oO0=;
 b=FNg4EuWTtroQ8Ejw+oZlApfPCt8tytEDHQqMeLUc4eAXYNs5Gx+P8IO1TghiTm9dO2b5Ag
 jnUQ1+6r/9t8bcW0Iql6Is/4iak8iVRBxZWewXDnFCN4Kg4E/sMQXLqGuiX57u7VcNBqap
 Mly+QmUAssnStqDvz436oKMuVgpHySk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-VcBzcJ-4Oz-DT1W_lE-Fvw-1; Fri, 11 Jul 2025 08:03:41 -0400
X-MC-Unique: VcBzcJ-4Oz-DT1W_lE-Fvw-1
X-Mimecast-MFC-AGG-ID: VcBzcJ-4Oz-DT1W_lE-Fvw_1752235420
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-455b63c2005so3288475e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 05:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752235420; x=1752840220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qXA23HO/2Tzbznn5FOz78Bw76jvZ5gTQzFqnsZN+oO0=;
 b=vBO2zK94iyJ3zviXRGXQB0uRU9GTsdprfWZ38G5os6HKOCG8y17c9mwoWIPB9mj46f
 TW0JRi625DqYjYfwtaFo20XlrNnj8BaDkg1VmhqOGVbNfdSEGySlODHWyMIUIMIGHpB5
 WOp2Q1uYoeGBIWyhrgTE3oOqkCuqesHrTX5pISbfCCqLDSYe3GxGX5Bto2Klf56M2ZP+
 sXqVPvvdZTr9jsIVaBdZBg4v5ucmsWGI/CsG7pe2WWv4v4Be/pBNjWcW39ANQu10P7wj
 nSWcnX40ux7UofIo/bcHi5yawTLex20OohHvu8JuDzxqSuphhDapJC5hhc3FYonHvPap
 F1bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrRY17DeKAGtjbAsHrgzc2jym2G0FD5Dn6mzCXmBK7LQdDSmalwmn9Pn4mC/Ro8O5P69fZNxeDgTLJ@nongnu.org
X-Gm-Message-State: AOJu0Yw373zRr0tEslzutjvB+d3cBXCnP4rP4o9UY8oKSXR9Fuzjgprq
 IiWythcfB6uL8wej/tl004TnSNX8vDbuca2j3kV0yEUlkBOH0MqT9LAntop5o77t/LiLHJ/uObe
 EAexMbgyd5f3sauIfG5kQ41PlSoLhcNdHTvvwiHc7gZDbL7iFTV1hGE6uma7Kh5Xj
X-Gm-Gg: ASbGnctAFgekaNXK7vvgJ8aGbNDsfQtwPsMuRqMXIeTvO2cQlz6G+yU2q512Ozcoa+A
 VqXI+jHKYUP//+NU6nmP/fMrlExOB+a+JPSG2VHZ+pggO+foGdtqO2pQI2aCOowfJxlW6HsdIL2
 pTl3NuRc+RUiANM8HewFJywTPcjGTqibUuMYDx8g2U0/C/uzSkhMDh6S9o8EbSrZFhNCQroVbYs
 BnrjCDkRJah+hnlYNWgRc26Llu0Q4NEq36hOmQDcwuzWUiaagrZ5qd/jOotQnilwVbyXaixwdSD
 qRMk3t2KkSFAQXn0BZuuiH5qjK0Y9A==
X-Received: by 2002:a05:600c:c4a4:b0:445:1984:247d with SMTP id
 5b1f17b1804b1-454ec13b6b3mr24424875e9.7.1752235419337; 
 Fri, 11 Jul 2025 05:03:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCn+VOzDMzKSTX1ArxhlHZjwfb2plkTBgcMQosYIv8cqDm3ZzGdB0WAee3NHncWE+ig861sw==
X-Received: by 2002:a05:600c:c4a4:b0:445:1984:247d with SMTP id
 5b1f17b1804b1-454ec13b6b3mr24423965e9.7.1752235418567; 
 Fri, 11 Jul 2025 05:03:38 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd541abfsm44497865e9.33.2025.07.11.05.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 05:03:38 -0700 (PDT)
Date: Fri, 11 Jul 2025 14:03:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, Jonathan.Cameron@huawei.com,
 gustavo.romero@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com, pbonzini@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: Re: [PATCH v6 21/36] hw/arm/virt-acpi-build: Let non hotplug ports
 support static acpi-index
Message-ID: <20250711140335.7ba3c87c@fedora>
In-Reply-To: <20250708142437.1344644-22-eric.auger@redhat.com>
References: <20250708142437.1344644-1-eric.auger@redhat.com>
 <20250708142437.1344644-22-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue,  8 Jul 2025 16:23:03 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> hw/arm/virt-acpi-build: Let non hotplug ports support static acpi-index
> 
> Add the requested ACPI bits requested to support static acpi-index
> for non hotplug ports.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>  hw/arm/virt-acpi-build.c | 12 ++++++++++++
>  hw/arm/Kconfig           |  2 ++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index a2f31be9ec..1f936516b3 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -34,6 +34,7 @@
>  #include "hw/core/cpu.h"
>  #include "hw/acpi/acpi-defs.h"
>  #include "hw/acpi/acpi.h"
> +#include "hw/acpi/pcihp.h"
>  #include "hw/nvram/fw_cfg_acpi.h"
>  #include "hw/acpi/bios-linker-loader.h"
>  #include "hw/acpi/aml-build.h"
> @@ -883,6 +884,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      const int *irqmap = vms->irqmap;
>      AcpiTable table = { .sig = "DSDT", .rev = 2, .oem_id = vms->oem_id,
>                          .oem_table_id = vms->oem_table_id };
> +    Aml *pci0_scope;
>  
>      acpi_table_begin(&table, table_data);
>      dsdt = init_aml_allocator();
> @@ -936,6 +938,16 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  
>      aml_append(dsdt, scope);
>  
> +    pci0_scope = aml_scope("\\_SB.PCI0");
> +
> +    aml_append(pci0_scope, build_pci_bridge_edsm());
> +    build_append_pci_bus_devices(pci0_scope, vms->bus);

> +    if (object_property_find(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL)) {
> +        build_append_pcihp_slots(pci0_scope, vms->bus);
> +    }
this part seems to be hotplug specific, is it really necessary in this patch?

> +
> +    aml_append(dsdt, pci0_scope);
> +
>      /* copy AML table into ACPI tables blob */
>      g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len);
>  
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 6ea86534d5..50153331ed 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -34,6 +34,8 @@ config ARM_VIRT
>      select ACPI_HW_REDUCED
>      select ACPI_APEI
>      select ACPI_VIOT
> +    select ACPI_PCIHP
> +    select ACPI_PCI_BRIDGE
>      select VIRTIO_MEM_SUPPORTED
>      select ACPI_CXL
>      select ACPI_HMAT


