Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A1DC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 13:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR9xw-0002Q5-Jy; Mon, 16 Jun 2025 09:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR9xu-0002PS-R8
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 09:33:34 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR9xs-0007Tf-N9
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 09:33:34 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a531fcaa05so2771853f8f.3
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 06:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750080810; x=1750685610; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OLBiGdFQBYSuCjE9HOzR5RujC6zuqYW1dMFD/IFCbwM=;
 b=w9kJgZGI1t8UXATYgiEpfYnCNfO9V4mi90Ao/G29J5OZbYQpzCoWGD8nNu9la38ETq
 ySJZyXhamBFCMJTv51hkqeBllt0r2dZRYd4hO4iOg+o2q3uGc1xlesqwcQfj89ciFpZN
 GqAA6CVUANxoqIk46m6rcMaacRFPcmIvVXTIS+WiIZxiAzHTx2444zHY61ZyzM3uTj8T
 Z0XU+dUUlFzJL/MVwivBu3ZWGV4IBedoq58Uhk/o1F4B61NU9CAJwvx4APHPqKoIrXfU
 G02lfR5XZ/li8ibK+SkhzVy51qVbTTR2lFjwiV5/tvXROgv3WSYSceYlfQZWa4OAPPeI
 vtrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750080810; x=1750685610;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OLBiGdFQBYSuCjE9HOzR5RujC6zuqYW1dMFD/IFCbwM=;
 b=JjHa4SFlXvo+zYr7K0xtcktxZDZyyLihXB+wiJEEAObETiK7G42YcW+Z+v/nvXI++P
 LIEvePA+f+Zey/7vPA+TtFoXsAULICyrqZcRz2Io2rR+NUY6StCckU3Jw8z/9GK2CZYo
 vt1ZOykxch+MI7P039U934OQUJy9wKmThNfguXD85obi2tXrt+MYIAUXHVS6aPB8pPHC
 iEMHwSYi5KgGbCfZXtHXyrWI4Y+DFPzXXq+tA6zpzM2uFY6HH1HSaMXdUCY3jMfUdcBd
 2Z/bRMF3SJ4OpsrNTMlwbnHN3jY6CrcWwiDQ5n6QYlFn4AXKij17h0csYL1bPstiSJIm
 mAWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7tnVHQQ2OdkpMpfuP3/rRRn9FsrqLcaB44dnDSkCeMs8RPYUG70azMHbPX6yZ6Pp9aDrChhEqDqqU@nongnu.org
X-Gm-Message-State: AOJu0YwLYMRiUcnWfPo5CvYmEzVwQbHxuKDW4DE9crIAdlFOIqfgw3Ka
 MhlNLdo19UvBFmDERTiYb2FK4+bRasfD4jNVWQveT519Oog+LgQJCpMu+X43DiNs8Uo=
X-Gm-Gg: ASbGncuS8L4iqi8FcF6q918l02RerRnnd1p6AFVpuITxkZnCDhe7bEtOAj640gmt+RM
 YO1ygUPyDhPSFu9KK+UgYMSi9olpP7F8LO7Y/bjGGxWzTIU1gK0XZa7kew9OI7hPIvwMxRUSr/d
 JEatsbNT9oIbYBzzzTVml8K0oKiaijFj+rO0n7TCOkdYYZcuVF5ftLs2sFEyIX2DpOtIs6Q1mEQ
 QOuRyZdSqi4CQ6NhMnY6GsiN4M/QkcnRx5W6lxzBWzWpNAdK579g8ROyRZxepNkClvjFZNQkFda
 lG74swT1Kh8+L21vIrxzGHSu5kg3pmnI/t907LVpq7hFtx8/D28ipU4ag2LyAEqSyXzkNMxSMMO
 GhWZOSnWlcLVSfxVVxBxxt1WdIuOAMw==
X-Google-Smtp-Source: AGHT+IE580eB4gDixRbSCBfpsvK3enjr+M1j09ArqGPbt+1MBAuB68pk2dqysHu0uKliTlQ68Onp2g==
X-Received: by 2002:a05:6000:25f9:b0:3a4:f024:6717 with SMTP id
 ffacd0b85a97d-3a572e9a4a5mr7316014f8f.53.1750080810284; 
 Mon, 16 Jun 2025 06:33:30 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b08e21sm11236902f8f.52.2025.06.16.06.33.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Jun 2025 06:33:29 -0700 (PDT)
Message-ID: <70853fdc-ef08-40ad-85a9-5cb02146cf23@linaro.org>
Date: Mon, 16 Jun 2025 15:33:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] hw/intc/gicv3_its: Do not check its_class_name()
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 eric.auger@redhat.com, mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, udo@hypervisor.org,
 ajones@ventanamicro.com, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com, Richard Henderson <richard.henderson@linaro.org>
References: <20250616131824.425315-1-gustavo.romero@linaro.org>
 <20250616131824.425315-2-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250616131824.425315-2-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Hi Gustavo, why reset authorship?

On 16/6/25 15:18, Gustavo Romero wrote:
> Since commit cc5e719e2c8 ("kvm: require KVM_CAP_SIGNAL_MSI"), the single
> implementation of its_class_name() no longer returns NULL (it now always
> returns a valid char pointer). Hence, update the prototype docstring and
> remove the tautological checks that use the its_class_name() returned
> value.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/arm/virt-acpi-build.c               | 32 +++++++++++---------------
>   include/hw/intc/arm_gicv3_its_common.h |  2 +-
>   2 files changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 7e8e0f0298..9eee284c80 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -737,20 +737,18 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>                                             memmap[VIRT_HIGH_GIC_REDIST2].size);
>           }
>   
> -        if (its_class_name()) {
> -            /*
> -             * ACPI spec, Revision 6.0 Errata A
> -             * (original 6.0 definition has invalid Length)
> -             * 5.2.12.18 GIC ITS Structure
> -             */
> -            build_append_int_noprefix(table_data, 0xF, 1);  /* Type */
> -            build_append_int_noprefix(table_data, 20, 1);   /* Length */
> -            build_append_int_noprefix(table_data, 0, 2);    /* Reserved */
> -            build_append_int_noprefix(table_data, 0, 4);    /* GIC ITS ID */
> -            /* Physical Base Address */
> -            build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
> -            build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
> -        }
> +        /*
> +         * ACPI spec, Revision 6.0 Errata A
> +         * (original 6.0 definition has invalid Length)
> +         * 5.2.12.18 GIC ITS Structure
> +         */
> +        build_append_int_noprefix(table_data, 0xF, 1);  /* Type */
> +        build_append_int_noprefix(table_data, 20, 1);   /* Length */
> +        build_append_int_noprefix(table_data, 0, 2);    /* Reserved */
> +        build_append_int_noprefix(table_data, 0, 4);    /* GIC ITS ID */
> +        /* Physical Base Address */
> +        build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
> +        build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
>       } else {
>           const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
>   
> @@ -969,10 +967,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>                             vms->oem_table_id);
>       }
>   
> -    if (its_class_name()) {
> -        acpi_add_table(table_offsets, tables_blob);
> -        build_iort(tables_blob, tables->linker, vms);
> -    }
> +    acpi_add_table(table_offsets, tables_blob);
> +    build_iort(tables_blob, tables->linker, vms);
>   
>   #ifdef CONFIG_TPM
>       if (tpm_get_version(tpm_find()) == TPM_VERSION_2_0) {
> diff --git a/include/hw/intc/arm_gicv3_its_common.h b/include/hw/intc/arm_gicv3_its_common.h
> index 7dc712b38d..3c7b543b01 100644
> --- a/include/hw/intc/arm_gicv3_its_common.h
> +++ b/include/hw/intc/arm_gicv3_its_common.h
> @@ -128,7 +128,7 @@ struct GICv3ITSCommonClass {
>    * Return the ITS class name to use depending on whether KVM acceleration
>    * and KVM CAP_SIGNAL_MSI are supported
>    *
> - * Returns: class name to use or NULL
> + * Returns: class name to use
>    */
>   const char *its_class_name(void);
>   


