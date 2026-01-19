Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D4BC98315
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 00:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhdZF-0000LO-Ck; Sun, 18 Jan 2026 19:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhdZ6-0000H0-9S
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 19:56:21 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhdZ3-0008UB-7M
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 19:56:18 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a09d981507so27586845ad.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 16:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768784175; x=1769388975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JS2HzkFX9TjvbTW78RyBhHGHpOwKk9rGObnnK6SroCo=;
 b=J5L1OMR4TRdSXiNBK+RZEZOnNLZA5m0eiJNhS6dvA6sLWEcCFbuSQx8mOqo/LgmKXi
 JNzB0S6i+VyyaH8syHg1Ivg8JoFZEminer+M7c1YB6vKS5PSASQ9ZJkvgWWON7f61DiJ
 9+cpibtFlmwznQ5ro51MiA8CpJ1B1G0aExt5rQtA40vVQVXF1Hr+AKEv5G3Yt7Q9c9nP
 1Kutm9o4+Ks9zP/3IiLNhkYLLbC+RkshPTzCF489tLGxjS4YCEPXGn96hYeFIojIaGwu
 7+jcd6AHNRukYOVQfxBcsv1HPpfBoRaVdJJKeMvYWn/Ga7fNk7OfLgld9Jca5s/2bw23
 g7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768784175; x=1769388975;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JS2HzkFX9TjvbTW78RyBhHGHpOwKk9rGObnnK6SroCo=;
 b=ijHb/5igm1gDWZ97XNuYbVF+yK1AACTv2P6oMu7MgnzGOjDlFIdNZk2aJKZliLvB1L
 pcOAdoFUSqRkPy78z8KStw+S7OQ/joZBagRGhEKzIyh34WLwmCJ8XZlNOIFBIgN5SsG3
 wM89CYeMQJrXfHQwXXY5jT47/mYG6JlC8J1VSqiqA/1o1+IJCPB8y1jHocvkJ7wzJXos
 mQp+RiVApEugk5YhKuNmnuj6VrXNWHD6d8/hcsMWntitMPdFEdqLzmCZlmOfI925GPNk
 9pEVv10L2Xk55PznXt5gex4+SQ+OnaZHV9sD2k5u5qoHXuGnvAj9/oYLfQhUZC1p1mPt
 figg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9Lw5ATdKZgbhmH102kY7j/DrM7m7Fk9JseQDFww8f0ZhtOv+w0djSydGArNg9fDJ4zMhkfGW/k3GM@nongnu.org
X-Gm-Message-State: AOJu0Yy26AGgbuirpTcvLrMyVII+RDXu4p/WYiSvV9rpL/AFDGOsvbi0
 nOnwAJdutHmkxqSLy2Y3TvyM6aHhYDVB1X+6TqrZuJ4DCXcRVx1rAHU2YDMWAA6vGqg=
X-Gm-Gg: AY/fxX5iNumoYvqe8Nu0GNQZH1nrm0gmWwa8Lhc9uMG1xTHF0Ug2DV/dL+pY9+JmWJK
 JSP6z0eb8Gw5SC8Mn0JJQjftDDOU+V3aj+aaKlRuadu1Ngefg8nDAePVxCzDlOk7tW3n+T4XWMe
 1rpqKs0I2JBYk4gVNoN+ILWWjQx8o+/rybIIFesU2SKSQkmYYNBTfaPIgmXvZNScbk9xA0ZXKZ5
 JBqaWtPs5tB5wYKCsL3NrgfWzxBgIv7kPpbrROwFp0ptNou5W/iixa3GBuabJemAcd6cX7PQwSx
 7rXcNJOAJtCx4KT1z2hhbBGdO5X9SARFD31HKqd62XdYQ+RVXvYTnvWZPbdGb8bIeCnWMXLgqER
 XAGSS3xphreM18ekASG0E1MPl/SMzhHcxUDqR+1pOWIwoLPzKfdKSlbs5tnR8BoqxyHZDvU/43S
 ruEc7UJbfYJkMwk4ZSATL/mHTb5RV1ww==
X-Received: by 2002:a17:903:2f07:b0:2a0:eaf5:5cd8 with SMTP id
 d9443c01a7336-2a7009919c4mr110677155ad.9.1768784175300; 
 Sun, 18 Jan 2026 16:56:15 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190eeefasm75809185ad.43.2026.01.18.16.56.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 16:56:14 -0800 (PST)
Message-ID: <88bbc0e8-4392-4c93-9ea0-5e441c566f7a@linaro.org>
Date: Mon, 19 Jan 2026 11:56:09 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] target/i386/tcg: fix a few instructions that do not
 support VEX.L=1
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20260115113306.126905-1-pbonzini@redhat.com>
 <20260115113306.126905-2-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260115113306.126905-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/15/26 22:33, Paolo Bonzini wrote:
> Match the contents of table 2-17 ("#UD Exception and VEX.L Field Encoding")
> in the SDM, for instruction in exception class 5.  They were incorrectly
> accepting 256-bit versions that do not exist.
> 
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

