Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04414C3DA4D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 14:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSHFx-0003SC-OG; Fri, 12 Jul 2024 10:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSHFv-0003KL-J6
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:28:15 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSHFt-0006on-Ue
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 10:28:15 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52ea33671ffso2140704e87.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 07:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720794491; x=1721399291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uptgfBZcZWMJEpLHJsJs8o8WU95f1Z6i8DsAB0xKZ38=;
 b=TpaRGWYRra5lBdZbiR9Su/Gcd1fmoMRQnKhrNOuysia5CavAGlPYHI1yxVG54532r2
 RcVMc1JFJQ4rb0MLETdjh+zKOeU9DAMA2SnKLIU64WUbgP4veeD6QoCxqusxAXk6495T
 /nMMJ3FbWYXSn65s4fXXtUj+b75Vb02BUqkSJtpffTcQLSipFKOvXfti2YroNULCanDt
 UeNK7DEOAKoUafySQwtMqL32F/Dj9EBU3XWw1S8azYvHMkA2I+jHQfLYuNnRUZ5Aatdo
 tLzITQm/1c8uS4lB9RwVcRoZWC5v7jUgzWZGgBB5fDTwTF2hUVkMOEBHZAIOdHvp8ug5
 lnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720794491; x=1721399291;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uptgfBZcZWMJEpLHJsJs8o8WU95f1Z6i8DsAB0xKZ38=;
 b=C3obS5SIX/KlKZbDIes0Ni6OG2zQ7b+q2HYwMBBNXr5kM/fquo2mgT6mrbOnnNInNT
 PK7njvqVDH43FL9GEPahfoRwdVMaGZSuJBH+MDmRuW3Ib3iROXujfiDVQdAOKtiv1EvR
 +nQmOVsrDtljF71VmaX27gVG7o2ivGoeR/ImD1+jdKjVf/eR2UP4Y/9mQIouLNNCDdbC
 DS8l9HSXh5ufvcfSnCiPn12JmCs9Y+/7/ba/EZWYn11/BgidBwyFoqrZRrSQN3H/5Jgl
 CxZA5rh/PTlStDxZr+Q8FTOdPKV0BWVrEEYzunlqETSavAEnRrctRn92ATd49WC7ktwV
 nvug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwD9cnsPkAmmi6APbwMmHwqoLiKSEdH5VL4pA5tA0RjTUb11sbADgn8zeiDbIaOK38q+VFpHltoZIyH6Lugsz+sZAHHKM=
X-Gm-Message-State: AOJu0YyDH5QxgTaBOra9Fd9nBJiduyqLQTUl7NS/CdOCbfI0ItLgahEb
 91aoyZI6LMka7L6753jy4pC7ozVF+aEfn9lRcQJzRlt1LLEotsuQjB8dJNsQ/go=
X-Google-Smtp-Source: AGHT+IHomasCssWIgh8LTQwWkrI0fkC17hYb/xC034CERzKFtm4oUET9r0SwdmQ4KqCcNnaDQwsg3Q==
X-Received: by 2002:a05:6512:3ba4:b0:52e:9f17:8418 with SMTP id
 2adb3069b0e04-52eb9991963mr9232440e87.12.1720794491402; 
 Fri, 12 Jul 2024 07:28:11 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-152.dsl.sta.abo.bbox.fr.
 [176.184.54.152]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde7e17csm10437094f8f.7.2024.07.12.07.28.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jul 2024 07:28:10 -0700 (PDT)
Message-ID: <0b368705-7848-4b9a-88c2-986a8809c0ff@linaro.org>
Date: Fri, 12 Jul 2024 16:28:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Make cpu_exec_interrupt hook mandatory
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
References: <20240712113949.4146855-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240712113949.4146855-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

On 12/7/24 13:39, Peter Maydell wrote:
> The TCGCPUOps::cpu_exec_interrupt hook is currently not mandatory; if
> it is left NULL then we treat it as if it had returned false. However
> since pretty much every architecture needs to handle interrupts,
> almost every target we have provides the hook. The one exception is
> Tricore, which doesn't currently implement the architectural
> interrupt handling.
> 
> Add a "do nothing" implementation of cpu_exec_hook for Tricore,
> assert on startup that the CPU does provide the hook, and remove
> the runtime NULL check before calling it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   accel/tcg/cpu-exec.c | 4 ++--
>   target/tricore/cpu.c | 6 ++++++
>   2 files changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


