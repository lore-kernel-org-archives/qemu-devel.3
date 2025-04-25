Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F49C369D9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L49-0005IU-3B; Fri, 25 Apr 2025 11:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8L3n-0003Zn-4S
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:33:51 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8L3l-0004Oo-GL
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:33:50 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so1970578b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595227; x=1746200027; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QPCim8b+LO4Q2JcSDoJ2nk4O0pMo2S3iPj2Txm8vP3w=;
 b=wLZGDabH/BZVGCKqIJ9uO9bNEVlByGaYRlK6KOewrrtvVgDndAYwxIN9Gu5tHlDBST
 M7Q+LIrAfYfPBa/6FO5OC0iJjD0CVRrB0y5hq6P4fo+cmOa/h2LXekXh7m1qWfl2S/Bq
 SHYKJKAOCUGIWIzVisDKcF9kHr92a89tp1sVzEuAK5jRMxMliW5+wZ5RvhD9f/+z2UK/
 ugOrUyV+dPwCq122uyMtk21plzLePvWC6buCCxKhrGKPshXgFuQM/MZsrT7yx/WjkK72
 D6Oicf8oRs/vth4RXBPMAC3W8YuEZy29J1Hk6ose8i/caeFrvwVnIGozI+0ec14l15c+
 PJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595227; x=1746200027;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QPCim8b+LO4Q2JcSDoJ2nk4O0pMo2S3iPj2Txm8vP3w=;
 b=vTJ4rbVCnvlt+NBqg1K0la0hJe/m2My+3PYoQXJ4O8EN88fLHAYH0ybBe3O1oCJdsW
 2k0e6t+ooy7lBGeat7jQUGH7KywhZRkU84WWW0IV03ZXwex50fVaZLbf2x/FOUmwcaZX
 AhGxHzTHg+sD3KaE/1OmWmcUS3YVy4tVn6sJAJfJnGtJFqyyY3Cej78WNlN602Vcf27K
 VdviGcA2rH4N8fUVugqY5nfkaG+vosi4IbQIvCcV2ynuSi0pSHIOO0DtIBo0toDTaANN
 j5jU6RrPoN+7KGEQmWlyi3koyVzcXAVWE6uuFIuaHIpyLKe3YZDHnuxEOKhwLPFaNg+d
 AzIA==
X-Gm-Message-State: AOJu0Yyjuj80w6EXvP+KXkwgwnjttToTpCZSLdroYLuFaysmwIYFE//4
 fDvwXbyi9ohOBKAHZ3PzQV9IRr7EMdGHk9Ci+oboGuETD0DnJVSKKSzdTg4meQs=
X-Gm-Gg: ASbGncsaj3AbY5szUrZdUjbZ8FBlJYEOR5j6Q/Lyi4KyMvdzlhyZ5n9s5uzxKfFxcM9
 V2jTwYNd9dx5MeqNN0DW6WIsJxmgNTls1GZgPuRPzfdJhvGfgXF9AhEXXXI1IpEm6PCYlqLpjxW
 Djpdl1TP4AbwPrfjOAnvP8J0/XBLdtVn2EgO7Y8k1KBBOXNIe0tcOYe3IUGfuYViUrmI839EEii
 DE2VD0VtZXsxzFaM8w1xApQWc1N2CLErwv4A907BMStXmVY9UbeCCpn+N8mjnewTS+7rYeq9ehj
 GpDqnPLiDVP8au69mlOvUIgTFcCFk9s2l/6GkEoRvf2QuFvKwZeTTK6S8sLDzuq788qG2OFH8Tl
 VaQpjDWI=
X-Google-Smtp-Source: AGHT+IE/oQ4K6EnWfQGgNQPzyDfhP8uWARAMS+VZ/cPcaqCxAWJYlKy3QxsxrauDyGkH63dZ/rxLWQ==
X-Received: by 2002:a05:6a00:2e22:b0:736:339b:8296 with SMTP id
 d2e1a72fcca58-73fd896a1b8mr3636652b3a.18.1745595227173; 
 Fri, 25 Apr 2025 08:33:47 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259134a9sm3297699b3a.24.2025.04.25.08.33.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 08:33:46 -0700 (PDT)
Message-ID: <49fafb18-2186-4d19-867b-bc26c1c43572@linaro.org>
Date: Fri, 25 Apr 2025 08:33:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/loongarch/virt: Get physical entry address with elf
 file
To: Bibo Mao <maobibo@loongson.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20250425021620.3968737-1-maobibo@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250425021620.3968737-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 4/24/25 19:16, Bibo Mao wrote:
> With load_elf() api, image load low address and high address is converted
> to physical address if parameter translate_fn is provided. However
> executing entry address is still virtual address. Here convert entry
> address into physical address, since MMU is disabled when system power on,
> the first PC instruction should be physical address.
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> ---
>    v1 ... v2:
>    1. Only modify LoongArch specified rather than load_elf() API, since
>       there is be potential influence with other architectures.
> ---
>   hw/loongarch/boot.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Although perhaps we should adjust the API because all users have to do exactly this, and 
it's easy to miss.


r~

