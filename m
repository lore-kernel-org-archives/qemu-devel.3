Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE51C36014
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 10:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzvNx-0007Nl-6m; Wed, 02 Apr 2025 06:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzvNh-0007F6-KW
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 06:31:37 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzvNd-0007er-HU
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 06:31:35 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so34573915e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 03:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743589891; x=1744194691; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j+ixtitVW2HwxwjBnn85TjGkrpNw40oFffG8dlas4/0=;
 b=QYVUYYOu3rGR4eDdRh7BmkDstuSm6XJ75lgN4JKc78MKecL7TtISRwh6S0WVKjsSBp
 QwDFVnSzAJmOpBd/M2NEhFf2XVzWM6c4K7jIcgjbqMibEEiALhhktfVm62HzJ1A++tfY
 VUP1txgyc6uQcc39i9s8UrYa/yvD5sTlGiUg11IOT3JSBDV7AJkAV/NkgG6rW7Vf1obx
 YjpmKZHkKVuUszTg1QcL8redsNCGyRH9ypuqwmpsCUGL7YAuagE4XwQS4LdPLR656XtZ
 xOvngawNUCFQdxmB0+ASQQ9nyhv13tucJjkz02fNIsHMW91PmTrxp6DkigJTvZl3KDeB
 PxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743589891; x=1744194691;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j+ixtitVW2HwxwjBnn85TjGkrpNw40oFffG8dlas4/0=;
 b=ShNOoRKAju7BIx/2xAJlExQ09zY8E1zQoBjDzTdhixnPmsJKITg1kR44K1UqFfexUK
 ZFGOzUAmNQQapMGAGgQJwEG2AoW8docpdmyIZG26C1S70wbnFBwmrFm8qpmRf+0OQlVL
 OgI7fHfEENS14Jx6hZ2m6v8v4PMqzTAvhKgSSs7wXNmp/JzQxAUloKlRoGIbkdA4bqJf
 fgFutz1/h5r/w4udXRIUc1HME+jh6eLjwNIu1OMoyyAF6YA+3XILp9pmYf8WQyO9UAR/
 DQ3lfMroNfMLfB5NHlsPaasUC1Z7wpVh41VSNJHwwHkqM2Gm6edEztGwOPPyjJ65JQuI
 BX3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmWWpwDglyoE2H9onolqYVaLUfJNZGj2UbaEZhhqE7Cwr/WXQHCyx7GxYBNyYZT6aMq5kjartES4Qe@nongnu.org
X-Gm-Message-State: AOJu0YyN61IfWSJ490V6suyKpg0UR+sXMnhHr+W2LYyz4YDPTQWmwVJK
 zcRZEYtHzqJFwoXjXuIFANB88yi3DVEiny53pg0eqjKDhIz6BUP0E5tyvu7BPXs=
X-Gm-Gg: ASbGncu8kSyEzMKvmKBKtGhmFI8C6MlJO4X7Iga7xjvA5usXsWZNm7z06YpX8/NoqMl
 V8fWBvv8dkhSitCkfge051z552a6A1BslA0T3FFmuo9HZR0HN57hW4IOk1F75zl0tUPQeui/Jy0
 PNllN+EEFQk9EphqxiY4vjd6tibIkvyKI0eUWV0vZwVi7pnu+P1NnyEJUqpNxfKOhvpZa1h9q9j
 IrU+aR8yuXeuC2z9b7ambsKlKEWe0vxe9dY1DuPwfZwKjFp619N/W63iPCt1JxD9e7txUYJ9apk
 T//pe2svFYoq3t6vYAp0PAXAHKxkqJc4ALphUikTbPxYFH0hFWkoqt8KZjqVWmgXQVChGAH/q4R
 0E4jHxYwo74VDUw0/OJOOLEg=
X-Google-Smtp-Source: AGHT+IEBAkPFaKD7l1/F/IFi1PcQDhmWFzoVZJxrTpfEXjuujAqOTz7xvI0p3184KMx40FHKNv9cGw==
X-Received: by 2002:a05:600c:5108:b0:43c:f6c6:578c with SMTP id
 5b1f17b1804b1-43db6247df8mr135733155e9.15.1743589891558; 
 Wed, 02 Apr 2025 03:31:31 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eb5fc67b3sm16495685e9.6.2025.04.02.03.31.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 03:31:31 -0700 (PDT)
Message-ID: <dffb0578-e449-4984-9a86-d675eff93485@linaro.org>
Date: Wed, 2 Apr 2025 12:31:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 2/5] qtest/bios-tables-test: Whitelist
 aarch64/virt/APIC.its_off blob
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250331221239.87150-1-philmd@linaro.org>
 <20250331221239.87150-3-philmd@linaro.org>
 <957f0d3e-0c25-4d88-b935-ddfe7cc75776@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <957f0d3e-0c25-4d88-b935-ddfe7cc75776@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 2/4/25 08:43, Gustavo Romero wrote:
> Hi Phil,
> 
> On 3/31/25 19:12, Philippe Mathieu-Daudé wrote:
>> Prepare for ACPI table change in aarch64/virt/APIC.its_off.
> 
> The comment could be smth like:
> 
> Ignore APIC.its_off expected table (blob) for now until
> we update it later, after fixing the code that generates
> this table correctly.
> 
> ?
> 
> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/ 
>> qtest/bios-tables-test-allowed-diff.h
>> index dfb8523c8bf..bfc4d601243 100644
>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>> @@ -1 +1,2 @@
>>   /* List of comma-separated changed AML files to ignore */
>> +"tests/data/acpi/aarch64/virt/APIC.its_off",
> 
> I think this patch should be merged into 1/2, accordingly to my
> comment in 1/5. FACP and IORT .its_off files should be added to the
> list as well.

No, otherwise the test added in previous patch fails.

> 
> Btw, IMHO the name of this header is a tad misleading, because actually
> "allowed-diff" means that "we allow the machine's table to be different
> from the tables listed in this header", so it doesn't look like an
> allowlist (whitelist), it works more like an ignore list?
> 
> 
> Cheers,
> Gustavo


