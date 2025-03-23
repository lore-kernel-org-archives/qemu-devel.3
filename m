Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFD2C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 18:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPi6-0004Tv-H8; Sun, 23 Mar 2025 14:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPi4-0004TN-7h
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 14:06:08 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPi2-0006oP-Mw
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 14:06:07 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2235189adaeso64665575ad.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 11:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742753165; x=1743357965; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=exsoVqliI0pazz/pMc5fWSEweVei2fXCR8JORV/6Pvo=;
 b=ahNC32R9B31TL1kppC8c0iqFAUhWEL/RuTHbiS29PiVoll+XwmVjnLAmd7MNLyqe86
 XxTAQ7FOaT5KQcEOoviZNUJpwv82NZdLUTRnizGv9aIfNxGL+7sIS77LwQftgCmPLV/T
 E6c+0jyfK8mguiZpzZSoJGfrlySRuX7zj3fucNjGIy68c1iahPoP9VWLkvndQy7Rw0Yl
 vzeD5+v9QUau0QNIHxXMNU3PdQnQbkx1zsTFx+kc7TtDOvCdsJSZM1k+tflVrIwckBKb
 DjKRrDvOz8m+9Cc7I51C1r2NTa8yJLG2sdDZvt7SajkmeRpFz0Xvj2F2qK2ERxV84VE0
 GEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742753165; x=1743357965;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=exsoVqliI0pazz/pMc5fWSEweVei2fXCR8JORV/6Pvo=;
 b=o8JbGyKmE4q9TmA8mcCbFSukORw5/BBqlewSfEfH7jNAHiBr/j5qvawK969fvIbRjh
 zDorCaRMaUOPhRiWZm33IUw0FswOEu+YkUqoGqwdsgV9WFHA0zes1UuCv9IR6NRil3Lu
 aFByGvCT2cIO8Ga1I7sq3QX367o3t3XfDNzCa4ILJGwPvWXXwLvvpEYREhuuFvtzK8X4
 GHPzXHNx6zPJEcLc1X+U4ex5a0PaktMlyZTb0KP1vNG1S5x8ChNU7Gp3tmgILjQ8X9MJ
 GWZblRQEf3UsL0QbApX9sxkGiNiNj4M7QmnOV8o6hMgXMLwgWbxVH1yA67LE2Y1J6b2c
 ZR7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUg5QkKICW5Qg7yK+yPZwTcAl5OJQOV12pKqT4apdJZ1jiD+LXYb9q5wTgS+HKjvE7GlSDUNZLQg6BX@nongnu.org
X-Gm-Message-State: AOJu0YyP3U/Fw9LXv0B3qT8RBF652hwA3ydvYxupZbLtcjA+wHliJXfB
 jPqqH2NLvEc3lHle4Z58JTV8fuBuja3AGFy8IEslmVL2+hfCmyV4NHHqdetrFJ0=
X-Gm-Gg: ASbGncsfMs+B4mvi+0dO66XSkbwM7isu6PZdNnv/Owvjh7xGKMDRS/udszzcUgSEvob
 oFbb8DHjbefytwyDqBoTCjvpOpmBaAD6YQOtHYp3gk9NW+XSnLKHjEQBQmL00WDQyGuwdRE5zlH
 GiiWxoGI2nHlAcEdcRnI6olbk7n1lDDrjcS/t6bb2sSs7Zr4XnFie4hHs+eBA8xF4FxRTfTH4hv
 wVGg+lUmXw9QFLCXQSlP0GMitp7L4RayXhjLHz3B84d1QhWfA7z0e3EaJ15VMGLnPEmhf70ZbGm
 K7IVdCzOkuF/nTAvqpHHumjwTpoA3y6tDz/OMMq+X51bSCUFtY5S5x3Rbel2Ahru4j+C161oqgX
 kkyi5gB8d
X-Google-Smtp-Source: AGHT+IGy093Bv4vpVz2c0pMjgjQCJLmb2QzQT4Pa8/Eq1NFpmCMH/2rmeR+K1tbbPuI09Tm4FZtupg==
X-Received: by 2002:a17:903:19c4:b0:223:517a:d4ed with SMTP id
 d9443c01a7336-227806d70eamr176012725ad.15.1742753164843; 
 Sun, 23 Mar 2025 11:06:04 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f3b4d8sm54227875ad.40.2025.03.23.11.06.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 11:06:04 -0700 (PDT)
Message-ID: <7981f797-36f0-4144-a996-996aae47e69b@linaro.org>
Date: Sun, 23 Mar 2025 11:06:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 v2 6/7] tcg: Have tcg_req_mo() use
 TCGCPUOps::guest_default_memory_order
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250321181549.3331-1-philmd@linaro.org>
 <20250321181549.3331-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250321181549.3331-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 3/21/25 11:15, Philippe Mathieu-Daudé wrote:
> In order to use TCG with multiple targets, replace the
> compile time use of TCG_GUEST_DEFAULT_MO by a runtime access
> to TCGCPUOps::guest_default_memory_order via CPUState.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/internal-target.h | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

