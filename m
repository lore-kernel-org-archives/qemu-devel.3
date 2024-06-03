Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D429BC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5uY-0000b7-VH; Mon, 03 Jun 2024 07:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE5uU-0000aO-Cf
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:31:31 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE5uI-0001eK-Gx
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:31:30 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-35dceef429bso1715536f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 04:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717414271; x=1718019071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0pvRBBopizJ2gZQMqrLi9V1FIUD9kVaeww68E6Xk1IQ=;
 b=z8HFvBeJAHyg34Kdnq+9YNiJ0jASZiChJFhBI4XOCBvbL/phDNPluHaDUa1KrTlCyP
 pzVW6cccz69pSlJJ8mZ75K8XfEwuYtZBYJIm4Q+ySzkEkzaMFgBNLJMm8Ptf8L56UGBR
 ++JmTtaLNXbCqSzPTzFw5TJay8yEYWlzjoFsf7ILr0Ak069rm1x76xEFRR+DlSQsBZYw
 Uty5MXnVgGKdAv5As0VqLvwIOI+JsL4ApPFKtW7sGTVFZa30L7MmWEsvSWwOu+8FaoUj
 /ZMatJlDHb0d2UInfHW+QzcPezVFihCVxUyMLTqAChDl9XqVbm4ip22PSfUqLx+IBsEA
 bSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717414271; x=1718019071;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0pvRBBopizJ2gZQMqrLi9V1FIUD9kVaeww68E6Xk1IQ=;
 b=UQyYCTjLIF6uW4QLjcuA9MjiyIizwMO1MhwXOzfDJf/aolK390D6g8HdJbbsbfZHgm
 GQALXxy0E5bDpUVlSLLk7sCRQ/qLjzN01D6vhYskFG6Ma8AOLtPFBMb3S+hl9kOljVe0
 TgGeR+OGlzqAVfyeUHUYTbevdPxQNwG3QPhr8+aJrrOQFNeUlxZYVqZGGPsyOwXBu5Sq
 sh8QT15PZVOs4UCVqV9DYUrNsaOTacX6Cjlr1n5N26LA2udhm5TAoTByHnA9y2S7YRhS
 /exJ4zBp0b0v1VthdysWYBG6FwFdKLdzJ22l/qICjbNHQmoxGG1IzpEqMcalfXDVZ9L+
 /58w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjxNuzdE+v/CO77pqkd1P8PzQQZ+GS1/DrSVF894kX2FQPbA31+tg41LEBzvERIvU5ZW9GZFpMpGm0vECD4A7xrLH7DYo=
X-Gm-Message-State: AOJu0YzqbX5kuBL9+gf1CP0E7TWJEkQ5B9y0FYPVGSO79ThlmJdHK1XZ
 fnknMtla3pL1M6CUyohk4wXXyF6mC8NCqZBAsdn3K8JzkBeht0bU0DR5+DBjQAI=
X-Google-Smtp-Source: AGHT+IGmbF1h1ABbM07Oz/RX9bF3huYnvm5OdOEotdKdo4Ru8QxilyaCfoi00DaQ92UwDxx/7770Hw==
X-Received: by 2002:a05:6000:e43:b0:357:16f6:71dc with SMTP id
 ffacd0b85a97d-35dc7e3e560mr10103735f8f.13.1717414270789; 
 Mon, 03 Jun 2024 04:31:10 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42134f12e72sm82821425e9.34.2024.06.03.04.31.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 04:31:09 -0700 (PDT)
Message-ID: <0a76250f-db5b-4c94-941a-cbec1f2e1db6@linaro.org>
Date: Mon, 3 Jun 2024 13:31:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] plugins: remove special casing for cpu->realized
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Reinoud Zandijk
 <reinoud@netbsd.org>, kvm@vger.kernel.org,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20240530194250.1801701-1-alex.bennee@linaro.org>
 <20240530194250.1801701-5-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240530194250.1801701-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 30/5/24 21:42, Alex Bennée wrote:
> Now the condition variable is initialised early on we don't need to go
> through hoops to avoid calling async_run_on_cpu.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   plugins/core.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/plugins/core.c b/plugins/core.c
> index 0726bc7f25..badede28cf 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -65,11 +65,7 @@ static void plugin_cpu_update__locked(gpointer k, gpointer v, gpointer udata)
>       CPUState *cpu = container_of(k, CPUState, cpu_index);
>       run_on_cpu_data mask = RUN_ON_CPU_HOST_ULONG(*plugin.mask);
>   
> -    if (DEVICE(cpu)->realized) {

We could assert() this to protect future refactors.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> -        async_run_on_cpu(cpu, plugin_cpu_update__async, mask);
> -    } else {
> -        plugin_cpu_update__async(cpu, mask);
> -    }
> +    async_run_on_cpu(cpu, plugin_cpu_update__async, mask);
>   }
>   
>   void plugin_unregister_cb__locked(struct qemu_plugin_ctx *ctx,


