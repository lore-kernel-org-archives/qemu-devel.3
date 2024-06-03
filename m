Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A7FC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 14:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE8Oq-0004V4-Sb; Mon, 03 Jun 2024 10:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE8On-0004U4-Uu
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:10:58 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE8Ol-0000h0-CG
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:10:57 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52b962c4bb6so2249115e87.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 07:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717423851; x=1718028651; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C9wFY8wAGo7wIkGTxwt2dSj/9aPkgjqVMzXQSzjbvFM=;
 b=PWhZBnGeM+oiRVVFCWa1Fd18K4ZVzQ1wvuBhWhEaDDvZk0OkIX9Y09dhEMpA/AI3Co
 ytCoGcKQdyJENbnlvyhfQ4GZSTk7w5cD26iXwhsL0HikDtYtKG8jZgU+Rp0qzpCheHSS
 HeGHjJSP6ZTwnqO8alTIeUaWm34+zSMWCA0lWRxXlQ+9C2FpSNM9IT8qQUapjdBtM3kM
 yxISVWvGNyc8K19e9P0jtrqW8yuBzjJ9wA5edImcOfwKMR0uLRfTyzUmhI9qaMo3rgNv
 zr65NsiNYPMlXyR+0Ur9jSP11MP80irwnVu+kKZukxpK45G49aEnxiuJwZ7sP/76kmKr
 C2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717423851; x=1718028651;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C9wFY8wAGo7wIkGTxwt2dSj/9aPkgjqVMzXQSzjbvFM=;
 b=wX2emdXBYllthN1ebPxhBB9ptY3e/ECevw8EczBBEnTzZgiA7z3eAsYPtkFULeoOzi
 cFMm8ybF3CQuCsE8K7OqyVKYRc2J1EMvwuhGhG+x+N3MqoARZ/09qP0yQuIt+N1zFt6R
 ADpa+PPxeu8gmBbJ7XDxJQMGEBezt4FQ+2E1fNvHSgy9a1DtgrxLlESibkFIvbI+9cpq
 SBSBkwWHnSxSilOCOjCGKIPSTpj2PVPz6GDM1Xgyg13IusumqZ6DFsKn3axuOVw5tm2n
 m7dMlkR3+36gzJ9jIUklKpcFmKE+mbSZnaAd47CFscy4cZMaxepHvKEEYAA9HoeVMgER
 zH3w==
X-Gm-Message-State: AOJu0YyGqCntpku4oFV62KJY42OUKCueDd512i5eBuR8NAzkRNPLlWds
 M9ZlpgPLgKHfPQIuGazIIozNox/RZ1z2xHfwWF1KKxPYYdGHywUkw32ol1tG05Q=
X-Google-Smtp-Source: AGHT+IG6FLaHU1FmWa9jBBItRKFhE4J9xvwY+NVSV0OPx0aVujX+O++BJxFCuH/n71GMMXd6PGtISw==
X-Received: by 2002:a19:f603:0:b0:52a:e7c7:4ce6 with SMTP id
 2adb3069b0e04-52b895633dbmr7294067e87.39.1717423851458; 
 Mon, 03 Jun 2024 07:10:51 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a690b2703d9sm163919966b.150.2024.06.03.07.10.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 07:10:50 -0700 (PDT)
Message-ID: <3b4d3646-ea0e-46c3-b7e4-7efb22d53d3e@linaro.org>
Date: Mon, 3 Jun 2024 16:10:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] core/cpu-common: initialise plugin state before
 thread creation
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
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
 <20240530194250.1801701-6-alex.bennee@linaro.org>
 <1c950cd6-9ee0-4b40-b9d6-3cc422046d65@linaro.org>
 <87a5k6cqps.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87a5k6cqps.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

On 31/5/24 10:47, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> On 30/5/24 21:42, Alex Bennée wrote:
>>> Originally I tried to move where vCPU thread initialisation to later
>>> in realize. However pulling that thread (sic) got gnarly really
>>> quickly. It turns out some steps of CPU realization need values that
>>> can only be determined from the running vCPU thread.
>>
>> FYI:
>> https://lore.kernel.org/qemu-devel/20240528145953.65398-6-philmd@linaro.org/
> 
> But this still has it in realize which would still race as the threads
> are started before we call the common realize functions.
> 
>>
>>> However having moved enough out of the thread creation we can now
>>> queue work before the thread starts (at least for TCG guests) and
>>> avoid the race between vcpu_init and other vcpu states a plugin might
>>> subscribe to.
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>    hw/core/cpu-common.c | 20 ++++++++++++--------
>>>    1 file changed, 12 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


