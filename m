Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8EAC3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 03:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0XJ1-00045I-Im; Thu, 03 Apr 2025 23:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u0XIs-00044U-BJ
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 23:01:11 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u0XIo-0007zD-Ly
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 23:01:10 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so1321034b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 20:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743735664; x=1744340464; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=02Kv6Dc9UvpP0MB5UIsl4ucf+GEBoG4rYzTStdL35xQ=;
 b=YrRWrAvwhSv9CnXML4hvAFzEKq47ZFl8ZqJsThuJjpjmWBp3vvkGXnafI8CTHq5MJ1
 DJ6beDBwt9r9hRVL9dNhvGus9iFjDUPTwM6c+hRNuZvjrfhOVuvBZNb3wzt0jqCyt2rF
 f4oXQfgI0U7EU5ShV0Br+clp/LnofuatPZA4NtpJPH5854ar7VBf3N1T+DHmGYSJ6YRm
 y6iOe2sDSN3bSikcwksiPl+b38pFbjAvcSA1bkGS3culHjbb68goGVcBRBAbnVP3b58S
 buW2j+yVZn3SIjboTQOPjdnkm5Bc/sZYQn/LDkb+OYB0ye0RZu/K4hY/QQOEw2jnYPTK
 0g5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743735664; x=1744340464;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=02Kv6Dc9UvpP0MB5UIsl4ucf+GEBoG4rYzTStdL35xQ=;
 b=fPvi/bHjy9td5XU5AY47voP5cd33n20o3lTlGUapOzZVps0eL61MLWyCl8OZ8xt10k
 FZup9mWOdhK/cbzV8NbVMxKCKM9TOj3BPAUe5ACQNqS0iPYl2bhrvoBO+QnsCIWnEQ/m
 M282975GEzDYJqyECAPJYjHyzuHyOVKLSkR9q28QaBdZUo+NbN/WrTDgpJ7kBJ2WQxCt
 iR2KpCRIqFcGlKSc0d2Bjfzj2W7Ovl3UQj4DckodwYXfOM+4ut9MKHyrlqGVf+OI1tYv
 xOEZ+BfCqEHiWPgqTcwc/yyzBMAUVfvBAqN4ZOHWsPqZE9+WXiuK2JkQrSKscJJrlg7o
 dVTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyr9DzMdMzuD67pKu6Ire1DdGq5UwULwUgARokKrC6Mpn9StSqKf82n2/gO3KJMN/rnt5QHUezqqln@nongnu.org
X-Gm-Message-State: AOJu0YwC6PNQ1JhkSL8SjLYjtYILxrqKMBSt2xRVj50RJIkEc/shN/kY
 dkdMgLZDyy1ICNa5Q4Gu09JJaHKurrF9TOGfGZ9YH6ZZ1IMEqZ2SeYvvaFUai2M=
X-Gm-Gg: ASbGncuiho1GyK1j4Iy0PNnw/UNKoFzLPt3KWtvNOF9ZchF8AF7PzPldhlMc7bqmSNr
 GbDWRWMINA/vPnk+95HeYd6GNacvpS9gEcBKWFhwO2Qboiu+vHYPrtCw/YFRoQApb47e9XrW4Sa
 hRqWUKDrEJMi3YpmJvzItm/So9wamD74EPDXZLvv9KoG/ViEM+6cMPsSIs7LH6Wqrt/g02/mCD2
 2bbjNNgluJMBhOBR1BofzHAWG6X8YHHvqupUAQkDdCLVp4O/S30mO5KFxliYQOWDmLuo78RkWhY
 ZzxoNteaR3YAtpVletDEfi/eLLVBUvVfjZlf5uQIzsl9NKMpo5CLzC4G
X-Google-Smtp-Source: AGHT+IE7Gty54AIPLEBgHuz8LTBUMYwGhCMGP2bzHzsHAFX/QqGRI/1hDL4Wvq+D12SY/NsDKY4Xxw==
X-Received: by 2002:a05:6a00:3901:b0:736:3c77:31fd with SMTP id
 d2e1a72fcca58-739e4b7af8amr2440338b3a.23.1743735664013; 
 Thu, 03 Apr 2025 20:01:04 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.49.46])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d9e9dcc6sm2340080b3a.99.2025.04.03.20.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 20:01:03 -0700 (PDT)
Message-ID: <b905164a-e613-466a-9094-bac225cc96fc@linaro.org>
Date: Fri, 4 Apr 2025 00:00:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v3 5/9] qtest/bios-tables-test: Add test for -M
 virt,its=off
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Udo Steinberg <udo@hypervisor.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>
References: <20250403204029.47958-1-philmd@linaro.org>
 <20250403204029.47958-6-philmd@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250403204029.47958-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/3/25 17:40, Philippe Mathieu-Daudé wrote:
> Add the use case reported as issue #2886 [*]. The test
> passes while it shouldn't. We are going to fix that in
> the following commits.

I think this organization is not ideal. I like better your first
version, i.e., adding the correct blobs that make the new test pass,
as you did in:

[PATCH-for-10.0 1/5] qtest/bios-tables-test: Add test for -M virt, its=o
https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg07081.html

The way it is here if you checkout this commit and run the test
(make check) the acpi test will _not pass_ because of the other changes
in the APIC, FADT, and IORT tables caused by the other VM options
(virtualization, gic-version, and iommu), as I pointed out in [0], even
tho the bug is present and its=off does not take effect.


Cheers,
Gustavo

[0] https://mail.gnu.org/archive/html/qemu-devel/2025-04/msg00438.html


> [*] https://gitlab.com/qemu-project/qemu/-/issues/2886
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/qtest/bios-tables-test.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 0a333ec4353..baaf199e01c 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -2146,6 +2146,25 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
>       free_test_data(&data);
>   }
>   
> +static void test_acpi_aarch64_virt_tcg_its_off(void)
> +{
> +    test_data data = {
> +        .machine = "virt",
> +        .arch = "aarch64",
> +        .tcg_only = true,
> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
> +        .ram_start = 0x40000000ULL,
> +        .scan_len = 128ULL * 1024 * 1024,
> +    };
> +
> +    test_acpi_one("-cpu cortex-a57 "
> +                  "-M virtualization=on,secure=off "
> +                  "-M gic-version=max,its=off,iommu=smmuv3", &data);
> +    free_test_data(&data);
> +}
> +
>   static void test_acpi_q35_viot(void)
>   {
>       test_data data = {
> @@ -2577,6 +2596,8 @@ int main(int argc, char *argv[])
>                              test_acpi_aarch64_virt_tcg_acpi_hmat);
>               qtest_add_func("acpi/virt/topology",
>                              test_acpi_aarch64_virt_tcg_topology);
> +            qtest_add_func("acpi/virt/its_off",
> +                           test_acpi_aarch64_virt_tcg_its_off);
>               qtest_add_func("acpi/virt/numamem",
>                              test_acpi_aarch64_virt_tcg_numamem);
>               qtest_add_func("acpi/virt/memhp", test_acpi_aarch64_virt_tcg_memhp);


