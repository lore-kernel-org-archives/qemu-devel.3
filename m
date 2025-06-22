Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88022C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTApI-0001VI-RC; Sat, 21 Jun 2025 22:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTApH-0001VA-NU
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:52:59 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTApF-0008Te-LO
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:52:59 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-234b9dfb842so27203365ad.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750560775; x=1751165575; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RBFIwjykjuDC3ISZTcrlajxbdT96H6rNf3HDpqX/59I=;
 b=LjXLNa9fKe8IA5TjbpRN6lovPAiQN7R6QNKKiKpgss0SJX39A0E7wjRNLIYvCPN1nD
 yJ9u4bAo5qFSJQ+DdSn+c2vx6AT5siC4F8QGpZ/GrZBpNao4l6tYYQr5R5RFlOLrxbA0
 OjTBolLsIYCHynvHltdtUsMCZU06XK4obkMX4+FoLHWEOuAMvUnLpZXyizd/ZYdO256j
 UAzTzXEHxkM/qsog7vIHpmGPbTZbw4GzQe9e0r6RnuQ6OgdEKwkSU6i0AS/+YCAQqKmG
 WGhTk8euVc8mXvvznNIcerzjrGxl+mZDjyEZkHFbevZ/kwKc0dPH70IfU7G95dKJ8Cur
 fdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750560775; x=1751165575;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RBFIwjykjuDC3ISZTcrlajxbdT96H6rNf3HDpqX/59I=;
 b=PEjPayLgsaexFfH5OFW0TXE3P/QAK+mWWCduVf/63J8WmnY0japhDc/3D4U7oSPOvZ
 C8jLzoxm13ROTmdA2Fxltd3CS2uZAa2JifRRKNl2n/FdU9HIaJd1SnrTqixtgYiI3WGG
 n2TFN1PO0AQo4rq1vRtXpsyCzwvuzi/bUxUxpQcH08Pa8dFHAopBPaWpyugmn/EV1AJj
 QANF4QBbKwQu0mhhSOSv/jAa2fRcSzQonpFxt5VhM0Gn3E+rMowgl09QmCQgt07h6GFb
 EoIO1MDSB0+xZqX7plRVkwaBSnXZaJ9x++Gtx0bQ8IJNKhRrRkjeu4KFrxmupKZhAjdr
 usNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcyzUK5najHaAnNG5Swr3CARYXVvXL5vxHba52wBhoinIxoEj1K5QeAgLaNwSeyxc6TMXmfRigOhl1@nongnu.org
X-Gm-Message-State: AOJu0YzkxVUxYHpJmhI+tYfK2i9FBMg0S3xonO9PJAC8t29pVVZUZCRL
 9fGiPDFuISFvPQ5UPLuZgUBZW+cOYk+yuEcH8Xi1pfwn0L5Ax/VkEoaPLUKxlxi+T5I=
X-Gm-Gg: ASbGnctfo3cqEa3wzEaVTH8W3PXKPkaYmONx+5JjayJInXReQd/2EGqwRAk9FDkjQqq
 th9nA7lVtFoTTkcggcIaHugTF5p9F0FqGom498vsBLwvFZeuviT4WW5m1rr09aMaf9TTogMCoLw
 GijQEORudoFWlgf9uGUpA6Wo+RuntQlR/Qc/DBIJ4/nH5CcnPcv8sILVZNNOJjmddLOPV0KmGs1
 gl1pgW/9zr0lM0/dZSesOImF/n4/eIOTD85SqshugZTSgCSSRHme8f6P5bK/XJwwj0EYJ557v8L
 kCEDR2OOzmzSD8xU7IhMQisZFTo90+i4NH6361jlUS2arfsn4AHYZ9hxRUbYgK4GEyqzIegYQVz
 m5vLuMiIgGDUcsVEvpy4uqj0MK3hf
X-Google-Smtp-Source: AGHT+IHcX0gkjT7k2XSSvYZ+39zLnQtqUo9aT92/0mhbBPjqCnt2r9FIPMuQwpTXk/WXiSDuY4HwyQ==
X-Received: by 2002:a17:902:f54a:b0:235:f3df:bc1f with SMTP id
 d9443c01a7336-237d9ab626bmr117922995ad.36.1750560775544; 
 Sat, 21 Jun 2025 19:52:55 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d86cf313sm51675655ad.202.2025.06.21.19.52.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:52:55 -0700 (PDT)
Message-ID: <8b5ed35a-dc45-4617-83dc-4770d6c3a39a@linaro.org>
Date: Sat, 21 Jun 2025 19:52:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 16/42] accel/split: Implement
 synchronize_state()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-17-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/split/split-accel-ops.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
> index 65feb929404..80efbd82091 100644
> --- a/accel/split/split-accel-ops.c
> +++ b/accel/split/split-accel-ops.c
> @@ -165,7 +165,16 @@ static void split_synchronize_post_init(CPUState *cpu)
>   
>   static void split_synchronize_state(CPUState *cpu)
>   {
> -    g_assert_not_reached();
> +    SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
> +    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
> +    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
> +
> +    if (hwc->ops->synchronize_state) {
> +        hwc->ops->synchronize_state(cpu);
> +    }
> +    if (swc->ops->synchronize_state) {
> +        swc->ops->synchronize_state(cpu);
> +    }
>   }

I suppose in the short-term this is ok, but it does more work than it should.

Let's make the simplifying assumption that even if there is another sw emulator, it'll 
still use CPUArchState.  So the "sync" to sw is pointless.

But syncing state to hw is only applicable when use_hw is true.
I'm not sure how to do the pointer chasing to find that from here.

r~

