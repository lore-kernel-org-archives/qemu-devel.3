Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024FEC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaEAL-0000DO-UR; Fri, 11 Jul 2025 09:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uaE5q-00072e-Dj
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:47:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uaE5n-0001He-Gq
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752241628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tzu7gL5TEUXY0GgzHKCVlqvUJUK48vtiNAdklCGRYpE=;
 b=MbkTHRIsx6wlsZts49+lO67QajNgWnAnB4AYWRVAMsa9bu7jXn+EZwxyO3xRi8o9ehmH6b
 t6LTf7pxizPOlYGuN3LURneTkryCHTSfQjEwwm96tU1HfqPy7+RN5hCleyQWxyJ6egk+Jf
 MAxcsqrupx6oLROgTquybb1kYx6yCHk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-tOdNKqeJOJ2m14GhjQ1cjA-1; Fri, 11 Jul 2025 09:47:06 -0400
X-MC-Unique: tOdNKqeJOJ2m14GhjQ1cjA-1
X-Mimecast-MFC-AGG-ID: tOdNKqeJOJ2m14GhjQ1cjA_1752241625
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-453018b4ddeso11197315e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752241625; x=1752846425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tzu7gL5TEUXY0GgzHKCVlqvUJUK48vtiNAdklCGRYpE=;
 b=sx4B3//OIHYIL8tbKYFM1f6H7RQWl7T84/1pYW/uaV4kAVIvQCklJ/WYFp5sKY8dto
 XH3/cK2UhY4jGEqF34WXaMOh7xSwOHQOUuvZkrbwPHf3x+hPlfr/PloQ7Ig1vZOigUTW
 aR4USb+xtplghWuyznPX6d10Ripjpwt8J2VB3TU9u7Po5L0yeoWHqXotTTZE8zxEbvL5
 0kLNvXIhubcd1ZRrlYB6ZMsVDKqo7G6/Hi5KFeiCTL1D3KpAflpInFfOrbBslKTj303h
 EafWrfC/a+h75QUe71ncrtZfwi2LdH52OgA5T/s51re2fImWO4HA/khJFkvP4u2obJdL
 Ph2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG9wVZA0iPsCXYKCPzJNfmGgwbeklH7gKUBoq+FLX72UryJoAHH0/FScNBitk/YZTccy5J6YRTZ9YG@nongnu.org
X-Gm-Message-State: AOJu0YzBlUfKZ1G62+/oO7isdtuQpe6hf6E4uhPnf7RldbGA58oD9hsC
 GwQ4kLdILvllfTTazYlvVHz/UZzWLr/u204zAO4Vr5tagCDjAiAOv5dmQdeEzil0yYN0gtFpu8W
 Ok7HqjbTbXe5tsNLX1DFc3GnSvKmqS0Qe1NW1XDLgZH1tL9ZMH/FK6EDo
X-Gm-Gg: ASbGncsUAYvCP+h7GR6pBG0F5/vNWmQhl24gw2G+C+GCn30RzgVTbfrd181d4KfcOut
 lquiLPMEkYQ34vJtyJpn8NA4jtFW0ZbrM83y28FMuM+Wma7u+B6xZCBLsNKy8z42vCs6Rh2/MMZ
 sspe7Wu4yVA/uUaoa+GdrIfJ6HhvnsYvaDZZXY+AVBBmEfBs/GlviiLSIN6qO3POednFE4skfjZ
 hop0uqsYdcNsexy8zD/nNGmRCVq8hOl/dwHMmXT6ZeD6b4e8ZsgvE0jZshngYBuFQqHfWgF3AGW
 9SNXWhhpjkSkBi+mK8wdW6xthiDjFQ==
X-Received: by 2002:a05:6000:4a09:b0:3a4:e672:deef with SMTP id
 ffacd0b85a97d-3b5f35785abmr2243920f8f.36.1752241624652; 
 Fri, 11 Jul 2025 06:47:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/6JIzGXIwMI3J8jQ81msIV7ZxZNlhV+ihkOAZUUBUTvhZ3eeoe9MLuSyarrRUghKtLSXWKQ==
X-Received: by 2002:a05:6000:4a09:b0:3a4:e672:deef with SMTP id
 ffacd0b85a97d-3b5f35785abmr2243894f8f.36.1752241624155; 
 Fri, 11 Jul 2025 06:47:04 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd17b7sm4530650f8f.11.2025.07.11.06.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:47:03 -0700 (PDT)
Date: Fri, 11 Jul 2025 15:47:01 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, Jonathan.Cameron@huawei.com,
 gustavo.romero@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com, pbonzini@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: Re: [PATCH v6 34/36] tests/qtest/bios-tables-test: Add aarch64 ACPI
 PCI hotplug test
Message-ID: <20250711154701.0f394671@fedora>
In-Reply-To: <20250708142437.1344644-35-eric.auger@redhat.com>
References: <20250708142437.1344644-1-eric.auger@redhat.com>
 <20250708142437.1344644-35-eric.auger@redhat.com>
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

On Tue,  8 Jul 2025 16:23:16 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> From: Gustavo Romero <gustavo.romero@linaro.org>
> 
> Add 2 new tests:
> - test_acpi_aarch64_virt_acpi_pci_hotplug tests the acpi pci hotplug
>   using -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on
> - test_acpi_aarch64_virt_pcie_root_port_hpoff tests static-acpi index
>   on a root port with disabled hotplug

tests a bit simple, I wonder if we could reuse related x86 variants
for that (as those test a bit more corner cases with a more complicated
topology).
It's not a blocker and doing this of cause can be done on top.
 
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> ---
> v3 -> v4:
> - add -device pci-testdev for the first test case
> - fix the chassis
> - add a test for static acpi-index
> ---
>  tests/qtest/bios-tables-test.c | 52 ++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 357bcefd37..1074b8d67a 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1643,6 +1643,54 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
>  
>  }
>  
> +static void test_acpi_aarch64_virt_acpi_pci_hotplug(void)
> +{
> +    test_data data = {
> +        .machine = "virt",
> +        .arch = "aarch64",
> +        .tcg_only = true,
> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
> +        .ram_start = 0x40000000ULL,
> +        .scan_len = 256ULL * MiB,
> +        .variant = ".acpipcihp",
> +    };
> +
> +   /* Use ACPI PCI Hotplug */
> +   test_acpi_one(" -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on"
> +                 " -cpu cortex-a57"
> +                 " -device pcie-root-port,id=pcie.1,bus=pcie.0,chassis=0,slot=1,addr=7.0"
> +                 " -device pci-testdev,bus=pcie.1",
> +                 &data);
> +
> +    free_test_data(&data);
> +}
> +
> +static void test_acpi_aarch64_virt_pcie_root_port_hpoff(void)
> +{
> +    test_data data = {
> +        .machine = "virt",
> +        .arch = "aarch64",
> +        .tcg_only = true,
> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
> +        .ram_start = 0x40000000ULL,
> +        .scan_len = 256ULL * MiB,
> +        .variant = ".hpoffacpiindex",
> +    };
> +
> +   /* turn hotplug off on the pcie-root-port and use static acpi-index*/
> +   test_acpi_one(" -device pcie-root-port,id=pcie.1,chassis=0,"
> +                                          "slot=1,hotplug=off,addr=7.0"
> +                 " -device pci-testdev,bus=pcie.1,acpi-index=12"
> +                 " -cpu cortex-a57",
> +                 &data);
> +
> +    free_test_data(&data);
> +}
> +
>  static void test_acpi_microvm_prepare(test_data *data)
>  {
>      data->machine = "microvm";
> @@ -2602,6 +2650,10 @@ int main(int argc, char *argv[])
>              qtest_add_func("acpi/virt/numamem",
>                             test_acpi_aarch64_virt_tcg_numamem);
>              qtest_add_func("acpi/virt/memhp", test_acpi_aarch64_virt_tcg_memhp);
> +            qtest_add_func("acpi/virt/acpipcihp",
> +                           test_acpi_aarch64_virt_acpi_pci_hotplug);
> +            qtest_add_func("acpi/virt/hpoffacpiindex",
> +                          test_acpi_aarch64_virt_pcie_root_port_hpoff);
>              qtest_add_func("acpi/virt/pxb", test_acpi_aarch64_virt_tcg_pxb);
>              qtest_add_func("acpi/virt/oem-fields",
>                             test_acpi_aarch64_virt_oem_fields);


