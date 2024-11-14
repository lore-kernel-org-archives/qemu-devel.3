Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE37D6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeGR-00068p-Se; Thu, 14 Nov 2024 13:08:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeGB-000674-IH
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:08:05 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeGA-0003g3-51
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:08:03 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-211c1c144f5so8343575ad.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731607680; x=1732212480; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=21oNHqfNnasJetS1uucdBJi0+7jeLGccYGgs73soutc=;
 b=yOc1lGvMynS2D6d1Nv+fTUFv4eyqtrVhFTx2yMJEytEmiJbfz+YS2u4Op+h5POG4ES
 mU15cOPMq3/Buf2e9/aaKLdt/lGI3NA147v3NyqjWgorNWH1bmLD0J/8TQ72RjI0CwiC
 LfiQfVhqmZkGDOu2qByl4EVm9hP03WIXCphOro/KUr7w14KwzcezHhHo9GVJLX6UlE+w
 RdThGpJ6MSQbjdzJTk0v8/xAXmWJToesnFXlIJ4ZTl7JdGLGfwf3523WSwPCAQkOM3nh
 iR4Bs+q9i00D7SzZRC73DDOQIzTi1RZrSu3pMxo12bWgfaQT1A4te57eQY09kdAalODx
 btGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607680; x=1732212480;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=21oNHqfNnasJetS1uucdBJi0+7jeLGccYGgs73soutc=;
 b=hyDZBhMv9htajyK4kcVBokM/MkvJaoPJ44kD8W6eaUesYEPyX6n11zmjL92MolmYFk
 T99oXoK/1nn+X5zs94UrMThX2LUxDjj5xyG3bkkJYdxvGWX2WtkiXKtUfmBqr49LQ13D
 DnCfNn7XWzrdEXsAi5dKqiiU6YTEHbIIHVGgOQkAhca2DqaJXwhcdVEYQIHRZjTyZ/zs
 BgZ+5HsQ+UpX2llYCiweuZ7ZZeC3PqzkE8mQjINab8rqqgiaEAhcv8/LoWHQLu437aOm
 RZHUia6kA32BZRlSeqvuSsskb8LJfSj46iGzdY+148Y4y4+BnLYzs2Pf9DPQ4oxHUhA3
 TFnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNyFUQyB0XN6hXpUVYmzN34T6px6ea43H1XJJb57wPkj+gCIzawILik8G2ra6eLwk6MoCF9CZAFK2f@nongnu.org
X-Gm-Message-State: AOJu0YwEvXCKxt3ShvG5cgwevxc9VpICCCu6+XL46/nfvyC376d2PMXq
 Yjelz9frR2f3l9oKtkQBU4K4ADtMpeFawufc2PWWI7rZ/mq7ipT5eSZXdK48wr8=
X-Google-Smtp-Source: AGHT+IETwU3tfllDvxigR2gcTUy2yolPtr/YAC5BVG/Gd8bBO8PXg1bdTLVI9C4A/tR377TpaSMUyg==
X-Received: by 2002:a17:902:d4d0:b0:20c:da9a:d5a8 with SMTP id
 d9443c01a7336-211c0f1eed6mr56045095ad.9.1731607680318; 
 Thu, 14 Nov 2024 10:08:00 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a6f257asm1545060b3a.76.2024.11.14.10.07.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:07:59 -0800 (PST)
Message-ID: <dee55ff2-8e80-4f7e-ba45-3c12897b8111@linaro.org>
Date: Thu, 14 Nov 2024 10:07:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/54] accel/tcg: Remove tlb_n_used_entries_inc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-20-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 11/14/24 08:00, Richard Henderson wrote:
> Expand the function into its only caller, using the
> existing CPUTLBDesc local pointer.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 8caa8c0f1d..3e24529f4f 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -354,11 +354,6 @@ static void tlb_mmu_init(CPUTLBDesc *desc, CPUTLBDescFast *fast, int64_t now)
>       tlb_mmu_flush_locked(desc, fast);
>   }
>   
> -static inline void tlb_n_used_entries_inc(CPUState *cpu, uintptr_t mmu_idx)
> -{
> -    cpu->neg.tlb.d[mmu_idx].n_used_entries++;
> -}
> -
>   void tlb_init(CPUState *cpu)
>   {
>       int64_t now = get_clock_realtime();
> @@ -1211,7 +1206,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>   
>       node->full = *full;
>       copy_tlb_helper_locked(te, &node->copy);
> -    tlb_n_used_entries_inc(cpu, mmu_idx);
> +    desc->n_used_entries++;
>       qemu_spin_unlock(&tlb->c.lock);
>   }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


