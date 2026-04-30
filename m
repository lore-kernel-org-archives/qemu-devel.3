Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EA9FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIK5j-00048c-Cm; Thu, 30 Apr 2026 01:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIK5X-00046P-Bu
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:37:30 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIK5V-0000dE-9Z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:37:26 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so4457645e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777527443; x=1778132243; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p83a2KA0mduWZMrrAgGBK1vkuUMNVe6Q4xKU6DsISgs=;
 b=V7jCkXhciWT8o7NAizYXVY6q22Y3bdt12tGLMb3NzHkLYe+a+VWJ27Q4Ns2L/7cytW
 JZELlg8eKsoPpm+5FUALnEldSIzKDpwtWcESZzPvpCyqxR4SLmksRjSnmZBYE4JORsDq
 v5MVdY5/WrhiXDqUEWzxVQ+6iSe8SgvO3gPIzkVo6wiga4HD2CsFECbQFpN0Mdi0h4JK
 l5DH9WETFbRpZxTOakjt23DOY/WRVqsiVPoQ4TFT21PeP+SriP88jqu6YCZKy/bZtt5y
 oXHrhl496Z2Ush903AY4dm4hOjceRZ5JDznzRlqhBzOHq3eQAxV4jHwD5x2FFOroAvVM
 KxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777527443; x=1778132243;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p83a2KA0mduWZMrrAgGBK1vkuUMNVe6Q4xKU6DsISgs=;
 b=Jyu7wM341ptCYIGqwP7PR4bFOfCO/pGg93yCQPGElovLl+ZLtZvELTbhj5/dCu9v75
 7nnWprZ4QD+3t8FquM73z8O8HZ15XAt9hO71ZHImFKr6aPHyBOqYfyYsEMM63bZFZUUj
 DuOkOxOL6rk56sOrUGCsC7yIElTyTqyr9iWX6Plznq3NSXqn8a8TqFR4l+xTCC9Ef7P3
 fJC/DQqx/wxEj4hDw+NgYQYWcjrXOIM3yc8WZNOHfQPvrE8Fo0vu6sYLMLqJuGFcK9p8
 P+SsCGWK10IvVPRqz0NrP4rdh9yjXhipgSRtLMEfmOOmVk4fXPLtig3M3aetjGxv/oOU
 pMUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+SgzNV7dacbLyEzd43FUAR++SYrxEL1ZEZdPtWlYZ1YhzcZ5+IOIhZ8rTFEiCjrq0HyU4NqaxKLVwj@nongnu.org
X-Gm-Message-State: AOJu0YyrnAqNtX5Y241UgzaSv04xHtDVENhHu+Y8YVWCEZe7p+q+Gz2i
 mkvf0lystQfvmUQltXGxd52G6O5Zw/N4kwxMeXblXkFmhgDEvySLxty4l8Aex2e2hq9Pj+Qgr06
 jVta4RH0=
X-Gm-Gg: AeBDieug+y+QuNWKgKVNxAILmgIB84IgctSC26a1RH5BVJJXAKmpLrtCIixpgUAEi2A
 hYR4cujiqcIqyK8bXCtmOcl8j1AOaS0E+M7WdERlNMbUyspO6A0jqpH/tvazvdAlVLfO+3cjFmX
 Mzlm1u5HkJLKI9lJ0e3DAxnn0LneoKPr3tp8r67Or+itEO3YE2uGU5/NHcShRuMFX6UBnpwFVsh
 WKW0PxJxF4CqyTZH4n+lYS5mIVKp+AjyFysbiMWcnqKezOwZFXBwMi15pgAfvI7QLz4I0rm8TP4
 CmwiJL/01YMaxcyHMagDjk0hvx7S29aM+c+vTal2S5FRgL4Ycg+8QoNq6D5ls6O9g7hQFl81Ag6
 Ue62gFmrtsqnh9vTujruQDBDSYcbMAybve1MYVnsQ70WX49mRqWXJAioxaDSmuD5OPgKfjCjoY6
 zuAUnDxa2CCiZVtm3r8cwSSs0nBJqgMX+MY3mghUbVgKrPFBsBlxN+NiftAM3YpETk5RM5gdfjV
 UMlfmxUZeJUKFg=
X-Received: by 2002:a05:600c:548d:b0:487:21c7:2885 with SMTP id
 5b1f17b1804b1-48a83f6c90fmr22837045e9.5.1777527442892; 
 Wed, 29 Apr 2026 22:37:22 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c31fb8asm33859635e9.30.2026.04.29.22.37.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 22:37:21 -0700 (PDT)
Message-ID: <4e50dd26-e78d-4ed1-9a69-024de5e0bf02@linaro.org>
Date: Thu, 30 Apr 2026 07:37:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/40] fpu: Return struct from parts{64,128}_div
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-18-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-18-richard.henderson@linaro.org>
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

On 30/4/26 02:05, Richard Henderson wrote:
> At the same time, export.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat-parts.h |  9 +++++++
>   fpu/softfloat.c               | 34 +++++++++++++-------------
>   fpu/softfloat-parts.c.inc     | 45 ++++++++++++++++-------------------
>   3 files changed, 46 insertions(+), 42 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

