Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E795F532D6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 05:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4uQG-000084-DE; Tue, 24 Mar 2026 01:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4uQC-000077-U7
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 01:35:21 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4uQB-00021g-3w
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 01:35:20 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so36496235e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 22:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774330516; x=1774935316; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tSH2Irs5xoB4y2iJJiD4Y2v8DjQv3zbMZ5VG97RgZf8=;
 b=qbCZSPuE3RXZA7quXOl6YjDrP+KdahIfmfKBR8wxFeAYHfJsjaDZYuSeRBXbpg3WOB
 UMhbky8xKGc3taJi59Iwv+5qeXgTWK8k1GCNu42DHEm6l7nshtyG05lTkq0VSM+kE0qA
 tC9/oPnj4dLhU+eKDvOZwvGZCUxKbhJK7qor/Q4NhJujRP0nN9F9QQrjf2+iIrut6b1m
 etdVNG9oFOJ6gXxiWzleDJuuA6h0LWhqpcqEHkGV1YpVSbsH7du3SjyI10DjG5ESxorm
 LIQL3gFb3H+Tzi+DwSIdmywsjWqV3kJ68IXw3A5IHTdx7SopgSfG5mn8biLX6vP5NfGG
 lZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774330516; x=1774935316;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tSH2Irs5xoB4y2iJJiD4Y2v8DjQv3zbMZ5VG97RgZf8=;
 b=HnW7VWidz0wOsZv7PY2lz0tNP3VddoUskqbGq0nt+jtJWAmOp2MosphvdmBRN9fOCX
 U6nC2XhrqjHej4eN8VNll/zOHpLcDIXv0HTi21EJmgLuUvmtlRPfwtXUucKkz8Iqybwa
 vvXkmn3mhUQz/UjZAJwpQ9VyGIUyzPCQPzgc+tDx3HjmOGE1672q3NF0cvwiTVslLw6G
 kqHFIi5YD/4mqoYH0EfEfThVuYAc2Q5XW6LdOXMW0LuBkSdHxBDoBrrA5zRaGgDhtM9I
 kukheBHGu06ONGvy3ihlG0EC1IctWvlXJd6/nWhO0DnVK2n1s52Il2iDAYp7vfBNHQ+P
 xcLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHmDvtULwo55hdn5RV/J5+GyorXAdSVnvX5G0OSsIAmR5oklqTsOPU3TCip+L1T+afIBu/2qiiVNHh@nongnu.org
X-Gm-Message-State: AOJu0Yx+v7CrUz7zO3tCr/+Bo9Ew7NAPbcHrmiCE1q+GPLPWkdeq3+6Y
 StDc456q7B4pak1l+cWd3lLtuwA8DOD6jjWPg55ZuRM605okuUx3p2ZwRUJw58T5AnY=
X-Gm-Gg: ATEYQzzg+i+w1ZmAS9J5sPV3X2BiWsispOm/QZGF47nZKSrPpRuH2edjgiXplP86CdM
 UMXyVUy4Gc4AXdVYS2hGFmSZtLffu0xLRubXy+tT6CzZ6bsxiRVa1vJYxTLYZZN+1wVIoImVkeO
 aDm8O/+ydaveIGGUEnfq9WfNTrN2+JMu7RwiCk2sRf9ZCWAcUAUblt5krOmklfLkL7xeszjZhzZ
 6xmvafjwBdGA309gtPjMJJm39NA9gPsRUzg4cRLmm2vbh5Wc7xXglJpySiJP6hN+apoO+V2ES9B
 vzDNmJsZSRcV8KM5fQFq9twYqu8CGpNGjJDbCHLn/9yS/AhOOwtmSFYDT6INBiWQkHZYsFLIROe
 /WM7tkCgH6YUSv1r3Bhq8mp/fiH//w41W/OBRXIapwKrU3FLbJ87xqcJzC43w1nHMIc3g+fBEld
 ob+Ir7SCi4hTX0HDeUN7B93yS5P793x5/Jvq4vsQCxL7Rk1ecZqBGR9RQnxYV4MYpU7J1aFNhhd
 gB4
X-Received: by 2002:a05:600c:828d:b0:47e:e48b:506d with SMTP id
 5b1f17b1804b1-486ff0291ccmr207941835e9.16.1774330516404; 
 Mon, 23 Mar 2026 22:35:16 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487116ee562sm27430095e9.15.2026.03.23.22.35.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 22:35:15 -0700 (PDT)
Message-ID: <186c9ed2-5e41-42d5-8d07-f90654cf35a9@linaro.org>
Date: Tue, 24 Mar 2026 06:35:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/tdx: Fix the UAF issue in tdx_fetch_cpuid()
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Stefan Weil <sw@weilnetz.de>
References: <20260324012313.1580760-1-xiaoyao.li@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260324012313.1580760-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 24/3/26 02:23, Xiaoyao Li wrote:
> Fix the UAF issue by reading the returned size before freeing the
> fetch_cpuid structure.
> 
> Link: https://lore.kernel.org/r/758d7f2c-938f-49cb-89fc-980fc8e020b2@weilnetz.de

Fixes: e3d1a4a6d1d ("i386/tdx: Fetch and validate CPUID of TD guest")

> Reported-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   target/i386/kvm/tdx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 4cae99c281ac..e578110df4da 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -847,8 +847,8 @@ static struct kvm_cpuid2 *tdx_fetch_cpuid(CPUState *cpu, int *ret)
>           fetch_cpuid->nent = size;
>           r = tdx_vcpu_ioctl(cpu, KVM_TDX_GET_CPUID, 0, fetch_cpuid, &local_err);
>           if (r == -E2BIG) {
> -            g_free(fetch_cpuid);
>               size = fetch_cpuid->nent;
> +            g_free(fetch_cpuid);
>           }
>       } while (r == -E2BIG);
>   


