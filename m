Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57D9CD4F4A
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 16:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOe4I-0007Qo-4A; Sun, 17 May 2026 12:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOe4H-0007QQ-1V
 for qemu-devel@nongnu.org; Sun, 17 May 2026 12:10:17 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOe4E-00035x-U3
 for qemu-devel@nongnu.org; Sun, 17 May 2026 12:10:16 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488b150559bso11015335e9.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 09:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779034212; x=1779639012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y5wekYsrrHsjRiWbsrz/6bxJHwl1iTCmRIHkD/xdnBw=;
 b=oTZMR4b0jWK86kdLaby1YrL0DbsJOiZykenGjAvb4u5Hhdd8yQavVRbGskyNxilgiS
 ENJBT1HLLDjZwsnWfoRf2UuFB/z9DGeuYCTVoZ/djpAoyXvzYJC7oCQRRKj62ovaXbyq
 y4/w24jWi3vIACHpAns+Fios2LLe+8n1fSfGoJPiDKrX8/+J0kbrPwzhhA55CmcfSxqb
 eLIWIoe1E4AiinSQ5mLQuGCmD851LfqEdTQWXmLILqE9VbIC/CD8soBWcv4B6o9LJbZi
 pAVJnYQyuHJFsjihxkZypwe8m/osUEtg9HD9d4tBWtlapbX0/eJ5mtWYQIpw8hHxkNmN
 T8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779034212; x=1779639012;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y5wekYsrrHsjRiWbsrz/6bxJHwl1iTCmRIHkD/xdnBw=;
 b=la8XChyhQa/yH7gIn9AxVNhwCCExVhPxavztPtSjZRWsg85Ed1YK9f89jOqLZdCoza
 fSAsmE6VIcwe4waYNYla+4nXqLuWoH73J9oPawmo78Rc6aAEv8BcVWcEis9gkG8Zd8ui
 8xtg8IbNeO4btO+daxVaOJ40sGkVosto/5vxEYkGuS4K0h1QuwBZbJLbIPL9bOWfMwbq
 N0Hat811BoMEjhUh5ItNCYHgKLLZmSR4Es7isfOoh4diwmOjfPqwHnfbgZrh6UOOXoK6
 Uv+cqwiJDKMt2zdFp1oCcQTunXmL6p11GezJSzOGGDii8mmSC7XoAOwz3BFtEq6x7BHL
 shUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8dN3H/52KPEY7WnCwxolElOUv3u8aR2CldnHXXBAqtbh17+68MchtWv5eki8DDyDlj2aF9Avghj0Mc@nongnu.org
X-Gm-Message-State: AOJu0Yzn1wyPHLQPLEKtpF0xe3Ov5+kWiyq9fN3tjkBoI4+T8+/MDiEa
 elHu+2fVBMwm3MVU2e6p8Jy60Be4ymnJpG8AYTP7NVlQHamJE47m+euAtxw3nJx1Fd/R1UDxL86
 sDSygH3E=
X-Gm-Gg: Acq92OE5JsEcpyP/c2BEEtGzhk4vIkjpLFlm01kk4bCCBJkcygFcnZoRp2nysdvNo2g
 P4rjJI2Omw5icbqRf6z2r/G1dYWDvzkUadY0r/x6cV/ktE5sJASRW/iKxNl8sT6nFNK2qDSIMo4
 mbI+R36DM6wsaS+g6KuUIOjyZJo9zAKuGcCz847/0bdm50WXFj0+k+XC9odPfJh8C51lUXbTpHL
 FVOP7oYDDh6X0yIlad9QI5eNCMYmIAAGQqHdlHm1SdQk03RS9yIXJ4sOzkY7ppXtJJiXSIqR6PB
 RBeoLT19lPH7bE8xDzre25eOMrC16QPpqytaDibn3C15/7fXCTy9948roQvrrgD8zjU9Q4Obb2/
 TG8pjgC3VGNUMJu2Z9U6B/LgPyrK8qDRUdfm0/SqjciBgqk+S+3cjYsw4UQxU4k15o7DiYTYfT1
 xq+vPlM3vt0iyqadyi+XUxiCLaCl7MhiBbRXLKitoPLvDAxjyWf8kHPgNgdB4KRkQjRQ==
X-Received: by 2002:a05:600c:470e:b0:489:1c32:210d with SMTP id
 5b1f17b1804b1-48fe60f195amr161456815e9.15.1779034212222; 
 Sun, 17 May 2026 09:10:12 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe53ab6aasm207572375e9.2.2026.05.17.09.10.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 09:10:11 -0700 (PDT)
Message-ID: <4cfa2ecf-d445-4066-8f99-3128bff9d6bc@linaro.org>
Date: Sun, 17 May 2026 18:10:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/12] fpu: Introduce exp_scalbn
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260517002550.321291-1-richard.henderson@linaro.org>
 <20260517002550.321291-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260517002550.321291-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 17/5/26 02:25, Richard Henderson wrote:
> Avoid exponent overflow as well as checking that we don't
> lose information with opposing scaling.  Use it in partsN(scalbn)
> and partsN(round_to_int_normal).
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c           | 17 +++++++++++++++++
>   fpu/softfloat-parts.c.inc |  5 ++---
>   2 files changed, 19 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

