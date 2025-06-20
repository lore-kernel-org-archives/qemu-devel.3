Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC614C7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbdb-0005PA-94; Fri, 20 Jun 2025 09:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSbdJ-0005L9-3J
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSbdH-0006dl-GH
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750425494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=78KgBHkYzaVNbEYYl6xBENrGYcFNq/PxOzePpremf/Y=;
 b=KCcx16ar7xS4xomTsQkvAqdHKLVkLlHrQ0PPFxuWLbpta9WeR1XEK0Gx3Csg0vmvJn3E92
 zaPBOY+PuFjcH6DuZGB4rtX7mpeVIm2lGucZfCZXNEjujOSgklShdUTx27hua5xiNB1ny+
 WCAvzya3mfBqo0695oieGEXG/ob+ReM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-6i6KAEPvNkOjqa7BK4Lv4A-1; Fri, 20 Jun 2025 09:18:11 -0400
X-MC-Unique: 6i6KAEPvNkOjqa7BK4Lv4A-1
X-Mimecast-MFC-AGG-ID: 6i6KAEPvNkOjqa7BK4Lv4A_1750425490
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f8fd1847so674118f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750425490; x=1751030290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=78KgBHkYzaVNbEYYl6xBENrGYcFNq/PxOzePpremf/Y=;
 b=AcKNi7+Ng3awST/95vahQNe7eY3LW9wLFz7JKv4EkFgYULjuXHSAFvrK7VE8/dn1pI
 GctX6JaarRZiRsBIdOxmuLUN++u0dmztdWkoOcaKH+9z/kaThTWuZwn+rUZePGfVESpg
 wT37TDETRfSldTpOHXj2m2fsxHTVL+qM+Ea/IKX7AXAGHN3twdUewvedw5FxnS8Fud7k
 5MtqbzeFUs9jS05X5k6iJ/9DN6doxehGV9DxCgMZY5G9ZmmbugfoxKNShtqHQeBotB8p
 w5IQtqNqnRxMuhaBPiYjHm000l2Xxym25BmJjXtQmDcBjs7PqCC0VWBF6slCQi79JKL7
 W7UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqgdcQZcj8NC2ycx6+2PDG5NpdtkjvIsoEj7svLC/zAJJ1V92geHwUfVu/4mdXslfsYlHveIjgpJ/3@nongnu.org
X-Gm-Message-State: AOJu0Yx8bLL/MabfAsbdThGN2ww0IHqwpnatH+urx6gJB0kODQhNsqvI
 PQu9LImBRqcPe8xiy+hW+SjWC9tJsggWJ4deHJgPpSM5xuEbbegJRsQvGrMh5yNuZNaznz2PD48
 ZcbduPu3ZP3viL8uYyCp1FXdDzTjyfiBJmHWJT34qDTbsHV8SEmuP3SFg
X-Gm-Gg: ASbGncvjESnTSNQeJ2hk9uEcgkHRxFpuPOe2SSYOwsVOwjEuolcUZT+lnZ0X/aOGJoC
 VsZagX+ftnIfglyTgzVsTm5g4ZTR10shh4t5/8GSg6cc7vDZUeOooLlrAGM16pnitjADr5WBs6u
 lyjxlig3r8gdOqdXmx8U/eNLxER6xprRw+xm2vQKfri3StmbHsDHOIexyjJYNu+T/5Khw0QwkSP
 OdF/m0LiuJTrgEeJgMRcWWtnah7xDpnj9WbJ3Nz3Ou9NizcA4DdRQnnK3e2chC2mfy7KsF5W/jo
 8BMBVWlnoLZr
X-Received: by 2002:a05:6000:3103:b0:3a5:58a5:6a83 with SMTP id
 ffacd0b85a97d-3a6d13013eemr2687885f8f.13.1750425489675; 
 Fri, 20 Jun 2025 06:18:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCu7ulD1GeR8vcekHoutqgdP/3C1eweXOA7gE+/IcXmUK3BtyOlhfb/f0qPzvLaT65+v+XlQ==
X-Received: by 2002:a05:6000:3103:b0:3a5:58a5:6a83 with SMTP id
 ffacd0b85a97d-3a6d13013eemr2687856f8f.13.1750425489236; 
 Fri, 20 Jun 2025 06:18:09 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535a14221csm56508355e9.1.2025.06.20.06.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 06:18:08 -0700 (PDT)
Date: Fri, 20 Jun 2025 15:18:06 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v3 28/29] tests/qtest/bios-tables-test: Add aarch64 ACPI
 PCI hotplug test
Message-ID: <20250620151806.3f742bef@fedora>
In-Reply-To: <20250616094903.885753-29-eric.auger@redhat.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-29-eric.auger@redhat.com>
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

On Mon, 16 Jun 2025 11:46:57 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> From: Gustavo Romero <gustavo.romero@linaro.org>
> 
> The test uses -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on
> to force the usage of ACPI PCI hotplug.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  tests/qtest/bios-tables-test.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 0b2bdf9d0d..4b9e391eaf 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1643,6 +1643,38 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
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
> +                 /*
> +                  * We just pick address=0x04 for the root port to avoid
> +                  * collisions with other PCI devices on the root bus (pcie.0).
> +                  * It could be any other value that doesn't collide.
> +                  *
> +                  * The 'chassis' and 'slot' options equal to 1 have no special
shouldn't be slot be equal to 0 for pcie root ports?

> +                  * meaning here, could be any integer, but we set them to known
> +                  * values to keep the test consistent.
> +                  */
> +                 " -device pcie-root-port,bus=pcie.0,chassis=1,slot=1,addr=0x04.0x00",
> +                 &data);
> +
> +    free_test_data(&data);
> +}
> +
>  static void test_acpi_microvm_prepare(test_data *data)
>  {
>      data->machine = "microvm";
> @@ -2580,6 +2612,8 @@ int main(int argc, char *argv[])
>              qtest_add_func("acpi/virt/numamem",
>                             test_acpi_aarch64_virt_tcg_numamem);
>              qtest_add_func("acpi/virt/memhp", test_acpi_aarch64_virt_tcg_memhp);
> +            qtest_add_func("acpi/virt/acpipcihp",
> +                           test_acpi_aarch64_virt_acpi_pci_hotplug);
>              qtest_add_func("acpi/virt/pxb", test_acpi_aarch64_virt_tcg_pxb);
>              qtest_add_func("acpi/virt/oem-fields",
>                             test_acpi_aarch64_virt_oem_fields);


