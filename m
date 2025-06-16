Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE551C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 13:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRAME-0002b8-JU; Mon, 16 Jun 2025 09:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uRALq-0002Rc-6a
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 09:58:18 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uRALn-0002HX-5u
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 09:58:16 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b26df8f44e6so4820568a12.2
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 06:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750082293; x=1750687093; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w8YHxwMmQT2dMZDk/cIISk6jqJUWgkRqW39sQK3NAAw=;
 b=Bbs9VGANfI5m1623n5gz9ELWgDnIYuUtLNkExhpCxZc1eENKdGVO82hTv/C6WVNjSf
 IeLQXEhxh0d3EQ609XNoNBcluZTSQrXVfeRZk1Mw6zX3JwW/TaMos1owEFYGOGIhTtBI
 IxQI+YhlX9wOopV6inf4gxT64LMMVuX735fgEN8PFf1a7zWUKDLCQ6XKRhi0GgNUP94z
 88XEFfWv+ymmy7vT+vcMBOtkCzsx/QJ/oUBSntckk7xMVIQjaTqtJho8BNNZU5RGvDs6
 jxohUbgyJWVyI36ryF57HIKSqsD7PM2SjleQKeaV3UzA6eajBwLYYkir/YICFeThgQl+
 t9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750082293; x=1750687093;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w8YHxwMmQT2dMZDk/cIISk6jqJUWgkRqW39sQK3NAAw=;
 b=ZU5wZ4s7f+jK7zfmhbGhBY27xa3nNxCJIer3WnT38fHbDitu6TGS/2YyUcUXPKud1N
 UijxkCBs/omt0MSQez25+O9szTSUdI5rWPd3wz6VSC5SZ12YV5IGe8Ost5g3Ms1S0g1n
 MiXCc3+WBDnrZ9DLYAxNvw0SnJQuZHEgRcxZuL3H99K+aRieSun/2sbk3uxEtbew3TSO
 Qegtc5CjzNzAadBGOP5PqK0C3K4ZWGLilyvRtcm11gmmtZh3txtHSp228nRyCWpA8pdf
 o8W/pNDZ7c0rx7Pw3UJgrxzxPFYLcc0QNgybBDTXuAQzuMdADq6tWUPZVlq1Pom+3W/o
 hqBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV43iqeSwBisSAF2qbDLlb+ZBz5nR/cuciqHSJB314HP0XvVaAYjQmvQWiSxLe0AL3ht5cCgAubvZxI@nongnu.org
X-Gm-Message-State: AOJu0YzkfxLZ2klPfxP1UIJIWWPd3G05dBDxSmXRhLpwWnviLhIY9zFZ
 uMeRYXrWyx16kp9/xxIA764hKWCnhctm18HglDi5XzsVtwkesZqNZ368grr3jAS/XVk=
X-Gm-Gg: ASbGncv/vbN0siUvX7Mex9MTfTk0F46/OYlGXPac1VztDw14Ka0lTxCtkpRKQlt6Y/c
 c8Gs4ETWs/pmTgVwx4uLeSfPx52d/Gaw88M3ezFIntcceTV2DmaHdm3K7DDi8vdjaytwFGo9mZ6
 r6A0vCjEtOdofW3afluTw777Mo+wuoaup9P2tpBuy8NRTjPuHEQzPopZYfOmaitaLAm431hY3ED
 vhC26aqIzNGKUitPDNoJFmvyt+8mtuYmOxYvy2VJOsUxVXIFBM3HOS77yxf4i0BKdhyzYygUkqL
 LNFo+Oq1eCM96YNDh9Z5nNpJ5V3BbKJCaa0FQLy3n49AzkR+quIHAQLYqyXwdzr1XNEF6YHkoA=
 =
X-Google-Smtp-Source: AGHT+IHEQ71sYRD9lXreOK86iZrdzV+jd04+z28rTqgrMo/3stsd6RGkCd/0GYHKK067LwLQAn3M7w==
X-Received: by 2002:a05:6a21:9210:b0:1f5:931d:ca6d with SMTP id
 adf61e73a8af0-21fbd54a6eemr12568905637.1.1750082292789; 
 Mon, 16 Jun 2025 06:58:12 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.60.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-748900cc047sm7072670b3a.147.2025.06.16.06.58.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Jun 2025 06:58:12 -0700 (PDT)
Message-ID: <09652baa-2f0f-4fee-82ba-35847461242d@linaro.org>
Date: Mon, 16 Jun 2025 10:57:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] hw/intc/gicv3_its: Do not check its_class_name()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, eric.auger@redhat.com, mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, udo@hypervisor.org,
 ajones@ventanamicro.com, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com, Richard Henderson <richard.henderson@linaro.org>
References: <20250616131824.425315-1-gustavo.romero@linaro.org>
 <20250616131824.425315-2-gustavo.romero@linaro.org>
 <70853fdc-ef08-40ad-85a9-5cb02146cf23@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <70853fdc-ef08-40ad-85a9-5cb02146cf23@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x52f.google.com
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

Hi Phil,

On 6/16/25 10:33, Philippe Mathieu-Daudé wrote:
> Hi Gustavo, why reset authorship?

It was not intentional. hmm maybe it changed because I tweaked
the commit message and the code due to rebasing as well? Do you
know how to restore it?


Cheers,
Gustavo

> On 16/6/25 15:18, Gustavo Romero wrote:
>> Since commit cc5e719e2c8 ("kvm: require KVM_CAP_SIGNAL_MSI"), the single
>> implementation of its_class_name() no longer returns NULL (it now always
>> returns a valid char pointer). Hence, update the prototype docstring and
>> remove the tautological checks that use the its_class_name() returned
>> value.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>   hw/arm/virt-acpi-build.c               | 32 +++++++++++---------------
>>   include/hw/intc/arm_gicv3_its_common.h |  2 +-
>>   2 files changed, 15 insertions(+), 19 deletions(-)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 7e8e0f0298..9eee284c80 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -737,20 +737,18 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>>                                             memmap[VIRT_HIGH_GIC_REDIST2].size);
>>           }
>> -        if (its_class_name()) {
>> -            /*
>> -             * ACPI spec, Revision 6.0 Errata A
>> -             * (original 6.0 definition has invalid Length)
>> -             * 5.2.12.18 GIC ITS Structure
>> -             */
>> -            build_append_int_noprefix(table_data, 0xF, 1);  /* Type */
>> -            build_append_int_noprefix(table_data, 20, 1);   /* Length */
>> -            build_append_int_noprefix(table_data, 0, 2);    /* Reserved */
>> -            build_append_int_noprefix(table_data, 0, 4);    /* GIC ITS ID */
>> -            /* Physical Base Address */
>> -            build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
>> -            build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
>> -        }
>> +        /*
>> +         * ACPI spec, Revision 6.0 Errata A
>> +         * (original 6.0 definition has invalid Length)
>> +         * 5.2.12.18 GIC ITS Structure
>> +         */
>> +        build_append_int_noprefix(table_data, 0xF, 1);  /* Type */
>> +        build_append_int_noprefix(table_data, 20, 1);   /* Length */
>> +        build_append_int_noprefix(table_data, 0, 2);    /* Reserved */
>> +        build_append_int_noprefix(table_data, 0, 4);    /* GIC ITS ID */
>> +        /* Physical Base Address */
>> +        build_append_int_noprefix(table_data, memmap[VIRT_GIC_ITS].base, 8);
>> +        build_append_int_noprefix(table_data, 0, 4);    /* Reserved */
>>       } else {
>>           const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + ARM_SPI_BASE;
>> @@ -969,10 +967,8 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>>                             vms->oem_table_id);
>>       }
>> -    if (its_class_name()) {
>> -        acpi_add_table(table_offsets, tables_blob);
>> -        build_iort(tables_blob, tables->linker, vms);
>> -    }
>> +    acpi_add_table(table_offsets, tables_blob);
>> +    build_iort(tables_blob, tables->linker, vms);
>>   #ifdef CONFIG_TPM
>>       if (tpm_get_version(tpm_find()) == TPM_VERSION_2_0) {
>> diff --git a/include/hw/intc/arm_gicv3_its_common.h b/include/hw/intc/arm_gicv3_its_common.h
>> index 7dc712b38d..3c7b543b01 100644
>> --- a/include/hw/intc/arm_gicv3_its_common.h
>> +++ b/include/hw/intc/arm_gicv3_its_common.h
>> @@ -128,7 +128,7 @@ struct GICv3ITSCommonClass {
>>    * Return the ITS class name to use depending on whether KVM acceleration
>>    * and KVM CAP_SIGNAL_MSI are supported
>>    *
>> - * Returns: class name to use or NULL
>> + * Returns: class name to use
>>    */
>>   const char *its_class_name(void);
> 


