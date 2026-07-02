Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBA5C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 21:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfOeO-0001Pm-4X; Thu, 02 Jul 2026 17:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOeL-0001PL-Bf
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 17:08:45 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOeJ-00011U-ER
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 17:08:44 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2c7c61b5292so27191455ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 14:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783026522; x=1783631322; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BQ5cgBE0VgG58lorMSGXTlUncx7Jc7Yhqw/8oibGLdU=;
 b=p8R+NKL6iKcZSrRZtLPJ6YggVe7GBsNRIZSvew19a6KZ8wZ1X4iOlqGz+pOssFjsv2
 f48D6F9XLBq15NQDYvH/Rw27daK41znzsijO/vBdbhx7ywy60XSbA7+OeHSY9nFt2FQ8
 2QsdL3oYHG3wETYx1fDNqfSyzfypRlInXQTIxloocNQ4nShN+n0p0pLhugAKE9hXxhra
 z+m7WKbVT+1r1qaxokEDnl9r0hRbRm2q4zBh9X8TPssX3WuNUSN5up4f1Arjo2WWH0Z9
 9FtcXVBmJdI1BA4+SCDu6k09c0p/kv+zd1pFT9Z7wGHtkMUjZlz74gvYF5jZ0MALLmpR
 W0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783026522; x=1783631322;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BQ5cgBE0VgG58lorMSGXTlUncx7Jc7Yhqw/8oibGLdU=;
 b=JcHYe8l/ojHoom1oqsIoiflHzm3xjq7tYS+CJvDVQ5YdrgCKNWy+3NsNryleTEcuJL
 IvQ2JZ0O6HNOG+cJs1//ZEnywOnPyPM7NKEkbXOHyYpPfqH8Pa2fUyv75tf3GUbDs9Cp
 VG8dYIF2n+IlpgUwuy9tlM/0afCo71NdNr5tUIyujTmD+bGHZasr0hgaTyJqQjE1h3nM
 cjNhI/xKa0DRdW0j/X3ZNYmv1sItV+5eBWI+IHKPwPuNxzCSjMhLqy1LBktxV3tqr85j
 Ya2FQCtx66sjHrGMJU5/NxXJY7i9DtE/hAvwWCLlARIYNe76wDCUf/wRGJWZqvMPy8Bl
 f4lg==
X-Gm-Message-State: AOJu0Yyg+rDVietbvjuZc+/cwYpkg6jlfofBLfF0WhEdl5471J4lhdSQ
 TwxBp/BF2N70Cgf0QX1EtTezd12QEpneSdDiK9X5MAYCc5VhNCoDHNxe6adqCzCUpEnO4mj3yr7
 RQIma
X-Gm-Gg: AfdE7ckAxG7BXxq+WKS4JfMtcGquJR6B9qpGkL2N4kd09cYfCM9jnuaPD1EnsSffoMm
 W7ETJBjK2DVApP9vr0cBhNzf6RvVPMmkjBgCXZP4m7Ldls2JeXW/o0hwYgjWb7y/BB0xHtA8DWK
 oXqvP9ArMfhUckZuP65nWn65PENBiwKWm763o06RLRkB1zobbLV6prk3C9joXM4s1tJNirgdJH4
 PauE7VxtgqfNlKRh7LMHyeOkRqpcXB/Ae/4t8t743LQ7t7YLADtbC+Zn0hfXA5d0ORaQmVhf1Im
 aMALdftKyZlTyOIFliVcCTFlV9UIOk93GqZxJY2COHUTuJ/1qsLY6cTE3gt39Ale13Ux4oLWDmG
 xArtFji5eFCa5XJFiv6qWtiGyq4zgh+2mvFz79TeZJZxXpu5/qK9hsnulqW4bsiVQUEm8ybYgtk
 e+FnQO7p+4OwCv7Evv3rMwIhotOtZtk6kzt67ZAErpgaurxtcCtafR98Vfq9GOJswfg5co
X-Received: by 2002:a17:902:ffcb:b0:2ca:4f33:e86f with SMTP id
 d9443c01a7336-2ca911408c0mr62404905ad.12.1783026521350; 
 Thu, 02 Jul 2026 14:08:41 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad226a90asm1040585ad.3.2026.07.02.14.08.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 14:08:40 -0700 (PDT)
Message-ID: <5a567e88-ea85-4da8-9e6a-88124f6fadb3@linaro.org>
Date: Thu, 2 Jul 2026 14:08:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] target/arm: Update confusing comment in
 cpacr_write()
To: qemu-devel@nongnu.org
References: <20260702184019.3431139-1-peter.maydell@linaro.org>
 <20260702184019.3431139-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260702184019.3431139-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 7/2/26 11:40, Peter Maydell wrote:
> In cpacr_write() a comment says "In ARMv8 most bits of CPACR_EL1 are
> RES0", and the mask value is left at 0, implying that we enforce
> those RES0 bits.  In fact we only enforce RES0 when ARM_FEATURE_V8 is
> not implemented, and for v8 and up we allow the guest to write any
> bits.  The addition of architectural features in v8 and v9 has also
> resulted in the addition of new bits to CPACR_EL1, so "most bits are
> RES0" isn't really true any more.
> 
> Update the comment to be a bit clearer.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

