Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F005C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 17:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEt4K-0000Nc-Gy; Tue, 13 May 2025 13:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEt2W-00060P-9W
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:03:36 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEt2U-0007tT-9Z
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:03:36 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so34123395e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747155812; x=1747760612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ec7nBzZXny1twVolLK/NIf749kxcJmpJJJ9Zt7x7exA=;
 b=CtwKKLVSnd9y5o6wil9nmIP9aBPzV+yfhEKjIMRGlnTvsdgj+pUJLgE4jE0UvkFjTC
 gDEPaKyHuUA5vDQixtLKg9y4ixjwKO9vuvW9bWn8nGZkkbiOpVEFg7iMOn2hwiUR0Yer
 /CCjBUy7Ki4h3KU4up6eXmcw6kLKUN/eLU6lvEbhklfseKi59Svqsz8S20eBdZ5/ORam
 AFUWNaODhlXhfXP8p4TGjYgbaHsoZ4yBg3SMqO5tK2JlcByF/cBAx3+gEssUdRyPpVi+
 yxWUvoMOkVSHm06iF15dJtdWQA/NK9IPfEhNfrgHK/loNhLJezRByk3CAYddtp/vynA+
 u4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747155812; x=1747760612;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ec7nBzZXny1twVolLK/NIf749kxcJmpJJJ9Zt7x7exA=;
 b=PK5mbWmhaGZATCFw/Uok4OHwUfHki5OWFNLyN4BV1oapXX24y3gMV6kybMoF30ezKo
 VQqgdMWSrRqmyfwCeH87w/LhcManWFouqST/PE53qsjMGoveY3c2Xt2Nz1HRz4K9vM4E
 21C7wysL8bPYWQ4LNpRfODnzDR7KKkJ+eQdTjWki/l5yGCX2ogswIIPlybHJshCOteUg
 p3QuoSPNxahd/5z7sFu3Wr2t0bd6CX5IaEKpkNo41bwhbjhUPurywrTnlq85rzLYu/SR
 a+NJziRKn1VDh6CV83wnkisxR35zxhu9TRKhzk4E0inrYMOONjltc4+FD0ddBEJ9PwWZ
 IJ8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrk3rbpKMRNxmWiVO+bwV/0w8FdqHjYdtMAlkhUp1Z4kL4QrSlyK2MGgDP6c1f5mZEBC/+67OHMt8G@nongnu.org
X-Gm-Message-State: AOJu0Yx2Jt86ISyk2UBJ9BZolCBc/VjppbSAXWNDwMSYMJKF9mSpoJ6D
 G3B2FxMnwFBVbckcY+Q8MN2uuPJyLq3CQP5f8afBckAjW6RBQisCZ4joIKLimyw=
X-Gm-Gg: ASbGncuik8ZTQtnQQAabVVXWKjKeFM6AapjX7N1meXmAhRbTFZ5Tmbejdfib+xtPSYC
 wc42j+Z/C3USBglGEohPftUFk5+NHIP4Ofy0ZZCW++4JeZNIeyEHeirVCdrsWuUzk8KuLbyYbcs
 HW3OdhqroN16y9itPktJtPmYh/Lu7cwgNmUJyR6XwRktvko5V0QSh3NDi3wNmpf5Y05CbfAq9nG
 bfJwV8BTgjkryFBvochh9H6jOpqmJ1Mbhxmdy58hxlVWWuRwi7yV5jWqL8BOvE4xGrpzPCAlMby
 2k8klGlDUsiIdNBV/QzsBydZOwu/GAsXKX05KsFtmh0X7iWH1ivREoFOfiqa+EaePvP9GToC3Rw
 XlhZeww53I1tdDXLI4X727UP9E9o=
X-Google-Smtp-Source: AGHT+IHuvD7b+uKWAZi2SJclzjF+sG6qnTzikqIaAqLvy1x6sWnsYSvbygtOJLCjYHGjW57+5kTnug==
X-Received: by 2002:a05:600c:3b17:b0:43c:f8fc:f686 with SMTP id
 5b1f17b1804b1-442f20bb64dmr1242485e9.3.1747155812242; 
 Tue, 13 May 2025 10:03:32 -0700 (PDT)
Received: from [10.61.1.204] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d687bdcbsm176408005e9.40.2025.05.13.10.03.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 10:03:31 -0700 (PDT)
Message-ID: <39c6f5ab-6e45-491d-a0e8-07408e29e2f8@linaro.org>
Date: Tue, 13 May 2025 18:03:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 30/48] target/arm/ptw: replace TARGET_AARCH64 by
 CONFIG_ATOMIC64 from arm_casq_ptw
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
 <20250512180502.2395029-31-pierrick.bouvier@linaro.org>
 <91cd9b9a-8c67-47d3-8b19-ebaf0b4fab5d@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <91cd9b9a-8c67-47d3-8b19-ebaf0b4fab5d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

On 5/13/25 03:41, Philippe Mathieu-Daudé wrote:
> On 12/5/25 20:04, Pierrick Bouvier wrote:
>> This function needs 64 bit compare exchange, so we hide implementation
>> for hosts not supporting it (some 32 bit target, which don't run 64 bit
>> guests anyway).
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   target/arm/ptw.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
>> index 68ec3f5e755..44170d831cc 100644
>> --- a/target/arm/ptw.c
>> +++ b/target/arm/ptw.c
>> @@ -737,7 +737,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
>>                                uint64_t new_val, S1Translate *ptw,
>>                                ARMMMUFaultInfo *fi)
>>   {
>> -#if defined(TARGET_AARCH64) && defined(CONFIG_TCG)
>> +#if defined(CONFIG_ATOMIC64) && defined(CONFIG_TCG)
>>       uint64_t cur_val;
>>       void *host = ptw->out_host;
> 
> I'd feel safer squashing:
> 
> -- >8 --
> @@ -743,2 +743,5 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
> 
> +    /* AArch32 does not have FEAT_HADFS */
> +    assert(cpu_isar_feature(aa64_hafs, env_archcpu(env)));

Why?  This is checked in the setting of param.{ha,hd}.
See aa{32,64}_va_parameters.


r~

