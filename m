Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D29C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURPC-0005bO-Re; Wed, 25 Jun 2025 10:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURP1-0005W2-QH
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:47:13 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURP0-00057S-11
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:47:07 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22c33677183so19837995ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750862819; x=1751467619; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n+sPZyr+UiVFaKO0sDuBZb6xmBgKGiaOLm1DnLpzp7c=;
 b=rPafw41EJacLwiSQxC76Nu9oFDXAgBWgjt/kt65CO8ubiYDdsMVLDqnHzY5NQnUcuC
 oootkaCBCudqpvF5lhAFrm6VUyiB1QdE/8DYFLoBkXs6fRAOE4l7nupgpb018xjwVg2O
 m61lIoEFTvOpq27zMsxaY++R+8owWFHrXO0K10FX5re16uh0VP3mZAMv4KiD81z+9Qwr
 ERLnkYBkAQPMJRX4Mdxh+GynUukBZLk5vypcgnBIZnKNEwxkrZcH598WsqGcK0ESNDG8
 Ri9TBw54JVUEPyfNErPC6biwKj6qRu8oSsfidkUpPJaJXxVIIixWx8gT4vxZ3fX0lUXf
 m1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750862819; x=1751467619;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n+sPZyr+UiVFaKO0sDuBZb6xmBgKGiaOLm1DnLpzp7c=;
 b=AF7LtNl51b8vfVzdj3/gBfe1LVGZDoVyUsi/r36VXT3SMgafhsCtnscOkKj7phRiDT
 +TJvtDoI02JNXEOHmKKs2MSZf7rWZJTGUF01idwqy1jilHthIeU011s3WTjxnAKgbhVe
 MVuqvgRfQ3+eQdOZJ8KBkc3294H3yUn2CaOlIz8IswbqLQ2abudwqGNGvEY/rGKoboft
 pACiDyNS/I+xHBP5R1FTp/0Qd0Wl/3ka7/0ymtEb6s5d4cdDzIx66k6HB/6bb7yRFVQU
 RZFmjBB9uDugFOKKsTCRThOPhx0tTrHHSL7a+2XmOSK5mo45vIEMDWkGrKFJqRvqiIHh
 j2Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi7nq9hqumc5MApPNh2YApOo7mULLRFlExDzCOj2VL8ADg7Hm/wgYK1m50C5bU/gckaT2MSVQAV7Ze@nongnu.org
X-Gm-Message-State: AOJu0Yzw8HrL45dUnTZnNpvk0mB3qgESydz8K1gBGb6Mq7skyVVqCfow
 4G9IwivKF4x4eSrJaeKqcnFwdNokd6XdKUjPUG0jwnakGDPuCO5CJtGvtqO+/IafILs=
X-Gm-Gg: ASbGncussH/Krtv5a7m42aN2WXYwiTC36hTOZ9PGYur8Jghs67+gkznverBCts+jBwu
 Nem7B7oikV/8SweZEmJk9BBYs+Npurw9CGfP5owdkeHjisfPQxDFxbTbisGKYcg/lcd3w49fJrK
 aRQFzCW5BEF2QsoD4zlR+oEe1+rSLt+n961Z4wgc+MA2wrrg0IbYruVFQcrxnCqEVtccy7qds5x
 c8QGr4j15LY6lMWeCoTTja8rGidRrn2SYhLmKfVuMYb+b9NU57ILWQbWhSn3YSwseLCAGpWmKwN
 DmK5fF+HtO0tGiPBjqEAfaSLENVSq8T+W8LsWNvS89bh65KN3VTvy2IQMSqymHdN8sMZb34sYDM
 =
X-Google-Smtp-Source: AGHT+IF9wAhUPyR8fPmwb6smQVGB6nLrL+0Gaw+EL5EpClhJt67y4/vjC7lmA06qflgsF/hQ3Ktprg==
X-Received: by 2002:a17:903:1aac:b0:235:225d:3087 with SMTP id
 d9443c01a7336-2382424bffcmr52821065ad.30.1750862819619; 
 Wed, 25 Jun 2025 07:46:59 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d8393784sm132582185ad.11.2025.06.25.07.46.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:46:59 -0700 (PDT)
Message-ID: <7cbe81a7-96b9-48b9-a8ac-1e8afe61628c@linaro.org>
Date: Wed, 25 Jun 2025 07:46:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/27] tcg/optimize: Build and use o_bits in fold_andc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-6-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 6/3/25 1:08 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 23 ++++++++---------------
>   1 file changed, 8 insertions(+), 15 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


