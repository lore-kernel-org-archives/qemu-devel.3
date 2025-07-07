Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9F3C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 19:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYrie-000500-OI; Mon, 07 Jul 2025 15:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYriO-0004pd-Ie
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:41:29 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYriM-0006bI-GV
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:41:23 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4a43d2d5569so42489141cf.0
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 12:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751917281; x=1752522081; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L/79aX9hJUbYRWiagLpke12TxNj5aQwKEiSFbncf7sM=;
 b=D+J5tnzuGO+uU5mULEbjLf49uC+zjRWi02mDU9bhRNGV6woosOutq5BcKT21alyLdf
 8GYsVoZJxs/XhEG+tN65trGxFLrxqpdwuIfKDOvjzSUjLFcs7QKE7oHp2x6qbwdIUiZT
 eF7i+e2esCIX0Au0odcrX2YCH8fjMjWG3buAJis1nhwTFplN0BSrxAezjKyqHBY8HxMp
 D2w8DrJKr2PtH9HpuFRiLgmyePzeb9UttS5aaXCy7xkF2PQoPkRMbJO/kIG3LlCxt7Cu
 y63DLCKNnK3Kt5Dj01qCJ7X1SQHv0c3bliH5puw4pOLE3o3qHwUACn2G5XIABwlgKe1t
 ncHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751917281; x=1752522081;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L/79aX9hJUbYRWiagLpke12TxNj5aQwKEiSFbncf7sM=;
 b=WQN7JbjRDXhSBVaSZc1BcgA89sdvp5pQg9jBuYASNDTaTp18kYCEvDBqbtFR2kdTlx
 +UrNbYITZN3fI/wlfKo3s7sPBkddjTi1HWFWcISiwQVONxBe7zSXx2Nxy3INc907i5aS
 Mm5RbRQZH1qSJB+RH5chdiCgDwHClDJQMTiLZKdkjbqZtiC1LMOUKCRoIqVHf6kybO7S
 ThiGjeBCRepGK6pwUiIzEEeOccTEBH3G8CgXGfKNDSezjFb1J78+mo9qdwmLme2O5yxc
 M9G2OxxxklIwJH9i4Y1qYcnk80QBOgj3bKKj221/7cIItgjMu7E1HgYXuG0oO3MWsfLu
 +lLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCj5SiIT/rRDpBOwFqUdJnNR7K1IMPf0skgCCCB9AOGDMVhOx7QZxTmlU+Kccr70z3l/4Bat5N6O29@nongnu.org
X-Gm-Message-State: AOJu0Yzv1pUcs83ot4NLdyDjg6cnku9twwJrTOfPwWbrBHEfIl1xx9cl
 WEMjmc4h5JY1biyIj8czIXVFuSQnSvAOzWWkXaItb2SidUb/SRkEiV/QAEpfGRlYNmo=
X-Gm-Gg: ASbGnct1bMvUZjWPVBq7zTZBC15G9+WwK0BFH+OATK4gJeo6D+a1AtmkzLGpcmQvydU
 KgyVQsP7BZaLZfKSBGPXmy502c1pUv0qG/CQwkcLHgRx8AvySqsTnfCnsJasB2UkUfQxUhXyH6o
 gDP1PwRs6JPVOyt6C7b46MtHvNzINpnL1EVNfzE1j0K1tiDMfw+e3oTo8ticYqwUVR8aDfactc0
 hOty+ZqRIfPfyAeXdDyetTwdAQDcNBVjP4hLc01tZkWwge1S9MS/G+4R27ii7/SmWKN5aM9/rrq
 ubhplN8GPvn8TwWOebzSS1Zt0NafPzefMysZdaiPggPppf5JfBMGrrRgYkQc8Q5FZFATrpudR7U
 mzud2GY01cNkHsUYgsMDbhNClRGptGl2aQ2MdTg==
X-Google-Smtp-Source: AGHT+IGvrs1B33S9RmcgYp/eGlPBxDf8xapbzRKqtDq0b/Pa/K+xsHBbrypVg+Yvo0aX1pM6Ra3UPA==
X-Received: by 2002:a05:622a:2cd:b0:4a6:f8aa:3a15 with SMTP id
 d75a77b69052e-4a9ca1a12ddmr33045191cf.30.1751917281122; 
 Mon, 07 Jul 2025 12:41:21 -0700 (PDT)
Received: from [10.225.72.227] ([172.58.142.143])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a9949f99d1sm69053781cf.24.2025.07.07.12.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 12:41:20 -0700 (PDT)
Message-ID: <34eff220-25f5-4dad-9ece-1a9d04fc603b@linaro.org>
Date: Mon, 7 Jul 2025 13:41:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/s390x/kvm: Use vaddr in
 find/insert_hw_breakpoint()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>
References: <20250707171059.3064-1-philmd@linaro.org>
 <20250707171059.3064-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250707171059.3064-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x834.google.com
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

On 7/7/25 11:10, Philippe Mathieu-Daudé wrote:
> Since commit b8a6eb1862a both kvm_arch_insert_hw_breakpoint()
> and kvm_arch_remove_hw_breakpoint() use a vaddr type. Use the
> same type for the callees.
> 
> Fixes: b8a6eb1862a ("sysemu/kvm: Use vaddr for kvm_arch_[insert|remove]_hw_breakpoint")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/kvm/kvm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index 67d9a1977c0..491cc5f9756 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -889,7 +889,7 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
>       return 0;
>   }
>   
> -static struct kvm_hw_breakpoint *find_hw_breakpoint(target_ulong addr,
> +static struct kvm_hw_breakpoint *find_hw_breakpoint(vaddr addr,
>                                                       int len, int type)
>   {
>       int n;
> @@ -904,7 +904,7 @@ static struct kvm_hw_breakpoint *find_hw_breakpoint(target_ulong addr,
>       return NULL;
>   }
>   
> -static int insert_hw_breakpoint(target_ulong addr, int len, int type)
> +static int insert_hw_breakpoint(vaddr addr, int len, int type)
>   {
>       int size;
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

