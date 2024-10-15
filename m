Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150B0D216BF
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iqZ-0003w8-A3; Tue, 15 Oct 2024 10:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0iqX-0003sf-V2
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:48:26 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0iqW-00070X-3S
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:48:25 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71e5a1c9071so2116969b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729003703; x=1729608503; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MpJn7jcqdJkrP7mTPkpEMyReLD1c68tcZ6nu+OH9hVA=;
 b=WaPupRELFqw1T8Ipk+GWdrEFEZ00vOZIiAA6+yqPMA/jpNvjzdOemhYdUTaJVgYXOc
 fb1x5WnSm2My6JJhUDibDEZfIN1ASFCTJpk1wWGfIL4eROq8++WXy8PLS3iUtsYqc7VV
 E8J8JWsEshUHM1YH9L28x9p2ryICwqT9ta+SyuxGAUUq7G/nkjKdZSTMARU4Zz4OJ9aj
 KhpFrAyo4J5LCJOeuc5IOnP82+MmajX7vYifoCdOK4NI/7uIQUG1kz6v8TQ4RV6rD1TW
 pfN9dnnLp4m3JbJJT2FB6zNjx8Ct+JwwsEsz2SmTY/5/MDSTKy+1Pz7u4HSy/q/NUpAw
 OGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729003703; x=1729608503;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MpJn7jcqdJkrP7mTPkpEMyReLD1c68tcZ6nu+OH9hVA=;
 b=CcNZ2c2V6FYjL47rAHKt6rmjKCCvInv6w4g9CD1cNEhl9QMUK32rnNysumpepNX1st
 kHANdxdjs8HFr3ufPICu4zm8Kv+8uEzwqYAgHdJEJ1kS/sKulgGvvajn3BcZM8C1Iut8
 dtJoHbYABGhVAYXfKh9Rbg0j5fUSKMLiVNkQx3mF3tC+zmwcQRNSsV+9/aJsUVK900g3
 WHrYx9fQRRc9kNDQrT/xRkihZCxyJSMVyPfZSCgnxqNc8LWqtce6ROKfi9+Aocuvfv9V
 sNiZvgKpTp9alR0IYAifKu84h9/PkDkIyQBLappZsqDtv1Hn5zfOq5e4N8RJlTfxGq0W
 D2dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnINqg8hRkoa952XhVdqKNDl7HKNvOxBrljzDbDU3UPiwaKyxbXE7EEZH70TfFjqEg6G1I7ViyOQT2@nongnu.org
X-Gm-Message-State: AOJu0Yx7/bgNqbSX9Bx34BrAlVFpO4Qw34j8uoD5IGl9RX9rHfzNXIWg
 HygPh7YeqXGulq8EQZOsXpa48fBsfJNMIBVLOYE40lklT/0qWbCz0IZa+TrtA/I=
X-Google-Smtp-Source: AGHT+IFC/HGhgRGcDXuRNhhmpvhIZoVw4fCNewP+MAso1lvE+MAFT8Qhf0pNg82Rng1FdNzWy7ksaA==
X-Received: by 2002:a05:6a00:320b:b0:71e:41b3:a56b with SMTP id
 d2e1a72fcca58-71e41b3a6eemr14812256b3a.24.1729003702705; 
 Tue, 15 Oct 2024 07:48:22 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e77507db4sm1343998b3a.188.2024.10.15.07.48.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2024 07:48:22 -0700 (PDT)
Message-ID: <77803f8b-6b86-489e-8da1-608ce7432208@linaro.org>
Date: Tue, 15 Oct 2024 11:48:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/acpi/acpi_dev_interface: Clean up remains of madt_cpu
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
References: <20241015140957.385491-1-gustavo.romero@linaro.org>
Content-Language: en-US
Cc: Bernhard Beschow <shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241015140957.385491-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 15/10/24 11:09, Gustavo Romero wrote:
> Commit c461f3e382 ("Remove now unused madt_cpu virtual method") removed
> madt_cpu virtual method but didn't remove the text about it in the
> header file. Thus, remove it now.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   include/hw/acpi/acpi_dev_interface.h | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
> index 68d9d15f50..2f5ab5c1b1 100644
> --- a/include/hw/acpi/acpi_dev_interface.h
> +++ b/include/hw/acpi/acpi_dev_interface.h
> @@ -34,10 +34,6 @@ void acpi_send_event(DeviceState *dev, AcpiEventStatusBits event);
>    * ospm_status: returns status of ACPI device objects, reported
>    *              via _OST method if device supports it.
>    * send_event: inject a specified event into guest
> - * madt_cpu: fills @entry with Interrupt Controller Structure
> - *           for CPU indexed by @uid in @apic_ids array,
> - *           returned structure types are:
> - *           0 - Local APIC, 9 - Local x2APIC, 0xB - GICC
>    *
>    * Interface is designed for providing unified interface
>    * to generic ACPI functionality that could be used without

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


