Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F87FDEE53
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 22:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG27p-0000zU-MF; Thu, 23 Apr 2026 18:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG27n-0000s1-OB
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:02:19 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG27l-0006F5-1u
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:02:19 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c6dd5b01e14so2540905a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 15:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776981735; x=1777586535; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BqtxL4TOybwWRAnA99BEzo0X+Tv+xS+/pi2vmrE8n9E=;
 b=fxKeK2vzbQUb95QHYQ2JHzS1L/VK38SGaWR0Ga487DWFEZqTKLX3xhfEgC+RIj3Bgl
 IT0xiQw2aiCOrcdJJ4w9F+ZfibPXKbcQqzxmwMAG7+e/kFSm4tb87PbW6Fwt9R9Aktpe
 piWuMyxjC/A7OwntBBv4mz3TeLFx2bOe+r9e2FENBtoRpISbAMf0s/oEOS0KtCMd7hPD
 0pinKlcQHUheIGPEPoYRtOA1ihZ2UoNUwsfTl26fhp1ausvb12wvgekInfH0Fe4PXQJm
 hdzpxlqmZeiJnjGaSqZhVh/ugQy45S79syBTDSzTxqZQjtg77anNQIzk3VfH9ow3PtX4
 r1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776981735; x=1777586535;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BqtxL4TOybwWRAnA99BEzo0X+Tv+xS+/pi2vmrE8n9E=;
 b=EyHRl4D/1WqK8b1RXFzzdYAxY2B/f7Qpm3WoOvWQxmOdrn/jwuaMuvbzSXjt3t6YAe
 xm4mvU/bCZxfWCCubmPwbOPj7XSZhGCnzb0xRm9muI9o5VaU4wvuH/EENb6hw4Gt0P+B
 1e6ReHEhZrytRjsebH4eF9wDmIOJAbZzqNwY4RAh5DJ6b9+yt1QIFmbAsauCzKzP4++0
 4hbjfQomC6Fi4PA/qnaLfhbQJfOVKA3cOBrHD7cLtBIG2b6gqJf9r/7rP+aDJudzUeVu
 KCceZ/L7zhHtd7CbBah3bGPC0dkLDInAxri5FFcrtqWbYiRYE/XQRmL9CE5EJ+ovl9yI
 6SCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+iWkLsUWwP+9npSrAnx1dS4ZRKiG8TSKOCGBT5Xw/Kh6bniN8NH0uLrTYFQAIXg1ozOqSOqI6wDl8u@nongnu.org
X-Gm-Message-State: AOJu0Yzvr7mKdAVZEpqJNkKWRYiqPskH2kIrIALwIz7L4RcNkzrSj8IP
 GHadG8RtL0wc+n0g+vwza+dmXCrici+OMrzZtfDIj2VWyCo97kDyF+tGN5dmvpM3NOs=
X-Gm-Gg: AeBDiet8nPf2jtgT79UYj7qhnmt9fPEaBSpcmerWyZz1JpsZlI94/E9GkCdvG6Ceh5l
 RLsZX9rFqqQStNYdkJKC08x7rhdQSpu/Rn04gO/m/HrbGk1QJtc3f6iCr5/Hx/3+5+T5iWCQT/F
 ce31hQu09KmosJDYkvFnpWq4nFpnhvQuRwGMXyI5hgP25rvpdRI9aJXe5JkdRE9NmFbGPYPh1dr
 VCkaBT7emdpiria2TTe7nWVZNV/P3vBpGmPW9M6CDdjFptVwSDmNeUyNp+JnutNTCq31SeRHlSn
 cbdQj2fqdhIISNl06rw8ZAikPcGlqEpg+aBnUfvC1sJNz80Maf6YXjrA+RrtLZx+kcCIXWf1G22
 yJaEt1SzwKsF9l6XsPq63C06NeMCLVcqJ4PFcrqANO3NjfqBk8FyLAx7aQXvi3gpsXyfdrzwOaQ
 v3Gyo2hy3kz4YxV1yUQxYoltBIwTMTjgp7YEc5mC5mZu60xCg+dSUhvgz0K9eI
X-Received: by 2002:a17:903:110c:b0:2b4:5e7e:34ce with SMTP id
 d9443c01a7336-2b5f9fb90efmr295564255ad.39.1776981735294; 
 Thu, 23 Apr 2026 15:02:15 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9fedf0sm246666345ad.6.2026.04.23.15.02.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 15:02:14 -0700 (PDT)
Message-ID: <0deb5c1b-deff-48ba-9836-d3d1c11786f8@linaro.org>
Date: Fri, 24 Apr 2026 08:02:07 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: Leverage 128-bit vector type in VLL / VSTL
 opcodes
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org
References: <20260423141245.51344-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260423141245.51344-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 4/24/26 00:12, Philippe Mathieu-Daudé wrote:
> @@ -43,19 +43,17 @@ void HELPER(gvec_vbperm)(void *v1, const void *v2, const void *v3,
>   
>   void HELPER(vll)(CPUS390XState *env, void *v1, uint64_t addr, uint64_t bytes)
>   {
> -    const int mmu_idx = cpu_mmu_index(env_cpu(env), false);
> +    int mmu_idx = cpu_mmu_index(env_cpu(env), false);
>       const uintptr_t ra = GETPC();
>       MemOpIdx oi;
>   
>       if (likely(bytes >= 16)) {
> -        uint64_t t0, t1;
> +        Int128 t;
>   
> -        oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
> -        t0 = cpu_ldq_mmu(env, addr, oi, ra);
> -        addr = wrap_address(env, addr + 8);
> -        t1 = cpu_ldq_mmu(env, addr, oi, ra);
> -        s390_vec_write_element64(v1, 0, t0);
> -        s390_vec_write_element64(v1, 1, t1);
> +        oi = make_memop_idx(MO_BE | MO_128 | MO_UNALN, mmu_idx);
> +        addr = wrap_address(env, addr + 16);
> +        t = cpu_ld16_mmu(env, addr, oi, ra);
> +        s390_vec_write_element128(v1, t);

The most important thing to consider when converting to 128-bit access is the atomicity, 
otherwise you can find yourself slowing down emulation when the host does not support 
atomic 128-bit access.

In this case, VLL (Vector Load with Length) loads n bytes, as can be seen with the 
fallback code just below.  So MO_ATOM_NONE is appropriate.  Similarly VSTL (Vector STore 
with Length).



r~

