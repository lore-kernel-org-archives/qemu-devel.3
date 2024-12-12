Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00FDE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLl6a-0005sS-9i; Thu, 12 Dec 2024 10:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLl6D-0005gq-Ab
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:27:34 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLl67-0007PQ-8O
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:27:33 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-71e1e051e50so200813a34.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 07:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734017246; x=1734622046; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2X2amFAWN/w2XgC+by8KMgA2ttRA75qc/cZ6xZzLCT0=;
 b=ZoyFhyyrm3dply2p3ls0yGlEu9NpOeqGXOmJJcrK/8bNAoUmZ4nfOWuvatBT5aIFAy
 1cTLL6EDCq8E1vbRJm1MgMBl5V8r1kYkSWD78RCnOZOnqMR8K3TggThR9GQ5sQnd1B0g
 f++oku1xlwR7x4lRde4wyrpwspQQXNk//sOvrkxS+wX6U3nBz41ipgX2GbeM8/D3Z4qh
 7h8X2KovcY27t2gV8BjdISufCnn036gfjT2Wp8Kw6jJ77GSYYwn4T8Kl/BEI0ZYCBjvz
 g99FVJWCoyf9Yc9kO5as+C/KBYfeMcqcRTmvVGdZjShXNxobiowbdQ0NS9nYl8zhp+/C
 KjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734017246; x=1734622046;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2X2amFAWN/w2XgC+by8KMgA2ttRA75qc/cZ6xZzLCT0=;
 b=bGsPbRN4OuzYwcjWXXJVD3juUYMZFfGygnRjIlDt2TkoQQMEqWe/fBUdjcLNqZxNGG
 /7Ga+DEY4urIwGqVKPSu1Gp3AHF29UVBckPWkZpKeFlwhpqgZliWYtxl/rpAcD9REpI/
 29BzMnYMd5LKE+o84LMeB+jCik877Sjwubg4KA+uMxU0fEc/3edmQkucDu8mNLE6r4oN
 L/YOpbEvdgZapo6FwNp96iZs1/7sotBbdppmSvXIgcbu3O3Bz0fauoZ4VLv7Id1Q2JmK
 ikIWeHIiWK+S7/QlxhJGqFsGmXmuSMNFWl9ImMCf7c9c7IgCqTs/akTKM9xLxvP58rEX
 MIVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2N/56tbQOW4xo2nWhXz5jgkuU4ecRUm0U0eUxd9LiD3h76VNyYa3N+uXxnnlrDKZfaFBLxaJFH2yu@nongnu.org
X-Gm-Message-State: AOJu0YyPPhctjD6pMqtFeFvuKXkFMYJhvME4RL31Igq6FxwVn/3h1wc/
 58OCP3S5ar+9I7++yQO3+zRQPbg3YjA2DaXoiU/wtQNgAP5R0ByGBt8/4xXYdrE=
X-Gm-Gg: ASbGncuVKbZ87PN+Jp9WgvajUy2wUAJR437JxgzQFR7bnd6nK1zWKqWi9/5jXDj1Bke
 MORI/LyGbTueekKqCb7roUKfFLlWUe2ulWnKGtiw3XbEdJSFFHkKgGhmIQRTfyasU3785U/UBQz
 BXCOQVgFqFh71+S4SqNacaljwHM1WX9b7rThV/JqW72lhucTdi2oZS9YNAX6yOfV2S13Wyv+bqQ
 l5gkERec8pf6x6JiIYPx6v6u9hhGW9QS/73r/okgZ2VdR3EYg+I2aDxiU3wqTjWZ5EE/z6Uu2j8
 0mmfuCzT/kNCudnYFEYHN0bkPyaniQgv3Bk=
X-Google-Smtp-Source: AGHT+IFXX29IcOunmSLw28v5Q8iFXcKaFEranhAcuva+OqPc1kny35glxJpNfK5RsVOmC9epyHZUdw==
X-Received: by 2002:a05:6830:7106:b0:718:1150:a02b with SMTP id
 46e09a7af769-71e36e36d16mr373872a34.1.1734017245952; 
 Thu, 12 Dec 2024 07:27:25 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e1db1f524sm667659a34.40.2024.12.12.07.27.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 07:27:25 -0800 (PST)
Message-ID: <0b583ee4-f3b7-4d6f-bd66-35a111805aea@linaro.org>
Date: Thu, 12 Dec 2024 09:27:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/11] target/ppc: replace tcg_gen_qemu_st_tl() with
 gen_st_tl()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, npiggin@gmail.com,
 danielhb413@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
 <20241212151412.570454-5-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241212151412.570454-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 12/12/24 09:14, Mark Cave-Ayland wrote:
> To ensure that all memory stores are performed by gen_st_tl(), convert all
> remaining users of tcg_gen_qemu_st_tl() with gen_st_tl().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   target/ppc/translate.c                     | 10 +++++-----
>   target/ppc/translate/fixedpoint-impl.c.inc |  2 +-
>   2 files changed, 6 insertions(+), 6 deletions(-)

I think you could squash patches 1+2 and 3+4.
Introduce the function and use it everywhere; the patches are not large.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

