Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E1EC02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 09:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfxmJ-0004YT-MP; Thu, 06 Feb 2025 04:02:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfxm3-0004SZ-P4
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:02:18 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfxm1-0004xI-Hw
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:02:15 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38db34a5c5fso262614f8f.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 01:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738832530; x=1739437330; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y40mJMvxcD4zpanaxsb2tzkFSO+mRwuFjGcCX/RZUwM=;
 b=dC3WvUU2PMqkU2wY2FImPfSvUa05LPzWhRJEg8igR/Xiy267liFAPWumDkOZXoi5Z4
 Itpre5YB12xdi2Y7SrBWpMz6xzxDP5eoaSK1zbIHSikX77JYXyF4XGLsu2xB18p6caOg
 qXmvlo0QUnyebDXrMZiAg9GKVIUsOxsUd+jddJSnnuMFQAjsb5GHYy58zw4iCl0QZYiJ
 hIeEgqFspACF1YKa8cFDBWrBOvF00BTQHSpAev9nPgMJ8FLdtL5N5qtXlfTDisdTLAI0
 eHoLQJx7AwqdR3tN8+kYPQJaKa3SIpAgRZcnsMQvvA+Cz+eLZijzZrU8HFwlMI7RYzae
 UNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738832530; x=1739437330;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y40mJMvxcD4zpanaxsb2tzkFSO+mRwuFjGcCX/RZUwM=;
 b=vYW9fysxGi2sL/ojlOZj4DxufJPRNm/Ryez0a19TwvJM/U6WAtoPOOBgYkWEn49tLl
 uGKEiedgRdIZp4NwpHCl2YLc4uAzhbVLc+mM+bXevM7LKMj1E8/QoqY4TS1Kdv0c6vBg
 FDGShAO0gPdpCY7Lp48KVV4efKeMcjYDAsz4EwbRLgpxiP0ErjLXswa16CdcBq4bgVdi
 p0wrRNAlqT/cllJIWIL1qcGR+SvDEj8sKt79BMzqW0bK8dmZgpU3piugHMg2DGB3+995
 ZVi0+lElkPol0snzxh5LBAgbAd1CHnY/gkZTD82X1gZkP2hg25UpB1gfJaFsfWsULGjv
 JQ2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjIwvy+T2i3yhxMqy3Gkhq7OjZySijbHhVWLGv3fRAOerkGfO7sB4w5uQ+IZuUV/3wjn0wCPxqBvdh@nongnu.org
X-Gm-Message-State: AOJu0YysvVzFTBAlKUx35Y9fxBMB091KSKnePzCja8l9fvJJWncayPfK
 rChQbvEUJ885Nfj2BBIzdG0joGUr9DjsPoO+MYQ+7BW0jVPcqbETO0zGnfhA83RLs9x21FGnRo6
 iPkA=
X-Gm-Gg: ASbGncv8bXnSX6FUC80/NWVBouBERjRJi1MRg3xTc0VJo97ChWrKfssoW0yjzeko2Ng
 g+OLnGO6Nkv8cPCSzpOiNiTsvlHkYrkLQkA9wQepEpNM7d8xKcHRkTl38QcmYGaUPldcA5UA0Vx
 z5cTolWVn0p8jxSLqZ+1XFONEzYiI/IFdcViDiJldAkDeXevSN3R2CDxhag2XrdOmY/h6Rnk5TF
 nnZpLBZhC8Om36jtKzhAs6HyaoQRQy7o3dAITehgZIs/en6k4py0toOeIUuS8kVO+eRNaYjeykS
 ysM8T2SEOcrkKzErPj1tDiPiwfqeNAEphWL6XsePGau8kwdutN86cfF1Qd8=
X-Google-Smtp-Source: AGHT+IFPREV3y8i2qHU/in0o6MqoqS/Fv9O8aTBuGLkJbXmU4o6CSMqFrlEs0q1c6VD3QW2+eH+IDA==
X-Received: by 2002:a05:6000:1a89:b0:38d:b57e:7202 with SMTP id
 ffacd0b85a97d-38db57eab02mr4663731f8f.31.1738832530266; 
 Thu, 06 Feb 2025 01:02:10 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd54f2fsm1158964f8f.49.2025.02.06.01.02.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 01:02:09 -0800 (PST)
Message-ID: <a8ee0227-8385-4907-b24b-efddaf907165@linaro.org>
Date: Thu, 6 Feb 2025 10:02:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: fix vcpu reset command word issue
To: bibo mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
References: <20250205120635.2516406-1-lixianglai@loongson.cn>
 <3e857bbf-834b-3ae5-f9c4-35d858db5108@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3e857bbf-834b-3ae5-f9c4-35d858db5108@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 6/2/25 03:34, bibo mao wrote:
> On 2025/2/5 下午8:06, Xianglai Li wrote:
>> When the KVM_REG_LOONGARCH_VCPU_RESET command word
>> is sent to the kernel through the kvm_set_one_reg interface,
>> the parameter source needs to be a legal address,
>> otherwise the kernel will return an error and the command word
>> will fail to be sent.
> Hi Xianglai,
> 
> Good catch, it is actually one problem and thanks for reporting it.
> 
>>
>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>> ---
>> Cc: Bibo Mao <Maobibo@loongson.cn>
>> Cc: Song Gao <gaosong@loongson.cn>
>>
>>   target/loongarch/kvm/kvm.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
>> index a3f55155b0..01cddb7012 100644
>> --- a/target/loongarch/kvm/kvm.c
>> +++ b/target/loongarch/kvm/kvm.c
>> @@ -581,9 +581,10 @@ static int kvm_loongarch_get_lbt(CPUState *cs)
>>   void kvm_arch_reset_vcpu(CPUState *cs)
>>   {
>>       CPULoongArchState *env = cpu_env(cs);
>> +    uint64_t val;
> How about set initial value here although it is not used? such as
>         uint64_t val = 0;

Or        uint64_t unused = 0;

>>       env->mp_state = KVM_MP_STATE_RUNNABLE;
>> -    kvm_set_one_reg(cs, KVM_REG_LOONGARCH_VCPU_RESET, 0);
>> +    kvm_set_one_reg(cs, KVM_REG_LOONGARCH_VCPU_RESET, &val);
> Can we add return value checking here? such as
>         ret = kvm_set_one_reg(cs, KVM_REG_LOONGARCH_VCPU_RESET, &val);
>         if (ret) {
>             error_report("... %s", strerror(errno));
>         }
> 
> Regards
> Bibo Mao
>>   }
>>   static int kvm_loongarch_get_mpstate(CPUState *cs)
>>
> 
> 


