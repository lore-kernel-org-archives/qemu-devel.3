Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C9DC54EDA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 11:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjGX2-00023L-2x; Wed, 28 Aug 2024 07:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjGX0-0001yA-Ky
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 07:08:06 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjGWy-00016p-Nn
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 07:08:06 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-270420e231aso4179328fac.2
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 04:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724843283; x=1725448083; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m26K8JMvsB2j33hg+ib++FQqhUk6wCw8ZasiEUlHdg0=;
 b=gZxHRzwZgCalUdtZ6B4mzlteBm2i00NNyZ+miCa4+GtI28Wf3hOzmCn6A+wXWsadrN
 nCbUoq+HBU2KJcglnQq6NX94fBNA9ssZO/3+E57uD/60+9m1hRHE5f8OfNIOzsHZpRmi
 AAsrXqQ0IusHOYhQ/ITMo/uoWEC25WeohPntmtPPKfJdPHQNvg6Erkep3onjWYIekvLG
 +3VecMJQnj+IkFbLeJvcaqw2z6x8tGZC0jygl/dy8QDo7VNw+Yicnb2R47LWjTp2mlij
 aVSvhe4bDK74Ai6B+EO0OVRaTTdlGRSRNe2dsvgmJH0/CqkA+gZm72fY7t17q0CZYzvR
 cF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724843283; x=1725448083;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m26K8JMvsB2j33hg+ib++FQqhUk6wCw8ZasiEUlHdg0=;
 b=HsgTYIhNuYwFFD/IxFjC2jE3ntDhs+s50e+mdPbQubqp8vZqSUr5cqcFUHAWv1+PRA
 WkZsPrK8hs7OdCnDCV/ou4pVDcEMLOkVqqkhUyF+K6wYhelwp6HsgmZGDPMqRt/N/BK7
 Y1KIKfPDm+h+AZ83SRysvN0CvHW2GSEPaZXFwicuoNfxowtvPLqF57sem57QN/cmL/Vm
 PpAKF66nEfP9+01kgtN/RNuJj+YqNVNdI3d9/69gK14PxpB5Vd8Pq2OIKR7fKlbdBg3g
 MoQh3+s37teZVo+/W1ekRC0K3x4bFqPFTSRPozRSypSvLaIRAy5VB3kj4FN/wHETnupi
 zo1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgGv4yszkFgLQh/Jmc+WbcPMAdOA99lBY8grIdL91DDFmCeF/kyKmJ4YwbgbScnj4Bq1abRctVazuy@nongnu.org
X-Gm-Message-State: AOJu0Yx/n5DNDzGhBBAesH6rkrZAIUvkmMhtwyyT85sRYOSEPIUGWy2T
 a4vbwjvBTWU6OL6M7rggs+EQMLPcjRGI5LRpTv1ROgBzaVjgpNM+TT89QU3u9rk=
X-Google-Smtp-Source: AGHT+IFi8e0z32OehA5lDihFvMFs4z7GJAwVn0jcrHETGGgqw+dXqCQhgRQV9//FIX4WGleJ6ZWVVQ==
X-Received: by 2002:a05:6870:b68b:b0:261:877:7459 with SMTP id
 586e51a60fabf-2777d305e4emr1492894fac.38.1724843283064; 
 Wed, 28 Aug 2024 04:08:03 -0700 (PDT)
Received: from [192.168.98.227] ([172.58.111.246])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-273cebd131esm3683834fac.58.2024.08.28.04.08.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Aug 2024 04:08:02 -0700 (PDT)
Message-ID: <f6e22a52-7c41-4811-a0c7-9644731b1f9b@linaro.org>
Date: Wed, 28 Aug 2024 21:07:55 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 17/20] target/arm: Do memory type alignment check when
 translation disabled
To: Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
 <20240305135237.3111642-18-peter.maydell@linaro.org>
 <241ba192-359c-483c-aeea-1023a47c4e74@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <241ba192-359c-483c-aeea-1023a47c4e74@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/28/24 17:22, Michael Tokarev wrote:
> 05.03.2024 16:52, Peter Maydell wrote:
>> From: Richard Henderson <richard.henderson@linaro.org>
>>
>> If translation is disabled, the default memory type is Device, which
>> requires alignment checking.  This is more optimally done early via
>> the MemOp given to the TCG memory operation.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reported-by: Idan Horowitz <idan.horowitz@gmail.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-id: 20240301204110.656742-6-richard.henderson@linaro.org
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1204
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
> Hi!
> 
> Apparently this change also breaks picolibc testsuite (between
> 8.2 and 9.0, bisect points to this commit).
> 
> For example:
> 
> ./qemu-system-arm \
>    -m 1G \
>    -chardev stdio,mux=on,id=stdio0 \
>    -semihosting-config enable=on,chardev=stdio0,arg=program-name \
>    -monitor none \
>    -serial none \
>    -machine none,accel=tcg \
>    -cpu cortex-a8 \
>    -device loader,file=/tmp/picolibc-1.8.6/arm-none-eabi/test/ 
> printf_scanf_thumb_v7_fp_softfp,cpu-num=0 \
>    -nographic

Almost certainly a duplicate of #2326, fixed in master by 
4c2c0474693229c1f533239bb983495c5427784d.


r~

