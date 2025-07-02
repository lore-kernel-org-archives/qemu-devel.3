Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AF8C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWzWO-0001bH-KQ; Wed, 02 Jul 2025 11:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzWJ-0001b0-UN
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:37:12 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzWH-0007h4-4A
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:37:11 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-407a6c6a6d4so2278807b6e.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751470625; x=1752075425; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=as4F/fnFsuHkISjMt54nqsi/UhE98vv3TKNissWkEmU=;
 b=Q2cv8zXSd7rTukSpSay6t1SiAfBw6KmhsJnBdHZVMJEQQBNLS8eu43INApXiSSrLYp
 17R2M9PdShewDgaf8pqOp6xTlGgIdS+J0WSw/p8b9oiTzmpsyzfNo+zi3U3sggtVei0m
 l1z2cWULMTLKGEi6iHiJ2BQHwRE13wEJrId3gf553AKhnp9ljGe70Bv/DnQYw5ghp8bx
 9ZJ1bK1L8bHS7QdDkGs3CZj5OszkHT8NsSJxnUVcWlEJNj58VS+qhNzEdUvQF6g31qvo
 Dl+Bz/Iiq2Yb7YZZfCIhDjWvutOgbemLrsaCzPVWBuDLkwXZ+Zv0++jRxSYuLv5F5Xc8
 27dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751470625; x=1752075425;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=as4F/fnFsuHkISjMt54nqsi/UhE98vv3TKNissWkEmU=;
 b=XNUIGATK9CmOVT5hLye9xOyssSQCN4zBfJHxI5IzRkyH4zKWqSsEkTrjc8gUNb8wxu
 GbI/+I9jPvs8u/lQKhRnZ8pha48gv/Jnz68dB9wF1wQjvtJMJmOTBknAttoIWwJn2+zu
 512jM7L4JhwiHH3OfA3HIvFg/bfvQNDaoUNKmg+W7tybM2NPGOtuKUcPAnayjSVXyP1b
 vX8vfSGwNPC3e6izALPGKQqw2x/3vv4mX5tMlK/NAEixb5LzeHz+WJnABLWZmXIc/cd0
 aVL1JBfV4+rGi+pR8mudLN1o9EaweBvA9CBZedUyoGjxEvnOBhT3spsU14unxYPmbx6C
 mFGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuXTJayf7vAoMqaIL9d17VQHjWVM0V/VMiMmiz/pBKr6uU5m6M1AN2OZ/wZQCYEAXV+LQh633A1jSR@nongnu.org
X-Gm-Message-State: AOJu0Yw1ie0zfk04jx3a5S1/9Zpupb13sKPN0xmkEfrjwTr92aX96P8r
 GN0RBQD6OK8JdkDx59+zTvG+5doAP38uGpnYEp660N8On0TquvbuZ1uHRj0yQfCJDCUUHpRfrkG
 NfrYJAZY=
X-Gm-Gg: ASbGncuZ3PvtSKGUh7Tu6sTQC/mchArCU9sFgrN00FXdpoJdmwI+05ESWu9eXA1/WQv
 N6Pua5uvy3240f4Vi15fHyufUfEXgNAiKQBtaxaVOSPJPGg0LAzpOolUSmlld8lUlnHAcMsoefJ
 CFG5+Xo0+erlSQ0yLz8yyww6FylJa6fsuN/BbRpwGGP5AoiuKSEQwlDhGfExAJF27gylcNPjwHA
 bNbdZWkJWF/nLVWH+SSuRjzYlHSbqb8zC68GtoUIU2GLEtOfrYcDCrOwtK9Y/QbjGm3Za6F9yK6
 O8aB64paf6/W3xEORirE9E5u9EMHd7Tk0VUiSA3nndTcSI5HM+2uPmK9pCamulc5DTDWVNcE+li
 7
X-Google-Smtp-Source: AGHT+IFTV98MipssMFvJbOHaWUrKJ+LORxZ4a74iV1cf/6/qVNYRRm+TKmWJOOUbjYTJxJAYnu0bqQ==
X-Received: by 2002:a05:6808:2122:b0:40b:121b:65b4 with SMTP id
 5614622812f47-40b88818362mr2640118b6e.21.1751470625371; 
 Wed, 02 Jul 2025 08:37:05 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6120010b4absm286811eaf.34.2025.07.02.08.37.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:37:04 -0700 (PDT)
Message-ID: <a357c2ae-ca68-48c8-ad66-65a04c66c730@linaro.org>
Date: Wed, 2 Jul 2025 09:37:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 60/68] accel/tcg: Factor rr_cpu_exec() out for re-use
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-61-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-61-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

On 7/1/25 08:40, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops-rr.h |  2 ++
>   accel/tcg/tcg-accel-ops-rr.c | 31 ++++++++++++++++++++-----------
>   2 files changed, 22 insertions(+), 11 deletions(-)

I guess this is just completeness in matching mttcg, not that rr_cpu_exec will *ever* be 
called from outside tcg-accel-ops-rr.c.

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

