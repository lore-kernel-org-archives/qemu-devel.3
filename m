Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1DBC83F21
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 13:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubfWg-0005EE-Od; Tue, 15 Jul 2025 09:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubf5q-0002OC-AI
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:49:17 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubf5j-00059p-Af
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:49:08 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6159377569fso230460eaf.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 05:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752583739; x=1753188539; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yK+rSlyLajcga7xCfUnO0wa0INOmG9qahKrkedMiPiQ=;
 b=d+WHjJUpnavwSgb4I4swt1JzL6GG0pu3p+1Flr6KVKgj9KVeTbq6AerFfy2Q4ZG3SZ
 NsE8DQR0dAYpNe7tqAS/GxqkA4cEX2vU+D4sgEFN+BnBJQd5IHOTpeWWPn+QVBDCTZhR
 7CdJnioZxO2t7ZtyLu0k5YUDZrZ2fIxI8sgZIw/56FZjuatqnym8MxFKtTCyh53PC9mr
 eJZ+4B/z9gGgyyWbJKb16IoK2X1WU4caZ5GS5ydgBaCK7wqGiNwV6zwU78P7+s1G6x8J
 dL0MNbotXuHDgFqbsAck8V8vy6GCnZDwlK+yHRB3YCYyUocrTg+hiIwUwJc3g7/DEniQ
 Ivhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752583739; x=1753188539;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yK+rSlyLajcga7xCfUnO0wa0INOmG9qahKrkedMiPiQ=;
 b=c3dP9eh1vOd+P4SjT/5eWli+co+jkLNkUdlP2qVQlrKv5SDB/R0a4Toru74ixf0KJq
 jMhAv52Fc0U0ja8HU6mmTqCuWygyShO0XTLBLeuPp/vhUSVxlqnEp3YRxhAR85UNr58C
 VOUWOLIsqwcQ5gyive3WY6JnK33cucwMIz23SDZJ4ixo6W5JxLqkFzLX9/wQnb9ZZPp6
 juYPiVyeModVw+TYjh+3o2GGokt1WxRDu7BVRoy8nYN58HMXu0PB5goQkQEGOsYfV+FC
 k/hbHyx8KiWKq1TcT3289R0sWsR+14wDagNEH0uRwvXhtRV6beGBgEToSGYzFfzyVEW9
 xB+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmiTQK/uslWRJqD+YcTLMmxHsDhmcU0F4OqbwS+mkG5jhMzLzpd9QNvKvyJPDqp3x0pAaByPQXyu4D@nongnu.org
X-Gm-Message-State: AOJu0Yw0xwWwkTK3Md75YqKKHAbDeAApRDbnEMEIbzM9KKe3sXnJtYwY
 z98jGXYMtVI3RD/CCTwFtLHjQ8q/GC6ANaXksT/ejAKlPvmujXhfI0xjeOXNrldSc8g=
X-Gm-Gg: ASbGncs/6SYDN1acKUvIX0Eh11pxYZicgpA5w82vzQLCuHwcQlfBpUcDEWvoYijWFwe
 MgFbrPlEJ8nc94BKIO19SzNrJ3pTvv1QicfkAEUE/BJ21WxFN5iBBVANLTRdfJQVV4KcvQpq53W
 iXKDdIJDRoAx82HomyuAn5nWwpcW5FwrRFHZHVwXXa0Q9ycI/xrvf2Z4Aq0sPLI6q5UgfgalqPW
 2WIaRSwHZIDdrKBlAHMgI4xDxKRPiib9pDWb7u4hbWJL1zMmSB0ZzmHYU6B2fN1m/xyHdRmmClw
 vEbL1vL1ACgfjuhTswEYruPKJhy9EzfUWl7oyJIipc/OCh9V2Xc5P1oEhvJT9+dPlprG9fSrRvW
 0gRTw0nWdD+JqboJjzG6I8goTXTr8E4i4yqDqP3MEEi/Db/02cuwmvxTd94inaV5liAshQ7pB/O
 AY
X-Google-Smtp-Source: AGHT+IGxZbsK+Tmmd8msNKm5D9ZJPGrW/GsSi+3ZDp3Zo0M5ze9EOaXXQ37NXzbqRAFn2TactQQGAw==
X-Received: by 2002:a05:6808:bc3:b0:40b:4957:23d3 with SMTP id
 5614622812f47-4150f4bfe56mr13024574b6e.20.1752583738841; 
 Tue, 15 Jul 2025 05:48:58 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4141c58febcsm1972663b6e.41.2025.07.15.05.48.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 05:48:58 -0700 (PDT)
Message-ID: <c741d3b1-6a6a-4702-a33b-2d5c7c2e3598@linaro.org>
Date: Tue, 15 Jul 2025 06:48:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v5 6/7] accel/tcg: Implement get_[vcpu]_stats()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>
References: <20250715104015.72663-1-philmd@linaro.org>
 <20250715104015.72663-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250715104015.72663-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 7/15/25 04:40, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-all.c | 6 ++++++
>   1 file changed, 6 insertions(+)

Oh, this is what causes tcg-stats to be used by user-only binaries, is it?

> 
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index eaeb465dfd5..fc3f28e3532 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -236,6 +236,11 @@ static int tcg_gdbstub_supported_sstep_flags(AccelState *as)
>       }
>   }
>   
> +static void tcg_get_stats(AccelState *as, GString *buf)
> +{
> +    tcg_dump_stats(as, buf);
> +}

Is this shim preparatory for something else?
Otherwise...

> +
>   static void tcg_accel_class_init(ObjectClass *oc, const void *data)
>   {
>       AccelClass *ac = ACCEL_CLASS(oc);
> @@ -243,6 +248,7 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
>       ac->init_machine = tcg_init_machine;
>       ac->cpu_common_realize = tcg_exec_realizefn;
>       ac->cpu_common_unrealize = tcg_exec_unrealizefn;
> +    ac->get_stats = tcg_get_stats;

... assign tcg_dump_stats directly?


r~

>       ac->allowed = &tcg_allowed;
>       ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
>   


