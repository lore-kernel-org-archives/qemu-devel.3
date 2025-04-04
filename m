Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D077AC3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 03:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0XJl-0004QL-JV; Thu, 03 Apr 2025 23:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u0XJG-0004Ds-6r
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 23:01:53 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u0XJ9-000815-Tr
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 23:01:33 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22403cbb47fso16974535ad.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 20:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743735686; x=1744340486; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YvQrHIufzmNwSQPx6JtlnlJB+LGYI8bx5qEpU+hMbZs=;
 b=BscGZdTKMMWwmgfyBg8bQdqi7HhbWmqfzg8oiA2ywt3N5wDrUI78IadWU3kgYl7sWT
 bv7lYjeGkZSyCPLLktEpPME4Q8A3Cs+M+Jvd1srIVqjVNnCxSKjqrgOElX2++x8rEoYQ
 7JhT1YpIeijUgqy7aqyEXkEG+Laa9EcbFCh0oBzMBxLgF7L29x3afrgwRx5DgHMDYBK8
 KRn1ewwKZzrjCfFJQMnNefPz17lFgIvUIMGIZQrJJeOvCxqHf8Ne5pnhkOKhbi6xhowe
 1KlJgUiAHHY0VGXvr4LeE0SdEspnW4zP8c2DrO17N3THzsroemWEffczM+tEUgFIj8PI
 imwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743735686; x=1744340486;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YvQrHIufzmNwSQPx6JtlnlJB+LGYI8bx5qEpU+hMbZs=;
 b=aPxNmzJiKBi3xF/dOk0hKTMFJyA+dTOJosDR5Q4Rf2OzAeNew70iGRjZD7ajhh8n8k
 bqvRcn4ZxX4HgM/+3hqW0Fv6He1i52gFPXyTwz4zWxx9cNVr7NjN069yld85eDTVtonL
 S14cOi46nerKkMUqEm9BxosG9u9N2pqzuh/Dtg7mWjovCw2q2MDPI26esoyGhD7iMdDO
 wqkQXsTVPWEe1Hh2KnVlPKa8NEqTENMHAa5aSNscV6kmrB4rfoxt97aOSp4TEljCqYEK
 aSzmrXMqeb2jetVhG9J0ijV0TGnsTEhzJhP16ntGCJsof5mrc+qBzujnVjSlfvxp9HfM
 6iLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJOy8VaqpErnjox4nuZtTSuCLTZXHOrtZ/oOgHIPlmXzadaZMTMyYA9jVKQa83gWfMYTb1+8IrWrGG@nongnu.org
X-Gm-Message-State: AOJu0Yz5z3BcwQd2bpN19o3rEK0ikRLb8/gWvU0phimZcWACep5lF5mI
 DHOgtHhXxECe98A/NNzJ/ENWq/2m5l/xxe4GiTOZDhFVvYoRv6Z9GR5gbX52l8s=
X-Gm-Gg: ASbGnctK7UNBd3fGaLQZ/KKsBlPM8AQNJWIUduq4YkbiVvTejTnBGPB/NhcnlnJPRUX
 6M450lJd50dLb/Lu+2SGCw+bQTDuiOIOyYWTfI3gcEilP+qFisUOlYU91jMsCy7aeOt0ELMLSPS
 0sl5nlMySLgwWP0FNFph3uB0ghU5E1Y7qNtUubNZFLigN6fZePhPSb+/OWL8XTTuUcYEIX8irId
 tWafC5QDKqHQA7/m2wuT5QeQ/JuLFX5QO/O5MUTEaPefp6QdVFM6+2CldLp73xgJVbtg1MhQTrt
 pmU+G9z2ZTzKoacDSdfHUwgu4oCGslUX8/aZ5QUxd+9bm/ydr7LcezFJ0TGwFBF3gqU=
X-Google-Smtp-Source: AGHT+IFL7wt2VQAFqa4uKFPL6MTosainLG/mSIya3joSgB352tIwLrMA5yvNDXXkfL1sd/jJN3yKNQ==
X-Received: by 2002:a17:903:3baf:b0:215:b9a6:5cb9 with SMTP id
 d9443c01a7336-22a8a85a244mr20671915ad.5.1743735686400; 
 Thu, 03 Apr 2025 20:01:26 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.49.46])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785ad9dcsm22154415ad.29.2025.04.03.20.01.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 20:01:25 -0700 (PDT)
Message-ID: <671a6c82-ae10-4f3b-9d83-cecc32755206@linaro.org>
Date: Fri, 4 Apr 2025 00:01:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v3 6/9] qtest/bios-tables-test: Whitelist
 aarch64/virt 'its_off' variant blobs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Udo Steinberg <udo@hypervisor.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>
References: <20250403204029.47958-1-philmd@linaro.org>
 <20250403204029.47958-7-philmd@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250403204029.47958-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x632.google.com
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

On 4/3/25 17:40, Philippe Mathieu-Daudé wrote:
> We are going to fix the test_acpi_aarch64_virt_tcg_its_off()
> test. In preparation, copy the ACPI tables which will be
> altered as 'its_off' variants, and whitelist them.
> 
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/qtest/bios-tables-test-allowed-diff.h |   3 +++
>   tests/qtest/bios-tables-test.c              |   1 +
>   tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 0 -> 184 bytes
>   tests/data/acpi/aarch64/virt/FACP.its_off   | Bin 0 -> 276 bytes
>   tests/data/acpi/aarch64/virt/IORT.its_off   | Bin 0 -> 236 bytes
>   5 files changed, 4 insertions(+)
>   create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
>   create mode 100644 tests/data/acpi/aarch64/virt/FACP.its_off
>   create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8bf..3421dd5adf3 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,4 @@
>   /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/APIC.its_off",
> +"tests/data/acpi/aarch64/virt/FACP.its_off",
> +"tests/data/acpi/aarch64/virt/IORT.its_off",

I think your first approach is the correct one: you add the blobs
when adding the new test, so they would go into patch 5/9 in this series,
making the test pass without adding anything to bios-tables-test-allowed-diff.h.
Then in this patch only add the APIC.its_off table to the bios-tables-test-allowed-diff.h
since that's the table that changes when the fix is in place, as you did in:

https://mail.gnu.org/archive/html/qemu-devel/2025-03/msg07082.html

Plus, adding the blobs, which are actually related to the test in the other
patch, and ignoring them at the same time looks confusing to me. I understand
that only the blob that changes (APIC.its_off) with the fix should be temporarily
ignored and, later, updated, as in your first series.


Cheers,
Gustavo

> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index baaf199e01c..55366bf4956 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -2151,6 +2151,7 @@ static void test_acpi_aarch64_virt_tcg_its_off(void)
>       test_data data = {
>           .machine = "virt",
>           .arch = "aarch64",
> +        .variant = ".its_off",
>           .tcg_only = true,
>           .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
>           .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> diff --git a/tests/data/acpi/aarch64/virt/APIC.its_off b/tests/data/acpi/aarch64/virt/APIC.its_off
> new file mode 100644
> index 0000000000000000000000000000000000000000..c37d05d6e05805304f10afe73eb7cb9100fcccfa
> GIT binary patch
> literal 184
> zcmZ<^@O0k6z`($=+{xeBBUr&HBEVSz2pEB4AU24G0Uik$i-7~iVgWL^17JJ`2AFzr
> bgb+@aBn}xq0gwb2)Q)cq{30-g9B_L93G4|0
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/data/acpi/aarch64/virt/FACP.its_off b/tests/data/acpi/aarch64/virt/FACP.its_off
> new file mode 100644
> index 0000000000000000000000000000000000000000..606dac3fe4b55c31fd68b25d3a4127eeef227434
> GIT binary patch
> literal 276
> zcmZ>BbPf<<WME(uaq@Te2v%^42yj*a0-z8Bhz+8t3j|P&V`N}P6&N^PpsQ~v$aVnZ
> CVg~^L
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/tests/data/acpi/aarch64/virt/IORT.its_off b/tests/data/acpi/aarch64/virt/IORT.its_off
> new file mode 100644
> index 0000000000000000000000000000000000000000..0fceb820d509e852ca0849baf568a8e93e426738
> GIT binary patch
> literal 236
> zcmebD4+?q1z`(#9?&R<65v<@85#X!<1dKp25F11@1F-=RgMkDCNC*yK9F_<M77!bR
> zUBI%eoFED&4;F$FSwK1)h;xBB2Py`m{{M%tVD>TjFfcO#g+N#Zh@s|zoCF3AP#UU@
> R!2`+%Dg6Hr$N|zYvjDIZ5CH%H
> 
> literal 0
> HcmV?d00001
> 


