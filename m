Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3E2C44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 14:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wje7h-0004iL-AP; Tue, 14 Jul 2026 10:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wje7f-0004ht-Ka
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:28:35 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wje7c-0004gg-OE
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 10:28:34 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-381891a9525so4737401a91.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 07:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784039311; x=1784644111; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZkD53N6VfYhC+ccSYYsfDyAI/fc5VzkQVGBAy6ugitI=;
 b=crZ2XGZn+keEMpp7/5+qtfNv/DDzU1ZkQ3H9RIKyR3lpIk7KNeJCAIEB6HZ+3ewfKG
 FnhhMsZ1XUKuGVdt8b4MTFu0j5D4L7kLVaIZdDxVgDl42zcy3nd2X0+v+CID3/dmmxNz
 9smJ3CmLL0lT/KhwEUn73K6CTKcsQ46FFK6bvsMdq8dWsCtRdYl/Aue2Wnm3B8P51cGG
 Anl9Bq4STGLTasvk75NqkN/UhX+8dg401dQ8jH5tAAvG8Rx5j05CkIQkWdZVM3qcNIHD
 ghryiExoeIroS/gLN36blGj6hcQSfOdbXmkOVCnMuN53GlCPjLXRcuHoL8lT1wNj9xmU
 Vmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784039311; x=1784644111;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZkD53N6VfYhC+ccSYYsfDyAI/fc5VzkQVGBAy6ugitI=;
 b=m2f2dnTt6u6gcr20r93VYvtch+GHPgHxRlQiGgM0AQfKl9ABeKrJUmV0w5qiidu6fw
 WGS0BkkFG0wWvOXHu7ZTmKq3lxYUheAR9fAqlPk/9juZfanXsjt4KZ5fXgLLKLwf6QLQ
 STVqq/Z8YlQLs4eA8xGGJaTwekySK+hSVLq+owC44zuE30zliv9cMR2FDph1uvPel8/K
 X9dak3KihSr/ql6jAQ0ZedC4uJZ3h5uZTEICkEt6xTGrjeqMCe3H4qvyeEB2wZ7O7zzk
 /xN+SpkstDOY1OjOwUFLPAxgEDL6SA0eRWvNqOV77hZrVjw1N3yYvLougFPo6rGcxW1/
 qRog==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVx/EInZBEJmUkt3y0BySQhEVPpwxae+C69WU7M1Wz0uOV/5QHY9Id/Z1/p3LgLJKNO9zwsZ2L+fv3@nongnu.org
X-Gm-Message-State: AOJu0YztZLmEpmPOggDmdhPpCNXs6SPFmQE6sg0Itw6tb6k2Cut4/kT/
 Ns8i2uba8CmoTcFq6MOtBA8z4gafux6olEAPzJ+4KNJHh5NuoczkdN1JArFiJjg4Xl8=
X-Gm-Gg: AfdE7cmaJPcUDMr+oaRea4X22Lmu3yK253LB5IzVuPYgm0tkNmHU/j67WW8Jj7Zcyp4
 dfXqc66CVQoAiq92To15gIeIWkas0PkblbrR6tbv+62tGM+aBQxQKzPmgRnu49nuc0T7YDTLP6m
 oRXfrOb3nPx3p9a3PRFIp+eqcTPAQiyYj+ugAu7eLCn3ikC3g0BIbkZXw2pGvWo2+zRIYPLxOhE
 HRjmeKVSxnQp6516RuP0r4CF0zM/DvNriVLO4X5hPTx273HV3nY5yqNo9VmQg6dkEcBkJr04Vgw
 KzGS7qoYfKBLDf/rBXHqvRBH5DMaQanVNQdliC60iOn4wbNVdUX6Ar+uF+nARDQLiWFObXumEoy
 cwIC0adbq+DR3zhugp1z2RYjLjy0ieBPKdBPfWJr9K4VzvtsDjj3HR1awemwIIbYn70tbyTCjtj
 1/HAY8s2oLdmRHTqhLEebJn4siKg==
X-Received: by 2002:a17:90b:1646:b0:381:bc4c:da5b with SMTP id
 98e67ed59e1d1-38e1ae5c1cemr2514776a91.18.1784039310981; 
 Tue, 14 Jul 2026 07:28:30 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.146.49])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38d302d5982sm4551314a91.2.2026.07.14.07.28.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 07:28:30 -0700 (PDT)
Message-ID: <54396244-4a4f-4d32-8b75-2c0401fc9bfc@linaro.org>
Date: Tue, 14 Jul 2026 07:28:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/s390x: Make PRNO TRNG interruptible
To: Ilya Leoshkevich <iii@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Harald Freudenberger <freude@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-stable@nongnu.org
References: <20260714113946.275122-1-iii@linux.ibm.com>
 <20260714113946.275122-2-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260714113946.275122-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 7/14/26 04:34, Ilya Leoshkevich wrote:
> fill_buf_random() writes the entire guest-requested amount of random
> bytes in one go. Since the length is a full 64-bit value, a guest can
> request several gigabytes and keep the vCPU spinning inside the helper,
> without a chance to react to interrupts.
> 
> Do the same thing as cpacf_sha512(): process only a limited amount of
> data per instruction execution and report partial completion with
> condition code 3. This way the guest reissues the instruction, and
> pending interrupts can be handled in between.
> 
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Fixes: 3dbc5fdacb5a ("target/s390x: support PRNO_TRNG instruction")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/crypto_helper.c | 25 +++++++++++++++++++------
>   1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
> index 8fe0a222198..4902c4e93ba 100644
> --- a/target/s390x/tcg/crypto_helper.c
> +++ b/target/s390x/tcg/crypto_helper.c
> @@ -242,12 +242,13 @@ static int cpacf_sha512(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>       return !len ? 0 : 3;
>   }
>   
> -static void fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
> -                            uint64_t *buf_reg, uint64_t *len_reg)
> +static int fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
> +                           uint64_t *buf_reg, uint64_t *len_reg)
>   {
> +    enum { MAX_BYTES_PER_RUN = 8192 }; /* Arbitrary: keep interactivity. */
>       const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
>       uint8_t tmp[256];
> -    uint64_t len = *len_reg;
> +    uint64_t len = *len_reg, processed = 0;
>       int buf_reg_len = 64;
>   
>       if (!(env->psw.mask & PSW_MASK_64)) {
> @@ -258,6 +259,10 @@ static void fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>       while (len) {
>           size_t block = MIN(len, sizeof(tmp));
>   
> +        if (processed >= MAX_BYTES_PER_RUN) {
> +            break;
> +        }

Alternately, stop with cpu_loop_exit_requested() at the bottom of the loop.

Either way,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

