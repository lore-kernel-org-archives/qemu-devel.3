Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A3DCD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 05:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN2Mz-0003d1-Ou; Wed, 13 May 2026 01:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN2Mw-0003cl-0b
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:42:54 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN2Mu-0006oR-Fv
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:42:53 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso3820999f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 22:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778650971; x=1779255771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NB/jCwlfQ2uFQsakTEAKgPRfsZ7fv11fG8ThOhE3jsQ=;
 b=ca37PNLhMBlM61vNCbZbzoEjoj5U1FEy1tMr4xEKPZFYj4j/56qwkAcELIv8gc+PW1
 59yLefGFCxxALtNavjAenZnueML1vHwkCLILp5MklZG0Nkxt17f3DjplCGw7bNZ/TlYW
 etOtgDgz1RT6ri6YjqAtR0mTJwC/fFiruxazdLBYj0H3R8Ek2qvrJvbmDzZ1laOhHSf5
 FfpgoOG/YPVOONZCQUEK8QIvLlWOodxRskBhQ00rf4tDbej3M06s98Xjde6EBdqODQ6q
 IpTEjNWJjn3BLQ+vGFMe02wBvOo3/6PZaDhZb3943PzQyy8vziCK4UOvoKEs51kPRmUF
 svEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778650971; x=1779255771;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NB/jCwlfQ2uFQsakTEAKgPRfsZ7fv11fG8ThOhE3jsQ=;
 b=cMHI7Ic6ueKvJT5mmaJ33WT1ItoR6AeoRs+2ycRkNJ5u3BE0ooyfq3DeK8el7tA1NV
 /Q/M6c/5+e2npaTA8VEQlPyXmXN8ccmX3My0R76SgzSLw3Rq4rYZdKnOW6R62a88uJqw
 Cqu9BFLcD8dSTJtokfEoxoNAIkhRq8f9alaExXulKDqlrZyeXL9mikr3ql5ECIF7dS0C
 MB13dfc/V9ybih//kSoGqOcUI7tAW3gzQfoz+gqKBjUvswhEdjS2XqTlPEjn+s6b9v07
 3SJcOWwditp0idnFuIRxXjlb1xAGwP21Ic7byrpKSS2k1Lm+ypQitsXK0vEXbIdRFtMv
 J4BA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6IclRaxhCdNs3E5j2ZsUuOImOJse84rBjvQ90RZgipQB8lLqo9fAwr9DktwMXIMZsa1NT9YuwI1PN@nongnu.org
X-Gm-Message-State: AOJu0YxJhT0niftv29fRIlz5hlKZM+y8CC+FaLaQ1cSD2Mw8yKNdv84K
 EoRIQSPbcTZCIlnV2lIsdkSDqNKNFgtruE9tIbns7HGveu786X1ImjkplbaGolUX9zM=
X-Gm-Gg: Acq92OHYW2AbCsjbB0ylUGW2OntNUtUSNkl46XTEtev96iVxaX6rgVZnVg1ctaO6vxr
 LcaGbewsDBrTq2Hvs+oiG/1BQnwExh8IhXWZOVY7nKagoAzv2R5QbYJSRztrUlp4hcYhRIS0krU
 R4R7kA6a3xyFiyjsBWO2hPPlQ4VKLzUWgr4ugFp+SmMFbOpSvWpn2X1VqV8rN7wDecPHP2UZyYe
 jYXlKaL8C4SowwnpBPBaQGADKa/jjZ6DwBHhcRseuMnqEtdvPe4gOir8WoM3NWxCf7Xq+hZYQGn
 KGCNQQ8FkDIboqSv55H9mYNf06FAEOOO5/SbAb3XhBvnbW+sJ83nZDZJrLhaf6V8RGNaGQPrvXf
 DbHAtkZkGmz3B9/shelV8cZ0vsKRcAjmq/8eyVav/hbkqWt5S7HYSJ0L4yo1Ap3CgtPsgCwZv/B
 E9GfbfQn1sBKru0VeorpXGI7Q6ACuRZG1WY0oYqptSd0UiNAk1b6PQcX9T7YgCU0NtbQ==
X-Received: by 2002:a05:6000:298e:20b0:441:2397:f40f with SMTP id
 ffacd0b85a97d-45ac0b2d93fmr7242105f8f.4.1778650969990; 
 Tue, 12 May 2026 22:42:49 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-454913049ecsm36701094f8f.19.2026.05.12.22.42.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 22:42:49 -0700 (PDT)
Message-ID: <4162b580-3e22-4aed-b5b7-d4bf2d073c33@linaro.org>
Date: Wed, 13 May 2026 07:42:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] hw/arm/omap: Remove omap_mpu_model remnants
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
 <20260512203414.3633237-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260512203414.3633237-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 12/5/26 22:34, Peter Maydell wrote:
> The omap1.c code has handling for an mpu_model field which is
> an enum of which OMAP SoC model it is. We removed most of our
> OMAP support some time ago, and now the only OMAP SoC we
> implement is the OMAP310, which sets s->mpu_model = omap310
> in omap310_mpu_init().
> 
> That makes all the handling for other settings of mpu_model dead
> code; remove them.  This includes the omap GPIO device's mpu_model
> property which we set but which the device makes no use of, and the
> omap-id-e20 memory region (because the OMAP310 satisfies
> cpu_is_omap15xx(), so never executed the old if() block).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/omap1.c        | 28 ++--------------------------
>   hw/gpio/omap_gpio.c   |  6 ------
>   hw/misc/omap_clk.c    |  9 +--------
>   include/hw/arm/omap.h | 18 ------------------
>   4 files changed, 3 insertions(+), 58 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

