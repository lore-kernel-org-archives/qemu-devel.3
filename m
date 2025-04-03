Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494F8C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0M56-0004Ut-8V; Thu, 03 Apr 2025 11:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0M4w-0004Ti-Dz
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:02:03 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0M4u-0005gC-Lk
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:02:02 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-739be717eddso826058b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743692519; x=1744297319; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GLqmtjJoaHhsZ4jNgAepZtxQ4kkdDDoWQ9NcxzjffzM=;
 b=hKCAxhvD648wduwkMhNWR/Uv3y8GzN6cvWdipniOBff6gdIR9ajE+XKR++JxlqHS+I
 ftp6TytULGqmLI3xVHEDWJ43wqdI66Hjoh+zzmx0+Hm+jD2es1y5HVqX5yH3SaSmJZGe
 NKHHhDUDBarSA+/l3xmcuBZkeuz1GT9VSkA6zSMmCtUsbWIA+InOCn6vSRVMl0Ip7rtq
 Xc198rtzrchfVznfq8+DrXXxzxRDL6N2EjpmzTQCJWrEAmsv0vv84X8C6CTT2cvurwVf
 lJUuKxaDYdMNIZy3I03ioRd/UKMUAK/SrNEnfSRGUp4ZSj8/e/ixamLjpf/9IBusioW+
 gevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743692519; x=1744297319;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GLqmtjJoaHhsZ4jNgAepZtxQ4kkdDDoWQ9NcxzjffzM=;
 b=k/cLx3+wtD2Ddnfgq/DvuFPsglOSyW5Q8L29U05S6pZtuCHAOKgjfAaR0eKeBSkBN/
 uRAMtJd4QCp6BDQjRY0tKZOo1pkECmJ0Kywv8EDkDOos3LfYkbPclTjsPqh+5nWoyESm
 6vPYRJiQWqVPkizP6FQa2gsOvJYkx2rsBVpsoekNqeVWr9R2ISw4JA2m3HS39ktRmowx
 S79Hx2tZSXd+gwmowAKaVWzFhabcquColupdQiltcSqfJYkmLVkayMA1iph5TKcfvk69
 AG1zfhj97Q4+/BekayiAS2syAP7eUUeh2T1PJcaSgN7lgZv+Vi6mp2EOtqiLit8OomXP
 EdPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN+zDz+Zpx4iQgPRWl3GDehtafV2eG6XbV6SXjoehB9PRWtwzOH4V6sqsev8ahIHNlMXQUZIF+gShU@nongnu.org
X-Gm-Message-State: AOJu0Yzj11g0Fe8QYzS7FtXJ7ONPLweATmCFEeVWjJ4GQd0NXRcZ/zCO
 xtr7OA6a5Kucm/t6emM6E6SjEdBccXVvuGNQBOCpthXv6iVwtnXLKsxf1vOEN6wYzAkGqQhM3Iv
 e
X-Gm-Gg: ASbGncupnZZcNIoKRUU8qyhEuzckkQ917ab5aoBYWQddl7sWLnE803FV/wL8Z/QXC9e
 GgLtYv/kr3x4Duk9QtIAu05z4Id+oXV4qFLDuwOOxTOKyV7vDZKWJJc1VegkZMfWqWKU3LeIzjk
 pylUFNNJvF8rQyBasx5p2Tf/Cs5bAGnVgaD+XQ6cbNujQsIZF1sAkz21id75IgsIKauo8EDk72C
 jfZdfga0HCKL+1tBKlmBa41sIbsmAAPDbCybjSyNn52mVDElnIZDUkTadJ+m3xW0OjnfUp37yhY
 rX7657xwvCZNmd+3jqPh3np6miHq/1xOVv6TYPWBvTVSk2GCJmKIxBu9b0/IvJX42ECPQMBeqzo
 WWeMtnOFq
X-Google-Smtp-Source: AGHT+IE/DqZWxsDEgZxnl9zye6qto7ZzprgAvA6AnI0DLXvE1hhjy8nD6KHXuw2jh1XTNjUDqMrNfA==
X-Received: by 2002:a05:6a20:9c88:b0:1f3:345e:4054 with SMTP id
 adf61e73a8af0-200e4c1be0dmr9625272637.14.1743692518750; 
 Thu, 03 Apr 2025 08:01:58 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af9bc31c3d6sm1305424a12.25.2025.04.03.08.01.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 08:01:58 -0700 (PDT)
Message-ID: <648132eb-30a9-41e8-90c9-8b1317e79499@linaro.org>
Date: Thu, 3 Apr 2025 08:01:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 39/43] tcg: Move qemu_tcg_mttcg_enabled() to
 'system/tcg.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250402212319.58349-1-philmd@linaro.org>
 <20250402212319.58349-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250402212319.58349-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 4/2/25 14:23, Philippe Mathieu-Daudé wrote:
> qemu_tcg_mttcg_enabled() is specific to 1/ TCG and
> 2/ system emulation. Move the prototype declaration
> to "system/tcg.h", reducing 'mttcg_enabled' variable
> scope.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/hw/core/cpu.h      |  9 ---------
>   include/system/tcg.h       |  8 ++++++++
>   accel/tcg/tcg-all.c        | 16 ++++++++++++++--
>   target/riscv/tcg/tcg-cpu.c |  1 +
>   tcg/region.c               |  4 +++-
>   5 files changed, 26 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

