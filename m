Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4F3C0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 20:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc8oy-0004XF-Kl; Sun, 26 Jan 2025 15:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc8ng-00033l-5M
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 15:00:11 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc8ne-0003JG-Hn
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 15:00:07 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ef714374c0so5728306a91.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 12:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737921605; x=1738526405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jvT1nOyyGXJEnkXkKCQj0Xq14BrdlE2RAOYFWR4ybQg=;
 b=IUq5IpTPOLSEIAuBU+WXvx6ntkc2O4sbUPKuU1v+o3MF77F79fnfBTlB59lyEkYorh
 4ZSbtqd0A35SwGQ4obMNLeqvYMJXjE117/2LHk6/N7w4/h5ra2WORh7i9wuXvFWs75/M
 S5pq9BU8ZA+DGyw6zWLCtJlKrVYT2SthY3O4sXjGR6U5p9CEKyCZyYKR91BrEmRW3iOD
 21foiQPoiD1Ftte71ZUP3MAT9DTYX158Fb73zGA8oIZaO15OczHxvml7ScQ1gtAULbmj
 5/g+77PvF5HZlF1oIETlh9foRgHVxSVCnKfxaPXExcgcU17X0cSWcxoVG0c/3dLS8enW
 fuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737921605; x=1738526405;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jvT1nOyyGXJEnkXkKCQj0Xq14BrdlE2RAOYFWR4ybQg=;
 b=uS1Hev1F8Bg+GJKqErIfuothXEqsZkJE62IIa5ZK9/NQ+jtXJsIvBuof8mg/eDfxsw
 aN0HjKBpIosG2li4h6v5vaaT1SwL91KzpYOahqKXv3iayEWY4SLKXroYvBVbfNpe1QZ0
 uCnoLbOM0fcTIaOLtEqljzAogn1Er+mNA5uoE4pUbvP8HOVQPdD1Vo7QNiIVreiMAEcA
 h6kdmmrOpFTzBL1tSnYKycuWRgsrVQkbGu1pUrt682emLx+WaPDH7DmJjDCVTpE/3cdE
 SgWzz9eyu+zu+ZI9Lk/j/5OBNvdOsnpJ3o+zHgPoh5zClHQP5Cv8DyzO1Wl0sfZ/o+rm
 562w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtmNsPZR+rRFo3mzCvHMp0ZS4mBF7GQ26vaSYPf9hBqrOO/z2H0rFjMvh9rgL3tLdeiwj1rkUgKnK3@nongnu.org
X-Gm-Message-State: AOJu0Yw1jsrTIHDa04lXeL3RGHmhCiJIUGUQ6LuXlyHglOjFHzzFZvW1
 1ZlWpcQ6Lyb2V1q8cWslUmMpIpOp7FD2vhJfkVH4w+BzF7WRaU9jA79PdJaFvwM=
X-Gm-Gg: ASbGncuDrLv2nENGeUR0nk4aYLy9SEqKs+F/jatuDFWfGEuOl/l8t+a25Qb74l/bCgY
 vNsVWYw5YbQZ8LLmUc4FY3DtnpwDkavm6SGT6VgCiA3hELC3QWTc6VU66HV13v4xRmWhrE4hf0O
 aOu80sQGjab8xN2PMzUpc8nq3xUIEdxr5MNhrEHMhv0gMCjh/muHyPAXwvjLR36DKS17U2/6fla
 49LILs2zkzILA/0sUIiWulK7HHaeGIOT5rD7G8Oa3+E+VQxNlZCP19dCi6a/XBilocEPG/aOlau
 h3WECmlYMoFgMKciW2OKu74bauYcRV3VZD6/FXf4HwXJ3/0=
X-Google-Smtp-Source: AGHT+IEP4DwQ/u514V5B38J2P62wTL0qYp8JNncl4+5UB0i/l/G/YI+4UbX8eVL0ayMsA+c7B1DDZA==
X-Received: by 2002:a17:90a:f947:b0:2ee:8cbb:de28 with SMTP id
 98e67ed59e1d1-2f7f176b184mr25848071a91.8.1737921605198; 
 Sun, 26 Jan 2025 12:00:05 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffb1dc56sm6196959a91.49.2025.01.26.12.00.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 12:00:04 -0800 (PST)
Message-ID: <ba781224-7b4a-43f6-af25-acb308f11313@linaro.org>
Date: Sun, 26 Jan 2025 12:00:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/20] cpus: Keep default fields initialization in
 cpu_common_initfn()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, xen-devel@lists.xenproject.org
References: <20250123234415.59850-1-philmd@linaro.org>
 <20250123234415.59850-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250123234415.59850-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 1/23/25 15:43, Philippe Mathieu-Daudé wrote:
> cpu_common_initfn() is our target agnostic initializer,
> while cpu_exec_initfn() is the target specific one.
> 
> The %as and %num_ases fields are not target specific,
> so initialize them in the common helper.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   cpu-target.c         | 3 ---
>   hw/core/cpu-common.c | 2 ++
>   2 files changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

