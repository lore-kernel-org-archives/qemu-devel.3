Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38454C982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 20:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6vp0-0002GS-Ki; Wed, 16 Sep 2026 16:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6voq-0002G7-W6
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 16:01:27 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6voo-00060m-Tv
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 16:01:24 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc50bcf87b2so43855a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 13:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789588880; x=1790193680; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=grBhvtJiOkTraGTpm5AYZCtzN8O5euX8I7MJ3U+9SjY=;
 b=HEPs/pOcDOGlIS2VKirxPXJoqh5jR/pH1kgOtliU1KeiY2rmYQ4fAM70+PnBWdarGf
 qTbJqBcr22D9LmJS58C95Ppt9UZ0nX9svXZaImlqQ1GIaXOdJ2M1LLpZuBD8RbX7IIzZ
 53EWa+KRn4KfN8KT9OwPogqTqYZtJiR4jT/eQUu4mxGNHgqE/nP24E0ZIDYs2QnqbPkR
 cCBHP8iPromTkoAGCvVVYJyJyYiqVpHOAcM9eN/YLp9wKf7uCxOXVw2NRq3RR63+cPo/
 nlCXa0J8rOWExCMe3pr1zeFc0CSyHxK7q1Sd4AwO/YT+lrxPMM8EgxW/IgsZsVPGMD9U
 x7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789588880; x=1790193680;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=grBhvtJiOkTraGTpm5AYZCtzN8O5euX8I7MJ3U+9SjY=;
 b=WER0quY7IT9hMC7LpRryh8og19A7T48+VWJOLm0v/3c8DbF6HFfGJc7WoF2L69kc/p
 fP/zp5GoH4tmjwmlwqIg0UchPNKIPJfD07CvpjBXeRkdIL/baW4b6rbI6uFZ3uRbpZzD
 u1d+t3amosEAquznvuRSjf7OyDQFFuv4ebwQ0sJ+EadQGsO5id2WtUHszTAIJuUaFXKF
 COipNWZDf+qRKM68HF7XQ4q62qrdxLK7uhmtDQ7yXY1dhhAXt2ryBQfX1y25muCxGpM0
 AjGNfKXnXAiWgqo3JQfuyxuweisaZZlP3a/dfIxf8v21d0YGzOSreqUS/Q2oWVL11p67
 /Mfw==
X-Gm-Message-State: AFuF++mYaoGOQohlUTnx3iRnCXIUBCL0kRWo1+VKXJC347wfX9O8zppv
 YEvvMzpidDLxH0C6sF2DOnp+iPO+T+DK+sokOYgy+Vkj0OIcR0X6uIa01B4l0NAOPhe1an7bXeS
 bj5qH
X-Gm-Gg: AYBFou232uU/I+7wVEJ//VsutejljcwbOZpEr7+Q7rpMY/GPimqWmBp8bytAMUPyRII
 l70acyeOP6Tl4E2Zht7mBdLMQNJOIuhIYzsKW3WtoSVVOa3nFifPAkPlbL+rD/Q0mY5GXd2plL3
 S06nyzNgHAfYK8+v9M4hLnCGtXSj6LiDk16UeVFni5BihItmUNNHv+BcXgI/Wn2Nf5eLIfUttpr
 CXz5dW62nALgR/pT3pnJFl1tDXLVUzqxxTLWYcu3FKlfO0Ya7U2AwVITgA52CiTti/ot08obCtz
 1S8Mj6Na0oMO2KrJ5Cw0JAIJv3fibOey+iCGKXtpSrXT+i5YzTANqHwnx5cATr5xcnRQ/ILfgrW
 kHPYUbKCv54tnx/UwuQ8zrs/tPXPRIFHCmoF65p3f2gcg2DLv9Raax/s5cKmI9gkWKIGs3UMOTM
 TRuHgOolnag9zWEpaxyw1dd3l8AHT17Z9/D3+1D5StyKeLwFb5lDzB5HVrcZCO/cZ4kxOa5uolP
 T9x3OsvOTMziCDCdS+vx+cqMU45mGFsKos2B3c1670JccjIIWqHmr9ou9KTDQ==
X-Received: by 2002:a17:90b:2585:b0:39e:261:4e10 with SMTP id
 98e67ed59e1d1-39e1e5380cdmr11536298a91.22.1789588880208; 
 Wed, 16 Sep 2026 13:01:20 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:2521:7533:da60:6a28?
 ([2603:800c:7900:ed00:2521:7533:da60:6a28])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5ad9ed5sm10574659eec.22.2026.09.16.13.01.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 13:01:19 -0700 (PDT)
Message-ID: <663295d0-b1de-4c8f-bfbb-f2f85c7cb77a@linaro.org>
Date: Wed, 16 Sep 2026 10:01:16 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/tcg: compute C of CC_OP_ADOX without going
 through helper
To: qemu-devel@nongnu.org
References: <20260916133033.875328-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260916133033.875328-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/16/26 03:30, Paolo Bonzini wrote:
> With the CC_OP_ADOX cc_op, the carry flag remains in CC_SRC just like
> with CC_OP_EFLAGS.  Add CC_OP_ADOX to the same gen_prepare_eflags_c
> fast path as CC_OP_EFLAGS, to avoid generating a helper call.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

