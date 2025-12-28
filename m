Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E26E784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 22:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZzNz-0000KL-C9; Sun, 28 Dec 2025 17:37:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzNx-0000Jk-78
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:37:13 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzNv-0000OO-SM
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:37:12 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-786a822e73aso75218717b3.3
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 14:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766961430; x=1767566230; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+LBXkqFU5oYgH++RobLJVwgO08ZpIjZpc1yKu3yHXOA=;
 b=COXk1ZplPi9iWLnuKiUwZRRh3fNtWekXfJO7u3Ss/3hwaWPfZYLiylkWo4xlrb/pyn
 l7WQWU1Ljrd3ddCq5O6YBjAjUZm7typ0f8l9fNrIxAO/smZaiG9EnMBGtekEsQjZcNzp
 +XvxNZb7fPSmQKYDxh+dENCJYLRfDWO1X/NJ9gO/Shlwzh7DvAgkKYBks4b2tzlHyBER
 /vPuD/g8YnwIeFdXh4sVFBVVOn0g+q1gZKKJ2hys3U1/FCv/vdOixbhYq8MjNk07trv4
 GjP9v8bRDDyW/33UU+YL23kJEjAUaiai5sHw5uy0kLlt40ewB5AsL9QZkuu7IQI5qmo/
 UZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766961430; x=1767566230;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+LBXkqFU5oYgH++RobLJVwgO08ZpIjZpc1yKu3yHXOA=;
 b=mKTq+5J15YbUXpIDXA0DrImlppsf0jbCTu/A6Z6NIiR3T/Xtqkn54YgTevz+2dofNX
 uTnOAPb8Uu9UzPDBHcg7LOl0jgLIC7v0W5Bb8p+7+ZxMjnJN5lKg18kb0TiWM4F+gaZ1
 Iq+VI0O+siLH+lHeE8jPO8JCODrz1DNC/PI01/8d/JLyh/Xz+nvl5pOAhhUkak76vz+w
 tOpys5NtnjhourCatV1+tIm3g3Dqrbd0PI3pn9smrF7r28S+VE3wYLW3YDajOLEA9r2B
 fKqvuKVNbCay2zhNToCw28mKwypr6zv2kC1M0lh536EQu/iar2fMYTVzsv5WXYHzY//l
 6a3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlgZKBMg8IAkqsMGyolXmYr3myC4aufE4BdAEiXuZXWsbB710TKWjzuRrzHh7R4G3Dme4vTdSVf321@nongnu.org
X-Gm-Message-State: AOJu0YyTQ85ohy44CPUNVdJ1EryhcPkp2qvLgnmjuQmndeAnqORZE92D
 OI2rZBOD7jF2FsoVnCvPXpboV18c64X44vKLSiWQS4ac3x7WEfpXu3ApaF3OrowDLd4=
X-Gm-Gg: AY/fxX5M3e+nVlD9Iw4MRYAZ92+Vrlk31i/ldru1Tzu1PYPjqltjUPhk2NvyistHDfX
 X+WRLbhXEnWlOvB3ZNNWFXhyw3uwrs2pvlaJw9XiI6BS+uGglCiqavfp4SXsavUGAYqNPjyeZM8
 b4KxzstHeJULTdBm/aadHnwzLn1mNwplIChHvUjtNa+xyzYYjIMF1ZjXIoOvJydKZ+2XmQ9qvcj
 DtufTNbRNFysQyB7R/M9l4f3mhUChosMHcZjFa/eQeOcIslerExY2ve+LaZfJDT2m1kxSvJUawT
 WvQ42HRHcF40rVPxdGiv/hCqWMf/O5Yph3D4RTswX/cSw3/ILfZyu6ek8wZLx5+b2aC8Y9OquM/
 ZHLMhFeSP/bYWv0eMy/geFp6k443fpwESGh8YraSsr9Y/iqwSxMC494Bt1iwY8KHldQSCIstIYo
 MM6CUpJJPXeHayFYntxDCDNzD6ahaGbQOa4Z5/QDGGc6zVmVzg086p
X-Google-Smtp-Source: AGHT+IH4eAwJrAPU3+cPZp51DRsBTclxdwOalJ7URNXZA+QPBxZq6FkSwUAG9EcASJLZkFn+fQ0CBg==
X-Received: by 2002:a05:690c:4442:b0:78c:5803:f68e with SMTP id
 00721157ae682-78fb400de07mr239719797b3.33.1766961430272; 
 Sun, 28 Dec 2025 14:37:10 -0800 (PST)
Received: from [10.212.166.227] ([172.59.192.106])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78fb43a1b75sm107572847b3.16.2025.12.28.14.37.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 14:37:10 -0800 (PST)
Message-ID: <59d83d1a-0ea8-4329-8893-fadb30ee1b74@linaro.org>
Date: Mon, 29 Dec 2025 09:37:01 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] system/memory: Restrict legacy 'native-endian' APIs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@kernel.org>
References: <20251218212814.61445-1-philmd@linaro.org>
 <20251218212814.61445-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251218212814.61445-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1131.google.com
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

On 12/19/25 08:28, Philippe Mathieu-Daudé wrote:
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -412,7 +412,9 @@ static inline void stq_be_p(void *ptr, uint64_t v)
>           }                                                               \
>       }
>   
> +#ifdef TARGET_USE_LEGACY_NATIVE_ENDIAN_API
>   DO_STN_LDN_P(he)
> +#endif

This isn't target native endian.
Why is this included?


r~


